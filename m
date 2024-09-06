Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B691CE7B1B
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 14:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0219388CF5;
	Fri,  6 Sep 2024 16:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="Tl5sdTDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E3588D01; Fri,  6 Sep 2024 16:22:13 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003A488CF2
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 16:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9979f1739e=benjamin.baratte@st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486Cqq6j007617;
 Fri, 6 Sep 2024 16:22:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:references:subject:to; s=STMicroelectronics; bh=RK
 gyJ9f8AZWBqnKtxHylog2EYMhNGO9hPOoAv2BfaSY=; b=Tl5sdTDgqqGGZjTw4E
 7gj8iPO+XgPLzw6QaCeDqtpZVLvi21HfV7PKRtQUMMXNNH6PiVHHhzkgTqGV1mT9
 DTVIn/S2iyftDH9TasnO7jbgPCPb9DNonaWxPDBjlBnQtUayIuI3t3nZOljYOK7e
 hOKgB7LhTa8iqPSrxfh1CjvKUY4RB5ne+40aYZYHGnuy6z6o9wHdOiNq4zaMJDvV
 OZCh3Q8omyv218wp5vC4XCEonem55ED8OjSjwKwL2YLurcB5kekzPtzM1p1Ww/e8
 uh/Ht2Vl4GKFMaNioznC44QryWR3MpW8mSlr1XUotktqDmQAAkLv+hSMVq6Rsib/
 1+kA==
Received: from eur05-db8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41fhwr3whp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2024 16:22:03 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0OCSAJRc2WAdjcdUa4bECjKgZDuWs1vJvWa4ng+ILGU/qc1QbJjplhz9vV0WX0ZnSIjhOWTZ28uETPohkrb7eDVgg+Ny4LGatpfsKNCctgczqhMB7PkoUHLKJfojFusBYNHNndS5cX19vldIXcIn34Bx2/q0uEc/XO9yjD/arXqkX1GPf3V6uv1Y0ALHxsCG3KElt8V9P/OS5BuY33gQf7ploO7Dls+r2N/E2k+Xxi0VaLBxOKDsmtjNbWLYwCBUZdCgNdLoohVo/FzAvV9U0Q0CXrserKvmN/m5N5uo7i8qUdQ6xvAOHjRyH9Yec0104XqDtbGsuayFsrenUZS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKgyJ9f8AZWBqnKtxHylog2EYMhNGO9hPOoAv2BfaSY=;
 b=P08seMRLq/dAUXp3dLYuL7mi2N0E+1xdKC3xf1ttt/XEDrZx7lkijXeInlF0SSUcWp99slhl2zT24hHrlyehY7Nzhh3BvP9IIP37zs3RpBiXpa3sTQ7S8vEIWNws/msmVQDsR5ergCAxHBNDl5MUzdO+tpQFfVbYjoZraMD09fgRtF2LmsRvMtEDMiBrDZdjrYzQZKdxgFNTGI0P6Jtlt5QFo8HKEDP4wsD5EnVXH2FaladT/2h5Dgq/6rkVa51hYA1+sQBxPYjh5PY6Aj5PIy2BRon9ScyGxqZpAQZAkABPpAU41cRGgoi5Y2gwcTL844dWZ+Pyo1csUE+5+PkGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by AM7PR10MB3812.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 14:22:01 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 14:22:01 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Thread-Topic: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Thread-Index: AQHa4b8qDWUmkS89M0qqLs3iveArJ7I05xYggBYld3A=
Date: Fri, 6 Sep 2024 14:22:01 +0000
Message-ID: <DU0PR10MB5244E07FE63F58CA4E787C0CE19E2@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
References: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqefQTOIwKSl1YzC@hades> 
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ActionId=ea85e2ca-8b80-4c03-8559-4ab968b23d17;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=true;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=cf8c7287-838c-46dd-b281-b1140229e67a;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2024-09-06T14:21:20Z;
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|AM7PR10MB3812:EE_
x-ms-office365-filtering-correlation-id: c7d7f990-d379-4c31-1a31-08dcce7f462f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SCrzYP7k9qjzjplpWn9DdUGtova61jVXsGg40AWkpe7Y8TLrhyq1XmzZpIFs?=
 =?us-ascii?Q?r6EidHfngWRZ+oUNMY+eHEgtS7WOFT5FJVdIoyacsBfo+PD4U0d8QkRX9NaF?=
 =?us-ascii?Q?iSUJE6XG2MQZZFxv4OknWQ/PV//vF8IJxWXUg1+ysAw7Uq8d775vM2A8htRg?=
 =?us-ascii?Q?XuaKyrYcXOBtPFj9+r2lo46YE7IxU4ctUVoXMU6hUqIZT5N5ZOaeXSoZvSvE?=
 =?us-ascii?Q?F3/VhJ8Q/4BjS9cLhceUrqhnuwfS2H5mo/kgDST4EK/kIgw00GWm7gsp4ci0?=
 =?us-ascii?Q?YXG9WCljjyg75fpelWp6siiI2FCg+K15nDwloAnI3Uj1jEHJ5zjplSJrFHWu?=
 =?us-ascii?Q?HKXErUtHJdktnnA74/Mwrlf8cMvZGy+hcqh+jqg1GT0DS5wKroQJSYz76vbk?=
 =?us-ascii?Q?W8+uwjBUKEmxvsbSTqAm7eWLhDoGPl7MONfU4OVZx9hH/tvog0OartkLRwPS?=
 =?us-ascii?Q?Q60mnSxvxitAj3QRYX3Lm6UL1R6g41HAarI6SikYl0Qqwjq4WOGx5+LhQ4Kp?=
 =?us-ascii?Q?CdbxdJVYgBlndZdm9eb0MRezKn3nt55q9JoAENUhMucsDGmD5K79ll5A08kG?=
 =?us-ascii?Q?wHpzXNusJsA8Ly90itlPLPda6BxrlwYIvzf6QaLKROrvoSEbcQadtALIfqFg?=
 =?us-ascii?Q?NXmxGLGqO28L1acbx4Cmie/afpOEDghS9cfNOFNg3zWhpRUP2lwn1xmoWFwk?=
 =?us-ascii?Q?bmLp27pd3XPy/tL3DBomYGIWPlCF64VilnNwkNfLz5kvLejWUGZbus3dZG1L?=
 =?us-ascii?Q?TmqfpVPufb0dnUUBMZhxJDWV4h77oiXf0ulQPTlcXWiKlcOLDAt+LuJ94MXC?=
 =?us-ascii?Q?9YdaTrrigcJUViHoc5ui6xG1rzzBvi0Wk25xhFCePlX3YDHyz3gPuLFdTXRt?=
 =?us-ascii?Q?RBWNbPZIAeS98B1cbQlIdsj/Hgm5C6nGtnFGQK5QDTYqJ7JOuOhNrZhh2tWE?=
 =?us-ascii?Q?HsWWiwXvlrXrg5kab6qY+/LyChYq/vSb6L9OZwTi1dQtrj5LwSBArCCVfZ+n?=
 =?us-ascii?Q?Qn4NINWLC6QyrJo5BA0KYcqK8FR+ovrOnbh+2T+693DeKLqqJDIzyRrJTEsv?=
 =?us-ascii?Q?AndggDNZw5Y+KYLE6R5a/2UxWO6QPUnAZHlNwA2A7h22qxeGWZLCmpssmpVD?=
 =?us-ascii?Q?T8409iYveBcWrZpjIYatKZkyRDLQTBrPoYAh3aLwph2x4qIKXVtX8vZltAO7?=
 =?us-ascii?Q?c3kw4qHpS5V1KEVrxgVRIW8gYzjAiXOn8KliAoIm4aQwsGTBMkl/sZHBZmfQ?=
 =?us-ascii?Q?4xzp4c3XE2mi8OMDoMS4FgcV0YFZa1lB6vmTqOqeK8a5TTHpbAkxZoKHjgij?=
 =?us-ascii?Q?5vz/0C7sI2ATWyzbFnzIsXt7uciEZsAJwEZkthZcARH4rc2938Zam0SgBCeC?=
 =?us-ascii?Q?Cv/D9s17Z2jmnIn0FLQXXbkIrCcXxWHsRT8/OATRpdpGyUGYdA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?utI8W4IRsSt0I0nKf8Ws9RZmzjzzgm8zpgeQ/dst8alKDKJkuGE/9T47cW3x?=
 =?us-ascii?Q?aUDJ5AB/weH/4WOkxSITbyK7rT1z3/ij+b7UaqJp/CZ6wycXnlsyWJZll18h?=
 =?us-ascii?Q?YgT/hz9NXCo8b5C1qyB8UMsUxaklcauSiHUBsDSMK9fbAjAUaFx1cSKJIMOf?=
 =?us-ascii?Q?3Hczn2b+yvuZxpu6wn9mDLkajMLt4bm8ua15Z0B04mFIAKvKI+oBpBXYzC/I?=
 =?us-ascii?Q?BJMhjaCuIGLCrWb3789GOte3jc1AGoqzCKB9GXuBrIrohC9xkMSd5Jn5UqRL?=
 =?us-ascii?Q?S/vSlO2/KC90qvxAQvALUXcsaJ3S0m5UqPHvj6UcGX4CaAwS4XOpD+aJ+JCZ?=
 =?us-ascii?Q?Syjjf1kYzK65obbjNU3vj8aNh9y2NUPzP4pcBrrP3X0ewmOC3l/jTaTLh+BP?=
 =?us-ascii?Q?OCjQ3kGFfDLZdpbDFcqfR5kg4GVRbY5Q5IwSOm75TLH1pGmAQQy2CwBEwL3n?=
 =?us-ascii?Q?aF5GBTk6jIcEQfGwqZSpa/b9+WBVDdtgudE3aAO2RS1N5bij8eWU1uOTdjll?=
 =?us-ascii?Q?H+sIzWvyRDFjd+5ZxG0Zl2C8Ft/J7F0toPCzesT7GgCVg035IfpBFlDgbqWx?=
 =?us-ascii?Q?7JqdJTAmZM7XXLfdc5dPxq2hPLqluwJvJqhXlv6nbEYiTdSUSb9pZLmxK2PC?=
 =?us-ascii?Q?rady7tsm4rIgY4fFbWzt1BCmqUQoVvnEF3wplNgnpQUKdX59V4zuVQxZmx1M?=
 =?us-ascii?Q?dvYZYSRJQjA/f0UZAi8tJPgUDkodxoNuUcn3lFtWlVyNrcOfC5GPxfqSiTEs?=
 =?us-ascii?Q?hP92rI/GtvJc00H50T2JHYcOd9z+pfW6r8fGDLeqpJ5GEyTdo2ovZ6tO4NbT?=
 =?us-ascii?Q?D7dQEuR1QUeEfgo5Y5c3tmPl4TnwiGYBnm/RqhYv3VRIhKUVGZ2kPuJofWrw?=
 =?us-ascii?Q?RoG/xJ80S/zV2zWXOwjpit09i+orQT3Xa8tFNGZvuhnzcM8KF/SNwZow5QJQ?=
 =?us-ascii?Q?TZstL/0+9fUwBAQsv9a+ar/NGH5ospTnq5MqUk/jGGEhsTNonPDzKesv9KvI?=
 =?us-ascii?Q?uqMXNfKOYjB7KQe0Bc3ZOMbNnmK3TSLDo16+AUKBFbupRYNuO6HswaX5GnXn?=
 =?us-ascii?Q?EP3740oUMUZDjepT5Dy7ZZP6dpdjKoKYI3zMFwapylF/ktlBrUZov9uPvjXZ?=
 =?us-ascii?Q?ozGkTAhmd1fSYwwzZ7pEwvNFOl5eCFGaIszdzq0Bn40zR85JGxhCdUrciWaE?=
 =?us-ascii?Q?qy16Y2p+6F5g9pGWdWGbcHVywLJaiV0Chu5ZzhQ967PSQ0HNUwvxvRd2M0Ku?=
 =?us-ascii?Q?qWNWFbtGVksX6iamRG02ra4h5deV0nrydkhUxxv2eSnyjkSYahbDr1QxtOgu?=
 =?us-ascii?Q?R/hI0JlGcAyzu31bA9zA2DdywPMuh/a3CriKuvSCyxMBDiXU/ATz4emyYagr?=
 =?us-ascii?Q?MnbJlghLdORsDa0iofNLswQqFz+Vx7HL+HeDL4jujUtHGj/kjxUbqiRS7WHT?=
 =?us-ascii?Q?e/GijD7ra0NMLFgXwH9hnk4d7+Ulux7a1FNin0gz7WPmItJ1Dihizipl861L?=
 =?us-ascii?Q?dEdmFkSL82PCky1vIybxvHDbwoFLDaQv6m3bzBj744aVIQkidQP3ZXuPlgva?=
 =?us-ascii?Q?hxVinJHeAQVsNKURL7ykcjpfz8HCseappvvUQA6Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d7f990-d379-4c31-1a31-08dcce7f462f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 14:22:01.2892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QWaC8dpkeCb6drwzYhOHrN8p91zj/mqI215hVMLWZ+TUkATKaCaTTrZSDVFj2FlYYyvKsFSmPxLtPsihGWv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3812
X-Proofpoint-GUID: D7YQPAna2ULFmVitrAkzA5FQqGhj1VM7
X-Proofpoint-ORIG-GUID: D7YQPAna2ULFmVitrAkzA5FQqGhj1VM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409060105
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

Hi Ilas,

Could you comment my last mail on this topic ?

Thanks,

Benjamin

> -----Original Message-----
> From: Benjamin BARATTE
> Sent: Friday, August 23, 2024 2:25 PM
> To: 'Ilias Apalodimas' <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de; eajames@linux.ibm.com; sjg@chromium.org;
> tharvey@gateworks.com; trini@konsulko.com
> Subject: RE: [PATCH 1/3] tpm: update tpm hash algorithm according to
> tpm2.0 spec 1.59
>=20
> Hi @Ilias Apalodimas,
>=20
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Monday, July 29, 2024 3:55 PM
> > To: Benjamin BARATTE <benjamin.baratte@st.com>
> > Cc: u-boot@lists.denx.de; eajames@linux.ibm.com; sjg@chromium.org;
> > tharvey@gateworks.com; trini@konsulko.com
> > Subject: Re: [PATCH 1/3] tpm: update tpm hash algorithm according to
> > tpm2.0 spec 1.59
> >
> > Hi Benjamin,
> >
> > Apologies for the late reply, but I wasn't cc'ed in the series. Did
> > you use get_maintainer.pl for the recipients?
>=20
> I have tried but due to the corporate setup, I'm not able to use the scri=
pt to
> format and send the message automatically...
> >
> > On Mon, Jul 15, 2024 at 01:33:16PM +0000, Benjamin BARATTE wrote:
> > > The hash algorithm structure shall reflect the TCG specification for
> > > TPM2.0
> > > With vesion 1.59, the SHA3 algorithm has been added and shall be
> > > reflected in this structure.
> > > The fact that U-Boot does or does not support SHA3 algo yet is not
> > > relevant for this structure.
> >
> > It's not, but I don't see why we should add more algorithms if we
> > don't plan to support them. Any plans of adding actual support for the =
SHA3
> family?
> >
>=20
> The main issue here is that the new version of hardware TPM are now using
> default PCR configuration with SHA256 and SHA384 as per the TCG
> specifications and U-boot can't support them and generate error at boot t=
ime.
>=20
> For the SHA3 family support, they are supported in the Linux Kernel alrea=
dy,
> therefore, this should be supported in the U-boot to ensure consistency i=
n the
> full boot chain.
>=20
> Also, TPM API offer hash interface, therefore if the PCR is using SHA3, t=
he hash
> calculation could be done by the TPM regardless of the software support i=
n U-
> boot.
>=20
> Best Regards,
>=20
> Benjamin
>=20
> > Thanks
> > /Ilias
> > > It's up to the end user to configure the active PCR bank to
> > > supported hash algorithm by all boot chain component.
> > > Also, by default, TPM2.0 shall support at least SHA256 and SHA384,
> > > in practice dTPM support 2 actives banks with this 2 hash algorithms
> > >
> > > Signed-off-by: Benjamin BARATTE mailto:benjamin.baratte@st.com
> > > ---
> > >
> > >  include/tpm-v2.h | 35 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 30 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
> > > 4fd19c52fd..9848e1fd10 100644
> > > --- a/include/tpm-v2.h
> > > +++ b/include/tpm-v2.h
> > > @@ -253,6 +253,9 @@ enum tpm2_algorithms {
> > >         TPM2_ALG_SHA512         =3D 0x0D,
> > >         TPM2_ALG_NULL           =3D 0x10,
> > >         TPM2_ALG_SM3_256        =3D 0x12,
> > > +       TPM2_ALG_SHA3_256       =3D 0x27,
> > > +       TPM2_ALG_SHA3_384       =3D 0x28,
> > > +       TPM2_ALG_SHA3_512       =3D 0x29,
> > >  };
> > >
> > >  /**
> > > @@ -271,11 +274,15 @@ struct digest_info {  };
> > >
> > >  /* Algorithm Registry */
> > > -#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> > > -#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002 -#define
> > > TCG2_BOOT_HASH_ALG_SHA384  0x00000004 -#define
> > > TCG2_BOOT_HASH_ALG_SHA512  0x00000008 -#define
> > > TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> > > +#define TCG2_BOOT_HASH_ALG_SHA1     0x00000001
> > > +#define TCG2_BOOT_HASH_ALG_SHA256   0x00000002
> > > +#define TCG2_BOOT_HASH_ALG_SHA384   0x00000004
> > > +#define TCG2_BOOT_HASH_ALG_SHA512   0x00000008
> > > +#define TCG2_BOOT_HASH_ALG_SM3_256  0x00000010 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_256 0x00000020 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_384 0x00000040 #define
> > > +TCG2_BOOT_HASH_ALG_SHA3_512 0x00000080
> > > +
> > >
> > >  static const struct digest_info hash_algo_list[] =3D {  #if
> > > IS_ENABLED(CONFIG_SHA1) @@ -310,6 +317,24 @@ static const struct
> > > digest_info hash_algo_list[] =3D {
> > >                 TPM2_SHA512_DIGEST_SIZE,
> > >         },
> > >  #endif
> > > +       {
> > > +               "sha3_256",
> > > +               TPM2_ALG_SHA3_256,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_256,
> > > +               TPM2_SHA256_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha3_384",
> > > +               TPM2_ALG_SHA3_384,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_384,
> > > +               TPM2_SHA384_DIGEST_SIZE,
> > > +       },
> > > +       {
> > > +               "sha3_512",
> > > +               TPM2_ALG_SHA3_512,
> > > +               TCG2_BOOT_HASH_ALG_SHA3_512,
> > > +               TPM2_SHA512_DIGEST_SIZE,
> > `> +       },
> > >  };
> > >
> > >  /* NV index attributes */
> > > --
> > > 2.34.1
> > >
> > > ST Restricted
