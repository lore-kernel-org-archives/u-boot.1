Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF67E7544F
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B3687138;
	Tue,  3 Oct 2023 14:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="NRHlcrBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36237871F1; Tue,  3 Oct 2023 10:58:35 +0200 (CEST)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F818871DE
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4640511bd5=andrii_chepurnyi@epam.com
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39332Wx3003099; Tue, 3 Oct 2023 08:58:31 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tg1ast0gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 08:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQm1CT0o6y/VWbTiyzMjtzd7aTqQFLZWYJkjcyRH3bQR7tr4rkNfqLu0yMlVmCv3yYHHajLwFdVqhQ2fhkIDuAzD5/crbgSMc7obRF4dn6qrOPYpiP9OntUeUcL28cCEhqSz8aeGBUIxFsg+5gtsYnJXxBLUxEsF7CHatDyWqwmjLXKnzWKuCOv1d0R4SHF6cbSqjaw5dnDVKxSYA93yaxc6dHU1T287xN7LOznXuI++uRHjRuaSqvKp1qWO3V7Mg6HF4f5XfxHzvxhtXnM9WgbCt6tI9yHJs1NeXbwxijPzUq5ZPC1mM9eD4p4fGwx3AhN792RdQjphIhgVtxw0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXbV3XhC5EAT7ruK5AMR8bHxxHP7tnwLn9IxQ2t4G3k=;
 b=SXPKLuJJb/1Dke5PVBvWIfsDZ/qqJ/v3LkJ8UESKnEkZZXSdDYwGaOiujhocF/E+LO1WOjXXzO02xmkI0X8lT3jE4mA3s5GRx71orsxr16Y3JaojdxnGaapQdcYQvh7DggBXlvhMV3/isHCFXdtBYGsHqbcfYuUjH6Y9WjylyP+yWyvseHaB3UjwJfnLTt1psyZwE4rdqRc1HRwIizW2/Q1GxCLQ2sxn6Xhv0PrQggPpaYa/Mrtws0ITdAl+Q4tWFqsDxnFUcHAAbuLc0170AXxQIk7unjTpVB1fEuY7hJFmFDj2C30G59B+655cgt/eozDMAeI2H0X8CUdAsGGWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXbV3XhC5EAT7ruK5AMR8bHxxHP7tnwLn9IxQ2t4G3k=;
 b=NRHlcrBiEiXdijTxeK04gzrA8CEX9ISDHbbvEzm8szPY1xnR7w0HDVRIIiPeOKegkRYOJTjTWTR0q9VXtjUA95pnCa5a+Qo4xk/vPKpj1YIpwT9S0aDLnmic8v0VhAUJdtZTHr1knBO6JmE7Z0EAC+JJQDIBDeFDeODSVPG0zYAkB65dTQ5cNwIa+Kto90biWya2NfrrujcxTwsq3fx9WkaM8XOXfa+Nj2We5ikyCoKi2ESfGoS7c0yXUVceclWQiAdsFtbCR/uy7iGJLCnxNorQpFwI7lzBjsw3jFQqtPPRqR0Hyj9hnsxTxZyIhIjK3ftAxfAVVv5V9CKfxGb9YQ==
Received: from AS8PR03MB9583.eurprd03.prod.outlook.com (2603:10a6:20b:5aa::18)
 by AS8PR03MB8594.eurprd03.prod.outlook.com (2603:10a6:20b:573::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 08:58:24 +0000
Received: from AS8PR03MB9583.eurprd03.prod.outlook.com
 ([fe80::529f:7d90:7f52:64aa]) by AS8PR03MB9583.eurprd03.prod.outlook.com
 ([fe80::529f:7d90:7f52:64aa%4]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 08:58:24 +0000
From: Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "leo.yan@linaro.org" <leo.yan@linaro.org>, "vicooodin@gmail.com"
 <vicooodin@gmail.com>, "andrii.chepurnyi82@gmail.com"
 <andrii.chepurnyi82@gmail.com>,
 Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
Subject: [PATCH v1 0/1] virtio-blk support for xen board
Thread-Topic: [PATCH v1 0/1] virtio-blk support for xen board
Thread-Index: AQHZ9dfDihyn1d/VqU+VsjO0H4970g==
Date: Tue, 3 Oct 2023 08:58:23 +0000
Message-ID: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
Accept-Language: uk-UA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB9583:EE_|AS8PR03MB8594:EE_
x-ms-office365-filtering-correlation-id: b6597277-dcc7-4dbd-fbc7-08dbc3eee678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tBCC3fBV3nE35cTIOWZbbCMps3PdIKtXxaq/Hkswd1WqSbcxLuRiW5gkSnzqQsOyks0ag5di2TG+YwGTBJz+gxj8MeFXu6xq8KtRQOVUuEj0WuWY74Xgokea3RUDGZSgZxLfGPewlrt2QZR7ucIXvKFHYIBKFSHiMpx7zDuuvRZfUsIcRdRi3fHN+tEl4St+1lOH3CrlKnVWpnneJGNLbMxzW63UzBzP8Te9xguhK3Av2KD0xmQaeHKZgaiQKxAoxwhO6aOwhzxDoviBaO6oNmnXYbcrmQSQpUj4YSFgo8XoPDnszfBaC1nodbCk1dD6XM28t7T2yaU57Sfq97f8hh+IaUAYi6580wBA2LM50PJDvo3Al7O+S9eMPg5x311yyouoK11HqNOR1npR9aHLzX35iaXTsWjNEgQFHE5JZ38LKLqX72th+fc3q0SplVcHDgPo0mb8OJq8lcGMi8t1CCn8vKAUPepSxgJVQJYXDgtMEGSfoGjkhZKJc9cDaM6iHm0w0KAMq0GsMBOpfvzbywiP6KhQOZJV0T7STQVMFCp11vXeYY9fgn1XNaQvSUeFatKMPSLJ7IQtZENLiHT2S/JSF6PvKTSjC5GdWh0gAPjOrWAQJI5rTaAnBbF/99p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR03MB9583.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700005)(38100700002)(86362001)(122000001)(36756003)(478600001)(71200400001)(6506007)(6486002)(4744005)(6512007)(5660300002)(66446008)(2616005)(107886003)(2906002)(76116006)(66946007)(26005)(66476007)(64756008)(66556008)(54906003)(6916009)(41300700001)(316002)(91956017)(1076003)(8936002)(4326008)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mrbuYljUWeyt7XI3AnbvuciWcMlg7hsAqYq8YtarH7+9u8DCOoGIBV1eKG?=
 =?iso-8859-1?Q?8KL2lUBv3UYM9L0CPnRazqW4oyo4DtYUEHGRxbupLDqmRuOAR6Ny/ZbsF/?=
 =?iso-8859-1?Q?N2Ql6Zl/4DlzcK2V06i+WDXBVgRnM9BUxmGHx/VkImgU+jXbZMtjsuM0uF?=
 =?iso-8859-1?Q?OG1Yge5dBZUOi9kN3AwdcAtAmt2178oQpa6u9uEMmyzksbwNY6tOjr9+Ff?=
 =?iso-8859-1?Q?2Q8ZzVUxKNaF6O1EewPKIrYr5sGILjWaXkNz3JGwfIvAoFFQd4yAhwuBdE?=
 =?iso-8859-1?Q?1gVlFmqcrhrHl2hBMn5FhF2smok9y8AH5UwvvY73TZSvhKYXaiDcoh728j?=
 =?iso-8859-1?Q?YhB/ASX0aowdOJpFolC2XOFfjAvvZmdTfza/OQoZly92KKdN1KptvOkFjp?=
 =?iso-8859-1?Q?MOvvXcASWC3dsLfsoBX5f+6HktWLkBnJTL/Q7zCGAIiPAX5DJ0qePe6cZw?=
 =?iso-8859-1?Q?k/iC+M42QSlwDL/YupYaUzwsCZVvXs7cT6+T5eJKHAuFRSkkmAhiGW0MHY?=
 =?iso-8859-1?Q?UPgLNXAegyhttm1dq6bgXW021Yst70mab9XyBqc/qHgoKF/nmOydbUovjm?=
 =?iso-8859-1?Q?jJmVd2C9rsoKGX5chJ2ruXYXu1qvWC6QmNAyx0vHhmoQxZVKKFA4LaR5KA?=
 =?iso-8859-1?Q?vJuyHf+Gkh9R86qUIensgUlfHknSkcRsjo0jrmDYWhWC9PwyhGx+1bHL/X?=
 =?iso-8859-1?Q?HMZ7GQuJSV+6MmZwcCfVzpihkvVodclzedOi99ObcPWqxi8TJlj0gUevAH?=
 =?iso-8859-1?Q?ZbdanKnbQstABgNnke/V4ErjiHoC45aizdnS+nH9mHTGHcImZKaBUInaDK?=
 =?iso-8859-1?Q?GqS0SDNRHp5uMp2nR1LRvmKLTVPfj8vDDX/uki9jDLB1uBGtC2o/Ql9yD5?=
 =?iso-8859-1?Q?FTU8L/q10A2U9psxg9o+VNnN0MShbsiUFHOgSt43nbnnRThFI2VLfX2YOW?=
 =?iso-8859-1?Q?3jrBl7gb5klXLta9V612LAP/zzYDSO1tD4kagydZBLLaO3MTXjGAair+ol?=
 =?iso-8859-1?Q?mehVtZy+Ujy3X5ZR6zdlub9tObl6SyTp5KsPxex4q7Up32wqunp8ssHRS+?=
 =?iso-8859-1?Q?eHSPO03qWf0PlTfxVp/L+8WsX06hdlIjDe3t0INqlt/Pyh0KHEgr/UOziV?=
 =?iso-8859-1?Q?MIHv+NRokYA5V94bNLhXFy1eD4tTEk9keDCIuuKiSXXMXteHgVb7JO7gW2?=
 =?iso-8859-1?Q?vu+CwKGnN6rvYjtoEOVAciN6WTPosxAoWA/jb5s347XsuCuUDm6CCAaBp1?=
 =?iso-8859-1?Q?N6ybLyDms5GblC+HxAADGVKO2j96xXTHwMaM/JaBebA/fzoku8Slif+LmT?=
 =?iso-8859-1?Q?xJiScOB0NwP1OdwinNHIRlrYJ1WA2jTGoOGfwPPVE8uVOWl//1j/fc6xkf?=
 =?iso-8859-1?Q?5uPsKEAko60az1A0LFo6oCQo+XnGUPR7Iqevs/kOI84uYv2jtcfunzbCTV?=
 =?iso-8859-1?Q?fwJzEmw3qWPEVyKln9dRN75fS+UD4X6KGzX54h89iECXcG6+4LWMgNJFMC?=
 =?iso-8859-1?Q?Eex7msAunH3aU6Xwwf396hkd+a03HPUM2+cjhie4c3mudQfNMIjKRw+4+u?=
 =?iso-8859-1?Q?X8pw/qjFNZ0XInpXRhVGSd5uuMJINYTvj7dXES0ZQ/HTRR132DlHRg+fsM?=
 =?iso-8859-1?Q?2ezpW3rXEIAYTrNmY+rfNILQXPxwMi0jxWmxroDujFui08qmBrfBiyHQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9583.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6597277-dcc7-4dbd-fbc7-08dbc3eee678
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 08:58:23.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTd3uNZW7JCdjP429cS6FhoJDlWt4KqS+0Ec+9rOvS6xvNhjI0Z1tT425eGFqzf0feqDx+ijfpZrtWyUBZsjw68NnsYNVwHvw3XGeTWuKVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8594
X-Proofpoint-GUID: izoHInM2NKJIyqhIrU6aJxZrbSVdQr8z
X-Proofpoint-ORIG-GUID: izoHInM2NKJIyqhIrU6aJxZrbSVdQr8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=437
 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Mailman-Approved-At: Tue, 03 Oct 2023 14:12:00 +0200
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

Hello.

This patch adds the ability to use virtio-blk in the guest domain
under Xen hypervisor. To do such you need to build U-boot
with xenguest_arm64_virtio_defconfig.

The patch was tested on a specific build for rcar-gen3 hardware,
with multiple Linux domains running under Xen and QEMU
as a block backend.

Andrii Chepurnyi (1):
  board: xen: introduce virtio-blk support

 board/xen/xenguest_arm64/xenguest_arm64.c | 108 +++++++++++++++++++++-
 configs/xenguest_arm64_virtio_defconfig   |  63 +++++++++++++
 doc/board/xen/xenguest_arm64.rst          |   2 +
 include/configs/xenguest_arm64.h          |  10 +-
 4 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100644 configs/xenguest_arm64_virtio_defconfig

--=20
2.25.1
