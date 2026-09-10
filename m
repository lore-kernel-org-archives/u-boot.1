Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD0C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 07:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9708360885;
	Thu, 10 Sep 2026 07:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ON5RrHbMrO2k; Thu, 10 Sep 2026 07:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A743960860
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789027062;
	b=hirbRFLw1irM1lA3FXhTBo9Ffoe64nyOTVB9F4JYke1F5ZfePmsP139wH2fkARuEBtjV
	 zErU77gtF1FM1pzWWLDyWhUMHlgEgEyeJLBPrf1xTXxAQqKlp76MUvAt42aITw0ORIjaz
	 /7bdofwhMj1NE1ku5JoVJSiAl7wQW2Sg+QUmB30jQiY51/TMT6PVBZl7UYFvVIYTsKuiE
	 fxrVE7uqNnNhAILDK/cJq8SbfBSx7q8KcxwbB+PjyeShjMQUf5fndx6DgCDJWSayOawH/
	 BrXl22kpGOqshXHLFKpDdB4J9sjEpHpZAz+kU5ylEeT05uPr5ZW3dEaMqBBnvtn4VMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789027062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l/zRsc1sLaXs+Scei5gMe2f+hP+nXkbwUKy3gmHfiik=;
	b=ZO11Z5KFsbmq4IC2RK/K7XMeHrRjiTzqdojnMQ8MxvcJ781YBvq5d4QZWut5NcpYd0bA
	 p8y+Cn68FhtxGiwb/Ukw6HPUoKqG2T6Ww8/EEuufir3n62m49VD7NaO3MFizS8+iICsw5
	 9bfUeleSvZaJbOfA5ELecndUW9EwGIlwEG3Ov/YlWRE+uCGz96/rbs+XGe0hhaIoCJf4/
	 pO/6zENtOth0tfctwonHaay6ASdWwCUJSibasS3GGxvOtKdbwqwKLa7rjS9wbKQqGSfi8
	 OlpaSgF9iiMXmmmX3RONBBWbDzuRLYuLT/iXO8rpaUceMwtQi66Daes9WjoUqICvx8w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIGN0yTd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789027062;
	bh=l/zRsc1sLaXs+Scei5gMe2f+hP+nXkbwUKy3gmHfiik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2DDeS8yIjEu9pFEZyukjyA45NByKdUNilGcaiQh+z48s/MAO7/AlXxzNFfeh/B6S
	 04ekBs4pcfTA/q3H+EWYEMyWt+wPjbd59JhK9dNo5/zwiUU0LGU5MkZnopeUXDrm0S
	 grfzaG09p0+/MugL6QDLT21w2KxJGkJGB//iYtbX+hwREpLPQyefPFa9sIfT65ObFj
	 /2QvRtFMcYGEhXy2JmDlm5mjmcHXrIimTkAGi3LIygcL51BdG47HFGvVbLUfMDVkCW
	 eamI9OymwvDzdBs7nzSIgjNYM6m0gs1GGN9GvVTkbitNrYrKrU+TLY1XW6eZ2mhaMF
	 c2aovlZkQ8YoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A743960860;
	Thu, 10 Sep 2026 07:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70AB1E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60DB060858
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqTOZMLbzyf9 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 07:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 851A060860
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789027058;
 b=F/rmK266rq2vi8ML34RVu1GV2tioIlgbP+QUWA6iUF2R8S/efD6vMIxK9m6vki+zQsbL
 ZBgZsS/jilOlMHanoksf3kr8Iz/Jwertj7L38tc/NrcZ15mzRr0i70hyT7fHmR95LXFA3
 Ur2mKoKAuBIiM2A9PAoI88HcoiWyGlwThTjQTDqT6T6s9xPInixYMceljEP0tv2XVAh0b
 qg5x4AzmaiYSD6aUb+GU1DWDZGO5qtM8yO2R8SdhR135QnYUyOFFSJB/x0hJytouQycP1
 cunqgMNNqRIwGHB5z9xCis6AOdC+KT9c/mPsmTWQ+A5OmYV9Q+HdvXzAFKvL/CtnZTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789027058;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=l/zRsc1sLaXs+Scei5gMe2f+hP+nXkbwUKy3gmHfiik=;
 b=ch57h0lmqvyy+IanE/eRmir+1yXOMiqtYScofRP8nVB46iVIimLqO85V/U+haSsl+ogp
 m9aIy9ee7YPEdo90I419hjQvIO+o5+P2In7DPR7rpHTAgKN/5GVf2lnzJ9Mft38yMV0/R
 7BwfhP+nplw8eUn5Rr6eQMc9tDUHn3hdKbiAbvcaHIbPCjVPsdQrFCRtpfJYkJugdvik+
 ezD6d+hZjf1+oXPZl7iV06Rpq3LjM8uR4M0cDN61VfY2FK6WuGRmK+TcZxd4Kr3Pyt50A
 13f03N0XhzflyMLEo63XNuLOXJlZ46TQCR3ExexmFACjKmwIxgbsJWOErCK4iK7+sdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dIGN0yTd; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dIGN0yTd
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 851A060860
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:57:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64BB4601F1;
 Thu, 10 Sep 2026 07:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E1F1F000FF;
 Thu, 10 Sep 2026 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789027055;
 bh=l/zRsc1sLaXs+Scei5gMe2f+hP+nXkbwUKy3gmHfiik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dIGN0yTdPfi1WdjmHors8WuhaCR35b5DBc3Nh4XeeU6YB3GYL9BZqZ8Ak/zXv9ZK2
 g+2SsQKJ9HDu+Xx437V+yx/CdD+FevzpFNcP0zsxNP2WtRCzS/ugfBNvxj65dNPqCc
 Lyzr7foY+BQBh9wK7qJgPpa/u8U4As1iqTpfFyMlc5nIGVueeqCVrBXcL59SyzB+v9
 JSIdP1xlfOPpVYqT6uR5VCKXv71YcBtuRwdNffQTufG0WNoODUydQUenb0uB9cQPpP
 yt2klIegNGnRVkkShlrENu5mpaHfGJxUGoRhoWWdPT0YKuqOXRLVJrMUCOs4Rj4rG1
 2gq18FUnc3SrQ==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, E Shattow <e@freeshell.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] MAINTAINERS: add new SpacemiT custodians
Date: Thu, 10 Sep 2026 07:57:27 +0000
Message-ID: <178902575240.1831947.15650786856060001168.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
References: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
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


On Tue, 08 Sep 2026 08:46:13 +0000, Yixun Lan wrote:
> Introduce SpacemiT custodians and document custodian's git
> repository and management information in the MAINTAINERS file.
> 
> I will do some u-boot development for SpacemiT K3 SoC, and also
> help to review and test patches of K1 SoC. The idea of having
> a separate tree from RISC-V realm is to better handle SpacemiT's
> patches which not all RISC-V related, and have better dedicated
> CI testing, also off-load some burden from RISC-V maintainers.
> 
> [...]

Applied to SpacemiT tree, thanks!

  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git

[1/1] MAINTAINERS: add new SpacemiT custodians
      commit: 0320381ce909c1110e4b694f4da921a61a942957

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

