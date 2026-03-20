Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DB41093170
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 07:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3E483FE9;
	Sat, 21 Mar 2026 08:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PzILSlea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBA683FC5; Sat, 21 Mar 2026 03:40:43 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BB283D71
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48486108FD3; Sat, 21 Mar 2026 03:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774060839;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zxq7oJwUOXCrEHrglupufneD5OMhMBUSyuxf3DhPynE=;
 b=PzILSleaRSlUSf8j2C51l/9bTl4bwBMWoFR96RM9S01wpPb2J0iZmGwnsAGlNOb4f/4ams
 atIoV0cpIS2TaH1L+e8YbFzfCFeeSPbGYHfMF2lNX1EmGBrNUkZjwZ/5c75QgNLzSjZlII
 gVZCUzM8bhAkpIv8gZ+QXPeilo3z6tIL/bhl1YW5uL4jF9S3gCCoCawu6qBSUpQKeOA1Kp
 mr9FtO5jJeNsuNlnAHgW6nBktvGDJidtXvPvnRKgpcRLtxFgOq434oYP3GCCeZW4wDS0FV
 iE0LSbnXtWs2/N6xL/zYbhqPHQ601Drs3Xh/y4WQAaDVPFvDG6iC5SGwjovRGw==
Message-ID: <e850989d-a82f-4aa5-add2-011670cae56c@nabladev.com>
Date: Fri, 20 Mar 2026 17:29:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
 <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
 <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
 <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
 <7fg7jj4rou4ke7nkewytibvcz3oehxtot4q4apq2uhtz75a2gp@uvpcobhbwu33>
 <a8f0a62a-9b26-46c7-bf5c-edd26bb1f29c@nabladev.com>
 <7ew7523twjd26673q2pezosnhyu2qzf7foywuga7r3hoamqpfb@bm2d4fsbk3ld>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <7ew7523twjd26673q2pezosnhyu2qzf7foywuga7r3hoamqpfb@bm2d4fsbk3ld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 21 Mar 2026 08:11:56 +0100
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

On 3/20/26 4:29 PM, Simona Toaca wrote:

Hello Simona,

>> Consider a device that is trained in factory, at 25C. The training data are
>> saved, and backed up. Then, due to some sort of training data corruption, a
>> slow retraining happens in field at unknown and possibly very high or very
>> low temperature, which could lead to low quality QB data. Worse, the next
>> time the device starts, the conditions can be the exact opposite, very low
>> or very high temperature and the DRAM may start to suffer from bitflips
>> because of that. In this deployment, it is better to use the factory QB data
>> from backup than to rely on the in-field training.
>>
> Low/High temperatures don't generate 'low quality' data, just data
> more suitable for that temperature point. If there are issues with the
> DRAM, one can erase the data themselves, using 'qb erase', to force a
> new training. This way, the data is collected under the current operating
> conditions.

This may be something a developer may do with a singular devkit, but 
this is not something one can do on a fleet of deployed devices.

In deployment, if the device breaks and cannot automatically recover 
itself, it is broken and useless, and that makes users unhappy. If the 
device becomes unstable, e.g. because it was moved from hot environment 
to cold environment which is the normal mode of operation for some of 
the devices, then it is broken, see above.

The solution is simple -- keep factory produced training data around.

> If there are any PHY firmware updates, or changes in DDR configuration,
> performing training again is necessary, cannot use the 'backup' data.

Not all of these devices are connected to the internet, this is not 
applicable.

> If the concern also includes the training time, if the data gets
> corrupted, the training will happen regardless.

This is also not applicable.

> I am not saying it can't be done, I am just saying that for things
> to work the proper way, I encourage the usage of 'qb save/erase',
> as I said in my previous reply.
What I am saying is, that the user should have a way to save QB data to 
arbitrary location of their choosing. If they then decide to restore 
those QB data in OEI because the original QB data were corrupted, that 
is up to them to patch the OEI. But that option should be available to 
the users, because there is a use case for that. And there is a generic 
way to specify the target storage device, at least for block devices.

[...]
