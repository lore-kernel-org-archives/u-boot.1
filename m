Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881D1C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1A483EDE;
	Mon,  5 Jan 2026 17:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/eL7HYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E8F839DF; Mon,  5 Jan 2026 17:41:34 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BBB83A9F
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so28033f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631291; x=1768236091;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AwLU3YUkEos43VqpyHz3sA1hNnWziyeOM5Ldk8d7XBs=;
 b=I/eL7HYaijUjuiOaBI6zD+galhyo5MZaQ8odz6Va7fRUlIecnh4nE3gouKugNEYwMs
 m7QusezfktS9heIoUrVvWfDnPVfMszFOTyk6GSAesdj4ZeQvCRMmDx9mdPisSTumrv95
 FU/3KHwohxGwDOjuFYl7v2Wjx4sKaKi5F2VwllxGsaT1Tw8ge9p/otxIK+2IIYGPqAm+
 vZ1VkDdTwMG5ycFvKj3Ej0mIxl5Bjkfrva3YENFQ2T1lksVCVwXBvRqxAZ4jYo5vAKSw
 k+3x51eDVK8Zc9kZUo8DlGEAFmGWpyGMzazPTLSSYhLs6cxj9AFmbER85Ld0WrXiAfFr
 ynPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631291; x=1768236091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AwLU3YUkEos43VqpyHz3sA1hNnWziyeOM5Ldk8d7XBs=;
 b=ouf4miTCet4k1ymxETAhnsWVm/WK9ef1A3AxSOQH1SMogVeQ9JbjvD/SA4cBq54Wlx
 xVpaXWZipC4ShuOb1pGJU7aXHztGQoy+ejSoXMPP3FS8vaGT1EYjOe+bFyUYtuuDWKBB
 ea/i7kiOxJwgYrwZ0Zukv5wKScjvyc5364zSFlPtO2r7yIvNSBjPw4XUi7Wh9gvKBSNo
 xSmaOFSOFpcqb4w6+aiqfgRJzqDtrKxo8XndesZkB+k522to+RdxmcpLV00fyJ23kN7k
 o+p3QgIKwazwXVu0G6QC1K/BaSqbvQ4qIPZTtotZqmjcyjzUBpx7m/V8DP8DehKQaYCx
 sSYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKvy1Kbx7b0pYtqaEBdGuu9FInlMhlsOWw+4Eu0v7wG+LMKew0zVReLNts0bTYTnBZXzA2KVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyctlsAQ48S1q+tqZcE2qvOFlDg7pjjmkKpl/9SyD0+RLy5ok6D
 2qZqXNznL8gsGgLsyb2+TLYRv7Z3zKPspD2iql4U3W0BynlAK3aVCLBBdOJlzH6Yev0=
X-Gm-Gg: AY/fxX7EZAzp9HPEYbn4Zoh4v3AFEfGrvBWWyMMhrGDqZ8lTvTvULCqTigQhELPKd0e
 q8H8btYzG2IePX3q90Ii/wrowL6UNhxHI9/YsHEEkIhWmTDlnKvVwZQ0ddCEdZFJ8amgMQNZRYp
 ulSmO55YQfJ0GM8xtLrLtxvDjJc/JRYjBtTkuDW6M7JvPOQVRLrHnzZeWICWYz9RiuRjYYn1kdm
 fGGa8dK3rLK1BvGUJHQjELt0qGKb/PI8ag+L8Bdr3dWX2vnPW1PF7GPZkeSJjpqbx0q6d/EbQ6u
 AjLvllmuKMdxE7BV6tE2LvF7DXKlcQPZ8KmbN7sQvZK1lrDjwrqVznNnyo0GOvbeg+yquQ/9sKS
 kUmE4R3yMZjH8J6r9Wg08MBvde8YXvXABuOw3qW7ciqru5Pf3JkD7aGPgaYg2YqUIILgEb8ooAB
 uzY7Pzvr0E
X-Google-Smtp-Source: AGHT+IHj/8xoLvHtqv6NJA1jpM+HMGrCJuEnLnhlCqQ7H6j+XSePMUKi5RHl2avShglkRmvgdzvImg==
X-Received: by 2002:a05:6000:2913:b0:42b:2ee0:569f with SMTP id
 ffacd0b85a97d-432bc9f50ccmr564062f8f.33.1767631290824; 
 Mon, 05 Jan 2026 08:41:30 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca295cesm460193f8f.3.2026.01.05.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:30 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:57 +0100
Subject: [PATCH v9 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-12-7e33f2c77dbf@baylibre.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
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
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JkFmmLrvgUAC6JGhHpGA9eAAYn1Yn+JaFiZUvH0W7C0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol/OfHFYp+at0/lVB49bJBeE2xytUX3s9mBn0SvnF1
 eJ5JUwrOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiF1YxMvwJX/9zCd+NmTo7
 f29vu7qSw+T7J/+cLyy7l6TNnPU4feMyRobte1wXzZty6fODX/M/vco88/vKOiadA9vKT7x+yP4
 9qHMbNwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c4264a5d9272228e468f7057c195593a..3a9f382193532dc3b712a1bd3fa16a9c0de3fedb 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -106,3 +106,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0

