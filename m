Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262CCC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E8A8219C;
	Fri, 25 Apr 2025 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="kcZDsCvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB348059A; Fri, 25 Apr 2025 09:39:03 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02olkn20803.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2e07::803])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17BD8059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 09:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maud_spierings@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUOCmg3eVcnBqXhrBC9/7XLhFng3WbUdtgIwHcXS3MWsvGE39wzA1Vki87b4Nmam0y/ysegWofZAjLPuUyQ+fLC+vvgAC6mO9wHijK8UCiEvTWUM6yMI9li2EOgShWxZ4D89HDJ16qdvUofhN8BjbMHI8PZgaM+t5PfmICVMec+IrdTeigRxvdFW+8UAVnHuqSfe471XNGCtbq57G9tqJf107UZfQMYTWFCZmVOiGN+mDEzQV+7G4YRN+ztWqQ5qlp9SpF1fUTcnqmyMq9Axizabk4D79UbgiI+T7MMUVwt3gmu+C+mdaRMoL5UtDaycqlSdLtNk1wzUrIuDvg7LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrP/OsEogb/GkAE6vD50Uhcqo8h/wn+Qm0pSrB6pU7I=;
 b=B9eW1iZIyQdNgYm+gFS/JdCktAJjwcgLqyAsPzTsPhAyiChPTtdghmXbZ/DMlMKvyfHgfqFOiMbx+JBTGL4wbWfwg+QychPvmvYZMxx3rC938NsuyjyY8Dvw5hst6vlUER7P2tNak3W9aAY5irXvdoouU5zw8yHa0rvv90d/0WCkdfgn1UcCz+muQB2ZMFaoSHFWxDqcRE9FwAN8Rh1r5DUz6MGGfEA6V2exkJ0LrWDkO9+hrQEcbmhSNnK5RMwK8q6o2ByV1WuD9XoNKG1oviSLso3XAyWupViox1uFOiXdwqCL1a6HKq2kAzaYL88Aie1CNPteeypErRh8lHIDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrP/OsEogb/GkAE6vD50Uhcqo8h/wn+Qm0pSrB6pU7I=;
 b=kcZDsCvOlaxVwpUZ9c1OLIaeJWH+h/XZKXkGTmZf4sSCKJD666wC/m0RmtmBttkLdcB+UFdJrka2hjWgDG0Q/QHpwzoGS+tjSf7QSurkcvw04b+AEO0E/M1P+eqe/DzOFgAlRz9Ne13AouTA3EEjwJ9DpzDjoSkHA3LucPZCDEc+0T3LkYV9WszAIpAJyKW0w7VodNJpRQBy01YndHMzerOJj0MJ/PReNuy60QHg8NSCqqT41M8lPrTcuGpah3ABu+YTpcAnduTFRU2PVHKsqVYx/iS9SDmP1ReO3N4zkC+TJfNgHSjPe6y8MxM8FUipkRWdqJy/iWgr5gtWr4zZXw==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by PR3P189MB1146.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:38:59 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:38:59 +0000
Message-ID: <AM7P189MB1009AB369E6C8918ECE69FFBE3842@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Fri, 25 Apr 2025 09:38:58 +0200
User-Agent: Mozilla Thunderbird
To: e@freeshell.de
Cc: dmoo_dv@protonmail.com, hal.feng@starfivetech.com,
 heinrich.schuchardt@canonical.com, mbrugger@suse.com,
 minda.chen@starfivetech.com, patrice.chotard@foss.st.com,
 rick@andestech.com, schwab@suse.de, sjg@chromium.org, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, ycliang@andestech.com
References: <e5e68920-cfa4-48f0-ba3a-301cf30c5eef@freeshell.de>
Subject: Re: [PATCH v4 5/8] doc: add DeepComputing FML13V01 documentation
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <e5e68920-cfa4-48f0-ba3a-301cf30c5eef@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:205::16)
 To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID: <0375ab24-d4c0-4721-b507-751e853a61fe@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|PR3P189MB1146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e417d87-1144-4db2-fe90-08dd83cc3dcd
X-MS-Exchange-SLBlob-MailProps: iS5pQZgsAQA0FA2wMw7ykrjEzak0iSdAYSP4pqwewWq92Kj/RksfzDVPNW/+Kuvtd1kSLxehPVnvsi+q2bpW0Q8CkBGUiD3m+N/LXlLU7o3eRxYAuhyCOEJtdr96E/zHi766drwzs+gEUUiFYaKoFEeiJEdpNJqaMK6YbkEIi/EdFDCJtV5qCqsxwpg+d8iibw1iNL+0bsGaLjqFoT+kS0BrAfDrt1NlC2xOjtN0GC/f4XDAnKsZaw/Zo81c6MQhJDpRvFM3stUhucJC1HJEXeHoxaFmRpAVvSO3516pomoZuGPqdi/vBBRKt6LWzOL7OiIKEMk2fIvN/71Riqxx/TPwc4UdGadTsPP+RmTD0DGYyly+W7ungwmsQa+uI0XUcXlTWWp0+Ychmv0UEX2kTjKPYfpf8419cTD1k0b3gsVMp3qyy+nZe4nSEQaOX7geEylyAR5pu2fVgELH22bXkytI5tPaw+UcKl4nDxHwM9ggAGng8IyL/hI88fQfWg5xDoecHbdlFPUHY0IVWf+3NSxiXx5ILlJG3bQQQjpehsPCuSuap48WqlDxS+aVVg+uRKP5v9q6qt2fHPsl+YK5WyfCW0w1pCJC3RvL+zGI/HWFX2Di/Bl2Qoz7Ni0g/kbhNeAEIy64cc8EKMvvA0hDANlxmy4ql+LbZxYMQj6hENXWLkzUfuo1pHQsJvMF0JNV/jWo7cBO2K+D9r0iJlnF52r/gJVyWv7UgJ1r97UJ4nwXUNYBc8NsLnBPwbd2CZ68XmyTZzqi3YrTAqczxcHAM67lNGVo73tOIuXVR3VZfgMpn7N4lOZxxfOmu/9E93gW
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|6090799003|10035399004|440099028|3412199025|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1VsNk0wemR5UGhRSU5TY015eXJBaVF0RXR6K2EvWTR3cnlDYzFaSDQvWXlw?=
 =?utf-8?B?KytFT1R4UWhFK1AzY2doWHBiNVh0UCs0bGttZmxSUzQ2K3d4dE0ydzJKMjF1?=
 =?utf-8?B?MHdvbzMwMzNoK24zODNOdkRzMTJ0eWZ1MnpoMU9TWkptdXU3c085WHVOTFhk?=
 =?utf-8?B?MUpvM1F3YjJGWkZYNjdpMlc2elp5N1JUeE1mVFh6QjJlbktmblQyNHRjdjZr?=
 =?utf-8?B?RlhQbTJsQ3JkcDVlT1UyZitUSitmQTVvcW1zTktrd3duZWNhMnZwU0JBZHBa?=
 =?utf-8?B?R2dYZm1kdk93R2hNTjVDYmNhQ0d5dkFEdVR5cW5Ca3QxZ3pVb1YzMjVpaFg0?=
 =?utf-8?B?eXhMUG5RbWxxNXJhUEtoRTJFRXZLdC9wZlg4WklZWHFyRU9ENW9RZVRQNEI0?=
 =?utf-8?B?bU5RNGlINktnSDJxOWtmUitwM28rRjVNdG91NDF5eE0ydCt2YWJ0QTlhMkxG?=
 =?utf-8?B?ejJkSEprTmE1K2dqcGREdGRqalh6eW9uSURQbGNWY0Y1d3ZLMHBZanpuSHB4?=
 =?utf-8?B?N2ltK3I1eGEzb3hvUk5LeWUxYWVTVzR4d3FaMkF3S3BhT05CQU1pdEY1aTE5?=
 =?utf-8?B?OXUxS2tkQWVBWVl1ZExiQUsxcVh6eXF1SWJlbkxzclJVUE0yUmliZzhYenNH?=
 =?utf-8?B?RGZTU3YwRkFEQjF1dDdDeThKb0dkemhTZjkvS25WL0hEdnlNWmx1UE12VEEz?=
 =?utf-8?B?UDVMbzl1cnZwRVVMZHZOUHN2akNMOW1HZkg2OFo1NFFtSXlpK1ExNC9EMGJz?=
 =?utf-8?B?c0oxaWpRV0FqT3FEL3JWd3l5dVlEdyt1VG9rUmtiM1dubFZPUy9SbHJHclow?=
 =?utf-8?B?SVBQTGVrVEtrVm5JaGxUenc1bDdNdkpBNGYvczBSM05VYkljelRjMGhjdlZN?=
 =?utf-8?B?VmFwcEdueWFMV0NCbmYrS2gyQ080ZTVYQVNNV3NubU9ib0d0YXdSNTAzelZi?=
 =?utf-8?B?MzdnZFBYUXMvYTNZSmVBZ29pK2JFZUZOWEhGWEVEelFyRUtVUndiNnVGT05Q?=
 =?utf-8?B?UmhzcmdTeERqMnpQZGZLcXRvbmpJZzh4ZGR5TTlBYVVaYTh2YXg5azZvRHNF?=
 =?utf-8?B?TWhQWE1rM0RGWXpLWDJIU3JXU3AzUVZzbG1GcWIrdjQzS1dmR1RsZC9VOERB?=
 =?utf-8?B?TmJTRkJGd1BZclkxNWxiVnY4NDI0R0hoV1UrREVTZnc0SkZmT2c1MTZCSXFX?=
 =?utf-8?B?OXZ5dVUxRnl1K0NFZW51ci8vZHdsMEp6dmw1akdwZDdtRmtMTDRkRnRlNmJs?=
 =?utf-8?B?bUw1NmxCOGlsL3hQOW14ZGRnbjZjd0dmWVk0Nk5MVXEvOXpRcFlpQjF6Q09u?=
 =?utf-8?B?K3FJQkdkOFhGNXpESlhaOGtSTjl5STRsRU4zR2YydTJzcitzTnlmOWw1ODRP?=
 =?utf-8?B?SEJqMmFjeFdacXZRK3oxUENtNGt5R1ZnZ0ZpUGxFK2l5aFphVXpybTFYQ3Bj?=
 =?utf-8?B?ZzNQQyt6bXE4am9wMEZwSVNEN291aTlQalJtNUM3YWl3dTVQVFpQRWZnaDFq?=
 =?utf-8?B?S1NadG00a2sxLzhJamgzSG1qT3N6TjBnWER6eEplbWtkNXg4U2hJemdhVXh0?=
 =?utf-8?B?UklnZ0JFNkRkYTV2eForS3hobEthQnUzY1lMd1gySnY0OWFkK1E2RTdJUFNU?=
 =?utf-8?Q?fjyx2bdGu16Wb7Qy+Vie6EZwgknmB90wGAD9NGPdh8SY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGw4Tm4zQUoycnl2MnNkd0ZmanpYYjRvL01jbXVEVDJOMVVndVRrUGRwcU55?=
 =?utf-8?B?WTIwNUkwclk0YmNTcW03ZWVPMUI1Y01BMnpsUjc3MzczRnE3WmhwNnR3YlBK?=
 =?utf-8?B?Q0p2Tmg4czlXY2tZVWU2aWs1bm9QMGlNa0RmRlBWSCtLZEVUc2RZRERjVDhy?=
 =?utf-8?B?ZkZkS1Q3TnZ4VmZBQ1hWNGp4YWEzNGJlS2hJQXZrcFIxcGk1L2RPTjJnUzhw?=
 =?utf-8?B?Z0ZQdXlReHU0SityMmY0MXpoNU02dVNyL3NVVW9XMDNQTXE5RXRIclROd0hx?=
 =?utf-8?B?a0tTd3E2dVR5aXlZOWVabWpTRDJtZkF0cUhTMW56anpTMlZ1YURzSWttbmFt?=
 =?utf-8?B?YnZWWDErdHhSUVVIK1lCc2xWRE5FcnovaGRJbmVqOUQ2ejB4Mlh6UHhMZTVR?=
 =?utf-8?B?Y2ZuWTQzdjNlSHFpS3BISVNBNXRvTC9aV1gxUGJVRDZCMHNLZDJPdFBtbUIr?=
 =?utf-8?B?K080NlpXMVV3Z2Z0SzFDbUU4ZWtNbXdtZ3RoRWxNbFJKcWxIRDhoLzR1WXA2?=
 =?utf-8?B?M3FMQ00rTWhVR3ozVGt1Nk9EZGU0eittMERpRVRUVGJ5N09uWkFoUFIxc0tO?=
 =?utf-8?B?UmtsdTZCQ3pJUHNwaUZ4VkpFUlR3VUJGM3h3OWhtRjExcS9OVmpoQ0Z4MUta?=
 =?utf-8?B?VXEwQXF6RDNOTmpEWGQyNnluamRTVlJ1ZXMxZXhTMmFRV2hIdGViUHNDTXlu?=
 =?utf-8?B?bkZCYzArYnNEV1JFYVFLTW9zdjZ1Z29IYnFteVJzSHo2WWdLNzhzOU9Da1dM?=
 =?utf-8?B?MjdOcWx2d3lNa0hCNmdLZ2ptSUpRanVWanJqNG5LYkFCbTdsanVrMDE4dDVw?=
 =?utf-8?B?NC9RWTBhejdDaUt0RUJRNjRTUXBvOFo5QkVGaDhWMDJBSllFQ1hGczlGbXhS?=
 =?utf-8?B?Q2JubVorTCs5WXczTmJmNUsrc1VvYnJ6UXFGYnFtcGZnWU9aSzI3d2NQWlR5?=
 =?utf-8?B?cmxPTUVHRWI3MjkyM3FhWlU0SEdIZk4xeEtEL2pya1djZzkxRVk2cUM4b05j?=
 =?utf-8?B?L3dPMUZTSkFHbFRDNVFMRU9YRkZkcGFLZzlncjlvTWNZWEtwcjVvemNsZTcv?=
 =?utf-8?B?c28vQ3BKSnpWNzVETHlpOWFBdStvSEV3eitoYytxdEd3RUcwZ2dpblJZd0cx?=
 =?utf-8?B?VXFDNXJKcldia3ZlQTJmemlnazMvdnRheXg0UGlkZ0ZPajRoMllabVViV2o2?=
 =?utf-8?B?TXc0OUhoNm5lQXBGMHRTc0x2eDFtVSs5RVhGSGlYbTBJZTZFZHdZeWppbnZX?=
 =?utf-8?B?NXFBYXVVcXBOY0h5WTBpTEQxZlg2eDlXV0l5WEc0STZncVRkcmJFQkJUWm1z?=
 =?utf-8?B?OXg4ZE9Ed0Zvb1Q5d3l4TlFTVVlzOE1HTnRSOFVzUUozTis4eklhOFYyOWs4?=
 =?utf-8?B?YUdBMDZBU2JkbWtnaDZObklWc3MzNStrbFJsM1pXTUZXYTh0MktMYjVzUS9l?=
 =?utf-8?B?Nzg5a3FuWkplL1ZIZUh1ZjJwM2ViZW1makNkMXRJZVJUZUdEYm1WWWMxR3NL?=
 =?utf-8?B?eGhjY1AzdTRvNVQzUDcyWXNDVXZFRko2c05vRUYyWjliTFo2QkdxbEU4Qnl0?=
 =?utf-8?B?VWQreW9Ma3p4cWpCM1FuZUx3VTZyQzV4Z05GVmxJWTdBWVVPdFA4SExOWnUx?=
 =?utf-8?B?NWsrSVRNUGF3RjBwUjZZR0dzWnlhKzRqSUpqNERodC85OHhySjdTaG5kYjBV?=
 =?utf-8?B?VlArcXBqaFBpK3dUMHB5OWFadEdqWWliQmFpQ1VjR2N6WHVMcWtPYWJ5Q0hG?=
 =?utf-8?Q?UgwGrw8OUsB8MC1+Y6Sj0avjy2YAmoic13vQHak?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e417d87-1144-4db2-fe90-08dd83cc3dcd
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:38:59.3863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1146
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
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

On 4/24/25 13:26, E Shattow wrote:
> Overall I think this patch is acceptable as-is and I'll be willing to
> make a later series with my suggestions; it's documentation so it is
> never really completed, I think, and I spend an hour or two editing then
> decide that what I want to do is its own other series. None of the what
> I'd like to suggest here should delay a PR for this series.
> 
> On 4/24/25 05:13, Heinrich Schuchardt wrote:
>> Describe building U-Boot for the board and booting.
>> 
>> Carve out common information for JH7110 boards into an include.
>> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---

[...]

>> +Booting from SD-Card
>> +--------------------
>> +
>> +The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
>> +to choose any partition number.
>> +
>> +With the default configuration U-Boot SPL loads the U-Boot FIT image
>> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> +When formatting it is recommended to use GUID
>> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> +
>> +Booting from eMMC
>> +-----------------
>> +
>> +The device boot ROM tries to load U-Boot SPL (u-boot-spl.bin.normal.out) from
>> +sector 0 of the eMMC's main hardware partition. But this conflicts with GPT
>> +partitioning. Fortunately eMMC can alternatively load U-Boot SPL from a backup
>> +position.
>> +
>> +For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048 (position
>> +0x100000) write the following bytes to the eMMC device after GPT partitioning:
>> +
>> +======= ========================
>> +Address Bytes
>> +======= ========================
>> +0x0000  40 02 00 00  00 00 10 00
>> +0x0290  40 02 00 00  00 00 10 00
>> +======= ========================
>> +
>> +With the default configuration U-Boot SPL loads the U-Boot FIT image
>> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> +When formatting it is recommended to use GUID
>> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> +
>> +Booting from UART
>> +-----------------
>> +
>> +The boot ROM supports the X-modem protocol to upload
>> +spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
>> +u-boot.itb via the Y-modem protocol.
>> +
>> +Due to restrictions of the boot ROM not all X-modem implementations are
>> +compatible. The package tio (https://github.com/tio/tio) has been found to be
>> +usable.
> 
> JH7110 Boot User Guide says "Since document release 1.2, boot from SD
> Card or eMMC is no longer recommended. But to maintain the code
> structure, the following SD/eMMC boot address allocations are modified
> as "reserved". Be aware of this change when designing your device based
> on JH7110." [1]
> 
> 1:https://doc-en.rvspace.org/VisionFive2/Developer_Guide/JH7110_Boot_UG.pdf
> 
> So this is important we preserve documentation how SD-card and eMMC Boot
> source modes can be prepared that are since dropped from official
> documentation. Yet on my patch for bootph-pre-ram device-tree hints to
> LKML there is Hal (StarFive) and some other people that want this
> functionality of SD-card and eMMC boot to remain working in U-Boot even
> though it's recommended against and dropped from official StarFive
> documentation.

Can confirm that I would like this functionality to stay, as I've used 
it a couple of times already on the fml13v01 board specifically to test 
firmware before flashing it to spi flash.

I believe it is actually the default boot mode selected by deepcomputing 
on new boards, but don't quote me on that.

I have only confirmed the sd card to work though, since my eMMC is my 
main drive and is already full of efi/bootfs/rootfs.

I should try that uart booting at some point, I already use tio. Would 
love to see a more detailed how to on it. I guess set to uart, then 
ctrl+t x and then just send the spl, then ctrl+t x to send the FIT?

Kind regards,
Maud

> I don't know, which is it? This appears to be an academic exercise to
> make those deprecated boot modes working. It certainly belongs in
> jh7110_common.rst as something interesting the hardware may be capable
> of, but not as the recommended standard operating procedure.
> 
> @ Hal can you describe what the JH7110 boot code is doing for SD-card
> and eMMC Boot modes? What magic numbers and logic is this process? If
> you want these boot modes to be functional then please help with the
> documentation here that is now deleted from StarFive officially.
> 
> With that,
> 
> Reviewed-by: E Shattow <e@freeshell.de>
