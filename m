Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E89CCD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52678486D;
	Fri,  5 Jun 2026 10:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCHbH2DZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B90684895; Fri,  5 Jun 2026 10:50:54 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245418484F
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfCSHdquoMwQJhYCYuTzQPaP3R22a2OMBJtQPOXv79Ncz+v498EI1ZWdGbh8S0JhJ2xJuUpW4YMnslNmR4+8KExIxnQ1YnBDzSP5zRLEVA1NTeknog7AngvePuLpe6vbt9Hmzl6hO/4KyfPSIKI+bUeYXOHIAX9Y9V5sHFgXQ8O9mTdysvh09Ep8zHQSSr6z2a16ingAghzW6z9hJK35YCXavnJ+HO2XHjNr+nv0mXmpmn2CqYeZ/COckc0euPHEdNynd53XhdoHQKh+bj6IUZAa9EbBhOennyqAsyyw0Zmt/qLUxxeKGoKMZ25vZjKMCJdQS6GijM5lpteJE1lSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAzM5uQ8Ulz140XlyqNfzIpvZfLfdyFpjv2qBtEUjNc=;
 b=CAfpY6dHF2yNGMghxcPAAvcHzRTZ/7yt1NPyta8bzIRwkP/GW+ODTcC5DT0V9RjHmIwfpqib4d33olVUp6Vj0ya88ksc34z6zluB4lQWJKxr91ZEIMMOYVrj3ZbKuFsPDD538htqDqOEs4KTtSEz175/jAYCv9k7KGbmMf9N+qlfBNtc/g+TNvbd8Pap3fbA7kLyq0ANKqeGUNPEsy39VmgnaV1mVWJV+zS8W9oAHBgypz4maqy0tF1FUZJTNzDMgcUCB+uQJO4B6iht/AdoGoR7MxgpLo/lSVRAMnr0aqZUxvXBOCxD09iciBszhUYOQKXVdiJ8IpJa4muOxcU96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAzM5uQ8Ulz140XlyqNfzIpvZfLfdyFpjv2qBtEUjNc=;
 b=iCHbH2DZfrVnhKMOipeGl6poDigQOAvB01NaVuJrv37XbAwIrxK1hGcfMAonLkHAUP9NpPS3M7JXxUA57AxIDXpWPLRNn2R4MVqq3TKoknajG+elFDp5cF6PX4gVcKO1fyztz9yy6RjNQDSeFwKZoPY7+SKbPyQbW7KJc+HeKpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:50:48 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:50:48 +0000
Message-ID: <8bb78933-862e-415d-936e-fd8b261230b3@amd.com>
Date: Fri, 5 Jun 2026 10:50:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkimage: allow zynqmpbif to use a register initialization
 file
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <cab1c990-a44a-4b2f-b50f-1481dd00b16a@amd.com>
 <20260603145453.552101-1-erich.e.hoover@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260603145453.552101-1-erich.e.hoover@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: aa790b6b-eeb0-42ab-f410-08dec2df89fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: lYgTiSBbGIlvip3yAPBtfkmybC8GCxE53R7dlKO7PQ8zOA1E2BW0tJSDB17n3MsFrIhsyPMhEEiMfzAnLJTZ21soHW/6c9DZWC1u8XzjVuQMH6VZv23zZjB334fR1KWoUeylW1H/6zDBVcJF/Z5+xlUeVXoH4vOzag/wRgnH7x6lPAkD50o2y3KhwuEXK5VpOqufJbM1C8qoegADZhYJXoElNW1C9QzJnTRonMw+zVUFyG6vI6tjZ9n44+zmKBl/nnPqCC+Wx8SP5so3UHCkNBjoGgJWknlpbRhD6Y+L2nzY3CEzauwPwiucKegAx7gcGhqIM7/VZ0D/VOU4VxIbZqsXWr4h9D4Od4+Be4M46fUlD3UsNX+runRrKaqUL9L6yXVFNEuBhrrFCp2zUxHEYWsaR/jgBNbZJGpyw1NuATlkl0Wp3gGY8eP0VmWvi5OohUf7klxKwBym68UJDPGjmhD8dr9pOEz9JrKBI5YwSzXMgOXK8ZRX19fGIlWj/ue/KZaVFYa8iiZ6njU3l9RWWbcykkY11uyp8tq7peJWvlZMI2DNVzwu2BxLwyyR4/DSyz1i/AA6gasSo8Cm6MmJQod2mgoArlZ7eIEAnkRAliGAgt5r8n2UBAmndItszc8ymyyoyjqsuBGrx7Kx5Q+DUoyrdNlM0V2gjcOJoerqJTbsPo1vi5qJV14HETzSLCS/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBTUEJlbzdFL0RXaUpFbHQ2U09tWWErWnVBb1pSdUQza2VCek9vaS91M0Jo?=
 =?utf-8?B?SXZBckpvVzQ2bDFFS1dScVlCd1hGdGJHTGtTTml1VUIvamJWQlgvM2FQdlZz?=
 =?utf-8?B?b2pkVEUvcndnbFdaSlJMR1hyR2dicXViV1AzTVptZENzWFRUc2ZsNXlLdFh4?=
 =?utf-8?B?Tm94c1JJdk54aHl1RUwxMTliNHJxeUpDMUVpbmRoekdlRHBFSktBc0x5N3k2?=
 =?utf-8?B?ZkFVUHNQeXhZd0pvbTZKL0dickRDQkczQkszLy9QZnlUUnZMMTJNR2NLalZI?=
 =?utf-8?B?d29tM0pHOUkxcjFPYXg4NmpJNFN5cWdyT0hkZVRCemhoWXJiM2I2U1J4YllC?=
 =?utf-8?B?NUpLNGpCdndtV2JrZFcwcGs0SXFzZTF2UDBCYmZwM3JMQitRc3JmWHJYeGx3?=
 =?utf-8?B?QldtaitvRHR4LzRVYWpVanliUnVPSVFicDFsbVhnZkkxZTFZS2ZQS1BDcHZE?=
 =?utf-8?B?WURPVTlQS1U3OUpIZjBReVdzRUFUWW4zVnlSZ1JKeUpDM0hLYzdRZ21IbytR?=
 =?utf-8?B?QXdMOThlM3F1U3RESld0amNjanhSMjk1a053ZUo4YUxNckRZdEhSeUdCSEw4?=
 =?utf-8?B?N3VQWitFVUovTHFsRzlweklFT0dKK2pYREowZGIwbnAwVlIra3k3enB6UFYx?=
 =?utf-8?B?MmZkVmVtbEp0U3JZbS9PTmluRXE1dEZkNlovaXRGVndXalRiWXlLUXhSckdC?=
 =?utf-8?B?Z291ald2djNacmQyVC96UkxqYTh1RFpQanhxbFBObXRabGc3WHdJdlNGVE0y?=
 =?utf-8?B?ajFLbkhOdS90TlpyMDVjUnM1bzQ4MlJkTjhsQjRHdkYySVU2NTBPa1NnSFIr?=
 =?utf-8?B?Mm1JeTMvUmlnY2gyeDN2Q0p0VDJUS0t1TUsxelFYQy9aZXpmWmF5QVdCZ3A5?=
 =?utf-8?B?SXcrSFd5Vmt6MHhKeFk3K0pTakZiY0s0MlNUL1VNbElzWDc5bFpTYTk5WXVE?=
 =?utf-8?B?V0NqZW4zMFZVdW4yVmRjemZucVhtS3U0ZWNMaEpvNUh2TldLbE1CVlF5TWhW?=
 =?utf-8?B?WDNnSzRnZWpUeVlMMTY0NzhCNTdDZlFqZ3hmenljS1JFWWt4Sm9MTXRBOEdl?=
 =?utf-8?B?cjd4Skc2aHdYeFo4VTJxY0U2Z3lNUTBWYmxGc0ZTS3BXZVFyWXN1YnNpK3Zo?=
 =?utf-8?B?c2tWMmpwODg3bUd6WlEyS3h3Mm9PUEtya1VpVkdrN0dXdWg3SkE5bnBJdCt6?=
 =?utf-8?B?MTRtZ1JtSGZlWi92YW0vVDRMYkV3RHhqYi9Tc3RnSzAxRlFzZ0JLSGVlV2RV?=
 =?utf-8?B?TkxPYVZtWHh0QTRRWnlkQzJwTDd2dFN4MU12aVFuSU5KcnJGT0ZHUUhhemFx?=
 =?utf-8?B?UEw2MHhZVjNGSEQxMno2NGgyU1FPRE9pdlN2cHFqd0Jtd1hmdEZXVEhyUlVV?=
 =?utf-8?B?eXRSWDE4TGhEV0ZDSGtwaUVMeWtrYndBTjlzSmRac3U3bXZGOVNwYWpDWnlJ?=
 =?utf-8?B?Z1k1MHphTFVUVTYxZlFIYlJSOWgzTCtUbjVTMXZFVnUwRmplVE9XOUhpbXg5?=
 =?utf-8?B?c1liVElQMm10bXBjTUF5R0FBYUg2UHZpS2ZsZzNQdE43dHB0eElOK1QzOWE4?=
 =?utf-8?B?L2pYeTFFL0V1Q0lEZGtZRktrVGZqM21ON3JGRG9sL0xLaTBsZ21pOUx3VDlu?=
 =?utf-8?B?blNyU1kwaW1pREZRWWE0OHlJRGw0UTBOc3d5ckw4MXhpWUxaT1JJWWlSdkJh?=
 =?utf-8?B?K2p2cmY0MiswQVMwWHM2OVRyb3lidlBnNzNRbG9LcUs4ZWJhOVoya3RYQ1BR?=
 =?utf-8?B?SGsvbFd6aU5KejFDOXN5anF5T2dWMHFEcnA5SDh6cUxxdUZicE5SbjY1MUlR?=
 =?utf-8?B?MWlOaGkzL2RGaEllejhVRFU4d09YQnA3bmNjajVMOXByZXl3eDYyQ3QxaU5G?=
 =?utf-8?B?KzEycFFsOE9vRkxBdENhR2FJalh6N1FQcWYyUERERGdDaTlqdGR2bVNaeGMz?=
 =?utf-8?B?YzdmaG4rRnptTkh5N1VRcm1aQ21BcmhSTGxDVzZlaGdyOTArRU4raGJlTU9J?=
 =?utf-8?B?RXFPM2NLRTdPb0dCS0hQdDJPVDhpL2p5SWRZQ2FkQ0NGMXhvTTdxYjZ5UHlp?=
 =?utf-8?B?elBuMlFnV2thWjg3TWNTM2NxZXRFNWxsd3lySDlvU2ZaaW5KaEhpNWNtZXcr?=
 =?utf-8?B?ZjVIZDR5a3c2eTV0SlpMQmNiZ2tsYVpNOHVJVzJTZDExWkZxallxeG9IblpT?=
 =?utf-8?B?bnByb25qOHlseWlSS2xiaW16VGxzeFRIUTJLQWlwcU5Kd0QyZG1UN0YrWjNG?=
 =?utf-8?B?M2lId0x6S2dCZlVJUUtEQnlwcFJpR0hCS2hRTklZRG1jQWRLWHMxQXQ0Z2o4?=
 =?utf-8?Q?yExJrm702TRTo4kmb9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa790b6b-eeb0-42ab-f410-08dec2df89fa
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:50:48.2666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHmxVnWxwA99bEoUD6hysbRMDx8QhubsPUFEBu6wCz20kIn9S61Zu6xKAp+gWrpq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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



On 6/3/26 16:54, Erich E. Hoover wrote:
> The ZynqMP Boot Image Format allows specifying the register
> initialization file with the "[init]" attribute.  Since this
> feature is already supported by the "zynqmpimage" backend, this
> commit implements a binding to that existing support.
> 
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
> ---
>   tools/zynqmpbif.c   | 16 ++++++++++++++--
>   tools/zynqmpimage.c |  4 ++--
>   tools/zynqmpimage.h |  2 ++
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 
As discussed in that separate thread please send v2 with extended commit message 
as was asked by Sean.

Thanks,
Michal
