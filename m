Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AE606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TDTyAP3u;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=K33S9UO6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BC48407D1;
	Tue,  3 Nov 2026 13:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xT6dmuaHimqc; Tue,  3 Nov 2026 13:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBA18407CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711107;
	b=BovKWQ7DFO9cjW/MZEfIwF+OtshcrvpKIKbGTB0+sBviiM3IVUkowesr1bPWp0yZtqri
	 9oqTGCOfl0c7oGoEYqGQvi5YDiP/HXOq9DTLRdNhAXtj7nFymostz44QyggDpM7bA85K1
	 p6jhLnXpeKAq26n54Z91IxYvhxa00g7v0pMIF8FEFumAgQdYJwwNejs8vpJ1X58IRRqnL
	 gomgItvDixEreg/ShJWAlItY641bdg7EMI68F58XIYx2ZNss/9SAIIVI7Ve/bJV00bXd1
	 C8zI5Sun8bBeRzx+kBTH+h9g30K/WasGKgjXFulqvdP9oj8jfU+SB71rEV0/rdVvW9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711107;
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
	bh=3UQkWALA5rSU+34YMnebOOpJAjVu9zoR8EaLIoXtKV0=;
	b=XDZdoKkNgAdfBVeQoAbsVFEbMT9DHMEYAhbhGpGi9WnDd3EhCKAasBkggfLkkBBddZ34
	 TUc5Ei+ZMK2aq9P03ncBs8g5tnCbTwalpTYeM4X0vunexVEx5TBYbKWuvcnY1JueClR55
	 FrygvFqcr7pnGSV9B08GYrx4jrzGDPUR/A7AuCIHc/7kt4h+dVZuYlSpyk3s1pipRfpjX
	 2m1d68hkS2hpMQP3fTv5ZIyu1L6s30OA5UBY54f6cvoXpGm4B2KE/sMoU0FEZu3zz8MTm
	 hbSjLDA9ShQcjrOK/nGmU2HK44apOr5w8JwTYsqj4j9nLLFCszLWSGiOjQUe+BLnwjw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711107;
	bh=3UQkWALA5rSU+34YMnebOOpJAjVu9zoR8EaLIoXtKV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDTyAP3ucY+oZfDHDtrQjzGB5+lXDtTxLLrw2aefmQG8kMWkdvcbsgZVgjdANpB7+
	 Ee0r8hPA5E34eWwjoGWpPn4xPsNheZaoJzwJBQDsThP5ATQk6miGZAApxMIVUVoT8S
	 LvPj3JxgvSrrJCMAlkAj51tTouKnIkcQwrX+KVNcBCjt3AMuy4s8W67jloqy9F+/2u
	 /bEF1d+WRsT7Zr6cFaWCZ0xCMjQdVDl7d9bgmWZY1aCaIdecaUokzJJJH/Z130rFnJ
	 wPytNwOjXvlyG9mhUQ88yVt13bMPMkK2v1AKFPbAF77IqMlEefeHfqoomVSMdbpG4n
	 P+RnksqeN9I4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBA18407CD;
	Tue,  3 Nov 2026 13:05:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A0EE435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BCC880AEC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHwVDohatb1c for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65EC08081F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699917;
 b=P2XbxxOlwqnfLydX7nQQmcisrUgeRDZQ5xeU7TtRp64moGo1YaJ8RHwdFv080fWEWTzl
 7LzVyUZsIfM7Gg9pgT0uPdw0igFE6Py4ZoLPQ42tc5dWq/uSx2Ney5wU9U+MA9fSY/Fzk
 v+Xt8Si19O33bO+fGhwENEdw3OAjP4wckFu5zEjGxHc1hZifH7kvlwrTZiOxpPTK8Xgvg
 d12bMuP9yhOZInL23sw3iVfTFHcys53hlIuDvRvK/8MK5RlfB2zgZMGS/gqFURjCJDiOU
 IBhffbjJu+jrQgiN4Izw2CEOK1z261xiOCGLOYnaDVWrgDlLLUaLpypJH6/t3dMilig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=3UQkWALA5rSU+34YMnebOOpJAjVu9zoR8EaLIoXtKV0=;
 b=d9JdMH0mXdmUcTLAZnMmAyIZWX0tnrDfGm0CTR60+AR22qOIpkbTBYvcmC/MWMchRBwW
 EWeNpA/MM2ZRAKXdfuoxl3fD7sjONUpYav0O7ekZFUH+v1xZZS0mWGKEo3QkHFS88+J9f
 iW8xGBR+9ok7ZTJCiOb3//sFy9iUn/2sgebuCIbt4qxdsigYld8y1Y45bWd4Q8tJKUgfG
 mqiyggDMVqE5oExFFZ4bCt2V67AFuDJ4XlIMyKkp/uF6GkLsfRV+R1TTwmzp+wZDTQXwv
 M8FaQJzR8iQbZTup62jqf1glAdSZEb9wY3lNhtLazgl6hfErdVbT8mWjCTY1PlxUUcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=K33S9UO6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=K33S9UO6
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65EC08081F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:36 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso1586096f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699915; x=1794304715;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3UQkWALA5rSU+34YMnebOOpJAjVu9zoR8EaLIoXtKV0=;
 b=K33S9UO697fz1kfDJ7HaFwfYI3x2nn6IMUtmoopttElolblQYCQjyIHxujZGX689K3
 u2LizjlshxYzbmsjv5J4I3GDQpqoGp0Z1IjZaMUJYNYI/ZKiMews0M5mkLwD1AVKqp77
 SHt8wPuut4OL/HcPNBCnpcVU8gU0e3VsdiBBiCoPCpNthDrwo6upDvA/WFY8wI01DscF
 9nTsT+L7opX46NQ76wwAtcvn9gO2JatnBAqW5UoMTqj+fU6rJ5ECaygekazc51cFRYM3
 4xfp/ogCdjdNQASPxdIky7j7K5W5tNcLxiS7yIYU32y7r+Z3MGsk1tiyLXksz+jhyQtm
 12iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699915; x=1794304715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3UQkWALA5rSU+34YMnebOOpJAjVu9zoR8EaLIoXtKV0=;
 b=gg+aqwPiPdb8VpO5nzogdFJudQtQl8odIkgnXxENoAnNKzPwOSfDSD5ZSYgUsF7Hzd
 FBkf6ppTHVF51Od3RVzYNNWmhp2hctt4t0Y2fVMcePvSlZDuy23s6xp49EPNA0HhJjAU
 gcauwVhhqQm3UoDoEuGdvjHkc+1TMQc/Jx1zWpRKz1DmCk7hippJtVq74b4tmftrVUJi
 JFdLpNgSoqjsCEiLHZXW+dpJ4Souw3o9/CokYncvC22ETFAEFCVEEqhs36P8hOJSbnh6
 CfQ/pgr3eaG+hKHlld+ZF1v4I/yMMu+tsmEQPuPyLOhfHkjW26My3pCpPBaucr5QMSKZ
 W5vg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJQxKT5xajSwgx8PDlS0WnkcDZw2Kq2z4OjfQslrhW4yk8uGzZru1N98WJX7W2FrTLx8vrRig=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9zmjM8V6bB1+S9TUlW7ypVP8J+q6puOxRa/TyTME5NncCK8oX
 bvzow5WMynNApUZSG5+DAgbALse4NPYHIl7MEabuJ/a6/zYNDiKnSCJFXMDOK6J33vY=
X-Gm-Gg: AYBFou072eWXY/EuLml52aBZe+rjn5FW9GqtWPPNglF+5wp6lfsnIfrtoU779AhmwNd
 sU7T9sMj/hvZtyGeSVAEBebK4e9dDKLnTNHoV9HIwV2YTYkBrJYtAE3xj/EjjDDMoESqnj3s0hr
 v12Nx+PNRSZpB0f8lcQn6huQV0g6gB712GH7Lh5hPHh7PXBDMS/FqsRDC/DuQAeRIWSc0GoUd+M
 8LiNBCd6/pEg+R59sz2yKVvxJPK5uDADRtA9hPgSAghIgRvOlgbzA9DY9Hf4vVS+fl0joRYyvQu
 d+0dpKh8lm2RwI6E2S1ahMAaVSVJhFUtA3Ro8N4YQ33mIshngyrc+NvLQvqCC3sIEZrTBsqJOuN
 JBM18B1yLLrvLhHgjvQAJwb52Wl4X9Ay9DSdUHDTWNjoTdBRk9ocNuGLM7+8EO1GN36osSD6QM9
 dRFU9Csq7tDOpV91gt74hcBo9zKQRyHQixxB6Wr/FXNHZ9FpJtj72YgpoTtpsCUPMOh/rO9E8NM
 EyqBxa756BlRuxoxSK1b1UYg9RtELDL8OZyy1extIn51u7GPVbbA2Wi5c8YqX/0TqvRiApckwy1
 /iaNFGHp9uulOvjD5lici76UN84=
X-Received: by 2002:adf:ec49:0:b0:48a:f404:695e with SMTP id
 ffacd0b85a97d-48e6e4fa651mr23070466f8f.50.1793699914910; 
 Tue, 03 Nov 2026 01:58:34 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b964desm23901656f8f.46.2026.11.03.01.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:33 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:51 +0100
Subject: [PATCH v10 05/24] arm64: dts: ti: k3-am62p5-sk: Fix wkup R5F
 memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-5-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Mq/O3kWHSOmWOamVPu8LFUXe2vq/ciHTV+sCWPMYMC0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX669lSvIePHD73Lu5OmZLumMWfzNT9t7T1fr4uBvLP
 10O3gtFHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARo1SGf9r56jf6Gn/5Xoq6
 kvVeckZc8cny5dumHo/5u0+vjnuF0F+GvwLnw1Sv1b/ZunGtROi54sPaLmr3E+5Pm6oitEDui86
 Ow/wA
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
AM62P defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 396 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B63000

which results in an end at 0x9e608000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e608000 - 0x9c900000 = 0x1d08000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: b05a6c145001 ("arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote processors")
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-5-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 93cfb76923603ccaec3720dec065a7874458e67d ]

(cherry picked from commit b8fefbc928c7f267025c08f0db0206c61504b4c0)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index b770ed82be9d..b8af9ec81b0c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -57,7 +57,7 @@
 
 		wkup_r5fss0_core0_memory_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			reg = <0x00 0x9c900000 0x00 0x1d08000>;
 			no-map;
 		};
 

-- 
2.55.0

