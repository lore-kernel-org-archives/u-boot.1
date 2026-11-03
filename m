Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D8606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vMbK8VMj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Y6GWbYDR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF53F6082D;
	Tue,  3 Nov 2026 13:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUvEdJ0uQ3gy; Tue,  3 Nov 2026 13:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3339A60844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711142;
	b=KEcqI0FsGpRYWJnfWLebYlJ5PuHKsJ4bBGUMEfXHCcjySh/Bxw9YwXkykFEH1nEjkhw/
	 UgMpcztrUtQHAoViHs4vVBKKsEZDU+QvSavmZvxjTv50bvG/miYM20pgyEanNpcLjoqQx
	 4xeAkiIquvwdh/xiV+y7ImHM7gHSFiqWmVuqLqDKIWSzz/gB0Mla5wQTEvc/2+0yYfg6s
	 vliIikjTCagdUZHzYE0e6H6B3RV8LspFSKgFmst7kKgiwOs4WUWr6Dne4CQ6dSY56QuQp
	 YM8N8icJ0IaZt916MLO5t9GUiClreE2aJb14MiwKNZYLZPGH0SFVKS0FCJC3HxVf+sA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711142;
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
	bh=akiC4fmTU6DiEaHk9lV0PFCKFMYkteULm4ohVmDp4kI=;
	b=hm5DhZf2DfSZ2h44elYjNkZnEB18LBHiIAhH2O+Zq8gbDTjQrmByahPkNYwrqzLaZTdX
	 YJRDrRg2OqR+RtccReHlqmLZ8wvMWyz0LEBLe4iMv3MRWkxLWfSW+/mjPOFicxjCYPIwa
	 WZoKkc7+I6x+I65OpCcsfsT2NSZoFjTJTE45PcobX3qEurPvVbhZnWxh3zakVTy+p2hUr
	 K0fx23f4tQspiCiknOrT77J44qoRaLlk5AOFntLSQduzHL7eX2HsIEUofLM43wFIQHKbC
	 AyTJTCkCGUKmkjZrS188tyHAKi9lU5v5B2YFK61F9I2wTRJlLBiCYlUpoGMY2h/CeuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711142;
	bh=akiC4fmTU6DiEaHk9lV0PFCKFMYkteULm4ohVmDp4kI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMbK8VMjy8Bbku5vD1PUEGoroQI3tDTX2Q+3UNG6fT3YVQSqJ+htd09cnk4RtWdit
	 kcl4M897Dq+Uyi8sk3YBfbfJ2gFeDu106bJyl4EvCi0Q7Dg24N79jasONUfbbD/81a
	 xLcFVrlqaLvd0+1GURonmsujXjpz4kIOM0itfCkzXLxGf4VSS0ektpqz3yU2tzdhkU
	 rWHkORyzqaeEjbFAvMJx4Lu/ZuGB3rg9iw8OmgD1pxmlDCyN5HJsJpeS+a1almptYx
	 IeBdB+SB5UaxdBRKMyK65Te4sZLjR+ITGpKMkVyXicsQeFUnRDizY82YKzf5VMNUDA
	 WoEg9MjpNiEvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3339A60844;
	Tue,  3 Nov 2026 13:05:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE2B5235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93EE280C74
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OeHfLI7eVn8m for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9ED0580D34
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699949;
 b=DfaokQvIx3BAjgpwYcoQ99T5oiRViKZxdQvKiyYuSLHiWZiGCI9hFzQArtglJo/UGKID
 rLownyd2qY+8qEHEuvumK/utILW31AwnInpFDMdicc3XDIdycd2o0GdvYhebJ01zZOA8r
 c4MEVcVlpgKW40lIHtJiU6kMQFIqgIzCoPTWsg27RokG7V1XiGgWxqUe8C9BZNnGdaR0D
 Ou4ZZBRS7ZuHyW7mxUx8bww6h6Zw9UB12xg9/hS1l8eDeu6bWrqB93Y2lMvyjxicjZhJu
 LNXQi9IKzTuI+IOytNVi60Y9eD41Zwz4JZvinbBfY1R8k30P94Pyv0dpkGK8nIhYuhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699949;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=akiC4fmTU6DiEaHk9lV0PFCKFMYkteULm4ohVmDp4kI=;
 b=qL5WXrtOJAXv62kiYc5dbVqG41i4U20WWtC6bej4rQg+CttYPbTYCvpGPPSggqDysD2/
 AWUpfUzVFIGeGI4ox63+4wr4CANCR54twE6YcNTuImrd2q3r6Ob/lTtg1VHZDh36oi6Aw
 OLtvJPQwYBFT+wiZzPdEYu96r7niu4/knk9waMj9O9Qy8m//SuNKO1bkjWCkijuv8ezy5
 cRQ6MsWWzJ1KcOIn37QgHAUPcTsx5MmJrmxbzyaWdE3UC0cB0z8woTmBo2WF2MxiqLDua
 FBlZPwFML6zzAkNR2Xscu9Z8y0mBAeYOgZY2YVn+qc8JpxMKqaeIaZHVUrW3WAlBXYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y6GWbYDR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Y6GWbYDR
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ED0580D34
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:08 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1941420f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699946; x=1794304746;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akiC4fmTU6DiEaHk9lV0PFCKFMYkteULm4ohVmDp4kI=;
 b=Y6GWbYDRQbmyHNWm0jD9O8brFkuxK1XwElHl+rZUQdyvXWNntMsxs2CygmBAvZZQB+
 BF0WRpg08Qcu3dBkoeKzm9b9/lq5tVNBZA83Gfh2wozNNQll7FvtwQwAYlImHtiD2A10
 TyNVkET6QvW9V7BELL80NGStaXzs/uB+kqs2zJEjRefHsyCPW++qLXfdQhn80hq2oaab
 nVy3kRa5Zk7AvOTxvqKid/bJ9VY3seCDBFOofHExR7HJqDny2O4nFUZfxoRSyyUpRroY
 i+0D6yQ+P5sMEHV1G9eCHRvEXgre9K5N7VmvsVJW2um9uiOx7CB69IEt3yaMHdbnZXp0
 7pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699946; x=1794304746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akiC4fmTU6DiEaHk9lV0PFCKFMYkteULm4ohVmDp4kI=;
 b=A354/ztaERDfKjb0pHF2lzM1sucQNkyKff439StORTVk4Ww2HGkr/1mjU0K115IKvi
 d2FutMVPAeT8MdKwOCpJQY8HwRs7jGz1NZqNAEWr/pYuyPHtjx5NiqYV8xi37xz8HgLH
 tpucdpcE6n1VwttjoyVhWvG+2RIQtxR3t60OBM8wesbJl3cqNv09IrEqAmnCia/nBaGq
 HTBD1HTxg/T3SoA4t1fNh5gbTgELz+ME891p9TAe3i3urJ+A8twb+tphu/tJU7LIhPUm
 sl10JlxRIjn0mQV4i43LcnwJBgrIpNIOuL3nm1n2MmZQbpVDIfFIb8mzJe8BjpesSeTE
 SUUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmg0xtNDSCmybSVl1v09m7oohOJYS0ArORnFp/8bf8AZG6Y3QSsSO5ZJhhV2jOOLNXrY4uvf8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+uUP6qQd7/S5rexokyW3r5qmQOuBt0DqAQjnabhONCp1KNmK6X
 y4Bu8nFWrdo5T1mVN/pH8B0ElcwW26B+nObTaEa3P0jWbPhWP7ebP9yxM2tmO11ISWo=
X-Gm-Gg: AYBFou0WHauSIZqCLu2PjmbRl4V7cC1v351kn6ezGA52jDAvR4KypBtCEpuoclXakQ4
 ElAtB7emIHdir80Q9itntfbqlOlSJ+pkIu99BkAT6L1YEtPRwld8598BnwZlmcQ3sCwgTfa/Po7
 7dfiTevNS4tJcnBKX48S+jCiqTNhnNyA5fJZQiuWw1XUwP0saCtRnrk6wg2HAAt6vIBauN9hIWR
 v6CyYu9H0N1UVasTZJje4tKjpWNzqNq3+kG4SZ885aIzT6ml58yiVXhXBXj0W3Q2wx5omkAcHOe
 xfJh7vmf+dtm0l7W8Hdzw8pN7y7gtp52kg3nSkL9q2RJHnfiIbqZpR0tt75ibni1/iqrTPnH7wi
 7LvGxnNQCIHxxNQ3d3xFA3fZe/XBXKRLYvXY3p879i9YUyGQ4WQQUguymKlfquxhZzOosmBdJU0
 4ek0P0V7yj8EwwR74Fff5250ieQaIDVxvt0kC3K6TL2TUImjDOXDhD2XUDSyXikNoiEUI8EanuE
 2PD4ekWJKRIZFpSmqVzOxVRBfl5+aHce0/5HQQnZxjlaCcrfmIQk6iXe7RhnUdTY2Kj+WxxndlG
 YgEjAVM0Lj4e+LmW6wMZDgFE2w==
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ac180f1b83mr304049745e9.23.1793699946625; 
 Tue, 03 Nov 2026 01:59:06 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cf248sm69097505e9.2.2026.11.03.01.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:59:05 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:10 +0100
Subject: [PATCH v10 24/24] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-24-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=msp@baylibre.com;
 h=from:subject:message-id; bh=t9DngpRXKDnmvMIMmVKNbkT1E+ncOdkU6qLg7pmR/Zk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG6yqD/34d0DJuSBxydY+w/b8w0mmYl8LDqq9U/WsW
 Fdf0xPTUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOx2MfIsD76m8Wk1MT1nLHX
 ZjzR2bhDwGbe8wAeVb9ZuhZyswybFzEyfC3rNLyWdffShJWVFke1f97/qLtptrgKy+s8rZj6x/l
 sDAA=
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 52e4ca6faaec..e631dda5190f 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -121,3 +121,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.55.0

