Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CDE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFF9801FD;
	Tue,  7 Jan 2025 13:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Bdbe8pI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEAC8036D; Tue,  7 Jan 2025 13:11:35 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA416801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cByqR1777rUAWRoKcvy5uUX9PEPLXtj5NNMPauh2BUgl1BYnywKkmOfi9RZZt024MC4KDKCFsZ1/EraWYFrWGqOsWlaFKkzXa5oXl1PuTD+HnjYa7innDUbZnrki606McvPdiABR+wfjAyZa5NPoJe3WNcUhiPrlY2xc1aPhZit/qr3xFVqttvRm47xr45VzYyEy8BdaYo/7JPKNCU6msrDHxh+tdCkNVF+RyzxXUpz/koMRFjClN4Qt8ye2jbN1XzmKA+E3I/z8j4KV/R0FXBthv36AmoWIqSfsgFt1p4jGfbUIA04szwxMnqySLq/S906xiygmC6dhA1KoTlrQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyYgiB4ta9B/8si0FwRXez3nIywPEvSPs0/x4Ti6GnI=;
 b=L//rbL3vAf2rX2DMOIEll7supPkG/eG3CmIoJ/nzmf4MaT5uM5JlgEbGrTjOejc1nOBwle3j0CZw68q8xIcsge+FArMxI0Yw7BQMyB45pynCEhzpewS3kh88No1JCpEsmxPAID7XyzHBbDYLyFDM1w+UXZ6VtYGlJkOUsNygz2WJxgF+cAamN0wMEqQ3movlQFuxB3Tnlf4e1KnjuQt5oV++fQZTV62oEYaNaQuHg6/PaF5rGVqEBdMRb1uVxKGk+VsQwvsLyZfPU2E199ESFolug99edMf1TKM+PicuTEGy35ZBTsm7eh0QnfJ3QyljhZLjc1h4WFOGirtPcFtzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyYgiB4ta9B/8si0FwRXez3nIywPEvSPs0/x4Ti6GnI=;
 b=Bdbe8pI7YurWc+dYzBlpRXB+FtWFVkwT6u5Ae/FXTGJMdeyX1D6Qk7DpNXqE+jOXe33r4oOfTZZ5gFrx9Ro4M2ZlEbfH8DCO9aizP/1jzKgVWNR+Af+rma4+CTYFEa/7le1IuQOOA4Y3UUnnEZUjAxisrqsc+u29gUb1bHTKu1Gw8XDziTYSM32qniSyLluzPmg/quI+vaPXmob5Hmo1t2nfwmIbg2A+T0RG3hdw6T4hmoa8qEMttRvuyCE3yO0hY4x0UvYh+MusYQOVKTP4RV80BSdTo825DIcO9++SWWN3KvW5iHFfjle+fPb21OYkKdX5/qzGodDZ0ZuUHUnsqQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10353.eurprd04.prod.outlook.com (2603:10a6:150:1d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Tue, 7 Jan
 2025 12:11:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 12:11:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
Subject: =?gb2312?B?UkU6ILvYuLQ6ILvYuLQ6IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDMvMTddIHBp?=
 =?gb2312?B?bmN0cmw6IG54cDogYWRkIFNDTUkgcGluIGNvbnRyb2wgcHJvdG9jb2wgZHJp?=
 =?gb2312?Q?ver?=
Thread-Topic: =?gb2312?B?u9i4tDogu9i4tDogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMy8xN10gcGluY3Ry?=
 =?gb2312?Q?l:_nxp:_add_SCMI_pin_control_protocol_driver?=
Thread-Index: AQHbXasnNarmZOh5aEy8sjzIg6Z+mrMIr8EAgADXYwCAALWJAIAApb6AgABNhoCAAAve8A==
Date: Tue, 7 Jan 2025 12:11:24 +0000
Message-ID: <PAXPR04MB8459F3B1A250609CE5788F3D88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
 <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
 <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <7c7ab649-2bda-4693-8e41-c41c8e820c06@denx.de>
In-Reply-To: <7c7ab649-2bda-4693-8e41-c41c8e820c06@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10353:EE_
x-ms-office365-filtering-correlation-id: 70c09bd9-3a9c-49cc-78db-08dd2f1467e8
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?SjRGaXRza3FNM2RzM1JSaG9aNTFZaW44dk45QTk0RWNGNVFnWkhhS1NBNlFo?=
 =?gb2312?B?Z0R5dkd6NDUzNzdHRnJiU2gvMmlQRGR4aTZicGpsZ1VpdWlaaEpveGxSZ2VF?=
 =?gb2312?B?VnZRdmlPdnNaa3dKZWNuTFI1alNFbDN1bkkzM0VxNnYyNEFKUjE4VjFVSHhy?=
 =?gb2312?B?UFBqRWpyUFJXT2ROSDNrSFhwMURhWE80OUFLcEJrekxqck0yamQvYkFyV2pn?=
 =?gb2312?B?bXRaUXp4OXhjZ29BUWh1Vm5pS3FYRnpDMndENFEvZEV2b3JZdi9TcG0wY2Zs?=
 =?gb2312?B?NzNDd28vLzlCYlR3L2FRR1lDVkx5YmZVVEtGN3NSQThPSUlOVlU0K1JJZzJN?=
 =?gb2312?B?Q3R3Mk4xR0MvZWloeFFqVkxIbkpRQU5PSTU5WTR1K09JOTdvOE5rdzQzcFUy?=
 =?gb2312?B?Q0pIdmVuM2lZdFlXcHBldTNMaE9TMGZyS2hya2ZuVkxMTmh6WWMzZ2txWm1N?=
 =?gb2312?B?amxjUTZsUkxqNjF1SllidmlNeWtaY1E3aHlXQXF6dTZ4MUQxbjlLbTdYblcx?=
 =?gb2312?B?MWFkZUhLbnd3Q051NW04dE9ESnZ2Z0JlWnNHc1M0UUJRY3NKYnV3Q3p5cGRo?=
 =?gb2312?B?amhrT1ZqS0ZOQXRTZHluV0ZqZWZBNnZnOUxmSmRHYWhIV1FlSnF2RS9Pc0Vj?=
 =?gb2312?B?T2FCNUVKenVqSjBHVDJKYnZEYU9FcnBFMUJsUzZIcTFxK09YK3V1Z3haMU8r?=
 =?gb2312?B?bGNwUEJSUnlDbk9jNjh0dXQzdW84ZDIvbEZIZ0dac3lNSXd4eXh4S1BxL3RU?=
 =?gb2312?B?OVM4eGNqZ1lCQ21iL0lSL3lYN1RvOG0yK2VQVDdQVGxSNmkrc3J1UUFKdmda?=
 =?gb2312?B?NjN0UUlkWW5iVjhkaS9aN1hnM3hyQWxnWUtaNGpLZWxHUjA1WVZKV0VJSU1Z?=
 =?gb2312?B?WUFvZ09SSXc0WEEwYWxVc3hDL2dnUGZvcktjclFqMjJOcy8wallFbzFuaWdG?=
 =?gb2312?B?RW1MTmhmT013MEVmRGsvN1c2OHQ5MnltQ0J5Z25xNDQyTTZRR1JsUWRLdHg2?=
 =?gb2312?B?MzZTRDVuRWppbkdqZXZBbG9HbWMwbVowdWZzell1SVp5REJTT2wvOTRqLzg2?=
 =?gb2312?B?NTJwL0FxSTZjbjZOdklQTUZFZVRERkx0SWJzczU1YjhPOG9UaXFLN1Q3bWtl?=
 =?gb2312?B?THBBVC8yU2hPWk5wYUFqUWxRa0htU2JtdldiTFNjSjZFY001djlwT0R0bkMy?=
 =?gb2312?B?ZGxJSllkbDRGbktQQ092bWc3ZEh2MjRkTnA2YnEwVjlmTkRiUDhITmZxVmFh?=
 =?gb2312?B?bGpheW50WXg0dlk0ak9ZSVFNNGRkbHpYNG5heHIxTEJBUER4M09hQi9TQkJS?=
 =?gb2312?B?ejhic0w4bmUvbGptSzY4SmtIdnA2Tlo2UkxVREFoR0lMc3UvcWhaaCtJbkh0?=
 =?gb2312?B?TkpTeXU5aGtJMEJsb1ZIQWtPVE1TeW44RzJlN0hYbDEzK0UyRHRuVmtUMjV1?=
 =?gb2312?B?MGtBMlI1UTRnU0h3RjdBanlDejhMM2haSmFCNWVjMU5RcVVrU3RrVjZiVExh?=
 =?gb2312?B?d3dVNzUyMjI4SUF2YW9EbEx6aTJjRzU3RXVZaTJtS29hUkp0T2NTeE1ZTWcz?=
 =?gb2312?B?T3pabnFEME5wTFhYdjVIbVBVdllFQXV4SzIxMXpMNGxsL2dSZFVnMzlvcWRD?=
 =?gb2312?B?TzlDcFFSVWlBeWQzNktpNTcrZVBuMUhvN3Bmdk1BVVI1eGttZ1BFaTlKTVdC?=
 =?gb2312?B?SmhsZUVvdFZtZytMTENHSGQ4NDg5Slp1QWJGUmNNM3NZNy9jL3o5cyt5bTF4?=
 =?gb2312?B?SWFISk1rSkI4S2ZUVTRlU1Vjem5kblVhR0daTHJGTTBlVXlIc2NBajdVZjQ4?=
 =?gb2312?B?clFLZUtyNjU2QnBkNmdLV2JlbE1NR2VzcTd3QlVYaXVpa0NoYks0anl6VzMy?=
 =?gb2312?B?MkpHTGRodDNOL2FFNVFEYVp1dW5RV0RWMkh0RDNGQVlmOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bTJGS3hHS29iUTRsK21zcllOeUtsYmFPRXJsTncvdXpOSm9DemZUelFMMmpT?=
 =?gb2312?B?OWxuMGlUa2haK3psVGdoVVErNDh2SERXdDVFeVlONVpENEMwZTE3cUkrdUdQ?=
 =?gb2312?B?UXBLc09TVEVJNk5sRDJxdjd2TzZvR2FtQXBoWnBiS1BmUFpKc3NrMzhwaXBV?=
 =?gb2312?B?Qy9URkJHcEdqU0R2clVTWWtoRjlFM1lLR1JnbTk4MU5ldjM4Z0t4dVVXemxj?=
 =?gb2312?B?YlhzVHpadDV0OHJGV04vVzFITmc3dC9UY2NZdm9Sekd4VU1COW5acVNPeU5t?=
 =?gb2312?B?bEVZdGo5cWNkQzlweHBDcFJ0bnl3VWJnbFN3OTZFTm5pNEtERzFXVStUZXBn?=
 =?gb2312?B?bVZRRTM5QnYwbG9HUjNRS2p1YXZDUjlFbnppb3dSeXc1QTRPc1kvNUF5dG5O?=
 =?gb2312?B?V0ZhRnBySUQ2TXVadEY1Z1NYK3lCNzc1QVpHamoyZDBoWEttTi9Kc2VwdnBx?=
 =?gb2312?B?VU9XMW5GTjZ4Z2RiMmFudEMzVFVWd1VKNWlCWnpLMUlmT2liRUVMVEpBQnJO?=
 =?gb2312?B?MVV2U0N6cjR3ZEFvMEUrWnFQUEdCa2lERDUrbWRTUnBQTXRORFRYNnRYKzBV?=
 =?gb2312?B?ekJnd3FyNXBtMGN3WmEwZHVlaVBrRjkzNjlLVHdUWTVhK01PVElKSnR6c1VJ?=
 =?gb2312?B?Qk9jVGxSaWdjVjB5YXphaW1HOEVRTTlPb1owVTMxcnhVVXhRTU1RemY2T20y?=
 =?gb2312?B?OW12MHhpcHBLSkFlYzFoWlR0dDV1YnNvQWg1cmlnSkx6YVpkekxzWGdIeUJm?=
 =?gb2312?B?N2xIdmJvQTVlVzMwQW5NRlk0WDJERGJyTGFjOWVpMjE4ZDd4VmJQVDVzakFn?=
 =?gb2312?B?MmNWV1F3eldMbCtHK0ZIaFVDM1MzWWFpTnYwMHQvNnErOGtJVEdiZS82WDhq?=
 =?gb2312?B?OVRhL3FtaldWZ0ZPOVBlSSsrNEV5RG1BSGFzeStJL3VBZSt6Wkk4RjRSaDhs?=
 =?gb2312?B?ajBoUndJUFlUMXgwanVNOFduS1FrWG5DVG4rYUFiTTVtbkhUZVRsZ0t4TkNw?=
 =?gb2312?B?MzZ4aHAvTkpGeVI4TnI3NTVNY2hibnplSVBWNXg3b3ZScTZHZk9yQURoUmY1?=
 =?gb2312?B?djFrS0NTVDREM0FZWDZPRGhHQ013cUpnN21ZaHVIQzg4cjVZS2dScWVVWW9v?=
 =?gb2312?B?eEJacld4YWxFM1FyVFgzN0JZelJzYzE4Y1h0S2xaZ2pRV0RLczBTMlhJYTFD?=
 =?gb2312?B?b0xXYU11OGYyQ2RabjUwU3hmRU51TEMyZmh6dm5ocG1JY20vOGVHbUk2RGlQ?=
 =?gb2312?B?cG1pSnB2NkwxdEhzQXVBV2tFdDkyTEc3M3ZwOHc3aHlKV2Uxd1ZHbHl5NUZV?=
 =?gb2312?B?MUJGTlBXZEdzeUxzalIvVXB5M3cvekFLYW5qUW9ON0YrK0Fud1JQZ3IyenNT?=
 =?gb2312?B?ZlN5eGFvZExEdkUydHlhYjRYNHlXSnJiMlFzeE5KdFJGdCtHMVJMVlZVbCtx?=
 =?gb2312?B?R3FSUTBwemIybWJkZE9PN0UxMWNIN3ZzTjBZdEk5ZUNNYmVERVhvY0d3V0I5?=
 =?gb2312?B?bkhSQnlGVkMzS0E3UlNBd2Q1WG9yQWJIc0M0YXFQajljd3lxeG1RSW4wdnVU?=
 =?gb2312?B?ZFJlVkEvRE9WelJ5MDVmQUQ1OTd1WlFsY0tYRGtmanFTS0hOelV4Y1pOdDN1?=
 =?gb2312?B?VFZ5TkpsU2NDYnFXZGM3bDBTVlFpbHNQNHBNSjVPdXRCeDcrRjlUR2hqcWhq?=
 =?gb2312?B?VzM4S0h6c0FFd2RlUkpORm03dFRDcGFNSXd4OCs4Qjh1dmJuMkNFTTlPTzhv?=
 =?gb2312?B?YUluTk1MY2xFUVk3bWZHWVpXeGp3bW91TjdNb1dGYTQ1Mnc2N3BabkpYejVB?=
 =?gb2312?B?LzlJTUlqUTlXTHlhVU5PdUVDL0pmaXc2cDlsN3BnYWZ2L0NHQlNSVk5waEM3?=
 =?gb2312?B?Z2VSRGt3T0JFclhmeWhxa3RvUDRDUFhZVmJWbVEzZWhzb1U5WFRpcUJyUGFJ?=
 =?gb2312?B?bXA2L2R3Zi9NNFZGeURucHE5UHF2Zm9vVjEyZElQVHJMdzg1cGFMVjdYM1lh?=
 =?gb2312?B?SDlDdVdlZWN3UmdvTU40YjBSZm1tZHBMZXQvRjVaNDltbnlqcHVuRzdCYkJm?=
 =?gb2312?B?QUY3YWVxcWF3dDRUNVh1eVVGNGRldUxvQlZrZmpUZ1loUzZ1WExFRERVZEM1?=
 =?gb2312?Q?APX4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c09bd9-3a9c-49cc-78db-08dd2f1467e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 12:11:24.5583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfTb+a1K7j4mf0FgrfIXu5p9VzAuE/Nlt9M15YeYNVwOK9e2/mzCQxm2C9BTWYJ1TquFYdJ1Q/7DiFu9syNVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10353
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

PiBTdWJqZWN0OiBSZTogu9i4tDogu9i4tDogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMy8xN10gcGlu
Y3RybDogbnhwOiBhZGQNCj4gU0NNSSBwaW4gY29udHJvbCBwcm90b2NvbCBkcml2ZXINCj4gDQo+
IE9uIDEvNy8yNSA3OjM5IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4+IC0tLS0t08q8
/tStvP4tLS0tLQ0KPiA+PiC3orz+yMs6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+
PiC3osvNyrG85DogMjAyNcTqMdTCN8jVIDQ6NDYNCj4gPj4gytW8/sjLOiBBbGljZSBHdW8gKE9T
UykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+ID4+IDx0cmluaUBrb25zdWxr
by5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZhYmlvDQo+IEVzdGV2YW0N
Cj4gPj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5j
b20+Ow0KPiBMdWthc3oNCj4gPj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFuZGVy
c29uDQo+IDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+ID4+IEdsYXNzIDxzamdAY2hyb21p
dW0ub3JnPjsgQWxwZXIgTmViaSBZYXNhaw0KPiA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPg0K
PiA+PiCzrcvNOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBQ
ZW5nIEZhbg0KPiA+PiA8cGVuZy5mYW5AbnhwLmNvbT47IFJhbmphbmkgVmFpZHlhbmF0aGFuDQo+
ID4+IDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+
DQo+ID4+INb3zOI6IFJlOiC72Li0OiBbRVhUXSBSZTogW1BBVENIIHYzIDAzLzE3XSBwaW5jdHJs
OiBueHA6IGFkZCBTQ01JDQo+IHBpbg0KPiA+PiBjb250cm9sIHByb3RvY29sIGRyaXZlcg0KPiA+
Pg0KPiA+PiBPbiAxLzYvMjUgMTA6NTYgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPj4+
Pj4gVGhpcyBwYXRjaCBwcm92aWRlcyBhIGRyaXZlciBmb3IgdGhlIFNDTUkgcGluIGNvbnRyb2wg
cHJvdG9jb2wNCj4gPj4+Pj4gd2hpY2ggaXMgYmFzZWQgb24gQVJNJ3MgU3lzdGVtIENvbnRyb2wg
YW5kIE1hbmFnZW1lbnQNCj4gSW50ZXJmYWNlIChTQ01JKSAzLjIuDQo+ID4+Pj4+IEN1cnJlbnRs
eSwgb25seSB0aGUgUElOQ1RSTF9DT05GSUdfU0VUIGNvbW1hbmQgaXMNCj4gaW1wbGVtZW50ZWQu
DQo+ID4+Pj4NCj4gPj4+PiBXaGF0IGlzIHRoZSBTQ01JIHByb3ZpZGVyIGZvciB0aGlzIHBsYXRm
b3JtID8NCj4gPj4+DQo+ID4+PiBIaSBNYXJlaywNCj4gPj4+DQo+ID4+PiBTeXN0ZW0gTWFuYWdl
ciB3aGljaCBydW5zIG9uIE0gY29yZSBzZXRzIHBpbiBvciBncm91cA0KPiBjb25maWd1cmF0aW9u
cy4NCj4gPj4gVS1Cb290IHNlbmRzIGEgU0NNSSBtZXNzYWdlIHRvIFN5c3RlbSBNYW5hZ2VyIHRv
IHBlcmZvcm0NCj4gaGFyZHdhcmUNCj4gPj4gb3BlcmF0aW9ucy4gWW91IGNhbiByZWZlciB0byB0
aGUgc291cmNlIGNvZGUgZm9yIGRldGFpbHM6DQo+ID4+DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRg0KPiBnaXRodWIu
Y29tJTJGbnhwLWlteCUyRmlteC0NCj4gc20mZGF0YT0wNSU3QzAyJTdDcGVuZy5mYW4lNDBueHAu
Y29tJTdDY2UxNjUzNzI0OTdiNDBjMjANCj4gM2I0MDhkZDJmMGRmMmZjJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDDQo+IDAlN0M2Mzg3MTg0NTkxNjA5NTUxNTglN0NV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQg0KPiAwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3
TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pDQo+IFRXRnBiQ0lzSWxkVUlqb3lm
USUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9TE1LSEhkQUpwQkMNCj4gaWFIYnJWSXcxZmc5WSUy
RmJxQzdtV09VRGZhbjAwZ0l0dyUzRCZyZXNlcnZlZD0wLg0KPiA+Pg0KPiA+PiBDYW4gSSB1c2Ug
b3B0ZWUtb3MgYXMgYSBTQ01JIHByb3ZpZGVyIGluc3RlYWQgPw0KPiA+DQo+ID4gWW91IGNhbm5v
dCByZXBsYWNlIFN5c3RlbSBNYW5hZ2VyIHdpdGggb3B0ZWUtb3MuDQo+IA0KPiBJIHRoaW5rIG9w
dGVlLW9zIGlzIGFsc28gY2FwYWJsZSBvZiBiZWluZyBTQ01JIHByb3ZpZGVyLCBzbyBJIGhhdmUg
dG8NCj4gd29uZGVyLCB3aHkgZG9lcyBOWFAgdXNlIGN1c3RvbSBoYW5kLXdyaXR0ZW4gU0NNSSBw
cm92aWRlciBpbnN0ZWFkDQo+IG9mIHNvbWV0aGluZyBhbHJlYWR5IGF2YWlsYWJsZSwgbGlrZSB0
aGF0IG9wdGVlLW9zID8NCg0KU3lzdGVtIGNvbnRyb2xsZXIgaXMgdGhlIGNlbnRyYWwgY29udHJv
bGxlciBvZiB0aGUgc3lzdGVtLCBhbmQNCmkuTVg5NSBuZWVkcyBzdXBwb3J0IHNhZmV0eS4NCg0K
V2UgbmVlZCB0byBtYWtlIHN1cmUgd2hlbiBBNTUgY3Jhc2hlcywgc2FmZXR5IGNvcmUgc3RpbGwg
d29yaw0KcHJvcGVybHkuDQoNCj4gDQo+IEFuZCBvbmUgbW9yZSBxdWVzdGlvbiwgd291bGQgaXQg
YmUgcG9zc2libGUgdG8gbWFrZSBVLUJvb3QgTk9UDQo+IGRlcGVuZCBvbiBTQ01JIGF0IGFsbCBh
bmQgaW5zdGVhZCBoYXZlIHJlZ3VsYXIgY2xvY2svcGluY3RybCBkcml2ZXJzDQo+IHdoaWNoIGNh
biBjb25maWd1cmUgdGhlIGhhcmR3YXJlIHVzaW5nIHBsYWluIHJlZ2lzdGVyIHdyaXRlcywgbGlr
ZSBpdCBpcw0KPiBkb25lIG9uIE1YOE0gYW5kIG9sZGVyIFNvQ3MgPyANCg0KU2VlIGh0dHBzOi8v
d3d3Lm54cC5jb20vZG9jcy9lbi9kYXRhLXNoZWV0L0lNWDk1Q0VDLnBkZg0KT25seSBvbmUgYm9v
dCBtb2RlOg0KTG93IFBvd2VyIEJvb3QgKExQQik6IG9ubHkgTTMzIGNvcmUgaXMgcnVubmluZyBh
ZnRlciBQT1INCg0KWW91IG1heSBjb25maWd1cmUgVFJEQyB0byBhc3NpZ24gcmVzb3VyY2VzIHRv
IEE1NSwgYnV0DQp5b3Ugc3RpbGwgbmVlZCB0byBtYWtlIHN1cmUgTTMzIHdvcmsgcHJvcGVyLg0K
DQpSZWdhcmRzLA0KUGVuZy4NCg0KVGhhdCB3b3VsZCBzdXJlbHkgbWFrZSBoYXJkd2FyZQ0KPiBi
cmluZyB1cCBlYXNpZXIgLg0K
