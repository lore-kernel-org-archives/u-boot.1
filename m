Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167D606A335
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uh4CdmLL;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mS8Ss9Wa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC10F6061B;
	Mon,  9 Nov 2026 16:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIjG75f5l0Y3; Mon,  9 Nov 2026 16:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1285060773
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794242166;
	b=dvdrW0nd20Vv0PykDYBfXV4PWkCJAOXSms3ar/3ZPQh0NHk37aZi1HrhqnsDmMxNbptB
	 mwm7MTTUQJXV9fteHt1AymmDpkLkco4zbz+7HKfKvRGzGUXqQ9RBh1djNx3n2382q53/R
	 Y30Uc7vnlTHWEO7LtLBol4bO/FiibTenzlZFTwioi5b8rE8EZp9Xxs3Cgmw8lTiujzGSx
	 lCwwKt77y4n9RnTcYPROOWC4oA09FNaeSeCLoBXdQi4fgQIMuNeBUjlX5N8oGNInjN19V
	 vUlLA/sk3zwDng1VnmI4VPhucvGT5rO2I6yZQ/S24WyMCTpFHLEK8kGXleuDMiUxACw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794242166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H4jVtfljD0RTGz8gNAN8X3jARd9Z0H0mBLFA3pf5HH8=;
	b=d/KQOhjzMm2UM6fdsoqUYRQbD/Yv3+vSL5Moi6YBowYN9q68/AVSzkmK1BTmApF0Oshc
	 ya9uPYXHuTx6jYbiZYdRZA21CQOy+Fod9tGcAU/138PPdazJm7zuLCNEzDSfs/sze8k4q
	 61igBQ4Y+HRjcI2LVKiop1T3J4979RNLLILzCvND8+WcxVDj2BE4UCSISD8rdwyaK+Vrm
	 RrC1SsQPt+UqN9oQNaUBZTNniJLLMm9zrJCbpXJHjAR0rFM00JxutyUoJ2qnz3BqD2rc4
	 6FhV17hGzXIjMUkNb+cyj7/rZYKRDiRFUDledbf78JO02pMVXLPwOJMJG5Hv2nXBqnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mS8Ss9Wa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794242166;
	bh=H4jVtfljD0RTGz8gNAN8X3jARd9Z0H0mBLFA3pf5HH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uh4CdmLLdRqjYAcbnq3F15HlL7SIPdENrjKrHiF0BhObQpIuBRHhzX+pktN7/XgF4
	 1j5AUB9/NY6R/Bx01tRpeRJpya9p7g/7kcMVxXkDUQfESIyirRK2W/z3/ywD+QFgtw
	 GeeULbPEVUHsr0gbzDFU8qMm8O1DmLe9IIuHLHL44WahBHr8AbLcN1vniI4u4Mkz/C
	 z53Jh5czkRCfYpZQoWU7d7FXZ+Xp7RJkm+Pccmjhd96ILlGFNkj1sDXB/SyA4JshNL
	 tKzewkWEbyhN6Qh3JCfoFzLOa6oPae9F38M1P3Ksw3zYVXMJ57b3m2mP07ACKo3HO2
	 jFg1QqCC68EzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1285060773;
	Mon,  9 Nov 2026 16:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FFEB362
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60B7760773
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTebjIC3UQM2 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 16:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 784E96061B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mS8Ss9Wa
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 784E96061B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4jVtfljD0RTGz8gNAN8X3jARd9Z0H0mBLFA3pf5HH8=;
 b=mS8Ss9Wat11ncxi1JuOiJwiaHOmWtwYIQBPi8mmninX4AUemeXQjd8eqyyfZwcs7nalsJHcHfvrmrN4bnAxxv9xYTer7sp9OH7O+1Q2KonM3jtYXyMHwq7thJbFekGmIsNMNiM9vREtvqtreH46uv94IDwaQEn4zkiUP89SdZLw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB6995.eurprd04.prod.outlook.com (2603:10a6:208:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:35:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 16:35:56 +0000
Message-ID: <cba6b6a3-2e61-4bf0-af99-6429f9da3350@cherry.de>
Date: Mon, 9 Nov 2026 17:35:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fdt_support: Add /chosen/bootsource fixup
To: Wadim Egorov <w.egorov@phytec.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, quentin.schulz@cherry.de
Cc: kever.yang@rock-chips.com, anshuld@ti.com, aristo.chen@canonical.com,
 alchark@flipper.net, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
References: <20261014143328.3135006-1-w.egorov@phytec.de>
 <20261014143328.3135006-2-w.egorov@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261014143328.3135006-2-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0030.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f132b8-3a81-4be7-9525-08df3e7f8743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|4143699003|11063799006|261102123227099003|261022115727099003|56012099006|261021121427099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: xqxLhAk+1C2CZ8KTbfb7y3KRAF8W5K+8EcC5C5Ga6aakxODzbkF2QlQGImRXGyJDQbS0ZqyzpZCMRb+R3TddA22H+yG027gCFtbH/1Uh0tB7EOxBiVtadVYrjPtJpVT/fcEFFxzLESLxF2yQGgTg1svvf2AbgFQ7uYGz+5p9rb9sds6F1G2YOPknQYel3+1Sgq3aCcicUTiT4gtOIi4wnOW9lwOQwwriWIMzGP3cmTc6s5CemuApVjoZ9aR28qcJTIv3gn0XRKiBhXpsAR5j/5vRMqg/PX1wbqcH07FsSab7q+fHZNhzgxZYpy8w0UvBb2zKlTznoybyX6t3ftFi7JfohhuY7dNVYKI+vkRo4WRwPB67TLP5mczdHkQjVczhW5olb1sSK30Hbsec6gIKHKSxTbf/N2KXSmkLxwc3pDszFH9bemLheTU2GdR0Mu55B9gBdXbFu+kIDRDFB5xPYWEaWWllUtG/LyDl2wU0p/Mn247e1xv6mhtXU1ZKKmCDvROSbcG2wjXradmAYpi5JNF0a2BQcT0twb3iZ7rUrGrX9MyPPMz7AkOwEmYVyl0/PjeuwhY6iQL2BxQ5fM+6+OYXmWBpF8lS6bXkxlLZp/F8BCp6GD3QvIbV4xhYWkP12U/fr1NNBWLj9kcyHB9Wq+QII64N+NcUxb+jd0I87ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261022115727099003)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9RQStrVU1ZZWxHcFlWSTl5ZEpSeFppQUNJbEdYQmc2THBXZjZsS2FJN2lP?=
 =?utf-8?B?ZE43azdRblNZb251MW1VMGxVcTE0TWlFZVBwN3h1NjBCbjFGd095QUxWNkd4?=
 =?utf-8?B?Qzd6K0dKZUxEVXJKWEx6Sndjd3ZDWjN0clBEajl1YUJsWnhhb0E1MXZJY1Fu?=
 =?utf-8?B?TzBYOTZMSk9wWU1IejNQSWR2UDRycW9HZmdTMnNOem00cHo5NXhJZG9NM2RQ?=
 =?utf-8?B?N0lOdXhQRjF2eEJidlp0N290MGpvYjh4QzZ3QjViZjBBQ3VsaWVPRHdEWmxO?=
 =?utf-8?B?bi9mRDl5cFpIczdveFlLbENXZWZwbHppMUxrNlVaUjc1RTBUcFVtYVE2anFF?=
 =?utf-8?B?M0hiYW9pMkJmTExCOG5NVThSMitQNThCVFBoM3FhZGx3U055cHVXZ2Fla3J5?=
 =?utf-8?B?UEM2bVlwblljU3dtZVVjeHpaTXJmQ0pnUlJ4M1N0UjdRYnE3VlNqVTV1a1VR?=
 =?utf-8?B?TWxjdytvc3BCQVBodkdFbWpXcVMwSmY2SHphd0FvNkxIWTRFWFV2WGVVSmFC?=
 =?utf-8?B?UlJmUEp6cTg4NXg2Rk5lNXYyb2ZzRHVuay8rL3VLUDNWTndwS0U1TG9wN2R6?=
 =?utf-8?B?MldLWCtUN2dxWjU1YUNMN0xVLzdWbFJZdzZmWjZNbHRCYUZGYkpqdUVYd0E3?=
 =?utf-8?B?K0dkUytKblUzZExmT2ZHVVNHVFBTYzlHbWdzWEhYM21hSkVIc1hnWTljTDlp?=
 =?utf-8?B?TjdUaklEaDFHbE9SVlQ5Rm12YjNkNVNJbDFNMjZRdi9JTzEzWFVWNW9ldkxL?=
 =?utf-8?B?UjJhSHBkUE9JNW5ucENabmd2cEVJVWR0dWV4STN1b01OMEJ6TDA5VmRWRWpJ?=
 =?utf-8?B?SS9ZRHh5K0d3dEZxVDdtTnJpNk9WRC9vaFpjQnQwN3MzTTROVVdoNVd0ZW1J?=
 =?utf-8?B?SjZJMjEwWUZxTm5hOHFzcDFEYnJQUnpxOFdqdW9SWWlzV2xxRTlLMzExTisz?=
 =?utf-8?B?d0xjU3JhMkMxZ0lrK0FWVHI3NTVPV0lwT1lZekVwTExjRVgxaUJOL0M3UmVX?=
 =?utf-8?B?d0RPN3R2MTZQWng1Q04ydmpxcjRnM0ljOGpQZGc5UFV6UFZUZGRZcnA5SGdR?=
 =?utf-8?B?S2FtZDJJSWxZVlU5blM4eEFyUVhyMmlpNTMrMEdPUmlCNHZOYlNJRXgvQWV6?=
 =?utf-8?B?ZFhHNHpGNEMxd3Z1VjBuNkM5WFRWbWJBY2FMai9kSTUrUDY1WVRSRXlWYnd0?=
 =?utf-8?B?YXJKcjl2dGNyK0NtejlsOGw5dXp2bTQ0WnUwMFovWHhiSkdsc1JEKy9zbERP?=
 =?utf-8?B?OC9hRHJROGovYWZ4alhCNHdxZU5HU3ZNNDNGZGVLMXh3U0hwRVlYand6LzdM?=
 =?utf-8?B?N3dtdk1UanVKNHNjZnE3ampqNjdLZVhEYlpyUE1QaTFrci9YdDB5SXp1NVNX?=
 =?utf-8?B?dEpVem9MbDhQdGtVM3Nvc0xoQ3VYdHYxcFFTZll5amYyZS90eW04RFZRZjVO?=
 =?utf-8?B?aCtmSUZWcFI5enI1dndMdlg0NmFoNnF3SzdZeWcrMEIrK3hyL0FJRUZ2Rk5F?=
 =?utf-8?B?d2FoTlpSL2NRZGdjQzVwNWZrY08zTWF3akRQSmhJZ2hTNFhpVmIxNkd1MC9L?=
 =?utf-8?B?WGl6dFNKK3V5U3BlV1AxV09XbHllVTBQcFc3Y041K1NJQXZRVnVRZHJMTW1F?=
 =?utf-8?B?c2o5a3JRMm5ZRjRrd0V3TnV6NnRRT0t1L2RvM0NUZDgyR2lKZVZaWnI2a0hQ?=
 =?utf-8?B?NWs5SG10ejVnTmhVdE1DUmxRZVFVOW5kckJkZTN6cUZqMFgzMjVPbkJyNGNx?=
 =?utf-8?B?Y3JFOWFsTk4xOEhWbFRqcktzRTBVRTJocDdhWXowY1AwYlRJRnJWdXBOV3Ru?=
 =?utf-8?B?dmZ6VTZPdnZZU3lpaHhPZ0xPSGgzQjRtYWN4WUpLMURYTEJnVERyK1N5K3hE?=
 =?utf-8?B?VFIrRWFCSFBDeWRTT0xPWXN5Uk9IQjlnbUZWS0VnT0xUcm5xak5HdHZnbUJL?=
 =?utf-8?B?MFVRenZHakpJd0pXZHJDdlZlWmxLUHdId1lKbklJenI0WnFDZ25CZmZua0li?=
 =?utf-8?B?YlhuSmZ5NVVrNTU3TnhLUFhQNE0vb1pJOGE2TzdaWStBMHh2MmhObmxXY2hQ?=
 =?utf-8?B?ckwwRHQvcE9kakdEbm1lSVcxZVdCZ1hCUFdmKzlML3FaUXBmNnI0QmpzSUdu?=
 =?utf-8?B?Vkk0TkVuS3lZT2Vsb0tzWVFXOERyWjYzallTaWl0Vm5wYU96V0I5TU4xWVgw?=
 =?utf-8?B?ODI1MkZPV0c4ZXN1bDEvc0NhaXlOOU91R0IwTzluYTh1a2JiMlRnUWtqaUh6?=
 =?utf-8?B?RUVDdVVSY0Z4bU9GcnR3STFNUS9JMnFaK2JaNTdhTlI4SnNFcHFpanVKbnpW?=
 =?utf-8?B?Wlo2dVg1aUlEaThSZkowTXQrRVcwYWlTa2grRVhJZWZLUXpxdEg4QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f132b8-3a81-4be7-9525-08df3e7f8743
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:35:56.2755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5sjLrNztVerqkP+yW2obDC/7L9cozEL4mrk+e5cLuX4Mo154opQtB3PX5zzfAbNS3inVqypIaCyVI2dXChLOiedhjwht1VUX5hqoIgiXZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6995
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wadim,

On 10/14/26 4:33 PM, Wadim Egorov wrote:
> Set /chosen/bootsource to the node of the device the BootROM booted
> from. Platforms provide the path via bootsource_get_ofpath(). By
> default we pass on what a previous boot stage has set in the control
> device tree. The property is only set if the device tree has a node
> at that path.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>   boot/fdt_support.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>   include/fdt_support.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2941df55996..0d04d6f7e9a 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -334,6 +334,46 @@ __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
>   	return env_get("bootargs");
>   }
>   
> +/*
> + * By default pass on what a previous boot stage recorded in the control
> + * device tree of this stage.
> + */
> +__weak const char *bootsource_get_ofpath(void)
> +{
> +	if (CONFIG_IS_ENABLED(OF_REAL))
> +		return ofnode_read_chosen_string("bootsource");
> +
> +	return NULL;
> +}
> +
> +int fdt_fixup_bootsource(void *fdt)
> +{
> +	const char *path;
> +	int chosen, err;
> +
> +	path = bootsource_get_ofpath();
> +	if (!path)
> +		return 0;
> +
> +	/* Only record a path this tree has a node at, so it can be resolved */
> +	if (fdt_path_offset(fdt, path) < 0) {
> +		debug("%s: no node %s, not setting bootsource\n",
> +		      __func__, path);
> +		return 0;
> +	}
> +

I'm wondering whether that's a good idea. SPL's DTB is a very stripped 
down version of proper's, so I could imagine setups in which you boot 
e.g. from USB via the BootROM but not have USB enabled in SPL and thus 
it's missing from the DTB.

> +	chosen = fdt_find_or_add_subnode(fdt, 0, "chosen");
> +	if (chosen < 0)
> +		return chosen;
> +
> +	err = fdt_setprop_string(fdt, chosen, "bootsource", path);
> +	if (err < 0)
> +		printf("WARNING: could not set bootsource %s.\n",
> +		       fdt_strerror(err));

suggestion: switch to log_warning

but i guess this matches what's currently in fdt_kaslrseed.

Cheers,
Quentin
