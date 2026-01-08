Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87033D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4178984189;
	Thu,  8 Jan 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xgk6eMNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE57683B8A; Thu,  8 Jan 2026 10:52:47 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C54183A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLilFI62eldAgjIa3NdIKravSQ/LYbVCvZmuG0mpq7ktXY+gdU0rbI6zQNRRira7dnEJOJ+FV0fGNZ+g7Kr54gz04Ned3yI3QDfKDiji16xInQnOYMUfMDfJB+OjFvkI12O5VB692wiUIEnA87uauBQaaWfBuX8hanE6JG1/FAB6+hCXLOkrt8VdMZywbv4kEjsF5Y5CjKJkTa3n6nAofArVLnAreDm3NMClxakkYOPYVMGuVU7I7ucfFMZf7PaMxJDC0r1Eqmdmv4bq1IiDDTi4MtsgBI7eb++MdgGG7OBnKvUhPNYknJvJPspsqeHlbZ5aSU5a/Y7M9aFS2S+mXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNMxd5zSK5tB1Jd+e37gWPMar0Eo9/B1E9rBvqRQIdM=;
 b=LZ6+9QZ5m0bYNwLtaEWAW10oYWEEA5cZvDnZgwnEkvgqLVp6lVSNNTBOnh7oNBFqsQSiTAttvIU0N3d6GdPp7SQL0lr9n2Q1iB/WxNXR819hAc/+d0ALT6puA7L+xkHA7ie5luecS1DHsCkvMUPe4eOyFUVoXZ/21kNz7GEUcIwwV8V8CsLa+5C1/ctSHC3TX3fXG0pzwtc248/DJvHtK28/c/7CM1v67C0n1Qcf7ejWoSQLYu8m1NE1SnV+c1GEluZt9JQDPG5WQDxM9blbbDeqCnSSQb3IOtkKlF7UAxXteDV10+ITbCcsCXGBASIhTl28yWJpfdVi8fOhpErSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNMxd5zSK5tB1Jd+e37gWPMar0Eo9/B1E9rBvqRQIdM=;
 b=xgk6eMNs0UJArQ1PgSujYDhqOKcFYcXiFtQCyFSngKs6s3KH4Th5j6Z5V6SP3oxYsLklR/fer54Bsa1vDGgmDT0Qgwp5Of13VmuAemRS670keaTMbDi3YGFbjHQlUtjwtzDLmZGmcqJ4Eg7I106AtYVmTDzeS0iXQbqheS+jFqhAoyYxkkiKk5UfRmOyfS7BfYliLZvotgx9cAhN1WJBCDVcEV2jQ9N5MtWtCnu8YTx5ocjgJfOs/1z8VsFh3xnV5XEkx1dlc4q9Rdf5W54C2XqE/w+iwZ+3WyCtJJNwffapPmMUVTe1DYFwaKN4MBdfD+exry+Nci8NcVszfKBNLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB12015.eurprd04.prod.outlook.com (2603:10a6:150:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:52:41 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:52:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/13] imx9: board cleanup and include ELE voltage API
Date: Thu, 08 Jan 2026 19:06:45 +0800
Message-Id: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWPX2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNz3czcCt3SgpTEklRdM6NUQ4skSzNT41RTJaCGgqLUtMwKsGHRsbW
 1AAUNYdpcAAAA
X-Change-ID: 20260107-imx-update-62e18b9653e5
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB12015:EE_
X-MS-Office365-Filtering-Correlation-Id: 88968e7b-16d8-435b-f7f9-08de4e9ba9ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tll1SVF5UENHZlNPVm92VDZOakxtckpyb29vK0s3bldkcCtXRENOQ2FZVndN?=
 =?utf-8?B?eDIzQU9LSWp2MEEyT2MyUmR5SUR3RUQrS2xUdndvRnRzOFlSSXVIME9ENjlC?=
 =?utf-8?B?RE5hZnZzWFNHVVF5M1lwTENybUZIdkduZ2drd1B0clgzL1lmaTduVk13TzFK?=
 =?utf-8?B?akJiSUsrcW0wUk1MdDBwZnVoZzhRMnp6QW9MM1ZuZGlZb0J2Ri93ZEF4ZHEz?=
 =?utf-8?B?MGpsTGJsQ2JVY2gyOWNyQ1p4c1VGSTB0VnpxaWN5MWJodE1icklvU3BtNWVW?=
 =?utf-8?B?TUh6cmphOUJqQ3YzdnJhSDlROWU4TmZrKy9YSjMrTEZOU3V5MXY1QWprMjY4?=
 =?utf-8?B?aUx2Wm9XWmZrSGlzWWRrU0ZkV1RhcTdkK0FzT0dEZ3ZqU3hDQWVXZUZoRFJl?=
 =?utf-8?B?ZmRZeHU2eUc2cHFFSHNlTVcrcTJ4eWhNYnRZTVdWRGsxbHNNL3NiZUt2eXJz?=
 =?utf-8?B?N1J3V1owSUt5Ri9kNUthS0ZJVmRGUUhwTVJBeUJJRFlEYjZBeHVIaG00N2Jp?=
 =?utf-8?B?NWVPRFZSK1Q0RGlQU3c3aHNYYnBVS3I4THR6ZVVnQWo1b1lxRC9CdzY5YnBQ?=
 =?utf-8?B?NW9oYkV6TkxqKzFJQy9PenEzMHQyUXMxMFh2TFB2cloweEx2Mk9naE5RRGpF?=
 =?utf-8?B?NlRSY2Y3Vlk3VWp6ZnpXTTBhaG1neHBHRW5tajFvMGp2VUFuMmhVRXg0N0xI?=
 =?utf-8?B?ZnlDcTFWd1hSOW5mamhHZ0RlbEhaMGtmWTJ2aHlyTUxtZzUwaHdzak44aGhX?=
 =?utf-8?B?TDUzVUhVUGt1NmlmcC9JeGtiVUxvdHdWWHFITzhhV2hKTkg2TEdET05qVG9n?=
 =?utf-8?B?Wnc1WHBQN1JZY0IrTTFDWU1JaFNnckRMdzE4VTk3YThwdXE2Q1FJVGdMMnNE?=
 =?utf-8?B?TDc4YmtEMC9pM3Ara3VlVG9qL3RER3pLQmk0bmdKc3ZLWXZrTVQyNzduZzkw?=
 =?utf-8?B?dDMvbEdnNExVTzJ6dEZkVHJHVTRDMnRDUG5HT1F3Z1A2djdsU2NlV0RRYXlo?=
 =?utf-8?B?ZTNFcjZDbFB3bjVtcDRCZmxNNFRZcnR5WlFramVCcVk0TE5sSzZnOG5HZzRV?=
 =?utf-8?B?dDlKWDZsaWx0R3VUT1lUSUR4WmRlTitRckdUZW55TENrNDNMQ2ZHY3drblFw?=
 =?utf-8?B?MDdEaC9KaDduTkxuS2QrTWtVeWdEZUUyNStFQ012SnlsM0tSQXF3QWwxcFFj?=
 =?utf-8?B?YkNoUzhlZVppSXVjZlNDcXhSL3lwRWp1b3dCNXVvYnY5S2YvY0xOaTdKbXIx?=
 =?utf-8?B?UmVmMXFCRGtqNDhUUEg5bEZiSGlDYnprMkZKUTRWNU53Sk1UMlJ2NEd3Qkpa?=
 =?utf-8?B?czhTenZCUlVJR2Vpd1FaVEVaOEZuMFRQTzgrYkRFc2VUSkV3YkNvV29oVnhE?=
 =?utf-8?B?OWU1eFpiWEZCQzJxeENwUis0b1pKYTlvdk1MQkFLUHhvazdhVVl6L0p0RGQy?=
 =?utf-8?B?ZGo5dTgvNFNFU1QwUXlxcUJKWGZkdnZvRmdEUFFTcE55eFJacUtPeWJzZW1w?=
 =?utf-8?B?dlYzdW10UDNDVlFBQVZiMlhMaFdpSGtncXdJSitUd3hYY2J1SC83MGdDMDhT?=
 =?utf-8?B?a2hxaGFUZlNmbS9ja3hVQ09sb2laaTZCUzNIT0NZVzNGNWt4Wk1jbU5ndmtV?=
 =?utf-8?B?TndaNnEvdWRuaThXM0JPd01SNzBYMlI2eEdYSDArRlcrTzBVbGFTV0psZTN0?=
 =?utf-8?B?VmFEMTJ4aVNmRlNyN1dGcDhvdUptdG0xOHN1ZGdRMVNuN1JsSTM4VWNjaFUr?=
 =?utf-8?B?UkJQdHczb2VYMTZPOTZndmVEb3p1MXZYakpZNmhmd2Yrai85ZUptYzlLRUhR?=
 =?utf-8?B?VFdsT2NSbGlWVGFyV0RRcWtQcG5ZS2VqS1hTVkdCNFB1Nk5nTnc0ZGdaRWxw?=
 =?utf-8?B?eVNuTGJxaTRzMkVRSFUweFJrR04zTXE1THFNb21PeTRHeFNCTkd5c0thUDUz?=
 =?utf-8?B?MFZIYUxUcndXQUhHUS9hWWU1c3A2OUlISkFMdFI2WnNLeklMZVhld1p1L0o2?=
 =?utf-8?B?ekZ5QVF2QkhxbFU0WUR5N09kbjVOMld0cE9qMEpobXlYWFVsMGpDNU1SWCti?=
 =?utf-8?Q?djJQGe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVphSjUxMmdXMXZ3RzRaMlJZSllleWZ1eUwyOEpWWko2bkM0Wm9FeTRraVkv?=
 =?utf-8?B?T1FqWWdSNDB3UktXUFJ1U3NDSFhKZTQ0OHdkaWRUMzdvN01CNWowMGpxZ2RW?=
 =?utf-8?B?NEovc1pxY0RFV3Zod1NhLzFyUTZ2bGVEMjNra1luMk9aV250YWZqOE9SeENC?=
 =?utf-8?B?WU1xeU5OUjBFNGRUbUp1aUxnRm9tNEhyL3pJK3ZDaXl5VU4zejUxSzVvdU5D?=
 =?utf-8?B?NHIwY3JGbVVPSmdaU29QWmlHekxpMXRWWVF1WVpsUzZLeUFiUzJ1dThQS1o1?=
 =?utf-8?B?ODZpUHJheVUyNEh3UlhKbEd1bncvRnU5UDlFM0hBQ0hLc0lkRjdoTW1BMkV1?=
 =?utf-8?B?bVliUVo2ZzgwdzJDUy9DREVOL2sveXpCNm1jb1J5TzhkMXgzY2VYUHI5Ynk2?=
 =?utf-8?B?MFJ4UkRMckJ3MjBCWDVGcHhBTHRYQTlNQlJBVHdHdXlPdHlmR3g0b3lMZHRL?=
 =?utf-8?B?bVFsN05nUDRtendBeFgrZVk5cFNpN0xiZU9XRFJSUTYzNnlyV2syUXVLL3Rw?=
 =?utf-8?B?SHU4NHozQ0V0Rk1RbFhJN1QxcUxaOUNNanFjRGpJY2lQWmpaMTRsNGthZkhV?=
 =?utf-8?B?OEV2VFZRS3JhU0VVaGJldTZ2Zk1QYXdObmdYQUpwbEZTdEJvU0FSZEFOSlF4?=
 =?utf-8?B?M3g1K0xBWkZ0NmdlVnZLdXVJek1JMzVLZUlqbXNWRDZJL0o4bmNvclQ0clZ4?=
 =?utf-8?B?OVlGMXowaXpzdVd4VklrOUlVQnA5VXMwcXgyWS9SQXIwVFFMWlYvRCtxRDR4?=
 =?utf-8?B?dTdOb0Z5K1hlSlpEdTVKcmRiWG1EaGo0MDNpb2krMlpneTg0U09WMnBhTHk4?=
 =?utf-8?B?NHpuOXVSdFFGTXc4dXlmQTZ2K3FTWC9EM2F2WFd3b2VudFd4S1FUWnBDa3Vh?=
 =?utf-8?B?MFdxN3lIN3c2b1gwMlF3OXBRK3RGVTYvR1Bab2ZlQlE2bHZVRFNZYTBKb1lW?=
 =?utf-8?B?MHpCeU13bFpLUXFTYWZYeDJiZGQyV2Vna1czSzNFSG14RXNnYXNYd2h0M2dQ?=
 =?utf-8?B?aHhMVjlDMTJod0p6UnZ4ZmtoZVkwYnJGaFhlRlNDR1Rmb21pZ3VDVWZYNXVD?=
 =?utf-8?B?WlBYa2xsUUVBOHdLKytlNjFNMDdXcCs4NEFyeUV3QUlmK0E4RW5lQ08yWWhn?=
 =?utf-8?B?Rk4wVHpmUHdrUG9kWUo4S1BjVlZZRW5uRUQxbDd6VWVZVzFLb3NhQ1JXNDNH?=
 =?utf-8?B?Q2xjNExUcTYyWlFuQ0lHZlRZVDY4VGhiQk1iT0gzb2gvUzZNZm1jR0FJZXVq?=
 =?utf-8?B?U3ZuQU1mZ0pXZTczTW0ra1JBNHd2QXdLalhTZElFWnN2VWlIcThjNE9KSEhS?=
 =?utf-8?B?WUh3dFpRWTZUT1I1RE96VnhkN251aEJISHdrQUFRUmJybTJvbUZicG8yWGVm?=
 =?utf-8?B?K0xMWmVHemtld1o5WFYzYy8rOG5tRDk3MTUzdENSNWF5R0Z4d1dHbnJhVlRB?=
 =?utf-8?B?OVd0dmNTeVhVeWVTWDk1eWc5ZGMyRkxha0t2SE5DVExpS0YrOXRJZGdlNjhU?=
 =?utf-8?B?Vm4yS1FkdUlyYTZUdFk5N2hNNVE2YUxoZEdVVDgyL2oza3Y0R2xkV2hrNlAr?=
 =?utf-8?B?YzBBWGF4M2lYaDA2cUdNK0dnUkhLQTdNWFZQZ0ZWdmdLdXlpWWhwY055RGdL?=
 =?utf-8?B?U2ZRYitCSXVjWHFKSnVqa2h5R0VtL2lGVUJEaFdReStjM3ZDNFdvemhkaXZr?=
 =?utf-8?B?aFlSY1ZpRTA1K20ySWFTUDBYK3ExclBSTzVxbTJyZGpjc2lIV20zUllDZGQ5?=
 =?utf-8?B?d1dnc0FFTG91KzRtZmlPNEJGNmJzaitaSUdnU05SdDhtUExGaWxZV1VsSit1?=
 =?utf-8?B?MGJvbzlXbFhlNmttQ0FUb0FRY2NCR0FVR1d0R21jcjJrQ1dETVpPYXVqSHlw?=
 =?utf-8?B?UzE4cFlETUJhWmI2V2tEbmVEWG14aHl2d3U4SUt6eXI5TkcvaXNwUWhURVBh?=
 =?utf-8?B?RWxsMlM3QWxxUnRFM01hMmU0YTZpVU9WMXVFSHNuTDNoYTVmMFdtUUJXeFpS?=
 =?utf-8?B?VVdpNzlyMDBnNDJBS2NqeWFwNG9jT2FvMjFCWm5CKzVtTFNGT09QYWYySUpm?=
 =?utf-8?B?THFLMllEeFR0czVCM0pmN0crR3c1Z3hONHRqMWVOamNUSzlmSkxCbkRhYWxB?=
 =?utf-8?B?L29BbWpXd09pakUzTDV2Y21qTUVmN1VUS2psWk8xZ0VsWmtXTDJLTUY3SllV?=
 =?utf-8?B?WTlhc0xMa21FT3FqUHo5K3ZVaHEzcXJCbWlCRGJmL2lhNjFwNTV4UU9qaUV6?=
 =?utf-8?B?eHVRcU1DazhURDkwdHdlWFhPZTNmaDliNXlxbldFWUpNWFpnc0FJQXJRcUwy?=
 =?utf-8?B?NDBHRGg4US9VYS9mY09FTFlEY3E5aU1lY2RzbVZHUWtRbTlqZEdIQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88968e7b-16d8-435b-f7f9-08de4e9ba9ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:52:41.4512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+M+tXFurWZo1m6seOZYEdTmUoxAetZwkjVnE+xw3c1p9jWVYVH4e/5MAAjhfg2JhJ4z/rMRw3Y8nGVnmXgBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12015
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

This patchset is mainly to cleanup i.MX93-EVK board code and
sort the included header files for i.MX93/1/4/5-EVK.

For patches to sort the header, I follow such rules to sort the header:
*.h [generic header]
asm/*.h
asm/arch/*.h
asm/mach-imx/*.h

While at here, the last three patches are including ELE voltage API to avoid
create dependency if post in a separate patchset. 

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28959

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (12):
      imx93_evk: Drop UART pad settings
      imx93_evk: Drop setup_fec
      imx93_evk: Drop board_phy_config
      imx93_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_evk: Cleanup headers
      imx93_qsb: Cleanup headers
      imx91_evk: Cleanup headers
      imx94_evk: Sort header files
      imx95_evk: Sort header files
      imx95/4_evk: Add missing header
      imx93_evk: Invoke the ELE voltage APIs when adjust VDD_SOC voltage
      imx93_qsb: Invoke the ELE voltage APIs when adjust VDD_SOC voltage

Ye Li (1):
      misc: ele_api: Add Voltage change start and finish APIs

 arch/arm/include/asm/mach-imx/ele_api.h |  4 +++
 board/freescale/imx91_evk/imx91_evk.c   |  2 --
 board/freescale/imx91_evk/spl.c         | 28 ++++--------------
 board/freescale/imx93_evk/imx93_evk.c   | 46 ------------------------------
 board/freescale/imx93_evk/spl.c         | 35 +++++++----------------
 board/freescale/imx93_qsb/imx93_qsb.c   |  2 --
 board/freescale/imx93_qsb/spl.c         | 33 +++++++---------------
 board/freescale/imx94_evk/imx94_evk.c   |  6 ++--
 board/freescale/imx94_evk/spl.c         | 11 ++++----
 board/freescale/imx95_evk/imx95_evk.c   |  2 +-
 board/freescale/imx95_evk/spl.c         |  9 +++---
 configs/imx93_11x11_evk_defconfig       |  2 +-
 drivers/misc/imx_ele/ele_api.c          | 50 +++++++++++++++++++++++++++++++++
 13 files changed, 96 insertions(+), 134 deletions(-)
---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260107-imx-update-62e18b9653e5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

