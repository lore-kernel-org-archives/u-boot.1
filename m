Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C6606A331
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lmzv689+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HOfMlbZY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 167AF811D0;
	Tue,  3 Nov 2026 13:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YDrZUU6mbLU; Tue,  3 Nov 2026 13:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51D59811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711135;
	b=FY6bK5KhSzSzm2ZoGNKsDNjnMpegxtgQFmrBPUCcoV4F58ciU1FTMVUv0m57G73gIFNf
	 /b4DoYNO5tLNUKRHLK8qwuwedxFT6WKa5Ptq3Baam+9bNCBerpoDlPXbORmUHzQ7EWtvS
	 hc7VlU6xTJqS3xvpjP2jW/CvCTis3TUnH8g17TvfhJHmOpLo1m6un7B9UfquKlKWRxJXD
	 1uzSGMJyBcJcHuCbY2ykf2+LzD8QEJtZtoUHJfEmSXGyGm5Q4RKeawwPbZmhJ0E1BqXl3
	 umy7bVFnXdYR/3AUJql2yjQ91Ey+eFt3QJlmIoToLNVgHQqeg75hfeLEVOo5muWWbWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711135;
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
	bh=2AEa6s7zK6TkkldKpjGu9Xj25WUVCp2GnnDJ857bDlA=;
	b=VaS7cSRHspRwqMUpdXRqUezrG5UlMOBNemQB4rjywW/huIb+n1wxr3CBhE7SCSaNYVyK
	 8eg9gN94RFPD/A/nSV8MSdIz/YahFGEnWBW0kklpkAf+9Ft+dCGar+fbdrCg8cf8IM1Lr
	 g0mEbm0doMmK+DYUtinlYMnfOklUuIclqMwZLPNvrbhyUW9F9Y/R2V+tWCMFDAPXHvtHj
	 AyQ7Cb+mQYwG/W2N8ek+CVV0ci9xZYH20qau1WmdhjKB1PjQW8IdxnJgH22Uy0FtGX6hV
	 RhSLwukfsnuen+OtBiidSr7owVnbmYIh/ZGN8GVCOihh7rwSpKbDd81Q93ACJFbqhDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711135;
	bh=2AEa6s7zK6TkkldKpjGu9Xj25WUVCp2GnnDJ857bDlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lmzv689+Z9OZeS326eRGLUcwjkUIPx2vGBP5UoUIEfjo5XTZBWl84MEpaZNUd/JpT
	 IWlIJuvbvizAsmJxKaUX3/KeYuUSHJkr8xBRH2ufa9shOBYfailL5uGZPTCaMFfV1w
	 ZAcQE2SdpU05nWPQTFjCgQPIjhmadYEAel05SKgXPP7nO0HPuF3vpZGvspPHnSsK2R
	 8hdaUlpaM5CFY4uK9Wn5uUAi8p63y7PQD/JuVxKGTPACqVXxDQEJ+bfkMBvLkehgCS
	 FnVNLluAx8CBOKzUXR1mtNIku3byMbBBo5vvqyTRr4dMsSJEYwuPKwDmcnFj9VHq76
	 7EzGPIJQ+WKhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D59811BF;
	Tue,  3 Nov 2026 13:05:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DB30A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44065606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E8PpixSsbaav for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 303E160670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699943;
 b=NR6KmBdR0u5Sinx0feKsZu4Tl1EN7rJzZPW9Y4qTX4r9JNIxm7Jpj9UHnMfdDh0XixRi
 h5QhzDOCu8w0AaladSrMRuSBPTpvITdiYFQmzfQreAt+5zcZyK9OthM4kDeScetSpS6OC
 Zh6m+iCdbjIqcbCfKcq4LQlH1k7R7IGRq3vp0lQ8+J9OhVWcdiHWPJi8r9ge/tM6e5V7b
 7OOdJbmB9qiVWCZmJyPGdQlQIHd+leltvsr4h8kK5vaAymEBbFSFtNAqBfuDh6o5QlVif
 coBhTBkj3Q4QKnDGAEkyLP8YRYI/KnOd2H//jWWVXMaYGjFNqWOBcMBhLU5gjziZ6FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699943;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=2AEa6s7zK6TkkldKpjGu9Xj25WUVCp2GnnDJ857bDlA=;
 b=bu9rq4hrqIV/TMXOAvY17gNi8NEgPWecBAQMQSf5eTClVHeOy2MRCQ/CiQ8CznNPLb7f
 XedKqXDq3u170XYHAUhC3ZxsRShFRoaO2tOom+Z1JbnfNqhyRuTZFIPRk6Cj6LF9D7gOl
 FmTV1mh35cJ5ipVyW9BQ7nGxhLSCe+IHHDYZ+WlB282vFUQx1NujXYhn7BwBrybrQ+tgc
 X9VIZr5YWETepoWHScFXtg2k5tD9NF+tRf7n5z2ePeSdRwtczvbA3LZymix7RBBvzQEYg
 kWwnFrbAD2+HN6tQNcQXvrBugafeO/WFeLnA9JMIsb+QhLGwSFYs22w9Wdj4wPylfQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HOfMlbZY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HOfMlbZY
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 303E160670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:00 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3117147f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699939; x=1794304739;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2AEa6s7zK6TkkldKpjGu9Xj25WUVCp2GnnDJ857bDlA=;
 b=HOfMlbZY5Kg6WU0mqjmq2pHogSc50BeIt5Zl2JgXNRabzbd/PTfEFWWIIqcEPqxgPd
 KOUwUmWTtEuvtdvkAaq8IrIHymDXF1cNRiZ3gNih4l/+Sve6O4gA1+yQwI/3bqcDRPIj
 3u/J9DqDrfqvnKA8O++O6uL0P62+evbIpqWrZSvPlpaOST23u4a9VtHYOf3cKAVuuqnt
 fJWPUSHjXmH2TNQiK/9V3CVOzgGkPex/GOlgRUnNd23gC5QilSP/JRs2vFDiuL0Ed1WZ
 jGcFWd12wI1CkTcp7vz4mm1Xp9oNQCOLpFxa/kmcmvy/OghO6J6VRB7krZhe7aNwZbE4
 mNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699939; x=1794304739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2AEa6s7zK6TkkldKpjGu9Xj25WUVCp2GnnDJ857bDlA=;
 b=JtghjDXctBRPOKjL7LWxVa5CNvYGuVdC/gMnB/yRca4uFvpTKQlpVYym7V7wcqJIPQ
 Vjcz1KeeFYpjNeBafX838d7uYn8u9Q/UDQJsLYJhmyhLao+ucvJndeJ0orsHvuVJ0r6o
 KxQ2SZwFVmxaenNuVmoXhL27OWuSnH0V4xPRALqsyVQVaQWchzhEeHVRuzEKTQJJMcoK
 /n14jJgyfMwNZPUpOl9peU1AStYWNiLzPSDi46/Mmjs+bGt9fp0FLBJZEcxv9tEGqNMk
 u9hv2zA7X9pW8V3vdY4Xxr1/CwkCixhmQ1DPFLEiinzXn2h0HMGFSY8fi3BvFGfUaVrR
 3ZPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0OLfICBniUpwhKMf0C5GLPLiTShJyzTIRD4EMpeBXAdNoAozIFCl5hmSsiLsN5KggYbe3JR4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+XlXJNJiKcNTXUpo6eXrmkn2WdwYhqqPmenkF+xwQlUHd1oEd2
 O3hQSHZtDcn9NxDVHb0yKj6gfsaoynVz08MZR3+XoTMyLzrBBb4LBPvXC3b6975pCjE=
X-Gm-Gg: AYBFou3NLXkxhXuc48S93Ay8Uloit6FHaztrAs9ES3YBcV9qp+P8Ce2TAl9z2aZg7+a
 bshwHY3JvYC20a1APbGHnEuWiiObYtBfR6VUN2Eo/s7HVJYTP6r3CghNwRqDwdPfgR42pYMsa7x
 5QVhEbOhzkXedPTYbK/vTGyLtHFa8YLoDcVXVn/onMA8LcNjmPtMkF+rYknhjOgIS7N4QFmaYIl
 ErxTlKnyCP0SZMBLuSj5PcH7c4zLadmqZ/9po8vOYpSMYRkfze6aRbqy7yL18EWGpDWZJcAqpC4
 oPZPYjYyNeP34sHF12n7v/rkSJS1jHoltz2sws2LN/zQ9KzIzmaKbDMvL3+9LKDc/EQAvigFaUK
 F+JXv/6BGYNPDBI5eoUClmRAWgtz/ln1tnIkJHiJaTnkHXMTpmoNDkUrVPmM/iFGvNq7aXArjWj
 ppvyyUkXaanUceftwU7cV2Lbjd6Kbp5fgoTDcuBRdsuasbwn6rGZ+5qcu1mSbHUT95glHZlj7ZM
 9sNGyZNgpbtOYnCTNYeo+khTnFiSgvC3fNvY0dHeVwlMDonAMbh1QCRxOURA/wOUZLePG0e+0ER
 8vYNdt8r97zPzFSXhHYyasR4NQ==
X-Received: by 2002:a05:6000:24c7:b0:48d:f460:2c62 with SMTP id
 ffacd0b85a97d-48e6e50da1dmr29722961f8f.33.1793699938678; 
 Tue, 03 Nov 2026 01:58:58 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b727c6sm26263543f8f.16.2026.11.03.01.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:58 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:06 +0100
Subject: [PATCH v10 20/24] arm: mach-k3: am62xx-lpm: Add 32kHz LFOSC enable
 function declaration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-20-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+o4TYwIBCcUiju0B5NIrZBHsX5sgtY86WtCLQkZdLbQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG9RXzdt1Y5fMdZZtxjIL1yTbT2j8uT+pVfpVcJvfw
 dXO5xLfd5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE3BgY/len/vZYO//N4cNC
 nzb/PsT9cf6yzTVFtbNjLtw3cH5meeEDI8Pk02J8uR9e7W5ePnu7lEPLAkbNTkkDjW02ih67bn+
 V/MwBAA==
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

From: Akashdeep Kaur <a-kaur@ti.com>

Add enable_32k_lfosc() function declaration to am62xx-lpm-common.h
to support enabling the 32kHz low-frequency oscillator during
IO+DDR low power mode resume.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep on SoCs with external
32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 741e3ccbcbd0..9eb3ab99200a 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -15,5 +15,6 @@ bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
 int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
+void enable_32k_lfosc(void);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.55.0

