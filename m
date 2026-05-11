Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A03CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27F7803C6;
	Mon, 11 May 2026 15:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F+3w0f8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9079A83A41; Mon, 11 May 2026 15:08:06 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AEC800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso8349687a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504884; cv=none;
 d=google.com; s=arc-20240605;
 b=PXhU65mrQO8HlHLwNBHbUksC6oQ474LFIXiS/A7r76NcjjgghnsIH5Mt1Owia1J6Kj
 jbIJTl+ej0yS8KX/cO3AsK0AyTW4ULNPfWnkJix3Ge/W8QSn9FOE0YFYE+PmID5OGsQN
 xaD2fzRw6fysmlnQztbMzmhgOeT3EgplV8hgLGM1e+BtDXA0wcL51928ADAASTRsb6K8
 uCk4AYmfxEFreF8cloHKAZOgsFZqiwtVaJiGg3MA5hgm1RLVrc+uifs0XnT+0kpIxCsE
 KwxXeH2uvt1LrroUUiYa6cec2w5Ll8cJDkSlB1UUXr1siI9mEoWHuHcC3qAlZ0JEHV4d
 E+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VVKOjQI8ikwuEWLcmt2thVTWYcx+R+sQ+b7nlkxeXn0=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=UwfaajpiGbQ/uYKruOlAZG3RjGqN3sdsL3ePvozg4kpT32kc5fWf55iuBEMqcuA72O
 crCjSeji25bEay2KrPozpA/1mLzhgDB6fCTzq+6Wvd/x5J5I6d3ZIp3uO/RYYKLa+C7O
 oFvz3oWDRrE9EKqTFZEJOi6tbmTRj/96FThlipzwbX3S5fXpXhNUn8YfzqP5aoEem21r
 wuTbzmH5Yr02qXsReoyY/93dQo3o9zRRtFgu0FWjgaei5d1WfvvxrjeDVzQF2ghMoPe5
 P6GZ3oNPIkix8fRmfIEU30JvTLK8yoL27ZOgGkQ+wSSnZD5/ERVWqEPO4/VBIA7HSp7I
 l1Ag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504884; x=1779109684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VVKOjQI8ikwuEWLcmt2thVTWYcx+R+sQ+b7nlkxeXn0=;
 b=F+3w0f8mWQOinc1UIxMcddMb9Z94OlQUhUKjF4W/5BkUmpavlzkPDcE93MSI1gibJP
 sfRKggqQYEfg+1dnUhDEOamOjUpdRuonRvUaVSMAj/8/fw0ZRRoRzOQhdSKLi6u6TLv8
 POHLZDZRzOxQMuGBx+Unpx7T8P20HtIk5AaI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504884; x=1779109684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVKOjQI8ikwuEWLcmt2thVTWYcx+R+sQ+b7nlkxeXn0=;
 b=El2NNGFDzWFexL3coJjTFjehfBQqbi2b44DdvQUd03fVOyvc5ochcCdZB9Voh3hvw0
 lr3zsI2HneAYD+Sa/wraBKs+OxWQ9lgTbDytejoalnyAjP83NpFEzAqP2flIIgoCmzTu
 nUsTTbLHt8CxR71ipbIPLEHb0Ov2iSmdxkbliOCmasBAHQ3wMi86bn/mBofG4Y7BINVR
 eaYOockyOfRESPM2ZOQPiDkXvU2CKqKjOdBhWqOCWU7wOnQyoeWgvOHSG0BV6GHnbglo
 QwhK9u6TzEmen99mQUzuGP5fCM9jVolNagPtg3UFtYZfJ5WGLxyPjyPDMh2r/Enzh6M0
 deNg==
X-Gm-Message-State: AOJu0YwxQdpwbnAERyx9WYM5Wg047IsShaQPxOX/c8aEXfVJLv0LmT/m
 Ah6/qWsIbwNmqpvHxNXGzr69C9TXHn78nEd03iyJPhddPQKB5B5I6PwC+cgkmwRtUQjAZNBAlOi
 dkRUsq6VmHKnmEJuREdIBttvl6QNSXMb90U2BfUVs
X-Gm-Gg: Acq92OGRgqxURnOUnOPI7uFCelDWFYqZhF9CEkPGhPXgHV+DOwLYBP3pqFAy+1k2Yao
 sv99E/DzaF8LHbKx3Ste+e/v360MtDuSF+YXoe3oipFyqqxcmzc4u1ne0R0mmKWbE2f+ilokzTE
 kEffby7pkW9reNzT+PuEOmm5WCqEa6QphKwzEx8ZlJp2268Btj2owumC7gcUWzpErv56L6C+gRG
 r2KVHuU3LRM/9b9b0zafjsvT7EOSfLUA3OsdjVnxknnFhOG/3rL5Tuj5ObQ/PaGykFIlwEPCICS
 /t958Kn/8jGvihDK
X-Received: by 2002:a17:907:c81b:b0:bcc:d84b:5663 with SMTP id
 a640c23a62f3a-bccd84b5bc9mr436101266b.33.1778504884027; Mon, 11 May 2026
 06:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:48 -0600
X-Gm-Features: AVHnY4LL7rncZ0Vx2XBufpIMXX9SIlQuk57rfVW5b5VTTWZmKDb0fO0PlTXEAME
Message-ID: <CAFLszTijBbaX-V47psmrJUPLX_ybM1aQtu9NzByCfsh5HhL2_w@mail.gmail.com>
Subject: Re: [PATCH 01/11] video: bridge: anx6345: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: bridge: anx6345: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/bridge/anx6345.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
