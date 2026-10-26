Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8D606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wz2fAjFr;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CGe0e8rk;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=qUsCA+i1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 737FE80BD1;
	Mon, 26 Oct 2026 23:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WIrc8Hj8njgK; Mon, 26 Oct 2026 23:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E4AB80BBE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058504;
	b=rpTJVy93h2pVRNpGjB+HJIByea9cQzo6MWayE4TYyQ/GJUlya/SpgRm9z+pswlwecGSQ
	 kZiCD94Ev8KcGNgzTyM9dcxwIQoFXTKGNAzZ/S6pqQqG1hHNdKExRhp5hReRAli/yRza6
	 axTBT7xKv8/SfJ3clnpMLBt1h2EWMmzuTCb4RBkajVWOIrtzydiAEQH9PDWgDU38IWoXn
	 UkjSjBqCs0OumKUWIqZh5ZUfDBiPv9RL+Sum75qW0fPYVd09fp4xoZ+qjHkPrnMuB/YWr
	 UzDYX53OWq+OFJWdJAKR65k59Kneln1UhO3qIf1UsmNdaH0qVtiIU+OvJ6K/Qtj3Rhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=quuXTWBu5lP9MeDGg8uFGibnV/5c9/JDUKs9O7V32VM=;
	b=jjO9WaPBCL7Qnxfh/yD+Jzui17oSdCvD7xCr1lmu5QXM4VLI/TSSkkpFxmHGX/CSyDpJ
	 lrA+61gi78lXbuvP04JtUStSp8JR+qZI+HMcrpbn6bjFx3PJmshHrWH90KKEYCbFfnrQu
	 FcwyoEusTcBs5p0DaRiYHGMAqnmj/sjiDTiOimC4XDaMuBvyQcdG7sS/njq53uwgYtj9K
	 co3R5OmRgF4ouSaqGHbKykg58P+OMZjSrZrkBOBFYiqvR1D6kQ/bFXRKZBcR3cdfs0D3q
	 6QbXZU/bdxa613xL4GsOTNuHbZRaW8vqDoz/j4NzYjvWs5m9/CrDjfO+kdTefu1IxwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058504;
	bh=quuXTWBu5lP9MeDGg8uFGibnV/5c9/JDUKs9O7V32VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wz2fAjFrKny63VepmOwCVuUOMsDpXo3fDleZlE8IFs2XRC0IfPyAxV/l93vc5HzJJ
	 c+0RAnKA9vfwexQ3AZduMNrO4KydqxZNS9FMVnq4Af54gyZFoGIDtMypxzzg463nFJ
	 GOYoP2OYSOfJH+FUhYitN2Z5rCD9BMIEQMH5fUVSiHxII8rfwxExE60PwIzn/q7ALv
	 KR7c9IZhxxcqSLRt56+CLK0IZDKXnhkJP9986wifUryQnYMfmW2qW/jrAAXxRe5Hul
	 cTZl61YCdgYJELvMtZ4/7CpAYcDrPxR+8qU7axs1A8/TATnmHtZr6Wd0IyeCe7i5pz
	 JJ+bs5TdR/P2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E4AB80BBE;
	Mon, 26 Oct 2026 23:48:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 119A02F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 034314023D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id m9_s5Bx00ZQU for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9350A40205
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058502;
 b=QhYxjFwdqxhdg0n8dsRgijbi8YyUsiLHT8yFhPxYoQkwhAmjmtv1ZVu5g6tEI9hrTMMB
 lDV+IGWiWAZ8E/eylRCrrqAy+4b2ENWm2YilvuRXn6obRmXfgil9EuTUC/cc6GZBKoRFc
 BSKDEBnTMhhZJ139kibIeHOoAI0MKQti/JsEk2b+EkeH7wOtr7Hh5VydKB5nDNSX86wG6
 OKsafpAaGgBPQKFkaC36F4j97wTvEhq65luBKJwvTfJ0+pJkOX2Q+OBk8LmPAkzjCkpyn
 oW5giTq2w+xGAsbWj2ck9RGN2s7OwHwXnDO7ulxCGZ7FQsiHcExLO3yAennzy6kinkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058502;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=quuXTWBu5lP9MeDGg8uFGibnV/5c9/JDUKs9O7V32VM=;
 b=qXj1MOmS3G6CXp1hq+K3lPljvp7ycriVZCA79JBL4W7rbTiHWdwtEpilNsdXjj8H8Eld
 uPlIDcV8R99AwFPIU5xbvb83rrxg1iln5ikIDYCET/SBGuoSNe33lGIG/+hlqehGmrOHJ
 dvaJJ4jC6IOUcTB8dZQDuRUwf/BLwIZE1yLgutiPJmt/nCtU8B8HrD6IVTXMPVgJYjGQ2
 8m77daQr0Znf+rQeFkZK/3vMLz8xiAv94ZXmpzhDhVOVNW9ckhtAC1KF9sMey4A/5wPkX
 BAVXQcdARIDsoqYkDT9ex+ue9FI1SyodP70fYqwC06q9HqIB5rt5cKENDEemMuMLf0w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CGe0e8rk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qUsCA+i1; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=CGe0e8rk; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=qUsCA+i1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 9350A40205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793058495; bh=quuXTWBu5lP9MeDGg8uFGib
 nV/5c9/JDUKs9O7V32VM=; b=CGe0e8rkjPwfbQi12nWvwjwre7sxVI/X0wuQcPFpBA15qJma55
 zmkV4t6EmXZGAoboM0MEBQEu0ddn6xi40kjUvjIoPXDBAkWjvxsUci5SFjFu6M7mACk9pJRABGZ
 bUiSdSkhwX/SKQ5KCry44dV9sVsh1J2jBUkrV3xPA2VMM1nqZ9uvS5PWX0L5Lir22kggB8sHaUE
 f5Rq1t0YTl54GYru90hGzpGa6+Uqvqf9cBcdA4G8j/WYthceaAzJepjCI0GIgAj4qHyN560NTRw
 ZtjAg4K9Xwdpas4Va2CriD5WK5BsL/gYEQecK+qIt6Fc0GmkRvBEksCWSsEvsUxfZ4Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793058495; bh=quuXTWBu5lP9MeDGg8uFGib
 nV/5c9/JDUKs9O7V32VM=; b=qUsCA+i10aTqSixKaoH9B5DoKt9/H46Uj+ShX+Fl4EmlCXKFIE
 Qcy4glIrNF06nXZ3RD6KhhURSB1PuBwSdrCA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Bradley Morgan <brads@mainlining.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: Re: [PATCH v3 00/26] powerpc: drop unmaintained boards and SoCs,
 take over maintenance
Date: Mon, 26 Oct 2026 23:47:58 +0000
Message-ID: <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
> PowerPC in U-Boot has been orphaned since October 2022. Several boards
> and SoC targets in arch/powerpc appear to have had no active community
> maintenance or testing for some time.
> 
> This series proposes removing the targets that are currently unmaintained,
> to help reduce maintenance overhead and ease treewide work. If any board
> maintainers or users are still actively testing or relying on a specific
> board, those removals can easily be skipped.
> 
> [...]

Applied to next at u-boot-ppc, Thanks!

[01/25] board: powerpc: Remove MPC8548CDS support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/91332bbfa36c
[02/25] board: powerpc: Remove P2020RDB-PC support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/74f4118d5607
[03/25] board: powerpc: Remove P3041DS support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/f345ae08fa06
[04/25] board: powerpc: Remove P4080DS support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/c7492940bf9a
[05/25] board: powerpc: Remove P5040DS support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/23f32a1d1eac
[06/25] board: powerpc: Remove T1042D4RDB support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/bdad411ca572
[07/25] powerpc: mpc85xx: Remove P3041 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d63e5fc8303c
[08/25] powerpc: mpc85xx: Remove P4080 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/353f7e2edaa1
[09/25] powerpc: mpc85xx: Remove P5040 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e85e4e0e26b0
[10/25] powerpc: mpc83xx: Remove MPC837x support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/286b4f95a2ca
[11/25] powerpc: mpc85xx: Remove C29x support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/ab46013e050e
[12/25] powerpc: mpc85xx: Remove P1011 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/244d495b2d72
[13/25] powerpc: mpc85xx: Remove P1023 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/07b36f2f63be
[14/25] powerpc: mpc85xx: Remove P1025 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bf43c8d082d
[15/25] powerpc: mpc85xx: Remove MPC8536 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/9ba511b59ce5
[16/25] powerpc: mpc85xx: Remove MPC8540 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/4e2d7d590196
[17/25] powerpc: mpc85xx: Remove MPC8560 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b75b1e387d83
[18/25] powerpc: mpc85xx: Remove BSC9132 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/2bc1536a913d
[19/25] powerpc: mpc83xx: Remove MPC831x support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/d7f92247c56a
[20/25] powerpc: mpc83xx: Remove MPC834x support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/64c720ccc8d3
[21/25] powerpc: mpc85xx: Remove P1024 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/97ab3bbd4979
[22/25] powerpc: mpc85xx: Remove BSC9131 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/afc835c3312b
[23/25] powerpc: mpc83xx: Remove MPC8309 support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/6e2405d54e5d
[24/25] powerpc: Remove MPC86xx support
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/dbb43f735a5b
[25/25] MAINTAINERS: powerpc: Add me as PowerPC maintainer
        https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/86b1f677e263
--- Thanks!
