Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94686606AB9F
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c62V4M2U;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PPB2rMb2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B6D281098;
	Mon,  2 Nov 2026 16:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6InIh9pTZJZm; Mon,  2 Nov 2026 16:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8273F810E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636531;
	b=OtbuzdaJvqJ2d7aVvSmFFJpMHvULyfGx/efbKr/8zvvXqXkF0vsnw3gy/Bh8R3WHIj8E
	 uQJwgb7rFIAY5i2+9wO/I1eljo+oBOMnflVgBjDNzXNbwqacphiN3HeWBnb7T/WRZHyJW
	 dPdfGPBaYTkRuF1Kysl0PIhYamdKh0kd5qm0PZzrlIEeu4tK3sv0Vqy4USl8xQstocQB0
	 35Fw8pcYLot9f20+v9GPyQfHVpCN6jOamW2qL0LYLqLccrY+HRuDiDtgEbMp3ywIU33ks
	 L3pDoJzLAbf7ueVtqPsZ0LjT56vv094vHs1P/GMXmVRa7TRjH+W4pf/uHwJNcfFDIbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3hNEpgtTNCgXRICCySAMZMuArVT271DgN1GRUUkwNkU=;
	b=D1qVwNFIaPaPrhM5rS361q8+l86JFiRNkQQR7RWUoXYkt4M4f20WTQHmTCf7hopS+WYu
	 IjZ7gaWX3tCMWMZvrLwN8bEFhUWvdcgAwUX0jTUQcuUJDN/S+hvz/4JCa5QYeFQ+LANZp
	 BQOjBcXWdV/o79KxahBrBaf/GtfoamOeQ8zYX45Q6C+8SW8z5YWm4xOYykUpzp8Z2ZGKJ
	 eGI9I2aimASpi5IQ5Bq0lluTYhgTeCxqT958f1MeTlRMuT13eTvnpZ8NDBSjEM1qJMksV
	 zcybX6Fs1gZI7ERXbeYHST0K+viljzPT2gmPt5ZrkEu9sT+K1xq4iXF4HqXC9UbslOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PPB2rMb2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636531;
	bh=3hNEpgtTNCgXRICCySAMZMuArVT271DgN1GRUUkwNkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c62V4M2UGiCZ8X7TNmQAF3IBXd3sbc/ElDwtnu0Ug+BuepPGogmiZivCRFrITSMue
	 sTzU2HJbnV0/XzzAyqYWbDJo69txV0h7n6Qy5+3fYSmrJYHIB+xXcMg8XZmzg/Kquv
	 yOTlpFSn4qiJbZGufh/sQeYX5SxI707dPeT8px54XlqoaXWUnmpB4LhRIH7mw3Y1Qv
	 4IC31B2J6iPeHF/BAac1haMJRWwIn91pJlivHnkouCshoDpxKyCN2i11hCI9soYS92
	 /3nqio3WgI1sCVyhYNI9TI9sp9i9fbkAZnh7kUYlxAbWWuOIirphxcqXO17eUGkyjT
	 Epd8AJ/W1LguQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8273F810E1;
	Mon,  2 Nov 2026 16:22:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A95932A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A3C9810E1
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id netcoaaGj-dF for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9EF3381098
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::243"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636528;
 b=pktQpEiZ30DwFa/30zifXdA43lKm8a3L+uzAk22H0+dx5gazdRTgMZg8kosnOo6KmIGP
 PmdnTPqEx/p2dSB+aagKU0x6xsEJiShoTHLdZeqDdEqjkKYBjWKInv/kWdSnW6/HwCxUK
 TZjgFPhX6n97pGNKugfEMOfqRj2A9i7SecHEq5mqks8/JjYnpPlLjjjBMpcJLau8d34Xd
 piO920Z85KJ8J950VMzRTCWZTX4FTHtgRUf3IEL099a46HKt+eRY9k0VgkuHl2kILpOr2
 ecpKla7jilwo8SmvQmGrBFzJP8x6Y3gJMLP6UWwOVisLeT2IRgdb4pJOX431JgX8qsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=3hNEpgtTNCgXRICCySAMZMuArVT271DgN1GRUUkwNkU=;
 b=GhNnyUlIup3iZPPjOxaW4TJmuPuv/pN57/l0uJ8moO+waDlDr19R9gvze/nBHx5iczhF
 jmpuD4BaVMdkzNr4n54kr/IfGsPuBa8wn0TZV1Git3YQMxVqC38AXcs1UzUYp6zhzXO88
 G3vYA/O1Lwojbh2g31ySq1E8EyJAeLQEY08I26O3Gaqvh4rfHa/BIfdjCPBdabhg8M+Pw
 +eIFJpfKhdmZ5Sm2d3gHKIY1IlvOTPZ6e5elU1nRh5B00rhHNgPNYnnhQXsg7b08f6fne
 RIZc3BwQ05HMfWnRAoOFXBKxHM+2Epu3oH1HMcuW9UtiKAXsJvY/hS38RnlHDCRLFfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PPB2rMb2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::243"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PPB2rMb2
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EF3381098
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:22:08 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-4b28d9537bcso2323839b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793636527; x=1794241327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hNEpgtTNCgXRICCySAMZMuArVT271DgN1GRUUkwNkU=;
 b=PPB2rMb2bR6VduFyrTCbbQNLn+YoEZmPKCMfaNGeZOOuzmisbFeDz7XRusrF373izB
 yKZNodCJXEnDsI/wzjJ164n3X2ZQKllCceG8KoJ2dWE/s0TfA02cAALq9QSVlochRIGJ
 pKe+WyYJH9IUGL84i7fFBUg4KQ2YdkAifRsmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636527; x=1794241327;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hNEpgtTNCgXRICCySAMZMuArVT271DgN1GRUUkwNkU=;
 b=PC7L5qPq6L97NSTSrNMCrVQVOkOyOLdzCthWJ6OVWgXec/QD+fKn3VJZFR6rbTIdeg
 EHZ8mhxtuBL8tkdEvmCFd3uj8zE6g0ssOYqHWw4nZp8iTKdOmCU2dDx4oCil5qVcwjvz
 3xtGGJgCazYDzkuZehM1E1h+K7ETrU9M8+6dB32QQcJIRWMNw52SmKbplclWS1VMz1TH
 Xwc2IYfZXJEPk+bryixg51F0C7Jp2aLrIVYNeialP6WaDnRdVENH3Nr0et1G56Ty/ih+
 n2Ox32l5ux8A5yCqaXHplqylKQPCgfDidMrTQI1o808yBhSHkU3paRvJ2EzBG0izWyj+
 PCsQ==
X-Gm-Message-State: AFq9FYJ67MRq906sGYXMpjKPKgxcYb7dhQEnFuH+Xo9Dx1HpQ6C1vtsM
 USQFkHl9kWb3XvQTft7gwm8zbw9aKBCCYFZkDvFiZ39jY1kY9UfmePKv8na7VLjDnxA=
X-Gm-Gg: AYBFou3fzdIqH5nIsEVzCx8cNyJpmdM0Eeht5fsBQnTEhUSwcQTC4jR4JkQ5mob6ZrK
 oHCAzZTPB04AqO+mztMA1IPzKIAaqmfy65kQG4/ltWW5ObNqO57opzU4wx2VNPLG0pbyoXst1Gc
 3B5Mcf+k/h4olXFymBLBd8srje3WQ+i6kdgOcyNc1xGbMWcR/nQQCcxfvlcJbnIYii8vsKLQzha
 2fokf9LI2vHCkagbMf2MINVQ2//CsVb5TtTRqRFu38Nj7mhBixkychbey1MVcM2RsI/RP1sjpLQ
 hsKSKRUW260O3DEYFSmOl8wxu6j7c705CCcZrHE/cs+++o952lL3PqUxw4TtTS/9zsQSM2eg5xN
 UrSkjjex+emJjkQzZ7Ij9vv18V2rDi0gzDE2Rl1Yqrkdoo6Os84dw5Xe+1t0polxffFzbfSmPMV
 l7dN/nrcOW/rAgq8p4AmE1/g4zrjHc+duQbWACZvjG06N7JekXQbFQlflLyHP+r3Z1MDp/mhhxE
 1Q8IUITDc6RSWAkz/eQI4jkLb0XvWqdI0YERrsydIe21BDdpoVgLxnCrKxUnK84geGu9l3R9WLy
 CSrKzMmknSRm1E+m9VQTldMc774wplkY+ah11bSz7EBGYNTb4GmSCy9gnLy8DLaA7x4Mv00h7Yn
 KQcH1MlrvRxwHy5zzTbGAvEzOiencOIp0s+LJWkFalBu5L63sF0PQ0cB5puHQV5bvdAnIXMXhfW
 E9QajVHxi8kw57ihjP8gjqsBDy6YDvFA==
X-Received: by 2002:a05:6808:2443:b0:4e8:4a03:dfa3 with SMTP id
 5614622812f47-563efbb609bmr6658296b6e.40.1793636527212; 
 Mon, 02 Nov 2026 08:22:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce8f5sm8653353b6e.7.2026.11.02.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:22:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com, 
 zhuxu_ran@zohomail.com, nwhitehorn@pa.msu.edu, nikita.shubin@maquefel.me, 
 pengpeng@iscas.ac.cn, me@ziyao.cc, jamie.gibbons@microchip.com, 
 gaohan@iscas.ac.cn, e@freeshell.de
In-Reply-To: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
References: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-Id: <179363652610.461671.15374949032614393673.b4-ty@konsulko.com>
Date: Mon, 02 Nov 2026 10:22:06 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 16:40:36 +0800, Leo Liang wrote:

> The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b:
> 
>   cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


