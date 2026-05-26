Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAA3CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87676847AF;
	Tue, 26 May 2026 09:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QLcYFXab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773FD84825; Tue, 26 May 2026 09:00:00 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6258F83EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9QOckOKWU+2bzLGTQdGaSGO2YeK0FGc5fEBxbh+aVeVXAXhHobx1lN2t9dtKcW8fAFcmr14zgSwfTtB2E8mTbGICyJgNNEgsLl27zbCuS9THaFFO+zd+05sWpOpP1KZgiKCP0XCtWB8SSY2NNWWb3CnDc/icXSSWdWp0oCNsotTDsEXIPiNhuKVUZ1hlAi1St0be0YToRRpEu37qW/KqbR40xdkU6f01FRU7O8H3S+H5CmfsYvDZOyVhX8f6BlfgOfKW1DJIK6sLbOfEZSN+PaALossg9kfNY2lh2Fa9oj5AsfBhVt0duxxag5M4vD1M5VXaKNkoUUD6WKe22bDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI3MiTd3aPZjcWhfG1s+h7+KEV5a/FGKv81yXuvw0SQ=;
 b=d2OJxDl0eOwsipWpFH9XE1EktunHlGsnLVEAMKmabX2a7KMmsUiEnehiaDJBEWQra6c/OLdAB1xESp0/9iUN8B6jKnxmJ6Z5ewez0bjAs+FbYFQ+RoIwNNuFyJwcuktH3+aahJt9x/xMdSFk7pIYmJhaKy12l89UIimeQZKn4QK1xfiPdz3M8KRElx68FsOB13LgwSg0xNO0OlmBEmfm88rKG8BIFSagTn6I/ymGulGv+XQ6UUB96B32MFLShSbYlLGXTx7IZPI7eORH84hhJSG0Gla5A5WXXzfUtf0FvWuxKg1bNxG2mDTJsxqbUpQob+u0Za96cuZTo+eNjJJHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=groups.io smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI3MiTd3aPZjcWhfG1s+h7+KEV5a/FGKv81yXuvw0SQ=;
 b=QLcYFXabiGBgDf3F6yBc6vgkxU4Uf7LHRy2vQse+kwAUfvS/pLfvD8w3J8n+8RvMbxoNsr1a+oKsLSyy8OHG+NU/HIzuSoCkzUfhEhCv8HTZwOoN97AVSWLbiWqoIfK8lDcMs4yZMqiAWZQRjpA/w1owntB4C3DbzLG8nU0wA4c=
Received: from BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:59:53 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::4a) by BY5PR13CA0009.outlook.office365.com
 (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 06:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 06:59:53 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 01:59:52 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 01:59:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 26 May 2026 01:59:51 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64Q6xkog369971;
 Tue, 26 May 2026 01:59:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] ufs: qcom: add ufs host regulator support
From: Neha Malcom Francis <n-francis@ti.com>
To: Federico Amedeo Izzo <federico@izzo.pro>
CC: Neha Malcom Francis <n-francis@ti.com>, Sumit Garg
 <sumit.garg@kernel.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Luca Weiss
 <luca.weiss@fairphone.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <4864d2a49cdabe9b52e297cff11d7f4f@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
 <20260523-qcom-ufs-regulator-support-v4-2-45639533b06d@izzo.pro>
 <177971117506.986002.14811075924990554544.b4-review@b4>
 <4864d2a49cdabe9b52e297cff11d7f4f@izzo.pro>
Date: Tue, 26 May 2026 12:29:46 +0530
Message-ID: <177977878633.1764621.17326534778878808106.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779778787; l=1155;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=RnnlAFB3H7qLsOf5gFbvb6AsAySv8ZgOKPA7FWxYJ2g=;
 b=0rVVeO2DOSxn66qVJlv4ZbIpJMqlKl7jI7/o+lQt8fZ8q0er9k8C4m7gbL6JA3XvSt8A+4E8y
 /wU8eZZaUXfCo5wvsI23U2xQ5ZSiKylEPQazZ7bkC2RUwCdABI1e8z7
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 0106f68a-dd92-4224-b1ea-08debaf4635b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +8KorkmDnsCC6NoLAf4PNCGwFQvD4FhHwV0ftN1/M7XJd6agzjfFA0JmcQli3OygLPTzAmAWf4nk0z62iUgEBpif0w/OTkImCvJ4zPSbhLyx7qyRgf0VgDnKQZRyN27fh7bG0RO6XPb31dqg5DM+d4hA1ey62CcahDFSXER7mqGH9NqyqcZ/8N1JRrxynrf2Zve4PwOy7ad0Ffq9I36clIR/YDf2DEyfamngnFgZIEA46hwGGhk4EYlVxZwh16ZdnSiUEiE0bmwGauJsdI5y4ZZMYtrvT8dH1YDOiWAerbt0fGy01petMMPZE8/jnoJLXxZBFkVZc1dTY98Vs8cjjXQByND2Xpl7KnvTVtJAHHzZF9dPG0OutwzEPzZ41BO7VGE7oVL/zkee31AcyClHSIiVQZwbElRxVM5dhTNvT8q0h2vnRjKRAvytrVy5UVStfW8rDs9EXUTVV+F7IuS5vMum9AUPwJK22j7dP1+UQSflQd7PFoO618ECaXto53hx9oniB35pimog/s6U7S1wD1CSDbXaskF52bt5xTMZcBGgAnxJHcn0YxX8g2Ivp9oMpiOEKoLmzlYDZcOHirnHdwrUedUPLwDegEpJW/1ReFqn5FcA4u1JGEe9jyr721+2c4SdCNlW7kWteTnMjVpeNgCvgdPejYqMGEdzRBIrnxlIezNHcKikxqOemLWWEafA7ZAYdxZwxFTuRoObM8H8hN8Tg886UZowJuVhbF4zhU0=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4WY7KA+vAJfj6Ohsvs4YpV5j3AgdATFlsmgZYjZEvja0nU+FGX3UFaP4LiGUNkWRRsPGMlLzE9TM3Jfw76E9VTzZfWlyjXe6I+wjRTwikWIuJ6UbAb63VlBmHxAKPP21OPpz9y8wKfIgNKe7DntdijcjdCZjQE3/n+JFNsgvvTbmbUAG3ckKNTfX8T49NXVRXMzkLExQ+D8/lNepdlh2d15YNiOQhTlCmFvqt/KbwnkSmddXEGDS6o5UCxtqZurtDv2KNWA5WqnlwizY8/NNjYjsOlnF1mriQNCZIYyQ9KT22QdiDfBaLvqhgmZsC3S293247RF1X+VZthqqInhg4lg0HwS2zrmV9YysG4MinTVF7mNYtIQzQSu6xEPUWX5XXh6CxuYhPd01WYfWjImjxC7RFeLyg+diTYil3BKv0yEwi220Bn7LqqUYU7BPzUL5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:59:53.3634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0106f68a-dd92-4224-b1ea-08debaf4635b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
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

On 2026-05-25 21:41:00+02:00, Federico Amedeo Izzo wrote:
> Il 2026-05-25 14:12 Neha Malcom Francis ha scritto:
> 
> > On Sat, 23 May 2026 15:04:25 +0200, Federico Amedeo Izzo 
> > <federico@izzo.pro> wrote:
> > 
> > 
> > vccq2 is optional right? Is it verified that the optional code route 
> > will never
> > return ENOSYS and there is handling in regulator_set_enable for NULL 
> > regulators?
> 
> Hi,
> vccq2 is indeed optional, if it's not present, regulator_set_enable() 
> will handle the NULL regulator and return -ENOSYS.
> The warning is skipped for -ENOSYS as we don't want to print warnings 
> for non existing regulators,
> 
> Below is a section of regulator_set_enable() from regulator_uclass.c
> 
> int regulator_set_enable(struct udevice *dev, bool enable)
> {
>          const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
>          struct dm_regulator_uclass_plat *uc_pdata;
>          int ret, old_enable = 0;
> 
>          if (!ops || !ops->set_enable)
>                  return -ENOSYS;
> [...]
>

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

> Greetings,
> Federico Amedeo Izzo


