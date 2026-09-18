Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81B3C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 826D260BC4;
	Fri, 18 Sep 2026 06:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ds45AFhjxo4q; Fri, 18 Sep 2026 06:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C97B860BDD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713381;
	b=eX/f2VjCHI6wMCIdKyBviyvjxpzeTgARmxugmw+mD9PCon81g7faV3l+pxq3ymj4agCn
	 tdsHtGKsdbV1q8CuONxbbPfMeucIELIB9BE8MOY2fbDgZyF+8Ou46muRncXjrkLDr/NP9
	 UGI720YpClO/zoSvSDVdmL5dzZhwTDWED8ApCyY4g39FYiX0HCt9js1wbbauUtBLWuoYU
	 asmGvP7co6PZalwHzHgvMK+0kcqXqEuU/OEwmARjJ/K+UXhh6KIj+j0bVewi0+K8A04CE
	 Wb+R0b7oO8PJieTcf6tb1fvTDpz2pimk59LaZAfSi22VTwBEpQRCtnF1fEAoWjKXOmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pzvJz64J/mzbNFHox0Wo+6+/yRwTnq7BET4v4qDhOnI=;
	b=nUKwSWZnOlcs6Ton8+VaGXQz0UnbWEy18oXY8iS2egWf9FKPMZEpOx6pFeSNsgB2L2Q0
	 IxoqKw4FhlM7527+We+IHUW02q7VYpPFnJOnPC+hXuJ9SfD7kvBY3jg9bVRWnEAIN/B19
	 Rnf28FdmvDlFrbLeiJXhhYIfcBdwL4Ya52vr3xyR0nt2R/2SpPIQBMZQF8gyAXRm/J+a7
	 OITr+TAzwnl5g0lkOSY5jTRLznrMDClLaTioB5SqF9tMCEYsd4JYNpFvzIdZ1OQgfEcvV
	 neKm6NFB2Bms+AxLJLUhSB9ORcYbKIXKgzx04qFnQDR4SNJt+Z1fnfxKz8DH9VbQm4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=dUi+xEQG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713380;
	bh=pzvJz64J/mzbNFHox0Wo+6+/yRwTnq7BET4v4qDhOnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BLTZvcOOc8UOQC0nNqYss02jCaTjjtmIv2g1iGV/ACsr65QBrSh+hi0OikkVhgdIm
	 quB83BXAFPLeUDvl0lxTwQnm6PNffKYrltQuKlpOo5AIbrZlNxrLfU7J6eIGqYJ+Z7
	 nvihyMOrUIdiY9fQRHXow492oA3dzD4+HJX9O3w7KU5U4VMUn9Jt2xCXtpnwrdXnxa
	 0WM+HWFbRJl+AaSZTW+Zi0oDNSifKM8jlqXO4YdAgbvt8SHxC4YwBf8AmQjwenNMBi
	 SR0sOgTI4UFmVWDVdN+x45El6GOMjMpNiLUKw1h4Noj/pCYhEy0tzLm+Lb3vfirlL7
	 vuFINTwT+2Frg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C97B860BDD;
	Fri, 18 Sep 2026 06:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A011529B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8624F60BEB
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBfvOg1MKy0M for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7F6A860BDD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713379;
 b=e9HpGX4G9129otf9cmO+wh+mjP/1BCj2wgaktJJU1D2oQYdc1AlTyLHyXJcT7nVi35JC
 phYQD3bCmrasWBohNxSWR1HPgm87OT+2fp5wEPaJyDEw9ThKUCfrJAG8lU00YnOhdjG3L
 cueI4t62rFIbMXPRFRHIVRC8VEwrBfEQsff9DRVFINtTo4uskjKNLhUcFEFxd8+PpgpJT
 uFGMgUOX9l7275EoP37vtuHgherZmBxF5yxfATo3H0YepKjzQw+elMNmHy9LhzQcaJTaM
 i/aDQzKwGcz6PAXJ6lpHnxn7maMocM3vUYh1PCAXEXxvBukxzlHhYMRUDTYl5ayiQuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=pzvJz64J/mzbNFHox0Wo+6+/yRwTnq7BET4v4qDhOnI=;
 b=RuYhtMx6VqPzbB3vpVz4QSPEZe5lnTiQNHy2rTrfXzyFAVj+LIMLYYz/5uPYRDGTrfKc
 TObCQk5GhrAXkvdtNro1C7J6T/IIX2B3JRS/l3ULGJNSmLN7EjrK3VTyNVKZDe1GWxAHZ
 hg/sG4ZBslc6fb0An+1O0vHngPrUMRUd+iVA47IUgAUPmctFMc/j9clny6uOUhn5OrrCD
 1xSNU54W8I7yfWaJXjFtiHp26zdGWYoUyFdceDvsyd/Rvcoc4c23QV/OVTk+sbg+EjK8+
 UlDiuNwqLzK8Jkm7DJnub68M3FvGobDYZ80tERFv/FP7HJlJk4kC/ITQxwitsysJ9Xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=dUi+xEQG; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=dUi+xEQG
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F6A860BDD
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:17 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so2127335e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713376; x=1790318176;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzvJz64J/mzbNFHox0Wo+6+/yRwTnq7BET4v4qDhOnI=;
 b=dUi+xEQGfwz6KvkHalM1aTn7PLSPkFVc+5/ZBYYLbf/OBrWuJWcMVQEPUU6he0QvF6
 Sffxhum1JT6xFTKuEsVsw9bFGg2QehaIDi/Bx/EAtMYdI3iRa06i9EW0Doqvby/yYtgm
 C4Xqlyb6smcVauky2caagbF4qqNIiMRG3KVU2o3jUCAo0E2nkHJpuRNF3R5looFgYS5R
 HKRNFnnire+iKLBYEdqAaD3TRjnW4O6VsBZir/D+glAeYSFOQ+2yHCXphfk0acf9UKDo
 F7e4BpDjDTK1CZKxqKdKnDgVdDQVvZxEBkju9u7SyvJPjdPU+i6GHq7TAXoVy2ViWauA
 LXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713376; x=1790318176;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzvJz64J/mzbNFHox0Wo+6+/yRwTnq7BET4v4qDhOnI=;
 b=oHF+FOkr56QCtPqHFCb/y0wePipgdcm6kbRVtOhRU8UX/80x7sCoEkivoeubg7+BaY
 pk/qfPFnvZ/3p6kCAc/uPUtVm7gfTYDqO4Vphbwtkdqaw4DZzxKl0jYL2/iv2xnSyqCh
 LICqP+uqIdiNiS++4mHkeM9jFOqsbruiUSYmOSnvDQdoTuL0dR9dPLac4lFHyk5dMsHt
 0SFFv48nQCRvauWwfZevK31jLifbs3k+gPcCBZG9P879DlA9QpbxQt/YNo+qykmZubFU
 CnIIw1H9LiCn+phhS7kecF8EGW5PXxqW0cuqaKYYPi2ktR2NLuEax3dowes8yLfjgN/N
 9YvA==
X-Gm-Message-State: AFuF++n8F8NCR08U1QeQdVo484y8VHovZ6ypApGQ5y5MgZQUvxBG/HAI
 z/Tq2f3QKNa3imQTCE8cV96HJg87ba3j7/tRrIG4sL3YD/UH46LrwPCA9UsZCJlil3A=
X-Gm-Gg: AYBFou3LNgJgNcrkK5byexVSHlma9Aiq42Jgi19KFMjVIeD2Wl6fBjFRek4MhbYOE3m
 EKVEhc32Ez8QcBMly440P1Xv0hg7l4If2Hmvx4CrBr0PPwD2jczCnGOhr0IjJLYO9riSQVnFyCh
 MFuYP5/1Pqfuf2t+/t7K3382nDQMO02rckS2kH1MFUSBUICdhAxYXUTpijH9dWM9NhTVgR/CeMJ
 RiVk+jRQkyQe6e9XKmcAxi6ZIiKcqSsGxeXR0/GEA0nu2G2Cz8kT70/Ee7kSdDABcavynuk8c0C
 OzUk48MJiDgAwmFOSAF2DGPhTbwaMf3bjrNROXE/VOcZ0GMUHavEd+bQjtWcIp/OAOSbAGtfL05
 qbDF0xers5AmS1GAItb9PVgScgqvVCuJfIZZ6ypXBlXT8vSIcE1z3y+nZGeCxYYtiZM4ncV44m2
 QiKlZ3Cibi902GYxV3XhoqEtQ2OqWKNuNCv40CjU2esUxrJrK8X0EmD4HZlRz+EoW8yGOETfMBb
 fqgHMnpWdu08zuXY4MXlXTBu+V/JI1ZcVC50T2lrJm+Hb7U6Yw=
X-Received: by 2002:a05:600c:8709:b0:49d:870:7a69 with SMTP id
 5b1f17b1804b1-49fc573514bmr31138625e9.12.1789713375748; 
 Thu, 17 Sep 2026 23:36:15 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:15 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:45 +0400
Subject: [PATCH v2 04/10] scsi: allow a controller to declare well known
 logical units
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-4-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=alchark@flipper.net;
 h=from:subject:message-id; bh=S1PlTFIbZGQm6K5XXAmxHJNXn+RAZVJX1gnty8ubFrU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1RsmLjt7ku7VrzW0U5zgltz/32Y+mLqUUqjv7VC
 pfiTrJ+7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqty9hZJilsv6M6M85JmzC8gFfyk+uOmG4/2rF83OTF577bZP4a+ljRoZlbvx
 9D//dDV4jEPQ/zebsE5/8mbfYpXfMat68oLyjy4gBAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The scan walks a contiguous LUN range, so units that a bus places outside
it stay unreachable. UFS puts its well known units at 0x80 and above, far
past the ordinary maximum of 0x7f.

Let a controller list such units separately and probe them once the
ordinary range is done, so that block devices already created keep the
device numbers they had.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi.c | 16 +++++++++++++++-
 include/scsi.h      |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index a60843e505ea..b169552860e9 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -685,6 +685,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 	int ret;
 	int i;
 	int lun;
+	int j;
 
 	/* probe SCSI controller driver */
 	ret = device_probe(dev);
@@ -694,10 +695,23 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 	/* Get controller plat */
 	uc_plat = dev_get_uclass_plat(dev);
 
-	for (i = 0; i < uc_plat->max_id; i++)
+	for (i = 0; i < uc_plat->max_id; i++) {
 		for (lun = 0; lun < uc_plat->max_lun; lun++)
 			do_scsi_scan_one(dev, i, lun, false, verbose);
 
+		if (!uc_plat->wluns)
+			continue;
+
+		/*
+		 * Well known units live outside the ordinary LUN range, and
+		 * are scanned last so that they do not shift the device
+		 * numbers of the units before them.
+		 */
+		for (j = 0; j < uc_plat->wlun_count; j++)
+			do_scsi_scan_one(dev, i, uc_plat->wluns[j], true,
+					 verbose);
+	}
+
 	return 0;
 }
 
diff --git a/include/scsi.h b/include/scsi.h
index 72fb6e4bd90d..fea2d0152098 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -269,12 +269,16 @@ struct __packed scsi_write10_req {
  * @max_lun: Maximum number of logical units
  * @max_id: Maximum number of target ids
  * @max_bytes_per_req: Maximum number of bytes per read/write request
+ * @wluns: Well known logical units to scan on top of 0..@max_lun - 1, or NULL
+ * @wlun_count: Number of entries in @wluns
  */
 struct scsi_plat {
 	unsigned long base;
 	unsigned long max_lun;
 	unsigned long max_id;
 	unsigned long max_bytes_per_req;
+	const u8 *wluns;
+	int wlun_count;
 };
 
 /* Operations for SCSI */

-- 
2.55.0

