Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E843C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 15:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C9980977;
	Tue, 25 Feb 2025 16:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="dwZux6PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAB880EC0; Tue, 25 Feb 2025 16:43:22 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DED680805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 16:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQd4kWVCCHBbv8xzYhSBN2oqGbBuFPzzHCNZucHYvFXxyBymLoJGx1SfZyRVUkU2erwx35k4vEz3VpAH7K2UvT9sZ9QxBasBDDZSLal0f1zj9u9UbjovF9XIUk3HdZHI5O99ql3/ixQYsDczHN9Z1BEBHBLVV4LN0mkjiuEkdfj8ulhKSC67wnlTRvpZu6AaR8quqO/WcoL0KFhqV2rCnNWigDF9DLossLXh8HKXUOuvsnrw5r1IUrd/PB/44SIE5DyVRK3kaUa01c9RVLuTNoNDUnUcIfuF0sNkvW524yI8F/JJbMpH+o5zYS7vI+oWy1ZeyK55GIDZ3fJu5yuRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0jQpTRSUY2z0R0zMwX+xCo5bm8lp8LtyMILryrL9zQ=;
 b=WSHMI40+vfms3phO12yd7oLyFLe2gIuqYvWMCjyToVlMCC8LNbtreUbJ8vXNf67a53Hsm5h6VFUYz7GTo5kfzOOpQs61AGYhB9pH7DoLYGBc1M0JgowFZHYOJ9P+SC+YsROk5K+UcUp7U468fMhYMgxHqKqKnD7vLDUwiuA419tgvWovmvp3xs+ZalYBmz/rmZaP1RkCartc2rZaTGM0//2w/sG/34E7blAmjaiWBo9ObR2EVbnGnPC1C2+XtxfZOsQ9dwFBVXL9Oz4VMVw8b0zgAhW5QDDn/rhbPLs45iQ/3OrWqdPXLZLDOQHn8DjNKPapK0W/DcH4aztSgZHWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0jQpTRSUY2z0R0zMwX+xCo5bm8lp8LtyMILryrL9zQ=;
 b=dwZux6PXmvc5k8qS7x35e0anox+w7YTzVBvjCQQL8kUy9bhY2rjFZbohQW3xMqZYjpGy/IY3kK3pa03CWkBmICVJ73qJBZQ3ZyvORb95gE/MJcw1ckqHVoKyOXrS6MmgMkykZNNe7fDv/WdHCgDkO6bYFN+g/DX61HtWGBJksQP+RXfd0tcv/D5er7F/Uf2Ag2WS76/px2e4Z74gQSp72oENlt9vSOBz6IVzUi5k3oKdYgvD5ap72ygAPgTu4cbVqxRSIuAqsqptNn6/4MK5/rTfppFLrPL3GI5Dof1Ee98TVNBWdIVlxOSjRrEvOjXbfIlfFSgWE1HBZu6y4IIPoA==
Received: from PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33a::21)
 by DU0PR10MB5268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 15:43:19 +0000
Received: from PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6b2:75c9:2b40:aabf]) by PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6b2:75c9:2b40:aabf%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:43:19 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "bb@ti.com" <bb@ti.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>, "afd@ti.com" <afd@ti.com>, 
 "j-choudhary@ti.com" <j-choudhary@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "danishanwar@ti.com" <danishanwar@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 13/15] board: ti: j722s: evm: Enable cache for J722s
Thread-Topic: [PATCH v3 13/15] board: ti: j722s: evm: Enable cache for J722s
Thread-Index: AQHbh3taU9OmZHXIVEe4eLluN9fdwrNYKQOA
Date: Tue, 25 Feb 2025 15:43:18 +0000
Message-ID: <0f4fea18b359cf9c85ba33805f706f02759012e4.camel@siemens.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
 <20250225114903.2080616-14-c-vankar@ti.com>
In-Reply-To: <20250225114903.2080616-14-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB6877:EE_|DU0PR10MB5268:EE_
x-ms-office365-filtering-correlation-id: d0f24eca-d196-4bb3-537c-08dd55b32079
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a1gxR3pqem9LTjRrQlZnY1JYMEV3ZXpNMjJyZjVsY2VLa1dRMmRTSzhQd21D?=
 =?utf-8?B?amZRT0xJdUZsR2VKZ0pBeWJXTTI4Yjd2bm5Rd3FKZDdZWnJaV0hmL2luM2FR?=
 =?utf-8?B?V0NzMWRvajRibVA4bjBISkFQQ24xVEEwQ1BEdThXbFIwUXV0WFBacmVVMjhC?=
 =?utf-8?B?UmgwVUJSUUd5ckZYNm5GT0ZxK1RvOHMwcTdDdE1ER1k5VUhlbHp6Z3ZFSzZp?=
 =?utf-8?B?aHVUOCtmL2RESzlUVXZKaWJLREtyWFJrOElacWVPQUVEcjBDVzJIOVp3bjVl?=
 =?utf-8?B?L2N3aWZwczBFOHhZYmI3RGRaUFZVZkE4c01FV2tKbHlJZ2l3WjIwbzRMaC9N?=
 =?utf-8?B?MVhHNUsyZG9YS2E0ZEt2RVlraXRXZWdxbEJydDg3aWNJUUthMXM4TXJ2SlpV?=
 =?utf-8?B?Qk9QcFc3S1ZscmpicTBLZjRWMmpab3d2RGZwS3BxNW1XdnFqci8ybE9WQlRu?=
 =?utf-8?B?Vm1JUDF2QlpyK21RUWY3YWltMEw0SUgxNEhINlhxNHNBMmVGcEFmUVNQQVhJ?=
 =?utf-8?B?TmFOMkZKUmg4NzdUYWFFWkNoQUwzQlFjRWQwQVB5aGtvUDFlZWovemx2QlVJ?=
 =?utf-8?B?bUhVWUpkOG9jSWx4bVVOdFkwYWIzck9lVXVYNWRQR3Y2SXdFM2FGNEVHV0Zs?=
 =?utf-8?B?ZzJKbTV0MDJ2N1pXMXViS1lBVFFMMFdXSHY5Q1JDWjhXVHpNQjFlN3VJblVt?=
 =?utf-8?B?UDlSckRNZGNOQkJqUlh1SEphK2JEeWF1WGlHeEs3SDBwRjZjMzZMViswdklI?=
 =?utf-8?B?YUsrOFdOTGVuRWY1a21pNFgrRDZtWUNnMTMxSXJpY29EZUtxNFN1Uk1sc29p?=
 =?utf-8?B?MGxSU3JDZ01xb3J2OXV1SUxpNzhxZDhIVEtzK0dlbWxpQlRqdjNiNVBCVTZs?=
 =?utf-8?B?dU56SVBGQ2dMWE9tOTZlTDBNbGpVQklmcXJORWhUYm9PNWIrU1hwbExNWmg4?=
 =?utf-8?B?MkxqWHpwS09wV21rR0tlQldCMzRKVUY5eTJxTTRaQ2wyWTV1aWpxZlM5c0o1?=
 =?utf-8?B?MkpvZW42ZStPc1g5K0t5OElib0t1bTNxOEtXczBTRXFmVU9xSU1ZcnFxNmdl?=
 =?utf-8?B?NXkxekIxcEJhMWZCeENRanNkbkMzbmlVWGhOa0JGdVJRbXdOWkVoU2gzTFpu?=
 =?utf-8?B?ZzhqYnRaMnBsZzU3SnpBM1JmWjNNQmI1NXlBd2VrVWpqNTJ6ZnNFVUxLWjQw?=
 =?utf-8?B?dTM5VXFPc09YMW5hOUE2akFkZnBhaGVhNjRucGRDcjRlcjhRRC9nQkRHaVI5?=
 =?utf-8?B?T3FsaWF2ZVVpbkJzeFQrZVB0eXN4SUQ2czVMaEJpSHVqTWtwckV3eVhtS0hY?=
 =?utf-8?B?TUgyV1lmVEZISGZhMlR0ZmJOVy8zb3JWbU5SWVIrYWwyd0hCVVlKTVJwZGpO?=
 =?utf-8?B?TU5MQ1FMQldRUThKQWhGelgxcXZHMHp5OE9FSE56emcyRWJGQmNhbXRyQnov?=
 =?utf-8?B?cUJ1R1NRYi8ramhQV2lydjFldWR5UERLMEZmekdJRVI0NW90T3I1Q0htRlZw?=
 =?utf-8?B?QUJSUEFmQytMTjVwZFlySkFhbmxCbVdHMUJWZG9NYWlPYmtMZWsxV0k5N3ZJ?=
 =?utf-8?B?S3FrcG9sQkpxVklOMTdJTHVSS0EzZHhINS9aWHg1ZFNCYkxBdms0d0FXTTVJ?=
 =?utf-8?B?R0F2VTJ1NUVBMFNnU1U4R1RHTUlNT2FaRFoxdS9DMjErTEFqejNwakxUSDBK?=
 =?utf-8?B?Z2wvNjRKczNoSlBuU1NHZ1p0TFFZUUg2UERwUC95Mi9lTXRULzhoV0Qyendx?=
 =?utf-8?B?K05MR0E2S3lPOW9CdUNNbXlqbGU2VEE5ZTN5NzJHWCtIRVcvQ1FtZW9NMTJD?=
 =?utf-8?B?RUZ0SExCQ1pHWC9LeWtvOUdlcnMrdi9TUFo0QUlSdzlkbVBwcndaSnUrejFo?=
 =?utf-8?B?Y3N6YlUrVDF2cGQxMGRwZTZpQXN0K0tqdlZXWFZUY3VubHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzVlSVpnZmJOYmFPQ1NvZ3M3TVVzTzNyaXdOcFp2R2o5MzVuL2g3UHEzcncr?=
 =?utf-8?B?TXBKTVllVnl6dmZ6MFViVnFmTVpkZHdOQS9FUFJtUlFSRHI1YUpMUldkUEkw?=
 =?utf-8?B?TVJyU1d2aFhNNVZVeXJCN2xhKy9EYWNBTGF4NjJmQUJNWkZmaHNiWGNlWXhp?=
 =?utf-8?B?UVVMUjZ3a0VNYnhKcFlocWNuZktLQ0dHTTlzbFE1dWxZUXZXYy9EbDFhY1hX?=
 =?utf-8?B?UFU2WFd3T1ZpU0FBUk9qSExPQUx0Z1J0L0tVaTV4RGJvMHU2Q3VySC9zNThX?=
 =?utf-8?B?N1ZTTU9xK2NwRWR1RkJWV28xUDQxb0FyejB1VUlPRnNSWis2OFoxNi9xQWZv?=
 =?utf-8?B?K3lSY09BR1BxaUwvOEtGNTV0WHR6cHRjMnJHakM4cTQ3SThVemNMUzJNV2Yw?=
 =?utf-8?B?VEgyMWpGSlRnWmt1T1lvQm0xQnJDN2JKbEJ6WTB0dXlvR2RJQ2xJNGRqSENx?=
 =?utf-8?B?VXJxT1I1VWhkZVlSZDd5SDl2NmJmSjliYmZMWkFXSXF6cGZwenlydktwYUp3?=
 =?utf-8?B?ZmZ4aWpoR0JJc2RnejBOMmlCQU1PK3R2M3FtQy91MGQzc1IzREtaRkQ5U3Fp?=
 =?utf-8?B?SmV2emVSenN6VEVpWlZQcjFPYzVXOGJycWtLOEdBZWJGcTVkK3Rwd3dnRjBJ?=
 =?utf-8?B?cWJMUm00eFhmb0dtdDRYVjQ4TFEzUnh6TndTM1pQWnVuTktrSEkrN3ZoMCsx?=
 =?utf-8?B?SHJpd25TWEhHR0I0OEN3cDVVeTVPaG9teWs3SERUd3oveG1TSWhlRWZFazJ0?=
 =?utf-8?B?QW1DWlVDZUNLT3UydXdVMEpZSVpOUkxkcEhIUEtyN01jTDRheTc4VnBtK3hH?=
 =?utf-8?B?RmE5UFFtZ0xEcGNKb1ljTTlFSFFEWGxsdEJZTnZianBTTWhURFlIL2kwaUZN?=
 =?utf-8?B?ZUYyMWR0Ym9YVWZmb1ZSaGloTDc2cXoySXRpcEdRRlFKdW02RC9Xbk0rMVdv?=
 =?utf-8?B?N3pSKzZuMUdYMWdBMCtZMnA1bWJYaUh3d3FvV3I2K05FME1lUE93SU5NMTBz?=
 =?utf-8?B?Y0F3aWNKT1RKblBidDNtcXlCczI0OHE0ODdHRlpTbU94NngzVGhnaE9LbUM3?=
 =?utf-8?B?b0QxS0NuazN0ajN6RW9STzJ2OXg1aVVxbDlzZmlHdEJmRldJYWc0R3JKaFBV?=
 =?utf-8?B?UDNENDZSN1cvVHVBK0VpM2h5cG8venBwaGlrU0R0TExaS3plMWgzODliaS9q?=
 =?utf-8?B?czFxWkRiK3l3ZFVsTk13am9XbGVTSmpBZHpLNXErZko3WE8vMHlLdzJSUmhn?=
 =?utf-8?B?TmduRU5xNElUeHZabFErTXkzUDBnc0cydXBZclc2NVU1REZ6NS9Rd2ZtTEd1?=
 =?utf-8?B?VjhRK1BMQWFBd0diTDZvekhFSmtpQS9OMTF3MVZ5RHNJeEdtenExeGNMOFJm?=
 =?utf-8?B?SGQ0Wi9xckYxTVhabU5IYTJSV1hmaGZsOHRreUd5SmxpaTNMTS9qVVJsK2hE?=
 =?utf-8?B?VU1ub1JHQ3NmWDhWdkxGZFZCZ3dtZC9XakxRVnVlY3ozYTF4dzJnTHFmMjRN?=
 =?utf-8?B?T1UyUTdSVGV0REFaRGNIREZOdnordHVLTG03WExycG5BeER0cVVxTHB0MlJJ?=
 =?utf-8?B?MWpjSWdxejJwbG1OOW0wRXF5UytKYmZLYktYcm5rbHJKKytoY2ZuRWJrNitn?=
 =?utf-8?B?OCtMT2JZbmFhanpHZjdML0xOY3JjY3hvbkpGUnU5UGh5UlFZNzdNb1FBTWxk?=
 =?utf-8?B?MHYwUkN4S05tNy9KQVJmNG8wamswYWxHV1JnMXNLeFVCcWYzcHhCTVpCWit4?=
 =?utf-8?B?S2svMnk5SzZVelp1QXBNanFVYVQrT3psMVFnYnN1SmlScFJlV2EwMUNnKyt3?=
 =?utf-8?B?QkxyaEpPbWVwTG82bWRUaDg5ODh2alB4OE5NbkFmcmpQeXpTM2RCWHFKT29s?=
 =?utf-8?B?MjNXcHhUR2FRUy8zN3lKWUVpcUJlSHVOa1IyUnVEYUhSZnBrRDcxV2dXUG9y?=
 =?utf-8?B?MjBRZGFTZ0FVbnRvVGx4aGx6eVlieDAzUXF5Nkp1SlJkamtiZHpDV05lY3dU?=
 =?utf-8?B?dzVrVW81bURwWDlnNFpNcHlTblZLSU5RQkozclJkVUpHUlp2ZXNFRlQvZXA0?=
 =?utf-8?B?V3VVVytYbGhmS0Q2OFROTE0yc3pieWZ1T3VHY1ErTksydzE3SUNWN0hEZjVG?=
 =?utf-8?B?SFFjcXBhelcrT2RhN2R6Q2JlRWFNQTdpMm00T3VGNDUybFZwUjNhZXZUYzkx?=
 =?utf-8?Q?xg+E6XZk2E+Njf4zjTRn6aU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDBDFAA4748664DAA8779DD21A6D887@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB6877.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f24eca-d196-4bb3-537c-08dd55b32079
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 15:43:18.8059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSlRqxM5opcWJHxaODkGtPLk3SoKvsxwXam5KC5aSUPOi7H7Swlat+wm7cS5KzMWfyIRokGfHdKByLVfvAnETeXW2+rthMRwzWlr8n3caPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5268
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

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDE3OjE5ICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gRW5hYmxlIGNhY2hlIGZvciBKNzIycyB0byBvcHRpbWl6ZSBwZXJmb3JtYW5jZSBvZiBDUFUg
dG8gYWNjZXNzIGRhdGEgZnJvbQ0KPiBtZW1vcnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGlu
dGFuIFZhbmthciA8Yy12YW5rYXJAdGkuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2
ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiBU
aGlzIHBhdGNoIGlzIG5ld2x5IGludHJvZHVjZWQgaW4gdGhpcyBzZXJpZXMuDQo+IA0KPiDCoGJv
YXJkL3RpL2o3MjJzL2V2bS5jIHwgOCArKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC90aS9qNzIycy9ldm0uYyBiL2Jv
YXJkL3RpL2o3MjJzL2V2bS5jDQo+IGluZGV4IGYwODVlY2ZkMzdlLi43OTNjMDI4YjUzYyAxMDA2
NDQNCj4gLS0tIGEvYm9hcmQvdGkvajcyMnMvZXZtLmMNCj4gKysrIGIvYm9hcmQvdGkvajcyMnMv
ZXZtLmMNCj4gQEAgLTgsNiArOCw3IEBADQo+IMKgDQo+IMKgI2luY2x1ZGUgPGFzbS9hcmNoL2hh
cmR3YXJlLmg+DQo+IMKgI2luY2x1ZGUgPGFzbS9pby5oPg0KPiArI2luY2x1ZGUgPGNwdV9mdW5j
Lmg+DQo+IMKgI2luY2x1ZGUgPGRtL3VjbGFzcy5oPg0KPiDCoCNpbmNsdWRlIDxlbnYuaD4NCj4g
wqAjaW5jbHVkZSA8ZmR0X3N1cHBvcnQuaD4NCj4gQEAgLTIwLDYgKzIxLDEzIEBAIGludCBib2Fy
ZF9pbml0KHZvaWQpDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4gwqANCj4gKyNpZiBJU19FTkFC
TEVEKENPTkZJR19TUExfQlVJTEQpDQo+ICt2b2lkIHNwbF9ib2FyZF9pbml0KHZvaWQpDQo+ICt7
DQo+ICsJZW5hYmxlX2NhY2hlcygpOw0KPiArfQ0KPiArI2VuZGlmDQo+ICsNCj4gwqAjaWYgZGVm
aW5lZChDT05GSUdfWFBMX0JVSUxEKQ0KPiDCoHZvaWQgc3BsX3BlcmZvcm1fZml4dXBzKHN0cnVj
dCBzcGxfaW1hZ2VfaW5mbyAqc3BsX2ltYWdlKQ0KPiDCoHsNCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
