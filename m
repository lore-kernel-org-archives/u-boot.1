Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC2CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320A9836AC;
	Fri, 29 Aug 2025 16:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Hy+E9pVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC9883448; Fri, 29 Aug 2025 04:45:49 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECB483443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcV2Pzp8mKqk5vDmoTERG0xTgIpNJsYIp/dPUN5kU4lVeFe2ftZD4/s2CRbc7H6lUJcOAlVK77oU2UKEGPMW/bAdgqDv/3iqfkXAZskFfiXFI/k/Qx7wyVpYBAnAEBDiak9KDnVVIrmyv/zTrOhWpuC2TtsI27pZmf3qqh7InG4/aFILq8psrAVKr8u0Ty+RbCNZA51PzK2gVrj+0JkvWFZa5cI29Cj/ITtnP49xPH60ST5fmIMuU0wR+Wfl141u1eOhZY0jU6qpg4O5jjz5exY05YlrPCYFegatVrrJO+a9NC0qjcT9WJuAyWS1UaKB2LTt7xQJAeu/xtN7mjBl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFl56AXOBY9g13rXSySeSGUBIV8s9ZHeaqa/YUAkt5c=;
 b=A6T9XJDhkuWP3ya96i2WTDjDPDcsZ1DLaBMpepQ7mzTi4i6YLtO6hF2aEVC84x5wSH+/uUkCJFzQDsy+yrS7zGJXt3euZl8E5FZ5E9SuYj2hlrxQHrSf5BPttTaEmSMbw8nosR4SHEcG03eEqHRA6AIKCZuqVVinAQgqbHIqOiAxaknHOlPt9U1+ZV5GprsZnSnXob6/cxMfvztexvgYTLoAx4U/DDwh2wyBlfJrH+cvtNr6AqBbO4v/fZEiijg2y8M71ay4KB8IWUFalC56gJGsvTxWkx8U/EHn++Om0h2abAGesTN40ASIpK3WgrgLoFglG3W2q1y74me9ksjmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFl56AXOBY9g13rXSySeSGUBIV8s9ZHeaqa/YUAkt5c=;
 b=Hy+E9pVhYWTmyHRxrODj+bqXwZR7UOZlgZSvD+qRWCQ65LXjinNFyjFb1aL8uHbFQRYJNMzt9LuHQemrtdpQ0NaAHVkRzU6O5uiMznKS0iKLvLVaxQirgYXWPRFBhRyraiNmJUkOl2nv+jy49WpzXXTaGs3g6/fnBoqE0kFO/lWie4r5OG8UhPcf2ug76g2/8s9oxLDih0ayhB/vDQRpTgQFehvUsyZmfLfGGnZFk3hArXTp8mTcEWT0ps0WKn1If8FCcVX7C+bZVDa4z/0DDYQhrRKhnqXcPrOiPFzw6wvs3FrlVP9b9X27WK55pCCQF731rQqUFczk2GIQ+jtquA==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA1PR03MB6609.namprd03.prod.outlook.com (2603:10b6:806:1c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Fri, 29 Aug
 2025 02:45:39 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 02:45:39 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Nikunj Kela <nikunj.kela@sima.ai>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Topic: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Index: AQHcGG7kEnkw2dzFtUSRKLOzDr8ZjrR47PzQ
Date: Fri, 29 Aug 2025 02:45:39 +0000
Message-ID: <SA3PR03MB7187E64199FE9C74B131D52EB43AA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250828225532.1147284-1-nikunj.kela@sima.ai>
In-Reply-To: <20250828225532.1147284-1-nikunj.kela@sima.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SA1PR03MB6609:EE_
x-ms-office365-filtering-correlation-id: ca386254-950c-4aa7-0205-08dde6a623c9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f1E2vQJsGTKE1vv9Dy05R/P3sB510l3eUpDYOsw8XNECxALISeqH8SQHqgg5?=
 =?us-ascii?Q?oqYASkGA6ksia/3QRldjh+Obp8m+Cj51TO/w1hTDvcUjIf+CFgJz3SLqYykN?=
 =?us-ascii?Q?DvSl9v2brueOetoswL3jIqjmL8T7OsJ3jzQ1y04JUwOVl1qzcB/GjyqE+QVk?=
 =?us-ascii?Q?3QBW/49IDJDIa7eSrLCrjWBM+q9OQgMV7P0GDo1VhRSgAR3oUfkKdj+sUis/?=
 =?us-ascii?Q?AnYD6nWzag/bmy1VByU8p4WdWL5AnJjnJfsKqrtNr5GZDlUKHijn7FJm2zdb?=
 =?us-ascii?Q?wAbDMjoWZ8yrjoAKgyvAcO+Y2nmA6t9b9aT3XYFD5A4KwCwWUTeiA4pPEXAd?=
 =?us-ascii?Q?F+cVq/hsB3Fugeg1YV4R+fV+fi1ExaDegUxlILT9Ne6GgYm7s17meGlDAkN2?=
 =?us-ascii?Q?OmlslQU0sBWj5/Ql2vg39mTniPXrGzwiZIbewSFhna1Vn/tbnTSYEN+UrVcz?=
 =?us-ascii?Q?8C+l+tpDw44WN0XCNdQHiNP2UHImOkbZrxTA3EpsbkaLvvbt7J2gwZ4apgO+?=
 =?us-ascii?Q?SRUwSYQk5l10r7SQzj5TReBFDz3oAlWbvB53qyx0WiFafnbIyBdggYzkE1/A?=
 =?us-ascii?Q?+P8cjl07rYfzPkxlPQ+/ue9SnhY0NYNfjnYiNxvEDDCNGiV/wXWW6cO/JD7O?=
 =?us-ascii?Q?Exl5bzOXs+ftvcGJ6eFrZAH4WbrZ6hserWE/f/rHb3r79zGwZNTGAwfw/syl?=
 =?us-ascii?Q?LiQHh0uZNJzp6lTxON78h345RSDn6fMulb8BkHFvc05aaZL3B0cN6I/SGy2p?=
 =?us-ascii?Q?PGgbJq56FsjTRgldXt4PKc4jX/0iVnLSHRajKQlLACKn6M7k6HIP+XAJ4oLP?=
 =?us-ascii?Q?X5oqfQKGofN7Fhki0A5AR+8vp98p3Rk4TNX7vnNdf0UIMC3DWluFwFixko3x?=
 =?us-ascii?Q?F5QeiOLvEKV6hkFWXMILFgL7KcA8C4bsVc96yotsBfiQ6k6+UbmMCC05DxWt?=
 =?us-ascii?Q?s3eroMjNbosG0k4QcmPIoD8KHLm1FNii3N/VMTlgnsIhZXuDymUm6K6qr1+u?=
 =?us-ascii?Q?cItOuxfy5Q0ER/PBzcOI+O4+wc/45ZroisbH3dU0uBP5S4Y4M2fcfv2K3VQY?=
 =?us-ascii?Q?zDHin3hmwsjJHd4IMUTrcp+eWkQKCjJbQQOjJJSbQv/uJR3nny9ezKT9QJbT?=
 =?us-ascii?Q?ya51sMWbUfSoOPAjvox8ILKyQ8se5spuk7AhcT7pQJ+KHJp/rvfmT8wMYtdb?=
 =?us-ascii?Q?8jMgbdLMg7mZ5Pw2p1BO+69KZL1OMzqn8YLA6n4HQJBoZlP7oH7etDXC5Yl6?=
 =?us-ascii?Q?Xuzk75QzCXvGXTZTFwhUGZWf/UvRCnl5r6Y1E1X5EqxHBHY3Li9Ufq2Xpv5e?=
 =?us-ascii?Q?p6uh/Jye207OKuUXdHqIDaB88B0LwL/H6CI6SmMH3DhL1+xhLQlAeEHEzhzC?=
 =?us-ascii?Q?6cCf2qfeiWy/KhTzHcVLOZmg0QbCYCs2NOsb064dtZV1W3RlrLNtINoZb8lQ?=
 =?us-ascii?Q?llVJAUkmvlmrRc/kyMmfF82Zcy/u3qQE2iEhU0mnHn0Z29q8r92sjQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g4u9ZIRZ/xONyhMj0TvvR3jh/oB5cvRsccsbG6ZwgCZvn6iZGzCoVpJbHZfF?=
 =?us-ascii?Q?Etc9OU3Zpe2iskIYiv49SfN406Enbqqzj55dodZq12xqdhcri2OEJ6O03P9d?=
 =?us-ascii?Q?8+tj1YAfHbK39bHdSfvMYARMwBJ9LHcIOivKKRXIVNBYnp0Rw4z8zLZd8wC/?=
 =?us-ascii?Q?GcMCGyzIcOnBHYNWPDv1Yliqudq1hmJffXD94+yPzsEJpaqjRZ16qWB9JtcZ?=
 =?us-ascii?Q?z3PWLgvJRoN7Yii3EkymGLbYdEQncmt6Jy/zgPMgHg2C8CKv0rJOnf2CFjZ/?=
 =?us-ascii?Q?FcoDbC9ieQDqnazJXbQQGFibGhtNZf1YOJAX0UxFJxE/Pm8Ab5whPb9+x7ew?=
 =?us-ascii?Q?MNSsG0wp23Xc0tLXDKBRP2Wejt78iPX6zDPmlVRAV14e9CesmX/I2H6jfAom?=
 =?us-ascii?Q?3msz985ynP0FIIUc03flevCPgVfIbaHjL/CYx++zIS/jWqimtKA43F7SxEjE?=
 =?us-ascii?Q?B6UjE7PaIJrQx6hMxhz8TsT9uoQA+4vKO3RlEUVncUTy0ibteMYVUI8eYhYO?=
 =?us-ascii?Q?JpWPJjoeuuGr4uyMu5IaylaDq3teNy2F/VRZAkYd5pvTaKjg/SrtFLfXyVON?=
 =?us-ascii?Q?/WmqPNgFwUpzTuwlY3J7MX7+rmkZIc0e5EGnngCoEkAjvU7oGyUqfyOv4AXK?=
 =?us-ascii?Q?WVi5y8Li0P/hESycZgwqF0Wwedp8RVUS2I/w7HEGKEh57ZJVCMuOtT4uN9ci?=
 =?us-ascii?Q?/jTYsKvfCFap30SyKACcTupgxOq9/8hWGRvn8XfwTGkVC0gt+LZJdR0zmPbv?=
 =?us-ascii?Q?gFpwEokDe/qvynWCcg3kf+T+SIGA8EVnT0fNHec9TW7GgLkyNooRMbyrmf66?=
 =?us-ascii?Q?SGoDYa4JMwoDgX1VKVq6/5mJ4D7tXuqAV9YVJGf9KcKeZCZrRDT7ETVEjBrh?=
 =?us-ascii?Q?VreapmAFUEo/Z8PYizb3NR/dh7iy2neIVu6tn8LBNkRjeaR3ooxBHHyiMbQL?=
 =?us-ascii?Q?RWRffCzN8nDbazw68yDFFlRk+BOPfOJ6gsuEJ+V3cMuMvim6ckzmYuDp3dLz?=
 =?us-ascii?Q?XOity37Si6VM9LTZaGvRSm3w+0gmbbwJlOlvJ5OspQ/DFIPhI9/Inqfgi6eg?=
 =?us-ascii?Q?46YXTbjJvBHZ/i3lk7OPqDSDPLw2uozzfuKLpDjGZJsXeBloyYIoVFsMat0b?=
 =?us-ascii?Q?eTa2vUJF5GH3Ix8GbzuL5ehl0vSN6Hm1FoVzEp3TOqkGJlpa02azIPHHur6v?=
 =?us-ascii?Q?XXa5tjG9reH8ylaNdbIWNxOkNjk53Ic1b+3fbGYCFd+8wHHJg/Gx8a+ETmMt?=
 =?us-ascii?Q?Kk5dfDRZ/1sfRjkpImG7M6fxCSTfmqS2BwAcu9Ro+Exh3dVLjjYLpD+0DUxR?=
 =?us-ascii?Q?tuUGSiFDJAeAMBEG7q8S+6hhxYcmRSbyjzIPv0UKQhpJw4Lj2dmcAw/V9+xF?=
 =?us-ascii?Q?QAuDZTOFi/nQAa13XtGMbPJ6bEuP+pY/GsZPkEM3gITs1IYoFfAG+L1qdKFE?=
 =?us-ascii?Q?aA0mEE3txubYvOPs0plAPdOzIIwVEEqAz8HKqiWuh7TY4+7Gk7HJkdKrX0ZM?=
 =?us-ascii?Q?B5Ot96BKjUFgHWeNZ6IYt91vGP4eH7ZskNxBzSZenAMNmbv5sT3M2ezpXr+4?=
 =?us-ascii?Q?gAeZG7itKCnLwvLK7o1/S1uSxZZ6rTbi0vEoc6Byt/pJJrdmxsDTKe7aBdeT?=
 =?us-ascii?Q?+U1AlmRb1Tpa52v8LH32MT+y3x9Az6EtLXqwl3nfeTyk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca386254-950c-4aa7-0205-08dde6a623c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 02:45:39.5405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gr96elNw3qt8iZbpFEIkhNhjNHovDye584AoOgzOmZfW3IEZwhpEb/ofnVFh54JrHXjU2giBP+DA+BIqtiWpDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6609
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

> +
> +	val |=3D	mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
>  		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
>=20

Replace the tab to space after |=3D
