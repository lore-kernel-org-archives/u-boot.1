Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A71C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 16:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728438498B;
	Sat, 11 Jul 2026 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W8cuWrFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931F284A3C; Sat, 11 Jul 2026 18:08:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B5818498B
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 18:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ca=FG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783786111; bh=BDW9k/cD3+RAkyUdhqnxRjkhcCmkxrefRMBnRjD+CtY=;
 b=W8cuWrFtXHrJZtcLjLXQP3RkPRJIVEDiTwtsMM1i+PFkSPI9wcSX0RX3yLuBysEeRbVCSCrrz
 XXdjrtqW9kf1BoLFyS3WE8GFQ1u/FNUQMHVGcf5wHZAJ8ffH9gMi2/esF6IwY4KspP8bkqBJyJR
 mo6w7qFsedPKI9s9UGmIpamupajmgLWYoyLasDlx4ZfCHBTzsojGi5d7gUyYCj6xIDZ1NI85Rw5
 peFt76+e9aPw9lossQDF6P9Fru41yo2J62sKqDqY+Uo+crWGmOlMGoeL7JH56HDuaFCbKIeGsRm
 vDkwVZ9zk7z8o1+zjBA84GlhBnXw8t5TdlKJQFDt5WVA==
X-Forward-Email-ID: 6a526a7b1b09fea89cb124cb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/8] usb: Sync linux/usb/cdc.h from Linux
Date: Sat, 11 Jul 2026 16:08:01 +0000
Message-ID: <20260711160808.2022242-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711160808.2022242-1-jonas@kwiboo.se>
References: <20260711160808.2022242-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CDC NCM constants and structures added in Linux commit 01154aa71424
("usb: cdc: ncm constants and structures added") are missing from
U-Boot.

Sync with Linux commit a67df6d1b939 ("uapi: cdc.h: cleanly provide for
more interfaces and countries") from v6.19-rc1 to add any missing CDC
related constants and structures.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/linux/usb/cdc.h | 233 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 1 deletion(-)

diff --git a/include/linux/usb/cdc.h b/include/linux/usb/cdc.h
index 442316b4e2cf..2118a4b5df6e 100644
--- a/include/linux/usb/cdc.h
+++ b/include/linux/usb/cdc.h
@@ -15,6 +15,9 @@
 #define USB_CDC_SUBCLASS_DMM			0x09
 #define USB_CDC_SUBCLASS_MDLM			0x0a
 #define USB_CDC_SUBCLASS_OBEX			0x0b
+#define USB_CDC_SUBCLASS_EEM			0x0c
+#define USB_CDC_SUBCLASS_NCM			0x0d
+#define USB_CDC_SUBCLASS_MBIM			0x0e
 
 #define USB_CDC_PROTO_NONE			0
 
@@ -26,6 +29,11 @@
 #define USB_CDC_ACM_PROTO_AT_CDMA		6
 #define USB_CDC_ACM_PROTO_VENDOR		0xff
 
+#define USB_CDC_PROTO_EEM			7
+
+#define USB_CDC_NCM_PROTO_NTB			1
+#define USB_CDC_MBIM_PROTO_NTB			2
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -44,6 +52,9 @@
 #define USB_CDC_MDLM_DETAIL_TYPE	0x13	/* mdlm_detail_desc */
 #define USB_CDC_DMM_TYPE		0x14
 #define USB_CDC_OBEX_TYPE		0x15
+#define USB_CDC_NCM_TYPE		0x1a
+#define USB_CDC_MBIM_TYPE		0x1b
+#define USB_CDC_MBIM_EXTENDED_TYPE	0x1c
 
 /* "Header Functional Descriptor" from CDC spec  5.2.3.1 */
 struct usb_cdc_header_desc {
@@ -80,7 +91,7 @@ struct usb_cdc_acm_descriptor {
 
 #define USB_CDC_COMM_FEATURE	0x01
 #define USB_CDC_CAP_LINE	0x02
-#define USB_CDC_CAP_BRK	0x04
+#define USB_CDC_CAP_BRK		0x04
 #define USB_CDC_CAP_NOTIFY	0x08
 
 /* "Union Functional Descriptor" from CDC spec 5.2.3.8 */
@@ -130,6 +141,15 @@ struct usb_cdc_ether_desc {
 	__u8	bNumberPowerFilters;
 } __attribute__ ((packed));
 
+/* "Telephone Control Model Functional Descriptor" from CDC WMC spec 6.3..3 */
+struct usb_cdc_dmm_desc {
+	__u8	bFunctionLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubtype;
+	__u16	bcdVersion;
+	__le16	wMaxCommand;
+} __attribute__ ((packed));
+
 /* "MDLM Functional Descriptor" from CDC WMC spec 6.7.2.3 */
 struct usb_cdc_mdlm_desc {
 	__u8	bLength;
@@ -151,6 +171,50 @@ struct usb_cdc_mdlm_detail_desc {
 	__u8	bDetailData[0];
 } __attribute__ ((packed));
 
+/* "OBEX Control Model Functional Descriptor" */
+struct usb_cdc_obex_desc {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubType;
+
+	__le16	bcdVersion;
+} __attribute__ ((packed));
+
+/* "NCM Control Model Functional Descriptor" */
+struct usb_cdc_ncm_desc {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubType;
+
+	__le16	bcdNcmVersion;
+	__u8	bmNetworkCapabilities;
+} __attribute__ ((packed));
+
+/* "MBIM Control Model Functional Descriptor" */
+struct usb_cdc_mbim_desc {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubType;
+
+	__le16	bcdMBIMVersion;
+	__le16  wMaxControlMessage;
+	__u8    bNumberFilters;
+	__u8    bMaxFilterSize;
+	__le16  wMaxSegmentSize;
+	__u8    bmNetworkCapabilities;
+} __attribute__ ((packed));
+
+/* "MBIM Extended Functional Descriptor" from CDC MBIM spec 1.0 errata-1 */
+struct usb_cdc_mbim_extended_desc {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubType;
+
+	__le16	bcdMBIMExtendedVersion;
+	__u8	bMaxOutstandingCommandMessages;
+	__le16	wMTU;
+} __attribute__ ((packed));
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -174,6 +238,17 @@ struct usb_cdc_mdlm_detail_desc {
 #define USB_CDC_GET_ETHERNET_PM_PATTERN_FILTER	0x42
 #define USB_CDC_SET_ETHERNET_PACKET_FILTER	0x43
 #define USB_CDC_GET_ETHERNET_STATISTIC		0x44
+#define USB_CDC_GET_NTB_PARAMETERS		0x80
+#define USB_CDC_GET_NET_ADDRESS			0x81
+#define USB_CDC_SET_NET_ADDRESS			0x82
+#define USB_CDC_GET_NTB_FORMAT			0x83
+#define USB_CDC_SET_NTB_FORMAT			0x84
+#define USB_CDC_GET_NTB_INPUT_SIZE		0x85
+#define USB_CDC_SET_NTB_INPUT_SIZE		0x86
+#define USB_CDC_GET_MAX_DATAGRAM_SIZE		0x87
+#define USB_CDC_SET_MAX_DATAGRAM_SIZE		0x88
+#define USB_CDC_GET_CRC_MODE			0x89
+#define USB_CDC_SET_CRC_MODE			0x8a
 
 /* Line Coding Structure from CDC spec 6.2.13 */
 struct usb_cdc_line_coding {
@@ -193,6 +268,10 @@ struct usb_cdc_line_coding {
 	__u8	bDataBits;
 } __attribute__ ((packed));
 
+/* Control Signal Bitmap Values from 6.2.14 SetControlLineState */
+#define USB_CDC_CTRL_DTR			(1 << 0)
+#define USB_CDC_CTRL_RTS			(1 << 1)
+
 /* table 62; bits in multicast filter */
 #define	USB_CDC_PACKET_TYPE_PROMISCUOUS		(1 << 0)
 #define	USB_CDC_PACKET_TYPE_ALL_MULTICAST	(1 << 1) /* no filter */
@@ -222,3 +301,155 @@ struct usb_cdc_notification {
 	__le16	wIndex;
 	__le16	wLength;
 } __attribute__ ((packed));
+
+/* UART State Bitmap Values from 6.3.5 SerialState */
+#define USB_CDC_SERIAL_STATE_DCD		(1 << 0)
+#define USB_CDC_SERIAL_STATE_DSR		(1 << 1)
+#define USB_CDC_SERIAL_STATE_BREAK		(1 << 2)
+#define USB_CDC_SERIAL_STATE_RING_SIGNAL	(1 << 3)
+#define USB_CDC_SERIAL_STATE_FRAMING		(1 << 4)
+#define USB_CDC_SERIAL_STATE_PARITY		(1 << 5)
+#define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
+
+struct usb_cdc_speed_change {
+	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
+	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
+} __attribute__ ((packed));
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Class Specific structures and constants
+ *
+ * CDC NCM NTB parameters structure, CDC NCM subclass 6.2.1
+ *
+ */
+
+struct usb_cdc_ncm_ntb_parameters {
+	__le16	wLength;
+	__le16	bmNtbFormatsSupported;
+	__le32	dwNtbInMaxSize;
+	__le16	wNdpInDivisor;
+	__le16	wNdpInPayloadRemainder;
+	__le16	wNdpInAlignment;
+	__le16	wPadding1;
+	__le32	dwNtbOutMaxSize;
+	__le16	wNdpOutDivisor;
+	__le16	wNdpOutPayloadRemainder;
+	__le16	wNdpOutAlignment;
+	__le16	wNtbOutMaxDatagrams;
+} __attribute__ ((packed));
+
+/*
+ * CDC NCM transfer headers, CDC NCM subclass 3.2
+ */
+
+#define USB_CDC_NCM_NTH16_SIGN		0x484D434E /* NCMH */
+#define USB_CDC_NCM_NTH32_SIGN		0x686D636E /* ncmh */
+
+struct usb_cdc_ncm_nth16 {
+	__le32	dwSignature;
+	__le16	wHeaderLength;
+	__le16	wSequence;
+	__le16	wBlockLength;
+	__le16	wNdpIndex;
+} __attribute__ ((packed));
+
+struct usb_cdc_ncm_nth32 {
+	__le32	dwSignature;
+	__le16	wHeaderLength;
+	__le16	wSequence;
+	__le32	dwBlockLength;
+	__le32	dwNdpIndex;
+} __attribute__ ((packed));
+
+/*
+ * CDC NCM datagram pointers, CDC NCM subclass 3.3
+ */
+
+#define USB_CDC_NCM_NDP16_CRC_SIGN	0x314D434E /* NCM1 */
+#define USB_CDC_NCM_NDP16_NOCRC_SIGN	0x304D434E /* NCM0 */
+#define USB_CDC_NCM_NDP32_CRC_SIGN	0x316D636E /* ncm1 */
+#define USB_CDC_NCM_NDP32_NOCRC_SIGN	0x306D636E /* ncm0 */
+
+#define USB_CDC_MBIM_NDP16_IPS_SIGN     0x00535049 /* IPS<sessionID> : IPS0 for now */
+#define USB_CDC_MBIM_NDP32_IPS_SIGN     0x00737069 /* ips<sessionID> : ips0 for now */
+#define USB_CDC_MBIM_NDP16_DSS_SIGN     0x00535344 /* DSS<sessionID> */
+#define USB_CDC_MBIM_NDP32_DSS_SIGN     0x00737364 /* dss<sessionID> */
+
+/* 16-bit NCM Datagram Pointer Entry */
+struct usb_cdc_ncm_dpe16 {
+	__le16	wDatagramIndex;
+	__le16	wDatagramLength;
+} __attribute__((__packed__));
+
+/* 16-bit NCM Datagram Pointer Table */
+struct usb_cdc_ncm_ndp16 {
+	__le32	dwSignature;
+	__le16	wLength;
+	__le16	wNextNdpIndex;
+	struct	usb_cdc_ncm_dpe16 dpe16[0];
+} __attribute__ ((packed));
+
+/* 32-bit NCM Datagram Pointer Entry */
+struct usb_cdc_ncm_dpe32 {
+	__le32	dwDatagramIndex;
+	__le32	dwDatagramLength;
+} __attribute__((__packed__));
+
+/* 32-bit NCM Datagram Pointer Table */
+struct usb_cdc_ncm_ndp32 {
+	__le32	dwSignature;
+	__le16	wLength;
+	__le16	wReserved6;
+	__le32	dwNextNdpIndex;
+	__le32	dwReserved12;
+	struct	usb_cdc_ncm_dpe32 dpe32[0];
+} __attribute__ ((packed));
+
+/* CDC NCM subclass 3.2.1 and 3.2.2 */
+#define USB_CDC_NCM_NDP16_INDEX_MIN			0x000C
+#define USB_CDC_NCM_NDP32_INDEX_MIN			0x0010
+
+/* CDC NCM subclass 3.3.3 Datagram Formatting */
+#define USB_CDC_NCM_DATAGRAM_FORMAT_CRC			0x30
+#define USB_CDC_NCM_DATAGRAM_FORMAT_NOCRC		0X31
+
+/* CDC NCM subclass 4.2 NCM Communications Interface Protocol Code */
+#define USB_CDC_NCM_PROTO_CODE_NO_ENCAP_COMMANDS	0x00
+#define USB_CDC_NCM_PROTO_CODE_EXTERN_PROTO		0xFE
+
+/* CDC NCM subclass 5.2.1 NCM Functional Descriptor, bmNetworkCapabilities */
+#define USB_CDC_NCM_NCAP_ETH_FILTER			(1 << 0)
+#define USB_CDC_NCM_NCAP_NET_ADDRESS			(1 << 1)
+#define USB_CDC_NCM_NCAP_ENCAP_COMMAND			(1 << 2)
+#define USB_CDC_NCM_NCAP_MAX_DATAGRAM_SIZE		(1 << 3)
+#define USB_CDC_NCM_NCAP_CRC_MODE			(1 << 4)
+#define	USB_CDC_NCM_NCAP_NTB_INPUT_SIZE			(1 << 5)
+
+/* CDC NCM subclass Table 6-3: NTB Parameter Structure */
+#define USB_CDC_NCM_NTB16_SUPPORTED			(1 << 0)
+#define USB_CDC_NCM_NTB32_SUPPORTED			(1 << 1)
+
+/* CDC NCM subclass Table 6-3: NTB Parameter Structure */
+#define USB_CDC_NCM_NDP_ALIGN_MIN_SIZE			0x04
+#define USB_CDC_NCM_NTB_MAX_LENGTH			0x1C
+
+/* CDC NCM subclass 6.2.5 SetNtbFormat */
+#define USB_CDC_NCM_NTB16_FORMAT			0x00
+#define USB_CDC_NCM_NTB32_FORMAT			0x01
+
+/* CDC NCM subclass 6.2.7 SetNtbInputSize */
+#define USB_CDC_NCM_NTB_MIN_IN_SIZE			2048
+#define USB_CDC_NCM_NTB_MIN_OUT_SIZE			2048
+
+/* NTB Input Size Structure */
+struct usb_cdc_ncm_ndp_input_size {
+	__le32	dwNtbInMaxSize;
+	__le16	wNtbInMaxDatagrams;
+	__le16	wReserved;
+} __attribute__ ((packed));
+
+/* CDC NCM subclass 6.2.11 SetCrcMode */
+#define USB_CDC_NCM_CRC_NOT_APPENDED			0x00
+#define USB_CDC_NCM_CRC_APPENDED			0x01
-- 
2.54.0

