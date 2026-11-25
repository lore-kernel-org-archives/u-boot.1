Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05100606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eSnoZfRm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUWq5dVi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7893608B4;
	Wed, 25 Nov 2026 18:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkXVBSCiihV0; Wed, 25 Nov 2026 18:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01FC2608AF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795631790;
	b=Q88TzA1F63CTBkj7P37lmN+trdyPSq/LglvLwQi2GssfTNGDRyi9VxWbxpL1kKlvG6Qc
	 ITRrB3UXtwG8+l2WJtXkksxeLdg8vqL142CxAr6Ol0I0zSdX6DeLgL9+stTte9Er7zizN
	 +HQ1BcQeC27TvXba7BeMGq2C+D/xHXoCKaiu22BtYwn16K2NDLZUsgxKyXrj1TZAm+kVf
	 2oRaAqmBbXL4eSoWfnnyrYAmwxva/DrzYOquWRjsd4gppIp6E2bH66nv3ckhr8RsfcSD2
	 p7Y1+941VkTpmVsxd/NGMbEh1GXFalLhgd876jocTHGea7p7DkiGSuXRCKkztBVO1xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795631790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xPMDpPOQcPuKN/UQFz0nzxUsE4RllbSNQJGAo0+JAVg=;
	b=ZYWKkEEjciEOeAgZsjM/zMVMXzqpD90MaRjkiAoy9JTQ7xriXALF100MeHyQ3H4euQzL
	 OIZXJdmQxHKDqnkiUoRWBjqBwGMH/cw+xbqZhUEno42L+iaI2UvuPk7ReSOErV8uKvf/C
	 wsHrs2PngIxNDWSK91BEPiI1PYATDq1bt1czFxKjm3050C/6IchYQuves5xA22AipTew+
	 ldnZbRmcZK6SRF9lLJBDwecYRDjt98sqF90Nq4Z1YcyoqwB5fqiQa4Vo/Cwen83ulVZOx
	 Qb5YbIDLTrr2Adj8reYCGSqsLXpLeaQjC60TtVDN3Sppgk3YgNDuG2VmPeHFKxFbAnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUWq5dVi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795631790;
	bh=xPMDpPOQcPuKN/UQFz0nzxUsE4RllbSNQJGAo0+JAVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eSnoZfRma+DpSHxqVWdTtPv+RpQo0d634qmzzgMRgYNVXyTnKQ/hg1yNIk7zqrzKw
	 /9Y+rhISoY2qi4sj3uh8xdX4tY+Frzcyra+LOXYFrXwEAkWGNW/LJv0sfDMiu2OZUF
	 WaqhX4jlvKyK3H5kH4J2GdJRiwWTTWdBbRu2JcjTbAprjCWaCIYw+s2q2N9f3vgFbQ
	 6/BB/IIL95ycipclXIoGhhEjFJufKH/8FVnO/FtZgGW25BSVW44xp/pPUC4ZWMGK0c
	 tLpuKohAnojjgjcbpPxEzknluKWKxg0oU+luXpFtqO9/Qx9FLNEe2ZYly4zqD9IoV0
	 7xI9hvnGEVgUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01FC2608AF;
	Wed, 25 Nov 2026 18:36:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2B1526D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C81EF608AF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yf1avrrNLbuq for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1698608AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BUWq5dVi
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1698608AE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:36:26 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5c14f7768acso5001854e87.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795631784; x=1796236584;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xPMDpPOQcPuKN/UQFz0nzxUsE4RllbSNQJGAo0+JAVg=;
 b=BUWq5dVic5N2Lq6c1uCV3xqV6sXcNM6fkH+zHC6+7xBCFZnwlB2hNxwOHcxV1+eI90
 yq8/f6gT/uTVlmOrLxSp/lfA7Ixuptn68lU0g+o57MwirMEU4yyyEiq/A6ZTaPhQO5eN
 UCEiNvZ6LGa4LRWCj+QVCYal2Xt3enwhb17KRXz3I2JxwzOayDSC6CUX0ZHbWwy5nvWO
 sOu/5MiE/fhgO8fa2dc8Q3NEJpbyFVyevz6PmhIkxfWQ41pjAzuYbxUhK2CYWUjx2klp
 FJt3y//PWo5SSxpgvlEHWqCRxPVZiraxyIWrGDIhAdOHeRZr6FuUswDRrijp4ODuCV/S
 WWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631784; x=1796236584;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xPMDpPOQcPuKN/UQFz0nzxUsE4RllbSNQJGAo0+JAVg=;
 b=ix/UFlZkozoNVRrxUJ06N4Tgf9I6jUGMjDX0H3G0obdNlIpUM6imwVSRvMGhXRAcEH
 jcSC2oQYAssY2ntGij//YxbiIRXHyCfMpaKzfMswgi6Quod+eKrTGM/If//OCb7j2KS6
 OT4AnAavzMlwKokFe93CjtpzaTxRSj5BNXSygTfcIhGc6YnkgHYP/K5LiMlTDJpxuwIK
 Np7e1lX98zs1yfe48OLURtHXZ+ga2eBQuogffDjouecfFcgv76QBCVFbvss73g0mR6hM
 sSvHV4hqoAsqnv89HJAnmQ5igjNsJgsG4CRqqCZysNCn/rNb2x5JKSolTBuVLePL96Jp
 BnYg==
X-Gm-Message-State: APuU4Z+kjHD68z3cBB6gl2UpdqapICIozVHdqUOiETK0YsFAvt7vr3N1
 O2T7gmG9QUadn2liNPG9XKy2BcMIsHqKMAzdtuVLNPKj1HY+XuxUbuz82W1/nU0cUKUyzE58Bie
 L1NfpnSSy8s4rihgR6H4wHP0EaE3tvU0=
X-Gm-Gg: AZFdTZcsExSu0OV3/C/BUIB0zu00n6Ng4tlywsfTg6lpjhS4oY+8ZdzFHOb8np53F7D
 TYoMJ3ilJXIFk0VwhZD94z8wIis2GeLdfMxKzKgvEj0e88mwO2V+mUTihLeqvcE72Wb0sAADw7S
 QjEacihERyzevvJ6D2GUhy/RvoLsJ/EuB4LTjacxXOcLJfytyEqCk+1mNHjso4YcAt6Z5wshEGP
 fu112UqqUz4Q9ziuvtxu3zsFo9JlBbWgqyDZcejlgpoj2gLkn0S8Sn6DsJ1AuvVo93vryOHhQ6h
 gqPgVnBYJwDgw2sne38ZR4kZXkU1b1WFEeKtC2V9jdqh0gz0ajCUc3oWNRcWcS74RH2SyVUWhPa
 GZ1Cb7cZBVvIQYv4xl2nKSN0LK72qddm5Ix8IUREffxWMH17OcbTL4IFDCKWh2lA4opLg/Fh3sS
 wZnrDBFKzr2YuYc8cbLobBwzyoVw==
X-Received: by 2002:a05:6512:1396:b0:5c1:ac33:59cd with SMTP id
 2adb3069b0e04-5c1bc680093mr6127368e87.8.1795631784100; Wed, 25 Nov 2026
 10:36:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
 <20261114-91qsb-v1-3-046293559467@nxp.com>
In-Reply-To: <20261114-91qsb-v1-3-046293559467@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Nov 2026 15:36:12 -0300
X-Gm-Features: Aa3M54oZbAWFSXtpOD885RRyNspF0D-ns-q_L885004vHcDaq0x8dIwA6Ltp3GM
Message-ID: <CAOMZO5AYRDRFueL7_Wa=c5sWiNHTjoVttP_dbNcD2T_xbP36xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] board: imx91_qsb: add i.MX91 9x9 QSB support
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>,
 Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alice,

On Sat, Nov 14, 2026 at 1:36=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
> --- /dev/null
> +++ b/doc/board/nxp/imx91_9x9_qsb.rst
> @@ -0,0 +1,69 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx91_9x9_qsb
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please make the underlined title line (=3D=3D=3D=3D)  match the title lengt=
h.
This applies globally.

> +Set Boot switch to SD boot
> diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
> index 8f7c8d64804..049ad90b483 100644
> --- a/doc/board/nxp/index.rst
> +++ b/doc/board/nxp/index.rst
> @@ -13,6 +13,7 @@ NXP Semiconductors
>     imx8mq_evk
>     imx8qxp_mek
>     imx8ulp_evk
> +   imx91_9x9_qsb
>     imx91_11x11_evk
>     imx91_11x11_frdm
>     imx93_9x9_qsb
> diff --git a/include/configs/imx91_qsb.h b/include/configs/imx91_qsb.h
> new file mode 100644
> index 00000000000..40d30923a50
> --- /dev/null
> +++ b/include/configs/imx91_qsb.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __IMX91_QSB_H
> +#define __IMX91_QSB_H
> +
> +#include <linux/sizes.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE     \
> +       (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)

Is the CFG_SYS_UBOOT_BASE definition needed?

> +/* Link Definitions */

Remove this comment.

> +#define CFG_SYS_INIT_RAM_ADDR        0x80000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x80000000
> +#define PHYS_SDRAM                      0x80000000
> +#define PHYS_SDRAM_SIZE                        0x40000000 /* 1GB DDR */

No need for the 1GB comment. You can even use:

#define PHYS_SDRAM_SIZE                        SZ_1G
