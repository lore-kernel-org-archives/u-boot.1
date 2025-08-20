Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ED8CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 08:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9008211F;
	Wed, 20 Aug 2025 10:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FqB2X0Up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36E782B07; Wed, 20 Aug 2025 10:57:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6719B80FA1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 10:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c6L1S1nnnz9tqy;
 Wed, 20 Aug 2025 10:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755680236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEEq4BNNIyWK1s8+LJxS/eh8oY/lxwz43vzUQYD5fzI=;
 b=FqB2X0UpLObl7+IGr+r44K7OSL345y9G4Jpd2MT+3CKQids7goW01K0W/jVBk05RV9DhfR
 3J7LQd2Bs9A2UPcH3XtZlETxjMK9hFmm8omd3IRwoHqZmWyeOUqCqc4J4ysyXCK73gK1yc
 5B662TVdyWqivRbir3/EmfaATBJlasyNdwuV8Q+gfpNdW2uAoDko8zw8+D40lWEdf6opJj
 lyQCFtfwygxz0ab+/NcbSVRspe8n0lrqkm4135RPcGNa9AzfmkqsdeCKY0yZP/dK17gjPh
 ad7VJyoO1MRk+G+hHZFaMvEh4tmS6IDvivVNli8UubrqcQIPj/dfB3vdUn7q/A==
Message-ID: <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
Date: Wed, 20 Aug 2025 10:57:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6eeccd038caa4ba703f
X-MBO-RS-META: r3rapgk1gxt7kguqp5uybgyfamgi966s
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

On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
> Enhanced the generic firmware loader to support QSPI RAW partition
> loading. This would enable FPGA configuration bitstream loading
> from QSPI RAW partition to program FPGA.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>

Why not load from UBI on SPI NOR ?

> +#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
Use if (CONFIG_IS_ENABLED(DM) ...) instead of preprocessor #if ... .
