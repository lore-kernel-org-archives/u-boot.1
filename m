Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47061C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 03:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D728827A;
	Sat,  8 Jun 2024 05:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U8RwTPmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E938848D; Sat,  8 Jun 2024 05:53:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1504087ED0
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 05:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717818796; x=1718423596; i=xypron.glpk@gmx.de;
 bh=kJt1tNaQP7BJBe7oV62Kw7aK7DETC7IxoHlls2vYiJc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=U8RwTPmmrNx6d6ksXmdPNkO5KwmSW9wcnBCqFOPQPcHbhyypH6dbBi8a62/rSjY+
 hQYeGSuLrzJmajhjyQgOWQAj34FpT/m0nda9EMSoqqNrBWvOnlPseRb0ZzaKaYYni
 41+041w450tuBG6oiPyn7Y1eDqfTx7QWpNHs7cCdbM/9Vorfiaxv7zVYq/UmCql2e
 f/dOw5RctA7ek3AKhKLufSNw5OkMABsAPV7lUGMf00fGq0e+9DEC2E62gMoMjaRNh
 lMB9mtBrkajoXLdymn6ZFea/0lERojXQg2vM3hscgfGTTHb0Z6yDpCAh3CtVouni1
 eOK4xmkkprkd3c6zVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1sRRlB2Cz7-00xNio; Sat, 08
 Jun 2024 05:53:16 +0200
Date: Sat, 08 Jun 2024 05:53:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_11/31=5D_lib=3A_Kconfig=3A_add_a_c?=
 =?US-ASCII?Q?onfig_symbol_for_getting_memory_map_updates?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240607185240.1892031-12-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-12-sughosh.ganu@linaro.org>
Message-ID: <388854D8-E73C-469F-A214-EEC175CF000A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JBchsNtt3Jc1CSfp5hES3bx9I8FHdSgorXMmD0Qa/V5Qsi9oFYm
 2alpwn6/Gy9C54Nut62Nje1Ps7VTCESrknG196qSOn+gK6KZjJVkPWW3/LPuHOCdI7AeU9D
 mQdk4XqMwNzTYUsuDjhxKl9kladDzbIym1POrX8vbPFcaQowCDaS5bcy3Q3aog6ZA5165zq
 R0G1H7kORZuCo7GrNF8Kw==
UI-OutboundReport: notjunk:1;M01:P0:VpAhe/843Lo=;iW5k9Lyw6tCfCdeKLco5CyVRoyd
 r5iMkB1x0Ul/XAehiumEjsbfSaAwBQhxKElmDMtAdaho61X02tMTM/ovVC7usubv+SXxCLw+J
 i+cGp2qikineIZ7ghBfEjff0w4L+R6P96LxvyupGKKpDcoYMgwOzMHdecTQkPg4rj4SK5kQke
 E2AD8zfk+1P8DYxdnutqGRpeewyqd/KuUV40Yn7cbBbhK5UDnXZ2EURWfL1h6Odal7VW+Spl4
 NytSxM5B8Q7JB6Lpwq8hxGrMwVNoxlY1lu0CALif9AxnDlD5xBNYjWBPoI0SFP77/9f9REvtm
 eXBiD2mIl5dOpT1fjgwZz0ejuTQ2ReaOAwO1R3PzkwFX3NVg9qqRjedGgqKj6vHPWUyRrc+CA
 zTj6iE6tLznfbnK38i/48AmC/KHJbblY0EmY8a5KDsk/p2I9Tgxr3iNOq51nIdLZM11400v7F
 vsPAIO0HDtbf+x9RVLFviIn+X3dcOva3IvT3mwFqtSlVOXekbbDtOd5ecIPRVH9DgtJ0CKLDA
 Wa1F7K4J4oNxgTP16qUPdlCGTPXJyqehx3XzJWZzBstIzJiNoaSR0inhP0cqOwIe9zD6L0gII
 6N+58zRaOGccEXRVd3pKDNp2+TkDc9wD2XrIyiC/jR3AB7W61IdPt2QGN0Q8Daukx5nMvVOs3
 /lxG+xBU1UqhNjA3KK4APBslWF39aM1EMnOzLMvTKVJ1TVOyL6pVkjvdQ8DP9jqAA8K2l9o3t
 bKx0cS/7iLJ4ymcw1JaEQK6IRVcnqAGZWUnhMuODbzl0nuhuJOEGHe6lsHE5rZCw9FIfqlVtj
 pGbb6PeqtWJJfiULY3XkoPV5Lp6ZGnWsrO+lS7n1Yi/og=
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



Am 7=2E Juni 2024 20:52:20 MESZ schrieb Sughosh Ganu <sughosh=2Eganu@linar=
o=2Eorg>:
>Add a Kconfig symbol to enable getting updates on any memory map
>changes that might be done by some other module=2E This notification
>mechanism can then be used to have a synchronous view of allocated and
>free memory=2E
>
>Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>---
> lib/Kconfig | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/lib/Kconfig b/lib/Kconfig
>index 189e6eb31a=2E=2E9ea02ae006 100644
>--- a/lib/Kconfig
>+++ b/lib/Kconfig
>@@ -74,6 +74,15 @@ config HAVE_PRIVATE_LIBGCC
> config LIB_UUID
> 	bool
>=20
>+config MEM_MAP_UPDATE_NOTIFY
>+	bool "Get notified of any changes to the memory map"

To the "LMB memory map"?

>+	default y if EVENT && LMB && EFI_LOADER

I am missing 'depends on EVENT && LMB' here=2E This should allow to simpli=
fy the 'default' statement=2E But why not use select?

Best regards

Heinrich



>+	help
>+	  Enable this option to get notification on any changes to the
>+	  memory that is allocated or freed=2E This will allow different
>+	  modules that allocate memory to have a synchronous view of available
>+	  and allocated memory=2E
>+
> config RANDOM_UUID
> 	bool "GPT Random UUID generation"
> 	select LIB_UUID
