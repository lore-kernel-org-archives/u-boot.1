Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC952606A332
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xRPPetGS;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=a+xGrelN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82E36407B7;
	Tue,  3 Nov 2026 13:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id slg3bpHbyv7x; Tue,  3 Nov 2026 13:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5ACDF40778
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711102;
	b=NIaHXuGHAbVxrqam5gH5r+gjUTaVyiBXr/TzOxTtHKGMFTxGBtjw45mEUXvjjHD0bQs9
	 ucEl4+G/VU/aJwH3tBverjTkOcpbTT1BrAEf/NSz/UgjRhTBdN/2HF6fXirldPILnxmQU
	 hkUsNjBjsciRtC8Da/OEFXo6fihpccVKDppy8gXMWbCdSMB0BlEvit4tV0CafqbRXvvbb
	 TMqeYNj1H4kCC/gN9DgJ+2onuhGkXMWfCNpWP4D0p/5b/4QXXokcCkAFWoTwRJ/pDQRoo
	 n1G68XrvWe/5THEVooJ8jXvw+zn7+pq+B+mAe4MPBHebPdfG9D1Fpd5I1Hpv6wkGzew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711102;
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
	bh=a2EoipHl9jGxY8yeY0pwkNL6dmnFmXdBhacQvPsR4kE=;
	b=K26F419P7eKqli7EapYBGwvED/lCE/U9UUHkyZXmEaZqr/lCzmM2PeqaTndxmAkIgoLG
	 vflEIWmxjKSDv3OCOn92I9TGHIgciX7inB172+wVzCzbb6ge8NHFF1ea8BpeUtVzAs2HC
	 YM0f0pWcGzIKuy243tXbv1G1Q4xHeSGNgGBxFK9o3jZEMw4FJPqj4TfgZ5WP8R6NrUgfJ
	 gmWGhDisGL47b/ZBucJbgA4c06SXkDDvx9npegr4I8mpq1P6swmdS/+L/T1Ag8lBkCcd6
	 gRgHPlHBSAQY/288jM2t7ho4QBK/ofGt2HFNw0S/0jxlgmhuKm2CckOQbe/Po37/zJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711102;
	bh=a2EoipHl9jGxY8yeY0pwkNL6dmnFmXdBhacQvPsR4kE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRPPetGS4VYzFjS7Cw2pjlVTg3U/Fh14Suki0U/cVpbgNC+CNMNNaAehHhrr3T7Nk
	 FIpVNbmWNBHt52XjbUHu8Jiy8lHINhg+/UWLT6YmK9nPe9fssKt6T3N3K0mV/g7FEo
	 VhGPXIFhfwfSzVGUzWiAJd0eyraTkXnc5g4VlPijLQHku97c7l4CM2Ua0KHi/BbR9s
	 x7Nmcq6JSUmAIq1xGQF5DpjL40jYAFEo8GOyAWLjeXdLXqDu+XOIcaSsXfh+9mwQDd
	 rfCbAnrPYo1HCIKYvvUdVQs+PFUYxIcQl6EDCm+fNElxL2c0OdrNFXsdPHkwadQ2/e
	 mq5j8LTE80xRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ACDF40778;
	Tue,  3 Nov 2026 13:05:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD59D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3DEB606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na75VaIfEyLx for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DCE660670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699910;
 b=QWtS/RZK1F8qzlqv6L5E+ckIbVM5sv5ab4Md7Ou1vLB1Z5NyH21hHU4YyfcWut1bmEOB
 t+KL5Nhxz0PjFwreV2fMGmu+OGya33h3NSq061QwARphLV54tLOkABqPqGZuQ+UsEOtk6
 zNR74mpvQ0T6ynVw9IBvoBdLsqdiLbEDznr8lzGXK+eGNSujCw7zL25f7jOrknBUuaEI1
 ILZxufcd78PUTmzEHJafuv221oCzbuKOPM8on1k9b8VWqLjO1ZGVUrE5NWgqVUx3C++V5
 KU6NM8UTfszhaRDMVu5cCa+zSMR5vVspTPNUe44fd7pmirw14yzYzhpVLL5l8FZ02Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699910;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=a2EoipHl9jGxY8yeY0pwkNL6dmnFmXdBhacQvPsR4kE=;
 b=aeY8WVtACQrg7TSbY4ybxVzmUIZRuDCHHvkJMQfRFhCTlixXPXneXC8YQMF73aEFy0gQ
 ce9yrNqYirgXMPM6B5Ddk9TQ3YuH9b9z57BO/rRJ/eDgIfwPC/6jbs1G5sYh/4tfV6aMH
 4xR4rZfx7jClNJxu7w5bKR1YJpy3IlrfY3nmKOJzeTgnJ8y86yfMf07YMN4RuLoxDGueu
 lPz/lClS7zXkmue4CCopB7F+lUmN6VPDf1pl16gi5ie64MTOS2p+07TecT1LYdFkVxXlV
 OwcjyazasiaLclhm0p2oRin5qgCmrOyb/+1gYIFL514D+1vd0hcThnvuSyZfrttMmvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=a+xGrelN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=a+xGrelN
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DCE660670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:29 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so4163045f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699907; x=1794304707;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a2EoipHl9jGxY8yeY0pwkNL6dmnFmXdBhacQvPsR4kE=;
 b=a+xGrelN/2kGZyVa8atzNtGH+ymgkxioPr+9QTkVgPIUgUfE+kAoGd5fSH3l9chFXn
 jProb7s65A0ySp8Pil9yHGqNRxFenBM2qxRTiZqtCLydPp6SmjpPvJjWTua1o/cE2RMo
 Otnlev9scg1erTmcnjlc+AMEQAw/OUhHhMzf16EBYwoXMmgIrcGYp/8+RmKVeUXbNwEs
 6hiwvdxWQ+8DqfJuRgLUlCgmlYiPQppqVMwIEY86oFgt2gVB0pC2Tm6ca9xhH1t106Su
 nkCaIeP6QO0LEt60corAPFsIlHrE4BX5PS/urhfWu3nXiY3MX6x6rRLP+0+Lq/2V5uSY
 iSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699907; x=1794304707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a2EoipHl9jGxY8yeY0pwkNL6dmnFmXdBhacQvPsR4kE=;
 b=Nuo9Wk/PAkPgCPvwtCDdj1Ws2oCvKieNk7CzrMrbUa/IBHsctZA1+tLzbwQEuf/JRh
 lb8le1gZMBYeZ000hsUFt+2ZXk7/7aijQmqIZkeONhAgDb+8PbNX12XeyZdojyADJ8fT
 a9bu3mlVvq0fqolzfbqonSXT85xvVq/3iPRwctjC/TS9DwpZp8w3Ew9mggQjaqximcb1
 rFjk1QNB8pmN7/0VkgVxfOyTReCaOpWhPpbmdTw6P/w4feM3uQBcGpkwKy+LKN+KWYEs
 iyXbQJhBEzVgDkRh563homutucdF/fyX86t8XsJgCYuIt6kx2xwBFjg0W2db64Yt+9Wy
 Vjsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiF4wX5H7Kg0NlBrY7AxkR8L2L7J8ly2mL5c/pzu0FyF1U7Kyc+F89WAcqb0a9wpW/pTgQ8wA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+AT2VTqnfD0rPfXm8dp3/RzgpqR4dMw5z8ziXAxhVTFB61/xVa
 SyZrL3olXlhCgUaUb7rN6awqfPYS+KXFuTKky3Gwd/xXn9N+GY+yQEZpIeo/RyuCV50=
X-Gm-Gg: AYBFou32PnsUejw6qhJRyRLHwifzn2DPn25+FP5Pv8g0KK572T2WOu4BtOIzCx/LGnd
 jc77XNVDt8Y9SABAqrcjzAN52Q9IYzEBbFC6iHoYcvnK8Gi2ID6aluchQEE/05fnh9Nj7eEOkYC
 MwrBR0170d/4UqWBI8jaloT5TAtn5IGIct7SU4jxo/nUS7v4PMXqv4hfMThABiV5mLv81BBCAZW
 4vmFA2tQkWYOW5yQwigRqkKhhEnDvXf4QH+BeGfeapdDmok4IkfRqp4w7i757IfX2zjoSaze89x
 l1wtzawdcAnekJ/8FSmZWosQFP8iWFDcF9XuIJJad0nQkNHuT2XjVbs5gc2q1TTVC6cpUkfw6yI
 2zk/p98r9gFN4fXngSS7dDVI770q8WFg7JJDyS73x4BiMJIOs3Vi+VHHORfDf7ASL76W6M9HhIC
 8H9LWQhFc2K6EZ/DyWsqLUhcA99WKZL6L9UuiZPM25sKcZILfQlUfX5pjvk+VTDq1ORDD+NXTQz
 phGc/WpFVB4lwWVPpRC2Mlx1k/d3Z/Hguog5vIvdvaiNIHlZwe2VZVVbvtYWzr943wWV2PWSRko
 6EutuFouOEdiNfmD8mKEIapq+w==
X-Received: by 2002:a05:6000:250a:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e6e303c68mr27811855f8f.14.1793699907580; 
 Tue, 03 Nov 2026 01:58:27 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fbba47a32sm951492f8f.1.2026.11.03.01.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:27 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:47 +0100
Subject: [PATCH v10 01/24] arm64: dts: ti: k3-am62a-phycore-som: Fix wkup
 R5F memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-1-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PidVOKGFm7YOFoU6qt8kYherLIlUpTPliHxSBLLDmCo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX69e4+0SsW7pzx29REeMGP9YtPN9frs3PYxZPMknp2
 f9F9vGxjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI852MDMsFNQOCN/4y56zR
 XX76Qpta+dS6cvNygyy3NUame/1r9jMyTD3elziRcSLnR844vbNfxXPXGvsvdFh6/IZK3eu4Db+
 TuQA=
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wkup_r5fss0_core0_memory_region was reserved with only
0x0f00000 but the MCU SDK linker for the wkup R5F firmware on
AM62A defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B5B000

which results in an end at 0x9e600000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e600000 - 0x9c900000 = 0x1d00000

AM62A additionally has a second DM firmware for edgeai whose highest
section end address reaches 0x9e700000, so the region should end there:

    0x9e700000 - 0x9c900000 = 0x1e00000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: 8dd0ac27fcd1 ("arm64: dts: ti: k3-am62a-phycore-som: Enable Co-processors")
Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-1-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 3690b591d07a2e8863eb96e2aff740da47b8de03 ]

(cherry picked from commit 3cc9e9eb606aab57294854bfa440a9eb7c43ea53)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index de4048a3564b..53c096da68b5 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -67,7 +67,7 @@
 
 		wkup_r5fss0_core0_memory_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			reg = <0x00 0x9c900000 0x00 0x1e00000>;
 			no-map;
 		};
 

-- 
2.55.0

