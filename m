Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3E606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MI8xcfTe;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PF1mXqkh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9570740816;
	Tue, 20 Oct 2026 01:07:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0UUc_g7VV1Fj; Tue, 20 Oct 2026 01:06:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F10B40805
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792458419;
	b=tTjTo9t4PuYXIWEqg0BgRbad8DsySY5+/zUnZXDN2Ze0UoD6xEOv9coMKATJoUgio8DY
	 qlEzP298XMB7/vffIx8no4xTdtdzs0WTBLgbOoEhA8Riehm0Y0xwLlmjqV2OadNVFbDVP
	 tvVbKLRib9xxCCQYBr8ZVsjY2MorDI2Src8EPqPfwYEkRak1nZrwijx81v02tAWUltwq5
	 nYbCUp4cZE2gGw0o2FeoSCVtcyOcac05afZEX04+dXekkRNAFpQhJ4rjuhaeEyiEZ+Vgh
	 RnPEPFAvd573fdZ5V9TTiY44PH7Tn3jChj2mMKmKGKDtxTi7txyV4tP1NmeWRuxUCTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792458419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hVG39FiABjsJZxBVjVenwm0ARJMQS0x/Xd6WvJ4exhU=;
	b=Wq6zEep0VsMMZKkpdbG2KbQWRh2zrJ7nqN18rMCVoMPSdBIPtTN0dCKaGVZoEbBcawu0
	 k58aLeYlzQhbLbIkdJlRXlrCGVqvLZ0XuE8/rFin4GG8SJy1w/6+L2RQs4N68B6mdZ0qj
	 +aULAVgQ3lxQ8yG5Ij9+GDvNxBJmTDCHSqzSrpKMaNakj2PzWv8w0qBYSnIZEYFCeZZFA
	 tTmSOu1QCRHndf64BhOLTwxGWXALtkpQO44tTnGrrkaxo5zgz8cpRjna31OSqS18GNsul
	 CeEvlikWQccbPm+hXP8D6pvAizRUp0lFeWzpV8i9I06PeBQg0gzolOyu//krAEt5AsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PF1mXqkh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792458419;
	bh=hVG39FiABjsJZxBVjVenwm0ARJMQS0x/Xd6WvJ4exhU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MI8xcfTeRVpoLJgvW2AWsukHSS0rrPVFNW7LTbqxQw2mICf59V+5NpKuL3ZFQQ2eW
	 DXIUmXf9rgJCiqEP42h1/0uVBY497l7L+GE87hbW6Lnjw/QdJwMStbFHZSojGHHQ5x
	 iLwarR1EMK7REhowVEJAl/3bB6jp6IcB6992jm9A6anfefplTTPZsDaZhSrK25c4V6
	 Ty2hhpoGK+eAYyLktXWBOsuka5a8qNcZ2g51LLQJCYZCFc0jxi34sRp+lCZB+O38t2
	 GSnyDsa0Y/iZfSEborw1XZ9pCd0PaItKD7FKgLTH2ahYGPMfv81rmn5ctEBIeBkZW6
	 bbJZc1ZpSs55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F10B40805;
	Tue, 20 Oct 2026 01:06:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E365D23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4926407F9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tckR_ZNX7YWY for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 01:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 163A8407F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792458414;
 b=XamO1eWPFilIuXBrWicf4xGQV1O4C0ujZEYjL82WlyJJkFNBhpN705SuJIsxeDHE45F7
 E8+TQRh22nJDgzorlmimOSN+Qm/sFVBiW4paMxB9ndtOevzgU29gXC+fnjYkxUNJDLMVV
 OVaXDd7l3MhpsVaDwnKN6Kbtulo2ff2ch0yUWkw8S0G6sb+L3Sffr+0MzrW9ddtA9ch4O
 MDC9FkEads4LF8U9b7Rr7wKY4Tc5YM4r43urk4Hal58uBPJFPqyvWrGCzy0nt1hyb8SNQ
 KMACZgZeOqM+ZGmZD7EdZDvtSsZwg77rjus+v7FJ9D5rhi70h9NUXYYWnzhc+ErTkXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792458414;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=hVG39FiABjsJZxBVjVenwm0ARJMQS0x/Xd6WvJ4exhU=;
 b=jVpJ8iEe03To2lPUpVHTMKT06ydsBcamnBxHdBi086mcmvc+ZqM7LdP84nTwbAHRw03+
 4nHiv9RuUZieP6rp5hVWJ5SyqP5n/3inivvQcWfGNfb7QlW0+4C+LAIIZDCmXnOvXj+aM
 Dq/md3Z+YIIDuqDRY2oXjXc57hoslTSV/fls6glYLv3DCGUrwycG+u5kpra4+6/33hcSL
 OaCUNPkrZ8pZHmlK/MRusl4Ug4QoP0aJqWRogU0Xrw7ewqKoPPcWKic7F6r4AWbZUZFtZ
 ujBWomqh8+OhZaM5Hy1ho0z3AelNS7outV/PmK48hvyt3toPs4STiUDSu/uDwj2e80w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PF1mXqkh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PF1mXqkh
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 163A8407F4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:53 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7fccba9c675so329693a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792458412; x=1793063212;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hVG39FiABjsJZxBVjVenwm0ARJMQS0x/Xd6WvJ4exhU=;
 b=PF1mXqkhxsA5bkjuWLNtYug9XPT9qQViPatbJabsBSHHZjbAc/dBYkvtzKLm4FqjJ2
 r9LKhAtj+Tj4m5rom42phpJ9dK83wzZJueeMKwFvxnm7jvOJ94IA2k3gUA5B7R/9/9tv
 x5ukmqdfB+AFh2wdkbMeC8E0lY4Vw/h6GRnKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792458412; x=1793063212;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hVG39FiABjsJZxBVjVenwm0ARJMQS0x/Xd6WvJ4exhU=;
 b=VfAxjnEWK4vmfIw/yBf8wmvCARX/JqZVoQt8h7x06jXqki3sY4rJOqfFnDrBHUJKO/
 ypNxn/T+/qzP2gnhZ/svJW6lgxXishRoHaGOgsc0zW9jAXQj1ZLUa4CU78B/+1v4XZJF
 uSVxGL59e+Gv7uqj0jFCpK8ToBXaWbM55MT4vLXeaeW5bHq9iSdbFuXrg2FMx69aUA5/
 LLJZBSo8i0mrWIn/wQWF68vjUrIGpPOu2Jt0vkp5Xc0pZLdf4uSYZJD5ITvjHC9lkUrS
 46R7wXi/H2WjtJWBbP7RfvANLAOsC4E1r2HcAlNiFlIQkXENQnIQr79X8Q93kB7S1Bkt
 rcUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrxmR9sHIUqdp0Qg6Ed/xuewJg3Nq06Cg9TqrbTdH2zD3p8BPf7aAaGkDFDuyS4WkuecL5hMA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJhX3VhEqExAfDVAqFzDIC3r16FBUgPHSe7f1WdPOZY9tEdTeIt
 +rx666T3Kj+hhWDgTsYMYEsqBQ9BuDR4axDH3IYtkmeTPDVd/vDQ0gCzWvWxS5fFTxs=
X-Gm-Gg: AYBFou0qEcm7DDjYRy43yt0SihKcpjbvCk7rmxFp6CK+Xp1pieQnVHLZy2JzDzdcEZO
 d9ZKnIEdMUQ67I4dGcdFFtRjgUJ52bFd4BREOUPhtoolazvOuThGvRT33skNUFq+g13yiEtv0yI
 cp7QQ1EK3O5UsDw78JfJlYd7bjOz33+QhhmoilxpYU8paI8mYhNnZKqEIhOV5Yc4pS7w6BVWMQz
 HD0DbLeZ4aNIf4H7GMate06mXqFMaiq/b523GgB6uHkXPyz1VPK2JMFa/OEWfqe5HKORIVNcaT1
 oPUtOC96GwaFIRipqgjfQnbl91d6Rn2OuJthjApfgwbhs6PcSoMRcWhnordMiVc1ZJVSnFlZaP0
 OrWU2i+1/oS4TK+X/PLzMAAwuQ2MNClXMcpe8FYo048z2xjcVO2VKhoiNXhokpSTsInf1PEmdA/
 Z3EepHyLzNTx3mSHSLapQUrzF6kgE935zOXDfqlHxLIZts2ybeEyysZpwCAH6DaMJZbHTC4Szkx
 GoQHU88L5Oq5NPZl4QWRgD0hIEFELZ9pSLDpETqk/h6njwpyNKYm2WHQk/MXv0/plsLU3iNFIxM
 GaVzXcO/LSvP3oCoqg==
X-Received: by 2002:a05:6830:2e04:b0:807:3423:e50a with SMTP id
 46e09a7af769-84b75bd2f41mr789739a34.15.1792458412565; 
 Mon, 19 Oct 2026 18:06:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm7868871a34.19.2026.10.19.18.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 18:06:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, u-boot@lists.u-boot-project.org, 
 Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20261015-am62x_increase_malloc_pool-v1-1-8b6e97ffbd12@ti.com>
References: <20261015-am62x_increase_malloc_pool-v1-1-8b6e97ffbd12@ti.com>
Subject: Re: [PATCH] configs: am62x_evm_r5: Increase malloc pool
Message-Id: <179245841095.885845.4203275534172253070.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 19:06:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 10:54:51 +0530, Anshul Dalal wrote:

> Since the commit 6b4b1c8dc464 ("arm: mach-k3: am62: add &main_uart6 to
> clock and pwr tree"), the malloc usage of R5 SPL for AM62x EVM has been
> increased by ~400 bytes before relocation which leads to a boot failure
> with an "alloc space exhausted" error.
> 
> This patch fixes the issue by increasing the malloc pool.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] configs: am62x_evm_r5: Increase malloc pool
      commit: 2b696f8ead5f258c9dab045d1b1abb46fea11c24
-- 
Tom


