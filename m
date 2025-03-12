Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C023EC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE463807D9;
	Wed, 12 Mar 2025 09:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="BLo0aEV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D7080FB9; Wed, 12 Mar 2025 09:40:14 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8975805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK3vzTXMERzWb8mXWdLBU9e6LXAuh5sf51wC7+tS7x711jWf5GjBqWDaj2wjTp6IhLaNmNKFbRhxbrU0AHzBwoA6KvzLFj3vncia5M1Bx0igeOHZAENjDDLzdHqTCpWikQnODfQxww5U+53y+fd4p3a4mJ/CIl2Mjm9VyhcZD1U3reeSMkiv6jnOyPqJGWNAdGyfJZ7XUmZYTw03aNF12tT8+hsvJ1oUauEz65MCsXuvZKmDBkJu2492q8KXQSeTM0C2aTsq71hgvULSiqo3XLOEz2XHEP4+enDmP3FFMvwgsGkF/JeHKAjpAGYovseIAhWHLcUXpdqGMpgC16HlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMjSMm1VoEtkiPsEyWT7OZ9xqp9SbxkHhOr9BtCDwMs=;
 b=OJ/k358Bu5D2PeKoI3TPm8yYh3S0OXfMUsFI40lzT0/HgdtCz859z8JhDJ798GYE6QIY6pVrDCTM3Pf6GENBIo6i1xUXm6eG7acWRfZBoBA5O7y9gOmvfUjZNck+uyShyagzZCNL3BaQvbe4G5q6ZIcN1uGHyh8sgOznoTQ2/WZt1CMzr6kIaNR0yvd9aINWImMl1gspJgsMwG15sEn/LoymEYoVY0CfJbDcqSTcQhveNNIUd/YgVd3ApDgfLlnHtYz19ZR8We745/Qx4dPq1G1xRdAbfZ7RpMKxgd1/bgvE94vb9ITJZ0AqjV2UQdBjx/4rt3YfXxaFtQ1GvIGICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMjSMm1VoEtkiPsEyWT7OZ9xqp9SbxkHhOr9BtCDwMs=;
 b=BLo0aEV//o4i5XqQ5A+MpAQTQUqf7GR8tJhAo2P/DmZ7TkXI6dnR2G6dSH7ic4tdkxvbKjtaDyijXMlIGJdzo5FUR8sxUegFsbOllz5w6wlHtREjozCuNXLPHZDYqa2H9vYg+F/Gaw9Hav3J/OgaFdFBilPjvC+g0Q8yJObiC6LAUGar5HdvnAygDqrw3RQET3LHoMfGZZYaqQWGf4+Qa/9AxppUIGELTkI/wcNFtUdKYlqXsH3snX5yGUfhNFOJVzX6Js2/PEItePAOlJ7jasVEuGu3tOi3kAKH9H4gMPk6rt/RMThP6nfU9fQ7uCi10LslGucSqLpLc8pDuYpRKA==
Received: from DUZP191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::9) by
 VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:40:08 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::e6) by DUZP191CA0066.outlook.office365.com
 (2603:10a6:10:4fa::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 08:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:40:07 +0000
Received: from outbound.mail.protection.outlook.com (40.93.64.29) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 12 Mar 2025 08:40:06 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS4PR04MB9457.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:40:01 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:40:01 +0000
Message-ID: <108f0807-1b78-46ac-9342-caffe50a6f3f@topic.nl>
Date: Wed, 12 Mar 2025 09:39:57 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>
References: <282a304b-29e4-42aa-84de-485944377806@topic.nl>
 <SA1PR12MB8697648198657DFEE5130A1B98D02@SA1PR12MB8697.namprd12.prod.outlook.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.53f109a0-81ab-445c-85e5-b41f65028e2f@emailsignatures365.codetwo.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <SA1PR12MB8697648198657DFEE5130A1B98D02@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:610:4e::21) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS4PR04MB9457:EE_|DB1PEPF000509E4:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 633d1914-8513-4950-4773-08dd61417e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VlIvU3NWQmxLU3kveTNyR1VzMy80bDhvSVBudlZOQ2o0aVV0RW8yWW5OMkRi?=
 =?utf-8?B?ZFNMNVlDUEdJSVVQMWp5Z213RUNRUkFzdnZPNzdIeG1GdEJuRFcvT09reGFm?=
 =?utf-8?B?Um1odHdNd1JYK1RUSjFVUmpoeW16Q1N5a3hlM1d2UGtmZDcveDRQNEp6Mkt3?=
 =?utf-8?B?MjA0TXhrcmFjVkVab1lyR0ExcDRlSG40RUJNV3g0ZDE5ckJFWDByRnZSUEty?=
 =?utf-8?B?SFRqNTZ1blI5UTVPK2FISi9vR2poeEVQTWQ3YVR3SHptWnZTdEZxOW1Rayty?=
 =?utf-8?B?VE8vVEoyY1lvcEdnZUxaUjRkZEN4RTRPTCs2bWtHN05JeFNSOTNjbE54ZVhG?=
 =?utf-8?B?ckpSU3ZzbHRNYy9qbEl1Y2VxMXJJZHZPR3VqbngzUHVubldaWXdRWnNIZEZ4?=
 =?utf-8?B?NE53c2FwNE9GblYrOHRzMGNMWmFvaXV6RnFBVlZoNXAxZnJXS0FMMFBsUnE0?=
 =?utf-8?B?Ny9Fc09FSXBOdTEvcXVuUDBSaW1KZkEzT1hiUUEyb2h3UUlhRWIyMTRBcHRr?=
 =?utf-8?B?MElQRm5jUjBBT3dCRDI5MzA1aUgxdUYrSXdWbytZVjVXaHJuamMvNXpiK0c5?=
 =?utf-8?B?RWw3bEJvUVZJQW15dVJHUGNUbXpQeUVLRHBCRUY4SW5qand4MkFwRElOd2tC?=
 =?utf-8?B?elRzekJRRkVpWkFrcFVzSEhKVUVJMk1USE9Ldlh5Z1pBUURUT2Q1RGFKa01C?=
 =?utf-8?B?VllLbmt3aUtkNlN4NGZjQU9XeVIyYVRPL25vRUhsNjdqUlFocTByKzlsalBm?=
 =?utf-8?B?M2d0WUNKWkpYcXJscjJhTW83WHlTUVF5ZFljR1N6Y0M5L04rSENLcVZ4NzZ2?=
 =?utf-8?B?bDFpaHUvelpqYlB5Nk5kd3lxeitvOVZxUXAvUlhCUCtZRGpSRFUwTkl3NWxh?=
 =?utf-8?B?YXB1VzU0R3M5TXRvNFp1NGFyUzcwWlNGNjBHZ20vd3NNb1lRVkZsZHRzNmJ4?=
 =?utf-8?B?YU9LcVFTZkY5KzFTWjF4T3NGOEZqZGZhMTJqaENHWkpjc1JncE1sTTM2elpK?=
 =?utf-8?B?V2RiQmVmQ0RCUDJtZGYzcWVDczE4R1c0djBJNEZBUm9ZYzNBM0hDMTg5K3RZ?=
 =?utf-8?B?amRweXJpc2pabUc0b0NTalJzME0yL281MGprdXdZeHNLc2RCMEU2clJhcCtC?=
 =?utf-8?B?Q3NYSnFNTHltb3Jid1o5aTg3eE1yRlZWdkMvRktZQ1dHUkE4eUZ0YSt2bXpj?=
 =?utf-8?B?VUVhWnhmQTVtVUx5aDAvRzdaRDBLM3Z0ZXd5cHYzUXE0dHdxdHNyd1Rxcm4v?=
 =?utf-8?B?TFJ6ZzBoUjZ5WXNxeHd5OCtLSWxXN0xYcWhSd05WblRQT3VzNTRITVdycEhm?=
 =?utf-8?B?QjJEajJ1YUhpb05lQzViTzBEck81WUhLVWlRcm8rWVAzL2p4WlhuU0dwVWZi?=
 =?utf-8?B?V1g0WUE2ZTV4L1VZcjVyMFB1OE1pbEU0bkMzWkZ3aFROQXJRaVhGM2VTZmVx?=
 =?utf-8?B?VXpwUXRoblRQRERkNTJPVVNXczFKSThMWjd2dzU5SlFManZUb1Vxa3J4MTBu?=
 =?utf-8?B?NlFjT0doVTlmYWJzclk5YWUvL01MOEVDVTVRelFvRUZ1UFFGTjhLdENNckhJ?=
 =?utf-8?B?UDZyeExuYlhjdnczV1Nzc2REZEtEYXR2a2xsb0NkN2h4M0NjRWhTdmtocnBx?=
 =?utf-8?B?NDFFK3NEa0luazBhVjZ5MWYwQ0lVbGJXSHNDVHB5WkFVV3dyNGtUMEI4K21q?=
 =?utf-8?B?bk1SNVIzTEcyYVd6WUhIWGVTUnBUZk5aSzltdDFlc0tIdENDY3dTSEJoZ1hS?=
 =?utf-8?B?U01nbkw1d2R6cDRheURuc0Vyd2F5SVR3TUNQQmxIdUtaaU5SbngwTGx0TVpi?=
 =?utf-8?B?Qk9oTlA1SGJLT2xmTHNaR01MSGxrRGhoQjNvSVlXTFBESlZPblRzSTV3ZlEw?=
 =?utf-8?Q?XJOPOzHBgDYBX?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9457
X-CodeTwo-MessageID: 46318037-6a99-48ba-8c74-60e8bb10b92f.20250312084006@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 92ad8169-6ece-482b-d777-08dd61417a64
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|14060799003|36860700013|35042699022|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWYvUWRTbUZaaFZDaS9vcHlmWUVOODlTcTY5Y3YzVWZDbnpmaU9GNEpma3Vw?=
 =?utf-8?B?aytyVHg1MWJnczJ3NHJqNnJEYVNFZlc3MlJFRlBGblpYWFRrM1doaHE3Q0Fa?=
 =?utf-8?B?NkdSSjBwQUFINUkvY2p4RXBCbXpMSTVFUjdlUjNkM2tsM0hEOVFiVWZRQnJY?=
 =?utf-8?B?Z0x6Y1Z4b3VBUzJ4YzNqRk1adXF1emFKVEROR1pxSDY0Qm1qS2phYnEzaE50?=
 =?utf-8?B?WjRXQkFoeXhZTUhtcXRvbjBDN0RUc0I4RGlYM1ZzYjVwWXZzNEtFRFpJOW5V?=
 =?utf-8?B?SEdTYTZ4VGZFUnFON3VIeE53ajI1T0VWNENJMHVQZTZsZ2lQejFoTFZEMU81?=
 =?utf-8?B?Y2pHOTM4ajdzSnFONk5uSTlJVGJ3cldWWmZsNjliNUFjRjg4cmNwN0xLck5Q?=
 =?utf-8?B?V1I3M2VqTnE0LzhyT3dxeU1mT0RLUXFRT0x3R0czMFplSVg0SVlGK2g0MWJO?=
 =?utf-8?B?Y29UUU9OTDJWNlhZRGNtTTB1ZGZCcXpIRHdwN2JzdnBrc2tsZnJveEw0bXd2?=
 =?utf-8?B?RVBmK1AvT1VtSkt3VUhuZjNHOFBoRnM3UjhkYXlvSTFORFpUNWVzSTZwL0lY?=
 =?utf-8?B?TDJHQ0lvSGg5ZWZWQU1rSG4vcEUvcmNFbFJoTFgxQXRNZkdyYk81RmtoSEFC?=
 =?utf-8?B?Y0JKR2ZWcUpMU2lYQnhEKzRaaU91K0lpVXRHYm5POGFtTVJTdFY0MXV2V3Mr?=
 =?utf-8?B?eHRTZGY3K25NRHJBVUFwZHhpTFVlQ3V2OXNNWmVGRDkxSzJPOCs3TXpSYVhE?=
 =?utf-8?B?UjFyRWZkcXA2SGlsOGd4VVU5d2RxQnRCVmM2ajIwVEdqYU9LOFgrbTN5ZlIz?=
 =?utf-8?B?YjdJOFlWR2RMbndkOXJpVVl3U0d1cEwyZkk2S0tPelJGT01jWFNkYWkyWnJs?=
 =?utf-8?B?bU1TOE43YkFwTjlUU3ZlY3p1L3kwUzNGZmhmTGtqMTNncVk2TXRVa3NnOGR2?=
 =?utf-8?B?OU53cThxbFFDRVg3Rmg0SDhSRVI4OGgrdHIxVlFvZTlTaTNtVW5halFVSWgz?=
 =?utf-8?B?cTdsK09hTTkwNHp3TkxVcTBNNlEzVmdPdEFDTFlQdzVhdEFqNEM1NnNLOTln?=
 =?utf-8?B?a3Q5Wm10dk1PaGQyWEN1bVdvT3JCekRwazBuT0pDSlFERXUwTGFRUjQyN205?=
 =?utf-8?B?ZmR3cWNzeGM4Z3NYS3FpYi9oS2ZTTlJZYWxSUkVWcURpL3dMZlVjMzJCNERS?=
 =?utf-8?B?YUhkVis1cmdEbmN6S2RUSUJlaDJmdEw0RWlsOC9HUjFpWkZ4RmIrSFFEZzhF?=
 =?utf-8?B?VGNya3dFUjM5QlJvT2RBcmVNa0JFd0VsdFhaK1FIQlZZMU5BT05DR0k0Mm5q?=
 =?utf-8?B?R1hVaTBiRm9nZC83VTdWbjJOZ3NUTW1GdXFZSXFmNkQ0YXBuZUxCMVF4MTJv?=
 =?utf-8?B?cjhCb1ZBb3hlQTFWZnczQlkvVHFzeXZqWUFFRExRbjRDNzQxY3ZaMUxXamdQ?=
 =?utf-8?B?aHF1eWQxbTJpc2lYQ0l0MGZ1KzdSd0RNb3pFSlFkVW9nNmJHcVdRU1VDYlJj?=
 =?utf-8?B?UXhNcURsR2UzekpmYStPYklZYUZGUFhjRWh6U0FKYmRreHd2aHJEZDBrOXpY?=
 =?utf-8?B?L1hLeDRXVWdiZExjY0R6Sm5RRHV2cmJ3dHBlYXlZVm5SVllqOTVmZDNzVmk3?=
 =?utf-8?B?UXlMa1E3dGhnTVhlcHlBUzdvcmRRa0RjUnMyUndLeW5idy9DTVVDZ3pLdVB0?=
 =?utf-8?B?WHVKUy9SUGFVcjVLWkF1eFNhK29FWlNGT21wQVpLeGYyemU2RWRYODhPTHd5?=
 =?utf-8?B?dmprMVRVZFY3UHZ3ck0vYWRVQmZlK2JOK1VuWk9IY3JLSjY2YXJKTUxhdXhI?=
 =?utf-8?B?Znpzaloydm5Cc0hlWUFVUllRNUF2UDdKbkFDS0VKZ28xMHpVZGhOVWdYakU0?=
 =?utf-8?B?ci9tMzR4UllwUWhoQjhaMG1KNlczUFF2d1NKRGFreEF2cFZBTXpGemEwZ1Yv?=
 =?utf-8?Q?ejNzdBsc2B8=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(14060799003)(36860700013)(35042699022)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:40:07.6245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d1914-8513-4950-4773-08dd61417e59
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810
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


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 12-03-2025 05:05, Abbarapu, Venkatesh wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
?
> Hi Mike,
> Can you try disabling the config SPI_STACKED_PARALLEL.

That's already disabled, the board only has a single QSPI flash chip.


> Is read getting failed?

Fails in SPL, it gets an EIO error when it tries to read the u-boot.img fro=
m=20
QSPI flash at offset 0x20000. Not much I can do then, since that causes a p=
anic.

Simply reverting the aforementioned commit fixes the issue.


> Thanks
> Venkatesh
>
>> -----Original Message-----
>> From: Mike Looijmans <mike.looijmans@topic.nl>
>> Sent: Tuesday, March 11, 2025 3:08 PM
>> To: u-boot@lists.denx.de
>> Cc: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; Simek, Michal
>> <michal.simek@amd.com>
>> Subject: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
>>
>> After a bisect session, turned out this causes my topic-miami board to f=
ail to boot
>> from QSPI:
>>
>> Commit 9bb02f7f4533: "mtd: spi-nor: Fix the spi_nor_read() when config
>> SPI_STACKED_PARALLEL is enabled"
>>
>> I haven't determined yet what the bug is exactly. The board has a single=
 QSPI chip
>> attached to a 7-series Zynq. SPL fails to read from it since this commit=
.
>>
>>
>>

