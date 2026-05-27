Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51DCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DE0848C1;
	Thu, 28 May 2026 01:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="VAVcBHtY";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="ZERbTPTS";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="KTN9afaa";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ni2V2Lx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59899847C4; Thu, 28 May 2026 01:13:28 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9C0848A1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RKidFI1297258
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=J+V
 iM/aUQ6jh+/Ov7+yx+NtKepQ0GuNOt6gyHP1KBL8=; b=VAVcBHtYe0grzrhZHjt
 J+RHgXraNa5pOm2sPeb14sunMatztE4e5wWyn714AF4Sxx0kw5zULTLHkJx8dUsf
 FVyz1fX5H6Om1BDFtThu1N54+fwv5lYfIsTMWkFejqTt1u6YEnBtKggtnzqmnrTq
 5DCUzm+iyCSP40GslJmBh0n4zMwAlsbZ9bGDmI6D9dPl836NlpBBvTCPTe0vGbcA
 Fg3h7GCgYYgDUXRAZD4UNTKhQlQJf5OdNfAHW8W5THpWSAaBH73pVmvv4MFr9gqg
 eocQIYS9sFbZ6V8hyvIULuSMjbaC3qb1hW8HBMkqEtv7FGrK7UaefZqdMneVQdoL
 7Uw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by m0482515.ppops.net (PPS) with ESMTPS id 4ee7wugup6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqcgAyoCk8cWcK/vLV4pZYTRxSHNQOlmiqmb/C5TcovzKRrYurfHIRIkUv8Vh1pjeHUzYJmLZ6b8jqlwOxdPQ237V6kXVYXZxba9pHltQuYVKZnJSRTRy3YBmASRn61ULl1zf378kONHffupw1rkW9XH1JgUWoEwD7PF4bXo1AB1GOveISWiCKsJUbmryegrXYRGEexZrXC1X4U+am6/t5QSabyE35b+J5kColKK7gwpAWCkS2qP+4tUU+bW54AnUeMc2l7750OT+tDiCWMNW+bgAQQF20xxLerPkm4rw0bsB16sRl1AuVHkWhXufzOpLBnHflmhfmBV+hDvM5G8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ViM/aUQ6jh+/Ov7+yx+NtKepQ0GuNOt6gyHP1KBL8=;
 b=QPvuntWIObC/h6VccZvOYuLfbBl4p3XWxC1Tj6mL6azfv+/fJ20N5ufhlcjGfEepcFZHMtAKlAp4tGlwSFPBqpl5cUCdbwuBwcqJcTN8JrYTU2+ab2siVl1Bb1f8FvohRgG99lTpxrJe8J5pRtGzlN8pdD2waY8Dwhm99c8FzfBGh3M2fTBvvY5l5ud30QFUVr9btlZPGMe6xVQ01MJhO2AgJubhosEkmZSsaI+pav0kaEzbQ1vEDJn/p2b+6fEPwyh7aXzU1S4Kd48nCGiV3yNAlKOF3ysaL56pbXP7gUvCwTjzFB/495t7H2c/2HAy83SZQgTEC3Rp20INajLDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+ViM/aUQ6jh+/Ov7+yx+NtKepQ0GuNOt6gyHP1KBL8=;
 b=ZERbTPTSXK4XvU8uXi6UoT9j+2LzZKxXts6IYpUcXPQ7WD4JZwLtezr8/HigcchFvrIHV4y00gI18Utpc6VwwKkPBDuoSYFpSwpkGF6jF2DcDEKVyCSkIzRzOvF0W9br5DlJCS3EToeHRbqUBy0v/XYKfBt7D9mehsrjPc1phrU=
Received: from SJ0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:a03:3a0::22)
 by DM6PR16MB3816.namprd16.prod.outlook.com (2603:10b6:5:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 23:13:20 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::81) by SJ0PR03CA0257.outlook.office365.com
 (2603:10b6:a03:3a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 23:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:17 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjxYQ3408790
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=J+ViM/aUQ6jh+/Ov7+yx+NtKepQ0GuNOt6gyHP1KBL8=; b=
 KTN9afaaVCKRs7KoSESi/Bv1K1GqkrL5jqCl1aWYxBZ8Rc/Bs6TPLFuLgzPdz/43
 0hEOTRJTnCZHogFZ2xIRp6JumkJkxhy/tchkEu6TvANLKaSMJ+MfIktWTov/L4g2
 4EjId0GpGZBgg7iuZk5+uUTG2La5slDtXD1FnTlLnPpDrK3FOyDr+GRMi+KVl6Sd
 TuyRBkTPK+SBye85jffmB7WPlDiDAq0FPZWVh6YFa8Jlldan2wSdMF3amlTG1JLi
 tVDnCKb9Eh6z6jlEVeETSalnsFgAvmnzVozk3JhqmokjKUarSVKLTeZG6/OvpSC2
 Jdgg9eS+N4fJOtdHytFB5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=J+ViM/a
 UQ6jh+/Ov7+yx+NtKepQ0GuNOt6gyHP1KBL8=; b=ni2V2Lx6FiB20ioh8vqmk7T
 g+FxEWjeDqsDClt/UmFFrVxBIWmJ5m7KQgsmZ2rPO7e4HjHDkMe9JkoN0S9dHrpG
 NIgYOsCQRh3LKLP3FQk988EzhSrIw/4/2YhSOKB7TWD2662IsyZTdEzfngjfgFAs
 2OOzIj8O34IYx6Zd4fl+rnT0SzfK6x/dbjEcIXoeZtZmC+VU+tbgXD6WXdJCE7jQ
 wabKfIJbgubtw3MS/Oheg5BRU3VRfNH+SVKKR5K6g4DHHj+RL9yF9jacWxD38DQe
 TyFhawZ3aH1wWQQUIlbMJPvKp1ahQA2LgYWUWJ+GBsd0aXcu7QNNZj88pBK1TfQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x9g41k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:17 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SNR5wYwh39jbESNR6wADf8; Wed, 27 May 2026 23:13:16 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNR5wYwh39jbESNR6wADf8
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 3/6] reset: Print reset type on diagnostic console
Date: Wed, 27 May 2026 16:13:03 -0700
Message-ID: <20260527231306.1714741-4-dmukhin@ford.com>
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
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM6PR16MB3816:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f47990a0-cb95-4fb8-933b-08debc458995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: pT/FtQg0D0lpGcHp6rhNLjuS5RqU9zHtGrE9jQjdpxac2dA025UqqFQYdCHpBHJmMbgefnoXdO8SgIsn8c9GdRvrvAl4NdCkyu3KC9y3B+k4QslxZZPtM8dygXuIqgz6fMkkmEqzHsDF79G8D2227KgDnTkHLxqa9UnovbJ5m4YxJ3Hr7/eOtXfTyc2w5l8gIi928TbB/8BMHNJALpmn+qxOBwwpHLA6HgaFkD4KaGVV5aLRV6fSSV4b9eIpUHqMELy3d6o5wCWHy/cyKyrEQHblRIcvrhYFO05DcnPAbI80xDNnXsN1H9j5HOuQKzyYmtdPx1mifWgQ2M4hGX00v3p5RTYEBCwzMYEaqqAQ7KyBU+TQPHU0D0MM+ECz6jkWKJ2oGqeobk9oY3C8buYSRU6eo+egCCO1T5G0EpCkxfMSWlFaTL0u2NxaKnGFaCDaunmG3CjjGs/+xMFEILdcb0krB2PL3CxNl24gu/UeEN6bQKEyd5Qi8pDd9Q7wmi1jGzT+bdOZoCz0H2FP8KbPy7nnaSDqUUuKhyek+akVo1Z0exIJKIHCPwZp57YbSf+YcZ9foKKxeM1XLcib3E1LXvjL4PK+iYMx4UWYRg+KhtRoueLWiIPuU2s/7gajIfKyTymAfcNMYaqlRry6sHCAzPRaP4w4pO50We0PKP2fxIAoprT+Ny9zz633JuE97gqTyRzRhmAaq8k0/aNnVpIIi2kuZwCz2yEckz2eJ04BwlQ=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9XOh317v38fYhZAT9KCZ/BRxuwG/erzfFsog1GV3+/Fe4B7tP9ea1kebpUNKFVMgofzcl2JkJ+2V8SmmIbOEaHr8wqj0juOQr2S5iauXvPb5LFqj7uKrhszBHDcAIdttfGmRd6gSCbmbYe5P5oSaVRW1d73zr/RHC7SP20Vrif9h89ixNL9F5U1OlWiGPQv0aO0o1HT1CA6wHiKlFQbEfTub3WnTSvLFEzhCW2ZBD7q38ihttYxqdZ8QObdHdcW0529LMdGQVWLiPXk1MbL9frwtzOQKI3Uh8Nh1B+J4fN94WaBZtiB1Uig7RHAkLuV1H6MK08in6x1Z85w4+r+NuRBJiPCLO5j7XBf9cZL5YAGeTx316ndqHk/BkpEoo70Jj3OvafUN+GDw0EDklrUmn8tZHEOj3hlcq3Q8dboch8q65xhAoTccSZAIKH7n12/f
X-Exchange-RoutingPolicyChecked: K1biBjwINxmHT+0rse6pePvIlynBSkWRkWYhYMvVT00o+wveKXB6XqQkuSzyrvspj/6r/j6VXwjLF6l3equEiTQiXFywkdhRhhAySg4XzNK7CScqMsKNpmVsoisXjOCFCcjpTEpQNjhi6yKjgAM+WrolgXuqYT2vxhWzS4xdnxrop5jmv+zXjyvsw0sT9Pq5PqFyU+Tez69Y7FoDCg5HxCBrekopAZ7/zwB/RcwDS9Tj6vipkZqrcmIVITlVavl545TNTAUKazIt4ITF2DZkUfflhm8nxtbdjs3zAyyjLvb4hp8dFWuwgW73a8Fjj7GFipfacNcGXkh6UMXeclJq2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iZLfTKElSrhha5BEYLCIZWctJEmYLRVcZRkITz2umPgZFHIaNi5RyDBpWVfz+Y/axz3muChuXcj85QY2iUyWVxrVQTvU4SlIB83mrUF/odln736IVm74wU4xGB8Tx5Z0xOj9jh6CdKUTg8XkZKQdEFDJYHaEV9VXTkzRQibU9VvByeYNlQmWorYM2EIeJOS8bGRqvlmeKzc5ahf2ljJCLNDHreBoQQKGWPunI5OYisnxY/xVK5HR0BGy7+pwC9On4PhRxn0haJsCcJFDG+QgZy8LJSb4HXKBzA84YEzXnI2WoLUwMAA134S/c/YEP6HOQQZh3yt9q1gTPPAtgg461vaLMfnwDKpElNd8gJ6HNGJUdcEVfZ+cZheGQwkg1I5Yj4MDk0wXtqhmKJm0NnlPPjbT9ABGATBUqeG7CMN2mEGSfcWfyLKlYLZuYxFGkx3Jdt+mIUxUvzXsaffWorsgY1ajoKaT1IwQ9h/P+9YNlAGO9ly2vdGioqM5z5ZgbrU23jiGwommmlXYXmMmNkEztjKWNDkhiqZO21ePJAI1ywocIc9/aMooAOJlBN66eXT9tjzf6yWv9FPQgqstZ2tshH/JsXuuVAillpYLZvW4p6XDcEu/zmHg4oT0HGT+g2j1s1KNMZeyEujPhnJ6LDxMgw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:17.9758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47990a0-cb95-4fb8-933b-08debc458995
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3816
X-Proofpoint-ORIG-GUID: rNHV_7tbnjMQq8sQLyvNuM4XhEMAaBxR
X-Proofpoint-GUID: rNHV_7tbnjMQq8sQLyvNuM4XhEMAaBxR
X-Authority-Analysis: v=2.4 cv=L8QtheT8 c=1 sm=1 tr=0 ts=6a177a93 cx=c_pps
 a=c8ROGaHEYT5V2SXoku0acA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=cbNQJ9GKAAAA:8
 a=23Llz5wl3KhMZEueFL0A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfX7Z9ekzRA006k
 mqXJ1nl8b5gGO51OJ4gzT5sauN2crSAhSv4L6FbSOzAk3HmWQi44NDRu/MCAwAaUKviCI87wnZI
 oTJxLgzqNzDP5xLxSwL7Xx9b0Nq6xp+RhTB8NkbnvccAS8lklM/aMyyedtcffKgWykDvNaBLodQ
 Wmj3z7DzMHVvEeOcQ/3qgl+EIcI9NAVDudjtKBWDDLogP6tJv7FpTfNoWGbZnHhPW2YfCaZ86Mk
 q4SrTsUWJBhkj1o0/YChYt3YP9BvinCjMOXD8uXqx/Vlk2t9+ZVUIHG6Wg5MeSwxbRGaJ4j2SLK
 1VUNnn06uUHn0gnJ2x6LW0ruR4TgI9M5NycJ3MZ74TXgWt1f7Noz02wKKScVBFqphxBs4wTtrx6
 rFcC9t91Jo6Jo+owBqPFSsQ/3Fbqpnj2N9qBxXqIuR/Jh5L0f89xIV/Hsfod9HhwjIwtNW2W+EC
 NNbPQa7mObR7iYW4LyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0
 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
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

Add a diagnostic console trace indicating the reset type.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- corrected the string representation for SYSRESET_POWER
---
 drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index df68b5c3f9eb..8f49a6093d49 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -22,6 +22,22 @@
 #include <linux/err.h>
 #include <asm/global_data.h>
 
+static const char *get_reset_type_str(enum sysreset_t reset_type)
+{
+	switch (reset_type) {
+	case SYSRESET_WARM:
+		return "warm";
+	case SYSRESET_COLD:
+		return "cold";
+	case SYSRESET_POWER:
+		return "power";
+	case SYSRESET_POWER_OFF:
+		return "power off";
+	default:
+		return "unknown";
+	}
+}
+
 int sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -187,7 +203,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
-	printf("resetting ...\n");
+	printf("resetting (%s)...\n", get_reset_type_str(reset_type));
 	mdelay(100);
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-- 
2.54.0

