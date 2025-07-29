Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE352C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAE383287;
	Wed, 30 Jul 2025 07:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="C3ZWeWK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D9D83045; Tue, 29 Jul 2025 18:24:06 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601AE82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+tuqLo8SBAVJQ/t8z18XsXlQ6C6wyZPzsjgGb/EPnIuCej6Deh5XfODzlcxRtZDrBsfaJufSkIoca4gMKv0ziXexau52DD+x1EbufjVIcy9esocc68/DOVk9a6LJXpCPt53P0wkfKD22F08nlk2AIinaiO8iYIlmQLd32xopCrVE1sMFE4yz2Ubqhs4bCXSnTDqhm1bazIkrtrJvUNf/rKp0b0UPOyg/idVPgywUL2KolL7kpBjLCEcDn6k6E/rUJKvl+g3ALLP1JainMgXTla8wpxnoLHjPWrchh182aloVDS8ezWYUKc5Y+pkzqh1GbJw+miHvDu1xlZJr/si/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=nuoTGOY83Qm6wAS7hd1gsMn6u+g5o/lnRQH86PrDhwhCf7kAO3jdIvljexygToThNt7xGNkoeqRBkjHkGyLYHn/Uct4rGwd9vRnMFr5tBxeobX5Z9ipWn7aMKmDrCsyBzV4BtJDz0B/aYQThpGWkJrLsZCQn4neU0/oNslgYdSatenKwoX+haYpiU9mfquHNZPzXx3yV9ebiS9ATThkythMPw9ZrluRdmbVt5xbarFv/f4Jn7B2TCRHwm/ZKDtOxEYiu+jq4Mxn/+t1KO2HVQvY/JZBJwPy886QAhE4OgqZbbLr+0FFUaqcwOrvA1chhRYBk9woYlMVFewbWQNfoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=C3ZWeWK/4VrWH5DTjyW00+L2DhMcGCzgFVpmabwMDZ97M/mQhhaAOz/kVIdDuqikQhFb6icFT9VjSrLxIAK3DoiyiAxmBbUrt+Cvr3kqhtQH9cM42kQeaUHrjDYJugc5SfUjoEfwwI6CIjBmvJ5y6blR3R0VlKOcBkpeKM2Q2jHOVpTnfdvDnFaG1UoQyqedeDIkNK/R6qnV4LK+XTK+IfcJykjgo9GCx+SPFhOo7Tue+Z2uTGISIaZjGzE9A660YrSyvczZLNfS0P+L7AOyzFTcI8BwybLF8G0DvnIgr6UMDOOlhcZ2Rw521S/JDyNo6gOYiJtnRDkjt67MhGLSnQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:24:03 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:24:03 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 07/12] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH v3 07/12] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHcAKUyQkzlK6yoB0qQS8idVEDtXg==
Date: Tue, 29 Jul 2025 16:24:02 +0000
Message-ID: <20250729162035.209849-8-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: 1c969a98-6de8-439c-ad1f-08ddcebc54e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XD3WSHExIgPk5fEDOl7QC/FIneA8ezbmXtGiT/YiS/hFZxbGldgyBGZerC?=
 =?iso-8859-1?Q?qeqohW9c+t4oYKQpTPnJL9udqrtMBRj3KnzWfsqr3YhiBX/hB0nWHfGrwS?=
 =?iso-8859-1?Q?5OszI+whqDKLjKZt94eDFk1WqwkFG6FYlUKgeuzVFRbOei740tSj4oWnIl?=
 =?iso-8859-1?Q?2937gYeYFxNAWq7qB7qQdeLH6/oLVSp2OhzlqzKbfNE15UOUZJX7ykeYch?=
 =?iso-8859-1?Q?vTKvVnkyThfQtNUC9mpLCJPjfaEq+8kClIsAcHgZEJ8nZ//WzKZkeU5oO4?=
 =?iso-8859-1?Q?ccdANJRrI6+mp+P3aGg6vz0hLojYzaGW2SOQNywFFf3ncObmD3ZCI/cl3s?=
 =?iso-8859-1?Q?Tki3cUsla1LZsQDNN8J9KyHdrjbRi5ATKfSqXpFUHl9WiOLHYilCHBn55R?=
 =?iso-8859-1?Q?YokkYHJqNUE3SmF3NRHs27XaTB7arajzTaWhg8S0YQNroCM1y2j0EJFm6A?=
 =?iso-8859-1?Q?W99u/ihiurZ4XbD+ad5wTZanisVOr3611o+tqTRG0C59tLVDFOVfa3Um1s?=
 =?iso-8859-1?Q?nZwzEvK6tt357adgkk5cMvON2QoxfMvx4TjShmgHscpSaKAuAJg9cSuubr?=
 =?iso-8859-1?Q?BA0WMoBJdODLooUwRf4ADlJNgGOUnOfzC5bzS5kdG/84Dqfv3sQgYlMmEe?=
 =?iso-8859-1?Q?jqBKAD7cBlWGw1jGFNnrIDsetCJ58jU5DqqbZFBiOp3FTZRhE60hbYuHwr?=
 =?iso-8859-1?Q?3pqZ7rbVH/LP6z4vQBmnVUvFwY0AqNrIDcyK2/nZU9a0hyzPucZOA1XhCq?=
 =?iso-8859-1?Q?l/MYKwuLcDkFdUtmQ0lXa9pmDF4zxutI1dEx2PE0sl8nO5NE58SIUzjNMr?=
 =?iso-8859-1?Q?KCppbq1bi68NuzHP/44V5WxYeBnch1nXfqjQNo/AM2OaL9wdrdavDdAjS4?=
 =?iso-8859-1?Q?AJ0DorFrRAfAPSy+c3Mbz/irrUXB043vG9MdWDZJj8Qy+AdBZ8rYFEMYuY?=
 =?iso-8859-1?Q?KUWLpDi4qx4SmWIqXq5Lc7EnXDZ9YykQkPdYlOMgWGFJiCA5wyLPtnIuIA?=
 =?iso-8859-1?Q?Fq18DvTBdRIMt/A7Ka0mFKuLSEnQ8qaaCPabV8bGaMPdL82ClmA/se+guZ?=
 =?iso-8859-1?Q?XfFWHNj67BUcU4VrQfPS2Zg0gVlCFpyaiQ2aNEBTxxeq2BpgIXJ7pMGbW7?=
 =?iso-8859-1?Q?2Ct/HWmpcuHJPRnNFF0HDMTv6ZICkMRM7VghWzjErndsu1SkOorsu93DDQ?=
 =?iso-8859-1?Q?M9K8nA52xWb0a2M2R1S6DMTknUDMAYXxCYjLqgZ980xsb1bLcfzYeKt5rv?=
 =?iso-8859-1?Q?+N587Rg52GG3UCjHd2NHDt5u8T0TjnbQWUu2lTLj27JqBgar9UUTzTWCZO?=
 =?iso-8859-1?Q?TwcFwgFdae8G6mv/x4VxaiNSbEB6h3VQdRSN1VyhFTEfGZtF8+BN8u0jL4?=
 =?iso-8859-1?Q?E/vjKWMca/8lmxYF4vHFgvE4mkkYwtwOM2Js3YsJu7qnFyYop/sGZlLXbp?=
 =?iso-8859-1?Q?Zkko+jJz6z2thk0Zajfe8GKZmOty0vRAR5nbESHgAUAyWMMYR4+w/A+ovb?=
 =?iso-8859-1?Q?rG8njFxJSOT2hvQikO/MHUF+85YeCECQ1KrzmnN/cxOrmm47qDJN96gBqs?=
 =?iso-8859-1?Q?oGohkKs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nqrNaFIyfK24YAuIdO6EViOxsXOTmuQREL2+cEKnI0Y1sL1N5bXCtG6keu?=
 =?iso-8859-1?Q?4XcKuFbWv0BrZucRjTykVXzZMogo+2cK7ipq5JS07cre+sGQDroON2GRNx?=
 =?iso-8859-1?Q?1qCrCpMOGPObzh8lsc7VieKqV++bNBj3PQZ8NV66qKEb60fQuG5vqlxZu+?=
 =?iso-8859-1?Q?VGk7pJxfwZVbSSbb9FoWlRjDGhY+NtWwgL/6CJtm33yLHfrLCxXC/iz90k?=
 =?iso-8859-1?Q?W6mDVwjA8p7hVfvUS7A+yFwkxj3TbdTNQ//mx8ZCZ7GF3yhA7skUL7ONAk?=
 =?iso-8859-1?Q?YaAyUxL++4zqc1hfYf1J8XVPJksh/uC6SBrzXvtKuKjL6bWn9vx2L5aBxE?=
 =?iso-8859-1?Q?Lpcf69hEIrjBgk+KpTKHe7rlaE4a73Nwqe1759s0VQAUAVZhQbBlPkdHoa?=
 =?iso-8859-1?Q?u/GS3vFY6s9R/kEa1pKCiP050axQA7hayxiqJUWLzMdRbB3vHmUjSGC3CM?=
 =?iso-8859-1?Q?DC8KjEQw5VAG+9wuSK6xsBZsUOvGHKyp8PPKh4baIM4aMzv2La9qalucZ5?=
 =?iso-8859-1?Q?jOJa1EuFqDIxlpCrHYNNRuZYIXhfsVftMPFsFR8dMEZ3VPaU60iM/0u9HX?=
 =?iso-8859-1?Q?oOI9/K+4d69n+soctA1ojyUm3KNj2AHlmLCsxsUAsPvTwwMJzfhP19ZQTy?=
 =?iso-8859-1?Q?HuDbQAg954cAtEpIUYStq4Rf+0pO9zIdlBmMwkJy425Xlpj3J2SL5cHzEj?=
 =?iso-8859-1?Q?KlXyft9PRg4kkLRxBIKo4EJ+6IBEqehr//2p4sK6tQd99PTCreDtCtriEt?=
 =?iso-8859-1?Q?QD5c9akR5lA3owP/pgPtty/Fv3ZssllIhWqsz8NsP9vqRQ2hsr+a/fvbMN?=
 =?iso-8859-1?Q?zLHj3GMsBbLY856GDxkW8t7GPPPdYF6r4JdT/mi0AsFje0wIOCBF54JHBX?=
 =?iso-8859-1?Q?NuD9tydjsyMhfciuOF9bKsgT5tcrnTTMffPE0WBymxOKwehMkLF64FNJmU?=
 =?iso-8859-1?Q?9TcU4fA6PD4yenVYSmiltkpWhysv9riMeynzCvsjE3OFDxOpNUcrHc0LUP?=
 =?iso-8859-1?Q?RAkzTCaEIG7cBsHQ7EFHfjg7L2r6DrXhnh+e+x1u72mafSULx9Xi6nyLS5?=
 =?iso-8859-1?Q?DIo4TqPUsQtQgOObI9LvUTS579SQXjgw3yo5QhX6ZYugpUuXXewwwL5i5S?=
 =?iso-8859-1?Q?eUo2JAlDHSRgXsmXxQHkwpwqVYg98iXc2pXzoNJtCRZtgZlEmJL3bq0h6C?=
 =?iso-8859-1?Q?4fss/i8bf6BiAJ/ZtDrsINyktLhZbZMdzFbohHx3TsI/NbOlYKNqIim4qv?=
 =?iso-8859-1?Q?TGKEWNUICoipqQJ+SuE8fmCunhZkF902BHh+dukdkuYx/UBbCBf2LC7x/6?=
 =?iso-8859-1?Q?58N2mxfWewJZBUd5rq/Azb3BnSoZYPq+iO2SdKjvF0Z5qF3ELKze2udkMr?=
 =?iso-8859-1?Q?8Wo1GQIDN2CRAXkcdfaW4kZidqblfs5cHiRmBCuuEzHRSB9/AHXC0kWrxj?=
 =?iso-8859-1?Q?cPgxHYxSF/o54s50RrEDNw0PNmGw4R0kDKgV4X/cPbvppVcBIwP8h2VfP1?=
 =?iso-8859-1?Q?1WeDRg5H/kvX2ChbFAlulAeB1ZtsvVdl+hdb/vaXB8aBThI0ZeYTLs5v2/?=
 =?iso-8859-1?Q?vNIwsBRNUJCiVyAhILi5i1rHWctFvGdoA5IXYa8UMDMFMleagnknmavI9l?=
 =?iso-8859-1?Q?zLc2NUrsEEV2VS0MzCNdqAa48rHTFXd8QGwwLuhQ+fajdKHauPcHwTOg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c969a98-6de8-439c-ad1f-08ddcebc54e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:24:02.9537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXbZcb4gXCEgYPymOuP/JQv8t139fAym52x14FZnxGB16/pGstQe7wcuiO0IAwUiJ5asIUKgCeEgatFLSZXg/ZCzpAAwfzXjN1hU8iLi8rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Although memreserve entries in an FDT are 64-bit aligned relative to the
start of the FDT, we cannot guarantee that the FDT itself is 64-bit aligned
in memory. This is especially common when using a FIT image, where the
alignment of the embedded DTB cannot be controlled.

On systems that do not support unaligned 64-bit memory accesses, this leads
to faults when accessing the memreserve section before the FDT is relocated=
.
To resolve this, copy the 64-bit values into suitably aligned on-stack
variables before accessing them.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 scripts/dtc/libfdt/fdt_ro.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index d65656aaa8b..1c18aea66ab 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -174,6 +174,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(cons=
t void *fdt, int n)
=20
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *s=
ize)
 {
+	uint64_t u64;
 	const struct fdt_reserve_entry *re;
=20
 	FDT_RO_PROBE(fdt);
@@ -181,8 +182,10 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *=
address, uint64_t *size)
 	if (fdt_chk_extra() && !re)
 		return -FDT_ERR_BADOFFSET;
=20
-	*address =3D fdt64_to_cpu(re->address);
-	*size =3D fdt64_to_cpu(re->size);
+	memcpy(&u64, &re->address, sizeof(u64));
+	*address =3D fdt64_to_cpu(u64);
+	memcpy(&u64, &re->size, sizeof(u64));
+	*size =3D fdt64_to_cpu(u64);
 	return 0;
 }
=20
@@ -190,9 +193,11 @@ int fdt_num_mem_rsv(const void *fdt)
 {
 	int i;
 	const struct fdt_reserve_entry *re;
+	uint64_t u64;
=20
 	for (i =3D 0; (re =3D fdt_mem_rsv(fdt, i)) !=3D NULL; i++) {
-		if (fdt64_to_cpu(re->size) =3D=3D 0)
+		memcpy(&u64, &re->size, sizeof(u64));
+		if (fdt64_to_cpu(u64) =3D=3D 0)
 			return i;
 	}
 	return -FDT_ERR_TRUNCATED;
--=20
2.34.1
