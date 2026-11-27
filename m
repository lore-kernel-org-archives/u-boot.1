Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E3606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XS8RVr0u;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yUzTajOW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A918E408F8;
	Fri, 27 Nov 2026 18:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUkTrNUwOEW4; Fri, 27 Nov 2026 18:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9A2140D2E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804169;
	b=tbi49PuyVlmGBcsqLsjdxqXB9buE3K2iu+SNgqWXRGB9sx34WmrA60SWm4qsvmvdRSzZ
	 47cRx+SG5990U5LiZpCwNUSVy4CZfG0hDhQydx56/9UfF1BxOITKaoy5QCIY2c5Dfox+k
	 g6LSJeCKyEkBKK/q9gD4PebdSEbj+djX9dYsJ/2X151ZfFTyOPNVp1dUS8Fkb1X1AzVts
	 doSXsWBprBLlIX88hqUI1cRqsw3Zartbf2iSwRHTzo45vRmtQZuB2lWoV+UBmVwvC07Rl
	 kKGUBMD1i0aLZ540EZmg8JsiOyFwxsnLhKd4jYgpNBqt58+kUPJwq42xiC+ahB9p4gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LRkizq88DwnrjIgZynT8s/Jj0qiOhXgG88V+csS96LQ=;
	b=qLfb/di+EFBYd25x/O51QWsw3dMZX2UheK0Au7rzRBxcSszGmZxqnnaA3w4JBJ87sBvM
	 JrdTawowxklv/3+G1E3zrA1giEOtb5mxzwOaxBGGRyYcuGbZjVy+Z5hqyyYKsD7xxbUWQ
	 ZCtuvBJ6EF7TVnUiO4ogDXRGXUdpI+sw9aHeprVnyionOexF6dM1bAPl9BqN9oPpc7yD+
	 Y3J+5OBWR8SB8voqTfj8Eq3qmZvqgqyUVxpKvG2n/l76hXvst1d3i5WbDHNnh9HYkokzG
	 BpH26USe8saK36qmToa6LP1t8NXCiNLc28b6ZyDJ709FUzzQWATX6mmMrgwh8vTQiJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804169;
	bh=LRkizq88DwnrjIgZynT8s/Jj0qiOhXgG88V+csS96LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XS8RVr0ubPmimmuSjSkI7eH3s0tFhyR55n/doKpaJbWqXeRoAL2urX+YMwVl6ll7d
	 JWNkhc10d+cZKEpQETPi2G5fkaS8PMTJc99EpHbRLC7ta5Ge12Kv+D9sGluDsQ4g5x
	 RNVq4F5lzLUfK1A9PTPz0xg2qKzm7rZSLRyu4AbMunzaBw109iNoslCebFfL8iISH+
	 VnR3tI0QGE2nJgRcZgmn8/5i+8UTYhxilmbltfQQhPyeCKnZGrsKGAUQPTDfyA7ngu
	 mW0YrVYD32vbss6bDS/I6WXlgtpBp+DLEcXpO/BoRscVt3Ne4Exku+VkADZyKwphqN
	 QTljKIsm9sb+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A2140D2E;
	Fri, 27 Nov 2026 18:29:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A01F0A0B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F1CB405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gl8diI4jwYIo for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C07FC400BC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yUzTajOW
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C07FC400BC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:16 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e47347279so5142926f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804155; x=1796408955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LRkizq88DwnrjIgZynT8s/Jj0qiOhXgG88V+csS96LQ=;
 b=yUzTajOWMPytkw9aDQP+jd1cjRjd65t/YGia2MDN5JiVc7AgvkDkF94odqXr4aBpFJ
 7k1TCYJwcuASwU77SsU+vdOwVHOL3SmMFRS9ovHpzI8Y/H3ErsiEThaJ8yDeE6NdrBUA
 Hoe0GktbvNupn0jlamHmPVq6HbW1Y1fJupd2ER0e0sS4zx26RBYJZC3l2s4uCxBNUVmN
 TKkrsbxlsFKdT0vqNEu2iYcpahB2oKl6Huc5vz2d+zcHEcE3Sq66KKTpaKThy8toSA+R
 AFVCAI9p+CuSpA0qPyCf5VPkTSt5x+ypcblk6kOyiBje7ZDYOMN6qFqpqBZHYFIRSFCr
 wKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804155; x=1796408955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LRkizq88DwnrjIgZynT8s/Jj0qiOhXgG88V+csS96LQ=;
 b=uglJy85C05juPfLAgR4lBs3+XN9O36s8GMjMjJQkpf/Y1sYdqFH/h8mB4LJCk6kvrq
 GFjjM654DHkPNAcVBibmxmz14Ul7NyZrewZ5QMXeouX1bkri/yupPgFaWteorfdTdAjH
 vZ6BbC0j9nCCd5ZcA4gfc6vKS7Fmrk1c8J9pHUscMpG2+NGSfWuhzt26n2BUBhRdtjp0
 hZTHFummtddIK6w04kfXF5baQa12zqTQmUlENm1ISQsXGjQ2j3MRSCKW5k6g5UlfNp+5
 apcH8Y/73aR27Gr5jGKJwIc+IHmfVrKfQJDOZN27/u0gVl2k5lyKxKGCkVHhaffgX6xQ
 bazw==
X-Forwarded-Encrypted: i=1;
 AL+hErEdx4lRbnLfU8KJEyIAE9Swtc3S5K4P/UMriZD8yMDwek8TN99rmniFjQDJHe9XpwGpZa2OZlQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9LNc6UNp31LKu4OKnKb01lnKRPiAb8d4b4DpZtGfUlRw/Y6o1f
 vNzbzcYqo3R/Vyg/BNgrshiFR3P8IqMzVcjOYwRRGEnIYvx//JaHb17s
X-Gm-Gg: AZFdTZeXTKyKt/BWpgOdZBf3uKoFpY6Qfzqps38ZuqRFQaGWap81bLpb8gRDRVQlyva
 J78VMrIc5gIFyuv8oKs1rz6jepzGV8kSOXwkmJazM3WcjTHiP9tUPIoLWrDjtsxXrlgkfzBkxk9
 JEJuHJnvKL6YguDiw6fRyDZbUapcMGkzwqnl/wPXV9b/mMaos7TbIfq/nBIcNhF0qqUY3Ueu7LY
 hZ748Ff3e9MKc4tPvK/t14DrqpCPN2Q8YQBqwVH9yJjhAJBB8YdYqHeZQkrzkkD/gDmPyvUMWRS
 FSu1tCuDAny8bxvBvxDh7tyCZQjRSfdLrnzT4j/u3yDa4kXKXcU7geagVwZn3MhC6xRf5GNPZqN
 qQ/ym5QrpQlOYzWt6AFZoChC0HsnDR05t05II6gCVLwTXiIKAm67tPqfHzUFr7nahA4f0JuNx2c
 QU2aEwI2JztGRwyCoX87vNpqpXAdP869N0Uh1n+IpWDqAVXyfkUv7W6dgxpZVa7XK8DZ3aEcGWW
 ZsmpZo9Il/ZQLFH+3cC9A2SvfFXC9xhr+eCSM54UBwwuN6OpIH/zrwqW9n7xeoO9I+4ksZWTTWQ
 fXIBiH3nsMeRLJRVGfxRzTEyagOkLuwQM+8=
X-Received: by 2002:a05:6000:2c09:b0:4a6:4687:2cec with SMTP id
 ffacd0b85a97d-4abacfea516mr49918112f8f.5.1795804154787; 
 Fri, 27 Nov 2026 10:29:14 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:14 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 8/8] colibri_vf: leave the USB clocks to the drivers
Date: Fri, 27 Nov 2026 19:29:05 +0100
Message-ID: <20261127182905.2836449-9-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

ehci-vf enables the controller clock and the clock of the PHY, which
powers PLL3 or PLL7 up, and the clock driver takes the PLLs out of
bypass. Drop the USB part of clock_init().

That part also switched off the PLL3 the boot ROM leaves running: bit 12
of the USB PLL control registers, named POWERDOWN here, powers the PLL
up, and clock_init() cleared it. PLL3 now stays as the ROM left it.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 board/toradex/colibri_vf/colibri_vf.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/board/toradex/colibri_vf/colibri_vf.c b/board/toradex/colibri_vf/colibri_vf.c
index adf755707f9..2ef78a5e47d 100644
--- a/board/toradex/colibri_vf/colibri_vf.c
+++ b/board/toradex/colibri_vf/colibri_vf.c
@@ -132,20 +132,6 @@ static void clock_init(void)
 	clrsetbits_le32(&ccm->ccgr10, CCM_REG_CTRL_MASK,
 			CCM_CCGR10_NFC_CTRL_MASK);
 
-#ifdef CONFIG_USB_EHCI_VF
-	setbits_le32(&ccm->ccgr1, CCM_CCGR1_USBC0_CTRL_MASK);
-	setbits_le32(&ccm->ccgr7, CCM_CCGR7_USBC1_CTRL_MASK);
-
-	clrsetbits_le32(&anadig->pll3_ctrl, ANADIG_PLL3_CTRL_BYPASS |
-			ANADIG_PLL3_CTRL_POWERDOWN |
-			ANADIG_PLL3_CTRL_DIV_SELECT,
-			ANADIG_PLL3_CTRL_ENABLE);
-	clrsetbits_le32(&anadig->pll7_ctrl, ANADIG_PLL7_CTRL_BYPASS |
-			ANADIG_PLL7_CTRL_POWERDOWN |
-			ANADIG_PLL7_CTRL_DIV_SELECT,
-			ANADIG_PLL7_CTRL_ENABLE);
-#endif
-
 	clrsetbits_le32(&anadig->pll5_ctrl, ANADIG_PLL5_CTRL_BYPASS |
 			ANADIG_PLL5_CTRL_POWERDOWN, ANADIG_PLL5_CTRL_ENABLE |
 			ANADIG_PLL5_CTRL_DIV_SELECT);
-- 
2.56.0

