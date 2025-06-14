Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4978BC7114A
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 17:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388B382C8D;
	Sat, 14 Jun 2025 19:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uM7J52nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D0282C8D; Sat, 14 Jun 2025 19:44:23 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C678129F
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 19:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60f22023eddso2187376eaf.3
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749923060; x=1750527860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rIzxiVDsfd8T6qoeio4ZJkLIGul/QW/XfePC+OD1ehA=;
 b=uM7J52ndmkn53c243ne/AbSEPEyK5A18X+zI4mg+/lwzAWcUJ/PwimqAZad39QZGeA
 lic9TLlm/O6nu8OW9mbA8MkyhDCWqsezbFkZkVjyP8WV80HgV2pG13Hw1tlc+1owTVd7
 UODx/cTVKoU3Nge/SXTRoHakg60fAQs/p29Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749923060; x=1750527860;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIzxiVDsfd8T6qoeio4ZJkLIGul/QW/XfePC+OD1ehA=;
 b=wDLQZCgAV+IezqgU8Srte4D4C/ijCx/h3t0O3aOnz5hb9EHl+0xJRsL7op3Nb56qzF
 15l4QFtw/NweGlCa1ozELJinduxvaBroVpfF4KhzGu33qaY1b/FED/0oomxD0zYP0ay5
 j82xcd4YjcUI6g2ilYCR9A4BCdHMRADUa3b1ZuheH4OsRpCIRifvain0yC8iLp+imYpV
 jls2HHvTpKKuNmFlPqYSZvRwhl4TH+TSX0OhJxEYTm/XJbv6Md47qjfWNFtjGIBo+geP
 XP6mScROasCoQBmr/JLmvhjTzjO1NWZSPBXsBPmhjFMqsaPhknlSt9o1Iw0808JCTUP8
 nAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWAoB/A7yS+fIrLXCOLrdJE7KqZU0GXTZ1QwdswtTMBATephyDZmIWjMnVZJiU5NokCBYfG9U=@lists.denx.de
X-Gm-Message-State: AOJu0YyvBn6KVFUuV+izOYIGYXrH+utF83mXAt8UjyyMjY+ZHiM+yAOm
 q8Wz/nXWL1OjnCgohm6my+t/wu2RahsznyzobgU+xLzvnssusb4LWQbvSx3WG79YmHY=
X-Gm-Gg: ASbGncvno299WfwzkCZBCTFWDekwqiGvYbFl1Mq69VZS+mRfluxDWffpu0u7Ohh1bfN
 u5nNhJhwfY8zcq3VXnfiBmdqVefHbv8v7Pv5dIAIYQbFDfIOIT55B7rtXvIEA8pDFomDPQU+GE4
 YoQGkgNGdnCfstXwe2SN35FKcYbj44f06g/jdlwAWDcFCEP8e1Qo7x5EENl3e6Rlg0KFp7fRr4h
 BbuPTgnIomhFvtOdQAbrpzfJbaZbby1DQChOO9aQ6QA9GMB8I0wmBSb18XAHnvRJebFI4ZML3Ly
 wQ02iaEQrvwp0aXuZ67RAS3wV4AWe7wU3w1hdnJDG2zpzRrQdHGZsGzROul13k/SMCO2HmwEy2/
 aSh/OW8GqnpaUJqWQcHkk5g==
X-Google-Smtp-Source: AGHT+IG96Jn6y/Fb9ASipEkUaHRA9UoAg3rOo17Qpyz6s9gqw7lj8/XMbWrTMrv5RxO7LAjsUl6dww==
X-Received: by 2002:a05:6871:3609:b0:2c1:4090:9263 with SMTP id
 586e51a60fabf-2eaf0bb4f9cmr2595155fac.35.1749923060122; 
 Sat, 14 Jun 2025 10:44:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8ef0f93sm1145016fac.45.2025.06.14.10.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 10:44:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 0/5] linux/bitfield.h: sync <linux/bitfield.h> from
 Linux 6.15 + winbond
Message-Id: <174992305858.984784.7466559562026874319.b4-ty@konsulko.com>
Date: Sat, 14 Jun 2025 11:44:18 -0600
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

On Sat, 07 Jun 2025 23:11:16 +0200, Christian Marangi wrote:

> This small series sync linux/bitfield.h from Linux 6.15 and fix all
> the compilation error due to a change in the header include.
> 
> The sync is needed to make it easier to support the winbond changes.
> 
> The changes are CI test with [1]
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] clk: imx: add missing linux/bug.h header for WARN
      commit: 7d0f2733797f3c1453e718c3b9f9da3c07708c15
[2/5] iommu: qcom-smmu: add missing linux/bug.h header for WARN_ON
      commit: 1f1aafe0b526ae22b0b1673d440c58fa99d5d4bf
[3/5] arm: apple: rtkit: add missing header linux/bug.h and linux/bitops.h
      commit: 5c734237ac56ed943221030cd027454d2b4d94cb
[4/5] linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15
      commit: 01cc7046ad2a1537791cda5175bce281f0a0acfc
[5/5] mtd: spinand: winbond: add Winbond W25N04KV flash support
      commit: fe37fb8214e40ea64cf03453d112527b629fb08a
-- 
Tom


