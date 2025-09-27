Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C25CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 14:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8260E8329F;
	Sat, 27 Sep 2025 16:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WwyQqzbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D00383192; Sat, 27 Sep 2025 16:04:58 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89C4830CA
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 16:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74542b1b2bcso2789833a34.3
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758981894; x=1759586694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5OlmdmGDVBaVSD3YBilYr1YBcD/7SksOzzXAN3RSHg=;
 b=WwyQqzblQ/yp2WQxdhblqz8hTuJO8pPhcLkJ8zpHev6liLaTk9LTTGEbs6WAuWmPkb
 DvEJOqNijijob4iSG9KfygOMRtZlQhPAEpo2AtpzR5UAV9Kydo62fkPEFzYzsTxfcp1o
 woVGumkaP7UmpYTinrPBriD3Bv5NZqbxzzC3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758981894; x=1759586694;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5OlmdmGDVBaVSD3YBilYr1YBcD/7SksOzzXAN3RSHg=;
 b=nIcjij952IFLDhAXJxU6BVcGazoI15g3S/bx4dEezc5B6NLFbFItSacaHLZw7o6H2U
 teEyYsSzuYiglsChquXgtmf8kOGonUmD+joC8sLAhCpB70b/9lL3ZLKiLH/1J+na4E8/
 +LOTadHv2cCymPImJQK3OGvhc6t8w/eGWw3ymTXLeOb4hynqYh30m3KVbQvPfkOsYK5b
 k4YFRypH+7OU+LtQaSZUmrfWST66U3okWKAaGypWZBg8sMsMdNr7adizYooETVEwbd3y
 EKN9Neabmr8wl3Pa5DJkExP1hnvRszYJyEauz5Da03ZkuN/T0wN1NC+Wap9Jiv4rCiMj
 Ks9Q==
X-Gm-Message-State: AOJu0Yyso42cwsJZ213cd2LKcTX9ors97uQi6CADHwv7Bg+Y2FPmPrcF
 C60ONUL4C6uFNDqehryjcIvHi22x5W5X2NLTbEwqB0cqu+G3LlhlwMd5qsUQC4IUWDQ=
X-Gm-Gg: ASbGncvPAsLrIYisACiiNaz+RnkUcKxaN+fLM2E++q7u9/GM8tc8ClB1NZrMEt2zxkX
 uYZJCXxp0b666DqgXTPCGtFsToIIZXYy8ZanAoqPGFfvkqddrSVSl1yYSaEkEXM0cZUaRslCvMf
 MXRuLdkNHuFeiotVS/CcwUkSqaY7Vx/uYLblobwVFdr+j46erA1cuAGLkL0BV4/degRCP5ULvZl
 Q4T8UkulDQbTgyQuwOBR25Tev5mOpkfkHimblvdYFTvY02ISnPF9Ds9LtHm6vSR+Wf5Kcup8Xbr
 yYErS0pKjbtwBpFuDK46UhPLmA5chIad1CYtCMZrIQiXaLIOrgLg2YQk7AZCyEA2tcMLUP2CM4x
 GxViweQo9XQV5Xh8huHl1KZajbUrFoe2qUi1eanhmJNmycium/lExSLY=
X-Google-Smtp-Source: AGHT+IFH2aHPwpeLqIsmq3Y/A8DoTZ082oeOMITNAKEya+5PLL8rJTDalmTFs6UQG73+Sr3iYBaVmA==
X-Received: by 2002:a05:6830:378e:b0:7a9:f37b:986c with SMTP id
 46e09a7af769-7a9f37b9b14mr3273310a34.8.1758981894607; 
 Sat, 27 Sep 2025 07:04:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm20077a34.26.2025.09.27.07.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 07:04:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Chris Paterson <chris.paterson2@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250918164936.25592-1-marek.vasut+renesas@mailbox.org>
References: <20250918164936.25592-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm64: Add MIDR entry for Cortex-A720
Message-Id: <175898189300.3905802.1751341647924318308.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 08:04:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 18 Sep 2025 18:49:19 +0200, Marek Vasut wrote:

> Add MIDR entry for Cortex-A720 core.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm64: Add MIDR entry for Cortex-A720
      commit: 7c0f1c46f885db62c86d035814c1bb282af43c8c
-- 
Tom


