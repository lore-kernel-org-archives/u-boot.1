Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB3CC9EC95
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E4E838A5;
	Mon, 12 Jan 2026 15:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gDu2okxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2021C83885; Mon, 12 Jan 2026 15:39:16 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE12F8391B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dqZl34wkkz9str;
 Mon, 12 Jan 2026 15:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768228751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvmmae60+A20OSVeAqkaGBV/HKjjRxV5broLo+N0Qps=;
 b=gDu2okxXv79rPHmdlpzxoBkmoIT0qoWwqZ0tjLoq1yn8swuUm9ypXPWjdcHJ+u2gHGo7E0
 6vtXJc1owWzz9HhAHacSCpvfpUKYiwQDqcJmRZI1zFoVu/FV06lU37MSuv2bjWcghquqDi
 WDhPAZW53EcphiIFphUdbD/TZKy2QCp5uUOOmSMv2Rap80Sty58v0dJlBj28w1PFbe0v4C
 6/10JrwQtsVciuQZTupELH/ElWYWNXLrjaljvBPUVd4U7AA4UzKd16p6+IpIFFIdEyT8l+
 hMfsfiPtXkBnZBjmxERTcXSNbkcPs72wQW+/obGt+7TXx2KdavED6NnDP+72AA==
Message-ID: <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
Date: Mon, 12 Jan 2026 15:39:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Beleswar Padhi <b-padhi@ti.com>, trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260112101102.1417970-2-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: n6ymg6zkzywsg4b5xexf1ntuqyx5qyr7
X-MBO-RS-ID: 4bcbbdc89c76d5537bc
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

On 1/12/26 11:11 AM, Beleswar Padhi wrote:
> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.

Because DT properties are 4-byte aligned, and fitImage is a DT with long 
binary strings encoded in them. But that is not the case here, because 
the invocation does use mkimage -E .

Therefore I see two issues:
- Should the code which handles LEGACY fitImages with 4-byte alignment 
be fixed to relocate the blobs ? I think yes.
- Should mkimage -E align blobs to 8 bytes by default ? I think yes, and 
frankly, I thought it does so already, but apparently not.
