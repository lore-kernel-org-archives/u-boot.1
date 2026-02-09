Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF7EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5891483D07;
	Mon,  9 Feb 2026 02:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UNOYr8+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A573283CEE; Mon,  9 Feb 2026 02:29:10 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A929983C72
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjGLU4PKD3JCzT6Jy6IBtCpOvmNHRhZkgExuC8OJgIFwHKLlI7ADCMCN6D/O5CTA6Tj5R30ZncJCB1eHqnPMq4bXaVJLZyVyl3N5Z338b7WY668DqBEh8Iazv1DaaLkMj9BqWYUmf8lBbPESV8ao2bVRuHfrDjsyG7tjzqIkYP8dpIBLISYzHdxPCRzDhxf06naw7wT5UZx0OXp2iaNd5Q3rd3a6555IbUE0q4vdumTiUajHoKVGjQeJn84JPcD9gun40DoiTByDV1rOxdtPdmnEYBaABQiKeVVu+AJbS+AE+Gm0+fJDqhYS4fviniEDh8nM8V2vGVwZS/KpX+rmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=waMcEkG9hMbyd+RXbWqYe/ZlrPn0AZ/HLiwH3HqmZts3ggvVZa3CNcZBhOxUTZi98UD1K1iS3pQclT1uNxUP9fI83tOOakp8IDYxODZ1TkShsulfceCnaEeNX02vX0OoWy3jxBLnvAg3DLqHvC7vXrWs+kVQ6UKWnWwmP8LUYZZw6hdn3A7rwXtZD0ixLHbqBNVPzy/JHyx/41VV9W2pjLgRxyITZOPrcSHYN3S61CL40HmGsQID3lEKcgAmFcZvtov4A4MemjZaNl5GNEEwDqMrYpbQhSdoCurBP+TQeL63GrwZ1wLz1JudIUqDHvQGiy/7JhVNTM/TC2PRaVOfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v0xNatn2VRaEqixmv6b6Y0wkMotCYfBmo97xeZd3uw=;
 b=UNOYr8+68KoR2Bwg7H8Q4egmKukBtWRlV+UEZdSM8lONMITu9CV6qQwQ1yUJE0IFLaxdR2eu+QtV4UMCMNbypaPsM4+cfaA+/O59qNUBfcP1Y+osDIky+n25Rm6LHz8p4oK9mRqhgl6En9lWdL6qED7i7oCaMUlQeR5ptyC37+gPZaIbjMoX/zRJjIIdt3jiuAaGzmWeZVFgGwbM1w6ZTvmCPtAMlrN/qyQOsjNqzaqioFUK9VbdLaAq83BL8CL5e92Pl70Ss7YKIHhiWtpnhWBLuTU94QsUqK30RDOdiyB3bgPTdZyVcJb+fo0QHPhFY2/pN/0ySd2fsouHrkKecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:12 +0800
Subject: [PATCH v2 08/14] tegra: pmc: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-8-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc259e9-29d0-4376-5c77-08de677a9df9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHh6aCtNc01UZW5vbzBUYjQzTi9XMFBsejVmSTU5WUJOR2pzY21zMVpWY2hK?=
 =?utf-8?B?VU9iZDNLWmpxa2dtRFhMRkppQThxdHNVSWhtNVRGUnZhZ0dEdTQ3YUxRa0Jj?=
 =?utf-8?B?RWsrN1JJeDQ5RVpybHhoeUhYQmIzdWpVVkVFUUFKeWdpUGtxdkFtZFhrVU1s?=
 =?utf-8?B?ODIzeXJGWGZwUTQ4bEc2d3VNVTErN0RpL1BkUjU1MjRrajRmeW9pSmpVYlNn?=
 =?utf-8?B?THhZU0JCNlc4Q1ZURk0rVTdsTklPVVNlVkN4ODJoVVhYck01aUJ2b2U5STEr?=
 =?utf-8?B?YmdGWW1zOTRCVnBFWEJTakhMT0xNbXR3dTBMN0I2ODZwUWU0UVgwZ3FtUWxz?=
 =?utf-8?B?NEw2UGppUjhvSjh1cU1rSitZTDBXait2b0k4K25HM2VIVVdEL094OVJkclZk?=
 =?utf-8?B?Ym9ZVHVGMEFWdmFaQ0xyejdOQy8rY1o4YzRMdGNxblpDTnIzTjlKR1JKbEIx?=
 =?utf-8?B?M3J6M3BVRFZFaklWZENsUTRwWllPZFJTZU1IeHA2Nk8rMFdzLzhXaHY3UzZl?=
 =?utf-8?B?NmFsZnE3VmpXVW9mODlmbXBlU0lyenVaemVmSy9keGdua1dpQWRIZHU4Tmh6?=
 =?utf-8?B?Y1h4bGVOZFdmcTYyc2o3R3BBbDNvWG1rL1RrQ2JjZW53VHZNM3dDRWJlWWdV?=
 =?utf-8?B?Z0Qrd0F3Q096aUx0OWZ1VDc3WVIzcGZxanRmbzY4V0QrMjFOUmNGWlIraHlL?=
 =?utf-8?B?a3lqMnJqdXFyOU53VUN4UzlZdkxMMWJyNVlVcUNtTWw4Ky9CQjNRbXF6NzBx?=
 =?utf-8?B?VFpWandKSlNqSi9sQzFyTG1WZmVEdTlDMHA2c0VmWWhwOEpsWGpzbGJNcFdo?=
 =?utf-8?B?U0FXbnZ3K3FmUjRTa1pOenpaTWE2aWFjcGJ4aE1XdGRNNytWN1VITGtVRkxF?=
 =?utf-8?B?ZGV5VlZDRm5KYnlKa3lWdml0cUhVZVBLY09KMXlpemhkb1BsamluQnhUY1FX?=
 =?utf-8?B?b3J6ZXljWWlaN25Gc2RVU25VTVlxS1FBMWROVTJOa0puUUpOSFRzdEF0NVpQ?=
 =?utf-8?B?NlJWRmRCTmIxOVhOd1FpT1RzaG1IRndweFVGQkhPWnBaZVF1NmhXVnl3WHox?=
 =?utf-8?B?TDA3ZzlqT2Y5ays5NkhYWGZkbFhST1l6cEdWQ1lZblk0UXo0Mm9VQ1BoUVdk?=
 =?utf-8?B?V1dYcS8yK1RDRm9SRDNRcUZndm5zMjdzdkFubmdWV3M0VnJMZmNlUldMK2Uy?=
 =?utf-8?B?dHh5SXd0NHZzUkJwSGF1bUFESkd6Wmg4Z3FuTkZvRnVVMWhuMTYrakxEOUZK?=
 =?utf-8?B?R0V4NCtBTTIvenpCYWUzZ1orcHF2cStlOExHQVJpRWUwM1A0YnNST3RBM1Rt?=
 =?utf-8?B?RVU0NzNSMjQvVUp6NDhhc1FQeklISWdSRnI1ZUtJU0M3ZzBmWmVxNDRrMjI4?=
 =?utf-8?B?RDZHbXhtYUlXZkYyZnlIajhqSk9pdjczZmxuSGVCNmcwcXJwdkRCckRVKzc4?=
 =?utf-8?B?L0l2ejU3aEJKOHBUTFBRanZhTUtwdWM1RmVnNU10UEdXUmJOK0kyTXBiUjFP?=
 =?utf-8?B?MzVUZkRqUktxb1ZPcUI3cFZTcjJMM2E2Y0JXdHdOU09tT2VKZzRiTS93MHZ3?=
 =?utf-8?B?RkhrUTJaLzRrS3Q1UWVRMFlnQld3WjlUNjlwVFBCU0NYcFdYQzJUS01NOEx5?=
 =?utf-8?B?OGRQNUZHb3VuRWJOOXF6bTJ6Vnh2R1lGaU5jSG96WXV6b1pqZWRYQ1YxRWFx?=
 =?utf-8?B?eHB5T2NKY3hRKzVmaG5mc2ZIUzN3TkZ4c3R3d1RvYUJMZFJNVCtnWjhmTzda?=
 =?utf-8?B?OEh4ZmlSdnNZY2hxQjlqa2pUUWdRaHhtUDQzK3lSVXN5ZUx6aFBVOHZzRDJm?=
 =?utf-8?B?Z3RIRk5kZ1U3M3NQakNKSkdyNExjdFI4U3lHUW9zUnBFOE5tWFlFaUdZbUEx?=
 =?utf-8?B?aS9SQ2FaTWtJTzd5Zml0UDFjb0tQOS9iNGllakdVdHZrUzIrcGJhaHVmZGEy?=
 =?utf-8?B?Tm9MakhRUjkzdVJhSUlabW9NaXRkYzBEUGZvSzB1NVFvTWRONkxSMUhQc25H?=
 =?utf-8?B?ZEpVUzVjeW14WkVsZlhVZDAyWDZCZDQzMkl2SVhmdW5RVmptUlc3SjJqSGF3?=
 =?utf-8?B?N0o4eklkNGcybWgrQVloZEtkaU96VW8xd1hLWGVDWG1qVzBENE01VkRkWW94?=
 =?utf-8?B?aTVNZlFJczhHZmhkWWY1RU4rRkFOTDBqeUxaazZxbno0SXBoZHBKTjViRzRZ?=
 =?utf-8?Q?PazPP8pC9CrmEFiw9gQkxjo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JNWE1FU09VSS9Sd0llT0VnUHdnV2RwQlV1bDZxQ2xsSEFLVGFLaGk1ZkhP?=
 =?utf-8?B?VWovTnJTK0Q0dEZOYXExWGNSbHV4SkRuTU4xdEkzaDN3Q2xINXBKbGt3TlBX?=
 =?utf-8?B?SitaU1ozam5pcElFVnlGNlNQWWFXYjBQK2c3RXcyK2lmNHZFS2wxTytibHUv?=
 =?utf-8?B?QkxRNjRzRlMzMkRhcEMxTEJQMmRIR3grR3FMK3RFcHhPaG1ZNWFaMElXMlAv?=
 =?utf-8?B?LzcwR2ZLTmROV3J4UXV3d1NWbjJ3N3pmamxHOWNodkFGeWhsdXV6NFBTeTZF?=
 =?utf-8?B?UFFiNnVDbnJmL05kYXdSZlpPQmR1aUMrbkNUNHpvWXNXV0NzV3JEWDlDaUJI?=
 =?utf-8?B?eDNkM3pkUmE3VUtzQ3B3aTNYeDhVcFZ4djZ4MVk0L20xcTF1RWhRNkw2aWM0?=
 =?utf-8?B?OG5UVSsvVExHN2w2UmRlSmNWczR0MW9iTXVsaWFVOUUra2E4aWowMHlyNk1C?=
 =?utf-8?B?SWtlN29ZVVpCTTFiUmdWak5OYXZ4czg0aXg1R2U4L2RyZ1NYbnl0KzBxc2dB?=
 =?utf-8?B?SXhjczEvcG1VK1ozcHh4QmJxeXdYb0JjQlhVSFQ5bWg2RjBrZlI4b3E3VFVV?=
 =?utf-8?B?VGRXTEhqMnk1ODlVUW1DdG85TXgxQkpQckY4aXFEbTUwMHA0WmUwN1ZSekhL?=
 =?utf-8?B?cGFmQ2ZIaWN2REhQanlGNGhiSldWSkltYW9PNlJpWm9FNWRmRzZ6elNuMWdp?=
 =?utf-8?B?UHN4QkpzQ3B2bkVnYzNWUzNPOEtRcW5LRHlJY09naTNGSjdzR2lRdzFXdEw4?=
 =?utf-8?B?MmpEYjRhdnFEQ2Ura2J4NDA4Y0dWaFQ0NDVSdWNESzM2YzQ1b3crTy9xRGVs?=
 =?utf-8?B?Yy92RkJvRzhXaE5UVVhLSENBc2hBNGhNOXlPZEdaK0VkWXdQRHRXdDhuaGkw?=
 =?utf-8?B?a1p6YkdRdEJENTdBakE3Y1ZNWHNES3ovS201TkJ4K09HZDNBZExXMTJLS3FI?=
 =?utf-8?B?UFg2VDVuczlPL3p0S2h2aXkxUS9zcXROV0Y4Yi9CT3QzbHlCRFhJa3R4VlVv?=
 =?utf-8?B?emViaVdHT0UvZitWekhJS2JpN0VHd2k4NWp6dXRQeDE2SU5peS81NVBHUFJR?=
 =?utf-8?B?VzJmazlkUmIzMGpQaEg2VGJWM2dWbjIwbzhaN0ZQSjUwMDRWc2gvOTRudUh6?=
 =?utf-8?B?VDUyWEIxWWUrcEw1QnpERHhZTmRIYTE0VzVsN0NJNFlRVjN2bEEvTlBPWlBK?=
 =?utf-8?B?RFAxdGFVR1VqUTFzbmo3NzFQL1VHaEJjdEZya29yUHJNckpVME9ETENNa2dq?=
 =?utf-8?B?bVRneCtEVHA1MUIxZFVOU3ZScHRyZWlUT0ZJeDNZbnFabTJhTUxNUEc5Rkxx?=
 =?utf-8?B?MmxuMEJqL0VYMS9ZenJPNDJUS1E5WmVTYzQ2bGxzb3VOc0daRnlVKzltdWtm?=
 =?utf-8?B?S2UvSUxra2hveExlTDg5NGpabHp6c2c2TDQyeXg5aTU2TmxSZFJtdndINDlh?=
 =?utf-8?B?MjRvZnlJcW1qU01pOTlIS3BkeXc2QTNlMEJuYUY2bmluVVVHMmc4Mm82QUVO?=
 =?utf-8?B?U2Fvd3pHS2I4STRhQ3JFRHh2QjZ5cXQ0MVVMODhIYlZnRFQxQlNYTzN6bTl1?=
 =?utf-8?B?NjYwdWZmWm1mTWIzM3J3Yzd5TmVMc3hpS1hqZW9Da3RVeG5PQlF4N2RxQWJC?=
 =?utf-8?B?WllEazhkUjZYaEpDQS96em90aWF3cHhhZVpKYkVZeElJbWI3TlFVUWtUTVRj?=
 =?utf-8?B?SnVzNnZQSlZWeGRSdkl0N0FTWGNQMU9tMFBsa0ZSN2Uvbjk5SVlXdS9VM21B?=
 =?utf-8?B?YjIwNFZ3ZUVFd3RxN04yUlhvOWM2azZVdlQxVEdHVENXbVp3ZXc1VWEwTmIx?=
 =?utf-8?B?c0Qyd01rdGN4QmFUV0ZIWE9WdDFjR3RySno0dHZ3VEdLb2FPVmE1VXJYOXpq?=
 =?utf-8?B?dE56bVZ6b0dqRlBjL2dvMFRYOTlSMmFzVW4waEhSU1lDWnRjclkwZkpDOU9T?=
 =?utf-8?B?MmJ3UW42a2VycmdFbHlFc3JVL3liSTBRL1dJNjJLangvemJBa1RpQUc3R2Fv?=
 =?utf-8?B?ZkFCbUhNaE1pSXhiNmxneVJnUFlPaVBYSTVNYzZwVWVETFZJV0NXclByWVJn?=
 =?utf-8?B?eTFSQlBkY0NPNDlxbE1YbHlxTkd2ZUt5dHFQV1BESVZLbVlFemQyU3VIbUZl?=
 =?utf-8?B?VEkxS0NPdW5TMXNpWTZiVUhtVWV1TE1iVXF3QU96Vi9PNXBpenJVYW1sU2t1?=
 =?utf-8?B?clM0V2ZmZ01salNYOG5ydXRIa3UvMHJzRkQwd0VoTWZXdW42V2ZLMkF5b1dv?=
 =?utf-8?B?MXE0Z0l5dytYTk5vS3hvSTJZWVdoWG55bE9keTZqUDZiKzNwWGVvZ21LR0dQ?=
 =?utf-8?B?YUJlZzBRb2llamJqZTVhWG9NRCtKS0pnTXhFMjhrRVNtTFJQaEZHUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc259e9-29d0-4376-5c77-08de677a9df9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:06.8371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpOfzp4WK/6KWvDYzrWwIzfSs+dV0rfx2jO+q8MEiAinWf1iZqdJnXaUs+N72IpKh/idX4eb8jdUs7pAhnj53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

No gd users, so remove DECLARE_GLOBAL_DATA_PTR and the including of
"asm/global_data.h". And include "asm/arch-tegra/tegra.h" to avoid
build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-tegra/pmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 3f968d4aeae862053dc4e7f26335ebbe1bbb9aa5..019c4b0b21f3b6712d2f577181fd6815ad826e09 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -5,14 +5,12 @@
 
 #include <cpu_func.h>
 #include <log.h>
-#include <asm/global_data.h>
 
 #include <linux/arm-smccc.h>
 
 #include <asm/io.h>
 #include <asm/arch-tegra/pmc.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <asm/arch-tegra/tegra.h>
 
 #if IS_ENABLED(CONFIG_TEGRA_PMC_SECURE)
 static bool tegra_pmc_detect_tz_only(void)

-- 
2.37.1

