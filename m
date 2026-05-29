Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF86CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B568487F;
	Fri, 29 May 2026 05:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="eqbSOGuh";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="YMRTjdID";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="IDzuBmW0";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="KjRUJHaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A38F84839; Fri, 29 May 2026 05:49:05 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CD2846D0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SNsjmi1929743
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=NKn
 dge3WGnJ9yYucY7gkss0pI9vtiWahca29Bq7mqz8=; b=eqbSOGuh7Yl661wfqg+
 fo9psmiOTBUl6Bx7B+9V4gZd3EXmDrb1DjdtQxovcQMA7ZcEOMLboGDSIq3r3Rkg
 W9XOt98EhLeuSZfgzarV+9bbKGC1nkFweESr1gtj86Dnlw43O9FYxNLyDzVqsu47
 cyWDcw3Qzuwgwbqbwc2eMgsJPxsrzlepe3+I31qhkqQ+bAsok4AXPYmN+/dSXJno
 S1gQ0lEk0Ok/BV4w4eFrUjFiHZ3Tp0YfIWmjy3cg/bXfjxq8MTMYbBmPIGFNrTTw
 oQh1iHK2O58kg/3mzLsHsCZJLgYy7V4z4v8/AJ4eTqRqAx2X/w++gryNOpIDJtzv
 m8A==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by m0482516.ppops.net (PPS) with ESMTPS id 4eevnnt41s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpA2AdZ2iS38GynjUQStVawz//jkVQ+2HtzhBLbbzBkup2Kq32mKa8DH15fwaA7I82CmgHiBE9/GJAFcce1rWsYVdL5YueZ7LVmbBD6ew52B6omsejg1p5zyflHi2Ed6pV70Lw1xX8jT90jepO5gI52REj5pnZ/Njev7pKW61iWwtpm6OzcKHTe14lsqiiGEkjnykUpg4xq2CuIbkRPyexxHzIYKW236cbbgBBzIgYMKI7FmVejhMKyXsH2TLR65jrUnlzgCNFvGIjTNsYYP5s4slOxjKBtzIeozuJUca7kjsKMFRSWnxFhZAMgckv4p8nC+UJE4yHtnAqtSLqDGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKndge3WGnJ9yYucY7gkss0pI9vtiWahca29Bq7mqz8=;
 b=NmwXIOBX90yKo0lCOud7MahYnms5QrqIKDrcTkQUHFZDBJeGo2lXA6S+2BxRfiTwOwMpRW7EgBAe0+YABUw0pL7N2J0tueKVWGV6bo8sGk0mF9c6/abIcS0aGldH+PveqG1/sDCoTcC/DJDB4JPcPBcTIiHKNeFeA7hysBx3/oajHYoPoZJuEY3TiSobiwb62AvJRDrCf4Hs+5sYXyE6ps6cNUQBYUx9iERWcbDR1c1CuHjO56LQSCSHhO0clHIwYUh65w/wv0JjDCIV4JtZJCQZORonGpB/G/+jEm6HLF6qdPov5vkG5L97FiGKRX8VxY6ZRR3MQxgWfSk19p0YBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKndge3WGnJ9yYucY7gkss0pI9vtiWahca29Bq7mqz8=;
 b=YMRTjdIDtNJoqZ5M2+E5i3PWXxwrvk9E2k9wV2qz8FYhrayljrvBxpKed7nWSgmTN/daefCdme/ZUvW+aHF8k1Wm8l9q9QW2B/lp7189CXEFnzcC7H7NnLPW6hYengJXgwFxPE259YYH12e7hdDoAhlQLN7Udc0F3JVUY5F2O0Q=
Received: from SA1PR02CA0022.namprd02.prod.outlook.com (2603:10b6:806:2cf::29)
 by DM6PR16MB3734.namprd16.prod.outlook.com (2603:10b6:5:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:48:56 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::49) by SA1PR02CA0022.outlook.office365.com
 (2603:10b6:806:2cf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 03:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:55 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T2P68r289916
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=NKndge3WGnJ9yYucY7gkss0pI9vtiWahca29Bq7mqz8=; b=
 IDzuBmW0GuDsMZQSWBOdmaRFWgI/ReIcEcW+YuRsEg0GEJS+7gNlJD5r7FPBWwvu
 nKmo3hyr5KyPHjHRHcqcdbaTA6qujRmZY40BAhtrXQihAwX5K570PKG+XFNMOAte
 Hp80OOauhFZBluRYmD4yXsk9/6RzdKrw0tifm3Qwo25AwCFVRvQTYCIHN01B+9sa
 Z/G6BKzayxQOVsKxPZ14aoVnGJOVnkxsQGz+1M1jpnPFaot5j5rw6ddmzvz6ZrLH
 HvXS8IbBr/FZ7XzyRXebnhROTN4oJOVm9ZJ76Ix6yIOzmxlP7TDHqrF3B1dwnvGC
 uOrmNKRqfZfaOsE2yA3uAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=NKndge3
 WGnJ9yYucY7gkss0pI9vtiWahca29Bq7mqz8=; b=KjRUJHaBNztpibC7ivApKvi
 2FBELQKszAyVqBFx7sXewhhaTJfSih64J3HSEXqpt7M6wp/TloVwmnWn8rZsOSQX
 U9aZ9bIZGOSJyJKVSsfpMUTYW/SF4/0MSpiHTZAi4/jMjFE8NcpH7+2Q1ImKz2h/
 L8k3HbcSaeU/CKKfrZM6OMjQKwHL5LNXXes1FkveXiIXfIqaXoWRjVtASJzWmMTA
 jk0bdv7SqnKi405dKN8lYVU82yIlo8JcpcUau3xK1jb0oZW6YhyXdN/2W0JLrrSL
 MpZV29ZGKLQUQWI6n3bCihJ9oe0JbR2oeP9ZPVwNL+uSL4Ci4coSNCDNzaBk0xw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81tr7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:55 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id SoDOwgxe0EF2CSoDOwGZXu; Fri, 29 May 2026 03:48:55 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDOwgxe0EF2CSoDOwGZXu
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 6/6] tests: reset: add cold/warm reset types
Date: Thu, 28 May 2026 20:48:39 -0700
Message-ID: <20260529034839.2075806-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034839.2075806-1-dmukhin@ford.com>
References: <20260529034839.2075806-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM6PR16MB3734:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e77eaacb-d5ba-4154-d71f-08debd35356f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: BB+HFF0vR9S5d0KHxAj0LBiI32b/+f/8T+sCcCL7p0sDbqQl70PCgT4Ev58sWNWsHGAKTn2dqLX6xOdilRiTYzd19WFXU8d/6nL5L7eEO9ujgFS8DLWngVpBf3odgByloCE8bi9UCUtFIuWN4KR5j0hacjsaAcLRzhoC456KOg+QCAIac8uE0t08Og8mis/SFJwgZK7xvcqQ8OM+BFtL+FJBRqPynbOoU5jnNKX4dsLiDhpVaEYnTveL0kMgoqJHXR+X3fNoCdpXYkXZUGj7aPpd6k6qc1qWCpv+ezJqzD9ZyGve++Rb7ZC11bfcXmSk1tTWJ34meNDLfXQNVFw2Empl7YnXjUgoLjGuE/OEOOFjxNMZyk6l7LQqgvtR6I4/FKcxvcU4RTP0CLniz95ESdU4eyQUDjY6rB9jRo9H8Dy1w3b2t/gTVy/bTbLHWntFXhNppq3bi2lPyHL3fiRxdpMs8cxPMKihh/6/m3dbdI0QkY97E/meTooVlXKq0d7xzK8xBckgDrHxaned5FUN7Or71PTBgXn85wRPs/bkMBYpqJi+5XerRXGMyBiyPntqxKm6M/FB0Zj+tPOobkg+M0GfM6DRfRF35QXYncW6MmOAOgLhLGws4IXR1oToqwHb6oYKltpzjXZEVlPIVMs6dsBb2Dxg3q0tGn8YeoduzL5yG/csR5lTkTSaPlbG+95FWtr61tlpUA5nQdT2ox8tv4SW0mWv9gssfre+oKkduww=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jCPM8lz96otDsWhsxRF1VgFP2GYxYAJK4hJA2jRLN56IqoNlLArjJIjj9W3vr7dZjSObGR4DRGAnDfwHnPpzF+n+bsNi2oEd6JiB9IcHzAoOAzpMCuVPBEUXV69rV+uozv0RcpaWs3zTCb14TILQMIP5T7kBcycDLkfHTy5lZq18WWfbpgSAw5QG6+uUm9nejxhiDeCDRi3c8ducRopvE+vwnbFbRSSZ0NlRxZGrn4gTF6s15QR26AoU7sn+STboy1IVXgUHBVSFhoYFUSwaR/iLXvbTqdP/TCrcQLlQ+zk/4OTVsUcyz4QySBBWaqYfylZRjUtyWI5j/xFwuSNQ+chOiEdOTmSwugqSR/v0fjlOkmNdkY35s/1jQ0gv7PVRCW3LwTWEU5Kpw2nf1O5LuafThcXTtvdAImET/6c/icUWvVBr7OSADaxRW5/4TG70
X-Exchange-RoutingPolicyChecked: pUVB13ip0JPGmQiyfTJArXf7sGPcZgBcrgx/Q8427tFQ8rS+fE79s7baJnSv4OLUHNMIo/njjaBmKKr9zUwqzrd0q87RoWgYfDxSQ/scx6p+Mr+ddBC9wknB5T4GZlyH5/GAs99lWaiHijWCvT5v8JrrvNYJpAJNlulWQEQfEwXoHwtTcz5V093KHKTgRILXnQeX1TXV7SVFrxd7zz1tJHZGEh2muPq64Kq60eJi/e+pFUkS9qUMLEyz8S/cTBoTwrLRjNRAVbU5Mg4UhSeJyLwmrYGfBWMMtJxa9GxsXXfT4pNHT0tKYWIuYgrFW4IqhZp31YInCQcOfpV2xeTs9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NYIpX8FherLyz0NUJ8M7p/dhcuW6+5cJSsmwD7eIgOnWDEb8f39GdOKB8VdslfFnIcC04YpbMpx6vt8IhMqHQQM6awXJsCRUpLdWhCxRP5Ffw0J5p9Hzko+LJroXnHlYHNjObnxerqvcPVMb6v7oSMxZvktmzeUXP0nO2iP7of/nTZLMOwmSJK0THHW97E5FjHeoVv3enOkeL39HQ7mmTxsb5uEeaDuFNFYOleKA2CBC8JSj7iQvN8X7l1uuKlRkTgBQP/uAAAK4rjbCz7MvfKMQMTgpRxCJrRykeEpbZP9c2AXZm3bCQOPjCf2/4S+j0VJPBCWiJSyjhua7ysFVVSlyEzu6rRPcM2dp+Ms3PO5ON0DkeEzEIk/XftAJB+arqUgf7q4Od6Zfoi2FNweEpIUox0Yi9K2yg7LCcR6rBtztrsvNd51XSqMndXZoJQFxkfVyQdD71mAnUknZwDt7s04VASw2fbjyctH12rBE1UOLA1agGt83CC0BGiQLCAQDx36WGeUFf3oD9Ck5ac3VXZgny/B2VpcHX6fbr5aQ0wtqQupO+/pC4DR+k5W2Tgv6HfUSUWtUV5vaty5MEM7CtVVeJoQ0R5TnMCH+njV+w1XzELenhBhcR2B5NTllKBdF9faUkdkx1FLMxYORfK1PNg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:55.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77eaacb-d5ba-4154-d71f-08debd35356f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3734
X-Proofpoint-ORIG-GUID: m_0uBaj0DdMSX8DkbxU1tlk7oPqX9Wif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX6xIay6JoUlUf
 cw1tirjoAIBV/jMQqxXiIL7huquueqjWgXI6pdG26+ejEgl/fvvWnguWWkfyT5HMahbIyjrX9WK
 zvQmjSowliXEHS2DOrPtnjm4EB0ekTNbks6rtBHeGjaNbajctNukVKBdGWBKLylYfVsJod7PbLL
 EBdsu0TdBvKz8KkZEka6SJ13eFD+HqVU4xU3EBNEhsvylq+Yp5A73de62VbtmHNwHsLFz/SKyAZ
 ZUIqpchTy4FQD5ADL+A0rZVlQ4sVoVZsORA5ECCvCiU8qY+xpCxEC449xYCf9yKBi6DhFSoI+La
 K6RrBYJgflWD0rXK6o049EtPC8G3oKEsrSHI0H1FexrMonTs92NIdEQg2G4kIphiFb52+wTRT0Y
 wncwHnMistSfsaT47CQm2tJJj/uACiJV/lDKuQD4xgZUAjxETn3a0TYcv1t1peH3J159YYfTbEU
 BP1NrTZk1YuJtgZgsnw==
X-Proofpoint-GUID: m_0uBaj0DdMSX8DkbxU1tlk7oPqX9Wif
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a190cac cx=c_pps
 a=5XLVA79qUcMA6Bnn+7FYtQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22 a=cbNQJ9GKAAAA:8
 a=cSHeqpaBJNz1K7nbmfUA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
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

Extend reset tests to cover both -c/-w reset command flags.
Make sure sandbox reset tests are passing.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- dropped sandbox condig for pytests

Changes since v1:
- new patch

Test for sandbox:
./test/py/test.py --bd sandbox --build -k test_reset -v
---
 test/py/tests/test_reset.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
index af079a706647..e1037c963f77 100644
--- a/test/py/tests/test_reset.py
+++ b/test/py/tests/test_reset.py
@@ -52,12 +52,12 @@ def test_reset(ubman):
     test_000_version.test_version(ubman)
 
 @pytest.mark.buildconfigspec('hush_parser')
-def test_reset_w(ubman):
-    """Test the reset -w command in non-JTAG bootmode.
-    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+@pytest.mark.parametrize("reset_type", ["c", "w"])
+def test_reset_type(ubman, reset_type):
+    """Test the reset -{c,w} command in non-JTAG bootmode.
     """
     setup_reset_env(ubman)
-    ubman.run_command('reset -w', wait_for_reboot=True)
+    ubman.run_command(f"reset -{reset_type}", wait_for_reboot=True)
 
     # Checks the u-boot command prompt's functionality after reset
     test_000_version.test_version(ubman)
-- 
2.54.0

