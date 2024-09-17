Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488C7C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BD588DF8;
	Tue, 17 Sep 2024 04:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lf5pISK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C29888D88; Tue, 17 Sep 2024 04:31:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A0688DFC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui5iGrv4k7Xrh6thhYLtK/935kuuaqBgNGaPEhkJJhgggbdNuipXPvL+ShMS2cmR++cpErraZm1GZrk0F9PUImbchwbsg9ggQ6QLqHSmdSM1qh1vyaqkwqk/EGetJFmrojKOyosoGuiOK6QHG8wmaGOfeqTmuoqZPDxCv/onQ1kVSW2WLCd1T0W2VPYiOLJiFj0o8oycFsjn9nZ4izxMMWStqG/rS/lZ80KMs0VT3qQ+plnj8jwUqgVyqDxtAdpoqnayNeWMfSohfm7ac9H/+54/NsDEjiFgR16mzb38N+6iPErtBgfJZrUimJ6cr/MZlh+xPcz49ZubblbpZ2qjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBjr9t67Tc9BEC8DYclgOUigR6mT8WtfSA9GaDHYEKs=;
 b=I9290aeL5YrQKs4RO2sIpwLubCqlMuUgiwhUxIjdapPkjgiVsqKVq0zDIHYh4oY0W1Eiek45/lLtcAUKh89bQHRz7K6LgcsXHrK53OaGUM3qOJ/WNsDE+V3QOllmDBpL3eg6k4SF2z4OeaIgm8RNveKxyrNfBAzzfLwpn1X0tsxWyPfXdjSVx3Gg0/MrDCKEsxF6RZFNeRRu+QYMW4uL1RvjyQyFh4D0OrvARtQ/RxTaZsjauklGN69P92x85znLYiyNgFLxywp18jJ6Mt+Y9ZJegvTMTbf+dD2ErmbF1oaxXIfsKN8gZ3B1ttLVOgio1sd09rii0l/nmkavJ3bdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBjr9t67Tc9BEC8DYclgOUigR6mT8WtfSA9GaDHYEKs=;
 b=lf5pISK5I4sq1VhOhNaHSxOZueWp2+Or4y2CzwcfwHjKFo/oYuS7ZIS7yr0AnX9EpCs00PBo1g4n8AAgYqlsG9v9aGaZA+Jo0VMiyUwZRW9YGZXQpEZtUJeKrC+b4fWF1DDGHW/8J0vF5ONry0RO8Vehv+7uoXjVyOk2fxp8IyH0+G6lW9quy3cy622kFfTmw3bDUp3sa2Zur5/0Mawht6xflAoLpwtCyUIqNSshYHTahlXMddnDjD662YP3S5U0qzrLjlUWp1YD21NEhWn8eZA6yjnELo2GVnmaG1X/kqPCbQZ9nNtrpWjEReFfiHAX4HLeBg+fKrbbukfVw/QXJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:30:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:59 +0800
Subject: [PATCH 07/21] imx9: soc: Add function to get target voltage mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-7-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: a91e8b9b-2acb-46f4-915a-08dcd6c0c049
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a01wb2FuK2dCOEpDZXo3SkI4SGxKRE5KZUdheEV2VjFPc1k2TituWHlEL2Vu?=
 =?utf-8?B?QU1VSTBWTHd4ekhiajgvVW54ZitUckFLZnd2a21YZnlXbVN1RW5aQnJYaXdT?=
 =?utf-8?B?dlFpUDRxYkd1OEdQanZuRDlZV01ZZWgyU3k4SCtiSC9ieXBDemJGem4rUVJE?=
 =?utf-8?B?K0xCM0NSY3ZybjNzTjgyTjV5WW9XeDk5d1N2N2piU0RnOHk3QkQyVjdZMlRk?=
 =?utf-8?B?c012MDJhRnRhRkNwUlo4MERiRmpmVFA4akFrSndLYk1OdEZvQW5MY05NUitx?=
 =?utf-8?B?aEhKeHZORzhQN1lVZHNzdnNyeFVMMUY0dit1SE9GYXhhY3lqMVBSbjZhaFF5?=
 =?utf-8?B?cWZXRE45d1o1N0FFTm1lbmRIamdEemk5dnNMbi9PRThxalRXdzg4bnJRcUtL?=
 =?utf-8?B?cktGVFlUQ1Z2cktENm03ZHYwdXZSZUtscmczTmNEME9tMzZuUm1XR0pWM3U1?=
 =?utf-8?B?RmIrWG9ZMXNEOFRoMXc1Wi96R05xc0J5ZDVSMGd4TkYxcnltN2c1OTkzUXZl?=
 =?utf-8?B?MlBpUDl4RmdiR2wwNm1kRlk5c0lpa2NWbHp4bnNZTyttbXkyc1IyT1gxdFhj?=
 =?utf-8?B?enkvT0F1NzVJalhZblZBeXdLazlzNDJPNnIwTHRFSVJxRHQ3Q0pycEtYMC93?=
 =?utf-8?B?YzR6VFdVS0k3SlQwMHNaeXhpdHBsTVA4cC9qSEdjcldIT0tKbUhycEUrckEy?=
 =?utf-8?B?c2xxdWppdTAyaWs4a0psbGRqNDlnNG9KZmEzejRLK0dKUUJ5VUVaZGNEbWZ0?=
 =?utf-8?B?Mmcwa1NpUi9ySXUxQWM5MG5Sbi9rS2NRM0FCZFBwVUxsOVNsNEJmZU1PU3ZL?=
 =?utf-8?B?bmJtaktoRmt5Q0IrSklhK29iMHB5YWZxV2FTYlVTakFvNEF4eUVmS2ZJV0Vv?=
 =?utf-8?B?OGdsWjlvblJ0R3Z5bE1zOHBmcjlQMDlmUnpRQi9lZHdwN1N2aWRjb1VkNEt4?=
 =?utf-8?B?T2taNnhNOHZ1dTQybTJEdkRkeEgwY2lQNUhEeTd5L1dOMnJUSTEraXlieVlo?=
 =?utf-8?B?S1pxcWFHdE1hY1R3TVQzdUtpbndPdXpvV1ROcWtJV0kya2JCdXpRMjdnMDNn?=
 =?utf-8?B?dFNSbkp4bkU3bE5FZnBwNnFsdENiS3ZNdlc5bWNROUdkbGdDM1UxQkxyczlH?=
 =?utf-8?B?d0t4Rkx2bHZpRktDaFpsODAvaE8zanZNOEFPbS9PckJ0U256d1diSnBGYnRN?=
 =?utf-8?B?NTdjUWtZdFJNOFdPbUxCSlU2RzlKNHVLNUhRMXBrRnlKaVlINGVNMGxzK0dx?=
 =?utf-8?B?RmxwdUh0aWpzM3NzdG4yN2tyVTA3Mmo5ellVYlVIL0w4bzZUU0F6VXlkMHVh?=
 =?utf-8?B?elF0VXpjd0V5dmJUam1DcURJNlRjaWpxVmZkd2VpdHpjQmEwMS9BR2swbjVS?=
 =?utf-8?B?YVd0Ui9FUmxmb3pFTDhReWtkajR6TnM1TDZhVHE3c2J3NlhFTmhmSlRQRU1N?=
 =?utf-8?B?RWdNd1NLVTVvS1RyVFJveVY3dWFaazJEWUJwWEdmTFAyNFpzb25nV211RVRS?=
 =?utf-8?B?dE80RDhxUDBmcEJRYWJ1NjZUckUrZ1VEaytJWkZNcDZOVUpjTWlWeDQ0dXdy?=
 =?utf-8?B?NkpJMS9JbWFtNXJ2djZSdzE4bWgyOXpxdjV0ZlJ2OUxpN3ZhbzQvTEZUUC8z?=
 =?utf-8?B?VGZXQkFSV0UrMUdGcGY3WERzdS9TVWp4elJURE1FWUhiQWxWN3R6OU8yL2JR?=
 =?utf-8?B?RFFhOE1MUmcvcEdCRGFXaURDQ3NQcHVTeEJNWmhJTTVxMnlNQ2NpL3lNTlhK?=
 =?utf-8?B?dDlUNkh3U0c4b3JWTjNwZ00xK1lETk9jdXFTTTBUNnBlb1AweHRBWXZXZDhj?=
 =?utf-8?B?c1ltNHFob2h2WjhGcXk1YklPdmYycUZYZnVBWnFzbGpyYjJjMU85TjZiSTd1?=
 =?utf-8?B?cDE4Mmk2bkVtWEFDYjQvbzlvSXI5a1FGTThRQy9KbUtJb3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NPZEF1RUwzVmZHeDlqQWRaaXA4aFNBTmp5STYvWHN5VGN3Vk55RHJVczJO?=
 =?utf-8?B?WWlnaXlicGlwTW16ZERnWCtFaHJqM2RWd2NBbElSM0cza3NDamZKTUlySms3?=
 =?utf-8?B?YmtHaDZTQWhNREEzZXVJdWdTdWs3YW1pNEo0NmJPbjV2alJYRVVEQk1EZXMr?=
 =?utf-8?B?NCtEZkp0RzF1TVdhVTl3Nm9MV2UxSHRqaG8zeVFUaXo1bGNTK2ZKUWtxZVhR?=
 =?utf-8?B?MHoySEpsTTMwamhzbk52ZlkyRCthM1MzWXdqeXZoaHh6KzIzemtvdEYwZGdk?=
 =?utf-8?B?V1dtL01VWG5FWWdYL2pjcE1ncUFhMWtVQzhtU3g2Zno3ZXdOUVFNaVNUSmtn?=
 =?utf-8?B?czhFeFY4L3JXaFIwRHc0VlVpeUJ6SXdQVVVLUTdMUlNXanRUeVBzUkF0V0U4?=
 =?utf-8?B?aC9QZ3R4YzNTVUxmSTM2MU93ZjlPRDU4U0ZKbUpDcXIyNnYrblBDWkxqeGhJ?=
 =?utf-8?B?bHhwVGhxcnI5WW9mQXNIUHF3TVVwZHF3MjRScDRyRXlZRVc3d21na052enJv?=
 =?utf-8?B?M0ZWTjNNTWF3K2Ywb1pZUTV3SzNBQlg0Sm8xcXJscFVVSFV2TEMwUXcrNVdG?=
 =?utf-8?B?Y0JrSjMzK2YySjhBNXhTVW9lZnlKb2dMcHBHaGpPMVZ3RXQ2cU9naGd0S0Iy?=
 =?utf-8?B?U1JDc1hPV1NTRFF6NWFNazJUVEVnLzhQTGp3R2RLYmU5L3hvQ25PYithZTUx?=
 =?utf-8?B?Wml2WmczZFQveXZVS0hscVJlZ1YyMTBldjFBSzJ1dlR2MEdHVks4VVVweUVo?=
 =?utf-8?B?MW91OUxxOS9aRTFyYWxENm1VNWV0VzFhWDNYRmNvTUI5RDhUVDZ4UCthMVFh?=
 =?utf-8?B?bFE2SHgxV0tLT09CUUtDb21lSjFOcFR2M0NINWl0R3ZDZSt5Q0xBcy8zbWpO?=
 =?utf-8?B?T2Z5elJ0UDhJRnFnZlQ5S3VsYk0wYW8rWk92U01la2xjVFF3dDcyd1psMzZx?=
 =?utf-8?B?d3JIZ3NRbXYwTEJ1R1hXaGI2U0hjWWEvalhOMTcyMk1SaTdEREIxd2plNUhS?=
 =?utf-8?B?OXJSQ2ZlK2k1UGp1eDlzYU5XcWU3SkZ6VEtuZzIxRkJPcmxTdFl5VGF2OG1u?=
 =?utf-8?B?N3BIWGxEWEhORzZzSEJCVCtlZldnZ0JlZS9lVGNaazRuc25PUGZxRXRXb0Fz?=
 =?utf-8?B?R3Rra05aajF6N3Azb0t2dlRzdm1aTnlXeU9VUFA3MkFlcTJyZWVNNWEwZ2tx?=
 =?utf-8?B?R2UrNytEZVlUdFo3Z0x0WlVBQ1FKaXl6SkVGdEtuNmJkMHl3aGJCN2JvczFS?=
 =?utf-8?B?aWNXQ1dKVC9UUk0xanpOYXJ3R3U1UmE0TTNxL2dYZTNXZlNPR3hLUEZEZ3ZP?=
 =?utf-8?B?V0pvT2thdDJxQ1NoYkJTOG1idEFRdGdsbC9IK1dKbGpEUjVwbXcvMnpROFov?=
 =?utf-8?B?Z0hVVUI3aU9jeTc5c2ErcDhDNWZnMVV5MWNzWGxMVWdlUzRpdkRGM201L1g3?=
 =?utf-8?B?cEpVeU12K2RJczhZUU0xYkpFMkVLSU5OaHBQYkFTY0k0TnZWV0phS0lkM3RH?=
 =?utf-8?B?MGUxOHBzMUdPUU5PMWlWenZlV3lBcm11bXJCNzlrT3k4ZFNoZi9sS0NmMlRx?=
 =?utf-8?B?cUN4WkFqZDJPWjBiWnkxd2FrUmZrN3BpVHJTZUtlYkdNcVg4a3VORVk4eW1s?=
 =?utf-8?B?QXVhejNIc3dSdXAxV0J2VmtNNUR6MnhpYm1lZHdtZWdHcENGZFc3UnJkSEVz?=
 =?utf-8?B?L1lZaUFYYnBxWk9JUXM4U1M4dEVuOS9yNjVFK2I1ckJBQnBxNEdJZ1ExVmM1?=
 =?utf-8?B?cWgwMG9WNjRKbFNCU2gwVTNVS1FteGVNSUlXUFFab0M4dVJUbFA4ckFkaEdl?=
 =?utf-8?B?bXhZYjBtSUhXcCszRmcxQXFXWUNvN21ZMUFDRmxSYW8rMnI0b1BsbTlYWjRG?=
 =?utf-8?B?TlZvbzgwU3p6TmJyamhjMFFCYlU1c05lbWw0bUw1YlJnUFRpS0JyN29LbU5q?=
 =?utf-8?B?VmRJT1FNMzRQb3REL0ljWXJZWHNFWmRDU1FtTmpJZnZQL2VKZUdPelM4bGsr?=
 =?utf-8?B?YU9OZjVxRkk0VW1OeU1vb3ZvcjZMTnBoTTE3aDMwOFBVM29kcW9BTmNQS2Y1?=
 =?utf-8?B?amgrU3JzQzBnRVBkWVlYOFM4TW9TREN4WU02Q2ZTZmU4TGV4TWV6VFQvRjRr?=
 =?utf-8?Q?+uywQXC5ztIpXAODovgGbLjvT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91e8b9b-2acb-46f4-915a-08dcd6c0c049
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:53.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKlwbf/fLRpNAdpnw4nGhBA7I07TSpzLTJXDQgAbxzY1HGiSEF1koCEc6LyK6nbWbjI3ElCBdjYdMLpiB1dMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

Replace the static CONFIG_IMX9_LOW_DRIVE_MODE with runtime target
voltage mode by checking the part's SPEED GRADE fuse.
SPL will configure to highest A55 speed which is indicated by the SPEED
fuse and select corresponding voltage mode.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  11 +++
 arch/arm/mach-imx/imx9/clock.c             |  31 +++++++--
 arch/arm/mach-imx/imx9/soc.c               | 107 +++++++++++++++++++++++++++++
 board/freescale/imx93_evk/spl.c            |   2 +-
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 2f7a1292758..e4bf6a63424 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -8,7 +8,18 @@
 
 #include <asm/mach-imx/sys_proto.h>
 
+enum imx9_soc_voltage_mode {
+	VOLT_LOW_DRIVE = 0,
+	VOLT_NOMINAL_DRIVE,
+	VOLT_OVER_DRIVE,
+};
+
 void soc_power_init(void);
 bool m33_is_rom_kicked(void);
 int m33_prepare(void);
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+
+#define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
+
 #endif
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 0abf4579a1e..1433e68874d 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -603,7 +603,7 @@ void init_clk_usdhc(u32 index)
 {
 	u32 div;
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		div = 3; /* 266.67 Mhz */
 	else
 		div = 2; /* 400 Mhz */
@@ -700,8 +700,7 @@ void set_arm_core_max_clk(void)
 
 #endif
 
-#if IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)
-struct imx_clk_setting imx_clk_settings[] = {
+struct imx_clk_setting imx_clk_ld_settings[] = {
 	/* Set A55 clk to 500M */
 	{ARM_A55_CLK_ROOT, SYS_PLL_PFD0, 2},
 	/* Set A55 periphal to 200M */
@@ -728,7 +727,7 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#else
+
 struct imx_clk_setting imx_clk_settings[] = {
 	/*
 	 * Set A55 clk to 500M. This clock root is normally used as intermediate
@@ -762,9 +761,18 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#endif
 
-int clock_init(void)
+void bus_clock_init_low_drive(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx_clk_ld_settings); i++) {
+		ccm_clk_root_cfg(imx_clk_ld_settings[i].clk_root,
+				 imx_clk_ld_settings[i].src, imx_clk_ld_settings[i].div);
+	}
+}
+
+void bus_clock_init(void)
 {
 	int i;
 
@@ -772,9 +780,18 @@ int clock_init(void)
 		ccm_clk_root_cfg(imx_clk_settings[i].clk_root,
 				 imx_clk_settings[i].src, imx_clk_settings[i].div);
 	}
+}
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+int clock_init(void)
+{
+	int i;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
 		set_arm_clk(MHZ(900));
+	} else {
+		bus_clock_init();
+	}
 
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 5b0fada8295..a55863bf456 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -607,11 +607,99 @@ int arch_misc_init(void)
 	return 0;
 }
 
+struct low_drive_freq_entry {
+	const char *node_path;
+	u32 clk;
+	u32 new_rate;
+};
+
+static int low_drive_fdt_fix_clock(void *fdt, int node_off, u32 clk_index, u32 new_rate)
+{
+#define MAX_ASSIGNED_CLKS 8
+	int cnt, j;
+	u32 assignedclks[MAX_ASSIGNED_CLKS]; /* max 8 clocks*/
+
+	cnt = fdtdec_get_int_array_count(fdt, node_off, "assigned-clock-rates",
+					 assignedclks, MAX_ASSIGNED_CLKS);
+	if (cnt > 0) {
+		if (cnt <= clk_index)
+			return -ENOENT;
+
+		if (assignedclks[clk_index] <= new_rate)
+			return 0;
+
+		assignedclks[clk_index] = new_rate;
+		for (j = 0; j < cnt; j++)
+			assignedclks[j] = cpu_to_fdt32(assignedclks[j]);
+
+		return fdt_setprop(fdt, node_off, "assigned-clock-rates", &assignedclks,
+				   cnt * sizeof(u32));
+	}
+
+	return -ENOENT;
+}
+
+static int low_drive_freq_update(void *blob)
+{
+	int nodeoff, ret;
+	int i;
+
+	/* Update kernel dtb clocks for low drive mode */
+	struct low_drive_freq_entry table[] = {
+		{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(table); i++) {
+		nodeoff = fdt_path_offset(blob, table[i].node_path);
+		if (nodeoff >= 0) {
+			ret = low_drive_fdt_fix_clock(blob, nodeoff, table[i].clk,
+						      table[i].new_rate);
+			if (!ret)
+				printf("%s freq updated\n", table[i].node_path);
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_FIXUP
+#ifndef CONFIG_SPL_BUILD
+int board_fix_fdt(void *fdt)
+{
+	/* Update dtb clocks for low drive mode */
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		int nodeoff;
+		int i;
+
+		struct low_drive_freq_entry table[] = {
+			{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+		};
+
+		for (i = 0; i < ARRAY_SIZE(table); i++) {
+			nodeoff = fdt_path_offset(fdt, table[i].node_path);
+			if (nodeoff >= 0)
+				low_drive_fdt_fix_clock(fdt, nodeoff, table[i].clk,
+							table[i].new_rate);
+		}
+	}
+
+	return 0;
+}
+#endif
+#endif
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		low_drive_freq_update(blob);
+
 	return 0;
 }
 
@@ -935,3 +1023,22 @@ int psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
 
 	return 0;
 }
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx93()) {
+		if (speed == 1700000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else if (speed == 900000000 || speed == 800000000)
+			voltage = VOLT_LOW_DRIVE;
+		else
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e5807134bb2..e4999baa95f 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -77,7 +77,7 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		/* 0.75v for Low drive mode
 		 */
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);

-- 
2.35.3

