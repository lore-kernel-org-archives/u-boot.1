Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53636C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F23B86F80;
	Sun, 19 Nov 2023 21:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NaodVPRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEAD886F44; Sun, 19 Nov 2023 21:06:44 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F90687208
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SYM9B4DxNz9sQm;
 Sun, 19 Nov 2023 21:06:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVmCmWRoaFuEX4ENoUjBgAdozRCQlOhoyKKwzBg1DZI=;
 b=NaodVPReRHcMRELtRsW7lv3R9fsbqUpIxMyQnmojwdt5QqutG1KI+PzSpyNEinUwJv+nv5
 Gr6GupcBIr6f4YfpWo3UEJ6JRT0o1oYtsTGbs71YQpK680WySBbeXrSILNbPJR/YKiOCcD
 JKpPpiKUaaqRROlWp6mFynBo+ilgTYha2KGeB/NFMLOiAWsiJxKULQJKg72Y49Z4rTuLXZ
 TeoISD7piKpwRUuuIYMQy3KxzwayNIy6qrLX6cCnNwgCESazo7++gaNkZg2P7rCM5rRKkf
 ugbW8C5lde+ESKWzF0NoC7VpMfWb8rg7p7EMACmf5/1zqGy6C20zv4zhb4xWFg==
Message-ID: <fa5775e7-c9a3-488d-a023-af3508d4481f@mailbox.org>
Date: Sun, 19 Nov 2023 21:06:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm: rmobile: rzg2_beacon: Auto select Linux device
 tree by SoC
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com
References: <20231025231311.8701-1-aford173@gmail.com>
 <20231025231311.8701-3-aford173@gmail.com>
 <917ce30e-d737-4881-92ec-4da29e1cb8ad@denx.de>
 <CAHCN7xL9S8QxUL96L2+j5GOV_9Ka1D7=J-ROVbjF2HYuHYXmxg@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xL9S8QxUL96L2+j5GOV_9Ka1D7=J-ROVbjF2HYuHYXmxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dgrxn1obwdog1h3acnxmd9nadap3ainr
X-MBO-RS-ID: 1ee223b152c30a1a5c8
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

On 10/27/23 04:12, Adam Ford wrote:
> On Thu, Oct 26, 2023 at 8:44 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/26/23 01:13, Adam Ford wrote:
>>> There is a function inside the board file to autodetect which device
>>> tree is needed by U-Boot to properly load its own device tree, but
>>> it currently defaults to always loading RZ/G2M for Linux.  This is
>>> not correct for other SoC variants.  Add board_late_init function
>>> to query the SoC name and use that to determine which device tree
>>> is loaded for booting Linux.
>>
>> Can't this be scripted in environment instead ?
> 
> Do you have a recommendation for how to read the SoC type from a script?

If you want to read PRR from script:

$ setexpr prrcontent *0xFFF00044
$ printenv prrcontent

