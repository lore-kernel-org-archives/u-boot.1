Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC34ED5B840
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 01:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C64389124;
	Tue, 29 Oct 2024 02:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L7i5/fhr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nLrNifXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFCE88C3E; Tue, 29 Oct 2024 02:44:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C778B89126
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 02:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XctMt3XrQz9slN;
 Tue, 29 Oct 2024 02:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730166250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asz/WGYm3fFP+Si5bnH+mPp4+k5OFXdvBt5Df7Aa3tQ=;
 b=L7i5/fhr/HH19XNk+eHJUAD21yp8NykBvSHvpaaTBCBM37QeV0eskUfJj2G/bLIPZCwLrE
 QRegezRImeDzqGyE9pu9K/5AjiZVMTEwvieEKgmJuJNDJ1FDN4snjcCUpobYtl7jyL7Uj/
 ncrX6kL+l8JLRm5/SWBZTEhiPRVHIxv1JCpFXqckGMWDLNFebk+uWHGMy87/1/InLb1oXn
 giXC4bv8zP1Ztg5eBPG+DFK7j1h1e2Dg/nRqqFvW0yGOfdXLvQrJfjmYmBo/wpEssYtC1w
 sJcRstMEk0gNmYmki6twZQYtz8Xxjnty6RRViFuci4QDPM3+ZcU0TrP7uFq7Nw==
Message-ID: <169d92a0-eaf8-41ca-87e1-05db60a2a9e8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730166248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asz/WGYm3fFP+Si5bnH+mPp4+k5OFXdvBt5Df7Aa3tQ=;
 b=nLrNifXGmYONX7ZxtbSlFtetkrpKIBGZ+BkRFS3GoHqknr16NI3vd3ZwyWQURPbCms2Qwv
 vYV1iQls6O6SEn59msJWmoZ3LcRQIFlz7zDah3RXjS8Q2RAo0jSEur2jdh4eIY2FZxJ2Es
 E1/rBOlyaQYhUHuf6dynLxQvBWPuSKECSrl7dfWDkzYuNsMUbtf6M3+7039K/NAPK4ZjCK
 4bWMks4+RjHwItkGl7UWByBaPxnDpVf7nx68bSdyTDwfn6O8V1ngNjSptn34PYuO08tlIc
 3xtt46kjuaek2/gtgRyqSlQnTy0D3ZaExq+7OHQA5XnMYbBdPaZ5qTPvkppQ6w==
Date: Tue, 29 Oct 2024 02:44:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
To: Jaehoon Chung <jh80.chung@samsung.com>,
 'Paul Barker' <paul.barker.ct@bp.renesas.com>,
 'Nobuhiro Iwamatsu' <iwamatsu@nigauri.org>,
 'Marek Vasut' <marek.vasut+renesas@mailbox.org>,
 'Peng Fan' <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
References: <20241023105319.334-1-paul.barker.ct@bp.renesas.com>
 <CGME20241027163220epcas1p450e4c0dd3bf0fd840c433e128b6d2447@epcas1p4.samsung.com>
 <1aa8a914-dbd6-429a-a6ad-1c3753cad9c5@mailbox.org>
 <122401db2982$0c2c51c0$2484f540$@samsung.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <122401db2982$0c2c51c0$2484f540$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ufcdwjzidm6weikkjqzzfgagup9f1ixq
X-MBO-RS-ID: 03497049229a9e87dac
X-Rspamd-Queue-Id: 4XctMt3XrQz9slN
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

On 10/28/24 10:40 PM, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: Monday, October 28, 2024 1:31 AM
>> To: Paul Barker <paul.barker.ct@bp.renesas.com>; Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; Marek Vasut
>> <marek.vasut+renesas@mailbox.org>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: u-boot@lists.denx.de
>> Subject: Re: [PATCH v2] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
>>
>> On 10/23/24 12:53 PM, Paul Barker wrote:
>>> After the recent dts/upstream subtree merge, the sdhi compatible string
>>> used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
>>> not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
>>> and SD card devices on RZ/G2L boards.
>>>
>>> Fix this by adding the new compatible string to the sdhi driver.
>>>
>>> Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
>>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>> Changes v1->v2:
>>>     - Moved new entry after "renesas,rcar-gen4-sdhi".
>>>     - Added Reviewed-by tags.
>>>
>>>    drivers/mmc/renesas-sdhi.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
>>> index 23db2a75c444..92afa6adcdac 100644
>>> --- a/drivers/mmc/renesas-sdhi.c
>>> +++ b/drivers/mmc/renesas-sdhi.c
>>> @@ -864,6 +864,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
>>>    	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
>>>    	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
>>>    	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
>>> +	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
>>>    	{ /* sentinel */ }
>>>    };
>> I can take this via sh tree if that's OK with you ?
> 
> If you're asking me, I'm ok.
All right, thank you, I included the patch in current SH PR.
