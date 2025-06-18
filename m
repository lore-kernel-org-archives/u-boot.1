Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706C4C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E9982C8D;
	Wed, 18 Jun 2025 09:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nv6Irkrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EBB82BF6; Wed, 18 Jun 2025 09:30:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD14B82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwgZUiqAzLG3IZvR8C3w3pV5nJLo7gp2TPRVtHX88c4uFVhHGpO3v+zDpP1dPWpVkM/5NaoOrWTRQ4UpDRZdWYIoHSUPZRyIM28RU5Fm9JIJP1NjWAZ34YbbKZaDyl/PqNo9tu66jFAK3XnkebTw7vJfUJLIa464/pGygwSqF4lR/QxBeTF3LqtBuH/OIAagzbmGtoNNmej8dX0O2Cen39zjVJg+8TiccK5SuLy5Wx/2r4/aqlTCJLo99ID3+VxAwGg01g+hOE6oHaF2fq8wYIAeL07Mt5OkYWeAXjtQNRJdrt+xGnYfp6fgfBoF17VqjOTbzxuFf+DXgynIe1CtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0REzeETTCG5PBx94gtBEdf374CGl5pvWDDNf28kVaI=;
 b=FcfY3uZDdGS6eN2aEiuONpWugOJMdTsY5UPFrQS5GyLscf43W9IvGBS8gK3JbUccQDj6e/FCnQYRkx1v9Hs0QQxymqa614y2p1H4YI4CmncyWjFy56wuzwO+uvDv9M0xn/g4RIq+C70heTvGirMAZVhSScJUAuvljz4tESLEF5t9PXGWLjovDG/DhDxzwDAFxYgdpfS8EzzVo5+sL6cq9bdJfV3Sx07FzyvctLjlJJNLSW7kfR/ItZMLBeSuDhuTF8dpvZcdv3IxMPXOcjriaKeReIMxOCKD/UwD3kHAxcu0ZRav+AcIbK3HdKcCymKee/r65nHnq8u3cHPNeUp8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0REzeETTCG5PBx94gtBEdf374CGl5pvWDDNf28kVaI=;
 b=nv6IrkrkFcD92Ohrhka8Wk8GnCW3yDGRUDNWsavTsJrA8aZ6rBy2o7RaNNeqk8+8hcFKmkdukE0tkLgrP77EZaYPNsqMMcTYOsfJObPhYkGmXMOJ6zbncKH11hV6r2GeNZN6dvWf8YSppuLwEEClep2VPFgJ8taDxV//UqfpxcI/WBVXPspO1xqwafe77TTpoV4vWXnF1qCrj0DmE2Qn93htmF+GbsC3M1RiqLT1lQZloEEsRVVCQxoE/58JPHXS2234hflC4iCVGdfNm5jJURdUTX77COOAkD6PsGQ6XMo64fVSafk8xazm7MdhaEJEjJYViDzwRSUpvhNhFCVY8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:20 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH 0/8] (no cover subject)
Date: Wed, 18 Jun 2025 15:30:13 +0800
Message-Id: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVrUmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ML3aTMvNzEPN1ES3MTc8PUVMtUYzMloOKCotS0zAqwQdFKZYZKsbW
 1AJd9nCBcAAAA
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb26747-5826-4192-4543-08ddae39faae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2VzaGpZUExvMVpHcWpES3p3NGRBVWRjei9URDF6Sk5ZVTVrSjRYSmRaRzdr?=
 =?utf-8?B?MWpEd0VjWFI1aVk5QmZGMnBBWDRqUE5aaXR4dDVzZ2RzcU5BZGkvN1NLcTVh?=
 =?utf-8?B?N2JDSDV1bGxuNHBLcW9Gcm9CQ1I4UFFRb0JtbmRTK3dseElQWTZIeUJEVGtI?=
 =?utf-8?B?LzVrQnpSYXg5aXBLM25kVEtEZlNRaEVXYS94a3JUT3hPSDZjYlVvcmNndzBC?=
 =?utf-8?B?YktKSmZjU29WaURyaWpLeXNJMkdDVXlpSlJPWnlPWUZ5eU5HK2JnZldQNDVv?=
 =?utf-8?B?TzBIYzU4TmpUSFJoOEF3NFVOM21nVzhaVlNuREhVM0dUdm9HdXBvUlgyKytp?=
 =?utf-8?B?amNBbGVwcUVreFNuL3FaWmpGMjd6NDZFb0R1azkvSUx2VkttSlZXTWI0UXpt?=
 =?utf-8?B?cHkxamMxaUNiSXU3WmVXQk9nNzhhdllrMi93TmNtR01GcXJqRUNldGxTYVVw?=
 =?utf-8?B?WFpVbVJCQlpVQ2p4MXZtVHBUN2F1SGpST2lzUDRYR3B4bGl2T0pieitOOGQw?=
 =?utf-8?B?S1o2K0ZIR1AvNW9QVm5BNXJJVEkzdXp2dVVUeUFLOWQ1Sk9WaEh6c1RxOXJW?=
 =?utf-8?B?MTZWZXVtS0M4WE9pU3pCMm12ZGNWOHVEY1M4WFkzZllMQU5aYUY2ejVJUisv?=
 =?utf-8?B?SzZnc0ZzZUMyd0l5N2V5YThGdzV1UHhYYVo0bWMyYi9lOFY3V3lCaWgyeDhC?=
 =?utf-8?B?VW5MTnBQelBLMFZiY3RvemdDVk8zMzBOdVo1aEtuckNRbzZ0NlYyL296Y1hh?=
 =?utf-8?B?QmRrbUlzanluM01WSW5FT1RJYTEvL3Y2bzh5ZHp2SW0rcWxOcDhGSm5XSlJJ?=
 =?utf-8?B?c0owMmd5WlRJbnVndkdGbHE3NTl3cUc0cnpJS3VnclUxUkhXaXhReDZLNkF5?=
 =?utf-8?B?ektwdDQ0WmVNT3I2UXdOZ0E4V3lyMzhJVXkvQ25Lb1Rvd0JpYU1KNDlmMmIw?=
 =?utf-8?B?S25KYVZaUTBpUThCQms4cS9LSDl3YWMrVS9FUnc0eHFBN1dqR291amhYeE8r?=
 =?utf-8?B?eUpvNVRobFZmNVRkdndzNkNRcDJYd3kzTVdoQ0cvWU0wZE9xcUZPQW83SWNw?=
 =?utf-8?B?TEJUTU5Tb2xnc0tiS05PTFhXOEFoZ1NrY3VIN2l5SytXZzFSaGhNa2VDRFox?=
 =?utf-8?B?c1B1NGs1bklOSlByN3d2YnpBaWxGT3lsdU5ORnMyZ2hTQklqYUV0NUN0WGpH?=
 =?utf-8?B?S3E0b3FRSllQbzJYL2ZBY25LbWFIMzBnTHhhTjNFWkkvRER2RTd2QmI3cTdq?=
 =?utf-8?B?WUlqOTNZYzZhdmFvM3puWnBkS2psK1ZiaXFPWURjQ2Y1YitvOE1uaThVMWtY?=
 =?utf-8?B?T3k5bHlINEhmc0diUGpyL2NOQ285SkEzdkhOakR4ZG8yc3I0eDJjQUI4U0gz?=
 =?utf-8?B?MmQ2eWVtSlIyTE9UaXd5MDdKKzRYQkxwWFhOWDI0SFdFQkZUR1V5SlByY2tF?=
 =?utf-8?B?V0w2NFhjOVJZb2w3K3VJM1gwc2xhdkNwV2JtU3NnWFBYS1dyZ25CQW16NHFs?=
 =?utf-8?B?Ui9SaVdCMnJkV08xMldha25ZUFJaRGpDQjZiVExSZmVTWGFUeVdNSjJERW5h?=
 =?utf-8?B?SjArWE40by9YN1dvZWhsNjBsNUxMcUZ3ZTNCME9aTUNHVTdrQ29zNnU1c2Ny?=
 =?utf-8?B?V1FPeVpyRysxWGVzL3FlbkloWDM1QTF4M0ttUUhBQkV2RFpXMnFwTGkrSCtx?=
 =?utf-8?B?MjFya1hod2pQMXNLd3haNU1YYmtyUW1XQjI4OVVmcWVPT2dmUVk3eXZ2d0Nv?=
 =?utf-8?B?WkN5Qmtabmg1eCtQUTdXc2twQXViUTJlMHhnczMvdlpoYVgxNG8wYWM5RVV4?=
 =?utf-8?B?Ykg3YUxPcEpyRHVrOTUraVBpZUJCc1ZjUnZYZy9SM0V4SzVXcEhJV2l4bGN6?=
 =?utf-8?B?bUpzY3dlVFI4ckpjcDR4Nk0yaG8ycDhUbnpldTl6Y1BHL3dITW53aTAyOCs1?=
 =?utf-8?B?c0EzWndvOEtGQ1hiOE43amVQOUxZOFVWM01QSXVMNWdHQVNNU2pBVkYwQ3Zj?=
 =?utf-8?B?cC9ESTBvWHpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djlEcGpBaE9ydW5qRFFVYmQwZDJBU05BeHR3bWhkcElESjRlYUFXRko5UjNn?=
 =?utf-8?B?ZGt2bjNmWXVCM29sd1VISEkrMk51dmxNMW8yTUJjQ25naHZRQ2dqZ3pLdUFu?=
 =?utf-8?B?SWxTQTZTZTMzdWlKUFp0dFc5VmU0SnQ3MTZNOFMweWp0RzlUVUo4ZzR5R3Fa?=
 =?utf-8?B?bDltVDN5anJiTldUV3VrZlRhMDRpcjQxN29Pbm5ZQzg5ZTJVazU5MmRYNUZZ?=
 =?utf-8?B?NDdDSWRCRDgzcUFqSHNZNEhqWS8vUmpraGo1cXZFaEJrV1hnaFNSMFBPZmUr?=
 =?utf-8?B?Q3R5MlJzS3ViYUY2VFlINWJEclhCTGNIWlFNZ1lFRHNrODdBZU1rbEZMbzdx?=
 =?utf-8?B?ajg1aWExdUJEZEVyb1d6NGJGK0NXRWlHRXhVRHg5aFBTZlNvLy8yNzlPTjJx?=
 =?utf-8?B?aERRNDA5a0t0dDFmalM2dHZlQTkwNDZPa00zM255RVZiaUF6RGk4aU9rbWxL?=
 =?utf-8?B?aklWWDRzMS81REVjeWNQV213bGZ0SDhiRnlnbmNsNTdiMFYrTjFpSlpiUGFr?=
 =?utf-8?B?ZG5hWmc1dHdHZUZ1MXJBWGlubk56SU5xMXdZUGhEeUx3VVJ1b3BrVzZIMXZQ?=
 =?utf-8?B?cEM0b2xVcGtjS2xEbXZ5MVZKQnVCYTlZb0J6c2x4MG5YeHdxYzZuM3YxeUJm?=
 =?utf-8?B?cTA1SVdSeWFEUlFrRm5GYk9UcmFoV0c3dldEMWZ4TURoUmpwMXVsYUl1cHhN?=
 =?utf-8?B?anMyVDhuVDdiMnJJb2xRdzJHaFBiSS90QTdKQzhmRnJ1cTRhdTN2OVpvUVFP?=
 =?utf-8?B?anQ0WjV5NDVPMEtwY1ljRXFhUHhzL0NCdlhZWDUvb1dlL1V3Z0N1MHFleEZv?=
 =?utf-8?B?QXNMSXhRRXRIQmhzTkxRZHlYWXp5N1Q4dHFwMk9kbFdQTWFLaUNIVGYyN0p2?=
 =?utf-8?B?REFlY2lDNSsyclk2Y3ZBL0dWOVl6WFZXa1dyamdTQ0JyckJhbmY0U1laSk84?=
 =?utf-8?B?eXJTUktTZWlHVSt2QjZSVGVmY1M1SUc1aTFXQmJWYnRDMCtvaTZSd1FtTkJF?=
 =?utf-8?B?M3R5V1djZVhEd0hLUG1VZnp1S0taRkp0RlM0UkVsSC9PdEV0c3M0TjhsNWpM?=
 =?utf-8?B?ek9BU25DTUZtTnBCcHVITGRidlBScERsRVBLV21OcWpsaVFpbk5tNVNtanB4?=
 =?utf-8?B?blh1Q3d0V2xwS1hlc0wzU0pQbUZBZnRRcXQ3cmN5NnYyTVJjZzZXOU1aTElR?=
 =?utf-8?B?TCtOSkNiVVlnWWlqZEQxa2kwdU1pME5JbUZHVjZiK1V2ajVtWVA2ZmF5allk?=
 =?utf-8?B?R2V2STNjbU1lOG03QjlPdFdTaWhMREpFY05sMytQZFIrKzNvU0hZcW10REpJ?=
 =?utf-8?B?aWtYSjJhRDNQWEVUamlTdlpBNDBFZWI2eFB6cWRTNllkUlQzVDRiU3JwbEFu?=
 =?utf-8?B?OXBOaEpmU3pCQW45bm8rYVcydE5naThWSkI3Mk9qemRZVVFQT1B3RHNQRzdi?=
 =?utf-8?B?NGdhV1hDVUdxM2Jobk1WTDR3M2dRWVhnckVsTm5QeXNUZDAxSEZRZ0IweUZ3?=
 =?utf-8?B?OXk0cjdRYWgwc2Q4ZFUzVldtTW5TVVNuZ2NkUFp3TzhGV2lybGFyNjRXZUd3?=
 =?utf-8?B?T1krdVNOMVJrNDQ0OEJhbGZ2cHRzbEdMZmx3ZWdaMDVlUms2c20xRDQvakdI?=
 =?utf-8?B?MXp1UU5vTEw4K01saldSNEhGUmlDZllPam9kMEJLajVxN2tib2FTNC9kamRR?=
 =?utf-8?B?NE9IanBlUXZuek9CVHM1eFh4OUgwOTdMV1JSLzVKb09EUUVvY09FNGcvVnhn?=
 =?utf-8?B?QUVhMk5pWU0rNW4yOGIvdUJXK0lEbGdKZzRjOHQ3aER2bVlEaUQwN2E0WUhO?=
 =?utf-8?B?ZDF1bTVhYkxiMENnVGI2TWIyeXJBS0JjRGVsZ3dxRGVFM2tFNStNQzdVbkR1?=
 =?utf-8?B?UWV3S3F0SUxtbGJ0dEtRYy9pMkdwbTRRQ2hEUXhMUG5BQ3Z0WVM0RXI3SkJt?=
 =?utf-8?B?aFRFZ1N2VVZjN2dWVTd2b0wxSCtlcThvZ0xZZ2ZrbnIwL1JVbDdOOTU1M05E?=
 =?utf-8?B?SlNJSXA4YnJOK0FFLzRoMWx5bWZlWmtVYU1QeHk3VEl6MGtsNE1hS2xsTTVD?=
 =?utf-8?B?U3Zub25uMUpjK0QyVlNSVzQ1d3dKUVJ2aGNqb0E1MHBXS2I5MVlta0htdTA0?=
 =?utf-8?Q?m4eVWkH1YFD9MabMY9prgLYXz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb26747-5826-4192-4543-08ddae39faae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:20.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3rBB36Cyj42WB19meKguBGurnj+Zdn4oKSB2/p/aDk5BWaTYJpHFZP1Ipqwz5Ck/ebVc8+bd3A6G8chKl3FqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

imx: update the building bootloader image related part for
i.MX8QXP, i.MX8QM and i.MX95 B0.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      tools: imx8image: Fix the value passed to dcd_skip of build_container()
      arm: mach-imx: Change to use IMX_CONTAINER_CFG to specify i.MX8 container config file
      imx: imx8qxp: update packing i.MX8QXP MEK flash.bin
      imx: imx8qm: update packing i.MX8QM MEK flash.bin
      tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and CMD_DUMMY_DDR
      imx95_evk: Add i.MX95 B0 support

Ye Li (2):
      arm: imx: Update ELE get_info structure for i.MX94
      spl: imx: Add support for new PQC container

 arch/arm/dts/imx8qm-u-boot.dtsi                 | 38 ++++------------
 arch/arm/dts/imx8qxp-u-boot.dtsi                | 40 ++++-------------
 arch/arm/dts/imx95-u-boot.dtsi                  |  8 ++--
 arch/arm/include/asm/mach-imx/ele_api.h         |  2 +
 arch/arm/mach-imx/Makefile                      |  2 +-
 arch/arm/mach-imx/image-container.c             |  2 +-
 arch/arm/mach-imx/imx9/Kconfig                  |  1 +
 arch/arm/mach-imx/imx9/scmi/container.cfg       |  1 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg        |  5 ++-
 board/freescale/imx8qm_mek/imximage.cfg         |  1 +
 board/freescale/imx8qm_mek/uboot-container.cfg  |  2 +-
 board/freescale/imx8qxp_mek/imximage.cfg        |  1 +
 board/freescale/imx8qxp_mek/uboot-container.cfg |  2 +-
 common/spl/Kconfig                              |  7 +++
 configs/imx8qm_mek_defconfig                    |  1 +
 configs/imx8qxp_mek_defconfig                   |  1 +
 doc/board/nxp/imx95_evk.rst                     | 12 ++---
 include/imx8image.h                             |  6 +++
 include/imx_container.h                         | 11 +++++
 tools/imx8image.c                               | 59 +++++++++++++++++++------
 20 files changed, 112 insertions(+), 90 deletions(-)
---
base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
change-id: 20250618-binman-a97471ee9e36

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

