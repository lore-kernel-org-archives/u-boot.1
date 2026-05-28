Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8B0CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0D48469D;
	Thu, 28 May 2026 03:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="tFCJDCNv";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="ce1Xo1Eh";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="RNskfL5b";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="p81+ZYwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2622F848C1; Thu, 28 May 2026 03:21:14 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B14848A2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKhrFI3964339
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=1Cc
 wK4DilB+/vVr4dUnDXw0Uo1CMjDAFcBk4KbHRuAk=; b=tFCJDCNvpgPDKFnqqCl
 5EWvxyGngy27qsNSyR++zuq8V8JQpWuxUhAVYmiRe/sxU3aEBEAJueFnxD+nYead
 Eilx1BS+nHE1ZUWlCsiZPcm2CKmXg1V8krVMOClSTmao/H4ePFwTnkI+cXc6BWyo
 aAUio/aHetFHP73re+DdEuHw/b8SUydy+YuMcI5KmW9llhY93gxSNLqXz7ZmUsmX
 xAlMCBCIvviu/o5QFFRUidUE6q0cgaT96Z/LKAMuX/QWnn2dB8vF1nEnaiaA50UK
 Q86hS0fOg7gaYWidFPN6ZbNk6AiXuUivaOXmxwKb1KP9XakBt4E3TkdvNUmVuxv3
 /pA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wj1esw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4Kr1ju71njYwDyzmxV+ON6QI0CFS3XaWifdoTEol0MuWlSKW/QyzY4Fv2tPGOnH07P5Jn8Rd/UzPG9lhjRMsB60UlZOUTKrjHQ3bpKhNmzZNM22d6CeXdRktQpxfAES8cAZf6LRiPyJIBcJulPt8we4Kx5CW6R15dTXakrJ5vsI5/2K97hVC6cKBhBWvawnpf0LFhM5XDtH42u2OrP+aHSFjbwZkHfdC7z3dF/rSC2+YJe+TurzaLiC+oNVnDTdi7vz9a/axLkSy2vD/oHcxm6yIkRlB3Jp+K0A0KEVTt2A2VRLU4xpKEdPpLeTnFDOdWUnMXJSZXWFVpXDxIMHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CcwK4DilB+/vVr4dUnDXw0Uo1CMjDAFcBk4KbHRuAk=;
 b=U8uMmiZ0RvP40fbmw9pUA0lNvN6ap+22RG824vfg3xKebCE7gbQrOu25y0DTZGGjq6MyMNvesy8II//goldSlWwGbrbO8KGwa2PdEmATWQ8skDl1WkhXUFpUKKpaPbEN1TOzVrm8E0LXUZlzXgQgstpe0wg6HqbuPDJAOxfQ9TvWqQEMnqVDmtKvQ2ms5t2ywlqq1uggOzOb8byc+R3xvqtYvtbFWX3GlR0z0+AkOjyOqxQygmqMZzQEk/KDnNWKaqgLXHU/J0X1LsQZZEKoT7xTMCKmpExw1xIFnoYefXfNvICjmp3xxuGB4IVn0saWAWU3GbsrzIH805uzblqF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CcwK4DilB+/vVr4dUnDXw0Uo1CMjDAFcBk4KbHRuAk=;
 b=ce1Xo1Ehkayz+K54x+St2HCPxr+uFavwXi/ZlKvHgeYP82waeTq8SQUQDwzmEYjRPK9AzsNEBroQSM+IEbZJ4oyzsoQJlQD+VwiVyhcwrFIYWKHdALxXXRRdRKiKvlX1ifW2+CMQTd15SJO46ZdiZFboYXVIWf3g28a4GylIxUk=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by BLAPR16MB3906.namprd16.prod.outlook.com (2603:10b6:208:27a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 01:21:05 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b7) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 01:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:04 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjS913751409
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=1CcwK4DilB+/vVr4dUnDXw0Uo1CMjDAFcBk4KbHRuAk=; b=
 RNskfL5bFeVHmN7lNdEgpO89URPgR2/0I3taJgNLJDa+26CITF5Y1CcidBC6AL8c
 PA0jEnPkn2X7PQR/JnvMe8wykEyQyiRY9Hv+tYjZLo36qPXAcErFTrSxTA+Z5L+u
 ZQ9KMQvMY78KR9kSQ3tFcdyGE6FZmOrUEZZs6fjGHSkw8TEboXNQWTMKho9J6Jys
 5/IiiUPKsmPZzKIgznoGNG/6TME+P2cdtlx3nKsYHpZNA9ct5ew+lFk3+hdmsFMh
 CLvSnvmHNrDpGuZYfObBt5iwdykXJZaEd8Id/N/Yn3edXA4HyjfXaCZVPej1bwkl
 KcYjBKcY0gYpjRJ2Pj5RIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=1CcwK4D
 ilB+/vVr4dUnDXw0Uo1CMjDAFcBk4KbHRuAk=; b=p81+ZYwR5iXal2iDkUglHw0
 Ohy3W8O5ZSEDVPaOu9J1a6wgOkxkwMpE0ic3jC/FGDh36GhHZHvuDYN0XCHM5sP9
 kxix0VwC5Wo0zMibq9Om9QhL3Jy/AoSfbelP4poIvSY7V1YesUa3Ds738TdD/uRh
 0O/pa+wJAT5RuV07Y6rLKWtysdZqkzv3+TJeA/9UjCUvPbDpg5VmK8KOy7+Bg73M
 89RYgnDC8mkp2yZbCthIOx1GyRjGq+m066SamVwVNG1OwqkdGPMrkZl2iLj1Y964
 fE3fS8tKyMamS+0aAJLVPFEQB5ryHt/M4tzsrLpg8QCiOWMxkVQ/6QDz1Bjy6jQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x8079p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:04 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id SPQkw4ewTl9zvSPQkwugbS; Thu, 28 May 2026 01:21:03 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQkw4ewTl9zvSPQkwugbS
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
Date: Wed, 27 May 2026 18:20:53 -0700
Message-ID: <20260528012056.1744362-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528012056.1744362-1-dmukhin@ford.com>
References: <20260528012056.1744362-1-dmukhin@ford.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|BLAPR16MB3906:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f02455a8-b5a7-493a-50c6-08debc576363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oAUpepL/Jy7KHUWsGLd82J8e4YxVcYbLHIKA6j711uFy2/fecQJquKEm7+yfX0lOjXu0zgDZNNLKvh9C/8Xkt3c1l9KEY0qKo+R3SOz/37uMqmNH98FJhRQvMqlXeXVxeFOs3q8Q5efDDZmsIJvew+/dw5PKD3PO8coLAlKPL/FI/QZ3wlij4qgCFRMxfdn+LK0Qo5KCrTrgZiirA82Ge9eEIdxk4SORieYzrX6IlrnuZkblHf080OglSahTQfIaV28xPe5TsQ+sI9mtGR6pE1/M/UbvfRZpSKsoMAuaPpBZIY+lPbdI6IHhl2VT4waXrTKTnwpfKxSeMUymwsrN/COLHgOrS2Mnit7KuOjXdphNA3rq7teKjmRuERCkU55oZSHXuFA8+vVeY/xPurbg+UHzHy5x6UBihuYE4okkYZjvkCfym2LNxVre3OiiqtHT8tUIy1QOYacGea7RLc3ML4QO6fQPHv7H5E2VHfX2ntF2SYVJfW8yIIfFhGxScpB2LqDoVKI6nTVhm3Znr3civHdpNqXwwCBMJCkEohDHlc+TfSwt1xv8r+4w9rzl8wGFBV0erKG0wW61qqDJOMsiqiglOJYZkAMq0JFOr1F+tJlx4vwtZn/8p4tti/2q5wXSHsdpmKuMWYT25A7Ytd+y5CVpFutUcEFPgtCnMlBfLe2yj7MZ5WktXYCj+wFdcheQoEch0PTpceiVTZsW0BnWeN/AuFLOx66strmGSBaFkgI=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9odlFN7Qjnz/+XbyZo2XbwE34LKJgle9Oom1lU9LvS+Pt04+oUBStkhi+buaEewLNTd8Q+Ag5+TLj08v9dqrM4wss4s9YxJaTr+jz0XnUznLAcl2XgCrGUHOCFG7tliHLhYXC/mgb8YfKibajkILM4w99eyHFFSkQCuGDq8+nNQ/PEE682MnfYZ1o5ZnTFzQbK1BcW6xZkeNd1yF5/fdKSp6ZCXplw4PQ6iDvIZlOlVpp97K1Bcc8SetjnTDpj//JApe9TamrW1MKNg8kqscCZ6aBBDEB0wAVJHVoYNvs8g25U4MRxMpREfQ9xW18AiaaRiKB6I19/LWiIE9bmuP2uamjSVEE6cH5fYP9s8EMWQ0fUTYORJTAMNTwwRiLTZ+TrQN3zGubFSaG7I4Hp4ca2jwTTDqPdNrgoCYrfZ9BMd8WA+CzIeOtfqrxZm62eab
X-Exchange-RoutingPolicyChecked: Pl5Qj4LxpprjZsHAM8YPpuxI+FQnpx8LEP0HXvvhnoKfgdh0O9t50eFW41poAUWjJY0LlU1up0nkYuIRY0HiXCM/T2FW2NDJKbIWYLdMrmmC4pmOv9Rgk1rM6ZwECbXvG0PNNN3MGYZeCfQNjJWCGdcPGRLmVftpQdh0msmeuY81hbZkYCDKjCWAQP6K2QmbIdTPpq9WDsK5U2fQmN/HTW51ETswPMkeWKqNjwflG3pVKgURMme/C4OIBzUeXtOcV9l3pP8dWFJ0YDDq+BogxcUt9goHYfYjOJWbeRgSCECTl4+sQIp76QddrCVIopht/kKUB5ZHR6FyQ8oW1DrOXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q88kNrRCGuVTn9DuFKl582X3hSG2A/rkjtMwMzq3iy6w6bzpx+6mevWlmeWcCP5TrJm//WfpSus4i/UaGb5dBGdpwuF+XsSvyXW/fNm6oe4Y1xxiBkVWxRK4QrbZclWYzU0WFVNpTQ93B/7y7kKru2V9lK20QXh/p70nFbuElUmHfUzFN5R90xB02es0/NGjAvEpPMvy+ipTu1FK9diMTPejKBxsFYaHhPyUm71O6nMQG+y2sRQGn4XRlG6SZIdjD9M6dXJXtM3uIPN1FxktzGrXbXywqFUZo7tvT+sWr8vlDEcte1fgTgQQwnG6V1Og+mKBfEnAGY04aea3ABJULbiC8YMdVt+emjyAgM15g9cGd6aS2nDcgtIU88iQsZiTHMi7NS/78jBeYnRwAEw60+jTQ6PHHUYZ+umWp/kQwJaXsfsx5T4NETJLka7BbPmXlAH90XGbA1O4xBdNk4GwVOVVg7kWdTheOSNxriDNZrP4Wy000rOwRMQgY794aAc8pVC2vrxe3sAV+g007Bl2K4I5hA4C/tPOBD6ugT12sMfrugLJTHG/XYcnfGWgQj09APYBQi2MT7iDTJ/SMXM+tIW6hwQY4gGCThcl/fMZ23HPltJtC/o2OiLcniJe4cTDScrH8aooloe7xyHptDZaPA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:04.7712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02455a8-b5a7-493a-50c6-08debc576363
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3906
X-Authority-Analysis: v=2.4 cv=VIntWdPX c=1 sm=1 tr=0 ts=6a179886 cx=c_pps
 a=zuxl87/EtwiH5kfn8ojmSw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=cbNQJ9GKAAAA:8
 a=RXzEa-JWCwTXoRYvH-oA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: 83nFpwoww-rqyydTa7-K661bJemuxcfD
X-Proofpoint-ORIG-GUID: 83nFpwoww-rqyydTa7-K661bJemuxcfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfX/R2pAAbuHfgt
 sduGsMYm2f0cxuEOVgxm3Cei9G+P3Ln/Cih7TFDuq80K9K+qXO3lviVsUKlkesTgVZHeoZLpNGt
 EwXT/Mqk45VYwpn6zolLfYJNz9YksgY7OhGjz3ZZuo1tEBoY9LW+xGwhxfplH9a1YJxgu3BYVk3
 /IyrsJx4QS6hjrS7rwU8+K3dG+CbIjuzCMcClXufl24DqxGTezYISwRwQazyZ3j2yp/VCvpOIoe
 XmnIppgVPbMtxBrfESKevVHCkbTWoM7sXzQmYCZ3AjLXsPG7mLK/6gkSur6bWsSqSTAxQ+gRT33
 YHkedD/F5q/q4Y3tbePL9NvybOUAo89/hwnyz2/LQM/HEtd6D2zEX1TiSe71DHUKrgbYKxxPGOZ
 kJsEA81KwjB1S39Gk59A2Vh79NtzN4No62jYI6/NlAxARbFaxfD1glnqgi1ux6W5LANeXlykjbA
 44FjpvJZlFqD5LJp9Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
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

From: Denis Mukhin <dmukhin@ford.com> 

Add flush command implementation along with a high-level
disk_blk_flush() API to be called at certain checkpoints
during the boot (e.g. updating custom bootflow flags stored
on NVMe).

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 disk/disk-uclass.c         |  6 ++++++
 drivers/block/blk-uclass.c | 18 ++++++++++++++++++
 drivers/nvme/nvme.c        | 20 ++++++++++++++++++++
 include/blk.h              | 28 ++++++++++++++++++++++++++++
 include/part.h             |  8 ++++++++
 5 files changed, 80 insertions(+)

diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
index ee3cc4407d76..b04b6306e5f2 100644
--- a/disk/disk-uclass.c
+++ b/disk/disk-uclass.c
@@ -122,6 +122,11 @@ unsigned long disk_blk_erase(struct udevice *dev, lbaint_t start,
 			 blkcnt);
 }
 
+unsigned long disk_blk_flush(struct udevice *dev)
+{
+	return blk_flush(dev_get_parent(dev));
+}
+
 UCLASS_DRIVER(partition) = {
 	.id		= UCLASS_PARTITION,
 	.per_device_plat_auto	= sizeof(struct disk_part),
@@ -132,6 +137,7 @@ static const struct blk_ops blk_part_ops = {
 	.read	= disk_blk_read,
 	.write	= disk_blk_write,
 	.erase	= disk_blk_erase,
+	.flush  = disk_blk_flush,
 };
 
 U_BOOT_DRIVER(blk_partition) = {
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 73c24fd91763..0be1fdab1ba5 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -514,6 +514,19 @@ long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt)
 	return ops->erase(dev, start, blkcnt);
 }
 
+long blk_flush(struct udevice *dev)
+{
+	struct blk_desc *desc = dev_get_uclass_plat(dev);
+	const struct blk_ops *ops = blk_get_ops(dev);
+
+	if (!ops->flush)
+		return -ENOSYS;
+
+	blkcache_invalidate(desc->uclass_id, desc->devnum);
+
+	return ops->flush(dev);
+}
+
 ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
 		void *buffer)
 {
@@ -531,6 +544,11 @@ ulong blk_derase(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt)
 	return blk_erase(desc->bdev, start, blkcnt);
 }
 
+ulong blk_dflush(struct blk_desc *desc)
+{
+	return blk_flush(desc->bdev);
+}
+
 int blk_find_from_parent(struct udevice *parent, struct udevice **devp)
 {
 	struct udevice *dev;
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
diff --git a/include/blk.h b/include/blk.h
index 8d1b70cabd31..3e2160a1ae4d 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -99,6 +99,7 @@ struct blk_desc {
 	unsigned long	(*block_erase)(struct blk_desc *block_dev,
 				       lbaint_t start,
 				       lbaint_t blkcnt);
+	unsigned long	(*block_flush)(struct blk_desc *block_dev);
 	void		*priv;		/* driver private struct pointer */
 #endif
 };
@@ -275,6 +276,14 @@ struct blk_ops {
 	 */
 	int (*buffer_aligned)(struct udevice *dev, struct bounce_buffer *state);
 #endif	/* CONFIG_BOUNCE_BUFFER */
+
+	/**
+	 * flush() -  commit all dirty data to storage
+	 *
+	 * @dev:	Device to flush
+	 * @return 0 if OK, -ve on error
+	 */
+	unsigned long (*flush)(struct udevice *dev);
 };
 
 #if CONFIG_IS_ENABLED(BLK)
@@ -291,6 +300,7 @@ unsigned long blk_dwrite(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt, const void *buffer);
 unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt);
+unsigned long blk_dflush(struct blk_desc *block_dev);
 
 #endif /* BLK */
 
@@ -331,6 +341,14 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  */
 long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 
+/**
+ * blk_flush() - Commit data to a block device
+ *
+ * @dev: Device to flush
+ * @return 0 if operation succeeded, or -ve on error.
+ */
+long blk_flush(struct udevice *dev);
+
 /**
  * blk_find_device() - Find a block device
  *
@@ -559,6 +577,16 @@ static inline ulong blk_derase(struct blk_desc *block_dev, lbaint_t start,
 	return block_dev->block_erase(block_dev, start, blkcnt);
 }
 
+static inline ulong blk_dflush(struct blk_desc *block_dev)
+{
+	blkcache_invalidate(block_dev->uclass_id, block_dev->devnum);
+
+	if (block_dev->block_flush)
+		return block_dev->block_flush(block_dev);
+
+	return 0;
+}
+
 /**
  * struct blk_driver - Driver for block interface types
  *
diff --git a/include/part.h b/include/part.h
index 15daacd7faaa..63982d7b9370 100644
--- a/include/part.h
+++ b/include/part.h
@@ -454,6 +454,14 @@ ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  */
 ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 
+/**
+ * disk_blk_flush() - commit data to a disk
+ *
+ * @dev:	Device to flush
+ * Return:	0 success, or -ve error number (see the IS_ERR_VALUE() macro
+ */
+ulong disk_blk_flush(struct udevice *dev);
+
 /*
  * We don't support printing partition information in SPL and only support
  * getting partition information in a few cases.
-- 
2.54.0

