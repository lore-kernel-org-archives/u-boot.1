Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B1ACCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3611983981;
	Tue, 28 Oct 2025 17:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBiMqM5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA677836D1; Tue, 28 Oct 2025 17:57:37 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFFE83935
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso32903045e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670655; x=1762275455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHJfteSREVzUr9XxwZcWFhsHNZHw1zo6d7bHW5BFsBc=;
 b=kBiMqM5AJPXaRI+Mvsknenksdnxx0DbW/NGhRnjb1ItIi0mnqHHW+yra8tao+wF4mY
 18x2w40fb9/ESDEOX8Uc8I3Vdn4EY4l78Tk0CtWdOFsAuL2SIiM6Gw6verjVO3dZzIJu
 W8BfbBkBKV9IO9JaOw452j6o22GQ0TZyH0tcrLs2CS2GVUBOCAGB3aGqjc6nvLuz+HPz
 nOdn7p1/fGsyyq7Daa/+sHbpNmKhpCzoGrQrdZqtMH2KNcIIOH1iFX3fPKsh3ZYFtrFc
 I/AustbuVtmfA4ot1RplparYJIek6lVhBpPBFDYy1mUzOy9IqdlAFv3j5dMx06SI41vB
 0ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670655; x=1762275455;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHJfteSREVzUr9XxwZcWFhsHNZHw1zo6d7bHW5BFsBc=;
 b=VG+4gC36+nUtT7JMPBXg6VqHxhMk16/W/embFCWaLZjl7fh8O/5QG+J4WNzBnIo5uG
 gINhMCsFRvwr6TilMCOXqsekQyz54kRmycRrx2QUmqa3HbfFZ7aV/rdzQu86MeAXGcsZ
 SE5oIgMiuR+6QT7WYlUBwshzChWH2a+DIwdA82eMQ6KpEzVRV4k6slQEQqIrDa7A2Uv7
 +zcFzcL0umIr+yom8tCdBOqmz8kYdJ5KfOHvhEFR3OAHpxN2o5esGsI3J0WgYFJfncKM
 vbXhHhzE2Wolrkk0q0D14DGbEQK2HUPV285Zr6dL0zwlxVFcpx138nYEyx090aYCGPGf
 rCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQH0g1/tWCuTmJVphJlNylyKnKV5nv4vPdnW/eIIaCYfCQg5+SJ3kq4yFTWlpcXMNorm2ppzo=@lists.denx.de
X-Gm-Message-State: AOJu0YzjEDIphu1SBIHJDf1cw3fpGQPQBy+ElfxvU2gyzKecrVAQxtzF
 e1zC1XX/CMzhqy5e+nAqbA7POJA6wXfcqKrDkJ3z9l440FuCxpnPYBPAaFJDb8Yj6go=
X-Gm-Gg: ASbGnctb4cQHOtp9njUN8X1vxel6+gYUQyqXiutXTWKSA5nXh+wJjlU1GWujTb7xmWO
 lONcWC4OoOSUx9RJbTvRpCwI4nJarC7LYAx7YPdjX6xqjgw4KtK3K1YdjOvdBYdcZKXf3IB5mVI
 OLVAzAkR7woXyW1esWmyP8/XGjQLQNXHFtg/vvGuw7/zVdPzX3LRyhIlzc96EIGAO9k69MU80Hv
 mS0uNt4mUSTwmPPPRaJA61Q9TIl4X2wcP8wJLhaJSvLT/JJ5ws2vTtiJKvz6W8bikuMflUpjpRl
 7NPX6XBwopcAkmftz/F+YGAdGmqADgBm8/joUeIfEx+DoDZl+kLVfwwflz/YKdlX9/N3tvwZJ7x
 A6Z11GX7lMGaWfKrWsMW/3xPaWKfrPB6JGpro3EJ2jKKVRO+qCih2JbwE8o/k15rTW4jKvdGyjh
 JVqwlvHaICxwheY37pT41t
X-Google-Smtp-Source: AGHT+IH4O88rcev15mHjz8APBDkU75fLH5hW3kQCX0+YAw39OQp1ahGJk362b/3Ix4mPLRxs5TiFPQ==
X-Received: by 2002:a05:600c:a013:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4771e184c2dmr1537625e9.14.1761670654847; 
 Tue, 28 Oct 2025 09:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
Subject: Re: (subset) [PATCH 0/4] ufs: Add support for MediaTek hosts
Message-Id: <176167065378.4104072.13033991788401267817.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 28 Oct 2025 17:58:12 +0100
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

Hi,

On Sat, 11 Oct 2025 21:10:03 +0200, Igor Belwon wrote:
> This patchset includes basic support for UFS PHY and UFS for MediaTek
> platforms.
> 
> It's part of my MT6878 upstreaming work (more to come soon), and is
> fairly basic. It does successfully grab a link and allow I/O over UFS
> with no spotted regressions, however features like clocks are yet to
> come. The peripheral however works, due to the clocks being set up by
> the previous bootloader.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[2/4] ufs: unipro: Add PA_SCRAMBLING property
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/200e3f893fbc2915797b466043bbcb19000d821a
[3/4] ufs: Add MediaTek UFS driver
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/6cca3db2bd91ce1e5d812a61c13f1f62a2c2b82d
[4/4] MAINTAINERS: Add UFS to MediaTek section
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/928269494c8495eee0a74c9685cc6c222e8ee0b7

-- 
Neil

