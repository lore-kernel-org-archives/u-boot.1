Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C4EC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C50885A4;
	Thu, 23 May 2024 16:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="g2r0r+u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2616D885BE; Thu, 23 May 2024 16:53:25 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4306D87F8C
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQQR3TZtVBKCLYa8Ue1dzyzNNd+4vaXm3nn9IKYlejCc5d4SkC4qndhJGk4jqgCRgE+vna3h/OuVZ4qfW7konDQIn78Mepq5rlDOuAkQcZYo91sLM/BXKswrxIWXb7vi4CiynBtLsOv8hDE/KYN2dZXDXTjHZPU4Z69XNSE1/bNkQYudZ5a/x779gYsMd33s/Y6kVcuvBBoVL0MBr7Trm7Yippt8kSxhKyPXlciSBjjLkqe0CIVxYKGYTAQ5wO4zzWB8iEZNrGZvrdQmNX98B+doRcWd+G/CaQSHZ+RO3ors+OXbMoGI3MLxbqEhb7Tc3ZYbSsTis4NYtF4Jf5RFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D1IpHyZhuJwXVLfOdH+yaEH7V93bGbMa4FeYzlDxvU=;
 b=PFTDEooyfysgvVLYa5alJyyDr7TciCfZjK6JeuSnSWEn+Q5QM21SSpPEbCQSs+5wAjZ+SZIg7oDb7xIGe80CFEhlFVMf3M3T3/b+hqo85bsmEvL8OLYckp56j7Z1QmOj8zJAtj2OIyyMQYRXxqvS8pqsaAl2AJ8zyYs1DoKaCiaNL0Hn4uMb8ZzmCDBn3DB352hgO78BcJ2bIaZVW3iGgIdHkmTihbsYpQrkL2gxb30M+5+UHIVHCh8f9Fp3199IJvyH2vYjbND45pdOJAt5LzagCZYUoZSdf3P/2jRzjKqMZMlparL54p31aj6pppHWiXFJ8GXCXt5q5mUWYGVpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D1IpHyZhuJwXVLfOdH+yaEH7V93bGbMa4FeYzlDxvU=;
 b=g2r0r+u5/eXlj8jA20SCwQE5e+683i4vYLMHtS5Vu8yvlSz8BW7w4PErouM7jPUHIv5F2ypR06rQHa6Ep3CR2WCBo4d6RwRkLtbjUyC/FKs8IjvJC5dFfssgljpeFRXqEklBsCdyCvX0MbpJv3hDocOVOiJNbtwkxnLPGsSw5DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VI2PR04MB11025.eurprd04.prod.outlook.com (2603:10a6:800:277::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:53:19 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:53:19 +0000
Message-ID: <7b381bc7-dd0c-437e-b774-0861c86d5625@cherry.de>
Date: Thu, 23 May 2024 16:53:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/42] mmc: dw_mmc: Extract DMA transfer handling code
 into a separate routine
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-9-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-9-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VI2PR04MB11025:EE_
X-MS-Office365-Filtering-Correlation-Id: b6325e32-3f8f-4b4b-a0fd-08dc7b381602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWFpZlYxLzRYcUZ0ei8vYzY2eDVPSTV0K1h0WGZOTmFVWVBqVC9uN1V4ejhB?=
 =?utf-8?B?YU42ZnhrWmQzK1RzdDIrYUNtallOcXFnQWthbTg5R0xmb1YyVVRqUDFYTXdj?=
 =?utf-8?B?b2Z6a1VpM0YxVG1IbzJFUkFLWlJ6TGJnRFBMZDFuZzk5aFdLSHpTNGpNc09I?=
 =?utf-8?B?UTFJQnV5bWY5MDJuUFJTL3VVeEFmZ0tNaHA0NmE3VG5WRnkwTit4a0FlWVJL?=
 =?utf-8?B?cWdRVkFYQ3g3Q0JaVm1iK3JOSTBpWXdLOGhGRXpIZ0dobUNJcGlOWkJPdzJO?=
 =?utf-8?B?aElNRmwzMVJ0c2hmVkhudFhSSThiRWtiZWNkYXhKc3RFQTduVGU0am1JL25L?=
 =?utf-8?B?ai83RTN6M2NwbWZRZHpoSjl3WE9wTTk3d0ZXTGczUzFvYzNjZGlFRHkrRlVr?=
 =?utf-8?B?VmxUSzF5VFlvSll1aERJb01vd0pySWQxNkxXN0d0akhZMUhDWFV4SDVXM2xN?=
 =?utf-8?B?a0VFNC8xMTRiY0pYOHdNdUVPVVVDeFRFbTZQVzVSS3liQVBtWVI3WER2aEIz?=
 =?utf-8?B?elFwTFZpRGp6dVZ2YVdWc2xrRWczejJzRU1xZjFBbWRDNHh2S3hzM2I5c3Fp?=
 =?utf-8?B?MXI1T2JZWjFJODZxOUdrU1ZUMnZhZkZ1V2duM1ZXQXY1UTVjK1JRM1JKZjhO?=
 =?utf-8?B?YTRkcWFFZUE3U0pkaTJuaHd1Snl1ZlRwMENocHVJWHFDRFMvNEhQTjRmR1FV?=
 =?utf-8?B?WlEyNnhpbGVpbGJ0SmpyTldvclYvZ2lMOFBuN3R5YXhja3dpeEpxOFV5WGJo?=
 =?utf-8?B?RkpCTENxQ0J1QVBIdExydGpKWlNlUDZoSEVQaEI2RnB3ZW83b2l5a1RvTmJJ?=
 =?utf-8?B?a0RLK1RVL0NrelhpcW5FM3o2c3RDOENLOGczZkNyMkttYi9yczZiV05zUmZk?=
 =?utf-8?B?RitUOW54bFpnVk15TjNpazIxKzh0SklSWDJCQy9oTVlDNTVkUFhSb0FYOC9T?=
 =?utf-8?B?cGlWcDFsNlNXYzVaMkxIbVJ6ZzNKRUZVYnRNWWtJbWxvdVZDSHlaL1R5aStW?=
 =?utf-8?B?a0JYTmZKdXRPdSs4Y0xnQXg3S2s1TkxmZUtERUhSUzVvMnp4ZkZHcXR6OTNh?=
 =?utf-8?B?SUlZUHdGb29jb2lIWFNTKzFWL2RXaFVlbDhtbDVERVVpNk5YS21MUXZXQ2E1?=
 =?utf-8?B?Z3dmN0p6cmRLM1dMYkZSbWtaMG4yNU5tZmhnZFdHQVd5VkpXNlkrRE1xU2VK?=
 =?utf-8?B?dTlaL3hNdVRKQkw0Mzc3OG9YQ1N2eThSWmZZbS9WN2RYanNOKzl4Tm9zM0JB?=
 =?utf-8?B?ZDJlUi9jQ3VIaHR5c04zQkF2clBNY1ZxbVc0eXZUUzhZSDZZVEZoOE5uaisw?=
 =?utf-8?B?aVlNVUpMRzRFOW1zOEhCMFAvaGVHZW9jY1JMNXRERG1oblIrL3Y4WFk1aVg2?=
 =?utf-8?B?eUdHUVlpbGk2OEJOZmJIaHJtRVhDSExFWHhDdThKd3o1d3cxanlsbDkwdFNj?=
 =?utf-8?B?SzIrWmM5VGFDYjhHSnRBN01CVFBVZGF2SFJLdkkvZ0ZEME1iUUhxNzRkRWFw?=
 =?utf-8?B?OHNiQm9GS1BOL1puNVZSSVVESTA5Um1menU1bnNjWlMwRjk5M3YyVHc0OVZy?=
 =?utf-8?B?eGNxNUJabU5XRXNUSTdGRFNNQS9sOWF4QUJnUmpUMEhkQXV1MlQzdU5sVGJ3?=
 =?utf-8?B?UVJGTStocmFRU0Q2MFhHMUJEaENRYUt0bE94NVY4dTc2ek1RNUQwdFhhN0c4?=
 =?utf-8?B?eS9zUk5qbXR0aEY4R2ZESGRtbHNEd3cyYXE0VEh4SVpJaUhqTzRXTjRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxQZEJoYjM1TDRhQ1QzY0U3QU5oeitmSEkzcUhQWTRSYnhra1pKOEU5ZXJl?=
 =?utf-8?B?UDhScDhQdjlDYXBXT29nZ291OGI2V2dmVHdsRG8yRDQ2NW5XQ1Y3b042bEdz?=
 =?utf-8?B?a09HTmYyeDNjQmhTZXJQdkFSVWMzNkhiYWMwQWkxTjZzdy9rK215Smx2bE1T?=
 =?utf-8?B?TmdTaDFyVDhjN1pOYVQ4K2ZIalQwV1dkNDB2WGEzbFFQcDA1Ykc5blVKSGs2?=
 =?utf-8?B?T0FqeUZFV010ZlczRHF6V2xhOUVSRUhEcC9LdTNHVEQ4M3dhbFFBdk5lSWFS?=
 =?utf-8?B?cW5wUHhrLzR3RjRUOHFjVW1jcVVOeE1qM29iSHFYTWhva282dS9oUWwwK2M4?=
 =?utf-8?B?aW8vOEkyMEN2a3RXbUNpR0lrVC8zSnlobzk0NWVONzdJZ3hZeFpnWXQ1aklT?=
 =?utf-8?B?U3RhRWdFVnRZMTVxRzhtSm0yRExRMmFrU29CYkNiTTRWOEVHbFlDMmtyNnZ4?=
 =?utf-8?B?SkdwVDFERTBhZDloRUZyWkEraExzSlNpUlRPOFhJdGZqbXFVSm9pWHZsMk5R?=
 =?utf-8?B?ZTBiT3hQZERCT1lXZU9pS2tiTGwyWnlRa29xYm9pZFZoWDY2bXp2NFFXd1JM?=
 =?utf-8?B?SnhtaGNqTlFZMndCWUxvMy9oNmN4WWtaN2dmOGNyUVJ5S2ZxVUFUWU9ENzI5?=
 =?utf-8?B?b3J0WVpsRVA3Q0JZblREcm9Mdi91cmlZSlNkTGdqdmRPQ3Y1cUovSjBjRXJ2?=
 =?utf-8?B?ckQyOHBtR0xNd3kzVkF1RUFCUUlwUDdLRG91ZGtYUlRYOFN4R21pUTBtTzY5?=
 =?utf-8?B?Wmc4ZUNGOTN6b014am1ZZnpxMXlxY2dacXRwOE84eUI3TjVWb2xVYXczeG1G?=
 =?utf-8?B?N3BpQ1B1SkZwbWJaK1p5am5XdzlCVCtGRW95QjhLcTN0RU52ZXVhWk1TTTVS?=
 =?utf-8?B?eFZZWmdjOUwvcTdQY0ZadCtON2FzcS9YYzhnYW5BSmNDT0RkTnVBNUtUbjdN?=
 =?utf-8?B?di9qNUUra3Q3eENzcFpvSm9KbkFndUgySUQ1MGtTaUE2NjJXTjBrQW1aeW1H?=
 =?utf-8?B?bGtJbHFXdm9kT24wRU1kZnhQUjJNWEJTVGRrL2ZLZUh1R013Vmo4eUJkQXp2?=
 =?utf-8?B?QkZQbTBxS2c0Y3ZUc1FFcGo3YTk4d1BheGZrS1VqVEtrc1NLV2RoVjRkalVU?=
 =?utf-8?B?NFViRmxxTHdhaGE3VzZUMHRPYTJqVmxiUk1NejZkSzVibmZIU0pjb3dIZEFM?=
 =?utf-8?B?ZVM1cjdVdTFwNjF2MEc0RDBhcEZyTGN5MmZmRmc4QVNZVTVHV3dzS1ZoWXFC?=
 =?utf-8?B?UjhMMjZJZlNuZDIwYXU1NGJiNWJ4Y2dpdUZOWTRCcW5qa2xtRmxLTXV2QkhV?=
 =?utf-8?B?andBcjZ5Zzl6cEFzSlNnbHFyeDRmNk1GczV1bEVpK2pwZ3hwU2k0SGVxd08w?=
 =?utf-8?B?ZVd5QmFQblNCVzFRZ293UWVaTDRhcE9oQVFIRFJ5TG1vR1krSDF3dlJoNVZ6?=
 =?utf-8?B?TWcvZGIyY3NJcHNqWm8wclNJaEJtR2h3azVWMFkrdUE3SDQ2bkdFdjRGVm5W?=
 =?utf-8?B?ZG9OYTViYXBEK0Y0MXFiTXlEaVAwNE90eVpDR3c2clBBMGxVQnZEMThsYW1u?=
 =?utf-8?B?UGo3STdOQWlJaXMwUlhvZG10Nkl2QVEwSy9JeXBiY1N6WmhUWDg2ZGYwSHh4?=
 =?utf-8?B?OXdnNklCL0kxY3AwVHd5MkNmeHprOWJmcm9VS0E5dkQ2bUR0V09nclc0aS82?=
 =?utf-8?B?YWIzcXljcWIyN0hKUjRjYkVSVHlrQ1pubG5RWExJbDh1amloVjRmSkE0SXJy?=
 =?utf-8?B?d3E5aVdzQ0pYbHRwdXdBeDJyY2VZK2dXMnE0Rkd6YURXTDZvWEx1RUF1bGtG?=
 =?utf-8?B?YXVRN3hLcmVlUnhlWDlMd3NETjgzU1FMZUlPR25EaHZMM2pkSVhZZGxzOXJi?=
 =?utf-8?B?YzlPWS9LWnFjbWZmcjIwOWQyY1ZFOWUxZC9qaHVOV0hXNzMxS0IyLytLSTlr?=
 =?utf-8?B?VjZmc3crMkhDRmc3ZjlWT3B4U0N4bVhNbnRwZjJKRmUxRXh0TVB6RFVvY3ZB?=
 =?utf-8?B?N0diMzZwUzh0RWk0ZElEWW9qclllb2FqbkZ2U2dFRFlGeHBjckRBWjJUSzJm?=
 =?utf-8?B?WDhDZzNEdGhsMGIvWHZaT2tPNEh6NkJiUStrMnFaZHI0RkpVc3NnSUlvdEE2?=
 =?utf-8?B?VjhvWjVHbytwdjczQThsYjJleWtzcUZQWU50UmFHNEtocEw1Y2pmV043NHlB?=
 =?utf-8?Q?V+ugDzLZik5oWqMve5m28os=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b6325e32-3f8f-4b4b-a0fd-08dc7b381602
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:53:19.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvMs4JNbVWD2SlHHerBGk44TxSXuCs8/YjwkifZG+ylsAhkF6ufdXwjCcUUkS/zLcjcrWmEcSk7Kqt5O32pJunoebEMI4duC7iuszV943lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11025
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

Hi Sam,

On 5/23/24 1:31 AM, Sam Protsenko wrote:
> Make dwmci_send_cmd() easier to read by moving the DMA transfer handling
> code into a dedicated function.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
