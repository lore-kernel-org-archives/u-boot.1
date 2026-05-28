Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB016CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFA384702;
	Thu, 28 May 2026 03:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="U4LEaEy7";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="UnrHWShJ";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="pEryIdZH";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="okw96f9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2938846D1; Thu, 28 May 2026 03:21:08 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67087844CF
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjOlI4108114
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=9SRaDD75OgPBKIBc2EYXRv/uj
 p57ndbrupJPH65NUUM=; b=U4LEaEy7lZGamMDNM0r9HGMt6PZGivalPSiym2iTn
 tQY+TpO+WoxBhuMEGgA5jhqk3IUVFKp2QtYnu4eoIsJsS2gWPvwG37Aux7EQ1rzc
 bca+/k3ua3jU3EE34eIYWsznIrFofWjkrWaPtL5svdEOa2+lBmTRBjG+GEjttccS
 qC+9oWdaKj3uvIrYyRDZbj65heHxKCXLh8jLoEBy3KZzQ4UnTfGdK/S4p4wBW9lS
 V96quduD4L7XFLMSXFCIVWeDd0H3bAsp1BxCC2G9Dvu5nj2UYjs253ZK2zxze9RK
 53zpxZp19wrqCtlKfP4kiNDKHEs8a84Dj0jT+Bp+qF4Lg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wy9dsc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKqDdpZ1cCmZ2fXKMJ5NzbsnhKvz11Am/DPEGClbH6zfYvrkwuJOQOqTPKpDdzCgczbkLJWVE3VzZDojDZmlkNlwHIXBuOAoZpbGSAD4I27+yicBclnzKsw3eBR19MqfbtAiDNlde15r3ZvVGf8QQEy3ITNUeI6aBewsKvgXXyiRyYvMMDV+IvaVIMH845PJ7GsB+oK2g+YgX/aQ1qBlXQQah1Gcia9NGu+WJ8GUdu8S9gANZeA2Tx/WhR2oRh3j+nMN2nBdeSIoWDsm0ZvT8itZvQnUDSekp5VHmJKfv3j/6p7Zdf9brlK/TOsvbKMhqqM8pqpsaIm+88Ckfu6M5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SRaDD75OgPBKIBc2EYXRv/ujp57ndbrupJPH65NUUM=;
 b=jetRQVa0fF1IDPV6KK4FTRggjJJowH/wA172LNxoJPvpOMw8+mctTAsd6kqx0RtaC22m5ddX67YL43CEceqMUYOCBMYhNh6eshg5xCv7H2pgaF/x7aO9VOeS0r4YHle4bKyNlrU4CGH4X+8DRq0BLg745qrJVcPw0TBjo/mNExEQB2aljnjZIllAUb/vr63144SVMHPhXm9PzvgL1i73Zw2K6YT2bM1q5AiihAHrI5yR1lLnhn1Mg21YfHJTSgPKC1pHmgECw7DXsxyDWomtWImd36Pyeg1FYD0irbUukOEZIa0l+we5QNH/COxj5mOkDZ5Lw5kpVOOXrU6Ou0JMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SRaDD75OgPBKIBc2EYXRv/ujp57ndbrupJPH65NUUM=;
 b=UnrHWShJrcbNFLR73NvAw7cYAYIoX6TAh5+g2e1AWFfYPDLWiNkfWxaRkSTUoNIft0b1jTe9HM1JcFQLITjjD92hea46KRyNQjUS9C+o0HDaNodGl4grIIpjIOVoLHF7Uokg9EPBohCQK1ADbOgVBhDsqo97NeFI/7p6dWEpfdQ=
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by MW3PR16MB3820.namprd16.prod.outlook.com (2603:10b6:303:46::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:21:00 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7f) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 01:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:00 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjSsx3751410
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=9SRaDD7
 5OgPBKIBc2EYXRv/ujp57ndbrupJPH65NUUM=; b=pEryIdZHcSxlnvVrR2EE3Aw
 AFYgkpRfuPZWgwiX50+ZB8k0nJkaCXPDFDJk0cZ9YEKn7PSHb465XASCXnIntGMT
 45QjRLw4GF9rYICtEL7ZscznaEKtSjkDWVRZ8a8aJpcfqyibHClpKDTrMbgtGYwH
 mPtUpAionYohjtyAGK/an28hLseEMv+u56KvoHUYKW+eJZpJY6zFB6OKEUPeaLCn
 FOX8DnCv/JKvYXEVTSGO8IKzL0/cpaobNW8QfR0agYSsR5Aagc9xNFu4trUPhCNg
 nCozHWEAPJEojA4wGg/FhekZ1SK1gb0ua5ioYjQkAwIMlgnH/otGUGAgkGuxv3Q=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=9SRaDD75OgPBKIBc2EYXRv/ujp57ndb
 rupJPH65NUUM=; b=okw96f9iPNYVgCIi+FhZj951JZXrGeiLP9zKEb6aWoxoEUx
 uHfDUBybHLmWqCaK7EKCONE5OSYAWA0ZsoE/WEBcDJ9uPIfLT7gHND//HYajXJJ3
 bPjHRHsin6Vb5Z0jnAGpV/MfpSLwh7oWdqxpx3PoAtZXxrgOntxGrKPXynBvucRk
 gRAw0ayqOVP1F2mdu1WZeqBVv71QTIHq10G2Njjl9zW2RGuR5rN3ariciqlLyHsf
 EEv/Rf0B+cIOQgO2jg3ucrHyr7+plVPWDwOcir8TAslizoWeS4r2kzX2eUSTNY2a
 rkE1Vne+RiLh3fSsCp6QFMM8bwfCBH0cLd/WY6g==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x8079j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:20:59 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SPQfwyKhXhUj8SPQgwwBsX; Thu, 28 May 2026 01:20:59 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQfwyKhXhUj8SPQgwwBsX
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 0/5] nvme: few fixups
Date: Wed, 27 May 2026 18:20:51 -0700
Message-ID: <20260528012056.1744362-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280010
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW3PR16MB3820:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55b37c64-1cce-4339-7cec-08debc5760ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OOox0smSUeKXRd/Jjf9HMwniPA/C1K+XGs8FUCQmEu5H/I5l6Go7iBY8L3XhBOHXIel6SN8l7HIzyMUyIcZt2MGs8cHZdGQbQpykHG5BGCBLtA6FHahxAHPApUGSw1Ec5/wZbaGhU+plReFpm5yYpqrf8+JnlXDpxqa+rIKMFI1BR8GeQS1oYDjcluIxuRZRdmYGra4MdDV0PRkJkVeyDSl1WphV2PorDQXdF3s6rtWD0cpcAposeOgS3cfBalpk6JCpxUNChxkvr5Y6I+RfxuoFj8T6qZAz3iQhl0oSWfyZc/zpVzQu+QJ9KszRDZbx8XMDW9ZcuuFGf86+ENVEkblli3+/2ZAJXkOAP3QZVN1fHksk1u7JI1MaYuGMAGImYaGjXWa5//+5twX+KXqCfGKIthS3NmeM0dxnkF5WI8AkhWRm2pt6lrBoGyfBATbtMsAC7vdrnIzrLMMpyi4TaeJwTbY0t1HbtWwgWVC3x8LKnhBSgnXu9b1iWu6tTKpgZMgDpL3ojW3suk6LuL77xzmxLLGB0HoopxdNO/laqS7GG2oT13Qrsz5zycKXMGYk/Zg6gj5idc+YG2GC1pJLJ/GeBB0kgFqE7wYWX8Z7AZlYvl/i3UMN3wht8eO13DatNNU9e9at1gl5ape6Gu3gqV5jN6i+jQf4Jey4JfEbdG6ptYF94pQh8V35XAIjkgHr9K6tsJ51KLsX3z07dg7ySgadb86GL99uZ/rKNFzGU8M=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /TGJWB5R5LQ34VY2pjGUBKos9d76bO88kpIJX0ybJkRp1ThiLLqifrEVB0GWfavnKjXumyOdhNUZfVd5ia6ueVwahD6D+q1t4lR75d2NcKvF3CkaRGeY0ri+3qU/BmdjJCgIIImKfGhijbdcxHgTVOqWzTHZ73DoZ/qqFILC0xycQfoQHrj2injzjUdzpPctFaIfXoZYWBlNYyFNJBWGW+UXkA3CQE7eDWqXlz+t/Yy1hBoGdsuNx+t7fZFFeRINwFWi871N9sLLkxAfCKJFJtX8z4taQfNrnBI4CmQvsvxkHsHBZMzCoFmx9TpuW6/w8+/OsROX+6R1AsIrX4FHXLKuZWm9+CoPzEVWk3+SJtHKRujMIvfI/Bf01dT0jHXa8lzEVDDkyuGTpXZWBPBgTXcnrXQ+9fs5fufX+8nmhj43oM+KspQkj/v0/LR1fDeB
X-Exchange-RoutingPolicyChecked: a+gzEtVie7754po2/ENZn3yDfh41zWxRyshb4PvFNu+ta9BfmLUhtOu7i4xTMgFN9MtVy/TmiWuzLMJyIUmtWiUyUS9bmrRoXhA+FNNrt8YDJ1Q1IMw5LSKcS2nYyG8gb9A18HD81PJg5uOO3CKrc0d96IWxBkQ+LLxPR4oFtrSeTJSKnjx7jR/J+I9dcG1SY/IWyeoeSZAmFGa7KN+bsoRkNx+XsEPaXsnFDiAL9JRrArjSlHwS4P5tCXs6dnlD0VnnmdZ+uXIcBLkN1UWXcT7dMRqPmmqZjVDI/6gNu0UL1jmOPDTOKVCX+Z9oCVwseQNr5kQQy/PaMpE62tbH6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IbqwIQiTkV25yVPQjE/nrK5/hcDwoovVcWaLS65ghWEr0DIRj8syOJbwhr5RHazD1V5J9WDQ7J9HJI+hgA/T2YxS1z0zU4x9mY/2Dwj/QlASO6m5d2Uq7iGrV/vEkOy9nqbWou52BDOMzxOIoxBrTMJ68lhtgeS2WiK3r5SIhdnQAR0WGswnPdNMkwLt2fF6qqu5qhtuaxobfrX7dCgvvIW385TjUzbBwM5Rm4MICceJHQh4OTCmEW7qHKUgeDE6lNzCQs0R6fLnLhkdxSe07jUq7Hhlu5QzUusYTiUfNBgGBkq1Gl1rNNn2p5PD1Gw02KsSAujDWvGVMm9JvTyJndsNB1otdY6GySfKH7UkOY+uiv1izOVWCsrPZXgAw5ZoLNeDQUJnjzc2J1gr+wJuhJZX1D+HTjzeNuPNKSNjN7rdbl8xD6mVHfJZp9+L+XQaGnKOYtxkip5YIAssxoBIfLVJTHO72URIefT9LirLdwYt4d/7sthTWq/iVksAdAkRzL/8sndM8kDXp5uSNlpdUnQhPuHIIiq3sdvUOb/S7f9sHjmLisgkmO5fNDxUTRT9gC2nKXMrZw+1hT5aa/K4gH3mbRgpkC6880g1i2qr/+cbD5oRHQleiqLxPwx5W2HebMA5UZ01X1QKsmTvoieYFQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:00.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b37c64-1cce-4339-7cec-08debc5760ac
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3820
X-Proofpoint-GUID: 1CcPZH0BF9iT9U8vp50njHOhg__ZagE7
X-Proofpoint-ORIG-GUID: 1CcPZH0BF9iT9U8vp50njHOhg__ZagE7
X-Authority-Analysis: v=2.4 cv=erfvCIpX c=1 sm=1 tr=0 ts=6a17987f cx=c_pps
 a=LdSsacNKwWtvIYfRw5AjOg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=zFJV60gWvoO_ChBBrkcA:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfXxcxmInPcnzK6
 cXdPxbj49zmYXj789f2CcIiAS+zquNKbfenywx0zS3/OaB57x+yjeFN1MEpk87+KBcz5uFEUSm/
 wQae/N76TXe+TNmPIkjuiZLO8DamxgXZa5tsiuuixQ3w47v4Q3MsqOjf1sarN52fvNT9FG10qN1
 lawpFZBncZug/V9XpD/OWtc8TQs3oKDfLZLXOBzTBLTgZDBjGtGasoi1gljUchhJtbFecnaWhH/
 qfCDrrnMdd9R4UF4qmpDBktJGYdez0raTfacj/sXsUExu7Cb83OcEyWRZO7v2Nm99PmGca77UpJ
 5ZePdnV2T5AY6YpTHObMsqjj32rlcnma4jPwP410zK0tJ/c+1jPaGzHu65HCKSC87KX+2A3xJBe
 ZIPa4441ZII1R0NUif64YvvWY1WqfYH6v3fXhG43cHbsD/ufIG88UUf2KlCFU4QmXSMccRXpiE9
 G3yg6tCm9uCZ6BJoQ8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280010
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

The series adds few fixes for NVMe subsystem.

Patch 1 adds logline for tracing misbehaving NVMe drives.
Patch 2 introduces NVMe flush command.
Patch 3 enables `nvme flush` for the currently selected NVMe drive.
Patch 4 makes nvme_shutdown() symbol public to enable use of it from
        board_quiesce_devices()
Patch 5 tiny fixup for QEMU command for manual NVMe tests.

Denis Mukhin (5):
  drivers: nvme: Log I/O timeouts
  drivers: nvme: Implement NVMe flush command (0x0)
  cmd: nvme: Add flush support
  drivers: nvme: Export nvme_shutdown symbol
  docs: nvme: Update QEMU command for testing

 cmd/blk_common.c                  | 14 ++++++++++++++
 cmd/nvme.c                        |  1 +
 disk/disk-uclass.c                |  6 ++++++
 doc/develop/driver-model/nvme.rst |  2 +-
 drivers/block/blk-uclass.c        | 18 ++++++++++++++++++
 drivers/nvme/nvme.c               | 24 +++++++++++++++++++++++-
 drivers/nvme/nvme.h               |  7 -------
 include/blk.h                     | 28 ++++++++++++++++++++++++++++
 include/nvme.h                    | 11 +++++++++++
 include/part.h                    |  8 ++++++++
 10 files changed, 110 insertions(+), 9 deletions(-)

-- 
2.54.0

