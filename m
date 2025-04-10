Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0F7C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C6883DBD;
	Thu, 10 Apr 2025 19:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A1QTveWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870A3839D9; Thu, 10 Apr 2025 19:33:59 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB5583D9C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fa0eb29cebso1240315b6e.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306436; x=1744911236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D//jz/JviEQNLBPtwa+U+WNYffwI65d/r4B+NOdzcss=;
 b=A1QTveWWD83T6iIS5hPhbA6+0PwBJpDB5jkacr/LBhE8r14DtRCJHgqVx0FsQdBAWE
 sExZcBj/8WN/aU0fWJ9myz9czP/W0m7BOMtC76mjVz15qjtvgH/0GfLo00FtKSUOF75U
 fc2UGIUrWS9WN9lHJVim0p3TbmVwBKKjUjFfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306436; x=1744911236;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D//jz/JviEQNLBPtwa+U+WNYffwI65d/r4B+NOdzcss=;
 b=H/OI/+BnaLfkFAUPsGnzI8s4xZ2K9xJEzvGktjAX/dtiXgQwGEi4swyQuHqKP5GN6w
 YYPqiHztBNoQRavih3lEVPHk2DV3RSOQ27muyNTuRnkrB6N38TArFkwFGIS1AonXjJPy
 LDyrTOBNQh6eb/l7il0xO8tx+N0AGxi4bNFOPSszseML1KmbKYC0wvs9MBtmppMI/IY6
 qZ0dnr8GT0WHMHGWXj0UGbh6Pzpq3nR2F84WTjyGWre+0Avavjj2txTqckR59zJ0HeoJ
 b6bJ0yhtMrzVso45cfN0Hjb5+zwkfwKPZAL2E68vG2KUbawZ0Ffv5ksnRvQ7+JhpHuxT
 isPw==
X-Gm-Message-State: AOJu0YxcxwFJC4emEWqv/rwowadFV7hxFmAviGsywR9sedhdtGr1DDgH
 V04zuKwKFCaQFp9z4CyuXtWWMeP9l1qEjtyLZVnp0dka9KOyXRqZwf3UCVbFKaP1jd9OQNZYIsZ
 fOs4=
X-Gm-Gg: ASbGncv2mGufvadPx/UdjMsD3bRyBbLpj0OVLNKkc76TYDDfl6DN3jSFaOkStJP8B5Y
 1B8DqY771m4a3Gq6s1pEVVjDN/i0zjzSc7fB0gPFqqaXrMWqnx7uFRbPzcG3Foxi4NPSV10mHFN
 LyPJhGZgW8tFU7fmGNUN69twYrrKjjRCQy87ZzXYlvwFQBzMn+X/8r5xkGXKO9+sRcUI2uA6qVy
 cSXp2A8Nt0Sj7RlUiv4H6viZubbzx5Ay5w7i2SRoy/778nVBF10eGzpnQ6ptspI+lu/I3uegrx0
 Fc0GfmqfNAF8tzct1+APc2sYoTi8fsb3J0yfQllfC33eXrwl9XDSMH7/9Yla8/LGz/rB3R56l1l
 y
X-Google-Smtp-Source: AGHT+IGq5ZSIIiLU+Os2QfRNOzUCQhzanrokTRRrKVMYGMlvS2yeZuCctOQN7R3AAOY7XursgaB7Ww==
X-Received: by 2002:a05:6808:6a97:b0:3f8:18a3:b1cc with SMTP id
 5614622812f47-4007c1eda67mr2119713b6e.12.1744306436135; 
 Thu, 10 Apr 2025 10:33:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250410151505.2596608-1-trini@konsulko.com>
References: <20250410151505.2596608-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Move to latest container images
Message-Id: <174430643527.2959201.13310458880277377284.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:55 -0600
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

On Thu, 10 Apr 2025 09:15:05 -0600, Tom Rini wrote:

> - Bump up "Jammy" tag to jammy-20250404
> - Include most recent changes to the Dockerfile itself
> 
> 

Applied to u-boot/master, thanks!

[1/1] CI: Move to latest container images
      commit: 206ca97fac5bc638b04b712075d8bb4656d79395
-- 
Tom


