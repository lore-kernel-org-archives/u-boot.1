Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B344E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459CB80312;
	Fri, 20 Dec 2024 03:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x92KFHNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BC480326; Fri, 20 Dec 2024 03:55:09 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D158021D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaH+Pagr+dWpNbAqX9Qm7nR3/mIgK2Fo9Aqmd9FirOeAldF+ezcI7N6DEFBMi4Kxjwx3yHwTsx/wMEKYS/6LFLy7bnr8VHPOhVXAoeswFg0mEbWen9nNwtHxodFZ6SaspXc7/xux+B1oi0QmwrecN+iYUoOBxNTpK0Ngo3y3qpHsdFL8OUVpAsCyoQW7LgoIX8YuUM/J4mufcU498XSRSi4BlennfDXRWAtVITdFTqrexlaxvaEm0Kwne7M59l3l084Ez3ARiwHczs8p8Lfp1hEf/VVOSOF9Wk7je+t5Mc7A2OZhhiWjCFqiGx3cu8vyIjCYlSDxxiFClJ+gQtqvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qzCKG0eTMFZJIEhfJvIx3gsE3R6O6ja/BKIuX8QMZc=;
 b=P26xhaL9w0zVC4O5SY5unn2fHRJAuNfdveDgJk618weed0F/fc3tKamteL7qpGes9K0Nfbxakt8hmYJeRraboRVDpC4OM3dutprwIqDxCUREjctkSAo+UhFUx13cu1UWyXhF0q342Y93QKn3TswQuKhez9Jp9fZnc7cge0EUvYafgADRS+gDpgUobF87BQuS8YQweSWSvadNEX+qrwxxzXnIgZ+oCeT3PZY7C/w/1v62nz+Uo9hRPDDuRdA5RALk10BVeOtr2+tvpmIIpL+JsvVwUQ6C8PB4LZX//hw2WJWUI3We5itTicvzY5661nfzI83cuaWJrTqL6KVoW499mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qzCKG0eTMFZJIEhfJvIx3gsE3R6O6ja/BKIuX8QMZc=;
 b=x92KFHNSxjFa9jpq7EhdV5Ys9J0122loRHJwcUjDlRg3U4S0TI0HOU+16adW3eH575tcvyDKvEnFMLq/2KArrB2bCCkQTRT3ohKbvjvWftlF9gExgr+2YF3yz5Jh6jczzfLHteC60ue0nmQffHEVRaY2w/bOY+nXivLunIT4Sa7TZgbfX2xT4Rti7Ra3Hy3KCYVUJ2Qx7yKnMMMyo5QH5tPY563b1myB/or05J7oCQ9vzLosB4jUvPI4+I0a/Oq72/QZQGOKrBKnFHp9PsYyyB4IZV9GZHD/96+7PWq7xX56Osfkw6SlIl7H4eshbLIR/JhFNlYIgE7DHg4GoGJK8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:04 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Subject: [PATCH v2 00/17] imx: add i.MX95 support
Date: Fri, 20 Dec 2024 10:54:58 +0800
Message-Id: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILcZGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyMD3czcCktTXQOTREujJDNzE5O0VCWg2oKi1LTMCrA50UplRkqxtbU
 ApJljwlsAAAA=
X-Change-ID: 20241220-imx95-04a92b6744fe
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=5335;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=H6q8lBsm3pdxsVJQkQKJIUQ1oFOkAkyIQwHrHcvdXnI=;
 b=UsSYBRlWw3pNj/54dTZNQGXIJVsHCNBbc/b5LJa7gCIu2E0x48fzd6Ub7ASv+tA5SxmnwG78Z
 a7mzpxhiUOHCJNihv0Z8t2jMGEEWxtROH7TBzQpjZMYgm2QEVsIIgAf
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: de065c5f-6619-4b0a-5151-08dd20a1b46a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnlQRzJTd1piQjJCMGF5ZU5JVE45dVNzSC9xRzNBbUhrWkVzOHFQK00rcTZV?=
 =?utf-8?B?MXQ2WEw5WmZLN0JSUVNNVkhHMlEwNWJydnVUMFRsRmRYR20vQW1QOTNVRGpT?=
 =?utf-8?B?OG1BRVRScTBNd1RqYm5MTDAxRWVvNmk0YlVnaDIreXl4MVFVNWIxWVBreVBi?=
 =?utf-8?B?VnQ5ZGd3ckpjOC96MXlDVVV0ZUxPd05nYk9ZOXRWNldlWGVkVXBJZVQyN1Fv?=
 =?utf-8?B?OUNLNU5YMVhIUDRHRjdUN1YzdzdRM2Y4VllVSElHVnFHN1RJazhkeWRYdksx?=
 =?utf-8?B?NmJWN1NyNDQ5c0d1cWV1dnZYMmIyWkxYWUJXVWwzZjMxODlTZnhnNkJCOEhm?=
 =?utf-8?B?YUVNcVlGT0xFUjNTcHNtb0FDT0NzL0hyQ1B5SkpFTDduWVR1N1cwaGEzSmVi?=
 =?utf-8?B?Qy9lQ0NDZmlqaWYzNWt5TkVDRkdPSzY4Znh2a2Jta01qRStBUENPeGJlMHFJ?=
 =?utf-8?B?eFl2Y051MmVZNjZBRmdNT3dkQkx5dnc1RkZEVi9aZldXdmZqK1cvaDlLeGhw?=
 =?utf-8?B?Z21UcGRVR3RxYlF1Ky9OYUJtTysvVE5Id1VhNUhIZDdaeTE1czJkeEJuRStY?=
 =?utf-8?B?WXBWRUNhNGtPTlAreitXN1FFM3FXamNiVXE2eDRHeXF5OUxVZEYxanR4L2Ri?=
 =?utf-8?B?MTdJSGJKS1UyQnIrZFBxa2pRcmF4VGZqT0tWTlIyTkRaSlJheDZQazJDcXhZ?=
 =?utf-8?B?MjR3cDlpZlRob21uckZ0MjVmSER1dld6d3JMZFVoaFlVQks5ZWVWWTBqWkM5?=
 =?utf-8?B?WXhQMlBtZnFuMDZkSzV5d3puVENaV2xSemY2RndGeUtNMkY0QWdkckhKeWNH?=
 =?utf-8?B?Vi96VkFSelUvbGFtdkpkT3k3SlQwK1NwbWZHTjkvaThLemQ0M0I0QjdhQXds?=
 =?utf-8?B?S1ZRR1R2OU8wc0JkWmNGNjFWdkpKWVVuL1pqOWx0ZU9ZK0NYbkk3bjc5ZDJh?=
 =?utf-8?B?OW5SM250dFl6UFh6ZzhkVmRzM2FOMEp5bCsrL3psVlhhZis1bnNiZ280TnlR?=
 =?utf-8?B?RStKOEdPc3JlOGRuNk1UcXRUbTVZTHVacExSNi9ISjZRV2J4V1ZpK0pxMFBW?=
 =?utf-8?B?VC9ONnhXdGovZWFNOGt3TGlJMWFrbHBOeFVMVW53UXZrcTRxb3ZIMlhxNTZo?=
 =?utf-8?B?U0ZSWHFqUUQ0dHREQ0FaS2ZhdTFEenRjOUhjdUxmcTJic0dzRGZGbi9OT2pH?=
 =?utf-8?B?b1ZTNUdhUitPNlF4TnZpdjUxSmZqeEkvVTNueVhTcEViVDhuMEpJa3Z3cS95?=
 =?utf-8?B?SWRWdzI1VlJHRmxPU0pxTXZDcjRWemlQVWM0MDIzNzZBbGpMcHhFdy9EbXNY?=
 =?utf-8?B?M0ZnMlVkVHN3cC90TGFwNjhHQkg4c09BcUVmSUtpS2R6Rk1CazVieC80QTJD?=
 =?utf-8?B?Z1RUSnRoVG5yN0hSS2ZGRHNlM1hJZ3NJWDI3dmoxYzJuREVCK2lGQ0FXc1Nt?=
 =?utf-8?B?Sk5mcHdXV1k1ZXBUVWJVQWh1NVAyOTFML2djL1VzYWpTNUJlVE1lY1h3N0xM?=
 =?utf-8?B?cGhEZjlyR3VSWUYrb3NxdGI2UjE1ZjFkaXA3UkQxNVh5K0Jmdi9MS04vYThU?=
 =?utf-8?B?c2JORXdyRW5TVEl5ak9oY21rL0NRbmFOWVg2cW9PZkVPbG11azVYRisyUVJr?=
 =?utf-8?B?czlZMVhzQ0h3MW1yd3BneWJNOUxMdHQwSmFPVlhOd05yN09waXc1MkRMTmVJ?=
 =?utf-8?B?dmw4ZzFWcmUzUmFPdTRqRGVNK0htV2R5MC9hOGcxbTZqQ0RMMkhWZVBKN05h?=
 =?utf-8?B?WVVGaE9xYXE3RWMwQUJlV2kyVVBKeVVwb3RRdHRhQ0VJc1NyYldKWVZFb2hW?=
 =?utf-8?B?UEk0dUs2aVBnblI3cnl0L3F6RTVhN25KQmJZekVCeDlzaHR3WllkbVdVMTZL?=
 =?utf-8?B?aEUzSng0N3RCUk9yTkpOUHUyM2FHUldkMnhHUkhHaW5rSDNtVU1xS2JZaE9N?=
 =?utf-8?Q?efKjwiub5mop7LKATRQO0/IaceFbO5J8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDV2cEJxdU1yMkRQSUVLWUYvQVJSVi84UVo5dTZDanV0aExqUWlYQmtKeHBK?=
 =?utf-8?B?eHhqQXlMZDB5VmJLTHdCOWJmT2pkb2IyaG1sQnovS1ZIRzdVSVVhVWtTMTE5?=
 =?utf-8?B?RlNuQzYzL20zMVR1MGpWcHhGdW1XZmdEL2paQ1dOTENzR3pMbXQzTE9lOWtG?=
 =?utf-8?B?OVJ4Z3AwWjVOL0wxZWw2YkNhVTFPMWJhcGhyZW9INm5aOU1GS0VzUXh5NWVn?=
 =?utf-8?B?MWw4bEE1Wk1VazdRMThUU3A5UUJyODVQdGZMdVMza0NXYWhac2txWW42aXZr?=
 =?utf-8?B?RWRxUGtmYVpXYWdSWDlaYmN4aUI3SFVHM2g0NkU3UG1wdFhQVEUwQmRlNkJX?=
 =?utf-8?B?RENMRnBDQUZKQnFRNmZEcmFuUUx2U0N3dllpdTlFVXFldkR4Qjg3YXk3dzdT?=
 =?utf-8?B?MXcwOVA2SzMzZURHR1hIT200MHNscEhXc0ZLci84dFpvcEI3SUo3UzZPQWwv?=
 =?utf-8?B?ZHRnZVZhRDhwWFpQS0IrMmhsUHp2R2piYnl6TUpHVGYrd21MUlMwcWdjRCtF?=
 =?utf-8?B?c21HNURiK2ZpUE5leUpFbUdBcnMyelYyeEhDQVFxbEZiclpnRml6QnZMSU1D?=
 =?utf-8?B?aXZtTFhuek5wNHRqS09ZTHoveWd5M1h5dWV4cjRQOGsyVThkbDdaT3FvVFpO?=
 =?utf-8?B?Q2ZEUjBrY25ickI1c3NtQ0FuaXk1cVlKUWVXeUpvTDRHeURaSnFMMm1SQ0Uw?=
 =?utf-8?B?WjEzc3RBS3BMQVJRcXhmeVJMNEtpTzVLWmpQZm5NSFRPVVoyMWtmOVNKOE4r?=
 =?utf-8?B?N0swOW1Jcloyci8wK2xJRmRIWm1uY1Z2WGxZcEtsMHhYb0FPZVhYZm5TeVhn?=
 =?utf-8?B?UEFBMWNwMUcxOG9jZGNvU043YU03QkJtTTdqSGQ5bmFHMWs5L0hGT24xQzc3?=
 =?utf-8?B?bzZHcjdDODRkZ0hyNDZuN3pjMVh3OEZlMEUwUGwvSWxGeGhHR1FoM1J1QW5I?=
 =?utf-8?B?a2hQZTB6Mno3N2hIakJwR2VsK05kOTZReGFQRXZrSWQzVmwzNEUrQi9DQTRE?=
 =?utf-8?B?SGEzNktMTk13djVBRjU1S0tiUFNpUXFRUXowYWRpejVIOXBlSEpwQ21qYjNt?=
 =?utf-8?B?ZmRjVE9KL3J4eUkxNE5BK2ZYS0JTRzIrVENWR0pxNE1SMDVoSVpqOUVpcnVS?=
 =?utf-8?B?S0FyU3daV2ROTCtjUFNGaStxdk9nekE1L21DSUJkckRvNnZscWh1ZkJyUS8x?=
 =?utf-8?B?aHdKSjFOYVJYN2NLVm1qWit2VDdBSGNnQ2J3QzVMOVE2d1JRUS9VSEw4VkR0?=
 =?utf-8?B?VVRGb1MrR3Z2UmdIbk4yRFNReHRpVTZQSnAwTlRLUitkU0FTMHBRU0crMkxz?=
 =?utf-8?B?cWwvTVZ5TnZHaGYvRUlDZWxDMUlyWTRSVERwWWlXZnBUZmVWSlBVeERjd0tx?=
 =?utf-8?B?K3VYWFNBRmw1Q2k5TnV5eWdQaktSdHN6bVNlWjNGZHV1M0IvQ1kwbHY3OHA2?=
 =?utf-8?B?VU1pS2Z2WTU4MjZ5MWJ0cXM4OTA3MUNnNW8xMHc1SldabVh6TG5ET2NOOThL?=
 =?utf-8?B?bnVTTkswUWVweW1qeXVQWFJIOXQvKzdMYW5nYTNZb0lIMWZIcCtRelpWOTZ4?=
 =?utf-8?B?a1BFcFMzbFFjNzRXUDJkMWIvNlhhZElpMHVKZVIvbmJrOURDVWdMbmF3aTJL?=
 =?utf-8?B?VGtBYWtoSXNTRXc1TDdrU1dpcGg4ckpIZ1ZuaE02cXBqUjJOc2VNTE4ySjF3?=
 =?utf-8?B?cTdQZlREcVlIVSt0UnhNeThaUjFFdnNzV0twY3lOMERtTzdNUUNWSVJMbUZl?=
 =?utf-8?B?SlQrWmxONDVGL1djRkhIRDNlQ01xQ2NqZzRpM2gvRXFWUnNkMUVVL2VSU0JG?=
 =?utf-8?B?MnJScm51WWRjcGFvYXB3UHJvWkpNTjhuVU8rTU14OUhhbVA3ZEEyNVAvNWQw?=
 =?utf-8?B?ZEM4YlEwc1dONFpDSXNxMUg4QitaU0hpQnNyQVNoK1B5QkYvNEJBZWRXbVoz?=
 =?utf-8?B?dzBlVk80ZGVvWlduc1hrYVBVWkgxeTZ0ZG9DUkdkbExQKzBINmVlaVl2ZWFj?=
 =?utf-8?B?NjhxVUY0S1pOWm9iMVpUU2tjYy9GdVUzc3M4dE9iOFBUb01BNGdXckN4Y3dK?=
 =?utf-8?B?bnhGVlBsNEVuNnd0SmtCWm9yREdPT3E0Ulh1R0hlZVJxTVlvdjhrRGFjS0pK?=
 =?utf-8?Q?ezJ1EPnbF3I4cEzWT2/X4kL3p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de065c5f-6619-4b0a-5151-08dd20a1b46a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:04.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ip2zimh7a8vyFFKN0B7TwfZ0w4VXEMfTuFGHjIXwz6yURQyUOck7rMmxe+aMHVVI8ofuC6lB6gDHPy4MXNrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

CI:https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=10

Bootlog:

U-Boot SPL 2025.01-rc4-00356-g9dd9c3256131 (Dec 20 2024 - 10:37:50 +0800)
DDRMIX is powered UP
Normal Boot
Trying to boot from MMC2
Primary set selected
Load image from MMC/SD 0xdf400
NOTICE:  BL31: v2.10.0  (release):android-14.0.0_2.2.0-rc1-1-g28affcae9
NOTICE:  BL31: Built : 10:35:32, Aug 29 2024

U-Boot 2025.01-rc4-00356-g9dd9c3256131 (Dec 20 2024 - 10:37:50 +0800)

CPU:   i.MX95 rev1.0 2000 MHz (running at 1800 MHz)
CPU:   Consumer temperature grade (0C to 95C)
Model: NXP i.MX95 19X19 board
DRAM:  15.8 GiB
Core:  231 devices, 20 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... *** Warning - bad CRC, using default environment

In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000

BuildInfo:
  - ELE firmware version 1.0.32-193e5781

switch to partitions #0, OK
mmc1 is current device
Net:   No ethernet found.
u-boot=>

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support

Peng Fan (7):
      mailbox: add i.MX95 Messaging Unit (MU) driver
      pinctrl: nxp: add SCMI pin control protocol driver
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      imx9: scmi: add i.MX95 SoC and clock related code
      scmi: add the macro SCMI_MSG

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (5):
      clk: scmi: check the clock state/parent/rate control permissions
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      imx9: add i.MX95 Kconfig and Makefile
      imx9: scmi: soc: Override h_spl_load_read with trampoline buffer
      imx95_evk: add i.MX95 19x19 EVK board basic support

 MAINTAINERS                                   |   1 +
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 +++++++
 arch/arm/include/asm/arch-imx/cpu.h           |   3 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   7 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   3 +-
 arch/arm/include/asm/mach-imx/sys_proto.h     |  40 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  12 +
 arch/arm/mach-imx/imx9/Makefile               |  11 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 328 ++++++++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 148 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 873 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   2 +
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++
 board/freescale/imx95_evk/imx95_evk.c         |  54 ++
 board/freescale/imx95_evk/spl.c               | 117 ++++
 common/spl/spl_mmc.c                          |   2 +-
 configs/imx95_19x19_evk_defconfig             | 178 ++++++
 doc/board/nxp/imx95_evk.rst                   | 109 ++++
 doc/board/nxp/index.rst                       |   1 +
 drivers/clk/clk_scmi.c                        | 191 +++++-
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  11 +
 drivers/firmware/scmi/smt.c                   |   4 +
 drivers/firmware/scmi/smt.h                   |  10 +
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   1 +
 drivers/mailbox/imx-mailbox.c                 | 417 ++++++++++++
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c             |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h             |  11 +
 drivers/pinctrl/nxp/pinctrl-scmi.c            | 136 ++++
 include/configs/imx95_evk.h                   |  36 ++
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_agent.h                          |  11 +
 include/scmi_protocols.h                      | 105 +++-
 tools/binman/entries.rst                      |  14 +
 tools/binman/etype/nxp_append_ddrfw.py        |  78 +++
 tools/imx8image.c                             | 143 ++++-
 tools/imx9_image.sh                           |   4 +
 50 files changed, 3556 insertions(+), 64 deletions(-)
---
base-commit: 078542c346347406cfacdec8adeac66ae6758880
change-id: 20241220-imx95-04a92b6744fe

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

