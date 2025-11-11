Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B28CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 17:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA7D83BB5;
	Tue, 11 Nov 2025 18:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VBrXjkEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4A983BCE; Tue, 11 Nov 2025 18:27:19 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CE383A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 18:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeXUWgpW3kmgyX3tZIozGOH/5rathCMcohDbo6nQRjw40BgedK2MdGQ0zDk6wzlaBgcWd9OYF9d4H+4jbrWFkSSVUAhFfJPsIBi4I/2siNrloyZ0xOOLYRPr11lwaUTGCBIjJcjKIQ6kFJJBIQnp4cCyv/jkiOlOY2DY6DSR0E85tkUa7Cg1jkGfYE1/R5yHoUcgVXwBoMZ1jD+vCZ88HqgjCc5azewkXhxVdfSHALrFE5HyJpPgdxDTiByUXpEpxu2G1y8fww8MsGIvHKZ9yL7RWcZiq63Y1CnjZ2zNz+CBOjitEuH0PxvfcM5lGcqNyYiAog2iGYQgZMbVycqWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DSyyhldLyN1kr0bvdA4XdF0aG3X7GU26oHii4pw6H8=;
 b=rtvXVLM0DOx0YWo8Khyg4VX7Dnc2A32KpbIGU0KREzGYRag3TAixajCFQj0Y6uEE5hvVHRD+MfvdS5poWcz/BXdJJ+x9rJaVavO1T5vSy9f3tOx03a8uKXh9ND9Zvf0ZEwiBnrNy7F+05DTIPAdaqSk4cPbYKe3icrXXYIG3dRIgunSc5FnlrrbzHlT1wiDskEnYQyFdbEy/L/5Dmv3DNf7jpdhsBPWYRCClob0HEXuQ042fBZrviKQaZZknzl5oPqfLaUFw+5ES+BRnmuyWZH9iKU8t8SNq+FhXiWMwjQHkPxRnhj/YPmXqdierOClS9SJt3vwhevK46mHR3RYd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DSyyhldLyN1kr0bvdA4XdF0aG3X7GU26oHii4pw6H8=;
 b=VBrXjkErVlVaRkMT9ugpZoCTW9kjh9Uhq6Cg8TN6DShFoEU93FXNr92WMi0O+8xSSj/6jQzS4GBW2lA8jjwihP5Xu0sN64BFGjGgrCxpNnjlFdOmUO84ndb2b63iq31iniGdvAoF9VPXHwlUUQp9yAZ8fZEgeTjQ0EnHyF5vTH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 17:27:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 17:27:15 +0000
Message-ID: <57fb6330-76cb-46a3-b371-b4d7d46bf99e@cherry.de>
Date: Tue, 11 Nov 2025 18:27:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cmd/part.c: implement "part name" subcommand
To: Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20251110205411.4075351-1-ravi@prevas.dk>
 <20251110205411.4075351-3-ravi@prevas.dk> <DE5M6LMZV9EI.NS7NVSZR63W9@ti.com>
 <87cy5pc82m.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87cy5pc82m.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: f363bf70-f23c-4b3a-99b4-08de21478e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eThBNU84UnkwbHBaTE1tUHlia0RXN1cvWkN0SjBpOUVBTTUzcDVCSXAwazV3?=
 =?utf-8?B?bU5VNDc1TXRKcmsyRkoxYnFlYm5wOGJ5SVlEOUtMelRDQ1Q2TFRqcDhSZUlY?=
 =?utf-8?B?VmRwYlJlMUJPeUtTUTR1L28vNi9rcStFWk9Zb09qTG5uN2h2TXhnYmZuT0VH?=
 =?utf-8?B?V1dmc3ZsOERvNSt0WC9IdnFKQyt4eHlWRlNQRmxSNk50WjZoVEhDK1ZYSzg4?=
 =?utf-8?B?UmVGc3YwQndoY1hzeS8vdmRTRGxsTnRZYnRWVE40d0ZqcXJmTGJWakZCaGFE?=
 =?utf-8?B?Smd4eWp0cnJiNlFuWnZvamR0cEhtQW1Rc0t2NjZrVWZPc2ZyMEQvY2hFVkkx?=
 =?utf-8?B?L2RkTE1hZGI4SGRmVXN3TkxlcUU0aWt5NGpZNHF4WEtTN0IraVd1ajZnV2Qy?=
 =?utf-8?B?Y3BLYzRVaFQrQllTUzBuMzlCUWlkdGlVYkxpV1pHdkk1S3dNdFFmMlEwd0dW?=
 =?utf-8?B?VTBrNVJMQURlVmcwaUxHL1Vpejh6djhEN2JsNXNsTkFUdHRYazB5YzRqNFBl?=
 =?utf-8?B?b1c0cEJkUmpXNlFCVUZReWJHK0dUalhrVm5haTJEOUxxUVh3SndaMkRzMlI2?=
 =?utf-8?B?SEdsQXE0Nk4rR2xvNFlsRDJKY3NZdkZqaHY4S2hxZCtUWVUyOWRWbVhmMHl1?=
 =?utf-8?B?bDRud1ZqeEZjUnFvMU1QN1F3cUg0WFBDSHMvQVl1aTRwbktpOTVQTDh2THc5?=
 =?utf-8?B?Qm1ncUZSRXVuRi83RGphS0Nad1hNUHNEL0c2Mk9BVzBPazI3OE56Qmw0WjB4?=
 =?utf-8?B?SXpNeXJiNjRnRW1oUm5wY010T3NHbEIzbHhpVU1WTXM5ZHJCYUdmaUwya2ZC?=
 =?utf-8?B?U2Y4SjRXL2xuOEdKc2w4NnhCcHhSZGUwUVVUSnI5dGUvMklicUxYVWdGZG0x?=
 =?utf-8?B?TE1lRWxuWW41SGxDZThOLzkyVnB0Q0JFTnNHaStvNVYyTHRPREdYZUljQmtw?=
 =?utf-8?B?ZmxoTFZjM3VPYW9Jcm04TllXN3lqRzA1Qkc5TFlVTmx5THhEbFVpZFVaREJX?=
 =?utf-8?B?eGJ0dFpkNHdJM3NUcTB3YjgyU080ZC9tSHc0R3ZGdTFvQ3cwUVIzSlV4aGNP?=
 =?utf-8?B?bTNoQjRJRVAvS3hwSXVOZXBTOGZWNUhWV2t1VTJqRXFyZzB5enpIZXpzUldp?=
 =?utf-8?B?bmdxM2VQUXFFTExBMm4wMFMvOEZnZEcxVXd3VENnVms1dFFNTDE0aW0ybFd6?=
 =?utf-8?B?ejFkWDFWU01xZHR4aTE1N216MG5JZFJlYk5MMWU0UUdRSThYZlY0TjBnOWVM?=
 =?utf-8?B?dFpMZ0txUUs3NFFPMDdudTBKMG8wdlhhR0xlQ24vWXFIVVhvSW5nSmJnMzRW?=
 =?utf-8?B?UDdxYjZuS0RYUW5HNkN4LzBwbEV5MmdCZHpHbjhtUmdSN3BTWlNKRCtBcUpE?=
 =?utf-8?B?VFBpWEdHSHhXK1BnWjYvbWZCcENRV2NMYkVubGRLOEJvazFObVBrNEYxUnBi?=
 =?utf-8?B?T2pwekw2TkNxMEpPQkRXRHFIaVV2UDlnWkJvSDFhUlZoMGV6Q3VTNzBqV3Bt?=
 =?utf-8?B?Mkw1SVExbGVuVGNJVVdHR3FTc3VJUVJxTGRMZktKdGdITWZmM25Kc1hZSDRL?=
 =?utf-8?B?eUJua0s4OUpxMkczVXEzVzNYZ3JRQ0lnR0MrMGFPOHY5TjdjZkg4U3JmcWUv?=
 =?utf-8?B?Y1picjd2Nzl6WVlJc3VBMjlmWFJoM3RQczE4V0pWdXBoTHoxdk9QT213ZGZY?=
 =?utf-8?B?bHVkbW16UEtZSFVjdFBoeFBxSmhoa3VVMVlXREpROEVOblJqdVFwcHRsL2Fu?=
 =?utf-8?B?ZStoYnpUWGwrMVRUdG9HSll1cjJvelZRaVIwU05uaG9FdDV1NndzamZBSDlR?=
 =?utf-8?B?M3BKeS9MUVJUZGhVbVlBam5tS1lRemVpSkpMcG9FaXlkNGtDWjFQQ01EZkhj?=
 =?utf-8?B?MHdTRlVFeEtwaGROUXlYdXgxb3VyUzlHdFRlcCtmai9vM1NZUi9Fa0prNW16?=
 =?utf-8?Q?CyEU/xWdx8kvWRNIGlyU9el15PfXlPgV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ZvbWo4SjJEMjduMkwrRExVK21nUWlvcTFkaksvTHlyY1VnbUd0QWFlTTFG?=
 =?utf-8?B?eWtFYm91MVNCOG4wekFNeHRrRVgwRnRzMVZEN1BDV1BybkRiNnFaUDQwRE9F?=
 =?utf-8?B?cVM4cEZvRkdwUGtua1BqRk9zTS9SRTFVbmR6WkJla2srNUIyZGxTVmU2MUg1?=
 =?utf-8?B?TkVzbncyOFAvU3F0R3JVRGNsMnM4ZHBaVzlxSzlINUNNSGxsUlhsRzdwM1Fj?=
 =?utf-8?B?Q3FLTnUxclR6ak9xamlZN3hRamg3L05Bc1VXTisxYnFrbENqbjJ4VXRRYkUx?=
 =?utf-8?B?bjlxNCtDT0daT296QkFMWFNzK3VTRlN2bmFzZ2pxbTY0emVVWDU1MG9ES05a?=
 =?utf-8?B?ZUlrcXN2V0RrRTNuWFl3Um50K0t1cmJ4cGRaYVljNXFJMUZmYWN6Uy9hUDUz?=
 =?utf-8?B?dUoyMVAyOWVaL28xTmlHNkNQV1ZCaE1mNFNST0lKNGtSOEx5TWhreFNIRXZo?=
 =?utf-8?B?azVrY0NVTnZSWjFnMW9wb1EySGtzTHlpaTlRcWErM2dkMlpJaGtyMjNlT3BR?=
 =?utf-8?B?YmlkTUZidzE0OW9nejhVaThtc2pwMlRraVJnV3Nod1owRURjK0JNQVVITFFh?=
 =?utf-8?B?S2lpYnM4c3dibGVpU2dlak0wNXVxVWd4aGwxa3lpVGdvWEVwN2FWZjNhRkRM?=
 =?utf-8?B?UEVBMG03aVY5SUlKeFl2ZjcyQU1nSStKZ3RRZXBFWkFHRUJrRUxrRHM1UWpX?=
 =?utf-8?B?ZjhhbnpQT2FZbkdoSUsxb2RYS2NaOTBLK29DTDhvOWFheVk5cTlwQ3M4T2F3?=
 =?utf-8?B?b25JZHpydkRKWFIxTjNMMFJQUmN6TDVLRWEwdkh1emFQL3FuMVlHVk05cDln?=
 =?utf-8?B?NEUyckFTbFo4Sk1COWxiaXdQT3NheE03QzdPcEtrVmh1YmtVMmhzUktGcm9i?=
 =?utf-8?B?a01aWGEycG85VlVraVlLREVQTjVtMS85L2Y0bkFaQ1dmdzlkN3FJVm1ZVkNq?=
 =?utf-8?B?L0ZZeXRqTWRWcm5MNlBLQlBBNTMwekkxRVhsR000ald1ZCt2bXA0RXZSa0l4?=
 =?utf-8?B?OEliZHNkV082MUxKekk3T0xsNmV3SHhnVE5NQkx4RVBYUTZTcnQ5bkMxb1NO?=
 =?utf-8?B?UUo0UitBcnhFbEJNNzc5ak55TzJvYlZoMDVqSVpPSUlodnh0UDZkYWgzdG45?=
 =?utf-8?B?SG41OFVEbDJlM2VGUWlCU2ErVytjbUNpQm1FWFB2NUZmY2g5azNKNmhqVGFC?=
 =?utf-8?B?STBSeHBSZWFpTUZ0b0hyL2IyWnpjNXhqL1pZWDR6VkNLZS9PMzNZRm1HRUo0?=
 =?utf-8?B?YVhHL3dkakRjSFE1K09aODRaaDZIVmo2RldTMFVMS1VqL3lzY1JxYXRTRWNM?=
 =?utf-8?B?UnVYRktVNDRxaW9mRDZpbjZxcTNjOS9mY2NxRldtMUozUHFNWlBjRTVzamtF?=
 =?utf-8?B?NG03RFcveWRzeHMxQnVpN2s2SXB6NGZnMzkrTkl2QjdRK0ZaK2Q3ZW9ua1FQ?=
 =?utf-8?B?R3IxWUhTZVV0L1JyTDAwWlo2eDl0eVNFZmQ5WU9lVkhRTlhVZ3M2N2xQd3NQ?=
 =?utf-8?B?ak9hRE5HUUF0cnZaQitPb00wSTEyUXlQTnZobGFsazJNMm9sNkhFSWVvL1JS?=
 =?utf-8?B?U1BEMFBTK05UYThlNWZOQXA5NkwrSWxqU1BCRGlvZXFSQ2lCTGlUMk82LzYy?=
 =?utf-8?B?aWRaWHpNWXJ2cmZldVhjOERtY1JKQ3RBY2xodks3aklFcFh2Zy9DU29BSkNQ?=
 =?utf-8?B?OVdrbUtBejRyT1BVYVdTZzIrOVJvc0F6MHhvRnZ1U09sbGdDYzVJd2FiRG9H?=
 =?utf-8?B?UHVXU3hXWjVtSkdSUmw3ZXRTdTJ5MjBoSHRRSVJFQTBubGw2cnZxT0Nwd0Zx?=
 =?utf-8?B?MEJEdEhHUHRWUHFMS1NZYlJEYnZidGpVS3g5MHBSSWVnYnF6UFBjVEk2VTNN?=
 =?utf-8?B?M2FxUlNBd3pRc0U0N0tmWTRpOUFrMjVXcVltMmRzTlFwekVTVjVQczA0RGlT?=
 =?utf-8?B?amsvbzY1b1puNnFRbFhkeE1YaXl6aGI0ejdVSEdwL1EvVm5HWExaY3k3aW1G?=
 =?utf-8?B?NFVOUmZTLzJiTERqbmJLN0l6d2UxUDdHa2ExeTdZTHE1WGZ4L01LRS9yVm9H?=
 =?utf-8?B?Z2VxY1VIenVkdmw4T0RiVlVYTFNyVlM4SjlwUXRlZ0hpTmo1dW5IWE5jVzVW?=
 =?utf-8?B?VzVaYXNOYjdZWm5pSUxoWVFIbFpCRXJDbFh1ZndvZXhSdmh4Zk1rc2hZRnNT?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f363bf70-f23c-4b3a-99b4-08de21478e67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 17:27:15.2492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr2ap5EEmym0AqjoKThWAQ11abNdO2tWzLSoEWQ/rDB0mmntrSNuh9bJbDTx5rgSSmvxIALYWvg1xVw+MwTEpMLG0RAIIP2Vj/K0N5eItpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
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

Hi Rasmus,

On 11/11/25 9:00 AM, Rasmus Villemoes wrote:
> On Tue, Nov 11 2025, Anshul Dalal <anshuld@ti.com> wrote:
> 
>>>   static int do_part_set(int argc, char *const argv[])
>>>   {
>>>   	const char *devname, *partstr, *typestr;
>>> @@ -273,6 +282,8 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
>>>   		return do_part_size(argc - 2, argv + 2);
>>>   	else if (!strcmp(argv[1], "number"))
>>>   		return do_part_number(argc - 2, argv + 2);
>>> +	else if (!strcmp(argv[1], "name"))
>>> +		return do_part_name(argc - 2, argv + 2);
>>>   	else if (!strcmp(argv[1], "types"))
>>>   		return do_part_types(argc - 2, argv + 2);
>>>   	else if (!strcmp(argv[1], "set"))
>>> @@ -305,6 +316,9 @@ U_BOOT_CMD(
>>>   	"part number <interface> <dev> <part> <varname>\n"
>>>   	"    - set environment variable to the partition number using the partition name\n"
>>>   	"      part must be specified as partition name\n"
>>> +	"part name <interface> <dev> <part> <varname>\n"
>>
>> Nit: Shouldn't this be part name <interface> <dev> <part> [varname]
>> instead?
>>
> 
> Yes, probably, I did notice that, but I preferred being consistent with
> the existing cases which also do not indicate varname as optional.
> 

Let's not be consistent with a mistake if it can be fixed without 
breaking compatibility. From what I gathered, it's a simple help text 
(and maybe doc) update, so i think it's better to fix it.

Cheers,
Quentin
