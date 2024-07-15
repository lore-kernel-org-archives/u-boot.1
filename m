Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C039C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3695C88898;
	Mon, 15 Jul 2024 20:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="IYZpPAnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018A688820; Mon, 15 Jul 2024 15:33:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA4F88887
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7926f054d7=benjamin.baratte@st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FDCpuO030197;
 Mon, 15 Jul 2024 15:33:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=STMicroelectronics; bh=vvMc24JNXYppD
 QvTY16xqHKlD7quR7UM1S7G0qs7+ac=; b=IYZpPAnwJkhXVRRqykra6G+EMM9Uv
 MZY5CwGmqRCb1UA3xipLIhCkmpGy9kSAZjVyhjV5dBVO49dbf/+MNcCDt4Fi9hWO
 R4RlTZeS2hOZpB81fciMSQJila1OGs4BXE02veeCVDUWrzXrRZWTTrcRcEfcZOVr
 MVtBr29DFTHkrP9qBWAiK8m61uyoNgdlMRZvYlpQWfJ1O21XplDCvMkhk50/RCe0
 MPDSJIkGq2pkFnYnWGbVTwU8aR0jMp2aEptfOwa8ngPK0xbLbR4rsPST/CxKpROH
 xCtmKA24KC6V1IaAABu6q/aRdIuvhSCHafuDK9y6Ywy1Tr++Wx7zL3VRw==
Received: from eur05-am6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40beq4pye9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 15:33:22 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCbHjoF3FFtZ3qA3lFBK61rkikq4q5HX9dGAKWMbz1ir4reHVxLTHn1cvjRMCNYeVItYM9rCeu+UMLyTLrBjzqYgbBuJ3KGINvYRO/3GDrKafynKVMzrMZEzH16Si3QfJQEdKDv10PjxW9IWouETlOevrTgYThqnfhhRmvTtUQGB4+n28SvvZzXI3ZEIQfpE5/D1Zw78LX4q/P2G4aG+1i/z/WR8xuM4doczVTCsqXTclYSTL/jPrtcg0+Me71G+rfCS3lbSKoMaUZPLYwvWXWKvawVVKQ1dkF70gOp6O4WYA7gGMh39Bj1ZuS7nkD44o/kt0PggfD/rQDwKbffnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvMc24JNXYppDQvTY16xqHKlD7quR7UM1S7G0qs7+ac=;
 b=viatyJ9U3jSHQ6lRxbBkzHyFJTBjo38CZ9oq8oLAJITEa1VCdtGpLmS0chGyaByUzLBoFrVRemaGcDbRNklmbEXQvfx802tG/05UGgm1s90Jl+iRKhd1ZotQumGO/1SAZNIlqg9PamNrMrqTE9WG7SEDJ8XvW8kEBiD0nesHxCfipPhAiYArxFNaedvYofyAGIOhyXhqIOZrH04BYDR4cMM7Ibp0skbMXNachjTqs04XupC58YTktYp/b0HluVY5F3nStM9HvNzrVtNd4sIGFMiZVpxM0j5n6bGbo8Bl8r+EjjED1fPMgcvULSwtzfnjO51r3c/00RYBGU+zrpjpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:33:19 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:33:19 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "kojima.masahisa@socionext.com"
 <kojima.masahisa@socionext.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH 3/3] tpm_tcg2: hash algo optimization
Thread-Topic: [PATCH 3/3] tpm_tcg2: hash algo optimization
Thread-Index: AdrWu0AvS5Kdp+k6Ry29qYWchaTU6g==
Date: Mon, 15 Jul 2024 13:33:19 +0000
Message-ID: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=7b156ef8-37c6-4eec-9135-7627dc6c7416;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-07-15T13:30:25Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|DU0PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: 617f555c-1d4d-4286-3aaa-08dca4d2b0af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rQvJ5OiFlY1vs2ke7YLsujLWEBTYunda7sSbg1beaeNFbG03jwQUjDunnS1A?=
 =?us-ascii?Q?8NGsGFl6IG8ml2L4YA4qYAG/fw/l5zf/w18KefCoKSt7RjWhhP9s2oycqXTc?=
 =?us-ascii?Q?2IJ/IvqWD6lIhSTMrUXxLd5ZDCQHdD5FGeOBajxgPEDrcXpbkv6MqNjO4E9P?=
 =?us-ascii?Q?j06X61gTZVmK+B2o8XsKev/Cwbdnz5a9ZBxazSFexdYXXaugkJ6pgTn52IsP?=
 =?us-ascii?Q?FR0VXetLupp+wQ6nHMGf3z6L570EMSX2q9jKtJAJIZmx0eXOvT0QBYEPKTEJ?=
 =?us-ascii?Q?ezE4GJjaZmNvbpB4mXyfyGc6YQHvJB+46TQw6UWnay3ttfRM5Ha+csnY4iAM?=
 =?us-ascii?Q?u4gu+niJjMSAygLm8iNAIfCm+QGH83Jl8nVE/FOZdmEY4XsiIi5xN43fajCw?=
 =?us-ascii?Q?4Zm7UQ/LP1HvTOtqFvDOsAAAJA6u+7r7TjA6DyA2MvhhZwwqyPkjXlgar+Ep?=
 =?us-ascii?Q?1WPz38mxKeFCZi7QWtAYDpV3Fiz2XEgLyXkLaYpKOt9t3Q3gCakNC4CWHNUL?=
 =?us-ascii?Q?/THxccoxYYZHRQj17MXsTl6BK2V9bmPw7uFiux/o8tZYVlPwQuCz8Jsg/3YN?=
 =?us-ascii?Q?busBvuloi3OJW8fiiaN21zErscf0f1eXhLD9b8uxAf61jpwboOl/Fufv0FI1?=
 =?us-ascii?Q?L1yI0OAm9FLnJgzYh5GPb496THK9fWLnFm04GjaBdbIH0H0epoX+VEYU8kQp?=
 =?us-ascii?Q?/vNGR6Az33Y76GrEJo77xLij9w8ceAnG66QjZpxQCxQ9rkXZ0uwaQ+bG9Ffu?=
 =?us-ascii?Q?5sKmUXXLWkZllNVYMoZONAtwYnkClZyqZlPiGFN1kzqCF4tieL61IBOebDdV?=
 =?us-ascii?Q?PmYi4hp2alF+Bbg4IB7PZatyNClCfEYhHblDk2bV88F/H2txl6ERjwFaJPEd?=
 =?us-ascii?Q?Mb/Ju/d05piWFAz3uSft0YZpqF3KgtV+BylpbKFgxK0bgBwglVJ7HhB0/+Ps?=
 =?us-ascii?Q?D2n+9dwO2DnKBVF0v4xn9PX7r/8z75IOzjlvCI2hh/Wdr1QD2041B7vQ4XHj?=
 =?us-ascii?Q?4Rz5/OGKRluByjhK7BOtkBvHx+1BUb5jcVt8dBYHFWsIuT89WfZudgoFxOS7?=
 =?us-ascii?Q?Y2Borz2EEymJekbIe+O+dU1kmtH5SKMTS2gWOvSq0xoe807khKJ0HgJrgTe0?=
 =?us-ascii?Q?sBZX/xEpYfWWBqJVfvDtv4PVYX2Dyg4LDt8tO1BojUQA0XiRLn3Mq2Xk/3mB?=
 =?us-ascii?Q?3pgWSiTtRJefs1kH5yo5kc+2mqN18KONXhQOMDR5dE0iuXtKfwlUm1r//Hm3?=
 =?us-ascii?Q?8cZtyzICwjsdzAMnw0Aui1bEQm/U5tG7Sz0MCJtaHUuoMEplTRzFTa+ilYWO?=
 =?us-ascii?Q?f1B0paSQp9eXwIByZrysNial1KCUI47/kT7GtjpDW7LEmwaJn1A0iExzglFL?=
 =?us-ascii?Q?Z1/Zz1pdig9a3geAzgdp0zW1WM8LHXJ8cSirkh3wARTS/352Iw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UnDjL63stLEzgPQltqOsTCTRU3quW4PVQA3VH4TGj+Y9YCYmDpPKh7h8tLNg?=
 =?us-ascii?Q?oPlAX/cTiI9kzwEfJBg6TOrkBtH89P4vygWtfJyIxOlHgsimihBH4mPjjla3?=
 =?us-ascii?Q?9EuXAZEg5zNa3Ylyjite54GekrJM6ux1/07Sn8+PqViOI20k60NAPXxGCfnQ?=
 =?us-ascii?Q?0ecp+Sf/wiFhwIqW9RTfvmH5cfJSRs6L8ikCdpROMOodFuFqpt6JEpypEOgB?=
 =?us-ascii?Q?BB3odJflLc98gBOS2/vOGOoqjps+FJOz9pLXhxzSwZnmoT7r5jJ2FMEgTioc?=
 =?us-ascii?Q?nMyOcxw2KFg5ToGi+AJOJ5oS1YS98z2Eojahx69wC4dsQPTLKts2uusMsNIL?=
 =?us-ascii?Q?MFDSKGGCSvp+RvgS76oihDzHIY4eYAVsWwQNWd0SJ/8ZwuX+pJ+eHb94tep/?=
 =?us-ascii?Q?hxUGZkxEIZBMce3KP/l2JaFNkv8QdGRkSRrW9UD/P8VnTh2sUdKTcI7gjRso?=
 =?us-ascii?Q?vW92pPYRFETy4IVJWUpcwBafHKuztHb3qb61eWx38BuIH9YxPEKp86DXiviC?=
 =?us-ascii?Q?I3GV2itxyu3ocxu7sfZrdOYyXfXEymMpnVr4TEk6ZHdY4eVUWwlFrZ8Z8UxZ?=
 =?us-ascii?Q?orFmOSMeggf5UDMRpUPBsXAupW2DBLJlj6Ra5vuxU1h0UZ5lKSPLfa5gOmh2?=
 =?us-ascii?Q?uAjjerxvUGjb3E83kZl72tFuJ4DvYQKuTx0WZIySGxGlb6BBitRMBYvWuye2?=
 =?us-ascii?Q?isFrp9mqvbBF/NgSq44T1meSEPaiVET9ieYOH7jL0npcOhIsgwooFrZOjoAB?=
 =?us-ascii?Q?/azuAjbl7uAcM7/C83fxe+3esLASjWs4n7hTlaFt3qlMmG30si7KTAi/Til+?=
 =?us-ascii?Q?mHNM5+A7O/0w69knHejN3lMdDKcr7bU4pWslVDxG0Xa898tiRkfb2EFuoCz4?=
 =?us-ascii?Q?yCUmgaSe5arSXTl4ZHIIVF22cKSp12y2G29qahbO4nZonDW+tqQ6CLthW0cR?=
 =?us-ascii?Q?evE44V2sKcH2Oc8bulijoXZS2jPU1y1PavPBZpMCAGngL8cUU8cZFQVYGlJX?=
 =?us-ascii?Q?nFb/39r4JRv0W+r7k9u1RoiaqCLjXj5QL2c9JA+6bVwsYtqhGO+iwAdaEaI5?=
 =?us-ascii?Q?3H2vdBpI3AEg24qA80U5cGLpXqfu0CIn5OVpQSLkOFhyyECbuOKaagGvCS9T?=
 =?us-ascii?Q?aClH2SPfBc4bvjNqD6r1bTP1VL5oz+078gAtmv68JlMYpxn+WXbdGCbMJTul?=
 =?us-ascii?Q?KY6hvsM9x1uJGibBKn0mgTrg4BnCCCLQawaYTHsPnr4nXJirXgvnqRahrC7M?=
 =?us-ascii?Q?y5M42OgVK39oHEf4AKEb33E56y5/F5TsQUJ+05OnIGEOSzhJ1CrX+ckSgyAI?=
 =?us-ascii?Q?uFcIHbVKQ6uttx391ZKQrnHOEy3W9jMAu9wfMQxDcwbxkoBQqmMxXk9CNCuf?=
 =?us-ascii?Q?82TLWiIMAEgn6wxCXAx0VLZcactu8otpT9bwwz7dJmzlt4NYRcoMm4qukSeb?=
 =?us-ascii?Q?S4dEwZ/TrGDRLMmGtmXO/ttLJI0dGrNwTqFnNg3iaWrUyXDoO8QOH+OohUzb?=
 =?us-ascii?Q?AOYwZACgRwjpu1uKVu97nfkpoLXY4nyJgSCUjOD4gfNZK67RP87PsBRUxK3c?=
 =?us-ascii?Q?vmzZJxvnxXumHlz3QaUF37nd6J4dIkXI+CNjcr+F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 617f555c-1d4d-4286-3aaa-08dca4d2b0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 13:33:19.3991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4TtL8HiGL/lYDwr47i8gJqJNgQ1jDG/1Bvxc78XWdiziJJ2gGPftWcZ8B+j/PIsms5+2mdOJ9uvdYbVB1s1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120
X-Proofpoint-GUID: LIK4Kdwj4pzqjWBJHzLxb5razp0NfNjm
X-Proofpoint-ORIG-GUID: LIK4Kdwj4pzqjWBJHzLxb5razp0NfNjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150107
X-Mailman-Approved-At: Mon, 15 Jul 2024 20:14:57 +0200
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

To properly enable code optimization with hash algorithm, all the
reference of the hash algo should condition to hash enablement.
It is possible to fine tune the list of hash algorithms based on dTPM
configuration.
Therefore if dTPM supports only one bank, on one hash algorithm could be
selected (TCG PTP specification mention in case of single bank support
that SHA256 must be support and default value)

Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
---

 include/tpm-v2.h       |  8 --------
 lib/efi_loader/Kconfig |  4 ----
 lib/tpm_tcg2.c         | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 9848e1fd10..ec3504de44 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -285,38 +285,30 @@ struct digest_info {


 static const struct digest_info hash_algo_list[] =3D {
-#if IS_ENABLED(CONFIG_SHA1)
        {
                "sha1",
                TPM2_ALG_SHA1,
                TCG2_BOOT_HASH_ALG_SHA1,
                TPM2_SHA1_DIGEST_SIZE,
        },
-#endif
-#if IS_ENABLED(CONFIG_SHA256)
        {
                "sha256",
                TPM2_ALG_SHA256,
                TCG2_BOOT_HASH_ALG_SHA256,
                TPM2_SHA256_DIGEST_SIZE,
        },
-#endif
-#if IS_ENABLED(CONFIG_SHA384)
        {
                "sha384",
                TPM2_ALG_SHA384,
                TCG2_BOOT_HASH_ALG_SHA384,
                TPM2_SHA384_DIGEST_SIZE,
        },
-#endif
-#if IS_ENABLED(CONFIG_SHA512)
        {
                "sha512",
                TPM2_ALG_SHA512,
                TCG2_BOOT_HASH_ALG_SHA512,
                TPM2_SHA512_DIGEST_SIZE,
        },
-#endif
        {
                "sha3_256",
                TPM2_ALG_SHA3_256,
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index ee71f41714..512fb710b5 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -405,10 +405,6 @@ config EFI_TCG2_PROTOCOL
        bool "EFI_TCG2_PROTOCOL support"
        default y
        depends on TPM_V2
-       select SHA1
-       select SHA256
-       select SHA384
-       select SHA512
        select HASH
        select SMBIOS_PARSER
        help
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..66573b838d 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev, const u8 *in=
put, u32 length,
                       struct tpml_digest_values *digest_list)
 {
        u8 final[sizeof(union tpmu_ha)];
+#if IS_ENABLED(CONFIG_SHA256)
        sha256_context ctx_256;
+#endif
+#if IS_ENABLED(CONFIG_SHA384) || IS_ENABLED(CONFIG_SHA512)
        sha512_context ctx_512;
+#endif
+#if IS_ENABLED(CONFIG_SHA1)
        sha1_context ctx;
+#endif
        u32 active;
        size_t i;
        u32 len;
@@ -114,30 +120,38 @@ int tcg2_create_digest(struct udevice *dev, const u8 =
*input, u32 length,
                        continue;

                switch (hash_algo_list[i].hash_alg) {
+#if IS_ENABLED(CONFIG_SHA1)
                case TPM2_ALG_SHA1:
                        sha1_starts(&ctx);
                        sha1_update(&ctx, input, length);
                        sha1_finish(&ctx, final);
                        len =3D TPM2_SHA1_DIGEST_SIZE;
                        break;
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
                case TPM2_ALG_SHA256:
                        sha256_starts(&ctx_256);
                        sha256_update(&ctx_256, input, length);
                        sha256_finish(&ctx_256, final);
                        len =3D TPM2_SHA256_DIGEST_SIZE;
                        break;
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
                case TPM2_ALG_SHA384:
                        sha384_starts(&ctx_512);
                        sha384_update(&ctx_512, input, length);
                        sha384_finish(&ctx_512, final);
                        len =3D TPM2_SHA384_DIGEST_SIZE;
                        break;
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
                case TPM2_ALG_SHA512:
                        sha512_starts(&ctx_512);
                        sha512_update(&ctx_512, input, length);
                        sha512_finish(&ctx_512, final);
                        len =3D TPM2_SHA512_DIGEST_SIZE;
                        break;
+#endif
                default:
                        printf("%s: unsupported algorithm %x\n", __func__,
                               hash_algo_list[i].hash_alg);
@@ -236,10 +250,18 @@ static int tcg2_log_init(struct udevice *dev, struct =
tcg2_event_log *elog)
                        continue;

                switch (hash_algo_list[i].hash_alg) {
+#if IS_ENABLED(CONFIG_SHA1)
                case TPM2_ALG_SHA1:
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
                case TPM2_ALG_SHA256:
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
                case TPM2_ALG_SHA384:
+#endif
+#if  IS_ENABLED(CONFIG_SHA512)
                case TPM2_ALG_SHA512:
+#endif
                        count++;
                        break;
                default:
@@ -337,10 +359,18 @@ static int tcg2_replay_eventlog(struct tcg2_event_log=
 *elog,
                        algo =3D get_unaligned_le16(log + pos);
                        pos +=3D offsetof(struct tpmt_ha, digest);
                        switch (algo) {
+#if IS_ENABLED(CONFIG_SHA1)
                        case TPM2_ALG_SHA1:
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
                        case TPM2_ALG_SHA256:
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
                        case TPM2_ALG_SHA384:
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
                        case TPM2_ALG_SHA512:
+#endif
                                len =3D tpm2_algorithm_to_len(algo);
                                break;
                        default:
@@ -450,10 +480,18 @@ static int tcg2_log_parse(struct udevice *dev, struct=
 tcg2_event_log *elog)
                        return 0;

                switch (algo) {
+#if IS_ENABLED(CONFIG_SHA1)
                case TPM2_ALG_SHA1:
+#endif
+#if IS_ENABLED(CONFIG_SHA256)
                case TPM2_ALG_SHA256:
+#endif
+#if IS_ENABLED(CONFIG_SHA384)
                case TPM2_ALG_SHA384:
+#endif
+#if IS_ENABLED(CONFIG_SHA512)
                case TPM2_ALG_SHA512:
+#endif
                        len =3D get_unaligned_le16(&event->digest_sizes[i].=
digest_size);
                        if (tpm2_algorithm_to_len(algo) !=3D len)
                                return 0;
--
2.34.1

ST Restricted
