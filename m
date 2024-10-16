Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387FDD2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B673488D5C;
	Wed, 16 Oct 2024 08:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dmAYBxLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E064588D9A; Wed, 16 Oct 2024 08:34:01 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E5288B86
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h71K5TWEoDcOW/P48RMJBkHvZycrxHra7Tc0NHbm54a36GCvwFYMP+hPoDYIWrZq52hgbn0DohEXPFTpSIjS9U2h4CYwsshvpHApYYsFjj73yrzSk9OREOlZLvvwu/adG3vzIuPjrHznynpkDJhccnzUgiK4sL6SuJckVw3HGSJtGdO5wAW91hobgOjmw/c9qbIYU0Mc4soFk/cmCIWU8chzD/d9swrCoAvKe6ydOvG6ij/LAGdOpucTmNGDwm1+cLjuV8PDINL4cTprAUV0ZPmLGusJWK1eBGaathoDw7X99dDImoZbFmX4YADJCQjm47KMiQhzM+jiYUpjeD19ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t6V4HmNx+QJuI6h68XnEw7mwbFdFd8XWpsD7AiW4b8=;
 b=rHdNhkiU/PrqrScGuJca3rvTPscXpsuptLhhEsuFCUTqSKxeiAfoPxvsKuXqyT0ekFhhCDB2JHHPabAJxXsem5y+AWDypjdh0wltqw3jtPmd/gMFhvJjUj0iT+3Zz6HIoX2A1y0EG4sfVuDAblnLc2tcdzaPc3TAOxKfn+EWHYK9HtryLTsDnMJAAOmH4IKWIgIxh2J6wfHkzADHCamiTkqk2PytGK3po+oJYL5HuelwkwxA9ATC5lmQ2kZxo6WAwriSlM8ZGAIfJFe+p/sNEICjTL77NKvXfc7nkP7UfaiJqIq2mWXBD1ClkrLIlO9l4GETSX67zPO3ZC4kMsNYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t6V4HmNx+QJuI6h68XnEw7mwbFdFd8XWpsD7AiW4b8=;
 b=dmAYBxLVi6XzrKQE/wY7wXLnbr5kTjszLfHexzLRH9QUj4ZOAY3LiZpaLi2lVfWx+ubvcWNRiiq/a1e9612SXMkNDBmp7OaYcPsF4qhoIvvNu0KFvOsQzc3PaBgvJl1gn49XI+ilRMRwCAIp+JFHKZCeKHNQDwsfns7yCrQDJF6Kv4/LYrKp1fuv5UVHE2fX2QCqWIVvAR+yGpD92/xCnRcp0lFOPbz3Qy/o7cubmAMDwTZhwWkFG9rVgl4vlylFHdCBCZCPXAE8znA5esYfsAsZZx7KTrFyecnojzW0jDE1Q0Bkw2KmVDdz+FrvZbLoKPaTD0EoMVGxg3IBrFmFwg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8266.eurprd04.prod.outlook.com (2603:10a6:10:248::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 06:33:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 06:33:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "hs@denx.de" <hs@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico (BT CPS R&D
 ZG FW CCP)" <enrico.leto@siemens.com>
Subject: RE: imx8qxp: deneb board fails with current HEAD
Thread-Topic: imx8qxp: deneb board fails with current HEAD
Thread-Index: AQHbH41WAFKI4zBF3ES21nZYTjTvMrKI5R8ggAADyICAAAGsEA==
Date: Wed, 16 Oct 2024 06:33:57 +0000
Message-ID: <PAXPR04MB8459AA14EEBD7F061BC37B1188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <67ebc675-d681-3b63-b642-f32f5e6a6b38@denx.de>
 <PAXPR04MB845969EF200C1F0A6AF7976488462@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <43626d40-90cd-4e8a-a7fd-f6c659a6fac7@denx.de>
In-Reply-To: <43626d40-90cd-4e8a-a7fd-f6c659a6fac7@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8266:EE_
x-ms-office365-filtering-correlation-id: bd9e2110-db58-4db7-249a-08dcedac8361
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUQrbXV2WGVLOVdzd0ViUjlKSzYwUVluNU5DcTJUSEovY1U3YUZMdXlHYmdS?=
 =?utf-8?B?ZVpzVDZOU0hVVnRtcGRFZHBvSGl4U0F2QU5MYlp1ZGtUM2U4Zm5LYnhUaDdp?=
 =?utf-8?B?eXVyTTM1MnpheTY2QmFTK3BQMU50MlNXNVBMMDA1VVFDMi8wSVdzZS80RzBH?=
 =?utf-8?B?b1VvendDbUN5eXQzY1BLVnl4UnVjVVoyUkpIWEtYY2p0V2gzeWNZTzFmTTQ2?=
 =?utf-8?B?aVJEeDhrY0l0SHhsMHNteW9jTm15bGk5blhLZlNmWXhGWEo0c3FPajFHWlNm?=
 =?utf-8?B?eSt6MHZ4MmViRmp6Ym80dWZTKzVmVGFTWU1NVk9JWWJ5RjJnT01TWHIvaDhX?=
 =?utf-8?B?SW9wMWp0MkJtTVpISi9LQ1RleS9pS2w2aWpCUGJES0xIcEJTWnpOR3ViTXlv?=
 =?utf-8?B?ZGdHREowa1dublhad2ZZOFY4RjB5WWxNQlZGZFZvdlZna2lIejdXL0tyT3dl?=
 =?utf-8?B?ckJJa05vV2p5Znc1MW5oVUdodS9uc1NHb0ZqRVRMbHR5Y0hKOG5EamZySklv?=
 =?utf-8?B?eEhlU0hmRHI5SFI0QlljYzlOS2hlVld2bElYRlB5aFJDV3VIdk4wRUE3OGd6?=
 =?utf-8?B?VEhLOUZjWW9zZld3MUtjeENDTldRc3BmSFJDZmRHNVVYNjM4Qm91ZEIwN1Y2?=
 =?utf-8?B?NEkrZkFIbjJiRENsUisvSWxsalk5OURGSk1lRHlOalM5c0RUeFc3V0RCZ3F0?=
 =?utf-8?B?cXJYWnNXQ3FIZGxKT1N6cmRQU0J3Rnc3T05wZklPTkZOaytmTmFzaGp3VE5M?=
 =?utf-8?B?OXpvSDVHZDBySGVCQm5jYXlSMFJrdDVXekhtUVMrdkZLOXkvQ05sSktDdUpH?=
 =?utf-8?B?UVZ2RWxsQXowa2dkL3dGVDJoRDdlelRHSFYyVFU3b3RDaTllRmRsbys2ZkVx?=
 =?utf-8?B?bFh5a1JBUzRzQUplU0ZscEtwOHlvWUZIUWIwTml2TkFoS3AwYXFhT01Vckth?=
 =?utf-8?B?bDRnQVRDL2EyQmhOQnZwME03RENlbFlvNm9mVERXay9VVUVQWmU2VFlVcFlR?=
 =?utf-8?B?RWJGTUkvQWJsZWNjTDFESkNkbTdXdCt2VUFwT1RkWFpRa05uY0hIbmp4VUhj?=
 =?utf-8?B?bkp0RVp3UnNvYkxxSUJmVjJ5ZVdpVU91L3U2aERmSXd1OEdFUTB2cnJWUXI2?=
 =?utf-8?B?VHJER0h5RXMySVJ4NFZQclpJVmIyU0U0MUhZZEUxa25OOFVXNUg0a3QwK0pD?=
 =?utf-8?B?ajVSSU10R0hMUjdXdkV2cmJQYWkxcDNQK085WDB4V25YK1dybkVxMENzUFhU?=
 =?utf-8?B?TG55QUozQ2hCLytYT3RVMHNwZ2IzQTBIbHhoTDBHMVhSNGZvWkZIL3FENzlC?=
 =?utf-8?B?V2V1UmR4N2ZNeUlwQWRMbjR6MTVMWWtRUGhaS0VjMTAzbDhxWUErSkVkR2sx?=
 =?utf-8?B?SU1NTktQRzVIcW95NVpVbXg3UGRGQUpXNUwzUjJTRGFHSE1raTJ5aUJPS0pO?=
 =?utf-8?B?ME4ybjlNMXNpN1RmTVRNaUZTSTVWQ0xHeGxjdlJVSW85UjM2SmI1OXFoWWp4?=
 =?utf-8?B?K3p4amZIYUlwVm8weVUza1loSTF2V1FPdnRKc2xCUEJnZ3M1dGM1bGZMRTdz?=
 =?utf-8?B?UEV0Wll0eGhDMlJjVmdVK3JSaG8yUnVacEczTjBKZ0lPZUdFODRhNWxGWjVN?=
 =?utf-8?B?Q21HZ3Iwa0FGdDV6VFJtRk1TTDZvRk9wQ2dzc05yUE1xUmExWWswOFp1cFpK?=
 =?utf-8?B?a0g2TGVYM0VPUHVpWDc3ZDYvdTNwd0l2QW1mY1pBaE5jRkhPVW5vWS9UWVRG?=
 =?utf-8?B?K0ZoaVNPSjgyYUZGM3hqTkRLSVFtWnFKRExJcGxqSEhxY2dSKzRHY1Q1YnBC?=
 =?utf-8?B?dXVBYUdKb3Y0TXUyM2MrZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnN5VnJVM3VDcU9iekRoMGRwVm1Vc1cyUFZseHRkV3k2R0xHSHJyeFBmbEVk?=
 =?utf-8?B?dktXVXRpMjBZcllaYTdGM09vRitxZU1ZTzJXSE1Eb0lxWE5yTGQrdUxYWkwy?=
 =?utf-8?B?c2lTYTJTdG1iL3JmOEdsVldvRVlVL0dGNXJBb282Z1llK3hnUWo2UG9rN3dp?=
 =?utf-8?B?MG8wVElUY1dWdHc1eUppbVNtek1MNll6aVg3SEdNNlJaaWVOYVY2cWtMVUpv?=
 =?utf-8?B?aEZkSXU5MVZVUUdKTGNMd3VyZGU0TTdha2Z0a0JwT1M0Yld3aXZqSmk4aE16?=
 =?utf-8?B?K1pOcXdiOEpnTGNnSGhrcGJISkpLdHg3U002RVRXY2xzaE4yMk5vRXBpcTB5?=
 =?utf-8?B?cU5WM1hRanFmSStWSXNwUytSZWtBL3VwNitnckl4Q1ZBL2VCcTd3S1I5eDJ3?=
 =?utf-8?B?WkdpR05DeTRBeEdrOFdocm9wOUZidVR1cVBwUEJkNXE5K0VRUTZDcUd4c0ZX?=
 =?utf-8?B?SDA2YmthTXdRQW5aS2ViZm9EYnM3a1VGSGVKQUlUVXVQaXRPM1B1aWpsempF?=
 =?utf-8?B?Z3ZQMldhTkRIZ3Bvd2g5TXl5UXdUVXVMZjdKVWRraVFERllFV2dWaE1tNWNk?=
 =?utf-8?B?RzdqV1RuRlVPY1BIWjVPdXJlK3RQd1hVZ3MrU1E2RjJLcDcvaXMvdjIzRVJG?=
 =?utf-8?B?a3cxRzEvUXd2YzNaaXA2VDdtNWRLU1NQeUpvU2dkQThEZGd0ZFV2S1JtN2dV?=
 =?utf-8?B?SWxxOXl1ckwybzMrYzhJc2xMVERFV2xUOWJXSU9VcmhzRkI1ekc3b2Fld0Jo?=
 =?utf-8?B?WHkrb3FXMnlWZjJVTlNLd2wwN3I0endHMmFENjBLanhXVDA2dWpoZzM2SXhu?=
 =?utf-8?B?aEhaYlpsaE1SWi9HY1d6cE5XWW00c2x3K1BSWkxRclhZeXZsR21sQnNpTUps?=
 =?utf-8?B?ODRLMGRlN0Y5RVAvV29wK1o1YXN5RTk3OTJLc0lZa0Nsc0NHVXdaNWZzcjY3?=
 =?utf-8?B?ZEZPT3ZMSWtvODNVdmM5czMwZElWSFpHWEsxSlJadEJzNFRiODEwWTkxWHVQ?=
 =?utf-8?B?VWV2TVplUzAzczhEK21PN3ppQTdWd3RyckptcVFRR0dqSFc5Y1pUMTd3d3FU?=
 =?utf-8?B?ZmJEMkszaHNmaGsvVjdmczdaTEE2NmpFVDdROHI5MkdxelFJOUZ3aHpMR1hw?=
 =?utf-8?B?dlRRQ3ZEQzArajk1ekZOSFlabXJrYjE2YlZOUEt5Vm9FQkhOTk5pajNXNVlN?=
 =?utf-8?B?N2d3RzdRSnIwRHhzdE9pMjFKYzJDb3R3SUlZdlpwbTIxYjhRTVVIZXFMWVVl?=
 =?utf-8?B?ZHErQmVsVGpIdDlUMXNkcG1QSEZ6cS96UWM0T2FWdmNzQkc4VmdDNFdQRzFn?=
 =?utf-8?B?cml5SUE0eFlBV2R4WVdqSWdnbjRJUWgySzd0YjBwekhtQ1g0WVdVWnFuOEVs?=
 =?utf-8?B?cHU0TjBON0tuMTB5RUdJZW9QTC9WOTc3Z1N1NjU4dmRGVVJQRzg5MlJkRVI4?=
 =?utf-8?B?M1ZCR3VtbFNNNVZEWmdaM2h5V0ZUaTRabC9tcUk5NWdGZUV1WGcxR0lvMkRm?=
 =?utf-8?B?L2JVRnNBNVFubmthTEFkSHlZTS8rdVNib0ljaEV4UDY2UmprME1pRGwwZUtx?=
 =?utf-8?B?ZnlTVHEyU3JaTUtJK1prdXJSbHRITzU4bnZ5R3ZGeVkzUmpMQTZmVW9UYzJ4?=
 =?utf-8?B?TUx0c2loQnRSaFMvY05zUDJaOVRuWThSWmFmamJTSERFdm93WTN4YnNqVkN3?=
 =?utf-8?B?dTBnVlE5emxpNG1QbnJTbGZ4bTFxQ3RaSENPWU1mNWNLaENSc1ZyS0ZNdWha?=
 =?utf-8?B?OWhxU081V003QzZCbWpJRmlGRjF4bVZkQlZzT0hhREQ0R1Bzcmdzb0FmNmM2?=
 =?utf-8?B?K1dNVVRjdGQ3M1gxZmpZU2xrKzZ2Y0NFSjZQbjk2WUhxZHYzNWJYRnJscGlH?=
 =?utf-8?B?dFNCNjNQcGhPczVXMFFiYXRpczFTcmlxZjFSRkxyZUE2SjU3THpBek1oQVRZ?=
 =?utf-8?B?QW00Q0g4QkZxUlNubHZ5QTdBYXZJaUN6VkdNVEd3MFUvS0QwSWhlbXJROCtB?=
 =?utf-8?B?Z3E1dGxaS3hzc0twVE9LVkV5TGZSdWtqOTRmQXNsd2dTdE9JYVEzRWRkQ2tq?=
 =?utf-8?B?a1h6M2pWSlpEbDlBY3h6TUZOSDg0aGFPd0gxRzFaK2NEMDVuWnhvVTVmM2dI?=
 =?utf-8?Q?FO6g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9e2110-db58-4db7-249a-08dcedac8361
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 06:33:57.3893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyi2Vz8jyrqQeYOuBBCRcvPuONrA3QEva5ea3kzTgNOFOW9ms3RdAiezksN76VyIDxVX9/WPzBBpn4Gubvs04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8266
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

PiBTdWJqZWN0OiBSZTogaW14OHF4cDogZGVuZWIgYm9hcmQgZmFpbHMgd2l0aCBjdXJyZW50IEhF
QUQNCj4gDQo+IEhlbGxvIFBlbmcsDQo+IA0KPiBPbiAxNi4xMC4yNCAwODoxMSwgUGVuZyBGYW4g
d3JvdGU6DQo+ID4gSGkgSGVpa28sDQo+ID4NCj4gPj4gU3ViamVjdDogaW14OHF4cDogZGVuZWIg
Ym9hcmQgZmFpbHMgd2l0aCBjdXJyZW50IEhFQUQNCj4gPj4NCj4gPj4gSGVsbG8gUGVuZywNCj4g
Pj4NCj4gPj4gSSBqdXN0IHJlYmFzZWQgbXkgY3VycmVudCB3b3JrIG9uIHNpZW1lbnMgZGVuZWIg
Ym9hcmQgd2l0aCBjdXJyZW50DQo+ID4+IG1hc3RlcjoNCj4gPj4NCj4gPj4gKiBkNWNhYjBkNmFk
IC0gKEhFQUQgLT4gbWFzdGVyLCBvcmlnaW4vbWFzdGVyLA0KPiBvcmlnaW4vV0lQLzE1T2N0MjAy
NCwNCj4gPj4gb3JpZ2luL0hFQUQpIFJldmVydCAiTWFrZWZpbGU6DQo+ID4+IERyb3AgU1BMX0ZJ
VF9HRU5FUkFUT1IgLyBTUExfRklUX1NPVVJDRSBzdXBwb3J0IiBjaGFuZ2VzICh2b3INCj4gMw0K
PiA+PiBTdHVuZGVuKSA8VG9tIFJpbmk+DQo+ID4NCj4gPg0KPiA+IE15IGJhZC4gSSBoYWQgYSBw
YXRjaCBpbiBteSBsb2NhbCwgdGhpcyBzaG91bGQgcmVzb2x2ZSB0aGUgaXNzdWUgeW91DQo+IG1l
dC4NCj4gDQo+IE5vIHByb2JsZW0hDQo+IA0KPiA+ICBGcm9tIDNlNWY4YWQ2Y2I5M2I5NTM4ODUy
MjMwZDAxYzAxYjUyZDVjMWM5ZDEgTW9uIFNlcCAxNw0KPiAwMDowMDowMA0KPiA+IDIwMDENCj4g
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiBEYXRlOiBGcmksIDExIE9j
dCAyMDI0IDE5OjU3OjQ5ICswODAwDQo+ID4gU3ViamVjdDogW1BBVENIXSBjbGs6IGlteDg6IEFk
ZCBkdW1teSBjbGsNCj4gPg0KPiA+IFRoZXJlIGlzIGEgZHVtbXkgY2xrIGVudHJ5IGZvciBpLk1Y
OFFNL1FYUCwgc28gYWRkIHRoZSBkdW1teSBjbGsNCj4gPiBlbmFibGUgYW5kIGdldCByYXRlLiBP
dGhlcndpc2UgIl9faW14OF9jbGtfZW5hYmxlKEludmFsaWQgY2xrIElEICMwKSIuDQo+ID4NCj4g
PiBGaXhlczogNzYzMzJmYWU3NjkgKCJtbWM6IGZzbF9lc2RoY19pbXg6IEVuYWJsZSBBSEIvSVBH
IGNsayB3aXRoDQo+IGNsaw0KPiA+IGJ1bGsgQVBJIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xrL2lteC9j
bGstaW14OHFtLmMgIHwgNCArKysrDQo+ID4gICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxeHAu
YyB8IDQgKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jDQo+ID4gYi9kcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jIGluZGV4IDYyZmVkN2UzZTMyLi40NjZkNzE3ODZjZg0K
PiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhxbS5jDQo+ID4gKysr
IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4cW0uYw0KPiA+IEBAIC00OCw2ICs0OCw4IEBAIHVs
b25nIGlteDhfY2xrX2dldF9yYXRlKHN0cnVjdCBjbGsgKmNsaykNCj4gPiAgICAgICAgICBkZWJ1
ZygiJXMoIyVsdSlcbiIsIF9fZnVuY19fLCBjbGstPmlkKTsNCj4gPg0KPiA+ICAgICAgICAgIHN3
aXRjaCAoY2xrLT5pZCkgew0KPiA+ICsgICAgICAgY2FzZSBJTVg4UU1fQ0xLX0RVTU1ZOg0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAgICBjYXNlIElNWDhRTV9BNTNf
RElWOg0KPiA+ICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgPSBTQ19SX0E1MzsNCj4gPiAgICAg
ICAgICAgICAgICAgIHBtX2NsayA9IFNDX1BNX0NMS19DUFU7IEBAIC0yNjQsNiArMjY2LDggQEAg
aW50DQo+ID4gX19pbXg4X2Nsa19lbmFibGUoc3RydWN0IGNsayAqY2xrLCBib29sIGVuYWJsZSkN
Cj4gPiAgICAgICAgICBkZWJ1ZygiJXMoIyVsdSlcbiIsIF9fZnVuY19fLCBjbGstPmlkKTsNCj4g
Pg0KPiA+ICAgICAgICAgIHN3aXRjaCAoY2xrLT5pZCkgew0KPiA+ICsgICAgICAgY2FzZSBJTVg4
UU1fQ0xLX0RVTU1ZOg0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAg
ICBjYXNlIElNWDhRTV9JMkMwX0lQR19DTEs6DQo+ID4gICAgICAgICAgY2FzZSBJTVg4UU1fSTJD
MF9DTEs6DQo+ID4gICAgICAgICAgY2FzZSBJTVg4UU1fSTJDMF9ESVY6DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OHF4cC5jDQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgv
Y2xrLWlteDhxeHAuYyBpbmRleCAxOGJkYzA4OTcxYi4uNzkwOTg2MjNiYzgNCj4gMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4cXhwLmMNCj4gPiArKysgYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhxeHAuYw0KPiA+IEBAIC01MSw2ICs1MSw4IEBAIHVsb25nIGlteDhf
Y2xrX2dldF9yYXRlKHN0cnVjdCBjbGsgKmNsaykNCj4gPiAgICAgICAgICBkZWJ1ZygiJXMoIyVs
dSlcbiIsIF9fZnVuY19fLCBjbGstPmlkKTsNCj4gPg0KPiA+ICAgICAgICAgIHN3aXRjaCAoY2xr
LT5pZCkgew0KPiA+ICsgICAgICAgY2FzZSBJTVg4UVhQX0NMS19EVU1NWToNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICAgICAgICAgY2FzZSBJTVg4UVhQX0EzNV9ESVY6DQo+
ID4gICAgICAgICAgICAgICAgICByZXNvdXJjZSA9IFNDX1JfQTM1Ow0KPiA+ICAgICAgICAgICAg
ICAgICAgcG1fY2xrID0gU0NfUE1fQ0xLX0NQVTsgQEAgLTI0OCw2ICsyNTAsOCBAQCBpbnQNCj4g
PiBfX2lteDhfY2xrX2VuYWJsZShzdHJ1Y3QgY2xrICpjbGssIGJvb2wgZW5hYmxlKQ0KPiA+ICAg
ICAgICAgIGRlYnVnKCIlcygjJWx1KVxuIiwgX19mdW5jX18sIGNsay0+aWQpOw0KPiA+DQo+ID4g
ICAgICAgICAgc3dpdGNoIChjbGstPmlkKSB7DQo+ID4gKyAgICAgICBjYXNlIElNWDhRWFBfQ0xL
X0RVTU1ZOg0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAgICBjYXNl
IElNWDhRWFBfSTJDMF9DTEs6DQo+ID4gICAgICAgICAgY2FzZSBJTVg4UVhQX0kyQzBfSVBHX0NM
SzoNCj4gPiAgICAgICAgICAgICAgICAgIHJlc291cmNlID0gU0NfUl9JMkNfMDsNCj4gPg0KPiAN
Cj4gSGVoLCB5ZXMsIHRoYXQgd2hhdCBJIHRob3VnaHQgYWZ0ZXIgSSBoYWQgc2VuZGVkIG15IEVN
YWlsLi4uIGJ1dA0KPiB3b25kZXJpbmcgd2h5IHdlIHVzZSBhIGR1bW15IGhlcmUgYW5kIG5vdCBs
aWtlIGl0IGlzIGluIGxpbnV4Og0KPiANCj4gICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnNk
aGMwX2xwY2cgSU1YX0xQQ0dfQ0xLXzQ+LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIDwm
c2RoYzBfbHBjZyBJTVhfTFBDR19DTEtfNT4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
PCZzZGhjMF9scGNnIElNWF9MUENHX0NMS18wPjsNCj4gICAgICAgICAgICAgICAgICBjbG9jay1u
YW1lcyA9ICJpcGciLCAiYWhiIiwgInBlciI7DQo+IA0KPiA/DQoNClRoZSBjdXJyZW50IFUtQm9v
dCBzdXBwb3J0IGZvciBpLk1YOCBub3QgcmV1c2UgdGhlIGRldmljZQ0KdHJlZSBmcm9tIGtlcm5l
bC4gVGhlIGRldmljZSB0cmVlIGRpdmVyZ2VzLg0KDQo+IA0KPiBEbyB5b3UgcGxhbiB0byBzZW5k
IHRoaXMgcGF0Y2g/DQoNCllvdSBtZWFuICJbUEFUQ0hdIGNsazogaW14ODogQWRkIGR1bW15IGNs
ayI/IA0KSSBjb3VsZCBwb3N0IGl0IG91dC4gQnV0IElmIHlvdSB3YW5uYSB0byBhZGQgbW9yZQ0K
c3R1ZmYsIGZlZWwgZnJlZSB0byB0YWtlIGl0IG92ZXIgYW5kIGRvIHRoYXQuDQoNCkkgbm90IGhh
dmUgcGxhbiB0byBzeW5jIHRoZSBEVEIgZm9yIGkuTVg4Lg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0K
PiANCj4gYnllLA0KPiBIZWlrbw0KPiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdt
YkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWthIFVudGVyDQo+IEhSQiAxNjUyMzUgTXVu
aWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwNCj4gR2VybWFu
eQ0KPiBQaG9uZTogKzQ5LTgxNDItNjY5ODktNTIgICBGYXg6ICs0OS04MTQyLTY2OTg5LTgwICAg
RW1haWw6DQo+IGhzQGRlbnguZGUNCg==
