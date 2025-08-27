Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C69C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C81831BE;
	Wed, 27 Aug 2025 09:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="tuan0+Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70B6831C6; Wed, 27 Aug 2025 09:42:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 120E98319C
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCyekapzGOnJ1NsOELjf7iVicgpaj/+Nu2G1GbNX1Yinf6Vbf8fyhK9sgcRzjkuQ6exEC/nocaNgZayVjkJuN/Lk7s/8UmymE4KcrzEZReuhxvQ7a1+y9zHpAUVPnURwnhEO8qQVpzWo9Hein6EPbpkV4+c/kdwE6R4Q0ceN346by44OpUYTDL4kEUwp18FG0A/x70AAC/+IDlM/yy8Gn89GgxUSBMsp+lTrbwaRk77RyE2Y4Lq+lMGpwa0U1kED9WXlrUUU+0xdtK9LfvuLKEbF+PQl09+4BUSZ6GrjLhQW0vX00pTFdqD1Zc+301qW3nF8b43OV+oYvq3noOE6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVRxkZxzmSzPj3flm53DltQ6a31MFjoKKXA8ZvauU6I=;
 b=IwS43RbAhbhFlbqtgiJ2/UqbzU+v7qklHXDpTg8RBDSXym2bezTjXy0LaN8cAmCxxepusrb3/x1h/B2HPIgqs6aY9S/XAwe0xlywsBp4aW9/XULe4/Pu+lYicTTcd/7afaxoxms+j4V6lQeRklIUOIiubFX0c6PzWkr1XOolGDrMej5Zeej9B2nI9F3+CVH7DRHXhOXJFKm40mD1SSROSbI9wOiEv/Jze5u7c2BcazGIi1qVbS8b4QaDaD0sz+ccJYuQptn8Xo4xYDFmnpDIqoXdFgN1DAdU0BMMJboKRhtHja/RYrRH9/T7ccBZRbZUyqKvTYmFGrxMwk2yUX2KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVRxkZxzmSzPj3flm53DltQ6a31MFjoKKXA8ZvauU6I=;
 b=tuan0+JbiTrVOAmknLAJ8cyDdVRTEN4/xfbrrLGdcCy046SaYoTnIUOHvBfXSxssF5VC0KXZhY37R8sxyU+YoTDJ/VKQhWcgezyoQ1G2kapbDinImWGAXldxXri+LWvJHukaI26HBpsDO1B+tfjifAlEcofrJxwCUU10B2UZdonPedG01z3pgmXH87aJd9NAYXoOumrBdp+IofqeyGd5eMyfQ0Mo9+t43Jr2nESfCXdC5iGs2ZCwd1vjxifLZYIhhx/L8CIvXlwGvzzWbSw/Gip712kZHvmR2i49AAPa6taLF1W6E4AB8/inw9xd3wOt5Zv1TtrgCVfZYfETC9E1Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAVPR10MB6939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:42:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:42:07 +0000
Message-ID: <d7783159-1872-466f-ad05-f76965236b00@kontron.de>
Date: Wed, 27 Aug 2025 09:42:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] power: regulator: lp873x: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-1-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-1-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAVPR10MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2813847a-b19e-4552-3daa-08dde53d3919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDVsSE5seFB6WlBYVjArY2l3dVdtMjBwczJPUU9VOEhuK3NzcXJha0d2S2Ir?=
 =?utf-8?B?RGhwd1U2QVNoRjdmUit5bE92Uml1alB5ZFIzY1ZWNWVjUEM1VmZpUWhoMktJ?=
 =?utf-8?B?SGdHdmQweTFSdCsrVCtkL3ArTWppU1dkZmVxeUlKUmszSHVSQXBmZjJoVUVX?=
 =?utf-8?B?Z0REWWI3Rm9CclBrdXMyS21VZC9oanFrdUFOdGl3N1BNNkdkY3hUOVZ3WXhY?=
 =?utf-8?B?ZGtHYmVjalFVU1ZuSGw0U0o0M2hTSW5ndU5FZklpWEpobEY3RmlCaWV0WHE3?=
 =?utf-8?B?Y29jazdpQnJEeDljTFE2dkRHQUJOS3FrTjVoUDloMnRpTk1EV0sraUZlYjlo?=
 =?utf-8?B?RlllWXJocHBHc3FWbElEUHlLdjdWLzlWY2V1ZzJaVm5rWnZ3bE9iV1Awa3V3?=
 =?utf-8?B?ZFNMdmZVZW5ScmtDM3VUZXRBQVVYRnNNS2doTSttcHF4L3NlYzFITnlzZTNC?=
 =?utf-8?B?QWJOU0pqVEtWck10bURMK1hqV21MYzVmN21hdnhNQ3hlOENRT0RGRHlPU1RU?=
 =?utf-8?B?dTUwMHdyOFlWV1BKOXNjVC9qL0Npc1RLcWJoQ1NEZTB3bHZ3L254TVpqSnVZ?=
 =?utf-8?B?aUJZdWNVaDVkMHVzcEEya3g2Z1FWUEhRQWVtUDA2MjRDa25QSmdPVFUzMjMw?=
 =?utf-8?B?Z0szM25OZlpvRE1wM1ZlWW5IcTNtUHIwMWFCdy9HL1hwdmp2NjBjNWN5emI5?=
 =?utf-8?B?UVFUWTgxYUpRd3NhZXNOZEI1cDhobVlQNmJoZ1BZd1dNaEVGd2VydFFHVWhl?=
 =?utf-8?B?WHp5aVpGNFhIUkxtVjhHM3pyV1RTNDZ2WWt1U3VTei9BbjJPdTUvMWpNbUdt?=
 =?utf-8?B?b25BVGpvNjRJc0xYdVI4UHlLQW5TRlpOY2pPaTg0SWU5R0sxSG4wblRqTExJ?=
 =?utf-8?B?c1pzeFVUTzE0cnRxa0hVM1ZUNlJGUjd1dWNseEJ0eXhMU0ljR0xwekN0dnlt?=
 =?utf-8?B?bzBwZTlyaFBMZkNWZWZCbnN5THVtb21IQ0h2bmgycDVZenp4Y1NOWS8vS1Ay?=
 =?utf-8?B?a0hUUDNTYzd5N1lsZGY1UG0xa1I0NjF5UjFYRDBLNHVqbUJqcENGODh2NnJo?=
 =?utf-8?B?S3NMclY1LzFYSlplT0tPTW9sa3VyaDdVU2VtRHFlaFpwbzRZYzhBVVhidDVX?=
 =?utf-8?B?ZU9kN0VTb2ovL1NmT2Mwbmc3RVRCSVh0eXR5RnB2enZzeVBJdjREN2tTOURD?=
 =?utf-8?B?RGFkTDZRbGhsSkw0YVVFKzJEL3B6RUVCNzRiSFNGZnpjSTlNNjI3VUo0cWV4?=
 =?utf-8?B?akpkdWJiakZURUN6WUgxZ2RXNjJQK0ZhVW5XWEJ1VlVQTmgxL0o4aG9LWTVr?=
 =?utf-8?B?dy9DM2VLWnFRT3FsWnQ1TWpqNmZmaUlqWTlQVEJjZkVFY01vQ29oVUttc1dE?=
 =?utf-8?B?cDAzTXltRU5NOUVINWhUdm1TeCtLN3RkanJ2aElVWFAvT3A5Z2VWZEY1QWRE?=
 =?utf-8?B?QnJFZEd1RkxPeEg4WDBCMWc1d2QyWHpYM2JjTktGSnMxL3o4bXd3VDZqN0ti?=
 =?utf-8?B?THNwTHN4MXpPT2FpMTVrRnFTSmw0ZVhMWTlkcWFKd1BlZXV1WnNJU1VRSStU?=
 =?utf-8?B?cis1OEVkd29LZWQvRStteE5kL25BaG81VWc2U0xYK04rYVlZWHVwalphK3hq?=
 =?utf-8?B?WHpQci9rUVRKUThvUXBpZXl1N052TkxUeGtoNnExS1pNb2tab0dTRmdLa0JY?=
 =?utf-8?B?ME9ueGlBdlBxc0dFYzlGaVhHbXZ2alJjc3VsSmlZbU9zWTh5MCt6bGdpbFk2?=
 =?utf-8?B?QUJIVkkwdkZxV1h3Szd2QXdpYTdCeFJZZnVOWnIrWG50OTVKeU4vZS9kRzZI?=
 =?utf-8?B?Z1NybEJMM3NNNE85WDNYTS9SN1p6bEtWZ1paS2JsYWN1QU14bkVNNXVqeG1Z?=
 =?utf-8?B?WHYwODJTdkdFaktPS2tWNkI4STFxZUJmWjNJc1hxemZTNkpMMXIrWFI4UnFu?=
 =?utf-8?Q?Yz+1ETMBHVU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk10dXJpYTVMSko3RmZvQjdLUlhFeTF4QVlQZXhnQ0xRdW1HaXBoZHg2bysr?=
 =?utf-8?B?TitvZThscHkwUnFCT0FiKzUwb2NiRUtySDF1L2RMQTF0bzd5NzFWeW5WSzR3?=
 =?utf-8?B?dTNKYXlWMkdoTnNOSWt2c3pyNU9QODk5cU1KTlFyZXgwL0VJQmc2SGx5RkFq?=
 =?utf-8?B?aW9xY0dNcjFwalMwSS9xZEJtY2V5SHBJTDVZcDAyby9Ga2ZpN0FMNzBCeXJV?=
 =?utf-8?B?M0FoTXI2RU1HbVhJQjFhblMxeVQzT3RZUHhMb2NWaFBmWkI5Qko4WHZVWGhn?=
 =?utf-8?B?OFg3b00xZFc4Tys2clhtMzFvUDVjczduTnYrY2tlRDJicHJndzFZMnE3RVZK?=
 =?utf-8?B?bkJLa3lZY3Qra016eWk0Q3VSc21YRVhGUlNjWlU3UzdpSlhVQjA4UmY0Nkwv?=
 =?utf-8?B?VTh1Y0M5eDFhN3Bubkc5UXQ0a0ZyNzJuOEdTTzEyS2V3OG9aTloxK1FoTHlY?=
 =?utf-8?B?MUdpdFlISDZGMGl2b1lqS2ZUNzR6OHhXUWtGcmJqVDQwWk54OXNuV2RDbmlD?=
 =?utf-8?B?c1dSWC9xT1RRR1I5TmVrWmVGSkFVWXFJcUVxWVhZT01uTUJKc2IvTGpNdnlr?=
 =?utf-8?B?T1BiallHZ3Znc004ektBc3g5QWo2c29DbUZQM2RsVEVUVW1Mam1yNDdNVmhq?=
 =?utf-8?B?a1EwWGIvQUIrVklRVkxsZ3Y3QlM5bXFYaTMrU1VzQXFsSmkwYzRYamNvTzhk?=
 =?utf-8?B?cnFTZUMyTGJKMTIwbFFMak03WXhLbzhFdUJrYklnVExDR3FiMFBmd0Yvbzlx?=
 =?utf-8?B?K3RWRGRGOXM5Y1IwU244TWVCRzBxdlpBUlRwdHVyUzhVcDlHWm5wY204V0JY?=
 =?utf-8?B?VitFZ0VZTkdSdzZyVmg5ZE45MDNGOGhvOGZNSmdEeGVnMWFscHVETnBoSHcy?=
 =?utf-8?B?RkxmRVc2WlRDM3ZyKzZXQzBrMi9GRVpPM1ZBU2tzWWtiaG12NTZiL005TGNG?=
 =?utf-8?B?d2pMdllhQUs3NDFJWjF5VjNCdld3d1NvUUNENUNBWHpvOWFIOGZmL1oveE1t?=
 =?utf-8?B?a01DQ0lJNEh1bUdqVlp6dTVrbHVNY1EwNW8wQVFlYmxxQ3phcmp5dzF1L2VL?=
 =?utf-8?B?eWtIOFc2L200TjBmcDAwamplU0tBMm15WGVXQ2l1M3RrOUU2QWdyMGhpOStl?=
 =?utf-8?B?akVDelNHbnZITnpNLzh6SzVVSE9vaFhhNEVFSGh6TkRlVHhDc3MvZTBmZEx1?=
 =?utf-8?B?dzFjSFBvWWE5TGhUWlF5ekJOaUZDUTkxUXc1T1Fqd1VIMTAwTkJPUzFoV0VI?=
 =?utf-8?B?QmxnTmhsdk5GcXFEV08xcXJ3UDhpb1FVR0haeE54NkVmSlhPaWZaaC9vcW80?=
 =?utf-8?B?d3dhOUVHYWRJWmRMVmNPbzhZNXpITi9yQkhmZFZIbGw5aDdSd1J5d05tNi9r?=
 =?utf-8?B?OGRxeGZ2djN3OUFUT1UxdHYxTDVGOEtaMHpuMTVqNDRyb2FtK0ZwM1c0SWJn?=
 =?utf-8?B?VndpaGc3U08xN2RuZGVBMjVwUEd3UzlzL0tIMnN5MktwaDJmMWFvVDlNbjRa?=
 =?utf-8?B?cGFvR2N4cXREZHhjcktCVUpFNG53OGZndVdzMER5NXRRTjVpdmZxRmluWUdS?=
 =?utf-8?B?bEgwVTIyMk9jUHVSb09TYkV5T3JETkludG1EVHV0czRKbXdob24wWFhKSk40?=
 =?utf-8?B?bnY0TE5mcWRaOFN0UnF3aSsxUWgzVUs1WFVXS1lCeEFwclJueUo1NFVxREdB?=
 =?utf-8?B?ZzN0TFBoSzdFSEh6SGNsaW11QWhhSFM4OUxnNFZQcFdDaHk4b09ldFZTVkpp?=
 =?utf-8?B?bllpRFZyWnc4VU1jZTRtay9nN3JKZStJVkJ6ZU9zcnQ4SFpYQnBHQmFnSTBO?=
 =?utf-8?B?SGN0T3hPYmxmM0ZLajR2TFRuSXN0UkZGVE1OT2sxU1ZtRWFLc25mWUIyRHVw?=
 =?utf-8?B?S25ENkh3MURUcFFjcHBaUGRQRm9LK2xVRVRldVpYWlA0anZrSit1SnRselVN?=
 =?utf-8?B?MVNGK3RDTVNkQXZNQ01oMzEvVUdjc25VZUpJVlhSUlI2SXN4dFlReFRIMkl2?=
 =?utf-8?B?K2MxeGIzSVM0cnZHYUNyWWQxMlFxdVlQUytyWXE2NTRUa3hDOFFOZHd4UXZF?=
 =?utf-8?B?K2NFUVB4amM4Z3JTUWIrdG0xazNGNjh5NE4vSENGTXRjREFDeHkyQkUwRitP?=
 =?utf-8?B?Rm8vTXI5eDdZM1RuZUpDNllHbFU5YW9MRnA3Y3g3cUU3R2JIZTM5L25DK2xv?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2813847a-b19e-4552-3daa-08dde53d3919
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:42:07.2025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsXgUTCDdZTpV0+4v6zDtaE5ErqURc741PEkK+Un/cwU7l/MTlu9oKnHlJlSzgWEDpTLLhfvk2qY+nh90SVf3kGuK/9cGnberVAuhfPNESU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6939
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

Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> In lp873x_buck_val and lp873x_ldo_val hex is an unsigned variable being
> assigned the return value from a function that returns int. Change hex
> to be an int so that the following test for an error as a negative value
> will work as expected.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
