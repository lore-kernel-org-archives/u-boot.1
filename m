Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC11606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BAhFmemD;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=WCVWaJy8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BCBD4093B;
	Tue, 17 Nov 2026 16:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f30-cRF6c8lw; Tue, 17 Nov 2026 16:29:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79EB440908
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932998;
	b=adDLIiL3iqdiW+rrpNJlXV/C6YfqNh1IIERs0NeQf1HICJEpJK0xhzwbPIdy7ng2ueLz
	 HjZIPo4jrnvaALOlpLIMz/jGYbRYVbWneMJKhjK5NhuPavxSDV2WgPG7BIvDKgD1lj55k
	 6JqThle3ODIFbyr47C4MMi/7V2ZZNZk7NSjWL63dePNj+zKB6RruBau5ludVusWJN6M+o
	 lobGMZsv21fRr5ElA//KFxAw/CK3xr+TlFklmd/vYhYsxWIoUROkeilwxZuq6jSkVWfHG
	 zqLz41Uhlx/cq0AlGkpxk8o+s1plC2iaWVzOJ7ZRvJLjrJFSxURZZkXvYsenjXL9n7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932998;
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
	bh=rA9Y7dx7nmbvbzwCyY/Kupu4RidmRl5M5q1aIIWm4Vc=;
	b=J0FpQulIEooVn+TXHYQQJTKQbpyaql7GFMWLYWH/Vd4KPH9iNyg030/FHT1WPg8pbyBx
	 eB84p1jXz3OKHuV7uROAfsXdPQNil7e7CRaAFYinU64JvMDzdw/eAk7NHdI7ANeYef6K4
	 Gw6FAscpftkCFIeEtyd0Ow9BZOaz5DllsmED600d8gafoySmBZny3SSCvCVvodrrlUhje
	 Rse7dn80+ET4s9WRX5CLUPR6VDUkLc+gxuF39m6l4Z3/56PF0ZCu5rfug5czPESLALiUy
	 aUcFg9Y9DvpS1lfFKATAW0fUOOB2rccmwIdcQ+lKjYn50+DM3/tyGBLrIeJyjaPngqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794932998;
	bh=rA9Y7dx7nmbvbzwCyY/Kupu4RidmRl5M5q1aIIWm4Vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BAhFmemDx+1MpeVZfwIgwbnQT6Q24eRm3nOzc8H+tZxgM+Z+lMcXm4/45gbNaWnjw
	 A/KRildZrNxp7X98aCw40NRI0DGHXF1f7F2YLGYDIlXyz9YtLeGdn84NbscmoQ5Mup
	 VUOnqkUfeZk/AEtv2mXrk3hBEGQJ8L4Ir2fSyp8xPnj97/wNuQWcw8/izKstE+tDcR
	 p1FcYNgmwEviT82x1JB94A2aDVBe5cnCKboZB22Gexr5aBFpGrCdKlwp//7bRDrcMI
	 T5WaH3RCleDON1F6S+frej0VaHlfJI7I3VO33HEab4vD0bEqA4Jzsz1YxbUXH0v3Ox
	 6MBsuS3TRZYfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79EB440908;
	Tue, 17 Nov 2026 16:29:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DEF83105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC93E60782
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HM4MI7n9HcBP for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:29:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EECD60729
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=WCVWaJy8
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EECD60729
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA9Y7dx7nmbvbzwCyY/Kupu4RidmRl5M5q1aIIWm4Vc=;
 b=WCVWaJy8dWhQT3lqRfdTz7RqJ9jMw6Qfor1BNhGOGK39JXCVO9jULqrBXKj0Ht9XUVrrpR9suNGTtgonTqBNiWQhsfVPxMpaIXNgH7p3fe+M6zSpA3wg75ooXRyT0+yt2jyz68OoPsF1XBS9D32rhi8RwjNqk3AUK+XmoZtSBPU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:28:10 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 16:28:09 +0000
Message-ID: <469c26c9-c2cb-4007-abf9-5fdf5ea0acde@cherry.de>
Date: Tue, 17 Nov 2026 17:28:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ram: rockchip: improve sdram type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-1-fe9fb30a3169@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-ddr-multi-v3-1-fe9fb30a3169@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000013F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::889) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9712b3be-d110-4950-2f92-08df44c7c47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003|261026121527099003|261026140227099003|261102123227099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: uPLWTSZ00CxTHr6JHVAQDModvkEpqqcgvs+PxIRGu/8+UT2gk68XZzPuvP5HgZNv2L4ax3m8tAL3BbRQrmPx+99W5+TfshP/BLK/PKsUvsRJnJyv+tSIPZW+t2Uusf2THJ9+AX7GevVklQlBdHeB3i76g8Sf1bsRxcLcCwEkE2D5GLEKmfc/fMN80grAOuI211DoUFbkBQRxdckajo38QSYed1QesER/nWDOwFE1acc3eS+quPEci5iuLGYNkd33ziWOOLe4L9qCfL7T+YD4mQl7vBbBhG/cQQ/M/8vKDW5Usbyjv844zEaRB+T7Oovz7AqYELYV/oFkHGc9DrpdHvQdDghLP816m9RcNYCPEa9Ce2mIvwR6TxHLIFSIHjeD3ovobhoSDTb8Jn2n0Hgjvh/adJCN/VLr80JHeu7rtCgdeGDQ5eELOhxKyE+E6FmDfdwbOCViB0IDEIDd0Du4rYfgDVFJG2opjeAe8QFeYeE9ts6ULjvfVDiN5a6U/v3FGRDSLDxPYsdbhfUAx2b0FXsE7zkDXDoMlEn/eQ6Eq4icFBIWTkvY9RcSf+uqIRudeDmQVE9+kfYQGsnyHdVlK4Bltbh0ICbf+MZ57VY/CNnVVul88Jq4hXQc35GIdIoY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVvZnZZSE1XK1NVbnRRTm1lOFlEcWsxOXpROFk3QU5UeEZEMDM4UEk5ZXd2?=
 =?utf-8?B?dUc5MjJWMVE3WWx1UHNwOHBKenZkZkZSRFhhaEE4bmh2d09NZXd6TEg1MzVz?=
 =?utf-8?B?MWhlR1pkUzYySHh6SG41R3pzV2ZSbFhHQkFQbmg0cnFOR2FwNE9GV1o1VzZO?=
 =?utf-8?B?bk82QklEa2o1QzVtaEJVSkdnc3ljTzJ0aDR5QTczZ0U2aURvNVlxN0dFcGxi?=
 =?utf-8?B?dkhkd3VhQ1lKMXNSbWpkN29TYml6eUh3UXRoLzcvNjR2Qkl4K3ByUG1lZlhZ?=
 =?utf-8?B?T2NIaFFGSHZUSjBBR2dEbGQ3NDRiUWZKNldGVkJteGlBREVMVmFEd2dWYWl3?=
 =?utf-8?B?R0V1b2RIa1I2aE5WbHpJTnRMTFI5UXp2b01yVE12VUxMekFzZDVlNkxpS0Jn?=
 =?utf-8?B?NkYxWmNyanZyaHRYd0poNzlJRWFUencwV3NYM2hvNmhCK2pnbUNBUlVIQk9U?=
 =?utf-8?B?eURZcjYrTWd3WHkwU0dsMHZGaUQySlQyU3pOSytVYk9HazExY3B1LzY5RUQx?=
 =?utf-8?B?WUQyT0JTcHdZaGZsYkV0d0FLa29ZekNJSG9Cby9xN3RDSjIwMlU4SjJCRlpU?=
 =?utf-8?B?anplOG1OR1NUM1ZiYVVrbURaQ29pVkRRd3FEK3V1aWh6ckFtNWU1dmVhdUQ2?=
 =?utf-8?B?bFF3Z3BtUmFTeGtEaGFyMktVQzRIME9UWWVGdnNIdkR3OC9SUWdkL0hESHZw?=
 =?utf-8?B?YjNUQUk2ZE5CRUVTbGJzZ2hSeE5hSWlvUTlCdlFXNjdFbWhOWFUyN01BbkZV?=
 =?utf-8?B?dnVaRTBnc3hLaFRuaTh4QlhuTm14ZVJPTFFIUkVFRlhNTmpCQ1U5UmFUQ1Jo?=
 =?utf-8?B?TjZDRFpPRjV6cE1RQ0p0VVJvRDEreTZJY2YvYmQwMGFrVVE4MDRUQWd1aDZR?=
 =?utf-8?B?NnZ4ZVUwanVxbkFRUHoyU1h5RHFZYzNVNDBnQXRxU1h4RTR2Z0NuSXZOdjB0?=
 =?utf-8?B?Zis1T3FFRUliOHZoeHF5ZWdmbW9XOFV3UEcraG54Y2xlRkc4SmZuRUlRRUdn?=
 =?utf-8?B?d2N1YThSTmM3dGoyZVllRlhvS1RlZmxWUnhLcnNySUlxeURiWmtiWG0vMzQ4?=
 =?utf-8?B?YlZrcVhlcUkyVDlZZWNaSTY4Um84cTN6SXpRM21xUzBmKzI4UEVIamFpb0Jw?=
 =?utf-8?B?ZFBDaWRXUkFCUFNBVGxGUDBXSDF0M0owTTJtV3c2cWFGSDM2SVByZWxuZTNI?=
 =?utf-8?B?ZjdmL09ISWN3a1huaDBLUkQwanRnVkhRYjR0TFlWMHZDWEw0Nlc3RjA4eHZH?=
 =?utf-8?B?VjZBeXNYRlJtc1lzNHFmZjB2M0c3dEl4SktYTTJtSTBPcEM2SUx1ZGtrcUlG?=
 =?utf-8?B?S1R1Vm8wbmZIQVNubStUS0NWZW82MzVUN3R6WUhlMTlBSnNrNDhhRE4vNk9p?=
 =?utf-8?B?Q2Nua1NJd3I2cUdydmM2eGZ1ckJUV1EyOGlxdGZsSUdSbzBNaTJZZll2cDZu?=
 =?utf-8?B?VitnRXlISHhUV1NsVm1xWm9oQnRQTVd1ZFY1VUlUREIwK0tXYlM2ZEMyUVI0?=
 =?utf-8?B?TG9uQkp3TGppU2d5UjBxaGlyeHhLTFF0bmtmYVdFSzlva2R0aTFPZndHUDZ5?=
 =?utf-8?B?Q1NBNkF3enJkRVFoZjNCZ2RTUktRLzJSaU1iOWluMTlFM0lkK29GWGtjbTBj?=
 =?utf-8?B?SVpweFdBWGxjdHJ5Tk9VaHhTVTNXNmd0MWJ5NzE1YWQzSUVKZzQ4aDdZSFJq?=
 =?utf-8?B?cVZHZFFFcW5haVQ3dUkrcHV3OW9GK2djYk4yNUdzd0I4WjVxMmNBSUVkZFFw?=
 =?utf-8?B?YWs2Y0xMRFFvbUlZbkIwaTNHZE1XK2JxQjgwZ2dVU3ZjTDFnT2ZSRS9Nd3Bz?=
 =?utf-8?B?dVVLOTg4eDJxWVhnaUdEWFA2Uk02UGprZmg5TmdwUm5HaTRPMU9rWEZkcFBT?=
 =?utf-8?B?ci9rV2JTK2YwQnI0eHMwTEpscHF3eFJWWlRLbUtmeVlnSVM4YkRpTkFINXpH?=
 =?utf-8?B?VVJ5Vng3V01vRk5QaWlaN21qTWQzTHVuOStnTDIxaDdTeU9iNDBtY0x0U0Zo?=
 =?utf-8?B?bnBSQUpXK2hlcGs2QXJlend0UjJIWDlZZjVqR2FOVE9kZHhsQUpnaGFjSnZ0?=
 =?utf-8?B?TGpUZFpwZ1BNck1xclJUSmxFMDUzeWF4bGwvK3RGMzJGcjZCaXNKdjgybTZM?=
 =?utf-8?B?YkpGd3dseGJrVnRMMG1nRktVYUtrSWU0RklmY3kzaWVBM1Npa3dwWGx1cjdZ?=
 =?utf-8?B?eDVnRkJNS2plSTl6UkpwWUZ1d0h3c1VDSW0zZ0xSTUNQQWhaT2h3cVVZUVlv?=
 =?utf-8?B?ZmxDeWd3UU1zMnplZWU0N3hqNG1CRHMwUmRmT255d0JoU00yNzRISXErRGli?=
 =?utf-8?B?QjAwcGNJQzJSL3hBZVlWZlZGcHdIWTA3YVlCdW5kUnFleCs1YXl0QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9712b3be-d110-4950-2f92-08df44c7c47f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:28:09.8133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0G55dy0v2NlBKGxQaejCFU4ms4aJpz06d8Fdy6CZOb7gkyEgmsW2t1GaAuAppOqMFl/EOc4i4NSdWwaPsTlKSwo29X4PW0rshHTszofcdv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> Not all the SDRAM types configuration options named in the Kconfig
> are supported by each of the Rockchip SoCs: improve clarity adding
> SoC dependencies to the options.
> 

Considering what I said[1], I'm wondering if we shouldn't simply report 
what the driver (seems to) supports even if it doesn't actually use 
#ifdefery and the symbol state has no impact on what will make it into 
the final binary. I haven't decided yet, so this is an open question 
rather than a suggestion, and this applies to the "thought: " comments 
below.

[1] 
https://lore.kernel.org/u-boot/9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net/

> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/Kconfig | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index d707d09c1c8..74422947452 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -26,26 +26,26 @@ config RAM_ROCKCHIP_DEBUG
>   
>   config RAM_ROCKCHIP_DDR4
>   	bool "DDR4 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126

thought: add ROCKCHIP_RK3328?

>   	help
> -	  This enables DDR4 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable DDR4 sdram support on Rockchip SoCs.
>   
>   config RAM_ROCKCHIP_LPDDR2
>   	bool "LPDDR2 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30

thought: add ROCKCHIP_RK322X?

>   	help
> -	  This enables LPDDR2 sdram support instead of the default DDR3 support
> -	  on Rockchip SoCs.
> +	  Enable LPDDR2 sdram support on Rockchip SoCs.
>   
>   config RAM_ROCKCHIP_LPDDR3
>   	bool "LPDDR3 support for Rockchip SoCs"
> +	depends on ROCKCHIP_PX30

thought: add ROCKCHIP_RK3066 || ROCKCHIP_RK3188 || ROCKCHIP_RK322X || 
ROCKCHIP_RK3288 || ROCKCHIP_RK3328 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Please remove the Reviewed-by if there's a v4 and we decide to go for 
more SoCs in the depends part of the Kconfig symbol, thanks!

Quentin
