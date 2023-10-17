Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887CECDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 01:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E10786EE0;
	Wed, 18 Oct 2023 03:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cloudbasesolutions.onmicrosoft.com header.i=@cloudbasesolutions.onmicrosoft.com header.b="m+GSy5tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 529E886F1C; Tue, 17 Oct 2023 19:32:31 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0961B86F16
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=cloudbasesolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avladu@cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihj36LlVCcgOiZyd9hoA5SwsKSBjfvJB1QrtW9d1BdC2G7vCspA61SrvYLYWd3XGahviZib0W/UTMqpK5Sa3B/52unTK1NXTw+7g8FPO/ROrF7HSInpaom3u7Gun1NNxGmyQK4oLO3d4G4B7eNm0/TLvHhyKfa5ueCVoJzFQLCiYMmKF1ar1qt9JzmPql1j71bsdtsvwk+1AfH1vkUFMr/8TSTMcjFtOp00aC5WRLc3PWa+sRuERauXbrIKlwtbjHZKtcAEpb7sOZoJ9axqLmXFa0qyoWfdBdedyP4B1JHk3Oy+DhLy9hu5ipkgXtGUe1MXyq5qJfnfwp7NeD2waKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgF1FlXa+7MKo5xSbX1tu6v4iHr3jpJ1tfB2DBJF54g=;
 b=JCw+B22CrWlW8RPTnOMwW2jZ2jX03ON3C8z/fFA2Kck5Yd7sx4km9/CTNeD3Ki+pFafDWKubjeZwK4qcKxs2QmytXp28QBhg2byayBfXV6C/lFa1yz1wrqxe0yWPwNZbP5G9vhlBYsiPKJkbdFRTzSjDJ0zd9vq4UwIGrXJz8U2WFDuzimaJo7HphsKNi6+84ga91H/lPgYXJfZmlHVIN5HikglGib7kzZ0zxgEX9rQxDgjXWyt9pinKuSugwZvU0iMgAbM+u967IriFzH5iF2E0RFoL4r1/2XtUPYxw4SUK9f9BrPIhnB8gsDdFmNxw1Tsqqm38A8LEKu7YqIybMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.onmicrosoft.com;
 s=selector2-cloudbasesolutions-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgF1FlXa+7MKo5xSbX1tu6v4iHr3jpJ1tfB2DBJF54g=;
 b=m+GSy5tB31YM4BmAgpfjAlkBN3W3eHdDmA9Kz/1UFvvAs4RT2OcKzjLsS9qPqnNVCJARleWPsJ211WPPaV+sS2pmXwJDXh8clRYYWy4I4czSdfqS6MJUF+cXrB0PosqGUDkXUgiDY8J4ZGLihCy+hUmVLvHkZIkKH5v4PtWNWb0=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by AS8PR09MB6065.eurprd09.prod.outlook.com (2603:10a6:20b:569::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 17:32:26 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::1079:aada:8bb4:612d]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::1079:aada:8bb4:612d%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 17:32:26 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: PXE booting Flatcar OS on NXP ARMv8 SoCs with Chassis generation 3.2
 LX2160A: fsl-mc: DPL not deployed, DPAA2 ethernet not work
Thread-Topic: PXE booting Flatcar OS on NXP ARMv8 SoCs with Chassis generation
 3.2 LX2160A: fsl-mc: DPL not deployed, DPAA2 ethernet not work
Thread-Index: AdoBH3zUqvFI5B6KQ0G2kFS3o9hpZQ==
Date: Tue, 17 Oct 2023 17:32:26 +0000
Message-ID: <PR3PR09MB54112953C97E210CDC8E0EF6B0D6A@PR3PR09MB5411.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|AS8PR09MB6065:EE_
x-ms-office365-filtering-correlation-id: b3e09b48-94b9-440b-960c-08dbcf3707ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1i5s7h3aCkB/XGU7dAI6gtTBNDmd32El1Yojpe7CjgH69YwStHBO17mqKzOqkklWnPqR20mcbqi7HbMUPuWRjW+Et/mmmPpNoJNWoeNxD91cso1UF86Ym1XkM38BEixZoOFoJYRbr8xMetjHOWpQQmOCts6BmQQZSO1p18ceDObH8sKzlby2Rx9+sck+ba/XaMPfjvojxDtdbvdy8mNF7vU1N4GxTjhXY/dbX1VRAYBIDG4BjB/yKtCJZunaOAJqLvx649wUI0K2VHpY4zWFOSJh+7ojl+sT8rhQ3ixOLs8g5DxYBM44S8QgyMAPya0LlckXDpv6Ti2T+qvRWif1sLV+GPIh2SzHiXIB3VEDllBkzqbKErVKnydKWWLQpNWFTpLYDEASnbhvN3UCoZhJBfGEXt1W4/5nVQVmkc35Dt9IxOu7B+dIJUzcpYb9VoZU9gkFHbcCgflHVCuYTkHtcRBwCUCg42fWnEBAZ+uxSOzrlEVAXGvQL5XKWLQXYttuPj/vFtNmK94bhY4OtEBIhqvQQXlIX3A6DxVvYXln8iJ+yGnpnl6Y/0g4q59T9CNctwWQsBXXNPuGNR/U2Wa3Q4vX2zvHj1E8yk+QDstRTY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR09MB5411.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(396003)(346002)(366004)(136003)(39830400003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8676002)(8936002)(316002)(66946007)(6506007)(478600001)(71200400001)(38100700002)(6916009)(64756008)(66446008)(66476007)(9686003)(76116006)(26005)(66556008)(4744005)(2906002)(33656002)(52536014)(86362001)(38070700005)(122000001)(41300700001)(7696005)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iFPkkum29NH7Tn4f3VR0n6UDKhCwrz8tv1BqRgX1iH4tiY1aG4Q4slMEyoFB?=
 =?us-ascii?Q?W1pIe4JZCv2DF8Nqll7wq6OPlwNopIDd4fn9vzCTWmGsb/0DIYYAeLTHPzEU?=
 =?us-ascii?Q?CpMwr8Qnu9a4M1UBaHA+zi0wNdcjDIoF895pAi6WkwWg6U2HESi28Y5PUKiS?=
 =?us-ascii?Q?QA/NACSpXZi+wFjVTf9tJyMDWzwHZypGdl1AfM0ku41yvXbQCQupmPfXTRTU?=
 =?us-ascii?Q?2usc8SoVfeuxKdUG26IVL3CLN/lmGRU5fiGUh01hAcwUcAFhAfekzjW8aEi4?=
 =?us-ascii?Q?ji4oZLxxWFH0XgAXEzcoskjxnRvS+3T5jRf8HTF8wjHyWAmZB6tOo01OiqIu?=
 =?us-ascii?Q?GGTBmY/9ylGaI+Ph8XDQu2bHyESGiuGLF5+L+zSJNvUfNwjX13oQEJGqmtg0?=
 =?us-ascii?Q?etsZXzC/tVzCz2W/uxMugC4IsKqc3lMV46vUA0SFEo/cM7XaU1TCu0uNka5Z?=
 =?us-ascii?Q?B38/0jaAsTw7Bej0qMwbYUesqSsSMetDOHdZuTZQsHb24K1/dnNxGgxMLITD?=
 =?us-ascii?Q?xO+cw6EG+tuOKeCiE/lq6k5R2DCud9DsGve2x7UFJGh2EPkdD3r2IBOcdeyU?=
 =?us-ascii?Q?ldY+0bJpqgefodCuCL9uDN8qxIFl1Rz4tfKlmGwOEAY6AUKfbJaTRLilyfp4?=
 =?us-ascii?Q?D3D+BfnJjMjVe34yMfY4XorYTcECh0fPun6AB9AXAgBeacBaGA0n3/pL32LH?=
 =?us-ascii?Q?DsXx0JuiaUDs288Gadz0/RRQQIaZQQeO5eF33oRqY/TrCBjfNEKrgSFIP7lS?=
 =?us-ascii?Q?MjzmvtFqbHENBhcDvynYBw0D76pmHVvqsOMQNagw+vOlMuEj6KSv165Ftt3q?=
 =?us-ascii?Q?egzp0PpkTpcoR9T3SSBzMO8xruvCZIopIK9wamTJ4nIi49qJ4jqbtniwGbyk?=
 =?us-ascii?Q?ViE18qMJU6OIU/+g5wq1dgyjQmz3s1nw+ZjOW0XDlFtlZ2wtU4Gc8ccoXdPa?=
 =?us-ascii?Q?WepokM0BYydq+WyHZ7x4im8ZMm9c9HvNySi0GKspjM58DnJNBustfEGkwNc0?=
 =?us-ascii?Q?Z8xdecVFUPDxynMmXG8lWa2E/wtKET0T25sUSnS6ltCvCjuQMtaNk/AWIV7X?=
 =?us-ascii?Q?Xwf4Las0eHKUNFSF+2WLncb/Ki5ZYKpZJUqJCcDDfyVoaqOPbrE77ZwKNGS5?=
 =?us-ascii?Q?PUiBrBwQLk6XYfDqQtuqc9HFvdhHun+rZbWWsU2cVXX2eo/ZB0I8IH05tSOi?=
 =?us-ascii?Q?L1YJ8BtQJbUxV8FPr9PPC1P2UBgM6iJCy2eQx3U3KCGqwLdhiuHfMqaqi0UX?=
 =?us-ascii?Q?poFVSVgJjln//SKYGqspqIgNpeW/ZR/dFLgHxMBH2X3hleLIZlWVM/h5wGuo?=
 =?us-ascii?Q?IhSy/gUHbLsIxYUvkSD9ory9QT4n524SL0lRN4/f12RZTK/beyAH+zSfkQCi?=
 =?us-ascii?Q?rzsiF9UnBKmpBwA/MZkawPwnE6A5/NUiSN9R05047SN11UsxmFPozJnAvdUC?=
 =?us-ascii?Q?RKQB2eHen+YLVkhAhPEIw/nYtz41MosNZm/BsaQOr0ycXfoo0b5H2Pa75Bc2?=
 =?us-ascii?Q?/WcubfPT8/EKBPKFit+gCO53rD1CHWKgi9ncKdPmVnkOLefrHBlPDIjR9F/m?=
 =?us-ascii?Q?OE8knhjZdNezW63e6uz84ljNqnqoCbsD5dSrq47fIFjYCOIPlRaxQZnpKf9I?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cloudbasesolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR09MB5411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e09b48-94b9-440b-960c-08dbcf3707ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 17:32:26.7199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ/SbIahh+frEixIFE3ZqqNUWsIu4ptdOnqm+GpXh0Qq7hQyPSad08IYqNxngYALa6SqNdQ0zB6Q1TPvF3zbcPOMD3yh/KsxCpEr7mG31uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6065
X-Mailman-Approved-At: Wed, 18 Oct 2023 03:24:48 +0200
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

Hello,

While trying to PXE boot Flatcar OS on NXP ARMv8 SoCs with Chassis generati=
on 3.2 LX2160A (https://github.com/u-boot/u-boot/blob/master/arch/arm/cpu/a=
rmv8/fsl-layerscape/doc/README.lsch3_2),
there is an issue with the DPAA2, error logs seen:

>> Moving Image from 0x81100000 to 0x81200000, end=3D84740000
>> ## Flattened Device Tree blob at 81000000
>>   Booting using the fdt blob at 0x81000000
>>   Loading Device Tree to 000000009fff2000, end 000000009fffffb6 ... OK
>> Releasing fan controller full speed gpio
>> fsl-mc: DPL not deployed, DPAA2 ethernet not work

This issue " fsl-mc: DPL not deployed, DPAA2 ethernet not work " -- is it r=
elated to the Flatcar kernel not having the drivers for DPAA2 or is the dev=
ice tree blob or maybe initrd is too large?
With the same DTB, PXE booting Ubuntu 20.04 works well.

On important note here, the Flatcar initrd and kernel are ~300MB, respectiv=
ely ~50MB for the kernel. Can it be an issue with the initrd size?

Thank you,
Adrian
