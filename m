Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76986C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 10:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD10886D85;
	Tue, 19 Dec 2023 11:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="bVxpqM3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23A986F1E; Tue, 19 Dec 2023 11:29:47 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A434886D2E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thomas.Schaefer@kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndoB8safFLcYQnjQvzpzmWUEkfEILY/PgKy6klZedkRgSX0zZ5MkHQhqnFJiWDp9ewsyP68EdUFQgIrVHDcD2ZGMaPtWp6M+V9Y6MuJaUYIpaKaRgx56Q338w8aL7CJSREqo97YlBuMkRPRr7bRzrT7ImBVy7rStKyxBdJpFmvitKc7W6FAiudBLoO1Bg+lFpii3qXYJ0RqPlNAI7YNhF3oPOLAWBbyaLEo48/7skyE8UaWuVBuIPOoiwEQEEduI6ntkPz3rIy4dfhb0L2hxYrPxKlgGLfOl5P3rvsJDRgWKnDElHmsdt9q8nozGLO48KBBU5DgLxisYNEOvE5u/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osnJJON0MDxKGxBk00Yi8k+axXEiATlqf0bKYa/J/vI=;
 b=K+pishhTilOiNU+rxhC+LMJqnm1am2c2hOIiIqKfGDbRZirmUaIfaG4hZya8lt+CeHdCxkr3huOAhJn4Ozv/IBaT46lN71q9kIULTLurLTh+wrouTmYvQmx0auEXuFNGOE+J2W/bW8G6vPbVpmLVwM3uS5nk9jP4oePRhyJtg7WX+Rt8YQjrUWwpSjvIqRHJ0o2lxEeqQOWbmt5kgbaZLM/E3lcSMkfoRg3gTXGH/Y/upqtt2mTtXhNkVw6Pu8x9nOHsCgCOgAk9JIm0ECPxiKrP1nYgWquoZQjDqx3c/K2Xv+kQMAWNDWe+8DCnkMNhxBE11uphYL2m5njNpA9mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osnJJON0MDxKGxBk00Yi8k+axXEiATlqf0bKYa/J/vI=;
 b=bVxpqM3biv1LTREdjMt08zc1LI3K1UIu13OA5Oz5H1PtZaW+do1NApbHUBTGuq9ImVRYQSc56vdw3bLfrf8N8aj9uJ7cR/g9vy1Q6LjrA/huOZHUmiyWmwGIaJODj4lHzG4Y0RX05RrRvPWulAIUWL3RxBGEBcY3tZUJSXEolB4=
Received: from AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:46::22)
 by DB9PR10MB5235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 10:29:43 +0000
Received: from AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7175:23f3:d229:bb12]) by AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7175:23f3:d229:bb12%3]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 10:29:43 +0000
From: Thomas Schaefer <Thomas.Schaefer@kontron.com>
To: mbrugger <mbrugger@suse.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "macpaul.lin@mediatek.com"
 <macpaul.lin@mediatek.com>, "fparent@baylibre.com" <fparent@baylibre.com>, 
 "mbrugger@suse.com" <mbrugger@suse.com>
Subject: AW: Using uart1 on mediatek mt8195 derived board
Thread-Topic: Using uart1 on mediatek mt8195 derived board
Thread-Index: Adop93yhTv2TROYySNOqmHa1StEQRAIXtWqAAAOFm0A=
Date: Tue, 19 Dec 2023 10:29:43 +0000
Message-ID: <AM0PR10MB2082410BE48997A335DFC481F797A@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
References: <AM0PR10MB2082C282ACACF92E42484727F78AA@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
 <800e2ae314b725348f0d25cb1676a04a@suse.de>
In-Reply-To: <800e2ae314b725348f0d25cb1676a04a@suse.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB2082:EE_|DB9PR10MB5235:EE_
x-ms-office365-filtering-correlation-id: 9bea70c4-8dd9-4f8e-d4e0-08dc007d6a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plDNqiqhhqJ3y2ZUIubMqqzEQ/2XhJvY4izqupPVSiz89CTxG2UpjuijWz8YvkNE0YK5SdRddXJFdzICvQb43KjqW9kAjKOecbQCOFFmzr0q+YA9P/FrF9IRL89QV3cdSwsTQyikj6MXt21tewTkFp9zJsHEb60iavb7/7fH9H14JjgiecN4ZIksyIeTZVhPxxyTnk99+cZsg6G1rOaTd6vFcbp9DLEhsZw57IL3xZrIgFEPIinYyAxyvxNA/4qvITX/dDmwkrc7VZ0G5bq1Pd+kl4aYU+O6dpj7V0ZVaiRrwxpcQ4nHX4GlMXPPv5bzOPj8bfx07fROvJU54M85mmlhSWbA0rAjkFIWIqPGa/2PIRlxzXhVjBxGav+2sD2B0RuJvboFFoz0nUcJSFlxZejhDH5YQCCpLdK1CoeC5v9hYycc9DH/HZpXCYPk58XOps8TE6NC9k7Uys8TqviYnWnwAJejKo6Y0FvdoXJ7mETR+soptRvaHHzBTXbgI134UVggoaTqKOj3qQuNf2CWzrM7liSPMXbMI/NYRMzj/5YIGgxsbRCZA2odM+bnCDLFpcqBorDc6HZ5OAECT7XcMaarAmwqH4l/gmu1Sk+IApA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(76116006)(66476007)(66946007)(66556008)(54906003)(83380400001)(6916009)(316002)(64756008)(66446008)(66574015)(38070700009)(8676002)(8936002)(4326008)(122000001)(41300700001)(2906002)(38100700002)(52536014)(86362001)(33656002)(5660300002)(966005)(478600001)(55016003)(45080400002)(9686003)(71200400001)(7696005)(6506007)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TVaKYev8X+tffiIvW3ZQC3FcCN2sAN+ia+9RQUzGk3v4Vn7egZadLhoHnG?=
 =?iso-8859-1?Q?6pc0sAgNkCk1uohwehf6a+vYyklGW15fX3kIp5q/rOkJvBtoGFG1yiTOoJ?=
 =?iso-8859-1?Q?dyhJ6sObZ31iE1n6gcfhl/HtFWreEDxoQ10MJm6iInQBkhP2lHwWz0iUt5?=
 =?iso-8859-1?Q?LFSIF7yhSXPD7j8sw8QaulbhGJ0a4VR9f9SSp1trNUUmS7tRtZdrUGAX90?=
 =?iso-8859-1?Q?mTdFDNUWhSNrvsWMx7LRr2UpMJ+ZUxOgP3r7lgKMvx11KgmXSn0Bqst8kI?=
 =?iso-8859-1?Q?v5nBSecFJFKWiZ99eEdmSWvGtFRoBZ2xKquW8/HI3wXQdsDko8C5CZ1N/9?=
 =?iso-8859-1?Q?Y5yRhL3u1WXxeb5M8FvwfPR1jXUHemX1IA1cBTXvWwTxkcmd+zj6kDDTCI?=
 =?iso-8859-1?Q?UQL8oA9JqffWfe1LnHyHTXYOHj9MUTbNy3sqjnbeauWGCrCNrgfII3z6G/?=
 =?iso-8859-1?Q?sbQc29euSyYp4YnqMBksRCkRL1SXNijpg5wYk0ZhO0ALrgfixVDtAD1ac4?=
 =?iso-8859-1?Q?fs2YXOV0BeTOqHtRdl1RttFpMyAK3vngYCJ/V49zDXPfwy9WKjWn+SWVOS?=
 =?iso-8859-1?Q?T2/aLERCX5cjDHeZ8ydC1WC/fM1VRzl0eFQk6guWke8K3/dOQBtF5OJJM6?=
 =?iso-8859-1?Q?Iun54Qx8oPqWI8vEcjlxqoHTW91Co/gxLLGnlnT6zpdwEUNTPgB4hoP93H?=
 =?iso-8859-1?Q?H1YxXUoeL7JlII/0ARRB+7uCAWhmdw7tGJUvJmj/Dj+kaBrNvn/pnYdiHm?=
 =?iso-8859-1?Q?KTT5CTHNkFKkDh2LTBmUja+THayGEfzbTe40rilEl+i653IXFdtYk7Oy3S?=
 =?iso-8859-1?Q?RR9e01ATepE8Smn5EoSWuR8yUv7EmOPUck91G7kOMcjT2kPJCNB165Pq0w?=
 =?iso-8859-1?Q?FDf2LVbz56Ryg1aiExbmIYoBtGR1UeZt2Csqkx1fvxxCRIxwGCGRmmnjBc?=
 =?iso-8859-1?Q?aKxXBc+qPXyDAttL7CtvWTb2Y/9gtfpgs082r80sEZvqmKP3VaDeOzCePC?=
 =?iso-8859-1?Q?r1HGq6cnHyLrNe2GXAHucR47QQBr1yikAaEVWKwLXWfsSffFvgoNi4wK1d?=
 =?iso-8859-1?Q?3SDUI9CxI+6z4wV9VElDj6S1x2g2wbrXmrOywj9zZ7fsttXhFYlkY+mjZp?=
 =?iso-8859-1?Q?ATNGMx09vQAPC/8QA5vAieNiYSpYTZA/q0uFZac5ueICaTEVc77+6AwR3x?=
 =?iso-8859-1?Q?luw7vR/6YIafTmpqBSBuui8KemzQqI1hQHjZGLszGeggUpPi3Qke/uO5BK?=
 =?iso-8859-1?Q?v5gUJhDb56yO4ygr9NJXBM/Fp13RRmkmBDhadK7Vqr6SgteI1L3ohST1Bp?=
 =?iso-8859-1?Q?eENVVATkxQNGCG55drsFQ6Bj5j3aX7JnD7bPEL+frjxVjWnOdPPRKLz3EU?=
 =?iso-8859-1?Q?1A9eVdeNt5sVbuAskQBLfPRoFNC8TsK0/u4IjBovD1wftdrIdjFbMJioU0?=
 =?iso-8859-1?Q?pS9J0yuBF49HFUtaAcsRIOdb3IyB9dwTQZI3SBVzbRC3YHXT9qsAlfP8M/?=
 =?iso-8859-1?Q?4Kdo+lGWkuTwCvwil/kvoExa5YGX9yVdHzosPHnPHyNKCwYpUcCwQI4vkC?=
 =?iso-8859-1?Q?EMdt+u4rTfdvqvdPdo2HwqB6cN9oQ0K7H9cN0pGepbwg17vPO/AgJup3JG?=
 =?iso-8859-1?Q?42VUk3i+qLWHFcmuG4qrW99NACnCw6Yr3dRKBcDUKhD/GGK6E+Llgzew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea70c4-8dd9-4f8e-d4e0-08dc007d6a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 10:29:43.0764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7O0Lj4DnnH1Eob4sGqzz7qj+QU3wKj1frzGd/CEIhRFa4ZS9D2hIsrEoyflmdUzpFhVkwF+bdoE4bpOV9Ic9UgE4G6Ic7A10PVyGSzRT5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5235
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


>El 2023-12-08 17:06, Thomas Schaefer va escriure:
>> Hi Macpaul, Fabien,
>>
>> I'm referring to patch series
>> https://patc/
>> hwork.ozlabs.org%2Fproject%2Fuboot%2Fpatch%2F20230804110448.24589-1-ma
>> cpaul.lin%40mediatek.com%2F&data=3D05%7C02%7CThomas.Schaefer%40kontron.c
>> om%7C7254656e8bcd4aaa665608dc006d75f3%7C8c9d3c973fd941c8a2b1646f3942da
>> f1%7C0%7C0%7C638385717332491611%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
>> data=3DeNa2nC%2BcBA8g8GC2z32nBO%2B4MvKIJGb2XU2lw3EqzTE%3D&reserved=3D0
>> where support for the mediatek mt8195 SOC is introduced into u-boot.
>> We are developing a board based on the mt8195 as well but we want to
>> use UART1 instead of UART0 for debug output messages.
>>
>> Our board is booting and we see boot messages on a debug pin header
>> connected to UART0 when using the settings from the demo board, but
>> when trying to switch to UART1, no more messages appear on the
>> console. What we have tried is the following:
>>
>> - Adaptation of the dts and dtsi files with uart1 settings taken from
>> linux device tree:
>>
>> diff --git a/arch/arm/dts/mt8195.dtsi b/arch/arm/dts/mt8195.dtsi index
>> a7e4db5aa7..53eb437fad 100644
>> --- a/arch/arm/dts/mt8195.dtsi
>> +++ b/arch/arm/dts/mt8195.dtsi
>> @@ -245,6 +245,17 @@
>>                         status =3D "disabled";
>>                 };
>>
>> +               uart1: serial@11001200 {
>> +                       compatible =3D "mediatek,mt8195-uart",
>> +                                    "mediatek,hsuart";
>> +                       reg =3D <0 0x11001200 0 0x1000>;
>> +                       interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
>> +                       clock-frequency =3D <26000000>;
>> +                       clocks =3D <&clk26m>, <&clk26m>;
>> +                       clock-names =3D "baud", "bus";
>> +                       status =3D "disabled";
>> +               };
>> +
>>                 pericfg_ao: syscon@11003000 {
>>                         compatible =3D "mediatek,mt8195-pericfg_ao",
>> "syscon";
>>                         reg =3D <0 0x11003000 0 0x1000>;
>>
>> diff --git a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
>> b/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
>> index c6ea7e8f3d..4700a6d303 100644
>> --- a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
>> +++ b/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
>> @@ -58,7 +58,7 @@
>>         };
>>
>>         chosen {
>> -               stdout-path =3D &uart0;
>> +               stdout-path =3D &uart1;
>>         };
>>
>>         reg_1p8v: regulator-1p8v {
>> @@ -121,7 +121,7 @@
>>         status =3D "okay";
>>  };
>>
>> -&uart0 {
>> +&uart1 {
>>         status =3D "okay";
>>  };
>>
>> We also tried to change the DEBUG_UART settings in the defconfig to
>> match with UART1, but without success.
>>
>> Are there any special means to make UART1 interface run?
>
>Did you had a look in the DTS from the kernel:
>https://elixir.bootlin.com/linux/v6.7-rc6/source/arch/arm64/boot/dts/media=
tek/mt8195.dtsi#L1040
>
>My bet would be that infracfg_ao CLK_INFRA_AO_UART1 is not configured corr=
ectly.
>
>Best regards,
>Matthias.
>

Hi Matthias,

actually the problem was that we didn't enable some transceivers on UART1 l=
ine.

After fixing this, UART1 now works without problems.

Best regards,
Thomas

>>
>> Best regards,
>> Thomas
>>
>> Thomas Sch=E4fer
>> SW Design Engineer
>>
>>
>> Kontron Europe GmbH
>> Heinrich-Barth-Stra=DFe 1-1a | 66115 Saarbr=FCcken | Germany
