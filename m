Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E31D6554E
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 11:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A696839FA;
	Wed, 17 Dec 2025 12:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UBWtKz+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD7F83AA0; Wed, 17 Dec 2025 12:13:31 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21A483979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 12:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc11wKhxR4pI9sCqlnOaZ5PDr3H0DRnrJYyzzaUvua5H+wQXBXDaDNI//4kUFBqqtnUmYo/SoBXLytm/c+/57TavpeqI6yk1nvnI3f2DKUOGbpeDh1Z7EtJbXkqVYI3Nc4V7zluZejAfrGTH2bwU3PMJ4uGg7thjRUAaU8PZdLzOwLtmrBTKcFx9wNzIQnJyFj8Xgpph9Cvsnc+T2o4Sfd3Ocd+2l8XF0WBrE41Qto5I55gghE2H29/K9YjCEy38UcbDYZt+6TigOMQJa0uIAxWItS5hmECmWGl9x6GD0dtq8ep0aOskadXNDFK559p+hRDPEHoVVmp40rllbYtyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snOVGuEue5emTw7SXICmFvEVkba8VX62b+NWutr71M4=;
 b=oqtgPM4wMO8p9aoohfJTtZKQBSKzHPKJVmzrxpq3MQhojN14zE0r680wF7s1d3+hbW9kjmPxI4MJME9/kmN/LZFIq7BbTrNfPQa9BZsZWkXBy1eRQxrHywMTfM4asQI52FcydrHmiyn3BoiNv0Tl04MI9ORvZVU8bItvMfhXnnhzm0B82mvtSxSvXWo2WdSke3D0Y1NGzx5xaagWdiaok6gGCTUZOEYsXbAGX9iupZ2RegviUXahQ7fzo3K7cgwEcOYQWZaMHGSgZEwAdDFE2mju640cbEzS/SD7m78oI5PeO07Vk9Aq5YFFguCqCEgr/L/8vK7oC92Jl6g1fYjZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snOVGuEue5emTw7SXICmFvEVkba8VX62b+NWutr71M4=;
 b=UBWtKz+7qXxjmgMKkhp7FCK1KITS49D0N9QToPUBC+VeMOOQEG4FBjbZ+f7Jy1vbW02OQkg33KXtzNZphfx15SlERMhsj01T2kPulD6ADtpOD6lhakMtcvXRWUtC+7Judb3Gkje026rc7jF3VcKbq4a8CgBcUtuK2VkPFjPguR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 11:13:25 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 11:13:25 +0000
Message-ID: <8a7bdb38-6bce-4130-bda7-1a3008ae852a@cherry.de>
Date: Wed, 17 Dec 2025 12:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
 <b729be6e-3091-4aa1-af7b-266a94bbcc66@kwiboo.se>
 <7286807c-3846-4b15-bf20-deaae13d25ce@cherry.de>
 <f5f29e68-aa8f-4534-bc3c-d50b02f0e495@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f5f29e68-aa8f-4534-bc3c-d50b02f0e495@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: d3679948-3f7b-4ea5-a7e3-08de3d5d4c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWU5YnVzM25oYVNVWU15M1M1MVpsWUdYcGtGUGVmc2g0VVRXM0tKNFpWNUJY?=
 =?utf-8?B?Undad1lLUHhWNENZNThOb3diM0t4cDYxWmpoYTRZZjUvOXlKbko5d2xsZVNN?=
 =?utf-8?B?VUppVWp6aUM0N2EzMWIzeGt2cnZxUUpPdVNQYzRNdU82d1ZwalJNNzh4MGY5?=
 =?utf-8?B?ZFlpYTVsQXFMMU4zenNDa0lEempnbDY3MmtBVmtRalpHZDhXcm9SVEpySHU0?=
 =?utf-8?B?M0NidVUwb2RwVUhtbjBuNjNqQVYydURPajgyQXFHUSs4SHI5WGFQK3VMQ3pC?=
 =?utf-8?B?YnlGSzkxWGF6OTlwVUtJVUhaZWpYcDgzWkhteGdYOWVwcFpsN3hlUzA5bTJK?=
 =?utf-8?B?U0p1emYzb2RnZ1RNRDU0bWZjRjdkYnh5N1cwRzBuWDVYRXRzQUFJVW4zVEJ6?=
 =?utf-8?B?MElBbVcvclVMd0RXcHlDbXpIMEUyRlVJb0pONllHYkE3NjFmdHJYd2xNNjJn?=
 =?utf-8?B?LzFmS3lDRUU1ZHUzVlJYQmtBMk5aTjdNMkhuVEpFZnAyb2VvSDF0cVM2SUxW?=
 =?utf-8?B?TkRlc2NFdjJib0lad3NPTVdYRTBYdGhtTGdVUys1YkVocmw1RmRJV0VBTlVF?=
 =?utf-8?B?bkVEaE82c0NSVTJkckIzSmFhbGNCYnkwUURTcWlBc2lhZlNtbTFjMkZrYnlx?=
 =?utf-8?B?b0hGcUFSNjlVRXZhaC8wWnFzRXhiOCtsSVo4S3E4b2R0anVORzdUVlRpdUhS?=
 =?utf-8?B?SmVuOEZiVkJLTnRKYVdHc20zaUdZMTIrUVl2OFM3TFRST3F4b1d4d1puMVVN?=
 =?utf-8?B?WjltdEhVQUlqN3hNY2Q1TzZra2VyUk5JWm8wdzhjc3pGV3FIVFhEdUdwWTdW?=
 =?utf-8?B?R09RdkxCZ1FtTDZvNHdkZm82dUhSNnpsaTUyUStibklKaXg3RWIrWnlTb1px?=
 =?utf-8?B?QUZiNGFQY1g0OTZvMnZjWUFnNk0wTGQxQjZ1c1pkWEdjRUN5bXZ5UUxxdmpN?=
 =?utf-8?B?YlhqUGtSRTRKQ0dZUkdNNXFTNnZoeTFON3pMcmN3eDNTZjdETDhVMGUzN1Nn?=
 =?utf-8?B?SCtYK0pTL3Vyam1HL21pMG1LZDhxMytzMFJJdEdmODNoNHA4SHlKS21OQ2ZW?=
 =?utf-8?B?TkhVQ1ZqVGZGYlJ0cW0yUnQ2dERDeVNwZ3JnMWRzeEtOa1ljTU5la3F0d1Jl?=
 =?utf-8?B?eGNzWlB2U2p6SmhSQXNqb0EvYzB4c01qeElYejlkY3lyeEYxSXlUOS9xTWVR?=
 =?utf-8?B?dUpLaFcyaDZLRTErNFpYYjcxS3ArMllKanIraHJwbkJiMEhBL0FFckZ4cEdQ?=
 =?utf-8?B?V1RaNUIwVUlCdUxGTHRnaWlPMEZJYW5PTWtCUGV3RlVKN1FIaklHK1dwa3hl?=
 =?utf-8?B?VC92NGw2YjZ4MTcvTUdqKzVONW9XZjQ0V2kvSlA0QkM1bHQxa25lNHJnVGhi?=
 =?utf-8?B?dmordUtvYmdtWWRXeU9ZUE13Q052SGZERUJoSnJWekYyU1dTNmhRSDhnY0RI?=
 =?utf-8?B?NUt3UWFocGJlOERPRUtUT2VTaVdmUkRpUnk4Z0hYZFdNaGR0N1crVlZCa1Bq?=
 =?utf-8?B?WVJkVzMwaE5aUGFpY2psTHV1UWJROXB5ZWNIcTRBbm9vVDlGMVYxcXFvUk1s?=
 =?utf-8?B?eXZHKzZodERyWTBma2dPUWtOQVk2ZS94RlVOMENDYTJOV1psSHRLeGFJM3FP?=
 =?utf-8?B?R0NBOVFVVi9MRGk1bk5Rdm4vMkt5dURsZ2t2aTBSS3N1Um5tZGsyWDhDV1cv?=
 =?utf-8?B?MXczMzhDaWIxY0NFOHZXYzlRaUpzM3hMY0xENXFGTGdITWxIL3N3dlJtcFE3?=
 =?utf-8?B?NWduak02MCtlcnlHMlg0ZzRWTzhnbjc3N0hiL2ZER2c0Mm8zcDRObjdabzdN?=
 =?utf-8?B?R0w1U2RmaWUzS2JwYWNNNXdNN0VUTlJ0UmtKZEVxZ2FLZFZYQUdUb0pOUlZn?=
 =?utf-8?B?U3RBYjh1SzRSNkVqbGN3UzdFUll0dHhEUXE1bTBId0FZSjlDMENmL1dXMjlJ?=
 =?utf-8?Q?nP/pb46MNc+cW8FAjxMl08bw2Fyp6xqN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhkZDV0TnhwNDIwZk5YVzYxNmtmeFROckpYTHpwUWxzOVU3ME9RaFVQUmNn?=
 =?utf-8?B?YmNON3BLS0J1amk3aEZQT0l0VGVyc2hDUWRxd2NoNUl5RHd2dlF6TXllTisz?=
 =?utf-8?B?cmNKbEozb2xlQ3RyRkRzR0ZLR1ROb0VEejFhbUlRN0VVVXJBeHl2VFRHSVF1?=
 =?utf-8?B?UitBRzdvQXRCUG5saEtpQVAzcTdCYzVqckEwTmVWdXJYaklxNUIydHQySXla?=
 =?utf-8?B?eE1udDUvOStvTkEvNWhQeWR3RGRydE5iQnRuOUZ0RHNnRHY2WXNjb0JpT2xQ?=
 =?utf-8?B?bHlKZWlmOWQvemZ1d3Q2U3BBUWVLOERNUWM3MHJMZGZpeEZyb2ZmQXByTHFw?=
 =?utf-8?B?MXgzd0dTZm9SOHZ3VGszeVhSYXVPY09tRFJwTWdzZFFxcTF2YlJ4eDRIS2Ja?=
 =?utf-8?B?VnkzdkJhSW9FMVE4TTZCTUxLbXlQRkdMWU5wNnBWQVptQUxSaEkweExEWXJF?=
 =?utf-8?B?NkZMSnRzeFRDVCtlOWR6VHE1QTc5bmZiTzVyajBjK3FYZE5la0NocFNJS0Zn?=
 =?utf-8?B?eVgycjcvL2dtQXhwVXZDeHplVnp3S1VmWDVwN3NRMm51dXpoN2hPOElVNDBT?=
 =?utf-8?B?ZGZiUDNiclBSVTlvbHZVdHgwcWhub1NjcllDSi9XaXdEdWVXc1UxMUl1UkJ2?=
 =?utf-8?B?dDd6SVh6K0ZmM2Zra3hjOEo5R2Y1TXJ0aVJ1T21wekMwNGltYWh0RTRjWDJ4?=
 =?utf-8?B?azJZNnZQWGFZNVVLR3JWSkpUZzhQTmZJREZENWJ4VzY4QU9CRGZveWtDczVF?=
 =?utf-8?B?VUsxSnhUWmFxcERtektIVWxLNE9QS2NMcTgrM3Q2dFVOWkRTejlTZDhHODFN?=
 =?utf-8?B?TjladGx3bHBNdTYvbEVqL09ra25NRXJYL2U4M1Q1emZESkZEbjgxVTEvUXkx?=
 =?utf-8?B?dUc1OUVaUUhCK3JNYUwwY0RwSjUzZHRkQStjZ3dYc1BxUEZ4UDJxNnNTdFhp?=
 =?utf-8?B?R3JlYlVYNkxXNGlzczhwZmRKaHY5OWxUaFJuaUt0Y0NLVXRPS2VBOEdTUWFG?=
 =?utf-8?B?cy8xcS8wUWlFdHZ1aDk5UlpsMG1aaGJlQndxZkp2M0xjaTREYTV1TmNldGEw?=
 =?utf-8?B?Z29LeTFEM2M4bm5CZ2pnT0xZV0w5UkptMzJ5eVJOd3U3MHBVcEVEcExZS1NV?=
 =?utf-8?B?K0NQdlhUUXY5ZU1tVHZCc3dhM0dPQVhBdmlPYXVIWUxXak5qdXR3SThJSVdE?=
 =?utf-8?B?SEVhOFEyRW52NDhVZnhYVlZIY0czVW1vcXRyS09KVnI3UHRMMWFQVkNqbWNp?=
 =?utf-8?B?R2VrN1RKdklnVUhhMVZtZlNERDZWMW1BUjlDenF0WHJVejQ2SXl0bHJVVndZ?=
 =?utf-8?B?LzE0cERNOGR5MGoreTQ5WjVqZjVub04rdUt2MlZTYTk4V2NVVXp6cGdtZDA4?=
 =?utf-8?B?bWVIUERWYlRRUXVOck5EZ2h6OEwyVjNJSnpVSXJlbVNkeFZTVENVZ2RCcjdK?=
 =?utf-8?B?MVN1Q2tWNzl5WXJyQWU0TGdHMmRhczRLZ3QwV2FiQURLNlNTZGZMTGJDYU9T?=
 =?utf-8?B?T082VlUvMXNPT0Y4dVErTVUrTHlaQkZzQWh4SzFCazgxOUZuUzV5KytyRmdu?=
 =?utf-8?B?YUl4RHBTeDdlNHEwNFRPSDRadkxRWHVXSmNlQ3VZS2g3UUYrZHExdnp6WHBZ?=
 =?utf-8?B?T3g4YXRBSFFMeFNVb0FDYW5udU55RUF5d0xMcXpwRS8xU0FVN0U1a0FDMXFM?=
 =?utf-8?B?QytNYVBwMlBvU3Y2RXdWSjBZNldCellPcHhjN04ycU1NUTA4b3l6Rit3Qmtu?=
 =?utf-8?B?NzdQTXlSTTFWb1Ftb1ZkVjdNd2N1SkMrc3lWZjNpaDBEd0ZhZ1lDMnprN0p4?=
 =?utf-8?B?cXBUdVhRZzQxRTNwYU92ajhHQUw4c1ZrR05saGNBWnFzL0h1VWlJck5ESXNk?=
 =?utf-8?B?QU5ZNCt1emNFQlVrem1ZYi9lazV5VkI3b2UyUEpiTVV6Nm0rZTgxZENRWGx1?=
 =?utf-8?B?a1ZXbUZqa0lxZHN1TlBFTVBYREw1Qm52dndGc0pBR2RWNERGZkFMc2ZQaHhy?=
 =?utf-8?B?aHJlOTdaZzFXRE9lYnJ5VE9FbzdFRFM5VDk4cEZNTkM4ZzloVlRhVzBlZDYx?=
 =?utf-8?B?eW56dUN5T3J4S2EyeEViQXNONHJsbm9pMzBoYnFyYVZxQjVPUVZqNk9qMFJE?=
 =?utf-8?B?OGZXUHFpNkx3RVY1YW5FUDVWZkJ3clJOMGc1TWZvRkRIZnF3SkRGQU8vaEJu?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d3679948-3f7b-4ea5-a7e3-08de3d5d4c72
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 11:13:25.8221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW+gBekrsp11nXZJV/+bPYtb0uW4Qgusk3rFCDTeYxyClCOuD5UkdXtMcMirzSCIoYbUH6hk6s0uONfVNrnYNqQnhGTUF2PQsY+q1HQXcdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415
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

Hi Jonas,

On 12/16/25 6:57 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 12/16/2025 5:35 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 12/16/25 5:11 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 12/16/2025 12:26 PM, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> I believe (hope) that the new SoCs should now have this fixed and not
>>>> require the "hack" implemented in rkspi format which almost doubles the
>>>> size of TPL+SPL (idbloader.img).
>>>>
>>>> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
>>>> to the DTS setting the mkimage format for the SPI's idbloader.img to
>>>> rksd explicitly).
>>>>
>>>> Since I do not have any board with a bootable SPI flash except on RK3399
>>>> where this work-around is required, I simply invert the logic by having
>>>> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
>>>> that did. It doesn't mean that the SoC actually requires rkspi format,
>>>> just that it's been the case until now (maybe because nobody tested).
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>>>>    arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>>>>    arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>>>>    arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>>>>    arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>>>>    arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>>>>    arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>>>>    arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>>>>    arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>>>>    arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>>>>    arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>>>>    19 files changed, 157 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
>>>> index 2f726b0aaba..7385de7d6ae 100644
>>>> --- a/arch/arm/dts/px30-u-boot.dtsi
>>>> +++ b/arch/arm/dts/px30-u-boot.dtsi
>>>> @@ -27,6 +27,18 @@
>>>>    	};
>>>>    };
>>>>    
>>>> +#ifdef CONFIG_SPL
>>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>>> +&binman {
>>>> +	simple-bin-spi {
>>>> +		mkimage {
>>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>>>> +		};
>>>> +	};
>>>> +};
>>>> +#endif
>>>> +#endif
>>>
>>> This is probably wrong, rk3326 use rksd format.
>>>
>>
>> Yes, in v1 I said[1] they probably are the same, but I cannot test it so
>> I leave it as it is today. This patch does NOT aim at fixing anything,
>> it is simply inverting the logic such that for any *newly* supported
>> SoC, the default will be rksd format for SPI booting, and not rkspi. For
>> current support, nothing is changed in this commit, if it currently uses
>> rkspi (as is the default if unspecified in SoC DTSI), then it'll
>> explicitly specify rkspi in the SoC DTSI now that rksd will be the
>> default. If it is using the wrong format, it already is and thus can be
>> changed in a separate commit. This is intended to be a zero-sum change!
> 
> For boards of most of the SoCs that you flip to add use of rkspi in

I don't add use of rkspi, it already is using rkspi.

[...]

> Adding the possible correct use of rkspi/rksd gives a false sense that
> SPI flash is expected to work for the other socs.
> 

So is being able to set ROCKCHIP_SPI_IMAGE=y with menuconfig for SoCs we 
don't have the necessary stuff to fully boot from SPI. Though I assume 
we could have idbloader.img from SPI and then fallback to other 
supported media (MMC) even if fulling booting from SPI isn't supported yet.

>>
>> [1]
>> https://lore.kernel.org/u-boot/5f45b4ed-d01e-41f8-a05e-c617039228e0@cherry.de/
>>
>>> Also seeing how the rk3308 has a later model number than PX30/RK3326
>>> I would guess that this also applies to RK3308.
>>>
>>
>> /me shrugs. Not tested, won't guess, not worth it.
> 
> I have been told that this 2k for each 4k page read bug should have been
> fixed sometime after rk3399, so far this has been true based on my
> observation, especially for socs using sfc/fspi controller.
> Unfortunately I have no reference to provide.
> 

I've asked which SoCs are impacted by this "quirk" multiple times on 
this ML but never got an answer from Rockchip people. This would make 
everything so much easier.

This patch is pretty clear in what it is doing. I can add a comment in 
each untested SoC specifying we don't know if this is working so that 
people will not be confused as you claim they will. I will not be doing 
a partial patch. I believe this patch is useful to avoid having to do 
what you're doing for every new SoC where we need to add to its DTSI an 
args property to mkimage to change from rkspi to rksd format for the 
bootable SPI image.

This has been the case for years now, so if there's no consensus, I 
guess we can just keep doing this for every new SoC, it isn't a big deal 
to me. Patch 1 and 3 can still be applied individually regardless of 
patch 2.

Cheers,
Quentin
