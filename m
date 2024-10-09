Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF401CF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 11:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 576E388F4E;
	Wed,  9 Oct 2024 13:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bocKWg8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5177C88F6B; Wed,  9 Oct 2024 13:03:11 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A3B388F4E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 13:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuFj5m+WC3agFFfaxNJ/fsJKtxJQJVRt8u4K+TYE674ubAmbFUS8mZWXqK7mZfEC9Dh+/i4OdXRztGPMJBmtzAkk7W0SS7fDcdTFKrCPplR3XPZx4prWvChLY8g6oshxWF8Dkk4jK0ya8IzHn7WrkgwREKtYZSKyBUwhmIf5g30yMxsN/rEXSbwXq6BkNsyKiXWDCE3LuUgTSvvtu6OniUWp3fGaB5IylKnqYmgHkHBiNSqSbVlbqYhgXccaYRO8iWER8QPM8pxr7e77thgS1/5pMFv5eZ71CFJyOyjmFPeS15eB6og8PhpsZi5i/vwdNo0MPXWmOxHz/zFDKbUTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S9RGZ5bOVr/qUgrXqAxAzxLN/JDiKN/Vn2SzowxtfY=;
 b=nUW3SpcChO2BX8OJeB/DfFf/IaVe9Z0OjdkdcLrgayIPkV6JzSSSp47i6+3HNcHOeIkzn9vtGgG75zuk6xmXyTLSabplkq6ESMjsI3nNeFOQ2zLjNEqBfRrf0D/J0H9vVZy33pXmdBZRzc6t0WgCeoZHNUJbUsMnUhuh+rag7rYB0x5shKltoqaxZnGoUaFAY6sFl+p96g+f5fIfzGoVR86O5XlbOYfx/i9yIsRbYCV6iqSZ1rD5g4CkdSIIE5ohJtyk4rcgixK94Co/BzAytSimud5jGAZTCI+aIPPeydogvUoO4OAHSwbC0Ahpwx/grfalF0HgFI+DddZsLGG4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S9RGZ5bOVr/qUgrXqAxAzxLN/JDiKN/Vn2SzowxtfY=;
 b=bocKWg8zzLi7MUVn5vZxgxHinC1f5kqEZ2iD4JO+i+fLso83p3ingDkrUgErk2u292pdV9DimeWDdmLqFQjbS5EE/jCgSHUn5eH6m6mj3W/xuX5CoHknzqkarHFMfkasZvEPd54+91k94HgvmdSgKWBnr+kDRXiMuXKZbmSQ9Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 11:03:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:03:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Stefan Roese <sr@denx.de>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/4] serial: fix circular rx buffer edge case
In-Reply-To: <CAFLszTi37m5b1T03NnB21OTBgqd1dre+o-6AjjsQvUmY4vnN0g@mail.gmail.com>
 (Simon Glass's message of "Tue, 8 Oct 2024 19:51:06 -0600")
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-2-ravi@prevas.dk>
 <CAFLszTi37m5b1T03NnB21OTBgqd1dre+o-6AjjsQvUmY4vnN0g@mail.gmail.com>
Date: Wed, 09 Oct 2024 13:03:08 +0200
Message-ID: <87a5fd5yj7.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::32) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3687:EE_
X-MS-Office365-Filtering-Correlation-Id: e4925548-d683-475e-2598-08dce851f437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?skif+Tyy/LeINrGxKAIMEelhnDxie7UkwIyfasQGp9dVZz+z4gXigNMaPml1?=
 =?us-ascii?Q?10pnwdVzB17hSsMFpHxAARSIAjUw5WDynyoIseqWofzwYkfla6e/Hx6gywTA?=
 =?us-ascii?Q?/Z4gsmR2ltIf8SQwJjFHWggV2GHI6kWUdwhp86h3JhN334ZBLNzWSuc8X1w6?=
 =?us-ascii?Q?JGclSe9BnqPcy28a8jcuwcF8L8ZXuBC6abBUYwDW2ZDhWs0v8k2HzD2qCM7h?=
 =?us-ascii?Q?o6rhkB8kww7MmF0RTEbVeYx9kwEp7H27JvwHJPlhONbV1reCBJBQGUHs8lQy?=
 =?us-ascii?Q?+qgS6WEoetDWbWEFUUR+H820+6+Fw72g7hshIklOTPPH5tkN5WKNNzDo/FQ8?=
 =?us-ascii?Q?sLBmHCcoXb1tEKkrAlhUfnIAxZoQVRZWfeFMY8ZY0HUoCOMOtbSAVsDetm6Q?=
 =?us-ascii?Q?Uob3i609ni6f/6Whex9WcKNcGCekE/zrkRuTMTlMR7D7zvmlq2942MOZQRcp?=
 =?us-ascii?Q?0qTi7xSbsGsIItBEBrV1+YNf7c7oBEaDjIIEfaFsuee0maZEdcVAQg+wP/lY?=
 =?us-ascii?Q?K4oe+vxD4L/rgBTRyjSfDFpP/fyjqRBALUBObBhfD/M4jbAWrV+JPEqT9cWC?=
 =?us-ascii?Q?nElLZYSs0dsRhSzctCzkDePFyTEmu6dMFqE+t3uYQfyGGHMjQa9dZjesGCIJ?=
 =?us-ascii?Q?AZ3XAmxz9jgvq2BWXk6KjS4d9TbYYtVsjPW0s7/FOh3X4QphjqS4wlylsSzN?=
 =?us-ascii?Q?ih6NoSbxny+2ECM6XeEl2ZLybWSQl+lKb1XPBkp+Nyh0D+rHEd4K4k5Hp530?=
 =?us-ascii?Q?iw0SijlgWrTojuQ3jVGfxvGm8yUswiUoTy0BjYeJ4UUI6i0ghsmyQ4Ulga0A?=
 =?us-ascii?Q?lEIk/NQWrlUIVophfXh8ra8pyVv8LKSiB/lMoG0r19iKdokCCeEHdCYZiJ+5?=
 =?us-ascii?Q?HB5ZUBnE9Wcwtycv504mhwRhr6i/9TkiVHxP0WupLtZYLcqDZkoPmNa+5I7O?=
 =?us-ascii?Q?ZKQP+IA3NDvDhfwUoPV2mKxXc3lw3Dr8x9D8RsogRDWJP62OtAneX7W+YX+i?=
 =?us-ascii?Q?uc47r/Z8ePmmmFMOKaBOhUot4S3YAs7i4aHsSn/uZ0ad51lHM10JppXMOPs1?=
 =?us-ascii?Q?V73rw7Beq/Ei0lAXp71EtXWwn67KPCCuB5jrIRZUOOz/sdC2IsvIjf66m+7D?=
 =?us-ascii?Q?lJmgTSXgl2I+uAmTQ89JybxK7T+AKqTJ3eYvQpTpP1SaKGNF5roi3N3C38vo?=
 =?us-ascii?Q?17rpyCPHWMMa+70KcRXxztiocIpPlM0gVoSeFUf93AJz2vQPdVHBHL++2Z1Z?=
 =?us-ascii?Q?t0VpjP6hLiQ+ZBXOPcUW+Av4uFO6If8H2pYeeMfVNcaj9F0q+tMwFeRvKGeB?=
 =?us-ascii?Q?JGKWvNVl3as5hQMAI4X1VExQDAlsjsLPhUuMsssB7T0srQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUqhUQjEzn9nif7SXfCNecG1Rx8BmedcQYsd3dlcCagDR3N/AnXipX3Bxt77?=
 =?us-ascii?Q?B141GnQ5AWv7qg7tsvOWW/8HLW5i5tlHb0WiYN9gMMXTAbFfl8x6IsLhBUxl?=
 =?us-ascii?Q?HiZ+O3vU0ALanM3A4PWNz6LBoWZ3/Nz5xC6FcohNpaD+ITIjKVFpImuwIDPK?=
 =?us-ascii?Q?eizolevxTL8pBAK8ZiWT8iFXXRS71vkaoXgRdEN/CKGwGTnmfpMGE4FbcVUa?=
 =?us-ascii?Q?3CIRa4Qx2PuQ5J5wuaAWSYORnCKeip4ka8gRdFWncDTcZkP8c7upHlZ16ADG?=
 =?us-ascii?Q?Ft90IdudntHrxn+hAhA5DCoENt6xN+CHi4BqE367Mim4X73DSqiDoCGERtID?=
 =?us-ascii?Q?/wQioj3O6FZUbkTTg+FXz7IQadQ2qwINHrB2T5VV+0lzK07IcvNlx8gK64Uc?=
 =?us-ascii?Q?TKlx6OVnUmXnYHFxBMFbvIWA/lg2/dI0UpMtYE8eu2bI5mK2k4qw5X+/Vd2y?=
 =?us-ascii?Q?dxcc5Nbvzhi2DQeZLptOKc3vqP3VvqBW01kGiM11At4NFNvwEmeZ4qcYrBjR?=
 =?us-ascii?Q?DnojouhHoRTxAt/inlIio7Edhv/ojalY9kSJdzxGqr0DFcu6ouDSytAayXWT?=
 =?us-ascii?Q?VcYIA0MFh+ryjI1VyaWykB0UP8Z+2bb2ca1C2G9VO+dsGI+XLCDZ6IzLCKTP?=
 =?us-ascii?Q?OouPFcWK9OBAw7AxL+tSYghePxgl5nTRXLVef6+DA/yIXECCvqIUvTQ00F78?=
 =?us-ascii?Q?W05hd4OFW+6H8wbK+XNbTUzPlIaHDjrlnXpJteG+4o3u/5YY+ugRYKnAmtX6?=
 =?us-ascii?Q?zoq30N2+ytvvecXFcz6zC8IqD7A5JTeGyhgh+bHS8nXvkYezoZvLu9gyyT8u?=
 =?us-ascii?Q?z1Sap8lP7p8IXeAgRgtSQ/CIWzo4WkWRNGTWlwNvm0sdiMhFlk9etGRlsy9m?=
 =?us-ascii?Q?0NetCgAN1oUdyD65xupPkpDGAMr7An4burUu1cdvRrn72IEge7s+LeikJ92O?=
 =?us-ascii?Q?ryBLkRJZq8+okFAmCwLvU4bYMxb+acAn2HxxTXnyLiNBpVTAP0FrIuVFha4L?=
 =?us-ascii?Q?Sl4arJjBCuyBngsjZqTFYsnZ83oLtcXmWIVl2Vuu6lMBKQKUeGIzJxHOV7Ma?=
 =?us-ascii?Q?P3TCbTpOXbFDm+kI0v/ggrpu/mH50nzOrdoKGhqopdWwpKlwAxMvqZZ9QQSe?=
 =?us-ascii?Q?3WBvu5MwUF55/uDKa2lH8HqombYwV+m6rPOYH3JcH0B/A0KXwk/YIhQcFacJ?=
 =?us-ascii?Q?OdSM0EF8kBgH9vrZ2D3Bll6Uxhm+6VCsMMgGQpdAFtUjmTxGffKzOyv+7hjx?=
 =?us-ascii?Q?KDl/VaHgj5D9yIDbzptIex4mFx1oO2e0nJfYFRfgWvgMXBgv0nEpOHyr7PhY?=
 =?us-ascii?Q?GI6OLO0IHUcuMFS5KS+bbfAz5Yl2O6pvErs4QiCA67MiIgbrVk50y+hp16HL?=
 =?us-ascii?Q?uKuwiC3SiStlYJ24OEXK5fEq0l3zAKMK9uiVSs8Kl+9fiOjk8tTBB54yyD0j?=
 =?us-ascii?Q?s4FjTRsjJoatMuglIgh32RiUqO32PlLZybOlTOJilYoPax4UH4NbERRrwKKR?=
 =?us-ascii?Q?YpncfblhUHkRNIVvmjZk3Fs9QviaeNufrK5X/LCIJlqLVw0cljxoF5PU50q8?=
 =?us-ascii?Q?G7429j2nU/8rIX7NQLisRg5BE+iPl9Ipaa6ghX5o4Ep4diREQyrLYgp8RRta?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e4925548-d683-475e-2598-08dce851f437
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:03:06.8338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAq++iiwOpVIr4jKp4EjJ7eJgYA14u0if6tt1FzksW4d8fuLjNkFg9hOtuJmtpnMXTIoCPALAeRkzaNx6fdC3g0pF0y55IaMeVFqRK44hNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3687
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

Simon Glass <sjg@chromium.org> writes:

> On Thu, 3 Oct 2024 at 08:10, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>>  drivers/serial/serial-uclass.c | 10 ++++++----
>>  include/serial.h               |  4 ++--
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Perhaps we should use membuff, like in other cases, since it has some tests?

I didn't know about that till just now. But no, it seems to suffer from
the same basic defect of losing one slot, and while it may handle it
correctly, I don't like to introduce more uses of that model, and
open-coding the single putc/getc that we need here is really not that
hard.

Also, which tests? I don't see membuff mentioned anywhere under test/,
but perhaps it's implicitly through the console recording testing?

I just had a quick peek in the implementation, and membuff_makecontig()
seems to be buggy: the second memcpy() must also be a memmove() (suppose
size==32, head==30, tail==10; then the memcpy() does a 10-byte
overlap...). It has no users and never has had, so it doesn't matter
too much.

Rasmus
