Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283F0CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B0E8312A;
	Tue, 14 Oct 2025 16:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VzvCnCH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4139834D4; Tue, 14 Oct 2025 16:20:34 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07D2809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-36e4d00ebfdso1538947fac.1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451631; x=1761056431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYyld1p0pPbVEnvcYOwvoeFddiKkriyCT+EvytppLXw=;
 b=VzvCnCH1ZZcKn9fBta3GdwnU5g21kb/syb6zq3fCzlJ4kVPKlNpp+XUCT6Dxe5a6N8
 4/m8POggrljIe5Llz4hqkZkiPk1hdtuCXuKuZTvG22OEHBtCqG4TUcJBvrX/5OTV9qiE
 MLjb3DMCTGSXPNf3KLLtN+klGQH1wAnqA/PV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451631; x=1761056431;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYyld1p0pPbVEnvcYOwvoeFddiKkriyCT+EvytppLXw=;
 b=mRYiM8R9CxfGl6Sg1NbCMRQrn5WEG8VaVI+8RU33mmj8hfbtrqzX1edTQZ9NarL7ze
 f5tUADhaeNw1ScbNjL0++ws1V0Pn76TbgvY8HszKdRbHFFTxs5vuWZqtggskKHCWjcdP
 e8Y9tc/a1uT1Nch2hHCGh4UJ12v0R/itxm2om3546AqOdtI5Hq2QnKlL7RAVbXQHOLrU
 fSuih6o0p7eN//VrU0/WiLuNQ3suwPQRZbMIc/C6iXY80LL2MY2oBXRiLsp9IE11b8Ee
 B+NEpj5tm8DtCMuYt0nerezqr+Aa1iaVRZtgVJM8+ywZ9U6lAjQUwQ4Sobup5Zj7yM8+
 7Yqw==
X-Gm-Message-State: AOJu0YwYIRUdyTLWuurP6r022KiXSHpXMfYIcULrxwjQa83beB1vQTyJ
 EMuEHhHId0WiZdrPnemUkeH+BEuksQXOGj10dxabqW4KIDwkxOBWUP7RL9qfr5J0ao4=
X-Gm-Gg: ASbGncsBppsGNlb0Hrm5aRs0Bmgem7wz0gHFc7+nhRy/qlzUaMAAXXFCTTro617SRJO
 PLD2e7Y4SiD4YAXqhamyqBFhYqch103tLxzjSoniXztILPCg6V/yQAznlI2qv4o1R2CTx+SnyLd
 hZ8wyNh0Kd2s/5AsE0eFklMCCucDAzyp59q8cAL6RK6TSlguba7csui1I5fKHwUQFyBOAUhgPd0
 3JxzrqZdgluD30/BP9ikBnVVWucTS2VZBvRbGmb2cjUDSApJPUQ2RE7X7je/c6jrk6NmU4avNWa
 DP4/J0iax26VB0Ac+fslkEmf5ytVv9VdhJ5rPo86mkjx7FoeLdOdehs/tNmfKNBepPYTvOU4xKT
 YT2VCPBB4WrnvgmO7wptgtodEXHz/f/ahWvtIA7+RJ4R15mczolFcf5WtlAk+/wRdD13EqTfKte
 ZkuS09ybmRuciCMA==
X-Google-Smtp-Source: AGHT+IEzDBu+dMBEJ31DqRLiyqZMT+PLmpCeikjynyvEDuYlbCTePdEnGHsKEnxNXPV2b+isAN8B/A==
X-Received: by 2002:a05:6870:3643:b0:342:74e6:4fac with SMTP id
 586e51a60fabf-3c0f959600cmr9813879fac.42.1760451631225; 
 Tue, 14 Oct 2025 07:20:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andreas Pretzsch <apr@cn-eng.de>
Cc: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251002162506.3908711-1-apr@cn-eng.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <20251002162506.3908711-1-apr@cn-eng.de>
Subject: Re: [PATCH v2 0/2] bootstd: rauc: fix doc and info msg to reflect
 real flow
Message-Id: <176045162981.284655.724218968160494598.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:29 -0600
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

On Thu, 02 Oct 2025 18:24:57 +0200, Andreas Pretzsch wrote:

> For the RAUC bootmethod, newly introduced in U-Boot 2025.10, both code
> and documentation contain some incorrect (maybe outdated) statements,
> so they do not reflect the real behaviour.
> This series corrects both the docs and one log_info in the code, to now
> reflect the real flow. Beside being visible in the code, all of it was
> tested on a real machine.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] bootstd: rauc: no valid slot fallback: fix info msg to reflect real flow
      commit: d6277523e54f4398dc5fe26e1d6151f400c974ca
[2/2] bootstd: rauc: extend and fix doc to reflect real flow
      commit: 1c3687782fcedbf13d114d0dcf3d151f2a210973
-- 
Tom


