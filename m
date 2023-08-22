Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2485CEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 14:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78583864AB;
	Tue, 22 Aug 2023 16:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="EPuK2lTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C79F864A4; Tue, 22 Aug 2023 16:34:38 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn20806.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::806])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D827686492
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 16:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Au1H3HWAsbndVfDFmp7C8KcrkINTagI+PG8W3i7OYAXY4pJhoC0xGkJ1EXPGe82oU3cZOb2unK8khndP46+bEM4vGwfl+KZdJn9hNX34vT5mRoO5flFDKtHHZt9+lmQ/20LYuI9YRYSpd0woJ/aY1tS39OUaFB6pWrpxDAq9CgeW58mbPxaGpxqU/oAzc8U02L12WqkvVsmuBW4Zn+8KvFBEuufBH+Gemw2qVokfP9/8Mv6GpprFrlPrhBNsBcpwdJ1eUMyYHjhEGk1pfz4gWSA1wsG7tZLv/szi0draalWxfJOT7gm7VMu/iOQ6Pv+SVIa7ywNlrcGZw6Qy6uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eowtS77YvGB9XPjLH2RQg0AgyzWf5VlJ15cHF0R3jjA=;
 b=Kstu8IqoPyFf3nwtmCm5DJY5d7558QcBxvf179xTa0VJq5lUgVwQckjLzTOL403orjootDvGFw9gv8WlBcF9Wvw22jJF7rfbOZMAt62LQGByyF+bVPoBL3kgVYnzlah+1eilEfJDS+5v3NhgXUN45DHWIGRjoFWdJe12bL3Q/xcVyMZqZEoCrSinvhYZWUOrBaUVVnQr0eAPVbu6S7NauzuU/4zfFIhBrjgU+6bnq9JhHYxdFc33cj8YlqEzqpleJeY1jXsz/CPJsnGN79zCesSV+z0F/RwS+t2rEUUSSPsLhYdAo7dwmmNLAeaZpmIacWItkH1pvZb3ni2BBjrqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eowtS77YvGB9XPjLH2RQg0AgyzWf5VlJ15cHF0R3jjA=;
 b=EPuK2lToGY16f0T9W1dcNMNpRpGq36jbK3nfZ+lt3VYw6Fv9MDpvklgn1mZMxYUV69ucDBfC2W7aVpIAXctWWKWE/JlUsvsWJGOxDr5IVXVmoLzO94e6BPbOAkmjTbti+hDVgDl0LbpKsPH4OS8/k+jefKRzQ5NqaPsXKlNWC+VdlTlHq4ekJJvVuhCCSK/flngepvjpXyqLqQsyPD1jhFTE7KlO1Y7aeNJ3O9/5jeMn6XM1vMJ6dai784RCMWzb7kmeHyE4Xmuuw3o8r5LROFkH3TJtswQ2jKWyD6pwsu3WJRZyFGx7WloN4xQSMRnNgTg1RYvhy5vT33lBHcXTlw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OSZP286MB1847.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:166::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Tue, 22 Aug
 2023 14:34:30 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 14:34:30 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 2/2] doc: board: starfive: Add more info about supported
 driver
Date: Tue, 22 Aug 2023 22:33:57 +0800
Message-ID: <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230822143357.2818-1-wiagn233@outlook.com>
References: <20230822143357.2818-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yJeup+fIw+FcuhisjVgWh2nOuEVaD5wM]
X-ClientProxiedBy: PSBPR02CA0008.apcprd02.prod.outlook.com (2603:1096:301::18)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230822143357.2818-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d3d086-99eb-49a5-4056-08dba31ce53a
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrG3vTz6Q+SuBzsjDmvYmoNLBZi8ukuFgZpeCfRqcjMA9opHHowznr+HgX+TvamFQHjnVOExkm+W3xpQD7eSQCfz3PRjL3AV7ySwNMCljLoT5qugKvVmURSxW720g4jikn8eh28whkJpRB28C8W3kDZkPL4Pyn0rVJxM1XrjhHlGPImuqIwr+vBHKgsZgGpdltQ6xuygHMejTPR7f/Ex83ysJH14wnEsuSoINqyWquoVObS3URCRPmFiYwyMFYfK8nN1eOhzuNAWG8xqUmpsnJ96H9HDkFb9gAf5clHBJO/mOdODV6/tJ/0Ww9cYVkRHj8xdVtbopoJvEH88FVw5lHoJgEs2G1lKSTit821PiRhnr+IbMR+xAzRSGoiINFn4MYYwu+ht1DpxSB81HF3QKHkDIShPQ5xqnuMz6yrUU3sRNb4QnWnWxY9g6EBkJdLuU+sdsL/ZJoAZjM9LAWLjJwpH1w6VKnVScx5NFB9MJI+kOGChsI+/HJAqjMZC2XPAEo77Zb0ddWumYjls0oprBz53jP4cDu3gIh0jrk5UxAxamIT0sKgHSUc2gxfA4vuDvrNy5rDpHhbFrc/VcpeWEgBBZp6ehqI13OxaS/Oa+iqM/stleEQ0kLUUJQjx4kr5kpADogUJW37mf7HGc4nBzANm/N6mTL7bTnGPVospbor17cgGGGEKTsHdx7PibLWiVKyC/Yd01XMIo4mfCgJDkABKAAf9VRuylIG4NE7QJ8L79J3KdUJ+R6F4DHkKwh1Ug8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmzLnU/sw5Uhk9WHS6K2ZOZv6M8VqfpjIlwaMi7xUYhUfVmp4KcJAEvgyF+ENTooGMZaxAJHKjNUh0qiqTuDitUwkwVif2H9qJUgWlIs18XRth2t3lLOP0ssLpONhbaMOw024j7L0viP8QhTejWaaZw6IOYnrT7y7Xmkr/K9ybAdxl7cwdxiDdXQ3dNHMrTcotidn56u0od+mUr0mqmKAMozzqqAmWdtEQOuxKK3BCcXkdmPO6cbUk7oL7W6xAVD9pLtgef9j/tQB6X19eDyEd09SC9p1Jy90SAsB9AilWuXZujjVkZ8RojJLDyu1KZUOKLro9gHhDpp3iNojKxkZ7fFqAMM8AhVyh0irkVMbeqvflNedr97ztXqP2PF9bJkbmErNgihN886xd07mlAX7SvYL4VYa1wWZKaKrgQrRJOUVkrrWiIyILN8oh1CEq5FH6eS8pTkqhcHtJMkSfmOXHF9c1UnL24n9+4cN+aTimoQYGtoMWOiuhmEUVnha2HVuxjFLPteYaZiw5x6c+AG1syv65HG7JQUIOAqksBJAQMr6nQagpnI4dP97KqG03H8hAMi5GrBp2g/khLdlM4cQizOHzInu0Dy4EJCjAlyNaoGPBAnasoV2mWFgJXSXDX2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6unCdEYjjo1bRM26j4n8xCX6VwF4q6TXqngpPgfjMc+PHpMrUORN35rdxau?=
 =?us-ascii?Q?rpI41oTPe9ulOrTCUkbPnoRjQmSYea7MCevmEl/wnZbIvpQrShnqcXTbPWkA?=
 =?us-ascii?Q?VItt1ndWe6AN5ajJcMpvpFaVGXyzS7v0g+0JA7nDr/GsYmsoU+gcfEsO6s59?=
 =?us-ascii?Q?y8FNmZGAO6viqZnfmqvckZeDieM5Gn6d93Wz1mOxhnoEDvYl2cY48oEf4Y5y?=
 =?us-ascii?Q?qykQdK+Ozo7UnXcBXiuLaaBzLWhB7wm/1vrvLHqAhsKtWcsWaaw2Hz7FX7eB?=
 =?us-ascii?Q?j+Y/SNHlNPKM44pvvzLePBXIFkpC70gnFhR77uC1J2ZXoQAteYnSugbSknUn?=
 =?us-ascii?Q?g/GJMAv7kU//2wHhVmLIqLH3EhGgH5PtPvZWHEg4eajCoRBzOFzy8OZC/xng?=
 =?us-ascii?Q?i6BRTjMo+MEuj/H14MzIzh1Qr6UCmusN3lJyBvBd8+P/toPOSyMkbyw5hflA?=
 =?us-ascii?Q?XLMunm1sPNdZQX/Zi1WZCKarFPXpOga6Inaph/GEaw5PnXRePDLe0a7+Pd/e?=
 =?us-ascii?Q?jkA0mr4h80oRhBYxgnX0hcgHgQNDdeUt7GszitawJafPDmz+exKuK+QRzbXw?=
 =?us-ascii?Q?/eqxXCOzTRIZgIN2VvzmJQX1BkTbCSl0lbMkkFWUCypgllNMLz1ZugOBXdM1?=
 =?us-ascii?Q?wQbbYu3hrJ+vU2uALxqzbhMgUFL7TqqqfcCqyEtA/zxGRYou669pvJptJsMY?=
 =?us-ascii?Q?SyfrEo+Hwh0iEYinaUcqA6DKz/LeFqbPUztLMHm8psgTnhhtHu9SBAQW8lb1?=
 =?us-ascii?Q?QTTiSHcnK5mpqxusRbCjZSU7VRIeue+teQJ1JwHjK3BuFZoGdS9UOff/2x9t?=
 =?us-ascii?Q?lAbJ/pqOeQiuVaYSpH8oekvmcd1p37DV3P1AvPBePZzDwAk47ZmHELUmOgyM?=
 =?us-ascii?Q?QDG5sJZ9ZRFCqRDTPcqS9YLZFcZ95ZIjif+4ts5aUSKzvl5tj6z551VD6cV1?=
 =?us-ascii?Q?dCPLDxzMp2iOTq/6J+XSxG0+YidahMkAiv7BIq2RcTzVS456Eg07eWMXyY94?=
 =?us-ascii?Q?lqxoksVrYYhCaulQqLMBV/PVrO2LuxgYLYnlxEJtnAIHoGVYRXYwe+aI7Q/d?=
 =?us-ascii?Q?YYIOHsaqzcyUcHbvELlTqNE8PpnvzstAZZ9wALZAQnD787rtm6oX5O8LSDZV?=
 =?us-ascii?Q?x/HHyAKOwfO1TcD9Z5cmf/WXjxE5i2hCnvS3IHh/LfSQQdoIb87l6vsAiKWB?=
 =?us-ascii?Q?L02g0rQwIusDTOnJLAlRIjIDXbO1FY6gA6bGXg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d3d086-99eb-49a5-4056-08dba31ce53a
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:34:30.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1847
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

Since PLDA PCIE driver is added and VL805 support is enabled in
defconfig for Starfive Visionfive 2, modify the document to keep
consistent.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 doc/board/starfive/visionfive2.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 941899a0a4..460f23aec3 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -20,6 +20,8 @@ The support for following drivers are already enabled:
 3. StarFive JH7110 reset Driver.
 4. Cadence QSPI controller Driver.
 5. MMC SPI Driver for MMC/SD support.
+6. PLDA PCIE controller driver.
+7. On-board VL805 PCIE-USB controller driver.
 
 Booting from MMC using U-Boot SPL
 ---------------------------------
-- 
2.42.0

