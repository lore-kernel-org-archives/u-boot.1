Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36002CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 12:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6568381D;
	Mon,  6 Oct 2025 14:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="enXEcx/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7231C83734; Mon,  6 Oct 2025 14:50:35 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279FC82E34
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78115430134so2970126b3a.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759755031; x=1760359831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W+amXRRSF7kIGRcKWB1QkramV3eTrZSiR05UbxchxUA=;
 b=enXEcx/ifZ4W2+ZUICl1HTlPrjdCCruziGZ60aOhq0TWc4yRnfk2v0cgsocOHjvFtX
 2c4YTDpXutFb4SlaVbcEMx3XXtr/CB2lHgm8aJmwMCgYRaYAD96IjyOyXvlzaKi4JKDm
 ttJKY4b6MOr3vyFewfCAaZucSFFu+9vzfKSHYEPMkJ6/ly9xIN/SJBT7rpTzr6Ur3zWv
 ejiChzNzUk7OGKI4EloUHzbt93mjNG6gRmdpnXHM45riySGfcVpYuzK42a++tbHjtfYA
 dhjq4BZzahOMOKpEouVUwr+fOvlPiTZ14o5sEOA9XZMHZOPu/ZnjJzdQKc7JpNC5oxI2
 8zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759755031; x=1760359831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+amXRRSF7kIGRcKWB1QkramV3eTrZSiR05UbxchxUA=;
 b=TO/wNhntUVrKHIIMyod4sBo9QvUXt7l/zj8sBSt+a95F0ut80YisrcU7oHRMc0zoZ9
 m+1wanUZgd0Ags1oQFs7vm/HqfP9lA7cCeuCrAOb6dVMJKUOLciElrLWM6vaigA6ypCG
 rId2PE6LsIjAe0sOT7UCkmS6ht53cfxTf3YD7ubRfXjPLPhBm0LyTNfjgvpPRBDyYnwb
 MKTTzZkZYe4NxnWYydEiyCKHf1PFewWY8IPTac5i/TwrvTf4PLl8cQbdsozsz61wftKi
 VrS2KbIgNUk1/OYLCoYYoFgzmC/0tn6rN3YtKhU3h5j0h6RX+fF+X2Zvq/zFIelmV17g
 THtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6iEi/FLY8NKaae4n/jON/fL+NiJzOuZ4TTgUQhStTOf30S3dHTOgm+/10pJovh2bCSwcpJLw=@lists.denx.de
X-Gm-Message-State: AOJu0YzBrKCDbMcuZhs/Xayc+nbTZ4JmsefrpAatsGgM+8jk8qDgaTWA
 DWPt0JZVgYCDrANscFLUdbU/+5tqLbvvvjApunNxrYKCPWvUyqtVfNIL47k8XXseGI4=
X-Gm-Gg: ASbGncvx3+lUh7naeYW60HP5URICW3+TGa4iyWUtlu+3LXfSy+/44upbfmuTmxOTPSW
 aLNSyK6IAZngTS242Hkl7jO7bj6tzGNbjU2xOg87tknaqKR7TJCakM7DbbimgJm++8kQpsLMQXe
 ow4bl1jD/F72kz6NglAp+Yr3VqGjo0nLCkjwTfxgx8QFyvnJJUWaNpIv1Tzi+lHYKouHrqzSTve
 a6waQWi/yo977YLOxLSR/+JA3vyF6nVLlquYIuMWqdnwJivcYfN+IFGYEemC6YdDVU1xwv3K0r6
 ViraqhNmzvv/hZsO4vEWmjHoSlC73nMkXK+ElxSvAVEMvJYeikUQEFPOZ74lj6TowdOW5lx3baQ
 xPgOjlADCIR/Eyxq4sEF1CiyrISgHXc2rtjmeYnFK9CNlqavvJIMamg8LWqAJR/81WfomVnTyWY
 Auw1xBA8gtUYph7cFw3/Q4U3bnVr+Y3YjQWcVkGAb/3w==
X-Google-Smtp-Source: AGHT+IEdyJBC+Hd8APMDrAKdYQwNSbcD9TxHQyV7pZ0itYKaN3zj5eMhT8aBU0xLI3rjGe0kmBFNSg==
X-Received: by 2002:a05:6a20:a110:b0:2fb:add5:5580 with SMTP id
 adf61e73a8af0-32b620d8f5bmr16475717637.45.1759755031602; 
 Mon, 06 Oct 2025 05:50:31 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f9cda9sm12548357b3a.13.2025.10.06.05.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 05:50:31 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: jerome.forissier@linaro.org, skylake.huang@mediatek.com,
 s-vadapalli@ti.com, paul.barker.ct@bp.renesas.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
Date: Mon,  6 Oct 2025 20:49:15 +0800
Message-Id: <20251006124915.13647-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Oct 2025 14:52:24 +0200
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

Synchronize paged PHY helpers with Linux v6.17.

Add support for PHY devices that use paged register access by
implementing the following functions:
- phy_save_page(): Save current page number
- phy_select_page(): Switch to a specific page and return previous page
- phy_restore_page(): Restore previously saved page

Also adds read_page and write_page callbacks to the phy_driver
structure to enable driver-specific page handling.

These helpers allow safe access to paged PHY registers by ensuring
proper page selection and restoration,
even in error conditions, which will be used by the Airoha PHY driver.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
Change in PATCH v2:
 * Change the commit message from "Synchronize paged PHY helpers
   with Linux v4.16" to "Linux v6.17."
 * Remove unnecessary commit information.

I have verified the patch by loading Airoha PHY firmware on Banana Pi BPI-R3 Mini.
Since we need to switch pages to access en8811h PHY registers, this patch is necessary
for initializing the PHY and loading the firmware correctly.

1. Implementation in air_en8811.c:
````air_en8811.c````
/*
 * Driver for Airoha EN8811H Ethernet PHY
 */
#define AIR_EXT_PAGE_ACCESS		0x1f
...
...
static int en8811h_read_page(struct phy_device *phydev)
{
	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
}

static int en8811h_write_page(struct phy_device *phydev, int page)
{
	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
}

U_BOOT_PHY_DRIVER(en8811h) = {
	.name = "Airoha EN8811H",
	.uid = EN8811H_PHY_ID,
	.mask = 0x0ffffff0,
	.config = &en8811h_config,
	.probe = &en8811h_probe,
	.read_page = &en8811h_read_page,
	.write_page = &en8811h_write_page,
	.startup = &en8811h_startup,
	.shutdown = &genphy_shutdown,
};
```````End of air_en8811.c`````
2. Test log:
````Test Log````
Net:   16384 bytes read in 1 ms (15.6 MiB/s)
131072 bytes read in 9 ms (13.9 MiB/s)
addr: 0x46000000, size: 0x24000
Found Airoha Firmware.
MD32 firmware version: 24112802
````End of Test Log````

 drivers/net/phy/phy.c | 113 ++++++++++++++++++++++++++++++++++++++++++
 include/phy.h         |   8 +++
 2 files changed, 121 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9702d042296..b58283fe3d5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1250,3 +1250,116 @@ bool phy_interface_is_ncsi(void)
 	return 0;
 #endif
 }
+
+/**
+ * __phy_read_page() - read the current page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns page index or < 0 on error
+ */
+static int __phy_read_page(struct phy_device *phydev)
+{
+	struct phy_driver *drv = phydev->drv;
+
+	if (!drv->read_page) {
+		debug("read_page callback not available, PHY driver not loaded?\n");
+		return -EOPNOTSUPP;
+	}
+
+	return drv->read_page(phydev);
+}
+
+/**
+ * __phy_write_page() - Write a new page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: page index to select
+ *
+ * Returns 0 or < 0 on error.
+ */
+static int __phy_write_page(struct phy_device *phydev, int page)
+{
+	struct phy_driver *drv = phydev->drv;
+
+	if (!drv->write_page) {
+		debug("write_page callback not available, PHY driver not loaded?\n");
+		return -EOPNOTSUPP;
+	}
+
+	return drv->write_page(phydev, page);
+}
+
+/**
+ * phy_save_page() - save the current page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Return the current page number. On error,
+ * returns a negative errno. phy_restore_page() must always be called
+ * after this, irrespective of success or failure of this call.
+ */
+int phy_save_page(struct phy_device *phydev)
+{
+	return __phy_read_page(phydev);
+}
+
+/**
+ * phy_select_page - Switch to a PHY page and return the previous page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: desired page
+ *
+ * NOTE: Save the current PHY page, and set the current page.
+ * On error, returns a negative errno, otherwise returns the previous page number.
+ * phy_restore_page() must always be called after this, irrespective
+ * of success or failure of this call.
+ */
+int phy_select_page(struct phy_device *phydev, int page)
+{
+	int ret, oldpage;
+
+	oldpage = ret = phy_save_page(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (oldpage != page) {
+		ret = __phy_write_page(phydev, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	return oldpage;
+}
+
+/**
+ * phy_restore_page - Restore a previously saved page and propagate status
+ * @phydev: a pointer to a &struct phy_device
+ * @oldpage: the old page, return value from phy_save_page() or phy_select_page()
+ * @ret: operation's return code
+ *
+ * Restoring @oldpage if it is a valid page.
+ * This function propagates the earliest error code from the group of
+ * operations.
+ *
+ * Returns:
+ *   @oldpage if it was a negative value, otherwise
+ *   @ret if it was a negative errno value, otherwise
+ *   phy_write_page()'s negative value if it were in error, otherwise
+ *   @ret.
+ */
+int phy_restore_page(struct phy_device *phydev, int oldpage, int ret)
+{
+	int r;
+
+	if (oldpage >= 0) {
+		r = __phy_write_page(phydev, oldpage);
+
+		/* Propagate the operation return code if the page write
+		 * was successful.
+		 */
+		if (ret >= 0 && r < 0)
+			ret = r;
+	} else {
+		/* Propagate the phy page selection error code */
+		ret = oldpage;
+	}
+
+	return ret;
+}
\ No newline at end of file
diff --git a/include/phy.h b/include/phy.h
index 36354aaf774..ae9fd1652cc 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -123,6 +123,11 @@ struct phy_driver {
 	int (*write_mmd)(struct phy_device *phydev, int devad, int reg,
 			 u16 val);

+	/** @read_page: Return the current PHY register page number */
+	int (*read_page)(struct phy_device *phydev);
+	/** @write_page: Set the current PHY register page number */
+	int (*write_page)(struct phy_device *phydev, int page);
+
 	/* driver private data */
 	ulong data;
 };
@@ -314,6 +319,9 @@ int phy_modify_mmd_changed(struct phy_device *phydev, int devad, u32 regnum,
 			   u16 mask, u16 set);
 int phy_modify_mmd(struct phy_device *phydev, int devad, u32 regnum,
 		   u16 mask, u16 set);
+int phy_save_page(struct phy_device *phydev);
+int phy_select_page(struct phy_device *phydev, int page);
+int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);

 int phy_startup(struct phy_device *phydev);
 int phy_config(struct phy_device *phydev);
--
2.34.1

