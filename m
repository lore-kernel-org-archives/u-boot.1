Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7150AC982DF
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E39839AC;
	Fri, 16 Jan 2026 18:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mr66rcb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B8C8399B; Fri, 16 Jan 2026 18:33:03 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0B08389A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-66109b09b53so824260eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584780; x=1769189580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+PwtMTnOicppussyni6o98rQLi03keyUi3tKBQ4rUg=;
 b=Mr66rcb0ge03jvVaEP8lUvGhbdcezlJzv6iPq71iLYKS1hNhv9coRj4G1uVZEGViEE
 VKBR6VY9lDYeQX5HBbDY38cUAQXSiXL9yB5lw2n1zAMYGNoh8GC5ko7/17uRkgCtcBFk
 C5WCV3+aWSA5eAXJ8X86nnwVg3tJfqWGZf+Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584780; x=1769189580;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y+PwtMTnOicppussyni6o98rQLi03keyUi3tKBQ4rUg=;
 b=BPvC8pZ09Qh1OAjca5bLKBYShOO8XSBvvWoLOjJ8snS9kAqp/mOTipLi87BcSFrrrk
 0cVAQAufZwLXTrLcccBhMUEdOFd+OYdEAhcU4HnyJXrGW2+0ynhBq+Pdilm2VZhWk/r4
 fRZpvdrYyzIdKRzHDCLSvL/ThMPQO1QRHg+6K+oK/J4ObcAgv2eqL4Tkh04+d196JmAX
 W0xO0EsRsWBUwmlh+EVXc5aj+ZHxP8ouOXSuBasR1hESEudXDk7tqJTr0KQ/0WVpKM1q
 ijFCoqXaefhe3cDiqgW0nn7JfYVrSYk5BY14XdGuiwBRVbheaeRMbdqBahyLmjl/JP19
 B6SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUgwc//yphecX7eo92JhVC1qlDULVZxUP1k7HtGOdnYNy4Db3M9o5qcUdQCX0Uly+guY2xoe0=@lists.denx.de
X-Gm-Message-State: AOJu0YxX9QgS69ADtqepkFXdlVHQPihN9swFV2NGo/eiXiins/q8hboi
 7FmI5XgFBR39Z3qDP9sMBdyUUOhZ26eyvX85KMZv2Eo9MuBl8o3DVAKbRT9EhdCnkuY=
X-Gm-Gg: AY/fxX5fNMTAVSeLCvuuRsPlIzkbrFvnzgsw/4TomccX2gvcznQp63VwYktX91AzZjJ
 Jm3/W9BRggL9lWMPjMafbSXlKos7MJePijAl9kxnyLfcZzW41tkBG2gqdV+3Wr/fRzJq/50eNhp
 r9lKmjiWZLoLbQr0/cZAC/eEGu71QjFk+QwqOiGWMePzlsoSIvrm7xrKHVE47h4+qedfcL+vonk
 jMdQm1HIRVokBGVRsphLA9e9nRxgvnN3PevPDrbdLXJLUnTetL77RozXX2h49eUHuOgb8AgIQa/
 a97W5g8IfZ/C7VjryzmbUyCiDmPPCLIlfS+nWNLPCr6XObkBoQZJDztTd8L0pw7EIEHP0wdU79K
 mIS8inycxd1V9mg37bBfgVouQsfvDWhM+/IXyIuruLyvN94sU4A2kB62RREJuW9Obd8E/XPcAM3
 C9VZW/reNGza3G2JlylZhPuo9YRXJmcLOheerKTabikEFAEcH9G9zzsztwczv2ZIM+423GNoBsQ
 FLt8++8fcRj+rD1H/HArGHXsj9oaxezFotmkA==
X-Received: by 2002:a05:6820:160a:b0:65f:6b5b:b1ac with SMTP id
 006d021491bc7-6611796a737mr1463397eaf.18.1768584779752; 
 Fri, 16 Jan 2026 09:32:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:32:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Jerome Forissier <jerome@forissier.org>, 
 Jerome Forissier <jerome@forissier.org>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-spl_net-deps-v2-1-e412128520f2@cherry.de>
References: <20260108-spl_net-deps-v2-1-e412128520f2@cherry.de>
Subject: Re: [PATCH v2] spl: fix incorrect dependency for SPL_NET
Message-Id: <176858477863.4075554.4815770186199519667.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 08 Jan 2026 13:28:36 +0100, Quentin Schulz wrote:

> When SPL_NET is included, scripts/Makefile.xpl includes net/. However,
> in this directory, the Makefile only compiles things if CONFIG_NET or
> CONFIG_NET_LWIP is defined (it doesn't use $(PHASE_)). Therefore, at
> least one networking stack needs to be enabled for SPL_NET=y to do
> anything meaningful.
> 
> In certain cases (e.g. am62px_evm_r5_ethboot_defconfig + NO_NET=y via
> menuconfig), it is possible to fail the build with undefined references
> (since include/net-common.h does check with CONFIG_IS_ENABLED(NET) which
> would be true for SPL_NET, but the implementation wouldn't be compiled).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spl: fix incorrect dependency for SPL_NET
      commit: cb1d775d253c84a0eee0db94d8bf4145d9fd7bd3
-- 
Tom


