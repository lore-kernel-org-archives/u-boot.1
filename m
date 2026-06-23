Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520A4CDB47C
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 22:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E8484A06;
	Wed, 24 Jun 2026 00:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Gsg77PnB";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="iL34m8gq";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="iCslQN6y";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="sI+ldM9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F4D84A26; Wed, 24 Jun 2026 00:06:50 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F2484A06
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65NKrhfA3157332
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:06:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=F0E
 Q4+NX2rVUu7pg/lhSRtp5elbslNfp3mNoHR2zNA0=; b=Gsg77PnB9wPj9gQIPU6
 EKzQe7t4CeWpB2E9tUpMqBr+3DzX7xiAzJ8CkTR37mXp6lZGLDJgGtWtfgT7661q
 w/wd3jC1HZhyMiFnUAUDf1PgizwDSamePkojT0xvmqxur7mpZzZpcdglmIWDhsZL
 5gVcLsGGqG+JeNi/C6/Uv8slABLxmUneZrbByFAY81r6kkJN+/I9CCn2sF0GVBBb
 5AVWOmbh9SKEMyNTzy+UMrd1d+/8OdkdEmAApdJFssvyXhymYgVn65WFB9fh/CE4
 K/VRU5Jnv0NlAFvcqH6YOhh8pWgAv6mKW6K/Lk8Om2JDQwDkKDVwzA5q/txr/Tr7
 r5A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by m0482515.ppops.net (PPS) with ESMTPS id 4f01k50h8h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1/8Oh2LRM1aUUGKykxpYid3sqS4PMlLrEB4zy4s/VCa1S2t5p6Ue+c5QZdpN5XMG31Ay5bxXIjt7Yw5crCerB3ERY+s+7TQJ1BW9vlyHJ7ic8JmEj76DXonRjeZMKOg9ISOBFgNPtNgzEd9sU7zPrAdnOiK1AfXs38Scyvo306VrwyrLZUduskmtmYFpyvGNLWFbo4OgoBHh5MLeS7iKi8wdSeHLjh59OHiyK1AZAJ30R5ctjzShN1rlS0s+sFvYAT09f7/np5Y/GTs10wu9bT7brqCO9d5kDFHhWgDEQR0b8VJR/yu+u6/lI9tBwfNSt1CRSFr71pSD61bUyU4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0EQ4+NX2rVUu7pg/lhSRtp5elbslNfp3mNoHR2zNA0=;
 b=hJhF2K5ak2Ef6CYFLI3AwlS3bIjKqOVI0lMfkebqk8qtUJzBI7DKFpLqJo/6+b6+xcaC5CnZH86AG4PvcsLGT4BVj+42IlcDgcCCiCWo1DgJm366gEM2apC5nZ0g6VJg4z9W8OpqhwxwNhn4Wj7vCddXa5xW7PygtNNAMwQx7R9y4jY8jofSs4XT8/L0Txzz6X3WwKZ4hknso0as6Baz5KbeTUub4mb8rSw3qzIfAa+2KJG6Fx2MwDSH1uouXf7pbP/yYAe6CMz5QReICRR1LP2kP71TnT5YkkbJRfwmJi5BKv+snPxsZCUviHrSuKVwjzmvDu8Qln/+ldCoLi/S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0EQ4+NX2rVUu7pg/lhSRtp5elbslNfp3mNoHR2zNA0=;
 b=iL34m8gqzIVNrJivUw+fUiqUe1b4WT5xq2V52+KJ/P9Yje+Z6PyUKxj+9uzslv0w+kuT8hxpZc5FQ1ych9vRzfbtXUQ5sxnmO3P9WK4/KzeFwnBD9x60JLL5gZ4ntDGF7fmkSQuu0cehxnm//Vw3/PW75WzeXaTHZJyHASJgFlE=
Received: from SJ0PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:33f::34)
 by PH0PR16MB4735.namprd16.prod.outlook.com (2603:10b6:510:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 22:06:40 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1e) by SJ0PR05CA0059.outlook.office365.com
 (2603:10b6:a03:33f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Tue, 23
 Jun 2026 22:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 22:06:40 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK14iV1709005
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=F0EQ4+NX2rVUu7pg/lhSRtp5elbslNfp3mNoHR2zNA0=; b=
 iCslQN6yM6jMHzcFU6hVpWGfTi/DtJ+bgTO1uXVLVIAJi3wWi7CkSotqL3vbM9z3
 Si2e/TqRw8vnoGGbWY+6akJ+ycDy/odSmIe7TRjVtrKLz97nsMQhd9mW/6bDd8yo
 6WamyRcc1hqpwvi6/ZwaDXX9wNuNhxpMEgB23ErpsnsThbQSp6VOZ/xjuglW0FTa
 vtd3VPUOG1qIWfMAi1f+8oyGl+n6v5YoTzI+5X/ptUMnRT7Op09vlIgxp521aIiX
 cWi3+lh1xQ91uaEQQFY7cB0t5XzBwTjiW2G0dgK8Bt3ZirxJs0lfV4J2UYlCjKCI
 RQbgcZdvL8EbrkwCDXrwMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=F0EQ4+N
 X2rVUu7pg/lhSRtp5elbslNfp3mNoHR2zNA0=; b=sI+ldM9MNkmlftjrxLv9JgP
 rCWMc4TqECuQ3isfiMgClbP1g8DM9kyOzG1zxMLHjmgH2P/fB45//guOoED0XGZU
 +6+3KnA7AFZOcn5v793N7JtKUneTuLDGotkiXdvGqPRfKq7OKP/9WB8OKVct2S7L
 K9o3uRAQ4jubbsaULPEPv8r3JKiBXSUl3OkO2BrFumUxkNEjEL0xXuSN08jSVQ/h
 MHRTlxXZKPFmipd5a6cWX7b2gfAseVygYWFA16bkr5A5E04dIPQWqN/3DbdRE7QJ
 okv2tc5j4EvGwMtnzyNFmsFEe/HxdumWvi4pRkJ3hYYUA51WW3AanswRgCq4k2Q=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9a4uq4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:39 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id c9GPwlzneaKlDc9GPwh2rq; Tue, 23 Jun 2026 22:06:38 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: c9GPwlzneaKlDc9GPwh2rq
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v5 2/2] test: bootdev: scan with a broken high-priority device
Date: Tue, 23 Jun 2026 15:06:30 -0700
Message-ID: <20260623220630.2828767-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623220630.2828767-1-dmukhin@ford.com>
References: <20260623220630.2828767-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230181
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|PH0PR16MB4735:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 59dd03fb-658b-499d-cdb1-08ded173b3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q+IMMLbYj4jqq22XlV7GWrJUmIXr8NGvIjRr4cSWG3W5a2wdm5hnJN8ZV0lZ1M6Fe9QlkjeGL2cVJ0AWSRwfdalkhnUvaBPCTHdhkgXJkrchVrZN2DhDHIyx3S9GAgFSMOcD1J0BcerQ7zLapim96olTHyK7jJTsxmxk6E0dHsEyfODZuvGFttvNwhstilIVH1y3MtCl/ajnQqkZXFz0U0I1V5cvpfLu3s4/v7w+UmQy9VQQyzVK+zwy1EjiC6Bc+yenGSoKFJerMDuw29DLvP9odD+JwWs2S3/iftVw83OQ1XhWGXMbeREQrXr2ZuRTV+gvXfnewVQihcdBT8UA3Z3MCv+l4qEaJvmjNZ6seVPBpLPgvue1AePwsKmtfslOn3aT108CzqzsqQuFo4Uvo/RnbfX+PnPwCuqiXZ02ab+qh8RsC0t76KzNWJDhwnYKRX37J1UVr/Me4AX0gA0P4hUKhrABiMkQWjGZ8/KYp8qfLiWe/AQP9QFk3Yi9abL1hrUdbm8cmHxwBsvgnLXQ7nXRV5R1gHuj04WtdA5on7GoR/7/JtatnXIDD9Fh1+nMbnpYxHsUM4RdsSEGyglFawf5iDqudklAI/ycuxNF4Z0qccRZXYyH7y++UZb9TEAzseSp/P2Zb+70bkiUkA3LZGICpv2O+JamJzF2VQKKmUZqacICRPjvHTg4qJzVpNDDmgPsC+c3q6BIc4wHt6Nd2Q==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r5dSAOj7GzmyIPJPon0zHQ9OOznY8fDq2/pLlp1bMPzeY8b9SBP1kxlpYNToRuSU+Yz/MxJu3Tl1XMQS3ufYq98p/ZiGWIfK98HKBt66Sz9yHchWLqzVZ/jeu6oW25LbdW+HOXUQ7DWeBOJJkdZIAbWRwKF1P+sAJyJeb/ywfgxf4+sYimlVBsWdeKW42F2UEph7ijDxIrYKKtvBAGTrG979F7JBtCbbjfz76LEe5cE7noiNp1gN1GmnG4mDuzqM/Xk+3eauz3lDsUxgoKoOrrHiajq+cganS+Z6wqCyrd39gcngW72qdItmrxZRXDxAIzAtSEtSOSaqEx+RquHqHBxSJLjgvuZZtArTZ2+szwNKpuwK4ztvy7U12vBTFZxrlfNRYoLIjUe50O2d/AIegvRB8+OrVTum/Uyxz4sxP6XnH7rnP5RAbmYI375J5l31
X-Exchange-RoutingPolicyChecked: D2WaibgWWShb44XWPX4XftkCgUZ6iZvanUJm4nNI3i2Q6IZsZWWRqnoZ3qASoa3y8f7N3JmxHG8fWB9ueZWRf+W7gohMIyLx7p8I99ySu+1JSioL4u7t44tgkD3O4c4H99UWToWM49D7Zp7VidOJi8LGTJNJ+vSzczLSbLpglQTt/2hBPLjZxQzoxefgGFHqLQwiCBBTEhWG+mO26YPKymQaCCaHMTrB+hsdsAttrZzN1REpPwAaGNPE9OUZRdR/rCT3H3jauUKrWMqAAXoOiFd+DvV5bpGxbh3rZZ4YwRpnfc0a4s3yKg7QV2f5jV9/4V0ayBETn4gbflKE7+x34A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SN8VCe825p2ehDVNK6zHrPr7elUb7ujYg7McsOtqDaH9i86Qvpfs9CWDX0nbXXBnu+/My8Ghy1FdwerIpEs3xLICzZmg2L/gmw65xw+U4/J24PbrZTZ4q/qm96p1gMPSAtlkxNqCxa83NJiD8m5wm4XOj4yRr/r/KBaXJ5QJCjFuqG1NsMwe9FhgplCsL78nap2A4vn+E7cAyX6tut3Il4D3VAo/888ZsRgq2hkWcC5PU0UttzWNe3ArNCnHofUDp6ovz3reaWKwOVUNT3q2xeu7u1hYnQllUiAeJJ4I0ArYiKhAjOlbBBBZ8rw7W6HAstBfoEhotHJXMGwEk4J1y6kUdzuizaRm5c3giebUMaWJBaRmLNF+n0LgyaYDId8h5yIoc/NGlksFd7wt6VZn8GcuZwLEYKMuebE8pRTIk6Ki7ZslVk+z3lxHop9QUEEbeWKeszpRdA8b7XL1dYUFHjKLaPtBdNhi9HA3oOdKs/lsFevIsOxWFAmjjnkEGlHd6EDEQx01ISEORqPM+BLaLOpuInzcwIJY6E+YFKuSGKL+xApTwhtSvracAC8PMO81IX/AthaPTJpPmyZlXrLlVSz/EmaTZ3gSpomwObOP82VbRazlLl2hk89Ax7wCtc9QvavlBAj3uHhhGan8W5b95w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:06:40.1880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dd03fb-658b-499d-cdb1-08ded173b3eb
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4735
X-Proofpoint-ORIG-GUID: RSr5vayX6TZIDWbWVMJdTGqG8l5oaITy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX8Zd2k0nh3bOP
 cPPNOXSFPUJs9rc1+ju5BJUi0S2rb5exsOk6m34FB/xoyOkq3JaaH3zKVzzbFFS7yee0gn0YzX+
 y/jVGQsi0ZZNGqg4oB/oYyUPWrBL9EoiP6Cf4bizEK+KbNbIvId3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX3KuXvSFrzpGu
 M25W6zWIXNpWYdC0n+LURxetVjdusux6AtRnXB3I3situfe5fMRy40wo6ZiyI2lqEvY7jFSGQ+w
 25CRRaEjcHvuDtKCQSSAEpZhZ7CaHRCIjSGtdkMIqJXpZkmLVHpGQw5jKGE2vSGS9de8fEYWSbj
 TZzZOduvNamtc6LkU5ZFLZAVwxXNYwOgOgLOBpE7r0AwBB4Ba+Muz7Qm2/zz0b3ODKIihgZTzFB
 akyB9ne84EC3FZXLA8cnCcAkg9Zv9Rc63fAat7/YR3PcWtV0zeQkZVlCi9iA7Bu34PGRXSS5qwp
 JnuG7NCS7GS67djly4qiUH+SufYd1VHXICQEK6fo6HYUYROOW4jjo8CdinQsn2cLgSHTUeS5JM0
 VaVQfK4jSHsNmlbnPZVaCmTUZhJbCkFjKH9M3lSmX3KEICmrTONqC8YGJ8NHZigd8CheUpkeddz
 uUf+nb7HKT/4osYdYWA==
X-Authority-Analysis: v=2.4 cv=MJxQXsZl c=1 sm=1 tr=0 ts=6a3b0375 cx=c_pps
 a=zZIwMYV7Wou7+0JapvgM9A==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=i1MxBqhcqyiCWgHNAf4A:9
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: RSr5vayX6TZIDWbWVMJdTGqG8l5oaITy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230182
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

Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
falls back to a lower-priority bootdev when a higher-priority hunter
fails.

Introduce a simple 'sandbox-bootdev' device for the test. The new
bootdev can be configured to produce an error at the hunting stage.

Introduce new host_set_flags_by_label() API and a flags field to
'host_sb_plat' to simulate a bootdev hunter failure for the test.

Adjust boot{dev,flow} tests which depend on bootdev hunters.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v4:
- addresses feedback from Simon:
  https://lore.kernel.org/u-boot/CAFLszThk7mWg+7LrVcN9xY5owrpUwhCTLdf=XHi0K-M-uPKzXg@mail.gmail.com/

Changes since v3:
- addressed feedback from Simon:
  https://lore.kernel.org/u-boot/CAFLszTgU3X2GUTny3oG3+HxAuuKrGu9di7-oGBM3xaP8ZRVA6w@mail.gmail.com/

Changes since v2:
- dropped 'flags' from 'host_priv'
- added description for 'flags' in host_sb_plat
- switched to log_xxx() calls in sandbox-bootdev.c
- corrected sandbox_bootdev_hunt()
- updated boot{dev,flow} tests which depend on bootdev hunters

Changes since v1:
- new patch
---
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 15 +++++++
 drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 18 ++++++++
 test/boot/bootdev.c             | 23 ++++++-----
 test/boot/bootflow.c            | 47 +++++++++++++++++++++
 test/boot/bootstd_common.h      |  5 ++-
 7 files changed, 170 insertions(+), 13 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index f5a9d8637a3c..c827fa81a2d8 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
-obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
+obj-$(CONFIG_SANDBOX) += sandbox.o sandbox-bootdev.o host-uclass.o host_dev.o
 obj-$(CONFIG_$(PHASE_)BLOCK_CACHE) += blkcache.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap_helper.o
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index cf42bd1e07ac..95b0b0b2ffea 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -150,6 +150,21 @@ struct udevice *host_find_by_label(const char *label)
 	return NULL;
 }
 
+int host_set_flags_by_label(const char *label, unsigned int flags)
+{
+	struct udevice *dev;
+	struct host_sb_plat *plat;
+
+	dev = host_find_by_label(label);
+	if (!dev)
+		return -ENODEV;
+
+	plat = dev_get_plat(dev);
+	plat->flags = flags;
+
+	return 0;
+}
+
 struct udevice *host_get_cur_dev(void)
 {
 	struct uclass *uc = uclass_find(UCLASS_HOST);
diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
new file mode 100644
index 000000000000..15af0c17d1fa
--- /dev/null
+++ b/drivers/block/sandbox-bootdev.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY	UCLASS_HOST
+
+#include <bootdev.h>
+#include <dm.h>
+#include <log.h>
+#include <sandbox_host.h>
+
+static int sandbox_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST;
+
+	return 0;
+}
+
+/**
+ * sandbox_bootdev_hunt() - Hunt host bootdev.
+ *
+ * Note, this hunter exists for bootdev testing to simulate a failure
+ * mode.  Do not use as an example of a real hunter.
+ *
+ * @info: Hunter details.
+ * @show: Enable extra printouts.
+ *
+ * Returns: 0 if OK, -ve on error (expected by the test)
+ */
+static int sandbox_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		log_debug("hunting %s\n", plat->label);
+
+		if (plat->flags & HOST_FLAG_BROKEN) {
+			ret = -ETIME;
+			log_debug("cannot hunt sandbox device '%s': %d\n",
+				  plat->label, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct bootdev_ops sandbox_bootdev_ops = {
+};
+
+static const struct udevice_id sandbox_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-sandbox" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_bootdev) = {
+	.name		= "sandbox_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &sandbox_bootdev_ops,
+	.bind		= sandbox_bootdev_bind,
+	.of_match	= sandbox_bootdev_ids,
+};
+
+BOOTDEV_HUNTER(sandbox_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_HOST,
+	.hunt		= sandbox_bootdev_hunt,
+	.drv		= DM_DRIVER_REF(sandbox_bootdev),
+};
diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index f7a5fc672300..1330358ef7ab 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -8,17 +8,26 @@
 #ifndef __SANDBOX_HOST__
 #define __SANDBOX_HOST__
 
+/**
+ * Device flags.
+ */
+enum host_platform_flags {
+	HOST_FLAG_BROKEN		= BIT(0), /** Simulate broken device */
+};
+
 /**
  * struct host_sb_plat - platform data for a host device
  *
  * @label: Label for this device (allocated)
  * @filename: Name of file this is attached to, or NULL (allocated)
  * @fd: File descriptor of file, or 0 for none (file is not open)
+ * @flags: Device flags (e.g. for unit tests).
  */
 struct host_sb_plat {
 	char *label;
 	char *filename;
 	int fd;
+	unsigned int flags;
 };
 
 /**
@@ -122,4 +131,13 @@ struct udevice *host_get_cur_dev(void);
  */
 void host_set_cur_dev(struct udevice *dev);
 
+/**
+ * host_set_flags_by_label() - Set the host device test flags
+ *
+ * @label: Label of the attachment, e.g. "test1"
+ * @flags: Device flags
+ * Returns: 0 if OK, -ve on error
+ */
+int host_set_flags_by_label(const char *label, unsigned int flags);
+
 #endif /* __SANDBOX_HOST__ */
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0820bf10ee08..c2eaf0b2c559 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -384,19 +384,19 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_nextline("   2        mmc              mmc_bootdev");
 	ut_assert_nextline("   4        nvme             nvme_bootdev");
 	ut_assert_nextline("   4        qfw              qfw_bootdev");
+	ut_assert_nextline("   4        host             sandbox_bootdev");
 	ut_assert_nextline("   4        scsi             scsi_bootdev");
 	ut_assert_nextline("   4        spi_flash        sf_bootdev");
 	ut_assert_nextline("   5        usb              usb_bootdev");
 	ut_assert_nextline("   4        virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
 	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
-	/* USB is 8th in the list, so bit 7 */
-	ut_asserteq(BIT(7), std->hunters_used);
+	ut_asserteq(BIT(USB_HUNTER), std->hunters_used);
 
 	return 0;
 }
@@ -417,7 +417,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("Prio  Used  Uclass           Hunter");
 	ut_assert_nextlinen("----");
 	ut_assert_nextline("   6        ethernet         eth_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Use the MMC hunter and see that it updates */
@@ -425,7 +425,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assertok(run_command("bootdev hunt -l", 0));
 	ut_assert_skip_to_line("   5        ide              ide_bootdev");
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Scan all hunters */
@@ -441,6 +441,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 
 	ut_assert_nextline("Hunting with: nvme");
 	ut_assert_nextline("Hunting with: qfw");
+	ut_assert_nextline("Hunting with: host");
 	ut_assert_nextline("Hunting with: scsi");
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
@@ -458,11 +459,12 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
 	ut_assert_nextline("   4     *  nvme             nvme_bootdev");
 	ut_assert_nextline("   4     *  qfw              qfw_bootdev");
+	ut_assert_nextline("   4     *  host             sandbox_bootdev");
 	ut_assert_nextline("   4     *  scsi             scsi_bootdev");
 	ut_assert_nextline("   4     *  spi_flash        sf_bootdev");
 	ut_assert_nextline("   5     *  usb              usb_bootdev");
 	ut_assert_nextline("   4     *  virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_asserteq(GENMASK(MAX_HUNTER, 0), std->hunters_used);
@@ -646,8 +648,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_asserteq_str("scsi.id0lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
 
-	/* SCSI is 6th in the list, so bit 5 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -657,7 +658,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* dhcp: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -667,7 +668,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* pxe: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	mflags = 123;
 	ut_asserteq(-ENODEV, bootdev_next_label(&iter, &dev, &mflags));
@@ -675,7 +676,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* no change */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(SCSI_HUNTER) | BIT(0), std->hunters_used);
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 56ee1952357b..1cc137c97005 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -19,6 +19,8 @@
 #include <mapmem.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
+#include <sandbox_host.h>
+#include <os.h>
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
@@ -1532,3 +1534,48 @@ static int bootstd_images(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
+
+#if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
+/*
+ * Check that bootdev scanning does not stop if higher-priority bootdevs
+ * are failed to be hunted.
+ */
+static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	struct udevice *dev;
+
+	ut_assertok(bootstd_get_priv(&std));
+	bootstd_test_drop_bootdev_order(uts);
+	test_set_skip_delays(true);
+	bootstd_reset_usb();
+	console_record_reset_enable();
+
+	/*
+	 * Create a sandbox block device (BOOTDEVP_4_SCAN_FAST) and mark it as
+	 * broken so that bootdev_hunt_prio() returns an error.
+	 */
+	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
+	ut_assertok(host_create_device("test", true, DEFAULT_BLKSZ, &dev));
+	ut_assertok(host_set_flags_by_label("test", HOST_FLAG_BROKEN));
+	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
+
+	/*
+	 * Scan with hunting.
+	 * The sandbox hunter at priority 4 must fail, but the USB hunter at
+	 * priority 5 must still be reached.
+	 */
+	ut_assertok(run_command("bootflow scan -l", 0));
+
+	ut_assert(!(std->hunters_used & BIT(HOST_HUNTER)));
+	ut_assert_skip_to_line("Hunting with: host");
+
+	/* USB was hunted despite the sandbox hunter failure */
+	ut_assert(std->hunters_used & BIT(USB_HUNTER));
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
+
+	return 0;
+}
+BOOTSTD_TEST(bootdev_hunt_fallthrough,
+             UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+#endif /* CONFIG_SANDBOX */
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index dd769313a842..672917454a31 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -21,8 +21,11 @@
 #define TEST_VERNUM		0x00010002
 
 enum {
-	MAX_HUNTER	= 8,
 	MMC_HUNTER	= 2,	/* ID of MMC hunter */
+	HOST_HUNTER	= 5,
+	SCSI_HUNTER	= 6,
+	USB_HUNTER	= 8,
+	MAX_HUNTER	= 9,
 };
 
 struct unit_test_state;
-- 
2.54.0

