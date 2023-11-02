Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BA6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7198D8761A;
	Thu,  2 Nov 2023 08:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="XI6uRBft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C00487620; Thu,  2 Nov 2023 08:17:59 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89F0875AE
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aleksandar.gerasimovski@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffjE5DzT2ZWjcQiOYJDZ2c3/DuUSrVoLhS7vwuhKLzmKjtlMfkcerZzhGbWAXuO2pXaHqrmVz5p2/js2ZiAK6oRm1mkz9Xhamohgk4xv1D2iXvBDLOvtkeBKlm5sJYdLnV0MWcyl0sNYEdgcqwNbyRZWWExUT8xbVFPyk57DbLnYFpsOCRZKzyQmVYeegPvlzh4p+/YrTwCgsDLy6BjLoDT4j55goKV+1nLLqrV2rcZsPjrKPTPr/JqXabs/3CdqYeWbmMA5egkqdyh4Hr4pFK7NgYxvw3cy2kyTz7cGAILcqiht6HOPNio7pCHQQd35mWSMde7MXHK8LJ3b9pAl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyU9V0oyW3bAnB4aemirsrmwp//iMUy8L6kTYRjpvXg=;
 b=nzoBxBupec14CcgqH6eZghd0JAfSAoxmBkFV6zj4QiNH6DnD62cAf2HavNgwV6kTwGIYqEmFUAKML6RDyxnQ0i1uJqz/SFmDcrGkHiF1ckM9TWUYTnS/RAelzcaZr3ul1P98Z4NDZJmeDSEKXgHw6BFwLJVnuXuIfLnqYwm/GRTdrbSHnAIURAo/ieUPc3iGDO06+1bXpWGPCkGEKqmpRXRX1yTb7aN7ODuzE2NTNdBoHRpJOzXChxKTLmzqVZXOzCLRQM5OXrjfc+60mEXJaD5Vs/uWooNl0Q+l6ito0t2xK6KnCJ4YjViZNN0387xTO4pOZrz4CiulY6NMK91pLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyU9V0oyW3bAnB4aemirsrmwp//iMUy8L6kTYRjpvXg=;
 b=XI6uRBftIlVmHN/xXK5E2VF/YMza8H3apt2bOqYCpvc1zK2TTn3tECPdbvQu8yPC2XWTtaoBQTo6RVAlabmQiwbfg+FMO+Pu/ukFI1iqrbvnGpqpmVWl41OPd/9uiOEYcp6/+9D4whlGJPfV02P887pgh2zcsHvk+ZPzJFDc//vdwxwFm+0pG5ON359xvaPN6eesryI9YAS55eAwl5NZiAsiDpxsh1XMiyq95dUvELMNjARvHemFtSseA0229DeR0mtTPkpv+YknDyPXu8JoVFJ4gYkm6qvYUVBW72hH7ZYMOPEvKcPwFxRbPhw1NYtWIP8s3WIQCpsjB0Dlw8lP9Q==
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI1PR06MB6559.eurprd06.prod.outlook.com (2603:10a6:800:124::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 07:17:53 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::1596:e79b:5de8:e482]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::1596:e79b:5de8:e482%7]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 07:17:53 +0000
From: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 11/20] pg-wcom-ls102xa: Include <config.h> in the board
 file
Thread-Topic: [PATCH 11/20] pg-wcom-ls102xa: Include <config.h> in the board
 file
Thread-Index: AQHaDOB3Pydol5nmcUalTyE2rUFsh7Bmn1Bg
Date: Thu, 2 Nov 2023 07:17:52 +0000
Message-ID: <AM9PR06MB79074A6E9FF8F6F48AFB0C99E9A6A@AM9PR06MB7907.eurprd06.prod.outlook.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
 <20231101162824.3755579-11-trini@konsulko.com>
In-Reply-To: <20231101162824.3755579-11-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 8.28.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR06MB7907:EE_|VI1PR06MB6559:EE_
x-ms-office365-filtering-correlation-id: 7affd8db-2e05-4b2b-59ea-08dbdb73d428
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLUV4h+EoLPEuEDLq3UIcOg/ub2D3lDKON02yfmfE5sDRAwhm1P9JC8uLREP42D35mZgFf5wd491uP/M1TPiPHGksqKv6I6VQRTT+acdGALgt1NaCL8ggDgIM6M/lxJOELOGxTOXg7P+OqXloPJzQQqngZiWqiT+GQCS+E6XthPEh+5rcp3OR25xBZAGlW3nKwem4KBXmCCSp+TE4HdUZeCq7Bo2YLciMoaRC0XuNA1Z030b1abHTLcrK8ejZRyqjBSfkl0tSwjkNmhUsytrfL+NY1TKNcgH3Rhqtt+OB2l5UPUAVluMytODgVRixWacOpzCm2CdekBPEIVmtgn/EbSE9TAKJ747VrfJcYa53wO02fgxAFThLFCn724DwFQTLzn1dnHJ+UUnlrt/HpwxAu4wLREpc32WhrVY1VGoyEj0TgiU3vWxuZTje4c7BuaNTquQlGLUceckm2oHKMsuP6QvvUhDg9UFRqi7RO/iQj4Iar2l6sX1txzeO2APh/afDfnNQYnKqOW7J+xfgPluOmSaJahKUqlzlxpIHS18NISztVP+pTj+h3y7nQyCZRHHW+N1Ewp5aKSX9KVPNi1Jn9rcO2dI9Tgui8b6wDXc4rfSAFAtEnLiQZ3s/Qu7sUwDgaS2v2DQ9G8bX6ajTvIeJLspQ8yoXDnKJBtDcGo/C3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR06MB7907.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(33656002)(55016003)(110136005)(8936002)(7696005)(8676002)(316002)(83380400001)(6506007)(26005)(38100700002)(71200400001)(52536014)(66446008)(66556008)(478600001)(9686003)(53546011)(66476007)(66946007)(64756008)(76116006)(45080400002)(44832011)(122000001)(2906002)(86362001)(5660300002)(82960400001)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUIvWHk0MWNiZWdGR3MyTXVhMFBLWUtueXNuVnlkQjZnczZPallWMjFQVjRJ?=
 =?utf-8?B?VUpEb01GNFFqNFN3U1pNZUlwUllDMVV5ZG9qczFjcW5lMTN1U1pTdGFrZ0Vj?=
 =?utf-8?B?dHdYcC9vRWYwRjE4ZDV5N0IxOEprNzlvQ2dqMVlrMnAxbFZwVEFaVnE1bjBn?=
 =?utf-8?B?OW5DN1hmdVpjUVl4L2hxN0RrOFdUN3lKbS9wTjcyUTVwZXU5OVd1eUlOYmFs?=
 =?utf-8?B?Ym5nSDNrNG5TZ3gzWEYyVkFJZHVTWkIwU1VQNmY5eFl6Tm03VUJ6RUNrZWJU?=
 =?utf-8?B?cU5GWHhqWUlsWjB1enMzbmNGblQ2UTZBU1kzU3FFeVBWV2ZtaHpnVEZFQjQ1?=
 =?utf-8?B?U2krb0gwV1VDMU4zdHFqTWpBZGdmTldsSC9TSUkrNmUxcXMyMkJpTEN1YnFq?=
 =?utf-8?B?dVpZbm5wY1NNcUk3MXhpRmR4dlY0MnRyaXNOQnl2VkdMNTlOMzFJdHZCZW9y?=
 =?utf-8?B?aFFTcUhoMUJEbGs3QnNHTWZ3MnBwRDRKc3NvU1UyRUlrWEJtZkFNT2V1ZEZO?=
 =?utf-8?B?WUtRb3FESWhMaE5zMGl6RDljMGJYemo3a3JBbE5oT2g4a25Mc2h2N0tLM3Fx?=
 =?utf-8?B?K2tlNStoMzdwL0dlbUlobnNTOTFqNFdNblU4MVVGb05oRXY4MEtLVy8yVXlQ?=
 =?utf-8?B?SVNqYzFrOHRhTU0zNDZqd1AzWTZyTWQvU0tzZ0lZeUhPSm0xRS83Y3FsZ0to?=
 =?utf-8?B?LzlRYzBtRjUvVUZGejkxV3NzN2JHeExsNWpzdWl0cHJqSjZEMWc5TWZsZ2pW?=
 =?utf-8?B?bXRLK2dUd2x1alhQNnBLTDBPL1A4bkhqN1pIVEVmM3JDTDN1Qkc2dnFldWhw?=
 =?utf-8?B?Z1dORWdSYlIzdERqUGpGdWdkTGRhR0c3V0xNWW1oSzZBalFYdStpQ2IvUHBS?=
 =?utf-8?B?ZmNlSFkyRnNCRTB1N1dFMnBPUXpXOFZyN1lKaXFMS1VyUDZzazhMWkdaMlFn?=
 =?utf-8?B?Qk5YNEtiSmVYdzUwQ1diL0VBQnpDN0svd09vdVcxbE5JMndacTZLcUFiYjF4?=
 =?utf-8?B?TkZMckhGcHg5aW9pMmZOMTNzYXZxU1RHbWwyQXhNMmxuTmJWUDFhZkkyZ3Z5?=
 =?utf-8?B?T3B0TVdqR293OEhNZGRqcHVVcmFxZ2RhYlF6VncvUHJoUEFDcC9KWDZENHdD?=
 =?utf-8?B?YzJYU2ZVbFBCa1FRV01ZVWlFYTV5Szd4eVF2RVhTbzhqbTkySGkyd3dTczMv?=
 =?utf-8?B?dWJMVW91SCtwcjdya0xLNnAvaDMwQVI4QVNDYkFVN0VldlFtZ2tJSmhacXI4?=
 =?utf-8?B?dEFOS21ZZGVaQ0VpRWhJbWNMdUtQRUF3ZU4zZXF5TWF2ZHB4aS9Jc2NQbFdl?=
 =?utf-8?B?eC9CNmtleTRBYWFSazlicUJiNUdqTEQ0bHF0ZTA0dlc5ZDE4Q3hTT0lqb1NB?=
 =?utf-8?B?TmJKcC9yUWc5cW8yZW5pdTQzaEtRcWhsM1B3NHJsTTZIQmxTc3FONGliT0pW?=
 =?utf-8?B?VS9Hb2h4eVNVTnY2MWN6OGpZWHVaQWZITU1UTDJueEQ1Z3U0UUd2SUE3QkRX?=
 =?utf-8?B?UktocERGaXFTU05Qb2lrK1NWYjdlbHN1TCtoaSs0NW0wU3NRY0ZGdjgrdmtO?=
 =?utf-8?B?VHJuTFlLVDliMk1VcW9hakJZUEZPelVCSzZXTk9rZzZjZjNzM0JXSWZQa1A4?=
 =?utf-8?B?MzllbHVNS0svTXRtZzFEd2NYNjNvOHhxZ1IvMjJybFVvbWxwUHk2Wk5abFp3?=
 =?utf-8?B?bE43b0F4MlBuYVhkVkZDTU5rd0FHM2ZKQWVZUEV1dW9mMlVqSzhuSndBdzZt?=
 =?utf-8?B?Vk1sNUg1dVdVeDJEaWx2SWI2VmtXeVRhT29Sc0ZYSFVkb1pHRkNYbFhYSlV1?=
 =?utf-8?B?Q1NZeXNBL1ZRL0hmUFBhdjljSnMzWkRuVnNhemczaDR0K0lHeUNKOEV0WHBN?=
 =?utf-8?B?ZlVMd3hHLys0NWFTOUxubUdaUWFsK3dabjFLZmJDVGl5cTdwZVYwZ1Q1dU1n?=
 =?utf-8?B?eUhwUTZSMU1JZTdLWFRWUktrNDFmblFYSlIwc2NhaU1ra21iTUMyTHFzSzBS?=
 =?utf-8?B?UlR5NjNZNCs5eHlQaUQrUEo1ODkyM01pNFM3dWxhWk03TzFhYlo3ajBJRDRq?=
 =?utf-8?B?UHpjQXJNeW85cFVjTWNLbm40ajJ4UXd2WHovTTZrc3l6VEhnYWtjLzhQOXdr?=
 =?utf-8?B?WFFpT3lZOU15UWJXUEtDZXExOEZpclhHdmhXSS82aGJkeElnWWErL0MzUjFh?=
 =?utf-8?Q?NObVPFepAPiBN4EIodxTh7nvf7i3FtOSv/sE7pm+2MTl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7affd8db-2e05-4b2b-59ea-08dbdb73d428
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 07:17:53.0021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWwdr4Y57sx5h5lzTMHygnTxYbLz6X1tMWrmfKHkAE8TzgOgVl1v7AIOOeokahDlJmEtFr541Wo3/GFrSfk/oOfZeII8AFeRrEOE6rZSJhDIoz5Xlt8I8pMi5xEKNwUDn0l3jmLdJqqPbC8eRAM5AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6559
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

UmV2aWV3ZWQtYnk6IEFsZWtzYW5kYXIgR2VyYXNpbW92c2tpIDxhbGVrc2FuZGFyLmdlcmFzaW1v
dnNraUBoaXRhY2llbmVyZ3kuY29tPg0KDQpSZWdhcmRzLA0KQWxla3NhbmRhcg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4g
DQpTZW50OiBXZWRuZXNkYXksIDEgTm92ZW1iZXIgMjAyMyAxNzoyOA0KVG86IHUtYm9vdEBsaXN0
cy5kZW54LmRlDQpDYzogQWxla3NhbmRhciBHZXJhc2ltb3Zza2kgPGFsZWtzYW5kYXIuZ2VyYXNp
bW92c2tpQGhpdGFjaGllbmVyZ3kuY29tPjsgUmFpbmVyIEJvc2NodW5nIDxyYWluZXIuYm9zY2h1
bmdAaGl0YWNoaWVuZXJneS5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMTEvMjBdIHBnLXdjb20tbHMx
MDJ4YTogSW5jbHVkZSA8Y29uZmlnLmg+IGluIHRoZSBib2FyZCBmaWxlDQoNCldhcm5pbmcNCg0K
VGhpcyBlbWFpbCBjb21lcyBmcm9tIG91dHNpZGUgb2YgSGl0YWNoaSBFbmVyZ3kuIE1ha2Ugc3Vy
ZSB5b3UgdmVyaWZ5IHRoZSBzZW5kZXIgYmVmb3JlIGNsaWNraW5nIGFueSBsaW5rcyBvciBkb3du
bG9hZGluZy9vcGVuaW5nIGF0dGFjaG1lbnRzLg0KSWYgdGhpcyBlbWFpbCBsb29rcyBzdXNwaWNp
b3VzLCByZXBvcnQgaXQgYnkgY2xpY2tpbmcgJ1JlcG9ydCBQaGlzaGluZycgYnV0dG9uIGluIE91
dGxvb2suDQpTZWUgdGhlIFNlY3VyZVdheSBncm91cCBpbiBZYW1tZXIgZm9yIG1vcmUgc2VjdXJp
dHkgaW5mb3JtYXRpb24uDQoNCkdpdmVuIHRoYXQgdGhpcyBmaWxlIHJlZmVyZW5jZXMgQ0ZHXyog
ZGVmaW5lcywgd2UgbmVlZCB0byBiZSBleHBsaWNpdCBpbiBvdXIgaW5jbHVzaW9uIG9mIGNvbmZp
Zy5oLCBzbyB0aGF0IHRoZXNlIHdpbGwgYmUgZGVmaW5lZC4NCg0KU2lnbmVkLW9mZi1ieTogVG9t
IFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCi0tLQ0KQ2M6IEFsZWtzYW5kYXIgR2VyYXNpbW92
c2tpIDxhbGVrc2FuZGFyLmdlcmFzaW1vdnNraUBoaXRhY2hpZW5lcmd5LmNvbT4NCkNjOiBSYWlu
ZXIgQm9zY2h1bmcgPHJhaW5lci5ib3NjaHVuZ0BoaXRhY2hpZW5lcmd5LmNvbT4NCi0tLQ0KIGJv
YXJkL2tleW1pbGUvcGctd2NvbS1sczEwMnhhL3BnLXdjb20tbHMxMDJ4YS5jIHwgMSArDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9ib2FyZC9rZXltaWxl
L3BnLXdjb20tbHMxMDJ4YS9wZy13Y29tLWxzMTAyeGEuYyBiL2JvYXJkL2tleW1pbGUvcGctd2Nv
bS1sczEwMnhhL3BnLXdjb20tbHMxMDJ4YS5jDQppbmRleCAwMTc4NmQ5MzhkZTEuLmNjMzYxMWUy
ZGVjMSAxMDA2NDQNCi0tLSBhL2JvYXJkL2tleW1pbGUvcGctd2NvbS1sczEwMnhhL3BnLXdjb20t
bHMxMDJ4YS5jDQorKysgYi9ib2FyZC9rZXltaWxlL3BnLXdjb20tbHMxMDJ4YS9wZy13Y29tLWxz
MTAyeGEuYw0KQEAgLTMsNiArMyw3IEBADQogICogQ29weXJpZ2h0IDIwMjAgSGl0YWNoaSBQb3dl
ciBHcmlkcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCiAgKi8NCg0KKyNpbmNsdWRlIDxjb25maWcu
aD4NCiAjaW5jbHVkZSA8ZXZlbnQuaD4NCiAjaW5jbHVkZSA8aTJjLmg+DQogI2luY2x1ZGUgPGFz
bS9pby5oPg0KLS0NCjIuMzQuMQ0KDQo=
