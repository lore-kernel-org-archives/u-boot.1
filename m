Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B57CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D5286E65;
	Thu, 12 Oct 2023 14:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.b="oKKNDG5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E2386DEE; Thu, 12 Oct 2023 11:13:13 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A65386E13
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 11:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Chris.Paterson2@renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SANgUUKJBc/8Yvi9PEyi9liGWtUlZGhw6lS3hiMqyXjTdsKrLtqoOePrUml+jEgaDSAOyG8m5IeMseJxzCoj115jyfjTXXJd0wCVUGd3YB9BEtYPsodoo4Ewj2lY5AO8Wc0DleXF6Go2ZRApH/VNTjuvlWtMfgmyQFXJFmQbR2AKUizz6h063Fz5P4+VAbonv1VLZjZ4ZUhNzMqZXNgOLu9dSgpT9xHn9Pp+Rr9JrQ40kwIJW+l6MYa1QJWpMWbNziA1Bi5VAh5tWBBaoaVmOxZVdtgZVSjcqY32J2DW5tADkCeEXDBoqC3aA+EfveYekDi35QpAVa/J13w0oC5BgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZligjr6elcd3s6mkyVp3xkKuyGWzxSxQtauZWWrMmI=;
 b=UwArUVQ0K4xHuB4cj0LXEwjBMP+J2EAUiAiqxi64Nxegu0Gb1jVne7/JiRR/Fii/J0QRaQfrdCyRc1tdP2TMYH/IqyS8WP+LektXEqRgALOdEjsY6bJDRLKgK+Sb0bNs2g8wDe4JOxEMdceqwKAhz+Je8TJPUKXBv0nbQe2RqBj7l9Bon0DNhXF48Qzqlh1x33ILQnnjKvHSiN+WUDl2NmgLPKpDi6oYpnBHWFlgX4xfzc9t2aKAAPX0U7L+SG7xr7re3aIWkzINyourehqMy1gEwYCkHsxeA02+c2KZchCUSdJDRVNm5NR02+zUjNEeIqzQn9bdMHRhFMxbS3JyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZligjr6elcd3s6mkyVp3xkKuyGWzxSxQtauZWWrMmI=;
 b=oKKNDG5oo6Od/C4vmraFPIxh4nUYTrZaRGK1C0rZqxnCpviB4/aPeOAdo85kkXZT+hP1O61+s06vnMM8EScLtujCZKFPxpY9CoB6UV1+FOy39w0VuDzFlxqgnR4FWzFCaX4Ukkn5+RVIg4jvlkmeWAr51z+3mqevs/JSXsfAmjc=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OSZPR01MB7698.jpnprd01.prod.outlook.com (2603:1096:604:1b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 09:12:48 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6784:e7b8:de4e:bd44]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6784:e7b8:de4e:bd44%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 09:12:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
CC: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH v2 11/19] serial: sh: Fix error handling
Thread-Topic: [PATCH v2 11/19] serial: sh: Fix error handling
Thread-Index: AQHZ+tCSLE3SdLONLk+HX8vLjpdNv7BF4hZQ
Date: Thu, 12 Oct 2023 09:12:48 +0000
Message-ID: <TY2PR01MB3788C2CBD5903F28E729D1EBB7D3A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OSZPR01MB7698:EE_
x-ms-office365-filtering-correlation-id: c7f3c8ea-546a-4717-805c-08dbcb036785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sMT4CzpRBhTYbvEO0l7v9xtVItmca7q1CgnJZVkkqoY1nDY4FoJyrsjrnMMKIREGNFdsHYMTtmsMV0e25L9vKeUNgUnH62++qspedMvMbyrfIDa5Il4xCK7CP95Ch7bm0FBaGdFOMjGD+vlitOhIbPSWLELzYVkR6KNj3+X7/OQWNlzVwm/t6U1f0nm9Zog1q0CZes2CnKNR/Q814vCEqlL6C4thXx3oKCnhXNd72FdHNLSDKrI6WE2ONP0wV9E9XhAOhu7+E6idj2KcMrzBLS9ucO1cc7wrHEeOxyyfPDsTLVGiYEz1UekZgM57cypcU36Ug9VKHP/KXYmdRYijvKQyPxRGDYmyANmdT0hg9qB44E6nSJPIP2B9AsmCN9O+PYlxNSR16fWo3QGuBVgg0W91EPqNwSm9/x6colVru/QPYc09bWCZDZpxdLa/uJ9s2V2SSLBlniWhYLijnF7mxeOhl0yikD+XDgdEia7acjtpry1fFpmjb+JWLBYPkl4oT/2z1WBsrthSHXEFm59T/OSEQrNQKadEG5UZ+tg+JHaphP3GD+NdDg+4SJC1eLfrpiGl+zTB6VMBkQUj7N1JFRDACk6l6cG+85UrIzRWGKJcToh1p08iKytVsZeTlSC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3788.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33656002)(86362001)(110136005)(76116006)(66476007)(66946007)(66556008)(64756008)(66446008)(6636002)(38100700002)(38070700005)(41300700001)(122000001)(4326008)(8936002)(478600001)(8676002)(52536014)(5660300002)(71200400001)(7696005)(6506007)(316002)(55236004)(9686003)(107886003)(2906002)(26005)(83380400001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ASxdhPNjTFfFMOoMvo6Ugtlm7DjL02ggSm2+DIXdse4PP/rsvz02O8NC?=
 =?Windows-1252?Q?ArQySvjdSKJPOU6CyFMcvVI+UDqoEslLKbyPAIxGJrpexzAs8HnEEbYN?=
 =?Windows-1252?Q?Tv8UZX4RRUuBV2Fxk9nUyTlTIllQgp27X/CZFfNIoOFHEFhYNsk/tyYy?=
 =?Windows-1252?Q?pGUBq9MdJqGYb3qkI/L45dCsl0Muz4lTDqzxCQ0Y4EY5V0T43Ik92QsZ?=
 =?Windows-1252?Q?OiaEyVphAXiO/48304DJ2w9SC4YNLnNkx7uOwi6enhhFf5jwVcE3cWLV?=
 =?Windows-1252?Q?COV0/fCTqdZfyaE/H9tD3AV8suzNYVkfB7SN0aJF8U5SvApT1xCgGxwE?=
 =?Windows-1252?Q?2EQuK3yV6jjntcoxRmhnT7oHWgBgYQjeLS9g3WMEp8hAiUtLjvVHQLsf?=
 =?Windows-1252?Q?5Ep2R9fUMRauVd4Y3zqC6DBAcdk7AfUgBs9ZaVRkTpF9Pok5/toPiJ4n?=
 =?Windows-1252?Q?zdc89njMfzK+ZIHwjAhM1WDPpkE3XXeXyKrZ6IAT3eUtMOva7PYgtSpg?=
 =?Windows-1252?Q?hNj6ZSNjAs3/iB+NHf0LnH3NVRrO0PuFSq2uEENf9e50SPJO12KKyVQb?=
 =?Windows-1252?Q?doS0aifCVSpFTWDoSiBKoTiSkAJV8mBf3sNOa7NEbT1jKenoEmkRydCt?=
 =?Windows-1252?Q?uASL/tMJq5hro4ZdRqDQHw52wg/BMB7TSGLjF2JPC7kyWRm7s4/S+siB?=
 =?Windows-1252?Q?/OC7NkK4V4pUK7GcfBQOqv4nheLH36heVwa9gmqpzGJ+T5RxTmdpoxtv?=
 =?Windows-1252?Q?+brdktN2eP+0Rq7ifCgs4OFh7Fm/o5jX7TvEZ1yBZo+Zix8jDKpSi4yN?=
 =?Windows-1252?Q?b02paM5LdC7Gydd5EInyuKDRROaDh9FU9z7eO6vW3lXVDq6wu4aK8geC?=
 =?Windows-1252?Q?j2rykw5UV3WS3/XY3WvT6oGDmj7kDOkBoMT17ZESSmgxBS4XK6Obs78g?=
 =?Windows-1252?Q?zCDK4xcR01KlphSf5FxRIG1W9bUqZu0Ljwh/p2hN1ojnMzd0bVNSJO8D?=
 =?Windows-1252?Q?jyVOiQE4N+0qFB/ufHmbvBw8edTefPVvxe3Ht68bZxa2T9XzrLWLXTh3?=
 =?Windows-1252?Q?QhGVFamt93B9RaRuKYWjK8YgnDbpG+CKMdaJBnAC5d6wTJTQ3ICEf4Zg?=
 =?Windows-1252?Q?mpYnKpqrSfomCIrQ5gIt2KeXk7OfTAQxlwOpJPn11V/F4AfMy4HgytIm?=
 =?Windows-1252?Q?4FrN4hwr1bCsphQQ7dbCmYaz1c1Pysra4mNXZzQiodLhnXAoU16D/OIA?=
 =?Windows-1252?Q?QNc/o8hLzZK8y9RRB6dud1FDSaZ2YuomnaQvKQ0hQHH+aZ9Weg8e5/sk?=
 =?Windows-1252?Q?JaIDjUvNg/UpGSe3p8+EmXUkbWqkAB3DHhilAgf18KKV0uWVVcr/TsN2?=
 =?Windows-1252?Q?o1RC2eHLAeoP1/jcbfd/xx3sZoKY4uOmdUanwUsD1jYJeWn8fLwIKCU1?=
 =?Windows-1252?Q?RUSlYoIF6qvREQxVYFwUc1GyJu9yv+Sjs0D3PYpEQlzMgdxv7wiy2S+C?=
 =?Windows-1252?Q?JKkOjc3P3XXPXxu+OvbPMW9B9//RDh8UXihIwBS5ikFWzgf39b7wflTw?=
 =?Windows-1252?Q?3dKR2gBmT/LJuLNZCZiLuZmCxcg7WnMP3sisvlAlDPObAGdwT9qBD6wE?=
 =?Windows-1252?Q?XnZOUtUHHm31si1ehHoHFr3G9niqsQeMTyHXoLZQ7M7iprY34TaZn72m?=
 =?Windows-1252?Q?IGP+DNr9VfS1M/fgszup2rqBIUT5irWdaNX1etyx3Dl2cp4S/77M/g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f3c8ea-546a-4717-805c-08dbcb036785
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 09:12:48.5091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Cce+0vSmXrQU2jTbrToLBX3hICPDXceRT9nMyK+iYIi4SF/SQehV9bMASDT53ayRKp09/egVwjtEHLrnt4lEGt3jvAglkusgS0TnfJxZXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7698
X-Mailman-Approved-At: Thu, 12 Oct 2023 14:26:23 +0200
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

> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Paul Barker
> Sent: Monday, October 9, 2023 5:47 PM
>=20
> The current SCIF error handling is broken for the RZ/G2L. After a break
> condition has been triggered, the current code is unable to clear the
> error and serial port output never resumes.
>=20
> The RZ/G2L datasheet says that most error conditions are cleared by
> resetting the relevant error bits in the FSR & LSR registers to zero.
> To clear framing errors, the invalid data also needs to be read out of
> the receive FIFO.
>=20
> After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3
> and even SH7751 SoCs, it's clear that this is the way to clear errors
> for all of these SoCs.
>=20
> While we're here, annotate the handle_error() function with a couple of
> comments as the reads and writes themselves don't immediately make it
> clear what we're doing.
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

I've verified that the problem exists on the RZ/G2M hihope-rzg2m board, and=
 that this patch fixes it.

Tested-by: Chris Paterson <chris.paterson2@renesas.com>

Kind regards, Chris
