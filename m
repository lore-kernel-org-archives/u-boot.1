Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA5EC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC4080E9A;
	Wed, 18 Jun 2025 16:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IzqGDshW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA92682BCD; Wed, 18 Jun 2025 16:04:08 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496B98006D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a6f3f88613so68618051cf.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750255445; x=1750860245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62V/BhmujVKnCh1Eup54V34S+R7BfIhjWGqncsywrls=;
 b=IzqGDshWDAbU0v8EXJZM0EufX6LTz7ZgsdcPBP2z3wo3OQMI+NWu+tcPTC3rS6Zn63
 N+rB52v9TvVxX1GSY3X2Wa5KrAH3JZmpg0DEiyEqRIjE0hoegbCW0iVEiMQ1SUKFS5JQ
 zxjwwgqXWbJMdVLmuh3DgF9GxkF9MkrkziGdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255445; x=1750860245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62V/BhmujVKnCh1Eup54V34S+R7BfIhjWGqncsywrls=;
 b=HevmoWhiXhIpuMUfSRtC1Mn/c9QYxN1QnkTdTKcgr4QmTJRo6K87sBGgyStW/U/nGT
 Y3QqNvVBrOTgnFyuQUAp0WKfvV+ulUry/GnSK1Kmhrx3NC8aoRmdKy9zRTILr4yr91hG
 rXBr8NsUPoEKelJdfBoZHet+inEJPCeO5CMH6xOgpSSOFwz4MaEo4iBpojAStz6165Kl
 n2xpO9iNhGCeTUtTcQaNgPrPW93GWnf5htdmgexpl5VPMHOgMOMoJTWNZd5UjHSYQfFP
 qJc4qNeURKCzoUftvunDoAt82tsWklSWnocDV43XJj5rGG0n2n707K+sX0dDouSmciE+
 IrWA==
X-Gm-Message-State: AOJu0YzTdS/bnG168NxCM7JLIAIvraPNFP7p3TbkmZ1hVY1uZKMwrupz
 ynQq+FoNmDDOyHXKm7YdKrKzO3EdhsTwt61w/hdwX3cW9Ey26Ifj9QT7/+PXasD1BCOxOfevzuU
 17kDVohg=
X-Gm-Gg: ASbGncsrxdjrWGxSQh5U+KuAJ96EunK4iWo659t2hq25E9MnH41XOeaZFw4wFBpu4ed
 TavxX2zGp4dBz1eAVXlzJtRPA6TjJGK9yuhhbOP2IvgTZpFgHSqSCS93kJs9sIObCGyt/zpOsB3
 MmDgmdWYbOdc7qcTkhYzHDuadoLSWKGR0hdTwoXTJMGiTC+qKwDhutUIr5dH3zhZ0AMNpco/cBs
 VqjqXxDANQ6jTxFfqgO+rWfar2rM3tSpBo65Qmt8QI5+MklRiCM2y4TeHZTMB/FdsXmgXcqoVJw
 naRyBpSi1wBrTAcNlgXY4RwK6oGzcLPjRcKGmHlK0lmblgndetsjgo+rJljefXAR2orEXd5mhQv
 UiMN/2gbM136UfmEl/0WfdqYs7d8EJSqx
X-Google-Smtp-Source: AGHT+IHd23PsFm+liOV6f+YupcrKZSFTw0VGgomB1RRf+3CJ7r4ecIux7IRdjiqV9tEqDL/KqdWPhw==
X-Received: by 2002:a05:6870:b02a:b0:2d4:ef88:97af with SMTP id
 586e51a60fabf-2eaf057ce1emr9634215fac.3.1750255431849; 
 Wed, 18 Jun 2025 07:03:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8910463sm2797192fac.11.2025.06.18.07.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:03:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: jerome.forissier@linaro.org, patrice.chotard@foss.st.com, 
 ilias.apalodimas@linaro.org, Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250616112749.17311-1-patrick.delaunay@foss.st.com>
References: <20250616112749.17311-1-patrick.delaunay@foss.st.com>
Subject: Re: [PATCH v4 0/3] Restore support of short name for type UUID
 parameter
Message-Id: <175025543025.7476.1231836682265621641.b4-ty@konsulko.com>
Date: Wed, 18 Jun 2025 08:03:50 -0600
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

On Mon, 16 Jun 2025 13:27:46 +0200, Patrick Delaunay wrote:

> V4 update the test print_guid, as "ESP" is a known part type UUID under
> CONFIG_EFI_PARTITION flag and no more CONFIG_EFI or CONFIG_CMD_EFIDEBUG
> or CONFIG_CMD_EFIDEBUG
> 
> test result:
> https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26699
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] lib/uuid.c: restore support of system partition type for ESP
      commit: 73d5a68fec9e68b2278d83625d6f8bbfcb33e2d5
[2/3] doc: cmd: gpt: add information on type partition
      commit: a3a5179b1c9eafee0850aa653384cb8c23a4f79f
[3/3] test/py: tests: gpt: add test_gpt_write_part_type
      commit: 7a598e633a5376ddae6a96bfcdb28c8e7b422b0c
-- 
Tom


