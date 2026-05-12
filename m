Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB08CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55475836AC;
	Tue, 12 May 2026 21:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OQBf7t9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C463838BB; Tue, 12 May 2026 21:05:38 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A5C8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778612733; x=1779217533; i=xypron.glpk@gmx.de;
 bh=VDHBeF4bgNoJJihQctT/CtlkTfOnbKwuUhXEGvbyH9A=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OQBf7t9zHhOCFt8ff7TsIS17fo23qN7dy5ypdX80ovweJJygUDS0QkM4BGRvBGhc
 wr7OqEnAe7R+4hVpCYlpK5w6gJ8wkQXKDRaHHSb7jaWhLGvxFYrx6u9eeYMIXz7AR
 qi8wY54R3osjpdUOLh50wnDvKrM8N9r3zSfGMQNUlpeUap6kvutGck2t58zcpgyZs
 EXJWkugv4y6fxiLWK2BaNfRsq6MFMCjfMqRbEC5H93oISik+e3RyWHurVeQT194ZE
 MTSEn/sqE1lxjsqBRLx3uPELo71p3ceGg1XSGVMfc9H1Q7kY9oMEDIbai/bXGdEBa
 4YID9NdC1GJzjBuaqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1xIx561Hhl-012h8R; Tue, 12
 May 2026 21:05:33 +0200
Date: Tue, 12 May 2026 21:05:29 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_efi=3A_fix_and_test_hi?=
 =?US-ASCII?Q?i_keyboard_layout_pointer_computation?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
References: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
Message-ID: <B11344DB-FD58-478D-A9BD-5081C48116D3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4jVdMXZstCVrAm7MvoIkFH/hiNxD5hRsiILZduPQrLjXvfy4NI3
 ncW5ir0jLH2vVYenCchG+frq8AV2s3pUOqXWPcZyFbkE+t2QLCg2xzsFGPVMAEcvcyZrUWG
 mtN7ypZPFWLvWmCN9fHf1Urmh/1MUiNXFi9iE8BKCxjpsg0Xz/Og5rC4NS3BpZwj7Hq4T7Z
 fDBK9ThZbBVQT9y/3XYJA==
UI-OutboundReport: notjunk:1;M01:P0:zRpPipZ3WcA=;BApgXjM9PwGYzVVlv+FTQKncOdO
 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
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

Am 12=2E Mai 2026 19:40:32 MESZ schrieb "Vincent Stehl=C3=A9" <vincent=2Est=
ehle@arm=2Ecom>:
>- Fix one scaled pointer arithmetic bug in EFI Loader HII implementation=
=2E
>- Enhance the existing EFI HII unit test to catch the bug=2E
>
>The unit test can run on the sandbox with the following command:
>
>  =2E/u-boot -T -c "setenv efi_selftest HII database protocols; \
>		  bootefi selftest"
>
>Signed-off-by: Vincent Stehl=C3=A9 <vincent=2Estehle@arm=2Ecom>
>---
>Vincent Stehl=C3=A9 (2):
>      efi_loader: fix hii keyboard layout pointer computation
>      efi_selftest: test hii keyboard layouts more
>
> lib/efi_loader/efi_hii=2Ec                 |  3 +-
> lib/efi_selftest/efi_selftest_hii=2Ec      | 67 ++++++++++++++++++------=
--------
> lib/efi_selftest/efi_selftest_hii_data=2Ec | 12 ++++++
> 3 files changed, 51 insertions(+), 31 deletions(-)
>---
>base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
>change-id: 20260512-layout-pointer-29d1cd52c070
>
>Best regards,

Hello Vincent,

Off the list:

Did you find any real use for HII protocols in U-Boot except for running t=
he SCT?

Are HII based EFI applications a thing?

Best regards

Heinrich
