Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92139606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l0lcNZKz;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cFQR3/Kr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6437B6086A;
	Wed,  4 Nov 2026 10:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTEack7nL1n4; Wed,  4 Nov 2026 10:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FCC360861
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789974;
	b=PSWXMKLSQZnXi81n5LHePUszXSu0+e8sydd88vMSdhHKupixfXcHAlaJc3FTmr2e6ANM
	 YR/2uKqVoNPctwbqXU3uBRbqCVjgVs+o42T3u/oMKW9SPH93rSTSiql/WDNaucHfya382
	 CRFJrmd+UDGYf69NpMCwisSwA1y3Z0O8ZvEjhCaPkid/0YpuTXozok5zguCtsTEmRX0IS
	 kbQE0NYoH4sOyYhtOgQDlYJ4aNcP8j7DFMfw3pxXUQg3+HZua16XW2lPA0OroHE6cyvoS
	 qz0Xm1BYfpg7aqB5A7m99qN8XuYkpVSoWBlcae3JtBy+ADTAzq0m+7FeZfQY8xm1E8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
	b=mfMKAU8Z6YLNwC54LwTkgNa64keYhIM6pBW4IQLOGd6yKq3EVrCwoO4gidpez9OA/Po0
	 hJmzlWoPxaO0G0tPyjDrOxpmPiEdpDUHZaJuVE0z2JCyNbJyJx3Iljcf6HNUFwksT7BMp
	 WP3OJZz3q70OUP64ZCrFUwbG04Qg6LbSgLrl7yxPa7j5FVYEK8stlgjT5lH5wyeSwyeUM
	 I6jx6bX/vBmmm8Fg3ovF9TLuLEjoK9lgcxaVVaFH2NZIkvwvhWL3Utn2DghdHbWhSD5te
	 GqhkUa14CnU+QmjAUav2eLxhVBxhKFgKOe7X5Z4w4+HI3moPWMX3eNnJO7VS+FtLodQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="cFQR3/Kr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789974;
	bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0lcNZKzBZ+2rC/GCsUuNrezlMx3Wdcd1eoDfDVo2Gp6uEqH8ehvuB1VnEx44AEbW
	 N19vuWgGfH8CQ1PfjRIakUeOhTulTsa/Ts9RlyzhLVWi3accggvNkyOMWzEmzxDCi3
	 jmp6P87wgWaJsXOLLP/xU9zxCJ2UD6nC5loeI5HQaucIiBYFmbjQ723MTSxflrnEka
	 NYdlgluCJyoDabgDt6cCK5Kp26yJwERerp6c0QsP2xauCL9iK48IaV67rBKavUGvBu
	 C8hjJ64wAimf64qEXn7zoFMuLxsGLv93uIBLJfzhRA2ETmEtDc9cGi6Sdl6sRoxg3k
	 dsvpeTWgsqE8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FCC360861;
	Wed,  4 Nov 2026 10:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C39E9341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACBC2606EC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAtbVMyXa7jT for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF21D607FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789965;
 b=bd3z7Zx+Cvehwd+Rfb9DFzppDdy1XZrjYxIoTF0UF7bPEn6jq7R5SXdSCJ7/n7rZ8qFS
 Rsp6/lG5jQY0/NHxEyVi+pUPbUOAeJcI5kqC2ief9+Yty2lA3FH1q6vj7AcgQsDhRxUPu
 NQHs2lHUJFdEubZqDAId7WHbWS73t96XadJ1WPjMuvwVrm1Y5Vka9etYEY4QKOA2X/VlL
 huTaUD3nCapI6VCwhXT8zD54tERrm6W+RgkFDudOuFDcoWC9b/5QH7YWcQtkESdkJVG6V
 S5Bn4UfrWDPC2PliFPyHyTQ31+MJV28S20mEDR9ZRrFPD32ia40V1wBunKiFgKGokrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789965;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=kVNN0Z8luAHhQghN0IxsuTRxr1TyCmJ0SOjS3u3ak8wH9VpQM75vQT2oK6Ik2ZlrMETW
 XfbgNm9Yj4z1acaWCxk5Ubwhalmc1snDIXVQEOFTK00rcSN5uML2hMfywrcJ2i7DWZzoP
 CU7TQGPbwQ+4bWU/P7ajx+/MsYpCu834qSbJySG8sl+SS7oUW5oKNNaEv/zawnEUpJEl9
 Y1kUXHJMa32fPbcWRhHmsw8+93riKZhsmsrVYs020rivuMAH/7kg6lZV/jOuz3zl8crGU
 c/AklxanurXFIkkVF6DJgmWUejmkg1L4pL8FSOGp7WhpA6izL3wCPo7AT/gxsergS5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="cFQR3/Kr"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cFQR3/Kr
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF21D607FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso472075f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789962; x=1794394762;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=cFQR3/Kr1fs6eOTB/S0HHQlkKOXqVlcvuJ6W+rcjTFWSLvi7tA3zD9G9sVM7KFsU6+
 ElVpXiqJxIkcJhkKJNcLC+po9r54ys9my+fEGFgVlOKjufxp5sYMXS539uQcONsUI2X+
 r5VDXxHepRq++jjvu62ZguGqLoTNySDjvEVftSEtz+9HaAQEtvhgPozQc/ccpcD3uT0M
 OIsgRcrtjkbsGaipSIyjUcP6e8mOqqBPNgAm63J4cLLr4WAz/ea2kAlFECz9QMT8dQgr
 FcbyRdcbw1hCvKiBQj6cdKDv4eyvnvDNwd3NZFDjC0l8lyhC7Z7SG8qhhETvME4J2r7w
 BlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789962; x=1794394762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=liRuI0gxpboVCPBHOh2aijzOr2du2gn8LaoPQafrjYp+j/G78TRX/K7lD/sVz+/VEI
 eMcJm4I1kkMFrZWJxnQixAkuuYk3Exvlebdk6VdT4Iidd/KG17wpTuMHxtM2c3DHKnRr
 jFBH5QK3Skv6ZIanzuEnyoZTNCCbwwkKMj5dla1PMDue6a3L8uIjcgzoCS8jC1Rg9EKH
 UPrZ28Kmpe/AZ5Hi5yB2Pno7P2fPOq7x0hQXeeCXFPoMwPT2iGkAV4jFKh6QCdwFBFhF
 c0S7G0Wwm97oSEWdmI29h7GGTBe8ic2BlLbyoYZgn2aydlNY/mlMLd65PgnZ0BzrKM19
 Wx7g==
X-Gm-Message-State: APuU4Z/wzTbWwzKtED17RopAaVGiJ/V1dToApX2Nsdbg0dQhJCsXwBDR
 HWkkF+0mZZ9xzxBeNbu0JFJncrwPn2D8WRw6vvksvN10BmdeanmIHRHIj98oyzBoe9c=
X-Gm-Gg: AYBFou1BSebxTwXGJiGpW0TyePs/6mOaHT7eoHLa9RANS5VqQfTyMtapgS3sMmpuvSz
 /2qA7Sx2wgcLoKoDN7iCNcq9VvFxU57lCy6eBiFefJDHhqWMi2Qy0zxG/TC5pWnaFQsH4Z5U4Ha
 j4sUGKeL83Hep+gcLVRw1vmux+BfkXS2P0wkvGs+dz4O7qZB4MtqeoHdyTAfaNP+/boz6eQWFs0
 ZZWT+bdj/Xg+XNAqUKyXn6jOO4Hr1cyB9A+x+X+Vxd04NdJfMCKcPDScnUK2l62HUWomO6wWC7c
 KkfZsvUeDUigWxl3d8GHgl8GKwZrGJBPH2GM6EDaUNVLpTp8nR/3fIivxlVD+gmUGEOXmr6oQgz
 R73KkaxkXetrVf+aAqiwg7wT2gsorKcOOkMclwgookiY3IFkTPqqXvI5TUg9TZZnj7cYEPxcBgB
 J3cQSHXGZbo43g7cKcgbIwu/3P02tfAHAPuV1MqMIVaRQJN3GzrQOlxnyNF2jGWD8xePUtT6cfi
 hKFs+HjMeccatIJI+RKOvh7nEvm8KomY44jP1b/OTsZhP/TPvhPNy0OlchqJGMDpdMEgzs63sdU
 j9CUPjXncCxI/EBdJQwWwm6UXKxfstDhQ9o=
X-Received: by 2002:a5d:588c:0:b0:48e:3d2:44b1 with SMTP id
 ffacd0b85a97d-48e6e510f87mr33444310f8f.52.1793789962437; 
 Wed, 04 Nov 2026 02:59:22 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:22 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:23 +0100
Subject: [PATCH v4 5/7] arm: mach-k3: am62a7: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-5-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TpMR8AuDiS9QMT2ISzqDy+UojR9qInqTqV93Kugrdqw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/N/E57w6zt19rKJ40bFnm88oi+7f4rTkuJhMzWTfm
 jcXRM6ydkxkYRDjYrAUU2TpTAxN+y+/81jyomWbYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApvrDBYa/giFuES1qljI353VLX5l+36zeunGlsAlrKZ+1ms2PpgfHGf5KCuT/vfl
 6g4tm/6bCz28/xi7wqT60RvZrusbVrXYNE8M5AQ==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
ctrl_mmr_unlock() before anything got probed.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig              |  1 +
 arch/arm/mach-k3/am62ax/am62a7_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index b1f290c1d765..405c5d4fad94 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,7 @@ config SOC_K3_AM625
 
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0d86d52ef267..ddfe84217ab4 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -110,6 +111,20 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() after all devices are bound, but before any of
+ * them are probed. TIFS has to finish its initialization before CTRL_MMR can
+ * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
@@ -134,8 +149,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 

-- 
2.56.0

