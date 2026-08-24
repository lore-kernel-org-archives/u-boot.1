Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED957C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 11:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA813405E6;
	Mon, 24 Aug 2026 11:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2H16Iq03mvMU; Mon, 24 Aug 2026 11:54:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787572480;
	bh=JrqdnN0y7AwzGqFde6ocbVJALhv/kMr18J7+TdvV5vU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0l/q9wtIimy7vtgX0SIq1KnHZCXt7fD/SQTpyu5JT0e+fgQ4h4PsL04gGc/o0aYFV
	 50YkmZu7z4CD/GgqidHMqzvuoeckQszVNWSJed1FmDDyVuy+IWN/tdH+s+OAb4wC5V
	 2JWfX335CDu945il6S5FCSnug9IrVNSpxuYNCPI5FTnM/SPigOCtLPpvvxyUEV7rd8
	 KMCM57XM5fR9BnnMtwowIAdwHKkHlmFj2Y5LBTO12dVjeg+aX8vWP0SLT0yIeB6svd
	 2Os/MxlnCxs0s7GlmumO/1MjjlhYr/B50mr9hmRPyHcx2igVWi7O7BSk3Svgj+4t78
	 uRnDJRFEoJl+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99024403E1;
	Mon, 24 Aug 2026 11:54:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 798F53DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AD488096E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZqYVa-ZNT0r for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 11:54:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qiUA527p
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFCA780944
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dluZGVcTWcuk0DM22gI0NG+pWLu6xK0Lct4R6O3IA+zaZ/rqV0lUUt8xUgdrp6uzrb3WsMyCMjbMHGv3fZlYV0kGeVeyR1NrBC7unPTi2CrA8Eg4FPe9NVOetf0+Ll5LrLljXWegn4kvCeTHSciRDA8i8tw5lOFiWHkwBBZXhoR9NNzCkeC4PY70z3pAyYUMiQRzbyyeAjm3GOVJaPOPwN2jZGBiDVJKVKtzpacpUZ7RPVPVqveUyJIijzyU7FVbpJ2WhzaX46dNv9cXz21rEk4brqyMmO28f1aUrwXnbjVAHwhoCC+2Ib1pyL2JkEuQYw02uT9ncztuTAhj9UECDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrqdnN0y7AwzGqFde6ocbVJALhv/kMr18J7+TdvV5vU=;
 b=oGoJqglOOAsNF508RSRJ7Tfz5uAvEt46rc5p1ClwgyXPaDbGE/fhcdjmrGrlnPNxdnInYGTYVJ+Pti8RmWv2L7QajE8iawSgHe5bnvvCLUvRnP+XR34g5XUYIywS2N9pAiL7zla7ILBhcLe4ydyDtwg3ic8fh7htaMMBCAEFYWWId/fMsNVoTk8/qruucUlEDKf/ZRo0XN9BfHkA+4bly2er+iTWugbnLyWQT8i0+9ryaecdyS0V3hfIjKC3cIbhDkKswUrmtpobocK37OE3gPeNzFq0BkIY0d5AXpvAHi79I490x+VACX/Ke/MBuCsX5qsI9cRkhVUCnigT6Zwh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrqdnN0y7AwzGqFde6ocbVJALhv/kMr18J7+TdvV5vU=;
 b=qiUA527pyyTZ4zetZChDvMfsSOKK54/JbSrR/NJFs3zjh/3xElkQDlvurMlMiSH98FKwKFqdJkOa9W4gi/Uoavy0+HTd3UVOLZ6JiwKMjVJYSkpBH9p7Z2OnSJICLHo7G6sOkDGRxRM0ppbCVfWpRyPuOHuaKbVbjskr7FZ8by8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 24 Aug
 2026 11:54:33 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:54:33 +0000
Message-ID: <35e472a2-7473-4c8a-9367-326c50f671f1@amd.com>
Date: Mon, 24 Aug 2026 13:54:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Angelo Dureghello <angelo@kernel-space.org>,
 u-boot@lists.u-boot-project.org, git@amd.com
Cc: Andre Przywara <andre.przywara@arm.com>,
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
 Tom Rini <trini@konsulko.com>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <f7c4c39c-f45b-4a02-922f-4d1474c14cc2@kernel-space.org>
 <14ce91df-4a4a-4b29-977e-d8a5837e8242@amd.com>
 <9d95447d-0786-4bf0-952d-15543a58ab38@kernel-space.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <9d95447d-0786-4bf0-952d-15543a58ab38@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:803:50::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f48976-d7a7-41bd-e5d7-08df01d67654
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|18002099003|11063799006|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Nmmxn+vRqt0nKO1EQG2Dt77uo64ute3PQ+lTIJ2MHIS70KnExCpoPhj8kLUkvDR2olL2XMqgljcNiL7o2Rd6F6eOwmB9qDFz3xZB9i+LH8u5Y6q9hs8+BYWS/QaHmzmTGf9msU+O2sGV4HsZe5w6p2HB1/Ogd5nmfYn2DQlJM6lWLpzIa9/4MSMIPbFK8UMp55ZMA/2DI5v/UTON24F3ADLS577PDKo+x/gxnwujGmsUy4FX+WnhvtQk9Ig5px4Wi2NtckaSSPeq+Xa2vOwo+/PatkQYiX3/1CyZ9QTg1mFzu4sS02NTx+eqY6xMkJ8ZIiQcZYMT1kKfsi66lWruSZdaygQKP8+mUz2x8MV++PjOjTg7MU+6xCNb5uuSPQWJWfLHFW86P2JPd4rw7jbwdo6qse1Uct5Sco69bi8ouYF7d8PTQyPzYqaMl4nNN4rE0tGi9RUWrHsXObdyp3djpewGZHV96U2AcYsGSt2Gwkxa4Bqs/61JrowazDdYzEDxEI808JQfIR1J5NvTJ4I9ffK6FIDBFnGDylCKp3g43RnegUOQ3vI6r3YxRFHEpJb1KEUg2qtphf6fnFQMI5Sk6AMYACXaMm9qH6Tu9SmGhMrfOXg2LqOJK9H5C2vjTu16kGRrY4P01m8bOtkgsFOk0R6OTDyh7YiBGuKTyjyEjbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZYMUw4azZpZ2pwUHRNM2lYb3QzNmlJNFpiWXJRcWlTeUVHTERWZE5jZmpE?=
 =?utf-8?B?bWN3L2VsZStoYk9FSmFwdlVRV0k0bUV6Z2NCUW5LaXVDUGNnNDQ3bnlTOGRo?=
 =?utf-8?B?MWpjcld1NmlsT09HbW84aWFyM2FoM2RRZURlVDZPM0FQWU9KS29jWXNMTW9i?=
 =?utf-8?B?ZDJDTWE1ZzVHQ00wMmxuMDlnZkg3YUI2RTJERGJXemdKQmlBQ3JRTXNZS1FI?=
 =?utf-8?B?VGJFZWdrQVJQaGtRV05GSkx1WHoydTNFRTB6Z2NWVXp0Uy9LQUwzWENNc3hq?=
 =?utf-8?B?K1h4WTk4emR6bUFrSVNuSXVpZXZpaTQ5YThGUHZRR2ViMjlJQ2x2OEtrVWYw?=
 =?utf-8?B?V0dMbXZmOENyWWNHRnk0NE5yQlBXUGtpV3J3bFQ4UHg1MkQzSTY1VkJRLyta?=
 =?utf-8?B?Y2l1SnRNZ0NyQTMrV1o2UlZDWG9abUFkRXA3MkFPbVFmUFBoNFBiMXM1dXEr?=
 =?utf-8?B?aWZoemorNnpQOUpReHRmNGRDcFljMHlOWmxSTUcxbmFaU0FPc1pyVGtvVnda?=
 =?utf-8?B?RCs1ZTJEQzRqMzRmQkF3R0xaRDhiaTFCM0k2bzBuVS90cWlXOHJEd0hVNVFp?=
 =?utf-8?B?ZVFDQjJyb0dXNVNKaXRVZklLMmk0cXFiTFdCTGhjcUlNWnY2ajdaR1F1MzJM?=
 =?utf-8?B?Um0vR3NUcXdabTJzcHljNWJCZVhOb2hIUnhQNThjSXpCYURJZWV4VmZzVnZa?=
 =?utf-8?B?UW85Wm5ucGJuVm1vMTRDenhxaGowNXhZeWJkWHNWZDYwWUZpbE5zMG1veEZT?=
 =?utf-8?B?SkVoTDZZdC9OODB3MVJDbTJZWkoxcUw1ZXVTZXU3NllVS05HWDBVL1RWODdJ?=
 =?utf-8?B?MDY1NlZ6MTBnUWxpamJBc0ZmcisxeXdtN3c2ejVIUzZsME5TWG1VSnBjZklF?=
 =?utf-8?B?bUloaDZYUS81ZFIrWVBlYWFzTjIyRUZVakhzbGF6TlBIYVJoVWlkanhXd3No?=
 =?utf-8?B?dG10QVZEOTJjODZrdzdqRFkvNVZnbnNlVjhIZ3ZlcndPWk85U3JqaHpaYmJz?=
 =?utf-8?B?Q0orS215VjZDUmtLbnhFNEx4aFVLY2R1eUxQL2huTndMTEROU2MwbVBqbUFM?=
 =?utf-8?B?aFJDUjl6UHdtZm1TK0J4TGd5eWEyRHdUc3l3NWRFbUY1cGVBdkhBSXl5cmda?=
 =?utf-8?B?VEpxV2lqbWxhRHowUk5ta2dIWkJnU2svY0JGdzZwdDNUWmd5K2ZOVkErSU1I?=
 =?utf-8?B?VG01Nm56YUw1QnIrNVYvMjJxdDFWUmxwbTNiM3oySmFCRnRRai85SUJsdFpW?=
 =?utf-8?B?ekVKRk5tNVdzb3JNTlFWQ2Rsdit0OXZ0WXdraUlhNlczNHFpb3kzNGN3cE12?=
 =?utf-8?B?U2t2MnROUmpYSzc3R3lSbEFYZk1MVEJoK280TmVpaGhremRseHVMdUVYQzgx?=
 =?utf-8?B?VXhzVmovY2lMMHVhMnFGMFdMdVF5RXd4WnNtaXdHa0NEWkJrNWtNUVAzWk5S?=
 =?utf-8?B?WGF2ellJWEJHSjNTdys1MG1YUkZJTVh6WWFSTGhFWDczN24zVE1tZXExY2Iv?=
 =?utf-8?B?Nk01UE5CNjhpVytNbFF5ajZuejlsRmtlQXdPZ1FBTEovVzM4bnRLWERBQTdj?=
 =?utf-8?B?NndzbWFMWTFtNUdENnkzaFdnNWt1Z0hMR3NiakRTVVR2dDJLS0FCTjZLdTBM?=
 =?utf-8?B?SVl4TGd0RjQ1VHVLQWhGTXhGVlVETDRpeCtIMktFZ2cxc2NyUVFsZVpZOWti?=
 =?utf-8?B?U3BJUzMwd0t0WEt3dEpNdE9ZbzM4L21CRzhpQy9Xd0pLMVpheGo0b2JwZWZl?=
 =?utf-8?B?eUppMU9yMTZiZ1lUbENHWmh5b1g1TFcyVldvbU95NUJGU1RlSm8yVlgrM1pG?=
 =?utf-8?B?RERMcmxvdEpPenNDL0dhU3NhOE5kR0xwVTJiQjhUaVBiaG8vMTAwNHVQS09h?=
 =?utf-8?B?L3Iybk5JZnpYMGhkdlcvR2xkVERtUXdCVkFHektjb2M2M1lwbXAyTVg4YlB6?=
 =?utf-8?B?UGo4UHpUTnJxaWdLcmFGYU04cFpLWGg0NDFnYWlMV1ZvVHZaRUd3cW1iUTd2?=
 =?utf-8?B?d0N3cTZGbFFKckxtdmlKL0RKT2NhSExPS0RKRGdRcng1THFoUFZDQWhLam5w?=
 =?utf-8?B?eVFkbnJjMHdmNmxFVWZGcUFqYzJiMVFiSDlVMGRhYzhsNlBVWVZwNWxoK3VK?=
 =?utf-8?B?MzU5STJJQ1hvY2FUemJuSWhsVWl0UWZzU2RHOWRFRDR5d2pYazhuZU53ZWs4?=
 =?utf-8?B?bnNsdDRvUTVGYXJ1VDYzS3U5RlNVa0JhbVl0QWY3NmdhOFFoSjl2ZnBHWUlk?=
 =?utf-8?B?SGRsVnY1Y2c5d2twTW8yQUNRRDhvVTBhM1A5NzliNkVSUmxiYUFXSnRGRzgy?=
 =?utf-8?B?OE9lWS9nQis4UzE2L0xWM3BMeDFwai9CUTk5bHFLbi91Q04vR0ZTQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f48976-d7a7-41bd-e5d7-08df01d67654
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:54:33.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkLFi734H0oqcSebIcyRMNtkkRRgbUJHiJsZSeSdTsQaCQRzdqjc7i9vBGq6c/f5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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



On 8/24/26 13:34, Angelo Dureghello wrote:
> Hi Michal,
> 
> On 8/24/26 13:16, Michal Simek wrote:
>>
>>
>> On 8/24/26 13:10, Angelo Dureghello wrote:
>>> Hi Michal,
>>>
>>> thanks a lot, i should do it for m68k.
>>>
>>> Acked-by: Angelo Dureghello <angelo@kernel-space.org>
>>
>> Good that you acked it but don't you want just fix your email address?
>> Or all of that files/boards are obsolete and pretty much should be removed?
>>
> 
> at least "sysam" boards, they are not obsolete, working actually on stmark2.
> There are some quite old NXP dev boards that i am still trying to maintain,
> still on market or used market.
> 
> My company name changed some years ago, and i forgot to update all the files.
> 
> Yes, new email "angelo@kernel-space.org" may be better, likely mandatory for
> board MAINTAINERS case.
> 
> Let me know how to proceed, should i send a patchset for all "sysam.it" references,
> and you remove your changes ? Or i can fix this later on.

Just use current upstream next branch and send your patch on the top of it (and 
ignore my patch). I will keep track of these patches and will rebase them on the 
top of it.

Thanks,
Michal

