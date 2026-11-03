Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FD606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ew3YBJ7Y;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BIm4YpFP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9C2E81192;
	Tue,  3 Nov 2026 13:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6ufI-HlAryE; Tue,  3 Nov 2026 13:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 370EA811B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711130;
	b=mbCf0/G6LyhudmCDKWzwxH4TUMgJ8lvPWBq3sZJau3tIwP66iMEQ+eJD345IqxNV52Cn
	 mYSLGpRg2dHwjlWF7eZ4jlYjZdeV0R6Hf/OElO1ZnG/e1v8BJv+2vfbnh+eO6Y9TzLSJQ
	 4zqKjPMonGB/XBySpCmhLaRmMCBRz/6Xy0Mpxx812AzTJTYfyOQrVdnniioFL2Hdq2AUV
	 eE2GI5bU2iqCdBR+8qiqvsJJlfDWbBj+wOvDQVuRiMvqOEt1bKUiz1G5yhBkFV2yGHCT4
	 zyzG69wKMJmCE7JwHxVFAX2/HmQ/BPmT7p1T+dytkvZaDZBU2fl9JykH0W0D/fA/5Ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711130;
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
	bh=TRaCbIz0c1XjJbc8ifU6rxNyFjfqgoDh5ebgdfDcPbk=;
	b=UuFbeeftYDV8OhY4jp3OkQahyUaihXO3wfq45MrpVOcaMOJdNUPEkQ0oiCk3m2C9LwLh
	 Ns7jeUSpJMhGDhXjqKwy9MWYhL+It3uy7WM3pmReGPnPeowbRBnBMUlCNfyINQJPsIQ13
	 TK1EOw0ZHNstt9tGCohqZOECptV6j/MkWdLyJK2w7RsozsSgaaF6sdv5cCAxouy956oCE
	 +8BGgOypkD1UyUuPx7IMvBHvm86AvyODx3UOoDBvEFkCoMv03y3u4gA4CgKbzd7I7Ebf8
	 WPgA3aOKH/IZMilMMlJx9PFvQl9nglHWTDivuZX2NyyxoT//cJwuC0x8gJgCCFp5NPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BIm4YpFP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711130;
	bh=TRaCbIz0c1XjJbc8ifU6rxNyFjfqgoDh5ebgdfDcPbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ew3YBJ7Y0VuO53S3aOXx/MRcy/WheuCHfCTbK/YAh8Q2JdLjTxWsalcJdnADVQu3l
	 MIiPoeLW3DzU3h2vwvlnfhDAcQXa6wMhcTHbEjw/E+kxgMmwZJMuXhbiuUurviQXnU
	 WgV5pdSu08zeMHw4UtdGzb6qQE12BHjt081TRkVViob1nwtYxURxdvpq9hr7M/U7Ib
	 wJ6y/XK2cJ3X2anRaif4P4QS2jOc4qhp7QHzZAMEv9XLH2tybtJsi3g4/fafxW/5iu
	 lHsWfQlMH2UNIzNjs7SgjCt6pcY7z1f+BCrDPe6w+tYTe4u+e2YcpM5twEd90UKJtE
	 wd3m3CLyErzlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 370EA811B6;
	Tue,  3 Nov 2026 13:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC87A2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE09480AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMjx1NjIobOP for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7A978081F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699936;
 b=il2UuLvKj9akuwA96qp3Gi6els2LbWtjrPypKdLuCe/9+Crm/Y7pYvfekLvzeZuqlraM
 UbQWm9A04fN+4x/Am2pxvTWRTl/wSRb1r+UmFpKb2j0Roufw8hJ9Zt/mfUbIsp8J0pgK1
 thpmdRzsWoRA8fco4h7x8SSMAGZe7p27WnxeQnIrFJ05KH3cADFslMquFmP80HILrtphg
 jSkGiuRhCsUMSFYEH/S8QDa5FRzC0R8yh3vn0IX7a9VJ2DvoydOyYw4zRW5eB8nlL+m07
 ze2WVcp+QNesJUg+IgGdU6UQaFwe87zT7eqlYeUrGb0yndDjxtj8ChecI+BZ4fQE9Sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699936;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TRaCbIz0c1XjJbc8ifU6rxNyFjfqgoDh5ebgdfDcPbk=;
 b=LBgvMjUmflbY9mC/gACNz9D/dVSH1CG1uath9+/CO8Xx+E0b/Stv1xBZ/pOVuxXhZLBa
 hGcSrROBDoHlpS3Utu2kGQmEzOhq5gGkHqycN7Wn27nUMuOhWYkbtgpxEBF0lXrx5bkd+
 EcrDTDtOFO9tPjBGpnaIznLdSQBX0oGCMJ1STVj/736LocwCbu+SGYqjQqF/lSec26ZYJ
 mRYs4uJmXZotJ14XUuNBgIh5I7mDINMPQ4awGTojBHQRqdNfoho988d5U/KRIhPUyhp5S
 S1RBLsyrMW3yr6kobbsHmcp0h+JrP4V5gbhIXwmGEUCFuc89LsUjmmhZQagAL6kkowA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BIm4YpFP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BIm4YpFP
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7A978081F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:55 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso34961255e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699934; x=1794304734;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRaCbIz0c1XjJbc8ifU6rxNyFjfqgoDh5ebgdfDcPbk=;
 b=BIm4YpFPqY+im4QXDTbnWWuYEERNFn0osMzAr5f/wny7/zI5UehIIEcwboswiLmXXm
 461jhqEUtA4aiu+Sji8dUpxH2j3CLDd3+b1I8elwp+zc9dMX7Fuj53L8jprB6dV9jc7q
 hJoynDWPBk1tJFGLxDqJdpl143nCQPvNf5oERBkyV22EWhwMOFmxsyDrzpRhybHq63tR
 E+7mghghRoLOH2yThE7UXB1bGfpynLGs2qwbUsYvNOl2Uy1BgLGEYAI55nF+FXx8OK8R
 qVSJhXm2mIEKop7Ngq38U0rc+FW7D6SLkf8Vfj3ajYeJ+0KBWE7OiPhCnfCmcGl6DktT
 aKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699934; x=1794304734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TRaCbIz0c1XjJbc8ifU6rxNyFjfqgoDh5ebgdfDcPbk=;
 b=y8Es8XWDfxoJRn/PNCw4oX8cvPRrWLHi/u7XYBurHw/sJ3Q2328YGSjWB+C/McmGwa
 HYIq7JXzRIHojfRTupmTmrySDqDarzFbzD+OtMWXK8THo3+E/DVOhtvJmnNEoxCT0pR/
 4Q3mf/vzK+uDLgbLnsQmvRvpOyVLLwov3QGsh9LaQI9r6YMojI+eU3VUfu32+9/6Sm5G
 90Qcyt/U+t1NBXO7HOtnXR1GkQ19qjtiAEOTfNxrLs1LmmmtK/hYF2WyjRiW5k+AAtsX
 MekGqhppDIlbktGlqvCpmSBkyet71pnX/MiMuIy/zkAfUUp5Cvfkt3bP7TDmEfHnJ26l
 rzLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBjnjTJx+/es/nQ6eoX2HH5rxNRFRpFLYNp2A26cVX9jVNmQTHjjoIVnkkF9G2Ayt3nsHHOb8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z831EQcZ0vtU8n20RxRi9sPYnaUeekxfwQmblxqhUjMVLFtZkNo
 k9TfcFzyza45YXfzfK/T/6pKuxzTFimMnVus1GKKuzpn/RWL2OC7fwHbIViTh3/0hu8=
X-Gm-Gg: AYBFou3LOXRSQ4g2hVsmGER5qPfAMMZ6u4+IJ0Bky7DhvvhIcKPVri28eEpDHr0FfJr
 oewtlpZzU778gi10Z4QbUKc7QyIItQEgosXSVFzAcS3aazJkfG8/oLJtkuZIHCZtWZYcSUDzYJf
 LpzxbJO+FLUSqHxbYCyu54EirkZ70ENxR4U44N/hNg+E8xN8dVUaz6jTcMB389zxhRFtIGXV6YS
 NlNOqblG8TPgNt5zW8ECZQdTQTGj1Axotm5nd3h41Qi7qHpChtzqLd11WTy163/bqosn/bu4T/p
 GXnSFS3KLzDTaDXoGW0DDoVIhDv4wYNpT1cBXQURD+PVrrx7C0tIanVJl/oskLgNxaBDCQYfO9C
 Xelv4KyY7Sezuk349wDAqzwfDe0kxul06ZT40tGy+5+D7NqxJnRgKtli4wRnReIy8QTLF4ioz4d
 1om0xqesK6LvMoewFKI7WwqZOpnif3RNw8xlPEAm0gchtNBU7KeGR+4oydhv+4ezBfQ7iDbC/TF
 qEai3i4R5X1P5DM+VJggR0iN/14WlFOVY/9sbscW3r9E4csXDh2ryiReSILpxpEqME0/xNjt/UD
 h9sISat4idFG8Seukvp9Q2nh0Q==
X-Received: by 2002:a05:600c:3f0f:b0:4a2:1612:636e with SMTP id
 5b1f17b1804b1-4ac16bc4645mr289340535e9.5.1793699933853; 
 Tue, 03 Nov 2026 01:58:53 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa5781c9sm48682605e9.8.2026.11.03.01.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:03 +0100
Subject: [PATCH v10 17/24] arm: mach-k3: am62a7_init: Resume on LPM exit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-17-0b24ff0a4d6e@baylibre.com>
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
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9pvQWsRG0RoFDOSUbZRbTnbQZgi7JyvfXJPpuV0AUxg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXGyT5ZcLK5ojddks5+WhDmnOBj2pSqtumiW9bsz/YL
 ziQIOTRUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPxf8HI0MHx4GamXO2q7GPh
 7yc1KzZ5Lv8QWH1v2a9XOtctX33rT2JkOPDe7OCVHyFdFVK+j+urjhT1O2ceWXVZl03jkYjFU/4
 CDgA=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Swap order of setup_qos() and spl_enable_cache(). setup_qos() is
required for LPM resume but spl_enable_cache() is not required. There is
no dependency between the two.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 401d6a8e41fa..ef96c35b553b 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -232,14 +232,24 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
+	setup_qos();
+
 #if defined(CONFIG_K3_AM62A_DDRSS)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
-#endif
-	spl_enable_cache();
 
-	setup_qos();
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+#endif
+
+	spl_enable_cache();
 
 	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
 	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {

-- 
2.55.0

