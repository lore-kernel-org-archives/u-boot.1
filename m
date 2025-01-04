Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC6EE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709DC8039B;
	Sat,  4 Jan 2025 04:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bNrzmJX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC41280384; Sat,  4 Jan 2025 04:19:44 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB7B80207
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiWlBZ2yHcWeGsMIDvhjvcN02VNRBQLgDBEk5CuMvYF1wQH9xKXGXJ43kbM1q6fhlrt396u0TBZcVUsc1kmN557BX+XOELOQKAjneyB9LriHKQBKQn4ychcei/Q9UeJJ/netBYlUz1sgg3PJc+K6yEqMi4tqOoRNkU4KhkXPtLmqrpUIn2vagd6XOXYlh2jrmO4By/zy/HOWq517YEfcfdyvVew/XuuydZbZsc3kD2KtUyDORJ4mVc5Dchw6MNg4Mfr2JOCeoeF4xzj8TNm8gAx9+z/fHypmz9aDqT8AtwDnrIRviYX7vXzlE1CZzvUTgTYxJzrc4VGA4lwXBuD+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm9kRJUnjk3JIbfW7pO9qy/TAx7ktSudyXdrJuUKk5w=;
 b=iYCNZ7y90uBDvvRYeZal459BsseU6GvKSO/IWIyq7VOkm5pBVVbgDStbsjkknC48lc2JcfMOdQ2zbvQmj9UkvuEoo7TUhoFThFnjCS+vGVCjNJSBnE4Bcz9vSl9vwt4xqBEwDnhCfA3YCSPW6ZBRdoqOT15y9EkCdSSqStPRxTFAveOzPacKnNxZcuyjJSK055ywTVjk9NhUKRAHI61kJyY0XMRKeDgsvSykASAF1Lr0/Sq17GJMOL2Am8ZIjwM7eGankk9GS0BhiubPGXIZX4/HUv608oE9qSHnaV3XXrj/x3T+y8jFRBXE75ZMdw4oi4HO3MgDuNfH64SYM8FFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm9kRJUnjk3JIbfW7pO9qy/TAx7ktSudyXdrJuUKk5w=;
 b=bNrzmJX1aN5eBR1jK0SZVidsJKXLeLD/7oMK66xNYs59kvAjfJnHzBvFieqgGDgyYCbRzfiS8He4M4eyCfbCoPCkN38E5+t1JfMj5yECqWhpJaP+rCKyX7iOu7UdTt0W/AflcagKP45eKlXArVLRfWWnX68O312+qh0IEYeuKbIxs7HDTRqRjYuAPqqx8aZNW9SGgSOxXztfOJmk2A7Rcql475Rh04A5LZDjzFKGu8lgUF4f6CnGDnrVIm7aTY1BZVARvsQYEwgV6+Z5BTWbG2FxtLGH14jvFaRhgigXC8/q2jteCyR0ckuo+8VZ7xd/kGhLbXe5QN+sKMl8+l8z5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Sat, 4 Jan
 2025 03:19:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Date: Sat, 04 Jan 2025 12:25:34 +0800
Message-Id: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD64eGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI2ND3czcCt2k/PyS4pIU3cSkpDSjVMtUgxRzUyWgjoKi1LTMCrBp0bG
 1tQCHbfkGXQAAAA==
X-Change-ID: 20241231-imx-bootstd-abbf2e9e0d75
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 71673ac8-fb44-42a1-b871-08dd2c6e9d49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGgvVVZpdm5GYmw0VkFoMGFFQmptcit6OXhrbUduR0tFQUd2eHJkTlk5c1A0?=
 =?utf-8?B?NlF6eENIa05FNjhEZmgxMnhncUhVNG83a25HWGdLdUFqZzEyM3cxaE92OFJC?=
 =?utf-8?B?cjRpc2xwS09ucWxKVFBKTExVdEVlcTRCcE0rNUp1dGgzNXVlTjBaakREeW90?=
 =?utf-8?B?Q1I2N1pJQk5lMzdVNzFRSUxoNURVcW4rWExKaFFvTHliYURDVm1zM3hISXB2?=
 =?utf-8?B?SFNlTlJtTkFDK1dSamhhRXFzMG93YVg2SGpicDJCWFA5TVRUSzhkMWswcmlS?=
 =?utf-8?B?c3p2ajdRQmlCZU9QWnlLaWExMzViVzBiZElQSTUxQWVIZHBIaEM3NzQ5OWhX?=
 =?utf-8?B?eFNjb2pSOFJocUxyMWkzU1dZVlBkWS9RZEw5cWN4dEg4RXBmUDl3T3VpL0Ro?=
 =?utf-8?B?Y05qOHczOUx3bHBxVHYySmVwbHorNnp3T0VSVFY4M2VHZE9PNmZ1SmtvcFhm?=
 =?utf-8?B?bmphem1GeUZGS005a1ZPS2lVSVpBTk02K1lmTloyVGd2c00xajFjcndNZE1Z?=
 =?utf-8?B?UmxpNVR0U1RETTdoc3hramhLbEhGOU5jbGtzRVl4bk4wa0V1UTczbUp3Nnhm?=
 =?utf-8?B?Sk9uUGlkSGNpenJwa1hIdU5waGJISzJvelJuZmlhdkR5K0R3bUNnemUzUXpJ?=
 =?utf-8?B?Q2I2SWMwZHRONThlcEh4MEw4VlFYS3RqS0tFR1htampNVERuelkxNmZUeDhW?=
 =?utf-8?B?RlpTZDVyQ1RXQjZzbkdQN3BudHYyNTltRjhrTUErbHlyZmhHblRrUm9SSEto?=
 =?utf-8?B?S2NyTlZZS2x3TzZONTZJTzBvMSs2aUl6MmcyaU90dGxWYVRteEU5aVVjWW91?=
 =?utf-8?B?M3grMU0xSFd3WEVCKzl6SnFGbWNUdXJQa3lVTFRWb1pTcHBNZThsYzFWSHBR?=
 =?utf-8?B?U3Z5eUpqOEdIczlTaVJxSVVmaWJKRGVYUWNDbDNPOXFIUzYyQnp6eDY4alRz?=
 =?utf-8?B?Sm02aU9BdXM5bDlCSVJmMkhtd2JkdnF3dFFVbUtyOHBUQUx1bXdEaVUzZ0Rm?=
 =?utf-8?B?dEhJdjRjaHZsMThnbkpuanZiSkkwR21SUEEwREtnYWRvd09wTmdFU1V4bkNw?=
 =?utf-8?B?K2lveDM5c0xEaGJQN3dubUFRd1hMdjZ0OFM4QnUwWFMweEp1Y3Zra1R2b3py?=
 =?utf-8?B?OHFkYmgvcjZlaGx2czFxR2U2ZmNrYlV3bXdhVTJNMkJudjNxQktYaWNkTU0w?=
 =?utf-8?B?ZHFiVGVld2Y4OFM4aE9PQXlaMzhqTDVndWlUQ1FQMndnM01IZnJHWTY2RHFq?=
 =?utf-8?B?eHA1ZDZGRzhvVWlCODVQby9SeEZTTHd0ZEtoeFF1Sjc5aEJxTGNrS1IvVkdE?=
 =?utf-8?B?VE1mSmZ0WCtES1V1N3ZhVzdJS1JzNkY2MTRhQUlxdXJIZ0p2WkFSNzBadGVQ?=
 =?utf-8?B?ejRnbDBaRFJhZGNqbGVaMUxUcklTZzd5alpHQjdYTENHV2syc1U4cC9kdm4x?=
 =?utf-8?B?UVJ1YTUvd0pvd0NrSXRod2loMmE0UkdlSFErSEFWckRaaEd4dDdPVWJZT0tn?=
 =?utf-8?B?enlJWXpTcEdBK2lzV2UvTTdsVHFCcS9reElRT1ZFNDRBM3Y0TDlqdE1FbWM5?=
 =?utf-8?B?cWFCK0FYZzBmUEl2WWJpdHhFc2NmWU9oWTk5aVNyMG5oODZEWkxSVUtiSUha?=
 =?utf-8?B?SnVVbnpGTEpuM0Y5OW1mMFhveWVIZENqYlBBSGJKRDUrMStYUXFZT3JYVXo2?=
 =?utf-8?B?KzhhcEpnUHFCMnhCSTFaUFZ1ZUUyM051eDlxWDZtTnY5RFJBWDJ6OTNST3Vh?=
 =?utf-8?B?UUErdlFTUzhnekZHSUdxOTEvNUkyalNPOFpmTURWVTY0Q3MvbVk2NkJRZ1VE?=
 =?utf-8?B?M2lRWXhNK3VGY25MWXpvQXJQaSt5MGwrZWdBY1p1UFREZktYZHExdDNkNko5?=
 =?utf-8?B?dnRRSWxUUUtoSHpQR3FqcG5Ka2h5NlYxWDZvR0twenh1cXhzQVNBODByWnFo?=
 =?utf-8?Q?UZiOcsOxB5I3ddQayWbbNijKreeKify0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdHc0UxSFZIR2dkQnNDNFBRSVBlalZWZWV5OFpTUWhtMW8wa3BzYityUWJh?=
 =?utf-8?B?WCs0V1V1UFZ3Y0tkdGdHRXJkUzN5K1pNYVp1SWlMWHJaWWRBNk05dDBkbXhJ?=
 =?utf-8?B?dHlZSW8rSkVReGRYYmlzSnJCeDNTUkVuOEUrTVBVd2tRc2ZTQXZwajBCWjNY?=
 =?utf-8?B?cEhYWFB5NTZDTGdGdzRNQjNZT09aNnVxbFN0ZkM0SFlsRUxleW83a2xIS0VK?=
 =?utf-8?B?WXBHQ0NBM1dRT2wxZEZXNk9IeDZadUJqc3lqd1BrQ3Y0WHBvbmYwU2xtcHc1?=
 =?utf-8?B?MzF5bVh3ZzhmWDF5VFEzUFpBeGNSb1FhV3RuSzBPOGRqZW9PU0VuWDNUOVJF?=
 =?utf-8?B?RG1DSUl0QlZ0eGtab3Q5eElmbGlXK0Z0YzE4azJHK0dwK2FMRlA1TXVvOUxr?=
 =?utf-8?B?dnUvcXdRZ0xaL3hWV1ova3RzSFVEdjZVbkJPd1Vvb0xudlpuR2l3VWJCa2RL?=
 =?utf-8?B?TVBoREdhZE00TnNoQ0xBS3JnSmVwUmQ5MkliTHJXVDdGU2FuSjdoYkd1NHFS?=
 =?utf-8?B?RkJaM1c2U1dxdFZZNXJWcnlmNTV1bWpPSGhpd2t1WDdCaTRRd0Z3ejE5aUVr?=
 =?utf-8?B?ZlBtMjA3QnFPazlGMHdCSjFnNkxockFJQVdsK3NpcnFoS2F6NFhscVVQaTZj?=
 =?utf-8?B?SXBUOFl5Ui91UkxyK1Y1bUhUY2JiUjJ1eGlrWkQvd3JDd1h1RGgxR1ZYSjhr?=
 =?utf-8?B?KzUyZWkzdnVneTFnTmhUWWFaemFZenE0NHRDVC9EeFYvenhZVlY5NEdLYTRh?=
 =?utf-8?B?VmUzeUVaRmpGOWZjRWFVb3JRRUV4azhOcU02dEtkUFJReFlUQVpzR1dsTzBP?=
 =?utf-8?B?bE5mVlBlN2hHcmx5VDVNMGlkdjZFb1hENmxEREppUlJZbjJpU0hKaG9hS1Y3?=
 =?utf-8?B?UEVuTnZSYW1pS3ZLMnR6K1AyTTVyc0hrMzNzMXpwMHpmS0pBZlExb1Rsa3o1?=
 =?utf-8?B?T2hVR2crSC90QVA3aFE3bXBVZlhwVFlidFJ1cFFIZVRXQk9BbGJ2YmxISkxm?=
 =?utf-8?B?RWhkeGJ1OTM1aEhYeko3dmdMenBqSFZOaVVBeWhWUGFhKzY3bVlmUGozUXFF?=
 =?utf-8?B?UmhZZW53L01meHRWcFR3V3dtclRpQ1VoLzRNalpkK1RZbHVNQXg3NElQZkJx?=
 =?utf-8?B?SzV2WFdMWTd0cVlVQythWkEvaVRDdTFOdVZMV0tvaUZUc2JqRDVNVUtlZC9L?=
 =?utf-8?B?dm5mSVlkZFhxMUtNVlZmZS83UEV4UDQ2RHdmYVRFTFozbHRQZS9HWEovYVll?=
 =?utf-8?B?TDk2eUlnWXpxcVFyMjhrSTR6aUtTcXBtMXc1YmFxNzlFVjdsNlB2MENMVTkw?=
 =?utf-8?B?YU45SEV5Mk0vTTdYTG1wTjZuMWFwRzlxN2ZZK2h0N1JiZXBzdVd5M1RDaUEz?=
 =?utf-8?B?K1J6SmZXZXk3UkFneEhiWkhnOUlDc1RLbHo5OEw4YXBDR054SjIwUit4Nngv?=
 =?utf-8?B?cHgvMmlNZU1DWis0ckVLN2pwa2VXKzBiaU50bU93OVExRG8yM3owRFFuNnhu?=
 =?utf-8?B?b3Y0eEJzT2N3eHhlRUx2bWdRdVE4dTdGdkgyMk5TdUo4VGlPamtDaFBQY0pO?=
 =?utf-8?B?TVJ3Tk5oOG9XSUhpckdIQmZZM0FSNGI4WVk0ejdmQUZMR0VuUzl1YkU1dklP?=
 =?utf-8?B?NFFRdEZhRFFxVVpSQ1lYMUFGaDZ2cnVUZ3Nhc09WR2tGQW81Z0NjUEVvWDJM?=
 =?utf-8?B?blV2eTRieW9nemxmS3k2TlY5eDV5V0txLzBUM1NWNGF1WUFRSzlYSVlrWXpT?=
 =?utf-8?B?ZTkyTFo2K0hDWkliT2EzOTRLVzFyRXFFM3hYb29kSVh4VWdqOFFLRStkd0h6?=
 =?utf-8?B?WURMdmRxSEZXczc3dkNta2FSUXFPZW5TZ1U2cUFZbUlwOU91VThMODdCc29E?=
 =?utf-8?B?NFBNejA0WmYrUFJwcDhWdndMRS9KVTVFWm9nNDFPb0tMamNiM2x6djRkcVB5?=
 =?utf-8?B?QzNaZ0pia09RWDdGckdORlNqak81Zk43S0gxWVEzZklpMjdJcFU5OVVjb1k3?=
 =?utf-8?B?T2M1b251Qk5lY1FXUFhlMDl2K3BMNksvL1N5cTNiVlZmc2ltTUVoODAveUpZ?=
 =?utf-8?B?cmdPSEFJVHVMK1R1ckVEaTFoU2t0WVJzeDd3eEtKT0pnck0wUURiQWU5OHM2?=
 =?utf-8?Q?/nAE3P0eap+m07dGCY+k4lH3r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71673ac8-fb44-42a1-b871-08dd2c6e9d49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:35.5809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7X0XI0oHAYAEEe1Cgkpg+xlF0XPgV62vJs9fgA1f4ZYF6vbQemoTCzW6i51cJYQBmt1mZVP3WJTnoEcpNOMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018
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

Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.

Patch 12 not related to bootstd, it is just one addon patch to cleanup

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=15&view=results

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (12):
      imx: imx93_evk: switch to BOOTSTD
      imx: imx93_qsb: switch to BOOTSTD
      imx: imx91_evk: switch to BOOTSTD
      imx: imx8mp_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mp_evk: Switch to BOOTSTD
      imx: imx8mn_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mn_evk: Switch to BOOTSTD
      imx: imx8mm_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mm_evk: Switch to BOOTSTD
      imx: imx8mq_evk: Enable dynamic settings to mmcdev and mmcroot
      imx: imx8mq_evk: Switch to BOOTSTD
      imx: imx93-11x11-evk: drop duplicated nodes

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi     | 118 ---------------------------
 arch/arm/mach-imx/imx8m/Kconfig              |   8 ++
 arch/arm/mach-imx/imx9/Kconfig               |   6 ++
 board/freescale/common/Makefile              |   2 +-
 board/freescale/imx8mm_evk/imx8mm_evk.c      |   3 +
 board/freescale/imx8mm_evk/imx8mm_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c      |   9 +-
 board/freescale/imx8mn_evk/imx8mn_evk.env    |  67 +++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c      |   5 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env    |  57 +++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c      |  25 ++----
 board/freescale/imx8mq_evk/imx8mq_evk.env    |  60 ++++++++++++++
 board/freescale/imx91_evk/imx91_evk.env      |  29 ++++++-
 board/freescale/imx93_evk/imx93_evk.env      |  88 ++++++++++++++++++++
 board/freescale/imx93_qsb/imx93_qsb.env      |  29 ++++++-
 configs/imx8mm_evk_defconfig                 |   4 +-
 configs/imx8mm_evk_fspi_defconfig            |   4 +-
 configs/imx8mn_evk_defconfig                 |   3 +-
 configs/imx8mp_evk_defconfig                 |   3 +-
 configs/imx8mq_evk_defconfig                 |   4 +-
 configs/imx91_11x11_evk_defconfig            |   2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |   2 +-
 configs/imx93_11x11_evk_defconfig            |   3 +-
 configs/imx93_9x9_qsb_defconfig              |   2 +-
 configs/imx93_9x9_qsb_inline_ecc_defconfig   |   2 +-
 drivers/gpio/adp5585_gpio.c                  |   2 +-
 include/configs/imx8mm_evk.h                 |  22 -----
 include/configs/imx8mn_evk.h                 |  30 -------
 include/configs/imx8mp_evk.h                 |  21 -----
 include/configs/imx8mq_evk.h                 |  22 -----
 include/configs/imx93_evk.h                  | 105 ------------------------
 31 files changed, 448 insertions(+), 356 deletions(-)
---
base-commit: a3d3d869b6f5860660718d05ee9b4d040d938e0f
change-id: 20241231-imx-bootstd-abbf2e9e0d75

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

