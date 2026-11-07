Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37DD606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UMDmUKdy;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jxfTRPB4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E46407C9;
	Sat,  7 Nov 2026 09:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmCSOFZrI0L5; Sat,  7 Nov 2026 09:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86A0340634
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042140;
	b=KMyhFnpYGuawPWocjMKIazxi1WioDhroLU2oTsjg2A+mbnwMyNsWeR7d4CoOhx8vJ7ry
	 Wdwn6LigOyqxEgmARLW8zdMGRh7BZJPvdE2IhwexmtY2ezBcvx7XXHZQhHBHasiF05eAA
	 YbsgKyo7fdQQ1PSeegPl4ESoCWcHXXKdXZcLu29Dt4FEfmSeo0Ywcb/wtaoakl2XGgKCU
	 RZaHeT6rwwem1kPFIccotAcL56dwPK69moRuOwXB1G/BhAN4l4nhc/ds+B6eJW7qcGIf3
	 2d/m/tstqVhYLwMbAwNsl28dYVuOAdQlHrx88N7OL9pfFCX5WQ21/eOgRBhNvVGUI1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IOOFrjrz1vzoT/SxnXixBpRTy+GU4HpXig62xPjdNgY=;
	b=qaQ0HnKAghJw/JukC50j/m1xSYhNhL5Vn/YFlE6N4ubf/3PHlLAbrNUqFixegsEPbr54
	 lmBsp2S1ppGtCFJ3G7t2M7zsIIYPjPG7cQ95PzD6rPZDgyov7QFkcx97wwlrEkFxdZ8Ha
	 7W05HeOOVlq0QZl8rYaa5okNoaCsFTkmEzVGAb6VHDh+M5gPd+5okib8b94gj+68X+Iyd
	 CdmoWY6+r1/JiqEYmzt7oa2mJavQqCjey9elYWKVrCiezICVOKpIkY5yhXiPUd5RroquV
	 FxVrReskV831N8DXSH2m/Dxb4pD1u9OtLY4f2+JTsBr0qfOp0WP95Kxbl0Bj4LLGtJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042140;
	bh=IOOFrjrz1vzoT/SxnXixBpRTy+GU4HpXig62xPjdNgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMDmUKdyNuRAERGV97mZMpiBC8mFSwh9XWQ7DkwE1dRRVgtGE1HWSrkAxQ6I3UTtX
	 DRECnNw2TBQXb8X1CmZBzzpqjz4kqH4noWthfKa6Oqgu8Wbq1PPhd1/Pbauew5xgcy
	 33yzXjs2n2AuVqZwf7vZBGTZ9VUL55ckc+IfeTjC2NP2h8Aonl76HonvqbYZtRcyKi
	 tLFS/kQX1/ZYN71WBQtPYBO87gjMFF14YwOBtW3DS9JGfvviN/uhpjOGKEBbsCznro
	 2Dle9AEUcv4GIlewFpDzksWY2aDfjkiegtfvg1xJMcJMavraAHRI9yPx1FdCkSUyBV
	 NXzkR2v5FnGbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86A0340634;
	Sat,  7 Nov 2026 09:02:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61E8E2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 509D080BF0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yrmwlV5iyppJ for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B7ED80BDD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jxfTRPB4
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B7ED80BDD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jM96C0wCvzMldw;
 Sat, 07 Nov 2026 10:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOOFrjrz1vzoT/SxnXixBpRTy+GU4HpXig62xPjdNgY=;
 b=jxfTRPB466M4NPKDBvUgrNbLlQThHO0CXXHZrwwOe7/NAs84dUOFgHghST/Ga7QoY1qqyY
 T5nAKtwUYuWqHDDgxgpi1nhHFuk+X8IKt4qsC4Wq6+Vu9ua6yZICs6l3iR+9gizhihkxyK
 9O0jX4Vh+5pyvHg2uUBG6U9KIFgohN0p1jq/RVd+YzNO4LoXRyo+mOl+as3WA9tWG7u/cG
 OCMupk5/uYi9xA5b3nDvNtJxsKQxnOU29UIiQdu73pzLNI9QOl9AFTJxQ+jJ9edTLFPOIe
 CpiyaqDAUs7758h952cD66mBPlcelGhEGm6OMZA+EiFF+7rwuKkXz4elwX9ZqA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 3/9] cmd: wdt: store the device sequence number instead
 of a pointer
Date: Sat,  7 Nov 2026 10:01:57 +0100
Message-ID: <20261107090206.2015512-3-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-3-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-3-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9n9on7fs4ndb66ddbu936kunaym6nt56
X-MBO-RS-ID: 49d0cf3d55fb03e2dc8
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:34, Juuso Rinta wrote:

> The wdt command keeps the selected device in a static struct udevice
> pointer. If the driver model is torn down and rebuilt, for example
> after running 'ut dm', the pointer refers to  freed device and any
> later 'wdt' subcommand that is run without 'wdt dev' uses freed memory.
>
> Store the device sequence number instead and look the device up with
> uclass_get_device_by_seq() each time a subcommand runs. If the device
> has gone away the lookup fails and the existing "use 'wdt dev' first"
> message is printed, with the selection reset, so no stale state is
> kept.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
