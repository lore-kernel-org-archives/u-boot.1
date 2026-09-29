Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B6CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 10:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D38C40619;
	Tue, 29 Sep 2026 10:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNj3npVeT490; Tue, 29 Sep 2026 10:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 43BD840602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790676701;
	b=Fvk0Lhlz6E57RokTiB1q//zOQms8X3FthERiw5ffugaUb/HGs3LMlnD3KrYmMy9wxFI0
	 z/oFXWl0HEd50LLHBdzTmhfeEX0Oeg/h7vTauEZkEG1crhJDIt0McdhhltNC5ePOF/Xwu
	 wlV0DGncZAw9iYYU9D/lt7rY5Os2TUsRuZZTEQZM5yRN57e1AO6JgCd536CoC+/nP5fvJ
	 uUTtLdG7B0Q8igPl9ONxMkqf/j56KqJHp9Xi8dXTWZCfiS9vdaEfdbkofO2HPXnCZQI0A
	 lOj7hZYUEyd25BcZB1mJprBrrrXErRjGCLfQGWdwmNA75eIv06bbBLEfkm7MFS1qEKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790676701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f+7b2am7U/fNd83NIlYeG+3nqfiFSbllLeH0x1SMnAU=;
	b=BwukKSoPN4qOMcA+Xgn5J1VmBNW/KSBPmQLf7pBRktkNTrSayIFVhWq0u6pBiyZWTrB8
	 2w+yNUkd9nFEc76JuZt/XX2Znei+G8tXBnIPLC/UYpDgfgLE2OLq5C6bnZnIzBzOIm6KK
	 KLo/1nIleEywxvZPbeb614IW3vwM0uAU9ZFY25a1Iq9uo3i0oDyj9osnwqKTp+SWZwUyc
	 17rZ0ks/VDR3DkEops2Uvj5Y2uSXvDDO2Qw499y7AmUv2PvSfrKBFuszSA5eDocPtTSzI
	 JAwNqZa8mTYMU2z2y0Y69RZt4yf1CE5Qq3tNzzB0NlVMFbu0847s0AaEfSMiPQrvVVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790676701;
	bh=f+7b2am7U/fNd83NIlYeG+3nqfiFSbllLeH0x1SMnAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KWsrxnArPKIQcjI2yoCk+714GqHShX/WhBAkKnoETo7OiktlXb7UoJwqReOUtyaEv
	 +cyM9o1f4LbUjkBcEHWDGLoLKpJrBd43DHdKd0Ig/6CVNyYtKqNl3nCsP0bqo8huJK
	 pGqWAM/7wE79wNZpSMLpshLfPLQwJAPASgRC5sA1L/dAzUIHGzi3FipNNsL5c6Ipgk
	 RJAlDTHxKOKaqRAHzULpkOSdK/L4tCgxR+igIILL2vbufv+6MDv1lG4trSTJukd6gz
	 5hkBGwLJ7FNlTZ3Vi/6JnJPCM3mji5aBSpj/kToXqRH+Z3MC/peWMDbzJXvR7h3A/8
	 bHF3bFuOjFlyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43BD840602;
	Tue, 29 Sep 2026 10:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 568FC3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CB416074E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwScnEisXv6a for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 10:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B1DB60729
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790676698;
 b=Z01aApAkVrrKMlTmNmZ4MSa1NzSCkVeh9svQ8656/gscJNL7wWtdHTBv+jEkwuUyZJqU
 ugpud4Ri4zCaBnU5dTkMW2xRxMFrJSNKRQTATmZg88vdUz0GTh/EQ/lkzEnR9S52gNAK0
 +I89v2gadEx1rv0jnAsH1XsYxV6NF/nc52OmYJBIRwFc45MOe5WFq+3e18LZmwHH2eFJD
 ACqORNK9K/tKqUxhDip0yZnRlRSzez7q8p3KQ5i2Ru2aGuzw5UpUB2mmWfYZnr+P0kxeg
 q1gciB9+vLJtG5aLJBHkyAijgnO+aN41Ed1HQ+1Xxh5Mj8A4xG4d2rT6L7k9t3YIj7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790676698;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=f+7b2am7U/fNd83NIlYeG+3nqfiFSbllLeH0x1SMnAU=;
 b=SRFuvXruCv4TKsqPh9KFMawMGcPgp9fgnbjHeRXQWB9x1o0X5q5jN5TUo4+j0sP/tpwB
 tXCGTsJWKWC0YI6RPzMZz2UHfDXLvQjkWdinNgLEkOjarMUmtvchYZuwafnXZyVZnEY1F
 J+RQjo43whpOzh20+v+RrfJbrwztHJcKWmzbtQHLkVCVWxDQfhDRtDEsGi/ifJYYrppnt
 ONXzt3vHNLq7CmBT3SEUrvn7CGjcA51NHjY0+ahajEiY2oRhv7//Mv0kMN9eXAL4I8Ek3
 t0+DStcDa7enaqSs3jnrbLPnG66D9o72tkTgik114itPBaVzYC1fmUOWSyd64SK2KeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XDm3XOWn; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XDm3XOWn
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B1DB60729
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:11:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D3EF602CC;
 Tue, 29 Sep 2026 10:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF9A1F000FF;
 Tue, 29 Sep 2026 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790676695;
 bh=f+7b2am7U/fNd83NIlYeG+3nqfiFSbllLeH0x1SMnAU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XDm3XOWnzjYQTlpTX2Nr4I9Y4iGqIl9X/lpUQF1hh3LCJ9dBpGSMpgCFyECDlfoDn
 T4rZS7zSgwehvesxA5p1qeG+9IljsUEnR5Xhjvn3Ig3+5FE61rtROUWSHHhFzUICyt
 n1zSgjwMyFp2FqIH1VC3DfrERY9AQNlhQ5AiCsLWrXXPmC7VcIeWlkO0yPCDbsjA8X
 eqfM6ixOZ30wCf+LM3FRfVGNueTB7W5f6Fp16H2IrdYpGmGD520cA5fJr+CyviHkCe
 ETG2LkcFkMz4lXY4AHePLOozdwasrBs3iwawYYWBxuVAUmrOU11b2KR/Mz74siLL00
 O7CMTorcR9bWA==
From: Yixun Lan <dlan@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Huan Zhou <pericycle.cc@gmail.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
Subject: Re: [PATCH v2 0/2] pinctrl: fix on Spacemit K1 SoC
Date: Tue, 29 Sep 2026 10:11:15 +0000
Message-ID: <179067636289.1554964.8925266076160246530.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
References: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Sun, 06 Sep 2026 17:31:58 +0800, Eric Chung wrote:
> - Add IO power domain control register programming via APBC block with
>   ASAR unlocking for dual-voltage GPIO banks (3.3V/1.8V switching)
> - Fix drive strength configuration: use FIELD_PREP(), preserve io_type,
>   return correct pin number, and remove redundant initialization
> - This patch set is split from the spacemit mmc: https://lore.kernel.org/all/20260819-m4-v9-0-6e66016392b9@riscstar.com/
> 
> 
> [...]

Applied, thanks!

[1/2] pinctrl: k1: fix drive strength configuration
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/2a8df8759350ac00bbfd5ceec96aad1d03f6a1fb
[2/2] pinctrl: k1: add IO power domain configuration support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/b42233010428b64b546f1a72f62342f130d87d47

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
