Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F8CD4F50
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 18:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A7E84119;
	Mon, 18 May 2026 20:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TNd/qiZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BFE8460E; Mon, 18 May 2026 20:29:49 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D397A80433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 20:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx8CrKx8h3ahcnlEkVKf1CBBAfG9l9S7HIFlcazpRyXGuCIBEFhfeOz43NLGZYA8psA3SiLS1JtdhfVcrgWmmJlHjbOmHZA/GUGNZqAhuMhr4wE+iSAxDJ14xzKry/uXfKco4D2csgzq1K5aoHE1KzgH6yfF7HAhR3JoY9zYae2yEw6gw3C6Pg/a7lUmT6Ygec4e6zYxOFeSjnrdGGyfvY1+43y0xIZPkYyr5a3qK7u2S4kbgsnc8MEOO9p29DCXox+kai3v4fi1Z7SBdqxP9tjPqtnC7V9ah66DTDVWzj1XUxMmb/beB38wwAjDRkJACIIEwszE7qecdXvLi/FyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1yy4uqaYzs/umr97nAh0ctAa6bTpMVE4PNfQB/Sv2s=;
 b=UQHQr64Y8pXmhtz7z7AJJdUMkD2EaqBDsmBpaspDCdVoLDlVYB3N/BxJkdlbqJwUYgfrivjTd1wUbgY2PIocqT77ZLLpc0lrD3E1UPTmSS86Gu0QREldJFEg1kcflBbFZ0Brh7mMjsHGrheY4zGNKD3kgonevZ170xX32SamAgqadD4DBStIF+IhCP5kfXhiGgeQYzwUtZFDoDIERLXFDvpuLv2nQJ/NUeSAh5cBQOhSa0o1tciEwGsqjkyDZMIHO32FMwhCD643qaQq5dTGkHyEpHdBa7Db21q8dgdYuF9q3bfYrKqe0/9xxkZNgZZ+ztN6prL4hSUy8nIzckL2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1yy4uqaYzs/umr97nAh0ctAa6bTpMVE4PNfQB/Sv2s=;
 b=TNd/qiZmAZTsFrRL8b/Vs6LhLshzNip/rz3ntkEuBLUBjh0plHmICGbAIVmhLLazbUAxjOiZoroVKAPqW4qPvYOEOuO6wja3DQ7ztgMBr2fJEb6C/XOaTwwVFTzS4wo02Hs+sW5iAuuQhs79I1ZygPLyzg9OhIYxRk2HN3r26X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Mon, 18 May
 2026 18:29:44 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 18:29:44 +0000
Message-ID: <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
Date: Mon, 18 May 2026 20:29:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot patch submit standard and requirement
To: Sune Brian <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0d8cc2-b7df-4692-0d62-08deb50b6ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4133799003|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: jJfm8D2i9E0r9vNuEsHOPyXkCRqL29TKTJa+pzlhq3/wSJl+g4JjdjBtVRi1YA2NazGiX6z+VzgEgriQI6O+KCY2/n96SUj/BU+TP3ReCmdmW7JrfZLXG1bSrPrzJihY95scESj2i60qiMX/k4rO7UNvzum3QxAfoZrsj9wxGdF5FLhP9MLD1RZIGkG/ADjYqdPTc/w9MbSXAlBjc00Z2QMu2dDDhf8YgC+A9tTSK66IhTsjuaghEN8Z+m9E3od7gW9UgB45Dk9sZq6z5QAbd3C/gHeqIUeeAPQemsmJhgtOEyphi51u+AOlzkI5HiaXJOGmifUjS/QpsLhsx/8q7daL9yInv+/vezoObCu7TjFydxNsLPSRhe2W0RIqauEamsz9W/3djhisXr+A+Q915SbUqaX7KrCnk8Zt9gEFBckz0xQVLX2GJtMt+SyiEWKFrV3UcxpKAkUzR4URiVElSJHxJgKWYSrkC8KflYJg9QjFyIMwMoBXz8hVuF1A1TyWKDSJWdkTWbMpJNpwF3d+0LcuhrXpG8hfHu5L1tPt5cF3BbYtm1cTA6e0XgvTwnecHkv7znrPVXu6xH0r+g0nU0gQtBdzuJbvlMOyqDc8Lfusx3L4iyA95GF13YOzJHcFU1X4OOoTmSVNgzjLnvcM9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4133799003)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bms1NEFPVzVLWXNXclRPRlFXVlM1NGVaRmVkajBVQk5Pd2VVcFVqdXBJcldK?=
 =?utf-8?B?RHN0cmxYamZzVUtLVExKRGZUMlF1UUVIWFg4NkR4OG1KbTVMWFJjcW01WVpH?=
 =?utf-8?B?SlBkYVg1WDV4UWFGcTVsdGRFWW9BVHVlRlVLNHo2NTVhUDRFb1ppZlZZVkhs?=
 =?utf-8?B?SndISE02T3dHdVRrUjUzNzZqYVJNejl0YUNzTXljUHU1YkRSZTExVmFpbncw?=
 =?utf-8?B?Z1lQYXV4Z0tOenE3WlJxOTFZUGw4UTlVengyU25RbEZ0NHFJZ05uMDZTZW5n?=
 =?utf-8?B?bkkvRFdEQk9OWlJmelI0TndGSkNEZHpadU5yaTF2TVk1TlV6NmxkUUVySFY4?=
 =?utf-8?B?bGl5NkRiNmhDUlNwZmFGZDA1NGd4Z0VndE16aFYrSTdXWkNNdVBHdW9UUFJL?=
 =?utf-8?B?OGNpc1RDQVRidkhUbkNxNDhSeDI5RXUremZOWGtmTkZwNVBTTDM5b0M5czBq?=
 =?utf-8?B?eHJCRm9aUmViN05xVkRudy9qSTdXN1pKU012UjZSZ2QzVlRPYWovemJkdVcv?=
 =?utf-8?B?SnhGdTFmcGxKMklqZWJvbEpOQ2taOVdtZ0dUV0k2THV6YUNHT1VFbnpGb1pH?=
 =?utf-8?B?RDBxVFJNMXZ4NjdvTzZWRmdsdkc5NW9xQlBWQlRrMnJIaGhROCtUZlU0NFc3?=
 =?utf-8?B?eCtyaER2UzRQZnBQVUhNb3pyU0EraWFYVyt3ZjVxUDBGd0dLamxpenZZdmRU?=
 =?utf-8?B?QUdFaW5ZT0V5VnlONGtjdEZXa29pcjlQaEJWOEhtZ20vcUdTZ3R5TTB3Vmxl?=
 =?utf-8?B?Tzllazc5c0xLallOdDhSNjQvS0RuT2x1ZE4yQ3FIUzJGVjUzMFpObXZPMVc0?=
 =?utf-8?B?WjNuNmd1aU1yc0dScEp6U3ZVWmxZRC9yVDRDUjRuQzg2SHcvWVc4WVB5eVFh?=
 =?utf-8?B?aVNHdktKZGlsMkFqZHFtNDF2bDByd0szbXphUGg1bVRiZVg4ZHNNM09HY3dT?=
 =?utf-8?B?ZG5NTS9oR0ZBdThCeFEzRDMyYWN3NTI1bE8zYnNBWjZWdEZsREltNjNaaGdm?=
 =?utf-8?B?REQvY016ME5YQ3p6b0tOUmROVW5kSnhLUUh3eUpGMTZYL1Q1T2RUNGlvZ1ll?=
 =?utf-8?B?dlBuZ1pXeUJDaitTbDEra1kwVWFyM2kvZUw5MkFiY05JK08yL3B2cGNTTStH?=
 =?utf-8?B?UWZYYU9VajJQSVFENDlTM0c4VFRSeTJxaUJEdmJpZWt5dHBOT0NMb2VsY2F6?=
 =?utf-8?B?K2VMeXc2dDYySlNmbWFxOG5vL1grekdMdGhWQXc3MTRnN1NmQWVmYzlUQnJy?=
 =?utf-8?B?bGV2V3F6V05ZUjZLMGZ3eWZmTUJaVXpqcTQ4SUdiQi9RMkpOSlliRzBGUXJU?=
 =?utf-8?B?UTJIalVudm1kMnN3UVRGeFVzMW1yWHJZNzR4dXFFM2RXZ0N1bU1sb0FJWlV1?=
 =?utf-8?B?UWlvNlIrUDE1Szk4YSt2Zk5VMUw2R3BBNjk5SDh1c0MvZnNYbGlPUXpRbS9r?=
 =?utf-8?B?RGorNHR0SzdaTEdNZk1GMisyUVB3bngrRFVDTUNPNjAxbi9XR0NWMmNQU2do?=
 =?utf-8?B?ZFdtaE85czN0bG5hZDlpK205Ulc1aUlGZGx4ZW5NdzJMR1lsU0Z5UWFTaCtr?=
 =?utf-8?B?dU5qSFNZcmlBUlhwTEJSd0xFV3VzR216b1FyN0I1SXpWSmVIdlZzTkplOEYz?=
 =?utf-8?B?WVo3SnI3anZQUC93OUJkYVZOYW52Y3IxK3lpdk4zSmhxTkViS1Y2Qm9uK2M3?=
 =?utf-8?B?UVgxT3ZVUkpydmR3SE0wOHZ4aGtBNzM2NERpRUl5THoveFliK2I4UDRTd1pI?=
 =?utf-8?B?Rk1OSnhyS0JRUUxjbFQrLzRkYWw2S0pLVGJ5bXhsMmI0Uzk5cHFOeUhBb2t3?=
 =?utf-8?B?TnZyOUROMzB5UXk5dUxRMmZMNEdYaEQ1ZDM5SW4rRHU4ei9FRzZlaHhQSnlR?=
 =?utf-8?B?NjR0WTFzWGVjL25KTXZyWkdyRG1JN0hvckh3UEU0SjlqSGdtUHpSZmZPSmdG?=
 =?utf-8?B?Tnd4QXhnbDFrVUpqL2dHbVJiRmpkSG1JYmlLRW1wdy9BQnhkN1c4WnF3Uk1r?=
 =?utf-8?B?alVUSDA2c21tYnplRkQwN09zRHNQcWFPRk51QTRpQzVtc0dQUkY1VTJxcjhz?=
 =?utf-8?B?MDhzbi96QnI2dWpNcVB4dk52Z3NtM2c4ZTlpVGg3K2p4K1I3VzdmcWhrNVRX?=
 =?utf-8?B?bHlVU0Z6ajZtMUFpUDhWQjlKZVpObTlvSHlHSkU2QlAxcGJzOGFIS0FaemUv?=
 =?utf-8?B?Y2dTRVVrTlc5VGQrNTZVTk1UNTMyQ1pvS2xLSHVlWGVrMUtZQjd4blc5dlJs?=
 =?utf-8?B?NWVKVDlvTXVoZXlpRGRySGdVVWVOcTlTYlpQTXZHY25DcTZBVHlzVDBIK2x5?=
 =?utf-8?B?UklEdTUzOC85emFUQSt1b3dFaDgrWFVSUnc4SXJvdEJPNXo1QStJQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d8cc2-b7df-4692-0d62-08deb50b6ec7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:29:44.2782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlOqGGUc52e9p4HIxESg7xIRaDNJ1b2QA8/w8NigMx7TF32FhYaE6k3XYLYULtLIUp0Ni5KmNr4kHx9L4tFnJIPYIvRGqLC/cSsATzoKpcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
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

On 5/14/26 3:51 AM, Sune Brian wrote:
> Hi Tom,
> 
> Sorry to bother you.
> 
> I am curious that for me myself I had no issue to follow
> the requirements [1] as long as all patches that are
> passing the review stage do follow the rules in [1].
> However based on most recent commits and reviews
> most of those are not even close to what [1] mentioned.
> 
> So at the end, reviewers in U-Boot just made their own
> standard and requested contributors to follow?
> 
> Rather the U-Boot itself should all follow the docs rules?
> 
> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions
> 

If you feel like other people's patches aren't properly formatted 
according to the docs, you have two options:

- review them on the mailing list and tell them to follow the format as 
specified in the docs, like Simon did for your patch,
- suggest updates (or send patches!) to the docs to better match what is 
followed by the project,
- if they aren't about the commit log, you can send follow-up patches to 
fix the source code to better match what we document, (but you cannot on 
commit logs as those cannot be modified once merged),

If you do not understand why someone is requesting changes, ask them to 
explain or point at the documentation. If you disagree with the reasons, 
you can *politely* tell them that by providing arguments. However, 
maintainers are free to go the "agree-to-disagree" way and refuse your 
patch. You have to work with them to get your patches merged, sometimes 
it means being really patient.

Maintainers are famously overworked in any open-source project you can 
think of. By following the rules (which sometimes are implicit), you 
make their life (and the life of reviewers) easier as it's less effort 
for them to review as it follows some patterns they are used to.

Maintainers are people, like you, like me, they also make mistakes or 
give some leeway because it's the 15th version of a patch and required 
changes aren't worth going back and forth with the contributor. This is 
the *maintainer*'s call, and they're free to decide to do it for one 
patch of one person or not. It's a fallacy to say "this patch didn't 
follow a rule and got merged so I'll not follow this rule". At that 
point, why even write a commit log? Why even have comments? Why even 
care about the code compiling without warnings? Why care about security 
holes in the patch since other patches got merged with security issues?

I've learned over the years to not answer when I'm getting angry because 
someone doesn't understand what I'm writing or they have unreasonable 
requests. You wait a few hours, or a few days, and you read again the 
mail with a cold head and you usually read with a different perspective 
and you can now stay polite with them (and sometimes you understand what 
you wrote was confusing because it could be understood another way). 
Getting angry, especially at maintainers, will be a sure way to get 
people to ignore you. Since they are not your colleagues they perfectly 
can decide they don't want to work with you. Yes, it's unfair.

Remember also that people are not in your head, so providing context in 
your patches or emails is really important. The more information and 
context you can provide, the less the person reading your mail will have 
to think or guess before they can review your patch.

For example:

- 8f41874f4631 ("fix socfpga GEN5 handoff script path"). When was src 
variable removed? If I had reviewed that patch, I would have looked for 
a commit that removed that variable and it may not be obvious so it'll 
take me time that you likely have already spent yourself.
- bb1c2b463265 ("update GCC version check after Kbuild bump"). What 
errors did you see? Did you test any other toolchain than GCC 10.0.1?
- 5b1fe6ef6b81 ("Altera SoCFpga Boot Stall Fix"). Where does it stops in 
the boot process? What's the boot log? "After testing", what kinds of 
tests? There's no explanation as to *why* this patch works, only that 
it's imported from downstream fork from Altera (that you say is 
"official"). I can understand this as "I don't understand what this is 
doing but it works", which some maintainers may accept, some may not.
- e291277689f6 ("sync socfpga common u-boot dts". The Device Tree node 
would be present in U-Boot proper. So the issue is that you're missing 
L2 and memory controllers in xPL stages. Why is it important? What kind 
of issues does it fix?
- 3ba9b1f7bd7e ("Cyclone V Board handsoff script"). No explanation as 
what this does. Why is it better than the current implementation? What 
does it bring? From which version of "official" downstream fork of 
Altera did you import this script?
- 1feebc36e588 ("FPGA2SDRAM setup fix"). When does it stall? What's the 
symptom? What are the bootlogs? What is stalling "from distro"? "This 
patch fix the issue", but why/how? This sounds like "I tried something 
and it worked, I don't understand why" which we typically do not like.

Were *I* maintainer, I would have accepted none of those patches in that 
form and instead asked you to provide more information. By not providing 
information, you're stripping users the ability to figure out if an 
issue they experience in an older U-Boot has been fixed in newer 
versions without having to compile the new version and testing by 
themselves. They could just look at commit logs (or do a search on the 
Internet since our mailing list is publicly archived) and see if someone 
had the same issue and it was patched. This is *not* a theoretical 
benefit, it happens often in the Linux kernel. With additional 
information, it helps us figuring out if we can refactor or remove code 
a few years from now because we could hope to reproduce the problem you 
fixed and see if it's still fixed after refactoring/deleting code. All 
that to say, your patches also benefited from not exactly following 
rules. An obvious one being (specifically the last sentence):

"""
Keep EVERY line under 72 characters. That is, your message should be 
line-wrapped with line-feeds. However, don’t get carried away and wrap 
it too short either since this also looks funny.
"""

They also do not adhere (according to me; see the list of questions I 
would have had on now-merged commits) to:

"""
Detail level: The audience of the commit log message that you should 
cater to is those familiar with the underlying source code you are 
modifying, but who are _not_ familiar with the patch you are submitting. 
They should be able to determine what is being changed and why.
"""

I've noted multiple times that your patches typically do not follow the 
naming scheme where there could at least be one prefix like "socfpga: ", 
c.f.:

"""
If applicable, prefix the summary line with a word describing what area 
of code is being affected followed by a colon. This is a standard 
adopted by both U-Boot and Linux. [...] The best thing to do is look at 
the “git log <file>” output to see what others have done so you don’t 
break conventions.
"""

Though to be fair, some merged socfpga patches don't and it's not always 
easy to find an appropriate prefix. For 
arch/arm/mach-socfpga/misc_gen5.c, it could have been "arm: socfgpa: ". 
For arch/arm/config.mk, "arch: arm: " or "arch: arm: build:" for 
example. For cmd/Kconfig, "cmd: " at the very least. For the new boards, 
something like "arm: socfpga: " for example. This is important because 
people visually filter what they want to review or not. After looking 
into your patch submissions in the past, I understood that you mostly do 
stuff related to socfpga which I have no interested in, but since the 
commit titles don't match what I'm expecting, I now simply ignore all 
your patches even though I could and likely would have reviewed 
f26db83ca964 ("fix PL330 CMD supported target") and bb1c2b463265 
("update GCC version check after Kbuild bump").

Cheers,
Quentin
