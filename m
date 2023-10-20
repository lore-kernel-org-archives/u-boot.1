Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE79DCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 08:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7338719D;
	Fri, 20 Oct 2023 10:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="S4GQ+Gd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C87038744E; Fri, 20 Oct 2023 10:57:35 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC9986FDE
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 10:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB07pr+7Lli53XUYyGuctWrPSA3zl4cxjFwttJpBF7/wOtPsU+427hy66glbQjFqrmHUhk4/8avtenDk+6C/0A5rtad+0vPXd9I+tQskO/YqlA6GH1G1zBPPRkzA/+zsOSWedXgPdsP0NGFQgSPIw2cF1yJHBFyEpKJvCWhbIgT694kEsQiVFJGQLxw0E/vK6hTIRtwb9CqZjHVEaLlll6hmg0bZenhP0eN5mpBdDGu2LJ/+k/pU/sqA8fasUZe6+A2fuKvIh5ZuDclnPQiGriBbdbmkLHLwUyA+fGiPSYEM50Mlld+y6h74MqlL/0IDiyVj9PErSo9LatKdbS1YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk7CA31JOhHGntapbsqKQQ5zCUYwgCPmxKVBwEDHMDc=;
 b=SnUDfX7DRA819MgCCoVxJdZjJWUrJu4xeYzcHm+7KTH+MGz9N3D9u9be3hqoWBhbOEpwIadOBRVdEDw/F1e8avLgRUIHIJalPzM+EgOrTzgQLqJNAt6cqaO6eWcow+NSba5ExRZ6NIUmFr4POlywpiqTEQZZPXdg78iFfhBAVGLc7BeGP4Yt5or13W21qxO7Gz91QcX2elXqtKwa9VyfCm31yqcZi/IKrf4k5dT3WU8/Wa3w5iWQxSv/a3M/56t8+vFoeq+7XKrH26jaLfKw/+1Dy7lciY3EMdNBz1J/IR1eR/x0Tu9zD4AO0SnuZXJh3l/bxEsDAlvOHxCl6sSNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk7CA31JOhHGntapbsqKQQ5zCUYwgCPmxKVBwEDHMDc=;
 b=S4GQ+Gd6XicPq5JorZpdMZnTavaj30bXj/ZyZW4eFXk6ITkuoadq7ft4//rifZGIASh17OhyT3J8aMmvvT++2BXQfQXnD0YJRCu7m4tMQCWYxuEzBo8IkT8enZqhp+oE+CYeyp0D4+W+xPw5tRDkXLlQLCmB9miiJhFgv+IhJKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA4PR10MB5754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 08:57:31 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 08:57:31 +0000
Message-ID: <947c0b11-97f5-4d8d-9202-c79131296cf3@prevas.dk>
Date: Fri, 20 Oct 2023 10:57:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] make: check if DTC variable is an absolute path
Content-Language: en-US, da
To: Richard Marko <srk@48.io>, u-boot@lists.denx.de
References: <20231017104453.2121276-1-srk@48.io>
 <20231019130412.617507-1-srk@48.io>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231019130412.617507-1-srk@48.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA4PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: b83e6159-5d78-40da-fdc3-08dbd14a97f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xE7UQJfW9m3x2RW1/L+vQoWP3p0s4q60DcTDqX1Upe27hxnUHIvxVed4kJw5emsKSkuxGgHxqRne+Mw7gvLN2KC1aET1QAUpi+awKBs8x9vrxiyEyMV1NaMvGp7DrJCBnikTDDP75ISBTAGfgESeMoMtnEVQielh03xkY5qN8n7tnbJoA8BpCCwBL+iAZHRAVdB0EmBi0q+PMLjyKMfEWBxiGz5l/6VpPpguEJ6C0AXpOXpb4LUXK5fL1fWN1/dvrre8wtTDAiV4bpCCw9e8vHf5I0VxQJC5OSBe2bRifMz9iKmDkqzYq6vD4ehWIujArvWlNYcs/h3H5TRdYnwvTeBLrMXOja6TlzVa6joVcq8ee2kPK6KKGfhtvcYgctGTU6jdm8QIutakUy0n/9fTux/yUVPOz8SRnjdg3FRTXkW9+D7vHTRX9rLMDJNYhpntOLjMovOacZTGCu6r/l2Gl/CLJA/mwfqDGGeASwXaBPiN+OYmY+5XieSk1X6VARBpCgu1pEWh8MbeaksP53//kX5CFV6LNmJ3RBt9t/AnNZedeAebZGt/0PkHPvQYPYn5IRvUO76JgysFRHpjAwHaZAysfgu1dIfcuwSngvP9AdfN0yqnGNee06Jp4gMETrA38sjSR62F78CXiu7aae+B5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(86362001)(36756003)(5660300002)(66476007)(316002)(66556008)(66946007)(8976002)(478600001)(8676002)(6666004)(8936002)(6486002)(44832011)(2906002)(38100700002)(2616005)(6512007)(41300700001)(83380400001)(6506007)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNkamw2RXpmaGlUUVJ0RTN3MGE4UzdwWk81UTFrUkJMbTJtRzhwd0V6Umc0?=
 =?utf-8?B?U0k0TUhDd0ZyRVE1M0Z5R054QWdEc08vL0FEdHA4c2g0V3JTbEpLZjJLaVBM?=
 =?utf-8?B?K0RCSktCdWs5Qlhpa3p5VE40aXl0SHhQZWtlRjN3QWZSay8zMWdTUTVFUUsx?=
 =?utf-8?B?U3NPK2NsMENFTSs3Z2xBTlBJNk9nenhnYnBtSTZaRHlpWGQ2RkFMZTJ1TlM2?=
 =?utf-8?B?N3R6Z0V5UldkRisxQVFnMG9XQUZURzNGd2Y0Y3kxcUxieHFJUlNTOS9FRkkx?=
 =?utf-8?B?TEIyQzZ5djQvT2dZbXJkT2dWSGdwaDQzSjI4aExzbHU4RXZnOGlMeUZmV3hT?=
 =?utf-8?B?UGxvL29Lenk1NFJQTmpyNnRpNWVXNEsyWThMY0hxVUNjdE8xMWNNNElaM1JU?=
 =?utf-8?B?bmhYRUhqT2xqVC9ta3c3czJ5SGI0NEUzZkdhWlg2S1lQbFpRSFVWOTVwaDc5?=
 =?utf-8?B?bjlLZmttWmRyM3JyZkUwSVN5VkxjNHpXTnk3b00xdHB1Z1N2TEpJUDRDd0Vw?=
 =?utf-8?B?Z0hnWnpERUMwTG9mdzNtL3doN3dMMlpZTVJwcVNkMnluUkZ2cEtLUXdzSmRh?=
 =?utf-8?B?TVB0OHlUZUNnN1FZSUxSQjZvd1NtU21kVkM1TmJEWWU2Ly8yb0YrOHZCdGJT?=
 =?utf-8?B?ZmZmd2tNUWN4bUdLbG9JZFVWb2FGbE1nQS9ZVHN1OGE4b3d5NHhhMzBMNGZQ?=
 =?utf-8?B?ZUxobHRCMmZTTHM5emJraDZiSlROZmNRQzYxV1FqRTR5MEJGM2lMQ1lQbDFq?=
 =?utf-8?B?WkNxb3Rybi82dUE1ZDNaWlg5bHFqOGFTdkE4a2RlZ2x3Y3hvYkw0M3VDN2hP?=
 =?utf-8?B?MnJ3WCtZRUh0WlNWbEZGbXFLV1pCVEV0WjQ3MFVoQW1LZnMwaUc4YzBDTFlS?=
 =?utf-8?B?eDV6S2l1UnBBVFRhcHAxZlNEOFR2cnVJK2FEY24zV1JoaC91MHNZRzF0bTBR?=
 =?utf-8?B?NjZFRTZScEdoS0J3aXRhTUtjSzBsQTFUWWNKUmdta2NLWXBaU3hGamxWSHpN?=
 =?utf-8?B?UndlbFY4K3Z4d2E0RzlPdTRQcVdxS1hRU2xiWGp5S1E4dUJ1TEtSS1pQRktL?=
 =?utf-8?B?dkNkamU2a1JJbGlpSVBGUmJZaUw2eDQ1c3U5ek56L2ptRjV1NjZZUTNxWUdm?=
 =?utf-8?B?KzhQTlpSWnVnenRmK2hqRVdhbExRSWtaTW9HY3Y5V3Q5eXF6OTBCOTVDb0Jz?=
 =?utf-8?B?WGxMRFFPUklqWlM2UzJIMUoxQllaNWEyZUVHM2VldE9ZQVdvVVBlakMrUjlq?=
 =?utf-8?B?anpQM1lUYVU3NUZIY0N3aTJxaVZ0WFlNTXBIaWZ1b1BoQmhpWEFOWlI1UUpO?=
 =?utf-8?B?QXN3ZlErYlQ5MFlVWlVPcHFOcTBXTWw5dm15dDkvcE9NSFJHVysxM1FWYkdu?=
 =?utf-8?B?cVJyVm1aL0xVcjNrdjBkYldSU1IremZmMkxuMHR5ajRFR29iNzJpL2VkUUVh?=
 =?utf-8?B?ckVRbnY2VmlXU2NHVzVGOFVwdGFLc09PQXBleEx0cDJYcm5WdlUxbXF0Rkpx?=
 =?utf-8?B?MzlFQ05uMitKM2owaGVPQVUrRHpnZ1g2YmNXcXd1b1UxU21YMXpqUytOeklH?=
 =?utf-8?B?ME1sc0lkQXhJSVFpMWFGaytaeFBXUFU2UU94UXlwSXMzemttT3NGNE1TQS9Z?=
 =?utf-8?B?OGxQbWQwTWJmSkovbHJyYnZDK0R5eXlPNHZXdzliZ2tXNkl4VkNZRnpuN3lt?=
 =?utf-8?B?Wk02Qk8xbUhkVklRazV4L0dzR3ZGbDkwWENQd25lWVM2ZXJCd3ZJZUFRdWNN?=
 =?utf-8?B?OE1TUldncWQwRTRlOFdJM096N1BKVjlDeXJzcFdxdGxQTnEyRHhJZ05Ja1Rp?=
 =?utf-8?B?Q1psZFhIVW5WSzVyWFZuK3BobmVieWZNR1F2OFYyMXgvWm12VHF0a094Zm04?=
 =?utf-8?B?UHhjSzZjL0ZTdEljeWEyTlRXUFRaTHIrYlRhT0RYeG5VWVd0TGxWRlpJVmY0?=
 =?utf-8?B?UUU1VTk1T0hXdW5GaUJwOE5yc0YxRzB0OVE0ZDdyVG94czhZQnZ4T0FKVG9W?=
 =?utf-8?B?TkE5SXVvMmsvRDZKeDlGM2dCZHA5MlZBWndBbDJLNDhjZzlLV25qN04xM2pW?=
 =?utf-8?B?bUhaYTh2bHNETFFVTVI2dE5YMHhlR1JOQ3p1eCsxcTVtZzd2K2t1VDYxSGpZ?=
 =?utf-8?B?RnJCcHBoU3JTQ2tWM09UYkd4b0JLME1aVUY5akcxOHJseWZsRmJGZWkxc3dF?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b83e6159-5d78-40da-fdc3-08dbd14a97f8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:57:31.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXEri5/ogq8TXsbD5IclIDOPj/Zc7LS+cyRFn3Abkkc3eHuphAkCX2OFjncfhKvohWDqPe7rRD7NyggX/I5koMJETqMPGYJR5EOZIDochMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5754
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

On 19/10/2023 15.04, Richard Marko wrote:
> If we try to build using external dtc using
> 
>> make DTC=dtc
> 
> we get a confusing error like
> 
>> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
>> needed by 'dtbs'.  Stop.
> 
> Workaround is to use
> 
>> make DTC=$( which dtc )
> 
> which gives make a full path, so the dependency
> is satisfied.
> 
> This was introduced by commit d50af66
> kbuild: add dtc as dependency on .dtb file
> 
> This patch checks that DTC is an absolute path
> and fails early if not.
> 
> We also replace `which` in `scripts/dtc-version.sh`
> with POSIXy `command -v`.

I think this patch is very hard to read because of the initial check
that moves all the other checks a level down and increases the indent.

I was more thinking you could let make do the work instead of doing it
in embedded shell script. Something like

diff --git a/Makefile b/Makefile
index aeaa6987360..f313e9dba66 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,11 @@ PYTHON3            ?= python3
 DTC_INTREE     := $(objtree)/scripts/dtc/dtc
 DTC            ?= $(DTC_INTREE)
 DTC_MIN_VERSION        := 010406
+ifneq ($(DTC),$(DTC_INTREE))
+ifneq ($(patsubst /%,,$(DTC)),)
+$(error "$$(DTC) must be an absolute path")
+endif
+endif

 CHECK          = sparse

seems to work (though I have only tested it very lightly). One could
also add

ifeq ($(wildcard $(DTC)),)
$(error "$$(DTC) = $(DTC) does not exist")
endif

inside the outer ifneq to make the failure very explicit.

Rasmus

