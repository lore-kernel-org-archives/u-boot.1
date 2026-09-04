Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99617C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65C6160BEC;
	Fri,  4 Sep 2026 07:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9amKkHaCgqU; Fri,  4 Sep 2026 07:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9271A60BB5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788506004;
	b=mx3BeDrfKvWdwAmF4tnFZBv220Z2Wv1lOfxsp/4GYZhgvbBry7Mv6/GU9njWt+4RE+hC
	 mTEZbSfGPV+hBnjgG7XQ5yUuuqVEQQcEcTwVfsEIKrAGsmMK19+eGPnVwCI0jX7fuDVZ/
	 v0jikjEjhXLU4IPi6Pn1yjjvWAPrT8meuHyGoUGlzd2ykYOkt2hIHsbmFkjotU67aj2Nn
	 mutE364rEFS2CT0p24oGWh1bZ78rn/Z0xD7YEeJVZfX97RQA52uHa6i0TMtXdrjdVGwx0
	 yoliWye2AgI+BF1BprsGxg772twdXLN/jxmozJjRDurK4mL9zralI2/GQhRhTtOth/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788506004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4UssnWAXTrBIb0J/zGIYvYxjRyf9bAF/WeW6MWr59HU=;
	b=J1ejGoe3K5bHsZl3DizEhoj8C2QrCmJtLQeCySIrlL7D9oxDtZ34lVD0uSdrfhS/Xs+R
	 5iwnIdL7UYiELm3h1TyWBdub1RFFNhhRzD7qOiwI3FpigqKJRmhCsNbFuv34bf5B3F1fo
	 lVpWgFHZ1JM3RsTH2E5EJ1h+kVv+VCxxjxe5JmdUOmBkNXXVM/J07mpXcvinnAUjbDiG4
	 5iJMONtKPWfy5Aay1BW8WtOibfsK+jasoZj0Z/VQYE93YaRtO1Y1OTNr2CNBkk9DuNTMZ
	 0IgFVg/DXn7ZwDNrPtB6+2ysqeU+6kFPnsOqWXL5bWAJhW9zg1XYKd5/lAD3NagAYEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788506004;
	bh=4UssnWAXTrBIb0J/zGIYvYxjRyf9bAF/WeW6MWr59HU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBcT+1mL6QXEq0mXrjocKEXQmc1xUwpIChcYIM+k/5L0qWD4C5yNFWYFxWwMHeyYx
	 knDbVfNAKKATW5dhJTUdg58/T9YxSoaZqVf/BlRsg+TQhnl+NMFAEzNvX9iWeBk7CG
	 0GoQaNfzyUNa41k30iYxoYnLEfB78VZyRL5yhKDMPj5RPeu5Vc2rMsUb8F5wbK6n7M
	 AE2iX+O7GE/y74lg2Bj9iIxH6+lZyCOBEbRr0plvJrKsk+2n3N4IUo8KbIV//2bsR1
	 LrdZjc2ornj4JLKxxeZ6+pJJek8fWi+lZ/zGip0xfzryHGkMDQacOOaK8QKqK1B0XR
	 PpzFiF3gzPS7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9271A60BB5;
	Fri,  4 Sep 2026 07:13:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E50232FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E28AB40B78
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpOhlGKdhe4G for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E6E0740B5E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788506002;
 b=BwbKW9A8QVNQiZUSyg/i3KfhpRUkIPBC4QNRqHm1e6lGwiifbABDpii9/EE0OWVx5Ned
 aU72wDZ/Ue9S++yHZPZaVu4FwO6XXzpYr6XlEBhUs+PA7j3SC5Kmi/YIWEpGZ09rAb2yo
 iRAsC9m95EG54uJfLS/MXiThnZ01KZqghOH7BLQgpbLJM+Rq9mp1HLcOxpX1zfzs08TZ8
 QX4mGq+NxI2+7H0BLRppu/qtp+1kwz9j7TY7lgh2gunmIE7LDkqFc5D1N7XS6Tgmj9pLq
 6YcA1f7tQKH52Q1R3a0Oqwvw8hhmOdmas2uBPIxQQMg5sLCdh6DrqM6Agv3xmawAYKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788506002;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=4UssnWAXTrBIb0J/zGIYvYxjRyf9bAF/WeW6MWr59HU=;
 b=fObe68RC7V1ZFN0OJDKzEF8br7Mxw0vgsRnZqGshmaL2FSq5giYbLBkQUNAQkY+YVnQz
 tBlRIA+ecJcTmoTHQSwIJoC36KRazlGA3i+E8NMWEEnquQr+Ekpqwj5hvpHzT/39jkkPO
 GeIp1gqq5gu+WjR6EIjyfldrf8wqhPl2kM2q8GWDnm6rsy29/buZ6eNtR6gYmr0KTAnbC
 32lXVvixZ+lOo9erWmm+umdFZv+88j+xgi+U2268u0d7faxOuy6weKfiOqdinPiZFiZLm
 Dd6OKuSm3o3by4bR1BW+j/vqn1nZWTnVczMkXBmnatBLks4S9qLvBil4b623CQPViEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=KHHNjFCh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=KHHNjFCh
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6E0740B5E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4858595f997so403368f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505999; x=1789110799;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4UssnWAXTrBIb0J/zGIYvYxjRyf9bAF/WeW6MWr59HU=;
 b=KHHNjFChFoM7m5swq4WOr/L8oWd9zZGMTUp8MsLjvXGhePZ5bozDomrm54Hcv2/MkE
 6vOK6JMosSDVMwrq9kV3iaPpN9Y5ziZifpcqFoxGrirMVrLuPBalTjmv5hF7hwygfXng
 KVDeWu16DnNvCpWJ5D3uXnVAxisy8JtpczK9uYBZPQ/QIRYzOlZWuJtx8HxmcZoOHMOl
 tU8W23aS03o6EY2T5dzZ0w/GLpCRwX5UxjzikcEi7FLJjxq0vmcY4h8/M+0EiF5F+ug0
 xdcdu4OwMv+LAXcPI87A1ooSOPSgHQZ4OygHOe2gajnbegIWwqY2pik4lRzgfKux7nHc
 Jjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505999; x=1789110799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4UssnWAXTrBIb0J/zGIYvYxjRyf9bAF/WeW6MWr59HU=;
 b=PQT+kig38nKImIrFsri+hkMvcPae0/13Rc6GEhIwzgAGzlHv68ygRnJw9v+t8H9kcf
 8cHKxipdI39K0sSrBHvN6EYWtVrBr4UzhQ5D3cntWObyBLN5uKiQ76jmiyTunN4+Dj+a
 zspnY4RN4R13A3OGCOmHRQJRLV2oIDVWVyAsTeZzXPIRHYS5/j7jATgAmeLnBdg05zHe
 t9eYf8xce4LSll2swEIUQbequ8iUJ/p4H+2lFhJuV1K8PDqsmIRWaC9tilPm90sGMwGN
 PzRc5LglDPNLqV2BuxZt3F66l+A8HnV+atexxe+/H0IcC7WlnAiVkoFZ3s2VIFudiyzm
 NkqQ==
X-Gm-Message-State: AFuF++m7FG7Oq4VCKz0x6zXbDSFtqVE8w4QhFYp21htaFaE6bUcdSr1U
 BRvWZ/FhHxaXY88iABXm2lPoUp7GX9l5zfn0ZjTRQt9HvLNmd73rQ8TzK1mp2IC2zZw=
X-Gm-Gg: AYBFou0Yh0fCyNTvbVO2kb7yD3MkSo7P1d/Y6DsOOp5bkGPefIW+d3GnqoBhW5air1f
 XKZGdw7Z8DD7dGoPfRxUwjM4PA8GIkzaYzJeiO6G8gdUaxx9T1sbpiCnRzQFN97ct59aGdzv6S1
 Coovl9Qaf7UxZ+waawh+u980CTiBPUNZob4yELcuTY5xi4jIodYaK4+nrD9R173tuvzSZkZHNId
 fJcQppV5/Rosw7MM0jflE45C4UCC7FI+ArRXnsGDWfxAvbUThl8MvEftYX8ereKRCdErBWuzs/Q
 uiABrtnogCJvVMeluxWrYeUg0MP9E2qNxtZ5ryAQ6YZJ+90mnDm2Z3x4vkYzrOD5fiurGW8RaFK
 BDXpmBmWkuqjMqXSrBbvW4omwSGku+zu7PXhD1ZJQizprOwf6JioRiBZZLkKqypKjYOC42azjZn
 PsvCK+SzoMfVM3j6ohS8zpksmlCvPM848fszD+pnmtPrCFjyFsBfxmRNDON1M3IBiB5YuRhsxRw
 Acd61/pfU1TWud66PqJtiNUctVwD515GGYzwtWtGaFIbQRIej2FiQ==
X-Received: by 2002:adf:e00f:0:10b0:484:47a4:ae60 with SMTP id
 ffacd0b85a97d-48587046862mr5726259f8f.3.1788505999252; 
 Fri, 04 Sep 2026 00:13:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:43 +0400
Subject: [PATCH 08/10] ufs: report the logical unit the boot W-LU presents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-8-59aeea16c4de@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/YJvaFH84xe0zWPre7xLCDD94ZIiYvuOSF4iZK4wmxU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi+apPjH7lCytOBhqynqUxgqUzZnpt+6e1vviM6Fz
 4aeqa+/dkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVT2oZ/sorLGX2/VMle6+KYXbVxMK1X+oE57M4frRpmeTCOu9b6XmGf1p6/6c
 d9l4p/uVxbOa0eYkvv/JzZXJn9lzhmMvBeOu8LwsA
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

The boot W-LU carries the medium of whichever boot logical unit bBootLunEn
selects, and describes none of its own, so the SCSI scan cannot size it.
Resolve the attribute against each unit descriptor's bBootLunID to say
which unit that is.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/ufs-uclass.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h        | 28 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index acaecfa1e341..da0d6f01146a 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2293,6 +2293,49 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	return 0;
 }
 
+/**
+ * ufs_scsi_wlun_alias - find the logical unit the boot W-LU presents
+ *
+ * The boot W-LU stands in for whichever of the two boot logical units
+ * bBootLunEn selects, and reports no medium of its own. Report that unit so
+ * that its geometry can be borrowed.
+ */
+static int ufs_scsi_wlun_alias(struct udevice *scsi_dev, int lun)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u32 boot_lun_en;
+	u8 boot_lun_id;
+	int err, i;
+
+	if (lun != UFS_UPIU_BOOT_WLUN)
+		return -ENOENT;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0,
+				      &boot_lun_en);
+	if (err)
+		return err;
+
+	/* Booting is turned off, so the boot W-LU stands in for nothing */
+	if (boot_lun_en == UFS_BOOT_LUN_DISABLED)
+		return -ENOENT;
+
+	for (i = 0; i < UFS_MAX_LUNS; i++) {
+		err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, i,
+					     UNIT_DESC_PARAM_BOOT_LUN_ID,
+					     &boot_lun_id, 1);
+		if (err)
+			continue;
+
+		if (boot_lun_id == boot_lun_en)
+			return i;
+	}
+
+	dev_err(hba->dev, "No logical unit carries boot LU %u\n", boot_lun_en);
+
+	return -ENOENT;
+}
+
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
 {
@@ -2315,6 +2358,7 @@ static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffe
 
 static struct scsi_ops ufs_ops = {
 	.exec		= ufs_scsi_exec,
+	.wlun_alias	= ufs_scsi_wlun_alias,
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	.buffer_aligned	= ufs_scsi_buffer_aligned,
 #endif	/* CONFIG_BOUNCE_BUFFER */
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce71..7c3c26e009b1 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -396,6 +396,34 @@ enum device_desc_param {
 	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
 };
 
+/* Unit descriptor parameters offsets in bytes */
+enum unit_desc_param {
+	UNIT_DESC_PARAM_LEN			= 0x0,
+	UNIT_DESC_PARAM_TYPE			= 0x1,
+	UNIT_DESC_PARAM_UNIT_INDEX		= 0x2,
+	UNIT_DESC_PARAM_LU_ENABLE		= 0x3,
+	UNIT_DESC_PARAM_BOOT_LUN_ID		= 0x4,
+	UNIT_DESC_PARAM_LU_WR_PROTECT		= 0x5,
+	UNIT_DESC_PARAM_LU_Q_DEPTH		= 0x6,
+	UNIT_DESC_PARAM_PSA_SENSITIVE		= 0x7,
+	UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
+	UNIT_DESC_PARAM_DATA_RELIABILITY	= 0x9,
+	UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
+	UNIT_DESC_PARAM_LOGICAL_BLK_COUNT	= 0xB,
+	UNIT_DESC_PARAM_ERASE_BLK_SIZE		= 0x13,
+	UNIT_DESC_PARAM_PROVISIONING_TYPE	= 0x17,
+	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
+	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
+	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
+};
+
+/* Value of bBootLunEn, and of bBootLunID in the unit descriptor */
+enum ufs_boot_lun_id {
+	UFS_BOOT_LUN_DISABLED			= 0x0,
+	UFS_BOOT_LUN_A				= 0x1,
+	UFS_BOOT_LUN_B				= 0x2,
+};
+
 struct ufs_hba;
 
 enum {

-- 
2.54.0

