Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5ADC5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84EF040F6C;
	Fri, 21 Aug 2026 13:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1mqgsItIIMW; Fri, 21 Aug 2026 13:16:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318180;
	bh=oUX8Qa5GaaBPrcF+48PW/F9FY0sCMoVfogaoHl0KhGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zpAadZ0oXAM9WB1LxT6fRrGifP1jiU7RYTOK/SbYhnCOuXpd6Nu1a60VeHZjQ2BTP
	 cMVzFRMEAhawJDbuo2izfoUwJVP8IRKRm+VYOkD+Vb0GR26jn7n5VRlAQDsUv0j9at
	 WMe2js7RErjiAtrkPzMRbmjeCdZDBigbsevrwxfNPcl/tGXH4bwntWuB3sliSDOHzA
	 Y/x7EtBtj/xnCMvqWoXby7jVl1a7w5TOENxqKakX4M/5AO++McVbRZxXma2WCe/EGX
	 KgmmSQwJpKGd2AeluHN1n/OQvrnApDR7Aa8Sx6823A7Shli0YurJeP6In4yXK3383G
	 FkkC7E4q3RLrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 614B340E6D;
	Fri, 21 Aug 2026 13:16:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC63D29B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE2C1408AD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNofLknzrF9M for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 12:21:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=132.204.25.50;
 helo=mailscanner.iro.umontreal.ca; envelope-from=monnier@iro.umontreal.ca;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca
 header.a=rsa-sha256 header.s=mail header.b=E3scE2xt
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1E0B408BC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 12:21:43 +0000 (UTC)
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 60E80802F9;
 Fri, 21 Aug 2026 08:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1787314898;
 bh=zbNiTbctDElauB8o5NY7kJL+Ea8qtMywar2VczjbajY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=E3scE2xt1XCxZ0WxoVcG7Io9u90KhyB0bEx6iicnWbPflC5KhhaXGWZdqisrkLuIm
 ZhjLkF4r28SV1ctEpkcY/ZKwgaquIBPhaPUFf5kkMxUYvcqJPfk8+zZ5CfUmSfNHmY
 qwAr+3oSn7sTYIIGkjHlCXMrLoHLOX3HwHJU+/24W0I5VkEr8AoXTKvlk5sAB05j12
 51/dXlU2wnpc7NmyiDzRZyJoCKNE4VjTe/eIHikes8jwPBEY7AgNsiuXi3QojUvA+D
 xuOfRyY3xLXIpsQ1ZyUUQ+qfX0gpIcXrxRxeFQh3iHnRUNmqycq34ZjBUluELEW/Nn
 Ju3E3yMrYed4Q==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id B002780216;
 Fri, 21 Aug 2026 08:21:38 -0400 (EDT)
Received: from pastel (104-195-211-127.cpe.teksavvy.com [104.195.211.127])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 6AD0E120497;
 Fri, 21 Aug 2026 08:21:38 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: "Carlo Caione" <ccaione@baylibre.com>
Cc: <u-boot@lists.u-boot-project.org>,  "Jonas Karlman" <jonas@kwiboo.se>,
 "E Shattow" <e@freeshell.de>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
In-Reply-To: <DKUFJ6TTK7AW.2VKPRV8CRQ70V@baylibre.com>
Message-ID: <jwva4qf7kuq.fsf-monnier+Inbox@gnu.org>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
 <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <DKUFJ6TTK7AW.2VKPRV8CRQ70V@baylibre.com>
Date: Fri, 21 Aug 2026 08:21:30 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Carlo Caione [2026-08-21 09:05:37] wrote:
> It is possible to include U-Boot proper in the host-loaded bootstrap
> and use its existing fastboot implementation. That is a valid approach
> and is preferable where the Boot ROM download limit and memory budget
> allow it.

Right, that's the situation I'm familiar with.

> But it is not always possible: some platforms (like the one we are
> enabling) impose a strict size limit on the bootstrap, or only provide
> enough early memory for the DDR initialization code and (small)
> SPL-sized payload.

I associate "fastboot" with the Android nebula, so I find it hard to
imagine a machine with enough resources to run Android yet with a small
enough boot memory for U-Boot not to fit into it.  I assume the SPL is
pre-installed in some dedicated boot memory (SPI NOR?) whereas the main
storage is left uninitialized during production.  And the NOR flash is
so small that it can't even accommodate a proper U-Boot?

I wonder how many cents it saves the manufacturer (e.g. compared to
having a slightly bigger NOR, or not having the NOR at all and
pre-installing U-Boot on the main storage) =F0=9F=99=81

Anyway, this is clearly getting offtopic.  Thanks for the answer.


=3D=3D=3D Stefan

