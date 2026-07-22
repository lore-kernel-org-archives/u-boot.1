Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC3FC44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88F3580CEA;
	Wed, 22 Jul 2026 06:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmZhruH00wSz; Wed, 22 Jul 2026 06:55:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67E5980DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784703308;
	bh=4L4t+ELgLknTG4s4znPjXBbHqoCZ+SeW0/K4ELSRSqo=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ko74C5ul8fs3s/e7FkiTpXMScIjVYgL+WHVFlzUVf5wAFlMzZ606VmabAjTmebLFZ
	 4gzlptYDL0CBchL1Dw+6u7jIEkk35O2OqmbFBgddp00R2qSlHw2lKG9KWkbku7fqu4
	 UZTNfql2t/PEK8lgmJpRuXdiduoXMrTWoK1ZX/ZM85Y1bAABI1S2UKhU3gE3JP+iop
	 A7iMhPKRn8dvuf4++TdnA/TijGzCGbObyYiweDZrN2SOFqtLtJElTXRiLaASlhkf1v
	 MRcOdsiUWUNGxVyrYY6PyvlC84MLEKKxbEFxrv1/4U8TJflreomD1NLx/MARUzLLuV
	 nVKdVFA4jUeyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67E5980DC2;
	Wed, 22 Jul 2026 06:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C5D1313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 427D5406FC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWvsy2Il_9CZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:55:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2E205405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E205405BF
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E205405BF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:55:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20C184949; Wed, 22 Jul 2026 08:55:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36154803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:55:01 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C665B60A64;
 Wed, 22 Jul 2026 06:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF1C1F000E9;
 Wed, 22 Jul 2026 06:54:58 +0000 (UTC)
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
Subject: Re: [PATCH 0/2] usb: gadget: dwc2: Prepare for UDC core migration
Message-Id: <178470329692.163835.8025542216110715157.b4-ty@b4>
Date: Wed, 22 Jul 2026 08:54:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784703299;
 bh=4L4t+ELgLknTG4s4znPjXBbHqoCZ+SeW0/K4ELSRSqo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=kdN+LsHQwX++9kO1ZFbBuPIFrpTB0/sh7MBkGKTXyvXiWYcXMWquR9sguzEbwltH5
 6+/Su5uX6xMdfp6LcTeoy0rPA9kXmolu2i5Da/TNvFmzDXTptBj40oaSQ4e630ORCD
 vbjoyY5EIJGneuTWr2c0HAIDq0pLQrMmnF4x0diG8IILbGWCNu4HOE3hrVxrHWBMM1
 BWBYk+J42VDoyHgV6zYFKDeCAJPutxd5n6QJeSl2PQ9kW7Tvrk7iAwVU0C9QYi4vq3
 23ETKmDjpe3uhRqpIQ4pnPr+MFsDIHysivsMXoQyKEr4gG5Y5nRQ68e+dy7RNHjInP
 o/BO5rBgLngzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kdN+LsHQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kdN+LsHQ"; 
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

Hi,

On Fri, 03 Jul 2026 15:29:35 +0200, Mattijs Korpershoek wrote:
> Jens Wiklander started to migrate the DWC3 driver to a more recent
> version of linux (v6.16) [1].
> 
> This migration also updates the UDC core and most notably how drivers
> perform their endpoint matching.
> 
> While testing Jens' series on a Khadas VIM3 board, I reported [2] that
> I can no longer bind the fastboot gadget to the dwc2 otg driver.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6f9c431a20627db34e0c41ea865c611f0d2c2016
[2/2] usb: gadget: dwc2: Set endpoint capabilities via .caps field
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c5c4cc4c6b9887858e168d5106f8f1d3dfb6c3e8

--
Mattijs
