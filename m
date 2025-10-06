Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70FCCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 05:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C12D807B1;
	Mon,  6 Oct 2025 07:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GGyVeCU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ED7808AF; Mon,  6 Oct 2025 06:44:54 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3ABD800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 06:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-279e2554c8fso42039025ad.2
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759725890; x=1760330690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lWcBrxJCWjv3P5TvhmJgE06h2lYRXIikIRFuRb6ngYQ=;
 b=GGyVeCU30NvCd3vblnbSxWHgt9+UqIpBjtb87jWcGSEB6i4yFDXiCchwodP/8DJvD5
 ayVHTpzA765bfrIyvDHCGgagjz/kcHIrCxuQ/1rwbLnkzCJv7hMsdFmWbAurAoI3WwID
 7zWEcKVTHx+2oSI6MxVkHInphnyfEp+89dSHi9yN6VKW9hBqmnnDtlJbqGFSZj1eYTWm
 J4QX/hGoKD0uwMRuHIw5q1rJL3nbBoayA8W6dFBKrMejBjTpdWSvC3jJTu3j+Axw7MtA
 AM4rYEOhkPqS/+DyD2c3oI6jGRE7e+DarELG2GMrvFIEvBUjio+xUsUeqEXFD6K4SQvR
 4EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759725890; x=1760330690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lWcBrxJCWjv3P5TvhmJgE06h2lYRXIikIRFuRb6ngYQ=;
 b=Lks6yQQohHu46l23aPZ+ncep8E68J87WFMYvXe+vJL2FUkWswD2r58biAaOSQFktb1
 cP70BGglwSwN/OBHrLD0IeFslZT3Ne2OFhOij389x/bhxCouhMY+E1KZsWLmUYJn7qYE
 5vYKtjRte5HRs62qTdQRnZfugTUAkp5WRzXDudwyvafE+cX8ndgaSOap0dZZfx1aKLVD
 aSE/D56yc+4j1oBSYWIkphTl0ig67rM1j4YttgRdFl+MQT75HojFdLrehHLa1aDKqdhv
 dNw4UMkHAWmoKusm5IzvZ2Q2nbpTOGUmEv3pXKtsliTfk+ftSl/Fb4d052dgIHYrii5w
 gD0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+1B9la1l4VejIcZFRQ8b2Zw0WwBDGZ541G+oDBCN+qM9LO8/+cVSW9Yj3ASPz4A02i14PVwo=@lists.denx.de
X-Gm-Message-State: AOJu0YxX/r6BHCiMpzg3TkAxMzWw6InEfN3dp/f9Ny1m9mf0BYW3/WA8
 09O+xApM4haQTOlFPUpGiTcw5iMCcpD2JeDPt6MNAdhCWF1aC+d5ONZb
X-Gm-Gg: ASbGncs7Jvse7J8ppfGj5kLVArry8MgSRnoHsyxVU+pDuHoeqWTMZMPbhJRS3VA2NR/
 wT64Xe3699JrHXw6jIJ8Cs9Fk5YCzcqoRS/ZD9xDSUboUUn6iQ7X+K+heZWQX1zw4uDcfvxE/92
 uwU0jvnBSZ75quGoMDoqGkxfAcwQDk6DPgAz4UHEr17mGiE9LuB4DHWIXfYlOJGU+oX+diYq0qU
 AkaRNh/V0AHzXRs96MRVAKQLWBIPpJx6OJv5jN79mIM7WLk+azyWUhIG0dJM0N5EeappnScszdZ
 V1nqC6+mas6uUQbxQSBqP4YNJK+cjJjkZu+m2FZ1Mw0h+M9wQ4R7Spgh6jIsFkSt4rgeidiT8AU
 qrAsbkAHoStgAIr5z+zkJgWJs/F+7oMJEGHr5QNCDHrMG58/BcG3NWd2oh6KqKSRG9Xsn5zrbGW
 pXGiSOZpdwCYvqvAU3RYYdQFtPlMp3Y7AgJnm+G26t7ag5eOsJD0ZU
X-Google-Smtp-Source: AGHT+IFjtrS0qVYeawt+D4NNPw6reWrWV8Zr3dUmp5qp9L7Wy62b9GcyOcL7Tbgx8WgcYAiuNs4iOA==
X-Received: by 2002:a17:902:f711:b0:24c:b39f:baaa with SMTP id
 d9443c01a7336-28e9a651a3bmr132591885ad.49.1759725890187; 
 Sun, 05 Oct 2025 21:44:50 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1eee04sm115255325ad.130.2025.10.05.21.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 21:44:49 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: jerome.forissier@linaro.org, skylake.huang@mediatek.com,
 s-vadapalli@ti.com, paul.barker.ct@bp.renesas.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucienzx159@gmail.com
Subject: [U-Boot, v1, 1/1] net: phy: add paged PHY register accessors
Date: Mon,  6 Oct 2025 12:44:05 +0800
Message-Id: <20251006044405.30376-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Oct 2025 07:13:44 +0200
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

Synchronize paged PHY helpers with Linux v4.16.

linux commit
COMMIT 78ffc4acceff48522b92d8fbf8f4a0ffe78838b2
TITLE: net-phy-add-paged-phy-register-accessors.patch

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
I have verified the patch by loading Airoha PHY firmware on an embedded board.
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

 drivers/net/phy/phy.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 include/phy.h         |   8 ++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9702d042296..902b7fd3704 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1250,3 +1250,111 @@ bool phy_interface_is_ncsi(void)
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
+		debug("%s: read_page callback not available.\n", __func__);
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
+		debug("%s: write_page callback not available.\n", __func__);
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
+	int oldpage, ret;
+
+	oldpage = phy_save_page(phydev);
+	if (oldpage < 0)
+		return oldpage;
+
+	if (oldpage == page)
+		return oldpage;
+
+	ret = __phy_write_page(phydev, page);
+	if (ret < 0)
+		return ret;
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
+	if (oldpage < 0)
+		return oldpage; /* propagate original error */
+
+	r = __phy_write_page(phydev, oldpage);
+	if (ret >= 0 && r < 0)
+		ret = r;
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

