Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E098C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 321F160C1F;
	Fri, 18 Sep 2026 06:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDs37fcfbkWf; Fri, 18 Sep 2026 06:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5D5DB60BEA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713383;
	b=oVcqX2hmd/pJweYIo/gBhMRxsh/MR2b4XcnCFwVB0e/o+aG3DUYuLx2C6ajv6R7dtlDp
	 VB4B3p1SFO7EjY+x5ATh47twdtpkvFvjvnPGsdHRLM9xsjLPVgBZ0QVJi6QmkUJLfyU7h
	 W1IQYvVkfR+i8KhzsZsBJzCQ63VSXUrsQl+TDeXjHZ/jZW5UrAx63ZZWSaXjp82TmFMRH
	 11/e8WonB3h+3ph4TOphJ/cgOY42j2jtQsSn4OBkLxx53WnR1WmDc5iQYIDPnnFICs9oE
	 92mfe6uzsF7WBg68x9rt2bU4UKVQfLQeGGtPXYWAHHLkBMFAiOW6zgcDaI3P3781iyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+rje0igRZUu7SHFNAn++pFcsL6ba/txQ13ku9r3CMW4=;
	b=hq/sM++1yXFwwVQIYWauG1yARfqNXp5/q1YofxLI+6tiUHUitFq0Tz6mHU/kpS1DaT7e
	 bl+GuU3cfSLM3Fbmhn5kBlNhQIUwJVbl6hEqtp+hTw7nJuyW5R82bME7ju3rda2E1K1IP
	 VgXCgESmOgutYCGiCQZWHDqLCPX/1TdNX71ekFAJoABbWczKvUQEtkbmmpqntWHisudCo
	 QSromtSQgcGiV1dUzf7GtzKQjBYpAWH88UpZJQbJGgSqsbzAgzsXMMuYm4grEaq9QlhVi
	 af99km1hagSi+D7+93n+PeGuzlg8DB9MZjdB3MTV5Jl4yQrVN9ktM4i2mHmpBdN7b9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713383;
	bh=+rje0igRZUu7SHFNAn++pFcsL6ba/txQ13ku9r3CMW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCL0ptvOPSaZ0/necWo6aJnvDHM9P14ruHynsOvPxBf4zyX6PwF+5RcaxR95HEPOb
	 c7OlPfKPkrlrrYGlhTYyysIEPGXKnwE6rUkZ16J3ENAjLHsEX+e0nxjd91ganoQCtR
	 Y2zaJC8LgeUkWGjYYzi6NkABp0BzujsdnbBHSRvesQLz8dGwMJtkD2EnqKjxfdXUe7
	 WMXatn+NC8Q9wNw+0tJ8ld2c/eyop/QABUxERA/T4/WZxj7lVWqlx75CBk9AQKuBnU
	 AaJfFYCnTgJ2xS4Wt4g0fLYqIZYXRXjw+IC0WUtMmUlZ+PPgvaUhA11a6Jw1LxForQ
	 d64MH/9TQJ+zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D5DB60BEA;
	Fri, 18 Sep 2026 06:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B508813D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6C16404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id du5FEivcvXSi for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BC367400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713382;
 b=olizPwyqCofgDJKdqImWUtjdAuCnyAQYtZa9h07CXFjP9HtXxblbLj2No3hPcSUY+nX3
 EqNY38KDUC7/yqouOdMasslrMF2IqMl+YgfNT3IdqRB9ytFZFewvi//IteS45Rvqly6HH
 W2x/P57iPjuT0zu/epK8nRfUELdc1udJWrnqNhe9DyaYsBeeRJhBeHB90PdGmPyMO0Xah
 Cn62Se2G2iDakFMDkT+1VvDnwESBUNb7/O2g9F2OTTfJjXkiSOH7ZQVWQI9RmVA65kHNe
 +vkKO1SfO0t5XIspxxftsa2R7SPmfdafKfUnK3miUvVhywn3RdEx6ZX8qPtwbG1Q+kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713382;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+rje0igRZUu7SHFNAn++pFcsL6ba/txQ13ku9r3CMW4=;
 b=pETKaSoyY9NnO69PhD79qUEBWYSFT/L/9QNLlrSJzeOeoVQu1HKqtYnbbAXJbMvX99Td
 gdBefRiA72cltqDRICp2XWmnVa6JH81sgvalsfm88l+xcfa8f4Z6uo4RdctS+WxK8tvp8
 ctMR8757lmvB28Zs4CtKeWMLgf8GFkPsJ3vAFXDb8+PP6uhNGEKvT1XQV5/6WZ1mjw3zI
 RFwMNvXYCBxUv/bDUVy+m9O0/O7aCLt9psdKDHrXu6p13AGW1rQrQ1CPNXcar0OCRsqq0
 C+Y5okacwGfNOtCFIWRkorLtlHg61z960fLQswNc1WTPolyyVnUtuKjsD6eHjuZX/jQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=5b2y1SUG; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=5b2y1SUG
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC367400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:21 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so1736445e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713379; x=1790318179;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+rje0igRZUu7SHFNAn++pFcsL6ba/txQ13ku9r3CMW4=;
 b=5b2y1SUGdeouDiLR9I2r5UymDwJS6YayWJNtJw4za22uXJ3G0KiArcirpdKBRWyLzb
 JMODU9MrcJMAbC+J2lXHBNZgc2jVVw2nGJfiQWP4Fkkjc5Cywlv85kvxvIklNDOFEWXD
 +LR5b7brYXMigpLkgWMclXH56Y/mufcFGiAEyLS6eTs+h07Q8FmXC8S6N/Djczt8bctP
 pHNWzKIGM307qMc3/S9eWsJeIesOWxDx1Tzva34ODP+cgH4uqmm3lQt+/zWOQSyZKXaY
 tONjl/f8zjJSbwjW7xfUe3O7mnB0mXeBb0yiTdI4ohlD4F0OMgUj3sABH7r/dtud+Zia
 SL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713379; x=1790318179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+rje0igRZUu7SHFNAn++pFcsL6ba/txQ13ku9r3CMW4=;
 b=l3XpU0OHTQtMJ/TSHLL7wXHFCB7KM7Ms1XFBwEgIjA/B8kY2XZxbhogywePGo2/l8K
 96xZG/tVbCP2z7wJQdL9k/DliiHZmUirggFplVccvAUIYgh6CZtGlXqQrAMpkLa/zbDG
 X2tQcY6gEFhJXnuSWSbm8zJey50hgmKfZ1ZrS0/a47sWrj1ELE83z+Xxyk1u+q1Ae9Ry
 YvgQuO6HTXISixZPoV/PWDN/Fzqax7VXhCRQVAdTkToArPn60MparCGhUJeyAN6bVD13
 dKb5ZuKopYx4K2vdW0gwx03cfw7ZeD0R8NifEQ4VndY4SDW+RowiCY9E/fm+L/HpW3Dc
 4TOw==
X-Gm-Message-State: AFuF++niAAtF+8Zwp/KlHcLgv93aDKx0z8pwzqJttA2ViK1koI6jcvSO
 iirxvJnShQLbysh8QouIpWv/ZiA+G6g/1MzmVhkaAZUiqttUYxOFPyuS+x8r/ogf814=
X-Gm-Gg: AYBFou3D3Y7Fx0mmAkA9CbFUreBAzxy9sq6BIXl7NCbnMN44aPgukCNxsYcYvp+rood
 p1Jt5ZIC1rnzOJxGOhBfehdVgM6RFEh9XqkRwjNRe037gWdlzdbgxktl4tbFFUIXLA3y9eXdMRC
 FQsKnJkWBBeU+ddwYTnAU9TDb4rmQzVwD/+X2YGG7gEoVPc3n8SYbM0AZErSNrYlefR1DoS4/Of
 dO3Ukvc570J0PjV3I9Uwo7262fxNj8p0iA64+ITcPTMdf3co7rgrtneKr6VIylJ4CKbbHmMKVlU
 XdQQE2B0yDAl930GOt7/0R8hzWTpGMpH/jqAL+DjPV8mlCZfna9U2IKY9Eqyb+SoVIuvhliq2aL
 e5hDyRQqJtK9zwII9V7KSZZr6cG/Fo/tzgeTww6dmZm4b9SsRbwzdPfoma5NE6HseaUu0IFfQuc
 XiG4ipLw0n8rSMxeClUg2ASjJD5aX6I5qsAJ9LvQHpFh27kMbrEsEoShmc3BbbPZRckOXxaD+OV
 YF7FLIKhsSCsFclUaQrQfvFw32FyGYVVMrQDHvm/wCp587O600=
X-Received: by 2002:a05:600c:4e42:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49fc4f85e54mr19915825e9.6.1789713379071; 
 Thu, 17 Sep 2026 23:36:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:46 +0400
Subject: [PATCH v2 05/10] scsi: add a lookup by target and LUN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-5-8a63e372bb6e@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Acde9ebgwzcWMzXC83EsCZfUr5qgP3SmD6SEqo4dlh4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX3x/a5FsdLdihtau6U5JNdY/c4ryr64dc01K7dMA
 8csgVvRHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1iSUjw2n27q0nq0sjYkNEZ0068eMWq4lq60vvi6fDjl/m/TErwJuR4f1zh77
 lb638v2teV9FX+ar56Nbb3/9V3mpNmrp0o7xfJDsA
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

SCSI device numbers are handed out in scan order, so a caller has no
general way to request a particular logical unit without relying on
assumptions on the scan order. Well known units make this worse, since
they are probed after a range whose population varies from device to
device, even though their numbers are by definition well known.

Add a helper to unambiguously look up the block device number for a given
SCSI target number and LUN.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c | 19 +++++++++++++++++++
 include/scsi.h             | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index ca6a16cd8206..30f049c21cc7 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -50,6 +50,25 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_get_blk_by_lun(int target, int lun, struct blk_desc **blk_desc_ptr)
+{
+	struct blk_desc *blk;
+	int i, ret;
+
+	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		if (blk->target == target && blk->lun == lun) {
+			*blk_desc_ptr = blk;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int scsi_wlun_alias(struct udevice *dev, int lun)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index fea2d0152098..a99a179d0f3a 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -395,6 +395,22 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+/**
+ * scsi_get_blk_by_lun() - Look up a SCSI block device by target and LUN
+ *
+ * Unlike the SCSI device number, which is handed out in scan order, the LUN
+ * identifies a unit on the bus. This is the only way to address units that the
+ * scan does not number predictably, such as UFS well known logical units.
+ *
+ * scsi_scan() must have been called before calling this function.
+ *
+ * @target:		Target id the unit sits on
+ * @lun:		Logical unit number to look for
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_get_blk_by_lun(int target, int lun, struct blk_desc **blk_desc_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */

-- 
2.55.0

