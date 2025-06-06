Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E80C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B63281FEE;
	Fri,  6 Jun 2025 11:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gYr7b4lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8AF8291D; Fri,  6 Jun 2025 11:15:14 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43CE803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb/bLR1eERAwVgh9AG6PpwdWwc8ChsYYMbGXJlpOTMhJjhOwZCBq117+/feA/DAAJvnA7qL3z32hguL8gmz3JVDZoPn1DDoScR0G4bxE4ydKtdylJiGrlAO0P77Dy0yxc/RLB27z+xy9MFTlU750ybtmugBmBW73C4hhP+jkCyIGUtCamSLfbPbzD2JgYRRFdnv85O5q6q4iOEDmhGvk/KMaKUrGAWDxrcKr/D+olEs7j/KLIQsqa3GpU+D4FwA8hQD2vpgRjoY/RN9MSbw+DklfUYfjnvFgKPH9AcoPBVcEy+WsPupnQV4BgQRLB9/e2z+euIb6QsGezWWvlCVeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACeTX/QQEBi0cMa87Qgf9dyDKMStuzzSEjsSxPJZNJo=;
 b=R4eVsDI7Y1lBmRz+dI8wDKz7T/NYzZNjcvkSjgz4plqXDiFwtke9WFrb1x97RnQsx5a7oaAi7RPvEtajoq4QdC3qVxHEQ4x5hZ3rB/ffGdMYHAGauAYE2x+xIJGfKfO9924y/wQ8OBu18By4UEusHxOYzRnBSL2ksHDxkaXHiH9ldsb4by7nLjvHokt/c626kv4OufCLx16WQtJF7XRGftYn5k9wejaVUA9Po3iIDe+4+swqIF2Ck8jO+Jao/NWG/yunmJGaDJTaKyLfVo0V4Ej7s+ODD5ntU/Som2NhsDSE21U9SY1YhP3YE32IW2Qd4+cNwxqIvBnAfIo798HvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACeTX/QQEBi0cMa87Qgf9dyDKMStuzzSEjsSxPJZNJo=;
 b=gYr7b4lOb60GgNPviqRc4JievL42FUP5UcGGiB167AdqRBbOiWyM37+86j6sxkRKOVKNlobKuZN9obeuSn6bBzrsJEEa5GBtyKUyFNwXVwsBZA4xZmOCynzQWH8fIuiv1bjyHeB/lWOwKaQPXa+4uyWJr5QH+vzpIcHbZOPmpDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 09:15:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 09:15:08 +0000
Message-ID: <55c63b2e-baac-457d-b6d5-b03eba4d30c8@cherry.de>
Date: Fri, 6 Jun 2025 11:15:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30: Implement checkboard() to print SoC
 variant
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.denx.de
References: <20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de>
 <b9a85c5c-ddbc-4c67-ba29-52a4cb7bcbe3@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b9a85c5c-ddbc-4c67-ba29-52a4cb7bcbe3@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf57281-fea1-4da8-e40b-08dda4daa208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE1VYi82eWloSW5ubStyVUZ4Zjl5SUxaeW5DS1JFZ05PRlhERytKb0pXcVhI?=
 =?utf-8?B?dFUwNng1SnRQZktrc2R3cEJMUU9KKzRCaEhoQUhSdVFJKzZwaUE4K2RaMTls?=
 =?utf-8?B?WDVmNHZBa0dGVzVKKy9GT1FhSVZVVTFQL0k5amk1YlNwck5NckI5K0FYYnJC?=
 =?utf-8?B?c0VnWCtlOXJITVMyMFpyYWFiRmFHWEd4aFVjNHJhSkZSajI5OEtaYldkY2d3?=
 =?utf-8?B?QkE3THVlSURlZnV5ekgwNW1nQjN6a3JFRWI3QXZRbXBiVEFnM2VuU09SeHI0?=
 =?utf-8?B?TUduWG83bXlWeHJxTko0VHlGRkMvanJ1SmNYOERTNERHcWVoOERrcHNWUVF6?=
 =?utf-8?B?ejZtVHFpeWthQk1nNS9oWUg3V3ZKMjJBRHpoRkozTlQ4MlRpeGc0dVpqTUhG?=
 =?utf-8?B?bXRvenFuTG1leVRNejNkdElHL1NUc2hIQkRyM2Jqa0R6WEZkK0JSbE14ODNM?=
 =?utf-8?B?SHQ2VGRiUlFqZFhiQVVrN05NL1ZGcUxDenJSV1U1QTRTbTBpQmZJV0t5ekQv?=
 =?utf-8?B?MjJyYWtiNTI0RkpEM1JLV2JBM3J0S3N0OWhJd21Zc0tlOG1iNzRweFNSU1JT?=
 =?utf-8?B?S3U2enNBbVNQeW9LWFZ3NkZ4YVdXN3dTZVVVbC8va1BvdnlYa3p5RzUrVkg4?=
 =?utf-8?B?ZnFKcDlRNnlMNWhsL0RTZFZjYnZKQWo5RzFQTWdya0M4cmpnSWNUU1J3Wkxr?=
 =?utf-8?B?N1JRS1NyU0QyTWk4NEdYcjIzbzV0V1dGR010cUM2UFMvUExPVXdrM2RORUZy?=
 =?utf-8?B?cEo3aUdaYUIxamt6REhXQXIzSld2WDhPdE1rODdpa1NWUDdVSElpVi96ZWlo?=
 =?utf-8?B?S04yK2tHMmhhYTBFMzU2WVI3d3JJZmFMZ1k5eUQwbGhrdmttTTRRWW0wWDkr?=
 =?utf-8?B?VXR2MHRKdlJxYzhLZGlvS3ZGTmh2L2Z6aVAyYUlWMXN0OUVxM1B2TnJBWjlO?=
 =?utf-8?B?L1BtSUdpbkdpYjVrZGhaODNRQWNTU09OMWwrZ2hpa2xJd1RGZHVDdjJaV3Zv?=
 =?utf-8?B?azA3NXN3OE9xUkJlQXIzeEhpQXRCL3V5UDBOVXMvTmRTVmlwMG9hSXFHYTNY?=
 =?utf-8?B?QldNZ1laNWU4TUM4Mzk2bmhtRXBFRFlXMVFmd1dqbHl1bXQvU081OXZGN2Na?=
 =?utf-8?B?KzhQMGw3eC9kbWRLY0ZLM1dYQ3N6RVVZRCs4UWs4eXJpaS9rNUVhc0lQYVBB?=
 =?utf-8?B?M2VjaDlLSWo5cUsyRW1KYW4vMUFuVnNJNWJEUjJrcWpMNEk3WW1KU2JNN2J1?=
 =?utf-8?B?UVRjNEdGZEtDdjNZTVpMYzJwNE1Cc2RPSnNPa3cvMHVrRmY1NDBtTkJ3R2NG?=
 =?utf-8?B?YVNETWxYalZSakhYd2tneVV0c1VqdW03TlZvbUxQM0lZWitxaXpJMzZIbHY0?=
 =?utf-8?B?MWlrSm15QUNHV0V4ZlQ3WVJ3UTRGZ2tGa1AvMFV6L1JtcXlzRGo0YjUxUzB3?=
 =?utf-8?B?OXZKVFU4NnAxSFJ5Y2w4Ny9ISHZUYTRWTlgzR3JUeTQrLzFPVDBpbXFPTmE5?=
 =?utf-8?B?ak51MEFqNWlFaFB2cU4yU25MTGVmaEJ5cE5YRENuOVExY1Y2ZTNPMHRqeUF1?=
 =?utf-8?B?YlRQUm5SQ055Qjdac3VqQU1MaFE1Ris2eThTbG1aV3BpMEkzbnZzUU9JLzE5?=
 =?utf-8?B?dGJ5dUhvOEdtM2phb2wxa09oYVhJRWt5SEN0Mi82ZnJ6ZWE0cGVJeGlYMElU?=
 =?utf-8?B?N0pzNmNoWGNMNEZGOUIrK2xrTi9aU0RKYkFuUUJJS2lBOTJ0WnpNa3B5UlRr?=
 =?utf-8?B?VVFZbnBZQmx5TVZ4U1Y0MHJzdFZHdEZVcVQ1K0JxWFJoUDREZllEbzNjZDly?=
 =?utf-8?B?OVM4dDRValpIeExRajVvdWxFWmgwU1JMaFhPNXlRVW1QTDd0WEUyMUJYUlE0?=
 =?utf-8?B?SVZvYnAwYWR4NWFyQUJ3NVYweTZsUDJ1djM2MWZwNnl6MlpxZVpaTi9aSmVm?=
 =?utf-8?Q?zBi5JlTe7DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVaT2JPVnAyRlpTbjluMmN4eGM0MTZGTm9JODF2Y0xnc0owNWM4dndEb1Bn?=
 =?utf-8?B?bm1vY2ZtZS9mY3BBR1pWZnVodDdoT1hOYUc1ZGJZSUNrOHdwSTY2YjlmM09o?=
 =?utf-8?B?aE1zRWRmY2FHbThDYVhSa1RFbzE3V0JrZVZJM0s5ZkJuczVidE1DcURSTUcw?=
 =?utf-8?B?eU05eHBaeG5IOFNxRGdmMnFVQUZuUlJvVk1VNCtNdER5bitpamRXN1BiQ21U?=
 =?utf-8?B?cXhPVlZXYnU3b25aajJvcmhaSEI2bWYxUk5wYm9PQnZHbVgwSWVvQ3MzSEJx?=
 =?utf-8?B?L3RoYS9YY1JJOUpRL213YUtXTW1ndmpWN2VPcWtldFA0TmRScldubzVlQUIx?=
 =?utf-8?B?TVFrcExWTXRVbHR5UTVMQVA5LzgvV2x0Q1g0bmxHMUZMdHpXUTNVQVgyOWdz?=
 =?utf-8?B?OVlnYUJnVUtZNDlFblFibDVEdDZpM2x6UUtpbyt4cXFPK0JuVm1oRWo3V0Jk?=
 =?utf-8?B?cmdlcmovL3RSNHc3T3cxS3NyMnM3QjNXR3VmMWdpTUtvc1F5N0tHejRyMm1s?=
 =?utf-8?B?TFZEVW53UWdsWWt4TU15UHRIL0l5Zkh1cnVGTjlrK1loVkgwazdwNkdUcnMz?=
 =?utf-8?B?Q0ppRGE3OG1BdWsraytVRVJLaDJ2N0lsRlRvMytQdDMzU3BxM3RSenF3bVFr?=
 =?utf-8?B?V0hDTkg2cnVmUFo2R0JKais0UGxYK2FFTWZoTlRkVzNHUkxNTitDYkVvMmYz?=
 =?utf-8?B?cWxpTlJDazFBeW1qMXJSYlhxMlRQOGJDUlY2MG9aS1JtRjJYMnQ3V0tDRjBu?=
 =?utf-8?B?L0tvTkkySGloNzB4RFFhS05LbWxwaWNVUnh3Mld4YWVDMW50WVJTdkJEbUhM?=
 =?utf-8?B?dStQSGZNTFdjQm1NdlJyZWtYcGdDTHJJa3N4WEU3SnR3ZVVFQmN1eWp0YlVD?=
 =?utf-8?B?UCt0R1pPdTh6STlGZ2t6c251NEpZeDE0K3RBcURjekI1L0djM0JoSFF0TkFx?=
 =?utf-8?B?YVM2ZmNjUmRCbmN3QlNIM2ZoSkhzWGJxcGJGWUZCNnpRSUtMb0JvYzdCZHZv?=
 =?utf-8?B?K3dWWFhvWU1uRjVtN2lFOWFNMVF2eVNPTE9VVmRqaTJGVkpYMy9sZ04vYmR0?=
 =?utf-8?B?VUFuVFJYNDZYc05HSDJMZklhMWVMVFF0OU9ueVZydlZwVmtMZkFLTWxndVZk?=
 =?utf-8?B?NTRwQ1ZFYVVVSVpKRnJLaDE0eXJIVEZYT0p4L1g3UTdzQWkyNCt5U0RBVVdV?=
 =?utf-8?B?Q2wrSTFOM1FBZktBbzJUeHB4YzJSRXpoYjVVZGlIZUlHbEVTQ0EvYVZwZ0N5?=
 =?utf-8?B?aUdLczZ0UzNsMVhhM003THlzcE40RFRYL0VOQXpiUlY2Qm83ZC9HdmY0bGFw?=
 =?utf-8?B?dVhRZ0V1UVhpS3RFY1JnUm9SNXFuSncvUFdNbHh6aDdoUUNpWWNKWEFyem1U?=
 =?utf-8?B?djVBTHk3Vm9TVEszOExEWkxhM01qNVBuWG84cThHRThwSjZMbnVmbWlGUHMz?=
 =?utf-8?B?RjJnR0I4L1FCR2ZFTnlNYTMrSnQvVk5JZDlnVUtBRkZ6NVFuRS9KVUdaWmRK?=
 =?utf-8?B?cllGM0JUNm5uTXZnck9qaDdaQTI4bzlBOWlqS2ZyemxKTmRyU0sxUG92VkZZ?=
 =?utf-8?B?V3M2OEdKSlJmekVBSkVWTCtNUmVQTmI4am14VHl3ODk4V2NrT1BCMmlpbVpQ?=
 =?utf-8?B?bkJrTjFCL2JtZHBGM3h5azVMTEk5R0tTYks4YVhJbENHN1BNbk9oNFFoUmZz?=
 =?utf-8?B?NWhCaWU4UStsVTI2TEJ1Z3BLbWkxYitrOWZ2ekNzcDhGZ25kNmVuWktqazFI?=
 =?utf-8?B?S04xcnpkL0ZSWXpqc0FDMTBiR3BCL0xOd3AvczBocUd1MkhTSkpKVzh5MFZa?=
 =?utf-8?B?QWhmaUU5TWxHQTVtOWlnRHdaTmhKTnRwRUZ1aS90aWdHVi9jZ1krYnZwWStR?=
 =?utf-8?B?d3ZDYTBwQ2QzMlhPVkY3STVLTFVSdDdCUEkrZ0NCQ2I3MHJvblhkOWl4N2tS?=
 =?utf-8?B?WEQ0VVRIaFBad0hEV1orTW5nYU5mUnB0Vm1rbkdRMm1weWIvY0xlamdBQzIw?=
 =?utf-8?B?VWJDeHFDYmE4NWJiSUJraWNQNEJzQVBXMmNSbFA5K0NndU5rTmZJbTRlZkpo?=
 =?utf-8?B?aXhFSjRkam1pZ0V0NHVzb1RycTJJNFZrOW5VbkY0QTkvRS9xYnk2YmN1SGRM?=
 =?utf-8?B?SjduaFI2YXlyUjdIOVhKb2tiaUIrMjIzQS96bmVGZVNibmFhcGFRQW9DWVJn?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf57281-fea1-4da8-e40b-08dda4daa208
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:15:08.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zazVKr3yyn0TSh5hfuvhT1jZobQgOibsQsiQouBgKVGr3BypTs28kc3tzm4hGUXcb4CeNuSMvm9q2Dkq1jUsCNV5zwDKFGRE1kGZ4Heep9g=
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

Hi Kever,

On 6/6/25 11:09 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2025/5/28 20:00, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This implements checkboard() to print the current SoC model used by a
>> board, e.g. one of:
>>
>> SoC: PX30
>> SoC: PX30K
>>
>> when U-Boot proper is running.
>>
>> The information is read from the OTP. There's no public information as
>> far as I know about the layout and stored information but this was
>> provided by Rockchip themselves through their support channel.
>>
>> I'm aware of at least one other variant, the PX30S/PX30-S but I have
>> neither a board with that SoC nor the information of what the value in
>> the OTP is supposed to be. If it follows what was done for RK3588
>> variants, where the letter is derived from some offset added to the
>> value read from the OTP, PX30S could be represented by 0x33 in the
>> OTP. I'm assuming this is correct and simply printing the char
>> represented by this offset added to the value in the OTP instead of
>> checking whether it's 0x21 (PX30) or 0x28 (PX30K) or bailing out.
>>
>> Also add the OTP node to the pre-relocation phase of U-Boot proper so
>> that the SoC variant can be printed when DISPLAY_BOARDINFO is enabled.
>> This is not required if DISPLAY_BOARDINFO_LATE is enabled because this
>> happens after relocation. If both are enabled, then the SoC variant will
>> be printed twice in the boot log, e.g.:
>>
>> U-Boot 2025.07-rc3-00014-g7cb731574ae6-dirty (May 28 2025 - 13:52:47 
>> +0200)
>>
>> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
>> SoC:   PX30  <---- due to DISPLAY_BOARDINFO
>> DRAM:  2 GiB
>> PMIC:  RK809 (on=0x40, off=0x00)
>> Core:  293 devices, 27 uclasses, devicetree: separate
>> MMC:   mmc@ff370000: 1, mmc@ff390000: 0
>> Loading Environment from MMC... Reading from MMC(1)... OK
>>
>> In:    serial@ff030000
>> Out:   serial@ff030000
>> Err:   serial@ff030000
>> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
>> SoC:   PX30  <----- due to DISPLAY_BOARDINFO_LATE
>> Net:   eth0: ethernet@ff360000
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
>> had a device with a PX30S or any other variant so we could verify it
>> prints what it should :) Or maybe Kever knows :)?
> 
> PX30S has the same id with PX30 in byte 6.
> 
> For PX30, there should not have other variant now.
> 

Thanks for the info.

Is there a way to differentiate PX30 from PX30S from the OTP maybe?

If not, do you want to show

PX30/PX30S

when byte 6 is 0x21?

Cheers,
Quentin
