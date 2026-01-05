Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD333C79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF8883F00;
	Mon,  5 Jan 2026 17:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G/AZNA4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3FA839DF; Mon,  5 Jan 2026 17:41:39 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DE883990
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so26426f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631292; x=1768236092;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yCGdigPB5vuELbG1a6JnnhxhYWjgn3jQ96olBFom4R0=;
 b=G/AZNA4YUKOV8V7nqxhnTIZn5zRLrDOoq5K15OH9YYgjsYddeMwfSYlDfy3GHa6zLQ
 sCutJ7xS43sYfSlH8AAuAY8qm0HoSyQBmydJEXp7sqRjlMCgZl0+QKgDB3ZQVZ9HHaRj
 RUzAxmbjw+kFjAcKMNvhCD9kVlLS0Rr52VnMJTvLGTSjgZZF6sPcwE+ranmyUtNC54wV
 GqKFDe7LxbPy+zSIIDknpUcjJiF0/noUxtSxwVMwh7mzjLyh4OOCYIlrRZYPISZ2RVOl
 WZuIJcmVc9kcnr6ugdYfVN7qidv5V23thEvRT7eyVKqC7pDqkuY95Ibt5IwzTjqrFFjF
 vxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631292; x=1768236092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yCGdigPB5vuELbG1a6JnnhxhYWjgn3jQ96olBFom4R0=;
 b=SW0CVwu1N7O3lifd9cyLagDkGDbG4d+7gzq14m25lSfMaLCEEVJ5FcybKIJda8JXer
 Zr+u17gI8PzBA8K5Mu4Y7vuqjOarT8OOchRskfbgTm2Yxdl9oxg1sSPKCxQn0kJPQXvZ
 Nje5K3PRS+W3Br4u9LmQN2mXsXKmmpYSx5/OJlPmA3o8LALdA7+5DLD4g6o2jdNearlz
 HEGkwNMPAmQBz//bP37lYiwG86slwcMQmDMytBRDWekrGoxNlp2FRCotekN1DalLqJl5
 2jbwXaoCdAx+PQxgRXrI2Kpf71ZJqpNw8Ys/wCOGduam708wuoFlimXP9RqufUPTeLvX
 JVEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz9YwaOR9zC5jN7KEAN51cI4a1v9MCd47eFscF2Rb3N2euXFb9uug8K0EubDf5a1qNy2Ud4XI=@lists.denx.de
X-Gm-Message-State: AOJu0YxNXQyaLSviLSQVTYC8uVdSb8cNrwTK1Kb04m25ry4Lu2TUom0c
 0aRZp53Y0x6DrZXzZHtFekv1Q2+AbK+HBWgxghw2+NpgoORzDWc+cg6/HTkryCViX9s=
X-Gm-Gg: AY/fxX7FQmn9wOqplXyujS4L6mmmV8QJvnw3OAws7xtCNyDFC3jPV7/Q1DkFp6vPYLP
 +k+n5CELxj+ISUwFml6rcC8WSWxUFm8YSIxO3KbnZcon2GcbzH5ch8nvdJYSAds2vLWE4ei2jhT
 8LRIhzMLbX5vkhH1bHnnduPiw2Qgwpy3Wt1CmZSQSSlDMSsx2oGvQ7B+AFh2V5PQbwVzxOlT7PS
 AHcZDPA59sPsrYt8nIaKqoUrd9NkkxUow3dv+4w2qBuUmI71FuQ/8PSgstluvu/7byVC90t3XLL
 UAipRCPTGED6UA4zhsX2jgmldBc6QmX2mh3L7lh7zuoS1pq8I6Bt6chO41mDKqaSnrrf0YmcQ8f
 AdcHhvsLy9dk8dt7aXTUdb8LttWs6stQWM72oE7wn0aiv/YNH7ay7olZOXHYXAvjYQT+2kzCBgK
 usqdps3YLi
X-Google-Smtp-Source: AGHT+IFWcKIsFAYPpJ6UXFwO6C/Hn6uQ3l3mGpvWFd5buKswLlwfW3WkwCJy8f6thS0BuijmlonXXQ==
X-Received: by 2002:a05:6000:228a:b0:431:1d4:3a8f with SMTP id
 ffacd0b85a97d-432bca53d2fmr455292f8f.47.1767631291969; 
 Mon, 05 Jan 2026 08:41:31 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca56a16sm374129f8f.30.2026.01.05.08.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:31 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:58 +0100
Subject: [PATCH v9 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-13-7e33f2c77dbf@baylibre.com>
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
 h=from:subject:message-id; bh=q6M81uy73R66xDd9tX31KJ47wNghiY/g1bKkQepNwcY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol0uaJ01SiOuoyKyPNOZfz/BRV9VhXvX7BzeuBP157
 yr3OXR2RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEqJaR4bv3jKmztrtxtL/e
 7Pv6MkuxM4Nx+JFYgeIjK/KeX5ytKsjIMGnHFdVyjdh6X+avMddkfx2Q3iQ7+19WbtqKXmfnsv5
 DbAA=
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
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0

