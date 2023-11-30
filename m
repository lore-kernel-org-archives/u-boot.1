Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF46EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 22:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F22787625;
	Thu, 30 Nov 2023 23:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="htBL6z6N";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLFMFSjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FF086406; Thu, 30 Nov 2023 23:05:05 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2BE87625
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 23:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 52E863200B24;
 Thu, 30 Nov 2023 17:04:57 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Thu, 30 Nov 2023 17:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1701381896; x=1701468296; bh=Gn
 ohL3SmQHFodKE5xS/3en967CZPADQU/INcXCJi3+w=; b=htBL6z6Nd82wjzlWg9
 q6YAjgOv0v+JQQb98YolZBbocETSVcrG78rYiycOLyxh7Z7q2TrgQIZSateoWTgj
 OjXw8x1KdRi+fHD76vJe6FVQerRFFAA8cFmDcghyOwK4NigzMrpT3/L3V6VwvZWq
 LZjurj2nqgmcvuBdD4QLaemmk5GilNt5kVMudQqXPAiU9am+9wkxEWdF/4m0oFDn
 OYfxDhG0xXBpl25ABdbQhs2k5scmHpaUn0jPcPu3suUgbNfl/uX6nylwEelez7a0
 evLXCJ1QLhXrhHw4/mSoogMtx6t54KK7zZ5PORl473ZaiU6F5Wdxf350HNKRv2ui
 WfOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701381896; x=1701468296; bh=GnohL3SmQHFod
 KE5xS/3en967CZPADQU/INcXCJi3+w=; b=pLFMFSjfsuNUw157a/EbCHJjiIwmh
 SIn3Xe9+2NW49xfjKOxIGS+4UmuD6xjvQoX6iTceseI+4I87adoazKadhxedHNSg
 fzJQuX4hrr8saZ07xr2PtBbXdRqWCERGWvVEGh+FxxajmJy9o88EX6+jgXmlLICY
 rOwP8AgGqnttAnqCW3R0wV+Yo7h16OtKx/ykfTYpnWq+iRQrcGyBaLTk3EBXNMfY
 8XdzfTlHuEt0Gu/QlLaEVHmAE18qtzL0gf1C+p+ZOBmQTD+ZpkMlJOliqGkJmXXB
 qqYUVeeNp6YeCyQxqnEEMUKDqQMJfjAB2h7FDxt7y3alajM60N0nUYSdA==
X-ME-Sender: <xms:CAdpZWtE4Q218BW2SgBvWzTUPjrufE4tPJlznzQqbiubIk2ONzZD0g>
 <xme:CAdpZbdf_HDUqSyK0KDKR9zckahtwLVZYof3Y7dPaOXTpZQk-33WqfcDKTez4JFPI
 _OdyL9OnQmNB-fG6EY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfl
 rghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
 gvrhhnpeevvdfhtddvvddtgffggfeuteduhfeigeevfeffueekheetffekjeehjeefhfei
 tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjse
 hjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:CAdpZRyDh7-8a7wxqJKpTncnip7nca-bOcX1D4-u8_OvAM1piEUVew>
 <xmx:CAdpZRNnMbeF0luI1iTff-UYE5YYX8qeg_5P35N5ByrTtfmsPKe2TA>
 <xmx:CAdpZW-5ax69kSwvsQQHieRPt0qnm9ulSTMdcBpRwj1kiHq-g1Uqqg>
 <xmx:CAdpZYLl5E7TkR-zHU-5AqrImFhrNOkK-sMENpJkS2py92c14VpVRQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 71435364006A; Thu, 30 Nov 2023 17:04:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1238-g6cccb1fa34-fm-20231128.002-g6cccb1fa
MIME-Version: 1.0
Message-Id: <6ff006e0-941d-477a-b3d9-01986d317a04@app.fastmail.com>
In-Reply-To: <87jzpz0y34.fsf@bloch.sibelius.xs4all.nl>
References: <20231130-apple_t602x_extend_memmap-v1-1-cd96b251d2dc@jannau.net>
 <87jzpz0y34.fsf@bloch.sibelius.xs4all.nl>
Date: Thu, 30 Nov 2023 23:04:36 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, trini@konsulko.com, u-boot@lists.denx.de,
 asahi@lists.linux.dev
Subject: Re: [PATCH] arm: apple: t602x: Add missing MMIO regions to memmap
Content-Type: text/plain
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

Hej Mark,

On Thu, Nov 30, 2023, at 21:45, Mark Kettenis wrote:
>> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
>> Date: Thu, 30 Nov 2023 13:42:22 +0100
>> 
>> From: Janne Grunau <j@jannau.net>
>> 
>> The memory maps for Apple's M2 Pro/Max/Ultra left MMIO space out which
>> was not used by any driver at the time. The display out exposed as
>> simple-framebuffer use a power-domain controlled by a device in an
>> unmapped region.
>> Add a map covering this region as well as another MMIO region in the
>> range 0x4'0000'0000 - 0x5'0000'0000. The added regions cover all MMIO
>> annotated in Apple's device tree in this range.
>> 
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>  arch/arm/mach-apple/board.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>
> Hi Janne,
>
> Is there a reason why you can't use a SZ_1G mapping for the blocks
> where you're using a SZ_512M mapping?  With SZ_1G the mapping code
> will use a 1G block descriptor which avoids another level of page
> tables.

no reason except that SZ_512M was sufficient to cover all devices in Apple DT.
Shall I resend the patch?

Janne
