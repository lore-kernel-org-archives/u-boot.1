Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF17CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 06:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67038848D7;
	Tue, 16 Jun 2026 08:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="lEhHpj0P";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="bBtM+STg";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="ZDADdOh+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="G90lYIDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A573848D1; Tue, 16 Jun 2026 08:36:24 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0622A84895
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65G64XZA1220962
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:36:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=jT+
 wg1E9UOH9ag9KJgpCqTiJAdjqsyAG0sR04ecxjD8=; b=lEhHpj0Pvs6SyNtNcvo
 YPN+7j8j6sjkDG2JpLcyxqprhbqFGSdPqlSyoXH3nRothV60RENmI5ZmIW8wJRe7
 3L9cnmZhWMWdcoaAdn+MKLbii90rPCprYH6hmr8uoJ12zMNaaGcNe10ai6RRwRRT
 8RJmjRGiV7S3xxMLUFA1CX/7x+Ul8/h8OvftFlKOT6sLCMfpdZtsLD3DRwf3xx+8
 Hu+yJYfTE8cLheAJXUWfyEMSzhpdt7PGwAStZ2convnXzG5tOkkv89B5rN4xuNr4
 kdMiaSZh6JA87SkUXnqh7NiDvsStGoNDbbQAsrhLLyTh2xn+G6Mo01c7C6H0xKyC
 jHg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by m0482517.ppops.net (PPS) with ESMTPS id 4etwu816hm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIVfSvJG+1E0Rbk3QuJz406PWxFwAOqN4uZwdnkXKC2MharPNnG42sH24EKy7k7h2fOzlB532Igo6qiM4yZZkfDkCAjKiK0+FNVyPNlu9PPL6VmyfoF/Hp6ujvUadXqPTCl5ntU3WByY7xe5erIRIlhQnz+3kq9vaA9b2vaWNLHsk2cUbiepWPLYTqXKzUk2KwXJ9YFZhJnkuu9bKSOZcmQm11xuW31IjT2HgGbL3jQ5MITHW/ZefCSLUxp6omYO5l0KYi7vF6rt3BvP+gV9lGy+2uJNuIiae1rk7AvNxykQHOWIAPNVudU/jvhlpHteZZ98p9eJSCJ+avOrc6SecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT+wg1E9UOH9ag9KJgpCqTiJAdjqsyAG0sR04ecxjD8=;
 b=t7tfRaaz8XYPyTwBtrlziuQ3W+xQnthxzy4BmfZ1Yv9IR6RjPOS2IsrJWko/h0OotaA9vG/s1rxsFlTqkubYmAYowSKO5H4uSJRYgC1GGX4De3AdRjqdOmDfqPVr84VZ2jcJ/GchmvgYwZuHyfHwWWZvFd1KpdrLKseNQdW/05MY+2X+1oAQ02sQjiAAFBhZg61jAFw1LwtYnAsPqSHXH0gjPSynji//2KFEjL38T5nQ8hM94pttCxktdyDPpyNCggT2vCkdM5ixn79a6ZaficqFVtYhTZSlQO8f9WxS32RKqceYZHAQt/exdIGca44gkDL2mzJaKP7/zwStO/744A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT+wg1E9UOH9ag9KJgpCqTiJAdjqsyAG0sR04ecxjD8=;
 b=bBtM+STgJfwdZ5cYGsHwbN/I18TU1dwh0ze0igJPZRTMLCwQsQZryWtKRTwDpnmtSOqB9ZMT0QSWbNukIXh1pYulb4E1R6jCC6cWRT1i844W4EiDHwCM1ymXfNEXaECSa9mjkJKKnBV87Hk3P5U04VAhr4nh7NqnKzIDWMB3LHM=
Received: from SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15)
 by EA2PR16MB6277.namprd16.prod.outlook.com (2603:10b6:303:25d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:36:16 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::5d) by SJ0PR13CA0130.outlook.office365.com
 (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 06:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 06:36:15 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G67pRm2645556
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=jT+wg1E9UOH9ag9KJgpCqTiJAdjqsyAG0sR04ecxjD8=; b=
 ZDADdOh+ZkHQub0eKkX+3fpq7p6HRufSR0T4Hro2eMTfUFDP7ACnt4lkn6B6z8tp
 pDMGmjx6orcDLD4Z15WAZLD6j7cP0In2SZLUl48eTLU5hhTEWXZzJvVsqs4onQb+
 NEelRYUDYfPGiEfRUp/cHr4t48LnJSsLRuLLRr39Vfpb7YCEI8Esp2nE6/dTKqGZ
 1hCitlvW9pD4I+DnAnFoQKvuEmBG66y6k/GxgU+0sWhJz09L6zHSBV0MvSgJjp99
 k7p+Sf/dXmQrwkjlm9KD9fs1acwUE2sduRi24wZaw2Gmud0vjymMGF+WPyP/W/SX
 a/TXP76dr67pHsFqDz1r4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=jT+wg1E
 9UOH9ag9KJgpCqTiJAdjqsyAG0sR04ecxjD8=; b=G90lYIDpEFLrM3TQDxKsP5r
 ICjQPLd+x/8NzLVgxTEzx8IPLVRH7gCWxkTzfLLtA+cLZIo7rs0W74rIOx97sAOR
 vv9GcC6624JkCa5l+y1ynN+rcvGZzCmquS+k4i5coain0iR03BUXZAcaF3ch7fLi
 wIYb0Y1w+RCPd1KPuehBDv1z+gHTAH2kJ1m4n9oLFul+51qdiczMemuuwVo7fF3e
 /T3mApvW6cVrpa1DUlA4NXnLa4PEgrKDLi61H61wcmJZWD0P6yxUGoW4MPAuXUrQ
 dx8JJIbQ91THogsRbrCHh2IjpQ/ddYhmOpb0NLX/tnd8a2uNzAc3rl8rjvy+l3A=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4esp9r2qyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:15 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id ZNPBwY1IKKoqdZNPCwuDTp; Tue, 16 Jun 2026 06:36:15 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ZNPBwY1IKKoqdZNPCwuDTp
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 2/3] bootdev: scan boot devices at each priority level
Date: Mon, 15 Jun 2026 23:36:05 -0700
Message-ID: <20260616063606.825688-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616063606.825688-1-dmukhin@ford.com>
References: <20260616063606.825688-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160063
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|EA2PR16MB6277:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2c8edbac-03d3-4744-dc51-08decb719128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rY+FH2U28Jk7i9msEgMmBHir1T8QKEcVocwey8/1H2tqbqUVauzM87IQ3S9csmrLOWcHaXpy4hwfmeufW8Un7zXJmxfQU38iNEFVjlUB3/EN8iW5QrbPmthZ8l3v+movVxoJLGNUXkKqxaFRn+xECDfbZg5I8WJFfiX5U7gmhmq7rmp7qOUZN+LJ+n4YfnnsZgvY2Vyp1wU4aOLmhB8lXDQDZwqcukFgwyWu3lB61YfM4Zs1Ac7B4DeW7if6HwOw1/lKmmr5jm+FY4Vo6uRJywALSxFYPqDSVUQKx8IuSzwjpJr+pooaaseFCMm31hnwaLNvDs3HGDXsblbjPD07AD8NRsApzTQiLHS+3EIrYoHEUPAskigJ57Zuq8JiEryD6viIV9MPDhRA/Gl+59xpdQhl7UlJwtXttKOfaNy3ezq72HqP+TX1NhCDRaTLlSAEmBRRfCiuSe2BdRgEpJDjauczzijuSXdkRHadKmqLtS0YnNZpNlFHVUBfS5XtcNH6sOn1BjCPZ6NI07DjLKOMNh+eDkqw++C3MSZLHtZfU6C/FsR+PBw2Sg+e8xttLTAx5V3suCgadrNkFVViqCDOIhxvjCZYqFPJAVNqCYQziw5asKiWBqpE2YmdAg9aiZ6Bxgn2YqaUYyyb7h/6teyaNR6WZJD1Zfgk+wy0LjsaYT+0OPmUEO0rMwAiRwgvvMJAZT8ekXj8KzAokcFl2KzN+ThvW1T6+QQL6NdIBfE5VwM=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /bWOMTn8YFByTCTUtcn0wa39cdwG2odFxuDCfqJTPoUp51j4aCdYIvXfi5zECq0ocSoE82+7eR0oMaip0uVSc5ajxMbUHMdBK+PCN283SXbMRZwplEmYsE7gEGwH95K61S2klv+AJvmYtCHkF9SrvkDGUjezYB0OpMdYehAfxMdjQCJgyF9yJcVDq6Y/0r4/KsK9FxOd0MdEpLI+eKcFMtwvCKroPjQuvBHFKzeVzo5Me34O865kvXON5Bx0Ydyi6Fmxne+5re08Ce82liT3TcJNaq+GDXJMGTmColVfUVboQ3t9+7+XKxUCeVutCEAgxbWb+50EMMFwo8uLxK1GeuSUxC0miXyGwhoFOS9KvvnLPzL8jv05OQH6NqTvbEvXGPCXsBje25N0rmFT7gDd3b9r/Dev3BA5RdhmiB2nhFj2Nt7Tje3G3pQiXCcByRlS
X-Exchange-RoutingPolicyChecked: lONg+aqnpJba4bdwE9nG3KFkxilEi+JHUe91/FCvnBrQPVngO88vBOLwcH99DCxAUHN7TgW5Le/F5My3C9dBFRBeXbFolBxWsA10Eo7Sl/9rd/Gn89xpXFmpjZg1eLbdrVOOvwvcFjxjN/Uo6ICb8NXp//LdqzfNtqHyig/xYejiuhNCEZxb2pbopPpicoHrxD6CpMr5iHVmmZz8oLiMm/PuPFtOzHtse0V2LwJumNpW3c19+RalndUFVtCBlhGFwXbvrzbdvqMvNMdsUL4YP5BAPgdfRM3SELU7MaY1CSmxYpgrOgPL9YICwDz1gl5LXhpUlldNOLAag5/8+2hnkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 38mdebnzrnU+m4JJngP+R06abZ/woz0t4sztyrRQGg6dcq/vVCOi8E7MuxtvpQMA8If/0pU37KfnZQnpKWMmRnINWmfo3aPGnlQ4SuvDJY8Q16NfPmSkS2r2xTbgNYQzRJ58cGqA/+Rk2Y6elGyH7E5WXiD/iZBP2L5oZopzkUlLO7InoVCTZ1ITiplEZ3kowlpqOD74wufj1NByXZoAEI+vIajvnIt7CGFzVtnWzKw4jIQEZLmYIaGNCGFFzOAGRsNlnafIwikn4rgT5B7rzHiB9vvAcdtbSb6eK2yp6Q6/6rFCRoT0CnaHwQUr1qiVYagqd3+fvUG5Kv2i+48XjCpxF+B+xa1/O6PMcja0oRps3Dra7WOFEgOg3kiVljt0QfPKOYS/d6UVs95YcGj9YqM8K9ewHL42y6dLQdQLUnbQZ1EH2Kefw3C3lHaggogb1jGkq0VaM0Xu0uLOnPs+1H2uwPEcvwFxpWbQUCnpGIPYfU6MlJFrlr6uozk1Qgzo4u078eQLgdBv9sA1usA3UYnR29dvpJkdGY5pXulz8yf4jFIvXig0MgFrPtzaiSr1HpI9ZSg1RG3+jZWqqAl7fKdcxqcrRFMru5gv1UXXyzRHRVlX+MPqmTirAEvHkjONO0fubWKoD4MYdOUrLK/w8w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:36:15.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8edbac-03d3-4744-dc51-08decb719128
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB6277
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfXxzlMt9/TMrhZ
 TraiQprTYQi6HS6wEFifO05yLA1GrLm0D8XJXiA5XGnY57/iiBUY6MLhfhDDZDsA4P2RB0mN3tS
 Oirb28zC9qmGRcvObbDJqE6tNguK7nzrmxd7YvEOLll7a1HY0gj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfX4vWPO9HDSjY8
 gn8QPUcbmKg5Gp4gOg22+1W6Sd7Ytp5ulCILX+oqnKW1sJUZeFJUG/BhueXhO2l9WVJCkjvRx6N
 mDq0w0DLKmK8aqz0Bn4Dn0GR9VhgCB7BY0tdoVHVOgU3XK4nTrgBbUC1dZMn1jPEeewjYgGkWK6
 t6zaZBY6mmRwkd9cWBWOS8O5PivLJGjbj7+ZZa3ver1UWdLr4lsIJ2DnbzHLNmciU/t/wBOJ4RI
 bBUtYYZuDDPinNkyTIKv8rCwl2OXR/0BcGHFJEN0T7H4tU7mqpK14g9SO+T960pBAlUFkCoIkeC
 SADJz9LmxF6CysOb99feZbeLdda3xNyTEO8mrlhtOx5RXmAYkFY5DOp3rTt9t901m4yQfcG31D+
 CW3qFlZW3izoeJ7i6UdOyGqdoWQTBlLCffmVi++YFmwkZQeUj8c2TmDYJEjgEWScOhHl0LYBAaL
 XIU16UTh3MGDjUQMSVA==
X-Proofpoint-GUID: -tqwU-3HWNOLs4EN798wwlrorLksEi1h
X-Proofpoint-ORIG-GUID: -tqwU-3HWNOLs4EN798wwlrorLksEi1h
X-Authority-Analysis: v=2.4 cv=Mc5cfZ/f c=1 sm=1 tr=0 ts=6a30eee4 cx=c_pps
 a=NvljgnbIoj+kJW4KAcm4xw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=cbNQJ9GKAAAA:8
 a=WioVj99LH3wGi_Uw6w4A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160063
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

Currently, default 'bootflow scan -lb' will stop booting the board if
any of higher-priority bootdevs fail to be hunted even if there are
bootdevs of lower priority.

For example, if the board has both NVMe (priority 4) and USB MSD devices
(priority 5), and if NVMe bootdev hunt fails (in the event of a bad NVMe
firmware update), USB (which may be a recovery bootdev) is never hunted
automatically, leaving the board at the U-Boot prompt (user intervention
is needed, e.g. something like 'bootflow scan usb' to hunt USB).

Fix bootdev_next_prio() to scan bootdevs at the lower priority level by
not exiting the scan loop early.

Keep the existing logging verbosity unchanged and rely on the failing
subsystem to provide a suitable diagnostic message.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- corrected the commit message
---
 boot/bootdev-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3f8dc2c3c4e6..73c3f050c225 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -664,8 +664,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 							BOOTFLOWIF_SHOW);
 				log_debug("- bootdev_hunt_prio() ret %d\n",
 					  ret);
-				if (ret)
-					return log_msg_ret("hun", ret);
 			}
 		} else {
 			ret = device_probe(dev);
-- 
2.54.0

