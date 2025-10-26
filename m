Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39D0CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38AC83849;
	Sun, 26 Oct 2025 15:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kuKxS3nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 630928384E; Sun, 26 Oct 2025 15:27:40 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F3A82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b6d70df0851so465966366b.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488858; x=1762093658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lso+6OIeF9xzEYBxTpRFc/CeY1NTpBqfvhRkyIlNpjI=;
 b=kuKxS3nZr9IiBleAgCwxCxLeSnZb7vhMwAiBAh4myZrRBV8jFJUIDmDjGSIg/ih68K
 CROCWbhQadTEYdtbI5+8Sru7VLRVX+h0x9njqFrFuODlpcKqNmt0qkeFYy1uO5/JRNuw
 KSOSpSi2NFzoxkQB2sST5+bOeBgArZriTeKRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488858; x=1762093658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lso+6OIeF9xzEYBxTpRFc/CeY1NTpBqfvhRkyIlNpjI=;
 b=E92qhjsnYXMzFNgK79fDIIfHGV4h2HE0N0imWdHgg8FbAkecmR+e4vVLjl8xt71ELf
 EXNYFRdh+NhILKvJGjm6ASWCXLFEngLm6AiSGvnH5bhss9fqoWejTRvHK2kjbJ09GeJU
 ssvB44lgVX2IvC8RwGAZRGGdsxH3tKvwfbiMfveEB9qzvVmEuvI1V0C0sCq3pwWcO/i4
 r1lAw0EI+Ig3v3aW/6VNoLEpNzeA0gP2LMNzg+kn6DKaj7DIjxmviN3H8o6RrKHqjXBy
 Rh8y6kguWpO9FP8iZSGKbqS+IfUgDe6EG4OKXcumjLnr8oeseS9i8um8FAzZUFWC4BJm
 ESMg==
X-Gm-Message-State: AOJu0YyAy158abC3MT77HGQCVkL5C5Oy6jHsGAu5kZDkvWNzvsRjR4A+
 riWb8dErVZFXj6/6ZLX1noFbaAtzQIctVvIj6tDyU37JQk1VnVGGlQamK9nG3dYvt57BhsFOE8y
 VmP6jKa7XHsap5SXozKutxuHx6RfmVcprkhyIpaki
X-Gm-Gg: ASbGncsv+eiHu4ovjqsTnLyF9em0wp773oJv/6ngPaDig9NKEt6cK7TP6VrqFaRap6h
 o4D9BxteglczR84i24TWo/3kq0HkyOZqZRcfxIOzRIsAEalmmQxKugNe9tl+Et9qYEsl6q8vJTI
 6ftAAHUucBDhG1A4aUjGOO6b/ljAMyJfHn09lum1rpkjYE/ZJJQbLPoVnRSrYcIHoUJEdvtpgfb
 kTxKHRz2o/KK52gOV5+YlieIHHyupYggQBXYgPsZLyyInk5W1XQm2rnkWcO9WXt6JvpEoI=
X-Google-Smtp-Source: AGHT+IFP+1GmRthrIE/OREZUJpo0wvp6Le/lTCZm3fwSseuu0dCNV8inO7OTQYQeyLKN5Mkl1Ak9BCE8oX/ckYn5F+8=
X-Received: by 2002:a17:907:3e21:b0:b45:66f6:6a0a with SMTP id
 a640c23a62f3a-b6474940f13mr3949875066b.44.1761488858027; Sun, 26 Oct 2025
 07:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-8-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-8-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:27:05 +0000
X-Gm-Features: AWmQ_bmEx-o_G82nG7lGadEvLY3WyNgs8xW0TQ9p7Mk3ywSZCgvcus6Ytxpp-0s
Message-ID: <CAFLszTjG76KA10Q-97OY5wxQnrEFNngy6pGd8NnnDYipxQnkdA@mail.gmail.com>
Subject: Re: [PATCH 7/9] boot: Fix typo
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Fix a typo in image-fit.c.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>
>  boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
