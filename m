Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F2C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67CDB811E3;
	Fri, 18 Sep 2026 06:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdbKmM4CyTEf; Fri, 18 Sep 2026 06:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADFA5811D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713397;
	b=ErzDYpj241Z95HJqMwrl9ys/sp2Aa/af5liddsjpGj2MTipgBB8es0ScDkgg4HY5fTDG
	 yaZFTRqtU4rmGIf1AltCYiuuB5xyO4oSI+tg7f1M6Lt0YXCkvU3JouCEvH69gzw3jnIA0
	 oUAaim5sgWrqbSMO2mqhGXNGhI6lhYHhR+kE7qGC/PJSEBB3gVvXofK0IOeBsJjDc0SD4
	 GfEmuggRKwEQ0Z2IyT4CHQ2Qc5uoQzAZK0MStbunbVPg9l1a1quHJj4vuyH+q8DR2x5js
	 J6U2pZiUiRfoOvnhFqZ7H0tRxiZcY4tzuy+UEC4UroGxbJ0sgJPUDxua7azSCKQUP2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SW5TWnNQVqnpR47rGVWVPSXVCe7JVgcdcSUQvK01jbM=;
	b=BKPC7TMwPqGzLcmUHzGaWjtuPKdlolTMUym1NzkJGQkYHPerNZYQkhvYHgHV8h6WI3FX
	 KW1Ee9GoFLQ+dhCCazH0ZplwCqobOH1YFrmHHzNJnn6n+O+J62dVXqEu94vp75hofIGI+
	 dUp730yxdCr2Fwu03jiZ19uLvuuAuBK3jbyAt39U6THV7+8GB2ZZYKJusdBe7c4kbzc9d
	 06QlbpcEaAqWAw5HpaU6DNhidakQX8Cxx0qh9HsSUW+xXdP9e/TXwT9Ikv/oAU1DNT8V9
	 pyRLagvLD87T1sbC6fLV7+5aZxh80kdNNrqjX39p+0H6hb6ZIEdguxiWl0V1JW8UUjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713397;
	bh=SW5TWnNQVqnpR47rGVWVPSXVCe7JVgcdcSUQvK01jbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAThF323BKY0UyJ/kouTwbkxzonNJHlCTxDv7z+BW4ah6zwgD8EeYityNRyyteBb+
	 +C9aU9951TxSMdjSRt934iLnXUYTs7Z/cKE30ghFj5uXB+7XEH19jlS0Emv4dbBLpX
	 YGmpeg5jW9cnT2RaG+aP71TcfDnTw1lXmCO4riDOGhI2XWBpxFERflCm+nZt6gK95u
	 ZTnv2R+KN1PooNdnsuuHrxfzGUwN4NZqPHvSBF3NZBeavHBdwiquWPhHL2X4jCwroB
	 2zF23/6EVek/DjwCTfPFMma+KRW1V5uMOqtVogCXrmQNNvz/Uihxr82nbaidJ0PbpM
	 ZDEWCg9zMZLKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADFA5811D8;
	Fri, 18 Sep 2026 06:36:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1420B13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 055F640AED
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHMJPnT6LCow for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 239D340AF8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713395;
 b=kVGrWT5Gvpvvdks4sRZRPRtTforuQddLfbkCd6O75o3D+v4TKu/n2Lnx5my7w9XzYeAH
 huRBg4HEGc00SvCxYWak5JuSoQiTIKFzBGbTrqGTSenTh6TcFYZXVqpKFNzAUX4dz0sXO
 j/6TLdJMkvwHuikrhCVpxj/I6MpOt5loXzjUyIGKxhlzZLuCqL7rZpaCdIx49q0vmw+J7
 j+Y3Lpy7edYlOqVMu3LdLUxK9DYgxOv4mfzfaovk33HawkHE+MBCJxXfFX3JXRRS5clnl
 1u6ecn0x5Q+ZO3yCwl4w1UjoXg9rn/3JZT6g+h0xr9ECce00al6yJMCYKdvBYoGWuOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713395;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=SW5TWnNQVqnpR47rGVWVPSXVCe7JVgcdcSUQvK01jbM=;
 b=lg0vHnnl1UCEm1U8qGih3JBnk4ZKje3qo1lJm9aNLjU5LLkYECASOzzM44UURucOUdC2
 AKIMN4ipauiDCbycZ8UlyxgRlEZOzqGaRFMYHV6HSKD6aSZd6dOlPasDCg80P2sG5V7DN
 uQM3e9FaNtLY8M4nJxQYaOHNesdmqdjI7ay7XN4nXC6h27FDiqzm7aoQT07pWsxsCs1K6
 5+kUnOHJzqlLONXZDNdTZVBGGO48t/ispwxBUgVIZzeddNHPZ3VPvI/0gFIUfO80yhnz8
 V/lslfdNcXKz6yi1jenZPxJ+E8i7TDMXEcDs1r9Q4HZI0nFS5G5QidFisbCkdbsKnIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="Ok/musXK"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=Ok/musXK
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 239D340AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:33 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so186394f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713392; x=1790318192;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SW5TWnNQVqnpR47rGVWVPSXVCe7JVgcdcSUQvK01jbM=;
 b=Ok/musXKRmGbBRDjOc71TXtjvSnEPwZJPYDeR79ybJVAT8WwUAe8BTzaayqmCExZJi
 qbm/Kx1uRAjzA3bq2uBc+rmT42Tw4xm3maNoINvXVnSmmlUmDuYwDT/XTDeys9kmgr7f
 HsryppWEM46Jetp9tJb4Mr2oronM4WFTNSgmgltWcVIZfgCeTrKNGfqOEYMRgd2AJqxi
 25GbWYNmppnl3toy4kPw44RhT/nUbwzBWGdlHM9LgmQ61l8VBQMGKj5efKwOEUIIB+Ct
 pvveCAYb4lXFpdAayHXg/WJqP3bmpPjTasPmi46PM/nrmW5+ebhZI1b4d0Fnf8Cvg5ze
 G4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713392; x=1790318192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SW5TWnNQVqnpR47rGVWVPSXVCe7JVgcdcSUQvK01jbM=;
 b=cbnu1L6TbfWr7vb984M0VyQegf7kiuD7J1y8wg2NkU7etaWqOLFYhafWG26l10BTiN
 3GcqCjd1SDh+q4CQDxouX8/jFIQYr4vD6LmHjinn7tWrZq5pjMC94LiYaCaakgZ4DUYv
 Po55Vw0u4T9CZb+cBftg68yUbtNy9qlU4aS+jLxHLW+lNJrEUdVeQ1ne21RinrEBlHTQ
 7IjHoA5ck1WkeH4WZXLIo6DiEwyfIdOFUtSLVe+SagP7jb6T4DMR6KGgqmeGyDzB+O+N
 NgQTq63b87fIxCa8HiZOlf0lX/URpjHAwycPRFBTMX4bnPPD2EspoyaoYtzv3/GPKNgS
 zAnA==
X-Gm-Message-State: AFuF++mUmCI5fErPYhXkhDPxPHNtKSLXtaPjpraBFaz5Jw6tYxBkHvhg
 olZeUsmM2xlPfOAVXimkc29q0AP27d0ryb04GjSCHv9zRn5DQFWboLU1x+EyIwLEkqc=
X-Gm-Gg: AYBFou1k9g9flA/GOkcNEWKvla6RJSGmZk/q1HyKZbHDFOtKVD3Cp6iMM+cHPzTK6Fg
 zkzGiVzBsOpkRIo32J7WF8AkqNUMsazq/uvYPAC/68H8dKEkc//mbfWt4gpcZhVr/KLnVszqkPI
 oBU7ftJMx+xiXFi4JDVQ6e9DbTb38QQGRiSB4rnh7iT4ecgdC53/fCf+wU2c2EVAcKJlUn3y7yP
 foivo34D5irw6S3m+E1Vk9ea37d8EeXLZBtbAuh1/u8DwZbqrm2vFr8CeuRj/IPgMz1X2XbASlp
 B4D0ZK3ruNK8zpRdDf3iQHqAR+7JKKfXNz33jwKHrzHtROyC1Iw+k3YAEE4jaX3vnF8suhUA7QB
 c7EtwkxPt2m/45hWpeETWVBkpZXYrpkPjPb+pJwnHPt+sdPIzNyj0r9qKZYavUZNExF9DrtpLgq
 KVj7xD0d0tqAMV5NtGx/mJYFHmtAgA9/6bthvgyL8fVjK5OlssnV5TZIDnkloCQED0ECVt/WyWp
 IWjXKoaVzZtyZDkTrtkcJ/Ot7lq/+c2XrReksB/siJimrEP2LY=
X-Received: by 2002:a05:600c:c490:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49fc573e8b8mr27270265e9.16.1789713391902; 
 Thu, 17 Sep 2026 23:36:31 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:31 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:50 +0400
Subject: [PATCH v2 09/10] ufs: expose the boot logical unit as a block device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-9-8a63e372bb6e@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=alchark@flipper.net;
 h=from:subject:message-id; bh=plepszhoiZGVyMTFeuERAx0eY1yIXFoDqASVp9EW+ok=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1xCn/74sPn9ZL+7gi74yHw82/3eX0z2yXLvp85J
 /qBp/2hYcdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBT7cPFyLBzefOZx5bKD9do2M3pDuav6H6uHhEfH8difnqRkMLObEeGv1IxBfx
 yF+Q41skuWDov7GzIqpszvgkofY+SbG6Zte3Qbm4A
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

The boot W-LU aliases whichever logical unit bBootLunEn currently selects,
so reading through it follows an A/B switch made by the device itself
rather than one U-Boot has to work out.

Leave the device and RPMB well known units alone: neither is a block
device, so probing them would only cost two failed round trips.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/ufs-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index da0d6f01146a..ba061dc8aef1 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2195,6 +2195,13 @@ static int ufs_start(struct ufs_hba *hba)
 	return 0;
 }
 
+/*
+ * The boot W-LU aliases whichever logical unit bBootLunEn currently selects, so
+ * expose it as a block device of its own. The device and RPMB W-LUs are not
+ * block devices and are left out.
+ */
+static const u8 ufs_wluns[] = { UFS_UPIU_BOOT_WLUN };
+
 int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(ufs_dev);
@@ -2211,6 +2218,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	scsi_plat->max_id = UFSHCD_MAX_ID;
 	scsi_plat->max_lun = UFS_MAX_LUNS;
 	scsi_plat->max_bytes_per_req = UFS_MAX_BYTES;
+	scsi_plat->wluns = ufs_wluns;
+	scsi_plat->wlun_count = ARRAY_SIZE(ufs_wluns);
 
 	hba->dev = ufs_dev;
 	hba->ops = hba_ops;

-- 
2.55.0

