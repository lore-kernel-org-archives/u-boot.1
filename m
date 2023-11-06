Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D06C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACE18695F;
	Mon,  6 Nov 2023 13:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lV0GEyGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEA986EB5; Mon,  6 Nov 2023 02:55:58 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190B686ADC
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 02:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongxing.zhu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq0CxWF1SExbou/nOw2ZcmZc+0nKx9UE68z6ACJ/SXHz5kHi8sux8sM7h4Jl228ffXRrxb0MFyYu/WhtTcAMs0T0mC46N4FXhImqCpOx5LdpZapJDEzMgHWd/RFcHmxZcEdUBREV80r/qwT2QzK7CTJ+Pwff9ZTnYAQodmLG3YwqUMG08aqZ/w1QRJB/bspnqjJa4RKm4TZnezfi/2W4T5fZ3uzpneH8MwrVzkzdyEBfz+UPZPtnFuLya9QzuLSWzb9I5mCFZuwfIDN6eFQTwDUXXS4wd05u8AywvbtpCpV0Nqd8pG1GtGvXdUFOnFb+kyrclb+9yHIEW4Ia7b6S4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/AhmtdwzkZeh5eqEp0M12UPBU/R4sb1Vv5sQAE6Akk=;
 b=b4hCTlWW+U6GaqYAnGHn+BCJ0k/cYjfbK7Ykv+glCzg1nZ03ssEyx45BckJGy/QYiyuh52D5/ZrpbDyd+n3pQKcYvbcI/FkLOeRaLCmFQevb7b+0jbLz+M314Dk9IMC8+XH19sceQeNZLtiLqbGOIrJUv3tjYNJ23OxvTFfxDHvdbIqt5xbwTfL8CArckmQK0jk2ybeYniwGMCqfspOSi389CtlUuCpf5SSOhSxf7B3rtRmWIFCHDTEXXfbdPWSC3bMind4LVGjUsa2SzJ+f/gHWqVt+TnTGcI/AExHWZNVKvTdmI2qG1PG4qI5BA6wocqck1RyTTu2zrYputZHZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/AhmtdwzkZeh5eqEp0M12UPBU/R4sb1Vv5sQAE6Akk=;
 b=lV0GEyGG6gnrF8uiq2N4YRtdhIj0zG+qh+j3bzOlATfKqAKT7GlDy6zyzlAWDh6eyB6jknFwxV4LqBsooFx7Ax3fEQO0YvPQx8dVbUeO/tCpy4igigdeyzzsZlTypttadHVxbVwMb2/2s2dFr9/9CFcEl1jz/kOwDRhecCfKmmw=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Mon, 6 Nov
 2023 01:55:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f025:aa23:c5c:63b5]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f025:aa23:c5c:63b5%2]) with mapi id 15.20.6977.016; Mon, 6 Nov 2023
 01:55:51 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk is
 gone in next scsi scan
Thread-Topic: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk
 is gone in next scsi scan
Thread-Index: AdoMbvzePOEhAsuLTy2OTmnmM9WusgBhnjhAAFhxzQAAAolkAAA8svtA
Date: Mon, 6 Nov 2023 01:55:50 +0000
Message-ID: <AS8PR04MB8676DB510B415C73FD2EA9FC8CAAA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867669CC8B5EB411BDEF45348CA5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAPnjgZ1r60UomKz5DkH-POvsj0jKq1rNENniwZpAn3AWHk94EA@mail.gmail.com>
 <2F0F7B2D-8DDF-439C-9889-8FA0B21CF36C@gmx.de>
In-Reply-To: <2F0F7B2D-8DDF-439C-9889-8FA0B21CF36C@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBAPR04MB7304:EE_
x-ms-office365-filtering-correlation-id: b29078a0-1645-4c41-acde-08dbde6b80f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r89EK5y6JzLU6p8Pmuo4PDUVr6TNT4xGzuBOjuzTkGnxb06uYzQqWH0G6YzmtrS8IGrUx0qNcX2qXovpTU233Qu3Ht4AcA5cRjo17OvUI75acZmZETg5D3iW21Ilg1YdJvV2Py4yog/ucPc/0gLKZK59BIUHVvdUp2uNEdl5IpIlTas5fS1580gRD4/oYrNSkz991W/J1WrUG8V+GQcoH52qqnnOtklKslzlGz4wrNyylMxabCI8WRbttCeDLDhIixcWgHtTUbGsD3sY03cYZ2rPFpiRmX9PbXGvM+bhjEyq4pa5bjLSGaarbw/2qpjRXvQ2AnL8ZMeEdCC44vCe/HJxfaNyzRqYYOlDlTwLNWyB4X4iPdyW65WE8vaVfe/V7+KjWI07PCR0OdBsc9DOhuaHSxLBNs4gZoaKe8hr9SAGOQARL0o/nJKzfs1mKUOrJ6lyF8Fh4lSDTLB5x20OmTPpdWskuWqUpITW5tcecoOrZvqajmOpIjoNCiSar1vtykrbYnw4RNuIjC0E6qsSgjMw4hJEe3enVAtLejHDQ8oJScXwRmqM6S83oVX1yPQMRWd0dw3RTqJmD7gUHifjLSZUTyZqZliGZA35mThsSZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8676.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39850400004)(396003)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(122000001)(9686003)(38070700009)(966005)(316002)(110136005)(8936002)(52536014)(8676002)(4326008)(33656002)(86362001)(41300700001)(2906002)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(26005)(44832011)(76116006)(71200400001)(53546011)(6506007)(45080400002)(478600001)(7696005)(55016003)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z2hVS1g4WUNwR3R2cnNIWVVWR1U0TW8xa08yQXNoS1B6eUV2NzJUTm93WUMr?=
 =?gb2312?B?d2xUcGlCVXd2SC9EdFlCeFBGSU5IU0RJcGVhR2RGWjhRRC9vdXFoSTJjUDJQ?=
 =?gb2312?B?c1pLbUZzS2dMcXJCcitTK1dKOS92bUNxT1hIaWtQUmVxMTZNdHlackVCakU4?=
 =?gb2312?B?MUh2UTM3aFNPZUtRaXVUTUR0Ym9WRW1kTlNxRGd6TTl4TmlVb2VpK25wMGI5?=
 =?gb2312?B?RjJ3UWNIeWFJWTNjVjdkR2g3SzdZTlFEV1V6TlBTbWVrODdWNW5WL2ZlRlNS?=
 =?gb2312?B?VUcxWmxsd2xCLzluNXlBdEFTVldvZzAwVzdNY3I5SWVRV25nNklUeXNrNzhL?=
 =?gb2312?B?MlpMTDVmd0VSWWxxTG1mUWRyem03QlB5WnlBVm1qNGVBTXQvYlZQUVh1eUQz?=
 =?gb2312?B?cGI3VWNLZ3FWT044eEdOcFJrczhWdVdaRnUxWUFzREtaYmhtMVZnZHpnVTZj?=
 =?gb2312?B?VG1Lem5BZHRZRXRZQUoxYUlBN1pIbW1yc1E5Y21VTzltVWkveGFrK0JtemVx?=
 =?gb2312?B?ajlQWkdabk5lUjBPM2h1QnVka0lnMTRSZkRiTEhPeHFhdE5mUlJPbVFqU2JI?=
 =?gb2312?B?bG1pbHdLa0tRYWxYbDM0bzFIZHdzdHV3TVc3V0E2VDJScDhvb1RLQk5OZUdm?=
 =?gb2312?B?dGZ0YzQwUFNrVHJLK3NIMFlkcUJ0ODRxeldLdDdnbVM5aEQ0bUV2NEgwYjRa?=
 =?gb2312?B?VExJaE5IaUN1TTUvcm1yeFlUSzFBN1RHbHFLamlmRGM3V3dNOXBYMGlZRUV1?=
 =?gb2312?B?dmZ3NXRESzJPQmtSVG92Yml2T0NQV3JTM0N6dkFCdEZDUlJmTVhwK2RHM0N3?=
 =?gb2312?B?TDFBSjYzay8ybGRLM0ZSRUZzMWFxNDA0YnM5VW9xaFlvc0tPSE1CNVUxYWd3?=
 =?gb2312?B?S0NnL2ljbHBvVjlPUGI1QXBDbjhzbDBXRVRxYnczWDhOZGw5QlZjR2dZSXA4?=
 =?gb2312?B?Mk1CbVRicW9idE54am5ndzFRQi9OTC9YZXFHeThMSjNWMjdJUmR4UVBBeE5o?=
 =?gb2312?B?K2FSdEYrWHNHcEs2VVpVdnNkV0hxMTlMcVVocE5tUm5SSkpUVStVdEkzQXNk?=
 =?gb2312?B?QkUwT2dqNXNySGVZZ3U5ZDYrUmxHSWlreXFBRm04c0FHdjBCY1lHUjROV09w?=
 =?gb2312?B?OTRwMEtjeUxJRlB1RnBMa21XaE5PQ1orVHhJKzI0dU9SMlNNN1o4bEpDK0ZN?=
 =?gb2312?B?MzBWOWQvNDJoVGV0azMzQ0VDa0ltNzFkNXpVN3FsTW5FSW5rT2xFR09vbjlw?=
 =?gb2312?B?dmRYbXEwdXJvWlYxcDd2eXpsMCtmNzZpbnRDQmJsMzcrVkdOVjIzbFFXTGFz?=
 =?gb2312?B?dCtRYUloQThTcWR0Qis3cmtUazhwdGVOZnVuWVJBQkxzd3B4TzQvSHdBSnMx?=
 =?gb2312?B?c0xVYzhxcFE4VnFCRDJKZTRFTXpDcUt1L2g3Q2xDY21FL0pxNXpXTzd2YXk1?=
 =?gb2312?B?bEd1TllySjNSemtmMzBzWlBwUHlvYXFodHBwcE50MWlXYlhaRGVOUEMzYTJF?=
 =?gb2312?B?ZGtDOVVLQkY3Vk52VXdIQXVCSkFYbnFGbnVaVFI1NVNwb0J2c0l5OHVMVW9H?=
 =?gb2312?B?NVBqZDkyZXo1emNXZDNKMHJVY0o5cHNRSmhEOHFrRnVKTmFQNER5YVNwcDFP?=
 =?gb2312?B?SlFBdVNHakJQYjFSNHBjSFhuY20yS3pCdC9rOGQrL2x3SW5WN3FEWlhScWVy?=
 =?gb2312?B?bDc1ZXQvQlNJdkRPT2UzV0YzUUJKVWZvYjlHU0RYVWRVcXZQaVdacHIvOC9N?=
 =?gb2312?B?YUg4Smlva2lSc3p0NnBza2pDRWMrTE84TFF1dEx5a0kwYzA1eHJWWndyTTBU?=
 =?gb2312?B?NjR4OUgxblNEc1lkZDBRS3BTSUhrZnhxaWxqdFNJQWk5V1VTTXFOMEc2RGR3?=
 =?gb2312?B?Y3o1Uk1ySkZDb3NxZ0RBUXFTYS9EbVZEWkF0b2xoWlRwZXhHVVB4RVg4bVd4?=
 =?gb2312?B?TDZTSjdlU2VqK3NYVllqZWRZb0VhMytsckYzNnFKdEEvMHV4cUVxcmtxNVFO?=
 =?gb2312?B?UEhVNWdNcThabTBwTTNyWkJPNThSYXhWTkhWaGRkTldlbmJOSXo1R0hEaytm?=
 =?gb2312?B?bnVkYkI2RkkzKzVYdnJTTXFDRXJDVGxJbklFQ0JMdUo3RTN1NC9qdGFLQjJY?=
 =?gb2312?Q?BCsrZVvYZxib6oMurfGXDjOqC?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29078a0-1645-4c41-acde-08dbde6b80f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 01:55:50.8648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKeRI8zBYftxMW8xjam33Sv3os/yEfeoGrFEe2mA3GI7lJqPCzTzhOwGFI2pBGxOFnYCLkNpZ49nZ2I1X96nrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304
X-Mailman-Approved-At: Mon, 06 Nov 2023 13:46:39 +0100
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

SGkgSGVpbnJpY2g6DQpUaGFua3MgYSBsb3QgZm9yIHlvdXIga2luZGx5IGhlbHAuDQpUaGlzIHNo
b3VsZCBiZSBmaW5hbCBzb2x1dGlvbiB0aGF0IEknbSBsb29raW5nIGZvci4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEhlaW5yaWNoIFNjaHVjaGFyZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4NCj4gU2VudDogMjAyM8Tq
MTHUwjXI1SA0OjU3DQo+IFRvOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZQ0KPiBTdWJqZWN0OiBSZTogdWJvb3QgcmVwb3J0cyBhZGRpbmcgZGlzayBmYWlsZWQoRUZJX05P
VF9GT1VORCkgYW5kIGZpcnN0IGRpc2sgaXMNCj4gZ29uZSBpbiBuZXh0IHNjc2kgc2Nhbg0KPg0K
Pg0KPg0KPiBBbSA0LiBOb3ZlbWJlciAyMDIzIDIxOjQzOjUyIE9FWiBzY2hyaWViIFNpbW9uIEds
YXNzIDxzamdAY2hyb21pdW0ub3JnPjoNCj4gPkhpIFJpY2hhcmQsDQo+ID4NCj4gPitIZWlucmlj
aCBhcyBJIHRoaW5rIHRoaXMgaXMgYW4gRUZJIGJ1Zy4NCj4gPg0KPiA+T24gVGh1LCAyIE5vdiAy
MDIzIGF0IDE5OjM3LCBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPiB3cm90ZToN
Cj4gPj4NCj4gPj4gSGkgU2ltb246DQo+ID4+IEkgZm91bmQgdGhhdCB0aGUgRUZJIGNvbXBsYWlu
ZWQgdGhhdCB0aGUgZGlzayBpbnN0YWxsIHBhdGggaXMgbm90IHVwZGF0ZWQgZm9yIHRoZQ0KPiBz
ZWNvbmQgZGlzay4NCj4gPj4gVGhlIGluc3RhbGwgcGF0aCBpcyChsEVGSTogaW5zdGFsbGVkIGRl
dmljZSBwYXRoDQo+ICcvVmVuSHcoZTYxZDczYjktYTM4NC00YWNjLWFlYWItODJlODI4ZjM2Mjhi
KS9TY3NpKDAsMCknobENCj4gPj4NCj4gPj4gd2hlbiBmaXJzdCBkaXNrIGlzIGFkZGVkLg0KPg0K
PiBUaGlzIHNob3VsZCBiZSBmaXhlZCB0aGlzIGluIFUtQm9vdCB2MjAyMy4xMC4NCj4NCj4gaHR0
cHM6Ly9naXRodWIuY28vDQo+IG0lMkZ0cmluaSUyRnUtYm9vdCUyRmNvbW1pdCUyRmUwNzM2OGVh
NTdkMjI0NTU3NTcwYTY3MTVkY2ZmZGJjODgNCj4gM2E4MDc5JmRhdGE9MDUlN0MwMSU3Q2hvbmd4
aW5nLnpodSU0MG54cC5jb20lN0MyMzBlMzlkMWFlMGY0Y2E2DQo+IDhlNTkwOGRiZGQ3ODg2Yzcl
N0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDDQo+IDYzODM0NzI4
MTk1MjU5MDIyNSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TQ0KPiBE
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3
QyU3QyU3Qw0KPiAmc2RhdGE9cUEwUWlFc0E1NXk5OWhjaTdFeEE2cXlkZm94cDVmN0pnMWhtZ3RZ
dkJVSSUzRCZyZXNlcnZlZD0wDQo+DQo+IEJlc3QgcmVnYXJkcw0KPg0KPiBIZWlucmljaA0KPg0K
PiA+Pg0KPiA+PiBCdXQgdGhlIHBhdGggaXMgc2FtZSB3aGVuIHRoZSBzZWNvbmQgb3IgbGF0ZXIg
ZGlza3MgYXJlIGFkZGVkLCBhbmQgRUZJIHJlcG9ycw0KPiB0aGF0IHRoZSBwYXRoIGhhZCBiZWVu
IGluc3RhbGxlZCBhbHJlYWR5Lg0KPiA+PiBFRkk6IFBhdGggL1Zlbkh3KGU2MWQ3M2I5LWEzODQt
NGFjYy1hZWFiLTgyZTgyOGYzNjI4YikvU2NzaSgwLDApDQo+ID4+IGFscmVhZHkgaW5zdGFsbGVk
DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IFRoYXShr3Mgd2h5IHRoZSBiZWxvdyBlcnJvciB3aGVu
IHJ1biBlZmlfZGlza19jcmVhdGVfcmF3KCkgZnVuY3Rpb24uDQo+ID4+DQo+ID4+IEFkZGluZyBk
aXNrIGZvciBhaGNpX3Njc2kuaWQwbHVuMCBmYWlsZWQNCj4gPj4gKGVycj0tOTIyMzM3MjAzNjg1
NDc3NTc4OC8weDgwMDAwMDAwMDAwMDAwMTQpDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IERvIHlv
dSBoYXZlIGFueSBjbHVlcyBhYm91dCB0aGlzPw0KPiA+Pg0KPiA+PiBUaGFua3MgaW4gYWR2YW5j
ZWQuDQo+ID4+DQo+ID4+IEJlc3QgUmVnYXJkcw0KPiA+Pg0KPiA+PiBSaWNoYXJkIFpodQ0KPiA+
Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBGcm9tOiBIb25neGluZyBaaHUNCj4gPj4gU2VudDogMjAyM8Tq
MTHUwjHI1SAxMDo1Nw0KPiA+PiBUbzogc2pnQGNocm9taXVtLm9yZw0KPiA+PiBDYzogdS1ib290
QGxpc3RzLmRlbnguZGUNCj4gPj4gU3ViamVjdDogdWJvb3QgcmVwb3J0cyBhZGRpbmcgZGlzayBm
YWlsZWQoRUZJX05PVF9GT1VORCkgYW5kIGZpcnN0DQo+ID4+IGRpc2sgaXMgZ29uZSBpbiBuZXh0
IHNjc2kgc2Nhbg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBIaSBTaW1vbjoNCj4gPj4gTmljZSB0
byBtZWV0IHlvdS4NCj4gPj4gVGhlIHUtYm9vdCBJIHVzZWQgaXMgYmFzZWQgb24gdjIwMjMuMDQg
dGFnZ2VkIHZlcnNpb24uDQo+ID4+IExheWVyc2NhcGUgTFgyMTYwQSBSREIgYm9hcmQgaGFzIGZv
dXIgU0FUQSBjb250cm9sbGVycy4NCj4gPj4gQmFzZWQgb24gTFgyMTYwQSBSREIgYm9hcmQgYW5k
IHR3byBvciBtb3JlIFNBVEEgZGlza3MgY29ubmVjdGVkLg0KPiA+PiBJIGVuY291bnRlciBvbmUg
obBzY3NpIHNjYW6hsSBwcm9ibGVtLg0KPiA+Pg0KPiA+Pg0KPiA+PiBBZnRlciB0aGUgZmlyc3Qg
U0FUQSBkaXNrIGlzIGRldGVjdGVkIGFuZCBwcm9iZWQgcHJvcGVybHkgaW4gdGhlIGZpcnN0IKGw
c2NzaQ0KPiBzY2FuobEuDQo+ID4+IFRoZSBvdGhlciBkaXNrcyB3b3VsZCBjb21wbGFpbiB0aGF0
IKGwRUZJX05PVF9GT1VORKGxIGVycm9yIGxpc3RlZA0KPiA+PiBiZWxvdywgd2hlbiBydW4gdGhl
IGZpcnN0IKGwc2NzaSBzY2FuobEgY29tbWFuZCBpbiB1Ym9vdCBlbnZpcm9ubWVudC4NCj4gPj4N
Cj4gPj4gRG9lcyB0aGlzIGVycm9yIG1hdHRlcj8NCj4gPj4gQlRXLCChsHNjc2kgaW5mb6GxIHNh
eXMgdGhhdCBhbGwgZGlzayBpbmZvIGNhbiBiZSBkdW1wZWQsIGFuZCBhbGwgZGlza3MNCj4gPj4g
YXJlIHdvcmtzIHdlbGwsDQo+ID4+DQo+ID4+IGFmdGVyIHRoZSBmaXJzdCChsHNjc2kgc2NhbqGx
DQo+ID4+DQo+ID4+IEluIHRoZSBjb25zZWN1dGl2ZSByZXNjYW4gb3BlcmF0aW9ucyBpc3N1ZWQg
YnkgobBzY3NpIHJlc2V0obEgb3IgobBzY3NpDQo+ID4+IHNjYW6hsSBjb21tZW5kcywgdGhlIGRp
c2tzIHdvdWxkIHJlcG9ydCChsHVuYWJsZSB0byB1bmJpbmQgZGV2aWNlcyAoLTFFKaGxDQo+IGVy
cm9yLg0KPiA+PiBUaGUgZmlyc3QgZGlzayBpcyBkaXNhcHBlYXJlZCBhdCBhbGwgYWZ0ZXIgdGhl
IG5leHQgobBzY3NpIHNjYW6hsSBvcGVyYXRpb25zIGlzDQo+IGZpbmlzaGVkLg0KPiA+Pg0KPiA+
Pg0KPiA+PiBEaWQgeW91IHVzZWQgdG8gZW5jb3VudGVyIHN1Y2gga2luZCBvZiBpc3N1ZT8NCj4g
Pj4NCj4gPj4gQW55IHN1Z2dlc3Rpb25zIGFuZCBndWlkYW5jZSBhcmUgdmVyeSBhcHByZWNpYXRl
ZC4NCj4gPj4NCj4gPj4gTG9nczoNCj4gPj4gPT4gc2NzaSBzY2FuDQo+ID4+DQo+ID4+IHNjYW5u
aW5nIGJ1cyBmb3IgZGV2aWNlcy4uLg0KPiA+Pg0KPiA+PiBUYXJnZXQgc3BpbnVwIHRvb2sgMCBt
cy4NCj4gPj4NCj4gPj4gQUhDSSAwMDAxLjAzMDEgMzIgc2xvdHMgMSBwb3J0cyA2IEdicHMgMHgx
IGltcGwgU0FUQSBtb2RlDQo+ID4+DQo+ID4+IGZsYWdzOiA2NGJpdCBuY3EgcG0gY2xvIG9ubHkg
cG1wIGZic3MgcGlvIHNsdW0gcGFydCBjY2MgYXBzdA0KPiA+Pg0KPiA+PiAgIERldmljZSAwOiAo
MDowKSBWZW5kb3I6IEFUQSBQcm9kLjogU1QxMDAwRE0wMTAtMkVQMSBSZXY6IENDNDMNCj4gPj4N
Cj4gPj4gICAgICAgICAgICAgVHlwZTogSGFyZCBEaXNrDQo+ID4+DQo+ID4+ICAgICAgICAgICAg
IENhcGFjaXR5OiA5NTM4NjkuNyBNQiA9IDkzMS41IEdCICgxOTUzNTI1MTY4IHggNTEyKQ0KPiA+
Pg0KPiA+PiBUYXJnZXQgc3BpbnVwIHRvb2sgMCBtcy4NCj4gPj4NCj4gPj4gQUhDSSAwMDAxLjAz
MDEgMzIgc2xvdHMgMSBwb3J0cyA2IEdicHMgMHgxIGltcGwgU0FUQSBtb2RlDQo+ID4+DQo+ID4+
IGZsYWdzOiA2NGJpdCBuY3EgcG0gY2xvIG9ubHkgcG1wIGZic3MgcGlvIHNsdW0gcGFydCBjY2Mg
YXBzdA0KPiA+Pg0KPiA+PiBBZGRpbmcgZGlzayBmb3IgYWhjaV9zY3NpLmlkMGx1bjAgZmFpbGVk
DQo+ID4+IChlcnI9LTkyMjMzNzIwMzY4NTQ3NzU3ODgvMHg4MDAwMDAwMDAwMDAwMDE0KQ0KPiA+
Pg0KPiA+PiBTQVRBIGxpbmsgMCB0aW1lb3V0Lg0KPiA+Pg0KPiA+PiBBSENJIDAwMDEuMDMwMSAz
MiBzbG90cyAxIHBvcnRzIDYgR2JwcyAweDEgaW1wbCBTQVRBIG1vZGUNCj4gPj4NCj4gPj4gZmxh
Z3M6IDY0Yml0IG5jcSBwbSBjbG8gb25seSBwbXAgZmJzcyBwaW8gc2x1bSBwYXJ0IGNjYyBhcHN0
DQo+ID4+DQo+ID4+IFNBVEEgbGluayAwIHRpbWVvdXQuDQo+ID4+DQo+ID4+IEFIQ0kgMDAwMS4w
MzAxIDMyIHNsb3RzIDEgcG9ydHMgNiBHYnBzIDB4MSBpbXBsIFNBVEEgbW9kZQ0KPiA+Pg0KPiA+
PiBmbGFnczogNjRiaXQgbmNxIHBtIGNsbyBvbmx5IHBtcCBmYnNzIHBpbyBzbHVtIHBhcnQgY2Nj
IGFwc3QgPT4gc2NzaQ0KPiA+PiBpbmZvDQo+ID4+DQo+ID4+IERldmljZSAwOiAoMDowKSBWZW5k
b3I6IEFUQSBQcm9kLjogU1QxMDAwRE0wMTAtMkVQMSBSZXY6IENDNDMNCj4gPj4NCj4gPj4gICAg
ICAgICAgICAgVHlwZTogSGFyZCBEaXNrDQo+ID4+DQo+ID4+ICAgICAgICAgICAgIENhcGFjaXR5
OiA5NTM4NjkuNyBNQiA9IDkzMS41IEdCICgxOTUzNTI1MTY4IHggNTEyKQ0KPiA+Pg0KPiA+PiBE
ZXZpY2UgMTogKDA6MCkgVmVuZG9yOiBBVEEgUHJvZC46IFNUNTAwRE0wMDItMUJEMTQgUmV2OiBL
QzQ1DQo+ID4+DQo+ID4+ICAgICAgICAgICAgIFR5cGU6IEhhcmQgRGlzaw0KPiA+Pg0KPiA+PiAg
ICAgICAgICAgICBDYXBhY2l0eTogNDc2OTQwLjAgTUIgPSA0NjUuNyBHQiAoOTc2NzczMTY4IHgg
NTEyKQ0KPiA+Pg0KPiA+PiA9PiBscyBzY3NpIDA6MQ0KPiA+Pg0KPiA+PiA8RElSPiAgICAgICA0
MDk2IC4NCj4gPj4NCj4gPj4gPERJUj4gICAgICAgNDA5NiAuLg0KPiA+Pg0KPiA+PiA8RElSPiAg
ICAgIDE2Mzg0IGxvc3QrZm91bmQNCj4gPj4NCj4gPj4gPHNuaXA+DQo+ID4+DQo+ID4+IDxESVI+
ICAgICAgIDQwOTYgdmFyDQo+ID4+DQo+ID4+IDxTWU0+ICAgICAgICAgMTIgbGludXhyYw0KPiA+
Pg0KPiA+PiA9PiBscyBzY3NpIDE6MQ0KPiA+Pg0KPiA+PiA8RElSPiAgICAgICA0MDk2IC4NCj4g
Pj4NCj4gPj4gPERJUj4gICAgICAgNDA5NiAuLg0KPiA+Pg0KPiA+PiA8RElSPiAgICAgIDE2Mzg0
IGxvc3QrZm91bmQNCj4gPj4NCj4gPj4gPHNuaXA+DQo+ID4+DQo+ID4+IDxESVI+ICAgICAgIDQw
OTYgdXNyDQo+ID4+DQo+ID4+IDxESVI+ICAgICAgIDQwOTYgdmFyDQo+ID4+DQo+ID4+DQo+ID4+
DQo+ID4+ID0+IHNjc2kgcmVzZXQNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gUmVzZXQgU0NTSQ0K
PiA+Pg0KPiA+PiBzY2FubmluZyBidXMgZm9yIGRldmljZXMuLi4NCj4gPj4NCj4gPj4gdW5hYmxl
IHRvIHVuYmluZCBkZXZpY2VzICgtMUUpDQo+ID4+ID0+IGxzIHNjc2kgMDoxDQo+ID4+DQo+ID4+
ICoqIEJhZCBkZXZpY2Ugc3BlY2lmaWNhdGlvbiBzY3NpIDAgKioNCj4gPj4NCj4gPj4gQ291bGRu
J3QgZmluZCBwYXJ0aXRpb24gc2NzaSAwOjENCj4gPj4NCj4gPj4gPT4gbHMgc2NzaSAxOjENCj4g
Pj4NCj4gPj4gPERJUj4gICAgICAgNDA5NiAuDQo+ID4+DQo+ID4+IDxESVI+ICAgICAgIDQwOTYg
Li4NCj4gPj4NCj4gPj4gPERJUj4gICAgICAxNjM4NCBsb3N0K2ZvdW5kDQo+ID4+DQo+ID4+IDxz
bmlwPg0KPiA+Pg0KPiA+PiA8RElSPiAgICAgICA0MDk2IHZhcg0KPiA+Pg0KPiA+Pg0KPiA+PiA9
PiBzY3NpIGluZm8NCj4gPj4NCj4gPj4gRGV2aWNlIDE6ICgwOjApIFZlbmRvcjogQVRBIFByb2Qu
OiBTVDUwMERNMDAyLTFCRDE0IFJldjogS0M0NQ0KPiA+Pg0KPiA+PiAgICAgICAgICAgICBUeXBl
OiBIYXJkIERpc2sNCj4gPj4NCj4gPj4gICAgICAgICAgICAgQ2FwYWNpdHk6IDQ3Njk0MC4wIE1C
ID0gNDY1LjcgR0IgKDk3Njc3MzE2OCB4IDUxMikNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gQmVz
dCBSZWdhcmRzDQo+ID4+DQo+ID4+IFJpY2hhcmQgWmh1DQo+ID4+DQo+ID4+DQo+ID4NCj4gPlJl
Z2FyZHMsDQo+ID5TaW1vbg0K
