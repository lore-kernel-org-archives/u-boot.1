Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C4606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SoC22xff;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NJ/wrFUA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81C7F407ED;
	Sat,  7 Nov 2026 09:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayW5tTjbYii5; Sat,  7 Nov 2026 09:02:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF665407EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042147;
	b=i6jFSDmr+j1lBke+rd1Jk08tWcbktPAAIIReHvFARZ+x8swugsAETkmeqrpOtmvzmz2v
	 N6ZLs1HCog2VkP1ejf5Kw5LGrscMKIR1XNVJ6aMxa78NPbUQ0MCibUwOmhWhDsMYi+1D3
	 W2zDac9KCyJmXWumzP2C34NgCfpD4BgqGt0Bre4tdbPo6SwPf1S3KELDMLcgNr2ItSJL/
	 ODR5eSqLzjLRigFC6RRqEMXYFnWFXAqwBYpbpDgAptfPHYqu0CMbX3CZ5rHiQaZF4eHoL
	 OrL05CE759Z/AzRLif1ToJrNfVEqahy3asLfAtWtGHgvas3Ys7J9cKvpvhoN8MpQWQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=13r1nzUPYsDDq5wO/M1u+adx0E1gz6yNNId8F2gVijY=;
	b=Ek/tO3aP4XViuizL0oncREO4ooYDeveAPnTn6wrlEhjpp3Y+Gw3+n+QDo1dhGqc5674R
	 DhNoHChyqySSYxbNe1QvfvDMhn4b5zsk8QlGE1vmhHhrEiZ0DMzQdT0kegurfq+vfz1NN
	 PZV8dREMzPLn1FOXAy/GcEeHMMRURwZZHSXCAaV64+fUuqsKE1iNK0Bct2AXFGwPy4ZLr
	 vvUTfcAoq8dQwv2259V1vEM5k79f+dSP9X6lmnt46agXvuDw696x6NQGw7ftqBUgKWbzi
	 k9Wq/Sr3tH0wvLg8x72v4y/L3aQXX1mH2LhjS2j84l46t0B+tj6dbQq+8xLRl8m5uRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="NJ/wrFUA";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042147;
	bh=13r1nzUPYsDDq5wO/M1u+adx0E1gz6yNNId8F2gVijY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SoC22xffH1T9UjCtnLEeMlBQvw2zCaz8+J9pEWRFcrauloiOCtUhACcS6OPHjm6Kj
	 IX63HWbThO42q+nh7ahyKezpWAkOT1IjatFnAarUNyGHVIlO9mdXqvph81OAql2dUz
	 S8Aa85L2Muq7BxDow/Z+3zENkSzv/wUFegR9SSKmz+CSx1/UXUkQ4bff0XJt90I84/
	 JlNE8LOnHilVkFwegkh+YzNqBlIw04z6MRQdSarCidFc/iOwBCVaUdtsqu7K7Wiaif
	 x7HUoXYdDLQNf2MwG3zoTvrBY6cDFXJoqqiSqIfntwaIJFWgF161N63rBXA6JVY/OT
	 D4fxQrh29dfwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF665407EE;
	Sat,  7 Nov 2026 09:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAAF12E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D066E40634
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6UhDUAIzDDP for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CE1C4062A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NJ/wrFUA
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CE1C4062A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jM96G2VWpzKnDj;
 Sat, 07 Nov 2026 10:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13r1nzUPYsDDq5wO/M1u+adx0E1gz6yNNId8F2gVijY=;
 b=NJ/wrFUAKjiCJpxXwCizIv7WltJ/6c8Q8LjrqNWphrs4SdmW4U+4DKUptvGgykdpyeolec
 tkqSgCKw5s1J2K0mg9j4/GtC2nc+kx6D0R1wm9J7Q3AalprhCZiD/GDhEzjmyqpcJnc3Ha
 CAWs9VV+uS2+yaKGugoTKcWyDBkbRzaZP6E55s8rd5KkIr8qTa9k2fH40YP6IFJg1My5nq
 Hqs6fFDLRi8Qq2KbKyduSz2uALhYI22vKpQ2TKjDareADan2DoHo9ngP1T5U9Zy7cehc10
 LAmztWN59dFkb+H5Uhdzr/SmkDfyuwpppQL0oztSFCIPOIBc1MtBC3sv780fNQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 6/9] watchdog: max6370_wdt: use a lookup table for
 timeout selection
Date: Sat,  7 Nov 2026 10:02:00 +0100
Message-ID: <20261107090206.2015512-6-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-6-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-6-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: icdtcaz3skxssqpqrgygcyqwowi1bbii
X-MBO-RS-ID: f0dca444e3c3184255e
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

> Add a lookup table for the possible timeout values. Replace the
> if-else chain with this table in max6370_wdt_start().
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
