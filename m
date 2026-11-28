Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA71606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g1n8JRrO;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=n9B18FAd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4975880E75;
	Sat, 28 Nov 2026 13:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWQMpY6Yli74; Sat, 28 Nov 2026 13:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4D9E811A8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871547;
	b=ZSgtmGh9cVItRqO2MqHFG4QgIYmuh0XEH5es0kSQYYgazuFrl5HRCJigGkdLIJHvPobj
	 TpzMhxh90Oop3U6CjCMEuM21f2usd7aF9JsXB68Sh7KZJG8VMaGlCEsprNSNX4eWvhWZ3
	 XFxk/ZVZWWkbClqk+keNk+pIjC7aZt6zwnB7qq7rLdYI5uUGu22yOvxvwW7rqc7iv+rhM
	 xCt4jEy4mdG8gy4Zi+xb5jaE2ALGXsEbSwnmuEwRefYhq/QNyV3Njax4e6rla/95cJNUQ
	 Qvurq3VuvySmjAWoKx0muphXnJ5lBYlb3J3sQIMFvrGBo7ao2Ic/m8Bs60nW7hmY37w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v2dQ7Xenkd1Ho5nrSz6I//sqfpKD/5lSiePjW4wcJ/A=;
	b=JbeIReVaMRy+G/GfhgZnqn7o8tTgmNX0BIFY7PK3oFLAloicvNTsTti63ADdmW/2fLLL
	 rdgXkGu2vqua1t4bU8lty6nXPtKzCvLEndwKKAfuHjIwB7aug2b4tIZd9Mb0tkArQzyyL
	 05wGuJ44M6MY8qxB5KkES/YnWTcimKraZrDVaXXi9jeJ85nCEw7TeKCQucSNouHgf4WLH
	 ynGaN1W4w/O0SxFemXecU7Lr3b3gImkvN4INCXITtvFS/dSFnRqRDPdxDCD8z9xDTf1xc
	 eNL2FOK8/LRnf/cvHSEAPszZdxl0fh1zZtn2dPGq6wRiqCi9PMlo+WJioGjoCsFBrvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871547;
	bh=v2dQ7Xenkd1Ho5nrSz6I//sqfpKD/5lSiePjW4wcJ/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1n8JRrOTsYBS2Xnp5148mHckrySf7HErd3ybGLMbWKj1S2DUwaQaIOwAOMzspFQS
	 WoyZ7JLOyToWKUEbNlV4+Zgdoae+ryvyt4ATtTBHHBNWjHbtxx9CBBeIHCq78fx1h9
	 FKGNTS9Sq+w/AAQTt/CxVA8F+K2zDG3dW1yDwSRGVfQWmcbzjLj5+3dSVyxd4NSxxt
	 pvvlQ2PN6VsVbaYAiLqO9bJOJTPUIpEr70+6cOm71eHPTHKq8VJdNRGRoEuha7mRy+
	 ZtxCxniNA5TUpONDNUrB48WlP2H42vHl3BJu2xUWliPQ82cfU2EqnZdKuZM4+VFnzP
	 ICXA8rQ4AQTaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4D9E811A8;
	Sat, 28 Nov 2026 13:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8C8926D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAE0D60621
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sl1_MRevRKwg for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E96B760650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=n9B18FAd
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E96B760650
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-491846221ffso7865315f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871525; x=1796476325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2dQ7Xenkd1Ho5nrSz6I//sqfpKD/5lSiePjW4wcJ/A=;
 b=n9B18FAdSejt7SW/Tdje9rq37gIUXqlPorgz65ypYsMYHeMwgTegzJ7mEl9EeFwv4x
 L0a9/43Iz8nTbZggvZ0F9AxjJPigs9dJ4P2g8BLHYu6mvCmZPK0dkPdCo8V7MxQdDg8Q
 n3HhH3gWJy1j6khA/GZiI5IdbEj0R/RVlizt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871525; x=1796476325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v2dQ7Xenkd1Ho5nrSz6I//sqfpKD/5lSiePjW4wcJ/A=;
 b=eM0eAz8NtooA98q339AbxaVh0z6UsEu8VY+VL05vIOY4Yj2KCTa3vH+VtElodC3uEb
 sprlUvuSvvh7wnVLgxdQD7Eo5wlq9G3GLiEd+jgVwi1r5P1NEzjXKUfqwI9bl+8eACbU
 Vcyh+FbvE1FESmIjSVdAatAnraMtg9gxAAj4mmcmtAKswLDOjJ5yCVR+WljkI712cFPp
 Wnk8QTKJBuNx9aJnOgOQ7EKFmWJTPeKGLxG21YTVfnHT4jPj0VJjamtRMxtzRlAJ/FIt
 d6JA6IkVXjfNcFjLs0i8+lb17AKJTbr/teX0Y3qSgiYzp1pWwROxDk3/v3RrlHoKbKSU
 LzbA==
X-Forwarded-Encrypted: i=1;
 AL+hErGf7BPG/on1Zzijc2mzy5aBa2KdVP5r1SHvsF5QckDJFvuIrUjNQPiDkPSuYKFacLRYr3gCpbM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZY++n/Wn6jSebP2vTVA5iFbZY9TBrv5l0FAaa/bX7ND6oh7iT
 lA1Xu5uSeImvgvjPDBp4PsszH9vxOu3+OlJUvrZejFk0G8KsaYPN38QK49FmcxisaUs=
X-Gm-Gg: AZFdTZcE4fZeS505a64iu+UNq3yYnmeEgMO7ewHBmHpIoREKza/rSUrez9I7f+ouYzh
 xzOfTrBgG1UjXrQYlCuE3Q5nEU42kvTyduzC8YzqSiD3+xm3MeQEkLenWaADDer9PLv3s0TrGtH
 dSVwLQho1xq1H8hZxKbyfzE5eBMFghnI86RrG3KXj6hTfd3r+IC7WQf8TNAF8M59DrX/fmzo/bL
 3kjEYKqtRpb+TC4MxJo+BXibvn+XXNBu1yBvy9+oBl8ztJk2ROa3lZXys2c//OPTq+KTNdRqyDb
 fgNFzcUQmIOVjKDDnl/QEaWn0PxLvni1mD+aRJ+t4Wl0i7cp5pAAOivGHXCWXoB12CrYwsGynTU
 94BWgHoMRSRbMOmuFfNCN6LRoQqqO8JKJF/d4M2qYoAB6uybNvJDgQZmnwqH7mhrrp60xUjiB1V
 2hatKADuoWzstmkoGPst1ojyMrX8jAYAcZ3+InSlsmKzkW5HODhMAVPlqSHOCIUtNmgsMd/QnEx
 4JxXYs5hGljK3nKVSb2rz8yoNubjuMs0F6aoT1QOrfDVxcBm8JQ96DgsBrAoOLUWVmL+mMyh/a9
 hbA1GwCW3XYAnt2rMgQKvMBU+GIBhWnpzBqHamhSK1pVjOrId6em0wHaniyiyJeQ9RxBMNlLxhk
 ORA/JK0wNsOT5gROlFHkif2i1RpRNUhrL9eBZtZha8GNHuUQwFzrs19d3FfofkYdQqJx9dgBTWb
 4cav6GmlpyHANiRaQyOLIVBFg8sQ==
X-Received: by 2002:a05:600c:6219:b0:4bb:a5f1:fc5f with SMTP id
 5b1f17b1804b1-4bba60168f3mr237457385e9.26.1795871524911; 
 Sat, 28 Nov 2026 05:12:04 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 22/29] video: simple_panel: add Ampire
 AM-1280800W8TZQW-T00H panel
Date: Sat, 28 Nov 2026 14:10:39 +0100
Message-ID: <20261128131125.2141352-23-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add timing data for the Ampire AM-1280800W8TZQW-T00H 10.1" LVDS panel
from Linux to the simple-panel driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

 drivers/video/simple_panel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 1cf587f973be..e674419fd912 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -208,6 +208,23 @@ static const struct panel_ops simple_panel_ops = {
 	.get_modes		= simple_panel_get_modes,
 };
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct simple_panel_drv_data ampire_am_1280800w8tzqw_t00h_data = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+};
+
 static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
@@ -240,6 +257,8 @@ static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "panel-lvds" },
+	{ .compatible = "ampire,am-1280800w8tzqw-t00h",
+	  .data = (ulong)&ampire_am_1280800w8tzqw_t00h_data },
 	{ .compatible = "auo,b133xtn01" },
 	{ .compatible = "auo,b116xw03" },
 	{ .compatible = "auo,b133htn01" },
-- 
2.43.0

