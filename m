Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F58CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D9F83C60;
	Fri,  7 Nov 2025 05:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BL9ruxph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8701983C08; Fri,  7 Nov 2025 01:39:53 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C17183BDD
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 01:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP2coK3miUPsHU6rWQ34695ZSeAVoH0l0nN79Cx9pDEuc0uA11ETEkHkSpVcdhbmMzjMzhlNYQuYHT+Ywe6Wsx3xMGFk2NTCYs27aRdi2/oRmbmk4U9KWl2Gy/IL6jb3s8i4TowUgLLLJLDnR3HLU2bfKKpzZ+mFNoqkI87IujqpK3RtVdbjAkoN1+WwtGkZCcQcTS4+2iZYNCm6VzAFG5DXw9WMqNAA7FSNkFiihYS7jXkO5mZfNRw+Ua33Bv/O3RUW+5luigbB0bGbQ2xaBcaAp5EiPzpG9ky+XCDqsmDUWJTNC/kbAqKRLK4T0EeKMN4Pn43tHp2bszdufrrPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RKgLQclAVsUBYn/dfMTlozKnI2KFRYxanBgxUhHrNw=;
 b=pQGAu2bF9qAitnskYl4VbapR616kUfTHfwRiQT8gnUM7ESnMqKY9gEB3VFy9B6wfKabQGvUgRdXwI2o6nJEXDxAZ9PCyTkvlIUnmrPlONcB1zHAO5QL0QrOY46bLqG3vmSkn29AtPL3BmaGWcyoLQ8TQIlitfuy8qzX6dpvgTt2X+kr/C+AYUJ8N0EOKS/b+3rjeF8r6ysG7tFPRR2Bqwo3C/tgKqOacN7uAcsGDjo8Z2sOYwV+0K9PKeyrUusQR91TXmZzxDznoz//Nt2dlMmhlzSpjlsyyGXkwjk3g+IM7AT67+HNNBbYDTG3bssq8bDEKrc5mAxCoDBqVqSCGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RKgLQclAVsUBYn/dfMTlozKnI2KFRYxanBgxUhHrNw=;
 b=BL9ruxphKd4arUBPWSj4fA4iwnqt0cyzdNjbzgR23VFOC0KBob0Hu3GVBz6lMdTo3UI6mzPVMz6IfDvy8ODHcN21+Jx2Qp0Blz4Amh6bFxQkyW+8Wxam84vpC5g03R1p/TLq0qyYHVvTIi/Ss645CkLC6+lFA12gQsXhtxqZ1CorphHE6nxrrnrx5v0Wm9ChS4hOYy//EfVPDP1p3q+83eC+8rZltUJ3PDJe3WZq3mDzNoo4GnwfKL3XQbvD1DdK4vFL7rywmWjPRX8tiz06fo6O1ISox/qgj44RCTWls+smr+YYlYk05wpMklgQScelCrAMg1mgI9aSDMVOi7LChA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 00:39:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 00:39:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/1] spl: mmc: avoid including errno.h twice
Date: Fri,  7 Nov 2025 09:52:14 +0800
Message-ID: <176247978656.799411.12773880220720492011.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105001351.92457-1-heinrich.schuchardt@canonical.com>
References: <20251105001351.92457-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 138f664e-e95e-4254-8129-08de1d96278b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVVQZlZpSDNkdGtxRjVLZHpKNTZvK2xxN0UwTUtYeEtOKytmT0w2cTQ5d2Vh?=
 =?utf-8?B?UXRSUmpzamFDL3YxUWd4cGpjdGJjNGVxVlJvcVdlaXV3RTVCN3FCRXRISjJy?=
 =?utf-8?B?Yy9xN2lva3dEc2pRcDBkMzNlZEJoMW1sZXdublNMSlBXM1FZcUZZbmxiLzF5?=
 =?utf-8?B?ZEU3bnFraFM5bnNZT2h5Q01Yc2cxM0JLakJjdFpyWjVlVm1Ja0RlUjBCQzQ3?=
 =?utf-8?B?Y0x5TUpTQSt6M3BRZStpbXIvVU1hUjZtN3FmN3VNU2VkVWVKMk1UaSswdVVa?=
 =?utf-8?B?cm5hY1lTU0dtWURKbWRzbTBvWHhjcTJDNEowc3oxMlJGOFBFZkE4ZE1GZ1Qx?=
 =?utf-8?B?R3UzbGc1Y0FLZ2E5dnJjV1RpcEVwRWZpdS9uaGcyWVdjd3VEK0EwSUNLL3RE?=
 =?utf-8?B?eFQ4di9JSlNEeDhEWWhXYUpLM0QwclNJR2RDU2NCS1Rid1lJWXgwVFdMR21m?=
 =?utf-8?B?SEZWUDVHVXdwK2d3cWR3ZmhMTitvQi9JQzhTSjFVVEVnSHRXdXJ1U0QybjdV?=
 =?utf-8?B?cW1udUtTUXM4N2NvTXBVZE85dG0wcWRCVWhTUUsrZ3AzRWRPMXYxNkFYNXFB?=
 =?utf-8?B?Qy9hTUgrdXZFcm9VVU56RUZkOWFTbEN4bmJ0UndBczN4dmc0WUlVc1hYdmxQ?=
 =?utf-8?B?bkwwODFmWlNpMlluQUlsQ1VuZTdCV3ozcm84KzlKM3VSblVxd2JtUTNQWWxp?=
 =?utf-8?B?aXNTbUplWkhXNDZ5N0pHR0lPaUo3N0YrOUV6dmR0MXZMVHdKVFNXRHMraVZ2?=
 =?utf-8?B?VCttcVFlUWxGQUpnTGQvRG92RzBYRXdJaWVVYkswaGNsaHZ1RFhlMFkyQXR0?=
 =?utf-8?B?UUIxMjNDMnhGRU40aG43Rkl6R1Y2U0ZVcFVLVnhMYjAra0pCU3FVVmphUnBz?=
 =?utf-8?B?eko1c3FFSW5GcWpRYmI3NU5tZkNPdHE5alh5OExoYTZjZFR0eWVqVk5xSWVv?=
 =?utf-8?B?djRIbEVqVndVWTIwbVI3UjdQK0V5NFFCVHRHTlFpTmlSOXNtWFYxcjM0N0Nr?=
 =?utf-8?B?bkRidTVyQWloSzNpK085RkZxOUsraXJ3WW5zQ05HMzFIM1pyUnVFbDJyc3k1?=
 =?utf-8?B?Tlc3R2tVMmpkNVNjWVBLaVZ5T25lZ0hpelRxaENPT0ZISmpIVXNnV2pDdHhu?=
 =?utf-8?B?RkJwTXdRbXB0K0pTMFB2R0tiWFBJV2JsSEFiK0ZhNDk3S282a25iZWdYL21L?=
 =?utf-8?B?NzJOd2s2cjdxS29mNE8xUFdmNCt6QmZoazVPNi9YZ24xUU1UM0JsMUxyMFhE?=
 =?utf-8?B?ZldaODZEUGlIaVhDSDBwL0QrWXZqYS9TOGpROGRUTUxxMGpmS2Q5OE1FNFZ3?=
 =?utf-8?B?NjkwWGZDaWlKU21lMjdZd2hPM25ta09uYndMcmhYajhHbVVaQ0thQmI3T2NJ?=
 =?utf-8?B?cUF2VHRRVFhSTU92TjE2dVJpLytLZVRLNkVORm1UTzZ1TmJ5ckF2Q2wzTGJh?=
 =?utf-8?B?NEovR0k2aFV2a2tNdFlHUFVDSDFyWkZVUE5sNDBrYlFKYzFrNmtoYnFRbFY3?=
 =?utf-8?B?ZzBLWUZTTkc2Q3VhdU42NXljNk9KK3dSTE9rMXV1RHVpQVYzYmhqSVZRVGdi?=
 =?utf-8?B?TWJNMnNvOGRtWUFZVkx4VU5jbGErNlJEbktzQVBNTGhCZWxWK01ZbnFPTndz?=
 =?utf-8?B?NVJrZzVZTkhIa0kycUV2UVJoaElnL20wVTJvQ1NBSUtXcFhEQ1Fiak80MUVD?=
 =?utf-8?B?U1ZuSlZvaE16VFVrQmh2Yk1GRTRrZFB2c3BVbmxkNGpxYXpDOVhUTFFmK2to?=
 =?utf-8?B?b2x2UGxRWWJ5akxvT1dVSHorNC9aajBZVjJ3RUZXN3hiUjlaTEpuTTk1K2RX?=
 =?utf-8?B?K25wNFZkaGNxK0xtVlVIVGFnWDlDODlhSDhXQ1lrOGVQZGl5VDloYXNkYnYr?=
 =?utf-8?B?bG9sZFZIM3dyYTVYWmtOU2RkZEdlVDBLQWFMRmNhc01WRU9GamU5ZWt5c2lt?=
 =?utf-8?B?Vjl4cDNSNDFNTXQ1cUVlVnllM2ZaZEpZNHdWZ05vekFWUm9VdGpVV0RScFJw?=
 =?utf-8?B?NUpGZWJxdXg4SlpRR2VCMjhDekc3TTI0NEx5RE40ak1SN2VsTEh1dzIyMmFa?=
 =?utf-8?Q?Di0iVH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBEMFU1MDB4aVBIcTNDRjc4UzJBZ3lXLy9TWXRGNkcyV0tWVi8zbmQ3QUlF?=
 =?utf-8?B?MzRXbnNBSnNvdjVMQVVqQk5xTGdKQjRoVjAwWDVPWlpVUjRmdWxMQVEvQVFw?=
 =?utf-8?B?dHFROFdEYjN3SEtlMGd5bU9DWGFITXZYZzBjRTJydGNJVDVWVWhsRExxR3lj?=
 =?utf-8?B?Z0QyMk5XdWpmVlUraGozdEZPYktrb3luckNTMnpMWUxGa2s1QUphY0VCamVu?=
 =?utf-8?B?ZlM1Yi9wQnd5VTZVUlR0bGlaZGxldG9MdVNCa1ZtWlVqYkVFdDBSVzB2QzZF?=
 =?utf-8?B?UklCZndrTmtZSzZoZ0g0cUdzRytkdkxINVhKb1RIbWxEcFN3SWE4dE1ZMlIy?=
 =?utf-8?B?RUxWOVFNMExHRE1wOXNLMkFUekpMeGFlS3MxRngra1Y3ZWFQL3hza1hVMjc2?=
 =?utf-8?B?NWVGQVQ3OURmQzM0NnFKMUQ0enhNWWtkdEpQSnAyS043bUcxUHQxcGxLVzcz?=
 =?utf-8?B?Zmg1UFY2NHUxNGNEdEpPOUVGNlE5azR6RXlJRklvQ2FlenZLY1pJRDBOejZW?=
 =?utf-8?B?eFZrQUd4dklBYk1pUWU1VFprWmsveUJvNFVqMjRiQzdiVVZJQnB6a1phQlp5?=
 =?utf-8?B?djgvK2NERVJXTU1kUkhlcE9lNUxralZQS2xDVkZ2enZoUnNoZWpvMnFzSVZl?=
 =?utf-8?B?bExYR1ZTVGhXaEJZalJoNUEyWGFMcmtCV0VNeTNVcFVRQUw1MFRBVkFsRGRl?=
 =?utf-8?B?UVRnL01lakk1RktDZ1ovcC91R21IMmp1OXJnVVZVQmVpNXJDSndZZ3FwcmZF?=
 =?utf-8?B?ZTFLY20rMk4wZkpmbzBnYkZ5Ynl6TXpyNkJtTWoxMDkyWDhjSmU3NlFLbHl0?=
 =?utf-8?B?TDBtT1BjTHpwTFltcmM0L08vcmR6TkZjM3JnN0tWdjJJN25aWncwdXV1SGcx?=
 =?utf-8?B?SmE4UmlFWmtJVUd2M2NBcitmSUtwZE53eHhqV2dtSmdDbnlHQXZBT2hINCtm?=
 =?utf-8?B?NlltMlBLQ0NXQ3NZekFDYjRVSFV1aHB3aG1Fbnpldm11R3pESjlFS283eGhS?=
 =?utf-8?B?ZEFiTzBLQStxd29YZWdLbEdubGVLSHNtV0VsNG1aUEdZNnNIdjB3bzFua3ly?=
 =?utf-8?B?T3hUUTNySmFQR0ViYW9PVjVVUDBBQVliNnBRSE8xby9td1k4WEdGWlJ5QVR4?=
 =?utf-8?B?ZVFwRDJnMHlsWEpGckk0Zzh2SllUN1FRcStYdkdWbCtRM0NZeUFMRDFHT2o1?=
 =?utf-8?B?eHZmS1pGclpIb3R2VDdaL1VqVVlnN0JZdlc5dWh6czliM0U3OWdPT0dERWs3?=
 =?utf-8?B?em0xZWFMZzNCVDdUeGxmeFU3Q244M1IrT05LYzFtMnVLMkdWSnYwS3hQcjZx?=
 =?utf-8?B?ZXh4eFZIU2l1UnJpR3VMdTJFR0dUdDduNG1iK2ZkUUhlUzRCQnoyYitXdUhk?=
 =?utf-8?B?dTNVaFVIaHNZbTMwblVMSFU0azE1OFFZbW95MlNPZEx3RzlOQWErNTQrK2FV?=
 =?utf-8?B?ejdKeDl0SUVyUGRZMnpUQ08wUXJ0WituaGpub0orQW83T2FJc1FCVURoc0c1?=
 =?utf-8?B?K0ZBakxIS25WZlRtWjZ0QjBDaHVhREgwQVUraWhpMldsc1V2alFTVEpITnhG?=
 =?utf-8?B?MzdpOFRxNWFqTGl1YnNaMXVmVitnM1RTaFdNWk1YVjNEQ096bW9GbnU3UG5u?=
 =?utf-8?B?NXVvNWpXOEVIaGhHY291bG1Mb3JzbERsOE5tSWlOWjMrdUdBVHVhTytDZ0tS?=
 =?utf-8?B?aWcvemh2bXNMbnhHcFF2K01mV3JoWnU0YkFEU3p4ZGh2d0VBdHc4S1BJQ25m?=
 =?utf-8?B?dlVCK1ZwU0V6SHhnUWZJQ0VJZDJjVUNKNXgyRGlweXJEcXNvdWR6QS9JSmN3?=
 =?utf-8?B?QlFOQWVrbVV0SXluYUdlZnlCWnZEZjFKVzBuc2cvUW5kZnFZM2xyeG1IRmhr?=
 =?utf-8?B?dmEyVnloTUY2cVRJSzNtUnVsNnMzc3YrYVVkZHZmTEZtNHVsby9ISW5Obllu?=
 =?utf-8?B?dTdkaXBudDBmaXQwREdTVXZ4YmgrOFV2aGxxc2kwWWhlcHNkbmpGbkxKZWFP?=
 =?utf-8?B?a3AxZzY0WWJWdGszOTdqOVNtK3dSZEJJN285T1d3NElMVW1vRWNlcUQvNmF6?=
 =?utf-8?B?SDlEbHA4d1ZDMFhjaGlBUy9ON25MR1NXaGsvei9EaUlxVWd2elhhOXlNQlV4?=
 =?utf-8?Q?WREF47XmvUlruWSqp/BCNJkc/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138f664e-e95e-4254-8129-08de1d96278b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 00:39:49.6864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TldBFuM8ZJmqGfqWVuXpxVr7Eo7o+g5gveBDbdwyTEPo+c9JsO9uxXnZgx848DQQv34na2PLJ8ok0HGNmnE1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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


On Wed, 05 Nov 2025 01:13:51 +0100, Heinrich Schuchardt wrote:
> Each include should only be included once.
> 
> 

Applied to mmc/next, thanks!

[1/1] spl: mmc: avoid including errno.h twice
      commit: 0408ae531fe8ad01b9b788181fc5b91e0a527b42

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
