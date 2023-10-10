Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF7DCD8CAC
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 17:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4234E86BA4;
	Tue, 10 Oct 2023 19:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3BD86ACA; Tue, 10 Oct 2023 19:44:52 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05olkn2082f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::82f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5D3867B5
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 19:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzpR8ITZxiLR8l5LoVgizwg9fQckJfDFC6n7qXpoSClRLeJbedfUrx9y8aVoPpn/MTp8STLTOzAyByS1vY3c4X0DJhXyVr4OIeQsm+MoLT0YFxAtXdTrS8+Znx70qiyLL65P9/pComkWsPX7SzVhFU2CUGtG1y54jWI903rZpIaZv69um5aVDRFLW2aiyfhwiR2inOoBux8/r9638n+TC2kvzZVv5ddiwRyanlGMv808NjKv/+//3c0CiGVMZHFvBwnVgprx3hhKUjB6GCnwK78lOH1XnVSGJRgpLRjSDkmaCn8VXDED5lBb2/hh6qfW5K+wJpmzAuMu2QjKDVDb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSZ2O7qTIoKn97SmWr++nWzznjX1YPff2bFuRM+56ok=;
 b=ayYuG/l8TGlLHYY4E+RO7KZDKFfSJIiAljyI/rYPm+4JyTaAc6EoHBOL9grgzf86yh33g21H+5sLaapgBNsb3eS1+fw2W+aK1Q4FjBlJ9fIjlHSv3qL5EGcQhdvOQxE0hM1O+CcNZ9j54+LDQDARW/BUuwSpbnu5knpAIDJ3zzskrCSbBxxrrgHOJkCQ43evOraeBvMgazU3gTM3JWYzOwbtDRVu8cHelmM9zvA2HWtQODb/Tvi0dKiLWa714trAdHgjI9hoycKDhEO4d93hCvt7mHgX4WIg0sdQ9FinvDXzB5BhMcdkYLRXo58tS2J2Q67jujqYoxS/oD+WpfMwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:337::6)
 by DB8P194MB0549.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:44:48 +0000
Received: from PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::9883:ec9:55:903f]) by PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 ([fe80::9883:ec9:55:903f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 17:44:48 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: patrick.delaunay@foss.st.com,
	Francois Berder <fberder@outlook.fr>
Subject: [PATCH] firmware: scmi: Fix clearing variable
Date: Tue, 10 Oct 2023 19:44:32 +0200
Message-ID: <PAWP194MB2055B50F4E55CA0A416DE2E2DACDA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yV63F9O5UUllkNkWQvqUo1EY7KrLig6zMQaYiHZHfFQ=]
X-ClientProxiedBy: DB8PR06CA0042.eurprd06.prod.outlook.com
 (2603:10a6:10:120::16) To PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:102:337::6)
X-Microsoft-Original-Message-ID: <20231010174432.31566-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP194MB2055:EE_|DB8P194MB0549:EE_
X-MS-Office365-Filtering-Correlation-Id: 64018ee1-81cb-47b3-7346-08dbc9b89884
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htCJWaQKzyXkkm9AmDIgt0Dx4dFI2cBzsXaNzZ055cgFttzLGs7PgVP+lv4CDyi0yswxsyYr+lI9Gmv1a04g3DMgb+7goXb74zef5jl6gI87RmG4PTsJw7KG3k3/S1HVGrCcHOsClspqQn4trY7s1w6ee10FRwPmBlNsNQfhsfxLJ2Sbnn/Vc0g93w+Z8it88h9YHlqtblP45GjoV4BgknW3nJAo2OKBKTBdiIs0sXW7Y4OruawnEUjAi0w8d1t07RlTWBGyOxTXLSyFrZPM/p37dOEJcjaFyjMbUgHXjAqIkMDioZzjnQqWVg3E13NVqA/KIwM1pszjSRKprD2M0kl+5irEc4J5igWDUuciyhTgjiFJWof3uYT8oC3N56bnJH7vDQLh8jWgtSn9YGElqBq4PzI5BZq6NZuWByDxowtTWEgypIrHfMUaiPIA3Zj7zpSZ09d/iD9bMl4pzb2UsB0Bm+mtEZmbk/Bx+s8Up1OEYj4m4ZUAC4acRUoMf7PhUkPHcOgygrX8g04uhafTVfwI+YUXMJbrrkIePKdDwwWr3zLFlTgmoBPV8QqaCcHEzKTcd2lQfA9VutqEqxpSRVUdeMVFJBaLzJLo+lrfphURB4QjCE+4jJnrWKp0E3Yi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8PTIb0kQhwutwUbGe/CloXp5JKPEe5mTycpioRYkAz8bmoF14/4ANOd4e3C?=
 =?us-ascii?Q?pi4rMenmG5NLKRsGEWTjrPhNA3l4O80bCIP/So3a4Vd6oxiqo4T3+OPuxfAl?=
 =?us-ascii?Q?L0nJsZ2q9b8Aoou5Iz4m+JE4qx1kirU+Xs3623jamTMHvIcASAf219qa4Xgg?=
 =?us-ascii?Q?GxKwxq7Z2qs8ltClJYGieZYLstiJDKD3wSv7Q5v7x/x/bTUIHgobyZYAvDg6?=
 =?us-ascii?Q?UDUmR/B38Xo+2DH6eNICnOdIulEIG1lr9snmvLj4FNLxvTqG1HtJBYVixEZ2?=
 =?us-ascii?Q?JFBbMgeM1MvUH8eApdaeWgZpR3hRRurLhta4iz7iVuk5eZuhZ8HpAVC19r0V?=
 =?us-ascii?Q?uUzmv+V1RMPCWqYitl/HDYbM7F0vnxA60XZTt6vNtEnWXRIRKFQSmhHAr8q5?=
 =?us-ascii?Q?roHZBpIPWPz5qFH35RmUecjnUFqxyz33T67NnTBjsxLI6sYou8llkT7MSYpi?=
 =?us-ascii?Q?FlfNNqN1DHmvQcXrAHx372zIauT4XxyxfVmquafs4HfZA21p7AzJrT7YWZUK?=
 =?us-ascii?Q?8ku05DkWpQRaKvyPetrb8hCzIyl57OYu9VFFFGvo/LHuH6JoQP5cIIUsGbvm?=
 =?us-ascii?Q?8Pt2tpF7072FVaDwgRnlKxIT6zdmm7vYnMgv+6q0WFwL3mocxuDlWJYXnJf2?=
 =?us-ascii?Q?QeHkcJZ6Yp+F+I9dPCvj/w9D43Ndi9YthLKL/YHh5139NK7GTcX5/1zHh2+R?=
 =?us-ascii?Q?fhWHBn9Zi1V2lQGEPTQTzGSBygno7U1+Xw3i5bTRWQ1yzRFfyO+74sQ3j4Zk?=
 =?us-ascii?Q?b8UF0fSyA9tucEu+EIsxjZ194XgO2yDDaIJTnLDSkDLQj9Sq7ZSHaN4cfntq?=
 =?us-ascii?Q?bIaz1en4EtMPWLudn8txcIZDCMOm0s/o0anwI9Ot5M1SFBGpcmNJjHp6C6gQ?=
 =?us-ascii?Q?uThJDsFSCiJM2nyFMqZxLY9PKwbNKWfHzA2nXH4KM1ITf8fAjlP/QYno99MG?=
 =?us-ascii?Q?+LQGQB+53wgQRZNQBCqtCCegNhl1XPl3cZ1a/mcp9VaoYkY1yjCq4FklKtQN?=
 =?us-ascii?Q?SUhqb2zDwiqwOrNnFuGMyvGEKihNd9u/ucrKTv6GbBopGtmESJjqOLNCqeRD?=
 =?us-ascii?Q?iDtW2gygwn9oUxkv6y8dTB4pmtmjFbdsXgrutYm34sLPCEUtlaRR9qcQO/Wy?=
 =?us-ascii?Q?/RAuN+Ft6dNAI5zYfYm0+9GnA6QLyV+4/GUNDxVCAbt+CYMhOTbshYT3/kp1?=
 =?us-ascii?Q?6+U4qL1+BChp3tCx8ZKHC7c9ZfIB9U9KS2yBYQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-84264.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 64018ee1-81cb-47b3-7346-08dbc9b89884
X-MS-Exchange-CrossTenant-AuthSource: PAWP194MB2055.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:44:48.6785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P194MB0549
X-Mailman-Approved-At: Tue, 10 Oct 2023 19:54:35 +0200
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

The sess variable in open_channel was not entirely
cleared to zero at the start of this function.

This commit ensures that the entire struct is cleared.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/firmware/scmi/optee_agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
index db927fb214..1247d0b03e 100644
--- a/drivers/firmware/scmi/optee_agent.c
+++ b/drivers/firmware/scmi/optee_agent.c
@@ -149,7 +149,7 @@ static int open_channel(struct udevice *dev, struct scmi_optee_channel *chan,
 	struct tee_param param[1] = { };
 	int ret;
 
-	memset(sess, 0, sizeof(sess));
+	memset(sess, 0, sizeof(*sess));
 
 	sess->tee = tee_find_device(NULL, NULL, NULL, NULL);
 	if (!sess->tee)
-- 
2.34.1

