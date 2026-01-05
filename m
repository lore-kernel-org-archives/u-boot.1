Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0E1C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C42D83EA6;
	Mon,  5 Jan 2026 17:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6Tw3oY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0348283D71; Mon,  5 Jan 2026 17:41:30 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0945D83990
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so829285e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631287; x=1768236087;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZQZO3z6Pzg87mXJIcVEiKSBX4NyA0A4Pc6mCykz/qQ=;
 b=n6Tw3oY//++Fc3mjhj0wdasae3keBExlMgJzTP0C8O/Fe27vzng6BsRPC5FGylx5TZ
 j2hmIliGYLmaLsFhbwI/Bpyrg//Srt4iTYevWBSSfaRss5MvNgzNH7AKx0xNH3uFB4jH
 INPLl5PQ/0qfsut+WwdXZVmuNyXpDD6DQcnp37jNigheIXfGN+FPPxRmq4SRWL7BGkC1
 5Qr9zcifTHy+8PcvM5TYehXVZ7UNRUwQLuU6BQzP5+HE1eKYAiCG00/lnVPrCAUxxU3N
 LbXddzmNrl9db1tgAyZGX0Rz/+FtwKBae0S723t0/OiSDnlEXs+pO4sNUpojjFEa8LfM
 +GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631287; x=1768236087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gZQZO3z6Pzg87mXJIcVEiKSBX4NyA0A4Pc6mCykz/qQ=;
 b=PHM4NKdVPqD/QvUANn4i41yi+EIeX7nrutkx4CqYi+Aba7oFGokjbZqwCOryUxwPY5
 Cfd1lS07tXUPX421rMD0npqb5bqiB5XvXK4hwZ1xrcpc4wb/UsxDvlj6d7+kG35xJ9CW
 +cKhvz4Gq5ZcpIepNLqmDd8ZJJgJrfjE25R9ZWO+z92yO+zuK73JEVQquz4/Fgr3syhf
 KyHNFTP2NL0AwK2F2qVV8k2mudg3+VZV9edcILfLNj7cgYN2HaFQwfD4s8RTFGo9imBS
 DUqs+s5LRdYe3qDVU3bMoMnH0iiu5xiGqRZwlkdGiS8lOhyrJJmJoDa4LYXwpBTNDmr/
 tLHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuGukExxr2OIFSengt3ztJ1VByLKEvJx90MUgaEUizFMF5Bx9t+tXwRMXUV+h/FPQzJcgNvY4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1snOm8cxe7oJGN5wc2vebZcTAzyMKpoLDUt2VooZbEkUaHcFk
 ewrlRh40z1y8bz4dkoGW0InHawpsfmwIlwN5Tv8SX6gK4CU+cbsujufbdU10Qy5B6Jk=
X-Gm-Gg: AY/fxX4F9QUdqtO+SEmUynCLnSAqzjtUG1DHifof8cZBcY/Wcg4luCIG6ObrxDlztNA
 /6yE1rXY0oDFOr2q/WcFAlSHW1DdId2G/tz7q+jBE+P9I6xxSeuUomhrnKUat2Oe+KONQhLCJyB
 M4nC/3YOIYo5iYDaLcPGVVNUR3FUNg0FdMakyu/SnHbA0zpZA7G91h/ZdRo6Xw37bpx11rTfGzq
 elDm8EN1nZN6utWYf7tmVBEEM+5XrvWtztGBz6XeYZJM3cK5toZczysKBLah8syCbv796fgcgtq
 17+Io/c2d61fdXYAK8lOcv5TeDjgZRLVWEtF3dbFN5xIY/o1BRPlhcFLOCbOq5k4Ey8xNiqHXTu
 t5FzmOFjkgpqqfu0F3PIzaag069aScfLZtvcu1AYVs9Uiuo9JKuaYIKBRkrP1sBLBy7rCm+yDxb
 poJJOzjOXMVwxSYWKlpR0=
X-Google-Smtp-Source: AGHT+IHHbYNtWbPGt9gnPkR8wdBkZYBcbRCtjxLJdDAaNfx3CmPW0ypw83Nm+8GglxCwv9ILOt0Xkw==
X-Received: by 2002:a05:600c:470a:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d1958a61fmr614448045e9.31.1767631287162; 
 Mon, 05 Jan 2026 08:41:27 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d45aa2fsm157673705e9.13.2026.01.05.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:26 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:54 +0100
Subject: [PATCH v9 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-9-7e33f2c77dbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4m8seU6J+5hGcKcQEjuBiQW670AbJ+w4lBeFhGGmoVg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol/2cbx2m1Nk0quf07er+xbLU6dR2i8Mpa/hvljyy1
 TH1eXako5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaStIaR4ZxzE8uP5V/9XXV5
 nFSOfy4/pSutNe33FtH8JSwX10hFWzAyzC+Yyn37keGkI0lHuRtz3iWlVV++4PDZJ37KqdXtgfo
 HOAE=
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Swap order of setup_qos() and spl_enable_cache(). setup_qos() is
required for LPM resume but spl_enable_cache() is not required. There is
no dependency between the two.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index a74fe3d23d7c4b66ac95aa5a01c2a32a586e9ced..64e146365929f69803217ca0cb9f46eaefae9529 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -253,9 +253,19 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
+	setup_qos();
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
 	spl_enable_cache();
 
-	setup_qos();
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.51.0

