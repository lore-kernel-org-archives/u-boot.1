Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C604CC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 07:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 456CC60721;
	Sun, 23 Aug 2026 07:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nCPxJ9d9yOK; Sun, 23 Aug 2026 07:15:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787469323;
	bh=uym5oaeDxvIBAmwvlTSPevr56TnPXvFCy0Zwz/nwY6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKExZcaRe6oIHdMDVQTXzwxGzJ95CvBQY7/theiaddtkTk2Oq7C78UUCTxBSD+/jn
	 Ef9z6g0Lu/HYdUSq+imbWvZ8TCH9pI28yatNmwiDRlx2WGWLPSgx3RxT7wBGdVBst/
	 fetvRg3Pm+/qeV+Ur8WCkiHh/mEcER9wYMBOwDaFROtmpHtPPXtAbhkHdf/KRE7rQL
	 hJNKTiPyWWUQoWRGKSs678myvcT9RtGNtnrHWr0LIpKj3oIOx6WCSMOPyLHcCy8GHt
	 j7Hvx6dVEJD3SSr6lPs6TPbenFuf3JUtzU4s9LMGN5A/WOxkWOrCgXBxb5tFwmBzsZ
	 H0NNsBWNDY8Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7299B606BD;
	Sun, 23 Aug 2026 07:15:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0C61118
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2E2F606BD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOumKXFo59Mx for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 07:15:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=rTYGD3Qh
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A825F605E7
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:15:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hSQKv1XKpzMlC3;
 Sun, 23 Aug 2026 09:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787469315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uym5oaeDxvIBAmwvlTSPevr56TnPXvFCy0Zwz/nwY6Q=;
 b=rTYGD3QhZxMH8MYRqaRjCoTOwVxpKzt6zD3hUqNV0g3GiUca2BERU8Msz7MQmWutFi3eBS
 yaxk1BQuHy0sqkLOyRdZC7/+GArzsaUAz2nlihFcYjvYGrLElGin3s2umts9sw+fms4FwE
 i5DUBy3Tb12K0aorIFPKK2Fqx+Im8Y8txm5K/pbwA5WQJlXV+jGy6UidYdnzB1oH60vbHL
 FKYpJHDKGDPptKLIDDkM4gTd2YlVVZs0DLexrzkOJuDNsR4LrJJebw0CQzJ4/VbYC0RrcL
 qA9E4DpGOsrImmKJO7ngMv+J9GvK57DRL+qgZL0SB7VjZLGIXOI6TBw+Dt+mwQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 0/6] watchdog: report effective timeout
Date: Sun, 23 Aug 2026 09:15:08 +0200
Message-ID: <20260823071511.687900-1-stefan.roese@mailbox.org>
In-Reply-To: <246f8c07-d77e-41a5-bc67-5f77c1c522b0@cherry.de>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <246f8c07-d77e-41a5-bc67-5f77c1c522b0@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9a15057b773c01533aa
X-MBO-RS-META: awzxcbgua5za3qb5oii1zicpn7enm18t
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

On 21.08.26 19:18, Quentin Schulz wrote:
> 1. Is it really appropriate to have a timeout smaller than requested? 
> Maybe the answer is that we should fail if the user requests an 
> unsupported timeout?

I don't think we should. If wdt_start() fails, init_watchdog_dev() just
prints an error and returns, priv->running stays false and no watchdog
runs at all. Firing earlier than asked is usually better than that.

It would also change behaviour for quite a few boards. Most drivers
already clamp silently in hardware today (ast_wdt, at91sam9, cdns, imx,
mpc8xxx, octeontx, sbsa_gwdt, max6370), so a timeout above the hardware
maximum is not something anyone currently notices. arm_smc_wdt is the
exception and does return -EINVAL, but making that the uclass-wide rule
would drop the watchdog entirely on all the others.

Linux does not fail either, where it matters. watchdog_timeout_invalid()
only rejects a too-large timeout when max_hw_heartbeat_ms is unset. If
the driver sets it, the core takes the requested value and its worker
pings the hardware more often instead. Our clamp plus the cyclic
servicing is the bootloader equivalent of that.

What I do agree with is that clamping must not be silent, and v3 prints
", requested %ds" for that.

> 2. I'm not sure it is enough to clamp the max. The Rockchip RK806 PMIC 
> has a watchdog with only a few possible values as timeout: 50ms, 100ms, 
> 500ms, 2s, 10s, 1min and 10min.

Agreed, and we don't need the RK806 to run into it. max6370_wdt.c has
the same shape already: 1ms, 10ms, 30ms, 100ms, 1s, 10s, 60s, rounding
up to the next step.

designware_wdt is arguably worse, since it rounds up to powers of two:

	i = fls(timeout * clk_khz - 1) - 16;
	i = clamp(i, 0, 15);

At 25MHz, asking for 3s gets you 2^27 cycles, which is 5.37s. Nothing
hit a maximum there, so max_timeout_ms would not help and the print
stays wrong. booke_wdt and renesas_wwdt round as well.

So reporting the effective value is the more complete fix, yes, and I
think it is worth doing. Note that it is not a step backwards either.
Simon's suggestion to use max_timeout_ms came with the qualifier
"assuming this is a static value", and for sbsa_gwdt and octeontx that
holds, there is a real fixed hardware maximum. What your PMIC and
max6370 show is that the effective value is not always static, and that
is exactly the case the plat field cannot express.

For that case v1 already had the right shape:

	int (*get_timeout)(struct udevice *dev, u64 *timeout_ms);

with wdt_start() calling it after a successful start and printing what
comes back. Drivers that don't implement it keep the current behaviour,
and the ones that round or pick from a fixed set report what they
actually programmed. Simon already said in v1 how he'd want it built,
pass timeout_ms straight through and document that drivers only write
it on success.

I would rather not put it in the uclass plat data. It changes on every
start, so it is runtime state, and it would have to be cleared before
each ops->start() to not leave a stale value behind on the error path.
Overloading ops->start()'s return value would work too, there is
exactly one caller in wdt-uclass.c, but reviving the v1 op reuses a
design Simon has already reviewed.

There is one more reason to want this beyond the print. wdt_pre_probe()
derives the servicing interval from hw_margin_ms alone, with no relation
to the timeout at all. If the effective timeout ends up shorter than the
service interval, the watchdog fires during normal operation. I don't
think any in-tree DT hits that today, but once the uclass knows the real
timeout it can warn instead of letting people find out the hard way.

Juuso, I would like to take v3 as it stands. It fixes a real bug,
drivers that don't set max_timeout_ms are unaffected, and the
effective-value work sits on top of it rather than replacing it. I
applied it on current mainline here, checkpatch is clean and the wdt
tests pass on sandbox64; octeontx_81xx and lx2160ardb_tfa build fine
too. We are past -rc2, so this goes to next for the next merge window
and there is no hurry with the follow-up.

One thing though: none of the v3 patches carry Simon's Reviewed-by from
v2. Was that deliberate? 3/6 is byte-identical to v2 2/5, and 4/6 and
5/6 only changed in the ways Simon asked for, so those three should
have kept the tag. Only 2/6 really changed, the clamping before
ops->start() is new there, and I would not carry a tag over for that
one. If you use b4, "b4 trailers -u" picks the tags up for you.

No need to resend just for that. I can add them while applying if you
confirm that is what you meant.

Simon, 2/6 does something different from what you reviewed in v2, so a
look at that one would be welcome.

Thanks,
Stefan
