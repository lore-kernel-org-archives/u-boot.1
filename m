Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C0606A32F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kcrqoS40;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kZ59Npvq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0243608DC;
	Wed, 21 Oct 2026 17:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CRe-YNDYuPJw; Wed, 21 Oct 2026 17:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78304608DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792602665;
	b=AMNRLenufeFP92sf1WSmWElRLLLEKy1Xj4Pk1CCPo4HypBZpSZFCvy4D5QLTzkIU9m4L
	 PVPr/lVnWTDFzWz63mppSnozcfvQQhjoT8LxEYp1O0ZH8SGip+TA0tZEoL/CiEiqTqGm6
	 RrrAx3M8ZpiM07l2/U0HTKSbwUui2GgBfAvgoeBOWNL+L91Dn2soTo/Bcv6TW/09dYo8C
	 0Qj3aYPniP5tTevLhqFJz328NDYJy6o4+5puCrBajIdCJE6Lbne4J6wcNm1q3rL+v1B7u
	 IgXx3tyEnipsA+mZyS2/5ZdBPHpim+gaTI9iyQLlii+iSMdUlxYOCCTmTpA+mR4zhVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792602665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HUSPF3u8jdOhkUEXoPPsXQ7kzz9jY/SK95Y83Q9/TMs=;
	b=iyLwQisAlXYV/zpt8gmI+7MS1yQ4pZsmNVBUgbuZ5/lW1LmmZG+SHJE54qSDYy7VoBuH
	 quca383rMeXKPy9fF7lvu0wYOrtIUTk/3iwvsgxeFQqKKAH/S5FXy7voIlqRXYh0HRl58
	 RD9XrUoxrvnC67No6PJw9ynSzQjgqlvNDoe1NKyuc9yVAsYcuq4aRKldLCQHF7+uTQ25M
	 SvNQHXyHi7sF56gg0nqRmNKAqS6R3ltBsT/nBgJjlDIwNoPFZ01uB2x6vsIZbt9zoTONX
	 TljAuCUx4MY6/sZBJmbbPh0a4ixYmwq/NuL5JaLQgieobCU5ugu08Qdtf07xrx/U6Ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792602665;
	bh=HUSPF3u8jdOhkUEXoPPsXQ7kzz9jY/SK95Y83Q9/TMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kcrqoS40egAJKQeBFLsoZSKvKGLA52iQ93zg5mEpm/F4wUZfXL2vQ92XcSY8dOpJn
	 nmA1YsZowGbif6fiyIi6xQ01aq8hfE4K5K/fLef6zztyYJu+Ffqv5sXJLxtfh/8GdL
	 V9qYknG7YGvXX+uvn8ahpdFicWcHWVPrP9va1SUR5Q2GsxBItr7pNezuu414oZZCBN
	 5km02W3DY+lryRbv7gFQBpbwU34dWZJOEKZRPN0OTs3mqenrVJZ1VkL+015r56m7lb
	 ZKyB+Alu+3Ud8qXMdErpR2ig8y1gxGYVbb7CYjTphH5+0XpBe+7KZKj85/tbzg3xVf
	 H2SCbqsAWkRFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78304608DE;
	Wed, 21 Oct 2026 17:11:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF4E930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A830380DF7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fptUI9M6vILY for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7CDB80DD8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792602663;
 b=Row32VxyCczj+2JxJsVuFy0MGShHd55FdlSTBWTQt7+sSAbwRZsB6EXbbnE/+/b5Lw1e
 cMTdzKsYKST5aNhg8SBWWa2R0FuJX4DB5XmfDzRFOW+lEbIumULBiiO3NmkQcxUkyCbCk
 XjC3A78qMNfF6sN/SRTCBJLhLl3s610fe8aSlWFRJpTCIzKuGBRlt97d1BDa9466EP0Cg
 GbSEeK3w01tVlS29qKTgT4f3Wc9v7jRzcnIf6e20hCK+brHmQ24dntwVU9wyjKf70L4gJ
 NzXySe/SmrgQpVuegXnsGtniavQadXYlyckz6Y1EP8QRImPXCC29inHBEz3YhBDvtyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792602663;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=HUSPF3u8jdOhkUEXoPPsXQ7kzz9jY/SK95Y83Q9/TMs=;
 b=aTE6OkJ+rC0XtPMeAHXkxC1n2Tnamjiy7FIQtldgCOgntM0OZoW6eLO0eT8yH6G3f5+Y
 CEV2o68Rv9kBlcdllNXhYM1A35r/8UutWokIp/qbjnsU+5K9g2j203mYIJ7QH58qHYhkq
 DkKh39m45cl1kUIxpLERgHqEcEB+MSVtz+LYQvf4RUFxK1qi48nPPuCVNktDaqNfn7z3M
 IB1K1Qrg+ufzXXbSo0Dks6066BSu09S8N1oJt9S3EapYaKwf2EQ2KCyznkOYpJrszutSF
 4GTug4uDz4oiSvIpycRTgVxW+PpBukpPlnsvvNrqY3xEaHY61WkJWor5ACtLGGC0hCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kZ59Npvq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kZ59Npvq
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7CDB80DD8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:02 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-8253bc5a613so650722a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792602661; x=1793207461;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HUSPF3u8jdOhkUEXoPPsXQ7kzz9jY/SK95Y83Q9/TMs=;
 b=kZ59Npvqt5MkNQW71b7a+ip3COjOrp81XSyzwO0BYr3KxTFECWRk7v0CxSdBWL2/fJ
 VA0FcfjX+trKs7xuEWnPIrRqavHoY318G1WzQ9rlO+f1KfvxQcf3ceCUfILzlvwl7LGg
 /bCcLDQofzk7JZM1+NTIYKkgu2at2WOsdjHNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602661; x=1793207461;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HUSPF3u8jdOhkUEXoPPsXQ7kzz9jY/SK95Y83Q9/TMs=;
 b=sQL+8QCuA8vJfx43CyUsZXfNdsFguX0gNgvAKfC0CvpsBh+QRlASFRd85sPkRncwLw
 89IoCF+gh12yIslrYr5OPJ3RetpE+QVnBdjMoOGOqlivNZSlsk/hilPH6Sj7bWFmJiaI
 Jr5vU45NsfDcxpUx0fzFsqCswVMc3TMh3N/HHpLq2zqmylYU46f9eG9GZ5flN5ASOt+r
 qJb2/cgL8ruUNVz1cdpyarAWMDp+cEjvKaTibkFH6/u+63ReKtGSHgTKoXD+5KkFdWr2
 WzvD5QdsZz5cYh8eAQ2Mcn1iWJzxJnNltisL7RdrAfALzNJusb+Sbd2t46YAwEYU+ZCP
 MhXA==
X-Gm-Message-State: AFq9FYK1MJk/1pXxN1HTT54LNiUF8PiYGvxcyZOYCuCpYKKemL6DapLh
 4eLyVKhUfqkqwnfwo9UsLS1p06j5i7GhRVQ0hPBRz+vYR//TtnE6o/STcyjXFPu8zxA=
X-Gm-Gg: AYBFou29CQ3Ou8pNo8HMV9K4CXxtwz4zeHNdw0gJNk78Ar8ijtqwNAUgZzjIxsmlQMk
 zl/k2f61z34n3mmkZ1BhKWzPJP97LAzfrDAWWl1RqgOPj5wdgeQ90tLa6pgDmIzCeU/o1DJpG5x
 WkJW/uLKWQ4J/OQgbEx4mR/KV+Fbe6DAXv7lJ8vzSi4RNKnqJjun/4mVQ8r7Y+n51INz4cPO4z1
 3C9wMSc4UvVvmxEOK+tx/vzi/e9epvMN2eKTvJ9gnj3FU6f2THeP+HNZolLK8Ir6OPMdnGPvQ5q
 g6Gz1x3EkTWvRpRpBdafFc2Rm0HgT2rZmBb6oYerNsL4Yv19SiZq2MwhaADVnsIgWCieagCdc8y
 rJ/bLpJPCpAXtzjrsBkJVospwxyugyS4zcRNhY3s5VUgeyeP9usDy0QCXyVbnY6ApC1zWIbbm2e
 JMx2a1QwLauWryfCzbLmHytMv5Au86KuutRIAyWUIT5Jb7tpYwytTTliuYkIh/CUMxT9LfT/zRP
 ZtRUoZU5UaotyIlF5gNuhr5h47JLsDCeot7t1JW+0CVbdbm8jdZPBnXycsEZzlomYIUAnjGqEz9
 bSy/GxqESJNQ4+/5uG3ycUgm/i2wi/04kxykATHFvM7eBs1s7OCX3LMMUWUA5MiUMYHnGJcJzGE
 =
X-Received: by 2002:a05:6830:2589:b0:7f4:d1aa:2f32 with SMTP id
 46e09a7af769-84d07c03a57mr2122421a34.11.1792602661398; 
 Wed, 21 Oct 2026 10:11:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbc7d9b1asm2683971a34.8.2026.10.21.10.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:11:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
In-Reply-To: <20261013074313.84961-1-pepe.schlehofer@gmail.com>
References: <20261013074313.84961-1-pepe.schlehofer@gmail.com>
Subject: Re: [PATCH v2] Makefile: Skip undefined symbols in keep-syms-lto.c
Message-Id: <179260266049.3262409.18078343716239299929.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 11:11:00 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 09:43:13 +0200, Josef Schlehofer wrote:

> The generated keep-syms-lto.c gets an __ADDRESSABLE() entry for every
> linker list symbol that nm prints, including symbols that the input
> objects only reference and nothing defines. keep-syms-lto.c is compiled
> without LTO, so such an entry becomes a reference that the link cannot
> resolve unless .discard.addressable is dropped.
> 
> Pass --defined-only to nm in the U-Boot and the xPL rule, so that only
> symbols defined by the scanned objects reach the generator.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Makefile: Skip undefined symbols in keep-syms-lto.c
      commit: 5ab784245a445d683709b9bf10dc04f580c13afe
-- 
Tom


