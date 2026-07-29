Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE2EC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E8CE40B40;
	Wed, 29 Jul 2026 08:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crQ3x_gppIS7; Wed, 29 Jul 2026 08:38:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C05F240AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785314325;
	bh=K726xwF1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CoBM0aCM1O3IH/svowpAkProuJCRXDLQs/NNb1jt0EOgakOZLQnc+ibE7Oa7cKi0w
	 liR5bWsKWUiUflNv1aD7EUnwi9hRrNn8a1cbkC7WT91cPNtXMyDYXwrHkBzlN6AsGF
	 HqIsX7JkU0WX1eJlVf0JleKzcBUaoyoK4HxRrRYuG2RgyxEkVE+jFEwI0RrEla1yW7
	 01uPEo4n2Qqpp/LONkU9BcHeBiOvqEJfUXIzt1QxmS0b3NQHpbhuPHJE52OqCaSdR4
	 YO6bUteM/SzhILUkQ/sFxS508pKclRnFyeTrW6QWW6I2q1QBe5b9PyL6S80OWqH7JL
	 4aT2hCGWdYkBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C05F240AE6;
	Wed, 29 Jul 2026 08:38:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0726D490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 049EA60AE4
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ovCYPrYsVsqc for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:38:42 +0000 (UTC)
X-Greylist: delayed 780 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 Jul 2026 08:38:42 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 14EB4607E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14EB4607E5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.143.241;
 helo=mx0b-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14EB4607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:41 +0000 (UTC)
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T8Udh3561001
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:41 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4fq9trss0h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Ow7Nft/IsG9FcYVpcXB38crbpEhblzMhfPDzrwfrDL3VgNBh04bjeySnjwH/8wOdThvWIEDw//X+s9LAhIZ3CBjlLcDWUvgohgUAy70xxcLHqx4eFBfuCt9u05OFKcbi6D1CsS/OMkXQtO47qLVDh9bIi3wX/2QFSzejKjb+d3OzRKzkXYUH7eKMP1HxUkIJRFVuwVDJxjz/Yv1C3xaol8OW+CoL1EJ85Qqr6bKG0foGoN12KOOQP+kMHmo7bnFaF4j3RG/UA7uamPPzRTu1CQqyRIGNaTqSRtPa9vQQlnwp2eV03ny4IFsVVl3VxSVWh46Q5dlNOaZUobFuf4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K726xwF1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=;
 b=jNLBV2xUG0EkUtUZK+vaynEqLF58D7wWMGkE0R8DEtpwanRpXXgw+VQaUZmYpvAaG38mc1MOBQpxTHBLlhlhnSA6k/l43ahJV547oLygH8L6i+tMYPzV1xT6o/VZnIvkhqJMRcUN9i/uZAjPrM3mXu6FbDabewE9SvzKGhJHu4DgU46DdV/oBebvA0EVnfTT4ycG+fOQOr289/+wZpOLuDwZW4UuDYpidod8pg0eEeIOQUMCYFG/WLCgwG8EQb00vYFNhOfp7pH6WlAfEWuMJs2PebtKJWnYIJkCW8YzFONvjOZSs7+XbNdhjaIAVsRN9tAsnmENsvqnN/5O6IeXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from DS3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::11) by
 BN0PR16MB4352.namprd16.prod.outlook.com (2603:10b6:408:160::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:38:36 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:45f:cafe::75) by DS3P220CA0004.outlook.office365.com
 (2603:10b6:8:45f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.1
 via Frontend Transport; Wed, 29 Jul 2026 08:38:33 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7fZ5m3667130
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:32 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fnc7qccs1-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:32 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id ozo6wJNqTVWzXozo7w3LIt; Wed, 29 Jul 2026 08:38:32 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ozo6wJNqTVWzXozo7w3LIt
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 1/2] reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
Date: Wed, 29 Jul 2026 01:38:25 -0700
Message-ID: <20260729083826.2277173-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729083826.2277173-1-dmukhin@ford.com>
References: <20260729083826.2277173-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290070
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|BN0PR16MB4352:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d610e4c-b09f-4b8c-3e61-08deed4cc666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|13003099007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u3Pb4A0LWJgPxbl1DxQMQ3jongjYl9RSy7bjj/jlUZZQnHd9w0TInJyO4VVa8concSQn3GsHlxXSzhif7zMu2M6bvvw+XEfiZlezb5xINTGbYa6UTwGFjG79rlU6uvsunkU9ibSxFw1oHdnr344M9i3PE1yoYJaTxgWl/Nu65evo5+fAxiTrKLy8X+bSF9B9hiWInh2887u+9vvBHKVQRM4D4nyZ9i3Nl9zZIsqTPhmjzKv3wZhK0a4rAA7A4yejdFDg3SnrD6y9Zk+MtwgAVbtlvB6SBRA2gIjTyHBEk8W0pBfGjONZYJBIqzd2w0AC4BhNZqfXrAzjP56xWkZiU9u2U7wOnL8qJ+ZW3e3PcP2rH83nLj+YpZx5A6Mc5nU2S52HEqbppW0BlyAIC9R5zIxDKtJE6QxGZ7nmVFXiVM33ecPXvqZ1pnSUCLqVFYdHaTrXeSmMm1J865j2vBpBW6k93rns6NVrNnKDIy4jT9Sbs1cEv8Kf9B7LlTrAE5oDubUrAu+FJS+hvNmyo97CPC4uo+dUJSza13j51jpo6kvhPSH4o7cFhtkXcM38VIlGUq8GVqx9Hfewi7eapehCSUJZFEF7XPZ7Q7f3FHaBL4aZ9qUY5Rkp7KBdMoE8NGVm9rXh7yPkSGozOvwRarJTXANS15cXptEInsdPBDaBHhppq+ze955V1M6qnrHhA8InPa2reFq/gcZXemub8eB05Q==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L/F+22HgH/tNNsV41jGK9iaTZJb1Dn8LnWU2285wzJlg3hs9DKAawtUv1RPSw70U+72w/8mYyB9K3zRKcXqaxttE5C5T6zp8PDL3blGPZak2CP5x0ax09ss53NoFgaA5Oe/MhNqT6Bo5E2seIdSVbjbSwGrZl42Cw0NCYxt4RAZXijMvOajQUm8cHldvOrWr6tFrn4RN8yiMJIWidGpK34IFI6b4cq5NYdhouBoNrg4e1e/ImeDdb3ZUhFRXd752pMQ4msipW6IS36hRARMqMgtLjslndwhbH0JmGr4P/3deZeXr8M7vbCsca0O/iUoPAidaBcp8nh0ftEjGJBF+CBvIXXkeDIhkrxyH8gxaapIQoNlsIVSDVoJv+O9Ma4NKR7iwYQJpXPmrJ8e0RClyJ973BBQlC5Oblsao6wYG2RAWNZWqIh1l84nqE7kXNXh7
X-Exchange-RoutingPolicyChecked: mKMz6zSzbOvRS3goZ8osGjjsseuPfBiNcAfc8Ac1GuvewS9AVvDiZjzexsrGuk9eKUKkztbXyWP5rKZnjyLY1AV8CV1CwPEoeEY3fTU3Z4xT61EwO8n4nbAfWoiHz5MRSC9363NMzxftJ1t+Aw4lkEqhx5r2T2g2APsGitCANMSzHh9W28zgbCCyixtFYYlw2/r5xAza0da3y2eKNKPMyoxxi6QPR6jTLM8glYrKuFHQiJaKM+pHifPp7DByjY0UqweM6Teuu4ilBnddGGLzlaHPcQvlHgdFIGgEOqy5Tyn8b2jDIVkLGPgjLjgBBjcLJaRozxncO39n3Fcivj7MKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MzwXCwuxvhGKFOAG86YC2B9HIMPfmVz+tuJ/P0yJS7Vab76mbXPugmykyEjbdX8SPWLC72OWS4eKa5XzrGp0/fhLmvh3LB8ouCYtV/H8hPO6dtyzn5nARlYnHl8xPTddmQ/Ra+rOHYlmgLUQw45mk5YXmaqiJ619zUh4Jk6UB0g9F32QCZE/tEBcVycImvvTwbaxZGVfyOHIwgupQCFAAoAvYYFaIkbsgoN8RMXxU481EHJmJ5G8yRT/G9XWFmaFz5vWH61JBimnRwWgQ1owi7hSMBbQqckd9A8q52E4xlei0cUQS00Jzdaq1+ftiLv/ALH1YBgAxIx7mIKJA3PF7fU+BYXY/6gkO/yYzJuzYbXl0IYvbLgIIPzD1OBnMsO/ngrGDmsDitmy6nfJNh/n+L4hfVrQ1lizchDzVNQUMPjtgRyvRVKaoK7eC/vsAIxSziOsgoVN5oQgrmBMAbsz6Z7WgKayFwvqZJHysgihhIEVWaGCQxqT9riTHS3tc3KAhvo260d+Ls1Ngspmzo4A78L0kvgHfZEAOWNtFTwV9qKILjrMBGVUpfs27Mj6UkNbfrBfXn9VCOV5t9gaJL7ur0VoM2yNLYC5Mi8OmWqjb94mraaewHZMZUeZgAdo4hrkMmIw/f4HcqA7IEVAGIDLWA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:38:33.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d610e4c-b09f-4b8c-3e61-08deed4cc666
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR16MB4352
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfX/2tL1H2dlKvj
 wkn7RuqcNPdRua5rOPVa0AjLq1761IdKu/our/L5CzwOSV5bkgzS//TokuXLwAap8Bn6yKpSiWB
 A17gmUHizmVff9um1VBL0gKPTRjrzHbxwad6pQB4fS1tUhdvy31D
X-Proofpoint-GUID: rNqjYL-w-hWmPPGZXlvjucmN8SZDsx93
X-Proofpoint-ORIG-GUID: rNqjYL-w-hWmPPGZXlvjucmN8SZDsx93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfXzKiaZmMbI3MH
 22A9l5nr6hc+Vknvy5IGcQrpwJ3YVWDEF63eLPAtove7xia/ZRwRaWmThKmYVu6m0G3Lhu6S1dJ
 ycgSYwXAffZWMNLabduZlZj0cyUMecIvPKNUQWkYQiotY0IHiJOmympiZC1ezSNHou7jcxGMZ9V
 xrpydIMf9NyFnudu0kIOlBx7CBOZQ9/YcqentPtcQLDJv3sk7ylMWzRbxXQLOb02c0BD8PgsSnf
 jsi2kkFjnuOQMlaqsksDk1IXMWC68uujjyBvOnuWphAP7viMp29Bq3W2E67DcSg4vUlVv4DS6pD
 X6rmkPTvjo+6lr3G4H2IUtECKxZY6zbTMifj94qQqReVSWNtk+Arewq8Ihivpl1tI84meVhd9gk
 9ux+N/eWKdmZoLfoUo2xx/CQfYvN0jtUSfGoE7woR8smV+qQcQkB3QMhA6oHL8gA32GTyA0Ud6r
 I/YEDtbJFhFtIXfAnOA==
X-Authority-Analysis: v=2.4 cv=XqjK/1F9 c=1 sm=1 tr=0 ts=6a69bc10 cx=c_pps
 a=Y50mrEwtfcpO0Uk6WJhX1Q==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=ssGtgqLs-8kEB-WaXhQA:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=K72
 6xwF1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=; b=n5Zx5uzQ68hZqqYHvh3
 SZ10mv+PNh6srqTkQRTlAzVxURsmkdpwxW4LsL/ci4oTQW2HwydHP8mInAhvYLQl
 3V5do3IinkPUmftzs2nu3qyhjs4mk6oUlsgsaHDaZKLWsv6QSBw+eVHJuHFArseC
 YeGSY4bkjytZd08mwMrpvBVhZYOPAU26qq47a5NC8yt+76bGuoG297TF2NIgM0kd
 wcC5TltbwEXRhqnojmjWtm1gav9QYlLT7mJczHIzzCR7EKC7JwyvxND4t6lOmaYh
 Qt0+KPTn72by9mgZ0Eey8TZiHECbQjA1KDWLYvt053T9dNge/tsT2SXIJdqtb5lh
 EhQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K726xwF1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=;
 b=ZxhmDaXZlWmhRQwFjS0+amM8+Ucl1G77iuON59KGLA4NyBRQai1pjcxlZMOVjRdjkPybUDVepY9ozoLiTw3uaASOQDsFLq2DmRP3RVpontHUlK8jZnIu50JaXCnF5ZlZh+ryHYVt2vNQXW/nHoJWF2IxOhzG2qMYjTC5zvd/fKQ=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=K726xwF1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=; b=
 e/B2vllnRN3fk5tKcZqn8Z7DgypnOU18SpDznq1G7kJcduArpcV9NeWCBOVaDGbB
 iXgll6EQDj1M92w4PzlU8nErcOn/B4G1M6e5aEXrmrox18m26AlY3G6ofe7ZFM+N
 WicX9m4ksivUR0bLiJGSMJjGFgpTX7X7j2nZT0owlnHu15JhP2+9XxHJ76IZkfn/
 1bUfh/Ayut0ax+Hx/fynavkqbqwSy6bauipHAGxnHYcxP6jH9I8/wB2JRA8xJsZj
 Z/YbS8LdIxvl1wABeyOilHfWp4cAEhJ/WThHx1PjsbRg6G+U3QRtcpHRndF6ACVu
 MmcP/h+4dFWPISi+mt/ISA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=K726xwF
 1yodHUULNiUibzQssQJsU2oZCDHdB+rS5aT4=; b=abBMobwPXSzG0W0nk4GBaPb
 r+dungjNYDaaRNcJyjVc9ag86T/C2Wx7bk1Wsuw4RBpKb9uXhxiyQuuFZ/22GQxs
 bHy1a6430Bsk3yIsAstPCOZMFRe5OKLjGpjVcp1F/Muh5Zah7eLwxG+Uuzbi8BmP
 AcESUj+S4ga38rlUaeWg5OyKk7tgroAyjsj9ilsQQsNydrgoR0LQ4HAdH/cPzm/4
 QU/rmuhuYBLWQYWl8MjseGgBgb72Zft6RD4ByMPaJ7Fos6qOc/ClEFcjDlLyubfW
 ARhutFJKhyDeAdcilNrI37BFr0FyojSlURFR/8awuplK2DfKqNY70NZ1IxiXGBA=
 =
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=n5Zx5uzQ; 
 dkim=pass (1024-bit key) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=ZxhmDaXZ; 
 dkim=pass (2048-bit key) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=e/B2vlln; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=abBMobwP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Denis Mukhin <dmukhin@ford.com> 

Use cpu_hlt() instead of open-coded "hlt" in pch_sysreset_power_off().

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Original patch: https://lore.kernel.org/u-boot/20260603070743.1268544-5-dmukhin@ford.com/
---
 drivers/sysreset/sysreset_x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index c2f28c65280f..05a3ff9c8363 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -65,7 +65,7 @@ int pch_sysreset_power_off(struct udevice *dev)
 	outl(reg32, pm.base + pm.pm1_cnt_ofs);
 
 	for (;;)
-		asm("hlt");
+		cpu_hlt();
 }
 
 static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
-- 
2.54.0

