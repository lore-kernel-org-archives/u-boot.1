Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7336FD0E3F3
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 19:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1C588FAB;
	Thu, 24 Oct 2024 21:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=al-enterprise.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=al-enterprise.com header.i=@al-enterprise.com header.b="PJyS5QZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DC788E90; Thu, 24 Oct 2024 16:58:06 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CADD88995
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=al-enterprise.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=girish.kumar@al-enterprise.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYs5Tmootk/L1U6gVbtM4AOsKb+Olz4qP6ObeIOzk8RIYWyC0ijRTGhwzMDomQdLh+po4GYhuxYWXUSxeNvt13soMrQ//ke70p/svO4GA25GKNzSl8GzMs48n/Gp51L83IBdrdsBVxnyLnDTefLl4qvm6IqjojPTsXmDCIoayd824eK1z9quIoGsFiTPOf8jSL42skvWgCHZwleSgnlHkeyDdYeTuy+mV8wuoGQLehZP/yHRzg9T6xq9/4ce/e5rjdBsUvVy50sOvOFkyDkkepLs0z8vba+AFV8BSUlKXyyg73ENK0OO/SGcWNO55TXpYJuChAnY8srlghHM9QvHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT1dVY9o/fcCp0t0MDZlKuosaAH1AfPcWAmn2ZiboAs=;
 b=JtOMYgFqRioRf+V10C2wTslBlbpkpUA194DDchMqnXK3GsajyMGDfPwPGgRPaH1iCWjNkWG3jUZLhcgPeMyp/RMMmeCvNIFj3l5iqGw6rqOkMeQ7/co31zgmeKWWbP4cD5ijjvXNPG0bL9MxCpXcvX9IMVaoxcBdcjsA/mwQzDn3/h62sSedN0C+qgvhl7KcUwkvbbcBk7KqHgej5ya6bUfQFSqalLO/qlTJsiKsFPo767Ep76TqdkV7L0b8m8d9aSLuJWayV1AGouj8Lvnceyb5p4ryxfH+P2EeVcYVVJUzFUJSlQI9/34ajLoFxq9g3ChsndSZ6ToyI7WPFi0Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=al-enterprise.com; dmarc=pass action=none
 header.from=al-enterprise.com; dkim=pass header.d=al-enterprise.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=al-enterprise.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT1dVY9o/fcCp0t0MDZlKuosaAH1AfPcWAmn2ZiboAs=;
 b=PJyS5QZTMTn2fwHE/AUeD8XSWnfo0a28hW2VMuk3j11npQWte6zYYerrox1E36mb6wEhtJiz8zR0jBZrlUZj232NrcpJMzRzRxk8eJnikMGIyTx71foAOqem80LnuwpdZQG+zW5RXEVnmo+B9S3hha54ttrc8bLuLIZzDRDjItE=
Received: from AS4PR08MB8167.eurprd08.prod.outlook.com (2603:10a6:20b:58e::16)
 by VI0PR08MB10709.eurprd08.prod.outlook.com (2603:10a6:800:206::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 14:57:42 +0000
Received: from AS4PR08MB8167.eurprd08.prod.outlook.com
 ([fe80::2da2:6fd5:19ae:5f73]) by AS4PR08MB8167.eurprd08.prod.outlook.com
 ([fe80::2da2:6fd5:19ae:5f73%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 14:57:42 +0000
From: Kumar Girish <girish.kumar@al-enterprise.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: EXT:  Re: Patch for 2018 u-boot : Fix "EHCI timed out on TD -
 token=XXXX" error on ehci-hcd
Thread-Topic: EXT:  Re: Patch for 2018 u-boot : Fix "EHCI timed out on TD -
 token=XXXX" error on ehci-hcd
Thread-Index: AdslZ7yOimV/I94/T7SDOm7sLs0d0AAiDW+AAA0Y7SA=
Date: Thu, 24 Oct 2024 14:57:42 +0000
Message-ID: <AS4PR08MB816759780973DAA85256D034C04E2@AS4PR08MB8167.eurprd08.prod.outlook.com>
References: <AS4PR08MB8167C4DB165AF2FB28C0751DC04D2@AS4PR08MB8167.eurprd08.prod.outlook.com>
 <CALeDE9OCPGb9PK9evm=8bQyV9fWHrHd0TuOA6BSufT5mZLiX9g@mail.gmail.com>
In-Reply-To: <CALeDE9OCPGb9PK9evm=8bQyV9fWHrHd0TuOA6BSufT5mZLiX9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=al-enterprise.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8167:EE_|VI0PR08MB10709:EE_
x-ms-office365-filtering-correlation-id: 6145219c-d129-43e7-1902-08dcf43c367a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2Y2N3h6R2lWbEU5TWxzL3lMaUxZMk9reDNZVk9SQ0ZPa1J6VkpjUFFybENV?=
 =?utf-8?B?WUdVY3d2dEpQNlZtcXk5cUpwOW1iQlgweDlRV3cyTTJWek1jK0dWNDFQZGRR?=
 =?utf-8?B?Q3NSV0lCWnp0dkx3KzJyQjNTY20yN0JRaHlHOFZiQnVtVkhyMUs1Tm1OWUNm?=
 =?utf-8?B?OHdZQUV0K1RZVjdXdHhjQXdJdkdqTWVTT1Q2VGZVWVFTSmQ5NUJQMytnMk9v?=
 =?utf-8?B?eFZGeHRSZHNzeHdrb1ltTkNLOCtnWDBrMWRONTZ6ZVV5djdpOUlDOHVWMGRJ?=
 =?utf-8?B?MTI5OVdUekdScElkWGwvbWdURVpPU0ZvNzNDWHFzMzJiTXRuL1RWU0c5T241?=
 =?utf-8?B?c1BJYkdvamxWSWVVbjNMdFBUaUU1b3dQNk5FTURERDlsMy9mNGdHdWpvMzRL?=
 =?utf-8?B?Y0NJWjFOSURSRjkxZHdZc1UrdCtKanRMc0xJclI0NUtKU2h2R25DSG9TQmVp?=
 =?utf-8?B?ZWNnTThZNFZJYXhORHFHazhEYm55Ukx1V3IzSzhLcXIrSTlnVWtzZ1ZDZjNR?=
 =?utf-8?B?Q20vS0NrQnQ0T3JmZ1U2V0pYbytiR2xiT290Yy9Hbk5kcWhDQWErSUxxVmhr?=
 =?utf-8?B?SUtGdHBqeUxWa0VudTZ2SURxYkp3SFJBV0Flb0FneUJZVFllVUl0TmdPSjBP?=
 =?utf-8?B?NGVnSERTYk9tMk1uT2g3WVRteDBrR2tyRENlOU8wZFdlbzVhNEdOa3lnTTJz?=
 =?utf-8?B?YWY5MHhvazB0UUpOcmpQdHIrVGpsZlJGQThXNzEvUFB4ZmxFRXgxTk1URERo?=
 =?utf-8?B?TnZqeUwrTGpXcTFQVE1qTTFrNm9SSDBUSERVcHpNN29IT1VJTHoySFEvd1ZN?=
 =?utf-8?B?RUxPdTJibXFSa01PWG9JVUo4bkQ4cHFCQ0s1QnZrVzg4eUw2ZjdJcEMxa0VR?=
 =?utf-8?B?ZzgvRnJrK3YwMUxIZjdzZU9pUThpUDBNNFppTnFHSUVNR2tFRUlwckRYWk9C?=
 =?utf-8?B?eEtxVTFlbFlpQVdmUStRZ2wxZXQ1d1NseVJ0OW0xQ092TVU0QmZVdG83eFZ3?=
 =?utf-8?B?TzlZaHZpTlRlYUxHYTVhdzdDaVgxUnByVnJCaW1FeFQ0OGpYVnJaU1R2RlBo?=
 =?utf-8?B?K2xVRlFJWmp2Q1dEYzlNUStGejJDbUFVcFlQaGVFOG9US3VSRzZoQ0Z4RjJZ?=
 =?utf-8?B?c0E2Z3ZLN0E2cGZ2aXk2OFZmT1I3enFxeVF2YWh6OUZvUHl1MzR1eDkyQWdF?=
 =?utf-8?B?cXRGT2ovK25vVUZxMTZKMDUvTGE0V0dVUDFHa1RVNzdWZWgxSnQ0TGw5RHZE?=
 =?utf-8?B?b0txMmtTTWNuVWxuL2E4TVMvOWR6cXMxSHd3RkQ4RzE5UHFHRzBZM2ZpZUl0?=
 =?utf-8?B?eDFMbk41ZzlaRTFPclZUZW54ZFdUeWU3MkZ6dFBtMEhSV290SzRSajNJeWdF?=
 =?utf-8?B?OHU0UGpwaDBlMDVpU0VObE5HUllpZHFVa2xmcXd2NTJtQVVsMDM3Tis0QXgw?=
 =?utf-8?B?WGdvN0JwSkE5R2RWRjlBdk1VVTlNUFo3dVVJUUxNcGc1cUszM2hBa0JpZzZQ?=
 =?utf-8?B?eFRzdXJDOHhWOHhyTXpKU0pvVU5RTUErNG16SXZOUWxoRmZ4N1Q1ZmpFbUNH?=
 =?utf-8?B?VWNES2gzV0ErUHlBUW1SZi9qei81b2ZESzFxbU14bG4yUWoxUVdKMW9xTGNI?=
 =?utf-8?B?RWJyQ2Z6Nm53d2FaaTQ1YmhMTU04MUhXNWZUUkdDb1lCSS91ZWZEVmYvZThl?=
 =?utf-8?B?OHFXVXo4TkNWeGJLbCtnYWorcDFkU1c1ZytUajVwWSs2VjJoVlNLbFVtN0ow?=
 =?utf-8?Q?4zJhX0QlmaAl9eT4YkRz175uH9dhuKpF6vwgrwp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR08MB8167.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG5DeURaMmNXS0R1L08yMTB5aTEvMzNuam5MWXBmZk54NmtCSzA4R0FvSURL?=
 =?utf-8?B?RzY3ZHRETmJpNDdRUk9VQlNwZTc4NUw1aVpKTTI2WE1DcWlKNmowcER5S3U3?=
 =?utf-8?B?eVpvWU5vNWM4RmVoMjEyTXA2SHFHblpPa3VUZVp5czFkVW1hYVhtUGdLSVdV?=
 =?utf-8?B?RWFLbWkxd0xMZEQ4WlZiR1dsVnh6OGhaZlNSci9IY2toaHhNTU1MVndwZXZu?=
 =?utf-8?B?SG9jSVB2V3RYNG9ScWlTSEllVTBGTmQ2Mm1tZUVNLzNaU0FuRE8xYXRSWnhz?=
 =?utf-8?B?Mlhld3JId3hVek9GZ3RuUEVTK3NuQWlodXZDWnBudjRxTnlZY2ZFcTV3aGNL?=
 =?utf-8?B?SmlLb1V6b1ZscGJ6eHVOY0ZxR0ZOZHIyTmRDL3ZSTXpTUjBBUEFwUFVnOXFs?=
 =?utf-8?B?UVZFMm9JQ1NFam5EM2pPaFdLMVoyRlBnMjlEbWVFSkhSU2NleW0xa0hrZHNG?=
 =?utf-8?B?d2dWUTZXcWFodXQrRER2Qm1EMmxORThTRVhkdS9MWVdOQ3dITDNwOENkL0Nq?=
 =?utf-8?B?WUZZK1ZTWndvZkpBNFR6Z3cxWDZPL3c4Zm5zVkFGNmdWbHZtRTdDWENxM0s2?=
 =?utf-8?B?VVhWSmVXUkoreittVU9CbXdHV2UxMmM2eTFrM2JDemRxaXdNbjF1Zll1YW9G?=
 =?utf-8?B?WDg0RjlaL0p0NTMzTDZXL2l1TjBKM1RrcWsyRXdRMGR5Um0xRnZydW0xZ2c1?=
 =?utf-8?B?eUNBNUxLb1FRV3RtVFBvOGxwN01DbklnMkRhTkUySllZb1lUREVVTlNjYjdO?=
 =?utf-8?B?dzdCY3orRmhVNzk0Qjgwb0d5aTc5dEt4YlB2YmhSaTFMcStzNTBKN24zTlJR?=
 =?utf-8?B?Z0phSDE5VTFvK29jc1FJS3FSdHJyTE5KaEU0NFdlMVNDMTFNbFFlNnArTWpr?=
 =?utf-8?B?bFlEZC84YWJWT0NJa01mOHJ2a0djR3FLU21pY1pSa3V1VlpIbGdvekFOT1Az?=
 =?utf-8?B?R1RFT2orY3FkMGIwdzAvLy9veXZSc2FzMWI3clIyZ2p2MlRRMngyZmhBQ3Fp?=
 =?utf-8?B?bUx4QWtORDdFVzVkQmZlRDFCZGNmWUYxK05xdUVIUUY2Ti9tK2YzU2RVOXNG?=
 =?utf-8?B?YkhxSGo1VWpLWDdlbWE3SC9vTHpXUW1OL2pOa0dIbkJldUlYMWZ1S2ZpNXVs?=
 =?utf-8?B?bk96aTVrWEI2N0tLWERLVkFoTDFWVXpjUTk2RTU4MnpNOGp1MG13UFg4cUxl?=
 =?utf-8?B?MXdreUUvSFV2SG1remNpU203MFFESS9LdXJpK2lQT2ovck9vNGFmdjAzUVNH?=
 =?utf-8?B?RktYUVZOT0ZXbERYSzVjMGpld2E3aHZpQXpxUnFicXFDUnd2L2Z1cmxoUi9K?=
 =?utf-8?B?dDlaRm9QZVJmMFpUM1Z1RG83aERXWExyY2NSZ0daWkZJWFRYa2ZzUjFkRnRF?=
 =?utf-8?B?UmJmTUQyRG5JbjBMN1paNkFuR2tzU2NReTF6ZlhQRGlsU1B2cUx1WW5DZUg4?=
 =?utf-8?B?N09rdkh3QVV6azJ6SWFqOVB5NTB5bXZ1QVR4L3RGSmVTSS80K2JIMCtJMXkv?=
 =?utf-8?B?Qll0NFFFSlVJRHZMNTR0OGhYbVBaVk5QbVRmYVIwVk1xdGVEQ1gvdnllY1B4?=
 =?utf-8?B?eE81TVFwNTBteWUxdU1uVkpCT3FtYzF4M0NiZ203L2l6MWw3a21nTUFaenpz?=
 =?utf-8?B?VktNcTJnNGN4Sk84MHZmYlBWSHBDcTFJZkpoTFU1UnpVSFgvTmdybE0rQmF3?=
 =?utf-8?B?K1ZzQmIrVU43R250TVhkblVjcXdZMVdINW9UcUE4T3ExbVIzd2JGakpzTDRV?=
 =?utf-8?B?anU1OGVpayttYStNbTR1c3ZrMXl4QmMzYm5qVFplcmpmc3lDK0w2ZWVmaVpa?=
 =?utf-8?B?M3d6UnhCUzU4TktVV1crSVJtTkdJb3dNOGRYczFsVkxQS3ZVbXpTQmpvbURD?=
 =?utf-8?B?TnVqcVBIRzdXYzJGc2VLWGhoVDdZTmpsSmtORExkUHZCTEhrRzVGcHdyL2ht?=
 =?utf-8?B?L0RtTVZRU21mbDFoTUFZRlphTUVMa3RaVmJ6NGkzNHAraGU5dFFwZnR0S1VU?=
 =?utf-8?B?Z1BtVWRzU3FVcExVQWNpOFFIdGdCN1BULzNycHNmVjVwbVdZeWM0SHJ2dm82?=
 =?utf-8?B?Mjl4VHlmMGFxZ3l1RTZ6YmowcXJ3MDV1M2QzRHVhV20wRVJYL2hpUi9TZ05y?=
 =?utf-8?B?NHB4MjJSdFNQdE9ScVl6OFdlbHRVaUdqeFpQMkRxSEtSS256aHQyVDhCdTcz?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: al-enterprise.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB8167.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6145219c-d129-43e7-1902-08dcf43c367a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 14:57:42.8755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e410eb7-628b-4a1c-ab28-642f4be058a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2PuHwMr6b1fTbDKMfe1GouuX1+d/QUXzu5aebaFiBBx2GTno79/BCt21Ua1o4PGnsp3itVfOCuZOdkDl26iLECaGkGZtWIftP5l57NYwIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10709
X-Mailman-Approved-At: Thu, 24 Oct 2024 21:39:34 +0200
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

VGhhbmtzIFBldGVyIGZvciB5b3VyIGhlbHAgYW5kIHN1Z2dlc3Rpb25zDQpUaGlzIGlzIGZvciBt
YXJ2ZWwgQWxsZXljYXQtNXggd2hpY2ggaGFzIGFybXY4LiANClVwZ3JhZGUgaXMgbm90IGFsbG93
ZWQgd2l0aG91dCB0aGUgYXBwcm92YWwuIA0KDQpSZWdhcmRzLA0KR2lyaXNoDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQZXRlciBSb2JpbnNvbiA8cGJyb2JpbnNvbkBnbWFp
bC5jb20+IA0KU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjQsIDIwMjQgMjowNyBQTQ0KVG86IEt1
bWFyIEdpcmlzaCA8Z2lyaXNoLmt1bWFyQGFsLWVudGVycHJpc2UuY29tPg0KQ2M6IHUtYm9vdEBs
aXN0cy5kZW54LmRlDQpTdWJqZWN0OiBFWFQ6IFJlOiBQYXRjaCBmb3IgMjAxOCB1LWJvb3QgOiBG
aXggIkVIQ0kgdGltZWQgb3V0IG9uIFREIC0gdG9rZW49WFhYWCIgZXJyb3Igb24gZWhjaS1oY2QN
Cg0KDQoqKiBFeHRlcm5hbCBlbWFpbCAtIFBsZWFzZSBjb25zaWRlciB3aXRoIGNhdXRpb24gKioN
Cg0KDQpIaSBLdW1hciwNCg0KPiBJIHNlZSB0aGUgZXJyb3IgIiJzY2FubmluZyBidXMgMSBmb3Ig
ZGV2aWNlcy4uLiBFSENJIHRpbWVkIG91dCBvbiBURCAtIHRva2VuPTB4ODAwMDhkODAiDQoNCllv
dSBkb24ndCBtZW50aW9uIGFueSBkZXRhaWxzIG9mIHRoZSBkZXZpY2UuDQoNCj4gRnJvbSB0aGUg
ZGVueCBzaXRlLCBJIGZvdW5kIHRoZSBiZWxvdyBwYXRjaC4gQnV0IGl0IGlzIGZvciAyMDE2IGFu
ZCANCj4gMjAxNyB1LWJvb3QgdmVyc2lvbiANCj4gaHR0cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVy
bWFpbC91LWJvb3QvMjAyMC1NYXJjaC80MDE3ODQuaHRtbA0KDQpTbyB0aGUgcGF0Y2ggbG9va3Mg
dG8gYmUgc2VudCBpbiAyMDIwIHNvIEknbSBub3Qgc3VyZSB0aGF0J3MgY29ycmVjdCwgYW5kIGxv
b2tpbmcgYXQgdGhlIHRocmVhZCB0aGUgcHJvYmxlbSB0aGUgcGF0Y2ggaXMgdHJ5aW5nIHRvIGFk
ZHJlc3Mgd2VyZSBmaXhlZCBhbm90aGVyIHdheSBhbmQgdGhlIHJlZmVyZW5jZWQgZml4ZXMgbGFu
ZGVkIGluIGxhdGUgMjAxOS4NCg0KPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbWUgdGhlIHBh
dGNoIHdoaWNoIGNhbiBiZSBhcHBsaWVkIG9uIDIwMTggDQo+IHUtYm9vdCBUaGFuayB5b3UgZm9y
IHlvdXIgc3VwcG9ydC4NCg0KSXMgdGhlcmUgYSByZWFzb24geW91IGNhbid0IHVzZSBhIG5ld2Vy
IFUtQm9vdD8gVGhlIGxhdGVzdCBpcyAyMDI0LjEwLg0KSGF2ZSB5b3UgdHJpZWQgdGhhdD8gTG9v
a2luZyBhdCB0aGUgdGhyZWFkIEkgc3VzcGVjdCB0aGUgcHJvYmxlbSBpcyBmaXhlZCBpbiBhIHZl
cnNpb24gbGF0ZXIgdGhhbiBsYXRlIDIwMTkuDQoNCkdlbmVyYWxseSB0aGUgVS1Cb290IGNvbW11
bml0eSBpcyBoYXBweSB0byBoZWxwIHdpdGggcHJvYmxlbXMgYnV0IGl0J3Mgbm90IGEgZnJlZSBw
YXRjaCBjb25zdWx0aW5nIGhvdXNlLiBHZW5lcmFsbHkgeW91J3JlIGV4cGVjdGVkIHRvIHRyeSB0
aGUgbGF0ZXN0IHJlbGVhc2UgYW5kIHNlZSBpZiB0aGUgcHJvYmxlbSBzdGlsbCBleGlzdHMgdGhl
cmUsIGlmIGZvciBzb21lIHJlYXNvbiB5b3UgY2FuJ3QgbW92ZSB0byB0aGUgbGF0ZXN0IHZlcnNp
b24sIGJlY2F1c2UgaXQncyBhIHZlbmRvciB0cmVlIGZvciBleGFtcGxlLCB5b3UncmUgbGlrZWx5
IGJldHRlciB0byBnbyB0byB0aGUgdmVuZG9yIHRoYXQgb3ducyB0aGUgU0RLIGZvciBhc3Npc3Rh
bmNlLCBlbHNlIHRoZXJlJ3MgYSBudW1iZXIgb2YgZ3JlYXQgY29tcGFuaWVzIHRoYXQgb2ZmZXIg
cGFpZCBjb25zdWx0aW5nIGZvciBVLUJvb3QuDQoNClBldGVyDQo=
