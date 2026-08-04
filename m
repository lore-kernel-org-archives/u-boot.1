Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AACC561E6
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2307380D92;
	Tue,  4 Aug 2026 21:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzhiUCmaEgSQ; Tue,  4 Aug 2026 21:55:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7786780DAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880546;
	bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxTG7leRxu4/7Bf4MFUk8lKUXnqqP2p4oDjgO6DgtSmXm5nmVnM8KYKmx4WCgIW6y
	 m82J3U2YuPOFmYq7ozpaF136AqbDJlMS0kuNaLLA4WEGAb1DOo0bse100LbusjmuQB
	 voH6dAUGuDmDaRDuEop+YlvRvF7C0gSa8CRnUix2SdhjssFnfZLcF0DkoLDtLfyvT7
	 tqaPcu2DU5oyelWANPoMetljCnjgAUVb6NhF1hjMTp/EnCjmN5f/tGmjLiQjgbUv0e
	 I0+O5lZyWNTatA2GG1wdCqrVCidQHzcTH5NElq9kbil9vRJaqTp8ng5i75X5XgkRJ6
	 a8WsMD5BNx1RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7786780DAB;
	Tue,  4 Aug 2026 21:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1315F2FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 057AB40090
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQT8339K1L6g for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C7E60400DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7E60400DB
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7E60400DB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:35 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JoQIB3359177; Tue, 4 Aug 2026 16:55:31 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufc6vc80-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2UX/rNIiphINl9hazfo25tltiCVRDux2JCSccRIJ4KV8S6zRu7ClwNy8MpdmlJJ49lu/B8yn7AqyYhCcg2KohjWd4l8W5Wl79rTR4RplWHQidKxiY9GSqs7OgROOrthMdevJJkf40co8HIPx+vHx6jYJ2CHftXn/dkoh88lxGMnvntiGBrocQWLgH5/twis7RZGGHfeY5HxFeMQ+B84a2VZoYuwEvws7ZzNqlMtDqzD4EeJZMJzzn2hjS+QuDoFdEFInFZOEKFTMRdqkQS+3uWbYuvq6dp1U3c26gDZqPzegTNCL14bg4P1DOSvvvwOaYe488azUb+pHTkmT6+k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
 b=PGPHy9h6QAP6PmM5aFB+b4awWaBwDuK6YWvEsmiK1nyq+fEl18mnrRJAYR/1g/WGkzVml9co6xj6v8h8kOQ5OBr4uzsuQrfNmwkSPGzuin5nJdYqJAzEkWt9JP1xvXgVt1nRKkCplqzpct12dNNH7hAc8qBKaCErsJb7rHGk/dGIXgUMvL2LMWGqHFXUTVlXOyMyKnjV1sqqoD7uJ308Ttx5aU0UAdf3Il7vMjWnyzAcLnkZvXrEdb3EBXgchgbEpbKIrN/0gnl5VMxR/wv+1+PO7HKFpvbAHtGagt5oTsWfvVp0S9WXGDFn5heC4HPQ2D5HiLOQ1Ntr99Z5sJT99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:208:23b::17)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:24 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::aa) by MN2PR11CA0012.outlook.office365.com
 (2603:10b6:208:23b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 21:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:20 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIM9222918;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:01 -0500
Subject: [PATCH v4 02/11] tools: binman: extend ti_secure_rom to handle op-tee
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-2-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=8018; i=bb@ti.com;
 h=from:subject:message-id; bh=6ymAz1ZZel9JB9+6+hQTEObfLWYlwg35xCguH9w6yFk=;
 b=owNCWmg5MUFZJlNZcRvFuAAAY/////59y3+rj73u9nhQ+/vb3xmvf1/8+/tt+/897v/n9f4wA
 RswHaTQGgBo0DQNDQeoNNA0AMgBkAA0GgAADQA0BoaaNAZAMjTTRpoMJ6TD0ogyYhoA0DQ0ZGj0
 g0BoZGQYIaANANGgaNGmmgAAGjQ9TRkBkNA9QNAaDQyGNQhoaNGTTIGQaANGQwmgZDQNANAZBkG
 mEAAMAgAGmRoAyABghhMjQGQAQO2EuKuCCIKcHGoIGGDlIgcSmpQEw0C3QdCy0ZCvXG17gBrHk2
 a5/ifEAOobYkyHPxjbTQFZNBpHsIIX6/zv1SWGuH/qLW2qXkEfA/N0IpAlOr3Yar4VCQHATgEi2
 OhUgYSFhvboTUaeTAZCWqBj3lQLxQQ0ThYHpuWduEcbMVy670jbZTl3xwsnvD8UGjUq81AM1yDu
 nupRCcOqUw9EzSoRJpFh8vEXXplqQ8wAc5E2wGhwg2hIf6De9uMjlyswQ+PPnLknZUU85HxNGqY
 cIZImGkUpNhULErD1StclFURrFM/QbCcYieh4ZQaeenSH1CAGWtn7aZ9gM1Tw3B3LiBOaOtV4gR
 vHWBExv6DULIR5/8ELfVqyFrwmWL4F3DGFxljETy2BvZbvqcXRUgaw0xpFcq4Z7UYURy6MG4RIB
 cYCbuAMX/F3JFOFCQcRvFuA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b6f2ca-1ba0-4525-b7e4-08def273144a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|17002099007|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: aMACJY2yxpHhxgOTxlPGJl39vcH0fFxcywY+hBllB6tGSE7tO+nZUDoOjbLxca4uFex9RVLgGqrvPFjX/U3Fff6DHEMt8tozL/YYYiLuP+ezIoJfBUlc2XxxSbcXpjxzBR8KXJuVvSp0tR058Lm8CBLxek7zJ5sof8Fr6fKq2QOmX//15b+b5GgF16GHESfeGFC1ny4gOBscp7A6q1xCuk1NhGVVpQG1iWto/Ny6Tb6RuDj1UrTabBRPF7pCPoxBXCeMtasF9fk/xbutfzbuv21kT4qdfAxJZkGG+Kppbp4PVSeO6c6yElH9Y/BkaZ9aFNkvktgmOffbaZTpbUO0X1T+L5p/oa9B3mPMMeYRGan69u6vUPJn2ywlZYMcEl8NAggcTDmqbPv6pb8hHunCNvGLpAxejeJT41I6FPHJVQibH49cF3C29ngw0v2VhGBC3R95bIZ3YfSYvZ5CJCgF4d1nh2ziY3Lu5D7RxzWLMUhmJow8JAXnhrWW4OuxXaBdR0RockGh1Z2HcuY0TB6CnqDA8na4VktPyPplta/vID27tzsAl6dGdGrynb8EBiqlrMQnjeVbrpgovfszwe4eI+uwEQKYpSNkLOYfZ0IbP0eNGThHgmrvuUUwMg2oEeNExby6S/frRimY/9wzSTFDGbeZrkNsdDE09tjCVy6K9mBS5Vcm7kXpCkkvuqsUpv574G85eeYbAXlKOBXCxohRxA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(17002099007)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YyOR3rsO7jH1JaU3s/VOetLZWSwx/mE3ODoSXc8pP+6ZORG83Z1VOHpTHDeJx4mMx/gCu4K0tjMiG9wVmcYbuuuIKimPJLhBZYIGPnmGw9LCoccHYFYbwJIIBO2lvZCT6EU17PUTtvxMt6ikTCK1yLkfNvad5/tR/rRwVDY/r+5+ONAPo331HiIG8t8SRwQZ5cTyC83Su4ZJM/RHLTmzbZmTk7KTJ5AIC1KeegHrwynfIMRD2NooSPyqyyMH8IDA3yQRRbR9MeCOauCTTLqyixQ7LqYtsY7MEAzT2cGIkTOb5qSSND28rEbcFvBb+7itHDXfiazKsbo1mdJW2pKhMJqaAmJI36yCgmbucG8t2x1YJ5xK98PXAErNf4H0RwDLxhVkQZEuGL4zft7rtCZZc0I1InZmA0W+Fw4QH3J/KVRcqF77w7RlGC81OWlyW1nd
X-Exchange-RoutingPolicyChecked: bYJNG1ZrjAGnjThfY9Z2WZcG5wfuc0XHvCMRuVymmct0WeDXOmzgdaCIY/GesYrhwwfP0Y1ar7O7GoldgjxAEXzLE0lBnYYfibzyX/pg9K4aAIfC7J1aaVWOl2A07pBcwQvN070FJMB+YzTVkCxYRIwj1UJKrg0kJloSUoKkKh/Bim8yb3PFMWaeg0PdPlUa8esuN3TvCFN/aCWw7i/D7jatCPoZmmlbK7mfWR/GGNwIfIW7ylRG9Aaks4ywNVjHbiQVSxAG4vIMCg0MhFliTbHgtG0Q/Ud5ZrYkyKGor+Vk9bPPUf1aIwTnBln923STuVGlZG/8N2nwH5mIpRn1Vw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:20.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b6f2ca-1ba0-4525-b7e4-08def273144a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXxC4X2IArB2wj
 sSrlxxQ4jiNIl2R9tdn0aKiqtMfG9cLLVuKwi+CYcKob70owXu7BrGb+99jNQXZwYi38616IQiS
 1BV7sjtAjDALYuK1CHNlXCd0NJhoNSUnXxR/S73W+axY2dqTtywqAR25III3aMMxoh4nNMdN8uC
 JOUXrsS0rj6PYnviF36B7kKpvNWhv6lQfusHL27ONjspIa/LqttVRVCqfly4RKWHKIOZviIwDG/
 SFGb/Xamq1kyA7Iv4P5hNWhL8jbTMjKx3rWG/jU7bjCUb/1MhaCyKkR0rwxofSGE/pMGLRGQaQu
 KrUFSlz+WMRnHn8Zek/L3u2p+ujDP5pqVfvLJvtzDjNA2QnGNHyopU4Yg4a3HwIHK4vvQ1TwJwd
 rSfMBfkSVxeSrtYJQsbZZJqRJMMPhJq9uX/hpRC4RdX7Bl+br82qkquRkMnpwfu8smMxw4TVSte
 rU8qtRtBCEsF5tIPEfw==
X-Proofpoint-GUID: LOri04rDz2YmxJ7Y_U11C5vLJpuOvnXu
X-Proofpoint-ORIG-GUID: LOri04rDz2YmxJ7Y_U11C5vLJpuOvnXu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX0dfuE23ycmqx
 U4qyVvo5gIWRTDiZHjH+cv7A2tCYezO6SqJz7Kxs+BCTRSN5jKzXPcigypuCXxXqr7FfXeGQc4Y
 74yKUEjXnYCkJyiOLlIbPfUSbSOBK6E=
X-Authority-Analysis: v=2.4 cv=Va3H+lp9 c=1 sm=1 tr=0 ts=6a725fd3 cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=ZdKUUdNxhPkhoCELuMkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY
 /U=; b=IVC4aHngDClwg8WN0u8Vmla8G57Bl0hWT3NrNmZZ/cNGBQkzmI24qNeGe
 VhDMSF27A0dI9pWG8Wd1voBhUjPs2TKgllq6djZZJoJ/nCrPM8/adVOddtAvctjq
 YxOh4FM2RYf9p93XN9mlFbhO17rbtn56qa6cnfRlKmo1qZUc+vwQbNg4lj/ostb2
 S766uJBZ84wKA7Qvv7UCDzjN1lL/EBhoFGsV6OSiVncGQqEu8Dn0uAQXrlBXEJ4U
 7xeQTIKzdrKgL1DbjNnaI9zcRyc1ZsvvxXPS8UG2wRemDKYua+Jg8IBqCMILv0kO
 Vj6ZuhAXa0h58xvOujlXTMqYB3uAg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
 b=mSTx+IO2bUlmsEOQYybFouWLhCOxFhg8eTR3auDpFwWfYL9qtgZTIzJlQ+S78dUTpk/15+JS9FIpDsNsWyv2/N1zOr4Mm46gi8xR93EePR8IUE8GLJ6gZSbjEGwzye3phewd8FqD7VDd6ycb1YzPaUpMG6TLJRujt8x2Ahd1zUk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=IVC4aHng; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mSTx+IO2
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

Add an optional 'tee' entry to the x509 certificate template to include
optee during the second (tispl) boot phase for the AM62L.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Extended documentation and testing for ti-secure-rom etype
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 tools/binman/btool/openssl.py                      | 11 ++++---
 tools/binman/etype/ti_secure_rom.py                | 34 +++++++++++++++++++++-
 tools/binman/etype/x509_cert.py                    |  4 +++
 .../binman/test/vendor/ti_secure_rom_combined.dts  |  1 +
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c4470..c4762f6ccee6 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -239,10 +239,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
     def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
                   sysfw_inner_cert_ext_boot_sequence_string, dm_data_ext_boot_sequence_string,
-                  imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
-                  hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
-                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block, bootcore_opts, debug):
+                  tee_ext_boot_sequence_string, imagesize_sbl, hashval_sbl, load_addr_sysfw,
+                  imagesize_sysfw, hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
+                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block, dm_data_ext_boot_block,
+                  tee_ext_boot_block, bootcore_opts, debug):
         """Create a certificate
 
         Args:
@@ -299,6 +299,7 @@ sbl=SEQUENCE:sbl
 sysfw=SEQUENCE:sysfw
 sysfw_data=SEQUENCE:sysfw_data
 {sysfw_inner_cert_ext_boot_sequence_string}
+{tee_ext_boot_sequence_string}
 {dm_data_ext_boot_sequence_string}
 
 [sbl]
@@ -340,6 +341,8 @@ coreDbgSecEn = INTEGER:0
 
 {sysfw_inner_cert_ext_boot_block}
 
+{tee_ext_boot_block}
+
 {dm_data_ext_boot_block}
         ''', file=outf)
         args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c6559409..0d7d3e602a9a 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -42,10 +42,12 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         - content-sysfw-data: phandle of sysfw-data or tifs-data binary
         - content-sysfw-inner-cert (optional): phandle of sysfw inner certificate binary
         - content-dm-data (optional): phandle of dm-data binary
+        - content-tee (optional): phandle of the tee binary
         - load-sysfw: load address of sysfw binary
         - load-sysfw-data: load address of sysfw-data or tifs-data binary
         - load-sysfw-inner-cert (optional): load address of sysfw inner certificate binary
         - load-dm-data (optional): load address of dm-data binary
+        - load-tee (optional): load address of the tee binary
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -80,6 +82,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
             if self.dm_data:
                 self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
+
+        self.tee = fdt_util.GetBool(self._node, 'content-tee', False)
+        if self.tee:
+            self.load_addr_tee = fdt_util.GetInt(self._node, 'load-tee', 0x00000000)
+
         self.req_dist_name = {'C': 'US',
                     'ST': 'TX',
                     'L': 'Dallas',
@@ -219,7 +226,32 @@ compSize = INTEGER:{imagesize_dm_data}
 shaType  = OID:{self.sha_type}
 shaValue = FORMAT:HEX,OCT:{hashval_dm_data}"""
 
-        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data
+        # tee
+        self.tee_ext_boot_sequence_string = ""
+        self.tee_ext_boot_block = ""
+        imagesize_tee = 0
+        if self.tee:
+            self.content = fdt_util.GetPhandleList(self._node, 'content-tee')
+            input_data_tee = self.GetContents(required)
+
+            input_fname_tee = tools.get_output_filename('input.%s' % uniq)
+            tools.write_file(input_fname_tee, input_data_tee)
+
+            indata_tee = tools.read_file(input_fname_tee)
+            hashval_tee = hashlib.sha512(indata_tee).hexdigest()
+            imagesize_tee = len(indata_tee)
+            self.num_comps += 1
+            self.tee_ext_boot_sequence_string = "tee=SEQUENCE:tee"
+            self.tee_ext_boot_block = f"""[tee]
+compType = INTEGER:17
+bootCore = INTEGER:16
+compOpts = INTEGER:0
+destAddr = FORMAT:HEX,OCT:{self.load_addr_tee:08x}
+compSize = INTEGER:{imagesize_tee}
+shaType  = OID:{self.sha_type}
+shaValue = FORMAT:HEX,OCT:{hashval_tee}"""
+
+        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data + imagesize_tee
         return super().GetCertificate(required=required, type='rom-combined')
 
     def GetCertificate(self, required):
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..79b7b37baee7 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -41,6 +41,7 @@ class Entry_x509_cert(Entry_collection):
         self.num_comps = None
         self.sysfw_inner_cert_ext_boot_sequence_string = None
         self.dm_data_ext_boot_sequence_string = None
+        self.tee_ext_boot_sequence_string = None
         self.imagesize_sbl = None
         self.hashval_sbl = None
         self.load_addr_sysfw = None
@@ -51,6 +52,7 @@ class Entry_x509_cert(Entry_collection):
         self.hashval_sysfw_data = None
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
+        self.tee_ext_boot_block = None
         self.firewall_cert_data = None
         self.debug = False
 
@@ -132,6 +134,7 @@ class Entry_x509_cert(Entry_collection):
                 num_comps=self.num_comps,
                 sysfw_inner_cert_ext_boot_sequence_string=self.sysfw_inner_cert_ext_boot_sequence_string,
                 dm_data_ext_boot_sequence_string=self.dm_data_ext_boot_sequence_string,
+                tee_ext_boot_sequence_string=self.tee_ext_boot_sequence_string,
                 imagesize_sbl=self.imagesize_sbl,
                 hashval_sbl=self.hashval_sbl,
                 load_addr_sysfw=self.load_addr_sysfw,
@@ -142,6 +145,7 @@ class Entry_x509_cert(Entry_collection):
                 hashval_sysfw_data=self.hashval_sysfw_data,
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
+                tee_ext_boot_block=self.tee_ext_boot_block,
                 bootcore_opts=self.bootcore_opts,
                 debug=self.debug
             )
diff --git a/tools/binman/test/vendor/ti_secure_rom_combined.dts b/tools/binman/test/vendor/ti_secure_rom_combined.dts
index bf872739bc13..ea246599c6c6 100644
--- a/tools/binman/test/vendor/ti_secure_rom_combined.dts
+++ b/tools/binman/test/vendor/ti_secure_rom_combined.dts
@@ -14,6 +14,7 @@
 			content-sysfw-data = <&unsecure_binary>;
 			content-sysfw-inner-cert = <&unsecure_binary>;
 			content-dm-data = <&unsecure_binary>;
+			content-tee = <&unsecure_binary>;
 			combined;
 			sysfw-inner-cert;
 			dm-data;

-- 
2.54.0

