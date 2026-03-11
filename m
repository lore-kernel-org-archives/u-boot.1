Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C170FD064E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 07:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6669783F93;
	Wed, 11 Mar 2026 08:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TMOEk8l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2155683F9A; Wed, 11 Mar 2026 08:42:36 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFAAD83F6D
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 08:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7aFErc493fGLZPL/uvziG2Kc0eMtMlze+1WsfLKCm+BudrOF7E8p+CNhCAJmXjc7XZZ5S57OVH3bUXnOVyexLhac36HGu12HeJ22Y8o2WyX2HBZjdR4/QGYq7CqFUbZydIp+eCUhtQA2xC0HRiHxavPEM7OYW/TRUi3b8BDiZMWlLW9F0G5G0epWXh/FeS7siiwaxPbQHHUuz0aPPDeGw8vn4c/NaY3yvtRXH6iZ3YwEZqASdo473EbCP2qi/0d0/YGyUZqqCil8nUAj5+u6lblYWxuA6tb+MIitBUeP2+M3FxOXaylvZf0P5PmUg6UfjyeCpLMzzHIVgYYhGHWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCKYoqeNleNiiCJ+R/6AYzDj/0heLxtLTKTGmPX7JXk=;
 b=xQDZ3TwUhFbLzyqka509ijI/+gAtdO1f0msIpB7UFwTk+W6G2imi3waK6HSVmq3JGSELlfedLvM3SgJaVWmrJVGM3+6fMpsGz3hwjDHvvNYTrDcN93j8nDCWCI28zcZsrYxa24D09NlisBszRoRXHRacPdI6CvI+GhhH7+ZgsZwAZxIR8ZYD3w2NJ9WnqDarIzwwh5q+LElmIQmfj2bzmR5uOzsFIGAGwosaJDUdSb8wcxAHMiq0Bs/wu/o17QMlOmCUh4Hd1LWU4ZuTdZm+LUN13Oe7UfKTrXjv8Zf3ihrxCm1pJfn25hRLp0DMRnzUt2ku+Qn/OYzEuaTFGvii/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCKYoqeNleNiiCJ+R/6AYzDj/0heLxtLTKTGmPX7JXk=;
 b=TMOEk8l2yKhPqvrPfx0D8Oj+e/rvCWP1r0ZA6PpUWNtKq9kIqjNtPVuOX65/bnngfNG08CfZ0eSTNBd/RF83LN3SvZ72foEKptAkfy0x6rrObeVJXcQqHA5+ZakllZkL8zWvRIHRIcb2fZssvMwOFmVHD9WXechkpoiwB62lJy4vfGcEH9AmUkmgfWl4rIDzMsx7qiprJ/GIYD9kIJkpoA8z7ipu4yjpk0xdjLE4A/VzZ8UgkhSOyKrLlnoV0lB/59AInLQYhsYCQtFbC5Fmc5Bd+c/5fzCZodZvsXyDjczS/X71mw/LyqO24JYqViWY7rXNTncLFlwIr4GzVSFGyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM0PR04MB7185.eurprd04.prod.outlook.com (2603:10a6:208:19d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 07:42:26 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 07:42:26 +0000
Date: Wed, 11 Mar 2026 09:54:23 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, peng.fan@nxp.com, alice.guo@nxp.com,
 ye.li@nxp.com, 
 simona.toaca@nxp.com, viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, 
 ji.luo@nxp.com, semen.protsenko@linaro.org, sjg@chromium.org, 
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Message-ID: <osdr4utlrns6lbmyemfjyicnomydqfnvskrbuy2ekhlfj2hvwy@44o4m2qh7zg7>
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
 <CAOMZO5BRMVV=NW8Si2fEK0P5BmWHiPJb9zWqT+v7hES7U5Xu8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BRMVV=NW8Si2fEK0P5BmWHiPJb9zWqT+v7hES7U5Xu8A@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM0PR04MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a6ac33-9298-40b2-aea7-08de7f41bd5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o7wvvlAhM8KaaKNvRX0gFsByTwj6HHhd9594JA8alIF5zLPJgD0dcNPAssZrZRkTNjLXGHY0WnvB+28xsAxt3/vRJSKQ5zj3iMT/FM7O5k+vPj3Q3apo5XUL+oR59BQvaorxrZeZaAyXChaQSgLZq6TyQLDwi/ZshzxYCmyH61FrK3nsYZ9D2M4RkR4kHYgas8TLg2eJEY17qRCJ2fhZlRjCeHh7HvwmlfX4lbAj3V3akFVxf/b+o9ipvCOoLTflkYhblx1xYAzn5k9h3ofIcjwAPyrPgkO14e8qVsF46Ks1jF/KPKXvBGUyYadD8Rnj+xCVc5spukFMAzdNZu26S1fE40L5SymOUOcpqtW2u0sKUJeIt94pX27b2NBJnAn/+b5eHdNbKtYCxtFZbiUEzrw7176VUnA9G8zn77PnKker24XSyfh5lJka+JN7zaCZN81Eulth1vU/pDkTmNJw2XpPJ2MZEL4Lvfer53GfB2VIXVLnKjtLTTQECQfepGMZ7oe3NjAkH4h814nvZZ+bEfro0U1HejjKnXGtXNBaWAa2khOWVL+uEr8PT3/trBgZLZPLbO6pRGXwgavrKABdpTTuAn7+G+4Djjdnz9NlG7hhto1eGamaEyPuZ8E7A7iT/OkqER+5GufIJ+2A6STyq0ktCnpbKBq7obDHp5hxvoXRO+Wr2Pc4XZ4leax+Sm9GpUgmOpnF1o1gYwuAssrgwD2g68WP6aTehf9YXEAB4bI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9BWWFWMFFYSFBRbUhBUnhLSEF5RXZIYWpObi94Y1U1SG85QW9VVWE4ZGZO?=
 =?utf-8?B?QTBZNmtMQTlPbTQwU3NYQnpLbG0zYWtZS1dkakhuNkkrNEl5N3VBZUxRY2Nr?=
 =?utf-8?B?UlBlSXpibyttTDJiL0VqTDNlNHRMbTc5Y2Q3cG0wRXZ1WlVvNHFDNFgxK2xo?=
 =?utf-8?B?NEZTV0R6a2lCWUxGNzBKSFU1NHdvdmRINHZpVUVtU3ZUSHVPaXByclNkWUEx?=
 =?utf-8?B?VlFwVlcvNGVuTWFQTHdoMHBzL0Y4aXljbTZMUWhwSTBhRzd5TkhCUWJzeWZK?=
 =?utf-8?B?a3k1aS9BTC8rNE5PSk1JWWJiZllCZituRm9RRzFxY1ZxaFhkbGVnU1NTM0FO?=
 =?utf-8?B?UDIrS2tuTkRjek1PV3JIRmVRSjBhMkVwOHFsVWJuT1duVkR0aW9vQ1FhOVpq?=
 =?utf-8?B?SXFReGtKdlJHUTdFb1hPL0F1cWNRbjRFaHlDNFY5a0RXQnFSVUlLSklkY0Q1?=
 =?utf-8?B?NkVqQk1CMWdldlJmKzFnSnVJZ1NObDZkRVcva1VSMmhFcGNkNVJ1NThpR3M0?=
 =?utf-8?B?RllrS0s4aVhtamVhMk1HT1B5VnJ4VXVhYzh5Vk01MTBYKzI2OGxSV2R3d2o0?=
 =?utf-8?B?Q2U4Rm5YS3lmMHUzaFk5bFBZYjZadVZwNUpGVjRuQitkZmh3R2tzSjVyMitn?=
 =?utf-8?B?cHZpZTY5SUVPaUF5cnJmTnN1bDVjazdSekROb3FaZ3JNRDE0TW5oekxRaUs1?=
 =?utf-8?B?VG9UVE4vckJDL2VLN2I2UlM0MmxwcEZqcnI3bzdnU2dtdS9PMDFvckRQWDRn?=
 =?utf-8?B?cEtlRktxQy95WG85THdyVFVCV0RWQ2l1MWUwRU9xZHNWK21yR0xWNWJ2aUgx?=
 =?utf-8?B?V09YY1JGNEVxMTJyRFN4TXVHVEVJYm8rQUVMOTl5eWYyNDdYRXhXSHhlaDhx?=
 =?utf-8?B?RTBZd0dPZTVWY0V5VmJZOCsvS2hYQzRJWW9qUTR1QVV1N0Y4UGxlSzhGMzJW?=
 =?utf-8?B?QXNwUFZLMkh4TFVTZFJacXVwUWw3YlBjYXAxbTdoMHdHc3I1ZkM1RStHLzh5?=
 =?utf-8?B?WE1kWDVidTNwNXJxOFRsamVxcmFUMG11SmVFVnJaY0xNTDBKSHg4cFNBd2xr?=
 =?utf-8?B?M0RGd1AzUlBka0l1ZTROR042TGNadUliSUFjeUZYcmRqeGRGMS94eWNjaGdv?=
 =?utf-8?B?U3ZYaTRmTWVPaFloYWMzTTV3bXU1ZDVhMW4xMzNZQVI4cVAzSktqR0E3T3hW?=
 =?utf-8?B?ZkRVSEpEU0d6dWxyNTFIOXdGV0wrNVYzWHU4K0FqTUJrdWFDS1ErZE9PQTBQ?=
 =?utf-8?B?VHVOWFNIeWgvd3d3aGNPbHk0YWpYRFNDMEwxOWFyM1F3cWNSUVc4UXluVVY0?=
 =?utf-8?B?RFNkbTBIYzdaeng0c3kybXdmTkZ0dWFzT3YwTEZhMlFFU0FTRkNwQWtRN0po?=
 =?utf-8?B?OFpLU01ON3ZyUE1Ec0lKVnRadUpqdFFBU095aFBnZTBEU2FDZXVsYzRJQmU4?=
 =?utf-8?B?ZXJzMkFNWlVJb3hqbG9sc2QwdFplVHhWb2pITnB0QTVQS1dLQ3dPdG4zZkor?=
 =?utf-8?B?aVNUUVNKdlR1QTdxZVF5L01QRVBxK1prLzIrZXRuTU9xUGdyLytHQ0k3QytG?=
 =?utf-8?B?c1E5VlhXbEEva2FNRklWeEtVYXZjcTBjdys3enFkVzNsK0EvSVRpU3Z4N0RN?=
 =?utf-8?B?cVZDVkl2dUNSUEl4S0pPdU5hVjNhVEpFTzhBRTBxUnVPK0J1RkdJMGgwUDVr?=
 =?utf-8?B?clAxdVJCVWtWUzFTWEJwdlZHS2V3RXF5OER0SHJWV3JJTzB6MXY0ZzE1L3dn?=
 =?utf-8?B?WDI4SkdFWnZ4aWFidEZqQTNHMXN5ZXdWOXVxQXM4YkltSGcvSFE2b1pWMUhY?=
 =?utf-8?B?L1FQVVBTbzFvd2hDRnlwUUNqRjRaczYxYjl6cHIzZWlLSjdBVXh6cVBmSlgy?=
 =?utf-8?B?dGhTMFd4K3JaN2U2VndMblNleFBTRWQwaVN6aHZXVEpCcklCMWtJVE95ZVh2?=
 =?utf-8?B?dlRPSkNCKzcxN0hsRlJSd0s5SUNtZFpQSlRvZk1aTjZXRjEveGswd00wYkJr?=
 =?utf-8?B?eVNZYmp6V2xsZGdaaE1OekhKRlZQOXozTWlpT0JwSytIZThLWExibGhXOEwx?=
 =?utf-8?B?UGxiU2RmRHU2L0JvdkE5cTJBcmVBSjVZditmc1ZOT3lFaTgrRjdVckF3S2ZW?=
 =?utf-8?B?a25rK1VkTjFIYXpPV21LTFpmTHBiblJzVFJyTDVEUDkrY2l6bGNNcTVQMzVn?=
 =?utf-8?B?NEU3QlVrWW1sMTh0cHpxRS9oVEtFSnVxeVlqQWxTZVJFOW12M1F0REFRMXo3?=
 =?utf-8?B?WGkwRU9JcGhzV3Q2Q2htRHB2dkg2ZmtGNThBeDBSVEdIcDhWNFlabUo2K2lL?=
 =?utf-8?B?ZU9MTDg0emYvMnlGQzQzbTR2NlZaM0hFWnRrcWlIUHFSQ295NkVBZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a6ac33-9298-40b2-aea7-08de7f41bd5d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 07:42:26.3155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpp8N18eBvEN1rjTY9esqpjk8Hk2pwFwjCwo25KPJIa5njvot36o3Jrlzr2bR2oEgS3NRgCG9F0xNCwu9p/UOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7185
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

Hi Fabio,

Thank you for the review, I will fix these issues in
the next version.

Best regards,
Simona

On Tue, Mar 10, 2026 at 01:12:28PM -0300, Fabio Estevam wrote:
> On Tue, Mar 10, 2026 at 8:44 AM Simona Toaca (OSS)
> <simona.toaca@oss.nxp.com> wrote:
> >
> > From: Simona Toaca <simona.toaca@nxp.com>
> >
> > Call qb save automatically in the board-specific
> > spl_board_init(), if SPL_QB option is enabled. This
> > makes sure qb_save is called before any image loading
> > is done by the SPL.
> 
> Why do we need this? What does "QB" mean?
> 
> Please improve the commit message by providing more context and an
> explanation of what you want to achieve.
> 
> > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> > ---
> >  arch/arm/include/asm/mach-imx/qb.h | 2 ++
> >  arch/arm/mach-imx/Kconfig          | 7 +++++++
> >  arch/arm/mach-imx/imx9/Makefile    | 4 +++-
> >  arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
> >  board/nxp/imx94_evk/spl.c          | 6 +++++-
> >  board/nxp/imx95_evk/spl.c          | 6 +++++-
> >  6 files changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
> > index 5efe68f0a60..4f923d79e7a 100644
> > --- a/arch/arm/include/asm/mach-imx/qb.h
> > +++ b/arch/arm/include/asm/mach-imx/qb.h
> > @@ -10,4 +10,6 @@
> >
> >  bool qb_check(void);
> >  int  qb(int qb_dev, int qb_bootdev, bool save);
> > +void spl_qb_save(void);
> > +
> >  #endif
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 17aad696648..069b25c6241 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -71,6 +71,13 @@ config CSF_SIZE
> >           Define the maximum size for Command Sequence File (CSF) binary
> >           this information is used to define the image boot data.
> >
> > +config SPL_IMX_QB
> > +       bool "Run qb save during SPL"
> 
> What does "qb save" mean? Please explain here and in the commit message.
> 
> How does a user know if "qb save" should run in SPL or not?
> 
> > +       default n
> 
> No need to pass "default n". Drop it.
> 
> > +void spl_qb_save(void)
> > +{
> > +       int dev = spl_boot_device();
> > +
> > +       /** Save QB data on current boot device */
> 
> Please use a single /* instead of /**
