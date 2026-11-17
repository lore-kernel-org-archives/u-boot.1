Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12042606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VNWdzkw6;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bGpTAUjF;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DwsrrYeh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE92D6083A;
	Tue, 17 Nov 2026 06:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opG2uJA56OXl; Tue, 17 Nov 2026 06:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BFD7960774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794897042;
	b=FXsidd41Ys7c10qb9o6oEIC1NpzaRQhZVtSXgLeDPi5RL0EBXWYTjzbBKS0pPRcnh0Ib
	 HPPnfJTd/a8BMrb45rmx4MTSTQjNqrOlHMjBn2Y+5AQEC/hwPAMkuOecRC2EWEP0XHDF1
	 MRjSts6+yzx1B2Rz3v0rhos536caIIOBkLCjQI+ARLA+Z+fLyUGtt/m2CyjrvjxS/IbNp
	 m3c8yqoqBorCJ8sw5APYlOvVlAuCwtot1ZPqMtCRjyIgnakT7HLYIduRVR0H1+xNJLUFt
	 qs2DGWLcPNsXmo/NKWsPwxi3F88X5NJwU93u2tiUTNfWzCAkaae3seFddwoRQbsqgKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794897042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y5ROmdnQG92OpgjskD3jQsXyCsJdbLs/bcqQ5hn4Ef0=;
	b=IgQK1V8BmXu7k5kvGCwws5rViu+cfDwKI8pYb+gkdcE0itSev6sZX1barCCEsztlbI92
	 r4dNq8qkubi7itI56HC5EmMOWlTFAy3+CMZvaMa7+43NcdRXcl4WICkaBDWo5Tzv4tUVn
	 vHanxiw77yEPB9SLfiDYau/Anxup/9SmUkVO6fYqqnrhwRXmJJaJ0/vWQ6Jt28nS4Ag5n
	 cyG53lwTMagCK9wTa+Zx4BSWJjgSkmvn8NGEvoHpqdun/jBqOzMs32C0MKoZhmfSAPrbw
	 Rtd7p7J/1MLxl+t53rsxHmwCUeadvFOIwBaMRBWWyHgKGRADbYfiHWpV9EpBjXRTgBg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794897042;
	bh=Y5ROmdnQG92OpgjskD3jQsXyCsJdbLs/bcqQ5hn4Ef0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VNWdzkw6aGqK2lpnqyFycySkbL46jlzTF8cJK7oRjWjtCYt5YGIrzVyKeeAqBYbYi
	 YXsBPgOiM42HIq+Ym1DsdrnxyXBzuWywcfAUq+EV8o2G6uaU6SKCisPB4Qkr+/p7zP
	 Hv5EcSn+uq5IbOYfkk1LZSQk+q8bXAJ43jrYL0I3qmj1ID+3mtOWC675T/1oIz0Xby
	 b3un/CcGobQsJ1msH9nZHXgfbFFx+z9Znp/5/gSWa03meD2K1yk5rsSKCqBRqGrmkF
	 nFgrCCnpI9NaXfYKJoyYSGPEKjUnfwHGe9IowFp58rqh0lmDBt+ncXhybkrnBVChS9
	 vicRKD1cGSS4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFD7960774;
	Tue, 17 Nov 2026 06:30:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 527A3A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 384C780FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDBth_XM7b8n for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4CD980FC6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bGpTAUjF; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=DwsrrYeh
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4CD980FC6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:30:38 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH2bDMV3291024; Tue, 17 Nov 2026 00:30:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Y5ROmdnQG92OpgjskD3jQsXyCsJdbLs/bcqQ5hn4E
 f0=; b=bGpTAUjFtn/O3nKTmKqmCF2kStnSOU9KeoxOR+UccuLh+1JymXUnjYBvh
 oiUILj/RV08vzVA9VAiFTgbdE1fIj7v1VCX/pMx80f2+4CbXrhvsZWW4URZKR56E
 fAMbC/tsMmV6G2iwXihVHCCSBH/mMVvGFAekdLzrMabOugh62hrGktqay0rA6L39
 3AmiwmleCv9hpgy/18Y1EsxqasL33lV/MtaWIHfpLHTkuvA1A9nbyLNiq4yyh/1j
 c7lnmlWqM471SeB8IJ8m0qA3iP7HUJehSnp3/G3p0EQzn3KILq36CP4HSGyjvTi0
 g9StC7jyXtLjnNki4Xa8qzB7nX8Rw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0cbmhhtk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 00:30:28 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5ROmdnQG92OpgjskD3jQsXyCsJdbLs/bcqQ5hn4Ef0=;
 b=DwsrrYehpVxXGk5CZbIAuVpy2KePW+jFdG8VknfHoVFGgH9G7sGFp0VglhNtkrhKs0TtSvYcZFwNkY8esWDAP4PNDcA38+uXyydsRqG+efKjGhr07ieDUkzBUgVLVAjzu3IFm43OrbzYWVhRgwe3YyPEL5h/XIlvo+OE984L12c=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 06:30:26 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::1f) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 06:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:30:24 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 00:29:58 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 00:29:58 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 00:29:58 -0600
Received: from [172.24.21.188] (lt5cg60819vj.dhcp.ti.com [172.24.21.188])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AH6Tbtl2327475;
 Tue, 17 Nov 2026 00:29:38 -0600
Message-ID: <7ad5572b-ee14-4018-8aef-6c67394fb014@ti.com>
Date: Tue, 17 Nov 2026 11:59:37 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] arm: mach-k3: j722s: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Daniel Schultz <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, "Aristo Chen" <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>,
 Paresh Bhagat <p-bhagat@ti.com>, "Julien Panis" <jpanis@baylibre.com>,
 Jacob Parker <jparker@basepowercompany.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, <u-kumar1@ti.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
 <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-7-e211cba9f3ea@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-7-e211cba9f3ea@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ffc7cb-1545-4f91-0f30-08df44744311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|4143699003|56012099006|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: wImfpX5SYC8blUkEvDtbmTquj45a+TypQHXxTmw2U7BmxHqFjkCMkogg9Rnnqxf9lnHaBRYI5tvT1WpKbj1yllSxyT/5krQN3ufDKQlNBLKwFNJajHlGvft5zenOmHuRJ/jQmzr9Edrbr5bFGywpj2ayw/ZFv3L8UhdjjqmwDCx45A7he7xrbPUbhPt550cegGypqA0rMF+EwphAaKvFJPEepwsTEkudAPYI8mlGuh3njXrBKv6HFjEBxGxA7OI4/LvSlWUrt6CMqycMAF+vlyfbPTazXbmZ/Lmr/K/5KTiQZav5GgT+vLfwTiEVJ0SO6mx9esHQgfIPH21xjnfJaQwvPyYIJc4oVy11d407I/kNvTvlG8pRLTBov0ciDGihXzk0vRYzmTuquwTiuPgLdW3INWYNQNApUYgTdPBVlwFTcajmeC57pVEgswPOqm2o8+LXb/PPXUS1jsqQq1j/0fGrhZmDtfA4B+sWwwKFag6P2a+Xk3z+1yWs0CMX3Se7V/viOdRDBhTP+VosdDcNtwFVRYRVpTVl2B5EkdlVxlgyQHUokGFcmUqqOxoFY5V3WMhZy8uSekrqMzxbDMH3lYJ5aCUfwP750VP8VT77w3tBCbOzpK5u1vlXW+GmrF06bWVEMW11aFEjjJKaJ8O+4g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4FeDml8K8hU7xIYLxkL7Vc/Y1txqo8f43FSjS7FUd/O7qv+yW2XznMEtH/MxSjW42ct2ZokqVXvOTNpTn/JNYptE9qlayI5c0O27R3X2JDe9daHulOM9Qf1b6vgMO1ooz/vky4ChNKFMXu+Wz2dy4/mX0UWPYHFFAV2EHvyk+cmDMUAf7Q34FKOln826WWnjnWvlOxYLdxwX0DtoQymBkFLCtSLnQiUoIskG5zkQMXAsCX5DZdpppTswM76BzOVMmmKznwRJj+QBOVEQHgPHI3yP0VDRIJLcTL44YLP0EDiI5Drl5B4HH5XABtiQfkYH/qB9auRJkm2JWOQCQhd8tDs/3BzJivFIxJvC9Tm9COguxLAnQyomnzzCyq32JSJLIFiZnmk1yXnKBSRgUhwchUtwKCE8cHzh0pnAh+AOHjwKOwsntQsou1BEYCbw98uZ
X-Exchange-RoutingPolicyChecked: kL1nuDbw+ZL6C1paSIJfaXtz3p1bzH83v0wIRz0ZPoLW4TCRZo6zUyOcUyU4VjYcXakJF0hFdEzgsotT0dMO5WWqGPnS20opCL3mOUgjY1q2rs23RDfssqWHJb8YBmjueHcraSLvqbE0PEYzXOhWXUKe0E/6az5ai0blv7obRMcv+N7azArpe3iZJHdU0p4jxlA8pa0IFfUrSgfkMJG7UYkOYtfUGRUE+PHumAasLbTw9azmjnJcf4nXu+xxSypS95E/HUbP9BYPcAFLn4pgTNO7vmtsbzU/81dP6q/hEKnCr2owMMdbjj8/cZQYltfl05nkDrCN3Mj3ypPeIhM+eA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:30:24.0880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ffc7cb-1545-4f91-0f30-08df44744311
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX8Q7s0rxHbN6r
 dLMIaTEuotWrNYJdXZ8aF80rcIpzdUQvLGgHIHysqzJhMNeUKLzGht0+rXkH9lgZJpxSMyWcWo1
 y1Dw5E4hGXf7NxTdy/qx7vc3ZE1jicA=
X-Proofpoint-ORIG-GUID: p21g6UFwOxK3_jJFlKCiK1q-VC5buSA4
X-Proofpoint-GUID: p21g6UFwOxK3_jJFlKCiK1q-VC5buSA4
X-Authority-Analysis: v=2.4 cv=aZz0Dhot c=1 sm=1 tr=0 ts=6afbf484 cx=c_pps
 a=D1syOSCgd/TrkoObF8KiHg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=IpJZQVW2AAAA:8
 a=P-IC7800AAAA:8 a=BQ0GtcSurV8mRgA82EUA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfXzFtluXjmMI7N
 E5QppLDLQgDTSzBVaKSFDJ9kV6nOVlvxvvofNTCXE4L4uJbaWPJnSxc17LJJFfNaCK2DD0b4Jq1
 FV2BDWx6ZGeDPnctldnG9Bgo8FWeLhwuK66QypW+HX4xsWYkRK1K5lMkRUBuXr0meLArcVxxTGm
 +dHvhgnjEU8zqT4b6ZhoU5oTCaFGwBADIRpidOAA4ij7SmiX7Z8ZmwWjomEFiJvWWMGoqH0bAvH
 sJnjZplzwjeL1OKCgYwWLEUQpvOjb6G5w71MJEYr4/Fp06hU9DUdf2fI+kU1q/VbuGdzHDZ3SWu
 vYQKzGw59lkz8ZbNaRYW9bxf5oZB9ctssnlvFeuRmX58OG7EMk+14sYA77240n06zRi7Ts08Q66
 noXbU5RLzFSzouqImP1gyS/6iE153YT14la1OH7zL0qRADBMSM85YsqsYjG2HE44/5ZZNl16f+t
 J0d7CR88J14OWz9P6zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170025
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:28 PM, Markus Schneider-Pargmann wrote:
> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
> the firewall on the registers at the end of initialization. On HS-SE the
> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
> leading to a race condition. This leads to a broken watchdog since the
> signal configuration doesn't succeed because the write doesn't take
> effect.
> 
> Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
> ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
> am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
> ctrl_mmr_unlock() before anything got probed.
> 
> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Tested-by: Richard Genoud <richard.genoud@bootlin.com> # on j722s HS-FS
> ---
>  arch/arm/mach-k3/Kconfig            |  1 +
>  arch/arm/mach-k3/j722s/j722s_init.c | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 3c567f50b223..a952638fc282 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -33,6 +33,7 @@ config SOC_K3_J721S2
>  
>  config SOC_K3_J722S
>  	bool "TI's K3 based J722S SoC Family Support"
> +	select SPL_DM_EVENT if SPL
>  
>  config SOC_K3_J784S4
>  	bool "TI's K3 based J784S4 SoC Family Support"
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551d..7b09691998c9 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -11,6 +11,7 @@
>  #include <dm.h>
>  #include <dm/uclass-internal.h>
>  #include <dm/pinctrl.h>
> +#include <event.h>
>  
>  #include "../sysfw-loader.h"
>  #include "../common.h"
> @@ -70,6 +71,20 @@ static void ctrl_mmr_unlock(void)
>  	mmr_unlock(PADCFG_MMR1_BASE, 1);
>  }
>  
> +/*
> + * Called by spl_early_init() after all devices are bound, but before any of
> + * them are probed. TIFS has to finish its initialization before CTRL_MMR can
> + * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
> + */
> +static int k3_spl_dm_post_init_f(void)
> +{
> +	k3_sysfw_wait_ready();
> +	ctrl_mmr_unlock();
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
> +
>  static void k3_spl_init(void)
>  {
>  	struct udevice *dev;
> @@ -84,8 +99,6 @@ static void k3_spl_init(void)
>  	 */
>  	store_boot_info_from_rom();
>  
> -	ctrl_mmr_unlock();
> -
>  	/* Init DM early */
>  	ret = spl_early_init();

On j722s HS-SE wdt tested.

Tested-by: Udit Kumar <u-kumar1@ti.com>

>  	if (ret)
> 

