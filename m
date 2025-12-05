Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62E8D2CE01
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 01:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2381A8412C;
	Fri,  5 Dec 2025 02:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QE+8NWMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B3F8416E; Fri,  5 Dec 2025 02:10:58 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040C88409C
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 02:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnlaUAo3g+AOz7vQu3lJerUhrXYKAuVS8ycVPpZsbuR92GVLVoFggAo8Xv63wTaibgF6eY2Wb+qK/Ja3Qn+o9NS/VA1qs81uULA03Yc5jzgnbee/1qa2+PgszZFyxdkCu8j5WBDrdJ6Fvewpp3v8C4vv0s2vmI5DbexV6ypUuojvhsXI2SThNHOnV18vjc55cPgCSDKtaJAI5cKkXDo3+bd/eSV3ZONVbpRg/iuZB0aJzae0EBPMIud7Iwbcd+DV/q0aipE70YPksejkbgzXZ5FzVZgfINiKknTnUBggaW2Ex28HvanGmrsqfkvo6HnndgHXog7NdklynRrzRiiwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq1mZxvk2VumivP1HMJXsNCf8FtlRey1lq0D68lEhm8=;
 b=QIfF4ioHL11hEbo+1XkpGPW/3CalnQa+qlKOue2cpQ9bsB3S9nI5r1imN19ueD5YReBVZ7sLLgn4GKhzxLNr/w9WE7f71aQL5x8WB/tzP9zIaYD5DSvGzO06KKJmrtFaluZK1q3t+rgih8e2AhNOp9TfA9BGE+pMmHkqKlM5s1QCUOqfIjIQPu4JXhHA3jVZDPcglsw7LKC8YVF+xGLwytXbR/be7iTvyIyZ1/T1iE0oxly3+GifjICdrOcXUq4Tge3YfaJJHO/9UHQoeM+GI4BMaXtr/VMCuldwV1hZ6+Yjks2+Lg1+2biELaPVagtUNdC+YgQBkrwmjfi3eM+dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq1mZxvk2VumivP1HMJXsNCf8FtlRey1lq0D68lEhm8=;
 b=QE+8NWMVgjx+C7E+j5zDKnZOn+oLb1+5X4GWSfPeylUHyiDe9WUniHXieU9acNulIs3fD5U0IoacRyKFg/EJBt6vs+jibY3xHJkISnOYr6xKlAl+iw4H1TzS91VEr+ib4ZAxim3mhjORfkDRvWkCbFBN8r86ssKN6PxoMVav5g35/Xc+dFUcIc6SC3aHkDHRY4+f6+Qhy5R64VDTCD5/MHIikkJTonOj26wiEt4Am6u9F5J5r7N+VwhCGmZUexFaYGDegSgPRM+z9dMT6EzlRqhG03awqjxZEttdV5u+D7jV6yYs5xgPQ+9PQlMF3LntH1uvi0wq8At9dU5aDWL7Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DU7PR04MB11091.eurprd04.prod.outlook.com (2603:10a6:10:5b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 01:10:53 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 01:10:52 +0000
Message-ID: <02e71eeb-573a-48ba-910b-f9feae66adbd@oss.nxp.com>
Date: Fri, 5 Dec 2025 09:10:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de,
 u-boot@schwermer.no, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
 <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
 <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
 <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
 <bc75cd00-2372-4dac-821e-74bef5790e34@gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <bc75cd00-2372-4dac-821e-74bef5790e34@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DU7PR04MB11091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcd06d0-19c5-4ae3-0226-08de339b2250
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|42112799006|1800799024|366016|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STdNc25nS24yUnA2dnNsd3lJN1dXUWk4L0N4NlZ6M1VneERaTG1oR2ZsY3Fp?=
 =?utf-8?B?dEVNK2tIWWJkMDQvL0VoOVRVbVBXdzhWTFRzalVWUlk4NGJmZUFkcXRFQ01y?=
 =?utf-8?B?R2ZvdE5VYTRKWDhnUEcwcUJNL3pUWnFBYlNvZGtNaTlUeFBIdzdLb05uOVVU?=
 =?utf-8?B?dmw0Mm03dk1YamJIcE1SZkR4OGpjTGV4K3VObndCTzlUdzRhWDdNYTB5Wk1j?=
 =?utf-8?B?VlBPZEZOaFpjMzZtbUxjKzZNRkw0NFd2cEtHUkZOSmRJT21yR1BKOEtxQ0lP?=
 =?utf-8?B?WU1xTHB1azFPaFpZU0kvYVIyaFl6NEZiMUc0NTh3RWZkVzZnd2YvSmUzazFo?=
 =?utf-8?B?enZhdHlvTWxzRGEzK29NelRMaWFTVzcwZ1daZkYxTmQxSmN0YlBod3EwQXpF?=
 =?utf-8?B?UlA5S0pMb0o0NGRiWHFIeXpaOHNUY2VGbzlTenJLVVgzVmNIOGdXTStxMTQx?=
 =?utf-8?B?WFVKb0NiSUJ5MXBZT0NWSXJqOW1tUE9Jbk0zZkgxVmUreUpJTTVHL0JadEhx?=
 =?utf-8?B?WmpseGt3R2tUQ0JWTGxWSURGUXI3NUFOc1FvekhBSjFSSjJzMU5BOXpaajdk?=
 =?utf-8?B?aFA0TE1qWk5KOWV2bm1JVEVONzZXTzdsTnJzNmFQNy9qL0tQSGR0MVlIRzVs?=
 =?utf-8?B?UmJUeHJMVlBwZHR3aExReUdoL3EzRWx3ZVNWTFV3TFpXUmZGc09HRVJvTHd1?=
 =?utf-8?B?R0ZmeE50UENXdmpaZlZTbExuSHdkL0dzT2F5U1RFc2hNcDNpZ0JvVWZRZ1Jq?=
 =?utf-8?B?QVB3VHNnSjVvaWlEUUphajN4SHI5SjF6emppVVFXZ3A4a2VTRGNmMHlrVXFz?=
 =?utf-8?B?akdxYkJySlNONkRkTXhBcDF5UXFPcUxuRkJVTjF0c2M1aHk4a3BuY2hNakhj?=
 =?utf-8?B?QzNMRkovUWQyWUJXTDhZc25BeVM1a2lJMFJhTlhYeXplNm1mb2FtQmZUMnBO?=
 =?utf-8?B?ei9wZ3BHL3ZTckUvbnVhemN6QjlXakdkZHhnNm5xMkdGYkM2MDRRclk3d1cw?=
 =?utf-8?B?MHhSTTN4MHRMT0M5Zm9FYU9nYlI4aGhrandTdHVlNDVCczJqeW45V1pMRktk?=
 =?utf-8?B?VWZPR1RiYnZrdnhrODN5aDVwVHZwaG5DaFJOeUxlQkM3MktPVE4zVHJBMGJl?=
 =?utf-8?B?NDBjQkg4V21vRllrWmw3NWdEZGRYMFpSY2tJZXNnTmt3ZFlyRjFkUTJPOGlu?=
 =?utf-8?B?clg2REtGNlNMSW4vdWRab3Nmb0UvNzJlYTlUbm42R2IzdDljTEJTNzZZUGhN?=
 =?utf-8?B?VHFXTlBudkZ6WGY4WWM5b2tkMUhINjlKdlBYdUhhZ2Z5b05EM05FVzFsaWYr?=
 =?utf-8?B?VGd0enh3WHdURy9Ec1QvdUVPQXd0K2NPTDI4azdDZE83SUQ4OFFRVW5UUzVT?=
 =?utf-8?B?elJIY0grWHEzeHFndzY0QXFvMjJIZWhDZXE5QlFISS9XbzhPWWpCcjBmTnF3?=
 =?utf-8?B?RkhhS2hFYm1KaVRqSzMrclF1a2xLempONnlONmNjNDRKLzNUcU9HS3dUVjRY?=
 =?utf-8?B?djVWaXNZS0RDOVZ6N1NIRUJhSWZhM3N3UVBRSnJhQUtvbVZoUTBQNytOcVlo?=
 =?utf-8?B?aHQ3OFF6NFE3RUV6MDJKa1BWTXluMVZiNTdjVjduWlNVVDNjamJZMStwbEd2?=
 =?utf-8?B?azZ6Sk1BU0ZySjFDWDc3enhtMjBoR0N0aFMwc1dvT1hHcG5JN2MvcTJOSDZk?=
 =?utf-8?B?L1REY244eUdCak4xbEtpRXExdWtiN1pkV2wydGZmYkNyM1Y2eE5jYTRid0JE?=
 =?utf-8?B?N1pMOEIxbUJZQTcvemk1SU5yRi8vWXF1emtJVlh6aDZPaE9mdnVxcXBwTWtK?=
 =?utf-8?B?NHFVRWppdzBicXdaQ3RtR0tSZmlpZG5welErRXh5N2E5WWRWUHlPa0l6TklX?=
 =?utf-8?B?WVZmTVRHTVhoT0hhOWVSK3ZDSzVuVHBobGhqbENZb0N1ZEJoRU5sem1QeVBY?=
 =?utf-8?Q?5ZBiZ3ivPXjV5nYDiPqVr1ALkIBJI6vO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(19092799006)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFhjSjBWZDJLOE4rL0trSmZhWjJ1bSswbzkrSXFneEEyYmtCYnZDRS80b1hv?=
 =?utf-8?B?dUxGVGVTUWtYY2twaE9GaEZWQyt1UUN6aUdJVnE4ayt5aW51d0RiNTlpVlpr?=
 =?utf-8?B?eit5MjRZcHZqcmVsUEEwUXllblFBWTNIckR6VWkvZHpkd0tXMEh6YkQwU3B6?=
 =?utf-8?B?QzkyUGxsWHVqRzBQYUJjcklmR3M4T1Y0OGdaODFJRTYrQkpGNkFyc0xVS29w?=
 =?utf-8?B?aHVOaUJWZ1VsSE5LNCtnY05vUUhDYlk0Zm5VdCtQZlZmV0NidDVBZ09HVUtH?=
 =?utf-8?B?eTYrTWJpT2xudmNLbHdzUFlvdnVCL01XM0sxWEhQS1lmNmc0cFM1bmZuNjBz?=
 =?utf-8?B?T2hGTEVkVnp3eEp2VHJ2UStveU9rbVlKSElYQXdVQnkweTRzSU5DY2tYdy8w?=
 =?utf-8?B?RzNEQXE3ZFV3WGJKWTNiQ2dOeDdDdWdHQmFNTkc5dmo2TGlMWlNnbWRuSmN0?=
 =?utf-8?B?WGtSaFVDT3BFbHZ0NkpHczRhMk56RWluN0FHTjRpbDJCWDQwc1E4aEFGQ3Yx?=
 =?utf-8?B?QXlWNnkvWEVFRWdpeE9vVm9FazZZbFhLaEh5TE12VENERmxBZ1FyMHYvTCtZ?=
 =?utf-8?B?eENxZFI4L20zV3gzd1NrWEh6eGFyclVnblI1OWRYeHJjRGMwZW9KUUxnSGMw?=
 =?utf-8?B?U0hFK2R5Rkt6OUtRSU1IejVQNFZIZThaa3VFWmJYazlWYmk1Kzh6dUtJa2Ji?=
 =?utf-8?B?N2F4RGd0blk0QXE5bC9VaGxsTnNwbmtJUVVLbTAzVWgrT2JnK1E4citGT1Rq?=
 =?utf-8?B?dkZIbzJJbFRZOCtUbTBBWVZCcTVaNDRLbnRRQzFhSXB0TDNlcEJGSW5vdlFk?=
 =?utf-8?B?M2VsSm9DMnlSS2JJTDZkRUtnT0ZHR3pkTmg1S2JBZytPMTlZQUlFUUxGWERx?=
 =?utf-8?B?K2xPVWZnUkxWenFGTTI0MXlCbUpwYU52QXhhRnZSd0NmaVpLMndZWGhLWnZt?=
 =?utf-8?B?UHZST3djZjZpdFFkOTJpNzZzVFhCUUdCOElZWXowQWhnaWdhVGgvelZvdWtL?=
 =?utf-8?B?NFZPYi9rTEswL0VLNXlUeUtkbVNoYk8wWWRsK1BVQkVUMDZ6TllXUStud0Nk?=
 =?utf-8?B?YWNsWWlVZHRIbVVxNWx5dUVlS0I4eWtzQkMwdDY5YzkxZGdwbjYzZWthS2pD?=
 =?utf-8?B?ZThpQnJMQlczcXFFSzVwS2twb0VyY0daQkpvblRyRmlwSjJKL2kvU2dHSTNx?=
 =?utf-8?B?VlJueDYxWXNaWUNPNjlYQVQ1WTFwOFFFbFVEOUltNmJSd1dxUkJraEU2TE5O?=
 =?utf-8?B?SXJuVVVkN3IyV1ZLcklhZ01wMHB2ZTAwdVhUNFBnblJoVjFpdTIvNFQyRjly?=
 =?utf-8?B?NDN5SW1sTndYWmlPSXpvM1lKaWlweEdGUGI4ZVlDcEN3Qko3YW5kUGlOc2VM?=
 =?utf-8?B?MWFoV2VGcWxDb2lLWkFOLzVqUnlDQzh0VjlrdjlqMFFmZlVxbmQ4N3V4RnEr?=
 =?utf-8?B?L2FqN1l2bEpyKzdNZ1V2Yy9kWnNDbkZ0ZTFTbldtcjhrUmpCeC9SMkFOeXFi?=
 =?utf-8?B?Z3F5QTJRQWZaYThYamd0dUxhdXo2WkY2bVN2ekhmdS9nREc4RTAwTXBrd3Fy?=
 =?utf-8?B?dFNPSUpYajVhWEh6dUIycjBUSTVjZ0hUbHdvUmNkdE5yWVpDRnlxemtldkJJ?=
 =?utf-8?B?L3NpTTU0OFJUb1BUL0ppMVRrV25YOU40TnhvLzdlN3dMZE1Jd2RXYXNzRnNM?=
 =?utf-8?B?STNMOGJWRFZES2dlNm9nSVpjRnJOUFNldGs3WDV4YzdmTk5NY3dLSG9CY2RX?=
 =?utf-8?B?UVBKRVozanpvb3E3M0JhK3Q2c3EzWnFZZGJ6ZkhZTldoSjFpcHIwZEUxemFv?=
 =?utf-8?B?eFB2bUZkOTZRb2x3NmlWWWxyZTRUdTV0b3A4dEpla3FaWlM1MWFqTExIMU5i?=
 =?utf-8?B?bmpSY1hnZE9odWxXakdhRkp0Sk8wVk1oMzVGMlJyNG5SU3JJRGhZbDJ0Slov?=
 =?utf-8?B?VkVCUDFkQmpwKzJlR0VFUHhsZHRDZ2tZb05ydnh3RGVSM2xnRmJzZGJuZjBO?=
 =?utf-8?B?WUNRTEM2M0V0QlByaFphKytDc3c3bXdaSXJReHkwNDY2SEFJOUtKV1hLNCtU?=
 =?utf-8?B?ZE81VXk4aVQ3UEdEM0MvSU54QmdyZkpyY1FPMVc3SVpRZ2U5N3hUR1NhM1Vt?=
 =?utf-8?Q?yjUs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcd06d0-19c5-4ae3-0226-08de339b2250
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:10:52.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UXgOnDiPxiR2hX2kkprc2JPOF1PcuNgp8/kb4FNTOzwff299CJARQ6YcIf5DGnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11091
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



On 12/4/2025 8:01 PM, Emanuele Ghidoli wrote:
> 
> 
> On 19/11/2025 08:49, Ye Li wrote:
>> Hi Michael, Emanuele,
>>
>> On 11/12/2025 6:07 PM, Michael Nazzareno Trimarchi wrote:
>>> Hi all
>>>
>>> On Wed, Nov 12, 2025 at 10:57 AM Emanuele Ghidoli
>>> <ghidoliemanuele@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/11/2025 09:16, Ye Li wrote:
>>>>>
>>>>>
>>>>> On 11/11/2025 9:47 PM, Fabio Estevam wrote:
>>>>>> Hi Emanuele,
>>>>>>
>>>>>> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
>>>>>> <ghidoliemanuele@gmail.com> wrote:
>>>>>>
>>>>>>> Hi Fabio, Ye,
>>>>>>>
>>>>>>> At Toradex we have been struggling since quite some time (back to 2018)
>>>>>>> with
>>>>>>
>>>>>> Does this problem only affect early i.MX6ULL silicon samples?
>>>>> Hi Emanuele,
>>>>>
>>>>>       I have same question as Fabio. Are these samples are early? Do you know
>>>>> the time of receiving these sample? And could you show the part number
>>>>> printed
>>>>> on the chip.
>>>> It could take a little to answer to the first two question. I can say that the
>>>> SoM I'm using to validate the patch was assembled in September 2021. Let me
>>>> know if this information are needed giving that I can report the marking on
>>>> the chip:
>>>> MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>> the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
>>>>>>> issue we observed is that the thermal shutdown seems to trigger too early.
>>>>>>>
>>>>>>> I have investigated the history around this topic and verified some
>>>>>>> internal
>>>>>>> notes in our bug tracker. With this revert applied, and on the devices
>>>>>>> we have
>>>>>>> (all trimmed with value 0), the reported temperature increases by about
>>>>>>> 10 °C
>>>>>>> compared to before the revert. The absolute accuracy of the readout is
>>>>>>> questionable: for example, on a device kept at around 20 °C, the
>>>>>>> temperature
>>>>>>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>>>>>>
>>>>>>> Consider that for devices with fuse value of 6, there is a -10 degrees
>>>>>>> offset
>>>>>>> after this revert (so, the other way around).
>>>>>>>
>>>>>>> I understand that for Sven this revert improves stability during large XZ
>>>>>>> decompression in userspace for few devices, but for us it means that the
>>>>>>> thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
>>>>>>> our case.
>>>>>>>
>>>>>>> I would kindly ask NXP to double-check how these devices were trimmed.
>>>>>>> My gut
>>>>>>> feeling is that there might be an inconsistency, either the trimming
>>>>>>> scheme is
>>>>>>> not backward-compatible (e.g. old and new devices behave differently,
>>>>>>> and the
>>>>>>> code should cope, I don't know how, with this), or this patch must be
>>>>>>> reverted
>>>>>>> (because introduces a regression).
>>>>>>
>>>>>> Peng/Ye Li,
>>>>>>
>>>>>> How does NXP suggest we handle this? Were the early i.MX6ULL parts
>>>>>> incorrectly fused?
>>>>> I need to discuss it internally, will feedback you later.
>>>>>
>>>>>>
>>>>>> Can the fuse be read and dynamically adjusted?
>>>>>>
>>>>> The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it by
>>>>> "fuse read 0 0 1".
>>>> Colibri iMX6ULL # fuse read 0 0 1
>>>> Reading bank 0:
>>>>
>>>> Word 0x00000000: 00320003
>>>> Colibri iMX6ULL # fuse read 1 0 1
>>>> Reading bank 1:
>>>>
>>>> Word 0x00000000: 00000080
>>>>
>>>
>>> As is clear this problem was the same we had some months ago, so we
>>> are on the same page
>>> with Emanuele
>>>
>>> Michael
>>>
>>
>>
>> Can you help to measure the VDD_ARM_CAP and VDD_SOC_CAP on your devices with
>> high temperature read issue, when REFTOP_VBGADJ is set to 3'b000 and 3'b110
>> respectively. Provide the measured voltage and target voltage.
>> And please read the Unique ID fuse of this device by "fuse read 0 1 2".
> Running u-boot, VDD_ARM_CAP and VDD_SOC_CAP respectively:
> - With REFTOP_VBGADJ set to b000: 1.08 V and 1.11 V
> - With REFTOP_VBGADJ set to b110: 1.06 V and 1.08 V
> 
> Best regards,
> Emanuele>

The voltage looks strange. The Vmin of VDD_SOC_CAP is 1.15v when LDO is 
enabled, your result violates the spec. Do you enable the LDO in uboot? 
Can you dump the register 0x20c8140 to show LDO setting. And what's the 
measured voltage of VDD_SOC_IN?

Best regards,
Ye Li>>
>> Best regards,
>> Ye Li
>>
>>>> Kind regards,
>>>> Emanuele
>>>>
>>>>>
>>>>> Best regards,
>>>>> Ye Li
>>>>>> Please advise, thanks.
>>>>>
>>>>
>>>
>>>
>>
> 

