Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF6FCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B160584815;
	Wed, 20 May 2026 15:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yRncrZ60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D37A8464D; Wed, 20 May 2026 15:38:37 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4695B846E6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so3517160f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779284315; x=1779889115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmpPF8v6ehebCNfAifw1pky7euHKDsq1eRjEiuWyg60=;
 b=yRncrZ60QFeTmcexo9kDzWVS5d1nNQN1SMJ9iNi/LEeh3+M5DZJyXQQhWPMvwIm9Z8
 hbyBCgyY6aopgc2FftgRyurxTwJMc8o89kJUNGZmDuBi5VC+V3z+aqBZB3FqXCMogyBs
 SHAwj4WHRg/XK5QZGaM1bpWr8V6UlDLVm2iXITiOwY/Ai8cV97pI/+eryOYcnAhGOENj
 DtlSQ0+Wzlh8bBkRaEETvFZk/jT5GDoqDZ78nP9Xc4yaRW0lgUJwNMcu6R2iSr5/PNPw
 ftbnjl8mLQ/rmo8kBG63nbL+Hfw2uAe3e3QPKj5+sFEJjcADW4sBmfGSZ+9qGmeTg+B9
 udkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284315; x=1779889115;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RmpPF8v6ehebCNfAifw1pky7euHKDsq1eRjEiuWyg60=;
 b=lxIAYmEmh9HcMGQ/Zxlu8+SFvyV+y1j9jq9StiIqNfQL49F+KSW+I/Bvb8RUJXHzvb
 9rjIxZvcghw5jt0m9M2BGr4dHiXrKIIQQmy0weVDm1m70yD5GROt4AZCOMbNtsCglgfH
 vfZNpDLXq2kQWgjPnnhUMWkS+YfInRrYDOuf/rO8+0sr6w/QQr+VinGaAt286Lw1lplb
 biTT+bmhxYSwnRVFcLN1pxEUWAvtqy8aw4mhbZfbnaNEWNb2jgaHWuu34soJRi3Iqu0N
 soi53KK6u3R7EwCQcFcKDv5vVKeCskadVYeFzrZRKE3PdEa4nh2IiIF8e5H7mYSBnJam
 T1Iw==
X-Gm-Message-State: AOJu0Ywh2u8TQtfvvSCUQE2E67Z04D4L8/Pa1aX3xjF/NWYETybwPXjo
 FSj9A5eJXMSk/I/IRS0l31tco/WM5xQI/FtOJV6zI5wy7vftCOr2gPpxHEwXR15G0r8=
X-Gm-Gg: Acq92OEpcXQ/51TBz7vu3/2ANG0IYEwYEzPXyUh0blj/V/T9Ry314/AqWSJYXLXVbUJ
 Yoy1id70UlN5FtV04TKTJtFWwQeuuTxH+NMQYqvOM0JeFz/GPsNKPLhsBHuZe3xhoaTKGAzax4j
 s7XGnyVkO3d+DX7awVfK+zJL4EaNPiv/jj4ArHeMjJUJrdbVl+/cMshfnSk+to0+3623T1CksyC
 0RAgGK26IHjrXP0PZEqTuWZQWy6Y1u+hBMc97OP4C0qz8NZOOR2EYM10NBo7j/kS1S+Oi6mliY9
 0ei2B8PEWe4TfKkcPB0CpHN1L0SWsrrGbQvXchUJUNEYUx15CTNu+4sRX1FOyc6Zu4kjVK6eMuB
 qhoLzR4onAL6+i5XpBWyYabdSffU4sueOhZwDXuWbEEtwoYRM1K+mqhzMWy461EzTKOYrI3Po2G
 VmPSjbdju3S0yG9VEynpUafiK+7N7/YIaDo9ZvLPT+Qw1Gte+8wQs/7LubEE8Ck6EpA69qYGVFY
 ovj+no=
X-Received: by 2002:a05:6000:1ac7:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-45e5c57d369mr39517753f8f.1.1779284314672; 
 Wed, 20 May 2026 06:38:34 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm52466459f8f.3.2026.05.20.06.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:38:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, u-boot-qcom@groups.io
In-Reply-To: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
References: <20260508122144.512818-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] pci: pcie_dw_qcom: Staticize and constify driver ops
Message-Id: <177928431347.632715.10241026442561590369.b4-ty@b4>
Date: Wed, 20 May 2026 15:38:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 08 May 2026 14:21:37 +0200, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.

Applied, thanks!

[1/1] pci: pcie_dw_qcom: Staticize and constify driver ops
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5a995c2fe0b1

Best regards,
-- 
// Casey (she/they)


