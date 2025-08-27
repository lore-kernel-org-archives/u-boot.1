Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F8FCA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E03D8319C;
	Wed, 27 Aug 2025 09:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="hXcJaOwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5F6831B4; Wed, 27 Aug 2025 09:54:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD8A83145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdLf0ITEBEp5OkYQR8yW7/d/UNbuKqTze9f2VmDH72JWGeDaXA8IXl/nO3PK5bmE2LmzX6xF0ydr0J0wYtCvEE+Qwb89XI+2eYGWmngtLd4A+yVtO5g44N3n9IOUiqSY+MPypcajq9arEXdnrEi3eDA2jbxY+IifU0VUXK73hF+IxmdVw5DTWf4Roc7aF88djls81S2qG3h7q9HRJL9oBCPnX/3LEAOvVLTXl14qAGgx/9m+Te0JW1gMh8WE6n6O5GIr+3e+om0lSqMv2sLSu1Nq4RMQMG4gc3CeI42WiPQrdYp0frQIdtBvjGRC/XR4Nl+DQNjktckXh0qgBv7qVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZezJkYdWdCBQ5ebQfH6omjtMSZLBLGfg6wgQK1wCdQ4=;
 b=qElOB2oJfrCZPijAHb6MVCY3QTm4CNMrzXeu9fKRAMv9IwudpkjAApJMYN0i+OLh0GhEXCQTBSct60S9mbU/kbwK1Em24D2g5oQ6W67PHNpHnDr3dHdqpjgoO2p4WxaBApYmQXjCdfH7xuOvcgd/nP+n7ueaks4KPRW7zCzQliukMzeU2Ak/kLwaX3xJ4Vksvg/3YtyalZTiX+nDK+KlykHAkM+8tUd3oarCZ+tw8w8KfP8nJb8zX0hAYJdbWhej1jEkp7j47ZPymNwkWjjLzeYTSFcv4Jw5HMANfDolnQCU8lYQywCZxWB9KngLH9nFYFOeRD6tTqmlyjyfoH5oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZezJkYdWdCBQ5ebQfH6omjtMSZLBLGfg6wgQK1wCdQ4=;
 b=hXcJaOwKQHspC2IVaCM8/4B8QyDzx8qtv8rjNj8rFUwCreVZf6YZJYCIFdCVdNJkx6GybnDI0RwDBPrwporkuhbseCGksGasEFdeMHAKXvddEDEcwtq07vMnnod0vfpYDwdCPwxE0nwyBO+0vYP7HODna0GuPKmRfjga6aOS1vNBnHkcOcMixkRwL5Fwdbs6Leec/3FAM35WNXR0lJY/PyR7dB9Cc20yERvwm+dUZWPFcFaPWIfLmdcvkVgLCFJzstQe+agA8c+ZpnqlcXSF5gw3xdxChUi/sRNgv2qAZ+sSR48HYs+skp2TnaL7QOFrPSWOuMC4nYjRA/7q8KWDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:54:54 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:54:54 +0000
Message-ID: <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
Date: Wed, 27 Aug 2025 09:54:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eb111b-b57e-4c1b-7895-08dde53f0289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlhLWExPNno3YlphMjNWYVIxNHBUcDZ0RHl1Q3FsS3M1c3JmNmtwK0VZUGtR?=
 =?utf-8?B?UU1vUnMyOG1CZEswUGxPQXp6SkdWa0U2SkFSK29rVlluUEVQTlhBNW5JcStU?=
 =?utf-8?B?NC8xK0JMbW5UQnpEblB4WXN4dzVaNFdhZWJpRnNBWWliNTVnWkVUWXFGN21s?=
 =?utf-8?B?NE11d2Y5d045d21VSWVuZEpmWDRTdFhoNXpzZkw4bTY2b0xRaVRjTytrVUF1?=
 =?utf-8?B?MEpSbklIZzNsYWgvSU1XdDFGMlR2N1VTQUU0aklidUhpRzBseGc4OVFkY2ZO?=
 =?utf-8?B?QU41RXpmOVBmdlB2YUtRKzZmTWVCU2IxaFN5bGJyS2NuOWwwa29BbStsRldm?=
 =?utf-8?B?QjlydWNOQWxSNFQwOG1YKzBZYkt1VGpuaHM0bHVNL09WbzZXdFo3U2puejdU?=
 =?utf-8?B?SExnbFduanNDczVpRTdZVUsxcjd4eGw3VldpNm5kbzVlQm83c29rL1FHazF2?=
 =?utf-8?B?NzNKMWFYRlBXZHhKMEtDSHFpamxMRXB5YU1qMHZ6N0U3UTE2MFBoQjhYVTdr?=
 =?utf-8?B?NDI2T3NnQndmMndnZFg1VlFpVkFsR1JGa0VQc3pTWHJ1YUNvQTM2WnBTa1RC?=
 =?utf-8?B?OFB0R0NFZFdiaTYrcjA2ZXhRVHRhZVMyLy9rY0dTbzVCZVlReXVVQ3N1TTRM?=
 =?utf-8?B?NEJvRGMyVlFGWTdCYkVBaUM2MVVDaXl2RDZKR09ZZDNqMjZQUGNNUERLR1lr?=
 =?utf-8?B?OUdtcUxYeUZuMEgzN1ZOdFRVSnRyaEFJRmR6UmlKNW91RVVIZ1ZXS0xjd04w?=
 =?utf-8?B?bE1JSm9yQXcrV1hWdzljOHkzaDZCa21WL2RjbzZiVGJkQlBMKytNWTJZUTBs?=
 =?utf-8?B?SlJDTU9wTEcvNml5cVZmL0c2UkY4NlJrRU1KZkl0NVFhaU1qMGUwL1dqVDZP?=
 =?utf-8?B?c0NHa2U5UlZmbWEvdVhNdTNWNklyQVV5OEhEVFRlckgveHQ3NW5jeXZXNWxT?=
 =?utf-8?B?d0srbW1tS1laT3gvZWUxK3c3UTlHSlFuTExteVdMVkQ1c2U0TjFsbTJaOUk2?=
 =?utf-8?B?MTM4MFZWSGtiQm55WTBQYVU3VGVOcUlaVVV6bFZuSFlQZXZpVGxaQjdWTzZt?=
 =?utf-8?B?NW5pMVNlYm5DTGw3M1VzNWU4RW5BR2FobmFVSUpBakp0S242R0RDSEovSFB4?=
 =?utf-8?B?WUpTSE9McHE4bklYVDhtREp1ckNIWmVoWlI0OFN2d0ZmKzVTS0FSYnBZU1I3?=
 =?utf-8?B?VWRRSVhEQ3JHcmttTmVKb3N4RTJCWGhHNVF1N1Y2RTIwZXorUm44aHhZaCtS?=
 =?utf-8?B?c0FMTU1LTTBDREhucU1VZk9BVVN6Tjk5QU5JSlh4aVB5L1VMNC9SQlE3VENs?=
 =?utf-8?B?eVNJTUlWNHpwUUozaElhVW5oMU1CdmFweWVSU3ZLa3BzZFFCM0VPVE9vUFBm?=
 =?utf-8?B?UXpMOHhtWlM3RlRzTlQxWVNZcHVHRXZwbTBQTS80VXBBLzA0d1JicVlxbXNQ?=
 =?utf-8?B?eEZtZk9GNi9CTk5VSjl1djM2cEFkNVgyRWJrNUZYSzBhaFlaTGx4NUJ5UFNu?=
 =?utf-8?B?ZkZVbDFja3EvVSt6WGFVdmlLdEt3ZzFFeW1xVkVRa3R1dGowQ2I1R1g3Q2t4?=
 =?utf-8?B?ek80OTFLa0hlQWh0V0ZtVDFEc1BYbVZWeEp4K3M1N2dpcWJoay81MnMrSy9j?=
 =?utf-8?B?U2d0MmJDMFlRMXRPOFZhMGFKRlFjYS9NTnFtRnlKOW80VWs0Y0JlWDhib0Ex?=
 =?utf-8?B?WllSV0tIRXd5RGFsWitsN1RROTZRa1h5NkRNZUQzODZwMjRBT2d0RlhxZmJK?=
 =?utf-8?B?aWRmeU5LZTZBWjF1NnJjQkdwMTVmUk8xNUNVTnpWTHh3dE5vdnIwN0JUdkxL?=
 =?utf-8?B?Uy9GRW54WDBCQmcrYndLOWhLR3JsdXlCbXBXVjc0eFZEenllSk9Ea0lKemJJ?=
 =?utf-8?B?U3hJU0wzSFdHN2RPdDlVYkNUMFF2N0xzSHNqbkNwL05QK2VOYzg2VTNqeTRQ?=
 =?utf-8?Q?Dtoei3QKbJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRBb0QyT2RZMEx6bUtXODB6UzdkT0lYUmtscXd6N1BlZG45V2hJbjl3bExX?=
 =?utf-8?B?S2FLcE92YzRIcFpNczRHczU1b2pCSG5vbXZmYXhkNGpDWThCUTM0amwrS051?=
 =?utf-8?B?Yk1za0NwTzZJS2lWcWpKaFdtR0JGRGp5TXUvakM4YUhNYWUwdTFXYVU2bVht?=
 =?utf-8?B?dmd0RGpMUFBXbWpkYXlESzNxWEJhVW5mejFHSkRrbS9uMHRyb3J6MzF1SGlz?=
 =?utf-8?B?Z1BpWXk2TDFoTkIrQ3BCbVhwcUdPSmJXeTliMWloVHNGQXo2Z0ROWlV1WFRp?=
 =?utf-8?B?Z2E2aEZ4SkF0dkpOWWpacHNRNFh2dzRheElSQ1hzeEgvaTg1OVB6U01hNDZP?=
 =?utf-8?B?RnluakRaWSt2QStSV2c2MDhMT0M4OWJzSnJOcmFSZmdVZS9BVFJTVVVzeVFy?=
 =?utf-8?B?NjVQcmZsWmhNcm1HWHBsWmFDdGhBN0syWmFZTU9QU2FGbTYzQVFWZGtORGhD?=
 =?utf-8?B?OUlzbmxod1RnRHFjTG9iV1JvdDRlNGtwb1NOaWZZZmQ4VVJNY2tseUVYa0Q5?=
 =?utf-8?B?VGs0bXU2ZWNqbFg4RUZBUmtXbk9XeHhTcUROR0d1RjJVQjYwMmJ4TVJBMElm?=
 =?utf-8?B?aGs5U0tLOTNCRWNyL1E0eVdtdmtab0trRnBFclliQzVvWFA0dEIzM0F1SW1Q?=
 =?utf-8?B?aTZuWVA4UXpIRnNEQjNkT0s4OE5FSitUbVhXN3plWno2dVc1T2YxeTNoNzFl?=
 =?utf-8?B?VFpmYTlXWFprT2pyNW9FcTRhOGo4cDZJbmhZRzNnODhqNFhibHJRN0JybzY3?=
 =?utf-8?B?VWtLY0FqWlJ3ZmEycjdYM2NHckF6Tk8xeGNnVldmQWd6eVNTSUI1aWNrck5n?=
 =?utf-8?B?U0QyN0p1R1V4aW9TbnRxMDBCSHV2WW9Bejl6UUpGeCtzZ2R4cGVEZ0I2dEJR?=
 =?utf-8?B?MEZ0YXIxMUdoUm9SZUNlM3NpaVJpUFg4WUZORTFqanRhTDdKZkEveE1xY0lY?=
 =?utf-8?B?ZWhDbSsrd2ZvbFVFTFFybG9nbTdsODlZVmM2aUVrTTkvUWlqeEZrM2ExZ2VX?=
 =?utf-8?B?QXVWcDFTY3c1WFJ4amhJNG5SQmdvVm5WQ29FdldJVUg0OEc4cVpycWN3Y2tz?=
 =?utf-8?B?SGVUSTkxUmNTcnZ0Qmg5VDJGTE85czhITTJjdHQ5ZytMZVJYY2pVbUZjNTRn?=
 =?utf-8?B?VW52d21PdWFxSXlTSGp1OFhvaUVjdzZycUZJeWJmZjhKM1ZQOW9NS0pCVFha?=
 =?utf-8?B?UDQwOXNDaDNmQW85SjVqUnJaSTZXNFQ1ZHJMMUhrdHlEa21ZWllnWnlRVVhr?=
 =?utf-8?B?RXRnTFlqdzRJbjEvTXl2SS9sQ3JhaTU5MW1uczdlanYrL1RSYWgwNUlXWVp5?=
 =?utf-8?B?T052WjhUUGFFWVNscGRzYm9VcjBzNW5KRE1oU0xFMDhacDlXSy9oTHFRNTM3?=
 =?utf-8?B?UWpzM3VROCtIcStLeG5QaWVYSmZUQlFQZllYS2dqUWxRb3lnaWczQ2NrMWtn?=
 =?utf-8?B?RUVtSHAxQ3NRUTNNemJ2NjdlbWVyN25VZXdjZWtZNkl4MmRMektXTzJQdkJi?=
 =?utf-8?B?eWcrblB6d1RMbHJoRmJSV3BrMXdKTWw4clZYVlJaVS9adDJmdlBWeWMzRE8z?=
 =?utf-8?B?ZWk3SXI5a3FZUEplNW1hdXl3MWVQbmsrUlF5aGxJYjJtdkJzWGJabFNzak5E?=
 =?utf-8?B?ZGVKNk9EVDlwNlNLdFVMWTcwMEZHMjh2Q2RoTFNURTg1YzUxMWlmRXA1M0Rj?=
 =?utf-8?B?VjNzY0wxNm1MSjNTN0JSNkl4VjBMNyt2RXk1elowdU80bDFhc0lqSGlMNVZi?=
 =?utf-8?B?YVhacmhuU2gxOFFSZUxlR1pFN3lNM2E5N3dXZ2tWUkw1VG1seTF6NDUrMlFE?=
 =?utf-8?B?N2dzY3VhcGtGZVRnZlFIV25YakVnak9Bc1Y5cFJKVkxzdk51aC84bkphd1Nk?=
 =?utf-8?B?b1VOTnFUS2UvU0xpYVJkdDl1TTA5YmZjZ1VBbEZWSUQvSitla2NwOU5KME55?=
 =?utf-8?B?K2F2dE5mMGM3Uk5oYmdBazlETG9XL3k1OTJVUkxhWTVXVyt0cDErL1hXVDYz?=
 =?utf-8?B?SEc4b0RQakhYM2ZZZlBhNVNZUUVtMTFNd2h4V2VtZW1TbzhCbEpUSjFUUmtz?=
 =?utf-8?B?d05ycVY2anRKYXFUT2x4QlR0bU5XQ3Zpc3BjV1J6UXhjdTIrdE42bjdxWUR6?=
 =?utf-8?B?U29YaDkwMStUenlkNENQUXRTRGtzeld0M3Y5MGJxc0l6ODNBYjNpN3BxakdT?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eb111b-b57e-4c1b-7895-08dde53f0289
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:54:54.6138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv7qamx1yrfjbBnjQlQmC4xTaf0raaETtSMBSH7CXLzmpxYIjrH8/z8EIpQDRJnOCWPwOdV0rf5+isaKsjMUuShvpnZeO0G13moQ5RJERjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
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
> The code in tps65910_regulator.c treats the field supply in struct
> tps65910_regulator_pdata as an int and even tests the value for being
> negative so change it from a u32 to int so that the code all works as
> expected.

I'm not sure if this is the best solution. The supply field holds a
voltage value in uV and u32 seems like a reasonable type to use.

I would argue that the driver should be changed to not use int and
remove the negative value check.

> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/power/tps65910_pmic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/power/tps65910_pmic.h b/include/power/tps65910_pmic.h
> index 2026ec2f426..8fa02f33ab1 100644
> --- a/include/power/tps65910_pmic.h
> +++ b/include/power/tps65910_pmic.h
> @@ -123,7 +123,7 @@ enum {
>  
>  /* platform data */
>  struct tps65910_regulator_pdata {
> -	u32 supply;	/* regulator supply voltage in uV */
> +	int supply;	/* regulator supply voltage in uV */
>  	uint unit;	/* unit-address according to DT */
>  };
>  
> 

