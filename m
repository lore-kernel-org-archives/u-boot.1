Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE255CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 11:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84908801BE;
	Mon, 18 Aug 2025 13:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Y07bFzBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B788801DD; Mon, 18 Aug 2025 13:33:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9038780107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 13:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8bi0EK01WUoPJRgfmCctTkwaa3jFL4eiZ2vE/eLdkD8MzFqu+ndDoGYXUznaei3HjA9FRkcFiv60wn8T9fR2omxpKk3udm3I0LzWRmH3CPEuSgx2unOrOoCzonuBKsH592XthasKK3V2ImhG0mnOFSdDe4vDJb+f52LF7D1+yOyrPEmVzNhkKssPnBtcEfrtUd73fsSTXDIBsRfz+PoJZmc56r97oLSz2NvcGK74uwKGL3Aopt2yB9mnqGk0F1a/euodFKF+hdbZrZht1ytmdfCRu850CD7W2wMZcQ46aavZOzlLb0n0dyRWbkj1c0+bdtmwwCdxg6P21PCOj1giA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DPVwM7B4s1DE4rZCNHeuwIggtNKEv/LLlUehh2a27s=;
 b=ISKNF9Ws1v6dEx+DIYIRUy72Q2HB3xFjXKrDaWUFg3e6AFVhHTypu3tDqim1vW2ovlT2lKbKaXe836vll3a6ogFTZDb79VPsvCfU8NfBxlXaDiiWRUYU3kHdvoLafl7yuQw12E1BWPq9zAqJZK+vzS2Qm75dTXGIcDH6EJ5pP77y3u3uZnPTFOm8rqkQniVCxoIw078pXdoCs9XPOS18sI8OSsqr2GRmZUZiK7dKit0eEiGKd696DFlVx0wbKFKW+tNPWMnapRuFikzzbh3f0U53jiZJstmOXqwC8LSbigwOTFftRrQIiCnnQJrnqp/mWIWZjgz9OWQlLKuvlpmx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DPVwM7B4s1DE4rZCNHeuwIggtNKEv/LLlUehh2a27s=;
 b=Y07bFzBzBugDM5ywfDalD1pZRjB4gaSgFK7GUBjY1uNLJp4Ti1aDHPGgIpJb8v4ABw/v+JmgriSsZgvrlJg/rtJy254zDmdNMNd4hG5T6ahYW95ChqVjq5W/MnuQham5AamLYpN9zbUNMNcPUuXobqtSViGtd8oIPUkpKiCE0bUJZQvC/FIq5f98qycTiBKtZQgk1Mgli5TRClvEEeFGrw7MNiJTn9lKy8P66Y2elgBPBu1UMb+ozCpqlCV4zcEjXx0Zl+aO3bR3my57m3Y9d30QlUFiTv2Ks7wtVt28jvi+4UC9cUFjKAAmxUTDXmYL3FzndeJMZwpdHnJQQXTPqg==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by GVX0PF830FF53A4.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::7d4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 11:33:23 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:33:22 +0000
From: Martin Schwan <m.schwan@phytec.de>
To: Wadim Egorov <w.egorov@phytec.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Daniel Schultz <d.schultz@phytec.de>, Garrett Giordano
 <ggiordano@phytec.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] board: phytec: phycore_am6xx: Add rauc to bootmeths
Thread-Topic: [PATCH] board: phytec: phycore_am6xx: Add rauc to bootmeths
Thread-Index: AQHcECqNrxnFvPaXRkysOQmxF9brbLRoR3eA
Date: Mon, 18 Aug 2025 11:33:22 +0000
Message-ID: <3e22d7d70fc21720fde43c097c1c76e3d66007ab.camel@phytec.de>
References: <20250818102605.2248056-1-w.egorov@phytec.de>
In-Reply-To: <20250818102605.2248056-1-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|GVX0PF830FF53A4:EE_
x-ms-office365-filtering-correlation-id: 37830984-bf85-4a37-ab2a-08ddde4b0a08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YXcvcDd6Z0lFUFZUdjhGTUJ5RnZVZVFyR204VXV2YisrbTI1YU5MeWhncnZy?=
 =?utf-8?B?TmRydWJPem5rY3J3MDl2QmQreXNLQ2gzR081WXNIaFNHblZSZmxYLzg2cGNH?=
 =?utf-8?B?N0FXVERiZ09xRmt5cTRmL3BDbHdVUk1RMkNBV01sb1RmNnZ3WHk3a2tnOUxR?=
 =?utf-8?B?bFJnQjRTRDdDM2FsemhDckFxanQ4aVRYbEFheWZ0aytWVm54cWxyWWhaK2l1?=
 =?utf-8?B?QjBRd3pYbno1dU9aVDFiQndyZ2wvd1dQSG1wbVBzdVVELzMzbDBDSXNPR3VN?=
 =?utf-8?B?dDVheWxaMndyWlo1anNHWjY0TnZmTUZmaW1jUWpzZTY0T3ZUU01USVdxSm9k?=
 =?utf-8?B?bjVVdW90OWZMMkRXSHJ4dlp2TitHcDFxYVFnSERha2tQcUNVbENjRGZNQ2Rn?=
 =?utf-8?B?QlhsRXFRb3dRb2d6NG9oSGRPZ1ZTRUJVOExaaDZDN1plZm9QMUZMU1AvRkw0?=
 =?utf-8?B?elA1eU5PSzR4WjFuK1ZqV0d4Z1dFd2wvSXNKandkR29LckJnd1dxMWNlRlJS?=
 =?utf-8?B?L3JEdmpzWHpQbFFMK1NnZEtncWhueXFucE1KSXFFTmFsTFZaUGJCRWhaQzJp?=
 =?utf-8?B?endpNy9Sck9xR1pPNytQVk1JbWFhY1UrYVJTa2ZMMnlQVzhueW5FVTErTVd4?=
 =?utf-8?B?UENWZklmZjhEVk1jNyt6VGVFMVFGZjBvVERZZnRaMVlJYUpkbnpvZElUWHlk?=
 =?utf-8?B?a0VkYmJ4UWxtNkc1QzBEMGxaQmVDNVJjbU9IWllPd0JlbzBpdXUyYjZvdk5B?=
 =?utf-8?B?TE9CYjZkWnNjdmxRbE00eHV3UG0zdEJvNy9uWUFLT0s4TjJxZnp1RzBFTHh0?=
 =?utf-8?B?R1hjTExnVXNWUkZWaEpYMUFUYWI2ZFVwdFNaTm1sV0Y5M2lmNmN1dlBkakJx?=
 =?utf-8?B?V1AwemR0bTF4WFJ0THBRRi9FVzMwU1l2L25YSDJ1SUU0QTMyc0dWekM1Nm5D?=
 =?utf-8?B?RHE0K29qaHQwNmRTUFRNTldzeVRpUVY5dmxzVExNVUdNS2pJaEU4Vmxaa0g0?=
 =?utf-8?B?MGVJMGFFYUZFTFduRU5Qd3VVVUhqT0xNZWhUeElhVGdsT01sSHZZUFovQzVP?=
 =?utf-8?B?WWVMbmpsSnV1ZFFDZmNpcHlIdVZuMjFpd2RkS01sZy9RUW1FZmZkamFoMmoy?=
 =?utf-8?B?TXErL2o1Y2lLY2ozU1pWOXo2RXVERUJLa0VRbTFtcUh2VjBpd0VITWlFMlZX?=
 =?utf-8?B?elU3MUl2UmxhV2xNemg1eVl0QnRQTTNMSE9kMGRlTGEyUEF3V2FqTUROWS9E?=
 =?utf-8?B?R3B6TUFiWFc5dHI2Zmk0MmY1TEhFU1Z0RGhSMytCNnVQdklWb2k1NTBBQzFv?=
 =?utf-8?B?a05YdURPOU5DZW1adnBpNVFweWlNU3MxQ0ZYYlFzTFVnKzRIY3FsZmE5YTVU?=
 =?utf-8?B?T0NLWXRvcE1GekZJS1luWU95cDZwTWQ3bC9Nd0h5NmsvU3UrMGRPUUVmWjYx?=
 =?utf-8?B?eGxDcWZ3VElYeXZoNTMvZzVYM2xFNTlaemFFVTNYZXdDckU0Yk1BV05vOTA2?=
 =?utf-8?B?RkZmS2hCSENmZUFIMlRZcFY3ZXF2NGI5UnhJdCtRemFoUFRnUWgyQ21IWjEv?=
 =?utf-8?B?dWEwMXpVaDhaeFQ5aGlXUHhqVHI2WWZmUFo2N3N6TkFqdlRFcXd4enBPZXNx?=
 =?utf-8?B?WFJrMUtWTi96TksyMGpBQjQ2TlVIb2s4TVlncjdlRTVlbjEwd0RIcWxWK2J3?=
 =?utf-8?B?Y0F3dXJuRU9FOWp2M3VuTU14VkZSRkpEVDVxa3VhdkgzcS81VjNSSlhheW5x?=
 =?utf-8?B?bWsxNFF6NXh3U0FGaDZ1RWJENHM0YnVBVGl4ZjFKYWtMVUpPVFNoa3J0RWJx?=
 =?utf-8?B?em9mcURTTzE0NGNPOU1SRURhczlNVlJFVFU0SmtLZEJRM09IblMzeFd1WGV0?=
 =?utf-8?B?QnpGUHZ5SVY0eDladWZMKzU4RnV3Nyt5UHlHME56UDk4VE5IeDFaLzY1WGlv?=
 =?utf-8?B?QzVCK3BBdTg5T2lDZ3g1a084N0cxRnVEVk9UNFh1YnpSNWx3Tkg4Y1ZWS3N2?=
 =?utf-8?B?c25rK29kUmt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QytsTDhka3Mzcm9vajVxVHFZRFhCb2ZleVNmR21XV042M0p1WmticUd1ck5T?=
 =?utf-8?B?MFM0eHJwTDF1UlNKSXEvTlAvSEZUNEY4aWhpejlJQktsZzBMUWl6R05hWFNN?=
 =?utf-8?B?Z2JEUVI5N0xEbzhIem5YR1JOZXFRL3M4bS9hSHloSzhZbkJUdEs5LzBIZWhN?=
 =?utf-8?B?ZTRhUHlnaUx6V056bWROSDk4TGNzcFhLOWZKM3V2b3pBRVc2bTBSeUlFa2Fa?=
 =?utf-8?B?b3h6QlVFWFd4TDZjUGU4VE9lYkM3a211VmU0TTU3Qjc4Qys2VmdiSHdLL2Y2?=
 =?utf-8?B?TjJBVk02TlBMSy9nSTUvNVFXdzRsTUQ4a0ZKV0pBQVhoNXU5bk9GWkU4RzVI?=
 =?utf-8?B?Vm1wdCt3Q0hOR3Z6R1p6c1hwWHZMWSsvMGJEd0tlWE90d2FJb3RXbWFmdTdM?=
 =?utf-8?B?aEd3VHpZZzdLajFmTlBORFdXMVphR0xLZnNVQWRpRzZ4OW9ueUZLK1YyeUhB?=
 =?utf-8?B?eHZsTTZZY1I1eUxrQU9pbnE0UTFZWjl0ZEFXTXNWSzJPeFdVZ3BmazQzU2FU?=
 =?utf-8?B?NkFyakRZU08yaWUzVWtVYlNHaVRST0J3dHMwSEsrRmxNUHB4dXkzVDgwNjNx?=
 =?utf-8?B?MlBJYnJkeDF1WEZHc0ROdU9NL01BdlVDOXNRN1UrOHdWbFBEZSsyY0lEaFpL?=
 =?utf-8?B?Sks3M29DV1N5UWZxcE9rcUx3TUd6QmtWTnNWMTU0SGJ5OVRJbnpTakszdFhD?=
 =?utf-8?B?ZGRNSXVyUFRsU1YxOXJEVXJqcDdlcERCWXMvZ2wzS2ZzZ1ZhTDRRQnY4RERF?=
 =?utf-8?B?NkdzWjBuWWcxRkZrUGN6ZExBYkN5Vnd4bzA5Q3FxRUcycllYS28wN0cwc2do?=
 =?utf-8?B?YU1OV280cVJXbkg1WW9iSFpDMVRVUDk0b1Rob2RyYTRqM0RIQUhPSkNBcWly?=
 =?utf-8?B?SEdqclJ0S2xzTmZOWkFOR21TMFJsczFsLzNCeE5DNDFHWHdEZHVSYjliaWtD?=
 =?utf-8?B?S2VtbDE5VE5CREFOSTZjeWUxRnE1eGM1Y0lVK1QyOVEzQ2dEOGVDUlczbDFC?=
 =?utf-8?B?V3FZb2hub2Vpc1pWRHpWQWwwYS9zQ0ZFR2I2S1ExSEIxVVVWZ0IzSklhakdS?=
 =?utf-8?B?QnBLTEQ4bm1FWmxpdzdXbVdEd0ZXUEFabEQ5eTVxT24vQzBSOWJZbXlrVE0w?=
 =?utf-8?B?R2JpWVNCbE0xUEFSVEI3cGkxd1Y1elZiMlJvR3lBR0JMTTFxc1RMeUdPYW5j?=
 =?utf-8?B?SkFRYUdSQ3B4cVZSUjhSWVR6bDZuWjBXTUUwS2xYVE04cEJnZklFcWpNRVZi?=
 =?utf-8?B?MEVCend6Z0dzeE1TQytQb2RSeUtwbWc1R3hFUlcrQ0YvMTBvWkFySnJBZmpR?=
 =?utf-8?B?SDBuQ3I1bTJaOWZxbkNkbjYxZGdNR2lkc0RWOUkwekszYUZkTWRUWDFNUSs2?=
 =?utf-8?B?NHZZb1ZaK3NNZkJpRmJzTk5MdkZxMklncDhsZVZLNmlURkVnUFYxMmplWG1P?=
 =?utf-8?B?U3QwNVdSbG1BZWx2dEZIcnZ3dktvOENoenVZQlQvMjBtc1ZlUC9pbmRnTFVk?=
 =?utf-8?B?MUtxeGxHdzVOeTg2aDd4TUI1d09lM3ViVDh2bkxrb3ExTUpkV3REWFBlZElR?=
 =?utf-8?B?VjV5OVExV0VSbVBXTWdXVDF0cHR5eHZzM1ZRRCtwN1NqU0oyVk9keTNDRnlk?=
 =?utf-8?B?MjhWTzEvZGZhUlpNMjlncTJJZ2lBOVE3Yi9VNS8zd0hWU1FlYTBFZTBhRkxj?=
 =?utf-8?B?WWxWcThZVUN0ZE9PbEtRa0ZmRnQyWS9tNmRGWmIvcDNnbzdzVVAzQzF2TDNP?=
 =?utf-8?B?OGhweFZuOUlzYllGZnNZYTBka0pwTEw1ZGVySmF1WGc1MWdJQmJFaUpoVlRy?=
 =?utf-8?B?Z3R6NmNSaG1jU0MyK25PSVRNdjQ1bzM5SWxJUkExckYyWURlRXBrdTZCekJt?=
 =?utf-8?B?N3dhOFZwVm13WGUxL3RyQzVxRVVselVOY1ZMWnZ4UXFqcjEwKzhpeWwzYkxG?=
 =?utf-8?B?SjZtN2cvdHNDRW41d2w0YTRTTERiT2xQaUc1Ym5rSEtUNzhIdUY1b3RUSGhp?=
 =?utf-8?B?cFJDZU5aajY0SzdKSVNlT1YwVnV4Z0dVZHprcGhIZ3hTZzJrcGE1bWZFWGd1?=
 =?utf-8?B?NUZBbmVmaDZrbThST1FJb0dwT3czWWdMVWNGSmdvNHZlenAzN3RRT3JEUm1r?=
 =?utf-8?B?a01mNERkKytVQ0pqeWJYaHdTNTZPQTFzajhPRnoxR0pRT0tPQnRwVHdVUElD?=
 =?utf-8?Q?SvbNTAoiJh1vVOXAWll0CT0JG+V3DyadDiBzTGKCJ57a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FEBF64D4C6D0445983E91D1AE036AD8@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37830984-bf85-4a37-ab2a-08ddde4b0a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 11:33:22.8459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMqlN9AeidTz2OZ35pxRrLcxE9tQnpzecy2cjnSuhV1UrHqKMBBxRTUGsdDkTewniSrBwO5+LLO8kUiAdbgv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF830FF53A4
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBNTEyDQoNClJldmll
d2VkLWJ5OiBNYXJ0aW4gU2Nod2FuIDxtLnNjaHdhbkBwaHl0ZWMuZGU+DQoNCk9uIE1vbiwgMjAy
NS0wOC0xOCBhdCAxMjoyNiArMDIwMCwgV2FkaW0gRWdvcm92IHdyb3RlOg0KPiBBZGQgcmF1YyB0
byBib290bWV0aHMgdmFyaWFibGUgaWYgQk9PVE1FVEhfUkFVQyBpcyBlbmFibGVkLg0KPiBUaGlz
IGlzIHNldHRpbmcgYSBwcm9wZXIgZGVmYXVsdCBmb3IgUkFVQyBlbmFibGVkIHN5c3RlbXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRlYy5kZT4NCj4g
LS0tDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfYW02MmF4L3BoeWNvcmVfYW02MmF4LmVudiB8
IDQgKysrKw0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2FtNjJ4L3BoeWNvcmVfYW02MnguZW52
wqDCoCB8IDQgKysrKw0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2FtNjR4L3BoeWNvcmVfYW02
NHguZW52wqDCoCB8IDQgKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjJheC9waHljb3Jl
X2FtNjJheC5lbnYNCj4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYyYXgvcGh5Y29yZV9hbTYy
YXguZW52DQo+IGluZGV4IDc5NzkwNDAxM2RjLi5mZjRhYjhjODdiOCAxMDA2NDQNCj4gLS0tIGEv
Ym9hcmQvcGh5dGVjL3BoeWNvcmVfYW02MmF4L3BoeWNvcmVfYW02MmF4LmVudg0KPiArKysgYi9i
b2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYyYXgvcGh5Y29yZV9hbTYyYXguZW52DQo+IEBAIC0yNSw1
ICsyNSw5IEBAIHNwaV9mZHRfYWRkcj0weDcwMDAwMA0KPiDCoHNwaV9pbWFnZV9hZGRyPTB4ODAw
MDAwDQo+IMKgc3BpX3JhbWRpc2tfYWRkcj0weDIyMDAwMDANCj4gwqANCj4gKyNpZmRlZiBDT05G
SUdfQk9PVE1FVEhfUkFVQw0KPiArYm9vdG1ldGhzPXJhdWMgc2NyaXB0IGVmaSBleHRsaW51eCBw
eGUNCj4gKyNlbHNlDQo+IMKgYm9vdG1ldGhzPXNjcmlwdCBlZmkgZXh0bGludXggcHhlDQo+ICsj
ZW5kaWYNCj4gwqBib290X3RhcmdldHM9bW1jMSBtbWMwIHNwaV9mbGFzaCBkaGNwDQo+IGRpZmYg
LS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYyeC9waHljb3JlX2FtNjJ4LmVudg0KPiBi
L2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjJ4L3BoeWNvcmVfYW02MnguZW52DQo+IGluZGV4IDc5
NzkwNDAxM2RjLi5mZjRhYjhjODdiOCAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNv
cmVfYW02MngvcGh5Y29yZV9hbTYyeC5lbnYNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVf
YW02MngvcGh5Y29yZV9hbTYyeC5lbnYNCj4gQEAgLTI1LDUgKzI1LDkgQEAgc3BpX2ZkdF9hZGRy
PTB4NzAwMDAwDQo+IMKgc3BpX2ltYWdlX2FkZHI9MHg4MDAwMDANCj4gwqBzcGlfcmFtZGlza19h
ZGRyPTB4MjIwMDAwMA0KPiDCoA0KPiArI2lmZGVmIENPTkZJR19CT09UTUVUSF9SQVVDDQo+ICti
b290bWV0aHM9cmF1YyBzY3JpcHQgZWZpIGV4dGxpbnV4IHB4ZQ0KPiArI2Vsc2UNCj4gwqBib290
bWV0aHM9c2NyaXB0IGVmaSBleHRsaW51eCBweGUNCj4gKyNlbmRpZg0KPiDCoGJvb3RfdGFyZ2V0
cz1tbWMxIG1tYzAgc3BpX2ZsYXNoIGRoY3ANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9w
aHljb3JlX2FtNjR4L3BoeWNvcmVfYW02NHguZW52DQo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVf
YW02NHgvcGh5Y29yZV9hbTY0eC5lbnYNCj4gaW5kZXggMzZhYjE2ZTJmN2EuLmNiYWY0NWIzYWNl
IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY0eC9waHljb3JlX2FtNjR4
LmVudg0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY0eC9waHljb3JlX2FtNjR4LmVu
dg0KPiBAQCAtMjQsNSArMjQsOSBAQCBzcGlfZmR0X2FkZHI9MHg3MDAwMDANCj4gwqBzcGlfaW1h
Z2VfYWRkcj0weDgwMDAwMA0KPiDCoHNwaV9yYW1kaXNrX2FkZHI9MHgyMjAwMDAwDQo+IMKgDQo+
ICsjaWZkZWYgQ09ORklHX0JPT1RNRVRIX1JBVUMNCj4gK2Jvb3RtZXRocz1yYXVjIHNjcmlwdCBl
ZmkgZXh0bGludXggcHhlDQo+ICsjZWxzZQ0KPiDCoGJvb3RtZXRocz1zY3JpcHQgZWZpIGV4dGxp
bnV4IHB4ZQ0KPiArI2VuZGlmDQo+IMKgYm9vdF90YXJnZXRzPW1tYzEgbW1jMCBzcGlfZmxhc2gg
ZGhjcA0KDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQppSFVFQVJZS0FCMFdJUVRo
OWpjOE5CVkttTUc5Z3hOUjNZVTQ1MmVUQVFVQ2FLTVBnUUFLQ1JCUjNZVTQ1MmVUDQpBYWZnQVA0
dC9yelZMUFNiTXNRbkFIUjAvemRaUUg5UHpFMm9PWGF6SEtBTzluVWJrQUVBenNIdTR6WldyUkd5
DQpLVVIvdm9FZ0lnOFR1a2FDS1M4c1VkOEF4dWp3cWdjPQ0KPTRWUGoNCi0tLS0tRU5EIFBHUCBT
SUdOQVRVUkUtLS0tLQ0K
