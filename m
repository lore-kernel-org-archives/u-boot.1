Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCBCC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560C4883D3;
	Tue, 28 May 2024 13:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lJPEYFIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A4588470; Tue, 28 May 2024 13:04:31 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB9A883D3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmDuYAP0t2B8UUjlFdrsy3bq7scar8N61PxWIUfjuuFBeHMtsXuSDBNt4xxMqAp0trTdCCrPi+nrmYvwBOTXXzc9sxwOmSLERfOtJLka3P4U8FpRL7FvtlnsHid+UH4L5+JffBu3TeJzPktWpZzUaJRdz5Rd3OvmA8ES+3aP4ycDPUnWYI2XFzTSMUhHEHHyjXnYkxCdEXfWmOXRVvO+UvlbNOYmipB+OSPcp9WNwyjKQmJXmyC+nh/f76xH3Imvta4fQ31QA/YHNDbD35vM42Po9tOue1OWusLfefboymXbkFucMuNGTWWFNmVUGQJz9xSI+b2expVuDOoVx/Hq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1Km1HHPYutaq6LcTgaLBvyewzSHKFdNvrfe/I8F6/M=;
 b=B+OWNRIs1lbqlIB0GuNrx5u+Mtl3mEjcBdWAA+HGw8D3Tw2EU0z45Y5YsmJtIj3zQWo7DXYKjsFSZVcJfedtUcXTrN8YGupk/qhPFD/gdQhRGMEPEoV4pJ7lKYZR8xigdJBXTX4G5Uw/StOTzO9PwVjJ5vdB4BSFkrzRLwBhKy9mcvmyq+b1Vvc5dRobylE3IATE9hvbstLh3pHPGCVhVBvVfTDSA4vuuxA53NpeOkxSVTT6X4lsK/hP9uCV4rcvC71gXBFfxgBnti5OwL2LKavwp92UMusOITIbcieZoRl/vjA48ZkMFT/EyQ1SYbu9RMKUuFhfioTmQnTjM7WsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1Km1HHPYutaq6LcTgaLBvyewzSHKFdNvrfe/I8F6/M=;
 b=lJPEYFIgQZGo2nJi2ymfcWWmAWm0q9JZezGdLQKaG0YCshoSFjpf30pWG7j8QpkYcNP6WWUwD1PIC7VqlLpu5RQ6CnAvhLdoNNTwcygN80Tlj2X7JTxcj3HVjHSCtClXiiorqv6KMYyZkG3LobTJiOd5vGdwvX5xYlcaDN/9T7I=
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 11:04:27 +0000
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f]) by AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:04:27 +0000
From: Elena Popa <elena.popa@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: RE: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Topic: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Index: AdqwWVW3P9w5ugCBRoKUpk8i6qFE+AADGHsAABx7kSA=
Date: Tue, 28 May 2024 11:04:27 +0000
Message-ID: <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
In-Reply-To: <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6968:EE_|DB9PR04MB8169:EE_
x-ms-office365-filtering-correlation-id: fed47b75-acdd-439b-68d6-08dc7f05f11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?S3ZhZW9wOEtkYnZ6VGQySDdySStZbit0ZkhUbjVjaUNGSWJCNyt3S1RJM2Zv?=
 =?utf-8?B?dEhNYVhpTTRkOUZScHR0Q2R3NjFCYzJ1UGE1VTUrc0N1UHpSL0Z0VXM1cGlH?=
 =?utf-8?B?d2N4SGFTbWxyL2t6Ni9jZWhNNEMxTVJ1NE43UTBsNXpIenZ2M2Z6dWt2RHZC?=
 =?utf-8?B?ME45SnhoQnRBd2pmaUZCL084eVlyQ0p2elpzV2x3MGx2ZzYwa09ac0hNZVVJ?=
 =?utf-8?B?Lzgya2UrbWhEUnJad0lxa0grOFZjMjFGbjhsS3pBMkM5QloxNzNQT2kzS3Qw?=
 =?utf-8?B?RnRlY2tSdlJNNk8vZE43TUxnTk8zUExvUnRLQ1RScmt0VUU5UTJlOGVOYWZE?=
 =?utf-8?B?eDN6ejFJWDY2KzBnZ0g5MlFWM01ySmdMakcrVkN3cXBxMDNSS1Bma2M1bEdL?=
 =?utf-8?B?MTkvNlh1MnVqVURabHRnL2xzU3lucmo3Lyt2ZkVGcEdFTUpHUlNHL3RUVlg4?=
 =?utf-8?B?WjM1eFNwTkNreWp6Yys3cGFBZVcrZzJhS0JHQm1ydzJoZHNma25sekEwdmVG?=
 =?utf-8?B?UWZudjRVRE53c1FndE9kMlN6aGZhOHlzS2ExN0k5SVd5TmxJdVQ0UmxFTzJY?=
 =?utf-8?B?Y2dvZzlYZW4xTFlmU0IvV0hCWi9YMUc0Ry92QmlMUk1VdFJEK3AzQVdsRmxF?=
 =?utf-8?B?WmdKa1RFakRlS2djU1ZVenR0VGhwbzBhQzMySDlFSHdKdFBKTlp2eW03d1V6?=
 =?utf-8?B?OXBVZEtLSHlLVTRTZjlYejBtSFRVT0JOL25wOWQwejdGR3RrTFJFQmJLRWZX?=
 =?utf-8?B?WEJQQzh3Mm1OQm1nUFRFYkNaSU9remx5WjRhS2ppc0pIOHlUSUpHdTBibHFi?=
 =?utf-8?B?T3JPVTIrVC84eW4yanhEZEFvR2hzMElkWWthR24yWVpiV0FwWGllTHZCUERl?=
 =?utf-8?B?bkNqaDFHVDJhVDIycHhGWkh1UG5QZVNKN0g2WlJDRjl4akZwZWF0ZVJTQjZl?=
 =?utf-8?B?UXRMSXlvSm02WGl6cU9WbG02L1hCczVhL2t6TzZncDBEcWtzRW00RmtYeitQ?=
 =?utf-8?B?MDhoYlEvZGQwR2FXVGNLWUlLNkFTOTlqL2s5bXQvcFhFWm5kZ2JheGNSQTM3?=
 =?utf-8?B?UWZSZEJxWVViblBtRnlWNlM0SVY3Mnk0ZG1nc1RDYk9qcUVjRE1admp0dmRJ?=
 =?utf-8?B?QUdMbGZxUkV2S3hYd2JyR3VCTG5RTjlYMDA2TUZWdmx0RzBzR1ZLVnhZSEZ6?=
 =?utf-8?B?R1lXNUhUWE1qRlQ5eHErem55dWJLUk1KbmhsaTcxUVRFS3Z1N3RuT2xxYzNn?=
 =?utf-8?B?QXFUNFQvbk9odDI4TThLRHpncEJ1Z1VsZ2xuR1NPdGZYaGFwTFhRNzh5RW5j?=
 =?utf-8?B?elRHUHpsSkt2NDFGdzduZFBVMVkyQk1GSis1TWJ6Yk5USHAzS3Nrc0p6aVZX?=
 =?utf-8?B?aEh2NVNEQW5CNDVmQUVmMnNQZE5neCtVZlZ4RUxSQVpEWStpOFFuOVlGOGNC?=
 =?utf-8?B?WTc2eCsvcCtKTUwyUk9ST1dCUFZYNzJMajBBYnJmYld3bUR5UUJoZFRVdHdm?=
 =?utf-8?B?R0NuSTZna0Q3TVhCQjRMODROL3FKM3FEUWJhVml0c3dheW9lNzRyaWxYTDdH?=
 =?utf-8?B?MWF4UkdkWlYvRGcyVHRGMTJGc0JHVXhCT0dQbTF1Ykp6TCtHWHNMVGdxSm43?=
 =?utf-8?B?ay9YWlZZc1pRbjNvMjN0NFlRMVoxb0tmTTJPOS9tYnlCRjNxb0J3a05sS1hz?=
 =?utf-8?B?SXE0c3VrWVA5QXNxQzRqZk02dlZsUmFCOFFQZlBrVkdDbkVRNDZjb2p2UUZW?=
 =?utf-8?B?d3lIc1dQS2FsZEJYZ2ZlbW56cG5SMHpGeGIxZUVzY3QwSElwSVB1TXQ4VytW?=
 =?utf-8?B?M1hjK25HRmcwcU5scXQ4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6968.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bndCU3liNC9ROE1hVWkxK2x3OENCMG4ybHd5U1NDREUxZkNBeHhtM1N2dlEy?=
 =?utf-8?B?Uk1NWXhLaEx2eHAzWEtRWVBUQmhpR2VOR3RUOE0wakQwSUI1L0kxNHQrKzBZ?=
 =?utf-8?B?VlBJbE9YOHNkbW9wVU1zanJTSnF1U2tOdnNDZ0ZpTVlqZE96bEw1QW5PVk9a?=
 =?utf-8?B?Mzg5d1dOWDQwSHlDcDM2OWdNeUhrY0xsL1F3WFdHZGxadFNOelpLL0wzb3E0?=
 =?utf-8?B?S1FlM2RSKzRVd055VWt5eEExdXg0Ri9td0F3ODYvVkRzdURnVDBKWloreEha?=
 =?utf-8?B?WmdMSDhvbHczaGl5VW9meWVBQ29hTWxLRHc0d1YvYmJnSDRVT2xqMG5hbHNT?=
 =?utf-8?B?STlhZGU3akNzQUZWZzBLd3JObEZraTBIRVRCbkxqSFd1SDNnaDl5UW04Zm5l?=
 =?utf-8?B?WkZmdlhrUEEyblk1dzZHc2x0UlBPcmtKQmpEMjZVOGhrZGVXL1lwK2NkQXFU?=
 =?utf-8?B?S2xkR1AvTnMyRmJHdHhqNk9VUnpLbWdKRjBaWTlDdjhGUE9BQXVKdzArT0ZY?=
 =?utf-8?B?MG5SQ0NGcDJaUys2aGpBWndURXdYNm84VXI4ZVc1NU5nWENscDExM1Z3UnM3?=
 =?utf-8?B?MEt2NmljdUNMSHV6ZmNNSkxnbWhpY1hMbm1qbkJycHlXaW9SRUJEK1dlTTV3?=
 =?utf-8?B?MytlaVMyUk54cExCajcxd1hJRmgrZEMyUGJJMldlMFQ5U25sVlpYZ2Jkdlhh?=
 =?utf-8?B?QzRtWHRob2xXNytPZ09Ja3hPWEcveDRJQi9kM0VnQkFrUlJvMk9ZV3I5enpv?=
 =?utf-8?B?akh4MUt6aW9FcFA5T0Rvd0lwbG9EN1M5ck5sNGpEYTcydHQ1bzZITWE3Nkdy?=
 =?utf-8?B?NWY3b1hleXVwblhCM1IvU1ptTXNtbFE3NHBOaW8xYndYN2dxVUwxeFBvNlU4?=
 =?utf-8?B?bjJNTXR6MmZ2RmNkeUQyVUQ5Uk96dVFDZ2h3TWR6WW1kaFVwRGV2cHVvSTRT?=
 =?utf-8?B?WGxJd2o4Qk9LbWNNV3dhRzFTWDd2SUh3REpBL3EyRnowMFM5eWxOMGNOQlNt?=
 =?utf-8?B?aGdIcFl4SGVkZ1IrYmJRRTYxbGRwYzhuUzRvMFlxL3QvdWNzUTE1dVNybGpE?=
 =?utf-8?B?SzVIMnE3b0tjcVg1ckVGZkQvems4aTQ0ZXFkRWxKS0cyYXZtY1VsTjN4SGk0?=
 =?utf-8?B?Rm83NDVkSE5BeFlPYmNEYlY5aFBUT05IV0Zta1NXYXFNUFR6Nk5VcUk2SnJG?=
 =?utf-8?B?R0FlMXJzVjFWb29SYzZNN1haelBqK2xVWTE0WTlCY2dtQWlzd0tMQW11eDBW?=
 =?utf-8?B?VXh4K0xqMjBMRmk0djlGTEFwY2JNQ21idkowSmpGTUdsTHo1L3huamJ5S1R0?=
 =?utf-8?B?K1pYcCtmMFVlemlJNmpnRGtHcVBKUyt1Qjg0WXQ0Ti8yanp3NW13dEFCMVk4?=
 =?utf-8?B?NE5na2d1ZXBGM1JEcHN5T1BCc2JWT3UxaUM3UWtzbHVQRjVPQkxoR3pMak5s?=
 =?utf-8?B?QnM0MFBPVTgvcVBza0dVYXJENVI4WGw4cE1XRGxic2dOdDVTbDRtdngxbm5B?=
 =?utf-8?B?TTM4d0tCNjlZOGRZM3E3TDliSFBwU2x3QzUzaEdaOElEbTBkdVJnZTZGTzFh?=
 =?utf-8?B?U0ZvRHBsNEVwSVFOV2R5WFZFSHdGWEQrcnN0TlhZaXB4ZmFGWjFRRGEvSGlV?=
 =?utf-8?B?cU1hd2x5c2RHc0lYQ21WZCtzVHhGUGFmK2JVdEFYQlpxclo0VHdBRG5rMEQ4?=
 =?utf-8?B?WHpZSEJ4bk9GTDFkVVRoQWZRR0FiQ2pZbUV6WFRGS0J5Vkw0M0NweFJjRnZn?=
 =?utf-8?B?WmZXdVNmYm9oa3hLdStkcTYzWUNPdnVXUjJnei9SSUdRMjF0ZzlrcXFXZUc5?=
 =?utf-8?B?elZGclkxaEdRWFlmRVo5VkhhaHVxbmVRUk5jR2tLQ0ZCZm13WEszd2kvRWVs?=
 =?utf-8?B?WnhxZGsxYmd4T09nRmNuTzA5QmpMN1NRdE43Z055TzdzSHZPTS9LZnYxUnNj?=
 =?utf-8?B?RVlyZUo3b3lwaDAwUkpsZUF2RVF0Yk84NTJmTEh6MkczMmc0bk9hYUVPU3NW?=
 =?utf-8?B?ZUVmM2tsK1JEZHZDVGRKUkVGY1ZIbG5ZZ3RtZmJmdEVveVplU1QrM0NnT1hE?=
 =?utf-8?B?ZS91VnAwdW5WOFQxMi9uUEFDeDZsVnIwYTdjY3N4WnFuY2NLTldFb0VRVnZU?=
 =?utf-8?Q?T4eyqOSdI5Jib4dzi7wRCJRr1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6968.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed47b75-acdd-439b-68d6-08dc7f05f11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 11:04:27.5893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNpfr80hTOMG5Krq6aqejiKUR/qEqP90FiKMmWE6OOIzzlHIo7VXrA7OmJUYMOL24LGsrJd+E7hQDyHfa0036g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169
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

PiA+IFdlJ3ZlIG5vdGljZWQgdGhhdCwgYXQgbGVhc3QsIG9uIHRoZSBpLk1YOE0qIHBsYXRmb3Jt
cw0KPiANCj4gV2hpY2ggZXhhY3QgcGxhdGZvcm1zLCB3aGljaCBTb0MsIHdoaWNoIGJvYXJkID8N
Cg0KQ3VycmVudGx5IEknbSB0ZXN0aW5nIG9uIHRoZSBpLk1YOE0gUGx1cyBFVksuIA0KPiANCj4g
PiAsIHNvbWUgVVNCIGRldmljZXMgKGVzcGVjaWFsbHkgVVNCMi4wIHN0aWNrcykgZmFpbA0KPiAN
Cj4gV2hpY2ggZXhhY3Qgc3RpY2tzID8gVVNCIElEcyBhbmQgbW9kZWwgd291bGQgYmUgaGVscGZ1
bC4NCg0KVGhlIHN0aWNrIGlzIGZyb20gRUJWIEdlbmVyaWMgRmxhc2ggRGlzaywgVklEOiAweDA1
OGYgUElEOiAweDYzODcNCj4gDQo+IFdoaWNoIFUtQm9vdCB2ZXJzaW9uIGlzIHRoaXMgPw0KDQpU
aGUgMiBlcnJvcnMgSSBhbHJlYWR5IGxpc3RlZCBhcHBlYXJzIHVzaW5nIHRoZSBVLUJvb3QgdjIw
MjMuMDQuIA0KDQpOb3cgSSBhbHNvIHRlc3RlZCBvbiB0aGUgdjIwMjQuMDQuIFRoZXNlIGFyZSB0
aGUgMyBiZWhhdmlvcnM6DQotIFVTQiBkZXZpY2UgZmFpbHMgdG8gaW5pdCB3aXRoIHRoZSBlcnJv
cjogIkRldmljZSBub3QgcmVzcG9uZGluZyB0byBzZXQgYWRkcmVzcyIgDQotIFVTQiBkZXZpY2Ug
ZmFpbHMgdG8gaW5pdCB3aXRoIHRoZSBlcnJvcjogIkNhbm5vdCByZWFkIGNvbmZpZ3VyYXRpb24s
IHNraXBwaW5nIGRldmljZSAwNThmOjYzODciDQotIFVTQiBkZXZpY2Ugc3VjY2VlZGVkIHRvIGlu
aXQgd2l0aCB0aGUgZm9sbG93aW5nIG91dHB1dDoNCnNjYW5uaW5nIGJ1cyB1c2JAMzgyMDAwMDAg
Zm9yIGRldmljZXMuLi4gV0FSTiBlbmRwb2ludCBpcyBoYWx0ZWQNCldBUk4gZW5kcG9pbnQgaXMg
aGFsdGVkDQpXQVJOIGVuZHBvaW50IGlzIGhhbHRlZA0KV0FSTiBlbmRwb2ludCBpcyBoYWx0ZWQN
CldBUk4gZW5kcG9pbnQgaXMgaGFsdGVkDQpXQVJOIGVuZHBvaW50IGlzIGhhbHRlZA0KV0FSTiBl
bmRwb2ludCBpcyBoYWx0ZWQNCldBUk4gZW5kcG9pbnQgaXMgaGFsdGVkDQpXQVJOIGVuZHBvaW50
IGlzIGhhbHRlZA0KV0FSTiBlbmRwb2ludCBpcyBoYWx0ZWQNCldBUk4gZW5kcG9pbnQgaXMgaGFs
dGVkDQpXQVJOIGVuZHBvaW50IGlzIGhhbHRlZA0KV0FSTiBlbmRwb2ludCBpcyBoYWx0ZWQNCldB
Uk4gZW5kcG9pbnQgaXMgaGFsdGVkDQpXQVJOIGVuZHBvaW50IGlzIGhhbHRlZA0KV0FSTiBlbmRw
b2ludCBpcyBoYWx0ZWQNCldBUk4gZW5kcG9pbnQgaXMgaGFsdGVkDQpXQVJOIGVuZHBvaW50IGlz
IGhhbHRlZA0KMiBVU0IgRGV2aWNlKHMpIGZvdW5kDQogICAgICAgc2Nhbm5pbmcgdXNiIGZvciBz
dG9yYWdlIGRldmljZXMuLi4gMSBTdG9yYWdlIERldmljZShzKSBmb3VuZA0KDQpUaGUgc3VjY2Vl
ZGVkIGluaXRpYWxpemF0aW9uIGlzIHZlcnkgcmFuZG9tLiBTb21ldGltZXMgaXQgd29ya3MsIHNv
bWV0aW1lcyBub3QuDQoNCkxvb2tpbmcgYXQgdGhlIGNvbW1pdHMsIEkgc2F3IHNvbWUgaW1wcm92
ZW1lbnRzIGluIHRoZSB4SENJIGRyaXZlciwgYnV0IHN0aWxsLCB0aGlzIGlzc3VlIHJlbWFpbnMu
DQoNCkkgYWxzbyB0cmllZCB0aGUgcXVpY2sgZml4IG9mIGFkZGluZyB0aGUgNW1zIGRlbGF5IGZv
ciB2MjAyNC4wNCwgYW5kIGl0J3Mgd29ya2luZzogdGhlIFVTQiBkZXZpY2Ugc3VjY2VlZGVkIHRv
IGluaXRpYWxpemUgZXZlcnkgdGltZS4NCg0KVGhhbmtzLA0KRWxlbmENCg==
