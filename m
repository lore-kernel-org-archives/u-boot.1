Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E53D3C545
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8D083C08;
	Wed, 10 Dec 2025 14:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o0rJut/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89ABE83B48; Wed, 10 Dec 2025 07:27:52 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F23883A35
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 07:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL/wgRrHl+EwmEDUTil5GhD9xaRvTywtgI24M0LhRnjSnRXerPG1JJlor+8rXW0+/ZVnwqx9CM7oSOI4V/CTuFvmB4DtvnoZHKKMH0zsQmpain21VDgev7SfQhipfi4GYfCI3aRYVYJKr10OzpJ5HljdiC6Sa7vqSXbN0ERmynYLdGvULfTTnTgsglxCNL0+e8HD1AmhobUDF+vyvUXxgDtGNY1rGKswgDuyz2cZLeLCpbMDMG/XZosPnuEH1DfopoGZBtzZouVzFDh1yx5pRfD5n6DJouFpKwTiMgu9hyX6wQX8Nf1JUFrdRa4FpU4tqOHTTposZumjqxwsZhnpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKjgfx0a4D2k+DXq9+NL99M19xKssyTS8tXHhl8eduY=;
 b=gE1AkitymQGGdsMYh30xJ1BofjHGBnqTeDjBsN4uzJAKswUxAgEMgpCirpooLg7ue/4aL3grmZhNFxU/SxqljXUGPY3hX1Mo008csq2vlwaxvjjMZSTLfYFfX471OZvYyJKfwU7YoPNskDxHLy2MLEbPhq6qVXBx0iiIB4efpy2/c1EVxBsoAP2uM9kIRc7BP5pe/u95j9bIapKMZTKcimBZZyd2WHKAh0ihyTZmWtAM+iyTYz0QCc3Z267ZNHaiED06yDqPY6HtSPGMZiFyAiDspSk1ZDGN+sB0Z8mX2lMg3I3dNoXqOlC0+vcpLZ/Dn4I8NSuQ1sksLMpkzQDbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKjgfx0a4D2k+DXq9+NL99M19xKssyTS8tXHhl8eduY=;
 b=o0rJut/LxyUiflznQDEr+RdtKYR4w716jabjkI7/dx22AMphpgsXICxKiF3lent1254p+BXQsisgQNgQpn953Jo9EVK9kxxaikKxTAuQO9mc+uAcxICG9CobKT8+47u9fk3mLqXAO+w0s+LwcGe5xvnGYcOErsTOl4bIaUR7aNRk9zAyFGDPxNmiGvBTvRxG/UVWMsqXt69svMKbk8IxeOh8py4EtheeMFktj0D5UWBeqh63dxRL4SHapzXRdowGlSC2L7liS6nQPqyYph0ULkWjW12v40VO20wCyICid57F8O0oWu7Q2TS5uS1V7qKSGtUcruyxEoOj7RqEsSoGPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 06:27:48 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 06:27:48 +0000
Message-ID: <1d79237b-4dfa-45df-a4cc-a01542d3fef2@oss.nxp.com>
Date: Wed, 10 Dec 2025 14:27:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] imx: Support i.MX91 11x11 FRDM board
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
To: Francesco Valla <francesco@valla.it>, Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Jacky Bai <ping.bai@nxp.com>,
 Justin Jiang <justin.jiang@nxp.com>
References: <20251209-imx91_frdm-v3-0-02303eb0c1c3@nxp.com>
 <20251209-imx91_frdm-v3-2-02303eb0c1c3@nxp.com> <aTiWrz0RMo7umwbQ@bywater>
 <ab525485-eda0-43c4-a305-99b8727d94aa@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <ab525485-eda0-43c4-a305-99b8727d94aa@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|AS8PR04MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: 249b8ea9-1c47-4568-b4c1-08de37b53c9f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk5xY1ZNb2txeThId3gyZzdJcTB0NG5Hc0tOSmRzSlFXejFEN2ZoNU1vRWcy?=
 =?utf-8?B?SjYzRG91YnQ3YS9TSTBWOXkzclRHc0I4QnFnelV6d2dXQ3NvalNaN1p2aEVY?=
 =?utf-8?B?UmYyK2hZRVRtdytpTk9VUWxoaE1SSGJNUFllMExPdFlmV3UzY0pOeVQwY3Rz?=
 =?utf-8?B?S0Q4S2NIR0p6RHdKSUdDRlN5MWlzV21qWkxsOGRUNGFDOFpQMzdzNCtLR0Vp?=
 =?utf-8?B?bTJONGZRQnFrN0pTRnluWFRGdE1EN2hldWpUQ0xCRWZ0UGliV2RmdU15RlZs?=
 =?utf-8?B?S0lHWHJwdUN6RmticnZ4a3B0NnhHZDkrQWIyRXRNc1FrYXhZSzgrOVdyWlRK?=
 =?utf-8?B?N2UrWUtYT2dra2VUNmh0Vmp1WmlVZXZmQk5QaDFNNkRWaW8rSGhMa2NteFc0?=
 =?utf-8?B?Y2lHa3VoYnIyOGgzZ2wrMmxqb2pvZCtmMDVmNmNTalpBaC9qbG9EMGt0Y2hV?=
 =?utf-8?B?SDF4anJYS0IrQTVDL3NHZXhPSW5IaWQ3MDRRd3ZMUzZ1VGJOWjRFZGxzM0xV?=
 =?utf-8?B?QlkyTUhabmhjWWRJMEZIRStxcytZMndJYngrb0hTMVoxNGFsUnIwR3VmajFC?=
 =?utf-8?B?cEZXUVZITUJjdUZwZjhPYklwMGxiMHJoTmVjcDBDSy9XY0Q0b29JTFlpYXow?=
 =?utf-8?B?TktxcVNsZ3Y2Tjl1akdrWmtRSDNhTHpJMFVMTk9mWFB1dm5lQ0FpaE5LSnZB?=
 =?utf-8?B?b21LR2lMd21WMUNqNUl3dFh3QksrdlJRTlFVSW1PQmJYZ3BocXRiM00vYUg3?=
 =?utf-8?B?OHZhdHVPV0pFTHJRZDJXWXFqZkJoZExmb09sZlVhMnBKcFN4UDNtTXphaTJ5?=
 =?utf-8?B?aytYSlFSdVhwd1VpVTZvRW1PcnZlL1cva1NHSlRIY2lRbS9tMzllVEJjRTRH?=
 =?utf-8?B?SHpVeDNSNmpVTjNwclFFcFFBd2dYeTRqMitpcVVwODRKb0txZzM2Sk5PbzRR?=
 =?utf-8?B?RHIwb0F0TVJwMU9PeE03bSt2QVN2c0ZpV3Q4VG5RZDcrM1Q1Nk9XYjJmK1BX?=
 =?utf-8?B?NnBScW9uTUtRb1BCdVFmeVhkZ3c0eTArMjNvZ3ZyM1BmV3lLbHhhSkc5azhy?=
 =?utf-8?B?YXJFLzRQd3YwMGxjbGVoOXdoQzFUcVRUaUlMQm8veWpzdmNVQ25ReFd3bSta?=
 =?utf-8?B?UzBSUGs5KzZxelN6RlNoeHEvZlluUlh0NHFMQVR6a0t0cjladlhvNDdGcEN4?=
 =?utf-8?B?bDYvVDE2U2EyeGdud1hJalFGTEJNQUVZcEl3UTJNc2VYKzlRN3BFKy9Kb2Yr?=
 =?utf-8?B?ZnlXeDNVeUQzSWVKYVAzU1pyM1JFTUlDd2ZETWxUK1ZLNEVOeFlOZjRvblNs?=
 =?utf-8?B?WG9yem9XWG1XZC9kNkpQMlkxMWkzQWRvV3AvOWZWLzlaRzlqaEtGWjFOQUxU?=
 =?utf-8?B?bGEzaVY5WllFTjFoTytIbFY3WE1GNUROS3F4VHFvdEpwcUJJT1E0LytWaS9l?=
 =?utf-8?B?SWFTQnQzZkc3SGlVNGFadjBuakRJTUluckJ4Y0ZjVzVFRGsrNFJscmRJSGcv?=
 =?utf-8?B?N3NlN2RvcTh1c3lTNytONTRhSXRJTzFLbVZ2Tmw4VS9FSWFua0RLcmdPaHRD?=
 =?utf-8?B?aE5kTDg0TWQ3enlaUis3eGMzM29pSWNJcUhFeHhWaU9ZT2JNTVhKMTk0dGx5?=
 =?utf-8?B?MENXaUkyREJTQXR0cVVnRjhQOVVpZVFPMmVjSldMWkVlZmtwZ09WckdEZzYz?=
 =?utf-8?B?S3hzdzB4SWFPWUl3MXFvblh2anpQcHh4VDFjZ1Fxa1AweVZ5cFpMUWlyU0JK?=
 =?utf-8?B?WERLVFk2Qlg4bmcrNHdHVE9ySzVJbEcxSUZvLzcrdEFRN3k3RUthZ3FFWWhG?=
 =?utf-8?B?R002NkVVdkZlblBEVDhwbk90YmN1a29Pb2hkNEtNWUh5SzBKY0ZyUWV6dWsz?=
 =?utf-8?B?YitXYlEyaXlsMFpqQmhOYzd6Q0thbTBVZHVaV1pZSHZGbEgweWV2UTd0Y0xm?=
 =?utf-8?Q?wACEf3ILIamsKd1Oa3ugkBLalJeR3gLc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2M0VzJWL25TQnNLZjJNTk0vMEYzZDBQNG9vU09zSGVaamdrWlZ0UEJKU3h1?=
 =?utf-8?B?MDdmRjA3K21SUi9hcGFIU215M29Lay9uR1NJakpFZ1h6V01hY3FiUTQzOTJZ?=
 =?utf-8?B?QWxtcXhKQytwaW5Cc3JCT2lvN1dUNXowdWFjaCtUVks2ZzJNeDZMTnR1NTRU?=
 =?utf-8?B?Q1labjRMOUNEZnhoZEdXdTVRS2RnNEhZRlcyK2l6MG1HVUNveWhwYXhUSWJV?=
 =?utf-8?B?UFpDUSt3SXRoOXMxT2JqcmwvQmxsZGZuc0NMQWZ6cW5uc0hzeVhlZVRvdVlI?=
 =?utf-8?B?aytCMTNLVU1zWnp0aTlaSkdmRkJreGJCZFkrYUFoNi95NWU1blVmV093cldV?=
 =?utf-8?B?bGFiUXRURThPTVhVbWhHRXI3Y3BUSGdWUXNjTmtPZEZDWkJxWTFuL05MUDBv?=
 =?utf-8?B?elp6M21aRHFXY2tITkJnOTBGRzhkRUoyYlpGa2RmaEcwdjB1ZURjUnFrU2pl?=
 =?utf-8?B?dkVZaGl3UUpFRkxGcWozM0VNeldkUlFjM2hSVTRpeThYTjR5a0g0V2QxUUd0?=
 =?utf-8?B?MzhYcTlmTGFuYjU3ZGtjY1NRclcrY084VjBFdnR1QURQTE43VjRtaGowWldt?=
 =?utf-8?B?UkdJZjBTa1lJK1pLVXlvdE5PL0kwY3pxVjk5OHZleTc2bXFFSzNPUkVaVmpJ?=
 =?utf-8?B?ZHZHTUdkcFg0VVF3bTFzK1VjblRJR0xjM2xHM2FqVi81MEtMMTFna2szQzl4?=
 =?utf-8?B?OEp4cC9ua1QyYmRJdzgxdzFINHJUMmg3K0twVGJTaXJzRXJNOGZrOFJqdGVI?=
 =?utf-8?B?WC8ya3lRT2hpQVdYbmVXd2w2VVdxL09hZmFuVG9QTDBQeGdmeks3NWxwUC9l?=
 =?utf-8?B?clBqYzBBZnlwYnBlUitmQmh6QVdseEc4a09HVzhwR1JZTi9kRTNTQnZRZjVi?=
 =?utf-8?B?c0QzdWlrKzhOQll4U2R3blpUQnEyVFFpRGxGTWhyejdmbEYrWDEvckV0bk5X?=
 =?utf-8?B?VXRTWmQ5cmJNT25hczE5akZZMGRIWXJNVGNGWlJsZnhXaVNxaU90cnZpbk9k?=
 =?utf-8?B?ME1VTEptTGxMQUo1TnJ0NC8xd1FuZFVwNHhCcTlBbXNSa2t5YzlmZm14VXA0?=
 =?utf-8?B?MlZvV0RvdDVJOXg5dit3M1JqYzBmRnQyR3RnM2lPcGJTdFJBVlNBc3NMcjBx?=
 =?utf-8?B?b3dkVWRnSllTcmE3WmlvQXF1cUVTcldZSVc1T0orT1ZPcjJJVytIMTdOb2xr?=
 =?utf-8?B?STdiNmNPMUtpMUhDNEZ1ZnJVTExid25pZzFNMXh2WklqbWM3b0l6enZmcDNJ?=
 =?utf-8?B?UHZaOW9JU2Z1Z3h3TTI3SG9pWXRwNm1BS3BrTVd4bXRmanlINEszbW9yS0VI?=
 =?utf-8?B?OXA1aTFaL0xlQXlZTzZwTi9idHN4ZDJsRTJDRjNTd1FWc0VVcFcvdm1sbU5q?=
 =?utf-8?B?SXl0anJ0SXpnNzg1cFBRUkF4R3NGODNzcEtRTUZMSzZqL1NMQ2tCcmxkS1lD?=
 =?utf-8?B?THhpNVlEbVc3ZUExZDcrTGo5YXM3Z3d6RTh6N0o1VTBraHVOY211aExQVTBr?=
 =?utf-8?B?WGd5T1JOSDRkeG4rek9nM1liR3Y4dE9BZU93V0k4SnY1OUo4WXpKRmJsS3c3?=
 =?utf-8?B?U2g1OFJmS3dKaEhuc3F5cHRxSnlUOWt5OUl4WkpmVVVXeXNHQ2s3US9PVVhq?=
 =?utf-8?B?eFRsMEdFQ0FDRVhSblMyaWhCSkszZ1BZMmdqUUlVdTYzQ2N5Tm05TDRUZHE4?=
 =?utf-8?B?SmVJVW9lMTBrcHk0QzgwakVGTEFyYWZLWmNNdXVqZDN6MUZYL2tnbC8yQ21F?=
 =?utf-8?B?QXgzZWFHQTRETm5MVHFiWE5tVzVRcVpRcXIrUnZPWFFza1cvdENiSFQ4aURp?=
 =?utf-8?B?TlhDUjloZHFpc01WVUJvRE80cFF4QkdEcmUzQVdiOFhpQ2hhU1hUR2pjY0h3?=
 =?utf-8?B?WVhxT0IrK01uT2VtUGIrRWl3UUVzKzFTVU81L2Y1V2xRU08vb2VYak82aXJv?=
 =?utf-8?B?NWhDN3N5b3hWSXNHbHFJelZYVFUrR25sbjdJc0VSWVRNN1JNdmFuT1d5SmI3?=
 =?utf-8?B?UkpDdDIyTVJSUEVPS2syTllhdEpYRjhJdG9oOTlNdVhrRndXSGhVRjNPd1hI?=
 =?utf-8?B?eHVMdUNtWjFVN21abUIxNko2RFdRc3BYaFJIUGljb2F6bUFFcysrOXd0VUtY?=
 =?utf-8?Q?+Z9ovEH+JPHYsQF4tywKyl/Ze?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249b8ea9-1c47-4568-b4c1-08de37b53c9f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:27:48.1288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZGff2xxZz09fVfKE1RQBVm12//uVlZPlc4BjLOw4Glpw6a30AkaABYtYJtPUA26NzsOz9JHYQnZz2nGcfw1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:13:29 +0100
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



On 12/10/2025 2:09 PM, Joseph Guo (OSS) wrote:
> Hi Francesco,
> 

>>
>>
>> I also get on startup:
>>
>>      Failed to update cpu-thermal trip(s)
>>
>> But this is probably due to lack of thermal support at Linux kernel side
>> and needs a fix there?
>>
> On linux kernel side, 91 thermal driver is not upstream yet. And the ft 
> update is a common feature for all i.MX9 series SoC. So the fix is to 
> upstream the 91 thermal driver in kernel and add it into the kernel dts.
> 
> It is not related to this patchset though, I think there is no need to 
> fix in this patchset. Do you agree with that?
> 

Sorry, 91 thermal driver is already upstream. We only need to add it 
into imx91.dtsi and it will fix the problem.

> Regards,
> Joseph
>>
>> Thank you
>>
>> Regards,
>> Francesco
>>
> 

