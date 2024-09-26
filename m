Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA4CCFA10
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C3788CFC;
	Thu, 26 Sep 2024 04:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="k7ACuzJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F2C88363; Thu, 26 Sep 2024 02:35:43 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11olkn20825.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c16::825])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BDF6881A2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 02:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfcddVBEbTXVtKykpkujn1ZLJde4PmEUknu9mjTkHGQxegopuCle537NIWuTpaJLyQh7JZ5q9MMXQvjf0X+uITREN+nM2rOdUoVnrldSnx4iVCpQ1GEQ9m+8PzRWhGoJ8AIrZpn8B4JiOjFy/Ys0huRPmAiOkaAX3MXiKFLS1lVEe+jSgCxwDyiFnPu/jGaMBzS2aR7OPnhOtoWkhwqGTQTl762qV/paO1TE0riHY4y9vI6WtvxpocWQ/vLRECtvEB5vxjbajsfihJnwAbXYYzzoN+S94QVZ/lvFvXffc71A7ykJloWP0FWhF3d+XW0bTHsVtlg/QhbdiCGIjNezLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkGWa9Oser5e5m0cSpSM3ntNDRSK/nBrDd6OFERzSek=;
 b=Kq/+/K/wHJpNcm6KAqo9zy+TkFjjhh21baDyP7jmb0cMqsPiHjysl8TiSBNDnsnN3i4jxKI2eI0k66Ei5fY8Oh5rbnRWJ8MMzsJ+ptfR44D6v8XEtsbGK6dweGzWRdBcMhayLDOM5f3SWphR/E2dPvI0iMk9p1Aa4tMa+LqaIFxzX71S3SIcUfPdjowa4rrvgBISTFOgiZ3pLXXMUzNzRLIKX8QBovWyzlUpzmzmXTwE2U2snmYeNqYEqf1vOrjOUSxMVspncTBVOLKTNWPUUqA6Y09I6tOYZ7PSupjdEiN7MffnTEVSESqACyBZhwam8FW2G+tTGdgNWsVvv6y+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkGWa9Oser5e5m0cSpSM3ntNDRSK/nBrDd6OFERzSek=;
 b=k7ACuzJEsRQTSnnBQe6MRkLz+OXKCuXoLwcpMuRCvtGxYeoN74Mer3PzMPet6r2TOmrBkXsbdgrTb55XgDgPok+9rgBweoy3mrhsde5MjDKHn/2raa3tskMgyJjvnSrutfHqN5FN4WvLdiL5NZH81izOqy6v/9mIdBtM5ya8yubnNyzrJt0+bnJKIA+7RcMYAkvF1pkxd5/QK/pJkfxgUJemrUQTqKv1TIdcDgmYD2BqGkJYZ2ML7ytfChAA2NSwxWLz2l0r3pghdl5WzbJE8XGKyEykQ2si2V8pgpTNMrXXmO1QRoD6hTXONCwZDlECxSLllW1tzkXqZqELnZ7YYA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by CH0PR16MB5273.namprd16.prod.outlook.com (2603:10b6:610:193::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 00:35:32 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 00:35:32 +0000
Date: Wed, 25 Sep 2024 19:35:26 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
Subject: Re: [PATCH V2 2/4] board: rockchip: Add vdd_cpu reg fixup for RGXX3
 Series
Message-ID: <MN2PR16MB294187E6BC10830B40BC9597A56A2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-3-macroalpha82@gmail.com>
 <2a207719-e37c-4289-9470-2324928e24bc@cherry.de>
 <MN2PR16MB2941DA215E7CDBFD7E3AF730A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
 <3b41755b-bc5b-4729-9f6d-5229634e8a70@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b41755b-bc5b-4729-9f6d-5229634e8a70@cherry.de>
X-ClientProxiedBy: SA0PR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:806:d2::33) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZvSsTid+lYSAIjjb@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|CH0PR16MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: b5959cf3-e1d3-4042-6bc5-08dcddc320bd
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|6090799003|461199028|8060799006|5072599009|7092599003|19110799003|56899033|4302099013|440099028|3412199025|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6KMNacbSAvIXXLYcbJZgztreb6rkd2II/EqDnXMfLfLlv4Sscsr4sf5ikvwH?=
 =?us-ascii?Q?iOl4MH7ucWlyvcWDnWnrSlfor95sSfO3abmECd9Z2yXgT1YwSzshPUbk3h2X?=
 =?us-ascii?Q?AGJUXmJcPQpLnzji4hcQCZxHQFfqAinL+yx/rtiqciLO4mMMI7GqdfSz9Ph+?=
 =?us-ascii?Q?S1SGyE3PnWqrx2jvW1nHQ93AeCjlCZHOlK7pcTNpNdE+E3F0Lv/q/H9vekIY?=
 =?us-ascii?Q?Dglq29OyalnJ6gAbT+/1XyNI6II6Xc/MeAOaSATBTU4u1KvQsBt4d9oux70Y?=
 =?us-ascii?Q?WscGgne2V6MBS+gooTuGM4vMb5T6CscS82l7whzyQ2hrynSwS8eMpy502fLP?=
 =?us-ascii?Q?NXBNaJhtQ7UvUE+J/oatWnJvTbfpJCcMKf1L7wzXFTrqDcriUACPvkgoLP1K?=
 =?us-ascii?Q?XIUmQPJQkS8DVnLJWCppnIyiXxlhhBKr9ilkGgKOQiKofnp56ZA63jbpBZds?=
 =?us-ascii?Q?u23B0SzFsyKU86ZVr2wWUmPIKWq4g2TL/P9yIqcZdJNBGRuXeOVL/cavM5Dl?=
 =?us-ascii?Q?OrupQFqJciANitGm/V0u6ICixfqFArkjeVzS61zxS4n90RmPCVZhFU7fMbtx?=
 =?us-ascii?Q?KaGQj/g2B1Pd24MlG54GacBVHd8Fn+YF6ur0zj7dzHIRrFVR7B29Jvu+T5Ur?=
 =?us-ascii?Q?JwiRaxRTqauDt/1x9U657a/Vcq4gGwin8U9lFvPZzEIvz3+ZE6gmFnR+FAQN?=
 =?us-ascii?Q?z4i+b7mzYVod+DhWOTYCXYw0sQt2r1E7/7VXjYtG6rIO7sMO7qgsAtJAIrBX?=
 =?us-ascii?Q?cNN6IeEWF3Nnf0jmB0N9Q6ALUKRVmndqpUAxTsHZIlItqwR4lriCPh/RmGoc?=
 =?us-ascii?Q?UVLgUfB9iegbG7zOu49vRui523y+VrUELCyk2aEMB+ZKl2pC/Uq6O7ZEE1uw?=
 =?us-ascii?Q?+7ZjBjqTwriukl1IOV88mvkdafv/IIkpNyGF7ESg7CQBRFq4X24mSdhJxYfm?=
 =?us-ascii?Q?8qEbQtoLnZwYPhjOz9uwcw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2a3C7YlYGoK/hTJKp7fmaOyQ0tHk0/iD6I2l2OLxsP9tgjAK0dRs9zocDcuQ?=
 =?us-ascii?Q?PZDA4RXbTFH7Lk/5F0M+EHZLbZ7X9ilA9eMRUCZRWeORIbk7WQt5pZHi7t5A?=
 =?us-ascii?Q?H0BYztSLo82prW74FkqkxOCN37ykLMwb632gq01W01D1LZnz5MdIvvFwcd2o?=
 =?us-ascii?Q?9hgAhZE7efiVmYG3lzYXedsTBbl1AVonVZbi6rm0+VUVZFfSD7UHpf7d/qQR?=
 =?us-ascii?Q?I+a+JibodK4xuY20xW4Hn1DUbPSjdyvUjtBfkaEloZlhfShRH/9RVOI1bmgW?=
 =?us-ascii?Q?xQtdx7o8jKS3wQ37ygNJVRnsESPhmd72UusWU+1I2QX4a59TB5YCo2lXiN+P?=
 =?us-ascii?Q?kgr8vvS1DUSN42beY2Xp9qVHQZd+4I66D3j0hyhmejnscWQTq6ekpVyV8vaE?=
 =?us-ascii?Q?pprVLXNVN5flLT49JvGQ65UyS8nkf3iEq8RfX9phUOjOrP9c7iLKd0M7pMRw?=
 =?us-ascii?Q?nwkuSdLNCNWKnkvtHOJH2D0g8e2Y/+m+MXwtCkhHZ7M3TvWOF1YpSC/Iu1FE?=
 =?us-ascii?Q?7XmLELM5KWLruzxpJfynhldkJnJCC02/js37slA6+2nwTP92GR3A00z1Qt4P?=
 =?us-ascii?Q?zVHUMItk9euXOJZp5J/VjwFiUubs4cL6FIgAiA+o7Ohu4KdRk9qLjDZF7+0G?=
 =?us-ascii?Q?y6pDxQQcI128BCKY1mbf0nZr8IQ9z84JJIeKXjmALbnxOER2l3A+lz7yQMMl?=
 =?us-ascii?Q?OQ/UAkIa7zG6PaxUWXhu7CfYAiCClTfna1I/cYiQNQvZMQhGJII/MSLWNDBi?=
 =?us-ascii?Q?n+YP5iVH+zHZdtLFHMHos6DIWAbG5vcYKQXhJLF9z+gi0vPyFokyneDO3dL7?=
 =?us-ascii?Q?M16FjiTn9kmASSBGfzwxCh7Np3Ak3lKA4S5Mw5MLt4V/nIl599UJ9L4+WhIN?=
 =?us-ascii?Q?GB6nvmq2M7/XdN/isc0mpDkkiIIlwcd2vfXPsziaC6C8F4PWXEaRJEZJttiD?=
 =?us-ascii?Q?g7IjIYrHO//jhkM+3m2+DzaleXVbJ5vXQIc4slIS/NvGiiguD3KO/h8XgQv+?=
 =?us-ascii?Q?dMjsfNR+qW6BIk90P5uot8bD5iF666EIJDZfnPupyUt3PGPdF+NVhDzs8uFG?=
 =?us-ascii?Q?3LGp1YAJjQTBabdYU3iUGxcn/68RODrxFIXKLMxCrn2tO4SreLU5iiUhjPSc?=
 =?us-ascii?Q?SNSZmfGr973Hi8z8h2OV7XxXg1Ewutispg9JJJ6c9VyTZtaN+awpnem8E4oh?=
 =?us-ascii?Q?/VCHhL+kSFPgH0PCxjgJa6MzGxD3pfsGGFs+j9JrrXB3EGUUPDIRW/BOOciu?=
 =?us-ascii?Q?NBoTASYKOQTsYVTtBQ7hKWyvEj0eNIKk+edwu+z0xQ=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b5959cf3-e1d3-4042-6bc5-08dcddc320bd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 00:35:32.2036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB5273
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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

On Tue, Sep 24, 2024 at 12:24:16PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 9/23/24 7:36 PM, Chris Morgan wrote:
> > On Mon, Sep 23, 2024 at 01:21:01PM +0200, Quentin Schulz wrote:
> > > Hi Chris,
> > > 
> > > On 9/19/24 4:00 PM, Chris Morgan wrote:
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > Some of the Powkiddy devices switched to using a different vendor for
> > > > the vdd_cpu regulator. Unfortunately the device does not have a new
> > > > revision to denote this, so users have no way of knowing in advance.
> > > > 
> > > > Add code to detect if a device is present at addresses 0x1c or 0x40 on
> > > > the i2c0 bus and update the devicetree if needed.
> > > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >    board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 147 +++++++++++++++++++++
> > > >    1 file changed, 147 insertions(+)
> > > > 
> > > > diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > index 224019f9ba3..c1d1826fd14 100644
> > > > --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> > > > @@ -43,6 +43,7 @@ struct rg3xx_model {
> > > >    	const char *board_name;
> > > >    	const char *fdtfile;
> > > >    	const bool detect_panel;
> > > > +	const bool detect_regulator;
> > > >    	const bool uart_con;
> > > >    };
> > > > @@ -69,6 +70,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		/* Device is identical to RG353P. */
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> > > >    		.detect_panel = 1,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RG353P] = {
> > > > @@ -77,6 +79,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG353P",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
> > > >    		.detect_panel = 1,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RG353V] = {
> > > > @@ -85,6 +88,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG353V",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
> > > >    		.detect_panel = 1,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RG503] = {
> > > > @@ -93,6 +97,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG503",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RGB30] = {
> > > > @@ -101,6 +106,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Powkiddy RGB30",
> > > >    		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 1,
> > > >    		.uart_con = 0,
> > > >    	},
> > > >    	[RK2023] = {
> > > > @@ -109,6 +115,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Powkiddy RK2023",
> > > >    		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 1,
> > > >    		.uart_con = 0,
> > > >    	},
> > > >    	[RGARCD] = {
> > > > @@ -117,6 +124,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG ARC-D",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RGB10MAX3] = {
> > > > @@ -125,6 +133,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Powkiddy RGB10MAX3",
> > > >    		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 1,
> > > >    		.uart_con = 0,
> > > >    	},
> > > >    	/* Devices with duplicate ADC value */
> > > > @@ -134,6 +143,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG353PS",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
> > > >    		.detect_panel = 1,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RG353VS] = {
> > > > @@ -142,6 +152,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG353VS",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
> > > >    		.detect_panel = 1,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    	[RGARCS] = {
> > > > @@ -150,6 +161,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
> > > >    		.board_name = "Anbernic RG ARC-S",
> > > >    		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
> > > >    		.detect_panel = 0,
> > > > +		.detect_regulator = 0,
> > > >    		.uart_con = 1,
> > > >    	},
> > > >    };
> > > > @@ -172,6 +184,22 @@ static const struct rg353_panel rg353_panel_details[] = {
> > > >    	},
> > > >    };
> > > > +struct powkiddy_regulators {
> > > > +	const u8 addr;
> > > > +	const char *regulator_compat;
> > > > +};
> > > > +
> > > > +static const struct powkiddy_regulators regulator_details[] = {
> > > > +	{
> > > > +		.addr = 0x1c,
> > > > +		.regulator_compat = "tcs,tcs4525",
> > > > +	},
> > > > +	{
> > > > +		.addr = 0x40,
> > > > +		.regulator_compat = "fcs,fan53555",
> > > > +	},
> > > > +};
> > > > +
> > > >    /*
> > > >     * Start LED very early so user knows device is on. Set color
> > > >     * to red.
> > > > @@ -361,6 +389,44 @@ int rgxx3_detect_display(void)
> > > >    	return 0;
> > > >    }
> > > > +/*
> > > > + * Some of the Powkiddy devices switched the CPU regulator, but users
> > > > + * are not able to determine this by looking at their hardware.
> > > > + * Attempt to auto-detect this situation and fixup the device-tree.
> > > > + */
> > > > +int rgxx3_detect_regulator(void)
> > > > +{
> > > > +	struct udevice *bus;
> > > > +	struct udevice *chip;
> > > > +	u8 val;
> > > > +	int ret;
> > > > +
> > > > +	/* Get the correct i2c bus (i2c0). */
> > > > +	ret = uclass_get_device_by_name(UCLASS_I2C,
> > > > +					"i2c@fdd40000", &bus);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/*
> > > > +	 * Check for all vdd_cpu regulators and read an arbitrary
> > > > +	 * register to confirm it's present.
> > > > +	 */
> > > > +	for (int i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > > > +		ret = i2c_get_chip(bus, regulator_details[i].addr,
> > > > +				   1, &chip);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret = dm_i2c_read(chip, 0, &val, 1);
> > > > +		if (!ret) {
> > > > +			env_set("vdd_cpu", regulator_details[i].regulator_compat);
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >    int rgxx3_read_board_id(void)
> > > >    {
> > > >    	u32 adc_info;
> > > > @@ -485,6 +551,16 @@ int rk_board_late_init(void)
> > > >    			printf("Failed to detect panel type\n");
> > > >    	}
> > > > +	/*
> > > > +	 * Skip vdd_cpu regulator detection if not needed. Warn but
> > > > +	 * don't fail for errors in auto-detection of regulator.
> > > > +	 */
> > > > +	if (rg3xx_model_details[gd->board_type].detect_regulator) {
> > > > +		ret = rgxx3_detect_regulator();
> > > > +		if (ret)
> > > > +			printf("Unable to detect vdd_cpu regulator\n");
> > > > +	}
> > > > +
> > > >    end:
> > > >    	/* Turn off red LED and turn on orange LED. */
> > > >    	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
> > > > @@ -547,6 +623,71 @@ int rgxx3_panel_fixup(void *blob)
> > > >    	return 0;
> > > >    }
> > > > +int rgxx3_regulator_fixup(void *blob)
> > > > +{
> > > > +	const struct powkiddy_regulators *vdd_cpu = NULL;
> > > > +	int node, ret, i;
> > > > +	char path[] = "/i2c@fdd40000/regulator@00";
> > > > +	char name[] = "regulator@00";
> > > > +	char *env;
> > > > +
> > > > +	env = env_get("vdd_cpu");
> > > > +	if (!env) {
> > > > +		printf("Can't get vdd_cpu env\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Find the device we have in our tree, which may or may not
> > > > +	 * be present.
> > > > +	 */
> > > > +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > > > +		sprintf(path, "/i2c@fdd40000/regulator@%02x",
> > > > +			regulator_details[i].addr);
> > > > +		node = fdt_path_offset(blob, path);
> > > > +		if (node > 0)
> > > > +			break;
> > > > +
> > > > +		printf("Unable to find vdd_cpu\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	node = fdt_path_offset(blob, path);
> > > > +	if (!(node > 0)) {
> > > > +		printf("Can't find the vdd_cpu node\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	ret = fdt_node_check_compatible(blob, node, env);
> > > > +	if (ret < 0)
> > > > +		return -ENODEV;
> > > > +
> > > > +	/* vdd_cpu regulators match, return 0. */
> > > > +	if (!ret)
> > > > +		return 0;
> > > > +
> > > > +	/* Regulators don't match, search by first compatible value. */
> > > > +	for (i = 0; i < ARRAY_SIZE(regulator_details); i++) {
> > > > +		if (!strcmp(env, regulator_details[i].regulator_compat)) {
> > > > +			vdd_cpu = &regulator_details[i];
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (!vdd_cpu) {
> > > > +		printf("Unable to identify vdd_cpu by compat string\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	/* Set the compatible and reg with the auto-detected values */
> > > > +	fdt_setprop_string(blob, node, "compatible", vdd_cpu->regulator_compat);
> > > > +	fdt_setprop_u32(blob, node, "reg", vdd_cpu->addr);
> > > > +	sprintf(name, "regulator@%02x", vdd_cpu->addr);
> > > > +	fdt_set_name(blob, node, name);
> > > > +
> > > 
> > > I'm not sure this is viable in the long run... This relies on the properties
> > > for the two devices to be identical. Are we sure it is absolutely the case?
> > 
> > Yes, for the moment at least the devices are entirely identical except
> > for the CPU regulator. Unfortunately the identical ADC IDs is why I
> > cannot simply have an additional entry for a new hardware revision.
> > 
> > > 
> > > An option could be to have a DTSO for the "new" regulator that removes the
> > > old regulator entirely and we would simply be applying that DTSO at runtime
> > > before the kernel starts. I assume you probably want this for SPL or U-Boot
> > > proper as well so applying the DTSO there would be required as well, not
> > > sure how to do this though.
> > 
> > In truth I really don't need the regulator this way for U-Boot at all.
> > Near as I can tell it defaults to being on and the right voltage. I can
> > do a DTSO, I just figured a simple fixup would be easier (plus we're
> > already doing a fixup for a similar situation with panel revisions).
> > 
> 
> The benefit of using DTSO is that 1) it drastically lower the complexity of
> the C code (or I would very much hope so). 2) you can have this upstream in
> the kernel and it being very explicit something fishy is going on with the
> HW so people are aware of those things (which also means if someone has the
> idea of supporting another bootloader, e.g. Barebox, LittleKernel, ..., they
> would know about the different variants to support and similar "hacks" to
> implement).
> 
> You're the maintainer of those boards and this doesn't impact any other
> product, so I would say this is up to you :)

The difference in code between "detect problem" and "detect problem and
fix" is about 3 lines, so I might as well just fix the problem when we
find it.

Long term if the device tree lets us specify multiple things [1] and
we can somehow probe for which one is present that would be ideal, but
for now this works so I say "ship it".

[1] This is kind of interesting and could solve this and other problems
    I face. I'm definitely keeping my eye on it:
    https://lore.kernel.org/linux-devicetree/20240911072751.365361-1-wenst@chromium.org/

Thank you,
Chris

> 
> > > 
> > > Can you please tell the HW vendor to have some way of detecting some
> > > variants of the HW instead of letting us just guess stuff? How do they even
> > > support this in their downstream kernel/bootloader????
> > > Have they already ran out of channels on SARADC?
> > > 
> > 
> > I have told both Powkiddy and Anbernic this. Whether they will listen
> > is a different matter. They haven't run out of channels on the SARADC
> > (except for the Powkiddy X55, which is its own board and has no
> > detection logic). In theory if we allow for a ~10% variance in the
> > resistor values for a resistor on ADC channel 1, and the range is
> > between 0 and 1024 (20 and 1004), that gives us about 49 total devices
> > we could "detect" at one time, assuming no one collides.
> > 
> 
> The channel 1 is commonly used for the recovery button IIRC on recent
> Rockchip SoCs-based products, so another channel probably makes more sense.
> 
> I assume one of the possible issue is that they didn't foresee such a change
> would be required and forgot about those ADC channels AND the new regulator
> is pin-to-pin compatible with the same footprint, meaning they didn't need
> to redo a new PCB. That's the only "excuse" i can give them :)
> 
> > I have no idea how Powkiddy fixes up the CPU regulator, but I know
> > Anbernic does panel fixup with some hacky code in U-Boot and Linux
> > proper that detects for the panel like I do. In their case it's built
> > into the probe function of Rockchip's own "display-simple-dsi" driver.
> > In our case we detect the panel ID in U-Boot and then fixup the device
> > tree for Linux with the correct compatible.
> > 
> 
> I definitely never had to do that myself. Never! I don't know what you're
> talking about ;) Oh look, a squirrel.
> 
> Cheers,
> Quentin
