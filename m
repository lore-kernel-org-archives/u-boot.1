Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8627C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4111982BCD;
	Tue, 24 Jun 2025 15:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sm/Rm3LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F4B82C2F; Tue, 24 Jun 2025 15:55:22 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F8482B18
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ea35edc691so111014fac.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750773319; x=1751378119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLGuVBDqgCvU0ASb/G6o/LlVzCbWQmbIQd6z+rUuZMg=;
 b=sm/Rm3LL0B1KBVf28TmhYv3ZVWyVRl71xMu0NQZEc98Xk+fMM9Z1CkgmHzTjkTRwMZ
 5VF1snze9f1ALNJxcocGhJpEMW7EpsD2QGU5gADqj7VzElgoOg3vWwHbBEDp9lw/odUY
 QKzU1HYG43IX3rWcma0iJGVrnqaSNQDd9pExs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773319; x=1751378119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLGuVBDqgCvU0ASb/G6o/LlVzCbWQmbIQd6z+rUuZMg=;
 b=msZnnHhpJ5P9Tz2AIMq6MX8ZaErg2XCf4pnpe4rTXruGA6imdqwD2NCj5dVYco7Ezp
 1gZegoNmJyGOvb1uoMEjg6CeYb+rW1qeirTYmmWbNJ2wjqThgp5nVRNoAjbE4Y1LB9bg
 ur1C8k5qhJEepTEAz5XH//4PGpesWLR+9+IzsWzsYWJum0oUz1gW3zsdQgbD2qSnofiu
 wWe5cqQK5610mx2AT8LJ9juTK7UhmmV1mhRodX4NWg8Sy0NuR01C+hqF4ArW2KGoQHRG
 LhRP5mfiBrRU9IlkshLMjm9j5xySdaXBLET0Hxv+6ROkTpFCfJg7Rd0RO5h+hZtDqK1o
 3CAA==
X-Gm-Message-State: AOJu0Yy4prUVBK3bP30Rz65sfSLT3f/qhU9T3clfhhVn92REt2juFGp5
 Ez+FJGoirE5yb5kZ4dyaLdlzqalW1f3V8XnbT76VW3Yz3/lYP4dmOa+O8hcRL7OI/e8=
X-Gm-Gg: ASbGncvj/vcYU2y7eaVHv386wVqTJ1OIlUooOk4wKDLUI6CcReZX99/m8/Ih5PkXmQy
 Z57M6/L0m8uK0zxWOjcLrmD+dSsoyEtqw9DglF4BTcqjez9aujHxaobXom9jGq5Qbiq4xE9vKVh
 NqE6l23nXVMdMDbF8KPie7owgnH6EGaTo6its43VJHrAQes5MmEqO4ABt2D5Qwn7r9Cr4hyTC4G
 yG69RN+txqkANigmnD2HlGpaaD31i8vj+tSQ1A3RKPS6h7AoWEhVGVc7VK5D6aqFl93NwyivIy/
 3XRqMNUtFEDkaEvf+CWZIJ7u2N9bwKt9Qb7AE0d8u+d9AQtZbKu+U7lZ3aj7zMc/K+88vJRgfoD
 qOAHDbhqwOxXwYbC0gvtsJw==
X-Google-Smtp-Source: AGHT+IFm2TBUHrE++DG4ez4U9N5Uej6zRlkXaBaeMfjB3oa3hxKtVcJf3q7cKnuLhrfyH4+lcjGRCA==
X-Received: by 2002:a05:6870:6eca:b0:2d9:45b7:8ffc with SMTP id
 586e51a60fabf-2eeda4e1f37mr10421092fac.3.1750773319241; 
 Tue, 24 Jun 2025 06:55:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee664c12edsm2109247fac.3.2025.06.24.06.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 06:55:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: festevam@denx.de, peng.fan@nxp.com, hs@denx.de, alice.guo@nxp.com, 
 sbabic@nabladev.com, uboot-imx@nxp.com, eballetb@redhat.com, 
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
References: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
Subject: Re: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip
 of build_container()
Message-Id: <175077331805.1181633.10389541695876373785.b4-ty@konsulko.com>
Date: Tue, 24 Jun 2025 07:55:18 -0600
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

On Tue, 24 Jun 2025 18:09:22 +0800, Alice Guo (OSS) wrote:

> The value passed to dcd_skip of build_container() should be obtained by
> parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
> data needs to be skipped, in which case dcd_skip should be true.
> 
> Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: imx8image: Fix the value passed to dcd_skip of build_container()
      commit: f3ee5872bf67e8e15b3a3f131b8eb64251508c08
-- 
Tom


