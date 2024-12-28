Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1E0E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16808048D;
	Sat, 28 Dec 2024 11:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ed/R85Hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA3D804E7; Sat, 28 Dec 2024 11:46:55 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B7C80362
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOOqCffxbtpENJMsgxEqwhDIMKjPS6O2yrgUxNmB6pEnMoNpFOmEiLA7zvKUIG+Ukx1xfgK+dhN1X/+Joz1YLd+udSkI8ky6urlue5+fhzBdyAJ3IT4/XCC1W2zM2VQ52Hj4JIDXUwKneXL9VBrC9iLFOSN+me/i0y12x0jNB0kPCg4VWWl7vcjKoppGZE/qQpm+aSwVjrZxMc9l3WJvxpNBxuXqAmlrieYU18wIW5AG8tS9groe9YGYTJQtqb6hmqXc3ji6WFsPil5k3c1rLN8CQVWpZ+Jm38Xzo0jAkpwhRCl7RApLDAPg5K5y4cjFpJSth79KvDWTFex4WEHdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=alnh1pyopV7AX8B+SRLmp8jDRx4u+iWWXHKVxCKNOGZzzynNP1lAG5+pzojoW4bEm2R23SRo3wysiEGZCkcvaLffXidjqVzQU8njsThilmsBHz8724JpHASqbOhamSYjr/TwDBlBynegCLY2nrko1QTkSc071h7V5B8I0L4GBcLhykCsUgMWTS48VmBedk+c0DgkkEPm+b04rsj2dXCjgxhC/q/bkhfNz33WPoReEYdGDpvYN2QdcvvUCX5H+CzE6KVKUaTZhjyJmeF7+xPhUYR7zYJWbSRJES2jF2pWy9sfHFO2yKyZTIIehxE6xaq+GfpU5/hUvLhFb69k0Aqqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=Ed/R85HbpvWENB7Oli06fvBWWL5ZVGt0brD6/DbmIW3gW4Iwf0DJXo3+2YTiWL2z8PWa8qX2p0wvfmReWCpVUDWUjqcM0It7kdsieTBb6bC32twyQ9AJD74HM+cda52Nw9hMNtfgZoS5Ulg0EWgl3cHpW21q5sNAVRzsoELxodYSFYC56Coq4OoFN6s7ZzcArAUcJ/AoxwELwHRmj6wKGfYpRRppANm/bSXWtEl/Kn88QUjZdYlCHiMXf4DiGvTkvUTxVp0XNAeFNM2MUPwwolwysus4w+FSFtO/LzjAB7DyAs+dFLIo0MWMAD369YWWlqavzXGq91t1pHrVE4OyFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 01/11] net/tcp: fix TCP options processing
Date: Sat, 28 Dec 2024 13:46:27 +0300
Message-ID: <20241228104637.4173913-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dc9e06-9450-43b4-585e-08dd272ced23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/PqLEcYxtzjUCk2B0LJuNHkL0JN1tNg8joHaYh9iC0spYqnDg+29RXX7XSF?=
 =?us-ascii?Q?G7SmkmxBMQR3ixuPutkf1LTYBQ8meCgRhYhpwwJXcMQb7HSZOkGmXVR7MRDe?=
 =?us-ascii?Q?8dAf/caO9+kUWXKYwzMBOrs2C53ut9hfgo7MYvIxmcNT9HC3I5ia0lvjUkl/?=
 =?us-ascii?Q?EeeLzhq+Os4lNvgW5hklFTSlWu2xE+6pRwSXow/LmqPw1rWeWWYc/UgVUeDx?=
 =?us-ascii?Q?IuaYgcIuLVvFif1M1ULwkQddDDQQLNUXzzCsfwFaZJOqm0dpsSAqY8bWXQGY?=
 =?us-ascii?Q?Pxdanl1bF6WP0v7EEEVKC2Pt7IdVUGCs0F4byrJm+/iZafL0QO/PPiNhRQLm?=
 =?us-ascii?Q?7RR8u0WhtMuVdUm3vh4B59mQwoHt/ELDoc+KdNwlkxR5Bf2u5+Pu1aaIgI1L?=
 =?us-ascii?Q?zNS0AUVPOFdUf8I/vxPVVPnKkK2sup5yOBVgB8gPCQpMFXBj03IKfXswvziZ?=
 =?us-ascii?Q?Vw+QV0bc7iv0fkicZZkYNmjC8J1YDJ3Y1jz/6J3C2tYtmmuMFVT/k6crh5jk?=
 =?us-ascii?Q?qSpvYPx61YHbAWqN1glrIsgu7p346KEXQMO+9bNbIWNuUDde7D0ysK4EovvZ?=
 =?us-ascii?Q?SHqnIeI99CXd9IvdnntnlW0uVkGHZARbvMlYvPjnWdzsTPNVjzUxjatQxcHD?=
 =?us-ascii?Q?es8B2olEaRazrEbc+o5qCE5+FCpXMxa2M2EHW9d/qzxhuZRj/eHwJxdB/eXi?=
 =?us-ascii?Q?OLgm9cNPBAhqvaR9gTYdgsLt1nvkUxV7Xde8hXJAoI7maaFVu9cM8nR8IZKQ?=
 =?us-ascii?Q?uQX08uRJUV50EwVezMfzmBYWLQ+lPERm42GHPNd9XqzHG62zeAGqYlWkhW3o?=
 =?us-ascii?Q?ClbORacZWCXfZ5aVMsSdRkTI4ExEt8SalbWfD/Jdq7VJ9kezyZKoHi+RDJb/?=
 =?us-ascii?Q?teKtsclH8AvK6ZQm1j6Ypnwu7zCmihkr9qkqFSU0BtyX+HqfW0J+dsr9swZD?=
 =?us-ascii?Q?2hRmZJhM/UUiy6DSV31hlMWBOQf8D4BHd9+UnHbWZZwBmD8lMSsGyzCLpLIP?=
 =?us-ascii?Q?wmPnUpcPUFc5kbh2LcOpsjnNQaWCbLs8bY7UIm9K25liFIqK9nrmEeQY/BEB?=
 =?us-ascii?Q?DIrEKOHvr9xU2lLFchYnydNEkbq4b5MhM/bo6RZWSOqGB37zdo0MN5dPl5K6?=
 =?us-ascii?Q?ONgIoseVOE2IoVsmylaMgZqCE7Rz4Oj7rH6a+u/cqEsR06IRJNvAV2mraQgi?=
 =?us-ascii?Q?o/ORzkGqJ1ZXNPSCVecU0+dBY+jxiqxqOELQuKrb2Or/gEDjaeeBGRSmTap7?=
 =?us-ascii?Q?/0gw8ZiYF9e317xLhE7AueivvgCU4a6FTw3aMP1j2QrgaZW+S5xelQVWQiSL?=
 =?us-ascii?Q?oxbo/5fIj5tCmcq+cnuUXLuiNx08KO/tX+dVkHUMuzo9yekQUz2VRAsw9eep?=
 =?us-ascii?Q?qmp3FHCB73Dr6ctqJO1De8ec9xai0IijE+1eR2Zsd02HaPjMed9Tw0LJ56W2?=
 =?us-ascii?Q?l9MUz1skZMvxjfxoNmME+9ZcVIZKXwTreOP0GdHoTGSv20Jt0kH85Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cE7wkIv7GQ1C8vfZW82sG8i6PegE2MZprHc1AmUqnZxAIArXDzzXO30QXpD4?=
 =?us-ascii?Q?QffHK1VC2mLTm7uZBjMJNnNiANs3rl/8C+jqeBbD14Y5HDWYueX/5HrI9/0s?=
 =?us-ascii?Q?wdwMrexgvn/wxE18F3f4LWWKPve1xrXGju3N4lunmyEECdekdWr0ryPbuJIj?=
 =?us-ascii?Q?Ov+hXIH4kvzWs6JnPtrhxXlDYcLaDu+M2//Fb8wiDy5PKsxw032sVA9Jw3O4?=
 =?us-ascii?Q?4r8MQwHkSR+jcBU1/eNRc7gtYa1xHEUljnl2RQoUyYT8HnB68Dxl8xoWDPrz?=
 =?us-ascii?Q?CysOrmLVTZdN2qKwpVqjf1umj0XDIcbuXHhFP7bR+Iiz90/ZTOhi8JNNGPRn?=
 =?us-ascii?Q?MDFYO+5ACtOPS/7IlXqY/9UwmE8XzoC9UFno7Nmaj5HRdNy9ZRia6/0uikVX?=
 =?us-ascii?Q?hvLVNkv87LR5zMA8smxE+8wf+dIgQm2D1WxNnXmWx6UvIjA4/lA683lDwSgl?=
 =?us-ascii?Q?sr52aAOH3AWCwIgzMyiBJtJuVQbHkXJu/F7cnWZ0ARegoPnP+3rX1QB3CJPU?=
 =?us-ascii?Q?6Xsw38CTs+vRS7AW/VlWeoA8c+X64h2ZkX0vCygc3gRV/ZVcNniY674qF49y?=
 =?us-ascii?Q?WyziiC8DuWyAEJ7V1ig+v72avyRNXIOtQ0oMCJ+6rMle8R+p9+OVrVR1m6RO?=
 =?us-ascii?Q?nFPO0vFFVQK0xh2LD2XUwOSPWDRDJXrveNRNFzau3hLUotLcwz+r0Xk4/MF7?=
 =?us-ascii?Q?lP0p61hn09DiY1KKFPXjYaO5R+ZY/D4dKUXIRDkeXm2uZDuTnkC2u9vxbBhu?=
 =?us-ascii?Q?SgM4nubeBuKwgEgkXD4I92WuRRGpgYFlDaTLhaJxnFBmyRk6jehyaMwCPrdK?=
 =?us-ascii?Q?xJtqdHVa7uaBLPy6Qzkb2rmUe3PmvzxvJlcsNakLOuOPx6fBbQV5b9b9vGrf?=
 =?us-ascii?Q?J+YJdTx2tGbUzq4BDv2Cf4ip+OTJyajc0JVx281FWUAmS9DVMBPzkM/PPMrR?=
 =?us-ascii?Q?mS1HrRubvqTHB1051KMzknlLjf5zUD91Qwavt2v+5tIS3j6opDlqLt/zfDQZ?=
 =?us-ascii?Q?mHfBxY/3wVQrMMRtI6cRaCmonuXtgFE1CET4AAIhqfSjB26lmRBPzI7EHBxU?=
 =?us-ascii?Q?WvkBLgj8P56iouV+KxL+MgIDgb6d035r6ei8wYH4lbFG5pPwlpQS3w22WVmj?=
 =?us-ascii?Q?SC5uUefgKasaAcX4+EUZaCaE1Wc2KXHri73eotYugWW1i1Ku73zW33j/IL3X?=
 =?us-ascii?Q?UXywKJnIyYBeqqn8oS+BxR8czFzSNXbeNqmzqdiHmhkdFT/4Vm2NP93hOhQg?=
 =?us-ascii?Q?7VVabqxKvR8M3OnUDTwBerPP0eA7bhc4Rglfufa0dvxjZms48y9griK+W8KY?=
 =?us-ascii?Q?ljKZ4l8LLY77SbLnjXR4D6pjz4qQ9gz8ft9Ovui1YZFzaFxOAHc9ozGwIJmM?=
 =?us-ascii?Q?d4AuYavRQcN3p4dFNzZ3/k5fwbeLsUJseF0dEUSLXOnUC/z3OPVjZCj5B6Wl?=
 =?us-ascii?Q?4z6Los/aheQmjwTQgTyyMDlJIvPjLae774hAQ8zQEo10YLoOIzvyV1dBZ2OJ?=
 =?us-ascii?Q?VpqT+UR/USJV9rlDLgfRXHIZ2jGIERpeJgJSn39imchYH0g+MRZ8QZdAegnd?=
 =?us-ascii?Q?BVV5o62erQs74gy0jRFgArFX+uASgWjfR9qMYTBIviQ6hyD1+RERe6t01CWG?=
 =?us-ascii?Q?MwKduod5ssDNkBZ8cVsFWUo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dc9e06-9450-43b4-585e-08dd272ced23
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:46.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhkFi7BDJ6G2wQ5gAqL75GdwSRFByASonpHNG+eFVVRbNu/sIRjgbPT8TpW5B9iIe0j9yr22JJmOETgHeXzAtU1OTCslQcH0xQnkdiqMHLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

