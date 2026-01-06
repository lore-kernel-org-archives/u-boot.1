Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF429CDC19F
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6990983FA3;
	Tue,  6 Jan 2026 15:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zxx27/h0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEDB83F86; Tue,  6 Jan 2026 14:58:24 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A2383F86
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so684856f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767707901; x=1768312701; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iuiXI3Rm3Q8Rm1JpAF0seuUV6HDx7sUHqc2XkBy/0lA=;
 b=Zxx27/h06dK+ZCoioDHv2RRNSLjmuREIFrtF/NOUuGg8bSOAvq81oUZ4RgSgF5Bgm4
 srNd23Egwt4pKkudD5+D/3IU5IqwuxHzvs86lOKamWxa5VD5mL7yf4oup2a1sRPMrEe5
 VWaH3ZmbDXbAtJdf8jxXUcgHWSGWMbYdNy6yDJ6uhvpthEoABU1kC3wR1yZuRLZ1OQqn
 VU9HvjewmWRQizhL6UGqdji38Pjt4owyCtDEzybQpY4q6lGf0WzL83idmlVnLDUF5LuP
 uOBUEmWJNd7CYEtRaP57JZMZhdyFxzttH79M/M4Lsrzxp5RZfxMm0qLXUmPXGXqRW5DK
 VGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767707901; x=1768312701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iuiXI3Rm3Q8Rm1JpAF0seuUV6HDx7sUHqc2XkBy/0lA=;
 b=aJthlygdQ8VSLJXVqi0d9hzkIURBQSqQx7uKYiEdUY+NvlN33/1Vk2mv37qijsr72I
 x7rhX1kf59tGAGj10CLv/yOBmjQVri360amFGrZl1srozPyB9PMBnthBpKwq5TEhUADb
 bIYuVzEwBS+AV2S5OmR4dRGiUlcnf2webtm6oULGjK60yKh2YSVGFnL14CPW3dAHxaGC
 5paBqtMZddG45O4FExcIj3zkeGUAdZNUtdqEkkbnjtYwpydbU3Ue85v3TbOH7rh0ZSxe
 izRU62ux1utUkYCqxaU0AEO834uBI8XcAGg5rJbm7T2SGcyf5Xv6dis+nt1Ga1pNydR5
 dSaQ==
X-Gm-Message-State: AOJu0Yz/KBm3UHt155vP9ZU78Df0BptIFOq8i2JWt3krTrnWiePJCFGT
 gXG/cdOqg17JxqaEvPzzHz2YlBaY6B9UZMnXg+UqaXwX3ARCaF6xLXWr
X-Gm-Gg: AY/fxX4o3AiovgZcqUZagGlhju5hj5NANHvCJfh3dtTR3amQqwWlqSPRQqTKqRSW+Sy
 XFkdg2LHK1/X7bh+3dG08O6hMlVoJSWLA0RSNUyWxlkG0dNxJ5p+LW3PsdXvI8ah7+HoHDAJMJh
 k62kaZXvw+btadeRFojzhY6voqm7QLvCls0ei8XMposN5r2rd0cZ8Q4B5AZSQz1JlbBd/S5FRpI
 6OpuTMJknYik2QprQDaNr7dKm6Zj8HWyrgYpffZVkPbjTv2f6FBHUXUer/8RJ+1OD1wPuTvkDov
 hCWsuedRLyOqq0gz3+M1Vc8LOA+tezoRrGwgzvYUZ+4dsgVCopRcgx8zpatEFx5i3e1oTAY8oyN
 Vm7sZ6XUWoch4K7RzVCJxRKourtlKt3BRmZoeFR28CadMJBwp99bCj1UzSBDY7O8Yp77UUSf3gF
 0eMuxEKiT0Wcj+EWdHynmgrb2Niqsjknz/i7cXP8tlpwAAu7ZbrAYvHiSvMTZMFXHc7g==
X-Google-Smtp-Source: AGHT+IEAMeJuymxj+3v16e9hIu99pfzkj1OiQmY9vytObcIiSCuCBgk7/0/59O905BNmkXaynBvXhQ==
X-Received: by 2002:a05:6000:2486:b0:432:88bd:df3a with SMTP id
 ffacd0b85a97d-432bc9fc546mr4127173f8f.46.1767707901353; 
 Tue, 06 Jan 2026 05:58:21 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm4605281f8f.22.2026.01.06.05.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:58:20 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 06 Jan 2026 17:57:10 +0400
Subject: [PATCH v3 3/5] ufs: rockchip: Enable SDRAM-only DMA quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
In-Reply-To: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=alchark@gmail.com;
 h=from:subject:message-id; bh=bGR8UNOJN9JJmw3xqaSwn0BxYHh1V4Xz97ApArl4/7c=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGitxYMXVhvdTU1MO7Fsfr/LgWX9sZyrv87XbfwKiPL
 AbiDEdXdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVNlGMDHst7nAGJAjvVoi7FfPx3K8qW7MFRZrPdN+km76vt1y16jLD//SXySt
 Znv8vfLJG6LTBgc4nWXuOfeLT/uAYfN5bd+7PPhYA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 06 Jan 2026 15:00:00 +0100
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

Rockchip RK3576 can boot fully from UFS, but as part of the boot
process the SPL needs to place part of the ATF code into PMU SRAM,
which is outside the SDRAM range that the UFSHC can access.

Enable a quirk to force bounce operation for this case.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/ufs/Kconfig        | 1 +
 drivers/ufs/ufs-rockchip.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6c75bb2a0790..2543b5d47c04 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
 config UFS_ROCKCHIP
 	bool "Rockchip specific hooks to UFS controller platform driver"
 	depends on UFS
+	select BOUNCE_BUFFER
 	help
 	  This selects the Rockchip specific additions to UFSHCD platform driver.
 
diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387da..699460fc4d15 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -153,6 +153,7 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
 		return err;
 	}
 
+	hba->quirks |= UFSHCD_QUIRK_DMA_SDRAM_ONLY;
 	host->hba = hba;
 
 	return 0;

-- 
2.51.2

