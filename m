Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDF5C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA46A82E37;
	Tue, 15 Jul 2025 01:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="S61odDN4";
	dkim=pass (1024-bit key; unprotected) header.d=keysight.com header.i=@keysight.com header.b="ooxScHh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB3A82F8E; Tue, 15 Jul 2025 00:07:44 +0200 (CEST)
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com
 [205.220.173.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FA482E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 00:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=keysight.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=john.ripple@keysight.com
Received: from pps.filterd (m0187218.ppops.net [127.0.0.1])
 by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELsVdB031631;
 Mon, 14 Jul 2025 15:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppfeb2020; bh=r3H7gph9NEE9LkCdnOQVs2
 L4mSroCUaYB3Z18zNixbU=; b=S61odDN4N2TPxqs3vmwNt/D0jU+UvSXHQaRV5K
 Ewy5k6thSqZJbKiuDBAPGIaD/fTFxc/znPUbtYSpnhF6o1stRAo812xbquM8u8lz
 zhUOBfl4gfPRZF8yTcJo6JMpguiOLeXY3XZeny9vFbR9uQ8x9JN0x3aYfw8IEkld
 I21MJyupLw20X9ImIi9RtiQkLLEbPmGBNXNfHdbSBzlaVLT37tIliYuyxYC/T6Nv
 AG4iVGsL4/U4ySsX0O7kL/9QsL0N9tgoi7ou18HYEwCzPJLHORKVj7fr28ppEC98
 CvRN1W9CU/fVlD11Pu538LJhnWT8ck3Ajmjp16A4Fg9nrd0A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 47w5ba8m88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 15:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um61OreyBj9sfa56ktans/ZXyYMBeadfYbdurczuHDD553bVUb+pC2DlmPEsCERb6cpf+IS3LJe6xe5CWeaF6Gajbespt8MJ2uWePOaxpNLgFfAsGhfVWJQCfGf4VDivas8FtcSsR40HhR0vfW9Q8Sfef2iQbDlhdVQwFNmxvv2CnvsfieYuUWeig+7/5TM/MvnPmEvHG7lvvSPLREfWZm80b9tPA3FpMJNTZH7+Rz7dwIAkJAkIX93KnXgiDXIlQ31WfjhwFWWTK4Gntq95HjSyW5I0fuVV9erVB0TVp2t+l0GK47kZ1EBQ3CKj/P5nkfjQm28xl3C+uMZucvBxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3H7gph9NEE9LkCdnOQVs2L4mSroCUaYB3Z18zNixbU=;
 b=F0QLQ6gx+8peh5b4LUpXxDPeYYpKAM5meb4yiRvSkx4Wi93OT3Hpye8F4gZPXXKHuOpRkU5rQhnguk0syXBHIvCW9J4MfVwOGlU7aE8fv0dhlHpObl8X8miToXwjfo5lZnFMe355Eyw5YQMsUWWbMrF3c939Uu5p3FzKo/jnegxUHq5/mpmIAtqMsJo7y/Yjv5eQ6MNQAdB9XR5BLXo058k7/P7h8H/vFWNbD3wk6+ZddtU5ZpZvNtIzxdePloTky4tivVIjNNv9GLrH/Psh0nsvs3LFuKNwcSe0UBEZ0V8Y9Z7alo1i59DZMBDNzfF6GUTmUeJDaGw0Uook96iLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3H7gph9NEE9LkCdnOQVs2L4mSroCUaYB3Z18zNixbU=;
 b=ooxScHh/owNO28lIspaM4p2ihWUuqzqYSU2uiqGS6PMWjqHUAC+tkq8uGx5VcGHlDmSBSyUlw2ryQFvQB3xXgCCgiPl1BzWWvcE/ff6D+MkVRkDG7Qa6KjPrw3Ycse0Wf2Ebxwh/vap1xAIf6bc3yuD56JYGls/tFprhKvMksIc=
Received: from PH7PR17MB6130.namprd17.prod.outlook.com (2603:10b6:510:1f5::17)
 by IA3PR17MB7311.namprd17.prod.outlook.com (2603:10b6:208:517::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 22:07:29 +0000
Received: from PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e]) by PH7PR17MB6130.namprd17.prod.outlook.com
 ([fe80::54bb:3a4f:5f80:a51e%5]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 22:07:29 +0000
From: John Ripple <john.ripple@keysight.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
 "andrej.valek@siemens.com" <andrej.valek@siemens.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "hs@denx.de" <hs@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>, "sr@denx.de"
 <sr@denx.de>, "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH] Add ahab_commit command for imx8
Thread-Topic: [PATCH] Add ahab_commit command for imx8
Thread-Index: AQHb9Qpmx6arAgP2ME+R5H32DaRdvA==
Date: Mon, 14 Jul 2025 22:07:29 +0000
Message-ID: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR17MB6130:EE_|IA3PR17MB7311:EE_
x-ms-office365-filtering-correlation-id: b5e77727-afd8-4d26-b115-08ddc322d320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ShBr3rRwnbif0Bp24YVnDHf+oj5oxQwcJd3nlIE0OY7PtQfiGCgNQn8nqg?=
 =?iso-8859-1?Q?Cz4SZ7idz43n8cDz0ntQi1EB7tC60Hmfh65bL3jX+MuuhgZKkfH4CY6r4g?=
 =?iso-8859-1?Q?qqKFckqLSgd5Zq1R0igYawEttd74eK+yL66ofkncxq/TfM5EX80KvFv8su?=
 =?iso-8859-1?Q?DE6UuMZqd7i1R3kkOsj81uxXRUPm00Lt0wA2YMMCcFUVAGx0fTVPaKLFZO?=
 =?iso-8859-1?Q?MRxwYDgehLyfg5Zj0tNxKIiBbyL7kJUYJFTF6zOitJUd1t0M7HKexaR8Gn?=
 =?iso-8859-1?Q?rNwCb/ArOrQKuFamAvOpJXtUfswT15Kb9ZW0c9M++tMMe1ctRs/JC9Zojn?=
 =?iso-8859-1?Q?KbqvhabwKU4C5hegZUSq7mlUblHsVPfofy6IR82Tm16kfr4zBTfesARBao?=
 =?iso-8859-1?Q?RhirT1f/X4tRH4Oe5OexJ88rHTdrUu/st0FFfykRTzTPtS2XcBsi6FfxZH?=
 =?iso-8859-1?Q?DorMrln+b52TgPbP2Hcz2sFQtDvzXKwH/1sw77+3TEe0TXzT4AjPllzESI?=
 =?iso-8859-1?Q?0Y8jrM5a2sgQfVCL+P/hsIlYIiZoEt0tGm9MjivPQ4Bm3styi9XZaM7mwq?=
 =?iso-8859-1?Q?bpOD/pvfQ+GlbLFBYDMIGSMRJSUpnhh+sDyTQvxrAorLizt0CouYAh0O4w?=
 =?iso-8859-1?Q?ZKD5Qnboee21aQ3q0HNoM6f4e+yAmCJRxqijiI4mq2smIcMp8cCDsYwIb4?=
 =?iso-8859-1?Q?zv7PqzZx+bl4Aci/bJAUDS3r+A0N6HVyJpx80WssI/WoxEllZDgpAFT0/x?=
 =?iso-8859-1?Q?Ddb9PCbWEgocUAG6LauWr9A4UOw6HTz8hOy09NoVdAe3DPJ6oVVOIohQHu?=
 =?iso-8859-1?Q?4l7og9WqsjleRcOS2a/xVq94h6Ys9Jj9IGOBADA9W965qMY3CLwnGbYdBp?=
 =?iso-8859-1?Q?DLXXfu6n2HCWWS/USG4McFXswbzRxopysdC2FAclUJ8jyjnuANXSWwHcMs?=
 =?iso-8859-1?Q?HFpPrAEavC1M5N6KYlzSl9XCfT3lKB+2ckoJaFX/SpcVJ2lliklIeXUPgb?=
 =?iso-8859-1?Q?XIH/JlOfXchKCOfmuDKyBuC1VjG0A+nUqfa39a9/Xr5UldB+hqVCjYOCSc?=
 =?iso-8859-1?Q?L9KOfdO04jQq2kyuGyIHy6E6j43X/RoSqcSbOtEth51wyMZ1fiLjhEMa6/?=
 =?iso-8859-1?Q?nmYQaFD8ZvdJnkJCozGzhseAF946bzJaar3EctJvXaePnd65EQSFHSxPqH?=
 =?iso-8859-1?Q?y1m7rDJCphZiCtuJMmAxiTbNzW9gUGyko9t6x9gXcl47APyYAf25lxYyOR?=
 =?iso-8859-1?Q?RCxfWcg7xp0+WXqEOLTTF/eFJ2EOZl/DpXHQn2QQfQOf0Ezmgtla+mLo/5?=
 =?iso-8859-1?Q?eH54AgJ8S3I/ndLqn+Hx/rU6X/Px0+0bvhO1qFI+30yjJQUq5/0hw7HHx+?=
 =?iso-8859-1?Q?pIXJf7hG8blka2g5edtwlo5kUe+C6GdqdTbzKeFgDqwKmVF83cnacUZf7t?=
 =?iso-8859-1?Q?NQf2CoSssIcXh/2USgz+MhSgyQnrDRQ1KKOjWGEKBU9QdXBBSbNVdb7mJf?=
 =?iso-8859-1?Q?KEvwA8H3D+OVe6Q9Hs6yRrs5lQbW9I1TT1hGiUP5GJEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR17MB6130.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RWFrBceN7fwOlkgZFSI1K7vH1UOeeea+YJPWPAnSyxRaoFWu3d2ViN9wua?=
 =?iso-8859-1?Q?xi7M3XGpSX/z5m3KFMxl1xVwz6elcpfIQiczgZSVojBN9rh92De/JAMmUx?=
 =?iso-8859-1?Q?6TYiJMwDEg3JjRtYvaomXIpJL028Bz/2iDiYGdtcdRyXJIPlzbBxppvCQh?=
 =?iso-8859-1?Q?langdRMF+XXCHWI+7dh9lvVWJ4CSBBTLniM4nZj/KlPrpYPr/bcsKNQ0CU?=
 =?iso-8859-1?Q?OAqhFdAMeeQatM6DTH21frXwGmeRNBkqZMyHY1NC1DV9czmHFJN7bKAkOZ?=
 =?iso-8859-1?Q?42YZFwFXn5vJf05P2uosFLF1i/++RfRiNHkywgJzjcPR563eS1FvdGsNDQ?=
 =?iso-8859-1?Q?2lhI3zn0U9EnaIythlhN5tFoG2tejKxSd+TDa957gmQSUBjNXc7HvWIKB7?=
 =?iso-8859-1?Q?cSOztvR73xmsQjNqV9tINf5PJWij7pd0Zji0d1dKpXA/Rk8jjuKKAyVyhr?=
 =?iso-8859-1?Q?vlGoIErClVpVAlmOoqDxz8VuuOqvSxCIm5fh4+s86jvgSDMUcLqoAaAH8q?=
 =?iso-8859-1?Q?ZvSGgmgrCb8SsD67ktISWcdtdtNeQz9ZigVFSEhqwnImj8BjAp9GEjs2nS?=
 =?iso-8859-1?Q?BFBOjjlxQs/GtdbBfiZtD4lNFVw+PPGf9z+FomsvEPFoZ6n6CcipC7cnoC?=
 =?iso-8859-1?Q?bCMIPttkrd6mlsVIY7o+fxXqcXXGo36YjiRLiH5tm48PQ5zyCHMWqVvLSW?=
 =?iso-8859-1?Q?prFjJDlu9caxyo3S1NiZ6peWHyrGONoVotWZS8/JBQ6ufStchUhCt3/pP7?=
 =?iso-8859-1?Q?TJ4lWmwvy2zX7D6mvAMJRmz3yJEl9QXENrvcEFZM8C0iXiIhCfwunSsdeg?=
 =?iso-8859-1?Q?zFaGG5jOEPrLoNZu+W9FSmGR7rbl7nMzenmm4AgQ8Jxw36k/La9kVNj1Qn?=
 =?iso-8859-1?Q?w87LBdwp/liPCWejpWZ3eV6sX8oQkfbcV63jCXre2lAm+t8Ax3VrVsAs1l?=
 =?iso-8859-1?Q?RpWGCWPEyVdk6E4hewrCpokUnzSs+ANf3Y9bDq6wJvU6pwyui+XnI7haeE?=
 =?iso-8859-1?Q?DtNGKXnLlCsLqA+sGGJnCHtvdHYj0C7endRjwx6x426lVJj5EWtsW+MYet?=
 =?iso-8859-1?Q?ksyjcQm662o07VSfrt7SSGnCuOZGSBGyBGLLIAnMNsxllUPi+WOBzp+0/k?=
 =?iso-8859-1?Q?9w0pCKnZrO0Bx9YMeoJKXgDtEkoPBiKf3wMPyXhV0RFx6h9VCkaDOcp9pV?=
 =?iso-8859-1?Q?Ft4oztKzsXccrNZlcGociflkDlZOuoabGDxIZXwuSp5TrVvuls14KT7eF9?=
 =?iso-8859-1?Q?vR5HTE4qgR/cQkep03XfN53IM3pNTHZ9DMuIiSxT84fHSSw0Nw6DfuIUNf?=
 =?iso-8859-1?Q?ahRDJ0MObqjVo/hUznGf2q6m+QBQSmj67dN+MRJLNq7gmssqv0A2Kb6Zfy?=
 =?iso-8859-1?Q?iFNjUeAXkv0M/qxphIEpiZ1wP4oH6JBjpg9ep0lSIxmVUwLpE5BhPZXIms?=
 =?iso-8859-1?Q?cSuNJOaI6xeyS/Sz4oXgdyy4NZH/40wguMvqXkKf2B5dfEHnMVCRq4RGHv?=
 =?iso-8859-1?Q?5k4bLzL1PtYqfgu43/8UhBxIkbD4HuA8b0ZD/dnpA+o8FDUAsMoz7c+Qpo?=
 =?iso-8859-1?Q?BWoxyUKfehhz376w8Mrk8Yh9VIjwIxTfHJJnTbuseZQ++qqZcDNWdNk6wD?=
 =?iso-8859-1?Q?4GlKtZirQtRwXzmmT6+Xd8n3yDmc70iWMZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 49Q2NzC8fXM0zYYdDhjzzcfsEUCnjjJhWg7MmzXRAmJVBdUplPtNeOralBrgcgjz3iSAgNZrC6xAxsocmdxjJ6zQ1S50Qj53BsKwixxRqeCObBW0ZGqqYqAvTbz3PbmjcWnf0pjeqhUZqmWnMOtAFURIpaeyZTdbo8olPoUu5bvuwJuelnS4T4OcGwzLUOfxFtyBsyVnmnkzM78wWjtcHABsDI91s25brkkTg0q/JldxH921oSBE7+ADQD1V9na7YbQUus8rln2OfuIoPAhk0bsowR2mh/EZVeReR4ImGAAVM4f1mm6It2bfzgtP19vj4SxVcAg7j5zgleP95wtNIqXCrgJs0JHiClQqDZnjVwllGPlnuP1XNrdn/ZXIodEOsxDn6VreDPiaEGmpLsQBQZj8d+YiYZPOKaFHHFTmQDJqh4a442vBWh2vhj+mHZWsT+6zWk+j4O1iMpecjPsZ98/q7jU9dmwdmwQuOnwK/NkZ7NI/LLyYpUCDUdmZX8NUmJhTsmdMBNwdja/+ub+QYQZdNKan3AZl6XBOe/uIgalOXsRWq9t6U0JxYXR8sXctw3+JBI4kj5Wg3c8uIXX2g7GdeUkC0d5u5F++EZCOc1meSCJNkII+2WwHRrb43onq
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR17MB6130.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e77727-afd8-4d26-b115-08ddc322d320
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:07:29.4391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hA0xd4/hS9noU4nhvJbfp3tBy2MYv4sLDzS2o7qUxaO+xL3fgWfGKqrGKEjjnARUQra1Gl61K1C5EqRTa93JMakd7N0oNlJhh+nK1fJnAM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR17MB7311
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1MiBTYWx0ZWRfX/651uegccLOe
 FZ9SGLY7D05bV/VjI5MNCzwCno+xmCO+Pt5pY6osgN56GAbYkY7dh6rlbdpM/N6ZPwHeleHj7Fx
 kcjoyD6lM8C1Z3mpMDWham/tJFJAH/Tb21ldMsFVjst4UHQ+P3rmbF1lkMXyl3BlzWy5/J1tQvO
 xvDiBoqyWL0PjcO13MQvST8tLBpD+uUIz5siX+E68PZckjn195txiRkzejthF2VJAVZrlzkNTVL
 jP2gPurIcxqI9TavoV/jn+hqVsRzXUYGApW4wYH6s9avYY7UIiQuqDOnWQeei7eJ3ReHGSXCoBS
 ZyGbrQ8WyUcmJwQIVp9Xl/QVDVpJ1TeiJQi1rzlldWTu/PR2ggYAp2J8BbVEmuL0DpwV2DzrcHQ
 Q/KI4ujjil3p8zpzCgL4G9yk6Pe7LqyOqHQIivHEnrfa9DdqwGj62+yvr2LB9z22PsjM+fNU
X-Proofpoint-GUID: AEaGNGGtAY6AjaBkqFcYq6fgOyVHCrBZ
X-Proofpoint-ORIG-GUID: AEaGNGGtAY6AjaBkqFcYq6fgOyVHCrBZ
X-Authority-Analysis: v=2.4 cv=MY9su4/f c=1 sm=1 tr=0 ts=68757fa4 cx=c_pps
 a=Kwgiled+I/UrNCKv8z8bUg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=vu2TTH8h0NUA:10 a=F6MVbVVLAAAA:8 a=jkbYhX3_Vmwd9nCaMIoA:9
 a=wPNLvfGTeEIA:10 a=6mxfPxaA-CAxv1z-Kq-J:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140152
X-Mailman-Approved-At: Tue, 15 Jul 2025 01:04:38 +0200
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
index a40c8badf9a..ba93ff9bd74 100644=0A=
--- a/drivers/misc/imx8/scu_api.c=0A=
+++ b/drivers/misc/imx8/scu_api.c=0A=
@@ -1287,3 +1287,32 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u=
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
base-commit: 235e14b0f1ad7cfd46e18635f22a3cba7209c766=0A=
branch: master=
