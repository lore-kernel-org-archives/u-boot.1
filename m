Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE7DC4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 16:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAC88794A;
	Sat, 13 Jan 2024 17:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="MoCOpH5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D0087976; Sat, 13 Jan 2024 17:37:19 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432D687946
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 17:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OInF3Kc/YUPtOFYZm5Dex6G5t3+KmOwERQqk2S91Lt0aRZrNfounkIZgDYe+2/3io+C5KQJ10wwNRViIbaVI4/TJGjAqz1f5yA6hQ8rxbuFqiyNKs6QPiNdSDgWWSDlynoqnIXAvvUlF2sUEa0TMNFLRV+R0EQdDlMDpwfayRJHPbpkk/g35NZsMSuKGPTkluZ1SvELl59Q8UAdnmO8lkeQT+Cj6eHRQLfdjcXZ9B9EfEKAkOEHe7NB+KM3mJUXyy+vgBIc/7dfpo/csuIWGXgCT7/c+Vke/QJv71PFaRhiEgeXshU5+CaNJRfwEqTwhi5XBXqO0F3EZpN4lytujeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T0aqKwh6JzXVbpDeGwDFXd1miwSLZpKL7gt/LCQwyQ=;
 b=JY+4pQ4CnRUm7wCeBaIq/h8N3mW7F6gkfNIg9emAam4hknWEqG1DiGLvHgwMZpGzQVpKE5h/UrkdRh567zHx/3D+Xec1F9BNFEsu1O3AZ+ezzNexMXAIbeOXDP7ETeQRHR5x5L4tsSFLl57u93aEqXxtMTsCcHr/BT4onOfISpL6DKt5uubxAnkkl0E9pM9kANi0LnUj8cxBctaBXnCim8l7+cVyyh0GKkZye9KZaIO59od6QeDk7hfPjqCAJfw5JTSW5y5iXnsh6+7GBdwrGxxlqgCrYzZ8zwE4gBEFSTIl9HiyTwO3slURRzu6pjtIGc5Qnhr+904ri2rmtJDJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T0aqKwh6JzXVbpDeGwDFXd1miwSLZpKL7gt/LCQwyQ=;
 b=MoCOpH5uER8esslxCO6VT4bbpt4B7K92avrFH6IQsdKwXWOdLb20fi3blrQu4v1yD/oHrJm1V6aOSxfOV9PvYt7mWMI/HqxECEwGgjFLyUK8tLLk06WjXpi3vQaGyxyhEcKAVz5+clTL6DqnD8frbnmNMRb7dIFnobOJF/9us7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 16:37:13 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 16:37:13 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/3] arm: mvebu: helios-4: add defconfig forspi booting et al
Date: Sat, 13 Jan 2024 17:36:54 +0100
Message-Id: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACa8omUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Nj3YzUnMz8YhPd4oJMXUMTEwML02SDpKRkcyWgjoKi1LTMCrBp0bG
 1tQBr+TtZXQAAAA==
To: Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d878bc1-8a3e-425b-bd95-08dc1455e53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gOSRW6/3WkYfG4eGUF87MAbxOGXyKuxXBsw3uB7NaL+tHtvC9pvl1dvqQAh69SWXv3GKVhSSrESsZb6UIXnx7h2x6hv7vlqgmf6OZLFKznWxySFEz1CRuI2fByMjVm49fqkcfqwBUAE3WmQz0b/Ytot1hzl0L3O6HSvf1xT8YIpgpmAbbm+7KdoVBWux+3bWLF4K2JPKWY9slVaS3Ss3+t1Z0ubQG2i7XmKywshCxRkk8xS5LMc05vARn1K11OiCDQK9Trpyx/MJslVM3onww+L/5i+5APyXh0VjL7wxoruuOoiqBizPkrYpxoj+5bnmonhLDYpa6j9k0tDXQHoIhQCLe/WteEvjUB3DLTVypfgiwjpFFTqpO9+NPCg1wShJZTNdsxvC+8bMozrhNLk50VCs8FP0285Kpf6LE0D8BQz4kQAz+1LgRZIrUkMm9TkOLTnYUNVZJnWbT3ibBmCRvmD3Rt0l8ax0H9mhjKuLG75WQdgNIqAzWwGR1C5HWB94GY6c3mwiyxDwg051EBoxRQTtmniV9aG2niSPS6+99ddBNHgjOpDtlHJw262Ad7jeutJoYByU3wv4O4smbsg/v6cSX6Fk++Gl+0G9/Kz69yoPQdK51RGcTl0jmvGptpS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4744005)(2906002)(5660300002)(52116002)(4326008)(8676002)(8936002)(66476007)(6916009)(316002)(6512007)(41300700001)(38100700002)(6506007)(6486002)(66556008)(66946007)(6666004)(2616005)(36756003)(86362001)(83380400001)(107886003)(26005)(478600001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm8xRElKN3F4R1poZGJtMHJwY213WjJ6SHdzSU1aSzg4UXY2M0hyRi9EWTJi?=
 =?utf-8?B?QldUWUUxVWZaTFhHbjY5c0JXdGVkQzVyTVBrUzFMYnlKOWZSajBSVDFSVHd0?=
 =?utf-8?B?TUxUbjRxZ01jL25rUVdCWXZCbmczQ3M5ak1FNEd3bElTUDN2dXB6cHRQYWlm?=
 =?utf-8?B?RSs5cHZnR2xySUo0aE5FVU50OTN6b2hjdjVTeC9SbitVM05CMmZKMkdDei9O?=
 =?utf-8?B?RjF4UlNDY1N1UC9qUzVmS3d4SFFwUzUwc3RQTXppN0luVEtRTTdGRWZ6ZXJw?=
 =?utf-8?B?SVhxYUJ1d0p6bzJXNEJWTms3c1poZUdPZHFrclVYbGJTNE5aRWdJd1FHN0s4?=
 =?utf-8?B?MHRYaWhHVFVCRUV0U0ZKMk54SVVzVW5FZlBiUVFENUFvV1kwVkpjNjBiQ1R2?=
 =?utf-8?B?Yy9BMUh1cXFJZ05lRmZrdCtzc1JCTEh4UWtmRnFtY2xrQ3VJZ2VKdFZqU3lm?=
 =?utf-8?B?eUR6eTRnT0pwMlV3YU55ZVMxWXZWbm1tVjFqTU4wVVdDK2N6eWxhZkhOd0x0?=
 =?utf-8?B?SCs3RFNock5vQWlBOENBK3VMcTJRQjVzeFhVQmQ4OTZHTGh5MEJONWErc001?=
 =?utf-8?B?K0ZFODBCcFA4Q1BuNjBXM2J6MFJxQUlHMEM3cnlUNTRDSWRRY0IwdnEwd1oy?=
 =?utf-8?B?UnVid0RCZGlyRVdqV0pDZ2lReFNYUkVlTDRKYWlRSENtYkd5RHF3WTY0WFMz?=
 =?utf-8?B?Qms3d0U4Z3h0SjhsT28xS1ZKOTlobEtOMWxTdk0zYnI4SWEvUHhNaW1zdU5a?=
 =?utf-8?B?Wnc1VzR0NldZYkZUb3paZ21MUXJ1VEJsQjhpTVhVRWVubFZLSVdoYUNpNTd1?=
 =?utf-8?B?cmQ5ZHNNdzNBZXVCejZpZXI1cVNidVp0RTlhN3l5cXd1M1F5a3haMklaVzVs?=
 =?utf-8?B?eFJkUkw2dUlKbGY3UHBRbDFFQ0Zaanc3MW82SFZHZHBqYm5jeE1aK3g4MCtR?=
 =?utf-8?B?ZWlJdUVFVDl1UWkwQkVkRWRGSXE2SlBnVnRsdENMTmxjbjY5RGc1YmdxMjBC?=
 =?utf-8?B?VUJRSkhxSDFmVVdJTzhibFUzOTJibm9Qa0Z1V2lqYUdwSExLR3B6VENrdWNv?=
 =?utf-8?B?cXRrbmVmR2tVeFkrbjNhN0Z6cU5SRVRZQlh2ekZZcFhHK1dxalRqNUFvdVU0?=
 =?utf-8?B?WTZsRloreFJQU2tORUc4dCtDRXNmTjdjeWRITEZDN2Z2OU85aFowWCs0Q2c3?=
 =?utf-8?B?cmlrSlcrajR0U1NkeTBibGVDQTJKMlZrWmZZb1JSbVY0bjdqcGZ3RzZrbXdu?=
 =?utf-8?B?QitodExObmxNbkFweTVzeXYvQmdqcitmbGQvalpNYkFueUJoUytPdElDWXZK?=
 =?utf-8?B?Q215T0c5R1BqYkp2aU8wN0xxRmdaMjVvRTB1N0J0eU9xMURVa3NLV1NDa2kr?=
 =?utf-8?B?OVpRUERIVjBhUU5yVzhDMTVIU20ranZZUVVldjFLS1ZVVkNlSWVDaVNNUzRN?=
 =?utf-8?B?aE1lR3p1Nlc3VVhHa0RRRXl5OUhsSTB5c1J5NTlUZkRmeEpOdkRFZjkxSFY2?=
 =?utf-8?B?OVVGSzlkclJHdEh5cHcrWS9KRUNHMlIzd0RkRXZaMEFVeSthTVllczgwa0w0?=
 =?utf-8?B?RUk5cXJwVUg2SkxySlZDLzVSczY2bmFxSXA5ZFNiSkZDdkEvcHYwQzcvWC8v?=
 =?utf-8?B?dHoxcmVCNnBuYmxYQ3FrdjVWd3U5amlWZUdLclo3dGRJRHRQZVIyRWRmQlBt?=
 =?utf-8?B?cFpSaVVJcmdUUlFmK0djdDBkZlVzZnA0elBTVENsR0FubFYyVU1GcW5OcUF6?=
 =?utf-8?B?YjlyS0VrVC9hS0Ruc0lER3F1K2pONTM1NUNJMHJ2RE55RmFzQnd4Yk1OeCtm?=
 =?utf-8?B?WGw2dmQrVDdadGZQYVdRY2JFSkpMUlFIN0tCNXk2REd4ZjkxSFZ0QllHMkp3?=
 =?utf-8?B?YWRwT1g4VDM0Qi90ckwwZ2x6bDhXYk5aS2h3d1lXQ0lOeWpDdWFkWWt4dFRx?=
 =?utf-8?B?bi8zcEFnc0h2b1VyNmxEOGhXTE1rK3FZNzYxZkpENUUxNmJpaktad2RFNWJQ?=
 =?utf-8?B?M1NHT3pRNmxzb3RsbHp1MWZkR2JneHBrdWpXdDBib3hxczg3M3BRQzUvakF4?=
 =?utf-8?B?alEwdTMzOHU5NWp5cGxqWXpMOTFhRnJhMDhEN0tpTmtRYmo3NG5Dbmg2cGhw?=
 =?utf-8?Q?T5b2ykR2PqhOtLD76epEombzh?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d878bc1-8a3e-425b-bd95-08dc1455e53c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 16:37:13.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ6S5w+uX364svUPgx+Ry5ek8hKyL83QFmU+4oo1LmGvTQF4dx7L47XIG3HNnVEXQt9QWt8XnHrcMnfm4YHGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567
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

This patch-set introduces a new defconfig for spi booting on kobol
helios-4.

Additionally add minor update for default defconfig to enable setexpr
command, and fix u-boot command access to i2c0 bus.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (3):
      arm: dts: armada-38x-solidrun-microsom: configure i2c0 bus
      arm: mvebu: helios4_defconfig: enable setexpr command
      arm: mvebu: helios-4: add defconfig for spi booting

 arch/arm/dts/armada-38x-solidrun-microsom.dtsi |  5 ++
 configs/helios4_defconfig                      |  1 -
 configs/helios4_spi_defconfig                  | 81 ++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
---
base-commit: 547d3dd28a46a18d59e00a153c8becca8d4e8cf9
change-id: 20240113-helios4-spi-144085c0bbc7

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>

