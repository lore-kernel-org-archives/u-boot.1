Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB028606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cza7a72a;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=csbmZAW4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4694B811FA;
	Fri, 27 Nov 2026 08:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJLPDLLvy8xm; Fri, 27 Nov 2026 08:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64A5D811AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795767944;
	b=EuakPMWsqN2ZDy1BTAm36ZlCfC+kA5QFwyo7za2UACB4QK4Vsvl+MmDaVMng8Z++AxN+
	 d6yGhTCdUoVZmv+ayeIKgugazy2Shqz6HObmk/UUkyNx7oxqd4zS+f9F0ANLY9R3ooi3b
	 /8msF7HXpz8etFxp2ej7dA5t0Jh2lXU9SQiKUwsmOmiRLEcx3jMnW45C0rZtbWBVpVWYY
	 TR+k9ZIobzkyqzKML5knWyZCa6qUtmcioQnc9AsjEIpYcVt8S4E4hbaMU8UO6C8xCpuHE
	 kQGVcKPnsRI6vRbyU1P5hzY8RHXP1k1eTN6Fp+c2KFinaW1YEYBa/Lfu4WKmMSbNMNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=NjV5ncn5buEhS839Hn7r/O9eIB2q4NKmZdroxWJuaSw=;
	b=gZAdUkDt5kzL8Z4vTw8CNcV5P5tH2h1pXpxNKOo80dLXj3UrTNrsqN3nIIsjzPCvD3oE
	 haNAjMxdXdxzWqavx1QvF5+PsgAyko8SaVMGQdXFRQP0IVIpqVWmyckQ5+K0RvJOj/k7n
	 n9lWwGRyuRDAdaeGbrDKREEZsK2RHLTQRJ0QF7+2eP0w2PRRhxAyjeMWiJ0IPxlHz9TUJ
	 kOBkcEDbDZECyAkRe8+R0xjOYao9R+AyNWY+EGRjh/sZXrvU6mqXD7rYbT5azsDUDvNhs
	 kPN3Et/uyv4bEwB3ZyS+3P++x72WV8rL0lycIRujFwDbRp9/uhF8kT+RtsQPfID2rog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795767944;
	bh=NjV5ncn5buEhS839Hn7r/O9eIB2q4NKmZdroxWJuaSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cza7a72aR8lUtV36tfjFvietMRiglBxPmVGAJzI0p/Fscdot+L6N/eyvDxirx1tmY
	 ZLDCqhl45qrEEsBftYXW35TN6ZeEN65r0iYk4op3r1qeDAyRNfSQTUuYMoP79wEMkX
	 qGGZMccgrEkOdArP0eCM3iUi2DnizbzAOtg574+CGEOaMrABt0EBzJ71mR3bSLCnYQ
	 nkCOH9UeN/FTCAYaePuHVY16q5RlHKXz51qA/8ancdpTkmDiFwjsv9cBEYcT9ZtETd
	 0EeWm9cJX889kyc+3g68mEOdLhVMvezrOPeNxXslxk5+pENHd8Gw9oUrgETHOVXWqn
	 HURsDyru4vgtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64A5D811AD;
	Fri, 27 Nov 2026 08:25:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 911ADD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7685A60AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFOfWYBnznx3 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 768A160A68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=csbmZAW4
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 768A160A68
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjV5ncn5buEhS839Hn7r/O9eIB2q4NKmZdroxWJuaSw=;
 b=csbmZAW4FfaN2JFu5quYTwgXqOdhKgnZ3RXf7OWDyq6HMHD1RzSxiDKVyEgsbn13PhhVSVeJl9rTMFodzCd1qHgcUerCnkuifKl3kLqsHOkjvVj3r27AGXSF6r9npUkzqKDWN2OiaoNwvYpVRswTm1tnx/9nwpUtl6f6gTFm364=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:25:35 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:25:35 +0000
Message-ID: <b2f9ec22-ab2b-4c36-b724-7213d712989b@amd.com>
Date: Fri, 27 Nov 2026 09:25:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: zynqmp_gqspi: Use the device's chip select
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20261104092111.3906459-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261104092111.3906459-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b291fe-1d6d-42c2-b850-08df4c6002d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261102123227099003|56012099006|11063799006|10067099003|261021121427099003|261021123027099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XeDoH7kuwnx+BtrZ1J4P0VcRmXXjD4WPMubhT5mF56dF4OxCybBW479FY1mTzwKUvBrRzGcF5adHgiFHyaeZhhN48nOmIpgs5zTRsYWBfRG5xz7gPB7MNw60/qJhiEOH1z8hYEZXk02MfOk0072oxDjeD6MFMpId1U9o+fQkaKugXPQcmRHfBCLFT+NpvccaewsS5FZFnYeWmcm9f2FlgASuDV9GD9h4jpsuH4Ci5ifEhbghjXOKhXz/O+63lMriWEjGHVzH/BIM0TzM/gGUHpzQuTjCL/V941S9eu83FgDmNNmYM+uIpdmnOFqKDuxfcJmM8gsWlz9mTlTG5NyrsZBglHHiXG7o4pv+pn+CIlGSzEpqDhU1X6fL1gPgSqJhy5SlSh4T4QdC213TiTARY0EPXI8cJBVZc6AddvQkn+SKoOYFs3qqpgyGQbx7RVX+TKbKPAKPQY3GMr/AuIHSV4v5Yvo55QmkcGJXezblzyGavtsqIBhbes9wSw4wi52fMQdeBXGPdDuN7agE6kC4pHNJiODRw4AU7T6i2b4idKXEOLLnmmqwwWuqoJXpMWksJ9jb5EoVoMt/7hOQ57pkC2THJB17AgLq7gz73pvfK2LJLnxGaUF3aFJo7hW68yFC+lFOauKf/Z3Fhz8lox1JHOYmmgNgfob51EtBqDwLn5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261102123227099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXc0YVBZSTIxTmx2dGxobWZ1V3Q3aDNScWV5SjBnNGVpbmNWNkF6dTF3UDc5?=
 =?utf-8?B?OENTRUdneEVkdmZiWDZaV25ObUlCYzNYUHhGbEUyUnJTVng2TVZuU0xXRkNl?=
 =?utf-8?B?d0ROR3Y1dXBwVUlQelZoVGVFUm9LU2tKN3VEY2sya1lSSEcwcW5ueEdBVGFW?=
 =?utf-8?B?Y2JUbmZCWkQxUlNIaGxPZ1VDc1JZNGZiemJidjE4RUIxMUdpa2VSbEgzMU1M?=
 =?utf-8?B?VnVxSjVYQUVTa0xDcDVTc0FibTVvbzF6TVRLMzBTZm9BeTMwUW9Xck1qNHln?=
 =?utf-8?B?ZDR0NzN3UE5FNXBWc2hrODVic3pybjlBRDg2dUNrbW1sbG9JTjFreWs1Y3Ns?=
 =?utf-8?B?ME9YWEE1QWZKRWNVeWRNUzUzZDdjL3FPejA4ZHhnL2FjbVI2TXg5eGJWcFNr?=
 =?utf-8?B?bFBPay9DcUZhTWRMNzZDNzFmbi9SLzh3YXg5SEh4cXcxb1ZWTVlmMUl4em9m?=
 =?utf-8?B?eGpxSEJhem5GbHl3RFZtY3NsWnIvYm5qLzI1OWNmc0xuaUtQSko0czBQdEdY?=
 =?utf-8?B?TWUramNrOEhmQzY0aTc2UlhiVS9KQnNmbnJTeC94SkFXaTZ5d3VPRHJPRkc4?=
 =?utf-8?B?YVhULzBiOXV1dFcxOThCYWNMMmRBZ2RJSEttTUFxdnYvT3pScTRnYm9xY1NP?=
 =?utf-8?B?V1BTcmlvaVEwVHhabFJFQ3Z5MDYzZ1dKcFhLYVBRaVpmQStJSjJOVlRIUFhl?=
 =?utf-8?B?QVIyM3pkYWdqSFVJOGJsSGVWdnVSaEdrdllneHc2MmVPV2E4N25NWW45eHdZ?=
 =?utf-8?B?UkxCcHJDT05HaTRpRnlFYUhLNWxVVTgzOVhpRzlGdzVUNlBLczR5TEFGS3Bn?=
 =?utf-8?B?VkNpTys1V2UySm1mbW82WFRHditydWhnVDdBMUpCbWJYd1JHckd4alBkUC9s?=
 =?utf-8?B?VkJwdStwK1ByeXNTTnhjR3ppTjhFaWRESjVQejlNd3VpZkduV2dyUHllT1Zr?=
 =?utf-8?B?MUNISHRwL1gyRlJNV3lRcmw5T0dpdzFxOFJ1ditHSVNVWVVSQUNTK0tOMXpy?=
 =?utf-8?B?OHlqRFJWclpORHJjVndkT3FEeVNlQW9leWx2ZytzZ1JpenV2ZFlFQ25RRlRt?=
 =?utf-8?B?K0dTa0ZPSjRMWGRFaGxxRmlwMGU5ZGwrK01yM0xNc0tMd2RvUWU4bE9PSFVH?=
 =?utf-8?B?RE9hRFA0MU9aS1FKZzByeE1EMndVenNDcERzUEpWbWJnQWw0cVRsYnZpY3cr?=
 =?utf-8?B?aTBOcC9xV3V4UnJhdVNCTWlBaFhmMWlRUTJ3QlM5N1pXRGtndUY0U29adTNi?=
 =?utf-8?B?bjRNY3Z5VFV2cmxLZWpPNU92SlpjWEJFWFU2RllXUWU5MWJSekZWMGorMThU?=
 =?utf-8?B?QUVLbG1weUdOcjByd0xpM3o1SEJ5UTBCSC9yWGdEelMyZkliWHo2L0NqSnRh?=
 =?utf-8?B?V0V3QlR6YlJrVXZMWUwrZnpobThtMEtFamp6S2pQRVcwL1ZYRVBWMWk5R0NZ?=
 =?utf-8?B?bi95aXN6cXpZa245MFVMTmE0VHFEYmVUMFRoYUkxV2UwZFFWWXRaclFERTla?=
 =?utf-8?B?UG42a0RmeFRmNFdxeDFaaHl0NUJ4ZmFCMlhHeHh1aEd6VVZmUERFYTdlK1ZN?=
 =?utf-8?B?d0M1VnF2TFdxK2hwZ0phaWtkRm5VcDhoVXdUTkF1OExxMFc5ZnQ0OVNJdG55?=
 =?utf-8?B?cmQ2dzhCRmZ5R0ZxbWZMNENhekpuN3pqVmNEV250N0lrUmZXVjhoTzZwemtE?=
 =?utf-8?B?SDNoMEtHQUdKV3d4MHk2Rld6cTg4cjZRVTJENFlOS2JzSHBhS0pUMW1qZEVV?=
 =?utf-8?B?SFZiVmJ3Ukl4VFhIYzFEUVZxc2hMQlJCaHREaTl5Y0pmL2lLUU03WFN0enZD?=
 =?utf-8?B?Z1pxeTVyelBTTXhQaVByWWhtdGMwek5CdWNiYkFnTkZRd1VHRXh3NXh1Q0Ey?=
 =?utf-8?B?RXQwOGNhSEJkY0pDN1RERGVvRlpPSWdpdm9wKzhpaHhhOE1jRjdaVE5vUG4x?=
 =?utf-8?B?YThkODdmVlBEOUJnT09rODVIVGMwQzM4LzJteHhkYzl4U0dzZURXYWRtZ09p?=
 =?utf-8?B?ZGRaY2VhN1ZWV1BtZVNEWVFnUWFsaE1DUFJqeldnd2phWmIrQTNmQU0xamNC?=
 =?utf-8?B?MVMzbDBSOFBFOHhqcHRUQkNvU0JyRUJpV29VVklRVlVCbEU1THN3TjN0STRJ?=
 =?utf-8?B?ZTZnc0VDSXIwaitQeUh5bTE1N2VUblloeVBoWjFTajE3djMwTnJVQ0QvaTln?=
 =?utf-8?B?d1V4Ni8yVXY0WTBCNFJkcnhHK2c0UnoyeEtuZ0RrQnRDUnpKbFRXTUNOZ3pY?=
 =?utf-8?B?a2lsWWFkUHlHbHh6K1RxTnlZNVRnQytRaENmUW1XcTI4ajhaR09WTGd6b0cz?=
 =?utf-8?Q?WPplGIzvnhd2unGmMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b291fe-1d6d-42c2-b850-08df4c6002d8
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:25:35.8848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2/7Gq0eur/xjg1QN19gySpcttw8Z4yBouyju7Jtgrw24nuUXywhKpLv10rUO1Jw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 10:21, Padmarao Begari wrote:
> When SPI_XFER_U_PAGE is not set, the driver always selects the lower
> chip select (CS0). spi-nor-core only sets SPI_XFER_U_PAGE for the upper
> half of a stacked-memories device, so a flash node with reg = <1> that
> is not stacked is always accessed on CS0. For example, on a board with
> two independent flashes, 'sf probe 0:1' or 'mtd read nor1 ...' accesses
> the flash on CS0 instead of CS1. The same happens when a partition on
> the second flash is part of an MTD concat device.
> 
> CS1 has never worked for a non-stacked device. Before
> commit 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support
> in GQSPI driver"), the driver always used the lower chip select, and
> the 'u_page = 0' default was added by that change.
> 
> Use spi_chip_select() to select the upper chip select when the device
> is on CS1. The controller only has a lower and an upper chip select, so
> any other value, including an error, selects the lower one. Stacked
> devices are not affected, as they still use SPI_XFER_U_PAGE.
> 
> Fixes: 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> - Send as a separate fix, rather than as part of the MTD virtual concat
>    series
> - Rewrite the subject and commit message to describe the general bug
> - Compare the chip select with 1 and add a comment
> 
>   drivers/spi/zynqmp_gqspi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> index f572f2b3f15..06de70de733 100644
> --- a/drivers/spi/zynqmp_gqspi.c
> +++ b/drivers/spi/zynqmp_gqspi.c
> @@ -878,10 +878,14 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
>   	priv->rx_buf = op->data.buf.in;
>   	priv->len = op->data.nbytes;
>   
> +	/*
> +	 * The controller only has a lower and an upper chip select, so use
> +	 * the upper one for the upper stacked page or a device on CS1.
> +	 */
>   	if (slave->flags & SPI_XFER_U_PAGE)
>   		priv->u_page = 1;
>   	else
> -		priv->u_page = 0;
> +		priv->u_page = spi_chip_select(slave->dev) == 1;
>   
>   	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
>   	    (slave->flags & GQSPI_SELECT_UPPER_CS))

applied.
M
