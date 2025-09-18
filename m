Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E338CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 05:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EED5800B6;
	Thu, 18 Sep 2025 07:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mgeCRW2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104A080050; Thu, 18 Sep 2025 07:45:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77754803CC
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 07:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txZg2JYVr01b2O/W2Tx5WLDiUNnmi6gC5x5xXUjWrliqnUcV60WmFqQlq5ADPHT0BtQ5oVtpFIufy914FAfT9693NvzzmVxchAh2KkFc5ILohFb63zISHYqqOl3w7/cBmbhp0kw+7EVALb7XLntMeXlPtUzh9Gzg4T6FQ3BeQps6oXoBL6G/KFezEnVzY0vWU17TOi/Sd0SpTcPV+g5uDx1vZBSLfh2lMlTqT9MPslDipCoCooeQNTQK5qzE0xTOYHrYzANJ1vrIDneA5lT/mvrTC64wdT35fSUyGlV7/rlPikC/Kejm26LMby6Qc4TxlVvU7mSz+n5xW485v7rwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhbIVvutcAbOrKWp8RWE8Z/bjPwzBNx8EDFG2MqN1ho=;
 b=cYLKNnb/orKc7AX1dWgFdyJVM+oFa53FhGUMIFX/Coj1KtJAc2rubJ2Mu7wlBqALsrg/pizrkTzg4dalkOI84mNZYr5sCD1OsUWpFLRDJbWvHwuTtETe2X5pCBClYLAhpr6EupplvimtQ6bHTIHDkOqAydIlbAmBOao5Hu3vcZ3KBWniBXpyT00XdyWF6GP7c1X5UMisDwTcooQW4GjX9eAC047G2Zs9pCQ8QYQwH8mD5pDGM6qOflQyV6CiUTYep8Y+GOjGRdw5kyv7EtM6KjygObltf6vcw2YFMApCvsxD3eSvvugdHsQWuGO3Zo4aduVz/70kbimcvd/ZWOzitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhbIVvutcAbOrKWp8RWE8Z/bjPwzBNx8EDFG2MqN1ho=;
 b=mgeCRW2O0oFWlS/UuY7oPyGve544t0iW0EmIAeHv23QAoOuJedL7KpH9mPsk7SP3/U8JO0ooY+UBxW2cRwe4AcsXK3dEqMo4JrPhkryqLEe9fzZnKgNLHfQMNS1FxmgOqk89dRThTkd7g5wRcZdIDK3hLze+P4mbGWkSZ+z7KmNiJ57uOyqrceKehqcBF1RPjWZf/MvG012vPhYvCz9YLEx6ytlaEhC4bVfDlh/EPPZvd0IMNduwGv/NvbV2uUSMQFogR5fyOSNLfN0uZF/FvttCeGFwsy9wsxveY/jv97Ba+kzbzJgEaCwYuYr1UwoIYyPRVjTrwdTPK06txBn/Sw==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by VI6PPF74BC0D4B6.EURP195.PROD.OUTLOOK.COM (2603:10a6:808:1::112)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 05:45:40 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 05:45:40 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Jerome Forissier <jerome.forissier@linaro.org>, Tom Rini
 <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <Y.Varakala@phytec.de>, Jan Remmet <J.Remmet@phytec.de>
Subject: Re: [PATCH v4 3/3] doc: phytec: imx8m: Style and firmware update
Thread-Topic: [PATCH v4 3/3] doc: phytec: imx8m: Style and firmware update
Thread-Index: AQHcIZLnlyBd/QXT+0yTFC5GL51qv7SXh7eAgAD0EQA=
Date: Thu, 18 Sep 2025 05:45:40 +0000
Message-ID: <9248c1c20c37602d4494ff28e9a45e364978fa5c.camel@phytec.de>
References: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
 <20250909-imx8m-optee-enable-v4-3-6dfe494cc939@phytec.de>
 <0bec0b3b-bd14-4b26-99f3-a0df5e652ab5@linaro.org>
In-Reply-To: <0bec0b3b-bd14-4b26-99f3-a0df5e652ab5@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|VI6PPF74BC0D4B6:EE_
x-ms-office365-filtering-correlation-id: 35d2094e-22e9-4082-2e8c-08ddf6769a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?NkU1QmUwaXg3NFM1eHRySFJ3QjlkUVdNTDhDcUxHUzlXYk1ENWdxc2xjVU1i?=
 =?utf-8?B?cGhTYlh5NHh0cDhtVlZ0aWc5cWc1Q1Y0QzFpM2JGRC80d0NnM05QMUJxRnFm?=
 =?utf-8?B?NTJ5dFRJbUw1dXU3K1VlMDFXV0lvWG0vLzBkcGxIUlV2a0NjOVVRRzk2Wkg0?=
 =?utf-8?B?STFwWlU0eW9xWnFZcWhwOTZrWTZGbENPdWt6UGNrZG5sbVh3YnB3cU1oV3Zn?=
 =?utf-8?B?Z2R6K2Y0ZndDYXlCU25saXpMWFBrb0xQNkQ5R0J5Q2czVkhpbHMwaEkyeEk3?=
 =?utf-8?B?V2VkT3dJZy96UHFNb2t3VE5FVWpNVy9kOWNtU1pwVEIxRW1XNWtMUXlPbkg5?=
 =?utf-8?B?bDQ1ZGNMaURUTHRDVWVnaW5DY2srbjErcHUxeFlVRmxFWDdxV3J6TFQ2Uld5?=
 =?utf-8?B?WlIxaDVKdUpTN1NhYlBWVFkyT3NWU01SWXJSSTM5VHNtV0h5cTRSWkxDYkgv?=
 =?utf-8?B?V0ErZXdoM0ZrMGZNYTUzVDMxWGxOMzJLMXd5ODZyTE1jZTRXRnF4TkdOei8v?=
 =?utf-8?B?ZlFJMUZoRjE4VEtxcUgrd0gwcWpObmgwakhuT0ExdmgrSE5ManRTdWdpWHBR?=
 =?utf-8?B?elRvbXcydndyd3RiWkR6bWh3UGNVekFnMWtzUTNlN0tkem54R2Y1Vjgwd0Z0?=
 =?utf-8?B?SjhHZS8yUHRDaGsyQiswbXFuUm9reEplS2ZxVDlvRTJvVlNNUTJ2RjFFUDlT?=
 =?utf-8?B?ZVJ6WFdjR1E1Slh0YWFlY0MrR3Ewai9VZjV0ZGdUbGJERlZwTDV3aDZheGMr?=
 =?utf-8?B?VUNSR28vL041Uzg0TS9iUUh3Q0xMcloxN2d4NXdLOGJEUTFjQzV1ZmJEUjd6?=
 =?utf-8?B?OGFJVHRxalpoRWxZaEJrMG1EMTk3ZlpCTTNFUTgzbGdRWlVMYXFPeEV6b0E1?=
 =?utf-8?B?RWdQdC9Wa0lHMk45VWlsSHNxMHJHNU5vTFJ4VVo4TVJaUUp1Zi85SHdJR0p0?=
 =?utf-8?B?WTZteVA2V0JBTXpMaG5pMnRYaUlkbUx4RzJVczQzV0tPQ2hLQlFxdWdCay84?=
 =?utf-8?B?SmI5NVdpVHU3YkxpQmNNRzI2WDEzT3ZBVzl4TVdHakQrSUNtZmZZMzF3bHJ0?=
 =?utf-8?B?Y01wU1h4Z0JzZ205Vk94eVhESE8wRHEvMHBCK0kzMWZ0WHhjaWJLckhYSlRW?=
 =?utf-8?B?bTliY0FmYmZpaUo5aWNrVXZnTVFMMHFRd1R5VkUxcDh4a2J2VENvc0NCc2hl?=
 =?utf-8?B?bVkxWjdDdWYvNWtTRE5SdkxVRjlVdU9sc1Ryc0JicEhTcmI0R0tFeS8wd1NG?=
 =?utf-8?B?TzdFM2FqV0FTbldlb21Md29oMklabzBtaWpKMmpFQW55VU1TVmh0QUFkWDBT?=
 =?utf-8?B?bU55aytBNFlXMnQzL3BvUEpMTUREVUtLUkJKZHlwa2MxazRTUDh4WU1Renha?=
 =?utf-8?B?cWdpeG8rNUJ3MkIxZnZiczZBN3VYdGNHWDFadTU1L0NvQmlsSFBoQ1p5STY1?=
 =?utf-8?B?OXlSTEVMVzh6bnZGdWdnc0x2Q0dZRGI5c0ZHNStTNmlBKzZxSEV2SkdiTXN3?=
 =?utf-8?B?dE5rMnQzMGtVNko5SXovYWU0MUlIWWdWdzl6RWJldCs3QXFPZGVKRVZ0ME9E?=
 =?utf-8?B?a3NYSStvL3dLN0hlRGhGZ2dEZ0psNHFuSW0zOHJJUVdpcmNaeUJvVmVwZjhY?=
 =?utf-8?B?TGxrcmJ2NlljTXc2MGRuZXg3RUVFbThCMUpaZUtxWUVwSjJKU2h2VURITlNU?=
 =?utf-8?B?NGM2ajNJakVvL0xVUHFMMUNqU3JaU1d2NUpUNVlGakpBWXdxdmdWYkdHVEl1?=
 =?utf-8?B?eWZEUXo3dzFOZ2U0dHdZbXdBQVd5OEF5ZU5Fc1pudDIvNjE3YVZlRmJqQlNP?=
 =?utf-8?B?TSt6aFhjQ04ybzRSWnE3TlpQa3JaZ3Vzbk5FMVgrQ2VaMC9qSlFveGtrTzRa?=
 =?utf-8?B?MWE0empIUTFxNFBZL0Z2Y3hlc0NzblhPRjdqNXlDRkY3WERKTEFNZXRFSldQ?=
 =?utf-8?Q?XEuvZiuyR/U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEF2TWFidVNNektpUGVwS3B2dVkrTFlFdEdmMGh3TXE2K3VCanZqSXhKRmhF?=
 =?utf-8?B?TUNQV0kzS0lzNDRDdHRGYmh6OUNidDFRRXZNcDZ0RWtWME1TcE5haWFuWlVk?=
 =?utf-8?B?TXpaTmJzWm9SeHFYNmFqZFcwaWNpZ0NGcTgzdmpVR0s4bG1mK0c5YWxoU01h?=
 =?utf-8?B?R3BFM05RNzIzd1M5cVA3ZVlJZ1lwTFBiTzF2azRtNjlpei9aUmZRY1BDR1Mr?=
 =?utf-8?B?UGVrZ0l5UXY5aVNMalNHQjQvM25FRWdPMFR4Y3oxUlpQYlo0S0Qrb2NFSnBX?=
 =?utf-8?B?NUtoV2RIZWRFMTczYkNWQ1RPOGJwUWVrTVlsdWhIaitud3NqU2pQNVVEZ3A3?=
 =?utf-8?B?QVlwWExYTUo2eGFzQkdORG9URDdDUjl5ejNuNjhBNGpzekVyeitONEsvQWZD?=
 =?utf-8?B?aXRrV3BydDNyTlV3YkxnVVlNaEJxSWMxVkFCcnJBSlB6LzdUd3hlY0pMUHQz?=
 =?utf-8?B?L29jNVdkT3o1RmRTbUV2Vm1odUxaNDlmNHU2QUxmRmFSdU9Wc2FBK0tjZjZ4?=
 =?utf-8?B?RmxQSjY0cHFiMmd6ODFydU9xdGJNbUtEZE1ueTRndWFOb1FDSHdQOGlIYXhH?=
 =?utf-8?B?QjVwZXlacFJoRmYvV1puUE13N1UyYXZiOXRpMTVLWDhqcFFUcVhqMHRFczAx?=
 =?utf-8?B?VFJQTHd2MW81TTcxVmc2U3A0STR6U2pjQ3hYN0xTamZXR2g4SDhjMGlvak50?=
 =?utf-8?B?aW9CNk8wbGp2ZnEzU2ZGaSt2ZnpONVZVdVVmWEp2VnRqK0lmMmdHenR0SnFB?=
 =?utf-8?B?RFhrdE00OHdoRzl1bnQxblk5aW1xOFdGMFdVeU9BOEt2eXJvc2pWeEx6Rkc2?=
 =?utf-8?B?UnN0MGRUa2ZYYVhDYkgvRzl2ay8vS2hXa1k5SlFFcUhvNmRQdVBPYW1pM3lS?=
 =?utf-8?B?a0twSU5GUkVhR1dBaU5ReUlra1BvcEZkR2VyOThFTTRncENYQ1EzMEZMRjNr?=
 =?utf-8?B?UXM2QTN1Q3lhbGFTTDNFVURVb1JPYjJlYVI5K2hjcXA5dXBqU1lMNWE1NU9t?=
 =?utf-8?B?TFd6Z0NCeU9WZ1B4cnlzZTNBbU54ZDlVK2M5OXpaY1BGMnBVMmNBN29FZ25M?=
 =?utf-8?B?dyszR1ViTVh1aWxiQ1NaL3piT3lpZmdsMEJCTnhRa2tpMmkxb1I1WEJUVDhV?=
 =?utf-8?B?bE03aXY1V2hCWnZBcjAyNThoMUFuK0NianA4MDMzblJLa3V6UE95cVVmTDFy?=
 =?utf-8?B?RWlBa2Y1QXBTTzJVMlJWRkoxWDFvd2NzVkhsR0U4bmlGSXlwdXY3bkU3RHY1?=
 =?utf-8?B?dUFqS1JmdjlxWERmS2psUmJoaVJsN0hBRnBaeDVGZks2dG5CRUpMNStGaFpI?=
 =?utf-8?B?b1dQUlE1emxLNG93cXkzY3QvKzdvVnk3YThyQ3ZoM0xoODF4VGQ2VFZ4SUZR?=
 =?utf-8?B?TXI2VFE2QTBUL1NCSzM1T3BhSkZSOW1tVjRidXdoT3dQRlhudENZNHFoVjRG?=
 =?utf-8?B?dE5MRjFDdndSbHQ3amZoSmZHQUJXcEQzZ2Q4MHovRThJWDhqMjB4ejlzOVA0?=
 =?utf-8?B?R3FhOHpRSGNsTWRjUjRnNG1TMkRKR2d1WnhBSHgwNldENjBMbE1Zc01oSDlM?=
 =?utf-8?B?UmxydGx1NktWZE1DN0lMaFNFeUo0NWpaQng4TFRYOXRST0ovckhKTWs2ZzJk?=
 =?utf-8?B?c2oxTXh2ZVNuRmdaeGJjQnBEQ2hTcGZhcHYwdUVhMEx3SlR6NDFiSEpmeTNE?=
 =?utf-8?B?eWlUQTVpeUpoOXhXUUJlenpEL2Z4VXI4MTVGSFNSZFU0emtIdzhXR1oreEdn?=
 =?utf-8?B?T25JYU1oYW9ocjFJbGxUdGpyOTVyQWxLRTQyMCtLUTdMcitTLzNUdmFRcTUx?=
 =?utf-8?B?djRRajZNUmRIY1JuQ0JtcVdzaVdZRlhQVC9KSUJDZ1ltdnVHTUhPeEZ3VXdT?=
 =?utf-8?B?MWhoRUZSTDN6ZkV5S25qTGRXVGRWZW5BUTM4VEVGKzlGMVZ4VmpZNUFWVXVa?=
 =?utf-8?B?bHF3RjRoSE9Na1YvSlN2NlFOWDdpNWRSRTQ1cXdqanNHSlJlcVZsU1JnS3A3?=
 =?utf-8?B?ZXVhRGk5SHBHdEJ4NFFIVmVteWhVcnlkR1dJNUNZMXErTElaQTRhcTV1cDVJ?=
 =?utf-8?B?YUdicjhSNGEzaXhsWTFGOTdpQkJaQ2RNR0REajcybGF1cWNpQ0lMZW00Q0o2?=
 =?utf-8?Q?/MyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FEA0B7CCE370A4BA45F31CFDBAEAB54@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d2094e-22e9-4082-2e8c-08ddf6769a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 05:45:40.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AbxAXEMAG7l3nmDzYAIdue+8YM4XW2WNgrl0+Ri2SVxz8JKdivq7DUb4YQzEchufTmfLlWg3WNgK+gLWfN9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF74BC0D4B6
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

SGkgSmVyb21lLAoKQW0gTWl0dHdvY2gsIGRlbSAxNy4wOS4yMDI1IHVtIDE3OjEyICswMjAwIHNj
aHJpZWIgSmVyb21lIEZvcmlzc2llcjoKPiBIaSBZYW5uaWMsCj4gCj4gT24gOS85LzI1IDE2OjA1
LCBZYW5uaWMgTW9vZyB3cm90ZToKPiA+IFVzZSBzaW5nbGUgbWFrZSBjb21tYW5kIGZvciBjb21w
aWxpbmcgYmxvYnMgYW5kIFUtQm9vdC4KPiA+IFVwZGF0ZSB0aGUgaW14IGZpcm13YXJlIHZlcnNp
b24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRl
Pgo+ID4gLS0tCj4gPiDCoGRvYy9ib2FyZC9waHl0ZWMvaW14OG1tLXBoeWdhdGUtdGF1cmktbC5y
c3QgfCAyNyArKysrKysrKysrKysrKy0tLS0tLS0tLQo+ID4gwqBkb2MvYm9hcmQvcGh5dGVjL3Bo
eWNvcmUtaW14OG1tLnJzdMKgwqDCoMKgwqDCoMKgwqAgfCAyOCArKysrKysrKysrKysrKystLS0t
LS0tLS0KPiA+IMKgZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5yc3TCoMKgwqDCoMKg
wqDCoMKgIHwgMzQgKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPiA+IC0tLQo+ID4gwqAzIGZp
bGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZG9jL2JvYXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+
ID4gYi9kb2MvYm9hcmQvcGh5dGVjL2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0Cj4gPiBpbmRl
eAo+ID4gN2VmYzkzOTIzNjFiNGE4NjdjZTJiYzE4ZGIxMWFhY2YzMTIwODgwMC4uNGRkODJjZDk3
ODVmYTU4NWVkMjE2NjY0YTI1ZjU5M2Q0ZQo+ID4gNzIzZGJiIDEwMDY0NAo+ID4gLS0tIGEvZG9j
L2JvYXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+ID4gKysrIGIvZG9jL2Jv
YXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdAo+ID4gQEAgLTIxLDkgKzIxLDEz
IEBAIEJ1aWxkIHRoZSBBUk0gVHJ1c3RlZCBmaXJtd2FyZSBiaW5hcnkKPiA+IMKgCj4gPiDCoMKg
wqAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXQudHJ1c3RlZGZpcm13YXJlLm9yZy9URi1BL3RydXN0
ZWQtZmlybXdhcmUtYS5naXQKPiA+IMKgwqDCoCAkIGNkIHRydXN0ZWQtZmlybXdhcmUtYQo+ID4g
LcKgwqAgJCBleHBvcnQgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0KPiA+IC3CoMKg
ICQgZXhwb3J0IElNWF9CT09UX1VBUlRfQkFTRT0weDMwODgwMDAwCj4gPiAtwqDCoCAkIG1ha2Ug
UExBVD1pbXg4bW0gQkwzMl9CQVNFPTB4YmUwMDAwMDAgU1BEPW9wdGVlZCBibDMxCj4gPiArwqDC
oCAkIG1ha2UgLWogJChucHJvYykgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBDUk9TU19DT01Q
SUxFPWFhcmNoNjQtbGludXgtZ251LSBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIFBMQVQ9aW14
OG1tIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgSU1YX0JPT1RfVUFSVF9CQVNFPTB4MzA4ODAw
MDAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBCTDMyX0JBU0U9MHhiZTAwMDAwMCBcCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgIFNQRD1vcHRlZWQgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBi
bDMxCj4gPiDCoAo+ID4gwqBCdWlsZCB0aGUgT1AtVEVFIGJpbmFyeQo+ID4gwqAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQo+ID4gQEAgLTMyLDggKzM2LDkgQEAgQnVpbGQgdGhlIE9QLVRFRSBiaW5h
cnkKPiA+IMKgCj4gPiDCoMKgwqAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL09QLVRF
RS9vcHRlZV9vcy5naXQKPiA+IMKgwqDCoCAkIGNkIG9wdGVlX29zCj4gPiAtwqDCoCAkIG1ha2Ug
Q0ZHX1RFRV9CRU5DSE1BUks9biBcCj4gPiArwqDCoCAkIG1ha2UgLWogJChucHJvYykgXAo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0gXAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBDRkdfVEVFX0JFTkNITUFSSz1uIFwKPiAKPiBDRkdfVEVF
X0JFTkNITUFSSz1uIGlzIG5vdCBuZWVkZWQgYW55bW9yZQoKVGhhbmtzLCB0aGF0IGlzIGEgcmVi
YXNpbmcgbWlzdGFrZSAuLi4KCllhbm5pYwoKPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIE89
b3V0L2FybSBcCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQTEFURk9STT1pbXgtbXg4bW1fcGh5
Z2F0ZV90YXVyaV9sCj4gPiDCoAo+ID4gQEAgLTQyLDkgKzQ3LDkgQEAgR2V0IHRoZSBkZHIgZmly
bXdhcmUKPiA+IMKgCj4gPiDCoC4uIGNvZGUtYmxvY2s6OiBiYXNoCj4gPiDCoAo+ID4gLcKgwqAg
JCB3Z2V0IGh0dHBzOi8vd3d3Lm54cC5jb20vbGdmaWxlcy9OTUcvTUFEL1lPQ1RPL2Zpcm13YXJl
LWlteC04LjIzLmJpbgo+ID4gLcKgwqAgJCBjaG1vZCAreCBmaXJtd2FyZS1pbXgtOC4yMy5iaW4K
PiA+IC3CoMKgICQgLi9maXJtd2FyZS1pbXgtOC4yMy5iaW4KPiA+ICvCoMKgICQgd2dldAo+ID4g
aHR0cHM6Ly93d3cubnhwLmNvbS9sZ2ZpbGVzL05NRy9NQUQvWU9DVE8vZmlybXdhcmUtaW14LTgu
MjgtOTk0ZmExNC5iaW4KPiA+ICvCoMKgICQgY2htb2QgK3ggZmlybXdhcmUtaW14LTguMjgtOTk0
ZmExNC5iaW4KPiA+ICvCoMKgICQgLi9maXJtd2FyZS1pbXgtOC4yOC05OTRmYTE0LmJpbgo+ID4g
wqAKPiA+IMKgQnVpbGQgVS1Cb290IGZvciBTRCBjYXJkCj4gPiDCoC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+ID4gQEAgLTU2LDE1ICs2MSwxNyBAQCBDb3B5IGJpbmFyaWVzCj4gPiDCoAo+ID4g
wqDCoMKgICQgY3AgPFRGLUEgZGlyPi9idWlsZC9pbXg4bW0vcmVsZWFzZS9ibDMxLmJpbiAuCj4g
PiDCoMKgwqAgJCBjcCA8T1AtVEVFIGRpcj4vb3V0L2FybS9jb3JlL3RlZS1yYXcuYmluIHRlZS5i
aW4KPiA+IC3CoMKgICQgY3AgZmlybXdhcmUtaW14LTguMjMvZmlybXdhcmUvZGRyL3N5bm9wc3lz
L2xwZGRyNCouYmluIC4KPiA+ICvCoMKgICQgY3AgZmlybXdhcmUtaW14LTguMjgtOTk0ZmExNC9m
aXJtd2FyZS9kZHIvc3lub3BzeXMvbHBkZHI0Ki5iaW4gLgo+ID4gwqAKPiA+IMKgQnVpbGQgVS1C
b290Cj4gPiDCoF5eXl5eXl5eXl5eXgo+ID4gwqAKPiA+IMKgLi4gY29kZS1ibG9jazo6IGJhc2gK
PiA+IMKgCj4gPiAtwqDCoCAkIG1ha2UgaW14OG1tLXBoeWdhdGUtdGF1cmktbF9kZWZjb25maWcK
PiA+IC3CoMKgICQgbWFrZSBmbGFzaC5iaW4KPiA+ICvCoMKgICQgbWFrZSAtaiAkKG5wcm9jKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBDUk9TU19DT01QSUxFPWFhcmNoNjQtbGludXgtZ251LSBc
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGlteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmln
IFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgZmxhc2guYmluCj4gPiDCoAo+ID4gwqBGbGFzaCBT
RCBjYXJkCj4gPiDCoF5eXl5eXl5eXl5eXl4KPiA+IGRpZmYgLS1naXQgYS9kb2MvYm9hcmQvcGh5
dGVjL3BoeWNvcmUtaW14OG1tLnJzdCBiL2RvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS0KPiA+IGlt
eDhtbS5yc3QKPiA+IGluZGV4Cj4gPiBiYTYyOTlhOTY4YWU5OTgwZDU4M2I4N2I0NmRjY2NiYTVh
YTRhMTg2Li5kNWVkYmM5MTQ3NGU5NWY2NzdkZDEyZTVmY2M2YzE2MDkyCj4gPiBkZWExY2QgMTAw
NjQ0Cj4gPiAtLS0gYS9kb2MvYm9hcmQvcGh5dGVjL3BoeWNvcmUtaW14OG1tLnJzdAo+ID4gKysr
IGIvZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtbS5yc3QKPiA+IEBAIC0yMSw5ICsyMSwx
MyBAQCBCdWlsZCB0aGUgQVJNIFRydXN0ZWQgZmlybXdhcmUgYmluYXJ5Cj4gPiDCoAo+ID4gwqDC
oMKgICQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0LnRydXN0ZWRmaXJtd2FyZS5vcmcvVEYtQS90cnVz
dGVkLWZpcm13YXJlLWEuZ2l0Cj4gPiDCoMKgwqAgJCBjZCB0cnVzdGVkLWZpcm13YXJlLWEKPiA+
IC3CoMKgICQgZXhwb3J0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtCj4gPiAtwqDC
oCAkIGV4cG9ydCBJTVhfQk9PVF9VQVJUX0JBU0U9MHgzMDg4MDAwMAo+ID4gLcKgwqAgJCBtYWtl
IFBMQVQ9aW14OG1tIEJMMzJfQkFTRT0weDdlMDAwMDAwIFNQRD1vcHRlZWQgYmwzMQo+ID4gK8Kg
wqAgJCBtYWtlIC1qICQobnByb2MpIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQ1JPU1NfQ09N
UElMRT1hYXJjaDY0LWxpbnV4LWdudS0gXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBQTEFUPWlt
eDhtbSBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIElNWF9CT09UX1VBUlRfQkFTRT0weDMwODgw
MDAwIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQkwzMl9CQVNFPTB4N2UwMDAwMDAgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoCBTUEQ9b3B0ZWVkIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAg
YmwzMQo+ID4gwqAKPiA+IMKgQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkKPiA+IMKgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiA+IEBAIC0zMiw4ICszNiw5IEBAIEJ1aWxkIHRoZSBPUC1URUUgYmlu
YXJ5Cj4gPiDCoAo+ID4gwqDCoMKgICQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1U
RUUvb3B0ZWVfb3MuZ2l0Cj4gPiDCoMKgwqAgJCBjZCBvcHRlZV9vcwo+ID4gLcKgwqAgJCBtYWtl
IENGR19URUVfQkVOQ0hNQVJLPW4gXAo+ID4gK8KgwqAgJCBtYWtlIC1qICQobnByb2MpIFwKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIFwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQ0ZHX1RFRV9CRU5DSE1BUks9biBcCj4gCj4gU2FtZQo+
IAo+IAoKClsuLi5dCg==
