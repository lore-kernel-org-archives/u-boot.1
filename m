Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23233C48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5233F8753E;
	Fri,  2 Feb 2024 16:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="eVkkEzLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D0987C5A; Fri,  2 Feb 2024 16:13:43 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AE587527
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1hdDajFq1XRLg0y+qw2jRNL+dNqV1NjtcRDWpwAWC5N/KbR0eR+Vh4yKPij/JDbHaZC3rnTEDn3yUhDLmXYLgGKAMCyT/GRFsK+LcUYklD3KH4je47ugVjpwkB0q7eEYxSBOeJ5PVbhQwi2y8xuaLLgoVyVP44RvvbQoibOqYWUqIQxplMJsTOKnIToGY1/BUc5Pp5uQWLKIuJpDCURa8mKaB1M4JffwcCBreM+guGn6VxcUFR4/KjHHmkTyNQhZgHZ7jORlHl+sLEUP0F70OsqizuCehukYOPVrXUuep4BfLdUDUYvFbmx6h8YivLfX47gPfAj2MWYtSuuov0Avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZwN3kPi3qR5N7WheKRXqeYxC2J82C8zGyvtO4tHnLM=;
 b=Zv5YbZH3VIMagzvRACy9Oq3Z+yEvxbtL/JN0te4256TUPaYw4tA56RvHzPvkWsyzFIRPsY5zaYAoRvA16xFNq6kbti1znY6ylokN/cZ7R4OQ3Q+t/sXwYaCESmaKr3enYf7OzlM7m/+7nj3QdWfWLQeIJOj0LytH9JxLWpW2KH1elv8pgMOIAw6nz+jaFadtTkFXiSJumV9rpe8lGbKUr9okK1JYso0xOfqlKqkkVEccXdmAOaPHHR/ZzaLHesWxzV+HWM7Roy2YHE0AqktoeQlT3fSqgZVwgPM9RqEUKCEsPBptJfUFz33Cgvz36/FbxZs13wNVNWwbWZFP9ahFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZwN3kPi3qR5N7WheKRXqeYxC2J82C8zGyvtO4tHnLM=;
 b=eVkkEzLLNbGuislHA34V5Jkw3d8V1v+PXvjxR9aFGZvjxqVPjvNx+qWrHXabLHUU3wkMRG9ltPoZTmdTuVBafUeTY9VuhHKjO5G7MpsRIdad1WfIXx9Lp+7p5NniNZbv0VhStDVvHqgMVVNvEfvsMoP2f2KZ9FSQxdqXYNn8ge8=
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
Date: Fri, 02 Feb 2024 16:13:32 +0100
Subject: [PATCH v2 1/3] arm: dts: armada-38x-solidrun-microsom: configure
 i2c0 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-helios4-spi-v2-1-df085461d894@solid-run.com>
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
In-Reply-To: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebb6293b-f414-49e9-a473-08dc2401892b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqJegNT1aAJHTQRY5U4QPiQ8M/hU954ItskLaWg1JUW9GLDSDNx3/MfbMnKTqwHT3AtY3QWL+KV1SQTellqmMMYwYVp1w1PAWAuFKmHWgSywA5I63AJU5FJ61i4lO9iNDGE43GUU5LIJsgZwGMcLO3LrhsbcqvK7eOd2qyYq9BbfTDENmpeu/6KkQBwPJzsg8jf+wm+S9P5QhAv12PMDZXITqznCcF42pVuSGYrROY9tmplYSv7t/e2LDRh/oBQD6BsFa/HbfCDyxPUzH3mJswnMhBYqWcdjrBXZXx8RYgUUkJ4aNWyhLllfm/tfw3oncPROICnr7OSW9RvqMujAdIq1E6xA536QSVnodSxbxxQPJdPqQL1sGII8RjdzF+FHxGWsRF1LtB/8V/NB8CikdvUDdNyQivyCxeTneI0y3u1ifMVCNlJIJcMgDF/OvJwGueWjR29Spxo1lejtm/3i+otxnhjuwuhFngl16fgR7LXC/iYDVrpuqQ3TLU3hzT7p3xxVV9fnmKGR5cZFQrHdXhHe1uevfyo3te8LJ2tHJY0OlMJ7yD3Exu6vnNiCfMoi4cZmkGfnVIu9SMAm2wbbgTnlxW/abO0RVN7ynEKDND3sTyyy2OB0uxkNMcEZ0DEa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(54906003)(110136005)(38100700002)(26005)(107886003)(41300700001)(83380400001)(6506007)(6666004)(2616005)(6512007)(52116002)(5660300002)(2906002)(8676002)(4326008)(8936002)(4744005)(316002)(66556008)(478600001)(6486002)(86362001)(66476007)(36756003)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhKMzlaYzdYNitBcEkraWxNazZDUDZ4RkFSb0hYVHNCNWtEUTFVZkVPN3or?=
 =?utf-8?B?U1pzUnRBbVpLK2dHNGNaRWhKZjUrZUNMUlIyb3Jjb1pKVEtVMnEvUy9oelFw?=
 =?utf-8?B?NTNNOTArZ3dDT3A4SDNSY083MXVRMTdNbElPVzQvcGVsaDhxS0M3K285UlpX?=
 =?utf-8?B?ZkF3UlFlRGNUaXhKbVEwYzVBNFRURmdlQkhFM2FHakRvSkR6aEdMSHA0a210?=
 =?utf-8?B?Q3laZEIxdlpZcGd2UGp4aVJobytnSzJhTGsxU1BJdm5EaHVwT1FLZGxYWHJL?=
 =?utf-8?B?N3YyL253dGk4YTIwNXVqWWptU0tMaUs2SGRMeFFxZGM5aFVlcHZoSTBlZHNx?=
 =?utf-8?B?a29Yb2xzTmtxeXp3UnhEZVlTdjdFa04xUUc4cjh2U29VTllyeVZEMUovNWpo?=
 =?utf-8?B?QWttKzAvS254bDZXZGptTGltQnppL2h6VHc1djY5N2xBYnhjM0NPdEVCWm1x?=
 =?utf-8?B?MEhPY0F6ZExiOE55SjJoZDlSeGI1YTIxVEJ3UUhYMmtqUGQzOER5TDRIeG5L?=
 =?utf-8?B?WW5xZWNuWm9VQlpDaUoyUmxSdHByR05lcVZLTGJpSERiWXFLcFh1bjFWMXZm?=
 =?utf-8?B?dG54aFBZU2hQMjhmUGlhUFdrVStSRGR1M0pvK2RnWW1TZWp2eFdpT0VMU3l2?=
 =?utf-8?B?ZURWcWFFc2JGandpSEVDZWYrVkxocjhsMUcwNTkybGRHbUVKWjRpMWEwcE5T?=
 =?utf-8?B?eFpqSEVpZStIa1lVdHR3Qmh2cllxY0tTd05hcFEwM01SVWlVbG94TWNhR0JD?=
 =?utf-8?B?aERKWU5XcGdyUnR3N3FZOGE4SWpDS2tlT0pvd041STcyaEdXV05VVDMrbHpW?=
 =?utf-8?B?WWNOczI2anRxWDRBcWd6RXF1TFVhNEJtNkt1dVRBZllwcHNTeVNHS2E0ZHo0?=
 =?utf-8?B?Z0xtSWd3MGVGdjZnemg4aFMwUlFIUVZpTmowVWtFVXZUcDY3Sjc2TjF4Umw4?=
 =?utf-8?B?TVJKcENkM0tsYzdYWGdmdkFrTVNoWUtCK2dGWklGUDFtOEUxUlRHdHVGWjNv?=
 =?utf-8?B?TktPWDF4a3A3dy9JeUdjdmtKR1pEb0liSjZqTnV2MVR0bFRzS3hOQlN4a1c4?=
 =?utf-8?B?QVd0aFRQNklrWnpNUHhCd204ZXcvVWIyY0NXRG5nRFJQYmJNSzBYNHUxbGcr?=
 =?utf-8?B?SlZyTmd0Y2dBTDJCM0YxUkdpVnlRc3FSOU5HeThIUE9DU0d3dUZUalBJWUxJ?=
 =?utf-8?B?d2NONFRDMHA2Z1AvSHpGM3ZwK0Njd05mTGNpbTdUVzU4cUJ4cys5UE4zbFRX?=
 =?utf-8?B?T0FHV2ZwMTl5aHJrVDdWaWdmWXB4L3lGTWZjdFgvSGZyWkZCSDN0NG94dkVx?=
 =?utf-8?B?RXRMUVBjem5jS1pkRnJBQXIzYjdsakVuV1NMVGJUQVRXTXpjbmpYVGhMSzgx?=
 =?utf-8?B?RkM2U3ZTZE1ZTVhqRVNqcEU0ck1JMG5rbTc0UFpZTmRpL0ltNkozbnp3QlRW?=
 =?utf-8?B?QlRna0N1c0x5cVFxam5waThZOFBLY3BEM0JrN1lqRWJPdlM4eHI3Nm9qNjBS?=
 =?utf-8?B?Sm9hOU5hU2g2eEZFVW42ZHJWcmc1V1AyOVcyZlovNytVL3p1ZHFXMVcvVXlD?=
 =?utf-8?B?blR4eFBFalhocWkyU3NOczEwWkw0ZHdWNE9DT0dJY0lHNkZJbCtDcTFyMFR3?=
 =?utf-8?B?NTdrcDJLbHNGKzlnL3pZVmhnRjNrdTNoVXBJamU5RkVMQitDN0w0cU1JK3Bt?=
 =?utf-8?B?WEgrajdIeEJnZVdvTUVPOStGWk8zNk9LZFpodTNwNEFnbzhaM1FaVGNTMVBX?=
 =?utf-8?B?WE1XcEdRTFJJSmMrK3VzYk82OFFZR3dRdlhhYlNUTVpCbGQzRHcyd2VoUm1j?=
 =?utf-8?B?ZVl0eUxjSzdKdUllU1lCQWQ5Vlk2MHVuOC9tUm9RSDlsdTFUdndXc3Q1ZThu?=
 =?utf-8?B?MUc5M29ZSVY4TkFLalBIeTBrOGpHeGdhK0JJT3JpbndSQTJIa293QmtURHla?=
 =?utf-8?B?TUZZdnBrYmF1RGJueUk3TVlkS21VU1dqVGF0Ry9kSXBuRC80NkkvcUZBQnp1?=
 =?utf-8?B?SUkvcFRvSUY4M1VRUW94ZStuZkc0MXRTSXQ4bW1qSTdSdlVGVnYwZVZVT1pN?=
 =?utf-8?B?SURJb21ma0ZxMHdFL2lSS1NpU01rcEE5VjJvWm5FZlZuRHBzdG9VNWx5bk9r?=
 =?utf-8?Q?Y/XS7Z6RSQ1YIWGIxYtygVZIO?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6293b-f414-49e9-a473-08dc2401892b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:13:39.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6h6ZvZqLqriXj/2vulfdNvlwfwWxYe01Cll7hdjRe/b7JrupU+EUEfS1JlYiT61TqcYjcMjxvMWkJkD7vXEVg==
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

SolidRun Armada-388 SoM has an i2c bus supporting on-som eeprom, and
peripherals on a carrier.
armada-38x.dtsi disables this bus by default, it should be enabled by
som or carrier dts.

Linux has moved i2c0 from helios-4 board dts to som dtsi, including
status, pinctrl and clock speed.
Copy these settings from mainline.

This fixes accessing i2c bus from u-boot commandline.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/dts/armada-38x-solidrun-microsom.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
index f6ae784bed..1540162e03 100644
--- a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
@@ -99,6 +99,11 @@
 };
 
 &i2c0 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
 	eeprom@53 {
 		compatible = "atmel,24c02";
 		reg = <0x53>;

-- 
2.35.3

