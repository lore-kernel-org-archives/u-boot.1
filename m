Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7200C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 04:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72258840F;
	Sat, 11 May 2024 06:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SplbTmaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC97E884EC; Sat, 11 May 2024 06:20:50 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B53AD87D1D
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 06:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7f1d60dee9aso896485241.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715401247; x=1716006047; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hm9k79b5k0YjiSAcxCrHPlERHOJvuRj67gc6R25br8s=;
 b=SplbTmaPxwg1bci3vqhveZgBlCwDbrRMDYekLeYmjh4FnoY0I6IcxToNDyPLH8qPpb
 SevkAdkBB2ZkKBaPihd5Xkkk7rQQge8zrqMLXWrv2qyU8SNYmngUkWtNoLNQ41jkaIsc
 mY7QX+GZ12bfrIe2bbR+Nwiy010+utDIwFYWkOHOh/BZccVwzC8qxPvVzm8pZXq25+sQ
 qFRtaTVgNImXV5Zg40kKvdMY3pL7ygqacQR7onVecK3PQjSVYYdPaFc3o1DLbxn0fCVv
 a2SMswQUvGLIF/SNzn33vVvT7f+7+K92NQYCiXJScRjk4MFDSeiY5ZkZTEdxmu7/iOpc
 Yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715401247; x=1716006047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hm9k79b5k0YjiSAcxCrHPlERHOJvuRj67gc6R25br8s=;
 b=hv8Tza6E4ZddTTLJsvacxqiX/I+TEJOvkR6GMEHBpZGEMK7Tyh/Px45bT9rPUUYBT0
 BnJu4so5mrtWZKmSL2nSI7l6OY4hcG+Y/32Q3nK6/Zoaq9WHU7uYwYeMlDGLz7/Jjocj
 7wGkaZQQ+UZKxzbYT0H1D6BKXmZzNZYE2j9KdwYlEHjI8wtNO4qTzPr3Jyw2/wkMKNUy
 CO8/c1beIsBFdIkkXt0HHKmqXEyZqKTeWrZxJdTTXrbVSwgej6E1iz9SrN0m1bUfrqT5
 agqcM3ftPnqlKoWMufs9yp72EIqFCLPkiCIdsYqmonicmtCQHwrPgwPrYZWfrfqAx0Na
 GKOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA3vRObcKoMJkWRXRubQkazjQuFH0Y0EhjEVKclw3CYTfMiTFmwEC2xZWcaaWP5AsFnW8JcPn0OWJF7UOzB64Dvubrjg==
X-Gm-Message-State: AOJu0YwUSth4KvLOtZnAw3J+d5MynzyFcPVMq6qStCZ57vKoH+61CSTn
 olRetEzw+t9Zsee4bKAmwf2Lhrwia+AnL1PW0kjmdrGDEfPfxo17Aw+QQO9Dn70+8pAhCj9O0ob
 HNTGCOGsXLhVSqBE32qloFwanG1Q=
X-Google-Smtp-Source: AGHT+IGq581vcSgiDjsK5JOhuS+zDaajmmAILOO2vRqEgcfxMWrIJDiVc6XwI8g5ryCERH6ie9pTrvPOvEki6t0FDgk=
X-Received: by 2002:a05:6102:1526:b0:47f:3557:84f9 with SMTP id
 ada2fe7eead31-48077eb3fddmr5097993137.35.1715401247550; Fri, 10 May 2024
 21:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
 <20240510055223.11617-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240510055223.11617-6-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 10 May 2024 21:20:36 -0700
Message-ID: <CANV2PTN3Kfd7SG_ENw5FqXCuKSEWvNj3_58oR0SyYnL5H0Hpbw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] starfive: add mac vendor sub-command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, Mason Huo <mason.huo@starfivetech.com>,
 u-boot@lists.denx.de
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

On comparing raw bytes from manufacturer data in EEPROM to having done
mac initialize and each of the commands incl. 'mac vendor' to
construct again that data, looks good.

On Thu, May 9, 2024 at 10:52=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> As boards from multiple vendors (Milk-V, StarFive, Pine64) use the mac
> command provide a sub-command to set the vendor string.
>
> Reported-by: E. Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         new patch
> ---
>  .../visionfive2/visionfive2-i2c-eeprom.c      | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/=
starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 9648a270494..141d3db8667 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -404,6 +404,24 @@ static void set_product_id(char *string)
>         update_crc();
>  }
>
> +/**
> + * set_vendor() - set vendor name
> + *
> + * Takes a pointer to a string representing the vendor name, e.g.
> + * "StarFive Technology Co., Ltd.", stores it in the vendor field
> + * of the EEPROM local copy, and updates the CRC of the local copy.
> + */
> +static void set_vendor(char *string)
> +{
> +       memset(pbuf.eeprom.atom1.data.vstr, 0,
> +              sizeof(pbuf.eeprom.atom1.data.vstr));
> +
> +       snprintf(pbuf.eeprom.atom1.data.vstr,
> +                sizeof(pbuf.eeprom.atom1.data.vstr), string);
> +
> +       update_crc();
> +}
> +
>  const char *get_product_id_from_eeprom(void)
>  {
>         if (read_eeprom())
> @@ -463,6 +481,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc,=
 char *const argv[])
>         } else if (!strcmp(cmd, "product_id")) {
>                 set_product_id(argv[2]);
>                 return 0;
> +       } else if (!strcmp(cmd, "vendor")) {
> +               set_vendor(argv[2]);
> +               return 0;
>         }
>
>         return CMD_RET_USAGE;
> @@ -586,7 +607,9 @@ U_BOOT_LONGHELP(mac,
>         "mac bom_revision <A>\n"
>         "    - stores a StarFive BOM revision into the local EEPROM copy\=
n"
>         "mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
> -       "    - stores a StarFive product ID into the local EEPROM copy\n"=
);
> +       "    - stores a StarFive product ID into the local EEPROM copy\n"
> +       "mac vendor <Vendor Name>\n"
> +       "    - set vendor string\n");
>
>  U_BOOT_CMD(
>         mac, 3, 1,  do_mac,
> --
> 2.43.0
>

Tested-by: E Shattow <lucent@gmail.com>
