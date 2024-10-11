Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0890D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 23:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4360389407;
	Sat, 12 Oct 2024 01:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PaiiQjKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6EA48941F; Sat, 12 Oct 2024 01:25:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE59D892AF
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 01:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728689140; x=1729293940; i=xypron.glpk@gmx.de;
 bh=xHkDX5JVcIXMrtxU8ADulkeIkBsiDLBuDLHHr9s6Kp0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PaiiQjKpYiU22khDFIp4Ok8iIBJtMKbfjhPOHFJs2AuQQB+yq1+siKZzmSi+JSfJ
 yUPJa90bDBHTa9vQeNXv1D0y4azTOd5DF3fEFDzxyIRL7o8e3LHgL8FMIQ6hInYlq
 RRIepgZBjmLXFD3rDjK1LW8IC/XtKFsLrfd/Dac4b1c4yLNeNefuh8c6aOAUW6x4J
 cIkn87lDQNOStrp9vKC2oD7GDyIZTGKiaGuTyPJEJKbLTecQUxSbjA3L3bVCu36F8
 8YMv2b1UEs1iHzMrTZafRwPN+YQKrnjMHxcikKC7gLi+1pigYyOjEv0zRfjt3l3rA
 EzZLmahVtjZ35EBFGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.96]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1tzire3Vpd-015j75; Sat, 12
 Oct 2024 01:25:40 +0200
Date: Sat, 12 Oct 2024 01:25:37 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/7] common: Tidy up how malloc() is inited
User-Agent: K-9 Mail for Android
In-Reply-To: <20241011214032.760072-3-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-3-sjg@chromium.org>
Message-ID: <5F3C1A6C-4EE2-4E5A-A6D9-F7943827A3B5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Ab91KoaA+fCD339K8glLrWSLH8cPUXvrSswIqWl9c1VGORkp94
 jtcZww2bQ89sBNUrdsx9D79gFGLgFQngICa64Aht7JL7+pf0+2sVJ8CpG7xZzhKSn1A2QpV
 Ttoc0HF4KdlJwgLFacT+eHJt+6alzYRhQITId5HW0b1gjI0bwNHY/gha2NVQ4UeR+X7+uQ+
 YRjnyyYyFZNa7mzLbpSWQ==
UI-OutboundReport: notjunk:1;M01:P0:l6IGnvG1eH8=;3oR4dhLnrH5x3rqFT1zU0tvooH4
 zPN0AEOgeThhguWtGI68jt+OTXodinVAyuqnCP42SlkXjqvtpW4OQL0RpRli5IdZghKGNRdGN
 ldUb0ORkWlimIr1dKA1fY+ErxwcTC20QB57HFB0vMG7OUzt7tpJlRF71zi/OqD3bGD0YqNXf+
 WcCgMi8NeOJrR/hn7+RJDnIkr+caT7vL0slCLswCOanVvOwdTBbg+F4ce+8CdJVu2Vh0j580W
 eyBG600jfTUmS7cLPvqTix8lHYWwklnj/ZgvIAZHzRu4w2K2+VVc5Jd0/ps45BSQt90zUyLdi
 FDjJ+qkWiLk3p7W+RXDNLgxVDBYqJYh1QqWsvZkUqriZbvade6ND1/sOg62xpa36gKI37f+2r
 XI5ADhCMJoaXHVc1j+NKM3wZlaYINjFNatTLSZd+fonj8lk1ToWm8jhkLM0tC8hnLUjmuFb4J
 +97Du+MeE/DENLk40bYgYUWTJX9BxSPta0e9od/xFlJmtSJZzOTVrK40jSmGtGkXwZm7rtPaM
 aCDIjqzu0HN67Wc8xvir+GqBbHl8rrZ2Insli0oqB2a6pNCf40nmHIWm5SXffomXt1mKvfokF
 /UxoZhnbe98XhFdWX1Ka/jwoV6hlJyZYjcekpPR/y3VVc8gO3WAEDbWJrJBexqu+ckvaqlen5
 LQ3yWEhcHfAwSrs3paDdRRYZY+gg4LhW4bKkCCs+83XlkF33QzHVoMJw7DKs83JgMbDmcf7fA
 cMIn6FR3vXsWdcCLyzJF3bbZ8WAhw6FD8MMQr19zTCaPlhaN9zyzKR7IRjLMnij/J7czyISrn
 OirQqax5lz4WDHnbPscx8mWw==
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



Am 11=2E Oktober 2024 23:40:26 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>The call to malloc() is a bit strange=2E The naming of the arguments
>suggests that an address is passed, but in fact it is a pointer, at
>least in the board_init_r() function and SPL equivalent=2E


Please, do not push sandbox only code deeper into malloc=2E

We should strive to get rid of the sandbox only virtual address space wher=
eever we can=2E

Best regards

Heinrich

>
>Update it to work as described=2E Add a function comment as well=2E
>
>Note that this does adjustment does not extend into the malloc()
>implementation itself, apart from changing mem_malloc_init(), since
>there are lots of casts and pointers and integers are used
>interchangeably=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v1)
>
> common/board_r=2Ec  | 3 +--
> common/dlmalloc=2Ec | 8 +++++---
> common/spl/spl=2Ec  | 4 +---
> include/malloc=2Eh  | 8 ++++++++
> 4 files changed, 15 insertions(+), 8 deletions(-)
>
>diff --git a/common/board_r=2Ec b/common/board_r=2Ec
>index 1acad069d92=2E=2E60eba0942d8 100644
>--- a/common/board_r=2Ec
>+++ b/common/board_r=2Ec
>@@ -204,8 +204,7 @@ static int initr_malloc(void)
> 	 */
> 	start =3D gd->relocaddr - TOTAL_MALLOC_LEN;
> 	gd_set_malloc_start(start);
>-	mem_malloc_init((ulong)map_sysmem(start, TOTAL_MALLOC_LEN),
>-			TOTAL_MALLOC_LEN);
>+	mem_malloc_init(start, TOTAL_MALLOC_LEN);
> 	return 0;
> }
>=20
>diff --git a/common/dlmalloc=2Ec b/common/dlmalloc=2Ec
>index 1ac7ce3f43c=2E=2Ecc4d3a0a028 100644
>--- a/common/dlmalloc=2Ec
>+++ b/common/dlmalloc=2Ec
>@@ -16,6 +16,8 @@
> #include <asm/global_data=2Eh>
>=20
> #include <malloc=2Eh>
>+#include <mapmem=2Eh>
>+#include <string=2Eh>
> #include <asm/io=2Eh>
> #include <valgrind/memcheck=2Eh>
>=20
>@@ -598,9 +600,9 @@ void *sbrk(ptrdiff_t increment)
>=20
> void mem_malloc_init(ulong start, ulong size)
> {
>-	mem_malloc_start =3D start;
>-	mem_malloc_end =3D start + size;
>-	mem_malloc_brk =3D start;
>+	mem_malloc_start =3D (ulong)map_sysmem(start, size);
>+	mem_malloc_end =3D mem_malloc_start + size;
>+	mem_malloc_brk =3D mem_malloc_start;
>=20
> #ifdef CONFIG_SYS_MALLOC_DEFAULT_TO_INIT
> 	malloc_init();
>diff --git a/common/spl/spl=2Ec b/common/spl/spl=2Ec
>index c13b2b8f714=2E=2Efc8b38862e8 100644
>--- a/common/spl/spl=2Ec
>+++ b/common/spl/spl=2Ec
>@@ -679,9 +679,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> 	spl_set_bd();
>=20
> 	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
>-		mem_malloc_init((ulong)map_sysmem(SPL_SYS_MALLOC_START,
>-						  SPL_SYS_MALLOC_SIZE),
>-				SPL_SYS_MALLOC_SIZE);
>+		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
> 		gd->flags |=3D GD_FLG_FULL_MALLOC_INIT;
> 	}
> 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
>diff --git a/include/malloc=2Eh b/include/malloc=2Eh
>index 07d3e90a855=2E=2E9e0be482416 100644
>--- a/include/malloc=2Eh
>+++ b/include/malloc=2Eh
>@@ -981,6 +981,14 @@ extern ulong mem_malloc_start;
> extern ulong mem_malloc_end;
> extern ulong mem_malloc_brk;
>=20
>+/**
>+ * mem_malloc_init() - Set up the malloc() pool
>+ *
>+ * Sets the region of memory to be used for all future calls to malloc()=
, etc=2E
>+ *
>+ * @start: Start address
>+ * @size: Size in bytes
>+ */
> void mem_malloc_init(ulong start, ulong size);
>=20
> #ifdef __cplusplus
