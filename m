Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A9ECFA46E
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 04:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3D0832AD;
	Fri, 21 Nov 2025 05:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="jtvf4Zlx";
	dkim=pass (1024-bit key; unprotected) header.d=unsw.edu.au header.i=@unsw.edu.au header.b="oAtaMtT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F24680433; Fri, 21 Nov 2025 04:53:53 +0100 (CET)
Received: from mx0a-004a3801.pphosted.com (mx0a-004a3801.pphosted.com
 [205.220.161.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA595802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 04:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=unsw.edu.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=i.velickovic@unsw.edu.au
Received: from pps.filterd (m0437972.ppops.net [127.0.0.1])
 by mx0a-004a3801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AL2aNw3791122; Fri, 21 Nov 2025 14:53:38 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 pps1; bh=ScvtkEDJVQEXnandtoklzmzu9sJ/PMyLz/DPN3Rzbqs=; b=jtvf4Zl
 x6IdOCi1EB/3o4bw8MD4Zk034W2pTWNFjh75xMGQMSLWSIZkYhw541Tb4/avadTu
 eRkxxy9TMiftGlat1iGHm3gBxsAusjc59d8Sriww0QjEuKxE11mkYyG72tTkqc4H
 11tfB523/p6fq4OXQTVMkBtoH5uoozqozJfCf76Pco9l0pJGPNYj83L85YfkJTwv
 fpKCQ41uPLIIRMzOzb4Q7RIshmTlJ1KqsGvk0UdTA2fL93WVufWQC8xeE1uxxXRu
 tw7gvu0IjajgT4of42ErIdYZmASpqVTIYlauPp1CXzerplPYFS/QjfeB/pUK04yD
 Uo5EB2vT/niQSPQ==
Received: from meupr01cu001.outbound.protection.outlook.com
 (mail-australiasoutheastazon11010052.outbound.protection.outlook.com
 [52.101.152.52])
 by mx0a-004a3801.pphosted.com (PPS) with ESMTPS id 4aj598b0ww-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Nov 2025 14:53:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZTuWF3LxDTOlxJ7WkqDO8j9QggZeX4R+A9NcrLk41Ai2//JYmE5y2YLSog65jTRnWfH83hsrbhhE4cELMSc7/VMpAANcd2iXu0NIng73JOk6L/5v6imfaQJFg+uv7hll1MVOZHwkmqZvrURC+GzsaM+iZFKSDyStLZd57+XjY92WzyjPadWPgqC4LDAzXkiU7p4HkN6oZqjJ2KwRuKb+DbqvyzBx/QJwjfCDRZhov+uSzbgliYQw4Cgr5POR2sn8OiPhsZCICASAc+BxiIx3Gn4bCfpxh0XTGNDGbZJTSndVY9XGc1DCcOmmMJZxJeKflykLqNIUmsI49rePehnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScvtkEDJVQEXnandtoklzmzu9sJ/PMyLz/DPN3Rzbqs=;
 b=FYNEK20y/OkNyI0Sp6l5qL5n7/53eBu4lY+MXF5TbO7AqXDIGWCeNTp9bqJkpKnzIbsLBkH2BpW6zu+zj/PYp2r/8E13Lcg9T5MRKt9sPY0z9nAzvmKtqv56cZxHtIO4aPdLfmBX7tNbGF2y4qZYhLJmD6aBERu9K01ESjYWxAJ4kgrUWQSiKuu7j5oZdwf0Mew1UCVkDd+QJGootW0Ae9XbNE4WD+sK5BebPLN06eYklPi5fJB4lO44BzJAQgoqhFLLR6Hf0m8dqnLtkcLKiccbIafV2hCVF24PzWhjValWTj6zZj0FvqagUp6shjVPSvsAoJKsVqNVHEadNMgyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unsw.edu.au; dmarc=pass action=none header.from=unsw.edu.au;
 dkim=pass header.d=unsw.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unsw.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScvtkEDJVQEXnandtoklzmzu9sJ/PMyLz/DPN3Rzbqs=;
 b=oAtaMtT7T6uuR5+ZVFKC60aiiLhMBc/BBjTbNWQKcjXBjq21WJksLAkDY8tIhGPTExY5j22O1cmbhEBgbZsn82KS9yURImr4gCxd6T8XEJYPIiR/50Zmxq0TNeuDC4pvUh9GXKDYr+Bj15n/GzoLEwURinkPsU4aYxd1iok1kbo=
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com (2603:10c6:10:3e::16)
 by MEYPR01MB7399.ausprd01.prod.outlook.com (2603:10c6:220:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:53:34 +0000
Received: from SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a]) by SYCPR01MB4015.ausprd01.prod.outlook.com
 ([fe80::1706:211f:3cf6:db9a%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 03:53:34 +0000
From: Ivan Velickovic <i.velickovic@unsw.edu.au>
To: Yao Zi <ziyao@disroot.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Query on RISC-V booting ABI
Thread-Topic: Query on RISC-V booting ABI
Thread-Index: AQHcWoqnagDnTl/4MEm8HJdn6H4Yx7T8cGUAgAAPSgA=
Date: Fri, 21 Nov 2025 03:53:34 +0000
Message-ID: <261A5A77-D8AC-45D0-8262-95DD9D8BD614@ad.unsw.edu.au>
References: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
 <aR_VYKIhx-ZWYfGT@pie>
In-Reply-To: <aR_VYKIhx-ZWYfGT@pie>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4015:EE_|MEYPR01MB7399:EE_
x-ms-office365-filtering-correlation-id: 012e2fb9-d971-4f93-c036-08de28b18b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?V42Ix4MVHorTRLuRk6QUqhKACYx4xC/xxEfkzPqqmhzaE1DYCm/u+e4/UZrs?=
 =?us-ascii?Q?ISGSUpYSn5/AzIFyg7YZ3sve1h01CYUGemIAjRSUtCNWryF8XCq6T8pZbQBQ?=
 =?us-ascii?Q?kXdsUxv3iyGVPgLGIzph8FU1j0vxvaNzTedCH0/hTx55NPBtV6vyFf88Orm1?=
 =?us-ascii?Q?rwmE9UcoPqdtd+yyHPOP4lmXbj8L7Ew8GXZUVe4dAGqSFcFz51CYEshT1H8l?=
 =?us-ascii?Q?uwkapIEbPJc82nAqc2A9PbhL0EXIZjfliD66weOLcPJzi39qM9QXUvq9lyT+?=
 =?us-ascii?Q?Rf+dlY1V54cqyC6sRZ864yn7lvOUBDQGA6uE5ywwE9WGFofBBFkKl4y3BY0v?=
 =?us-ascii?Q?cEOLa8FYm87yJSDEaolbq5jTXj8ioUiIXePddF/io6ej0vu4Mvh5V/MVLu/w?=
 =?us-ascii?Q?uRgQe6I61BeiFTQXUDAiwVpZbPbf+TSbP8InSJWUz3xHSBw9f/buThKM8r7T?=
 =?us-ascii?Q?7pdogd7JCizvosgFT0bZwjujKC3BFZLP5szYV/k/FETvzvdRD+LfRQ+3CIil?=
 =?us-ascii?Q?JyAg9ED4vRCdEpg90d7ND7T1nRGIRss7mLU1WYM5uJeV5FL7vDlcNXPD+neN?=
 =?us-ascii?Q?9mJ7EudrSg+eXIy0NciVhLvUBkvN8gbQ2HZ4xNf84Fug2BzcYr/gM361O7Hg?=
 =?us-ascii?Q?xQzaKYtNxMu45gqmB6FHCvpsi0sNu1hnBfOrrVFTn/boj1LtW+wtbUgfkA/7?=
 =?us-ascii?Q?8QnZmeHoZ0BwnyupjHV9UpsCiU0aDI6Xx0Y150H4pfcbIa5Xrhq82R9NNnnI?=
 =?us-ascii?Q?6v0tfQOM48A2yWgug/O9PLFXMg4mZc73uOtoV0+wlDNtEzuRRJX1siabt7qg?=
 =?us-ascii?Q?X+CP/rbD/n2PbLg77Gw4y1WGkpayJJDQWiXPHyTp91In8t1fiAS4CtuNT2R6?=
 =?us-ascii?Q?emiaBxoSXonVOQpDM8mgvANoATPnUFcnJ+Pm/4AX2zrRAzwC/v8ba/xv4Mfj?=
 =?us-ascii?Q?AfYnRRxNJgvvbO+x8jPXeoXa18ASBFHSAHPkzdjN3gCiF3W0hgv9OUBn52K9?=
 =?us-ascii?Q?upYjmJUkRX/IJSkOmuVsr/4YqKpIm16yZGZwg8fry4VFztnlLhtkAalkecSw?=
 =?us-ascii?Q?y58XxnpmwSOGgn4uaNiqL+YIWpp2qWLizYbAvK1OOoGoJ6J+d9q7nfH04EdC?=
 =?us-ascii?Q?CBdjATA5/2QbSuQm1GlG9LLbhfdozlsyuUp0yovsWth62D0C8dW8o9za0msH?=
 =?us-ascii?Q?03r5uz3XVzoBH3cRuEbjJs8m2V4J9Me+wsS6lKY0tYR1XAwSEvT0MOIBopeY?=
 =?us-ascii?Q?99zGJOAztpevU5v8PLvEv8nI9XYocXxp848PkISLUieYoKIB5FOkRyKdH0y2?=
 =?us-ascii?Q?h3qk4yfLBHrGEJUEB3aq8j2tjXo8v5Mt9xBoIR2hI0c4I3qooI6ab3wIr8k3?=
 =?us-ascii?Q?Nisz1l+s/sNAIxHMzD8Z0vQ9BtUzs2tes7YcDIyC+c1J7WO1crk9FqQhAHGs?=
 =?us-ascii?Q?9pM5X50aav758RQg8LMlVDL6A/wm18ZIFqdhz6ryrV7LPQTjRtdD7dP+1lOv?=
 =?us-ascii?Q?tdirEgt3eiVGWhe/adkSSTVm63X/gNucDQRo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SYCPR01MB4015.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6H2hSFS3px2yC2yfMcTvxgS58gxD5OW7kn8/0JcdMaqC/8mubJPbrjEOG0b6?=
 =?us-ascii?Q?rJ1Gqve8AZqTMWz3F6v+4SSOMHUuH3kScRCnMgZuv5sjPjpT+fkpHTxrpbY0?=
 =?us-ascii?Q?LEVp/BWmk6oWkzvYyC0AgHykIiU8HGP2+AdAqVuHMIxCea5ukF0+VAVVl3YI?=
 =?us-ascii?Q?dOM89149a5Any7kaClAu2jj9Lz55c8jxz52Vtxi/yiImOprnKh9oBVQI12+5?=
 =?us-ascii?Q?9IiX3qRjdyDTCHfJl4b7UMMTjatzIX6wh5cyO/aAoQon8x6pf15VWx3WmnZQ?=
 =?us-ascii?Q?IZSyg0cVRY+6MDWy2mC+K96klMdiBYGaQxjAcFyEK/4t2+1fOciZnRQQRpbV?=
 =?us-ascii?Q?JqLwUUqFXwA63MpZ9unKjwX50IVqNlk4m4rbHk6O6n59Q74s9h3sMMmptusA?=
 =?us-ascii?Q?ozi6OdvRyP2XuatVcEchJFc3QddcBKXBcDRQIObjdmWLndxQUoyrTswq1uTy?=
 =?us-ascii?Q?3UryrWbT9TbV7g5KkFk9fTi6BOhHA88NqFlG4z0WSQsKl00/cDxvHI6Urf+2?=
 =?us-ascii?Q?PLRv6qpSjovSK52VbG5HZGE/AFTBSpNtKDa5L4ujhTDB7afuS83YDt29daA4?=
 =?us-ascii?Q?6n2gYyOwr/9Gjmy2zQw7h0E+uTQFkkNFPUIymdqVbbYaoQdHRmkDuxj7ZJcX?=
 =?us-ascii?Q?2PbzIJIsaFt+sBYP+JCRmu3RLEFHwjr9ZZaF9REyRyX9xgnmCILpYwGT7+oZ?=
 =?us-ascii?Q?wqO4sydZAS/mtJkka+1w/n+jR0bMUFItorDMzAHVFowMJcI+4ML+ONqC91yD?=
 =?us-ascii?Q?Jy9AVHOFhOwvwrzGTY3RxUugpBZ71yUt0z24O7dTCV5GCUqiaLV8tgCXjySH?=
 =?us-ascii?Q?2LD4Xc61rZhco1tkxUexr4tB/UrKwmZOngfZnVX6hnVSuTeIZaLJbB/CgstA?=
 =?us-ascii?Q?8F8RzlAbT4q9/pDJ7L2DzuYd9Gj50+WyQn4rc4s4Z32f0oB7BptPd7557ju7?=
 =?us-ascii?Q?xaNCxPCsQiam62g2w6wjZH0RC6XJ8elpPA3FlYJ2rcOo/sPtgkVhxE1/yRC6?=
 =?us-ascii?Q?Cn7N+wilqAGwvXJypgqB2ZUSMSPi7/DH8Dl/wxvtSWZP6KYsid4vz2UbpTF7?=
 =?us-ascii?Q?hIvEV8cZUk2Wl73rVnAK/PozjhbIAwDX6JrbmPRTUqKIJQHlX9NDhFRyhFiO?=
 =?us-ascii?Q?we55Uc0IdPESyaG4fiKkFD+6Yiuvxkug3uWPGhPPrwrJyRwJY0I69SFdw6RZ?=
 =?us-ascii?Q?hzfnTfEzPhwIKBtHKHCqm5ToFNgXUcOykPbjZxTKJ5dw7gZprIF/5odK6Pfc?=
 =?us-ascii?Q?8mAYtM6u6N9tgpO/qeS4d6GF/NXPhdl52ZBCLf0EcTVPdRkeDpu5N7muyp4s?=
 =?us-ascii?Q?zBNgE35q0a6UHMlzrG3VTHRhpoAxaegIWXmT9bIS9kZKpbzNMLZI6iXLT68p?=
 =?us-ascii?Q?RRSp/17eBuUJ1IlQ3kCMuAtqQvOo6rCLhqXd8w9RP7h08/fIl9bQ9cI6ZUnO?=
 =?us-ascii?Q?IIbLVsJzyL69CKy62AH386mG1FEI52XqcSFm1fp13DBoNPySxfAuzqD8CxgS?=
 =?us-ascii?Q?7QRZrc8ttuOoK/iFCbYp7mIYtRL1ajuPxXvQoFoCsukg0ozGjTWdx5ycdmyx?=
 =?us-ascii?Q?dgob8D5yurR9apbFbjQHNXUfDRjfh4rOjmv2x5/VuOjJW9DIdIYc4yjuvH3k?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57FAD6A3E2997A4482CD909B24C600E7@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: unsw.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4015.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012e2fb9-d971-4f93-c036-08de28b18b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 03:53:34.4473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ff6cfa4-e715-48db-b8e1-0867b9f9fba3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlYuvvPtEHz2EK2ij7U4aNFoQby5a7SlkKK75oaf6WA87alEM3g0XF487Piq6alOQc4btk1FlK4ttvVZaq+5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7399
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAyNyBTYWx0ZWRfX+O3yCkZbITae
 EOtZFBFvLPX/ognRXsIAXcm/SxBboDfo3dnkpRwueVXTm/wnxCcNP6M/cOAkOQO4D0inkqseDHK
 LiTu7zOSHpzzQZuGuBlRzfdtwtj5RctOrnEO0ghP/XtDBcAEWDYro1aXaLuc8R8U1m+7BPr++xy
 gY/QXaMl5hxVOdqLeuh0jX8QTcSacWQeBhKsbPGKNoO6IY/i393FLlImcRMz5+zjrfMbNAy+X2Q
 ZAeH40KOBG+3NwO0IlcSuiks9NGqVfjgT4s8hi/VSpkv2WBPVgW2xCa30HfBW5uRRN/M7e/8pjs
 nqeHw9uwQOlY35Z0TMNyssgPUrC2Z+4h4d54enYiySa7TAAWcuK/RdIhZvm4qHFRfLpXzLyIHyv
 l8LZf9byVRJiXTOakSHaOJYLf6PYoA==
X-Proofpoint-GUID: xWje1UmQBZxBwWO2U6X0HSlYBdsKauUq
X-Authority-Analysis: v=2.4 cv=M7NA6iws c=1 sm=1 tr=0 ts=691fe241 cx=c_pps
 a=BVsloBwAbkGQNof//kbw+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=x7bEGLp0ZPQA:10 a=Nz8yn8fW8ScA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=J1kzD1WNnL91chRFdAwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xWje1UmQBZxBwWO2U6X0HSlYBdsKauUq
X-Mailman-Approved-At: Fri, 21 Nov 2025 05:08:05 +0100
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

Hi Yao

Thank you for your response.

Thank you for pointing me to those patches, I will target the Linux image f=
ormat from now on then.

Thanks
Ivan

This email and any files transmitted with it may contain confidential infor=
mation. If you believe you have received this email or any of its contents =
in error, please notify me immediately by return email and destroy this ema=
il. Do not use, disseminate, forward, print or copy any contents of an emai=
l received in error.

