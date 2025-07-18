Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F3C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 13:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF69583666;
	Fri, 18 Jul 2025 15:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=radisson97@web.de header.b="nStKAebt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DA083666; Fri, 18 Jul 2025 14:37:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6DF83623
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 14:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Radisson97@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1752842231; x=1753447031; i=radisson97@web.de;
 bh=PUlnWyssJhAl7uXTjZdRRZINyTNLDxanaRye1DWAFrM=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Content-Transfer-Encoding:Date:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nStKAebtXLFjM9ryeicSohPo8Zx2x6BeImxTbfPrprblnayKM1Uck8iH4CDs02n+
 1b7Vpyh2puxhPr8x21N89QrR9JGSlCBO1bHNolV2uUgBkFGGJEa45/zLePa63jPw9
 MOQ/ylmG3HlHy62gb7uu0qomHx4+5jkW8+v1eLRIdv9crEwBdv5k6QJgaL25/xABO
 YCOcnDm0JY4MNT6wAGG/aCWEuToR/y1vac79Gtp1Ba0yUqmxzZAFeCJJSbrbQFLMa
 ADhy2qw7mUcabc9NsQo83oCutGMPqij8oBG4P+i7HHQijJlwqdMUHtEytBUSy+W8b
 cTZVrtOQTFEy2e0+9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [100.64.250.143] ([100.64.250.143]) by
 trinity-msg-rest-webde-webde-live-597dbb6dfc-t47db (via HTTP); Fri, 18 Jul
 2025 12:37:11 +0000
MIME-Version: 1.0
Message-ID: <trinity-2dc0c8ca-3b5f-446c-8236-28aaea7b5e2c-1752842231069@trinity-msg-rest-webde-webde-live-597dbb6dfc-89pk5>
From: Radisson97@web.de
To: u-boot@lists.denx.de
Subject: MLO and crc error
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jul 2025 12:37:11 +0000
X-Priority: 3
X-Provags-ID: V03:K1:FVfCd5vfltukFE9mK19SkqP1kMeJKAdgrSnTQDAuB0wMd/oyvjeRh5yGEd99bC3qZlYCw
 COmoYnM3YbCYS7Q+P1fEyRud0HsO+OzLuGS/p+hIM0hIy6pths8I9JNNINGSRmtXb7Z7AnoDOCq3
 FDw48fpL2J4+fuNQIojmCInwtUXvi2j4RS8gNNY1MpNHgAnstxACdN/2luKStqSadaHzzNKOljre
 7KhseVXKGd2CnBctz1doR2LeKbyb+BBPzPogpXrnXl7BSrGMX6vDHTh1qSpm2YmFTLJgNHmx1eJI
 eYjbh+bKOsAP5Os2tpYtDNWcooGQgEgYpgFL1JNYa9GdrzWoZLUVvI6F4EX8iGa62MU1xxludQWB
 3tWFb87N9Gx
UI-OutboundReport: notjunk:1;M01:P0:mtpP8+S0KGI=;dPLskA3W6//9Utue8UjsZyYJDSB
 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
X-Mailman-Approved-At: Fri, 18 Jul 2025 15:02:47 +0200
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

Hello list,
i am stuck in a porting project=2E The hardware is a AM3703 on a omap3 bas=
ed custom board=2E
The original hw used U-Boot 2013=2E07 but since we need to update, we swit=
ched to uboot 2021=2E01 (complicated background does not matter here)=2EThe=
 stuff is running with the noteable exception of the MLO that keeps spewing=
 CRC errors (but it works, binary from the 2013)=2E

For Uboot we define OMAP_ECC_BCH8_CODE_HW_DETECTION_SW and it works fine=
=2E Booting from MMC we have no problems (but thats not an option)=2E Booti=
ng from NAND only the MLO complains=2E

Our initialization sequence for MLO is:

nand erase=2Epart x-loader
nandecc hw hamming
fatload =E2=80=A6
nand write =E2=80=A6
nandecc hw_bch2

I guess the problem is with changes to nandecc but i have no experience wi=
th uboot to fix that problem and run out of ideas what todo here=2E
Does anyone have an idea ? I even do not know, who exactly is writing the =
CRC error or what is expected=2E
=20
Please, reply directly, as i am not a list member=2E

CU
