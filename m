Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D3C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 10:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864F2889D5;
	Tue,  6 Aug 2024 12:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NRWc8s8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECADB889D5; Tue,  6 Aug 2024 12:00:07 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30D688A08
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 12:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so338232f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722938396; x=1723543196;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kzWsa8dQ44f7go4bybIeWmNoXPFrl+/Nfre9RKxe5g=;
 b=NRWc8s8Sz0SOlxJMRT2zGELnC7/HEadfHv+T+USsDxrFQexZLZmGmIJ1NE9clkMuA8
 WPUOl8y9yQ4b5UZlvHp2IpcUIb4ArHup1XFJsd7fm6w4aQKFzDYTraUkS350dvBZrlbl
 8BbT2oVfDozhM8plKdDCaE0q260AiEmf2wqqB/rACbG7mS9Jlz4j84u/wlv0qlydXSGd
 QeBbBTlcZEM4fqrxQm0b7R3VCKyExlVEKQ9r08qccF62481xkSss5alvtOz9Dai0diQE
 PWizM0qlxnR9LBon35x/fGeA3npX2qZNtqAe4g1eB6O3UbwGKtj+Qp9vdq6bkpQ8ftKh
 G7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722938396; x=1723543196;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kzWsa8dQ44f7go4bybIeWmNoXPFrl+/Nfre9RKxe5g=;
 b=I1bD694fOn227o8M7MSW4lDSCBqVwWgjsChE7Xc6AMyayr06VL3Xh2LspUchgZl/7M
 CpaYzMKoyqukTrr15U62VmKFiPynsnx1sPcYTw3MQ4zI1uzpeDWoGAa5rxWhX7VmOQ1U
 a0sUlT2jvyCRh5F408o37dIrZum1RXxgZR4pJMKFJ/8+FZ6Ofs2SDx/XA7Xw3YhVYNWm
 BNE083B4klAerS5v5lnLqX4vdWuAMCZ3VIvBmkdY4zRoDw5tQ2Tg4SKSmkg9jMw+q26h
 gwjkg+c8Vn5DW1u19aCrx9mt8+XzY78QePMZKkf4F0A3iQCl68p31KoxOFW8/k0KhEvf
 pjxg==
X-Gm-Message-State: AOJu0YwckWzD+4CHCQjs5boHQ2KIypZjKToAKX+4QHKpo2JQbPfuAJbi
 J5S7Gi1MyjVe+Z8X1AYgVQnzRtg9hId4dYSybdjkiTwWE+SofQm1NkF9FVf9Vsw=
X-Google-Smtp-Source: AGHT+IFzw1yMun8ZJU3o6JfH+4ZbOKeG3AB5JP9RYW7sjrqlCe6jYcwpW/FWkg/DfLtgLWr4fc7RwQ==
X-Received: by 2002:a05:6000:23c2:b0:36b:ea2d:fd5a with SMTP id
 ffacd0b85a97d-36bea2dfe1bmr626769f8f.22.1722938395013; 
 Tue, 06 Aug 2024 02:59:55 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01eff1sm12461973f8f.44.2024.08.06.02.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 02:59:54 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com>
References: <20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com>
Subject: Re: [PATCH] cmd: bcb: Fix segfault on invalid block device
Message-Id: <172293839402.29644.2888815575844952854.b4-ty@baylibre.com>
Date: Tue, 06 Aug 2024 11:59:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Wed, 24 Jul 2024 11:51:06 +0200, Mattijs Korpershoek wrote:
> When blk_get_dev() fails, block NULL and gets de-referenced in
> the error path by a printf(), resulting in a crash.
> 
> This can be reproduced on sandbox with:
> 
> $ ./u-boot --command "bcb load mmc 0 0"
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] cmd: bcb: Fix segfault on invalid block device
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d7b5ddf0def85a7c536c45a3a0a1d3a50a150646

--
Mattijs
