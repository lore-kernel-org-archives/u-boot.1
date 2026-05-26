Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B729CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD27D8464D;
	Tue, 26 May 2026 08:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gNjHZ7Fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39EC8469F; Tue, 26 May 2026 08:56:24 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09EC983EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUD71bRUpRSwY9a10Cnaq4LQrpTYvbMlHS/Hm2kkhF/7Skw0P1l3XwSY4TCwL6apVZ7/auk2XAt5HNoMnxMksuoNED/1X1hf6eiwVt7+gCkRmTXUXfyRb8VJtfbHCosq4iYFGHfXxSUqkN7RSTRMlaLBlTIRyjFlthXsVf8Tt9VCeH698VSUkZ+YqE55fdXciYfubS20gomCHsDD7f7kfwj7H6CrpdVuy7fv/xuu9QrX9Yqd5jia786vhCxNCAOVhTE9c7vZp1ccI5rOLG5hBff3CNaDChhBSh1DvhtTma7YFCvFcxgvEIlmuWoDfKpQ6zukGcAPEZ5cGcRcyCYwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOgGGRygSPIE8dxbS9R/JJKNFjWtyIU92Fe9d6VUJsA=;
 b=B5vDtUo5HDSGydMXas9bytu01h+//T+femiShPxf0HuWHMV0VpAYnNhGyz6jOxqpLFWKUvEyBLFll/jVJxvtymvlnBjegUyPllQdbzy9d1tKc+3DWFgQ9Zo2TC1unzfAC9JCaPuBqpZ4VIRIXWZijnzCQPufaMCQjzGo1m/ihNeDjdDxltWYxYyDo8jXM9yZmZ7yWx0zqW1m/BGZqb1nNQGjt3+S4pZnWORYXtxKKu9uzmIzRFRK3qMgGE2MYdSWuOUUwucGVfj1l9nq1r0GIqabQdf8RNuCcRwqH0FzZjyRyONLSqvxQtNjXsl9UELfRTG04nsLc5BtW5tfbZAUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=groups.io smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOgGGRygSPIE8dxbS9R/JJKNFjWtyIU92Fe9d6VUJsA=;
 b=gNjHZ7FkdLIhEn4c6fnhDrTa+Lcanb6pE8phXs+9mhhuUWmAfTGwFLDpiKuxZAIlCbskw89+aoEHbkGdDD/SKvPZ4CEO+O2xf9o5Lgb0sICCSr3AFlB9iSGgs3EvU9IqpuFWyn9cRzfmoGVe1IsdddIOoY+KVxKhCyrALiGrjkI=
Received: from PH7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:33d::9)
 by DS0PR10MB7512.namprd10.prod.outlook.com (2603:10b6:8:165::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:56:18 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::18) by PH7PR02CA0017.outlook.office365.com
 (2603:10b6:510:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 06:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 06:56:16 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 01:56:09 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 01:56:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 26 May 2026 01:56:09 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64Q6u5Mp899508;
 Tue, 26 May 2026 01:56:05 -0500
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
Date: Tue, 26 May 2026 12:26:04 +0530
Message-ID: <177977856459.1764621.16001673223703740919.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779778565; l=1129;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=EhMuPLHTxk6RLZFtERWBc+JY16dBIbLPWD4NGE8y5FQ=;
 b=t7igT0HsO3+nrS+Itz5GmgSh+d1bYwjU+mlTdtIRiclHliwsnaQe+8mGaSqszieHyfccgKkdn
 ORcO/MAIWg3BqyyK0BFYlIufmg3aeIT1Kfd+aTnDFuMHyawB/wNacET
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0cc137-f8e3-474f-785c-08debaf3e22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: hpm9ozpp3wUhel3B0UmCGJmYSUH+AV3qkmAgKsUWBefHqZjyH9iOB33wG/U8irnzAk6cvtG+itG/XJDxsjg6d9V0JubT/vIp6mKHpi9vs1rjXNl5qVSmSZbX++beZHPN3ZxeVoEjygNdxAB4MPVgQbYtTgj8YR+Rr9HILjR2jwPaEWhH9Cg3Wlel+vHBPGkLaiN96DoAg/OqKeRJl8k1lxwiGKnGa93ZeiBcIlJib5WMFerz/bwkPCZ6RD/y9RJKDIXGePM1kkjL43zidBYzLs4ClY52qAei0F9t43JckQaJAUcsN87JTFbsX4hcUmUNdwLoo3EcSgbNa7OLWUw2cC9HNEycsJEmWh47xe4C1Fdl44b4cS+uB9CSCO+CyapdX6y5TBWfuLRNB/xis7DwqKgCHhB/w6p7zM96imboxRYyvEjVhazqZYFaNKxbl05FzEJGUpWj+qUB9xojYGVkO40sz3aJNSKK2v1cBcGX8hv9+tfwTNpqhkjThS+CzDEl6H8W+EOj8xCZbCVS0ZWtVhGiUWFhvYF/MQTkOUuFm+kmXQcuUon1Ckl06+RP1A7MJyeN0n8c3r1u4QWEEzsJZDRjEcxtqlEPk7GNIWbcVKQlDoLTCG9jpntFThtYvO3fuAAM5sjhHhJk3+t6awDua1EMxS9PtsVc06hCVaDaXejQ6XICuROhM93uRQ+TYPGDcK6zqErwRWuECdZiE6TDb7EaHERvtSA14pcvNHgf2Lg=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ck8++n/vUFglc9I0MFZeKCrKTK9q5usYICs2B8OcMl5+4Js0vSuiCzj5MP6gi9lxf8C1GckjAXFpg18OWduGFE3oJdEsJFQL9cCVWpWsx6RzsOspSI9roRViK8u389ZtXdfS1iUiKkyZKrj5l9rrJH84zdE99onfIWzWiBlpVryCXlNyJtYb8vlYBnbS3OpBolDNjYj5/68gueNtey5ev8DtnCknrgaEKj79PeFnGvmR2j1CYu7i8btCQiwqDgpY3sOLa0yNFggzbG1pSAyFpczmQ2oWGW6j+wD/nJ501b1j9lNDtvELGEd+K+j6X/l2KvU5L7uUO3cekVjZzIamiu6VX3oS+Oox5S/x7QitrQeAcjsYgTMArX7wjbFlLku5krGx9QilL3GjgWjbxsuVT6YmUMZ5RLuG9DcfopacC/tSg3I5F38mnAclplKMs5YH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:56:16.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0cc137-f8e3-474f-785c-08debaf3e22c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7512
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

Cool that works. Thanks!

> Greetings,
> Federico Amedeo Izzo


