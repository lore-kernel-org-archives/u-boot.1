Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D7CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 13:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C05080B9B;
	Mon, 15 Sep 2025 15:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="JWs5hWvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D532582C84; Mon, 15 Sep 2025 15:41:53 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F0180422
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 15:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsKEP9CZrQ0+x4Zwq+Syv+jteawzYJhQBZzLdOaTjx4dNlpWd0ewEBoudh89boVKo2rQp7bqQzF5W8+nBToWRMsfYF8AWH38o6D3ts1P5jHCN3rpq/IBNXk4v5aMe8hv8kGJAvw00qTymRegdV4TuXFDkZRxpW6gx5oM1Dxe35xR30ewGAL+xf8fwdsJaDlNk9xoIERZz9fergAFwbb+oEtPLFZvoknPH9yIa/qE1moN3YLskkbpCDKmx83/8p/sME6RqtCTzfmz7zInFlaFzVPdjXfskuVZUa2L/9vSnI1UPKwv/AVn4BKetH4DBnYBKxMKlINXK7sEGQAv0YOSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKY9xEitH1M0honN9l83fZDOMvgGW/LwbMjiPuVoMFg=;
 b=d7gIKJc1MEBAscbVCQRIvnStN8+NySDyq1yAmWMBCB7toNnvTO4zhKa3CfBSF0+xNWT8jetJ7vKdnbh8RyVnuyFvjvl8sdh/IakzhHxijmrpxS9cKz7B7jJfyOzfvhodQBdB1fvhbTH3g1QsXLkgotU6Lp5Ahq5XlGc43JtdiIva+NP2PoMm4OLFFNLVlXs6ED/xzk1u1sL8hnL3ufZBlm4Wcei2O4eic4P4q9PL0zMNocDtdpoDliNN2LXJ9rlepOcf6bR6e9Igr+WDUVvTTHtt7wf4f2zP2UnkHeYyiGTNgfAAC5sQEVupSTe1KAqNxpGYN3H5EolJ9FzUyK/Ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKY9xEitH1M0honN9l83fZDOMvgGW/LwbMjiPuVoMFg=;
 b=JWs5hWvZKZDhXrPsOW8n1LReG1TTt6yuxHnIZxDT+UQEeynptdcwEWUOVuFzdETwR+JpiUqN6D+DsUs8elGz/QgVFzqSjtjmME2U4hUHm6r6QhjqGIANvUHmWy8qoCvDdeksfycmq4Q7qp2vsB/NC54D9PDSu4+qBjTp8E4i8nGvmTGLXAPGM3dD4GjRV0bSJWpDDqaUspW3UdzFwzqt9q98RxhDNY2NyVqRh2JXmWVAa7Ytsi7HgnbthW/vYSGYNT4zhCMAKIePR1rKUJXr0gWiR927p958LDAnmNSWRmieOuS5fc4CZPdYgac98HVXA9k614dWjJ/b+WhRqzZ6UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by AS2PR10MB7084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:41:50 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:41:50 +0000
Message-ID: <13ba48f3-155c-4329-8bd9-fc548c6ea53c@siemens.com>
Date: Mon, 15 Sep 2025 15:41:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib: optee: Add line ending to debug() outputs
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|AS2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef9bacc-5673-424a-01da-08ddf45d9f12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxRQXlaWmc4NGU0TDM2U3MzejRraDFrS2p3bFhHdTNCUUF5NlE1TFl1Zzhr?=
 =?utf-8?B?alFKQUgxQ2I4S3dXSytxWGRnU2lhM1JZWTFVcStUZXZrdEhFK3AxaEVhNThm?=
 =?utf-8?B?SFRoV3RURmtjTzdtNUtFNVY5OCtrUk85dkVwU2Noa2JPUEFhSnNqMlRSSHha?=
 =?utf-8?B?a2RxV0E1ZVk3QXdidmR5NEM2K3JZUmtpNzNTWGg4VHgwenVQVlArSHc1M0JW?=
 =?utf-8?B?OTlEZ0ZIUW5HYmF0blBmbVZLVWJ1VFdPdVE3QXRHK1ViWDBwOVRGN3JoZWhN?=
 =?utf-8?B?RTBwcXJ2ZW1MOE5VRTloanVWOUVSVFljUktCYjBzUWEvTTNzSkdXb1ZVMkVz?=
 =?utf-8?B?c2owcEJqNG1yeERIa2JsQ1F0VWV3OTVBL2pSVlNTZ2xTRk1zNkpTVkZwWjBr?=
 =?utf-8?B?SjdvcTNDNTBaTXk4Q3pUeWc5NzFwaFIwdUFYVy9wajFlVXJVYWtuMHRqL29z?=
 =?utf-8?B?Q1kvQnlXNW9YSmYrLzFYZ2xVOXZ2bHZZMEhYMVd1VHJUd001aUovU0IyM1Rt?=
 =?utf-8?B?WUZvOHkwSHZtbU1QLzNrRzlHNnNHeC9MeVNZOVpCS1FtN3VBME45M3JQOHhG?=
 =?utf-8?B?ZUFOU1Ewd0I4dEVBSkprWWVsNUJKOXlrdHFPMTdJZWMrdWduaEgrVTY2cWdw?=
 =?utf-8?B?VG9IK2NXRGdQSnBPbnM5ZUpDc0F3ZzRsU3E0eXgrYkJNYmo3aTlSc2NRWkc3?=
 =?utf-8?B?YVBEZGtIdzJWbnA5YTUyWGlLaExhVk9BWE5YWnJ2aHVlZ3BIQThkT3psVUhJ?=
 =?utf-8?B?VUxwZ3pMMHlnc3dNWlFEY3ZVWHpXd1o0MmZ3NG5qcUI1YTF2TFg2WWtOUXZk?=
 =?utf-8?B?Sk42TmF0dnFtT1hmbm5tN3IwY3JPL0tmczcrUTJwQTlZMUhTanBlVXE0dnQ5?=
 =?utf-8?B?UmdzQ3U2a2FWSEZyK1NSKzdtMVJmUk1nRStjbnNNeWVrZUtQMnYwYXl0dDlp?=
 =?utf-8?B?TSsxV3VPREc2K1JBUVpsRFJkMU0vSDBkTG5UdFZqTDlDSDJuTTlqQ001U0Rp?=
 =?utf-8?B?UytTM2RjMWxxd2RyYmd4VmdmalRNaXBBbjVZaThyMmtlVkxvSnp3TExrdDNu?=
 =?utf-8?B?R0I5T2diWGtVeEs3enF0dytFMmU0d1AxTnoxUzlXK3Nhb3E0NDBDUGVtRkUy?=
 =?utf-8?B?Q01YRXFleUMzOXMwVFdYM2VLVy93OHZMT01yeWZ6RzkvMXBQcjYzZEpyN0JM?=
 =?utf-8?B?S0NUWWFnT3FobkRlRzk5cEhzanJOU0poNTY4R05IaU5OSWtIRHJwblorUU0y?=
 =?utf-8?B?ZnFMWERpMlNwVnJkV1NzZS8rd3B3RTEvMWF2RDJOVWFiSTMxbkZmSURJUTZi?=
 =?utf-8?B?b2NTeFA5SzEwUkZPcVhhNkJ2VDU5aWlScWNZc0xVRVN0V2dVd2p0ZC9xSGww?=
 =?utf-8?B?Qy9ha1Y0K3J1cnNOdjJBZGkvNEVaNEJzNVVQRkpWTldIeTRBWlFTWGJtaXBU?=
 =?utf-8?B?N3hxRVBuVjdxMWl3V3NyQm42VnlrSkloZ3QxcVk2T200QjB0bmVhWFEyNWR0?=
 =?utf-8?B?Vlc1UENWU2lZS3ROTE5UWlQwV2IrZE1pTllGVk5WdHdORVFma0dBMXhhZnRs?=
 =?utf-8?B?ZFhwalR0WGpxV1ZMSFQyMDBWbXoyQXNHbUFLZU93T0NacDFncUZpdGU2U0Qw?=
 =?utf-8?B?MUlZY2JIbWphdmhFdFA5RkVVd0FMcXlRQWwzZVJYeWZOK044NnFpSlBpVGow?=
 =?utf-8?B?enRPSmVMTm53bVBHYnJXK2MxZmxTdnB6am91eGNOYUNNdUhxejJBODRXM3ov?=
 =?utf-8?B?Q0x6L1BMT21WWlBmNWkxM21XMlhyejRJZ3ZGYWloSjN5L0VxR0FSMGZlNHI3?=
 =?utf-8?B?bFJjakNMOXZYMGI1a0tOejR1b1hLa002UkgvdDBJMlRzK2MzWEZCUkNzVWMy?=
 =?utf-8?B?ZXdsa1NDTytzSzVrbkJ0WTdQMFMrcDFycnlpUVMxc0g1cTFmSFF3czZsbjZo?=
 =?utf-8?Q?SyYkYm8vbA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K20yQS9jWE4vblRLZnYxQ0UxaEM2Y1dSUmNxSHgzeStybExOdWtUNHYzT3RX?=
 =?utf-8?B?NjRoVDE4azFkdkpUb1Z2dXRyNTN0YkJsMk44cUtlMkZOM29VcVcrY3VIYzJ3?=
 =?utf-8?B?TWptQkp4UXdFZVFKb1M2RUgzUUVaZ2l2VExZa0Nsa3BUU0UwaXZBRXU1bElP?=
 =?utf-8?B?WkdjUExiQ1lMb0Y3cFkvUGErTXBSWUROb2tNeXlhTjNMUW83TzcrZmdhWHBN?=
 =?utf-8?B?YmN3TndmaVFJQzAyd0hRTDJvT2RvK1hmMHA0Nmt6M0NhNnZHVkF4UXl0REhL?=
 =?utf-8?B?U2tzWjFSMXNKOEE5b2dmT1FuenljSndTRVpHOUpnY0J0bU5kd2RHSWVmMHJp?=
 =?utf-8?B?bnBjUjJ5elByMGFUWXNHTEpNRXRNOUZYWmNKdytrV0lWOHdzaWJ6ajNVOC9W?=
 =?utf-8?B?cHZMMVNZeVoxelJ0RXJQUVQ1TUFnZWlURjQwOUlha25qcWFlMHpjdlZFR012?=
 =?utf-8?B?WTVPMXIyRHRxalVvRmJKSURiK29MYlJlU3hLdlBBYzd2bnRCZW5KUkJsUVAr?=
 =?utf-8?B?b2hsVFlxT21GdmNvSjdyQ2YvQkxxbVZaTUViVmU0a2VGWWNBbGliZzg0MGto?=
 =?utf-8?B?SHNuT2tIdWJ1MzJBbUdCODhXRDZpWmtGY3NnaGhWRGtMdkR1MGp0ODVYWHRE?=
 =?utf-8?B?RXlXQjE1VkxZZjJrNjU3aXVacVpBbGdjbENnUkEwV0VlTUU1dzdsWm5YcXVv?=
 =?utf-8?B?WHg4S0pVTmhzUVA4Um5UY3VuQ0ZYVW9QYXVud2VSRVQzN3VEU25SeDV5MnRG?=
 =?utf-8?B?d2lkVlhRd1g0NWFhb2FXSFdhemo5UVBNVlZnMERwL0t1Ti81RjRWdnQ5cWZm?=
 =?utf-8?B?bzJjZmF0WktvZ1lwZHRhb2Z5RkQ3MlVuV0U2Vk9QSnhGUVNsZFdVQjBCQ0xD?=
 =?utf-8?B?RlVYaG9iNmNtRmUwVlptR3NhY1dYWXdhUjg3eGJvZzJuZU1JSHJzdE83eGFO?=
 =?utf-8?B?d2xwRUFwNzhHeFNDUWNDSlgrMzVEY0F2cmF2cUZMUEJwSUl5WmVqWjJCaTJm?=
 =?utf-8?B?MCtWRGNOUGxJek9wV3ZVOC9Ea0NDSWxteVIyMFM4bnUraXBCNWJQYmVmSGlB?=
 =?utf-8?B?SGpMK1pQT3ZEaE9vSUdsTkFqbmNlNzdGV1ozRkVmTzIxVVp0V1ZCK1BVV3Uw?=
 =?utf-8?B?VG83ZkZhU3lscGYxd1pZY3VQb3JhSDArZFl2WWhtNS81bm91b1JiUklPMlBR?=
 =?utf-8?B?MVY0cGNkcnhGOGp6M1dHc3FDNjFySm1ZdXg2RHdPSTdrL0dqOU05OTJzc3N3?=
 =?utf-8?B?NTBnK21JMlVWUERFak1CR0NwVCtiU0cwM0RLZ25zY3lzODZxKzF0QlAwOVlz?=
 =?utf-8?B?aDdyamc4bWVhNHJiNWJrTkxOK3hVMmVWbUpNemwvNjdqNGtVQzR6QU4xempy?=
 =?utf-8?B?ZzRpWmRSZ0xCQVVZcDlqMU1JaFh6MU56S2hRS1FVVVQyTTkxOFU5MUw1angy?=
 =?utf-8?B?TENqSU9DOEVpV2lRTXlkczZBZ1JqY2Z5N1kzU1kwcTBRTGJtbWhLWjd2TU1W?=
 =?utf-8?B?RlJiVkF0SzMvV245SlBHSkIxQlBXQ1I0NU80c3huQnBOYnNJOXZZNkgrcG9z?=
 =?utf-8?B?a2dTQkYvdERUY2c4VEd1RXJjR0ducE80bUxodkd4TkUwUGhLZ3ZubVdNa0Yv?=
 =?utf-8?B?SER4RGdDQzhURW1venZra0l1c2lXamFKM1Y1aEg0RXlDeHhMckJZSDVKSnJR?=
 =?utf-8?B?cThtTEthR3BqaVdoU2lwdE5pLzdaT0I5SHZDQ0svMXVqTnlEeE02WmhLVjNT?=
 =?utf-8?B?cUJHRTQzUDVhV3hzUFcwSXNDZ2lVWUl6MHY4NW96WmtuUU1LVEd4RW9FMGt1?=
 =?utf-8?B?bVFtY25hUzVnZlgra2ErSmJUQlRDdENaUHEyYzJlWXE4TVB0UEpZdDJSREhq?=
 =?utf-8?B?TVlhMWJiNHhFSUdRVmJPMG9wZ2RUUTVCOGUvUzhRYzUwV0JGbXNUV0pJVzcx?=
 =?utf-8?B?Zi8yNGJLQ1JuTG1wbjA0NUVoNXk1OHBSaEZ1L2pWT3BEVHJ5MkVnMUxKRlhv?=
 =?utf-8?B?YzlpZXZ1cllHdERtL05CVGVWM2ZDNUhlUi81WW5VRlkvZlQ0ZmRDYzJiVC9Y?=
 =?utf-8?B?QmFRK2Ztb1c2QXBkcURqVGNubkxxVDNWREZJTVZBVnBxWW1JOWEyNkxrMjFM?=
 =?utf-8?B?ZnRnM2NMU1lvOGpJdGNxMVp5ZEpjTGMzSG45WE13Ukd5ZUZWL3F3dnpOY0JX?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef9bacc-5673-424a-01da-08ddf45d9f12
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:41:50.0720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c817Mutwj3eObP1D+Uv+gLHDpK10Z4BnMvJA0I/FlUrIPHwHDz8kFrCgA/z6E41zGvY/VgWXqQl5mgIi9cirkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7084
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/optee/optee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/optee/optee.c b/lib/optee/optee.c
index 393f2715a9c..c643fd8fea0 100644
--- a/lib/optee/optee.c
+++ b/lib/optee/optee.c
@@ -87,7 +87,7 @@ static int optee_copy_firmware_node(ofnode node, void *fdt_blob)
 	/* copy the compatible property */
 	prop = ofnode_get_property(node, "compatible", &len);
 	if (!prop) {
-		debug("missing OP-TEE compatible property");
+		debug("missing OP-TEE compatible property\n");
 		return -EINVAL;
 	}
 
@@ -98,7 +98,7 @@ static int optee_copy_firmware_node(ofnode node, void *fdt_blob)
 	/* copy the method property */
 	prop = ofnode_get_property(node, "method", &len);
 	if (!prop) {
-		debug("missing OP-TEE method property");
+		debug("missing OP-TEE method property\n");
 		return -EINVAL;
 	}
 
@@ -121,7 +121,7 @@ int optee_copy_fdt_nodes(void *new_blob)
 	/* only proceed if there is an /firmware/optee node */
 	node = ofnode_path("/firmware/optee");
 	if (!ofnode_valid(node)) {
-		debug("No OP-TEE firmware node in old fdt, nothing to do");
+		debug("No OP-TEE firmware node in old fdt, nothing to do\n");
 		return 0;
 	}
 
@@ -131,7 +131,7 @@ int optee_copy_fdt_nodes(void *new_blob)
 	 * so do not interfere.
 	 */
 	if (fdt_path_offset(new_blob, "/firmware/optee") >= 0) {
-		debug("OP-TEE Device Tree node already exists in target");
+		debug("OP-TEE Device Tree node already exists in target\n");
 		return 0;
 	}
 
-- 
2.51.0
