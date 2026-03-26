Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEE10A62C6
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 13:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572FC81E18;
	Thu, 26 Mar 2026 14:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mytelechips.onmicrosoft.com header.i=@mytelechips.onmicrosoft.com header.b="fXr/NE5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A169838BB; Thu, 26 Mar 2026 06:55:40 +0100 (CET)
Received: from SEVP216CU002.outbound.protection.outlook.com
 (mail-koreacentralazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B0780517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 06:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mw.park@telechips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdpAdLhXlK9hjrtxSq6Fp7HFPBC8XJfzlJ8kKjNfE81LXMkfpPlQ3SkZ1wDDmXnkZfVzLGq+Wj6GiCi651OAUQUABLHawLA13PTqBVJpRZ2VBdahx6riRM0kRwEGZqOqMC8gNuNTok/GtHsF0EdwQf+SUmV36X6AG0eUrDnKYWJ0FMehz76Bz4z3Z5epXpJcnBdY7MyP/zRHfFzXs/g6k8s7Iyd62tdXy4fhLJ3r5xM+ljnmmheqKmp5Y/U3+SAfYvVZguVCuVlJsxiWkFznistVpouRLuisCyfhuR2EwYjtTAj6GHb/JFWXINp9+JVD9wAlk9UjIcxo1GhDQkd4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIG7H+EArZjUSlLNmHCslUtQ/tS7iH0Ae4T85Gs1jEs=;
 b=EYQaEi3Pi5FcjQhylv4T9pvfUeb4+Dt2kYV46rodV86BySPPG77cN15Mv4NIzgGz0u38dHKKXZgt9xGQvnQ2Hlk55oKk/wVXPiMU8z3wZWEf9LHhYBPHrOdReGNLuNY615z8SQyLbohy51c6CBd3zH27QW2gRsCUBFt3KZviTfZo4imkMNT23kLqu+kTLAMnz0HUHf9DfxtA8yrXRnUuACpJy7xszvlZJVeXghaY1qK5dFLCBqW72V6J/331s+D9eGAc+rstNpK4VrCYOeuxHgyRkbZNbX9Gs7168kXVd18pkdziPwHfgp1Tm7meQVEvJZCqfGE1q9GAsYYq4JeCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=telechips.com; dmarc=pass action=none
 header.from=telechips.com; dkim=pass header.d=telechips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mytelechips.onmicrosoft.com; s=selector2-mytelechips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIG7H+EArZjUSlLNmHCslUtQ/tS7iH0Ae4T85Gs1jEs=;
 b=fXr/NE5UTm54sfBAOs+wAkWl6L0PBywfu8M1ddAoYO9Lye4JRLTbsu0yZOxoXegiXY4I4YaPOFcaQQdi6KTqbeU35xjLPMMmrvAyBOF6+uwFeStdLCReZwlOSpzLIyMVtO2NqBNGFiTIT6LOBK7TtRFG3iWZtFfUapGOh7ss5LI=
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 SL2P216MB2110.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 05:55:32 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 05:55:32 +0000
From: =?ks_c_5601-1987?B?udq5zr/sIChNVyBQYXJrKQ==?= <mw.park@telechips.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>
Subject: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Topic: [PATCH] mmc: allow forward compatibility for EXT_CSD_REV
Thread-Index: AQHcvOJe6oDidGfESUyiWPsmGz0PRw==
Date: Thu, 26 Mar 2026 05:55:32 +0000
Message-ID: <SLXP216MB114822C04834C4F0A78869A6F056A@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Enabled=True;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SiteId=9ec49ece-9398-4634-9468-0ca88a890702;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SetDate=2026-03-26T05:55:32.011Z;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Name=General;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_ContentBits=1;
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=telechips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|SL2P216MB2110:EE_
x-ms-office365-filtering-correlation-id: fb384008-edcf-4808-71c9-08de8afc4ab6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|6049299003|366016|1800799024|4053099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 4AY7g/ywuAAkjAblOQWBSTykQyOjX5xobHG9li6MhXuVOgRKD0Sj74m4Q893PGlDZj4LiAfokmAxpCXHeIA+LPMHCfK2eILXmqnT9W2k73qInynuN2dj9HAcs4adCUkqexG7cyi6p+Qs62/VhJTN45u90H1s/YwIqKF/eT07H1gxJ6fq37FrSMr61C5QmAPwGqrCMfeEyPm/TWkeKjdDhKHBqPiPdB4v2EDYQpMZvHBhvMpGVBRmh6PDs4duLhdwXkFMLkYg8FUM8/W4JTOAhYF0XFEsM6fg03PfYg98XFuKlPG6dMIvF2SK2kPalFIUeGlKgIyu2reuEoQbfCi2Gd8ajX41xs391NpEbe69Iucnf3UUZot9/5+cuDb3cl6DuCl4HwUwavcOgnzxA4p5NDKrXh3fLT/NsFIxOXKZ0JQiihkB8Gf0JNWzQTu4zrqr9Lyh/gpnQ1MotPjGzievDM33YExXbUpd73HcabLpnzdIhI0sDRCdlRP+cdbOhnAelbNnf7pbjfvid062VfGtOC6JIuZpu+hYkewr/eWH93bKOlYtoofUHisGzjYZKCGxqixig0cSdPOvBAVACC1/Z2xVJ/v743/u1j0/PAP1eOo4kFT+wbBVK6xkLz0nsia6a+EQMFl5uC1HzI/vKcgK466/C4fGT6WGyxQZFs8k6R94iXm5QnBowQuOF1lGPIxhxqw1nqnLyTiegnn0yKOyOU0818I3g0jsJW8oGrNNAJIVpfnah42In2OSz4MC94ykKmYB8/x+qlLkaVHpdH409vM/NfEmqtf3oWXYVcf1Wsg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ko; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(6049299003)(366016)(1800799024)(4053099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?WENsdXdWSWJDdlZkc3F3RVZYM0l1L09iUG9QOTJDZjY1dnIrTHBU?=
 =?ks_c_5601-1987?B?MituYUZjR0tsamlydjNwbm45N1phbkd2Zi9EdWY3bHhxdjFDUjdp?=
 =?ks_c_5601-1987?B?TW0yanE3TEUzS3B0SDdSSmxONHJvdDVGalBjTmxnaFZpa2JWblBC?=
 =?ks_c_5601-1987?B?VHpwZVoxeTBRQ2ovd1Mya1FJSU1OdGltMzg1emZIb0NXS05kWEE4?=
 =?ks_c_5601-1987?B?RGdac0g1bnRDcnk5SnJvbHdPRmZKWHB5clhtZmljcUd5ZUM5cWRa?=
 =?ks_c_5601-1987?B?empDdnA0RkVBT25mZXFwdmdheEFUYWMxSHYvN0p4alpvUlRndWRT?=
 =?ks_c_5601-1987?B?RWg5OU9HczlYaXlWSldlNnNhOURuM29tc1pBV2xNRHJZV1pkR0hz?=
 =?ks_c_5601-1987?B?ait4WDZkbHIvcmFUeG9xUnFnL3lILzFhUUxZNFRmVVpPOVZQVGxC?=
 =?ks_c_5601-1987?B?U0QwdSsvU3doNWRSM2d3dmRKQXhpRHpGZlE4WTNCL29FaFEzSnhE?=
 =?ks_c_5601-1987?B?UHNhZzJhd3JybWNYaVlhTWFJK2hTYlpkUmNnUGh4eG9Fdm5MYy9E?=
 =?ks_c_5601-1987?B?R3RJRTB2NG9HS3c2Si80OXRQZUtYQldUVTltV2JYTXo1YW1PZ1Fu?=
 =?ks_c_5601-1987?B?cTBndWs5WlFRVDBEeEdwT1hheE5XaGlnaEIxVmQ3OXc4NTJWazBB?=
 =?ks_c_5601-1987?B?SU83cWU2ekIwVXBCWDlrV1J2Ukp4MFNnWWxjOHY1SFBKUitNNkRh?=
 =?ks_c_5601-1987?B?emZYZytVZjhCQVlkNTEzTzVkaksxL1JOU0ZOOWVpWEZTMmc1MHVq?=
 =?ks_c_5601-1987?B?RWJkUFNSUm83QUYzQzNieWw3SmRaWk1VUEJOT2ZrRVNZUTExbk1h?=
 =?ks_c_5601-1987?B?ZWpWRUxpQ1d5WGNMbkFBb2M2T1RSVVVvK0svMGpwUnBqd2pxbHN5?=
 =?ks_c_5601-1987?B?L29OckVHSUtkc2V0YnU0Nk9oMWZITWc1U2Qra0pXZElYMHdSODN3?=
 =?ks_c_5601-1987?B?R1dWYUxLZ2JncVVOVk1lV28xZ1Ywak9lbE50VkJhbWpEYm9LeXlH?=
 =?ks_c_5601-1987?B?M2VWd3A4ZXdoMVh0VERPMDkyMGlKWkZvV0pGNXFFRmtyUXVwKzc3?=
 =?ks_c_5601-1987?B?RlBrU08rNUtYOFZOLzVJWlRPRmpIVzRwalJjUXVrM3UrdG03OGI5?=
 =?ks_c_5601-1987?B?ZUVkWUV4UDA5ZmdjQkNINFptSzlkbjkrTUhzN0hoZ1lIeVB4QzFC?=
 =?ks_c_5601-1987?B?QWlNbHhtM0J5UHRSMDhEYVNscU5pSHoxR1JIcEppVmNVQXVsL1gw?=
 =?ks_c_5601-1987?B?Zk0wajIzd21XUlMwWWRyRDB4ZjFSMG9jUmdBZ21GSDJYU2Q4ZEpK?=
 =?ks_c_5601-1987?B?WVRWSU1obWUybW5uR1pFdkgwZHRzVy9ZNnhVQkFMaFhJNGZ3ZWdD?=
 =?ks_c_5601-1987?B?QVFucU5FWUgyVEV6NDJXTVVEbzdvNTBpT1VjbUxGRFhiTlFlWE1F?=
 =?ks_c_5601-1987?B?YUlERnZFck9QNmRFcHlnTXhhTXNpY2VFZ0swY3NhTVczei93SXVw?=
 =?ks_c_5601-1987?B?MGdkVGtCdGpleStMelBpVXFBWmlvQVUrT1FMZUxhT01obXJNK3Zt?=
 =?ks_c_5601-1987?B?eGRtNWczQ0h2NjA0ZHdGMklsNVBMakUySzBtTVorSEx0T1NWbUE5?=
 =?ks_c_5601-1987?B?Nm9tRGx4bGVaekxxaTFuUDNndzhTY29iSWNoZE9DSDVMRWV4cG5t?=
 =?ks_c_5601-1987?B?T2ZYbGJ1eVFFRHpsUWdZTCtnSktzUTc3K0VDS3hzRTFwekxlVVpT?=
 =?ks_c_5601-1987?B?bFlZRnBDUTVPRE9qeE9BeUVwZTkrM1hNQjF4czRGZTkvaUpqVXow?=
 =?ks_c_5601-1987?B?SGx5eDlzMU1LK1Y3QmJmdHdvcStXa09ndVR0UUxhejBKMko1enpz?=
 =?ks_c_5601-1987?B?aWhuZjA4Yytydzl1TWhocDFvbzI3dVlaZW1icHFUVWNmRHVVZ0ls?=
 =?ks_c_5601-1987?B?RUJzZ3ZkZlpGcVoxNVRDL1JMeHJwZVMxOXlYM3hyeHNBdUVLb1Np?=
 =?ks_c_5601-1987?B?UzZlOExBU1o3SjdkYkJ1SXcwclNIT1VhYmtESVd6Yks5c2I0WjVT?=
 =?ks_c_5601-1987?B?eDVvZ0h6d0dRUDVwWGRLNGJzUUk1OHZBNkIvMGo4bUtoWGpYTHZ2?=
 =?ks_c_5601-1987?B?Z1NPams1Q2c5Y1FwZDljNGtCZGNQRVJDcjRwdUhIRHRlVkRVTDZJ?=
 =?ks_c_5601-1987?B?SlBoQ2NpcHFDTnJLS0VsMktJYzFYekxEb3MxOTBGWUc0WDR6dWxQ?=
 =?ks_c_5601-1987?B?QXdIaE9GMXhHeERxWG0vZjN3Mk02NHpQQVVENEs0eTFLWCtxQVl0?=
 =?ks_c_5601-1987?B?THZLbUtWWGhkVTYyS3kzaXVucExJbm1pbjUrZGUvdGhyU0ZpMGg3?=
 =?ks_c_5601-1987?B?UE5YTWZ3dWx1RFZ6RFpkZlZGOVN6WTB5emlRMnYvRnpEdlY3cmIz?=
 =?ks_c_5601-1987?B?TUp5QmsyVHU2TUdrRVMxdFVnUzZ2MVB1ZjFnT3A3cTdtV1gyMGts?=
 =?ks_c_5601-1987?B?VXhsMkxSL3BHamR5YW9WLzJJOVpHaURvdEY5VUMyeFUwMjhWTTNk?=
 =?ks_c_5601-1987?B?cERzelhQWnYrOGVmWlEzNENKTkY1OEZIQ3ZqZEtwaFVUdTlMa1ht?=
 =?ks_c_5601-1987?B?bGVSM3pwbVNPNG9GWnMxYkd5YTQzdXRHYytQTjRCd1MyZz09?=
Content-Type: multipart/mixed;
 boundary="_002_SLXP216MB114822C04834C4F0A78869A6F056ASLXP216MB1148KORP_"
MIME-Version: 1.0
X-OriginatorOrg: telechips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb384008-edcf-4808-71c9-08de8afc4ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 05:55:32.2988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9ec49ece-9398-4634-9468-0ca88a890702
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0mbN7ku1g1QLQLqtRW0Uj3UVdtmvdHhLFFLLUIrRL6C5FYPKGVJjgEGAjvsEEsN/PFQyVjCKMc82v8/YPTzPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2110
X-Mailman-Approved-At: Thu, 26 Mar 2026 14:17:19 +0100
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

--_002_SLXP216MB114822C04834C4F0A78869A6F056ASLXP216MB1148KORP_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

QWNjb3JkaW5nIHRvIHRoZSBKRURFQyBTdGFuZGFyZCwgdGhlIEVYVF9DU0QgZm9ybWF0IGlzIG1l
YW50IHRvIGJlDQpmb3J3YXJkIGNvbXBhdGlibGUuIEFzIGxvbmcgYXMgQ1NEX1NUUlVDVFVSRSBk
b2VzIG5vdCBjaGFuZ2UsIGFsbA0KdmFsdWVzIGZvciBFWFRfQ1NEX1JFViBhcmUgYXV0aG9yaXpl
ZC4NCg0KQ3VycmVudGx5LCBpZiBhbiBlTU1DIGRldmljZSB3aXRoIGEgbmV3ZXIgRVhUX0NTRF9S
RVYgKGUuZy4sIGVNTUMgNS4xQg0Kd2l0aCBFWFRfQ1NEX1JFVj05KSBpcyB1c2VkLCBVLUJvb3Qg
ZmFpbHMgdG8gaW5pdGlhbGl6ZSBpdCBhbmQgcmV0dXJucw0KLUVJTlZBTCBiZWNhdXNlIHRoZSBy
ZXZpc2lvbiBpcyBsYXJnZXIgdGhhbiB0aGUgbW1jX3ZlcnNpb25zIGFycmF5IHNpemUuDQoNCkZp
eCB0aGlzIGJ5IGZhbGxpbmcgYmFjayB0byB0aGUgbGF0ZXN0IHN1cHBvcnRlZCB2ZXJzaW9uIGlm
IHRoZQ0KRVhUX0NTRF9SRVYgZXhjZWVkcyB0aGUga25vd24gdmVyc2lvbnMuIFRoaXMgZW5zdXJl
cyBmb3J3YXJkDQpjb21wYXRpYmlsaXR5IHdpdGggZnV0dXJlIGVNTUMgc3BlY2lmaWNhdGlvbnMu
DQoNClNpZ25lZC1vZmYtYnk6IE1XIFBhcmsgPG13LnBhcmtAdGVsZWNoaXBzLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvbW1jL21tYy5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9tbWMuYyBiL2RyaXZlcnMvbW1jL21tYy5jDQppbmRleCBjNTcwNWY0ZjIxNS4uZGJl
YzcyOGE0NzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9tbWMuYw0KKysrIGIvZHJpdmVycy9t
bWMvbW1jLmMNCkBAIC0yMzM0LDYgKzIzMzQsNyBAQCBzdGF0aWMgaW50IG1tY19zdGFydHVwX3Y0
KHN0cnVjdCBtbWMgKm1tYykNCiAgICAgICAgdTY0IGNhcGFjaXR5Ow0KICAgICAgICBib29sIGhh
c19wYXJ0cyA9IGZhbHNlOw0KICAgICAgICBib29sIHBhcnRfY29tcGxldGVkOw0KKyAgICAgICB1
OCByZXY7DQogICAgICAgIHN0YXRpYyBjb25zdCB1MzIgbW1jX3ZlcnNpb25zW10gPSB7DQogICAg
ICAgICAgICAgICAgTU1DX1ZFUlNJT05fNCwNCiAgICAgICAgICAgICAgICBNTUNfVkVSU0lPTl80
XzEsDQpAQCAtMjM4MCwxMiArMjM4MSwxOSBAQCBzdGF0aWMgaW50IG1tY19zdGFydHVwX3Y0KHN0
cnVjdCBtbWMgKm1tYykNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCiAgICAgICAg
bWVtY3B5KG1tYy0+ZXh0X2NzZCwgZXh0X2NzZCwgTU1DX01BWF9CTE9DS19MRU4pOw0KICNlbmRp
Zg0KLSAgICAgICBpZiAoZXh0X2NzZFtFWFRfQ1NEX1JFVl0gPj0gQVJSQVlfU0laRShtbWNfdmVy
c2lvbnMpKSB7DQotICAgICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsNCi0gICAgICAgICAgICAg
ICBnb3RvIGVycm9yOw0KLSAgICAgICB9DQorICAgICAgIHJldiA9IGV4dF9jc2RbRVhUX0NTRF9S
RVZdOw0KKw0KKyAgICAgICAvKg0KKyAgICAgICAgKiBBY2NvcmRpbmcgdG8gdGhlIEpFREVDIFN0
YW5kYXJkLCB0aGUgRVhUX0NTRCBmb3JtYXQgaXMgbWVhbnQgdG8gYmUNCisgICAgICAgICogZm9y
d2FyZCBjb21wYXRpYmxlLiBBcyBsb25nIGFzIENTRF9TVFJVQ1RVUkUgZG9lcyBub3QgY2hhbmdl
LCBhbGwNCisgICAgICAgICogdmFsdWVzIGZvciBFWFRfQ1NEX1JFViBhcmUgYXV0aG9yaXplZC4N
CisgICAgICAgICogSWYgdGhlIEVYVF9DU0RfUkVWIGV4Y2VlZHMgdGhlIGtub3duIHZlcnNpb25z
LCBmYWxsYmFjayB0byB0aGUNCisgICAgICAgICogbGF0ZXN0IHN1cHBvcnRlZCB2ZXJzaW9uIGlu
c3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVycm9yLg0KKyAgICAgICAgKi8NCisgICAgICAgaWYgKHJl
diA+PSBBUlJBWV9TSVpFKG1tY192ZXJzaW9ucykpDQorICAgICAgICAgICAgICAgcmV2ID0gQVJS
QVlfU0laRShtbWNfdmVyc2lvbnMpIC0gMTsNCg0KLSAgICAgICBtbWMtPnZlcnNpb24gPSBtbWNf
dmVyc2lvbnNbZXh0X2NzZFtFWFRfQ1NEX1JFVl1dOw0KKyAgICAgICBtbWMtPnZlcnNpb24gPSBt
bWNfdmVyc2lvbnNbcmV2XTsNCg0KICAgICAgICBpZiAobW1jLT52ZXJzaW9uID49IE1NQ19WRVJT
SU9OXzRfMikgew0KICAgICAgICAgICAgICAgIC8qDQotLQ0KMi4zNC4xDQpUaGlzIGVtYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgdG8gaXQgbWF5IGJlIGNvbmZpZGVudGlhbCBhbmQgYXJlIGludGVu
ZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0IGlzIGFk
ZHJlc3NlZC4gQW55IHZpZXdzIG9yIG9waW5pb25zIGV4cHJlc3NlZCBhcmUgc29sZWx5IHRob3Nl
IG9mIHRoZSBhdXRob3IgYW5kIGRvIG5vdCBuZWNlc3NhcmlseSByZXByZXNlbnQgdGhvc2Ugb2Yg
VGVsZWNoaXBzIEluYy4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0
aGlzIGVtYWlsLCB5b3UgbXVzdCBuZWl0aGVyIHRha2UgYW55IGFjdGlvbiBiYXNlZCB1cG9uIGl0
cyBjb250ZW50cyBub3IgY29weSBvciBzaG93IGl0IHRvIGFueW9uZS4gUGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGVtYWlsIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRlIHRoaXMgZW1haWwgZnJvbSB5b3VyIHN5c3RlbS4g
UGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlbWFp
bC4NCg==

--_002_SLXP216MB114822C04834C4F0A78869A6F056ASLXP216MB1148KORP_
Content-Type: application/octet-stream;
	name="0001-mmc-allow-forward-compatibility-for-EXT_CSD_REV.patch"
Content-Description:  0001-mmc-allow-forward-compatibility-for-EXT_CSD_REV.patch
Content-Disposition: attachment;
	filename="0001-mmc-allow-forward-compatibility-for-EXT_CSD_REV.patch";
	size=2104; creation-date="Thu, 26 Mar 2026 05:55:15 GMT";
	modification-date="Thu, 26 Mar 2026 05:55:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNzgzZWE1NWNlNWZiODBhOGMyYTY3Y2NlMTUxZWEyMTdiODM1ZjJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNVyBQYXJrIDxtdy5wYXJrQHRlbGVjaGlwcy5jb20+CkRhdGU6
IFRodSwgMjYgTWFyIDIwMjYgMTQ6NDE6MTYgKzA5MDAKU3ViamVjdDogW1BBVENIXSBtbWM6IGFs
bG93IGZvcndhcmQgY29tcGF0aWJpbGl0eSBmb3IgRVhUX0NTRF9SRVYKCkFjY29yZGluZyB0byB0
aGUgSkVERUMgU3RhbmRhcmQsIHRoZSBFWFRfQ1NEIGZvcm1hdCBpcyBtZWFudCB0byBiZQpmb3J3
YXJkIGNvbXBhdGlibGUuIEFzIGxvbmcgYXMgQ1NEX1NUUlVDVFVSRSBkb2VzIG5vdCBjaGFuZ2Us
IGFsbAp2YWx1ZXMgZm9yIEVYVF9DU0RfUkVWIGFyZSBhdXRob3JpemVkLgoKQ3VycmVudGx5LCBp
ZiBhbiBlTU1DIGRldmljZSB3aXRoIGEgbmV3ZXIgRVhUX0NTRF9SRVYgKGUuZy4sIGVNTUMgNS4x
Qgp3aXRoIEVYVF9DU0RfUkVWPTkpIGlzIHVzZWQsIFUtQm9vdCBmYWlscyB0byBpbml0aWFsaXpl
IGl0IGFuZCByZXR1cm5zCi1FSU5WQUwgYmVjYXVzZSB0aGUgcmV2aXNpb24gaXMgbGFyZ2VyIHRo
YW4gdGhlIG1tY192ZXJzaW9ucyBhcnJheSBzaXplLgoKRml4IHRoaXMgYnkgZmFsbGluZyBiYWNr
IHRvIHRoZSBsYXRlc3Qgc3VwcG9ydGVkIHZlcnNpb24gaWYgdGhlCkVYVF9DU0RfUkVWIGV4Y2Vl
ZHMgdGhlIGtub3duIHZlcnNpb25zLiBUaGlzIGVuc3VyZXMgZm9yd2FyZApjb21wYXRpYmlsaXR5
IHdpdGggZnV0dXJlIGVNTUMgc3BlY2lmaWNhdGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBNVyBQYXJr
IDxtdy5wYXJrQHRlbGVjaGlwcy5jb20+Ci0tLQogZHJpdmVycy9tbWMvbW1jLmMgfCAxOCArKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL21tYy5jIGIvZHJpdmVycy9tbWMvbW1j
LmMKaW5kZXggYzU3MDVmNGYyMTUuLjQ5N2FkMTcyYTNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21t
Yy9tbWMuYworKysgYi9kcml2ZXJzL21tYy9tbWMuYwpAQCAtMjMzNCw2ICsyMzM0LDcgQEAgc3Rh
dGljIGludCBtbWNfc3RhcnR1cF92NChzdHJ1Y3QgbW1jICptbWMpCiAJdTY0IGNhcGFjaXR5Owog
CWJvb2wgaGFzX3BhcnRzID0gZmFsc2U7CiAJYm9vbCBwYXJ0X2NvbXBsZXRlZDsKKwl1OCByZXY7
CiAJc3RhdGljIGNvbnN0IHUzMiBtbWNfdmVyc2lvbnNbXSA9IHsKIAkJTU1DX1ZFUlNJT05fNCwK
IAkJTU1DX1ZFUlNJT05fNF8xLApAQCAtMjM4MCwxMiArMjM4MSwxOSBAQCBzdGF0aWMgaW50IG1t
Y19zdGFydHVwX3Y0KHN0cnVjdCBtbWMgKm1tYykKIAkJcmV0dXJuIC1FTk9NRU07CiAJbWVtY3B5
KG1tYy0+ZXh0X2NzZCwgZXh0X2NzZCwgTU1DX01BWF9CTE9DS19MRU4pOwogI2VuZGlmCi0JaWYg
KGV4dF9jc2RbRVhUX0NTRF9SRVZdID49IEFSUkFZX1NJWkUobW1jX3ZlcnNpb25zKSkgewotCQll
cnIgPSAtRUlOVkFMOwotCQlnb3RvIGVycm9yOwotCX0KKwlyZXYgPSBleHRfY3NkW0VYVF9DU0Rf
UkVWXTsKKworCS8qCisJICogQWNjb3JkaW5nIHRvIHRoZSBKRURFQyBTdGFuZGFyZCwgdGhlIEVY
VF9DU0QgZm9ybWF0IGlzIG1lYW50IHRvIGJlCisJICogZm9yd2FyZCBjb21wYXRpYmxlLiBBcyBs
b25nIGFzIENTRF9TVFJVQ1RVUkUgZG9lcyBub3QgY2hhbmdlLCBhbGwKKwkgKiB2YWx1ZXMgZm9y
IEVYVF9DU0RfUkVWIGFyZSBhdXRob3JpemVkLgorCSAqIElmIHRoZSBFWFRfQ1NEX1JFViBleGNl
ZWRzIHRoZSBrbm93biB2ZXJzaW9ucywgZmFsbGJhY2sgdG8gdGhlCisJICogbGF0ZXN0IHN1cHBv
cnRlZCB2ZXJzaW9uIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVycm9yLgorCSAqLworCWlmIChy
ZXYgPj0gQVJSQVlfU0laRShtbWNfdmVyc2lvbnMpKQorCQlyZXYgPSBBUlJBWV9TSVpFKG1tY192
ZXJzaW9ucykgLSAxOwogCi0JbW1jLT52ZXJzaW9uID0gbW1jX3ZlcnNpb25zW2V4dF9jc2RbRVhU
X0NTRF9SRVZdXTsKKwltbWMtPnZlcnNpb24gPSBtbWNfdmVyc2lvbnNbcmV2XTsKIAogCWlmICht
bWMtPnZlcnNpb24gPj0gTU1DX1ZFUlNJT05fNF8yKSB7CiAJCS8qCi0tIAoyLjI1LjEKCg==

--_002_SLXP216MB114822C04834C4F0A78869A6F056ASLXP216MB1148KORP_--
