Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEC9C61CE7
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 14:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F5A8144A;
	Sun,  8 Jun 2025 16:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hSPT6qTv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YnxDJopQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585D181E06; Sun,  8 Jun 2025 16:39:18 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683738129F
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 16:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bFd3l6JSDz9vJy;
 Sun,  8 Jun 2025 16:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749393556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1Rinz+EWJKsLJtigdhvmvQfuXMM7xaEDSLe4h83pBA=;
 b=hSPT6qTvn7kCLimNpz0QZhrHki/CeXMBDPRADhmsHnz5qY//kzG4sbN65wgQVjCk+X1eoG
 gtVp7S/X93nPBnE/6XYqL3mwWCgeMbBJTZjvsHqjqbcvFpfE4SGb0rt6VC6eHNw776uW94
 tGCRoqc8zXIqxI4SP453dMBqgABkuf5we65mdVsSCuieJaBidvCAm0rIhShnV0FVtvTdBS
 zYOB4rcX4wOSsJ/CsbGqb9MAsC7FgEj59+xnBL2jAy0N9iDTD3+QXhAEl7eb1qmTqbHhcc
 4lyW57YMW2RYmhmURJ146xUfQ2AR6tmtvHAjf4cKUNO7S4DqTmER5CxnxwVlDQ==
Message-ID: <7f651ea7-3336-40fe-8717-70ed3ab51d1f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749393554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1Rinz+EWJKsLJtigdhvmvQfuXMM7xaEDSLe4h83pBA=;
 b=YnxDJopQlGuJsEasXZqBUrUW2JgbFU+My1wBYnwDe5VOqCAcvhfelzxZehmJYesj8+aNRm
 5WyIrbVqeTTjV8raRpSgMUHoWDvMBAxOTcpOlonySZfurA4eOtOf16xXylMQPk+AiQQ9EM
 BNnoD9WjqSw91ZceiUJuQ7ipDtAzxJ9mLkNnPcNK4zFWXIBEv4+bfE8FOasgsyggmqB7vL
 4Y3vbjvZcQIEhkdNae4CXBUmhHAq90voovoZBNctLpSFVjTWSzqiMjBjb+U+8F7dhNEc/i
 dOPFT0vJmKIWja2kgr5OJ9vUXz/sYssFCP2esxhSKty+mvWyfNDry8BOoTUUSw==
Date: Sun, 8 Jun 2025 16:39:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] renesas: Handle CLK_TYPE_GEN4_MDSEL in
 gen3_clk_get_rate64()
To: smelamud@redhat.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
 <20250603-us-renesas-watchdog-v3-1-af3a65afd03e@redhat.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250603-us-renesas-watchdog-v3-1-af3a65afd03e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: c8zgwehy3onqzxit6yqjfs6drros9634
X-MBO-RS-ID: ceeaf5913ce5a463714
X-Rspamd-Queue-Id: 4bFd3l6JSDz9vJy
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

On 6/3/25 5:06 AM, Shmuel Leib Melamud via B4 Relay wrote:
> From: Shmuel Leib Melamud <smelamud@redhat.com>
> 
> Add support of CLK_TYPE_GEN4_MDSEL clock type to gen3_clk_get_rate64()
> function. In particular, this type of clock is used by Renesas R-Car
> Gen4 watchdog. It operates similarly to CLK_TYPE_GEN3_MDSEL clock.
> 
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you
