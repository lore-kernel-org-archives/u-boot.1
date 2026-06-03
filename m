Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD12CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECBD84878;
	Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="ltnT4s2b";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="UMm3AdhH";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="EYe3Gxxz";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="tevjTgt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097DA8469D; Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685668341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6533RpGw2022247
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=XUL
 JHWUSTMqApltNreLI2nM2r1r8BTCHotrK1dVVdbI=; b=ltnT4s2b0R4SA3SK0MM
 zgEDa37VHAJiDE30ZJR9lUngNC7jjvwHzvQlslagaHt8lJRWd7l8eyZ7kzGkyAZh
 g/5JY2BsHLBc5m3Sxx2el5p5M58COUa9y2iASFzaP7kTUdbiuMXQ9fO0Y10PE6Yk
 QKGmegq1caOAx8hprIHaPFrG27jUju6gDDSrTtFFG3EFsv8m12gvoFltfN5PWrMX
 pRPtgBFpoqT5LgQ7zGQXpkJPs6HkflruMauWTHzKUBTUoa+5XsjQj8nRyI2ibHT/
 moQKLohs6I6sEAXcMvCj1vP+YvLtDhqB8wMW7laH8CKSkrEYLjyUQhh/XeTzZG8A
 h0w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ejccvs0n1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:07:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmmBjV1iEOvhcNNbK3VMWehssIoiPDID1MBnAL7U34qVrGa4DxUFXFZ+3lPxVdcnnofpZtQpC0irSQl8C4R6DA/my88GnIiWE9zjEqAmZ1gEDnwKogINVp3YuzG3jLAlT31RYG6v/MRPhi0GBwc+dnfO8hqJs+6P5+T8lqiWSPf9yu4GlVGi27Zuya/8c1bOCl5if+MUhWH8SK5CTVo0wwrwYvOeaY8p0WQGkWpQ4/LOrNggUDTFzBnY7uRKl0wCiItwypTLQECJT7bglVPFYDP42Gk+KuTG+55JT0StZCy7nZeD/SgshPOrO16wgns2Xm5u9yPL5DIEQx7fKeiv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XULJHWUSTMqApltNreLI2nM2r1r8BTCHotrK1dVVdbI=;
 b=tJU99CFR4yMs4sTPNLbtgE4XYVlvXEuaUues3FRg2T2W7qTE1qf3Wxqbk+ODpLOFZkR/JI6k48u8yOcEdlHJedHGcXH7RUes+P2h4hpScTGu7PMkPYIkAPluM5DuZYYAjGRJvBu7GLvutdUZpAB1674gjI+onYD9dTii/rWmQUMA0XH0uqQXjSZzSZVCh9Zor70ygP0LWPF7meyMSMbLBKtD7eW40RhI/BId86ruzVEuqb4M8hamNcsN/BowCPT4GQK0LzpuWq62qv+5Qh+Mxd03hPdiq0xvurNUcF7OHvRbsK9piE5tQ74+SmR9P8Q0s+/uJhpiEJ0zgY8lyoOLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XULJHWUSTMqApltNreLI2nM2r1r8BTCHotrK1dVVdbI=;
 b=UMm3AdhHBgGftJIqLSq8hLqmUjs/0q6dBBzN9Cmte8xwZnb0Ry1pH11HC6S45w07wSnsCXus+TLjyVmnQlij4/EJ5RfbnlmnYDZHr6/3g5QKEKxaAHJiyNJ0Mo0qZjon+0o1Tynd2LIvEYGZ1ahI1wNPA79NSVDeI2+a383sTx8=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by LV3PR16MB5979.namprd16.prod.outlook.com (2603:10b6:408:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:07:53 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::4b) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:53 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536Gqj73759767
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=XULJHWUSTMqApltNreLI2nM2r1r8BTCHotrK1dVVdbI=; b=
 EYe3GxxzeSsr4H+imq9MuydGMXsuVBP1lXDHw9l2bvpmFoVSTdUIB1Qu8S/d0oGa
 iyaOlixpHNozBXOnlePOu2u34HKU21DXTO+rovFn50bIfbCbZlkkLx630sTac6aV
 M1LjhtsapTZR1uUjRLxF76A22M2yJ2ifLHkUoWZG4x9b+fvb30K2oTGeewER3uWc
 Lgwdhb4cDH92SY4UWGtplGEYV5CWgB8UEB/hVY4hb9xsrwKwIZXvK0e9qn+JK0ig
 0U5cn9NvQVMcch03mue+hl43B2Us61AHK/L+vOcstyf0LdQTAHTHxTct3BJuOczi
 doR8m5QTg8s6EcvIcYLrTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=XULJHWU
 STMqApltNreLI2nM2r1r8BTCHotrK1dVVdbI=; b=tevjTgt2KvIx0qO3nz/jBIj
 BK5U8+1U9FZqezc1NkDuOObacSvTBMDyxM6LJiVWGLDTj2scwtpLn9oqcEVJxAnW
 Wa4XnwTeC34fCekY8KQlKNvmBxAeg9CmdnlizLfaPvl3Ve6bHaTNFUTUlfGvje1l
 I8lAJvbYBYZ+yKmF034jYMoGZxk1/+5T+unD5mBIkMO3ZGFvr8/c9tLlfgmFgPBL
 1WYvo8NEebJr9woAVPQySvYQiYuL0FoV5x8lvLUJCqQS77xgqRqd1iVpzI6sCsGd
 Ez6oD16oOoDaN+EjfU6wqpWYEHWRpLQmwOGVkG97gAmkiCCfPkVV20E5yF654Pw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4egeypmqay-9
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:52 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id Ufhew4fIk8Hc9Ufhfw4EDv; Wed, 03 Jun 2026 07:07:51 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: Ufhew4fIk8Hc9Ufhfw4EDv
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 2/7] reset: Add explicit cold reset support
Date: Wed,  3 Jun 2026 00:07:38 -0700
Message-ID: <20260603070743.1268544-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV3PR16MB5979:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1a50921-9855-4d85-bfab-08dec13ed4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: hgL5o8VVZTQFmBIIIMcX9bsY+N76fsKdxD+TsOQPMNsyzStvr40Sj3VypjU/dikYnY/T0gl6VY5wG/W0uvwNbMxPHH39lWwgYfD8tqD21OhNxrfXyzVeYaM7/0ZHjXcoDnvtbWnkwOpqHu64n3z9mTo8fzDP2wADYXKlUJfYGN/0793L4XOTf97awhvMw0ZfZ7hbarjZew+kIu6Rs+umwzFlXbpE373Bv46es+r++seo+SURz22ZuDbEqvBSnLf7klP1yX5ImzYDT18nznzKWKpLujYMvkDwITrPsgPkW7ELUmEO4ssz0Hcpo84qoEwfAMWDORD7DHznnQy8aDwPAE8Y/Ogy6xKDKDTncQlzKROdcjlRUomxgRN3bKWPdv+vKCNEsdVqgQncitZVDTcy/OnWMY17HYz+KeBq4HoTDz0riennET8KpeUB8SPr5vvzpulIlsiOQTZ8IZX3i3D7zgFGkpmvADFoJLwcyAu5iWfRswlslkq/dRwTZOGqSGlvoEFYgqq4VWAurQLBD7zzIKX4N+Uwd1mehoN5f9U2XSarXWDnEQ29RzJAA+/dxGZnwR9TVpeH1Mtx67ENfkQ1KrtcNg+slgdccNmgcZRlXpTFt2oGBrlGWs7bwq+dBEPm0pB7oyMMflTnwkYGEDl7TK2c4+ciOVWjpV0iSMO2Ax4GuKYc8NL9cfelS7aeLuDIzeN3R83w9H4Go6Q4ObKLcSQiM/WRTx7RQjgD4mAvjXI=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 12RTLCUSnc7RyD3/+tdJg10qVWiDteaEhGv3XB7/6i7wZ953izIx0jjJZp03xnK1Ueny7LRTmarXfpiZFkSSeHqK8Nzz2GS10aEx0zQN6e9IdFotmkvawfgQ+oDlFkVPLrisyiliNIOXta8m3YBtYrkmEHmE8CoCS8+jQPuUzOtO7OEn4qTSewcHCBvQcLzUjcoqd0J+SDGqYzmqXqt6qoyTVf88w/krLbiRFbyKivH5uCfvNZ9+Oe7jb/U83l5mIvHyQbYfUvA3E2xtDB5r+b6KN3uBIiYwRlmW0QF/Z50DmHonbJ0I0b6ADsE3IUYgFsFHyupzTPI2vorscjavMB2lyZHkjiwjus8g63jGeeDBha+Q8YgVF92qWQ1pogVPaD/SNywjXZ0YG+ICEjoT4ZJCzNGfn0sz+KWs+/B9RbEHQSwd39camlMoag+OXD3v
X-Exchange-RoutingPolicyChecked: TC/KhxZAyCWMsvZRFN2UDoT5FWwQGQMjVcyQE+r6S0wmgce8dRBveyyTcssJIVuDUPE/o4v6dDUYxIIwDN+Xfe1g5cp2XJfrbA/MHes2V4CwrwbSQLz+yoHUVXeNj+TctJsjE0bSSZfdMmW5j/6X+XwT1AE/vsSsGnvBK3ajPt5wuXMLmcelSbWZyanMTP4JWOOGvLdwXLo/USlpHSMLy7jFoBb68MKqsqAP/uxZYg23V8oa4sVMYv4cMgqy+2fs2AW5eH+j1USAuFf/WtN3WFXDPrQ4b6eP6uWG8QuKGijue9FRW4C29oX96ZFSZBUkd/nAxRswFTdGKtT2S22WhQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9eslJGTfYsDFiznfxFsYOm3lfIFlIU6Ji4vaRpv/E7I25pKwjv7FOy+JKBnYNtbl1QQ0fqo4kB2/TAfrRAPNsRAK3yb4aixHOTjuQ8FFNl4zPpHVlrvdVA1ooikY4wqOkmO1OeIA6w0NF9mVIsQmmhaj/1g4VA/NpKantyGUqehcS0HodoDjxrlzx+3ZL04kjUEx06aFgPntCbLvRYjJdA6dbF0uKvqL8mTNyOVYliB0wAwFPn4WIfJ2Lp6dubDRQO977SyTmbxg5SBUKYcIsL5SwrXh4vnOS+u6II9t0dT4yY1552DV4qifbIz61xMeNCwHi7J27krQrAxgGL5rak+eJ5Tg22aMVwcJalSnV/XfVzhX3QXIVf25Mj78Rja7UeI+3qr7v8+xIg922QVSnpQF4Oa92fSC0eKIG4sgyzwp2x/A1jgoHsB0L/1nEPqomAZPlfixdQKUDKCybDARrIPXv0OqncC/jHBb/rL0O3L5bfKQmRM4EhkoJb0sZnT+kZkBP5HVmr45/sXEjmqokmtw4uPaoQUVr7KV5TCqLExW5JxyDFrR2MzlilKIXd75+WQCySddjqeYxIvRy/8mQ2zdQ0DnJFp+Cly6vHyhoKIhbyc5BZw69SHEmB44SkKo
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:53.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a50921-9855-4d85-bfab-08dec13ed4aa
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB5979
X-Proofpoint-GUID: x-b-I95wJdjDo6cbLv0q7J89fApsoBgI
X-Authority-Analysis: v=2.4 cv=NaTWEWD4 c=1 sm=1 tr=0 ts=6a1fd2cc cx=c_pps
 a=JPuSXJPnATmcGobPKBfcew==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cbNQJ9GKAAAA:8
 a=RPcLDelSkFZS0uLvm74A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: x-b-I95wJdjDo6cbLv0q7J89fApsoBgI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfXz3WiDv+0xfcD
 hKlNTiQJFT/3Zy2IXL/cnXmnWAY2glbX3JcrK3xWhUCvb4YAEgZ6CIow8efnz9Bw8slnVfCFH6Y
 wrpLMkmhKowkYWjvF2AaKZzg1UA7zfUpd0hPC3sUkdN/P91i8NFBatONJqVSR5d+la9GCMAGPys
 FVeiAwBIyHn+KIo1og4fgxeXVozt+IQ5pvzUact8WUarJlGRgtxyvROIrKfrYBbXFkIABUZt7SZ
 gc6YDwTfhPw+IuVAYuXGx+SnqmqP7P0S5X/sCpujW3hv9g6UB6RVGbg++F+dpKnnZJVylVUMx+J
 mi55C7TAWN9ZOUyqQ4TZMnZ+TepFt5bxPmNNEFWSDP5X1+Rc7aJmUQsSNpZLQhMObd0rb9qSxFJ
 ope0pm0ASJfZ+d3r4Q2732MUpHo+MRir2fMKxYgg+mgp7oWQ4HFnZ9JWT3e+h4PWAdBJurEFOnb
 4h3xlepMFflPx0eHRZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066
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

Some prototype boards default to a non-cold reset type, e.g. warm reset.

Add 'reset -c' so users can explicitly request a cold reset when needed.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- preserved existing behavior for 'reset -edl' handling
- corrected commit message formatting
---
 cmd/boot.c                         |  3 ++-
 drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 29cdf4a9a81a..5cac6cf3fed0 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -59,13 +59,14 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
-	"- cold boot without level specifier\n"
+	"- reset using the configured default type\n"
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
 // All options handled by sysreset drivers via their sysreset_ops.request_arg callback
 #ifdef CONFIG_SYSRESET_QCOM_PSCI
 	"reset -edl - Boot to Emergency DownLoad mode\n"
 #endif
 #endif
+	"reset -c - cold reset if implemented\n"
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 5c6dd7cc1c55..1ba698b37285 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -168,8 +168,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
-		reset_type = SYSRESET_WARM;
+	if (argc == 2 && argv[1][0] == '-' && strlen(argv[1]) == 2) {
+		switch (argv[1][1]) {
+		case 'c':
+			reset_type = SYSRESET_COLD;
+			break;
+		case 'w':
+			reset_type = SYSRESET_WARM;
+			break;
+		default:
+			return CMD_RET_USAGE;
+		}
 	}
 
 	printf("resetting ...\n");
-- 
2.54.0

