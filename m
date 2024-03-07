Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D176C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 22:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C65A87DB3;
	Thu,  7 Mar 2024 23:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uhNHUEHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C1887D91; Thu,  7 Mar 2024 23:55:08 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDCF87B82
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-609f4d8551eso9055137b3.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709852102; x=1710456902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkl1uZn7JZishEH62SJ9aWpOHu75KX0hROz12UbIT4k=;
 b=uhNHUEHNmzBHE+D08GKIbg97IIn340bGnd8R70DpsAjepK5odWM+hoSO3FkIjaNT/P
 F2sTjIw5c97eQ9Rxy5BAbGF3Xfy3dS/PMwNYyk/3cHIj/kxauxIL5I1hXiRqwHisZrG/
 qJmebZRFWaqOrGWqSTxRSpzD8fpP5QtxVFWMfQS8cyfgOan9G5zdTdUIIgYjjQihdFqL
 Owt7YzBbm1MBHljEhVqzRd4zlrBuhHPHqBPHT6GWItHi8nZ7EhDBKpbzL/sLiugG7GPg
 vGJ/+cdkzMw+WHdS6TYkBjXYsU6iBHJiYmd56yPTxmHFcoVDWNBQhMeHrm6NOhQ1Hhfu
 YxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709852102; x=1710456902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkl1uZn7JZishEH62SJ9aWpOHu75KX0hROz12UbIT4k=;
 b=q8E2CJPfdcH1MZiteu0eF8kQtnDGkdD4l6Kluu60Nrh6y/iq2ONEgGEjgaC8qzYhvg
 +HCxjXrLneU1z6OpdOzjoVpIvrlME3j9XTG3Y4NzoxiiPgeebyNeO44yR0deMxZsOFbw
 fdEeQlMAhIERNNysqtqoOifE5QmbwKFxQpQ3sIf0vEDsxfwS5weWu5KtHuXJCy/UQbgs
 kzEePf//Pl2pqsHVvHbYNIZrLMcJsl92XTWsZeeeo/KhEEJ04hoq189Mccn/evP9jn9U
 R3NXzW74pPHA95N+XMsOgBbtO6gmltAW/npXqrmut417GGbZ58aVbJs7kS5eY27Imax5
 i5lg==
X-Gm-Message-State: AOJu0Ywd6WcDbbpQz+zd+cZidQjr6ar4YCO+O5MjrtP/WCk7QliOg2EO
 nOQWcGBDwM0hr3Kp4MJeK8kuDZPVGUWmYdjNshbsQKFbWBL4wwWMRKrnjBr3gLvK5snXS9CHBK4
 /zyw1S/LmyrqbYw4pti5cFvrFDcNHgPGIHlNLSw==
X-Google-Smtp-Source: AGHT+IENfvWFqdteN9Wy4CNRo89jLMZfHdgHOAvUdwwZNjFBmM5yD4j3eM0pP+XhnHsxYRYhFqIqnMRYZH0FtFtV/OA=
X-Received: by 2002:a25:1ed5:0:b0:dcd:9a9b:8d7e with SMTP id
 e204-20020a251ed5000000b00dcd9a9b8d7emr2117903ybe.9.1709852102305; Thu, 07
 Mar 2024 14:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-2-colin.mcallister@garmin.com>
In-Reply-To: <20240307221030.3685767-2-colin.mcallister@garmin.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 7 Mar 2024 16:54:51 -0600
Message-ID: <CAPLW+4mBk-4_FsVF27FD+a=W3-wfKrDr4vjjeZ7Y8nT2mnuOwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] android_ab: Add missing semicolon
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org
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

On Thu, Mar 7, 2024 at 4:11=E2=80=AFPM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> Found a missing semicolon in code protected by a #if that will never
> evaluate to true due to a separate issue. Fixing this issue before
> addressing the #if.
>
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  boot/android_ab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c9df6d2b4b..9a3d15ec60 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
>  #if ANDROID_AB_BACKUP_OFFSET
>                 crc32_le =3D ab_control_compute_crc(backup_abc);
>                 if (backup_abc->crc32_le !=3D crc32_le) {
> -                       log_err("ANDROID: Invalid backup CRC-32 ")
> +                       log_err("ANDROID: Invalid backup CRC-32 ");

Good catch! Wonder why there is also a trailing space in the end of
the string. Anyways, I think this patch deserves "Fixes:" tag, would
you mind adding it? Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>                         log_err("expected %.8x, found %.8x),",
>                                 crc32_le, backup_abc->crc32_le);
>  #endif
> --
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.
