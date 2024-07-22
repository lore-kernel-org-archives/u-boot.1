Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F7C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFDF884B2;
	Tue, 23 Jul 2024 01:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qUKriaX0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ge/28LrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDAB88703; Tue, 23 Jul 2024 01:30:04 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226088862C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WSc2B6RHTz9sZt;
 Tue, 23 Jul 2024 01:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrd6FKznbsqqQM1kVoS5PX2N3xEGLzDdiEb9kO8kRfQ=;
 b=qUKriaX0gMXA5ZjFTPMX80rZZshtF9m3+hLRQaUC/oEsoXeZZ52dEtEuoQhgU3MCj6/lat
 fWEem7Vy58R3idNVxbkcNpH13Q8fN9/hVCndT2N9KL79tyRFwxn8bwQP4HsK2EXriUZZGF
 u/zzwMWVvLMTRrt8XS7ap2MiHppPF5wz5utpLYH/cEnnwHYrJtNlDyVxY6XwTxCxGzMEvf
 bxkpZfy6cQDeBivfwvu9SnTD/UkNXR0u+IwWJ5LtrU3zkuXTghVCjkGhx/kfs+S3jxZBtX
 JlVckIqYb/OcQBTXr1StckI/I+N6bOA2LGgRxniKbFSveVUT6Hd/EXMPN09dPw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrd6FKznbsqqQM1kVoS5PX2N3xEGLzDdiEb9kO8kRfQ=;
 b=ge/28LrBONGIiz+wALkCez5vwfZd9o/Z1Ebfr8KeHvDPXiOP1ZhwQPmO27VaRyEWUUcwzn
 b5BhRzqT/788TZXXr2mM19vb4EPFFFpz7pl1OnKaOFqc3P0IHAhkgLlghCM5089+GaQQla
 xoidI5L3UHa+v0Ydf2hFzVE8opMyRTWhNeWBap++64qC6Enx8jtBcY23McVWZwTtdmHemR
 AlO8JOsHUA6Niy4rGR3zmakFCJmkPLmtRBTJOzbHfRhbGMqbNx8qPz9/Ns6F4NCjwIKF3E
 dz4T3wRnGbquhbXUvFo9ZhKR1oDAovNNcynH32ccrCJzwZSVgyL+OYK2q3M/1w==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/15] include: linux: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:26 +0200
Message-ID: <20240722232910.91249-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8b31ae64610bfa62aaf
X-MBO-RS-META: dn6qqm6gwxa69993ek366nm7szra6uao
X-Rspamd-Queue-Id: 4WSc2B6RHTz9sZt
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/linux/asn1.h             |  1 -
 include/linux/bitops.h           |  1 -
 include/linux/byteorder/swab.h   |  2 --
 include/linux/edd.h              |  1 -
 include/linux/err.h              |  1 -
 include/linux/ethtool.h          |  1 -
 include/linux/fb.h               |  2 --
 include/linux/kernel.h           |  1 -
 include/linux/mtd/flashchip.h    |  2 --
 include/linux/mtd/mtd.h          |  2 --
 include/linux/mtd/partitions.h   |  3 ---
 include/linux/mtd/rawnand.h      |  2 --
 include/linux/rbtree.h           |  3 ---
 include/linux/rbtree_augmented.h |  1 -
 include/linux/serial_reg.h       |  1 -
 include/linux/string.h           |  1 -
 include/linux/time.h             |  1 -
 include/linux/usb/ch9.h          |  5 ----
 include/linux/usb/gadget.h       |  4 ---
 include/linux/usb/musb.h         |  1 -
 include/linux/zstd_errors.h      |  4 ---
 include/linux/zstd_lib.h         | 42 --------------------------------
 22 files changed, 82 deletions(-)

diff --git a/include/linux/asn1.h b/include/linux/asn1.h
index a4d0bdd1071..ca208333e1c 100644
--- a/include/linux/asn1.h
+++ b/include/linux/asn1.h
@@ -17,7 +17,6 @@ enum asn1_class {
 };
 #define ASN1_CLASS_BITS	0xc0
 
-
 enum asn1_method {
 	ASN1_PRIM	= 0,	/* Primitive */
 	ASN1_CONS	= 1	/* Constructed */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index d2e5ca026e8..f826d7f3b34 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -108,7 +108,6 @@ static inline int generic_fls(int x)
 	return r;
 }
 
-
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
diff --git a/include/linux/byteorder/swab.h b/include/linux/byteorder/swab.h
index 5efc252acfc..2b41fbac188 100644
--- a/include/linux/byteorder/swab.h
+++ b/include/linux/byteorder/swab.h
@@ -76,7 +76,6 @@
 #  define __arch__swab64s(x) do { *(x) = __swab64p((x)); } while (0)
 #endif
 
-
 /*
  * Allow constant folding
  */
@@ -99,7 +98,6 @@
 #  define __swab64(x) __fswab64(x)
 #endif /* OPTIMIZE */
 
-
 static __inline__ __attribute__((const)) __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
diff --git a/include/linux/edd.h b/include/linux/edd.h
index 992ce7cf9f2..904e3d218d2 100644
--- a/include/linux/edd.h
+++ b/include/linux/edd.h
@@ -35,7 +35,6 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
-
 #define READ_SECTORS 0x02         /* int13 AH=0x02 is READ_SECTORS command */
 #define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
 #define EDD_MBR_SIG_BUF    0x290  /* addr in boot params */
diff --git a/include/linux/err.h b/include/linux/err.h
index 5ede82432d2..7a0b212c813 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -6,7 +6,6 @@
 
 #include <linux/errno.h>
 
-
 /*
  * Kernel pointers have redundant information, so we can use a
  * scheme where we can return either an error code or a dentry
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index aa7d2fd58f4..1b0736c97e6 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -376,7 +376,6 @@ struct ethtool_usrip4_spec {
 	__u8    proto;
 };
 
-
 /**
  * struct ethtool_rxfh_indir - command to get or set RX flow hash indirection
  * @cmd: Specific command number - %ETHTOOL_GRXFHINDIR or %ETHTOOL_SRXFHINDIR
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c820a4f77b4..5fbc30cf42b 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -160,7 +160,6 @@ struct fb_con2fbmap {
 #define VESA_HSYNC_SUSPEND	2
 #define VESA_POWERDOWN		3
 
-
 enum {
 	/* screen: unblanked, hsync: on,  vsync: on */
 	FB_BLANK_UNBLANK       = VESA_NO_BLANKING,
@@ -583,7 +582,6 @@ struct fb_info {
 #define FB_MODE_IS_FIRST	16
 #define FB_MODE_IS_FROM_VAR	32
 
-
 /* drivers/video/fbcmap.c */
 
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5cd6c9dc821..939465f372b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,7 +255,6 @@
  */
 #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
-
 /*
  * swap - swap value of @a and @b
  */
diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index 265e89f02b6..00278da3c20 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -51,7 +51,6 @@ typedef enum {
 	FL_UNKNOWN
 } flstate_t;
 
-
 /* NOTE: confusingly, this can be used to refer to more than one chip at a time,
    if they're interleaved.  This can even refer to individual partitions on
    the same physical chip when present. */
@@ -98,5 +97,4 @@ struct flchip_shared {
 	struct flchip *erasing;
 };
 
-
 #endif /* __MTD_FLASHCHIP_H__ */
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index ee18a63e460..983a55ce70e 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -522,7 +522,6 @@ extern void __put_mtd_device(struct mtd_info *mtd);
 extern struct mtd_info *get_mtd_device_nm(const char *name);
 extern void put_mtd_device(struct mtd_info *mtd);
 
-
 #ifndef __UBOOT__
 struct mtd_notifier {
 	void (*add)(struct mtd_info *mtd);
@@ -530,7 +529,6 @@ struct mtd_notifier {
 	struct list_head list;
 };
 
-
 extern void register_mtd_user (struct mtd_notifier *new);
 extern int unregister_mtd_user (struct mtd_notifier *old);
 #endif
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index 0f5a2332663..1959a695855 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -11,7 +11,6 @@
 
 #include <linux/types.h>
 
-
 /*
  * Partition definition structure:
  *
@@ -49,7 +48,6 @@ struct mtd_partition {
 #define MTDPART_OFS_APPEND	(-1)
 #define MTDPART_SIZ_FULL	(0)
 
-
 struct mtd_info;
 struct device_node;
 
@@ -64,7 +62,6 @@ struct mtd_part_parser_data {
 	struct device_node *of_node;
 };
 
-
 /*
  * Functions dealing with the various ways of partitioning the space
  */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4abaf4734cf..537c62424a1 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -177,7 +177,6 @@ enum nand_ecc_algo {
 /* Bit mask for flags passed to do_nand_read_ecc */
 #define NAND_GET_DEVICE		0x80
 
-
 /*
  * Option constants for bizarre disfunctionality and real
  * features.
@@ -931,7 +930,6 @@ struct nand_chip {
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
 
-
 	int chip_delay;
 	unsigned int options;
 	unsigned int bbt_options;
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1d2b1768c17..3809c3fb8ef 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -32,7 +32,6 @@ struct rb_root {
 	struct rb_node *rb_node;
 };
 
-
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
 #define RB_ROOT	(struct rb_root) { NULL, }
@@ -46,11 +45,9 @@ struct rb_root {
 #define RB_CLEAR_NODE(node)  \
 	((node)->__rb_parent_color = (unsigned long)(node))
 
-
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
 extern void rb_erase(struct rb_node *, struct rb_root *);
 
-
 /* Find logical next and previous nodes in a tree */
 extern struct rb_node *rb_next(const struct rb_node *);
 extern struct rb_node *rb_prev(const struct rb_node *);
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index da04156e8a4..605888dfdf1 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -70,7 +70,6 @@ rbstatic const struct rb_augment_callbacks rbname = {			\
 	rbname ## _propagate, rbname ## _copy, rbname ## _rotate	\
 };
 
-
 #define	RB_RED		0
 #define	RB_BLACK	1
 
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 061371773c0..99d0aeb5da4 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -287,7 +287,6 @@
 #define UART_ACR_ICRRD	0x40	/* ICR Read enable */
 #define UART_ACR_ASREN	0x80	/* Additional status enable */
 
-
 /*
  * These definitions are for the RSA-DV II/S card, from
  *
diff --git a/include/linux/string.h b/include/linux/string.h
index df1c1c5669c..27b2beb9ddb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,7 +14,6 @@ extern char * strtok(char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
 
-
 /*
  * Include machine specific inline routines
  */
diff --git a/include/linux/time.h b/include/linux/time.h
index 14a144d9c9c..0de44cff8d7 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -34,7 +34,6 @@
 
 #define isleap(y) ((((y) % 4) == 0 && ((y) % 100) != 0) || ((y) % 400) == 0)
 
-
 /* Used by other time functions.  */
 struct tm {
     int tm_sec;                   /* Seconds.     [0-60] (1 leap second) */
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index a8fa5d74490..c8c553b930a 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -248,7 +248,6 @@ struct usb_descriptor_header {
 	__u8  bDescriptorType;
 } __attribute__ ((packed));
 
-
 /*-------------------------------------------------------------------------*/
 
 /* USB_DT_DEVICE: Device descriptor */
@@ -272,7 +271,6 @@ struct usb_device_descriptor {
 
 #define USB_DT_DEVICE_SIZE		18
 
-
 /*
  * Device and/or Interface Class codes
  * as found in bDeviceClass or bInterfaceClass
@@ -703,7 +701,6 @@ struct usb_qualifier_descriptor {
 	__u8  bRESERVED;
 } __attribute__ ((packed));
 
-
 /*-------------------------------------------------------------------------*/
 
 /* USB_DT_OTG (from OTG 1.0a supplement) */
@@ -745,7 +742,6 @@ struct usb_interface_assoc_descriptor {
 	__u8  iFunction;
 } __attribute__ ((packed));
 
-
 /*-------------------------------------------------------------------------*/
 
 /* USB_DT_SECURITY:  group of wireless security descriptors, including
@@ -789,7 +785,6 @@ struct usb_encryption_descriptor {
 	__u8  bAuthKeyIndex;
 } __attribute__((packed));
 
-
 /*-------------------------------------------------------------------------*/
 
 /* USB_DT_BOS:  group of device-level capabilities */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index cf2161603d6..c7927df15aa 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -446,7 +446,6 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 		ep->ops->fifo_flush(ep);
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 struct usb_dcd_config_params {
@@ -567,7 +566,6 @@ static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
 #define gadget_for_each_ep(tmp, gadget) \
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
 
-
 /**
  * gadget_is_dualspeed - return true iff the hardware handles high speed
  * @g: controller that might support both high and full speeds
@@ -769,7 +767,6 @@ static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
 	return gadget->ops->pullup(gadget, 0);
 }
 
-
 /*-------------------------------------------------------------------------*/
 
 /**
@@ -856,7 +853,6 @@ struct usb_gadget_driver {
 	void			(*reset)(struct usb_gadget *);
 };
 
-
 /*-------------------------------------------------------------------------*/
 
 /* driver modules register and unregister, as usual.
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index a31ce67a81f..2083cbe79b3 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -128,7 +128,6 @@ struct musb_hdrc_platform_data {
 	const void	*platform_ops;
 };
 
-
 /* TUSB 6010 support */
 
 #define	TUSB6010_OSCCLK_60	16667	/* psec/clk @ 60.0 MHz */
diff --git a/include/linux/zstd_errors.h b/include/linux/zstd_errors.h
index 58b6dd45a96..edba6e1fab5 100644
--- a/include/linux/zstd_errors.h
+++ b/include/linux/zstd_errors.h
@@ -11,11 +11,9 @@
 #ifndef ZSTD_ERRORS_H_398273423
 #define ZSTD_ERRORS_H_398273423
 
-
 /*===== dependency =====*/
 #include <linux/types.h>   /* size_t */
 
-
 /* =====   ZSTDERRORLIB_API : control library symbols visibility   ===== */
 #define ZSTDERRORLIB_VISIBILITY 
 #define ZSTDERRORLIB_API ZSTDERRORLIB_VISIBILITY
@@ -72,6 +70,4 @@ typedef enum {
 ZSTDERRORLIB_API ZSTD_ErrorCode ZSTD_getErrorCode(size_t functionResult);
 ZSTDERRORLIB_API const char* ZSTD_getErrorString(ZSTD_ErrorCode code);   /*< Same as ZSTD_getErrorName, but using a `ZSTD_ErrorCode` enum argument */
 
-
-
 #endif /* ZSTD_ERRORS_H_398273423 */
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index 25f59074271..a4d559c62a2 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -14,7 +14,6 @@
 /* ======   Dependency   ======*/
 #include <linux/types.h>   /* size_t */
 
-
 /* =====   ZSTDLIB_API : control library symbols visibility   ===== */
 #ifndef ZSTDLIB_VISIBLE
 #  if (__GNUC__ >= 4) && !defined(__MINGW32__)
@@ -27,7 +26,6 @@
 #endif
 #define ZSTDLIB_API ZSTDLIB_VISIBLE
 
-
 /* *****************************************************************************
   Introduction
 
@@ -100,7 +98,6 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
 #define ZSTD_BLOCKSIZELOG_MAX  17
 #define ZSTD_BLOCKSIZE_MAX     (1<<ZSTD_BLOCKSIZELOG_MAX)
 
-
 /* *************************************
 *  Simple API
 ***************************************/
@@ -165,7 +162,6 @@ ZSTDLIB_API unsigned long long ZSTD_getDecompressedSize(const void* src, size_t
  *        or an error code if input is invalid */
 ZSTDLIB_API size_t ZSTD_findFrameCompressedSize(const void* src, size_t srcSize);
 
-
 /*======  Helper functions  ======*/
 #define ZSTD_COMPRESSBOUND(srcSize)   ((srcSize) + ((srcSize)>>8) + (((srcSize) < (128<<10)) ? (((128<<10) - (srcSize)) >> 11) /* margin, from 64 to 0 */ : 0))  /* this formula ensures that bound(A) + bound(B) <= bound(A+B) as long as A and B >= 128 KB */
 ZSTDLIB_API size_t      ZSTD_compressBound(size_t srcSize); /*!< maximum compressed size in worst case single-pass scenario */
@@ -175,7 +171,6 @@ ZSTDLIB_API int         ZSTD_minCLevel(void);               /*!< minimum negativ
 ZSTDLIB_API int         ZSTD_maxCLevel(void);               /*!< maximum compression level available */
 ZSTDLIB_API int         ZSTD_defaultCLevel(void);           /*!< default compression level, specified by ZSTD_CLEVEL_DEFAULT, requires v1.5.0+ */
 
-
 /* *************************************
 *  Explicit context
 ***************************************/
@@ -225,7 +220,6 @@ ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx,
                                        void* dst, size_t dstCapacity,
                                  const void* src, size_t srcSize);
 
-
 /* *******************************************
 *  Advanced compression API (Requires v1.4.0+)
 **********************************************/
@@ -243,7 +237,6 @@ ZSTDLIB_API size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx,
  *   In the future, we expect to remove from experimental API entry points which are redundant with this API.
  */
 
-
 /* Compression strategies, listed from fastest to strongest */
 typedef enum { ZSTD_fast=1,
                ZSTD_dfast=2,
@@ -513,7 +506,6 @@ ZSTDLIB_API size_t ZSTD_compress2( ZSTD_CCtx* cctx,
                                    void* dst, size_t dstCapacity,
                              const void* src, size_t srcSize);
 
-
 /* *********************************************
 *  Advanced decompression API (Requires v1.4.0+)
 ************************************************/
@@ -578,7 +570,6 @@ ZSTDLIB_API size_t ZSTD_DCtx_setParameter(ZSTD_DCtx* dctx, ZSTD_dParameter param
  */
 ZSTDLIB_API size_t ZSTD_DCtx_reset(ZSTD_DCtx* dctx, ZSTD_ResetDirective reset);
 
-
 /* **************************
 *  Streaming
 ****************************/
@@ -595,8 +586,6 @@ typedef struct ZSTD_outBuffer_s {
   size_t pos;         /*< position where writing stopped. Will be updated. Necessarily 0 <= pos <= size */
 } ZSTD_outBuffer;
 
-
-
 /*-***********************************************************************
 *  Streaming compression - HowTo
 *
@@ -705,7 +694,6 @@ ZSTDLIB_API size_t ZSTD_compressStream2( ZSTD_CCtx* cctx,
                                          ZSTD_inBuffer* input,
                                          ZSTD_EndDirective endOp);
 
-
 /* These buffer sizes are softly recommended.
  * They are not required : ZSTD_compressStream*() happily accepts any buffer size, for both input and output.
  * Respecting the recommended size just makes it a bit easier for ZSTD_compressStream*(),
@@ -722,7 +710,6 @@ ZSTDLIB_API size_t ZSTD_compressStream2( ZSTD_CCtx* cctx,
 ZSTDLIB_API size_t ZSTD_CStreamInSize(void);    /*< recommended size for input buffer */
 ZSTDLIB_API size_t ZSTD_CStreamOutSize(void);   /*< recommended size for output buffer. Guarantee to successfully flush at least one complete compressed block. */
 
-
 /* *****************************************************************************
  * This following is a legacy streaming API, available since v1.0+ .
  * It can be replaced by ZSTD_CCtx_reset() and ZSTD_compressStream2().
@@ -751,7 +738,6 @@ ZSTDLIB_API size_t ZSTD_flushStream(ZSTD_CStream* zcs, ZSTD_outBuffer* output);
 /*! Equivalent to ZSTD_compressStream2(zcs, output, &emptyInput, ZSTD_e_end). */
 ZSTDLIB_API size_t ZSTD_endStream(ZSTD_CStream* zcs, ZSTD_outBuffer* output);
 
-
 /*-***************************************************************************
 *  Streaming decompression - HowTo
 *
@@ -799,7 +785,6 @@ ZSTDLIB_API size_t ZSTD_decompressStream(ZSTD_DStream* zds, ZSTD_outBuffer* outp
 ZSTDLIB_API size_t ZSTD_DStreamInSize(void);    /*!< recommended size for input buffer */
 ZSTDLIB_API size_t ZSTD_DStreamOutSize(void);   /*!< recommended size for output buffer. Guarantee to successfully flush at least one complete block in all circumstances. */
 
-
 /* ************************
 *  Simple dictionary API
 ***************************/
@@ -827,7 +812,6 @@ ZSTDLIB_API size_t ZSTD_decompress_usingDict(ZSTD_DCtx* dctx,
                                        const void* src, size_t srcSize,
                                        const void* dict,size_t dictSize);
 
-
 /* *********************************
  *  Bulk processing dictionary API
  **********************************/
@@ -863,7 +847,6 @@ ZSTDLIB_API size_t ZSTD_compress_usingCDict(ZSTD_CCtx* cctx,
                                       const void* src, size_t srcSize,
                                       const ZSTD_CDict* cdict);
 
-
 typedef struct ZSTD_DDict_s ZSTD_DDict;
 
 /*! ZSTD_createDDict() :
@@ -884,7 +867,6 @@ ZSTDLIB_API size_t ZSTD_decompress_usingDDict(ZSTD_DCtx* dctx,
                                         const void* src, size_t srcSize,
                                         const ZSTD_DDict* ddict);
 
-
 /* ******************************
  *  Dictionary helper functions
  *******************************/
@@ -919,7 +901,6 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromDDict(const ZSTD_DDict* ddict);
  *  When identifying the exact failure cause, it's possible to use ZSTD_getFrameHeader(), which will provide a more precise error code. */
 ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize);
 
-
 /* *****************************************************************************
  * Advanced dictionary and prefix API (Requires v1.4.0+)
  *
@@ -929,7 +910,6 @@ ZSTDLIB_API unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize);
  * ZSTD_reset_session_and_parameters. Prefixes are single-use.
  ******************************************************************************/
 
-
 /*! ZSTD_CCtx_loadDictionary() : Requires v1.4.0+
  *  Create an internal CDict from `dict` buffer.
  *  Decompression will have to use same dictionary.
@@ -1052,7 +1032,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 
 #endif  /* ZSTD_H_235446 */
 
-
 /* **************************************************************************************
  *   ADVANCED AND EXPERIMENTAL FUNCTIONS
  ****************************************************************************************
@@ -1123,7 +1102,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #define ZSTD_STRATEGY_MIN        ZSTD_fast
 #define ZSTD_STRATEGY_MAX        ZSTD_btultra2
 
-
 #define ZSTD_OVERLAPLOG_MIN       0
 #define ZSTD_OVERLAPLOG_MAX       9
 
@@ -1133,7 +1111,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
                                            * This limit can be overridden using ZSTD_DCtx_setParameter(,ZSTD_d_windowLogMax,).
                                            * The limit does not apply for one-pass decoders (such as ZSTD_decompress()), since no additional memory is allocated */
 
-
 /* LDM parameter bounds */
 #define ZSTD_LDM_HASHLOG_MIN      ZSTD_HASHLOG_MIN
 #define ZSTD_LDM_HASHLOG_MAX      ZSTD_HASHLOG_MAX
@@ -1149,7 +1126,6 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #define ZSTD_TARGETCBLOCKSIZE_MAX   ZSTD_BLOCKSIZE_MAX
 #define ZSTD_SRCSIZEHINT_MIN        0
 
-
 /* ---  Advanced types  --- */
 
 typedef struct ZSTD_CCtx_params_s ZSTD_CCtx_params;
@@ -1417,7 +1393,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* ds
                                   const ZSTD_Sequence* inSeqs, size_t inSeqsSize,
                                   const void* src, size_t srcSize);
 
-
 /*! ZSTD_writeSkippableFrame() :
  * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
  *
@@ -1453,8 +1428,6 @@ ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, unsign
  */
 ZSTDLIB_API unsigned ZSTD_isSkippableFrame(const void* buffer, size_t size);
 
-
-
 /* *************************************
 *  Memory management
 ***************************************/
@@ -1555,7 +1528,6 @@ ZSTDLIB_STATIC_API const ZSTD_DDict* ZSTD_initStaticDDict(
                                         ZSTD_dictLoadMethod_e dictLoadMethod,
                                         ZSTD_dictContentType_e dictContentType);
 
-
 /*! Custom memory allocation :
  *  These prototypes make it possible to pass your own allocation/free functions.
  *  ZSTD_customMem is provided at creation time, using ZSTD_create*_advanced() variants listed below.
@@ -1594,7 +1566,6 @@ ZSTDLIB_STATIC_API ZSTD_threadPool* ZSTD_createThreadPool(size_t numThreads);
 ZSTDLIB_STATIC_API void ZSTD_freeThreadPool (ZSTD_threadPool* pool);  /* accept NULL pointer */
 ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refThreadPool(ZSTD_CCtx* cctx, ZSTD_threadPool* pool);
 
-
 /*
  * This API is temporary and is expected to change or disappear in the future!
  */
@@ -1611,7 +1582,6 @@ ZSTDLIB_STATIC_API ZSTD_DDict* ZSTD_createDDict_advanced(
     ZSTD_dictContentType_e dictContentType,
     ZSTD_customMem customMem);
 
-
 /* *************************************
 *  Advanced compression functions
 ***************************************/
@@ -1669,7 +1639,6 @@ size_t ZSTD_compress_usingCDict_advanced(ZSTD_CCtx* cctx,
                                         const ZSTD_CDict* cdict,
                                               ZSTD_frameParameters fParams);
 
-
 /*! ZSTD_CCtx_loadDictionary_byReference() :
  *  Same as ZSTD_CCtx_loadDictionary(), but dictionary content is referenced, instead of being copied into CCtx.
  *  It saves some memory, but also requires that `dict` outlives its usage within `cctx` */
@@ -1933,7 +1902,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_CCtx_refPrefix_advanced(ZSTD_CCtx* cctx, const vo
  */
 ZSTDLIB_STATIC_API size_t ZSTD_CCtx_getParameter(const ZSTD_CCtx* cctx, ZSTD_cParameter param, int* value);
 
-
 /*! ZSTD_CCtx_params :
  *  Quick howto :
  *  - ZSTD_createCCtxParams() : Create a ZSTD_CCtx_params structure
@@ -2010,7 +1978,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_compressStream2_simpleArgs (
                       const void* src, size_t srcSize, size_t* srcPos,
                             ZSTD_EndDirective endOp);
 
-
 /* *************************************
 *  Advanced decompression functions
 ***************************************/
@@ -2135,7 +2102,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_DCtx_getParameter(ZSTD_DCtx* dctx, ZSTD_dParamete
  */
 #define ZSTD_d_refMultipleDDicts ZSTD_d_experimentalParam4
 
-
 /*! ZSTD_DCtx_setFormat() :
  *  This function is REDUNDANT. Prefer ZSTD_DCtx_setParameter().
  *  Instruct the decoder context about what kind of data to decode next.
@@ -2156,7 +2122,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_decompressStream_simpleArgs (
                             void* dst, size_t dstCapacity, size_t* dstPos,
                       const void* src, size_t srcSize, size_t* srcPos);
 
-
 /* ******************************************************************
 *  Advanced streaming functions
 *  Warning : most of these functions are now redundant with the Advanced API.
@@ -2274,7 +2239,6 @@ size_t ZSTD_initCStream_usingCDict_advanced(ZSTD_CStream* zcs,
 ZSTD_DEPRECATED("use ZSTD_CCtx_reset, see zstd.h for detailed instructions")
 size_t ZSTD_resetCStream(ZSTD_CStream* zcs, unsigned long long pledgedSrcSize);
 
-
 typedef struct {
     unsigned long long ingested;   /* nb input bytes read and buffered */
     unsigned long long consumed;   /* nb input bytes actually compressed */
@@ -2307,7 +2271,6 @@ ZSTDLIB_STATIC_API ZSTD_frameProgression ZSTD_getFrameProgression(const ZSTD_CCt
  */
 ZSTDLIB_STATIC_API size_t ZSTD_toFlushNow(ZSTD_CCtx* cctx);
 
-
 /*=====   Advanced Streaming decompression functions  =====*/
 
 /*!
@@ -2342,7 +2305,6 @@ ZSTDLIB_STATIC_API size_t ZSTD_initDStream_usingDDict(ZSTD_DStream* zds, const Z
  */
 ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
 
-
 /* *******************************************************************
 *  Buffer-less and synchronous inner streaming functions
 *
@@ -2504,9 +2466,6 @@ ZSTDLIB_STATIC_API void   ZSTD_copyDCtx(ZSTD_DCtx* dctx, const ZSTD_DCtx* prepar
 typedef enum { ZSTDnit_frameHeader, ZSTDnit_blockHeader, ZSTDnit_block, ZSTDnit_lastBlock, ZSTDnit_checksum, ZSTDnit_skippableFrame } ZSTD_nextInputType_e;
 ZSTDLIB_STATIC_API ZSTD_nextInputType_e ZSTD_nextInputType(ZSTD_DCtx* dctx);
 
-
-
-
 /* ============================ */
 /*       Block level API       */
 /* ============================ */
@@ -2544,6 +2503,5 @@ ZSTDLIB_STATIC_API size_t ZSTD_compressBlock  (ZSTD_CCtx* cctx, void* dst, size_
 ZSTDLIB_STATIC_API size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const void* src, size_t srcSize);
 ZSTDLIB_STATIC_API size_t ZSTD_insertBlock    (ZSTD_DCtx* dctx, const void* blockStart, size_t blockSize);  /*< insert uncompressed block into `dctx` history. Useful for multi-blocks decompression. */
 
-
 #endif   /* ZSTD_H_ZSTD_STATIC_LINKING_ONLY */
 
-- 
2.43.0

