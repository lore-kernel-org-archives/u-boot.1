Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F44CCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 09:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6853F83655;
	Fri, 17 Oct 2025 11:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fsj1QxWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F44B83710; Fri, 17 Oct 2025 11:10:00 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDB983631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 11:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Et3IhN2F0EgnMNzCK9GbB8btu5f4Q5qKw6ZpNi4PiisvSLDfN4OT2jKvUgJgQ/iwtS6fHVhUzFGhO//PGr9S2M89alkPgKKxrJ8XkXxBhOW5+0XwOIgS5yiWLD2+pBmf+gPMF324dPDPR1uenhLjEhgzeX/aA8rlVjhdIQmGLRkHNeweisTBGGlm8voOJbl8aTkjfsUJHpdEHW6jO4P0sw7cxgSM+HKnp+IaIvVfHeHSTKM0FN8mpoYmU9kr84yBS1Z/f57tw9F8yZurePsX+M1YjMIcGeYbhMZfPBpGQmdOEMPvAghYybbXu9yG9PNVclkUdAusiJXYcLGeefUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwdN+xjIrb671MxK3IfoGmbE1KZuXBi2ZJvRmFBiB5U=;
 b=vFKtvdg6rDubR/KZvHbMMLBukWIx91SKVUALSkmfYCBatjgLAkqiMfTR9ig07k2iVV5gt4pB2V0X5QVXMko0Y8LzYtYJVpF8+Mru/fEjvZq56Mnbr0MJR7ZbWxelreE1RIdjttpMUOnj4whiQORMcLvLzv3oeCa5YSnWustJ+3c3B/WBPRsuz9eghU6ycuk3c+0/GxIKnsJUWizO/uFmonREJPjiFxdMnS6NU+oiLJHMaoQUd7/Hei23rq3YrxFkuf2M6L1AlzFu6riK4b1bSgmXnphwFwTQN9lS8O+5SRQjvC2mruaMjwMSosX6GXu2OkEOzRZx+DtgwW8Gog4JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwdN+xjIrb671MxK3IfoGmbE1KZuXBi2ZJvRmFBiB5U=;
 b=Fsj1QxWIjXMiDKpqz+x8VcqwcJHVGCo3/sKZ9wr+4VvGl07IIulC75V5v3J8OYEKsapB1rFobOqNHqvfHuXEVP7wCgNzzen9fvJcHDGRdmEAyHdWisnBenKXrSiS5Gi8ovS2pwh9qxFg2cRIilvA++dYZET9h/Za4XY0atLwXf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 09:09:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:09:54 +0000
Message-ID: <02ff09e3-9642-43d0-a4a6-222052080ef1@cherry.de>
Date: Fri, 17 Oct 2025 11:09:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/part.c: implement "part name" subcommand
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20251016125247.1594643-1-ravi@prevas.dk>
 <6e85c247-9624-472c-bbdb-b35be4fa03a4@cherry.de> <87ecr2ndjp.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87ecr2ndjp.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: c427f3a2-55f2-4d09-3a66-08de0d5cef5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTNDQnM1MTVEaTBoTmdIU0VPRVkzdmFuZGFieFF5S0szQUJIaDRTSlFERzIr?=
 =?utf-8?B?dVB2alZlMGRjQURJQ2pzSGwvajdJNTdld21TOUNOWnBaTTR5UERJY2JOcHFi?=
 =?utf-8?B?d0NTZkNkaDExM1lqa1ZjdEhmUHMwUnNHZWZ4WmIxcE56UDdBTkFMWVN6UDE4?=
 =?utf-8?B?S2w3R3NpZkY0OGJIeUtaTXdxQk5KVVhiU1dyZTMwRkhYbDhGOTFFMTBUUXov?=
 =?utf-8?B?T0MxS1JkU1NJMXd5Z3hLcHBWUE00ZnVPdENsZTczUlJFbDMyNGh0bkIxd3U0?=
 =?utf-8?B?U1lIbFJNM25Zb0lLZ2RCQ1RVdm9ZOGM3aEw0S1ZKZitwNFhUeFdxUEtybEo2?=
 =?utf-8?B?NU4xYjI0ZjdnbVhiN1RHN045bStqRkxnUTBDWlBEOExLOXlvQ2RYdGdNd0xl?=
 =?utf-8?B?Vnl0VWN1Ym9WTzlJS2tqbjNtaWFYU1V1c0tOd3NXTUUrMERYZzBwWG9RQ25J?=
 =?utf-8?B?bkFFdFF4MFo5eURRN2p1bEFURkdpajNxRXhJcjU1clQzOFhVY3ZwY0p4SDBt?=
 =?utf-8?B?NFhCS0xWZk9ZWkJuYnRWUGw1SGpRdVB5NythWkhES3lYSTU0QW5PNFNXZUVx?=
 =?utf-8?B?Y2h3ZDljWE9tUTJwODFUUiswUHB2NmRwNE0vQzVUbFhHd1IrRjhobmJ3UTZj?=
 =?utf-8?B?eWZHdmx6U0cwdmhpVWlyVFM1em5RQzRjN3pTNGNTbCtVY1pGK0hYYTk0cmNB?=
 =?utf-8?B?RzEvUGNySExTVlRhT3M1U1VaelVGZ1ZtKzhTb3ZPSDZ1VXQycEVGVURoaFdY?=
 =?utf-8?B?SENNWEtOUDlFWUZwbTlwTDE5ZEFlYUNVRzdDeWMyd296Y24wNHJZMkVRc1Jl?=
 =?utf-8?B?ajJ2c1llMGdjZlBlaWhNU3gvdTZvaG1aSzdhR1Y2c1RBNUlLV29NMWZwU0w0?=
 =?utf-8?B?LzhQVzlsZFZaUDVlQ3dBcDFlNy8vWGtaQWVMd3d1b3VlYTZwWTR6OUJlVTFD?=
 =?utf-8?B?REpRaXptNEZmNUVkb0VmdGFGeDdrRzFxU0NlbitScjhFSTV1dkVLb1I2akpF?=
 =?utf-8?B?U1QxblBCZW1taThkK1lQNWk3ZHQ0aFdieDFVYi9TUFpSMlJiVDBmckJ3ajJo?=
 =?utf-8?B?MjZZTG5ZbHkzRG1teHZlY1Brb2YwcGhJcm5wZW1sM09pZmVabnkrVzU0N25C?=
 =?utf-8?B?ZlNLbjdFekJOdXhrZVRaOGZMUWhDZ1FYakx1R2RxR2hxVm1xaEY0TXJaanBs?=
 =?utf-8?B?ZWNNZVRVVmJNNG5Yc1o2cEwvbDhrQ3lqQ1lsMVRiREVIRTNJSUNJaVJhWitP?=
 =?utf-8?B?aHNqa1lXL2d2M3RDWVM1T3dUN1FrTHBPZDhRV0RtTHlwQUNycWZURDNHOC9M?=
 =?utf-8?B?WlN1Q1pIbDA1cDMydG1ucmh6ZHZxVnhQdDJQQkdzamgwcUZDMUFYa1ovTVda?=
 =?utf-8?B?d0ltTDBkTDBEVWtySXJ6Vmx4N3RVQlIyb21nWGhYclFpaTE0Ym04NFBjaXJl?=
 =?utf-8?B?QXRWd1Z0KzNjQ09aTm1BZmhwdlNZRzFUWjB2bzE0V0FNY0RQdVdmUXI4V0lx?=
 =?utf-8?B?cFdCNmd6cFFUL3BPUVZNNFdYQ1IvZzBKZ3J0T0FtUk9SRUd5REFlUS9OeXFW?=
 =?utf-8?B?N3NPNHM4OHhJc1VQOS85VHJFbzd1Rm42VENOb0xrc1hDc0FIKzAvbVd3VXRB?=
 =?utf-8?B?aXU1Rzg5VFVkWERpdnUyMTZIZ2hCcE5Gc1RjaEhCZ1R3b2tXTTdYdG52M1k0?=
 =?utf-8?B?SVJPa0FnN3lKNVNKaEtQcDdQcnhVZWRsclBaaWtZWGN6bzZsUEhTYlk5T3Bq?=
 =?utf-8?B?T0N0SnlmTWExQ3B0VGJReHJxTEVDZHA4S2I5aXNydFE0Z1VBK05IaHpZWXhS?=
 =?utf-8?B?RUlmV2FibG9DaSt2c2thZkQyOUxJQXphNDQvVW9rcjlIM0FJTGZpcFB6SFFO?=
 =?utf-8?B?enpQd1dBbnVab1BoWmh5WjB1TU1mS0xlQzdNNVFSdE9RZEFRK05WWnVEVjNk?=
 =?utf-8?Q?c2qSelASaW8kKcFr3oAqlE6Fixudgd/4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0laWkxOUVhnN3JycVo1QThoeS9RdTVjbG5ZSUt2RzBVcmRBcGMybHljUVQ5?=
 =?utf-8?B?VHBFNkNCbW85SjZZaUxJMG1vNm05YUI2R2FLWEcySndZdEVhYzFWS0VnczF4?=
 =?utf-8?B?dUVQVHpIcFgyemRGNFZwRGRVdEl6NUFnejVPenJOTGFRQkJQMkI0UnprVDhV?=
 =?utf-8?B?bmNjTzc1M1hrY1BnNG84M2RUSFJyZy9LM2ZDRDgzcUZMQjdENTVFV0Ivd0hJ?=
 =?utf-8?B?Ry8vM0hmZ3lpNlJ3OWlnaHd3QUJwbm5lVEhVZGp2Qy82SUJ1NUxDNDZNV2lN?=
 =?utf-8?B?L1p1VDRyK3BMbTAvdkp5NFM5U1VyREVQZGFpU2hYZzA0OHN3K1NkVkhtZE9T?=
 =?utf-8?B?bUhvYndOSkUvZUdtc29qYTROTFh2K2c0aHR4M25qang0cEZHSC9GUkh2RXc5?=
 =?utf-8?B?dVh6cnZYa2Z1dHlOMU04MVE4U0IzUkZtaTdQU2MwdzdZSzd5TmJLSStRRGdz?=
 =?utf-8?B?Rytrb0swcnlkc3RaUlRZWUxGVVlJSU9xOVpnS0diblpIcmE3M0RZcGpkZjM0?=
 =?utf-8?B?b3ZtVWxQOUxpNXRFek1leTZXYTRqRmhQbUpoK015U2QwRWZ2STYvSmFyQzI0?=
 =?utf-8?B?emlubFIxK0FoK2NqaXY1aTh4SEVjWVhzSUVLUEJPYncrQXlEVGd6YXRRbzc0?=
 =?utf-8?B?VW0yd1dKTnhhdWN2Zm5FZ0JyWEF3ZFdPTFVCRi9xeUdQZ1JuaktlM1VPRDdH?=
 =?utf-8?B?VHpHd2g1ZmdGUGlpdms2eHNHWlUraU9VNHQ2NG9PajYrTG4rM21KaGNXajJR?=
 =?utf-8?B?WklJYnBvZzhYTGZ6bjBnVDJ2OTROdXBXR1FMZlkyRE1zUVVQbnprN1dUem1Q?=
 =?utf-8?B?akt5NUdISXVrMlRMdk95TWlzcTNuWVJpRzVYUjFDWGo1QW54KzFyRmZYQldY?=
 =?utf-8?B?MXBCUXNoem1rZEc3MS9DRVFEV29ldS9rR0ptN0JGeVBzTnkxcGI0RFBCL1pQ?=
 =?utf-8?B?UUs2RnhpSjlLczEzTHZITWdXSEIwM3kyU2FhNnNjRW0wNVBoME5OYUIyVmpU?=
 =?utf-8?B?OWZaVFBCeDZLTGRSSTZmWkRSWU9xU1NEUzZkZUo0ejFEN0FoNkduUHQwYkRL?=
 =?utf-8?B?eDRlc1hLZW9CTFVqbFRBSHVZSlppOVNaU1VtUmhEUnBKQUoxdlltdXNBMVZB?=
 =?utf-8?B?YmxoRlFLK1NQWW1NWjFjQStVbDlaZk82Um4yRWJWUVNhSXNIRlUvZTNOWExa?=
 =?utf-8?B?SVg1a21RV0RCMERvbnR4ZjR6cHFvV0UvM0xnSGhTOGpwR2k0MnprVUx3SjhH?=
 =?utf-8?B?VUZmeFRsYnpXZFVidlZRejlOQjg5amFvbkQ1MVptek41bUJoUjdjWThqNUlx?=
 =?utf-8?B?bFdsMUhGUEtUdHBJN2luTmtBUllLdUk2b0U1a3A4RjVVMW1aSUs0NzZzRlZI?=
 =?utf-8?B?bHdrOGZ6b0Nyd3YyYWhEZ1lEUkc4SkoxaEZLVnNhek00cnNYUjlmbjhuV0o0?=
 =?utf-8?B?NG4wSVBhUHhKQm9STzNWdnhuczdCSWI1MzRnWEJTQ2I0S0d1OCtzUkl2WWtv?=
 =?utf-8?B?QlBpWWNyUDNxRUg1VkRUbGh6bE9XWVNpTFB1QXJIYkUvelpQSHVTcEVucjFP?=
 =?utf-8?B?UVpIMXBQRDh6VlNsbVdlaVRENWpjL2ZaS1RWb0lTKzJ5Uk8xckRUMUUvQzQ3?=
 =?utf-8?B?aVZoeXA0STdmK2doWExXcnFhQ2kyN2w2MmdmSktlOSs5QllBNFlDQWh3L3pu?=
 =?utf-8?B?WnJxRjQ5SVNreHFueWd4N2liNERCdDRnQ1IxZ0VTWmNxLy9xQ2JNcDBqTENq?=
 =?utf-8?B?VXlMa3dTWFJ3NHJYZkJWa3AwT2FGb2R2cVZKd1pvZ3h0S1J3eXN0YnFmdXBt?=
 =?utf-8?B?TlJVcEsyekdYSDVYY3pGWTVNb1ZiRVhXV1ZaWG5nN1F4ZkljVVcvMVA1bHAw?=
 =?utf-8?B?aHpiL2NNSG1uKy9IemRQaXRrT1I1WUJJc2RUYXQxQzJSMlYydzU2K3ppNjR6?=
 =?utf-8?B?YndDNEs2cUZ5dTNIRmh5aGs1N2V0THlaUmJxbzRSK2dLZWRaQXBTREJmNXU0?=
 =?utf-8?B?cXlTTkhsZ1NkVUVmUGs2Y3lMTmxjOVg1b1ZyRjZKWXJkN2ZoalNIR3FDTkpu?=
 =?utf-8?B?angxNnp2SG8wVGRxUlBCS0k0YkFsK0FjQlhtanZHY2pTcGl6NkhaWnZ2WFdU?=
 =?utf-8?B?NTVMUlFvVG5GclhBNHA0RnZjZ2VSeUthOTRGOWY1a0d2MWwrVDR2YWhaS3pk?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c427f3a2-55f2-4d09-3a66-08de0d5cef5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:09:54.1462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QDxyx2V9k6HhJ5KqbpjL2LpfiXURu0AC10rNEG+pj+R7IA/xxTMYh77372wBuKPUXEX9sWn8xXr/8xw4hGyWNmY135dnjtMKMJ7Yqqd330=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028
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

On 10/17/25 10:22 AM, Rasmus Villemoes wrote:
> On Thu, Oct 16 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Rasmus,
>>
>> On 10/16/25 2:52 PM, Rasmus Villemoes wrote:
[...]
>>>    cmd/part.c | 16 +++++++++++++++-
>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>> diff --git a/cmd/part.c b/cmd/part.c
>>> index db7bc5819c0..975a0a08a99 100644
>>> --- a/cmd/part.c
>>> +++ b/cmd/part.c
>>> @@ -25,7 +25,8 @@
>>>    enum cmd_part_info {
>>>    	CMD_PART_INFO_START = 0,
>>>    	CMD_PART_INFO_SIZE,
>>> -	CMD_PART_INFO_NUMBER
>>> +	CMD_PART_INFO_NUMBER,
>>> +	CMD_PART_INFO_NAME,
>>>    };
>>>      static int do_part_uuid(int argc, char *const argv[])
>>> @@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
>>>    	case CMD_PART_INFO_NUMBER:
>>>    		snprintf(buf, sizeof(buf), "0x%x", part);
>>>    		break;
>>> +	case CMD_PART_INFO_NAME:
>>> +		snprintf(buf, sizeof(buf), "%s", info.name);
>>
>> Is it possible info.name is never set by the fs/blk driver? Should we
>> initialize this field?
>>
> 
> So I took a look, and it seems that all but part_amiga.c do initialize
> it.
> 
> - iso and dos uses part_set_generic_name()
> 
> - mac and efi have real data from the partition table to put in
> 
> - mtd also initializes name, either from a name defined in mtdparts or a
>    size@offset generated one
> 
> - ubi uses the volume name
> 
> I suppose we should make sure info.name is zero-initialized (or, at
> least, that info.name[0] is 0 so there's a valid C string). But I think
> that shouldn't have to be the responsibility of every caller of
> part_get_info(). IOW, I think we should just add
> 
> 	info->name[0] = '\0';
> 	info->type[0] = '\0';
> 
> into part_get_info_by_type(), and then that's a separate patch. WDYT?
> 

Yeah, something like disk_partition_clr_name and disk_partition_clr_type 
for example and call it around the other disk_partition_clr_uuid() calls 
in part_get_info_by_type.

I think this should also be done by *any* caller of drv->get_info? So 
likely in part_get_info_by_uuid as well as part_get_info_by_name. I'm 
also wondering if we shouldn't clear every member when iterating with 
the same disk_partition, e.g. in part_get_info_by_name, 
part_get_info_by_uuid, part_get_bootable so that we don't have leftovers 
from previous failed loops? Essentially what part_get_info_whole_disk() 
does (though it's missing an init for sys_ind and type_flags). Mmmm but 
that would mean also patching the loop in cmd/part.c:do_part_list() for 
example. Or... maybe the whole thing should be a responsibility of the 
get_info implementer (the part_driver) so that calling get_info is 
always "safe"?

That would be a separate patch yes, but likely before this one? Or have 
at least info.name[0] = '\0'; before calling part_get_info*() in 
do_part_info()?

Pfew.. seems like a lot to do here :/

Quentin
