Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B59FD172C3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 03:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F2A83C51;
	Mon,  2 Feb 2026 04:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="A0tUhSxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B87E83C61; Mon,  2 Feb 2026 04:33:06 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B6483C23
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 04:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0G5Ckor9Sy9Lctgf8fQkfgBIAQAbMfBZJgY8Qqq75jstjn5R12lkIgBfPG8yZz/WNVatkZ67WjostvnYGjpgTXvx2/GK1Eto+lw7i33MvtMRAStJJGbeSI4SZM+k+AhEZ+bmPoDsrPkd8JCbSgpu2Jx2Gqd3r2Z+nZ2Pw1CYeJiimWnVo0xL05LwlF5BShZ3K6L2YUUlb4d0CSQHa74RKrLKqNCTWNhgHq9+2TG4LLVIZVzqQTMCZkISvNZHEyYLCyRQOtzevxMMQII9S81RlntX5JJtRUV+diZ9bQ23wq8gssT4dc1kISyA3rowvbFEi6ceKtjStGUzMJjraWDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Nvt9r2KzeZYSYWemNax0od9qBcvRyoAGjt8yDdbfow=;
 b=xGlo7s/Iea5O5UZft8RRg34JgEWT5yt3HEF+vtUZ1HR4YgFXI1Df6vHfmmNXSEJChWBH562FAk7euo33gqmiPTVvWyqNLTpw3imytg86SdGMAXmHRTIjAzj6r1jeK+E1k7lE9wFoDL7KboNSWxLAkZqR6aotNjxfo4hdz13aM13Q5clcDLI+1PsHAYX7RclnIzcwQW6n3aXzmCAvl4zcw3oGqvVmM/z0WK4I33ifFpiEH6dEdXmr+Qj8yVGgisuL0MJYVwVlpmL5cmOOnlSD/mh9+xTWjBpTmpbQLZv240VEBSrP+ts4w54v+jAwkydLBUJtiI2yc3mVB58X4ovC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Nvt9r2KzeZYSYWemNax0od9qBcvRyoAGjt8yDdbfow=;
 b=A0tUhSxSSoKIOx5eS/59byy6x/xhmxfgjdcnaLOysnuoS0VquvyuESxZUz8U/GpQCHfloTAYocD+NJCjFi1uvUyUVIH608E/Te3VFJJyBJSwxFN61ylVwI8wA8gATSTso3k9D/Y13nqK0PjQvnEH63G5QsxXmAcpJTnLO4wneSqHxAxpVwvuBNz8o0JzFPzJMXWTmTp2LNvQql9Uzk+t7+5TU6FC6eKDcUqHM+8BnIpJsfuXwfDc5yBGYpKxWjHynUrbojP51cMbcjJvNVCvKC5WvjPU8v7zEuanDgTwGJUVg8I1UCX2PrcEmAqiFinn9UbiIrIDffR4LYKwzAwXrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM9P195MB0886.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 03:33:02 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 03:33:02 +0000
Message-ID: <6782bbaa-bce2-405d-a5b5-84ff3e399259@phytec.de>
Date: Mon, 2 Feb 2026 10:31:49 +0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
From: Wadim Egorov <w.egorov@phytec.de>
Subject: U-Boot website?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:802:18::15) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM9P195MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c33d813-1bd2-4347-a375-08de620bc4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmNQYjJxY1hCU0owS003ZFlISmZYdFR6QXhtZ0FxYU5lS0gzVSt0L1kySlNk?=
 =?utf-8?B?VTlHYU92bm1VMmRCaWNKa0dKSnRpdlJXM2ZwNkJheGxNalhXN2lQVEN1ZTkx?=
 =?utf-8?B?QzErS0k3a3ZwZGVKY0F4aUx1eVRtd2tGUm1WSTJKYkxNd1NTc0RzQUt4a0VX?=
 =?utf-8?B?bkZhQUorS0dZSSt1dTZlOEkrS0ZwNjJaaFZpVTlxTmpwN2F6SDlqanN5Vjc1?=
 =?utf-8?B?Y3B1WVRycFFuR1pJTVV6L1NXZmd1NTN6Tm45cmhOWWlUcVpCbXUrZXFGY092?=
 =?utf-8?B?bGdxNFJWUkFYNFAyUnVnZUp6dU00SzlwSlVNY0Y4UGphTks1RmNubGhiajdW?=
 =?utf-8?B?VEtBOHMySmxOMlUvUXpnK1MvZ2VqK3NqWHZiaEUvclZ4R2tPaUt2bksvcDRP?=
 =?utf-8?B?Y3AxSW9NUzR6K0FtQ3NOcEJ2M1Q5ejdPZ3owYS90bmFqRVMzTnNLWGhjVjlo?=
 =?utf-8?B?TDVWc0lNYmxvbDAzdUt1UXdDUmJuZllWMlV2ZUlOaTZuY0NFMExWWmYyN0Vp?=
 =?utf-8?B?SHlSSldIV29TYm1QRXkwd1kwR1dzL1pUek1tTnlXMzVzdFVQTUdBMkIwUXlj?=
 =?utf-8?B?ZkRVbE9hQ25OZ0xWWXQvRnhnN2hnbnZuU3MvZVpBWHVKZ2JnVmNuRW9VdHpZ?=
 =?utf-8?B?UGpRUytCdHdldTJGOUwvVy9NV0p2R2xuekVHdW5JRys3RlNyaEdUaHZqSE93?=
 =?utf-8?B?TlowNytiSG84U2VxYVBNcGRPd2ZsRkc3TWh0am1DS0hIazZ5QndPRmtTdjN0?=
 =?utf-8?B?M1JoNE14Q25Sb3FMQVN1U0EzUnBVSHhGa0crTjlNYTJoRU1PaEdTYmNQTGVF?=
 =?utf-8?B?QTJpcUlOTjYyZkt1VDZpZXI3bmFmUjQ5V3hDYkk5ZzRMYWQ0MDQwNDJZTS9K?=
 =?utf-8?B?bWU4b01FWlAxcWJ6aGlRVUhJVjNnaXdJREk0UWl3STd3cDEycWs1OWh1MEJO?=
 =?utf-8?B?RGM4TDVKVDZCbC9VWUw5TVVsbUNYdkp3QkF3emppbWdONlpOWE1GMkdvemgy?=
 =?utf-8?B?ZlRjVGM1bXpkZFJobDdkenpUZ1h3Rlg3WHE5a0lVbWFlU1hRMm9OSU1LM1Fj?=
 =?utf-8?B?OGViSU9rWHlTZkhpcDdFUDNUVklneDlJUXNRdG1oOWNtU1BIaFZDSnp2cmUz?=
 =?utf-8?B?OW03MkRQM1hEWnNOSWFGS0xZWVpVRVZTWk1FVE5Tc0IxRzZlQU10YXowOWg3?=
 =?utf-8?B?UmRwajhQWVpIZktxcERtUVNPY0V5Ulc3eFhvcmVhaS9RWVlhQjM3dmFkU2xz?=
 =?utf-8?B?ZVVsbUdvcFNnSXg0anNEb1QrdGh6b3VIa2RBcHRNU3JMMnhmS0xTeUlYYS8z?=
 =?utf-8?B?WDdhcEttTXV5KzhJR1VjVU5VTFkxbnFDV1lSVnppdmY3NmFXcjdzRk11R3dG?=
 =?utf-8?B?OWZ1QklrN2NlOE13UFBoUk93b3pqcldhYWs0L2dyalYvVnBDZEpOZVFIVXRZ?=
 =?utf-8?B?eWZQMEl5MSsyMmNXbzVLYnFEeVhweGtBZzR3c0Q4S3dLS2Q4V041VklPd0Zu?=
 =?utf-8?B?Ym5rYnBDcDFGTlB4MGk2Zk8zVW5TNWZDdkJRUnJKYW16c3RpNnpkNjhNVmRN?=
 =?utf-8?B?NWREVUVWSkMwN2hnQlQzT1crMFg2c1BHdjJzcGZxc3hBK2sxbm1aTDQvN0Qv?=
 =?utf-8?B?dDRQbjVFVFF1RVlaRUtjZTloSkZFQVZEVnFtaUV0c3VBKzFCK2RFTlRxYnQ3?=
 =?utf-8?B?eEhDZmhrc1pHdjE5aWVsZ2xkTkQzWEsyZzdOc2Frak9uckRGa0JIV3hJQStw?=
 =?utf-8?B?dlhJUUt5bWpVVGxwVDNTSHF6NFZyMzlJQklXczBjOStlZU1Sdk5tSzJMTTYx?=
 =?utf-8?B?R0pkUjR1U0cydDJUYnR5a2kvS3Jiem52bFFEQ1BXVi92SXgxN25kSFh0V1Ju?=
 =?utf-8?B?RkRSeDNrK3JHWEI2dk5rVnRpRDhvTHJJb09OV1I4Vk9oeEY4TEl0bDU1Y2ZV?=
 =?utf-8?B?NktTak5reVBDeTVEZ2E0VVNubSszL0pVczBtV0lOeXdQd0hHNU1RVm1kS2Zu?=
 =?utf-8?Q?hzruMPh9V8qbnkDX0sAVtVarq9gRtU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFoZWVMd0o3OFpPbjZIV0NYa3dscTk0ZkhuRW56R2J5bVJ4T0RqcnUrN0tD?=
 =?utf-8?B?K3dLRzNnSDRYUHMwMnFDT29BaVRDZHlXT3BsaVhkREtmNlVnY05aVUlGOVcr?=
 =?utf-8?B?QThOeFlKSCtCUDc2Vm5ab3Q1ZjY2OFVtOHhpeElhQXY4N1VlSVNjS3h0U3Fv?=
 =?utf-8?B?VXdrOWQrNTExc0ljdXUzMllPZ1dkTndET25Xa2VBWHZIZTR0ZEFlS2U2Rkpa?=
 =?utf-8?B?QWkvNTdmaDdwd1dNYnVockh3UG9qSTN6M2VnSExEMGZZZEt0WnFVS05PWHZt?=
 =?utf-8?B?Ri8ydXNiOFdubWZCUlM5QXRlUjMxTGJrNlY1M1FPYlhjRkxZc0pQaTBiQTg2?=
 =?utf-8?B?azlmN2xpNmlOUHhqYnJjck9IS0NPYzlpM3JhNnNSOThiU09YRzRiSnBMektX?=
 =?utf-8?B?OFdEdUxwdkpFSi9vR0dURkhFeG1HQ2ZabEFwR1cwZnZQaHBuN2gxV3R4a0ZW?=
 =?utf-8?B?SWo3VXZxYTBTb3hIQUwvc21UallxTWxsQXRaUm9nc0pmdllVWXEwZEdaUUo1?=
 =?utf-8?B?UnVEdHVxcXJJWjVESEhaeVZ3ay9wYjM0YU9oUWdQM2FsYU93SHI0SXBxdm5C?=
 =?utf-8?B?YnlWZU1nMTNlR083TmljOGx4Vi9IZlJJMnBndXRaUGJ2VFdRMzJiRHhjNWg2?=
 =?utf-8?B?YjA4RDhtU1hRbjdzbmp3MVhMbS9xbkZKZE5PZHN3ZC9JQ3BsSFNsQnNib3FE?=
 =?utf-8?B?VGEyd1d4bmluYWRwZVBDK0ZhMDJsVDI1eTI1UmxPdmJBVHNmc1dIT210RTFh?=
 =?utf-8?B?bjBZMWUybDJwRmdwaXZObXRNTS9nbHN2SnFGNWYrUU1jeFNsd2RFSVg4aXdV?=
 =?utf-8?B?Z3VSMW41RUJlK3BPN0Z4ZEI5SUd0MkQ5aGU1VEhHSzBxQVhVbitQY055cmxw?=
 =?utf-8?B?d2p2NXVVUnVncWhTSjFLWDFvYWJpWEFjUGlpc2I4cVhTNzU1bS9EemZzbUlv?=
 =?utf-8?B?UmUxVkFsYVdjWnh6WXE3YlM4c0svNFMxdkRnaEU0dGl3ZVdGYWYwbG9oSHha?=
 =?utf-8?B?dWVmalVCSmlSZHRJNUMyNzhmdVRBaWdMa1ZaNyt3WnJqOFFMU2doem1VQlY3?=
 =?utf-8?B?YlI1QzdjZWpiemxhOWk2YzhXR1hGdnBTMXI0QW94YklTZlJ2NEpQdlNhRzg1?=
 =?utf-8?B?RjV1WTFFQmUyb1l3OGk3b0RvQTZQelBRT1RqUU52RFdONmRGd21JbFlBQ3lZ?=
 =?utf-8?B?YlV5NGcrUm01YXFaYk9iTmoreWh4dVF4bUZ4dlF2NGx4a2pQWWxSSG9vb0Rr?=
 =?utf-8?B?Y2VqOXAyZUhTcmhFejdsNWRNd3BxVnYwV2VwV1RZbEE2MXMzaGZGdHo2U1JG?=
 =?utf-8?B?UUMrL0FwUHo1MXExOWNSdkQ4UnFpMm9XeWlLYklVaHFBNHg0REN3bDBtWFhE?=
 =?utf-8?B?T3N5WlhhS293emQrV1JMTXljM1lXRGF0a0YveUtqRG4yZTd1TFJIaXBTdjR0?=
 =?utf-8?B?NDNZM3haa0kybElxYnVocWVNQUlCQ25hbWpwS0RsSkJ3WTRlNVhqVEhtdW1n?=
 =?utf-8?B?eU5XTVNOdnhpZnVIZi9kaWw3MDVoT1hiTWxvTWRiYjlaT1R5YTRvMXE2bktG?=
 =?utf-8?B?ckFQY3RyZ3I4ODIwbkhyaFFXdExOdVZzTXJqMFoydTd6Sk05eTRLanVyRWFn?=
 =?utf-8?B?ZnNURjAyU1drakZMSGIvSjZkMmJnb1hSTWVYUkdzMmFHa2RDbUtDbTJmbzYx?=
 =?utf-8?B?VzBvNDZtSlYxYVdMSEpkcStvY0VqZ0QvbWhJTnRyL3dCZndBSllkNWl3OVIr?=
 =?utf-8?B?SDdUTHd4UHo0VHhXbVp3Vkp0RGJ2cUFXV2VjL1RsOFFyOUZEYzVLYmJzaFc5?=
 =?utf-8?B?dzVYaW5ITWk4OXpHRS9lUXlXUVlQZ2hMN2hLZU5Hd002R01kR1VLKzkvMXl4?=
 =?utf-8?B?TVpJenA3SVQwdStmOVR0dEtFb3JJdXNTZjltTzlWVFhVRjdaY045T3Z0d2FW?=
 =?utf-8?B?Y2V1Ymk1azc2WUZVZkt5ZUVVZkdNd1dtdDhYWXZmMmdlNGZFcTU0OFhTZTlv?=
 =?utf-8?B?a0pvcWpYVVRJK293VTRrOGYvcU0xamxzWmQ0RXRwY0F3Q1d4VmNqbGFXWm9v?=
 =?utf-8?B?ajZueHY5OVlRQjNuY3RNYW1EbmppbmQxTkVLNjFrbVA0S0RYazc0S2NINHZr?=
 =?utf-8?B?VnJPa2lFSWlwOHkrRE4yaWtoajdSVEN6QnN5OTJXczdmRzJCMXNkcVVuT2ND?=
 =?utf-8?B?VEdaSGgydENLMjV6Q203NUpTQ3hQREQxUUFwWit4QTEvbTk2SnIrekpBdEFO?=
 =?utf-8?B?OXBCaGk1aUkzNU83Z3NxVjVMOGlmZmtBaldhTXVDUjFyd3hNenVSOFMrbGtG?=
 =?utf-8?Q?ESWxCneLbEX6qq3zFf?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c33d813-1bd2-4347-a375-08de620bc4e2
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 03:33:02.4204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFZVwmhdXZqEhglK0+EdJUEChVVJPHIUp4iJ2ydsUOhOlAgJ0AJBCnYAjGY5G4XOstPl2Kw0zo1w9o65Y8L09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0886
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

Hi,

is https://u-boot.org an official u-boot website?

Regards,
Wadim


