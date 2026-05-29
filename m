Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B6FCD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206DD847C4;
	Fri, 29 May 2026 05:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="fKw1zw/j";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="dPOnyIlm";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Ptsbq0d3";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="AcrMQNCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C7184859; Fri, 29 May 2026 05:45:09 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32408847C4
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3UAcs2121987
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=b+z
 MyN+etl/8oFYVimRV/1mxNNrHQsjHK+yrHDNF/nA=; b=fKw1zw/jKfuXpGUvhd3
 Q2a1rxvVagD9FPRHBqVOgqSKlVlNTZR7lWWv3MGtk7qX2ubPrEcqVoQlOJ7P5ttW
 rTFwlsztdkxNPXLzlWwlU4HgccvYv8FkMogrj3G7wnFKatEcMPqHFnb3BtVpLpUW
 nVyQ/9MRu8morKAboLJsj+/EAX2TkHFHNvHct1Zsl9gBao2zPrg+zIiGDEaT0Bma
 OpIKgHkUboqZSm8NY+cLrQU3duAYA37iHgvPdP1Cvg2eZHJbPGaBfCycEVVeVUtM
 nzte4gS4OMf45DrRQ1PIiLgs8qZ6AzcYrZcbS1sPLwG6Uv7kJF6huUTpRNdeJ00M
 ASg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2xx823m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:45:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRkWiec04wnjh3sZe+0k782ErSdR55s9g6pwLZXhKH5rQlxbCocRCgRhCrrvgeEd3rfmmCvw38+f3+tzbi+8tMdawqy+yECh6kWpvMso0FrhOYrPzFtjWZ9aedIhHQN56XZ3Ag2BH7dD9Cm6ZD/w+nGbz5xCTyX3PsfH4PKKJC7464NutXpLpQ/5HkgetWNzrZqZafZJ43qf+QMPE3fkw8bquQ6Y8I71meszql99TRwDENFtUoTtFTxL9dBBTUUlQN+8NSrRcjvhHIVy5qFoEpoous6h59oJYp/QN+zNf3waWvMz7vmDtJCnufZE8ssENarwwccZrTG6NyaSMhmvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+zMyN+etl/8oFYVimRV/1mxNNrHQsjHK+yrHDNF/nA=;
 b=kQ8Jc3utLkVaJE4Crbq202pLIV7hYNjg45p0rjycxOr4kBWVOpIM8eV07aQubXNQOJU9bT+3gEF7hmjiOPQ4d7CnSjIvANgzZYqTinMNS9N62u7iomzcW9gFtGlF2PujYvQ5G1Eu8jFImZ06nQnIgy5yY780vsFmuWnzcQwiEzS/lSHbGRvrcEbiSOefyNXjAMUz7ALscUikovN4B2IUpl1IEQnmNngFXyAG3+R57X4ucPvHpJn8QfR0awYzcQdbYpsnqbXaXxjE/9+gCHd60dKl7mGWTGveWpQ8/g9DNp6mYevgctgTxqK8f6q1kiJL23Euf8aMsKGELnNi3QQIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+zMyN+etl/8oFYVimRV/1mxNNrHQsjHK+yrHDNF/nA=;
 b=dPOnyIlmLE5DTuLGM0FSlG6C4PwYLnLyoaXtPZZH3rf1qkp6vHqvcIBDvUgjXxeJUElKShIdilJbtwp94MpttkVdJgVDaz85YTrYymdSYqr9uNOxr1ErFvyu7+g0gQpFBrTfQYpdaPpwNkYOKIx2ldD8IEX1dCc+fYj2AP1RNio=
Received: from CH2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:610:50::25)
 by MW4PR16MB4814.namprd16.prod.outlook.com (2603:10b6:303:18c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 03:44:58 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::6e) by CH2PR16CA0015.outlook.office365.com
 (2603:10b6:610:50::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:57 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T04KU62743730
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=b+zMyN+etl/8oFYVimRV/1mxNNrHQsjHK+yrHDNF/nA=; b=
 Ptsbq0d3jM3vXLFBGGzCXsDeArIVVO5gEFd7UTz2ktlCCz/AxG/kNSHtWSV4SjYk
 p1K3/oig/7H1cOnKft0dRZ45cuY1orQkuCi65JIFLsrXPdR8wu0Dhg0d4yZo6uOf
 b18rX4MJCnTc9tYh+CwC9l7p+hrNeW7/DPUnRonKaWPtQyI5D5C0AKPlzWq6ycle
 uaCDuKgBTNnbYY79BEUBbiBUn8sgEGCXcjPDKtKpB6ilnXzfJqCN4mVuWbE2TGaT
 2UMRBlsBQx9uFKBAF11EM2VDIvRxFED8aUTQIUw+1S076EtOjOaibw8Yk1yos2qV
 I7qtU/blmGKTbSKe/O9Fog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=b+zMyN+
 etl/8oFYVimRV/1mxNNrHQsjHK+yrHDNF/nA=; b=AcrMQNCAM5Ie0sHBwvGkIAf
 5rtV/1875LhLGQgQDJ+FLdmyKSvYnRivoerFQf/3vB3E9/O5VE5fLam+LTfYzBcF
 YnWmMOf3WTVGq+VSf0fUVU4klftZklMzIHOPf0We0SwXk6yiJxYz1s5t8nh/GqNy
 XI6zUvhLYKIeZe6HvNsWb7lJXccHAHHb6xhV60HcHvcXacUCxNcHqI9Ss2Xyzp7N
 actJ+aaU+79AEyenxvh1n8RDU9QFFSJKS/7bVv5bpkJXBvRVB924bJS8eCL7nZ8f
 c5FKher1AP5gKdgJ3GW8ALgGK3BXHIoErLzineoxGBtjBHENpM3XAO5ZfoZaayA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5stwu-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:56 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id So9Xwh71QiIgTSo9Xw6UZT; Fri, 29 May 2026 03:44:56 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9Xwh71QiIgTSo9Xw6UZT
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 6/6] docs: nvme: Update QEMU command for testing
Date: Thu, 28 May 2026 20:44:41 -0700
Message-ID: <20260529034441.2075305-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR16MB4814:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17cf3905-d5ff-4598-7547-08debd34a75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: S5N6M5oio1xp7uVUz9FGYrVRigE9VjimzNORcQS4dDEMlzTYNmaBZXrK2b33mQBg8VyGUe8bCbN6PPUXkJ499pQHyPe+fwxnMoFlMC7gKzD3FDbMUzFfBN3xkubXCDjubgC052+HMQ3Xt6S1KOmAkgTFsEhSzTwisWEBMHA1YqQxs0jYhe7NOmbIBacNX8OOp8RfwYN6ILAl0CUzJmitdaXpvG0vBl4fA2KSEwfF9NWxCt1WIeYq2r0J8k44qRH0mo+L79MtDjf+w3uh/hjvR4daUxFVTaw+H9ePyOxKxNAv+EVWOCF+y1UOqMsrloHk5/m7cReALL1VHj1O8ww1kUR3XxvdefVNe3LzUmkuiQBjOMvcoBObO1aSXmIIYgAbWraU37Us8rJ5mQjtCvmXPf1QY3fbT5eh+5J8D7I2BokUL4OxgiymVyQJrtyQNSdHBXXmoVh2XAODJF5BXFNaK0egfyQvsALFZIDZf9e3L+3Lnox2XNGpn8mnGGrJDAKqFUI+HHT/96JKjkaTm2n7uH7NhxAvKotsY45M01o3VKFN5cAfvJhBEx0HbgxFH++GraRqcblb3OYi/Dbof6kM5FE0q4UB7eNWE/qU1BjHJT3v2uY0Kqnb9Rx5JzhikRU/c29IPvCstdGVMOtERn9xRtI4AXs/I9m1vyNFUPW8XrU03Hh1tXiat5SIGV2a6zA1o9MoRTdpEQZAG1jWsvhDB8isD3mtFxQuZnXBdh/9SiY=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5T/vAJFkNflyokprTqDtP6TjXJOdCuSr2P4XYwR55pTdjM2tc3H0NsJVA4zAPFvRp8N0ktY78zzPwtY5qYvGf8HaG2z49Lpuioe9skex8pfR/5kViq3aT4eaIWaWuecprkg/04blC60Y/k6c4z5zzfpu+3GFFdNljwBLgc28XMzheZQB4heeAOBV1jGSzSTk8lVYVm8Sr5joaqye91DvcRWamsMgayDpK/ujSA1wwqi1J91D/+KeoaawCtWg75vrA3jujuHpFrodzIHgT5oS+BEpEms1YGDqg3MNErLTq3SzMcS5saIU0lUL5UlK7950foIbjkxhDUSU6Ml2FCBMQKdKgutSFyWz0tlLMM1t81RnBJht5k/ISZsf+DpBMmVD3uwTFV8ZLi0dEfN/qrV6F1aIaeqUUCoa/6a1ewJ/okOAHFRGm7nvC2MHUw7t10il
X-Exchange-RoutingPolicyChecked: LslBhaYntJ/ai3zAw0ir+Ux+Vh1jVGHA7LwnBOKm4VumSwA6w5Vtk0cpHm32es4yBpMlhcP7vN8Kemd5Qfagv7sEAuUcC4d65uE2Bpu0j4Z7XnclxzxlenHUPdtRDRH/61vr++Fyv96PX6HWe8mX9vrTi6AdZb6zfJvhtk3sGnW98CB6QupYT9cW8coXifE5INEqIPsf0ZzXtbQKEfJDk7x+L1F2UmEYXBhmEg6N9JI6Y7F9qqyBRyTQIoNk1NUauLbEkcGeePkkrdLI+994oq/ej6y5z2DzCRu9IjU2+pyFTFakgglb0cTrcS2lR0OdqPleKyo9zktQlLLlDfH8ng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yGF4VFF9DqE/fa9TNNt/3K9SmbJt/9cNUwFjUvz/30dBngHdPcEtMhoF0lvQCizLhKRy7XwxXfzRLDHyG0zp8mu94Se9eh/Rq00uUvxBMAewMeADg/sRYGFmPc4/d7EL6j/R2mE3kM7/lwmAwRWZhFKxagFa2//ly3IYYEPTzPp0/Y6OLtZSCyBBwhoG/SNb+On9PJQCFGR7tpN1bYjk5QmXDHvI4xQus44q7pyjkdhN78pdS6nXauv4CX9tJBszg3Z6LTRaO4pS/b3G6EW3fo0vyWsansRzLBYRUx1O+QQqahAT4TYIhJSyDGwn68LwwCBmVvMFuj+PT3VIurbIQnDHzi2c7cHBwXWpEUToXIW0vBRRfKvWa6yzSWiVjt9VOYf2Xmmt5m+xds1dz96yAhptXLmrEDQWB2y/7EWaGVJnOa8FimR5zze/JjHslCTBndTvKqe7qKh0+rxtQPW0E3XPKvyXTWX0PReb805r8s7k4UMbow1/v99ONjBrEGUSlRcHHTh6ZsuDsCy+kPPYOAEI3Hdj1vIcZ1j4sL6OBf2PQ0kZ98Q/KcWK+/ct8to/IedHRz9pd5m8Kt5AaMTvkmEAkJMIPnr1hulklOHGJacaOWUrbjJWmBIRUoV5ZQvOXGgcg8u8ANwiyu2cG7tKUQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:57.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cf3905-d5ff-4598-7547-08debd34a75e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4814
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfXyoT4suZOXLVR
 +XeDpC5cYsDYY9s01wqAejh5LiEHDe5kxtNPwXkO9De/BCZfEkMWioxwxJn3G3IHyw8j93ltS4z
 OxRea/16dQovHrLrQj3YW/J14cs4nQ5f2KW8cXjOR2kJfdsueRTX8Nod+KD5WjWtC/xGA25LaLp
 XjUiR4G1VgUeucdgNkE8d21y40NmyXA3g3oaZJrbcxkLbt8tTriJkB2lts9UJ53RMZ+ORqtJmWB
 T+Vo/9/FNb6iq5yRT05FiJy81JY6Qe1n7TEEavL6xjkfnntgCeawVu5Kev0JWwLP6mBxzKikqYJ
 pUpneeoh5u1sZvrtcT2Fv5bbKJF/gTNbmOzk01tqP7Cu+kwXy3TXFQhBlLjqWDCuORzscyMOW7G
 5vpqyOYHraUdxQpmqTKOcopArvkxk9/ryhU7Jwq6Ai10NNOQ78tVYQL7fgcrNTwswci65gpVWtd
 nnjnNWf1STdihy78K+Q==
X-Proofpoint-GUID: JIjIXxtTXfu1iHHHWvILsICOr1qpEawB
X-Proofpoint-ORIG-GUID: JIjIXxtTXfu1iHHHWvILsICOr1qpEawB
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a190bbd cx=c_pps
 a=qV0RoXYxPRq0QxHYvE7eUA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=IPOQxGYqeswESv_Pzp8A:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
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

Switch to x86-64 QEMU machine for NVMe testing in the docs.
Also, add `format=raw` for empty NVMe disks QEMU command line.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- n/a
---
 doc/develop/driver-model/nvme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/nvme.rst b/doc/develop/driver-model/nvme.rst
index 755181331213..0e0624925e0d 100644
--- a/doc/develop/driver-model/nvme.rst
+++ b/doc/develop/driver-model/nvme.rst
@@ -95,4 +95,4 @@ Example command line to call QEMU x86 below with emulated NVMe device:
 
 .. code-block:: bash
 
-  $ ./qemu-system-i386 -drive file=nvme.img,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
+  $ qemu-system-x86_64 -nographic -drive file=nvme.img,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
-- 
2.54.0

