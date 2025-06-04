Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01D2C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFC882AF6;
	Wed,  4 Jun 2025 21:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="clU3UwHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0634781E72; Wed,  4 Jun 2025 21:56:24 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E2A801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9AblUSd8HNTFmqK0dVdO/62/7yBUUEEdgVtsPAG2dmqYqlVr82RmUX8KB3w0wi89V24YMJXojJSY+5py2EhN4zqkr4X2xODhZtLXgTv1z+aleGgLW0uu4GXygMKRZYt+Ln8qjCUiM5MK8OPTc/As6mxwJU6jVLwu9EkEcGUqXgGB+0X089Kt6KxRW0L2yw31i1/sL3Jow3h+UDF5eMeAKoK6Hnb+Da0pRDR+M4+xsn5fddOePWqU2DDf2btIs04OObLMdj6EkcS7V8ucv3uz+bmz8H/douFSPLK8Bd3QtuXzXlgvNSarBXi1sKQ7COI0dd0XymWBHpy6e/SJBe+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy3RQ84NdEQvpnxjeMUGmwOmZ5AC9W1JQdVCFT760ik=;
 b=PrxeXevKYUga1LeUSOkun/r0qfTPuuhUdnB7NH6OYTJ/h/0LQVf3QHxCBa83tS6Pf8cGyCCCbgm7sZLgMDiE8eTraFZTJRwF0mDwbV1CWPRrFXhdMeGi2DLN5QvkrOkBq6GnZ0ZfSyQRATy3Ysvj2VfAVNRVE4pvulvolDLvwjuvazkAlnFyhlEgnz9d0S5GoG7ahr8q0y/poSPlJfaa63Zqflj3ci5ixbl42sVwF9Ct1J/GOj1+iQ9gaToC5zvqbtywEp+VpFbJbZMUxZqlU7jxnMov4ULt9VApMzudrIrdZMel8+Jjuuf0Nft54hnjl1LswrVu0Wmzxcjql51hKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy3RQ84NdEQvpnxjeMUGmwOmZ5AC9W1JQdVCFT760ik=;
 b=clU3UwHmlXW99VP+S3QcZZhNkbdcUHiFAtIGZHFNQZV5Fr+VGr0slBnOJ2yTdehC9dfNiqHH6mlceZH0nKUk8gVZTWUolZ3023zCCKnjr47dBe59ConI24GrTSzXm9aGI4/+mO+Gtose++NwTeXd4pE1NlEGT/HVV7icqb/v09A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:21 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 05/12] m68k: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:05 +0200
Message-ID: <20250604195612.2312979-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: faa0d655-4131-4911-0c9a-08dda3a1e080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHjOlPB7CIEmM68oheW3rIOghDvkDSGINdrA7psYH7LTlDQvFcU7L+578z6A?=
 =?us-ascii?Q?A4btJ5Uy9auzfNyt3P02AJNqCJX/QvD80m7+mLgyA7XSk5SDtVZJicwF0W2I?=
 =?us-ascii?Q?OLJmkVDgSrfqgRdp+ZS/61AeL11X5QYeNg4ui/ceKVdDQprqInxzMMxZ81e9?=
 =?us-ascii?Q?9nDVnucCWioeW41B1DBZAD+GucqV2GKHgS/x1J8TONRL0JRL00rBCeJ4BlTH?=
 =?us-ascii?Q?3YIucz9X99+N7kH3H/xVsLcA1x85pAU6NPaKdW8C4e4BC8P/cPFzm4fm4IvN?=
 =?us-ascii?Q?5ft8JKTDJHR3Ucy3Gx6YWF29zXgAe5C2UxhZH3nVCze2oUgyewZndiGDCLT5?=
 =?us-ascii?Q?ckHtV1IqrODITUGwB4Et+F0x5VLXAjUIF9hKJlHpzpZ06XN0hxyQin+CG4hr?=
 =?us-ascii?Q?ZWp5A6xL6mpp6J0Tfbh/4uQI/HGmVPSEEG2jITGlhTE9ImG8E6j37aOn+0Xe?=
 =?us-ascii?Q?GSpsAWSSuDCzwE+CuQDapIKfJxeyh3yXSxSXYZivKEjKqjpqW0jEi1zK3CSx?=
 =?us-ascii?Q?CA+jAL8jnd926j1i5lz5qQOSyrDX6KVagjwSzJjCqhfMEFj8D6c55s2ptswQ?=
 =?us-ascii?Q?nHoS0DNneRG0sjE+A14FVztU8KhGp7rgXRx1Q3H1ps9SfnmaS4ET1X9C1adv?=
 =?us-ascii?Q?1nZdmdiNDiNHXfu6NstDGpVN6ouzNJI8LqIY9spcLCXlkvJvZ2+l3qiZ38fk?=
 =?us-ascii?Q?N+spA57CKQAzsGCKxrkf60BXEL6tdlbS3MEgHy8GdIT9Dqk1RDHhtWg+zw3V?=
 =?us-ascii?Q?a+iXzCB/FfYDeti1lmBy8lWmdfKSzilqYTavcFZlj6f75+gNS+5AyDu2Sg3z?=
 =?us-ascii?Q?UayJLJqpw2bT21YWiqWvbl60EU8rNtLyDOepnUgQFP/gEWeWG8xmY774ZqhO?=
 =?us-ascii?Q?+6M1ock/dBUblwgWUwLvfviGbh0TRQNnsZ+z/0AU7HDrKLWcK2GR3BTjrw7o?=
 =?us-ascii?Q?g5sOZzi5BOvlSBXUMQbBGHhiCREamF4CfY07w8Myuj0R38qtAFs5/gX4mCu9?=
 =?us-ascii?Q?Y2Miz7TuaexuOOKG0r7TL1WL4hPsMK/cZqjBrHU7jjF3zAetTwS7mtJ5gL+G?=
 =?us-ascii?Q?dlGxkjIF1wVPjeY0VtuRmwu4wGgKQc73KPOvdbqz3eNDcT152Swnis6DPrxJ?=
 =?us-ascii?Q?bGHDh0DoGSjd9GOth90oke13YJXpRar+LTDjiGt1PEspzxYpb70jYtlZmDu9?=
 =?us-ascii?Q?lflONnH9xCqfKvlPhwjctxnJkiYsne0sL/wwW10fqZUHXsRZyYKzFWHtPKFE?=
 =?us-ascii?Q?KDalQTaQrhdHoLGxY+aMpHU48a4bERChJH0jR9z23NA5d9gNgn/CfnV2ISVF?=
 =?us-ascii?Q?Qpl1qjO2HAHpjtiL3rMAZkJjrwyL/QcXoORTKcylLXUfWBR/cg9n/9jocZdJ?=
 =?us-ascii?Q?mi58GHxqFDvDIxpLlbXUMnaPr8PdZDQV0hkQg67llIhPYqlYDRnGp91niTdP?=
 =?us-ascii?Q?nDMrjvWBuMtcfLxd1LmhC6zDP0hKPvtgl67gKMJ0niMMbgqNfWNhTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awX14wDtXflPGE/LsWz7rIAk8b7mtbbkMefq8bUBTv7sYJvKOzAgwlH/fyy1?=
 =?us-ascii?Q?VZBGWnyOvETYUw0Cs5lvEhLUDJeqEviU4R3cohSzLWCm1FkAuucXhhUGh8cf?=
 =?us-ascii?Q?vPkryAqZwmh6/9vILOcMi6W3RzHdGzJnrPspgMIuqCzix01ZePZ01Fu6w9FY?=
 =?us-ascii?Q?DqQohtf3/QNTOTIIxnk6jNyyglUAD+zMLSi3QXK21F2iLd6BvfueD3obi1/w?=
 =?us-ascii?Q?XuEqunBO6R0KFDtk8sN9ndNphLbvDG21XNJn1fnaJv+81kXI5YHswkBKSOKy?=
 =?us-ascii?Q?bbdhvqD2FWhlzrpDI2V0CFTDKj0yOl+qkyNRpkDFdBJrJkGaTw1iPSD/WHWd?=
 =?us-ascii?Q?QVfJ42IhrZilJylHDCzCXHxIBaC3wknTesuxH9LXC3dN2sJv7F454DePn1wu?=
 =?us-ascii?Q?XMJHcZsMe28uJakuDWNaLEty3OSwZL4ZDMT4nkp/9nDJSCh5lilgkYajaUxA?=
 =?us-ascii?Q?03iI1eryafIMMvLULP67je5nJr7dw+YWTAvYwa0SHfH6clR+l/Ljd+aH3g/C?=
 =?us-ascii?Q?dxUigApI6Fa8yblSVbOy89Hd7wW7SOV5hTmMx9hcwZ1j6eRNp1219K4evKYE?=
 =?us-ascii?Q?mk1nAiY7os2Dwiuza3ljSz9PPQyEkDp0tlNlFnfai/eUbww8IbM1+1DZ4iCn?=
 =?us-ascii?Q?cAGf+gbYDNiWG7Ma1iYi44ZZZc2jH9KRrL5MLnW0PhWl+XXVHSzPTId473FG?=
 =?us-ascii?Q?XUgdKHiWLS/lnntGfCyzZldVtOE7GMt4NN71hpUkNfmAGozgP4E+rcEoo0wX?=
 =?us-ascii?Q?InZJEgW5V//idvEDbnrVvDvNMbnAxOEkYgU6hXeHCARoMx6FWznc5KTuq1m4?=
 =?us-ascii?Q?OANH9MgAbqz2ZLpTnoTNJFy5QyMDoYDRb/1cT4WIeB4nTSPP9nmxxS5eWFjI?=
 =?us-ascii?Q?bDCUNNZERvN+HggJ7aoncrsHHZLtpH9HzbORl6VoXZFFKfFHpS1CKGNsGJI2?=
 =?us-ascii?Q?OCnKnqNLVBW6g3dv191xnMgYuWa1VphqQNs5dgzvbLEu2nYcjD2McmFgsn6o?=
 =?us-ascii?Q?BqMvKrznFYMd8lkxvC7V5A2wqiN/eeU+F2p+AhhKOXNO1uHF9D0Axku27SWQ?=
 =?us-ascii?Q?WOv4nnCDqxg3laMGiSShmTir95G9fLP+CJCzYud+rsfvOr83YyYY1UqQgj8I?=
 =?us-ascii?Q?Z4iBIqH9y2FFI8PQ1R30E7GpfTiMg7+1kRWZ7G/yR/5d8JI5wwyFJ37YBWHd?=
 =?us-ascii?Q?7ncSQCtwDfwD1Z8VFhnDv6OAolT4epvYgqZ/zlcXyrW5gkqa+xT1okNctiw2?=
 =?us-ascii?Q?wbjhl1VtajUOGzvfKMULdVyr4iexD5K0FoeHugMiBkw6vChMQBecs9BuEHhe?=
 =?us-ascii?Q?WTojxdy+o/Qpy56yiLkFW9y2dEr+rhURbWV+5H7A/K5XjVuDSM36tD/W42JJ?=
 =?us-ascii?Q?vGv5saV3CuphDHVI+d9s/9XimTyX7YpCqUDkponQzC64RtzjFuUoYk/CocPO?=
 =?us-ascii?Q?f9cCMfqLSrrTXhn5hSUOhFttJMWeoDOXGH/veMy61E9Vrby9onl045WLxE3Q?=
 =?us-ascii?Q?zrit93Z15BAyxhkZPBw6yY5LGulDLKdoMdVsDq5LwNoksuQ6Eus2eC7Jzi7s?=
 =?us-ascii?Q?YVRxeEx2jZSRuW7TXFFVzB6i2qGloCDIGJqpt+0y08Z/vntF+WoXI0AJEnl3?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: faa0d655-4131-4911-0c9a-08dda3a1e080
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:20.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKkrdLhsSxfX2SEm0bAffzFL3IlxftRqTP3UCQvjQWs8S+7od2XXOup38G4GrQwEhLcPc90cDGkfv6K1sCOBwYeosmKrdu8jTo5/bdmn4go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/m68k/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index 4ac886933c6..29b46645676 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -36,7 +36,7 @@ struct arch_global_data {
 extern gd_t *global_data;
 #define DECLARE_GLOBAL_DATA_PTR     gd_t *gd = global_data
 #else
-#define DECLARE_GLOBAL_DATA_PTR     register volatile gd_t *gd asm ("d7")
+#define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("d7")
 #endif
 
 #endif /* __ASM_GBL_DATA_H */
-- 
2.49.0

