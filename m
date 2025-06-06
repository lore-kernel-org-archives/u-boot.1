Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DAEC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9F181F0D;
	Fri,  6 Jun 2025 21:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZnYB+vE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4041782AA7; Fri,  6 Jun 2025 21:35:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A05807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaC2sNzR5nkbOa7xdlznGG2IVwyzkkitPhtAJBoyOfJWX5bDveVylAGtDrCRfCaxK/FGhE19LDeN7MiUSnCkqZ0TUJBXrWE3ULdOrov0gBJIjR9R/NG2j/7M09PXAx4wWL0MBc72JVhsNm1zP5FKMl9xj0p/ZHI8G+R/SuVV2iNkS9zdG1aQj5ISPzP1aIutWLWlcNzQLJp11PKlMXzdswngTpCUY6NUAzVu850LsOZ0FtHUhEg+YUBgymwm/m/6ba5G3vAaAEzHFPLYFzTwR9G1ApdMnyLpwUt4dt4y1T9zQ45bYqFI+fTuWnOZID81oOerWd/f2hDGyVqBlOxE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lb+ycOFmQ7vI4bQ24stu0Np4rwrQi/A03+jZdl5JAs=;
 b=qxj/IkAiFA2oUjNbwDnRXOP18ElAl4IKSfRyA+bQFW6cAzmwnp7dWhfDVWGyGfMU3OYUuaQiaudGs3BzY1EtnAdmCzjTlokr34x6AE4VwQClMoELSCB8CDgOZVu7SUaE/CvJ4ckyOLQV59YyVodLsz4BiIFI36gBVhqo3VAMK/6IyLDC5pwOl1Yhf2pzR6i3J46bvvoRRM7xEAl7N8FnogKXsfikM3EvhTNzLddqrWFOuKneJ86bDMMk+lqMbO2zWDJ+m8UeSGXXDIKmQTCkpDW+iaZtMvfQb1iYJuK/W0p/gzJA+oj3EaOn1o8NlJsUYNWtzeFh3ZScWCkoJFpmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lb+ycOFmQ7vI4bQ24stu0Np4rwrQi/A03+jZdl5JAs=;
 b=ZnYB+vE+i1pJGgUq6pMyIs/6mjMqLoSJAjxW4+r3ztZYf1vzjx1Zvw7/8EeRGkLR6K3nmFZdiN1O1i5HJ1gpH+nUXTRobRgX8FJ3EgA9TmTOfvwsfDdnw7Mmtw9ejdpThpb74gVfNtBVpr0U4RRYFUUe9gfhgh5j+9uYD3OJVdhuN8wrbbi1/93rqIK9rY8EMydTcRhmVCipvKEGUXifjJ+p5wD+y3Zj38bCarsmSBQr483vWxqwxCJ6Y4lN/CYcllz8/8CLJTZUPcfIumw9aJizA4lq85vrm9gLF91ZRPQ7AEMCBS0TOcFTbspquwxHR2KTQmMI2dRFXsDfadoFPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 19:35:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:35:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: common/spl fixes
Date: Fri,  6 Jun 2025 22:35:21 +0300
Message-ID: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::318) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ee2639-0acf-4189-75fc-08dda5314d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p2aWTo5dEqBEzPNUi6m/CHccsb2qgCM4mRO76sDqzOLBLQ5cnn3d1NGR6oqo?=
 =?us-ascii?Q?W8TH3ciGvZmK5GacM4wMb4VGUSkWuqoPi/5C2J+8k73P5ABDo9WceDZajH56?=
 =?us-ascii?Q?j6kHT+2Am1iSlORPwwk2nKYy6yEqU3WSv+jIc5HDKaOcFVp+8O80L/sMFwiM?=
 =?us-ascii?Q?SS0ExkI6WSh00GJGBMmz25J+4pKdNvzWiHeM/uDfIsx5PruRLQPFyD4UD+HC?=
 =?us-ascii?Q?Xk1pyYmFt65oRwO75ylZ4XkqXtDvqRABq/7b7DrQDxms0LzZAtFRtj2G2P4X?=
 =?us-ascii?Q?Z7hdZVfKkTl13n3oPHGTU95M1ZGqMlOr0ldWtiNlmR1+aruxk0pAmzH3fUt4?=
 =?us-ascii?Q?cSm9dolGmppvJNLhPcI7FV/Jt7WQeQ/jCqEb+5CDSWhcGXlwFXa2jw5JzPUy?=
 =?us-ascii?Q?loMhVu2mft9muOU/qkTa5bN9r8sq4MmJ5rrDIYmuTbxhMabwQ8nz8gU5CkTV?=
 =?us-ascii?Q?081wWZpMN4nsvotSpoIN0iUOv62UZgcPxB09ITrl6PXhlPx2LrYh2yCpj+Xu?=
 =?us-ascii?Q?bsazmvrorB4xR6hKd/A0fib4u4eYwL1swnrgTjjr0wCFS+mN99vESAUf2p/c?=
 =?us-ascii?Q?VsxsBKEaWVgqqatlJkMt7CRWMRMf8owZOTAPjWksEIKMDy/PrmMgNO4pIQJp?=
 =?us-ascii?Q?51O+Dvuk3YfW31pqWHPB7v9sVsiSOEPOOBzmEu/tEG1gbysssfSiQo3gSxFg?=
 =?us-ascii?Q?JoUYk7Cg77vGKvmvcTejSRQmJ4My/VdWdJnqkMOZrKNT1n1xmRyCVXWFyMPD?=
 =?us-ascii?Q?nGynHzuAMAcVxtfeEo/KIq/vZGmCnUWeMqGjs07BtYNNyee/bUXLdhqKisSR?=
 =?us-ascii?Q?BDNmVbxVPLWxqVBNy1MVsyNkkwSOQtXI8Pgc2r0Q1/+WPiNSLnNPCYjenZ9R?=
 =?us-ascii?Q?splpE2Ul7/Oa2d4JJjAV255ke3JSxh3PqeXqkC/PzIg0eEuzP/JLgCT64YTT?=
 =?us-ascii?Q?wb0Ep6DEWdrwDY2Y47mf2cOUcolZFdV+nqw0v0MzcNCGSmvXoVtF9YNE/1xB?=
 =?us-ascii?Q?3CcW5MPdyTSHtook9nZ/3hPUtyWF8SWrvYF2N1K2UBFVFMqVB8d0sLpNYL/W?=
 =?us-ascii?Q?3cMHwwkbZi/h/z/D0r+flInI7lsHRbdMG86WP/JOval1VRNButN2ndFOSOof?=
 =?us-ascii?Q?5YIjm8o/+XCyWrQ1cRb4xQ6aMKISR08YhN1+MlqDt6na/5cUwtShsW23xHBW?=
 =?us-ascii?Q?c9Pres43pu8CLJuv/R4nkGtYjtn4ySYq/iWIgyO7Wptmjg5jrfHrILBRL/eU?=
 =?us-ascii?Q?fgaiKMs7oamUHb4Z4AZKFAts4ewgOTnRfkm9w67P6K3oNKH4Ra/rV0Xe+KhC?=
 =?us-ascii?Q?Q5J9vENov/wux81EqGHmOG/j0wCkcJbAwU8eOZi94btQ3Ws/0g2RMKG66LLU?=
 =?us-ascii?Q?D9IprsnX5wnxaeb2ElSbK+EeBiDGLFy4Vd3tziHTLalgEEH7rQ2dR7yaTfim?=
 =?us-ascii?Q?IrA60rpRm6P6WwcntAiuJ7VM0WaxD9AmStkmNlCApzXuuSfndWGYTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHzDUpbl0MUadDPf5kRXPtuoBo3qdr+VkPdPdjh5IPHFAMOfqAcQSZDmUT/2?=
 =?us-ascii?Q?9Fh8q//oJWz0wDcz6DUIyv46TGbNG/vzCPjOHXrwBJjzIRFe1fyci32YYXt7?=
 =?us-ascii?Q?YNQn8scQJECzlq8zYGFmhgnjLNqV/8CNJb4dibXZlCY98nE7lIlt4MlrM2Fa?=
 =?us-ascii?Q?ol8VeFjtwg+XNn4FojOPPq4E6VkjJN+eGWOnWvLXhhzbH1qeIyWfbveaGyvC?=
 =?us-ascii?Q?HPUvMnz+UkVzWJvDjOpaFwrKodv6JvJONalmm8/ol35+P4iPIXIUBvGstpdk?=
 =?us-ascii?Q?5/wfGXbteADy0ATjG2D+GfAVk8mCN4VY6FaC+iNNSzHcjeW2VPtMsqHXk19t?=
 =?us-ascii?Q?+b7qp4XuuyRxr97ONWM0PGC5oB7HOerrO6UFLD+HLKjpUyWoigGJOKI4BrN0?=
 =?us-ascii?Q?Ps+pLfxPygtQePL/CfCeR20R+GmlZ9X/lxvCsXRzjoE54fuNcJzaIz7g25tJ?=
 =?us-ascii?Q?8CN4KSZDFWuVN339JLpPaPL+DuI3+qkcPbmzM5i6XK8+DncAj8EjEQqc9rN8?=
 =?us-ascii?Q?h8OYzyCIieXNy3FYVUsyQjSNcL6DYqKV2sWDLw/NQNgWPFJRXHzm382IxYWo?=
 =?us-ascii?Q?xJaV89uSy7PU3Z6b8x9PAVRBcPSnkkpEMo78PMsF4bAd3a+GvjLWzj9ltj9I?=
 =?us-ascii?Q?fvniGWYcBmk2wT5LEbTKFURxmopb5p24x4DeeUL97eaBKzMiRZyeqUX7Iixs?=
 =?us-ascii?Q?arVhRpBUNFHTNQkbWbRZn5S7xzYt9b7K5f5ka02Fp/dFy+oTqdzMju1PpysA?=
 =?us-ascii?Q?NNKX7hdnDIB1oYhDawmIwx+CxxUozuyc9OtaIcJEh7Wt1gHhsmrpjjPt1Sbf?=
 =?us-ascii?Q?sISv7VfbAqvRcjDmA3mIfPHfeETqil3RalByKJw17FSwakGXr7kOBAFniTrm?=
 =?us-ascii?Q?e/WPqhxXNptzXSALLWYEjb4wvQ+CDCTvdoZcb1K+/bSET+633HnfiN814YG3?=
 =?us-ascii?Q?IK75Svv5PNklE0S4zT27MVaQ90LQwwlRixKtyWO5JqFLZoySPfsF0ZLKpgjx?=
 =?us-ascii?Q?r2H+1J63pSeWHUE5ddU6wSMwP7gp/2ZiIlcxD8g346xrZFD52GUlYdSVsudk?=
 =?us-ascii?Q?yabuOfRdcaydwUV0zUT1sx1Xnc1vt6Jwm1aCP8O9ZWfy80wpGDFxonxphl9T?=
 =?us-ascii?Q?8TlJmOXbrXtPmB0k0LoSIulVoH+rv1ginvegUgGsex2+BxULQuVG1Bmu/DyI?=
 =?us-ascii?Q?n1s3o0YOTc72arbfL0a13T2ikzSgHlNbjkY8IlMJMXKfETh5WByQhGiAPwAC?=
 =?us-ascii?Q?8xLvNnBSYJarFUbRoL233o7sE0S84RYFKvdMds72KAPPHjVtr+E2YA4u6oBc?=
 =?us-ascii?Q?qy2EpsrWd2QPiVQ9NIqyl1l68a1ZljhMxLSBhiZqVNVtNYuY0g+7C+GbfSzi?=
 =?us-ascii?Q?ZOMifLE7bAn9BcQEBSHNOb7EZiwEBH+TWIQA0+r1Ys+SPdfp8DtM18Ztspl5?=
 =?us-ascii?Q?604r0eJScs+cLtesxDqBrqrywrdfV2xcmgV/pI98hBsOLg4KMof0e7iaGb7g?=
 =?us-ascii?Q?mC4q+l9cdKhLLzlg1byL9UeZ/c3XLBcM226nzv3gYYVtTEWxZmqI5n9sraZ8?=
 =?us-ascii?Q?X/WQhQD6UnbJVcVj8FJHmj0IIzUfeAj8Wn7uw72NKB0ujxhIWHRICkLcMQ+Y?=
 =?us-ascii?Q?71W/kgyYBuxDlsxA8oB0LxM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ee2639-0acf-4189-75fc-08dda5314d0c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:35:32.8801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wIgHwfV4FrEtBVT7JE7RyXymC0tkkE8c5CPbl/+R14FGrQn528Jb5mKLW7BCpehySTXIcqHErxZ1Pa3AlF8/URp2Ujll734Nw5IQbYdg4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
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

patches for various bugs in the spl code

Mikhail Kshevetskiy (3):
  common/spl: fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: handle properly images with bad checksum
  common/spl: improve error handling in spl_fit

 common/spl/spl_fit.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

-- 
2.47.2

