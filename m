Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A552ACD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 03:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C21848BC;
	Wed, 20 May 2026 05:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SWSrJcnm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KaeDYcCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82F68487F; Wed, 20 May 2026 05:25:20 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE4C84874
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 05:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gKxkM47Lxz9v7k;
 Wed, 20 May 2026 05:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779247515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/tNt6l0fb/5hD2ExtbExbKlL6BMKqJjoA317m7bKvE=;
 b=SWSrJcnmiM6F45V3uxfg8Lg8rMwuT/VqXcbZIV8Bl+ZxGzuAk6oLNWejD5xxiw3JtNFGzs
 OC5LxP3OGfrwwLfVAj6d+CCIv8Axbno2J+8kVEGiKJFB5BSRIupCEgBquuV+gEXkKGEDxS
 vEnlhvj1/C13c6vNCD4zovJaQWgE04czwl5XZb63bhFuQFMYeT+egVygMjYfSxeBZjDBbI
 bliEi/DEVA3WG/9PO6Ptc2o3s0MKnIB0yOuSJNAe/vhQdStDHbyOndYbm5YXZyGZ044GLc
 VgVhDEgZLRs/rEdNoOxsBpTQAXryowEkaTbKPi8aHr/UY8+Ov5zmJNuWUTVc1w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KaeDYcCA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <990e5ee3-75c7-430d-985f-f146ca8d265d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779247514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/tNt6l0fb/5hD2ExtbExbKlL6BMKqJjoA317m7bKvE=;
 b=KaeDYcCAE61cZFgt49liNhHYFjaJIdiEMWK3rdhhoPm38bMABrmswdl7zze90d/DUvWlJr
 yCd2Uv/pul6SyCrS04Y+9F1qk+Ho80K8YKJQXVWKCVd8d7Qt85beObF0Pq4Qf0AWIqQH5a
 HvzmNV/uB0KUqGdsZ+cZsqUPU1q2sl3mbuJbboyUCpbzm10WjJcxcpVmXRZi9eu4d0aXvy
 gUwe/G8xmX4lrtdvVD45knB2UfEJ9V5iK5YNV3UNlIjQ1P4MO4QakzuL95p2qHRuILfB9q
 o6G7pXea+fq9hEO22oEiou+0Fsf/bWOZKMqXemRfRh9G9Y8OOD7YgnXogysQ3g==
Date: Tue, 19 May 2026 18:53:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] configs: stm32: enable WDT_ARM_SMC driver
To: Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal
 <anshuld@ti.com>, Christophe KERELLO <christophe.kerello@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-2-yann.gautier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260519163145.221668-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fmcyfdc4z8fpgobaxgx1z9yq1166h6ew
X-MBO-RS-ID: b2f8ace11641be63620
X-Rspamd-Queue-Id: 4gKxkM47Lxz9v7k
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

On 5/19/26 6:31 PM, Yann Gautier wrote:

Subject tags should be:

configs: stm32mp15: ...

to avoid confusion with "configs: stm32mp13:" .

> From: Lionel Debieve <lionel.debieve@foss.st.com>
> 
> Enable the arm watchdog over SMC driver.
Commit message could use extension here too.
