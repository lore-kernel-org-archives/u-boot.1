Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23C606A332
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RwiWhqyQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bxBWCAka
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80F0C81636;
	Fri, 23 Oct 2026 19:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-fOPLHzzw-M; Fri, 23 Oct 2026 19:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94A7A812B4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782059;
	b=mS/ECGrhboF+lxBsiQu5M2Jggsj6z9ZwG8RNw6B+YwSf6ZT5kZL6FAXBCt/LFMofzyL/
	 BheTBUU9+XAWkTXLuPoSR3sTx2gPJztcLsa2eewHR818r8+kDm23QtLqhCH+tsrhfLK2s
	 Ezr4cr6oR+sYMukrzWLsCbh6YTZr2KA09xYkb8F0WYURvnBBC/z4hQXHWXnA4Bz149TAe
	 VBgLrr1hpA17Pm59jBKjiwoUL7XOBTFLR5Z1860CDu/dbVpMcBslvlbyuBiUWPY4xwfxV
	 QP4WlkjN3pUUHdhKVfZXnFUJd+M8anHE6l1Cqu02hChPfNMjOsmVWYnjTTvJYk3h/mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xYjIiylUSfNGsffBIbAu+o7xS5vRC8ws18QN9T1aNw4=;
	b=KCnLVIcMOJDmuWb8e8ijBBlxd9SP1GeV4ChjlnBK+AeVgXYqpNir2Umx9TtkBDqtgDk2
	 /TN4ODpCtwxxrW91yP2DEmfBhhxsIz+wWx1ibAfLlpYfSHyuaNwXeIS5BZhb9fzZdwJfm
	 p4pp4d11GEsJEp+G7Km8mSi3u+VNQnHuJXcvMpw8lxYmRFsmanZCZtk39N82KTQ06qSS7
	 LBE4/zejiKCOdUkrZEeKoqKBPaXbA6kZf/j4PVRioWq9KK+HOHIflOquX7iZytOd49LF/
	 r/k+mDUpHUqHl0yR8y8QAEvsJapIG96cLdrJVB+7UzKa+6scJUQtOqxPY+dAWMsQXsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782059;
	bh=xYjIiylUSfNGsffBIbAu+o7xS5vRC8ws18QN9T1aNw4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RwiWhqyQCmYJ0ezMQjEky8OqchICWkFF0fRNd+TW3yPyQonmlQ0YWmSvMrsoNgrTI
	 Ou88fclG7gV+zncs4ZhFiNUAAQ5eAl8f3j5jIXaXGep9fAg8a3TXDegXxtfWU/3fUP
	 7ix32070urIf+yjpDXBYXXLJD6mr39U84lNOZoTvsNh4tUuQEMMnpY+Dzhd6T2NVX/
	 TCwGb/I9sRxNtvHdKVs0bE7bm+fviMzghuFPAC5IwSsIbWVYDapGNqCYSqI6VYZtFK
	 ZEXuzoGew4HrGVVw8Vv3ymBdkABVGDInTA5vb9cl3BJAueS5Vh1VEj/y27FyKJjaXI
	 DdRAtrS9pxbCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94A7A812B4;
	Fri, 23 Oct 2026 19:00:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5293D388
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5029140A52
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8puJCDBXE9ec for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:00:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CB484096C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782053;
 b=aGOK10Z9pINPB9f0HpWTOZPic0I6itjUXRPuGYowkBcxE08MFR89NK4HKzDCK6HS73tZ
 vzHkqMfcH/hXNxKjzA2RgWGiRzIUIm8ubrJCOk0NP0OFAatyKaOzMDRHwTLL/Jqdu6xMe
 m+zrcoH/12FfbiHC5G+LEjBtjTw+l4NhUde7S6jjDhb/O8Ox3lsuqyYQihIDSUPRCy838
 79PE4zSA8LkH2zyeybF7/HyMGZmM17PgacDKbHwe/CnxTNgmN0fj+lp1e+bZCWgsPvUJA
 78ajb7szyNCJuRZ9PtO+VL0klrG3Wq1rXFzXPiQT60uMz7L1L5vxPkdmWUdgz+yj+VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782053;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=xYjIiylUSfNGsffBIbAu+o7xS5vRC8ws18QN9T1aNw4=;
 b=EaOxskQLX0eDXEamsO/Vp+akSynHvad/Js5++1H1TEkX/nFzGI3R2nXFaGCWmtvDos3u
 68v5RjYym7x58R5SWYq3DItsYtwFkVdeYvC0GaRtEVwm8D7kAWgm8Mo7p1yuYLQ+6DMWS
 V7NuHTTu0jCSPqgiragvQOkwT5jT/6xExjr7eHsj1v9epwH5hGBrJ96b7pDjnO5HsDznZ
 4qrfrb1MhOrvT9tNjroe3IVBGUkBHZyMq3xiY37118g2SrTZxW4IiaYolKfAwiGPHm+uK
 eXFCp5IrSrJCdAZ9M5GSoTfZSAdus7tiZYAIZ1Idde/K/eWym3/zRh8XS2eQYAoGUWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bxBWCAka; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bxBWCAka
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CB484096C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:52 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so7808035e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782051; x=1793386851;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xYjIiylUSfNGsffBIbAu+o7xS5vRC8ws18QN9T1aNw4=;
 b=bxBWCAkaN7ADEE4geidPyDMN402MRfNFFl0JVhLXAAnBpGx8D7ZV1IKzlx2UvbbZ0v
 i4Auu1aGFUuHyV/UNGcy638Jkw6GSWTPrTXgbmpKIPL7FVHo6u4+HctcewH17ReBi+uu
 UFlId7r3gPg/DaW1fzlq0rDshGs3ZoIy7Ni3pMNGvsrxravgGEgdcuzn49EidzV9RCVa
 9ZZ/wNW8B7LjWVF41IheI6VgYMiSZRbZeg0jU4HRvmTvXOf0+DjpTXJYrQNzE5pDEMfr
 i/2HpcDITdG2d3m8NCboLf9IIfAtUePcqsQmZATnWC6vxMwomAe8Gf3PPCSDErW8K4gy
 5XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782051; x=1793386851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xYjIiylUSfNGsffBIbAu+o7xS5vRC8ws18QN9T1aNw4=;
 b=bHLYYFxUVnFKytcNybDb/doJLASDqbSpIqwMVBaye3NxyYZC8taSnGrOa0XIkUEKgW
 6IiaO/kCkZVxvMbr4zJA2Y3ekWD7sblnP0FoACiqBCtEsnv+kXAUU0vywjWFg2e38eVg
 ZIPWfr8lanTMTwsIIHEBZUZWdC7FKLo5OpKnNiHDSOnWG5pM1XLaXlT6aBs+5ufjOQaZ
 UuZMoaZMSebO6RbyBmcILBIeIwjbLhb1CgHJ4uJEUEIneE/gikcFFaYNA+MFtAtkRDen
 JahDdPgdMKUx0jMUIW6NScYimhdoVDZcdbS5VFHk4AXiv1kjYzTsOmmyRiswWKqzuXbp
 cM3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7yc/UIw4VImctsDRHPYpU8YdG1UQtqoACntmf0ntvtQSdipq9BJvbSvcAlc2aAi5hrdE3i54=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYISh+FuxHWyPRc/XKBVRpsfOAlc18kYAMFi+BWcOTzjEkHoN8BY
 X9iw+713yMjQvDO28+pOSFBjS/GaS4/gItvSTcy/UQzA4OgmnAOaAyxu
X-Gm-Gg: AYBFou2LBb6RYeG2UWS5PrtU3brFWeayCgRdqHCVoLIQzxKs8AODYBN+xGtbYLbQqgh
 wQLwnMV2TAvpbhJPH3nx6oLljiEO25Pvf9QYPjOJ9vlaGI9YgkVJQUGV9AXaVdjCDh4a8u0VapC
 xy0yc218JQGaakr1JCEkeZSaLAIxAXRzXWCXH1oNp66DFmPF+Q0nw7J4cqaOclgAES7Ug27SUGi
 NSdQE5t1gjwNoANR2O6DHWgq59LLYeGWvKnhuRvz7n5mkJTWeY4zoX/tyyT8M6k+FUwBSiNbc+R
 1epMprNWNMkNjOOyopEgXXsY8S5bxVlUim9VhfEYyuNYXf3p7XxqAEPXt9yFFTSX85prYWIi4+B
 Xw4TUdneh/DgjyaNrXc7yPGQy8sc2rMe/FYxaMsNttrU3uWs01OWJMCxik9MvxOXxAmUfGgzz+l
 Gt+7MQ63TaVIqH1MKg0gvs6ntmoNwHj53ADBELRbldbeDG8wGIltKf4PqQkeDA9oMlvdQM7C/NE
 FPMUof+u3FzyRMlJy//zGiXAL5208Brm97oSOJbnenyYQd9X+oO3O3dOxD6L18diVGpkThsY+8M
 JdCBeUZOWl+yt1w9YdrUL6ogT38HFPFp1j/Gk+TPxP/a7VHNdGbDU4I8axK7
X-Received: by 2002:a05:600c:3488:b0:4a2:be6:60aa with SMTP id
 5b1f17b1804b1-4a211caf977mr48584055e9.10.1792782050413; 
 Fri, 23 Oct 2026 12:00:50 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v9 4/8] misc: fs_loader: validate requested offset on reading
 file
Date: Fri, 23 Oct 2026 21:00:25 +0200
Message-ID: <20261023190034.911023-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023190034.911023-1-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure we are not requesting an offset for the requesting file beyond
the actual size of the actual file.

If it's such the case, log and error and return -EINVAL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c | 59 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index b1eb0311dd2b..6a1747e739d7 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -79,18 +79,10 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
 	struct fw_loader_env_info info = { };
-	loff_t actread = 0;
 	int ret;
 
 	generic_fw_loader_env_info(&info);
@@ -113,6 +105,51 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		ret = select_fs_dev(plat);
 	}
 
+	return ret;
+}
+
+static void fw_get_filesystem_release(struct udevice *dev)
+{
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+}
+
+static int __fw_get_filesystem_firmware_size(struct udevice *dev,
+					     const char *name, loff_t *size)
+{
+	int ret;
+
+	ret = fw_get_filesystem_prepare(dev);
+	if (ret)
+		return ret;
+
+	return fs_size(name, size);
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	loff_t size, actread = 0;
+	int ret;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	if (upriv->offset > size) {
+		log_err("Invalid offset. Entry too small\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -127,9 +164,7 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	}
 
 out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
+	fw_get_filesystem_release(dev);
 	return ret;
 }
 
-- 
2.55.0

