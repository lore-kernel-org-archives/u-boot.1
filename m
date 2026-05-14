Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F145ACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D2E83E81;
	Thu, 14 May 2026 12:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OaeiYby0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD4883E81; Thu, 14 May 2026 12:03:13 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6045983EF9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL49SH+ZV4YFCDWlG0L2txQ+Ee01cmU6vU9Fk15mPc75IMTjSN5UWIqJPq4bpsgnEvn8eNNPR1jWpkKKZu2mzwReYWPxBBuzPakBh8bTZNK9emEdKRg9bUzIqX+ms122UU59UQ2KbI5YgxUEfk2+4yckyFBBRyXHsF83qxholJPLlcDy3wEcoG+NeKXL4APMAJgojgRt0UbU2+UhVktyOf4KkVDFUsAq1+OooKSTNzgV+biwz+NhztKTqryirpp2oTptERayYOpMci58vYaj26sEtDKgzYxbe262L7ZmHtyUID8nLx0zK7/7+Oskoa845Fus7UTE1AUOmSy00Em4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysy1ghFf++UFxj3Vc/T5QdPTr9E2OyAPQyrpXjEgXxA=;
 b=TCJXr6hB4yYXxB4Je8b+6ez2GLtrIE9oRlbYBYYOz0mdx+w2xdw8MY0yZiC4kiR44js8Fm3mttupqRofAaJJta3xv2gc97ml6m7QM9+99RYhzgm5wQTX369b2jml8On9CX0H25LTJbbtw9jL1TQB44PptO2V3tRvSJ1CvcTS/9jkS947TwHzjWREukLkcTWft1Gu7KjMicbzUUzteNRZjoFx8LXzMUJVAVuuNlYbXX6P5wXIhOhCStdtogIA3TLmA/MG2T/8n1r9gj0xIqjNvBPCi1b71TaCE4WbLoVmAVKIWqMHxOcQS41OvZhmKLNhh1yC/vDWWL+ql6yKCcwhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysy1ghFf++UFxj3Vc/T5QdPTr9E2OyAPQyrpXjEgXxA=;
 b=OaeiYby0yHT25PFs9Vnk3O9MjbmnObY0M3LYo1xGkZQjQg+LBFJfH5PVwbnW6rKLzv8NYRy6/SwVtKL3xy0bQm0llKs2PQjP6uInx4hhbBjxWIWSwRBBhd9ADbRDqRZNlTj9YkfN8Nma41wRPhtp4xmU8+uaJQhCkiWlUdtq6pc=
Received: from SA0PR11CA0171.namprd11.prod.outlook.com (2603:10b6:806:1bb::26)
 by CY8PR10MB7339.namprd10.prod.outlook.com (2603:10b6:930:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:03:03 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::8d) by SA0PR11CA0171.outlook.office365.com
 (2603:10b6:806:1bb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 10:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:03:02 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 05:03:01 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 05:03:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 05:03:01 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64EA2uof1450971;
 Thu, 14 May 2026 05:02:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
From: Neha Malcom Francis <n-francis@ti.com>
To: Sergio Prado <sergio.prado@e-labworks.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <sughosh.ganu@arm.com>,
 <wolfgang.wallner@at.abb.com>, <bb@ti.com>, <xypron.glpk@gmx.de>,
 <y.moog@phytec.de>, <afd@ti.com>, <quentin.schulz@cherry.de>,
 <Wojciech.Dubowik@mt.com>
In-Reply-To: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
References: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
Date: Thu, 14 May 2026 15:32:53 +0530
Message-ID: <177875297370.2865500.17649133144445163354.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778752976; l=240;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=06n5dIfi+eB0EhJK95fpmOtLP5VPz3kZL3onDh82354=;
 b=e4c90QWyJ5jtUKiX6ADdPbI70SJw6sWkuP6vbUgqshGo6cp/P00I5JFNVW7pjSwDHqt/xawQW
 tJ7jiXByj2ND7ASFYLvRpQpP0C3BCJvKmMJ4djihQNQPHRWYfBfWBJ5
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CY8PR10MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: b115a4e6-24d3-4052-96ad-08deb19ffc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KRf1H4ndxQp74CFja5lQOBUYwAPKEoFmX7H2HCvflP1gCOIUvMxTu+Ht2iIsoZNVpFOmNYDcdKRwGQfZj5YqU3O1mYsUpDA6C1MLufclrWXlYklaLBSYkpWdItrxGpomJ8ss6Zsr+0Wiaf9dN+s/0TEXgA/RKljb6plV5lbwmAXuY/Xh7laP6O5EXx4asRshqXf8Hkvb6Psnt+Gs8f2Tcw8gZn4QZfiEh/v8XoASmw7pRgTgpLm+aUEyCl13DfLh7C3/zEr/io1KXYaBgB/WxiYiS5OesH58gE7O7z4qt3mGV17LT9TgWrOuFCoX4A1eGmiAJW+SFa7T9TzLvv6HLFpLmGmL2uYuc8sHmseupAu04awm9EzvPEGI4AlvpAC2KrI33Wr92RE7pzjf8G/Pk/gbhLqAN3beZsPnA3Fk7RB75dbnNWPsKLcrBLZ9xrMwta/VS11u/ZFW0/aDLo/th+Wi34HH7wfHFptpSDw/kN51x02gcd9TMW2iQ0C4xUiW0kLImFZJg8KMPUWzU1R/0G19W4Xc3vZueemu0JSplZ1IDADYhOMgawftovnJa/EDuur4Z2yvVQ4Ec4Qxnv7zUMFNj/MA3UJWF8f4crfOwKQTZ92VnTgXaz/oHEArmYchLywdM/mifpejDKpcEqiPMLkdnbLwVOkqnRyl7qg+aoo8pzWNB+aaouKk9iFIUGpPQ22sBxvx5CJNHdvXxFApfdDR1TDC+haRXPqPJDDWkvE=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3XbOUNq87fNsnyjSczc18tzu+Iky+zbBMIfigbnuhSA48r7K/YxWY3ioTCDeU21AxHQXnEyRS4aMkjBGQ1JSdbnLRl1jL3bq+cSizz9y253W/QD39Ci6geM/CiW0bu3xfXwpl89nyCAhi3PPJXfLP+qhDzMSy+dtEP2yY5Sc7DppU0uTjHMeqtUg1VUrNuMD8yd/dvDKXwXDd058OAbfRrDqZiVnWhfZOcbq92tPkcC677FPJHzZh0OqJi8Sfw9THjdybCtVqxjZGe+LGl8Yuc3JF5jf67wKCQkQq9UIJBXtMlR8wfs8M3sujmPw+X4e3i3cN8JoK06AaK+NzUbxel1CDS8RYwUBnitr3TLg9Hygwo9Lumi7iQfiScl7nzT3Icz/P44t7V0mKWOPQ0Vhv15ROHJbP71xR629PRUF2hp/Q79ErczTjb35CkrKTkTh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:03:02.1393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b115a4e6-24d3-4052-96ad-08deb19ffc2f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7339
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

On Wed, 13 May 2026 14:56:34 -0300, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: add PKCS#11/HSM signing support

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
