Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF23CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA69584659;
	Fri, 29 May 2026 05:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="mhudwI8W";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="d6Y1YDc/";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="bv8oCQrf";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="rjnyOO39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEC6846B4; Fri, 29 May 2026 05:44:58 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0DE846B4
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3U5S72121897
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=vfP
 hvyzTliTunfRiqxJu3OK9YT0sAYIvstT9mHmaDKI=; b=mhudwI8WtQNIbJrMaIK
 WMFG+X429OhH32N7Ca2tWNTA5PZqq5I//lLt6FTnEQnMzpSt0qJhzxxRuCGsI4QF
 h1oCDf2pq/uyWBLmtPJOSy+U3sZ2xfpMgAdARciP7n6bBnuMZZfs43ZEiH2wjYgy
 dxrl91k0CCoI8XVCfCKt1FphrHS4udyGRBqbOn9E4qIr4I7mKw6ZSgz7wRyYpc/S
 Cg4y6yI/eboaZ7hmeIarE3Exp3NteEeYhTRPh8B7o0+LazWr4+4Aj9Gzv7pn4+iV
 fhORW5TVm4nfPG6hbTVGhpWj/PoflkP2iHyUYrM0DUHoDkWMXgu/tW7qqD01j/td
 pdA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2xx8234-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLT2C5Y4GhzjmxJLr/hOsHVq3J/2NxF1IkjTALE/qe/nLYvJFqmzSNmxJvBSIebHa2j83Kkq+7607w5VexTMbXQMbszkl2kaCdQEao3d8PCq6qu0Lzrljil7rL73ThDJLOBv8Gvd2MlGobRyDNhKv1e0KT5Jc/fyM+rHPdas622i8bXrZ3mRnT/oSaY2neFecZj1Y6ELOvCwQiVSYdeAuGR6lssvlYcVGSTWrpoVe6AUyCHXZHG0DlRcpFHXEtDdVNiorqStAjo/hLM1YLwgrjxOBcL3YuP4lH2vwTT5V8Xes2eZZFHf/xB2V/xU6EAijZ9YLmHCeXTWBXvl536MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfPhvyzTliTunfRiqxJu3OK9YT0sAYIvstT9mHmaDKI=;
 b=Xu1lNegYYSRvOJef8q5HEcFhC4CEWyUkZj74PS5mIPAhSIxRvsoYn1uQIPKPjEivoeRUQiaFiiPsmcRZ5hogH3KwjDuqqhD5e9VGYdVzTH3K7bG47fvdBEBXQVpk/k4HQdBOSvJy/J//W4Up++jm3pWIFIjGjSd89im+EAu+T4JbAKjRoRBPX3Lt8gV6c3ns2I0KFSJUCbWgJJsVaTQJCfl9WNxKApRAKzA0uwLjwZM8qwyuquUTijM6NdXI2cHmFQJXUhyYaeN0g/fnCBV6S85aYmPYN2zKJ30t/9ZzC67O+JFx4+VrLp4J2wuVVJw0N/1fdAvph37Z0p70mMyOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfPhvyzTliTunfRiqxJu3OK9YT0sAYIvstT9mHmaDKI=;
 b=d6Y1YDc/fnIak+3v7eTjjQ1yMxgWM1MB7/NLNjL2tGJRHFQX46Zdkaj3uHdbZmrNvWBOwTJ+SQwaGzG9qreTzOFwN1pXLDE1Pc364MMO2ADkSOvnHhwdjHvewi3Ple28Yune52O5WynX8PKVxCID+e5FxgOG5NleBuWI58aA82I=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by MW5PR16MB4618.namprd16.prod.outlook.com (2603:10b6:303:192::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:44:52 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::60) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:51 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T04KU22743730
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=vfPhvyzTliTunfRiqxJu3OK9YT0sAYIvstT9mHmaDKI=; b=
 bv8oCQrfpa+J0mkyI1PsyZXDyZNozGY5eLRi7hTWPl3rigCvjUQ6KVZbD2rz1oPo
 b4mXX3RnvBk7cXLznrx8bj7dDcv6rGiWdVsdcDY0J/Zff98TuWauVFHJucM64676
 w3195QlDIeI8NABJ6LOT9az+p2bhzyWKaISHNe6krnDsCCYuFk76mhka7jZ+btjU
 xUBY5iIT3zd65loX6AnT3gVqw2uKM/KsDp8avsT3Lp/1YMCqQKl/wLH72FoQ7qWE
 7kGkrtjryksGTaX2QUNZJKHNz5ghCRfBkWqpfwFWAbZNWXwiU+fDBjRiivpxA69W
 rI7o1I7o/sb7FDf2bhsVdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=vfPhvyz
 TliTunfRiqxJu3OK9YT0sAYIvstT9mHmaDKI=; b=rjnyOO39Yfhvgq+DBV237Pw
 eilTrIEww+2f4YZuqhvpY3UTA94HU4EtRI0AtR6+k/0EgYheEh/eA8IdjOyaFSDS
 DDh5f7bBNcKdoqqZ8UEImoXphvXoT4Q6/u7KhdjvNOQWcco8EkdCa23F28KTLBT/
 jYKRMi9S3CxGZfc6YP6tQ5l3a2CrfFwcYznh3kSmmFFh0OlDiFz5aceki75ujdRn
 tFBp2Cjjm2RffzkWYiod+hd2kgTjOZalxVV6D9352dOk7Kj6s9BeBGLNB8IfQNEf
 +2cjIl35umirWHfx0UleYiCbwgfHtRIiCSFIbATTh2csdEMD4yP04+cxi2et5KQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5stwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:51 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id So9Rwh6k0iIgTSo9Rw6U4O; Fri, 29 May 2026 03:44:50 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9Rwh6k0iIgTSo9Rw6U4O
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 3/6] drivers: nvme: Implement flush command
Date: Thu, 28 May 2026 20:44:38 -0700
Message-ID: <20260529034441.2075305-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|MW5PR16MB4618:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52207fbe-68de-47c9-ad33-08debd34a3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: b/5t59S9Au1eL2+L+5PMJmEXht0YRDA/+4x6xKwqHZw6sfvjtUcaRctFMVm3j9TPX5WLF45XGXxtauTBdVOEj8lty4nAa1XMYJSRKpWBVsSWidFHOKFhf84qY7GIyNH6qWJ9/w12ufof0PloruXSeNdTN7qxhEiCBIuR160qsN9IjS6/EGfvvAaWEUV6U3ekqE2IOABNm1naaRW2ub+Mirur+9m6UphJ4Kq2+f16H+LC03Zby3rhGOonwWUQhCXpFEMOFf/u19S4P6lOZcjVmbDPCjptPBnrJ5P75Lz65hpVAwwYAC1O13mir/H1L7nUY1dnyQYQMLbKzJNU/Tw2XBj+KaXMmHEkYGS/h4TNSlKxkHmVoDdLmvt6MkiL2TWwzUnO1v3/6PdvSqeDNztkEk0UreJ8xtJdV7/4kcpT1AElsGKAW5P6R7keXRWAr00EJG/6rkp3Mx9DgTaNPpc88GI85spNvOD2pvSsqR2cgjDLx1RYHwmWObXccsDTcEAx3sJVEA+S17vOFMO0mb9K0K3UafjEhOjqqg3nJsu35f/wFppqhpHupWZsjDo4FreP9ozijaInV0vY7br+/w5/3LKAP8gbS+VnqLwo8a+g9VSYmRiT0Er6ZWwgIONeMifZ7XnOuSWv8OIFABH23rU6yt8d07ysBQLZz9rXOGchMBIZ4UVuLhQdLnD4UMzax415mgSpPnasfF3tLs4FF8AdGzLOxMTke7KOCd0H1WrrXJ0=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xmUi7O0XZImg3loDChE6UxbQoi98arvqFvqfrLLy5k0lTXeJtXl0Bud/PXOfNelS55Nb5AJkScISIxrXO1PBz1QBi2jRzv6+f1omrVnqSKnU9TrXWw1tGTmRZkY3eW+nqQHDgQby0Ete+DZ/R5+DFAzYIgv9a4nUiEV1Qrm/tb2kavG6MORjicUTF2tH6ugqxlGy6+prXknM1qpI7wEN6eZcXT3U7ayFlvb2ZsAEqP59Jha4eNxaoA6MPkODae7zU7q345HKTF5Q4japCTQEoA6pnNo5WjvHE+9DjkRrmPXWgNYQ3dzvWc87G1XuT4ptS5zn4HgpfhK/k0bC35Tsc2ttUaxeSRjhPjiMFc3OvLRL+BHmoFGWrZ+lc6U4DMxx2TqLGTTpIaAgx7g6BIY1Fmj4aexwolxqVdQKAlF/cQOQI/mboj4WlqK+1btEYAxx
X-Exchange-RoutingPolicyChecked: bs/jIPLq8B2GAQnb8hDIYRGLBuyuXaKhQrGQFrR3g2o5xa5nUuP+mpGBi4CCSfHBdYVIccHXsrs563+5MU3v7GFFy2xuH4QuU/49ktnfH9BlBju6kCnUYUos/DEiCtPLM5FjuOr3Z/BYriTJbcAqVdn641bUe0TqT2KxZUVwVJjgpJAOSEXelqAssQS2kUl8mU1wzr1jnJliazTyyFnlDNMvG7HOTv2suE0JmawejYxFAuk9OESYWXz82HxYHAfhR00s963TF0LJF1Je9hFjN9t+NfYQnNAh9+5DyS007v1UefZZ4wUqLndoiCr3+/prRde8WkrCEL02XW70xXezaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2eWYMDXy9a3X1lyRDegIVGUSggbUrhNXqZ3TKFJIOaaqmM4RQfuGFsJ3Jvc3mnGW6//+GKZdpUI3ldunD7ws+/CFBjWAXkdmsnpmoPqGNyMnFX02lwzjbsdhxOzWeoTrGaJIq9oZH9jopJ8e4rVlOk7GZlV/YMgnQ3sB72s1lEcUwaLn8BN3AiY2CQgPwqszbP1gnX2jueG0GUXzCbvAzDtQtRpzAOoDIkcFj0ZqTs01PQ+gemPhVTb7f5rmj0fbtF5b/5hJKAt3A+krLavzyv6SIByXISmwINlNOdtEg4bOoCwz0cynesiIWY/DlcL7sKj5GK6EUYoNV9P5VuvT4SC6r/zfWsesXN72qU+ns+XAxND1L047f5MWyCPPAAdLL9UmsWAt6LbZSYT73n0YNtzzFFFZdoLezM77Tw1Iw0GFrBKRib5ZIwpOr/vt9pWrqTTWYWZzPSDVxP9+v4pcTXv/8iaTMuKRK9vA6KuXcVcyEvBrfu/CCs0TA5MXcMFO9Lu072APiqqqEkyr/wXY7K2zANfcA1kbJaVHMqb6jkY+NkxuylNu2gw4os1D4aDIvBbXXm0UBIBw/w3HLkrFYBLPbROOAg0Y3VzzfMlhDHTn2lSr+LUqX2cALgGzY4cAAX4+vNZw8glfkpiTm9npnQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:51.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52207fbe-68de-47c9-ad33-08debd34a3f3
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB4618
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfXydtpy76BcOBJ
 CNwoNNiwlCusdqkezSYI2DsCXxYuV2rXoGvy9MNnsHfDSS35cSU/ok+uX1aKiBsPjBXlP79X1hn
 Ds2130Ciu0tov/dfn8265ICE8Cq1WfDikv/szghco+MnbGceVfsWhgepKskhcIPtyXsMHRbGEsp
 qNysqqotZDnmZQu2xXtw5mPBGnqJWWvJCgoRv/nuzz7aTY5qbMDXZ6Jbr/KADHJnajnITGtcT4l
 hW7vtMjf0UcxtMKbsH8gzKhIDZJIdN23+d/WFrtCNbtJ2htgBrIBKMXYkWluY1c07BH1QDn4O/Y
 Za7aAPFPn7TX0ItWyhjeoWqDRlkgC8/eHhCY97MvhVFXxWTns7K47c50ioQUvjzOIFOiDBqP0/v
 IrQzzESaRF0pk3yJgOYKIFeMW7u8l4eSRMrhsT1YK8uyy34owkP4OI9mJzINlbP8TGVADxFEP+1
 vOXXNITFHcXSJU1Qsmg==
X-Proofpoint-GUID: IDEh9W6nY-oGh8LjXcV-SDzR2FhP4Nsl
X-Proofpoint-ORIG-GUID: IDEh9W6nY-oGh8LjXcV-SDzR2FhP4Nsl
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a190bb7 cx=c_pps
 a=k4cRz1n5LqTufC1gTxF42g==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=clwLE12zPSX0YIA7b0MA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290033
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

Implement the NVM flush command (opcode 0x00) to allow callers to
synchronize any buffered data with the backing NVMe storage.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- moved generic disk_blk_flush() to a separate patch
---
 drivers/nvme/nvme.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c3c44e50f19a..d9f099a11593 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -819,9 +819,29 @@ static ulong nvme_blk_write(struct udevice *udev, lbaint_t blknr,
 	return nvme_blk_rw(udev, blknr, blkcnt, (void *)buffer, false);
 }
 
+/*
+ * NVM Flush command (opcode 0x00).
+ *
+ * Applies to a single namespace; the controller must commit all dirty
+ * data for that namespace to storage before completing the command.
+ */
+static ulong nvme_blk_flush(struct udevice *udev)
+{
+	struct nvme_ns *ns = dev_get_priv(udev);
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_flush;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+
+	return nvme_submit_sync_cmd(dev->queues[NVME_IO_Q], &c, NULL, IO_TIMEOUT);
+}
+
 static const struct blk_ops nvme_blk_ops = {
 	.read	= nvme_blk_read,
 	.write	= nvme_blk_write,
+	.flush	= nvme_blk_flush,
 };
 
 U_BOOT_DRIVER(nvme_blk) = {
-- 
2.54.0

