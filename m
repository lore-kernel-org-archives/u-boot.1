Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728EDC4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 10:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEB787C10;
	Tue,  6 Feb 2024 11:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Zfa4p/85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7123C87C69; Tue,  6 Feb 2024 11:41:49 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2962E87B8A
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 11:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHI9nK1I8ZieFH07YSUqwvqzwdA9Dt3qHdNET/bRu27jVFJy+dRSQACN2J/r9ldcFvJFlcBwoRER5hjI9CN28C2h1/X+mOBTvux6qeC0y7yPiY5Mh1M2++SmsBCzkcmk5SYdWMApMDguIIhad/w5LYlNU689HVQH8lleDEB11IhfWH40biy+fjbcXPBBFGoxnn1CgJDxFELvBQHS1qh/C2zxQZG5eVAtE/YsyA/ru9PsV4SoMqvNaWQtk4gFd/8N+o3se/UZtAuisWIgYPz3+ulPaG+0eCqeH2M83B2c5WhZJGvCPgQaTnH8H//eHs5MHHK1DJb6q73jZ0TewdWWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt39KCUW+ZE/E99mUc06506uwfEH/EZl0Jevu44P4vA=;
 b=Tiq7SUiJkAPQuk3g2GVtNefTYyuBaW48bQUDuj08wUHH9RdKdj044Dqnt56jsdAznrlJvW/UAa6fND/jXuFlbsn4r6+OzFFUFQwWWpOrVNgmsQeTcXf2iLgobnRB9mZp/D/K1gjcz/SK0jBVp4kg104dSjwennPW7GGWqWqoA5gyRrQTQUo/O7+HPk8fTgK1xfIkVKal0dXIOrYg5kQrpzVfAdGgnNw7MrqaPfxlj7y3YjMge/+ZACS3EHLUG2GKMxyvpfkoNoi9mn3DHjtsq0DvviijOtlxXw5eQE/VC638+wE2NVUCRM3eILGgy08RNhapAhBTfb1XZUq6UTZ9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt39KCUW+ZE/E99mUc06506uwfEH/EZl0Jevu44P4vA=;
 b=Zfa4p/85wqp8ayW2kANcd0j/FqSxzv3SQbDjyBnkbQLgm6yp/2fmVv/a3nHtGRyzLBKAo5FY5BoV2N/c6ByzQc3OoSxaVoo1cMSO+rX0cq9J2wwWAsAV/L57074fKnlgSclSMHH0P4Ycb6N6AfqXsKx4UL/2XhMrV348N40TjVtB/Xl72/Ixc0ihFe0tcw9ewH1Sh93dDY/of5ZX2smgQPFsgTFzoErlDKRlx0YJefjlz0jsS3ciExNibGUJtfUQSkriVJ11ekvIiLI/6FQZt3gPf2Ew8Zce1XcU3jPRVUXHVligBtRBhiiDxwl47eTTIRY6N+FwPBq54eMBe/BBzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:41:42 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:41:42 +0000
Message-ID: <799f8e94-b0b1-46ad-90e2-c98a67de91cc@theobroma-systems.com>
Date: Tue, 6 Feb 2024 11:41:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: dtc-version: Don't show error messages
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 martin@geanix.com
References: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
 <2493a32f-8795-4c71-b719-039db0f0ad24@theobroma-systems.com>
 <ba0ff826dbaff3b23a8a9fa27e5d663d@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <ba0ff826dbaff3b23a8a9fa27e5d663d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: a7041ebf-b7fb-4a86-54a6-08dc270034ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IykB7gW5fwcDQ948wMk/M1uRJbRxD9lfqH+vqCtbGM1H3+bdz4pjb+I7zrw1xgzewF5pJ4FdpmQ/RNJv34UoJTvKHJ8dxMhsa4FhFIfljKRugjIkFr3w/bJl9cTAbUc8kzEkJYLM0mpY9R66xVACwv8LCGGgwhgmYbRUBGlgZfU1S43QwqtZfoctb+WD69RwSITAAfffXTl33DEKNfLqXaOmYkqUeVCBphue0fAS/H8JO2CoN1dyhHWISTlVd0CrwQNoZz7F8/doiM/Askolo3fpWk2zOOuTleJlEIigvYw6T+SfJ3wlurFQSD/yL/aQa0uzq09JxlMWJeo3dpEsMqYWKlB48NwcmcW4FsV+KjbQhrBn3JuGdXMZ6mqVW/hJGUqXtccZH9tHD8Ujb4SKsHuNYOM7yM15663B6Uph1pQSDPrDbW3KZcmKLUKVK7S7IeNpSmZh1SiG6WgLvtuvRTXfiAdK8StBy1ClbwTiiOC2nVfDvpuqCQvJu2ruseAt2/36Yb4DbNb/BvB/pe4viya5bH4a2Y9Kfs/X0NwOII+ShlcKUpce9zFpr0V3ChsrpnYU05X6G0abkrAZ8LTZu1AZgvWCkZiD34GyNnhiaCPH8CkZBvjlc0MOazifvwyEax0VVpiGQP7sA254yMH9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230273577357003)(230922051799003)(230473577357003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(6486002)(36756003)(66946007)(966005)(66556008)(66476007)(6916009)(53546011)(6506007)(6512007)(478600001)(8936002)(8676002)(4326008)(316002)(38100700002)(26005)(2616005)(31696002)(86362001)(83380400001)(15650500001)(5660300002)(44832011)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURNdGN4dkE4VGZ4YlcwclptaUZIcjR0MFBIVXU4R0lINlRMS2pGM29wWnVv?=
 =?utf-8?B?Q0ZVbXIvRmttUHpzVkwwNkhQWkQ4Y2NWTkV3Yy9sR0t2VGJldGwxVmtTNGVW?=
 =?utf-8?B?VDdIelFyelNUbDJvRlFJMWh6UVNCZTZscUpoT1p5bGJwTUJUOTQwZk9SUG9Y?=
 =?utf-8?B?REkyVGlVZmt3NXpDTHNKT2RkcDRFMGRVNTIrT01KMXdTbVJzOGRFSGpSakIw?=
 =?utf-8?B?Kyt5SjRyR1h1VVFORWZSOGVQemNCN0NzakdINkhSY1EwQ01NcXAwa0g3Q1pQ?=
 =?utf-8?B?NmtzRGV4UnNrbDBxeHhJcWlBRTRnZ0drb0g2dW5xMkd0WnVnQ0JuTm4zMDFp?=
 =?utf-8?B?aWIzbElVem5qWU50K2NqcHVSVU4xNnlJZ2ZWLzFxaVh6aTBBTk1KcUR1N0Vj?=
 =?utf-8?B?TEU0TzJEZ1U3MS9pS2Z2Sm1uVjdnTDIveW4yRTBSd2FtdFphK01DTURSOGpR?=
 =?utf-8?B?R3I2S2JtOUg5TjErUlZHL3VjVWt3R0RWalF1eFIxWjE2aHhmNkt0MW8xdnIy?=
 =?utf-8?B?NEY0QnB1bjVNMENaRWxsazNwMWVTcDdHSVgvTDlldStUeTVHS3pFdTkxanVU?=
 =?utf-8?B?L2F6WGxTZnRhOTNuZXFpTkw5MGlzV3hQcGhhamxHR0c0dWlkVU1namRhN2hT?=
 =?utf-8?B?UWwrZjdVVnpZM01yVVNJcnkyQ2RKNjE1cFgvYzlVRXBtZWhINEpQSldXeE5B?=
 =?utf-8?B?amExZEFTTVBPalFNTjNaeFAvZktYSU51RGlVaE9LWU0xR1lpTFFzQ3p3bmhQ?=
 =?utf-8?B?QURoYXR4OEM0NWdWMUhlT1k2YTg0QndWekx3OVJXMmluMWZrSEx3cWZyTTZE?=
 =?utf-8?B?Q1BxSHNlU1pPNTVUNWhYSExDVHkycFZ6SmZkR0hTdWRIVElhL2lBcDQxbk1y?=
 =?utf-8?B?NFR1Y3hZY0Jod1A0QXZzUVhLTk9kdWhNVmx5TEZwbjYreStUTTFYekJKc0V1?=
 =?utf-8?B?ZTgvdnVwNXJWZytLdDZWZGNEOFYydXN6REJnMmdIdzFwQlZrL3hyYk12MkJU?=
 =?utf-8?B?ODIyVWQ5UFdaanpFMENwaVh3RDcrWVM4WjBvTE40U01iNzIzVWFqQ011ZGc5?=
 =?utf-8?B?ZUExRm4wVzlzUG5Vbk45eEVpZGNQOCtKUG1iTGUzUitFRFNqVUlSaHZYV1U5?=
 =?utf-8?B?ZTR0QTM3U2ZaNEdzNzJsUUUzV1FLSDBia1JSeUZjZU03czBtbEhVVDYwaXBu?=
 =?utf-8?B?RE9DRjVGUW02VnROYmh4a0RYTnA3S0F0RGNZeThOS0pTamxaVWtkZDZsQUNr?=
 =?utf-8?B?ZnAzcjlnMjU0Q0pWU1BqV2IySnhXYVJub3AwbEVINjROZWhuZ003dlhOVDJm?=
 =?utf-8?B?SFdtditTT0ZHd21hNVlHUHdjZEJtamJWYlUvUWtjV253QnUvMHZ1N3ZzSFVQ?=
 =?utf-8?B?MWIwbU9BUTRFVTlIQ3VBREQ1b09sY2c1NVF4VU1QTmc1MWdhaUs3ZkdmN2Zo?=
 =?utf-8?B?S2NGb1hoMVpCQW10MElDSFdROENFbHoxVzdEWHgvWXZ4TUswOU1NOWl4QjJ3?=
 =?utf-8?B?SS9QcEJJeEppRDJ1ZjNyZEFtWkVMdVcrZ012ZyswSWJTMk41bmZoNDZVTGQ4?=
 =?utf-8?B?TXQ5S3cvdVhlUk9kWlpISUE1R0prMFVnVEE1R3VrcFZCb3hLdVNnT1JQZVpo?=
 =?utf-8?B?ckorL2xkM0d4MW0zc0RhOUtKMCtkMlNGVjNiQktaMmV4dG5GcWs2UXhMeU4v?=
 =?utf-8?B?cWE0UlpOT2V2NCtpMCswbmNScUR5U25iSHQ3RUwvMHlVM1pBdUlKMFNvQ0FX?=
 =?utf-8?B?Q3Q4Y3hrdWYwUkZwcHRmOU53TXdLV2lPbm1wc2JqQW96M1VQc0Q4b1hiOEU5?=
 =?utf-8?B?SDZjUDVSbnJkUk1nMG1LS3FTOFlqWmNnNjdnNWN3bDFPTmQ1K0k5YlhCWWtC?=
 =?utf-8?B?cjU5djArbTQ5VWI2S2N6WVRxQlRyZ3ZKdmVBcHhvYkZJdklOblNWUzIydVFp?=
 =?utf-8?B?M1dFSDJMQUk4WVNWZk9CVlZMMUVQcDIyS1RaYkt2WS9iV01qTlZJeGpPTm0v?=
 =?utf-8?B?V1pDQWFBWVpTcEVuUHE5WmJGWlB6WWtTdlM0a09BRllpRVpFWHhlakwxVTBN?=
 =?utf-8?B?TnRrMFUxTHQreU9UUUtJdW10ditHamZISXVpMmRIeHdrb3lmc25VTXJ6WEUw?=
 =?utf-8?B?RlhLaE4rRlc2bTFXakZySWNHakFnYjVRMHRRYVlPR21lS09zVTFzSlZORG11?=
 =?utf-8?Q?GQFMG5rVxVKb2P3/r5ubmzo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7041ebf-b7fb-4a86-54a6-08dc270034ae
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:41:41.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md7Q2nF9QuO6fpo6N0Y2dOFdCwdHuhztPcWVjSvoPFOBRQMiOAV8sQ9vNwxsCYylRKQ6TD44Xd6ldLgPH5ZDK/Txak6xwQL81P0tmu9oIHwZdHf6Hdfsl2wS1tq/BUFJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
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

Hi Dragan,

On 2/6/24 11:37, Dragan Simic wrote:
> [You don't often get email from dsimic@manjaro.org. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Quentin,
> 
> On 2024-02-06 11:25, Quentin Schulz wrote:
>> On 2/6/24 04:56, Dragan Simic wrote:
>>> Prevent the error messages produced by which(1), such as the one
>>> quoted
>>> below, from being visible in the build outputs.
>>>
>>>      which: no dtc in (./scripts/dtc)
>>>
>>> This makes the build outputs look a tiny bit cleaner.
>>>
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> ---
>>>   scripts/dtc-version.sh | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
>>> index 53ff868bcdce..6d3d7b68fdfa 100755
>>> --- a/scripts/dtc-version.sh
>>> +++ b/scripts/dtc-version.sh
>>> @@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
>>>          exit 1
>>>   fi
>>>
>>> -if ! which $dtc >/dev/null ; then
>>> +if ! which $dtc >/dev/null 2>/dev/null ; then
>>
>> What about
>>
>> which $dtc > /dev/null 2>&1
>>
>> instead?
> 
> That's exactly what I intended to use, but IIRC some shells
> or some older versions of some shells may not recognize that,
> so I went with a more verbose, but slightly safer option.
> 

$ git -c core.pager='' grep "2>&1" scripts
scripts/Kbuild.include:		if (which $(strip $(c))$(CC)) > /dev/null 2>&1 
; then \
scripts/Kbuild.include:	if ($(1)) >/dev/null 2>&1;	\
scripts/Kbuild.include:cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang 
version" && echo clang || echo gcc)
scripts/Kconfig.include:if-success = $(shell,{ $(1); } >/dev/null 2>&1 
&& echo "$(2)" || echo "$(3)")
scripts/checkpatch.pl:		$maintained_status{$filename} = `perl 
$root/scripts/get_maintainer.pl --status --nom --nol --nogit 
--nogit-fallback -f $filename 2>&1`;
scripts/checkpatch.pl:	my $output = `${git_command} log --no-color 
--format='%H %s' -1 $commit 2>&1`;
scripts/coccicheck:echo $SPFLAGS | grep -Ee "--profile|--show-trying" 
2>&1 > /dev/null
scripts/decodecode:	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 2>&1
scripts/decodecode:		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 2>&1
scripts/gcc-stack-usage.sh:cat <<END | $@ -Werror -fstack-usage -x c - 
-c -o $TMP >/dev/null 2>&1 \
scripts/get_maintainer.pl:		my $output = `git ls-remote --exit-code -h 
"$url" $branch > /dev/null 2>&1`;
scripts/get_maintainer.pl:    $cmd .= " 2>&1";
scripts/kernel-doc:	open IN, "$cmd --version 2>&1 |";


So we're probably fine?

Cheers,
Quentin
