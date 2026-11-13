Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8E606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P7ugjPYK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmkhXINu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEBCE81174;
	Fri, 13 Nov 2026 23:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWiTG52NAflK; Fri, 13 Nov 2026 23:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1825681181
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794613882;
	b=px0Y1/2AL0wvpNPXH2ZpfhMnDYCMXEpJD8cT0GdovSQBCpHmAOhR00PEvzctQayx7Wua
	 ZSgGdJm3wR4VymsDK4CX7k0IOxu+vurrdk/j2R3nX69Mzy/DiqqrqMvuKNIrsrHz4TLHM
	 B1kJxe/0s+wrOvNsPm7VtvIynA2/AMrARRaRUfNmC8VMxnvE+Emp2y17xzofJ2GYRpfhZ
	 9IRlBTZyAmA2gAyUyL9bU1PDSoo+nDEPfKy8KAYjMwhKq1zop65w7mBsr6RZlaS2WFs02
	 51K0P+Nl7fQekprD6+qV6nMOKx6N2MnOZ3hvA4p4Y1AO5ZwVMAE+7HMgr7yojVWzrtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794613882;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PIuELKjvSE+9WyREWLkWEy7O39awLxsAhMboEWBviYs=;
	b=Iq7aPlkg8uO2SgJfYf408y6ouhEJWRABBXfFj82cIlNtCHKZBBStey9w74LyPsKhRMIB
	 KnjNWUdrYdhtL15VeIPvlVCEylKoduS2OhBZPE4naHRwgTUQ6eGnPsSarD3b7da8HQ7zF
	 dEk0aS8fVnOWjRYkjdToiSnRpUiE8mSEdScRCmly2I3EeQqBeZDKKQ8H48Gfrpi8g476D
	 Ao2+Ety2dxw5zWaAjduT8ZYbTkh6uCV/XWkut5LRwtOoQbyu0QiD2wIRBnqIKGbLUy+md
	 sgDC2MY6ve0ylRdDUZJ2A7DRD/WOksokE83SzHheeaW6dd1SXZbi4k+qtiHJkTYynPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794613882;
	bh=PIuELKjvSE+9WyREWLkWEy7O39awLxsAhMboEWBviYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7ugjPYKhSXxBuftnXDBcHA1+IzXpJQn3JVVMZ8kHFYCeVAGkXBa0g6eoOQazH/gS
	 sYitn2rPwk0PkM7zpB1A1sf44cINKRAf8ADvaMbGzcBXO2xqhgLlO9SM8Y7+sd3qKT
	 JPtJZNDFSou4mE5FQuJ1hWdQ86Lc3+LjmUqSb6jzUHs06CuGBf3hOb6grx02eRmX+H
	 ifLWIZ6ZF4zq/X/+uMr9Su4mY1BffVgkso01J+mJ66v18o7hIGJ4TVkyfxp24JADjb
	 utsFQ4+E9DBlj0hNI6KJ/3KgKWOf+Q6elYiAY+eZQUCcLqJCMwXKiv1DrED8OQRgj/
	 DTZGlc88qKWuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1825681181;
	Fri, 13 Nov 2026 23:51:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC2B428C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE22840269
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMMRUQbShxPn for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 23:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCFE34025F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HmkhXINu
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCFE34025F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 23:51:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 812686185A;
 Fri, 13 Nov 2026 23:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB071F000C4;
 Fri, 13 Nov 2026 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794613877;
 bh=PIuELKjvSE+9WyREWLkWEy7O39awLxsAhMboEWBviYs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HmkhXINun8qDQ4KY6ubluquKWJ8ilwCcDxPz2aT+rUpzUpK85ZlW9DqHLEdjqIIWJ
 JghHgGZcJiqItK+HURNlViEGq/+uZDeWwcfAr3ARsOKyQoDIpZNfeUDfzypATd6li7
 pMyoEjX6x3+jgsTVGG/VH0o+jtIp7xoz997vlJNo5CEU4Asuag8QcMRh7ebmnYEk0d
 33iRnwWDjQanyLkD+gK1CbFNhiTuouxcvfOXktlKEHslZQS07YO3TXQoas458o2f6a
 NfSxQUuRH9AH1SthQmR1hLsPGfCdSHRchxt9L31ZszvEyqWdlWErRbgW4M9fYODMDd
 s46avmr6u7ibw==
From: Yixun Lan <dlan@kernel.org>
To: Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Bruno Banelli <bbanelli@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Date: Fri, 13 Nov 2026 23:51:09 +0000
Message-ID: <179461382175.285186.12612468519287490952.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260825065257.69536-1-bbanelli@gmail.com>
References: <20260825065257.69536-1-bbanelli@gmail.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 25 Aug 2026 08:52:57 +0200, Bruno Banelli wrote:
> board_fit_config_name_match() derives the device tree name from the TLV
> product name held in the board EEPROM, and only recognises boards whose
> product name starts with "k1-x_".
> 
> Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> instead.  On those, fdt_name is left empty and the function silently
> falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> tree with no error or warning.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/1] board: spacemit: k1: accept the "m1-x_" TLV product name prefix
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/74bf93c3f2b2cf67dbddc484daf52dc92941d67b

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
