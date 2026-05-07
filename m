Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6CECD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F2984A7B;
	Thu,  7 May 2026 18:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C1s5/MvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFE084B44; Thu,  7 May 2026 18:03:04 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1CD84A75
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBH8g3hJ0z9tfD;
 Thu,  7 May 2026 18:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778169779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekBzBLl3xyNIuS5mSSN274WluwFd12lv6hicCSKWJZk=;
 b=C1s5/MvOXug+j9Qe0CyNk5mRM7wCdWHFpHvBjfIByGl7ntF29IIaPPEfBmUvC8yvlUjUia
 ZYIeXo0FaekHXCgtbm84sYnKLXy/H5svaFoYqwxYezYRWnSBaWbVabK9pmwVfWkW7x90/k
 lgvrIvdxTiW9Z4R1ZuHotVZyf7zSHyniG2xLivI+qivG89/aEP0Fg/IxYluYsEkcGbA/zH
 69YWA+TTuf4wO2jaGhn1LwfgPYDcjuT6njC04UuJddtC5DUnfn4CNUTlCkw22/3ulEKFc8
 0ptmgEulgWCLRn6cPf9KZNxQJjm2y+hu9AHZVYvdC/PIisXZGiKFTqJ3aazVQg==
Message-ID: <d93926aa-5f24-474a-a380-e7cca82644c3@mailbox.org>
Date: Thu, 7 May 2026 14:50:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
 <755b13b4-604d-480a-84be-000316eaf5a5@mailbox.org>
 <b6ffb0c1-aaa3-4a59-a470-fc3edf2df4d2@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b6ffb0c1-aaa3-4a59-a470-fc3edf2df4d2@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 07867a2082fd0e62e7f
X-MBO-RS-META: ocqau4x1be5h3tjenadros51xkmkrm84
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

On 5/7/26 8:07 AM, Yuslaimi, Alif Zakuan wrote:

[...]

>> Even the commit message of this patch is a duplicate of that one in the
>> commit from 2018 ? What is going on here ?
> 
> This patch was derived from the original commit you have mentioned.
> 
> The intention of this patch is to bring over the ECC scrubbing support 
> to Gen5 as well via a new common DDR driver shared by both Arria10 and 
> Gen5 devices which is sdram_soc32.c. This makes ECC scrubbing support no 
> longer exclusive only to Arria10.
> 
> Perhaps staying close to the original patch subject and message to 
> describe the original functionality might have create some confusion 
> here. I can rephrase the subject and the commit message for v3.
Yes please , rephrase it , what you wrote in the two paragraphs above is 
very close to what the commit message should contain.
