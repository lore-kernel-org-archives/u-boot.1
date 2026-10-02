Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE78CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B45CB80D63;
	Fri,  2 Oct 2026 09:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5z6M3EXscUME; Fri,  2 Oct 2026 09:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB7E880CC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790934757;
	b=r5cUxWx9oo0Z2knF9RZVIWtKo3EisWwddJDkEaRe7qbB6MMARSH1o2M/MSetRAUAaceZ
	 EMwtlYkv2b8PSgE+70GjfMq2D2ed0DIiOT2DB060yXLlb9ZcZZvPcIqWxZOvcPXodfcY2
	 Re2ChcaUOxkbTWHia/IbqBMsY3l/YDn/4xQsWsIJBlN/MkpCAhUnCJlbSXDF3TIWLg+Au
	 MQCW24HfkPx3EANY8HhG42rJFZN2YvEx0mPmncjWu21CCoNRbgPxr/JRdaJeh38Qe5FFU
	 nNGHlNUmSYsv4Kva8+LS8Rqi4twNk1jAPfEma4CZLZ3BnAj8wu+8GzYo4ThvONZCoYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790934757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:
	 X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1fTS9yptSD+YKbfqSG9gQXiz7DjeN9AdstCcYc9JXwQ=;
	b=r//yiHAeqr03X/MFVTM6YHPsplkQmRAuki+8FCdn6wdD+ilMw50bTNE68JKAG2qMM7vD
	 tU9YkDiqj20KGvHaLdzd+geHDwy8GYhugksfvHLKRLuIK9KdBL62lBrnL+XqCe8XGUFAF
	 C51OjwfqgyruSDJmuyccCuDp8ANj3/v74xoqLuCdAwU0GiLW4BX3buLB475Gze6YsCodq
	 jsjBSZFWim7i2WnRlqxaJWPAqFtMHHFP5bwjgfZhy8av7JV82CCjuWiO39/SEK86EhimT
	 DIiE24HaNZyudfI+b3ooJyDZ96HCzR2Bt7D4c+Nmim808SsQMHJx0ETsUhRXjzNE3Zg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790934757;
	bh=1fTS9yptSD+YKbfqSG9gQXiz7DjeN9AdstCcYc9JXwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i1BrVwNRGv2RkB/U5+P+Q6JK81c+I/nLMtW7ZIk4yUZej/gLfH5emliJDlDmDt9+f
	 r4jsLF5bYloMlLvpW4OXrVZFlCzsUWH6ZmMZueMgPejnKn+sosvvB3QDl3IGyApYtn
	 Twt9XVZB/DLJ8VjIPudtRRCBgWz5pHxWLvUpZkhIo6KSnDnMJa+kAQDZ0AoSr5MlQD
	 2rN69kgQ4ryLKbWRo4pE7gPK3Bc90vLtp8JczUvFLI74By9rLcESwBgBgAvBX7/Ar5
	 7GzrddzmuIP2hnhs0sWXne+rAf1Y5eOHE5vJXmHJ1mfFE2KKRc95IhJUfMr9kM2uNM
	 ka7MWDmGQd+nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB7E880CC4;
	Fri,  2 Oct 2026 09:52:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E7134D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B144D60645
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKUbUvH5O7Lw for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:52:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D37460653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790934754;
 b=O36QxZfrKBqPoNcgpOLRHIMxSpGMSnLbqdJBE+DbxpN3ISRKCm5NGx23sTgNx6oNga0h
 1SK0LV/8mzEZ06VjJfJn+6xp2dKmxvvC2mD9pT+7GNf7m1uFoZdXh76jqTiRs+6/CMPk7
 ZsJ3vqRjMG+KsLARs7lCZW6dwK0krAtwlEBPhvtZpCtO63GfsW5fO+6C5ZpiOnGZODEFk
 kDmCf0Q3ugPoboFlGn2MRB3vYKpNgpaYfdG+56IGDKjvG2yaBkdhYTVxtePCJGkYUhMwq
 vcdxj2QLhhaMriHuXi23LY8YDmcXjrxOWOCL6IKZRWiriawKvQMzUnX2bd9JTsIfgiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790934754;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=1fTS9yptSD+YKbfqSG9gQXiz7DjeN9AdstCcYc9JXwQ=;
 b=UoFsqytSbaD3DgcmehP1TqCdTOj/50mwV8v7vc2SS8zhZzyQvNuvuBzb7LTS8O3VQNOh
 KYfOu5ddhrrkzQaW8X9d5tsrWexX0xfG9MvzGMbtZkK0JHFzXd5OkTe9zGesgGsmYlAzJ
 v53mPkEv+emMJV9ZrOfLYF1GN7taaXq89tq4tCw8fWfnKS8kOjHrOHaeOF+31FwjN2t3C
 aAcW2lcfuDczVsNyIlLp6nn7Fuzjc9q2SSqW7YR2r+INHP9X+DCmVsrWtwZP3tqOuBsIf
 IEALNTxj/cD6+0xuS01TRh9SSGy0zgnVTAktGv3tkctlAP/JRFL5WmpEVj8VaVqwqeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=E49612lu; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=E49612lu
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D37460653
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:52:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hx3wt3WVQzMlX8;
 Fri, 02 Oct 2026 11:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790934750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fTS9yptSD+YKbfqSG9gQXiz7DjeN9AdstCcYc9JXwQ=;
 b=E49612lutXxyUyO5iS1zyDrAPCby0gLmRRCiHxhAcCqXEZl6XZ8rDpVNnhXa/inTxPrSvv
 66wdIjA3jQrBxrIo9TKqFW2Keodvajaposy1J4ddq7GKsD1KetbOLZinXUrqfinTkMlZor
 3ZTbsClssaFAh5DwX+jDdUN++acUmnheVTqdqFjx+Fd4mgUrq3VEJxq5fBZi/JIFIjelmN
 sUCsYR0LaLiOFsUraRAKnLoMy+euUOCTr/M4U0jZ/zNNj4LSG5AblpxXBv8MUXcY2vCFKj
 fbeMY+VAvft7RxolmvUjp8h/1EvMPsF7d5cjk8dpYJEUQcJYcVwDtzCMdZuAyw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Yuri Zaporozhets <yuriz@vodafonemail.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@qsoe.net>
Subject: Re: [PATCH] wdt: unregister the cyclic when the device is removed
Date: Fri,  2 Oct 2026 11:52:24 +0200
Message-ID: <20261002095228.2322791-1-stefan.roese@mailbox.org>
In-Reply-To: <20260823180437.152740-1-yuriz@vodafonemail.de>
References: <20260823180437.152740-1-yuriz@vodafonemail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4d57eb4291db67b054d
X-MBO-RS-META: o58kqrt1in61h7au3xt9c4us4991qex1
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

Hi Yuri,

sorry for the late reply.

On 23.08.26 20:04, Yuri Zaporozhets wrote:
> +static int wdt_pre_remove(struct udevice *dev)
> +{
> +	struct wdt_priv *priv = dev_get_uclass_priv(dev);
> +
> +	if (!IS_ENABLED(CONFIG_WATCHDOG) || !priv || !priv->running)
> +		return 0;
> +
> +	cyclic_unregister(&priv->cyclic);
> +	priv->running = false;
> +
> +	return 0;
> +}

Good catch. This is not limited to out-of-tree drivers btw,
octeontx_wdt has DM_FLAG_OS_PREPARE and its remove() calls the
driver stop directly, so it leaves the same dangling cyclic behind.

Nit: priv can't be NULL here, it's per_device_auto. And since commit
2dbd9101b991 ("cyclic: make cyclic_unregister() idempotent")
cyclic_unregister() is fine on a cyclic that was never registered.
Not worth a respin though.

One thing: the patch comes from yuriz@vodafonemail.de, but the SoB
is yuriz@qsoe.net, so checkpatch complains about the mismatch. Which
one do you want as author? I can fix that up while applying.

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
