Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E810D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7D383C53;
	Wed, 26 Nov 2025 16:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rZmUMksb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8AB83DEC; Wed, 26 Nov 2025 16:30:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2969183BF1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLmZMJ+otQSAkVAHG3t+mEiS8sBjNbAkyaZPIUj2eTIstfmhwEv9sEe5NOoQyk2snWsH+mPbw7WtRR4n0ynxI18Uk1Ei11xy7/5loETaVDM75snyYium/jgw2X0SHdA6GSu6/l8ZEKt0wNQXOKQypmViBykSz69Tj/zmjDQNqRlSU1OGJJnHqwDF5+LBfUkH+3dku3o2ZxTTDdI+oV0K77Lp9PkMFfNqbMo3noVzMKrUeIAZ5VJS8u4XHfK26HbS9iPqKY3PYosqQdtCb3hqWk3fq1e95ipOtniuLMcxQfFNj9uqMmoZjk3dDdfFzuVm92M5LLJDOmA7BpMKLXtw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiSc/2le2PYkAssaYVfoSvVJ/7sQDmcIkC7nkazeIhY=;
 b=Gmsxcxdo5LdPP0sxZwhLQKJoXAStZFf41BWPLEVQpUXDWzh5hC1uYIEt6VS7Qpp5UAsTyDVSZ8UAqU5OlDgiUSQZzhLGtrJ96OAza/UPDjzwi5EkC/GyHo0lVlWZOeTzxHQFD9p0oxBVtuvRhjLPbOvzHDl2TCgLkIQjfcrcikpf0VTKrLg4/qjifaI5293Yxq+hncPPakeD15msma2XaT12jiwD0eqjClwz/P8aFj5hUVWyKOl53PL7huAFuxeQhp3dGTymyVDBfxLqyTxMbVvqFNXHI5gtRuzPvSB0NXks7QbNTK3a7mJmzC/CiHC5LJX1YPedJRwkkFsPuarqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiSc/2le2PYkAssaYVfoSvVJ/7sQDmcIkC7nkazeIhY=;
 b=rZmUMksbKtTqZEAL+KPpnjbbtRjzD+L1SHpaq5sLb4UBtuzwwYWyd+HI8dPzirGen8DqhXkCeG10k7dTx8K4l+rOdJe9kL7u9DMsn2UddYU2iLEg+jBYRCH/4Zad07PkU5+WDdJqLV16AAOB+Je0julonOXp3eeA1P/wiqYw8yaWUCGxIqlDFjLNXCipaz6WK7VRYSjoaeJLvmg1qD84WUO4fdKLkgwXW0H5QWA4CX+EyupmHK97Lk0gKSSzMmTNJkMZPPhk68NhOerTZflkyv0yJZ80yE6ogBCSg8vuIPekorZlki86OVcp7X3HwkELsNrsOf4+tTBdpiaMsvLUEg==
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:588::12)
 by GV4P195MB3027.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:30:30 +0000
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c]) by AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c%5]) with mapi id 15.20.9343.019; Wed, 26 Nov 2025
 15:30:30 +0000
From: Benjamin Hahn <B.Hahn@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Tom Rini <trini@konsulko.com>, Peng
 Fan <peng.fan@nxp.com>, Leonard Anderweit <L.Anderweit@phytec.de>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Martin Schwan <M.Schwan@phytec.de>,
 Yannic Moog <Y.Moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <Y.Bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>
Subject: Re: [PATCH 1/6] phytec: change preferred bootdevice dynamically
Thread-Topic: [PATCH 1/6] phytec: change preferred bootdevice dynamically
Thread-Index: AQHcXjA4gSKD9qqqyk2IJ7hxsaMdKbUFFtCA
Date: Wed, 26 Nov 2025 15:30:30 +0000
Message-ID: <fd9a733c-3e9e-4063-a708-1e3c0180f7fd@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
 <20251125-wip-bhahn-imx8_cleanup_env-v1-1-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-1-414829c01b4b@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB2011:EE_|GV4P195MB3027:EE_
x-ms-office365-filtering-correlation-id: f476cea4-0d22-4390-ddfc-08de2d00bb7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGcvSlRoSmZ6RHBPVW42NVF5R0syYld0eFpGZ0VwdFhER3dpek5kK1Nlc3c5?=
 =?utf-8?B?Qnk5OVJZbWxQeHFURjdnaTJrYmJBNDlKQU0xeVUzeFBkWkxXaVpDQmVuZ2Qr?=
 =?utf-8?B?SEE5M2tKZXYxVndnVVkrSG5DdnQzbmZ1YzVxZW9SZkQ0Q2tLTURmSnk1Z0lB?=
 =?utf-8?B?KzRYR1ZvTGJjcEVjTS9OWTkva0MzQlh4QXFyQWhCenVRNFB5ZTJJTU5EbUZi?=
 =?utf-8?B?M01OaU5veWd6N1lrK2RmdDFVZGN6clFncVQySjJNVmZrSDhySmJFbGZyUlFw?=
 =?utf-8?B?TjRZRzBSSGE2NCsrM1Q1cmRYeUdVZjFOSDhPTE1vdGhTaVYxOFZyUng3TmdZ?=
 =?utf-8?B?K1NnSXV5WWNldTYrQkduNXpPaWZqNWg5MTVPZG5pVXhlaWQwTmswU01KK2dJ?=
 =?utf-8?B?cTB5c0RMQk9ERW5MSXU0Z0FoQXFKakpRM2VLVWJKR1hteEgyRjlrcUNkUkg0?=
 =?utf-8?B?TWp5MVNtTWhWS0IrdFFlcE5DRkxTYjhuc2dRQzhaK3dmRGdKTVlMVkRTbjFm?=
 =?utf-8?B?bVR4YlExY3NVUGExRHB3ZHE5Y2p6SlhGMjZ2UTRCTDd5WmVGaXdnMmp1bzdZ?=
 =?utf-8?B?Z2JCVWxzU21HMUxtOGo5Z1ZTbTZDVDB5UzFoTUlqQzJqamZUWFk0VGNabTM1?=
 =?utf-8?B?b3pYdTFYZksxTXZPUWJ1cFRReXZyK1U3aTZRcEx0ZmxjOXBHaXhIZm1YOHZ2?=
 =?utf-8?B?eFR3MnhwQmJiZEdZSjM3dXdyMTFpTmRoUHVWSzIwYmkwUU8xeFN2UThMSkFU?=
 =?utf-8?B?R2k0a0o0NzZhU0w3bVBoQVVHdVdabGllSEVuS1NuYVlFZTBoYjNMcjVDV1NQ?=
 =?utf-8?B?aW5SWEphMFJHZ1ByTjBsU3RIK2IvdWtNYVhSeTlaSGx4d1FUWGNETXZ3ZTZW?=
 =?utf-8?B?NXdCZHZ1V1NPdXJ1b05kUG1NcTJnaGRab2JTWFp4RS9mRmg1WmMweExJejMx?=
 =?utf-8?B?MGJlSUdsWkNETnFtaWV5Ymc4dnNhUVErbWhEVytDWGJ1VDZoZG5WZzhUbmFH?=
 =?utf-8?B?UTVBcEpJRHVTdktyaUFPSTIzUXZUUG5ZME9QaEFQcGM3Ym4wMXB5MTg3RzIz?=
 =?utf-8?B?TnJPeFI0cEwzY2VleXVPSExxeGZFWlltUUtjeDRwdXRZTHZKTU1IWFVrLzEx?=
 =?utf-8?B?Ky94NDcvYytPeXJNc29uTE9xSWxzNlQxSEVBNTQrRmN0cklGQTBSbzZjczYz?=
 =?utf-8?B?YzgyRXF6WjRJZTZvZWUvUEdUcnNRK1NKbGhlWjFWZFR1UjJOMjJMQnpMRkZD?=
 =?utf-8?B?a2J0UmJmSGFHY3FNa0duRkRkS0YwbXRURVZPZ25qT1F5RXZwZW9sTnhrR2pW?=
 =?utf-8?B?aERVQTFLdk9Ia1ZXeGVmMWFzNS9CQm4wYVR4Wmc2WHFuOUIxaklINEttck4w?=
 =?utf-8?B?UERYVXQwSHB5blVicFdVSllsblBvYzVXMFdablZ3R21PSWdDaVdzTW1JbXdR?=
 =?utf-8?B?bEk1bVNPQ29oVGVQYklzZjBqUG9lTStwUTNqaDhJTzFkR0FFMXViWXUyY0Ja?=
 =?utf-8?B?ZXpWVVpXajB1aEY2MDFtU0R1WWlQSTF0N25zb0t4QTJsOURHK3JJSk9ydWhY?=
 =?utf-8?B?RWt4UTlHZmNlY3M2ZTJJQmZQNFFVRXYrdVI2azczVEpPRWRiNVF4QkJOUWFK?=
 =?utf-8?B?Um5kZ1lLUE9USWYrQUs3dmFJVk5zUjAvUlBlV2Y1emthY3dMLzhIU3Q3OWNW?=
 =?utf-8?B?YTQybHhmWkloMXcvVkorcGlra01tRjN1Y0FVc2JyZXNTSXZEZDArS0EyV1Fk?=
 =?utf-8?B?QUV5VE1jM3RFaTJrWm5zWit4QkZ3Q1lCR1Fwa0tpRnpCVTZhSkhOcnZ4bnpt?=
 =?utf-8?B?RUpLWnRQeU0rVjlmNy9TRkZHQ0w0WnFUKy9lclRsem9uOGVtbEMzZitNZHNa?=
 =?utf-8?B?VnA5cXRjTEtCelYzQStUTzNEWXlzSDlWRTFuZTVLelhmZzUzRGZMYUVaVFM2?=
 =?utf-8?B?UW5uQzAwVk1ObEhVV2J0TUJCU0Q0c0VlbW5aN29odytRS2tkbEVMZnFVVGwr?=
 =?utf-8?B?Ryt2SkZrS2U3Q2s3aUYveE9HaDhLZWJCRUJnQzVWYXZsZ1luaElDckpnSkpI?=
 =?utf-8?Q?y/f4Dp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB2011.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdiVlBnbVEwUmsxY09WZVZwUkZlbUJ5YWMzNFpBTDlNK3FLbGJGa0VXTUhF?=
 =?utf-8?B?dDNTcXJFOFNxYm5BMjEzb3doSDh1bnhqQk9RWGkraEVycExSUUs1UXpYQXJt?=
 =?utf-8?B?eFN6VXM2R1krU09tZDlQZG1Ta1VLRVZuRVk3Zk1ERUJaSjB5T1VlOFZ4WmFB?=
 =?utf-8?B?THRUOXlVWW1DUDZwWUpZR1ovOFBnbUJEYW5HbFRxb3FHRmo0cEUxTGlOTmdO?=
 =?utf-8?B?SFN3NDdOVkM1VFZnUW5NVWVuaHVSQjRUQmxCcE5QeG83WWk3dldwcHMxVW1V?=
 =?utf-8?B?RUZoUm85TGRhT2RFQXhPWHR5L3U0V043S2xyekN1TXpQd0UrNTl2T2hWVUN5?=
 =?utf-8?B?UDE5REpXQ0wyRm1iY25lN3VmZkNlZzZVYm02c2JLSDREaVROVlpRdU5abWtU?=
 =?utf-8?B?aFViWGhzR3JLR3dYN1JsMzBtN1ZkSnUvL0s2dFpkUHliTTlpZzRIVGhkM2Ns?=
 =?utf-8?B?cGw0elM0M2dPNWNRNzlLQzVIY2VBWEtDZXdPK3QxMXlBT1lYNW1xTnk4MW1F?=
 =?utf-8?B?cVkyUGtNcHdFb3c5M01PU1d5MmdocmVSYUMxd3JxSWVXdHhDcWM5TXRKeTJ3?=
 =?utf-8?B?SmVRYWVlU2JucFN4Zk1zc21DUW1qYXhPSWpqaHlpZUl4M3BYelQ4Yzl1Q0VB?=
 =?utf-8?B?aFFJNXRxS29mSlVheS9QRWdJSlhHUjB5ZG0zdUtXaHpTaUE0QTNRNHJTUmVw?=
 =?utf-8?B?b0x2NGl5eGhQaGt0VTJwR0tvWk1EdURKQ3VvR1c5L0tndHFSeVBpelRkOG1Q?=
 =?utf-8?B?R1orREI2ZjJLb01xMmJZbGhUR2xaVUVYRUZuRGo5VXV4SEliandZYTJObTEx?=
 =?utf-8?B?bnBjSXIvMzNvTUNMSGQ1RGhjRCsydXVVVTJZclhSTjNUVkxnRkdXQVBKWTA0?=
 =?utf-8?B?U3VLL2I5RGYvSVIyQjh3OThnL1IyUnpqVWRDMkFqUG9UMlZoMjdqUVlUc1Zh?=
 =?utf-8?B?L0JUY1pETUN0eUVjQmRuZXliUTlLMW41V2p2a0s4ZmFKV2Y1TzkwVDE3U3pH?=
 =?utf-8?B?MXhnWDJ0ZXJ6dlVRMklTQ1IralluOEE3QU91MFp6WjJ1c2xnRHhIeWxwZXhz?=
 =?utf-8?B?OXo3cWh6MDRLNEpEYU5SRWNCaHZTTk9vbVA0eEZBMzNCYlRNU2U3UmtuT01I?=
 =?utf-8?B?cmxyWmhpWkNhYmNmL0tjb056YmgrRzAyc2RyZ1RaZDliR2N0Qmh4S1NKdXBS?=
 =?utf-8?B?TlhjNVRZWXZpdUwzVkwzelFvb3hCTXVnSGxna3lSTWVQUXV6aFhaemZwZ0ZN?=
 =?utf-8?B?VFkxUlZMMzEvSVRuVzgzeFVTeVFLcGhuaGRSYVpJRCtjVFBTcVRSVmFNeStF?=
 =?utf-8?B?cjlOS0xHN2h5UW5UcVVrQzZrdjdTRzMyNHQxMUZiN3BBeVFpdDhJbDYzUGlx?=
 =?utf-8?B?VUZVeWhVQnFuS3J5UmQyZjBwcS95VjcrZ0xTcmFZNWh1dkZ5OXFmNmpmL2tu?=
 =?utf-8?B?elhzdEV1V0JzNzJZWjBMOTVTUmUwdklhZjJCNmNUM1VudFNrM3RzNHo0bFUr?=
 =?utf-8?B?ZklHRHQ4VlRJdXhacHIwak1HM1gyTEFWM1ZIUXZOd0NoTEV5aFlKVmU5QXdH?=
 =?utf-8?B?bWdCMVNZM3ljdUJmS0djTVU2TG5TZGlNN1V2SXBEN3RiZ1R1M2gzaEVjcERS?=
 =?utf-8?B?MGtKZXl4WlhoUGV2WWRObUFSellqOUR1OHRBN3pCOTR4QXp0azl3RjFrQW45?=
 =?utf-8?B?Rml2MUNqZEJOVkJpU21jcGZIT1hwVjBTUUlTa0kxNXZkQ0lQUUgvaEYyOUNo?=
 =?utf-8?B?eWd3MEMzaklJZW5lR2g2WGUwM09ibFFnZW03WnJueEhuRm9TOFJ3aVNNYzBl?=
 =?utf-8?B?U1g2czhPSUV4c2dudU1tWXNoa2tHTjI2QXhGTTR5MGUvMXR5T0ZDVGFnSVgr?=
 =?utf-8?B?Ym95cWMxckozV0dBem5pOUthTEdQajlrUWJoeUNZSkVONTRHTXNyMmwvWXc3?=
 =?utf-8?B?SkFHc2haTDY2N3R2SVNmZURXL1gwZVNFVzBZelRaKzIzeW9vYmVhQnlrQXVU?=
 =?utf-8?B?NkwyU1pBa1FzeGZ2Z25DUStlRC9tWjVXaDNQMS9wWHlPVVRmeVRwVDNzRGE3?=
 =?utf-8?B?RkNHUE1DMitkbmZIbmpicU1DQUcveWlmSVZ0SWNPa1B5dFl5QUg5MStzVTFr?=
 =?utf-8?Q?5ZjQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <844EFED827FD2D4B8440E05EE3983799@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f476cea4-0d22-4390-ddfc-08de2d00bb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 15:30:30.1832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrsnC9oZMEm41VkO3VChnsnOSLsBsz54I9V2lAOxR0ktculruu5Guer1fWrj0Dgv9UH7DWNqBbzaBX4RjrLtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB3027
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

T24gMjUuMTEuMjUgMTg6MjMsIEJlbmphbWluIEhhaG4gd3JvdGU6DQo+IENoYW5nZSB0aGUgcHJl
ZmVycmVkIGJvb3RkZXZpY2UgZHluYW1pY2FsbHkgYmFzZWQgb24gdGhlIGRldmljZSB0aGUNCj4g
VS1Cb290IGlzIGxvYWRlZCBmcm9tLiBUaGUgc2FtZSB3YXkgaXMgYWxyZWFkeSBpbXBsZW1lbnRl
ZCBmb3INCj4gaW14OG1wLWxpYnJhLWZwc2MgYm9hcmQuIEFsc28gbGV0IHN0YW5kYXJkYm9vdCBz
ZXQgYm9vdGNtZCB2YXJpYWJsZQ0KPiBhdXRvbWF0aWNhbGx5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBCZW5qYW1pbiBIYWhuIDxCLkhhaG5AcGh5dGVjLmRlPg0KPiAtLS0NCj4gICBib2FyZC9waHl0
ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZS1pbXg4bW0uYyAgIHwgMiArKw0KPiAgIGJvYXJkL3Bo
eXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlLWlteDhtcC5jICAgfCA1ICsrKystDQo+ICAgYm9h
cmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVudiB8IDYgLS0tLS0tDQo+
ICAgY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcgICAgICAgICAgICAgICB8IDEgLQ0K
PiAgIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3BoeWNvcmUtaW14OG1t
LmMgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZS1pbXg4bW0uYw0KPiBpbmRl
eCAwNmNmZmJjYTNhNjkuLjdkNTY5ZDQ3NWU2MyAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVj
L3BoeWNvcmVfaW14OG1tL3BoeWNvcmUtaW14OG1tLmMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tL3BoeWNvcmUtaW14OG1tLmMNCj4gQEAgLTQxLDYgKzQxLDggQEAgaW50IGJv
YXJkX2xhdGVfaW5pdCh2b2lkKQ0KPiAgIAlzd2l0Y2ggKGdldF9ib290X2RldmljZSgpKSB7DQo+
ICAgCWNhc2UgU0QyX0JPT1Q6DQo+ICAgCQllbnZfc2V0X3Vsb25nKCJtbWNkZXYiLCAxKTsNCj4g
KwkJaWYgKCFzdHJjbXAoZW52X2dldCgiYm9vdF90YXJnZXRzIiksIGVudl9nZXRfZGVmYXVsdCgi
Ym9vdF90YXJnZXRzIikpKQ0KPiArCQkJZW52X3NldCgiYm9vdF90YXJnZXRzIiwgIm1tYzEgbW1j
MiB1c2IgZXRoZXJuZXQiKTsNCg0KVGhpcyBkb2VzIG5vdCB3b3JrIHdpdGggc2V0dGluZyBib290
X3RhcmdldHMgZm9yIHN0YW5kYXJkYm9vdCBpbiB0aGUgDQpkZXZpY2V0cmVlLCBhcyBpdCB3aWxs
IG5vdCBiZSBzZXQgaW4gdGhlIGRlZmF1bHQgZW52LiBBbHNvIHN0cmNtcCB3aXRoIA0KTlVMTCBu
ZWVkcyB0byBiZSBjb25zaWRlcmVkLg0KDQpJIHdpbGwgc2VuZCBhIHYyLg0KDQpCZW5qYW1pbg0K
DQo+ICAgCQlicmVhazsNCj4gICAJY2FzZSBNTUMzX0JPT1Q6DQo+ICAgCQllbnZfc2V0X3Vsb25n
KCJtbWNkZXYiLCAyKTsNCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDht
cC9waHljb3JlLWlteDhtcC5jIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmUt
aW14OG1wLmMNCj4gaW5kZXggYmYyZDVjZTAxZmE1Li4yNWNmODg5ZDM1N2MgMTAwNjQ0DQo+IC0t
LSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlLWlteDhtcC5jDQo+ICsrKyBi
L2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlLWlteDhtcC5jDQo+IEBAIC03Niwx
MyArNzYsMTYgQEAgaW50IGJvYXJkX2xhdGVfaW5pdCh2b2lkKQ0KPiAgIAlzd2l0Y2ggKGdldF9i
b290X2RldmljZSgpKSB7DQo+ICAgCWNhc2UgU0QyX0JPT1Q6DQo+ICAgCQllbnZfc2V0X3Vsb25n
KCJtbWNkZXYiLCAxKTsNCj4gKwkJaWYgKCFzdHJjbXAoZW52X2dldCgiYm9vdF90YXJnZXRzIiks
IGVudl9nZXRfZGVmYXVsdCgiYm9vdF90YXJnZXRzIikpKQ0KPiArCQkJZW52X3NldCgiYm9vdF90
YXJnZXRzIiwgIm1tYzEgbW1jMiB1c2IgZXRoZXJuZXQiKTsNCj4gICAJCWJyZWFrOw0KPiAgIAlj
YXNlIE1NQzNfQk9PVDoNCj4gICAJCWVudl9zZXRfdWxvbmcoIm1tY2RldiIsIDIpOw0KPiAgIAkJ
YnJlYWs7DQo+ICAgCWNhc2UgVVNCX0JPT1Q6DQo+ICAgCQlwcmludGYoIkRldGVjdCBVU0IgYm9v
dC4gV2lsbCBlbnRlciBmYXN0Ym9vdCBtb2RlIVxuIik7DQo+IC0JCWVudl9zZXRfdWxvbmcoImRv
ZmFzdGJvb3QiLCAxKTsNCj4gKwkJaWYgKCFzdHJjbXAoZW52X2dldCgiYm9vdGNtZCIpLCBlbnZf
Z2V0X2RlZmF1bHQoImJvb3RjbWQiKSkpDQo+ICsJCQllbnZfc2V0KCJib290Y21kIiwgImZhc3Ri
b290IDA7IGJvb3RmbG93IHNjYW4gLWxiOyIpOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6
DQo+ICAgCQlicmVhazsNCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDht
cC9waHljb3JlX2lteDhtcC5lbnYgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29y
ZV9pbXg4bXAuZW52DQo+IGluZGV4IDcwMDQ0OTk3YWRiOC4uMzIzMTk5YjA0MWIxIDEwMDY0NA0K
PiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52DQo+
ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYNCj4g
QEAgLTEsOCArMSwzIEBADQo+IC1ib290Y21kPQ0KPiAtCWlmIHRlc3QgJHtkb2Zhc3Rib290fSA9
IDE7IHRoZW4NCj4gLQkJZmFzdGJvb3QgMDsNCj4gLQlmaTsNCj4gLQlib290ZmxvdyBzY2FuIC1s
YjsNCj4gICAjaWZkZWYgQ09ORklHX0JPT1RNRVRIX1JBVUMNCj4gICBib290bWV0aHM9cmF1YyBz
Y3JpcHQgZWZpDQo+ICAgI2Vsc2UNCj4gQEAgLTEyLDcgKzcsNiBAQCBib290X3RhcmdldHM9bW1j
MiBtbWMxIHVzYiBldGhlcm5ldA0KPiAgIGJvb3RlbnZfYWRkcl9yPTB4NDkxMDAwMDANCj4gICBi
b290X3NjcmlwdF9kaGNwPWJvb3Quc2NyLnVpbWcNCj4gICBjb25zb2xlPXR0eW14YzAsMTE1MjAw
DQo+IC1kb2Zhc3Rib290PTANCj4gICBmYXN0Ym9vdF9yYXdfcGFydGl0aW9uX2FsbD0wIDQxOTQz
MDQNCj4gICBmYXN0Ym9vdF9yYXdfcGFydGl0aW9uX2Jvb3Rsb2FkZXI9NjQgODEyOA0KPiAgIGZk
dF9hZGRyX3I9MHg0ODAwMDAwMA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9waHljb3JlLWlteDht
cF9kZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiBpbmRleCBj
NDk3ZjBiY2Q5MTMuLjJmY2Y3ZGI5ZTVjOCAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9waHljb3Jl
LWlteDhtcF9kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25m
aWcNCj4gQEAgLTM4LDcgKzM4LDYgQEAgQ09ORklHX0JPT1RTVERfRlVMTD15DQo+ICAgQ09ORklH
X09GX0JPQVJEX1NFVFVQPXkNCj4gICBDT05GSUdfT0ZfU1lTVEVNX1NFVFVQPXkNCj4gICBDT05G
SUdfRkRUX0ZJWFVQX1BBUlRJVElPTlM9eQ0KPiAtIyBDT05GSUdfVVNFX0JPT1RDT01NQU5EIGlz
IG5vdCBzZXQNCj4gICBDT05GSUdfREVGQVVMVF9GRFRfRklMRT0ib2Z0cmVlIg0KPiAgIENPTkZJ
R19TWVNfQ0JTSVpFPTIwNDgNCj4gICBDT05GSUdfU1lTX1BCU0laRT0yMDc0DQo+DQoNCg==
