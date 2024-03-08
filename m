Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1446C54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 19:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB0F87CFF;
	Fri,  8 Mar 2024 20:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="m5WI9MzH";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="cIPa2lhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC82487D39; Fri,  8 Mar 2024 20:24:23 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC1687CF1
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 20:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428Gxm1B007444; Fri, 8 Mar 2024 13:24:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :mime-version:content-type:content-transfer-encoding; s=pps1;
 bh=YrlaxxHdIygfUzRGwAbRTRmlpYAl6PtQLXmhfDwhni0=; b=m5WI9MzHJqct
 gkDV1U5hHW+eGQgKvgeIJeqMHa0phT6O5D+xdhuyzlaIhPaJN0D+rtmipCbdDT5K
 KbCaFtDLsd0PeLEUumM1WShyl/2gMGC7IrHNTCElbtempZK/QS28nZRe1Aw5ViVF
 3RcHZRY3+CSajxcmQ+UKk3xEwhAeBKJl6bQqeU1FQq1qxvvQ62zie9jCzW21U0KN
 VifwFO3ZOx7kVwhL1vkGGHdOVHdDc0lcN6gu2s8fwhWeSk8FvSzlINVsmyxV9Weg
 /dvjlqT9chaoXlHUz2bgKTf6jJDhyZFoce+bFGqsPMP84j8d30K21CyWw2DtqB47
 WFJp8G41Jw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wr6pcg8f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:24:15 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/hMHWiWkPCJTteOeD2RFgjIiR03io02mpV+d4SVnUeq8J8tv/tSlrx4iVPyOjH9pF/oqFN0we9LENWHFYNO9Ake7+IpB6fcDHOTIPxRy5p/FOXjIwqWfm8NI7cKxKqQle3GkZJGpsVveNqEaRCTl1HTExiLVT31/53dFJ5XxUX8aWjZsCpiMIQ6Bq95dU2aW2kb4XRxu55BZqiXmnjDu1DpNBfEpLV4dED6TA4tIC6tGw7L8X/U93DKIC5oqhEjgJmWPByXobqwr8lxnW7QEymeo4rWZNLLlVtazy5tmW66iJWRjbjoEywYyZHtS5MiLTa3ei2gLnNOnxWtCA0Nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDC30e03g51a70pIBer0THsEUxRe4581OrkYWaSvdno=;
 b=YwI6qtbUDa4pFe2jIBQ8TGwG+8BBSOL575rwjfQZTy4yGdV8KZ0nWp9UpLWu0WrfE568GFW83EHS2U7EOV5MXM8QZJgUcjAVzF5Qe+Lftbws/4nwHAFWR8EsVuISOyjLHh5FKZd8jcln+bnCuRCLqf7wQYYYmEfhoyG4hFChC9g15G7Bng+ZORDoN2als63PuzFWwwyxtdRRyAwO82wB53UxZfpwRYb7oGwnUClL9hAn9C2T7EYxrv25um906GkXJMfYWXdWlgnXV2fqmK0kAyol1Nn1qwh9oQJqggCELaVqrkzXreknMBQD3dN3pFODMg+Ub0RXPaiZjjAXmI8b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garmin.com; dmarc=pass action=none header.from=garmin.com;
 dkim=pass header.d=garmin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDC30e03g51a70pIBer0THsEUxRe4581OrkYWaSvdno=;
 b=cIPa2lhK+uE5QjW9cb46RFpJ9PEZNsBM9l8KfrflLUkIJuy4AV3AiiSwf0JR41jB+4oTePQSRD0qg6P92Cu98Er5agZSakz/z7u24StgJTQ53HQudjPWfywrb7gmRzttL2DLmZGABrppJBenGTGmqhAwylfeXTt5HisHbA3F9+EFnMxFuLBnelhZjdbr4XRS2EU9K3NnQSogX/BOeZsci+rUQwTVF/N7sthkwRO1ER32mH20DYZ7A77d9iJOo27ChcFDaDijyeCEFpbrSYzbkbEtCVyFZ+iONjIC31eFip3aGPsTQJJKlTiEJJhgmSO+5JTVCnqvC6qRWGfNQNFGYg==
Received: from SA2PR04MB7723.namprd04.prod.outlook.com (2603:10b6:806:137::18)
 by CH2PR04MB6744.namprd04.prod.outlook.com (2603:10b6:610:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 19:24:10 +0000
Received: from SA2PR04MB7723.namprd04.prod.outlook.com
 ([fe80::84ee:c0c:4575:d02b]) by SA2PR04MB7723.namprd04.prod.outlook.com
 ([fe80::84ee:c0c:4575:d02b%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:24:10 +0000
From: "McAllister, Colin" <Colin.McAllister@garmin.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "JPEWhacker@gmail.com"
 <JPEWhacker@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup
Thread-Topic: [PATCH v3 0/2] Fix Android A/B backup
Thread-Index: AQHacXoPjin0fPlRhEye4OlEv6uxc7EuIFOAgAAUmtk=
Date: Fri, 8 Mar 2024 19:24:10 +0000
Message-ID: <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
In-Reply-To: <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Enabled=True;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SiteId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SetDate=2024-03-08T19:24:10.257Z;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Name=Confidential;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ContentBits=0;
 MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Method=Standard; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR04MB7723:EE_|CH2PR04MB6744:EE_
x-ms-office365-filtering-correlation-id: 5623ca01-3023-4389-5bfd-08dc3fa554e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8LnSDzlwElC4kX6PntOPTeHc6ITYwhWwZnXZd5BbVkt1sqavkEhz+rGbNg36KoPaNX7bDLd1NwneHWWPFcpaf7HUnjg3JWGb2S7R/mh9h6alb8mxFRSM4o/TYyzHUCkDoeSDRgqyRhYGEww0c/DhFs+P4bwBroganwBdoC+Ygsm4OxbF/C43HWELjGz4lOt0yjEGbGCLWXbMeZPJ0aXVydCozM3DEYRa8WTEchLsLyol7BU3e/rKeXcchWiXvpJS+krY907eZSn0oD1/ryawKgUn1cXFiuef/VG6uhJR/RMGPiGRsHN2jVD+435In50ue1a4m75Uh++oaBtcHHfyJC+p2jW5G38zORXd4NGhX4nIhWsGHhbhv93YtcsbRWUOecMnMbr4T5p1d6c3usgX/zZdvLvDUsoTvCTg/51eZofYnYdR/P0xlOgHkTBXBfJdxTKiyyMUXxrzqypU9UQXTBG+ETAGq4T33UQi3CrWxNYvpF6oXuWJBnYLibmv0sMZCkq0Yt0Bmk6U39/I0k5xPpBHDe54g5vE6sXnx+fZsUnOdv8TvuAdCBvb3de00vb5aWBY2fl/SKwH0J/MJt2YgOQ5F/VMmrSczxldnRFI57a9EVVgZm+ACbjs2Krt7M9aSuHTj3htXkhbOd5YNj9c16SpnCCJq4fCev7MOPDkpI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR04MB7723.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWV2aGhsWERxYW9pcHhsdUFCVXpyV2ZzV3kvZXdKOSs0MjZXUm9FaU9IMUlB?=
 =?utf-8?B?SU9kekpMU2cvdDZXWUg5dndFZDhMMkhTakZpTEk0V29BTVV6a2RsVUM5RENL?=
 =?utf-8?B?OXJpb3pSNitKNHVGVVhxZkZZUDk0ODFaN0o3Mllwdi91VEl4L203NU9IVnVJ?=
 =?utf-8?B?cDFWeU9NNmpDa1g1L3I1QnJnK2gzejNrK3cwQS9wOEZNWnZWUTVDellrdGxq?=
 =?utf-8?B?d3FDTEoyNEV4cklpT0dkeHJiTnFUYzNSVlc5NC90VFZYZmdXeE43dER2ZDZ1?=
 =?utf-8?B?clFEL0E3VkRCMlNyTUFyVnZ1cG55b0pUSEJ4cllSYjFja3JneXhMSjl6RUZq?=
 =?utf-8?B?YVpFNXoyMDNKQVVMY3IydWpISkRxWHpwZEtpTWw0ek00WFZJNDQxYnF0UmQ1?=
 =?utf-8?B?UEgzOUdybVZqdkJQc3F2RGJvdUNrekgyZ3laTlBCbktacFprT2JXWUorRlFm?=
 =?utf-8?B?RXQ3b1cvZktZcUh6TVBjTGRNZjR1ekFqRVhvekhiMThKUjB6dVc4OFpCKzBs?=
 =?utf-8?B?SkFHc1JTQ2oycTNCeXpKWG4wQUNyM0FTRFFuYmRyZHhaeklqMUc4Q2VGK0Vi?=
 =?utf-8?B?R0Y0WWQyQlBiMnJpdHI4b01IeklCMW5WL25VOHY4YlhDUXNOUUlrOC9tbmxh?=
 =?utf-8?B?VG9sQjZveW80VC8zdEM1YjByM0s3MlFHYmZJT2lHQkp2Y0NBVWcyYmx0cVNH?=
 =?utf-8?B?amhpcDNQVVFqWWtPNE5JMyszMkp6T0sxT2QzNlBjME1IMi9ydVdZVkFoVGFC?=
 =?utf-8?B?S014Q243Q0RqNEFOQjY3cUhnZ0FUR3VLSDcwV2NldnhxS2t2ZEZHU2w5SldN?=
 =?utf-8?B?SCtEdXhlbnRHUDVSNzM1eTZBMnNRL1FzMzJRNHA4d3psa2pSTVRaUytuNlJ1?=
 =?utf-8?B?eG84WklxaDJESXd1cEdDQnZ5YlpFY2phVzdxdm5GWllKT2QweHg0R3FRVVpk?=
 =?utf-8?B?NExMeTdISHFOQkoyaFY1dmxWSFFKSkcydWZETEttUFBSV3JHQVFVaEd0S3RE?=
 =?utf-8?B?MGs0NVJmYURoVGxlS3FYUkMrWHhzNUlkSG82aERNY1duUmZFdmdBWHJmTHMz?=
 =?utf-8?B?c1dFdVBENnJHUkpxamRsWEN3TnJNOWR1ZlozYTJYMTlQL3JhS1JqTitrQXBJ?=
 =?utf-8?B?VWRQWEVGY0JwWkJSbVluaG4rbkt4SnJYNWtmQ25laGw0ZTZwRS82YUZ4NHdy?=
 =?utf-8?B?MzRYMWVtSmdFK0lkSGN2L2tVcGlHNHIwb2dWMGYrbWNsQ0lJWHcxSmhpbDcv?=
 =?utf-8?B?WnlLRzZ6NkYvWGlFVE90TitENTVZWnZ3VUhTZHhFcUFjcFVKSWR4OVpNOWRQ?=
 =?utf-8?B?VGI4SnNrN2NiR01BcWVwejBtREVkVER5cU4rL1M3cTlqbjRVeGVLdmQvYWxF?=
 =?utf-8?B?OTRPanU3Y3krTkY3TFN1TmMzbW85TTR1RUFxeUIrTEJ2K09sbmtSZUdGbjk4?=
 =?utf-8?B?UXNjdzBNSWg2TWNwVjJRdnhHMURFdWRDcXNlSVhXbUFmOU42UyswcFRKalBj?=
 =?utf-8?B?N3BJYlQxMnFMbGJmb1RySGpaRENKWjI2QTFtSmVHblFLalF5OWQwRG50MVdv?=
 =?utf-8?B?RGRZQ3BnZ1VRcTB5UW9vaEZKK3NRa245Z2QxRW9yaTRTNUJ3bjlqRmIxVllL?=
 =?utf-8?B?dzVlUlk5NTdJV202KzcwWmZ1a2trdXhWR204Mm5jeXZoaEhPdDRmUDZyZjd6?=
 =?utf-8?B?UnVITTVERWg0RC9EU0hPejRFaW81enlKa2JDRitEdWwwd1FNdGhWWjVEamJv?=
 =?utf-8?B?ZGdRMG9pdkZueEVMQlVaUlZ3K3AwOWpNZHlsR3pOOFUzUmR0d3RublFuU0x3?=
 =?utf-8?B?MFYrQ2Y5V045WUxqZnk4b0tMQlhmcVVoK3UvREpEVEUyK1dZQjg1RGVxZURw?=
 =?utf-8?B?Tk8zdzhxb3FIbjM2U0sxMVVaWjNReE5qU1kyT1NtbzEzUUhLT2Z4eVovbktU?=
 =?utf-8?B?OXNQZHpweHpzZzVNamFBbzMwZGFOZmFTMjQrbVo2MlJkdm5FeW1IV2dOSTcw?=
 =?utf-8?B?OU8xL29iKzNqMUx5Vzh2bXBCNVV1L1VCdlNNM2cweFZmSUxOTVRsREZvSkh2?=
 =?utf-8?B?UHZ4YTJta2IyN2twcGRNTjJaQmluaTZ3OFNxOXd4MkxtK2ZIbzZ1cXNqd2Rk?=
 =?utf-8?Q?CNUsTcfGzGfq3Yg/lc/9OCHmD?=
MIME-Version: 1.0
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR04MB7723.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5623ca01-3023-4389-5bfd-08dc3fa554e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:24:10.5736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITvhtioAKRKSHKFSy+qjvFY+ZHy8zn0wmBB/h/DYyy47ymFlCMO2qxUte04GGjnkYgYCzjv2zyw+414pT7mvQFQ3pJiEHqxwqfjaWQvSD9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6744
X-Proofpoint-ORIG-GUID: y4SZTM-76JbVAyohGBNvBV0lB1Krt0-1
X-Proofpoint-GUID: y4SZTM-76JbVAyohGBNvBV0lB1Krt0-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080153
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

> Ah, ok, I see you replied to my comment here.

Yes, sorry. Outlook is terrible to send inline responses too. I figured
just adding responses in the patch contents would be better. Next time I'll=
 submit
my patch with a different email :)

> So when that config option is not defined at all, the build still
> works, right?

Yes, the default value for CONFIG_ANDROID_AB_BACKUP_OFFSET is 0x0, which
would evaluate to a false bool value in the if conditions. I did do some
testing with the config value not defined for my board and confirmed
back-up data is not used.

In your other emails you include your reviewed-by tag. For clarity, Am I
supposed to append my patches and upload a new version? This is my
first time contributing to u-boot, so I'm still learning the workflow. I
didn't see anything glancing through the "Sending patches" page in the
U-Boot documentation.

Best,
Colin

________________________________________
From: Sam Protsenko <semen.protsenko@linaro.org>
Sent: Friday, March 8, 2024 11:54
To: McAllister, Colin
Cc: u-boot@lists.denx.de; JPEWhacker@gmail.com; sjg@chromium.org; Mattijs K=
orpershoek; Igor Opaniuk
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup

On Fri, Mar 8, 2024 at 11:=E2=80=8A00 AM Colin McAllister <colin.=E2=80=8Am=
callister@=E2=80=8Agarmin.=E2=80=8Acom> wrote: > > - Addresses compiler err=
or due to missing semicolon > - Removes use of preprocessor macros with AND=
ROID_AB_BACKUP_OFFSET > > Bug


On Fri, Mar 8, 2024 at 11:00=E2=80=AFAM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> - Addresses compiler error due to missing semicolon
> - Removes use of preprocessor macros with ANDROID_AB_BACKUP_OFFSET
>
> Bug was found by noticing a semicolon was missing and not causing a
> compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
> a patch to fix the semicolon before fixing the #if's. Testing the latter
> patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
> compiler error.
>
> What's changed in V2?
> ---------------------
>
> The second verison of changes removes the #if preprocessor macros to use
> C conditionals instead. There was some minor refactoring required to get
> this to work, so I did more thourough testing to ensure the backup data
> works as expected.
>
> I also realized that CONFIG_VAL is not needed because there's no reason
> for the SPL or TPL to have different values for the backup address. I
> opted to just use CONFIG_ANDROID_AB_BACKUP_OFFSET directly.
>
> What's changed in V3?
> ---------------------
>
> Added "Fixes:" tag to patches. Performed additonal testing as described
> in the second paragraph in the testing notes below.
>
> I opted to not use CONFIG_IS_ENABLED because that macro appears to only
> be intended for y/n configurations. See note at top of linux/kconfig.h:
>
> "Note that these only work with boolean and tristate options."

Ah, ok, I see you replied to my comment here. So when that config
option is not defined at all, the build still works, right? One way to
test that would be to use buildman tool for all boards. Although I
have to say it might be very time consuming (I usually run it
overnight), so I'm not asking you to do it in this case, it's just
FYI.

>
> How was this patch series tested?
> ---------------------------------
>
> I built for my target with CONFIG_ANDROID_AB_BACKUP_OFFSET set to
> 0x1000. I first verified that the device can normally boot. I then ran
> dd before rebooting to corrupt the primary data. I confirmed that the
> backup was used to properly restore the primary. I then corrupted both
> the primary and backup data and confirmed that the primary and backup
> were both reinitialized to default values. Lastly, I corrupted the
> backup data and not the primary data and confirmed that the backup was
> restored the primary data.
>
> Addtionally, I disabled CONFIG_ANDROID_AB_BACKUP_OFFSET for my device
> and confirmed that after I corrupt the primary data, no backup is used.
> When the primary data is not corrupt, the device boots normally. This is
> what I would expect, because CONFIG_ANDROID_AB_BACKUP_OFFSET's default
> value is 0x0, which would evaluate to false for all C if conditions.
>
> Colin McAllister (2):
>   android_ab: Add missing semicolon
>   android_ab: Fix ANDROID_AB_BACKUP_OFFSET
>
>  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 52 deletions(-)
>
> --
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.

