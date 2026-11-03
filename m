Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FA606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mq/dN0T7;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B2IhTIi9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB97A60844;
	Tue,  3 Nov 2026 13:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUuDlyz4DC4Y; Tue,  3 Nov 2026 13:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A764760842
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711100;
	b=n6Rt4Y7jj2ymJUp25MVuC4GuRFSpI7ySvWZUqvPdVo5N9cANMhH+BZuhPtXsGuWGINEX
	 P9dfUWljizB0XNFjLxRiCXXk9PMUHXRlxDo/gGxqSIPsxUEk01XXFhxBEjrQ3rlHfvVf6
	 h4ESp90k0ETk2WX0CSP6TeIbMouQSgqOSm8nXXeR7JonON+cO/tmA1iEuTpGUqZWiqxYL
	 cOyFN7pAdLAPrZn3hOM5yUUAW+jRCmeryUlXJtaMZBidoLW7TuIw51RO1fUP8jc9H3EhW
	 7WN3dwQXO2Tnbtwtz156wDsAMr6GGZXPN4JTdaWjs+UwAmnBfNygV5DNRGAAd6NZxsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9fog547iEYJEB2sqqucTbqeOPd8kCexEKC4eGn5/JMk=;
	b=IanRTW4OXImFfB9nHFUDU/nHzJSqIQmI8kJqRAaxGT8Oljm0rpnh01bPKptnBg1cbSL0
	 w7/vq+Vue/KcXxO6GX11ATDyFLxt1pN++s1dbkPa6Px7Wkl4TGLA4YjMYNMo0Fc98wh9X
	 JZgINMIQItYX2sjai0RzYrhngvu+Wv89se1J4nVNkbPyRQLayQt+vCANUq3UPgDM1MIiZ
	 hUvOm1wZ3OeiRU5b8LsGIDfdUuem64Si2tQZsgq4SFluXHW6S4shzZw86ajVndANK5fjN
	 jwSLJoURCbWLvkWXetWyLP3cU0ZHTKH5uNnZRwYYYQYM6hEPg6RiL6QuJzZ5DrObmxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711100;
	bh=9fog547iEYJEB2sqqucTbqeOPd8kCexEKC4eGn5/JMk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mq/dN0T7P+hyi4HTWc7GpRqgKCJ/2Y7EHaR47rhT2uSCJKIa/pJs2GPIgv9jG8+jX
	 feeMUo7wSFGI6n1wk6E+pwqt2OiGH0L/vR2Q9jUNKV15ewDN732lZCLbyzGQt0sK/L
	 S/RTn4Bw7MFS8eD4U19hNTZnTjPs2CFMLQza4fuamLnSV8SfvYbK22VIpFVReQMep7
	 bnK9Gk3yDqM7IJMXOqqG+L6Hzrn8LHJM0VotO0miDlYQou/W/2TcudvnMz9BCXfdkt
	 v6SLaJZps5MQ7eLLZ8xMufU5PghJ0ImqIHY1Yb1tgXi8VxQ8si/VnBqZfWPz7J8rMt
	 g1F5bBGgm0D/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A764760842;
	Tue,  3 Nov 2026 13:05:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3C05A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4ECD80DE2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTs9B7oint9w for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B550180DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699910;
 b=II9VaHjdeEHXgbszMg5XV+3UYDYjGo66JoMWr0oBjgSKrHYk2WwX4K3U9T494eIEnvla
 jUOLgNMki9rpcDHZbxTdewDNb8i2f3O/MD/V3rm6s1uoxt3wH+Tn0ELBoq30cpTNo5Ve5
 NKUTBkwW0514gNi9hpNC1pLpeKxOnh3Jfkx5ep5vB5YyDsfXlqg//tnporIh6Q4gGOV7J
 0q6FMz8DopVUM5EdT+i7vNzCAM0Ry+JkW9Bvc+XNUhu/rAmtI+P1cdWG8F8/Q9gpVNbUE
 z4q3BMVNReOgt63bT7Qt61WcOBwfb71OvOM1IoGyLgbQWBSum6TCV64mBdQVyJtJj8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699910;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=9fog547iEYJEB2sqqucTbqeOPd8kCexEKC4eGn5/JMk=;
 b=oIJVU8RFaRmx8Y+uNfM1kKYNImhB251T6A7Ib09MilShs46QRUn5cyqL1r+hKA5cBgMC
 lDhE4yvK8vmbXlIorm97pKaEsXex8G4LYOcCp66AxVWefo5KavWBW0sDxCsj7X0qxJZ4c
 GuRtEPiyk9KggPtaKS6kh0UmnkqFj91ZtP43xfXnMDIVH/C7bgBn+TGB6uJj9tf1BCFiu
 aok3zOTwv7iG+nfWsNjB9yLokq5e3VikCek2P2ywto/p2ltNFoP9e9eNjchOsVow3wmBf
 D4XnERMCK1AZiOTIhm6Kf5qlefaVW/31+jlUczsK/hKnGRDZTS028crflLa0QriH/Aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=B2IhTIi9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=B2IhTIi9
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B550180DC2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:28 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so2117568f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699906; x=1794304706;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9fog547iEYJEB2sqqucTbqeOPd8kCexEKC4eGn5/JMk=;
 b=B2IhTIi9ZJLFbw1Ca+3+TG21dkADXS5lI1gJWMmF+QZJlr/tk7QPEWazbVEHUVp9BU
 HNAbrFGSz82b5qBClHbAbr2BeRBEK6KBzn1H2+iJ6C8QIE8WuLFyBGWuOb4JahEIi+5b
 HEHLvKbHa5Gua/0As+7pgffjPdc1Za7x42QaRz5RlfrOOzE2MeGe8oKwd11aYPpr+Y6N
 i7GJNQ9rqNYci82BahSPGx9CfO9qvvSjgfJRTK4l2eR+HIYPodA8EIgT7E/eQQJPIv1X
 A60LVagP/kHvevRyjfVcj/Ob1vcEj4tdDMBcohg1A4KlXHnR0A9n3v1QlU7Msch7C11D
 xPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699906; x=1794304706;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9fog547iEYJEB2sqqucTbqeOPd8kCexEKC4eGn5/JMk=;
 b=hGD/j8PbLa09d/X1hL+gIO3MZoVfqqvols845KQgVlHvFO1fRwipCivZR9kYEQ4z/l
 xriKgwf0F3u04qA+a+MqqCWw7URTuCp80WXm1o/ptXnGj9R12RI8ZIpf4O8FIcHeZZH+
 8ST9YTUlxxxMJ1pcLmtK9m1KvLG9KdF0qlgHsw9R1rNsjDCJVInL6W1lEBcCP24/TOdr
 Et3lIHizHhSCyKMRuUHZkXc8A9Vbw9jhTvVeay8HldA3vsY5cvAmXE6ln5+icOvmVI7h
 ZH5gGSDcUdyuPImi7wXPw/gDCG3CJ80uVWog25A3OUVJwTi2sLbP0nUKyXaY191+3bBu
 YxJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs9sHlD+zPeU21lwM/WZZNJNc7bYzhFTbVizpYUdFM8yav1mx+H1yU8RHlPmXXrvvVIEt6HE4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/za1R/FakJDoQJpHAIgpQZNq0Gj2TjqiEVKLS7psui9PmgCJMF
 jLwEaUQS/1PGPST17vqmGmD7qs7v8E3eUUzQZmGuT6Eha/u43oJfiOucSJLk61+2NgE=
X-Gm-Gg: AYBFou2UufvaMC6i65+UFJ4khv7i32OWjUMJvwBjzSDq8EEnTdUVOEkaYp5A4nWYNKf
 +5bSyXZj3qmyW6wA9gbt+BvusPbvn2qKOIzl3yFWoMcI6lL2xC86i2YCyO9DHsyZOLJhz8P5HLO
 ArjvONe6Ofk/A0reilqv9y2sqDehwjZnjUBLSG9gmis5j3aDhAJXdu2Dmb3uKzyPtcKLRnGtsVu
 NutxPEnhy0gLXT6yAlwVUP6+mo/jHzoVoa7mCjSZrj5D+GT2ctV/htxox+vBZ9aGvGfKcz9z8lt
 Wev6pgi+nxFcALZriVVB/1pd+8omFEflDcidR0V17FxFsYjrLiRNZ6KUusuaBhE3OXuE6MLN9IW
 kKkMibLq9DH14TFsQxQy63M1SwgtOz++rJSokjJyF7DFnMHCBGCtIFIbc3m2DJ7S8C/CB7sWdLb
 ON4Kax0MTISiOIPNxgjfGXuhbnGHti6mxodIQlekHSJJXHA/wGJx9OvY9yURbwWtZ/0Rssf4P92
 OsowJEO7pUUce1v79eX9RCDhx73+vKaZSzlS+RiCDADfAfP38Uwn+kxHsFz19WsPwKDU4IGSdth
 pgxnntnRTbcMBqpifU0PQpJ5Pw==
X-Received: by 2002:a05:6000:2002:b0:48e:5eac:7e48 with SMTP id
 ffacd0b85a97d-48e6e2f692emr26167468f8f.22.1793699906022; 
 Tue, 03 Nov 2026 01:58:26 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723b4sm24751213f8f.17.2026.11.03.01.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:25 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v10 00/24] am62: IO+DDR resume support
Date: Tue, 03 Nov 2026 10:55:46 +0100
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKv6WoC/4XSzWrDMAwA4FcpOc/DkhI52WnvMXbwj7wa1qY4J
 ayUvPucsq1lBHyzZPgkS742k+QkU/OyuzZZ5jSl8VgC0E+7xu/t8UNUCiXRoMZOk2Z1Hk/JK3t
 gVGkMIat5vVK6VdmD0o6sjlEGdNAU45Qlpq9bgbf3Eu/TdB7z5VZvhjX7IwNU5LngipmDDB505
 92rs5fP5LI8+/HQrPiMd5CBaiAWkAISWSuWum4DpAcQqyAV0LbBEqIHtnEDbP9AKNOsgW0BWy8
 Rehs1Im+A3R0EqILlpIZei2hN7DdBfgCxCvK6lBCGwRo04LaWYu4g1js0BYwA5KDj2NPWDPsHE
 LEG9gUUo6MEYAe89eThF2RdflYNHApohCiiNya4/x0uy/INiGN2iFYDAAA=
X-Change-ID: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8606; i=msp@baylibre.com;
 h=from:subject:message-id; bh=jh8nx+NyPZFXrl6RyUlfWLtjx5Kv5sgxW6zyni9tVqQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX65d8jpneUF8e/j+wNdz29rNyFelVwYa5m3c3zEtfo
 /vjyv2HHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRrxyMDM+u/svfvPjkiZp9
 5wJOTJ56MPHmfNcLN2L/MzLIvr58ZRkTw18Jw2dcb5oZ13P5f0/TOMt1XO+vJUdu1Jqevaf9vgm
 nHWAAAA==
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

Hi,

this series introduces support to resume from IO+DDR. IO+DDR is a low
power mode of am62a and am62p in which nearly everything is powered off
except DDR which is in self-refresh and a few pins which detect
activity and can wakeup the system again.

On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
it is, the DDR initialization sequence in k3-ddrss differs slightly as
it has to get the DDR out of the self-refresh.

Afterward a specific address determined from DT is used to get the
metadata that stores relevant context addresses. The context is restored
using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
further initializations are skipped and uboot SPL directly jumps into
the DM resume address which takes care of the rest.

This was tested on am62p.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v10:
- Rebase to v2027.01-rc1
- Drop the two DT patches adding bootph-pre-ram flags. These are now
  part of upstream DT. Also pick memory region size fixes from the same
  merged series.
- Cherry picked upstream DT patches for splitting the memory regions to
  be able to reference the relevant section directly
- Use "lpm-metadata" memory region name to lookup the correct memory
  region instead of a hardcoded memory offset and index
- Do not read the address in u-boot code, but pass a pointer to the
  address to the tifs restore
- Added all patches from the series:
    IO+DDR low power mode bugfixes for AM62P and AM62A
    https://lore.kernel.org/all/20260310100614.951573-1-a-kaur@ti.com/
- Link to v9: https://lore.kernel.org/r/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com

Changes in v9:
- Swap setup_qos() and spl_enable_cache() in am62p5_init.c and
  am62a7_init.c. setup_qos() is still required for lpm resume but
  spl_enable_cache() is not. There should be no dependency between the
  two.
- Link to v8: https://lore.kernel.org/r/20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com

Changes in v8:
- Create and use am62xx-lpm-common for am62xx lpm common functions
- Create platform dependent functions in k3-ddrss in k3_ddrss_data
- Align am62a and am62p initialization regarding caches and QoS
- Link to v7: https://lore.kernel.org/r/20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com

Changes in v7:
- Removed parent nodes bootph-pre-ram properties as not necessary
  anymore.
- Added missing new line in
    arm: mach-k3: common: Helper for LPM meta data address from DT
- Split off LPM specific ddr code into its own file k3-ddrss-lpm
- Rename lpm_ops->restore_context to lpm_ops->min_context_restore
- Pulled patch to add wakeup check helpers before the IO isolation
  removal to remove later cleanup of
  wkup_ctrl_remove_can_io_isolation_if_set()
- Some reviewed-bys and tested-bys removed due to changes in the
  patches
- Link to v6: https://lore.kernel.org/r/20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com

Changes in v6:
- Add comment for last part of removing can io isolation
- Only mention a single kconfig symbol in the commit message
- Add defines for timeouts in k3-ddrss
- Link to v5: https://lore.kernel.org/r/20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com

Changes in v5:
- Fixed compile warnings
- Link to v4: https://lore.kernel.org/r/20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com

Changes in v4:
- Copy lpm_meta_data into the stack to be able to debug unstable memory
  issues
- Add missing comments about ctx_lo and ctx_hi
- Use absolute addresses for k3-ddrss CANUART_WAKE_STAT1 and
  CANUART_WAKE_OFF_MODE_STAT to avoid using addresses outside of the
  range given in the devicetree
- Remove the cherry picked devicetree patches as they are already
  included now
- In lpm_resume_from_ddr() print upper and lower 32bit of the meta data
  values separately.
- Link to v3: https://lore.kernel.org/r/20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com

Changes in v3:
- Use wait_for_bit helpers in k3-ddrss where possible and add panic
  messages for easier debugging
- Link to v2: https://lore.kernel.org/r/20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com

Changes in v2:
- Remove 'default n' from K3_IODDR
- Pick devicetree patches from upstream instead of mailinglist
- Link to v1: https://lore.kernel.org/r/20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stefano Radaelli <stefano.r@variscite.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Akashdeep Kaur <a-kaur@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Bin Liu <b-liu@ti.com>
Cc: Kendall Willis <k-willis@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>

---
Akashdeep Kaur (4):
      ram: k3-ddrss: Add workaround sequence for errata i2487
      arm: mach-k3: am62xx-lpm: Add 32kHz LFOSC enable function declaration
      arm: mach-k3: am62px: Enable 32kHz LFOSC during LPM resume
      arm: mach-k3: am62ax: Enable 32kHz LFOSC during LPM resume

Markus Schneider-Pargmann (TI) (20):
      arm64: dts: ti: k3-am62a-phycore-som: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62d2-evm: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62a7-sk: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p-verdin: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62p5-sk: Fix wkup R5F memory region size
      arm64: dts: ti: var-som-am62p: Fix wkup R5F memory region size
      arm64: dts: ti: k3-am62a: Split r5f memory region
      arm64: dts: ti: k3-am62p: Split r5f memory region
      arm64: dts: ti: k3-am62*: Add wkup R5F nodes to pre-ram bootphase
      arm: mach-k3: Kconfig: Add symbol for IO+DDR Low Power Mode
      arm: mach-k3: am62xx-lpm-common: Add CANUART wakeup check helpers
      arm: mach-k3: Remove CANUART IO isolation
      ram: k3-ddrss: Add support for DDR in self-refresh
      firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
      arm: mach-k3: am62xx-lpm-common: Add lpm_resume_from_ddr
      arm: mach-k3: am62xx-lpm-common: Helper for LPM meta data address from DT
      arm: mach-k3: am62a7_init: Resume on LPM exit
      arm: mach-k3: am62p5_init: Resume on LPM exit
      configs: am62ax_evm_r5: Enable IODDR resume support
      configs: am62p_evm_r5_defconfig: Enable IODDR resume support

 arch/arm/mach-k3/Kconfig                           |   9 +
 arch/arm/mach-k3/Makefile                          |   3 +
 arch/arm/mach-k3/am62ax/am62a7_init.c              |  24 +-
 arch/arm/mach-k3/am62px/am62p5_init.c              |  20 +-
 arch/arm/mach-k3/am62x/am625_init.c                |   5 +
 arch/arm/mach-k3/am62xx-lpm-common.c               | 240 +++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h               |  20 ++
 configs/am62ax_evm_r5_defconfig                    |   1 +
 configs/am62px_evm_r5_defconfig                    |   1 +
 drivers/firmware/ti_sci.c                          |  38 +++
 drivers/firmware/ti_sci.h                          |  16 ++
 drivers/ram/k3-ddrss/Makefile                      |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c                | 261 +++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h                |  21 ++
 drivers/ram/k3-ddrss/k3-ddrss.c                    |  31 ++-
 .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |  29 ++-
 .../src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi     |  11 +-
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         |  29 ++-
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts        |  32 ++-
 .../src/arm64/ti/k3-am62p-ti-ipc-firmware.dtsi     |  11 +-
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi     |  29 ++-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |  29 ++-
 dts/upstream/src/arm64/ti/k3-am62p5-var-som.dtsi   |  29 ++-
 include/linux/soc/ti/ti_sci_protocol.h             |   9 +
 24 files changed, 874 insertions(+), 25 deletions(-)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

