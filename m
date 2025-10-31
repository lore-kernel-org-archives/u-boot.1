Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D8ECCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 03:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB6883642;
	Fri, 31 Oct 2025 04:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pgqa+Y05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEE383849; Fri, 31 Oct 2025 04:36:38 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013065.outbound.protection.outlook.com
 [52.101.83.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F458331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 04:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/nwUiOvabqLQBhgLr0YaGtYz5vEbqILBKb+OUWBzmFEE0kyQtlcB45E/g4M/XsGuahLP40+jsHGpWKYb8fNPg+zLrIPdabpXRqt7DJOBDjdu+l/g8u+hGFKrBpbSbp9UpL4RsK31lG9UOdDgxu0xLWZNPqeTChjg/ufpcJoL0LHHac+PwvMEjdnQZQQ7oH1dCD74W2vJzo3NRelFqkNIRUBAueLRBeat+aWZV0kziqHE+zdIVliVI78ri2D8hKi9ile6Vq/b5WB24w29yM8PuSYLGjgAECtxRqgHoS1C2a/MEyfBOcmngARB9Lpk9+iqbZ3XhsZ1uV/H4mDhqlDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpD6s1hKzBZz2wMbxrzFMCqRtIOrJKirbqzjGrT/Yco=;
 b=S2rSkCCQAxRmJ691jsFHDPQ8Jyu8LzJpYbTPdAgmfxAf5fzaThOaFqfVbQnLAO23jDt72P5rCFc3FSgg6aeTqQl0jM7Ozy5tn68J2+tglEE6YMDaG5kcUPB9lU4/IWmqI4opxNvfqtQzBxQe+1Uj2ih/bxR7TukdgSwVm5LGpXLebmipwTod7l8w2Qp8lltXOQ6vnfkwv51g4nCul3+fK+QCuifA3h7ilsAwKUgWvq+vpI3rpI1LvcfBcePaRV3q48cGFzfRpOFkd+ufUh7IxjTzi2j5VN4rCeOeGlvl72Nj5/9VM3JOmShOH7J8uK7sKL9p4QOvNtHsQGRLVBBEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpD6s1hKzBZz2wMbxrzFMCqRtIOrJKirbqzjGrT/Yco=;
 b=Pgqa+Y05i0kWhlYw+G/QOPRnwBY8Q+RVs/Qm8n+fJWYCJCX+u1gNBaVyj6K2EQkcwvxgRboJS8bHzEv/f5Czs9F3BhFv/Xk5H0TZSZfl6TNOaXbiFNNOSTJJZ3XuZFBWeOPR7y2H7GzriklIiZtvCOQ0CXP+/JC+i4SudcfHjGXpYlMMcJTV0F9P3SxRKNp0vAckXIpSOjB6lmmtrcPsRvNB5Owb8J1ZH+G4mcXNCxOc+/659gsL5LYoruVD7Wpmzap/I7cV22ltoEfMgykwiea6MHi0qXNojuWPv5WG3sjyq9XPAiTzUV3+e82bvWmjDrwqwVsCzFIdzEtSu30z2Q==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:36:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:36:20 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIXSBmaXJtd2FyZTogc2Nt?=
 =?utf-8?B?aTogRHJvcCBtbXVfc2V0X3JlZ2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlz?=
 =?utf-8?Q?use?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZmlybXdhcmU6IHNjbWk6IERyb3Ag?=
 =?utf-8?B?bW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2aW91cigpIG1pc3VzZQ==?=
Thread-Index: AQHcSheFlyrYRNUGyUyrWHPOj/5oPQ==
Date: Fri, 31 Oct 2025 03:36:20 +0000
Message-ID: <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
In-Reply-To: <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM8PR04MB7377:EE_
x-ms-office365-filtering-correlation-id: 456e2e69-8bf5-496f-704d-08de182ea87c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bWRpUWFCTlMxWWgxWFZEekV1WHczSlNOWnRNVk1VR1phcEJzUTF1ZW5IYllS?=
 =?utf-8?B?MDNHZ0lRc1MzSDZPMmQzSWlxSWU1TTU3VW85bmRsSEdEcHkxd1dGaENoaDd0?=
 =?utf-8?B?UlA1bjVZWnRVc3dIUzdvQm5YbFR4WEdaNGlTZWNtSXhSdExUVGg0Ry8xQ1JZ?=
 =?utf-8?B?R3FmazBtTUJHeHZTZEQ0aGVCakN6dENydng0eDBaRW9jb1pMTWJPc0hQeVFK?=
 =?utf-8?B?YXVuU2JEM0RxVThLdDhFNXZuMjc0N1NTbVhkVzVhaUs5eGhUSUFxWGRDc3pV?=
 =?utf-8?B?RS9oV0lMTlJoK09kYW9HT25LZU90VnFIM29PK09UY3pOa2M1enBXZFNHbHNZ?=
 =?utf-8?B?NTNBUUxUUWNDUTRLQTNYY2ZDQjVYb0xoeW14Vzg2cVRHaWZZcE1jMVZaWGR5?=
 =?utf-8?B?NDJNSkVaWjlqaFFyUkkycEZ6aS9waXZyZU5iSytPem42bjlrN1hCaU1GVWtN?=
 =?utf-8?B?Wll2VVFWRWN4MS9tUEk5VE50WlNJU3lJWU5tS21VMHJQb1k2amxtZlp5U2gy?=
 =?utf-8?B?eTlFbEJQazY2bkIySVJINlQyT0RvaFB5OG8yWlFweHZTejdXZ1JkVXhYWkRX?=
 =?utf-8?B?clY2VzNibmpzVEt2NUw1SmxzMXNsaGIxRFU4RVRzQTFxUXFuV0VkbUJIMmxN?=
 =?utf-8?B?M2Y4NThvQWpQbG0wTHloZGlLYXFwVmtFYUNKMTFpNGZRTGVpWEpBRDBVUmVB?=
 =?utf-8?B?bFdQL3M0MVJYUmNURjgrZ1hqU2EvY1hJak5BNHdnei9BTXFPYWw0TWcvV1E1?=
 =?utf-8?B?ZTc2TGlvY0dKYVZHSXpPaDVsRFFhTG1JeFpnK090d3VGamxrUExrd2N4T3g2?=
 =?utf-8?B?ZTJEUGg4NU1teDFQcUdMYXdkNUE4Wk12cmgreTBJbXFzeHpaMkVsOGF1MTZQ?=
 =?utf-8?B?UmxEcVBNL2ZoWDhtYVpEQXI1QjNYVU9sUHpXUXNINi9ueGZrSSt5akpqU2U5?=
 =?utf-8?B?aGJPVDJuMU5iRGNMclA5ZTZvMVk3WFJmZ0Y1MDFHZ2NTTUljWUNaMDRnN3RK?=
 =?utf-8?B?MGkyYXFMbkpzVm9weXVhUkh1VjMvcW5QRkxhc2gwMzBidTRsUGdkNi9PNTJU?=
 =?utf-8?B?UG11WXNKTisyZ21jclVqL3BNUjRaS05PRW9xRzRkZVhOeFhvV3pKaUhlMUdT?=
 =?utf-8?B?ZUdMQ2l6emF5OXRMTlNSZ0M2K1ppSXZrdVdLUCtKM1dWQjFqWk1aMjRmUlVM?=
 =?utf-8?B?RlJ3dTVBY0tEWTVCNmZyVGFxM1pWMURhSFFtRTNudXpqK2pMOUV6cERBNEtF?=
 =?utf-8?B?MjVxNTE1bUFIb3o4ZllEa0pGWHd4MDZLWGd0T0Z1MVdJalZMdzJ0RTFKYk5S?=
 =?utf-8?B?bnJGbG9yb1FpbG4wYml6c2hiZ2l6aVljN2p6Vy83TjRnUHU5QVFiSmVDMkJ5?=
 =?utf-8?B?YVYyQXFLakszRHAxSkx5M3ZoYjJKOFJyeG44YlNCc0tJcW52ZnJTQzB6UHVO?=
 =?utf-8?B?TjViYU9Rc0dST2Jrdm5VTWxzdDZ5SnVOMDM2RkdIbTgrSW92aXozQ2pDQ1N4?=
 =?utf-8?B?SkdydkRyT0pyeG45NUdHVFBnamF6N3hNNENlL0FiRVh2d2krV3BiVVVhWGk1?=
 =?utf-8?B?OFRMb1Q4UzNsekNKYkdPRHNrRDVJdkJHYmxrQlVmMHZWSTB0TEFkK3JwMmU0?=
 =?utf-8?B?aW9ScDZCTUZYVGtYek5VZFIxRm5Jb0doajkwSm8wMlZjZXRKWE9JT0pUK1dX?=
 =?utf-8?B?c2k4bVQzVnZBYy9tR095cXRqc2I4ME12ZGJyT2FzRG8yc3Y4NGVEVmp5V0pm?=
 =?utf-8?B?TGN0N3o0dEdLZmdGUnJ3VUdWY1pwV3pPQTRuYU5SeHozdlk0b1F0TWpUdEFR?=
 =?utf-8?B?U2twZGhUWm5YTy9SZkpFUHlRS01rSlRvRjBpT2FsWDlyTGNPMVQ0OGg5Q1o5?=
 =?utf-8?B?QW5VeTBsU09IUUp1bEpXQ3IzU242b2RJK2tvK0tOYmdiRGE3YXpuTGVxME5S?=
 =?utf-8?B?MklJZ1RIQ0U1a1J5Z1B6N0RMcGx1NEsreVBoTWhOenBObWRSVnhtcjlxalBV?=
 =?utf-8?B?dXpabWs5UWFWRWkybE5pQ1FTNHNzY0V4MkQrb1Bka0hzelQxRzdGbXZOSzVx?=
 =?utf-8?Q?9qKbkC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQ4eFJMbUNBRFpyN1E2MXdlM3RQb1I1VFR4ZWNiR1lmNStBRm8ybW93Tndm?=
 =?utf-8?B?Q0VGREU0RnBxcDFkV1RZeHIzb0JvUUtPQURZVWNTZjNaejVJc3lleitmeWJU?=
 =?utf-8?B?dVExZTE0TnlhcENQYTZCL21Kd2YyMjFRdU54TkZXUUVGRWd2RkhhNU13YkN3?=
 =?utf-8?B?bFFXUlk5d3NFUDZmWGhpY0crZllVeHk1R0JTMCtrWFVGYmlwLzN2ZW5kWFln?=
 =?utf-8?B?bmJvM0dHR3dTY1doUlAyckJuamNTZnd6NGIwZ016eXJvYVhJSWUxNmdGZFJZ?=
 =?utf-8?B?dnlvdzRNQkN0RGNFWlFJb2FhMFZlOUk5Z05taTVmYW4xVWVBVFAvK0s2QitN?=
 =?utf-8?B?T2RrRXVuWGhuak92M25EYjFtZVEyeXFNV3hUbkVyY1N1MnNNYS9RZitvY0hT?=
 =?utf-8?B?UFlFaXBQdFdzeEhWcWtqS2tLQkZnQyswc052OGhTckdqZElRblJDMGE5ZHhI?=
 =?utf-8?B?b25FOHR4cTFmbmt6UmxLQ25GR1lTY3V1cnI3WUZPbFpNcFFiais5Vkc1bCtk?=
 =?utf-8?B?UjIvZm9GT2lBZWJjNDFmWUw5SFF0M2FkQUMwTkM2Mm9KNmpCOGdQMDJ6bHZr?=
 =?utf-8?B?Q3Q5RDVTSi95K1YyVUs2Wm1SVXgvTjh2SDNTa2xkakFPNzNQUmkydlRMQjYw?=
 =?utf-8?B?OUZGR042TXJiSDFmMUI5RVhWRVNhMDF2UDI1R0lnalJxdFVzaXVlNXBnaE9Z?=
 =?utf-8?B?Qm5nQzdVY1dtL21may9KdE95azl3bW95cjVQdmRMSDBZcGtSS0hIVjdBN1Nn?=
 =?utf-8?B?ZW1oQlFUdDNDM051a1JzUG45eEthMFlCZEk3bHk0YkJSc0lDQm03OHZNUHhp?=
 =?utf-8?B?Q2NNWDZiQjZJNWdZSTY5dU5TTm1zRFB2bUNaZWRuR2FOSVNFVStKYVR0RmVP?=
 =?utf-8?B?eDdVVG12RE0vYmtndmtsQmtGY1I0Qy9yZjJ1MTZMa09nV0FmbnowK2ZZZ2x0?=
 =?utf-8?B?bkdBbWRZcGJid0NoVVJFWjJQR1hMMSszQjZYNU1PTWluVnpkSVNGVHV5TWtK?=
 =?utf-8?B?THFlNkk2dG54K29xemIwMkwzeU1CaExvdnMrVE9YVHhLWnd2NFVCbGtseFZq?=
 =?utf-8?B?NDdQc3V4KzRjQlZwWnZaVElDeTRyNkwzUCtGai9iSkdqWERWeitCblYxWnF4?=
 =?utf-8?B?ODJYbUhsWStPMnRHYklnaHZWRHlSMDhSWnlsVmNza2FqUmdmMFBsdTQzV2Ji?=
 =?utf-8?B?NjRCdVM3NkkrWXBzcXZaWWdJUmFpTjZ4NHpkWDAyajlBTFlXQVkzRE93VlVk?=
 =?utf-8?B?K3dlOG1tUWQ4U3piQVM1dW0xa1VIVmRYclVnRVRXaU13bDZkQzJyWUpPTG1i?=
 =?utf-8?B?d1VkbmpZMTlSRHJsZlNwK25nMmRpaWk1Q1grUTB5SU9WYXFQNnpwaHVDdDd3?=
 =?utf-8?B?Y3ZiQ0ZMUlJlUDdvM0daejRCMUVlTlZzT1RET2k3MnE1TGxaZnVtcUUrRmR3?=
 =?utf-8?B?bE1Jc3p0WVJVNXhMS3ZCMHcvNmtKVmdid1pWcFJvcTF3bkZEZTF5OUc0eWJT?=
 =?utf-8?B?aVpBRlF6Snk2Q2k3WFJkZUpxSnZkbU1Od01TSWNwblRnYkFEVS9EU2EraklV?=
 =?utf-8?B?TjVJM1k0U3ZzT2hOaHNtNUZuV2kvQVRheUlPMmZwb3dPckpTVXBDMEFUZ0M4?=
 =?utf-8?B?ZGU5NnJ4OWJ1T2p2dmZnKzJCVE9KQ0RKd3NHdHI5bCtGckVpcXVOSmJEOEJC?=
 =?utf-8?B?ZE9LTHpEK25POGFCWERjaXVvTkMwWDhBMGViK3hKaWM5clhYbUFKT0JPcUJn?=
 =?utf-8?B?Z25BRTk2UEhQeWNLZHF2SW9UWVNHWnlUTkpiZlBqMHlNcVlVWitTUEJLNVc1?=
 =?utf-8?B?WFJnNzVpSmY5dnVzUTFGUGJVYW9BS25NVTRpcjRtTW8vUksyeEJXZklJYVo5?=
 =?utf-8?B?bkc3cXkrazFjQWdZU0h5eVRNVDhlcjZrc1RORk0xSW5JNm1FeEFBVVZVQnlT?=
 =?utf-8?B?eXZoeWpaVm5ITlJUSk1XNTE5VzNzRk5GQkpZdjR1dWFleVBOdmJ3SityK0ts?=
 =?utf-8?B?eFpnUlorcC9pdEFNbnU0SU1EUk03NEd5S25PUTZtcG44ZnB6bUV5cGJ1NjJP?=
 =?utf-8?B?Ky9Fa3ZpUkN3bStFUnFrQUJDN05wS2tZTGdBcWJBV2QzT2ZpNVZjbzlBYnF3?=
 =?utf-8?Q?SYHTIQOU4I0IsKsfQoC8vM2Yk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456e2e69-8bf5-496f-704d-08de182ea87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 03:36:20.6908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H494g8yz/DIaDj/MUCzlL66uIAiNnzIff1IKQmOtQ5AAJc66EboeC6Bf7L0ymiGJVIGFTEANjgSrRv+N5X56hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMOaciDMw5pelIDIx
OjU4DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiDmioTpgIE6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54
cC5jb20+OyBFdGllbm5lIENhcnJpZXJlDQo+IDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+
OyBQYXRyaWNrIERlbGF1bmF5DQo+IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPjsgUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29t
PjsgVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29tPjsgVmlvcmVsDQo+IFN1
bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDkuLvp
opg6IFJlOiDlm57lpI06IOWbnuWkjTogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJvcA0KPiBt
bXVfc2V0X3JlZ2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlzdXNlDQo+IA0KPiBPbiAxMC8zMC8y
NSA0OjU4IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+IA0KPiBIZWxsbyBBbGljZSwNCj4g
DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zbXQuYw0KPiA+Pj4+
IGIvZHJpdmVycy9maXJtd2FyZS9zY21pL3NtdC5jIGluZGV4DQo+ID4+Pj4gMjM3ODcxNTU5ZjAu
LmNkMWMwODAxZjcyIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9z
bXQuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zbXQuYw0KPiA+Pj4+IEBA
IC02MSwyMCArNjEsNiBAQCBpbnQgc2NtaV9kdF9nZXRfc210X2J1ZmZlcihzdHJ1Y3QgdWRldmlj
ZSAqZGV2LA0KPiA+Pj4+IHN0cnVjdCBzY21pX3NtdCAqc210KQ0KPiA+Pj4+ICAgIAlpZiAoZGV2
aWNlX2lzX2NvbXBhdGlibGUoZGV2LCAiYXJtLHNjbWkiKSAmJg0KPiA+Pj4+IG9mbm9kZV9oYXNf
cHJvcGVydHkoZGV2X29mbm9kZShkZXYpLCAibWJveGVzIikpDQo+ID4+Pj4gICAgCQlzY21pX3Nt
dF9lbmFibGVfaW50cihzbXQsIHRydWUpOw0KPiA+Pj4+DQo+ID4+Pj4gLSNpZmRlZiBDT05GSUdf
QVJNDQo+ID4+Pj4gLQlpZiAoZGNhY2hlX3N0YXR1cygpKSB7DQo+ID4+Pj4gLQkJdTMyIGFsaWdu
X3NpemU7DQo+ID4+Pj4gLQ0KPiA+Pj4+IC0JCWlmIChJU19FTkFCTEVEKENPTkZJR19BUk02NCkp
DQo+ID4+Pj4gLQkJCWFsaWduX3NpemUgPSBQQUdFX1NJWkU7DQo+ID4+Pj4gLQkJZWxzZQ0KPiA+
Pj4+IC0JCQlhbGlnbl9zaXplID0gTU1VX1NFQ1RJT05fU0laRTsNCj4gPj4+PiAtDQo+ID4+Pj4g
LQ0KPiA+Pj4+DQo+IAltbXVfc2V0X3JlZ2lvbl9kY2FjaGVfYmVoYXZpb3VyKEFMSUdOX0RPV04o
KHVpbnRwdHJfdClzbXQtPmJ1ZiwNCj4gPj4+PiBhbGlnbl9zaXplKSwNCj4gPj4+PiAtCQkJCQkJ
QUxJR04oc210LT5zaXplLCBhbGlnbl9zaXplKSwgRENBQ0hFX09GRik7DQo+ID4+Pj4gLQl9DQo+
ID4+Pj4gLSNlbmRpZg0KPiA+Pj4+IC0NCj4gPj4+PiAgICAJcmV0dXJuIDA7DQo+ID4+Pj4gICAg
fQ0KPiA+Pj4+DQo+ID4+Pj4gLS0NCj4gPj4+PiAyLjUxLjANCj4gPj4+DQo+ID4+PiBUZXN0ZWQt
Ynk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4+Pg0KPiA+Pj4gVGVzdGVkIG9u
IHR3byBib2FyZHM6IElNWDk0IGFuZCBJTVg5NS4gTm8gcmVncmVzc2lvbnMgd2VyZSBvYnNlcnZl
ZA0KPiA+PiBkdXJpbmcgYm9vdC4gTG9va3MgZ29vZCB0byBtZS4NCj4gPj4gVGhhbmsgeW91ICEN
Cj4gPg0KPiA+IEhpIE1hcmVrLA0KPiA+DQo+ID4gQXBwbGllZCB0aGlzIHBhdGNoIG9uIHRoZSBV
LUJvb3QgTlhQIHRyZWUgYW5kIGZvdW5kIHRoYXQgaXQgYWZmZWN0cyB0aGUNCj4gaS5NWDhVTFAu
IE9uIGkuTVg4VUxQLCB0aGUgU0NNSSBidWZmZXIgaXMgaW4gU1JBTSBhbmQgbWFwcGVkIGFzIG5v
cm1hbA0KPiBtZW1vcnkuDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRlc3RpbmcsIHRoaXMgaGVscHMg
Z3JlYXRseSAhDQo+IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBmaXggdXAgdGhlIFNSQU0g
bWFwcGluZyBpbjoNCj4gDQo+IGFyY2gvYXJtL21hY2gtaW14L2lteDh1bHAvc29jLmM6c3RhdGlj
IHN0cnVjdCBtbV9yZWdpb24NCj4gaW14OHVscF9hcm02NF9tZW1fbWFwW10gPSB7DQo+IA0KPiA/
DQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IE1hcmVrIFZhc3V0DQoNCkhpIE1hcmVrLA0K
DQpDb25maWd1cmluZyB0aGUgbWVtb3J5IHJlZ2lvbiBmb3IgU0NNSSBjb21tdW5pY2F0aW9uIGFz
IE1UX0RFVklDRV9OR05STkUgcmVzb2x2ZXMgdGhlIGlzc3VlLiBXaXRoIHRoaXMgY2hhbmdlLCBT
Q01JIHdvcmtzIGNvcnJlY3RseSBhbmQgdGhlIGkuTVg4VUxQIGJvb3RzIHN1Y2Nlc3NmdWxseS4N
Cg0KICAgICAgICAgICAgICAgIC8qIFNSQU0wIChhbGlnbiB3aXRoIDJNKSAqLw0KICAgICAgICAg
ICAgICAgIC52aXJ0ID0gMHgyMjAwMDAwMFVMLA0KICAgICAgICAgICAgICAgIC5waHlzID0gMHgy
MjAwMDAwMFVMLA0KLSAgICAgICAgICAgICAgIC5zaXplID0gMHgyMDAwMDBVTCwNCisgICAgICAg
ICAgICAgICAuc2l6ZSA9IDB4MWYwMDBVTCwNCisgICAgICAgICAgICAgICAuYXR0cnMgPSBQVEVf
QkxPQ0tfTUVNVFlQRShNVF9OT1JNQUwpIHwNCisgICAgICAgICAgICAgICAgICAgICAgICBQVEVf
QkxPQ0tfT1VURVJfU0hBUkUgfA0KKyAgICAgICAgICAgICAgICAgICAgICAgIFBURV9CTE9DS19Q
WE4gfCBQVEVfQkxPQ0tfVVhODQorICAgICAgIH0sIHsNCisgICAgICAgICAgICAgICAudmlydCA9
IDB4MjIwMWYwMDBVTCwNCisgICAgICAgICAgICAgICAucGh5cyA9IDB4MjIwMWYwMDBVTCwNCisg
ICAgICAgICAgICAgICAuc2l6ZSA9IDB4MTAwMFVMLA0KKyAgICAgICAgICAgICAgIC5hdHRycyA9
IFBURV9CTE9DS19NRU1UWVBFKE1UX0RFVklDRV9OR05STkUpIHwNCisgICAgICAgICAgICAgICAg
ICAgICAgICBQVEVfQkxPQ0tfTk9OX1NIQVJFIHwNCisgICAgICAgICAgICAgICAgICAgICAgICBQ
VEVfQkxPQ0tfUFhOIHwgUFRFX0JMT0NLX1VYTg0KKyAgICAgICB9LCB7DQorICAgICAgICAgICAg
ICAgLnZpcnQgPSAweDIyMDIwMDAwVUwsDQorICAgICAgICAgICAgICAgLnBoeXMgPSAweDIyMDIw
MDAwVUwsDQorICAgICAgICAgICAgICAgLnNpemUgPSAweDFlMDAwMFVMLA0KICAgICAgICAgICAg
ICAgIC5hdHRycyA9IFBURV9CTE9DS19NRU1UWVBFKE1UX05PUk1BTCkgfA0KICAgICAgICAgICAg
ICAgICAgICAgICAgIFBURV9CTE9DS19PVVRFUl9TSEFSRSB8DQogICAgICAgICAgICAgICAgICAg
ICAgICAgUFRFX0JMT0NLX1BYTiB8IFBURV9CTE9DS19VWE4NCg0KQmVzdCByZWdhcmRzLA0KQWxp
Y2UgR3VvDQo=
