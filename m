Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1409FC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2673587885;
	Sun, 31 Dec 2023 16:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gB+Zx6Nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DF1878BA; Sun, 31 Dec 2023 16:44:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A53687883
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704037473; x=1704642273; i=xypron.glpk@gmx.de;
 bh=GiXXgWSItvApxdp2A/zy8V6+7F6TpxhsmyqM7K7yIgU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=gB+Zx6Nz+0ybUcX/5Qoa9VTM3DHv9aaizfFpkgp5AyVEm+jpHaMjCKqGn5mKVV/k
 +v3mZPxtwAr9uJLDjHE0eafYZ0i6mWxe6tXMwSHhos+vAlNCBNnU2KHDRUv+OqkfF
 n6Xi1qbST5XLlS+3+rd6Ke6umdPILglJIBH0ueoGgmN/NC7xH4ZGmfYpelHTpPI7Y
 B1HzVJtl3B5DtE5gD48Ftq8YYTDMZJOOrHXEVBcsXHR0yIu4l7L9l9cYhUh+WivNn
 N6tB4A1jYNFqiebnGqMEB+pk7P+641+iVPpTaEkpFKI2bli8+LCDhctTY+MKJfJ/3
 FYsmuv1j/m5OJX55JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1rdpE10MrQ-00JoTR; Sun, 31
 Dec 2023 16:44:33 +0100
Date: Sun, 31 Dec 2023 16:44:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_10/12=5D_acpi=3A_Rename_tes?=
 =?US-ASCII?Q?t_dm=5Ftest=5Fsetup=5Fctx=5Fand=5Fbase=5Ftables=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231231152555.464874-11-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-11-sjg@chromium.org>
Message-ID: <1E62ECDE-F9C4-4035-A51B-53A083D61C62@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A9z4mtL/X1GQqNiqEAjrOwrhAAJJh+8RPctj4W3j1k/TYdFbiHw
 rGamgqNzSdnGsu6d+Y25kZgcwEZyCKcub6pH482x9TLlrsm+JFT7OvSCV26lrIc3dphE0AU
 ztyB8ltjhvPkmsMYcjFVSqhnHCojfKGcnXSWksd+vyqxvgVH8UlwFmam/MrC6NA9EDnr0Hq
 Oa89Mn+k0kSyUi79N1ywg==
UI-OutboundReport: notjunk:1;M01:P0:SM0kNpMkhqI=;L7eHCxQ0J1fddA9rZgpCQvKFv5w
 kYNx8VLJuGIPlTJ/BETdBkwo5RVLeZniEXfiP7+eef7Rrszrn57PahCcjgBlam8j0GE6WMuSV
 eMNmJNKekfmIseEMXBcH2xfKDWbhFUyA6pjhTKuIe2M1z7B2RWMO7TemfI4x0EAHNSwnoi0G8
 827fRhQWQ8zCF/BrDrCD/dzLeAVhysjINqOdRrHiGOSniLIpzvJ8n6WRqiFRlBKjHpxoGG5Wa
 kKnVyUfR9TwLkoRnhysfCBVIfvnysOFnW2oZcP8CfPXfUEZDSkmSdcSk4zQPlYk6dHcnxTUFr
 yMbQCmRCQvtfcrpq02+m9BKnyC4cjkKL8B1EYbpytHCr8/ZG526qHaHZOgEz92VSKsynvwWao
 28BdBhtOZO/WxhO/w6A4oOf5eKWVQHlvKcdxhseVbmzfeE6dHlm+DG9SaSZ5pIrdTgzfJESki
 LNA7dMpaFHZX9Fl0cO4PHi1LFFBn9QpBTVr8RqcOCUbv40jHVX1ASvW6bC876KoHwQMcCSnj+
 ii1m0m9/ZXWqG01QDJbegoW1p5RmjY/sB1+f6GozAWceS1xBn8ypjpS4Tkym6/eKAesMp4vuJ
 xEgvVEuq3iepwMnJvRfOUNdFljDtpjDooSAta5Mht3XPm464qDER9PYQu5yBYNlKmkuEn2bvg
 MIs8sRCLdlVmdCvoJn/7gSnZlw65mvCXZpcepOqxug6U+pV2YYNu2QQafAkAstO9Bw9VmTVGt
 lU8K0pTsjb8FhjEXZjbG7893wjIcdF/VR2as35y4dcSNrN1wW5u9hC5IFhm6myU0NRS4vtFn2
 52UVIK5wNNFpvgeE3Uk2gGqD+33uSCiFTFxObA+DGR3Sj7i+mxCqlT9jgK8L7aDWMs8bWI0GH
 NzybuYyE8CHgBY6ong1gSwnJF+MQwJITAmr71qJaF/4vPRgv6CTtfWUGKQnAXXhsYNkzIPGxE
 AaXA+bhKxppJ1b+YZ0KWBZ6XPOI=
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



Am 31=2E Dezember 2023 16:25:53 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Use the word 'acpi' in this test so that it runs along with all the
>other ACPI tests=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>


Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>
>Changes in v5:
>- Add new patch to rename test dm_test_setup_ctx_and_base_tables()
>
> test/dm/acpi=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/test/dm/acpi=2Ec b/test/dm/acpi=2Ec
>index fb071902b45=2E=2E1211e2f0e7f 100644
>--- a/test/dm/acpi=2Ec
>+++ b/test/dm/acpi=2Ec
>@@ -330,7 +330,7 @@ static int dm_test_acpi_basic(struct unit_test_state =
*uts)
> DM_TEST(dm_test_acpi_basic, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
>=20
> /* Test setup_ctx_and_base_tables */
>-static int dm_test_setup_ctx_and_base_tables(struct unit_test_state *uts=
)
>+static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
> {
> 	struct acpi_rsdp *rsdp;
> 	struct acpi_rsdt *rsdt;
>@@ -376,7 +376,7 @@ static int dm_test_setup_ctx_and_base_tables(struct u=
nit_test_state *uts)
>=20
> 	return 0;
> }
>-DM_TEST(dm_test_setup_ctx_and_base_tables,
>+DM_TEST(dm_test_acpi_ctx_and_base_tables,
> 	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
>=20
> /* Test 'acpi list' command */
