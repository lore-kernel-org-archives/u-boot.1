Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B13CD6407A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B4483B91;
	Wed, 17 Dec 2025 13:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NEZkKBsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EDF83B32; Wed, 17 Dec 2025 13:48:41 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261E3839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw0xDr9pQ1l4vKztPG+kNkQx4fNHn2JpW/jn6hW2gTTyqD1hbv31w0x70sOO7bC87zLPYFzUkALDzY5NiHgQ1sgmzP+bxCgadnl+f/MO4fAR3UnpOT4Zb9eKSR2g55KzZmCT6K7M2fZuVVf5u/rDisVsDiExJzdrzoN+CacMDDAkTTbQCHonObKUFt5oLnJvkVo8syNr0VJK9vhPFVwn5n5pcif8ZHBL8XEVb5W2L8wr/ZtLP60pZcZG1b08+fLfbBDcfT+6u4Fth08HYaTWhLS7IVn2UWXKWym46XraMiLQN9m1EDcjUcRRY0zPmIhRnZ0VAziBt/uhrig0QSSfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os13+3GtjEBKLxLN5aYv0/oHzhM/em90wZBCpMF3QFU=;
 b=xgQpU6gWMLJDj6Mvash+Zxvw7CVe9g5+dPIZ78BFzaExCNn9GBN+vbDHrUjU2KCRoo4xRsQAv46iWr2AJ8KHTtlpINMdpBYcogIXpXwIY6ZzsPr1qofO7v04+Ww4/Sc6alHPouka87Uk7gJRyR5d+DybJrfs8f1vG+jYCCQJzt6MV3ymn8cJ8/plh0clQICLx+jDbsl2pURNCSCdzgUaNgywyoSXQI8MGDgIi47jFICmCtm1U6E3uNpV66xU/YqbhdmrGDKaduwt6km09dmkKZpYMvRu4MWKaZT3o9yT9AVx44yot909tcAg/A3w0WYJV0oEDQhFsjqtNlhJ2/YsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os13+3GtjEBKLxLN5aYv0/oHzhM/em90wZBCpMF3QFU=;
 b=NEZkKBsyu7UDPGAWCkBrjdW7xmULiDRH588/VEZl4s8a1cW/UqqEP8tzyupLa+Vgu3VjnPEmbYksbS2gI3dTKV7s9ktbvuWLgyuRTTP5e2yYmHiBORgGs6eCnHSKkp+c1Iph5O9NhuoVh1QlbLJkdGMo2ch1ibq22bkBmKWZ1cx4nv5wcc6TaT9fT+qPkfCQk6f18I5zdyZu2ON9nxTrxcmNxvLV8qfEEdrhyJ29PHsbU03ZV+Xsfx5oHXncWZJfrXboJZZ1ltRUUG5WBfBvz6MvblpeKXPlhNTxhgymAml2vCQ8k/SzE6dqG0VuupHHCO3yFx6up7tPi5k3RGFpPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:48:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:48:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH v2 0/3] clk: scmi: various fixes
Date: Wed, 17 Dec 2025 22:01:43 +0800
Message-ID: <176598007376.59835.2190294993721954524.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
References: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: e76488af-4910-4bc0-ff68-08de3d6a9766
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFpxcWhrRm9rZkRxcWJFODMvdDdZVEM4MWF5UU50SXBoRVRGMDRvY2NhS3Fv?=
 =?utf-8?B?V0g0TDFtRCt1S084bjlOTEw0eDVtT0NFWTYzWFFzMmNTL0xsMXd0ZlV0R2ha?=
 =?utf-8?B?N0RkeCtpWFplWnFLVmJoVCtoSE5ia1lGbHJYRDR1dGRGUXkzemg3aHFmQjdP?=
 =?utf-8?B?T0lsaW94Tk5GUThFS24xcDlDR2JlckprWDVLTDUzbmlqRDI0OGx6cDQ5YjZq?=
 =?utf-8?B?OGdIY0c1Yy9JZThCbUt3emh3SmZhaXYySWRFVGM2OHhlbEpCeUtHa29FV21O?=
 =?utf-8?B?TnRpa291V1JqZ2x1M2xXOXltemxFbjVZS3Q5eHdrUEhsUlJSdWY2eFRDRlp1?=
 =?utf-8?B?Slg2WUlKbGx5TTVMME04N21vUzQrUW5CeXZXeFh3cnhrRWdRVlB6RUR3TUZu?=
 =?utf-8?B?ZmJxdmpBY2VCYlV3MDhIVEsvanZHT2dGd3dvbkx4bDJITlQ5QlpaOEhZKzRB?=
 =?utf-8?B?MzE3QythdHhuV1hvbnUxN0Nvd3pXQndyQlA5c3kvOXBETysyLzlodXlBaTVl?=
 =?utf-8?B?OGIyRzgyZGkraEYwWGpVaVQ1QWFrdDJWQlNsaitRTk0zRDdiSnFBdnJJZStV?=
 =?utf-8?B?L045eDhxRWtFd1RROFlCNUNHM283YTZyZzV2bm8yY2REVHFrSE40OVg4Z2dG?=
 =?utf-8?B?QVVSQ1M1VWlKcythTWFZOVJFSlplUFZvcUV2NG80aXJlRHpsN01MRE51Q3Vk?=
 =?utf-8?B?NkpSSmx5aW1TZkFPdUJXNXZYVTUzY0ZROHIrcG85NFgxSHJ6WjRia0FmTU9y?=
 =?utf-8?B?TjQ5dHZGcmxJY1B6UWFGUW1xWElpQnp0V1dHUGNHd2RwQkdzcGlvNmNsMjE1?=
 =?utf-8?B?a1pkM0NpUDdaeE00RU9sZVhGaktEVUlmZ0JtSjJtZG5ZalREMUsxSEZlL3k5?=
 =?utf-8?B?SWFHaUNESkx6OFlZVzlIMXNKRkdTbElGbzJQWG9YNXRXNjk3TmE5ekVHZ1A2?=
 =?utf-8?B?ZkZzSklnOVU1aEoxeDB0eHZyZ3hLc1lrZ0djVDFuYWk3WVBkL3czVzdSVmYv?=
 =?utf-8?B?SGk4dHBLZzBmNDhmY0JGTG1wSFV5TkZMeC9DZTVSbUQ0TWxLdnJUanUzeGlX?=
 =?utf-8?B?TTNzOFpjSWxXSkVKTm9UR09nampmNWJHR3dLQjZFdUpBOUNYZys3OHdiL1p4?=
 =?utf-8?B?RTNjUGplVldNMWxXVGZTeWgvNzhzakVPRFpzUUpEUUh6b3VTSlV3QXJoV01o?=
 =?utf-8?B?TThJSkJ2N0FNdkp1V0hqK2RXNnR6b0tIN011OU5RSjJteWFlZ1R2YUlkZWRs?=
 =?utf-8?B?OWZLaEhvMG5vYWRJa3J3bE1ZbHliVlB5VVJIa254OWN0L3RxUGlWWGVrSkVp?=
 =?utf-8?B?cHNwREhMaUUvb0IzelVTZDVJVzF3c1RWWXV1SXVLalA0czFNVFNvazlnWFRU?=
 =?utf-8?B?bVRPUFoxNVlDYjNtTzVSSXdMai8vYjM2V3JCUVJPUHBqenVYMnlBWUhNY1FH?=
 =?utf-8?B?cW1kZGNxU2pTNS84ZnZ0QVVESG93WkRiYzBGa1doK25DaC9lcm91S0M0elhz?=
 =?utf-8?B?K0VVaHVaalJjQVdIOSthYUdZSE9CNUNpTkZ6RktHTmxXbTRYckg4SDdoYkhY?=
 =?utf-8?B?UzZqWVFlenBlTlVCcFFwWGhDcGlpWU1hN05MM2cwcXIxRlhEdXFOZE14UkIw?=
 =?utf-8?B?dGI1VEt0eU94bzNyZ2ZxNkdsZ0VLd0NxbERuMW44bkFoRmVOZUhnZWdHSjg3?=
 =?utf-8?B?bjZtZXN0d2xxWkMzVUhDSWRyWW9hWXo3OXlJUmFMcDYyV2QxVmZ5WW5iWUMv?=
 =?utf-8?B?Q0ZGZXIvOUxKeG5mWTRUWUs5dXYvblc1a3JXT2lCVVJGeXA0TDRHN3JtUlRK?=
 =?utf-8?B?ME1JSER2N3JpQmJkUWJKL3dIbnVlNnduZ1I3TkJ5dXJhYkRmREZiNlVaZVVu?=
 =?utf-8?B?WEZJRVBvVDFDUmUrRTRrbXBxazc4L3BhU3hMOGxkVWxnVk00d3kzRnlZdUJC?=
 =?utf-8?B?N3kvVmhyamJuUUxDdGhtaE02aGd0NVZKa2ZXRUkvWVJ3bmxrdW9MZTVDRFBT?=
 =?utf-8?B?Vnh3VWlWQnIrMkdMRnZUaDNIYXZGc2VQRlpURm9lbTF3MUlYOXdhbE1LTHZX?=
 =?utf-8?Q?eTIqTb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStTcWJScmUzaVRxa3VjZDVYODBYUlhBby9xdXlDdFJIOGs4M21GTFNXUVJ1?=
 =?utf-8?B?QitmdHZ2Q0tmUVcrM1c3eDlkWDR4dTdFVDhuNmJZSXVYZmlTZitIS1RTMFQz?=
 =?utf-8?B?MTcvUXRDMVRieklzVWFCNzVDWm0yUUlROEZkazk2Q24zQUxTcGpFZ25rNXp0?=
 =?utf-8?B?Z1F4TnBsTG1tOGlBWDExU01sRTlKUGFzeG9OT0tYRHNheng5REhFSzl0Qndr?=
 =?utf-8?B?YWNvWWVRdkFXeWxvWXNvWHVndkt5d2tNRlVvN3ZVY2w5ZHFpUVo0TzIzYy9a?=
 =?utf-8?B?R3BUT3VLYmNXODZ3VHZFaHBlQUM0cTFWa0ZvN0pSNVc5V29oOVdRTnJDQytn?=
 =?utf-8?B?UXJkdytra0tzeDF1RGppeTN5TDBRNVdDdlVXbFBxNXF0R0V1OVdnbGJEUnQy?=
 =?utf-8?B?WHNCd2RKbXo4WGg2SGJIZDhCQUJ3S2hFR1VyK1V3VjFRZU4rbm8wVzNGSVR3?=
 =?utf-8?B?amloZ3JKK1ZmakhmcFV1akV3dXZuTFpNbWN3bk01c0czSXd1VG1KbHkzcExG?=
 =?utf-8?B?d29HVklYRzJ3Sm1ubGl1RmJnem1RWnZXZUl6RW92T3pLTGgrVXlLZTlVdm15?=
 =?utf-8?B?YVc4ejQwYVlEWWNOR0kyQ3N5ZVd5SGp4K1NiTHpueEpvVHJGaWhwL1hJbTdt?=
 =?utf-8?B?S0QyMU5lVEpETjU1cUFrcGxWc2V5L2lPYTRGNkJMUzRaSGhvWG15b0VtNjBk?=
 =?utf-8?B?Y0FqNFczM1B0REpFK3FyZ2d1WFhocmx6UWpSMTliR0ZoMFZzSW9LM2JvRlg4?=
 =?utf-8?B?SnhFZkhkRC9QRUY4dWhlRkZUaGZRdVR2dU15dUxaUjVoamlHMkFvak11Mk1y?=
 =?utf-8?B?a2ZWTzA5dFV0UDFpaE4vSWRBTEVEZmpUR1dCQ2VVWm5KRXo1UGExeXJ4NkJW?=
 =?utf-8?B?c0RKYk51Y3N6UG9CVE5kbUJLT3l3dkdDU3MvR3hOS1NGakMwYzIvL2tINk5G?=
 =?utf-8?B?ZUtyc0NkdERiNVNqNHhqSzVLLzVZR29aa3dJRStJWjlSaFRBZ2Q3aENqSUxq?=
 =?utf-8?B?Zk0xMGdDOUNrNnE5S1lDb29jclIwZmMxVDA1V0dCbngzenpMWGlSekVHSmN5?=
 =?utf-8?B?M1p6YnMybHl6ZkVPN2ZwZ2VWVHVIN0hTdmNNMnVkSXNUYXVJVDFZVEVqUk0w?=
 =?utf-8?B?aWZrSXNHaW9uVmt4dkxxMVpUUTMxSC9sVjdjRDU3VlpFMGlNLzJ5RVAyMXFP?=
 =?utf-8?B?RXluVlNkbkRpRkk3NGtEVUV5Vk5HMTR5UnFLSEZuaytEWVRBNHlJR1Uzekc1?=
 =?utf-8?B?Sjg4MmhyM0ZyKzVvTHRCRkNUdEJ2bWkzL3BFOVNYYnUzREovaU9uVmMzMllB?=
 =?utf-8?B?cy9sRjFTNmhUYzJ6ZnVGamlvVkJMN0RaaytheHNQbDBybXVRaTRHcWpORW9p?=
 =?utf-8?B?R3orZUVPQytDMUxJSVBWYTVzblZVQVhibnRKK2s3T3NuaW9mUi9DeW02VVZ2?=
 =?utf-8?B?NS9ISzlJZkJZaDJWWGdXY00wdzZDSW1KZlB4Zk9FWnlCTWQ3eW13T292WmJL?=
 =?utf-8?B?N3AvOHA1b0hkclVvUG1hYVJnSlVlSElRdGE2MXBCWWxpcmJGc3ZuSE0ycXVQ?=
 =?utf-8?B?OERlZFFjTkhRR0YzV0pRZTJCKzBBMDcvUXgwVkxUUWJ6RnNScktteS9BTkNX?=
 =?utf-8?B?QW5QdG1MdklPeDJCemJXb0RSZkdxYUJQbjJQMEZTL3pMTFpiaFgvY2FnQzNF?=
 =?utf-8?B?ZDFQUUFiUlc5bC9sZFE5ZThhNzhYTWM4RXZOYTdLUnBOdjRUbXBSSnFMMFB2?=
 =?utf-8?B?bC9xY1dIMExHSy8rdVl6NG9ZN2V6cGxqc0NBR3NKOWl5ZHJJZ2pidmM0c2Na?=
 =?utf-8?B?YXV0YWYrM3g0SmJlVmtsaDU3a3Z6d2RGYWtoN1c4MmNFWng5d3dYbXBDeXpz?=
 =?utf-8?B?UHgxd2hwb0ZpZTlaL0JNclFNY0JJNkpmMVQ1Z05takg2aTJqMVJQby80emJR?=
 =?utf-8?B?ckNEa25XQzhxUGUxYkdRQmV5WXlNeWxZT2pVOXQ0dkFmbC9NMkdRM0YrcTVI?=
 =?utf-8?B?NDFzZVJjaGpyYWFWRVpnc21TT1hpYnJ3RlNHNnRMdDlxQmhQTk0yOVdhbTdX?=
 =?utf-8?B?RjhYb3JMNkZSc2UzVHIya0xsRlZGUDRKRHgxd0xZMkpXTWFZVFppRXNPRWVy?=
 =?utf-8?Q?24GWlqEwwHOsi+JyYPG79gzIp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76488af-4910-4bc0-ff68-08de3d6a9766
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:48:35.2574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNqSci9ZNCSwHFlFOUIWiNF2kyBMIb7W9fSo1fTPiqNCiT2Ht+ny1qt0pFlWNH7olmf42ItJ6QyTvSfVd3tgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
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


On Mon, 15 Dec 2025 08:38:17 +0100, Patrice Chotard wrote:
> - Fix typo scmi_clk_get_attibute.
> - Fix priv initialization in scmi_clk_gate() which leads to
>   clock_enable() error when CONFIG_CLK_CCF is not set.
> - Remove duplicated scmi_generic_protocol_version() call in
>   scmi_clk_probe().
> 
> 
> [...]

Applied, thanks!

[1/3] clk: scmi: Fix typo scmi_clk_get_attibute
      (no commit info)
[2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
      (no commit info)
[3/3] clk: scmi: Remove duplicated scmi_generic_protocol_version() request
      (no commit info)

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
