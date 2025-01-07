Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1288BE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC24980657;
	Tue,  7 Jan 2025 07:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BoLPrZrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9BC80657; Tue,  7 Jan 2025 07:59:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D26E80657
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo/Yc2qqQDrtAoZiaA1XP8VgRjD3h0WuLB/VscbIk8nbYUgy/AG/fPHDRMg/8yoltdlRKHVExl4FSqsCalbuJirhMk5//9/SqRqxP4mIk8yEK8reXS5IvY3sljFc9rio+o+9xPhGTXp3+DZtSag6HZLQXpEKN86El4oRnQ6XuPMKguzsYNEp6c4T8KCuPKAdcE4ENsAbj+ggIuECse2+ymi/jOnWwetaqlJNs+TaeO3eiG+HgPpOsW3slzDFSOvXAjgDN9PhwECKI0MtFAtLbzRCgS6c0tBnq81uStLUxqzuPzLRfWImZN+QihjLr+MNLiMc4vNW0bkJNwUC/fvztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emBEL3ekI3aGopspqQQZRD9YTflM+apJPcijTiuOJ5w=;
 b=ZB585TIHDa2CJ2Iv3a9jyks98ZMftPAysKgolUXwXF2FDB5dq+bLMa9dNR20TpcbwnaZjoU8zeewLseYYInwpiAdKLkBdNPIkzge33zqLK2XmtSi7kCqZ0iYZ/BtxZ6t+/GZq9kxK1U0YdBnd5rXDrajV8j6HZV+NFzzo3g3d4HKuofjbdRQCwhWI16hg5LQQc/fZR9k+ASkyBfmZTG5IXvh91lKOO/GqTT/LLh9tNky6jIBAAe4tnkNVLb4/C7tTXQozfbl0MUuA+I4D5fKnlsWs66+qn1FlCijGHKtZe5KU6Hxvdoift5OyirhLvdOG4ADWIoiwb5lXvO4fIfXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emBEL3ekI3aGopspqQQZRD9YTflM+apJPcijTiuOJ5w=;
 b=BoLPrZrZ1vvu+CsAjyYxK0dGZrfYfZJQXddzgGXr0i8E3BH7Ykuv12dIxm1fshlaV6KoC7nh62Kh0qFz9aaCXiG8Byb0Ug8NHqDFrZQ9rER7175v/jMda7eA4+jCfBq3E08rfRbsCC7kCE4WVwVnv2uQJ6n0WFL2Gzjsi9xHoLxsWNYsr941kSVR4yqSZdLOBW9/gPDZi6Z6vI1CbTQs4R9MOwv29qZhnYgaEoJaQ8JjjyEMAFXqU2SkLZLFyWd+hMvncN4+0yPLgu4jnbhK3x7wL1ZO5ipB0QeGJZ5FCIGFJEMPD4wkaS6I6behO9gkB7VKy/UNZYpgWzP9TQVArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:06 +0800
Subject: [PATCH v2 06/16] imx: imx8mn_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-6-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: b31ef2f3-08c6-494b-b2d6-08dd2ee8cb84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHVyYUxjRDZ1VFZtM2VDSW5IdG10THRicWphQzUrK0pyczE4MnB6ZDVCWEJR?=
 =?utf-8?B?bEtndUhQVUFKajk1WmJYWGRGOTdVcGVXdmNRMm1PRCt0Wng4SGc5eTgzRjJR?=
 =?utf-8?B?ZFFFdUdyV3lhaElZZ09zUE9SL1lYNUtydHJGV3RJRXl3VytFREtzYk51Tmla?=
 =?utf-8?B?OVdxT2Q0QUNnSUxrVzAwcWVkQkRGYXhHaHFOY285S1g2WVRCdDd4T1JPM1lB?=
 =?utf-8?B?bmN1KzNXWlVaek5jZUJPSnkvMzVaMEtQc1NEMG5ZcmVFTUpVQjVxLzBkREVS?=
 =?utf-8?B?bDVrWG5aSjZmYkNkbEFVdUMvanpncGtmeU0wSmEzTDBDV0JtVHFGUnpPZDI2?=
 =?utf-8?B?MS9tVmEzNnZ0dVMycHFDRGl1VmVmUGgwcXlVOFVZK2dwOVNhRVJoT05Dc0Zp?=
 =?utf-8?B?OGFjVWkzMjRETVl6eUdjK0thY0FXeC94RTllSnQ2Q0hEZTdBQkE2Mm90UDZq?=
 =?utf-8?B?UndCbDVGSU1tRUllSE1pYmdzWXlacWNFQXhTSmxSRG42WnpGVTJ4eE03ZDRt?=
 =?utf-8?B?VFlFMk9BMlYvemxWNUNFZkFXakx0dEhCM3haYVZiVi96ZFBBM20xOXJ2K1pq?=
 =?utf-8?B?NXFKZlZXeGQzYTh3dHE4TFZSQWhCb04yT2FoZ29VM3FlTUxpVjZhUjFaVTJ2?=
 =?utf-8?B?TmJHMGNRRnFNK0NWUUpSbXR5d1gwUjgwVkxzV0x3L0x5UmU2WEtLbTBRbjAz?=
 =?utf-8?B?RVVhM0FBbWkyZExvOXRjVHRBRTZnS3hzbEtyNDBjQ3owU2ZscTB1OThjMExE?=
 =?utf-8?B?aGxMNmg4V0RDUkJ1YzVHS0U2cXlEVm1aaHN0azg4REVaSEZ2QWptcG92SWZ3?=
 =?utf-8?B?YkxMQ0ovazREQlRZWmVNTG0zUERmb0FUUEJvNXp4MTNBekRFbEx3N0oxK0NH?=
 =?utf-8?B?WHRHSUFwVnlPdWczbXhQTTJBUmNzbC9FQ2Q0ZjM2TWY0dVV3cDRMVFpoNE80?=
 =?utf-8?B?aG45aHBTZG1RSVAvUVNod2lsZ0VrZFkvT1VrcVpsNjJrYk8zaWs3NTBZUUVP?=
 =?utf-8?B?NTE4enZib3lUNnc4a3RlU3Z6SXBhblZQcmI2c0dMZG1tT2M5ZVk2M09uMDI2?=
 =?utf-8?B?L09WVWlDbUYrNms3bytTd0Y5N0VJMGhLaVRNSEM3VXZpdG9lSllwcXZiYmxP?=
 =?utf-8?B?NmNjUDhnUTVWQ3ZlTXI3ZTg3eE1sdDJkaVM1Qm9VSUR4cFV4bWZNYlFVS2xU?=
 =?utf-8?B?RlhqSWg4MytVYnVqYTBVK3pyZ3lWbC9teWdMekNvYVFUbGlZelJjNWZ2VUIv?=
 =?utf-8?B?R2doV2pmK0Z0MXJJOGlPc1g5azlCQzRyMWVQYnc5bmhQQmd2NHRQdVVtaGhx?=
 =?utf-8?B?S1NNTyt5elZUTlAyc3V1WFlDZm5VQXI4dXVZSkE1Y1EzcGVWQnE0bG8wTjJz?=
 =?utf-8?B?eTNJQy9yaC9GaGNLSXpWYzcza0U2NHhrd1dkMG5BMmYwekVEUG9sZUtvWURP?=
 =?utf-8?B?ZUxIU3J0bHh1MGMrVllYdFRka0V5cjA0U0dYb3QvQkxRZHVlKzVENHMzbXBT?=
 =?utf-8?B?MTdrbDNFbm12MjBXNEUveXJlS0xzNU94TUVwQ0hZL1lLY3hZQlVRNkZVUUtt?=
 =?utf-8?B?SEp4cFhIV0x3VzMwWElNeXVOMi9aR0grYy82dU5aNHdzaW9LNm9vdkpHV0Fi?=
 =?utf-8?B?dUdJTHpVYkRxNFBoQjNxWm94Y0k0WVVjaGdGejBqbjF1N2srNVBmbGFSNW41?=
 =?utf-8?B?b1ZUclYzektnYzU0RlZKY1paYi8xSSttd2p2dHR0VFl4OGJKb0NPVXNURWNz?=
 =?utf-8?B?S0JuYXFSVXBOb1BhWVV3dnQ3RGxvZXQ1Rms0ZWNKRUcyanZWV3grMkVvNURa?=
 =?utf-8?B?Rzl2a3AvUnVFc1Z0YXRTaFpvcnUybUpSMEFMN0RldlVLTUdPL3N0Q1RNTC93?=
 =?utf-8?B?dmpvbXM0QnFHVmI3cTVObUZ4VXd3M05xeEdCdFFSQWpTeHc3clhhQnMzd2pN?=
 =?utf-8?Q?ATrG6i279QlM3cMYjfvwvpDDNxjL1Ahc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNjSzFEcFUyVllGSjNQR0NMZSs2aUJYaXdiN3BHdFh6em9hUC93RWpHdmo0?=
 =?utf-8?B?YkxsQWRFTlBaZk5UODB4MW5KV2FpeWZzcDRTRmdPNlRrRkhEUTdrcmQzM1BG?=
 =?utf-8?B?Mmp5dUdCc1NGaVlraytzMHFCemFkcm5RU0VvL2paM0JGVGwwa0IzaUR2dUt1?=
 =?utf-8?B?cDVZMVdQZjFmSE1PZFhxSVdKNDJ3N3h2QTJ2cG84T2Y1S1hXajVCVFowME5w?=
 =?utf-8?B?bmJYMWlNYjZtcnliMnpLY012SjlxYjE2SW1oanNxQ0xQOHVaMytqUnlybTRr?=
 =?utf-8?B?SGVPTE8rbHNkUlRFR0Y5VlF0OXpMREk3Wko2U0ZPOHo3S3FCQXJQeGJQVDBQ?=
 =?utf-8?B?QlRSZ2N2bEJraytnanB3c3ZvY1c3dVVMeGRoNDI3UHlkSjJiVERZUDlvY1F0?=
 =?utf-8?B?SkRLRkhVLy9QOUdBbE1EQnBXREZFRktFZXhleHN4Sm1VR3NmdTlmVEZnT0g5?=
 =?utf-8?B?ZnZNbmNiTEpHY2FzSFZyQWliQW0ydWVhU3VHaHBVaEczOTN3b3hha3JlbmhG?=
 =?utf-8?B?MEo3ekJza1RLa0NKNzVnNFZiaDJrOExWV2QvTisyNWNJVEJla01yS2Roak1n?=
 =?utf-8?B?L0xmTUxRYzA1VG9FUjBnOHV3a3JEZGZ5SmRmeDJUTkFyV2V4YVNJUE11bzJy?=
 =?utf-8?B?MjFBT0pDRkZNTXZaYXJWNHdPWkpTdlI3VVExbUNIQ1RWZEVzSnA4QVNVREp2?=
 =?utf-8?B?ZGV3UlJ1WnFBMFpXUmJmYVA3ZURXWEFvSDZYMlZjRVJya2ZPRFJhSkpZVGJs?=
 =?utf-8?B?cExKVlJEVmpsRythdVpzQVM1WmtUekU1cG9ZWkFRYm9yc29GR0l4ZTFEMHUr?=
 =?utf-8?B?bUJhZ3hjNnlmUzJEMFplQlhSQmVGa3QwQWxNZDlTS3R0RFNqOUFSeTZNanVF?=
 =?utf-8?B?V1hrTHdHeWhsSjdCcWNuWmZObkdqcFZZTVZLL0tpVnNxcTExNkk2dW44eG56?=
 =?utf-8?B?dFJIWUtISUNmWWFHSXdDazcwQkdScnREYU1XZE14c0hzWmptbW1wV21WSnBE?=
 =?utf-8?B?d2w4dUhTenViYmpLcVM5aGtxSlVtNWZlMFZuRVRJOUc0OC9qQTROa0E3bjJv?=
 =?utf-8?B?bDIxa2M3R0g0bFhLeVhSTndyUm8wK21CalJ4ekhPMGlKQmtBSnhOOFRUYzV5?=
 =?utf-8?B?UmZkbkVWQnloWGY2SXNEZ25TSS85V1liT3pRVXk3UXY2UERZcUZXVzdhaURF?=
 =?utf-8?B?Uk9nVFVUMksweDdIbFdadmR0MkFJVU5md1E5VVhtM0NuQnRLWUdDR1Q2UTJN?=
 =?utf-8?B?Q3gzcXhPSFVRNktzNHV2VXJOUTA2bVoxa3RHbkRBT0V1c3dIa2lXaXZ1ZEdZ?=
 =?utf-8?B?ZE1DcVlSNHRFUkFZR1FzbEs2U1VxaDJPWmVWS0RuY1d2TVFuRXBHMXV2eGt6?=
 =?utf-8?B?a0pJZEN6MysydDczTXZWdE43cW9ld21NS0tQNDJLS2paTUU3K3AyS0lMVlJK?=
 =?utf-8?B?SHIvZ0RaVklySjVpY05sbmI3VUxOT242Ylc5Zzl6YkZOZDJIc2ZWcFdhTHUr?=
 =?utf-8?B?WHVITVhVRFN0ajNYN2JtK0ZmZVZiN0NaVmF5ZWZRbXR1NDJQZkRpZlJXb3dt?=
 =?utf-8?B?N0RlOHdTTTZZZzNVY3pKMTk5aU1Kck1HVm5mei9ObWF4MDBUYS9kUGtFcFIr?=
 =?utf-8?B?UUtZQ0VLenFwMXhwL2xOdk52aVplTTAwU0NESk0yV2lOWEdzZHBvNXFoS3NH?=
 =?utf-8?B?djgveFhLbzU2Z0NJZExBQXBwRU9EYUg4c3J6VWpkM29YeGtOUWsvNkZ2Nkw0?=
 =?utf-8?B?c2orcU45clNybkRHZTN5dEJCZzF5ZnNoU1FSd0JWU3lxRWpQeXNYUDdNeWdz?=
 =?utf-8?B?dktndzk1U25kSUxERHNZVGlKQ1F2TEVzdGFjRWYzSE83bFgrbXFSVUh3d0hj?=
 =?utf-8?B?ZXY3TVdIbXpWa2R5N3hNQXg0cXRHamdialJFNTBRNVBwV2tDbWIxYm1zR0V2?=
 =?utf-8?B?RGhobWcyOHZGeHNqVS9UWm84NUEwSEkrK2ZlQzVodWRGRENOUTlMU3NRckNk?=
 =?utf-8?B?NW5tbm5PcDVFS014dkRTVS9pekl6U2tKL0pqdk1EN3FlaDV2NDR1MCtsai84?=
 =?utf-8?B?S1Nma1c0ckMwaUxEMTIzNGd6Y0lKNmtIOHkzbEJ0VERVYkVHK1hjb3VwTm9k?=
 =?utf-8?Q?A/4Q5+KLWci0pkIAsQNqnwkIY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31ef2f3-08c6-494b-b2d6-08dd2ee8cb84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:13.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASGjfzhkaeQL28hgFqkedOzr+VHtC0EvIp83WadxwB8ELEmJhhWZmw+pjWk6OpNOdRedFcxWBi0oDkpcBOh+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Drop unused headers and sort them

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 6b6fb0a7dd2178a20d9869a1b478d5a8b5124ad8..f20ffbc52501a8a5c3ae9603b04847bab2cbd8dc 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,12 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <env.h>
-#include <init.h>
 #include <asm/global_data.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/io.h>
+#include <env.h>
+#include <init.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.35.3

