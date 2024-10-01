Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3D3CEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DD7892B6;
	Tue,  1 Oct 2024 20:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gXWANmXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A867D892A0; Tue,  1 Oct 2024 20:21:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8948928E
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI82T1VNY56fbYYlwRo7y9uKvt45UkiT7SQnyKpbcNmrMXUrTJbBobN6bzdSalRMoNpai/ai60KDUtmHfwLIMSKa/VpoecV7ru/51ZCpXcpHefmKq1DB82TwTbOW2sbB00Vy1SsOyy3jkOJBpCyNgbEJz2hbOK5gcbe2HN3uJG5n0TGOd18whPQo3n/0GlDRG7e9jT/EO2XaDsWXEc8iTgMxbxruPzSqn1TeIYKfT99H5MPsN4uK4wJKE4oKpt12d2ovjpeasT/HqEKge775+ZL/VwY9SZZpv4wkokl9DrM95vb14Eg9aqiBCIM1C5s85FsLpK0ObUTdx8lTnt8F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pspr2bR/yOhTMM2JZ9eimJwQQzDhdTVT9mssiCzcq1k=;
 b=VL1MT0sJtg+f8YjCl3qCkPwVPWQ9g6BeO9C67myqpqG2nQC8rd8AkYY/uBMNluPNJbFI9Q3pgDaj4/e1P6EUveG5ZpRRTS7y2NtzixW2ZQrUN19V5xQ6dwtIxzXEDlOf4nhUmUuEQuWbAU0MyQvXsIT1ytVAFU/jwgEdDXdKzAcXB0Rgb65Hw6Yt//Mt3Y9JV3k1caEPvP8+0Vr3XsIWtxR/l98p1TTJNQ0ZDXtzT7BKVebj/lHuzOUrEe2jvuvtg8DhfbUuKkHIHJFBtqipTMjkFlsF1wJ1Bf+4jh1HoUZ0j7/czOINSCr0jHQPCSLIM8McqpZcSmyzbREU2Rw8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pspr2bR/yOhTMM2JZ9eimJwQQzDhdTVT9mssiCzcq1k=;
 b=gXWANmXqLmil0xBlo5ILGgq0x7piZc1lTgzJuPf6131zl/XAJznFF4AzP2os4wKe+V63HIPeyb/dhSW72rLy300BEyfP9EYR5MhTluwZrPSD9KFCNFn7IzQoP1s4btqsVU6UoszTKV5JVEvhXHiRlLnrCgSdacJQVqqwKWSiV3HGH2pawq6HFy+4AyyQLBTSmlHa9sBRFI292mHHdAdEteHKk7L1m3uDl/fp23AOvcGK2wGSbA7o8ZDT0HEycuciDBbWMmaBp1NnRZ0woQ7PbwwO/XNpk3z55aktTDJYm1qVoSq5JeycLo7pM0NhDQoJLQq7D7roA2Kvs/u3vknsCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Tue,  1 Oct 2024 21:21:07 +0300
Message-ID: <20241001182107.907828-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: f837e6ca-c977-422c-f509-08dce245e11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?87d4ecOVccruhIqtr1ffn7SixsmoHUfq+Waucfsb4qGrObXu6vF5TS4pywJx?=
 =?us-ascii?Q?X94WBEbzsU4H/E09EigkxffHaDiXKbb2pJBQAq9FK113L+01i3zgpDvTrCDK?=
 =?us-ascii?Q?YNhP1p6kW3uzwZXhrnuF+5qkwjmvtos4qfdxcqlyoYZuJWwP03pksIzXU13B?=
 =?us-ascii?Q?m2xX/Q1g+USuP65i1t0liDGgrJeivKfW8dCdw90Jp86lGGtNPYS2ym1Tyzki?=
 =?us-ascii?Q?oYIohc4byDeAgenO9W3SPe0AsyBjqatEpwPFtss5e7M5nQ63U3kfsrPOrlr4?=
 =?us-ascii?Q?yS05J9PrmR4aZy2+qUPV7FrgeugW/kfzjddsZZ28P594xVnRKyNLnFSL8QVk?=
 =?us-ascii?Q?5gPJOtTk1X7Hy2Ay0PBZe8zUMHgI8dHVFcegJKn4mbDlZDYyj62oMhSOLDu4?=
 =?us-ascii?Q?sjU6xxKEgQ5Fszx2sd19lOCZYDuH2qBFXroSMDN+2ynyi0Dz/D5S5gROJoNy?=
 =?us-ascii?Q?cwS5q+G8QGArGD+qgQvRWUZ1f4ae+tjjumHz1xJ/gwd5pkLtJSGTheUQbYx2?=
 =?us-ascii?Q?fhHpmf7ysu0AfVBO6m12v7IZCWZAO7AMfZ30TZjmhrxzl5FcQEYdSPAeAGiQ?=
 =?us-ascii?Q?J8R9KJkCfrSZthS55faY/XpDpj0zDvwAPYx39/2frPRBY3zNNge2c10y5WxR?=
 =?us-ascii?Q?Sbm/Ugmw7rBvpt6afeXAZnHXVWi4l3/TVnQRLscGa7J6dqbEKrhTdzHNKtx9?=
 =?us-ascii?Q?qx1UNiNVh7Def/9kDN3VAt8lh+iUtKecBds9BRnFzwcdLadx4fN1PX2O7a6G?=
 =?us-ascii?Q?6ZM2nfzSzej+S5NzPfktxhwwSuWJ0nraABx+JHxK1BoGRHVAahmnoQyHXsrL?=
 =?us-ascii?Q?S/sH57i72JB2aDeqT72hoxWL8u1TGYWuqbSxGuzockYFD1cGZ703H811OyNy?=
 =?us-ascii?Q?ov3F1snIeWpntxLJTSsv7Ej6EKURqEtYCtSPniVDjSOFB5MOT6dhgTN62rF8?=
 =?us-ascii?Q?r52knKUanCc0mTd1U04olxbBQgAxMBK6hVHK05gJ6pwJDHJ7+JuxN+K7FYId?=
 =?us-ascii?Q?EYXCGxhOQpxwCDrtQ/MQHwnZ2U8STQnwmJamKlxh71R0iLOoznqTiyYHaEBg?=
 =?us-ascii?Q?K3EHVpsvZHXPMXvKieUxljfPNwNpNfm+piZmxqMW0/4iEmiTlyCrel/OaTHl?=
 =?us-ascii?Q?fGG3PJctrjqkHl2JZFnz//gn366akJaR0Qnp8M+luFRnG8LxubzZjd+yjFiE?=
 =?us-ascii?Q?3ncUaTzR28JvTo4Ii4kjpaCEFMD78CLKeQC1OpTapZS4cYD3ZMFNktxN9/st?=
 =?us-ascii?Q?tOthhdI/Mikkbq75l/rY3Vz9vZsoz1oIbAIKQDq5QA7bxhU0tvHe3OHIVR1A?=
 =?us-ascii?Q?ApU/PmLK7LyvTfM18k7JFdj8SsZlg2IIjI+dtYbNLos/YKhJH4MWFrNepOCj?=
 =?us-ascii?Q?vNUbBqSUZSdxQZZJKMX2Gj8gtsQkY31ILKfKDvcj9WG4a5k0Td2vMoNdMxr0?=
 =?us-ascii?Q?1e+grKXwBwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovYbiyrf2VZPJqEoupnxts1RglVJdhKoNSUE6o1SM9a/S++F5Oe42vzdU+E9?=
 =?us-ascii?Q?Ln8fWcMAjVS1QVS9gpKm2qmPbZ1n5sek1BS86+fyjHtVRdL1s+kfRaj8fjGJ?=
 =?us-ascii?Q?nJetVNiJFNmBGMzhoN/ndbuJ0P2YUVCsd01vzYaaJnMjJU/mjvIkP0tvEXSb?=
 =?us-ascii?Q?jbot0wY/dlkcnz3L4xMvnzXSaZzF/Da082t/PiFHzfIbtWGgURmC40imEEtc?=
 =?us-ascii?Q?W8M0PqaE0qaLHVd5sJuXtPOKHaXLM84yUGbEeBfATI8/onc//aRk8oe9PwAC?=
 =?us-ascii?Q?ET9fM1DOS1VlCJbGkF/BTxDuLImOS6r5g92IBB4AsXTJdzvSHMoKllIWsi86?=
 =?us-ascii?Q?XlN8Is284CGL8S0ZktXIP+n7L9/94R1412w3Z/h8+B6L9dRd486mABtHo8rg?=
 =?us-ascii?Q?ONwKNOh6KvKlf44pe5LqU80vtGszxoenFfML1ZwAgRn8+7iUSx/9brZYByen?=
 =?us-ascii?Q?l7rwLAT/0a+38j1sxdW/eXvCkmXuIV6jpfoocPPcaWnEpTxv/d6akkccsubx?=
 =?us-ascii?Q?ESxohl7gxLTOdwMqNWfXLZaYPKM/snK+dzG2VkmYm7zCqeqc7RAn632z64v3?=
 =?us-ascii?Q?6kqtY3UFIG6+DM7vEB6flZ7MOPzsBqZ1cC5nhfLCG4RnnxjJhATJmlXfK10I?=
 =?us-ascii?Q?b+xGQLsAbr0FnAIzhTdWpdaw/tWoxofe8uynKBoRp3yQNmj8RhLxwlmq7YbS?=
 =?us-ascii?Q?8m6MtPT/cJNESP6CMcZIKF3S+j/5HrcB7yi5o59SknN47MUCmhpdHxf9vyAA?=
 =?us-ascii?Q?mjqkfi16ZJTOL9Do0C+baF1yEOZYsTfq14nwjOhFO+URkYzq5mj7e6VbK9t4?=
 =?us-ascii?Q?Xos9EiMSm5k4ANRxjCU/mD0Je8ohSj8bSWbUUe0Y95uEgpsIYQ1TmBXBQVQ1?=
 =?us-ascii?Q?e+yZYYgCW7x989/CtVx3QSPoycD1LwrwnYT4bgfLLwppW4MCjeiLNdDviitz?=
 =?us-ascii?Q?+3TlgG6qi0B5SRC+QNe8Kb8qheOpo7XoAaIQ8yjwT+8jCfGdmWv8VutaqeIL?=
 =?us-ascii?Q?zNy1BQu3UwwXG0rdn/vKocCNpsM6RJvfzUMN0FEpmD7ohBZneKsjYzsi9CC6?=
 =?us-ascii?Q?wiKgEIX196Ds1xq6JWCbdfAfAjlYhTD0v/2wb8NzS9c8TuI0QcYUCnuMX8HZ?=
 =?us-ascii?Q?8LTfOHtTHrHcr8FYcWhAbqWVohgehAwhJwa/OEuuDwc2HP8HMyBJBdIl1Cx+?=
 =?us-ascii?Q?kmMb/isjnVewMoCF7l61ed+EiLy93AQiPWXnjyZOE0MMoDZgmFnSKopYQb+q?=
 =?us-ascii?Q?YzKtJ3wiPSQkUnhcXtBn4eQ2C3N5IGQkW1M9LxJgzV6QFLHxD9tBHjRu5cwQ?=
 =?us-ascii?Q?XpkGclFXDvmWtZthO3axVyG90mDqhcWa2YuH7772P6C5ho4fY+7ibR72Q3I6?=
 =?us-ascii?Q?SEia7IPqasq2BHRNVDkAsrgECbLA5U/rlTlsRE2amjTdpxyn8EOzvBN5yyN5?=
 =?us-ascii?Q?IHzUVf82h2/IkeIQAoKWJYi8a/azvHhvV0GfLRf7g9kcdv+VrzhwBKcLkWpx?=
 =?us-ascii?Q?31IbgaB5MMANTNPx5ODeYCGA/5IAooqdgUNaR7TJrC6LnCqcouqXU9IUTaer?=
 =?us-ascii?Q?h5wkQpvEnJDmbxu6GtSzvKzZEQFLYcfH6SsHV5aR8E/aDI1IREQUaY++iOsN?=
 =?us-ascii?Q?ItvqJ8DiL7PKc+KKGcuqI5I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f837e6ca-c977-422c-f509-08dce245e11e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:33.8946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSVAwcegBeP6Y8/o/l2A4XsYDZ0Gy0E/4FiGR0oPOsjHZaoMHqzy1BgETzdrhfzGu39O1i17f+SQ/xPYkrIlpSxKYTTP0AOb1CIKPPmWVDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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

This is an example web-server implementation. It can be used for files
uploading to u-boot using a web-browser. It acts much like tftpget, but no
special servers needs to be installed by the user.

This code can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Usage:
  u-boot: start the we-server using the "httpd_upload" command
  PC:     open the "http://your_uboot_ip" link in the browser

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig                |  25 ++++++
 cmd/net.c                  |  20 +++++
 include/net/httpd-upload.h |  12 +++
 net/Makefile               |   1 +
 net/httpd-upload.c         | 170 +++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 78d9b00058a..41162600671 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2035,6 +2035,31 @@ config CMD_NETCAT
 	  will be lost or reordered. Any netcat implementation should work,
 	  but openbsd one was tested only.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  An example HTTP/1.1 compatible web-server implementation for file
+	  uploading. It acts much like tftpboot command: put user data to a
+	  specified memory location, but no special tools needs to be installed
+	  on the user side. The only required tool is browser.
+
+	  Start 'httpd_upload' command, open a browser, connect to the board IP,
+	  select file to upload and press 'Upload' button. This is enougth.
+
+	  There is no big profit from this code, but it can be used as a
+	  reference for other web-server implementations (ex: web-based
+	  firmware upgrade/recovery used by some router vendors)
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This option sets the resriction on the size of any uploaded file.
+	  Please reserve 2--4 Kb more space due to additional space required
+	  for storing of multipart/form-data header and footer. 
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 79bb126dbd4..f2df1eed2ef 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -21,6 +21,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -229,6 +232,23 @@ U_BOOT_CMD_WITH_SUBCMDS(netcat,
 	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
 #endif
 
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	httpd_upload_prepare();
+	return netboot_common(HTTPD, cmdtp, argc, argv);
+}
+
+U_BOOT_CMD(
+	httpd_upload,   2,      1,      do_httpd_upload,
+	"starts httpd server for file uploading",
+	"[loadAddress]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
new file mode 100644
index 00000000000..a80df214668
--- /dev/null
+++ b/include/net/httpd-upload.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * httpd-upload include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_HTTPD_UPLOAD_TCP_H__
+#define __NET_HTTPD_UPLOAD_TCP_H__
+
+void httpd_upload_prepare(void);
+
+#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index c1f491fad02..c1b41240aab 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..8e43860fa74
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd-upload support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <net.h>
+#include <net/httpd.h>
+#include <net/httpd-upload.h>
+
+#define MAX_FILE_SIZE	CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
+
+static enum net_loop_state  httpd_on_stop(void);
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post);
+static struct http_reply    *httpd_get(void *req_id, const char *url);
+static struct http_reply    *httpd_post(void *req_id, const char *url,
+					struct httpd_post_data *post);
+static void		     httpd_on_req_end(void *req_id);
+
+static unsigned char error_400_html[] =
+	"<html>\n"
+	"  <head><title>Bad request</title></head>\n"
+	"  <body>\n"
+	"    <h1>400 - Bad Request</h1>\n"
+	"    <p>The request you are trying to do is wrong!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char error_404_html[] =
+	"<html>\n"
+	"  <head><title>Page not found</title></head>\n"
+	"  <body>\n"
+	"    <h1>404 - Page not found</h1>\n"
+	"    <p>The page you were looking for doesn't exist!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char index_html[] =
+	"<html>\n"
+	"  <head><title>Upload File</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload File.</h1>\n"
+	"    <p>\n"
+	"      This will write the uploaded file to the memory area pointed\n"
+	"      by ${loadaddr}.\n"
+	"      <form method=\"post\"\n"
+	"            enctype=\"multipart/form-data\"\n"
+	"            action=\"file_upload\">\n"
+	"        File to upload:\n"
+	"        <input type=\"file\" name=\"fileID\" size=\"500\" />\n"
+	"        <p>\n"
+	"          &nbsp;&nbsp;<input type=\"submit\" value=\"upload\" />\n"
+	"        </p>\n"
+	"        <p>\n"
+	"          It takes no more than a second after the file has been\n"
+	"          uploaded until status OK is shown.\n"
+	"        </p>\n"
+	"      </form>\n"
+	"    </p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char upload_ok_html[] =
+	"<html>\n"
+	"  <head><title>OK</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload OK</h1>\n"
+	"    <p>The file was uploaded.</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static struct http_reply error_400 = {
+	.code      = 400,
+	.code_msg  = "Bad Request",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_400_html,
+	.len       = sizeof(error_400_html)
+};
+
+static struct http_reply error_404 = {
+	.code      = 404,
+	.code_msg  = "Not Found",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_404_html,
+	.len       = sizeof(error_404_html)
+};
+
+static struct http_reply index = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = index_html,
+	.len       = sizeof(index_html)
+};
+
+static struct http_reply upload_ok = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = upload_ok_html,
+	.len       = sizeof(upload_ok_html)
+};
+
+static struct httpd_config cfg = {
+	.on_stop    = httpd_on_stop,
+	.on_req_end = httpd_on_req_end,
+	.get        = httpd_get,
+	.post       = httpd_post,
+	.pre_post   = httpd_pre_post,
+	.error_400  = &error_400,
+	.error_404  = &error_404,
+};
+
+static enum net_loop_state	httpd_loop_state;
+static void			*post_req_id;
+
+void httpd_upload_prepare(void)
+{
+	httpd_setup(&cfg);
+	httpd_loop_state = NETLOOP_FAIL;
+}
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post)
+{
+	if (post->size > MAX_FILE_SIZE) {
+		printf("HTTPD: reset connection, upload file is too large\n");
+		return HTTPD_CLNT_RST;
+	}
+
+	post_req_id = req_id;
+	return HTTPD_REQ_OK;
+}
+
+static struct http_reply *httpd_post(void *req_id, const char *url,
+				     struct httpd_post_data *post)
+{
+	if (strcmp(url, "/file_upload"))
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (!strcmp(url, "/"))
+		return &index;
+	if (!strcmp(url, "/index.html"))
+		return &index;
+	return &error_404;
+}
+
+static void httpd_on_req_end(void *req_id)
+{
+	if (req_id == post_req_id) {
+		post_req_id = NULL;
+		httpd_stop();
+	}
+}
+
+static enum net_loop_state httpd_on_stop(void)
+{
+	return httpd_loop_state;
+}
-- 
2.45.2

