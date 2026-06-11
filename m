Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE5CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 05:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75675841C2;
	Thu, 11 Jun 2026 06:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mediastek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mediastek-com.20251104.gappssmtp.com header.i=@mediastek-com.20251104.gappssmtp.com header.b="SMpXTAFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE3F849A3; Thu, 11 Jun 2026 05:07:24 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392C484996
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mediastek.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=cobenhan@mediastek.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8421f0e9c5bso3455276b3a.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediastek-com.20251104.gappssmtp.com; s=20251104; t=1781147241; x=1781752041;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gGRSoo7/XaPbo41RyBaFq6d+nnfatEdF/HQ4viYH6II=;
 b=SMpXTAFRhG45XvOs+VGZAG2ppa2RiUO+aPyqBRMwEgoyVy+nVafV4NS+B4InYm7RR5
 aK1xFqADaJwPBMjNvTcrT2NDYm5M3lEmkVaUDPcQ6p8SecPJsvRL1Rjs390gr1brd9aA
 +JXeXTyG3KRVFAyKvXTG/FJxel/7avVr6R/+cZNjf3GJKvnnn6kMvv6MRufgtXy/RFGD
 jGokn7SCM4H4V8PO456kFBbck6VLzO1uWOMc9Is8Lneh8zX/wgT/JM305iJ2mpdWyP+o
 exDKZ4yWEtw4sQDJT7Pmlz/zJ+OjWKTMDIn0VHDGjDIW80lmrTeXDLtr7K7DbghVlkcR
 hzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781147241; x=1781752041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGRSoo7/XaPbo41RyBaFq6d+nnfatEdF/HQ4viYH6II=;
 b=bIXzo2nWp8PMRSPLYoU1rQYofrH5QJm+WBDV3EvrUL02E8PI6bqO8nYMF9sgRvhgjU
 zKs8aBYNSE5LwC1c9eRxxVC711W1jZv2tLD13CyqDt6k11aVSsE+GkcwqeMsMdkRmdUO
 A7DpenfYlxZt5aHhsfG5+3xOAocRv40C7tw3dgcDbAed37M66QVfR0Wz/YR/nD5mkOz/
 +/Ndd+YTLkBx1sVBWgTyH8p49uaP6jxyjfbXH8oOTgS800RDTiIKRwJ9jjTPf5OuSr9D
 oLscO6XF7LeG9VZhZ744HqZAyuZQYNf97oMnxJbw9nf+9zPTos6CkQLViRo3SvgHZt8W
 vvkA==
X-Gm-Message-State: AOJu0YzCmMhTOjvOwWL0hba/4X6KMEprgSI+lAHq5cfyKD8EZoKoiaDT
 Po/fLgJ4V6eG/u9cPHxMFrRH3BmZrugJ9tCi+lu3XMPjyLGzG6BThrri+v8P/aX2Jc+lYaZR3J3
 PAS5t0z8=
X-Gm-Gg: Acq92OGh17Q+wpMGhUMmyOO1kOYshe/1cJArXdsWmaixbiwgTFRb7fDaTNmicjX2dq2
 BS+SpKOVqRfeL9a7zef8/nNKK9kLCKjr64jva+t6U4AxUEPdBoFFGUD9xTzimeSoRJxbpsp4xc8
 r21khEnoQMLq2+4bKpHowk5/BEa2xpTmJy4bfIxd5XsQBGJ3amNK8ZcFSm5LVtj5LNxr+nozeMn
 QEljngkpGbxuAszCgk9SDmQUTnCuPJqBE0fuCP18yV7qzbUSCksqoQsCCXK4C41VtPli/IFPFys
 GV5/Rq9JqLFsFBrgbUf714ThUvx5/nhgWu0iMdAJQ7E5t9YH5fq8+XOvDzuWYdRp5zT4Kyuy72w
 T2q1rwVCeR8qWECZ4TChGx6USrYkLWuJggeKh4BHez3zvg2t1QMoKequJqCHifjnowrDORj2mPj
 b1/Y7R75PdG2yZxYSERtg2s2Wl0tMY3H/TwausQbGeDsUXmZEi
X-Received: by 2002:a05:6a00:3a09:b0:83e:f208:b113 with SMTP id
 d2e1a72fcca58-843367eb346mr868608b3a.7.1781147240660; 
 Wed, 10 Jun 2026 20:07:20 -0700 (PDT)
Received: from localhost.localdomain ([112.170.45.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-843383197f2sm275305b3a.54.2026.06.10.20.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 20:07:20 -0700 (PDT)
From: Coben Han <cobenhan@mediastek.com>
To: u-boot@lists.denx.de
Cc: hs@nabladev.com, trini@konsulko.com, cobenhan@mediastek.com,
 wojciech.szamocki@nokia.com, bigunclemax@gmail.com, peng.fan@nxp.com
Subject: [PATCH v2] i2c: designware: fix i2c probe error
Date: Thu, 11 Jun 2026 12:06:46 +0900
Message-Id: <20260611030646.894441-1-cobenhan@mediastek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 06:59:54 +0200
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

Probing i2c slave device just needs its device address.

A certain type of chipsets such as RTC S35390A have no offset,
which means address length should be 0.

But the current designware_i2c_probe_chip function requires
offset 0 and its length 1.

This causes the designware-i2c to be initialized again and again.

Furthermore, after booting into kernel, the designware-i2c kernel
driver complains its controller timeout.

This patch fixes this misbehaviour in such way that  only device
address is issued, no reinitialization needs when target device
not detected, the designware-i2c kernel driver continues working.

Signed-off-by: Coben Han <cobenhan@mediastek.com>
---

Changes in v2:
- use the return value of i2c_wait_for_bb in error case
---
 drivers/i2c/designware_i2c.c | 44 ++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 8ad716f410e..8d290acefda 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -740,13 +740,47 @@ static int designware_i2c_probe_chip(struct udevice *bus, uint chip_addr,
 {
 	struct dw_i2c *i2c = dev_get_priv(bus);
 	struct i2c_regs *i2c_base = i2c->regs;
-	u32 tmp;
-	int ret;
+	u32 start_time, ic_status;
+	int ret = 0;
 
-	/* Try to read the first location of the chip */
-	ret = __dw_i2c_read(i2c_base, chip_addr, 0, 1, (uchar *)&tmp, 1);
+	ret = i2c_wait_for_bb(i2c_base);
 	if (ret)
-		__dw_i2c_init(i2c_base, 0, 0);
+		return ret;
+
+	dw_i2c_enable(i2c_base, false);
+	writel(chip_addr, &i2c_base->ic_tar);
+	dw_i2c_enable(i2c_base, true);
+
+	writel(IC_STOP, &i2c_base->ic_cmd_data);
+
+	start_time = get_timer(0);
+	while (1) {
+		ic_status = readl(&i2c_base->ic_status);
+
+		if ((ic_status & IC_STATUS_TFE) && !(ic_status & IC_STATUS_MA))
+			break;
+
+		if (readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT) {
+			readl(&i2c_base->ic_clr_tx_abrt);
+			ret = -EREMOTEIO;
+			break;
+		}
+
+		if (get_timer(start_time) > I2C_BYTE_TO) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+
+	start_time = get_timer(0);
+	while (1) {
+		if ((readl(&i2c_base->ic_raw_intr_stat) & IC_STOP_DET)) {
+			readl(&i2c_base->ic_clr_stop_det);
+			break;
+		} else if (get_timer(start_time) > I2C_STOPDET_TO) {
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.34.1

