Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7232C3ABD8
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 10:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1297C81FEE;
	Mon, 19 May 2025 12:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EPiuFjt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3D182A9E; Mon, 19 May 2025 12:28:03 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C75481E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ4x1Y3hP0mC4kBj8NCABdrk2Em+o5c5BF//4+KOM3jDP0evmqzNIvvETzzMn/CtvRt85xWDDGCp4qlY8WjaFFoo0ldgJk4ab8LkuNCd5oKRKzHhJd/HXAu5qoI/npT9IhLQtOHICkFqjFJ6kwXveSEn4ru5vqTpijXHXxGQ1E//AGA6bgJWaWp9p63TtlaoYwF9FxBB3faG1158GTog0gn33vv09D/PSRHm1euk9e/qONG5uNHYq0vj+NGj4vum4yU5NdQUtlFxwHkyK65tz+lYoI3xmmJqUFskPmJSezwvgfmfrCUBlBlvW/gC684ErfDfJkO9ygBsm+3iQHO59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVG+JFobVxfviih9wyUDuGI2o+1bWNeF3xzarXUl8PM=;
 b=MPb1pEtc4wR6ZQNkXmRtqsXlGqUBo2IlNHV3d/AcQZMC5BuJ+qFz/Ecsl7zLc1YRajh9U3UIirsdpKlPrTCE/99fgdyLcA+wdG+CocPnNKr4Y4nsnVbpE10ubLFqLvMq6tP8azH+aUk8Nza9TNWbKP6hTrg8CruKst5Da2pKqNzHEioz665XjDZ++eHYDGioRNTmn1TheWxJ8oDWoXVrb1jDhwz3rnRzW0yefffr72uaqqTxjHdnoXR+EtmmjKBhGjrWCw+NK2AQTmkxy8oPyL17niWVtkQiIX4xaRyo6CKCOx6WwjOya8YSwOPaAIUBliy6ZhHwSJmA8fMt7NF9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVG+JFobVxfviih9wyUDuGI2o+1bWNeF3xzarXUl8PM=;
 b=EPiuFjt5ygEM4o/2rnzwvT3zjYob5a0hgOcsibUEjAoyglQ/4q4f2ObehZgF65TS/V3tUUy1apUyzbo52c66uzpFCp5TD2ATfSKFhHB9khnRcyBlwNQ1BcgpnEK69cokEOeDDpoDR0d0Wr2Wxc+eYqvzQpGvI+dgDb6MdykEQz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB8061.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 10:27:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 10:27:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
In-Reply-To: <CAFLszTjHnxzTxGUVOkTBo6CxoZc3DxO4q8=R8_Y847g_WHWM1w@mail.gmail.com>
 (Simon Glass's message of "Fri, 16 May 2025 17:39:57 +0200")
References: <20250516125430.1361912-1-ravi@prevas.dk>
 <CAFLszTjHnxzTxGUVOkTBo6CxoZc3DxO4q8=R8_Y847g_WHWM1w@mail.gmail.com>
Date: Mon, 19 May 2025 12:27:54 +0200
Message-ID: <878qms51zp.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a8a8a-02c4-44e6-1bdb-08dd96bfd1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IeCYUCzzOtzJd3z5SocPy9YygzajLtRne1NXMwMTo1GxIrDIb8qFBY+EVK2?=
 =?us-ascii?Q?AGvAzXFjIUuZVI9M8p4oJx0tHJjFXRgg2XuDhQOUr1/fL7k+VBCuoVqH0ilP?=
 =?us-ascii?Q?TsGipRtKrmSoahQBXUxrFlvQ1CH0OopqWbrqr7h+f/5hQaBRDd920WzxcCEu?=
 =?us-ascii?Q?DjJr9JSLuad1e2MAa1ifM71wZ8y7J8ucnM3vTEcXCQkv7+9AtjEpfIDpdfXc?=
 =?us-ascii?Q?Vcy1HrClCpXmn9cumBaj0lMVq9oU99O+gg6S0N30Om7ZaDOZR24qtGB29FPo?=
 =?us-ascii?Q?AwxFney52RSi8HI0yHdV+Am1b4KIoDbbCXNWhHllY1IMHfcK+krze+AmPvb7?=
 =?us-ascii?Q?iB5tVCVNTqxNBplGASeBeQcIsJW+ORdEfLytZzuDGhNyHTLpsz/RgWq6jNz5?=
 =?us-ascii?Q?MfcMXim7FFgH28amhrVB1tbdN+28+lNeGyJdktONtltOR66j64rIm8Ee30sV?=
 =?us-ascii?Q?Rkukcg7uLgvqkDpptlYzwP51zHHH5MsnAUAqUswfESISTs9ZUQCh8nIbB/BR?=
 =?us-ascii?Q?C6qGiFoTSwAri7NJFF+QrxFiQUV8KspooFEaJsr8RBN/9Q0F51r4an1ZmxP6?=
 =?us-ascii?Q?K1K4T5SJE8VVmVgluDL3LPS+r0ncskZFe5JyzIFgblpQlTTKrB4eF3l1SLKF?=
 =?us-ascii?Q?l8gsjYYdmjUsOtK5DI6PzTYD8qAm1LH1QoeTl2E6G0VCq92mZkT4DvJVhOmb?=
 =?us-ascii?Q?feZlO25V/tgPxk69GSOs+ywnLKQtXlZpGIMf+lPSS7lcA0SiiQV4JuOVL2ym?=
 =?us-ascii?Q?UZyREWVjrYcWbkDp/BXgaL1+P182rEfuVdO3qJQnLXqB9BnIvGqk8f48zsHL?=
 =?us-ascii?Q?zSBiVKkXkHA+0gSeLFJrUxXPo3JMBN02z7PoFWS0QXTDeRCB/OR+SJWsBv3M?=
 =?us-ascii?Q?AFnlbmNPImKEFW+FZf63Dl6t3Xe/C2ivSECI3a/2NfMoQl2kjiJ0hUojiEqv?=
 =?us-ascii?Q?CIgEHd+sWYlo+HTq0BRCns62IKeArViouGW3JgS3xPL+gVUVbLW2oLLARz+V?=
 =?us-ascii?Q?JkdVkHI7X19DQtqhZ9fPsVlAIHgM1j/T860hggV4DgtiK9GCPDeDYKx2b5mQ?=
 =?us-ascii?Q?K8Z6YRaazlBbxPGUL++ltb9WSWOiBeh9N6iLNnaNeT9/X+5vr5G0HWay5ANZ?=
 =?us-ascii?Q?fJrAOZzBVso4HHZtIF0c3Hb5tBEJi6qOsqMSyEpwkbWbVna3w2OZDChMCfyW?=
 =?us-ascii?Q?KdgCpBAnl28Sw+8LLGRiMI6XNhuWaRqJP2M89y1b/Gd6BVN2XmwflpX+J+Ug?=
 =?us-ascii?Q?5VM0iWnkut6+gxxSQWYwbtaN4BaLYK2wVrtPHCUpTYnhgsJlZzF2ydwokkwf?=
 =?us-ascii?Q?jV1oFT2bqzx3IynCfwm+R1f71Pip1o2J1EyC9WM7s/LQXkVKGOZND1Kt1IVs?=
 =?us-ascii?Q?B2m/t8PVsPIoYCE90/7t7iY+tR0Nzn/DWYQnOTrH/A5vlS5sHZqqC9DDt+RQ?=
 =?us-ascii?Q?s+VY05s8ZW1hln4/XqiAomkfD+LbGxOayZUp1rmxaJlFi6pVMY+Tjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHlXOEVx7EOt5aTB2ZQ5wYlzB73aWTnx/97EDg9O7JJAYlaJs3K8nIWVcO35?=
 =?us-ascii?Q?sf5K5vmSnV8gZ3SIPLccY1VBcnLYVfUuGl31pxBE3ZwE1kzgrvFmRaiyt2Mr?=
 =?us-ascii?Q?EyX5hUotznmkki6WM5mJgSzDlDwplDYeyudDIWUNGDLdkjc7SZT/QJ/FsG/x?=
 =?us-ascii?Q?Oy0QK9Frig5rDv7oXpmmnEu4Pb1OaWgaTh1ty4vsoMX+729+VMu+UMCIiwkT?=
 =?us-ascii?Q?2jWnMMqnKrkXIOng4PuE+sCHTy/7lKe/rSlPY04mFlr+HK7vxuhiAzYK+JB0?=
 =?us-ascii?Q?8SYFgpqZS8omrADkezmn96q1txOPB9eUMwN3zDhkNCdfAQ+kXOUaA/1hoUkH?=
 =?us-ascii?Q?kfnmEw6zpEL1ry9fBs27hksex5VQsC22+PwDgXNWQfoDrnFOkbOTvortiwUV?=
 =?us-ascii?Q?yOyceiZEe2SN/rTUacgDNZmgTToCR3wQjYtKvy4Vh2gadmr6jzKS0/qeP03o?=
 =?us-ascii?Q?rI1es0Mwr9uz7B337nzToX9axonbhG5uP4orh2FcizoKPDyBcf+3KQTSwJeg?=
 =?us-ascii?Q?IjAl0uu2XygxndrcnMYnPH5+1Ufa2SPo//UgeVXneKOmHzCvRFisRbl3StuV?=
 =?us-ascii?Q?8Pr8xKDaFM3uSnbexLTAikzGdDTnNTNQG95AE3a7DGLTBEgU8aIwwQMj0U17?=
 =?us-ascii?Q?oJVKtXk+d82vjaaRxDxoizRW+hdMcnMQ/Qo3aQ/Ri9uM9RWtgw6vwqjzLbrV?=
 =?us-ascii?Q?8ho5Y6mG0Xj7i/Q0tcPFDPpUpgOjsEv2ByOIVPD85vRD0rv9h+ltVS980tMO?=
 =?us-ascii?Q?49JSgcfccpxTNWHTWa5dMaj3mmBPK+UTpZZKku+tV1C78kksSNuFY9k1KsOI?=
 =?us-ascii?Q?O239S9OBQNFqwKc88gQqbi9+nGfAf3vcoELybvWVdBwU/EJW0UXWN1fiy2UJ?=
 =?us-ascii?Q?QEJQPYjAO573BSA8A7fCc8U2/ljsyfMAn9ay/We2RQDeOFxi6QHdxs2K5w5o?=
 =?us-ascii?Q?YPKD8baQGK0L/iObLGibj0fWJVGaPrqNCZ39iFujw9mZMGQcmmT8uo0ZOjPw?=
 =?us-ascii?Q?Kp1HEUTgpydWhgkwyzTOEFw33jlqTG+EQWg+0ZIsVU8Z0GNljvWeNCmB2OoA?=
 =?us-ascii?Q?3/BUbLwK0OKBG6h3Hh1AVQZ4pjlqe8v3d9xa3Wq+lxqfar1+D+RTJBafeiN7?=
 =?us-ascii?Q?T1r7QDJ6SwJWydm2L3eYrsRqxNniiSm2n63ED0aXdWr73kuZ6BzBIJAOWbic?=
 =?us-ascii?Q?cbunV4Sn5YlOTk8nQwWsXN/RAc47kiLJuN+mEg7Bvy3prHBOF81RtPdPCEZu?=
 =?us-ascii?Q?Y6Ob89w+H4XXjoLXrGiqe70sgPjS/la39YZPU2xos9+DoXzpZTA0ZiK+WwrR?=
 =?us-ascii?Q?LqnMTcwwdqWajq63NrkyvQ1X3fP8w09g+Y4B3ZfMVx7Gdl3tKQatugmJcmlz?=
 =?us-ascii?Q?CgMLg3vhtl6PJBvP35RyAj6NgEaC5uV/JrgfKLHDbWGevyGl7pnq3Wds0LGh?=
 =?us-ascii?Q?Udqc0dDjxnPKbwuorf9kPS6RmZx9qr7gp0Wl1HB1iSugik04ipY11Z62BJ6e?=
 =?us-ascii?Q?1CExMPb9S8ftiJoCzqg3dUOTEiauhgGM+0qJhe6yyk8h+VPFJByZNSo6Ybvg?=
 =?us-ascii?Q?aAeWXAZNJO+MhASvs3W7VW+DqTmI3c6n8ujj0kDWxoVO7JiJk+Xswr6EsKK0?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a8a8a-02c4-44e6-1bdb-08dd96bfd1ea
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:27:56.3338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLGAodA2HkO/3JLQiqjRVxrxlpI6TvItX2dbhofNzZaEupqfVs5r8EnLjvtdXlVrdoMiT6xDryGxfd0bgXBkwZb8f9H/fmQD6V0I5nY6weM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8061
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

On Fri, May 16 2025, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Fri, 16 May 2025 at 14:54, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>>
>> While not perfect, we can give a reasonable estimate of an upper bound
>> on the necessary extra size by simply counting the number of hash and
>> signature nodes in the FIT image.
>>
>> As indicated in the comments, one could probably make it even more
>> precise, and if there would ever be signatures larger than 512 bytes,
>> probably one would have to do that. But this works well enough in
>> practice for now, and is in fact an improvement in the normal case:
>> Currently, starting with size_inc of 0 is guaranteed to fail, so we
>> always enter the loop at least twice, even when not doing any signing
>> but merely filling hash values.
>>
>
> I have no particular objection here if you really want to go this way,
> but it seems to me that it would be better to have a way to determine
> the size of signatures using a new (or existing?) API call. Then you
> can make this deterministic and always correct.

Well, I'm not saying I won't revisit this at some point in the future
and improve on the heuristics.

However, as indicated, it's not just a matter of knowing the exact size
of the signature data; one also has to account for the space used by the
"hashed-nodes" property, which of course depends on the number of
elements in the sign-images property, but also on the number of hash-*
nodes in those "pointed-to" images. So it ends up being quite a lot of
code to get it more exact.

So yes, for now I would like to go this way, because it's a fix that
works for my use case now and is easy to reason about, and should also
be an improvement outside my use case in that it avoids at least one
iteration, but possibly many.

Rasmus
