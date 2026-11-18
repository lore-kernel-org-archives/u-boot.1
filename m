Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UrIQhg2v;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gucEtQ93
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 058D2400C9;
	Wed, 18 Nov 2026 21:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZuU17qSeCOF; Wed, 18 Nov 2026 21:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 634F5405C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038258;
	b=ZHDxD60LetVbRaA4xulnyPQbi/Mtn1E5Mmbx2FghS41HUkZnLRLXEm4nzJe+IWyB9HF9
	 lcFRo7rSwmU2mvauytVIQPM7Fp/ZyU447/eCtarcta8mP89FEpf9bMSJbzOLl2XNCR3RZ
	 YDHt72loKEm2flvLMQOKINgG/XryS9RN3IWp9rWqSW5T4QEso95C+kKTbQAmQXJXjNNpu
	 FUEr8LnWksqUOuq/bZSM664I81XoSi3MnYPFc9Cl9RBU6XHOB6L43enL3OuUW3fyEEh8s
	 oIeZ+vycSUcs6PKKCKRngrGDe1/jgU4Q5mXJReN1DLOcmOZqVd8dU9ijUUnMkcNGmww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=he8ua/Jsb7/LWWt8CsljDCCnb5pUs36L04tzjGq1R/E=;
	b=CmwPwKsjtpqtkscky9mlI4cQQHyVSstT2IUGsrLA0B2hN3GUcDWwFG/c2uV/l1hzkyll
	 Jy4bv20FFBxUm4ww1pDr1j40+6Uq7UuFceGNMuIr7uzKX3BD2es1H2vra1ylzNTGobkC4
	 Kd6n2jMUsdCKPtupKpPMvrfsZlKeShR49S9A0r8ViODv//RSriuNa4tAL3JooZKhtwyiZ
	 X59XZ+dpzVQ0EuuakXXLRidobYDbOlELYhBfUD0Zf2CJ+AF3DqDi9lFlkSgPUr+l3b0LE
	 LmdCWWUm6pCugJpEyKPN7aQzL2/E/DI5yvy6P/zIdyx7MdJIwPx/3s4anFAJmtYtWrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038258;
	bh=he8ua/Jsb7/LWWt8CsljDCCnb5pUs36L04tzjGq1R/E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrIQhg2vQNtKkVe9vxtcEWL5IpdxWbMwu4WhFx+sZXLiWeXnrpoXkhwYy/4G+eVsR
	 BJwSZbnX5DvHHcbf0kUsDXm4KI+BjRBRju4XuGU7kZzXe/d7DH7QBKE5gVK3UyzwMP
	 BN37cgbp5xE0VHXYJ6Vn1/tqwEb1PFoyXk7F0F8KooXTmsKPxkWh1TTLFPExwaovCM
	 UlK+llTV1QaN0hMH4YYNMpG9APA9sUFC6FqU3RdjWYH/NAN9FUEowmH1Y4CV/yV5sc
	 4mWSie7E5uZpKUu5VhqA7jZRAQ2pw64fmM9XLbKLhO3aF/pJyUI7FdULc1jhx8RsVt
	 HOwVi4rfAik7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 634F5405C6;
	Wed, 18 Nov 2026 21:44:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B037061
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96CD580E2E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBaV_tJsnYfb for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9D0280DE7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gucEtQ93
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9D0280DE7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:12 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso12163955e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795038251; x=1795643051;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=he8ua/Jsb7/LWWt8CsljDCCnb5pUs36L04tzjGq1R/E=;
 b=gucEtQ93VXQRX0w/SOyas+CuUJY1V/+WV4g1DsouN3CThAFWn4k8K+hOx4FYqJ0Cf0
 rwtnSWtpQsTDflKQWPfLv7ZdQiBTTgad2rTyRaL8+bbPy9YHEtahguNr4w4OMUXXLu0Q
 nGaGvTSgp4/btJioYzqWaN11ARa9SNul/TV0diMnGOAXSZV0rOWQKHuaTyH1gUP1xEzY
 9DH69CdYFMA05AsjUVvETnV++/Rnjmf7IZmsa7t84A4Lxs4Lwl75T0SCcd4CD1vEQui2
 qCsM4e/Ps4aZXaaqILOxM/8L2YWKUETOenc+m+8srpShhBxZFinLmVj84W1i7AncJgXh
 cdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038251; x=1795643051;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=he8ua/Jsb7/LWWt8CsljDCCnb5pUs36L04tzjGq1R/E=;
 b=XYbxR8rP/aPObozIl/8uG7rovpJ2hOk1k2t3v7kfuQ6MIPsiRjJmXO16WeeAf/Lh9O
 56IAsN7hZ8DxKdBYSKtVr3OmVyrMtmf/k1nIzSMHn4Jb4LQgyngGbKXaPo7xPn8mIORe
 6FTmBeWIthsZQsaVK95sX8cUq4KlfbtXLUnjBHl5GrJrbNkOXGCrosIxP7McM3T+aOjQ
 wV1sXl6aTLXIxTk9o6Tleh+w+AR60xHGGtAcBf2WcJBR5Rv16PfulTjWSR60tTPDkBoj
 HGCPwa1l1tk6oOtPtfgiCj4TbRvPcbmI3G+Y11hES9UZnbXPEvgOlXGP2qKq0f3RHDiD
 ln5w==
X-Forwarded-Encrypted: i=1;
 AL+hErEz0SIOgDeAv7/Hob8Q9X/ZxDGhGtlpXA+3Xk/ZVz5ohqfYX5HjSQrVRKrE5+g2GOM6qNfoKuo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+JHAxUgL6/5AXyujPrPITCT/FKDZQngPIOjN3XJDlYBkkArtYd
 3FXxeVuxQxJjwurEpennA53Lw6TDxDEcQaR91rghJP5ANX8rrWyfPF7g6Nu0VBIcoRU=
X-Gm-Gg: AYBFou1AARNoOi0DyyuW3JLYzhrxH2ZwaNzxxtDe4C7Ub2VNs/lT4arNPa6Ony01PC8
 h4CTUaE4LFMRALgeKXUVhr+5eDKmym8PrbUwf7/TAfK0jSY0jkM7CDsUIZUI8lRIG0jzEBtCRry
 lcOm/FyMCBzVwejf3equp2vqSI1Hf0yV32QH+sw3U69E5MqUhxcHDHOHGGc5xxAZpYkJseMKGpQ
 fyQXhPEfUi3DM/KCdLC1/R+iZAGK5nmNJHZ/NHG/iiEk/BZIY4dswA4YsKjN+8FLG/JxxqipsLu
 vA1+mK5Nn9Pvz2lK4GmV0GDwPpjT2iBhtYIcaUvN8BxjhO7q3CvimNUanufF8Nj8BzGJ1h1weJ6
 ojehxUW6fSnQVIaq2DFb1OuLAN9V5+Fgni24IVC5HRsgD11lT/HDNk+MdW57htxO06JDxPw2Kqs
 cIQ3RHhxgtG61XNDlk1scg5xITDUWoq9JLefY8jdf9FB9r7FB9m4SwsfhgISxECGzuLwhA5Iv7g
 NUTvK5vC0SUTLDe01bY6jmA+h/fP56vVOdhg2+foC4QSfbjBsD3BEO64c2CWg9uV6yd3yqxQ8Xi
 zUsjiIyl+sf7djwGKCflr8KI1ouZEulQQy59sHQbdnuT1naN1bY=
X-Received: by 2002:a05:600c:1f90:b0:4bb:7987:fbc4 with SMTP id
 5b1f17b1804b1-4bb7da263c5mr79337695e9.19.1795038250630; 
 Wed, 18 Nov 2026 13:44:10 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8450fce4sm700095e9.8.2026.11.18.13.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:44:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/5] test: avb: test the hex persistent value commands
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-2-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-2-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:44:05 +0100
Message-Id: <179503824597.2286122.5737928664097931823.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038249; l=516;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=2NNiTzceM5byjahSUwDvg2HbB46MzH+h3la5y9MZNkQ=;
 b=W6kGPGHfTJYs1+39WuQ9/eJHaYhlgkE3nqmF+oGAl9pVhHUXOsJQXKGuWoKQzAbKuFfGMxFD9
 r2ujyeOE8S4BnSM/QYjISuTDFQFIBXe+oKt3fJWt4quBoFowfW4bIWU
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:50 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Persistent values such as the digest of a user-provisioned root key are
> binary and may contain zero bytes, so they are written with
> write_pvalue_hex. Test the round trip, that string values read back with
> their terminating zero, and that malformed input leaves the stored value
> alone.
> 
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
