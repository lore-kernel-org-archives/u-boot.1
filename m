Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D0C48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B347F87C68;
	Fri,  2 Feb 2024 16:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EBBhDxsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E924F87527; Fri,  2 Feb 2024 16:13:43 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A225F87B8C
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C47C5yu9YoXgBiVag4HxFdGX2uScL8c1lSOcHJ4gC9JmrX5vhSorexBZ7XFabyOBHVcyRHQ/ttYb8Gd2+XQqjTlpac+xZtsFPReIhnuZnE56auw7DDT4MqCOOowu1wcSwn3eT3T7klPaZRjwb+9zRSZ4NbTgvy+Ai/gPYkcUomLmPS66+iOJ20XZ7dBabiC3wPz+D7EdRP/gKqNetLvO4Wo5YK3zuWAXMIaQGhmSpWEv6cFwV7uKvPzpHenAsSegqhiu1x3GmLBn20UyznaokEM/laIQuFhM89rB6sPn+DhUDlJKrEMR7rJcOuzuWqQFSyIk1YvWcYrH4JTXNG4Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkMHqHHmUnObYFdD5eWf4xcOkNseicLTMTji/U6BSTQ=;
 b=KWtcsvCIqSCUewQ4aETtCdkXZy/IOSPk5plej4KQ1l8lmxkABKcOTIyQTvSVod5Yzst+J4synQwn0sv2Jv2NjRxSs4Hue8EdO+8oBnQHcNiPuVJIXBMUjBdpk8NdFbNCwzCPDf8ft4lDK3TQ36pmf+NSUZGytNJF4tEtw+axHSC/Hlqp1BgRja63V5EVnuKFpBiJ3dDnoe5tdUZySvyowX9jAJyVhQhUYqSbTW+XBAh3d4qZjP0+H9qqG0NdQlkOVwj8Ed0vFRgfFw3DjfTM5PC/eyuz8wxHM63sn9p90CboVg+hdSqe+L3mZl1DdqWxM2Z3LTMnatfV430/cLWX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkMHqHHmUnObYFdD5eWf4xcOkNseicLTMTji/U6BSTQ=;
 b=EBBhDxsGnPkEOIp0mo2rXZB6Vt89FoResehhOFpTDnv9B3n03a2IRx5331W9KkQuhlhXghcusi/MZfsg+XMb1MJbALr4GscYXM10BXLYXBNNb+vFg//GRrM6hRw8bUmjmlOEJq+Ff807gQf4ZdSTUUhMvYOYUVmQc56vloz1Bn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 15:13:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:13:39 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 0/3] arm: mvebu: helios-4: add config fragment for spi
 booting et al
Date: Fri, 02 Feb 2024 16:13:31 +0100
Message-Id: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsGvWUC/23MQQ6CMBCF4auQWTumLQWNK+5hWJQy2kmQko42G
 sLdraxd/i953wpCiUngUq2QKLNwnEuYQwU+uPlOyGNpMMpYpXWNgSaOYlEWRm2tOjdeDYM/QXk
 siW783rVrXzqwPGP67HjWv/W/kzUqNK5p29ppRa3rJE48YnrNRx8f0G/b9gVMQFJqqgAAAA==
To: Dennis Gilmore <dgilmore@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: bec6580c-b6d9-4919-9718-08dc240188e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12uxfGH48KN2TRA6812oDKlQ1x7QuBD7CQQ+3gkZKF5M/QySx1fjQP//vSa/F+vCrEX82xeBHybspdIdd+bug1uT7wpgM6YAoewNI7LkTfXsL2memLsbutpMYe265OGtqlPsZYmkOfk1qsgUDM/gQU98xBa2n1l8bWbKwrV6EuGHuwDts8KHcO6jiXI8AxbcQtNBxQbvCrYC7HjPqOgSVRHjhtlFfxpNCoCkVou4jbTnjxlucsabheePg4hbO4PAPY5d4DzB6WDyvm6cw6y3w4XEHFUCVgJbMachW31vY8Ihfp7i+uWgrh9OA9W7WJ70/lO04bBZpnoGPG0QYtwzJwEvepkCd+3Rudi99BuhHbS/9bxArJM1sIjFk+u/6F+XNLjrvMbSw8h0H+aQQ+I4TcAEkYWVtHQB+85s22CurwXHXdr0mtScCdud6P0P1zBPbq9FbzCVSQr+RGeA5f4c0gvBVjFdZO8VyKIuwwq388pMl95lqe3gmMYlPYTovRY52AKmYj53DMPkpLOUC94ui+oTRGX1DncY0xKGeVPSL6R4ap6o6ryVWEt9zHfHwSRECk3o4AsDZ8Y7A1cMFOSmZBGH3sBb+UOlR8Kc6AqJkEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(54906003)(110136005)(38100700002)(26005)(107886003)(41300700001)(83380400001)(6506007)(6666004)(2616005)(6512007)(52116002)(5660300002)(2906002)(8676002)(4326008)(8936002)(4744005)(316002)(66556008)(478600001)(6486002)(966005)(86362001)(66476007)(36756003)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znh6RHZsZEV1UDdLaEYxYk9Wc2d6YlRFK0htV2dGaHBHd3BGbWtidU5FUDJJ?=
 =?utf-8?B?V3ZUR3VVaUs0T21QLzV1bzlLMWR2M2YxeG1yUnZ6VGYwM2dGZU15YUxVOWRN?=
 =?utf-8?B?dHkzM0pzbmswckRaMTBZbldhUTkvUXE2cWYxVGRabFc1OXU3SHhnaFZtMHZK?=
 =?utf-8?B?TzZUNFNpWjlmQVFQMHU0TVFPY0V4bGJObW9QcjJsRHB4am9EMjhWQkFZVGpE?=
 =?utf-8?B?K0NxWDdmdENlK0txQUlzYUEydXcvZU1PU1ZvRXh1VFNtQmQ0emh0RE41UGQ1?=
 =?utf-8?B?UmhxbWNPRTNqV3VLenZkcTBNZ1JrUzhWRHlDTmY0K1g4TGdzTER6QTk1dmJk?=
 =?utf-8?B?OHg3RkdoU0NNSXZiamRuNkF1a2luRWdUd0VnaHBOaktMT01TNzVPbnEzb042?=
 =?utf-8?B?aStYdzU3bEFMSXFodWxHcEszYzFuV0xORE5kSjFUNW4wcVNsRk8xK0Jvd1I2?=
 =?utf-8?B?M1dEWnVDTnJzcVV3cVFqRTJ5WGtPdWFyWHB1aGZLOFRPWjU5SjZpSHU3Mm5H?=
 =?utf-8?B?RVkzR0RwM01rQytKSkxmTE1SSUdDM25DK2NrTCsrSFhScGpFZWoxMmlXbzJV?=
 =?utf-8?B?eWZrR2lJcGxyNFp0RVBoMjlyVzd2a05XUll4NjRnWkdvdEY4L0JlYkkwUDZi?=
 =?utf-8?B?L0FpK0VLTFNuaUJVM3oySTZkaXpoNExURGhOMVV3djcwK3V3YlFJcEEvOUto?=
 =?utf-8?B?Z1dYTFlwSStjMUtlVncreFhpdnBMUFM0QnQyT2tEQTlCNnBRdVVZNXhNTHlS?=
 =?utf-8?B?Sm10NjcwdGNIRGZ0WkhhR2hvOURscEVZc3UwcWV6MTFKbW9SSGgvVVdrbGhK?=
 =?utf-8?B?cEU4OU9YU0RrZG15WEw5ZXlpaDVuNUVZMnhza0tSTGdiczBOaDZmOWNtQ3J4?=
 =?utf-8?B?OVRiZjBoa1o2bmJ2RlVUNXZ5c0lJeml1MHB5Rm91Njh1NUtQdE45NkUrc1Z4?=
 =?utf-8?B?TVRrUWxMTlBvMmcyQWRRZUVqVm5wUC96U1RJd1dFcTlBM1FNRFpyMkgrWW1t?=
 =?utf-8?B?YXNSZWlML0RIYzJWY0RZbW9iLzY3R3VoUFNIRXRtNVdVazFwNUpFUmd0MWJj?=
 =?utf-8?B?Yk4wSTZjV01PNU42R3Q1N2hLVmlVMXZ6aWJQSElsc0lHRDJ1Tlc2WURNNUgx?=
 =?utf-8?B?Y0ZNcW11VXpNbUVXdjZLdDBadEs3dlFzbitGWG5XdDZtSFhpbUo3WXcvUkxi?=
 =?utf-8?B?aW9PQytTZEJvOTZ5MjVta29tbFRCRm9rbjh2Z21yeVdWYXgyNExvOEJHNCs4?=
 =?utf-8?B?Z2NBUnBvcTFRZURLTU5Ea3E3dXdacTBMQTR4dHZaY1ZnVzVUZHg3OStibmtY?=
 =?utf-8?B?Qm5OODBpejJEV0VpYXdpSlJUYnpuMWhEK1VYSlhnYUU0ck0wVVBjL1NPSkVB?=
 =?utf-8?B?OUVsbWlDZWtQQ3BoaTlPODdpWVUxcDVOOU1NNzltZ045MTVGOFVOeENEajFk?=
 =?utf-8?B?R3VhQ1IzZGE4cXhCOHM1M0RZdkpLdENnS3VRZngyTTd1SFkzSml1bFk4NG8y?=
 =?utf-8?B?M1pTSmxtaEZheGlVOGkxYjZDZXdzNENCbDdocytHTjhDU0p3MklOMGlpTGc1?=
 =?utf-8?B?RjRxcmQzUGRieDgyUUU5Wkk2eXRJNVVMMUNHL25ObWlBZGtTblk5L2RPSVNR?=
 =?utf-8?B?dGFJdVBGcmtKZkk5S0IrUk5RelpMUFVxYUVOWlNlNGFBNlhVT2ZGTmc3VVdX?=
 =?utf-8?B?cEd3bHkyYmxWbDRMVy8zYzdUVUhVK2NaZ25wb3JDdDAycFZvbFpjMlh0S0xH?=
 =?utf-8?B?L3d4VUhjRVhyNXppWjBuKzhrb2ZndXIxeVpjVFhETU41TWtCR3p3dVBhYVFj?=
 =?utf-8?B?SWwxc0hNOUd4UGUrWE9TdXU1UEJUNnB6aVRwS21QYjRaczg5aUxYRHoyazNG?=
 =?utf-8?B?NnJNWmQ1cnpBajljOWQ2UWNCME16VlVZbXBPNXBGMS90K0VPd2lqZm4xc0U1?=
 =?utf-8?B?bTJ2VVEvT1BKSHM4N2UxWFZvelRGeSt3VUpYSmVqN0s1VXlLYkFlcC9RMDNn?=
 =?utf-8?B?YkErRlFCakJZcUtWTTU4dnB3dE9GenZMWmhYOUp6amZJWkxnTllFYStyWFNZ?=
 =?utf-8?B?UkRXd1hQanRxemVrK2hDU1NzYWhLS3F4eWZKY1VFN1l3VzU3bmdtUUZYRlQ3?=
 =?utf-8?Q?OC0HQQotfkjkItBN61YEYJpmL?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec6580c-b6d9-4919-9718-08dc240188e3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:13:39.2294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5wKjRdLYazwqnlF6+Is07u+12PH24PnS4gsM/yRCC6Sn/CLLZ855l3hByzXDlTYkyfO+SCkYJOZFXBTvwvxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
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

This patch-set introduces a new config fragment for spi booting on kobol
helios-4.

Additionally add minor update for default defconfig to enable setexpr
command, and fix u-boot command access to i2c0 bus.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- replaced new defconfig with config fragment in board directory
  (suggested by Tom Rini <trini@konsulko.com>)
- Link to v1: https://lore.kernel.org/r/20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com

---
Josua Mayer (3):
      arm: dts: armada-38x-solidrun-microsom: configure i2c0 bus
      arm: mvebu: helios4_defconfig: enable setexpr command
      board: helios-4: add config fragment for spi booting

 arch/arm/dts/armada-38x-solidrun-microsom.dtsi | 5 +++++
 board/kobol/helios4/spiboot.config             | 4 ++++
 configs/helios4_defconfig                      | 1 -
 3 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 050a9b981d6a835133521b599be3ae189ce70f41
change-id: 20240113-helios4-spi-144085c0bbc7

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>

