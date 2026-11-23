Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB2606A32C
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MlDyANU0;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=l+y79g3R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C38CE80E47;
	Mon, 23 Nov 2026 13:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ujzwnq4GokI; Mon, 23 Nov 2026 13:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0829780E38
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795441039;
	b=YxkjIo5pZEdr5rfSL8VK8yAn3LAjgHDPT5bBK0IyUjsazJXilcNeYw1Pxqn37eQ1BPMG
	 SYQUoVYtz5Xsd2bR6efIX3A84XAy8efbg0zZv+HmQDdD+VvIMfE7QN6gzIIImn+/fUQVX
	 75e6dM2tLZ/xtG+SqD5gpc+jYC2FcFT3p1y8maFc8MUrFO9a6BZnjEL3gu0DhnqJyxV04
	 tsDRlscc038CT8Y/dpKiRppwSTViAfyHKzPJl89ux6vTD4Ya0MuyEbo82f6RH+/YNveFD
	 0MC8bMP+Mu96w/PsL1vMjBTjBc/QAT2P40GgVAbrvz/BJhDkpLs9SW7VsnW7sCRvqLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795441039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Immke2GQGV0dAEUnLEpp9sZkG4FjXuYAsQhe0M3WJR4=;
	b=YwbEt9iNxLphOwLhsGMft8fjF827rq9mZDtz3FefUc/6BIvpucfUlHx9SIAfkDX76ojs
	 ZxTNtJWF42nJJlr2lcvVEP0fwFWIOQdYfNfy803gb+jIdDWE4fqUSPgL10+SUfZ/5hT+l
	 0HWkzEpQRAtr8NQknEiR3XNdISICkayHa5S2hS/JZ9CTfEPsrz89lEEigG2RHNr+c9oX3
	 xEdkDLFUzvxHURi0sSzZzx5CEaCI61tbnqieUZbrGz34bdsyW8ehxE7nS4FO7oZZ5m9rv
	 bjNlvx1cbn450cr4r6xmboAqUpwJ9TwlNgjpx49Rv8nRtnmHzlX0S49DfE6bus+jPhA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795441039;
	bh=Immke2GQGV0dAEUnLEpp9sZkG4FjXuYAsQhe0M3WJR4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlDyANU03rh/j9bJZz+zRWmiQYQ2fNIKT7fPt5RStZob+eu1i68IOR5H2yTEnMILl
	 iH1ZMJyDR348ZbbaWT1Avh5u6PTLZr2tXTFh0xR01hygioH9JiWvZfJ4Q5t2BCKHzB
	 qADYYyyJ1PvETw2eu+ky0oJeC6qnjG260jM1afWsSsQ6v3LGngOildpbLfT6Tl7dIy
	 huoCCHkPr9OY3QaCEQeLe8Q+HR7L1vNwBbu9vwMP3L2edL2+KKhbjshzo40AAeMWmb
	 IHSbbXJkiO9pvAkbmnZ8kwSkPUkJ+hrNm7Jq08JXls/IB0WBcACf3w87sCgS1dCDUL
	 npgHaKNrsXvvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0829780E38;
	Mon, 23 Nov 2026 13:37:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8D27260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF07B404C9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ftv0Z_rPUKm7 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:19:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D2C6403F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=l+y79g3R
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D2C6403F5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Immke2GQGV0dAEUnLEpp9sZkG4FjXuYAsQhe0M3WJR4=;
 b=l+y79g3R11OzxG4/j0JlgiZEmI61MAblhyKu8322qMM5CoLNRm4wYQNiL8MgrYyXQnqtw9eXBOgQBN4jQsrAG835Pla7wc1HxwZ15X8pqxyX6L86RoS7DmNGfeHZDAdeTFhNBBpMR3Ehjxr7R9dZdUbHk3UOabwGT/e/qZDqVLR4ZOKabt/jlimXe2mmfonoSlN/+Kf8s5zZ+5HF6FhQ7sd0s0FM50z7FB+bBPYYTQCxZcRZVixV+IjjNngM39REhzOSEDpmORpO8IwdNzeX+4RrWr8Li+CK6WnuIyuBlrfX9WXnjuewtYryrgsrn33kVnogB3no2RoqpUls+hxlug==
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10)
 by BR0PR04MB432630.eurprd04.prod.outlook.com (2603:10a6:2c8:5e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:19:20 +0000
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5]) by AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5%2]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:19:20 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, krzysztof
 <krzysztof@kd-solutions.pl>, Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, Johan Jonker
 <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDIvM10gYXJtOiBkdHM6IGlt?=
 =?utf-8?Q?x91-9x9-qsb:_add_U-Boot_specific_dtsi?=
Thread-Topic: [EXT] Re: [PATCH v2 2/3] arm: dts: imx91-9x9-qsb: add U-Boot
 specific dtsi
Thread-Index: AQHdc/G40MLSyT0P+k+5Pf0vwcKmnrc6BMeAgAFV/cA=
Date: Mon, 23 Nov 2026 09:19:20 +0000
Message-ID: <AS8PR04MB8721165C7000B6521E995163E2452@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
 <20261114-91qsb-v1-2-046293559467@nxp.com>
 <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
In-Reply-To: <CAOMZO5Be6ZrFPJJEg=oQeXb-Erh0G=KUsUdnVjptu+36W7PKgA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-23T08:04:56.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8721:EE_|BR0PR04MB432630:EE_
x-ms-office365-filtering-correlation-id: 6e3d19ba-93bd-4c45-0297-08df4942db64
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|366016|376014|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|3023799007|41080700001|15866825006;
x-microsoft-antispam-message-info: DvrQ2k/p093+Xi4xywT21OgOSiLVkGG2HD15lWVbGAqiZJe08sQNKlivVcfzqkBbYAVCRzUQ0gjkdvfYiUvNtIKVUEpM9PHZcdhpaWO2nhZ8y1Z8EsGACVZldzH8rV0KV9lPe9P251PG9lJohCEp9Uez56UqKhiBzks8LCxBeHZPHzSoAtuLpGX4yENA63U+jKWBrd1eXqJgNnbpGXgoBI9eRT0avG093PmVDiPgBPuvecJddSP5p7Umj8tQdnS6mgJ01PwzqR/qTOcwqCHGhTbF+ivLHRfd3hHD9hVGy+Qoxd0vLg3u/WJw/K9e6NDf3SG2Sa3G+ySpllsFHP0KHN+tb1g4VdWIrKnrX1SawAYof7AAkWqhZYymBGhqK3wMhtUDMbJVZnq0P6zrT/UArVBCfxGFfKDarTNLong02J6Bwmk0NkQZcxH+Tg3IMQzlTj8WzfCf1fQG+0FO0w49O1oQ8bhtGr2wDaZusDcQQShyl6P+w9ACO8G+s4EsVkVazAgKJcAueZQAQ7nI0XOKUaVtAX8xPe4nE+FDyjxHejSFp36PcIuHpjeh62czcam7BZAUhaDBzsX6UJOLmdpt9yMjw8o6vn9I3LhNRTInfH+Q21QPPlcYzlbD2u6TM5yfLSezdsdwPk6npj1IKRYiAUKxDzKgHWGMjATZAJzXLt34QTfhSklTty6tulD51IHvlmnTAAu9umIe27h0eESVhzr99rHlj8CFYUSW+Wvb6BTrzN+edof2dkogRxv/Q/BZZwAKyHsdab1IOcbBEVmqzm5blTb4S1RTYomGzF9oRm0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8721.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(3023799007)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlxL2dNckZYdisyVENEbXYvQndERHNOZ3lrdzlsZHYvQzUrOUZCQ2VNaHRq?=
 =?utf-8?B?ek9KNGlORU96cTJXb1VHbkQ0c1pDdktmL3RWaWEwME8xNWRFWm5HeFNpcUc1?=
 =?utf-8?B?cWxUdUU0YUVEWGlDZWNxT3R6ZEIyY1Y1LzNjRVI4czRENDZZSFFleXY2dDk2?=
 =?utf-8?B?bHE5SFZ5eXdPaVZ2RFREMWk4S3JmSEhTTlJCVnlMVnRmQWZwMHpxcExnT0Zi?=
 =?utf-8?B?cnFKcWNGYW8rYW5ldDdJSFk2cHNKbk1KY2kva3J5ZVJFYUNlTEtwWjc2R1RX?=
 =?utf-8?B?LzllQ0hpbS9jUU5OYThlaUtJNzlwQ0kwbVBKWmJxUFFkWlROQUYrV3RIdWx5?=
 =?utf-8?B?eGMxNUVic2pnWkNMWjV4NUhTWVo2ai9uNnlOdUZ2WFZadk15SG5ESExheE5o?=
 =?utf-8?B?ODRzY3ptNnkzdFhGMlhxMjRqdFc5aXdEWnhRL2ROb0RqY3l4MTNFVWFuWGEr?=
 =?utf-8?B?M1hTVzE4bXdVV2RFbGlGcDBLbXE5MlJDWDZnRFgzMUxVUUpiSkx4K0x1dGty?=
 =?utf-8?B?cVZXQ2hyMTR4b1BMaWg1QjJ5SDRtVTVDUHJBek9GYlVHUHYzdnpTdExLckJw?=
 =?utf-8?B?WWgvUnI2ZGYwVW5Dck9rMnZIanBPNlZmaThYZzV2bU50MDZrcTNiTitDaVgw?=
 =?utf-8?B?bnUxMTZEZTFTYno0dXBQZnE0VCtQOE11Y0tuTXJqV0hwOTYrdjREOUpHY2FX?=
 =?utf-8?B?YTQySXMvcmxXS201bngraHlXTHozSExkZU1vem5JWFhYT0hpaVJOU05Ud3BF?=
 =?utf-8?B?NE5aeTl0T29hbjZMSE1rWmtLZkVaa2RkUFB5K20weHpBREVSdUduSFZZOUJu?=
 =?utf-8?B?ZzN2QTEwREVKNlZZdnNCcm9jRWwvSDAwa21tL3VSazNpazIxU2FidWZJMHlv?=
 =?utf-8?B?V0s2MnRWQzNNWG83M3FtWE80Vk1Ga1hWT0pUOWNaWkkrZHFwVmFCZnNEYnhB?=
 =?utf-8?B?QXI2Z3BnT3dVUHAxZVZQNDhDNVpMNTZtMGdFK00zK0Vzd0paMmFlUVJ2dU9K?=
 =?utf-8?B?bHZ0UWJMS2VBMVRrb3hoODNMekZwK1Y4Z0laRjdlbHNwV2dFcXZCRjdkTStQ?=
 =?utf-8?B?K2pzYmxycjZoU3lRbkN5Q0hiUUZrSnJGUHN3Y0lPanVacDRvTXN3VGFXYkc1?=
 =?utf-8?B?dUNId2wrUTdxVERhbVUrQVI4WjZseVh5Q1c4TE1BUzZVUk9mcW0zZFk1ZVVh?=
 =?utf-8?B?dE00dm5QVm9lQTVsZkErTXFNVGdOV0RPZlEzS2ttT3B3MnBLejBWZzk4SE1G?=
 =?utf-8?B?SWVXQmdURVhvR1BNNWtzZGV5RDJKYXRiZ1ZvSVhMRWhsK1pjaSs1TEVlakRP?=
 =?utf-8?B?aFRJaGpQUU1KNVhqL3hWRm5QZ2lQazcrR1FNZ3BHM0F6N05qbTJMSDNMeFNk?=
 =?utf-8?B?YnBVZElYQ29zYjd6Q1Q5Ris5RzBMOGlWanlGdVdZZnlQc2dZenhxK3Yycmc5?=
 =?utf-8?B?bjJZNm9sNExGQ0Z6bWljaUNpTDl4akxSMHlQekNlZzZUbmtvSUxlNWpyYVE0?=
 =?utf-8?B?TVFPZCtRcjg5THh2MEgzV25RU2c4amlqSGlSc3d0enNWNEZSS21ZQ0FTVHA1?=
 =?utf-8?B?RGdTMmU5VXg4TnhZOVMwTXJSQ2tuUExHM1dBZjlWWHBEZ1hDZFFXcmJwN0RU?=
 =?utf-8?B?YWJTcDJXNU4vWk1iYlh0MTdIc1JmRXQxMHpTR2prLzNOSy81S1JaYmNBR29U?=
 =?utf-8?B?UDkyS0RwUUhTSURzdUJxV1N2K2VvN25FU3pVWlp3by9McStiQ0lYb1k1cjJ6?=
 =?utf-8?B?c0NnV1ZnQW5JcFl6QVJyUEVwa290cGVxSUp0WmNYaXZDVXQxeHJ6U1BwYjVa?=
 =?utf-8?B?OWE0OER5bVpjYktpd1ZrQUxqZUdhMVpnYWRlMDBjeHdKS3dRblptcHFCdGlT?=
 =?utf-8?B?clJIK0FVekxoZDJWRzVBNEdrVXVncmN0aTdGcnZVbVY2WEk5T0ozemQvRUQ0?=
 =?utf-8?B?dGs0UzV3M0FNOUJtUW5GT3FqZ2E5TDFiTkt2Um5VYUR3N2xqcFlKRmhtZUtX?=
 =?utf-8?B?eVJjN3YvcSszWlpqOXRsYXMzRHJtYmdlREdieFNwWENiTFlpVlp3WjFESVZU?=
 =?utf-8?B?dEYxSFJMTzkzUHpRRlFLLzFEUjRPWGVGK1E0azRYL3RuSjl2ZHJzRDU0NUhh?=
 =?utf-8?B?NEsxWFpzL1hUVFdpZlo1WFdEMXhDeFl1N2pTL1h4UWJ1VXRxcHpYREEya3FH?=
 =?utf-8?B?RnhGbWZmcVEydDAySHFXMVlWS0lnNW9nWnJENnZCc1lqUnNBRmlVdThNdko2?=
 =?utf-8?B?eDdLdHF6VytYb3k2TU5EK1BUbTdyUVp2SXgwalg3ZC9xaUJLUVRaQkdQOVBW?=
 =?utf-8?Q?gQ5v8iQk+hH281YNrV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3d19ba-93bd-4c45-0297-08df4942db64
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:19:20.6852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcHOVTmW/kpTTP3o4YL1mvtNmcf2uqLn6Hz42dqUnP2wIbL7wnGmhnU2mwwWLnWP6fI+jV3iurizmr53/xwYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB432630
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:37:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6
OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAy
NuW5tDEx5pyIMjLml6UgMTk6NDENCj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMudS1ib290LXByb2plY3Qu
b3JnOyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsNCj4gSmFlaG9vbiBDaHVuZyA8
amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4g
VG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IGtyenlzenRvZiA8a3J6eXN6dG9mQGtkLXNv
bHV0aW9ucy5wbD47IEpveSBab3UNCj4gPGpveS56b3VAbnhwLmNvbT47IElsaWFzIEFwYWxvZGlt
YXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz47IFN0ZWZhbm8NCj4gQmFiaWMgPHNiYWJp
Y0BuYWJsYWRldi5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT47IEpvc2VwaCBHdW8NCj4gPHFp
amlhbi5ndW9AbnhwLmNvbT47IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+OyBWaW5j
ZW50IEphcmRpbg0KPiA8dmphcmRpbkBmcmVlLmZyPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4g5Li76aKYOiBbRVhUXSBSZTogW1BBVENIIHYyIDIvM10gYXJtOiBkdHM6IGlteDkx
LTl4OS1xc2I6IGFkZCBVLUJvb3Qgc3BlY2lmaWMgZHRzaQ0KPg0KPiBDYXV0aW9uOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mg
b3Igb3BlbmluZw0KPiBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNz
YWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnDQo+IGJ1dHRvbg0KPg0KPg0KPiBIaSBB
bGljZSwNCj4NCj4gT24gU2F0LCBOb3YgMTQsIDIwMjYgYXQgMTozNuKAr0FNIDxhbGljZS5ndW9A
b3NzLm54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSm95IFpvdSA8am95LnpvdUBueHAu
Y29tPg0KPiA+DQo+ID4gQWRkIHRoZSBVLUJvb3Qgc3BlY2lmaWMgZGV2aWNlIHRyZWUgb3Zlcmxh
eSBmb3IgdGhlIGkuTVg5MSA5eDkgUXVpY2sNCj4gPiBTdGFydCBCb2FyZC4NCj4NCj4gV2h5IGFy
ZSBhbGwgdGhlc2UgcHJvcGVydGllcyBVLUJvb3Qgc3BlY2lmaWM/DQo+DQo+IEl0IHNlZW1zIHRo
ZXkgY2FuIGJlIHBhcnQgb2YgdGhlIG1haW5saW5lIExpbnV4IERUUy4NCj4NCj4gUGxlYXNlIGV4
cGxhaW4uDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQmVsb3cgaXMgZXhwbGFuYXRpb24g
Zm9yIGVhY2ggaXRlbToNCi0gd2R0LXJlYm9vdA0KICAgICAgICBJdHMgY29tcGF0aWJsZSAid2R0
LXJlYm9vdCIgZXhpc3RzIG9ubHkgaW4gVS1Cb290Lg0KLSB1c2JnMQ0KICAgICAgICBJdHMgY29t
cGF0aWJsZSAiIGZzbCxpbXgyNy11c2ItZ2FkZ2V0IiBleGlzdHMgb25seSBpbiBVLUJvb3QuDQot
IGZpcm13YXJlL29wdGVlDQogICAgICAgIFRoZSBjdXJyZW50IGRlZmNvbmZpZyBkb2VzIG5vdCBl
bmFibGUgT1AtVEVFIHN1cHBvcnQsIHNvIEkgd2lsbCByZW1vdmUgaXQgaW4gdGhlIG5leHQgcmV2
aXNpb24uDQotICZBNTVfMA0KICAgICAgICBUaGlzIGNsb2NrIGFzc2lnbm1lbnQgYWxyZWFkeSBl
eGlzdHMgaW4gYXJjaC9hcm0vZHRzL2lteDkxLXUtYm9vdC5kdHNpLCBzbyBJIHdpbGwgcmVtb3Zl
IGl0IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KLSBFWFQxX1BXUkVODQogICAgICAgIFRoaXMgR1BJ
TyBpcyB1c2VkIHRvIGVuYWJsZSBNUDIxNDdHRCBvdXRwdXQgdG8gcHJvdmlkZSAzLjNWIHBvd2Vy
LiBJIHdpbGwgbW92ZSBpdCB0byB0aGUgTGludXggRFRTIGluIHRoZSBuZXh0IHJldmlzaW9uLg0K
LSBTRDNfblJTVA0KICAgICAgICBMaW51eCB1c2VzIHRoaXMgc2lnbmFsIGluIHRoZSBmb2xsb3dp
bmcgd2F5Og0KICAgICAgICAgICAgICAgIHVzZGhjM19wd3JzZXE6IHVzZGhjM19wd3JzZXEgew0K
ICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtbWMtcHdyc2VxLXNpbXBsZSI7
DQogICAgICAgICAgICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmcGNhbDY1MjQgMTIgR1BJ
T19BQ1RJVkVfTE9XPjsNCiAgICAgICAgICAgICAgICB9Ow0KICAgICAgICBVLUJvb3QgZG9lcyBu
b3Qgc3VwcG9ydCB0aGUgbW1jLXB3cnNlcS1zaW1wbGUuDQotIHUtYm9vdCxvZmYtb24tZGVsYXkt
dXMNCiAgICAgICAgVGhpcyBwcm9wZXJ0eSBpcyBvbmx5IHVzZWQgaW4gVS1Cb290Lg0KLSBmc2ws
c2lnbmFsLXZvbHRhZ2Utc3dpdGNoLWV4dHJhLWRlbGF5LW1zDQogICAgICAgIFRoaXMgcHJvcGVy
dHkgaXMgb25seSB1c2VkIGluIFUtQm9vdC4NCi0gZXh0Y29uID0gPCZwdG41MTEwPg0KICAgICAg
ICBUaGlzIHByb3BlcnR5IGlzIHVzZWQgYnkgdGhlIFVTQiBnYWRnZXQgZHJpdmVyIGluIE5YUCBk
b3duc3RyZWFtIFUtQm9vdC4NCi0gJmNsaw0KICAgICAgICBUaGUgZGVsZXRlZCBjbG9jayBwcm9w
ZXJ0aWVzIGFyZSBVLUJvb3Qtc3BlY2lmaWMgYWRqdXN0bWVudHMuDQoNClBsZWFzZSBsZXQgbWUg
a25vdyBpZiB5b3UgdGhpbmsgYW55IG9mIHRoZSByZW1haW5pbmcgZW50cmllcyBzaG91bGQgYWxz
byBiZSBtb3ZlZCB0byB0aGUgTGludXggRFRTLg0K
