Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFCC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077FF87572;
	Mon, 18 Mar 2024 14:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="X/NImlZB";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="QHJO6iR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45DF875B9; Mon, 18 Mar 2024 14:08:16 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9414487527
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710767292; x=1742303292;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=34ihvQysKagQvTFhHNMihwD22kGe920QP17XVEnyGu4=;
 b=X/NImlZBwLJ3pACar9NhJPpKolqHnJh9YZlBwqoJoAcFyeHWZTOl2eNV
 aZBTewumxTCTA9XTYUjnEVgSM0U2r5dmweWkUBBjnkNbAq29g29OF5T5F
 uhA7JQvmvGRmOWSzifBubvuSfRN1lNd+iwjowgTGyozDtBzbFLER/rnYQ
 oPFXzqAYIKnv/LxUaVRfSt7rJMTdiR2nlB7zxEUufl7VmHowm1qtcZ7O1
 TGE6DSn7QzdsWnNS9NknJAXhm9oQ1MlX0kJVdEyj5PIt7nfZxNqGhgGx0
 it59QE6rh+XKYrcCeQNAFriwU0YmIq/wjstxd+brmXOm1XRktg+gazaYT A==;
X-CSE-ConnectionGUID: KMAML3YBQRiaXpn5MiBYNw==
X-CSE-MsgGUID: KkF4QTEPQaq8+PpmyGNC0Q==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="18320332"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 06:08:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 06:07:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 06:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VufvWDSkppeWfPI7cODQy7mwH49gKNElWwQkolCZqHGSsvrbbvbmWNcY2sXt0dDTWmbS5Emu/qOdWugvjk+36B5RYxSEvxrDxqB1HBc1SISF/DFCfftrI+LAsrG+CtiSwY39A6N19SiBRgxkv5gTuRQRgCjw+KKfgpGMytLHnQmAEu23JNya/AhbrifFMth1GDLQhRmaz72vHpCvbvN3BAoTkk6Ce0YjV1qo23f4+RZIWyEMykxO0tsNLik9rxYf6zqptM5DYYewXWaEd7K/pLRL4wjjHrakxoqsiw7Fqid4jadi+Iz6ST9rhYfugkFITXR9rIAVyfYX/5VisNMw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34ihvQysKagQvTFhHNMihwD22kGe920QP17XVEnyGu4=;
 b=dENZoLd6WVXfaP0KTsScfVFBpRFhqOuzAGcXWwwulI5Civfi3mip6uSXr/nRbAw7FlddK1opruFqDTNqfIoA+6cNugjzSg4d8/nlbtSRJz1hxU1ole3gSZQx0uW1X6mKsPJJozdThbtacbFHo4yKi36a8b/Notnjn7zG2EcB2MHQmPGfUlCFiZ+Efx7bsSgNx6Vg4EvETxCez3veZBIlv/uyrH53au4SYNeLgfgyEbEypdDaLhhCOaO3jTN8kEv/259aQ/9PjMNPMW1vVId1PvajcL66BFkYVIZxtNBJ8qYHPBauJDV7x0WiDJvcyKAbfLQodxJTP9bkduDcTNaM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34ihvQysKagQvTFhHNMihwD22kGe920QP17XVEnyGu4=;
 b=QHJO6iR3eQC2QRUsdJUbVjSEG6j32/A27Lc1EeoV3PzMa8XnJzPRDaB91mGUGhKWDdHC5aEpEzXIiK1EV2Pbdbw3lu//wD4ijB0xe0Q3dvxD+QZi5VK3AY9hJz7q7i0jFRb0uHB0/K1X1EPqsD1S28x8P2gF/trqvRkUmTQzLU1eT4F15SIezyt47zMODls+KsQ1mUDqY1K/A19H+FOfZz0O8ADmzMWHLx12fgD3XO32issERy+Ek53IklFBFvVWxvVgarWiR+6rnhcvx4WwDZLWXCxYvBI+e5ryVYvF9TjuLPRJllf/MmDquqOfCMoke+pGp0IUbO2oZMx2aF+JIg==
Received: from SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8)
 by PH7PR11MB8034.namprd11.prod.outlook.com (2603:10b6:510:247::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 13:07:37 +0000
Received: from SA1PR11MB6805.namprd11.prod.outlook.com
 ([fe80::2eed:8873:4ff5:1976]) by SA1PR11MB6805.namprd11.prod.outlook.com
 ([fe80::2eed:8873:4ff5:1976%4]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 13:07:37 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <eugen.hristev@collabora.com>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>, <Balamanikandan.Gunasundar@microchip.com>,
 <u-boot@lists.denx.de>, <Bin.Li@microchip.com>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAANRwCAAANSQIAAJy6AgAAAqiCAAAzJgIAADQMQ
Date: Mon, 18 Mar 2024 13:07:37 +0000
Message-ID: <SA1PR11MB68053E0E3F7BE4B8B2F224F0822D2@SA1PR11MB6805.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
 <PH8PR11MB68045C740982A66703188E70822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-crate-glisten-c4ee6f3469ea@thorsis.com>
 <PH8PR11MB68042D7DF9FDA068033F4CEB822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-rethink-krypton-c8479159e755@thorsis.com>
In-Reply-To: <20240318-rethink-krypton-c8479159e755@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6805:EE_|PH7PR11MB8034:EE_
x-ms-office365-filtering-correlation-id: 00b7215e-9a10-4d49-e4ef-08dc474c624f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9wtAzBmj7S5gXC+xArIr1kzCEhbLfBYXC5txbOy2d6bZvDEXTevllDrq6InnpnXUmXYY+h+ggBMyVfPQ7X+vXw4KpQByBdnz2V/7lcJUFb+zk+rAmX7uNcc+pIyVuozrVLFb/MJeFNA6LyT/SlbBw+tKzeltu9ToqPNKvJ7t29vE/9YkTS9bPgFdxX8tpv6QmsjBz7U7rBIyvIZJVQHMaSGm22HgAFJ4rAcpQiiynPyZ6NzfTwGv375ZKNwfTsHMjo5ZD1SnnbxzdB1fnqLJ6whZDvm118zFq0NgBNL1Bve1LZK+LkR+6Wcqku6kq0kOrRySW7rJjpOOWyduJIbX9miOqQV8Edr+YgYsQytpuF8aGiusJLWG7GMJT2tiYHHhEvUdRaNz4emzFc6p3FlU0ASMugxP5ENeXNeyJn8bE7Z1WREyWFR7uN1b/exAiUXzletIpqtlf2x2ddfyd8IE/QhxQJtjgmKWvaNnK8+Z/IX2nQjrc9LP4Mjv4uRlytB3E7QOESBUVZIJrqhp/og0oDeocqkDlAajNJzcalRmPwfyg3i9F3bCgIyDohY3abV//QQ9tYrkdIRa3/WeQ6srQMAJLQ60H8owleSa47D71Lt+zOsUzk8uBT87+RhHc9Gcykz3UJj3rTLyVcy0U+7JX9KeF462y7p+IYCj3cF6pc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6805.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjQ1bHF1NS9SV0I1dHhhMkpKRnk3WENDb1FOeEsxY3hRMXcyMjcxcGk0UnBu?=
 =?utf-8?B?RnNTN1ZCZGphdE1ObXNHdElidzNNVCtWUExuWnVwWTZSMUhrS1NySERRa094?=
 =?utf-8?B?cEJXZXY1anBnOXBRNGFDN05rWFpqb1FXQUM3dGg0QlVOMG5WQk4yQVF4QmE0?=
 =?utf-8?B?KzJGc3FhVGlJOUtMVS9TY3RPeUROejBQbWZpZUtCckduWVA5TXlSZDJzODFN?=
 =?utf-8?B?eE1FaHBFcTVYdlR4RGs5K1REU3hlZE1abjN5bGxIRHRacFZsYm1hMmYrZTlP?=
 =?utf-8?B?Y2hveTlabHRFUS9ldEdkTHI1L2VuWngrdldFVzl6S0lnMU9DMUJqUmFSRk94?=
 =?utf-8?B?WElRUlNsUmx5UG5TTE9IUkdjcWhHUjF4NkFaOG8wQ0FFM01YWlBHQnRyVEhL?=
 =?utf-8?B?SXp2b3BVbi8yNVF6aFVHQ3NYMnovWmJoTFRYbHNqTXUrSDNuTlpjai94UG1N?=
 =?utf-8?B?RjBNQmdubUFGK1FqS2MxQTVETGtBRWdYdkdPN2Z6eVZHNXBOV1daYllLdHd4?=
 =?utf-8?B?emU4ckRzaHlDUHdEUFgwaC9pZkJrTnFIZjRsNkJHL2hLMFIvRDQ0SlpiT1JS?=
 =?utf-8?B?QTZ2QzdJeTVyd0JUQUhrbEN4WWszYVJYaFhiMHdqaVpyWElZSE83aXYra0VB?=
 =?utf-8?B?THQzd2xmTFV1RUY5enRHUWRRQlE2RkFQOUFvVmdNN2YzTWpKR2xKUXlNaUQr?=
 =?utf-8?B?dHZpcHBtNGRIKzc5Y3d0bFlHZkYrTjVVYjNVb0I4aXVzeUpVRkl4bEhzTnd5?=
 =?utf-8?B?UDEzMjUxSk40dGZiYWg1Q1lsQjdvajNGRmhJdHdkeEg4MW5tWUd6ei9mZE9a?=
 =?utf-8?B?dkFmMis5M0c3R0UxQTBTbWJrRDh3WTAxQ0gyRlhqUzhTajhYZU1uNkFVSUZy?=
 =?utf-8?B?cmcyUVFRRVFMeitlbDc1ZU1nVWZnZE1mK3Q1dFJFUjJIWlgxQk04RndzL2ha?=
 =?utf-8?B?ODN0UnIwWGtDUTBBS3FuTkh4eklpNUlhdkVUcHFCZ1RPVkNFa0VmZnJkQ3BQ?=
 =?utf-8?B?N0ExRTVvNTMxajdqcmREVDVxdFFBWG8yV3A5K0lyb1o5c0lYd1VRaEFqem1T?=
 =?utf-8?B?eGlodk9wcVI5dXVVbjIxTXV0U0F2UkE0eE80bHNxakZZdXpRQWdiK2MrM3Fs?=
 =?utf-8?B?ajExTEhHc3NvaXVET1hrTUhxVUJWd2JTbllLMGxGdGVQVC8zNkYrTHFUMlBT?=
 =?utf-8?B?NHV6bEdTV2ZEQS9CV2xHZW96djhUd0JLaDg3S1BkU0hBVEp6eFFJNFJyMzAv?=
 =?utf-8?B?SkNxTURrdm5hQVRycW5ZOUJ3THBZVGt0MDZybGNSeXMwNWNyazAzcWNock4x?=
 =?utf-8?B?TVMzcS9rcjN5VUtFR2o3a1Z3clg1NXp4aCtPemZuLzUrUFdTY2VVTVZlL3lq?=
 =?utf-8?B?S0xGOFR3RzRhRzV6Vkw1eml3d3gyaXc1U0JBc0pWM2dydjgyQzY3Uk16RDYr?=
 =?utf-8?B?N0tKdHNVd2pHeE1TN3oxTkFqd0dzclVtdXNEenZ1SzFvalpJRU5wYjMvQytr?=
 =?utf-8?B?cnArNVYzS3JadTdXc3E5eUpSTTZrVFArUklFM3QyK2hIMzNuSmVIb1VRcVZh?=
 =?utf-8?B?RElOSTRSNkZQeDFadGJ4TXFxMktkNHhmSUZiY1lISVpqaFc4MjJmak1MZCtG?=
 =?utf-8?B?S0ZMRkdZTE9tc1c4Q3FYK0lUSVpFMEZlUkluTEQyWnhoQmY5Y1o3SUE3aURE?=
 =?utf-8?B?KzlvVU1idG41dTFYZHpxdnFSSXBoUy9ZZ09WT2MvL1BUV1VVakdhMnh4NEtm?=
 =?utf-8?B?NjNyNXArNC85UlZJV3hueE9FZDg5di9YeHdLSlFyc3BWYU1YMHFiTnowOElj?=
 =?utf-8?B?clVleFRmQTk5SlJSTFFDL2J4M1FQMWxDL2IvelYxVFpjRGQxeXMwaTl6eGk0?=
 =?utf-8?B?NFQ0ZGlqbi9tc25semNjazdNRjE0bUZTblFTNHlNOVVLU2JjbjIzdkhiS1c5?=
 =?utf-8?B?bUF0dnh0dVRKeUZiNWlYbHRTNFhVbXhlRzBSb1dFblZtWEgrQzc5VUdTdVhp?=
 =?utf-8?B?Zm9ZR1dhc09CYzRxU2lmYy92ZWwwTWdNdklqaWNHc1FLL1hDaSs4YTF0d3Rx?=
 =?utf-8?B?WGFqY0RmZWc2TGd6SXFyeVBuQzlsVUNWbTgxWDRJYUt6ZUM0UFNKNHhuOFNK?=
 =?utf-8?Q?y+7uhFVr63u1i80rLdSmJC4qS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6805.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b7215e-9a10-4d49-e4ef-08dc474c624f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 13:07:37.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwYaSaDHDaHqxmTKCY6pL93j/KxkYtqJT/FRCeMS7gga7L7wESmRYRLpovvf+HSFSG7MfsIz8duww6K2CZNjS5CzVMJhAv3cpw74ZJPh5XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8034
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

SGkgQWxleGFuZGVyLA0KDQo+ICAgICAgIE1heWJlIHdlIHNob3VsZCBhZGQgYW4gYXV0b21hdGlj
IGZhbGxiYWNrIGZvciB0aW1pbmcgbW9kZSBpbiBuYW5kLWNvbnRyb2xsZXIuYyDwn5iKDQo+ICAg
ICAgIEFzIG9mIG5vdyB0aGUgZHJpdmVyIGlzIGZvcmNpbmcgdFJDX21pbiB0byAzMG5zIChtb2Rl
IDMpLCB3aGljaCBpcyBub3QgcmVsaWFibGUgZm9yIHNhbWE3IG5mYyBjb250cm9sbGVyIOKYuQ0K
PiAgICAgICBodHRwczovL2dpdGh1Yi5jb20vdS1ib290L3UtYm9vdC9ibG9iL21hc3Rlci9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX3RpbWluZ3MuYyNMMTY3DQo+ICAgICAgIFRoZSBuYW5kIHRv
cnR1cmUgY29tbWFuZCBoZWxwZWQgbWUgdG8gbWFudWFsbHkgZm9yY2UgdFJDX21pbiB0byAzNW5z
IChtb2RlIDIpLg0KDQpUaGlzIHNvdW5kcyBsaWtlIHRoZSBzYW1lIHByb2JsZW0gZW5jb3VudGVy
ZWQgaW4NCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eDRzYW0vYXQ5MWJvb3RzdHJhcC9pc3N1ZXMv
MTc0IGFuZCB0aGUgZml4IHByb3Bvc2VkIHRoZXJlIHdvcmtzIGluIExpbnV4IGFuZCBVLUJvb3Qg
YXMgd2VsbC4gIEkgY29uc2lkZXIgdGhlIG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlIG9mIHRoZSBw
YXRjaCBhdHRhY2hlZCB0byB0aGF0IHRpY2tldCBub3QgZWFzeSB0byB1bmRlcnN0YW5kIGhvd2V2
ZXIsIHNvIEkgd3JvdGUgd2hhdCBJIHRoaW5rIGlzIHRoZSBwcm9ibGVtLiAgQ291bGQgeW91IHBs
ZWFzZSB0ZXN0IHRoZSBwYXRjaCBhdHRhY2hlZCB0byB0aGlzIG1haWwgd2hpY2ggZG9lcyB0aGUg
c2FtZSB0aGluZyBhbmQgc2hvdWxkIGFwcGx5IHRvIFUtQm9vdCBjbGVhbmx5PyAgSSB0ZXN0ZWQg
dGhhdCBvbiBzYW05eDYwIGFuZCBzYW1hNSwgYnV0IGhhdmUgbm8gb3RoZXIgYm9hcmRzL3NvY3Mg
dG8gdGVzdCB3aXRoLiAgSWYgdGhhdCB3b3JrcyBvbiBzYW1hNywgSSB3aWxsIHByb3Bvc2UgaXQg
b24gVS1Cb290LCB0b28uDQoNCihJIGhvcGUgaXQgaXMgb2theSB0byBhdHRhY2ggaXQgYXMgYW4g
YXR0YWNobWVudCBmb3Igbm93LCBpdCdzIG5vdCByZWFkeSBmb3Igc3VibWlzc2lvbiBhbnl3YXlz
LikNCg0KCUkgdGVzdGVkIHlvdXIgcGF0Y2ggb24gc2FtYTdnNTQtY3VyaW9zaXR5IGJvYXJkLg0K
CUkgYWxzbyByZXZlcnRlZCB0byAoY29uZi0+dGltaW5ncy5zZHIudFJDX21pbiA8IDMwMDAwKSwg
dG8gZm9yY2UgbW9kZSAzIPCfmIoNCglJbmRlZWQgdGhlIGRlY29kZSBjb21tYW5kIHJlcG9ydHMg
dGlnaHRlciB0aW1pbmdzLg0KCUkgdGVzdGVkIHVzaW5nIG5hbmQgdG9ydHVyZSBvbiAxNk1pQiBh
bmQgMzJNaUIgc2l6ZXMuDQoNClUtQm9vdD4gbmFuZCBpbmZvDQoNCkRldmljZSAwOiBuYW5kMCwg
c2VjdG9yIHNpemUgMjU2IEtpQg0KICBNYW51ZmFjdHVyZXIgIE1BQ1JPTklYDQogIE1vZGVsICAg
ICAgICAgTVgzMExGNEcyOEFEDQogIERldmljZSBzaXplICAgICAgICA1MTIgTWlCDQogIFBhZ2Ug
c2l6ZSAgICAgICAgIDQwOTYgYg0KICBPT0Igc2l6ZSAgICAgICAgICAgMjU2IGINCiAgRXJhc2Ug
c2l6ZSAgICAgIDI2MjE0NCBiDQogIGVjYyBzdHJlbmd0aCAgICAgICAgIDggYml0cw0KICBlY2Mg
c3RlcCBzaXplICAgICAgNTEyIGINCiAgc3VicGFnZXNpemUgICAgICAgNDA5NiBiDQogIG9wdGlv
bnMgICAgICAgMHg0MDAwNDIwMA0KICBiYnQgb3B0aW9ucyAgIDB4MDAwMjgwMDANCg0KVS1Cb290
PiBoc21jIGRlY29kZQ0KDQptY2sgY2xvY2sgcmF0ZTogMjAwMDAwMDAwDQoNCkhTTUNfU0VUVVAz
OiAgICAweDAwMDAwMDAyDQpIU01DX1BVTFNFMzogICAgMHgwNzA0MDcwMw0KSFNNQ19DWUNMRTM6
ICAgIDB4MDAwNzAwMDcNCkhTTUNfVElNSU5HUzM6ICAweDg4MDQwMmYyDQpIU01DX01PREUzOiAg
ICAgMHgwMDFmMDAwMw0KTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA3ICgzNSBucyks
IGhvbGQ6IDAgKDAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQogICBOUkQ6IHNldHVwOiAwICgwIG5z
KSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAoMTUgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQpO
Q1NfV1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDcgKDM1IG5zKSwgaG9sZDogMCAoMCBucyks
IGN5Y2xlOiA3ICgzNSBucykNCiAgIE5XRTogc2V0dXA6IDIgKDEwIG5zKSwgcHVsc2U6IDMgKDE1
IG5zKSwgaG9sZDogMiAoMTAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQpUREYgb3B0aW1pemF0aW9u
IGVuYWJsZWQNClRERiBjeWNsZXM6IDE1ICg3NSBucykNCkRhdGEgQnVzIFdpZHRoOiA4LWJpdCBi
dXMNCk5XQUlUIE1vZGU6IDANCldyaXRlIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5XRSBzaWdu
YWwNClJlYWQgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTlJEIHNpZ25hbA0KDQpVLUJvb3Q+IG5h
bmQgdG9ydHVyZSAweDgwMDAwMCAweDEwMDAwMDANCg0KTkFORCB0b3J0dXJlOiBkZXZpY2UgMCBv
ZmZzZXQgMHg4MDAwMDAgc2l6ZSAweDEwMDAwMDAgKGJsb2NrIHNpemUgMHg0MDAwMCkNCiBQYXNz
ZWQ6IDY0LCBmYWlsZWQ6IDANCg0KVS1Cb290PiBuYW5kIHRvcnR1cmUgMHg4MDAwMDAgMHgyMDAw
MDAwDQoNCk5BTkQgdG9ydHVyZTogZGV2aWNlIDAgb2Zmc2V0IDB4ODAwMDAwIHNpemUgMHgyMDAw
MDAwIChibG9jayBzaXplIDB4NDAwMDApDQogUGFzc2VkOiAxMjgsIGZhaWxlZDogMA0KDQpUZXN0
ZWQtYnk6IE1paGFpIFNhaW4gPG1paGFpLnNhaW5AbWljcm9jaGlwLmNvbT4NCg0KQmVzdCByZWdh
cmRzLA0KTWloYWkgU2Fpbg0K
