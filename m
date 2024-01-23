Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016F4C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82598753C;
	Tue, 23 Jan 2024 15:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=digitalgateamg.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=digitalgateamg.com header.i=@digitalgateamg.com header.b="bMUPaYjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571B187D13; Tue, 23 Jan 2024 13:25:22 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C09018793F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 13:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=digitalgateamg.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=adnanelhammoudi@digitalgateamg.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg1GavSBV4mY46f9JpoSuoc2vYV/W5hU7rrYq8BFKfjVe+iMtxbRiVKPjxy3DBNXmwdX9PW0r3pAxtb+W1//ICoKoaZXdhJyYDGgBUx5tpp4Xgq6xpDevZVtxwooNSXYwIUAme1D8fRTSlK0EEIqP5See7o5JHYqGnQ32Mw7GbBK4JMOIGYzCYDixA4gP+IH08eYK+itWvMTaOsRT0hWch9JB/vWVliajglo1N74+IWe6K+JHcStk7dJk4y0iuy0142XE2T1GKxAmjf7/I+OzlWryQnIT9HXM2kvMP3GxwOPw/lNgOm8R/FZNwn+Zvn3OnR6wUExEF+LAf6ZZCoUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpZEtZ+Bk8LZfMy/XpjRRKtRMUdmHF0zXGrr0KkHVeE=;
 b=E6KUbVN7ySK6iXUWvMfte3VswGPe3owXmzPK2MA8+eWfwZTYgMKZNK/bMfPX4WN7fgIqY6w1lRAdamJkDdrlseiDcv4ryzdvPjz1tF0L1nYPTOc9oDqrC+T86WiUd2ty85GW5nm1iunCuVsG486zl1gGYqTMwUwTADyZj5yR6+pZ8WLmPqcAmqIHBmlfHQZEU6B2FUEco0dXKCanOHKtoaHPxkGMKlxsVUfkN19bs/1eRQ4hEIFCc4PSxNuRmmZy0R5rUpV3AQB1nZ0twrmrotMdLQbeVtCBqA3MbCIOm44d5rAQyna5njHLsrm5jT6JCRdaV1bgS8Y/jYZhXdRR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digitalgateamg.com; dmarc=pass action=none
 header.from=digitalgateamg.com; dkim=pass header.d=digitalgateamg.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digitalgateamg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpZEtZ+Bk8LZfMy/XpjRRKtRMUdmHF0zXGrr0KkHVeE=;
 b=bMUPaYjEQgrFf//kpP4VkKQ9JwMpZPHnUnZhP1m+iW/JleSI0kFEfXgz/qCbDEOT177oQnGDLvt7mVAs4TKDDtMBiSvEEcnDRbHU8t1w+X5sh96eqs5rqv7EMbHQrNUd41Yx9ScXaahTzNEUIoIORQrMrkePoxjVpDRadHIqIdkn93xwAMNrZl1Du6hSoyzNztn+yVq7tddcDU0iH0FRSEzOdR1x8OPvS9n1OF3Cx/9sWT/BaQ0cKDrOOOUzxzgYUEwqvr6GpGOPuScCEyeG1FSEjLq3pD0GRRNyVhYZMqsOqjz0hd+tT50J+DtFXvjUMrVFMeHbMXXWMkWa0TROQQ==
Received: from VI1PR06MB4686.eurprd06.prod.outlook.com (2603:10a6:803:8d::28)
 by AS5PR06MB8701.eurprd06.prod.outlook.com (2603:10a6:20b:673::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 12:25:17 +0000
Received: from VI1PR06MB4686.eurprd06.prod.outlook.com
 ([fe80::8a7c:8737:9b8a:91a6]) by VI1PR06MB4686.eurprd06.prod.outlook.com
 ([fe80::8a7c:8737:9b8a:91a6%6]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:25:17 +0000
From: Adnan El Hammoudi <adnanelhammoudi@digitalgateamg.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: test/py framework hangs on some tests with tbot integration
Thread-Topic: test/py framework hangs on some tests with tbot integration
Thread-Index: AdpN9x1I08YIRjJvSeS2kh7DPd0igA==
Date: Tue, 23 Jan 2024 12:25:17 +0000
Message-ID: <VI1PR06MB4686CC71AB659B64BE11B9B2C0742@VI1PR06MB4686.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digitalgateamg.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR06MB4686:EE_|AS5PR06MB8701:EE_
x-ms-office365-filtering-correlation-id: ae74d2d1-17f9-478a-1a6b-08dc1c0e5b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNYc0zZ3JqOcXgYUcpF9CFkQ3al9ALblO/7igfV9SZrPxl9hs6vfl0hhJKxBsW13O0pXaLgQ5VcPlq8GbmWJC51U6tlVt2OYJljQGPeVssNbQA8i5SUPd2rOKDvTAUWnifeBHakuZ9I0Mv0TnG4zgfz6KRy8WnJnAPAUixxluoeE55iM4ZyL+LkQ+fwaMVEd9+fJaYA+i1V8gNou99r+AQ0UXh34Z7Je+TGD6r7yGKU1IAehfnRVWZilsX2UqOdC4Darx6JYLyutIVnN/Fq5d4grV/B2xvFb7N303xUHY1JgGuFez7gUDUD2eOx83j3T+JtIIyuYH3ylAh5vOvgsnEnOYRBqk70ltz6Icrj29GiJQzCAyR8YASCmUBtoJJ/VOCH0Luf6she3mpFETbsZ1hJEzdGVqLdNt2WxLgPqPB/M0b8jXzggCJ53hD8bxGBrOUJNH5kbcuWI4/X+HNaZTvXnkgewSkjfR5+7357GYcspBv46nZFUo66fXYrDoK3s57kJ6SDg6/aqsGyI3rf2Rp3AYYLonll9W38ivbV5YeE+gR+wqd+md1jyXLTw305OrBlXpL3/IiVchOHCkUAamyWHF0vUJDe4LC09HXOkAAFlG6JY9qn9qneI7kDngdnj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR06MB4686.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(6916009)(316002)(66556008)(66476007)(66446008)(66946007)(64756008)(8676002)(76116006)(8936002)(55016003)(122000001)(38100700002)(4744005)(7696005)(71200400001)(52536014)(5660300002)(9686003)(6506007)(478600001)(26005)(41300700001)(33656002)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PETEiTVga5zY9bUroLN+kJ/5jOoTNZZHWOiMNSlZAxQ5sdfD5u/VJlvjkiIf?=
 =?us-ascii?Q?F7FgSkkx0V8DUiaUtXZV6htPVojq1v+PFShxHX6YV2hBGOp1x77vm4B/lMoR?=
 =?us-ascii?Q?l4JMQbFBbQ/b9JfRBB/zsanhI6fXfLzeFpn1rueiODDQGZ2hDnCGt3kDKubw?=
 =?us-ascii?Q?5oFO4HxIC+EAC/+f/f8GtpjcYYjloNgGhvidPHSh7Ajf4etmFNI7KGOgE/iI?=
 =?us-ascii?Q?+87mWf0GagRZdngLhYR8smGINITuly3ByLJ9vUyZa+A7Imj26Y4NWeplVbWM?=
 =?us-ascii?Q?tFeEnrJCJBehtJOxAgnMFEt47pMB1/XuDsBc0bM1bzYtDLiXYYxUrgkwe/XG?=
 =?us-ascii?Q?gZZW+7Zd2hq3ymxcj/xnU3duTows1Ok3K9dBXuO312d+LzDMRn2Kg4lrpSP3?=
 =?us-ascii?Q?5IguziAkk/Z/ZCsNB7VMWzFENrspMXn/O8i84oPrmlO5UFTepkaSEuPO9oUg?=
 =?us-ascii?Q?PoAvkxm/q0sckd7lKHlMwaCvBribmB3/ZfuK1QYaHQpEUO/WUkNNz+w+rhz/?=
 =?us-ascii?Q?tyaHqO5m++uO4PeX+v8cN8gX8cso+oDtkJCT0/88Qnu34LbGJxn/2boncTpt?=
 =?us-ascii?Q?iYiUwMlS01mwqVSeu5Ey+F9ImRD1513clCTLcanaOen3oKdPVmzH1I7HdE+1?=
 =?us-ascii?Q?2ejxUt8dsm423/LtZxAOwIOGL9OhM6sn5Rk5KCPJGN1MnkiADxwlzbPvJqHg?=
 =?us-ascii?Q?MgmJ2olSYRbVxbN1kGkUr7awGURWkmIomVRNFAJvYxdu+C7CXy5AHUDpijVQ?=
 =?us-ascii?Q?Os5OPfA2J7T8qFWFNhkLx2y+pjlEGuSwg/t1fQhHad6TllrLo6uQk61h5I7P?=
 =?us-ascii?Q?d8UpVy7CteRKDxmWyoU08C60hr/uz+b5v9Wj6+s8jDM8ZQIUZ8pWNY5+HEvV?=
 =?us-ascii?Q?8kvnHI1xTv0EmvoKE3Tufs7v/rQ/DjalJkNQC2MT8QfBL03MZGNtE5KULjLF?=
 =?us-ascii?Q?jx7TgHi7dRzV5eWHy/KXQG7xw9pUK6P3BgsR0CmSlRsfxgaA3LkaRA2Ua//n?=
 =?us-ascii?Q?uPK0cpXUt8gRUB5243gyWFURJEkfqnpA8UW42nud87fPrbTiYucC/ilpoirG?=
 =?us-ascii?Q?Xy3m/ONuqNWOvtZjRAwQDqYr3ksCAqzPYCOCocgDnc8ObBKq6zvZ4BeU+cnp?=
 =?us-ascii?Q?1bS9Yas7pIYQcMs40t37tfx97Dm2gSN6UmZq3obBwEkVFcW2W0gxdiaoDlJn?=
 =?us-ascii?Q?wfDuC3VhybYpU+CiqKiWXj75x8v16A2i6YG1gDbyQ0wO7u3407QYP5muC0Ah?=
 =?us-ascii?Q?f6q1047Hehlq47+jIkw1LHKHmsd0wrVmui9oZlzQ77T1dGwQTlhLHGptFRp9?=
 =?us-ascii?Q?RQRa8GAEnjSjzavYyhSuZ8FiQo++YGm9NrfHPWokL3HNBKC8MX1xDKQ4BqhO?=
 =?us-ascii?Q?a8pHwLs4BfLAdb1fqRw1Kl4l42NczAZu/m6GmOWX1wQgag26y1TDtI8ECBE7?=
 =?us-ascii?Q?NBrkLzDaxyekZVA/uRZBdx3L0nSmGvww8vhtgnu1d6Fq27By2KGy5XD87eIg?=
 =?us-ascii?Q?hu2gr2TNutrJNqabpYXAbwg4I7dX9NL/de8h5y+8zZQwyNsEZz0yMih+YgM0?=
 =?us-ascii?Q?SvtdkheO6lRkRHw144XCSgTOC4Gu4Ra71XNn6M/2u4WNcagGTqQKP9fE8VAC?=
 =?us-ascii?Q?KA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: digitalgateamg.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4686.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae74d2d1-17f9-478a-1a6b-08dc1c0e5b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 12:25:17.0706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f5ea231-ebaf-443c-b641-1d5d3d2bb7ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHNjCkOg/5Y8SYy193KwWce3vkkMpqam95QccbrAqX/VSF4WzXh63bajk8J1ZrC8cp89yIH/rbCsDkVmQ9tMgsNEaG6oqP8PS/M+s76R9jQtXxzaZTalcIJxjCzBhRFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8701
X-Mailman-Approved-At: Tue, 23 Jan 2024 15:10:44 +0100
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

Hi!

I am integrating tbot with uboot test/py framework, and some tests hangs th=
e testing, after I investigated what does this hanging, I found that if the=
 fixture of the test
occur and configured in menuconfig it won't pass.
I am not sure what I am doing wrong here.

can someone guide me please to run it properly?

br,
Adnan El Hammoudi

