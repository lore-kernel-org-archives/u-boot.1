Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5647CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BF1840C9C;
	Fri,  2 Oct 2026 09:41:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zs5ia3ZUb0th; Fri,  2 Oct 2026 09:41:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5AD9C40A77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790934107;
	b=C8T69QaYb7JNJl6kNl9hkP2qAXsk3qkPCpW09HIydXpywUh3L3XsTT9GqCghlaEKqPII
	 nQ1P4M9+w606hBnIIb95bgX3u8Ree6v04HauO+S+sH8MGsB2UV3Z0s2AUMfdQZ5CrFOVb
	 lAYlbS5xj2h1uaFLHweRQdyF32JmtIjeeL1oSRI2iyXkzwx8ZA1uochIiEAd1ipmwl+O7
	 XXozSqolTlt+eL0ZYKqJFjDC7uK2yG8VgtLrl+R+Yk6Fvdjnfq6VRIJstItge1jGk1dnH
	 dxLlMvHQlRYHBfVBAY0V9ln4yEN3c2ixv8FGhNjdZcrNqExQZQWay03avIk4lfDBAKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790934107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iO7TwTAia5jVfrG7h4UmRewV/Bd6kbK2M8IkJBtw4PQ=;
	b=q/Dj8S1aMuozRKxwv/plBBwXwyM7GbnJRtjyR7CyEQ8CUGmWyCg6yWhkH3K4v6/oNNwr
	 b75LHmJ8o3eqHwgAwx/QC0YUp5EMWh7YU3nz6kq73SZaz7yyAUu/fbk39tU9Vv4tO8AmI
	 t4BJd5Qpx2y21JXlD3Vt1McJbDGGQJa6pRRjtx1jETCZ/o6DZNTxnKValfaVhrUPzWuVp
	 X9jBZgjUZU/2v8c8YWYLj+zXW7ZzEFqOLKUwd7Hr7mFE95qeEeBO0oIF/T2QiLsVjpVqo
	 A4hewo6zJAJcF9KzeAd3zT/a5K9TqqTHqOfi+BEJK4aULpH/9wSh0vmIOgjxQkSHO3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="OkpuSEz/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790934107;
	bh=iO7TwTAia5jVfrG7h4UmRewV/Bd6kbK2M8IkJBtw4PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OvJ5I6YJj9XY+ajzUipiA7bfvdWvwl6rXL8+IoyuUIOWOi2cqEju6GD/xoUWIQF7O
	 HRz7nypCA4f6DqiOxGtm8iiIwsMNgGeZ/GymUdL/O4wPBujIehq2oh56rH7S08fuFl
	 rnQuiX3clwvlUwxYl+uLnCOGr8MZ/Gs6lO8cKljSlSNBcVcnfazEXDAxdrMxowui4D
	 NbhaQCeh3cB2Y7VT6S0MDAKcPIFfRszRAmEtgsmdx3VaUC+4/92tqF+l7m62CmI3m6
	 H80/xTGeTC0Zyz7IJs0lma2KX3ubxVQh7uE/CPw6FKg7AnQLAC7rlUA3mMSu1VZAsK
	 eAssBkgdISnGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD9C40A77;
	Fri,  2 Oct 2026 09:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B9B33AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 014EF40A77
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXO2L9XyEkRg for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D9F140623
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790934105;
 b=d48gWjBB1Sa4OyWtOaNraP1CLdaEuH9NL4lzaT1UwN8Qtv9nws7lrb6vNEmwkWqt1kdP
 95NzdGtN7nSd7vdXgygzpUTe6scLKraBhKr+HMCNWhY6iIQbTxhU63A/Zyv5Sk03jzTC7
 pQTJt2oLqZj+NgW0tcHLSwiHjp6nOj+2PEo49a+l7FzHMTWKw4g3hzvn5pLiTNgG6tMcW
 RDp3LJ9E1llkzHTHHJ/sXoAh3kRc/fVorTTGjH0ObmUgaqvpVgJdxDgDo3ki14J7JDmne
 G+AWRRGzHYDbPNK3HZByIgIgd8zYVurHYtUc6Rx6a+a+jl8Tb8A9/F8FlClF7dAXTzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790934105;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=iO7TwTAia5jVfrG7h4UmRewV/Bd6kbK2M8IkJBtw4PQ=;
 b=WMPxrIczexemFc23QIX0MIUUT7SjYeTT/tP8nsgZc363+iC5mewNtwxo0TpnK3WBZ8yd
 1ZICb8KlHTPJn58T4Q3JrJE/4yLsMAQhM2Kmi7iiYonWCT62mX4M0wLRLK2VXrvE42PFJ
 cQYWYnuXbsYrbWYS819kx0/PNu6ptqCvjwTtrxXH9KMb6KHiatAgNpqVj+yjJmmAPSWZk
 avFWoOSXRMc9B3W7LetGLd6HtMmeD0QbJkuIl/udf7OtpQM1/QGxzmV5VMoGMhHNRRHWO
 9E4P6qE+Nfy/UIXtM+BF0kiaTa+RYYA65pyFIApqABTgRA5+SCHwLHZheMVTt5gIm8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="OkpuSEz/"; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=OkpuSEz/
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D9F140623
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hx3TB6gHwz8shn;
 Fri, 02 Oct 2026 11:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790933518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iO7TwTAia5jVfrG7h4UmRewV/Bd6kbK2M8IkJBtw4PQ=;
 b=OkpuSEz/t8rNV8VRhtaAfXBf+OO4YPbvKvpJd176g3RmKrxwPSndAMdkAaZyw1mhLvW5nZ
 c0uZx1Qx5LRBKcGWkFVnBRwbNy56I0se3lQY/PQBiROoYHlO6q1xyp5BTLTW7RiRiSLuvH
 XeSTJCQ+9lWjlH2CNkx8JJksx4/Of230rFv3v0ZXOX2UgsmAhuj5NolKMPkEClhvDkT1Ef
 6E+2DGTCQU8ISC+uyX3IZVKY4zE7WVCywTg6nRzSTqx+ruOUsLCCgYgIPiwQdNQAaEKvIw
 v84GR71ytpZ5XynD7jr4C7IHkqfnxOQf1le79o7t2Dyu3TbfDyJKgPpobRPjYQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.u-boot-project.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: Add support for i6300esb
Date: Fri,  2 Oct 2026 11:31:53 +0200
Message-ID: <20261002093156.2238815-2-stefan.roese@mailbox.org>
In-Reply-To: <d2d659169ff5dcfc8e72e03abe887afe20a685a7.1788526864.git.jan.kiszka@siemens.com>
References: <cover.1788526864.git.jan.kiszka@siemens.com>
 <d2d659169ff5dcfc8e72e03abe887afe20a685a7.1788526864.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c5ss4ht8rpok8n3etsy71wgpa9k46rxk
X-MBO-RS-ID: 14efdd214ece2b10171
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jan,

sorry for the delay. A few comments below.

On 04.09.26 15:01, Jan Kiszka wrote:
> +static int i6300esb_wdt_start(struct udevice *dev, u64 ms, ulong flags)
> +{
> +	struct i6300_wdt *wdt = dev_get_priv(dev);
> +	uint32_t val;
> +
> +	/*
> +	 * Scale to ns, then divide by 983040 ns, the period of the timer
> +	 * (30 ns PCI bus tick * 2^15). This is timer 1 (IRQ). Timer 2
> +	 * (reboot) is set to immediate expiry.
> +	 */
> +	val = ms * 1000000ULL / 983040;

There is no upper limit here. The preload registers are 20 bits wide
(Linux caps the heartbeat at 2046s, 2046 << 9 per timer, just below
2^20), so with your scaling anything above roughly 1030s silently
wraps. Please clamp it. Once Juuso's series ("watchdog: report
effective timeout") is in next, setting max_timeout_ms in uc_plat in
probe would be the preferred way.

> +
> +	unlock_timer_regs(wdt);
> +	writel(val, ESB_TIMER1_REG(wdt));
> +
> +	unlock_timer_regs(wdt);
> +	writel(0, ESB_TIMER2_REG(wdt));
> +
> +	dm_pci_write_config8(dev, ESB_LOCK_REG, ESB_WDT_ENABLE);

Linux does a reload after writing the preload values
(esb_timer_set_heartbeat()) and again in esb_timer_start() before
enabling. Without it the new value is only picked up with the first
wdt_reset(), so the first period still runs with whatever was
preloaded before. I'd add the reload here, before enabling.

> +static int i6300esb_wdt_stop(struct udevice *dev)
> +{
[...]
> +	/* Returns 0 if the timer was disabled, non-zero otherwise */
> +	return val & ESB_WDT_ENABLE;

That's taken over from Linux, but in U-Boot the callers expect 0 or a
negative error code. Something like -EBUSY when the enable bit is
still set (locked) would fit better.

> +static int i6300esb_wdt_probe(struct udevice *dev)
> +{
> +	struct i6300_wdt *wdt = dev_get_priv(dev);
> +	uint8_t val;
> +
> +	wdt->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> +				   PCI_REGION_TYPE, PCI_REGION_MEM);

Please check for NULL here.

Nit: checkpatch --strict prefers u32/u8 over uint32_t/uint8_t.

Thanks,
Stefan
