Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B05FCA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5090481233;
	Thu,  8 Oct 2026 08:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9ZtsYWZKMkW; Thu,  8 Oct 2026 08:37:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 942AE811F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448679;
	b=qJznwG/o3TZSN+KPuLS9lKG8a49tdaMiq/ozRocTSc8kFV5jANLdBrYavDY+m/2ycdkb
	 9eDBMwj8vRCjFO9+F2Hl+Qe/Wv8Pis8iTZ6AT4t9TEe1uU6vZLVE8BDvHEHXpa/KMDgx6
	 0WIMiQ2vibDUzvBTpgJC9kq4ysuRobtNm9XLD3Iv+humy2I2MKLNCeApZtqK0L6RFdwHx
	 tmblh6xeQYwcm0TGebnYw3FIPaX0qUCt6/+MNTG6a+3u+4OA7uFBET9tEtllTD5cSi4fb
	 9tSQ9gpcbpPzN8K9jYAQqz5jwS4A0d/L3hh9Zq+KjWf/w0lvcPLjmnN5enqngApB6IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SyRt1Gno/ATEgjk0OP6NeOrns735DwD+xKvtNaOCAkM=;
	b=I2Fo/IrNF2ILXAg/rl7HObdsB0KQPAFo6bQWIflp7XqOL09MxsoMD+USmqwbV2O1SG5t
	 1w4Lr6AllGv1Os4cMHS/OpcUsz9MWTKfYNIsHu+PiikcLyIswOVx4C1eY2TOc8pdlws9R
	 D4SONH8PAO32oBHgsNWJ+hiyhglKaUy9Fhg2YHQpW/Qbrg1c3u+UF0UyGsaU1E6dBBmfK
	 1US8oDV2XySnh9JEd876QI0vbcodffY433HDwLQIO24pdZs8E86aymCC5qkiX628BlMoV
	 gQiHA+py1Rt+tUBnEZjY6G3YZ5p0dCpgBexMA7xxsa7cQBNp4fNiMd8onRDGRRAd/CA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448679;
	bh=SyRt1Gno/ATEgjk0OP6NeOrns735DwD+xKvtNaOCAkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w5HboP6U2jk8cdvupHHtPOm5kIh6CCk+MPjo1E8Dkjw/xr3d4Ks4iEz0/FucyLEAZ
	 bO1FrAwE68+mOtCRFj9aXBRFkR8kcqVrP+Lxa8CrsmkYE6mxXWbkjNSQZBxum9gWJn
	 nypnpmIR7o5utaVqFCyVFdC2S3RrZVA2CnwWEytTR65t2IcPbxfpXFuClwGJUp0xJd
	 ywP4xdjFZpeoMISdi5PViEmxEfFv/FitmrgGeX97CpWg3eDEoGneatFnhOzkovw6p/
	 DFo1rp9tH9kyIQd/vl1a9gdnEoNMSwqkqORRLavzDzYgjalzolsUAH/VOwZMYCYh/W
	 ypiModiG15EEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 942AE811F6;
	Thu,  8 Oct 2026 08:37:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C04A0151A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A68AA40062
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZH4eL0WyanHX for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B0E8840050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791448356;
 b=WHRLjHmeDjiNfVDMBfLOhNmRgfnev2GFzLJE+Y/L2DSwMLX6QU9QKSuWJmlgcqvL7Yj7
 lzDq5vLNmvSs4KkCdMcld66iFMGbpY6Or6aGFUXi+jsmNI34sh2RW1J0rXIomCCCIiBbx
 TdxGag22twBjZS9L5jqjTgFP/KRN385qfI8ti6VF/T9mhU5/bs6EyaicPZ3yymGXw9+7z
 02IRx2PB5SFQ3MxBJg3EAQJSRRuNlNyXFlh0NRyk6CYoZBGfs/asDCGU4BlFYNWSWgIJe
 Q7dsYs3WwXPNxseYXRitiZEZRPMI9FCz4h517TRNohivEQMTjdUtN8IAsV1mnLH3iNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791448356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=SyRt1Gno/ATEgjk0OP6NeOrns735DwD+xKvtNaOCAkM=;
 b=dqDaaadVtn7kGnFtEyLfkcZsyLsHonjiwKyQ6uH6v6d7NUmsPvm/0sBVj8QNovDDXDHC
 qWU1ARbQobofizu1vnxF3wp6E50szrgfPJEh0+mrMF9ZpMy5/m9W0JxLeV/ywEoib92lS
 /1tIYnP0EWSNqURmOKEOXljST31kHBLwjVgBIgx9Os1aWTHOcOLiFf1bxVp81ZgbibYst
 x4KNem7YK5ujwwBvtz2cWqTlxmzWXzSNVxcHhjfYs418DMC+W0cenNN/uIXyWEkJbHOFW
 7ojUqGgIt/RffqAXef1vjhHEMLN1lrG3hXdPDMuWDifXJeCFd2rrM2Doctum3qVMA7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fCRCak+p; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=kilicyasirahmet@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fCRCak+p
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0E8840050
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:33 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so20822335e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791448352; x=1792053152;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SyRt1Gno/ATEgjk0OP6NeOrns735DwD+xKvtNaOCAkM=;
 b=fCRCak+p4qNyZE+viInqlDt1erFfDAgTVciWd2PG6oCoY6m1A6FY3oSziC+xdOdn/P
 UTqchwxP2GLlwZdNq0UH+v3NSOiu5Ya6DtlfU4g7Py5F7EsS6wrDm4+lGGQeyNZQApae
 uK09SR5Dpwj5TVPMH0mTnFvADXJJEV6nVwXqpNPNdYV+A7fFJ0fgWk/WP2esOf3E/X2H
 J66JFiNQenX/zb8W0bb/bPLDuEbWbz0qncdmZlXJjzukXYy0kOovwthaiW8ODcpJLB4I
 w3BaWCQPZU+WBHVu9hUAuDRwLxjJG4JgBQP4mgVtJILsY8sAeuqeBIhvtAXW/OpLio8T
 y9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791448352; x=1792053152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SyRt1Gno/ATEgjk0OP6NeOrns735DwD+xKvtNaOCAkM=;
 b=DFKb1z0AG8fBRmBHXIiFm7ZY4fLfNi/O/hhnfnIiEnqCtpwoVaXbOrWQjyuxvlP4/A
 4Q1HS4Orfp80WHqxd6iuj339i3L0ESfgEpSGiO89V3szI6nr2Kvx0FeoCvHdvDZil1/1
 sJK5gShEZU3/t1rEb4OvPDEH0QuaphKEZ/901AoKf57HDTUI5NAMWH0Da5IFcLxAC37u
 rB5lZLwOwn9if7xTKPa3DHfVrjyUO8Zm1nvWsbJ85KEMh7k3n5oeN4cnxGxh+fSN2dyG
 zBdXw3uqQ7HlbwrLuJocjFqtn0IrzM68kXwr6PauZOezDoZbqBJmmIvBoqiDqK087B5d
 LCjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM94gmPDCBXJmnneqF0KheBRdoxFUDoSoL36ps8c+nHwqJCzc4s6IzZbHGcGZTYCU5GuK/PNM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kTvPZwXEHn7r5eAVc44dLzUUZWF1SCnha+f3HEw6D47lmCpB5D
 FfHPg4xjQDqCy0BJwVmDFf0oHRlttBwFe6w3TnFlngCGUjENcHihcmLL
X-Gm-Gg: AYBFou2ggZdmoTKbRMaB9NlcArg+Av8rSp6smVrn4CQDLvEFbssfL95LK5y5sTKBbzc
 g59NS06jbVA1TGGkvOgRtwI9L4ippZR5gPMdgVywxxsuVa5r+SS+bvsXen/cOG803xBxDZm4fUI
 zrg7vJQzWspOnx5/paLqRQYO3XWTx0CbNzNtmWn5Y1sg/JM0xy2j3wpXAr4oLY0W5LQy3CHOd5o
 SGwMAbBkfeyUyEnGk1NX53fdygm+bmoRhTLhBAzVl6+Ic2QTuY3VeImJeaOLM44/l4ssSiEl3Gy
 +OusaCe+0sDuG0/S3EjdH10l5SJIgSmK7NmNSMbvdE/I9ATAqigCnHcQzfZpJAsN3FLLUaQcz/a
 HSQNKy6MzfzrQgvxOvFp4C/b87RcJJUZDx60H14hLXPXFGgEU+p1JSu8snKE7ZNzhM2XIsn5Yfw
 LDNofz1r4Ry/W0IkBvAy3PUrElvQshqvKAT5JZQFtTXrpoBsr/WT3lsTihtWTbRBGSW01zEu8SA
 Eohv8Ukl2XXIXDH
X-Received: by 2002:a05:600c:4ec7:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a18065df3amr92390395e9.27.1791448351825; 
 Thu, 08 Oct 2026 01:32:31 -0700 (PDT)
Received: from [10.40.144.67] ([193.140.87.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a3f55sm56309575e9.2.2026.10.08.01.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 01:32:31 -0700 (PDT)
From: Yasir Kilic <kilicyasirahmet@gmail.com>
Date: Thu, 08 Oct 2026 11:29:55 +0300
Subject: [PATCH 1/2] spi_flash: honor MTD_NO_ERASE flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-everspin_mr24h40_mram_support-v1-1-d8f14da1a997@gmail.com>
References: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
In-Reply-To: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ssunk <ssunkkan@gmail.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Yasir Kilic <kilicyasirahmet@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448202; l=1166;
 i=kilicyasirahmet@gmail.com; s=20261008; h=from:subject:message-id;
 bh=C1589OZetem9bdmpsW8v7jSNXJlslMeIBE3kN5XKxhc=;
 b=hgiIE47Xq/646aA1vCghdIPtEiQPutzR0iAhkBroUaUJXErccL6YRmz+Ufl83c63EkYI4QOJs
 4LjjbxTK8rVCRXfOjHWYI1lPJ8PCcHseBtym5DN57nRE+AwRZd3cXch
X-Developer-Key: i=kilicyasirahmet@gmail.com; a=ed25519;
 pk=FRG0XaJZhIxdUTCOJsdfP9Dy66fwq4axSdMGQ0leLqQ=
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

There is a MTD_NO_ERASE flag for supporting spi flash devices with no
erase command but this isn't checked.

spi_flash_erase now returns 0 if this flag is set.

Signed-off-by: Yasir Kilic <kilicyasirahmet@gmail.com>
---
 include/spi_flash.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/spi_flash.h b/include/spi_flash.h
index 2e703e85250..f471225bf54 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -128,6 +128,11 @@ static inline int spi_flash_write(struct spi_flash *flash, u32 offset,
 static inline int spi_flash_erase(struct spi_flash *flash, u32 offset,
 				  size_t len)
 {
+	struct mtd_info *mtd = &flash->mtd;
+
+	if (mtd->flags | MTD_NO_ERASE)
+		return 0;
+
 	return spi_flash_erase_dm(flash->dev, offset, len);
 }
 
@@ -208,6 +213,9 @@ static inline int spi_flash_erase(struct spi_flash *flash, u32 offset,
 	struct mtd_info *mtd = &flash->mtd;
 	struct erase_info instr;
 
+	if (mtd->flags | MTD_NO_ERASE)
+		return 0;
+
 	if (offset % mtd->erasesize || len % mtd->erasesize) {
 		printf("SF: Erase offset/length not multiple of erase size\n");
 		return -EINVAL;

-- 
2.43.0

