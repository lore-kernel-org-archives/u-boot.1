Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BC5F9D0CA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 12:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3C7841D7;
	Tue, 14 Apr 2026 14:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P9nBeHFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82B5840D8; Tue, 14 Apr 2026 05:02:58 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D7683BC4
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPefOl1tcr4ExLabCs5jXAu3qc3+M+UFIqKNJ4nfd/dyl2I5tklvIwnVhDWjrJiN1m9X0Udv3fA3ZVVRL8flINoAUpZTFsOf9s3qGdTbJwk/jWXVf77cLfpY/a1+tj78393G30RRJ2UCj5MYKirQ/FoACFmekeyGvdb6tBFPPzt8+T/kYbtC9Zc9/akii5A7v+Hpbqw27tBwBq6bkrOzNxiQWZqU+U9cgNP8dEMNMG1QL0NighyToi57/Yt9Ga4VNFT5sOXR94d+mcMcc7rlNA5DvWgOUHqR8fhPJWeep4IHWdsnTknqwnux+IFbbI5Bc3uyZ+HJMYRTkP94CX06vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zerVmHn0LAgogbuwKscuAsR5x6e4igxSMIlvYabZYkk=;
 b=ULGwU2BLiVJRfcYkkBVpzbSgHLI2MA9sHeBJ+v0e/FU8w4HgnvjsIHbnuz1a2Jj6SjsT5sosWOV3FtL+mucE1EJYmG4O4wv90v4FgdIf3KzgqnGEjvSreAjpes1UXzJf9jT6KPQoTWkb5W23JXPR5XGh+J7yW/52dY7/SSn1rgZWR7XlueOT3eQ2seRaar7GLoFQR3lvIkmt77Tlorwc4z/Qip2zwb/xeRwaRNrFY71GAgn4tlM0oBXw+zG8pQaolb7j/tyXegI64s+mTS+JRp8K7iKiVFziLH6J88HmPETDTaNSCpZGDpXtm8dkXgEeFqpWspGcXGKzsHmsIoRQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zerVmHn0LAgogbuwKscuAsR5x6e4igxSMIlvYabZYkk=;
 b=P9nBeHFOmu6tLo4xni/nlrqqTGbzJ9v7uH+y1T0mocPzyasbQpCrlPUcnpOPLXd5bSTHA5fqZVsH/Xps3duKS7aOBzRIBynyd9RC7yHzHIjv2MuXuWzR6puPPoed5eWLE8IBTMqW2YX0WcnO6XP4NezFQhe7GL4lL89J1oKmqvX+DudLDDnaX1fLcsJMesesXNBYVJob06nqA1iM/3V+NNLzePkHTbqjy9iG73oUI1DGysqgug8cbVDzuN/52vSFjYUKP4I83R0aUkOnf+1EXXZnEF41EiynDIvHIDZOs5UQFfMJ4C6L9ywLGBZfmurunUPhO45s5zNe2dSFpS6FdA==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH3PR03MB7435.namprd03.prod.outlook.com (2603:10b6:610:195::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 03:02:53 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 03:02:53 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v2] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Thread-Topic: [PATCH v2] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Thread-Index: AQHcl0FLie9ELA3/kE28B9wfIgd6pbXdB4sAgAE2Zlg=
Date: Tue, 14 Apr 2026 03:02:52 +0000
Message-ID: <IA3PR03MB8021F3099C54AC7CE657FA74C3252@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260206081904.12390-1-chen.huei.lok@altera.com>
 <LV8PR03MB813764D9AB9C683D10955D58A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
In-Reply-To: <LV8PR03MB813764D9AB9C683D10955D58A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|CH3PR03MB7435:EE_
x-ms-office365-filtering-correlation-id: 1be70a3d-d502-4e28-1c24-08de99d251e7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|55112099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 7GW4/PrD53vRlSUGcIfmgH/JMaPscXIky6MdMbSAEgtOhIRv1sCj42CQ/mKBjbyjgbFflB9OrmY75Z8GVOnQYJBl1nqCfXhmyUazbjMSfh5N9xvCEJ57++Dg3lJhBQgNK613S0MuV0xiwf2QQQr9inOBF1vHCgsbOsb3g0rWRzHmZGVASF7J/sOgyMLSFPhtDIu9X3cJb2/dYa15LpPG13BFSm3FDPCWd/7TR+7a4oCbK9AkP9DJGCYsoH3/9jDen8CSW9nSKG2X++b3QnaxrMkfpurOPvIuX8bFVjw/sCwxWJqd8BMeaurAwC6eU51FlL+Dkz3pQRQaB8vKln6ZTk/4yffUBg796ufxIyOYhNOEO3Syq6W03yVyyiTqvmndUMShm/85c+bgiVV7UoLNH/XSnPKQL1cjEpuQSOIqSlMiy5TDxedJeO6vtz6f9hM52mxeCWzTfPoD2n9h4yiTuhwceCQd8D5QaUaIhAtBUOdCvKAhmBJRLXpr6CrHp9uGTGFkWQOgXQj73TZ1b0UwWvXDBg+SQISxZXAahbPzqZay6r8RCR6aAXdqrSpsh6oODt2fGWKhRKiCK4rmp5dHr1libBZadlWDik5AFTmozRfjrXpZYNM5hVSLTajj6QgHCD1Hb5S34x5aqZf/G1NGWOUy44oD+RjHEjT8IYYwo4IedKNrgQBi9xPAIalz0qBJo6qWbO6IDt19EcdsFoNz64T9EOePaDC3QrYVUGCdZA+bVFJ0IpZ9ECtqY8+bPPsyl+LrXOoXoFNOmzjza3XAxrri2062bOQ/ktiKWI0EL58=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?lgfXzximsYKixSYsJYy73dY7GrXyspe1Lp30xMBmpIehcRvYnjuCg0KE?=
 =?Windows-1252?Q?fMSWmqx0C6v+AwGA5GHMDOoGMCjZn/YGxQC5v0kyWMPS9O3zjSTo8B9x?=
 =?Windows-1252?Q?U6IF0fOSnJh5J8B+VAqH5bQgqT2w2M9wVDeEhBXcBaZXD16HQTBHjy6S?=
 =?Windows-1252?Q?uR6psbkCg++XGxFJKplCboRbV+5KbTb3ZYP2MzjNypYO4FJgDUArZCAq?=
 =?Windows-1252?Q?q3A/5Vrep1Jr6heY5bfksenTMOBWgv8PGY5QkoOqeUS8bXt/4bJUASqN?=
 =?Windows-1252?Q?PMsgmUgGxkFuJfqIWRtljvyftCfDcy/Mb7YL1o3JTdF8HoG6Dsb3BUBE?=
 =?Windows-1252?Q?IODpwjjZ4cwjyxczilwGhh0Cg8CBXk+v0LgokbzhhA6P+iR8K/qXdFA+?=
 =?Windows-1252?Q?h0pfac8+6PiwRb4WgnqrOaAztD+DvBckTsS+OnQuzHsoRU1bX9m8G4q5?=
 =?Windows-1252?Q?Xg/QuxqsK1Yic2dPIf4wIslFVbtx2KtrWjrhInKvNFx+iPbhprUZgno8?=
 =?Windows-1252?Q?bz0VeLQWenHxRc7bAWhHksuQtxvJENamuzPNT68jubEYVh0UEFB9p9J6?=
 =?Windows-1252?Q?0DY8MINoCGUYcL5omzW9JjRXkAieXnBckwo19bhZsNK4pr5U/wbn3tOY?=
 =?Windows-1252?Q?bypVn/r7Avsht797SMRwVoH9gPNw2zkvurN7e6za7UAcgBuwytx3sqVC?=
 =?Windows-1252?Q?AM8j+vsjUckztVb1qYZ90c4NJ9hEsc6Bg3d6fymoc+Bn4FlC1Mm5Y7lW?=
 =?Windows-1252?Q?iVTNmC8KT+c94DdcSNyvO8tGTAOEJoOdoOoIjAxUwrwmiuEZ4NZn/x/g?=
 =?Windows-1252?Q?BU0aeXl2ghw6X2P38u/VsN+Kg714co6Gqddn/6JdiNAirAsYAGWC4Vkt?=
 =?Windows-1252?Q?33HhABegBLFuMuubYKrB2e4hvABk01KoL/5Uy6OkTdYrtoL33F5BDQIU?=
 =?Windows-1252?Q?7JjHkgCA8gMZgzn2rwtGJZkCxGs2RbT0N3OZvTMEkPGPScqk/UEiixI0?=
 =?Windows-1252?Q?bNjxYX2tb0A3K/rg2irlfbjEa07IEtW1D4Ce/7kw4zKxRdstygEyB6fM?=
 =?Windows-1252?Q?z63Y9klZ+PNidTqRbyhTezlgOd7YV2ygFSFptMP/TSae1rNepu+fJKyQ?=
 =?Windows-1252?Q?+cS0c5u3pHzB0q+m3oaVO91Ip7uE2+iOZfGfKpIwHsY4xUFLAEcpf+uf?=
 =?Windows-1252?Q?pvQ7sJKaelpCS/IEISvNTgJb18acCm7o8c6/Rl9orKIW3uk8VbA0JWhf?=
 =?Windows-1252?Q?XxJc0ncwpR9e2ixYfqF+iBV4VwiDeEXuiR6vGpSkobBXVqXEymFEITBJ?=
 =?Windows-1252?Q?n+GWELJBPCY0gfrQ3IOKjI2LUHHv2vkIBPl7SE7+TpeMd9z5jZXNDVq0?=
 =?Windows-1252?Q?bLsKQnGcuKb1j7MeYms1PZoeIJ2MdZFv7XKGMuvYbG/lFSKqB95Mq49i?=
 =?Windows-1252?Q?KI0+o+uWZLg+pMJicSa+6Mde3vvZ3IsoyYzz/GgclxThgJChXa71du7d?=
 =?Windows-1252?Q?hAR4oeopa/xrgLJW2fgIb8EIA+pNCf/51XQnqfGxQ0/0HkVLZAG5PfRV?=
 =?Windows-1252?Q?TY31RRFj1IQQWMA8vJbwS4+rVsEPjNlMb7LUJCfab4htYcW4BRzawojr?=
 =?Windows-1252?Q?9XKExARiZpQGayuP8fm9gRxrD0TyGfzYlZlGE6MYo4Ra0Nrwp7gBRcQ8?=
 =?Windows-1252?Q?cREBykQ1rvicujdxroB4mzcXomqBgJYEawWSBAQ2CsxDircY7rdU13Sb?=
 =?Windows-1252?Q?JDo8JL2qioFNUrzyeLH3ud1OwE7b8oVrvZJi5k4NdrJxbwIZawBmsZic?=
 =?Windows-1252?Q?Eflx6YsMmAPWN8ZMdpN9ND9ffUGSCTTkCw3o9f6PgK+lMMHll8nXrJsI?=
 =?Windows-1252?Q?90HhZ5/dCMq4iw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be70a3d-d502-4e28-1c24-08de99d251e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 03:02:52.9250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YZiaTMA8G23d//TsKDLZXDCY5Fh4ZMEubt21cRH6bi5XkCgGgdaq476PM9cWwAH1mCDOebfNSK0pjnCzVKBsSBmIf2fKiUHFYOHs3GqWO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7435
X-Mailman-Approved-At: Tue, 14 Apr 2026 14:54:51 +0200
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

> > -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \=0A=
> > -=A0=A0=A0=A0=A0=A0 IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)=0A=
> > +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)=0A=
> =0A=
> Please respin against current master; drivers/fpga/altera.c uses=0A=
> CONFIG_ARCH_SOCFPGA_* not CONFIG_TARGET_*. Likely want=0A=
> CONFIG_ARCH_SOCFPGA_SOC64 if available.=0A=
> =0A=
Hi Tien Fong,=0A=
=0A=
Thanks for the note.=0A=
=0A=
Yes, this change comes after the commit that replaces the TARGET namespace,=
 so using the CONFIG_ARCH_SOCFPGA_* option is the correct approach here. =
=0A=
I=92ll respin against current master and update the guard to CONFIG_ARCH_SO=
CFPGA_SOC64 accordingly.=0A=
=0A=
Adding this context in the commit message for v3.=0A=
=0A=
Thanks,=0A=
Best regards,=0A=
Lok=
