Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C6ECCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBD683F94;
	Tue, 11 Nov 2025 14:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ou9nWNJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D58C83A83; Tue, 11 Nov 2025 10:31:28 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8BF839D6
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzNHC9zpy2Rk34hp1unsTmbxYSG7bnK8RORNxuXydPwNGoPppMoq0kr21E6m6r7q+B7+EiY1FxdWBjYzqEdnz8nCT7RRgdzmNWPx0q6WohihYr0tiavYCJuWrrOyyvPGx6pRYCFDpYk3gBTzNnd4khL/YEHHd+JcGMmdu2w15blOtE4fC7tDLVZn1atWxtHowyOYlr+GuX7/bdmo1dVzI5zrH5ZfxLr8ISKEngBjF2J7KT0KHpmOaRjEL19jOqC3dIxZ3/2n273C6Ta5m5KTz8fvlY62iz0CvGX2+CVlTrduVZZ7Xsb1VXYJ8daXco7IJCR3m4GcZYbjgVeV+fb3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iG2DlJ8zn7ad5iluQsKB08OffFUfWfohTvIrJSPBWs=;
 b=cpIDBdiF5eNOV2z3qATL3qlBYKi+yGQRrNTldanU5NzrTLS7lQ/NuE/eQAXO8WWLSoP5UlH2jcXNGZ3NS/5SjrM/vjnVHgQLnKRxvm/PQzCDgPzJV2Q4tkILSyqAtSVpvrjr6yMiNf2D+6fKYnLJQKBGq23Uf4L8PClkRoROa0o7XjDV2XNL9/MJ+ew/j5erXuvM106++BHvihjc/hyZ592pJ6g/1Yvlhqm5DAKdDznRcZgvxxZIJ7G9C4hM6gxu8PYy0z9TI+y8Z3hV3vMqdEQfIf7/eVisvWB6LcSHPAhBGEV9WsqpiGFTrWdVjICm/GFDhOn08+nDVCa1Du5/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iG2DlJ8zn7ad5iluQsKB08OffFUfWfohTvIrJSPBWs=;
 b=ou9nWNJ/pa+jECLRE/luRwu2CXSc2a6bTpDgQEp/lQoycOnJNvIqEv64iFkLXUMjGrlWAOjjq1xw4nMurJq4ppbpxckYiRNFk1IbpW4NwdQ9yM9MayMDSvPZC90N66eGriAebM5bqyGkb/8ekncRaBPLZQtMp65CsbGBOkOzhbjoPrmHnnVUoZYPZ6VjKpC/du6Hg42bA5hO+wybcXs2LAeRtpwyPlUlaKRitdnBYQ6DUMCRtxQ4EBAHMnkh6zjGJ20013fGV0PlFs9F9BJSB5IwvSFPeBjyf1aURTDk9ULcCsqFYtDmgmvWFME4UAwVz7sRYn2KraCKX68UDQaIHQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA6PR03MB7614.namprd03.prod.outlook.com (2603:10b6:806:447::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:31:23 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:31:23 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Nikunj Kela <nikunj.kela@sima.ai>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Topic: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Index: AQHcGJsqNCZCo+aUvEi012yWWlvwT7R/OduggG5wOcQ=
Date: Tue, 11 Nov 2025 09:31:23 +0000
Message-ID: <SA3PR03MB71877E9BB24B98DB4120000BB4CFA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250829041232.1160655-1-nikunj.kela@sima.ai>
 <SA3PR03MB7187A45D6B0588067C348FDAB406A@SA3PR03MB7187.namprd03.prod.outlook.com>
In-Reply-To: <SA3PR03MB7187A45D6B0588067C348FDAB406A@SA3PR03MB7187.namprd03.prod.outlook.com>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SA6PR03MB7614:EE_
x-ms-office365-filtering-correlation-id: 811979ac-2522-4ecf-5f17-08de2105149e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|39142699007|31052699007|1800799024|366016|38070700021|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?68nIfsfaVW2wWelvqNUWblcVu310W8eewd+l9dHe2GCwciT50sdUbZoGPb?=
 =?iso-8859-1?Q?+d07Pp1AdnCn29HhdQDVmv2KGxiiYHWy/v/MuPuh8UyjqzRFg8ThW6MhcS?=
 =?iso-8859-1?Q?0MFPAJmp7ua+nNsnG2h7+LSA3+GtGoD+ijafV1RVnnlDAnrLbLijFQKdF6?=
 =?iso-8859-1?Q?Ie13DRNQoIrSyQkR5l+a2fEQsGq73NJpNAv85olkK8cXGrlX8L2qjaWoF3?=
 =?iso-8859-1?Q?pRcuHmbEUqsdNQd3CFot3e3QKYHYnm/fyiM8O2l9KBonQ87WJZmEqGvxkz?=
 =?iso-8859-1?Q?CKA0Km6eZPNCgRR0dgsPl5UdbFpvZoOHosGWcfVBhxjuL1LB04Pc3ro6x9?=
 =?iso-8859-1?Q?r8JSMnejqnobXT+c2pSbWidD7CUcHna0e28uLvSBWdapYwvgN9TXLxwZ/A?=
 =?iso-8859-1?Q?Fn7GDL/NJWPTlToWtMdB0tA9e8AKJtZ+/fHtSkYz5o/P3lq9EvsixxXAK1?=
 =?iso-8859-1?Q?PrXMkL3RWuwf3qursx+CJ1TP9HepVdD1P93qs+LxOXGjxriucXXjQF7juc?=
 =?iso-8859-1?Q?0OBKNhoqCIZg6nUHeMKtYsXQy5qvesJ6GA6U1nXyPewNMl0VDmzk8UgXl+?=
 =?iso-8859-1?Q?LRygQztgQrbAFyN6nZnN5HqtmJGSyWNZqd3JT7Z4E9Bod1NdsjGKSDjpFu?=
 =?iso-8859-1?Q?FWgq94R3rut75V/QNdSnjmJzQ7V9Qa17ajG2jLygeSGyf15U2JjzItsOnx?=
 =?iso-8859-1?Q?vtQQ0rVU+KSDNJrgVLotcD5FMBFo9QlIHHLsY88tg5R6fL9X3unZwJZhZJ?=
 =?iso-8859-1?Q?0Ja1ip5Jvj4XMp+MKEgHMfH45r18J8jCIQPG2Gy2pr4xkITrCqUBTCRbKt?=
 =?iso-8859-1?Q?FronomgRzoGTXkGmkwzl7EqBB1h/n1Dw6Wk7kVB88wb3MC+4snJC3RSa4F?=
 =?iso-8859-1?Q?W10MbHoUdnXYDo+ERABctJFCDa5P6cQVygJvpX0OOwHndtpgePJpNOx8CI?=
 =?iso-8859-1?Q?U/0dsD+Vfktmkl3zArMQr5+CdXJw3DDjpq3SLESOtd1+BRRcEyFfDybaNz?=
 =?iso-8859-1?Q?Yim9vh1JbU+btZcwaOiZu1JjOLExwXCMkWfOKxkMKDhq1qZJE08jtjiMbW?=
 =?iso-8859-1?Q?bG9LBALiAHInFqtyJ19icNB/Q98oLBNYTgbPgv45gufpbkQWav/Qez1UtS?=
 =?iso-8859-1?Q?1v6hkNArmNkbLeVl4zlgB5XOPengEX9yD5Cl5c1nMZEMjCbSEKkwZCQdUM?=
 =?iso-8859-1?Q?C7UrylUl2GUcrT3JSN2Nr4JZ2NLs5wzp6mt56gl2bZDUE5ATxnwdsEYQo/?=
 =?iso-8859-1?Q?1+XkSoS7IfAgs59tICCgxYBeIyIdpYhMrtoISCZpP3KUrachSImajYCQfz?=
 =?iso-8859-1?Q?HQXN/vytPPmnVSXvW8kWXLtOaaxL8XkljGTTsmJOwfy9/zOCMwhGl0JWNU?=
 =?iso-8859-1?Q?pQBpvxYOzF2hSWoULr3g7wkP0sQ3QwWRO7D3R4cHDSnG9RoBxOCHsVQ6BB?=
 =?iso-8859-1?Q?989NULdZlGMZxSMXTQ6SuqEGATiQ5hVFNe8uKbhcWQRMBTF3oeLU0N91ak?=
 =?iso-8859-1?Q?RLgacZgvjDvhKGWIWvvpcbE/2vVZgoArefVkfwrWstQJNmt+IepX3S5sVg?=
 =?iso-8859-1?Q?ohDotkXfRXAccy8SDOiI9RSWzDfJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(39142699007)(31052699007)(1800799024)(366016)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tn898jhaE5RfSZgwUanLwvtoSP2EcRDh7Rg46OsZ/TTxyJ6WBaleBJRrwG?=
 =?iso-8859-1?Q?DtyXP1+w7GfdWnYHFliiAevmk4J792mYBW5bKrfKuaXaEitFiJE83oJOni?=
 =?iso-8859-1?Q?VCfcMFxtr23qhbFT/liC4CJdWQG/WgYf3ZEGkCPKQKRC31tnBFbzneaYfO?=
 =?iso-8859-1?Q?jzcRr/1wyOw74jbpZIUtTEPLYEhF+4jQW080XC0cohmSVUBlg+/nSZUQva?=
 =?iso-8859-1?Q?ViEopgZgd4erEm3BgnStXx2EnGp/bAwD6c8AFNMZuY4sLPbrwF0Z6suqjs?=
 =?iso-8859-1?Q?c+Hco4L4w76rQ59+xToT/aIm5rH2uEjDadD/REo4EZaRUMv9Y8SeEyjp89?=
 =?iso-8859-1?Q?AfdjwFF6ELNxcUXPnscPtjAViQ1dmP7wOsowrfTBKBG1eFc/l3DeNpTpBt?=
 =?iso-8859-1?Q?oSBTvAgSSVGO3kMLfRSra0QrxUaJQI2ZJn8t13vl9/qtAhQ0Vk3061yqjU?=
 =?iso-8859-1?Q?hTi7BwqmNsHWjOFAGtsgHxKZ/42ByR558jwCmeSUXdUHLIyBPiF++x+A/n?=
 =?iso-8859-1?Q?r6nz7Y6hxTd4fHAb1eUt0myi+LGCFUGTcThYgrlUxE6bz4AER1qM3+P6pz?=
 =?iso-8859-1?Q?z/BoUaw6ShgFVWEne0Rykb6Xx6Uf0c46JDLKCiM0FYihmuTTSjnUut/qs9?=
 =?iso-8859-1?Q?R1NCuCY90WxPqajOE8REZ1IPhsOwd0fayZOZe8CQL9YkoV/o6cCCqGBWRS?=
 =?iso-8859-1?Q?xvSOAuGHvde+u7Ko8mdSUI/0uaIHfFytHojks7NyoVWCl+oCTwDoRFThUh?=
 =?iso-8859-1?Q?C1rU9xOb6RpYGkz1soMXBcbWnDGlO/3KZOKAAbwgSzoxg0mqVWsm2d2pso?=
 =?iso-8859-1?Q?9lrqAFASCxtDKU4W5KQXVyIDJh6PEvse3KTyU7iCHw0UgmC93Lanc48eJu?=
 =?iso-8859-1?Q?lwQ3U3hODs2FBRJc69qh0nAlYsVa1o6Wu5fE5Ww+IGw5wUwmCmJ9gNTmy+?=
 =?iso-8859-1?Q?nhsarOA/lwzQU9WIHd3fIkOcMU/RzGz7FGVJ+jsJ+qwEStsSSdDrCJISI0?=
 =?iso-8859-1?Q?kG20PGuHy/IyhGtgELXcrAWklWAUEubRKXZ/1svVtp0vDFwhHwYp9kZztS?=
 =?iso-8859-1?Q?67/l7B/6UjxixNlVPUaE+dPRd7Mh7s3Ds1a2bqtfnYJUZfzNVKslQnDKqd?=
 =?iso-8859-1?Q?8ST11QZFhUhLsNcTLx8wuuGBDAqKscWGDjlJQTF+hKaAFeKDmHwWNkWNCr?=
 =?iso-8859-1?Q?dG0K/8mZPmdMu5jnfy2tukrwZHybuzjXm2EEo0Bq6WIDXHvsKKiWk7TxWW?=
 =?iso-8859-1?Q?EfZSIQneTncJExY6PqMT2RrUcVSX010bf1aniAnaM2aXbGLIDhi/x8x7Q0?=
 =?iso-8859-1?Q?Xgfw1SJxBbKma5YGtbPqerHtCMS4wPzvMpDB39GBdN+p38rHpQ/5OKIJPN?=
 =?iso-8859-1?Q?R8YRgzt3HovejGpMY/zd1XggS6tBd/B5i6gDEGs70mvss2nw2OEsHbtKYT?=
 =?iso-8859-1?Q?UBjsWJT0Ybj/1pwlC2qljr/cmwl69bZ8vudijC5FR2p9JN9U6SdJL+xj9M?=
 =?iso-8859-1?Q?IeB6c5EMPUXVlZMD/G/P67lEdCmjyvtrb7jHLLeEk+LRElygBea4RkJNFg?=
 =?iso-8859-1?Q?0NKtfzqwv2gIugU9s/l93/1ioEh0ksoUWoxv2nfoRpG+qsnUfPhVK98+O2?=
 =?iso-8859-1?Q?tNseenNsOFFYOm/9rV9s1wxmA3XHLTnFRo?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811979ac-2522-4ecf-5f17-08de2105149e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 09:31:23.7612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkX/4Rb4A9oAlytHscYIOAWWBOFLqfjysq/pT0dsTYjvAYlxJc3KKGJUUmHFqbinO0Jukx8efWIwpMSkfMrv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7614
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

Can you help to take a look at this patchwork?

Regards,
Boon Khai.
