Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025F8C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE91160D4B;
	Fri, 18 Sep 2026 06:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuiGJMxEDvpY; Fri, 18 Sep 2026 06:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D52EB60C1C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713394;
	b=NpeUhTQWdMaftBW3+M84NfFPx9euiDt5K5uc7Kv6HQK7qjSlo2aBS0NCojrtgcty6CZT
	 lT7jWKwj93i2pVoje+X0zd//soxhkZDQhRVzlB7sgYnGEQE37QtimVTG/85jr6LCtOUiJ
	 Hbt6ZpA3WOSlg3ARuH4Qs6CoKDMCCDPtC//6nMpYzTjDZmBrJcyMEnt/6FvQMj+l93NhX
	 DrDfLfqBqLHfTKw8zYmPj3g+FpSdZ0ShbK1dapl0cpZ3WKvHV+7xp3r/7m7vhA0sTlkqr
	 x6a6TZrpSBYXFW7ZNDBeWoGcSThsQPHy/MasW139ZEfHvbk6PZUI4n3JkpWFWKQNIDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oYJqH+f6cHMFl6fX78Xi4O6SHeXFAURYM7dDyNr0nyk=;
	b=bE7wL8KJUetW/Egt7hZRY+iPRn4/kX8b/JyN7YzLwvRCsiIWJEpUxk8cg9lvkWltngWm
	 8MrUdSZyu3KMpjmsYmtEaNO2DVWAN5xfP+/fZF+04RUaVqp6zEz5LOkZ2UIJdgYQugZlz
	 RnbRaF+8aghOAPxzs7lg7hbHY9ByDkJxbiyuWuMKWa7mNNUmjFuEGrjKvTYipVC7xAh7a
	 nQgx/rkI9ftbJi+Gh269SEYPv4kQZe7Sgtgs5nflQuyV2HLFjnp+13/0VPg2PONyEqI9O
	 QW+F1oCsw758akbCDat1SJxDimfGi0xoKe2c3KkHJBa8vFcUa6F60tw+k0t7JBv3lwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=xkZVydAA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713394;
	bh=oYJqH+f6cHMFl6fX78Xi4O6SHeXFAURYM7dDyNr0nyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSAXmzPD2yEf36L4CNhGnRond7jHLZVFpC6dKPf5HGkETNh9zZmZO9pSscs7OdvK4
	 fZrsIeg28GPxyc38CESzt/zSN8MCLmhBD4Z2jMzdfZH1Wrn4eVfyCma0pIYMshicSD
	 7F9Xv2NDZBBasCILq970qp9XFgHRSMvlke5sQ51WKefywtunyPzen2kzrrwyhyCCUS
	 uxql+U05587zFC88dfncEdUNtSHU/eFi+NjQpolaXqikbbQMKpedACKoMqnNqndFE9
	 D/YsQlQjTvuwHxOuKWam/yQQAlqMD34SulYvrik5HsQOEQ37etgIeEKUymPsV5ZH9G
	 VDuXpE8uZFY8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D52EB60C1C;
	Fri, 18 Sep 2026 06:36:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 630C329B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4531760C19
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0Jd6j6UiSXl for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3358460BFF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713391;
 b=qKaLvnAe75phrtUVakhKC8J6GebT32oKFN5B1uuabVNT8OHloCUXmNuCOpztLHrBcfm5
 UhCtyl/VptN4fZShKmEWb1XHe0PY3622/TX0skYguWbTvQ5ntjIz3aSoR6f0uMvotr4e8
 4g6/idmAmRXFJbaGBhJKqOR1NjXC1hqefNLGyAsn/BUqSJr7Ix4cH0x9S7mjgONHTwdEq
 WRVAx8OEozXMHN4cz+99kntkjk6Tz7iwtUgktQhYmtARYTqfuUS3weKA1Y4+vp/pMVj6C
 +UOKLxBlMrvd3bYyvGQMukSo3RfsG8OWt/82ScHESEhC9/V7KqWFpnk50C2uY8KbHKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=oYJqH+f6cHMFl6fX78Xi4O6SHeXFAURYM7dDyNr0nyk=;
 b=B035OjEUr6NVlqfw+yZIUS87U7gSQ2dFgOc/3J5wfYj30/vkag16QCe3steRwlul/EWa
 PG4Ab5neogiQECsS/TSJ1WkgAbnnqGxX0d27VvhZgSln3h5oItI3SN3vulyi5SBm3CaQl
 NbBUQ+sqOqlYPpNpYSLLKCm7mlRRUsiCM9UfKdK8D/3El0IzL4SgR3ayZf06H7SE1JZ0Q
 JjXYnvXtesYv7/Wze8HZUCHd/zBCHJ9gZYP2nF2zzYpsKdNtWxuQpSXIbHoLJIdQzzWUN
 CqUB4fIPiMMUKN7ACpnMC4T69B/TRs1Aa1Bu729FvnhLKDf7RS1o8rFQKtjDD1iBb+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xkZVydAA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=xkZVydAA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3358460BFF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:30 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso898965e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713389; x=1790318189;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oYJqH+f6cHMFl6fX78Xi4O6SHeXFAURYM7dDyNr0nyk=;
 b=xkZVydAA66HL04hVYW6mjoPZe2y4WrkjqXZqgYIfuDyPS4ZYwRsRteSJoKlN2QtiFQ
 QSfEhreBpt8j6BSc7LNREkA0iixSnjFUs6p28IednaF1OndBGr5+8bYXh30KNOUIu+3y
 F4f77QYBL7uMaMBGvsZjeTKLVW54rW1YC++THAxvx6gF6DXcLkAWwZPVDzkF/C0D7CLz
 jhHP+J7Ks76LDOhcemyk3MXbpWoZDVHtFdA36RX8qaT23QoNwDST0pCyTE/iIQbi1Ei+
 6NAX+DsZno68InoR/4rDjc+omr33bAk6Em/OQ1PYfT0hg8//98607+7bpmNfrzeCiAiC
 Ka9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713389; x=1790318189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oYJqH+f6cHMFl6fX78Xi4O6SHeXFAURYM7dDyNr0nyk=;
 b=FyTvLGCR7zE4x7p7+wXqfeEdS/QQLJc6rEyFXsKsjYndNXmqF/WFQWMQ6SSsGpon0Y
 LKMbX40cw/HlYltNtpuAG0DEkSeu+b90KEmE3Vb/opTqWbN6WjS9gXQRmCQ7uacm5e4S
 3ezzPcj3mVEiQCMmrYzHIltaUa6YEaZMkxjbLwYCdndwzSeMvoJO4LNcx2UXXLHcABDs
 tJzuTQU2xfQcepsy1U5N33TT0f8F4jigMpwQSp6d3c3mwuhAN5LTg2jZgnY0d1cTK7GV
 KStU4b6921umPdCDIC2W5tjA20TBIY/5+ru15AaoFqPpI2ZsaizCZMbBi5yr1gnUz7q0
 MeIA==
X-Gm-Message-State: AFuF++l4bbSXJFWYnImKhuNB9j7O9kOCtYmZ1u+vECX1Tm5Zy9StpBxr
 FKHqP3wXrwL/PDU0v2x3G9mTl7PjHZrM95lbb5PzmKV4UAt53321jBhabtFssGnNgzU=
X-Gm-Gg: AYBFou1Wvmj30+9mxE2aNRz9FAdlcQki2mH+/69LYIzfO8h7UhPrAcqQGBJ5bCWMdSQ
 VEDelflCeyyYTAIoyy3xxDrGKUHMJolzBmKR6j+S9SQ06a0MR/loJ+sM5X8t2Zf/XQB2L0bzb6a
 bqcjD1nc3SoOeEneXSN82e6MJwF7smkVuvmH1ciIN6L+y3iwKbqC9F9AE3nKMCjlLDAoEo/L5C8
 aHqXRexalDWnaekbm55dR1oRjclueB4xXK9B6N3B30yR7Qkq0ibhm1FKzRxPq03vzcoLPBZi9kL
 zT6X0WKkrrTjSWPfH1xg8AY5xYl2+bBnTbZVTzkodTsmEXoSKBQvGI+OYoeqFWue44BsoXdgbMM
 ltXbRjqXjk0VFY6whDftv3VXmwxTwWsYzD2nD4lhRYUZoUBqmBnakvwxIHWO4hzqCvJnlzqYID0
 jr9IMvDc8hYDkX/oiTfeNwZRibfN8AaY+vcw8L4e7Qb0e9LZ8M74WJvPKoSU77H4aBO5CDAufmV
 WqsT3SRdMaZNFWpLCU1klNC4TwFqdMSNBVf4/Oo6WwQtqTiDA0E
X-Received: by 2002:a05:600c:468a:b0:49e:7c8c:bc77 with SMTP id
 5b1f17b1804b1-49fc4fae7acmr21191585e9.7.1789713388646; 
 Thu, 17 Sep 2026 23:36:28 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:49 +0400
Subject: [PATCH v2 08/10] ufs: report the logical unit the boot W-LU presents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-8-8a63e372bb6e@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Cbgn3xmeQuR64ErKuASeviaiontBOJS3RWCpsFkWPos=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX2xx/zTrAS+/6s0U8r1XSo396RteBY1389XcBeD/
 MmJB+4u7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqtwQxMjzZKWO71VeY5d2JJ7d4FB92ScgvPuBmPesWX7GVYHTBqjJGhp7AerE
 mBbdpwf+fefyz/M6VMT8nKlDv5yrzXYaBIvc3cwEA
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
2.55.0

