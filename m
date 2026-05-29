Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F09CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5DA8484F;
	Fri, 29 May 2026 05:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="I6cJMhqf";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Ls6R6bgh";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="F7AWZFJd";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ovWDPLss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66D584671; Fri, 29 May 2026 05:48:56 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF3D84659
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367129.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SLrAam2528531
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=c+d
 8THHu8Br09+HVDRFT5jGbcMRqvwcnlqoLfDivhLE=; b=I6cJMhqfyN0uPATJ9j6
 wFXMNEQtPwwM66HcfxKeYBpgnoU8QwCWYA7qYljgwQFHEco2A/9xJBB3rWvsrSFb
 8MMhZQBgrCCQc24KuTJeyoY4azDjcXkilsfL5TU8fLnkxz9NOx1+LzIXAMfdr7Hz
 7c6b8FZedk7EC0bCPkktXG4u8FjVnpNCwf2ODk921R8YxrCZULkLcNZRtAHm+M28
 05Pl9yge2FNmpoCENz9Ow3BWiJ8gWzgwCMnobZuZv0iTwdHUE4pZKr4rZ61Zf74w
 NYieh9apKU3H0D0l+Egj4VLcevmO6v7djxAiAgngiVO18vbPWILQGBCpyA6cvAqX
 u6Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4eex0uhj5k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+RImPj+8g2b72l3VOz/+/o2soAkbEY33+7hNadpeQJQHHMvav8VS3a8V9rH/VhsIdgYq3vm5Gnr4aFexVLfKoRTaY/W+bflVXfkyXOnecyhTf8nBk7P9wgjGYE+ClUHVpa0xjm3TSdpgktZQUVLoFgRQNqipzAOtn3faALCfAMCSq2PyJqUr96DzIVSh55riLXggn7xSh0JwiqkdC+VORloo8HqKsWBL9R4ecwvj47e2c2DHRdND4CiBKhNSb6z7AiW1ueuBXe1xyEve4r6qds7aWtAQzruAvlHujhWp8Rk3QI8sTRMSWYUWZySF/z/dYNY7AgKm+e/AQlCUBeWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+d8THHu8Br09+HVDRFT5jGbcMRqvwcnlqoLfDivhLE=;
 b=WKOcUzHs/W+ug2COGCiuNdTvIsGbc1JT9RQY9XxOk1eqjGOsyL/kigvXx4RabAg3oAQJ9nznWU5S73D3IkOvYHltP5ZdnxrmsgB6z7mDEFI/6tjH9Lm8itHeBpIAozCCOT0KuyKh8tBZ7ThOOD+a4gQkB0VrVSTiVCwiLO/ju0Q7xKKp2DqkmIS+FilwMTlgE9jEj2NXNtHSHtqki8CqVWKiIRcq6AqB9f2cExZOTFXwuDHBFg99FHeW3i18zfOvevTu7cshnN7Gw7aLPrZKg0z5DdogatXimTj5w4X7kgxWscEH5bko1pAVjDsXffYkkgSG/0a6i3PLSjFoXuoIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+d8THHu8Br09+HVDRFT5jGbcMRqvwcnlqoLfDivhLE=;
 b=Ls6R6bghOxCshIaXCXH4ULRYGk/pJuMptFa2IL0lFth/YxWyUhNzCFWCGLeOhfnGSOFJYVyXtUdfne5krSB7ZYcmQunHuATf//jeldZ6iNxdeLVmN02n6v+W8y9qqKA4avsyVMdS8ofFS7oLWMBaiaVBI+niDfdnFLBUzMM+YIA=
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by LV3PR16MB5810.namprd16.prod.outlook.com (2603:10b6:408:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 03:48:49 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::7f) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:48 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T2gJZN2743692
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=c+d8THHu8Br09+HVDRFT5jGbcMRqvwcnlqoLfDivhLE=; b=
 F7AWZFJdnag+15FjarCfNVDU89w+C+SRsoQuScy85mnusDFfJ1CM1SJY2Zk+NoPt
 KIZa22yOsVuWW5gesriIxilxoxQG0xWi/fzFzUMMDNjHrJOjoxBaklqCKUVeEc+p
 bayycHHfxL4fdGFtOBMsLF2agrl/ccODx0b81a1WUHIAcp/PxY5zUWUtk6b6IgJI
 qZV/rMLs/NoX2f4TuDOgqUO6ozlwrHQGfrKEQpejz+L7QFdU2Gz3NPEIZM5n2znt
 PpTNZ1+oQFDX+Ks+2BqvTktMbkPWdkYEQ4DMy31+MODAXfirAEQHOXSlz658hLEG
 RxsfsMAQUabA+yXDtjOusg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=c+d8THH
 u8Br09+HVDRFT5jGbcMRqvwcnlqoLfDivhLE=; b=ovWDPLssRlJyKdNtcm2hSR4
 +arAU+XcbXgfb5iRKdN4FT8YnbEL78hlt1v6vHgM837sX8scSblHA1f7XRUqAwcI
 M5PY9qFMAjScn/NQyacITQn+cs2Pi2dvQJCdv29u2EdMRcXUPWJElBvWQvfTZBQa
 V7XKQ/3lb3KQByQ72c+rotGKIJyY3tyOANWDFC8cltFc3LTHzZSeur3eO/12kWSy
 tSFAe1u2BxGOqn0Vvr1LQ5P6f49DYB+btgfAmg8G0KlufB9A/0MgWiTeQLqMyV4C
 sK/HPFxP3S/4uJT6TF4ZMOmmLFqcDrCHT1zGpLw0JTXSMXVadn19G1V9FgsaHNg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5su19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:48 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SoDGw2SUtonD5SoDHwbohu; Fri, 29 May 2026 03:48:47 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDGw2SUtonD5SoDHwbohu
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 1/6] reset: Allow per-board reset type
Date: Thu, 28 May 2026 20:48:34 -0700
Message-ID: <20260529034839.2075806-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034839.2075806-1-dmukhin@ford.com>
References: <20260529034839.2075806-1-dmukhin@ford.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV3PR16MB5810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a8aa8df3-66e0-40be-c8fe-08debd353140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6JlYpZ/IC23t7b6MODsVf+ToajXk5JfrktwIquymxRUK4UmHyKtft+WfcSRdbMmFTxSvWSlJxeKzo49GTOp1cOeK7ayeaGoAL87VFWYqN+r+LfKwQi0369AUJ7Mc7kJrYq4Sai2aegsDkj9K26hczXfcoW4/ywW/qyQiagSiB2R5b0a8VcXyPLkUU7rcOzCYLISwpaKROtx7UiLm30uLNBtWUxcMYCMZkbqFCh2jD79ophok9Sp4l50u3njziJ9V14B0SRf+tJ/IALnmCO84vN2ITCh2UDkrS2dmDtHGDIdz7xpCr4TXfftUsfeOEqZovoP9rCBKuWeOoUsdfMn63BRcLA9ae1uCvbsjX/IjnhB8VI3hV8lWipUCab0BYuvrlDyEpS3Ds2JqgQpK0CiejVjWGhkJgpk15Q0U5s8GsuSCLhNXbh5hWp/HPidW4enfUVvPgIEYgsTIMY/sGYdH1Sdwb2bUfex8WUr3jsCTO/aiu7coLm1Z4aWg2XQ2HhedvaFQJAeEN7Di2bg/6609aQvQ7HYNO5qWzyRx83nH3AVJHNMM+taf87n4s8FyrVlFn3KZbyvgaJwoMuuSnA8A4UrEer69eUW1RIfE9rldckNZoR3I6gsOTT2wjEyy8KlRXcZ0odGZ8bZr3ITEtnJZHhw62NoV9PsmadrDOL22nuX8ljMamjBWCw99/kY8eWw2en8KVtJk2FSdGSYkx8QuKCpYNPGN0IKZmUIy6uYmmQs=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PzaEjfIAI64cbQZnMzFzcnnUACquCVnab+DxLvvMSV/VHKUPZkmz70I7zQRdPwNrVKnljRFQmssLjI4uCSOSObZiOoUQgQhpq4BMnzFJ6twa0KwPUqLsV5QibTOV9gzkoqt11dOjMstKvTicwae+zfo4YFOn/yaVF4yoFiFTImPYKFUaOUL6CLSZOgFuZIqta9RklptbRKQt0BD9j+W2Atx2H9zu4wECkZHhUVXCz++ER576wXOEYkKgr8uU4HcUorsAJhgks7C5i8D1fbsCCmH1M4WB3DtqLou+w11vGeu0PdZb1drnpL19PyrbVbI581nKCcuP+o6/C7ly/ZKtvR3oBFwzLDTx/oPQwK/AZL/rgfRi/xPsn4/lTL7io38iEiGMEfpJDHSu2RMCG4poARS7gLFIhAJoN3qZ5//CzQPnBobXy2JvF/fzYInemv++
X-Exchange-RoutingPolicyChecked: BDhZsxa7VIo3CMsC4f+RtMpMcxAfLNaizX+1q6fx4A8ijqiLMGK09bmZa4mpdhYxrRca9nx7Gj2JQqRzLzJVlNt2fCpkIG2KtAJWuoRV84Da+OnHgqQIIRb8QMm8AroPKFLm2y20clNxOZQAh+bw99/Swrtgf5Pm5+BgFGbygvfhjATa7mu4yaA3EpjSdcE4Yn34gpMxH97fwF4s4H2KsE3v3ALUGj8qqPoHN/vnz4r5j51McW6zYwegkiKIFppc1hZsLIIXCVIItx4saUuxY48bWbOq89KneWfCc3+R3eSC4zzrj/7/ely4sAAsYBLGPpqNwBiOEkg9qTmr+G0ABQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EjjJjJDdIPHonxzGQKKfloMJKw6wBH0htdkhHKd00YeEhGUQG+LJsphwrEZET0gggZSJou5oCViXEnnupOf6qaiXK07h9n4zv5oU0+/hpHOh5IAenB/RpFfqxtiK+7gr7P1LVjzXN/PG4d5gUC7s0Y4GeSRfwIQtIlNNdgW5zvQO1Av429UifN+WCpehXXEQoRlk3nZKwpkAwCIPaMWVgb6cFZM4f6lgL7gDon/rDpcP2Fh1i3Lql829iXdz40mg6UIt3BTe5rf2ipStXGYRT7NvJHPoG3LgdF5H8y+aAgdYnsRlQAzssteidXHjEB++nXLiBRuOTGe7Xn0o3MI1+RpZ48YVDP6C2b8HJVfX/JbqzTUQiMcoY+d3r1xOTZXdo4imre/4tBcr2gnCuMkcnGP5bAn1GxyQjenM8hXIWlpJ7mxF82VEtLhCeZU1Vxo5hztW4gz7w9IEOR5UNVqcUXQlGKXOIDfH2v+7EaT8x00XkfRLz8dagEdoSL9VtrZ4JCW/Gjq2EnFZAatmiAc189PGqefsL+2tl9eE+gHalQ1yPSVmfoSASkJAOqj2pMM16q16hsLPowmZPPjBa2EppGwoy8iZGfl45pGaLd8DgXWJ952EPU7ZCtKa0m5NpWa/D2llEdgFxEmqre/VnJAyrw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:48.9955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aa8df3-66e0-40be-c8fe-08debd353140
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5810
X-Proofpoint-ORIG-GUID: T0XDVG1ECHK9AYzGO2lbO41u1chgr_jO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfXz1B+X7cx3adF
 +35/KhB9q9xnEraKFREcMCPoOqLbhZR6ppKOig6W/aSqdULvmkw0y6EaKw7ZjFyVsyIaj5a0Qmw
 FTrZ+eu3SMQ38ZhHdFyYhG0sw6zlwLTUjmipFfhZzQCmRWAJWyJYwD3pPuy7ALcOFA+mhIHoO1r
 r4BNx+312aDZ2+3I1hXDzLcph009mw3VbLEl+c774E5eCT1r57xVt1OOk3lIG+8oBO0ullhfAOF
 /a2X5Urxkz8gTtTzWCMwC2/Qllm+ir+bCjcPjI6hvZb+BFMqTajXyQ9Hy1Y35XK6J7FG4m8ZFWW
 1a3F89BrlDQ4/NfXRDka6hAAX6Dho45msNHPqPiKdAoWjnq+IL6ve7X6s7zPWjl5+Q/RcvrK8Lx
 bXMpQgEBZzbVBQqEODasnRhbqOtZ6o8eShemA0Cjy1H6yfireOkdXnVqkoexAc64AblWG2QmYUW
 XsEQgMMyx3DSB9HOJvw==
X-Authority-Analysis: v=2.4 cv=ZLnnX37b c=1 sm=1 tr=0 ts=6a190ca5 cx=c_pps
 a=PurIBXv9FE+FLdDnXy66Mg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=X3KReqg2EL6A36SYCKpz:22 a=cbNQJ9GKAAAA:8
 a=ejiq-ewEror-4W4SFSIA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: T0XDVG1ECHK9AYzGO2lbO41u1chgr_jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
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

Some prototype boards may not have (temporarily) all required reset
types supported (e.g. only warm reset supported).

Add a Kconfig choice to select the board-specific default reset type
used by the `reset` command, allowing it to work on such boards.

Keep cold reset as the default.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- n/a
---
 drivers/sysreset/Kconfig           | 31 ++++++++++++++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 19 +++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 90f740f51d42..2584c2b203e5 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
 	  additional arguments for implementing arch/board specific
 	  functionality.
 
+if SYSRESET_CMD_RESET
+choice
+	prompt "Default reset type for reset command"
+	default SYSRESET_CMD_RESET_DEFAULT_COLD
+	help
+	  Select the default reset type used by the reset command when no
+	  explicit reset type is requested.
+
+config SYSRESET_CMD_RESET_DEFAULT_WARM
+	bool "Warm reset"
+	help
+	  Reset CPU while keeping GPIOs active.
+
+config SYSRESET_CMD_RESET_DEFAULT_COLD
+	bool "Cold reset"
+	help
+	  Reset CPU and GPIOs.
+
+config SYSRESET_CMD_RESET_DEFAULT_POWER
+	bool "Power reset"
+	help
+	  Reset PMIC by removing and restoring power.
+
+config SYSRESET_CMD_RESET_DEFAULT_POWER_OFF
+	bool "Power off"
+	help
+	  Turn off power.
+
+endchoice
+endif
+
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..d2fddb470bf1 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -150,9 +150,26 @@ void reset_cpu(void)
 }
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
+static enum sysreset_t sysreset_get_default_type(void)
+{
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_WARM))
+		return SYSRESET_WARM;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_COLD))
+		return SYSRESET_COLD;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER))
+		return SYSRESET_POWER;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER_OFF))
+		return SYSRESET_POWER_OFF;
+
+	return SYSRESET_COLD;
+}
+
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	enum sysreset_t reset_type = SYSRESET_COLD;
+	enum sysreset_t reset_type = sysreset_get_default_type();
 
 	if (argc > 2)
 		return CMD_RET_USAGE;
-- 
2.54.0

