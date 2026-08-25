Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE0C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 05:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0701402A0;
	Tue, 25 Aug 2026 05:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyCJNY5Uz0C4; Tue, 25 Aug 2026 05:17:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787635075;
	bh=Rn+lDcKn6nHZshnTxcmIeuvAb/mNR0im+hy6K/sUGRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nI4wVx62gOoW5UtHpLMTaOyXCiHoLfLzvCGZsI7EDoVzXZt4mn6zemH634sKsVvst
	 4/JX+kjpg8t8CsmKkD6afL7uAs3tJ7w1Ux9Vs+HEUq2emH87Rnh1Z1k2L7azAUThuN
	 t7jzR2iq9CsaLrGnYuEmYgmvGmxtu2p/IfkETfKvc6E7kgFh7LwoqKeueGxv7b/2DI
	 tQBHbiSIqY0H7HihaDzKhKiIBGus4P5g4pyvhels5gxujU0Jt6prmm2Uiv14il7TB9
	 wxzetAO992CEOdaMmcP1PUzlSvXSWx26AcRSM7dWItXNAdz4NnQyo+uWyX+b/D6aFc
	 9loO9TGW8Sfkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C970D4027B;
	Tue, 25 Aug 2026 05:17:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D053336
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BC9060672
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDuFN0eAD1ET for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 05:17:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sBzwKeMg
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D71660667
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqOrL9dDAmNUq2u5okjPa0tu75chRZ8TihQFsuDV9yc8YZypvJNH5ub8iPm8wzRBUAIxU7PAI/207dNKzYyGgOhluyDy57Cl96TNo7Nl2mWZn/0NXU/QlW/kEq7IhfoXgXkG9oahN5iTAAsx+qn0FAkYM4G/XKdL/iOzgijFtQE+yytTzbtEfl3qw5I4Bu0huIjUFsSMW9vO4WKfgvaI5wzk0JZAx3UKtFtPkYAEsnkRdMlJqEubTWkvtbH9VyMEZaucngHNuWRnr0fPcTUnnM6/DkBcGnMZkWRMJSq3VazmuEZp4MZfrRmrjWs/HimoM6uvXrTzXW/955pa4Hkb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn+lDcKn6nHZshnTxcmIeuvAb/mNR0im+hy6K/sUGRc=;
 b=yf27Cvlg8IjpwgUF7pQ615sHWV1A7LIvY/rU2af+gxOPWSPEdxPts0FWPN3NyvA9WoAvBjQ7+Q3jRygLUQAlPFn6I8Q7/4c3q/R4GS9IHP1+FMHm3kng4gZx9NgpZklfJacvIJm42sIQpzSF150E1VF4C2nAvCG0ourybqpo0moLM5D6+iWLwN+lSRwb2cSVkZ2s+fP9PiNOJAY7JNESBGZYYYfadwEE6yGAHYbWrN1knL9R8OYHiIjXKvJQbLC/XCF5kU6OMiuNxfEUUBSUMJAQ5TvwPzL7sdpeHCD720Nkfa4eaqRLy6kIERQ1peIrYTigS1z6lx4Kq+UVFkPgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn+lDcKn6nHZshnTxcmIeuvAb/mNR0im+hy6K/sUGRc=;
 b=sBzwKeMgkJ7qCZNA2X82eCt/lV3BIgZTNUUUthxMAKcyamYd1Tnl9lzPnlJYet9ttk+6bIpZbbyLwy/HGuWF8r5ljQkKDqC7nEqoOahI9npWjx37bR7Ub3JLUbLKgnkVLY+oUnQYFAoWdvkBpQnNSCNvlNtCXQtmC2VB5YJSCaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 05:17:45 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 05:17:45 +0000
Message-ID: <c012177e-274e-4c88-bc32-1ec647fad643@amd.com>
Date: Tue, 25 Aug 2026 07:17:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <20260824163956.GH523975@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260824163956.GH523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c38e82-f914-40f7-0c17-08df0268322a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|18002099003|22082099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: UhJa279uZMbjI8YUw2Z/m5UtrsKweP9UwZcG+YpHR5zFPFB5P+8LVPGrrhITjQalfKMpgbCAuGISi5mDOibzBz6o1AIf9XyTX1yMgyQKpcs36mYOv5PtKPg4uqxjOeHkLceDSkItp+M5gPKgcGEFwWFQ76HhwQKG0oizMGDf14GtI1dLZSRbRcirw9roCwDFj/m9aEGDrGUzKscHL4S/DGIdyQsHEkAAOuyr9OrrOjgmkkqJFtkqRFYI9JrX4S/yaipp0JEwdWLgAd0st9Pj0HhDUjb5BoL7ZSmgmKoXUl+n0FfXAnqerIQ6TmJIjjO/L8Dgbp6D69E7U9ri0ydg3PWjNVOPEJBB8O4sFDh3zHZcyxpYlHtmNa+m/Gqge1VTwUyfHergEqPRqcODKXKus25iRFVbSuEZQXyFxevjP2W/lgvOA9Zf8nBDG25NBGerJmn2dWWPIaq/r8z0zSz8SWPz2166zG/U/4KLpCMaFTzK5gylttVCTyglgCZhte5Up5tLLlStQAw9/A9WORldBFniteKP/HP+SEP3/iXZ2pbVs0ylBcuPFQ9DPXbKr+578ACfBEIYWopq7aJ0JyhW0lFYiRs4cTGykh8AGpMuYv8uECuHIyG9dLqL/P8PCp2hbO2EzOupxyw1d3neDEMRmoEVbERsDbWLziJI37Bl/ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJQVTRzQUNxTndqeGFqblM1czBNWDZKdTFnNC8reUpEaTZnZzNPOHRKM29i?=
 =?utf-8?B?SHRudmJTaVRUYUtqQ0JjaDQ0eVN0eVc5UWQxVkpGcGpEbTY3WjBtWVo4eUt0?=
 =?utf-8?B?M1ovYlNEUlNHUTlCb2J4WENTUm5TQUEzZ05EbmZoYTdSTWpZSWpsQ0UyWlBU?=
 =?utf-8?B?ejZuQmhnUmc3bHdERkQyYW9vd3A3bVVWcGUwc3FhQVQ2YWRETVMvWE1tcXdz?=
 =?utf-8?B?elcxcXUzM0pYcCtZWTlmVUdlWEVudVRGZ29lZ0s3RkNzVGNldVVDUllSQVIr?=
 =?utf-8?B?VFN0ZkpGNEtoa3NuQ3JxcGxBeGJUM2c4ZGZGSmFRTUJDdWZtSGxaK1VxcFh3?=
 =?utf-8?B?MWxvR2xNaDZjWlYwaWJ0Y1pYQjIwamR3elRkR1FJNnZCQnZ4ZzNKWmxvOFRL?=
 =?utf-8?B?cE51OTZRSno3WDAyZ0x0aUlkL29XT3ZMazRvMGZhWjhqQ0FwY29tV2ZWR01a?=
 =?utf-8?B?T1lHV0pTdVdyYng4cFJBam9Id2hwL2hjUWNnUmUxNDA2Nml6akFjdGhEZHdM?=
 =?utf-8?B?YVhIeGZCa1VrRnQ5aEY1NnAyS0RnU3BqMWZjVSt6WVh5N3RINUJGZW81N0g3?=
 =?utf-8?B?c0dCemJFS2tlOHRlakEwSVp6K05yU2dGUnN3VlFsSDlIUmhnVGI2RTZiUXlS?=
 =?utf-8?B?ZVdnRCttblRyNktzUTV1bFljMGJ4cTZSVm1zYXFZYUVuYTNJYnFCWWo4dkV6?=
 =?utf-8?B?YXQ4NDZkd1A0akx5azNIWnJCSlZudVpxMHlQWjlzeDIvMHhDYlR6TXlsZWI0?=
 =?utf-8?B?a2R2aXNpMWhFTkRzMExvY3BQVkxsWjhaTkIwNXY3S3RXNXZwZXNWRE8rclFW?=
 =?utf-8?B?N0l2SmNESjZ2bDhjcmtnRTFCZ1U4QjN1SmE4eWc4UmRiKy9mZmZKaXhncTZW?=
 =?utf-8?B?bEVSVVR6RHBWRTlNaHAxTno5SEVhbEF3OG5CSkp6YzBMejdqRWpXY2RJaGs0?=
 =?utf-8?B?eFJOdkpHT3NGMnB5dXN1MGFWWGJUeXFSbmJweFJ0ajI4ZVpQMmVjQUdTUXBL?=
 =?utf-8?B?OVYzNVFyWHFkYmZYazRPYXNvZ3o0OFJmOWJHWjJFYmZpclZJK0thMGJiOE9M?=
 =?utf-8?B?QlJLSzBkeG40bVlrK0dXTngwTDJET0NLeWxMNlJhNmdnZ0ZGeHkrNUE1ZThK?=
 =?utf-8?B?MTBKWmhFbnYrbldDZ3gvQStVMk9lVnhPVXhIQTZXZkJxWlRYUkJlOE8vdzRC?=
 =?utf-8?B?VHlCLzhncHRkQ082SzZJQ3MzUzVWMUQrMmFkNWxTYlZlWDJRT0pDMnE5c09B?=
 =?utf-8?B?eGVkclBMdmU5eHFwSkt5bXcxOXdhVi9OSml2RUR2dXBZR1ZUNnVGR1hhU2kz?=
 =?utf-8?B?SXdHK294alczMkRlSlFpcjhhb21Qa0wybUR0M2NkZmFRcmR3K0N5QzhqZld5?=
 =?utf-8?B?cG91VFNrNG41Q1JEeUtrSlBCVCsxY2xzcUhVaTZaa3R4TlVJZnluNzBYZ1NC?=
 =?utf-8?B?RE1zNHRFUDZrcUVBSXFJOHVQTndlRnk0ZVdUMElUYUFCaWxvR000aE1ES0dZ?=
 =?utf-8?B?ZjdiNlRxMWNVaW8vUktiNlpaNHl6cW4waVZhZmV6aTRQbkJQOWhDNHU3U0FV?=
 =?utf-8?B?WUpxMXVRWGNsblhlb3JudnBaV3I4NkdJOXdDd2x1QmNBQkxDV1BvNlRrUmRU?=
 =?utf-8?B?UFZIeEgwUThkQmE2WWp3ekswRytZN0RZYkJPN00rd1duNUl6b0d2cGVvVGVE?=
 =?utf-8?B?aHpmQ2ZjU1BXNjU2WE9ZZ0I1S2N0eFNoMkVxSWxuU2JKR2JNZncvR1B6dlhG?=
 =?utf-8?B?b0hLcWpJVWE3ODlPK2ZnemhPVFhXY2lNenc1WjVmNkt6Rmp6Nmc0aGRoeEFz?=
 =?utf-8?B?Y3MvMlFHZzBaMGNBa0hyZzRFZFI1cmJBdmxTMkdXdGxkZDVja2htV3ZINjha?=
 =?utf-8?B?Y0NLMDlvWDZkbVgrVHhYbXhWRks0RytsMWpXMWRRdkoyOUxHNSsra28zcXJX?=
 =?utf-8?B?TW1iK1RLdG4zRzRiM3hmTFZ0dERaRTN0REZFYUFPY1gyTFBRUjl6aGZIRVVG?=
 =?utf-8?B?SFlLQ2pBLzV2cng2Y1R5UUU0NGpMbTZUMlNZaG5RbWx2QXZCdndid0NENC93?=
 =?utf-8?B?d1ZKa0h0d3BjVFowdWVRazA0bk5GQXoyUUhucWxnbTBVQ3I1c2FaMmlrR0Ur?=
 =?utf-8?B?SHBkWHhLN0RkVDk3ejZSaWxBWWUwOGNYcHhVUHBZS1diY1FQT0w2UE5KWEp4?=
 =?utf-8?B?b0pmMWs3S2pqL1drMllOTGhPZTNHSm0yRnM1L29sU0N6S1A0UHYzS2hkWWYy?=
 =?utf-8?B?eFFRNDhIZHVXclY0eHRYTk5WbWdOelJGbU82NlVBejN0UkpITjNJU0V3SWNZ?=
 =?utf-8?B?aGh1ZTFRUDZQZDlCZlR1Z3d0ZWFRYndEOEpvL3FPM0lGZEI5dlJSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c38e82-f914-40f7-0c17-08df0268322a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:17:45.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32oGYPIitMlGw8rP7H8swo5mSOCz4GU5uyrX6YBahb/ZqkeWic+aaOYZMbysGlG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/24/26 18:39, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:
> 
>> There are 5 domains which no longer exist. Remove all email addresses that
>> reference them. Where such an address was the board's only maintainer, mark
>> the board as Orphan.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> This is generally good idea, however:
>> diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-cx-a99.dts
>> index cf126bbd2c57..0642161ec969 100644
>> --- a/arch/arm/dts/sun9i-a80-cx-a99.dts
>> +++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
>> @@ -1,7 +1,7 @@
>>   /*
>>    * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
>>    *
>> - * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
>> + * Copyright (C) 2017 Rask Ingemann Lambertsen
>>    *
>>    * This file is dual-licensed: you can use it either under the terms
>>    * of the GPL or the X11 license, at your option. Note that this dual
> 
> I don't think we should be taking email addresses out of headers. This
> kind of information is useful in looking in to history and trying to
> track people down.

That's why I kept there name. Emails are saved in history anyway.
I don't think having emails in headers will help with anything. They don't work 
and they are not going to work.
It means if people ping that author and get nothing back it is IMHO just driving 
them in wrong direction with unreasonable delay and hope.

Thanks,
Michal



