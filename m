Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166AAD0E6DB
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB37B84047;
	Tue, 25 Nov 2025 14:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Zb/OBtnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6452B84051; Tue, 25 Nov 2025 14:02:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D2384042
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dG2sc23Fwz9tX8;
 Tue, 25 Nov 2025 14:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqEidiA8DvLLaTR5PPOWn6qAEUNlA4GZxLzaQp3m9As=;
 b=Zb/OBtnuRje1ecg+fwCgFPCesO027dAHfixU71mMRfOXnM+TIebg5lVcY51ECHXCGeg8sm
 xbZaMvAF8xm8duEc/m5s6mE8272mWmlzALpaV5ybAAsiNJtJ5IVGgt5BQ12slyW5iRyDLW
 XvOSdnddyUXrooQPkUlA8Gz4NmeDMJJm4+RF7cYcBpvn7mewJQ2tOG2ylQ2bi6FF3JZ4ES
 ukYhDxkv6tT9TPoW5300g9qHM/xaci5IhJgHTDE9vQQJFfwIe/4gG2/UMQafBwHLfKfSgJ
 bmQHp053Q0APZNdcVI2EHlAytpTsX93TyyTwq8L5BtA2qBcUTj4fWYrBl0//gw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c7bc72c8-703b-45d4-8bc8-444dead9e76e@mailbox.org>
Date: Tue, 25 Nov 2025 13:17:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2a3e21ea1dd00565857793228cf1a0ee27d550db.1763140421.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wd4e4fug67yi131kw8minjwyeoa3zzny
X-MBO-RS-ID: d01f020b09c0fbac5bc
X-Rspamd-Queue-Id: 4dG2sc23Fwz9tX8
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

On 11/14/25 6:13 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
> by chance as both options were enabled.
> 
> We also need to explicitly select SPL_LOAD_BLOCK when UES_PARTITION_TYPE
> is enabled, just like the other choices do.
s@UES@USE@ . Ideally this part should be separate fix .
