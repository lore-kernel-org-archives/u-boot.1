Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC3CDC19F
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2605883F9A;
	Tue,  6 Jan 2026 15:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrG/SCDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4620183F86; Tue,  6 Jan 2026 14:58:20 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4103283F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4327555464cso560654f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 05:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767707893; x=1768312693; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zv+c6RHIc07pD0EcObYDOOdrRZ8nCh/i4RV71DUt/RE=;
 b=lrG/SCDWTJj9Wz2UwalmyqyAMiUi5UrNGO+c8EyswykppNJ29H7GpIiz+z/KA3prlT
 9TqzMwQ6V8YDGGM/hkpJ6JVQF0vfsTzx1xyf8K9vP7iZvevht2skP8vXu6fxotkHL7SL
 gF4M1R83VcBHhKAq2sxTXUftq7ZP0OfBiOD5xJYBpZ7C6Z7U+7dueVR+23hDo4qS8WZj
 j1s/Ezh46C+LzhN2xjI68jdXwrrrfEO2KG9nMR2kucAQZnmazbPltMVVjM/hDEfbDeOy
 hnBT+kpl4bTdV6aB9oZjLtoQUHJiw1cGKMHNLPZvYWZsGUQ5+vyVbVEzjsJNzA2hYH9P
 3KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767707893; x=1768312693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zv+c6RHIc07pD0EcObYDOOdrRZ8nCh/i4RV71DUt/RE=;
 b=IFW3Xwvj6glSTRi3e3OSq4Q3LkSP65Q0oaVNdFQfAtKogEUWa0yHXXW4XNxiOq2s5U
 W/qGxl0mJDxOMh4Kq89YQc+/t7Mhg1D4009YdKim5w72I4aT0oop/45L9yzc/NoCF9tG
 Oq5Dau/FthvZxgQWPVD5kSv5vA3gUJKc7rwfvC03NAqelYOmju2zWW6Pz+13mj6FXBSg
 1WzlLPNcQl5AQp8auujXT1wobCCRsddeXRaHAasH1+7e3dgLWlvhdxbbpryJ2RGRs0Lt
 FdMjkS6sNbKpFfDum7xd1/vZ5rFOwggZjagn3sQZ8WXVqDVFQa1tjBeDK/bTzFG2m8DY
 OC3Q==
X-Gm-Message-State: AOJu0Yw+MDvYHuZC+Hvm9uQ2TMJhhHivV38PcUAks4fLkrQx6gLnx14c
 jg5GHuJFVQDzfB0cMlcIx/AMw7JB/Np3anE5s5pglug/foENa4QxbM0Q
X-Gm-Gg: AY/fxX4qEdqXL5Mf9d5MCXi7Ki3XpNYWDe6UGYLBuqKrp5vpBc2yA9QIb7c/Bp0dLMj
 MBWGYlaCCneM0qyaYX+kcdvleMUgpyMNYbFtW1sQW5cWNtWkvJ1jqtMebgrh8kKEyD/sGFMWY6e
 MprI7X0u6KR5h+gPB0m6v/lrekMjvb22j+QP6Wb2YVn3KvcVDv0+8hMGY/31DhC8aXbJQ/zin7E
 og0sN4flC3u1z6fCYqIoqRYZnYAfvKY4TNTYqUu3lfT4FOAC4MeBgpmgTUENxop8EQWsp/YkL35
 i/JNp8tl5/OTOpy9CaEGJWPNpWuxnqVBYoZdYT1/7PXlZ7gWFdMqnG1PObW5EhmeSjJB8pMf6Xn
 LG/LO86yI37X17cVwr9BrcbJkso9AQPZpz0TnX22KRhzjAZfqwyzUlUlILDRgX17U0xpRr/ghdi
 Q3IIdja/uz92ZLfc4AaGve1fMnO6j+w0dpdpylOgacdEmrLI1pCXHPnWXg+pIpZCtZLw==
X-Google-Smtp-Source: AGHT+IFxUgmuDBa/7r9M1Viu9EFGLegpAnFTtIQGkqr7heJizHvkawvv38GiqxHCmbA4RHkNNNMwEg==
X-Received: by 2002:a05:6000:1448:b0:431:2b2:9629 with SMTP id
 ffacd0b85a97d-432bca4ae0bmr4458688f8f.51.1767707892505; 
 Tue, 06 Jan 2026 05:58:12 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm4605281f8f.22.2026.01.06.05.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:58:12 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 06 Jan 2026 17:57:09 +0400
Subject: [PATCH v3 2/5] ufs: Add a quirk for SDRAM-only DMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rk3576-ufs-v3-2-bfe259fd6d17@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=alchark@gmail.com;
 h=from:subject:message-id; bh=tVeSEv5ijIcJhsZ3GaeBqjAaiFtXZ7U1WZeUMgJQlnE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGitzIC7sXe/Ds45vbDyy46bTSdAG/2pVP009OYmI6Y
 1xzcPl9nY6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCm+qg+wz+FJUm/1uTs3e7S8Uulzz7uWfqkFd/zBdVvxum08SWkuh5j+Cu1fBn
 32aJrPVnHwtM6AlayBL45u6+97EpS16GjnVbr0lgA
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

Some UFS controllers can only directly access buffers in system SDRAM and
not in other memory (such as various SRAM regions used for low power
states).

To enable block reads and writes from UFS to such non-SDRAM addresses,
add a quirk forcing the UFS core to use a bounce buffer whenever the
requested user buffer falls outside the system RAM range.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/ufs/ufs-uclass.c | 13 ++++++++++---
 drivers/ufs/ufs.h        |  7 +++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259c..8b0e2f5305d6 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2244,19 +2244,26 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
 {
-#ifdef CONFIG_PHYS_64BIT
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
 	uintptr_t ubuf = (uintptr_t)state->user_buffer;
 	size_t len = state->len_aligned;
 
 	/* Check if below 32bit boundary */
-	if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
+	if (IS_ENABLED(CONFIG_PHYS_64BIT) &&
+	    (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
 	    ((ubuf >> 32) || (ubuf + len) >> 32)) {
 		dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
 			ubuf, ubuf + len);
 		return 0;
 	}
-#endif
+
+	if ((hba->quirks && UFSHCD_QUIRK_DMA_SDRAM_ONLY) &&
+	    (ubuf < gd->ram_base || (ubuf + len) > gd->ram_top)) {
+		dev_dbg(scsi_dev, "Buffer outside SDRAM %lx-%lx\n",
+			ubuf, ubuf + len);
+		return 0;
+	    };
+
 	return 1;
 }
 #endif	/* CONFIG_BOUNCE_BUFFER */
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index bc839a437045..f860c7143bf7 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -691,6 +691,13 @@ enum ufshcd_quirks {
 	 * single doorbell mode.
 	 */
 	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+
+	/*
+	 * This quirk needs to be enabled if the host controller can only
+	 * access SDRAM addresses but not some other memory type needed for
+	 * U-boot loading or operation
+	 */
+	UFSHCD_QUIRK_DMA_SDRAM_ONLY			= 1 << 26,
 };
 
 struct ufs_hba {

-- 
2.51.2

