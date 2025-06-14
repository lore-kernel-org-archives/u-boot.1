Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63712C71135
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 17:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AB880F0E;
	Sat, 14 Jun 2025 19:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ih6kBhGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CA782C4D; Sat, 14 Jun 2025 19:44:22 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BCE808AF
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 19:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2db2149ffceso2420568fac.1
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749923058; x=1750527858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tPrLSK8zu0BQN76RuJZM1ZlHsXK7l9m9y69wRcOuV8Y=;
 b=Ih6kBhGwWdDoi2BNuyDhSAq65Ym57MlgyXYsG9J156PcifSq6WCKTIud8NM5R9iWzj
 AkzxvKElKSkDIWkSySQT+XcOy3Td1JgnolFcLMoEZ18acDNth03h05F8f5rDC+MlCTrt
 LhhBhqHYVMdFLWIrbtbPaefjgmcyNylDL4X3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749923058; x=1750527858;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPrLSK8zu0BQN76RuJZM1ZlHsXK7l9m9y69wRcOuV8Y=;
 b=ggKb1RsNWfmFcuXDqh+mQxt1cX/bm52kKDdq/TqauBGovwTaUJerruOWIPwXmUkH63
 onXpOF3SDUpWDSRe2w3Pae+gDG3fcSFo8uN7oA68IYJbxGuxf6FLsYvpqjgv0RZSziIW
 uczl1D6390DwFpRslkBocnSc0N94LEFL5ueeuEIgurBkr4iajO688l0Lp9hS8v/zwce5
 yFByuEe2gqblRMWhpGDsnkenCna6ygITJr3uClPZ8+kuSKKFZANrkOmssVoqCxQg/TS0
 QBBaRq2BjiOVYRr5y4ZHGiRG0YRJ5Ov6MY3jVIHbmU6r+S5grSOJl6LLAt3HZp9386I2
 bf5g==
X-Gm-Message-State: AOJu0YxluG9VHpnCtgoNjt8/6Vp81aflhpxn4pczpALfXBzKwii8+rYv
 bUfyZoyShQQ7+5UIJOXyBjJ58qNjWLzY0OSv5i+uGRDZGoHQhp1p5WpG4kt6V8LbfKphbXr6QoC
 3VrllY1Yjfw==
X-Gm-Gg: ASbGncsM1VT+HyHSkn7RfeMVsom++dOc9+nfQXQ2TyFgZB+BDuGVjblXzKH8DogpbY9
 kThrwRuNKOtUeN38wL82PVDyeWXKABcofQev7X5lz78EV3k3ZzzMeLzwXb/6ab3LnQQKLkALmtU
 i7VdIwY2nmRzCGqe6s2P1Gp8MvX1Ok+zAJWE5fxOE3pF2WyMe5XsrkC0FIuFCnZSZHr1mPeoTRc
 KjAdsae0+YcsyO+C7gO0dunWZNBbjmSN0rMMHu5Ujx72O/6AOAaUMNKHgdRFwb35eHP6+0UdxGg
 KogGMcTlZGCChMoCNFEexv5vNZGuwLd3Hh6NTuQqe+KN/1l281ui1El3lsv3wsqEzYury8PDXu0
 1wv48HJy2UmoSPozvVOxZ9A==
X-Google-Smtp-Source: AGHT+IFxQR+A03m3IkH0yV1dILKFem+3FXjdfkikTHaaorKdYkB0jhr61vzAHfFGiXNk9qEUtritdw==
X-Received: by 2002:a05:6870:8a13:b0:2e9:8ed9:16fc with SMTP id
 586e51a60fabf-2eaf0603887mr2146028fac.11.1749923058372; 
 Sat, 14 Jun 2025 10:44:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8ef0f93sm1145016fac.45.2025.06.14.10.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 10:44:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, E Shattow <e@freeshell.de>
In-Reply-To: <20250606224558.1117422-1-e@freeshell.de>
References: <20250606224558.1117422-1-e@freeshell.de>
Subject: Re: [PATCH v1 0/7] Hex value prefix case cleanup
Message-Id: <174992305681.984784.5989026265201728905.b4-ty@konsulko.com>
Date: Sat, 14 Jun 2025 11:44:16 -0600
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

On Fri, 06 Jun 2025 15:44:55 -0700, E Shattow wrote:

> Make consistent use of lowercase hexadecimal prefix '0x' throughout U-Boot.
> 
> There are a few remaining uses of uppercase 'X' to denote hexadecimal prefix
> or placeholder in documentation and error messages.
> 
> External devicetree-rebasing dts/upstream and the generated code of
> xilinx/zynq are ignored for the series.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] configs: use lowercase hex prefix style
      commit: 9f208a3e709f8201f0d7dd6fe23c789430ba6c1f
[2/7] board: use lowercase hex prefix style
      commit: ba7634c6b6f1924d87af001dfdefdbced34442e9
[3/7] drivers: use lowercase hex prefix style
      commit: 449a5566522f07b4c8d58f3a6bdc36a74400e672
[4/7] tools: use lowercase hex prefix style
      commit: c5824a1b3d9776632e5c57c2f212819e2f2c8532
[5/7] lib: use lowercase hex prefix style
      commit: d1aacc9c787e67314dd24e8f104a67d773e33c98
[6/7] arch: use lowercase hex prefix style
      commit: 58bcf9ab19290442019bfa80a66a535252f341fd
[7/7] include: use lowercase hex prefix style
      commit: 0230ad1c30a405c807dad5f78c95c57704234ffd
-- 
Tom


