Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35721C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BE58839C;
	Fri, 21 Jun 2024 01:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hte72YAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6A888405; Fri, 21 Jun 2024 01:05:39 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059FE87DB0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79bc769b014so80693185a.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924736; x=1719529536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NsZx3/DEoJrgAyFpV8faApwGoMlMP1NdPgGUa5kmqrk=;
 b=hte72YAhGA98dt5u1XoIs5wmvfLVmKC90TcV/s7DpLMmjXn4IEdDK7dXIAHr0MfURC
 VP8YFtVb7VJbGdJ6uMfHoe/+shpXkZ+4vlicTQtNApu8WUDj1R7rVXHB93i2eqPHg2Gc
 4UmCzc674u+iZXs2jGCTXPyIhstsYtx40MJNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924736; x=1719529536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsZx3/DEoJrgAyFpV8faApwGoMlMP1NdPgGUa5kmqrk=;
 b=vrfesDCJ3Cu1Wed7eN7TRqFDa7VjqCFB3dSBO7Pi/lhCQXaMVRj+OlaCtxcQYkRg0K
 NWzlbqbBFQMalOnU1x2TRJmb3w556+cHCGaEmLQ/91+eW7HvQKOvXWNeLzDcP3OJYcoj
 932sEO+ZpO32c9B7t3KIS2V7TuZwqlygWZ/4GGzslJybox0zD1KmhAHhHLkCA1v3tuiB
 sjIDEImTkPRBUZsIAI2nouUwly5GPmHyJ5OzFYoJA+wpslkZ8bqgVmgfqwLArI8tD/dV
 qF7KcuilujH/J2F5jTWKseF8v0o/Rq4NOQ8IH4RnjDPVdt3A3gNwXn0ScWdpq6lXhcwA
 ZwoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5G+l7La/JQ6Orec2BZr6UCgkq3MlBX9NmOh7XAZt39kzZxGkGxXCzjOliBawqGo5YY9KxZ0ZfnL62GDFKQZ7OVXxvGQ==
X-Gm-Message-State: AOJu0YyNre55gcnufMU4vxIsHuhyg0JSuBbRDsbE80XmFZCnIHdryNu1
 prksVDhAfnJWKgT10AawLRXCfnCzCmoJgQaDasV+7YSQa3TtXPcVBX2eW4rpev6IfgUGU84/m4o
 DIss5LEenhaLCrLgf+1zr97KBh9Um0hroTqgW
X-Google-Smtp-Source: AGHT+IEMsLJwl0C5NHCsTvPYFN0u61tT+QsL+frLI3O9dtOv/orJYgJsw5cClKatrPGm6Wqyq9cgWD/dG5jJD5A+9Hg=
X-Received: by 2002:a0c:df0c:0:b0:6b5:34c:a66 with SMTP id
 6a1803df08f44-6b5034c0d09mr129085906d6.17.1718924735720; 
 Thu, 20 Jun 2024 16:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240619-fdtgrep-some-ram-spl-remove-v1-1-7d4a3df7f280@cherry.de>
In-Reply-To: <20240619-fdtgrep-some-ram-spl-remove-v1-1-7d4a3df7f280@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Jun 2024 17:05:24 -0600
Message-ID: <CAFLszTiFzLvinYrDMFzQ70xH4=GCwy+9WEGjha6K_Wu7Pj+tAg@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: remove bootph-some-ram property
 from VPL/TPL/SPL
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 19 Jun 2024 at 05:33, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The property isn't useful in VPL/SPL/TPL as it is only for U-Boot proper
> pre-reloc, which has its own DTB.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
