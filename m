Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB888E95392
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 12:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2888C839D5;
	Wed,  4 Feb 2026 13:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gtiXRguy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3004083A3D; Wed,  4 Feb 2026 13:10:50 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F7283015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 13:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNpDMrrbLVCuNisqToASzKViRAxsS2tAvd5TsV7m0nrje7HBlgXLdGhj5mjHtmok/nLrPSRBg17QGo6OS0bA7PNnPqLeJWeV+ODfNSopmVEaVq84uO01HuLkajjxGEPRdWyatla3960EC6kx2JDpCJgJia2AO6iolKwuuYf0eiMTExVa7MkZtJOhnDI7VtVV2WreOcplilEb86G4Y1Yi0QB3fG43/7Rz58eo2GMbKWtFs4G5e5BIFkmXFyFhZubNDByWlCk4ftbidpX2dOwZRPUdOPbAEDHMzJ3d7gol+lAHnOgwbFXOlhHL74e8LKzgnDX/BfBWz+avJXF66WT2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnGazneVbccKnh0ReTb1gUQeCytXZFFO71XLhM8LRsg=;
 b=bjinDhTwa2/qLwRf68bT++L46PFjDrxwsM2+LBzduGuF7/Xp0EWNehjOlpUntEog1oDDjjWwAkti9JnEx0vfuwQ8uVCMlxMxaY8pKn8T4z8TF5xAKxAw2UtjT/o+rRo+xxEl2Zf9YlMCuMAZkTdSQQhL69+qTEz+KdNlCMm/bIzi/B9mzfV3uyB4fcy7PprKD4oTkPm2w9hU5zr13IMS1bLvamAsupAwDBvBKuLAToMkR4aQM5itpLMiYlp/P8ZD4/MFO7MQb8dDkSIAv6tEQXRt6w7MZvwJ64eYL4it7d2X4qJic18Wpayd91W47305h85EJXeX3atsxfcyodYzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnGazneVbccKnh0ReTb1gUQeCytXZFFO71XLhM8LRsg=;
 b=gtiXRguyF207+Uq81lsauv9DrUiECaMCOBClIJLaX0Qj1VbBf6ZGozvK6j2Q5yes/ATaAAlJNgJ3+onS6ErqCgQYuNBWVINdPfpCPN2tS6S7JnWzAYPbTFJZYS+diedljDe38eCJIO1yiHPwT9F98kt1GFyD1RqmOioLwGXsD7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 12:10:41 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 12:10:41 +0000
Message-ID: <33d377bc-06b5-4e77-a89d-aaff6f6a6d9a@amd.com>
Date: Wed, 4 Feb 2026 13:10:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com"
 <git@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
 <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
 <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <CAC_iWjJm2uBi33Xm36tZ7Z4j3dxBirOagsTJGuuiLKebF+LfQA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjJm2uBi33Xm36tZ7Z4j3dxBirOagsTJGuuiLKebF+LfQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::13) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 83be46a6-b045-4a6a-cd0f-08de63e66a92
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHhWVjZMUHJoZlZtZHNueUwzV3owcnRjQnZsbkpudk9UVDB6OU4xM3NiWG16?=
 =?utf-8?B?YzY3MzRjSjl2WHRHM3oyb256azBOeW1wd1o0VlovNEdEZ3p6TXVURFB0K3Qz?=
 =?utf-8?B?L2hmdjhXbm9kSjl4Y3VodEszVDhhVlFRdng3SHFtTlhmNHVpc3EvcUoreEt6?=
 =?utf-8?B?NTJudFBoTmFhdE42ZU1EdFU4RENsUGtnVzVkTnc4dUdHUlc5amlwWTlQdjB5?=
 =?utf-8?B?djdvUW9RRTFwdXA4ekl0TmNmMDhaSzJwNHJWNGhzVU8vSHlhWG9YSGlEN2o5?=
 =?utf-8?B?ZFY2T2VqTFNBalBjZk9tUHllTWU1ejdkQWxML2xJSGk0UnVuNmE0OGxsNWhF?=
 =?utf-8?B?Y3BVTm9HTVREOEQwK0EwMUc0V3dnYVV2RmVuZG8xTU5FMXFtZWdPRzdVVmZ0?=
 =?utf-8?B?VFVuTFZpeGFtek96RFRPMkxuQ3dBTVNVcXB0Tkt2S0I2dXZveG96U3VTcHpt?=
 =?utf-8?B?eTAyRklTM0VvdlF1QVRLZVVieWEzWkdQajJWRnlFZVIwbGk3dUY0V3JtbFNV?=
 =?utf-8?B?QmdMWGdieDFEU2FyejFyOUJHWUhqbWNEUTFUVFdSS2FnczFodWtVKzFEVkgy?=
 =?utf-8?B?clJ0U1hwR0MxTnZ5clJrOVpZTjMxbVN4eDh2VUN3aklJMmMvb3UrZzNPKy9G?=
 =?utf-8?B?NW9BaG9KL2ZuOW5GQURTZzVrNHIvVVBCRndPUFROajBoakYzUElYZVgwN2Fy?=
 =?utf-8?B?WnIvMVp2dEdOSkRWRitPd0hGV1ZqQmRYZUZrUGk2Yml2eU5rK25FMlhaekdt?=
 =?utf-8?B?WHJHSDltNUxBK3pSc2xRSzQrNkVjVGhHNXhNd2gxMGwvWVFzMW1KMVUxL3F1?=
 =?utf-8?B?SWVSRzNBbUtZUDZvRFhLWEo2Mjh0bUhINHpsM2M4TWtzOS9iYzJvazJTSnYw?=
 =?utf-8?B?RmdVZWpqZHUzNU5ZSnBzYVI3ZVMveEJFbm1yaVVET0xvem9mQ3ZMc2lJekxm?=
 =?utf-8?B?YWQ5akdUVy83Q3Q5Qm9FYjNESjN4dnhjclRpMzViNlpkOC9aUW92UWFMeVJY?=
 =?utf-8?B?dWZNVXhoeXJFbndKc1BROEhwN25iVEJnL2dHVkNVd1hSdEFnQktmUGlxQUhT?=
 =?utf-8?B?TkV0bU5LNmxlQ1pPVGtBNlhSZnF6MWlRd0c0UUZoVGVPVVJkVDE4OWhKQTJp?=
 =?utf-8?B?dnM5ck1qcEtjcVRqTkcybUlqaVllM3Fjd0kxZnlmY1ZJYkVCVCtPQzBGdE1t?=
 =?utf-8?B?dzFtN2RZN1F3NDI1OHdDZUpib2ZHK2NNUjF0aTVKL0VVMi8vbTk2Y1RuRWxn?=
 =?utf-8?B?ei9NRXZZdXhlc3A1ak9vNEYwcGpFTE1nM2xwcmxCS1lzeUZzOUpLemhLME04?=
 =?utf-8?B?YVZmbEhKaEh4S044N3dLY0xDc3Vkei9sNmN4cVFFT1cxak40U2VoYXhSeXQw?=
 =?utf-8?B?OWRiMXRsQjZpNTJsT3U1QkttbjY5ZmhUaGlLZURKL0dHZVdnZEJKbzlNNENi?=
 =?utf-8?B?b09rMUdFekxNTWNnRXN5MnNLNmtnZGRFKzYwSzdENHhzc2FhbHd6R0Ivd21r?=
 =?utf-8?B?c1JzdEZWdmhOSkkwRXp0TkRVVDNwQTUxR3lXa2ZCYmFRUHB4Qk1XM0MzMTVD?=
 =?utf-8?B?TmFMTzM1YVFkdTZKSUdQQ3paeHdXNFQ1cW95OWtVb2RPTFl2Z2JZclVkcXdQ?=
 =?utf-8?B?eVZZS1o1VVBKTFQyR0NpVW9QTi9FTndXOG42bHhXakpxQmNJbXpIWk9BZE50?=
 =?utf-8?B?WmpUd1hYMEVYMzVzMjJnb2FabUlBTzBZOGpxSE9Wakl0VkJvbVhlMUZ1ZUlU?=
 =?utf-8?B?YlJHM2U5ZHV3Vk1HOUJzbVVVZ0Y4VkxOU2ZDaGVUaWhYUEVxczcyd2dBc0Vp?=
 =?utf-8?B?Q2ZqaTBtMXg1V25XRXlwRDMrcE1pNkZlR0NiMVNHTXV3eHJqelUxTi94Vy9l?=
 =?utf-8?B?Um1XVElJU0EwTkQ4MHlMaEJlbGJOMjRQNm9wZXVWa2NrL0Z3WmxCVWxmVExX?=
 =?utf-8?B?dm00WWIrVUVPL1BhME1za1JxYVVYL28wVzh5aTFhelNLWEd5WC9oYVNsL2RN?=
 =?utf-8?B?eTdORXkyTWpWVUltUHFoQ21vaENJMzNWb1QwNk5XTUE1Y3MvQ3BIaW8rR3dL?=
 =?utf-8?B?VUtoeG43RkpwK0hDTGg2UlVORkl6U29YL0hvYWQ2dWVncWlqRkxtMmdNVDNa?=
 =?utf-8?Q?sljw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpISGNUTXowYWw2ZXVQM3gzcUl6OTRWUXdud0xLZkVtamlJdkwrZVpJaGRw?=
 =?utf-8?B?cmhPM1VwdjhCSlpNNEpuenJCOExISC92T1VKcXJyTTB2YThybnRRaXNNRDBU?=
 =?utf-8?B?MWpYejhFQ1k4Q3hkN3ZRWUJzcjZsSWsyVm5oZHlDenhxYTlvakVDRndMTjNl?=
 =?utf-8?B?dnp2akF4Uld1bm5kWFE0dVZUVnBFWnpnbXhTQ2YwZjg5ZE9pSzNLVTdyVEZP?=
 =?utf-8?B?dGpubmtnWDVqbE40NXRiQlRyMFFHWnNXR3ZEL0k1cURBMkpsd1pja3RqWGJ2?=
 =?utf-8?B?eXhuMHh0V3huWHFZTVFzaGk4bktjdEdmQWhOMHpZMmg3SWpxSWcrdi9GOGI4?=
 =?utf-8?B?Zm90bVFhRXV5THhpczJBb20vcVVwTVlBWHl4Zk00WFZLdTYrN0wrdTRmVFRL?=
 =?utf-8?B?aDhzZmZKTnR5bnhIdHJGYmh5SVRzeDMydVJZYnNCYllnVHNpaWNxZ0F0S0Fr?=
 =?utf-8?B?MDBlNVNzSmR3WDJPU1MrbTVyQk9JRFJqVXNKMDRQYW9qTWFHWFM3c00yUFk4?=
 =?utf-8?B?YmRXdU9jWHZyV3NqRjllNzF4Mkx3R3Zuc0FlWTYyejBWQk9ZamZxWE9lZC85?=
 =?utf-8?B?b0kvWkRyQ2ZZMGpNOWplTlVqbzlVRW9BdkJkY3I1ZGEyTHZrR0JhMm9yTW95?=
 =?utf-8?B?Nm5MdlpGZlJWTlFOTE5LenBOVlFlSUtkU3l5bXN5Z0xpeFJ0c3B2OXIrTk5S?=
 =?utf-8?B?Q1k4V2xwSUgvTjNDS29qaEN6emZnMGdSRld2NGRpUjVNNUQ0eWZJM3dhemEv?=
 =?utf-8?B?TGRqUTBJeU1MYmFqcWRxZlVzR21UVlVrZE0rMHlzeGcxdVFHdndnQ21LZ0JO?=
 =?utf-8?B?YjJzTzQ3Z1hxYUNpMEFka3ovaWYyYStWc0w2RDRGWVZXTUk0UDJ0NFlWdFBP?=
 =?utf-8?B?NWUzcVBhMUp0RVJoU2YrUGNyOUJXQnVjb3lLSjR1ZCtKbzR6cWVkaG1hbjNI?=
 =?utf-8?B?MjQyTUU4N2Frd3VuRU82SkVwd24zaGJjM2ZDdE1lMFBqOTN0VVJTejdKT2Fv?=
 =?utf-8?B?Sk9QTnlwa3I4RFA1RzdrUEZOSFpYYUYxRS9JNGFwUkJEOG4xK091SXk1d2Vx?=
 =?utf-8?B?SUlTWWRRUGMvUlBKQjV1cUg2dzRjNHJIYlVuampYT1gzc1dJNDhta1JvTHR4?=
 =?utf-8?B?TDlDNnQwZk1JamdyaG9LVzF6aUZZODR6ZUUrNmlycGZqZUxGTGVzWE0zWXhN?=
 =?utf-8?B?SkhYL0dLeTJmb1YwSWJjdHV5eTl1Q0YxRmVubGlEWHV0N0hLZkFoaUZpWWx2?=
 =?utf-8?B?aG9EbFZrYkJDcDB6TmRNazlPQUljMU41bUNoVEp1VFFTSnJlNTlDMDNlZXg0?=
 =?utf-8?B?aDJkT1gzTGMyM1labXpudGNpeEZSb3dQODFVSGhBRWxmZ2ExZjlHTnJrLys2?=
 =?utf-8?B?SW1HRXZOVVFxTHNhcFVLMlpCYThiR0kxeGIyNmpiQWJOMGNpeldBVSt1eXpj?=
 =?utf-8?B?aFBtVmYxdVF1UUtSajJHbG4zZ2g2UW1kUWFoRE1tNWlicmxDRC9EMENySjRF?=
 =?utf-8?B?bEx5RVJuR3pkaEFhT1ZpME1UYm4yZUROSXhxUm9NdG1WRkM1VEJybWFHdEYv?=
 =?utf-8?B?SlczUUF1Wm10TU94SnJlT1NkTFphUWE2N2ZEUnBvaTlFNklFWFN6Q3VjYnRY?=
 =?utf-8?B?SkpvTEdnVVFibWhxcXVpZmR2SmJHVWZkQ25kcXcyakozTS9LQkxLSWxRMkM3?=
 =?utf-8?B?d2N3bXJYMysrWldKMHJJaWJVSkt2QmZ3KzlBb3F5WW41YTRlaEFsOTFoSGlJ?=
 =?utf-8?B?VTJFaC9GUFBjZXdheVR4VWVwd1MvOHpVMXdtWEhmME1JVnI1WmtWbzJRb0RT?=
 =?utf-8?B?MmN1NnpMU1hvWUhMYUZyQmV3REFBZEFkUmp5NUVFTVhadFlRRi9zRUQ0K2hD?=
 =?utf-8?B?S2F3cjVUOSsrQ2dQZmhzRlVMKy9vU2ZZajcwazFydFQ2cW00ODUyVlRZVFNV?=
 =?utf-8?B?b1lCOXBMOWdObkhKUzYrNGlpZnBYS0RrcmsrTWZPUmtwTGhsT1dvRjVLN3JY?=
 =?utf-8?B?UGFkUHkxT1RSbjM4SFQvVkNxZE84cHFubHpBNEJrRE80VXdnQjVCU0lvNEFx?=
 =?utf-8?B?R2dVazNEaWVLODNGVnpRem1vdjRBbkNFTUpoMElPNmh4S08wMVg5dXdaYjBa?=
 =?utf-8?B?L3Z2WUJLdnowOGNNMUtYNkVpdjNlcmlvUk1TbGpiNS9EVHR3QzRQSi9nSjBi?=
 =?utf-8?B?ditEVUNGMUNlaTE1MjVad1FNRU92Vm55Mk5UT2dSd25LZ1pRd04xc0NEdHBE?=
 =?utf-8?B?Zi9pdlNqYThCTWkyNmlIcXJtb2VRaFJGaGljMHlIRWZILzFleXU3N3VNNW1j?=
 =?utf-8?B?cy9IWGE5SmQ1WlpyK2NLMnB2Z3owQVRMSllxUXN3Ym1iOHNhWnJvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be46a6-b045-4a6a-cd0f-08de63e66a92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 12:10:41.6076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/M6rkEGIxCc+1cDDOQ7PGx0hhZj5jpQLeSZRh06c2cIk0T7Hdx+FIIeIe6aKybZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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



On 2/4/26 13:07, Ilias Apalodimas wrote:
> On Tue, 3 Feb 2026 at 13:29, Maarten Brock <Maarten.Brock@sttls.nl> wrote:
>>
>>> -----Original Message-----
>>> From: Michal Simek <michal.simek@amd.com>
>>> Sent: Tuesday 3 February 2026 11:10
>>> To: Maarten Brock <Maarten.Brock@sttls.nl>; u-boot@lists.denx.de;
>>> git@amd.com
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
>>> <xypron.glpk@gmx.de>; Shantur Rathore <i@shantur.com>; Tom Rini
>>> <trini@konsulko.com>
>>> Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
>>>
>>> Hi,
>>>
>>> On 2/3/26 10:44, Maarten Brock wrote:
>>>> Hello Michal,
>>>>
>>>> Why are the new function names non-symmetrical?
>>>> efi_var_to_storage <-> efi_var_from ...
>>>
>>> Ilias was asking about these names in v5 review.
>>
>> I'm sure he meant something different from what you implemented.
>>
>>> I am ok with this with a small nit.
>>> Can we rename efi_var_read/write to efi_var_from/to_storage? I want to
>>> make it clealer what these functions are used for
>>>
>>> With the changes above
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> I think Ilias meant to use:
>> efi_var_from_storage & efi_var_to_storage
> 
> Yes , thanks for claryfying this

Take a look at v7.

M
