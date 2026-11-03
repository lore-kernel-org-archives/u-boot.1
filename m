Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A9606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B2H+RnKO;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fJWW3F+7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D2F811A7;
	Tue,  3 Nov 2026 13:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xknC9mpf-Umg; Tue,  3 Nov 2026 13:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2313881192
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711125;
	b=hw+ym0wc1M58GY4XWG810SdchJl9xMh+mjkcys57w77mbAHGXlQTfLThY2ujGBxUeYii
	 kUmNZGmJ+8hw7Z2lQiUj8d1Oi4tASfHIHX2rtguueFfAoWkKCWKc+pBtByTdIXp4JUqNt
	 +ecamdJC9paqaXWHs7iJUX6S11oZV9iuVfUJ9a/n/KFIEcWnsfJkVvpHBNsBiioP11H1K
	 0xVXPui+unqpZxeSuNZO3sP/XAScr9gWyDaplwr1xJ6jXgqfgpwc8qQLTUn7Q1MXkRPKH
	 P1vOXQjhKIRFZXOo9ra0RFxW3Gz++vRrh86vNy612Z8yiemZ2JiRLcjjQMaVb8rq6wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711125;
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
	bh=sBCHcp+xodkA5J75WWuW0KEL+5LJA4F97Y5E+UbKRo0=;
	b=G4xsCNJPcEb1UA9U993c5ZaJTX4ayIuy6iSoRTnfGjERaz3o1fUXQvRjp+T6RrERmGG1
	 JHXCdBTFMhhdI2Ze1s7Y0XBizQxUO/fLOUTgqo3ZYZBuwXnC4YHvkx5yipJ8OXIhg06Y5
	 ei0IZcanFl5cLh2tDBO1pKXMqB/Jz6XA7+i58nhsYM/hHX980XA9k4n7eFFw/3oWAk1zu
	 oC4xSIuHE2cJ39i46MhH7u1cPqUXgQYh08tv6qCpBSTQX9L3H0RsnLwTHPKEsFqKOhm9U
	 pKssFBXldndicCMiIX0g2T8YJ7C3JRWzJKnjodKc3Oh/lkinVZCm2+nFjvzdMspctiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711125;
	bh=sBCHcp+xodkA5J75WWuW0KEL+5LJA4F97Y5E+UbKRo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B2H+RnKO+VwBO1YdTf6kbJf1MfkFa2kNGCXkAQzKexA3dg5nC59LFQPOdESPdRuB2
	 A8jrFTwMEaCP5ue4jeW73l9zvoJiZvRKkSgxqKJbIW3AcMOyDrinHAos3K7+I6m8hL
	 doGNqLTgBiOT4d7QxuM6JPNzuAHFqgOFSm1ZzzFGKNKbCBI8Wf2wvkYGeyngeN24l8
	 DGgBvTuHHdyNj/VHlyZEeQ7t9VIDPT9WTEwd0mSARigLpp9ZCgs/EhmNDpst5X1wpm
	 wfQQHDjh/UqLnoY9zCfRjfWLbWS3NXcfKc2/JMCWbKWPf088QTswfnBC5w7Z5JA0wE
	 iaJB1OVg4uUEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2313881192;
	Tue,  3 Nov 2026 13:05:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A29F5D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A078B60670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPDKlX9VRPAA for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82F07606A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699932;
 b=Gc15nxorbEMH0np7P/d0KAK6yiOwzHuTdCUnVLbdQeppk7c6+ieP2GNYZud1whOsG2iB
 6YWjMuLWpg2hKYGN2eEiVha7LMS3STHvEoHPp3ZXyo90Ai1CTLkY8fW6CgkKFKWv22ukS
 ivMdk+rP1By43LLmc5zacb3r3tc7qb6BN0CrkiE++gswbCrtyiZib+CCxlMC39tzFb5lD
 RG/OG3BOVPCa3WjvemLyAazrtF5llT5c/pyOdxJ3/0MeGDPnWG5iQ/+6DHbi3dBb1hkd2
 pNPw3DZM0NmoXFtmyt0r61uwMDPwvaPX1ohTbu+XVvkkadBKeciDzKUjfHhHtBHvktw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699932;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=sBCHcp+xodkA5J75WWuW0KEL+5LJA4F97Y5E+UbKRo0=;
 b=e4RNjY33RNcZ3ou/wDxychW17+suDff5g2a6A36HcJSWYBNqnLqKFNODsCoEq0xi6osn
 ZyehamAG3jkLv6GM6ZS8CGY/TTdscvCkRbafLLzn8tt5kFA+0yX2JW+cVK4OG89rgDpSP
 jwLGuX/wywNFTHNQgEZwLCcVgfsdz1oQnRyWk0IiwqNRKGinA65vCmygETG2a3l6TT8M0
 bHXmHBk2Vcjmuaq4ZeoVz23dEfNB6FqSLiQqpvpqgotkbe7HxKtO5fASFJblnS3ZdBgCB
 RJezqux7qghp2Ec/J7jxMiK0guZyTo348f6ZVq8w2QXoqhWQ00igt+rqwI+n3N9H02Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fJWW3F+7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fJWW3F+7
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82F07606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:51 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3117040f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699929; x=1794304729;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sBCHcp+xodkA5J75WWuW0KEL+5LJA4F97Y5E+UbKRo0=;
 b=fJWW3F+7t22bpnPfOF6dKu1h+eizOuSQas5qIv8SEc6jCMsg/TWQJXfktyXxMbba0I
 5FZBSbJJ8Qj3EmZ9HzCojEjIwJ3G0Z6aqtzlnQEUC35aLtlDmQWmcv+k5qFAgci6yMGX
 Zc5WfO7XSZS9t7teF9PEB+wrC6aewNCPUUW/hce/8rrWNuaCxDGdS4z0Bst86xiirfGj
 hMQWj81URkvdgtRplVaAO95eZIOUHdmEJFAOCNdXLK6eVcClPwlseTuTiz1ns5+pr5CS
 sn78ZFhp6f9jfASQeq0RcN8y6t2iJiEaE218bZba8MZVDo5T4vzC9i6UumLZ7D3Ph0XD
 MDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699929; x=1794304729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sBCHcp+xodkA5J75WWuW0KEL+5LJA4F97Y5E+UbKRo0=;
 b=y0+NsPPv6L0g5JqwlQhr0qDsXq/BNRfUF7UyyoIeq6gEQEmDHpaGZWXJVTh1xdQ7lR
 mtIfubyOaKarVjUjAgE+RPw4OWsAQcyNFBMB7P/KVIU4jzFnxjSpm/omJsFsrUYdJqtW
 Yo7NSL6RqhRLVaMb+KQCK0PjFe30C3qhtJ35Rbi9rP1NJB2R0X8vhbpuEyQ/RLcJmrBs
 BuA8kb95HL4PV2xMOjO8c/N3UTZBCDcZaN7r24Uj/+7nKmzhhWhYMD8+MV+mCMEXYHLx
 IpU9kceWNrg4QUAXz9CMNJqQ6uGfNdST5GnQhjxgSI3shLx1l9avLNeoKZIzpKp2bcbQ
 aQIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+k6dJPB0eorzHyZ3it3f1kVmAaHadWkw99nzOG51768aNtTJepmKK3EK2AGxMit0Utc32nuM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ggmuEJeQjB8hsfTZCV76xDoeEtgiAnk0aLVBnPSapaqsJAlYl
 6m/k1zscjVUiT7iM2TnzuFCy0wnSaEY3yQybLea+G3njBQtGB1vvSH6KLahEU9sLmHQ=
X-Gm-Gg: AYBFou3PlQXROJt+q1usp+ewdXByNAnj97KKn1maduAQ+8BIk4+vW4yFnTTPyLBAOs2
 eTP8qU9g6DjB++vDPTeCdlqsXxNBgvvkqxd1WPQ6YHLxo2OGz+twUCZYWH7xV0bb0bcSbQN1lZ6
 g2u7H1xxmwYVK931vpMW1MNcBHa2QUXywgPw40nqs6qy2pgd4mYHwl7U50cZyl1jMmJWKevwG2k
 uRaWbtCuLEPp2SGCfFYSQtqCxb3AMBhugFKEHtKTtk83xAJ4FcKabzcv6QydwhcsKf7gqNNG/L7
 fWUmfFF4Tuc0MZTffKhP1TifiJaoxKy5iVIFq6/WGoVHv3IQo8whAOqeIQe8Jw3eEMC9+Jtoh/V
 yXQ11k2QVA34QooiTtBz/Zak0dYBHnWP4Vi62g36DilbTYm5gGcd7dIiI7wRD9/shnC28nrf3xI
 8pkmgWkjkmhzFNTm66AVNFqD9c8tozot40eymE9weJ8Zb4bQkh/DvgwocO8XL7v+Tfe90MQjkgv
 1miaRbfZdM7pMRlPHjfWfIR72FTdwthF/QDPPdqNVircNbODq31CLpP9EWHJr6U06M4mZqBA+2G
 BI/u5YWz9ZdkfONQBHFq4hHu7A==
X-Received: by 2002:a05:6000:2603:b0:48e:6852:aea0 with SMTP id
 ffacd0b85a97d-48e6e526830mr26852689f8f.48.1793699929101; 
 Tue, 03 Nov 2026 01:58:49 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm26982542f8f.6.2026.11.03.01.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:48 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:00 +0100
Subject: [PATCH v10 14/24] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-14-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=msp@baylibre.com;
 h=from:subject:message-id; bh=19iIDaynf58JTHyHpgVBgoM+m2mmTPmFj8C2X3K1XU0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG7iOXJ28e3aT9OlegXc6eWn3rzVvtF+S9X7RsvV95
 T890hw3dpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEKhUYGea17HnlUOCoduzu
 0futpyomp7GIfa0P21bVPs/9qKz15iSG/wXinKePXq1ZKN6tYLtD6LyYh14oO8fKNxdOXi1ZyZi
 jxw0A
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
The context needs to be restored after booting SPL when resuming from
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 16 ++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0f5e180e9e94..c015bd3cc245 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2710,6 +2710,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+static int ti_sci_cmd_min_context_restore(const struct ti_sci_handle *handle, u64 ctx_addr)
+{
+	struct ti_sci_msg_min_restore_context_req req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_MIN_CONTEXT_RESTORE,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.ctx_lo = (u32)(ctx_addr & 0xffffffff);
+	req.ctx_hi = (u32)(ctx_addr >> 32);
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(info->dev, "Failed restoring context %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -2728,6 +2763,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2795,6 +2831,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 
 	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
+
+	lpm_ops->min_context_restore = ti_sci_cmd_min_context_restore;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ce50bf6800eb..68908c6c8c46 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -45,6 +45,9 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_MIN_CONTEXT_RESTORE	0x0308
+
 /* Processor Control Messages */
 #define TISCI_MSG_PROC_REQUEST		0xc000
 #define TISCI_MSG_PROC_RELEASE		0xc001
@@ -1572,4 +1575,17 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
 	u16			owner_permission_bits;
 } __packed;
 
+/**
+ * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
+ *
+ * @hdr:		Generic Header
+ * @ctx_lo		Low 32-bits of physical pointer to address to use for context restore.
+ * @ctx_hi		High 32-bits of physical pointer to address to use for context restore.
+ */
+struct ti_sci_msg_min_restore_context_req {
+	struct ti_sci_msg_hdr	hdr;
+	u32			ctx_lo;
+	u32			ctx_hi;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 52696763ecf6..6b1dd801f5f8 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -632,6 +632,14 @@ struct ti_sci_fwl_ops {
 	int (*change_fwl_owner)(const struct ti_sci_handle *handle, struct ti_sci_msg_fwl_owner *owner);
 };
 
+/**
+ * struct ti_sci_lpm_ops - Low Power Mode operations
+ * @min_context_restore: Request restoring context from DDR.
+ */
+struct ti_sci_lpm_ops {
+	int (*min_context_restore)(const struct ti_sci_handle *handle, u64 ctx_addr);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @board_ops:	Miscellaneous operations
@@ -654,6 +662,7 @@ struct ti_sci_ops {
 	struct ti_sci_rm_psil_ops rm_psil_ops;
 	struct ti_sci_rm_udmap_ops rm_udmap_ops;
 	struct ti_sci_fwl_ops fwl_ops;
+	struct ti_sci_lpm_ops lpm_ops;
 };
 
 /**

-- 
2.55.0

