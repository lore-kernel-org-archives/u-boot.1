Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAB0C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D995B60BB6;
	Fri,  4 Sep 2026 07:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vxRdJgKYKaNI; Fri,  4 Sep 2026 07:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D0D8C60BBE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505997;
	b=B2yYhIelUT323JceLV7d1NEA62YYy/Z5oMCV49be9zuI8BR7YnhwOhrXOMvNcxF49Xfk
	 US4EI54ApyRWP16G/MsXiDVvSoows7tcMjOtGmGez1aq9+lTseT0WeI/2p11vIaAHOwC2
	 rl5NntsHdBR3Q5NKTi1KdxkVaPydnCddAzYdyWAxqL9wN2PmzT9/nfrCfA5KTxOB0qa3o
	 GQIZIDO/N6NgwsFAy2m16yH8y0nb+/c6obz4ywk671gxrk/bMnZYN8MKs470V/a0DwC2G
	 MwFxon76GNjVFRBnxUTuosU+EVFwtLtqd6LiJTuQ9c/gPLohVHZ0RiD1+H8JvoFcw5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tTSW8WMNLRgKbEQyMFjrbCZPcyWf29W1PpfI/o7Fp+M=;
	b=F5X79KxJZC5yScPR+GwUhT9KFtmSKHoilHZDtPUGT6F2MOfBOhY17ypDOYKCWO2uOYjy
	 Us+C4TgkFz9sE4zlHaKi9x2aXovwqupD+W7XAl38EfMHNgNJxDPU5CcKpj+Jalh+3yHnw
	 f+yRdOX2PVbtjTEfcMeXJEeJCi3i0GgcFU4jtsEyGOu4Onh/jzF/Z8uIX1yqAVIcH59u0
	 CW/tVv/3CtzyotMVCpf/V3/PPm85/bOVPv5h0C2b1e7AkxZIG8vblo1WRSKpmUJAAng0f
	 ioEHloV6hFSelRx6XGVWyOAKWZoAI1os9+hMdK6oCGwwIUJZ/rkijzBB1FAJcZZck+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505996;
	bh=tTSW8WMNLRgKbEQyMFjrbCZPcyWf29W1PpfI/o7Fp+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RBHR8EnR4xMuCwOcOnzw4NXB3m10ghwCET0ttYYSLbmcpeKSW0+t5blhEtrYKtok0
	 ae3Kbyp9RO+bKTDrIEYYQO+kfQpMCI8WGR+fp7KXrBm8+9voUhs9EzFUPWvY1Im4vL
	 3rAlEyI7YZdNq6m+2VqvUP/Bbv8myWZLA90s951qpFfCKo5uo+Kky/NEUAI1DBLpif
	 4MgKmBDCu4ko8JbDGB22MvBrpspJsDWLVE3sQd/VBcS7JQdmTpC+tpYg1SwM6lq8LM
	 hPZ5hpaNTswS1/K5AAm6GH5suUIltZUxcHiaYQLidyJN4xDBr4vdHrFL7iiXExGXq0
	 QyQ+St8D1wcJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0D8C60BBE;
	Fri,  4 Sep 2026 07:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E16DB2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F70E8116D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZhOgqy8AxDf for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BAB828116C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505994;
 b=nTqNh8QbP7UH9QHJjqJ3zjAwpDJ9gTRKfhdwzRWwe2tviwssT7aNqj9BmDgK85+SAhe7
 yPIVZPADWJjly4nC0enD/88tA5vhIdm0cZDZkqRBMvWgmeROBPQxBDLmRu+oLenrBffD2
 fDTgxyp1cs0SS6jhpv/vgp2sPmqkQHE9Y/aJVhFHjlGZsASr85VPjigoIuL92CQPSRthj
 cQp1DhuISJQFwyuP5X/ckKWkUrFlDKoUx18H9lC6Zd8exh7sJ4vqTO36zdDnPdE5t07fy
 ovnxVULpqkqDBuJ9WrhsiahYExPHF9RjQ9lm2dWyV2L1AmXC6Qnz39WETgdJhmvIinQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tTSW8WMNLRgKbEQyMFjrbCZPcyWf29W1PpfI/o7Fp+M=;
 b=hjNhVPce58Gxm4DRDL8UnkS5EZG4xPUHtavRzsCLAr/gtAa4psP1gaDvH7fZ1uKwOKFR
 Pi8g+0oBTws+lCr9Gxt5OaDYNc8HDA6kf51vkeJOD4vOEDhTTVupL/nflbMqJ/D4lC5c3
 L0YqeoOaYIKxAO2Ci7Z6qyUtqDtlvDyKgsZqCx78E0Ph1fTUS7r9Z40ox9VAVK2YCeM19
 ulyxIuu8fcSzwO0V9lM71nl98zgTLz1GvufluhL9HcKo3BR4AtqZP5AliYX8GWQCn9shS
 EDaKkC/Iy5y+mHiReFjc5pXOCwS9ASjuHiqP5kU75rfJJIWebtWu1RM/Iu6rAEoY7Dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=BgsxTjCe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=BgsxTjCe
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAB828116C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:12 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so427102f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505990; x=1789110790;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTSW8WMNLRgKbEQyMFjrbCZPcyWf29W1PpfI/o7Fp+M=;
 b=BgsxTjCeEpO05vtw5nWkgtV6xWPexPo0LhBOA+QBEUZekSYFCEjF5ZFRHz322Zbyf5
 ipzNwpxYp6QC4G9rK0kdhlCcFD0cP61UG5we+EfHs/7H+j8xCY7CfiHF+R0qbeV6VsSC
 5ZafbHLDlB62EXCIXnqRwc/iZF2cNtwQay2jMpNyhcqOX4xNbzBtO8NhiHjWeqXY9Fxh
 yBaCcddHo5r7ykWcjo61VFrjqdGxBZQ7KHvQaPzTCmBmG8iM5vJuOneF/sS8KrGO2fTt
 HlUQqfLrGCLqiRhT0fIGsyZ3+fnhIveGksUAnc5avfhTNrcwewOlaM79R0gKjVNv6IC8
 Dv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505990; x=1789110790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tTSW8WMNLRgKbEQyMFjrbCZPcyWf29W1PpfI/o7Fp+M=;
 b=La/kjf/qdYtGgHznScWsplPBJTDVxiCWHc+u/+xiiRwGxWdYwU2i6K851HASS1VOw7
 5vrijDiCqTRZZCRG0RAclff8MkPh0h2oHV7A5w15j69THJ4uaf0g7zPxSD3qumk3mO9K
 r7f1XgwJ2z0G0xxf5niiZVLUqRkU7vFhR+MNcTi6s3dKmHjRWFHvdFiqAw36t5w4bWQv
 t9VCkd8fKI57pUKZeMtpSWSLGpIbmmUVe5OKJKh88fvbVGQM+sgCDV9tkwWW5XVWpMB0
 73dvEwRxCnoJ/acsJK/hYoKoYCk0INA4LCFC8Um47YT/VXZY83PFkNkcQ3nTCX0UTwOr
 AlIg==
X-Gm-Message-State: AFuF++miJDqduBdxCVCWBFTPxyvNN8y9ie1S/yo0MJ9KDyuqWK3ukKE+
 syM55G2OJmvEbSwYU2X2QisNHzyIUdBs82ccgMQ9me01ee+gMBMm0cHtRbH7Q/nM64U=
X-Gm-Gg: AYBFou0SAlH+4OmHnFRX9WN1103R++9D9+qK/pfHscKUwZHEd3Qi0VCEufSOzpoZjOs
 0l+2adfH7CQbiBEd98rgqv5wjJ89Z8uJhTg0llZDA3rNqbBfWiN73qXsRTCBYORwGZANHX+8UeS
 p2Qj20lpzDsbvoNkmogLhRfFkGAbjK20M0k00iaWgoSx/gqCsYBrTAYLhdG95Z3GFfp6BeM2Ojg
 RroyrOokb/aWvY611JsevvqqI9VWI8t0YJUZKsBvviuWJtZeKbxm0ZcfyyAHK3Ye6wMK2+sGaej
 eAhROFnX2DDdT/uZV3Fyo6PLE24ZZ/OyMOo0OhdCFx3rNyHxLtSjcxi/hPWxQd55BF9A7ugB3u9
 dVhcS0lituK6u4psf6XlRpGMSHjMxrD4AbxonTdg15gsWAv1/+W8BE29/OaFWMn2Y+reE+utmFU
 elf2fVA4giGpXMsSEnakbEs4U3ZXpFP0WhkWIoDuA8DzCRyhPu1XqWZwShwKsYB/avQv8z4hp2O
 LvbSGCp+ZK2Tt/EGsS01f9RAsIKptg5gW0ox5uG
X-Received: by 2002:a05:6000:612:b0:485:8a47:5b89 with SMTP id
 ffacd0b85a97d-4858a475d2bmr2257782f8f.38.1788505988490; 
 Fri, 04 Sep 2026 00:13:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:07 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:40 +0400
Subject: [PATCH 05/10] scsi: add a lookup by target and LUN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-5-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
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
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=alchark@flipper.net;
 h=from:subject:message-id; bh=HHOTmdsqSGCqte6ukxh1qE+PxmBmeqRM2SlxemHbZO8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi/6qSLP19m1bOVt30nspn73Zl2U94jcsUHwV/6SW
 01TVkRUdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVydcZGea0Ly543JY3K0NFxFvpePiPTRPeFnDo+xwve7k4seD3l20M/2zv6ZS
 zt74xbfPbXVpqv7e2PSYiRln65/KEnYVLz0bqcQAA
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
2.54.0

