Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A33FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 13:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 030DA847C7;
	Wed, 29 Apr 2026 15:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="HEU0agRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6201784832; Wed, 29 Apr 2026 15:40:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1189684702
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOujf1DQrreklmHTnzFVfnIzMTAoB3nr48+dgZxWA4Y798Qgz6sVlu/F7nF9r1oskUnmL2tn7tQ1TGNk3c1b6XU+bcpNY2jFq+bjmx+RpMFblgMLAAObtMeu8wmeRyTFbwfI1d1DQuAHHq7Fty9snprYTK2SNquPpBm7FMAoGUxIxxhVB70gtNI5RSZB+uxkgmwvIyfoQxP7M7NNjj9jq8fUEwe4LkcT7kHvj+l2K6C41YFbARfE1mVWXZpOZusVFe6iBmQg/gYt/sqZ88ncKrYYwZ0uP1r3/G6EbemzCFX683NFwO0zxps8jLCABWtclwpmWMmDGqZYR4MCb0jX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR5hCM/PbLzAKgEKW23d2w9TMzKVZeQqQiU3H42+8qo=;
 b=B2mhu3WZA/31yzvJOl8ChajNJftSuVusHYM6NryP65or9u0nzlvVBrDEycHjeMShXQnZSLIx8+gmRrSuO1m0zUNuk3PYZUwoY2KqGzCl2mhqkTq71yfqYv83a+h04QFCFFIG/td3+4n5ckrV6dMV+A/xekLvOJhEgxjxOjrCfaKjLOnb3a1I4GeseFjzxN1OZXbmpft8muvolIMn3uTGYn39sw2LjADxshmpMiBdAMaMPyIE4RGfBIvJl4oUumTmPt6U7cEZSLfvijLwMSmpD9zMbkaaQCzuXzQFCLUG5dvTODjXhxcwOvvEW/K2k5G3Kzz3t4wQTKKOGEA3xt4Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR5hCM/PbLzAKgEKW23d2w9TMzKVZeQqQiU3H42+8qo=;
 b=HEU0agRMc1H89lHDGx0tGx5GrKnfyZFKZDvPfTNA35bmzZ63ScifRPSHlJsfxeUjAGiNe1kwzd1eySYHyLPij9WSxMZZAzDh5bcWZOcQTGWP9v7wrOZlooP/xibSllRIRMBgRXiaM0g6xeCVHuc7eSfi6i+oQ45HuzAjH0b7MbJJoDNUFPSx/Gw68XxsJmPH2M4BKB9/AkDXwgXRHJP/irvyC03TrM60N6km73KR0xmHLy6VixWlfzsneEKbz3Ese4Y91K89WaLmwSTRswbl8dLUaQ1lSYtYG3psX4zN/YkY3jChmYiDxqNyv0AxPx/FQqNqrIiqVDTSR+odjuB/ig==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GV2PR09MB6087.eurprd09.prod.outlook.com (2603:10a6:150:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 13:39:56 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 13:39:56 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Liang
 <ycliang@andestech.com>, "rick@andestech.com" <rick@andestech.com>
Subject: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHc192qLDlkefQ1+EmKmGV+NYhZ8A==
Date: Wed, 29 Apr 2026 13:39:56 +0000
Message-ID: <473eb859-a1dc-435e-b0cd-304623809262@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GV2PR09MB6087:EE_
x-ms-office365-filtering-correlation-id: d8c66d61-815e-4d33-999f-08dea5f4ccfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021; 
x-microsoft-antispam-message-info: a0lunIQDuAjrUGkeNlSZjohxYY4/Q3SbgZEJrpBnu069Qd7bXwNehZh8i2z0IsauJypSUA3+iA+3ydyl2QMdNdAsK+B0Fs9NGnf+EYwZ6zIJ7JJ9dbP624pKauwnEZBZHiT/wMUZpqoivo0QqgyflOyI/yWvuaPqgSYSEembUIEqYGfN+NN5FLeAdCKNsrULAxiRVMat1ZuRomVpIv/fAFXDDhETTKZEaIR6po2AKEWWn4ip1A926NAUjuXW+XMAmq7ZdnDrv5FWTDNd+oQ+VrpK0yYx3tXhm910Irt5ETt4RxKGM7mGeFo9SIAqoFcg+6mUhMGlKmB4qILbTM4vVSQuIQ13Qbk8+8SZQqX2m8zymRD8iB7H/Lg6kf83VKl6GaGrs8sho3QLWWl+7nILGkCz5njEbXDVjnULAWhYYzQOPvDpXj7u6oiuyFKdk/NAgH6PFrN9GsFGhqkT3SPXVuBcjDZgVW53zCNgzjWHNPAv82D1IINYHxC856L2o7VegBaOifyVGedjT1zJdhEb20h3UerS7boo8dBiT5UYO09a0xmqTFU7Ns3kry6RwZ5Mj+pHzWtDrPGETIpTj0B6XQ1CEl+2SUKLlkzQIyg4U7fLFPN4bMMgRa4uqkINTqDCBh7zZfao2QOY7N+i0slL50YAYCPJHofVZ86oUP1U/GfuGqyiWUDGmOwHulZSilIgwqLcPW+4w4ibkQrPDIq99wedhpw1yiqwYekDV6iex1anktgRK6jjdtQ0MzbkSxyMbddDzbAmy/UFkr/QFVJ8SvodZP0MWHKr7lr6QnjE1No=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YitkUFUyblZBOWhKd0lvRUNDZ3NYbno1V0x6ZkJZUGlhclQrb1VidytteCtG?=
 =?utf-8?B?VmVxOTIwYTkwVlpqK3piczFHRWdxZnByMm9nZHY0VXdjSTd5Z0RrRUxUVkVu?=
 =?utf-8?B?YWJUOHNReHJUQ0FvRk53THFJZGY5WXBDSklIakoxT0svbEkrR09NbDNrZzhz?=
 =?utf-8?B?ZG9adHRVbUR0aHVTYTE4bTlDbkxkQXJOakJYYkw3NlJYTGZUTnFuU0dwOVho?=
 =?utf-8?B?YzNYM0VDMmdNWmJqODBmYWRMb3RhL0tBT09OTU5CbUdONmlUejNMYnExYVFs?=
 =?utf-8?B?SHJrVVBmeDJIN2IzNjA0aDJVOXIwN2lGaWxLcmtVdWt0RC96SmVBSmF5SUVH?=
 =?utf-8?B?SjE2dEc3dTd2SGd5RitHOFpGTHJqVGdVcjVMdFlQdFN0Vnc3WVd3alUvQjBy?=
 =?utf-8?B?b0kzRjdJZit0V0M2WVhVaUx4OHJBeEtocGhQQW5vcnZRMXlPRlg2ZThhQnA1?=
 =?utf-8?B?OC9mTkN1UnE2RmdqV2VLZkJ6YzdLeXVXYWFCUThSQUpMOUNaWkZUVG5ESXNL?=
 =?utf-8?B?cXRQRTFKSVRhZ1pIcXpBM2RnS3AwVGZMNVlQY25zajBQYy9pNSt0WFpiSHov?=
 =?utf-8?B?RTdvYlVUNjdOeFFFVysrRUwxVUZHMmIxVUtHSG5vem0xSFdlV0xvWGJQMmdy?=
 =?utf-8?B?U3JRRzBsSk1yN0xEVVpTWTNCZnlkMThCL1krdHJueW5YdCszdUIyYmtqSFZT?=
 =?utf-8?B?TGhKb0ZYcDVreXYxNlVyZHg4MGdYcUNmUnArVWFQaGU5Wi9rSis0WUY5dE00?=
 =?utf-8?B?aE10b2lSTDd6TTQzRDEyb3hDVSs5bDBjbm90ZFFVd2tqeHpaMGFkd0hyMHhV?=
 =?utf-8?B?SXpsdHlMQlFTWjhBQlJ2aEZmaExmOVgxZTUyZGlLNGc1ZjVtcEVGd2t6OURH?=
 =?utf-8?B?c0g5ZE9GM3AvMTlOUXk5aFRYa1NLVEhPKzRtZ09TUHhVSXJGc2hNVFpyV294?=
 =?utf-8?B?ZldhRkNhYWxGWmJvZXBISmtoMFdBbmZSR3EzMVowcU5Nb2JmNm90V2J5ZE91?=
 =?utf-8?B?b3pNdkpKeWRaVUdxZTB3UHFuNnNsQS9YTGMzaEFoRS9ZcHl2VW54K0lSdHJ1?=
 =?utf-8?B?ZXc2QURNWkt6QmQxRlZKL2hWcXMzRTRlVFpqZTBRN0VGM2lnTmx6bG9DNkZ2?=
 =?utf-8?B?czgzYS9sZEczakJXcCtvaFF3bFlLRG1FZ0NvbDU2UmhyckFQcDNuODBvRWRV?=
 =?utf-8?B?M0FZZzFlMVZzZTZmVndEWStybzZncjlHVlorVkFJdVVVWXoxR013UWVwVXEz?=
 =?utf-8?B?ZVg4N010WmU2OVNYK04rVE0rWW4zaVdUZm1sY002Um83RkRySzErUGhVNUJT?=
 =?utf-8?B?KzVWK0t5K3RLVWgzYTU3ODVheG9uajJBM1A2SFVvR3IyK0xleEFzemgzbVhU?=
 =?utf-8?B?MTFNOVF3QytPa09LVTFwZVBFQnBGR0M2T0NpRkNoaFphV214L0VTN0tqdlUy?=
 =?utf-8?B?aENoT3FZSHFqTElVQk1WaTlGYk5OZFMzdGlVbzVaMUt2citnOVRERWE5YUdD?=
 =?utf-8?B?QmJ4cERDREwvWHdTblFpZStkYVZudFlObmJmbHhzbnFWMmltZHJYRVJhQmw4?=
 =?utf-8?B?RGYyaUNZSC9ydklnREMrSUZqaFNtZzd0TEIwWERycFoxRGQrME96ckc2b2RL?=
 =?utf-8?B?Z05RR04yaXNhb2RibzBETThwS1kwSklTaWFxMnQ4Z0lFODRVZEFzZ2FWVGZy?=
 =?utf-8?B?b1Z3bnRsa1JTSzB1bEQzQ1gyNUFxQnE3RlFueWQydVJtN0dqTTBnaFBrcEFF?=
 =?utf-8?B?eHBheXFuRG5zZWplL2RGNHBVNDQrcVdkdDNmdCs4d3RTdzVJR1FsZnhEd0pQ?=
 =?utf-8?B?ancwdXN0Y0FuWHFaY2RNejdEZXE3YXdGUDc1Tm1rUzQwcmFVVnVucGkrcmFL?=
 =?utf-8?B?L2JrRllaTGljeXc5dVpEbm5zeUN1Z2tmNCtJZUlHRkt3bDlQc3FOVDVaZ29V?=
 =?utf-8?B?OW9WRHBwTkZ3QkFUUEhROFVVTGRIRVBxMVZVdmw0WFVxdVl5Mkx3cGVvQzg1?=
 =?utf-8?B?dFpJNzJaRndzMkNGL0pNYk16d3ZDMjhsK0RuNXBMMXpWN0FFVlN1b29RS0sy?=
 =?utf-8?B?SVI3V2tWb0pOR0ZvbzhBWDdxZzVjanBENjZ6bE5aSnNBWFoyL0VHbjlTelp3?=
 =?utf-8?B?ZEtFT3dhb0UreU5OTzZDN3VsUTJ6UUdVWHRNeHFTNEY1U3ZOUFZTRkgwUXBF?=
 =?utf-8?B?VEE3UUUrS2pIc2J0aTJmSlcxUjFLZ0VNYXdEcEEwZFRjT2N6bEhEQkVpdFdB?=
 =?utf-8?B?SmcydU1WeisxeklLWmRIa2NYVFJtSkd3TFVEWDMrK1FScDZpUVJYc3FnRzRk?=
 =?utf-8?B?YmM1WXRtWG5PN01oQ3NXWEtSajlKOTdGczh2U2N5dWo1RkVZWGVadDNWcWhC?=
 =?utf-8?Q?P4kfT4IvprXG1tXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF74AC2D1C9C145B7DC368563466E7B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c66d61-815e-4d33-999f-08dea5f4ccfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 13:39:56.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6/P1SWxljPqTIPXBVpdx5/5EYi15fn8pdb4sLyimsMFiA19KJ2ZaTTTMdjUJ5vZGLvrjeOQiybtPyfup40YLXefSDufStQipa+1os3M1Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB6087
X-Mailman-Approved-At: Wed, 29 Apr 2026 15:50:53 +0200
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

SGVsbG8sDQoNCkkgd2FudGVkIHRvIGZvbGxvdyB1cCBvbiB0aGUgcGF0Y2ggc2VyaWVzIGxpbmtl
ZCBiZWxvdyBhbmQgY2hlY2sNCndoZXRoZXIgdGhlcmUgaXMgYW55IGZlZWRiYWNrLg0KDQpodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvbGlzdC8/c2VyaWVzPTUwMDMy
OQ0KDQpUaGFua3MgaW4gYWR2YW5jZSBmb3IgeW91ciB0aW1lIQ0KDQpCZXN0IHJlZ2FyZHMsDQpV
cm9z
