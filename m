Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wJoUCWme;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=h5Z1g0O/;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=in9DVG33
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2CA040748;
	Mon, 23 Nov 2026 15:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PApwGVwBYSOQ; Mon, 23 Nov 2026 15:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60F9B4073F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446432;
	b=inwzNghvP5s1xOPxNZ1SqD0kU69fuNPkW3321n+T6XcSH25a3QC17YF0dILw8KhyxDAu
	 jHRI5ONCCzsXl8wig8y/tMpFDv4FfEAxeolSHyJ16QsAKvSCRR1wZU5s/KA8fL9INc63r
	 uDKKQQln6tFqn7xgo+9QE/UiBRbTCfKlmV6RYjdYcZKvw0eqfnWWMHjq+s1zLBvuAYahE
	 YIo8rUF0jSW39j86hv0DhjaJ6Wq7jaezfhlQNx/kGOOpHaAZG3pu25u6kUZA5NbVtTAcf
	 Uj1W0+dk8z132VzCiJ47bp1FQG4jR9yuvu9/knSf4KjkPPmgwGJr2hC4nipMIPmEjbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446432;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2W6GbnO6QOAUz6bssbUcKAdGfHWjxwyrmKWDjfLUxJU=;
	b=l4w2QuNGamX2L6cKV55LkyUkDGBNoYswJE43QWM4t0yh2ogzMzkDQOYULozjk3462yJA
	 ffKj5hSd9aH/7yDmATFf/5rmOvM6I+v4Ja71X8XJfuOMo9q3o5FYF9zGWvxRAjDPmpIgD
	 PR7FoTAL2tjIXMmj0Y23RBzFxwu/5Aw7xqjMBYUMyI6Mqjl6w5SNc7M7YdjtzamyofTb1
	 RSchCschiV+vhLKmNTNfm8sUS5CzEGHLBpuhCMOesMie3uerVxIfH8UxLGUfvIctuvAdr
	 QvP/nDFiNvcUlfk1PFcVjuSgIsSY0Okpfmwr1oGO6eciZomKvU0jkwU0EzdrfPK1fHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446432;
	bh=2W6GbnO6QOAUz6bssbUcKAdGfHWjxwyrmKWDjfLUxJU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wJoUCWmeZ/GB/4EUCBE4KmJIz1t6WOKEiLZogk501O53NBXf4JVyivRHfNz4/1hLk
	 11SDP9CYT7xK0+7nLOJz3mv7xNlPBwz33dpJjHYtZEWczi88fOWQqqrm7dp4cCNTQY
	 mBSf7A9ZRcK//0+G7SC6yK4f8+VvgFYL/mza70hjmbT+3HHKvRskSsVS1N0DH/TYP2
	 mAh0a2EpVtABj7HKCqg20pMPketpB1eiacP7dV22mh6y16G2f15AXXk7RGZKHIJD+O
	 6X/b27kB+twJYBQZdQz20A7MAd+NsQbHSmKV3lrN3W/gR+WC/L1CKtJr9UpSfngY1Q
	 5xUyZGAp54uCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60F9B4073F;
	Mon, 23 Nov 2026 15:07:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A3FD1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8011280DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FZBoBGOPeevj for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:07:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6873C80DD1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eede=jn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=h5Z1g0O/; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=in9DVG33
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6873C80DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795446424; bh=2W6GbnO6QOAUz6bssbUcKAdGfHWjxwyrmKWDjfLUxJU=;
 b=h5Z1g0O/h264AQio9Iok3Vem3fsQkTmjpW43K7y/mu2reGH4ArBxdaQGBCmZW65vq1wD8RPan
 z8Z/bGKv/dwXpKN8r7ivaa/l5HZwbE9Kgt+zVkW93OZmpkavHfbi/9oX5rl5yW90Rp1hSia+j4m
 XsPg90sxkH9HQLxLAVntNmK/k5Iw+dmd4sW/pkCpRHiHv1I5IEy/SHR9/WJIql1RB6kGjVA0z7p
 /5nW89YDq5rZAK1BptR03aQd5NAfSJ+1g46OFN9h1mGZHcXJI3U62nWTa5QqJZ7BHDnWA3uBHrZ
 /WjoEp74o6ozb46XGedrg7FT9UibFZAdxd7t22pSVGow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795446424; bh=2W6GbnO6QOAUz6bssbUcKAdGfHWjxwyrmKWDjfLUxJU=;
 b=in9DVG33b9ASwd3zsQpQMEnPeJ5Nq+YhH2SrlIynMjGCxMTTZA0pNRTohxMbHzXuVkfR2GJmh
 pwAIY1p5f+5sBGjy5HEB+RjGwcF/5R+r0x/36W4T9SBRROIyVJq+Q4G5e7qMtrkaldVWKBbyzwy
 i7sc0lR2I+Fw0lDgzvx14ro=
CFBL-Feedback-ID: 6b04569431d91c9369aee171:43ff40508b1637de069a475bb18187cb
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04569431d91c9369aee171
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: Enable use of OP-TEE for RK3506
Date: Mon, 23 Nov 2026 15:06:51 +0000
Message-ID: <20261123150655.1397175-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Vendor OP-TEE blob provides PSCI that is used to enable CPU cores on
RK3506. The OP-TEE blob is expected to be loaded and executed from
0x1000 and uses memory in the 0-1 MiB area of DRAM.

This series add initial support for loading OP-TEE firmware on RK3506
and to reserve the first 1 MiB of DRAM for OP-TEE use.

Use ROCKCHIP_SPL_RESERVE_IRAM to pad beginning of SPL to avoid OP-TEE
blob to overlap with SPL. In future, using a different load address for
SPL in idblock v2 header could likely avoid this padding. However, we
currently does not have a way to configure what load addresses should be
written to the idblock header. The padding approach has been used in the
past and seem to work good enough for now.

This series does not have any direct dependencies, however other RK3506
related patches may be needed to fully support devicetree/boards that
have been submitted to Linux [1][2]. A branch that includes board
support and other related patches can be found at [3].

[1] https://patch.msgid.link/20261122060114.773624-1-jonas@kwiboo.se/
[2] https://patch.msgid.link/20261122184532.1300004-1-jonas@kwiboo.se/
[3] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Jonas Karlman (3):
  rockchip: spl: Fix use of ROCKCHIP_SPL_RESERVE_IRAM on ARMv7
  rockchip: sdram: Allow reserving a region at start of DRAM on ARMv7
  rockchip: rk3506: Enable use of SPL_OPTEE_IMAGE

 arch/arm/include/asm/arch-rockchip/boot0.h | 10 +++++-----
 arch/arm/mach-rockchip/Kconfig             |  4 ++++
 arch/arm/mach-rockchip/sdram.c             |  5 ++++-
 include/configs/rk3506_common.h            |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.56.1

