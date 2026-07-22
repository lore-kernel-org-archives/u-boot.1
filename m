Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEECEC4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A25C80DC2;
	Wed, 22 Jul 2026 07:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzS1ohPJePTD; Wed, 22 Jul 2026 07:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A73680DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784703754;
	bh=3M8lb4d7qzGuBIqdflc+K7O/anV2xrq/tEcE8VAoEis=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OaRrnlGquR9xbAmkPtPz/tDkpplf09vf7CSOzWXX/9BOQbR5ALvMFP9PzbTTGLGuJ
	 bwspuDnIQsfFnKNMXBAz+zOJ+wWyR542MswTSImrVgoh0lOOZsitOK2B+qE/WCWUfK
	 qPMQ2SlofCT9qaAzFeG3EwkcMzTF9lkYsH6IX84PH8pmnqFlQTpMkj94G0mXcTz5Hy
	 WYcJWq2E59i29T21Btf9H1AkfsVwge/EonCMefPzYz4oasaMd8owbXhTf5yvFOjE4Z
	 +VikjBOUHrBkR5IVFPp5tZulRdTMFaKAtZGL/PuFsMjJyAPDNI9OAn0ksSFzaI56qy
	 Q81m+6t0m+Vqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A73680DB3;
	Wed, 22 Jul 2026 07:02:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C215D9E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A871A400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buoe1cCwI_3P for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:02:31 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3AFC1400F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AFC1400F3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AFC1400F3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:02:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E4C848BA; Wed, 22 Jul 2026 09:02:29 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A94C803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:02:27 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D854E404EA;
 Wed, 22 Jul 2026 07:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B41F000E9;
 Wed, 22 Jul 2026 07:02:24 +0000 (UTC)
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@nabladev.com>, Tom
 Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 0/2] usb: gadget: dwc2: Prepare for UDC core migration
In-Reply-To: <178470329692.163835.8025542216110715157.b4-ty@b4>
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
 <178470329692.163835.8025542216110715157.b4-ty@b4>
Date: Wed, 22 Jul 2026 09:02:23 +0200
Message-ID: <87mrvjik1s.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784703745;
 bh=3M8lb4d7qzGuBIqdflc+K7O/anV2xrq/tEcE8VAoEis=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cOwWftJ7Az83NMoIXX/IDlCAmUQQ0kpWeqI6D9x+MrvvcOwzJv8jzzMNSCbOFvxR3
 /C5Cn6UbSS0BMXY0hefdBeFgp9BBClpP09jSBSktsyuzNKy6bM+Edj3YTE7IZv2TD8
 yDzd3r6sRpiTM77raJ+nYl1SXZVlvSQ7SMeKaxt/3OZLMBT/oQXHPARpxLNkVLr/5r
 Jb4ta5Ucfs89WbA8LntsiOhAiWLkdTKwX17ijAz5DrY296lJMyv+p79sxqK8s1Z6LJ
 APL72jCTK+BbKni96535Mm+bO/+xFxw4ofHaVsKuK34CGkI0e5/cp3EqW2jR4+SCsC
 X/4NttbHDEDqw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cOwWftJ7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="cOwWftJ7"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 22, 2026 at 08:54, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi,
>
> On Fri, 03 Jul 2026 15:29:35 +0200, Mattijs Korpershoek wrote:
>> Jens Wiklander started to migrate the DWC3 driver to a more recent
>> version of linux (v6.16) [1].
>> 
>> This migration also updates the UDC core and most notably how drivers
>> perform their endpoint matching.
>> 
>> While testing Jens' series on a Khadas VIM3 board, I reported [2] that
>> I can no longer bind the fastboot gadget to the dwc2 otg driver.
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/2] usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6f9c431a20627db34e0c41ea865c611f0d2c2016
> [2/2] usb: gadget: dwc2: Set endpoint capabilities via .caps field
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c5c4cc4c6b9887858e168d5106f8f1d3dfb6c3e8

Err, my automation is not up to date.
I can confirm the patches have been applied to the new u-boot location:

https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6f9c431a20627db34e0c41ea865c611f0d2c2016
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c5c4cc4c6b9887858e168d5106f8f1d3dfb6c3e8

>
> --
> Mattijs
