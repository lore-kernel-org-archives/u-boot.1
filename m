Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE983CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 19:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB0783429;
	Thu, 11 Sep 2025 21:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VTM/8FfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA4B833EB; Thu, 11 Sep 2025 21:25:46 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CEE833ED
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-40e925deaa1so8987295ab.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757618743; x=1758223543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=emkqod399YFZkorg/0vXBXSKnULXX8Bg7Z7Nhx+Q6bQ=;
 b=VTM/8FfZyAYMQsEIpykEXedrhvcb+z/moTNe8q6pcv5nKT9zapsyHdhBYbkRtlOs5N
 RjvrFZfqgmFe2pIpNMtKG2MslimY8jouBKOJVjyRIacbBOFVchvc03NuRtkPiGL/NozT
 5HnEvLadmZ9dE59qun9p1tnkEWk86HU/JRwOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618743; x=1758223543;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emkqod399YFZkorg/0vXBXSKnULXX8Bg7Z7Nhx+Q6bQ=;
 b=af/xQU5viagBlytBGh1BuIN+irf3J83LGq/xk6l2qX4F7lkK2RT9+94XWpc0X+rlfB
 RIRHUOkIICP288t+Re2DV0D8nl+fHgQfKVpUB0VcFrBmgJP6EQIgFODrLqPqDQWwXCOO
 V20qIuM5nGFG1sahPGSlF32yyKnds+8CRkCx7DP9SvmaUCH6NHrQIGwoNTX580MkulPw
 JxDMJaEsxX+fMpOmnQu2qZMBzIzLJsTgOVdSwmNi6H2d6iVnHuG+LHQOJAc449898Byz
 k4dP7ziRarX/y59IqqfCBLZftuBo9Od4IpqVky08B0oHjblxfi+H7GxDkDxVZh00KbIJ
 FOzQ==
X-Gm-Message-State: AOJu0YzlRFE7ux3Pi4rhztyl2xW0Yab4zOiOJ1DN5m1mbDn10HhOmib4
 fdUpCAMsl9GhIX8t79aER1Ek6EJbI9ELRuzis4Sz31OnqVU5EnS4RX+heFuyA3dGIozzAUuQnYH
 fbntNDhY=
X-Gm-Gg: ASbGncvRKfsL/W6CZ4Urg2kzMV+bMKb6m+w04CI+ee1boXAkjtUjjhV7hllB/30PiDk
 VfybKP5wCOg7HoV5JiuKwGjB+179zisQUflf9ZW0mdvBmS6OFLDVAcwCpFh4qnm3kcD/UAhA0IT
 3Ov9KD51XXWiSUqg/UE4m8yWt3FUKGnkOrc+oeWf/+MaCoa6Yvr6nDHLEzzFrLhBpQlDkOuNEQJ
 LbQZEAyTy1wcd4GdhTwRg5s/hOO02F+R0lZgTCDqeQ3Rd1CIkD5iMaujI3Hw5adNI7zH/MMue6s
 jNk2+mMqxDPhG4qeNILSVURdtQbuW1Ege2hfXv+vA0JqSQlibV8e0Qoch1wbuobAit3nkuMv2+k
 VFDo78bFkIPdzYeAmWt602kPLBIBuFJzHL3PURgmpfPIqpxebFy+HGFm+CyFOuua7Eg==
X-Google-Smtp-Source: AGHT+IE8r2B89pVu9w/CcZMdrEuRSjU1OMkz0Qbljy3IhrLaKubF7jt30wACa5Jnks/bnS64qQYVSA==
X-Received: by 2002:a05:6e02:2588:b0:41e:dc1e:6157 with SMTP id
 e9e14a558f8ab-420a568cbe9mr9543945ab.31.1757618743233; 
 Thu, 11 Sep 2025 12:25:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f2f391a3sm854305173.25.2025.09.11.12.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 12:25:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
In-Reply-To: <20250901143945.82095-1-bhimeswararao.matsa@gmail.com>
References: <20250901143945.82095-1-bhimeswararao.matsa@gmail.com>
Subject: Re: [PATCH] board: ti: fdt_ops: make ti_set_fdt_env()
 const-correct
Message-Id: <175761874244.3939245.10667982312393468763.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 13:25:42 -0600
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

On Mon, 01 Sep 2025 20:09:45 +0530, Bhimeswararao Matsa wrote:

> Make the fdt_map parameter a pointer to const, since the function only
> reads the mapping table. This improves API correctness and allows maps
> to live in read-only data.
> 
> No functional change intended
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: fdt_ops: make ti_set_fdt_env() const-correct
      commit: 4d1caf58d22f8be26ded411d5774eaa6eaa3714f
-- 
Tom


