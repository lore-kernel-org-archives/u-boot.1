Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A4FF94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E101A83AC5;
	Wed, 22 Apr 2026 03:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XO60loiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A9A83C51; Wed, 22 Apr 2026 03:50:20 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC24183936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-38e7d983f50so54622101fa.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776822617; cv=none;
 d=google.com; s=arc-20240605;
 b=hwTc6Fua/sH3bb05CK11SiEb7y/ziSJA8kdRvzvfvSQdgPk1zDDPOWt+GsDf0obQt8
 OXTc1PMZXUg8N0eHBwnaQJhudXDLS9dMV1C8kiFht552er1VCcp1FjkOWs1UBTY+ZU+O
 6EXfvZbkFjAa+bl/KSDXzNmnrYnIr+Klo0udRLBWwqZP7RceHE/37hhIymplDi0eXFUQ
 iNs2NUbrQY05/UEAm/XfsAjH1zxmKoNhiGvaUXeHM2iaVO8n7QZnbTPuRkryumGgOysh
 lOEd5SEfIDEBqzOo3DmHT+Qqmw9FpIHvRzP5fLYVdIHCVj0r9JUdO1asy7Tk4VR/BwEk
 JIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bdz3bBj0DLW9I3vAq8jwRYdT7jBhl1wFsZJoQAa6wAY=;
 fh=707FTTJlrFytdCmxsftjCkf3+Taq1pL03khHDHMOhkA=;
 b=GjHc32XCPmR22a6Tv2H9XOxwxH6UnR0MaGBYq/O07ppmnRiB+IBWV9a0kSj1XkCZTt
 PrXQAt9FgD5q20J2QXlYzdOnO9xndth1MpPkI6gFWy51PsT2BdFtzJv0CbAGaq1kUHQs
 SBQgxGyKC3EU73yMt/Z5vJi6E+lsZAILUTatg4W9O1bJ6QEQs6rSyET2snHZfCa0f359
 KKMSzITfLv4cq2JKvIl9KdxqLS2/5zn2SP6Dk5OFvCBrwLxZB0GkUcBcLVMxRV6mEfXU
 u2hVCnnFFEPgmts6Vhk0snVBrHLPLRz1ZgFLZd2hK/uLA8YL6Oo3FJU3fkIiq8oAKRiv
 cSIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776822617; x=1777427417; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdz3bBj0DLW9I3vAq8jwRYdT7jBhl1wFsZJoQAa6wAY=;
 b=XO60loiF/JxvfZlYiHgVdiz3MrxUeA4RJtK4V/U9bhQ0PDWqN/wBOgS8castYjwSsS
 6oVfHTuC+4fT2DyCDUY7p2Ca/RF/OxJhH5boJ9twqZyuPPhmCjGaRDxe8uwu2vDNCHc/
 KAaoTRLf4BvjRYydeZ9x3QTO98fLEp5D/+HRZj/BK5BSWNTxgkD7NdcsRMLiKg82ur9v
 gSO1JpGTeIK7KIw6IVmElmQQ370nEVn8cljc1ai0pP7YnH+4Bn8m7NFu9P91zGonPFwE
 uty0mXoBr908+2UTVWiSqnbx9Aj9oDu4oUx3vsDfRS6i+VNOLacFfP/V+DCIVjQYE2fB
 3Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822617; x=1777427417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bdz3bBj0DLW9I3vAq8jwRYdT7jBhl1wFsZJoQAa6wAY=;
 b=qa9WAQrBX8IgP/NeUey8HNMv7coLqgp7rtl7LIkwXPfo3LJQ0q/UkOFbXv1xV8Zuwf
 wqI1dGKzYJkhZqSZDLk/Y/nE/3pViTI8rsrqRVQbvmcuROfbkhIucHS0y76Kjvsq4TkA
 q/mJFBAdvkXGJBK7pMjDcl/n/yl/xGpszyOX+eDh35vq51ZXg8/BmICwMl+yF7HQdjI3
 uFPIl8Ais+iyWUYh5bs4kgzzsaujf+eOOm3+yM2gwTjDeWmYUTj2FrdixNgLYdMvSYUF
 LC4VtIF4JA/m3ThTnv/d92ykNgdkgC5MeCupvb9Ji/UTMQTl4apqoGFKn7kbu/gSyUip
 vyqA==
X-Gm-Message-State: AOJu0YxHur3GSY4KbRHz8noXkaXaj/pyKDYiMmDl+TFstQDNkXu2v5cU
 +DpuoUl/pzCybAR7X/SBhHDFhUO3IfIiaKe8acBw8OtLWpCOv0RB8rL1xJxULOEhl7uPatp9oAX
 O5q300xs8pV+o/Wz+1JyA96IvbF7tNCl84n81
X-Gm-Gg: AeBDieuAciKwB8rWJh6JGQGfNWKHX09VU6n+Lvk6PpPWreNRTmZqlxAECd6q9vxA8Mc
 nDqocM72bSbdM+M3cC2TCVT8bpeNKqu3QCv9ipKd9iWpi2u3X92OQ/9BjeDPPw9MgRBXaatUt9Z
 PBfMJU19F049FQ6bnXow3ukApfKBEnPvWxl2fQ3nM7hKahDxMCreBeg3AxHG+NGO1wUwNURGQRg
 jjM+TqIaEnej8KS7n7BkemOyzL/ft0h5SDFGi4qKZvVGZhiJ0zrwdJ7HcrkBAayssd1//5oxav7
 QiIhskhXnVrD1Bf7WsmA3naC5frQ7iM0/6G91Zfv2kW8Aqpl8VzolE6yoeawPLaQSJm0s/k9/Pb
 PposYNxVSc5DunYutIA==
X-Received: by 2002:a2e:bc26:0:b0:38e:58f1:99f7 with SMTP id
 38308e7fff4ca-38ec7b61afcmr57018631fa.33.1776822616838; Tue, 21 Apr 2026
 18:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260414155928.1391211-1-krzysztof@kd-solutions.pl>
In-Reply-To: <20260414155928.1391211-1-krzysztof@kd-solutions.pl>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Apr 2026 22:50:05 -0300
X-Gm-Features: AQROBzA59BmqV16MA1FJj9cN5hJH4M2hjQ7Xoby5Kb5vpshTSm6KWda_oGmmWJM
Message-ID: <CAOMZO5D7VJrSvjpmKBm2mLuGXTa0J2PUn8Vps-u-S-dpPqwfkg@mail.gmail.com>
Subject: Re: [PATCH] imx93: Add support for OPTEE
To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Cc: u-boot@lists.denx.de, sbabic@nabladev.com, trini@konsulko.com, 
 jeremie.dautheribes@bootlin.com
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

On Tue, Apr 14, 2026 at 12:59=E2=80=AFPM Krzysztof Drobi=C5=84ski
<krzysztof@kd-solutions.pl> wrote:
>
> OPTEE-OS starts correctly when "opteed" is enabled for Secure Payload
> Dispatcher in TF-A (tested on OP-TEE version: 4.9.0), however imx93
> devices require a patch for OPTEE targets because binman does not see
> the tee.bin file when it is available.
>
> Enable conditional OPTEE support for imx93 devices.
>
> Signed-off-by: Krzysztof Drobi=C5=84ski <krzysztof@kd-solutions.pl>
> ---
>  arch/arm/dts/imx93-u-boot.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.d=
tsi
> index dc86746ac90..60648bd10a5 100644
> --- a/arch/arm/dts/imx93-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-u-boot.dtsi
> @@ -69,6 +69,9 @@
>                                 container;
>                                 image0 =3D "a55", "bl31.bin", "0x204E0000=
";
>                                 image1 =3D "a55", "u-boot.bin", "0x802000=
00";
> +#if defined(CONFIG_OPTEE)
> +                               image2 =3D "a55", "tee.bin", "0x96000000"=
;
> +#endif

This patch breaks CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1430279

+binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.u-boot -n
./u-boot-container.cfgout -T imx8image
./imx9image-out.imx-boot.u-boot': 1+0 records in
+1+0 records out
+887808 bytes (888 kB, 867 KiB) copied, 0.00296579 s, 299 MB/s
+1732+1 records in
+1732+1 records out
+887152 bytes (887 kB, 866 KiB) copied, 0.00434548 s, 204 MB/s
+./tee.bin: Can't open: No such file or directory
+make[1]: *** [Makefile:1395: .binman_stamp] Error 1
+make: *** [Makefile:189: __sub-make] Error 2
