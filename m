Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD3FF6E87
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905B88414B;
	Tue, 17 Mar 2026 23:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="acLNL3rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A96084201; Tue, 17 Mar 2026 18:25:23 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29A284242
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E54310DDA4; Tue, 17 Mar 2026 18:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773768321;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1OBWOqenCDc5cEj/wJrIgfTAaB8h8WFgbTD+skz+vGo=;
 b=acLNL3rtBLGVzTVvaUKsiAMUtrxXHouPlVgOxEpUMimNf353Ot/rCKFdaZvObxoV9OqRMh
 9HBpb/B0oAMVnwhQOECb9pbgaONImJqnhXpcXa7toJUlm7xmG4GozALZDEBep2UMM1UfWY
 LFYxKdkeOaEnigeqTcUIrC3R9322R6ysmTWuwbrMuyHXN/sQer9mKqMDPiN6/oduVjF01e
 m2ushawtz+4RT7UCbTqZznrRDK+VNdXVdBIkFPBKyhT3dVJ6ZbSv4asoHa9SqENfPg97jp
 uP5XwR447zqlVf2YOduFS5O9//VRKdLcsr2aqzI2H6mcEyAm4FpF2N5iy21VKA==
Message-ID: <c993ed73-ff93-4c73-8060-92c0c6e91b4c@nabladev.com>
Date: Tue, 17 Mar 2026 13:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in
 SPL
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <8f6be77bacc6a9abeaf4e9cf6c6f5e01890bc31a.1773648510.git.simona.toaca@nxp.com>
 <ee133e83-8d13-4771-a306-f5f5c2a62b08@nabladev.com>
 <bgv2qs2kotqahuoduagn2pxwvegthjmoy4gnjbzreukwkmo65g@dbvocyanygg3>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <bgv2qs2kotqahuoduagn2pxwvegthjmoy4gnjbzreukwkmo65g@dbvocyanygg3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 23:04:49 +0100
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

On 3/17/26 1:40 PM, Simona Toaca wrote:
> On Mon, Mar 16, 2026 at 01:22:55PM +0100, Marek Vasut wrote:
>> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
>>
>> [...]
>>
>>> +++ b/arch/arm/mach-imx/imx9/qb.c
>>> @@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
>>>    	return 0;
>>>    }
>>> +
>>> +void spl_qb_save(void)
>>> +{
>>> +	int dev = spl_boot_device();
>>> +
>>> +	/* Save QB data on current boot device */
>>> +	if (qb(dev, dev, true))
>>> +		printf("QB save failed\n");
>>> +}
>>
>> Should be in 1/5 ?
>>
> 
> I thought it would make sense that all the SPL-related changes should be in
> a separate patch.

This is a board patch, which modifies common code. That shouldn't be 
happening.

[...]
