Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C60FB5173
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 00:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7540D8352B;
	Tue,  7 Apr 2026 02:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YPLAGqTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC3983936; Tue,  7 Apr 2026 02:46:39 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752128341A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 02:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pInXyXN20Qjfm/YDr5I877eGZNWL4xOX95110XfQvqqhFQnqRZEi/7GwdDwEeAaO4q/hKLxj0d8INWtjdFVPrSlcVyvNfzDOHAUfA5DDwqpVUOmOcLCb6R/FFOTH4jBO9UMY0gFMPmcAoPZKRHJN53s12er+E/Xd+wjENrXP2vUJtWmCBO+UMumq8xwMfESBauvWU7Jjsm1b0q/cK/VD24YwxK/1SJxmdc84wSXWmxV6U7kW6ly3Uagtspr1gewWOa/XObmO+LC9sCPjWj6Ip0wKdLMXqYLGqkXsKtgFMABAhyMO/6GACi7u4u65N6hrbkcmqZXfYsBUjyR04ygoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tI2905FRchrRiJZ05RpouLRRlKXlMa77xdXIk59QP0=;
 b=zCZZT+sCMoqgamsyw1kD/93Vg+xAQ8NtsVR3NGpSEAuKq/T+pc0ixma9+fA+qLnCfcn1RsLTLB+Bs2It8n3ZKC3HuOzm4Uxa8DkGb84734qKzJY3Ep7FXgro3NBSYh43pS7kiCk6N69EEQxOmpe2pF6IKcm+inbY/ueE5UEN0JZIn6CQzodXiyaVgPV7LAb+JRY3j8/NdwjEWdoFK3ucjaVI9l7dn23jaLbbkRT0ONvRJ8+213Hvd9yemYrwmmi9yBMI8k/AYgi20N93YfUbDLd2er+l+eTM9nAU8h7lLgApOJiBpDiffJvQ40o7/vFTArRIqSRYVhrg0AF8ca+/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tI2905FRchrRiJZ05RpouLRRlKXlMa77xdXIk59QP0=;
 b=YPLAGqTKfpk0zEQ1pko8eN5TUg00iMZI5JJqKji1SC2k4EgV+4rbu5KeHWlA8ezxHfE2o0O0aPJUTfkN/7/2MQesWpj4VeGR2CYJRFJqQzeP2b3IaUyFWTRymEzD6fpO/SxfnMkw4TGfGM0AzqEfLAZC3YqQ+gfJj0aN/cVjyXRV3KOQQzpEe81TS/BzK00u/+oVdZ33CsQ4ZYukZKuUU4HCV2DDcpaaGRd39sDW5i1VhX4O/pjDviTwsf/cYda48fDK4I+fCjcHbnj4NAa6rRRZfV71+02GnNcjhqRuwl9M4JdH63ZPmBg9BWrht9k2kiufEN6XRkDgmVMk2w71hg==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA2PR03MB5899.namprd03.prod.outlook.com (2603:10b6:806:11c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 00:46:33 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 00:46:32 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, Chin-Liang See
 <chin.liang.see@intel.com>, Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut
 <marex@denx.de>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
Thread-Topic: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Thread-Index: AQHct5NhYEcwx8aNDU+9MkP3aZIY5LW13uOAgAAmm8qAAAK/gIAc1DJ0
Date: Tue, 7 Apr 2026 00:46:32 +0000
Message-ID: <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260319161609.GU502704@bill-the-cat>
In-Reply-To: <20260319161609.GU502704@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SA2PR03MB5899:EE_
x-ms-office365-filtering-correlation-id: ef2f58f6-9c60-457a-eb93-08de943f1d3f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: rN5QEEvmucPRTAIIqtovZZuH9F5CtAUuE7uvTEYEZRQ+cGti6TDalbGVVPXeNRwtgUzZ58/mhn9XEWegh+jye8jtus/0X6/9xhAH7It1kA+hyY+lJyG2vPQ3J3vbs0KCoDlZI58bTfxvzdutBRGTVCESy5msKtXoKzh3ujcqzyPZMB5FX+/ARI/QxJKxpujs6IQ/5baS1MUDWTSRsCgyYJ0D28dI91NrYz1zUngY1I47mBzBczioU/sfYkxkC28DroKZqQMe2rpNKxJb5QC/W5eOseC2R9936HitjyJqUG7tlr+glnoTbktAjrMfSfZooaII3q9Q/V9HSmvz8uAI9OGqCCELhWGKyGlpXzQFhBCl+91NEmya8JEE4sm7nzNCC/HXNV6H38pd2MIb+qDMG2e3bYc+PEjJe5ECy8HCaT0VMwu86mW3rlAkfyhXSh4wu4aME2Y61S+HLgoxG0nNXR5A2/HyBQ8TTdn+nmHX+0M5GNUu7Tj9GCZKs+8/0tU6AqtFKSXlCqfns4kdpb1sfib/2WAh31ym476aolpKjRv6zJ1BejxVr8TM1RYCbk9+4B3oS1mTlII3oIV9jZqC3Jzcwn/FMVfJSbw7AJ/nX1oxn0Uq7DsJ7RIjzLPDjlzLuaHSQC7flgx4RxZOcTN85/fMLQbsuem1mWNg/JtKh0PCzgWxWfMNY+m1f+FhO368bm581hRYrEDwp5habpBHYCTrKNePPnJmLGbvSzrHPmE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?63KmKwflKO8Qzmw+j+Q1LP11mVQkb6Q6js5u8e2E55mNV1HxJBZ1/XVSIh?=
 =?iso-8859-1?Q?64PQT/+CtWFZ7VQGtHIUfcbRn/Ppq5D1htitXDriFSSdTBPIyEACAOZpkQ?=
 =?iso-8859-1?Q?KINp0wwfpHB5rAh/D6hHL6qF8l4fMb9K7vKf1RvOkc/YxjLa71eJEWD040?=
 =?iso-8859-1?Q?Lqk3jcI31DZxQQKXhTCG1LRAzJSOv5R0DrYjOZys2Xom56CB7zHbi2UKAF?=
 =?iso-8859-1?Q?DU3bWKl7IQFn0B6lBmDB0SeV9zXiIwClSpjN6H9WmMd3ed2h9veIWOPLao?=
 =?iso-8859-1?Q?PZaPy/BOW3yHr9ieWk7Qlbp20QLBYsF4cnSUtZn1EyPDrcQO+n1XU4MHrb?=
 =?iso-8859-1?Q?RU9fAGIXvqhC0kmxzIq7ivddLuhamKap6CGc15bnF7pCVRGIQqFNZ2q09u?=
 =?iso-8859-1?Q?ydymlA/qgENpq3SwOcwWFJLu57KFGoJH2YQUBxjTON7kR7KRR3I7VojzvT?=
 =?iso-8859-1?Q?YqIhHnNZnhO0WRfLwoIjtUDME0Xp5DPDtZK5+13s4yTI1vmqfRbLiVTS0u?=
 =?iso-8859-1?Q?sofbOQldfmIRHEfsZmjJc0vZnMax5asAimV13KTFeNOPUZztyJ4cICojQH?=
 =?iso-8859-1?Q?gYpsfRSYvAVyRRmXh9Ulc5dlppot63d2teIe7vAR4YCOxZXUbbE+ggBxY9?=
 =?iso-8859-1?Q?MRHd/+K7FSAa5moMx7Baf8VcBhhJxgqkCnKwLccjk8Ssw6btb9F040e7XQ?=
 =?iso-8859-1?Q?/WWkzy3gkZa2lQ4OMOoduLmyJKYfspAEJ+a1Q7ewdslV9lW389/Sm2kiNk?=
 =?iso-8859-1?Q?xB/FWK0l3yJAu0LeF9Dhjb8fHIzsfTitLauH23M9dECm0PrpKAf+xMu03i?=
 =?iso-8859-1?Q?QuPKNCwMUgD9Y+EgaGzxpnT01yxQ9HIfeLd3/RRHTCP8Zns5cs7mK9WuFR?=
 =?iso-8859-1?Q?eK1IXwaIso2GEsCZSfgkV0xvTlu+wyq2KvugZ22bm5nslwY2IKEUbWSOtw?=
 =?iso-8859-1?Q?eSTmHlk3Ofpamtx6X89FCuR3BVVwXbXgS3Z5QLUCKzLGwFEgqbGlc6SfHw?=
 =?iso-8859-1?Q?RhrNDtGpBuo1vUaRRTPV/sXS+VQ2Esrn6jVS62GRTYvxc9iqbxwuQZBl3i?=
 =?iso-8859-1?Q?zRFpb+EIof+Ngh7xBvAZ2Zz6STjyIm+i/AoBHdvmzZ4AnJ5aZgAbNlRugq?=
 =?iso-8859-1?Q?Q6r3b6aGWdDfNeh8wMWWcBugpmZoU1fEBfrJlcZX4UYoemjZrfjXu1rkox?=
 =?iso-8859-1?Q?HQdR5+05eVSGw02CO/d6AJvGvlxVY/nTpv9w7QkSatLlqw/g59E1rYsupr?=
 =?iso-8859-1?Q?X2orjTsVk0PfySL8Ore0RSVaITFJjpevXHo3EDsTyO97H1qa/lP1QQ0Sqy?=
 =?iso-8859-1?Q?SP4MuV/HdVp2uUlyi4Ksj/r1JLN0ziw33CG2rDzZBYdKvN6leDXTi2u8Rd?=
 =?iso-8859-1?Q?9mAUGtj9r1QmVqiUdYM13Lg8ltSgHBXoV716OwUmRJPy3uF3/9Zxh4fkFn?=
 =?iso-8859-1?Q?/1NPeJrL9jFYmdpqNoZ85F2YwdVfvPPM0kVKpjYMtAiejk9OUm9tHIIH/a?=
 =?iso-8859-1?Q?f0HklTTJubGEw+kFpbjP0Lv0io9jrDKCGTdA7pZ2QO3PoB8O9vOaL+8hjX?=
 =?iso-8859-1?Q?BLdOTKUqLO9m4MGq7/yCZWSHpdxJjYlDVJa8LNHs/nMBhQ6KfYIYCpVW8c?=
 =?iso-8859-1?Q?1vW5xQZ79xbtOFoc6CXmz8+U83LoUQIX3yKZ9c8hSjmKYED4tKqSRtDZVI?=
 =?iso-8859-1?Q?blYtg8dn8GdfSbFkD59Kx1mXgMuaIRlcFIuYLTtgoK+krfJg5P3WglS3eH?=
 =?iso-8859-1?Q?nhSq/f4sfoaFmnkJ0m/QgMqaUTaeNoz2Xo7uQbmaow5N2pS5skjeHBks1z?=
 =?iso-8859-1?Q?owvcn03MxA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f58f6-9c60-457a-eb93-08de943f1d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 00:46:32.5161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGaHyGQiLBtJZwymJyYUDRlyaH798kJqiYEJdvpfSu2QkqJl18QO72GtkaxauFIbjrHvkvv0JKOFqTiFia3ZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5899
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

Hi Tom,=0A=
=0A=
> =0A=
> That's a documented host dependency. We generally don't want to disable=
=0A=
> general tools even if, sigh, I see a few other boards are also doing=0A=
> this now.=0A=
> =0A=
> --=0A=
> Tom=0A=
=0A=
Can share the link to the documentation? I tried to search tool the U-Boot=
=0A=
docs.u-boot.org but cant find any document related to the host dependency=
=0A=
this is only what i found https://docs.u-boot.org/en/latest/build/tools.htm=
l=0A=
but didn't mention about mkeficapsule.=0A=
=0A=
At the same time, i would like to clarify why this is more than just a miss=
ing=0A=
host dependancy.=0A=
=0A=
Since SoCFPGA does not support EFI capsule updates, the automatic=0A=
enable of CONFIG_TOOLS_MKEFICAPSULE actually not reflecting the =0A=
actual capability of the platform.=0A=
=0A=
Disabling the tool explicitly in the defconfing is an accurate representati=
on=0A=
of this board's feature set, and this is not merely a build workaround, =0A=
=0A=
and, according to https://adaptivesupport.amd.com/s/question/=0A=
0D54U000086ca7RSAQ/toolsmkeficapsulec2110-fatal-error-=0A=
gnutlsgnutlsh-no-such-file-or-directory?language=3Den_US=0A=
installing libgnutls-dev would suppress the error,=0A=
=0A=
but this will leave a misleading configuration in place.=0A=
=0A=
I'm curious, if the intent is that the TOOLS_MKEFICAPSULE should always=0A=
be build, perhaps the correct fix upstream would be to make the gnutls =0A=
dependency a hard Kconfig requirement?=0A=
=0A=
Regards,=0A=
Boon Khai.=
