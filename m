Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E31C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 02:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E395187B44;
	Tue, 23 Jan 2024 03:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="Hd/eU0ui";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKuv4jPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E02879F6; Tue, 23 Jan 2024 03:20:54 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2E687707
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 03:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id E47875C038B;
 Mon, 22 Jan 2024 21:20:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 22 Jan 2024 21:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1705976448; x=1706062848; bh=raEvyfonb+xtVTJ1uD3sM9B0GQgo8qwV
 fX5DHCBj/20=; b=Hd/eU0uilaVfdFLEjI9aJaNl3g+ZMYqT94w09vsMVvMRp4ef
 TYW767mhfZE7+0MNXFC9XZQKRQ4GqciFn0wZ4JMXVbFZ8nevX1oShOuTyRJjU0xO
 bRJ2b3IGiAyy6SjPGd1cZM3TeXCWPirxZuZaUFsB+5PmXNvvi0Lt0JT1LhdAO+aC
 YPZp91GYbGeoLoI46XrOxXc3HHtTwKR9rFyN8CG0q+Ji4Vagk3h/1Z3v0NyEFMG+
 fJMKmgIBifpuyHloWh+CiwTPf074sJ1Cn1rNfMTyqqCqI731nx32UfsjdFQEMPj6
 FF6hl7Bq5dhPdETBgfom9i/i5Aqs8tkq5LVppQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705976448; x=
 1706062848; bh=raEvyfonb+xtVTJ1uD3sM9B0GQgo8qwVfX5DHCBj/20=; b=C
 Kuv4jPw45oO4RoRIhycuf94iVLtuI4Zm1vynoBmDoj/staIVAyxFQTNd6Qbn/F1O
 8Ln8tw8mtSKgdssV0Hvyx845L3PzHlCGCt2L0fdX7il3AEfcikNktrZpCP3ulU4B
 VRkMXrI+n1z1n3qoTq/kRENZ0pV2z7hrFMKiOrxxS2ovqURMYjmCDrpgKTT5s6Da
 G9N0HEeUI93dDtclucdfo1hlduu5PodcrG51EJuMRJUf2W6suecLM3wH0wIIFFiX
 4ybORgg8ex9gcmpYM20St6/isg+D3YumXNHw8rCccO2b9wgsgPmtu3Cqc3MUHiKT
 1HfRbEDdcOfxUlVKdh99g==
X-ME-Sender: <xms:gCKvZeSp9bSFqPZQAv4QFfc8g-2jg858DQs5P_hKIA9TsqDwxfWRkA>
 <xme:gCKvZTxKYmGMk0isSlND4XyxT3JW76yLFj9wLtVHOB4iiuOQQ0fGQm_37YB-vFN7r
 ZK1_jRepA>
X-ME-Received: <xmr:gCKvZb3bOzTXSsmTdoZuIdSlDbQ3FhR2TULvZ3IDMmPbTm3PGU5S89360MX40hgZDc3EbQ723pqJ2zlBr7v4yXTuZAIPFmACupPaVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
 ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
 hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
 esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:gCKvZaDJB8LPoPCc6t62_Q4ADamymRoUhVODh_f5hdM9cm9VdoQz9A>
 <xmx:gCKvZXhdOnhC-vpAukwDfHq1zp9m5ryX46PCQgYTg1HgW6-AwOYGBA>
 <xmx:gCKvZWo4WlxnPzaaKiuNF3t6zSgFWRtNxd0IgWcgUjdcxltLMGbDTw>
 <xmx:gCKvZXcOWeO7MDqVCuaOdwNuRnVQYNpckhNPiR0sSLwIGLVVIP5FUQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 21:20:45 -0500 (EST)
Message-ID: <86fdbd38-7263-4a56-8191-e422ede98ee0@feathertop.org>
Date: Tue, 23 Jan 2024 13:20:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] board: rockchip: Add Sonoff iHost board
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240122124603.3341988-1-tim@feathertop.org>
 <20240122124603.3341988-4-tim@feathertop.org>
 <20240122153621.GK3652023@bill-the-cat>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240122153621.GK3652023@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

On 1/23/24 02:36, Tom Rini wrote:
> On Mon, Jan 22, 2024 at 11:46:01PM +1100, Tim Lunn wrote:
>
>> Sonoff iHost is gateway device designed to provide a Smart Home Hub,
>> it is based on Rockchip RV1126. There is also a version with 2GB RAM
>> based off the RV1109 dual core SoC however this works with the same
>> config as the RV1126 for uboot purposes.
> [snip]
>> diff --git a/include/configs/sonoff-ihost.h b/include/configs/sonoff-ihost.h
>> new file mode 100644
>> index 0000000000..8ed5d78687
>> --- /dev/null
>> +++ b/include/configs/sonoff-ihost.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +
>> +#ifndef __SONOFF_IHOST_H
>> +#define __SONOFF_IHOST_H
>> +
>> +#define ROCKCHIP_DEVICE_SETTINGS \
>> +		"stdout=serial\0" \
>> +		"stderr=serial\0"
>> +
>> +#include <configs/rv1126_common.h>
>> +
>> +#undef BOOT_TARGET_DEVICES
>> +
>> +#define BOOT_TARGET_DEVICES(func) \
>> +	func(MMC, mmc, 0) \
>> +	func(MMC, mmc, 1)
>> +
>> +#endif /*  __SONOFF_IHOST_H */
> We should be using standard boot, which removes most of this, thanks.
Thanks for the tip, I will check this out and fix for v2.

Regards
    Tim
>
