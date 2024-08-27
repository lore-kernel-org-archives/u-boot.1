Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4ECC54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A91787F5C;
	Tue, 27 Aug 2024 16:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eqSjIKS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7FE884C3; Tue, 27 Aug 2024 16:51:48 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164D487FA7
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf775d1bdfso28462816d6.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724770305; x=1725375105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hrUNJFzeIm2svtxWCtgSwO+ll+nksurX5knMnwn7IM=;
 b=eqSjIKS55X/fpxjAxC/sRlY9Zkl+PULCmcHF8rlRKNr1eDc1V/XLxsMFqG3z0szwGg
 jQAA8g/FNnyFJSSoFLndIlxYLvLGEKsk+sRZ77UlU9HeZkoPS0avlC1ri3KDQ3q82kn0
 ZjKUEmld+djF9qSIMlKgVC0Kt93mY1dhNwF6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724770305; x=1725375105;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hrUNJFzeIm2svtxWCtgSwO+ll+nksurX5knMnwn7IM=;
 b=ADf5ASwU1pHuodI5i0K+4Kjqrug1wHAzQaJiK3j1fmBHHSlxiG3xwS3Wg9L/vA+7QX
 BsQ+WoifNjRmlxMDeMrUzvEbGaSwHkiiCRfGgJlPj6dQLhijDw8BVUQD6k8AgDwLFyfH
 UBLOOAvavUfpHNVGuptn3/6Lc2NSruUlrrhCfOYSk0yA5XcU76Sv/N7QK3+wkG6FujXr
 HVoJ35MSxu8KLHY9Zgq0w/iJ6OnfQpHW8tbm0779kUFGhj3aT/o7rhQr306pbnfOIJGH
 Rp6I2POnxfSZSlAc7vjLhTb/vu8QWW9lXJ4ta5bE4xn9WgDInxv2/dV5k6BTuzjwdxN4
 fsfQ==
X-Gm-Message-State: AOJu0YxeT9s715p2/s8yNo93Z8j4nZXezkyvIvUSL+Qe4/S4+gTnSC1A
 hisbyIBMqA36NdZ4SiXr0u2bqSzurbyf7V7Rfi/xVv9pkvHR14ASnblqv/SawrY=
X-Google-Smtp-Source: AGHT+IF6Rti0jrGQ9gaAhigLdtU1ZstgCN7gk5++/tmkYlnxq4ZDtJ9nandQ8LglU13qs2FSkoW27w==
X-Received: by 2002:a05:6214:310b:b0:6bb:b23f:8d06 with SMTP id
 6a1803df08f44-6c16deb47efmr157091226d6.46.1724770304914; 
 Tue, 27 Aug 2024 07:51:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162db07cfsm56926916d6.93.2024.08.27.07.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:51:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/19] Tidy up console recording in tests
Message-Id: <172477030319.2887898.5727133738754752506.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 08:51:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 22 Aug 2024 07:57:45 -0600, Simon Glass wrote:

> This series started as a small fix for checking for an empty line,
> but in the process several other problems were found and fixed:
> 
> - fix tests which use console recording but don't set the flag
> - drop unnecessary resetting of the console in tests
> - drop unnecessary blank line before MMC output
> - update the docs a little
> - fix buildman test failure on newer Pythons
> - a few other minor things
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


