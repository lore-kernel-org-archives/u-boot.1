Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD7FF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170D684209;
	Tue,  7 Apr 2026 21:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NTVP1w41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5E484144; Tue,  7 Apr 2026 21:50:23 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A29128419C
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-66f747175d8so2784545eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591420; x=1776196220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TU9aHqQN9gp/ACGep7Y7VIJ+H+/wIZZzez+PUyLK1gg=;
 b=NTVP1w41/RMcUT6Ai4tHkDGmD45OaEIwsdpHKRe2i87UZE0+Qm74+nJ1IGRESYJx71
 tj0inz/quBh/5FzN5eY6/4IAZIB1MkcYt/r3yT3OEaad2e/cNSwAr82BglroJsu1RUsg
 hjt5leFkG/f2GZouczmvoJnvlQk4dl0ovO1g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591420; x=1776196220;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TU9aHqQN9gp/ACGep7Y7VIJ+H+/wIZZzez+PUyLK1gg=;
 b=kUulBnSp2JAiwWfUZG02Or1CFlkOryknJBpaIgJp9OU+zlSZtcPbAxBjGC7tT+1JzK
 JOV3ccbQQGnnhJ/7Mm+G+dl0UK6FbE8O3JQi4jq29X+xzjzoJz4AzCy+dsDoB9QkENOl
 nFsZTf+yAwcH8EtwVRov402BvCVt5+khJRrsJkKVJkccu/nZYlW0a8eaj8JtB3mzCdAA
 bD4wL/fFfkvlPtuTpo/d7F+B+k46a/NQn5i4oogVq4zFIz+4p5+qsIo+4v6ODTd/LCPB
 Nmq8bbGTtCXXgXCcxuaJT/atqKpNZwbR5Q2w/PTK9vvJVbY5+qEYpKN+PHkUeiLyYymS
 JUaQ==
X-Gm-Message-State: AOJu0YySfX/PcmKilUtd3C3z51THqRBgESGDEMAHhp56hCZbvAqe25Uc
 NV3TDpYcFflSVvxcjXGLVhb8dzrJKBvsBr0KTzpGela+0i/bcjN4vyK/TavC7SdHp2w=
X-Gm-Gg: AeBDieuDPw+UxhR2QhakYE/q+BVz59L44Nr8JPrNnXuOmULvrTVAPSTciKSnE5D7Uqp
 /36ut0hLYj+OZzVjgGri6ODUN0fLAjGJJfwU//+h5Nqr2oC5UweO0OmUzLWciIXfao0woCJfKMf
 0AnY8qUl+s66OO6D9d/nG8jZQWPtagbOW03XpS8WCQWxC6uxyTaMscwh7QUyoFc/fKffa1zNGXZ
 +s/nwdjOLdzRhAxZssMYdCWxfwSWqU+qotMeEbBW1O3Ikj2S+/scTRQUadVi/+r7XDdascHNGMr
 kWa4YrwFADRG/kOqipKSbXmQw2RnlUKnTqyWUx/p3MTlQk/sk4RUSF7sR6QkFXMXZ8+MrCzMoWi
 WgtbJgxblI6sfj9Kpth9gd0lIDDnieBHFLbfcLTf/asIcvWpOW7KIJ3KpPSBYm0pOPyUfN3hBRh
 K94cKMasaQoJJv+mH/v52WVcB3Ue9eQIycpzgxRqfg2LPPa6WGFLRy07xEDDHtJk0sK1Nc29ZN/
 T5EQit6N5H/yUJ52vQvAMDVd+zbCt2WiCX+tz7+LPp2IoQ=
X-Received: by 2002:a05:6820:81c4:b0:67d:e836:2e46 with SMTP id
 006d021491bc7-6822064327emr10582368eaf.45.1775591420434; 
 Tue, 07 Apr 2026 12:50:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 =?utf-8?q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io, 
 linux@analog.com
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
References: <20260323225537.896180-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Message-Id: <177559141859.2108693.17265258152616779822.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:18 -0600
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

On Mon, 23 Mar 2026 16:55:37 -0600, Tom Rini wrote:

> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] global: Correct duplicate U_BOOT_DRIVER entry names
      commit: 8c212d6e2e778b4f294d1d9f85eac9680a66d463
-- 
Tom


