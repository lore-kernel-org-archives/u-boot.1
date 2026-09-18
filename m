Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD799C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 938E960BE9;
	Fri, 18 Sep 2026 06:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybOJAE3rcQz9; Fri, 18 Sep 2026 06:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD0A660BC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713371;
	b=DZjXux/kT+MEv/l/pca0UwdSo8jw6Nc9B8wO8GyPtZ6Ni9FxB70LDr7cEabaKkWPZOlq
	 JZ57yqqTRVqEmnU0wSKHa3kCf6NQ4pLuu9xZw+F6rTSsRkNktoW/nFcYIItAmgtCyVscP
	 pdWt9TT/xR8T6dyhp8Q4JzV8/4kGimbXxODV5Ym9Ll1uySa1NJdtxOU1MOCyGnmM+ItAC
	 CbU9LgzQ4cgQZbWjmrT8ErY+iNU55DDiyyBtMbzXSiiSn/F7Tl9RANI5qAy0uyEd6kLxv
	 FPqs+GoLyfGNTHDxVZ1ZFDxuSkl2Ep/Rer5YGhWm0SJjtKEZAT2Wa5mgO3qgFRNVf8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pE8hXRh2wvbG1MUnsusD5HWUtXmxkTBobh2yVF8VmPQ=;
	b=KVqUq1Blnu14wH0WB47C6+OkdV9dBgIIuw8GDNpbrkKU+0qi4tOkabiXwKp9OSBntGKO
	 gRhrvCj18VVrjNtRgF2/txZlA44XJqtovo1/NqxEsJBV30OWWCvPVpvlt9d5Fz2osPkIe
	 BhMoJIbKEbCfG3y8QOyAS8pypl0g49nf+fRXg0rYMDbmLhE3dSeDqZlaPmUamz47VSYfd
	 O+10vIRkUNfd+z84u4juNKiuspobN7b+/loX26Ky9Alfos3EWDmra/M5IMpB/9BpwbbLY
	 ElZb7ehtlzaZ8zW+Ch/3l2uGfk0xCQbgk5CrpefxvIv8o0OB9JkHV/q7TqQJRCsWZ6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713371;
	bh=pE8hXRh2wvbG1MUnsusD5HWUtXmxkTBobh2yVF8VmPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0uK+Gp4SGoJ9eIw1vLyZftpgNeuuj4fpWgIEsWbWfdsdZb08IkVXbP83VzFvEdEk
	 GH6rXm445EmooVVL30lZtR2GiuQChbnlDbOwu5JtQPsRJFYOH2cCKiXOkbnlzaywCH
	 TbnQrYxn4Jhoff6vTElLhqA3ltlvpzg22uzVBsi745lLSUfRpPnellfx5HS/g+yF3k
	 a8vB+aTfF79EGDroSl2TzsZx37p90lYsvxc3n036JceklC6JV5pTnya4hz7poe5jBj
	 47C6d1jHipD72I9XLyjfgDV52ds4yzXweFujA4XtWMcsv4K1HT1ekhskgO2flu1laN
	 GoSxfgIFGG95g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD0A660BC6;
	Fri, 18 Sep 2026 06:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C63B6352
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8375404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Z3wx9PgBCaz for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C46FC400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713369;
 b=GMPQ9AAxvs5Wd7qjW7il+3g8dyqUWIGXJA3WylSx8xWO+F6vebpUDBlFU2hO/hL33PWu
 dsAW8IupQKcWwq6HkWoz/rr2jLG+9raFwLhb/hYvL7lSBlXr3ZHPw5CAtbn+SgjvXwxl7
 7ztTCzt7rlr4qwzVf+jPjI6GoqiZgyAeYdkjsZaSp7+eY+6Xpp6vRSk5OTtQW/vRVD7kE
 imYzjuMA8sYez1lckhcOVtyvLSI3hBGm2ys+83S2KScROl+Xfd4AxJUy0JZbxcKM6+vgP
 97labrput2my7N6VzG990hWJRgjbemya1pirrP2Fs13TCwBZYHtzhizEBP7fzq7IWZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713369;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=pE8hXRh2wvbG1MUnsusD5HWUtXmxkTBobh2yVF8VmPQ=;
 b=lZkFKwzl3onzFroBQvsoEDrr1QwONYqZeufsiZYLOXqhJuzA/KHzrQn53pHx7+wbW1gc
 UcVyozbGEkCgB7xp3pxD28GroOP71LH/7pbjZ9+QttAK/RtEVsO575PTjyVBlQjYHw1hI
 jKaiFMTKBlJ82b7LuN8TWF3vJFLEPKKm/HFoLq+yrOo86zNhBQRDXh84UjvwpA1Y+Yx0i
 1uDcC3Jwe/L6RBYQPkbDZlgTFbk+AB/e5qhQbFS/kIvzMqHObAOSSPXhHPVgna2emmncj
 wC/3XHL93RhDJPtr+hbhFNBOR9m2uRbTaGPxYAcyMlz53Xv7LI86UUvFWkKJ6e3g3Sw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=KTf5lIpD; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=KTf5lIpD
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C46FC400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:08 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso99722f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713366; x=1790318166;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pE8hXRh2wvbG1MUnsusD5HWUtXmxkTBobh2yVF8VmPQ=;
 b=KTf5lIpD3z18FDz7T0vt7BZLDCmlMI63ILhZR678JfrYlBaGXP8Xz3hE3t2qnfI0NX
 id1qDMbSp8JTzHJlMgNTrHA7QX/vjIMuyR/mz0cNaCuf2Wjvs5NoEHf5F+xHrg4TkRnp
 0sbAVBnWv9yXHLa8G0JDd/0MaXmHhZpxEsnz0rJ6fwIrcPgyUC/zfLOE26B4QlmGHjRZ
 Ce7Ii/tTmZhmx6jTq6HVdfLtd734oL63Z6l1rVm/QPNOvXURbIPpH9GB4xqYSyEGJYH4
 +KNIH9Yapka/SyBAduEkjekPAE/VuV6h66zLdnGygicND1mULOjRdDv3EUQx6k7HF9cm
 s84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713366; x=1790318166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pE8hXRh2wvbG1MUnsusD5HWUtXmxkTBobh2yVF8VmPQ=;
 b=CyPT6AYekvbLaq08qSDlDMqnj+OaoCYHucCcinrLxB7Np2rqUszGPRgM0mMGo/S6KN
 jqXHsL12TVjCWqinopOC0/6KBUtALeXBDLpT1/nR20hNhecwCqTdXQAgkMfuz/JYWWXj
 /1YdpOza/861G/0Fk+H1dcgFMUCaSnxEogX4a9HI6Zwo1cbtNwGInhwUBGL4C5ldHYdL
 wXJDxW6Ck4N/DGuMkDYUhNm1bz9b6GOvc5TX232XijLvJW3c02owEfnsVems5F7rktql
 m1rge9X9mJRbx/auHC6sPxa52VfP9vhHnPOXbXnCJd4N3NmLwyr88enE6lQOhyoHEmm0
 EjHw==
X-Gm-Message-State: AFuF++kpJhnN6uklCunsXiEmBTKlXaECtTIZ33RmUOA29w2FMOVCoBvp
 at4iIAe4g3+Lw1r7pk4KFZm9JDfIHNoegQ+s3/0T2clVPHMzwCRAUxW1D9D7YaTbuNY=
X-Gm-Gg: AYBFou2bRkxTXQSpuZzdwE8A7KBhVGuV7FTAUR5GGOybmHGgKjj7e8W5/sa4wW3y7Cn
 2Fq/04GT5wM1lhBQhBTtthVK/CIbhxwRP6+xGEKohwwZ6b55WVb1FDrYX8widTdeAaZEKWmsNhw
 BbAE6LlzwNe2X1ApJ/T55sMweUdEE/WCHFoo+A4ccblvwDCzGUJq6lZuh3EVQDp4dPhj0XGG4P4
 69vg1rn/UUKb4bNUS0mDgUp6JemJZ7oXnFq0uuWbVs17HcGa+dr/heQ3PEMpZyFhoABfy1R9KIS
 F9NijbbuY9/tWphtUIqkqDrs4hTb3KxDff/IZjOGrHZPg+pQZyS/8T0ld+P2c2gQ1L3IoZgCLBV
 VoLyFwiVLHOHaN4Azllo+R+v1SfJMai/cGjIE0ETHdwcq9SE0luCeYM82K00P6fBGVpEYdsGE8u
 zfKiq5LtMF52k4Ixii+bGbdQj+4QTZhJcbbus1MvKRQiP2KaGAjulVeEHlyzIq31nb0q4zPHZ2I
 x8vAaEf+7e9BsNmMXrPE/QsuVTn0ojkvkTzOzN6atxjP4BNbdCu
X-Received: by 2002:a05:600c:1389:b0:49d:2936:8ad1 with SMTP id
 5b1f17b1804b1-49fc4f71c7dmr19051935e9.1.1789713366032; 
 Thu, 17 Sep 2026 23:36:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:42 +0400
Subject: [PATCH v2 01/10] ufs: hand sense data to the SCSI layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-1-8a63e372bb6e@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2519; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nKFc6oHpbxD5OxyNDzZKbTzZaCgVBAxovpk2bbbPHMA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1RcsJs5eTrs5wrT/ElaydxGv7VYE2aLKwZ2vnvZ
 KG3qy97x0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFMdVcLwT3eNi+xWzc4Hxxo9n/ay7+JlPLboW8uTww1MFy22nS0P6WNk2Gs2c+n
 +bZHTrhy4U3DhY7qsvoL+/AuFC/tFvhoL891zYgUA
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

A logical unit exposes a CHECK CONDITION through its sense data, and
without it a caller cannot tell a transient condition from a permanent
one. struct scsi_cmd has carried a sense buffer all along that no driver
ever filled, so fill it, and clear the length in scsi_exec() so that one
command cannot be read as another's sense.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c |  3 +++
 drivers/ufs/ufs-uclass.c   | 23 ++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d45..54afac6eaf51 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -22,6 +22,9 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 	if (!ops->exec)
 		return -ENOSYS;
 
+	/* Whatever a previous command left behind is not this command's sense */
+	pccb->sensedatalen = 0;
+
 	return ops->exec(dev, pccb);
 }
 
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6ef01f8e4aa7..acaecfa1e341 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1657,6 +1657,24 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
+/**
+ * ufshcd_copy_sense_data - hand the response sense data to the SCSI layer
+ *
+ * A logical unit explains a CHECK CONDITION through its sense data, which the
+ * caller needs to tell a transient condition from a permanent one.
+ */
+static void ufshcd_copy_sense_data(struct ufs_hba *hba, struct scsi_cmd *pccb)
+{
+	struct utp_upiu_rsp *rsp = hba->ucd_rsp_ptr;
+	u16 len = be16_to_cpu(rsp->sr.sense_data_len);
+
+	len = min_t(u16, len, RESPONSE_UPIU_SENSE_DATA_LENGTH);
+	len = min_t(u16, len, sizeof(pccb->sense_buf));
+
+	memcpy(pccb->sense_buf, rsp->sr.sense_data, len);
+	pccb->sensedatalen = len;
+}
+
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
@@ -1683,8 +1701,11 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
 
 			scsi_status = result & MASK_SCSI_STATUS;
-			if (scsi_status)
+			if (scsi_status) {
+				ufshcd_copy_sense_data(hba, pccb);
+				pccb->status = scsi_status;
 				return -EINVAL;
+			}
 
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:

-- 
2.55.0

