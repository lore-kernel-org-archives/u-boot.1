Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EF606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B9Be1ekM;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=G3A0PDyS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A8E94064F;
	Tue,  3 Nov 2026 12:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDfi1vHPzxsJ; Tue,  3 Nov 2026 12:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4316E406CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793709633;
	b=Srji9+1Ni3doQtecAbgp3G09fxWF0nnAN7ahZ62RRuOG493aTK5wXXjyXaOKUWw4uMj9
	 weWtZRPcj4UVr16+G5PAQY4NXP6ZrzgXysOTJukSfbP/S1l6+k55ItKQU2jMJRzlCKb+3
	 A+sY+R8doLHPaHYaNpTrecFzJVcBiho5oI+wZVFyKv56zPeU/UVAIdwLYelY+tk9aVe3X
	 5L2MQq3VXPMnqhj1+qiuUukvpF4hqkaItwpufpUU8VUXXhNXkVi6Pxa9Eop9hcIcJEtW8
	 UqkL/mDFZhO79hdRcS/VdYJxhzrKFjhymaTYLxFOHw+HQ+yiaC/qmV/115GeOm7R7nA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EHvgPuiDIYnxfZjR+o5RbV7rZ1gN8tnNN/wOhtLrVPE=;
	b=j0yn9N9+HtwY3hO1bPgOBvb1ZYvTvROcjXYOAkQWz7ArELUHG3RwmxifW6Xb7F2wgDK4
	 rWeD0XGq+EEQkMvpb5eUowgpZxDH5dc5BUh1URTeu/xVBNrw/ji8Hw05ioAADmip+djCc
	 s94CKMaMDCnWToVYwAhIUTjhacuBITTFAyuXP5Pno6R54lEKVP0syanEP6TJi+E4dUslg
	 7Sv3ANvIQcgSPTgue78pkKWofSxRuiB4j1VHCHa13vppU2Z0uxbcXTd45VDeKX+A1mhqM
	 5MWkEJ8IsldKMSs0dOoRiLo2bFydL+iB06vJtAm6Z4tIYj0iLUncNBF0qrPDnfhmbeQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793709633;
	bh=EHvgPuiDIYnxfZjR+o5RbV7rZ1gN8tnNN/wOhtLrVPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9Be1ekMhJmDqX1HrRvDn6uPsgqcszaCnwCP/D+RTbVzGiTMEXGMoJeZFrttlT4pr
	 X87hWGDoPgd66wQpvY0806HXyCBIGTomwsEHMqk4Q+T0ku2pcIRZ/Rdg4yi1MkKF9h
	 Ja9bHH0e3cw7+HAZAU3UIKwlw/qhZ5DQxZbj//o/3MPR+m58vDUBw+epafMdaT8i4/
	 A9BAlKbqzGAkPCfbsU6Di3GgIV5yfeU5iu9dmD7QndpMgrJJpR4/dgKt7ErWgSgatd
	 moZny2LgSo4s6P54VegNn6K+FgO/ObBwcvPPkNIQjzMfBi5FT95mnTz/fWxqSf6Ln1
	 Ts5Ek7XCcQP8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4316E406CB;
	Tue,  3 Nov 2026 12:40:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57624235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39ECE607B3
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MywwvX9GsvbY for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B785606E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793709629;
 b=eiUgVoE58wJTwKbWjz2wGLJjG0Bg9RxBPodXbajKUrVmrcUXUk10ID598K7oOSDdI9Eq
 PZnUW7WTyo3MVqcVD5UlOZTUDNxq+HKxPAHcKujvvrdSBO5S/U1dJ7VCMjWdWgwm1dAbB
 jUC66KnWMDtsOBNtDtomlrEMZYWAluyHDWdDUeK1KDWTExoZJwlYlSLHQ4SAywsH3cqft
 aaz2qNL/G1UR9pDFTadniFfEKs0pq18gSCknRbY0hIDvX8+zDZZ5T8buWlQgG96Njlbaw
 GVVFQhrj4/5A7+Okb8FueCWF2iwOwoSi9qCMp5iEyPiHbGRg0acEw0iPwplowgiiw5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709629;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=EHvgPuiDIYnxfZjR+o5RbV7rZ1gN8tnNN/wOhtLrVPE=;
 b=hIUwJCmQVjfkkXRoLRLSsOl39dYpQtCV+EZPD3ZdxyqkqSEryilQ/dxc0KPFQOq81qYZ
 pA38EA8EQVw5bPQle8IlT8j/fwm0YVzqsYqSOv9bHYa8bHYQnJ27luG5zfqQdUr+3JNKa
 NEvWaoElcXtmchLnMVlsA+9+4kKpdswHLapanbBJVsr8GemmFSyD5IwQXZGvWc4MULmLc
 hYNX6c4Gcq+iilBRsbaJSfq+HbuJN0W7vLcg7clT570F2DztU0kgLENxp8umqy440LtFp
 9SXOrc/HVRptPQH4/ejcFFK47wEH1qSYZJWGqUVY76zF955Ks/IgSQvn8CtRYrBzFTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=G3A0PDyS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=G3A0PDyS
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B785606E6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:28 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso33642325e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793709627; x=1794314427;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EHvgPuiDIYnxfZjR+o5RbV7rZ1gN8tnNN/wOhtLrVPE=;
 b=G3A0PDySiiz6PcR6mEVKNYvpJduJ8WWDI8OA2Iw3mTVZbIY6/hVc5VWWLtE93oKC6/
 +RhMBxMIcjunfwLe36Bu5hiDhbEI+UZJUUqx/tPfXgkh60pJuw3kZ5zTWHBcduTfSbud
 tTCBXRdg8CccydoDndIFc2NQFD2Xv1qVDi7qH/JKzUs+kVOkiaL3YdtQKgcc73WIhoqM
 GHjPQ06BjBSwMVTGCWxx6HSe3mhXYwAWaXSJTecZkoEb6+AYEkMotGU4cfLruWtj8xHK
 Tvrptsnmkh0QXjmhSJBpuGFA/TZT9UHHj1o/bf3wOtKrI8DGckUpiFfTi7yOL6RSt2m0
 2RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709627; x=1794314427;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EHvgPuiDIYnxfZjR+o5RbV7rZ1gN8tnNN/wOhtLrVPE=;
 b=zvz39odzXsM50GkxcbfFyjPI1MQqdyPMP5TYqtO0XSCORGkWPwaWL1LVGQAlZSC+hQ
 uojwKAl7PIbClSWSTJ1wFQXGzn/idHee+plsA3gXIhp0nMEqcSGE6cPbp5GcqUaObofj
 DHQmSptsJkk1dF+PCHQijqq9a1oejHIMHFy5U5+YheZHtp6E3ELnvPZDgW6rY7d6OINo
 rQGOcAkO13MHvTyLq27HJ6vZXOIXnI34oTkhEEa8m0JeVkNnVOzRqtek8H0tujiDzeuS
 79G8sPR4sgmP4rr27IEsF4MDMrDgI/QjNPCdNhl2tR7cQUSxIZ4vUJUjAP2aFVAWnvIP
 w+RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3Jx035dgIiEJv20zt2YMjQwEgWBCGmfeSUeykgbWAFfbTXItJEYJa8lfSkBVHZyGdmpBFvZs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1IrXfI9LtimiWTC6IoNTovM0c7xHCclpkLWBGm+7gDTTwO2N3
 Pm+QvU0FUsYV/xUK6Buup9kPW/7L9FQDj02AA6DlMcFnptaHTNBMDHhbWxHyEQlriJOJ4csqm7K
 lHsJiAOTCHg==
X-Gm-Gg: AYBFou0SSFnchjBqvcklKQY50wxt/fI5RXvVaQvpzpQGzlwnRP4ofmGdHhN/HNeslJg
 m8Tgf5L3mBDRiRBlwB93GGye3pcFDFrCb3JHtHTfJmGk8gs4aOofXScZUovlCK6t2sxGMShwa7R
 dfuhQROtmmJ5uwU5nreWA2nNzAy8wFN5SYfocFAnUPKn9w12Zaica3DxX/jb8U4iK4ZAyiFoqgz
 3Cv8GVSJYEAYb6ibvz3mhrFo72+vHzVmAGnt2MEFIjAXxxT0HKO1t9Xm/2G0zNqA6+wNXJWJCQT
 A+Dvsd58BSOxJj7AbXLFBP7Xx7qEFgykMzwW7Aas0oZJzRJ1Lit8Ytu85E9YGd9WvLfz6lAmhcC
 T9kPM+D2s+nlLLZtIhQGpCpvq0PNGXT7mkIqp43Obcuh5a/m88wpn6M9XjPYox23vP8rw/KtoVO
 Ekb488806etT202HGiwj37U7HLfd/K17+fkTOMFrDT4isMwQbzP/r9wXIh09N8Ue7RtysZsPNDS
 u0zK5xS1wHpu8lvyAmOEBbBA1SICj7Bw/YZP+31+ogjpnTIXtqmxYMkL+s2evWmUcL2oz0rdiAX
 C97hT94iEfTQ8NKFgzcCr7kzNSlM0R3njRB4Yw==
X-Received: by 2002:a05:600c:674f:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4ac1228a434mr309362245e9.0.1793709627064; 
 Tue, 03 Nov 2026 04:40:27 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm60369835e9.0.2026.11.03.04.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:40:26 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Tue, 03 Nov 2026 12:39:23 +0000
Subject: [PATCH 2/4] imx93_frdm: drop board-specific USB boot fastboot handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx-usb-boot-fastboot-v1-2-f3a918d55a20@baylibre.com>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
In-Reply-To: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, Christoph Stoidner <c.stoidner@phytec.de>, 
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Daniel Drake <ddrake@baylibre.com>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
X-Mailer: b4 0.14.3
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

Common i.MX code now handles the case of booting into fastboot when
booted in USB-serial download mode.

Remove the board-specific dofastboot handling which is now
redundant.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 board/nxp/imx93_frdm/imx93_frdm.c   | 5 -----
 board/nxp/imx93_frdm/imx93_frdm.env | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
index e187de74a72..c24c737d40d 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -105,11 +105,6 @@ int board_late_init(void)
 		env_set("board_rev", "iMX93");
 	}
 
-	if (get_boot_device() == USB_BOOT) {
-		printf("USB boot detected. Will enter fasboot mode\n");
-		env_set_ulong("dofastboot", 1);
-	}
-
 	clear_pd_alert();
 
 	return 0;
diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 96096bc51a0..b68ab18258e 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -26,12 +26,8 @@ fastboot_partition_alias_all=0:0
 fastboot_partition_alias_bootloader=0.1
 emmc_dev=0
 sd_dev=1
-dofastboot=0
 
 bsp_bootcmd=
-	if test ${dofastboot} = 1; then
-		fastboot 0;
-	fi;
 	echo Running BSP bootcmd ...;
 	mmc dev ${mmcdev};
 	run mmcargs;

-- 
2.56.0

