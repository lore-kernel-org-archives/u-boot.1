Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A22CFD376
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 18:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EFF83885;
	Sun, 30 Nov 2025 19:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZTC2TrsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AF78389A; Sun, 30 Nov 2025 19:35:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F1C8312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 19:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764527715; x=1765132515; i=xypron.glpk@gmx.de;
 bh=FlIt7Ap/EqB0LtTLmij4xU7ZstajjIzGX4Ki/I4u9+Y=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZTC2TrsMvi42rY0cGlZaV3UMBruL06w9tXUOBDLuRRwdxhRRWp2pYIRouGh8aEmB
 ml4k3Y/rQ6hYYJKCDBhGaoesGh8jHKCF7Up1ImbzIVTl9/0QPi4s/wZU6G29VojYC
 0nrWa9k6mpDv5IfD7TLrasqbnMVMci3RZIpVgYuZrUts6jjz2VADVSZPbin9ICo4n
 0jhaA98FNxcB6miz5DW5Jnhf7Hn6JQXxfbAVgKL3VBsRli9BocCYOB63kHaT1QGBs
 Ogip1A34/z3IKYIY4LX0t4//8DZvMOOY02ZBBD4qKXeSQC1IoHXMZ96cpwPDiH9Bf
 nM0udZ99DpOXmiQMqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1vK2pc1AL5-001lfm; Sun, 30
 Nov 2025 19:35:15 +0100
Date: Sun, 30 Nov 2025 19:35:12 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] configs: starfive: enable wget https
User-Agent: Thunderbird for Android
In-Reply-To: <d9088cf7-07c0-4458-852d-e083fa0aeb8f@freeshell.de>
References: <20251112005451.41285-1-e@freeshell.de>
 <d9088cf7-07c0-4458-852d-e083fa0aeb8f@freeshell.de>
Message-ID: <596F9E2B-C1C1-494E-B229-624627186144@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0um3yxEoTac7kDmyfkSW5ODULoeil2ovteR53o6hsTPmrubFaIs
 iNe23dLzUHDYYqUOLoLmCbvdKTtUuxCwQqZ+k6+OhiZQzvl1rwFf4ZUNozJeyuzOP3o020A
 0HhYgInkBeDsmuC+c41F2HO7unhjPqxcYoskffFS+HZf9G6Ef7dRbllqHi7KQjZ/xZWuzPD
 F5u763XNxraezd5K1vIxQ==
UI-OutboundReport: notjunk:1;M01:P0:GtWnZNWd5vU=;YpSXFEnXpNqkXTn3xi9ot9CqFTS
 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
 mCgrerz1pM8WcVe7iOjzlSLfUavzJbide6SV/E
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

Am 30=2E November 2025 12:00:03 MEZ schrieb E Shattow <e@freeshell=2Ede>:
>Hi to all,
>
>On 11/11/25 16:54, E Shattow wrote:
>> Enable WGET_HTTPS (no CA verification; also enables dependency MBEDTLS_=
LIB)
>>=20
>> Signed-off-by: E Shattow <e@freeshell=2Ede>
>> ---
>>  configs/starfive_visionfive2_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_=
visionfive2_defconfig
>> index fa83ecfa10f=2E=2Ea754134a313 100644
>> --- a/configs/starfive_visionfive2_defconfig
>> +++ b/configs/starfive_visionfive2_defconfig
>> @@ -76,6 +76,7 @@ CONFIG_CMD_PCI=3Dy
>>  CONFIG_CMD_USB=3Dy
>>  CONFIG_CMD_WDT=3Dy
>>  CONFIG_CMD_WGET=3Dy
>> +CONFIG_WGET_HTTPS=3Dy
>>  CONFIG_CMD_BOOTSTAGE=3Dy
>>  CONFIG_OF_BOARD=3Dy
>>  CONFIG_DEVICE_TREE_INCLUDES=3D"starfive-visionfive2-u-boot=2Edtsi"
>> @@ -154,3 +155,4 @@ CONFIG_USB_GADGET=3Dy
>>  # CONFIG_WATCHDOG_AUTOSTART is not set
>>  CONFIG_WDT=3Dy
>>  CONFIG_WDT_STARFIVE=3Dy
>> +CONFIG_MBEDTLS_LIB=3Dy
>>=20
>> base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
>
>If there are no objections then can this then be applied for the 2026=2E0=
1
>release?
>
>-E

With mbedTLS U-Boot pulls in libgcc which on current Ubuntu requires RVA23=
 and leads to crashes on the VF2 board=2E We need to move to using a privat=
e GCC library=2E I am on it=2E

Best regards

Heinrich

Best regards

