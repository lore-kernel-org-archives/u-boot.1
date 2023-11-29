Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB4C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 15:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F5E87691;
	Wed, 29 Nov 2023 16:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KR582Lsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FBE86DD1; Wed, 29 Nov 2023 16:34:37 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADCD87753
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmPzSf8SEPzwGmWW+ky0T3k5tO3vO9CG/MFm+abfrfZZFOy2EEQRzT/vJHwpWgdS00gNNTc6Zj24N1EIogCnWchY6sZHgxYDzjk3du3OWnaPntnkcr9a778qNGwxzd8kLs0B08T+x4jD4h0GrY+9RTHovdMd/H69PEuvqxj3GjewkApfN4brvL+9UzdpkamvT9BLiKmUn+s4cc5wdaX+rE2QPzyHYGtX0NMUcMUPeVja2JEWmJ5cWiKwSo26TIEDQTNSZIVyF795IPBDeECTWcvJ2TWh5qM4vLSL48EZ2UU0GObj2i1W4F177PPq7FjrvDppANYwkmDys9pgStXX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCfLhRxoZmMiqmli3fTnSV/tqpb974WHDdNo18lUKb0=;
 b=oOzKtPO+hNp+jhfxcNBJUG9ONtKN7kVKyt5b/s43wajaxIhBExfqzIn++uMlr4WQa1p2WWLIeUIPoAhSk85N8GQ3NIrGPmvD/jevaxfJuxwEBMfC0dVsZLWfyXq9e94gEVH9JmBgolvoXn5XZR8pNE6LPKIsa0FQteQ+UjoSyrlJ71Dq/RqLyVIJ/GNbQ3aPVpLdT405Y1f6Pjr7JHZkypjmE+P3Ip9Yd15YAmFRLfRf9v6Cuz0d9WvjSkgCz6TQrZ0916/PKfGIqrj+2iEOhW4MsM0RKcgJrLiDZlPswnePAxAVbyejsqPeV/KSYIKmCg0fGTZ0sslmvLQzaaWBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCfLhRxoZmMiqmli3fTnSV/tqpb974WHDdNo18lUKb0=;
 b=KR582LsvCNFU9yo8CsOuVC2z2qZfML6w+HoUELITTwfBM/z360CAlQ5AxL/KauXRng14QsSC9ncBtvLpDF71+Oda56iE/ehDXENE3bdFgT1185CG4euaNAhlVSQGCXORJlcaHzOjqXrOFp4dR1cnYiD5eSk4kseWmq4kBds1KwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 15:34:31 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 15:34:31 +0000
Message-ID: <11c2e4c1-3b1a-4c19-bdb7-be61370e5262@prevas.dk>
Date: Wed, 29 Nov 2023 16:34:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] led: add TI LP5562 LED driver
Content-Language: en-US, da
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
 <20231117113811.149329-7-rasmus.villemoes@prevas.dk>
 <20231129152311.GA1004509@bill-the-cat>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231129152311.GA1004509@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 371004d9-d8ae-48ec-b103-08dbf0f0ae62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkrzD6nBpgxzw7mPZS+LocXnYrB86miBv4dI70EwgV6SsUSZ7d247KD8+LMajynmzpzq5PH1cmAf+PyzTExKFdeNKr9MjE29XrC++TEe8V5IJ7gWKoi1vmXt+vZieQAR9wJXZRZjEbn4p1Fsl6oU6/oi/ICcKYNziEJolucvNlB/ISR9MFc3r5dwzzR8CBexFISQkIuEWiTbAlPIpPOX0++HaS3MEJwaJKcvBdQ9J/KR+ZIm6RZK3JII9ZMR8I9pDepNBl6i0LTTcS0YBb9f03gAXqqd7xoqjgj1Qi4COAwNFTAXx6lhxGBvPkHoQJGyx1KUxupEJSKPcL5T7w2sawF0bJ3A5PCd4i0LsOkJOQlavegKUNwwj7gKnnYeHFeqXQjvvOtpORZTteCcgZvhpb7E4NVnPSeGRwP6jDqEgA9/8m0ZfKqpGBOCzaygHkLu7m+nnlMNY2qDPquAEKqgWxNCsErHEyh26xK4vXbICv4jp1PQ76aKaOy32XRvgGVWz5doeNs/U7yfC5lvJZ9n0F6JZ/8lTZU1O1gpiaVrBxZ2OYXfA5u3khAGdScgRpnZUv/Gay2zIi697KzT/K6USWofgsDvxqqheBMC2klvtCfKg1XgAhnEQqxrW6/kGG1trYbdaBXI4bLNSPnVpZNzcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39850400004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(36756003)(86362001)(31696002)(8976002)(316002)(6916009)(66946007)(66476007)(54906003)(66556008)(41300700001)(6512007)(8936002)(6486002)(478600001)(8676002)(6506007)(5660300002)(2906002)(4744005)(4326008)(44832011)(31686004)(2616005)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhuSlJxbWo0TFNEdVBIdXFaeUNwbkxWaWRHU3RDakx3bnlCSk9abzJwbFNt?=
 =?utf-8?B?YldWZW9jWXdYTGJDdmxaTTgva3lZL1FSRDJyS0I1NU9mK0tRZXF2ai9CeUJa?=
 =?utf-8?B?aGk1RTNPQng3Mmp6STdLbkpHOG1QVDRyY2VjSUQ0bXZGK3VIbHpGTktxZVY0?=
 =?utf-8?B?c0FPK3d5c0NvYUlwaTRGSWxobEZGaDNGd3pLM2tXKzNTd1VFRHZ6Q0ttYWRZ?=
 =?utf-8?B?dG9SempWbjM4dU9jTW9WZWR6L0I0LzR1U29OdTVrZTVEZklZZ0M3eEZEVFhW?=
 =?utf-8?B?akFmTnQycEdKRFNCRmlOM2pvWWY4V20rMVhNNUpXV1dJUVVKejd3TGprZlBj?=
 =?utf-8?B?V1ZVTWQ2RXpFRHVvK2JZUFV3dHk3VVBpZnpmd3d1VEtGblBUUmZyWHNCQWVP?=
 =?utf-8?B?UU5kVlp0am1qSGo4b3NpSnpOd1J6aHEzUlU4MXp3QzVxVkwwaS8za0xrcjdS?=
 =?utf-8?B?UTd3TjA3UTJUR0pHSTZJaXk1TlgyQTlRWGJBdjN6aElqcVVkQTlMTDJlb0ZU?=
 =?utf-8?B?ZXE3dnY0OXEvZDRsWG40RzJiWm5aNDBJaUpPNDQ5TzJnUnBzbUZqbTRmUGJN?=
 =?utf-8?B?MEI2SzNSdSszMFB1T1VxZEdUczJvZmNGVHRndlNTNGNrWmpLeStncWp1MEd5?=
 =?utf-8?B?OTN0ZnczUWh2aFVTc2JHckZGMjlqYmhIU25VbjZZUnluVXkwN1RUNVlwR3Vr?=
 =?utf-8?B?V0d5R05xdHQxMitLbUpzRG5yZzREclVVeURCQlFnT3NaTmZFS1EwMEZPdzJl?=
 =?utf-8?B?ck5Wcno0Qy9uVi9zMTBqZHE5RGZFZW9nMTFrblQ3SC9pQlFWT0hRYzVvVmZO?=
 =?utf-8?B?YnY4eVd6RUZBb1dTZkwzSjV6cWozNWdiUEhiVlJHL3RsMkVCR0pPVjRrcldQ?=
 =?utf-8?B?R256Ny9KSmtJTlQ2TDhhTlY1UmpvMUk3bFRma0xYakR5YUpXaTRsdFphVzla?=
 =?utf-8?B?bEdibUhZQWZ0L2FjcmdyUHpqWW9RZSs2K21hVGYyRnQvZWpXeGJMcVhwY0Ex?=
 =?utf-8?B?NGlWLzFMQk9FVkw4ck9PeDBEV3M5bmJTNXg5UEF3aE92Q1NqWTgvUThEZzg5?=
 =?utf-8?B?YnI1VWphaC9ZL2kwYlVtTGJKZW1XNVVmdjFsTFZBTnI5NG9pajdKMWZtM2gv?=
 =?utf-8?B?d3F5a3E3c2JzdEFJdXp0VDQrV2NUYUJadGF0aE9tWWtibEVncWpjaTFReHNa?=
 =?utf-8?B?ZmhqTzkzTFF3U0YyRkVwakpLdEpoRlhONWJhMnlLTk1mdk5UTG0veGIwd0xD?=
 =?utf-8?B?OXlickpGRkRpSHhBLzRnL1paRmxicU0xMmV4TmlhSGh3MW15UXd6ZHNUTm5j?=
 =?utf-8?B?N0EyK2p2NGp4Z3pxVW14OWVhTER4cmdWUG1ia1JpTkk1eFdQaXI0clVhMnZs?=
 =?utf-8?B?dHFRQW5iWWtRMXF4elh2RXI0dmF3QURCalJqUEpyZVpYb0w0MWNUdXprdVgw?=
 =?utf-8?B?V0cybDZFaWJHM0NTOGZGdUtuN0tLczZSTEswNXJYWC9zbHJDSmdycjVBQjVl?=
 =?utf-8?B?Z3F6OGp6QWFzdmhZTHcwZ0FnZE1ZT1pWT2t4TWh3ajJKZUNnMlhDOVRJKytx?=
 =?utf-8?B?dTY0cnBEdFFEQThsVFBVRk5ubi8zS0x1UERLaHltaWlVUUFkdERhWTlvdW1Z?=
 =?utf-8?B?bXp2SmhmaWpWaEtJSXN1TzdFOWV2dlg3bTZIQys0Mi81ZURCMlZFV1g3b0NE?=
 =?utf-8?B?ZDVyVnMxM2V5L2VjRmNsNHQrUzQ3RDk4QmpjcFNTMFdhR1NONzNxTEZwRmVx?=
 =?utf-8?B?ZDNoYTdHMGVSMEtHSlZqaGE0M0JoNmgrS25YcFd3L0pvTHIwdHdpaEZMRGYx?=
 =?utf-8?B?OW1lbjlhUllSa0RtU1Y1bUhQMHVvK1dnSUloTkhraEdWYUhpMWdWM1hiUVFO?=
 =?utf-8?B?aVUzK2c5TEhwcVdwdEhhVnEwTzBQRFVhU21xa1EwN0tzc1NrODV5amhCRXJO?=
 =?utf-8?B?K3lNQ24xcDlySGxSZ2hQbitsVDZabUdXSWsyR1ZBQUk5WWxUUHFEY0Z1M1gr?=
 =?utf-8?B?Mkp5MU8yWm0zRmlJa0F2a2tBUXYzSEZjeWo0bTdTdkR2UmFqTXlGbkNoSHFV?=
 =?utf-8?B?NUJlVzJocFRiRmJ2M0kzd1UrME9CcEtiNUpsTklxZVQyWFcwYTNPMEsxZFFX?=
 =?utf-8?B?aU94Q3QrMndSWmdRM3lZc2QvR1BBUXNyMHBQbCtiY05XSlVqNStsbm55L2tI?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 371004d9-d8ae-48ec-b103-08dbf0f0ae62
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:34:31.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMIF8kZB1sn3sWfMfvqRHPdQEaFGvtpHNEjDSVqCBH77g9PYAdRjLTEeYlxLgIuZ7QpiIpUV1LW+Nh6QZH4Or8ZbPwHLYD8meTJZwyhSaXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6221
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

On 29/11/2023 16.23, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 12:38:11PM +0100, Rasmus Villemoes wrote:
> 
>> ---
>>  doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>>  drivers/led/Kconfig                           |   8 +
>>  drivers/led/Makefile                          |   1 +
>>  drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
>>  4 files changed, 650 insertions(+)
>>  create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>>  create mode 100644 drivers/led/led_lp5562.c
> 
> If there's no further comments, I'll update the MAINTAINERS file to list
> this driver under your name as well, OK?
> 

Fine by me.

Thanks,
Rasmus

