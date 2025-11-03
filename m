Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB5CCCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 20:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18FA7836D1;
	Mon,  3 Nov 2025 21:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="R0XF5YOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B71D838CE; Mon,  3 Nov 2025 21:38:22 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D158331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 21:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqspLOiDWCLoyVgjXHcE+PM4RMxgE8V7wlzTmAjkv1e6FnkKSLF1cbBW5m+xYc9L8yToDlBme/Ne8Sdky5WJmwc/DePXwyxw3pS4NabPy/Q/tAXgBJ0po7p55GDFvK8CmslwxaXEJYVPhfQ/Doy42B7EWP4E9O763SiFp1TEKY7P+UYvkBcql66ku1lM2MkQiibgmzQ0W+nZRVCtFTUK/M39jvMi68PN3G3tZT5sf5BUvvVCeHdu6EskGHpYDs27cEp2Cy1ZyLn+4C2b/cG/u2JBmpOX9zgKZAIGggUhdhqLgmaMWAIuibtS/Cku84ZVdPu/QVg2oszP5Pk2Od+New==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHzfDk2m+ljtcxZqbhCBHEHCL+W1sCOzgsO9YIYQ4aY=;
 b=t06CkUuOhzOiSpR6y5RInwbUgirv2MsYvZmHX9K/rN6RxFrX16WQG2Mvn4C8Qi8TfKYipHc5mxQdQhwFZC0iUTlLxd6gzVJTffSw/OnLN+ica9E1VHGkoXGRB44d/vWyLlyAL77oaK2MBd1JkOmlBsEqRklABrvFQi6fPGMtsXdGefQmNwjiyu5SaI2JrljXrVDY3bW9ZOToiMxJB6VGl85FvTAUiqEZuEBU/w+YsKk+zNnfWnvwSiaFrgO7Xj4ZZzvw2zOi4wgeSZAH3Q/kIGMt7Z1BgMkt+xTulPg45d3dd3A083DtnXarKXgAH25yt/L5+ZMy3GQhg8QPkFwUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHzfDk2m+ljtcxZqbhCBHEHCL+W1sCOzgsO9YIYQ4aY=;
 b=R0XF5YOLaAXDUOj+4T/l86MtuZtJyxjXFKtBlnBnroB0dbFFxOPUa3VezscPmQpPgzdPGXhSVjQBYmo4aF21R1yNgS3dex5ZEhPdjXpl26K4X+k5157EesNefct+8HMHv6YxGAj9mRYot0v0WAoGgGJH4fYPrt5fkjR8lbuMA6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM7PR10MB3763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Mon, 3 Nov
 2025 20:38:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 20:38:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] cmd/part.c: implement "part name" subcommand
In-Reply-To: <fc2149cf-97ee-4ac4-ada3-c4797607a5ec@cherry.de> (Quentin
 Schulz's message of "Mon, 3 Nov 2025 15:14:10 +0100")
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251020121100.1742812-3-ravi@prevas.dk>
 <fc2149cf-97ee-4ac4-ada3-c4797607a5ec@cherry.de>
Date: Mon, 03 Nov 2025 21:38:14 +0100
Message-ID: <87tszadf7t.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM7PR10MB3763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd78aa8-e424-4df0-abb1-08de1b18eb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zjI+uur+fKFiufO5KLLSx1WUU+2uF6jAgxJhJ11RQ/DToN5plpPp37ei1Z3b?=
 =?us-ascii?Q?pKo5OaTQBepzu719Y1L7YGYvq2JbidN6bM3rBm0GyIOVR2CEsfTAYo6Ey0/S?=
 =?us-ascii?Q?U18USYdb8LpF9q+uhThGckI+l0PRXIvI9leE/ARdYpnU1HD22/XnW9RoQL/N?=
 =?us-ascii?Q?d1ThyROas2NZB+Rm5cwgyxKFLeFN6MGtMypqhl8Lf0I9Dip7ZXylCYozCOHH?=
 =?us-ascii?Q?omNUMkmGKbKv8Z0ClP3cOAYNl3Pb3D252JJQFQfCnM4vl44oPI9whnpVRWaR?=
 =?us-ascii?Q?5qCT6an4UWP0simkfxoBqtZYjf8rwv1xKu0z9sGrSdsaLjNDou0ZfVGXJO+X?=
 =?us-ascii?Q?xfHYK518gc06pBDKEisM+6aPvvsqeBYb1CIXkNXWNri9JKHQoVwMVX7lEXuB?=
 =?us-ascii?Q?CL8QQe28UoUPCNPPbgAACFl22DCYXSOJkZGlxSTOfJcQroJ3xo2FHSEy88+h?=
 =?us-ascii?Q?UrmhcovUoUmFnVeonF0eWXSRgYiIQGftjE6p/y4GxzAPGA+Eetf7MTucwxx8?=
 =?us-ascii?Q?LeI86sntf80pNP5YLmiyLTG7AqubfXCHyfwv710j6s3JAKq1ubosLAZWNhPp?=
 =?us-ascii?Q?WQq2heBt/9WjZVR+lRB0TLj3+Hul+617rm1TNVhwUOZnf2GZjdjJbo6krzgt?=
 =?us-ascii?Q?dGzzi1w+O7q4I2tbfDkux5DEn8QJRSNGXEXCS+rzqBn5AIM9aVsWXkzMQ6N2?=
 =?us-ascii?Q?Flhh2x/mpYbxdNisEJxz+5MUlKGOrVr0i4P3kjiXdtKPa7lJSFZAaim6MzH8?=
 =?us-ascii?Q?HsOAgef2Ts/aVgNwY2ZA0AA3Sr1Xz0GMwT2aC/I07YKIMk6hyB7lpWuUEmVn?=
 =?us-ascii?Q?dIEps9ENhtzR1/tm7Sfb+LLqwSIXV4rd3fOA2R9CVabIvfFVpuckAsPS1osv?=
 =?us-ascii?Q?1ywpPmciA/5XDVP8RPeBmFAGyrdiWWa9VCP7mGk76vubtpCVJlIiYGuEjowB?=
 =?us-ascii?Q?kHCB5vw2wIvqKPUmwAM5AAu8SrsG+x0Uq8vSMPR4Cyas5NTITmG1gunZFrVO?=
 =?us-ascii?Q?SrNQjCGBY3akni1phRvlKncWB4fHZwgp6fQOlj82d4nxA7YZnIR5OEb+faph?=
 =?us-ascii?Q?2TVPGiuM+Db3kQM3/EAKrnGlLumWzAnInk5rVGqL8aow7MvXQRrqfEWAtohC?=
 =?us-ascii?Q?VngqhoznJiFppPJ27vmiYXuHkj/fljPHvOfn0V2eECCFxjDbuV+ISuYrvslN?=
 =?us-ascii?Q?h2B9zolF3z4e9rzLZcqdyQA5jAjpw+j44JMWBl9+4NI01qGx7qZEztPgjbgn?=
 =?us-ascii?Q?3+BGTNUrFpT21iH8rIVElwtco76ktyaZtbph3FHteAWdplKdn+I81XsGcj7F?=
 =?us-ascii?Q?1iEXFN68Ihfj5mRE/7lU3IZp53i3e5yfyAJ49Lk+f1nZMtNNq/SWFAyhg/wK?=
 =?us-ascii?Q?xteLrc/yaD3B9o+RNwdpETjl/gBcCgjXS+9OOXU1WOz2qykhevZU8dLhwFfo?=
 =?us-ascii?Q?cb3+GuV9iLPG5aYvRrz3qXYQLQTMkL5YgsUjMIjBzkjgn5dgpLMdxuGNOoRy?=
 =?us-ascii?Q?rDBAW17dIcX2Pk1KKDcMNAhayNYJUl9EME46?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OS5v3MW7QvPibvnIVpPgGwRIjMjNduJj8aK5y8t02AKpAANrk4E1jpkHQbLj?=
 =?us-ascii?Q?kIle6F5sjJp5zkNGUDDxZ4OWLlfv+buSLtWbVaIxjsx2CkBvo9ihFPFY7hAn?=
 =?us-ascii?Q?6ea5RDN4y6KxnL1sEgNVWvqWUnoQpnrkz9Ecv290IaVRm/nGkZXDctiVTBvf?=
 =?us-ascii?Q?YPi2BZOYg3lQ4gPVVX/EoDgu5XzMIjSjb3wIvJCDsKBdZEhd8T/Jt0f/KlR3?=
 =?us-ascii?Q?ZwY3MUys+l9NCh0AM3YrvisSDwjbX2zyHWRoSa+UYv49dwC986u/XE5yD+yD?=
 =?us-ascii?Q?iyuy5+ybDEzWRk08otYk4l04DHRAPnQlW3C4jr9Br9BpB97NwnfAVgQF2Wjf?=
 =?us-ascii?Q?yTDaT9rW3wI1CJEUlQ2HgrOjMhIRST0bhg+uXGadXXU76uNNQMz+ZdNXTXhY?=
 =?us-ascii?Q?OKotfo5TmCC+5FqQRPco2NDb3Q4thBZerEwTTIuDCwAMYshtZih+U8dnTQ/Q?=
 =?us-ascii?Q?VhlwoA0sFI1P4DDkk7mhqa3Rzd9VeOTDPTrhZX8S0OqEmSlzpagTuHYQBJ3k?=
 =?us-ascii?Q?Gc8+Io/P1XOUpUmF1pwnLQSIfA3bivk1Zh6vm8/CTlPcmbPgbOHhF1x0gc6f?=
 =?us-ascii?Q?firuXi9dgQTXygHZNkaDlCYfI4JH+dgkDEfrXrSQ5qQVmKB+ot0M0Nvddsu2?=
 =?us-ascii?Q?wGJpEk/As34L/GZkJO+8hsvoZ+w99pLeBdf+1qd3B+Z/1gBTRdCdPAtoOvGv?=
 =?us-ascii?Q?4Kchlxd9NNBQC3wFJElepdh0mMQKA1ir4DFjV5wFJ2ePDmgpCuSSOkpyfDSi?=
 =?us-ascii?Q?onWztLTrK+scFAc2tb3pjujIVMgQQ4ytyleOkg7bAzncXiRiPrJZLVdnDYia?=
 =?us-ascii?Q?1Qa4Bj+YBClwbALKZDqmol00xDFD1NPXwvSrhU3Q7Krb739UD9pBOIGffBzY?=
 =?us-ascii?Q?aaI3eiGhPOrz5TlFdmh7UrXQn16D8dK0GEYHp+Xt/XVL/2WD8BWn6GqObrn0?=
 =?us-ascii?Q?I5lIWomWdWoQwuz7hPjUDhhmS0Ncai5jux6S2LPhSNkolUG3Qj4KGszUdRkX?=
 =?us-ascii?Q?/dZv7XX8+MlRCePFSEK0uS5WivijI5R9L2dydoUDHAlIaRPsAJdDyZxMYbQQ?=
 =?us-ascii?Q?9b961+jcpWKTRo9suqBR0sHyKwgZxtLQHbUEAY93t40iP1xyvbVOESp2mM2V?=
 =?us-ascii?Q?smN+4UQi2EmuQi9G0Sgx2YgCBXI1TGnXN5+Jb8QGnreVMAuBibkQE5xNGBdF?=
 =?us-ascii?Q?hiY+K+oyrXqoBNitxqyML9w7yL/XFI8cH8uGWPQQc3R0jiQYVN2r5S6QNiOV?=
 =?us-ascii?Q?HfmRVym7cjlAU6NzB4Fs2X0kEgwOY+Cs2bsdnwMvz/15cMCfZdYgo+7IAjhV?=
 =?us-ascii?Q?+FjaLd8jVjFkhe5giVfg/mQuT5YpTEStYkEZQAPO5rLr57Mdwei2owXOsJtm?=
 =?us-ascii?Q?Tkh4E4DkceaL291cvlvI1fGXB7nNU31AKlMFdAXyIMYWAZVv0XZhmqGX0Vku?=
 =?us-ascii?Q?TQFtL72xjkQzVgjjIzuMtFQvEpFJku8y8tv9yrrVskY2FKiGlynxZezzBQCP?=
 =?us-ascii?Q?ZeWZ9AerkTaz+WiaDlsYqTgBCutVRBo1bz0eJekQQZkIEYgFtt16dID0KbVz?=
 =?us-ascii?Q?4UAhkE++V9TbQq/wqMlB1Y0tgqahCiNr7D9UZX+KLafa4ESFezkDGnkTkZTn?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd78aa8-e424-4df0-abb1-08de1b18eb0f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:38:17.1294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ugyA7TX4EoxgkIaHhnvuX2zYSQ1lTcnJHsKwQH96ztvykUSgRIA5JMaqnF+EYlovWsu0J4pcZY+qbrHdYEX2qNZ6i08FF1M257bgi14zbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3763
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

On Mon, Nov 03 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Rasmus,
>
> On 10/20/25 2:11 PM, Rasmus Villemoes wrote:
>> This is a natural buddy to the existing "part number", allowing one to
>> get the partition name for a given partition number.
>> 
>
> Acked-by: Quentin Schuloz <quentin.schulz@cherry.de>
>

Thanks.

> 
> Reading the code, it seems the part command tries to auto-detect the
> base of the part number as passed by the user, which isn't that usual
> I believe in U-Boot (usually either forced hex or dec?), so maybe it's
> worth mentioning in the docs.

Fun story: I started doing this because I have a legacy stand-alone app
which is involved in the bootflow, and it communicates the partition to
load the kernel from by setting an env variable via

  sprintf(buf, "%d", kernel_part);
  env_set("kernel_part", buf);

and on the U-Boot side, that $kernel_part is/was used with various "read
mmc ..." or "mmc read ..." commands. Guess how well that works when
kernel_part ends up being >= 10 and the U-Boot commands unconditionally
interprets the partition argument as hex...

So what I wanted to do on the U-Boot side is to translate that
$kernel_part into a name ASAP and then use that name exclusively, and
for that the sane semantics of the "part" command came in handy. Except
it lacked the ability to do the translation.

As for the "[not] that usual", `git grep strto -- cmd/` says that the
base argument can be 0, 10 or 16 depending on the phase of the moon -
it's a constant source of pain to figure out how numeric arguments
to commands will be interpreted.

Rasmus
