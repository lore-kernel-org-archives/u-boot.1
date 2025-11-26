Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB53D10F43
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5799C84191;
	Wed, 26 Nov 2025 14:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pzLnlJGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C3B8416F; Wed, 26 Nov 2025 02:04:23 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D197A84101
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 02:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azEBuDZwp+l47pakxI3f/bQF5gp5wHHpv9VNqH7/fHlCUGqhXGZMwJKBUGq/QnF/MmTX2sBSU6Lz1j0/UDnr7XGe3HdPWFnsF/SgQBonWdrwYzojfKCIRReYhHfZ28NHc4LSOz779tXC7LBSNBR/H/6uD298v6DzMZm22UPy5RMbBZ51P1uiVisdUUJYStcysZZsDWbbRMQBqBDkKYaJ+1mk7A+tLTkjarnDj7SuJdMqfZduU2W7tnF2D/eN+JsTNm5Tn0NaxNQHkUQjRa6KqZXYlTzUZrqBHTMaFmHnbZ9hsZA7iBvcSKn//uHRhk2IWk5oj7CJFtY4LI7VniGUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeJUBIKe8+8tIk8GkucUZJd4dVJD1W+ZAsI6NXssdXk=;
 b=f9lriZ0qSWrOy3Xv9YO5IV8kyN1XK/Ry4+zEPVSN7v4FMPe2wfyuSV6hdFoU5XEEFfacT4+qCfNw0ck2cP+fO85S7dfMNlt3ttKh84C/ENyj/ndt7TW12MmvRe5Gsh1qnzgzrVXFqqjL2yRJ4Ys4eKvzwzlnTMbIU5tPa5iAFwrOS+ztf6v+Kdt+M4pKb44QUjWiFFt8xLwGAPNISezWrbLwG8YSrSxTEhJD055fo6xTZrbxKi6q067mlD5OVOiS1HincYJma0cS2dr9TedJqqCkHBc/8Sqn3SQouMmyuHhuKj/9QyZK4vsUNcufb6ky8sTzem02lAIz8KW536yFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeJUBIKe8+8tIk8GkucUZJd4dVJD1W+ZAsI6NXssdXk=;
 b=pzLnlJGvEiHyyM5+PHS+gmm2sMNpEFmBlwaL+U5j19DDkFd7W58S+xoTvZFPUwgXUT9FR1kwMrVLrPGx6Mv6ilSadQPJIhWBavxWc1k8BE80QxUXSXdVekEXgxzMbmUJtyqgIsRSCz+WNV0Rfb+/hjVnE5HI88R55P7saNSWq/hqaPtPhr5Z3mV+94KKAUJ48BXG0OQ+BTPmtnlUYk6LIVj4JKGY+tITxy07tG2wKxn4tBrDRvkab9e2ye3LACnOBTyZ3jng2tIBOZZ4fVC+Ase5l143kuEhlyZQuQAWznEltveTJ7rDbOTal9S4b0EARly/OjcIt+w2WgfD4sFGeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 01:04:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 01:04:18 +0000
Date: Wed, 26 Nov 2025 10:17:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
Message-ID: <aSZjLjm7saoeQYBs@nxa18884-linux.ap.freescale.net>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
 <aRv_hIwxZshKJQI1@nxa18884-linux>
 <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1636234f-6f49-480c-add9-08de2c87b961
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VMUHHSVqvWW4iRBAHFosRHYvjRD+FmbI1lr7Na0rEOie9ppn/9blMbFb5fgq?=
 =?us-ascii?Q?OX8QNKqYhuHfEdCm70bg+04j1nLCgFwGWTSua0v3IQTdULV25aRGIz5VjPv1?=
 =?us-ascii?Q?t3YjDjIjJRxJKN/9dqkiHor/9u3H3brMlYjmMXCcyD78W51ttwjNV6g1ohxP?=
 =?us-ascii?Q?ZEz4Z5whTgPECx1SiJxWUEhGr6huEiuR+kNd1PN8ObO6MOlXsNnpP1Sjhq0D?=
 =?us-ascii?Q?f4Y6Xi1HPzaLdZt0JVxTi6ha6kVYNVfYNw5TDTW186N5a1B4YeFlnXhT4RVy?=
 =?us-ascii?Q?pEElMSzy3CerVcRHmXr7t+wFfanOk/0p+DMCpjpCq8uDR6hOl6dknjcgR0hm?=
 =?us-ascii?Q?km78646q8gBmOw4r0hLzt6YOCURiP3dxlA2GoTWCqIMIsZBdSeUowye3qLBp?=
 =?us-ascii?Q?qrlepkEQmmbsANb3cBXIijs0qPUt7bndRdvoKW3oWyyvFQFx9YCFlZKW83yI?=
 =?us-ascii?Q?3MdhyLXNeVZzROWmsfFnhOIXVHHUT+Muz0CbA0XFRTFD6Fg46FZEirA+J+s9?=
 =?us-ascii?Q?u82r8ohEQ4FpfwBRcXoql22KOoMh0PIXi08Y84cBojjLziH8QumOSSygpW+y?=
 =?us-ascii?Q?3iNlzjDf8FMDhWT8fgb8YRcrqzwNeaC5V5nOkR7RSrE+60YOldoYLqBv1Lna?=
 =?us-ascii?Q?oPvBFjAHQk4QsENQecv8/2a8srKNMieEvSoOfkWfuNLnJhgxoiKIAbqLlSGP?=
 =?us-ascii?Q?5H8Z2qL6aZHZ3lPmpNoLKhI4oDIoyE7Qtu0CneMgVu/nk1fAmQpeShayPjIO?=
 =?us-ascii?Q?B75LmMOseXoYYKi/yKfMybvzny/im2VDGGLTQBn8blnAJSOOVFFbDpCOwXXs?=
 =?us-ascii?Q?uJyuOzwO8VbQdg3cksF6cDqv5KhW6FMEWG6wiLpb3dVrhkt/9wpJ8jcCRiKu?=
 =?us-ascii?Q?MzRVwQdT/72BLt2adySUDt0S0hcfd2tyx3nMjLJGKdnJv/viFh/v4f1Nfwo2?=
 =?us-ascii?Q?fLnIaLSD9kgqRt14Sd+qa9vCcZrGRfA+f7dWvV2w17o8Z96wriHlhIncApb5?=
 =?us-ascii?Q?1+EWLpiq4gvKnn6jBV419Dc8Xo95/JuM1x4m8dK46+pPf64pejYOCakPbV9+?=
 =?us-ascii?Q?EtVzWPbu8kT63MPU6Xt0c2IfMWn7llb3/tzeUyfPziruaUN0Y4FrJPJEI9Bn?=
 =?us-ascii?Q?7m8Ql76/hkQbzBo/TI/EFQ+CqGypbiY2U4PQcD9tEUWLx/Pe4BWRF5H2wlAJ?=
 =?us-ascii?Q?dGKuPCFOdU4dvNqHAOFAXZhv81vw+/KSAxbrLAt+emDFUQOYbkRGgP/4ss8O?=
 =?us-ascii?Q?+zZLHCPGGrnBHOJXtQrLF717dNdsPVMWk/IM44pOspzZg4c5gECMqf7JHqxr?=
 =?us-ascii?Q?Y/xfTT3fGfGQ7X//RuzrVLtPo/st34UQ4zIEVNvPEMlJxBs667Wdifs+3BGq?=
 =?us-ascii?Q?uSSwnTFW2GSj7PgZA2svVYG7k0I88YZRsCvtMtd/1lY2pWloFRf05sU3zZdF?=
 =?us-ascii?Q?yA7vsICJA64plVjj0WF+aXkBC0v/aDOLCeMpUnZzpv83p/B2S6Bz7MsUexij?=
 =?us-ascii?Q?uzr7ljNhgeEY/b8mZN9KnpRQP3TfgSXqkONZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unJR2tlV8VGOEkXVbTwB2YcdgKA2GbbtSqFBRMT7fxf3La+Hc6naxJxk1owv?=
 =?us-ascii?Q?5ZhGClZUcrTByQReP4+kDulYMS8z9BRtmxWXEdS+nYgdUrSgAvJM0lg6omrQ?=
 =?us-ascii?Q?FBN82noL2QLnNO1sl9ARcbYCxejgLPaa6FF6IQb5fSShhLCrEYJtvbPzNRLb?=
 =?us-ascii?Q?DDUbYjcP6/Egyf8JmKysk09Xij6ozkjnvRPpQ6GxOtU4o4qUKg2SIa9oD9av?=
 =?us-ascii?Q?iPKMIrZKa+GzpD+bUQo/nYJRNyiasA8xcV4inflx8q0fSLpGENqzZyKyMLJV?=
 =?us-ascii?Q?KvbCb0VB4IWGCxGWDxh14/uR/eFvBGc4t6OViKfZHdlQ8XwEm6Tpxcaxvyie?=
 =?us-ascii?Q?4uKHEMChugJcVkbAFbH76pBuvChm2jhyfquy5X0yDy/ZNBC6wex3SolY+sRG?=
 =?us-ascii?Q?NA9VmmyBDg6c0SEP19MrktbR6PRFd1HJ9ufsK5NTG/9pG4+RR3RC+Hhl7HNF?=
 =?us-ascii?Q?D6KKZHl0AjfRTU9zHDLlu4o8g6vSPyAE4ziuOz8rzbsNrZCS/5/msvPzJboB?=
 =?us-ascii?Q?gvKemnZrTqkTCEu7EylgIWWe5Nwim87ILXJ7jk1sVv2lsSpvw/keTiXJrPOK?=
 =?us-ascii?Q?KoWgrgQ0xDi1MljlBi6nvifTN6WfPQ/nz410BI39UOn2MJZj0yjhgIinJ9lg?=
 =?us-ascii?Q?jFf2Vb7sYwuz7mkZfsKkmy3Ku6i6KxTZU+Z/WnLksv3bNN/6x79ic4EMUUkj?=
 =?us-ascii?Q?L55TW7BbO2hsfWW+J02IUByQgoOtmM1iOlrcwSr0S3Glwdui79FejvC0Ohsg?=
 =?us-ascii?Q?2DeAdf6NkdqB4ofv8XFUifED3G3GejpyIOJRuVhuQK6Kn7OEGJaDzgKZh8zs?=
 =?us-ascii?Q?fCa4OEBwvyFBJ3zlVrJl38k+jQ4Jlh6cBuZ5Nt237dGPQ96r5jn6rsKGJGr5?=
 =?us-ascii?Q?KJFU0hSROfgZP8084lZYSEZDEfT2ed3FZJK9OWDuXOhIZatt5c3b2aUmEdcR?=
 =?us-ascii?Q?C9Ij4e1kDTvCq5IBKz5BB3eoYiir9avotDoqVYPbZNrkPqqCIMF8VsxvtD/K?=
 =?us-ascii?Q?Obbr/3s2NisvxL5DbFCe44kiC4hmsOiubCqPDiir84RpcWc/ipHmQMJxn1Jx?=
 =?us-ascii?Q?bv0gM5ozyDyrBKlJ5V+Ih4atVrQzi5Uxfvn6W0tuCR2xT9nOcGXWjEJgFGtF?=
 =?us-ascii?Q?84BaGhgvp1qL285vcxiwAIgqyLbbLZ+XIUak7DO+O1crS76d8jfZY2Q8jl7c?=
 =?us-ascii?Q?wFDaIb5SJSgeHqQEuqsdjaYm/9ve+9Ly99MKA+5SFAKeEweflo8J9MnrV2Go?=
 =?us-ascii?Q?R3SkQ3tsIa3CedQCETmH8BV8FJey9RjLZkkaXhA7979WF7NKCOfdRuG3TZVc?=
 =?us-ascii?Q?9OMmy3xXz3hHYjUsWJjrOeL3EYdnlmnDV7Bz9r5WeYrXt/FellyhmlIUIp6a?=
 =?us-ascii?Q?0fdvUA9uRPSIpDHQF9qzqic9BqxlFM+4P6qWPLJDwz+aoN2fKoe4No1Wqlp7?=
 =?us-ascii?Q?LMbBfAkOfBMrhNOrqfZLNVgmtxKsRJkIvYxGtf6nHhEyilG4XaiuT7ZlAFFu?=
 =?us-ascii?Q?Y32BK1OX2fnmfmYGp+UmeThnc1c4lGnp4rk1EYpPdZqChMAXXMfYY4plRKgS?=
 =?us-ascii?Q?h5XyFGjdYl+KJC50S4Cz1y2WDy4zkoUuQXY46IXl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1636234f-6f49-480c-add9-08de2c87b961
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:04:18.3999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tMqg5uUF1OhnT3j2zpu66AgoclQn13diSZ5Lu3ZWflJhX16xTrE6Jp1DNHqz7UB0+NSYTjFYM2i0nlK2tGzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
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

On Thu, Nov 20, 2025 at 08:29:11PM +0530, Tanmay Kathpalia wrote:
>Thanks for your comment, Peng.
>
>On 11/18/2025 10:39 AM, Peng Fan wrote:
>> On Mon, Nov 10, 2025 at 09:37:30AM -0800, Tanmay Kathpalia wrote:
>> > Add reset control functionality to the SDHCI Cadence driver to properly
>> > handle hardware reset sequences during probe. This ensures the controller
>> > is in a known state before initialization.
>> > 
>> > Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> > Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>> > ---
>> > drivers/mmc/sdhci-cadence.c | 8 ++++++++
>> > 1 file changed, 8 insertions(+)
>> > 
>> ....
>> > 
>> > @@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct udevice *dev)
>> > 	if (!plat->hrs_addr)
>> > 		return -ENOMEM;
>> > 
>> > +	ret = reset_get_bulk(dev, &reset_bulk);
>> 
>> Should this be optional? Some in tree platforms may not have
>> the reset supported.
>> 
>
>Yes, you're right-some in-tree platforms may not have reset support. In those
>cases, the code will print a warning message ("Can't get reset") and continue
>the probe process.
>If you prefer, I can remove the warning and let the function fail silently
>instead, or is there any other way you would suggest to make this optional?

devm_reset_bulk_get_optional() may help.

Regards
Peng

>
>> Regards
>> Peng
>
>
