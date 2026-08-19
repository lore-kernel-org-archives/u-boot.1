Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507D3C5DF87
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 12:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E510C4053F;
	Wed, 19 Aug 2026 12:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kfZy-VPs6nm; Wed, 19 Aug 2026 12:16:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787141789;
	bh=4gMPTIxTo5F3cXRQFG38mzDLEdFWHGLKYts9rZeqJag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F03VjXepUgjU0EJriws9UkKY7R+9C8++PHYqLptDwb13V+9yuZa34BR8Z5fi959PV
	 B49N+nS95hmjtoI8pXUsPZyBnEfgHo8RuffwiFsEPEmSwPZqSOyZFkIMqJQEJwhG9b
	 VcaqoVdfqxAYwPpjbDYCqm937iqSkb69dshZ+XvOYRQA3jYbKwbyPdzPtdRncJ3WfZ
	 BOLso9L3arYlzWcGrWSyC4/wqfkkSop3H6tlFrdQF+FEKFUnEqu8wMTF9YMfxfgsKo
	 ePCBlMYxG/MFS81qM2VmwaMxhc5O2unhFbmDw6viMiixEFByqRj/brvqKGPDxbP8UX
	 f5KLdO03l4r5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50C8C403BD;
	Wed, 19 Aug 2026 12:16:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 713D41395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55EE96069C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uPyKsyLbuK96 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 12:16:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=d7jKZRg2
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 788C66069B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2LbLluviRdZJXsRK6x/ME0wfiW9R8QJRyTfFTCn2Yin0s6uUmjsym/Xn+Qtq+IylmPW1kWQCDSl2IH7H3LC9vaK6bYt0Mxh+YX0Fdr87L3njVGMpfdgqy0lK0whghFj0DE/38lJEfHYfBrR+lezngHFAJ81t1E2yu/nateHFl3OTQarY+dqFQoOTft1Qne5LunVCjsNeHDtRVdXIIf8efsOCLTtdlozkqBbWjL6pZ+b/pDWeHZ2ykeyMRcjfc4LPw5UTQCmv4JvaEaKA7bOH7SQEBBeHpNPYP5nJSzKo/STe9aMx0Nw911x5JucaK3svY1JwdvVYtdsigtONV8s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gMPTIxTo5F3cXRQFG38mzDLEdFWHGLKYts9rZeqJag=;
 b=MZWEVxiu/Jsh8ulZh8EE920+ZtW1Qo1UULl6vavtaRiIPvO35fdfq5V/TxnPflcCK6vMuReS5vzaCFI6BAFWgcXlRqr0EFJvyRb+vI4i+Cin9mSOGSBIMuG3KpUjD04s8DiFWoKj4jqyHqYcFUcLARgKuS7Yf68xwAjhRLl+DQd4wKP07USBnwPmk2pXkxK2P91hyOzOLGnllury80EFEnNMj3IAJxi3vAaLN1T2GnK01daeEZdWXUMNQCj1QB1glO86MOjYy6kW3FHQBCznq312y6VK+n30FArz7Yv6Y2Pr7+0yCmheg/XV4rsbqn4coTEmKTOXtL1P0gJhwi2+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gMPTIxTo5F3cXRQFG38mzDLEdFWHGLKYts9rZeqJag=;
 b=d7jKZRg2NSCdzhveLDGdnbRij3l0KHk3L3zoBvzk8UH9CugjB/++bskYNeqw2sv7XjC/OvZyboDrbmd7zfpjIWND1b3uD+ziqFp21hSM304shIDW3LFZFnBD4qToFJ5RKlT2753/VpPa4JERZMYmLwVwMz0I9HNzZxzyfFRY7nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 12:16:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:16:15 +0000
Message-ID: <a20d0539-6629-4c40-bfd6-4af512610892@cherry.de>
Date: Wed, 19 Aug 2026 14:16:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] rockchip: doc: add mask ROM mode text
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
 <72cb1d52-c09a-4f33-a369-1741e0b0f543@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <72cb1d52-c09a-4f33-a369-1741e0b0f543@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0104.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::20) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: de648cb0-5f9e-43b4-d645-08defdebaa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|23010399003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4B93Jq9HyVAjofwajgXwQMO0S/OwviO2qGJaq0WdbbSFJ/OmvbqD4OLdzzQGhwgjLnCTl1Moze8yDxrwZBxUf9k9X+rotH8I3ERi1HWPZoZMhWuTvKBtYJzZpG6UyVXcIVGdxDZLGMzhaKJJF9jDoACxGTsc0PPVwrKDKNvcwgopt4h5z0/jDajiqZMnU7nA5xw4ECtHKwTcjOcWM/i+sVrSGOOLJYWddfRKmuHtMzzyEev1n8w7ILOXx2N4XxeB9zH1AVDwF/E6H+ejtt6UshSDjHjHXriyjL9DgHubBis0LviD6Q3k6V3SwaKhhrWvoNxnEUtYA/GY5N4NLksGDB9bTsUybxbMABJNnFOKNBf4r8PFMuTlSXZEVmiQfWvtcD6GYkddxNBl9QXit2Ow3zUwEVE+IzJd26PuwF5FRvX6LVsit1lWyA/nafuiQJttJ1vpAXylG2IlkQhfi1EEqSByNDjFnd4fNXzd+khrqNlEG3Dd5rGmbxQRxeuN3plr6dwP+h/L2aWJrbsd4HV6F3B2vrfR4IOnrsJDxsZ2QhHEl2TpJT1krZRoedzSi3wwaR1yF8pbKnaDvAA3eHcnfBMWsKXdLoV5fz/WsxLezRU4C5lshnRRJi2ImGotARJLJTOzOS4aS8PHC9yAOaq4fQBINK1g49NkComCivKBbo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtuc2phZ09KdHF4UU1iblhuMmgvM0ROdWd6WWpYSDNTdDVtRC9BOFpseVhQ?=
 =?utf-8?B?KzlDYTlCSnVYVGhvNDJJVEdVT0oxOFY2TG81cEpNenJiWHVJN3R4WlJEazV0?=
 =?utf-8?B?eEFZMWZpTVZ2ZzgzNkt6L1BFOG1aMkJqNm1JVDdyME5VbWlGcnVLSU1UZE5O?=
 =?utf-8?B?U0x6bjh4OWdnMFRWS0p2dGp3RlFDK3RtRWhNcDg5UnBlVDBWYlZHenY4K0ZV?=
 =?utf-8?B?SUJxZ0trcFhTbWNTQzRhZDFaUFNNdWRneEp5ekxER3VkWTE2K3pLRXcxMnV4?=
 =?utf-8?B?ZXI1eUhvZkFzaW5zUEdPMWo0TzVGdkt6U3oxZDA4enk2UWY3d2JRb3VrWnZN?=
 =?utf-8?B?SlRPQitVd0IwazREcUwzeXJuUzJodVBUVzdxaXZzRyt6cHhjVlJINUlQSGlI?=
 =?utf-8?B?Z3FqKzNFaGFIeFV0Tk5VbE14T25peGxkNk8rMlZFclRnaE1wNFhrMkcvZThX?=
 =?utf-8?B?MEdnby8wMlZidmxmWWloWGFWdnRVVmhBQ1VRQnZXUnFHcUZ1bUp1ZHhleDlr?=
 =?utf-8?B?clBrQ0lwYmpTTmJtSFpSZ3BqbFJsNzBnYVdXbWphMHB5aXZoZjVkS0cvYzBn?=
 =?utf-8?B?Ykc2K0VIVDkraGxUc1RCbjBCRDNmQkhKR3dxUGhab0NHaG8wYk1MTlgvOE9v?=
 =?utf-8?B?S1hoRGlySzRNRC9SL0lwTnN3WnNZU0R1QkJUTStDMkh5bnFvemRIZ1M2T0sr?=
 =?utf-8?B?MGFiaGJXUE9yUGozUFZDSUlYSnIweS84RFZITEc5NHB4ZCt0N3U0bk5ia3Yz?=
 =?utf-8?B?bmNnbWkrRTVPL3k1bmJtN3YxKzNPOGY3ako0TVcxTi8zcnV2SFRlSmk5eGZ3?=
 =?utf-8?B?YXdtNEcwRVpIMUpXVTlCem5vdndOcGtiLzZQWElVZ05jR0NXLzBPUnFDRXBF?=
 =?utf-8?B?QzlzN0o2di9HaVhMOVo1R3h1c3RJRmFiUEpwdUJVa24wUnVpa0xPVjRUTzdL?=
 =?utf-8?B?bU83Q0VHQ0xXZG5JempVaHVuazNUcFBRei9VOVd2Y3dab0VEVm56YlI2dDlR?=
 =?utf-8?B?RzhoOExITDB4L3RDVktuN1JlcHdoT09yRGk0OE9kbWdXU3Nza3N5TURLVTBm?=
 =?utf-8?B?eTF3cVdjVkJJSitrTDQyMU1kdFV0eXR4MTNEb1RPc3R3NmRvbzZVME01eWZx?=
 =?utf-8?B?SEZiMUN2SFVMWTBsWmVlUm9STy8yV1pTY2lycXVUZFo4NkE0Z1ZqVUxjbHJQ?=
 =?utf-8?B?Q1FkNkxaeGgvdWdsd1kwTVN6OFlMdlVMZmV3SlIrOXpIUVVsNFppekJQUC9K?=
 =?utf-8?B?ZXJWUDZsUlBWVnFnQlhWcVNEWGRGcC8wN2wrYzRSUnk0eXNXdlB1TGRhVitr?=
 =?utf-8?B?S1VFeFJ1WkF4aUhhczRXR3pGSlVIcXdIUGhwVlBheExiR2ZOVWNsQmFIaHJp?=
 =?utf-8?B?Z1VranB1RS9MMXo4eFZDaWNNQ29Nem14cmxUbHIvT3JsbjdmZm10M21jc0g2?=
 =?utf-8?B?N0cyZjVRVnl4U3B1a1pGQjc5ejNDSzdLNm1xRm5JTG1GMjZkYllVaFpXVHVh?=
 =?utf-8?B?S3V6VTZZVzM5Y1I0cTFrVGlUTjJ3QStMeUszZ2tKR0tsdlBiRWpGVWllbFBj?=
 =?utf-8?B?Wk5HUkxXVW9FTCtwMmRVb0JVZERSZllNd1ozYkpGRCtxYURjdmpBQVVlcEhT?=
 =?utf-8?B?bDBneEdkMi91QXVVSExPQnl1VDlZSFhYbTh6VGpGbUxyczVOYnZoR1ZSY3Y3?=
 =?utf-8?B?KzJ5VWFOQjA3Vm40TVNOd1ZkZjhQMlNFbGdzTGFZcTNCeEN3TnU3UjJpcUt1?=
 =?utf-8?B?WjJLNTFocndLK3NVZ0lNWWU3RWRGUWRvUDlidVc2V3NYYVcyK2tZVG9IYnVp?=
 =?utf-8?B?MmdPcHhWK2Z0VkhrcHZEYkFpRVliMk1RakNwczdwK0JkTHlsTVdKMG9KQUxo?=
 =?utf-8?B?VkhGWkl4c1FieWRYRHlNaFhVTnVXZzRWa29GMFRFYzN5NnFSOG82R0tPU0hZ?=
 =?utf-8?B?Tm9XVXRteXk0dENxbFppdEpOMlNUajc4Vi9zdURZK2V4TGtxNkphcUIyOEJv?=
 =?utf-8?B?cWFrckpFcCswanpjckNqeFBwUkJOWEVKY1hyNzhOOHRuUWZ5amExdzN4dU5l?=
 =?utf-8?B?dnJraktFQi9UUHlwZWs4Z0FNMlVRc0tYYStwVzhPRXFWVklvVUZ3cm1kS3BP?=
 =?utf-8?B?dmZYNGV6N2RlVDFjRXZ5R2xZYmZaUmkxemUzdFEvek1xKzh5Y1VEQmdvTFYv?=
 =?utf-8?B?aXBpSlZLQ0pkb1BwZkJWYm84YW9kSm9uZkk4ZGxvT1FuVThLU2RRU0JpcFov?=
 =?utf-8?B?RWVoVk82c1dVKzBSOXV4MXVMRWo5S3NjcUFkQ01rc0VqVjNFd0VYSkJuMXlq?=
 =?utf-8?B?WFpPdlhPS2svbUIvb0pocTV1K2xWK1VNR1AzZE1xcWt3K2o2UHhMWCtSeFJr?=
 =?utf-8?Q?d+0ctdXOkEHznkHpVr+Z9WsXHBIMgCIBUpOuZTOoi+QEK?=
X-MS-Exchange-AntiSpam-MessageData-1: 5hsTprP9QF7j2Q==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de648cb0-5f9e-43b4-d645-08defdebaa60
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:16:15.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4Zb77CPJYmBaKkxThvMbkRNDzQG2AAdLJVU2wVoFmCqV76BM3N9uwSTTXYbhn0Qzr794fL6W3lHXeZ4/3vBd+PEw2ZNo58yQ9QmHGgdlOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136
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

Hi Johan,

On 8/15/26 3:07 PM, Johan Jonker wrote:
> Add text that explains how to get into mask ROM mode.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
