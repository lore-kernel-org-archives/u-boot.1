Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB4E77188
	for <u-boot@archiver.kernel.org>; Wed, 25 Dec 2024 01:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326F380730;
	Wed, 25 Dec 2024 02:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tyH0pqsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F5F806FC; Wed, 25 Dec 2024 02:09:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE85806E5
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 02:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqnh5MR+k+4+aIzHuWuvj4S6eFF6ZSL0QKMhs6YCYh/xJ3tQyLi/qdNpMq41DLVxpudOsU9AA7Rml6C584fHFqTnNQQgY3TpTkrOVtoMUcUT7DLYuu3/taosZ0E895ViR2jjlRmQKGk177XVE8angmliP3UQmTeJPrT7hTCBI60zE9JyptEd/F6xR3wcvCB23wRIPN66WKfIxyR/2h8q19hehbYxXHuDdoyyUz4p6KEfXNUvIPf2i9sCKFcBTIcvjziMNUVZai0NMAGc3HqKZje+fvYNI20t1MEFQlF6YGxiCyrNl2+9Zy5phb3b4evHJUpWK+fEQIwQ4aNeDTCIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP1imH5M3zcz5us2rAdyIHTdwQVr2zmXL6a7Ki4Y6Rs=;
 b=ZR3+gtZWCjloP3OS0pBxcGaj+t42HMXIGJdyNjswkzEp8F4pPcfjKMRuY1bYuynkaF+vb5XsuYhZjccp1gsBgVAT/iMEyqqU91I67sYtSzce0hGGr8KSTa9pk66H8hnleSMO874BUptLfbcEDBPkmWnN8wjNzktWROLkuEL/pH7YMDJF2mTW2gkZMmnA4QrXsJ2j4KBYS7s3x2592dv9bOslX2Y/vTkBCi0EeWZcLfu7ZbuGyRa0YVjsnygitJdKO2BCdGZEWsDOnns96tUnCwuy7cmt4foQGnB68Sjad6ge/hPKTM5tJVSQCIeA71PwrhIIJxz8RFTYjavXZ6iQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP1imH5M3zcz5us2rAdyIHTdwQVr2zmXL6a7Ki4Y6Rs=;
 b=tyH0pqsumVn96Ly4w+nvgM4Owdjgg2Ptpzb7PeSLmvtDFMgcBVZ4nCuWn97if+jWTKKxCL6O9Nd7nKmsNzDUxdZAXEC+iyMBRtpq2bWky1bCioKqiOcQuqBaRnREdNoAbffJdfXSeQ6RZcXMG2G1is89k43XRFV/ZgKk+YBE6yAjR8hx4Fdt+RWjq44JrH4Mx3Zsdj0CvdM59GuILu3tr3H9NhixTEvT80/hlXLnQhuaRvxzuPA8orqeQXLu9ekinVXmE/kRedgMUWz2ZiMmKlZvjZaCdpoycCvqGCGY6J4tVHtVC24578jNNR3jnfjul7lciZO84erdhCYNF7bk4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 01:09:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 01:09:16 +0000
Date: Wed, 25 Dec 2024 10:14:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Gaurav Jain <gaurav.jain@nxp.com>, ye.li@nxp.com
Subject: Re: [PATCH] crypto: fsl_hash: fixup alignment if necessary
Message-ID: <20241225021428.GA15148@localhost.localdomain>
References: <1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8407fb79-0879-46e1-472c-08dd2480c056
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jpBQ26HS5PdncBe+JKmcsPegZ9cLBK1YdMGJxq8lKIGupV656gGAx0f6CvDF?=
 =?us-ascii?Q?BGt7+0VG1oaUZGLwDlAAZNiQIDg81oQnOviDf2VWiz4ryy7/W5s9K+ZM+F2K?=
 =?us-ascii?Q?YRA/uyN8+tJSjTaff8oTpj5rBTuATdoHDyJOGow4XZTv0l1Q40/2WcP9B7De?=
 =?us-ascii?Q?e6eG6XPbeob5klu/DeiiOquMMdLqc/1qEnVEaQ/49VFXYDJipz1uMARBCNhU?=
 =?us-ascii?Q?zNC3Ys3HBCKFIyriAnZz7tufS1sX7KMp1AVNxfKXifnhcsGwA1kxpX7U+ppr?=
 =?us-ascii?Q?WD3XkutA6PLA6zSSiLl8pbKZQb1JyCr/dw4PFIOPfpWVTlohrjUPzPbGcPDD?=
 =?us-ascii?Q?ACk6prPKUBsCkaO8ZleymByYY6dyGTaQ+6MRdARpDcpbkbAg9iqvA3uNH+Wo?=
 =?us-ascii?Q?kMmobFGPoGhP6ANDwYKpruFe6QG6azS1qjabZeikEBr27CfY0jILiHQO41tr?=
 =?us-ascii?Q?NNDa2YDeJHr2JCUAoh4IiOUHGs5NT8CXPCrFulfDfeLW43J7CXucc+czGjFr?=
 =?us-ascii?Q?V3zSpmckzpgMjA6dLC0Whz8zyADbJLihnkx/bCLk+FJqqFlXiHkIy6BPKRJc?=
 =?us-ascii?Q?+Ql60sR+rKkmrw2v1nnAmJXEZmTWYjfaZ7aG64trgISbxpSLbe8+CynEQnqT?=
 =?us-ascii?Q?EdqqwzrY6b4xD41Kxkt+IFhiRrAfE0WhZ1k3rnS2ETm0gt3G93aljUQvvLa9?=
 =?us-ascii?Q?2zwXxzMAxgLu3pCNRoC9AhwTXCwylcrIdaQHYtPL6D1N3NzH2p8ziYVGMujo?=
 =?us-ascii?Q?adsAGH5RrSXTUeCA26AhfAFkBCDHSCLH+L6gyMFSD4TA+msSWsO2HO0osgWQ?=
 =?us-ascii?Q?uNgigQGuvaQkL8roN5mVpr2pyoHskKQR3NIjMI6/TfqzimNkZ3a6RwFRViaK?=
 =?us-ascii?Q?AKulXu/uZXGPyY608MF+1J5REkQGCRjzj2lPyJBHlBK0yLLSfGMzWNLfifVf?=
 =?us-ascii?Q?kjriP9A7YeFAQj5Jk1uv6hH2unw5b4twWZc13E27aZhSBAcVoNLWbNhG1xGN?=
 =?us-ascii?Q?SY5QNjw/PX5CO6Kjx5aaol5ZHyzO0LHgZa7aFq0F6vREEVB+hs+mFsh6BIlF?=
 =?us-ascii?Q?JsUGrSyiMaeLD9MWf2TLZtowyH+d8Q4wKB5VihHmi1Lm8h693uWL13onQngB?=
 =?us-ascii?Q?u2i4Asg1TulcoxBL1Qn0FMiNrMDkZqZChoVTcBX8H20jdLPeQmbDZTjXirI2?=
 =?us-ascii?Q?44SH4iFSkshyjkc48SwiiPac8EnWB5B+H1alDJEf4OuMSy0YOpQwBqMvAb7F?=
 =?us-ascii?Q?aj4QTnKHu4/4zKCcQhGe+drur1olncEfDbJwh+HYmsV2Kzl6KXb5ZVpW3gL0?=
 =?us-ascii?Q?BDInmXRqtOBWATkcjEyEZi+y0s5q8vNcyfBIVD1Z5a+vdoCNzqNHbn6i0nbj?=
 =?us-ascii?Q?PP3yb9nKhNJXHes2+YMkpjq/8huAe9HUo6saRBjWMEHTDwCXVSPc+WHS0ZMg?=
 =?us-ascii?Q?ix91XCz+JsE3nCKCMsZzWRwsl9bJ9E2Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZtOl100VUYIDAkK17SoB4yLJUAVDPCcSshrMLdcB+8Cqt6esWML1ywTbH0L?=
 =?us-ascii?Q?DBHkO2oA3iy2tXzgDTuO299z320tM9cdbqidXaa28KacD5KxyTAF05MUUQSt?=
 =?us-ascii?Q?eNG5OI6qchxpFBkOUamj9Hkr8WAhEcJAVuE3Hdxd79259a2XTea+TVnGw6N1?=
 =?us-ascii?Q?Gz++lUNDbgb/WYRTEkpxZa3jVNSg/T/nx22tEG4RVw9QzajngtrR+8jrFYbj?=
 =?us-ascii?Q?8de+z211aKfP/J5XJww8sggG+d8GJS6vpIuKRCgubudDL1sRPjEN4GCQI9kl?=
 =?us-ascii?Q?SyPF3N+K2CuexFunl1P7h0ZVXrmgEBvbqdTt170nFruNP1cb6zQKQrk4Wd40?=
 =?us-ascii?Q?lQ6jZVvq3l/34C1LzVPYn2qvas+8QDU8uDF0x2hHc8U6GCPBdczoZJ0fhSym?=
 =?us-ascii?Q?mNK0vzeeSp2fGzJzqZ0WKSwsDo5nkTwNlg8KCySkH9Wx4T7BNxRYPZ5hWJVh?=
 =?us-ascii?Q?rcoRYKy7LfItabyt6O00W5KWzSbxUCrU96bmQhjncqsS09T8vZGnXRiB3FzH?=
 =?us-ascii?Q?Jftd1iuFNNk8IVuyc+VFNu+HlhND2BpgT0fq46cn+WsnlxgKKcz+TcYh0/fd?=
 =?us-ascii?Q?PE/jZJUJGVJmsk7WkraZH9ZdV/F8dSW0vSzLBepvCm5CEYXVtcBWhGBVQzSt?=
 =?us-ascii?Q?q4jaThOQHuv20jZOXs7oQz72pW4lSC+j/sWsZDw1T/HmRxwXo7fQyqzl5j5l?=
 =?us-ascii?Q?tQg0shTEytJPLJFJLFWbDLGppNvxpPHV0r83jhFchJFd8G6ZGNoo/7HrvlmW?=
 =?us-ascii?Q?zBhX2iBZD+yECOrGANXTITe3wx5aenEnp2lMb6khq3RJfMurmtX2A+xwPjHY?=
 =?us-ascii?Q?eylmp2qW8YwHGqaxT3JpYizvUG8h/jumqZKV9Na/e+CyPuvHUzJn8rOirG40?=
 =?us-ascii?Q?LYgrcXt7VXVYYO9BlREiMjXD4vjarLv58sKOlI2PBU110HNN1KG8E0QSI86l?=
 =?us-ascii?Q?NuBEFxls6VYev8Tnp5alhd+mtPIqK8QfIVcAMkdhOAVuM2O+FqCVpYnOjtD2?=
 =?us-ascii?Q?Uu6tK9Yfm5ByfKbc06jj7dwRM/3Aobi2OZT5Bysn6TfPNUc8jsKrLCouQY5O?=
 =?us-ascii?Q?ku7gV9qxAD5He7+/hC0uHhdyDb/03NmgNLxgS5EGBwv1di/1NSj9qSqNtVBZ?=
 =?us-ascii?Q?XxwhoiJwlgXFfuGZOZ9mJzNEpj1NdsP/9Rbqjf9jeYcShf/9Q/wD+mfxEB1u?=
 =?us-ascii?Q?aSiYsyI0rADSv6sJ3xQ1TC1wb8oSwCdUXftgQVcqcGkg455Qlh5YOBSBhS49?=
 =?us-ascii?Q?zPzyWZ1T9mSNnUpW5eciu1GIy7OR37fNwwl+6X81PKROIvRDMTfdeVqKMtHt?=
 =?us-ascii?Q?ORrN+8xgTHz/CxfdF0gqPEQ0QA6Q7kQgUUjKn9DzYqHwVrz9SueoOls11SkW?=
 =?us-ascii?Q?W1bb7jEvNaVJUIEOJ08aW4+jqRucP4wrbQsM5gMu3OXwXcMOcvipU9NrgzlB?=
 =?us-ascii?Q?WxFUYNuBf6QEWK8bSnJvsMZtyvkqmg6L5u+eNfXVzoYzY4VTIJE3+KbwvcfE?=
 =?us-ascii?Q?HYS8X6/szyM7reeiQa7Q4PGaEf7KXrtpvPYmeTD4WazGy+jtOUCi0gqzkqbr?=
 =?us-ascii?Q?uVeUWdLgnCJ9OL4U2oZr/nb9pry2dc4wP17ZfZDP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8407fb79-0879-46e1-472c-08dd2480c056
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 01:09:16.2225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16hRkcKGeuY48Jb7VwhxvIUluddgXpO2o9/0WpyrA384uI8iVDi9M6kYh6yUBhJQsxa21b7s01H+7nzSZ9v0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102
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

On Thu, Dec 19, 2024 at 07:32:58PM +0100, Christoph Fritz wrote:
>Trying to boot a fitImage on an i.mx7ulp results in alignement issue:
>
>   ## Checking hash(es) for FIT Image at 90000000 ...
>      Hash(es) for Image 0 (kernel-1): sha256
>   CACHE: Misaligned operation at range [90000108, 906d9b08]
>   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>    error!
>   Bad hash value for 'hash-1' hash node in 'kernel-1' image node
>   Bad hash in FIT image!
>
>Commit 41b2182af73e ("crypto: fsl_hash: Remove unnecessary alignment
>check in caam_hash()") removed a specific check which is not necessary
>for a Layerscape LX2160A but would have catched this directly in
>caam_hash().
>
>The actual root cause is currently unknown, so fix up input and output
>buffers if not aligned.
>
>Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
