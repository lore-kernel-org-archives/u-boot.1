Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C645C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B4C88433;
	Mon, 10 Jun 2024 10:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixOoS3D4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D168843F; Mon, 10 Jun 2024 10:45:31 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CEAE882ED
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52a6f05503aso470442e87.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718009128; x=1718613928; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJdv20lpiSyp5bh7QVWbHpbyT4yUulrMMXrPtHrSuxI=;
 b=ixOoS3D46YIY1jSkNFrDZ+3H9PGnBnB105fy7893AHd53Fw5m0L89rz8z7jdBxvnWb
 6mCw3Zf+YerMxzoiG98DDNxzVPiER5RFQ+4wrAG8TXoDY1i2gcp3Q3yVywbvRifnwGnl
 qPrR4T+KZeBg+SnBum0V3ybyFQzKzSh115hctMINMZj1IneqrDkHBiDCJ8K5ThFFTFRd
 XwidX6aT0MN/S9/dAOfyT438iTZhz9scJnRaO2Si82WccBZgVXnnh7uFdze5LkrCy3SK
 PFZbWJ+n6zUo1AuAz5bkA2VhYiPtZmq40R5J2+bpWooC5rf2LPy1oR1dDQKRlXO5RkcO
 iObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009128; x=1718613928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJdv20lpiSyp5bh7QVWbHpbyT4yUulrMMXrPtHrSuxI=;
 b=L8F08Izp2XrIIdGpZnf+2NLXNrbiEdB67bIcvqyctFzBCXQGOdArLEDlnF7SDnG55X
 qRWZGQrd95MBdBPjBCI2R1zITB6cqMN+s+pDTS+zyyDwKLOzPG+FeTFcZSog+dcNG2VF
 VownfXR8DspAlpjF25s3MoqK5SpdlmAawyTbJomDYQdRgeWtLVtuxGsAPbxCWt1e++5h
 gNjO9/37C6+nPXkN+SaVIZRcsIXoOitdxHDFWAhfRNqA4YurVTZkl10MF3srj6IoLO2U
 oJbhdX8FKjzizz9MULMpmjvnAg+sBDRT/QsMz3xavyWM07zTPc5VIELLkZlxcqj/SbOA
 xcOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyVVoFMTpztGMRACtEf7MZXl+53Y47R1BQ2H3XuXGTFewFZAuhqnO76YT0HocrqDqrzqCJDMhO073r0GKHtT3DpKFjWA==
X-Gm-Message-State: AOJu0YyqW+NUN4ol/3L3GpSH2KujAYpsQMCFGtEAJDIsgqXTXR9167XE
 2M570EuTceC1h2wY4/mWUXiV/CweFplYRpzCKjR1FW7tibDh5dXNROXBdGoiac3lcMrDkM8+bOM
 NA/+X7mhiiO2jP2UDgbmC04KdaVM=
X-Google-Smtp-Source: AGHT+IE7zasUjDCqjbFjhz3/2vRNVeMsAty1k34wYJDRwmM7BG3QPArDUbimCN7jLcYJvdmF8dBgE68lUBHNzhae84s=
X-Received: by 2002:ac2:46ec:0:b0:52b:be95:5b72 with SMTP id
 2adb3069b0e04-52bbe955c21mr4384750e87.1.1718009128130; Mon, 10 Jun 2024
 01:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 10:45:16 +0200
Message-ID: <CAByghJZm6PddZVv85H_jE-Ag9_ONgvEmd0PU=oR58xqpY0CYHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: typo prbing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, Jun 8, 2024 at 6:13=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/prbing/probing/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index 1081d61fcf0..754649f091e 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -113,7 +113,7 @@ config DM_EVENT
>         select EVENT
>         help
>           This enables support for generating events related to driver mo=
del
> -         operations, such as prbing or removing a device. Subsystems can
> +         operations, such as probing or removing a device. Subsystems ca=
n
>           register a 'spy' function that is called when the event occurs.=
 Such
>           subsystems must select this option.
>
> --
> 2.43.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
