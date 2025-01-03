Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F1E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB22805D7;
	Fri,  3 Jan 2025 07:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e38zevCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7DE805D7; Fri,  3 Jan 2025 07:46:58 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F064804EB
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4KRGeLGrYfJKwE21F8R0Tv/Ui8yBZjURJ/aaYz4+3hFgKDLUKNJB8VrsgIn5yShGBcghJBPD0KSA3S1op8zQ3M+fygHU4+hA/GU39Ulg8v9Pb7BXOi2ENRDuTCvrrivgSJqFryk6imkZuvPkhD5UNelVwEvdgI82HO8R6HteFJKYsk2EVfiDhj6Gm9OR9tYfPqCkA3tL6f93sahIlFvIDGfiAy9NAf9ovusvUmjCk7BNYJEl7gFwRhSUzwDrOHF50Lerf1pvoisitOmL6F1g3KhRGKpLde2sr7xxLi6u6rmh4H5Fg84gVfTHapYAq4S220hohmaRJJvl29hxjJymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BghBx4ND68HxDqNlQQxXJT8iAlbh9+pqkuK0NozujjY=;
 b=YzAI59I0LCNSNjdKszg5oxEcKmkokV6ggwDYKg2ojQqm6I4Ol13N7Xenm83YQxizg/6paPjpvp3WU6U5A73nsOceS1c/6e8J5ubKWKmlX4eI4+3sCWKUbBFCYNzjgaRhdgP7FtW9rNUSacxZegFXU9h7kuzoaKPMt28qL5tw//LFL/KLBOJ2703Qr/4WLJgFrVMK7LTQJEs3pfAknZXQyHNVNpN4WA07KtgAin1JdVhXOolQcpglpAdczfe2ARtQoAlrqRxTwS9ztO+pR5lkdMQVaeQx1HFGQgofE6AepoNpxJzbXGcSuHcE2VeZITY1vlyiq0b0hn/xn1oe/ZK36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BghBx4ND68HxDqNlQQxXJT8iAlbh9+pqkuK0NozujjY=;
 b=e38zevCYKnO59E6rOTud3s0J46okkZuLoM7rfMZTYa6evF85dn0osschAuuvUcnXWdJfunamebbyr1dYoUz9CbodUpGbXVXbarF/EhqsFdthGUlDHUhdGL9azvTrTTvs7u94GJ75onQ7PzjTZXg2YUrR/tCWOc8JlJUNa/jwRRPjixtbli8Dx7592Ayg0hK46h1xOjqyfNNd+tN3pFv+OXUqEEqV1Hx1/kQ5WupwcpQ9FcYB9UxPrEkIBedVneBC7A6jF06Lvb/QH6M5ycOogY9rrOvnEKvaIZLrj4Ju9OGcJydGTc9UYwcilGQ0JdKE3E+ZF+/aN4ms3WIhqVZNhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:50 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:50 +0800
Subject: [PATCH v3 15/17] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-15-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=14312;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=nG3tAnbUMt+LJqfpDYEgEHrgQa9fLn6hTa16PX4rSGQ=;
 b=Z9awH9a9+Rp5+dFdc/lPdAsSH5vnpvI9D9LrNlqRIW5N0WkhtLNUNCxuXNguId+DajqN4XOcT
 E1n+WuNhCYlCY0WpaZvJbqNCPIFJ1MPvtFxpcfo8DveKQPqUEASeHp3
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b71308-8290-4cd3-298f-08dd2bc26676
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVNXZkNmUnZxc3dHeFRFb1M0bGZxY1JZZm1xZUMwTmlzTTBVVFNqMkltWjRT?=
 =?utf-8?B?RlZneGR2SEcyRGJYQ1pDem5zUUFjMlUzVlBZSVNzWEVhcWxCeXBPTHU5MENl?=
 =?utf-8?B?aE9xZzRDcXhOVGFIYmJoYy84aUtDRll3azdkSjZOQWJUVWxjbk84TE9INTZC?=
 =?utf-8?B?aHl6S2wvdktSMUZ6T1pZZU42SDI2M0RER1U0VDhwU3lpU29DNThnbllSRHFv?=
 =?utf-8?B?emljMEhDaFhUQkpldHlGTlhrVkJWaTVFbUROZGRMeFNlR3M0aDdkTS95WVhL?=
 =?utf-8?B?TGFSV2dQSkFXTGZoa0ZocXJXZ2ZOWFhyeGcxT3RteG8wK2RSbk8rNWNObC9z?=
 =?utf-8?B?bm1BUjduNXh4K0tJWWk3dHRBSmRIQWlJekpzQ3dPSHEwek1EN2RjMkJHaHJx?=
 =?utf-8?B?SWNKOEhWTDl2OVFuZ2I1UFN0b3hWcGhOa0hwWUV5cmFLMTJwWFZiaklRUDlF?=
 =?utf-8?B?Vysyd3VhQ1d4TDRNKzNGdmdDTzFOeFJRREl3TytIQXRFNms3NXJIUkZERXBG?=
 =?utf-8?B?WThORGF1OXUyTC93YmpQekNSYldhLzVMdSs0OGh1WDM0KzRubHc0OUt4Wmkx?=
 =?utf-8?B?S0pscFdmd2VtZHFvTG5nRVVtdFFUcktJeG9jbDFkaFYvbi90SHk4TllySjlw?=
 =?utf-8?B?YjVyVWFOMGZZMThsZFU4VXdycm13TCtpUkFqOHRGUnFya0hZMi9UR3M1bHZz?=
 =?utf-8?B?RmNheklEOWRWQnMvRlBOYjk2L3VQVm8xOXlTZUFIRWZZcjNXaHZzaFkyRmdo?=
 =?utf-8?B?NmtiZUhxejl5andKUzE4b241R1U2ZURDWTZGK1VOeXIrdk4xU3ZJcm1FNVNC?=
 =?utf-8?B?OXAwK3BRTjgzU09JelRpeE1pUFk1MTFiMTZ5dWdtQ2pRZUpkR25PdjdXVzZF?=
 =?utf-8?B?bUZMU3lxajROaGp3R0Jlby9sTnJHYWp5SkJKMU02NU1kNFJTbWdFbHYvY0Ja?=
 =?utf-8?B?SUZyYW5GWkZyay9PMmxpbW9tV09tcHFaU3VqZkI5UFhubk9vMjBJdmZ2Q1VX?=
 =?utf-8?B?aHA0VnNjK0xsSXJJWWFQZGh3MmxLMGltSTZRNGczLzNMZG50ZldVN1NVQmlK?=
 =?utf-8?B?K0UzU3p1WVBkL0lveVdRaVJ0Z0ZzSTh0bHY1ZzYvMjhUblVXWHpTY01zcjh2?=
 =?utf-8?B?bW9Ta2lXTGF4Nm14SFR1UzlCejI4elpodGM1VGxoejc1U0xwYm8rSEFCWExh?=
 =?utf-8?B?dW01Tzh6TDI3OUtselFlQmxKRjBQbUNJall2dkpxNFdjY0ZhMGFVeThJdnYw?=
 =?utf-8?B?bTJjTER4Rm1LQUNoNEZYYlhOdEZUZEZkb3BSdWxIMW0zcmtpMEo0aVhIeFp2?=
 =?utf-8?B?b0NkelhDSlUwY1lSNSs1cXQxak1zZ2FWM1ZpMU1BbW01b1FYMUVZeTYvL0lS?=
 =?utf-8?B?UjRBbWlocXNveTNqeHhuOUQ2ODU3WmJwRWVBeE42N0FyK1BLYzdIcU9pT0t0?=
 =?utf-8?B?d1hET1NWNDUxODY1aG5iTkFIVzF6akhEUEk4eVZGSjhHeXp3VDhncUJsNUZu?=
 =?utf-8?B?eFZTd1NLZkJJeThBYUFYTXBPVFd3SGc1M1QzeFdCSkNOeC9MVGFndFR4eHVq?=
 =?utf-8?B?MFM0bWdaZzZXR1FIR3ZpV2IyWFV2VkFlNE9KRHU5SGtXZlhSY0xuRXpYTFVr?=
 =?utf-8?B?bXZKR040blhvNnU1QVVQZ1owaTRnK0ZWNkdYbjdvQlhUbVM1dTMwNzRvQ1J6?=
 =?utf-8?B?QVIrMzc4a1hKRCtmRFhzRWM4R29uRmgrRmI5dlNhOXpNYTNBaWlxV1dDVHVh?=
 =?utf-8?B?bGlkVFlNeTJuZm0rS1JBZGRqR0lHV0lCZ0Foc0VzYTFCNlJPWnZQZ25sVk9U?=
 =?utf-8?B?dHhEbHlsUmRPRFVjUXROdGd2dDFTa1Z1V1BhZDNtNUxIblZLZzZMcURseXpj?=
 =?utf-8?B?ZlZLZ2M5Unlmblo2cmZtaVpwTWxHTjA1dFhPWk9Pa0JVYnhoQStFQXhHME9V?=
 =?utf-8?Q?2I+vk3q1O578iCwJ3Rkkg1gPdTkF+uqK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1oZkkyUFhod0NSVkJXcng0blBMZ2Z0VksrdGY3Tk4zY0xQQjE3WVB2cXZv?=
 =?utf-8?B?clQ0dUNBR2JQcXZaNUNTdUpkdm4xMjZGUGtHL1c4dHJsYVNXMFQreXRpdWls?=
 =?utf-8?B?RUI2a2hyYUwrWGZqanliaUNlNjFKd1dWenFwSzl2RVhZR21lNXVtOXBnUDJp?=
 =?utf-8?B?SUlLOW9WTkFKb1drVVRXWm1zMXZMVUd6c3gvRG9PVWxaYlJwTlJsV1VmQ1B5?=
 =?utf-8?B?M3o5dDUxVmpJQUwxbmdER0IyQlkzVmtkSWZIUThiR1BlRlg0NEdSeDFOK3dK?=
 =?utf-8?B?UUY0MkFHR3BZY25HTmlJL0NTcCtwUGdMQ1FTUFhQQVNoc04rMGl0U0IwM2pY?=
 =?utf-8?B?TksvakNQbEhNYmV5eTVHOVRvSTRnQ0g1K1pYUlk2SjdOR2k1TVJaSHpFaFdv?=
 =?utf-8?B?bnI5OFUxczQ2OWp6T3h2UmwvYTVPV1RYSFl2d0o2dndnd2ZYNXd0YzNXSGFV?=
 =?utf-8?B?c1V0eEpBZENZV0t0dVNLdFJYUERQd1VvbXJIQnVIU1NkV2Y0Wk1OUzY0S1ZG?=
 =?utf-8?B?OVBFMTdZVkRISUFCQjVHOGtWc3dpQVkxTXhIUElFUEhQU3BNWkJvZFRIejFE?=
 =?utf-8?B?SnhNODJkdys4Y3dFK2l4dHRwZVV3bmNiU2RUaVdZb0VmSWd4bUcwbVRYSFFt?=
 =?utf-8?B?eXNGem5OeDlQK0pvZXRZdmZRZFBFOU1STHpVRzRYMlF4STM4dUM5SFRSVTgy?=
 =?utf-8?B?dnJlYjE2QUlic0ZKUXdlZmxzUVdIb05OQmRqekRRS2pKRTNnVHBIc292Sitj?=
 =?utf-8?B?RTlzNWlNNTBBWmo3L0NTbzdEMjB0aWhYazJkb3djTjRhQmxMU3FMVDcrTFk4?=
 =?utf-8?B?cDNXb29zQmprUVlnbng0TllaN1B4Z3poUE5EYzdIV0ZaZ255Y0UyZThKeFJl?=
 =?utf-8?B?UitpQkZLUGRoNUZDelBZazdUWS81eitRK05lVFB3elNMTkwwd3oxcUdCNXg1?=
 =?utf-8?B?ZEZubDhpZ0lvSkJJMXlRRkFZTDVZcnZwMUxFRGQwRHQzOFo3cUU2WW5Oanpw?=
 =?utf-8?B?emZxRmpTcjVaRk1rK1FIU3JRUFVPR0RrYklLdUUzYXNvREJka0djOFZFeWFN?=
 =?utf-8?B?Wmp6Mmt4V0ROOVo2WGsvcThWSnVTcCtQOTNWNDdNRUR1ZVI5aXREck15MTFz?=
 =?utf-8?B?UnZSOFFjbGhWOXQ2MTVhVjJYZ1lpWkNob2Y2U1krNWpQRUZwZTJKZUozQzg2?=
 =?utf-8?B?TmtjQmdEVHc3ZkJTV0c1UlBKQUZYalFQSnR1dVRtSlFiUXhRaGJvb09aOXNa?=
 =?utf-8?B?aHNpVDdoSnBuSHIyR3VRY2JyUEZpOXYwcjlOYnhOeUNrNlY4Nk9mWjdLQnN5?=
 =?utf-8?B?TEVWMiswc2FkYW12WjhVV1RYa2FEK0ZwSzZZQyt3TWdBeU03WnkyU3JIb3cv?=
 =?utf-8?B?YWljRFQwN2ZzOHJxZU1pS0JFcXNIVlVJWWNpd0VMbmUzTlNWSnhDRktIeUt5?=
 =?utf-8?B?d3VtNWVlNXF3RkFJdGhFVkJxVHRDSFpMZ2kxbDNhRExvR1VrMHF5Wkc0M0ZL?=
 =?utf-8?B?U2N5SE83VG5kZ29Ma2xHbWVpaHdKMUhrODlzQmsrbFpDbktqT3NXc0xHSDND?=
 =?utf-8?B?dnQyQTBmQWlKWUFzYzFkVUwxYzJSSTNLc2xuUlpDdVFaVk9TM0FmcDRrODFo?=
 =?utf-8?B?OUhlY2RsSXk4Y3lON2dDaFptWmltbmlIYUJkdlVEU1hIeThUQnlzTitmMGh4?=
 =?utf-8?B?Z3hsS0RuUVYvUWNYR2JxUXFoM2JjOUxrNlZrRksrNW9WQWpaSFlxUm01ODl0?=
 =?utf-8?B?YU9mcGFYLytzMHFyb21Yc0dnR3hDYnFiS0RMQW44cVZ6REc4UUw0ai9FenNV?=
 =?utf-8?B?anVTWlg0aFk5K2FRVWRhTWF1L0pjaFFNUjRKMGZiL3pIUnl2Z0JjUll6dmNm?=
 =?utf-8?B?YW9nY25xUVc1K0tZZUdvU1JKTlZUMDd5N1FYQ2ZPclh2NmJMckdDdDlEYjI1?=
 =?utf-8?B?aitOVUFLUFRydXFNTmhwRFR3TmNLZVpXVGdaNFJwSURUVlpIUWNjNHRZWXJM?=
 =?utf-8?B?S2k2QzBlRittMTlkdE9BcGlXN2lsS2lBaXo4eTh3S3dhKzhyaVYyQTFKU1hw?=
 =?utf-8?B?WEJJR2R5UWo1cHEzaGJMM29xeEpsdmt2Z1RVZmlFeHZ0dStFT2tuR1dsdjZk?=
 =?utf-8?Q?BqRT/TcElyc7D/RlqCvjC4KsW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b71308-8290-4cd3-298f-08dd2bc26676
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:50.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzIevsFKGo2iQlNDGMPqfHjtCG3uIizF8YPrt4WzRh2513A9c2bnDwSpSVuG2ixJiDt56FXTINU4faRtGIDj7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is comsisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50980f9e86099b3103142dcbe38764a..233c28aa501f1e78c4160bdf5ca69d2b474217ea 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P        0U
+#define CORE_IMX95_A55C0       2U
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 15510d3e712495c3508e130fcb2b4df42b07136b..9c4b43174558ec669f9a196c08756bcc6522b752 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -548,6 +577,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -557,7 +587,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -579,6 +611,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -686,6 +741,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -708,15 +772,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -725,7 +800,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -733,19 +808,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -837,6 +920,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -860,7 +944,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -869,6 +953,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -891,6 +976,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -962,11 +1071,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -979,6 +1092,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -999,7 +1113,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1030,7 +1145,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a06ade4792da6d2435cbc4fa07de62..6523d1a0ad109db2da29bae122a20b084c2522ed 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.34.1

