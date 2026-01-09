Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C2D26D99
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 20:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FDE843AD;
	Fri,  9 Jan 2026 21:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R9IHPXz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA2D843B9; Fri,  9 Jan 2026 21:05:41 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D976F843A9
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 21:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dnt756Yykz9tfX;
 Fri,  9 Jan 2026 21:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767989137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJldkTNKjsImaMPYLwyRzXqp3ylIuGT+j38gfaTMydA=;
 b=R9IHPXz+8wWYLhK2MJdelFvpzdtTvrNXsfuXc8tBUGvyvt17oull4ubhZQ/TmUDCQw5sN/
 gloqI2CZcVjTVL3SqhCOm2kJ3Mn1/nmy2Qd/G9FEKdq9zpMp/7F1ngpTR8efplnOoQNPjF
 b9lmGOIQDJrlYel3wt+TJfMP65cn6IPL4vqJ/grq2kGhH8tql3F6zXTbtpbtgXJNGamaVE
 +smJOczTVbYGH4krdmzrAIy6vYxiEMgTkoqfZ7PfIRwy6BxPYOB7SebGZnQoPOfgFvGFSd
 Fva3/vW+UCNkcJCXz1aqDFaHDKvDrFCGXLqBF2sQTggcMW6PrARo60BmqAYkbA==
Message-ID: <bd88a442-b56a-465f-b387-9307d0f10e49@mailbox.org>
Date: Fri, 9 Jan 2026 20:26:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] scripts/Makefile.xpl: Align filtered DTB to 8-byte
 within multidtb.fit
To: Beleswar Padhi <b-padhi@ti.com>, trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-2-b-padhi@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260109190026.58464-2-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 242f755eea555c4df78
X-MBO-RS-META: ekabgtdes589rtfar9j4da1xbntrk1e3
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

On 1/9/26 8:00 PM, Beleswar Padhi wrote:
> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
> 
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")
> 
> Add the -B 0x8 flag to mkimage to enforce 8-byte alignment for all DTB
> entries within the multidtb FIT image.
Are there any other places where mkimage should enforce -B 8 too ?

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
