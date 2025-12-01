Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7CDD116E2
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71485839D5;
	Mon,  1 Dec 2025 08:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nUS1lX7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF9A839FA; Mon,  1 Dec 2025 08:54:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57FA83966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUEDy0pEoPPeIqUVFQZJBg1a7q7Y4fGqHqdiLi279dEesYORWdiozPvrQVmfN1bCnp+p0Rd44k0I9r5JUZCgaaAC989WbgwCrvvG3Oy3PgHFZ/Zz4a5tMsRQLzz8h/24sALU9ZC/DAIbGJvbFDu95MOcNJ1glTwyiO70hIq0lD7hjMINMKuOj9iaQLclHmTpyYw7KejPkGv74Z8uz2g8/3hg8DmxbvbmUoD5e1tCI49rdm1HiAlCjrCE7DF2EFunUnQb1Qcw6kJOgLaKsuai6dhza8qTOZUVa3tamWCJCTXgeodPVf2siiZlRjjQLUNn6xRSQz7EaCdW/YAZrzUJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9JSDIawGIJlDtdSpyauRAk6arphaYhq76zt4RKy4SQ=;
 b=X5uVt4Sab/rF583LwM/5p9eteroq1aNO6kqxuQbGz4Mf0akGTjUif933fiAjLC8YvOAPeEVSRCeqzaSFBsUM8QFSy88KZ2v+SVLann/P3g6kropg+yZ5iQ69GJnTVnfw6Ii9INgczGaeJ6jYfBSltD7gvpPQVokSo1odKmd84QRKgn8lmG4xayOKi6Apf+oQjBqtuYCNjs6+F25Rhvc6cvdLPX3ICw1iXxWJzO/wVNKtaKaml89bHyMYj3skxsKW57K9N6ZrAogFMi2PoexmRMoj3+Cw8MwRS/+Z2oasi+Jq0erjvuZQH2EhHSiddHdj2NSxnhE9wxpcXn7lH4SG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9JSDIawGIJlDtdSpyauRAk6arphaYhq76zt4RKy4SQ=;
 b=nUS1lX7yHxalRCplOVHO2jeszmPcC8fJztzje3guQteVm4CFlphsvuzKxFW1LdYu9o/IMnmmlIdUazGXLieX2z7CQEIZ6GW1FCayHXRrYTGfFwtfXX2NgWISid5wzAW0VwN6DsiBz+xWuvFtSH/az0Y2eBdSKx6rVOGxmb/oHqpwwrfURbtDFTDHafLJNyo/HsiT2LV2qnGzaOX00tvglybA+KACeAkhA80e4uQm0yacjOqaFM0c7zC7XHs+7n8AIjDXwQh6mPbLqVkQhGzwSjSQvUENmGOM5XzQTgCzFgG/BkurNsGi0U7Q0yP/jqMLTQQaLNKKFg4frmhDJyT8uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB7794.namprd03.prod.outlook.com (2603:10b6:303:275::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:54:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 07:54:24 +0000
Message-ID: <a2600334-a459-4063-a76c-cd14b8698356@altera.com>
Date: Mon, 1 Dec 2025 15:54:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251119111653.456-1-briansune@gmail.com>
 <fcb799fb-4eba-4155-aa0c-46b5279b7171@altera.com>
Content-Language: en-US
In-Reply-To: <fcb799fb-4eba-4155-aa0c-46b5279b7171@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef51a27-d811-4741-4788-08de30aed247
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHo5UmZHWHZRbytZVkVRNDRsSmY0TERMeW1VdWRXbklVUXpzcGo3cllJakxO?=
 =?utf-8?B?U1kreDNtNE1QT1Jrd0FqRndJcnNRQzdQdE4rUndycnlsVDZpZjE1bFpjUDVZ?=
 =?utf-8?B?Tk9FTkgxYzRkSWdmaW9UZnJhbWV6R20vU083NGNiM3U0T3N0ODlQRzJGMkpE?=
 =?utf-8?B?c0ViOWtrT0VmMkxNT2N4dE84UzlMSnRoaXZiYVZkQTVQWndpMGN6V2llSnBn?=
 =?utf-8?B?SzZpQWpvUDgwU0F1clZGZDFESDhNdm56NmI2Tnk4QklqY3lwLzNjSWxmcGtE?=
 =?utf-8?B?L0JhSytIamJGVHh0dS9RaTJLb3o0UStpUW5LU0hUK25XaXNjZEViNDZjL0R1?=
 =?utf-8?B?M0hteHNsbmhCV1BnVnZtcGdyL1NGNzg3RGFBODl2dzRFSVdFWlMvRVhtbEdv?=
 =?utf-8?B?N05sdm5QRElzb0VINUtBZWxwZktuM3dMMjB2dE5OSHhLTEdlaXZjZ3FlSVdx?=
 =?utf-8?B?c2FaUFZrMWZiSGxJaVlFeXh3aTNobm5jTDFtU3dwR2Z6STAzakhicENpTHN3?=
 =?utf-8?B?NFVGUkpod0NpeXpjU01kdE1yOEh5YkhsL0w0TC81S29wZExFSVRFYldUZnhE?=
 =?utf-8?B?NDFQTEo5L012bnZkdTJKUUhRSnVnKzJqUGVURmZtZjhxejJJMWdMVURyQWI5?=
 =?utf-8?B?VE92dm5jWnVCRWpRUWh2R2I4b0F5U2twRTRoZDFXSTRnL0NwRXFveWpIQUIy?=
 =?utf-8?B?d0hrS0pESGdSQjBIRmVzRWNYbFNWQUJoZEI4VjhnRWlFbHU2TXROUjB1NlhP?=
 =?utf-8?B?RmRZdUt5NUZTem0xOWxIdjQzQUFKRHUwekYwaDJjQVd1R3VQM2VFUkwvOElt?=
 =?utf-8?B?aG1wZlpmeUp1UkJCRlFIbkVDYncyaGZ5M3dnbC9GSWNVcTdsTi9DVWNlVEdX?=
 =?utf-8?B?azREdG1nQmxxdUJMUk9xeGxhNXBSa1NBNmdYemlKN1FPWXVKK3cyaEF3Wmla?=
 =?utf-8?B?MUd5UzE3L250c2MzZ3VEUWwrY0ZtVUhoOUVoeHAwWXB6ajVSdlA4Y2M0QWxU?=
 =?utf-8?B?ZXR1cnFzeGx6TTh5NGxkVEw1TFpxV2hRaHdPajFnc1RvWGs2RjRGU3dvNko5?=
 =?utf-8?B?bHVJT3czWjlqVDBUWmIyUkxSSUpoRjhtN3NwNmxGWVBwWmdINHMxWkd2bEF0?=
 =?utf-8?B?dEhoUHlsUWJvMVcxdTN4OFpPZFNiam5qZjB2U1BiS0xlK3lMa0lhakhZQ2VW?=
 =?utf-8?B?QXMxczdRdEE1cEJ2Q2NjSXlEeXRrRHRJKzVRaldFaTVWTk44U0F1Q1VXQ0Fy?=
 =?utf-8?B?SXJnOFpIc0pzeE8rcHB3Y2lBa21pVFdIRlpsdytjc0NNaDVpWTJGQ215eWJl?=
 =?utf-8?B?RUFBSTFHVWE2TUh1amQ1SDVFMEV6clNwMGwrUS9rMkwza0dvQW8wSTFwcEJF?=
 =?utf-8?B?M0R0aksyOXhVTUU5L0g2WktaUUtXQ0FUYkNWVVV6bURkc3ZpdHVSU2FzeVhQ?=
 =?utf-8?B?MTFWVVVvSTQ4d2Zoa3hzOGszaC9mOXdCQk9SdU9HU0ZxMkJsUnRHWGlyd2Yw?=
 =?utf-8?B?VTFmKyt0ZWQ3aFZqOTJWQVZaMnMrdmF0cHdFa3RvbDNvZXRlc2t1S1IxOGlX?=
 =?utf-8?B?TVZxMU1SYm10NngwcHNxWnVIakdONy9hMUlLdk5IdGMydm8zTjVicmpDdFZp?=
 =?utf-8?B?ZXNRZjdaNHd5amt2Rk90QlRWb1JWN0ZPOE40SWQwck1KblpEeTd3TG9RSnVm?=
 =?utf-8?B?KysxQ3pHcitkWjRwTzlRM0ZsS1R6SS9KbjdnalFpRlQyUG1iMXM1VG51dGs1?=
 =?utf-8?B?aXdpck0wZUljeTNUZ1pJb0Q2WlVwWWFBcERGVm81cmNZekN2QjJ1d0VTc05J?=
 =?utf-8?B?V2N6amFhdFhrU2NLdFhaYW10Q3AxN3B5OTl5dEpDL2E0M1ZvWU5qVFZlOG1x?=
 =?utf-8?B?UEEzVjRENnkwLzFZVDdMeFFJTDd4eU5QSGp0VGVjQ281aDBOT2UxZTZXTHJh?=
 =?utf-8?Q?s7xqQo1ltaG9/ZcfJgWVfx4zx7hDpzLv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBnOHNYS3NISnh6YWhOaWY5NTdmWmpMbWJQdlBhbEk4OXlPSjVkSUIyS21G?=
 =?utf-8?B?enhQSlJYTkdDMjFLR285MUNaQWRLaWY0bXgyWGJlY2NRM3poWmhEUWhGMCtM?=
 =?utf-8?B?U3NhWWk0OUxtMkhnOTBoWUdWV29OUnFaL1pYK2FWQ2UyWG13bDRCNTcxZzFy?=
 =?utf-8?B?ZlVYMHhBaS8vMFhlaTNTelFlSGR4V0dsOGVkYWo1NWtTbFNJb0N6b1hmazR4?=
 =?utf-8?B?Ymczejk4bkZXTWJ6WmtldWtlaFhqUnZUL1Q5UHNSMkVYck8zQk1nT2prQUFh?=
 =?utf-8?B?UVY1MkY2R0ZjR09lUFNRa2p5M2UwT01lRVpTbEJYQXl2SHd2d2NpbHN3OGdp?=
 =?utf-8?B?WHIvVkxNUEYxSU1VNGp3NUdXZU5BbnFKTlY0UGZUUG03ZkVQVTdraVBnaE5o?=
 =?utf-8?B?b1loMG52QWJWeXdFckJBbHlqZGtIYTh0RytWSFpOWW0rVk90L2VsSERhelp1?=
 =?utf-8?B?YXJJNS9maFpFbktMZzZFTjhZRTlXTm5FL0E0VUNVak9IRUphV1pTUVM1NEZH?=
 =?utf-8?B?OVlPdnBiQ3p0eHpjWjdoOXhseXlWTFljblZEZG1Ec2tBc05rTmNPdFpoYk81?=
 =?utf-8?B?SEFKZ3dJUFU1VUdRVktXSUNKU29QcHkwc1l3ck1tL0dDL1Awc241eHZtTTZv?=
 =?utf-8?B?RnZRWWlrWTRReWxralEyM05ZVzBUU2t5aEpkQWhaN1U5Vm54TFlVT2Z1Zjh6?=
 =?utf-8?B?SWI2ZmxjUW5JQUFsQ0NTSW1iMURZcU1xQWhqV1R5bURDVGlPU1l3bWtRK1pw?=
 =?utf-8?B?VVQ1MkhpUlV1VFpjYlg2eWJuZWZzVjI3YlArWXl6ZklBdXZSL2FCb1BLbHlS?=
 =?utf-8?B?YXlmTWdMOFY2cTBxVTh5NjU0Y05rNmZiWkRsS2hLT09qb2ZyeWJjdXNjVjdv?=
 =?utf-8?B?L3phUzRYdDRPQ0F2TFpZNlB6WFhiNXRVblN0MUcyZSs0ODB0RU1tOGxvMHhF?=
 =?utf-8?B?UVdQc2YwamxYOGp1T0FSa25Tc28zZmtlc3VJWEdYKzZRUVN2bVhoUUtHKzFP?=
 =?utf-8?B?djZEN1JSWUtoeW1GSkZ3UjdheWQ5NWRZQkxhcEpKcGlLY3oyTE01RGEwZ2xW?=
 =?utf-8?B?ekNBWnhXblFmaldLd2xBS2kyYy8wT1E2UnhwS2dSUFNDKzNRK050QlltTkJ3?=
 =?utf-8?B?M0FIVWhxY1huOGloanFleXlGQmJIb0Fmbm5OYkJYcU9nZTZ6eWNPeUpreFox?=
 =?utf-8?B?eEVPSDcralQ2b0xIOVFFMVJTSFZPSzhJUjVZM3lzQkZGd1d6TktHaVZtNitF?=
 =?utf-8?B?aDd0Z2FkTFQvM3RsUnNuSHpCTklDdnpFRXd0M29NeWg4VThuZitzcC9DRUJz?=
 =?utf-8?B?eXZpRXovbEVlZnE5TllaVTZGUVkvZFhmYkdDY2xDMnF6YTFRLzdDR1JjRGpr?=
 =?utf-8?B?VmxZcVg3NGg5S2g3bGVsZjNVWFhWeTJpUmpMcndoQmg4Sm5ja2w0OGdBTzBV?=
 =?utf-8?B?c1U1VGhZZ3lSTTZYbDR4bUZxR080T2JmeG40VFYzb0lQUnhrUVJZZXBtU2hM?=
 =?utf-8?B?VXpZYVFRb1BkS0daYW1vVmFvMEhiYmx4dUE5ei94TmNiWjBvYmFUQUlSeWxh?=
 =?utf-8?B?KzlNdjl6VWd1Z0RNMGIzSiszVjVoNTc0Y0hrRkNKUDZUUUV2azcxemViWitM?=
 =?utf-8?B?aElXcnQvbjNEU2hNRUVpSURHTk1vb0s4YjVVMWY0bW0wZ2crcDJ3RnFGdW95?=
 =?utf-8?B?MjYzU1cyaXRid3I2bGxrdkhEVjhZYkxwZkpBcTU2STA5eTk5RDQ3bk1UQlFQ?=
 =?utf-8?B?M25WMzRtMVVjdzdLNVZSREp3Q1dhaER1WXlibzVwS1ZndDcxU2xMRDFrRlky?=
 =?utf-8?B?TnVBMGthQnJYem5JcFZWMHE1QUNzRlE4bHFQRXFCMUhJNDhIMk1Fc3IrRlB2?=
 =?utf-8?B?aHp4U1ViZE1ub05MWWszMkxYUlRubGVwRG5aVWJER0hvZ01NcnZxZllwSnpH?=
 =?utf-8?B?eXJSTVZvN0JEQUhXRit4U1Fyejc3UzQ1elJuRVlETUo4S1YrcHRqQ2JNeFY0?=
 =?utf-8?B?YzJESlVQdlI4Ui9xYmJPZGE1alFPMCtXSFJJZEVLL0d4QW9jckJXUURmUUdR?=
 =?utf-8?B?RVpCY0xLUkRMcy9QdW5ZYjh5YklBLzdOWUFUSEwyd2dHZ2lNUGhHL0xGc2x6?=
 =?utf-8?B?S0I3UE9BcWs2N1FvbUZmdVgvOFVvcnBqa1JLMEprMmtRRVB2VlB3clpJb01J?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef51a27-d811-4741-4788-08de30aed247
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:54:23.1180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g0l19SYJ9tbr5KM3ZG4wBFClxF/Zo7uli2TpL7VfMVJsuPjvDYqqKgL0tspFJEkzw0qiZRGqwqF6GKBQBf48P6YWoxCii0ESlgib887Qo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7794
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

Hi Brian,

On 27/11/2025 11:18 am, Chee, Tien Fong wrote:
>
> On 19/11/2025 7:16 pm, Brian Sune wrote:
>> [CAUTION: This email is from outside your organization. Unless you 
>> trust the sender, do not click on links or open attachments as it may 
>> be a fraudulent email attempting to steal your information and/or 
>> compromise your computer.]
>>
>> Add optimized Makefile support for SoCFPGA handoff
>>
>> - Introduce socfpga_g5_handoff_prepare target in U-Boot
>>    arch/arm/mach-socfpga/config.mk
>> - Users can convert the handoff via make prepare.
>> - Detects Altera/Intel SoCFPGA boards from .config
>> - Combines vendor/board extraction into a single shell call
>> - Checks for hps_isw_handoff folder and .hiof files
>> - Uses ls -d instead of find for faster folder detection
>> - Runs BSP generator script only if files exist
>> - Non-blocking: continues if handoff folder or files are missing
>> - HANDOFF_PATH user define allows overriding auto-detected folder
>> - Minimizes subshells and other slow constructs for faster CI
>>
>> Signed-off-by: Brian Sune <briansune@gmail.com>
>> ---
>>   arch/arm/mach-socfpga/config.mk | 50 +++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 arch/arm/mach-socfpga/config.mk
>>
>> diff --git a/arch/arm/mach-socfpga/config.mk 
>> b/arch/arm/mach-socfpga/config.mk
>> new file mode 100644
>> index 00000000000..df1eb909129
>> --- /dev/null
>> +++ b/arch/arm/mach-socfpga/config.mk
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Brian Sune <briansune@gmail.com>
>> +
>> +ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
>> +archprepare: socfpga_g5_handoff_prepare
>> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
>> +archprepare: socfpga_g5_handoff_prepare
>> +endif
>> +
>> +socfpga_g5_handoff_prepare:
>> +       @SOCFAMILY="$(SOCFAMILY)"; \
>> +               if [ -z "$$SOCFAMILY" ]; then \
>> +                       exit 0; \
>> +               fi; \
>> +               echo "[INFO] SOC family detected: $$SOCFAMILY";
>> +               @set -- $$(awk -F'"' ' \
>> +                   /^CONFIG_SYS_VENDOR=/ {v=$$2} \
>> +                   /^CONFIG_SYS_BOARD=/ {b=$$2} \
>> +                   END {print v, b}' .config); \
>> +               VENDOR=$$1; \
>> +               BOARD=$$2; \
>> +               if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
>> +                       exit 0; \
>> +               fi; \
>> +               BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
>> +               if [ "$$HANDOFF_PATH" ]; then \
>> +                       echo "[INFO] Using manually specified handoff 
>> folder: $$HANDOFF_PATH"; \
>> +               else \
>> + HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
>> +                       if [ ! -d "$$HANDOFF_BASE" ]; then \
>> +                               exit 0; \
>> +                       fi; \
>> +                       HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 
>> 2>/dev/null | head -n1); \
>> +                       if [ -z "$$HANDOFF_PATH" ]; then \
>> +                               exit 0; \
>> +                       fi; \
>> +                       echo "[INFO] Auto-detected handoff folder: 
>> $$HANDOFF_PATH"; \
>> +               fi; \
>> +               HIOF_FILE=$$HANDOFF_PATH/$$(basename 
>> $$HANDOFF_PATH).hiof; \
>> +               if [ ! -f "$$HIOF_FILE" ]; then \
>> +                       echo "[WARN] No .hiof file found in 
>> $$HANDOFF_PATH, skipping BSP generation."; \
>> +                       exit 0; \
>> +               fi; \
>> +               echo "[INFO] Found hiof file: $$HIOF_FILE"; \
>> +               echo "[INFO] Running BSP generator..."; \
>> +               python3 
>> $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" 
>> -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, 
>> continuing..."; \
>> +               echo "[DONE] SoCFPGA QTS handoff conversion complete."


I tried applying it onto the latest main branch using:
     git am -3 < v8-Add-optimized-Makefile-support-for-SoCFPGA-handoff.patch

However, the application fails with :
    Applying: Add optimized Makefile support for SoCFPGA handoff
    error: corrupt patch at line 61
    error: could not build fake ancestor
    Patch failed at 0001 Add optimized Makefile support for SoCFPGA handoff

It looks like the patch file may have been corrupted during generation 
or transmission (possibly formatting or mbox header issues).

Could you please resend the patch in clean git format-patch (mbox) 
format so that I can apply and submit for PR.


Thanks.
Tien Fong



