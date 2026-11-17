Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43223606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j/lRw3Ra;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoG52wcX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3D26608B0;
	Tue, 17 Nov 2026 12:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RF7TzS8jzyOf; Tue, 17 Nov 2026 12:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 479C2608A6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918456;
	b=GUqjK6CruodPjTsxdglUd8VjE+85AjzbvWXAbF0x/kcPRFTlgKN09xf8uN6/2IETXqag
	 K/L1Gom3Fl/SgHVrbpIYUplNZZ14nUk09Tt862MWHtOmmzbxE7g1AsL2w1OH+YVovtllz
	 RZxPXHCMsYvcnZPYmKfISlrE/cW8p6yx3KpUHxF7I8ZkPWfZNb5WT7VdhA6aIn/AIIO7B
	 bvX0BgJxspih+9Lnr+ph9AssP+mgoW4nR28xdyNGfXgDEQwTYs56+h9+LuXlds2Fa/G/i
	 +np8cIbpfAJNcH5V0uvtmqs2BxMJnU8UCdE8Mw8wixEpsw9ZZQu31uX9EuOpK62ajJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/AxGcG4fWDCuE+0PNw6/3N8jrGEKSUuRgQI4WbGWtr4=;
	b=XSc0Q/GYUqcIHmzlQyQuUduyxVwrs4TbRLMtexBZ1RQCoy5GY24qvO5i+GS3aGOgDNw0
	 BEExppACZ9SBUGzJnLn5kFDhb1R/Z0KY+oNAp0avS6PjF3eZFfBnFD2ntZfAswg5c6CxQ
	 e2zh96Vc09lwI9Z3vmkZ0cVHxhIDYtmS2fxx/6UIMF6h4JVXd6hP+9b3tdBcAgWmA6KOF
	 ZWeIQQa4sfFfkBtQN/bI4dDE19uc/2k+wus8u1I8iRM1pWH6QhNShIvZzlWxuMKz2Dtv0
	 yJPKMIxLM6Qv3J+zBoDaKYPWotRY8AmcCcjWIcVyhrdYktRfEfLynIthyTcyIES5W1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918456;
	bh=/AxGcG4fWDCuE+0PNw6/3N8jrGEKSUuRgQI4WbGWtr4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/lRw3RaNV/8o3XTFZUbSugVyJnJI51Fm0COSm6u/rFlA/SYlnvdhx/A1rXK9l5nk
	 tUW00wCnHC0V1pAox5DLMRHqYWQ4F5Ewpz7//I70LC1dDIBW09Bj7U3xCnfgao53eE
	 idocGMRv+LGgiNDMdVFHFLI7aFaErtXb2nDNAX4L+UT4Tprk4Wf8IDmirXzHJiq/qx
	 58khlITSzD5rcJeZNCr5Yp4H0Hy9MU5ShW+PLztb+Ht8FFxreh4R76bVyjXm2Y1EEz
	 k6nPmH2tljNHRvskyksXRGz3FEks1QQ7EoHiNnKk7ckgAqY/vR0fcfmxXhoYTz+e5g
	 jAuiKrLLWTE6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 479C2608A6;
	Tue, 17 Nov 2026 12:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B8EE70B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01E8B40308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xd0OAXgVdJCZ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF0714008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yoG52wcX
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF0714008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:31 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so2091492f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918449; x=1795523249;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/AxGcG4fWDCuE+0PNw6/3N8jrGEKSUuRgQI4WbGWtr4=;
 b=yoG52wcXaPbsKoNWTykK69Ne29tqrQlUeqJS0N7/TsXpIkunrTqX9UmPFVfMGx8CPr
 PXnuzX7L6UHAQZMSDTmM2hRJHntG2DG/Qz51tc0qFVJA4HNfnymaCkDWm3PBrop8jJ9i
 KdXGf/tqvqxy68QvMlfG0+KMACg/mMdnE1SOyYOvIaZMjQT/ZTn/NsRXgADhfp9h6pUs
 wkLY1lbK3g6Sm5va8j+84kt8f4K3hlxYQFDWEOU50OxJMtT/vRYBub/9m7nDoeJa7IJJ
 ISr7upndXGeiZ7r1L11LTXKssyNaE2/Eaz3CJdNW7zw4bg5/A1UIYXipl7RCUabe7imf
 PysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918449; x=1795523249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/AxGcG4fWDCuE+0PNw6/3N8jrGEKSUuRgQI4WbGWtr4=;
 b=VGgSItwRNwi2hPFEiVBctIVfxupLRWXwO7u3Z73v93+B5d1v7MLZCH1+mzH9w2oe2q
 QnkljiowffERhQUmb+MU4llAl4AxsEpLhakLU+LUcB1oKhGZ50027ojxzM3hqF2HxM6x
 Q1/MvNAXWdfYXC9bVej7G3TUFmCvm+d+a6LSUfWuAKdZPJiuBhl3jF9GtOd7yw8JPso7
 pPb/6HsEfshOEbRJ1kRiuBsdctw3iF1Ox5Z7rKAZcgbZCeVhP767LH14JvhmHGnNJkp1
 39G6u+E4+YvaJspKJWuLB/RmkmQNvAEBIbGyFEW4WoT/ReLKzi77iopLoGvf5077jAXS
 oILw==
X-Forwarded-Encrypted: i=1;
 AL+hErGsevc8KCyjVG7z0DFKCO+LWiqfB/h9EuylKGzIvFRiGazZw1h4hnvJWggXhie0k5eWns5+mug=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ery17QArWXwfVg5qq9qXA9YfWK70P0AOiFBFPi4Gemzb4vRiO
 QuojpNlz9ZmAOxZheMO4QZlLjhQS10Xchu3YVuxoer/EwvsqDb5mdKG+N93Waw==
X-Gm-Gg: AZFdTZdspT5g0uo8+Bo410SBddKX5RpWYKRf6vYkEhiPKToHoYP/BH3nxYeOs0NF+e5
 ztcz1nQNSiYDfEE0YEeBgSZEj+oOK6F2U8EArTMV1oQsgxjdYr69znvMY29+uB7vfP1VoTFaisR
 tG4CYuiG1JvLblBx9CsJ3u/8mfojfMa/rroSIJhlj/VtJduXth7Zz3brHzcqamr2pMe6/6nngj3
 RagRO61zEB0EGQcfGB3SVreXqvEMHrInmT2iCD9xqAoazvndNPsnPql0p8WLn37UbV7Mziry9GF
 TxA0s9wJg9uIuI5tBZFKH4/SOkulRPnApDRvLiXwena9HOXy8/dOiBpfAGKYNqmJsZIIauQAZtD
 jE42PEWVBlfPcHJsjwJ2XdeaGCGtoa9lssAX5lYmy43Ybd8LEK4FhSP0HxahFeUJNJ9dX2L7ZNI
 99kwR9alKlNqVcbKrardDxyAWLxYjOQXCjgrdvVvkP8XgvNTBtTGRQuHlWjd0aYv/c/2ND3qL2+
 zvxBBJFcVVvjwlucTv4R3QTpRz9tWg/kuhpW03rRQnAQ5F1i+lT2Ik2POY6eGsr9REGS8te1bnK
 mlj2DS91kRE8H3UGz9ZhnU0zBEnbWNrxRENx/90ETwclZaerhwhRRj0JPYqTfdZoL6vN0lDLvhq
 CGz1sYOBj5mw8BOnhpenvDDt1N7B4xGVYVw==
X-Received: by 2002:a05:6000:4812:b0:49b:f45e:655f with SMTP id
 ffacd0b85a97d-49c72ba71e7mr27098259f8f.45.1794918449398; 
 Tue, 17 Nov 2026 04:27:29 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:28 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 4/9] misc: fs_loader: validate requested offset on reading
 file
Date: Tue, 17 Nov 2026 13:27:09 +0100
Message-ID: <20261117122715.7983-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure we are not requesting an offset for the requesting file beyond
the size of the file.

If it's such the case, log an error and return -EINVAL.

Code is reworked and split in various subfunction to permit re-preparing
the filesystem after a fs_close (called by fs_size) and reduce patch delta
of upcoming support for reading ONLY the size of the requested firmware.

Dedicated mount function are created to mount relevant filesystem only once
and follow the same if-else logic pattern used by the prepare functions.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fw_loader/fs_loader.c | 98 ++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
index b1eb0311dd2b..01b0a221c8a7 100644
--- a/drivers/misc/fw_loader/fs_loader.c
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -49,6 +49,16 @@ static int mount_ubifs(char *mtdpart, char *ubivol)
 }
 #endif
 
+static int mount_fs_dev(struct fw_loader_plat *plat)
+{
+	if (plat->phandlepart.phandle)
+		return 0;
+	else if (plat->mtdpart && plat->ubivol)
+		return mount_ubifs(plat->mtdpart, plat->ubivol);
+	else
+		return 0;
+}
+
 static int select_fs_dev(struct fw_loader_plat *plat)
 {
 	int ret;
@@ -63,10 +73,6 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 			ret = fs_set_blk_dev_with_part(desc,
 				plat->phandlepart.partition);
 	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
 		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
 	} else {
 		debug("Error: unsupported storage device.\n");
@@ -79,18 +85,26 @@ static int select_fs_dev(struct fw_loader_plat *plat)
 	return ret;
 }
 
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
+static int fw_get_filesystem_mount(struct udevice *dev)
+{
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info info = { };
+
+	generic_fw_loader_env_info(&info);
+
+	if (info.storage_interface && info.dev_part)
+		return 0;
+	else if (info.storage_interface && info.ubi_mtdpart &&
+		 info.ubi_volume)
+		return mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
+	else
+		return mount_fs_dev(plat);
+}
+
+static int fw_get_filesystem_prepare(struct udevice *dev)
 {
-	struct firmware *upriv = dev_get_uclass_priv(dev);
 	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
 	struct fw_loader_env_info info = { };
-	loff_t actread = 0;
 	int ret;
 
 	generic_fw_loader_env_info(&info);
@@ -100,10 +114,6 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 				     info.dev_part, FS_TYPE_ANY);
 	} else if (info.storage_interface && info.ubi_mtdpart &&
 		   info.ubi_volume) {
-		ret = mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
-		if (ret)
-			return ret;
-
 		if (!strcmp("ubi", info.storage_interface))
 			ret = fs_set_blk_dev(info.storage_interface, NULL,
 					     FS_TYPE_UBIFS);
@@ -113,6 +123,56 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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
+	ret = fw_get_filesystem_mount(dev);
+	if (ret)
+		goto out;
+
+	ret = __fw_get_filesystem_firmware_size(dev, upriv->name, &size);
+	if (ret)
+		goto out;
+
+	if (upriv->offset > size) {
+		log_err("Offset %#x beyond file size %#llx\n",
+			upriv->offset, size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = fw_get_filesystem_prepare(dev);
 	if (ret)
 		goto out;
 
@@ -127,9 +187,7 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
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

