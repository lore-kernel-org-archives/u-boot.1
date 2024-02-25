Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C15BC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 15:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E88087DF3;
	Sun, 25 Feb 2024 16:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="kswgjJGS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRiUwQ2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194C187DFF; Sun, 25 Feb 2024 16:31:00 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127BC87DF3
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 16:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 190973200A06;
 Sun, 25 Feb 2024 10:30:56 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sun, 25 Feb 2024 10:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1708875055; x=1708961455; bh=xDvK/vy0Ti
 NGcQ+PSCi4QAwyUHIAx6RfRWAvJMjt7/k=; b=kswgjJGSCus/S3Jg11+kD3i/Tr
 Xr625FysQtHlvRb/XhIHmsmw+ECPuJ+t0JfDWjIHkG+DiXNQUPpPB/ao5dPHLlaQ
 tq5evFEo6GLHAiHIjzqJvSngrykDsYuAK7+fiaXMKrXGcSM4ve09gKZbneL2c4Li
 ANQSjjkLDJHlJalsy5oRKKTFTCB40z00CV6FgzqSRkAJhkfbuZoex96mLloqObey
 D748Xxk2CjEO5X9IBad7uZd/TOmdlDW6Gyx6YWSFp5fKi00V10ZuXJ2PB7sW37ev
 88MlnSee8oFkAIgvwd5jWBV4nj+25reqsXvdAR3uhjTIDzIwaducl9aTNRRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708875055; x=1708961455; bh=xDvK/vy0TiNGcQ+PSCi4QAwyUHIA
 x6RfRWAvJMjt7/k=; b=SRiUwQ2wszdchYHatYJ52cnb64zFdDa5Rlu8JRW2dVSc
 CBnN6DxJmw4uZoV1FEj87Qlrj3GVHPgIs94gTTNgeYsFC+GLcjSPVeXa8Vvye9Ck
 mqZSUYJnE3HJNwioWT5eXScuELeY3nlE6Kpzmj8VlqBXxORnvwmNI4FXZLDTD/cZ
 fYtAyuAY7zflYLHTANs3teMea+vZdQ04j6/y06WZHWIP4fwoirIMiJMTlYQAZte0
 tS4oEVATsZv36EZoo2bunzfVmEH+borfNdD4APoItkNAZLI4h//leAgkkH8izuUP
 1r4qiKAvjtC7745y3SpgLfnsJxynAxmBz2NVZuVuRg==
X-ME-Sender: <xms:L13bZXZ7Dbx3JAYYKSa_2PSaljbEpOk7CpkSWKo7jUJKWpCKeiPsCQ>
 <xme:L13bZWaxZ5uZ-8l8njjLqFFw2ziSDTbdYss3REGBvREkwCTqV6VMD5iOFEuYcWffM
 NTkSJsnzdYZ_DH92V4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedtgdejiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghn
 nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
 hnpeevvdfhtddvvddtgffggfeuteduhfeigeevfeffueekheetffekjeehjeefhfeitden
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrg
 hnnhgruhdrnhgvth
X-ME-Proxy: <xmx:L13bZZ-E8EkC1W2lclN9un4jnqfBfQrg8Sk0ZAwdhpo4Gnn-SAHXlg>
 <xmx:L13bZdq9BvyXWufnVXJy4-UnEHtzb4ka45Cp4IqW02xKEV9QMV8ynA>
 <xmx:L13bZSp2rKrGb1iAK3-Vw2JtdVD4zhwawicyGLPzo4Vw9a_4zE406g>
 <xmx:L13bZZ1efASTN6P_7W_lK7hBgOmxYo8gkItTmi1OVyW5dX7V9zdlGw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 629023640070; Sun, 25 Feb 2024 10:30:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <89f4be04-d26b-4ec9-b476-aed6285ed6d5@app.fastmail.com>
In-Reply-To: <161786f2-cec2-44f3-b8d6-14e78c243e85@denx.de>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-3-814b2e741790@jannau.net>
 <161786f2-cec2-44f3-b8d6-14e78c243e85@denx.de>
Date: Sun, 25 Feb 2024 16:30:35 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Marek Vasut" <marex@denx.de>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
Subject: Re: [PATCH 3/6] usb: xhci: Abort transfers with unallocated rings
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

Hej,

On Wed, Feb 21, 2024, at 13:40, Marek Vasut wrote:
> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>> From: Janne Grunau <j@jannau.net>
>> 
>> Discovered while trying to use the second interface in the USB keyboard
>> driver necessary on Apple USB keyboards.
>> 
>> Signed-off-by: Janne Grunau <j@jannau.net>
>> ---
>>   drivers/usb/host/xhci-ring.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index b60661fe05..4446f5f098 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -685,6 +685,9 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
>>   		reset_ep(udev, ep_index);
>>   
>>   	ring = virt_dev->eps[ep_index].ring;
>> +	if (!ring)
>> +		return -1;
>
> Would it make sense to return e.g. -EINVAL or some other errno ?

Agreed, -EINVAL is good match as ep_index is directly derived from pipe argument.

Janne
