Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A31ACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29140846AA;
	Fri, 29 May 2026 05:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="f9uYfOOi";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Zw9N5pf0";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Bx5H9EYD";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="SAt9Imlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0E9846B4; Fri, 29 May 2026 05:36:45 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01C38341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3NpgN310556
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=WCh2TqsFJS5uboGap5Vixw1diub
 /lGVQ4tES3H9e4w4=; b=f9uYfOOimTuUUDYqHTQQoe0wf4HwROx9a2Dbsjj0LZ3
 dVUSgf/o5jBb8UMfctXNMOGoQPogi1T5Y5r/BJCzLHf+iSDr9ypmOtDOmOjNUnqb
 gMNHTS9aq3f7biPdrBd56sDuEckgZINu/8RKti2nNzsPqptWoy3l4ckuhG45T6BA
 x47sDMzs2KLsoCzSyy0NJc/czXxYZQxxMMy3nB2kKnmUG1bIvbZJFB8BuH6suuAM
 DoFxd9FGQKZ4xVAN+tpQebLKJu2UokwJFR+fZvgk+V5v2aoRdurjJPytygD2YTj1
 0W54yeE+HVCq8+SyP7WsQCU80Jb7HKcpRqEEyDLP8gQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2uv01jd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:36:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOHucXLiuUpbkYC/KOLZOGl/Iq3NGjcx7GGh2kq4eNoPLzBUt3JqOShKiQvhf2gXvhAckaGjG4xcqG4dEe3994AgmYcwsKYUrVbAwwc4s3z+dmCAEoCMluUk/HqHi0p0iqtQaTK6fo+ieFMXIFqhQtbf5CbmZfjTyp+UK1zh316YuSfb71+PZ307WqEF91b4V3/cBg7O2GiGCxE10EeRD+/c/zgqTTNCu5maQnxoAX3vwCXcPW5n6mYvFyRy48QnK3B6qOqBB43Ll+4OJyR06BXR6+09dVRaoHL1nmrlOXM6xpmW/Ezaf6/G+QJEVjw69lkjyoLFUy/mBBQHHGsItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCh2TqsFJS5uboGap5Vixw1diub/lGVQ4tES3H9e4w4=;
 b=vJvAnz5ZFNN7mBb9Sg0wfBUckTLHgQ2sQTrlrbytBwAdC8y92/qX7/hb9KwD9ssBXaio91220mb3bSnSCCmRPnB0jAaSzJs8gyYkM56H/SWU0g5J7keoOcSVm77ABDW7X6a51sNe8M9J1WvyBVYRvfnhzn8U8ccAbiohpru/PD/DK6PGtIJ7/VmaYaZSNfd7YWdfkyp9eAWhnUYUpzop7jCcL8a7Dmoe0N66GBK51NjokaX8d3u5CNWziiWrfo8JFUtMia12vlQ7kkFznAFsu5Q5uZfuHxEuTgJscMq2fBpkSWkfYp0cMDdFa4Ks/OBvj0N2ZNqK0KBkbW1dSi94Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCh2TqsFJS5uboGap5Vixw1diub/lGVQ4tES3H9e4w4=;
 b=Zw9N5pf0KIu28aZla1IJFMsQ66DDRcFXlpNv23fmYklz4wGZgeUbRl6tLty+LKXsdrC4MvmhVe3aNYZcyg3D72l3I0BagaJGmjXl8FVNktzPCbDkq/eD4VoqUfT3NjuGoGRQ3WnBjF+VAVFNvYeFXDPuYh04a7f1XjfuTjt5BFc=
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by DS1PR16MB6681.namprd16.prod.outlook.com (2603:10b6:8:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 03:36:39 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::d) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:36:39 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1Vv9I3452360
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=WCh2TqsFJS5uboGap5Vixw1diub/lGVQ4tES3H9e4w4=; b=Bx5H9EYD8VA4
 s24LumM2dOAISxL7H1FBLnxc5Ycnb9sW9b8hKYTXadcknmWEtfdMqBMvnXbPnW23
 X2uZqBJFLP485rty3wM6D+4hGeXdJhdRbSKzoGOKNgDIW3hXzg1AturDYhgGniUY
 4OGb3aic+BfP2UBcbNOtAPNM7CzHpwuv61p1tENEXUUcXEW4d+g9XjHhVbFIejQe
 FYIWJ57di4DhsgH0a+Ov+PRqyAPQRj2UThiYYSBj/+PsiWYmlwwV+r2A1pL+UrKi
 H3qkAFC/6e3g/Imt8LzXClzc4OQzTDbbO+DsqYypObFbP3ApZPSm+3LmbPn5LxgA
 RnaJijhTxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=WCh2TqsFJS5uboGap5Vi
 xw1diub/lGVQ4tES3H9e4w4=; b=SAt9ImlwX4XfjZiJ0D7Uo90X9lQqkjInAyQb
 Rug4Tbd5wfFyHhycKgG4eV/M0/QwB7Il55ikFLeED+SXJ2QB0sjvsZAVXFetRVyn
 UPBVl7n1hEkdau3gjwa67F+4118VJ4roM3ypUgc6cRrRmGvbTg4IzhS9+WUkjUXR
 OyI64nEOnbP/YaT2GkK+ucqKrheTXTvrYovi/nqIrn2G/wKnx9l9FEnuQeywwfT9
 XxjUGbUlRAv0pNtp88hcykzncIfRU0tZcW82n5T/8dmjt+1uP8CAGa3n36pkOf82
 Qad5zEXIdGQFnMau9bxvNtI2DjpsAD9wy/S/LU4zQ+up9q48rg==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x89tmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:36:38 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id So1VwZIKu5kHRSo1VwEPvO; Fri, 29 May 2026 03:36:38 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So1VwZIKu5kHRSo1VwEPvO
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 28 May 2026 20:36:36 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com
Subject: Re: [PATCH v1 3/5] cmd: nvme: Add flush support
Message-ID: <ahkJxPyWARHRloQ5@kraken>
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-4-dmukhin@ford.com>
 <93b97c39-b3c8-4ec4-83f0-af1ca93fceec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b97c39-b3c8-4ec4-83f0-af1ca93fceec@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290032
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS1PR16MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: bad30fb2-0ae6-4ed0-a852-08debd337e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: pmbepC3XTm8mFvFQuDMRSEV0LJ1ChJCVDnpmRpltNFiUvZ+yI46HXLPgjJQd7jyhYmFcwCcfv8nxg7vsV8K0Q/cBcWeVPpz72dKLgyZUs2NKJe3UwpYGvlzZWSWk8I8hPbDnpfC72uyFHp6oMDkqsI2gGEt8bBxidqb3ptS/ATuQxku4i9VgIp9ByoC6SCfLZ2PWeRK1js7K9kpN6iyl2zJgtXVvkodrNBG+drFDGg/z8jYCGvGsm/tAY9YeyDjyOrzuwk9AjkG7BGNSNDgKnfCzTIFFG2a1nN9VWSIELuZvvihAz1F57sy3+qa/lgd3EcRfEMWvpXb5CoVJs7zxX5yUlnCguxsSKKEYVVbUSpEvGVge/ro7fFFqV8gZn6k1Pt2zbOY4Ii1Hd577zi7cSROa7XTyFyPKmijV1CXrSEUIW/Cb2xrMD+IdjqQxgD/FbIS57ZPHSCMAIec0Hf/NVJPydZvVUpk4Vbk3rkYlXDguzjxLrbbO5wZqwyjliQTUzEjiW1dXkHOXG7W1yX93XIBHZOa24APJjzWmwjV/Lh0/zE+jKSgvw5adVoJ82CQHhOi/+LJJg0bZMOKZNNKPkv75hwDo2chv5a6U0CKfw/I+koORVFGuFM2WU0kmB9Xtd+3I5SFzkCRRPOfnvsMk+VAdd1RR35qOzRi36HA+F+fv22fGWEIdospZniy8cT3iF5h8opgJacND80UK0SLcZhJp4yT65phrvkiR5QGDakg=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LAXoBvth1CWpdnJ+fhQDwU1RkrfpeL1slyF6yv0zzyd3Ze1wiyytMFF6XlLVZcJUcFALF8BkiwZkknAkbtXO/NrnhmpeWw2GjxpXSIP3VuEkeQJb68IF58AMarfviKxLaW/XrAWb7oCKTT2dhpTY1xVTj85/62PheIpqPl16u6ypA+0azJdjmePrghyFqSlMTQ/PIlblOTiZHGEc02Dviv6lu7CbERDm7ailewXd7ZwpNWLm/+7YJgz9sbeeG8eBezzBMzdN47NFur0ovqiyWMBjfd3GsHP+gBLMn+684bAqJSY+NBkRLsopRDYClqqTT0ckQTHPlnG4tQuhZzbTIFDw1llJDVA5lNmo7u6JiLjHbWUuJ0f5/Ka4IXRCV125K1zSwo69uWfDB7rm28bc6D9blloNRI4Y7sENrR8MLs7F6JCVMY+n0ump9BhgU5vM
X-Exchange-RoutingPolicyChecked: RuYPbkK63MC/DUlbdUMPh4rhpPKqx5fcSlf1N/+/4fRBrSqiA5WzkQqYRg+1A80Sqvc04QvTXAbcjYg3H0UpxJyWB2lNwKfuVF1JiPtmRIQFFwSMt2Ak0SVuWGiJZvXzgtK3SHoLLHR2oGVTP68e9KKvb8YY83r0c1SsMBO8Q+W750S30njrMDxwinRVGncIwbv89uFFLvzy9aoWzG5RJ3HJvrNsPuiIej4mp6NmUiYmx/6NQai41CnRxU+tU0GjjE8qZvxgJJX0vQyfGPSIv3REZ6fTFcrjGUGKfMg116XwJE5GhEWYB1jjmh4KskA+jfyzooIXEBAyxtaUjorCZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jl3YTZxKAa9OK0wYR9k/cyw+32cqcIAhlOdGRHiY4dh9UWDKrJJK2Uy6ivs/XwYxOUscQoK9NYLvADJptzFMnTgkigGFLm554IdtxPZrRzwY7Kgb2fjgyhD4ZadVRxBqzVKJI3Oq40ddTuZWC3eOUQ6pqcGRQtqkLD/1TvPuGW+OJQ8mKBI5o7Y5smPfyfklYQwzqTvpSAVG141I3R+tTK0eahdDABHHLo4+vDlHRR0XE40/P27abhDe7jXo1yoqWVI2azchVjEOUXdBwWRyaVTp2yXzLqJi4bniRZYrVr1MlsbiZWxeBG3FMLT+dMpHJ2Rf1wX6176LNXEHV3P6CqySWHCTgEbr015Fjx8r8Ne5wrxiXsS/DI6qEvjoW3MuIdzLYfrrgCtOjSk2Dqum9utXg3bjUzeb7nghlQ1c/ORfJY9JQf1FLljGprJb5FrVSA2OX9OCLxx2C4Ks9I0in4UoK874UtDisafZGix0troLpAH8dyO1JM5DgZw60LCj722sE6t+mwv7bdXGJVO4uBNQeelMFQG2DnXEYa2Qy7Uw5XD6inX44Lka/pTR9QbxbjsPEk0WuLuOqvTJYJhqz+EYmY/1FIWKVDVxGJiXm0V5c3b6BkDNcfwd/RsE3gjKtSjgmUlRJxbLXR+btxgbjQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:36:39.2409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad30fb2-0ae6-4ed0-a852-08debd337e4f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR16MB6681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMiBTYWx0ZWRfX7hXBP+N6wYF4
 urnlyUP6DMxzBdUWAXjEwzUyIczu/lnsKXRQbhiKRyjYbw8z3OvCbXb5VCPKZP7tADDsl4hhJS7
 9F83GGm7RqjMx7yNjSUBzy/S0Zg2qRkZ9OBFb4Ig/0pJ7x1tDnDvX8ifLbxhpHPoZNVTm68mv2j
 hlcIPkizQGf0HFGiY7X4ZcfsZfhBSVlHZYQCyHM9vcavsDdenOHejWifrWK5aDnIxUXfmi8n1nj
 0tLgQ3TEsT8g4UAoMIxOjKXSYqJfc6G9lmFgSWl/FzXhXeFYrn64FbWeJ9HKyI0D+W75Rd7cSIA
 LSNCs+FBw+O40yKdXVH135hEJcsRMw2IdnFSJ1fCrIRlgX+4rCeoSrlBYKIXFzsaDYbznmHtzXJ
 OKQJ8MlDS1gpO9YT7Q/JJ1+15ZNKtYuu9YaBBuenZn3GrnIkiYUuRdgKKwEy1aJN5Za0DsBRMb/
 5DVQVETaEDog3JZqVpg==
X-Authority-Analysis: v=2.4 cv=epLvCIpX c=1 sm=1 tr=0 ts=6a1909ca cx=c_pps
 a=LPqnct3xGwQwGN9n+XDEZg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22
 a=cbNQJ9GKAAAA:8 a=3dhdi1QGKXRX3bwA2IoA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: 9rr6dH4Voj7hYvx862yLrTVM76m2LgmB
X-Proofpoint-ORIG-GUID: 9rr6dH4Voj7hYvx862yLrTVM76m2LgmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290032
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

On Thu, May 28, 2026 at 11:29:51AM +0200, Neil Armstrong wrote:
> On 5/28/26 03:20, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Introduce `nvme flush` to allow users to commit all dirty data explicitly
> > to the current NVMe device.
> 
> This adds flush for all blk devices, please rewrite
> the commit subject, message and update all blk commands
> and not only nvme.

Will update, thanks!

--
Denis
