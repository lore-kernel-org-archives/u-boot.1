Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52200D0C61B
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEA888B9E;
	Fri, 25 Oct 2024 16:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="R9sjaMcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7210088F92; Fri, 25 Oct 2024 16:56:21 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CCC87F7D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isA8nJCHnYkVEZwmneBBVjEg3zvIsVzEswBTk10nLyvYkIbv5ln4uabI4BMeexIjqKxzEZzfFQPuT99sfqvLeRzNj+ppRP7ORwsFyEwQvaP5SC/ROZFkAN5GUFwbQm4HGZsGuJgDPuDSdITXWRWWUmfRcCimMuyZacHm+sAbKEwlcHt4hicsF1/IFzT1DjNZdvYejP7rZbl0HHds3CvuhLZqq9tZqBhGyw6qhdRC8jUV+s2dwHo3cH23jXBgF+i37hmKtSQ2FjEca3tnC6GgfzaaLyYID1bY2dBGYic17q9PZh0kQGUGQDaC9bQPCdRWeYZqc2YgbnyRQImyhT4pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZRv9vcI2ahNcW2KAu88gEEYBhqSZEgmQlJThTNhVBE=;
 b=T3/HGbt250Tnp38OwvSgDHffg235sif6d3NWcRoqIjogcHpIPakscIknv7Hp+rbZONPIaYT7AWmcRGbFcecswjaXPFf+LKVsGELAETXQDVjPatK7FdB8nQ12IxXhJ6sXgGyIrjuuNM+7XEaaK7i01ZCnJLUrAo+w4fsCa6NOToqP6Z74dex3eLJZdQTS41vvJo9rURz6qTODLzIFYJVjMOkMynca8U102QvhEiU1wKrSv6qJhlaSsjOU88k6hzUzsOShY5wy9CpkZywWNTzXD/PJI/td37F8oybwgrwT/FYp3QPdSQ7Zpdlm92RJxpvhNbHgLu1WRTDPrBriK5YN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZRv9vcI2ahNcW2KAu88gEEYBhqSZEgmQlJThTNhVBE=;
 b=R9sjaMcgiA9cnF9sW0VeRlO5mlKlZQtodMd5+xhQRgdKsesxTY8U2+gX9hdzDZcpk4Oid/f+KU9M11E74lppdluR+FvmObIP3Y11yJCGmGk6M+c/v/tVZUGbGLSJkcYhBs4bzEKZSDgUVxkiK63yH/ZNXiojE2OLp37swUWCjC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10785.eurprd04.prod.outlook.com (2603:10a6:800:26e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:56:14 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 14:56:13 +0000
Message-ID: <aafa4ae3-bce7-41bc-a8db-5fe4171634d4@cherry.de>
Date: Fri, 25 Oct 2024 16:56:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
 <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
 <CABd623v=h5SZPcqvH=uoVHyA09RdxuP+mjNUaisOMj7dAm7uTw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABd623v=h5SZPcqvH=uoVHyA09RdxuP+mjNUaisOMj7dAm7uTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10785:EE_
X-MS-Office365-Filtering-Correlation-Id: 31589094-43e7-4199-05ae-08dcf5052bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1lRRkdidmtqdmZHT0ZiTnlNQTliODJ0T0tLN1NWMGJkRjJ0S1RxRDVKSUZr?=
 =?utf-8?B?K05KaGdPNWdKYUcrWW5pcXAvZ2pGNjlTQUxYeUVpTTlIVGVOUG1MSWlEU2xl?=
 =?utf-8?B?cXZqTUhIK0lHWWJXYWJIRG9lUDhLSGI0UTZuaVEwYmR4TlB4cUR0UkVIR01K?=
 =?utf-8?B?MVpXZ04xbVhDekwxU1FwVGx2dXBKZ3FLdkNBYjgrZjJmc2MvcFNqRVZuT2Fw?=
 =?utf-8?B?ZmI4L3ZUL3ZjL0VSMFhWYlhrTG1qVmh5aS9BbTRCNDhQL3cvL2lRTGV2MCtj?=
 =?utf-8?B?d0s4NllMTUJUZ3dBb21seEowaklvRmhydGQ3cE9zbVQwb2oyNzl2a2krUXU0?=
 =?utf-8?B?YjRrMGtTSThvN1VsMHo5STVxcUxVbEVxVFVqZUNzaVFpSTdMcUp5anRCZXp4?=
 =?utf-8?B?UGQ3NW5DZG81cjdjRzE4aFJvUGpMNjVvWE1ETWk0eWNFekZvY1ZpalJuWEFH?=
 =?utf-8?B?WVAxNDFxS3FlbEI5eHRXS1RkNGpDOWh4V0MzRkFQZXJlNXRRRElRSTcza1pR?=
 =?utf-8?B?UVNicU1qQjhocG1ZdFpmK05Bek5UbmRFUmRZMkZPd0JHUVQ5eFdpdHVKRDli?=
 =?utf-8?B?LzR5MTRLakIwc3MvR1VOTXB6RTdqNUUyRlhoMVhhUUtZSFhrT1pxbGhHYkwy?=
 =?utf-8?B?OUtXNDY1eVhydTZqQmFjbnNvSXphOEFaWnJZcGU0SGFla05Mc3NHM2lhbkNn?=
 =?utf-8?B?ZHVsN1V0ZjIyenlISTU3ZldEMzdiS2hKWnVKRy93N0RSOEJmUy9kSXMwUzBU?=
 =?utf-8?B?Nlk5VFJleTZxT3E3U1FJWFp1akNQV094SzVUajZFRWNNbFZwSWd0VVd6WTZB?=
 =?utf-8?B?QnNZUXhqWkEyY1VNNlZUbElUUUxOQlVRTWsvQVQwTUp0a09tZ1dUeDZlNkpa?=
 =?utf-8?B?VDFHM1JmTXk1OWs0SVZpNU1jSWFBRHJLOGpqVlhSd09saDV6RDdlZjlsV3NV?=
 =?utf-8?B?QmxudTJoQWczM0Jrb3QvSUZ1dEd2cVdYRjY2a1o5Q3RWQTdMUTJWNzRxQWFN?=
 =?utf-8?B?UFNCODdtRXNDbUJSSVc4MWlQQmxHbVNRQWZJdXcvZTN6NzduR3QvbEtjSENC?=
 =?utf-8?B?MFE3WkNQSnF5WW1EVFZ5SmI0SjBtcHNDZEdsNkR5L2dTUmtyQ0owbGhJRUNh?=
 =?utf-8?B?Y3lxdFFvazVWWGJsR3ZoKzJzelJDWHNqNDgrWXVXclBhMnVvUDBjeGVQUzRL?=
 =?utf-8?B?TzUxZ3o2c3VQdkNneFdaR1laVGd3eVBqQnBwQVVXcjdxQkZsQ0RxTW9YZ0p2?=
 =?utf-8?B?VmVoai9ZbGtJUXY4aVNOTXhqSU9tOTRlb1BuSGFCcTY1VVJ3eGJWSkEyeW5p?=
 =?utf-8?B?NEpBZ2lFQWVsKzZnVlRjL2N4Vk9iek10VzdGMy9keGtEYk9zN1prcTQ5Q09l?=
 =?utf-8?B?UU9vcWNxY09vTUowMjZ0UmxjVjZwL2IzdVorQ1Z4NGlid2NBQ3loL2pCMTYv?=
 =?utf-8?B?Zm5nME92VVBtbUNsZHE5ZzZIVGpRbzVSQXVlM1NRU1NXTUFtV2N2QzhRcUZD?=
 =?utf-8?B?bG9sZGpneEFnbmNjbFF5VmxsY3NaM2hxOGJCdWZQRzQ3T2RVYXFXNDdzTnE5?=
 =?utf-8?B?M2FuUnpiMTYxRFhzcHZhR3plNzRrNFJJL3RxTTR5OCtEWlZqZzhDcDIvQWNI?=
 =?utf-8?B?czEvQTlXUWdBUm1QaW82NTgyQXJDRzRON0FzV0F5RTloT1VPQ1dqeTY1SkxC?=
 =?utf-8?Q?YQv7x0YsjUUFi85OyOel?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZ4WGEzd0IzZjUwWURZTitDVmpOaE9SNXZyblFyOGZyV0FkWnpmcjlLV0h2?=
 =?utf-8?B?bE1YcVIvSklpTmliRjQzRkw3dGt4b3VBbXRvbWx4Zk0xL1Y1eVBrU0F4RlNN?=
 =?utf-8?B?bjJHQUNRUXcrTk93Rk94MFRML21Xbkw2ajc5M2c5UXp2VUN4ckpiZDFWWjNy?=
 =?utf-8?B?Y0Z1RVZGT1hwUmJ0WExQZDZqTkExMlZMQWsvbzM3dmhtVm9qNDBUYnNYU1pL?=
 =?utf-8?B?aXQ0c2hIaUZ3TkRGTXB3VW1TVmlDMUo0MndNemxPQnB4RVhZSXpFQ2R6d2Zj?=
 =?utf-8?B?K3JEUFRuMlBpTUthaFdCd2FTVjdPMlh6aURvOGs0NTl1Z3cyRHpEaUtsVHBx?=
 =?utf-8?B?bFVjS1FlaDR6d0RIQ3A2VjJtbTZDak5aMDBBNmNYeS9hVjhQWXJyb213MDBz?=
 =?utf-8?B?K003TG41emE3NmsyL2F6MHBXTk9EUjdGdTlmanRwMWhGdU02UG5JbXcyVHpB?=
 =?utf-8?B?YW0vTDZGUFlSczdUQWxMa00zTEZjOUtnRjFmSlRGcDVYbVlBRGZUNnpTUGQ3?=
 =?utf-8?B?THo0ay9SWTdrL2FrWDRqaEdCR1l2TjFvUERCRGkrTWxPVkwxQzFYWDNWWDgw?=
 =?utf-8?B?dGs0anlJR3pHZ2JKNU5VclZhdTcrL2ZZUGpXZGFmUU5Bb1ord09rb0FKcUd6?=
 =?utf-8?B?eWtLYXMwN3lFQmhZQmo3aFpZdXkvb1V1ZmYzTnFSaFpvSFNNQUdPM3ZWQXNT?=
 =?utf-8?B?OUtNdDl0U1FHSEZ5S255STdTWHU4VWUveVdaRG44dlVLVGJoc25NUHMxK1dm?=
 =?utf-8?B?a2ZLQWJiSTN4ZFZFbkNGUFFBQWFHRDh0eGJwRkc3N1FzVmF0OUpqQVlwR1Js?=
 =?utf-8?B?b1kxeXQ2SDB5ZHFVeW14VmgxclYrTFhSYWtEL1pOamNRWkRKSitid2tRcG4y?=
 =?utf-8?B?TWFWaWhIVXhqWFFwZDVad1YxbHdYNHIwZ2ptTmJMc0x6MUxaNkpDbklydVFJ?=
 =?utf-8?B?clk1TmNMekRGVW5CZSt3bjlyRXJ6V3VuRDNMcEoreXpyVDRCUG9QRFBoMkZm?=
 =?utf-8?B?Ulo1bG5vUG4wTzhhTEladGpMNkV4NlJhQ1VNYzQrdWJQT3EwRllNWXJENDFM?=
 =?utf-8?B?Q0xLWVgwbFBOdXlhWGJoZVhTZ3FuMDByekh5amtUR3REdlowQzdDVU1DMnk1?=
 =?utf-8?B?K0UzQzhGcEI4djl3QzRZV1RvR3R0Z2w3eUhjaGJ1amw1eERuYUlDU0N2bjJN?=
 =?utf-8?B?R0t1djhkdFhGUW9xdXg1eTQyMW9ZY2FwSjFSL1M2Zy94L2ptdmcrT2lDUDdz?=
 =?utf-8?B?SXFsYm4rdUlnNXFkZkF5eXgyVXdRY3Jkb3VpUEI5R0ttbisyY2ZGOThYUVJ4?=
 =?utf-8?B?d3hRT0l1eWwyUGVQNHAvQjcyODc5YWdLWUE5OU13WkpkRWE4Z241dEZEZnVz?=
 =?utf-8?B?Q2FxeUxQTGN5TjFsTFMzTVYxbFVucW5obS9lQXBOeWh5WTlzRnNSamlxMzlr?=
 =?utf-8?B?R0dJRTJBcmx1SEFpNXF0ZFVmU3FIU3BaSHdEN1gvUWtUdDlEbThTeUZaNWdK?=
 =?utf-8?B?V09ueHdlWXAyYSswNDN1S29nV01RaHFINXFEbHl1UEJ3VEl4YzZ3aHFMd0Fx?=
 =?utf-8?B?dVYxNzZoSXBoRWZkQUtra2FNTzhSZUZGd1Nma3l2TzJhVzBSNFRndXpyaXVp?=
 =?utf-8?B?TDFTdGNkakxKaFhpVlVvRUNFU3pPenlWUVo4TzhLcUpJSWlvVXNKSXhaYlpL?=
 =?utf-8?B?VnlZLy9iaHBzQTk3Q0QwbDkvdFgvV0VjVVk1MWxvT3U5MGVWY1FRMUFjNWF1?=
 =?utf-8?B?QU9hY2VPM0Y0djV6VThvZDU4VXpvTlZRNWtFZm41b0FjN2pGWStoQmltODNG?=
 =?utf-8?B?T2piWWdDTmhhZkM0S0hSSjZvWnFYNEVNd2k3VXN2WFFGdVFMaHU1dVVyeUVV?=
 =?utf-8?B?SmEvSmc1UkxQdFhmQXV3M0ZENk5rWUdEcjFoNjVxbU9kQzFPQU14YlM2SXND?=
 =?utf-8?B?SDhwUit4Y3FveWZ3ZkVRM3pYUGsxMnY1ZVVTMjM3NThVRzIzditnU0t1SnU0?=
 =?utf-8?B?OUVVcUoxaW53NGU0cE9jZGV1RWdIaHUrRVpCb091ZWJPYStuamtHRDlBcmRj?=
 =?utf-8?B?WmJYRUJxQW5FTU0rcXh3dEJVQkViV00wdVBZZVVaOTZoSG14OUVuV3pFdm1B?=
 =?utf-8?B?dGNGU0o3c08yOHQ1eWxzekR2ZTRZWTNNa1E5bG44eUdBajJYVGJpYTc0d1hx?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 31589094-43e7-4199-05ae-08dcf5052bcc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:56:13.9132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54gM4LVquPGpK5c2SSYLz7Sfcbdp02mcxKVrvzx42CdjIHFOIPyEGp1nVFSq4JJFsdoH7jmkPsfD2sStbD4BSA0WTIUvV6EiCZshsQWltos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10785
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

Hi Lukasz,

On 10/25/24 4:27 PM, Łukasz Czechowski wrote:
> Hi,
> 
> On 2024/10/25 14:30, Kever Yang wrote:
>>
>> Hi Tom,
>>
>>       This is regression of "#ifdef CONFIG", is it possible for us to go
>> back to use "#ifdef CONFIG" in this case?
>>
>> Or do you have any other suggestion for this issue?
>>
>> On 2024/9/30 16:55, Quentin Schulz wrote:
>>> Hi Kever,
>>>
>>> On 9/29/24 3:53 AM, Kever Yang wrote:
>>>> Hi Lukasz,
>>>>
>>>>       I think this will make the error happen like this:
>>>>
>>>> +common/console.c: In function 'puts':
>>>> +common/console.c:746:29: error: unused variable 'ch'
>>>> [-Werror=unused- variable]
>>>> +  746 |                         int ch = *s++;
>>>> +      |                             ^~
>>>> +cc1: all warnings being treated as errors
>>>> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error 1
>>>>
>>>>
>>>> The main reason is that below patch removes "#ifdef":
>>>>
>>>> c04f856822a console: remove #ifdef CONFIG when it is possible
>>>>
>>>
>>> Can you please always share the link to the pipelines that fail so
>>> people have an idea on how to reproduce it locally?
>>>
>>> Here I assume it is:
>>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22455
>>>
>>> A simple way is to apply the patches, build the pine64-lts for example
>>> and then you'll see warnings (which aren't failing builds locally I
>>> believe but in CI, yes).
>>>
>>> I think we can fool the compiler with the following:
>>>
>>> diff --git a/include/debug_uart.h b/include/debug_uart.h
>>> index dc0f1aa4c98..b19e44d6d0f 100644
>>> --- a/include/debug_uart.h
>>> +++ b/include/debug_uart.h
>>> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
>>>   #define DEBUG_UART_FUNCS \
>>>       #warning "DEBUG_UART not defined!"
>>>
>>> -#define printch(ch) do{}while(0);
>>> -#define printascii(str) do{}while(0);
>>> -#define printhex2(value) do{}while(0);
>>> -#define printhex4(value) do{}while(0);
>>> -#define printhex8(value) do{}while(0);
>>> -#define printdec(value) do{}while(0);
>>> +#define printch(ch) do{ (void)(ch); }while(0);
>>> +#define printascii(str) do{ (void)(str); }while(0);
>>> +#define printhex2(value) do{ (void)(value); }while(0);
>>> +#define printhex4(value) do{ (void)(value); }while(0);
>>> +#define printhex8(value) do{ (void)(value); }while(0);
>>> +#define printdec(value) do{ (void)(value); }while(0);
>>>
>>>   #endif
>>>
>>> Does this make sense?
>>
>> Hi Quentin,
>>
>>       Thanks for your information about pipeline and suggestion for code
>> change, but this workaround does not looks good :(
>>
> 
> Thanks for the suggestions. I think this code can be even simplified
> to just i.e.:
> 
> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
>   #define DEBUG_UART_FUNCS \
>          #warning "DEBUG_UART not defined!"
> 
> -#define printch(ch) do{}while(0);
> -#define printascii(str) do{}while(0);
> -#define printhex2(value) do{}while(0);
> -#define printhex4(value) do{}while(0);
> -#define printhex8(value) do{}while(0);
> -#define printdec(value) do{}while(0);
> +#define printch(ch) (void)ch;
> +#define printascii(str) (void)str;
> +#define printhex2(value) (void)value;
> +#define printhex4(value) (void)value;
> +#define printhex8(value) (void)value;
> +#define printdec(value) (void)value;
> 
>   #endif
> 
> That will allow us to get rid of warnings. What do you think? I can't
> think of another method besides creating a lot of #ifdefs in every
> place debug functions are used, which will look even worse than the
> dummy macros.
> 

You need to surround value/str/ch with parentheses though.

And we should remove the trailing semi-colon too as we cannot guarantee 
it won't be used in contexts in which the semi-colon is not allowed.

But I guess that could work? I'm not too verse in C macros so maybe I'm 
missing some corner-cases.

I think Kever is suggesting we revert the commit he linked earlier so 
that the functions used by the macros modified in this commit are always 
defined, just empty. Is this something you could test? The downside to 
this is that we would have a lot of unnecessary dead-code with loops 
calling empty functions instead of just not calling functions at all.

Cheers,
Quentin
