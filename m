Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F18C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 701248755D;
	Sat,  9 Dec 2023 21:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="RlojdZpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0818687695; Sat,  9 Dec 2023 21:37:34 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC128717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1702154250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbKgL5PUHuHQVE1YQmKzzgBTYLV5c3kbBYwZTdAd08o=;
 b=RlojdZpz3OKmGxVfq4y8q8odap0RSlELg9uPbQIrd0cE+VkHEz49o7CYC0KvQOvyxewxXZ
 tWUoMJWWjhUzexjcIdooroSn09FJ6yy1nARtg75tlhHcoaaqTJ764HG5rcsJ8BMl4kU20U
 drIF7Ub25obptOtgLgxIXqh/raEVpGjhTeSJAIOPLODSG7+OATWnM7kvYb+tyU3wQ2GMDg
 HFItLSYChPGeBWwNTS0x06A7JkpLo7pW3qrM/vjPe0okv6R5ZkehJkjgb3mRjrjUpWbmmZ
 nKhPOZGC9OyBn+maV0HjST2MmlLG1LNcECOLHBxjkQDr/3/2EBEhJmUF95wbxg==
Date: Sat, 09 Dec 2023 21:37:28 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, Vignesh R
 <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, Piotr Oniszczuk
 <piotr.oniszczuk@gmail.com>, Bob McChesney <bob@electricworry.net>, Stephen
 Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Add support for zBIT ZB25VQ128
In-Reply-To: <20231209203423.GF2513409@bill-the-cat>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <20231204005954.13201-2-andre.przywara@arm.com>
 <20231206162443.7f0692d7@donnerap.manchester.arm.com>
 <20231209203423.GF2513409@bill-the-cat>
Message-ID: <3c6b3fe41f54a2d2a391d433684e80d9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-09 21:34, Tom Rini wrote:
> On Wed, Dec 06, 2023 at 04:24:43PM +0000, Andre Przywara wrote:
>> On Mon,  4 Dec 2023 00:59:52 +0000
>> Andre Przywara <andre.przywara@arm.com> wrote:
>> 
>> Hi,
>> 
>> > Add support for the zBIT ZB25VQ128 (128M-bit) SPI NOR flash memory chip,
>> > as used on the Xunlong Orange Pi Zero 3 board.
>> 
>> does anyone have any objections against this patch? I wanted to take 
>> this
>> via the sunxi tree, as this blocks some board support patches.
>> 
>> IIUC Linux gave up on adding rather generic entries up for each and 
>> every
>> SPI NOR chip, if there is nothing special about them:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=773bbe1044
>> Should we follow suit here?
> 
> And we could then start trimming the table we do have as well, to
> reclaim space?

In general, yes, but we'd also need to consume a bit more space with the 
additional auto-detection logic.
