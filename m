Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D09C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68994811AC;
	Mon,  2 Jun 2025 21:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H2ZnqNDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0436E8144A; Mon,  2 Jun 2025 21:25:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B8580F9C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748892320; x=1749497120; i=xypron.glpk@gmx.de;
 bh=ThKomgKzFF8grbkRXWl7S71nwsU4ceQG7UEAsP+OYwU=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H2ZnqNDYDViluJTHIoVKy8aSl9/JwtKjxJ4I0IDwwher4bs+fdU/WcJVZZh37n1J
 v91tRt1hcol94kYPRqTfW/QAtVTilMpCABaEyeIBJBDwvWpggc5m1yLA7l0kTq+ZM
 1V6GY5GhD4quUWIhctqVx+0C7PJNc5rsSZD6zN/fKyX88tUC3udPqN7p2MU8gFatl
 niU829LR9ZBqzHtbSFwyb+s3X7EaNZAN7diznI/KjISK5sHpGM1qUPQRruedySf9j
 6Cqh+EVgxmBRU7VjaK0pS2h14/6jseNVCb8PUEyDnNWQOWbCImDOqhOjPvFhLAQc1
 beOe9phOx5kf9fLZZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1vBOSb15Rl-00szYU; Mon, 02
 Jun 2025 21:25:20 +0200
Date: Mon, 02 Jun 2025 21:25:17 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Behrad Elmi <behradelmi1@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: build: fix typo in gcc.rst
User-Agent: Thunderbird for Android
In-Reply-To: <CAFUnUVBZG5eV5f4sypeBrUhgJQGeYiHNKqx18p4N9o2c2_mL8w@mail.gmail.com>
References: <CAFUnUVBZG5eV5f4sypeBrUhgJQGeYiHNKqx18p4N9o2c2_mL8w@mail.gmail.com>
Message-ID: <73E1BE7F-3DBE-4971-A364-45EED7173C8A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KiM4pcvTYSKUX9IO/LskFvR6e2AeEwbf4cxqVw+wYH3iE03lrnY
 BUmDtYiG2Q14CJao+REduIjCgsdDUVRIVilxBZUqf+UaYuOnBhY/s0W+2dVhre6Stpzbsfe
 trTYtLdv/e4stOMXR4x+TqtyDzYd0ITDGbyfrtp2D0yzcIDdkl86XYHdJeI+kB2ZhJNziWf
 JFxp2RrhJjsF5ccpu1+cQ==
UI-OutboundReport: notjunk:1;M01:P0:NowcoSIua5I=;3T858TDJOUAenonGIsDs4h54x+O
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

Am 2=2E Juni 2025 20:57:17 MESZ schrieb Behrad Elmi <behradelmi1@gmail=2Eco=
m>:
>From babe445ec1e08a9bd6d313980371c4b64494ac89 Mon Sep 17 00:00:00 2001
>From: BehradElmi <behradelmi1@gmail=2Ecom>
>Date: Mon, 2 Jun 2025 20:54:16 +0330
>Subject: [PATCH] doc: build: fix typo in gcc=2Erst
>
>Fix a typo error in gcc=2Erst, changing "out-out-tree" to
>"out-of-tree" in the Out-of-tree section=2E
>
>Signed-off-by: BehradElmi <behradelmi1@gmail=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
> doc/build/gcc=2Erst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/doc/build/gcc=2Erst b/doc/build/gcc=2Erst
>index c76a7fbd732=2E=2E1fef718ceec 100644
>--- a/doc/build/gcc=2Erst
>+++ b/doc/build/gcc=2Erst
>@@ -122,7 +122,7 @@ Out-of-tree building
> ~~~~~~~~~~~~~~~~~~~~
>
> By default building is performed locally and the objects are saved in
>the source
>-directory=2E To build out-out-tree use one of the two methods below:
>+directory=2E To build out-of-tree use one of the two methods below:
>
> Add O=3D parameter to the make command line:
>

