Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147D4CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FB18488F;
	Wed,  3 Jun 2026 09:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="O7fgBfu4";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="dkNG+5Fd";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="fRmNMFFj";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Bka4r3dM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FFC848B3; Wed,  3 Jun 2026 09:08:10 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228E8848A2
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536oLd13034333
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=X2Y
 ZVByufouCA1Ixk14J98G8Tkym7ATTWP2HS7ZFcvk=; b=O7fgBfu4ZJLdPJgGvA5
 7gzdzymyV/mvveiwkrEqFXiEmLXox1Qw//7nWYiK44uc5AIuI1xWrrJmd+WPBzcu
 a1y9a1jC4rG/JQb9nRhvrHU51acqhWkGQYFlC92Nl9pfQSj/g0b0gIlr0RseuHwk
 fKhod7ZX7z5TAIkQeA9U3LhBdG1XUDHzyYHCj5dLuZbwCSexwVn0F2wtRuoLLX1f
 3qgJds3lF1/zNuC1xp/0Inrz5pYl079GPVQqpuhOxfX/UjEJaSOQs39qsX4GZIjA
 k7r4dxMJKan+rkSy3ZP2GDwbhYgN2i/SnRCjQa84DRz6pDEYpp/MKD3qlOGokCQS
 D6Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ejfbtg3nk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:08:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxNph8MNV86Ykm5eb1/pmdlsB2w32qHWR+KSxjiznNGT6DCfVyMOO76MF8mm1ZY7/0b5a3PMzx6jLoeZzVnugFtsxplaMJ6F3WTOUSJjWeatozA2r9/0MGewIwX5TxmEkevrCKuOaHIO1AeMNzlOkN+0okbtIvnqP4D3zCxlqyCbiW3jRnxWL51cPqPa2/iftFfPYtCEEF8/ssuKy2yH7R+FsGZws2iEb3BhDzyU2dM8/0AqdiB6OBFhrINwBCbRvgItVjObylZ6bHymDgO3Ku0vipubgRwACOqJ+0Z9zspBcIJZVgESzxu9BBJgLdeK/hr8iJW92XOjkz6+LOuhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2YZVByufouCA1Ixk14J98G8Tkym7ATTWP2HS7ZFcvk=;
 b=uGV/bDhsCnDYwW/peqjmqHlj0g2tx0EKIDr2ADrOUVGmOXz49tGBfJobzq7A6WKukqGA58uEPT9E96mh8x6wy0EulMVzDxKO0sPVaruWRckkUM9o8/6ZsYVi9rYKnrRglAxWdb2hixG0P/1YhUrSYlBbSYw/vncein+sxSbulmlv0gC11v3QT+zp0r1+nqNELMRYhDqQef1Ld0MjWgaDDhUPTnlUYfgUB4YJ3POMlGMfMkaxeWL7harzcrHZvZOjWExUlo0BjBzXnD9Xk2DwBJp61l6T4cikybeR2vpgJlyllVIcvc/XYDom7Cce1zaQnbbKU0mJquvt4Igo+TL3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2YZVByufouCA1Ixk14J98G8Tkym7ATTWP2HS7ZFcvk=;
 b=dkNG+5Fd/8XmHu54OLsNnfOmLzOIec7x58Z1nhqwU3wD87SPtO2/n844txKPE/p0C2xaLyPdlS3OdXlDZuSYrZt1V3HZwiScp+aYprnBDNOv0LRmL84XIN3eW02SwZf8nfuELpKY8fkNkdsFVfUWBAfJe39/GFXVqrKjMclbEi4=
Received: from DS1PR05CA0007.namprd05.prod.outlook.com (2603:10b6:8:457::17)
 by CO6PR16MB4307.namprd16.prod.outlook.com (2603:10b6:303:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:08:02 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::53) by DS1PR05CA0007.outlook.office365.com
 (2603:10b6:8:457::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:08:02 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6532Y2eN1071542
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=X2YZVByufouCA1Ixk14J98G8Tkym7ATTWP2HS7ZFcvk=; b=
 fRmNMFFjBt+2u+ydRoWYyEIR3zk24gkKh7zbVmDczlVKNCj64J/dsdJThptMqD54
 SjInyl0WdEcnZTk9q8KxKAN28IqoyTJDkNDpH1ZCFpqqKN8o+HoO7JYVThV70fYf
 npOORWrIhQuLc5JPYJmwO9/e8neohBwOLzyjaWbdKs9QLQUPud7J8L8o8/xUg9fI
 L9nSbn8lYJBHEpx7VtnEjKEVHN0GMnlwvQTdLlfvvUOeGJmKBOP2oDQyEKh3R/pk
 HxYSAxxhZHACkynZzb1/WvKXqJmbb6W9kHLfB6IFpKohmpZsYUGMLbFs86Snd1aJ
 KIzaRbg/nTZ8sDEqP8tFeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=X2YZVBy
 ufouCA1Ixk14J98G8Tkym7ATTWP2HS7ZFcvk=; b=Bka4r3dM054XH5da9sYt0ru
 aD9CmAGwRTIbDEwxHTCZMvptGvXlTC+KEVj2TYijPJD+T2CslOaD5uZM35/Jy08H
 Mem55cdhiMXyYps4DVLm6sJmTgfcmJldJvkWTKcY8SK3d3d1QUlhkCHp6RpkkCMo
 c76Gn0o1Zy4Q66CoGO9ws3NSuW6SwDQxkLd/HHyb19NG/9VEDQaUlIxk2mLQ8Ft0
 qCsdJ1ah3P336enOYFwPtEUwy9+Q3NcRwu68Du4Wm7o3NkKkpXLs4r8GgAxFjDJ8
 V+JZW0B4oEV/uVjWD1fC26e99hYLDOLQHji0BehNTtiofOnyYTfVaGrHWQ6CLJw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd4kn5-4
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:08:01 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id UfhowfYFofWWnUfhowzyOv; Wed, 03 Jun 2026 07:08:01 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UfhowfYFofWWnUfhowzyOv
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 7/7] tests: reset: add cold/warm reset types
Date: Wed,  3 Jun 2026 00:07:43 -0700
Message-ID: <20260603070743.1268544-8-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CO6PR16MB4307:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8118200-e50c-48dd-18d3-08dec13ed9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tXcY/78wlvia9+aeifeu1i5K0euhIQDO9wvQzyJvRoTx2gHOM9ufXsbfmiD8GwmOl2xEQnx8N4gPBMaLfRUW/u6ITtuF3QY4Bqpu8fce1UQLJT/dZSf8iuocjlihBuTJqN2+levJcAsUk38pSrkWLPPjrhyVcnWJyJrDBm+JDzZlxYAqvzf70N60gTPlLWo6tuO0WW5Khps5WyJESi3AatSSKRjxnJV4helQJKp1bAx9wFyCtF54lvzw0/tR4sgAyG7xZ2F571TLqedBuKBjM8b4Bn4xsHdTW+wlCsFY6DijX33I6Oa0c1VgaVF3170c0O2671ORNb6Hd26DLYgzL0MgWT1ByAUeKWJvB43/xO3XjkD9UfP3KFz3RrrmVaqX4MoYiL10E9Ar9XE/SMIMnhnPK9mgIuAsvvWcFSv0bPUxtaY/KREISYv2OWrNTJF3KyGmkafnXXGTmgutZn43S7YfGt+6Ww1owk2psT2c2cntfVDzrl3ccmCaiI5f7QU4vZhSvPCeH5Xw7Y9YXgmhacJppSW8LsUrM4+P+Uwxincp3nTZ+i+SD3ePMT/5nLGW6TMGdxQoDIWRuINT7FZiii//wz+sqUqRGE9ufwR9cpqwKrQhc8tS09tLKto0pKT7JdVJU72x9q/fbDlakVyMrhOjfsk8VGCfTGG91bJZct1mteKMID+sZDU3meLly8Swghv04l2oK9NnKpRXS1tmdAvQ0SIUMG3SmrS4+tpdQHo=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mnwz68iVPHp7xfLS0um7+sOnCN2rvuwXHXrMlsixr60Ga1V655ohh+lwfBC5/oUSJYErvI958zU4IrBmyCcm5Ja04+wMgBz23yxt2HpLCTULWPs0oFSrSCykGq+3q8sdUpamoJI24TzxM/x/3hd3bFQX6BiwLmy8q11wgOi3o3bxSDCLQWttbAKxOuc4J5OjsMN6P4qGvu7k9FGLMw8Js3PXn3myPxaAo8QehzvS/GLF7arMmy1d1HjO3ERnNQjn8ay7s/meb4odY/H0OuYag4Mn7PufoDM53OGM0IiOaQmGVKWscnHc/QXszbFgUPpqVdsq2QHMP93jFjJ29jicfNZe0yU3TETWG0oU+1bGYeEuC/Jib8WeIfXj03p98CtDKAdiXLtBGJIK3ptTTdqearlRTnydplGzHyakh8W35fJw0mHj6VEaF+kHSXr053G2
X-Exchange-RoutingPolicyChecked: Wv+YMGSRhC/HnhinSJFp6DnuCGg42IPShqBsIyhOsOrbibTH82YPKIm5dZkW0+1s4EhqOk6dCrIg4odmQ8AwiWu5Uxg+WfF0JbPSvK9KyKS9nIFJuc7IivnkA8CCMa1ehOHOwdgerNtA7yQTE5117fum5MvPq0RY5hisBP4ZBOebWHol/1Fiew8ilxkM6n2uGoR9+GA06T6xY9pDq9vb1QQc8FFFUDpNI+pbdDLAPbdETga6zb2VflvLX4pr532UWZrP9W8+O95ZxItD6A8dblna6DY+9IlEcj8Leu1S+9oK9TSgTZrlWvdAqLA2bH+utFj19viz3HwIC0UqAliasg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O4sn1iEChFnw7jY6Rb4dQD8QHqrXaJ7wInE87z4XeuUw3Mykii/uUef8TvV7H9sA0CEjUWy/4zBFUBXCHgjooZ538Q6jxF/TXI9WIdYkvroLejM15/wgwKXmrDA2Bfuzk+w9i4X/I85Spd8jT+G5fiSI7RMOYXgQjKrhtEaJtBxnMXrgwcXY4Wu3a7gMgK/0AbFWSYFkYD5WxbSn4I5ZxwuTCUr0mzFf9+jQamqOEbFON2Xiok9pPcxHQPxSPR2d/ZOvxCtTN0rA0vczpRSGMPHAda5tqOfWbhHMLuFSag0o1eew4k5E+oNz0D4zzyNxDdQqZJpxytptnqNuUfav9Sgrjse2dzIHJyE1K/Ersw+fAZHfW/6i4aTnjy4Defp3E1PuXSxLjez/ps/5Dqab4GtL0avmrXZDsfDKGokvqbk+/alTGW848p9aUkn9BsW3KGBj1iac/6Rv4B00JXR0kkUdRuNNKVx5eKNaxRAh4Pf9uMy68XhNemuIJ3WrFMVcpa2KIQSA6gOdFUojgkYm213Y6vv5ahxCL7Rxs/MIGKRf3TTfkClJ7lSfjj4JVDxXMV/AM+KnmqN1KAdV18heOlR54GNxwuDCvjbubqTAyMobCgD+G0P9tC58e/fSqTka
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:08:02.1010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8118200-e50c-48dd-18d3-08dec13ed9ff
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4307
X-Authority-Analysis: v=2.4 cv=X9Vi7mTe c=1 sm=1 tr=0 ts=6a1fd2d6 cx=c_pps
 a=4HEXQ/P5pkaUFkQJdDnQHg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=ylyPRLGYKbN36ShVx3YA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: kwqPCjr-LZFmLrvLudFRu5xgGF6iwrot
X-Proofpoint-ORIG-GUID: kwqPCjr-LZFmLrvLudFRu5xgGF6iwrot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NyBTYWx0ZWRfX8Mhf2gVWVw7V
 mQtq8hEqECv9hKN0LrWYcauJD5OXHoM7z8q5HRandJLLXpYPepzCEehUW2+JcnRZIcjjjL5rJjp
 Hn3X978U/dFkdbuZkpDDpriuKQFBin3zC9L09I//L0mvn5+ojszKExlavqh8hAvzP2VR6Y+kcey
 xXPN7+zQpSm/QRbPd7dhrFXY36Behh9+j+E7PcoXjxT119ZI2LQErkg2QFu6BV0P7BANr7BmBEn
 Rb4WtXyLhUho3sveAGW5/gfS3+bodMutQ91T5uwOpzT/vUFYlbXMEG37uyTUDgWp+cjgxmIa6/q
 KLdpzJYpdnZv22kKHwhFZQpZ15/TljQDlKEb3GWCf4Z2y3zCEuMBuSfpi0z8ZGx2SaLPC1M7mzw
 04gV4VLPQ/fthSyA7KVkrxJvEm4xVFjc/U8LZXlLbMuQii/5983wxx3GlGrQzs/JV0hlWgZ96k4
 kd8l1X/zXpBdDhYnX6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030067
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

Extend reset tests to cover both -c/-w 'reset' command flags.
Make sure sandbox reset tests are passing.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- switch to ' strings in the pytest
---
 test/py/tests/test_reset.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
index af079a706647..7a12fe5f73c3 100644
--- a/test/py/tests/test_reset.py
+++ b/test/py/tests/test_reset.py
@@ -52,12 +52,12 @@ def test_reset(ubman):
     test_000_version.test_version(ubman)
 
 @pytest.mark.buildconfigspec('hush_parser')
-def test_reset_w(ubman):
-    """Test the reset -w command in non-JTAG bootmode.
-    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+@pytest.mark.parametrize('reset_type', ['c', 'w'])
+def test_reset_type(ubman, reset_type):
+    """Test the reset {-c|-w} command in non-JTAG bootmode.
     """
     setup_reset_env(ubman)
-    ubman.run_command('reset -w', wait_for_reboot=True)
+    ubman.run_command('reset -' + reset_type, wait_for_reboot=True)
 
     # Checks the u-boot command prompt's functionality after reset
     test_000_version.test_version(ubman)
-- 
2.54.0

