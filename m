Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAF5CF3180
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67001892EF;
	Tue,  1 Oct 2024 22:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hoggsiXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D6F892DB; Tue,  1 Oct 2024 22:45:11 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF26892F2
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIXy8MnklqLGBnQ9qNWStNLMCa6P+4zQVbKZ3IwcumVKMnqGRIWjiyYOMb2H6H7S/HQFoH2OSB68wy0Tsk51fdi4NsM5RwTS9q+PnwSXvBhbtWTQwmKi7BjFq2hbRerFquRXCKNBIZOwmLJrxgcAwW8rlWm8J4AB6ycHfys8T2wAxr8QBblB3TGyh+UFcdwlvg+OmDT37w0SGvRKFHsbV3T/wxAwqUpmHCw+ZE29WSR9dN+Au1tfxpR7YurecjiRpmQAuTpxHkCOw+HNzoDYZ56zYUzXjFw8VYzy5RqfnYD9E/W/FBXz2YAodTgckHlfUTzWrrd9vYpZtDlP/PZF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2TuJ167zXF+4597y/mltm7CeNOCfUl7PLEvbi78QY4=;
 b=wwk4A4gpvyuqtXzZtPkoXB3khQsv6uIDQ4RgoR4MQzbj2D44Cu5IXHYaYRs8Do455toAWlVZaA160Nd1+dSw43/bDzndgSRTFp+9kyvUOVoj7TLSZDdE/X/A+BrSVGvx+AhXI+LM/HoGi1+wPgKyYEg4OZh7jDnK63LXdQammPXELnU9WwgGFKNkBIbU/GUH7Cv9FPW0Wz8HzcgSbzyIebgoYYDpl1kJnEma4BrxP89kTShNy42G5GA9V879HY/vAdoaNRWf4s9LpYPqygeC/Swh9UeBsPey/KKa4TOXck3O64/Wpcg8zU6Zqz3XhI1/j075ntNIrPvMm7mBjeI2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2TuJ167zXF+4597y/mltm7CeNOCfUl7PLEvbi78QY4=;
 b=hoggsiXdGcezA+ZHbgWCV1iYoePK8kS+5R19JY3vXVYmP8RunKuGlH0jpGpme435i0Ch3mI6rnEUG5O4Kmz+OMSON2cgjLn1G+q2xdU6qPB3sfYmK+/LWWDKhEPxBSIL7br8wThSkJz3bT4KV07L1ZVWGC85uliBsM6AIrTmu8bgN1qqm4DsiwVDB8/YRuSpW7U9/kbgX+5IExppyCd4renCfw/m8Oxg/kas6/kyphN1QQvnP4QeMJiBSyJiPUAZeQ+2wi1hKLN5X1FJwqtWi4TwFDQMFZFoELn0Tscu/BMhVpg1kYTSSaWAmBVodZZlxm05MJtXL/RiD8PEKBxu6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:45:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:45:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 10/10] mtd: nand: add initial ecc engine support
Date: Tue,  1 Oct 2024 23:44:42 +0300
Message-ID: <20241001204444.917238-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4da529-76f4-4692-8735-08dce259ee1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UExTVDJIbHF5bFZjZEVWMDA1am9OaktWUGdPeDdHamM0dHJ5S2s1cmRTMWNq?=
 =?utf-8?B?Rlc0RnhQMWhaMG5TRUF6V2doVHBUZGFVcmRQY0syZFRYV3dxZEZLeEt1MjBN?=
 =?utf-8?B?c3BXZ25kUVFuUSswc2g3YVJkUmJHS0xucUZVYjI1UkFxcWRhd1lZV0R1Mnky?=
 =?utf-8?B?Z25rZncwY3I0R3Nqajc3alpabEhoQ2RkMyt4NExTTm1DRHhwV2RBcXBwMktz?=
 =?utf-8?B?L3RaNHd3S2F3TnUvYnZDdVV2dWJibjFsR2g1anFpY1B3cHloZVhTTElmSE9M?=
 =?utf-8?B?SXdpMjZJdUFlZDhFR0IxZkk0VC8wOG1tZzR5NDZxYWY2d3QvT0l5Q3I1TGYv?=
 =?utf-8?B?ZGRzdHVjeVFPY1MwYlNvcWxkYzhuZnFSREw1UW44eWlwbWVTL2J2N095aWJ0?=
 =?utf-8?B?ejljZXFpMXR5STRPc0JKN1RzVDRPa0J2R01RSVNGU3Z6OTJDVWVBWEIzbjV1?=
 =?utf-8?B?Um92dUxOOXBjakU2Vjg2SlZRNDlOOEdwU3hDODRCaWFtZUNRVGRlUXVsWnFY?=
 =?utf-8?B?SnpQZHpNNjJaNzYwNmFVQ2xUNVh0S1pGa1JZekhtL3orSUlJU3JNTkVpckdp?=
 =?utf-8?B?UUs3L0pqY0k1L2pUSFArZitlOU5RczF3OU5aMjhqaXpKZDZML3Radnl4RDNi?=
 =?utf-8?B?NlJXZmswZTdFSVZSUEtZb1BnTVBnMExjVHFYaStqaStwQWYxYkppSkVmQW0w?=
 =?utf-8?B?ZUNFck8xN0RnWXp3V2JXd2d2UlNlQ0g1UFczdXJmR29QTytuSzkzb0dNcU1K?=
 =?utf-8?B?aUVZRGhzbndDQ3lUR0R5d1o5TFV6QUNDWXh4YUFqQjFXdE5DRUJ6Y1F6Qk0z?=
 =?utf-8?B?Y3ViSXJjYkZUNjExWWZDN2ltTTNHVTVGYW9pcjArV3pPazRVTnlCSmNRRlJ3?=
 =?utf-8?B?czlZZi9VOTFTblpqSHF1WnRwL3UwVnFwUW4zSm5MRytteVBIN3NtMmhiNEtU?=
 =?utf-8?B?bGpBMGcwb1FJSTl0SGYxazVUQ00vL3F1U2xaQXhlb01zMElFb1FqWnhvRGtj?=
 =?utf-8?B?dlZtVFZXNklZb0plVzl6QWNaUnNBU1h1SEVlWjFBMFQ5Y1kybkFPanlQNTVu?=
 =?utf-8?B?ZTl4cWdISGI2VUFDcGRvWTFLV3p5dlVQSVo1bEVXSmV0QTlhdzBDaWsxQ2RP?=
 =?utf-8?B?V1FjYlgweVhVSUo0cXhSd093clBGYmNVaytRRzZhcE9xWCtWZlB6ZUU3aldQ?=
 =?utf-8?B?bENsa1ZxOHhnalhlK3hPRGxZamlPQVRGRFNyQWtYUVVVMURsdnVpTWhUK2gy?=
 =?utf-8?B?N3lKN3VYM25FV1JtRkNFdysxWm0rZi85MjNqTHZMaURlUDVTQ285UDRidDdT?=
 =?utf-8?B?WlM0eGtzTkpVRnlSSWQ1ZzZSQWJsOGRPRERkWWZvWVp5TWR0SFVJQzRndlVz?=
 =?utf-8?B?cmEyQmRFcmhoZnZESlFTSjJtT2ZqZjhyUkt5VDVQWSt6V1k4NzYydnEvcTdT?=
 =?utf-8?B?VzhRNzY3c0J2cDNhalh3eEs4MEVFQ0VIM3VHZ0VPVWNwS0VZSFdVTVY2eG16?=
 =?utf-8?B?eU1sWklyaFM1OEU2TzA1SFFaMUhlbkRYdFJtYVY3ZjZqY095L0R0VXpJZk0r?=
 =?utf-8?B?OURUQ0N4Mmc5V0xJb3BvWmd4bFZJYUduYnVRNkRlaC8yTHVxbG1kWDFwTTdX?=
 =?utf-8?B?YitxeTZoaUdaMWwvcnRrT1lINXUzVllnY2RBb0Zld0ZLMXlBb3hSaWFTY2pU?=
 =?utf-8?B?bnZJUGpFUWNCSnRiNzl3Q1J5SHhLdnZmRE5rL3VJZHFDdG40REZaZnN6RUVa?=
 =?utf-8?B?L1hiVFR3aUcwU0FOajJ4SUpVRnByMTFPZ3VQT29HUU5IMVdTRzUzbEpDSWIw?=
 =?utf-8?Q?0qcFCcpd18VygcwZ9mCMjkrj2DvuMZGdhSl1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtkYkZ0ZTR2ZGMwM2FKWjRuMkcraEdxTE9OM3lIT3FFVjgrYWxDWGVRdzY5?=
 =?utf-8?B?aGtodXRva3daRWtDSEx3TkdaUW55aXpBMXQwa3pvZnZJVXVqa0FjSTRieWta?=
 =?utf-8?B?b2lQeFZHaG0vbGRydVhKUDBHcitMa2J6Q0xmMzFUUHRhZXYzdDZLVXBPcXk1?=
 =?utf-8?B?enkyaHpiN1lzSitsU1JSaGVDTlMzWS80K0h2UjIybUtnSTkwQ1gveUFMWHFK?=
 =?utf-8?B?L3Y0end0ZXR2OXVCQ284a01NaWt6Z1lReUVuK2U3YlJmQW9LR05KeGs2R3Vj?=
 =?utf-8?B?aGhYZjdqa3JwOWZ1dGNvdlJaQWFSd0tYaEQ5amV5ejFwVW1jdTg1ZGlwRXdk?=
 =?utf-8?B?OEd6N0xxWEVLNEVxaUtpcThPbG8vY3IxQk9vZ09TYW9MMys3N3IzVEYxNFgv?=
 =?utf-8?B?SDlhaW5QdDA5N09zZXJtenhWVjNEUzRsREdIMzJIdWpXckhhaFFMTCtJZ21n?=
 =?utf-8?B?WmNadUxhNlN5MFkxSjVCaE9xWVZSMEdSVXZnRFUwZ1hLKzJpeHNVTHU3dUQx?=
 =?utf-8?B?RmJpK3ZDbTZwakRSWHkzbWN5N1VEanpPbCtNTXd0Y0tBRVF4UXN6amtpeFNw?=
 =?utf-8?B?MXllN2oyMTIvWHZqMis3dm1XMlNIaXF1ajZNNXYyaHFud25aRFp3dmNSQ05U?=
 =?utf-8?B?Y2Jwa2orNDlWZDRVQ2xNTTBQWWR0ZG5yUHJCVE9uWEZGRnpIVHJuczVRdlRq?=
 =?utf-8?B?T01aQVFvS3Y2eDNBZGsrWVc0Q0h0ZEFIZ1cyeXlqRGFzUmlxMVNxK3ZYQU1v?=
 =?utf-8?B?TnNkeDRmTjdMWmt4RWtUR1RsVDZsakx5ZC9reDlLUEdQREtFdzZ2TE41Z3ZC?=
 =?utf-8?B?aEp2L3VwYXl3STdXYi9VdlJkM2JadXpBNStMTm8xL2hNcy8rQWtMZFRXZDFG?=
 =?utf-8?B?WlcxVExFd05GQlJDYkNMdFZtcHJMQ05YU0MrSXVRMTlDNElGclB5UE5ldFda?=
 =?utf-8?B?cDBqS0tmWUhiZ0QwU3BzVFhYWlI3TjdYUEdPNU9yM29DUld1UE5tZzZVUy9H?=
 =?utf-8?B?TFcrWEc1UnlLc2ltZFE0MGpabmJJL3B4S2k0SjVLWGFrQnl5bXV0MVJyK2tp?=
 =?utf-8?B?Qzd5Yi9JUitOWW9BQnBrUkUycXpZN1crcWxMWXQ0YjlpS2NtRzlmVUxublA5?=
 =?utf-8?B?alhpUjdoS3FCSUNwN1ZLUXBLeHpwVW5HcmFsSzdMa1lrSUk4OGJwTEphR0w2?=
 =?utf-8?B?NVNyTUhRMFJGZ1lGYlVUTDJpOUZHdk96L0JraCtERTJKcXpjajFNRHY1bzIv?=
 =?utf-8?B?ZHU1Qi9LWDVVQXUwSWR2dDVwYitBYkh4dkpCNGZoaHZTYzFwTkM5ck9OM0ln?=
 =?utf-8?B?OW9XeG13bDJ1MklGdkh6em1BNnp2OWlMd1RLN1VVRnhoMVVseHlydGsrZzRB?=
 =?utf-8?B?L1R4b3NYM3cwcllKMHE4TzBJVUZwbnNHK1JIK3B5eTAzU3ZPUUlzd1d1RHVt?=
 =?utf-8?B?bWhGRzVSdUkzZHpVZ0xUY3YwTWNMS3hod2JLZTZPUzNMT0VMS1NMWkN1S0hn?=
 =?utf-8?B?MTFWOEhLMnZHd2pSamhQdVVxN2U0SzRMWmV0NE0raVdBclNtU080WjRqQVRk?=
 =?utf-8?B?L242MWkxQWtKV3dudTJJNG5SV0E0b2MvbWdYeGdIcGlIQ3JIRlFtUjgrVkVi?=
 =?utf-8?B?dWN4THZmZXFKaktsdDU2Qnl4Zi9Wa2hqQ3IyajdSZWNZUTdPU3hGd0JGYm5p?=
 =?utf-8?B?c0xiZlUwYjNUdlE4SE1XV0UraE43T3Z4VDEvUmJpZkkycTgxUENMbGxCWllo?=
 =?utf-8?B?ZG53Y3N2ekJLdHVtTUtRcUpOYkpKTHpwOTJvUU96VUVHelQxbHRqMDFhZXhL?=
 =?utf-8?B?alBZa1A3cU5ZM2tDTHVNQ2dVQkF5OVdXUjJVTWpnOXRyWGsrTmhkMmJxL1Z3?=
 =?utf-8?B?dmxDa3F3Wm01eEx1eit4RnByajJKcW5UaUdyTk1EQjVVU3J1OC9LWkt1cEFu?=
 =?utf-8?B?L3dlU21xQ2tacjg2NUhMSndCbllrdmxBbTljM0c2QnV3aWdzWkJiVUc5Q1pp?=
 =?utf-8?B?ejd0YUhCZGlENXd1VS90d0ovWFl3akd2dG85MWh5VTMxdG9reGo4N1dJbDZn?=
 =?utf-8?B?TUxkMFF4RjhEdGlzSDFvWUFQODZtZHZtdThDMnc5SmVKZDJjSXJtUnRDdXVY?=
 =?utf-8?B?ODV4dGh4aW9hWGN0dGdSUmJEUGY0QWxuekt5K3YvSCtIT3lVUUR4ZFJmRnhv?=
 =?utf-8?Q?soCwErg1PNdy3Vu254DbALc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4da529-76f4-4692-8735-08dce259ee1c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:45:05.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SieJVTNed/WGNyAoG7SsFzPI18djk5YWwuTB6WVOgcQgwt0ZxxpY9VJMoyBUYA2U2lv/vv6cv1swhCf3l5MUIhmVIJkaS3oGFhci1mItvq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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

only spinand on_die ecc is supported for a moment

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/Makefile       |   2 +-
 drivers/mtd/nand/core.c         | 130 +++++++++++++++-
 drivers/mtd/nand/ecc.c          | 249 ++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/core.c     | 207 ++++++++++++++++++++-----
 drivers/mtd/nand/spi/foresee.c  |   2 +-
 drivers/mtd/nand/spi/macronix.c |   7 +-
 drivers/mtd/nand/spi/micron.c   |   2 +-
 drivers/mtd/nand/spi/toshiba.c  |  10 +-
 drivers/mtd/nand/spi/winbond.c  |  10 +-
 include/linux/mtd/nand.h        | 261 ++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h     |  13 +-
 include/spi-mem.h               |   2 +
 12 files changed, 830 insertions(+), 65 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a1..56179188e92 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
-nandcore-objs := core.o bbt.o
+nandcore-objs := core.o bbt.o ecc.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 472ad0bdefb..6c90d576de3 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_GPL(nanddev_isreserved);
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-static int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
 {
 	unsigned int entry;
 
@@ -187,6 +187,134 @@ int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
 }
 EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
 
+/**
+ * nanddev_get_ecc_engine() - Find and get a suitable ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_get_ecc_engine(struct nand_device *nand)
+{
+	int engine_type;
+
+	/* Read the user desires in terms of ECC engine/configuration */
+	of_get_nand_ecc_user_config(nand);
+
+	engine_type = nand->ecc.user_conf.engine_type;
+	if (engine_type == NAND_ECC_ENGINE_TYPE_INVALID)
+		engine_type = nand->ecc.defaults.engine_type;
+
+	switch (engine_type) {
+	case NAND_ECC_ENGINE_TYPE_NONE:
+		return 0;
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+		nand->ecc.engine = nand_ecc_get_sw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+		nand->ecc.engine = nand_ecc_get_on_die_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand->ecc.engine = nand_ecc_get_on_host_hw_engine(nand);
+		if (PTR_ERR(nand->ecc.engine) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		break;
+	default:
+		pr_err("Missing ECC engine type\n");
+	}
+
+	if (!nand->ecc.engine)
+		return  -EINVAL;
+
+	return 0;
+}
+
+/**
+ * nanddev_put_ecc_engine() - Dettach and put the in-use ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_put_ecc_engine(struct nand_device *nand)
+{
+	switch (nand->ecc.ctx.conf.engine_type) {
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand_ecc_put_on_host_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_NONE:
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * nanddev_find_ecc_configuration() - Find a suitable ECC configuration
+ * @nand: NAND device
+ */
+static int nanddev_find_ecc_configuration(struct nand_device *nand)
+{
+	int ret;
+
+	if (!nand->ecc.engine)
+		return -ENOTSUPP;
+
+	ret = nand_ecc_init_ctx(nand);
+	if (ret)
+		return ret;
+
+	if (!nand_ecc_is_strong_enough(nand))
+		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
+			nand->mtd->name);
+
+	return 0;
+}
+
+/**
+ * nanddev_ecc_engine_init() - Initialize an ECC engine for the chip
+ * @nand: NAND device
+ */
+int nanddev_ecc_engine_init(struct nand_device *nand)
+{
+	int ret;
+
+	/* Look for the ECC engine to use */
+	ret = nanddev_get_ecc_engine(nand);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			pr_err("No ECC engine found\n");
+
+		return ret;
+	}
+
+	/* No ECC engine requested */
+	if (!nand->ecc.engine)
+		return 0;
+
+	/* Configure the engine: balance user input and chip requirements */
+	ret = nanddev_find_ecc_configuration(nand);
+	if (ret) {
+		pr_err("No suitable ECC configuration\n");
+		nanddev_put_ecc_engine(nand);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_init);
+
+/**
+ * nanddev_ecc_engine_cleanup() - Cleanup ECC engine initializations
+ * @nand: NAND device
+ */
+void nanddev_ecc_engine_cleanup(struct nand_device *nand)
+{
+	if (nand->ecc.engine)
+		nand_ecc_cleanup_ctx(nand);
+
+	nanddev_put_ecc_engine(nand);
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_cleanup);
+
 /**
  * nanddev_init() - Initialize a NAND device
  * @nand: NAND device
diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
new file mode 100644
index 00000000000..58cbe7deaac
--- /dev/null
+++ b/drivers/mtd/nand/ecc.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Generic Error-Correcting Code (ECC) engine
+ *
+ * Copyright (C) 2019 Macronix
+ * Author:
+ *     Miquèl RAYNAL <miquel.raynal@bootlin.com>
+ *
+ *
+ * This file describes the abstraction of any NAND ECC engine. It has been
+ * designed to fit most cases, including parallel NANDs and SPI-NANDs.
+ *
+ * There are three main situations where instantiating this ECC engine makes
+ * sense:
+ *   - external: The ECC engine is outside the NAND pipeline, typically this
+ *               is a software ECC engine, or an hardware engine that is
+ *               outside the NAND controller pipeline.
+ *   - pipelined: The ECC engine is inside the NAND pipeline, ie. on the
+ *                controller's side. This is the case of most of the raw NAND
+ *                controllers. In the pipeline case, the ECC bytes are
+ *                generated/data corrected on the fly when a page is
+ *                written/read.
+ *   - ondie: The ECC engine is inside the NAND pipeline, on the chip's side.
+ *            Some NAND chips can correct themselves the data.
+ *
+ * Besides the initial setup and final cleanups, the interfaces are rather
+ * simple:
+ *   - prepare: Prepare an I/O request. Enable/disable the ECC engine based on
+ *              the I/O request type. In case of software correction or external
+ *              engine, this step may involve to derive the ECC bytes and place
+ *              them in the OOB area before a write.
+ *   - finish: Finish an I/O request. Correct the data in case of a read
+ *             request and report the number of corrected bits/uncorrectable
+ *             errors. Most likely empty for write operations, unless you have
+ *             hardware specific stuff to do, like shutting down the engine to
+ *             save power.
+ *
+ * The I/O request should be enclosed in a prepare()/finish() pair of calls
+ * and will behave differently depending on the requested I/O type:
+ *   - raw: Correction disabled
+ *   - ecc: Correction enabled
+ *
+ * The request direction is impacting the logic as well:
+ *   - read: Load data from the NAND chip
+ *   - write: Store data in the NAND chip
+ *
+ * Mixing all this combinations together gives the following behavior.
+ * Those are just examples, drivers are free to add custom steps in their
+ * prepare/finish hook.
+ *
+ * [external ECC engine]
+ *   - external + prepare + raw + read: do nothing
+ *   - external + finish  + raw + read: do nothing
+ *   - external + prepare + raw + write: do nothing
+ *   - external + finish  + raw + write: do nothing
+ *   - external + prepare + ecc + read: do nothing
+ *   - external + finish  + ecc + read: calculate expected ECC bytes, extract
+ *                                      ECC bytes from OOB buffer, correct
+ *                                      and report any bitflip/error
+ *   - external + prepare + ecc + write: calculate ECC bytes and store them at
+ *                                       the right place in the OOB buffer based
+ *                                       on the OOB layout
+ *   - external + finish  + ecc + write: do nothing
+ *
+ * [pipelined ECC engine]
+ *   - pipelined + prepare + raw + read: disable the controller's ECC engine if
+ *                                       activated
+ *   - pipelined + finish  + raw + read: do nothing
+ *   - pipelined + prepare + raw + write: disable the controller's ECC engine if
+ *                                        activated
+ *   - pipelined + finish  + raw + write: do nothing
+ *   - pipelined + prepare + ecc + read: enable the controller's ECC engine if
+ *                                       deactivated
+ *   - pipelined + finish  + ecc + read: check the status, report any
+ *                                       error/bitflip
+ *   - pipelined + prepare + ecc + write: enable the controller's ECC engine if
+ *                                        deactivated
+ *   - pipelined + finish  + ecc + write: do nothing
+ *
+ * [ondie ECC engine]
+ *   - ondie + prepare + raw + read: send commands to disable the on-chip ECC
+ *                                   engine if activated
+ *   - ondie + finish  + raw + read: do nothing
+ *   - ondie + prepare + raw + write: send commands to disable the on-chip ECC
+ *                                    engine if activated
+ *   - ondie + finish  + raw + write: do nothing
+ *   - ondie + prepare + ecc + read: send commands to enable the on-chip ECC
+ *                                   engine if deactivated
+ *   - ondie + finish  + ecc + read: send commands to check the status, report
+ *                                   any error/bitflip
+ *   - ondie + prepare + ecc + write: send commands to enable the on-chip ECC
+ *                                    engine if deactivated
+ *   - ondie + finish  + ecc + write: do nothing
+ */
+
+#ifndef __UBOOT__
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
+#include <linux/mtd/nand.h>
+
+/**
+ * nand_ecc_init_ctx - Init the ECC engine context
+ * @nand: the NAND device
+ *
+ * On success, the caller is responsible of calling @nand_ecc_cleanup_ctx().
+ */
+int nand_ecc_init_ctx(struct nand_device *nand)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->init_ctx)
+		return 0;
+
+	return nand->ecc.engine->ops->init_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_init_ctx);
+
+/**
+ * nand_ecc_cleanup_ctx - Cleanup the ECC engine context
+ * @nand: the NAND device
+ */
+void nand_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	if (nand->ecc.engine && nand->ecc.engine->ops->cleanup_ctx)
+		nand->ecc.engine->ops->cleanup_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_cleanup_ctx);
+
+/**
+ * nand_ecc_prepare_io_req - Prepare an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->prepare_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->prepare_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_prepare_io_req);
+
+/**
+ * nand_ecc_finish_io_req - Finish an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->finish_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->finish_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_finish_io_req);
+
+void of_get_nand_ecc_user_config(struct nand_device *nand)
+{
+	nand->ecc.user_conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.user_conf.algo = NAND_ECC_ALGO_UNKNOWN;
+	nand->ecc.user_conf.placement = NAND_ECC_PLACEMENT_UNKNOWN;
+}
+EXPORT_SYMBOL(of_get_nand_ecc_user_config);
+
+/**
+ * nand_ecc_is_strong_enough - Check if the chip configuration meets the
+ *                             datasheet requirements.
+ *
+ * @nand: Device to check
+ *
+ * If our configuration corrects A bits per B bytes and the minimum
+ * required correction level is X bits per Y bytes, then we must ensure
+ * both of the following are true:
+ *
+ * (1) A / B >= X / Y
+ * (2) A >= X
+ *
+ * Requirement (1) ensures we can correct for the required bitflip density.
+ * Requirement (2) ensures we can correct even when all bitflips are clumped
+ * in the same sector.
+ */
+bool nand_ecc_is_strong_enough(struct nand_device *nand)
+{
+	const struct nand_ecc_props *reqs = nanddev_get_ecc_requirements(nand);
+	const struct nand_ecc_props *conf = nanddev_get_ecc_conf(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int corr, ds_corr;
+
+	if (conf->step_size == 0 || reqs->step_size == 0)
+		/* Not enough information */
+		return true;
+
+	/*
+	 * We get the number of corrected bits per page to compare
+	 * the correction density.
+	 */
+	corr = (mtd->writesize * conf->strength) / conf->step_size;
+	ds_corr = (mtd->writesize * reqs->strength) / reqs->step_size;
+
+	return corr >= ds_corr && conf->strength >= reqs->strength;
+}
+EXPORT_SYMBOL(nand_ecc_is_strong_enough);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand)
+{
+	unsigned int algo = nand->ecc.user_conf.algo;
+
+	if (algo == NAND_ECC_ALGO_UNKNOWN)
+		algo = nand->ecc.defaults.algo;
+
+	switch (algo) {
+	case NAND_ECC_ALGO_HAMMING:
+		return nand_ecc_sw_hamming_get_engine();
+	case NAND_ECC_ALGO_BCH:
+		return nand_ecc_sw_bch_get_engine();
+	default:
+		break;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_sw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand)
+{
+	return nand->ecc.ondie_engine;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_die_hw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_host_hw_engine);
+
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand)
+{
+}
+EXPORT_SYMBOL(nand_ecc_put_on_host_hw_engine);
+
+#ifndef __UBOOT__
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("Generic ECC engine");
+#endif /* __UBOOT__ */
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d5cb9026246..70f07be06b0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -239,7 +239,7 @@ static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 		 * fixed, so let's return the maximum possible value so that
 		 * wear-leveling layers move the data immediately.
 		 */
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	case STATUS_ECC_UNCOR_ERROR:
 		return -EBADMSG;
@@ -275,6 +275,92 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_ondie_ecc_init_ctx(struct nand_device *nand)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct spinand_ondie_ecc_conf *engine_conf;
+
+	nand->ecc.ctx.conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ctx.conf.step_size = nand->ecc.requirements.step_size;
+	nand->ecc.ctx.conf.strength = nand->ecc.requirements.strength;
+
+	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
+	if (!engine_conf)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = engine_conf;
+
+	if (spinand->eccinfo.ooblayout)
+		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+	else
+		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
+
+	return 0;
+}
+
+static void spinand_ondie_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	kfree(nand->ecc.ctx.priv);
+}
+
+static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	bool enable = (req->mode != MTD_OPS_RAW);
+
+	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
+
+	/* Only enable or disable the engine */
+	return spinand_ecc_enable(spinand, enable);
+}
+
+static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	int ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	/* Nothing to do when finishing a page write */
+	if (req->type == NAND_PAGE_WRITE)
+		return 0;
+
+	/* Finish a page read: check the status, report errors/bitflips */
+	ret = spinand_check_ecc_status(spinand, engine_conf->status);
+	if (ret == -EBADMSG)
+		mtd->ecc_stats.failed++;
+	else if (ret > 0)
+		mtd->ecc_stats.corrected += ret;
+
+	return ret;
+}
+
+static struct nand_ecc_engine_ops spinand_ondie_ecc_engine_ops = {
+	.init_ctx = spinand_ondie_ecc_init_ctx,
+	.cleanup_ctx = spinand_ondie_ecc_cleanup_ctx,
+	.prepare_io_req = spinand_ondie_ecc_prepare_io_req,
+	.finish_io_req = spinand_ondie_ecc_finish_io_req,
+};
+
+static struct nand_ecc_engine spinand_ondie_ecc_engine = {
+	.ops = &spinand_ondie_ecc_engine_ops,
+};
+
+static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+
+	if (nand->ecc.ctx.conf.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE &&
+	    engine_conf)
+		engine_conf->status = status;
+}
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -317,7 +403,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	if (req->mode == MTD_OPS_RAW)
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	else
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
@@ -366,9 +455,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * must fill the page cache entirely even if we only want to program
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
+	 *
+	 * Only reset the data buffer manually, the OOB buffer is prepared by
+	 * ECC engines ->prepare_io_req() callback.
 	 */
 	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	memset(spinand->databuf, 0xff, nbytes);
+	memset(spinand->databuf, 0xff, nanddev_page_size(nand));
 
 	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
@@ -385,7 +477,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	if (req->mode == MTD_OPS_RAW)
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	else
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
@@ -498,12 +593,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 }
 
 static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req,
-			     bool ecc_enabled)
+			     const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_load_page_op(spinand, req);
 	if (ret)
 		return ret;
@@ -515,22 +614,26 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret < 0)
 		return ret;
 
+	spinand_ondie_ecc_save_status(nand, status);
+
 	ret = spinand_read_from_cache_op(spinand, req);
 	if (ret)
 		return ret;
 
-	if (!ecc_enabled)
-		return 0;
-
-	return spinand_check_ecc_status(spinand, status);
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_write_page(struct spinand_device *spinand,
 			      const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_write_enable_op(spinand);
 	if (ret)
 		return ret;
@@ -550,7 +653,7 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (!ret && (status & STATUS_PROG_FAILED))
 		return -EIO;
 
-	return ret;
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
@@ -580,21 +683,14 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
-		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
+		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG) {
+		if (ret == -EBADMSG)
 			ecc_failed = true;
-			mtd->ecc_stats.failed++;
-		} else {
-			mtd->ecc_stats.corrected += ret;
+		else
 			max_bitflips = max_t(unsigned int, max_bitflips, ret);
-		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
@@ -635,10 +731,6 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
 		ret = spinand_write_page(spinand, &iter.req);
 		if (ret)
 			break;
@@ -667,7 +759,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	};
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req, false);
+	spinand_read_page(spinand, &req);
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -835,6 +927,36 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
+	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
+		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
+
+		return 0;
+	}
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].wdesc_ecc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc_ecc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc_ecc = desc;
+
 	return 0;
 }
 
@@ -1019,7 +1141,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			continue;
 
 		nand->memorg = table[i].memorg;
-		nand->eccreq = table[i].eccreq;
+		nanddev_set_ecc_requirements(nand, &table[i].eccreq);
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
@@ -1171,6 +1293,15 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
+	/* SPI-NAND default ECC engine is on-die */
+	nand->ecc.defaults.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ondie_engine = &spinand_ondie_ecc_engine;
+
+	spinand_ecc_enable(spinand, false);
+	ret = nanddev_ecc_engine_init(nand);
+	if (ret)
+		goto err_cleanup_nanddev;
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1178,27 +1309,31 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
-	if (spinand->eccinfo.ooblayout)
-		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
-	else
-		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
-
-	ret = mtd_ooblayout_count_freebytes(mtd);
-	if (ret < 0)
-		goto err_cleanup_nanddev;
+	if (nand->ecc.engine) {
+		ret = mtd_ooblayout_count_freebytes(mtd);
+		if (ret < 0)
+			goto err_cleanup_ecc_engine;
+	}
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
+	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
 		dev_err(dev,
 			"Failed to create direct mappings for read/write operations (err = %d)\n",
 			ret);
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 	}
 
 	return 0;
 
+err_cleanup_ecc_engine:
+	nanddev_ecc_engine_cleanup(nand);
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 7d141cdd658..6229c959b2c 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -60,7 +60,7 @@ static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
 		return 0;
 
 	case STATUS_ECC_HAS_BITFLIPS:
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	default:
 		break;
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3d4a7f0c3cb..c2a7aa2da96 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -87,11 +87,12 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		eccsr = *spinand->scratchbuf;
-		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
-			return nand->eccreq.strength;
+		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
+			    !eccsr))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return eccsr;
 
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index b538213ed8e..01c177facfb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -14,7 +14,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index ad48b1c7c8a..bf7da57de13 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -93,12 +93,12 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c62096dc2e6..d7dc1c86494 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -113,7 +113,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -130,12 +130,12 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0afdaed5715..18b9cf276ac 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -12,6 +12,8 @@
 
 #include <linux/mtd/mtd.h>
 
+struct nand_device;
+
 /**
  * struct nand_memory_organization - Memory organization structure
  * @bits_per_cell: number of bits per NAND cell
@@ -126,17 +128,72 @@ struct nand_page_io_req {
 };
 
 /**
- * struct nand_ecc_req - NAND ECC requirements
+ * enum nand_ecc_engine_type - NAND ECC engine type
+ * @NAND_ECC_ENGINE_TYPE_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_TYPE_NONE: No ECC correction
+ * @NAND_ECC_ENGINE_TYPE_SOFT: Software ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_HOST: On host hardware ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_DIE: On chip hardware ECC correction
+ */
+enum nand_ecc_engine_type {
+	NAND_ECC_ENGINE_TYPE_INVALID,
+	NAND_ECC_ENGINE_TYPE_NONE,
+	NAND_ECC_ENGINE_TYPE_SOFT,
+	NAND_ECC_ENGINE_TYPE_ON_HOST,
+	NAND_ECC_ENGINE_TYPE_ON_DIE,
+};
+
+/**
+ * enum nand_ecc_placement - NAND ECC bytes placement
+ * @NAND_ECC_PLACEMENT_UNKNOWN: The actual position of the ECC bytes is unknown
+ * @NAND_ECC_PLACEMENT_OOB: The ECC bytes are located in the OOB area
+ * @NAND_ECC_PLACEMENT_INTERLEAVED: Syndrome layout, there are ECC bytes
+ *                                  interleaved with regular data in the main
+ *                                  area
+ */
+enum nand_ecc_placement {
+	NAND_ECC_PLACEMENT_UNKNOWN,
+	NAND_ECC_PLACEMENT_OOB,
+	NAND_ECC_PLACEMENT_INTERLEAVED,
+};
+
+/**
+ * enum nand_ecc_algo - NAND ECC algorithm
+ * @NAND_ECC_ALGO_UNKNOWN: Unknown algorithm
+ * @NAND_ECC_ALGO_HAMMING: Hamming algorithm
+ * @NAND_ECC_ALGO_BCH: Bose-Chaudhuri-Hocquenghem algorithm
+ * @NAND_ECC_ALGO_RS: Reed-Solomon algorithm
+ */
+enum nand_ecc_algo {
+	NAND_ECC_ALGO_UNKNOWN,
+	NAND_ECC_ALGO_HAMMING,
+	NAND_ECC_ALGO_BCH,
+	NAND_ECC_ALGO_RS,
+};
+
+/**
+ * struct nand_ecc_props - NAND ECC properties
+ * @engine_type: ECC engine type
+ * @placement: OOB placement (if relevant)
+ * @algo: ECC algorithm (if relevant)
  * @strength: ECC strength
- * @step_size: ECC step/block size
+ * @step_size: Number of bytes per step
+ * @flags: Misc properties
  */
-struct nand_ecc_req {
+struct nand_ecc_props {
+	enum nand_ecc_engine_type engine_type;
+	enum nand_ecc_placement placement;
+	enum nand_ecc_algo algo;
 	unsigned int strength;
 	unsigned int step_size;
+	unsigned int flags;
 };
 
 #define NAND_ECCREQ(str, stp) { .strength = (str), .step_size = (stp) }
 
+/* NAND ECC misc flags */
+#define NAND_ECC_MAXIMIZE_STRENGTH BIT(0)
+
 /**
  * struct nand_bbt - bad block table object
  * @cache: in memory BBT cache
@@ -145,8 +202,6 @@ struct nand_bbt {
 	unsigned long *cache;
 };
 
-struct nand_device;
-
 /**
  * struct nand_ops - NAND operations
  * @erase: erase a specific block. No need to check if the block is bad before
@@ -169,11 +224,130 @@ struct nand_ops {
 	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
 };
 
+/**
+ * struct nand_ecc_context - Context for the ECC engine
+ * @conf: basic ECC engine parameters
+ * @nsteps: number of ECC steps
+ * @total: total number of bytes used for storing ECC codes, this is used by
+ *         generic OOB layouts
+ * @priv: ECC engine driver private data
+ */
+struct nand_ecc_context {
+	struct nand_ecc_props conf;
+	unsigned int nsteps;
+	unsigned int total;
+	void *priv;
+};
+
+/**
+ * struct nand_ecc_engine_ops - ECC engine operations
+ * @init_ctx: given a desired user configuration for the pointed NAND device,
+ *            requests the ECC engine driver to setup a configuration with
+ *            values it supports.
+ * @cleanup_ctx: clean the context initialized by @init_ctx.
+ * @prepare_io_req: is called before reading/writing a page to prepare the I/O
+ *                  request to be performed with ECC correction.
+ * @finish_io_req: is called after reading/writing a page to terminate the I/O
+ *                 request and ensure proper ECC correction.
+ */
+struct nand_ecc_engine_ops {
+	int (*init_ctx)(struct nand_device *nand);
+	void (*cleanup_ctx)(struct nand_device *nand);
+	int (*prepare_io_req)(struct nand_device *nand,
+			      struct nand_page_io_req *req);
+	int (*finish_io_req)(struct nand_device *nand,
+			     struct nand_page_io_req *req);
+};
+
+/**
+ * enum nand_ecc_engine_integration - How the NAND ECC engine is integrated
+ * @NAND_ECC_ENGINE_INTEGRATION_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_INTEGRATION_PIPELINED: Pipelined engine, performs on-the-fly
+ *                                         correction, does not need to copy
+ *                                         data around
+ * @NAND_ECC_ENGINE_INTEGRATION_EXTERNAL: External engine, needs to bring the
+ *                                        data into its own area before use
+ */
+enum nand_ecc_engine_integration {
+	NAND_ECC_ENGINE_INTEGRATION_INVALID,
+	NAND_ECC_ENGINE_INTEGRATION_PIPELINED,
+	NAND_ECC_ENGINE_INTEGRATION_EXTERNAL,
+};
+
+/**
+ * struct nand_ecc_engine - ECC engine abstraction for NAND devices
+ * @dev: Host device
+ * @node: Private field for registration time
+ * @ops: ECC engine operations
+ * @integration: How the engine is integrated with the host
+ *               (only relevant on %NAND_ECC_ENGINE_TYPE_ON_HOST engines)
+ * @priv: Private data
+ */
+struct nand_ecc_engine {
+	struct device *dev;
+	struct list_head node;
+	struct nand_ecc_engine_ops *ops;
+	enum nand_ecc_engine_integration integration;
+	void *priv;
+};
+
+void of_get_nand_ecc_user_config(struct nand_device *nand);
+int nand_ecc_init_ctx(struct nand_device *nand);
+void nand_ecc_cleanup_ctx(struct nand_device *nand);
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req);
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req);
+bool nand_ecc_is_strong_enough(struct nand_device *nand);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand);
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand);
+struct device *nand_ecc_get_engine_dev(struct device *host);
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_HAMMING)
+struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
+struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * struct nand_ecc - Information relative to the ECC
+ * @defaults: Default values, depend on the underlying subsystem
+ * @requirements: ECC requirements from the NAND chip perspective
+ * @user_conf: User desires in terms of ECC parameters
+ * @ctx: ECC context for the ECC engine, derived from the device @requirements
+ *       the @user_conf and the @defaults
+ * @ondie_engine: On-die ECC engine reference, if any
+ * @engine: ECC engine actually bound
+ */
+struct nand_ecc {
+	struct nand_ecc_props defaults;
+	struct nand_ecc_props requirements;
+	struct nand_ecc_props user_conf;
+	struct nand_ecc_context ctx;
+	struct nand_ecc_engine *ondie_engine;
+	struct nand_ecc_engine *engine;
+};
+
 /**
  * struct nand_device - NAND device
  * @mtd: MTD instance attached to the NAND device
  * @memorg: memory layout
- * @eccreq: ECC requirements
+ * @ecc: NAND ECC object attached to the NAND device
  * @rowconv: position to row address converter
  * @bbt: bad block table info
  * @ops: NAND operations attached to the NAND device
@@ -181,8 +355,8 @@ struct nand_ops {
  * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNAND)
  * should declare their own NAND object embedding a nand_device struct (that's
  * how inheritance is done).
- * struct_nand_device->memorg and struct_nand_device->eccreq should be filled
- * at device detection time to reflect the NAND device
+ * struct_nand_device->memorg and struct_nand_device->ecc.requirements should
+ * be filled at device detection time to reflect the NAND device
  * capabilities/requirements. Once this is done nanddev_init() can be called.
  * It will take care of converting NAND information into MTD ones, which means
  * the specialized NAND layers should never manually tweak
@@ -191,7 +365,7 @@ struct nand_ops {
 struct nand_device {
 	struct mtd_info *mtd;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc ecc;
 	struct nand_row_converter rowconv;
 	struct nand_bbt bbt;
 	const struct nand_ops *ops;
@@ -332,7 +506,7 @@ static inline unsigned int nanddev_ntargets(const struct nand_device *nand)
 }
 
 /**
- * nanddev_neraseblocks() - Get the total number of erasablocks
+ * nanddev_neraseblocks() - Get the total number of eraseblocks
  * @nand: NAND device
  *
  * Return: the total number of eraseblocks exposed by @nand.
@@ -370,6 +544,60 @@ nanddev_get_memorg(struct nand_device *nand)
 	return &nand->memorg;
 }
 
+/**
+ * nanddev_get_ecc_conf() - Extract the ECC configuration from a NAND device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_conf(struct nand_device *nand)
+{
+	return &nand->ecc.ctx.conf;
+}
+
+/**
+ * nanddev_get_ecc_nsteps() - Extract the number of ECC steps
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_nsteps(struct nand_device *nand)
+{
+	return nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_bytes_per_step() - Extract the number of ECC bytes per step
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_bytes_per_step(struct nand_device *nand)
+{
+	return nand->ecc.ctx.total / nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_requirements() - Extract the ECC requirements from a NAND
+ *                                  device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_requirements(struct nand_device *nand)
+{
+	return &nand->ecc.requirements;
+}
+
+/**
+ * nanddev_set_ecc_requirements() - Assign the ECC requirements of a NAND
+ *                                  device
+ * @nand: NAND device
+ * @reqs: Requirements
+ */
+static inline void
+nanddev_set_ecc_requirements(struct nand_device *nand,
+			     const struct nand_ecc_props *reqs)
+{
+	nand->ecc.requirements = *reqs;
+}
+
 int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 		 struct module *owner);
 void nanddev_cleanup(struct nand_device *nand);
@@ -598,7 +826,7 @@ static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 }
 
 /**
- * nanddev_pos_next_eraseblock() - Move a position to the next page
+ * nanddev_pos_next_page() - Move a position to the next page
  * @nand: NAND device
  * @pos: the position to update
  *
@@ -708,8 +936,18 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
 
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 
+/* ECC related functions */
+int nanddev_ecc_engine_init(struct nand_device *nand);
+void nanddev_ecc_engine_cleanup(struct nand_device *nand);
+
+static inline void *nand_to_ecc_ctx(struct nand_device *nand)
+{
+	return nand->ecc.ctx.priv;
+}
+
 /* BBT related functions */
 enum nand_bbt_block_status {
 	NAND_BBT_BLOCK_STATUS_UNKNOWN,
@@ -760,5 +998,6 @@ static inline bool nanddev_bbt_is_initialized(struct nand_device *nand)
 
 /* MTD -> NAND helper functions. */
 int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
+int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len);
 
 #endif /* __LINUX_MTD_NAND_H */
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 81a7b0dbbb2..3bcdbffc34a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -319,6 +319,15 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
+/**
+ * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
+ * @status: status of the last wait operation that will be used in case
+ *          ->get_status() is not populated by the spinand device.
+ */
+struct spinand_ondie_ecc_conf {
+	u8 status;
+};
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -342,7 +351,7 @@ struct spinand_info {
 	struct spinand_devid devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc_props eccreq;
 	struct spinand_ecc_info eccinfo;
 	struct {
 		const struct spinand_op_variants *read_cache;
@@ -391,6 +400,8 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
+	struct spi_mem_dirmap_desc *wdesc_ecc;
+	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 3c8e95b6f53..82dbe21fd5a 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -91,6 +91,7 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
  * @data.dir: direction of the transfer
  * @data.buf.in: input buffer
  * @data.buf.out: output buffer
@@ -119,6 +120,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		/* buf.{in,out} must be DMA-able. */
-- 
2.45.2

