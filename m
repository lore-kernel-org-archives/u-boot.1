Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6DDC83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470F2832DD;
	Wed, 16 Jul 2025 09:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qnmMYRLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A07583192; Wed, 16 Jul 2025 09:15:59 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564BA82E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QafuRm/9HNKaGnJjdupnE9ecvioAo9cw3WgjddfnQl0XQgaK6F1erKwG8xyxb+Fgr5WbCC261lJmxSLf+Em6d0Jr8zzJfD3U1qqMhLmD+WC6vGtgLRWGu6iveMSSZPH2A8krVi0hswKlK6nhlZ5q+fWdLbgp9bPkq4L3qk3RsFeG9d3HvtAxXrdvWk2fsOwN8MVXK8aKrg3bofA8WVFaV07CjgeeFHR38wyzS7h1xCrjvv5u5u1sMygZ90+GfryJbnxYtRuEb1I+MpKDN22qkr1o00M4FtNxeycLu3MJOQUW/aM9+uVooFOOGbVy/mARh6WuRySNfkWM16xLrmn2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkQNYAuh2fKtQxSs+rTjP3rnM4PocgQEKKq9EXoAckg=;
 b=hUT6ds/FUz4k/QsepSOWEQzqke14O4JQL4zA0bIu8uHBH/urO1mAjiXqgG2HkVHLttHR1pTgxh0Dp7Lk5H4SsepWgbk+7NF+oaC7N/iGFfW9+STCY+6YKSfhLDPmyDwldnBeqpcR8UG4LZvpH2rSsuBbDhFzKI4pPCK5q66hAuHZD/YOurgQaHchxyprV2V+DJkz3YGdLBlqDPjFTs66zYCLDafcVrxVlwFziArpntW4DwkaZrVDeytU8Sb7TAmoi1HcFdXKKC4SSo4FqW/Z/EhphIWnACy7WGbwFLSnQpQg1ChUwjYvOxYEMZ9h0/zlUlxN4FQZ5KsfvZFPGu2W8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkQNYAuh2fKtQxSs+rTjP3rnM4PocgQEKKq9EXoAckg=;
 b=qnmMYRLJsJaltObH36M0mCQWmFY9tww3GRlNJZ3g3jpUkr00S5V/BBdovxyR+i1ZUT16QgZwp8H1J0/CKgzEtLcLIysmBbF9D/KkmjLjogvqAv2w3zkNvhfVqyetfVNWoYrDLvDFcamXz6ZoU6F7UMIOi1mbS8AwP5ybIUi/DdNwD/Wt6pWkVwUf6v7elLSpwUKUqDhMapl9BxsmjHYJm7AxMg22p4q+mzmjmJYUpQ9+ffuzouL+Nukm63J1KWVKCV+SpbgnquTDewtRjs70P6t092orfW20/azSto8A/fSwk81vRXNb3NWKVB1YSe3ulrG7vVBQCNIam6FoojBs+A==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB5790.namprd03.prod.outlook.com (2603:10b6:a03:2dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:15:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:15:52 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHb9iBuqOT6woZ46kWSi1O2duDIObQ0VTxQ
Date: Wed, 16 Jul 2025 07:15:52 +0000
Message-ID: <PH7PR03MB6942EB5CAAFBECD0B6C8BBABF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-Mentions: hs@denx.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SJ0PR03MB5790:EE_
x-ms-office365-filtering-correlation-id: f5d28964-143f-408f-69e9-08ddc4389939
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?PVXC63Vv+Cn84lnr1XHyvZ1GmGr3NYQvbn4OmE77Xef5dZ1AjvszoPZ0m5gm?=
 =?us-ascii?Q?nqFIA6OTfdNJ5642e02E81mz23Da+VkKAr9ODlwyZ8zsg0xIHASc3gYMVpNq?=
 =?us-ascii?Q?iqklZhDnaTHCBBoECoo5zmAWabLlo67I2TLIMNw4qyoiINH/66+M5l31YIRJ?=
 =?us-ascii?Q?Z5Z9dqQzjXGtAYXXcIKsRQt1ZxS0LcxeZo3D7EueFBb5yGyZG9HqNropZNcW?=
 =?us-ascii?Q?SK7xnppFG8h54WGA1fsWsNaVw4959QHWPjV7tGGx+f46BsHrQzwMTZ9NOaAu?=
 =?us-ascii?Q?cDBUQsN+vtHkHbl7qJaSSk4aHOSnAybyhT578SwFlRY4y8xAjg3P5Cclk9Z5?=
 =?us-ascii?Q?9y7qjfUx3Xbx+8jQk9qfqfw0QxjeORUNp/B1Oj4PgLAGXJrrn2+8UJP0CNHJ?=
 =?us-ascii?Q?LPXpkho8SXSxNIxP1w/3sb21w97051TbtfAZYYIZQ+g2V0JtqlgG7bQIaEL2?=
 =?us-ascii?Q?1Yqbp7nLoFoYEaMIw7my6uaegF/2+QPztWHA5ypCza9tLF7HlqdxOztb2LUQ?=
 =?us-ascii?Q?RQVYzYpYigY3n99iprP9K1dyc2tODMWNlYf1hNquKGe4hrf4CZroKuD9YvGr?=
 =?us-ascii?Q?Peet8H5m2AAzKfVHNI9qZ/xlYUFEcEJl4ZWNeWyyWRHkUzpbFCorZJ9RrU8U?=
 =?us-ascii?Q?wLfVr+FOQvVf9P4gb/F6Cdap9F79i5UdQRcKUIo6qwidsyJoLRqj20+wlxp5?=
 =?us-ascii?Q?aHoqji3rizHMHuE9XQN8EttI4NN0o/ps35Xw+2a/dlyfFqv1dVFOOKurIEYO?=
 =?us-ascii?Q?iedJBXChNxFqZQjNTGi2Mt5PGqaUmeOJmbbZd+ntO1UUG8y7B1OuWv9ZwpyG?=
 =?us-ascii?Q?cpjoD3C8YlShMGmz3IX6PmmcB96dS/7rtBnZEr0G0nzTglkkxBavXpUuUnjk?=
 =?us-ascii?Q?mAXscdUBP5pp2HgV13QrV538jCeTQ4fFPOSFkQPUdIppOAB6NagYxqTSYWZQ?=
 =?us-ascii?Q?Cbqz6ZwE7Kf7ccSHZJMKWWa5sj4I5ZCJoFiPl4KTg/m5YhTHsjE9iM/MCBa1?=
 =?us-ascii?Q?AqQ+qAtyilxP2QxajPENtdzn9KHM+WtsJanVMDXlOPW3W2bW35O8nVf0r3dW?=
 =?us-ascii?Q?lkrjEvYex1/R7j7GjuqYHTy7ra1zuZ7StAcA75krbKG3e7R29MnRq2OHBdYR?=
 =?us-ascii?Q?CULFxpdVPkSQJM90qVl1R6wUAsKfQCNAHOs+ajgDpD5ER8tvfdfdD87bdMOD?=
 =?us-ascii?Q?tNHDBHFX98m/WaN6VE62wa4KL9ERMeeW/RnJfEoKwb/lT8iREq+wzJ0MoLQP?=
 =?us-ascii?Q?IE/PxUM9l95XeWAZFwjBhP6dRGq6SbNbh+lKV67m3XCbHlo3u+2ypiqNaQOI?=
 =?us-ascii?Q?oPKJXtZXwDYKcueAEUb6z9eiY5hLs7zkIirNdI4N+YirjJE/IjX5AA2mVymg?=
 =?us-ascii?Q?zZkBqslghL0c91Pk4reIqp2J27Kt0iGQSgoL2NnVu9fTjL/cBe8I0DS+NDbZ?=
 =?us-ascii?Q?tqHlpA1UAQLCB1uXg15V78Y+l9eR/3P4m+sTVXabZYdNHHGqFNI2xQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h/b8hy06GImuo80I4yzKGNqMfg3erP1lnBp0tTXwXLL0pWSMo1U922BGuRmE?=
 =?us-ascii?Q?v0qCbLTk9O5W0LTp6Ry4PTzGm1p39U9kumnwNWJ+KMVdGuQol6Wks+tpHiXX?=
 =?us-ascii?Q?gVG0I9FfgpBpZCwvuGXdxz/fhEKBeufJD6pq70t86UPYBVtVYscH2LGcYerZ?=
 =?us-ascii?Q?4J8OH8vCR2ehs/rvF5eXXZ7cAaTHni2oJPLw3XQV/XelLmHX8M7upnHP9k9g?=
 =?us-ascii?Q?E7k9O1sGdGcuK4pmLDn1XG199Ek+PSLTgz6NxiFXVgUPs8D6Q7oLbzGUHQqB?=
 =?us-ascii?Q?H7WYsElOn9u1zJ71t9OAYODtDkBoDDyJhYAFBRuUsC4LecpV5izR7ZH/jVxL?=
 =?us-ascii?Q?QweMWgKrWcKCNuFIotmlY3e13qvHRUFi4tuaGHAgeUZF5GzEGiyhRJvgjuK0?=
 =?us-ascii?Q?hUVSc0IXsWGRjifmFnmq9S5I4lmgn3KzNL8bZOixv2D6VRw2kQ1QcIzwU1lI?=
 =?us-ascii?Q?ZImi26c+Q+LcyZ/UNbk6Z/U5BZ5wqkId1qWOH3tnUiVJ7coPkvqgLiumUIIy?=
 =?us-ascii?Q?KohY08rCeFJ2djBdwSb45bNx51RraH9adQsrdUNRbpCsdhkrxF7K67/hXdEc?=
 =?us-ascii?Q?Ly7CsjtFqJYVPQxwCjLu9mneNe/9/L6BpOz0Xc9FU7aE/MCUZujc5GcdlY9u?=
 =?us-ascii?Q?CfG6O2pfWs3AxjWq5vG3qgrAC3kVplWBIC43kMyuA7bXOHHE3QvhK05a3sA/?=
 =?us-ascii?Q?0eHB/8V/WecPIYgHQVHj93f2lVW3TMWT2PgPxRMZfz35+C2AdlVrXbia8AVo?=
 =?us-ascii?Q?FBhRs0wBsC6Oq8kJAjLh5TBIvEwM9c5LMgruGLYTERQJw66oVbBmGvpeu3RL?=
 =?us-ascii?Q?MkVLzNOrUsTSGhZr5niand/RZsbP9o1SiQCNjFrTLu8CLvfsW4B8GhaoFDRi?=
 =?us-ascii?Q?T+uARMstdLhWLaP0MGTHh2rCRkHeIYbHoLAt/KyeBVFLeVouW+sruSkAAPiu?=
 =?us-ascii?Q?ocXSL+DqSai8NxswlrgQdefxpWxRVDGQGCloyZDYB4twZlETjiqDqKwqb1/P?=
 =?us-ascii?Q?C3L4hBc0hrguYZzLxoyDeGEUrBSuMayZKrtslAeSZP3yTiXiE0zxllmwuNR3?=
 =?us-ascii?Q?Pt42F844rrPDt5pqR5fZDbGGAaCaPGEL5aESJfjQ7BMAxHWpSBPQXnp79dZ2?=
 =?us-ascii?Q?n2fSj9DXFuDDBIzUxQtmUE5x3R641Jdhs3sSSYopAlkuYNoVQF3fIDHveM/Y?=
 =?us-ascii?Q?Kn/4hkq5LLHuJsgqYJuZHYln5pPIKWx1WmmarFQ+fLpGzC1pcKO1lGoM3vnU?=
 =?us-ascii?Q?v/7kuV/uZdEwkN1x4n77Dti8NJOcUsbAf4HjUFpedGGaFMuw2zEruYNwNG87?=
 =?us-ascii?Q?r1lmXaa+h5pZLKjKlLUMal1sEFXx6IxaufbyrHtZpadpJj1a+1TVhU2L0FED?=
 =?us-ascii?Q?3DcNbVaQqDI8dMSh5df+q9tznVx9yTN481OoH/odnVlAj04Yzg72Gkb/NWfj?=
 =?us-ascii?Q?0an8/d5nLcgFWGXDOV1+Sxcbbmg9e2M4YyClDRSBUHsjma6yEuCeDmagWncR?=
 =?us-ascii?Q?9XwAYsI564C6nm7DJJ73ZOKQE+Fi6isZwkG8T7a00TSJKkq7l8KGVv83cLXm?=
 =?us-ascii?Q?hkOIUvET8c0LwvWqFwiCEHjTEIl6HPea09Kv50n8Bi/SHmuK5sBWm9ig4DEe?=
 =?us-ascii?Q?P4YKHXr4ibF6zH8q50KMPdoOTpVMT3YszdmKPr7BvapyesKg2oXGhr7vtMal?=
 =?us-ascii?Q?15cvMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d28964-143f-408f-69e9-08ddc4389939
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:15:52.4078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itFg0jIscjNrlmTYaWWdAwgX14zXaAYFVsqnk7bEdNXtCNPM8B27drpAFtI1shZUhMQ3i2aWxyZv6n1D9hyFn9I7J2RQj5skLcXt4yTUa4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5790
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

Hi @Heiko Schocher,

> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Wednesday, 16 July 2025 3:08 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Heiko
> Schocher <hs@denx.de>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>;
> Maniyam, Dinesh <dinesh.maniyam@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devi=
ces.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device.c=
 and
> i3c/master.c Linux version 6.6.37 LTS And few header files included to be=
 part of
> the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/i3=
c/device.h
> and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support i3c read =
and
> write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.
>=20
> v6->v5:
> --------
> - Resolved documentation warning in include/i3c.h
> - Move declarations to the top in cmd/i3c.c functions
>=20

I have addressed all your concerns and implemented changes in this patch ve=
rsion.
Thanks for your time.

Regards,
Dinesh

> v5->v4:
> --------
> - Add header file to doc/api/i3c
> - Rephrase function description for i3c.h
> - Separated subcommand as a function for cmd/i3c.c
> - Used memory address to transfer msgs from i3c
> - Rephrase description in cmd/i3c.rst file
> - Replaced int with unsigned for positive variables.
>=20
> v4->v3:
> --------
> Resolve ci test:
> - Add i3c node in index.rst
> - Formating error in i3c.rst
> - Resolve cpu_relax undefined for sandbox
>=20
> v3->v2:
> --------
> - Squash commit 10 to commit 9
> - Resolve index for new files to pass the checkpatch
>=20
> Commit: sandbox_defconfig: Enable configs for sandbox i3c
> Commit: agilex5_defconfig: Enable i3c configs for agilex5
> - use savedefconfig
>=20
> drivers: Enabled Kconfig and Makefile for i3c support
> - Add maintainer for i3c
>=20
> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> - Add empty lines for if/endif
>=20
> drivers: i3c: Add i3c sandbox simple test.
> - Removed DECLARE_GLOBAL_DATA_PTR
>=20
> v1->v2:
> --------
> Reorder commits.
>=20
> Added commits:
> - drivers: i3c: Add i3c sandbox simple test.
> - test: cmd: Add simple test for i3c
> - configs: sandbox_defconfig: Enable configs for sandbox i3c
> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
> History:
> --------
> [v1]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> dinesh.maniyam@intel.com/
> [v2]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> dinesh.maniyam@altera.com/
> [v3]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-
> dinesh.maniyam@altera.com/
> [v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.621=
2-
> 1-dinesh.maniyam@altera.com/
> [v5]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-
> dinesh.maniyam@altera.com/
>=20
> Dinesh Maniyam (12):
>   drivers: i3c: Add new i3c uclass id
>   drivers: i3c: Add driver for MIPI DWI3C
>   drivers: i3c: Add i3c uclass driver.
>   drivers: Enabled Kconfig and Makefile for i3c support
>   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>   drivers: i3c: Add i3c sandbox simple test.
>   drivers: i3c: master: Enable probe i3c without slave device
>   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>   cmd: Add i3c command support.
>   test: cmd: Add simple test for i3c
>   configs: sandbox_defconfig: Enable configs for sandbox i3c
>   configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
>  MAINTAINERS                        |    7 +
>  arch/sandbox/dts/test.dts          |    8 +
>  cmd/Kconfig                        |    6 +
>  cmd/Makefile                       |    1 +
>  cmd/i3c.c                          |  271 ++++
>  configs/sandbox_defconfig          |    4 +
>  configs/socfpga_agilex5_defconfig  |    3 +
>  doc/api/i3c.rst                    |    8 +
>  doc/api/index.rst                  |    1 +
>  doc/usage/cmd/i3c.rst              |  146 ++
>  doc/usage/index.rst                |    1 +
>  drivers/Kconfig                    |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/i3c/Kconfig                |   27 +
>  drivers/i3c/Makefile               |    5 +
>  drivers/i3c/device.c               |  262 ++++
>  drivers/i3c/i3c-uclass.c           |   38 +
>  drivers/i3c/internals.h            |   26 +
>  drivers/i3c/master.c               | 2070 ++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig         |   11 +
>  drivers/i3c/master/Makefile        |    3 +
>  drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
>  drivers/i3c/sandbox_i3c.c          |   56 +
>  include/dm/device.h                |    2 +
>  include/dm/uclass-id.h             |    1 +
>  include/dw-i3c.h                   |  252 ++++
>  include/i3c.h                      |   93 ++
>  include/linux/i3c/ccc.h            |  385 ++++++
>  include/linux/i3c/device.h         |  286 ++++
>  include/linux/i3c/master.h         |  698 ++++++++++
>  test/cmd/Makefile                  |    1 +
>  test/cmd/i3c.c                     |   50 +
>  test/dm/Makefile                   |    1 +
>  test/dm/i3c.c                      |   34 +
>  34 files changed, 5822 insertions(+)
>  create mode 100644 cmd/i3c.c
>  create mode 100644 doc/api/i3c.rst
>  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mode
> 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.c =
 create
> mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/maste=
r.c
> create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i3c=
-
> master.c
>  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h  c=
reate
> mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c
> create mode 100644 test/dm/i3c.c
>=20
> --
> 2.35.3


