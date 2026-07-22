Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430E0C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE53C40708;
	Wed, 22 Jul 2026 07:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOKOS1_pb_10; Wed, 22 Jul 2026 07:07:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7FF3406F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784704035;
	bh=BzK1PRh2TaxChJ5pcBkmyHqCoNDclObIJYjqvZcqAC8=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RJ06rpYsiNiO29gk+9RlvDGWbNZ4EDtWKmiuueuQ08iE4ETKZF/Aej1+I4abcdOlm
	 b2q3zzsKB5L9+1FZbm/oZsq+KZo++iMflZvKvJRQDf0U0BxEm2R/RFe1OaBYQUADbQ
	 +1Li2bnnaV0y/nEPox+yfu01rG6mQoe84EZlhpRzwguLSX+KutR2AQ85S57UQwaFFC
	 X9A4DgMsDbbCb35Qz9WidGL3CZ8i7p+/ysRM6cGGNVMvaWfqZT/idpCbiGEMxLZR4o
	 N+VwNv+P9vfCzakedQ/NSNsnIBAFzUilGEXmttxdzu1njV5BiKyok+RaejbxBvN6UR
	 GGnoz+6ZN4pNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7FF3406F6;
	Wed, 22 Jul 2026 07:07:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 819E4313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E88180CC8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUqQ1Id0xNqC for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:07:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 776D580C9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 776D580C9D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 776D580C9D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:07:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA0D848BA; Wed, 22 Jul 2026 09:07:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F6A803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:07:09 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F389D42ADE;
 Wed, 22 Jul 2026 07:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B01F00A3A;
 Wed, 22 Jul 2026 07:07:07 +0000 (UTC)
To: Safae Ouajih <souajih@baylibre.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] boot: android: fix out-of-bounds access in bootconfig
 parsing
In-Reply-To: <178470329989.163835.6163607000590154751.b4-ty@b4>
References: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
 <178470329989.163835.6163607000590154751.b4-ty@b4>
Date: Wed, 22 Jul 2026 09:07:04 +0200
Message-ID: <87jyqnijtz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784704027;
 bh=BzK1PRh2TaxChJ5pcBkmyHqCoNDclObIJYjqvZcqAC8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=BSr2VLd2Kz6vU2Y+IuakaJuKTWU/HkT6YnhAVCSxT0yePD742b0M383fN2oySmnqt
 VS6PiGBqoUjYDFu+LBAG8HmJddn3bn+Gq19vJSINb2JTI5HpTY2x4h1rruetljQw1J
 PFKLvCn8zFAZvTC2gY76nVQIQwh5duovLwI4NisNy2IrOfrS0SQnrbipOcNMRQ7DVh
 Ow7kqgNOkOrD4ie0EWvphRkM9hxbVZ4boP1l5EWsYKY2gp/YkyhpBIWYUK+jHOSN7x
 jDQRX7ae25Xiq9htZDPV+qA9RBa2XGNDruoMkkDBDzlnjYUvE2PGHh9i9YxmEKFUpo
 5kZqlKsKSeXiQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BSr2VLd2
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSr2VLd2"; 
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

On Wed, Jul 22, 2026 at 08:54, Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org> wrote:

> Hi,
>
> On Wed, 08 Jul 2026 21:32:07 +0400, Alexey Charkov wrote:
>> When android_image_get_vendor_bootimg_size is called, its buffer is only
>> allocated with enough space for the bootconfig header, but the
>> android_vendor_boot_image_v3_v4_parse_hdr helper attempts to append a
>> bootconfig trailer to it, causing an out-of-bounds access and heap
>> corruption in some cases (e.g. triggered in sandbox test builds when
>> extra bootmeths are added, resulting in a segfault of the sandbox
>> process).
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/1] boot: android: fix out-of-bounds access in bootconfig parsing
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ee3ab6988860d568b0ba0b568e57335cca2809d4

Also applied to new location:

https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/ee3ab6988860d568b0ba0b568e57335cca2809d4

>
> --
> Mattijs
