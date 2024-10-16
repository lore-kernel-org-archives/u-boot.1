Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D43D206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C241F88D82;
	Wed, 16 Oct 2024 09:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MPr9buC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2CC88D82; Wed, 16 Oct 2024 09:19:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E692588D91
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiFMZ33h9KIvGosVxFXI0u7WyqffM+uD2lVy3knMdG4bhRVM2hPXdYqmrN/7/i3wueYYMPcI6U5kpnelb0ZB1o0IHJvvU/6SZ9CC0dVv6Snn3Xb0ldIsfUgyDkyjernwDgRgoZwkT/h7v40LwWh4/UN9tjPIRqbMMObqtF9Z0B5wNhUoYWJ5Zu1z8c122SZPFINiQzmrwa+ImQQ8Av3NcIw4/YSpXe4h/Avs6PbOolp4S4sR2phgqNZwGkqCLNwHh2SSdgXPDptUrQS/iln1M1S/6mNR69RTZdlQczGYUD91WYJRDQX9U1fVPDhtMtA+HtfSCQb8V45xBhMQeVz1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=OVfbKz62tkDYohQLxGIdkcndLkP5aq3mkcM1QtAq2tra6aiqKPy110smGFHsonnBMeVmrBWwIJBkDDdrLU6NspxL+ca2fWpwL/Hf2utbyW9JyzyXnlX6/nLI2cXvyC0ysv8sQcyMe91ARAqczNwAE8xKthSBpQEm5ucdb1QH06gSEGIFBBrk/y0tb1IC/0dKBNICkB2CzNp3YEJAK4fmT+P3K+/2WhNkrRFTPrmcDxXd/t/1PEkr9Fk4QtG0FhRryjKoCqkVjr6/RqaSdE4yXJIUjBdJjesHyXWxPcsN2Bc+Ll1jq5tnrkl8ZLRd/A1OkZtMmaZiQ2AhscloRGcmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=MPr9buC6HE+1gz9n2p24bwLNBJLAEZi2xbjPLeklWno35WPHVG15m05xyGSMRGxEf+wNdwzrYofcmMzYepjxfAOZaf7vaNELj5HC7MU+p12+xYtndFY+kDnZSSRq6DvTSCxxKCV7ge2v77jDUq4G9dHMfd5on3orcsFQ4/MF4GJ49TMNvq+xJQdHOATnPoYE3NxxB+pIXJUGipnGjycMOvNtFRFQ4+Syc7JqGBt+5JJUxC1FeHP1swgNR715WTwFS5Zol6O80ER1LUC7gj97DRmzLfpwx7dF/ZEXpEZGQ6rroHIXunVqouU1LYcTNQ5vVB/Ib5AGcOpNM4G0PB+Ryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:19:12 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:12 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:17:57 +0800
Subject: [PATCH 04/17] scmi_protocols: add SCMI misc protocol protocol_id
 and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-4-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9362:EE_
X-MS-Office365-Filtering-Correlation-Id: fecc9cb9-57ea-40a8-2e1a-08dcedb2d5cc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TCtrekhMaDlUK3BWbUZLbUVGZ1hEeHRTNkdGa0JCSm01L3BleGRiUFFtQUd0?=
 =?utf-8?B?TXNFejFWM2ZSREcxeVBZRkFLaHpLQjVmUFlPUTQ4b2dXRnJYbzFRZ29QOWxz?=
 =?utf-8?B?K2hNeHVwaDJZalk1cldCKzU2bnM0SHFtcU9yV3BLejZxVDJZWTVuamJ6Z0R4?=
 =?utf-8?B?RnpaNmRRM0dQczlJTlFFSzVrNjdZTmI4WDRmMXBoZjRJTHR2VXpPZWN3UTY1?=
 =?utf-8?B?c2NXY0t2WHpLbFNPNEZORzQ0MzExQ3FyVHhxenRCM0Z4NGd4bEhDcDc2N05w?=
 =?utf-8?B?NkFOeC9mYldBQjZYT0ZRVXlMSVU0VUpzNjMzN1lCVUJKTkprN2tFWnd1a1M1?=
 =?utf-8?B?RUdxZWduOWJmKzJIVVhzeGNVQlltZy9PcW45QXhDdXZHaWFWZDdwTVhVbHBj?=
 =?utf-8?B?eG9FUGhENkhxdUhVRVFOM2RuQ1NpbVUrcURwcTZ6OGZNeW1paGhBQmxDWHBE?=
 =?utf-8?B?V2VnN0Nxb2xoQVVYYjlTLzRIWCtVQU1BWmphNDA5dVR3dVQyV2JxQk5kdWYw?=
 =?utf-8?B?Z1lGK2k5Z3NQeGRJOUkwTFFTSVB2UUhBMFcrUDlIbFlnbkNJZHFQN1dLTUlr?=
 =?utf-8?B?RUgwdjZKNUYvaytxMldOTzVsQmg0OTczU3IvalZibm5QeEtnNkV4WVl4MzAw?=
 =?utf-8?B?VzN5WWRsQTR0czVkd0lsYlFOTndDK3UxVU1iVGQzWUxJTHYwV0xzK0dDWVQ4?=
 =?utf-8?B?UGRnYkVDVVpjOGl3RitSUFpJYWJzcDhERlpLdkRqSFZ4V3gwQmhjSWhoN2JX?=
 =?utf-8?B?RGZSY3l3cmhZWlZaYXVQeXhrZnRyaVh5dWpab1djdWRVV2pqREFvcGJoYUc1?=
 =?utf-8?B?dHp2Uy9ac0JYWXd1SlpYMWdsdk9Zc24zbmphR3JLSnFFTGdXMVhWUVg1aUNI?=
 =?utf-8?B?UEozaGt2MjQwd3J4VnFkU1RNdDhQT0N0Qm5ObGJ0QTZDOHhWVEl2ZCtVQ0FD?=
 =?utf-8?B?S3AxM3p1dGVLQlN0cU5CdXpWOTlTMEJWWDB4SHEvOU4rR25BemF5eU54SXNL?=
 =?utf-8?B?Y1F6MTJRUFZmYTdvS1RqMGx0Q2ZBVlQrUFVnVllwMXRjZ2M3NkQxMHpjWTRO?=
 =?utf-8?B?OGIrNW42YVZGRU5PdWRFV2lwamVhNFNnNytHTldsRlhTTC84TDNVMzdoakZG?=
 =?utf-8?B?a0pSNDZCV2plRGJRRUdyUTlERUFDRUpZYnlFY3lxYytIYm13bnRoZnpzQ1J1?=
 =?utf-8?B?VllDcGwvK3Z3bWpySmNMMDE0UzNsZk1BNjlKUEdTVUdTMnhNem56S0I3ekkz?=
 =?utf-8?B?T0wyWmMxbWZ6OHdPT0lzNFdrTjB3cWpBayt4aURZWFZ0MDJkV3J6UzNzMFNp?=
 =?utf-8?B?SmNBai9KVHRYWHVLTy9CV1hrRE9XTWZMSWxYcGxjN1hRTnpXUjB4YXRRZFJt?=
 =?utf-8?B?RGVReWtVZkJ2N1p6UkFaTWVWMTJrQ1VZODhKYlZ6YjgwZCsrdjdwd05kYm1D?=
 =?utf-8?B?NS9kd2lXbzFJSDQ3cUhZd0RZa294RHBjMzlTTmwvaHpsc1l6Z0U0NjFHZW12?=
 =?utf-8?B?c0lMdXNMUFI0czVpWHZsYUtQOWo3WFd2cnFwV2RCNXdYQjVJekFpRnZZMEJi?=
 =?utf-8?B?Qy9ZQ2dkMW1sZThKUldhN25aZUcvWVp3NmF0TE9JUy9oNzRqcm9Kc1JwNG9X?=
 =?utf-8?B?YVh4ZFRMZFVLTExiUFZyWmtjN1ZtejBITDlkQndOUFlpd0R3ODNXL1BJUmNr?=
 =?utf-8?B?QmhCVmttU2tDNGpvMmREV1FtMkVpR1E0ZWYrU1IwVlE3bVpxY0JIRUg3YzZ3?=
 =?utf-8?B?bzhxZ0NEZkZDWHNFLzlpTVVldEpPd2M2bkhGSHg5ZFAvYjVKUXNlMk1CVDB0?=
 =?utf-8?B?SkxVTHdFclVPNUxuVnpIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFU4R05mNmpTbzhUejdNcEdsVzhFa1VvLzJqOHlBVitGbVErK0FEaCsvRmhi?=
 =?utf-8?B?WWJOSSs4UHptVUgxQ0ZVNW1MdVVmWnZ1MFY5MEFDMldFZHFsYWhlUDNzZHlx?=
 =?utf-8?B?d2Joc1l1WWVzVlppS1JCSys3K1ZYNE9OQTN0SDVSTGRPRTczcEJvQWorSXBv?=
 =?utf-8?B?cm9GMm53YmNCeURhYXF1OVY1MW5FM3gzb055SEF4UjRuMHlSeEE0WUk5OG14?=
 =?utf-8?B?bVJwREJ4dVBMZlE1eFM5TWFGbFdLQnh6VFo3cHFYZjVqaitoaHJUUzdSeFg3?=
 =?utf-8?B?Wmpva3U4QVhnaDJRZGJNMXF1bUV0WWNRdGNUekRxZFBjRDl3OHplcVBOL3Ru?=
 =?utf-8?B?TlNJUTltbi8ydFBTR1h3aVJ5VXYxQVRlOEdoOXNxbjdJMlF0VlJtNldLT0NV?=
 =?utf-8?B?WC9wYjhPS09KenM0MHQ0VjllRjI3SUw2UW5OV0tPWkdVUk83bjhYbys4dVI3?=
 =?utf-8?B?UXY0R2F0V0VncEVsUWlCYk1NTmpkTDd6cHJVakhseU80akRDQ2VJWTMvZVBu?=
 =?utf-8?B?V3MyNHVsRzFyQ0tVeVdMNUd4Y3ZkTGEzWlRiNkhtY1NvcUJFNkdZK3VzakJ0?=
 =?utf-8?B?cGh4SnNwbzdFM1VwNnk2UmRLY1pBNzMwdDdCMlBrWmUzQ3NNUTNSSGJVMS9J?=
 =?utf-8?B?d1grTmp5QlZKMnFqRzJNeHRSQllNMWFXQXdHZktmQm1WbjRBeTJ1RXNrTDRl?=
 =?utf-8?B?TnZhOXlhNFhaUUpVUVE4b1FBR2FteWt0ZTlmYnB6cUFVa3IzbGZFSDBndGJm?=
 =?utf-8?B?bU1hWDBlT3ROVWRFWVF4OS9LMmZtVVduY2treThUYlNTRHY0S3UwRjZxOU40?=
 =?utf-8?B?RVNOaDkzaTNxYW5yd3hIelpRMXFCVjI4NzNkbitFU0IzU1QrcjVjMlUySHEv?=
 =?utf-8?B?S0dRVDFWTkFHdWQxLzlvV3lRNWx2clgwU1JnTWlBRFBhOUJReDd6MDVvNmdw?=
 =?utf-8?B?NU12SmhIKy94SzJOSDVBalJXTktJQnl5NDdrOC9QSXVyZDgzWlo5UUo3ZGRG?=
 =?utf-8?B?c3UzRllNZ3ZrcnREOC9xT2F6MzRaWjVYRWJoVU1KTlV6K0JNU2l1OGFkV3ZS?=
 =?utf-8?B?MDk3aE10MDN5a1oyMVVZQkc4ME0wa1J3R2phMDJzVGVLTVdwUUdzdm5QRm9y?=
 =?utf-8?B?SmozT1grRXFHbURRYWY2RWNtRUhwU1YrVENaWFB0M0dvRFF6MlNyYnd3Q3Nm?=
 =?utf-8?B?ellhRTZzMHBYTHRJdndXUTVPSU5kSUdub2dBZWt3dkMwMzdyc0g4SktVSGFU?=
 =?utf-8?B?NUlmZ2grelk1NW1FS0dGSVVsdS9sMWJwVTlnbDJXMnN2dDl4Y2ZwWWRXWG81?=
 =?utf-8?B?VVRlOUorMlo2bmFjTURIc21ldDVobHhvcXNzaVQvOFgzT1psc1ZBd1lHckxl?=
 =?utf-8?B?UWMxWE9UK3ZWNS9BVDZjbUxySTE1R002N0hEdUhSakEraVR4M1NqWUVqVnhF?=
 =?utf-8?B?SGwrRzRmK0xqWld0UXo3eWpVamNwdmNKTjloZE9zMHZIbjI2WThHKzRjOU9w?=
 =?utf-8?B?cENIVjgxMlE0dDVuUFQ1cGRoWFBDMFZjcFBuRjZRQzVJL0RWKzVqbFJSSXlU?=
 =?utf-8?B?K1hkKzVsMUN6YWxMWnBVdlZiT2R3WVVHUDAwSWxMcU8zTGUvUVJBM1JSRHQw?=
 =?utf-8?B?ZmFpWVIweklIbmJKK0l1UjN5Ly9uNlp4NlhSd1RMYlJLNUZMR082RHdSdVBl?=
 =?utf-8?B?Nk9SN2lHdVViNGdrRkU0LzZSaE1ORlFxS255SXNKWnE1QWN3Nnh6ZEFGR2VE?=
 =?utf-8?B?a1NjV1ZENHNyMFhubEdmRFJBNEVNUGZnTHppaHhORll5VG1zRmhnc1RlSnhD?=
 =?utf-8?B?d042SW9IN205SVdhWENrN2R1dzFBNElNOG9KdjJlb2pkUlFrbnU3MW10YXBF?=
 =?utf-8?B?MUQyencvVDFyMnFiWCtrY2lGZ3lnc3lqYkQ5N3pDSG5hdGxSTkQ5WEtxMEZ4?=
 =?utf-8?B?Uzk5eERVQWIxT08zRVNVQzdkbE5ZYi8zd04rM05pQ0dTRnFrVW5RRXIzVXg2?=
 =?utf-8?B?VUZkRmMyTHlOZHdSMlp4cDZtVi84M2JnZStoSFlDOFRZQkdEL2lnS3NnS2Vo?=
 =?utf-8?B?YWM3Y1llZ09RSkU4TGJWSXVHc2IzajM2d0QxNlZ3WmhwMXlzMG8wdHlrSVEy?=
 =?utf-8?Q?amJt47RtA5dfKbyxHxnXdBFIs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc9cb9-57ea-40a8-2e1a-08dcedb2d5cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:12.7564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sf6DGnDjOf06lEfYHfktHepdY8ATNwTrl0kGAGppvr2KvBbh0bpjGa8uXrNQZZk0UJ9g6uA1KHomJGqGP+H5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9362
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. This patch
adds SCMI misc protocol protocol_id and message_id for getting the ROM
passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2367467512a6b65253317e51bea71de396aa96f9..6cda1f00df1f6baf6db65a28b4cab114f8540a4b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.34.1

