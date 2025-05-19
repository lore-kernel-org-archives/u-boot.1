Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C333AC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 09:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEAD81E72;
	Mon, 19 May 2025 11:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="cycwPU6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33BA81F66; Mon, 19 May 2025 11:05:36 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6EE803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 11:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5sw6v012847;
 Mon, 19 May 2025 09:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=Q+uM6myxPWfw1kyB0OODnwf3JT
 OXLm563Zb/YxQ5aJM=; b=cycwPU6MZJdv7z/+0xWFJoYRR6r2yBEU7WaM66rUcG
 eHOJcLlOGkanE+L9+hlZmFAnqKsjS1fkS3hVPYEBEwniohOwfGqQ4Ylu4N98Og0T
 9c/6zfAxxwGNIT1CMf8gpoq1OYNKfdEPuf4bp/2j36VSCbKtexKBTcFa8aqZOnnl
 eXAVR04JQTMXP3zjrVbh97l4csCX5mQRF70yCBvND/oyWbh5aDHJotbUUdqw48EE
 fm19Cm+eMA6ZFDnWefmhSqZgPOc+75W33mMnXrbxrolvWJ5dTX5hXzn8bGuuUFpz
 6PPJqEXAR/0ueMfiaWvLWdQNeeq0hf3jC1XR43Y7XDiA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46pfy8dyfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 09:05:28 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 85F1980044F;
 Mon, 19 May 2025 09:05:27 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 18 May 2025 21:05:15 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 18 May 2025 21:05:14 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Sun, 18 May 2025 21:05:14 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 18 May 2025 21:05:14 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSxzHa65KmSw7P9VKFURz2iIU5PN13mn4lC7aOMG6QLEhtE3hoaTgNmeXFae5553cWDcQir8Em2gic0TszuPL6Bf6i1McJcGaW4yvnmVL2k1qqu0vJ4tcnpJnPfJDUzzCB4scIn/05wPs2QQicyvEkX1DV6N0E5yWvnOh5iFQbMp5MWWr0f8ynsyoYRJxAhYOn6PuWxBWhlIZqmvCnQMQbfuztaIg47ayHLszJRfE0Tw/Pb5EbW33EqrlyH20p+agbsLK2gC1MeecDKOaEruIW5xfS5nIjgR5YE6R6AEA2lc63ro8M7dtDZe2YLvjFVdYo7dUaDk9ZLJHdnzkgx6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+uM6myxPWfw1kyB0OODnwf3JTOXLm563Zb/YxQ5aJM=;
 b=qq5RpUMSlDXq/tG03P1gMFe9RNfFumwmqKIzoUGOfKCX1ufzGMgwnTJN7cubDbTAmq7a6xiVYCnojYFky6klhK0SjLK8KVsHa7KCMZGSSQnGFKxBz3HCCbXj/pwL4IR8WDA4DjtcPGuRI9oC2JOiQ2t+Mrcpev7xbkO8OeLiomWu9sJnRd+wJtqZ5X0H/EhkSh0Y5p4roQVG07KWzCzTbNFsaqK7f0fmvTtadXyXrP0YTxHIOkKNoDT0zBr2LVLKkO7IrTiUqtBfhI0ZXsYM70MLohhEnyxV9zZHk9YUsge9YgfVKqbYbAQkPfSPgJ/eU6Q9angmcfuVoYprl0NjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 MW4PR84MB1585.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Mon, 19 May 2025 09:05:12 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 09:05:12 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Topic: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Index: AQHbwp7xIrnosPKZPkmFc0YqeiDvV7POpWqAgAAZ0gCABP0MmoAF8FWAgAAGdeE=
Date: Mon, 19 May 2025 09:05:12 +0000
Message-ID: <DM4PR84MB19761284E20ABD1F1F8ED8C5D69CA@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
 <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
 <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <8e930859-c73b-4bd8-b58e-474b3e70e15d@cherry.de>
In-Reply-To: <8e930859-c73b-4bd8-b58e-474b3e70e15d@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|MW4PR84MB1585:EE_
x-ms-office365-filtering-correlation-id: c322c035-ff39-4b9b-494b-08dd96b44319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vTA3k4uQkPe8tGPPw/gALFqSfgwJ4b42cMflaavzX9rhpzLr2qfaGcZCUNtc?=
 =?us-ascii?Q?5XJLbNeX/S9V5WF4MjKCN2BzOkT+AhwFRQqCQF3NH5jkgFdtvWQOGNfb2eHa?=
 =?us-ascii?Q?uCXqXOATHFjHMMJOQAoHf+XN8/MeLJZv6ZrlUy9/U9mH7eH1prqfVHS2XXTs?=
 =?us-ascii?Q?FQylsK4/zCB55gEEeGQfWlsIKYbq3zJLC7uVMGakbWu03EQKxpCFqmGGHJTh?=
 =?us-ascii?Q?cXJtPkVF5nYaEUN4JOx23vocxofAus8Omm9f2oHWLsCG5hQSkyWKO2eV0vmX?=
 =?us-ascii?Q?BWuShKFgS8COF17Pe2ltGNXHCxtCGNGmrpbpBmdfqxq4UI1f9Srfdpp4j2S9?=
 =?us-ascii?Q?jdRV/Ilv+mbxCUmqkp1ea97IYO61xATIsCOkLDUGWih1GnL/arty80nD4Wko?=
 =?us-ascii?Q?Z3XV5cab+TJfzJdiEsAJ8jEtkDZ1llxO8jj+HMXi78Eo/sti387pE12HkaLC?=
 =?us-ascii?Q?OCbq2bcidaql1Bb9fwXJ8wM+4AhJvFwb8uskC9cE7mTb+E+t2wr2/d8q4r3w?=
 =?us-ascii?Q?xMWcO9azvmtiBqReuFISNjA1hVsc8jRmTBAbHS+/mmsFdlHcGP3BuaxooKOp?=
 =?us-ascii?Q?57YDGw7xC4GlLgOv/SIp8QyNZK84hiiSgw3WXnBKauKgh0aEqFkVO37eqhhh?=
 =?us-ascii?Q?rrWznxpFdYJug0mjA9GoGwq5gM7mofrrOr2CtiTk7RiMSexIhnJGUxWYDE/S?=
 =?us-ascii?Q?+aENPuu1/MP0Hfi5+Lvl+TA2okk3JTLZGHLQnR6Vxtgy3aWecrqGRi9fzuKY?=
 =?us-ascii?Q?bZC5akict/m2vT1UlUO3lWxslLuveLr7ceCafiUQAJc0q3WrSKXiorLYimZP?=
 =?us-ascii?Q?j0bYpxu1sxrLr5r1YGNo7r7l1T9x+osJuotVW+l6mg7oPvNW/b/lavY6MgyN?=
 =?us-ascii?Q?L1JtCQbXjQnipR7fDWMOAmlmsup5n2GusmegZFdpyIlguebJbt6JxLrhERVe?=
 =?us-ascii?Q?UyxUge5fhuDuM2orK6W/de0WbnkGDmzFPrR2QaJ9WThcyhXaeDic+KmiW8oq?=
 =?us-ascii?Q?fmMtsZQXb8cPQqdhr+DEovB5SFMay4gaU0T1U/BeeqOI5dZYEmezxxLCrwQ5?=
 =?us-ascii?Q?89XTuEl0UC7vTC7eKQqme6luTLT3opcG4NJh/cTBNpoXTsibwje/qUHGJqIe?=
 =?us-ascii?Q?SKaoLwezxLSXjOVq3TY6B0sNXlB1Cuq+UgK2pQ0/+K/TFYELnxfd0/E3Y6Tm?=
 =?us-ascii?Q?pG2tc3odC/pzjNX6rvnxSE4hIYyAdD6oMTLVvzxuE0zlH9EqLkHD/AOydXJo?=
 =?us-ascii?Q?xeUf/3vmtXU9XOmqEmZFTrfMoIhK/dqMJ49B7OLHFg4hgT0jVD60KeCvZTQt?=
 =?us-ascii?Q?3GVdwbPN6uo2KBxw57ScdNumMSfhGzGd+/uzUNvn44enRZNscZK+YHEt/hvK?=
 =?us-ascii?Q?h7qF0NDpNuhdPj8j8zS1tsr970uNAXYnZTD6vs/GdIuevDSxBQMDUReJ1zPj?=
 =?us-ascii?Q?9riqQRE7ZrxKpmQAkzcLf3NWfViwS2m7wZb6+cBOlnGcO/LwoM1aug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eb6xQ9UHagm8OPAw0JdC+AbN89X0dLEsarD6rkI9UPri7iyVR+ZYxk1bJBhZ?=
 =?us-ascii?Q?xcafpCtcEaZMp0QvB5rzCg8pTJcqqreTErIpEy4rBcz4buYTSdv49MCGWWBf?=
 =?us-ascii?Q?Hep2STNqC/kF7dE5kZTJzoylgpmavJ+4RN3J8uq4FLq0FNegh6X4PSPQ3Igk?=
 =?us-ascii?Q?XcfNoO+VDP9U71strnHS9voWMzAd4FIoFl9Liaa0f2gxnq8BFW4jqyo/fgea?=
 =?us-ascii?Q?VQaC3pmz33CGNT2zjcxhyK519/aPLsKd7f3nk1ka1uA41s20It/zICjupPiE?=
 =?us-ascii?Q?Fccc7CDDNr5SROyKVfdJ/mCd2unfJEzX8RhmkgOycfYXE2ZIHqBWbcLDaroL?=
 =?us-ascii?Q?9c8SAsS1LVj2EsioN0sptB4VjNIHvKWq2DTUK+ny62T0VGDq4GQEmhQaXUzH?=
 =?us-ascii?Q?BF5LyNuxz0uZes5Aky0AQwahzUK6Xqdn0G4NIAMJt1j0EdBzWOVGrEvDo13W?=
 =?us-ascii?Q?01jY8N83LVdZ8vyCB8PFPB1M2I5nN3qQGdVGh9T8md2WO0GyepAB0tfi0gkm?=
 =?us-ascii?Q?oGSIISEe4NbAk5/QxA19SCY+KsY5Xd3QWaTzsGviVIhoAMRT8ph0K/9h6Fjy?=
 =?us-ascii?Q?AIBlSRJ0bc025cEUrsH+XAImN6fmY5Ffvmk8kzLt8L58adS5jEaINznn/AJm?=
 =?us-ascii?Q?Aqvdy0juHb2YaAqiTPZtplIFfnLpiutJq52OsZ0MEwh/R9XKzxJPKqCl1QQR?=
 =?us-ascii?Q?diyDZ3CpSggbh0BWZUQbYUrIfE+af1Znjs6tz8kro7KMntdjPVjj/yEdQor3?=
 =?us-ascii?Q?VbanmDe0tLKoQdO3mZydD52hvsZHvtY6e5Dh6g83K7VbGBU/Vglg6PovpElD?=
 =?us-ascii?Q?hVvmythYnIeNuIg23xhX4NF092uMtDa+7B+O8uCkT5CUM3kI8CoRoaQx6ATM?=
 =?us-ascii?Q?foTGxIWKsK/I6Db4Zn3V3VJZGBbH/+mbT1fSyc+D/ka1sHERTEhXnNA8sjC2?=
 =?us-ascii?Q?ZCvAFj+ZkzWs9UraE+ole9h2woHjNyJKrkFwLGUhU9Go2k47e57qDMRzBrze?=
 =?us-ascii?Q?LSa4ZwEOSPrd54QfpZEuTbxyp2JWiTHin95Pwp8MP/c47pBr7y0s0q8YB9kM?=
 =?us-ascii?Q?7kOZW6fkxA/70kefvPzl4eYIPt3qeWZeOLkm6Jb7/P58bl89OBWU1RfPNSif?=
 =?us-ascii?Q?M8I8caWTIdWHA286TQDrhJLgVpdx+eu3Nr7ZD1y+2B0CbeGN9QsCwxfoY/bA?=
 =?us-ascii?Q?Ff5o9AQE6c6/HYBv5oFTTZSaIERgqmMbMqjtsDObTriQSV943/PKWIbMNfor?=
 =?us-ascii?Q?5zAjcXm37ynWN8q2Z28dGf9G1xawTsZWaPq89VZRliE2LFo6qUaKqTwy6NSJ?=
 =?us-ascii?Q?sBkp1lJ88lvaxe8kWSayIDN0qIlFNB6xr7Xz9V0zA34fUS6fL/OzQuLKbQy7?=
 =?us-ascii?Q?mY/CMNjHWRkwNuQbSa1Spb1NFSje+sKoxErog08wwODY2HdGUiIW+XtCIVZk?=
 =?us-ascii?Q?ZUYr63S9OLbVQXzLYA7bD9CT2Rj/ee0fM+gL/YCkG8p3LQNjcEAjme+5/B6M?=
 =?us-ascii?Q?HA2QSWPLQOdUPmbaimU0XplGmjd6Es+4dVk+cDUavuT9W88rQOqF1FkYVmQ2?=
 =?us-ascii?Q?uLlDcZFtjeBAqFVsMvW3YINLy2Z4H+KUVesQrCqb?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c322c035-ff39-4b9b-494b-08dd96b44319
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 09:05:12.0221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDmoYT7tcmPSbVkxUGQHbCHzp8JcBFm4hsGZjNFo0coATXSz6k5vnEKNstTVJYLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1585
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=OPQn3TaB c=1 sm=1 tr=0 ts=682af458 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=9WsQpWsH5MFBPi-5sJ8A:9 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=Yi-kuNgvaSzpVX4W1tEA:9 a=yLdepWMXQ2UmjYoG:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-GUID: qpTiED4FJTFnQzutRO8pwKfLHQGClQig
X-Proofpoint-ORIG-GUID: qpTiED4FJTFnQzutRO8pwKfLHQGClQig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NSBTYWx0ZWRfX8ch0fjDzqseW
 BuDto8VI9QYTdfaBkLw7WiEH9kqOzan46IPGPt5tm/uUOEiuOCHn5X5BLSQlwtkvhuFdPhMrJcT
 BfQzN4aniiXPnfyHhsK4sMYdwXCjEDOQlOLCTzSkkDpCpn0hzATl8HwESJJHO9g7UZKWhAsZ+Yy
 eMv2BiooGucgQXwxmJOXL7quwlGLsLjkQR6TW59JxlOcN/KvIR7akxqYrG3t6EZ88ufL9SFbF2u
 fuhYe9j1YoJiizpMVclAncqqGWDk3x2zaHV81h6LIMKO0nSNloTAKZBxBYgTxGrJm0ovvGb03Ws
 Ttx5UsKH9h+SXbRiqsJl/pl+r0cfk9vJjPB1EXt+xSLgbAvhIeIET4wS1l6npIN5+2aDjh7Afi1
 u0bcdT/1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2505070000 definitions=main-2505190085
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

>> Fair enough. You could have the same ternary operator to better match
>> what's in the kernel.

>> Can you also reuse the macros that are in the kernel already?
>> W5500_SPI_BLOCK_SELECT, W5500_SPI_READ_CONTROL and
>> W5500_SPI_WRITE_CONTROL seems to be of interest?

I will check it

>> If you do that, please also update the kernel code to use that :)

I have a new version of the driver code without the _spi_read* _spi_write* =
calls. I think for the u-boot version it will be ok as it shorten the sourc=
e code.
What I loved to do first is perhaps to get the new patchset upstream in u-b=
oot and then change the cmd[xx] logic to a structure in the linux kernel an=
d u-boot ? Syncing both might be a little bit tricky. I also have some perf=
ormance patches to look at with u-boot (udelay call with a value of 0 is sl=
ow and I know useless too)

>> The benefit of using dev_dbg is when you're having multiple devices from
>> the same driver, then you can identify from which one the message is
>> being printed. You could have two Wiznet W5500 for example, how do you
>> know which one's printing which message?

I am going to switch to dev_dbg. I will send the new patchset on Wednesday,=
 as I liked to test it on real hardware before doing so.

