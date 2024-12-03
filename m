Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6FCE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D68A896D2;
	Tue,  3 Dec 2024 20:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=carallon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=carallon.onmicrosoft.com header.i=@carallon.onmicrosoft.com header.b="bo4h8s2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B143894AE; Tue,  3 Dec 2024 15:45:42 +0100 (CET)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018F488E7B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=carallon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rufus.segar@carallon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbm09v7cgI89UfP2D7rB8Zgkz4J7T6jFazMvhpWSDc0FLcAWuLgeps4cHjIwnZfJ5/VpjTEERQ8GpQhlpXQZbLFP7zERJo/1DT8puPgdIcj6bsjA3iWkRc75gthZdn1HUnybe2EN//+xalKMkDb8uiqLSqWFVvoTKV3WNZ5NzuvwJcpZv+7BPvMmAg7TVyyvfHLsveY0z3+9KiBHK3bhwUB3+TZpC3GfY6dH3mU7R4hyT8Bb4CaL5EwynEdHp5jBjXiY9pniChN77F+nlSEYP2orWYQBz3xR+wycqkOE+3QSv1fV6Wl3vBQ6NVZtoERtxJrBQ+vYGg2nPYljxsggmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSK3/8Ia9cU7AOeJR6gpsxme+zfrxl7S3Rw6gdkEp1Y=;
 b=LtTpC9gWWpg5TAZJIOgFMjrjUXqOetK/RJUw9Hr9E3qFk4aAwoe62RlA/TqKyl5ZMmTnRMUcwE/hjjGjRKR159BDXPjsVZ3eZ9B3Xm37gwYO8yN/0W8w7+M78guf9XRZ63xFQXczcmC5oWWkUEiyl3UtBlWL51C9jzLtC5wczHIY640JHQepDIPaHogw0bqK65ERWCSi4of5QsH7oecmIqXfwzEAQXJ+Nxxnz/+AzVrVpmnrlbSz/FGzPkBfdFdeR74Dz4fkGmbT/CbLNptjG+g96eJqnUdCYnUxiBkNAaSHPvWVjmtOt4EKluY3RoCMzgz91q17FJIf5t8IqKbeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=carallon.com; dmarc=pass action=none header.from=carallon.com;
 dkim=pass header.d=carallon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=carallon.onmicrosoft.com; s=selector2-carallon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSK3/8Ia9cU7AOeJR6gpsxme+zfrxl7S3Rw6gdkEp1Y=;
 b=bo4h8s2GI/Tkngf8gFcHcayFcRgkDDzLSRJI9U8X6Aq1sb0CEM/Wglkd/C0jte8L0wnlL92kiaXsspSCHkwvCbN/g+NjIR5ZTtKQMLvEAVWxLeiascph53S9ojN9x0IehT2SDC0zHBVEOzWeYUOjKl343XuJSpMWaPuDgNInB64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=carallon.com;
Received: from LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:325::9)
 by CWXP265MB5651.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:45:37 +0000
Received: from LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 ([fe80::28cc:cdce:8d07:84c4]) by LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 ([fe80::28cc:cdce:8d07:84c4%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:45:37 +0000
Message-ID: <7b204be7-53e8-401d-bed3-f47a3e23bd1d@carallon.com>
Date: Tue, 3 Dec 2024 14:45:36 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Mario Six <mario.six@gdsys.cc>, Phil Edworthy <PHIL.EDWORTHY@renesas.com>
From: Rufus Segar <rufus.segar@carallon.com>
Subject: [PATCH] Revert "net: phy: marvell 88e151x: Fix handling of bare RGMII
 interface type"
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:325::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P265MB6811:EE_|CWXP265MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: cccb64f6-5b6e-4a79-b0f6-08dd13a9265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJZNGI5SXpEWFk5RkZDRGJIKyswbERJQkhwNElvSmZCbVEwMlh3SzV2UCtL?=
 =?utf-8?B?QXlEZzgxOXVVRnRmNUw2TEs2dGRHKzRvMEZ4dVJlSVhkQzBCUHR1L3FNY2Zw?=
 =?utf-8?B?bEk2RXFEVTF0R1YyaU5xZ0RweWpXb0dLbVJOVEdTalhrQmpPaGRuNE5xVkpo?=
 =?utf-8?B?MXNscThKKzhzeDczYW1BM1B6ZnByYm9oSjd1b2R3OUhmei9mZ0RvS1dUUTRn?=
 =?utf-8?B?cjBXSFpxNGtMZDczTklGNHdyVzZFUmp5aVQ1OXJ4cG84MWZ5OXo2UlE4TWVC?=
 =?utf-8?B?ZUIzU1B5cnpLcGJCeThnTDB4OUtXSzROZE5SWkV2K3hlY2o1UDF5YkRJaUo0?=
 =?utf-8?B?ZEV6aUJRTUJna2VDNjAyOEFSUkNITlpZb0NZMWlTMHMyK0lSQzlYMFJvUURJ?=
 =?utf-8?B?TlJscmpvQlgwUXc5b3FNWDVPeHcvTS9hamEyVWZpMURiYXo1WjRyZ0dFcGVh?=
 =?utf-8?B?NlNoVVB2b1R6dWp5bkp3dnhPZmloQzliYnZUL1JORkRkeTh0Q2RoZi8xZEJ2?=
 =?utf-8?B?NXJzZWpFbWRrZEZodmVnM2QwekJ2aWJ4MGM2SXpRS0JhWXI0UC9TWEhKc3dl?=
 =?utf-8?B?RUEvd1JSODNLYVZKTm4xOTludThrTnlJb1lkdHI1SmM0T3N4ajEvWk9id3Yr?=
 =?utf-8?B?MnovWXVQN2tRd2xMMFMrNDUxanVkN04zbnRXdjdGVjVMb0w0UmZjVUcwVDlD?=
 =?utf-8?B?SXFTL05nTGlISGFJWWZPUklNSjVySXVDNnZzalYvMENkMHRwY0ZoM2syNS95?=
 =?utf-8?B?ZWhBYmZ5ejc4bDdOWHJIem4yTE93K3IwVWpGUGlZUE1mWC9hRmltVm82b1Z3?=
 =?utf-8?B?bnJ4QnF3R2lmOFdjUm5ZSEwxU09KVi9PcU5QY0pyMVNUQzBHckJVREx5V2Ra?=
 =?utf-8?B?YWgzcEhvZFJqWXVMVFI3QlBiR0F6N1Mvcmx6d3JKOGtwcDFFb3RTRTFsWmFu?=
 =?utf-8?B?ano2MVJsS0JKbHhRT2VERGpXem53QmNFTEs4bXRBYjhsZzVwVFcrR3lITmpr?=
 =?utf-8?B?K0cvdDY1TU5JbXlqSVhxL1JLV0RhZmJibWVFWlJXWTZnZEVWVDh0VXZWUkhB?=
 =?utf-8?B?eXQ5SEFuUkdkTUZzMWNSNEE4TkkyU1BwRGFCaWRURFhJM0V0azdZV1AyQmdq?=
 =?utf-8?B?bkd5NVRBOExFN0lPL0I4U1ZLY2lvQzI0d1B0WTBtWmM0NGNHZmVBa3BSMHQ4?=
 =?utf-8?B?Q0pSRHM0a0VCcHlKZ2t5NVg1by96UnF0SkdCTUM3RWphTk1oZFFodnlrY3Yr?=
 =?utf-8?B?ZkxjNmhGcDhXQ3ZmZ3phMkpMWWFoZUY3NGptT1RmenJIRmplUDFuUC9VQlpl?=
 =?utf-8?B?NmtXV2FlczVHemVkbkNya1VaZFd2UVJ3MFNTMlNhWXkzLyszcHlaQjU3V0F6?=
 =?utf-8?B?TGhyeGdrdENjNm93MGY4NHc4Q2NkVDRGcTFVRlZPeTh2Tm43MXcveWJydEtL?=
 =?utf-8?B?ay8vcGc3ZXNqYnRRTEhrbWlLUUQramFiMGczOTBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1h2OXhjam05Mk5FVmZmSGxBQXpwcXpoUlM0c2xuUW1vZmhiZWRBYVpXWHE3?=
 =?utf-8?B?bWUxS2hQekp2dTBhbXNzWTZHajhBSGVzZ1g4M3dhTmlZWDlMN1ZYcWREbjZX?=
 =?utf-8?B?WlJYd1VuSkJGRmNGbWp2OW9IOVdlSHNWT3dXd2pJZnZFalZJOTFabmI1Y2pr?=
 =?utf-8?B?QnRQblU2eG1EWGJWdTBJRUFYdFBxaEtFSzN3MEJFOHk4enFvRzlnWkZQSmZM?=
 =?utf-8?B?Vkd6eWU3YUpzYW9MaTRpdktrRlVpWFJOQWlsUXJ0MnVTUmYrSy9kNG1rZzJy?=
 =?utf-8?B?T1NJblQ0OHZ1Qy9UM0RKTjRaeGUvM3F1RVRBTFVlMWE3TnRueS9PeFdvajl4?=
 =?utf-8?B?Wlh6bTJFYlJoWnJEYXRYNVFzVVB6Wkd4UDBpWmx0Qzc3WW9NSUFPUENvY29Z?=
 =?utf-8?B?K0FrZ2l6b3Y0UDNRRnpJTXQrcVpPeUxQNUZNMERYREJoOEVhZ3RzN3g3NFla?=
 =?utf-8?B?Sk8wOVFkQzU4d3crbmJjR2JTS0dmNjJDcmdkcW1Pek9OdDJGK3FyODdsYTBp?=
 =?utf-8?B?dVF5RXpZcnpYOHZnSHFSeXluZHl4TWNMMnRRQUNDbng2Y0gxeUFpZ3k5WDBM?=
 =?utf-8?B?SUxWUGpDY015SjczdTRUb0Z1SFlhT3l5ZmhmRVJmL0NGRk9iSlA2aHRjNWNk?=
 =?utf-8?B?NnZ2ZTFmenlJYXlPMEw3Ti9EWVBvdFhVTkdNbTRUMEhHTmhKb2Q4WkRpdDFr?=
 =?utf-8?B?RXNoUDEzMVJDanl3bnQ1WDUvV3ZiVzNwZm5XTEpGdVNFeFRXbVJyOHp2OWY5?=
 =?utf-8?B?dFVtZEFSckhwSjBaeXFJUG1SMjNqTzg1R0h1d0Q4bkdnbEt2eG5MbVZrOUI0?=
 =?utf-8?B?QmRlSEJYMjRTcnhPVHpaQWZCOXE0KzhWU3YwSTVveUpnZ2dJN3FwQW5wVys0?=
 =?utf-8?B?WDdTZmE0S3NCbkdqaXFTOTlEdG1jVUhVUGo3TERncTVSNXBjY1M1UG1pamlX?=
 =?utf-8?B?OGdnMVFFTVRWN29mOFgxcS9NSHR3L205YjFFeU9oUDM3MmgrdHJTWGFhcXh2?=
 =?utf-8?B?cDlwYSt3MzdVWUh4aUo3dWk5anM2MnJpeDFqOXhKOFI0MklxMGhLM2owb1V5?=
 =?utf-8?B?UjJNbXlkQzcrZ3dEd2FVRWMrL0xlUkl4T2VhL1NPQVdkZlJqd2NIQ1Yrc1J4?=
 =?utf-8?B?REkwQXhiK2xiNkJjSk4vci93eGxha0lHc1lKdXFQMm90YlAwQ2d1aFJnWXpy?=
 =?utf-8?B?WTc1RlJYY3c0YktOc0RQeUNTb1pTRzVTOWduTGE5UlljMitoQ1dndWhxNk9v?=
 =?utf-8?B?VGYzakNqd0VtbmRzenVCaDZmTFVQYUIzU1NaVjlwQmF3L04rRitOd0ZXcmY3?=
 =?utf-8?B?U2Vtb08rNWJCb2FCWWlaRTVISlhHWjl6K3N0cjZ6VXhNZldHeUVvdkpTMTFU?=
 =?utf-8?B?V0tiMmpXOGFWQnFpeEc0VUpPUnB3U2NhMVBRYkh0bFdhV1RCcTdXcWtubmpQ?=
 =?utf-8?B?blQ4MUVtdWZKQm41NjcyZmJnN0ZScHByZzlEU0Y1NWZYV3dya1pjZVVBNWZQ?=
 =?utf-8?B?N3ltMzZjb3VwZXVrMC9tdFNoYmsxT2FqM0lLSHpFdkU0RWxIeWlaSDRnejRu?=
 =?utf-8?B?WEp2V3V5SkpMVWVodm9RanhKc3V1MGM1NlgrRG5xNE1STHR1YitQdWZJKys4?=
 =?utf-8?B?aFlzRXJqc2pQU1BGaW1Od1EzeW8xb1ZEalA4WmN3SVA5T1hLOTFjLzEva0tT?=
 =?utf-8?B?QlhzM0lIU1lDalVlcjRPU1FtTk51QlR2Uzhad0NlMjZ3OWUwbnhyclVqVWN2?=
 =?utf-8?B?ZkxDNmFBUmo5a2JoeUpZUUNaaDAzazdocTBBcWJuL2YvSGlHN2h0Q0cyY1JC?=
 =?utf-8?B?WHNXMnU2dUNlRmdvSFI3MnN2ZnUyc1ZzdzlrdWZxODk1c0k0MVhkd2VGUnRi?=
 =?utf-8?B?ZERpMm95NTV5NmRqQlFMdXNqamFIMVpXNnljaGhUWjFLY0RzRnhSbVJya2J0?=
 =?utf-8?B?THppOFM3S21WUkNheHJDZDRQRmk2SXhuVC9Bb0lZS3Y0b0VuZkxpVlV1Sm1a?=
 =?utf-8?B?cFlCaXIveHpJUTBuZTJ5MUdNR0pPMHVzK3pMTERSZDdBNS9Relh1UjVyWVZZ?=
 =?utf-8?B?ODliOTFmMjdWNElGNmhUenczZjhPUG5nOTF0MXdEcTdMdzNyNHdxa2pBZmNZ?=
 =?utf-8?Q?tJIbJGMWnBW7J86zyV0s2Ik9z?=
X-OriginatorOrg: carallon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccb64f6-5b6e-4a79-b0f6-08dd13a9265e
X-MS-Exchange-CrossTenant-AuthSource: LO6P265MB6811.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:45:37.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5677293e-6dd8-433d-8f8c-03a0fd233eed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1r6suT8yHR79+oHEOUaWoC7qObEATSiWZJtCtMgufgxiDKrfM4EX9kGLKNmY6wpuhU9SYn0lSssf23nyctryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5651
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:40:44 +0100
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-net-phy-marvell-88e151x-Fix-handling-of-bare-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Revert-net-phy-marvell-88e151x-Fix-handling-of-bare-.pa";
 filename*1="tch"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

RnJvbSAyZjk3ZDg4OWNlY2ZhMmJhMDY2NTI0Njk3NjVmMzFjNzBhNjhlODY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSdWZ1cyBTZWdhciA8cnVmdXNzQGNhcmFsbG9uLmNvbT4KRGF0
ZTogVHVlLCAzIERlYyAyMDI0IDE0OjM1OjEwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0
ICJuZXQ6IHBoeTogbWFydmVsbCA4OGUxNTF4OiBGaXggaGFuZGxpbmcgb2YgYmFyZSBSR01JSSBp
bnRlcmZhY2UgdHlwZSIKClRoaXMgcmV2ZXJ0cyBjb21taXQgNDMxYmU2MjFjNmNiYzcyZWZkMWQ0
NWZhMzY2ODZhNjgyY2JiNDcwYS4KClRoaXMgY2hhbmdlIGlzIGVycm9uZW91cywgdGhlIFJYL1RY
IGRlbGF5IHNob3VsZCBvbmx5IGJlIGFkZGVkIHdoZW4gaW4KUkdNSUktSUQgbW9kZS4gUkdNSUkg
bW9kZSBzaG91bGQgaGF2ZSBubyBSWC9UWCBkZWxheS4KLS0tCiBkcml2ZXJzL25ldC9waHkvbWFy
dmVsbC5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWFydmVsbC5jIGIvZHJpdmVycy9u
ZXQvcGh5L21hcnZlbGwuYwppbmRleCBiMGEwYjdmY2IzLi4wODYwOGE5OWI5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL25ldC9waHkvbWFydmVsbC5jCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9tYXJ2ZWxs
LmMKQEAgLTQ2MSw5ICs0NjEsNyBAQCBzdGF0aWMgaW50IG04OGUxNTF4X2NvbmZpZyhzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KQogCiAJCXJlZyA9IHBoeV9yZWFkKHBoeWRldiwgTURJT19ERVZB
RF9OT05FLCBNSUlNXzg4RTE1MXhfUEhZX01TQ1IpOwogCQlyZWcgJj0gfk1JSU1fODhFMTUxeF9S
R01JSV9SWFRYX0RFTEFZOwotCQlpZiAocGh5ZGV2LT5pbnRlcmZhY2UgPT0gUEhZX0lOVEVSRkFD
RV9NT0RFX1JHTUlJIHx8Ci0JCSAgICBwaHlkZXYtPmludGVyZmFjZSA9PSBQSFlfSU5URVJGQUNF
X01PREVfUkdNSUlfSUQpCisJCWlmIChwaHlkZXYtPmludGVyZmFjZSA9PSBQSFlfSU5URVJGQUNF
X01PREVfUkdNSUlfSUQpCiAJCQlyZWcgfD0gTUlJTV84OEUxNTF4X1JHTUlJX1JYVFhfREVMQVk7
CiAJCWVsc2UgaWYgKHBoeWRldi0+aW50ZXJmYWNlID09IFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01J
SV9SWElEKQogCQkJcmVnIHw9IE1JSU1fODhFMTUxeF9SR01JSV9SWF9ERUxBWTsKLS0KMi40Ny4w
Cg==
