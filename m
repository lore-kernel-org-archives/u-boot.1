Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEAEC369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 20:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF99826AD;
	Sat, 12 Apr 2025 22:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744491134;
	bh=EEX5C1QmOKpzCEIjp3oZvfJhDng9JChqwDV33FwN55M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtqrQV3e7reM9Ihdcvnde8N+eLfHiD0xLVfBx+poA+9VjacJTUAgR53Rq4tNlDnDW
	 Zft/454OAjs2l2mTr0AMuZ9Muvzj8BJPQ16kMKfNiq2mtGw+mLB4WZz6pPpvK+Bg1Q
	 wYPcW8bLxr8LJRVLSoLqZmuyxM/gwgcgHOIYZFeIBBOonXtU4NpWGvUIhvJ1wprWDj
	 lh/3h5rf5vfRLl2XlLAHE/S37Oh9eGZbVkKMAzRuSf2HSS+Tohv0zOShYA+Kv6ZDCr
	 LpNBb83/S0D2iXQw7brBuW/Ryf6p12r4HTuqo7wyGzBdVbrxevTn1fihPvRDy3dS/d
	 +KCBaRt09Fw8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7C582928; Sat, 12 Apr 2025 22:52:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C49B82161
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 22:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="B7/bMsju"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7EC910275AD0; 
 Sat, 12 Apr 2025 22:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744491129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=EEX5C1QmOKpzCEIjp3oZvfJhDng9JChqwDV33FwN55M=;
 b=B7/bMsjuBZrxhEC3rYgQKykwUQs3/qWe27ujHSYUHfjjIaiS1wRVzTdpAP2Y6dmjrpHaHv
 IGizbD9kAQE8eP9Ks8Fnn4CcbEwyA4a/WyVptN7Qz9fTLAL1BnqLeYj5Q93VF1+RdY5Zeb
 ZI7P43wGxO7gQSGTaTnluI2KAZ9fx+JGIg3g7+twzYneiaQW2qARDm2SUyFLpGIhpt27AO
 xCiVcedD6YEoxSGhOffy5cCR5xWeRsfPs05KpzpdCyXWcQjx1ZzDhc4Ng+CQ8giecCxXdC
 PXHfggTlVle+pRsSg0N86SAA9fepNvL+mpAlaaa3j8nATkLFUfeS0SKFS98sYw==
Message-ID: <1e19e679-8af0-41df-8ce0-42aaf15d4890@denx.de>
Date: Sat, 12 Apr 2025 22:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] common: board: make initcalls static
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <20250404135038.2134570-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250404135038.2134570-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/4/25 3:50 PM, Jerome Forissier wrote:
> Change board_init_f(), board_init_f_r() and board_init_r() to make
> static calls instead of iterating over the init_sequence_f,
> init_sequence_f_r and init_sequence_r arrays, respectively. This makes
> the code a simpler (and even more so when initcall_run_list() is
> later removed) and it reduces the binary size as well. Tested with
> xilinx_zynqmp_kria_defconfig; bloat-o-meter results:
> 
> - With LTO
> add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
> Total: Before=1070471, After=1068190, chg -0.21%
> - Without LTO
> add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
> Total: Before=1121723, After=1121213, chg -0.05%
> 
> Execution time does not change in a noticeable way.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
I don't want to block this, so this is fine by me.

Sorry for the extra delay.
