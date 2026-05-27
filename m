Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E585CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 19:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FFF847C4;
	Wed, 27 May 2026 21:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="nvKoaI99";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="G6n7V2wo";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="D1KCCu2U";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="o/PZIPgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505048487F; Wed, 27 May 2026 21:59:23 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8F6846D1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RGBRqL855392
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 12:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=hQ/kzmdPgMNmrz+hHZgezLM7ms9
 zfZjnLgNaC9QPsgA=; b=nvKoaI99R3p1IeLT7PIhB3tBiI/Cvf/P8plw6Ty66jN
 Cu2FuH6K/uXJkx8W+knfBAEQRUpnrJRsePUbMJnfzc1UEARa2T/9JW8HE/mfErye
 L3nb/L45+voj+XDNUCDHC9TCcN8GNpH2n8TnhOgxXKrLGDF5QDFKaZ9L+qk6ro/l
 cpJ3ll9PRfBkNGwYWgd8ZVlK5MXgPhFHaIQ0paTadVZstUdypvt3duXjCIcz4om3
 adyR6PGTkRVVm0LghWWOaXUpVoLL0Ddaz6wynoVIzH7oWtDeSrkROsq5ntJQRooK
 hf9uNUwdm8HyjmSTbdESJLpa6SoT5s8Urad07u+QGmg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by m0482516.ppops.net (PPS) with ESMTPS id 4ee3wu283u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 12:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iup/RpwBdIxC7U+4OwzGLWgFUHlYIPjDTLgvN4NcQWo6bS/CVOhBjnN/NSwy2YC2q20fovkcsW1atH/PlNgu5Em03MMeM8d6L/y4sxGNI8n1U+l1jUyY6fsg8ZrqbcP5snIc4b5J7M4FOhGnR7JehsVMXp+hozdEscWrDtuxVgyFYSFy+17ZdM1iWrtMlo/0BLnhPaZI7chczK5eymtLkV1PQ6+fzjgUkT1dFTeuummKuguJlE3DGY1W1yafACYiEPEGYcQdqGp+dpEPKe81kLfe60s1G26BkHpfad13zQN/NrMAGZTPrk80Zgr0br07Zr/+TY7vfEF0Sv25brZN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ/kzmdPgMNmrz+hHZgezLM7ms9zfZjnLgNaC9QPsgA=;
 b=wHr2TFmnKKWmLO6YaaMCtYymvAN7FsPPTHY8ljWXwv/U7P7QuKU8eO7ffCV8SZALDvSAqhG1vbjuZy2GJSKhUpR3QHisUFavqlFyk9sLpbRlO1qdgXDfDOmZbrGwPT1xOaEYrHyZXuOslde/GEOEtn85brcI4/gH7leIU6zkVmjXW9hQUKVBu1EhMd+fRXFmEPw7dzuarBMhjb/EibSIOuv05odOaCAM/mqqR9snTy30zDGixSNlgnVcVdSxGCDzogiyGq1n0XeQYpONJFBsYvTe2IPuWHOijzy8iYLGajwLWIWt8XtPkYVEbhdMIfhCX4UkgUADPxXcva8UxalMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ/kzmdPgMNmrz+hHZgezLM7ms9zfZjnLgNaC9QPsgA=;
 b=G6n7V2woVlqsHw3Y4tLZHgK5VyV10PejyIW5M0QEH0Bknuc9B3e9UXPoY7FUVOHNfuOlnQIA/y/so0eb4GslT1eCsI5+zO2wLkQ7tM0gcUUQZCLefL8nzjtS3j7GBVZnCdmR7O5yyG7rVgzLQ4frQVO0gYWeK1nDbZpW7iXABlA=
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by IA1PR16MB5287.namprd16.prod.outlook.com (2603:10b6:208:446::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 19:59:11 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::38) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 19:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 19:59:11 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RIpYMn1018407
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=hQ/kzmdPgMNmrz+hHZgezLM7ms9zfZjnLgNaC9QPsgA=; b=D1KCCu2UEBfZ
 lOelIjS+Ng/1JzyQAFpToCNnDg/4XI6lYo66eEsNeUtMXR5h8Np82jEadiI1OLns
 YeXTHRQ6jK9ii5w9jxcIFcwaPT9iDYFTfATvbM4VZGdeO1ejlRgZqiwuBF3uYJJh
 Yo291Ta9i0rZz9Dwx+S8DwZ/CwXKgHCuk6pjPkKcf0jY2jAT4QdXa+a664MST1RN
 GhoIcFnJFeL0v5C2YxIhUw5y/5nIZ8c7siMaHdTRxuzKhWsNF5Xw5YAKG3SNW32q
 E6x16QB4T/K8vgIXzZrsiX95+MdvG6YI/Yi5Hc094/pai/yOl+0AQIQsbOFpNy57
 9VvRAE46bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=hQ/kzmdPgMNmrz+hHZge
 zLM7ms9zfZjnLgNaC9QPsgA=; b=o/PZIPgFLPpJNtIsNP683+n+7qxa27IFJMse
 2m4LY9ZuUBs1C2OZuZhwSn0debSS0BWPuZ9beeHigICafQPwmxy/ovSDBLb9fu5i
 alL+rqmBB9Lb+vWqvw//352P2I7tOskeH79l4h0RC+w2S5fn/tK1XY819pUUNGWv
 +jbOJqSeEpkIDwNfdPkuPMgdEnDL9Hkq8w+YY6G57jSnAnd5T9auLG1otQsQ73CB
 7ZbGaEjDkpSqfQbBg3QrNPJ0tIh/L+hB+vf3kfezYhKaw2wONuKj9OLggECIPbUG
 mGyN2tT1ssoj5uJnYuwII7e4wbmN2joev/Wh68h41eE/x6BDpQ==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ebuapcup5-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:59:10 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SKPFwQ48rZ2SgSKPFwYgtI; Wed, 27 May 2026 19:59:10 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SKPFwQ48rZ2SgSKPFwYgtI
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Wed, 27 May 2026 12:59:08 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de
Subject: Re: [v1,0/4] reset: add board reset type
Message-ID: <ahdNDJE1rFD9acyo@kraken>
References: <20260522012312.860026-1-dmukhin@ford.com>
 <CAFLszTiwegtmhcSzy8xg5KKc1JcjeoYwsav_Tb7+9o9Hy+aY9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiwegtmhcSzy8xg5KKc1JcjeoYwsav_Tb7+9o9Hy+aY9A@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270199
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|IA1PR16MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9fc6b9-6a80-4f9d-9c67-08debc2a6b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: YrybuODEyT+sscd4xmSlX2GdqjuEXcBr5TQ/EupSYGbY4gZxDfzSmt7q6HoAKuw8dnxUcreehj+oL5W31aAU2tmMErOzCqI0cSbjvFW512PPXnC8y4/WRYiuUCNJx2DVV1YMImq1czzdG58R+I9+jPejCGBC+iX3ZljGrYmD3bV5TOdHuSompWz+f8CWR3rn5piCnuR6AAPqfcmX+/QqadUwPW6dqKZc97ILHxbh3ZZFIc/oUsDJTz4VFgSNM4Tr13hZm+vlhy1AvZhqs55PTCBhtZJNhJ/Q3M3tOeG7QN9Dz1K2Y17ZDnUSg4FBfhOmOSalWVVdla9Hjgw5v1m4v2Tp1iXmgWleb6pc/EhUX0PmYivw0K/62K+nOrHFpbpq30OQlJyfsSO08PS5iJ9dwx/XzXPFBst9n9VsOFt8r4JS1ZWcAt1ckk2XUHLFtWd3SHADv/WKY1brt7g6FXXpVWQw7xrqzPkWMzmjg5OksFiXIC229kBNeY/u8I7qRJsu1Hzf1Lt7vfmFqpwhbtsD2y0xDrRNGHohjbYSSK+eo94xfOzznYnK6tGYLfxVvQq1Y2YfjkcLUqfnZcSAyMDbatHOwQRDSubVi9NLZC4xeFys0yaWVPn1pt5y/nmAhXt2T1SHoLEPmBm0bADzrPkPY7WJS37MtcUsYccB8rQlYK7x2lgKZ6fQvsvM6RgvNwnfVw9dCc/btNNK0DUpQQZL44kQ9sClR9maDVCd3ic3AT8=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i92b4CFdLqZXgq3dS8bC69BT92KS1yYSfy/cURY3Jc3kiGSI+U60wvkCROqmdchcfaXxtbhM4gnv3s+jeVVQ/OtMrgEtSVbaJrQTUwq2YARcFXRnGrxW2UfExvV7GDOhaWy06tUuIBtU7eOgNkYpcpQ+so1EmNu/qaW2vQ3KxBRSnUDqNQVoGJf0ZKM/WfMRuEXn73lTa5UZruTL5kZXYq1IdRdxvIZ3sF5BWpXATiV6iFBie3WEtk4dIUtctXceUz2KJQl9YYZ1SWAMcACQ90ogmuBeao1ibEoNMCnU3JjAes2gnbVp4DrUrF6NQUzr7BKDhWfrV6P9hDKr+B8A/FCFY/mZHKuS4dwXo3MaQxb3LJpDlqwOBWaMSd3urBXabHdxokaFrdAzv7HWIcD6HV5rwqCGUXllvvhSY0DCFGVG45soYG3b//wJaFFyvXst
X-Exchange-RoutingPolicyChecked: Neg9S2ZEh1Hy38xTfAxQqF/9hAvxC1ZMRl+HCXMAwB80ulnuBraML+vD8UjstzRvd/rkAcKqeWXi070leXi2cdim6TgDDAXaWJCvMQ1Ntt413nMUrbhtkC310c7makiSrPoL4s2bAhR8FLNU0srhbzkxaME8n78fvdfAGb3ptgVtdwAJ3NCYlA3/VAWN8/xlkTRnN6f7EHiqpxXK1Kp2Y6SBzsfMJ01lC9w8h0YcMa3n4lI5zLjC4X/7I5R7MFlg1mAcX9pbyH664xPpo7TJgCvAStOEbmPYWmjj6y/NkpfYBRDDjIGKHprTCoBSVOUGrCvE7A6yJwwBIj5P2r3hOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mYw5zw7sKPvxqV9uEiKUbC21dwX7INPv5ZF07gpxYVSdBOFlJXb0/M8HnWscwmkSiF/M+01wVEBphEt/wPmqK1wgelKrs+cQgDG2g07yfTPnpkIVSXeYI5JS6LOLkd1EVpHipE/bbcDHAu1nL+mwlOqvEjW/Sz1DbS/Z2ZeC0rDPEHg1JpuVwEmjF/FOgVz/wc3nMuNpd3q9LIUeIW1JWMiffU1vEMsG2VUN/VeFWaOjSZ6woO2+e5y2YJWLi4QOMi4d8gOJMeYQjv8Ubcc5iyUy0jk7f7BSEN2tCdBFrJpfhjNbucEFKr23Yt0j3dbfpkX4bGcJfC1e6digwiqPnSY3VAGUhBYj/tr41h2m8+BxZy/KXMB0uVhf46vwVcWFApqaYOAPzOk1LcZG6n8IC+6mdzO4y2yatuO447h9BdlsnPEh3/EcjL9e0fZlDkeigItFvqnCsI/Zirukg+R8a+riRSwQ9jOWaeiK2UwOdOWsBzhWY/C0DK6ALxAqKm2ydoDfeIuVuOr1jIb8kx/wBpN9Z3duKqdrfZNnNl7hKLKSC5pDZuU4efzaLlvk1yvjfunZOWFJh/jM82NzEqENn14cbZ9Sf9Pa1tHVDV7Cf+9/yDN+nJpvhW9i1T84dQrKc+WW+ZwlXE5Q/Q80aee1Tw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:59:11.1785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9fc6b9-6a80-4f9d-9c67-08debc2a6b8d
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5287
X-Authority-Analysis: v=2.4 cv=fdmdDUQF c=1 sm=1 tr=0 ts=6a174d16 cx=c_pps
 a=1g1g+NiJF5nyOkqFb40SOQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22
 a=cbNQJ9GKAAAA:8 a=FcH_mOwI4ShVdl4CEPwA:9 a=CjuIK1q_8ugA:10
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIwMCBTYWx0ZWRfX6Z6NJAjkBwKq
 bjKqIOsjQqnpsFMHGRyiH5sN2HH4OvZN+tg2owyy4PsZGO6dAtiLQgk/Y+Xx5UEQk3e5WVNMqB0
 OfkrbvgHi94mqyjyLpaP9Ify5izwqHAmghFJcMxZxTmuABRhdLwtF9d/rUPJzgZSw0bWLytsU2Z
 QD1lLy/1cjoBZznRnplDZnuAvLe3wZ77wvFrp3GIe0N9CD0zVlj1nqDX+wCv+FuWhdXDLTLIMNQ
 UJrrwhgRxXJ9iktWclDvdCdq/BayOEOCrRsrJ5B3cgNfz6ZDhZta3vASxiJVuajXOYEdnEX2P0A
 z+NnL2hov+Fst2QED5JR5ANFC/mrd1Y36qylyhaONaHrKYFRfVxNlfuti38nrtbyd39aF0O2QeB
 oxuKreQoxcsYgwaSLV1rxt/Zi+2sAXoL035yLtXyCbP/tlq9gLJC21yLtds0326vQSaEFZPjpTT
 EYpeau6mrZh8Z3bRaPw==
X-Proofpoint-GUID: ZDFvvDc9OWBdylQDzgR4FbzCuvqEVKmQ
X-Proofpoint-ORIG-GUID: ZDFvvDc9OWBdylQDzgR4FbzCuvqEVKmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270200
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

On Mon, May 25, 2026 at 09:25:13AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> 
> > Patch 1 allows per-board default reset override.
> > Patch 2 adds reset -c support to explicitly trigger cold reset.
> > Patch 3 adds reset type printout on the console.
> > Patch 4 introduces a small fixup for the x86 reset driver.
> 
> Since you are adding new behaviour, I would expect a sandbox test to
> go with it. The sysreset sandbox driver should make this
> straightforward - what do you think?

Will add tests, thanks!

> 
> Also, prefer board_sysreset_default() only as a last resort - could
> this be a DT property on the sysreset device, or a uclass-platdata
> field, or a syscon driver, so it doesn't need a board hook, or even in
> extremis an event? Weak functions are awkward to discover and don't
> compose well.

I think to cover our peculiar board, Kconfig option should be the cleanest
way to parameterize the build.

> 
> Regards,
> Simon
