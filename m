Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2147BC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8262E87F28;
	Tue, 12 Mar 2024 15:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="G0NO0fNt";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="nAYq30cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DB887F28; Tue, 12 Mar 2024 15:05:14 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD3587F3F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CD4gJw025385; Tue, 12 Mar 2024 09:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=pps1; bh=1Rv+NEYCcQsU7QhSP5m6jmf1C
 uvFmi+wHnkR/g1l5Zg=; b=G0NO0fNtD20lUFUhBGZ+uJtjMHCvgwz5BqjuJ5jXI
 Rmjmj8haNg9d46k0jdLSGQsZfQ9dJtQ1ZpeChZgJKgILUAbJ7nCIPjvf26avkmzA
 wy4BhN8piP6HHJj4dHob7Y50Qr7ni2shiisKbyYxqWj2CysL4Z/zGnw5w5iK72El
 Bf45e9vAiUJRkHIebrjK6aTBkajGzcvOyJHHrjjRhuUbL7p4ggCsOVDWA1/KpXuV
 dVfPE8DHfvqTkMjqBmmliu4OnnmEjy+FxeilXDqn5Am9o3sNn3rWNR8doA45iYkx
 yvKXCHe/vCKdKUSgiUiY6VeegRKDs0h9Z99RCzxYMBdbw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wtmw00ut0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:05:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORQGiibUvTCH2g0NDajw2n3z+E5L3aAr+zWflHB6m8BAvjvR4xycV1E84WtoKKu3vvdE6Ax+ppPLu6ShslOagyl29LygOkLD2llgBWtl6X83nPNpFKnx9TGPJJ9VVF+ZqJZ8KUI0eJk/D767P58nEhPNRtHdB3i5oG8lkAd8uGowMKFkHhZ7CRrO+RheuqcLI0ezkq9v+heM5K71PwXPJiGgJSzmEkYFDvgP8/F44LlMNXqDmBHWHKZ0JfWwMyxF2DixBTp/4wDyYbR5WzrTxoRjg2d3VZyUaMZhQxc3jy/9Zsk9cKBDCKkgOW9UIhmuzPJ7gsmc4dhGzZ1B7RP9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Fe961abPKwGE9SbXJg5bu+c4k3LYfGcDw5BkLI/Yo=;
 b=CqNn5EK9fG9qBrHnLYNKCu1x6aAHl8yQUFcGHYe8n6OIe6Cuxnw3bxbFmRmbI1WSvXxAMtSiXgs5+NZ7Pu2vqL9Hq8tJyO1CqApoS0pfLOBQGj8NdgnwMple28ntVhHYcrbSA8riR4ym4nLMWAo1eRO55l/D6cUO35+wkHQfeEoYbQvbG1pVlAiX3OtBjAIssARD3wpTnWJ+h5E9Ejn9Y0sZDCXzDmEJLiKIWPflFSnU8biMYj3S0Rlm3HUUpiNYbifXGEe52FQUM3s8ZOQAQAU0MgTC7XfGhDp8+ynliPZeuOuXOgd/QOUs1qrjySLJgwqIbrGyzfoein/jMyfSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garmin.com; dmarc=pass action=none header.from=garmin.com;
 dkim=pass header.d=garmin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Fe961abPKwGE9SbXJg5bu+c4k3LYfGcDw5BkLI/Yo=;
 b=nAYq30czx2JJZTdAc0H681RzXu+Q+7K57PI0tz+1dVpu+YIioPrKDKzPoBRtphCqMtg7nGLaHR54DqGl0A0lBXrSWzDFvxKw5w7DN2eOntrSoihndfchykvUFbhNpx66k7u+V8qZu3+hUvoAUeoJ80x67gjR5oJ5mkI5a0vp4NViagRK+OlUTZ5pcy0ifqErU9KcHOkqKgYvJeIbv53IitIHBOSEAwfI4JuBeHOppKhWrEU5uZMaa5mRDoCeu4eWXXgm0TvHQ9zN9KLGy06O1EnMEcXcyOfVd8ZvQo+dbWN/oJATvppg3hfr3qkOEQFiIG27UKZa5CUgpxxJnhu0lQ==
Received: from SA2PR04MB7723.namprd04.prod.outlook.com (2603:10b6:806:137::18)
 by MW6PR04MB8819.namprd04.prod.outlook.com (2603:10b6:303:23b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 14:04:59 +0000
Received: from SA2PR04MB7723.namprd04.prod.outlook.com
 ([fe80::84ee:c0c:4575:d02b]) by SA2PR04MB7723.namprd04.prod.outlook.com
 ([fe80::84ee:c0c:4575:d02b%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:04:58 +0000
From: "McAllister, Colin" <Colin.McAllister@garmin.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sam Protsenko
 <semen.protsenko@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "JPEWhacker@gmail.com"
 <JPEWhacker@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: RE: [PATCH v3 0/2] Fix Android A/B backup
Thread-Topic: [PATCH v3 0/2] Fix Android A/B backup
Thread-Index: AQHacXoPjin0fPlRhEye4OlEv6uxc7EuIFOAgAAUmtmAADAKAIAFfHGAgABHT/A=
Date: Tue, 12 Mar 2024 14:04:58 +0000
Message-ID: <SA2PR04MB7723DDB13510F1930459C073F42B2@SA2PR04MB7723.namprd04.prod.outlook.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
 <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
 <CAPLW+4nQBssOtR_wqU25XW-6ZDEm7Yu_7q9ODjWhkWoE9FoV9g@mail.gmail.com>
 <87v85r4wao.fsf@baylibre.com>
In-Reply-To: <87v85r4wao.fsf@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ActionId=9a3ed1b8-d770-484d-8f92-8e36812f4381;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ContentBits=0;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Enabled=true;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Method=Standard;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Name=f3ff6d80-3782-4df6-bf6c-659f84558040;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SetDate=2024-03-12T14:01:52Z;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SiteId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR04MB7723:EE_|MW6PR04MB8819:EE_
x-ms-office365-filtering-correlation-id: 61265013-6634-4772-a550-08dc429d66ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdbKF4ei85lwawSBim35HS/kY/cpxEPNU5NeO1HikAThtF5GDDrj+Z0GabVaogWunE7Cld1ktpQcEQIeW9GLWoEwzVzK2e9LnV+MkcRDoLgHSng1Y3tn4Pf7A39gMM6FPONubmbmJBZqZLzzXrcl5GY1G+9zasBJHoDF6eKseWIJuM2ZEiQewa8vNc5uhq2OPHPPnYSd/bHe6f2M3tYeqBuRhzL7KWpyGPmmLhcb+O0ILEB95u+3N4D53r+tpJu66d48EfsrCQRd4bQFp3U63eqLA6pnCOaoApyeos2e6CyxlkZSe64lZGcQr1fNNc/WFC9hxn2pRCJ3mBkZ33X4u1ogkE4cd7WKyAoYNM0pJ+wwl6vzUySRRaBChBp4uibEAc0FwaEwZ2pdWZ1MgIoGbyJsaX9DD5pQPh5yV7hLJBD6b4fswKacg6mGQli3oofSsITjslRC0ZKqIfMwKAI4JQc3H/WkkqwSXyxzsx6vAMK9p3Nie1ql1+swTY0GmvnJ1enxLYaacWmESAGeS+ipturcwilEZMI5HKkBNnxP+6yCG9z/mFEcF99a9gwjQjYedSjZZSFVh5DXDSBh/xXiHK8lVL10iMLee2m86sEKHZB9ZUAjrGT6qUp4jllCNcbXcllwCcb2DA0WNBWXvxrkarXK6SU4GtVUGs4/8C78BV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR04MB7723.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VnODJvbmR1c3FvN2N0TXE5OUJGYlU0VmRhYXBLaFlJbnBrQVU1c3RXeXR5?=
 =?utf-8?B?dW90K1VpeFVVRFR4NkdOVWRsM2U5bktLREk0S3ZsNUVVT1Q4SVlTUXpRZVRO?=
 =?utf-8?B?cHgvNnQwcmt6R0RERWtHMzJGTzIzd0VncEVOa1YzRFZ0TDFSR0hKckIxb0Zu?=
 =?utf-8?B?WXRPU1lJMHc0eXFSU1lqWEh3TTlRYzY4Zi9FMUl0UnE0eU1GeGR3MTUrTVVt?=
 =?utf-8?B?SUR4d2Qzb3dpK2RKYk5GVVpYRWhlR21kQm55V2YxUExGb1VEYnduU2ZxQm4w?=
 =?utf-8?B?WXhtK08zeDJ0UzFQdDRoT1pBUUlablMvTUo3T1ZQd2J1VFNaQllRSXg1Wk1P?=
 =?utf-8?B?VHhVUkdpOGoyUGN1cjQwNkVRUjRkYTdjOVNqWTFhQ0lSREhaUDhjRFA3NUEx?=
 =?utf-8?B?dXJFRXlNR0d2TlQ2c3RWcVBXOGxzZTQ3bU1NTS9yb0pjOXlGcGE4Nml1azFp?=
 =?utf-8?B?Q2IyVldPNnZwVFk5MW5EYkZ2ZjYvS1pENUloU2crdVZrU2tKOGJ6WXFWVnYv?=
 =?utf-8?B?dUcvN3BtMXFSeXlDQVg5ZHpEbU0rRmVKSTdUc2hBTHBtS2lHTWFsWDc2bWlv?=
 =?utf-8?B?cUxDRnpyTUtVQ2JHVWV2KzhhZ0VRZm93b0ZBRmFNb1ZGNVM5WTZYWkJSZlV1?=
 =?utf-8?B?QnF4WndjR29XbzBpWGtha2p3L2pKM2N3RnJUck95dGpNWFg0akNZWUpieFp1?=
 =?utf-8?B?NUYvSyt1UG0venNnMExOajF4UU5UWGFXaEU3Q3pBSkdSUFZ4NlNmekVkeVhl?=
 =?utf-8?B?SHErNm1hckZrem5tQW5iZWdXcTN6NjJFejJLNm5KYjM3YSttTjdtd3g0bWlN?=
 =?utf-8?B?NkRmc1RLTmZNNGxMcTBJNVYrR1BlZk9DM1hXTHFyWk14VVc0Q0N2UGE4b3E5?=
 =?utf-8?B?aThiUmhiV01UaVZIL3hVZUs2L3hwdGpmSUUzZGJ6UnZYWjFrZyt2UldIeVFC?=
 =?utf-8?B?Q1E2NW8wa0VqU0MvRng4UWluOVg0T1MvYjNaSE9BVzFKQy9JclEzTXovVnBt?=
 =?utf-8?B?b1JYZzFJUkw5dm55UStHcGg2QzhUYkltOVM3SjQwT09wWVozRDdybnBaZ05l?=
 =?utf-8?B?MkFXQ3hCWTZaVjJodUhxaUlNV1BUbkJ1ZEVGNEU2cHdlNk42bFZlVEZjTEdk?=
 =?utf-8?B?STVST3R0YllXM2ViYTJSSmM3WHhCYWY4Rzd2MTVBVW1QcUVaN2pmVlZmZmU4?=
 =?utf-8?B?OWVYeHQvZE9ubnNlN2ZCRkEwZ25jUVRiT3oxMXR3cktFVWZKK2NBQVNDbyt6?=
 =?utf-8?B?MXY2eTBxaGpyZGxoTXU0MXFGS3hNTFpHd1ptUnFkL2pMbWlJRWRDN3U2L1RP?=
 =?utf-8?B?RFBsWnlYSUk1Z29ITlVEZFRmWFBJenl6d3kxM09wZ2doZVRnV3QyR0txdWsv?=
 =?utf-8?B?ZFZDRFVBN0lVcWlTRktydFBjSEdGWU1UdFRFWVE0TXc5U2JNOGZrMUpSQ3Z3?=
 =?utf-8?B?VmJ3dUhtdFVIMHZWL2FoN1UwZENzbVptc24wRWI4VVU1VEc0UFlXTXl1WUM3?=
 =?utf-8?B?SnFxLzB2ajFlbFJTRjlMVFNaem1adzM4ZVhNRzExWjd2dTBWNnVDNm01diti?=
 =?utf-8?B?dmNiTUxSWEFCeTBTcVJsN0JJRUZCMVFlNklFd3c3Y3MrZkVkaHhNWGpMNVZr?=
 =?utf-8?B?ZGVuUmpoc0hUK0c3SWhXTmxDZm92UmdsaFpIeFBDQnFXb0w5RFFyeGhRcXoy?=
 =?utf-8?B?VWkySVVmN0xiZ0lOVStwSXorVHJSNjBTT24yRGkyckZ5RkhIM1k3aENFb3Bk?=
 =?utf-8?B?aFZjeFlkZGw4a1pwWk5GM0R3SENiSWZEV2lmVWlPMklndEFXc0MrOEhpNXF2?=
 =?utf-8?B?MnpaQ3gyM3lRdU51ZnNXd0NOVWV2U09idjIvcmlKKzVLZk5pUlZ2cDVDUTZH?=
 =?utf-8?B?RFdZTDNZQVNjSFh2bzF3cnBscUQxb3htQVBxdjFqSHBFV1pnSk1ZdmZORlVI?=
 =?utf-8?B?Sll6SVFqNStOazZjLzZZeGl1bGRjc2NsWkFSUkd3S2l0b09tWHZNSExpdVM1?=
 =?utf-8?B?L3JFWWM4ZThBYkY3UFdyY0FQamZySjQ3cjVVWkJGUnY1aHNZTmk5UTRQdjh6?=
 =?utf-8?B?NktIR2JNU2l6MHh6SWNhMnRSc2d1Z3BQTTlhbkZjUG5NYkM5MktScENtOE1u?=
 =?utf-8?B?Q3hHMklYZGJxRUhZY000Zm93VXoxMzhNWGI0VWg4eG45S1IyM3kvL0JWTmVV?=
 =?utf-8?B?ZXc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR04MB7723.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61265013-6634-4772-a550-08dc429d66ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 14:04:58.3652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/Pqy6wiB/Inx8RtViMBbD9syuFcl+Iu7Vzm2RegJMRu/8FZR3LqAsBynw5UkYIZafQEP9AWoy1gWh4UvXY/UFoviA+9lEGmOEuLo1P7U6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8819
X-Proofpoint-GUID: sTuuU0b0SYzsfn54YE5t_FFRJil9K6ev
X-Proofpoint-ORIG-GUID: sTuuU0b0SYzsfn54YE5t_FFRJil9K6ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120108
Content-Type: text/plain; charset="utf-8"
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

Hi Mattijs,

I=E2=80=99ve been using git send-email, but there might be issues with what=
 the Garmin smtp server is doing to the email, like adding the footer. I se=
nt a v4 PS in a new thread using my personal email, but that email isn=E2=
=80=99t subscribed to this ML so I think the patches are pending approval t=
o be added to the ML.

Best,
Colin

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Sent: Tuesday, March 12, 2024 4:47 AM
To: Sam Protsenko <semen.protsenko@linaro.org>; McAllister, Colin <Colin.Mc=
Allister@garmin.com>
Cc: u-boot@lists.denx.de; JPEWhacker@gmail.com; sjg@chromium.org; Igor Opan=
iuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup

Hi Colin, On ven.=E2=80=8A, mars 08, 2024 at 15:=E2=80=8A59, Sam Protsenko =
<semen.=E2=80=8Aprotsenko@=E2=80=8Alinaro.=E2=80=8Aorg> wrote: > On Fri, Ma=
r 8, 2024 at 1:=E2=80=8A24 PM McAllister, Colin > <Colin.=E2=80=8AMcAlliste=
r@=E2=80=8Agarmin.=E2=80=8Acom> wrote: >> >> > Ah, ok, I see you


Hi Colin,



On ven., mars 08, 2024 at 15:59, Sam Protsenko <semen.protsenko@linaro.org<=
mailto:semen.protsenko@linaro.org>> wrote:



> On Fri, Mar 8, 2024 at 1:24=E2=80=AFPM McAllister, Colin

> <Colin.McAllister@garmin.com<mailto:Colin.McAllister@garmin.com>> wrote:

>>

>> > Ah, ok, I see you replied to my comment here.

>>

>> Yes, sorry. Outlook is terrible to send inline responses too. I figured

>> just adding responses in the patch contents would be better. Next time I=
'll submit

>> my patch with a different email :)

>>

>> > So when that config option is not defined at all, the build still

>> > works, right?

>>

>> Yes, the default value for CONFIG_ANDROID_AB_BACKUP_OFFSET is 0x0, which

>> would evaluate to a false bool value in the if conditions. I did do some

>> testing with the config value not defined for my board and confirmed

>> back-up data is not used.

>>

>

> Looks good to me, thanks.

>

>> In your other emails you include your reviewed-by tag. For clarity, Am I

>> supposed to append my patches and upload a new version? This is my

>> first time contributing to u-boot, so I'm still learning the workflow. I

>> didn't see anything glancing through the "Sending patches" page in the

>> U-Boot documentation.

>>

>

> Welcome to the community! And thanks for your patches :) U-Boot

> workflow is quite similar to Linux kernel one. It's useful to collect

> all tags when sending out your next version. When the maintainer takes

> your patch, they usually also apply all R-b tags for the final patch

> version, so you only have to worry about that when sending out a new

> version. I know that U-Boot contributors are often using `patman' tool

> [1] for submitting patches (and corresponding updated versions), and

> I'm pretty sure it collects all pending tags automatically for you.

> FWIW, I'm not experienced with `patman', as I'm trying to use somehow

> unified submitting process for both U-Boot and Linux kernel, and I

> know that using `patman' is sometimes discouraged in Linux kernel

> community.



Welcome to the U-Boot community! It takes quite some time to start

contributing so thank you for the patches.



The changes look fine and the detailed approach on how you tested is

very much appreciated.



I have a couple of suggestions on the whole series.



1. The patches don't apply:



$ b4 shazam -s -l 20240308165937.270499-1-colin.mcallister@garmin.com<mailt=
o:20240308165937.270499-1-colin.mcallister@garmin.com>



error: patch failed: boot/android_ab.c:187

error: boot/android_ab.c: patch does not apply

error: Did you hand edit your patch?

It does not apply to blobs recorded in its index.

Patch failed at 0002 android_ab: Fix ANDROID_AB_BACKUP_OFFSET

hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch

When you have resolved this problem, run "git am --continue".

If you prefer to skip this patch, run "git am --skip" instead.

To restore the original branch and stop patching, run "git am --abort".



I suspect your email provider swapped tabs to spaces. It's also possible

that the Garmin confidentiality footer caused this.



2. Using the khadas-vim3_android_ab_defconfig, this does not build:



boot/android_ab.c: In function 'ab_select_slot':

boot/android_ab.c:350:48: error: 'ANDROID_AB_BACKUP_OFFSET' undeclared (fir=
st use in this function); did you mean 'CONFIG_ANDROID_AB_BACKUP_OFFSET'?

  350 |                                                ANDROID_AB_BACKUP_OF=
FSET);

      |                                                ^~~~~~~~~~~~~~~~~~~~=
~~~~

      |                                                CONFIG_ANDROID_AB_BA=
CKUP_OFFSET



Both are minor problems.

I re-applied the diffs manually to be able to build/boot test this.



Since this is your first contribution, I can either:

- fix both myself and merge this.

- let you spin a v4 to fix the above.



Please let me know what you prefer.



If you do intend to send a v4, please:

- Do it in a new email thread

- Make sure you cc me, Igor and Sam

- Make sure the patches you send can be applied.

  https://urldefense.com/v3/__http://git-send-email.io/__;!!EJc4YC3iFmQ!SPI=
0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACO=
zFcWz8Ldw1zsFDgg$<https://urldefense.com/v3/__http:/git-send-email.io/__;!!=
EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_=
SXOw5oXUX621ACOzFcWz8Ldw1zsFDgg$> is a friendly service you can use to test

  your workflow.



On workflow, tooling, I usually suggest the b4 tool:

https://urldefense.com/v3/__https://people.kernel.org/monsieuricon/sending-=
a-kernel-patch-with-b4-part-1__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFw=
aCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8LdwuYhSjtw$<https://=
urldefense.com/v3/__https:/people.kernel.org/monsieuricon/sending-a-kernel-=
patch-with-b4-part-1__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNo=
upu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8LdwuYhSjtw$>



Regards,

Mattijs



>

> [1] https://urldefense.com/v3/__https://docs.u-boot.org/en/latest/develop=
/patman.html__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPL=
giELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8Ldyum8H6Ow$<https://urldefense.com/v3=
/__https:/docs.u-boot.org/en/latest/develop/patman.html__;!!EJc4YC3iFmQ!SPI=
0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACO=
zFcWz8Ldyum8H6Ow$>

>

> [snip]
