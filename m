Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AFAFEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A48283FAF;
	Wed, 25 Mar 2026 12:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QcnqS0eH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C737683FB6; Wed, 25 Mar 2026 12:23:13 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA94883FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aATeBcp0souYPu5gQDJct/vpFM1Qndg2BZRSjtFZhmbWDtfjAJvQn1m8Gewx+yreT8sI3htORifjiSvfo9Xw759VtAGZxp2WDlXw3DanrFbXLMnGoAfBmjL+lPGfDRY363I16retJBNQVgAr1X9Vef6LgsBftyD+GfDrm+h5hthF7aHPeA0B0zl+kC2OsG8hmElQhswKZ2C0kdd63JOUVrMJHpTAkGPJCzD9PLjmFvdhYCDfYAi0Y42f4CmphAxCFsDTwYNV5rbizuasPaczea3IaxXBBuGkNIwFNrHt0RPHZt//42BjbY1mVVmTQrsAqo3c6xvvksxV8R1sQCCdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg6sE/oee8ze4blsYLuLKVoiP02p6UHIaFQN7vD3nSc=;
 b=olI2WvvvuzfAz73zcWgpVfai0rrYukYV0wN4h3y46VBvo1/b0asVi5CH+DMe0pMip3rYn9n0GvNO+FCLz/bN+UQX15mp7hg2Ykcx87erhQL0SK5zkIAT4RLqjulORV5suPZwiF9n6X0ZfToSIWEnsmgBXJHwtrBgLJ/qkSFu0pHNDzLsBQIlUXsin5qGtZ9UxEM70ia0itdmySPZ5q1yxRGn+bjkAJ+UONctXfigfi+QR8ivsJktyUd8YBQv3f0Mj9ezBHxPlA3jGxAo8qXkN0P30MaIuP/5/rmv7hv0upSbj74DzObeuch1tuRVYfpQfxrYlxS1xNqO1Hi0I2k7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg6sE/oee8ze4blsYLuLKVoiP02p6UHIaFQN7vD3nSc=;
 b=QcnqS0eHJ/2By38HVNXLdfD5y1hVUb2ehGdVqViRqmoFN7hPQI4yGsN4HTZLU66GTeYOFOcAYd/jNL7ezuRT04bPL3GBgU2eUfUXCcu82YZzj1mScN1TPYdzXOkNKkriCEHXuR5C6Zb+4EiT+53X3YmkCOWMHmbKSMm745q5mOM5O7/txItBAJsgp0iOewmkhReJPML/irTDvYcKzLPqUtexuYnEnlwG0L7vEPRpWtJj3AuJTMkN/t22sApFA+DSfFVzXbITvGmwD6Bos8VxqiSW3HPQp7owR3Y0Se9P9VO/mo8os1JgbsOPnuXK2EiNt52JkEOxCV+U9HYvXS9VyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSKPR04MB11367.eurprd04.prod.outlook.com (2603:10a6:e10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:23:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:22:48 +0000
Date: Wed, 25 Mar 2026 19:25:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/8] Kconfig: update build-target for MX7 with SPL
Message-ID: <acPGIqc2jjF3JR8p@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-2-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-2-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: MA5P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSKPR04MB11367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9993778d-18fc-43f7-8058-08de8a60d85c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: ppi6TO/uAfazC4vp+fon8n+a1iJPofi+dJJqBRqXYzkvgha3WBMSMg51T7mGvuOIcWQM6OzjAmWqDU8xWQuH40ICd3BSxLv3Qt3bnx8HWAFAcXXxqkoPyetwJZJQKd7TRzB3xzZj9inbIk/ZHb5Hf9X5/mwBUKus3zo8cuy41zu+QyxGqijcvZb9WplBEln+mSwKH8uQhTnZpmg0UuZpEL5eFryT2hksTqaYqRsqhBawmeXOqLIrKgSJIXpebO/+6HNcmU44yLFGDniNgQIowypVIdVWFMsT5tY9rMPcX3oUqbwm5vnzYLID8O0mF+Yaq2D8cokJCHzIXYtxdIt3y0S9blSjCRMreg8NXOOrseRkcVJtPhxokhMDCG/6geStlRJd1iG41ulwDUhxQcYw7eV/hqlZqWi7DUIp6jOVbw3KkpkpYigNLgVJuiUQ+1uwOERwQBP+dyzWsWtyclzsRNqg6kCufqvNxaGDC+JpxZG5OYf6MfZ+KPqb13Hcet2HEvtZbj13mnDainWAsyaJcKs0fzOVC+5c3EjmJeRGX9A1uMxmasz7nFPqEXzedhbAYY1ZPSJedshrY7nGqKpLK59WRJRnQkjm4QDqTM1nfyUuIg4GscT7LhpHGeLBLjnPPNN3OKUqHZC1gGe39DWcbGurA8iAvqLHfvrFJc4dMznWU0aecS4PcEASeFK7uhBNI0ZQOSO8SDWfcSgqqgu7LCa9te6xxie8CfevzpT8u9g1oMD+SaP8s5EnLz9IMbvcsZ7tsZBCoi94NwvVkrwD3S/ArZbFPIBVhHPpBxYAedA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?678UJW9DN4ck0bipYev/GXsA+VyhGqm1b60/+zh4/tRuTTdruSeNd72EgxbS?=
 =?us-ascii?Q?ORrcafCD1jsyGn5doeGDyEUe+rDd4I4BGHiuAH41t6Bpy3nMs1ZsNwHfthhv?=
 =?us-ascii?Q?4jVDmpZQH5w3NXFfwTbtxQDiG3NQk25Qasv89xTOuiLayXZK1FiNJElg0E/1?=
 =?us-ascii?Q?FTbTk2BBcWzFkQljIWExwzV7ZFkaEU9yQ03YZm2AbZ08+OQtuyQJSVyu+RXo?=
 =?us-ascii?Q?ZQUlEoCUrrptz4NyzJQhZneGysmyUwFXA2H9TtvdNM2JOefhftz3wJm5FMw+?=
 =?us-ascii?Q?o54lDnXy+jnwZm+oReyAa4brjzc4fGA0bKJRpYwP/SZc7fSxIUIWreOEyMev?=
 =?us-ascii?Q?itZiBNpNQy6e+qUvStYCSi/78/xqAqLfYPFcTueHJ1yjo43UbjDXi1r75Zej?=
 =?us-ascii?Q?xPD7lDMF6+tWsfRD4Ep2+R4+xz4X3TrnVQ7jqCg46VCg4P4MLGgZtkKLo8ma?=
 =?us-ascii?Q?SA+XWGUnuQexAyhAQH7WKDUAmti4h9mwnmf0cE5fWbDumeHVF4pYht2qjvxr?=
 =?us-ascii?Q?Ejwx0yG/SmAXCcqqifwGj2SoeY7XoOzuaY33Pobd1caOgPnnhbego/IYZmtW?=
 =?us-ascii?Q?XZ/vsE8LPano7aqProQO4fmCguWuz10fOmbRtQFBK4VBWefOjrPARKW6OOVo?=
 =?us-ascii?Q?Y0Dm6M2+8eHIsMWi+YgjTUP7XwSk5lGbVd9a788TU0AWF2aGYG7sxWErZ7Ln?=
 =?us-ascii?Q?d5ETjY6UEb3Px+h4ghHaEl5RoE137ytWYVjT+ZFlw7lh0ULN1CpUcyMH55O7?=
 =?us-ascii?Q?MvOvndafNYk5vBDNPNncgBnYaWf3fg8W53ncUhYnNqe+DJWlfG11pWQ2Uf/b?=
 =?us-ascii?Q?qmiR5JShWS7HlybjIO6ryCrcbrVmC4SB4VYv0IB3pGfyByDVw13A+GLGtX5L?=
 =?us-ascii?Q?xiI07Il+F/kYlP0Cf/6STxo3BdioPE6hL24FtAfNVMsgaAN2WDuCcyI8hhs/?=
 =?us-ascii?Q?7USl1vZvuKDxetNd38RwOplvv1+dffpsvE5GWLZglz7uowEBwow0VjJ1ZIUx?=
 =?us-ascii?Q?YSHFjRUe17Mi+gIVToam7EZmo186Y+xz4Plrw9u4VMGtWTX93KwqwEoWBOZw?=
 =?us-ascii?Q?v4AbBL0syb7My2cy+rd0WrRS1a/7vIGJ1MEcGVQ4aKYGp37hXLrMRsV4aKXD?=
 =?us-ascii?Q?pSdujRqv0XaIKLGKeQBIoSngsEYOJw3JdC0ug+J3RGap6SPR2lRwp2Q6COa4?=
 =?us-ascii?Q?hRCO/Wa72dyNnxZERjE+Ou1umcJoRmEW8XlWlqM0DKDm/9k+cs+KrYM7mEQT?=
 =?us-ascii?Q?bCWjfUrDiF7+2nYj3v30vGiZxyIXtR8zNaUMnv97+Kt3pbnYdHJIAhc+pbIa?=
 =?us-ascii?Q?zuA4Ef0vARCxuXM/QytNoTmCZ62ZLsk2mDSUnr2oaRw5M+4jRQRMVowoJq0T?=
 =?us-ascii?Q?wyVjGsytbY73wSE2GI6hRUxzlBdTuw2ebBN3x5nbShVjZvKgEPP0F5wgmQ2i?=
 =?us-ascii?Q?qIpvS7T8cm8kYMrGUsZpIfR7M3IWbY3VRQsRo+ULDpt9S/bfLzdT0sb/iu4P?=
 =?us-ascii?Q?zGd9nvDAwQeKIuxI/Hut0VfeG9I2L3ywwM9Eg2ak+Z3AoVmj9aS5FN7q0sKz?=
 =?us-ascii?Q?fzDkEgdS1UIr+Uuf3bNFSMGUCIzSga7z/UZobzoXt3aHHt7KF6FLxEI5T78z?=
 =?us-ascii?Q?T0g2kXgYOeq+9owrSaAYAAKitfXMKcSHDmfiQ2TkqqXdec4dbdIG7IK3mctQ?=
 =?us-ascii?Q?phVJyOmP8MtCHu3Gzf22+lmUOlRvc8EDVh+Qvx4QfCRk4DglFid1dUz/mx6q?=
 =?us-ascii?Q?a0b4UDbfjg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9993778d-18fc-43f7-8058-08de8a60d85c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:22:48.5910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti2BQDefrWma48e1qxUE+bqkVKCdsiHBuoABOZnZ7iPKfyfhAXK6Hlp4iLf++ku+zDrzZFfAlzJfadgxdSV7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11367
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

On Wed, Mar 25, 2026 at 10:57:54AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Prepare for MX7-based module with SPL support.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
