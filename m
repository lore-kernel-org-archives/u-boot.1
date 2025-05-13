Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39069C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CFD82A39;
	Tue, 13 May 2025 10:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RjHEaMT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A898B82A39; Tue, 13 May 2025 10:40:47 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134D881DD6
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7ar2IDjznEldcQaZCDgCtcauZELQBVbunrj7TqioixZ077fZtsrBrxmJS4zvJVABRS7IPkw5tsjP9+ZUmo72Maho3ULfSfKzS+dfVivfqiPmG2DWiMHwlPGNJBb2+BFMdHUqaD4jxd+r3scFjp0F9c765Qz0DtZjj2GbjurZitcy7g5o9Bv98ZHtx2i081jjwdep8X3iGIkBN+yAfX0nQyWqUmdWePaRtVcAhINxeYui5502AOgynAB7EAgjCUAV47ZfgO+j9hsPTiqHTGDEynDERauMFaw6Plm64G+JgD7VuOYN+g066aS85OBdn2wiaoYRvxziSbySDEi80Y3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpQJwuREdfuvIbOAxuD7S+EZB1CAs6GZoWyFGcKJJ0A=;
 b=VIjqz6IYfrJoSt2ewCJP2ZOhkeWO/QLAhvSUzWe52eJoX85VwyDSY3f7H4XRT24Nr7FxcwsGdPA9lEH3C778YPMaT/cb/o6Sh7lv/X5LkmInusl2txTmN9aHlIISV/Hqhv3jzFOauityqGEOuVST6SecrJOQkeilPfT4O2e2haX4noXiRLX3nsIisGsnmwp+rWPLwpgt/yuw0SyjVYOoAvyGe/+5KKuksQumxL+7jiaJpW5/D4z/mNJrCUVyqqDFNXwLwiQgkGhxUIPRP6t+SecFCkDzuwrPk8AfF0QzHI2EuNZKiUEsJnfDizRgHk6mq+BIOKQyXoHz2WaY7+GCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpQJwuREdfuvIbOAxuD7S+EZB1CAs6GZoWyFGcKJJ0A=;
 b=RjHEaMT1hCPEC4IukpEk0UbfNjnxNappLEvSJtaYX4Aib1Vs/xe09O0FIIXJXFwrCa8KUYxKp+TnOJqIbxGgea/s4W7E/3HM12fE54UncWwezwkdlT5hkfjywaTva46cIXZ2+75F/o9yMMhoTDuRwEvrgahXMTqpt0UEFZxDxWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:41 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 02/12] slre: add myself as maintainer
Date: Tue, 13 May 2025 10:40:24 +0200
Message-ID: <20250513084034.654865-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d51318-ff1b-482c-3c81-08dd91f9d764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zzPo2xAbOCTZVWanj23AwshkrwnG0UBsKuozpYhmPNyZYH0iEbk3b1v+qjui?=
 =?us-ascii?Q?63tTvCeBWGOglRkUhjBRwDiAjdzIKdT8hOad7bsp//hs1TsLy+klBfcojD21?=
 =?us-ascii?Q?XSORVHRqLMWmkrlZonlhiOdiiVw32t3XkSdh5fgOip6PXAnMK8cHLhEPhr1/?=
 =?us-ascii?Q?X8d9E6+0TJ/oqQo/rfXm/bMaygyXklyjyId6ggCCcGk0NsBpLixfPhUO/YbN?=
 =?us-ascii?Q?iSz4dUAqn4uojfIna9rROQpq0iKSwPobLyAIzm8iml0zaaeqZUaof9JXRtSe?=
 =?us-ascii?Q?AqOaa/C/352MWzU3C8a1iD+1TXwnATtp+CiQqJRoefFzKQgzapXBt8msIi78?=
 =?us-ascii?Q?itnWIKBPghG7JZP7oPqt8zRXW9InG0ttSGXbOxrarO4C7j3NfLB1kFC3aOyG?=
 =?us-ascii?Q?JSBWmyGwbRCuWEkC3/z/R4iNfoI3RleoJLWxcjNUJJsCCuX3+uRXDLtXYycN?=
 =?us-ascii?Q?xPnl11B4Yk7AbN+edlKKoxgpwIkZkHVHyRG1rSdX5vNxT5OkrNNe1fpH711C?=
 =?us-ascii?Q?NjzJX9aIOf5MFuImiAjl3nm/k3NOIyPUS16TG4GXwt2e5Ch+eG8SuEISmHlN?=
 =?us-ascii?Q?qUiYS+Z681qbsC5F5wydtCnqJ31B1LgYe0eovAIm/883RUa4Ddy33ed0zq7j?=
 =?us-ascii?Q?32R46QgpuAnscShHN5hs3pwvNxu9ggQv96HOWUEOCBadyWfzCwoAczP73T9K?=
 =?us-ascii?Q?g2GiY0TyFbRl7jrUTOqkImQEIOirA65MoKs3unwUmCO/SOxuBPpQ0BLfeL2u?=
 =?us-ascii?Q?lnBelKB5fTAyoAk/9LHKk5d5dOG37TDYSd4I15dP6w8lY7uDU4uBiHGQ0D4u?=
 =?us-ascii?Q?/voW2/rvOxBdRqg9LkFxqyGMdmwKMuNepNUntIUKGPYLNto4PLfjuocwleM2?=
 =?us-ascii?Q?usWooqVrKmZeynxHIcGCLxN+LyVLS3lKAdBZu3A7o0gsdYSrTI4l9+KCS2sw?=
 =?us-ascii?Q?oZnXu2nhrzTF9fwpiKkI5E5JQKjQVIqQbDDQ6XjZQv+hyIlab1Gjf0eXtB/4?=
 =?us-ascii?Q?yDpdZrCc/S+yrjpsd6PDnsVHxgLBz25vSamYlq9fB25VLbCGAduW6EoIVqMV?=
 =?us-ascii?Q?g6/X8lhmtHnH1ZylrJfeXmGJWg/i8BXH7K0Tf5DP8EyzleckRy98ROTnrf8J?=
 =?us-ascii?Q?+RjMXWEbZUIO2uc7eu5W+YgK1kO6YUjSU0RsE6nq1chPWzTiQIuaPtk9LESQ?=
 =?us-ascii?Q?8aNNGzTbfD+7wx5PwWwtAe7Ce9zZ/zgjAGyXiih47+M+5C2X8awx5riy3/tn?=
 =?us-ascii?Q?1u9nniqss0b3o40NTx2DiY9MFBk/NVJlzq98sqOoyNiNe3wzmY2jW6My4VKL?=
 =?us-ascii?Q?ZqYXByo+ip6MAuJJK+b7kMNfimXhcvHgAASeqLfRPLsPwkHg1IyEKpK6JeVz?=
 =?us-ascii?Q?p+sL/z20vO0vJFpgdKaLenxSq8wWmJF9y1DFblYZ01ocG1dP9P6j+X6ZAS3T?=
 =?us-ascii?Q?Eujfy9Wld+5LhiCwGICWKsYL8ebG+mjNqqbG97fY5gtCn/n6txSWOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hywwv+Jro0Qy0rboRIGSYhvW2SxAI2+gsX/gH2GloBAGWukN8P6RArYtbHeM?=
 =?us-ascii?Q?ULTxPkCko1y/iz3t24jF1pvJHLpX6i5cts2vyBv3nPzCBid94Gk49aDO/kxB?=
 =?us-ascii?Q?NN92tPBwD8YbiBrJNW3L0pIZ1+nw439vJqwYXN2o8HQ2jVtajI/ropZedr3V?=
 =?us-ascii?Q?BTNlyCNUKZH2M7akb4W456NK8H9OTy8oSHQdmCYJPnfH+OZ6DgbcV+G+Ow1U?=
 =?us-ascii?Q?8XrjT0z0O03QVeRb1/Wb061AXTFMI9uIMdsMvRiJAQBAHzkN3AfP0LmSfG6U?=
 =?us-ascii?Q?b5aaxqpkdBcBmZtmo9Q6a99OMMkNZVu9tOdIrDBddat5N3YMMl3Kp1Tt9d16?=
 =?us-ascii?Q?ouN8T5MYZ3oTEjM8eehWWHr7AFAhNyUYOhO0AI8KDG1Rk1RMMh4bWGL58zab?=
 =?us-ascii?Q?9Kfrgvx57yWmGV9EruVDZkqRLikbNuCwelp+A+AebcUEXXhgI8KiKor4JbVG?=
 =?us-ascii?Q?fYQE5Ie1ku59ztMI7O76hk6xlU5XPoYUYyWbgnkL/07X6wfOIRwXPNzcdWyP?=
 =?us-ascii?Q?l4ekrNucoDT2yIrm0tJm1uwTnxFBwkVA8R01AI+m4AuQIwjHIYT4zSnkkVxj?=
 =?us-ascii?Q?eRk+SnSFTr8A7XT8Qx3b5wBWiuDBd8un+3YLAUf2CP+YCaLiK9V0N4uFokCi?=
 =?us-ascii?Q?GqiuTJoHWCeT7jQPqyFeBtYnPecBdizOsDXCAyz9PLKfMLU86jrPBEXxUt4v?=
 =?us-ascii?Q?3OnbNoZGwrgXKZjT2wRZiRncswEcRZqBp+OH+xs4BznPHkIwgWBrCbLo7N6b?=
 =?us-ascii?Q?CG1VA983TcezGzBcx6NGfUMcE3RlgcDhUH1tiC1D/mn4nba7XOi+ENujwhPb?=
 =?us-ascii?Q?iFHS5lJDCZElMRus5Fw51nnMlo42ybLkj4rlJn4ctalkj0vYoFHchMiw8ep+?=
 =?us-ascii?Q?aWjIearQjeWau1CsTLlrGgNRskNTl+anYMPUksADhIQe82DvYB2cejlPhb7N?=
 =?us-ascii?Q?98/JVFt33tIO6YsJGfjBmAcZrUakex4crbGl98xD/MN2sv6br/SgsS2iWc3+?=
 =?us-ascii?Q?vIItKWL3KFRquTz3pk+L/cjee5FCPjuET25w6g9VSpcdlJbZZmQmaiadTbDP?=
 =?us-ascii?Q?U88/j70G0Q9yin8/D9W3ArZU1y4Ql154m8WdeRS6KCioZoDJrnUyGi73yk8z?=
 =?us-ascii?Q?P1oX091BWlMwU/FKr1OeFn8NPL57EezhybgKNYVigmjpSCV0eEl1Knyv48J0?=
 =?us-ascii?Q?vpLV3oq13iaLE3CjdizLbQF7bOldIBqNCEjUpMupLBzfqDkhMS5vtxPPvbVD?=
 =?us-ascii?Q?jJaYRApFSHYxjswES+gpNEBs2bQOLsY4qcprsk6BpL0JI89cKx8a/6Cway+T?=
 =?us-ascii?Q?0KzVb6WdaCXzNmR+/Q6e6Dfd1FZwvSj8oPC7DZLfqom3vIvIYFy8P0k3pr+T?=
 =?us-ascii?Q?zid8xA9Ap281hJIqmLAQTpait9bMTHgqB5sH4MWAUsgvRKHVXLE1QE4LsF7C?=
 =?us-ascii?Q?C6ZuFch0D2+FYwXGnaCi1MC2PaRkv+nAm2G+LFZtw6xbPCLAQrtA7H8p+qxO?=
 =?us-ascii?Q?DooWQdE0KSJyKan+iTgP+NcW8dyJynf++mt4ImILam6SpEHy8q3TMyK9OcXE?=
 =?us-ascii?Q?HfswkGEVYsKW2FIlXMDwuZnr7IXjmwSAyeCVH+l0Qpe2rzRd+I1GQOQxJS4j?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d51318-ff1b-482c-3c81-08dd91f9d764
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:40.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltVr/qXFSTRlOj5HkmBc5LaJZntdrU0pVtFCacy4FndrrVq4PwdWvQifPoPkc6jD87Q9Ty6ilfDJiVNUSBpr5CyIfbX/admYDR4R6uPsGh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

I guess that touching these files means "tag, you're it". That's fine
with me.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..94c62daf834 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1628,6 +1628,12 @@ F:	drivers/gpio/sl28cpld-gpio.c
 F:	drivers/misc/sl28cpld.c
 F:	drivers/watchdog/sl28cpld-wdt.c
 
+SLRE
+M:	Rasmus Villemoes <ravi@prevas.dk>
+S:	Maintained
+F:	include/slre.h
+F:	lib/slre.c
+
 SMCCC TRNG
 M:	Etienne Carriere <etienne.carriere@linaro.org>
 S:	Maintained
-- 
2.49.0

