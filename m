Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AA1D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3358F80077;
	Tue, 16 Dec 2025 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pe2CYaFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07F480077; Tue, 16 Dec 2025 07:39:37 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF616800AB
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wku9pl8btNR+HL6PTJKuYL0Y8hKHvr0AugLWf5zfXMG52jrynOq0Hw/5CuxeAMv3TLUcMj0r8KXUd8fphdjnNXbGbJLAdzHFDdx9olY7f9BtCKoL+miM2HJiOC3P5IKL4TvepU0opuP0APL9WCTIKr0p3XRnHngjXX32N2S6KtrbQQhP0A2/tmmFaWa+ERDeb+sGz6CwbhVYg7lCdRaQJaj/fj5eAaZAPMx4n/4nFTsUmZtrkYZeLuED1EjzKGASXPxofXGIAq5Z91etMaVGcElFlTOpm95uVLq3ejnLaLW2r3LxRNweAO4Ug6JNsguyOGQCH4NpnuDPnZmhImTeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t7Ei7IrMuFcYGUeXotN4B1szV/NzZgDmFTrxm22mLs=;
 b=VbrVHWrIG9WL8wIN6+XDDQooNAw1jYWhd16GdbGJ8y1eBetTjxoF8PX4AMRBeblvIW8vo7yWdLgSHPL5ipoqS41CW8bzZyV5T3g3iQt8yhgB46T0kBs66CVFf8uSN1qyPUksN4jXmXs15RIFyutmon7kjPZK5OEqMy4bK13XYcGByFEkgRVRTehjfi/AkulJXXTvyBExl6l1yfwW2RqiASaodgUvn0l5MPfy8GfjuVR+0TaSx8sAiB8/gAFIzEBxEAbF7hPkJmaMQCwPNWf2w1TvZnTuzKmMlqWC9L+ZviAWiCq84kJGdht1y19PudVuiPKkmvx9fgI3rv3lIwJnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t7Ei7IrMuFcYGUeXotN4B1szV/NzZgDmFTrxm22mLs=;
 b=pe2CYaFlJIIcPSmKfRWxJkHsftnwcGb5xGGlzBX1NEHAjYkKIyWmREH6WytwDx2UMmH4qGUf16EgML/lrpa8BWWsLpgoC2IHuA8tOL1FCjBfyhvM3bgHPJx27UmLR5heFZVtLl00jy3b8xlH6hjeBER2WHpymby/qIAsQAf229iBpWjuRaUDbRfLkKrGcX9/e15itNJB79GuXEzyKpKDLiZzFraVRFSaYV3Q9gg04N3eS3YMkA3JyTukoUYQoXjMJMjCfs5b5yss0opE5+e8Or7C8IUDzxyPG28vzBV6T/Bb+kSLjNYDw1tUZ5rs7N3aMvkbyosNFYNrGoxoIH5Mmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:39:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:39:33 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/7] Enable USB in device mode on i.MX8ULP EVK
Date: Tue, 16 Dec 2025 14:38:32 +0800
Message-Id: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGj+QGkC/x3MQQqAIBBA0avErBOagSK7SrQIHWugTJQkkO6et
 Hzw+QUSR+EEU1MgcpYkl6/AtgGzr35jJbYaqKMeCQcl5zPeR1BImrWzBpFGqHWI7OT5TzNkhOV
 9P2bn6oBdAAAA
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 367f1574-7c40-47be-b6d1-08de3c6ddf2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnNWY2M0MjBCaXhEMnJMMEpTc3pUY2hhc0tHdENGOXVaZTRBQmtqeG1mZUQx?=
 =?utf-8?B?MytKcitLS0ovTlhCOXJJbFhBVytxaWhmWVV3a296Z0NVSlVPM0dVVG1HYlRo?=
 =?utf-8?B?dXliT3g3N1RmejgzeHIzZ1JWc042dmhxVWt1M0thd3JMV05ZK21wQnpDL1R3?=
 =?utf-8?B?NnF3bWo2VzlhWHlYL3FyOU40Z1ZYbEFEa2o4djMrQXgwalF3bDdtRk5EZ3Qy?=
 =?utf-8?B?ODFMT3pidTh0SnlhUjhNa0xKOEVlRUQ2WlkwL015b1VQU0RiMlEzV3VjVzYx?=
 =?utf-8?B?UFUzVHNNMy9BV2dzcFVqa2J6ajE4S3RhNCtFVVFkTVhiT3hjR0prVk0xeVNo?=
 =?utf-8?B?cTR3NnJlVW1nZmZFeXhRaWZrNHhDWENOdmJmUmRVbFRpNUpGV3VvcnAzT3VE?=
 =?utf-8?B?YW1ML3dsOHNPTHhNSlJ3S2thc2tLd0JpVHN3d0JpNHk2dGV1NkI4ZkM0enZ0?=
 =?utf-8?B?YVBNL1lqOGovUTIxbnNYeDFiVU9uMjNKOVl3UWI5YklKZDQwT2dBWlp1QVBE?=
 =?utf-8?B?VWs3QUxTNG1hNFVGSDdFcW9MOTBBOCsrdGR4Sk42cFVxc0U0SFN0b1BoMy8z?=
 =?utf-8?B?N2NRM0w0WmdmTXFpZmQrd2p5N3lNeFYyZFpxQjlrRFBMZ2VUWUZ2VDRadExz?=
 =?utf-8?B?STVjTXZWQTNmYzZtYjNlMTlzREtMMzh0cTVJUG95OHZCZ0o3V0t6MjYyMzl1?=
 =?utf-8?B?eXVBc2RrNEFya1c4NlExVkNmVmpqSDZXRGxuYWcyUVgxMHJxWDlER3lWY1BD?=
 =?utf-8?B?elplZE5GYndFM1dONXhhZXBUak12L3ZwcUg4aGRpU0RtQXFySHJRdjhseHBN?=
 =?utf-8?B?WnBoaEVqaEhkMlV0WFdzVFVzMCtWMk44UE1XWWF0SjlEVzdTNHIybXhSUFly?=
 =?utf-8?B?K21KSFJPMTFvbFJqN25acDZoWTAvUFRVOWdlZUc1R2hoM2w4emFDUUNzeDhZ?=
 =?utf-8?B?ZmJnZjBSV0JxQzBjUzkxN1V1TXorUHlqTlBiV2JlSTlJQzZYYk53TThnQlhX?=
 =?utf-8?B?K0k0Zzc2b2dPdnc4ZHR4SHRhYkVzODRhRW92MjNWMkZMRFdZcW4xZTRqK1J2?=
 =?utf-8?B?QUlROXdDbnF4MnRFeGRsZFdXdWZ6VzFRNXd2N0J6MTNxMzh3emxlSzF5WFVF?=
 =?utf-8?B?d1BWaHZkVHBqT2puekVlNFZpTmN6U3NiZVFVOEhXQSt6Z0tYNFB1Mmswcjg1?=
 =?utf-8?B?SnZZWjk0eFNWQVpPRTlXTlYwV2JMTUI1dUxKN0lLby9pN0duSk1MVTJnY3VV?=
 =?utf-8?B?bmRVNlVFWnkzSmd1cWRqVDBpdXJKdldSZUlmMEplbllraU9IL2hWcGVyOGZh?=
 =?utf-8?B?L1VmWWNtbmlJVnROVFczdWlVY2kvRk5VcmN6QTJIa0N5UVAweFQ3N2QwTHhk?=
 =?utf-8?B?Qmo4a0grMmtVUGlubm05ckhCUmoxSUZ0N0pid3gycWZBVFpxaS80TDU2Z1ND?=
 =?utf-8?B?UU5UYytQalhSRzNPTm9oTkVDajJ3djRqN1FSMEFqN1BWbHR5R2taSDRiSFNW?=
 =?utf-8?B?MHAwRWd4ZStST0ozRU9iMktQWmNVZHRaSjFOYXJzVmdvVTM0MXZjR2dodXVO?=
 =?utf-8?B?WGNCNjdPZEpnOGMrcDJuMnNTQlNkbkxzL1ZVcHc3NzVjaUNqWGxEcW92RFhX?=
 =?utf-8?B?d2krdTI0ZXlsYzZkSVdMcG05ekpLSGNMQ2dlRmh0WVhkd1RFMXdUR0lZWlFB?=
 =?utf-8?B?NG5NLzkrRzNNcmNzRFUrbnkyKzJhei9ncUVtK3g2WWVMaVhMVmxKRUx2SElY?=
 =?utf-8?B?QVIxYnJZeDRVVkNBallCa1NaS055dC8yZnlINGgvZTd3SzBsam96eFNvOFBu?=
 =?utf-8?B?MkIrVjU1Ly9mYTJCQUduOTd4aGN3R2RkaHQ3V1JJNFpNL1IwUjNzZWNGekdy?=
 =?utf-8?B?bnJ3cmJ4MFdhbVpEbUZUb3JlejFMNzRtUkVHTkRvV09KUFJGWWFzOEZKeXRn?=
 =?utf-8?B?c1Y2TXJZTEVJKzBCTUU4UE1qREZ2eVJaejVtZmxMa2FWVmpOL2JvVHZmWThq?=
 =?utf-8?B?VVhEQXVuRHc4T09KbzFGa0lWZWw3eEFibXZzVUxlR3NZNVdPY0VpNWt6Nm05?=
 =?utf-8?Q?px4sYA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBYVThtRGFQdDhheWRZdXJaWGFUL2YvMjk5OWc5YURKcThLRFZlZW1ocnRS?=
 =?utf-8?B?RWxwYjdac3hsRk95Nzc5UUgvY1Uvd3JSdG4vNVF0TFExU3BPOUNCeldLSEJI?=
 =?utf-8?B?MVh5M0FJZzloRHF5empFd0JuUWhDcUJWVWVTdWx2QU9KeHVHSU5KVFBnWVQx?=
 =?utf-8?B?cDhteEErbEU3ZDd5UUt5V1lGYmxlTjZIdlZFMnZLbVI0ZzQ2R0E0Z203Qmla?=
 =?utf-8?B?ZWtzSU11SStmQ1lyb2tpa1hZdkNyUlpIWGE4amdTbkM5RmJKeWF3U2FlTEQy?=
 =?utf-8?B?VnhEL2U5YVpHQUtsTmdhblVheXRiQ1YzclJaU2t4WXczNk5XUHluS3JOL0hY?=
 =?utf-8?B?Q3hlTy9Hb2NrTFl4UnNXT2dRS08xNk1PY1l5aTVBUXhPdE53TE8vVXc5d0Jx?=
 =?utf-8?B?VHNBdzRlYUpON3R2REkyQ0tCYmVsMjRXckYzejBaL3dBQjBLT1JHcGJMWTRI?=
 =?utf-8?B?cUs2RHpSK3gxR3k2N0JlNWhTVXhTQVp0c1VOSTYwRzJTa3NlRlFKWHZjd1VL?=
 =?utf-8?B?VS93MEtqNEJRQnNOTW02am9yNCttOWw0eklCSXJlQ2Y5M1NuRTYxR2ZNTmRV?=
 =?utf-8?B?NE9SS2JQQ2F3eU9LREdndXB0OHJ0Z1NoZUVxRmpEN01PQWdRSm5WVWRGSFpW?=
 =?utf-8?B?WXpwQlZTb0RvYXgzR1VGemJxZTdhQlYvVDFIY1hYSXhIS3BYMm1vTVZFSU5y?=
 =?utf-8?B?KzNmSjIyYjk2SUJ0L3Z5M2xZUVJTL2FtbHRWMEkzU2o5M3VXcXIzc2JPWXIv?=
 =?utf-8?B?QUVKQk9GUGIrYjhCbGtwRkp5cjlSYzdsdENtYmMwV0hFL1pUNk9YYlNhWGg4?=
 =?utf-8?B?L3VUR0xsSjFhUXlGcWVyTXlrYUMvY1dVMkZUMnZPbStJb2cxQVl6ekJ4b2lD?=
 =?utf-8?B?ZjFoNVh2MGxmS05uNGtQQkRVMHVod1kvcXFBcXE4U0ZkbTcrNWpYcXFLZkQx?=
 =?utf-8?B?RitGRmxFb2p1MW5QaHFEa2xsRHhJWDJHUHFOWUwrY0dFMVdReFRvWnFIS09r?=
 =?utf-8?B?ZXFZR1Y0NDJBejNtTnY0Zk5yOUkwRTFCMDl6aXR1MTZ5am1Pekc4ZHh6VGFs?=
 =?utf-8?B?WTlEZ3ZaRnRvaDNLbHVPdVFEUnlMUU9BTDAvZmNQK1BGVTdLbkJGWU12clpB?=
 =?utf-8?B?K1hGSGZOOS8vcUs3Q3dJNmd4aGhSdm9uREFQTWhLOVdCQXNtMkNNWVBIaXdJ?=
 =?utf-8?B?M25rSTdZazYvUmZQZFpmeTA4b1BNOElERWpwcTRwSEJ4RGxYWU4xeE9QUi9r?=
 =?utf-8?B?S24rNUVtYVE1NmhBV2pub2FuclE5ZDNjRHNET2lqZ1NCYmVpUlNTVmRQWE9t?=
 =?utf-8?B?L0wvcGpwTURQNWdlcUQwbHF2ZDN3NDU4dEdTaXdwRzhCNHU1TTNIV0V1WWM0?=
 =?utf-8?B?dzBVNm9qWFBMTGdQVGxNZW4xdXRQSjRQS3p2c05aa0NhNkpzYkQwQng1NWVN?=
 =?utf-8?B?UURWZzgwMGxOZFp2aHB1bDJWMmwxSEk2aG1qRkdORzFFaXhJK2ZoTVM3Y1VQ?=
 =?utf-8?B?MFFPK005R2R6NTk2dFdyOVBCamdEZnZ6N3ZaZVlTZEhEQXl0YWN5ZlR4SVg0?=
 =?utf-8?B?VHdIU04xWFJIdmYyOGhYQXZLblA0L0tJSTk4N1RTZmh4Y0o2RzFXbEdLSWxv?=
 =?utf-8?B?aWhFVGlYeFpIVERaTkpVbFBaNGhobkFhdHhQbzBmT2M4MGM0TU1zSnJTMjA5?=
 =?utf-8?B?RDF4K3BVVS85VTJZV24xd1hiQnVuM285NHFoaUZtRG9XMFFMbTBBbVVsZ0pM?=
 =?utf-8?B?S2pUdVpUUkRuaDJLUlNWbVhuMW1QakxaMVNzcFBDRG85a0tRdGphWStYN1Bt?=
 =?utf-8?B?c0dEK3drTms3a2NwdW8rc3hDb2ozWDhsOC9qa05hbnlOTmJvQ2FQQVdsZDc1?=
 =?utf-8?B?dzNza1YyOGtVS0o0bU83dUZQMFdoRGpxWVE4ZEJRY2t6M1BCa2x4Ujk0OWJQ?=
 =?utf-8?B?K3pXdVVjaXFnejU1UlJPTmE1emY1SUdFLys0WmpHODZUVVNqZlFneEowTmV4?=
 =?utf-8?B?NFRKR3FOOEIvRzI4UWhRV00rYkFWZjFHZE1Fd3pyeGVyQm1kTVBTSldTeCtx?=
 =?utf-8?B?VUVFSDhTN1BzQndKazNiUit4dVhVRW41dUw3dm9PVVZlMnpZa2lsay9SMENp?=
 =?utf-8?Q?wVr2GPZitA8GmyacYs6DBp9qc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367f1574-7c40-47be-b6d1-08de3c6ddf2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:39:33.0111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ufw8HST5bNZ2zoLxcCA3zPVjLp14rmdpYIwkNG/foC39t9wDLEGCz4ttn5donXCNyTfJa4am/lj7+NNWM2iSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Changes for v1:
- Refactor USB PHY register definitions to a common header file to
  enable code sharing between ehci-mx6.c and ci_udc.c.
- Fix the usb_oc_config() function to correctly handle overcurrent
  configuration on i.MX7/8M/9/7ULP/8/8ULP platforms, where the register
  layout differs from i.MX6.
- Extract PHY initialization code into a reusable function that can be
  shared between ehci-mx6.c and ci_udc.c.
- Convert the ci_udc driver to use driver model.
- Updating Kconfig to automatically select DM_USB_GADGET when CI_UDC is
  enabled.
- Add i.MX8ULP platform support.

Tested on i.MX8ULP EVK board with USB mass storage functionality.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (5):
      usb: ehci-mx6: Move USB PHY register definitions to common header
      usb: ehci-mx6: Fix usb_oc_config() for i.MX7/8M/9/7ULP/8 and 8ULP platforms
      usb: ehci-mx6: Extract PHY initialization into reusable function
      usb: gadget: ci_udc: Add i.MX8ULP support
      imx8ulp_evk: Enable USB controller at 0x29920000 in device mode

Sherry Sun (2):
      usb: ci_udc: Convert driver to DM_USB_GADGET
      usb: Kconfig: imply DM_USB_GADGET

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi        |  17 ++
 arch/arm/include/asm/mach-imx/regs-usbphy.h |   3 +
 configs/imx8ulp_evk_defconfig               |   7 +
 drivers/usb/gadget/Kconfig                  |   2 +-
 drivers/usb/gadget/ci_udc.c                 | 354 +++++++++++++++++++++++++++-
 drivers/usb/host/ehci-mx6.c                 |  93 ++++++--
 include/usb/ci_udc.h                        |   9 +
 7 files changed, 465 insertions(+), 20 deletions(-)
---
base-commit: d21fcfb29ec2871976de8d21ea0e60fb13ce032f
change-id: 20251216-imx8ulp-129e9fdc1128

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

