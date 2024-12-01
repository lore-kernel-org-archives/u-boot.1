Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43848D49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68B589589;
	Sun,  1 Dec 2024 19:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lwh1bMgR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eQdgiCYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48D58941D; Sun,  1 Dec 2024 19:59:03 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2852895B1
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y1bmg4sXgz9t2W;
 Sun,  1 Dec 2024 19:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8oF2OR6OqikXP4CXHfBjh/XK8hayDij0y6iZ974Hb4=;
 b=lwh1bMgROFdLg98nCMVRmsr3Ut3dPsDe7t82qzOfVa8u6PJo+0/IjIhNgEYr8wdETbJfYk
 E8K+L2h8AS4QNNx0hRn0FpyJlyfEBXm6ZVRjdTffumj1KHesgA4FI9M9/3EPjWtz84Qznk
 jm00b1wxVm93emFXTSbn22u/ly9sGo7WwdYZOboBiAgpuSdDE33OhaS+z6EUoFL3YmqbuB
 E1JJa2i0pZzbvP1ll2/RYjCIinB/sA50yxrdiI76zOpWRCEGIusiy7fZe/+gKsnTIhOMvD
 Q7ZN16+QrvSHSOjNvWuHDz43gR8jPPuY8BYlBSX7eZ4TJLluT0tJZnOCqo6CUQ==
Message-ID: <ce662fc7-da77-46a3-9f34-081b3377cac4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8oF2OR6OqikXP4CXHfBjh/XK8hayDij0y6iZ974Hb4=;
 b=eQdgiCYHrT8Zqar+3Nk1xc1zv1HwxU4W+rL8HiT+sfpX2U1eCz15vcPB+wcge1RyVDDoD0
 +EC7wGa6pulgV4y7kXp9Mv2K8Mhq+nKZwtCiqe6TP5DyBtx39cj6abEpfKus1kpsEtBoG+
 uMudAxkZBzczL614WtykdLeWuN7NUf3TuZWgZ019zZe1hXwKfxgEo3AAKc2PtAhIO+a90t
 QJbBDrUAwxMfCmNuKUUZEc6r375Q2HJ13Xfpdh1+Ui4eZpYcl4TXnOtQe8fH0ls0ffPiEX
 AZVebxZ1C+02jG+Hc/48LrdEt66GJ1antqgh4yfWwshNkmq3/R7sqP3Rq5ClGg==
Date: Sun, 1 Dec 2024 19:57:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
 <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
 <3cc475db-8546-4855-991c-5e678bef0fef@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3cc475db-8546-4855-991c-5e678bef0fef@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dcddd5156a3ea54b90b
X-MBO-RS-META: bxxjpxq8ta7gg4fp84ciph3uu1fus8pc
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

On 11/25/24 6:23 PM, Quentin Schulz wrote:

[...]

>> @@ -446,6 +474,10 @@ static int ksz9131_config(struct phy_device *phydev)
>>               return ret;
>>       }
>> +    ret = ksz9131_led_errata(phydev);
>> +    if (ret < 0)
>> +        return ret;
>> +
> 
> This seems to work but is happening a bit late.
> 
> Indeed, I need something to call the network stack for this to be 
> happening. Meaning until I e.g. run `dhcp` in the CLI, the LED is still 
> following the bad behavior.
> 
> I assume we cannot use the probe() callback for writing to registers?
I'm afraid there is an inconsistency between U-Boot MAC drivers and when 
they configure the PHY. This is well visible on MX8MP, which has both 
FEC and EQoS/DWMAC MACs and they behave differently in this aspect. The 
question is, whether it makes sense to initialize the PHY before the MAC 
has been used, probably no, because that brings up hardware and adds to 
boot time. But at least aligning the behavior of the various MAC drivers 
would be nice.
