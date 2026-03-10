Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E8EFD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1EA84118;
	Tue, 10 Mar 2026 17:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ggmpaJZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2AA84127; Tue, 10 Mar 2026 17:14:32 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C0384101
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-466f1c3c627so2133381b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773159268; x=1773764068;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCgjf5yIMfX4naiKWkFL3nNH4O0heiK8BTbdM8TyD24=;
 b=ggmpaJZ9griM/hFV340l+PQAeQCpTfTPX6Hbzx07/qfyh316qLdJ4YgzaU7C4j0uuU
 QRqS3O6CHkX1EnKjozr9W30oN2kkPzw/Aj7h+nG7YWeLzM9HQXGphI4iX4cG9Hcf73HP
 nTtZFB3O+nwtAR6SskqJOQLnRKGLVjgfUWOQO1EzmKNVVnDW5t6apFIYSMq8Dm2Ud1mj
 VVcv7T29/nZPL+5bqCx8ZwFgydn4xh8QA7mfGrQ/Z0qCOO6hGi1tmoROT+mnPMupJ2t7
 9X2BAiAmLmOA1QHr2PwHHrQg+PFghk4pNKGXnLY0k0snlSRFAt8TtqLptZ5/8FXONGMN
 /0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159268; x=1773764068;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCgjf5yIMfX4naiKWkFL3nNH4O0heiK8BTbdM8TyD24=;
 b=vyhEcY7XNAUlm2Y1Ajq/+4cMGo02GtKBrQn+KxvCSAIOT0jhpgaXRYrdStD1gz1qWj
 gW/evrnxW80lL6BZC005gemhZrsyXv4PkvUzMVRYQLhIaQxr/Jt4lyBySasvYj2lK4Kv
 9raWoQFoCg7zv86HXsHhBY+3CFWVtoF6Ph+Wisz1meD61Og3SdxgbopW5mMa3yKXpFlL
 QDm+6bMJIvpYU5Rn0nCfnCi8L/Wr118vAbgkuS+vAQR3IJ/pQy1LRI/8VfaMCJUyknAf
 NhA6lByXyhm9NUSqptS5GZmeQqXKT6NoPkCWWqjkXgASt6Tu8md+NIbjqIbd1Ve+GEXd
 V6aQ==
X-Gm-Message-State: AOJu0Yz436Tlmk9cMcYOq0deiTk9k+QDYakd6uOSCmyeCZ/4MnYK4ZC7
 dow/2Ubcu9e/G9KvsEAksM5ieDe464HuuY+lWRKuLpC8dh/dODuHyQZmCjFnNVzEOmc=
X-Gm-Gg: ATEYQzxWv7B5Zy9WkyJpe86N3YHCH4wa6lh4KP99oxbXjsM7v6ustR0h5BIC/Lw6s4v
 SzBkC4XC0XSPStZXXvfFlpZBCf8HzTfJqudgOR13k+NFc3jZ645LX/zDzH+xoFqI9iTU4s+oAE3
 8L2ZVccdFWIoI5JHwtaiv4PSoimwkG7qGYTT2MUMl3jBjfgjwOgFWakf1RkRZ8Z6h/GeVIqdzej
 Fr5SosYK6QU+gqYKnLoyMRnkgpf7NYm+dDI1pfR3YlkEVhvBNeYqdlaDbl+PT5LrlUJFVQt4b01
 y2B2wwnwHrDg/76ihXjqZiYykkqnG3mgJnIATnRRrzciGFyPmrYaVNfPqntZHScahH6DtJTXLhw
 eU8j9Tid0YIR93QE8buYcn4+KMTsamE1C3AEE3noSEmFh+KttvDGPlbTGeCz51zvKUpSqyCudwd
 EYkCVC8PwQat/R6e8ufv+YHuDiM0A+8/4unr26ZEw=
X-Received: by 2002:a05:6808:4fdf:b0:467:17f3:68bb with SMTP id
 5614622812f47-46717f395fdmr2929350b6e.59.1773159267877; 
 Tue, 10 Mar 2026 09:14:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfb14177sm7769967b6e.19.2026.03.10.09.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
References: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
Subject: Re: [PATCH v2 0/2] Add MediaTek MT8395_EVK board
Message-Id: <177315921511.375938.18388259732497713315.b4-ty@baylibre.com>
Date: Tue, 10 Mar 2026 11:13:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=518; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0Jsn/cePnLyogiByzakbbMFWPcmEgOTl+kVZMYlkfl4=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDI3OIdJfJE7sTCTmVvdLSCTMbtZqfu9EfdH9XV3ubQEA
 zoXaCZ2MnqxMDByMZiIKbK8kbg5L4mv+dqcGxkzYAaxMoFMEZNJyUlNzshLLXJISqzMyUwqStVL
 zs9l4OIUgCmMncf+v3qxzO3GcwLRt9uXFDpfarLW6s94xLhkbsxTV9/TC1dvP/XBcdfX3teHst4
 XndJjD47MVXh3+kWvc9rhCTre01+2WL1R3mLU5NVo4C7FwHjyz4e/jZuO35d/s7vit3LtpN2Sni
 YSMze13BOK3i0udFUv+/h94y9eXvylC9ZvDv2oXNJ+KqF1W5OB2ayQVrFlty+5V7aF+1lpFURrZ
 HUb93lJ/NukHiu+STCo2rxKyS/gn30Z6xu2uTs78x2+i2gKHfG9bXyyPPmQYlj4rgUpDJ3qURdu
 fXi20zTMsZvJXKv6tOyJ1xaNnxR+r9Nr26M3danpn3CLoEdWQXxPT63cpbv/lszy5sAtzsfr3VQ B
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 19 Feb 2026 11:03:36 +0100, Julien Stephan wrote:
> Add MediaTek MT8395_EVK board
> 
> Hello,
> 
> This series add basic support for MT8395_EVK board. It is based on
> MT8195 SoC.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/2] arm: mediatek: MT8195 fix mem_map
      commit: 40a4889220acb5f26ca2704c6f66f149234ee3b4
[2/2] board: mediatek: add MT8395 EVK board support
      commit: b2a1db57ebed72f93b614acfd41b3cf56a504ee5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

