Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39684EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 03:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B791B864C3;
	Wed, 23 Aug 2023 05:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="GcozCzOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85E3833DB; Wed, 23 Aug 2023 05:23:20 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn2048.outbound.protection.outlook.com [40.92.99.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C6D864BE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtdxAqwQT55ndO9GM6eL/9Rcl+K8XkaDoh+YRFGzFuzfIn6Ex4Bqe2vAlTMdkxcZN2IdueS0ZMhjvLYmvhcvoCS9ugw2y2JbIeg/GRmtXn5BAT1LUHa1Oe89+1WuYUOoaDvuhWKkIvo/5zGw1f7OqmHbY/iNkjQVVoFvtRAWXBQ8036u7V/h3wfrhxJUK9nqH5WivPQ8ev0ZKCJIS8aU0fyayGpOoJuQSFmmaTtIoW7Z7yojA9KK/Sk8aryU5olqrdrNBqDxbphpA8AMQziBZVKLlp5CkXjOie/NgAvvX6qknftmKMITEFKtpdn2QMWRoNLI7wcZC7P1WPKwpd8FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5xaB+kw5cukoL+DeMOgFZt42bWpd2nGP7O3+DJeMu4=;
 b=Cy+Z4hzBV3ecOeh+WSxbxZkmSspngWoYRNfMs+j4bMHGHuFQC0wujicjZrVNltR498PnxPDbbhm5inz1Bvn+jf013+oWtW9da0bBrYm5C+A/kUaRbET3l9cNHlB6qMshLmwb+7/7FF4vG00kEchdaYLPtGuG1qPDG15exiIPJUlti6H9m3wNlwPouLAbyMxA8RyPJpLtZUgXLfDE5fYtpuVQas6W2K15IZQLB4xgMyWJUH2/N1HUYPNcidUkZVCHmbrzuY0QtYq7ApaDlj+3NvUiK0w4klMkYAw30CeF3bNjKAj4TeJGBSBk42uTl+wKtvtpdRWe77WzT5cr8R7u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5xaB+kw5cukoL+DeMOgFZt42bWpd2nGP7O3+DJeMu4=;
 b=GcozCzOf9bxf7+IVXj4MB7x3iJdFjP5jwkLkUqE8JroQDrUJCMyvCzmwIGdSh1rzPuC3t90m0QykmE0Aa58O80ZgR0rIF7WMQ/Yk3gAwf5Wnei5QtmOjFzYla9K4JWErtxWvHKTYhdf069Xsd3Esv9k9TY5Je1NRWjccdGFBS8esJ0xQLTf/YRv+tU4xZO2a37A4V3zb1hcfY1HO5krZzbZc+0/hicIlbUuTHH7mxBOq8BGoe6r49Asw2/6pNP15wfCUcnjNcSbv1Ndj4VLYsp8pEHLFwZCf5XPy18taEMSKO81+dupOGTS4y0bRN0hoZARNbkVduB1bxb1ByaVlqA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3125.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Wed, 23 Aug
 2023 03:23:13 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.015; Wed, 23 Aug 2023
 03:23:12 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v5 3/3] riscv: cpu: jh7110: Imply SPL_SYS_MALLOC_CLEAR_ON_INIT
Date: Wed, 23 Aug 2023 11:21:06 +0800
Message-ID: <TY3P286MB26114433D37E24F0CFFB95D1981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0.windows.1
In-Reply-To: <20230823032107.1792-1-wiagn233@outlook.com>
References: <20230823032107.1792-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0uHhlSBGjc9ffz0t5pOzEZhEr/EhqWS4XWDa1i1JU1LykBOyLXKPeNULvS1U2raZ]
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230823032107.1792-4-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3125:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ea46fc-d17b-4cd6-66a0-08dba3884831
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWiCif6GDuV3ScvVn8CDwm+oU49CvTtJXi5aHaol04jISWYAF5AP579NqngChPLmJ6sxr+7zWUvrFCfQNQUbc4DjPUi5U4RTxwFNW8pslq/gXwBypslGyY41o3lV5/t0VrRQN1bjI2QLNv6IjECzJi7Jf4JRl2vKEv5WHy+oBuF07tzxinB4FtcRF0LtQG5uP8pS7CuPDIbi697EhXNADIUZly+HksPgfzsUkbpdpktN+9F02iNkAGn+erHWdVQr60OvDJxNmqWMlqRemTAN8xVWjP7Fte2jasdgktg2ZLS1ZQrssS1BFdsscA/ZNkIn8KPUjvDl6lkX+z2frRhh/LesOZ1j4rQcIDKgtmixaCbynUUlBWx6lVDLoIWP4k1FIZuzhqfL0e9E7WPj7EjGiCvwec0CJxP6CY7rzJoWfa2cZWiOO6UYK99rOnvIZIcTL+SC5/XhOZF2J+tKThRU0xz8RMWEUyrmal3VMmZGoodyxlnOWuPlWFgh48SGUBSAVqBu/tTrwBRKJho5xaSP+7J+X/N4klKIDkSm6dHr5ciCNBg015TsSYRU7P4QaErnqy3+xtVcKzdJL9HvsbgdoC8jbtoWtfyxnLGYOjVzC4RWcQA3hduxhAmiGnLru8ga62hOLB3QYyopvjAKMkOF4S7+6aHI0FYodypSFGDrxKrDPoDNVI4K7YeThXAvcSLsPB9pLj7ZRZnHEr5uGOkcraX/rnVfFusgbuUwVk37jdu7xlZnvk7jaegBgXepIWTHCQS/C7pxjlB5ub55G0AGGFQn5xaLQ3Hq24=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MktYI/nkL8kVEfmUzHYR3sUWp7a0iv5oIqaIK8U5PVvrXZasjw8gn+FSIe6OHh0OJuqKFO6xHk/JRwAuVipr9q4DFlYxQAxQ+y3XBbCu0q8cF+vzZkuUCX87rsnr+Za1oz2MTlYGYpPjWhjllt8ySNCv0XZBfuJ8HKAeu6Ac5ftMybBDhrpm11L+ixX1QrVRB+C9FCDqgSRYOyNFTAKyevSCxRb5ZJg1xP/9CinTpQBaJmPyweKZ3PXl1axkN6qVMthcsI08VGsIVPulh6OpT3UaqojqCEbYnXvoO/IX4SrmAdskGUZE9TG+hERI4ui+C3aKd8Pdc+U1qQC9M6NDAZQgg0nCXFZe4IHeCgW/IyWVWsPQyf8vqtjDMtdfq7TeaKrbspn0M5UgiV8PdmFbaCkukyEXy2OpbZk+SMo3+uf9os6Qc5+CN88s1M3HdujY0Hd/q8D8sN/lGe/GeV0pW6C82teGMXUdw5VXFVJaspIQhAl8i6DwAkj8WgYlpCkyR2ujN17X3+ZiWyFiVu5nvshxcdkhXAc/h43d9qw1wHQ6CDucerxtN8iH8kumSMEnjWMB3rbZ6z0T02OBkLvTQGfWC7xXZEvqXxtli9s498BDIL8hmZvdiI37w2Hqh3U
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7YvEuBgw4gWjLGIbiYG2UJxMAOnYAKyKTnEV16gXFMP4MLkbMHLoJM4U53NL?=
 =?us-ascii?Q?cEhXUvr14JTURg9H1QIoIbXFiM+/4d2ZdNRqyqArpm3WdeckCAGDsBx7Elha?=
 =?us-ascii?Q?IeG4/XcBbGDvoGFK4piQNdw8lmsMnmBW3NdAo/jcS+aFkmyZ9yzZbYdlwzE4?=
 =?us-ascii?Q?HNJGVWZn2XC4Mhhz0DXVBU+rBvzBuJLxJcyj6QuZtg+USLQJFirKXIKSNTNs?=
 =?us-ascii?Q?oWUdeGboo0pxmCLWb4fj2st/3OQVbwLBdOMTvuUPx+QOqTS46eRp8TTEw1cb?=
 =?us-ascii?Q?7LS9V/v34CjcLfc3az4k6tORGZTKQLntVNG55O9XcQwBqI1XKdmMk8m+xZ6m?=
 =?us-ascii?Q?rKLB/OB/S8ltp2mxtFluPZr0UzXDsdxnQW+h+RJy32fl59emy9tUPjJaF087?=
 =?us-ascii?Q?f3THkjMKC3B2OD4VVA7wiEbOg+Q/S8mW3N6Y58/R+cvtoLhK/V7W2K3lFX0T?=
 =?us-ascii?Q?77d20fec91I5J08CLpYcAF/CbsnHK/hAiTvQ1g5u2tn4GeX48flB8uvEpyGT?=
 =?us-ascii?Q?11aR3Zk2XKPFhyMRgNgdj1DyCYR90RY+6ASQF42W/KIIF++m2c9jB3Od1EDH?=
 =?us-ascii?Q?XlpndNdtZW2IooWU0fR+CBudgvuJx2zFdjHeo2JeWiqXL3gEfOFmiBWSvTHE?=
 =?us-ascii?Q?a/VEcS0nS+wyKmgmhOIJIn1mxRcBEQ9AiH0yhQK/FJdqEmq+9kqk32Sxo6NH?=
 =?us-ascii?Q?UWpDFyCgt2TQiGKfAhw98XkTquaOnSkLBBzRUe2lJOZWFJoq9zRlVHkJ5ODn?=
 =?us-ascii?Q?FlEkilUPGsQar/wDlp1ZAThXzJT+Gf/zhVsHiJQuuzo3h7xyoMKNjJ2SQmXt?=
 =?us-ascii?Q?vV06SyCs8NOd2QAsKghGilj5/6ryr5mda9LA4PU6LWuGIwdmB+sg4byyf7IP?=
 =?us-ascii?Q?MCJxgRH5VdvbTDzy4jeUWIDgQSpccLDevt8j+Neh/+HrHZt0unpWBEUKc+Pu?=
 =?us-ascii?Q?URXFdx28B64JKLDDY7ONQRYTDCr+kDCfHdFkonsYNrjSUBNql6j/uRcKcjaq?=
 =?us-ascii?Q?TaX8y/V5cqzYFjIexvxSA4Y9u12shtupLMjNRaNa7dP3IRrc/frjKcLHlp9b?=
 =?us-ascii?Q?fFQ+aZdoNf9WDNGR3Fz8ZLk0/i6mQbEcHBf914J/i1FivrM+0rLbLAMZFsuY?=
 =?us-ascii?Q?MzkhHbfI2R9EYj25kPFNP47mn8HGzPfBFnSxH7BHnlrONtcwvCvyR1363NDX?=
 =?us-ascii?Q?s6sy+GhsMyMV++TJtpar+00YDKB/vVK/y7P3GDfrXLJyHjQ9m2OHTBZE0yxf?=
 =?us-ascii?Q?ztIsSFZT468hTJOjT+1ulmJTnGdiBNGpIBqSCF8lTg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea46fc-d17b-4cd6-66a0-08dba3884831
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:23:12.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3125
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

Starfive JH7110 needs to clear L2 LIM to zero before use or ECC error
would be triggered. Currently, we use DDR ram for SPL malloc arena on
Visionfive 2 board in defconfig, but it's also possible to use L2 LIM as
SPL malloc arena. To avoid triggering ECC error in this scenario, we
imply SPL_SYS_MALLOC_CLEAR_ON_INIT as default.

Signed-off-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 8469ee7de5..e5549a01b8 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -28,3 +28,4 @@ config STARFIVE_JH7110
 	imply SPL_LOAD_FIT
 	imply SPL_OPENSBI
 	imply SPL_RISCV_ACLINT
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
-- 
2.38.1.windows.1

