Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681FCC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823E580944;
	Wed, 22 Jan 2025 17:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jhrxPGKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E592B80ADA; Wed, 22 Jan 2025 17:13:03 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B4B80A0C
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa66c1345caso302962466b.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562381; x=1738167181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9kIfLPp97YiyfpJTL4IPVzhbwGiyLFy6q+HX58Mkog=;
 b=jhrxPGKvCIs6gP91SZtpqfrWvFPAUiMKmp3fJXyDxvZdBHqHzMObPeG4k5Gmp9qVJ6
 751dhTXTDiA45cJFf9yjEOQhtF++E3ixZBwrVCiOyVdmGWQFd2p42R/CmL8uYX///01C
 IkTzGbWrcQr0vNeWscDHCWx4IDp3u+pxhrwKU/D9GRsGQ1bx8tORsSzrX8kUIpu3p5bi
 iWAZ0fBnjgc0tY1dThm9onQywUmuLaoFOOiN7euRn28xMZ2y5IDlso2OjJa34tu9BYBG
 30a1RWpCRflS9Q4QkevdmbYDsepOpqjCm9CyzyW4dQpKZMu3uuYXipnNGPYj/DbDbstI
 Jx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562381; x=1738167181;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9kIfLPp97YiyfpJTL4IPVzhbwGiyLFy6q+HX58Mkog=;
 b=hlDMiLwbVhwIk3BaUnF8sI+5/8JvtITe/UZizje40M5IzC9T7OGZdQNOeNi7gKz6sS
 MtPNFqM0U1irmE6xlSnbPch9k6ICV+pxp2fjQoo4f2arAhoujG3UDAsuf0+GTG4TSQQK
 nECRTcRxeIR5TvZP6NwmxDHqjauMrM43A6YkZJPd1YT5G5m2Fy19/Bgc1DpQ7FD+X32z
 LAqvbgxYBgowY8W5KWMF4OITlkcYu7wxXCBSkNyp9538ZzScULMnXD7QEaCW3JxIskId
 ddRxBE9MHFLWKli426akLi5EveHDZDfoR5PPI/r+jEYKTN3812ixmBxqTla29b0x9bIk
 ZOfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwHXDGkHUA5zS8m28y7VbAYmRS654A1q83C3vSwusJjQ0nUIVocAo1KRFGBgvCrZJT1844fD8=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ4+oR/blSiNEQMWJ1nek+qCBHUvlQC357fnHuj2Qr+K5yfSpL
 /hfXdRfoMIdjdBbyQdtX/2SH/LgttSAZX2n9TWzIqXBtYerQV1ljaC/ByQwLuVU=
X-Gm-Gg: ASbGnct64Bkk5QTJkn+ZzkDc8kruNhrhUJX0ZVaSJEmFzKN1phlQ6axbUY1ihzSfuB9
 4d95W+YwUFQCnkton7T+ANdCH+K1LMUUH8uaMYYW2p8/AStYpL5tYlo61Xr4z25hBPE71xed7WI
 wgvISryuv9lB4WMfw/1UEz6mrxFbdkdXQiNbV8ZmQYa+/q82EoCcg7YDwmdJ5EO7t6OaBfIXj2L
 he1ixZ2nlTIVehxAtsIItLTxFgmNic7CemB0FG83PLn47VnkUYWNxAEl1WTNC/JyZy7dyfq+lqe
 MthFhtlxC8iZ
X-Google-Smtp-Source: AGHT+IFDmbwPxq2x21Ql0iz8sE7muUVB9wcVjAzNWM6PLoMwj4sgem8t5BUmKmC/m3ub+YjCNXYnIQ==
X-Received: by 2002:a17:907:2d90:b0:ab3:10c5:9f1 with SMTP id
 a640c23a62f3a-ab38b200489mr1668816366b.18.1737562381083; 
 Wed, 22 Jan 2025 08:13:01 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:13:00 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Matthias Brugger <mbrugger@suse.com>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
Subject: Re: [PATCH v2 0/2] mach-snapdragon: Fix and improve /memory
 parsing
Message-Id: <173756237991.1864727.827993854575196059.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 22 Jan 2025 10:26:52 +0000, Sam Day wrote:
> The first commit in this series is a fix for qcom_parse_memory, which is
> currently broken on master (since fc37a73e6679). It's an alternative to
> the patch Caleb proposed a couple of days ago
> (20250117102734.3725009-2-caleb.connolly@linaro.org). This approach
> results in a smaller diff, and also makes it possible to do the thing
> introduced in the second commit.
> 
> [...]

Applied, thanks!

[1/2] mach-snapdragon: pass fdt to qcom_parse_memory
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/782641f872a4
[2/2] mach-snapdragon: support parsing memory info from external FDT
      (no commit info)

Best regards,
-- 
// Caleb (they/them)


