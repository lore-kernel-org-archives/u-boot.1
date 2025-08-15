Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E7ACA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 16:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094A783AE6;
	Fri, 15 Aug 2025 18:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="fUUXF+Zu";
	dkim=pass (1024-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="I/D2zZVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0932B83AE7; Fri, 15 Aug 2025 18:50:22 +0200 (CEST)
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com
 [205.220.161.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7172583ACE
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 18:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=keysight.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.ripple@keysight.com
Received: from pps.filterd (m0187212.ppops.net [127.0.0.1])
 by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FG06X4031094;
 Fri, 15 Aug 2025 09:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
 Gz8XXnGV5Mb7CB30dkaBKlhO6THZf9UJK4a9OK6yEOs=; b=fUUXF+Zu5CzQxjUk
 U5YfjWZcQDE79d+o81lxGgUsDDjFXChApTH+kyzrhQ/YhylHeTh9OozqN9sNNNnu
 jWulVS2GEw94LUjEpCPqjvTo7pxUvPcXYfCMyIxcPOzNrbnR8jG+8BbsoAEIRGgV
 EQYii0leB/8/uoWGCL+ZbnuiDQ5aI1eIzqpDu5f8qb6NN4MpyTdZgnYZYl1dLhP2
 ojJ4PshJGl7pi0wfdHcEeXmDqiLT2Nt1Vy9yIpma9Y/6Doj96DbSYIGkWWPyGFMc
 POlRr9f2XUCvla0IkGbErSJcGKWk4WamfILSx4dWARRR2OtqE8srqy8Dvzewpqbs
 VSzUHw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 48j3cc8kky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Aug 2025 09:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIrxNNO9DP55uBJf2Qir+D/H5mIr/63u3+iU8L7tcniLJ87cpBt/j7XkxQAAwr8jFS5Mdj7CdLsWFOKRhgDuFwGmtYWoFcAROTWSDootf2WreqglkVywC6UGXvB+sup8gzoQj5Fi93mNOxZMYvk/huo2T7QZ9ZLrQgU9rXFJj1kfGAHAzf9S27bH1cpEzFg1OeOV7j8K5K68CvgzwRuIX+zGWp6ZcSd6bDGYGAnJM5i3GieZZ7X+9NQJzDeZmyq7exHGXdgXrBNqBcYAsUDb1p9McYgG+hRK3aMKoMEIpcALhKPLfyTbLjcJPUnY8RSQ7uQwL1aO9sJAcQijyuWXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz8XXnGV5Mb7CB30dkaBKlhO6THZf9UJK4a9OK6yEOs=;
 b=LubTHUYPBrmDEn75lxsjLm74qD8FFL+tHOjVZ9f9TkICYfmYB/ZTSXIXX+g6dJ3j6kVcy+IyXWGdIXsFNscLRWzxkvIUaDFZEUDOK8f+WSedU+jYymoCn75Xu8xwea/E+NZnLpvPd6vP6veUqCt5GL2hR+TLhLVxvUyB/t4cFMu/QsWU09Wv0QtJD3gGPF5yEFKZrU3kTrnzUK4Ar8G/acYRflPwz+NRbFSujsvaBhewR/iwkAOdpjYZFhS2HqNtrqY+E3WVu4smWBnt+xsXYcnO82etIjHdkDsl/jQwABrS+dUmPRMY1VIJ3KRHStBiQgqKWAbtU2UzGPL55G925Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz8XXnGV5Mb7CB30dkaBKlhO6THZf9UJK4a9OK6yEOs=;
 b=I/D2zZVzF2I7uM8Gu2Mj5niZPhHwIpkv3JjMYCSMgR9YFZjZeDVRERthTvAksiYv9B5DTqBM540WnBcHRY6EWJV5VwZupxCoM1K0+3NKgRjAJVMVB1QGADfUqlaMFgnm5Pu5B1w+Ts/BwlsDquyOZrWgMvc48OP5YpzACS8M5HE=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by IA1PR17MB6622.namprd17.prod.outlook.com (2603:10b6:208:3f8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 16:49:08 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:49:07 +0000
From: John Ripple <john.ripple@keysight.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
 "andrej.valek@siemens.com" <andrej.valek@siemens.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "hs@denx.de" <hs@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>, "sr@denx.de"
 <sr@denx.de>, "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v2] imx8: Add ahab_commit command for imx8
Thread-Topic: [PATCH v2] imx8: Add ahab_commit command for imx8
Thread-Index: AQHcDgSEA7iWlhB8y0yzlFpds8A1kg==
Date: Fri, 15 Aug 2025 16:49:07 +0000
Message-ID: <PH7PR17MB6130D968EB14FCDEAF46BB8A9C34A@PH7PR17MB6130.namprd17.prod.outlook.com>
References: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
 <20250715034758.GA632@nxa18884-linux>
In-Reply-To: <20250715034758.GA632@nxa18884-linux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR17MB6130:EE_|IA1PR17MB6622:EE_
x-ms-office365-filtering-correlation-id: faf79488-6b66-4982-6b77-08dddc1ba6d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Yp8Fa0PD4QhxPpRBNL85J9kbsYOQgQJcd8iMCVrBnS0bDT+Ki/MLymnbXh?=
 =?iso-8859-1?Q?GnYjeeUB4Ot/Ck14bS2zYtwE67UjqOUP5aS5CmrtQqZMwn63spSOs6Ck3A?=
 =?iso-8859-1?Q?DAr5X9K3/BwpEi75Xz7NcOid+hE9N2dml6UnaxaPW3E4IFVkWrMiZd0h12?=
 =?iso-8859-1?Q?FgJNz5ELsNHfuYhs5m/nUbc9qi7NUuhTmGgvgzWED9WLpOhR+XtZaANKzT?=
 =?iso-8859-1?Q?hYNrNjaFdIOnN6LgMcsRIzEOIdqmciHwMILcMeRQB9GrxsB1ZsGGJa+Tc5?=
 =?iso-8859-1?Q?RN6lx0rNzV4M07mSLUqA+8QZElg4cTDSo1C1nOq7nypTdKbOUGJqeN/2H/?=
 =?iso-8859-1?Q?XP3TsfMLVTOvR7yuRXniSHS9QS8GZLPFktzgOr7rsmBKLCe9m79OkRSTdM?=
 =?iso-8859-1?Q?JbRap2hP1zZa/j+i7AIdx/GjuLgtnnBsZVhdiLQaAky+/+nax7E1x7rnr3?=
 =?iso-8859-1?Q?GKPm+P6I6dN70ZBXcXvwvjEDx8IS0g7XkkYNnVQU+mmx4Ofcg5MFA7LMDH?=
 =?iso-8859-1?Q?7pLpR2svQ/L0Bm5/qK2GrP93RJgxNkWjbAPqquQOQBAyK8aaC+uCWnVfg0?=
 =?iso-8859-1?Q?irnmRaRaKXXkrMGbvGYIBuKbrAuMnRkP/DC1zOXKChfVGmTaH9M6IBs+EJ?=
 =?iso-8859-1?Q?GdehM666an1vjfc0opgiZWSUBJp9NJRUpH3eDJtz/zKQ3fxRoa1rPAKmdl?=
 =?iso-8859-1?Q?e8UJIYu+5lfoBQIC5TJLj1fKrpsGWozdtaymkvcodYSQy15SVjCTBRr1qD?=
 =?iso-8859-1?Q?admj8adtSxUL4CKi07LMaTffrVTUwfJ2GcBUFaFaIkxI5fjeqrvP1L0Evp?=
 =?iso-8859-1?Q?/GT28JU4LwtCU+NZeleGrBEiwytSoaj42F7/Qea+TGFSNHawIjTfonDa/H?=
 =?iso-8859-1?Q?Sw2ebqxDZMgvH0YaY7kI2U9JqCkvA/VpUtWyE8wEqNq5MNZRGHZLSS58TC?=
 =?iso-8859-1?Q?I0VQUwr2sjGT5wPLPH0FTX01NOHvFx6HFm4y1Le49FEo4ynq6VEYgwbwHK?=
 =?iso-8859-1?Q?IvRTb5uNyhu9o6gueU+TD3RehY3Ry+pwJuwIZ4dDsevHzbmfougW7wV6wR?=
 =?iso-8859-1?Q?fqEvI5/BRtKCD5yIw21EM3ebbbPUMoLRfA1EHD7H8SUC4CzlbuB9JAvuzF?=
 =?iso-8859-1?Q?7ZTKJNFjk8zLQKEdY1HcdK7QoOJXqcRMo1qpbS3H0GLyHIkMfMA6yRPDxh?=
 =?iso-8859-1?Q?21WA/UXNcgYwWfNO69EjsgPtUdGoki1ZkUdo+y4CPbgkfbtouJJINeEmpx?=
 =?iso-8859-1?Q?Qns75zL3OqIC86pheXcZDh2LUvfkEuO53J0wpcrcFntsDp98K7NLZr/Hpu?=
 =?iso-8859-1?Q?vY59Wyx9q9IOmv+1foZ4qHDU40hcVHkbpHJa8NuLq9UGN0T14N+Lzhxs4W?=
 =?iso-8859-1?Q?lobiH9E4Ts0oDepsVDX7qvMKSLMJIkP7nex8ewsZ67gAKa234foD2IdPzp?=
 =?iso-8859-1?Q?6qPJ2F/TTqpswSwTooAXqsqIdP+wb1oPTrem4BhCs6hrUeJQpjsG4pZM8I?=
 =?iso-8859-1?Q?IWgsRwEY/KHgFc912BHolZgheiOmOB1GgfyakPVDvtzItZ1dWdI10ln+yp?=
 =?iso-8859-1?Q?91zHtGE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR17MB6130.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mtwc3AgrvLsDuruyfhzfFV2DoOp5v8SYThM1D60WWWW7OS4AOgaLHaTDte?=
 =?iso-8859-1?Q?6cfJ2mv34J8mXduefdIGRHs7qFvcK/wsD0uuZSfHabukPye5WGG9W9NyXg?=
 =?iso-8859-1?Q?+eHIz5Q/qZ1BGV1rxL97/cmXYo4qtT1iC+br9JcT1Bs5sHPnwlJCT9pr/d?=
 =?iso-8859-1?Q?eksXu5IvaT3QCsAJOptSuki/pae0o1lD7oJ/EUhS4A56Qk1D9P2jLsgJqZ?=
 =?iso-8859-1?Q?Ie4dU+mptRgOlh9Ui3Iz3OOZg2KY+gmhG9WFXy/N/DtUQAs4L5F7iL44EK?=
 =?iso-8859-1?Q?vbap6N1CDU93wUi6IiIYPPf0FrK8RYPQ5Vb7QzBnLXxro61sI9fJwn+Go1?=
 =?iso-8859-1?Q?2ucsV0IO/hOiEP8We6ldm6pwrBFH/jzcXBSk5cmNxVA2Xk+JsM6HIfRRot?=
 =?iso-8859-1?Q?vQ112CUc7QP8BIz8uPeTCW2bMmy30mGp93xg4AdC//b3BTlBMdiofDLaDk?=
 =?iso-8859-1?Q?M6w96sUMld6tj8dfSfiznsB+7jDC5eWb8VJOVCYWiVo8YBgJxyzumvHTQJ?=
 =?iso-8859-1?Q?Jx9r9ddJnm327ICzvf0ut0/4kxVWoruOsqIXU2tuyIbx7XMFltSu+O+hOh?=
 =?iso-8859-1?Q?kTZ/eM+jbN+Zx1ci7jbRfNLPUmBnxa8LvJM5lpf3cCHom4TBX3MnegSkHl?=
 =?iso-8859-1?Q?eamooK9Vfj8rPJIiYnaTJ649cT0vplcxqm/C8R+kH1YZM4Q7xGjHPM1vBS?=
 =?iso-8859-1?Q?hiSblxwWuggK+LlLQyRGxo3jjdz1Zw0hd3FEGtvMzA8g4cIgmK610cabf9?=
 =?iso-8859-1?Q?lK1kbsGJ6wl0r4UOAcrHofkLoO6zp0lQ37H2/xZH56JHQpyCDK481ZEcyQ?=
 =?iso-8859-1?Q?0LhkRaaeBM1XlUKntrn7Uf/Z/Iu2Nw1M9qjFmqdrIdIl4uU7IFgwIUcNdF?=
 =?iso-8859-1?Q?cW9vW69JkmE2zw++VXjnNU4J0fOBNpYbd3RBZGLgzW4duf3QrwqSfm/0T5?=
 =?iso-8859-1?Q?waWIN7N4YKZ16H+FpYD3Kp48uWrSxWaSMHx7TbVLerY/hZG3w9UtEbdeEP?=
 =?iso-8859-1?Q?k2szcp+emsLf46tJh8TJsbM4QsYm/m9c7BJRh1Oc34lhlLs8XaiC1aqnPb?=
 =?iso-8859-1?Q?8iGG2mIYmh4GAjV+FPlP9JYOJ2il4AYTzc8Pz1BcdO9td12fV7KeBMWuai?=
 =?iso-8859-1?Q?F5g1IJ1GoAAReQ0uT1oAvrLuVZKuHvAqDEOp5UVAF29WqvJNIAIuF/tICH?=
 =?iso-8859-1?Q?iKPAR2lRCOT4MWDylepbLZIBrMRR6WZVeqrecJsq2sZ5LXp78gUCTddIM6?=
 =?iso-8859-1?Q?+8KoaXUryzY4lanTV1DI+dZNIDxfWKM6tqKoy2rdf5nJpr8y/ZdhxaN4XH?=
 =?iso-8859-1?Q?8KAijXuo4oextRgYRPxA1wt5iBcAlpxZ+Khq9Q1aEJCMzEcRuSZWnVjyYj?=
 =?iso-8859-1?Q?fo/OZAywyYjqqk6RSFX0/jUWNf3+80rD6GKm7Xg1OeXGzIAVFLJrRPa3IP?=
 =?iso-8859-1?Q?q5Y/RkrIDXDblmMlzHc5dAr5wTuz0vkvOuyPs8yGjQf6iDjouFkHJ4I7Vp?=
 =?iso-8859-1?Q?p/XRYRH6nq1Z/XpTGEDmC+8+YVzwfh+1hQcTifjAk+CRw/jDfh7b5aQHkR?=
 =?iso-8859-1?Q?k0pyvgWWvwjzkvYULOeDaf6cwRKIi+gOJpc1apkt/6EJXsfqy4tJ4+5X02?=
 =?iso-8859-1?Q?pDqcI6JhRoLPBkes1m6xaj2Hp/74ssEGqL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MYgQxA6oaepKT5u88KpzPO0tVZ3Twgh6Nge9EruYdaixT8/Vy3VYPRJNKOM8geiy8oqjqe4qqcZaLBKrghbq5kP2durkywiqT8HviUPi55w2Ec5I5R0FqskjJ8Q01Vwj49JZ6IRzlc4IZPs3NNp296v8JIX/XbyoRdBZ73NTUznvjWTqZGpHr8dIedpOgmyWXxNBDcmg+Zwx9DMjwGkFawWer8/YXNEg1AzPpEsdEHZJNoyZdQaelD/TAYjRJ0AQbYv6oviEq0tzrAuNatRmuwP50Fu1uDsy4Z559+ope9/0xwwsvyLa3xB8APf1IdwhBgWPAbr4u8ygTQ5CkaelwRlL4m1KBCSh2V80F+3UEytI+r3de5VoOkFbuQVvHBZwvLEFshG5pNWxdg+Cz9qN5dGaZaOO2uOaNaMm+4Mef/Up6+7oRl/JQGpa+JipNdakpJQyeO35a/QQeypYXexB7swKAJurPyW+hA6dsAYKYSBR8rwK2DHyH5vOJrZpU+k3EJ58eqr27O1AXWRSapS7qBs2RVrymqRvA82sXESbSXaq2rgfKxJZBBAvQGg9blsrSgHEm6h+2KuhXccCASf3bW7tCgFkKgaBJ/jxGbW5QRs0FONH7Sa5ULdHVy+5pOdI
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf79488-6b66-4982-6b77-08dddc1ba6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 16:49:07.7414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZIqpWp/xx71xy5y3/UH4jJCQ6qYoz4Rx7NwdeXbjG4w4afAQaU6qhXryHd8GZbTa190JLbOYwFL5V67MC1tJs3sY7wjVYKtFKv7DNcsguA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6622
X-Proofpoint-ORIG-GUID: GTxCvvbf6BIOXkYT-bbiI7ZIVCh0UCPr
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=689f6506 cx=c_pps
 a=q+NZZ7aF8eLthFK4Etd3cQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=vu2TTH8h0NUA:10 a=F6MVbVVLAAAA:8 a=jkbYhX3_Vmwd9nCaMIoA:9
 a=wPNLvfGTeEIA:10 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-GUID: GTxCvvbf6BIOXkYT-bbiI7ZIVCh0UCPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDEzOSBTYWx0ZWRfX98+RLuy2uQag
 fiQuQINQvUo+XP5w8XROUqbB5Fpycv+nUhP+xVLum7CBtONhFHe8foZw6ml44PxttZL9FW8Eh9O
 x8scEMTTgNSz5/5BLJ6umwCqZG6G8UdVl87Ey7QmAuylFdhvMqlWGoJEwREeuVOkUURgXHHFxeM
 htWPqjB8Dopab9MCt/zuuZFMEsCIhl0cPA911AMkc+sGoCXaV2jbHVPr7VF8Da2eD6oGex4jae2
 enDp85PQ4QDG/FPb+N9qV7FfUa0Her7+crvEQmqc4mOd+NRhDsVHJDXsWb2RTDoQaB9sqI0H0ZN
 NDuGACo+Q184aA+uBaFxe8TkunZbtp+xxPn5Dx235II1pAEs7M1bWCGe1DUB3L1Az9dL6RD5qKS
 EJfeTnfeTqxPtMXfdwKLai2xjiqgsVPS6jE9HcZNIx8lpILrGpL4VOkebN36SOPT0BtD6+qN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508150139
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

The ahab_commit command allows the user to commit into the SECO fuses=0A=
that control the SRK key revocation information. This is used to Revoke=0A=
compromised SRK keys.=0A=
=0A=
To use ahab_commit, the boot container must be built with an SRK=0A=
revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this=0A=
means setting the 'srk_revoke_mask' option in the config file used to=0A=
sign the boot container. The 'ahab_commit 0x10' can then be used to commit=
=0A=
the SRK revocation information into the SECO fuses.=0A=
=0A=
Signed-off-by: John Ripple <john.ripple@keysight.com>=0A=
---=0A=
Changes in v2:=0A=
- Changed patch name to have imx8.=0A=
---=0A=
=0A=
 arch/arm/mach-imx/imx8/ahab.c  | 27 +++++++++++++++++++++++++++=0A=
 drivers/misc/imx8/scu_api.c    | 29 +++++++++++++++++++++++++++++=0A=
 include/firmware/imx/sci/sci.h |  6 ++++++=0A=
 3 files changed, 62 insertions(+)=0A=
=0A=
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c=
=0A=
index 324e010bb2c..f9a425c899c 100644=0A=
--- a/arch/arm/mach-imx/imx8/ahab.c=0A=
+++ b/arch/arm/mach-imx/imx8/ahab.c=0A=
@@ -401,6 +401,27 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int fl=
ag, int argc,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,=0A=
+			  char *const argv[])=0A=
+{=0A=
+	u32 info;=0A=
+=0A=
+	if (argc < 2)=0A=
+		return CMD_RET_USAGE;=0A=
+=0A=
+	info =3D simple_strtoul(argv[1], NULL, 16);=0A=
+	printf("Commit index is 0x%x\n", info);=0A=
+=0A=
+	if (sc_seco_commit(-1, &info)) {=0A=
+		printf("Error in AHAB commit\n");=0A=
+		return -EIO;=0A=
+	}=0A=
+=0A=
+	printf("AHAB commit succeeded.\n");=0A=
+=0A=
+	return CMD_RET_SUCCESS;=0A=
+}=0A=
+=0A=
 U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,=0A=
 	   "autenticate OS container via AHAB",=0A=
 	   "addr\n"=0A=
@@ -416,3 +437,9 @@ U_BOOT_CMD(ahab_close, CONFIG_SYS_MAXARGS, 1, do_ahab_c=
lose,=0A=
 	   "Change AHAB lifecycle to OEM closed",=0A=
 	   ""=0A=
 );=0A=
+=0A=
+U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,=0A=
+	   "commit into the fuses any new SRK revocation information that have be=
en found\n"=0A=
+	   "into the NXP (SECO FW) and OEM containers. For SRK revocation use 0x1=
0 for the value.",=0A=
+	   ""=0A=
+);=0A=
diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c=0A=
index 8985ab6584d..839d20116df 100644=0A=
--- a/drivers/misc/imx8/scu_api.c=0A=
+++ b/drivers/misc/imx8/scu_api.c=0A=
@@ -1286,3 +1286,32 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u=
8 access, u32 *data)=0A=
 =0A=
 	return ret;=0A=
 }=0A=
+=0A=
+int sc_seco_commit(sc_ipc_t ipc, u32 *info)=0A=
+{=0A=
+	struct udevice *dev =3D gd->arch.scu_dev;=0A=
+	struct sc_rpc_msg_s msg;=0A=
+	int size =3D sizeof(struct sc_rpc_msg_s);=0A=
+	int ret;=0A=
+=0A=
+	/* Fill in header */=0A=
+	RPC_VER(&msg) =3D SC_RPC_VERSION;=0A=
+	RPC_SIZE(&msg) =3D 2U;=0A=
+	RPC_SVC(&msg) =3D (u8)SC_RPC_SVC_SECO;=0A=
+	RPC_FUNC(&msg) =3D (u8)SECO_FUNC_COMMIT;=0A=
+=0A=
+	/* Fill in send message */=0A=
+	RPC_U32(&msg, 0U) =3D info;=0A=
+=0A=
+	/* Call RPC */=0A=
+	ret =3D misc_call(dev, SC_FALSE, &msg, size, &msg, size);=0A=
+=0A=
+	/* Copy out result */=0A=
+	ret =3D (int)RPC_R8(&msg);=0A=
+=0A=
+	/* Copy out receive message */=0A=
+	*info =3D RPC_U32(&msg, 0U);=0A=
+=0A=
+	/* Return result */=0A=
+	return ret;=0A=
+}=0A=
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.=
h=0A=
index 588f3671103..876d52cac35 100644=0A=
--- a/include/firmware/imx/sci/sci.h=0A=
+++ b/include/firmware/imx/sci/sci.h=0A=
@@ -144,6 +144,7 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 a=
ccess, u32 *data);=0A=
 int sc_seco_secvio_config(sc_ipc_t ipc, u8 id, u8 access,=0A=
 			  u32 *data0, u32 *data1, u32 *data2, u32 *data3,=0A=
 			  u32 *data4, u8 size);=0A=
+int sc_seco_commit(sc_ipc_t ipc, u32 *info);=0A=
 #else=0A=
 /* PM API*/=0A=
 static inline int sc_pm_set_resource_power_mode(sc_ipc_t ipc, sc_rsrc_t re=
source,=0A=
@@ -383,6 +384,11 @@ static inline int sc_seco_secvio_config(sc_ipc_t ipc, =
u8 id, u8 access, u32 *dat=0A=
 	return -EOPNOTSUPP;=0A=
 }=0A=
 =0A=
+static inline int sc_seco_commit(sc_ipc_t ipc, u32 *info)=0A=
+{=0A=
+	return -EOPNOTSUPP;=0A=
+}=0A=
+=0A=
 static inline void sc_pm_reboot(sc_ipc_t ipc, sc_pm_reset_type_t type)=0A=
 {=0A=
 }=0A=
base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac=0A=
branch: master=
