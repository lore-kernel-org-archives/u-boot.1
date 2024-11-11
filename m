Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF58D2E9F0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2E588F41;
	Mon, 11 Nov 2024 15:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NA1SWweR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C189F892A1; Mon, 11 Nov 2024 15:27:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA6B88AE8
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731335238; x=1731940038; i=xypron.glpk@gmx.de;
 bh=m/26UblB3AvOkWesLxqFE1tFcZlY1Tw6UekLlu5QQdk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NA1SWweR6piSQRdOzpwRqqCq5heIkyMjZ1WoXnmISktRunsvXix8mXKIxpy5x13a
 XgL0+kWy/WCNnSqkyMjpOygfO1xqmXODqWKugq9tS/UEyttU7ilgfyaoN1vHvrqWO
 /xR+ViBLpfjaL20hXfbEaPQGh45kFuul3VmMD3ZQBjbi/E8Z+ldEt9aJ9vzLcR2eI
 c0ssa+kaokUu5hDlpxZOHXqOVn1VtdBMjudehIuRrB2c+Nl/GkY1xiAuBTz10X4Ld
 VOWMheqO+8jokv6u1AA7tKj04pfl2eRM+Wa2YYDk5VKaAdyFYktmd5RYvB14qoM5q
 8uM4qCBZ6BD1zVyhzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1tYb0f14JP-00k0la; Mon, 11
 Nov 2024 15:27:18 +0100
Date: Mon, 11 Nov 2024 15:27:16 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjd@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] Makefile: fix empty MK_ARCH when using ccache
User-Agent: Thunderbird for Android
In-Reply-To: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
References: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
Message-ID: <9883B8AA-CA7D-4A59-ADB0-ABC86210273F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUG+dm/9VYJbw1+JR37ENGvO3ecCgWjgSvXbvPgOEZoiU+QM27C
 0NvDLgAJXisNytNLz6mR1lD+dpsQ2Nhkn8AfhTWzRAV8ZPCX2Fy18m/tTYA53cinQ/rV1ZA
 B2rA9qBnpQg4z90E9ntttFs97Xs3d7rIFKQY8cQWEfSWzggKaWfUfUvX45aDs9RSF8m2N1C
 n7AocPhv+QrM1DhS8xV3Q==
UI-OutboundReport: notjunk:1;M01:P0:CtzElPWwyxw=;kNho5Fz1NYIMqfyFeh14q1lMcc7
 jlFcgw7X1QfS3++hoEKrqmF3txNYWFKGUQGx3Dbsj/l3MVFENhuf74dvZjbRoo+/eaUroDOr/
 0ovA1ZvoNXAZgr47GQCRNRBOL+6+KsYgoj/oUh1rs7QCD3lOIpf4g1kaOsQTosrjvf5XRIXvM
 37ex17aJPPgr+H1gbs+k/hRT8JECay8S5/nhwDcKNZlbLLuAh+iJZNnBLyniNiDltQ8nOpWrR
 K8yfSazhoOFjs3LuLvghLwv18yOuUq1Pn/aDvjp44EOrZxXHswRDR9nxgcaYa6wdw6kGkHGOi
 kCUWnxyCUlU6VYI0X55Se6y4oAnSSO7cI21ZFeokxh4MVqFAUDcliJbPLMOkGnXcq9Z+lNsxe
 rPg6/DYOCEgi2PX4qzEHOddTM6SxOxoHbXEtC+NOghrYHLtiYtfLfg8gOsBTL1ZXJ2qzAAiGV
 olIdMxaBasQUlTmoPCI/TfKjkCGOj1Pc+89/I72VBZlxx+3bkyIx4Iy7c5sVB+L3XjKqd+t/M
 lpvUOD+ngKRNHpJOjweBZRxMmBZB3fUa7oUF8x0AxNnCJvXrsnQv4weG5fLwTCFNrhQZilkJ6
 7IUMD75c1wGCv+htvr2nW010Xuk4GCdgoRMTsJYZWsWjKDKjBp7WpNfbs9397Wguoe0Dz47z3
 9L9M0Yhwb53r5C54ys/kpBgHacUTuMhr1w28sf5HzqX/mZhYEI8GlY3lX2CCpemE1F/sGRTHX
 Aq+i9Uz9lA7DyR/w0VfIZuWozP3+ynV047Zx8e91zCleaLc1QeTm1cYWQJzWUg8py1ldPgNf1
 +Zbti4U71StsrM8UGBVbGLVg==
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

Am 11=2E November 2024 14:20:49 MEZ schrieb Quentin Schulz <foss+uboot@0lei=
l=2Enet>:
>From: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>
>One can use ccache by prefixing the typical CROSS_COMPILE value with
>"ccache " (e=2Eg=2E "ccache aarch64-gnu-linux-" for Aarch64)=2E This howe=
ver
>makes the MK_ARCH empty because sed won't find a match anymore since it
>expects the CROSS_COMPILE value to start with the actual toolchain (with
>an unlimited number of white spaces before)=2E
>
>This is failing builds since commit 7506c1566998 ("sandbox: Report host
>default-filename in native mode")=2E
>
>Add "ccache" prefix to ignore but participate in the matching regex used
>by sed to identify the target architecture=2E
>
>Signed-off-by: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>---
>One can use ccache by prefixing the typical CROSS_COMPILE value with
>"ccache " (e=2Eg=2E "ccache aarch64-gnu-linux-" for Aarch64)=2E This howe=
ver
>makes the MK_ARCH empty because sed won't find a match anymore since it
>expects the CROSS_COMPILE value to start with the actual toolchain (with
>an unlimited number of white spaces before)=2E
>
>This is failing builds since commit 7506c1566998 ("sandbox: Report host
>default-filename in native mode")=2E
>
>Add "ccache" prefix to ignore but participate in the matching regex used
>by sed to identify the target architecture=2E
>---
> Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Makefile b/Makefile
>index 7275a02f24ca64ebd46c5dc6e769dcdee9917dca=2E=2E71743db16fca930567edd=
67eb77f1c94e9b7b4e9 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -21,7 +21,7 @@ include include/host_arch=2Eh
> ifeq ("", "$(CROSS_COMPILE)")
>   MK_ARCH=3D"${shell uname -m}"
> else
>-  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^=
\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>+  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?[[:s=
pace:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"

The target architecture cannot be determined in this way=2E

You could use the riscv64 compiler to compile riscv32 when providing a gcc=
 flag=2E

You should not make any assumptions about the naming scheme of vendor tool=
chains=2E

The correct way is to cross-compile a binary=2E Then use readelf to retrie=
ve the target architecture=2E

Best regards

Heinrich

> endif
> unexport HOST_ARCH
> ifeq ("x86_64", $(MK_ARCH))
>
>---
>base-commit: 9c25cd563179cf32cf3b119d5ae78ef8348d0335
>change-id: 20241111-mk_arch-ccache-7150482cfde8
>
>Best regards,

