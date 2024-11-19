Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E711D6C29B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 21:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A507A892FB;
	Tue, 19 Nov 2024 22:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HFT+faaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946A789390; Tue, 19 Nov 2024 22:11:45 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B6488F3C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 22:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so792619566b.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 13:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732050703; x=1732655503; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv6vDiEPqdXSiHD+GGR2sKXCrRLmo9sGDfo2jnLh22A=;
 b=HFT+faafubqMtdU318BEi4ZaYidDgZlaAMHSzhBwSfYxn3KxZCDbXagyhLT5hm1D7Q
 yHjvrjswqv2ONJ0NCcK+c5aexNrsq2IbTERwmWjYwPV7gJqEADY9ObGmqjjrFY6TTv9i
 Dpaqqh7Nrl4ePQ0LNGEuISovWPWyClo9wD8ubMEnYp3NOMfhR1JYOYoZe963xNJCHpPq
 IHxFJsaQ0Mm3l+o4I6lR1QFXTuNHuQc4nV+C8xIauZh0hPHSg9B8iS8i7+7VLrDcDlRm
 Kkrm4waN5A7knQoSsw/fa1mnp5P7kPsfvfX1Mfc1jAW0fdpTIJMc1pRmQbssTqQw75Cd
 UqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732050703; x=1732655503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv6vDiEPqdXSiHD+GGR2sKXCrRLmo9sGDfo2jnLh22A=;
 b=npiFOoM+ojUBiBfGeyEHggdgSk+fGKkvaC7T85gtcCh38KPa+WVcXFgulzqcRARzd3
 P6j64TXKKfXkOxHt1xOZ3V9Y+fINkvELe/P+OdkH80s7/nAHHZg9LOP7PN+AbTNmzNXB
 /1/E1CNFk6XBJjVuOJpWnKGjcNOT9bmHHsj1ApfyCxwPJEoxsdBIz784p5ofJZeVECrc
 piXfqQUhbB8dcIQDpGms/TP8qMXXfQ45az8xT0u0MxekM6lUuEiG/Twi0zeYfwLWa5J/
 KClt6I0dAEp3etOJjZTl6Ycf4Sug4sVjgAfWu2RuFrWXxmgQJN+07h/FftsK8GbzF1NO
 Z08w==
X-Gm-Message-State: AOJu0YwfQoEHjCr6lsVQEKx92yAGm4g0YcRwWSm6DHZ/O7RHtYdcFerH
 DIVUpdGU+/0wteHFUyMLtE6wkMiinccIzz9Ul0krLI2SweKc9y0K2Qwb4WrSehiy5EfXURaynXA
 pVtkDeleDDRnFfWQbttAZVPPndx/y2Bgm
X-Google-Smtp-Source: AGHT+IFSncqOfNEhNoRq3qzF4hBIM96HGzXldLJa5wDNA+Vh0EdmcGPdIszwN42afkskkHbWHinZMaWAvrxWznlWzVQ=
X-Received: by 2002:a17:907:2da3:b0:a99:6036:90a with SMTP id
 a640c23a62f3a-aa4dd55158dmr38553066b.14.1732050702872; Tue, 19 Nov 2024
 13:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20241119172558.438470-1-ben.horgan@arm.com>
In-Reply-To: <20241119172558.438470-1-ben.horgan@arm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Nov 2024 21:11:31 +0000
Message-ID: <CALeDE9PUYktzm+AwTJg0vGJNKCFW22SVMCN6F=0TDUN1jY6G4w@mail.gmail.com>
Subject: Re: [PATCH] board: armltd: Make myself maintainer for total compute
To: ben.horgan@arm.com
Cc: u-boot@lists.denx.de, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 19 Nov 2024 at 21:03, <ben.horgan@arm.com> wrote:
>
> From: Ben Horgan <ben.horgan@arm.com>
>
> The previous maintainer is no longer involved in total compute.
>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/armltd/total_compute/MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/armltd/total_compute/MAINTAINERS b/board/armltd/total_=
compute/MAINTAINERS
> index 3dc1cd188a..92486f4193 100644
> --- a/board/armltd/total_compute/MAINTAINERS
> +++ b/board/armltd/total_compute/MAINTAINERS
> @@ -1,5 +1,5 @@
>  TOTAL_COMPUTE BOARD
> -M:     Usama Arif <usama.arif@arm.com>
> +M:     Ben Horgan <ben.horgan@arm.com>
>  S:     Maintained
>  F:     board/armltd/total_compute/
>  F:     include/configs/total_compute.h
> --
> 2.25.1
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
