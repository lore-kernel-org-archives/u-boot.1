Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF3FF94CC1
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 03:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D51383936;
	Wed, 22 Apr 2026 05:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eNCcOz5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5A483AC5; Wed, 22 Apr 2026 05:38:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C2B98352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9Up+U9Vo1Emz85zx9zHLeY5XDP07wYJsRLm1312liNb+NiWH+05nqYVGj7l3OhEUtVD7gwlWjzxXPpk2EZE2KCcrw+qoNwpFw6Fu5uqqJ2dLJJ8V75NpdwgBCF2yhogqyGCs/SXLaLA1s2BAC2xYGCmR0KMB8/wTr0rjt58hIIKO3gfkLu1JWtM3lg4HjmWG8KTyyeul/y5mFI4EnsNNeoquhXoahecPZeEVgULUKE4SXO4ydNt7YJJym1IryMrN5xkutdmCBUbOtGLZobFCL6Bdpcr1WAWQaW0cf+s0FAzZQyFJeyaFaQuLqyVM3q1H83O1J5beKNuKEdklaSIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWM3GZo3zYaKEEKg0Ykc5/hgRjPjvAxAdkHf3HVMuF8=;
 b=hIUafZ6bNTA+hjRXQbH8ks09tg0QaFqmWA29ubiw1LxUgvxLc5hnlYc+m6/LLB34XeqXkIMN98MpHuYe3U0LiqfQrfeO/P8307FjGLiStXY3g5xLHPa2bdoY2Rjp2QzNy/Boo64sm3+NMjx9mWwojMVmLdNQeQ0wRwZa7vTimZhtkVAhGjvopfoccT8Vd+dE0AaQYqfnqyN8Oyqru7gPnT+7Q9J1FLsNAEC6YoxxiLhlaAeM8zEKboRn7lq8EHE4QZAopMbhOtO3SoQJ3/pCWZWLv4nOzTeuauV6O59VNeEjOsbtbF2mijzWW5jgfX7CPgg0+6TebcfxKiDPVSguzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWM3GZo3zYaKEEKg0Ykc5/hgRjPjvAxAdkHf3HVMuF8=;
 b=eNCcOz5TzcWjK56+paagCy06ues9BJTOGpCzzK5CwndH7mHht/jtVuJXkaROmeaYysAD6IwsGcaG9rS2k8/1GY5yXtj8lDhaRROxskNA/TG1s3X/KKxh4CDPdfXGMiThY0eOaQR+1+QlphX8VsyTbSPAVzMY7De0RmnjOjRNlhgacOJQHMu4wPPevgZMgd9fBJc667OvgwXCKj+fkTZ4lzJTIkj5P2LxTvJOXHmVMGFSToU068sJADRE1vTMJA2pqXTbl+DroqjtH//Z5YA7CJ9Zrzk0Uy58MxaFs0BumeB9ewY+P3r8nSRvhQAY9+SDdrkbXbVEtV6AtMQtatnOmQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10313.eurprd04.prod.outlook.com (2603:10a6:10:56a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Wed, 22 Apr
 2026 03:38:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Wed, 22 Apr 2026
 03:38:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Ye Li <ye.li@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Michael Walle
 <mwalle@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Heiko Thiery
 <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>,
 =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?= <thomas.schaefer@kontron.com>, Christian
 Marangi <ansuelsmth@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Robert Marko <robert.marko@sartura.hr>, Yao
 Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Jacky Bai <ping.bai@nxp.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8yXSBuZXQ6IGZzbF9lbmV0YzogQWRkIHN1?=
 =?utf-8?Q?pport_for_i.MX952?=
Thread-Topic: [PATCH v2 2/2] net: fsl_enetc: Add support for i.MX952
Thread-Index: AQHcyx1x3X23GUBUVkOaw41+0XCR97XplKeAgADoKBA=
Date: Wed, 22 Apr 2026 03:38:47 +0000
Message-ID: <PAXPR04MB96441D8450200E87417100DAE22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
 <20260413-netc-v1-2-8670e5ce2d49@nxp.com>
 <aeeABQnCvsEFAgY6@nxa18884-linux.ap.freescale.net>
In-Reply-To: <aeeABQnCvsEFAgY6@nxa18884-linux.ap.freescale.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU4PR04MB10313:EE_
x-ms-office365-filtering-correlation-id: 68b75466-91d0-490c-0743-08dea020a997
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: GxH1Fhna4Nmp2i3w9avtGuDxuZ0tQwdA49aXLdpPCfkn8HRwZGPZpoVTktra3Z/MO8pEsPbAdOzfgdZX+NuFABmPM54nmhyxq8vGnIJ9RenhkSDOkb+EzvlGJr4n5zMSn1RLYyKwDci3yIo6dPa+92sed/S5arX3NJlCCGhn8NxW3mXXdhkt3V035JUJ91G4DdFqLKXtttzOBAttF0Z5wZAO9DklSukyuCFdHbie2cuMIRXuF1agOK9DmiY7bmR+g0TJM3phP5tC5NnPCxqM/KgIZMIn3MpSJlgTUiDEKchzRbJWjBc6DxwtsUC057f60KjJukn1Ki6wUK7fLaVWHb+2qtEqk1Ovyx5dmli52dGLpgwWuZD4AyTCxvnh4sJcXnH/LP+xC7UasbluYdH6vgBx25fmxJi1D3QsVkeIBOVOOWJm9nprrixb8PTD+cHVHrI0FxPTUp8oDfZPsxHCItBuAZM0RmhUPdLHT6+75NTYgjEiAC5Nx2ZB46VHJcjHQZMxpBlCH8cMlMmCoePU9JPa1p+jmFjctL/eZp4qNymLxf5ePAbeP+Qqr686fAN4HjnsfHdDrAG8ZUpcRdw8uGti2sPfm0RZPPZ1iEu28lGfei+ul3LxNs9y60E5hW2wDLjAx3AKzse36Ljgvyg7z0zxZ03KPuplRw3F0FH21Rf+ZNOZExh6i43JIdoGl31aA7JnuM8lROjnmI/ZBcGqySPUFFPMSReOOpYllj8KKANY9zX91syfuL0SnKPWvz65aTvMWHqaE4Mc8xGsg7yyFqoMRbEQaqN56yPR8gkRXgE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVdJaTNxZEg4L2xEcjJOb3pzZVhqd2llUStmeVRhb1YvYUZKbEdBdVd1WXpl?=
 =?utf-8?B?Mks2UlpSaW9ic28ya2hPUG9pa3JhL2hSQmZmaFRkaVVrMEE1R21PRWNQMC9z?=
 =?utf-8?B?SS9BbXh1WUhVeU5ERFhEYklGcFFhN1A4dU1GYk8rM0Jjb2FFeU9PTjNIYSsw?=
 =?utf-8?B?YVRqLzh5K29NdnQwcGo0TENvMmh1YUwwZFVoZTlCVEJxNVBxSVNuci9ReHVC?=
 =?utf-8?B?elZ4K05PRWRnaFo0YTlmRUQzWE1CaUpEK2hpdDMxWTlBOEpZODNBNFkxei9u?=
 =?utf-8?B?a2pvZlZqTXZNU2xoNjkyaUZrZnhOTzQvdGpCY1p0SEh0TTk2UjRkY0ErK1kv?=
 =?utf-8?B?bXgyMlMvWG9yYytQRjE5V0lhSzJ6MGVGZndMa0NHOG1pVDFhTUhubFhJVFdP?=
 =?utf-8?B?c3ZHdGZWTFRCNDJROVhRSHJsWTBjRGpXOWJ3c3pYN2d0SmlwSUpIZzh3bDVD?=
 =?utf-8?B?aldON05CV2pvQ3B3OHBxWUl1R3FtV3J4SWVOZmZaQlhKbERKOTk0ZDl0QmNO?=
 =?utf-8?B?ZkFvT09ZbHJYWmtoSWJtTElycE1Qb1FLVEdsdmFyVFlWSGVMNEI5YXk3YUhM?=
 =?utf-8?B?WkI1Z21qdWNpUncrWXhZZHdjWG5zL3VmWVlJZDYzNUltNGVXMkpoOEpvUVNX?=
 =?utf-8?B?MEdCb1IxVytpWlJCV0c3eFk4QU9wSmswREpVT3kycEx6a1hkY1YraDZ0V3ZB?=
 =?utf-8?B?MllFQnFlRVp3SnMveW8zL09QZHh2QVhYM2FzRmdkODRqSnBBYUR1OGpYVDlx?=
 =?utf-8?B?UzZMNzkxNjFzazlRbGQ4blBXRzlSeFdHRnh4SDVTZ0hLVFU1QVhBZHJIa3J5?=
 =?utf-8?B?N1MxRXh4WjVkZzBSRTcyT29LL1hqbThoQTcxcTkvNUxjYkM3a3czUGFTRDJz?=
 =?utf-8?B?N3UyVm1IdkowdDZHclRmSjJoNE1WTmFZcU1UcTRLYU02TGNWWEY0VUNqMHZy?=
 =?utf-8?B?SnlvS2V2dDNZelJMY1BiRjgxV2xYbVpZSC9GUkdrVWd3VStuQy9zYjc4L1hj?=
 =?utf-8?B?eFNBanh0MmJybnVKdnVmK1d6N0lucCtzQ1VqaWJLMmdKU1VDd0xTWDhoU2VX?=
 =?utf-8?B?ZnFkL2ZJMEpPTFZRL2I5S1BzUC85MjgxYnJ6bHJPbmovU3prODlxR1c2Mlkr?=
 =?utf-8?B?MCtvSHJCbnREeGN4WHdkQ0ZTTXJWeTF5YjNPS0gwRHAvSFZMbzYvZW1EWlpO?=
 =?utf-8?B?YmtrK1BzUlp4dEJ1RXdWRVhRY0dXcG9qbzFEdndXVzd3cDBpQkt1dFFSYy9m?=
 =?utf-8?B?UzJKc0hhNkZHN1MzZ1h1MnlBSG4wNDFraXVpemJiYmYyR1hvbm5kVStoS2ho?=
 =?utf-8?B?OEtHV3hVaEtGUzcwWFJUcmFjY0l2VEgxWUZVTzhmcUZNWXNTejAvdHJDYmZ5?=
 =?utf-8?B?amhmTnkvM2p6YURIZFVwR1UvK3lxemdNL0lGb3pzRWNlbkwwU2h5aDNRT25u?=
 =?utf-8?B?Z0ZtRkhRTDNFZ2MyNlNUd3I3b0hsQngyOVQ4T2lieUFvWVhRR010bHZ0QmJB?=
 =?utf-8?B?NUx6UU0ySXlXV3RmVnNxY2l4WUhPVnpNcXRQK2RMd0pLQkM0aGhubnhLa1JU?=
 =?utf-8?B?TDlHM2x6bzdtTndZZG9ZbFFXQmxCYXZheXdhcFlXMDFvYWkxeVJiL0NKY0dD?=
 =?utf-8?B?dUJJa0ZKdnNGMFFDMVI1RFdpaXN3SHBPcEdxVnU0WW50MGh2YTcvMDBLcTdk?=
 =?utf-8?B?anQ0dEgveEY4MGlLYlNEZjNJK0I4U1h1LzJwdnRqcFV4bW5oK3huL3N0VmlZ?=
 =?utf-8?B?anFyNVJybjl1VjZ6TjV2NWt0bFd0Nmk3RGRpY21SOWJtVWJtbzVEMmgyL002?=
 =?utf-8?B?WXJ0Ny9GdjJpQUx4V0pYRFRyOGV1K3hlUWJKVkFyZE5aLzR3TEpXVkIwWmQ0?=
 =?utf-8?B?TXYzT29xYlpCeGo5NjBoQ09kREQ2US9YNUROVUpJa0RyTEwraE5XMkdYSEZQ?=
 =?utf-8?B?MXhUN0lKYWxoY2EyZnBoZ0VrK05VZ013Q0hOc3h1R2p5R1U4TjFNa0hGdkhS?=
 =?utf-8?B?ZVpQV0svaEVIcWkxUC83L3o0Y1czWFJHSjlLQ2JrRTlQL1FyaFYveXZHUzVo?=
 =?utf-8?B?OWt1R1NYemR2cWtUbmNMUUNPd0xCdXVUNVJSelZFK0RGZUV1bGRiVEhNNzVN?=
 =?utf-8?B?SUpaUll1YnBLdHBBL0dJaEpHOHk4V2N2VWFaZ3JIcVRZTVFSaW9iYTJuMlNM?=
 =?utf-8?B?UlJPVlBqK09GbGZLaUJIa3U0OWhwWUVCRm0vSWlLcXR0NklERnVBSVYrSVFD?=
 =?utf-8?B?eEtDMVRYR2g2ZkRldUZiSXVMVkJsZWRwZlV3MVEwWE9tZzAvb1J3TUxuUXR2?=
 =?utf-8?Q?WGmDCt2iJgrCpqtcyT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b75466-91d0-490c-0743-08dea020a997
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 03:38:47.7713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArK22m4+cAolwzCh66khmCV4iUyxhRw7qEGRdzDH/x7QdYI/G2795jpP7aCemh2KMGqeZNAHJ+JGpQbM+7Cq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10313
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogUGVuZyBGYW4gKE9TUykgPHBl
bmcuZmFuQG9zcy5ueHAuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQ05pyIMjHml6UgMjE6
NDgNCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4N
Cj4g5oqE6YCBOiBZZSBMaSA8eWUubGlAbnhwLmNvbT47IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsg
TWFyZWsgVmFzdXQNCj4gPG1hcmV4QG5hYmxhZGV2LmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT47DQo+IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBKZXJvbWUgRm9yaXNzaWVy
IDxqZXJvbWUuZm9yaXNzaWVyQGFybS5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+OyBWbGFkaW1pciBPbHRlYW4N
Cj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgSGVpa28gVGhpZXJ5IDxoZWlrby50aGllcnlA
Z21haWwuY29tPjsgQ2xhcmsNCj4gV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgVGhvbWFz
IFNjaMOkZmVyDQo+IDx0aG9tYXMuc2NoYWVmZXJAa29udHJvbi5jb20+OyBDaHJpc3RpYW4gTWFy
YW5naQ0KPiA8YW5zdWVsc210aEBnbWFpbC5jb20+OyBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5z
Y2h1bHpAY2hlcnJ5LmRlPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBNaWto
YWlsIEtzaGV2ZXRza2l5DQo+IDxtaWtoYWlsLmtzaGV2ZXRza2l5QGlvcHN5cy5ldT47IFJvYmVy
dCBNYXJrbyA8cm9iZXJ0Lm1hcmtvQHNhcnR1cmEuaHI+Ow0KPiBZYW8gWmkgPG1lQHppeWFvLmNj
PjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBBbmRyZXcgR29vZGJvZHkNCj4gPGFuZHJl
dy5nb29kYm9keUBsaW5hcm8ub3JnPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgQWxp
Y2UgR3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYyIDIv
Ml0gbmV0OiBmc2xfZW5ldGM6IEFkZCBzdXBwb3J0IGZvciBpLk1YOTUyDQo+IA0KPiBPbiBNb24s
IEFwciAxMywgMjAyNiBhdCAwNDoxNTo0MFBNICswODAwLCBhbGljZS5ndW9Ab3NzLm54cC5jb20g
d3JvdGU6DQo+ID5Gcm9tOiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPg0KPiA+RXh0ZW5kIEVO
RVRDIGRyaXZlciB0byBzdXBwb3J0IGkuTVg5NTIgcGxhdGZvcm0gd2hlcmUgMiBFTkVUQw0KPiA+
Y29udHJvbGxlcnMgYXJlIGxvY2F0ZWQgb24gZGlmZmVyZW50IFBDSWUgYnVzZXMuDQo+ID4NCj4g
PktleSBjaGFuZ2VzOg0KPiA+LSBBZGQgZW5ldGNfZGV2X2lkX2lteCgpIHRvIGRlcml2ZSBkZXZp
Y2UgSUQgZnJvbSBkZXZpY2UgdHJlZSAicmVnIg0KPiA+ICBwcm9wZXJ0eSBmb3IgaS5NWDk1Miwg
bWFwcGluZyBidXNfZGV2Zm4gdmFsdWVzIDB4MCBhbmQgMHgxMDAgdG8NCj4gPmRldmljZQ0KPiA+
ICBJRHMgMCBhbmQgMSByZXNwZWN0aXZlbHkNCj4gPi0gSW1wbGVtZW50IGlteDk1Ml9uZXRjbWl4
X2luaXQoKSB0byBjb25maWd1cmUgTUlJIHByb3RvY29sIGFuZCBQQ1MNCj4gPiAgc2V0dGluZ3Mg
YmFzZWQgb24gUEhZIG1vZGUgcGFyc2VkIGZyb20gZGV2aWNlIHRyZWUNCj4gPi0gQWRkIGkuTVg5
NTIgdG8gRlNMX0VORVRDX05FVENfQkxLX0NUUkwgS2NvbmZpZyBkZXBlbmRlbmNpZXMNCj4gPg0K
PiA+U2lnbmVkLW9mZi1ieTogWWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID5TaWduZWQtb2ZmLWJ5
OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+LS0tDQo+ID4gZHJpdmVycy9uZXQv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ID4gZHJpdmVycy9uZXQvZnNsX2Vu
ZXRjLmMgICAgICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKystDQo+ID4gZHJpdmVycy9uZXQv
ZnNsX2VuZXRjX25ldGNfYmxrX2N0cmwuYyB8IDcyDQo+ID4rKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+IDMgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9LY29uZmlnIGIv
ZHJpdmVycy9uZXQvS2NvbmZpZyBpbmRleA0KPiA+ZWQwN2UyODY2NzYuLjRkYTEwZWQxMjg5IDEw
MDY0NA0KPiA+LS0tIGEvZHJpdmVycy9uZXQvS2NvbmZpZw0KPiA+KysrIGIvZHJpdmVycy9uZXQv
S2NvbmZpZw0KPiA+QEAgLTEwMTgsOCArMTAxOCw4IEBAIGNvbmZpZyBGU0xfRU5FVEMNCj4gPiBj
b25maWcgRlNMX0VORVRDX05FVENfQkxLX0NUUkwNCj4gPiAJYm9vbCAiTlhQIEVORVRDIE5FVEMg
YmxvY2tzIGNvbnRyb2wgZHJpdmVyIg0KPiA+IAlkZXBlbmRzIG9uIEZTTF9FTkVUQw0KPiA+LQlk
ZXBlbmRzIG9uIElNWDk1IHx8IElNWDk0DQo+ID4tCWRlZmF1bHQgeSBpZiBJTVg5NSB8fCBJTVg5
NA0KPiA+KwlkZXBlbmRzIG9uIElNWDk1IHx8IElNWDk0IHx8IElNWDk1Mg0KPiA+KwlkZWZhdWx0
IHkgaWYgSU1YOTUgfHwgSU1YOTQgfHwgSU1YOTUyDQo+ID4gCWhlbHANCj4gPiAJICBUaGlzIGRy
aXZlciBjb25maWd1cmVzIEludGVncmF0ZWQgRW5kcG9pbnQgUmVnaXN0ZXIgQmxvY2sgKElFUkIp
IGFuZA0KPiA+IAkgIFByaXZpbGVnZWQgUmVnaXN0ZXIgQmxvY2sgKFBSQikgb2YgTkVUQy4gRm9y
IGkuTVggcGxhdGZvcm1zLCBpdA0KPiA+YWxzbyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZnNs
X2VuZXRjLmMgYi9kcml2ZXJzL25ldC9mc2xfZW5ldGMuYw0KPiA+aW5kZXggNzY2YWVhMDM1ZDMu
LmExNTY5YjlkOTg5IDEwMDY0NA0KPiA+LS0tIGEvZHJpdmVycy9uZXQvZnNsX2VuZXRjLmMNCj4g
PisrKyBiL2RyaXZlcnMvbmV0L2ZzbF9lbmV0Yy5jDQo+ID5AQCAtNjcsMTAgKzY3LDM2IEBAIHN0
YXRpYyBpbnQgZW5ldGNfaXNfbHMxMDI4YShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+IAkgICAg
ICAgcHBsYXQtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0ZSRUVTQ0FMRTsgIH0NCj4gPg0KPiA+
K3N0YXRpYyBpbnQgZW5ldGNfZGV2X2lkX2lteChzdHJ1Y3QgdWRldmljZSAqZGV2KSB7DQo+ID4r
CWlmIChJU19FTkFCTEVEKENPTkZJR19JTVg5NTIpKSB7DQo+ID4rCQlpbnQgYnVzX2RldmZuOw0K
PiA+KwkJdTMyIHJlZ1s1XTsNCj4gPisJCWludCBlcnJvcjsNCj4gPisNCj4gPisJCWVycm9yID0g
b2Zub2RlX3JlYWRfdTMyX2FycmF5KGRldl9vZm5vZGUoZGV2KSwgInJlZyIsIHJlZywNCj4gPitB
UlJBWV9TSVpFKHJlZykpOw0KPiANCj4gbml0OiB1c2UgZGV2X3JlYWRfdTMyX2FycmF5LiB3aXRo
IHRoaXMgYWRkcmVzc2VkLCB5b3UgY291bGQgYWRkOg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgd2lsbCBh
ZGRyZXNzIHRoZSBuaXQgYW5kIGFkZCB5b3VyIFJldmlld2VkLWJ5IGluIHYzLg0KDQo=
