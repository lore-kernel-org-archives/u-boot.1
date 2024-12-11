Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBB1E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834C3802F2;
	Wed, 11 Dec 2024 15:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ZNEgtjDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA261802F4; Wed, 11 Dec 2024 15:59:07 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3832E802A1
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 11 Dec 2024 15:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPGwU6EjQSHAxnxcOGjH+92WPUyE6StLpkCjE1R/ZNpqWPsjKvnFkhkY/txLDokwkmSTN6+ST67dwHKoe+tAypA0W7lMl0L3BQvitqNu2F/gzTBw2Aem9Q3CmyVpmZishN/+CYxlHwwGbMxtF5hJ1uZ5PnaPCUEeGvwP9pSJGPR14A9zsHS5lpkfNZ9LqiZUeNdM2T8R0iQjfkx6yFgQGOq3MV04OqY5xdg2XgnuxGS3i/hAecwcwQZuXqzh1eIUBBrOxaX19kJzF4dHu1ozOSz1p85vkrXY5u16GdGUajlVS5psdi5LelPWbAdD0WEn9lmMmCld8WANVLwvsn22Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5xSSManmEYaeFZ/2LUpZRaG0cJOZtgHyj8SFdXGqZk=;
 b=BIJtYlS5DV3zV/DouyMF694f0rVCLgoVfsHHuRkv7ljKUVP+qIF0IjaA6gAznwTs8WKaR1OBIEFGSraUNXWdXoVcjTNFtyzNu64JT71Pjsqk1Cv+r3SrEKgccZXvdkMcJwqWJYlxEdClnBHPJfqYeuHZWi/PUtOWoKN5/GN8yAX2xf0+YtJfolq3fNF19bVRPxjz2IbFKFDYm1ebDAuUo+nAeXQHZAMZUAWskQJL87VHBVBUVRendtzjGy+tV/2YA1Nw5uLwDbX3V/I17oAQbxaqWMv8pjz6PL2esrhnRHa943FVPoE+MgdHThZuIvu+5dhpL+w/q3/48bUzc0WW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5xSSManmEYaeFZ/2LUpZRaG0cJOZtgHyj8SFdXGqZk=;
 b=ZNEgtjDhOMkSpFsD82kzZB5xMpx2VWFFWWbe5qBbIsGlxRYKabdX+kBDFbSPmnOt6HMzGrEvUzZ5FWvvQSVfwAZLAL9NERXoIuzcBNHc5j6fuelHIQ3gOrw8ggrfW4ArE/fbAPHwHh0AVd4tg49/qLSzJDH7NTfJJLCr0Fvv3UYA/Taz0rGKBRWlGXZ4+76/2pNdv5G0EqM5J+UL8K1Bj6eBA+bDJP6gQzYVSSiDf+0dmtruiwGhCLM0IiUQ4OY9MkicEyQyVjn9FrySZYVduz5/Jn+uKqzAvJ+rGvrWcGebu9N4NhnOINMakHItNOa6KLdRT9C3AFZvHy7UFvjIYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB2257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 14:59:03 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:59:03 +0000
Message-ID: <5aea0a7b-6026-4080-8130-537a11cb6730@softathome.com>
Date: Wed, 11 Dec 2024 15:59:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] test: lib: add test for sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-4-philippe.reynes@softathome.com>
 <CAEfUkUJoZn3=caM6-XZcfDGtavR=0BubNT3RuZdUR84da04Emw@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUJoZn3=caM6-XZcfDGtavR=0BubNT3RuZdUR84da04Emw@mail.gmail.com>
X-ClientProxiedBy: PAZP264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::23) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB2257:EE_
X-MS-Office365-Filtering-Correlation-Id: 870afb81-21b4-4eb9-3970-08dd19f459f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpXUmpIb0h4Ujd1K2dvK0JtNzZPVUsyeC9pa2sxZnRnWmZuYkNBRnZNdGt3?=
 =?utf-8?B?RVNwTmVKUHFpNlB6bkVOS29HNU5sTjA1c1FPSUxEYU9lS2NqaGZGeXh5bnhC?=
 =?utf-8?B?YzREdDVtcGlhWko5TWhwZ2lCOVBPdkJFTElqeUZNQzFRUFFkMDM0aGFJSDc1?=
 =?utf-8?B?d0g1dkhzVnd1SndjVUN0bzhqYVplMlRTVjZqUnp0MmJoRW8wZTdLcHRPWmpN?=
 =?utf-8?B?UDVSVERqa2IyYTlTT0hsb1ErdTlBLzNBMHhNdDNpMkxGSUNiOWpvcmoxZUZR?=
 =?utf-8?B?Um9aWG1hdDREWUNRZVIybFVWMUlnSzc4UFp0N1VoM211Y05jRmtYYjc1MkZz?=
 =?utf-8?B?cno3ZXNTa3lzVi9vaWVnbHdtaG44cmt2djMzU3FRZUgvVXREcWZoRlB3VHl4?=
 =?utf-8?B?RHpuZTRNb095UmZLV0Q4U3UvNGlKSlhkemV5Y05DMlFyZXNCM3ZkanJJZ0Rl?=
 =?utf-8?B?czZBUUhJcjRab1dFZ3ljQkhFTlRxUHR6aG1vSDNWRUhYdmJJS21HT0V2dk9K?=
 =?utf-8?B?TjZUdGh2LzA1d0JRMHdlK0dtTUthUnhBWm9qazRlUWVmU0JRTERSQnJ2TTlq?=
 =?utf-8?B?NCs0VDRHa3FXcFc1cVJpeFFLeWRjYmc4QjZ2RDVpYi93cnRYeDJmdEljS1pR?=
 =?utf-8?B?NWZ1MTdnRlh2VGFqQkRYK3hUendQaHhMQllNQk9xMk11SmxGKzhxSU5UYXhX?=
 =?utf-8?B?ZlJzMGplazVYd0wvMldNRElDUmdXM1R5citRcnZGczg4Z0dWQkxJVDRJTmJa?=
 =?utf-8?B?SFJsZkQwSFYxU0RybTl3NlBtb2lpUWJkSlBlOEl5SFlVU0lnRkQwbXlseXc3?=
 =?utf-8?B?SUxpSzcrVGxxS0s2RHFGb1lxKzJkOUN1WFI4UlhBNWVBajVCdFZFZmRtaDND?=
 =?utf-8?B?VkhZZDZVSzQza2pmNHpCVDc0c3kxL2pQN0kxMEtkTnBBeVFLdjduSGxPRUE4?=
 =?utf-8?B?bTlkdlMyOUhwandTdWhUZWpMaDhjRzJpQ0Vid1l2TElhNjlUaENmUjdUVk9Z?=
 =?utf-8?B?aW01RGYvTFNJdFVlV01ZQXp5dHlXaExjSFlFcFZQRUJlaDVSNEZpdGhTK1hk?=
 =?utf-8?B?ZStPTmYyUGlBSm1Kd1hjM1FEQTUwbzFGVTV0Y0VndUM1R3JYaEgwUFJ6NzZX?=
 =?utf-8?B?QnlzRSt1T3cyZG1MNFJEd21KeitTbThQcEhDOFUwOGZnRjlCZnptZEJYc1VS?=
 =?utf-8?B?M3lLV3ViK2FJbFh3K3FsQ2lpV3NnVjU2amFCbHBzRGx1VnJwb3hpcVVSWEto?=
 =?utf-8?B?aFlybFI4VWFWNHJXQUUwYWpzb0hPanl4cWRoWkJKUm5JM1c1WWhlL0k4Qmw3?=
 =?utf-8?B?dkE5Q1dLNGNoaGRTcCtxTmlGV1UvQWhjK2FReE05MWpFWC92emxmVFJrMDI1?=
 =?utf-8?B?OGYySUg3a2VibG1Rd2JOdDFSdEw3T3ZYRWhsc1BIRmY4RmpORjJERnB4RUwz?=
 =?utf-8?B?VGU1NHhaNk1XOXlLNHYzV1VGSUo0THFaZkkzR0o5aGM0MEh2UW5Ja1p3TlN6?=
 =?utf-8?B?QXk4a3ozaWpGVTJJNnlrUTR5bzJVK3kyeElTMGxkblJKTW1jZlBvMEFoZTlH?=
 =?utf-8?B?UDhBUW1ERXJuMVFUdUVIYkgycjNiK3FCOUtySHlaM0I5VmJPL29HcHk5MlRC?=
 =?utf-8?B?eGE0TmZLa3VCU3dRYjZLdytlSjYwb2xxWXhXeElMbzk0MEg0aXN3SzRXVkxJ?=
 =?utf-8?B?RDJTVmN1RXRER0xwRkovUDNlN2ZIVXRMbnRFSHBUMkZwamhENVZOWXp5RzR6?=
 =?utf-8?B?VVo2THNkSGQvbTVSaFZZU2R6Nzgwclp1VStHN2xITjg5c1Z5Y0duMFFtSUsx?=
 =?utf-8?Q?pI2nEAau/8so6O7rcR9Es+9Zlt9EC14hBgzH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Z2T2huWjJoS2I1OE9VdzZ6clhpMXc0c2hzS2tWdmVhaUU5dDc1akhFaExN?=
 =?utf-8?B?d2IrNG82aWc3WWp1RG0zSWNrNzRtTjZQQjRqSWViKzR2ZVZMdTE2eTdyZUlu?=
 =?utf-8?B?dWtzL3kra2YyUFNkd0U4UVRYc3JUNUhuMlNySHREeSthM21RSkhjblkvK2Fk?=
 =?utf-8?B?M0FiTFBBcWVna3kwMDlWQVJScVVTYVMrWlEvTDRSZFB0ekhZdVZJdWpWbjg5?=
 =?utf-8?B?d29pbkVQamM2OUpwVUlhblNHKzVGQzRENDhKc1pCTXZyS0NsS1laa0d4TnBD?=
 =?utf-8?B?WTdydE9DVWdxMjEzcDNodklFWWlpeTJjUUJhYVBWZ2t3ZW41Smp6UDI1Ykhn?=
 =?utf-8?B?alVwOGZGOThzZDZPczVkdXYvbHNqRXJ6cXhKRzBEZ1o1N05URkNBcXJFRFl6?=
 =?utf-8?B?aklYZmFCYzNmbDE1MFJxWE1zK2htKzViNk9jVGlocTFUTGYxTURXQndmSk1y?=
 =?utf-8?B?eVYyYmZtaFZKQ0tQRDBpdTBYUDRGNldPOHMvQ05NcFQ0QUtRODE3eVVvaHg3?=
 =?utf-8?B?SE1iemtFM0tRaDlhYTlMZ1p5dXl6c2dJV3JobXVONmcyWTlqMk8vSktKZ0cy?=
 =?utf-8?B?MnhyY0ZWUVJXcWpQNS9BNTIvQXVOaHV3ZWRSNVJvQUFXcmlJVEFJK0JGbHFv?=
 =?utf-8?B?bEgrRjBzZmJ6YlRGUjZ5QWtnZnNTbDBoazR3UVhtd0ZkRUdEOFRwQXdrUlgz?=
 =?utf-8?B?bFlYUlcrU0dJaU03MEZKbnFVOGxlYnkycUtMTzVieHVHTjBKV3RHdkxQcTR5?=
 =?utf-8?B?Zm5TVVppV2JPOVVRUXFFY2hkUTVkZHlnMmdWcjFkSEhwaG5JUVcrRFl6bDJB?=
 =?utf-8?B?d01zNnFGYTBRMlo5dTBTa2d5SGRHbDUxQ1IyeGR4MVYralFXOFB2T2Vsck1r?=
 =?utf-8?B?dnkyb2FRSHM4UTNmdnVmWkpGYmZvczQ0RExWUUppTGN4WXoxc0hJdHZOd1Zx?=
 =?utf-8?B?OU9yaEtKUVBTTVViSVJBUGZpTWFxV3BOanlVdXV3WVJlN1RPdU1zdWM0NVFi?=
 =?utf-8?B?S3lROG1Qa3FWbDVKNGZWV1NKZEJQL2NLZ25lTnc1Q0tLa0xqSXBjYmNjS0dM?=
 =?utf-8?B?Zy92SDlLN01GeEJKeUEvckZ2VEU1aFFBNjZ4alJTZlpGRm9pSm9kMVE3anJH?=
 =?utf-8?B?V05iRWJXWFVPSkhjeXlJYlRmNU5FR1lrWEhtSTg0UjFRUHhDQkUya2k0ckYv?=
 =?utf-8?B?V2QyeVhhUzI4Z3RCYTBEL0tUYVBiODZWNXFjcjBnUWNJZ0tOOEFSRmhmSElv?=
 =?utf-8?B?bGhoRzJMZzRrQ3NzS05Tc2MxcDZxSG5PM1VUTkV4c2pXQ0dKOGJqOE1IOGpj?=
 =?utf-8?B?Vkd1cTN3MlM3Q3pCWTdHZTZjRnpHU0xKNlkvME9ReVZJb3RtNUJNQU00cDRw?=
 =?utf-8?B?VUJYU0k3anViRDdrdGVtcVFWVG5zS2lWZ1BqUjhsT0Y1ZHhaS201cEhGWlY0?=
 =?utf-8?B?WmxPQlMyOE5qa1BSU3N1NlVtejdMdjhydm85UEdLeEZrY2JjeTQ4RXUxM3Vz?=
 =?utf-8?B?bUwxczczZytjQ282VU0zSlFoOEFQRDR6b205S2JrYUFPUHBYS3ZMVWx5enl0?=
 =?utf-8?B?dUNXUDkxcXZ1TDNLdnFHWmNpdEZqRDNDUllJc0Q4N0JRSjRkZkppSjZGNnNt?=
 =?utf-8?B?M24wQnN4MjFwUWcvTlg5ckh0RE5mL1pWeTZJcHAwRkF4TlVRZFo1ZE9GYS9B?=
 =?utf-8?B?VTZBWDVMMjkySWdiY0Uxcm5QS3dZdFRFVXN1R3Z0aTh5dVA3NzdoMDI1UjYv?=
 =?utf-8?B?NjVsb3VJbXR2ZzJGZkxlV0ZMclVRaXFEYWdGNkhzMUl3ZDFzN3JFTU9zQjRY?=
 =?utf-8?B?RHJvbXlGa2hoalNOK0N3Q3IvTmtSTnVwYzh5ZmhIS3RmZnFBT0lHYWxtWTBx?=
 =?utf-8?B?TkFFT1N5US9GVkZEYTJ2ZTFlYmx3bVhNWDZra0svUXJPZ0pGdWlSSmhyR1p4?=
 =?utf-8?B?Njgrc0hYb2VuV0JxdE12OW1ZRnd0Z005aGE2Y3JIVUtFdDJXTHZyYjZaSjE2?=
 =?utf-8?B?d2tMNFhtMUdzK2pteWYrWXNoRFloSXg0Ymg4QjdZRkhDODA5YkpqOW13Vzdz?=
 =?utf-8?B?QUk4L0FUanVDZDhkK3pmRWhESEpQbEYxQlFJbjIyZFR3eXYxY3BvUUtsMWs1?=
 =?utf-8?B?S0xJZmlRNFhVZ21WU0d5NkxtbVdGSFkyZmNPNXNTaGJsM0xVSzUySzZ6cW45?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870afb81-21b4-4eb9-3970-08dd19f459f9
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:59:03.1168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0iRGhbP9gutV7RYLxe05ahlPQXmXFIRWpQ+9rgHgzhRBz5RbNSAb+GH5TiUg78mcFtT5slO+Ab583GuMrwfg7OCbL/CFZMzEyUaZsAx9BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2257
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Raymond,


Le 09/12/2024 à 17:13, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Mon, 9 Dec 2024 at 04:42, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hmac
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hmac.c | 108
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 109 insertions(+)
>      create mode 100644 test/lib/test_sha256_hmac.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index f516d001747..4c0abcba81a 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>      obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>     +obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
>     new file mode 100644
>     index 00000000000..473922bd9b0
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hmac.c
>     @@ -0,0 +1,108 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hmac functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hmac_s {
>     +       unsigned char *key;
>     +       int keylen;
>     +       unsigned char *input;
>     +       int ilen;
>     +       unsigned char *expected;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://datatracker.ietf.org/doc/html/rfc4231
>     <https://datatracker.ietf.org/doc/html/rfc4231>
>     + */
>     +static unsigned char key_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
>     +
>     +static unsigned char input_test1[] = {
>     +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
>     +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
>     +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
>     +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
>     +
>     +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
>     +
>     +static unsigned char input_test2[] = {
>     +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
>     +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
>     +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
>     +       0x69, 0x6e, 0x67, 0x3f };
>     +
>     +static unsigned char expected_test2[] = {
>     +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
>     +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
>     +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
>     +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
>     +
>     +static struct test_sha256_hmac_s test_sha256_hmac[] = {
>     +       {
>     +               .key = key_test1,
>     +               .keylen = sizeof(key_test1),
>     +               .input = input_test1,
>     +               .ilen = sizeof(input_test1),
>     +               .expected = expected_test1,
>     +       },
>     +       {
>     +               .key = key_test2,
>     +               .keylen = sizeof(key_test2),
>     +               .input = input_test2,
>     +               .ilen = sizeof(input_test2),
>     +               .expected = expected_test2,
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                    unsigned char *key, int keylen,
>     +                                    unsigned char *input, int ilen,
>     +                                    unsigned char *expected)
>     +{
>     +       unsigned char output[32];
>     +
>     +       sha256_hmac(key, keylen, input, ilen, output);
>     +       ut_asserteq_mem(expected, output, 32);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hmac_s *test)
>     +{
>     +       unsigned char *key = test->key;
>     +       int keylen = test->keylen;
>     +       unsigned char *input = test->input;
>     +       int ilen = test->ilen;
>     +       unsigned char *expected = test->expected;
>     +
>     +       return _lib_test_sha256_hmac_run(uts, key, keylen, input,
>     ilen, expected);
>     +}
>     +
>     +static int lib_test_sha256_hmac(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
>     +               ret = lib_test_sha256_hmac_run(uts,
>     &test_sha256_hmac[i]);
>     +               if (ret)
>     +                       break;
>     +       }
>     +
>     +       return ret;
>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hmac, 0);
>
>
> Can we extend the test cases with:
> keys longer than 64 bytes to verify proper key hashing.


Yes, I have added a test for each test vector provided in
https://datatracker.ietf.org/doc/html/rfc4231

And one of them has a key longer than 64.


>
> Regards,
> Raymond


Regards,
Philippe
