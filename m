Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D261606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hM13CIrW;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Qwwww6PK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73B5E81173;
	Tue,  3 Nov 2026 13:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1pEsaJhjeAz; Tue,  3 Nov 2026 13:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 724DD81165
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711109;
	b=FWyPsZ/3tQ7BQ2bznYQGQCKwVbLxFzbso02VnJZl8zPsH8wjwARLcuqn5fXRfoFsk/IR
	 QwMvG41IIYs4Q171+TXKKVZAVnD8X34qkprhcPFJ+RgsIbh/1kOKWEHNO0TAHQgAHua4b
	 u94AMhbWwwAc4m78EFlwthyXTREfa/B0EwkT/0wAniRyWKpxeDUNgeA/mWEeSwkjkcN3A
	 Oxu3V62KFdNyn3bGC+zGLt30omnbYzm13eR68o89RsGj59b//MjlCnreKqBl63xMk84BN
	 /IE5IYo+mbMlk6LrXgT5BFhxAkuLDs3PyKT9eAaIF9qUfs2aX0ZHL8jkRwUQkAVdJMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CNpJw88oTHFBPlltvGbX6hk70dTl3qN8N9SaUuMVGCE=;
	b=dGcAqdY6Y6bSodn56Jfpvfj08lMfAVUJqH5IgMw2KSR2OHpdf4cnxmCkni7ACCbdZO5o
	 2DS5xnPSkkCAL+Zyzg/kVQI3IloT65Mnmjq1p3ArOIS3NwPThTcK+2g1OKvrudIr6jcCs
	 58t/wFSGxDaz6iWL2lqR/qZT7amDTvfLjrtSUSG5HVvbcII/7gzAmxmmKUsER9x2fIm99
	 5XuNqLyUIUVXB+612Mdv3aMfBarP5UuAw9jyAfG16336CJtOAdj7muLt7W3WM6Zze2LzX
	 XBcPB0LUtn9PJR+BKwcI4YRyh7S3yEtsU1Om7dErSbdmKVBRQScXLULSZvyXkC8erHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711109;
	bh=CNpJw88oTHFBPlltvGbX6hk70dTl3qN8N9SaUuMVGCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hM13CIrW6qt40003bZT7yH3wqQGHXaXfxSIm1EwZdT02/5AJc2r3DGje7YWalAx38
	 zPKPkM5NPzWjJmvqnDg+5RljEQTUH4TH/LRcYcP5aj7i81NsmjGAhFrxBfNZtqay9D
	 1k3q7o6nF78Wmp+2Y0eVcOyIGhwh6rJX9yrzheNtXZKSemu9zRodiWaG96cQTW9uBt
	 AsWkQg469wp9t3tcif+wnF4LZ2QEWEGs9hYIyLHgOB8HSai3VazZVMOum07o/zUUob
	 PCg6P8KdbuLIcshwZGcJiiFh7UeVwOrMxHqCC44Sps/hYM91Aim/ZPsLXqMWFeaQxG
	 b9h1eJ6cW3ehQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 724DD81165;
	Tue,  3 Nov 2026 13:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFABA435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9589140080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UsmWNoOQi3mZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3D89E4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699917;
 b=OGLn5aScV2qSDARSDfgO+tqfZEQVT/0zguz3ZOIgVuSOZ/hEk9Cc9w3DO0/DP45FKal6
 xfzvDc5rKpogtkyFQwhGffoyRTMjZjkvA+iV//Apy4nTrc3pQw79M3qVeV24KXUpW5MpZ
 1jh4CCCgJ4qOq+nVjLrGNxXnQFOX0+B+lANXUavm9zhXG+AfsHHrrkFGk7ZWnsELrqJFk
 uXaTGYFQYQ+Q9fyrjXakjzTvH8m4j3iWcmEhdyCNCRpfX9eDyuk53j+SMk52KhIAuvyTM
 CCQhH/xlA91HdnoPJvQvsxqvBL/5TNISg8cnYNN5a4LXhyasmyEeZviJSVjBXzyIUvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=CNpJw88oTHFBPlltvGbX6hk70dTl3qN8N9SaUuMVGCE=;
 b=dE/fylImp+6HSJG8hlcbvgxVQ5KKliJcUWx2B7z/MYKJJlY72a7GtqF7Tb8T0A8U5ob7
 P8H1sL5/sxB+eE588e8xDb61Kzpk2WimLMyDdY+JkI2dV53j/cR1QRewjRubY+3OXw5u0
 bc8P//vBbGIJSQaFL5NsKi2CUhHFPLGZyAqiqt3L32DgWL4jfe9zTNheaKm8hlKElgOGy
 Uk4ZzmxhBWh2XE9IbSEgvh2oJGJHNgSJqd4GEHrg93t28oROhEuNYF4AlLcMIKMXjcPZB
 DgpnspOtuR4n7KVU9I+0v5xmyc9Z86iv3IdHIU6iK2yqVz0u8QmPqdLXrTonIIGMAWw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Qwwww6PK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Qwwww6PK
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D89E4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:36 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so33445115e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699912; x=1794304712;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNpJw88oTHFBPlltvGbX6hk70dTl3qN8N9SaUuMVGCE=;
 b=Qwwww6PKhnV8GfVVur4e/OeU4NeS2EBUuA2JgN+wKwu9vyw26aQFUl0G8aQEeDs7Q0
 qr1Ti2vXR8UsxXcmgotE4lfEERYlpCvnsBybDyycvvS8ZnaY6q79CCEeewIEAJP0y92l
 PdDEAIQLsAQVeBq5R1OLk8lnzOzju8Y4xVpDy9r68tCv6k5Dql4IfWLYuRBnvtc3CBnU
 uzz6youiEnfH9SwGjlpEZ0NLlFxuFW+tphm3elhZh9W7e7b4xhGF/usouJL164MxpJAA
 FsnFl+AEEtRKoxnquHLbsGDxcd6hOvFYZcDgdm6rxFN2SQ3Qnw2sNMzX8Qa/70SgId0n
 kvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699912; x=1794304712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CNpJw88oTHFBPlltvGbX6hk70dTl3qN8N9SaUuMVGCE=;
 b=D1PPHsqDn6SH/9we9LKNuRYcw6ICPWho3KS6cxGTdtyxNR6/MuYrqWX/dlo2RqTYVH
 bLGPnBgVB6fphIRubac56NxlqO+kyXa2gf2lqT6tkptMhk7wAwcyAoS3GZuhLA82DsSB
 SXQKH8hoOUxNWY282xlFbAchKrG+iTAHVVFeUcW17r2RXnJgoGNztP3ORQP5d/BQqab2
 HeuG4X9KFQfdBYUph5EYiK8PcGe3O30MT9d+Au4EzCUeHzm7Ym85X420VlyP9rtfasN/
 p1Y/ayezD9Ils/I1YB4psveF8Sp1qdy66V0TfKBasrAAPZFGH2RGgE2rl+wgBCjbG4hZ
 iT3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbFRJKRnBqb1RGXIPx2CtOChY9y4X6F78/C3hmYawdPNWX3pB4WqH4uJpKulsJsbmYan9sxOE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+IXZLkpqAifj/W/mXCxn/KdsDcwTzC1XA/tdtwe5vA0Eaov+E9
 puPIP7H6ETxOHy6q6MhcS1fqDgy8JbP1kvcUiOcTq6GneyruvWVWMayp9kdfU2y5Uis=
X-Gm-Gg: AYBFou0s8dxAEPdtqleGQzAu5+7Hqrrhk3tk2/vIwzIkgCnX/QlbD6XE7L6ArqarHnB
 PE191A83HuE7mtUa0EvBi0poHUKcgJt0LanFR6NUgftPs89B8tIgUQp9pnFdN+SM2wDo69Hnqch
 1Bf3pTeMwjNFZ5WEBtV6t1+4+Rq569F/jOfhhCR5VRnuo5kYlv8b9HYC90ZZsgfQM+leFXDX/Fm
 fb6vZ0dS46f1CDNNbNNErxPHs/sf3XilsEGxTgSELbAlAy0EHwrElEcOpKRsQH5suSZjYX3OMc6
 v7bPZKbvI+8v5ANB7v4fLU0aQgJ9sJ1yAGAxTib1QIVN+HY5fRA5Nl/Rf0MGvI6iWQ7EpzRvU0s
 nCCyQpt0yFTPl7HFP2QdraIInji/IeMfCaJWdzY6biw/xaPim1hj8AVXYTkZcLUNS2VJzScVhf9
 0TjJJQkTMWQsgGDjSp5VtLtHV4Phyt+ey+b4GiXazmdWTF5nfqXco9mRfIJiBh05O6oWvkAqw3E
 6+qmdvxsKEVtT+swBmrJqS/EnbeIkDEr7T6254E6EaeIw+KPWsy7EDSaYrzgaIDFveiBZ5aEh3D
 37+kIbJdWdxrs7F1SUTdOfPQQw==
X-Received: by 2002:a05:600c:a4c:b0:4a1:fba8:b13d with SMTP id
 5b1f17b1804b1-4ac17d16ba4mr282099195e9.9.1793699912614; 
 Tue, 03 Nov 2026 01:58:32 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a922c298sm40056435e9.9.2026.11.03.01.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:32 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:50 +0100
Subject: [PATCH v10 04/24] arm64: dts: ti: k3-am62p-verdin: Fix wkup R5F
 memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-4-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=msp@baylibre.com;
 h=from:subject:message-id; bh=7vYm1dD9lb7UE2j4PKCYiZPjM/2E+yne7vlm5ZtsWyA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX6y+qTuK72M7X9unB78vOXsuvuXmd45s0UUElRDdT/
 t/Ff++bO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi98oYGTrYJlmHNE2z+NVz
 Z/uTbYrRBebHhBP4Z1VYXsn1C+Nel8bI0PhtVoaPUjijz+zctpvXeByEG4Va9+V9myS+5v7l598
 nswIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wkup_r5fss0_core0_memory_region was reserved with
0x01e00000 but the MCU SDK linker for the wkup R5F firmware on
AM62P defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 396 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B63000

which results in an end at 0x9e608000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e608000 - 0x9c900000 = 0x1d08000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: 87f95ea316ac ("arm64: dts: ti: Add Toradex Verdin AM62P")
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-4-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 70c9859fcca8dd964a588a0642aed3bd71bc1dcd ]

(cherry picked from commit a1eaf4d57681544696670c195db8170df62b81fb)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
index 7ee894d59113..8a5ff5c45757 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
@@ -170,7 +170,7 @@
 
 		wkup_r5fss0_core0_memory_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			reg = <0x00 0x9c900000 0x00 0x01d08000>;
 			no-map;
 		};
 	};

-- 
2.55.0

