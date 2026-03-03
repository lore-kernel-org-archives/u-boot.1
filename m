Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1265EB3655
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 02:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E322A83F59;
	Tue,  3 Mar 2026 03:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vn5XioGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427E683F8E; Tue,  3 Mar 2026 03:31:07 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F9B583F82
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 03:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOtvD235HLqBQHjOKvhczDmtl7BijPJLrQcvQ959oQsX0XJqpdIPrJB1h3YlIdIlfqX1bHr8jlO0HY+wJRypITzUvbw67cF+6pyZxyAI2W/SPfR9ZuU9zbuRAcXxiZwsjs78kYLk/Rw1svZH7rwuf91vAmVhnlk2FAbn82QH3qJQ4Sh0tGht8w+LMfBZD9F+Bwasbj84aTmK15O4YbU6vWkpYVEkAwDlB5IQ7koyIPca4xkOBWABJhN8f+Gp9SmJ7L7zTLyQo93jkybdS9J71zdgei1U0xWaDxy/+8NKwojigD7sT39utR0BVEp1BWPx67YnZj6NYY/HDadQQoIc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Zcx7zX/9MI1dg6ejegjQWng7BhUhzMExrs3BIlVrQ=;
 b=A74SM/YypV3u69I3tgmBZXAxAf2rNdPZar0OYosGfu2tYv0e1Dz7dNDDaQuH+m78ij+wDmJK3Tua0fg4gJQVRbpNlEdrSVQ+hgU3qCRskjq6QBGmJ90ifPGvGwgjB3ywVMfNTwcwBEBBRBi7wXCdOAEehf0oMnEs0Vk+dmjUbxCGSjnBJht8xZs3jvo+P8yBg5fYgWCrFw98QW1hq5i6ej8F5qc4mqbokdlFDdx6o4MyWU0fTIJAYqy+CdFra9LhM3wtmGwHi19VcV/aP1aLHAtxg+BS+G1vG3aWbnTNzN1Qpg4CVQPN6aZcFDr9PXZpBZMGvLoItR0vQvkx887moQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Zcx7zX/9MI1dg6ejegjQWng7BhUhzMExrs3BIlVrQ=;
 b=vn5XioGMkmjbtGMZlAm1ALjrcp73JfBThUWZ+dub5ghR27oSKOrvbeiHW2sY6/IX3Tj7BBfHeMobR2/F2Bz9p9ruWQAKXzc9MNq0G4i4wSJhoqQz0Hr1ItvqiFLBL6prdA+YhC1VTe3guf+jGKev9fxvzlKIvJYIYPiJdvTw/el08NIoGyQGUtG+5BQEpWtemAydqPmpzlD1cte0/tRTy8VXrnqQ/ocnS0fWG1ZUAkvXhiJ9LBJMYzCu91Q8KyuB6u1WARz/j8NOWSUF8mawfp0DnU1e1P8dN9z58hrhDO5jNp2HhIVna1SsBkUL9bmxUSg+DG0RsFdJ0P9pxtitpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 02:31:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:31:02 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 03 Mar 2026 09:10:29 +0800
Subject: [PATCH v3 4/4] imx943_evk: Enable XSPI1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-xspi-v1-4-8383ba6fdda8@nxp.com>
References: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
In-Reply-To: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b73b98-2a83-44c3-c986-08de78cce9ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 2LBCPSYelQyeHrwUfvTfvjqxgT+n7TTPmSWxMasthgkbHdbf5k5RghlAtZFhe75C2jcRTMVI7na0LcSJh/kXxqa/0Q9vzSiExoaLpRBhZyrLgZgctKsMnsiL4v9Y+LnH8uu0kZh9tDPHzfNJvfb3IbCKusgVrFb3OgFsTl45fLGsKtcFh+1rPK6b2KrOYCl+oz7KrrFdo0cFCnFvh5va+KMksmSlydcdKMu04agWqUyGO0VGQ7uNfwAoJ7oaYmnFU7t2cGyBN+1nSSMX9JS7MWC7KunrJid+g2+nCNEVxUkBHaMJ7o0GkdLgrgbzl1WzX8FPVNNR7dQnyJSp4c13uSaCLhU9XRVI8ksjj6pJ5DM2UmpcORKlRVtBoFeDvcirlcsdiKu9YkswVn3a6a/ZilflDCnuCtHpo7Lal2jb6z4GPhgzMHhAqESM2uJyxBwX729ZgktTAObC6RoTpJbcVoiZa+XLFcBqUyJmIfUoUdjbwTMrgqWtxUC+g98GlddOIdFqbam/CTAEWAliB7IVtnU1yYteRb2EULHqB2BOUkMj61SUwbMCyrBMhw+jFWaBQbI0JYvpG1A5ljcyizr9g3oaL+aEOEerX2ojNbCvEf9NwSGiJlAB7W1T/c3u5A0/cBTssWiUXtuv1wqz9LN3F9/kdfOsQIIoUz+4+QsAJoa/EHCMKlFBYlz43X12HhKJdRBtk6gZM7oEKE80vOrGmnOHN9pvqcK9EUrMVGuIf8t/QAJ2ZzHy8VeT+h9yeWJMPnPxAOF+qmmbaqhRYltqoOKpUg7Zw1l+Bl37wXq2tqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1IvdkFMQURhUTlrYVBGLzMraU9uQnFMbVFHbmhkZTRleDNFV2VnTnRpRytC?=
 =?utf-8?B?OFVHRGpjQVpsaGJyTDZ3MitJZ3ZHV1RGdHdKbk9MR1FCdlU1cGR0SS9SZDky?=
 =?utf-8?B?QlEraU5DbDRudTNINVB6S29UVy9SYjE4R1NYVlJ3eFcvMEpRNUt2azd4ZWl0?=
 =?utf-8?B?Z0lBd1pYOG5ES3JuMjYzaUg5NFZWYVFJL1dpbEFVWHpxaCszS2tLN0JhREVl?=
 =?utf-8?B?NFZxVWdseWJQekFyOVorNDJZd1NUZkJPN1dLUDE3S2pTSnMrUHgwazlXd2dQ?=
 =?utf-8?B?RGpVOEJPaW1yUlBXSXUxa0xsanJrZXRsRERLTXl3TDVQWHdVazVEVjZpWlFj?=
 =?utf-8?B?eStTK056S1lGWnpLQlRqYmRVVkQ4dGVqZ2lXaXVYdG9qRzNwUDNKWlAwVnBI?=
 =?utf-8?B?eUVYdktjYUxiQnRoVUg5SS9DSzQybndzV2N5cDZxSEpFbWNObndTM3JjdGFv?=
 =?utf-8?B?L0FIT0dhdmhZNUkrZk8yV1A1VHFjQ3p4b3IxMkRsUjl0UzE1bkZIMTF0cm5l?=
 =?utf-8?B?SThLcUFwVGxObU5tN1cwc2tMTGtKTGVOdHZ0TzFYd25BcXRBOUxRRFZrVDBk?=
 =?utf-8?B?cEdJMGFZVldTc0FlMU5ZQ3ZEMHZzTXRLTmtmbTlEak5RM01PV1VISDRCQXlh?=
 =?utf-8?B?VVFBL1JPQnBhQkRNenpLUFZjS0RHeHNXS3Q1cVFlWE5oMHRiTklZWnhXUjJi?=
 =?utf-8?B?Z3Y0ZFBzSS8rSjJWckZrNXhMUTF6MTRsRWl2NVZHVXlKeFlhVEh5R1ZkMnNO?=
 =?utf-8?B?WXJMWmlDZ0hyaXU0bjJQdnhuSEpXSWV4eUdWSzg0OUNzVUx0SXlVQlRVK3dz?=
 =?utf-8?B?c1ZhSlYwTlpIODFoMEhMbm1NeUZkYVNMUmYvdk04TjBuMFhOVTdzaTQzU2sy?=
 =?utf-8?B?ZkZwSVJLSTJWWEg5eGFpUDg0UTZXSFdXTWdTQ2hVN0Z5NkZCbnIzSDJmejBm?=
 =?utf-8?B?N2xrM3hmMHppbGFMa1h2a0Y5R1BhUFFUVDduT0ZFa3pZM3F0UTdNbVF4ajVs?=
 =?utf-8?B?ZEZuT01mTFRZWTQyaXgvdHJKcGhXby9iVmRNSEViWUpKS0FwZjZtRTVHRTBU?=
 =?utf-8?B?TGs5M1NGRjBQN0tBTVdoZm1lczF5NXhLOUV2SnUwZFdTVzBVWllQU001UFMx?=
 =?utf-8?B?RkRCL0lRa1FIVnVVY1hBVklnZlV0M2ZRemt3eGpKVHNyWnhCS0QrNktuK3Qz?=
 =?utf-8?B?akM2NHJ5YWJJVnJ1NWNhbTh1TmY3dnl2OHU0NWVxRTAzRm41SWJWeUJQNmdR?=
 =?utf-8?B?Z1FnazhYa2xRaFBuMHBZcndNdml6dU45Z0hIc3dteHRGenplelc5bmFWK0Y0?=
 =?utf-8?B?TEpPaVhIR0JMam8xdjkxL2dUc2gxOXNJVDlYWUZOSGhaQjdLb09GeWdkVVBh?=
 =?utf-8?B?TEhzaGxhcTVlTlhsdmtpMW1nZ0R6Ry93V1I2aVAwMG50RlFaaEgrOE44YWxL?=
 =?utf-8?B?RzZQNE5lS0h5OFUwNWZBLzFwMk9xR1loY3pwaDF3V204MlRYVmdiUDVBVTZq?=
 =?utf-8?B?cUhNMU1ZK3gyYlM2aWdZTlhLRW9KbkZDUlJIQzdLV3I3cDN3MUJId3VtNmZU?=
 =?utf-8?B?MGZFR2x6aHpFZ25HKzZUNWNkOGJ6c1hxNU5pRVJGNENxbmUzeWxzSzhjd0dF?=
 =?utf-8?B?bG9XUTRwajFqTWVzRFJqT1BucDFIZTMxUnl2ZDNBbHdSSTVUazVjVTVJaXZo?=
 =?utf-8?B?Z1A4OS9McmNVZWVQM29RNHNSN0trUXMzNGhEQTBRNmZSNHlkU3lKLzZxaHg1?=
 =?utf-8?B?Y0hybXErV0o1NTN2R3J2elZsSW5GNGk5Tis3TjQzQzhlNHdUU25ya2FWT1Rq?=
 =?utf-8?B?aGRveklIVHV4aU41NXl1UkJ2VjFNSFQzSEtscVFrQ0NjOXBQdFBmb211dEpC?=
 =?utf-8?B?OEM0WWJNdU1mRDJmRHVwK3RZTzB3eGdEcVo1SDE1bWhGbXc1bm02YUpCcms0?=
 =?utf-8?B?UlVDYUpjMWRvZ0U3Zms3eEVIaG9zZnhzQkRrSTA1L0lwVlZ5Q0w0REk5SDhK?=
 =?utf-8?B?WEh1RlRGU2hYcEFqc0VCMHExM2JCcFF3cms3YVRkb0JkMUk5aXhQUUlsdm1Q?=
 =?utf-8?B?WWIzeXpOampTZUZRSWhIZXdIUnBIbU1oMXp4MmduSytCVVpnTkh2WnlZcW9L?=
 =?utf-8?B?TzJObzFWU1hraVNVVHY0alpHMkVWeVN0OFV3L3RhSnNRZXNjRis1VXZZSEhh?=
 =?utf-8?B?blZNMVBzQmVaQUV1YnVTT3p4bVhIb1lydjduWk5CT1p3cUhqNU5Ib2JDc3VD?=
 =?utf-8?B?TEo5MnB1cDAvNmMzNFE4L1J5V1ZkWFBQbHZLWE1TWVYxeUcrd0I5bGNDNmlE?=
 =?utf-8?B?bjBrT1V4T3VONnRRbG9qWjFTN2szTDVNSm55Mm9PZVFTTnVESUJydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b73b98-2a83-44c3-c986-08de78cce9ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:31:02.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7L+5QnFOQagn17q3MmlJ2TAodi4ysH4eqcX/7Yudbc0hi4zzQpUkMkE56AwQ/k2hh4BjA5LIEnylODsFUAfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
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

From: Alice Guo <alice.guo@nxp.com>

With this patch, XSPI1 are functional on the i.MX943 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 34 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 16 ++++++++++++++++
 configs/imx943_evk_defconfig        |  9 +++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 528b3b02a3f..247a7ed6838 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -157,6 +157,24 @@
 	status = "disabled";
 };
 
+&xspi1 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_xspi1>;
+	status = "okay";
+
+	mt35xu512aba: flash@0 {
+		bootph-pre-ram;
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &scmi_iomuxc {
 	pinctrl_emdio: emdiogrp {
 		fsl,pins = <
@@ -205,6 +223,22 @@
 			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
 		>;
 	};
+
+	pinctrl_xspi1: xspi1grp {
+		fsl,pins = <
+			IMX94_PAD_XSPI1_SCLK__XSPI1_A_SCLK	0x3fe
+			IMX94_PAD_XSPI1_SS0_B__XSPI1_A_SS0_B	0x3fe
+			IMX94_PAD_XSPI1_DATA0__XSPI1_A_DATA0	0x3fe
+			IMX94_PAD_XSPI1_DATA1__XSPI1_A_DATA1	0x3fe
+			IMX94_PAD_XSPI1_DATA2__XSPI1_A_DATA2	0x3fe
+			IMX94_PAD_XSPI1_DATA3__XSPI1_A_DATA3	0x3fe
+			IMX94_PAD_XSPI1_DATA4__XSPI1_A_DATA4	0x3fe
+			IMX94_PAD_XSPI1_DATA5__XSPI1_A_DATA5	0x3fe
+			IMX94_PAD_XSPI1_DATA6__XSPI1_A_DATA6	0x3fe
+			IMX94_PAD_XSPI1_DATA7__XSPI1_A_DATA7	0x3fe
+			IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
+		>;
+	};
 };
 
 &pinctrl_reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 2b93ba9a38b..3457442a3b0 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -141,6 +141,22 @@
 
 &aips3 {
 	bootph-all;
+
+	xspi1: spi@42b90000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx94-xspi";
+		reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
+		reg-names = "xspi_base", "xspi_mmap";
+		interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,       // EENV0
+			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,	      // EENV1
+			     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,       // EENV2
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,       // EENV3
+			     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;       // EENV4
+		clocks = <&scmi_clk IMX94_CLK_XSPI1>;
+		clock-names = "xspi";
+		status = "disabled";
+	};
 };
 
 &clk_ext1 {
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index ef4f9a8fcbc..6acb49e47e2 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -107,6 +107,12 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
@@ -127,6 +133,9 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_XSPI=y
 CONFIG_USB=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y

-- 
2.43.0

