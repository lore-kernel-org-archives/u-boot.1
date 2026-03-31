Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E681109B47B
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C25983DA6;
	Tue, 31 Mar 2026 17:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="A5XqarGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AE584073; Tue, 31 Mar 2026 17:00:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6082083A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774969225; x=1775574025; i=xypron.glpk@gmx.de;
 bh=y/4u9MKVySN8jOsLpP/k2es7NnAmi0hdsRljkNJlgsQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=A5XqarGl6a/sI3XM/waN+BV+cq4bmcFlMDSnEtzLRLkiF/FpV28IhdrdMKUJMhQG
 jRqF80kHQpMa29iJaE3P6tajGY0IDeksURiCwxcMr/CevLJBANrxIrsTR9bBHZafZ
 5WUGUo0KQ3TOIc1IHuw4oqTJvmvMgbQ4Ot9Enjk870++6C/8ATtTbM8Uz3qjjIPAA
 hIf0xEXo77vzyHGQALEWP1ffxaAqn59ntzoRTjt2neoNgsv6GrJPKUj58YMTsXdnA
 X0iOVr4VgzDkptrgepBGFzDgr9xmuAwvIG93km57dRhX1jFN2t9Q9FlUH09lZfjsq
 Vp/pjGEyQPt0QISJLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1w2HPv2TXH-00Ovs2; Tue, 31
 Mar 2026 17:00:24 +0200
Date: Tue, 31 Mar 2026 17:00:20 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
CC: u-boot@lists.denx.de, git@amd.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, Casey Connolly <casey.connolly@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
User-Agent: Thunderbird for Android
In-Reply-To: <20260331142806.GA1235458@bill-the-cat>
References: <cover.1773840306.git.michal.simek@amd.com>
 <20260331142806.GA1235458@bill-the-cat>
Message-ID: <13015773-7580-40DB-A865-3B490FDD183A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E9471ixgHHjTqLCPpeOPUqlsJIcDwU08yVJGSSnqTRX8Ykn/8Qm
 I3RORyahF8dJyDhBUsdIUUC6dbAyfJUkSOrV5nnjGFXB7+TWuflF/W07OkM7MenUNa7CYdP
 ZQFoaxa0K45Xq1xOMmOG8YhtrQ1ECaCsdwAMJ0aiwRUAfukoS7Nh+qrrObwrTgMblGEJj5m
 UodVPflSXB8nZbZcuG66w==
UI-OutboundReport: notjunk:1;M01:P0:lhI8sP1qjso=;N91zyu4S6Ne6BjkD9Gsa0A+2IfM
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

Am 31=2E M=C3=A4rz 2026 16:28:06 MESZ schrieb Tom Rini <trini@konsulko=2Eco=
m>:
>On Wed, Mar 18, 2026 at 02:25:08PM +0100, Michal Simek wrote:
>
>> Hi,
>>=20
>> the whole series is trying to address issues we have on platforms where=
 usb
>> and ufs init are not done before efi initialization=2E This is happenin=
 on
>> platforms where A/B update is enabled=2E FWU code is called early and d=
o EFI
>> initialization before usb and ufs started that's why they are not visib=
le=2E
>>=20
>> We are workarounding it by starting usb/ufs from board file but this sh=
ould
>> be more generic approach=2E

If a block device is created after EFI initialization an event handler cre=
ates an EFI handle=2E

Do have an example for QEMU to reproduce the issue=2E=20

I am on vacation till April 11th=2E But maybe Ilias could  look at it=2E

Best regards

Heinrich


>
>This doesn't build on current next:
>https://source=2Edenx=2Ede/u-boot/u-boot/-/jobs/1416493#L1001
>common/event=2Ec:56:1: error: static assertion failed: "event type_name s=
ize"
>   56 | _Static_assert(ARRAY_SIZE(type_name) =3D=3D EVT_COUNT, "event typ=
e_name size");
>      | ^~~~~~~~~~~~~~
>make[2]: *** [scripts/Makefile=2Ebuild:271: common/event=2Eo] Error 1
>make[1]: *** [Makefile:2201: common] Error 2
>make[1]: *** Waiting for unfinished jobs=2E=2E=2E=2E
>

