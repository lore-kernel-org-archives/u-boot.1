Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5690EC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 17:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65137875F5;
	Fri,  8 Dec 2023 18:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="MDTLLWLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2A4875F8; Fri,  8 Dec 2023 18:06:59 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1335D875DE
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 18:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thomas.Schaefer@kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDXXSB8PleX6nyuAXHabkjzxrc/pkPntQ5W1KeIg7NoGHbCW9MJ3bjvbS1h4OFLFYznf2IdIKdurQlbQ0kzQk6Y7fdhy0YjABoom6anH5tUMSg3hX/m2lRbA0QWjJRVtqai3yEbBwcDZ40TFHFJHBUYJY6LHGs+b/A5Aqzn1hMfD2E4l6GjRByy3kSYI156mxcwpLDfCLPtPQEfpCn5BglFRXvVElGUviz3vfzc5+IgaQKLx+APpNvQa/q6SIV4DzZiEB3Km95Ffc9xnQOXP3BQwGaTvNf02TWXYygyR0UUviJYo1ZvmmQEZZr/5riSardu8OHnTF6ZCfyHvOBBaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hymTFXze2X8HLRPIv3onwPl6xEG6Ov0ZwgUjTP3CBA=;
 b=BnVNXr4dOE5VbJtJ55Dj2Jg46wH+Hw2LCNrpVA5P6VPEtMm7fkGdf37L/K5h6CVr0mmdDunsfY3OXe6pEQH3crRtsFon6OqdrqV7nDrfwbn/cKIaMHYldfwXzf9PeQb7Cywd+AZmTMMfTFQqPTArui46RVXab7xHRSv/9woSFMqGwRI8TlwwtgAwRTrP819ZceGfqbFSt8PVmiSaQ8GMCVWPQ9+oi9nDga5GXVu4aJE2ssR9QwDxMgaYShUzKOUGA93GdosqUtGvtiCmqQj3U8jddAQWJDQQGRHdbRCcWdR+ncB2tHSk/sFEXkAHPaiYbCZMVnvx6vOLHit1R3ohUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hymTFXze2X8HLRPIv3onwPl6xEG6Ov0ZwgUjTP3CBA=;
 b=MDTLLWLFG70tJ6CjvqJFhFCnuRoXZj26/rfmLg59pFhDDjU1z6Xt8NoZvSR/1H5ybN8oGOtoKmIb5k1wCK8Cmvj0EW6y23q/KXX+xHJrSzjQT0iQTEWyo645UDR56RlPIfJcx2oOE2szlBvMgqi1Exdo0ByuCmF4nVDP2w+7hoE=
Received: from AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:46::22)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 17:06:54 +0000
Received: from AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7175:23f3:d229:bb12]) by AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7175:23f3:d229:bb12%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 17:06:54 +0000
From: Thomas Schaefer <Thomas.Schaefer@kontron.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>,
 "fparent@baylibre.com" <fparent@baylibre.com>
Subject: Using uart1 on mediatek mt8195 derived board
Thread-Topic: Using uart1 on mediatek mt8195 derived board
Thread-Index: Adop93yhTv2TROYySNOqmHa1StEQRA==
Date: Fri, 8 Dec 2023 17:06:54 +0000
Message-ID: <AM0PR10MB2082C282ACACF92E42484727F78AA@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB2082:EE_|PR3PR10MB3820:EE_
x-ms-office365-filtering-correlation-id: 2ad8cb10-0039-401d-22c5-08dbf810144b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIPJhKzGDn/tIrVWG5smlrAXjPtHyBteVQn2ScUCmqsX9229MmHWQ7Uyp2ajbMExFyEGrNmSR3sO3BOlEQ8HAEWbXf49V2sCBW6Mryq0RCBRtHcSI2pmEtZCvyY33Dr05Vj+Yf2lGrXTcAlptWHMmKOgfFrx1dcTE/IiJLKgyZhbON5VmKpaJ2jMCGGFgn31Iu8jRTXtzO62z+iBY/hjVAVhfSw15DDcq9dbAfI99OzfWsR9Toh9htyGzhS4Dbf4VHfDeiYO2Qo/6Wy+YGJbHm/kCYLEKPmObhwU80pT6mz32r0DORuL5Z8auuC4KYSzoYcF8f/wC6x1ohzycGmvssbgdwm88kwhftYo7/7696ECfSW9hetC9cq87aw+/CUIrDMauMYRyNEyyfkkxNksFO+6YQ9+VgnszLVU9Ul8VZsNMU2dWorMteGqn8JAAk/myctGITNs+sNF9PNO1UuZ7HaNVaxrDqiyuADZfDJFFFC+IGsIy2uUT4jceuksb84xBRhtZqPCq8rSCuBJVvbQg4WDpfMjxXGko53OfsTIu4Dz6Qt15WnLneWpk2P1W6SKmq/wvkLhDsFxA8IsWnfBu4Z0R5CGLnTlmJNjappnRUM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(83380400001)(33656002)(55016003)(15974865002)(66574015)(71200400001)(26005)(966005)(66946007)(66446008)(66476007)(66556008)(76116006)(64756008)(54906003)(6916009)(316002)(6506007)(7696005)(9686003)(38100700002)(478600001)(4326008)(8936002)(8676002)(52536014)(5660300002)(122000001)(2906002)(66899024)(38070700009)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GyGcHXbLK2hmwCQ9tMcEqXBhgd4p2wmfnEJWzh0e6ybZ8tH4vlOl9tymsH?=
 =?iso-8859-1?Q?zV6eoVDHEXXeyyUh3l4N0J+vNPgOkH7hiIgvzQvMDzl6Hqz/GDp3XVT7GU?=
 =?iso-8859-1?Q?zOv1JKjg0SiI5jQUKPewqn5JuYoDWRZkNPVLyA6v8g0j6G6KaC3VvoZUnc?=
 =?iso-8859-1?Q?EuZExgGyGksQzxGkkGC/uHyFfFWaBqLD9mRLo82V0zqxWoGfvmgAHTtGjC?=
 =?iso-8859-1?Q?bEAbOodKRUyYs++LA0bJhWtvozrwtYBptPMoDAUDjD/tsS4qCS+awsFeDE?=
 =?iso-8859-1?Q?8ciq3xOKBVxoBaTcIF9f2wMuWzJh6uLE7ETOO3TmqgIgfCg4T/vpv39I68?=
 =?iso-8859-1?Q?khybL7tYvT9sJYY5821iHs4+3dOdQuszwQoZUtvfXXOFhageEw/DdXXgD6?=
 =?iso-8859-1?Q?CuhoiEKQKZ1zdCixB27NJOqG0zmfsHnSpDNHEqSiigx0ZzQVV0gfrqazM2?=
 =?iso-8859-1?Q?K0YXRGsGSW+aDSt/89OfqfprjtyfedJgI1+NErLNnUv5dWZpTz7Qcm27m1?=
 =?iso-8859-1?Q?d6TiEPrX74yMgR+OJhpovivuDW7/eSNZGpi8r1epxZYdR/h/pjmTZ9ONhG?=
 =?iso-8859-1?Q?F89oJhv6hWy3yzewI4gHqDBbl601s3TIkKEy7Eo4b9bTDhkcqDjMm0muN8?=
 =?iso-8859-1?Q?fimpUEUMhNY18AP5c+RPJP0vJ+ESYDJ3zqkG0sxNYQmRxVVxFK8D0EZlIL?=
 =?iso-8859-1?Q?a7WpvQTCse8HiYOpQxdFMXRmWLeaAcMZoLiVAl3t8E1w5neAwT9hASWqN7?=
 =?iso-8859-1?Q?MQbfLSWbB/YFjgoZ5XpPiqchuAZvDLCJJ26jcjhy5AN6M5paacfn5H6syh?=
 =?iso-8859-1?Q?Miae/ClZV1P0Irhi4oaaQmyq+4IL8BISWnlQES3y0UBFdRjyu/8PYVhID2?=
 =?iso-8859-1?Q?J+bVUtwxgJJRtt1Mv7ySP0AAladuvI91uUU1e6mtdi3fXSU8ndaOHmFzqB?=
 =?iso-8859-1?Q?PZAqJB8I3htb2QtD4KCBy8qu7Wreq4cT9MRJwzwdpOas65GA71TxhoNni8?=
 =?iso-8859-1?Q?jPoqv2QZezXfUJ28BpfgQ13OzMaGnCoy93TcYboY3mz6OR3iPMgfzc2Ypo?=
 =?iso-8859-1?Q?fP4iEvhWrjVUITTIPUEUMOyO8PvrgYkDWNGO7/NJlHY6p3yWsPyHWM+RHK?=
 =?iso-8859-1?Q?CMGe5FxLZVWmIqb20JiQ2ZfCuUXeSsm976YB5gGBrffY5/9/b4VbpoGbia?=
 =?iso-8859-1?Q?+Nx+gNIrFYG7QW9yi0J6XPVmRmvBXROl3qZu3a8zLAlYyU55CS9FXWYd+0?=
 =?iso-8859-1?Q?beAEW66cWzbY70FY+6QWczBNOzxUHObxleXIi6C/sxPx9bmo3JbZFTNx3A?=
 =?iso-8859-1?Q?TzfCBGlbdl1+qBNfvShZdUDyPRqD5IEJ30yuaPdPw9aECJyBN1WknUADsr?=
 =?iso-8859-1?Q?Vef7Tcf6kN1jsxQmpl4QT59lrIQBgVW/NMmV+dZgO3isDfX/fqG7gwQArj?=
 =?iso-8859-1?Q?S8vGdd4BX5ii/MYnW/KN9ub9Ubc3C8ZIaxyytsW2MwkgFTz1ce1v6PaZqQ?=
 =?iso-8859-1?Q?XqqebTi0Om6tOK00X/NXlTkBiYkMddr7Xmff8DYSknCldQiMNH5rnL2Qc+?=
 =?iso-8859-1?Q?yozQojhJf1foYpobgD2aqeOr4bGDVXY9DoRIveJLxKypT3y0qTkUSaoE0R?=
 =?iso-8859-1?Q?VWKtoiLGyjZUGxrw0supQAx/MQCEMaeK//4+gcohj+VhAUJjArFOdqpw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad8cb10-0039-401d-22c5-08dbf810144b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 17:06:54.6508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0fQdo/oMMKPrvO9t3fbkqmWTqTGk4S91QVXXM/HdDoDkUnTTy6GeHRhxjP+RPKsIqnpwHjSqTBgmC6mIzyzUYXvt+qlTEwcJrT7yIO+6x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
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

Hi Macpaul, Fabien,

I'm referring to patch series https://patchwork.ozlabs.org/project/uboot/pa=
tch/20230804110448.24589-1-macpaul.lin@mediatek.com/ where support for the =
mediatek mt8195 SOC is introduced into u-boot. We are developing a board ba=
sed on the mt8195 as well but we want to use UART1 instead of UART0 for deb=
ug output messages.

Our board is booting and we see boot messages on a debug pin header connect=
ed to UART0 when using the settings from the demo board, but when trying to=
 switch to UART1, no more messages appear on the console. What we have trie=
d is the following:

- Adaptation of the dts and dtsi files with uart1 settings taken from linux=
 device tree:

diff --git a/arch/arm/dts/mt8195.dtsi b/arch/arm/dts/mt8195.dtsi
index a7e4db5aa7..53eb437fad 100644
--- a/arch/arm/dts/mt8195.dtsi
+++ b/arch/arm/dts/mt8195.dtsi
@@ -245,6 +245,17 @@
                        status =3D "disabled";
                };

+               uart1: serial@11001200 {
+                       compatible =3D "mediatek,mt8195-uart",
+                                    "mediatek,hsuart";
+                       reg =3D <0 0x11001200 0 0x1000>;
+                       interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+                       clock-frequency =3D <26000000>;
+                       clocks =3D <&clk26m>, <&clk26m>;
+                       clock-names =3D "baud", "bus";
+                       status =3D "disabled";
+               };
+
                pericfg_ao: syscon@11003000 {
                        compatible =3D "mediatek,mt8195-pericfg_ao", "sysco=
n";
                        reg =3D <0 0x11003000 0 0x1000>;

diff --git a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts b/arch/arm/dts/mt819=
5-kontron-sbc-i1200.dts
index c6ea7e8f3d..4700a6d303 100644
--- a/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
+++ b/arch/arm/dts/mt8195-kontron-sbc-i1200.dts
@@ -58,7 +58,7 @@
        };

        chosen {
-               stdout-path =3D &uart0;
+               stdout-path =3D &uart1;
        };

        reg_1p8v: regulator-1p8v {
@@ -121,7 +121,7 @@
        status =3D "okay";
 };

-&uart0 {
+&uart1 {
        status =3D "okay";
 };

We also tried to change the DEBUG_UART settings in the defconfig to match w=
ith UART1, but without success.

Are there any special means to make UART1 interface run?

Best regards,
Thomas

Thomas Sch=E4fer
SW Design Engineer

T:
+49 681 95916 203


thomas.schaefer@kontron.com
www.kontron.com



           =20
Kontron Europe GmbH
Heinrich-Barth-Stra=DFe 1-1a | 66115 Saarbr=FCcken | Germany

              =20

Die gesetzlichen Pflichtangaben finden Sie hier
Please find our mandatory legal statement here
Unsere Datenschutzerkl=E4rung finden Sie hier
Please find our mandatory privacy statement here


