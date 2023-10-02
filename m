Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23ECE784A4
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 08:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C16870E3;
	Mon,  2 Oct 2023 10:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Pol7UUSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335EE87128; Mon,  2 Oct 2023 10:33:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6211870DC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 10:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696235597;
 bh=Ik/FU/uSmM2DB2ceqcwAlEkI9YW8+mFalxlwfjU0OHw=;
 b=Pol7UUSvTs6q16X4+vP1/F15+1D6bvnRk8MWrroC8jfYmDFKidCwGsplZRpbPz+nxHAxuxvom
 +TYXSs0gCf8dPc9eFIxbLeAY9d9SonJtnLgjLVx0KaiOiOPdcHN4DT2GzwlkayCyaEhcmQcy+Pr
 +M2xkykdj25Or2LjZnGQunNUbWPH/PZN8Wjeky3zHiFAd6qTd0nRiIiK4ANjl0G7v0iT/EFDHWb
 lhcuTFesOaiqScZAHpILaLUvJMX49J9w9iggEYX3I7xL1QfulTkB4nEBjPuceImuTBosMEleLcH
 6YJA9yBe5wsZi6On45uUjCmOfTc4JVv00e8f23zz8owQ==
Message-ID: <3e3de175-33f3-1fc8-3406-4a3ee4db8830@kwiboo.se>
Date: Mon, 2 Oct 2023 10:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Aw: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe
 bifurcation
To: Frank Wunderlich <frank-w@public-files.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jon Lin <jon.lin@rock-chips.com>, FUKAUMI
 Naoki <naoki@radxa.com>, John Clark <inindev@gmail.com>,
 u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
 <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
 <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
 <20231001191150.pydmtyqg4wtbri5k@mercury.elektranox.org>
 <trinity-b84ddad3-528c-4117-8726-f211e21a42f6-1696231041552@3c-app-gmx-bap51>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <trinity-b84ddad3-528c-4117-8726-f211e21a42f6-1696231041552@3c-app-gmx-bap51>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 651a804ccafb75b6837295be
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

Hi Frank,

On 2023-10-02 09:17, Frank Wunderlich wrote:
> Hi,
> 
>> Gesendet: Sonntag, 01. Oktober 2023 um 21:11 Uhr
>> Von: "Sebastian Reichel" <sebastian.reichel@collabora.com>
>> An: "Jonas Karlman" <jonas@kwiboo.se>
>> Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Eugen Hristev" <eugen.hristev@collabora.com>, "Jon Lin" <jon.lin@rock-chips.com>, "FUKAUMI Naoki" <naoki@radxa.com>, "John Clark" <inindev@gmail.com>, u-boot@lists.denx.de
>> Betreff: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
>>
>> Hi,
>>
>> On Wed, Sep 27, 2023 at 06:07:59PM +0000, Jonas Karlman wrote:
>>> Above works with this series in U-Boot and also in mainline linux. Not
>>> sure the RK3588 bifurcation part of driver have been verified on real HW,
>>> rk3588 boards available for testing have typicality not used bifurcation.
>>
>> Upstream kernel bifurcation code looks ok to me. It's quite different
>> from Rockchip vendor implementation, which might have confused Kever.
>> I also missed this when having a quick look initially. As you said
>> Rock 5A, Rock 5B and EVB1 do not use bifurcation, so no testing happened
>> on our side.
> 
> my Bananapi R2Pro (rk3568) uses bifurcation and it is working in mainline Linux, but not yet in uboot.

The issue on your Bananapi R2Pro is most likely not related to the
pcie bifurcation code added in this series.

The coded added in this series works same/very similar as on mainline
linux and fixes bifurcation use on devices such as Radxa E25 and NanoPi
R5C/R5S.

Please clarify if pcie work in mainline linux when booting with mainline
u-boot, or does it only work when booting with vendor u-boot? (in case
vendor u-boot set different/default pinconf).

> 
> posted my test-results here:
> https://patchwork.ozlabs.org/project/uboot/patch/20230918173624.31464-1-linux@fw-web.de/#3183519

From your pci enum command I only see an expected pcie@fe270000 (ngff)
link fail. Does it also print out link fail for pcie@fe280000 (minipcie)?

If not, try running "pci 1" and "pci 2" after an initial "pci enum" to
see if the root complex and your minipcie device is detected.

Regards,
Jonas

> 
> regards Frank
> 
> 

