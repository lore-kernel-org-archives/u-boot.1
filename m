Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C50EC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CC98210D;
	Tue, 29 Apr 2025 14:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CQ3Sc6hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E1D82145; Tue, 29 Apr 2025 14:15:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DB680BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPzs7kIfACKV4FRbvWa3H9DQswbVGY8zcs+mCqU8yOZ9THopYITBvueyzvQmtQnSbIctRTX9K5lKLNMl407IRZ8Z2R7C0omOh+M8gOShtFsFGFD21Owpnc6pFnWvLnLGWRoTKjiXlxVi4eoSeEDPOpe4J2LVjrRKePzMv6OfSrdcyUQLlETGkKfs+ERlOjO9Gx1NDcEP8XCd0XAERvTLor0FUT78kjMT6+SjX5JWk9854VsrLcBJKUEqVPMAmVyAJ2Tupo+VoqgWt7iRb/Czyr0P2krP8EXQN7sXWgTA1FPv6iZsjhP0ZVwfL345Xztf3tLKY6cCqWgErVmROR86rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWj8yXU5Vm5JCv3XU+PlIXpGJs40GTvB0nFv/5uE3v8=;
 b=NsCl/DotfxmXjjbN9bKHBjwnyBq2kI2AnUhO9RKSae0AttSwZQu8uyzfwYqL1uVjm5Qc1R+JjiRzQZ0x3+pedv0Oy/71LtZj3QBrKcpYEGGEA130kt7Tu79O9XqbzxfMPA8Tu9pPWbfnfmK4r4SX5TZ0wqmsuIm57HeRANIzbg8mWF0DXyM/i8BC7ngSATpCYF7O3Inov7QsSUjwEfzzyg+s0QnHhMITv1t3Xygm5s6Opd0qqNicU5nRn/yaJJQO+A2kyhb34kq2eI7B2dGFcXpWCg/RhNXVw8b2w5dgqLdkCE/iA9allNlDiO35gmsrjALDK8fp6KvMt62/bDHHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWj8yXU5Vm5JCv3XU+PlIXpGJs40GTvB0nFv/5uE3v8=;
 b=CQ3Sc6hm0wdeh+4jlWRXGRGbSR1pqCYGerrvAdF347SmNNS/VC3sxxMm3WvFsIwjuabj8uBGVdt/Hr24OFGRtwpbUmc3eLogyo+4rm27HkRYsisLKHqtlOBQucGODMZhwbz/SKxf2HsxNC6n1p7CtXPTGZVeshokjJgUlr8a2Z/ycYESbM1yAhylhFTM4FIZClkLDFwufRhQ06XRLcnIFaC89rphU0Q4YThl+ISkrilHvUv/BOcbQO8HTrVTAzPpjGpYMaAz1TmHv7yB7oEvjewpiHn9YZksbWp+rrd5mwv42mpvBOoK6fXe3GjntMK9i8LwnoW5ZUtJtML4U0ChNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by VI1P195MB0573.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 12:15:04 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 12:15:03 +0000
Message-ID: <4635ba6c-de1a-4c31-8823-7cc97dda3fc1@phytec.de>
Date: Tue, 29 Apr 2025 14:14:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board: phytec: phycore_am62ax: Update Environment
To: Tom Rini <trini@konsulko.com>
Cc: ggiordano@phytec.com, w.egorov@phytec.de, u-boot@lists.denx.de,
 joe.hershberger@ni.com, bb@ti.com, nmorrisson@phytec.com,
 upstream@lists.phytec.de
References: <20250428144904.1058574-1-d.schultz@phytec.de>
 <20250428144904.1058574-3-d.schultz@phytec.de>
 <20250428161051.GC5495@bill-the-cat>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250428161051.GC5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|VI1P195MB0573:EE_
X-MS-Office365-Filtering-Correlation-Id: 289a840e-76dc-4a5b-9984-08dd87177868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmRORGh3ZmcxRUkwdXdNbXpDUmxhdU10YWpOSU11NzVKU0tGZnVaQjMwZWdL?=
 =?utf-8?B?dm80Zm5HS2pWQzZvR0RPemhIeU9acEM0NEh4TnRyb2tQRzJsODdtbndRbU5S?=
 =?utf-8?B?YmJrOUcwZ1RDRTNlWWdpY3U2a2RvV25JaFpScnJ0a1ZYUVltTE9mSmRQOUFw?=
 =?utf-8?B?TFRhWEpLOW5kRDhjTHNaWTI5UFhXSno2a0l5UnFuTTZ4R2V5TnlXZ0psVG1V?=
 =?utf-8?B?M2EvM0pxME0yOE45YWxuVlY2d1FVZ28zVlZnZzJxbmRGQ2VyYW1jSVFlSCtJ?=
 =?utf-8?B?NG02WWwyQzcrOVEwQTVtK0RjOEZNYUZ1eEVjdmkvQkxmWi8rMnBNYVV5ZEVr?=
 =?utf-8?B?cnR3ODdZdVVENURBZEEwWnZ6K08yU0x5QnFlZmJWK3N5YlRTcWM1YmlDOFh3?=
 =?utf-8?B?dVl5TloxaTh3bDB6cDNWTnpwMXg4MCswa0lndnF0dklEc3RWNXVmSGpSNm5v?=
 =?utf-8?B?dlJQd0tVVnl0a0ZvNU50MWRmTVhXeEIyNXk2N0U0ejVnTUpCajdPeDY0VHlO?=
 =?utf-8?B?RDVqMmZqdi9jY1ZXQkYvT21kWEhTM29XYlpoaWtqRmR5cm50SHl2RmJGY1Nn?=
 =?utf-8?B?OXFKYkUwTDBvbGR4TTl4UGJKNExGejNDNWRISHFBK3RXMEsxbUZFWThyMHor?=
 =?utf-8?B?bkpWVFVieHY1QlFsSWc1UXRXZGJEVHhXWXU1TE12V1RZak5TRDY1WVB4ZjFR?=
 =?utf-8?B?SXcwVHc0YWNQRENEbmM4S1ZjT09ueHN3NGhhWHpnQTZRdmNEeGw5Mis0WHVM?=
 =?utf-8?B?b1dDTzhTU3FlcjRNbXhXVnFQeGNyNUlpVEFPclhxOHVCUGM1TWRCY2N1R1lm?=
 =?utf-8?B?aG85ZkJjVGlrQWEwcjc1R3luc3NDVncyRjFaU2FQaDcxR2pNQ0Z0ZVg0ZHdn?=
 =?utf-8?B?QllCN0toRW45azNlOGN6VUx6cmpXMlA5Wmp1QlN1N0xPWnNXdzZRaysxWTNL?=
 =?utf-8?B?REpzVDlPWlEycnZkU0FGcUVBZDFMSlBRQ0ZhM01UOC94KzhpTTlxbC9hN2xs?=
 =?utf-8?B?NVQ2ZUc5WjBLdkgzVUxVcXljY2VpSFJ2aXpXc1FUQ040RERMM2R4NUxlNUN1?=
 =?utf-8?B?VTFVdEorNDhZeUsxVkorY2ZSNk9JTjhDOXdWWXJROFovNXpTdHVIS3hwWnh3?=
 =?utf-8?B?SEZtRHR6K1E5OXJJNi9KOFhkUlJMa3JxdC83Y05nSVBmWi9PN0tMZDYxTFRC?=
 =?utf-8?B?RDB4aGpVWFRyR08yZjNnWEthb2oxQ0xFWWNOWTdVeGJJMTNxc28zZmx2RjNP?=
 =?utf-8?B?WW5BNFZCcHlZMkFqRnVqKzdZRU1oalR0NWM5N25pdDE3M1IzZjA3ZWdLZXlm?=
 =?utf-8?B?bVhOWk4vdjgrdTF2d0RqbzJNc1dYdXorak1CMm85NmVPYWxwdVBzRXVXcFgy?=
 =?utf-8?B?eE5aWkdLdmwrc01KbC9MUDVqeXRWMnpnSFl2QXYwd0E2dUFnc21iVE9xdkhz?=
 =?utf-8?B?MzBZUzVmbjl4OU9VSzVKNXpPZE5RWU5MNzRackxiem5Vb1hGQ3JuMmsxT0x2?=
 =?utf-8?B?M0FXTmJjNjRKb3YyRk9QejRlYUZvMHhzcVIvM2llelQralp3N3VHdDkxS1Z1?=
 =?utf-8?B?VG1ubWNyTC9TQ3lHczgvKzVxSzJMT24vL29zUlp0Y2V4YWo4TTRmTWl0eTBu?=
 =?utf-8?B?ZnlEcExySjRhaEJyNVZCa2tWamUwYjVHVFRtNFZsWm16UmRFUzNRVzkram9q?=
 =?utf-8?B?aHRyclNURkh6YVlWOUJ5L1FUZGtkVERXV0svcEcyR2lETWtyQ2Q5SEE0Vk9B?=
 =?utf-8?B?VThqV0xwcCt5dVc4aEEzWjRadDRtN3dhc3p0TGdXMmRkdG90YkV6ZkZRS1ln?=
 =?utf-8?B?MFowZXNrY2F5MHdwSzVFZ1lRK09SdW5kdWJUcmdyUUhISUNmVllWSjhVUEFs?=
 =?utf-8?B?YzZDdG84ZG1ZWENvczlyNUYxbzJqMExXbWRza1Y2M0c0OUw1alBjU0tPODcr?=
 =?utf-8?Q?YokOx/hkuUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRWTkhHMnZZcFBLSTBwK2xYZ1JYQ0FncUcrL0NaSzlHdS9yeXBPL1pHWEFl?=
 =?utf-8?B?dmV1Yno3T2M1RHA5Z05Db253Rm05SWJVR2tpNmkrb2MxeDI2ZzRoNmJvMkVt?=
 =?utf-8?B?THFMKzhtUDFUVGtpM0JaL0xvNTJXNEUvTkVvL1VSeTNzZGdTMFJLaDR4WnND?=
 =?utf-8?B?WE5DMWdFZks4UjlRcnJZS2RTTGJDOU5LMHdzK3hWM1Z0bGgyUEY3eVBhR01B?=
 =?utf-8?B?c3V4Y29PME5PcFFrN25MZVl4NDRzNzFOVS9Bdmw1Q0NBM0JrQ1BsVWNqNExr?=
 =?utf-8?B?V1Z1dkFtVzRHVXNWaVVib3ZiUk5tclRGbHlDeUIrNEpTbmRTcFNIeVMwRWFS?=
 =?utf-8?B?eW5HSHZpK0h5MzM0aFZna3dWQkNWejFVZlc4WTBCRUl1OHFweG5ybDE2UlNC?=
 =?utf-8?B?bUMyK2Z0V2dvUXFBQVVxeE5JNDhhekJaQTFnYzhEcjJHQWhiWFhTcElqT3lU?=
 =?utf-8?B?V1IzTUpSZ21KNzhZc0tLc0FzZWN0Lzh5M0tpOWpBL05zcWJCeDhITTVzVjFm?=
 =?utf-8?B?aXREYjFjTzNjMjZwcnVzR05RZHM5Tmc1S1AxNGt3SW9NU1RxNGJLb2o0QldW?=
 =?utf-8?B?OHdkQ0VUMTl1RVJXQ3ZBQXJ0Q1BnQmh3Q2NYNnFQQ0tYZUliKzhLMUlJcllF?=
 =?utf-8?B?YVRXWWJFQWdzenB2NjZ0cVhJWmEwazgwYXVZMTQrNS9CeStqbThDQ3ZaYWRV?=
 =?utf-8?B?cVhWZkhnekxlOFVuYm12bW9BV1Z6YzVUY1NRWk42QWRmNkhsNzBjbVBvOXVl?=
 =?utf-8?B?ZnNsWVdEaXdNWHB1Rmtrd3BJVjVtM2hDMUxKZWZRRDNoTDNYeUVERGJEWlo0?=
 =?utf-8?B?V3A4VklyUThHR1kvL0VlZ2JEWXM0cnBrZzVnai9jZjhsS245V2UwR0lHcWxJ?=
 =?utf-8?B?aEJDNUNoQkV5SWE1a1dPeXpWbnIyZ2hLMkEzNExQNG9VbXBicXJwQ2tiR2xV?=
 =?utf-8?B?UlR6eERuU0NqRmdYcWhLb1gzSzM2NU1yZ2h2SWJITGc5ZEFXcDQ2WFpKN3dw?=
 =?utf-8?B?eHJEWjdxaTFPNWw2N0FmdURTTHBpS3lwT3Z4NlVieWltYU5wRnIrZ01UT3Vy?=
 =?utf-8?B?aCtOcnpyWmE2WERkL0ZJT3lOMUk3eE4ycDdwYko4NmhwWk9rQ1FSd3JNK2ho?=
 =?utf-8?B?S0d1RnZXSmZFOWIzcG1adFhoRTFmTFpMODcyc2ZlUjJKYnhNanBaYWRMTkhv?=
 =?utf-8?B?YWRoVi9DTldvODlTbmtlb0htNDlsYmZGYU81Y0huTDMrbUx2WnlPdnFRQnd6?=
 =?utf-8?B?dnZWUjR6TjdZbFAzNFkycWtTOUhjNklLL0QzQXhxK21zWHMzZXFEcEYzWi9G?=
 =?utf-8?B?UkRpeTJsMDlyZHRYb0JqVkZ6ZkdpT0ZlS1VmU2VlREpvaWQ5Nk4wL0daUGtZ?=
 =?utf-8?B?dUxNYXJLaktSOHExQkk2RG5obkpuaFVFeksrVlhVN1VPQkxvb0E4RHNJeTNy?=
 =?utf-8?B?RWZDODArN1ZuWXU5cElYVjM2TVR0SW1uRXRlci9jTytDOFBFNTJhSFUrS3Fj?=
 =?utf-8?B?eHpNaHg3aXlMdjNZeGVVSWNaMWI1dlpTSG1IRjNjbG02N1JqcTJrajNONFBW?=
 =?utf-8?B?bytWenlGSk0wZzQ4NzRvWlVnSTBwcVZBZU55SHI5V1VyU2JIYTYrUkxzbGpI?=
 =?utf-8?B?aHEzVmNzamd2cmdMdmg5RUFVNE10TU0yQllVeHJKWll0d1h4VnlxTTc4dG4y?=
 =?utf-8?B?N2FORXo0WTJUZlA2RGFZKytqNXU0c2VOZUtkZCthS3V5ODBMM3dFUzYvdU9t?=
 =?utf-8?B?M0J0WkpNTkJETE8wN3IxcDV4bnBXRHpCaU1qS2JVQW5DUnU4c0pYMkxKN1Qx?=
 =?utf-8?B?N0swQ0o0SHhBMU5wMnF3VGJ0NUoyOC90OGZRT29SenNDVXYzU1h2bGFCNERj?=
 =?utf-8?B?WVhVMGpjTlFMQWIzKzFDSnBnYlpBc3luMWdsREJzcXRhRGREU051OElIUkxm?=
 =?utf-8?B?bloxNFdaM0x4RTZrcXp3b0JSNmQrTWIycisyUE9aU3Zrd1FMeUd2NUlxaGhU?=
 =?utf-8?B?aDFpbGY3Q2tCOWZlTmJGeUt1a29RVmhvV2dwUUdQeU9kYUtWTUZ6alVHVG5t?=
 =?utf-8?B?UWcvdmZrSzhjdU45ZDIxQ05kQlNHQVRONHJyQ0l1V0VyZXVkK043aEt4bDMv?=
 =?utf-8?B?dy9peVpPTmg5eHlNNUFVRW9SQ3BJbjJPRUR1ZlRhMGtrMGxIYUpMRGRadHkr?=
 =?utf-8?Q?xw+M/jnkX93s+F5IFCh7xViTwClnPAIH5w1Jav6WRKfr?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 289a840e-76dc-4a5b-9984-08dd87177868
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:15:03.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDaSHGHZIXAJ3SbqJxV8tMUi96eND032wBWws59XdMxb5hsL417Hj/+sO2B7SiRzMfD1Kea1KKrLoXPvVxrowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0573
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


On 4/28/25 18:10, Tom Rini wrote:
> On Mon, Apr 28, 2025 at 07:49:04AM -0700, Daniel Schultz wrote:
>
>> Add fit_addr_r to the environment to allow us to boot from a FIT image.
>>
>> Increase the maximum Image size from 23 MB to 26 MB by moving the
>> initramfs start address up. This gives us a bigger ranger to
>> provide kernel images which are not stripped down too much.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   board/phytec/phycore_am62ax/phycore_am62ax.env | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> What is the minimum memory configuration you have to work with here?
> That's still a very small window unless you're shipping modules with
> 512MiB or so.
>
We currently support SPI boot on devices with a minimum size of 64MB. 
Our kernel image is ~22MB. So, this change will make sure the kernel 
image still fits with future releases.

BTW, Wadim sent patches to enable standard boot for this product. So, 
this patch series fixes some minor issues with the legacy boot flow. We 
just wanna make sure we don't have broken boot flows upstream.

- Daniel

