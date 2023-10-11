Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1020FCD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 07:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1831D86BA3;
	Wed, 11 Oct 2023 09:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GlFgiv9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CC786BED; Wed, 11 Oct 2023 09:04:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C3E86B57
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 09:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqlBpiavw1Yc1+z3rHm/5mWElDupWt3m9f9DvvrEgwqoJ4WN3rp8diPZmENaAOwpgdqVfc7yoRxDJRbE5JDHTuusBrLH44zyqkRREwlT84usYR9NPpDwNbM5DZiI9uTAjklZ6E3ij2Ow3NAdsbQLN7+ig7zsYTmSJll5KTMOrpn60GM/HtAEYDup3roXgnRSh0RXlOS3bmcdtFde5XwfcTJmvUbNoX3jT3YeDRv5HkzruQqqtw/wFbHoekIqF/snGhMXCyM/Z4AIcQbng1v4nBcXX/F83jgBZQyPrNPoiNiBBvNZfgcsb9BNkCj+iVMjkXYEorzx5Ro5ahVYE37DwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l32GViOMftOJrZIolIBfdzDhmByFXBdo1w5djAYLY9g=;
 b=LBjvBp68c8kmckrgAAg9GIWTPNLzQHhEqHx4Kih9EtuU4vCaBwKe98gbgCVYoe/uTuz7Y0YqAfYv8xplw9ts7xQ1UUGBjcDk1Map9isywBNdiuZrxUSK74XGojuIZgxCG4HCmq9QhKlqjPGS0weDxz6PVHszVMkl3lNH2Bq5ZdVSw6hAMEAqfHa2qp2u8vJg/uHAeolGF1om6a3qZXEHWL+RJNaTrgRSG2VQaQr1ezVck6ED2TkbuEuCsnSphqMflGhB1VbFEZplCyYJzw+idtbiPNcPnxmeQg4mubj/d5WG3hKO7pCxCSy24vG4xMjn+KZ/38uIznJJklcbREQitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l32GViOMftOJrZIolIBfdzDhmByFXBdo1w5djAYLY9g=;
 b=GlFgiv9u8DbeVgz9yQsjvQPrip40jL/EDgwrORQdYOmBnNh85JDggMU5HH2bWm/t0q5zFXm5FLA6fP/e/cpEABKl+H/8RAHYPhZTVOQzIpUad3tX5tT6EkY9qGKerW5HmDicxDf4Kth9sSJinXtpbkjTFeiqhdRhoCV6ymX+OxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB8211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 07:04:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:04:08 +0000
Message-ID: <b61d2b51-9bc3-b648-cb65-ba15e4043eab@prevas.dk>
Date: Wed, 11 Oct 2023 09:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Makefile: make u-boot-initial-env target depend
 explicitly on scripts_basic
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tom Rini <trini@konsulko.com>,
 Max Krummenacher <max.krummenacher@toradex.com>
References: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2LYithR2_n3h51WZBRPCapw7XuYEGYoZaWg_PXUNcWxg@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ2LYithR2_n3h51WZBRPCapw7XuYEGYoZaWg_PXUNcWxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: e87cd59f-6a4e-425f-e61f-08dbca28430f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnv9FmCcXfw3Kf3gWxH52l2EHOb/tECD6PWOvfQHEe84mhJeoMWw6WtSFsQ3pppOatNenIZW3eBxAhQ7HFqMHrvewfMBExXqSRMY3ixA0Mguf1nHUxCW7OoxRt61h6VKrtsYIR39WH3wRYcaKEa4T5altbvQdyCQvdUKf5uHwa/WLFDCVeXoKL3B/80Ujuw1vzPb+NISgCcGa2uUAuyqXbHUwgGsq2efjl+Qc3auOZ706fYdCjQe1qf+5dVDI4kEdZd/tQcwMdDTLbcHHTYZN4HNWtB5z7d1gSemUYzAOE+u9pmlZKT/+Bv2UrwFxSFGhhIa1Xx4nKKz9YbOIvgDfE0YN7W9Cvd/7usgzk22FH2MmbdR7lp/oqzZsjJuFIfl/1+W34VrZR9+kczsS6lxypLxvLo/M/kMted4rAEcs4H7ufnslNxXEYL+CnfsFhMZXZJ3ILMFAYHRI6dMPeES/qh6lkif2ElecD6W8Bx2kI5fJGBRH8Y+JMsfKek8FkmEXOf34yA85qro3AIzGUUJAtTbOvj5MHztSEVluvkCFzXzTq07eQb2FL43PIPacRldGDqOErC8xyPvWStsRj1CkuW4Mi7CXMSxWldk5i02sO0/DuTsqUO+2CogwrRSOrqVbOAGNqVio6eLypbug2K2ZUbyftUUykmZyoPPthz1Am9aZZd9DeT99WHmvw0YlVkX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(39850400004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(31696002)(86362001)(38100700002)(31686004)(2616005)(6506007)(2906002)(52116002)(478600001)(6666004)(6486002)(6512007)(66476007)(54906003)(66556008)(44832011)(5660300002)(66946007)(41300700001)(316002)(6916009)(83380400001)(8936002)(8976002)(4326008)(8676002)(26005)(38350700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJmTjJxRzJ1QzRXU2RPajgrSEdwVGVVQmlxTUVZeEN2MTc1bFh0a0x5Y0Ns?=
 =?utf-8?B?cmpoM1pieWh0T2tiL21oY2FkRitaTTVqZWxnUkgxMUt6bFZtdHB1b0lIb2xT?=
 =?utf-8?B?WDROZndxa0Z6a2xQcFBQNS94TVJqNkVNYys4ZC93c2UwZ0k3em55dGRoc1Jx?=
 =?utf-8?B?QXJSVko0eGRKdWV3UGRTaXYxR0lLbndxMU9Gbmk5eTZCQzV5VU0rT3lJZ1l0?=
 =?utf-8?B?bitsRTFoU2RsdG1sUUhzRTRBYnhXRlBuczkwekJPNEJwYjBkQ1ppZms2UWM0?=
 =?utf-8?B?NkdQa1ZhWWQ3c2dsaTlpeGErOUhKblpONklYdlg5UHVMdWZZaEMyd1BDdGtO?=
 =?utf-8?B?MG5nRHIzbVorZVZzazgrcFVzeVNIMTFsMksvZjM4U3ZIZ0VOYlEwb0JRWkcz?=
 =?utf-8?B?Rk43QzlpRXp3bHBMZkpZQ3lzNjNQZXFVNHd0SlJ6WDFqbUNaSmZTUHNGMVJs?=
 =?utf-8?B?aFNvUmJ0ajhKYUNpRjhsbmtMektqYlhUeGJVRkFvOEZjaGc0andUYmdSTlRC?=
 =?utf-8?B?YmV3c1JRQms3VllmRmtOK3BMYjJmekpKOWRiMDF1QnZuclFESzVKRWFTdisx?=
 =?utf-8?B?dzNITkJ0UUVjMVQxLyswNmNNVW1rVEhDcXR0eG11Lzl3ZlVEMFZ4Z3E4MERT?=
 =?utf-8?B?dU02OTFaVjI1WDN3bmhLdGowQVR1ekw4eElLRFlxUGU0cnhGdU45MW0yK0po?=
 =?utf-8?B?RWdOd2lNWm1MUjhac1pwSERZbmJ0N3pMczNZak4rbERqMHQ3UDN6bjBXSCt1?=
 =?utf-8?B?L3R0YTVCM0hwMTBjOUtLQlJzK3dGK2pPZjRFOFF3b0RXaUJ3M2xseVNWT2N1?=
 =?utf-8?B?QWVaazNpMklySEpiWVNXdm5TVmNMZUZIVFhZa3RabjFEcVl4UW5ZRE4raEFk?=
 =?utf-8?B?MFZvQUo2N0I1SFk1a29YaFF0ZHRTZkF0ZWIxaDdWOUkvNHRTTUVUaGhNK1lD?=
 =?utf-8?B?L08xaTFERHZTVzBTQ1VJVzVDODRFSW5nd0lGaWd1MW1hbnJCZEt0Y2lXZnQr?=
 =?utf-8?B?bFRaUFNUajkwNnNpSjdjNE44WXduMXdvV3B4SEdnU3VjRFEwN1FhM0FSSGVR?=
 =?utf-8?B?OG9JSjdLQm5MMm1kQ0F0U3dpUUNoNC8vUXhTV2g4VFJZK1R6bU1VbENyNUlM?=
 =?utf-8?B?cThUVW1IM3hWZyswREppdDhIeFJkYzFSV2NhOGJLcFNmYjRyWFRiSC9EYlZQ?=
 =?utf-8?B?VmRTeHJRM09IY1RaMWNzcGZ0UVlrQUJ1TG9iM1hVcmdjbEZrVXVFNkZzOFJF?=
 =?utf-8?B?dEVFaW8wVjd6SVp1SHdkMWNkcjRHVk5vQWhCYmNEeU5vd1AxVlZkRmpnbHUy?=
 =?utf-8?B?UVNUa3BydytldzFRN0VTN2NKa0hBMHdhcndtbUFvblVKQlRscFFBRTBRcVo3?=
 =?utf-8?B?aDBlUWpTVnllaERvQjdxdzJudWRwN1NiSWpBejlwbGVFY1RVODJSblpCNGJx?=
 =?utf-8?B?MWhCK1pZZ0R5cG81V3BTeGpYaEVsTEs0NG52Wm4wSUMrenhzbW1aejRESHAy?=
 =?utf-8?B?MkxzTEVRTnkydkl0SGgvdnAwaXZJeEk5TS9tWGUvNzNEcEJIaHM3TWZIdVdx?=
 =?utf-8?B?ZEZvaDF6TXlIeHZGWEViVi95WTUrNzFiTGJlZUdaRUdnRHg2bTBuSFowbW4w?=
 =?utf-8?B?dWdQMWNBWXdUUTlWc0d5NzM4bkYxKys2eHJzcFhKeDVHTTZldld2eU5yWS9s?=
 =?utf-8?B?eTF0aHV0OGt0ek5DRVErLzBtSmNEK1dXK2pEcW9hTGQ4bmxnU0ZVYm9NNE5F?=
 =?utf-8?B?aS90bEQxckdDajFIc0lhL25EdWREanVydmcyYVlndFRGa0ZPSEdtNkE2bUZq?=
 =?utf-8?B?bVFXTVBaM2k5YUNIa0VaMllZWU1uTURvMHpHN2N6OTMrMDUyQXdDU005cFov?=
 =?utf-8?B?bWs5ZUZyNHFCUUM2STVkQ3VIT2NkMU5uUWhSR1dLOWJJY2VpRkRLLzFmRzFT?=
 =?utf-8?B?eEJJbXZVZzcva1pmZkkyZnJWT0dPOUtLYW9XNmdQOHYxSk1jQmJIRkpuVDI3?=
 =?utf-8?B?bHhXY2p4eUZTa1NGTWxwQnRWSzB3VytZRDQvbXdFdXpnalRKQmRJYXJsUnpy?=
 =?utf-8?B?N2txMGljNlZ3ci9SOERtNHNiY09VcDJKMm5MTWdPUjFWaE15ZWNjVjBRSlRT?=
 =?utf-8?B?OThoMWVla1NrOEd5QUErNmRkazBXaFlQRFo0aXMxZHYyUnFkd1ZBZ0RFYmlJ?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e87cd59f-6a4e-425f-e61f-08dbca28430f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:04:07.7129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbP8bT+rIshh9YHzTLllwOhl8sntrUt5fhtHuR1/Sohkztc2GGKtjpjIWibzHvUIChCCe8vD4+dPW4L2f9bll7UKt3qif47WaootBk6Kbc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8211
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

On 04/10/2023 04.10, Simon Glass wrote:
> On Tue, 3 Oct 2023 at 04:02, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>>
>> We're seeing sporadic errors like
>>
>>   ENVC    include/generated/env.txt
>>   HOSTCC  scripts/basic/fixdep
>>   ENVP    include/generated/env.in
>>   ENVT    include/generated/environment.h
>>   HOSTCC  tools/printinitialenv
>> /bin/sh: 1: scripts/basic/fixdep: not found
>> make[1]: *** [scripts/Makefile.host:95: tools/printinitialenv] Error 127
>> make[1]: *** Deleting file 'tools/printinitialenv'
>> make: *** [Makefile:2446: u-boot-initial-env] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> where sometimes the "fixdep: not found" is instead "fixdep: Permission
>> denied" and the Error 127 becomes 126.
>>
>> This smells like a race condition, and indeed it is: Currently,
>> u-boot-initial-env is a prerequisite of the envtools target, which
>> also lists scripts_basic as a prerequisite:
>>
>> envtools: u-boot-initial-env scripts_basic $(version_h) $(timestamp_h) tools/version.h
>>         $(Q)$(MAKE) $(build)=tools/env
>>
>> However, the u-boot-initial-env rule involves building the
>> printinitialenv helper, which in turn is built using an if_changed_dep
>> rule. That means we must ensure scripts/basic/fixdep is built and
>> ready before trying to build printinitialenv, i.e. the
>> u-boot-initial-env rule itself must depend on the phony scripts_basic
>> target.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks.

Tom, can you pick this up, it's a pretty annoying race to hit in our CI,
and I'd like an upstream sha1 to cherry-pick from.

> I have wondered for a while if we could have a few tests of the form:
> 
> - build sandbox
> - delete an output file
> - build again
> - check that the build succeeds and the file is there

Well, in this case one would have to delete two files I think, both the
printinitialenv and the fixdep binaries.

I dug a little further, and while I can reproduce with sandbox_defconfig
by just building, deleting those two files, and building again, I think
one reason we hit it much more easily in our actual setup (i.e. without
such manual intervention) is that we set TOOLS_DEBUG=y, and because of
the way that option ends up affecting the make rules (in particular, the
.config is not always read in by make), fixdep ends up getting rebuilt
several times due to command line change (the -g coming and going). I
don't know if there's a way to fix that, or why we don't just always
build the host tools with debug info (I added that option back when I
had to debug some weird mkimage failure). But regardless, this patch is
needed for correctness.

Rasmus

