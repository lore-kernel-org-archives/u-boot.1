Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7665EC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFED8872B;
	Tue,  2 Jul 2024 15:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="JJSNrhnQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F7D8841E; Tue,  2 Jul 2024 11:50:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1389883C3
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 11:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoW8RyVIIQRs57iddxda9w4nCQZ9uDR7dOmQ6nOA57f5W0No5gTZG6r3obwxBdFahvbzI4cKxGkUMvgOzCuBtBJoEoWcXcABBPcugL46h/dl1ncC4UsR8FoR5xkeq6wpgVKjbQuc8THZWLdUnuqPZUBKAv1m2T+HKWqXBq5ABZupVywjIAhDDteiBaNeYkKa9WP1h8i5gJ07xvF9CLwiSI8WBzU5f6IlwtC4WUL46nrD8MRpOSYvyIyGz1PZvShBVYLnpyPEY+1/iX4zcE8bOjnlN8GShBztotY4WnkjtelCJfWHelrH7UCDuvLJ8JcPaMcg3+XKERzX5y1U/ZN4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7hzBnLUvF7wFY5rDhhxceTASDiSl+BYtBQDp1J+ILw=;
 b=lykUlyxuI0HbymAxAwhxyzCUFejjVqfbru8yiwwpaEYdUZpTl1Xy2Yujn7npexwOcIryvivPSKKolfZt8akSu1eKI6i45ey24d1QGIAzVEmpwyexZddFjYpZ6YdhIIqdrEiWZOYNvI3d2UnGsUaamV2MY6mMNT9EQGCa5sn7ya7QGoYFYLqPlp01up7xjPrs4eoZfpRkmjn3lkplSngmOHBAqFiJSt8Nuj2Ee6G3jxD5cDzgebyUFmSxRn9xJoJ9bQkR6HGl5u4xq6N+PDIcHjYL6hYD1A6wILQ7gzHST/bddCP1DNTmGFPO+yNOhUH4AhA94+lTLivhHf2T//VFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7hzBnLUvF7wFY5rDhhxceTASDiSl+BYtBQDp1J+ILw=;
 b=JJSNrhnQpxUr6dcNXJbA0+kkuWWi2/84z1HMx7sFZzkph8DqYeExDTTYvLIelb25Dgr0WLPlO0AepdVp8cEtCMdZkCMGSm99/yYrhz/NK3f6mI3yzG2wOkUSDaox/zsKBDQuidgwzuZMeMiQ4HBzqf6DyOyLkphy6uJt7aKy1qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8492.eurprd08.prod.outlook.com (2603:10a6:20b:565::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 09:50:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:50:20 +0000
Message-ID: <aa997893-82f0-4a6a-b2da-b8e542dea5a9@genexis.eu>
Date: Tue, 2 Jul 2024 12:50:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
To: Fabio Estevam <festevam@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, William Zhang <william.zhang@broadcom.com>,
 u-boot@lists.denx.de
References: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
 <CAOMZO5CcOA6-w8QB3radO4NXUYNfWNEzs16ACf1yvvce6b2s-Q@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAOMZO5CcOA6-w8QB3radO4NXUYNfWNEzs16ACf1yvvce6b2s-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d4d38e-5381-4dc2-c549-08dc9a7c6278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHNyeVZteFRXSnNBTFplaDd3d2ZyT3lkL1E1S2ZKb3hJUkJ6WGE2NW5kWUM4?=
 =?utf-8?B?a0MxRGtrUGF6TUJobXdsYVJqVzhFa2VtOEVxdFUwTEFMcWpQWkQ1eDVvTFFX?=
 =?utf-8?B?NExRQ3hmSVp4eWRGbkhOWG5WUWFZMjI4dk5zYUsvRU0zc0NFZDVSb2RUb1Rn?=
 =?utf-8?B?Y0hGeE1xM1o1MzZaOC9PMzlId0ZSMkl1Z2lXNlRvdS9kN3NSb1U4QVUyc0FB?=
 =?utf-8?B?SnlZSnB0UEdUMzRsdFVsVW1Lai9VTVR2bzZrOE0xVjk2U3g1WXVXMUp5UUdn?=
 =?utf-8?B?bGljdUgrWkM0UGJOaHhkYndDL0dOY0JsR3BqL2JOdXVCN210SXVSWFJMY09s?=
 =?utf-8?B?U3lCSjJoQlpOalVXRGZxYUN1dmJQdDlHSkJld2ZrVGFpbjRBay9YOWZrbitm?=
 =?utf-8?B?a09hOUx4UzIzL01nTExhNGpJOUZCeEtqakEvOEMrbGJFOEF1bzllMG5sTXB0?=
 =?utf-8?B?ZDg2RHBQbnJkdXFGUzB2S2RoSDZtTXZ4Qk9oV2ZRVFV1dUQ2YVEra0R0V1k1?=
 =?utf-8?B?bnFTUE4rMUdPZTBDQ1lZbGJSZi9HaTE3S28xaDFUQXZQaU96c2tzZVZSaktk?=
 =?utf-8?B?Z1dwSUF0VUVEeVNnRTg5Q1dVOWRyd2Vjdm9XL1ZSdkR4ZzRvZXlxOHU0N1Jy?=
 =?utf-8?B?ZnFsZm9DWnloYjMxUDlMWXhHQVkyWlFjQVdhYXpYamZIN3hqU3dVT3BOV0VK?=
 =?utf-8?B?SmNEaXdURTJrVEswU2M2ZFVURUlHTFp4WWhKdXR4WjB2V2hTYXBZeklheHFv?=
 =?utf-8?B?Z0hIdXFZcllnUTlNcHJpZXZPWlFaNEEzRHZ1S2NsZEZsV3lVMkxaQkdSUHp4?=
 =?utf-8?B?Y2hpNXYxeTBVbFdwengwSzVrSnA4WWZ2WXJxSExJS3NSMGRUV3V6emxVNlBY?=
 =?utf-8?B?dTVibWdOaVVOSEErRElmS3YwdUtxMy9JRWt0aUNYbWYzSDZpN2V2bndtOTlS?=
 =?utf-8?B?SWhIdXluOTZZdWdkdXdqVXBNK1hrK0VBZXZtQVIrOVNOWmVtR1EvMFZjQTht?=
 =?utf-8?B?UTQvT3dSV3p5aEE2bmt3NVhGU0tHOFE0b2EzWW81ZitnUVczdzZjNG9vOXlK?=
 =?utf-8?B?Y0JCeUljeEFJUUhWZmRPZUFTakxZeGE2eHpHeUE0emNKM3VXam1lNkJxbEts?=
 =?utf-8?B?U1hzMTB1SG5aMFZjUWU4U3pzMWJsU3N0UlU2ZWlCc0wyOXhhMWxtVVhIU005?=
 =?utf-8?B?bE5YVWJlb0thSWc5VXRubkJ3NCt3L0htL1VXK0dZdVlwM1dCSVZ0MWp6ZlRv?=
 =?utf-8?B?QUNXcHNITmhMZjA2VHBlR1dKSDg5eUpTRktma1Z3RXVUOTNSbU15cXlnSFdy?=
 =?utf-8?B?OCtZaThzRytpeWRIaHBFNDBFNU10RmFQbjZwNnphblhyZzI2UGd5UTh3YmdF?=
 =?utf-8?B?eXlObGlUUGh4TndhSUVFeE0xejdFejZPcjJRNmVGUmlNYjJhaVVSWmpmQUc0?=
 =?utf-8?B?anRCaVJjY0RaM2YrV1ZRQlpwd2pLRmVCN3lsK0xxNTJMaUVMSkhLU0ZFbnR3?=
 =?utf-8?B?V3ZMMnU1bXFJSVdWZkpxQ0pTYks1V1NsTU1DdXZFVXpxcGZheDhBa2hRYVRG?=
 =?utf-8?B?UzJDN2xFK01BMCthNzR5ZHlIMmx6Ym1pSU8vSmkvNjRNbmpwN05MaUxPdnov?=
 =?utf-8?B?ZUExVlRWVnpOY1o3aHZxZlg5TmxXWEc3dHVycnFKSEUzYkVUNE9oOW5iMWFL?=
 =?utf-8?B?NStrZW56NSs5aFJTSU5XL01NWmFQVkMzMXBNaEhXc1JzNDNQaDVLb0piLzFL?=
 =?utf-8?B?QTdBV3JlTFBOVnhTaFRZQnZzNkJJY0Fod2R5SC9iQjRodGZ6ZElUWXFTUFFj?=
 =?utf-8?B?V3ArOC9oRlBjMTBJOThiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRpVjFuSWszT0NnZnNjRWpxSGowK3JJSW9TOEhEZ2dlTG8xK25XTnlGVjVB?=
 =?utf-8?B?YjdpazNZb1psQlEwNGRtVk5jRGlGaWlpQWU5SEoyajNiRDcrZURsTXZETXhl?=
 =?utf-8?B?WXJjcm8wNlVKR0pYRnB2Si81M0srVHl4OWhpek5xZWJoVHVJSU9VSUxVY241?=
 =?utf-8?B?YlNQbmNWY1NON3ZSMUFGakFEZmVwbTFhSlJRL2crOVRpNG8zSnduTUl2ZDRa?=
 =?utf-8?B?ditmejZLQnR3QlcrNE9rODkvRUlYaHdiOGFhclVNNE5LT1hSTUczQ3c4OUFJ?=
 =?utf-8?B?NDFNa2FHQUZ0MnJ4Qm0xSEUvUnpEeG9zTHBCamhPUy81YkRZNUhlZVQwREZJ?=
 =?utf-8?B?aUFidFhkYXN1SUJRZk1ub3FMcFpmTlFtcm1lMkVaWTkzVGpJeG55NzNxQ3Bi?=
 =?utf-8?B?UWJla3Z6TXVqTU5keTZBQWxKdVpSZW0wWmpDZUZCbHljVW51Y1FHZG1lVzM4?=
 =?utf-8?B?QlY2dmlHQjFOakRhb01jZTYxaEV6QVZQNEVzUXF4RlQxcEN2S0JrTlNCYlVW?=
 =?utf-8?B?ODBsSCt1Q3VlRVZwUXlBb1dDZ21ReXlKWnhEM3MyQVFGMVlXZnBaYW9ZM24z?=
 =?utf-8?B?M3ZNY2ZFWDFFTHNMeC9XQTVQY1V5aUpDdkZjcVhDNkVXK3lnSlFrcDFzci9h?=
 =?utf-8?B?L3FJdnBCdGhMZXM1Mkl6TUVQemt6THdwZDlMM1NQRnlPWnBUb0ZBYWJPVHdE?=
 =?utf-8?B?NGNIWDRxT0FpaWNOaWtnVlFDNWZKQlhQSEY5Sjg2WE5kSnR1alFhZGQ1TXdW?=
 =?utf-8?B?ZGZJTi9KVFM3UmQrSzhoaWNVbFZ0RXQwSUV4ZzZadHJ1VTBhejRjUFhlU0Q1?=
 =?utf-8?B?SFkvbXIzOVp5L01QeHBsSUJDb3V3TXJjVXdjS0tVL0tWYWM3eWxnenQ3amRM?=
 =?utf-8?B?RkVndGJDbE01djI0d0I2SWl4VXFXdWl3VmtOREdjUmVnQ0h1czFnZ1FNdW5J?=
 =?utf-8?B?OCtpangyVmRiYjJpeXdwVWJjcXcwMkFTLzBLMVN4RW1rWm9iY3U2dWh1VnU5?=
 =?utf-8?B?anViMHRJcW5PZ0tiU1VDYWNMd2pmeFZvYVd0SUxFdmNmOWcvdGJSUDg3aHBm?=
 =?utf-8?B?MDE5aHdubDlqdE84RkM0K3FlUjNtb0xOV3dubFpNOG9qN3hYa09VUXRYazV1?=
 =?utf-8?B?RWNzeTlxaWNaR25MVSt5RlNQOXdIcjZPcnhKSHZERTliYlFPMWRmT0I5OXd3?=
 =?utf-8?B?ckdROU1mM0liQ2JtQ0JTaE5Dby9zTE1jb3RWZ1BCakpPQ09NQU9OUWx6U3pR?=
 =?utf-8?B?ODAzaENZNVd4d0VVanIvZmdlUHJkeloxVFo3QWdHbm51MzhSbm0zRTZMcUE0?=
 =?utf-8?B?N0FXYlFoa2xGMFNYNjVyQnVRRVMxdUhnUmVzMzRPQlNHN2FoSHo3algwY2tJ?=
 =?utf-8?B?RWpmRk1ONmdMU0ZoQWZRczh4aFhCZ1FBcVdSNnlBaFJyd3A4MUtjWitCcWdm?=
 =?utf-8?B?cWpkd2t4aE53V2l3U3A0aEVWN2tjT1BWR1M3aU9JQlNyZmd5Z2gvMGJ2QUNp?=
 =?utf-8?B?VXQ1MEw2MDl1VXh1ZnM1K3Nzd0F2Z3JXQ0FHdkZpZjRrbXdyVU0zcHFHdjNv?=
 =?utf-8?B?Z25uOXI3Y0UvR3JQeU1kQlU0T2xRMzYwdzBmWkN1YmFZaVhLV2swS2pnNFc5?=
 =?utf-8?B?ODdNcXBsZXJuWTJYc2tEQkF3dFlONWtkTHZxU0Z4Sk52U3k2SHY3RFZlVnlC?=
 =?utf-8?B?OG9mM0UrdWRBWGxCTnZxTDFOc1hzdWV5MWRNemVnYlVieHZROTNEeFRHU0Jo?=
 =?utf-8?B?dW12WUtwaGJQUFpWM3lpdWV3UnlkNWk5cWI4eG9jN3pLSHJnbDhFTTlWWUZB?=
 =?utf-8?B?aHR4UEEzd3JXQmk2akcxT2wxMHlleW44c3ltN3RmWXBMRnM2NC9UUTdUV2Np?=
 =?utf-8?B?WlR3K3h2ZWcrZ3MyMWZvMWgrWnJQOHpoVDB3UjZ6dDV5NDFzR3VOanNRa2RP?=
 =?utf-8?B?dGZzM0FuaEhFdEdsSjJTUGhsTVZsT2M1QmI5cEEzaFY3ZmdaVU53ZTRjeUhs?=
 =?utf-8?B?T3E1L3RTK3NZV29ucE0yeHpSQ0JONWJObzhvK2VsQ0xkZFRUdXN4YVhIdXlS?=
 =?utf-8?B?SmM2THpyTEJMZEFScFlZd0p1a0dZZk9DQWJPOUFPRzZtNFFXU3Rad052aUNa?=
 =?utf-8?B?VnZLY3RaRTE5UzdVbS9aVi9SVmU5UU80WnExb3hBbEV1RUR0b3ZyOGRKZzQr?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d4d38e-5381-4dc2-c549-08dc9a7c6278
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:50:20.0528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvht59mr+mf+je6zjf/3vsM9Gb9/u4sSaI+kZpA0DlgpuVFxXRYu7lfa4CcLpgd95Smi/bgMK1dampfB7//t5qUQdpGxPtbXKtwAyTbM3Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8492
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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


On 27.06.2024 14:34, Fabio Estevam wrote:
> [You don't often get email from festevam@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu, Jun 27, 2024 at 8:31 AM Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/spi/soft_spi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
>> index 0fa14339bdc..3fe62818a44 100644
>> --- a/drivers/spi/soft_spi.c
>> +++ b/drivers/spi/soft_spi.c
>> @@ -272,7 +272,7 @@ static int soft_spi_probe(struct udevice *dev)
>>         ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
>>                                    GPIOD_IS_IN);
>>         if (ret)
>> -               ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
>> +               ret = gpio_request_by_name(dev, "miso-gpios", 0, &plat->miso,
> We should support the deprecated 'gpio-miso' property and the
> preferred 'miso-gpios' one.
>
> The same applies for  gpio-sck and gpio-mosi.

This is exactly what the patch did. Actually it just fix a miss-print.
Other properties already have a proper fallback.

>>                                            GPIOD_IS_IN);
>>         if (ret)
>>                 plat->flags |= SPI_MASTER_NO_RX;
>> --
>> 2.43.0
>>
