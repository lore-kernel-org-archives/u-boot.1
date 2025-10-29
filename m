Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8275CCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 09:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF56281E13;
	Wed, 29 Oct 2025 10:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JqtdVkCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9152D832AD; Wed, 29 Oct 2025 10:10:32 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6FE8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 10:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSAPHF9oTjjTuAD5eBAvGgvU8iWhqqR8B2xYnbpvfLvBFW22uaQ2Z5H5wplI3xLsS6pKGUCUjmDDrTrgqaGJG5h4lyP00+y/l++7K4QRu9v/LrH9YMuDGKUWEzpvgRqKfONx/B+TX+FkIfi9pcHgEfWwjDQtURTe90N43KzOaVqARywcUb/Hv3NGSS1CtMhcuEaQaGcVfdqzUUiLpNXkmedng9WyaqgjamV8iTFx15qJZDa8vKnFPWXVYbQGHffeytbBkC13rW3AmL//wEnTZUWRAp0csIkgI9afZl8ZGOOSNm5Cn6k2RtEukvam2LyQ8QcCiReYDnZSgES831z5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MAIupPzlm4jnBrnpGUQ5SDngDu/1Nkf2jAcW09xDAQ=;
 b=BhnpEqdxFpTo7+xjLn2nfyzvcWAhyPHrVd9x5DmPTBgBTFn+2rlugVDc1rsBj/PkJc2wACiaFvAOTYM+e87MIQa9Uzc5NKkmw5ujI7HO0j9tl59P3ZUZhyh0RIKLLX24spw5TVU8O1eY4CBh7B/NLhdQoCgDQdzOd0Eyev/gXYEadCcqlB5cOb1SOr3WrCm7frm7Z91AS8zkJfmtmPcF54RUV1tMb0C562euRa+pWXD7qkjd9xu5kN1Oz7FwShVGkj55U+OuL7kOQzTclvf+nMmmprHZ+RBxTtHHLDNpC1IZ26VAyWzL5ILSAecjsM426svAq6NKyhPm+uWMKC9Ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MAIupPzlm4jnBrnpGUQ5SDngDu/1Nkf2jAcW09xDAQ=;
 b=JqtdVkCz7DGlRH3kDDG96U9KIVQ5KAigH9vX5UfI/HPQLtg3+fmZk5Dv/aVRDYA2EJBa94e2GTNni2kFEwGdcDgRtzvghpq6k7Y6EjaZL2gXNzZjrO1H9nVemjEEIr/XuPRpa69tUSQg0skA+v3pp4ZZOpXDHpOsdyQqOq+/v7P3KElDKLl9ZBUF103aFlTeZNdKB4i5Qt2OxNEnV7Z7ibMGuhfknuREZ6u/j7nx5uswAhKoFvAvZqPAtu1w43rTe4MXwB5+ol4oNP2B9vWAHT4vSCI2gVp55JaY0Jqk5DD3MyZf/t28wGi+nIlI40Wj7Piv0i4o6arZ/+eVDGfuOQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:10:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 09:10:27 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBmaXJtd2FyZTogc2NtaTogRml4IHVwIGNvZGUg?=
 =?gb2312?Q?comments?=
Thread-Topic: [PATCH v2] firmware: scmi: Fix up code comments
Thread-Index: AQHcSLPdvb4JT0Vvz0WPIHN9l8avew==
Date: Wed, 29 Oct 2025 09:10:26 +0000
Message-ID: <PAXPR04MB9644046A5B3190ED19FFE5B3E2FAA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251028135919.8573-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028135919.8573-1-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8970:EE_
x-ms-office365-filtering-correlation-id: e7749961-7736-4236-1a69-08de16cb0025
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?dkJKK2FwM1pJSSs2Q3hYSmtQM1plVjlheHlIRG5ZMFY2WnM2Vzh2aXBuNklN?=
 =?gb2312?B?elpvZEJHa1ZjUFIxRjU3Yk83SlZWenFxaGcvbW5kWDA4ZGFxZ21rYXlEWVRp?=
 =?gb2312?B?QkF5TlRUQVVxOEltaHBuUW5BdEZxWkttaDdoUkpPdTlreCtxRGhhMDgxWkxY?=
 =?gb2312?B?d3ZnelJHNUlwaWwyRHlxa1BtTnozQ2dOeGRxRGxWV0hsL1d2SDBjc3FZaVNl?=
 =?gb2312?B?NnFpNnAxOHByaDZjdmNqUjI0emVtYjJPbVg0aUt2aTl3MTNNdCtBa3dEQm1T?=
 =?gb2312?B?dVluVkFqamd6NS9OaTNENUFHNkhiaG5mcVdOTkxnYm9EbllNNzBHMXNIWWVS?=
 =?gb2312?B?RllIQW5VUVlXdlRwSEUrU05uVld2NnUxakdoU2JmZlhHSjgvNGExY3hQWS9u?=
 =?gb2312?B?czBzL2F0aFVwR21ISjVQeFhWNTRkcVVPL1ZpWmh5UytBemNNOFI4OCtPYmE4?=
 =?gb2312?B?bXpIanR6YmlJdHNMOURWWmtYM1JONjVCV0cvZHNiTDIxb2o0bTgwVUlkZDVs?=
 =?gb2312?B?VjZ3Zm85R0VtT2p1QVRGRjlSTUt2MkN5eUl6VElaaEFGb0VJRHlaUzltM05Y?=
 =?gb2312?B?bHNhangwcGc5Tll6NzBteWtSSlF0R2M3dDlTRTU2YU9naE5YTnVRRTZPd1RV?=
 =?gb2312?B?NVZnS2l5QUYyVS81SWthRlZlSUM2Vm9zc0kxTWVUZGZpSkVpdGs5Qkw5Vzdi?=
 =?gb2312?B?S3llS0ZObC9KY0xUem93MVJCaUhDS2RZVE1RaHF6bG8yeXBxaSswQUNkaE1V?=
 =?gb2312?B?TW1ua2NmdFpCNTRJcCsxZ1JCaWxSU1hvSTA2QnV5c0UxVENXME5yaklHQ1lI?=
 =?gb2312?B?WXRLTzJUaXk0NHFmbmlBaVhoZ2FBQ1h3dHBqWXhCNXBDNm84STU0cXFLbEJu?=
 =?gb2312?B?d3RIdFJicG1kU2xQZnhQK2hrc1ROK25CaFlkYTNsZFJYVWpWc3B2SVZGK01p?=
 =?gb2312?B?SDdMM01nUVVmT0xWQ2RmTDN0Ykh6c2JlUU85eTg3alhkZ2tPTzZ3cnR3QzNt?=
 =?gb2312?B?K292SHlvMXpIdjhaQXE1U0xqdjdhSURoZ2xUS0JDYzFjTSt5bmpXMXZEN01E?=
 =?gb2312?B?OUJrMzZNdUJiZEh3eGQ1SjhpcXJKTUlyOTRSNDNKcGd3WWp2L2d6bXRxN0hT?=
 =?gb2312?B?VWMwS2ZXYmZITjNQdlVwdExNN2NHR1Era0NHMlVQMktHc0pXclRtRDRXUC9h?=
 =?gb2312?B?TU95aDVGMThmRzBST1Rya0NPUk4zUHcwSmhNNmxVSjhaYWVVcHArODZabnAw?=
 =?gb2312?B?dkNwLzJqOFBKQndVM0xMcitIdDdFVGtVRnBiY1FkclpUemZkZkwxdjVOK0RK?=
 =?gb2312?B?aGM4eEh0eWV3bFVBWW42NEFHK2N2cDdHYm85NGc2K3labk5EenZvUnM2eGxR?=
 =?gb2312?B?Zjc2cWphU0VYM3dXR1cxR2ptQ0xSeWtOUHMvTC9LNVB6VXFNK2kwQjl2bFBh?=
 =?gb2312?B?V2RPemVYTzNseVRWNXVnM0xFY2JHdEl0S1Z3S0toOHozdXd3REh2Y2kvM2F5?=
 =?gb2312?B?NGFocm5SVHJZTDFqdXE2WUU4SUdBNDJpODJUN01iRjU2aEIra1pGdXc0MGh3?=
 =?gb2312?B?NG5DcDQxM2dLQ3ZSUlk4Q2FLWjF4SmE0Z1FEY1RmdDVMQ3kzT014OG5VQTJw?=
 =?gb2312?B?dzFQQ0RzSFU0TVZ6eUs5NUtuOURTWXJGRGxsSXZsUFpuUXFyM21BWGtyMllw?=
 =?gb2312?B?bEVBcUl6azZ3RGtsSWt0NEYxS2piZmFyZmwrcDQ3ZTkzcHpEejM5M2h5K05i?=
 =?gb2312?B?Z3BsL3BwdGJEZ3dXQ3F3U2NlaUFJU01RRDJRdEt4YS9XaEI2aFdDblcweisr?=
 =?gb2312?B?MXo3eENKUmp4dGIwTlZzb3VLMjlBdmdUbjJpUDV5dWRLM01PZFROaVJhR2Np?=
 =?gb2312?B?bEY0M3dnaGNCaTIrMHBqL1Z5RzUvalovR0Z1UFFwUEN1dGZqVmVGdFNLK2dB?=
 =?gb2312?B?OGVyVlRGK1FGYzlUM2tOMXNGWkV6a3NuRlJJY1ZNR2FpZzQ5N013M00rcW9V?=
 =?gb2312?B?ZDFOdjAzSXpieVNHZ3FNWDBxd1pkWWM2S1NFSlQxeW1YdDUxZEozZEF3WExq?=
 =?gb2312?Q?DWjetx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MnViNjRRdEh5Z1dLN29VYjBrekgyMDZPaDI2djVPUmtTWVlSeHYvakk3RWxt?=
 =?gb2312?B?TkZGZ0tXS1NnTkhCWEo5UnpKSnlYcVJtNWVSbVBSMW1GNzhWRzlGMVZFVG9P?=
 =?gb2312?B?NW1sVWxNcmluL3V6VHVObzVNWERoeS9PcHBOU0UwaEZoMmIwd0dlVWttTlFK?=
 =?gb2312?B?ZVNOaUhIdFA1ZklNTkhQaTl2clM5bVZXWGZXZDNEMUhLL2JsMFlvMlhORTFZ?=
 =?gb2312?B?aXlqWW1SMXVYdHFwQzBqUjNOVm43QjNhR21udFpVSG9NcE1pM1JCT2IwV3hv?=
 =?gb2312?B?YjFnOHhlVTB1SFlSTTljeXVWNStOQ0Y2VXErVFFTckxua0xvN0w3Z2dmYktX?=
 =?gb2312?B?QUVmVnNaaElTcVBMY2pvNit4dDJ5cUprRmJCNjVuUk1zc21RYnZGQ0kvRU9D?=
 =?gb2312?B?R3h0WXhlQzFjSXFaNXJDTkgvQTNhY2VBZ2xvSEppalJFd2JnaS9xNnBGdERM?=
 =?gb2312?B?SW41RXhoaDdsN0N0WDViVW1pT0hzWFg2aGVmNmhia1RqQnBwQ1g0WkZPRVdV?=
 =?gb2312?B?TUVZNXFRZFptNi9hL21hQkR6bjRueHRZR0xEUkRVdGhqSFF4cXRzQVdUYUNR?=
 =?gb2312?B?Y25WUzloNWd5ejVKTnRIUmhqaUlkcXFhVlRmczkvUW5wc3dVWWlvTk1uOWZX?=
 =?gb2312?B?c0xFTnM5Mmh5a0ZkK3JBbWZ3WXBKQkdtTTJKcUNYemhzMkxuSjJJTXVncEla?=
 =?gb2312?B?YVlKcTZtK0w3cXduSldjSVZKbVhMWTFxdkpIeUpnQVZGVVp5RmxQYVVnSHBH?=
 =?gb2312?B?SWhSbWp5YWlpeUpPS002dkdTemVMd2EranlESTBTemtYLzJYOEZvMUtXbjZU?=
 =?gb2312?B?aDJrdjZFZ09nWnBuMEgwYzBCTmpnNzZOVEhwbWdPQ2drcktyWW1XcU15eEIx?=
 =?gb2312?B?V0VZYXNQK09DU0gwNzBOb2VYK2NuSlFyVmo4clovcmJPZWY2S2U4U0lPSkZi?=
 =?gb2312?B?OGlSRWdxQ290ZzNDS080Sm54b1dya2pMN01lMlpodFVvL2szVWVrSXdqVXlv?=
 =?gb2312?B?RnJkV09tR000aVVKaTYwV3hTaXBpZWdMeEpsSEFBU0lUdHI3UE9pTThVM1VN?=
 =?gb2312?B?NW9NMnFHd2RtRkdiOGNiM1FndmcvOElSMFRaS0lNU2x4YU5FSUU2SDY5SnE4?=
 =?gb2312?B?SlJnaHA3R1BVRFA2UUpSV1pMZjR0MmpabnVCQWJ6d2ROY3dOSHFzRE5idjB6?=
 =?gb2312?B?ZjhOUHdBQVJadEtRZldTUXlkNlNzbURpSlZTMDZ2SENOdy9KOFY4MzdybnRR?=
 =?gb2312?B?S2ZTYjZaNldaZjN4cUxxRjZzM0VVMnVXNUU3cEQrRmNZRFEySmhjcW9pMkZh?=
 =?gb2312?B?MHNsUUlGajhOclJKMXRQSis3RjRER05uQndsWTdSdk81Mk90ZWsrWlBCM0Fu?=
 =?gb2312?B?cWp6MFZaZ0JkK0hwbEtjS21IekRxc0t5S0JsT3NZTE9IUVlWeTh0VmllYVVV?=
 =?gb2312?B?bk5QS1VWSXkzQkpQbFpHOVcyK1J5SldtS1JoNGdxc1NVaGhHVkFud2o3Ui9J?=
 =?gb2312?B?OEtwejRjMjhldUVyNjR3eksyeDQrTWNZdnZwNk1DdGd6ck01RDRDSXpISTNZ?=
 =?gb2312?B?citMeDVlSUZwT2dYTzZnaERaTUM0NE9qVzc2WTYzLzFJSVF4VStBejZvU1RG?=
 =?gb2312?B?KzFpWUlrcjRiV1RING5ieWtuNGtOdXcwWVlISFNSekYxRE01VmI4UDdpdnR5?=
 =?gb2312?B?elpTS3c0Mzl4V3czallvOUs1MkpaQk1OWTdkUkNEWkExVGk3WWVBOXdZMUtp?=
 =?gb2312?B?bnljeHRYZ1EreEgydFJaT1VEcm1JeWZnaTFka2kyKytOUUlFOForRXZxTTBi?=
 =?gb2312?B?bGN3OFNoWnNIZ3FJcXlCa2psYnVkcnd3Q2RpZUVqSVNKNlBuWUp1TmI2aDdM?=
 =?gb2312?B?dmVDYzh5MGg2QkxjVnd6SnNSUmIxNjBQTVRQU25nTnBKbFFXQko4T0dqVEhE?=
 =?gb2312?B?cHM3VG5FcTdWVVRaZ0VTTTFEZHBTcFFUMmFzMTV2ZklJbGNZcGdRaWtXNFZk?=
 =?gb2312?B?TUNEbGxLZGpoRWxGUU0xcDJoeThzSWpEeXlaRk8vZVRVNVZaZWJqeDdDbTdu?=
 =?gb2312?B?cUY4OXB6cHBKNi9pcVVQbFQ5akFCcFdJOXhjM0JubkdCSWNTYkVMNmpZbHNh?=
 =?gb2312?Q?C/DA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7749961-7736-4236-1a69-08de16cb0025
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:10:26.9429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVN3AtFvgjy8xphhcXeIs1O/Tys/jcuft/XUINAtz9FuuLVm0z2UjZh+zG9iA/M7JIzmyF6YRtJFa0tfNWEFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxp
c3RzLmRlbnguZGU+ILT6se0gTWFyZWsgVmFzdXQNCj4gt6LLzcqxvOQ6IDIwMjXE6jEw1MIyOMjV
IDIxOjU5DQo+IMrVvP7IyzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4gs63LzTogTWFyZWsgVmFz
dXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBBbGljZSBHdW8NCj4gPGFsaWNl
Lmd1b0BueHAuY29tPjsgUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5j
b20+OyBQZW5nDQo+IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+OyBWYWxlbnRpbiBDYXJvbg0KPiA8dmFsZW50aW4uY2Fyb25AZm9zcy5zdC5jb20+
OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g1vfM4jogW1BBVENIIHYyXSBmaXJtd2FyZTogc2Nt
aTogRml4IHVwIGNvZGUgY29tbWVudHMNCj4gDQo+IEZpeCBtdWx0aXBsZSBpbnN0YW5jZXMgb2Yg
Y29weS1wYXN0ZSBlcnJvcnMuIEZpbGwgaW4gbWlzc2luZyBoZWFkZXJzIGZvcg0KPiBDTE9DS19H
RVRfUEVSTUlTU0lPTlMgbWVzc2FnZSBhbmQgcmVzcG9uc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz4NCj4gLS0tDQo+
IENjOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiBDYzogUGF0cmljZSBDaG90YXJk
IDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiBWYWxl
bnRpbiBDYXJvbiA8dmFsZW50aW4uY2Fyb25AZm9zcy5zdC5jb20+DQo+IENjOiBZZSBMaSA8eWUu
bGlAbnhwLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IC0tLQ0KPiBWMjogRml4
IHNjbWlfYmFzZV9wcm90b2NvbF9hdHRycywgc2NtaV9iYXNlX3Byb3RvY29sX21lc3NhZ2VfYXR0
cnMsDQo+ICAgICBzdHJ1Y3Qgc2NtaV9jbGtfYXR0cmlidXRlX291dCwgc3RydWN0IHNjbWlfY2xr
X2F0dHJpYnV0ZV9vdXRfdjIsDQo+ICAgICBzdHJ1Y3Qgc2NtaV9waW5jdHJsX2NvbmZpZ19zZXRf
aW4NCj4gLS0tDQo+ICBpbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmggfCAyMCArKysrKysrKysrKy0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oIGIvaW5jbHVk
ZS9zY21pX3Byb3RvY29scy5oIGluZGV4DQo+IGJiNzRhNTdmNzlhLi5iY2Q4ZTY3MTE0OSAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oDQo+ICsrKyBiL2luY2x1ZGUvc2Nt
aV9wcm90b2NvbHMuaA0KPiBAQCAtMzk5LDcgKzM5OSw3IEBAIGludCBzY21pX2dlbmVyaWNfcHJv
dG9jb2xfdmVyc2lvbihzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiBpbnQgc2NtaV9iYXNlX3Byb3Rv
Y29sX3ZlcnNpb24oc3RydWN0IHVkZXZpY2UgKmRldiwgdTMyICp2ZXJzaW9uKTsNCj4gDQo+ICAv
KioNCj4gLSAqIHNjbWlfcHJvdG9jb2xfYXR0cnMgLSBnZXQgcHJvdG9jb2wgYXR0cmlidXRlcw0K
PiArICogc2NtaV9iYXNlX3Byb3RvY29sX2F0dHJzIC0gZ2V0IHByb3RvY29sIGF0dHJpYnV0ZXMN
Cj4gICAqIEBkZXY6CQlTQ01JIHByb3RvY29sIGRldmljZQ0KPiAgICogQG51bV9hZ2VudHM6CQlO
dW1iZXIgb2YgU0NNSSBhZ2VudHMNCj4gICAqIEBudW1fcHJvdG9jb2xzOglOdW1iZXIgb2YgU0NN
SSBwcm90b2NvbHMNCj4gQEAgLTQxNCw3ICs0MTQsNyBAQCBpbnQgc2NtaV9iYXNlX3Byb3RvY29s
X2F0dHJzKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMg0KPiAqbnVtX2FnZW50cywNCj4gIAkJCSAg
ICAgdTMyICpudW1fcHJvdG9jb2xzKTsNCj4gDQo+ICAvKioNCj4gLSAqIHNjbWlfcHJvdG9jb2xf
bWVzc2FnZV9hdHRycyAtIGdldCBtZXNzYWdlLXNwZWNpZmljIGF0dHJpYnV0ZXMNCj4gKyAqIHNj
bWlfYmFzZV9wcm90b2NvbF9tZXNzYWdlX2F0dHJzIC0gZ2V0IG1lc3NhZ2Utc3BlY2lmaWMgYXR0
cmlidXRlcw0KPiAgICogQGRldjoJCVNDTUkgcHJvdG9jb2wgZGV2aWNlDQo+ICAgKiBAbWVzc2Fn
ZV9pZDoJCVNDTUkgbWVzc2FnZSBJRA0KPiAgICogQGF0dHJpYnV0ZXM6CQlNZXNzYWdlLXNwZWNp
ZmljIGF0dHJpYnV0ZXMNCj4gQEAgLTc1NCw3ICs3NTQsNyBAQCBlbnVtIHNjbWlfY2xvY2tfbWVz
c2FnZV9pZCB7ICAjZGVmaW5lDQo+IFNDTUlfQ0xPQ0tfTkFNRV9MRU5HVEhfTUFYIDE2DQo+IA0K
PiAgLyoqDQo+IC0gKiBzdHJ1Y3Qgc2NtaV9jbGtfZ2V0X25iX291dCAtIFJlc3BvbnNlIGZvciBT
Q01JX1BST1RPQ09MX0FUVFJJQlVURVMNCj4gY29tbWFuZA0KPiArICogc3RydWN0IHNjbWlfY2xr
X3Byb3RvY29sX2F0dHJfb3V0IC0gUmVzcG9uc2UgZm9yDQo+ICsgU0NNSV9QUk9UT0NPTF9BVFRS
SUJVVEVTIGNvbW1hbmQNCj4gICAqIEBzdGF0dXM6CVNDTUkgY29tbWFuZCBzdGF0dXMNCj4gICAq
IEBhdHRyaWJ1dGVzOglBdHRyaWJ1dGVzIG9mIHRoZSBjbG9jayBwcm90b2NvbCwgbWFpbmx5IG51
bWJlciBvZiBjbG9ja3MNCj4gZXhwb3NlZA0KPiAgICovDQo+IEBAIC03NzIsNyArNzcyLDcgQEAg
c3RydWN0IHNjbWlfY2xrX2F0dHJpYnV0ZV9pbiB7ICB9Ow0KPiANCj4gIC8qKg0KPiAtICogc3Ry
dWN0IHNjbWlfY2xrX2dldF9uYl9vdXQgLSBSZXNwb25zZSBwYXlsb2FkIGZvcg0KPiBTQ01JX0NM
T0NLX0FUVFJJQlVURVMgY29tbWFuZA0KPiArICogc3RydWN0IHNjbWlfY2xrX2F0dHJpYnV0ZV9v
dXQgLSBSZXNwb25zZSBwYXlsb2FkIGZvcg0KPiArIFNDTUlfQ0xPQ0tfQVRUUklCVVRFUyBjb21t
YW5kDQo+ICAgKiBAc3RhdHVzOglTQ01JIGNvbW1hbmQgc3RhdHVzDQo+ICAgKiBAYXR0cmlidXRl
czoJY2xvY2sgYXR0cmlidXRlcw0KPiAgICogQGNsb2NrX25hbWU6CW5hbWUgb2YgdGhlIGNsb2Nr
DQo+IEBAIC03ODUsNyArNzg1LDcgQEAgc3RydWN0IHNjbWlfY2xrX2F0dHJpYnV0ZV9vdXQgeyAg
fTsNCj4gDQo+ICAvKioNCj4gLSAqIHN0cnVjdCBzY21pX2Nsa19nZXRfbmJfb3V0X3YyIC0gUmVz
cG9uc2UgcGF5bG9hZCBmb3INCj4gU0NNSV9DTE9DS19BVFRSSUJVVEVTIGNvbW1hbmQNCj4gKyAq
IHN0cnVjdCBzY21pX2Nsa19hdHRyaWJ1dGVfb3V0X3YyIC0gUmVzcG9uc2UgcGF5bG9hZCBmb3IN
Cj4gKyBTQ01JX0NMT0NLX0FUVFJJQlVURVMgY29tbWFuZA0KPiAgICogQ2xvY2sgbWFuYWdlbWVu
dCBQcm90b2NvbCAyLjANCj4gICAqIEBzdGF0dXM6CVNDTUkgY29tbWFuZCBzdGF0dXMNCj4gICAq
IEBhdHRyaWJ1dGVzOgljbG9jayBhdHRyaWJ1dGVzDQo+IEBAIC04MTgsNyArODE4LDcgQEAgc3Ry
dWN0IHNjbWlfY2xrX3N0YXRlX291dCB7ICB9Ow0KPiANCj4gIC8qKg0KPiAtICogc3RydWN0IHNj
bWlfY2xrX3N0YXRlX2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19SQVRFX0dFVCBjb21t
YW5kDQo+ICsgKiBzdHJ1Y3Qgc2NtaV9jbGtfcmF0ZV9nZXRfaW4gLSBNZXNzYWdlIHBheWxvYWQg
Zm9yIENMT0NLX1JBVEVfR0VUDQo+ICsgY29tbWFuZA0KPiAgICogQGNsb2NrX2lkOglTQ01JIGNs
b2NrIElEDQo+ICAgKiBAYXR0cmlidXRlczoJQXR0cmlidXRlcyBvZiB0aGUgdGFyZ2V0cyBjbG9j
ayBzdGF0ZQ0KPiAgICovDQo+IEBAIC04MzksNyArODM5LDcgQEAgc3RydWN0IHNjbWlfY2xrX3Jh
dGVfZ2V0X291dCB7ICB9Ow0KPiANCj4gIC8qKg0KPiAtICogc3RydWN0IHNjbWlfY2xrX3N0YXRl
X2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19SQVRFX1NFVCBjb21tYW5kDQo+ICsgKiBz
dHJ1Y3Qgc2NtaV9jbGtfcmF0ZV9zZXRfaW4gLSBNZXNzYWdlIHBheWxvYWQgZm9yIENMT0NLX1JB
VEVfU0VUDQo+ICsgY29tbWFuZA0KPiAgICogQGZsYWdzOglGbGFncyBmb3IgdGhlIGNsb2NrIHJh
dGUgc2V0IHJlcXVlc3QNCj4gICAqIEBjbG9ja19pZDoJU0NNSSBjbG9jayBJRA0KPiAgICogQHJh
dGVfbHNiOgkzMmJpdCBMU0Igb2YgdGhlIGNsb2NrIHJhdGUgaW4gSGVydHoNCj4gQEAgLTg2MSw3
ICs4NjEsNyBAQCBzdHJ1Y3Qgc2NtaV9jbGtfcmF0ZV9zZXRfb3V0IHsgIH07DQo+IA0KPiAgLyoq
DQo+IC0gKiBzdHJ1Y3Qgc2NtaV9jbGtfcGFyZW50X3N0YXRlX2luIC0gTWVzc2FnZSBwYXlsb2Fk
IGZvciBDTE9DS19QQVJFTlRfU0VUDQo+IGNvbW1hbmQNCj4gKyAqIHN0cnVjdCBzY21pX2Nsa19w
YXJlbnRfc2V0X2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19QQVJFTlRfU0VUDQo+ICsg
Y29tbWFuZA0KPiAgICogQGNsb2NrX2lkOgkJU0NNSSBjbG9jayBJRA0KPiAgICogQHBhcmVudF9j
bGs6CQlTQ01JIGNsb2NrIElEDQo+ICAgKi8NCj4gQEAgLTg3OSw2ICs4NzksNyBAQCBzdHJ1Y3Qg
c2NtaV9jbGtfcGFyZW50X3NldF9vdXQgeyAgfTsNCj4gDQo+ICAvKioNCj4gKyAqIHN0cnVjdCBz
Y21pX2Nsa19nZXRfcGVybWlzc2lvbnNfaW4gLSBNZXNzYWdlIHBheWxvYWQgZm9yDQo+ICsgQ0xP
Q0tfR0VUX1BFUk1JU1NJT05TIGNvbW1hbmQNCj4gICAqIEBjbG9ja19pZDoJSWRlbnRpZmllciBm
b3IgdGhlIGNsb2NrIGRldmljZS4NCj4gICAqLw0KPiAgc3RydWN0IHNjbWlfY2xrX2dldF9wZXJt
aXNzaW9uc19pbiB7DQo+IEBAIC04ODYsNiArODg3LDcgQEAgc3RydWN0IHNjbWlfY2xrX2dldF9w
ZXJtaXNzaW9uc19pbiB7ICB9Ow0KPiANCj4gIC8qKg0KPiArICogc3RydWN0IHNjbWlfY2xrX2dl
dF9wZXJtaXNzaW9uc19vdXQgLSBSZXNwb25zZSBwYXlsb2FkIGZvcg0KPiArIENMT0NLX0dFVF9Q
RVJNSVNTSU9OUyBjb21tYW5kDQo+ICAgKiBAc3RhdHVzOglOZWdhdGl2ZSAzMi1iaXQgaW50ZWdl
cnMgYXJlIHVzZWQgdG8gcmV0dXJuIGVycm9yIHN0YXR1cyBjb2Rlcy4NCj4gICAqIEBwZXJtaXNz
aW9uczoJQml0WzMxXSBDbG9jayBzdGF0ZSBjb250cm9sLCBCaXRbMzBdIENsb2NrIHBhcmVudCBj
b250cm9sLA0KPiAgICogQml0WzI5XSBDbG9jayByYXRlIGNvbnRyb2wsIEJpdHNbMjg6MF0gUmVz
ZXJ2ZWQsIG11c3QgYmUgemVyby4NCj4gQEAgLTEwODIsNyArMTA4NCw3IEBAIHN0cnVjdCBzY21p
X3Bpbl9jb25maWcgeyAgfTsNCj4gDQo+ICAvKioNCj4gLSAqIHN0cnVjdCBzY21pX3BhZF9jb25m
aWdfc2V0X2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBQQURfQ09ORklHX1NFVA0KPiBjb21tYW5k
DQo+ICsgKiBzdHJ1Y3Qgc2NtaV9waW5jdHJsX2NvbmZpZ19zZXRfaW4gLSBNZXNzYWdlIHBheWxv
YWQgZm9yDQo+ICsgUEFEX0NPTkZJR19TRVQgY29tbWFuZA0KPiAgICogQGlkZW50aWZpZXI6CQlJ
ZGVudGlmaWVyIGZvciB0aGUgcGluIG9yIGdyb3VwLg0KPiAgICogQGZ1bmN0aW9uX2lkOglJZGVu
dGlmaWVyIGZvciB0aGUgZnVuY3Rpb24gc2VsZWN0ZWQgdG8gYmUgZW5hYmxlZA0KPiAgICogCQkJ
Zm9yIHRoZSBzZWxlY3RlZCBwaW4gb3IgZ3JvdXAuIFRoaXMgZmllbGQgaXMgc2V0IHRvDQo+IC0t
DQo+IDIuNTEuMA0KDQpSZXZpZXdlZC1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4N
Cg0K
