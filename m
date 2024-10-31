Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7915D767E9
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 16:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E59088E5C;
	Thu, 31 Oct 2024 17:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="srqDdsL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC50088F1B; Thu, 31 Oct 2024 17:58:39 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C208A88E0F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ebc1af8f10so524017eaf.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730393916; x=1730998716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7l8N0sUCSr10g61egT2VwdCFmFftywa6XByayvQaXE=;
 b=srqDdsL5edYjFPTzbAoXLAvZv9P96LJjrLzUPRSPL9kht5QBhRHbfpLAz6UKIeFm/y
 m8JNMm1nao0eNWiJ3BPXPwBQX0hPF3IkJYt1NW2KyoSTaPVs+/1FXkyiPxx5S4r4RrMq
 WHb4SsmaGEGzkCim8L9WBzcITk64Q5LZ+cxf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730393916; x=1730998716;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7l8N0sUCSr10g61egT2VwdCFmFftywa6XByayvQaXE=;
 b=g87KrrQftm0/jrdUKU6BAxtSUiakMtG0kWD0e42I8XSAS99C4NB8sfPPj/xrv55cgJ
 wi7c49fWVNAmVVQ7RHKPUpos0nklXqUqzmDJkAuEZBHKgI9x0UjEf9LQdZ3ZoeTIj8Iy
 weDve4Nl4aZGrqwHQ7Ji5Uv5aY0OUIbONFFddNLPH1cjmDH3mBLOza7vk/RJVgU+tU1U
 PyPAiXVHSpcigavkJp208JQ4Aoc4eZ5HS12lrBZObroBqTbWYH37teKcrvMVrMuhuwT1
 V+TNXFinSBpXquqNiQ8LPh3elZPHi0LDbjVuQG+mTA99u2S8oe0rzZlgZeu/ZYKq8CXd
 +Rzg==
X-Gm-Message-State: AOJu0YzbbM8k1osto5T3OzJ7ykKn5TeTelNMogtPXYPcQl9JuXbulT1h
 1xuk+53mYYmYsImBtCI91vn/rsQs7l4sQ06n2Sbv/fQMXrDvufoT7Q/lfI6aDAk=
X-Google-Smtp-Source: AGHT+IHrAbDkPP+2aGp2SgmnAo7vMAkjdFgKLLoX060cse+1PnAdRJ7leaxaStnT0xzvzQvP/Fgicg==
X-Received: by 2002:a05:6359:5102:b0:1c3:89d4:e888 with SMTP id
 e5c5f4694b2df-1c5f9a01d87mr59948755d.20.1730393916455; 
 Thu, 31 Oct 2024 09:58:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0c7009sm9350821cf.43.2024.10.31.09.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 09:58:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added
 nor->addr_width == 3 test
Message-Id: <173039391434.3581308.11011380626355124787.b4-ty@konsulko.com>
Date: Thu, 31 Oct 2024 10:58:34 -0600
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

On Sat, 26 Oct 2024 22:16:18 +0200, Marek Vasut wrote:

> Remove undocumented nor->addr_width == 3 test. This was added in commit
> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
> without any explanation in the commit message. Remove it.
> 
> This also has a bad side-effect which breaks READ operation of every SPI NOR
> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
> -EIO.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


