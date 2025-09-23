Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47533CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0703C8357D;
	Tue, 23 Sep 2025 04:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UBTSXUJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13B983211; Tue, 23 Sep 2025 04:15:28 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F478350A
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKta+3u3w+vpWmLIqlN/U418DpG8iTInljkLs+NczdcTbHv+jwVJlkRtZI0FB+nf950mvvZ2HIEIiWCBhYcZ5vA8jSrRGzeMDBmqmrYSoaS6TQZBK22Wu00TIasYQuk73vTSw1zQCQU2MoQbOXFVXRDN7A97u207v6DKaWLmZIVIYu/K8LUlZhtJGtaMSnSIgBEqJccmhhKbQmNGNghVGI/aGo3RyC0eUPlK+agNpyI7sbY+8TbJQhMh/A4Oiks8cxm1GlXFtGsvliCtvkvZlxuPS93/mj8mCe+VDWCHjMxXj0dtubl3t1v2N3+BpvgMvfQNYlg071Wf3x9iojTsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNPpnJkWryXJsW0eSdHm+6vWPxEBzjKXkRHfIaUxLuY=;
 b=IC/fh+/7wNRp1fIKpcJdeH2poBS5bK+pOixtGi3EdJjNcGKNuPexh5f6QQxcqEKCtA9Vfx7bN5Z447G0BHg3xGQWpyhdlUCMCos+grwRchYWcnae2U/tdn5Xj9kHv0oOClLzK1O7CQwn690+iqR1XMx2hmWmrmDBGB8ZbyzfVU8daGTivxFVwyooVqYRsCKYDVVqXgvQgRGuZKiHzg+sYODtq7T4qbK5qmbmV6SMLoh8o9Yr/i6RbFouCnsN/kq7mUL+H9aBJQ+JPpKxC0tVja6i6sYzbT9107YlmZ6KKCRvSO2q1o4LUlhn8Yawivkg0f8k709AGAEE1xeNMkTc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNPpnJkWryXJsW0eSdHm+6vWPxEBzjKXkRHfIaUxLuY=;
 b=UBTSXUJdxhjjOCuVuF8fjK0PgsT5SjhJ4hU0WNTMt/as/apWFfN4ynRPCUPsWdZkEXeyLxfgFbgDCX24aLKlHiMWUAWjXrnCcM0Wy25RDF0RxwhOAOOa7VjrC728y6ILKI55xfTiN5cD4BdTPh0LOiM5HCc4Okb9WmmK87zGS4KrbR4eH4A/9SwX0Dqgg/ZoyoLmgZb6K2bO+xEdlzDe6Gmh6+7R5wbBPf87ug+L+jPYSOcI8YB0ITqx5EbpH3oS7uTJKXJDQPRWhlqPma1zL3iv5v6Oy9GumkYluGTP4idZurTja0GnZ4BJTfNB096rCdOlTRoyLs2ocMsBXXq2kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AMDPR04MB11297.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:25 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:56 +0800
Subject: [PATCH v3 04/12] imx9: scmi: Add i.MX94 support to get_reset_reason()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-4-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AMDPR04MB11297:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b243b8-3914-44e4-1f73-08ddfa470e6b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1BEMytrTDY4dVRVblM3NTNySC8xUVN0cGxReWJQWks4dXV0a3VpQ05oQWti?=
 =?utf-8?B?cGt5Qmw2UVFid3FNcFZHSGYrd3BuUUtqb3ZvYlcvZzJNWmVPSnJ5dlNoRUJF?=
 =?utf-8?B?UFlFNDNNczVURGlHZXczT0FteUtOQUJDWStycXF3U0FQTTdLdFdHdUtVUlZT?=
 =?utf-8?B?UkpwVEdLVzlyMjdkVVhCdUc2UFBpd2MwZ1o5QzVCendhaFBSMDlIYjhRVVRk?=
 =?utf-8?B?VTRXNjlpckdrdnpKUk5iTWFhUUlpMW5FZnZINE1ZQzBLSnpSY2RubmQrcXhk?=
 =?utf-8?B?ZnROVHNmSnJXWXF5eEptY1M0NVphYStnNGRJeVNLVjFJYXV3WWl4c0xlL0h6?=
 =?utf-8?B?OElRQno1SEYwQWRaTVJUblhrVzREaWdlRGJncXhmYVpLckxQWnVyUHZFZXJE?=
 =?utf-8?B?a2pxdmFMcEh5ODVSV0hrcVdwbVB4bkdPemhocUdsamJkRkhvQ0x0djRaYS9H?=
 =?utf-8?B?MVY5ZFFIL0c4bjdpRHFmUXB5djM0TmdUdldOTkMzNG45SDl6eXQ4SmZ1NUU2?=
 =?utf-8?B?OFovOWxVTllJcXhMRXVOTE11N0VZYmNZejNKL0ZTWm5md3VObTEySW9EK0hW?=
 =?utf-8?B?cm8vOFVMV1dpWnBZbGMwYmduNzkvdVBEQlYvSzYwbm5sOS9jRDd4VllKY3li?=
 =?utf-8?B?YW1iTkU3Mm05cXI5ZkR0K1dVZXhIUm5LMW5jSUxBcnR6YnpjakhRYkZzdWxt?=
 =?utf-8?B?TkhQUUMra2w2V0hTQ1Q5QUdPd3VPK0VqU1daV05ISDl4TFYyOWFmZC9XVlV2?=
 =?utf-8?B?OXNZM1QwdDU5Vk4rZ2t1K1k2MEdTUm45SFhtNERKNlNEZDdvaHZLWExJeE01?=
 =?utf-8?B?NDBqWm5TTXBXTTEvL29oTmRFNUI1Y0lhc2U0QlpBVGg2ZkxZalFvMGpLb1pC?=
 =?utf-8?B?RkxLMFFnZGdManJqQi9FY3hQOG85cUUrOU5ZMkhHekhjcE13VElDOEw3KzdG?=
 =?utf-8?B?NEJDNGxnQ1FRQno3ZmtLRzJFbmt4eVBOekdXUm44Ti9Uc2dTcFp0MWk0RnpL?=
 =?utf-8?B?VTl2YjRaZStyazRQc1BiU3RTdzduTmt4MGNBWi9QdkJxR0Y1Sk9oZ1hLQVBz?=
 =?utf-8?B?U1BlNXlqM2hpNkJOYzhQTDRWNjRYNFpqOUw2MUlxL2RhQkZHN3hlRWV2WDM3?=
 =?utf-8?B?bUliYVZSeWpGSCtkRW8rdUpaZ0I2UWNPRmRxNDZQRytBRFlmdUY3K3ZTcWJE?=
 =?utf-8?B?Y3lxdm9UMmZMOWQ3RjlpQ01jNEozbWcyaFNDQ0pvRDRhZ0tXckNiNW5ZTWlV?=
 =?utf-8?B?NlVReVExZnhDTkdoek0rdGt0eEZXU1YxR3pYZWx0WkZtVFJxaDd3MzJhSVlV?=
 =?utf-8?B?d0FwS0RsSkQxV0RWY2M3UXhwZHJpemVpZWtQVEhRVHk5K0c3SVdPTkFlU0FS?=
 =?utf-8?B?SGsyM1hsUjRzL0RGUnRob1IyQ2cvelB3VEFFMTVsVmJJK09ia0hmVVVITDRM?=
 =?utf-8?B?MU52Q0ZZbkNlWE5ocDVjeW5EcHBOSnlmeC9oVHV0U3VYK1pZMDFhVlZiTzZu?=
 =?utf-8?B?UGlZUXo5Y09SNlQ5M2VMT0oxTjYzc0szQ3RVN216TmEraDhSZ2hXaWRFZTNO?=
 =?utf-8?B?eDNGSkVZdEVyQVZUYW1YL2VKd2hFZE5rZkFtMjdpcTJjZ09TOERuZVp2amJL?=
 =?utf-8?B?Q3drejlYcWxleVRIWWhuK3JSejFFUzgxVU10OE5ySkNvZkhmc1d5QkVvLy9k?=
 =?utf-8?B?NndNZVpNNXpKUkxsQzF4ZHFuL1JVWWtnemUzY0NoMmtUODdQL0FTaVAzRjRy?=
 =?utf-8?B?RmZsb3h1eE9XMmZpNG0vajdWTnJSb3cwK09YMWNOb2drYmZwQ0ZpcytuYyt6?=
 =?utf-8?B?S05xV0lidWRYc2d1bDBuZW9RZERvbnVJWDhibGJkbkJYeGF4S0hPU3daSmdp?=
 =?utf-8?B?dkZMTTl6c3lERE16bjA3TVJqY2I5S3dmaUhZaVhmTWZ3RSt2WW9HVTM3eUdn?=
 =?utf-8?B?UHpRMS9xSHlKZ29GVTNYVnlESCt3VlhDaUgyYUt0TUtBclpqc2JsamJKejBL?=
 =?utf-8?B?QUxDOXZFeC93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3dzZlJsVGNrdWRSVG9WYXE3RkltTGs3MGUzc0xFR1ZaT3lCcHd0RnFFK1Zh?=
 =?utf-8?B?ZjdWSkt2OURsUzhZM2dOemFzSlpPcFkvYlhNM2pLelYzWURjNkdKNko5Qjkw?=
 =?utf-8?B?dkFpdGZYSzNpeWttWU9TOUFOc3RrcUVCaU1SbkUvbDRET2JyaGtPbk5jNGF4?=
 =?utf-8?B?Zm05SWRrTjhxbmh2c3hXcmFpdHZJNVVZeDFPUVE3Z2hSek9LMkFPM3lTdlhV?=
 =?utf-8?B?SEhLV3pUVW1oZ2dseEV5RU9PSSt0T3J2ZUhrbDNzM1dYZ0V6SFRMYWpmM29M?=
 =?utf-8?B?VWh4S2VVKzU4bk9aZFlvM2tZaG81NUl4b05lYWJYV0ZkRXNmWXNmOTJjWENX?=
 =?utf-8?B?amE5RHhXaHAzU1pZV1pQamU2bGIrNWhqTzFveDd3c1JPR2hOb3ozdy94V1h4?=
 =?utf-8?B?Q0N4aWNZUkJ6aERKcmJBYWE3VE9yY2tkY0lNYTBRT1JseExsYUxTSncrRGtk?=
 =?utf-8?B?bThlMmJIV2Z4UWhKR0FCaFZiNUhkdGRzb1BYZ0s5RE5JWGlPVUpHTUdDWWR1?=
 =?utf-8?B?a0czQ2FBaVJUZTRrb1g1ZmR5Tmx1N0tFUUtzbURJcWV6SWdQYjRrdjNNeUtE?=
 =?utf-8?B?SlRmUi9FeFVVbFBHWmtpZ2ZhM1ZZQlI0RHdHcHlpZlgrZ3haM040T2VBZmxI?=
 =?utf-8?B?QU92ZTdkZUtFcHc3cHpxMlBaY2hQTHVmYVh2aUJWN2VnZ1UxeE8xV05aUUda?=
 =?utf-8?B?aWFlQmZnRlRKVDJrelpxK0pRMHVoZXp3YW9CZUdQUkRoOG9XeHhKaWs1dm40?=
 =?utf-8?B?emdGNU42bVlic0ZuYThKWkZnS0VNQ3RKWCszQTBsVTAvQTF2ZGdyeTVXYnNJ?=
 =?utf-8?B?ZUt6RjAyMFFaeDl1VkU3QkUyRVVvVmorejk5Q2x2TTdhVW5HVE5MMnZCaTJG?=
 =?utf-8?B?dWVsNkVMOGt4TDdkaXUya1ZudmZHSHBkTW56d0pJVzhYVERPK0JQRHFma055?=
 =?utf-8?B?YkFUakRQTVRGc2hLUXlnL2NVemREcFFSSUpUK29GdHludWJFL2hIOFljOFJr?=
 =?utf-8?B?eTJlZTJSTGVhSEErVE9Xd1JOMWtGRkZkZk82c0pMVm0wRzFLSjQyY043WEg2?=
 =?utf-8?B?ajRKbVh4YmdqL3h4QVBFNU9mUHBzbnFmYWtFRnhkTzR0Y1hIa3NlMWZwc2lt?=
 =?utf-8?B?amlGNTlQaXlIUW1nSmd3YkFBUDdzN0NaMGxZa3NDYVl3QjhyVXRxR2g3MVk1?=
 =?utf-8?B?ZXRVSFpWL2pIYzFHNU1DQjlVUGNVTEo4ZkNLZ1Z6SFFvd3BERC9RMGg2OERm?=
 =?utf-8?B?NVAwUDBoV2VMMm1mR2Y4RlNKdy9mOGZDMk5WcVByZDZjMHdRbERoaXlwRXJL?=
 =?utf-8?B?VFhOQnA4T3M2di8vNlVabXBrVUxEOW0rVy9XVG9vU3JZSjlEOTZ2ZmVZblBE?=
 =?utf-8?B?Q2Rwakd6Rkp2QmMzWm5nUklFbU10K1VIQ2NWUjhPUDNMM25HRGxhVllVS3Ra?=
 =?utf-8?B?ODBUZEFYbGlJWUlvMEFBcWxsRHJPRDZIVFlBWm9FT0JjMVpHanVPSTNBVGU3?=
 =?utf-8?B?ekl5ZGhGakFlWWI4YjBGTWdDM2VKai8ySXRmMmc4czF6d1lPMWgrUnovbmZu?=
 =?utf-8?B?WVgzM1E1YmNERUh6QW83YVdVbEprTnRJNmN5RUs4VTJhV2lLK2dodHFSZFRJ?=
 =?utf-8?B?aFVIeTBWQTc1TnN5V0FXK0FiSUg1RDY5NjkxcHowWnFZUnZtN0d2UlZIOHNz?=
 =?utf-8?B?Rm1SVGJod0hrMUg2UXlZZHJjRFhnZW4yaTNLQmpoM3hVK215azZ6dVZ3Y1Yv?=
 =?utf-8?B?eE1uWkQxYUlua2Vxd05LcGZLdjVPTzVuMmhQWDlBelJpM0RVb3JSNDJzMTdY?=
 =?utf-8?B?czhqakV3NnJYQXBEYU02dDhQQzRwamZHOFFUay92R0lXTTlwUGdiZFNvaUMr?=
 =?utf-8?B?WW9aZGNPa1EraDFLOXNleXhXckUyQVVLZnBEV2FQVTRkK2Y5NjFRVGNhdWFh?=
 =?utf-8?B?Yytqd1h4Y1dnYndVcUNyeUJsMGdDalI1Qy9qeEhacUFUcitJTnQ0OWQzK3A2?=
 =?utf-8?B?VjdlMEpYT0FJM0JVY1pSeXA4WkkzNUpCVXp0ZDZ0VURKMHl5NmlBenZMVFFI?=
 =?utf-8?B?bHdwalpuUHV4akNQcCtidUh4TnZQY1VrL3Naak1UVkZkWGRrcVRNVUZsQWNt?=
 =?utf-8?Q?yq1+ctVzTO8MBZBfEbLQKnLPK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b243b8-3914-44e4-1f73-08ddfa470e6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:24.9435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH36zliU1JkX0xsZtqbkmi+oMyTZIFbih6rxgYtX46lhBNY7E8LYE9V3XvnDUfbDKq7UW/jgZUXeIZ7/cEUMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11297
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

From: Ye Li <ye.li@nxp.com>

Update get_reset_reason() to support i.MX94 to send message to the
System Manager to retrieve the LM/system last booted/shutdown reasons.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f04b9255cdb..07022c65b88 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -494,6 +494,31 @@ static char *rst_string[32] = {
 	"por"
 };
 
+static char *rst_string_imx94[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm70_lockup",
+	"cm70_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"wdog6",
+	"wdog7",
+	"wdog8",
+	"wo_netc", "cm33s_lockup", "cm33s_swreq", "cm71_lockup", "cm71_swreq", "cm33_exc",
+	"bbm", "sw", "sm_err", "fusa_sreco", "pmic", "unused",
+	"unused", "unused",
+	"por"
+};
+
+
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -512,6 +537,12 @@ int get_reset_reason(bool sys, bool lm)
 	int ret;
 
 	struct udevice *dev;
+	char **rst;
+
+	if (is_imx94())
+		rst = rst_string_imx94;
+	else
+		rst = rst_string;
 
 	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
 	if (ret)
@@ -526,7 +557,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -535,7 +566,7 @@ int get_reset_reason(bool sys, bool lm)
 		}
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
@@ -556,7 +587,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
 			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       rst[out.bootflags & MISC_BOOT_FLAG_REASON],
 			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
@@ -566,7 +597,7 @@ int get_reset_reason(bool sys, bool lm)
 
 		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
 			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
-			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       rst[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
 			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
 			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?

-- 
2.43.0

