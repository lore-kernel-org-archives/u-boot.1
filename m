Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70590CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930DE86E7D;
	Tue, 12 Sep 2023 13:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=ge.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A6B986E73; Tue, 12 Sep 2023 08:21:57 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C804C86E57
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=ge.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=Lavakumar.S@ge.com
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
 by m0048300.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id
 38C4sDM1044373
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 02:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8pdANxihBVXf0Kk25qn0gDLcDxpfQJCr2lK+iRdgryUFtHyo5FkcojR6d/CmrSzxut1/9K+cG8BCfh27Rz//mZMFFAkwhh9Ssjs+Ns54KTjO1f/8QqON5MAU2gC6RwLEbrIApBL5y3vxK7K8tYQT8piLrTx1UjbVec/E7KKJqYHajxFc8DgyCO6HuSOm3JAB6VrkXrQ5ZmaKI3dhLuWFgxegqWxNTrtLo6Q2HUjq1dtshD/GMiWe+5REgs4yhcxkeq5rrCEKsFpgdUj4N0VN9sJwnigUEfSp2opbU4X4f8jjgDOGNcKpe2n1PUMIsT52V97LKfp/Voh90ck+GOquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXI4X7s+aWA0Bv6aSeYq2QhCbBODN8jjXy3hDuytgGE=;
 b=j/ikoVzPIdZFpaB1ptNZu0kit7IZUOahsq43e3X3hvKGUJnLNU8cVslIX/GUhCPrWiqLo9+fVDbBPlniMjIdUoTxCsk5yDKOANK3jgmzXhUAq6dVeTWyt9nSzB+CWgb4p13AhqY68B8MGUBE2O/WOqHt53NN8vGlBdpLi5bfzbgMbauuc66mzUJe1mhiVvzgohSy/wdAOkDrJn8TPMKuUrZSZFkUSvb8M2ggkT1EYpjbw0G7tk+fbs4hGlU43fhQv17z1AKXqDIIO7T1RR1LwOAFKGxTZorOj+evYg8X/+8pgCNXgnMXNu933iZzh/WNJqJ5lAsKcuxvr8CjY/TvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ge.com; dmarc=pass action=none header.from=ge.com; dkim=pass
 header.d=ge.com; arc=none
From: "S, Lavakumar (GE HealthCare)" <Lavakumar.S@ge.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Enabling POST in imx8mp processor board. -reg
Thread-Topic: Enabling POST in imx8mp processor board. -reg
Thread-Index: AdnlQSK/279k8PqbRU6r24TwGF2roQ==
Date: Tue, 12 Sep 2023 06:21:34 +0000
Message-ID: <SA0P101MB0377EB3FB4EBD682FE97540490F1A@SA0P101MB0377.NAMP101.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 22ABCDEF54ADAF4B1311323D940D9740ACC5494F1F19BB089F7577D1AB9027D6
 0810FD5eJzVWdty2kgQ3U+h9M5GQgJLKZOqkRckXEtqZYcqoHgZXRCYq43IxHz9d
 vcMhsRRRMprxPaDRhq3oY/69Jme4XqRZPzTNc8qy0VTC1fx85+TbDHXKuumFn0cb
 TfJ02ZUq5l6w3Iaxoiv1zHP+OhpxRfTZTrSndi2nLBRNWuxWbW4pVftepJUG6Fth
 bzmJGY9HC026QYvVSfi1pU9Nqp1w7SqhgGOYWJGVTsK7atE12OYGvFFUs2STTZS3
 uavvI8C3uyamuVYulbJmpphmqbtXJk1B/5Xd4yGpVUmTe1+vFzf/7VYtYJ2Upsvg
 tvV4998/OhObkVTq0zjpqZVwnlTgw8JV/ApWiWawntgYK07v2fc3d/12p9v0h5jt
 50vjN10r/75lgRJf8iGjcjp8uUqGIrleqd/e0wm7pKNWZ75dJ22RJ5Di7GAuXh3G
 3iT+Ee/Wwsu7gPze4wH7ph5AxYK9yvzAzYM3Ofc770Yax1uUzkscfS6LA7cNWvbL
 GYwAp6QuXN8X4MA3qjXY4PU3TDPZgPhPpUSep4FL3c3akjwCnEazO8inq/M01lfu
 Dt8DlPMW4C4dsxLSwm5wNzDbUcOkneUB8DxwDwh4wc8HPPmzdS8jfgWpUT9S8vjX
 YR1M0b+Ad8miCcSEg/fzwt3i3UGfg+lhJ5nObwbCqibNtUJ1EsL8ewQT0y8S2G+l
 GhPsd/lXQ1xctRD1IeLxHUC7xS/AM8McUD96JgvwLmhPCJO+Uzz5A/zwxR1hfQSd
 LKD72eLejl8b0jFvIO4LIxvjToHOLeo54Bvgvnrox/g7it9vAA7gXdK1+D9D/F9A
 z5ap6C+QDfG+BwxyN/F2Nt5F+G65UeX01cU8I5TXigfutQ51POOwkvzEhfxMkJ/H
 fl3trp5bUW8W5GuYT6wfkjnWhj/oc4g7gTzg7xEf/ArEQ8r5l2KI+kA1M8KeTig+
 A91BryrY9449X0p+o0xT4AzY14HeUt5BL4K1Jd3t7fwDvIBcQuFb0d6TXi7x3U4U
 38/V95O4J3iE+QpCU7Rvxb2F/Qs523V5/6wP3m3vBXzbs+nEPl1gv5Rv9emfO3+4
 2BPs2Le7XUM9GF2yrpboi6QFfFuq3gjcH8r93uE6wL4lWdFvLMkz+C9A4+mmAeue
 HXeOH/DCni37wv+R31REe8E6bL4iU6c1s+WUFcFvIN4olT2B7Lf6WFeaF1KiJczl
 Tfqh7Lv6+qsQA6Ww7vosC8XKl5d1Y+B5yqDVO5/LtDyeLfn237f9t2+to/nD/4Ax
 4x4dVESkcM7iBN0zkSeRemr85Txy/mD7It2WD+Sl125f/UCuS/0U6UvHZg/k+Xz7
 rD/wX6A9tldpQ+W1A2Ic4B6LvXg4cx9XJ7l887vyH4T11ch6wjGOvbVe5xS73QWB
 pKfA3Gs54E6h2j99Iv
x-dg-refone: fz/J5RzoHccUqD1RP2A+lL/VF/Z0814uOz19LwHFk+bx7R
 n0AvhmqPqieEuofVH35dF4uqO6Y1PeofFxv4l1Mei4wP3NVV1Nap9TvAXLdOje+1
 7zTPny6/kC/n/3xL6bzdzM=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0P101MB0377:EE_|DM5P101MB0345:EE_
x-ms-office365-filtering-correlation-id: 81dc1e4c-8fd2-43ae-e86a-08dbb3588311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1b2H9/8s9sd/vDpma0wAt59LNxiEOIi0LpxAQ3JBP3nV9RRPHflF1f4qv7j/+L/mWCncoM5dm6gcTEioOc0vgUe7fReN5F9+9vdVpZszZ6iG4Ukb6sY4B3IAyaF47kxKc7gX4o9S9764+VTeA7g8DBm4DxlIA1OPbidHms2WXUEO1d5o6qYnbsOvXFndAIgnuFN/sa95KLPUJedrbPZGbeN/D7W/bfsbOEt8WPiUrlfZD319gn/wMhip5k3LHDEVXEOd/8uBfOTTEblvOWxKa5oYgF4Hpk1Jl5yawlkcICIgrAetlwdCiJXzellVx0I/2vpVAhXNoaSPEl7LLHPMC46/vbDJ+695AB2wHV1IwvFyLNx8SdseN4ef+grYa12oMKEdZni6xQMDehmvvGDajhfpctHncMBOg2TDT09XdjSk0asP5UlRMWaEFSqnV21IELeOQ7QjdSXp/jSm4QBIBjhjO73+XOgxfsyG47oJNa027y8v8FDlKicbVapGCZGq2L0DbTD3hMHNs8A17flMM1fKzvWDuz67TctnpvyrT5o8XvLi3AyixwJ8z2BdkhoEx+TrEsM6E/u52JnFix+bXA5geJeVYcSRwIQBJK1R6P7olsWSDCzTdqur4iWhxmuQJdVXS99E9HEgl3aTzfP2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0P101MB0377.NAMP101.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199024)(186009)(1800799009)(55016003)(9686003)(7696005)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(82960400001)(33656002)(558084003)(86362001)(122000001)(38100700002)(38070700005)(71200400001)(26005)(64756008)(5660300002)(8936002)(8676002)(52536014)(6916009)(316002)(41300700001)(2906002)(32563001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zaUdFm4+Zjjy5e2OYRakg69QTLdowSCTCv4YsZGdA0CY+OpClNlIxPFhREU?=
 =?us-ascii?Q?l3LNmdFi/oRXOk6Ky3469wTwQ1fOFYU0jZM2j5YKFTaesYX/LicZfhpVa/0v?=
 =?us-ascii?Q?+Hw0+LkLrqJ4/bARAViQktuNHtn/QGno8YfhT4o0HQkv2y1JwR3z4nyykrIX?=
 =?us-ascii?Q?nfpCp5LaAEBcBX96NYWoOuss6Q1wx8l+yn3qxbVKfVgCpvQ5DDrN8BJA4nG4?=
 =?us-ascii?Q?Y39M/LATeg48mA8EEZ0dzMpvPMH+bfq2z69Rh/54gaSVnT/fAWiGc8KxBLgR?=
 =?us-ascii?Q?n0VU+EApFXj3QRndbQE50eOidDQA1y9DYHkTWzcBXFRr8bqg+u/ZwJMatB+f?=
 =?us-ascii?Q?HzQoGdYIlk5ZU+aIsJ28qPyPHEoSZzTN84VAeYK2Axb/X8csq80IB4xVU2h+?=
 =?us-ascii?Q?n7j1R1WUhwib2nbYL/y6PsDiWkoYczWnjoaC4URmyyk/VWxQcuPQXfumVeWn?=
 =?us-ascii?Q?ecI6FUiUnDLno1Ytf9mcX58C65d+4Z4mnnBeeRJkDftJ1qCW3/FCaxadbwp8?=
 =?us-ascii?Q?lqL8w/1mbzm7oVLStATUNMhIKHmrgkQwg89Wo65J071qTzp6brFTWJVUUBMm?=
 =?us-ascii?Q?JkdB9dBklapJnWWp/23uUA2nm6vx4i3msMmUVjFRw2KVV7rOm5bwvMB6EAtd?=
 =?us-ascii?Q?ad1dlTxQLqhmc9QFeHAacCl1+xxJOV/IBTyzgx0Zz91VY92YfxnWX81rq8N1?=
 =?us-ascii?Q?qZ6GpHtOhRUweiUiFjNk3Gci7X/Q7pUHwDWRtFhxBiVvhRpR0cdx8bDFwhmZ?=
 =?us-ascii?Q?qdOafqW4EK9ZTA/9eh6oQxlUoeuSAqcaLY4B18D/sOxF5D+UipaULzyPiYoB?=
 =?us-ascii?Q?GNz7aTs1Iszzd0SNvcvyAJynKv8aX36Q+ONn46ihjlqFfZqRC9fTNqgq+crG?=
 =?us-ascii?Q?9iOsQyojN9k4w16OBBlmFQVswoDM+4uSgH+qfPldKOhgDt//CYPV0s68xch2?=
 =?us-ascii?Q?Q8IuWqFf1R/M0ZpkMILlXfrNEAzu2nA6eWQv0TvGgRbQ0PRgdgVjCFOZk5Aw?=
 =?us-ascii?Q?yCxzaiUx1TRAjbi4dnphrIpSffX/0uagBe+WgPp+/jF0uOzaFQo4RZHZv9vr?=
 =?us-ascii?Q?3ZhNP7bWrLuvNlHJi9fRaDgEGvHNFj7shAdytit/EAxyEdRWQHKeE904TrE5?=
 =?us-ascii?Q?g+hn/ZNG1mB+zqQcWU7+ZSaESPFPyFX71egvi3+2K/95zzOSWesyNsW8hhMN?=
 =?us-ascii?Q?S/bISXSAEq6FutxWZSVkvmXtU8zHZShaQoLkvg+DbZhynmEyRm575pT1H0xe?=
 =?us-ascii?Q?2IkbclPmXCb20b7d4c/Fl0g6uH17GUfnjpB7iq92cJoJM5ayR/nioPrs/YjF?=
 =?us-ascii?Q?3yEMRh+cGEE6+foG1jzq/Uax3rEJ26vKSF4giMbeD0wKnHdgEtHuS92a8AIE?=
 =?us-ascii?Q?FSNQO3u+8cYyBjNUhyThPaLCSJFaQO7uwqENtMlnYqPqkk27+dD/aN0YQIt1?=
 =?us-ascii?Q?1hTkXlOtN91YyveWPM0QB/wvOtuoo9Q4AUonjBv18Hc4guIJjlLHcpeIB9Lk?=
 =?us-ascii?Q?6yJzN6lnmExi1Hu8JhRBbBrAPdsM/lNuUp7Pm8+ZQ80j1SLfKH3AVQ7PepTW?=
 =?us-ascii?Q?tq2jSBOINSlSnH6M91s=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0P101MB0377.NAMP101.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc1e4c-8fd2-43ae-e86a-08dbb3588311
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 06:21:34.0441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ccb6d1-d335-4996-b6f9-7b6925f08121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2InEHr2soyLHUqeYDngSkzw6T3wuOzGxMMIWzGEFq1WEsWTOtth6zgJ5P7mcW0xmIBJ4iP0UCrtBzHL8YY94ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P101MB0345
X-OriginatorOrg: ge.com
X-Proofpoint-ORIG-GUID: KnEREGEjCrhzIWwIMGvh-4jfGsPP0vrs
X-Proofpoint-GUID: KnEREGEjCrhzIWwIMGvh-4jfGsPP0vrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 mlxlogscore=504 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120053
X-Mailman-Approved-At: Tue, 12 Sep 2023 13:24:28 +0200
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

Hi all,


Warm greetings all.
I working on enabling RAM test as POST operation in u-boot 2022, for the im=
x8mp processor board.
Can you suggest me how to make things work.
Any leads are appreciated.


Regards,
Lavakumar S
GE CommonOs & Platforms

