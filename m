Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFB7C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9E088AFF;
	Fri, 16 Aug 2024 14:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="GcK5V811";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2D588B64; Fri, 16 Aug 2024 14:40:19 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F27388A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iABSOurfT/iTaAj75IJNJN4En2WN2VjYKfB66XVrajxKhCP4yv+xi8WVltS2dkIpYfNTd4TvT1jY+xDl1lPE2t/zy/brMT3zd3AWgv69lwa8S6+eNi7zta+JRmFBPYdo5Km1+grjHS0e5P89bWAtXRAbMNriOnFrkMSVoKN8ynR4/Tx3Rtsz7h++rOg8F3Otcd3HEMBTBqAtT3uJra7DoQEYo5qnbm+yYLpjF3ELDHqfGIIU885IrXw6hl0+ZnDShcCQJOqlJ/L2gF02PZS/d4AV1vyQM9OuOXiijVXP7CxWgRRp6Fwce1BJBbjrhlxw3Vau/DjCoan3h/+QoA6Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJT1UmbqvtoaUqRS8IcYHYlPbyNA2Q5Zl0NoDu66Tes=;
 b=HVmzJZv9obXzBwcQaZRb+lIoYa9anyJys9m4NhG6uer+RnpReJCVny+CZsMBe6N4k1TmFiZEikSBB3dLDql7L7dnFqcr4w0tIX/kHE/281lkJxbMAAeKL1asJbPN+5C8Pu2d5TpxWvZE8+3wAyEnaRTDYTkMtaFzwS3XNYxduOBWxnQHJVA6svcsHXfHB1Es/dHJvfl3yrKrwpzlGkMxjcyMRt8n3iEz+M/s39mVM+k0AnkBs2/D+/o9hRIAohFM7s0PpH9Jlr6+5gTi8RwteEX34BCqBHarxFolVuFY6r2Fa0AJ8HLIuQuX3yC9tU7Lnnmd3ShjrYnaJhw67Qa0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJT1UmbqvtoaUqRS8IcYHYlPbyNA2Q5Zl0NoDu66Tes=;
 b=GcK5V811QIJkobThPpigQo0CGSGMDHlu3vIL64paJujRA5W2jG0oyHwo6xGq6IFe37Cs935YNRs5niSKMNxfXMFj84HmI3tV9NcSxx1Hhy9vWQT4Hjx7gSvDIdjfiTAwx22B4kPxSk58UA1gfIix6JGEjst28hJrF0Pp5srBo/jqtfj1YAoWhmTvtn13QLTueMnWU2lh5DPyDAb32psMl0RNQoaRo7Fl88k/v/ZE8CwEMgfm1haCK7HmuWLZYMsJbPUCcAfG5vR8W6LeAJ9C7+NW6EpIpDu+LGwv267EtwjfADpPtkTUv9IjHYZUmbDP+fFNfr++zGRUBc0Ve6ytWA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 12:40:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:40:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 06/10] arm: mach-k3: am62x: am625_init: Probe AM65 CPSW
 NUSS
Thread-Topic: [PATCH v3 06/10] arm: mach-k3: am62x: am625_init: Probe AM65
 CPSW NUSS
Thread-Index: AQHazpbyu6QtjUgqVkKoRriAIAbUDLIqFauA
Date: Fri, 16 Aug 2024 12:40:09 +0000
Message-ID: <2fbdb9e9129cc2a8b26939f00c2592cfd29dcc93.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-7-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-7-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7459:EE_
x-ms-office365-filtering-correlation-id: 5b4cb5d7-1aa9-4c71-75cd-08dcbdf090c0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UStoQXRWbml2enlKcHR3NU5uYVA3SmVEbUM2LzBJeisxcFBJdHRjODF6NFVO?=
 =?utf-8?B?MHNQK1h6c213dWkva2JEQWVRS1RMbHhDcndtV0VOV0k3RFZWRkNRVWVQNHdz?=
 =?utf-8?B?aVE4WmQrd1p5aVNjQlErS0RrTUlYNjJBeEJueW9QME9IREljOHBmelhYalNo?=
 =?utf-8?B?R3h0SkhzY3FPQVltRGppRkJXcnU5VktvWDE5SUFBcWpKMElzejF5cGg1TktB?=
 =?utf-8?B?UXp1Vzh6bkhybnYwSHdSajNvUFRGOEcybG9FNzNwVTVWZG92NHF1QU1VUmJo?=
 =?utf-8?B?MGs2VmgyU29uRE1WcUZGbDdFbUZuM2JtaDdCb2pFSGdqNVlZbU5sUUphV3Z5?=
 =?utf-8?B?bFp4RU1EbHlTVzl2TWc3M1RqNm0yMTY5WjBCY0tsL0ZNcFM2Wks3T0dhRWVM?=
 =?utf-8?B?UGZKVDV4VjRjYjJrblFCM1JHMEdEN3pFMHJWZThabGdTMWZJY0FKa0J1M3cz?=
 =?utf-8?B?bHVlVkxZMGFRbk1LSkhQeWo2K09SWjRuNnlHb2xndWViVm8vUTBTeXVLUmNt?=
 =?utf-8?B?NWlkMTFlMkRFbm5zN1VCR1owWWNkM3d1a05TWkkyNTRZQldrZDgxc1NId2Qv?=
 =?utf-8?B?ck0xaUlQTnMxMzBpdllaY3ZmalBmL3lnakVoeGpLUmpkc1V6M2NvWitPWUd6?=
 =?utf-8?B?aXZ1Qnp3T1VsSVlnVXRXemc5cEVxVDRhekp1aVArSUI0Q2grRDIwcGdxVW9I?=
 =?utf-8?B?a3V0WnBUc08wUDdJaHZIYlovUkRFbTVNWjdVc3czNzZJekxsU0JjclowYy9T?=
 =?utf-8?B?NmJZQUNva0dJSlNxQmdSaXpNL3psUUl5YlI3L0FEQm9OWXQ5bkFTVGI0UEJZ?=
 =?utf-8?B?WXNVaExaSjdkVmhEOEgxSmpVRUVkTHdZREF0dDRyU0djQ3dMNmRCalJxdFJM?=
 =?utf-8?B?N0xOMkxWR0pveE9yUlRvdzZ5c2FidWZEVytoVlFTbURQaktMUWpjeWI1dlV4?=
 =?utf-8?B?bnA2blRjbnY1SDhXVnVTZlp4bXZQaGtvbzV0S0d6b0NURWhFMDNhaXNVOU56?=
 =?utf-8?B?ODNEQ2VodElQeEtxWityNERDRUpaUmFaT2d3MEtpVHhLZlNoYVBVRnptb01O?=
 =?utf-8?B?bS9lSm1reDRBVHVadDRaTldYNVlrSGFwcVRKeFBUZUo0c3pwcjZTNnFGSE0w?=
 =?utf-8?B?NitEekIyc1JySW10cWlaZi9DVmgvK2xGbnNVRVp0Vkl4OGkxZnF5UDMybkhL?=
 =?utf-8?B?cjhlYlQ1Qy9xSnJEUUVhaXNrS2g4a00rdVp6aXFZajdoc0hucFBDaDZ0MnZs?=
 =?utf-8?B?eE5La1FQKzlteDNMcGhSZE1iYWtnMFpQVStHU2RSL2dEMzhSOXZxM0UvS0Vo?=
 =?utf-8?B?alRkUjEvUGlFSy9VenVXRDJqb2RKWlNDb0FXWjhQS29OUXNyM2drdDNGZEVT?=
 =?utf-8?B?T1Z2VDBnOHZaalA1RXU2K1BaRkVRRVZoaWRRZFRibWNDWUtETjArZlI4eTY0?=
 =?utf-8?B?NlliTzZPZkIxUEs3MmxsT2xWQ2xUWDltWUJCZlNRWTlRUHdFcHZDY08zd3JV?=
 =?utf-8?B?dlU4NE5OcGJBSTRlbE14VDJSZndoZzZBSm94b2g1V0RuWmdkbXVMdUZ1U0xh?=
 =?utf-8?B?OVUrREdFRkxDNklxcFhHbGlKelN1Sk5mNnJUZDdIRVVkZVhWZkFPWmNoM1g1?=
 =?utf-8?B?QmRtQTA1ZjlBbEtKWmN3c2o4VHhQa2psSUZlVjE4N2VEQUUxMEtBbG5nc2lQ?=
 =?utf-8?B?akc2ZVA0NldiREh1N21STk8yeWN6eHY0TlFZK1p5SkVqbkJQMGQ4bWI4Q005?=
 =?utf-8?B?emd5KysySFNsYzdVM2hTZURXU3ZqSkcvZ3pjdU9pK2FlVmpGZm14K3VKV1Jx?=
 =?utf-8?B?VFBRbXdjRXU5KzFhNUJzSFdQOHRqZFFyV1lOdW80bThoeUlpdS9QbFNMWGJ3?=
 =?utf-8?Q?YeA/WWyDKqnj4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9yOXl5UDQ4VEFXb3N2VzJqNTFFbGdxdVhybHJXQ2hWOGtJY1pqTGwzWTI3?=
 =?utf-8?B?WWM4UU9uYklhY2ZCQnh4cGY0TGkrL2J5N0RrS09vQ043U1Eva2dUb0MvMExN?=
 =?utf-8?B?NCtiUEdaVFU5aFNvV0hYb3ZFdks2UFlPUDhxUDdOUzBPcVIrRlA5cHdZM3E4?=
 =?utf-8?B?cTZYZHlCQUQ1akVEaWt5Y3VRVlpnTG9EK3EzN1c2Ukk2SmhmcGhNMU1UWHli?=
 =?utf-8?B?c3NUYjNCUkhzWUVUTVg5cDQ3VUMxYmtVUkxZdXlROHloMG9JY05KTk02eWMy?=
 =?utf-8?B?bEthaFM0bjVhVTZKRzdSbXVWVzhMNDFyRFF5dGJmZGFjVnJTK01oSnI2d1RS?=
 =?utf-8?B?MkdSU3RhazIrVlVGcjJxLzAzdm51ZllidEs4bEZuWUdNemg3ZEhHZVE3SmpQ?=
 =?utf-8?B?L0Q5cHJDZzBQOElYcmtZRHlLZmJ6ekZlVjl6bWNUdUJmWFJVNkpMUDJyR1JE?=
 =?utf-8?B?ckM0YTY4M20xUmRCc05rSTFIRU01QmpzaVVUWUJoY0x5WmlPOHl5OTY0cEtw?=
 =?utf-8?B?ODFRT1dYNDlJWWtmWXZibWhPbVdXVTg5V0t0aGVwSE0vMlBLMVdmcFQwNjlu?=
 =?utf-8?B?bXQ4RTNGTUI0QkxIOGo4TTVBL1NnZDgxakFMM3RocWRzY0M4dDVKemNJUk1o?=
 =?utf-8?B?czZDRUhBNzNBRnN3T3o1R0xZRmMrYzhkRDZpMG12K25xb0lRSHdQU0RQMXNR?=
 =?utf-8?B?SFl2dG84bzJ4UVN4Z01FZFA5V2J6cXZYR3ZJN0RhTFVpOHBPcTFMUGFrS29G?=
 =?utf-8?B?dE90cXJiSFBHMzdGbzZXc0tMZXZFZ0pCb2M1NnRoM0lLUlhrK2J2WHkwellJ?=
 =?utf-8?B?RjlaaHhZTTZlQzNHZ1g0OG51My9ITEM2dzVFS0xjRTZBMFZkcktOSkNFTzlp?=
 =?utf-8?B?eGV2d0hzQWJXS0pqUS95OVVLd0hHanRwbm1SRzYrSEgrSExJbjMxZzNxdlcz?=
 =?utf-8?B?WldCaEFFbXFHamNvbUgvNVVQUXAzRmtJME00cUYzdXJBN2s3M2pxRmxKY3RV?=
 =?utf-8?B?TzRaeTVwT1JyZ09FRjlIeHZaRVp0NmpzZmlONkZIbVhsVGZRWlVCMWlLKzZL?=
 =?utf-8?B?dFNTNy9JNW0ySmlmZGRZTW9xeWs2bXVDdStLTDk5Y1lLU1FTeU5NVTRrbDZj?=
 =?utf-8?B?OWxJbnZ0RmpsbEhvbVdrelAxbXNNUStCUXlGa1Q4ekJ3TEQvYUpMOFZXZWRQ?=
 =?utf-8?B?c1NsZUIwL0pvMmhVaXYrTGoxWnJkd01McFZJN24rT1Z2VndQQ1JWaXNxUHpl?=
 =?utf-8?B?UUIzeWxRaXBhbjNrVk13NU5wSEROY3pwZmpzNldVWTZza1RyOWV0MU42RjU4?=
 =?utf-8?B?Sm9EY2RBNDdQd0hKMGJIcHF4K0dyU1pBUUx4TnlqTlpzbzNsTzl2MDdxcmZR?=
 =?utf-8?B?VmRVT0ttcy9xUUpYTFE4ak1HOXlXQ3VadUlkc3VWUC93TUc3aEc0VUd4RXVw?=
 =?utf-8?B?VTgxS2hLUFJlRjRvV2JZMWpIT1ZNOVc5Z04vOVp1cHlGUWM0Tkpwb1VYZDhW?=
 =?utf-8?B?YnVhR1VTbjBZV1owQXlTSTZEQzhBU3VSTFFyY1EyNW1ET2FOUDE1YWxubDFF?=
 =?utf-8?B?QjdMbU9mTnRlcXdPZnZLSThyQ0w4ZlJycC90aDZIajhzeXdmRXlucWNuYmt0?=
 =?utf-8?B?eVNOUFhwU0hyUTFjWjZTQXNpWU9LdlJaOGlpWWVJeGIyK05HOUg5S1dxV211?=
 =?utf-8?B?Y3RlazFMWnlPMzJJUm9rZUNWWTNYRDJqTE9SSUlHcU1OcW0rbDdzSzB6a3RX?=
 =?utf-8?B?VlRwWnh4YngrdFk0ODFoVjRjVnJNV0xDQkpwOEdvYU8zYldFWHdud3Z5RmVr?=
 =?utf-8?B?aThhQ0hYNHVjbThiNXBHK2VDcWJKOCs2SlM1MGdnQ3pLUnVldk9RRjhNc1Jx?=
 =?utf-8?B?OFlTSnFpOWxZYlcrQTM1Wi96S3JIU2wybWs2eml3TUtsRC9aNldsZUlaelFC?=
 =?utf-8?B?dVVTUlVTRjJyZmdLeGNWSFFRcUtCVnZzZXkyazZLZys0WkxtcVVManhQU3Ey?=
 =?utf-8?B?YlE0TjhZeTltNGwxcVQvMnlNb3J4WmViRyt5VDNyVkk2djkzbXdpbzlEdlMz?=
 =?utf-8?B?ZG1CbHNoQy9aaEpzUWFRZ29yYmQ5SFpSd0RyRUlxeDlHZzI2R2Era2h0TUNa?=
 =?utf-8?B?U29hZkorb01kd1Zud0E3UnYzQ2VEODZaanRiMjhEd1Z5YnpQNEF6a0F5TVZ4?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F9EF946A6C9C4428D4320E8ECDBBDC4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4cb5d7-1aa9-4c71-75cd-08dcbdf090c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:40:09.7746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KakjMsgn11D0odjw04Fk1CUN9NdH8UaknieU8VkO9mcghhZseJxtIWDRSfKeYJf8iKonHqIO5mZZ8A1RCNkGd8Bc2cPvxTls5JdneDROP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7459
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

SGkgQ2hpbnRhbiwNCg0KT24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRp
LmNvbT4NCj4gDQo+IEluIG9yZGVyIHRvIHN1cHBvcnQgRXRoZXJuZXQgYm9vdCBvbiBBTTYyeCwg
cHJvYmUgQU02NSBDUFNXIE5VU1MNCj4gZHJpdmVyIGluIGJvYXJkX2luaXRfZigpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBDaGludGFuIFZhbmthciA8Yy12YW5rYXJAdGkuY29tPg0KDQpSZXZp
ZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5j
b20+DQoNCj4gLS0tDQo+IA0KPiBMaW5rIHRvIHYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjQwNDI1MTIwODIyLjIwNDgwMTItNy1jLXZhbmthckB0aS5jb20vDQo+IA0KPiBDaGFu
Z2VzIGZyb20gdjIgdG8gdjM6DQo+IC0gTm8gY2hhbmdlcy4NCj4gDQo+IMKgYXJjaC9hcm0vbWFj
aC1rMy9hbTYyeC9hbTYyNV9pbml0LmMgfCAxMCArKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWsz
L2FtNjJ4L2FtNjI1X2luaXQuYyBiL2FyY2gvYXJtL21hY2gtazMvYW02MngvYW02MjVfaW5pdC5j
DQo+IGluZGV4IDcyYTc1MmQzOGUuLjAxODJjMTUzYTYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L21hY2gtazMvYW02MngvYW02MjVfaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtazMvYW02
MngvYW02MjVfaW5pdC5jDQo+IEBAIC0yODAsNiArMjgwLDE2IEBAIHZvaWQgYm9hcmRfaW5pdF9m
KHVsb25nIGR1bW15KQ0KPiDCoAkJaWYgKHJldCkNCj4gwqAJCQlwYW5pYygiRFJBTSBpbml0IGZh
aWxlZDogJWRcbiIsIHJldCk7DQo+IMKgCX0NCj4gKw0KPiArCWlmIChJU19FTkFCTEVEKENPTkZJ
R19TUExfRVRIKSAmJiBJU19FTkFCTEVEKENPTkZJR19USV9BTTY1X0NQU1dfTlVTUykgJiYNCj4g
KwnCoMKgwqAgc3BsX2Jvb3RfZGV2aWNlKCkgPT0gQk9PVF9ERVZJQ0VfRVRIRVJORVQpIHsNCj4g
KwkJc3RydWN0IHVkZXZpY2UgKmNwc3dkZXY7DQo+ICsNCj4gKwkJaWYgKHVjbGFzc19nZXRfZGV2
aWNlX2J5X2RyaXZlcihVQ0xBU1NfTUlTQywgRE1fRFJJVkVSX0dFVChhbTY1X2Nwc3dfbnVzcyks
DQo+ICsJCQkJCQkmY3Bzd2RldikpDQo+ICsJCQlwcmludGYoIkZhaWxlZCB0byBwcm9iZSBhbTY1
X2Nwc3dfbnVzcyBkcml2ZXJcbiIpOw0KPiArCX0NCj4gKw0KPiDCoAlzcGxfZW5hYmxlX2NhY2hl
KCk7DQo+IMKgDQo+IMKgCWZpeHVwX2E1M19jcHVfZnJlcV9ieV9zcGVlZF9ncmFkZSgpOw0KDQot
LSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
