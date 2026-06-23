Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90354CDB47C
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 22:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960E184A1E;
	Wed, 24 Jun 2026 00:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="qXFYrlQt";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="DZ+ozm8d";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="n1sPzErr";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="AQb7drsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DDF284A06; Wed, 24 Jun 2026 00:06:46 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513FB84A04
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NLL9jT3185609
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 22:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=nZoaViaDRkaaSuzrJUumNvsEw
 eii1hOLfCvdGlWJaec=; b=qXFYrlQtBCoPSPrQFJXk03dhefrEHRO0ZO2rfDDSA
 JW+1dSxrosVE3x+fOn2VJdiQZIVpbtLfsJ+R2nQbnJgf8SkOUenMgzFhzGnsV9d+
 1aJW1xk6B9MU40+JMWaXBADHnd+gjsAI4QZS2UbyioqeBfm0iTWRiyn2BM7wjsjY
 UAPfOnCXO4dimciaWvPQQCP+nLI2udsHMeEgQG2ARPo9OhRDKTyn77DlQrvYD5zb
 fTk2s7cQI6qDRkZR8SRSUmZ928dMb7mJQzK8ANaUtgWO0de7Bgb8JHlAyAqYqiGK
 CmLtZ8Ufac/7PYvU/U5ctrke21UtRsOShTYEqAEvPSKSQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4f01ypr9kd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 22:06:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMiK//eK81qhw975gy6yxsaSoTmjtxz0jpaePDfU58C1FJiacp94g9/6E5kzWyFpg26r7ibpHtsMQXWyECq/3mtSuIZJMfsqVnVLgmf0dPMYgbQfB+uGGx/Myeh3Abp4tQ81ZojbhrSGi0uwZssBa7+yVIkwYC4RIeshbPB8S8IzvrYn6cLr6+7/immDWnDCxihMkXuvyM2BCx4gP0ZRUuH42MnQUxzbZd4q/7yxhhYwnuu0F3lcnxY0qaxQ48oKUNeduhcKaDWEXsthrTqd26oFSS+MDJZ7Qg5VZBjq8npuA4IwZGcgjVE53vci6Ag5DZ0gjJQtfyqhs/NEAMALFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZoaViaDRkaaSuzrJUumNvsEweii1hOLfCvdGlWJaec=;
 b=ekjxu90qal7yJNHdFc+MgdgMqTcfFE9v2bkuELdmXvfeDq0ArTlIA5/k2qnaLXbaXdbxZ1Y2VHv/Rl3RSq9T447IZ6r6fojO8Fpa14022ICz+rfebtzUtQSmBtmAWW40SYx3cB5qRERJaidtXFcqTiB2Q0QA034noVb6F2UPa35JlXO2eW1M9dltmTthA98poQZavc5GPWx3EIDUubhrXqqeHqw2qC096k+/Faft6NmEETriQ8bLL9ogLrj9nxeCaQT3jyJhzhYqQLFQGOtaEcnMt6sWOxAQIIjNeV3pw6B7FM4twW/T9foXuRVSMj6SpUtHIiuts4OtGu2emlC1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZoaViaDRkaaSuzrJUumNvsEweii1hOLfCvdGlWJaec=;
 b=DZ+ozm8dVk4seBYtt8i7ywZZaNowTIFXD93XAC2DY+UwoUJ9XUD61Moq9/lT766lWhX0VmfJlSPQ8Kvo81j0Q5btro22ld5klFKbqitmvGAJJeA6xbk/3pWcfTub9Ovg1UFZQGort+OAHOUGEoV/E7feYg4RABDEn3l0RlJ4N4s=
Received: from IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::13)
 by EA2PR16MB6280.namprd16.prod.outlook.com (2603:10b6:303:25e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 22:06:36 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::9b) by IA4P221CA0010.outlook.office365.com
 (2603:10b6:208:559::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 22:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 22:06:35 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK12qX1708376
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=nZoaVia
 DRkaaSuzrJUumNvsEweii1hOLfCvdGlWJaec=; b=n1sPzErrwuD/hLr9vc2LCAQ
 IADH6wIUsyw05nYPvgr+BJA0Z+uf9esMgBAkqKVV2LqHrf98zsACKcSRHOkKxyAI
 nfNd1Vug/jm1NayUpZW/Gsn2ckO1WDkRGbf/deMpMvr6Za/r4s6tCQVJLkOJyXSb
 LS3clRV2uIIDkXOnMBRI4GGnxOn724R9DDANkeEJInENPR+fBjZP4x/d3Hlk+su9
 KWKtHhL8CFjY7a4Qes9VDNYXHOtj7xzb9hE1yisTqU+g2FmMlvS1NqO3JEaDD1Nk
 A+t2tR17ZqH4z4j1iqgUI+AtUiQKnl920b+mLAfzQremdGLd+l/+SpxBmxfZPgA=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=nZoaViaDRkaaSuzrJUumNvsEweii1hO
 LfCvdGlWJaec=; b=AQb7drsAwK6Xzf18vsxL4API2qMSk5+3ar9/pN8mEFgmJwG
 QXfmRCgSEk0tD5GpS3FUlllvPB9G5oxDJuxls9hOxZj1Nk8f370jmz99IvjGWmET
 AJBtwPqdZ2I2lmhC16NySgwhCWQQKmqOjuVKOUUOH7aZWKNIrRbkRcLDucrOy8mt
 1OWA8AUrceB0ocMVrHqrOh4a/OnA2JlayzBz0m/2zLUCwjoGcNzydknzkgDlnPrF
 HFbU4fFC11n97xczoSXCV3d3m6eq+3BsBlV4iKC5K0MdIMCNcJJOKC91RpwSAroH
 HRFWQqp0po0gXfCtK9ZjJmUmTPOHRFJr8IUQEmA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9a4uq4g-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:06:33 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id c9GJwj5IARTn4c9GKwlOff; Tue, 23 Jun 2026 22:06:33 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: c9GJwj5IARTn4c9GKwlOff
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v5 0/2] bootdev: few fixes for automatic boot
Date: Tue, 23 Jun 2026 15:06:28 -0700
Message-ID: <20260623220630.2828767-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|EA2PR16MB6280:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6918f4f6-681d-4ce0-c33b-08ded173b0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GOTr0FCutoPQefLrBlfUtJQzuyicxX4JT26ERy003ohfo11/q6rRsvVqgDeHYQo4qYW87XaqM1djNr1XsO2jcNWMJNztBwXpT4ICAl9MiznOaN79h4m/eHLJQnYpql2BLyKpnHxoOPv13nIJCRoKcMEkIAItW5uphdIk8vpcVEDzU4atB23cSKbmtup+CR3LKel9Zp9HquJ2E434/Ic/xk8Ljv+QlwL1UM/+v14DlDr354oWbsepCXGt6EMP83EC/Ka6DOei164grqZTaJA93f2jAYA/n7Vycbt+eA5IP3AP6m6okAY+l5voTE7sVPgGIqd2jHuuQnNdEa4iUE5JvWpAGarwCN3wFqYzzxkdC2fH6P+m365AzY36zWeKPgUwmBzfebGjj+N3CWBYk0mwUoYVhZIl04NC8hJdV4jc6aUXczt2yQa+DrleoKM7BYoY5l7b4OfwTltIkC3rbmOcWyUKy9canryqQh/5sHasR7kuIMxuuYhc2maHJwzT/isqg5z3TBjP8vFEI0SmApPVFP0VDfgFfespH6/c70vWFILaADOqJyVmqoWtXrxCoerYeRHdzOrjNK3bStFlLhCOsaLCpyupG93N4jj198BdFZn8bILgwrU6u73Cdv5vBYrYyB7UOpbEQj5IVSTX/nPWP7zo339D/hBG/c6126KAx5lm/71fe37NRaZzxuPiARsjalFY7Tlobp2odEtlGYhnEA==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJnPlyYKaYURcYoUKMwAJGVtInJDJ+C4IsUMGx0/q5ze8Gsu2mJeeu8e9Dt7k1FxFng4Ux0oDXRRhQ1Sawgit5dPBD/uX0ycq7LppiP7kyM+mKLANN2ZD9K3E4ffgaev077OtquHfXq70hfvdddFQ/ZWo0OfW2StrF/lTfk4frkf9l1grqHVQdc7o9j+2tiv0SHizBvJjw5ZPpVYtmSK1uFowz+1Gh14xBz5TPq4O+QojWX1tOyFguHAaT56rjaX8u6ah494so0Aqjf/hBRRu5FZ/c0SUv7Wra2YcFc5U4PxBzqFp/yk6oe8LGHdG0EAXqxqoOuguTUzr2rtXS1Yx382GOsIh03oeK050iWAAG54+NhDmckL/lR5IgItpbEI99YoVKuXKLKoYMJZJId3K+Ax69NzOZj2xLRCDTG7CD8+gPN22ndJkPX57Tjocgcg
X-Exchange-RoutingPolicyChecked: DOEf5shrukTdjRrDQg5gj/UBphAKxVPLQqSLT2nUfVyWSuQ1tH2HBxsl3fR2NWnv4XsSf1mybVfvzefYW2EmTdQuwjPmIvciY6GzGiajctLTiiQRHxfkabgNBwKEqt+Q+wMP+ffI7Y5nNyQ+7n2KSYKCQcuoX57GZtPGJwMd+GKqBUBR/3UIug/jC7uhr0ivycHoY5YYz1OutdJsmcKUxcfyMwdE/vJgT1e2GjBTTZD30liGAT2HObkyYP3jAGwe67AcWSNNFzpQRv4aityaLbM9jqE5x208So9fpTNQxTDBzhCFnQFr8Mx/rYrUeWwxp8drH4cVSqN+4O/tNBfGBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D9Y8lLnlAkVaiojsnRwIMNarmVlhThAs+9JAdUZ9hxEUnhr5cMTnIHtyLihMbXQyNqe4SiZq5UoGCx343hqmXcYfyybDvTxTRrIQfO/IjhZ58xMg4mxjFpTHNCW0oVNG7syFyI5PqK0jvcV+7hXzTv1claFjfGDsdurCsx5lA7gcG+f7CBGJ+DgtQjx7BeKSmUBB+SI3EbX99eh6iBIesF5kPvF9aUHd4Z8VOl8amTd6BWLBbn/VfMZ24kGin8VQSg7P12gw5LKKA9E5U5GqZEtlv9AnFF3TbeTnTreV1fixjZ5MqLH7+OTjQaxri59t8ZFCJQqd2drAnij6ZWO0bePCLM5YOKZVHlvZ30Tc1Haf6oxWO8KkZsyGppe80XNDnZmwSKxzOghcJKBCyTW7aM7Fz4XRLyhENNe6AGvI0fC10Wf8CnuxOsNX/51eCOwROE9pUk2Do8Ap3A6xLKrtHaHJn0VeFTt2FsSaejcXVJcblGdWT9tpZJ2TpJBSjvS2xnGNLmT4IePTp3WiHwcvfUEP7/j+qWq1TbFdjg44JgbCXRC+FvrbwUl+hRJFZoVSKy3SUHEw3vk4nZYJhz05pmpOq+s84hzkvJOxX8WITimSmtIaMO/efXMlAaFpIcy75xLfjQAY59dkPSWaAtmvdw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:06:35.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6918f4f6-681d-4ce0-c33b-08ded173b0f0
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB6280
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfXwc2ScwdwBaGR
 V21oq6IdSe10JLEUghwgwWj4dDNVfCiz+Wr183VKAK6oEUrDzvqRf2H9qdgzAllRTevxvPtrLaB
 n9ICZ5x/S2jk0WBf7lcIB+fGaQmnZksYApQocMbYdszdLyIdLpugA4Bd5iNfwRWNvc838TtYv8y
 g6QnVKPWq+7jASgD8luooEAHWmfjLkUbPgaO1ki3DsTtoPYLeGjEdZ5IP7cYoB7kkoBJkY8x2Qp
 yCe3CMU8HakwR3x9hYMTzWxhiJViX/drhMBfwYv6UJUiWfpZVmFofVo8UsSUQPCXwdF4UzUR/bM
 +46CWHv/j31z7slUjKmwqOerg6lsD3oN7OhtEfQre1H1xZl773YZ+OiI0oTcsYHcAwwbhN3h7Jw
 DYkeGxBFQwt6PP9+OOq5BpedEHZjMIqU030J4rHmcNQSdEGadYiOLtAYzjrou7IorFBd0QyGR3t
 7e33901G+g+nxUlBWBw==
X-Proofpoint-ORIG-GUID: BXOtOojSGWGKAWXr_uS4KkzjQ8eTfsHz
X-Authority-Analysis: v=2.4 cv=AZKB2XXG c=1 sm=1 tr=0 ts=6a3b036f cx=c_pps
 a=91TlPzG7kPfjcj/W1M6+cg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=vWJtlv6jBS4BreT72kcA:9
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX/TX+kl+nL4/o
 oVfxBvzR+bDYpBQXnA/6mAr7sLwPbe5+kGJmyX9hijAo+fUsHuDHT833T8XHn4DjB+fR8VB5pav
 lm3dJvhGGINQAP5hxFfSBx7DaWPdXg3Th0HfU2CODdSO6CMdNer4
X-Proofpoint-GUID: BXOtOojSGWGKAWXr_uS4KkzjQ8eTfsHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
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

This series addresses few findings in bootdev code.

Patch 1 fix for automatic boots in case higher-priority bootdevs fail
        to be hunted.

Patch 2 adds unit test for patch 1.

Link v4: https://lore.kernel.org/u-boot/20260623014930.2741494-1-dmukhin@ford.com/
Link to CI: https://github.com/u-boot/u-boot/pull/999

Denis Mukhin (2):
  bootdev: scan boot devices at each priority level
  test: bootdev: scan with a broken high-priority device

 boot/bootdev-uclass.c           |  2 -
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 15 +++++++
 drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 18 ++++++++
 test/boot/bootdev.c             | 23 ++++++-----
 test/boot/bootflow.c            | 47 +++++++++++++++++++++
 test/boot/bootstd_common.h      |  5 ++-
 8 files changed, 170 insertions(+), 15 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

-- 
2.54.0

