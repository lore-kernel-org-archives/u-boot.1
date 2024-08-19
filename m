Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F1EC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6572D88CD2;
	Mon, 19 Aug 2024 15:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="QVJYKnB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6AC88216; Mon, 19 Aug 2024 11:44:04 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45C288216
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 11:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oliver.Gaskell@analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7MQJV001347;
 Mon, 19 Aug 2024 05:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=G5URBhBf/uGFmFR9RdWGnsTD3oR
 eHSQRBhh/EKAGt+4=; b=QVJYKnB8/0w87O0K+3XaNvBCsv2cpzak9TQ7DEk9Q11
 VrMh5Fp7FVkiFgKvm7nbOP0PQ+tn7XqbudlLrSP/OHvCVU5zPu+riQahyn2qI6QQ
 15yl+QOA0ouCYm8/O1a1Yj/IqtihxxY7/P+rNN6s/uEwZtQqCOyEI6TgY1YbWFot
 3+fn/l2XJvwUAKJkRbo9zct/VWvKuWFlIfBexp9Ez9+h3bZo++kV7otayPkNYjJM
 v/aRYg8/el3uPbFVEyi1qnwYEXfQ12GJ+B76ORIpPDTC81ZCm3pEt5w6MZqQyDn/
 RbyvqgaVuSBFjKEyYMjGPDuA5svIVQiprBHa8NgVwgA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4141kugegg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 05:43:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHlMVWGNdJ9daT4XgzoxdhvVrkV6+GAk+9RHbeJqsMdf1CAYQxxvYHcm9+AUNA4yAOt9z5m8mPIB7hdzTguFtYhZPuspoMWfLCun00b64EX3NnqRqlw+aMOdEMoGCg39zBf53eiSjDkTZ0GCDvtT0pUNcRZ5pPumivuNBDiri6rB9cdZe4yWv47Emq0K5teRp1sb+AiOVatLPF9eMl2I7oadKvXbL7zNvW9xUy146CbVoDaXEk6znJ7E4IRHo2RIL99D8Uvujx332wK/f/oqbelaFvrPzFTJA1v0Cy9M1oSQ/WB9+gTQUREaejqlYQ7CM3VTmEpK6Rn17EBlUq/lJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5URBhBf/uGFmFR9RdWGnsTD3oReHSQRBhh/EKAGt+4=;
 b=Ivns5+/8GEPtYrDzMFsBtH1Pzgmx+Abm44bbp9kkrfMLHR1nvEfEePWIzzRVeMsocpC0tWyG0+ByTDBjN7yLsce04qaB+W1nvsVQ9IDDi/GnaP53qn7BdQ2ry9hKxZzrfqB6FbWc4jalomBXPCRemharfZgk3JB5rZWDsXUxYmZkqri2ukABhzV0wmyE1EzIxPcKCKOmkUVNM5cfPwNN8ZvfG27ii3eZOozdb/q8PHYJkQbvDWmPreuHyUDY9Ce0YcbiS1KXtDNbDxhKnNvKXRU0naUHsKhYzNyzikYxHsuLzxPGCxMRjHuQsOaEpncwcquAKXY4Dy4YmZSgcdJtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BY1PR03MB7286.namprd03.prod.outlook.com (2603:10b6:a03:524::10)
 by SJ0PR03MB6683.namprd03.prod.outlook.com (2603:10b6:a03:402::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:43:52 +0000
Received: from BY1PR03MB7286.namprd03.prod.outlook.com
 ([fe80::7599:91d8:b5b3:3c6d]) by BY1PR03MB7286.namprd03.prod.outlook.com
 ([fe80::7599:91d8:b5b3:3c6d%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:43:52 +0000
From: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
To: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Linux Factory
 <adsp-linux@analog.com>
Subject: [PATCH v1] dm: core: Make SPL_DM_SEQ_ALIAS select SPL_STRTO
Thread-Topic: [PATCH v1] dm: core: Make SPL_DM_SEQ_ALIAS select SPL_STRTO
Thread-Index: AQHa8ht35FOstzF+8kiGf1moc6yfzw==
Date: Mon, 19 Aug 2024 09:43:52 +0000
Message-ID: <BY1PR03MB72863313CCC8B4927892BFB2E18C2@BY1PR03MB7286.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR03MB7286:EE_|SJ0PR03MB6683:EE_
x-ms-office365-filtering-correlation-id: 97f53d29-b63f-4df9-0e93-08dcc0336faf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vvVuvw9v9NLQIvgmi2hYihdFjo7oeNBuXjepAirXJV1bvBt6grrMHL200V?=
 =?iso-8859-1?Q?NcqjLlquFC8R6ORtp9cEdoI0P0ZzV7NbpVSyBWAupLxC6/HkIMTHID8fBD?=
 =?iso-8859-1?Q?7tPhbXyM3WaKW2dwl4AsjbBA7obWZHTDiF7l6gM0rTMAXnaQXrX7VuSDxL?=
 =?iso-8859-1?Q?4AACEsnKwKSxCRd4j+glUFv02cZwIs34vOmLjFRzhB27YxJ7fkVSw9FZos?=
 =?iso-8859-1?Q?1KKrQZi5ywi+thqhE+GargVtfLSE1gYBnS23zJD18rrZYgmYtq9S3uKoKa?=
 =?iso-8859-1?Q?RTmQa9ARWf4CZ9L3R2XR+r7/NDivX0D48E7UBC4Z6Kz6E8gju9h6xFGLS1?=
 =?iso-8859-1?Q?P/UUPHmseLNVnsojk4FpQZdmBr3ZUWM6UY63h/zBceVnEOyy/msPx+vC9b?=
 =?iso-8859-1?Q?zv57yQR5J33C0lzOzx5vX6L83OKEvB1/hfFzOWHrkxZex5xtgZDskCOnjI?=
 =?iso-8859-1?Q?iU2TDKXMwP6HK4H9MmRvp847srsvxRJ1w3qMsBHFZ9uTqb9rooWBP2qgWv?=
 =?iso-8859-1?Q?zD1f+GKQw5UZJDe4qf+UzR+PAwRjS5Xc7EQ7eoD/3aEHMdw6HIDemN+xjw?=
 =?iso-8859-1?Q?6Acb2W6oRrEAGbhMYjbz/1E/qHoYgFY5QQ0YnhleJ3I2k6y7xBbe27YkUj?=
 =?iso-8859-1?Q?Kfp0oePYu4tCtAMscMj6cf9X+NIBo2mznL4WbgCpML4eTY3APH/U34uvdH?=
 =?iso-8859-1?Q?7kCmzJDMr5hnJIdB8cH8bVtSW2/EFijgWsP84llQVGRC1Bc+d+KKtnxHcd?=
 =?iso-8859-1?Q?e3djpLCd80OAwjyyHU3wtqvsameW7ltKMGdwafds5eUZCuYCnNLijF2dSc?=
 =?iso-8859-1?Q?4cCspc519PPT9wIOvtsLvAuYqu3DLkgkHWgo15ytaveuUbkFPAyZXEQbMk?=
 =?iso-8859-1?Q?FsCls1jIWqxvjyLTUPy4SVE3NNaXVv3Bv8ce4vkavzaOCqkkhWzRQp9BGd?=
 =?iso-8859-1?Q?lrPK3pl+s4r1MKfoyTH5rm3hVZklF/fFjjZY69g2cyp4CUm4Td/1uVa/z5?=
 =?iso-8859-1?Q?+zk8K1JlT1stSlgXo6IJnC3XeAy9FwzCHHhUYaVgd7raoKhutbDWL/u5Kj?=
 =?iso-8859-1?Q?Os9YgidhcJETyVnBLkqaYeLZkJaQZbxFDSYP8GijsMcocS3z04HATcT2zb?=
 =?iso-8859-1?Q?kTVus+Cz2LvtlHEiievlIucdiXyzERublcbn4VfMIwMPSmxRRWP0O+GnYr?=
 =?iso-8859-1?Q?KZWcVxvPiJSejIUpoUceQWEU3bZHDu4p0FRrqhYc7D9/snaRyxDxl+bZlf?=
 =?iso-8859-1?Q?CUgstFZKFbyGC/GJO6CYDETwwZZhgOCdlGO4LA4O04BPDDfDIidWGSAGVl?=
 =?iso-8859-1?Q?3vHOnODg0hOHO4CNt+M/vJfu8FT1XK089IVXIioEXqiNq6IRjd6dfKtYIu?=
 =?iso-8859-1?Q?p3pgN9rNpRspSFOVA4TLbG2NfFn0HE2evOvCz2LmTTirDxsxMxvIuRl06+?=
 =?iso-8859-1?Q?1iL3N0mt/wwNEpElmAnMxuNRMYogvTNI+cBEBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR03MB7286.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JmwoBOMZUiCIuDBzt/rRZoJCok65W+mgXKEaHqTSWg+7/om7x1Iq9EdiRx?=
 =?iso-8859-1?Q?/MBAZonemLl6CTTQ9gSPEAIVEV67ODuquXhLz8/oNLNJoQm7VBsNH3x29T?=
 =?iso-8859-1?Q?6vZl9qqonFing9a1ntj1eHdifdPFVC5yzih2sTdYHMwov9PZuhLT8YO/Yr?=
 =?iso-8859-1?Q?oQdwq83HRJF8CmAsm3vPYBJA7OMWQ2wa79mRwgVN5P1zZzt6AcVg7gq6Xd?=
 =?iso-8859-1?Q?Y6NzzdarZSMqUo1K8bvEXdoE1jQfFpbzioP0vBzCrWGSV9E7cxBjyMNF/u?=
 =?iso-8859-1?Q?yMNUVDMfbIzwVvBEIvqrlIn03taVfDXptGtSa8IQJOXuGeJeuWEYYymKiK?=
 =?iso-8859-1?Q?gAJnqibnrrSk+GyCsDv8bP5lKha8KCFEXhtIjx1ns1ggNiPULstRnkYzh+?=
 =?iso-8859-1?Q?IURRxAJm1NqYuJmuLtt/lAoGvqsgJAECaZaWWWBo+1qFSNnbTKBiJO0dFU?=
 =?iso-8859-1?Q?z0qhGuTZUxn3TZxkGTzgNV7pwoqsE3Q8jwweeCsD3i5i6ghLp9UVl6DOhL?=
 =?iso-8859-1?Q?6yiyrm3cZo6tHVtgkmLxe/buJLQ9hSGiAKIwT3Ff9AjdzDt45nIOC2ugif?=
 =?iso-8859-1?Q?C62hcegCyakcSton0IEMSUbRN57eC0Guarpsk+6a3hpOncMAnkRFmxZ19C?=
 =?iso-8859-1?Q?2mfRIkyXXAEmDbkXB+YHK2tgDBvWXQIzV+aP5tvZUlByjtXmJwJjcu7h9D?=
 =?iso-8859-1?Q?OKh4VeTDFXfJSRFYKd4mo9o+NgcEk0W0fE6jRr5t7+rXsfcrCicRXiMkY2?=
 =?iso-8859-1?Q?6QAmYAnlG773ODNsgeX2sOwWY6uop7+KGWfsQhY/sKkv0SLSYSmwIw5IKV?=
 =?iso-8859-1?Q?Dc4r8Y4JJ2yg31CkTqc5bcHEjnrmKQN1/66oztm3fCtK5Psf2k25pLMmwJ?=
 =?iso-8859-1?Q?+yFMgUw+WDeutbtY+mYvv+VKyn39eJhcD4cDZP22vI3dFcUOj+2nLDHE8G?=
 =?iso-8859-1?Q?eY0TMUHJWinemvfwnD2zDkzZ12cauzVbcXcimhdF3TpoMPQSZNgi0XzTPR?=
 =?iso-8859-1?Q?iMuYuOb2OiiNxz9Cm4M/2F6eTG8irRUJZ68eKHWZ98HzM/6/iEbyFMDCZo?=
 =?iso-8859-1?Q?gnvPiGms8v52KdrP9Bo22W4aSWG14+tYbQMsaQjdgu5M06SUQgzGynj6VV?=
 =?iso-8859-1?Q?743Zz2xneO133x/RE7XE86ZG5yBMpK/T3scP09zy3Ylv3ofPhwds34iVFn?=
 =?iso-8859-1?Q?6ldGaWom/SBJLQYfeMSvzIOxRfvdKZR1Mqfe8xO4iUsSww1RFWOB7y7iiw?=
 =?iso-8859-1?Q?vsp7WRncpUBP5TtdqncJdZd5veululc0VIflL6pvDije8sIDDBVJ+f1DC2?=
 =?iso-8859-1?Q?BjTZPwfGwM/v350AleUzz0926/qRdjO7843HE40s5/b2ABoV7ZxKvCNYrZ?=
 =?iso-8859-1?Q?SsU98kA/xXdowMazeB/ySxeWpkW1WDceUbHSfcGI3hqbHo0Y6u+SlTTC55?=
 =?iso-8859-1?Q?tMkTxO2R0JVKBEyWk2fbERHLpwqvovqVNHlfAn02UPQHn1o8BDZnhhRB1m?=
 =?iso-8859-1?Q?poDHwp41W3PnJA1oCHC0oE/m9hRXPNDmH5OTojejZPBLiZ3oVTTjbhEGbb?=
 =?iso-8859-1?Q?WrPSyIcqH/MWnoR++7621WhwJWGTmSrd7n9X1/5vY0+rRVg8aeQ2B8Pj0r?=
 =?iso-8859-1?Q?aHL6RHK8pgW14goA2PKc8whvrTK8I/NCHf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR03MB7286.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f53d29-b63f-4df9-0e93-08dcc0336faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:43:52.9105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKbB39Rysf82HhMBB/kGtd0GtaDIIRdz3K5zEzjmhTtbOss1xWE2QCmv4E8GNdJ00S4WIronffWQeJ/6j6XrrFBCAMyU2on3IdFkenOyRHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6683
X-Proofpoint-GUID: L703bJ2yedj5Ayzz0S9DVhUEGbjNKAA4
X-Proofpoint-ORIG-GUID: L703bJ2yedj5Ayzz0S9DVhUEGbjNKAA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_08,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190065
X-Mailman-Approved-At: Mon, 19 Aug 2024 15:54:55 +0200
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

Enabling CONFIG_DM_SEQ_ALIAS enables code which relies on=0A=
`trailing_strtol()` - which is only linked in SPL when CONFIG_SPL_STRTO=0A=
is enabled.=0A=
=0A=
CONFIG_SPL_STRTO is not enabled by default - to ensure this function is=0A=
available in SPL, CONFIG_SPL_DM_SEQ_ALIAS should select=0A=
CONFIG_SPL_STRTO.=0A=
=0A=
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>=0A=
---=0A=
=0A=
 drivers/core/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig=0A=
index 1a7be4d9b4..c39abe3bc9 100644=0A=
--- a/drivers/core/Kconfig=0A=
+++ b/drivers/core/Kconfig=0A=
@@ -146,6 +146,7 @@ config DM_SEQ_ALIAS=0A=
 config SPL_DM_SEQ_ALIAS=0A=
 	bool "Support numbered aliases in device tree in SPL"=0A=
 	depends on SPL_DM=0A=
+	select SPL_STRTO=0A=
 	help=0A=
 	  Most boards will have a '/aliases' node containing the path to=0A=
 	  numbered devices (e.g. serial0 =3D &serial0). This feature can be=0A=
-- =0A=
2.34.1=
