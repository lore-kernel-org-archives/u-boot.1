Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906C5CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0B6848EE;
	Thu, 28 May 2026 01:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="YS08edOO";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="KahGGbgC";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="XaT76b6y";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Dh6331U9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBDA1846E2; Thu, 28 May 2026 01:13:31 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5707848A1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RKiNmO1563787
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=ubR
 Kb+H/CvC9l5KGEDjlLtkWBRubWVemXQzTDPoTqjI=; b=YS08edOOwahm4jJxKHl
 tsph/tuT+3YR7JpAq7Xi8u1O2Ys33wUl8D/k+wEntlHnKGmCK2KDgC0bS2MkVIEl
 KGG4WW9SMoZ2bxuApfDHRUnqrzcH0tmffrnGrWtuY3rIOExVIpxvv8iDYKENlWM/
 tA5FsZnjhAfPfuL801LLLBOawwn9i01/k2gKBuA+QZOEBs6aaVnB5qnZnDPgNdc9
 57Gf/0kdFlH9V49Wuu/0XnUV0ElW8CjYXntaead51OIdflpxk25jO7smuYIr8RVY
 exeI6vsaTKd37ihLDnpCrodhGrsClJrvA1MFLXWRukbuxqDNvdjnN3vsy2E2ru0F
 yAA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ee7ws8trc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw72N5Awx0B85F8tQ7hKxal6ZctkPGAkoFtUGZrTuDaVkLdhzvk673Uh0yZISHMM1mwiiZD12HIppAkAQmzdIW01ULRTvM10z7cD9DoFPusOX6ZATXe3UIbpjWs2girzw7B/3WCED3XehcQ1ef+B/xb8v3LEHOppZJr1v41w+Tzm9NqdRljuxa8vxRYFdJkVMRal4B0iKgv+rx9miRkLjWZ30lRrgh4Ciju++FZ5f5yoyjUNVqaY0yW0Vsv88pSveGsFmrIxfQ3+C6aDG4IENzv8/hLaX/FI7ei3fbrhVQjwExDa7paCfikV3RcnG8vRbTDWobxeGowUgPLORQLUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubRKb+H/CvC9l5KGEDjlLtkWBRubWVemXQzTDPoTqjI=;
 b=qHtFOaKPER3YjV7wlo3tMGfZmpdCcC+aQrEOCCXcsWxEHmc0Mc9dVKVjvjCTZ3hvfZ50RHuFaZP+ktrqQoaM0jNANly5oflLQER2t5mGKfpAVVQF1errB19LQ66v7npmXXogQmt5B6RlFnNAb1T3/memo5coQdN4owCa30VD27fDSIig14tSo2cxEQiWCBtW41wpGewFJ0c3yqJaN5mtIJPdFtLXoUwUD6mxacB+T64ThT/rJirBpD/YxK1ZcnrCy4wJTLSSnkRnGBHD001TW6mIVZJ6DBS/gZ7fbrEGw+MF8u0dpdm3DzOb+jjJn5MkqX9H/y8BDSa8k+5x/D+q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubRKb+H/CvC9l5KGEDjlLtkWBRubWVemXQzTDPoTqjI=;
 b=KahGGbgC/1I2Z1oJycqbk1gl7NeMcHUgyGjALTbIY7+EI1gnQJvfa+wMALu/1UMKHy3idH3C4CJonkJqi/5AQu9+w6RySouBFE8gofYy120RKNgdUXp8dnERrPQviZhJYWNNN9ljr+kQEAOqzSPE2zW9IP4WkDH8OITPJ4T4hco=
Received: from SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::28)
 by SJ2PR16MB6108.namprd16.prod.outlook.com (2603:10b6:a03:571::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:13:23 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::65) by SJ0P220CA0018.outlook.office365.com
 (2603:10b6:a03:41b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 23:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:23 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjbAJ3752013
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=ubRKb+H/CvC9l5KGEDjlLtkWBRubWVemXQzTDPoTqjI=; b=
 XaT76b6yOWX41SVowi3lZXyosX0FSMBj1f92OGhMILnWHL42KZmrwr/zTYWlRlzh
 Zv9sFTsZz9lT/33IlJSRq0ZLWwzYi6wtaEnN72Dz7FpZijSbhvPZOtppOZH2vV6N
 0unuQy/7csKJn/ZD0kZz1zcelahaAOVu1YqknegWZuUe53xB0bI6YeAvmuH6T98C
 8UuMnwg/H3L8/PXm8133pXCzHK6wlsVbfGG+Z2q14F80R4XjkTbVuT0z9UV+p0QL
 CwT4CSR+TgyeYYxXDiM3++gC8BNBXAwrMUjF/DGBaCOS2Zcud9SgAypjgqG0PJvo
 /53lUj9UjgWNkoYMt6uUMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=ubRKb+H
 /CvC9l5KGEDjlLtkWBRubWVemXQzTDPoTqjI=; b=Dh6331U9Ds9N0pUSgWRGVF1
 dv3MSvC9f/c66bR+vdwLeJ3WFk9rdrv7DQ5Q6WNZnTNYfINnU1f7u7/7BMg5mTIG
 jdWiMdOmkmRP7SwWD9mFkH4OJzfvVaI5qIFD25057I/NZdA37JYGnlOlFP/zg2hz
 EqteXL3tO2pzS4SyfeXJEFTF85ydNdRNT7NCXBXyDRnc71uin+Ic5oHxorMHrt0f
 skZLoMbRWFd2oEdX3b4SonBqpZBDMYFdzM21GuOCUaXn17oJAzN4XteyA3YzUwgy
 3tQWtksssLDUSsL6agbPitvumLgJVobxgTYKO4b16/Q3MwOQ7aN2maXpUUvigsw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x803yw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:23 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SNRAwXPsYZ2SgSNRBwkxFB; Wed, 27 May 2026 23:13:22 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNRAwXPsYZ2SgSNRBwkxFB
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 6/6] tests: reset: add cold/warm reset types
Date: Wed, 27 May 2026 16:13:06 -0700
Message-ID: <20260527231306.1714741-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527231306.1714741-1-dmukhin@ford.com>
References: <20260527231306.1714741-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR16MB6108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc6c203b-382d-43ee-ab92-08debc458cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Uj7KX4afDzPD+wwej+R4wospfxax3VXb0XIdShPSHxZSuqXM5WelkIwQV7fWBdtCb6nYvua0X3NfFldMSSl2ajAFRLKAKUXwTQhXCkwymp29NHIJ3gJxjP7VO6/6319uPkh7wPhvGYgGTrmgY8QhbUnfD1/Zmmk1EQkeKpZ93cUflGE8XdhNe51peUL8MqrcX+d3d57ElJn+SWcudneasRWvPBNgXd56joJ5j8cqA4oBeyIdk9nkchPpH9J7o6QAO3t9lMNkFz1Z8hbUMtLFobICfGwVIEQeZe0562xX0vOmXBuaOmzJDb0dGy7zOOJWiFhJRsaviA0iARz6Hg8LElQWYeW8eqonFKTGHjHB79UemPaYoBpBfix9JLYvpB1K9BobgkVX3QbTZRNPRotp1rmX0LHZkWNrasd7zWGfD77UJCmFfQYyyJdqZgNlGCwrhI/WELE34li3svNTBVK7+6DdAfYjn2vyI+khIA3pZv1bu/HQZ1RFujxLtHqo1fCG0/CVm32seQqyDnNe4Z+jQjfdPk8fDhuyKW1IVNicPAAQi8E9DjlBhe+yrkVQ2oy1f8RfZv2L+jotWiNj6q5En9U3ckFdmmbra1RR3anNo7KsL1ZKhLb7fWT8FK8oAqeoRxJtfqXP9rxgZ7zqp5GCovh3M8kexXXUO8dQ0sMe5u8q0jO7L5qLhRC9Qn3NMvc513881/G2FYVxONw3qmzR3fI8Nc87v6khGIN/4z1dfFk=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r6C+VvUO9UtVT/A639+3G/yNNpnkObSXdRoSSLRtdIJLg8GgpDXKI+tKzytcdOYm5+INsbTZTumOZeGiiRFyHTgXfiq5cLsh80oFkGXfZD6+H1xI+rnxYeUvjB7ZQd817H3/mPlz3GuvxUTjVzYt8Ec47XbFBFTUIm0lBJSZZDzGT8/hxx4ZpguDCrilBZQJU0O0yzK6gnOkdrNfDPAxa038wV5cz2sfUR4nCCbYv0vcCptXi3gSGISCpI8JmRx/l552fdT2wDC7IDxDk0tlQBbSNmW2n/qLvXVZfXH98IRVEh4J157p8btlSf8BT5uP/PHZ8MBuz6xSosq12Ile4S0buFssA8jSE5ngyBdESMbamQ25SfjZcDapS4Rt2VpBSaj8vL8CvBgpkoYxDIdKDkKNZ07xpYUsSZ+SvPcmCoYGpbpTiNuY0PgwPD0qfeDr
X-Exchange-RoutingPolicyChecked: Jh6qG/7ePaa894CIa9dx1fXRZmstpdvNyR2BSjrGludT44WPNs2YRFAbtjgIbr64Eei2EFZJmvx3c3f/dZhe/BVn+i7N5cGKUyf9qZMpBRfPAaWsZ240yG0etxzUfWXl7MuUAlqPAruXbkfvq4i2I8zCTbXs7vU8p1rD9tjuJ1GmyN0u/7JB2gqEyt7FRoTP/1qYVSc8/ywX0emj8THTmnxKXAIr3DdYeH3Z5MQyvljSTfvslbyOlvIIWsjMgLKhdmKgmn15oeQedVuZue+8omBfp0kH3r9hXsSN2E8ipQunYlfGSPJm5PyVxLW4gfpG7hRSubEu1p9s+U2IHsHHJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pe0A13A/WfARoPw6J1AWvAfuzWqC8kZ59U2FSKRX6UhOMaXqAjmeO8vCW44PquBtt2SDreaNV3pcW3jCQwi3dMPaWcIz35f7VoH29rXahX2laHUqxDUg1Tdma0J0wxCL6PR+MJ75clVtVov5hiKRs/v9F7oHIuHdNCQ3jvehJFj7+qGdmM4/fgIHWFFvCXNmVGjH4kw1FD/Jl3GdpImfW00b4H6noGSTnwd9hAQfBCFpTxIpPEH2YIMWlJRJ1jgmYThO5PBz7SQkMlPEhn1PWebaxJQBZtezY8CIllsdtYy2+oVwbOh2ykjskGCQc3GZaSxe3QkrI3s8XTm1Bm797kFw/+Xr8qnH5VIJ/kXOmPKRO/nna/IzKMwKPzIc0ZABUymeO3cMciK4xJ5FTVw0KNLJBqb/K7eplDoV7DLWOXVo5UUFW/2vOf8ebtoFcsfscYquUsJdnWhvCW11FevD7LUzeZl2V7oAxidTXfHHUqS1iH7JbVIxwLgB4CzrkIti8hkFuW+AMFUOnjWnGuYwYf2uTz8gRXghQ7LSj/iYkzjoZHvXdWkxThPutqQ30lvCUOXZ5DPI8Hs1YCJ+QDbrtTtNcsDPXY/Gw98+E5BPJf+yfcTZAdLyth+t0WksFZMJ4aunD3NuUy7ofado45VQ9A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:23.4881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6c203b-382d-43ee-ab92-08debc458cde
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB6108
X-Proofpoint-ORIG-GUID: 7qYKQTmqNaeIvNYKyTv3zvsWWx93b5qB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfX/ruB3pqszO0T
 cJicOgo3D74xcIL+XqhW1uaH1H9YzziuGMAq7X9ptWGzQrAGDs44bNBf+wShLDwXy9499uiMilc
 hE+Gz1stHYHfyP71jCGZMI7WAc6kBwMe6C5ce5PYL3WC9axm2XHWXkY8raRzPNRzWaxhRSXouFC
 Y6vWCBdnb6cNdharMfEZ1fuG0T6C0Y9ai1SatprOOz/zK7YwxOw6G3esayZqGLmb4rziJm6a0q7
 VdAGXA2wx8dXEX2rcureGXn6TVnLOgZdD4o2nb5BHyUmh6flD5JiwhhAqCHwd+c8vVgKUpLb50S
 INcrm7oH2/MuLQP7eoIBoySK6vyyjOk/nBxCunwLPhH792uD023zDi/rHj3xirdZDq9N9PqU3MY
 75qwblNQvdMZS3DMtQA9I+OcGmEH3MZBTlASbMJ9izoT2yeibjNCJwWMtTWsGxIkhQAHywNLP7o
 pjfPtCvXNrIa1MvPtpQ==
X-Authority-Analysis: v=2.4 cv=JpPBas4C c=1 sm=1 tr=0 ts=6a177a97 cx=c_pps
 a=sujALEMa9QlLHAoAbbwPUw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=cbNQJ9GKAAAA:8
 a=cSHeqpaBJNz1K7nbmfUA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: 7qYKQTmqNaeIvNYKyTv3zvsWWx93b5qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

From: Denis Mukhin <dmukhin@ford.com> 

Extend reset tests to cover both -c/-w reset command flags.
Make sure sandbox reset tests are passing.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- new patch

Test for sandbox:
./test/py/test.py --bd sandbox --build -k test_reset -v
---
 test/py/tests/test_reset.py        | 8 ++++----
 test/py/u_boot_boardenv_sandbox.py | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)
 create mode 100644 test/py/u_boot_boardenv_sandbox.py

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
index af079a706647..e1037c963f77 100644
--- a/test/py/tests/test_reset.py
+++ b/test/py/tests/test_reset.py
@@ -52,12 +52,12 @@ def test_reset(ubman):
     test_000_version.test_version(ubman)
 
 @pytest.mark.buildconfigspec('hush_parser')
-def test_reset_w(ubman):
-    """Test the reset -w command in non-JTAG bootmode.
-    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+@pytest.mark.parametrize("reset_type", ["c", "w"])
+def test_reset_type(ubman, reset_type):
+    """Test the reset -{c,w} command in non-JTAG bootmode.
     """
     setup_reset_env(ubman)
-    ubman.run_command('reset -w', wait_for_reboot=True)
+    ubman.run_command(f"reset -{reset_type}", wait_for_reboot=True)
 
     # Checks the u-boot command prompt's functionality after reset
     test_000_version.test_version(ubman)
diff --git a/test/py/u_boot_boardenv_sandbox.py b/test/py/u_boot_boardenv_sandbox.py
new file mode 100644
index 000000000000..1057f7c3674c
--- /dev/null
+++ b/test/py/u_boot_boardenv_sandbox.py
@@ -0,0 +1,3 @@
+env__reset_test = {
+    'bootmode': 'sandbox',
+}
-- 
2.54.0

