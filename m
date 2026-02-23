Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4068EC1120
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFB583935;
	Mon, 23 Feb 2026 20:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PvQaI3M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F54583C6E; Mon, 23 Feb 2026 20:30:18 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E629A80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGEWtWiWqWXP+tb77rdOP//Xp/SMFVlKCNrQoknBjlGWsS08QpWPkM8qy+qPz1LTvv456st24hB/KH4bgBKHfg64l0n1hWD+P+Hrwzrlnq34Q20oiL9sp5KZbRYg1eb3RqG2gDcyan0omqUBe7xtRlOMV3weuxlOB8AFZsORlwhKO4Q/UvDNV3FgENr4VX45l+AY/mXRtHr1U4FBIp9MEVyFw+R2bPxOmbMtjI1CMiGOrFZfUi+JMTi5qMc7HuxTYNY+z8iI51VgZvNccLUereJX9O+loNPOE8Y7G4WRqYmFDgPFN57izkyAYzzYDQf7hEc91zzc3RlQGhc2cwuKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2WJ+r9JE2tfWnq902wFAo6kSSNiYeImDLC2qny0d+4=;
 b=Z+aMdlJUO0xuUv/QyOFTHrccgB6DEg4gL/YKkE2608uixJsMc/AqQ8EHy7c5Tr8Zkw/EZpMEe+Q6rR9lH5idRIpoGeaqqX/ThVFB+CYuQp2ygqPtcDOjqFPtWFEPIi27wcTfI68/DbnJMOy9BAT/SHwPyYyc4cH1yYZ3D1LWJGrXojEnOl5JelJpp6cX8uJJQB6WyIO+k4dzsHmzdnufj15vWXrXnhw6Og4AR6v1KU1EyGtwVJW1/OA+5AznroLIYoBYEe0F3WLeeRRuHm55nZb14PCjOEPZfyO/Bd12Vkzrn+n5clHGR6M3kX+qJV9QKH/CPxpRP4GYYIoh0MYnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2WJ+r9JE2tfWnq902wFAo6kSSNiYeImDLC2qny0d+4=;
 b=PvQaI3M3DhvWebFFJLFJ9QexfbdHyioSJnWylDntTR1zfZoAgJWSkzt16Gr7YF6J4vEoIBaBCTTso0dl3s6d5pnlsKr+6bcKOmz+k4PGEy98/SmmA3uBpGr45iJdnMsJaJZJWoQ8XVkwQ2SwsaSjOYKEXo7uVy0WWOdI63Pno3eyii2SictfWCo/GydvmgGxXdEH1bxUPTR431txB0nk9rpKBQcW5Z5qGtowikU+ilxqjT8CeKfs0N5+FwWIT2HBLWhsoARK6GNvL0rDVLHO2QJkOBpANF6JtVI640glVmdWqBR6TUQo3e1vNUP4clmvS4JhGRJrbtFYZgfI8S3wJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7446.eurprd08.prod.outlook.com (2603:10a6:10:36e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 23 Feb
 2026 19:30:08 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:30:08 +0000
Message-ID: <a1d06225-bc17-411a-80ed-f39e0450dc29@iopsys.eu>
Date: Mon, 23 Feb 2026 22:30:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
To: Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
 <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
 <aZc_f3lrmRdE9c3Z@makrotopia.org>
 <CAFLszTgxMeFvKx8nkVUa_PADiVFnv1UB69SyD+C3OiLY_7ku8w@mail.gmail.com>
 <aZypXx3liLvvB4zr@makrotopia.org>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aZypXx3liLvvB4zr@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF000239BC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1b9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e76e8ac-69c0-4f5a-86fd-08de7311f3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmhuUXM1NjBJVlVYNXQra1BNS1UvcUhmTGpkMXcxWDZ6TVNVS0x6ckxyYndH?=
 =?utf-8?B?WDNvK0s0VEFaYnJUR2JKME9DZzN1eTN1WnNpUENNREhTa29mUU5yd0JEMjlG?=
 =?utf-8?B?Sjh2S3FYMkN6ODVqeng4WFVOcGFXdXBPS0dOS0xFNlRROUNrK2pHeUZKenJJ?=
 =?utf-8?B?VkRiaFZiM1dxV1M5VURmS05jN3dkVUFoM0NhZ1hRb3ZIZFlzVGw5Tm42UURD?=
 =?utf-8?B?YmZ0NFZOampKb3VtQ2ZRL0N5ZjRKSFZuTnRXNjFzTHlrNm9hd01RMGJKRm1n?=
 =?utf-8?B?T0NrcTVscFVWYUI5TVhGQUw4MDR6RWhJTUgwRmFBQzRMVXFaUnI4U2x4VjBj?=
 =?utf-8?B?TkRXVkRyakJOMUVZdEFaeGtOd1poUUlROXp0RHl6dDVwU2dQbEJNd0pidkpt?=
 =?utf-8?B?QnJYeEMwOVFiNjgyNDJtZDZwODlqYWNYcy9Fd1lvMmdNSW9TbHFVWmkwRHdN?=
 =?utf-8?B?WXJ4Q0svZFgrVUsrUUpLc1p2aVhmYy9vRXpGV1ByczVneWs5WGtpcS80OENP?=
 =?utf-8?B?M00rWmRLa255WHJ6QzFzYWJYd1V6TVoyUDRqbGJSMHJFeUM2WnF3Y25wM3gv?=
 =?utf-8?B?VlBjdWczREJnTW5HVVdsYkF1WEtvQUZRN2pFVThTTVpuQ3FJNFJmSWpHWWpw?=
 =?utf-8?B?S2pTTnpCNTl5YUNwTHN4Q1p5c3ZzeGJqelNuN0IzTFVYU1MzbkhNcUZWS04r?=
 =?utf-8?B?RVkzQXcxbmhXNkM3YlI1dE5pMjZUREdka2V3Szlydmh5K0lyUDZFenhocVFM?=
 =?utf-8?B?emdLVGNrWTNuNHVSQVBQWTdZV2N1YXlWd05NaXFZb01LOC9RUGVUdzQ5UUxS?=
 =?utf-8?B?VTN1TUJDTVVNQmRIdENpQ0VKbDEra3BkaGhLNngxQTc1S1hiUVFXTDNDS1FU?=
 =?utf-8?B?ZGkvbUVpODJwaUttWVowS0YrdFRvOTBzNHAyRXFiU0F3SlowMkt4UWRuYm11?=
 =?utf-8?B?MHRIUHA1UGVCZC9pKzZpMzY5Vmh3cUZDeE8vU3hkdlVSRVVCcDhmclJMb0hn?=
 =?utf-8?B?YkZVRm4zVkU0MWNxMlVlWEFkejk2QzExVWNmV2lPcFZ3UVBGWXBXWUgzb0VV?=
 =?utf-8?B?RU5XaXNab1JYZnBSNXpIOGxIOGVScmVDVDRnTmtZQkJ2dVBucmEvSVgrR09I?=
 =?utf-8?B?ZVdRSHVWb05XczZ0a0pvS05IVGtrQ2JZTHR2cC8zdGNzd2IrWWtQSFJlUk1C?=
 =?utf-8?B?dlNGazJlMUpIa29taHFBL0x2TjQrY2VJUEh2TGdGT0FxOFFoVnVtM20wUUp6?=
 =?utf-8?B?TkdSWENqVkdJcjkwaGZqd2FPV1dmQktKUVRQVGFSR1kxWEUxVENJTjI5VnNK?=
 =?utf-8?B?djBzampyblI4eE9JcWphSXZWaWt3bWdJdGVoRVlaUXB2ZU9UWEFyZlFFZE5J?=
 =?utf-8?B?WWtEd1g4bHdEVnV1d2ZXZ0d5ajQwWWROL3c4OWFVV1FqSlAvNnVaeWtvMXlC?=
 =?utf-8?B?SWNsU1pPdUZXbW5CcEdSUGJ3RnRzLzdSUXBpaE04Z0FEZlhNanZSMVhHTHJE?=
 =?utf-8?B?ZVlwZG1yeGFGSmJWdnc4Z0lNSmdKUjFLV29JZ1NJRlhEdHpQRzNUN3dnem1Y?=
 =?utf-8?B?WW90bE9vU0trb0V0U3hrZVVIU1JQMGJBcStZUXAweWVPUnB2a2JPekljdGlq?=
 =?utf-8?B?Y3hlYVJScjN6L2pOeHhESnpaZjA4ZDg0aDhEeUR5S2xQOXV2WWsyazIzOTl5?=
 =?utf-8?B?QVVNMW5Dc3QxWDVFMlZPOENmSmhFYTlrRGx4c0thMS9kR01Zangycms2dFp3?=
 =?utf-8?B?azBVaFhlK1BFd0F1SFhZaGozSzVxMmtLd3ZNNlI1c3czczdra2lZTGkraHYy?=
 =?utf-8?B?VE9CWnpqWWFkS0tPTVhDVzNIdDN2MW9lV251eXpsekdWdVhlelpwZjBNdURB?=
 =?utf-8?B?R0p0aFJxcUVuWEtJVG9nSDVQU1Y1elBFTTBrTmJtZCtkbzlyVGJwREV5WkNn?=
 =?utf-8?B?RzE0T3JxWnZEdVVIWTIrNVBZaHBUSDRnVXV2TlJrN0xrc1VUR3dCdXkvc1ll?=
 =?utf-8?B?QUdieDUzYndSUWxQbGgyZVRXZ2QxZVZSdUVIMjl3TTAvY3l2ellXUlA4ZWZ0?=
 =?utf-8?B?NytqZ28yeFNnNlB6eXFYeTIxQnZIUkVtOXE2ZEcwUGRaUEUzRkFvc2Z3WkFO?=
 =?utf-8?Q?YrnU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNRdGRORWxzRndCMWJYRmIzSVU3cndvUU5JVTRCeU82cHRpWlFXUGNlUGQ2?=
 =?utf-8?B?aWJCbTg1MThDcXh2eFRXWUp6VFFIRlhpZS92V1R6eUhuZmVUYndaU2NrUE9E?=
 =?utf-8?B?eXpnMUdMK2EzbE9LZmFuM0oyeUhwWGljTEZLWE1YRi9jVDl2cnNjUkgwa0RK?=
 =?utf-8?B?VFJaYlRtVmZuc2dkQW9zVU0vaFFibzFRVThiUWZMRFFqajVKSCtJVHVEVFhz?=
 =?utf-8?B?UEhweDBWK2NNb0M0aVhRUjc1VjZLNFRqWE5tMWhLSTBRczFrNVBjcUh4Ujkz?=
 =?utf-8?B?OGZVYWdRM3YvNUdPajJTS0xqc2VlN1pPelNJWTVHc2JzTmhXVVpkWkhnSUox?=
 =?utf-8?B?M2FsZDZoUnNDREZ0bVkyTHlBRUhwYWJPOEI1aUorQ2lNYWpEbmlnRmtsNStV?=
 =?utf-8?B?Ymw3NEwvTUhQNEFnaUZqNHpHcXgrQWw3K0o2WGNUVzlnTGd1VGN5bWZOVHNF?=
 =?utf-8?B?QVRJSEluUHVNblhrbnRTV0l3Y04wTXIxT1VMQTc4ZGg1SUJuYmd5cFpkWjZz?=
 =?utf-8?B?M051d2R4aW9yd3ZqQTlib1phdmQ5cXdpMFN1dmJuc2FuZWRoY3QwQ3BFUWZZ?=
 =?utf-8?B?NmZ5ZTdsYWZsak9CR3NoeTdGUmdMK01vRUNjZGFBaTg3aGlCbjIzczk4QzlB?=
 =?utf-8?B?c2hZQWtCY2oyMllLWDJFdWtXU2w0R3ZMYVFOQ3JqaUV4akJkQWloL2g5M2ha?=
 =?utf-8?B?cEtIN0c4VTNXZkdEODJlSDFGczJ1THg4STNjQkhVMW1UR0tkQmhEZllzM0hw?=
 =?utf-8?B?TmRHK0orT2hJQW1PWlJ1UHRvTE9DcDdxUFFEdHp4aWRsSm1wTnZEV3BYLzlj?=
 =?utf-8?B?MW9WMWY3VVY1eWtzdkVYNTV6blZudzlaL1NDWjJMVVFjSDdiTTZVTG5ETXpO?=
 =?utf-8?B?RUZ6VWVTclRRSlhnWFVvdVphNFEzVnpEVnMxVXRhRzhOVmMyeDNSN2ptTlBE?=
 =?utf-8?B?aXJ0WEJmT0xvOSttY0x4OXF0R0d1YWRFVC85blJUaDhSamdWSjNPd3hqZmxL?=
 =?utf-8?B?bXY1ek9MYlhKNmd3TjJ1STBHeEdFdUJJalFpdVRVVDJLMHZ6K1g1cFJycGZM?=
 =?utf-8?B?R1V3Y0wxdzcwellwOWJ4MkZiaElWV3hoQXBwK2FxekFWTjZ4K0lwVXZLREhx?=
 =?utf-8?B?OVZIald6dTNtSDhBQ0E5eVVLNWRhZ04yTGhTamxob2lIcjIzWW9FdU1JWFdR?=
 =?utf-8?B?Yy9EalkxaDlQVjZ6SmppMVlSUFBsZGg1M21tbzlBSFp2WFZKdkJDL3dZdHY4?=
 =?utf-8?B?WEhMakdBSko0YWtBZHNhVUZWWlF3QTMxT0VIYzUrSHlWSmxZL09qSWRjbkQ1?=
 =?utf-8?B?S2tTNXRFWkdpdkE3NUFZQ0hkeFRmaVNjUHZwczZtak1hOC9nQlowVkhmS1JS?=
 =?utf-8?B?UUc5NEViUm1BNWQ2dGZhZDRyQWdOUStzMXFlNWlGejQ4VVRzNC8rUXFLNU1u?=
 =?utf-8?B?R1lPd0FraHlxTHBZQ0ZiT3krbkNPVmVJa1Judit3S1JBRDh6TGhmUzBOUVpt?=
 =?utf-8?B?aVd4ZHFnaGlJblZKYXZza2p1S3ViM25VNGdXL0FldzMzYjRPMlhNck1JYWcy?=
 =?utf-8?B?ZU9qT3pyNFlMSlJSY3A5V0wxaTFoNXRwMmlzajZvZmFlQXN2elpCTWgwdS9v?=
 =?utf-8?B?TVFBb3JHR2gvRlZNd3E0T1ROYnZNZU8yNVJPaWZlZFNBRWtwTWVLTVNNMld5?=
 =?utf-8?B?aVdTSFM4MWQrVTBRdk1FVDQwNlNOTGh5ZlFxT1V6TFk2VTBnNE0yTEFHNGFi?=
 =?utf-8?B?ODJFYU5YMVFyZ0c2Vjk2NVQyVDVRT21sQ2ZpclBuMXBpeTd2dUI2c2NZS2l5?=
 =?utf-8?B?akhJbVJ1YU4ydUJ5SldVa0RDNUhwRGw2UXhzRDFEa28vd2JyZWM0ZjNpTFc0?=
 =?utf-8?B?RWRHMFlYeDVhejRyNnJWWnJ0TDdtWDY0Vk1sUEMwcEFZSlJZcXhoQ3dpdVlS?=
 =?utf-8?B?c3h5bWh1eE9WNmRMYThkOUJJbE1rMlhqQTJmVko5WDZjcmFhUks2QkJtTU5v?=
 =?utf-8?B?V3poc3VEa1BmYng4eFY3aklzNUZGdWlKRnVJckR5SkVHR251MDk4UW1MalRQ?=
 =?utf-8?B?TkJINUozTjlmdzVGa2xHd2RQRTZNUDZMSGRXR0pvclBiOU80bzFGTTdrSGZ6?=
 =?utf-8?B?bWlPdG92OHBnOUtFeE4yM0Mvc1JRZ2VhUUhjMmlKY2RmM085YkxnR2JIRCsw?=
 =?utf-8?B?cStaRXFCdXc4RGE2RHkramxZNlZJU25Sa3J2aDRRMkpUTWVaU2syS1ZDdTRa?=
 =?utf-8?B?QU5WYzNnTnQxRHI3elB2WG5nbHdjNmJ0dGZPL3M0Y0NQK0xydGY1UENxRUxU?=
 =?utf-8?B?TG1Jb0hnUTlDNkNJdkZXRGhDY3VrS1FFYkNpMXFKVXBqc2phQmVLVlRNdERN?=
 =?utf-8?Q?MZ0jNMjjBGx3VAmg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e76e8ac-69c0-4f5a-86fd-08de7311f3f6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:30:08.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8/rmPykqlO+Nbbc0H5ho9KWQqYDPrKO4O01hlJBafH53xzkuAw0YZXFIZl+7TRlzsX21+AkHuzNy+BJnVhvVAm8fjkCorcFdoFCH/31Ik0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7446
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


On 2/23/26 22:24, Daniel Golle wrote:
> On Mon, Feb 23, 2026 at 10:51:09AM -0700, Simon Glass wrote:
>> Hi Daniel,
>>
>> On Thu, 19 Feb 2026 at 09:51, Daniel Golle <daniel@makrotopia.org> wrote:
>>> On Thu, Feb 19, 2026 at 06:09:27AM -0700, Simon Glass wrote:
>>>> Hi Daniel,
>>>>
>>>> On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>>>>> Add a UBI volume storage backend for the image_loader framework.
>>>>>
>>>>> image_loader_init_ubi() takes a volume name, ensures the UBI device
>>>>> is attached (auto-attaching if needed), and installs a .read() callback
>>>>> wrapping ubi_volume_read().
>>>>>
>>>>> Auto-attach works by scanning the device tree for the first MTD
>>>>> partition with compatible = "linux,ubi", then calling ubi_part() on
>>>>> that partition. The partition name is resolved using the same
>>>>> precedence as the MTD partition parser: the "label" property first,
>>>>> then "name", then the node name. Since U-Boot only supports a single
>>>>> attached UBI device at a time, only the first matching partition is
>>>>> used. If a UBI device is already attached, the auto-attach step is
>>>>> skipped.
>>>>>
>>>>> UBI handles bad-block management and wear leveling internally, so the
>>>>> read callback is a straightforward passthrough. Note that
>>>>> ubi_volume_read() returns positive errno values; the wrapper negates
>>>>> them for the image_loader convention.
>>>>>
>>>>> Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).
>>>>>
>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>> ---
>>>>>  boot/Kconfig            |   8 +++
>>>>>  boot/Makefile           |   1 +
>>>>>  boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
>>>>>  include/image-loader.h  |  13 +++++
>>>>>  4 files changed, 134 insertions(+)
>>>>>  create mode 100644 boot/image-loader-ubi.c
>>>>>
>>>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>>>> index 23848a0f57e..89832014af6 100644
>>>>> --- a/boot/Kconfig
>>>>> +++ b/boot/Kconfig
>>>>> @@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
>>>>>           parallel NAND, etc.) using the image_loader framework.
>>>>>           NAND bad blocks are skipped transparently.
>>>>>
>>>>> +config IMAGE_LOADER_UBI
>>>>> +       bool "UBI volume backend for image loader"
>>>>> +       depends on IMAGE_LOADER && CMD_UBI
>>>>> +       help
>>>>> +         Allows loading images from UBI volumes using the image_loader
>>>>> +         framework. Auto-attaches the UBI device from the device tree
>>>>> +         if not already attached.
>>>>> +
>>>>>  config DISTRO_DEFAULTS
>>>>>         bool "(deprecated) Script-based booting of Linux distributions"
>>>>>         select CMDLINE
>>>>> diff --git a/boot/Makefile b/boot/Makefile
>>>>> index 1dde16db694..7d1d4a28106 100644
>>>>> --- a/boot/Makefile
>>>>> +++ b/boot/Makefile
>>>>> @@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
>>>>>  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
>>>>>  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
>>>>>  obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
>>>>> +obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
>>>>>
>>>>>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
>>>>>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
>>>>> diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
>>>>> new file mode 100644
>>>>> index 00000000000..64901a13378
>>>>> --- /dev/null
>>>>> +++ b/boot/image-loader-ubi.c
>>>>> @@ -0,0 +1,112 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * UBI volume backend for image_loader
>>>>> + *
>>>>> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
>>>>> + */
>>>>> +
>>>>> +#include <dm/ofnode.h>
>>>>> +#include <image-loader.h>
>>>>> +#include <log.h>
>>>>> +#include <malloc.h>
>>>>> +#include <mtd.h>
>>>>> +#include <ubi_uboot.h>
>>>>> +
>>>>> +struct image_loader_ubi_priv {
>>>>> +       char *vol_name;
>>>>> +};
>>>>> +
>>>>> +/**
>>>>> + * ubi_auto_attach() - attach UBI if not already attached
>>>>> + *
>>>>> + * If no UBI device is currently attached, walk the device tree for the
>>>>> + * first MTD partition node with compatible = "linux,ubi", find the
>>>>> + * corresponding MTD device by matching flash_node, and attach UBI to
>>>>> + * it via ubi_part_from_mtd().
>>>>> + *
>>>>> + * Since U-Boot only supports a single attached UBI device at a time,
>>>>> + * only the first matching partition is used.
>>>>> + *
>>>>> + * Return: 0 on success or if already attached, negative errno on failure
>>>>> + */
>>>>> +static int ubi_auto_attach(void)
>>>>> +{
>>>>> +       struct mtd_info *mtd;
>>>>> +       ofnode node;
>>>>> +
>>>>> +       /* Already attached? */
>>>>> +       if (ubi_devices[0])
>>>>> +               return 0;
>>>>> +
>>>>> +       mtd_probe_devices();
>>>> This should be handled by your new ubi driver for your uclass.
>>>>
>>>>> +
>>>>> +       ofnode_for_each_compatible_node(node, "linux,ubi") {
>>>>> +               mtd_for_each_device(mtd) {
>>>>> +                       if (ofnode_equal(mtd->flash_node, node))
>>>>> +                               goto found;
>>>>> +               }
>>>>> +       }
>>>> Eek this is really strange. There should be a device so you can use
>>>> uclass_first_device(UCLASS_...).
>>> I carefully considered turning UBI devices into a UCLASS, but it would
>>> be a huge major rewrite of how UBI works in U-Boot, and while that would
>>> be a good thing to do, I consider far beyond the scope of supporting a
>>> boot method for OpenWrt.
>> Oh, I just assumed it supports driver model. But surely it must have a
>> UCLASS_BLK device?
> Sadly no. Neither UBI devices nor UBI volumes are block storage devices.
>
> Every UBI device does have a UCLASS_MTD parent device, but that
> obviously also doesn't uniquely identify the partition on the flash chip
> which is used as UBI device -- there can be (and sometimes are, for
> dual-boot/redundancy reasons) multiple UBI devices in different
> partitions on the same flash.
>
> What I ended up doing now is to move more of the UBI detection and
> enumeration logic into ubi_bootdev.c and have imagemap-ubi.c rely
> on getting the MTD device and partition index from there.

There are UBI based block storage emulation, see CONFIG_UBI_BLOCK
commits: 
* 9daad11ad178646c288aca3615a7ba1e6039aed3 ("drivers: introduce UBI
block abstraction")
* aa5b67ce226267440e64fadc57d3a21e5842027c ("disk: support UBI partitions")



>>> Or did you mean the to-be-create UCLASS_IMAGE_MAPPER?
>> No I was talking about ubi.
>>
>> Regards,
>> Simon
