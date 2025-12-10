Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A68ED3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F79583AEF;
	Wed, 10 Dec 2025 16:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zsyan4wL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DAC880077; Wed, 10 Dec 2025 15:11:04 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B9C83869
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so1242950966b.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375862; x=1765980662;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yc6zrG6PsIx5Jt28/+5YDi2gTXteXl11iGUvLHnwJ9o=;
 b=Zsyan4wLzLfI55wWMhUc4Qji+61R6V14StjzxVFQmxGkpUms7mzp9Bm/9rIbZc74AK
 yhcOoW3hRZ5jG1OAr84k5A6HnLxyu+t56mMxQOTMNsQ2abHVKGr6wpaY3IhmxAYbNPxG
 Erh+C1PXKWf42BGOQrJDG1qIURlSKGScjjnwVlcVp+RRu5ADiOKSf1pvm4RDkovDXsJF
 lkRJRSPvaBSgSiTxvrVKQNirpyZkgTAblhwd+c8jaa3mtHj0oatC6NjqNVH3dWpzPOWN
 YCUQHSjKDgA67nyZvY8y6C0HcsFARqRrXExUyAlhpgBmHxw1Fub7af+gQHVxg3ctgSLM
 WNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375862; x=1765980662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yc6zrG6PsIx5Jt28/+5YDi2gTXteXl11iGUvLHnwJ9o=;
 b=dVWNdHfO+ZhY/FN+Rmnva+1KQNgpAUrrbMXsJurredBsz1lqVNwt3YzXcCk/sJW0m8
 qCaHXosCQWWogPU3FPcNs3hYBwTt1Equp7Yi/2fLvCVVugIzW4XQTMst5FjV+KL0YwY9
 sIohH0TxLnCalbTmchVZAi8Ymaw5mTIo8RAac22BYQPOeZzszqhzgiSRcjz8OjUuFJ0q
 zmN+/Fqwm3+3fkj/dnT71S/QmvMLWInd9SWiGjk7ip1WgDiYu2kAP05g2JmuuTqtv8oE
 CiZy/gbSMDO3EvL9O7U0T2zaaS9K0+JPGxmgKrEVA//qiB6sx7DqXimLH+1S1GFzDvbg
 iRGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDaKjRvxX3DB+FxtC8RVh/F9IO+Bv4osHIWgs6S5crJMyvJIYIzYJYYZRadS35aKg0cYN5sA8=@lists.denx.de
X-Gm-Message-State: AOJu0YxNAb4nISwJWG5VGJX5SOp3F8nBAzA3oL0ImsYEjTL488e53rDV
 83u/yBqNakIg+1MGaFb7Qs46cMgvC+q1epsyIKKS9U/kewDudoYjIK0fvxbYbBOhyitozd5WBfQ
 83ngH
X-Gm-Gg: ASbGnctgKnB4gHW5L0i6wJad2nDxl/puo+UjHDib1mcynN/pCWzc9wk17K3FTOR6Cwm
 a+ThnvQFe18V3/Ju24U2d8QDAjfOnk9Al+cJ2TXUOQlENJ6rRhfSyBOWFrNbWEizKjtaYJ9GrXQ
 kB6Y+VfXKfeMYEvCsLwM8oLjX38I39PPx9ja35eiC6QwxiKRT0oPmM71ZBQ8n3vxgc/p91S98xZ
 Lx9GNN/GTsezX4LB0uLGa0zcUVjbyatoSpC2awLo9843cFvDXCHwnamenegYVrZIGLkHG8Nk5HP
 Dpa4GjrTtfPxiunE1pvFBphoMGAWqLUwcoH9u3V39hl5sdsBlwYbg+D/scUy5SV3CyVxNKbwLQF
 wVPZJHYxV/5bTMoOPPFkyo9+L1MxivQngaKnPMpevoru4xudqLbMSRra9jIZCsoCstnk0Y3g5Ms
 8bnRR5NCiy
X-Google-Smtp-Source: AGHT+IEKW5VkX2e29De1MQ5MbV1WHaU/h3NVymBlpyKh2co0uOQKXtwfnpAfdOOEJcUqKZRGykf4tg==
X-Received: by 2002:a17:907:6e94:b0:b73:b0eb:16f5 with SMTP id
 a640c23a62f3a-b7ce841b08fmr294476266b.31.1765375861607; 
 Wed, 10 Dec 2025 06:11:01 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2ec2ff8sm16882485a12.7.2025.12.10.06.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:11:01 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:03 +0100
Subject: [PATCH v7 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-9-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=msp@baylibre.com;
 h=from:subject:message-id; bh=wVFAtXt2QNMd4vDTHTYSAg+183AuTZeoBqrZaCpICYM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLersvqXPEn7sll2am3/mf53J0Rqh5RU23QnPJl5MHs
 gonPrrQUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPxP8rIcECf70xZ5lpWDaEr
 qg3PDvUrTFoxQ8NTs/PkypW7nVMmngSqWFa2vO3+MTmViEOsdzOurn8jcita6YbkutObjx//EdD
 MDQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 976bbbeb8747f9ddddd78b3f8d7f3787c5bfd576..4bc688ae10cd0ce36d87d2c2ad2d7609db52d5b2 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -255,6 +255,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.51.0

