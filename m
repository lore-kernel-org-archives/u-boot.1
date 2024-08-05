Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA8FC3DA7F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 00:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D7B885E7;
	Tue,  6 Aug 2024 02:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="kM5RbnJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A106788361; Mon,  5 Aug 2024 22:45:32 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E836C8831F
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=claudio.spinelli@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuAzvOv3JrUxvGv4o3NeYeseaxAGNvnoBsw8RNUI0bxRnrQMtmwfzWYbiyVSy1UaGQKyO4s1xP/nWGj5ovfehx39P2AUnYeZP+cRhzsx/NhtcFeTegDSSrm3/p08LFr2YDfAQiB7Zr/p75pPL5TX6oHAueqYxMxObW3kMKtFbcnXBetPksy6Nkc6bLgfwTAo2OT2hyVW2Bpf80uRSIo7MdL1yGKGXl3YmB6i6908lXZ58++ov0j51D1jy+xItzAO90g7spqqbZeMj7N/UFZLOJw3sB0UTHboWi92izz6kxgUoq7GvmIIX2Q7x4K2163IcFG/nvVwO77tBVqLlxEMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIUEsdEPAw+eWCquKmrORNxS4f1VPcy1Z5nZMEdtIEU=;
 b=JK1PRrXhTQxvbDtBE01bPo9VjMcYDOg8gDWaYFluzARI8Bd2EJ2VkCoW4RrSPW05pPNvTgkXSC7JyHtGn9e/8763HZ8PkyO9b1uuYu0xpyWU+auapW779bGgD7/wjrDETPWqZxpM5x4Vf9VsZcc6efMCawYVB9QZdyG2JiBm7gCdrCY7g5y8wV7KipyXYLVvbU8OYqt+VcutctK8+/JO1jpxi7RtnadH6tfMclFnfMmQ+npuOUlERqhS5lFLSTwBIUsURQ27HcydvrUtQRz8TjwecamGSfPGNk7xUb9ExFShQ6ZxyvBM0gmR30HZtJKXQsrnV70CfYCXLLGWNgFW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIUEsdEPAw+eWCquKmrORNxS4f1VPcy1Z5nZMEdtIEU=;
 b=kM5RbnJhA6HxMtq16bvP93DPlAP+0m4+tZWVKUrVmnod9Oo1rrRNw8+lDnlur/lErqdl2RHdygTCJRciJWOxbG0gYHCF9doyfco+J8rAdqx8y4DXoUqwyJZwIurAbRhxxXfUQvX5XUJW7lRKu8uZL8sJnoyMG6v4aGEJ3d2JRuaNsppS5ansQW8VffJIP1P+LVyhWm/urpUvc3sjZQ2vRTYQUaTCu6pdrbNt3D4QqoFx/hevCJGpD2G8SyrNvCJ9ZCXSB4FUojLYbZGdsosxqjv1tk7vx5I7vFnY7fRZR9ypVu559Na6IjpKjCsidczZ9P/w2cFm9cqK+VaMQlGn/w==
Received: from PH0PR08MB8212.namprd08.prod.outlook.com (2603:10b6:510:165::19)
 by PH0PR08MB6680.namprd08.prod.outlook.com (2603:10b6:510:33::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 20:45:25 +0000
Received: from PH0PR08MB8212.namprd08.prod.outlook.com
 ([fe80::caf1:803e:6b5:81e2]) by PH0PR08MB8212.namprd08.prod.outlook.com
 ([fe80::caf1:803e:6b5:81e2%4]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 20:45:25 +0000
From: "Claudio Spinelli (Nokia)" <claudio.spinelli@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: uboot eth_initialize 
Thread-Topic: uboot eth_initialize 
Thread-Index: AdrneBYikHWFf++kRzi/ytyusuytUA==
Date: Mon, 5 Aug 2024 20:45:25 +0000
Message-ID: <PH0PR08MB821205163A3B13CAD0F7053688BE2@PH0PR08MB8212.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB8212:EE_|PH0PR08MB6680:EE_
x-ms-office365-filtering-correlation-id: f36a5ed2-4be9-4548-d6ed-08dcb58f885a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MfCJfdlAQBI0vDNIiEvbn3ztjczxmYf0MrIw8z/ktbc/5CMaN7W82Ltau566?=
 =?us-ascii?Q?cuE+f4Lfo2dq5bqOCq8dlreSS5AlsrCET9N7iynVbTN6AbpstFO7YmtBYbRC?=
 =?us-ascii?Q?0rpvM6YauJtttsemJRR7sn1YYCitq+C3ahaH1Lri9nHQft89kcgFKz2QtXzv?=
 =?us-ascii?Q?Sjg/3suQT9Jvxr0UhOIuPFkBgSUQRV58/aAsYjSFzyEt6OpR7JprPBGDFHEP?=
 =?us-ascii?Q?3WFJ0t0TzeEldnqiZzQTX8Huni2O0rfBfUXp0mz7QgW48jA/tSdQkhafXI/W?=
 =?us-ascii?Q?OA12N0W+d3VNYw07unMRr4pCJCXzjkvmniecjNltyeZyL3iLVzWeSE2XAUBu?=
 =?us-ascii?Q?xJqwvPmWVidCCep7a8MxlhzFm9PAq0dVRODSvrSl1SNUKcVUle1Vd9wqwRTG?=
 =?us-ascii?Q?ypBN1Dep3kWZb8wjrL5Ja6Nfw9o+0jJM7nMpv5vOUMMOt89UZRm3Y5RlM7FT?=
 =?us-ascii?Q?xzoOgh00HP8yfdLvBv0UE5JnZviQnT46NUX+0AZuUmVMrMvRgHhNraUibQOf?=
 =?us-ascii?Q?tDzsLVxcIuyZGgxKWzpJ+jllWfp6TI6wVfjh0hdiKiw5rHaZExutFc5NDf5i?=
 =?us-ascii?Q?C7ZVRCj3RiGilfKnj2bEpya5mGfEJc1WGQ/IHklNdAeTHmoaa80MWoaRpeqQ?=
 =?us-ascii?Q?dGYCN7nMB0rXD63B0yHB93dWUCSmLLN7z8Cw0MulicTd9fKDX27D8mZa4MgH?=
 =?us-ascii?Q?kc9aIEnwQ5sX/OVS/NE5XiQCLOeFCw3ti35hl5LYIT4kJto4Y+hFhxPrTVnD?=
 =?us-ascii?Q?4dEqpXp9oSFsM54IXfrlQxPt376qlGD3Fmc0nUcEopEt0k1T7WPP79F08GL0?=
 =?us-ascii?Q?NckthSSB4fjDqxslK8nwimLRJgs8DmYNzLaLfldli+TayntHEWj4WcWvFYSF?=
 =?us-ascii?Q?BeV2AYMVwvsd45IrX3wXSp10KBprMHzKSeeFegZOjEd22Nfw9Rl7JlTt5jUX?=
 =?us-ascii?Q?/J3lUZaUcxMNqi2HdsDT3jAnYwLy32q2DL8JydnwBqlilZ95ZHfgE4ldzQdt?=
 =?us-ascii?Q?JXdhk/bSgEjo9R5RaNWpQ0N8FNMCaazlHWcN8Q8SIIcDOY43Q0W535ZRE0k1?=
 =?us-ascii?Q?0qP6KfJEbF4X/jTb1kwZWDUQrzYUIDWlV4cTveC9L17UOEh0RbdNNnjCV3p4?=
 =?us-ascii?Q?BWLVFfRup/elOtVgN2q8L7OFqE29Xya16IH54SJlsOGrIh0pp1q2pD4tVTkK?=
 =?us-ascii?Q?oX9pjqF+yTuyC7fkRm2h+FV2ULtT0wzvB6g4EkOJ1GH/ml6VAsjC88JlNKib?=
 =?us-ascii?Q?q+BseSPoQNeoYFr6+VSIwiy5pGQ7MOtgyNvPE1949A+ZuaMs836UKOpEBlCw?=
 =?us-ascii?Q?sCMgs5kkOeZLc14f1drB/T201dioDt2in6Y3Xqft3Xhe23fuf+hDgAK7YoJx?=
 =?us-ascii?Q?mQsMY1GC4cDiJibggFNQb4PENUQScHEFkGTXUi8eP1KM/kWTAg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR08MB8212.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7PGzoWEPdvvFgDI77CD0vB7NIuj91KxqhtY55DpfPSsmSBPtmJz1ySRdg0dV?=
 =?us-ascii?Q?izYRhJvSnX7KzMXeVuazqn+aYbUai3UcOgCuTlF875WSwOQYr5GqxoessKBe?=
 =?us-ascii?Q?bfKmPvXSBYkp5L7JLuzI6p21eoF8wMZiCEjYIFHmxED/A7tWKYnBxZJsCwsB?=
 =?us-ascii?Q?Sw+UtpqnQiGivr4mn4pUalW0Rt/Ka32Xzrnb/I2akFL/Zox19xkZVBuvlBHY?=
 =?us-ascii?Q?Rd8ukM1fGoGKt2u43cGWOCrz7Sd6yh9QS4bZ/Hoy1A5kkynRwRG23j4Eyr1l?=
 =?us-ascii?Q?IQx0/y8SbOWu2gkORUsvC/lvQ1nDv89oKIiGou3uqdVgSZ6qJRro0bbVI8BD?=
 =?us-ascii?Q?VsUxOGldu7IvqMVS4DDd8mPP6B9AYpNWFlw9pQ+02OKlnQoUyyzRj02kIzRx?=
 =?us-ascii?Q?eA8iE2Hw45GhxpBmOKsyJC0gIujd6yBFQXJdjchGXAbzSq4/kpRgX2+4Cj2C?=
 =?us-ascii?Q?MGWzb8H4WpCmVztcfuLLRG7H5hHuu9fHGl9urjWEAdPGqfXtIcM0YU3Xih/5?=
 =?us-ascii?Q?u6uO+QnpiJudeU8AiGvpK97KdvLB4gsib5ld/1vbzwgMYFy3hetoeRZ+OkBD?=
 =?us-ascii?Q?BNqs87o0wkZvk5jQN4E94nF5QJktKa5eSlKx8PYoO7F1H0Iw1wnhIsf1mZGY?=
 =?us-ascii?Q?2k0veHnnEplgzK2twE6zdvxO/+8BZNpYRi0p+oRufre8svvaIf2fiXUcDDYR?=
 =?us-ascii?Q?sy2zdc5JTQFWIJagoSLWRfo7oGX2GULYMahSHZAkGj1/6s3ZE/KYeZVPtP39?=
 =?us-ascii?Q?d60+Z6EuqDIcZN4yaS4tYSja3lgWQ4eX7S4A7Yd2PH1CwZ2yTDfz1KL2yDvI?=
 =?us-ascii?Q?qSs+fAUz/vQLtc8McVM3DUf08x/v7tGj+v2Bc0j5JrSXTjA0DEVdXltRKGBW?=
 =?us-ascii?Q?5yNLEIdUmZq3CBF92MAlkshE3wbiyXxu8ZAO2mBIKX8YVQawQZjwezdsDGL/?=
 =?us-ascii?Q?JdzjR1D1YK7v1w1zSJ8oJ+FdG5bz2d3+NPr0UcfhjlABYnuvwUcbOj1iVebV?=
 =?us-ascii?Q?RoKmQo4exDCcwl7SJIzF2iUttafu9uRRMGc54CMtooXqYse8pShl+yAtURsD?=
 =?us-ascii?Q?qgqadJx61fVlLst92IgDyprqXHiV8y2cUt/hQxO084/z9mqrk2qJVagvm434?=
 =?us-ascii?Q?n2I/3y+NlV60pNyYioibNuKUMWedk3koJ0BCwp/RIpjVcWvvOIcf2VInNI/A?=
 =?us-ascii?Q?YzfQZqzsTtY131mD116S28AjrWHiWPdIv8zic2hbiKzUCNAiquFfp3DHBmF2?=
 =?us-ascii?Q?pLJ0XHsV2X+yhZuxKiZYvTHXMBxkEqMiEhx1uDItuRnn+MX9gsd1ZBHIwezE?=
 =?us-ascii?Q?Ca5QcS1fibhXXG47oTQO7BejN46MIxwqEMX2g/5E+2z+09EUypc1WVpaJBYO?=
 =?us-ascii?Q?5+R3aS/qwMzT6rDKJSzRgX8GCcJz53VTXC0dOtNTjHzThTj+Ooz1RsvyL6Si?=
 =?us-ascii?Q?lC1FlHu0/g5GOJRTmAmY0AiSzxtaL7siZ3PAeqAyK8SmulytHnUxVZQfHKzT?=
 =?us-ascii?Q?oLOF/4GPMZwIj/3t08mzpzVLmFFUBSO8oatFZ4O8acYuI3D0WIMkWiiE4e3G?=
 =?us-ascii?Q?uFb/vYEoVrBLnF4m6H8ZBZa+1I94egcr7KgEvj/l?=
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB8212.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a5ed2-4be9-4548-d6ed-08dcb58f885a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:45:25.2048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alWjFrRDbA+Ku9ELm4MjupYhkC68GlFv+Oumpyk8JjtvhtID+m9R2W5BOA5f5c8QU++n17qn9ErCtWQ4jC5ovyerZEI6TY1Mq8Qrvba1+4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6680
X-Mailman-Approved-At: Tue, 06 Aug 2024 02:02:38 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I am having a problem in uboot with eth_initialize() function on my target.=
 My target is based on Intel Arria10. All the uboot source code, that I hav=
e seen, seem to assume that there is a PHY device attached  to the cpu emac=
0.  On my target I do not have a PHY attached to the emac0, but there is a =
direct connection to a Marvell 88E6321 at port 5 which is RGMII. So I have =
RGMII to RGMII from Marvell switch to cpu arria10 emac0 .



When u-boot code in common/board_r.c  calls :

static int initr_net(void)

{

        puts("Net:   ");

        eth_initialize();



I get : Could not get PHY for ethernet@ff800000: addr -1

and then "No Ethernet found"



I am trying to figure out what changes I need to make to current uboot to m=
ake it work. How do I tell you uboot that there is an ethernet switch conne=
cted and not a phy . Any hints would be appreciated.

Does you have any uboot source code that use such implementation?

Thanks
Claudio
