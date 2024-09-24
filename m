Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD4CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38150882BE;
	Tue, 24 Sep 2024 08:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="P+koT5Lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45066881C1; Tue, 24 Sep 2024 08:00:23 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9C2882BE
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACwtpamTgNdkV0h8hGmuSbrwvyaYXOgRWt+nJMYsEE3rpez3iubh0lqaebKLdCfET5G8PGPMxgvmCa+yDGCKndbIRjyjXrCgdyDiCApNpT3wbwU4GhtMFJH0YAQrrOy0ACDnlVGmRT0F5Z02Ug1jDmIlebL/JPNn4IhhW1bTK3HM9q4UP+n92P86cChJX1Spz6L0rFsPd7JkohqT/tEDYwi2WEoX/4ZwSJqQa0Cd/CfoHGtEJzhyOppdkve8MPBmP6qT4yg6BhI4DwJVtdwwp2g68/isH2QUJn+fHnPVvvU88mBoOt9aL0LfoHfaobX7cjERUA3V8+4qEY7fqANR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0aw5GopMx7x1rrjDHyuvWc53jGUvBmuffGFfKum7Vw=;
 b=PiibUMhn54B0XaHhx+eLfYV7WwOPjxeErFKkECkYfC4ep1smGQw+NVKkf3IhhEvcUhJPPham/OX+kH1siyxDLvTOaoDsS26cWoSK5CPkJ9yJQR/gcQ6AncofrFUiEXEibWJb7VSacV/aLmRJ3K+xfWWyGOuMU5fX9PXiJDi4n+IsLC7Stb3zdpYBSJyBfMDcT7qf2NkviuH5Mi4fGq9vniei8wNuI7arIpuqkx7Ej10lW1fxpPghQZ4ktdDwB7CBytbsVaYj7K30rRGKCZVgJF7A0Gyk7HBK22un0A1rQRr/j848WLfbHUNWt09qv6tnT1Z2ICirGPn2ZG6DMO+p3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0aw5GopMx7x1rrjDHyuvWc53jGUvBmuffGFfKum7Vw=;
 b=P+koT5LuKF/QMVo57JrjU/5MpgPlLmnpTNfPoRqnWty3LZZwXQfE20Rw/2fn1scMGA/xsKXhcPg11x9PklWxSA/gXYoUuoqgCuUmRmxMmzwPEtKHMaKd5qP8YQHxgHcQXkRhiSU2HcxbhHgmrsJDZ+ZTajJ3ynH1cfWuBIchSJ4FpN3hsjVInqZDsmrhOR1zTKCgR2nC66gANf7eFgg6IQqAz7FunkJQ53TavgHaqDXQeDIemfui8Llk3jmla2PeRKa/iyay9EkUjCd8Cky+25VgIqzBC7/2kbElncSDa/DOZLjdFKz85D+AL9fCGXUx1sUXbvgEg2pAj6TQ+EHgjw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8728.eurprd04.prod.outlook.com (2603:10a6:10:2df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 06:00:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 06:00:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Topic: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Index: AQHbDbGz4BzVcfPZy0Kz80Sb3g9sQrJlWL2AgADDeoCAACMsQA==
Date: Tue, 24 Sep 2024 06:00:16 +0000
Message-ID: <PAXPR04MB8459FCFA5C54A35E3A98136388682@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
 <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
 <CAOMZO5B7HLB8iLdo4YOzf7iVyTNaRA2Zv3U7B6HSvo4GPOST=A@mail.gmail.com>
In-Reply-To: <CAOMZO5B7HLB8iLdo4YOzf7iVyTNaRA2Zv3U7B6HSvo4GPOST=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8728:EE_
x-ms-office365-filtering-correlation-id: bbac0d8a-3dd8-48ac-e4d6-08dcdc5e298f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akFiL3k0Z3ZSVE54WUdXamwwbVloQVhpU0xpWnp2YkV3c3R2M3FDRlRPSFRa?=
 =?utf-8?B?SmovVExlbnNyZXBEZ1BvR0tRY1pZdzAvMTdGbDViU1Ezb0xGVDg3eEd4UUZL?=
 =?utf-8?B?anlDTnFoVWYramRWcTZJSllkek9KYmNUclMyT2V0bURkQXV0T2JDN3h6RzB6?=
 =?utf-8?B?TEsyNGp0KzlYblZDcWs0YXY4U0wwL1BqM3lsbWNGdEdzNk1uYjNwdnJRSENm?=
 =?utf-8?B?RmRMVTZ2WTRFa3lQUlh6Q2pLcU9UUHhnNk0xTE1EVmMxZWdJRVVld3o4S3ln?=
 =?utf-8?B?VUxwU0FaR3kyQ3VhZDJiUDFsUXVzdGU0aFI5Y3V5MVZBbTh6V1BqdEJsbElH?=
 =?utf-8?B?UjQrZ2JJRjZhekNydC9NMFExbTE0RjdxZGQ0c3BseFRrYlpHMk9sVVhiY1cx?=
 =?utf-8?B?dnFqeTZYdVJ1dlVneW93ZkF5SmtnMFN2dHY5VVlJZUd1dDhYK0ZQZTNZaHVX?=
 =?utf-8?B?WUVKaTNkajFzRnNBdjJveW1NRkgyRWtiVEx6RW0rL3E5ODdXWm1NZWtZQTgx?=
 =?utf-8?B?aHZtNmthUE5vZG45b0hsalNJRmYwMVA5R2ZBU3FqQlJ4Nzdud2YyUmhEZm9N?=
 =?utf-8?B?V1pIbnhQTVR3UVJZMG5YL1ZOdmplT2JiRFdvQVZoRUM3TWcxdVZFeStTVSsz?=
 =?utf-8?B?WWtVRE8vV0c0bHgwY003bGIzaVgwTURHTWdnRlV5QUVtV3NCbUJqWVJOZ2Ux?=
 =?utf-8?B?RFk1U1orZ2Q2RU5jbml3VWxFSnp2eFd5cS9Qb2ZxSWQ5T0dBNkMwVXRNUzhk?=
 =?utf-8?B?ZVdERFFWaFJNUEc1Q0ZONUlEd253Ylp3eFhjMWp3VFJHSnlxR1czM2xvdzI3?=
 =?utf-8?B?MENaQTF3aENoMUU2RHlySFZsQ1JTTUcvZ3VLS1lCTVhXZ1NYMFR1L0RJVWYy?=
 =?utf-8?B?dHpCSjF6S2hlWmJ1aUJXWFRYVHlLdUFWRXBKdWJJWlExMXhQRndOQjJTRTdX?=
 =?utf-8?B?VXFPbUxXeVVLN1NPYk43Nkl6WS9Zb3JVd0pvOG53eHhJSC8weTdGdkdKdlBm?=
 =?utf-8?B?MTM4VHBLVld5R1RHcFpiU2syang1Tk1hSjJEMEdTTnVXNXlyRkZQUlpZd1A5?=
 =?utf-8?B?NmJUdlJNdkdFY1pVZ3RJdEMzbGlWOW1CUHhhcktqV3NtblZNd0NBSkVrSE43?=
 =?utf-8?B?ZTlBVDc0TGFWQnFQOXVpVmxxYjJpemduamhXSHdsTHlucjMwdWZJRzkvVFFY?=
 =?utf-8?B?azZidE1KcFpuL0N0WXUyK2k1My9MZ1lxVHRjRTVwK1dPbkN6MkFzdVZzemZS?=
 =?utf-8?B?WTQ0aGlyb3JFOWNhMENsLzZVVDZLdnBXL3NsWDQ0T2hneU5xVFZwYTNOazQ5?=
 =?utf-8?B?VVIzcTJ6bmd3NDZyL1JCUEhWY0tNclplOE1vamkyRVlKM1RFelhxUUNOamY5?=
 =?utf-8?B?VERkaWFBTEZCUitSVVFIdzVUWHk4anFiRjIyUCsvNFFXTGFOQWJWTWZTZlc4?=
 =?utf-8?B?eGllSzJaWEltVlJ4UCtrY2JpaCt1MWRyTmtiQ2w5L1RNUDJQekgvSndHMlBF?=
 =?utf-8?B?b29UenoyTTRHZ1dTMFNGdzJNZlNNTWFiVWtKY1BkTUl1QVp5QUpaVWUwazRp?=
 =?utf-8?B?aER1SXdvUzFCUkFCY3I2WG9uWStsUVFSb1p4amdFUEZ3UWFya09tZVZCdlRF?=
 =?utf-8?B?bVBOekxUZm5yQkUrblNnUUMwMDgyTVJ0QlRXTW1zdk1MbC9mRFZrQloyQ3VW?=
 =?utf-8?B?anZDekZFbFRnRzZQOHMzVjkvYXBOc0VRVHpwU2tkZms1eDZzZ1IvbldQaFRN?=
 =?utf-8?B?NVVsQ29JMEhUbkNsLzJuVVJyaUtmQ1kvRk8rSEpwMXR6SDZDSDg0Ryt1M0VD?=
 =?utf-8?B?a3QwaTRqQmVzRDJGMXptdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZ3SWVQc2N6allnWFlKQlMxTk5wSHhnSE91ZUczdHJrQ1BLMWVnMkNSTHNF?=
 =?utf-8?B?THNSamRhdXVWKzltcGNHMW1Ha01nU3hubGpLWU5IQjB5SHNGODRscHh2bVEr?=
 =?utf-8?B?SjRLTnlpbjQzL09EVGw2cWZLN0R4bHkwaHduS0JIN2hyaGEySm5BNG5adkNC?=
 =?utf-8?B?R0dYUEtZNGRUcmR1SlpvY3RYcDJ0b1A0NjlKY3A1VFpRMmdDUWJuWVNXTmQr?=
 =?utf-8?B?WUM1ZS84eExuN3JNaFh1OXljZjZObG5nTE1VanYxRWoxUTd4Mm5mWjRKdWJB?=
 =?utf-8?B?QzI1SFJ0Tm1CQzZ1dlJ3RTF5M2NBU3ZwWVd1OWZ2MW9TTG1FQXlvWXBad3d6?=
 =?utf-8?B?YkphU3lOeDNJaS93U2VYa1FLdzd5VkZNMDVTRG1vbExMVnJiR1k1Y09uZ0tx?=
 =?utf-8?B?YmFjM3MvVGNoZzlmSDdySE13YzlaN3dOR05PQmNHVEVxWjNqR1V3STdlU2dr?=
 =?utf-8?B?MUNTYnNaVDNEQTVvU2ZKMHN0dW9QM0ppa1Y1cE1JUHl6RWVUd1Rxa3pLUDhC?=
 =?utf-8?B?VVo3UWI2QStrc0JWY093T1BHVU0vYmJidk5HS0hLMzBTUmFKSEoxaTJmNUlR?=
 =?utf-8?B?ZE9QMC94eXZsS0tzUzVuTFNJbkNZejFYS1pMRHUxd09FMU1IaWZNN2lia29R?=
 =?utf-8?B?ejEvTi9ZbjlNWHlaY2l1cDNGQjlid0Z3L2RoTkloUmhla08yL3h5ZzAyczFS?=
 =?utf-8?B?NzVuMHhHMWhLcEx3dVpVVE5CVmZIMXF5Q0ZuaVp2RUtFelV5STlwN1d0U21S?=
 =?utf-8?B?Ui85Y0twNkNraDhoSXlqaUpPMFYwSm85UHdEZXdZbThRRXdrSm9qS1VSaFpl?=
 =?utf-8?B?Z053bElGVU9oK3hiSW42REkvM1ZvNFRPSDZieXg0ZEptNnpBS2hEc2pOVVJa?=
 =?utf-8?B?NG9uUGdOcGtaS1NVTmNzOGdjdWJYcjc4SUI5cE8wMlNTNE1oMWMzTFZKc3hq?=
 =?utf-8?B?ZEhjcHhncVNXZ01JSkdRSVdpQzllUk02UWN0elBNcmhHdmFlaWRQZUxhTUh1?=
 =?utf-8?B?aldIcTRQT2Q5eHg3VHBLdC8vVzgwaFRKTmNxRzI5aU5aWCtLbEgxNFV6ME5J?=
 =?utf-8?B?YTRmRVNJK1NXcHRPN3JRT1NOT2xCalFLVFZwRDFVQkZrM2tteUg4cjcwaDZO?=
 =?utf-8?B?Zmd6OWkrVlRHaytYQURRUFJqUUkrSnFBRzNXK0FSQXdHTzU2TVdvTU1UeDV1?=
 =?utf-8?B?d2svWVU0cmFZUnp4U3RKZDAva3lrdGoxbkdHbEIxOXlIYkdGR2hpWEc2eFMr?=
 =?utf-8?B?TlBJOFhFMmViT1QrOTRRNndLbVliVkViNFpWbkRQb2J0a2Y5OExhdjd4QzJF?=
 =?utf-8?B?UFhYT1RxR05yOENKQ0ZEUmlmUDdjQ1FycFZBVjJuaTJFZXVPRFhtd1doN09a?=
 =?utf-8?B?ZG1nSzlqZERzUWpjMnhyek9mM01hWndKY0RDNVJpMFZQNEZvcTZ1TUgybWph?=
 =?utf-8?B?S0o1bFZ4VVNXVDdOaVRybDBJY2QwWlJPSXlFNUIxRWptam1LYzQzeGcvTGtP?=
 =?utf-8?B?OTIvbEQzdXRzSE5vY1F1eHR5RXFOK25RSWk5Nit0Rm5Qd3RPdDd0dUJiQ2tv?=
 =?utf-8?B?Tms1LzhGSWJwQzVDdXhPc3pmaUxuYVM0Sjd3d0VkOHJERlp6YkhtZUw2QzJi?=
 =?utf-8?B?UEtPMHA0RkZwbVA5aWNZcXZzSjlsSks4bkJZSU1BRHlhc1lYRmpzaUdCeHhW?=
 =?utf-8?B?T0hqVSt3OWQzWDM3ZmdGYWs4YXplbEJQSUgzMEdNK0RsWUdIYUl6TngwTDZD?=
 =?utf-8?B?VUVQUG4xWHBGdE1qTGhzMHFPcTdxZ1Z1QnB5NFV4ektQd0syNzJOUkM0OHVl?=
 =?utf-8?B?ZDlzNTFlVy9hK1VCY3lybm5GdEZNZDJ0Qk5iZUMwUXdmQ0xTTkU1V1BKVGFV?=
 =?utf-8?B?UmZ4cnZ5cmhVQURwYXErbWt2Ky92VU83QnlLcTJ5bXBRcExLelBrc3lJMk5u?=
 =?utf-8?B?S3pxcnd6TkE1aCtwaDBtSE1PaFVubmFYUnVFU0ljQXM2aVpuNVhNZGRBNisw?=
 =?utf-8?B?R0hleVRKeTJ1N0MvZVQxakZXSENKUTBSdzNIcFczVVl3cmVHV0RLUVExN1ZT?=
 =?utf-8?B?djc1aHhOeElTN1duV1kzZmoxamlmQ3djS28yNkVWekVXU3B6UTZaSW0rOTZV?=
 =?utf-8?Q?tnGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbac0d8a-3dd8-48ac-e4d6-08dcdc5e298f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:00:16.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xftfax11ZsYbVyqauWSC06myAQoWa4DJI7OFucaoe7yHjx0wmiHxaLHRnPaXoOwi10BMNxz3b97HlPINOol/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbmV0OiBmZWNfbXhjOiBGaXggY2xrX3JlZiByYXRl
IG9uIGlNWDkzDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQg
MTA6MTHigK9BTSBQcmltb3ogRmlzZXINCj4gPHByaW1vei5maXNlckBub3Jpay5jb20+IHdyb3Rl
Og0KPiANCj4gPiBIdW1tLCBidXQgaG93IGRpZCBpdCB3b3JrIHNvIGZhcj8NCj4gPg0KPiA+IE9u
IHBoeWJvYXJkLXNlZ2luLWlteDkzLCB0aGlzIGNoYW5nZSBicmVha3MgZmVjIGV0aGVybmV0Lg0K
PiA+DQo+ID4gSSBoYWQgdG8gcmV2ZXJ0IHRoaXMgYWxyZWFkeSBpbiBOWFAgZG93bnN0cmVhbSB1
LWJvb3QuDQo+IA0KPiBIb3cgZG9lcyBMaW51eCBoYW5kbGUgdGhpcyBpbnRlcm5hbCAxLzIgZGl2
aWRlcj8NCg0KTGludXggYXNzaWduZWQtY2xvY2stcmF0ZXMgc2V0IDI1ME1IeiwgdGhlbiBpbnRl
cm5hbCBkaXZpZGVyDQp3aWxsIHNldCByZWFsIGNsb2NrIHRvIDEyNU1Iei4NCg0KPiANCj4gV2hp
Y2ggYm9hcmQgZGlkIHlvdSB1c2UgdG8gdGVzdCB0aGlzPw0KPiANCg0KSSB0ZXN0ZWQgdGhpcyBv
biBpLk1YOTMtMTF4MTEtRVZLLg0KDQo+IFNpbmNlIHRoaXMgY2F1c2VzIGEgcmVncmVzc2lvbiBv
biBwaHlib2FyZC1zZWdpbi1pbXg5Mywgd2UgY2Fubm90DQo+IGFwcGx5IGl0Lg0KDQpJIHdpbGwg
ZG91YmxlIGNoZWNrIG9uIHRoaXMgY2hhbmdlLiBCdXQgSSB0aGluayB0aGlzIGNoYW5nZQ0KaXMg
cmVxdWlyZWQuDQoNClNlZSBmZWNteGNfc2V0X3JlZl9jbGsuIERlcGVuZGluZyBvbiB0aGUgbW9k
ZSwNCnRoZSBmcmVxIHdpbGwgYmUgZGlmZmVyZW50LiBJIHNlZSBzZWdpbiB1c2luZyBybWlpIG1v
ZGUsIHdoaWxlDQppbXg5M2V2ayB1c2UgcmdtaWktaWQgbW9kZS4gVGhpcyBtaWdodCBiZSB0aGUg
ZGlmZmVyZW5jZS4NCg0KUmVnYXJkcywNClBlbmcuDQoNCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gUGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWxzLg0K
