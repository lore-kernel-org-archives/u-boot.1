Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC4EC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A108812B;
	Tue, 21 May 2024 14:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="msoU1TA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EED8875B; Tue, 21 May 2024 14:45:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9328812B
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1Ug/CXasa2SPlkvhRXDYHf9UhbR8yeHkt0Mi8ZOIyJ5OMNGGMibNPOqblM0HK1res1oBBMWrDENVTUGlxAzO/cjUqATHQknytn+8Ow4scRYTy7r/Zwd7KO8x2GyNYt0rr64nrv9fqlfV9FSkFmtkV5GRpICMaSf5xNrVfJrCMv9oAdlJawrJCMBmnTa6emR6YqIt0ezcZfF6CTQ9ucVx73OaiMfPDy12ad/f3nwZOE3B4t9peLMayrnePaacLuH+ADSvILR/CanTXa5aMtn2DgK9GGinzxaBxDqY32L3K0KydXa3W6qnLuGGCKeFb/0qu+aOvhnCmiodZzeupcExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GUTUH3sxUyFrzkW5Df2/uMVRAU/jgDHjZiBAsoxJPY=;
 b=k0GY6+No8Zirj4a49F9A4TylPq7otrfBbDJGhtvte/sOkGNaLb7CL2maNfEhn1WrFVpeCCgGrCd9sC6nEljjRd2650aTYw3M4H4/1dkVaWbAHvkpcH/jJ3swzVMM9uW3D8oe3zw9G7bYYegVq+5k7/EEnvx7qGNpD+5XoVrydts8urYayn42FrRi3WG6b82YAbgIxWe3SfKPYiWEp8q8EWsz1DxENldedgwRC7agw4oHB4Q6doFJXatj+0eAk6uaDXTiogAARMd2bZ59gtXi7qarTL/jIAxwRikoY22+5hPLD5pNcr1lcXJYiMKIj34xK40Tm2GKE5FFApnHildsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GUTUH3sxUyFrzkW5Df2/uMVRAU/jgDHjZiBAsoxJPY=;
 b=msoU1TA38Wi4h9q0hI7DsgGg30lQxdDvq/DKnCD+/4DiAF1+i51LUtNvL7eSLKzUAdzQNbGSvi6iYjAWMmeDZnGuOlPkNl/vdUg+hddrmMG4d8XL1VItquWJf+GtG24Pc8fxT304Lu44q9yaoqgxtGLPi6Twn7PmROMahiFvy/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:45:04 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 12:45:04 +0000
Message-ID: <835fa989-fede-4339-af95-0f1053d5e405@prevas.dk>
Date: Tue, 21 May 2024 14:45:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
 <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
 <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: c798d40e-47b4-4282-4206-08dc7993d67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01SK2M4VVdmQVZZczRERm0rVjB2NXZjeFZmVFQyR1MyQXBBc1pNTi96U3NE?=
 =?utf-8?B?YWFIamVyZ3NkbWNrYWtTbGgvZ1oyOXUxajZGY3hBTEo2NlVlTnJHeFdIRC9E?=
 =?utf-8?B?UWF3UVF3OGxBY1pKVjRzcFcwc0NaekpSUjFrdmFqVVFrZit6NXI3MWlxdGF2?=
 =?utf-8?B?ci82dk5HajlYZlN6RXdMSWNIckFBYXNGcXVwVUlVczdjTDZVaEpQWWFCQ0l4?=
 =?utf-8?B?KzNONk5KS2w4a2xkZmJEOFFBcSsvRzZaVUJURDhyRXVxclh1OWRFNWd0R1Jp?=
 =?utf-8?B?Z1ZuT1pBL0JqbU1VUm1lMG9pV2xaUGlDZXAva0pyNlRra1p6WWdPT2lkZTNO?=
 =?utf-8?B?YktqaTFHRkdSZWNXbjQzVkJaVFVZT2pBZFBwME93RE9tb09QN2Y4c1NFTkRU?=
 =?utf-8?B?Yzl1THF4MjBxS2JVUzUxZ3NzNzl5UEMxalFCVWFXZzJKTWhiRVppY09idUpL?=
 =?utf-8?B?T1JmQXlZeEI2VVVVRVlBam5GUHljLzlyRnd0bnJnSUhvMko0b3pyZmdoYnRL?=
 =?utf-8?B?bWJRem9kT0w0TmtXeUJ1eGdOMU50N0x1ZXFJOHNFZHhwdlpEdjZHV2xVeTFO?=
 =?utf-8?B?dEpDSG1IVnVrcDVTb2ZQeDZNVUhHUkhjc0h4YjlvZFhuWDZreFJqYjhrakwr?=
 =?utf-8?B?NEpockgxNDBWaWZuVitKaFRLS1ZONFU5RnJVZUU5RjE0QVo4VjNCMHJQcWU4?=
 =?utf-8?B?Q2c0TkdJbFBVZStWU0RZN2dJMi9GejJneXo2L1FkQmI4bWpNZEJoV3FYekpD?=
 =?utf-8?B?UDVsYVM2NktwTHZ3Q25uVVRLT1hXYXRkNC9pb1JBTWZTcENodE4zNFNjSmwy?=
 =?utf-8?B?byt0a0pRZFp4dGdEN2s0aVI3a080OFd0M1grN3EwTjM2SjFDbFRZS0ZoRUpi?=
 =?utf-8?B?Sk1NOVZ4c0ZvSVRETHlaVHRpWmRZMzVBVFpZOXpSdDFaKzV6TXk4aUdVZWR0?=
 =?utf-8?B?MzhjVkhZMWxyWG0yWmc4SzFlY0E0Uk5RMHZiZTRQc0RFTVhXelMxRW1tTFkw?=
 =?utf-8?B?UTA0YmVWM2FQZ0NZRGRGWVhSMjV1eEJIU0JpMndQdDEvOUV6MmpFN2F2TWxZ?=
 =?utf-8?B?dG5GWWRYTGhRcUduSlFCenBFLzdQVzkyd1g2MHZWUmhkbmZqWG14T3RzdEdG?=
 =?utf-8?B?SEo4U1BaeUhEQk8veHhZZ3VHQ08rOGpjRHNYN3NVWHE0SkFjN3B6aGtVZ3Bm?=
 =?utf-8?B?WnFmc0ttdUVkWTNDaTNKNGlKMWpMdzEyd1BsSFNtK1RubzNteDgzWmRQMEsw?=
 =?utf-8?B?d05VTGlaTnptTmNtK0tzamVCUWtoNGJIWUhZNXRRRjJoR2JqN2tCMko3SkNN?=
 =?utf-8?B?UDJWVzNMUXVKUEs5cjRoS0ZmZ29iNjBJaXlSTmJJcDh4NURFU0dJOEhZdVRw?=
 =?utf-8?B?UjdYNC9xblI5TnNENFUxU1hoMVVLek0wTVEzUmZlVERTdHZxM0VjbVZsR0cx?=
 =?utf-8?B?akNNTEhsalgwVUFrNVRadUc5djhPdStIOXNGQkFyVndMK1hGSnR3WTlDZVRz?=
 =?utf-8?B?V1ZaSHJuUUVsdlJxOWc0ZTJuRTFtdWtnb3JRb2szNlhvRUpjV20rOFRyMWVE?=
 =?utf-8?B?N1RVTUV2SjExS3BENVlER1Jrc0liTUkrUGZnQUxka29ZRk1WQmZycWhXcnRq?=
 =?utf-8?Q?SpUy6W/W4B2qCjng3vRX4FYwLnLBSS3zAcyWu5wnPIsk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTM4ZWVHdG03dnNJRWNCY0FPckJIejdSTUkxclJzNnhrcU9ib0FZM2dlN2ZF?=
 =?utf-8?B?L0QzZllxOE55QlNYOEQ1dEZER09GZGMrcG14VDJjTzdyV2xwR0s3YVlCQ2hO?=
 =?utf-8?B?enozSWtnQUJ6akF1bDE4dk41VUVkL1FqL2xZTEM3RFRyUXdQa2pzVTFoa0Q0?=
 =?utf-8?B?TUcyZmRRaFZIdkJscjNRVXk2YWxsUzdkdHJFSGhiZ1VGRmc1YUlsdXBDTGdy?=
 =?utf-8?B?SVp4aWxNTnE1WUNyNEdtdGRSbW8xQTF3ek9Ra0QzamJjTGJ4Kzgwc09JNG8x?=
 =?utf-8?B?ZExlTnhPeEo1UHFsVnVteXpEWHcyaThpcytsd1ZuYk52dHJxSld0aktuNzFF?=
 =?utf-8?B?SXRad2VSbHF4SGJIbzRpbG4vS2w1cStsKzFPb2l4VFFtYXBKQml4WC9XUWx6?=
 =?utf-8?B?dEo3SFZ6UjYrR0VKMEF6RG52VnVxSGZmVmwwZkJHVHlBUjU3SDI4a2tYRnJm?=
 =?utf-8?B?eUlYZ1U4aFRiL3NFTWk2VFVCTk9hTDMrVVVpM1RMTUN1eWJNZmNzbFRGTEpG?=
 =?utf-8?B?aWcwKzJJSm1vVU5FUVJLUmtWWUJjWlVyak9WdUxFTWFRcHZnTHFVKy92QVBH?=
 =?utf-8?B?YWRlU3k3RHBYdENCbXMyb0orWS9maUhZcGVPaHl5TlFYSUJWZVdDSUpYOURk?=
 =?utf-8?B?MHdWUjRSZis5S2pkL1RPVDNQM3p2K0V4ZzIvVjErTVRiK2xTZG9XZTYxdVhq?=
 =?utf-8?B?bVJQVHdiTlhoNkJ6WU9KRHRZT1ZvUHVuVEtJb29ZVUNtWkdnTEdnTnUvRHhI?=
 =?utf-8?B?eG81UmVtWjdFYlFZcTZudWFldjJIY1BhRUJvamxBMkJGRlZQK0JJdVhMdVRw?=
 =?utf-8?B?L3cwM1R0R2ora3JBMy9aTE5qRWMxUGdQVThwVUtveVFSWTZXUklxTk1QZThM?=
 =?utf-8?B?bkI5VUlCWjBRTXI4U2k5N003Rys0VlJpZ2gxblZZcVNIMTg5WWszNlBGZXNR?=
 =?utf-8?B?Wjh2b2RIUGs1VTV4Q3BhUlhOd28wSVNMZ1pqWkNQY2VuQWIyUzM5YmFuNkE2?=
 =?utf-8?B?dDJBeGFrMDR3YmJUb1NmVkIyVHFFcUFldzdZRnJjNGxsMkhvdmsvTlBZUlhi?=
 =?utf-8?B?eUU4ZGNzQ0M2dGxKZFREdHkyV2psODlHN3c4QWlnZ1ZHM2pCVXhncFFhdlBN?=
 =?utf-8?B?RmtvekVnZVRNSFJPWWlxcTZFeHEwT1NDYTdSck8wNVlpRmprbUxDcG1KR1Fw?=
 =?utf-8?B?MEtneXhqRWNoWHB5amkrLzIvaEpoWGttZ1ErWDhJR0FETkcrZlhjZlV0MWNq?=
 =?utf-8?B?WHcxYm1CUTFneGNIMlBaang3c0EwZ2pHeFlhK1Q2WkNDWUFGTkpCTkt0TXNG?=
 =?utf-8?B?aGZiZ0VJWG8zQk16OWcvNlZ2SFhzbDVTUlVHOXViMVA0ejVWK3MwWjU5L0Zs?=
 =?utf-8?B?V2JzeGVib2NZN0hVd3dxTkpxdEdZaEJXZlpiUGxSSFBVdTN1alo3OFJpdmhN?=
 =?utf-8?B?K2hSME9jd1l4ZHVheGVhM1YyTGNtTTdMcUhCTmE3cHI4Y1pHSWxrcmRreVR0?=
 =?utf-8?B?N3pIZTFnZkxCMVJmd1NVLytndUwvejZkLzQvaC80dDhmZ1E2aFNjbERIeTRN?=
 =?utf-8?B?MFpqZDExdXNoZ09Ncmtya3EvSzRxb3ZZZXZoT3dtRnJwZU5DQ3lUWXVzMDVr?=
 =?utf-8?B?bWh3UGVOZTJTUFFBMUxpWk44VVI3T3h5NVBZaTJ5eGk3Qm5BSFhpVXRDWmNS?=
 =?utf-8?B?d2l1ZXQrK2V4MVNIQStTdWFWWms2QTQ5T0J1TXNKNWx1dHRsQm5rTCtjSHRa?=
 =?utf-8?B?MENXT3UraHkwN280QmZxUUJWM1FlNXFESGk1eEhzSmttNE5SRldXSS9uQVp0?=
 =?utf-8?B?K1M5ankwVG01SVU5dDhoc09jdWVlTzdobDNLc1FUTm1VQ29GVXA3VU5aZVpI?=
 =?utf-8?B?WkZWVEVaUjRKN1lzaTdQeWozTzFIZ0NGa0RjY0k5alNhZ3FYWjZ6bnFOeDVL?=
 =?utf-8?B?bkFFMDZnSlBXVVVIc0NidmErK3JiT1JIZFhPYklycXo4SGFiemtZRmpCbFlS?=
 =?utf-8?B?K1NDd3VVNS94NWw5YktRL2ZBWXFxb0NFZW40V3RPaUVPd3k5MVFMRGdBZ1B3?=
 =?utf-8?B?eE1sZ2xYZzJ2aEdCZklTbEVHTkpIaUtYdW9qY0F4RkRkd2V1QXJnaEQ2aWhz?=
 =?utf-8?B?ajBkUFhWOTA0ZUFTVzF5aElMQ21YWDl2REZlNEEzZFlvcUUxNldrZitoVHVP?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c798d40e-47b4-4282-4206-08dc7993d67d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:45:04.6987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV55rDdpTueCkri1N31nxKxQ6qtwAwqXQFyY+v1i6rTxBncRpAWc7sQokond+rcyJc37wS2LwqjcJZfpngEubLc/UM9mKCygeKp1zGpzTq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7360
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

On 21/05/2024 13.54, Stefan Roese wrote:
> On 5/21/24 11:47, Rasmus Villemoes wrote:
>> On 21/05/2024 10.46, Rasmus Villemoes wrote:
>>> A bit of a mixed bag. I've been wanting to submit something like 3/3
>>> for a while. So when I stumbled on Marek's patch
>>> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
>>> , I got reminded of that plan, and I think that patch could be more
>>> readable if we adopt this model.
>>>
>>> While actually doing those mostly mechanical changes, I stumbled on
>>> two separate issues that probably want fixing regardless of the fate
>>> of 3/3.
>>>
>>> Mostly just compile-tested, and now also checked that at least the
>>> sandbox test runs succesfully, and that it builds both with and
>>> without CONFIG_CYCLIC.
>>
>> So I managed to trigger an azure test by pushing to github and creating
>> a dummy PR: https://github.com/u-boot/u-boot/pull/542
>>
>> That fails, and while it involves the cyclic framework, I'm pretty sure
>> these patches are not to blame, since the same error also exists in
>> other pipelines. It's an "expect" failure, because some watchdog
>> callback apparently sometimes takes more than 1ms, so the default 1000us
>> threshold is exceeded, and that prints a warning which breaks the
>> "expect".
>>
>> An example is
>>
>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8459&view=logs&j=a1270dec-081b-5c65-5cd5-5e915a842596&t=69f6cf72-86f3-551a-807d-f28f62a1426f&l=1055
>> .
>>
>> I don't know why it only/mostly seems to happen in clang builds, but I
>> think the fact that these happen quite frequently warrants either
>> bumping the threshold used in the CI builds quite a lot, or adding a
>> config option to suppress that warning/limit altogether for CI builds.
> 
> I've also seen CI build issues from time to time and restarting the
> build magically solved these issues. I'm all for making this CI
> build more stable, perhaps Tom has some ideas?

Well, the problem seems to be inherent in the warning from the cyclic
framework; maybe more so when the build server is overloaded (as
sometimes those callbacks are reported to have taken 5+ ms). So when
running sandbox, or under qemu, I think that warning should be disabled.

> Regarding this cyclic patch:
> 
> Still some problems, MIPS64 related at least, octeon_nic23 target:
> 
> https://dev.azure.com/sr0718/0cded7c3-6e6a-4b57-8d0f-65c99496c42f/_apis/build/builds/357/logs/415

Oh my, this is starting to be really embarrassing. The fix is trivial
(as the callback doesn't even use any context):

-static void octeon_board_restore_pf(void *ctx)
+static void octeon_board_restore_pf(struct cyclic_info *c)

Should I resend yet again?

Rasmus

