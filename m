Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C851CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB0683900;
	Fri, 26 Sep 2025 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t3hSThUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278AF83677; Fri, 26 Sep 2025 16:54:38 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4046083623
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU7CHcKngTmqfgmkOUtiO3xREv7M02oW35+tyl+0PhJXGdnD8qqoOADzsHpzNxE8Ew/GjhwxrsVInRcgZbp9BI9AQlV/Cj/W9usCei3Wyh8l4EEu4/exnsVo3v4XGfw2Gm3czuZCHngAFdC+bmu5WAtnWE5hiHu2KUIOcVtDLz3RkXoWzmygJwc3FULNmXDyjcyLwObbct5tO95Ed5USQbs+Vo0IGlqmYvo1aGW8ePM9KkNkemyym7NYgY7PsGKOBhFnJwjRHN1RZur7QzD/amDcgyaCo5IzkHWFDpuAVuEILJrvY/wND+lQbVvPcasiTEwISsWGb5u1z+dCUnX8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDxsb1uiFGmQcgBn1ahBIfUuPwOS3ZrFFFfLtY20aQk=;
 b=ceGHCn9cztZ3Go2UuFHnlOoOQr45dx2Y5bFDZ788D7Xwabhm9PtuNxtnhoI+jt3OKbfDeUOoEddsSb/VWwmdXUfO5c06ccDloIZF6REq+hu5hjgwu7/Knx8TEBG1ArOsB6bb9eNoXw+kP/y8z/XMDhd5onC+4dUt8J8urK2TUh4Ly/NzMBie/tjb4El6M9257SGrI/VEec4FsSb7vHjY0zWjFjCv6DwjMoj/yDlc9lG7KTwuQ6wV09cV79+XKr2B3U0ZtKLdVj6cNtZKdtSF7mr20UY/AB6t9df6EJe86tqbKgAZgUTHM1hBfyl2CtMOHS0aVwotzk5HPmpHzgmGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDxsb1uiFGmQcgBn1ahBIfUuPwOS3ZrFFFfLtY20aQk=;
 b=t3hSThUN09AhIAJeeDZrFp3a5RGKPoIEF0cuU1J4j+NnxBKjNbmkYG7IyymAeM3NicJXsnntE0bEuN52Bv8I8GkdkyoRNPuKIOnZ2wb/XyN9nXqmGqKuS7p+7cwps3I/w4c1jx5E3NCPEqXdvLYCXu8JA0Q7WSwU+6YDJKLGxUb5/sxTjDnUXhvnETfcdxvq7ZyrDjke1pE1E8F1GRYLUKnejWwn5eoKs3k83WZ4ZAzjOFFrS32/3PKQWpGL1SSW9WecoJp0zt/9tEupdRrUgQ9zGXN3CwVzpHs83QYiXkrL/dELRHMWSGAUlp4CGR18Eo5xSOV0S/bqDAcot6NfRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:17 +0800
Subject: [PATCH 04/10] firmware: scmi: Add error code IN_USE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-4-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d18a80-2125-4669-8162-08ddfd0c9b31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZzVERaRGpaSnplRWZ3akJNbzBTMzltZ25ielJ0dnF3Yml5YnYwbERpMnNt?=
 =?utf-8?B?RjFKQlAxOE5mckRPWGR6WFVkYnZHT0xKSGhkQm5wRHNMOWVNZ2s3MGhSUTJy?=
 =?utf-8?B?dUtOK0Z3Lzd1UjN4VytrZUxrTjhNMmV6RnhJbmZDMzJKQlo2NmtsMFFhdmdT?=
 =?utf-8?B?Tm9DUjVydXVJZGFFd0tlYXZTOUovY2QzNGRuWW8wamVJS2RGREw2SHlOdkY2?=
 =?utf-8?B?cUFTcE5VNmc0OC9aMWlvTzFtbXAralFQdjJmSDB5UEZ2OUNaQ3F4dTdjZk1D?=
 =?utf-8?B?ZzFHSGhQUGF5VnhtWjR3dlU5cHM4Y2ltYi9idTdJYVNCTjdtSkhTeVRKbjFr?=
 =?utf-8?B?V1h3dG9rRmFzK3RZb3kwQ05zcUxTeGU5ZWI0U3J1NXFVaWdEVXAxbTd5NW1a?=
 =?utf-8?B?VVNVcXlTcFFOc3VXeEVTRzFMQ0xlSS9sT0p1WnpzMERubkFtMzNjc2FBK1BO?=
 =?utf-8?B?MkJBdlM4ZzNSbndZemdZOVp0TGlNcVI3WTZRYWwxNmpjRTNsbjZmbWRrdkZj?=
 =?utf-8?B?NFd6cUM2ZDJBczFRRWZOTE5xQXF1RS84Z2huOE1IMnNWbElQMm5YWnFBWGlp?=
 =?utf-8?B?TVMwejNLWG5KZWxJR3JKWHdpdml5ek1aNjQ0NlFFTjNWRi96VG5EaTJpOG03?=
 =?utf-8?B?bFVjb0tnR3NVMjlxcjZPdUhSb1VvektWMk5HV3FmK2dBNFZ3aS9yeU1wSkJy?=
 =?utf-8?B?anN3SG02SHJ1Q1FSZldxMTcraG9JR2VobEZ2Y1VhdGl5QU93SVpkeUhnOTBu?=
 =?utf-8?B?RjU1a21nK2gwR09TT2o0TXRUVUQzSGZwanhxTzN3Y29QQkhycWxXdnN5WEM2?=
 =?utf-8?B?dkJJc2lEWXN3K2tXUlhma0FFR2tzU2dqbUxVdHdQR1NyVS9RYjBDUXdhRDhy?=
 =?utf-8?B?ZFJkdlE5M05NRERvYmJmaEtoSHZWblFHa3djL01xblFMY3hBemkrc2d5MUZi?=
 =?utf-8?B?NDRwbUExR3ZBVlBxY3k2L0IveGlMNzRwdFM2KzNOaXE1ckVkRFBiN3Y2QXk5?=
 =?utf-8?B?MlZhQkRZWkpKam9YZEF3NFRHTTRxdE9UQ2VNMHpnblZ2V2ZQYVNMbUtEN1J1?=
 =?utf-8?B?d0lVSzZFaERjQUxsZS8wZTdPVDdRM1k3eXFsaDhRSElGbDdjRnpyYjBVWFRP?=
 =?utf-8?B?K2JPQlV4RCtwb3VtNEtmRmljeU1VRFVnbnNEaHBVWDByTHVSY1ZTamRvVHRY?=
 =?utf-8?B?YVdXNWlya1lwYzdNVE9Qb0dXNlVZY29DeFQxUExYNHFhbTRRWmxJMEFJQmJS?=
 =?utf-8?B?cVlDdnltVnhBRk51dU56SWFyZ1hYMytURU0yaDBDN1N5VTUzM2JUb1BLZDFK?=
 =?utf-8?B?ejJCd1VNN0tJMlo5eEtNWUdYODEzNXA0aVB2OE1yQTQ5UGZCYmQ4cWk3cmtW?=
 =?utf-8?B?N1F2SDhxYmlVd2lYTitmdWFTeXU2REZIQ3JrRThsZ1Q5Y2Q2QVc0WXVwUTNJ?=
 =?utf-8?B?a0dGU3plM05CZ1QzdHJFM3dsOHJZeU0rcEJ4d0VPSFhQTWIxMzJCTXN0dEN3?=
 =?utf-8?B?YXNVK2loZWtxRitqS2oxeGg2ZTc4RlVNWWZrUHYxZmJhR1dJN1NyZWZuZ25U?=
 =?utf-8?B?enNzRXBlMXdtN0pWTTVJNTF1NFJ6MGViTUplQmQydUY2NThGWWR5U1dTTkJp?=
 =?utf-8?B?N1N5VWczbG4vbHZWRElycTVLRlBxVzAveEpnVDZ1ZVhxM2dyVFBtcGxMT096?=
 =?utf-8?B?T0xicVdOSGt3WHZyZUw4SUx1SEhSZTZaclpiZ2ZkVWt2K056dDFuU2NqRk9E?=
 =?utf-8?B?UVhLWGdpa1dKTGZKN1pvekxCYVU5UEttbkFIeHZOYmxvUmZXOU8xVWtOdHdX?=
 =?utf-8?B?MWFFMmpBSjU0UnNBcWdmOVVSWTVMUzh1R0Jycld2RSthanFRZmlzTzlMNm5O?=
 =?utf-8?B?eGh3UHNUNm5VcTV5SUZrcFpNbWpueVlPTDZ1eTJDUFd6MmxrT0R0YTR5aFM4?=
 =?utf-8?B?Sk1ZVDg3LzMyd3MzUUZXTERidkM5bTM2czJrV2lJeFlMbDREUCthMzBqSmlE?=
 =?utf-8?B?Ly9RM0puSU9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW85NnRGcW9sd3h2K2R5dEJnWUFsWWs0K3VJU0ZvKzJhWmlVV2xEN0hUWXZE?=
 =?utf-8?B?NWVIM0JQTndnN0xyTlZyeWQwdDdzQTZOT2dsRm4wcFFvNzh0NlRnMnpMYWNI?=
 =?utf-8?B?Wkp5MW9DRXptVnlDN3NoSmhlM1YvRS9nT2tOTWRNdjhJYVZjRVE4SHlKbHJI?=
 =?utf-8?B?M2JrMGR2TXJDZjNyU0JHOHQ1akNjQTJJQ0NxSjZQQU5MaCtJQW51ZVhEcS9U?=
 =?utf-8?B?K21sNUc1T3JSMFpRZlJwRGREUW9xWkkwdXhZVDd6dUlic01TVU5QRzNGNms3?=
 =?utf-8?B?OE5aMDdFSmNPVUhvTGt4cjlRbkp2MHJ3NWV2Tm5Udy9vdVhHQlJSWHMrUHZJ?=
 =?utf-8?B?NFY3VXUvNDRDTTFZMEdYdWZNRVByS3haTkxabjNjbHVYT3pVVTZRSHJqaDgy?=
 =?utf-8?B?cWJONHViaEk0OXlTMkNFNm9rdjdYWTJQMVo1Nmw2ZEVvblRJNUVHTEhVNHNn?=
 =?utf-8?B?N3pXWkNzcFVPZWVFMHpzV0kzZkZIblF3cHZJYXBXQUtxdG9ZMFRoeWxTL3k5?=
 =?utf-8?B?a3p6ckFHbVlONXFUZkZwTjVNaUdFNEQzdTRQdlA1Q2pYZElWci9CcFNhYmZZ?=
 =?utf-8?B?UDdLeXg1bWJEOXNYUlIrd0ZpOVJVVXpNWFRuVzNlZVFkQ2N6Rk1xRDM0ZTBh?=
 =?utf-8?B?bjJJcjY1T3J5dXVLdnR5c1ZFRHRWQ1VzaUtIejZKVHRtUXFMZlE5THVDZS9F?=
 =?utf-8?B?VTh2bmpxeGNhVmh5WjJXaFZkeitoMUJUcGZGRVltTUxqVEs0Wnk0ckVZcFFx?=
 =?utf-8?B?NXNPK0NWUlVLaTVDL3JKbzU1WmNLQm03QlRYZVp4ajJ2TkxMSmtOanczcHJ5?=
 =?utf-8?B?cnFQMUVJeXVWcG03dm5WQTQyMmhnTW5jekt6K0Q1dnNqSk5vN1NmNEJ4WFpi?=
 =?utf-8?B?SjQ0bGp4N2Q3VnovRVlOR0hqZWkzSVYwdGwyeGNWREZsdXovWkY5d1BtUXFw?=
 =?utf-8?B?RDZrNTlDQnRGbFdMSzF4U0o3V05LQTZubTA1TmNIaXNRSDdQSEhGRVFOU0JW?=
 =?utf-8?B?a3QrZStBV3hjbnhZb1FpRW1pQk1XUSsrbC9HOG1XdkxQV0RWQ0FELzBBbHN6?=
 =?utf-8?B?cmd0VFBtZk0xaGNLamVpcGlPekR1djJ5cFBoSTdaYXNYSk9aM0JIOGhVWm1k?=
 =?utf-8?B?bC9UbmZJQVVPTDdnS1JIYzVrTlM0STc1aVZ1ZlIrb0JFdmIyTWZadlZjMURh?=
 =?utf-8?B?NTBHVjU2c1loaWNwTEgvcFI5VHVKUWRlVGxKalBGQlhHQlVWbGo3c0c1emQ0?=
 =?utf-8?B?Z3BtdGhwdVJHc1BIaC9JaVl5Y2lLZE1zVUw5b2JsdUJCenp0QzVrMnJJL0VD?=
 =?utf-8?B?ZWpSZG9PQlp6bC8wcUVCQW9xNWQ0RjBaZzRKZmlPU2VUbWtieFU4My9hMGh3?=
 =?utf-8?B?Sy9GQmxzUFUrRXp5cnBVeHNVbFd2aXR4NDNIbXJkTmVPT1ptSEJhODRhc2py?=
 =?utf-8?B?WklpT3UwcENqT1ZKaGJFcVEvUktUc0xsRnE5NmhHclpHbEIwL0I2R3FPZlc1?=
 =?utf-8?B?bWwyb0ZyaGNrWk03Q0NDNjJrd2RLaDQvZERaZmppYWJLT0hFdlY0K1J0cUxh?=
 =?utf-8?B?QjJmM2lvelFKVXBIdkpNZmxzRDl6UGo5V3d2eDdpdnQ0bE0zZ3NzRmZsZXI2?=
 =?utf-8?B?K1dwWWZZM1lqdzVaUVdrMEFOWXdiNEVqOExTemVsM2RzL0IyL09MSjR3dERX?=
 =?utf-8?B?V0lXZEdYOEM4TFplbnRXamRqTlhocDRTNENKM2tUMDg3Y2pKU3NXSW81N2xs?=
 =?utf-8?B?WWFnR0F1cDdqdDdaNXVPMWM2OFl5N1lOelh4ZFVLdjhTdS9Oc2FzNzBiWUFG?=
 =?utf-8?B?Z0MxbVZnbXZxdDlvc2xhb2ZBTExhRGllRWpYYy9zWngyeko2R21KNmVXMG5Z?=
 =?utf-8?B?OWRyVUlxWERZVm8ya3NidHBTV0tTeVRWTVpleDNFZE1zRytGRVh1SjcxLzdI?=
 =?utf-8?B?T0dOZTNhN0J2MWpnc2FyTE5VbDVObXdrZlZtQlR1dGR0ZnRjVlp5WS9ZZ3RQ?=
 =?utf-8?B?VWZMS2YwUDdQTjJ6Ykg0TEc1ZzNLYmFCNGNjNDJsNWhzZytNNW53WGdKYlFa?=
 =?utf-8?B?Q0R5QXZNdnI3ZGhOVmZlTWV4UnI3QnJGMXY4aXg4QU5rdnpydnc3N2RrR29N?=
 =?utf-8?Q?yrwZDoiD5HCkVWyiqhR7vaXdg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d18a80-2125-4669-8162-08ddfd0c9b31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:34.2846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqrP1fLx5KNaEvdUx5Gt70nm6KtDJ/J8G+/796CvKNAZ4uQSVJENHmHz1YPrwoULSRs9OLhq5JJs8ANc315mOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

From: Peng Fan <peng.fan@nxp.com>

In SCMI spec 3.2, there is an update:
Add IN_USE error code for usage with Pin control protocol

So add the error decoding for IN_USE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 1 +
 include/scmi_protocols.h                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index e7ec2c108e69022ff3744c0b9d26809171307bee..69a277e8786b46994ccb83a04c155175858791ad 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -35,6 +35,7 @@ static const struct error_code scmi_linux_errmap[] = {
 	{ .scmi = SCMI_GENERIC_ERROR, .errno = -EIO, },
 	{ .scmi = SCMI_HARDWARE_ERROR, .errno = -EREMOTEIO, },
 	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
+	{ .scmi = SCMI_IN_USE, .errno = -EADDRINUSE, },
 };
 
 /**
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 762a1032c37c45c1cf49d5eee22f8c2a2aa62410..95e0c3cce3b9d4430383bac0bcb0a541f4af13f6 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -40,6 +40,7 @@ enum scmi_status_code {
 	SCMI_GENERIC_ERROR = -8,
 	SCMI_HARDWARE_ERROR = -9,
 	SCMI_PROTOCOL_ERROR = -10,
+	SCMI_IN_USE = -11,
 };
 
 /*

-- 
2.35.3

