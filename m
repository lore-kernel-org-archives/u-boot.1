Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8900FD65C44
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 13:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A57883B4F;
	Wed, 17 Dec 2025 14:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TkDSe4pZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nX+4nUAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FAD83B64; Wed, 17 Dec 2025 14:03:06 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEAF83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 14:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dWYr76YPRz9tgT;
 Wed, 17 Dec 2025 14:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765976583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwDfn9EUv0psgrsWdb0BKbLWnZjwydrJIrPwj/c09cM=;
 b=TkDSe4pZYRNqZYcLhxnAO63P/PUKxa/tbjjQYkHtRm2oJERFPdxGpj70uUS/Juk7MXD4Yy
 d8SCQDRsQW4JLJog8jHllVXpWZnBGTiw0mec2Bd8BVGxfJOgC68+PpSvY8O1FCvnYX6tPh
 M5J9hPBuNaLxF4o6pDA2rEJ9eTfzVPIbOeAC6w9LS+Bs3DfTR/lIGpu3XhmzQAvuYDWN6f
 p79m1psnDNdBj3aNbHJKUEBY3/lkHeLP238Xn6SV6eGeke0iB3qHR0WHLQB3MRNyxCnoLC
 Qpa3yqOBBeigo5O0pU12LRZz/brCn64CEQPz7dojVr8ZDtCmSgckxPTf7vnu4Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nX+4nUAr;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d8b072cd-bb13-40a8-8b76-c493a58f51be@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765976582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwDfn9EUv0psgrsWdb0BKbLWnZjwydrJIrPwj/c09cM=;
 b=nX+4nUArQI3hOpnJ50SyyMjkmaL969dYNRQwHxtDtp39sWyu2TGnBNija75LQGZO2NxNcp
 4/gtrHohagYiXQOTtTMRfu4vuprrC87hiM4Cbd0jMAGc1JNjI7CHFpAGWouLWgDDPuqmUl
 iG6qUEsUIcGn1451hpdhNa7MUQ9oXBEGemIv26Vrmw59Eyw1PNVHLet2bsxSnvxgnDIJMg
 SjG/q3Ns2/GPz2cHmQ4anR9BNoToUAHkVMxYHa1qCstyeisu+W+Pq5MW8LmJAJXIU/BTQ+
 WlMubPpp7PNae8F3KO8Jre85N0wtihW1IJXqL/ibza/BGAC4QuFxQkkDRa26SA==
Date: Wed, 17 Dec 2025 14:02:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] firmware: scmi: sandbox: Use scmi_clk_state_in_v2
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
References: <20251217-scmi-v2-v2-1-5555f8b6e0ac@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217-scmi-v2-v2-1-5555f8b6e0ac@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 365efec047006327884
X-MBO-RS-META: 8nw8tchtmtonsm6zdmbs79f8ktqmowa4
X-Rspamd-Queue-Id: 4dWYr76YPRz9tgT
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

On 12/17/25 9:13 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The sandbox scmi clock protocol use version 3.0, so need to use
> scmi_clk_state_in_v2.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
