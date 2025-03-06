Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6127FC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 10:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C38980E94;
	Thu,  6 Mar 2025 11:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="EiF+fVUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D16B810ED; Thu,  6 Mar 2025 11:20:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CECB80756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaH+qODgIJ/Ljd5Moy3j3DRLyYwCvnlIsbRRfzIG1Jp2c0QmJQJmiiCRIYaebvHer2tjU5a99XjUbz/SEs2w7AG/pk/+1A0MhsVBnenLO1yrMbbKUsaw6Kznx6CLVZpcGciM6AnDeatsv5+7M5ri3+S1sy+b/VbLNhJ3ZqeN5hvk+qObkzWJ5aROH8/9QLX+/zlcuDrZfbQqQn4z+SLtxabSiPQCr3tJIHtXQw488dN3zSNNUrvM+uH/Xw6bpMf3i7o64Woo3mXEpiLqx6T9ai9jvRisrPrQqSatvJ7F7LYhnmjoFGbi2gWyZIDzJ7U08anEcBGr9MX5Ts1QbrywFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tspamKLW77HmcyCysKXEdJwIn7+QWg7QIltgvsfwJfw=;
 b=KSRmDPeyIGPLgsLnCCrlEvD7hPH2+3ulYcX0bTgyeZgBn/Vcp0SBBcwW2E9c1KupW/Eiq/hdzgJ7ti+QOK2D7kwDDd71nHDUUCS8NhqUs/bMJ8xy1pUT5JC5T41klHjfUqLbgrtNGsTBCaIRYSMkwvlDyJuEp/P5K8pBZEiOQ/8PcaSyIwe/lF3Qd96TvUeQKwHqU3lQKE+Bpj4qOOqN31vIHdLUMoV0rqY2NeRVadmSNk+vTVVVB3pON7X1HmWgbhiTWkL20DFJp/ePPh78wEPGg2mMPpRah375E6QBgAfyFUHusDaxXnmqeg3hni67CuckZ8bxozLxI7d5pFxf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tspamKLW77HmcyCysKXEdJwIn7+QWg7QIltgvsfwJfw=;
 b=EiF+fVUzGUXtonLMe3RFX0Rpy/CE0cmZA/LyDnFQdfujh77Bv8zP0PzY6rcRJNPnHgpqAoqmxyfROqayv0GnnwWqL7ix50Fa/e0O1o3P3bo2AoaqJrqOgt5WOaCaYS3RS5zGuKBozNxQ9t99YQl7A32WvYIQVvcRitXm8GkdKkuSaerHE8ske8xBwhLOSA7bAEZBRMxLj3gh8yY5mw/F3yuPzbTZcM5gw3Ft1Zcm0NnviEOj6epNKdQk9DVJqPWQe3wA3G9qh2lgkybyL8Z/ZzW7VTHuBKYwAWsPLa6Vsq9rJzD9Njn70+db9nHoUxYtwTJkBROxsTrxmhCvDX0ong==
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com (2603:10a6:10:369::16)
 by PAXPR06MB7805.eurprd06.prod.outlook.com (2603:10a6:102:12e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 10:20:04 +0000
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652]) by DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:20:04 +0000
From: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam <festevam@denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, Wolfgang
 Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH v2 4/4] board/BuR/zynq: initial commit
Thread-Topic: [PATCH v2 4/4] board/BuR/zynq: initial commit
Thread-Index: AQHbfIOC0wep50vKUUy8BBnI1GNVibNZd9+AgAyRbcI=
Date: Thu, 6 Mar 2025 10:20:04 +0000
Message-ID: <DB9PR06MB855954FEBC17BC680E24CAB2D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
References: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
 <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
 <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
In-Reply-To: <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-03-06T10:20:04.155Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8559:EE_|PAXPR06MB7805:EE_
x-ms-office365-filtering-correlation-id: d38d3934-a2cd-4dfd-97f8-08dd5c987647
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TtXUa/NIpyK9Qet8/oBzUeGLKDFbIcZhK5Jp8STaw8Q/a0Fhxws4wc+6Qz?=
 =?iso-8859-1?Q?WxpYqU0KlzJAW7kQPzvmBhIsnRnch1+J3AL5zBE19gVcLxkg3aKE9KJwcv?=
 =?iso-8859-1?Q?bLKk5NPVymbdPVtrWNayz02yPv3CTalp4vfpBNGmsv+5j+UA9NnM+9lOAH?=
 =?iso-8859-1?Q?1SY94YzivEcgis28S6qOTjZYNZA4Zv0VJjZgExB8rzCQCd2rL+TGVWO1zZ?=
 =?iso-8859-1?Q?+VAWt7FMpvny0NY5Pbx5b6IsnvYiIRe1+kklDmFe0vsLEcmtpw8PuGWg48?=
 =?iso-8859-1?Q?5Wv8wPkARjBBsyuk8e9IL5SpIN9HSkseaSai95xaC8of1Pb1LXqctFcigJ?=
 =?iso-8859-1?Q?h+3/qKWIQgR/RPgNmN1RNJ2CnqTSqqTh5NNASLngAmNEVyzcsDyBaZmG8e?=
 =?iso-8859-1?Q?r0U4HcqIvv7JpeH2w8Wh/Cm3b3TDEwhfWyFi/SkKxeTIDshg6BijouSqQl?=
 =?iso-8859-1?Q?Q5cP6vTgHydnC6DMCoUdaEgOm3qHbnvP0Orhk/RH+lBwdA8pnX13g6XzQz?=
 =?iso-8859-1?Q?Ru57Lk9Vx6/Ma0uLCH9PUfK+c+NEzluULXLWhSnfcQCZV/p5E77IKYCb1n?=
 =?iso-8859-1?Q?99bswNh2GqbQmJoR0kxbwKTUz0YGvV3wdMNRe/GQy2PK4Ne4JNZjqcLX2U?=
 =?iso-8859-1?Q?LXlMezE5xKzS1v02zev7utl3JGIKB+jfGlBlvzylHomrWdXhgSpLIaEy1w?=
 =?iso-8859-1?Q?NzEjafJO0T+QBKS3h4uLI6dTqhkzpcCvUVHhvLu+Be14yHMWezr5pHDpW+?=
 =?iso-8859-1?Q?dV6k4LGnMvauxpLfvDOGhgO77piTNH+qxA2rUrMsoj2KoYGDEoq7EvcDoX?=
 =?iso-8859-1?Q?vyK50nfrV8Gs+fBbCsWQujU25Cjo/vzD8pWiONlMJ147aO3aK3hn1yvp1v?=
 =?iso-8859-1?Q?o6gzeJ2n5cunQIm1sanu7/eopcpapK2a/IpdSb22cG1wzT2+nEtD1xMM5d?=
 =?iso-8859-1?Q?0FesMMEZ2mCeGgniyMkWz3jbFk8blP4YfpB3gpHdJ24C68F8fd2Z7i5L68?=
 =?iso-8859-1?Q?XRHl7hSIyN7yyKYG7z3kTVeuNEHZ4kCD8qp00hvQZ+F3Wf67tktP50p5ew?=
 =?iso-8859-1?Q?BOZyuejA7HZsMdn5og58Oe1Tshcz27NH8aGCv/IUcZVsmIxkomGZl0r6FG?=
 =?iso-8859-1?Q?14Oa6xguTGHeBY5lyi25Ppe4irZxzOlqM0T6a8etzIMvpcRoX5RZjg4ziL?=
 =?iso-8859-1?Q?4X2OnY9UEvQPabNfYJaOFN/CR0cDJI6GpaUUgfuexC/LMxv7ssTiuG5P1x?=
 =?iso-8859-1?Q?OFm8mu5qSdLMKEoW5Le2scx8qfX5Yf0vLfmBS6dX/AvupKp874RQgQUGJY?=
 =?iso-8859-1?Q?X/wE/IUZNbcqi5hoCVZ2uBr5KkoZwRymk0oO15Eo66IAuH43XG4FCujQ1D?=
 =?iso-8859-1?Q?150jlXdC6bZ3NxcHy1CzhbpoVPfTA+PKOY9GAXvFSW4tea69QGZLJU0oqp?=
 =?iso-8859-1?Q?R40qP9dqbHgbaXlYK9DzpIcFz6FDm/D1wCS0++If+aSJ9yhYaDNJpKrKRQ?=
 =?iso-8859-1?Q?5zCjUKpjRB/1sVc3LEKIl9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8559.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+xFIGg92QKgPGLFeCQ++gqrEXynUUZ3Rbf789S3u2Y5tyuF3eEDyydmQCa?=
 =?iso-8859-1?Q?6HhkstAjEhccHMk4eDV8UboEIqaI3C3FjQF5gprzNd846nec2acGANP4I1?=
 =?iso-8859-1?Q?kjfCHOpVMMqVdWFAKj+MRKbpWnOJjZCP0kwrPp8sPraO71MoaDrhfdZ/rL?=
 =?iso-8859-1?Q?EvwuyhuP9uC6/W83Und8ZPp1xVlV7SBueDKz0fHpeAfN2D3101R/MMSOal?=
 =?iso-8859-1?Q?YJfYYchVJGmkX07A1QBRqJZbLM7mkU0nZcpATQwOwUQ6OtRQ16rB28gNNk?=
 =?iso-8859-1?Q?XpXz6wM6PJcrc5XkorHxQVYmTUnUpuDU4ehi1cWG5M7vIDK2/KT5BJPNO4?=
 =?iso-8859-1?Q?TKbB7gNOxAPYcP6CggwaN2KZGSALnW3MDzQDeI7zXjiLfcqe+atYOXWz5R?=
 =?iso-8859-1?Q?9pJcFY4IEcDnPHAAeY1lqiWCGpxVgcTcWlIPwRnYsLu3LQ0+HPmZNMlegS?=
 =?iso-8859-1?Q?y2uiijUn1CPG1GpTM1JBjadEAh5SEnxuORHXg1bovNeaAVSDv7Q9WOWESa?=
 =?iso-8859-1?Q?0TCSDs/6LHj91ilA/PrCmPMlzZeW7bM1dUImQb5tjY1DjkVnWI5/8ZY8up?=
 =?iso-8859-1?Q?SvDuU+NJihRn9rCSpewB1ZExUxAteXoJ0IZ2Of1slkZhP4PizRkjaEZPT7?=
 =?iso-8859-1?Q?YMg0Q2hRMdgLy1ZzYlD5/8OUe/tXDyFM1uEvkLahLaGF+jmiwyXtgbCBZt?=
 =?iso-8859-1?Q?wwBfmBvzplndAhHBihpgfVzaNx54PzOlDM39Fo5uSVxU67rVUhS6uXanuI?=
 =?iso-8859-1?Q?cpTq61lx1otpri8elJFAUgk5BwgZICdYMrsPRz+NECfLRVBrzjWZXV7LGW?=
 =?iso-8859-1?Q?RUgciG9DWEQnHlPYtYlhb369QcdttWirmtDPM9jFdeE0E0fybDUrNJYkLT?=
 =?iso-8859-1?Q?S2TNrV0yHQuTRVd/eU+f3E1yeNmYfVj+yb1E1TLkBjMyuD8FcaS7BN9Wed?=
 =?iso-8859-1?Q?sS9OeF4ZkZYT8uSlsI/iVN9lvAs0yp0OUP5gZu8cdzKcAwaDJkh38/bZiT?=
 =?iso-8859-1?Q?bZC629ACyK4Sq93bJWhTkJ5z6DvIaCdmOiEjOrrhvL5kOS+wQfHL8itls+?=
 =?iso-8859-1?Q?N0GKcvZ+OfABz0R+eokhjpA1hAg3CfeJ+EqeQyqsSJsRMOmP/laEoNuAzE?=
 =?iso-8859-1?Q?DsQjTYcqaRv1UJ1DuBk+BUjbuHEctSQ0a/gpUZwz3K4rnYYQHqQ/LnzOva?=
 =?iso-8859-1?Q?AZIWcvVEpo23uZ0Y2Berb/uoz876YCu+ahphM+XcNQZzXFISqjcnhR3FI+?=
 =?iso-8859-1?Q?K3/zLLzt1HICmgyJQO+bw0c96eEK4SDbpvd3wNcR7tafvzfS9c0OkSHlfM?=
 =?iso-8859-1?Q?IGiNnfFteWrOhtnSfGwTT2oGsZcXJLrkeltcwQ1tFFzivCHkAbT6eSD4qX?=
 =?iso-8859-1?Q?twngb5vVkhO2roCeCbeV7/n1Hd7vjrC7xPzBo4g+XjONxQuZgPqy9UYE1/?=
 =?iso-8859-1?Q?eSk4KTrrI9eIB1kyJa/XPWvFIn7tNjkQEIU5W6H3QFB29dq1BwuzQaYO2Q?=
 =?iso-8859-1?Q?qa/lTRkNwQNJyeP8L3y1J10if8D47mAfOG2Bws8BWF2Udjzmrh2ssv4+sn?=
 =?iso-8859-1?Q?jrRV8xCqy0bZUkpzLKKeSpSe5eucubazHGS7K9TeewcmaLMBzuRe5jGcqB?=
 =?iso-8859-1?Q?cDimA1CmD3mgj5ql/fuieCrTDpkb1J282U8NUn9bSgNmaRSZ+aqP6zfTHr?=
 =?iso-8859-1?Q?pG+dH8oRc0/b9sC43AU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8559.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38d3934-a2cd-4dfd-97f8-08dd5c987647
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:20:04.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTOPdTJSDUIs3JrT/DppxIOYr2HT8b3cQdTpsdB0QhvYa2BCifH79Yo5GgAesiOl/+ehnJyVeuKhAXkGPHbqXjFjBZceEsItNbhohg7JS7PB08dAafjW+GrW4uFhtDfc+pOWqWo+ldEIX3u5jgwBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7805
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

From:=A0Michal Simek <michal.simek@amd.com>=0A=
Sent:=A0Wednesday, February 26, 2025 11:23 AM=0A=
>On 2/11/25 13:49, Bernhard Messerklinger wrote:=0A=
>> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170=0A=
>> boards. This boards are based on the Xilinx Zynq SoC.=0A=
>>=0A=
>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automat=
ion.com>=0A=
>> ---=0A=
>>=0A=
>> Changes in v2:=0A=
>> - Remove all unnecessary device-tree entries=0A=
>> - Reviewed led names (no pattern restriction found)=0A=
>> - Fix maintainers file=0A=
>> - Cleanup of code=0A=
>> - Move preboot variable to env file=0A=
>>=0A=
>>   arch/arm/dts/Makefile                         |   8 +-=0A=
>>   arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++=0A=
>>   arch/arm/dts/zynq-brcp1.dtsi                  | 133 +++++++++=0A=
>>   arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++=0A=
>>   arch/arm/dts/zynq-brcp150.dts                 | 174 +++++++++++=0A=
>>   arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++=0A=
>>   arch/arm/dts/zynq-brcp170.dts                 | 140 +++++++++=0A=
>>   arch/arm/dts/zynq-brcp1_1r.dts                |  29 ++=0A=
>>   arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++=0A=
>>   arch/arm/dts/zynq-brcp1_2r.dts                |  22 ++=0A=
>>   arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++=0A=
>>   arch/arm/dts/zynq-brsmarc2.dts                | 158 ++++++++++=0A=
>>   arch/arm/mach-zynq/Kconfig                    |   1 +=0A=
>>   board/BuR/zynq/Kconfig                        |  14 +=0A=
>>   board/BuR/zynq/MAINTAINERS                    |  11 +=0A=
>>   board/BuR/zynq/Makefile                       |  15 +=0A=
>>   board/BuR/zynq/brcp150/board.c                |   4 +=0A=
>>   board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++=
=0A=
>>   board/BuR/zynq/brcp170/board.c                |   4 +=0A=
>>   board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++=
=0A=
>>   board/BuR/zynq/brcp1_1r/board.c               |   4 +=0A=
>>   board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++=
=0A=
>>   board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +=0A=
>>   board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++=
=0A=
>>   board/BuR/zynq/brcp1_2r/board.c               |   4 +=0A=
>>   board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++=
=0A=
>>   board/BuR/zynq/brsmarc2/board.c               |  30 ++=0A=
>>   board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++=
=0A=
>>   board/BuR/zynq/common/board.c                 | 231 +++++++++++++++=0A=
>>   board/BuR/zynq/env/brcp1.env                  | 109 +++++++=0A=
>>   board/BuR/zynq/env/brcp150.env                | 119 ++++++++=0A=
>>   configs/brcp150_defconfig                     | 123 ++++++++=0A=
>>   configs/brcp170_defconfig                     | 122 ++++++++=0A=
>>   configs/brcp1_1r_defconfig                    | 122 ++++++++=0A=
>>   configs/brcp1_1r_switch_defconfig             | 123 ++++++++=0A=
>>   configs/brcp1_2r_defconfig                    | 122 ++++++++=0A=
>>   configs/brsmarc2_defconfig                    | 122 ++++++++=0A=
>>   include/configs/brzynq.h                      |  21 ++=0A=
>>   38 files changed, 4109 insertions(+), 1 deletion(-)=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp1.dtsi=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp150.dts=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp170.dts=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts=0A=
>>   create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts=0A=
>>   create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi=0A=
>>   create mode 100644 arch/arm/dts/zynq-brsmarc2.dts=0A=
>>   create mode 100644 board/BuR/zynq/Kconfig=0A=
>>   create mode 100644 board/BuR/zynq/MAINTAINERS=0A=
>>   create mode 100644 board/BuR/zynq/Makefile=0A=
>>   create mode 100644 board/BuR/zynq/brcp150/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp170/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_1r/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_2r/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/brsmarc2/board.c=0A=
>>   create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c=0A=
>>   create mode 100644 board/BuR/zynq/common/board.c=0A=
>>   create mode 100644 board/BuR/zynq/env/brcp1.env=0A=
>>   create mode 100644 board/BuR/zynq/env/brcp150.env=0A=
>>   create mode 100644 configs/brcp150_defconfig=0A=
>>   create mode 100644 configs/brcp170_defconfig=0A=
>>   create mode 100644 configs/brcp1_1r_defconfig=0A=
>>   create mode 100644 configs/brcp1_1r_switch_defconfig=0A=
>>   create mode 100644 configs/brcp1_2r_defconfig=0A=
>>   create mode 100644 configs/brsmarc2_defconfig=0A=
>>   create mode 100644 include/configs/brzynq.h=0A=
>>=0A=
>> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi=
=0A=
>> new file mode 100644=0A=
>> index 00000000000..f1cf75f1277=0A=
>> --- /dev/null=0A=
>> +++ b/arch/arm/dts/zynq-brcp1.dtsi=0A=
>> @@ -0,0 +1,133 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0+=0A=
>> +/*=0A=
>> + * Copyright 2024 B&R Industrial Automation GmbH=0A=
>> + */=0A=
>> +=0A=
>> +/include/ "zynq-7000.dtsi"=0A=
>> +#include <dt-bindings/gpio/gpio.h>=0A=
>> +=0A=
>> +/ {=0A=
>> +     model =3D "BRCP1 CPU";=0A=
>> +     compatible =3D "br,cp1",=0A=
>> +                  "xlnx,zynq-7000";=0A=
>> +=0A=
>> +     aliases {=0A=
>> +             i2c0 =3D &i2c0;=0A=
>> +             serial0 =3D &uart0;=0A=
>> +             spi0 =3D &qspi;=0A=
>> +             mmc0 =3D &sdhci0;=0A=
>> +     };=0A=
>> +=0A=
>> +     memory {=0A=
>> +             device_type =3D "memory";=0A=
>> +             reg =3D <0x0 0x40000000>;=0A=
>> +     };=0A=
>> +=0A=
>> +     chosen {=0A=
>> +             stdout-path =3D "serial0:115200n8";=0A=
>> +     };=0A=
>> +=0A=
>> +     usb_phy0: phy0 {=0A=
>> +             compatible =3D "usb-nop-xceiv";=0A=
>> +             #phy-cells =3D <0>;=0A=
>> +     };=0A=
>> +=0A=
>> +     brd_rst: board_reset {=0A=
>> +             compatible =3D "br,board-reset";=0A=
>> +             pin =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;=0A=
>> +     };=0A=
>> +=0A=
>> +     leds {=0A=
>> +             compatible =3D "gpio-leds";=0A=
>> +             se_green {=0A=
>> +                     label =3D "S_E_GREEN";=0A=
>> +                     gpios =3D <&ledgpio 0 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             se_red {=0A=
>> +                     label =3D "S_E_RED";=0A=
>> +                     gpios =3D <&ledgpio 1 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             rdy_f_yellow {=0A=
>> +                     label =3D "RDY_F_YELLOW";=0A=
>> +                     gpios =3D <&ledgpio 2 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             re_green {=0A=
>> +                     label =3D "R_E_GREEN";=0A=
>> +                     gpios =3D <&ledgpio 3 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             re_red {=0A=
>> +                     label =3D "R_E_RED";=0A=
>> +                     gpios =3D <&ledgpio 4 GPIO_ACTIVE_HIGH>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             plk_se_green {=0A=
>> +                     label =3D "PLK_S_E_GREEN";=0A=
>> +                     gpios =3D <&ledgpio 5 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +             eth_se_green {=0A=
>> +                     label =3D "ETH_S_E_GREEN";=0A=
>> +                     gpios =3D <&ledgpio 6 GPIO_ACTIVE_LOW>;=0A=
>> +                     default-state =3D "off";=0A=
>> +             };=0A=
>> +     };=0A=
>> +};=0A=
>> +=0A=
>> +#include "zynq-brcp1-u-boot.dtsi"=0A=
>=0A=
>=0A=
>Why? It should be added automatically when you run build.=0A=
=0A=
This is not case for me since I have 3 base device-trees:=0A=
zynq-brcp1_1r.dts=0A=
zynq-brcp1_1r_switch.dts=0A=
zynq-brcp1_2r.dts=0A=
=0A=
This device-trees include the same base file zynq-brcp1.dtsi.=0A=
The file zynq-brcp1-u-boot.dtsi is needed in all 3 of the above files.=0A=
But the zynq-brcp1.dtsi file naming doesn't trigger the automatic include o=
f the=0A=
zynq-brcp1-u-boot.dtsi file.=0A=
=0A=
My approach is to include zynq-brcp1-u-boot.dtsi manually.=0A=
=0A=
Also I don't think it is a good idea to create 5 u-boot dtb files:=0A=
zynq-brcp1_1r-u-boot.dtsi=0A=
zynq-brcp1_1r_switch-u-boot.dtsi=0A=
zynq-brcp1_2r-u-boot.dtsi=0A=
=0A=
Perhaps you have a better suggestion for this problem?=0A=
=0A=
>=0A=
>> +=0A=
>> +&i2c0 {=0A=
>> +     status =3D "okay";=0A=
>> +     clock-frequency =3D <100000>;=0A=
>> +=0A=
>> +     ledgpio: max7320@5d {   /* board LED */=0A=
>> +             status =3D "okay";=0A=
>> +             compatible =3D "maxim,max7320";=0A=
>> +             reg =3D <0x5d>;=0A=
>> +             #gpio-cells =3D <2>;=0A=
>> +             gpio-controller;=0A=
>> +             ngpios =3D <8>;=0A=
>> +     };=0A=
>> +=0A=
>> +     pmic0: da9062@58 {=0A=
>> +             compatible =3D "dlg,da9062";=0A=
>> +             reg =3D <0x58>;=0A=
>> +     };=0A=
>> +};=0A=
>> +=0A=
>> +&sdhci0 {=0A=
>> +     status =3D "okay";=0A=
>> +     max-frequency =3D <25000000>;=0A=
>> +};=0A=
>> +=0A=
>> +&uart0 {=0A=
>> +     status =3D "okay";=0A=
>> +};=0A=
>> +=0A=
>> +&qspi {=0A=
>> +     status =3D "okay";=0A=
>> +     spi-max-frequency =3D <100000000>;=0A=
>> +=0A=
>> +     spi_flash: spiflash@0 {=0A=
>> +             #address-cells =3D <1>;=0A=
>> +             #size-cells =3D <1>;=0A=
>> +             compatible =3D "jedec,spi-nor", "spi-flash", "s25fl256s1";=
=0A=
>> +             spi-max-frequency =3D <100000000>;=0A=
>> +             spi-cpol;=0A=
>> +             spi-cpha;=0A=
>> +             reg =3D <0>;=0A=
>> +     };=0A=
>> +};=0A=
>> +=0A=
>> +&usb0 {=0A=
>> +     status =3D "okay";=0A=
>> +     dr_mode =3D "host";=0A=
>> +     usb-phy =3D <&usb_phy0>;=0A=
>> +};=0A=
>> +=0A=
>> +&gpio0 {=0A=
>> +     status =3D "okay";=0A=
>> +};=0A=
>=0A=
>I am fine with this way. My part is pretty much only that wiring and this =
file=0A=
>and separation in Makefile works for me.=0A=
>=0A=
>Thanks,=0A=
>Michal=0A=
=0A=
Thank you,=0A=
I will fix the rest and send an V3.=0A=
=0A=
Regards,=0A=
Bernhard=0A=
