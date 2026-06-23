Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020F6CDB46B
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CD6849E0;
	Tue, 23 Jun 2026 03:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Qn+JF8fT";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="VTl6+PTf";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="MSPQ5uNa";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="TStQOmYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2E1849BD; Tue, 23 Jun 2026 03:49:49 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D0D849EF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N1LP2U3947287
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=B9p
 M50lkkI2IJ5b6s1mSP44YpmrzA228pYRWinZpRQc=; b=Qn+JF8fTpDwO3n95Xgl
 DXIR6HRVHca1Wa/aww0pcQqBty3dVNESXniBs8Md32JGgsk2CF1Wwz+2FsBPIFKt
 YZP0P//eVlD2A+VvLsF/fBvFIxMBKqNTo5k44RC1GmExhw/mDuQiISVlvl2PQaK6
 f4Rj6CJ6n31Wp+mFDD9Gz4FsHJTfLpWhKh7AUwpL2aKFkaQuIiR15bvr78+lXv5W
 ANfO6b4JV0e0C7ldAlYcfwB4DHG8Tm1TM6hUuNiU0GTdssNKySeGwU8NlyPFzAJR
 x27U/qlAn+0qB9j25KXePRmUNrnMnL4AChkTBp0vXR4HHz1xktEHmZsO5ErHybAz
 q0w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eygdmr51j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/HFc0Ei84BCUuRC3GHxGDS/K6ieX2iRCh21JKZguzOnwEfnAv9Gq26rTIFfE7AOKOi13QUvgjegagA0+YD5WCHFYqt1oTLNknSmsnm2xCMHisgxHitpR8c70Mm4BFdMFE99Gh7F46lR2DApVp8n5+jTK8bUSyRQpXuiXymxJIqI6Knf49a5D6DyFGFZlFHiniCVdLrRq4b8QUeNyllHtY7dHjndKbz3GK1MedOF4Gb/fG/nUNFRNw/CLz5GZlHoj91E86T0ZrXpUKCwL2bzm1rjGOBgmiDCrtE/c5annRTebuc1YCDwJWpA4BdaU7u0dkNA223MlH2xBhlpfzZaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9pM50lkkI2IJ5b6s1mSP44YpmrzA228pYRWinZpRQc=;
 b=ml54AMI2sSmkFIc7cfyFhuInS4/wE1tdK7D9JxjSfNHAp1TvOOtW6JDHO8EeP4NBdJbhV3WEYiPdJzUDM+i1z2xJA3f173T8uszj0z4qD8wjCAZz8ubckZkpVsojKefciA1vTBN5OlOmilx4s/4poIfOt02WdCh8TTdz9DQfoCy5y+tvfxnzYDwMc9+eRc2t7B3ekRN+7RWZUKMP9HCQ/XlIJZduQmNt/07PEnCtRP1R61lD+HS3BTuhewBJMEqvgM0Gicnxt47W7mia63h4mjzj4prAnaGzuP+N/Fy483AWXxqHVRIKt+k3/zL+jM94IC2jXq65SEtcykpF12hxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9pM50lkkI2IJ5b6s1mSP44YpmrzA228pYRWinZpRQc=;
 b=VTl6+PTfKaZItirykgs91jzArtQPje5TT6hr5h+H+n4MdODHGHJqrwcxHUHwULX28ftA/UyCa2bfnC6UB2mvakiR+m3G7HWrruk/2xNRmP/SQBSDTbq9YT5RXibChQvIQIla0lgIv2op0CKSgT8O8uG2THL3SWnG02Jx1LREMvE=
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 SA0PR16MB3760.namprd16.prod.outlook.com (2603:10b6:806:8a::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 01:49:38 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::70) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 01:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 01:49:37 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0mJvC3854738
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=B9pM50lkkI2IJ5b6s1mSP44YpmrzA228pYRWinZpRQc=; b=
 MSPQ5uNa7u8IWYsMb2CLVaWBhDGXMkY3tfqnrhCv8BYtQjLIImUk/GSANo/OFGG0
 jqNLoGbkBRd4sh4YsFWlBx/QexzAsX+kHPazCNKjD83I9SKbjWXkDngBP+8/pL5W
 VnJL4rKk6yK9FaW4M+xbUARshWTq9ffKW5Og07NadbjAHrDYhuqc68r+9HHfEBRD
 kGJQqMPVjAWGXDqb0RfwfTmFZGg1+F41G4shd+0kaBhxJDbwP75MDt9HyjdBMCkW
 dSro6XeBvGcTkPw53crT5DbxtMf0vPCpvq+Eti5ohvWdWpIvhMkv9KwbujlkZKPY
 W+bg77gOFqzEiIepanf3wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=B9pM50l
 kkI2IJ5b6s1mSP44YpmrzA228pYRWinZpRQc=; b=TStQOmYesoaZ367rH0qihuS
 uj/HCMHt3tYA+ZOHDvgCVHvr8XpNtuQtCSLzlJOoxKLi73llYM+W7cI5FkfbV8Bi
 fRmEdcNHj6pDvSDzmkCNgm+YO2ZagYqMHsTufpH+6ake5eiMFU0/IZcwF+0BPS6Q
 541WB5zZzGP9gDc3A1V2AUHIkJ0luhimkbaOyvKS4PPYBaUsC6Nj33Q7hjCD97x+
 9LIO27lRK838fZRfoNxeMLbmhtuMAeK1arAZ/3gA0vaggVWZgRaQmO3V4kkJYR3Z
 Grz4o0iI/a79Ed5XuolZMu8QYmZW8uB3dhJ8ti2Nl3PZPGGK5Taw8TDS6dxJtZA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9xp2att-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:36 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id bqGcwduhjFhvFbqGdwLQvB; Tue, 23 Jun 2026 01:49:36 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bqGcwduhjFhvFbqGdwLQvB
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 1/2] bootdev: scan boot devices at each priority level
Date: Mon, 22 Jun 2026 18:49:29 -0700
Message-ID: <20260623014930.2741494-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623014930.2741494-1-dmukhin@ford.com>
References: <20260623014930.2741494-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230012
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA0PR16MB3760:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecb6555b-cb3f-458d-d92d-08ded0c9af33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hqBzrrddeBtjmDgCHW5TaUjNoIZ5o7UYeh0NfveWTGL4wSs9Il2idHzYJET+k38kkOjw3HizIlt6eLOA7IFvYkg1eMZpJSvtRbZjwX6iY/IAjIow/zO/UF5b2Y5SotkUFF8KG3Nn3n8M+ixxWZhiO95WptBXGnORdtji/YHLWbKFwXBiAHRjNLHgj91y7NesI2DuFKJX1QJ4T4ICGPVoXd+GKzcoiKtmGty9D0lkpJ5kFTbFCs7jA3iMDqOptgwVvGB7psG0EHuvrbrtGZgFjhL59wq3MZgsy3gVF/0mWXe5yCg/+4BMp5pXDJQZBD44xy+HknVBdoxYb2zEAdL4qct66T+st+NQYCSf00eaenAic0nVHJTX/OlxUN4quYMg8FkDBCKFEibQq73Hb4qfhff3/gId8jh8S48XEWTO2H6zJj/9OU7AvBrUA8TmsSXJd5M6ylqGJYlSlqULunfR9mCdvaUvP3RJuyAlxlfWTxeoVLW0KPtKNqux+OhbwzUNt5WIWD9HFeKbC0/4gOc1hK+HAP7AYG3bZoDqnujjdPEQES5YznBTD4Fyz0ZVGQffZxVF25iOTvAeOGYsFFk0xaCFpwyUBwC6+a52K3F6BdUQYZeHqBQtAl4JxfR0p1biGUuaCiDxufEQUwIhvNknog7JEIzfkjgOqKahWBLbp6LH8mHgdlmkozQG0uFNYteMXBSo3RaNMP5PU3VViVMXlA==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LUBPme6PWCGI68PIpvCKQXWI9aD+Cw9ShlMjObZKG77ysaKQMZW5ZNc3Ni6a2haE541KhTCa39v5+Pu5yM/vtEadNKatTeq/Gpmr7xrUJuO6RSdswaZw1d8JBJW0GMhQj4qnAdcqxJiOvYtMMhyp+hUyHIo5L+kvLIM+NMW38Q3LHLSGndjmvmw/OJVzs42wNZaFyh68Gj/vYcajqNl8cBlBKJ0DB0pkAGF1tZNaEqOpQa4vWFedwvRb++w7GQl/RBHfMzGCJbX86ID+B9wb5WpmpS9u0W0WBklb7aPfgTxtxRBUB6R4W+asZCpxP2b5epesFHAa0CnprvL0aTI2JwGsGNQG+NUr9rSPEja1D0Uc4uZs3Gmt0mJStXYggtN9EgD/Pqx/y3MSS6QFmrHqK/qupo8Qym313NHqRlDb8L7K3Ye1FxVPzJMMGD3h6i4F
X-Exchange-RoutingPolicyChecked: mtvw+jOREdtw34NzHY1Dy4mz0i6kECdYscTeXWN/f7nIWgkSpfKA8blu/PovQTKgyiqUXM3dhCXEaSaOBW0G/NWitX9jLUYevaC63/NI0BxCk+kalqG+PhYm4hyZjjQbqhZnMaVDtAU/R73GSxUw0hnLzQA9xHQg5DoYvzfp1c+zUoWSVbkwpcwgVGuxRxB6CS/4cBd5rlzWGRU8Jr27+xLqBVVJZqLbgPR4Os3HUqEPxcyGaeLJYuRYXqPNF79sOTmbStDmRybY3vJTXnKRkc+eH1BLknxRBZLqQsX1yZvFtsvKAg6hJAYkBYrBdA5ydiY6qnoJ95Zu/nypL1+dsg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YJ+ETDl0iPUZWn6RJ+Zdj/+h6LV/nQgH6QD3PoX0t9g4ptzk0hhCx8JureTwqpGVNsCLdkn2cDwnK4QLb91QFJ/BrdBR6Z6VmSbfg6RXMStKJtTmJECGRrKQhaSyKtiodFSxecSZndmqfIn2ftaQ7UgoXHidyl0Mb1mVuB5Vgpjty5bA9s7W4tn63wEFAl8fxx3IbrE1btjEKAwiMUmc14yZL98iUcTV3wmKb1VUtxWxGAaVnznKjBj4hC2/j89aWZn5n6s/DlCLXaWHHvVeRtEHH6isjauHHMZC5Jz45Wgp4USwP6rPbYZPRsNxG+fMf9ul1V47G5SM80A+K4HYvmKt5VvGgUcmQmtNM19SS84wBLMpMU74Iw/J6dKWVZJ/0xHAyWGoR1R87uhlccnmh0nKn2cOk2qz6sYMegGaT6KjXwzTrFiitaC8Soo6Dj+JdbjDlN1rMHNCWKAJV5wicN8zx3LsbjaosEkE/awCNGFj/of3Rb6bZTkaee5ZbQMJbnYhGwVUfotxYnkK4c7ApMaEtcvEr4g4xiQWifwRj3tIEtOkW0i3MKUZQ9dSNHbqJsIvY5GfvpRgrrF8S5aGuPiO6J9Gdi1z9ey9LCd4mDNCvFL+gTy6Nd6Ry3d8cU8HFD81MiqCqhjqKW2tqVcUwQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:49:37.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb6555b-cb3f-458d-d92d-08ded0c9af33
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3760
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfXxx6ef5NtcoR7
 ms2vDrhg7btRrsoNo40JY3QPUaVxovfeRpvq5uF9hiAWLrkDKvJVsq0W1eihjcEDRXuHniCDMOb
 Pu1puX0v0kfFUwv815nRvwzzkSzVVQF5QgoWNsfWLOVkN4flhIzHx79h6oHCTNQlkjhEXz+1U9S
 M1VGkmrGuLEtIvA5M56upvocNe73FYotUKpIH5Raq1grSpRkBG5p6NTYDzHJBf5Qx4qUH6o4LZv
 T+8Vsq5aJaLk9ExhIuepBLPdluaj5pvRA3mXVyCL3ek3L+NqR7d4h/IszSvFZ75QyamG9wewAjd
 rVQQ6KFps3x9zWxEwIkVSu1ne3cWl7Gyiaecj3fLkJ+FWOGrdBsoJZKSUXr2sUllpMEPcsf8EE2
 hoJrJAetBpe8jp3awPiIl8cjrfuPbDZrTOosVMek85wR1Ri/OVVTNHxCcL83kcdwoP2POuVq38E
 1uT1iWoRZtvK2fdtYRg==
X-Proofpoint-ORIG-GUID: dVMgoSZGkRVL8ExXs5Vh5zIpBWskryEU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfX9HBieaqKFRbf
 ieC+LWQVXUp5rc7XKy7CaoAn1S4R9J+oo1XdHMd0ucwqmrYr7wunzr7salVSBBGertdW/BrjQ2W
 lQZ9BFW6EAZrnofuTjR1+zgwvFLnP8ecwwDNfJbBI2DJsHbgpT05
X-Proofpoint-GUID: dVMgoSZGkRVL8ExXs5Vh5zIpBWskryEU
X-Authority-Analysis: v=2.4 cv=cvOrVV4i c=1 sm=1 tr=0 ts=6a39e638 cx=c_pps
 a=FAljFvH9XqR9mTH/oaGbyQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=WioVj99LH3wGi_Uw6w4A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230012
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v3:
- n/a

Changes since v2:
- added Simon's R-b

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

