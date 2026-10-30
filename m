Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B81606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JF/UM/pJ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=c7H/Pe68
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5717340A98;
	Fri, 30 Oct 2026 00:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBilXkh1vwEg; Fri, 30 Oct 2026 00:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 972C640A9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793320857;
	b=qJ2+3ELliFvLH+O6fh9siglXXcn+1uP9zvL9tK+DIaY1drc824tsgcp/W2NZLMQRL9ex
	 //UlqyyMDHEbVu0BDS0zblxt85s4dTG0lIbJ9CWjQPvrEtdvApfP+GKpAq/3n0RXQvt/u
	 7XltoiFT2Z19kCPCsI4O3YN16N2GSkcIqaoAIO3E+rp+UzDXkj/wC180dcPCulv/lKq+u
	 3Q+t2S3/6zZnCbWOlEb4+gm6D0C+DEy2yeMHwWt5BQrf7sqlERrLf3rXXFwUQOEo+z/xf
	 xk0GPTTwBEyAEnvKQlW2CuZy1OxhyDAiUoRK6Q49ylSYACxIxb1hH+A9WzCwtS+y66Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793320857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mzc9HNOr/8TupbmXBO79xO2/79YNmrOHPhR1QI21ijU=;
	b=m5wYciR+DpZrJDm6lzdTgmjtliXJ6zoUeMTkiU9c6c+CrAHhmwoHC78/qnzuQo2aTgO4
	 im0UJAExJI5dmC0ueiSjBy6P5eyWw5IycqVuP8+XyAg5Tp8Tthm861FkeA5IlYeHEks4x
	 CR72THHjpJ7IWa+dQ6nXYoD/5W0T5TfJBLAvcsZ9ip8BEhgYi5DCI/kMvldQ/CMExKh+S
	 WThoIaZapMN0yt/r4AbmLMUsCGMH6YYdibfG/NmphZDb8cPtNV5pARySW7eXfuF4TqA4D
	 qbUKBCqptl6l1wM3+cqrCpLIOm50YBIFHmYZeMOkOg/h+LRS65BCwRslZ/1//wSuirQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="c7H/Pe68";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793320857;
	bh=Mzc9HNOr/8TupbmXBO79xO2/79YNmrOHPhR1QI21ijU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JF/UM/pJLly7cN4PbqxyRp3JqUtjnDEVTbn8nxvlEyj769Dk6Uk5eKH042uwKvVq1
	 zycLOhbKwq7lu5qiFXrccE2a34BQKuo5pfQm6xzwby3TLhE+yCquLawAWsplNtHpXC
	 zxdm8Hr2i2QdICniigHKdg9nCjlqRxHLTJQoomay/CmFP8m28wgY1NuBqKEWjEYIra
	 Yqos7XRF2GYFhiBYlY35oy4qTuDM0NafYCDVxVUJKUI8AKV2BzTTztc3WSjRXGaT44
	 x2JJo3hxYFW4bE/+QdXeehzBYopjOVfoBAyLDAk2zzvmlVlzuZ51LXtGC3Pv1RrfG/
	 BX/LfCtG/yE9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 972C640A9C;
	Fri, 30 Oct 2026 00:40:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B2D3712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C9BF40A9C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9i3ATlfzUHi for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 00:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B5EC40A98
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793320855;
 b=pKgAiUjkbUuVM4hYpreB/mPnFSskSKznj+JwGKCmXcU0Fd6ooPrnQW4rJmvKEtxN56J+
 qvpeYS2hUnd27hs7+7ehdl+dunsNKwi0FnFRmH53WTu2crUWrA8OBpKgi3SAK7xMRbIbY
 Vd/YE6NGs4qJhvwtqSoMGTu5KAW/noDZB6KLPtM8Bw0xOXfNxGWX0IGMa4NYGnmwhI3yv
 TvvNFm6TIFbkktoNLwlFF5LRiB9JAn6AfjOu4i4k7mMj04EFYiCs4lRN54QyLeOTHVz+Y
 Vhvo9mOGJ+Xp7vN6/3ak3UtF87QkySAyePUXlh1URVKZ378CyDtXCdngmRJtaDao1aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793320855;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Mzc9HNOr/8TupbmXBO79xO2/79YNmrOHPhR1QI21ijU=;
 b=iopSN1DtPqEcOX+83GqQ+bujAkv2N+y90yneQZwjYG+R/FD2pkenP87APRKxBVtyyLYJ
 X++XUgQucevpeihMbsYkmlZi22E+xzuwk2Kz9GzJ0rLexMv9Qv/WptOv/+KCmQPmt0bOv
 EfMJsULCuXyJFyQ559qiAl1eNHzSOvs1N+ZSmsfIDht70yABtlvESNBRh9tLR/qn8X/dd
 Nc+m9ONsIDPCdG8IIC85PFtRH2dyaX1le1kzQCzRRfLBxwk2/oKSGde3Wf8oz91FBsG4X
 7eLRAkvDii0v3IltzOB1tyAHsShp8jZ3nMVRP6IgyAgKEWirmcmFelRpAw3toYFXFDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="c7H/Pe68"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c7H/Pe68
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B5EC40A98
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:40:53 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6de1fd5f572so61502eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793320853; x=1793925653;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mzc9HNOr/8TupbmXBO79xO2/79YNmrOHPhR1QI21ijU=;
 b=c7H/Pe68sk1/B4ViiEB2SuYmLHi6Af4QzXg1TTiboCp4Y4JqzYnnyoefTqCZ8FzGvJ
 sbv/gfGBwBtJfe4sFWHHyMJhJ94L+KoFVN94NpLGIjNlJwAc+oYbHcJ8h/qSYQ29vE12
 uqansQZ7S/y1VDtbLEI92ad2ZwDIw5OS0QyA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320853; x=1793925653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mzc9HNOr/8TupbmXBO79xO2/79YNmrOHPhR1QI21ijU=;
 b=qNH1pLRbQr0XLFAHUxKdm3j167gUZzWuTYBsORlUpEKhFlufVkcK4vxK+DKrEuvVBu
 DMqYXL/g32lUCgVEX/7S71AKi7rk9e8ljwfNuxryDmJg8VBOPNrOo9Xh3c6Q3Q08Wlh4
 hIqqPcs6iu7385+3ufHxKd1kB1J0MLyuSdwYivwLEzBZqA1yrvvZKBKqq8xI7imxPPi8
 Oh8NbqARGlsqnpTJP/RU2UgACLlnl34ic1/eOu5KK8FQFVtAj+u9ugotRISPEHiMxXVR
 jbdF4ceaxuttUF7oFbzhOrcvmjiLSDqb3EZfnLUE0hn3XIJdMgbx6+sl1MbpVYHHTcPy
 y79g==
X-Gm-Message-State: AFq9FYJnJ0HQQdciEe8Qymnibnpe4H8k8Xy0meYIIrTa+4KLYYRfDUMb
 xS+qkGv/2LNdqXutPKm7JuL7M4MdR8LNYmMvV8AaD//saNOkcRMBu4ZzA/eVnha0FfNkSKGXXxa
 WAlkcsty4vvDN
X-Gm-Gg: AYBFou1Q9ZmGBHw27vxbnsLQcQLIMCO9TK7NJj4W2lqjGcYF+b/qIFLYEOgK5fmCPsR
 jZoqNlkOlI4ZcvQAVn6Sp5My9piszJf8JurIAVjzVd61Md7EDvCovTVZml85qdq6/yYTfHfqzue
 Rmzsf6WRGE9EFvAJ+KLuKzpL+m5Q9IMqki44BffzgJMZ7p6qp2bW71xLxca28AYtYR8z1ZZ1xPQ
 6bYdwf0DGx5Z6wNdnYK8lLLgEmPtFrYZOkz2PZ0o/X7zUUCq6bc7Ce7IgGYuPPucmBu+5iG1SLc
 nCoC7X1y3HwIKlLPk+0UJOQu08Vl4ty7oEjzu/tiUo2tTh2khezmNUn8dl0b3qseVQETlfS3rCJ
 OgzdZI7f0l1ltwOC94BGlwxH1YWeXoAS8IkbgPlMdj00GkviVxyNgZpgBxuTMqv/ssNfm976wA3
 Lj2Z+WeebStUAxsUYTv4e6uoCAKyQjYTenHIeluBrBwv/bfITkaLvc/8bo0eysg3NfTTo8wpMPT
 Y9eyyAEbrkZRGknkHmfEDInCWEA4wRf9eTZoZoLSnwLbfWM0FfQunDWOdqh31uoRJABsnzdZyNt
 yQFn3ZdhwCtcwU70ynFddyj453QmlDyNFWCl0WJ+M6NDLJNkeFTlIZqRl2verFFM1Cf+Y6y53Ex
 +CZWYhAeSrd5HEsdn87vPxFR/tDyMWJ8GgCO23qbQ+hBIQQ1+QX9KxegDtMVcP+VYrIEK1Jz9at
 K+upeMHVwagZNA5AO5rupra67lLVrVInvIVdK4xALncREIS2cSQ6Sb5/Y=
X-Received: by 2002:a05:6820:3385:20b0:702:3087:ca55 with SMTP id
 006d021491bc7-714f2959e9amr463807eaf.36.1793320852938; 
 Thu, 29 Oct 2026 17:40:52 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90af0df2bsm369511fac.11.2026.10.29.17.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 17:40:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Heidelberg <david@ixit.cz>, Francois Berder <fberder@outlook.fr>,
 Han Gao <gaohan@iscas.ac.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Petr Hodina <petr.hodina@protonmail.com>
Subject: Re: [PULL] Please pull qcom-main
Date: Thu, 29 Oct 2026 18:40:49 -0600
Message-ID: <179332066908.3108908.14830163894851596224.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029223529.3031661-1-casey.connolly@linaro.org>
References: <20261029223529.3031661-1-casey.connolly@linaro.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 23:33:44 +0100, Casey Connolly wrote:

> Resend without broken MMC patches
> 
> Sorry this missed -rc1.
> 
> The larger changes will follow (likely for -next unless there's some
> folks are particularly keen to get in?).
> 
> * Add scsi_scan_new(), handle scsi scan in mach-snapdragon without relying on preboot
> * Small docs cleanup
> * SDM845 rpmh regulator and USB3 PHY support
> * Support for switching to EL2 (replacing gunyah) via SMC call
> * GENI UART minor RX fixes
> * GENI minicore support (GENI QUPs which don't require firmware)
> * Added proper support for various GDSC reset flags
> * SDM845 pinctrl/clk fixes
> * QMP USB phy orientation support
> * Fix SMEM memory map not including some carveouts
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom

