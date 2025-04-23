Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A0C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB7C8059D;
	Wed, 23 Apr 2025 16:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="KsuLYtnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377BC805D7; Wed, 23 Apr 2025 16:38:07 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0298803DF
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NC5f2s012200;
 Wed, 23 Apr 2025 14:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=VFf2utWy68aDC8rwVhOmKM37nZ
 y+pbVi1tvlmZyBl9o=; b=KsuLYtncinJcXdwqnYThjoph8B8wZ7nORxVYxaDiv4
 PqzH2iMBs/iifjDohhbsIvj/mbvIPUUFs/l3K59Z9dunqqu090dpQCNKo8UIM6ao
 H9IxI1m3+7HHdkarzODkR/CRwu/pFKV34KIRttiSvKpQ7vHbMwCmzQ5Mb0VgO5mO
 bN5UAodH5XXqy/TZRv60obPEUVmlSLWXtXkV5Fdx1xwgIc0RGRVyRvUHr9a0wq4q
 PQKxUXgeFbv8jfHdHVH43XdBvaS3nxgPC8YYCPADl7IL9nkdrj7kFvuOIBiXfi4A
 iuk/t3nrkw6bc1CzD0YYZRSXxz4bSIYhO5BYfMu8UVxQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 466jmpyfpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 14:37:58 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 00C5280045F;
 Wed, 23 Apr 2025 14:37:21 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Apr 2025 02:37:10 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Wed, 23 Apr 2025 02:37:10 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Apr 2025 02:37:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV/NlRLYP5BL7GZkJX+4a+/eQLchpliBTfyuUAk56hHEwx66m18Gy7ULXTxL5hmzZMWgewidgUBQ46iCTTHerkGEbrnUGG8J6LDmGDs65njNDmij3XKRhpnr25CfCCjunvCzugRgMVcUC6UZPoDzIK3NjCgbMf1FxzRlBjdRuF1IbbKjhDbe5NFS92c3Qwxz+oozC6WfOdCt1Wsmw6wOn9fGjGlwn8LqGI1lIheXAaTqo7L4OdBjkBj+dKNoV2mmfJrvt3G3xCdQs23rZngyb5M878hgNgWTRQukT4/4QhEHBssOG1uXazYGPdYKrlJ/xQToiIFiStE3LvKbrbbC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFf2utWy68aDC8rwVhOmKM37nZy+pbVi1tvlmZyBl9o=;
 b=o2EYTguxwPUY2x6gdDKCjSepqJLZYa5F5XawJj8CKA3T081SQNf/PAarfCROBvZwm5I5QltJ4W08o07ZBvS6Hg0Ft2uryTZKWSUVdqrkSeIPJZy8GWzCpBsx3Yx76GyJUqK2GDntyls30Aebh83+mgDfYFNejpMS65G0sDOiSRFmDK8UNOerZJPHt7kvk60TMnu2ugX0eh5NXBQxSPYd2M6stgytue0peCqzUhKq5DAg1Qm9J7wrhLbVmzg4urznrc7wl/B0ge+a45TwBQX/jmt1eEoZrONxTI0BxzNq6xicMdQ+d4uJZ6MzZ27t/KzoCjDev4irk5DMfJ9xGxphEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 CYXPR84MB3666.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:da::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 14:37:05 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 14:37:04 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: Wiznet w5500 support
Thread-Topic: Wiznet w5500 support
Thread-Index: AQHbs7P1niICEprfvUOJM72ihHrWULOw9bKAgABbxYQ=
Date: Wed, 23 Apr 2025 14:37:04 +0000
Message-ID: <DM4PR84MB1976A520AABEBD2B1C243683D6BA2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
In-Reply-To: <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|CYXPR84MB3666:EE_
x-ms-office365-filtering-correlation-id: 61feafcd-67e1-40ee-fbd9-08dd82745157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003|13003099007|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?dW5ldjhKbjJmbk5pN1E2U0E0UkxCTFRQdzlVbjVoYW5jaGdESkZrRmhYai83?=
 =?utf-8?B?a3ZDMVlyKzIra3BNeXI5bnU0OEVBRFVyVHZ4TkdYMzJsUnVxaHFJZUZ6VnAr?=
 =?utf-8?B?ZWcvbkU1TWp0bVNzVjFhclI4czNBeG51eU9IT3ptMUNlYUJ5SkVTR1RHYlJY?=
 =?utf-8?B?T1VsdlhNbmZmUG1WNjlUNlhoUmI0RytGQnV5QitveGlzRlVaVzFNbEJqTXdy?=
 =?utf-8?B?Z1RaQ3M2L2hETTgwaGdPRC9jcExSV0FWcElQc01iTDZLUDlROVQyWlpWc2JI?=
 =?utf-8?B?YlZVNUZZSTFGSU4xb0h3dGp3NXJiMnJIVldxZWFsdlhsUG5IbEV6c1pqWSsr?=
 =?utf-8?B?Q0IxK29mUTJ4RmZib1ZpUEdyYWxMdWU4MTZpY3d4REt6cVZyYWdiamhiRFBO?=
 =?utf-8?B?c2FmK3hGT1NnNUpYVXFPZDZBRk92bXZIdFoxRXcrZC8zRitMcjRzdEVGOXpZ?=
 =?utf-8?B?dUlCQ05tcGJkSUl1UGJtUU05eDhGNGlldWhwMGxoTVFiWGtJRy8wMll4SXow?=
 =?utf-8?B?YUQzQ1B1V1huSXNzOEowbW9BT2YrQUpPem5PWnZrZVdSK0R2Y21PYUJBMUpo?=
 =?utf-8?B?UXJodE5IdGNrenM1d1JKOGN0OTMrdWxzd05pZ0M2U3JtMXJOaE15L29DUXRi?=
 =?utf-8?B?dlg0QnBqU1MrN0RHenNsRDBqcGRiOGZCUzVUZFUvRFl3SGVuNDJUbmpLVUlo?=
 =?utf-8?B?SFZJdDBlTEs3M3ZIUGpHNFc0bExYTXp0dkxTSlA5ZmtFME5XMGxRYzFyTlNu?=
 =?utf-8?B?YitSQlM1Z0xnRlh2NTM2SklpS0g3NUhqampjdnhqalNvRDUwTmlxMnN5NTM1?=
 =?utf-8?B?QlA2dytDQTlpTDgwcld4UWNIRmEvZnc0cnlzTWlrazRna3ZYaGZSUWtybTBT?=
 =?utf-8?B?S3hocnk5N3lKSWZyN2krK2FBcGZOMC9SY1IzcUNwd01ZQnFoR2E4NGN0S3Vp?=
 =?utf-8?B?M2ticE9lc1pFREY0aDEwVDhKM1ZYOXFCSVI4SU9Wak91L05DbTRRdnBqK1BS?=
 =?utf-8?B?VklQWGZjbC9LQ0VIYUJpMllVWWpsTy9oZXNvelo5cnVOSTdCYjNHWEszRTNJ?=
 =?utf-8?B?M2Z1TEJnRjBJUXFjdGxSUHJGUXQyWmc3alpJQ2tjVW8wT0toK3IrMjR2Uksr?=
 =?utf-8?B?VzlUaG5hQ05GV0VYc1pXbEwzN2dPUkV5V0F0ejIxdENoeXBoSDROWXI2SVJu?=
 =?utf-8?B?MXoxYjlNK1RnQkI3c1ZnYm1tQU4vKzlGbzZDcWNCNEpCMXZjOHhsZzNlWjYr?=
 =?utf-8?B?MCtzNUdxeklzUm1ac01YNVhwbSsyZm04eWdzcEZSQTkrb0pwdjNGZDhtUnVJ?=
 =?utf-8?B?U0U0NWFOME1RMzRHSGpWRkVzRXZyWHZIbkE3QmZibmZqYmhyczBURmFhTzN4?=
 =?utf-8?B?elBmcFVTZXFocmhUemJneWN1YTMrV21Yd28yOTRJdlF6K21QU2RieHIxRmlI?=
 =?utf-8?B?TmNvdHJXbDJQK1J2TmV1TEZjTzE5QVp1OUlZcWNKN29YWitwa0hYOVYxTXZ5?=
 =?utf-8?B?dFBQTGZ1UHZ3K3JOM3g1bUcvc1Ewa2JydVVSTUV6Z05WdkxtWjdaTW1sb2N0?=
 =?utf-8?B?UStFSlEwWjhJNHJwbnk2dWNwTkgrTTRwaS96eitLcUN3b01NVC9xeW5JdUE1?=
 =?utf-8?B?dHRBN3VRMUxtV3cva0JmemZmWE9IaEpQaENpRTNmWmxlOWdJODlTMmxDUWpr?=
 =?utf-8?B?dUVRRWNFdEpwWWVQVk8waEowZjhhOFczazNTbzF6U2ZpSExibktqZnRNTFpq?=
 =?utf-8?B?VnRXeG11L2t5UzFCSkRzeWptYWZOK3gxSXU4QmZlOEowL3NIdE80RThqUGNS?=
 =?utf-8?B?UFFzcXZsRjA1aCtkdTRZd1U1cUw1WHcvL0R1NGprRTVCTlkwQUhlaFRLK05M?=
 =?utf-8?B?NUU4Z2ZOSVRRVEl3cWQ2RUwyZk95TzBDS3ZOWGFpMVFic2YyNTl5dllEQVJw?=
 =?utf-8?Q?PmF99G7srVg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VuWno1V3FyZ3hKWVRLbGlFOS91bVJ2SXNFYkpCQURzWlY2Y3lvYVJuajlR?=
 =?utf-8?B?RVFpTHRmUjBMTStrUjZ6TWd4eVpBcnZlN0M2Zk1CbGYyNXUrMDROK0ZOT01l?=
 =?utf-8?B?RXVwdFV5ZXRocmhQemEyd1dnS0xNQWNPaXhoZkhJYWJxZXhYeXk4bUJzSjR0?=
 =?utf-8?B?SStIdDNhVnFoQVVJLzBKcmtIaXo5Smw0eHpWcjA5aUpSelRjRm0wWkF6azhY?=
 =?utf-8?B?K2xxUUJWQ2pVZ1FhZ1NIU0wyTmgwZ3ErczJTQjM3U3laTnZBMFAwTGNSMmdj?=
 =?utf-8?B?Y2l0UFNJSk9lTDFXenFXbjJmWFpvRGhkdWRYZDJ1aUhaRlQxNHZuOTExS3BS?=
 =?utf-8?B?OTZIZVZ5TmwzLytiR0Uvb3RNUUZsNGxkODF3cWxpVVJSWlRVSnBVeGZiR0Ja?=
 =?utf-8?B?TzZkQVh3c0VUTGVycnpJREczMlhkRVRBQ3JBdTVMaWVDcHJmNzlpbFhaOEtu?=
 =?utf-8?B?UXovUU1HUnVJM005eldGQjU5VW8zV0ZGdDlUNEZLM0YwY29kWXdTMkdRb0Vq?=
 =?utf-8?B?eEUwYlV4TVpqQVJlV3RNZTJ5SmxsWWllYUk0OHczVUdYeDJOZGlCMU1xRGla?=
 =?utf-8?B?THVkSUhZMVVrNlMzakFvVUVnSGtVZE1GY0N0Mm96aXhJV1B1QWJmcFdrSXoz?=
 =?utf-8?B?WGxrdm5sWlJadkg0NzNzck1Fc0U1MzVQa09sVHp6YUVZUFNrRDlUNnVMSERO?=
 =?utf-8?B?Ny9QMG9QOTMwWGlTR01OU3h2djB6K2NocU41QXhhUEZQYlhkZWlvVnNEMytU?=
 =?utf-8?B?cmN6Q0NEYk5Mbnc0TS93UzVsSU9qNTkwQjI5SUpQa0ZQQk1xYlo5TjFIeWdK?=
 =?utf-8?B?U1MxYTNuUVhqZEpqcWRoS2czOEdzeXFkd2ZWL00wc0U2MHllNk5LTDdPYThC?=
 =?utf-8?B?SkEyTXpMNmdpVXJuY0pmbDIvZmUwMnBobGFVYVhhMnZFaEUyMzB1QW1rVzFG?=
 =?utf-8?B?VzFrbFY0Q1FpUmowU1QyNTBKSWxHL0dGbGtmMGpiMzJ0bjZDRkdSZ3NYZFF6?=
 =?utf-8?B?MFR5cG93d0JTaHYzMldveFp0WlREdnRHOHZVWEljRVczOHRrcTkzbGlqMW5F?=
 =?utf-8?B?UDE1NDV0bUIydXlhL21ra1JjcVNRTVFUTE1xVkFnbDF2Uk5hZzNwSGU5Y2li?=
 =?utf-8?B?UWhycFZLd0oxRW4xK0V5YmN1S1o4Q1pnSTd1SUdXSVBZRFphK3hhcFVGbERk?=
 =?utf-8?B?R2dyS2IzajVBNnlRMmlCMnBybnFWYmorYmxlSlBWMU4rMEhPNmJ1azlZZmM5?=
 =?utf-8?B?OGRLMm83dXpFMGlCdTV2RTEzUHl3SkZLMERrbTAvaFYxNTVBMmp1QjF5SExt?=
 =?utf-8?B?dk13S0ZqdGQ0YTJkM3NSVmUwbjIyZjlKYjQ3VUVCbzcxN0Y2RmJvQ2FZc0NC?=
 =?utf-8?B?WHpybW5GNGVvaUhjbCt5U0hOUE5FR0loNC85bUZ5dVEvSnE2VmJzaDY0TktF?=
 =?utf-8?B?WmN1c2Z5a0VXeXlJdmRJR3prZzJRdUdXcG5Sb3pWQUwwUW1mRkN2VFpJOGdj?=
 =?utf-8?B?UDNObkRTemZHSVZ0ekpHSVd3YUdiUjFRYUN5OXRRcVBWRElEMkkyeTIzK0ZE?=
 =?utf-8?B?VjRtdUtONW5kZ1lSdytJV1oyNjBSbHMvcmJSbmdrSWd3YkdxYmFJSkFlZUw0?=
 =?utf-8?B?VWVkK2QxQnM2czZUOUszV3B0c3lvT3VHbFV1M3A0dVdtTVN5SGxMY3duay9t?=
 =?utf-8?B?VW8xMCtSRDl4bE5SRXpWUExOQUM4QTA1WVh3RjkwT0lxNmJwc0lGSWM0c3pk?=
 =?utf-8?B?a1dSbjdiRGhKazU5QmV3WVNhaENRWEdsZW9pcmphZXl6RWNkbENlSVUwU0lN?=
 =?utf-8?B?K2VpTXRyNmJJblR5QUQyWTJJMHF1OVdtTm53dWFUb3VOeXl5TEI1WXB0ZzEz?=
 =?utf-8?B?WjQxNFpUcy8yMXVLd05keksrWmEybHRrREFoWlM0Uzh1dmlSbU5heUVIQlNo?=
 =?utf-8?B?aTBCTmw4VldPZzdEc1dLaU1LaDVCYXZwQnRlQ1hIRUR0RERZT2xNMTV3MzFH?=
 =?utf-8?B?NjZ4OGhaS3RkNXVLalpiSDlCUjB6MGV0YmI0aHlnSXVJdDVhQksvaTlndnVO?=
 =?utf-8?B?SzlqYVBmeXZ0REtYRHlzV2hyanVXZG1CdHdENUhSQzFDOUZxVXQrbHdodS9I?=
 =?utf-8?Q?Vs4jbm0DlImsYXdnUyvHpTTS1?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61feafcd-67e1-40ee-fbd9-08dd82745157
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 14:37:04.8487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q65joRrvDVIB1nBpD/fgYBsycvncNd63ngefeOBIr+rQdvEB2TT/sdAA3FNWHCVT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3666
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: UGQnX2Dln5sxXBDenD8nkp_osmJlwE8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwMyBTYWx0ZWRfXx1VSDqtQPFU8
 lSZdhZfRa+3xaU9ICuezcMBMJvqV9t7NjVKO5aoE/zEPR6mTCSkmd2fMTI6DfL5DJEeGIKhp3Mn
 1LceeCO/rNtI4t9+orRr0Uh2/aWi6R0kFU0SXTs+X7kJ9wGPK2WiKIKcocvXvCg5hyIgf++V0Km
 +hvFYH9wE7uGXzewMQTQYYJO+7uYKEnU6z8dcOVjx+ItOY5MS8VclKMYBJTcKnaRz+UHLDXrElb
 WNura4z21sl+9NHr2DRMlYicKW6DmAE+D8HhdbgrSBfjad7z0ZCu4NpKaDk6w4idN579G5E7/xk
 ioFuDQos8KzrhT5kF89uoOwz2GYP5jYxBgKFC1XLoRIMNeoQH/oB2OGmC4HHxz0OY6VTGux/jdT
 paG7i+BA
X-Proofpoint-ORIG-GUID: UGQnX2Dln5sxXBDenD8nkp_osmJlwE8g
X-Authority-Analysis: v=2.4 cv=dLOmmPZb c=1 sm=1 tr=0 ts=6808fb46 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=_EeEMxcBAAAA:8 a=uherdBYGAAAA:8
 a=eYv95HnKAAAA:8 a=MvuuwTCpAAAA:8 a=bpfYyewEUbeDUOqg6SIA:9 a=QEXdDO2ut3YA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=KRyluQ8z4cW0j-tGi3cA:9
 a=pXUOT8TYTRfRlmln:21 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=Fc7fxMuEZ4-5KipR1OOC:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230103
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

SGkgUXVlbnRpbiwNCg0KSSB3YXMgbG9va2luZyBmb3IgZXhhbXBsZSBsaWtlIHRoZSBvbmUgaW4g
cG1pYy4gSSB3aWxsIHJlZmFjdG9yIG15IGNvZGUgdG8gdGFrZSBpdCBpbnRvIGNvbnNpZGVyYXRp
b24uIFRoYXQgaXMgbXkgZmlyc3QgZHJpdmVyIHRoYXQgSSBzdWJtaXQgdG8gdS1ib290Lg0KDQpU
aGUgbGludXgga2VybmVsIGhhcyBhIHNwaSBzaWRlDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL25ldC9ldGhlcm5ldC93aXpuZXQvdzUxMDAt
c3BpLmMNCg0KQW5kIHRoZSBkZXZpY2UgdHJlZSBzZXR1cCBpcyBhIGxpdHRsZSBiaXQgY29uZnVz
aW5nLiBSb3VnaGx5IHlvdSBjYWxsIHRoZSBuZXQgZHJpdmVyIGZyb20gYSBEVFMgbm9kZSB3aGlj
aCBpcyBhIHNwaSBzbGF2ZSwgYW5kIHRoZSBuZXQgZHJpdmVyIGlzIHByb2JpbmcgdGhlIHNwaSBz
aWRlIHdoaWNoIGlzIG5vdCBhdHRhY2hlZCB0byBhbnkgRFRTIG5vZGUuIEkgdHJpZWQgdG8gZG8g
dGhlIHNhbWUgYXBwcm9hY2ggd2l0aCB1LWJvb3QgYnV0IGRpZCBzdHJ1Z2dsZSBhIGxvdCBhdCBk
b2luZyBpdCwgYXMgaXQgc2VlbXMgdGhhdCB1LWJvb3QgbmVlZHMgdG8gaGF2ZSBhIGRldmljZSB0
cmVlIG5vZGUgYXR0YWNoZWQgdG8gZWFjaCBkcml2ZXIgdG8gZ2V0IGl0IGFjdGl2YXRlZC4NCg0K
SSB3aWxsIHRyeSB0byBnZXQgYXMgY2xvc2UgYXMgdGhlIGxpbnV4IGtlcm5lbCBkby4NCg0KVGhl
IGdvb2QgbmV3cyBpcyB0aGF0IGl0IHNlZW1zIHRoYXQgSSBkbyBub3QgaGF2ZSBhbnkgcHVzaCBi
YWNrIHRvIGdldCB0aGF0IGZlYXR1cmUgb25ib2FyZGVkIGluc2lkZSB1LWJvb3QuDQoNClRoZSBj
b2RlIEkgd3JvdGUgaXMgcmVhbGx5IGEgcXVpY2sgYW5kIGRpcnR5IGltcGxlbWVudGF0aW9uIGFz
IHRvIHJ1biBhIGRlbW8gbmV4dCB3ZWVrIHRvIHRoZSBPQ1AgU3VtbWl0IGluIER1Ymxpbi4gSSB3
aWxsIG5vdyBtYWtlIGl0IGNvbXBsaWFudCB3aXRoIGNvZGUgc3R5bGluZyBhbmQgZXZlcnl0aGlu
ZyBuZWVkZWQgdG8gZ2V0IGl0IGFjY2VwdGVkLiBJIHdpbGwganVzdCBuZWVkIHlvdXIgaGVscCwg
cGF0aWVuY2UgYW5kIHJlc2lsaWVuY2UgdG8gZ3VpZGUgbWUuDQoNCkZvciB0aGUgbW9tZW50IHRo
ZSBvbmx5IGNvZGUgY2hlY2ssIEkgYW0gZG9pbmcgaXMgdGhyb3VnaCB0aGUgY29tcGlsZXIgd2hp
Y2ggZG9lc27igJl0IHJlcG9ydCBhbnkgd2FybmluZy4gSSB3aWxsIGFkZCBvdGhlciBjb2RlIGNo
ZWNrcyBmcm9tIHRoZSBsaW51eCBrZXJuZWwgbW92aW5nIGZvcndhcmQNCg0KSmVhbi1NYXJpZQ0K
DQpGcm9tOiBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlPg0KRGF0ZTog
V2VkbmVzZGF5LCBBcHJpbCAyMywgMjAyNSBhdCAyOjA04oCvQU0NClRvOiBWZXJkdW4sIEplYW4t
TWFyaWUgPHZlcmR1bkBocGUuY29tPiwgdS1ib290QGxpc3RzLmRlbnguZGUgPHUtYm9vdEBsaXN0
cy5kZW54LmRlPg0KU3ViamVjdDogUmU6IFdpem5ldCB3NTUwMCBzdXBwb3J0DQpIaSBKZWFuLU1h
cmllLA0KDQpPbiA0LzIyLzI1IDg6MzYgUE0sIFZlcmR1biwgSmVhbi1NYXJpZSB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB2ZXJkdW5AaHBlLmNvbS4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb25fXzshIU5weFIhbkEtS0hscFFJ
eU1Qdy1WOEY0d0hsYm5ERUhVczRvQlVDRE5Ja1FPYUxpV1FDVl9zU0lBc2gwbXAwYlA0Q1pLbWxl
RXNTaGRjMXIxU3NZa2tyX1BpTFlBJDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb25fXzshIU5weFIhbkEtS0hscFFJ
eU1Qdy1WOEY0d0hsYm5ERUhVczRvQlVDRE5Ja1FPYUxpV1FDVl9zU0lBc2gwbXAwYlA0Q1pLbWxl
RXNTaGRjMXIxU3NZa2tyX1BpTFlBJD4gIF0NCj4NCj4gSGksDQo+DQo+IEkgaGF2ZSB3cml0dGVu
IGEgc21hbGwgcGF0Y2ggZm9yIHRoZSB3aXpuZXQgVzU1MDAgYWRhcHRlci4gKGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2RvY3Mud2l6bmV0LmlvL1Byb2R1Y3QvaUV0aGVybmV0
L1c1NTAwL292ZXJ2aWV3X187ISFOcHhSIW5BLUtIbHBRSXlNUHctVjhGNHdIbGJuREVIVXM0b0JV
Q0ROSWtRT2FMaVdRQ1Zfc1NJQXNoMG1wMGJQNENaS21sZUVzU2hkYzFyMVNzWWtrelNzYVV4dyQg
KS4NCj4gSSBhbSBpbiBzb21lIHdheXMgcmVhZHkgdG8gcHVzaCBpdCBpbnRvIHUtYm9vdCBmb2xs
b3dpbmcgYXBwcm92YWwgZnJvbSBIUEUsIGJ1dCBhcyB0aGF0IHdpbGwgYmUgYSBmaXJzdCBmb3Ig
bWUsIEkganVzdCB3YW50ZWQgdG8gZ2V0IGZlZWRiYWNrIGZyb20geW91Lg0KPg0KPiBUaGUgd2l6
bmV0IGRldmljZSBhbGxvd3MgbWUgdG8gYWRkIGEgbmV0d29yayBhZGFwdGVyIHRvIGRlZXAgZW1i
ZWRkZWQgZGV2aWNlcyBsaWtlIFBDSWUgYm9hcmQgYW5kIGJvb3QgdGhlbSBieSB1c2luZyBldGhl
cm5ldCB0aHJvdWdoIGEgc3BpIGJ1cyBvciBncGlvcyBieSB1c2luZyB0aGUgc29mdC1zcGkgZHJp
dmVycyB0aHJvdWdoIHUtYm9vdC4gVXN1YWxseSwgc3VjaCBkZXZpY2VzIGJvb3QgbG9jYWxseSB0
aHJvdWdoIGEgc3BpLW5vciBvciBvdGhlciBsb2NhbCBzdG9yYWdlLiBJIHdhbnQgdG8gcHJvbW90
ZSBhIFBYRSBsaWtlIGFwcHJvYWNoIGFzIHRvIGVhc2UgZmlybXdhcmUgdXBkYXRlcywgaW1wcm92
ZSBzZWN1cml0eSwgYW5kIGJvb3Qgc3BlZWQuIFRoZSB3aXpuZXQgZGV2aWNlIGNhbiBsb2FkIHJh
dyBpbWFnZXMgYXQgYWJvdXQgMS41TUIvcyBpbiBtZW1vcnkgYW5kIHRoZSB1LWJvb3QgaXMgaW4g
Y2hhcmdlIGF0IGJvb3RzdHJhcHBpbmcgdGhlIHNlY29uZCBzdGFnZSB0aHJvdWdoIHRoZSBpbiBt
ZW1vcnkgY29wdS4NCj4NCj4gSSBzdWNjZXNzZnVsbHkgdGVzdGVkIGl0IGJ5IHVzaW5nIGEgcmFz
cGJlcnJ5IHBpIDQgZGV2aWNlIHRocm91Z2ggc29mdCBzcGkgYXMgd2UgZG8gbm90IGhhdmUgYSBk
cml2ZXIgZm9yIGl0IGluc2lkZSB1LWJvb3QuIEl0IHdvcmtzIGF0IGFyb3VuZCAzNjBrQi9zIGNv
bXBhcmVkIHRvIDQwMGtCL3MgdGhyb3VnaCB0aGUgbGludXgga2VybmVsLg0KPg0KPiBXaXpuZXQg
ZGV2aWNlIG5lZWRzIGluIGZhY3QgMiBkcml2ZXJzLCBvbmUgd2hpY2ggYmVoYXZlIGxpa2Ug4oCc
UEhZ4oCdICBhbmQgb25lIHdoaWNoIGlzIHBlcmNlaXZlZCBhcyBhbiBldGhlcm5ldCBhZGFwdGVy
LiBCb3RoIG5lZWRzIHRvIGJlIGxpbmtlZCB0aHJvdWdoIGEgcGhhbmRsZSBhcyB0byB1c2UgdGhl
IHJlbGV2YW50IHhmZXIgZnVuY3Rpb24gdG8gcHVzaCBhbmQgcmVjZWl2ZSB0aGUgZGF0YS4NCj4N
Cg0KQW4gRXRoZXJuZXQgTUFDIHlvdSBtZWFudCBJIGFzc3VtZS4NCg0KPiBTbywgbXkgcGF0Y2hz
ZXQgd2lsbCBjb250YWluIHNvbWUgd29yayBmb3IgdGhlIHNwaSBzdWJzeXN0ZW0gYW5kIHNvbWUg
Zm9yIHRoZSBuZXQgc3Vic3lzdGVtLiBEbyBJIG5lZWQgdG8gYnJlYWsgdGhlbSBkb3duLCBvciBh
IHNpbmdsZSBwYXRjaCB3b3VsZCBiZSBnb29kIGVub3VnaCA/DQo+DQoNClNlcGFyYXRlIGRyaXZl
cnMsIHNlcGFyYXRlIHBhdGNoZXMgcGxlYXNlLiBJdCdzIGxpa2VseSBnb2luZyB0byBnbw0KdGhy
b3VnaCBkaWZmZXJlbnQgbWFpbnRhaW5lciB0cmVlcy4gVGhleSBjb3VsZCBiZSBpbiB0aGUgc2Ft
ZSBwYXRjaA0Kc2VyaWVzIHRob3VnaCwgdG8gZ2l2ZSBldmVyeWJvZHkgYW1wbGUgY29udGV4dC4N
Cg0KSGF2aW5nIGhhZCBhIHF1aWNrIGdsYW5jZSBhdCB0aGUgZGlmZiBpbiB5b3VyIFUtYm9vdCBm
b3JrLCBpdCdzIHZlcnkNCnVuY2xlYXIgdG8gbWUgd2h5IHdlIG5lZWQgYW4gU1BJIGJ1cyBkcml2
ZXIgKFVDTEFTU19TUEkpPyBUaGUgTGludXgNCmtlcm5lbCBzZWVtcyB0byBvbmx5IGhhdmUgdGhl
IEV0aGVybmV0IGRyaXZlci4gSXMgdGhlIHc1NTAwIGFjdGluZyBhcyBhbg0KU1BJIGNvbnRyb2xs
ZXIgaW5zdGVhZCBvZiBhcyBhbiBTUEkgZGV2aWNlPyBJIGZpbmQgaXQgaGFyZCB0byBiZWxpZXZl
LA0KYnV0IG1heWJlIDopID8NCg0KSSBiZWxpZXZlIHlvdSBzaG91bGQgb25seSBuZWVkIHRoZSBF
dGhlcm5ldCBNQUMgZHJpdmVyIChwb3NzaWJseQ0KRXRoZXJuZXQgUEhZIGRyaXZlciBhcyB3ZWxs
PykgYnV0IGJ1aWx0IG9uIHRvcCBvZiBhbiBTUEkgZGV2aWNlIChhbmQgbm90DQpkcml2ZXIpLCBl
c3NlbnRpYWxseSBqdXN0IGNhbGxpbmcgc3BpIGZ1bmN0aW9ucyB0YWtpbmcgYSB1ZGV2aWNlIGFz
DQpwYXJhbWV0ZXI/DQoNCkxvb2sgYXQgZHJpdmVycy9wb3dlci9wbWljL3JrOHh4LmMgZm9yIGV4
YW1wbGUsIGl0IGlzIGEgUE1JQyBkcml2ZXIgZm9yDQphbiBJMkMgKG9yIFNQSSkgZGV2aWNlLiBP
ciBmb3Igc29tZXRoaW5nIGNsb3NlciB0byB5b3VyIGRldmljZSwgbWF5YmUNCmhhdmUgYSBsb29r
IGF0IHRoZSBLU1o5NDc3PyBJdCBzZWVtcyB0byByZXF1aXJlIEkyQyBhbmQgU1BJIChidXQgaXMg
YQ0KRFNBIHN3aXRjaCwgc28gc2xpZ2h0bHkgZGlmZmVyZW50IHRoYW4geW91cnMpLg0KDQpBZGRp
dGlvbmFsbHksIHdlIGRvIG5vdCBhbGxvdyBtb2RpZmljYXRpb25zIG9mIHRoZSBkdHMvdXBzdHJl
YW0NCmRpcmVjdG9yeS4gVGhlIHBhdGNoZXMgYWJzb2x1dGVseSBuZWVkIHRvIGNvbWUgZnJvbSB0
aGUNCmRldmljZXRyZWUtcmViYXNpbmcgdHJlZSwgdmlhIHRoZSBgdG9vbHMvdXBkYXRlLXN1YnRy
ZWUuc2ggcGljaw0KPGNvbW1pdD5gIGNvbW1hbmQsIHNvIHBsZWFzZSB1cHN0cmVhbSB0aGUgYmlu
ZGluZyB0byB0aGUgTGludXgga2VybmVsIGZpcnN0Lg0KDQpMb29raW5nIGZvcndhcmQgdG8gc2Vl
aW5nIHBhdGNoZXMgb24gdGhlIG1haWxpbmcgbGlzdCENCg0KQ2hlZXJzLA0KUXVlbnRpbg0K
