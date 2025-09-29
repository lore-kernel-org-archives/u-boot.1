Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C5ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946FB832C8;
	Mon, 29 Sep 2025 08:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fqQ7/uzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E199F80819; Mon, 29 Sep 2025 03:30:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD14B800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTgKJgyH/XY0rDHSpTyaXw/p3yF/prg49rjF3N0P5QmBwnzwibDBlI4X8Xb907d2PrFWkDab5GBwmxNpKZj9X1+n0OBN7CZs+sE2uTZ1NQyL0t7eaawM+nvY8gRt8sr2Dl2TjAOjUoYmFNchwTbfB6wKTh4S3M6s9sEu6BDi6N3yeT24CyJdnMVuSNvSPHC9w6jtWqEwij/rLAcY6zQVOocfnSgE9B2/x50FbSp4B1jBQHX5IjsEvrRSzHrSRyA2etCCaIEnD3dHwhAnaLZSnEfHEC4wYehkmtFKGeUmettNltlnjtl8qYYBvpcsUEwiTjdWsYal19lCDKvKg/rbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFdRRKyimWfWT2ljBlNifAaHgB68SoDj7OAgpYqwM/A=;
 b=g/OKfimqcQSKOyVLxQ8pKN1rF53rdH4+NDPeySfE4RWO6uFUmP9r3ZK1rcWMwF+N/S1vmQ9hEwEVAYIScPB0jiJyUKF5fTP0MIZn8KnTPaN83UtBfKRh2eV4Aqc8kCKUhemOtf2G64ggCgeZLQYc1D/ibJcD8xdELI+FljFqsE80gsxBp8HcrraP2wMYtR0zsSrWq59ZJ7UWY9FN2zhbDFZn8j6eGZMK0Z2wyB5lfRjiQwlSl8PVtx8qDl3OnDCwcr/s3nbHsHiIA9zw3g+pHSxGTBLJzlRVeXFjOk+qZnrCt8VgHFRWzKMTQRezEChFyAppFCg2ChYWSmdpDoO6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFdRRKyimWfWT2ljBlNifAaHgB68SoDj7OAgpYqwM/A=;
 b=fqQ7/uzuPaKmk7cHsTNfcD9OtMRDa2XBZS2E1HA3xqoDPVzGlElq7iWz6313L39QJnHBi2CSm+RmKu0Glm1R4OLvqUOq7IEygtO35FK457Xu197w9Gqx+1c7B+at5SveBy0OL4rfNWXu1R5MjuainTznHC3qutvrCA7hdnknS66+W3WkjX7YRZlj7Pmw+Bk3eCEDgTnRdZjYy/gNM/M7pvk3QyMbnxDA4K6uMNwWLjLq2YjC16uLFvfRYqG4yoOHQ+/sEmoUgliv8On1H23d7YbsfYxqSTFFaA5tRr7TmqonkxYIKjs25q6Bbhird8mHYQe2X7Ti1CyDL2n9hzMZ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Mon, 29 Sep
 2025 01:30:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:30:11 +0000
Date: Mon, 29 Sep 2025 10:42:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Horia Geanta <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
 Silvano Di Ninno <silvano.dininno@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 "Baehring, Olaf" <olaf.baehring@draeger.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] crypto/rng: double the entropy delay interval for retry
Message-ID: <20250929024205.GB4184@nxa18884-linux.ap.freescale.net>
References: <20250905093348.204409-1-gaurav.jain@nxp.com>
 <20250923091238.GF31170@nxa18884-linux.ap.freescale.net>
 <DB9PR04MB840990678ACDDF8243F90303E71EA@DB9PR04MB8409.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB840990678ACDDF8243F90303E71EA@DB9PR04MB8409.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6b1bd7-dd1e-4387-2621-08ddfef7bb8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JC/jXZ88TrncfWVb4Ys+CPjapOixOynmJSxHnnpSCHigRNFUGPJBamWYyIiz?=
 =?us-ascii?Q?3RVxmxuD9kdtP3XyO9Cyxy29VNu2MyKe5gokwcYwZzLm1HmNVfr8TvseNWbD?=
 =?us-ascii?Q?3gMCtYiMUbCkmGp85NUU2AMvAbdCGh22k+PNZYmBaLAYbSq0kkzlz5HuiCOY?=
 =?us-ascii?Q?/HXYJ4b437HoY0ap/dN/YF5mLRquTqA+QUGPqY6zHXSWyT1hYphKdlTRvvBj?=
 =?us-ascii?Q?jtfeXYBjNXTOGro2sbOYecrn9ZewD6Tzp50L0ebrmv8k2RQz30t6aXCOn6pE?=
 =?us-ascii?Q?46mVqHjBw81A44YV3LgQ1liVzYktm+Pfa6b0U5+7DnwTRNOnv5t6pssYMGBx?=
 =?us-ascii?Q?uQZYKFukBNhFqiQjqvCFOLNBpG9DJAIkDebB+NwxgoiM1/AjQh7hD1Rctq8t?=
 =?us-ascii?Q?1Hlp7glmj1tz5csTSf8ZWZgFUiwzPEZ+2gJ4Ap1KFD16PLSFop25MbEd+ejx?=
 =?us-ascii?Q?FVeNRsrKg2HvmhFlv8a6AynXlh6oTMuDPKbr3YS9EetW5dMHpKJqh3EXNf56?=
 =?us-ascii?Q?lFyy2mxgfSOUA+uN1QCQBFSSjpry2/FFepF01VeGVRpF5OOi18ZHLSxmpmN+?=
 =?us-ascii?Q?zlrl5Bvk3RNF4YWyBqeSPYapMlNvCCxjlqm4ozgWQLGq8VsVOlJ/gdfSzGI8?=
 =?us-ascii?Q?FtkrOkht1Qfmss2WG6H1KPHs0fvvfKqwiYaFz+/3ExuoZrn7GxCPITfjgj+z?=
 =?us-ascii?Q?sxZFsj9jOBXHhnoeVSVg2iTKk4YZJi/p26ueknBhDFfX3Kzk5lkRaY8zFAlC?=
 =?us-ascii?Q?NHzkXbO8nmh6QJ5MuR/fFEhq8L4yIoEcBHBcH4lesTHP+aPoyF51pZhs1a/M?=
 =?us-ascii?Q?eXNSE1oiJygZdKvWVvJ4N0P5wSPGhxjnmuVELU1WKuC7OST4HwhZZ2wZgKAz?=
 =?us-ascii?Q?c0qWyCs/MQkvYUTPogD+Q+CS4JdvJRNmadFT7gkxJjzQeRHeXDSah+R0jADP?=
 =?us-ascii?Q?g7hdL5KymMnhrHULfkU/fFNHrEZh8uemtANcfLl9dL4SbpgW+q9Rnnxo1dz1?=
 =?us-ascii?Q?Ls5QWO27NKVKbidHgOcj4Fz3bnYuxPMND03+/LDVWQ8rL8nqMb1WkYxDVVVS?=
 =?us-ascii?Q?uRt5xnrc6224wbUpWrdCwN3CosFuf+mzr2BIN7reGQ/nqPDcurV+WQZBh/BQ?=
 =?us-ascii?Q?j4/A45Vyt/7ADNtLQ+rytz5jTn6t3v8m0g3n3NDXfoNMowBGtAvvdNZFFtLL?=
 =?us-ascii?Q?noDbMSwzuUCKVclI4hrp2UnJUIZkvHr8uR2YMsACmdDaEVHJbH7PkthDRSlX?=
 =?us-ascii?Q?lTNDuK7Q2TBLm0R2LVeMdXaTSstDAs3U4AS4Jn0ohjDQx3pUuS3KeSRrQy0o?=
 =?us-ascii?Q?b3m74CX05HhxVAqRmk6ORl4sw9VjOYuPhFtT4HApVBX245I1i+xkzRovrtR8?=
 =?us-ascii?Q?MPoSlMNK+f+rEcCXkVAkn3Mj3ZZehXeJXenK5E2KFSntq0ImRFT2zfEGopw4?=
 =?us-ascii?Q?2R0KznGCZikEiAI5E7HWKoFyOugbo9tzAfE8dNPCEON53yb/CdOlbl0BTtJF?=
 =?us-ascii?Q?AmyCqTKChpM9a3N7wmoH6zVpAdhahRrLvBuv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYU8r03dLJcdU8TWScq0ong1C5GpETmm1m6hjcBCnDnmqugVYTMScHkpgAdx?=
 =?us-ascii?Q?dW/CkYmrmZCKszC7HTFBPgQe2dFHScOcdH6DUgYbBeH9nn3sklUnkiiqh3f0?=
 =?us-ascii?Q?ZDGsJPDw53ZoQWb17p+FidyGZzBOWiIlNWAd0nMcc83A6KtCrKs8zH4N844I?=
 =?us-ascii?Q?Rr5R1GXY3s+OkTlqZh8dYQfzqOVXbT8sXbspzGcpaxxRot3Qctq2yTQsYdq2?=
 =?us-ascii?Q?34jkvZDJA6Nt7y1cqA3oFcu9Tb5xrLGvMlwx2m7elyOmf+fDYKv3QLjyJJ/+?=
 =?us-ascii?Q?0MzvmsbxY+RvDXuY4PHB2tRZdCmoonoA/KU5ZrjbJzjyJPDo+X+uyKScGd25?=
 =?us-ascii?Q?Iq6+sFP4bEFyp/FEMZcLjdgpeBWOe6fTQA/hEqTaU0hfCi9lGM0RJhdF+XPI?=
 =?us-ascii?Q?yNm7tydnddYFvn4Z+cUh1yZ86zslbda5wg/nUQOMBcfSzzlLE5rE1BlE0VQe?=
 =?us-ascii?Q?tpZUbpNtK+HArI5pjX/cut7k7Ve+uGbNryL2JhbFeaZJqijdooPJyvIhXvJF?=
 =?us-ascii?Q?msDIrw6S7AxaoRQDDduzOyRgLUwwv7Td771cWSF5+gzCz9FfXPNUc9H84/3v?=
 =?us-ascii?Q?SqnQgCiw3OtIVT4zyCEaHBhq87xOh8V20pR3KvFZMyxa8aCg8DF1xegtzRcM?=
 =?us-ascii?Q?i+oODmnRhT/hmK0VddJOs0GaIfsg8J53Vyo3/B5dQABANSJmNHeFcRh0V+NJ?=
 =?us-ascii?Q?884qRM0Ire6od6ymcXcSmiymxuEXRM/UNL3v/tpCPCdLRTOfr8q3Pbt0aN+Z?=
 =?us-ascii?Q?Qrv9TW7L9TESRZNfhRAMNDeQtImpRvpm7V+gPoVxniPqisBXUXtb5J8bLPyi?=
 =?us-ascii?Q?Pm1P4TwnZ4wWSPeAWBOVkfMi9i9G1UzHk7FKneA9iKrMBIoPo6ftu0Jzh4eG?=
 =?us-ascii?Q?iDPdgeHPIBhlw/eYzGDxqwc36DQoAl3/R4yoUey+US7VzNtqdq4erHuz1wbN?=
 =?us-ascii?Q?GIiWnEWSsa/WHydU3VfDUrQBMKPT1dgXBvZBxV9stxYWqvR3N9TtiGrc5EDn?=
 =?us-ascii?Q?6seLsDrSmhhMn70WOICUlOtvgYOEF2nbnjIoGLEuvvGrdA0wozpEpWHxdB2w?=
 =?us-ascii?Q?UWYQVqZcsYeWMsiMlct/gSC+eXSGS/WHf62NU2+CFEO37CzjNxJP0+qzvYzw?=
 =?us-ascii?Q?aJ0BSQcM0zd8jAEAWppK1D+pOLJqZXMhMGRYU0LWpNNwpi7hd6sh5tGhxbUU?=
 =?us-ascii?Q?c0KwDUCH8yL4XnyvNdJ+oguLsPq6QCBmPlMDxidRh9YYX65yaVtp8RroMH6x?=
 =?us-ascii?Q?UZuwBEqe2/ZtVKTsev2eD4EtbiTYfXYYeJstLknneYde6FsdQgrFEWam7M8l?=
 =?us-ascii?Q?uxMzsspY1F/yt9fujkPtY5NFy5BNRGZb1QuVzsvcGXl2GsAZWAdv+YIb2E0q?=
 =?us-ascii?Q?nYLOgImHRP8ZOoi7pl5rL8oSLZP5rMPjM7EXTS4EYnUeDp/+sxm7fbd8Fe4L?=
 =?us-ascii?Q?oYrTjCe6udYCsVdhyWlF1OsDBZhotnQOphXLGsZOUL5Aa6Fm0TFmYzuQ/Eq1?=
 =?us-ascii?Q?hw6E+692CnjcHJzg5q4BmBNanu6ZLJFPic1AYxCu1JhA7R0FfpViU2n9RRMm?=
 =?us-ascii?Q?wX17iPRWomqPKr7C1o5iNxHWU3GtqZ9Q13n5dSe/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6b1bd7-dd1e-4387-2621-08ddfef7bb8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:30:11.7571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CawVh7K/K43iddMpnPRKLs1FpTVrPkRV4BC2FNLkczLX3X4sv6CdzV+xjoFBDUTxDRIllAtM5RiXyFInq0HGkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Fri, Sep 26, 2025 at 10:36:23AM +0000, Gaurav Jain wrote:
>
>
>> -----Original Message-----
>> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
>> Sent: Tuesday, September 23, 2025 2:43 PM
>> To: Gaurav Jain <gaurav.jain@nxp.com>
>> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
>> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Silvano Di Ninno
>> <silvano.dininno@nxp.com>; Meenakshi Aggarwal
>> <meenakshi.aggarwal@nxp.com>; Tom Rini <trini@konsulko.com>; Fabio
>> Estevam <festevam@gmail.com>; Peng Fan <peng.fan@nxp.com>; Simon Glass
>> <sjg@chromium.org>; Baehring, Olaf <olaf.baehring@draeger.com>; Heinrich
>> Schuchardt <xypron.glpk@gmx.de>; u-boot@lists.denx.de
>> Subject: Re: [PATCH] crypto/rng: double the entropy delay interval for retry
>> 
>> Hi Gaurav,
>> 
>> On Fri, Sep 05, 2025 at 03:03:48PM +0530, Gaurav Jain wrote:
>> >during entropy evaluation, if the generated samples fail any
>> >statistical test, then, all of the bits will be discarded, and a second
>> >set of samples will be generated and tested.
>> >
>> >the entropy delay interval should be doubled before performing retry.
>> >
>> >Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
>> >---
>> > drivers/crypto/fsl/jr.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c index
>> >8f7a821ebf3..07d336c074a 100644
>> >--- a/drivers/crypto/fsl/jr.c
>> >+++ b/drivers/crypto/fsl/jr.c
>> >@@ -642,7 +642,7 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec)
>> > 		 */
>> > 		if (!inst_handles) {
>> > 			kick_trng(ent_delay, sec);
>> >-			ent_delay += 400;
>> >+			ent_delay = ent_delay * 2;
>> 
>> I not get the point on why need to double, would you please update the commit
>> why not 500, 800 or else. What make ent_delay * 2 the best choice?
>
>The typical reason a re-try is required when the entropy delay value is set too low.
>Therefore, when the re-try is attempted the entropy delay is doubled, thus giving twice as long to generate each bit of entropy.
>This is done to prevent having too many failures.

ok. I would say "double the ent_delay to give more chance to pass", I will
update the commit, no need resend.

Thanks,
Peng

>
>Regards
>Gaurav Jain
>> 
>> Thanks,
>> Peng
>> 
>> > 		}
>> > 		/*
>> > 		 * if instantiate_rng(...) fails, the loop will rerun
>> >--
>> >2.25.1
>> >
