Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F50CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8145F84671;
	Fri, 29 May 2026 05:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="beOC19rB";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="ONJynrRs";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="ajoPdOWh";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="rNqDA59p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E21846B4; Fri, 29 May 2026 05:44:59 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF608341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3U5vm2121900
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=b9F
 EaanzJnN2woNSR9uqZmTM9lZC/MkNxvpsNWhE4aE=; b=beOC19rB2xCKX7N3CiF
 L76Eq4WGDlh1gqNKl72neSrij5O8HM2EfH51vpq0Om7qazoS2RhrcIIWg2p0VgdA
 6z2Z0iC8iK50wMm7aBsYmPvNl8Pyw5gM3tJrcu4h1e1yH3XzpY827AQIpmIAfEqw
 0YzsZ+2WJZ9GLXQumpTG817mo+zInzmBIF0cSGazZln0NUwuiTcN9tSsZabZXbcS
 7ClvmOpiFLqwkZiT5peU9pEoSJeH7I1rFUFX14NtMINj/dVXMgKxDn0Op0DLCpUh
 mjyazbu3qruKHEE8MyJTXDNu8FXyxouzeewglc/zgZ0XIeaisgymgf6EaNDgfQsx
 JmQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2xx8236-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8ltjlFD52yqOX8pIWJHp0VgtnQVzEi/k1+xjp/dt7NZjK4RCz6wCVRzNTMRjnoO8tlxrosFYorvVDa/r4MIrgVbwaz9/F1aCJ+ohf/D6Of7xhHzAK9eqcv67im/CMXzYqwEblTrf8JjgZgKaXvw2jWpV2L/YbtoYZJOB5NTVSHImfXEI+NLrpjP5PbCTa0+uSt0TdTs9X1yE9s72T4rr2Db2emVpX3F5P0tYnAMSaS7cogfV/HRGj5B2uF87CVX52+JSPW1h4Yjmm/zoQw8y/0mSk2wH2My+jGtMfQLuYOMO4hLRrM12elXl2sDK+yKXBIwrXU1MZVfT6NGlsJqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9FEaanzJnN2woNSR9uqZmTM9lZC/MkNxvpsNWhE4aE=;
 b=oV5mOL1kmpDsefuiMNdWIXB/ZnELb3drime57ixZVeX+C5AyE38JEOpt14Y31eJyzL6VKgxbXnVTm3+XC2H5uhMsAakd38WyPeuKtcWzd4rZ9002YxKOIrwg+snidpRLR6M3aHlCHxFz8EpAWCv30kQ1QZjYgLUyeNnvumfk5jCMM+tOopO/fNoWzSH7zH0E2wIiJa9jAFJreoMglPsuE32yUOrohpUcvCFVNdAMUcke26L83aTJnF3IVM4a2sVNerAIedjKMyYwmUXTHUmAeUgnJBQn28EupU7+yzG10dbycQt7qFlxGOOz+JR/DuIRaMvEhIpclCb4/QH4sRy79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9FEaanzJnN2woNSR9uqZmTM9lZC/MkNxvpsNWhE4aE=;
 b=ONJynrRstwNryZMSMkBnXJfrGhew70pBdkoCpPYBhoauoLRs5XUzjUKBnZW2KKz3o/mTxDxyVJfUEZjir1oryj6nxFfcw43PwjWU00BIzDXwJGoF5RswvGozgcsSjp7Wl9h4AUN6mQMC8z0Zz634Bvr3Q7L2vyE/PUu6jkfYHGI=
Received: from SJ0PR13CA0140.namprd13.prod.outlook.com (2603:10b6:a03:2c6::25)
 by SA2PR16MB4233.namprd16.prod.outlook.com (2603:10b6:806:147::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 03:44:51 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d0) by SJ0PR13CA0140.outlook.office365.com
 (2603:10b6:a03:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:50 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1MFcp2484454
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=b9FEaanzJnN2woNSR9uqZmTM9lZC/MkNxvpsNWhE4aE=; b=
 ajoPdOWhHV15ZYHag1TUC9ZWtzBfSGF26UVKK/EK7nN+LVWkLuwu5Wh1+mwxO1LU
 f1V/N2howzxzvp5dxD+8BaFReY8sAKSg6Yaq5rmxhbJ/w4yWMu0FmLO/Xq5qAKSx
 irrqQFaLMCrTRWMo7QjzPDw1u7vIdeqQQ76N+U4yuG37vgIG3kKeayMV2wlqiSOc
 IMzje/blIwCdq6bZCL4FEr+YKOvKTOzT397Mjtsk/omw8bvOBZ0NB7ZlftveD8UA
 ORrAg3AZ38jhEkHO+e68CsJgoWwD8U+tPuxPrE4lNW/ZOxGDnD6fYo0RIB+BsEgh
 aKQHuNOFC3MEoqHcIVkNqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=b9FEaan
 zJnN2woNSR9uqZmTM9lZC/MkNxvpsNWhE4aE=; b=rNqDA59pJ08iI2n1wk+FXtw
 DW62leuRmuHHIPom1mkYNEOuCh6HguMOdwUK1EebRPHpInnTZCidGlDvKSuf3O/D
 mOEHRpkkckyrEppHYoaCWAp+VmSyng/njHKC7i97XGxGwu+t6I356TX1nFW8KAAf
 6ZFRCI3IOF0higpc3WG3S/cW/IVDkg69PDns5fdaf1LGJSNYT3EZn3QWayFyZvh4
 LFhJJdrdXp/WEB6q7qsXK8v9wVhBhajHCtHRMzQJlUJ9Ie848bLjoMbaDc9HSCV7
 MbpdRT39BBdsEnclnwmYpUlQSmgGT/LmVRrzsANQ9i4+ORhmZqKciQiJUbWwQRA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x7ster-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:49 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id So9Pw3HDpbrKTSo9PwL1jb; Fri, 29 May 2026 03:44:48 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9Pw3HDpbrKTSo9PwL1jb
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 2/6] drivers: block: Introduce blk_flush()/blk_dflush()
Date: Thu, 28 May 2026 20:44:37 -0700
Message-ID: <20260529034441.2075305-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA2PR16MB4233:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db2aa8b8-42fe-4a24-b043-08debd34a363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: r2n6GMLbktsWn1IOT5YIGvJcl7NYZy+GS7HiJjvlk1u0o3cJ7YGcMegysEyl+z36Vxm0ZTgObG7VNSJlOWXwQlKtyDktmSE2t45JjMAjdqke9cctuJQPHym125WNYnn+hFmK/4VrZBJf5NN9eqKLeeJ5Ci9gPDh0LI7vvLX+3myzw793GA0px3LS0utG3XkvGSB6e9FmddQFyrBOmpwhjd6NkCb9DSWOIF4oYIR/m7dwetz3kxK54us8xAT82Lr7f4x4NG/7Ww6MIsE0eHNFy1TFYa2Dl6N/m2+LnkBY8OJgZ23KdXjXMxH3qMM5nBk6Fr/j8p/zGvCBjrB2jLvsqillR6Vxk0+uHSl1cNriOcqc+ZIHuzV5hknxhbfqVda2e13dMttoMV3b69/GDqHSJDNr/6+qh/e3dmCNCIIA/HfGItOeOH7oXHKrHrSa7Y4lgX6FWDst9RdPaTyacg8BSRnGrIKsbpZ+IbbO8hpuOg2433vIRXqUVl3sbvfD6bd0fmJRONdxqXMTriNy4COPYh51XzhQFnoJeOoTIyd8lKdgFC7UzVCd2y7C2HE4qNn9Cig0E8LKoHoCexZK3EGjgBTsbKoR3SboFMd4UlNTSQnf4xh9ITXPL7WzIBHYcflOKaeS+yN89iZrvHwl5pBQSaOdbVpMdzh2IOhPpAtPQ6S3P2ZzadH+eyGR/GGp1kh2/vhhhIH8CzUhF+rC6XNx/HOCtzae6n7d6kY76fRth5g=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tSgekN8KCdGXjvUQbxAk7oFC8DXIrSQeJfcwRWCeOx18vI0dbHpoShBXOlwPWurc/l1KI9RoLFPTW5BQDKHV3NFOYZ4zvji6zAZM/T8RB7Wl0rMU61fhPK8F6foCUoRAxiUjv19Bjq/Ffu/uOs0nAnUpnDs47cMDmtJgghHcvdyjJymB8DCS7fvl+MSnSqgdAuxvi/PKdF4GNldmrJVI/JbeoKEpSP3rF5JCH6L5LvRMOCV4DSPHm+bG2dsmFEAQ0ssx/3QUouPKPksws/6gZHAdPfAmmvmNPFas5g1mMl2eShpAEELCFb3ajPTUSJ7AeooJajIoafw1ppU5RMqpxB6Eugso7URQPTOiqIJLqtatn+vtR7or87SedLfgUEzi/89WwULRoe/IVDTvDuEG7FbHycq1G21+xLSkdQ3AtoDlaS1SR79DWCAQJOmHutY0
X-Exchange-RoutingPolicyChecked: TzFq5+JLeDc6mjM2VH+geB4OUBalA0dgXNv43XqvfK8/1yWIt0kb0192ejN3iiER+gZ65NevT0wmtFA3JMOTS/o+M1SWvTwZ/2sAiS3lJEzJlpqo1pfjy2qA1Pp3GPXra1+RGjAtNptece4Hu1oJ2J98/UL+NsHFqOzGvHq9DLiA+Rq2ID6gsALUIkj3dPg947uOPdMBYaF8KvEXKhXj/Si9i1bCZDbUKYEGn2ZjL0igeM+3Pe0vBRmVf6L9HT14lgl1QGI5VQHKPtQrPWHQD8gu3Bb9nA/gl0r7HOO4lXd/6+yPsiK+kiVRllm5fjeS9o5PUsHb/rKZ8LfjySsOMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SJB9ma3B00CoS/sV9iT8G0aGcR/NfMZWf6CcCXGW5fZXvvA/26ry7EqBheljzBe6hQIxgsAyaOel0gIxYq7yaUvrJuWn04AkqKL/r63c98GoPwsKQ9tw0dAQGJ/QTJThJypa9a2nf7K1MAER+Xks0cD5Ld7/VPzksVX28Kkpw4zPKk/xm8uC0V84c/RrCzaNoJcOiFIyDCmvB5HcFCVc4omDXQJK0szod+qnKNXPLKwHGx9o5J3VIsVXxEmSivrLg7fZWSS6Fs9aSlCjoebAzhEdzcTQklg4KlBTJV+R4Bbo0ECyXTOWPYKsbymSTsHmtz/Ij2e7ICmIJjVfY4C0EwEWJCHaI89Nobd28U6jYZ4U5G+Kv3HqFv12G0Mgdnpe4D/A9Sl08GINZiYyIKD3PSzh8VT8k0dNt3lCZyWyePdUSJKzrqtekMH2TN3KPqNkCiOo+AIzH+PdzlWoZjj0+ikFwJT4TX8XKesjTTnH4oVOCqNyoGoIL3xPM5bqaUMtIYbZEKWcQW/UJzABEhhpKMVh++JDAWw0agOPoBE7mg8GIrqQdV/65eC9dKS8I/Y+qdARmjaRETcHzxtUMw4wCW+OJFIDVV73v7PHsiolxucZTtCBsGs0Kfxj6ABqirqXjJteGqSyheU0AAnhn/xr/Q==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:50.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2aa8b8-42fe-4a24-b043-08debd34a363
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4233
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX5ezUX0qsNpoo
 hByjjCM8DNvX3Nz+f/1QrnrCpePtoBSChMJ+kfZSyiBvsBlNQVQTC1KfAbuK7ExFI+yzmy3ylbT
 NB98B6dGRwbgIu3Bd+f3uN4dVWqXRrOi/He/iGYjWhKbxeTU8YFH4M6D/QnecUyfyFLGZ11t9DW
 ghPer2tpGbXgaSi14XlpIRkT6lALXUNm8Qi1bgUBdhdmRYFsajD91nuZikTQz0jpqLgprSRkdv/
 8WmEQ+vVUpFj6PuSKyEzK8okAkj1Ynt7hvTfvffYHaBiWqv+mo2wSOT0Tx+8qCRU9aTGIxxIDf9
 eFmCP0g/r322PB2sZkqBEjNMVGvUNZlPILSYDNjgJn5Pe6qzDBOG0v3/yvi94GZs3K8+JQLtQDI
 lgsXci8KyPWkwUYpxKSRJLrQOXALveGJaRqNvI5pSxN2NtJjyOTPTLl/v1UAIKpSobidqyT1qEh
 IGANMfFDE1fV4o0mfOg==
X-Proofpoint-GUID: uuq9X5BmGreGbeNslnmrJyl9k_gN_ozK
X-Proofpoint-ORIG-GUID: uuq9X5BmGreGbeNslnmrJyl9k_gN_ozK
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a190bb7 cx=c_pps
 a=qSo88s0AsKk38onbse8luQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=Er-RH_x7-BUbe8YD2ngA:9 a=P0bj-C3X3jJDpopQwM1U:22
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

Add generic flush operations for committing dirty data to the storage
device.

This provides a common block-layer interface for flushing pending
writes, allowing callers to ensure that data buffered by the block
device or its backing implementation is written out to the underlying
storage.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- new patch
---
 disk/disk-uclass.c         |  6 ++++++
 drivers/block/blk-uclass.c | 18 ++++++++++++++++++
 include/blk.h              | 28 ++++++++++++++++++++++++++++
 include/part.h             |  8 ++++++++
 4 files changed, 60 insertions(+)

diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
index ee3cc4407d76..1a87f7dffa7c 100644
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
+	.flush	= disk_blk_flush,
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
diff --git a/include/blk.h b/include/blk.h
index 8d1b70cabd31..98e1db7a58f1 100644
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
+	if (!block_dev->block_flush)
+		return -ENOSYS;
+
+	blkcache_invalidate(block_dev->uclass_id, block_dev->devnum);
+
+	return block_dev->block_flush(block_dev);
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

