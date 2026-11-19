Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD360A2610
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aAC+//x3;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=L5shuLyz;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=T/K9vFJq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 396C160D8E;
	Thu, 19 Nov 2026 14:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1rURVsWz8Um; Thu, 19 Nov 2026 14:16:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0CC2860D7D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097808;
	b=pQI41ifHZ35g8zylVIss1R3Wl6dEr/8JHidUTUdBuBPrWNw8nl03kC8idNM4Q9wIVbt+
	 nY7qTDtGT8U9VAXPzRKimThzbBce1q3CMmsX930d7PjApFr8r12dlLRmeRzWtFts0h1c7
	 aIKwJTF8rbzizxLpZFJROZO1uhLdDOXa/azR9d9NXvYOd0kLMESUEhVm8AGdY6TSNm3Zj
	 cf4YJHjtp3I7GZgdKYPoIm8HwAKKSS0lmfk5v5oV7uiEiNzcUquY1/bEdX7bfRDGYbjyO
	 6j7JRxENKYjFWIFcNKIrwz4Eya8hrvnZ/A8UzsTkaCHeAD0xgNu1w/8mafkhszHUZkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 X-PGP-Fingerprint:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Hrfm76k1vwngeY/Or6kwCmyiDufaKR9joLC7vK0J3Zs=;
	b=kSNE8WBfJ3d2foO2qfsa0/eJYq0u17pDCAcrBU5+VPDzVN0tTVUGcWToBuCLlih580xL
	 segpFAye+7AQDpAYrfrEJml/4BQENLnFojopT6Dn/Xl0UpuQZr6X16UaVlJefS0mYcqVU
	 n5NqxgZ0uoVnxaod5UrknEG3DEVzSO5gIQ3eUncsmZf8vXkiXaJrAXeIZ8j+w/QyOLUz9
	 jOEgXumMpQJOhMRfrCT6H++z/1ClhOy9JSrQ/QXIbmkbcIoNfuSxUNQwpFFqIgR06CK1y
	 e8bj43HqSkKE6WhLlpKBNu32FVxVdo3PwNrHzvpR/C+QpHiyUTk5yH6hJJJUU3pcbqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=L5shuLyz;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="T/K9vFJq";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795097808;
	bh=Hrfm76k1vwngeY/Or6kwCmyiDufaKR9joLC7vK0J3Zs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aAC+//x3vKy6JDNELm8/PhTm/LLhqqlvP6nWRX1AqKKwmv7cMe9qVAJRoFoqvcVeP
	 yDWOKANFhu+aHVYlzzgViqSTF+aOHOhlhI+0/ta3hRZA/84+kSQTrpns1n5xdV+sop
	 7OSivwNh/bs8wQfiKauGZq5qQJAmWZJCZOj0bpONJG73ibF0uWk7x2bI7w/UKfqMbd
	 LHqokMTL9nkUSBn0sCqEO+EVDBdGvq+g5rcxDV2p1pLHMmCygK8e7STu0Wyti7fI0U
	 8s5heJVoUZbxy7+DPkvPoi06ijgRUf27SDGNvtdG4WHLUrupawNez3VjQ3RE2EYXnx
	 8VSLh3UqipMow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC2860D7D;
	Thu, 19 Nov 2026 14:16:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50AF022B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35BFC60D7D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGGUmaJXiam5 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 680916064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=L5shuLyz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=T/K9vFJq
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 680916064F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:16:43 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBjRxn825527; Thu, 19 Nov 2026 08:16:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=Hrfm76k1vwngeY/
 Or6kwCmyiDufaKR9joLC7vK0J3Zs=; b=L5shuLyzbdirU/Vuaz6h4r0ACllDEzd
 EDwchjqRfWNt7Cei1JtlfvSwT0kN7UNMDVDX+LAgMIXTFixe6BvcsRPPJcMqfIWU
 SswAoA7XF6w75+necZBqRz5UX8TFgm9xClJMbm1tLqKCKs1hr+D9M1+XRaTor+yg
 2QA1AuT9mC4/lLtEXPbC2oBNrdn3Qa8j0/PhMejHXz2JCU95fny1MVTk+U2Qa/dQ
 6/P4iSrOQUze6inzDJxI3fOn/0ukfhOhwK6sU/BFjtjbg0FM10CCYHjKyfkwx41N
 83GJv99iB+xbWZ1HyO7qwfSIg82nh1AANgYFhz7iONoJgLupw1XmBcQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j1p6d401w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 08:16:29 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrfm76k1vwngeY/Or6kwCmyiDufaKR9joLC7vK0J3Zs=;
 b=T/K9vFJqJ5MC9/D1Znt7wLNRutORXWp4t3NCdw81Y1K9J/UPfjXY3caTvc/BjD2I9wfUvpN7pkQkA/rglRfArfv9Ii7/UU9sBYrpJJ+WJrzZLn3u36QSyp+OYuVWrPeXXcdq5VZG/nUhvQL8UW1BeXtbzPtJxRs8qRh5CIT0D0k=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.12; Thu, 19 Nov 2026 14:16:25 +0000
Received: from DS2PEPF00006E20.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::5b) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 14:16:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF00006E20.mail.protection.outlook.com (10.167.23.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:16:24 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 19 Nov
 2026 08:15:37 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 19 Nov
 2026 08:15:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 19 Nov 2026 08:15:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.75.137])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AJEFbUT100394;
 Thu, 19 Nov 2026 08:15:37 -0600
Date: Thu, 19 Nov 2026 08:15:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Daniel Schultz
 <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, Aristo Chen
 <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Parker <jparker@basepowercompany.com>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v4 0/7] K3: wait for TIFS init before CTRL_MMR unlock
Message-ID: <20261119141537.vao7cvrakzbugn7k@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E20:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b486f3-2fb1-4893-2e0c-08df4647b16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|7416014|10067099003|18002099003|22082099003|6133799003|13003099007|56012099006|261022113327099003|261028144727099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: zpKiMtSDGWObpke7kJ2ccmtN/+94fVEy2LeYR+HkN1vCld1Bq3riaJgAOz6e/iymGUN7RAiGYJ984ADoYCmfSIaI7YVmgz+w0WLu/pDapsiB5WtiM5Pc0Wd6C6jFfoXWv9FIot3VTMi+e4y13dpF4FD19zd81VIxfweRyR0bqBt3Fu4cXPZG46VkWbPp0OXaglGH1fS7UPmshbJr55WJxFuV4km4RPc/KGEBYXUuIbxX2aFvA3WDGEO6OhTObht68v68EJbyxz+nISGIKvhZnIe6mNulJ/3KqglDepbxd2gVzEYBSiIToiPL1czKOVpEiD0fUWxY2VV2DCoF4005o+RJ2T8rxRMwdDGf808qxc6BaWt6MGBTWBdRY1FT+Q4bGBaZTeCfcxj31Acpa4tH4gaB2sdE0LxrX7CamvnI69wljyTf0skfvxGYOSw+vgGbFcxd2KJg2CS5p0Khty6Rpsg9yIBbC5WR+1xnwH7ZTbCRrn6Zd4m6NU9zKnGKeIflr1jzYddNeVt51yCVJTFox7D7sWtxk1nYuquDGz+y7hoQtHFBgVLjFnEMPEr+YJV453zkqvL1Upo96IG1mGYJvid4gVtOSxIbsDMTVLXk/tCKlPTXrMzFcZfiV/Jb5kt8r1j8W276kv9un1NdZl0/yg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(7416014)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(56012099006)(261022113327099003)(261028144727099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021135927099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OA5+ROWQ3bjCtO7Pn+S7/Rlmha83iZcTdjo8KnF6+/cEztkWJzKaxXUlulwd5RL4F2b2fa2NnwRuCzPmlg3bf5nTPWAoocj8byyNLf3Z/FifPVwh85eZlJ+vOq5mFwrQ/5jKyeRcqxh8mCAybAC16TVDQ0Ta9rIkZf0dZ/HC52+afyu/I96PD1eHKW0IrkLvPQD2rt7RrStAssP3Q/ecO3NxIjN20I0RN2JMhyfIFEhgmnXTfBaFAmH2Vb4NRO/HvPXhj1wGcTIRp9qY/FJjlLJ3eDCSw7Cezo3VUAIzNx2Ih/3y6Bq/U6ls705Ozk+Mf8oKGboMizEpIGKb6MlRBcoQ7KLA5aM9tUk68wqSNzehv+phGlcOufOXc9V7lqw/JUAPWN2yD9i5HwfnjTuYVyHEK9KRVZOzaJf01QnbxiBQ8mzuKQauMDL8C50HsDZr
X-Exchange-RoutingPolicyChecked: mfH0pnNof91gvKNXP9DffuxKjJq90Lg8I8ZuYkz6BnXwRBWIGVt/LhioUS+kcVLv8pppcf5qFSRuoITiPl0Xs0oL7o4kmBRJIszU0M65MhkJQuhJ6W6HkGUX3Cog0CoGbeIwWxvHu0HCuLg4kTxYddjcw1UJe2FV98B/kRMq9lKA2d/a7E/3tBP1WizriJ1odRP5ie4xEBl16Dp4Irz5yffbF/0OqxpmDHLmw/THNM46CfGJjhtkqJjeVA9rrU7W2G2HETtxmM+4F7l4wlWFfAR9uJ4kDaBq1QQ4PqV6EJTUG1Rlrta4OWKUJRKAcLVfR5Z3VkZIMcuNjWZOmkjyhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:16:24.2063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b486f3-2fb1-4893-2e0c-08df4647b16b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E20.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1NiBTYWx0ZWRfX5tsCWBLGq2Qu
 ENo01QM+4MMcyp8DwqZm8RRda42TJoqqwfbFluhxjX5VlJsitXTdslGTJyTDLF8BW5X5ySDXTLD
 MpNTZettmmJdTtNRzO2Wei7GQyj//lJrUWMMD/RYKldawVQ30GtuNPO6hxrLQ5xLV32QmTkQ7zZ
 KgiFdD6V7gKXKewxbtbN3+Htz+OV6dHGya5emdf9vDBmophgWIGidbTdbKX7cnLYu0f/SevrVCz
 1a+w4WMahBOYdTOB6TOr8bXZN0XoAQAAlifJJ0YkfFlqsPyIJIylqeHZ4yRHxGShCA00Sj7IOcD
 90f6kCxCkDwhoZ4xF3PGBHd9yxEVw/nAVBUzBlzTDNEa4hc6hbRvAu75wu8INT8LD9HOGQLK8/I
 Ofxj2WrlfR/lwz9c6ahs/N90Tsnu8TH13WqUMdn17S6bQwai7kr+Rh/adrOMw/uyU8OKaGo63ic
 fRcBLVEtxsYgI5CAmkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1NiBTYWx0ZWRfXzAD2U5iEoJyO
 FYRHTz1u85ief+SMOtesdc3YeYozE3clB0yplTXYqzMwsPSDXjP7yP/q05vv04uiQvlowErVwhl
 rmfINKDaFQvkAuG4cDvXlq5Jm5jDgf0=
X-Authority-Analysis: v=2.4 cv=Qc/zLcbv c=1 sm=1 tr=0 ts=6aff04bd cx=c_pps
 a=MNM/txilNqeExyaWs+jKwg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=bC-a23v3AAAA:8 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8 a=KKAkSRfTAAAA:8 a=P-IC7800AAAA:8
 a=DfNHnWVPAAAA:8 a=cm27Pg_UAAAA:8 a=ng00cqXeAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=8Qelafo1Zfu9TgaA1SYA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22 a=aZ5uHUMKh6B-zo3GvD48:22
 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=rjTVMONInIDnV1a_A2c_:22 a=tYf5d_5LUfVMvSn2BupC:22
X-Proofpoint-GUID: BaMMo21iXLccsSKt5Opwpzwc2e4LN8DW
X-Proofpoint-ORIG-GUID: BaMMo21iXLccsSKt5Opwpzwc2e4LN8DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190056
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On November  4, 2026 thus sayeth Markus Schneider-Pargmann:
> Hi,
> 
> this series uses a TIFS barrier before doing the ctrl_mmr_unlock(). This
> specific implementation works for the platforms where TIFS is already
> running at this point. Note that other K3 platforms may have the same
> problem, but for these this implementation is not straight forward.
> 
> This series is only tested on am625 HS-SE. I don't have any other HS-SE
> boards.
> 
> Best,
> Markus

Thanks for fixing this for us Markus! It's been a long standing issue 
for a while unfortunately.

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

> 
> ---
> Changes in v4:
> - Update SPL_DM_EVENT commit description
> - Add a patch to separate EVENT and SPL_EVENT
> - Link to v3: https://patch.msgid.link/20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com
> 
> Changes in v3:
> - Added patche to add SPL_DM_EVENT
> - Changed the patches to not wait for TIFS and unlock after
>   spl_early_init() but instead at EVT_DM_POST_INIT_F.
> - Link to v2: https://patch.msgid.link/20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com
> 
> Changes in v2:
> - Create a common helper k3_sysfw_wait_ready() to make the purpose of
>   the get_ti_sci_handle() clear.
> - Extend the series to the other SoCs with the same boot process: am62a7,
>   am62p5 and j722s.
> - Link to v1: https://patch.msgid.link/20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com
> 
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Daniel Schultz <d.schultz@phytec.de>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Cc: Richard Genoud <richard.genoud@bootlin.com>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Aristo Chen <aristo.chen@canonical.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Kory Maincent <kory.maincent@bootlin.com>
> Cc: Paresh Bhagat <p-bhagat@ti.com>
> Cc: Julien Panis <jpanis@baylibre.com>
> Cc: Jacob Parker <jparker@basepowercompany.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> ---
> Markus Schneider-Pargmann (7):
>       event: Split EVENT and SPL_EVENT sections
>       arm: mach-k3: common: add helper to wait for TIFS initialization
>       dm: core: Add SPL_DM_EVENT
>       arm: mach-k3: am625: Wait for TIFS initialization
>       arm: mach-k3: am62a7: Wait for TIFS initialization
>       arm: mach-k3: am62p5: Wait for TIFS initialization
>       arm: mach-k3: j722s: Wait for TIFS initialization
> 
>  arch/arm/mach-k3/Kconfig              |  4 ++++
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 17 +++++++++++++++--
>  arch/arm/mach-k3/am62px/am62p5_init.c | 17 +++++++++++++++--
>  arch/arm/mach-k3/am62x/am625_init.c   | 17 +++++++++++++++--
>  arch/arm/mach-k3/common.c             | 10 ++++++++++
>  arch/arm/mach-k3/common.h             |  1 +
>  arch/arm/mach-k3/j722s/j722s_init.c   | 17 +++++++++++++++--
>  common/Kconfig                        |  8 ++++++--
>  drivers/core/Kconfig                  | 10 ++++++++++
>  9 files changed, 91 insertions(+), 10 deletions(-)
> ---
> base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
> change-id: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e
> 
> Best regards,
> --  
> Markus Schneider-Pargmann <msp@baylibre.com>
> 
