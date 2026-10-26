Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ul4IEUD6;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=rMKrYNbC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LMELAlmJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89A3180BFE;
	Mon, 26 Oct 2026 23:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sLK3di2i2mE; Mon, 26 Oct 2026 23:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8641880BE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058671;
	b=cJCHcYF0BlTJzZAgKMgZoFxJNZ3ab1EBRbPjOJarc1eBWc2ixfsy2oGAmv10CNrFxy7B
	 xtU0Q2c7IrILxVLkjsUW1oSAANSUQMc3muIaHfTfNje0evjMtS4bGKxI1BtlElDlwOexf
	 X1r5ac3pOM0JHtq+E8uWpHO7KrICVEEWAS8zNX9QwR6eaZJogWNkCjiAeqDLVTdCexBqJ
	 F3CXck96uDLOfBM9awmk+x8hMrN5b53HkUx+mo1CZV6G38uyg4oDRs/tMMzty+ZUE1N6I
	 4YF0I7mgV/6RNNWifIBrDWM53J1uZ0neER+AOE0+wUl2jOErX03/jWjtH5p5VotCI6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bg5aWyMfAgjuFugEBzEG8Te1ArIbMI6WtSXEHNrEjbs=;
	b=Odb+5eyV83cJE8lcCt1CGfLfkXWksumAb8MaLtlK1PhnhvHYNF8DVduwR9L4dM6PC3cU
	 L6bda5Zo+n3/q7HrK1m6VyPW1FZEmArS3jLqit5Ax+G+nya0N8IvFJcJZB/uuLfpiti9S
	 ahI/++FFXYx2KpMmvZ6ROFLlhDTwaOQtRI27lqyd/8EwczHKFmlQnzuWwwj+opjl1me0b
	 /eyos4Tr/hJpYYp6go7sWQR/XcL+NUVbCQCwvhHGVA+wCxn7eWdGgSEr91BLYhNZfjNNH
	 o65RV18dZk6dsZKzmlF5EzI37tXX6lghg7WU7f2hqgK1/FG6C3GpreSZqDI9Cf52r5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=rMKrYNbC;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LMELAlmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058671;
	bh=Bg5aWyMfAgjuFugEBzEG8Te1ArIbMI6WtSXEHNrEjbs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ul4IEUD69emhSe2VrnRznzwEFpAg479yvD3xSuI6qsm8sbOzL9izvGM6gmmB6wgQL
	 DuUF+TIC/yAsKk+E4ZsQTQ0KxtUJXmyKVe7WxV6XLWsh5b3r3FcqZU72740SgRWyGv
	 rSniRFn+NCvxcG+qnK8pKGWrj0FeRQnUC+jG9Wj89AhqRxkK207qsGu9EqISP1xR31
	 wI4p/ghxjF3wYDSMiFsJWbPsAO1ORUDVL2ZE79DrI4mmu+S5ey1wBe2ORRju1kbqZl
	 BXu8NF2JtAEM5PbSkif0Nt/Z8Sy58OpuJqbl4IDnMoP4O0QJxvnMOTwjYBe68JtJSJ
	 IJDRqSlQFJhkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8641880BE8;
	Mon, 26 Oct 2026 23:51:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D1AF2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FD4380BE8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHZDg5rp7bP5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01E4A80960
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058668;
 b=Mx5V03FBCw4dno/zU9tuWVyanW/MsImmu03n7LUzTi8HaXghnHDyx/rsiJkniUmMJRz/
 1ljHiBwlHVcOaoTtJFvHrm+NDgdZK15CiWL411ntQeilXQ7WNe3FjyMjaash+AsYFb0v9
 MzBkDtluTwvm2b+ijFFSwWp4+xe5/oizMmLxmUexs1HIOA7D+rd6tSDKx7q295OQMQRx5
 TADW2HuL6hpiphuPTjyGw4pSlmjx5TptJ28t1ZLbl00KyNFUXebFhsZ5MFC9bjeoKAjnO
 jm1vAYuzqyUHCS3SGgXpP23wpLROOYr21PUQ6iZgmqMXsSV/cXeHmLp6QBPzLCB9NQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058668;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Bg5aWyMfAgjuFugEBzEG8Te1ArIbMI6WtSXEHNrEjbs=;
 b=rZj2JYJWf8ha7Wr8ytHCUznDJMO2BH9mM2xfUmwUPucR4B+nVrI/yhNbFG3rJNIQdJJq
 CzyTZQRCAk5Pi8hOBG1/OCKoUG7iSW8QEuqLa7f4ar7I7jrPBOn+YxzaPSMSf7l8KXdoy
 mZEK9OQmnNG7kZ8p1jk8QA8d605HPD2Xj6QvpgbW4juD9Lhq8cazseNi7v/i8SX6JSG+e
 f9sglb66EdCiivdIFb6Sfa2sHzu40GrH5ihzy9na6hSIz+y0kSqrPshPK7onp/diPsdcz
 P3kJI9q9xonbrHYWZiHvXHlkgV6HZfDZvv1V+AmOwn9d9vklGAOfI5pXhbuuUYzXeZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=rMKrYNbC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LMELAlmJ; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=rMKrYNbC; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LMELAlmJ
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01E4A80960
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793058649; bh=Bg5aWyMfAgjuFugEBzEG8Te
 1ArIbMI6WtSXEHNrEjbs=; b=rMKrYNbCjqHl6aU6u40cHndMW3/z4TAJkMLjP90gZLunjlpPUU
 89sdmuwh3usSWyQ9YBehMAYKZ5swDGvM+KmkySw06ogDIIOjxZDiQiYcUQ1dTlTxebeNSijvphb
 upeJO05FxYb5Ql0UqIaK2R3KgDvq7R7hR7Jf2AVyRTppAAv5+EgV7+VdbH+SHRql9z927fNziaG
 TG0VBaF2oMqOAofKw0AELWSccE+s7P0zN0wQDw/qp/p0ECxlS2L0PTakQaDnUzsFicjzanxTXMI
 rmtwHWYGymFrcG3WFiDH44H0oUNKDdjIk12aITKdYe0xNUZyLwrim6JS7TFK2Vt9zjQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793058649; bh=Bg5aWyMfAgjuFugEBzEG8Te
 1ArIbMI6WtSXEHNrEjbs=; b=LMELAlmJIS3qbuH14OXV16YzLYAIBvgVS+xlPGu7029QwjT1DA
 du2BxxI3z68gN/kv3e6S+qL2gf4+1HGh/0Ag==;
Date: Mon, 26 Oct 2026 23:50:51 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Bradley Morgan <brads@mainlining.org>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_00/26=5D_powerpc=3A_drop_unmainta?=
 =?US-ASCII?Q?ined_boards_and_SoCs=2C_take_over_maintenance?=
In-Reply-To: <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
Message-ID: <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26 October 2026 23:47:58 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
>> PowerPC in U-Boot has been orphaned since October 2022. Several boards
>> and SoC targets in arch/powerpc appear to have had no active community
>> maintenance or testing for some time.
>> 
>> This series proposes removing the targets that are currently
>unmaintained,
>> to help reduce maintenance overhead and ease treewide work. If any board
>> maintainers or users are still actively testing or relying on a specific
>> board, those removals can easily be skipped.
>> 
>> [...]
>
>Applied to next at u-boot-ppc, Thanks!
>
>[01/25] board: powerpc: Remove MPC8548CDS support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/91332bbfa36c
>[02/25] board: powerpc: Remove P2020RDB-PC support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/74f4118d5607
>[03/25] board: powerpc: Remove P3041DS support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/f345ae08fa06
>[04/25] board: powerpc: Remove P4080DS support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/c7492940bf9a
>[05/25] board: powerpc: Remove P5040DS support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/23f32a1d1eac
>[06/25] board: powerpc: Remove T1042D4RDB support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/bdad411ca572
>[07/25] powerpc: mpc85xx: Remove P3041 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d63e5fc8303c
>[08/25] powerpc: mpc85xx: Remove P4080 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/353f7e2edaa1
>[09/25] powerpc: mpc85xx: Remove P5040 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e85e4e0e26b0
>[10/25] powerpc: mpc83xx: Remove MPC837x support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/286b4f95a2ca
>[11/25] powerpc: mpc85xx: Remove C29x support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/ab46013e050e
>[12/25] powerpc: mpc85xx: Remove P1011 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/244d495b2d72
>[13/25] powerpc: mpc85xx: Remove P1023 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/07b36f2f63be
>[14/25] powerpc: mpc85xx: Remove P1025 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bf43c8d082d
>[15/25] powerpc: mpc85xx: Remove MPC8536 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/9ba511b59ce5
>[16/25] powerpc: mpc85xx: Remove MPC8540 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/4e2d7d590196
>[17/25] powerpc: mpc85xx: Remove MPC8560 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b75b1e387d83
>[18/25] powerpc: mpc85xx: Remove BSC9132 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bc1536a913d
>[19/25] powerpc: mpc83xx: Remove MPC831x support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d7f92247c56a
>[20/25] powerpc: mpc83xx: Remove MPC834x support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/64c720ccc8d3
>[21/25] powerpc: mpc85xx: Remove P1024 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/97ab3bbd4979
>[22/25] powerpc: mpc85xx: Remove BSC9131 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/afc835c3312b
>[23/25] powerpc: mpc83xx: Remove MPC8309 support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/6e2405d54e5d
>[24/25] powerpc: Remove MPC86xx support
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/dbb43f735a5b
>[25/25] MAINTAINERS: powerpc: Add me as PowerPC maintainer
>        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/86b1f677e263
>--- Thanks!

Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.

So I would be more than gracious to rebase if anyone was to NAK any patch
in this series, I'll wait about one more week then send the PR, maybe two.
:)





--- Thanks!
