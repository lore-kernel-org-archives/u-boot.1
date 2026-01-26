Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D342E63C9E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8F683DB6;
	Mon, 26 Jan 2026 02:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HiOk+S9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEF583DDF; Mon, 26 Jan 2026 02:17:48 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5D883CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kki2M8kkDSCHKJBDPDGlj1JRp2FSIVECsMB0JTKhJ9Y5isKixuRLtiwFI0s/vI9UsnHpEu+Fu0/QZkt/Ytv5QT6gI7s1Maf4u5vbZSTSM8y0zbhyENaWDfMOBr3SYvpqLNkRgnZuKF3EWFwgg4x/aWdbdnzX5K7tE1wIYugrK99nXFX7SmsThMhiCOKp1PsSMhV07vie5/DpbsFAf6eR1/QxqvSn4V4EoRaWLA1f1gKjsZPEf4Oa3u+SLB0RiPn+5pbw//7oDPr6qtNz8ACMrcFoOVAwieyLmFcJbPCz2GQ7E2OA2uHXzeKx+U+F5s/TIsLGcy5ZprKDN8Z1eoJBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB0Ko9RP92V8yyV+ZCfvWDmD48FPV7CJ9+2NM++wPEE=;
 b=b0eFTugLoVZNFBxEZV0yAuJ5z5MD/2TdC0PEYYWmbZyZXrV8DNGvlzvUfwOZJpV5gP0TNblALoLF2Gk7lVYznbo24MsOE72FwoY0T6xuUkwUKavoKZStcIHtk37mO4fbg3Mnu/c602abr4sD00OzkVxRKIJ2bOigzO8PULr2VS47+cbPaHcD2KQQHMduyEJvom34ZKDsNLJQiN5cBsvgfZMQVFGrl0NGLoOUwtZ+iQj1kn9Uw/AMRExkDmKZX1UhwFrlX2oeYA96B/E8w6iTmGIclfsoUwubnW3kA0M5UfTFInAXY5dkuYUUWmoJkXoHIuzdVPY0jSGXKoS1CJRWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB0Ko9RP92V8yyV+ZCfvWDmD48FPV7CJ9+2NM++wPEE=;
 b=HiOk+S9MEyq4VKfhEPfKqwMTxslteYzIG3Vb/0CvY2oNFrw4jRH9JsLdw9gZcS61hMdUylvVFnN2USc+0rg5nFkAAw4SE2xNCqzHXImwN/KLyvIsN8pMEk3a3gJnakCWw0g2BlBIwJGdGZoYa+uVaZLiYk/dkBSb9Ri7sUCvD1f6gpgxgTaDdsqs1+olK9QF/inZKWF+FEGhfSE7b6tZpxFijy+vq+iyH5NJtBdpQVh+r06Aa2OxbilIGV2mzexH3fhkzjQwP/I2u6wm/LWYJxVRpn08XVXJDa4RE9RpzoKwMzxoJHAfm7HrmfUqOvlhOU1AFCpFAtdvXfRYrg0I9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:17:42 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:17:41 +0000
Date: Mon, 26 Jan 2026 09:17:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tomas Peterka <atheiste@seznam.cz>
Subject: Re: [PATCH v1 05/11] imx8qxp_capricorn config: add wget command
Message-ID: <aXbAsf/7AxHjBbBf@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-6-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-6-hs@nabladev.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb5d46b-7eda-4ace-28fb-08de5c78b3e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jjQz1op0IctxnQ6XgcXqvL3mBufUroGus2BSggVBPwyymWlSlG4gsCsY37qc?=
 =?us-ascii?Q?TEBjZgLpzS5P2aj0y5mFbk4kq8jepA6ktTPYhjZEPDRNfBZA/aMXT/M5Q8nQ?=
 =?us-ascii?Q?e1Sbxr9RCO8ycFPnX17GISwLT+0HlzbwIzo0o2Uyrg4/zf9iGMy7QdvN5bd/?=
 =?us-ascii?Q?yH7aE0YPxUpQCzIMfZo1hIAQCf11vVY23qPXUQTeKXpVeve+sSWrf6z79qPR?=
 =?us-ascii?Q?xL3bqhgN5INXzUbLQsSubSYh3LgXenfUvxJO2JdBnpmvM4mvH+a5uw4aQ9BO?=
 =?us-ascii?Q?odMVHHVayqxNhEgkZ0eAal7EA8aWizsaSCwt8pA7LrFor4NZp3O9OGvzFXB6?=
 =?us-ascii?Q?OXEvTAsgmuMioDaInC06oBl6ZcTy7vofUbXWpWjTYvoqydu9c2AKC4xNR6SD?=
 =?us-ascii?Q?RBplk/GAWGrnlnrcLgfXuSToMpo9bKkv8Bw/QHMkZ8OHpUNPhpVDS9BU+SIa?=
 =?us-ascii?Q?Zk8weyw2kyjAjzEvSx6978H4TgN8+hYmqTACD0S0A/MxayENF1uj054nNjyb?=
 =?us-ascii?Q?MbhC6ifgAg/Vv8ZWav4yDaHDt0AVMI7E9JKiZaVLvsnmZcrHc8Gs4oD4QEEv?=
 =?us-ascii?Q?GZ95jmEpDhYWBtnFclFL1JI9DAJC4i5WmQfHwrKRAGudOuxdFhxFGcvVBnz5?=
 =?us-ascii?Q?tZRD+BtepsqkvIvRAXUFmibHr1ZkDxz/95Thf9R9WmnUM+Yg9EnIgQRsmoEv?=
 =?us-ascii?Q?WbR/170ViKri5urAJ5N4fSMHLfR2WUu3BHmidkndMxbVQgSsVZsnS3s4hAY6?=
 =?us-ascii?Q?CLZPXslow/OPmNaDU8X6R+5mAoGGAz/z0yJ12O1Y9TYYnjTkpj+mKe0jUTM1?=
 =?us-ascii?Q?apv1rWELtF8zQ+qMSFlOWyGETlE6A+0NDSq/9f2cSKaDj/jbooZsDPzc9BKn?=
 =?us-ascii?Q?IxBu5SW+4cSkYRPc3cpN+H43JwvTqqVo5mr7D4pJ8gUuW1YI1jaP/DjKPt0Y?=
 =?us-ascii?Q?wzU3tRUcLrbbv8uV7tZKJgeGBgcl5gfPnH9+pYgPQcdjkafJdP9vi0EXZNVg?=
 =?us-ascii?Q?DTTArCaUGmjcZmr5qFaWou+c7i1fdvxFCTGQ2jwCckzoDJfehAqd5g0hc00f?=
 =?us-ascii?Q?5e/zpiXqSJdinH/ReUYQ3Li51XtRszv/vONShUDbawdwbTVHxP87pe+ELNrc?=
 =?us-ascii?Q?dTyQNIcPA7RbjegsV0HCL55ZIyFaw2xKw2o823IqfLza+2afUd4ARxGlXqKH?=
 =?us-ascii?Q?k5VLPfi3qd7XuB28d8WFv2AvcM3DuMBRgDKw/x42Cqt/9/0JyxqIZiO6x2q9?=
 =?us-ascii?Q?ZT8VOa6uUMSiRSWAz8n+01B+oox4we13XuyT9OEtBVBMQNLSzKp09mWhdLTb?=
 =?us-ascii?Q?SZGJ2UXIcfWAtiAB21a0XHFLqFbAviE9m7UPLDTkAGgi8d5/ZUxCtTuKv9e8?=
 =?us-ascii?Q?jRYhLk5yiaSP6dzFeqSgwQiUXxY+joNWVHNVLQBVDl94bfMZJumvpgH+PXHE?=
 =?us-ascii?Q?igsx5ErynK2dG2eTLdFbwTdL66kbah8qVRcYA7wzgG5vdJr5426sedRXq0ET?=
 =?us-ascii?Q?NeMf7NDfvxjDPs5EB5CcoMyVQtmPupeK0sfUcxq2LMS2I8kqJNU4iQp2DZbQ?=
 =?us-ascii?Q?UdpPyjaGqj9gsYDAOmQEHjLTjM5VaBo9jnc/l6ehZ+rzX9ug2/x6jE1/09f4?=
 =?us-ascii?Q?Ud0jNDn8CeyXqSufaA5KQjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6S7fkB06xgnQu0E+26S4RjDnj1fNWfO/JqEsbkWoaEOh5cZ3JjSwfvafZgTF?=
 =?us-ascii?Q?hO2jcX9k9P87md39dVUdf3oQZ7Y3a37Yw0ktzx1UuE4eph+dh8YBG/DuAbzQ?=
 =?us-ascii?Q?LVIuCtmet+PpXcotX07JN0KnzSI4iLWZqa+lqA5nn+XRxNTZ9O9oOhxc4Fxd?=
 =?us-ascii?Q?C/6tkrMYGS9SbM4IditK452Ojp9/0d4aKQe9m8BzgW8C0TbCbTgU9MPFQf6O?=
 =?us-ascii?Q?eE3Ws4kqxMhwWMN3F6lR6XOoBqIZIh/aL97gWpSW/3kkwxNlia66S4CboS/5?=
 =?us-ascii?Q?tHS0+YsB+GbrTsGTAouQXQtuhc/CBS1rfu5fSjg9KGBPdVCdQuUTPMt2v9E4?=
 =?us-ascii?Q?ppVVHRighXLgA0GbgBSEmuX0R4llSVi96amKjRQ2MGFEjT6E9AGLo8fW52r7?=
 =?us-ascii?Q?0lKYanuNoQ5VgKlg10tX5JvfMEqO8FqC5PVRClaS2+LJcW+qYiRUABosbp2H?=
 =?us-ascii?Q?+b4jIv5r1hMba4MiTytm+9ynILv8sUm7Qa58DNcui+PSiSTbB8F8Ec9uPVMQ?=
 =?us-ascii?Q?NqRZvLxgI3I2U7dq88zkVctMYsacGKSfrJ14Y3XWLDC3VaNeDz+8XoatLz+y?=
 =?us-ascii?Q?T7SiEpbbyblDHASMNxRaSp4mktoY3LW8OackpDgHShfmTexaqpTgx+l7+uPO?=
 =?us-ascii?Q?Num840JYo9Zbs6MG+6iP8d2nNmzDzE0uKdgSljziDEGCetU/yJKYKplRdVJm?=
 =?us-ascii?Q?yLuEbbCNF8V+zOO6e3m53J9srXRBaH5pFQAqr9b/N8zINF/JrxC3XFkv9HuY?=
 =?us-ascii?Q?ueRmZGNp9IAhpuTzF43WmsblhV0GrSvplXW1wp+tPcvsZPLVDC4a/m0uyqMW?=
 =?us-ascii?Q?aJiEqGTaHqcLrTRuytE9VcTNe5mAkIad19+vp4sZpUUxQpCuSscf03kvW6ga?=
 =?us-ascii?Q?q9Z6W67La7/uMj7xkt03OGmWRTQXSfoXGhp0DH55t4t2aXg+5a7G5FcORbBR?=
 =?us-ascii?Q?q7RYTRHF3TBXAR49h7R3809xMBdLTkP7MH2atZM0lhzjyOwi42ZvsB9TA5Wp?=
 =?us-ascii?Q?GgBwh4amZXJUTAdReB9ZE9/pc3383arF7cm0mKOibw4OMAWk9axLQ+3URG+E?=
 =?us-ascii?Q?RRrzSl5gw6vxDADUhZyjnChKQxxO0NqIckb0xv6O71DSJqVADdSkUG99CVZH?=
 =?us-ascii?Q?blbBvAORk6bzyndXf1onE6THVgPiEa01dwLmFLBqIAkqClbX+HfgzKETVLH0?=
 =?us-ascii?Q?VmorsRDdDbnf8xm+y9FthZuq2dYt2d/pUZFw77Vlgj67IVhy2EWG2FNSdTLq?=
 =?us-ascii?Q?YQCJh87NoK47ZOR5VKAswN62k5ndhWt/hjPlh0QejubweTV7C357qEmEZZez?=
 =?us-ascii?Q?td+X8B08PqGlYB3RqynCXGnUTz5JaFZJ7x/pjmbc7Mq31YDuH9UFMb/0a+gD?=
 =?us-ascii?Q?BrojCbqjcwVTFN8+9qfiOvLggiDKOZ1Wm0QoCeXZpNi5U9EQu957gr2riOYz?=
 =?us-ascii?Q?RwiAsGx2G6tJisQHPNY/6yW0PShMO/A+UMQVLzxzwqcugFD3rCjyZgOs3NC9?=
 =?us-ascii?Q?EGlG0GNnM7Fs4DaNQ48kyV+iNiDneAneJ5WXKVL5RVfzP6svjmHy1WQAE9IV?=
 =?us-ascii?Q?XZN7pfPUK/Wp5vJPbKWIXih7Z/63A3R99cZEkmwNfEHTaEfzIu4KEuOVweGS?=
 =?us-ascii?Q?K0QGkRTmJ1VoRPbxGzqOodeqXOW/lAB3Wnue3RXbEvH5kbwDbxoUMoh6nW5b?=
 =?us-ascii?Q?Dj1tyL0pAoekaGZdMtfG00sdH0Ik2D6xqUU6uvSqsqePxTpwYU35QTHiRcS6?=
 =?us-ascii?Q?00v9T2NC9w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5d46b-7eda-4ace-28fb-08de5c78b3e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:17:41.8800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVInUIteTkW1v1kAsKoe3ogsU9ouLjPBMhe119XpXkVVafDphYLHXODET8KHt39X7QzrexkS2r3LpnHQCpZhXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
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

On Sat, Jan 24, 2026 at 06:54:46AM +0100, Heiko Schocher wrote:
>From: Walter Schweizer <walter.schweizer@siemens.com>
>
>Faster than tftp.
>
>Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
