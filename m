Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E19E7AD42
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 10:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7C984332;
	Thu, 25 Dec 2025 11:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BL3l9SqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55B684333; Thu, 25 Dec 2025 11:16:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC52842ED
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqFERzc/i2UFOxAynPRSl9JGQYfn6QZbvda6I+gC7CEvcl/CX7lT6QdHlqwHBo1nNXPs4Ya6BO7SIZxUQoxAzUWo0Jrn+AWjWcToejEmLK8seObwyog6MnkN4M5+B9neYQ7jzUzteBlqQmFRDHR1d1IsBLONa9pICN9z/icMkBfCTojOWyrig/iX26WqQ9Te17OS1a3X1fHy98V6SrWtClXE6PAWtEMLtlY389ysofNJae4AhDb5xY78qKagxq9/1mFDN9bDvPD1P6mp5Ls+F2rdb+wzZsMw70bkOaviC1zx3v5kOUQa1FNKUAVs9AtNyaTBV7LkHSP1nzDFuPixPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeTCKzCz8NVnK5qpJx8/mxOWrhebtPc4ouTim7G0Sh8=;
 b=xCn9dU4mlaEtg//UjnuwxVexcDb1gXeqtaDxoV1dN6baT0Mg/ZA6Z2fgEjW3nZ0eK9trNJt537Mxjd6TnRvjxtaZQWlbmdMHUeTPuEn5D//f038tUdEgHhPc9T79cnw9YRyw1KFoe62tAp4fRqjHq47oLn/Xjiyj3+cDuo4fhyPD7/N7DVMDqi8vWs4XbFJOSH2k4NNl90stol/Qb6CHSf3dEdhZnOnLAF83CLM03vexc0VepB+OyoQLuduR6C4/6MLX8KlqQr++R2AWOcmmoeveQxI8ofDB0bGG6SSpnwrvnJ4/Pzqjc4SBFyjEsCHWLGo4vUslY+71wEcFujPqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeTCKzCz8NVnK5qpJx8/mxOWrhebtPc4ouTim7G0Sh8=;
 b=BL3l9SqBbyDtTCwaJubX/34UOP2KugSNEwEls6d4M6gZQT/vNhR0ORHU+HOBCPtIHgHHPp5VIOOcO6BZS05JouhHQa0y2xxZHw9GpeCs6YuNFvV2MkTUE89GLwpOa147i7KtHRPah+Pg47RdeuhVfixLx6ZzS0AQ8IHSCzkdXa+hFy8BMCVwa2UWdn1PYsO7wLEBSoKXN6tjsi1qdpRNHAYVvnviOXlOs+Wc+5aNN5YTjaLO3HKE1cXodoU7Km2cvtSUYWapooup7tz5usvvDSAB1ZF4wVCaeKUj08JZG/+I9PwaIRH15SGLy78Mo+r7gNfM8m2kEj/89SI42qaAog==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7947.eurprd04.prod.outlook.com (2603:10a6:10:1f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 10:16:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 10:16:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>, Sherry Sun
 <sherry.sun@nxp.com>, Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman
 <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, Simon Glass
 <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgNS83XSB1c2I6IEtjb25maWc6IGltcGx5IERN?=
 =?utf-8?B?X1VTQl9HQURHRVQ=?=
Thread-Topic: [PATCH v1 5/7] usb: Kconfig: imply DM_USB_GADGET
Thread-Index: AQHcdYeIKb9VwvAg006AuEW85bsvPQ==
Date: Thu, 25 Dec 2025 10:16:29 +0000
Message-ID: <PAXPR04MB9644C66E9B8C3109941561E1E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
 <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
In-Reply-To: <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DBBPR04MB7947:EE_
x-ms-office365-filtering-correlation-id: d181f9b2-1cff-4e6d-b692-08de439eab69
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RjljKzlrWmJIczBhcWx5OHR1YzBQUlBzSUNVK3FLZkE0ei91K3drL0liUXBR?=
 =?utf-8?B?U3RNN2RzdGdEQmpkd1pqTVZIMDFFWkRNeWU3dXlQeVBvVXlSYzEvQ1hnbVNV?=
 =?utf-8?B?dEFDMEZkRjJjVzA5M0FnaUx4ZVdvNXlXeEkzclBkRjBXOUVTMi9rV3lUTjBj?=
 =?utf-8?B?VEVHQkNLQmVwc0thSkphUkJOc2VCSWdCU3cwM2dZTm0vcjB6TUdocEV0V1Rk?=
 =?utf-8?B?eUZiNWVidVdOYjBTbnZodVNnZ2taOHJudk1xK01DMmszVC9CZ3VYQTY4YW1U?=
 =?utf-8?B?b1AxaHdBUW04NlFyN3p4MVByN3RxMENGanNNUE8rbHRJbmwxN2VoTUZBRTBI?=
 =?utf-8?B?b1pwV0dtVlZUaklHT0Nia2I3L1VDQjlzUGtwUEl1NGZadjVDRk1RSGtpUEpq?=
 =?utf-8?B?QXdLeVAxL1BEWDJKMjJGUnRCenVXd0Z2R3ljRE1PWDJ6ZXZsTkdKOWJrZjkv?=
 =?utf-8?B?N1lPaCt0L2NnM2hnSnMvSTFxcld0MXlTaTZTWjFtcTRGYnJtYkhaZERBZUpr?=
 =?utf-8?B?OUd6ODVCUUhyU085dnRlTTJRVUw0WVdCM2d5d1VWWHR0SnZ4enkyZ2xWUUV5?=
 =?utf-8?B?QWpscXdDRG9ENWlnYXJ1ZDJBcXR4RExISm9DL2crQ0JNOGZvdjlNQ0FIaDRE?=
 =?utf-8?B?R1BWUE5aVytjZGxpVGxLa2MzeDdndHFYelBYY0NuTGZBWk1QSkswNXdORllS?=
 =?utf-8?B?L0VGOUJsaTF6M3hqQ1QrTHRSNHduWDhuT1g3WEcxNUlUcTZTNkt1dGtUblc5?=
 =?utf-8?B?UVdXWGVUd1RtbkFkS3pDQWFReVhidjA1QmlpcGVZa3lVN3M3WlFpMkNXME5H?=
 =?utf-8?B?enhraG1WTFV2Nm16Y1NnbmpleDFwblJqblcvSjVtV2pBQTZOYWhVWTRXaWlD?=
 =?utf-8?B?dFh1TEtVbkR1NXY2UWdkcnYyUFhJZ2FHa0NzYXFPY0FVZEt5VnMzd3pWU01a?=
 =?utf-8?B?cUZEQUhmR3hhYm5maThwaXV6ZWY0Y3d1ZGx6UDkrcUZPZUc2M1pLSm1ZTzNG?=
 =?utf-8?B?SEhxTEhpVG45Wjl4OGNCbzgyb2hNOVhCSkkxWGdTa00zSmpUSHFBVDVVL0dO?=
 =?utf-8?B?U29SVHhyM1JZU2FUd1FMQ0NoSU1Mc1J1T1hPREI2TTgzVmcxS2ZHQ0pCckhv?=
 =?utf-8?B?SzBWQzdlSmRVcEZtMW9Vd2JqeVRqeFBHc3dxRTQ4T2hyRXd3ZnNWTG1VZ3BC?=
 =?utf-8?B?TEF1Y29WQlhTa1JYU2s4QUYzT25LTGk1OURySTE4emNiLzdLR0tOZFU4RVU3?=
 =?utf-8?B?SW1xcnQ3M0J1Q3plQ0RXWTRLVzc2c0RseG5jMFFBN2hmRzh6QzJNWjZMOFcw?=
 =?utf-8?B?SUhWK05mcGF4WEFzRHpXTXdZd0tyOXg1Mk9DNEtTSEU4RGcrSmpTL3B5a24x?=
 =?utf-8?B?eW8wYk1wLzdwajlvdGVTODVib3JLREU4WDMrUW40WkcyNE0yRHFKQ2xhU3Uw?=
 =?utf-8?B?SHE2WkxzSU4wVGc3V3VUSml4MmJQWFpxTjRMT0pYMVNUNGNKOFVTRHF1WERO?=
 =?utf-8?B?Z1BIeisxOXhwRURXYUVnbW84NlQ3S2RvMzVKRkhSekdmQnhQd1R2N1FxbXd6?=
 =?utf-8?B?YXp3TWl3VDJBaitEOGlNUStOaVN2RHR3UGplc1pDTEJBSnRINC9wWU04emh6?=
 =?utf-8?B?anZmc2JRUGtkTTE3VFZCSldTNEdRdWwvWlhnbmhCOXBwWStWeWxGZWpjWTI1?=
 =?utf-8?B?VUJJVVJxbVNEc0RBR3M3aHpUT2V1clRLS0FhY3NxaTdEei9HcWF1azh5OE5J?=
 =?utf-8?B?c2lEZlE1SjFQa1RFVkR3M2lwMzZwbUVuMkNaaGRlQlFHYkZtT1cyenJXVzNF?=
 =?utf-8?B?Mkt3NE56QUthUmpqUGdkMy81T0ZKemlGMmxYQWxZMXVzckZQSWpQL3djUnhl?=
 =?utf-8?B?Y1BKd3prekZOMFF6TFdnN2ZycS9QVUZLU2htMnh2NnJrWnBIOVpEa2N6RUh6?=
 =?utf-8?B?MFB0T08vRmFYTHlhUVBnMzN0N1RZWGtrYjhqbjNoQ3FXdzIzNmExT2M3L0FG?=
 =?utf-8?B?RHpucEdLa3lGZmFKMUovb2xrSXIwQ1k1M1FFbWgwa0R2TVYxZ2FKZ2UrQW50?=
 =?utf-8?Q?tdfS/E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L252S2J0cWtQWmZ0N2drV3RKUnoxY1BBRk9PL1ByS1FMNGRqWDFEN3JYZXNi?=
 =?utf-8?B?a3lydjRXbUUxQnhGQWdsVC9SdzVvS1FMVEZiYkpKVnhULzNXeEFDZGFwV2JI?=
 =?utf-8?B?ZVpsTmRCNmY0U1hRTmNtckR0aWVSWE5CMC9WZXl3WGlaSzY2TUFaejIvL0hy?=
 =?utf-8?B?cTR5bUNKQjBSZXhVRVN5SXRqNTlvY3pQSUhJdHFRN2pGTW50S2laQ05wMC8y?=
 =?utf-8?B?VnZkRVlablg4Tjk3czI4NmRKN2NnRVFaS0NPaEs5QUNYbkFiZWozMzlJMERt?=
 =?utf-8?B?OFJoM3N2NHhxeDdqWDZaOFZmYy9Md09lWjU5ZDcrN2F6MndmNS9qK1dJdW9C?=
 =?utf-8?B?YkxXTXprUUN4SW5zUGEyRnVNWGRRYTNMY1hYTDlMY2FQclc0cFR1eTREN3c0?=
 =?utf-8?B?MkRiYzZzbjFIa2RIM1pwaG0wNXc3aDQxSVRjRjNYeFZpR216R2dQMEdOUnVO?=
 =?utf-8?B?ajZKbjJjbVowdnY2SldRN1kzdno4bVJEWElyd1Z6dnE1enZoclVUSGhZMW1S?=
 =?utf-8?B?QnI1MlhWNkZMOTBxVWs5Y3RsbXJIRVZqb3BKUU9xUUtabTRaRjZxeldNTE9o?=
 =?utf-8?B?RUlrQThjZEd3ZTljYWdzQWRIRkE3TTBYaEluRTRUZUFEcmlnQkVqRFovRXlZ?=
 =?utf-8?B?WDJBN2lpR3VEMnljZE5odWwzTnB2N2NsTWtLcjRKOVJjK1FocWhDUGkwQ3dz?=
 =?utf-8?B?T280T25VREdkdXQ5bFpnVnNBemxucFdDU1lsZ05YdjFPdU1RcjFGSytGMXNp?=
 =?utf-8?B?U2RBNTlBUVJmUlNpZjFnKzN5SThGWGc2Q2NQdUNhdSszWnFiNXNseG0yQlVj?=
 =?utf-8?B?c284NXFGeDBsRUlwc1BWQStoSDhOZ0t6V2NpUGV5NWt3SHRxOXNJMVRpTnhp?=
 =?utf-8?B?UjRqZVdvQzRnV0wwV1JYdndqZERMRjFkSHZPOFBqNGpKRmw1RlVEV3BVYmlX?=
 =?utf-8?B?TzQ4aVZ0T3R5cXpsVUtQK1FPa1djLzg2eEhhdU1mclVsMG1LV3ZtQUYzWGt1?=
 =?utf-8?B?L3RtdE9PMTJYajcyOWl2NEI0SjcveGRXTVJWSm9MdHBpYlZyb3MrejRoUHF2?=
 =?utf-8?B?YWp4UC8wVG90ZUR0dmZWMForUnpBcHRhd2JiOTVsMTJKYVI0OXJxOGlnTlFZ?=
 =?utf-8?B?VE1vMjcyK05DQzgyOVYvYWZlOU1wSUxhcGVscXNoczRnZ0dZeUcyYUdoYVE2?=
 =?utf-8?B?djRSeWVEd1M5R1RDODRzU0tNYllHN1FGN0c0UVMrczY4TFJYdWtOcXVVbHkw?=
 =?utf-8?B?bXZKd3MvZFozc2RxcEVYSkF5bkNvYWZ0bHVPQW9qYWw5eEV6VTJUakdhdmRP?=
 =?utf-8?B?bTdsZ2dOaHB4dEFpMWV4eWNrYVFmODRoOVg2c0FCemFQV1kyLzdXVTV4bHdI?=
 =?utf-8?B?MHArOVpGeERuL1FWZitIWThFN3J5c2FsbDl0UXd6V3AzYVNURWtMZjZaNkY1?=
 =?utf-8?B?ODRmckEydlZ2WWNLcHVCVU1CZXdCWFlTT0srMkUrVXpKV2xMVUJ0ZUtIWEk0?=
 =?utf-8?B?K1FDVnBMWU5KYzExRXR3Rko1Umx6cUJsL2paekZjUXFnRzloU250Yk5ER3Ay?=
 =?utf-8?B?eSt0VTJKV3FwZlgxdmFKbDVtMk85Nm1GT3p0TzczbFlHL0dTVjdzUFVIODd6?=
 =?utf-8?B?akdvaGM5UmpzWk1FSWR2Y2dueHp5Rlc2TVRtblBTSUdqUytRRWJDSmlxckZN?=
 =?utf-8?B?N3lvRFJFeVVaMS84LzVhQ0ZQU3lBMlRWc0Fkcy9NdXdMcEc2bDRPU0tLLzh2?=
 =?utf-8?B?ckFWSGxqVms3dzVjL01HbEJWNHFOY3lVaFFsWHVqcTFRRldXdmF4Z28wVUF4?=
 =?utf-8?B?Mk1ZNmdUY0lnSlFJTi9wQVNmQ1hnVFI3b253RnljU3RYRm8wRSs0eEYwMzBa?=
 =?utf-8?B?eTJpRzlsL2lac1N1cmR4aHF0alhUaDA3WG05RlcyMmlUbTNyUXpFWXRBdmhJ?=
 =?utf-8?B?R09HNzY1aXlzS1dRWnc0bkVIbHRjZ1d6Tzk0YU9XN1haZThZVDNzKzdQU3Zq?=
 =?utf-8?B?aUlTWHpwN2FMUW95aFVzcGhsWnp2NGhMRXVuVHpVZXBLcmlHa1NtNm1TVWE0?=
 =?utf-8?B?REN4VUNpSWlqV3ptMUVoNFJQZnJvUm1BdThaQ1BsUG84clZTR3BNYnRnQ2Za?=
 =?utf-8?B?LzViU3hGY0RlbE43LzBmUGZiTnp3SThyc0QvWVA2M2cvR0Y3cWhQTkk1RU1P?=
 =?utf-8?B?MEhzVkhWZGxaUTJ2U3lCRSs2bXJvU1p2eDljRERGcG42djZFNWpiK2RVOGZG?=
 =?utf-8?B?cVJuak91cFpXVmhxNStVQjFZTU1sSk9PR2lETC9WeDNSWGZFSTRwL3lLOHJu?=
 =?utf-8?Q?wpCiajV3E14c6T2dqG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181f9b2-1cff-4e6d-b692-08de439eab69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 10:16:29.2405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vATqVcF/HHz5vOvZiyhhu5Ec3s/3VyJz4++TVo7PraK89t16qnDLA5GaMoYvaGORyH5/xGWmM1jRfnm6Z4B/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7947
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogUXVlbnRpbiBTY2h1bHogPHF1
ZW50aW4uc2NodWx6QGNoZXJyeS5kZT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0MTLmnIgxNuaX
pSAxNzo1MA0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAu
Y29tPjsgZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhwLmNvbT47IHUtYm9vdEBsaXN0cy5k
ZW54LmRlDQo+IOaKhOmAgTogU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+OyBNYXJlayBWYXN1dA0KPiA8bWFyZXhAZGVueC5kZT47IE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dEBtYWlsYm94Lm9yZz47IFllIExpDQo+IDx5ZS5saUBueHAuY29tPjsgdGhhcnZl
eUBnYXRld29ya3MuY29tOyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+IE1hdHRpanMg
S29ycGVyc2hvZWsgPG1rb3JwZXJzaG9la0BrZXJuZWwub3JnPjsgTHVrYXN6IE1hamV3c2tpDQo+
IDxsdWttYUBkZW54LmRlPjsgU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPjsgS2V2ZXIg
WWFuZw0KPiA8a2V2ZXIueWFuZ0Byb2NrLWNoaXBzLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFz
QGt3aWJvby5zZT47IEdlb3JnZQ0KPiBDaGFuIDxnY2hhbjk1MjdAZ21haWwuY29tPjsgU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBEYXZpZCBaYW5nDQo+IDxkYXZpZHphbmdjc0BnbWFp
bC5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFU
Q0ggdjEgNS83XSB1c2I6IEtjb25maWc6IGltcGx5IERNX1VTQl9HQURHRVQNCj4gDQo+IEhpIEFs
aWNlLA0KPiANCj4gT24gMTIvMTYvMjUgNzozOCBBTSwgYWxpY2UuZ3VvQG9zcy5ueHAuY29tIHdy
b3RlOg0KPiA+IEZyb206IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPg0KPiA+
IFNpbmNlIHRoZSBjaV91ZGMgZHJpdmVyIGhhcyBiZWVuIGNvbnZlcnRlZCB0byBETSBkcml2ZXIs
IHRoZQ0KPiA+IENPTkZJR19ETV9VU0JfR0FER0VUIHNob3VsZCBhbHNvIGJlIHNlbGVjdGVkIHdo
ZW4gQ09ORklHX0NJX1VEQyBpcw0KPiA+IGVuYWJsZWQsIHRoZW4gd2UgY2FuIHVzZSBETSBjaV91
ZGMgZHJpdmVyLg0KPiA+DQo+IA0KPiBJcyBETV9VU0JfR0FER0VUICpyZXF1aXJlZCogZm9yIENJ
X1VEQyB0byB3b3JrPyAiaW1wbHkiIGFsbG93cyB0byBoYXZlDQo+IERNX1VTQl9HQURHRVQ9eSBB
TkQgQ0lfVURDPW4sIHdoaWNoIGlzIHByb2JhYmx5IG5vdCB3aGF0IHlvdSB3YW50LiBZb3UNCj4g
cHJvYmFibHkgc2ltcGx5IHdhbnQgImRlcGVuZHMgb24gRE1fVVNCX0dBREdFVCINCg0KVGhlcmUg
YXJlIDIgaW1wbGVtZW50YXRpb25zIHN1cHBvcnRlZCBpbiBkcml2ZXJzL3VzYi9nYWRnZXQvY2lf
dWRjLmM6IGEgbm9uLURNIHBhdGggYW5kIGEgRE0tYmFzZWQgcGF0aC4gVGhlIGN1cnJlbnQgY29t
bWl0IGxvZyB3b3JkaW5nIG1pZ2h0IGJlIGFtYmlndW91cy4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlj
ZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBZZSBMaSA8eWUubGlA
bnhwLmNvbT4NCj4gDQo+IFBsZWFzZSBkbyBub3QgcHJvdmlkZSBSZXZpZXdlZC1ieSBvbiB0aGUg
Zmlyc3QgdmVyc2lvbiBvZiBhIHBhdGNoLCBSZXZpZXdlZC1ieSwNCj4gQWNrZWQtYnksIFRlc3Rl
ZC1ieSwgZXRjLi4uLiBzaG91bGQgYmUgZ2l2ZW4gcHVibGljbHkgb24gdGhlIG1haWxpbmcgbGlz
dC4gV2UgZG9uJ3QNCj4ga25vdyBpZiBZZSBMaSBhY3R1YWxseSByZXZpZXdlZCBpdCBvciBpZiB5
b3UgdW5pbGF0ZXJhbGx5IGRlY2lkZWQgdGhleSByZXZpZXdlZCBpdC4NCj4gV2UgZG9uJ3Qga25v
dyBpZiB3ZSBjYW4gdHJ1c3QgaXQuLi4gd2hpY2ggd2Ugc2hvdWxkbid0IGhhdmUgdG8gZmlndXJl
IG91dC4NCg0KVGhlIFJldmlld2VkLWJ5IHRhZyB3YXMgYWRkZWQgZHVyaW5nIG91ciBpbnRlcm5h
bCByZXZpZXcgcHJvY2Vzcy4gSSB3aWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
DQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
