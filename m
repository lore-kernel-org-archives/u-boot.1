Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8A0C52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 08:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B25C871C7;
	Thu,  8 Aug 2024 10:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="EN3Z3qD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FFA8851E; Thu,  8 Aug 2024 10:51:48 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2AA86BF1
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 10:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBUQ0mMi1YTtsw7ZGUVTM35o3jj566ZLyv7c/rsYbeu85wZQ9Md8X1a9lPJIYYEXfkC8xyau6UoIZQgxnqrP/45VcK9hr58rwjlawb4nscnDavojtHRxE550/i37tMZVHWQVQ2NV1MvvSn41H2v+BeLLbRQjIiogXVGkgRo/Ngq66ZXbo9cN+1k72ECrZneW2J6Frfm8mbRmj2rL5M0jWo14fAy6xPVdkwD7yO9ob5LyHNZbb0nZxUF9SpeySPxq3ef6DlDYr3z7A5tdoqvmQ8o110zbs87C0/bHviB/z+O/1PasrsfC9pLfKuz7EhVPPiDaXjeFM6m6AVK7sySIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sheEQmCpQqk8iAhG2opZ/D+/tjE46Ilw0fHsLDOsrsc=;
 b=Q1yLCNY9zFu+q9MAwkzspzkwf7uq+8diM+mdAkR0jU8gkaAEIVZl5sJEOSCv21z8tSdT86hsJhnGaMCyukc4XIbBbb70NcUV2cW6OwfA8/RmVjUapJ2BYr0+QA/OZDJSWE+Lz6rWaEW36nYhERq8KCT0zyufDuzsO+8T1M8KUCUQq1ya0ztMPhxXJcZxr3NrfchwJQIjrjtjmot3ORPtc+FLjmMCN4k0+WdKYvc2YqA4coAS184wdzymBPaIldhnKTYG3l+Iosnm0X8iaaSHzIUjD+uNgJxEuw3HuMuETZ25KJNKVz7dWJfNOFZrjwOwaBpmNzKxw573dBZOWYsq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sheEQmCpQqk8iAhG2opZ/D+/tjE46Ilw0fHsLDOsrsc=;
 b=EN3Z3qD3zZirda1Zi+p/dADRWEL9QaJ0yPJE3rPLuRTL+ZOXkDPYXSCj0GSkDBLCNeKfHaEzMW1uucT2pF3iXttJ6uagc0bS9mIJX5UvsdWFq9USdYPUu6UX1knPSPRTfBVfiOv4MPGLWbSk7mgIDVk3pqJWCNjTNEVJb8Z0BGzE5ryD4GnhPeI7ugreoUSGUnsUtLzKez16AbMRse0y4uPvl+YGoxrMEIpcsOsa52qFauIsnx9+E9N3MZcFkaMCqwuQfaZrU7GKVMA83DY+vEUtZZZ9rjmBJu6dW8jn23s6eMHOFL5aholYw/n9r+AfevI2gV6bSFQgpfDu9Tgmlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 08:51:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 08:51:35 +0000
Message-ID: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
Date: Thu, 8 Aug 2024 10:51:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3ba233-9b09-483b-b39b-08dcb7874f33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1M2K2gxNm1Uc0JOR0J5OGlvUktveGhoVkt3VGtLZjlYbVNLczNrL3U0UEtB?=
 =?utf-8?B?bHVLTTFGTFFRQ2N4ZDl0R05iS24yWVYyd09TemxXK2VGOXVDNngrUnEwL2t3?=
 =?utf-8?B?cW9GbmMzUkhaMDdXditITldFVEQxelVISXdzUHJ4Y3A0WndFRG9YWHJzVmVj?=
 =?utf-8?B?TzVUN3pBZzVpVEt0RGxDME1FcFNDQkxXUVhYaVhiVjdHNmhDcWxvaHFHeDRn?=
 =?utf-8?B?d3VSdmNxbHZHUDNQVTdMQmdaSUFpbHE4djVReGJUSC95d2hWdXR4OWF2bkNH?=
 =?utf-8?B?ZThxckZTUlhQZzFsMENqY01ReXZTVTZObUlzMGVHd0xwWVZrWHNiWElrQlFE?=
 =?utf-8?B?NDRtZjVLd1h1VUVFSTZ0bi92MktkZkRBZTNDNDNQMHBpWHFNTHM0UzJRbEJK?=
 =?utf-8?B?SGx3azFseHVkQS9uc3B2THFmR0xBV3hyRzV0cXdZWGE5MCtUTHlvZkJRbmcz?=
 =?utf-8?B?M3FtTkQzemdoVmEwMHNSSytlSlE0YjhFR0xPU2VJYlYvR21FVmJMNVo1TCtt?=
 =?utf-8?B?YnMyaU1PZlBid3U0ZDNJTGVsMUVMSkp5aTlYMGxHeFFKTU1Yc1Jyd1hXakY3?=
 =?utf-8?B?M1FpTlFvWnhNeUZuUVEvUkZFT3VpcitydU41OXdvQmNBbElQanExb0xRZ0cw?=
 =?utf-8?B?SEJFenVNa05lcFpYY2lHdmxody85VjczMEt0TVdaK0gyTlpZOE4zOEhMQUlT?=
 =?utf-8?B?bElyVXZvbG9BdzFJa1VuV1VXaFB2MlpUUG52YnJXdStVN1pqSzlMbEs1cGRp?=
 =?utf-8?B?aVVKVUx0S1U0aksrWU14Mjd2aXUxTWNtajByczB2R3NpMmlMZ0Vubk50YjFP?=
 =?utf-8?B?WW5yMzdNN0w3VE5NbUkxUUxha3k0QnZWWWpVWXhnS0NJcjdlSDRieWpVSnVN?=
 =?utf-8?B?ZGg4RGYyY2ZBeFNCaGsySWIycU5vZHVkYTNodWttS3NzTzVqYlQrUUQrcEpW?=
 =?utf-8?B?R3RybUVlRFUvUHV5dDRsdlVwNUdGNDZvMVdZNnZ6M3F5a1Nsa1FKcldTSDVn?=
 =?utf-8?B?OTkrT3R1RGF1WjVqRk1hbmpxaXRrNDNISDlLenBGaFVLNVJkMTJxS2t1NkRR?=
 =?utf-8?B?NXMyZ2dkR2Q1OW1zdzQ4bnF6SjV4eitHdFZ2ZjVJUExEWXpLeDdiVVhOUjMx?=
 =?utf-8?B?NWJWN1ZSMUl4Z2J2WDZCNnJVVUN3dGZuR2JhSkFCMGE3Q2JCWVREWEw2UGw5?=
 =?utf-8?B?VmtJNm9jK1hXSG16OVVHSUsvMDcxSis1S2ljS2FhTnR2UVR3OTVkWUFVeXZO?=
 =?utf-8?B?QmVoYU8rTGhXWHhLcEljVHYycXRZK0xTMkFoVlkyWU9CWmJEWXNaMG1WV2s0?=
 =?utf-8?B?ZmlHR3A5SWdrTzNPYXowc3cyS0pXVFM3ZU9yV3pNbEk1QlZOWEIyZVBuOW9t?=
 =?utf-8?B?U3dndE1DSFpLR0FYQll3ZkRDam1aMnNiZDZPblZTNEdaU2pucCs1eXVJZzJJ?=
 =?utf-8?B?N0YvbGtrczl2WWdZVVpET1BqTUFaNlhKNWszUVMrUThPSlNEUWg0amVYc2VO?=
 =?utf-8?B?QkNhdmlZMTg3WHcyKzJWQldZZTRYQk5ha3N6TURqNElyRUJLK3dxVEVjelIv?=
 =?utf-8?B?elZlZFVXYWZlUHZHNVUvbWRpLytTN2JHWHl2KzErbDJYbkV4bk5CTlB3T2pN?=
 =?utf-8?B?eitBU2Z3bDN0ZGdqOVlDQ2haMFNIcStvWC9GUUdOa0xmRXZBMVIwVXdpQ2pm?=
 =?utf-8?B?ellCZ2lzWmxaVkVubEJVS2RCV3N6d3FmVDJFNFhFUDdFc0xpWldmMEMxQXpD?=
 =?utf-8?B?MHMrNFZtUkZVUzJrUVhuQkNHdDVQUXlrZGhEZ1EzM2JEblc1d1Y0OVdsMUpN?=
 =?utf-8?B?RC9tU2tqMUNUbndHc0xEUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdjSyt2NWpSRWNnaW5sOER1dmQrYmZ4Ym9Scy9LeGFuWHRPUld5dmJocm8r?=
 =?utf-8?B?RVVRNExLeVhJRzYrY1hkTUgwY0NjdDJHMWVtcHQ2VnMvQm50QjM3NWJpelRx?=
 =?utf-8?B?OEVVTFg4cjZrNTdYM2pRMm5vZVk2WXA5UWJ3cktzYjc1UUgzZ09yTmZYS0gv?=
 =?utf-8?B?ZytQcUlHRGUyUUJrT2hyM01UNm5aZDdWMkgzUlZHaHNYd2xOa3BtaGNiVHV0?=
 =?utf-8?B?Uk0wVnZwREkycUxmZ2JwZzRDYVBLS21kbjFCbTVQY1NPLzd1Y1UyaWtMZWd6?=
 =?utf-8?B?UkVzejlEOHZMd1JwaGlWd1V4WnBsL2hDTlBGUXRiQjh4K01IYUdhRjFnWkI2?=
 =?utf-8?B?ck9ab3RhbkFXVUE4czVHT0oxVlNGRTN5eE45TmxEaVNuZk8rbCs5c2k1WGwy?=
 =?utf-8?B?cDNnOWNqOHFQWEhBc3pVNytRd01ESWhKTFVOUWk5bjgyZkczbVFlMytqTzNy?=
 =?utf-8?B?QXJKM2R0cVJNcmEzUUVPSkd4Q3ljbUtzN3JiZ2E1dWZvQlI1clFWR0lYTDh4?=
 =?utf-8?B?eW5UVG42YWwyME5TanNhVDRCSWlVSVdWYTBHSmZkaW1CbG9rN3FWZHJQdkc0?=
 =?utf-8?B?Y1FMUGU0RGdLem5YVXlpNVFzMmVFVTk5QkRaZkNJKzlGVzBGSEJKR2dXK3Fs?=
 =?utf-8?B?Y0hwOG1yN1BqRHAzOG9EYzVsWkdTcDBKV1I0LzJnL2ozV2tqNm5kTldTSlZr?=
 =?utf-8?B?ckxmaWh1UjZHMFpseVEwNi82V0dRakhBclNPMTVHdFk2K3Z2bGFGbWF1dElk?=
 =?utf-8?B?bFlyY01JUW8wYTE1NzZPdExYTHoxSW53UlZCL2g4NG14akMxUDdzZWp2NXN0?=
 =?utf-8?B?QVZQeEZzbDVhbzFXdWc5WDJJaGxhYWpFVmRlSXJNbmxla2k1dUxSdWJIMnlu?=
 =?utf-8?B?eldYTVZwUU16cGQ1UEF2MVBHakVxWTFJbHlDR2JSZ0JxdVpNeWxGeXVKbVFk?=
 =?utf-8?B?MzBBcFQ1ZEtNamFPSkpMeHRPQVFsRnFxeTZYR21PUUN1dlJGKzhYVmM4R3Ny?=
 =?utf-8?B?UlJqY3FOVnlaZ1o3UmRjSjN5YnBMOEVXeWwyR3BBVFd4emJNVU5TVFF1VEhl?=
 =?utf-8?B?RDBNSlIxWFI4YWRidGlVUTFmRlVSOHRkeGVHWDNESWx2Sk51UCs1QldTNzJU?=
 =?utf-8?B?dkcxSDhVYmxEb1ZZK0JBTEtVM1hjWlNsNHVDM1pxQnJ6K1d3MWRzMVU3MDQ1?=
 =?utf-8?B?RU9WUW5oYWVXRFBSVDdxYjZFK0owNlpYa2Z2WkpSL0JBN2MrVE1nZE0zM1l4?=
 =?utf-8?B?N0ZHdU1UQ0NXOUpGZUZnbFFmVEt5Z0pnS3U1U1g5bDJUVjExemtKNXk2NVcx?=
 =?utf-8?B?VkN5dDh4Y0EvL2M2cUFpdVZPN2FORHdPcUZ3K21oVXhOZFFZbFlRNWllMHla?=
 =?utf-8?B?OUpZb1hsSDVYREFHNWJFbFQ0dlUxNlBRWHpGenpzK1pUd21ROFZwamhsRzhE?=
 =?utf-8?B?cGZZZHZGTlFmeHk0dE9Ma0twcTg2MnJjK2wzZ0xIbDZWdHpGd21sTFlHUkky?=
 =?utf-8?B?YlZObGxicFlCTDQvbWtSTjk3YmNSRkZVR1l3YWcxaWF1YTQ3cXNmaE5meUsv?=
 =?utf-8?B?T3d2TStFZVhjNWEvdXFjOTREeUJ0T3kzMTZidVpiOVhWNXlQZExxR2svTmlU?=
 =?utf-8?B?aGdIWjRGdVNudmhnMUEwcFMwaXZvVGlVVmNrelhYRjdWc2lXanZBSUFCKzNo?=
 =?utf-8?B?Mjl2eFQreFVmaG0zZ1dOZlVWT09FeGI5ek5wRHdENS9kKzBvQjFLY0RaNG8r?=
 =?utf-8?B?emxMSHBwYXd1WG4vaEt3TGc0SFp0MU9RdmFQYmJFT0RiYnhjd0VVNjkxMlJ6?=
 =?utf-8?B?REQ4c01OZ3Z5MVg2UURLc1RSSUdaSHYyOE45bmNWeGxNOE5RWFBQNHVqWjBu?=
 =?utf-8?B?SW5xd0c1SjVQQmtCWEpoUTV5QVNTUlNiTW9rK0d0cUc2S2dTWml2QVNha1hv?=
 =?utf-8?B?b01QbStPNko1M0RvODB4QUxtUmMzT3dFNEp3aHVlM0xreWhvdFE0QjJVUit0?=
 =?utf-8?B?NFBqaWRBUU80b3JkbHlGZHVLdURSdTAvQmpQeCtES1o1MkduYTJ2MDZZMHhr?=
 =?utf-8?B?TVV5R0JPMWI4d3pXYXhvNkVXdi9wWUtuMy9vQzJ3L0xqbDg4OEN5TzZuRjFj?=
 =?utf-8?Q?978cl8EtU7YzWYnTls38NiJJ0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3ba233-9b09-483b-b39b-08dcb7874f33
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 08:51:35.7919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPK0ziKvPzgy7bnC0aFolcCvKHH4Ck3yGP4qMZKn3+0D/fN0TfmfEzNt1++s6oTSRnSS9HjMdreIwe4w5rcUxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5154
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

When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
for that so that targets like the IOT2050 will work again.

Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index a9ba315463c..2ab41cbae45 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 		return rc;
 
 	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
-	if (rc)
+	if (rc && rc != -ENOSYS)
 		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
 
-	/* Only returns an error if regulator is valid and failed to enable due to a driver issue */
+	/* Does not return an error if regulator is invalid - but does so when DM_REGULATOR is disabled */
 	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
-	if (rc)
+	if (rc && rc != -ENOSYS)
 		return rc;
 
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
-- 
2.43.0
