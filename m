Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F62CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 22:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD01838C7;
	Thu, 30 Oct 2025 23:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JTFmOkpN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sj497PNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802CB838CC; Thu, 30 Oct 2025 23:37:03 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D888334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cyJrY1B2fz9sk9;
 Thu, 30 Oct 2025 23:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+GwA04vtRbGVTjFYvBlDjKhw7SIKU25XbjGf4SZUKg=;
 b=JTFmOkpN/W3Evnyuw1tkuy8/CEVFgawfC99Tg1YfWwtX2HWserdAP/PCqf/1c3hc7vrXbw
 0FAQCNk16nnRfwbiEvZFmhq4jXymq3YbLvmv6KebXZ050nqBrjQ/J8pqY1mno7qhDe3KUb
 mUKfLmQSXOh/5JLlsi5oQAq0fkfcmEyvAIpsZi/YZ1M6Jw1xtrmrn4ajoHwjQ6QwQGQHcl
 WP3e8AYSVtqws0pJulet/V0vXjTfKc2C+LLKzPGGTo9Xt4vJoHgtv/W417k8ftndUG28pm
 EVUwkUf4qfXv5iiTfXjDPxhjt7F0QevXAe5U6iKEVHstxb4CbKnD+a7tbYlOcA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sj497PNj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <8f88cc1b-ea03-4146-96fd-99b45d16bc5a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+GwA04vtRbGVTjFYvBlDjKhw7SIKU25XbjGf4SZUKg=;
 b=sj497PNjiLZi5jb4KbqF1tiJrxGmQNHUjK+l+zosp+4AoYlXccVSUjLd4Y7fed10dwqY2G
 hzgKzPlMzigF2LHKqj0ueNBE7ZfQWKfPdha70DMDO4fJOxegPfJhaGJ85Zbs+ISJn9W7oV
 9ZHi1fM0DXPlrwki0SGNoWOfBq+lQOEQ+/uNK/iSRrUzgf4OwzkIAZO7SPc3R7+bS4mAMr
 YsYS4ekD04VwBdexheQBPaVUPY4HpSWmbTgfzjsZ4/IvpfYmYUr0cTspAq4h+CMY3BdDyY
 5G9bA+WWL1WQtsammKH9wcedCuh9BYaejpWST2oxshMxFWtivL8jAZRU3xmgAQ==
Date: Thu, 30 Oct 2025 23:36:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: Keep Makefile and Kconfig sorted one more time
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
 <DDVTPE7HADMW.I3XHZV2XBIZD@mentallysanemainliners.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DDVTPE7HADMW.I3XHZV2XBIZD@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hy3jp97p57murcp6q1rphem8ocsnwok1
X-MBO-RS-ID: 045a48ad595a247b834
X-Rspamd-Queue-Id: 4cyJrY1B2fz9sk9
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

On 10/30/25 6:12 PM, Igor Belwon wrote:
> On Wed Oct 29, 2025 at 9:14 PM CET, Marek Vasut wrote:
>> Sort the Makefile and Kconfig alphabetically again. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
>> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Neha Malcom Francis <n-francis@ti.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Shawn Lin <shawn.lin@rock-chips.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/ufs/Kconfig  | 28 ++++++++++++++--------------
>>   drivers/ufs/Makefile |  4 ++--
>>   2 files changed, 16 insertions(+), 16 deletions(-)
> 
> Hi Marek,
> 
> Maybe for the future we could use the consistent naming scheme, like in
> the Kernel, UFS_MANUFACTUER. It would make it more clear.
> 
> However for now,
> 
> Reviewed-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
I sent a short follow up series on top of this patch.
