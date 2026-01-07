Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E9CF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 03:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E3283C6E;
	Wed,  7 Jan 2026 04:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MDP8DBGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9182683CDC; Wed,  7 Jan 2026 04:58:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FEC83C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 04:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767758319; x=1768363119; i=xypron.glpk@gmx.de;
 bh=akbAJcJxXa1ic2HTvIfcak4W5NcyTGoBEYBs5o8b0D8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MDP8DBGHTPl14b3iQWAzIf7th72UxuT1dgkg/MTDz8r4VmjhDUkvgpPoRvPPibD3
 QCPx/FgPkvDhrHO/BoNJ2Ime+OY81ByzOhl8CzQ+MP8wgGeC2MW2ph6WayZYSLZHv
 95P+e8H5i1J3cmDdJIgW3okETxqt1TM1oGUdU1Sqop3Q5Lu2y3/mrlKuqp/HBd5Zp
 Z6ctoU1j3Z1L3x7DSUbmpm0jl1pMAbfBQbTwcRQF1im0aplg5EJRfssZfap4/8TKW
 Oqi917M0owReGxboXFko9sU9QSQzZZTjg7iWP6B/NpZdoxOdGm1gJ5PFVzL4WhdQJ
 F02A3Xo7x933+VJOhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1vHnfZ1pZK-00JE7T; Wed, 07
 Jan 2026 04:58:39 +0100
Date: Wed, 07 Jan 2026 04:58:37 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
User-Agent: Thunderbird for Android
In-Reply-To: <20260107003131.3064800-6-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
Message-ID: <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hYA1Wdeb+D0luI+KJFNrSzha6Fyxh300YHInnmoKBx9gtoD4luo
 ZWCPiMkVZ2nQvExk9i0DdAlwVHnvf7ucyqCXSpZQl/bFGuu3GE26EVFNaZoE172eOrVBUxf
 GmFt1up+DphM1R0U6keSNBB0VyMKqcPaoxpQyMHUT+YRkxeWRVC3u9/PR6B3nFP1BaGS4u8
 egI29t+YEbwmetTF4uupw==
UI-OutboundReport: notjunk:1;M01:P0:RcVS6uk7qcU=;pxM2+N+RB/RlbrusT9gcYZ6H+c8
 /06Uy+OmFm8OeWDpfS6EHJ5Y5OmfFtXOGy1QUSoPlqv+ti6cDiIkU0ryNuMNBceb+7fLGorzx
 ikXkslNoJW77LzQYJFb651ivdTGQXkr3mdCv95LD/KAH7h0oS3RbDH2BSjbqu9uySeTq/oNZE
 0s/g1l9+dVWZKV4KNqkO9sL5X3kazDI0rqqGkKnY5zp4Eqh8u//gt0N6sTnGzsi6zEfxfeWJQ
 Xe72b1bmmmvd59tvq8cOknQ5oEq6dtNOw+TU4ZLgqm45oSFFJcJMJCjm4b40hjLnEzsboKzVh
 VSb+4cxZHFl6th3yl3p2XVL2CjenlCy6Wwng/OxooGktD+erUnJW8p2aQ1nW+LxK2K9LyQljT
 zLxv+AIelgigYHdo6fcDDrCqqIFE+npU/CAKGssC1vCQqecHGd2WB+fctVz1FQ4h/mhbH25gf
 a2MR/8HKh918VDhWTtbqn+/VdxtPcoDaTEngb9WeyxeodAc2BCU2K6KQ6TqSesO/G1BvJtrUd
 cWyGkg/u6/PwJfh/K0lH0psYTzYCd9835zTakam6BfC+VEX1sW9A+xTb3mj47ZCJdJLdtguyA
 QzThlewNqZmzIsZvldXMwaaVwBKhAX+8Ly4qxc7L2bjyCTS+Uia1nHX/DFnRM0otDZ1qXgkMS
 Ctmhfle2hklcMbUWEiZjfDbRUEIYyDJQpk0dwUffNyzuRyJsFaY+gNULGYdcvaNy/SWGH0W0R
 9P2ixr7DaQJst1uhpVbm6akNJUbXcCjMbRvj0RVu+b1h+xMN+J0qL4bIQXWCMm3k1XM7Eu1Vu
 XPz1dvWfVzeC9t9OJUIidGBZgtMMmkLqImyXjg3wdpo2AvJO6KtYL9hixCsEve9O6Iv3lgQ+Z
 S85jn/zk9RcQxEIHHqe22Re7pjRzH49UgHN2zi4fx/3AkfnAt1sXzKal2XxIL7zGh2zLiwfBq
 hvgLsIQcCTgbOMnLSjColo7TTv0Ev7nwEzudWv8sulTTgu2v6+2IvQdLtmyf8TwFQimTwI1SH
 U2+ez8x97DsbIiCkBS6w9APEIYI4vC5tzR/xgbPEneu6IKNuLVFXV2wCc0gQRj0zkrJ8vcwth
 dlcy39t2f/ZL0j0PRG5K0/zTM1RG0Oz7metLgNrZ48UCrnAi1TAgKDguuyDmbmcnqdtV7VMdN
 /s5fnsPmnLVqFryX0Ku3YN9dzpYJf1TlLJz7TVfhrxcsGxQCnCGKmHYG9IBR1irVjP56eWxtA
 IP1TMQAxTMq738pxp2+p6O2beSgmN5mS2/WwoJidAY++vv0SDYYtW2xK1qdoOp/lwJY63yR6w
 YiDr81WUXtd2OqzGIHaK3XFcGs3uQ90Bmpaddcm0UJlMZeBHwkVN/Vz/FxcbKnbG3IMP23kCa
 BTnQiJetnprrDrKM3Ou1Mtug97FIQh5RPtLrmF+2Osq0lyfFLuApnN2ZuJYoW3HzPLo1q6Vda
 EpgZXKfQZpwA2iQEZPUj5oSFJ4QAQqczkBo+rKlt03RNnKQpYUizWMvM04mrYYhmrGuYmD5ET
 yhJsUkak6T0Hz/IwkC3xoFpXldnTdfLYc9HEJB5L9/WyNlRrzRLjJ/d97DDQgYVH+kt940zco
 P4SzpVQyDKJE7SngOzyTYOhohIZVoMIqhhCTSMmtQavss47CdkdDKW3iiuI0JdwVjLaZOeM00
 5AZztJxcNTmCJtT8ES87Dq03oa6a9HmvrB0MYgs4sY5dl4Zg8wG2f2A2MopVNJkzLPJRXdjYW
 lMw9OzPvNuqS0J1iLZuOEaJCYzGmR9VP+yiWnTjd4X40eSYTRPtslbm9G43WwpWGtuMeSgjlK
 R1gsCB+GdHEYD8gXi+ytYkK3i2s5xPkecuv9518QCb9MyzBY9MJUqwyLbBZrwePe+ZsFmq5Ju
 SaYmLsuika9PhiYyw9IMmkun6mwGRvZ59g14ePmJ+q5v4xWP6Fm/8DaOJAuwf0iMHORuWPxkp
 7cuiCpoNsXETI9eolL+mAumvwhzLqeuCrP6226PsdZ/xeDBc856LTZm9GiONYsvEzW/d6ctHw
 YmJIkxv9L5c3DQIj6uKjfpgtheeQJO9tJPiXyo49Hub2RhcI0P/fC4LzeL3dpRHGD0R7Er5nw
 ABGcy3I1C8t9jSoZERdPuLTxUW7oFkLtmUfeH5bUVBc/+yRdtWoqhAggOATZlV39INfHgKHkd
 NOcJkkHHT9jma2J2vn6TFcOwVK2FNkknYl74jMaZsIFldf0OpG2KW7LypbOcePxJRuqtWSvS2
 dH61Mo1tQEFfxAAIUoXyJSyKaE7Rh3U9Ok17loWeupVCJkerOu9o9m4SY2d6wc1sB5queUDRi
 qEvqPQAaehf6tVsrh1rtkdhpbGdbJKTznLCtJ5e/ApfMQKKFXa/6Rro2gYcvVHIXguZwlNOzP
 gd05yIkDy/i3tivr2nZiX8tzn5cT+lRjCCe3dqkctXl2X8o75w2O+zIE3SnfXsC9Z7ti9e19+
 FjxRx912xtenLEQ1F3vTkRPZPU5ezO/LAVsAwwednPb0e16ngjM8C/gEI2Q6tZsYZi/z/ShQf
 +jk1jEG6EcyPukhJFmW322dxfonYsQbWIk15oajvJluqA0SMrvb6JKw5GqvJR8pJqflIqNiLB
 nWwAPtqwhlw60vqMTlmaHmiGp3s+Kwf/LuSyQdAfgGyeWuYMxAav/m1mop5wCcZNYcmJj9OR3
 /htwksFWzaYg8FaAYFROgBCP2hi0Cp3UNcZd9yJIgBbM0LhN8Vc4PCjdhSVkBhhecuBDV6AcT
 bwW5rU2kuBlsiZwIzfLjcMPqIfoe6GYUNB08r9Vbt3LflWIml1MlhqQ9sz7KJHO48jBSkRbzU
 gv2AbSyGIwSXr7ROLtaRzItMNxPVaqCLar3SSfnuBQ6nNFkLjlldBeV9E8x3NngU98TRXJ8Kp
 tkOO2poiqSM6N7wG8odIc9/5j/8DEt4oSjleBtDwBU0KpJJsFSfUlcn4tNywcF+TNE5QQE0So
 qxOxNdhx+5nZYNKPkPw7o6hTY0BB6k33Fuz2Mt68BZNNEWtYTPi1vCrQQN8byJTb9OCOq3xXc
 9yQGlC5JFA8Npu/xCcr+ZasFhorM7ZHD54ezlH6WSEDQ61Y0ThNuxX3WgxRPhNtKFjjRl3pm0
 /lWgz+X8GZI06UQRiB+Uc8/KtvzqnhEotYcqULK4JzR3kFXwJoneXt2BEEA3+CKyVjkexkrFf
 PChM9NOJNTMjWqHmgbw0ZUlKJIlCbOzmfBm9Z/kTWFco3iLtAGixieWED0Luin7l3evyv5lLb
 idTWcKacCXvOqWRx5uwPrM7QF7eb5O+gHT1QjyVt9YrWiIsolN9NN5kvXMd7p17Tm0u4bb1aD
 +IAuJ8UMg00KBrzXglsu7em6YejihFKubzYgai2BxAXp7eqi5QfqvG1QiLAQF9GWQdnIoJDwE
 oBmPxctYMbTmdw7A+4Mqfntw6NnIkJt/W0AjSUqwYyb+e6hIFABMIcMo/OVT/9Y49CurhnwPe
 ew/O94n+oTALRy7j+rnbYyKjg2NqV4BxM/RwhUGvhF51lhBeNJToPJZMlbaaVbtJ2MRUAv5dJ
 wKdThHp6YpDe+Ei2eyKoXoYgoRlyvmNi9YNrE1WGlnEwIdbxgHS4jxEo1ZymFpKvAvJk9GXl1
 Y5jWmH4Syr4TVNpdEKaQGSBfsFoEtHOPOxHNmuK6pwp91gjnZj3n+j4yLxIZchRAXQmrnT0P4
 oCnG0UiPMdotHhfIwJyjZ4lT4gvWXacv5RNfFxPqDhC2y1FB4PzUW09g2tI1Zj7jytUaDYd3Y
 f2rzOFyChxWiVku9kpf/FUsavmnMUybQtWTfKaXUI2C2Nm8LeZDotWiDLUw/ow94WNu5XEO+0
 6KwdZbp2PYuz7XKv5vwlBz16vjlLeRL6CWzmPDwBCNE48ijKv5csNmsy1rYxiR383OmgluoRS
 wM4v4EQbnhGrHGVXKDvP7aICtQuCAEJLwYucdkxexHAwhODESCWcfVtbcTlgPpC3Y02n24BR9
 ZGfFbPki8FMkoA2/KQzAurA+FKLlMCOwmWxNeta0HZiCKdaI4OlHO1R6xHahVAWklEMIkKscS
 R69e+MhV2r3yL3+1GrYVqXcEhydW+w27koIpGv6sRZY/VP8IP1rwlqy7T9Y5ATDdaGjjdnguE
 YrelLm3Rtlrp96n16GkFQuuPDN5ZnPFgvwgnsAroaVjgWGjBVTVgKXCLHxyLoNJ0MDiFFrsJT
 hm1ONN6fM0XeCJjcP9XRfcOJAkqyWf+fgeHmJLTXcoqxPiNkDOebQOMAyHPjxuX1nwaH8kDZC
 w0veQa6fJUbAQFW4DNYlC+uS4gLWH4uAZpvqF+YPq66wxeb1EJvVzSu8pZRVKRQNHu6crDESq
 F3urUFdIkC505fsDR2PVv3xM7qtCql3vMxR8ExINbBDSrMCbY+k9VOfbUCr+7H3hV8MZra9Kw
 BkcqpeUt5m4fgQxiqZG26YNQt+ZpHjIvNHxfy72LWFlGK+JVe8G+XCkZ6qjaKi51mbvjZHqwf
 a0BxlKd49triz9+oSb6QQwAX/9htBu527rxPjWRmEH3VfGMcuTS4xaRcfSDQIKOXHkPTv4OC7
 WgkhzfzDSX4jMRRjp9+DREhognGpj0s6q3uInhIC7xpyzb22Z7NhOXOFEM16KuyC+hfd8/GXR
 fmgRwHpE20/hT/vUUl09wj4cF9TvPS3ktvUJQkiSY5UeAMnw4tpHDuzMCTfuXsk+G9hBfXjBj
 fFX1bsygqteB1II08gxPXMVGJzR+399RIfNoyH741d8WNszmuiivBKNdlv8B35Tq+aRq6yXnO
 CPBsH9rcfc7VJnOXkZ9uzswhE5l+g5xHbCoAtnDMva43wFniwxXWexNi9BBAaFc1EJQ8PZ3sZ
 5GGafbiMLmhtcNTH0d8cbSWhoOSJKOz/rjYmobJkiEZh5z8LN52cIXgLrPC/S3oKPBoBrbteH
 1zLkPrfGLMRfda1srdwkzgszNkYBt1+tB4YS5zo2m4QeJvdU5vfILUnkfjvoITailwkIgXXTe
 3P4gAlC7H2zQGEKoVr9x1u64Vg82HvG367WlhQfM/mLEzszczxnqroHRyLOFEZMHSm6Z/TBcO
 31TxldhG7xKx+6El0bNwLFm6+Va+Z5avA9+yzS/9rbzJCkwTOD+4bd7hmTkEVKNrrLxNoxzdi
 sRe7EnyMvAI4bmGHQXmVqYhooA4W9nxihHNol+FKLTHiqMJESwLOBslDeqnY5wAwbPJA8W4GJ
 2R+87KAPqQv9Oa1sbjYeRHDvEIgvqCNnNcAMpkNzKuM3Fb4064g==
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

Am 7=2E Januar 2026 01:31:22 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>From: Simon Glass <sjg@chromium=2Eorg>
>
>Mark kernel start before booting=2E If enabled, show a bootstage report=
=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>Signed-off-by: Simon Glass <simon=2Eglass@canonical=2Ecom>
>---
>
> boot/bootm_final=2Ec   | 6 ++++++
> test/boot/bootflow=2Ec | 2 +-
> 2 files changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/boot/bootm_final=2Ec b/boot/bootm_final=2Ec
>index 71661334e11=2E=2Edd7cac55f1e 100644
>--- a/boot/bootm_final=2Ec
>+++ b/boot/bootm_final=2Ec
>@@ -6,11 +6,17 @@
>  */
>=20
> #include <bootm=2Eh>
>+#include <bootstage=2Eh>
> #include <dm/root=2Eh>
>=20
> void bootm_final(enum bootm_final_t flags)
> {
> 	printf("\nStarting kernel =2E=2E=2E\n\n");

This noisy message makes no sense for EFI booting=2E The kernel in not sta=
rted in ExitBootServices()=2E

Operating systems like Ubuntu tend to boot the kernel with argument "quiet=
" for aesthetic reasons=2E We should not disrupt this=2E

Best regards

Heinrich

>=20
>+	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
>+
>+	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
>+		bootstage_report();
>+
> 	dm_remove_devices_active();
> }
>diff --git a/test/boot/bootflow=2Ec b/test/boot/bootflow=2Ec
>index a56435d053f=2E=2E80adc074070 100644
>--- a/test/boot/bootflow=2Ec
>+++ b/test/boot/bootflow=2Ec
>@@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state *uts=
)
>=20
> 	/* TODO: Why the \r ? */
> 	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
>-	ut_assert_nextline("Exiting test app");
>+	ut_assert_skip_to_line("Exiting test app");
> 	ut_assert_nextline("Boot failed (err=3D-14)");
>=20
> 	ut_assert_console_end();

