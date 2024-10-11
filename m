Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A50D1A427
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F6A89413;
	Sat, 12 Oct 2024 01:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WCZWDQLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D020893C1; Sat, 12 Oct 2024 01:29:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DBC893C1
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728689386; x=1729294186; i=xypron.glpk@gmx.de;
 bh=SDVbyGbxMJxsTj56ZMK9Ub2LH9t/0Wa+klAuI0azUak=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WCZWDQLVn34qKCZuiKB/e45Ch5zko1ncnY1iRu6TZSa4EBK9hoPEi1e8mXdd6+iZ
 iU5I6M1pRpTG0hezje5URsA3rCFgRBjRf6neCmZ9K+n1mKWnhAGxHUnAulAz2LSLp
 w5m4m4aSSyASu1rqjX5+HWK7AplCF0/eRXllp+cmMNULzHsgQk13uyW1GisVVaakT
 Jqt057U0b489jBPhNVpFFs/VbE82H59MrzZwim3q1vY1S8ZWP09ewDfwwulhvOetW
 Q/d9ifFwmiSo/wlLLNlE8uuUYWaabf8qDAbHKJNjwJZJ7rehy+y3zYISE1EsphYzJ
 KxJ+aqnDUIxWZyEIAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1u1uOF0b1h-012XIw; Sat, 12
 Oct 2024 01:29:46 +0200
Date: Sat, 12 Oct 2024 01:29:43 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 3/7] am65x: Use map_to_sysmem() to convert from pointer
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011214032.760072-4-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-4-sjg@chromium.org>
Message-ID: <76216664-F619-44F0-8AF7-9B115CF1A985@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7GvoQx1ym6jl0YGBJ9WtP/78vcTTI5ay1R39goy4vGHolRKipLM
 7XqAyssFbJ/7L7/3GI4vhcILCPhkVnhwJF3bht1Ii0dlYGJd461e+iUHCPKB90pBbbkd6TY
 yeCjbfkyMYRQCsfMLSr3xUdfbf7jbQ+kPeHHgjTQrcVXze4ecKGYB6IBs34we47ZOzN+0ql
 qGcuIu+SygNggSojeMj1g==
UI-OutboundReport: notjunk:1;M01:P0:y/TlGutJVnA=;sbDujMLMs9ygsmwlS4u8d/IcOCM
 0Ycr5M0PRVZ79mmcNV6Gigqys5Xg1jIyrTSu06Fz4P6PYvCTR3F3jV3mkf51P53BFgVCEDaeK
 Ti3VNmIGniOU9CSzzMDaG96mD1aGzEb2S3r9nA8vz4PqNRO2ApXkzu/RKyduMk9t64P0E+rRf
 gjK93SKDcv12+3/293yG7qhVMhcdGF2qUPrtGgwb43mNRDx/n7pmm6TUhg2aF1fGOYaoabGpv
 EqaOAdpYjGZhLJQXdzaxozTxRCy+DtiH3xfnvp96tORl204rr8Ijd6eZdymVPd+vtgJowfbvE
 OWUgnZ+xgK1wHUFY9waWPdfBZ90+n5dgATlpyJGxjN+fkf0yaXNpEJREgMBpOpPoOaOCUxKvZ
 6rVmJuq/eD8VoWRPn09LE7hDWRWRnPH6anvLwPrBjxy4aSTxpxqLVahrJOGXvu/6mqNDkIYhK
 mk2DFnjC4BLvy15L0PquHCyN/ir0I51fuFv1VHje44BztTMqOL3RcwGXRwmKBiuK3wVuG8C0E
 cmSKEcumoJNaZKJGQY/OtwVkSp3D5ggcARICRFFgOC0f0iVUUgITlcZZSNnSACSn+FbRUx1Ff
 dPVaJZc2Zd/E/nUv3sw0rcL7RSMD54dqLL/lz484I8kEWZ10OtwH6Ea21WQhNXaKTkIKg5r/B
 mP0j5XRp0OGG9miCrRdBHXLogqueptQ4MvzFMqoppM/Y52LImij4h4kA25/avkPT7VK971Yff
 1buuQiOO3zhxn3mpgjIsNi2MVcAb+fyeausrkOPW8TjFv3uRHO5p/Vy0eBCpiO4sSuzEIA3Zw
 bmhsHhJLh963d/s5oUxwjn/w==
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



Am 11=2E Oktober 2024 23:40:27 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>The board_init_f() function for am65x is a bit confusing, since it uses
>the variable name 'pool_addr' to hold a pointer=2E It then casts it to an
>address to pass to mem_alloc_init()
>
>Rename the variable and use mapmem to convert to an address=2E

This patch demonstrates that the whole series is going into the wrong dire=
ction=2E

Keep sandbox only virtual addresses out of the malloc library=2E

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v1)
>
> arch/arm/mach-k3/am65x/am654_init=2Ec | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm/mach-k3/am65x/am654_init=2Ec b/arch/arm/mach-k3/am6=
5x/am654_init=2Ec
>index a4f038029d7=2E=2Eddcc1355210 100644
>--- a/arch/arm/mach-k3/am65x/am654_init=2Ec
>+++ b/arch/arm/mach-k3/am65x/am654_init=2Ec
>@@ -8,6 +8,7 @@
>=20
> #include <fdt_support=2Eh>
> #include <init=2Eh>
>+#include <mapmem=2Eh>
> #include <asm/global_data=2Eh>
> #include <asm/io=2Eh>
> #include <spl=2Eh>
>@@ -165,7 +166,7 @@ void board_init_f(ulong dummy)
> #if defined(CONFIG_K3_LOAD_SYSFW) || defined(CONFIG_K3_AM654_DDRSS)
> 	struct udevice *dev;
> 	size_t pool_size;
>-	void *pool_addr;
>+	void *pool;
> 	int ret;
> #endif
> 	/*
>@@ -204,14 +205,14 @@ void board_init_f(ulong dummy)
> 	 * malloc pool of which we use all that's left=2E
> 	 */
> 	pool_size =3D CONFIG_VAL(SYS_MALLOC_F_LEN) - gd->malloc_ptr;
>-	pool_addr =3D malloc(pool_size);
>-	if (!pool_addr)
>+	pool =3D malloc(pool_size);
>+	if (!pool)
> 		panic("ERROR: Can't allocate full malloc pool!\n");
>=20
>-	mem_malloc_init((ulong)pool_addr, (ulong)pool_size);
>+	mem_malloc_init(map_to_sysmem(pool), (ulong)pool_size);
> 	gd->flags |=3D GD_FLG_FULL_MALLOC_INIT;
> 	debug("%s: initialized an early full malloc pool at 0x%08lx of 0x%lx by=
tes\n",
>-	      __func__, (unsigned long)pool_addr, (unsigned long)pool_size);
>+	      __func__, (unsigned long)pool, (unsigned long)pool_size);
> 	/*
> 	 * Process pinctrl for the serial0 a=2Ek=2Ea=2E WKUP_UART0 module and c=
ontinue
> 	 * regardless of the result of pinctrl=2E Do this without probing the
