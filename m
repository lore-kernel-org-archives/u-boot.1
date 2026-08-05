Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3FC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 22:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D875F80DE0;
	Wed,  5 Aug 2026 22:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0Ro6_lxvZSe; Wed,  5 Aug 2026 22:03:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02DEE80DA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967401;
	bh=Ha2P1JVg9CJJULDzZI498zN89KA0YZIrZI8KJbtluRA=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LBr2LO5SxxLxDnq1KT+sTE2dn9pFm25CowYwnn/H9bz5tBWC31WvKBzbeHvo85DK5
	 20layH1wgPBt/3Qkr2wptpD/g7phGuscljsVBjLvnVdkMRG0e6TIkNfy5/AuVFDwVw
	 POqwAm9LvbHs8olhaSsIi5Rudj4ffAro4CYEZT5jIywKvOyWqkr2npqcK4VT41VUwh
	 XFr+rBnNeM5+oip+a4AJY9CMxYv1xfdbxPMVzVFINlQSZfpgUGHD+D7K2/c0A4HqsT
	 PbEWoY9aUUA31JzAxNHwqsgn92WChrnnm62uAaUMJVSNKvZ4kD3hJcguK2pa7a5ATA
	 3A58Mhkdf8E4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02DEE80DA2;
	Wed,  5 Aug 2026 22:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB2A63F9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B162B40251
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkvDrkg4tIz0 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 22:03:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9318D40249
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9318D40249
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9318D40249
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:03:18 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HVnR72147858; Wed, 5 Aug 2026 17:03:16 -0500
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fv43f4kqj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 17:03:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNUja4FWk+2LPlJC0azhTYUKVyrlNrB3lVp0xd1xIxDMNJuPWo3pB+tm3mpo6HwLI1iwx23jTctM/otciHTlbR7GN8YcebrCfi/pm0fB6/n37a0d8woRphql7CNyeiVuc8aV89wpbACaweHz63JL+op/N/Yr7rhHzDlCY/7sqkREzisnXMk3RoxBKNH/t5F/u7qIzyZniv55O1jsVz0A7ZSIkAFZQ2rKpLwOFqJI3iKPNU12XHL6dzUT2vEElHAFKCTQ5Dg5WjA0LOdC5r7uXBinyt6QavJCf8WNQ65q7mv19qqstJigcKf+cyXK0VhEpMKlyPE49Zhy5QBNOAWSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha2P1JVg9CJJULDzZI498zN89KA0YZIrZI8KJbtluRA=;
 b=hqAAxbhVCtc10+IqQ7AIZXr9rxbbgqag+NrQVJsJzcU68uO1ce1QKKwG3euRxH92q3+WtExWSVEMBbWbuFXXH0+Er1BZGjpOlboo0rqvnrlhXkCXFEtrJk//B+whTHwnHwhAerjO3DHbn2P3vOtzXDxRn2SMEmC7OFQViOQNLZ0SGjHVoAQkYwIPdd4G3ksvE/nkaS8JBq5plnioxNuRAiVvvhQOpxOvNRH/F+//TTKKbBv4tv0weK74zHBg1IbPlOj9f5XYWQwJweyRW/2t0gvqtqzc3HeVib+W+ZoOCeUCOocjEDA2X7+s8f3zCFrOCTDJFdAcao+RG9I2t0zf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15)
 by PH7PR10MB6458.namprd10.prod.outlook.com (2603:10b6:510:1ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 22:03:13 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::27) by MN2PR11CA0010.outlook.office365.com
 (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 22:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 22:03:12 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 17:03:12 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 17:03:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 5 Aug 2026 17:03:12 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 675M3CBT2905410;
 Wed, 5 Aug 2026 17:03:12 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 5 Aug 2026 17:03:12 -0500
Message-ID: <DKHCLPDCH9U1.2RG5Z10DQQ1SG@ti.com>
CC: <u-boot@lists.u-boot-project.org>, <qijian.guo@nxp.com>
Subject: Re: Bogus error messages on Apple Silicon
From: Randolph Sapp <rs@ti.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Randolph Sapp <rs@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <878q6k2rv2.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <878q6k2rv2.fsf@bloch.sibelius.xs4all.nl>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH7PR10MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: a31f7f20-4040-40fd-d56d-08def33d581b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vfrL93kAl/E52tkvFfDIjk2TxPY+axYymVDtgzm3taZuUuYLqzb/cpdFj5ta1rmuhXKDsfTnRR/k3rxBGbVkpeVixBKiSkjb35UhgckBQs0AYtztPbl4VL+YpeRrBH9j25Ss9bZ4Y2W7hAZW8v5Jb/il0prilp/b13t/as8B8R4Win/DG+FBnkGpZw+4Fv54to9XUIDIA3IJfExib0NYf1i7E+t/1jn3pzuKEYwlXWws/qk1JViD9ZKskREESWWLuKdZjRDWip9I/K8kroskJeufzOyuxHncIqxdd9X92lE8hqEOfRSVVCpwS0UKggpeXknLxodXKaE2LWK++mEPWlAFs3q6AG+Lva9hW7NpFgUjhcKFtdgggF6dVNxYrDD2HsVFMODUUdv76/OnSCdWFzZ0wh2NCqaIsOylK+WDPJYcNkU9lHojp2fCL2wDxUZ5RI44qageUloSM437GqZfCdJRBfJHhPoGu0EeW3pzAcyXmujfFY7/Ys9hhp5zohDnJl1oiPpdy0ZYpJzToIBm4EuxVIzEPwkSM2BW4crq2ihJywO9P2AnlizW1o5hteK6+MqQAh2add/fVSLFnEjWlUvcFssI/4etQoIWlO2LvGiFBt7b9GWkz7lSD/Fm6a90R0G6nH9T74pl4q3MImnXvtRjNLBi7N8r5+jKwSJSsKL7gHLQElXklxz52+PCC84uU3vWa2a/YRgkzoMrsI170Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zXu//vJF4RnxxWv1oHGORTL6vtyhbzof/Ke7ODnSsS4Ca+VKa6gr4MoxP8FVcpSF1DWUI+CfX5Q4jOUfgS+yd+2NoZWLKwxs6u+Chig/cIMLs2uLkzXWGGPpDxhDfJSTKtebeD05OXINqnYBa79sV74PrytrB6ZG81ajGcPNQWGSw4F9P3dEgDk+8PKdonpynGfhhglOZzz9Bxs3oDVvw+GtpJxuy/96/Fb8xBagIr+5jrcVxxJIAk5C9pEAfYO7AzJ2I8gdQ4v2jRshl9/o/MMD3QLPHFM7YQZPXjBVWIOW9Ff+itC/6Rh16L6UVx/WauXzd8AA7DLwSFWotQ3l0OFwV+o7c1zHmoquAHQ7Y2PeAzCcwJ4AztlwbZlAJtt3Ls3bgQySYk/JZQLj9AWyLKmOnl4ivCy6U9j03dPalqlzA+D+P8LTwKCHLEHYRpwK
X-Exchange-RoutingPolicyChecked: Ji63lxoZXvVd48eJ/dJ6EnEqHysx0A3Mh6Ejn/HcBIUwxdR0/5hGTMRT4Y1LDYFEGB6/Pewf9s5wZvwuJdACPlFQiyoZLD0ofedQ0X+bUI5HVWYs++dY08oiEwDVdPvTnwr2pZWmOHXL8ppZ9gH0HNnq8x6ltvOmp+PohbWymlkwSfKFXo5i8GoTks+UFQ97OM1LbkEkc4yXEqcGpELTg2H9SQBYRUhH6n5wz4cq7achsLekJSrc8s180cVyNjxGeaxYB1yT9JZ0mO/RlrkHWk218sxG/eh+s7W1PbB1aDsb7xON9zIt3/YyxWhTCfD1BsQjtfr0bTdDrj7KbQn9Tw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 22:03:12.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f7f20-4040-40fd-d56d-08def33d581b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6458
X-Proofpoint-ORIG-GUID: Evja1QXOiwyLbG8ayr0awrioQnlNWsCJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MSBTYWx0ZWRfX2hli+vunVD6z
 iFg1SERBEPbs570vPEgQcqa4Umjq41II7UaK0tCFaHEKQg+YrYIF9wqA2h+ABFMkOS0p+5zsAgC
 TsVILgRQ/jehaJbBAhgM86hVc3RRL4w=
X-Authority-Analysis: v=2.4 cv=Ircutr/g c=1 sm=1 tr=0 ts=6a73b324 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=hB9iPs_wenxRIEXsO0gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MSBTYWx0ZWRfX8RAcYBUj+U/q
 NsIHhT/ul3l+sV17cLMTWbI5gqGdtzKsSsE7jUy93OGHajzQbvFU45mx0DcJmDFRbAJRrhvVqf4
 L5NMRfULGa/HJfxLeZiPEszctq+wwjkutpCBHfWOcd+wQrafAmfts4PqNfyIOpzYt42WxyyDd20
 XMxvZTrzpEZvLcQ+cWeZuqXI7cXVINxZP58Gs1F+EY2H4Qk2r7rBKZ2zKMjFDFlVRV4KkVr/+gK
 AnqwKxHDHy+oorsR29raT6cEkab3TOh5gT6lTQj+OHrHPtYWatOPAonfQ+rqCa+bzSce5WxmuIY
 VziMbDL+k8pZEkNoMENGWzHtaOwW0MbkG/wco8ixbWKP7z+tXgeEl2jyZac7eejHc65GmSu6W7z
 IFiYcNRTRGgytRDYVxXr0/pQuTOz9MrNXB1XzYou6KYua3DDMJvEGC4WrIdWvqexXS1CzrysHBr
 Yd8xTE4wTUIk8IARz/w==
X-Proofpoint-GUID: Evja1QXOiwyLbG8ayr0awrioQnlNWsCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050181
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Ha2P1JVg9CJJULDzZI498zN89KA0YZIrZI8KJbtlu
 RA=; b=EHl01UKX5OMX73EYqr0sHviADg2seORMoTeVBZci10UnTiIAAsj7zMEjM
 e0LKBB26yLz1vX1QJiuqYt3udrRNJPQw/wp+Cdm/9CYAsuTC3aJt8hbsvqI7KHt9
 aeNdAmA1SeyJoAjnmmFKKkGowzkSbv/tP7aAq06oZTgFLokBh7KuJQSeUIIJrYYG
 dJdkzgRCEFMTgF32YJp6r4n0o9RgNr/g5GYNKEFi0q8k3Kpf7thQHQxa155LuM7d
 VocVEOxkAfTVq2Yyw3tzmyH/0BFTsgdWnJ6x5j3c5aAVxvwjAVPmd3EyAW/AsYP2
 VreR+kkBG8cXSDjVGbk/+s6Lnj7RA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha2P1JVg9CJJULDzZI498zN89KA0YZIrZI8KJbtluRA=;
 b=tzqY83qR0Laxz+7Rz4Gp1dgGfulJ3gje5t5L2F+bcn76fK3vXUqcRB27u9GRWAEDhOX02qOdCs4ZvlkCMss3ZGqmAYPae0D9LNrprY8AbV4t4JAjUDGsS+2zWfUBtl9eXvS5B+GLdUmVaBB7nxIaW/X7U23MpXP5NEqC0/FTykU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EHl01UKX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tzqY83qR
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed Aug 5, 2026 at 4:13 PM CDT, Mark Kettenis wrote:
> Randolph, Ilias,
>
> After commit 623f6c5b6ab7fa2 ("boot: image-fdt: free old dtb reservations=
")
> U-Boot now produces some nasty bogus error messages on Apple Silicon:
>
>
> U-Boot 2026.10-rc1-00115-gbaa64b2f8928 (Aug 05 2026 - 22:33:45 +0200)
>
> Model: Apple Mac Mini (M2 Pro, 2023)
> DRAM:  15.3 GiB
> ERROR: reserving fdt memory region failed (addr=3D103d7f4c000 size=3D8540=
00 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D103d6c4c000 size=3D1000=
000 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D103d7c4c000 size=3D3000=
00 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D10000218000 size=3D6040=
00 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D103fff74000 size=3D4000=
 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D103fff78000 size=3D4000=
0 flags=3D2): -22
> ERROR: reserving fdt memory region failed (addr=3D103fffb8000 size=3D4000=
 flags=3D2): -22
>
>
> The issue here is that these memory regions have been reserved already
> by the previous boot stage and have already been excluded from the
> memory listed under the /memory node:
>
>     Node 0x22568
>         name: 'memory'
>         device_type: 'memory'
>         reg: 00000100.011e0000.00000003.d2a34000.00000103.d3c18000.000000=
00.00004000
>
> These regions are listed under /reserved-memory since they are
> referenced by other nodes in the device tree.
>
> I suspect there are scenarios on other hardware platforms where this
> will happen as well.  Can this be fixed?

It seems that these messages being valid errors or not are still up for deb=
ate,
and varies per platform. Rockchip has a similar issue, where the reservatio=
ns
are explicitly outside of the memory node. In these cases it's my opinion t=
hat
LMB should never be asked to reserve these regions.

LMB should only know about regions that overlap with the main memory node.
Masking these errors is still potentially a problem. Simon pointed out that=
 in
the event of a partial overlap it generates the same -EINVAL error.
