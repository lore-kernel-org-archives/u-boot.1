Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74502CDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D6B88B63;
	Thu, 19 Sep 2024 04:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AKZT/PNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24FD88D97; Thu, 19 Sep 2024 04:58:05 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF37988B63
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw8QFIZ/RlzUqm1KCGEXnQ+zrZX5bdEvprfV4dVMRN6zlrp43QIeQTf7qSRhPeBZoydLUhXjcaXFT44J7Z0cSByajNwM5xJduBZHGtJnikv+36qtKpZ87JMBMYDLDhEy999ZFDln8tlW8ZiIj6XkqJhg3gfmBfxeaKNO5EZ3I+hP29NihMF2dMVP1/adcw7iBsb8Y3VC9RRTcx+YEFOzxUuLwByvu41gIMBD+UX7XEofNyG1Y5mptQ915JgLZ8vwrztuNN+6l9D6aoqyIHxu4l0mOAVfr7YWUKWtHaNtA3ykIhG/DFlIHtOf2+iw/0vkfQqQYEylNAILHnhOA0zzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evb49IDf73lghnpK5vq/RnA7X5rr8t640/WWMvRvwNY=;
 b=EEefto4wUUdWsCPQYa8xuGkoqyNYt86Cd5y5mkcloJIkESRkCWuDCugkrQIrYamx72LrVPF/WgmWaHxWL4hgW42YQMO8m6SXAFPlpAY+Eh/F2wdzmPXByPUDDf279z6xjEYTjEPgn1mWXDm715ViN8L0o/X2j0CO6+df2G86u3RTDugSFH6Wg66JY7L7CnT7WH+6XvV/OSzbkWDmRQ/DWYlg+bxc75mh0WwKPN8w3EllNlSZmtoWCfYDjkXi57PDmOxZ54jZA9FdT0M4BFLfPJ/8I/4mgWNXlJJCj4oOjBDgqy2UlEwPhsonWLpwUPKYxOHH07yW9LaBTOPZOedbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evb49IDf73lghnpK5vq/RnA7X5rr8t640/WWMvRvwNY=;
 b=AKZT/PNe6yA/CROu6Slv15JZ1sCoi4lcL9KLAHb5TOIKgAltOlEnkg8xyDAeqFK/kAPe1ltth0ix0UZytp1PvcOLEh6NStxI/6FOR3DZMnzcUjBMROQA9XDmsJAQR7JWbEB4kui5AAKBx/fSBQPQJaRsC0krvhUH8lovjUnUywVTvcME7AwlzODNafl0cbLJeePDM2Kx5D9LqFuQHaHUr6YnxyuydgQmY7B49q8IkxURIp3RlI1yz4Blz0+FbwYEPrmDhCoH9p8RUgOcXJg9oKLFuQbdXrJhPhZQKb6xvEbI+yPFwfD+tPttGVYdVlKlotVBjXf5pvpQH9LSwBmnHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:19 +0800
Subject: [PATCH v3 01/21] imx9: soc: wait ssar when power on power domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-1-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c28960-bc9d-4504-6aa7-08dcd856e03e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0QxMFVHWVF6cSt3dU1ZVVA3WWJucmVFcmlvZjdHVk50MWRGbDV6SHRZaXRO?=
 =?utf-8?B?Y2M3VHVRZm51Mis1bk1Yd1R4TGQrRnZUQnVudDJXWHpwUTRSRFVPeHdyRTVu?=
 =?utf-8?B?RDExWjhEc1FsT0lIVVVJcWdORGlUUmNiQVpicDA4SUQyODg2TkxULzZyZ014?=
 =?utf-8?B?VXFwNzNxK0dYWXpvcnhIck1uWXBsSS9GclRhNCtxZmdrdkRDcHJzYThJTFJ1?=
 =?utf-8?B?T3FoSnJiVTlGVW40WWVCRjFtZVV4K3hYeDNDdnNsVDFPWURFMFp4TFcwcHlm?=
 =?utf-8?B?MDR4ckdvbFJUWlI2LzZ3bERhYmxYQW9rSEVEQlhLcGRhTytrZzNJOFF6NTBK?=
 =?utf-8?B?TzVqTitXSmZrUlZ2aUFsUGJKWEhFTmxpZTdKczBGVlBWNmJvRkVoUFNkK3Vq?=
 =?utf-8?B?NEYvWFdjT2ZtQjJYSnRWWEFIek5iVkNPNVdvZngvQlhhK2RldS9TQzlxMFVZ?=
 =?utf-8?B?WEpaOTk2SFpidHdYQys1MWE4YnYwdmdjeEdCenl4U2VBZWplWkwwUFl6dTJs?=
 =?utf-8?B?VWxtQlNBYXIzODhJemFKUTRvcjNhWmp1ODhsekk4ZzBZWXlFekZsSmt2UEYw?=
 =?utf-8?B?aEs3R3Zmb2FlNWNUUUg3UVFOK0w3Q3M0dnNqTnRZTEdBRGpHU3ZveHJvS3Az?=
 =?utf-8?B?VzlNZFFCYWRWVjFDSjNJRUVjaEJBVXM1QUpCY002SW5Pa1VhREI0by9BL2lZ?=
 =?utf-8?B?TFZEMlV2Mi9DRTU3OStzNWFtdElUOWhIMUtmdTlwU3p2cjBwMTFKSTNEZzNk?=
 =?utf-8?B?VHVuakljZlk0d1YvenUwaG9zV3Ewem9kVVdpb2pEOWttak1KaVFTdHRySUhl?=
 =?utf-8?B?L0VVcFF3NjQwTS9Icm9ZRGo2UHJrRUl0SUdoZGlwZitVNzJLSVlIYXlaQ3p1?=
 =?utf-8?B?NmhONy9jTjhRdXAxWXpBUFM4ZllrNWpMTTdPRGFKUTRmRE1HcU9LVERRT0hq?=
 =?utf-8?B?c2NlZjJBclFMUVZ4Q1NUd1VFNTNVS2RDQjBJQWhiRHZFMkJielZjUGUwcWVk?=
 =?utf-8?B?YmJNd1ZZKzd1TFBFUDlzc3pDeC9VU3owaTdXcDNicjNGVDNXVkM3dWt6aHBx?=
 =?utf-8?B?Zk5yQy9NS2hoUFM1WU1XTlZDN0EyQy8zRG54TiszMlhvYTJ1WHNKczdkTDlx?=
 =?utf-8?B?Z1BXMzJldlFjUWw4bWc1QkZaeWZrVlpwTDJLTitKa2ZsQmt4aks1Z2FjcDVw?=
 =?utf-8?B?SnNBUDJxU3IrT0h4dlIybkc3SXZKWFVrRlVBMFBoR2hGeGZ4Qloyd3MxT0kw?=
 =?utf-8?B?U1VVVmpjS0FWWnI0WXdSZXFFREdmVjdCZlB5b3BORG9pTU5UcWdaNTFQTWtn?=
 =?utf-8?B?NkY5aE91a25MYXNPN29nZXUrdDFmY0NVRldMSDkvKzlPd09uMFlUTG8rU1lF?=
 =?utf-8?B?MVVEK0pJUWpmNkdHWURqOVc1cXpsakx1L05wN3haeFEyNFFxUHY0Sm9LNHhV?=
 =?utf-8?B?OWtDNDcvRVdNUzlFbUx0bjBOZ0g0QlRxQm5sOWlXelhpVzVoMFJkT0F5MHZz?=
 =?utf-8?B?YWNEczlMak93Qk83blI1Tk9WM0d4ZUFyOE9TMzZlSlFQYkowVFFtYlp0WkR1?=
 =?utf-8?B?eWlzaENNS2tkRXdBdnpCZXhYSE5TMWllQmw0aTE4aG5GLythOXpkQkV1WitR?=
 =?utf-8?B?MU04NGtwOW1lbDIwUUNtdGJGOHQ0aUp5bGVNTmx1QUdhRW9yaUJDV2tXaVdx?=
 =?utf-8?B?Y0RJRnFQNFRhcFFMeVpKMzlseEoySmNEcHdFeW54cUNCT2lDRVVEMlpuT2ps?=
 =?utf-8?B?Y0RhMGFTbWNlTmY5UU1rakdJL05wa242RUUxNWdFT2UwRWI4OG1rSzhmRmxE?=
 =?utf-8?B?M1E5WEtWYUh4TGMrd0F2enVlSzlGS09YRzY2ck1ZUlZRR2U5OEYwZkgxeDk3?=
 =?utf-8?B?UDFxYlh1cXRtU01DWlZYWWp2dlhvN2hkcHJvMjBwTFhBbXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXkzMlZ0UDg2anRXbXNWRTR6VHg3T2ZqcEJ2dkJzRDNxTmUzOHBCc2hDYWN1?=
 =?utf-8?B?dTlpM2Iwa1lLakgyVGRvT2swS0dmbWpGNE9zdFljdXpiR0NKYi9UTCtaQjJI?=
 =?utf-8?B?WG5Cd2NzRTBvVGw2YzhtZEpiQkZmNDh3bFFVcFpNRmpKdHNJd2RwNlJoVE5U?=
 =?utf-8?B?MDIwN2lLSjJJT0lSN1dUcHdITXB2NnFXSUV1K3ZEY0FiUGYyQnJ2OG1HTVJX?=
 =?utf-8?B?RndPVTdUbmhmOGtOWFAzclJRd3oyd3BUOW5PVzFyMlBIS0ljMXBRNnVsVkIz?=
 =?utf-8?B?STNkcVJaK3FrQm4ySHUwTTF3YkI3UVVtV1ZqRHc3UjA4blQ5TXMweSs2MkFS?=
 =?utf-8?B?TVpaZTVESWNvWkFHZnltQVZra1AxdDB3LzJzNnZJd1VUay9xc1lxOUExeE1R?=
 =?utf-8?B?NkJUcWNYd1drOGNSYXVxR1lQWno5cGUvUDhMVVAyN0ZXWFdNcDAzNlB2U1hm?=
 =?utf-8?B?ck9yLzZmSXluVEd0Q1BzSWxaZmttaGY1NVBuZWFIbU5oVkxFbWVzQUNqUzlJ?=
 =?utf-8?B?VFlnN3V0TDlvaXJLQkcyNjNQd25NNGFWaHJ0TC9xNVhpZU11a3BrWVMwelRB?=
 =?utf-8?B?UWZkaXpNUE1zdk1BYWNFcDdoRmhNRkZvRFNnN09PL3ExdjM0MVpjN0lrdU5B?=
 =?utf-8?B?azN3ZEp1MTVnMGd0b2hzTFM0Vk9kbHV2dHBKQmtqQ0NicndmTkRVQ2tlTXhV?=
 =?utf-8?B?OTc2WXorUjBEeEMvNnNCcGk4TlhObnkwWENUSUdLZ25RUnZjRTRweSt0dDZp?=
 =?utf-8?B?aE9mb04wS2tveTBVeUNJdVVZdDB6NmlTaXlJVTF2Smo4di9PNGxVYzBCeTdM?=
 =?utf-8?B?S240K2tQa3dCbmVWRXMzcks2WlZkS2VHQzdaNW43SmZ6SDVESTJVaVlTcjJZ?=
 =?utf-8?B?bjk1bXBXaDc5bUYrcW02NWsyWkR1c2R4S1lVSFhqTk9CT0xXSkVWQVVIYW1v?=
 =?utf-8?B?Z3J1SVExM2ViQ1hNcHJHazExOW5rNkF1SUVVV1FiWDBqbklETlBNRFBzSTR1?=
 =?utf-8?B?OVFta01vRisrcWl2WGxvVEd3UHo0a216RnJrM3lwcHpMdzg4K1VNNFRMdUdD?=
 =?utf-8?B?Mi9nWVVMWFplVEEySm03S2RHcDdGVWlNN2xOWlNVaXFtUWxVeWhsUTJlY1ZR?=
 =?utf-8?B?Tjg2Z3hOemUvRHNwS3NwRURWK1dqWFVWd0h6YVFiSnNWb1YxRDdOenhDbHhE?=
 =?utf-8?B?c1d4VkJjQ0JpbHg5dHNDWjRLSnJvTkJ2aERpYkQyciszOG9vV2NhbVJMR25D?=
 =?utf-8?B?bXVldzg1cnRTZVgycE13MUdaWVgrelJiV0Jxd3RJZHhpZW0zS2FBWHlNUHBW?=
 =?utf-8?B?MFY0UHd5ZW8rOWlUelZxalc1UXJvK2x5S1pLZ2lrTTcxVWRMeVJycENsUitH?=
 =?utf-8?B?ai9WMjFZejhqUWJyK2lwaXIxZ2VXeVUrU3ltMnFmR2VlSmJTcDNSOWN1a0xr?=
 =?utf-8?B?NGdxSzkvM0xZcjJ4TldUdmxWSWVycUpOalMvT2t4cndaUHFuZlo2OUs3dzJv?=
 =?utf-8?B?RWlhajgzNXVCWVFVakNqRXR0OWYxREVFYnRiSThqR2Q4N3hKQXZIV2x5ZVY0?=
 =?utf-8?B?SExTc3hGaU4xUTJWcHFJK1pZN2wxZ3NpSGVoUE02OEpxMU5aYUR3NGUvbWU1?=
 =?utf-8?B?UmJ3WGtlTTFLVUhOT1hxY096RlVyYWErT1NLZzZENnhDWVJwOTc0djR4WkFy?=
 =?utf-8?B?ckxLK3ZOd1JmS3V2UEFKOXk1NlZBQmF5WDdFUTRpdFNWakl3VTJoU1k3TkxP?=
 =?utf-8?B?VWZmeTFPMmxXdmRLd3RTOUVYN2tHUGpDcUEzL3V2amlOVDhnMlBQeWVYZk5u?=
 =?utf-8?B?OXJuL0U2V25pdHZxNFI2djU4UVQ5YXZqOTJRVFlyUDEzUmw1b1A2OUY1NU1s?=
 =?utf-8?B?OXAydEJicTkxOEhuVktURytFd1FKUjJPb2RuQ3luQ0M2Q2ZmdUsvandDZC80?=
 =?utf-8?B?dkRjamVid0Y4SUp0SXRTNWNvc0Z3STl6TVgvRk0xVnNMZU9adVNzTjY3Z3Yw?=
 =?utf-8?B?WkhleDl2OW5xRXc0QU5yNXNBaUlTN0dldkdmeGt3YTY2VFl2WXROQTlhQUQ0?=
 =?utf-8?B?Z0wzazFjdCtBVFNiRnRtK2lPUmdHRnM5VjRSL1FQRnpTTzliVG5FU0NEKzRq?=
 =?utf-8?Q?itOgLwewnC78KafcFdtfWLt0Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c28960-bc9d-4504-6aa7-08dcd856e03e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:02.1769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ6iEW8KFzeCrfQ8mGIcOif8NVhIU1zytTq8rFlqAobWtyxF8oYRvgVlA3IUvtY0zV00A1O0wtGynOis6hBaoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

SSAR handshake done means power on finished, not ISO done. so correct
the waiting mask.

Fixes: 0256577a83b ("imx: imx9: Add MIX power init")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 76d241eab09..9953c33b73b 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -38,6 +38,7 @@
 #define SRC_MIX_SLICE_FUNC_STAT_PSW_STAT BIT(0)
 #define SRC_MIX_SLICE_FUNC_STAT_RST_STAT BIT(2)
 #define SRC_MIX_SLICE_FUNC_STAT_ISO_STAT BIT(4)
+#define SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT BIT(8)
 #define SRC_MIX_SLICE_FUNC_STAT_MEM_STAT BIT(12)
 
 #define IMG_CONTAINER_BASE             (0x80000000UL)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f88e7a222dd..3ee2f3d881f 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -752,7 +752,7 @@ static int mix_power_init(enum mix_power_domain pd)
 	/* power on */
 	clrbits_le32(&mix_regs->slice_sw_ctrl, BIT(31));
 	val = readl(&mix_regs->func_stat);
-	while (val & SRC_MIX_SLICE_FUNC_STAT_ISO_STAT)
+	while (val & SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT)
 		val = readl(&mix_regs->func_stat);
 
 	return 0;

-- 
2.35.3

