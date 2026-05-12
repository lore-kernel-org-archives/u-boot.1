Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80610CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574BB84099;
	Tue, 12 May 2026 07:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q0spfix5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1EB803C6; Tue, 12 May 2026 07:53:48 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D7583015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrLisG2sOMr3neE9BzY+lGizySM010RzOG1LdCSMQXQuXo9xiFZol5HqsPv10jZxSWfw/g/sK/JpTC03TwaDODwf4CD8xw3re3Q8Mrz9MIXXsNpZ2AWSIAo/KFUNxepty+CpcF5Wxo5TxjWdj3+Q4kggvf67mRywt6unhm3UcYV8MMoPBDoHK2z+R6TrbYnIC+lNSW+fWLSLvusAT1qcu6r7BQZrvqeXbR257OOUo/dIAfDkaTEYmDfun16FjfL4DyZeEnk57UA8rz8kiZ/ix4JqAxr52Mr1pQDRihZDSpvjMberXyN8t4HDmPw5O8iQWfZPSurn5LY5hAgD2wojdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv12y60Bn8/CGRyVDCqrBCVQnpwVk8PBlt4JIYgr67s=;
 b=unsHLZMMPEabdOgC9vxWdk+SA8ffeVsGqrwWLI3o8/w3PmJVv++I2o/sP1KI/9lqaiFdi2mIwRwne2TO7VizuqIQElQNeSDTBBqU1shoMpG+9VL2vbI2db2A/eFo7jXWaq2QWOTQ0yPbNMnX0WUNVgGRpl4FNM6Kpb9jCWc7hWV029kR/J7kRHtOsINkeX8jPttKU5CNLNxs4472YSozmT5+j6cnbOELvRUB2DWMrYDxXQnijkPXR9a1oUwER29IlTQ+3humhqpX9paEl/GOj4AwFIUS5ruiWlw0ek910Mc6lppPgpWc8WJ68HOM847ZU/vI5aWVzVmf0OHvw5DAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv12y60Bn8/CGRyVDCqrBCVQnpwVk8PBlt4JIYgr67s=;
 b=Q0spfix5m05CRv06i/BRRy50VqP9/mfNH3BTIZ3TLnOOThqwncw/A8Veea4T5xjmkdijEt7wvFDutoeANpHjB43WoqYgutV0RQr2tbm0w4b1vHofUYp41EQq60wX6zGwh6V0hcSUDivjo4J+nfBAaoflEoVeLZwcgJjrxssViws=
Received: from SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10)
 by LV8PR10MB7797.namprd10.prod.outlook.com (2603:10b6:408:1e5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:53:41 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::93) by SN7PR04CA0185.outlook.office365.com
 (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 05:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Tue, 12 May 2026 05:53:40 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:38 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 00:53:37 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C5rade1157805;
 Tue, 12 May 2026 00:53:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] arm: mach-k3: Allow for calling get_reset_reason()
 twice
From: Anshul Dalal <anshuld@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li
 <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ji Luo <ji.luo@nxp.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260511201235.1066697-2-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-2-alexander.sverdlin@siemens.com>
Date: Tue, 12 May 2026 11:23:29 +0530
Message-ID: <177856520963.106112.14407368040436691226.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778565214; l=875;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=/d5igI/WDidN+j/DG7IrZfMvuRCVe3+bnPEKIVjxe3U=;
 b=GtA5oaZYlCl3+PhjPbvvshDIohK+XndY78lhIOwm4bf6D1o5ePM+qKiyAA6cumlttgKAkwOJk
 h2NwqDWtK6vCJ//i8N/7Qf0bw/zUwKnvfkIDx+RvJZcr5j5xU6f8JAi
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|LV8PR10MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: ba607cac-0ec4-4332-f54e-08deafead147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: t7vYIqnq2sYhHL5lmblBCms9w6/SjV9rO9DgTi5r5AU2RzPFV9957SmvUxQFYv29d2PP3fuD/qf63HFKoRjd1ztc7huikGrWG3010wmABqvIZBZ7s6WnVTAxKmeoLMzAsyovWQOD8OXpa2CtemlsGIcl79sTv+1jkncdrLCTeU4ZBdqLTp1LfWNXfXhKflIV09rdG66o88Y8fULe9ouWc+9ijlIFd5iyI8wtKrIi5sIoKwOugmGQaKOvdIyruDcK9wOPfdRFsP8r9Lwda+O4fCLiMHJ7C0mIpZNiqFIr56ezzWen46YfnMMlH5iYe/NjFmZtz68LsoryiVjQ39FwQUmoSHKVZcHPFG08tadaiDmMbX3b/pc3wufTEMUDv1TO8vZEEMrala+C+BrpU2ma3V4yVwVmlYmWgj3nYggqsvwJtwD38a+OAtLSOCRLXENrT/YdPzFJpZBHaBwuZof6rMc7Pa+gRRhOu3u0s4zaiIbr5jYYUqsqGmnJwDvOe+S6BGcH6j84n6i6DO1yheIp8lX0/+t0LiYXodM7rQvMGuAZz3uluShRbTksHxOd1epNpKagzImDJpNJAwFT6NBY5EpQ+/99oMN+f26o2x9HbGTV99shjkcBayatk6QKpYmzMrS6MdHvk+jBNIybS9KlxH8jnKgSKeuozntvwIEJPMgMF0eCeA/SPr3Fk08RCn2U5cHkgIZV0sZEMSTO+2BUXEtXO/Do/S+8X2Qhf2SAwXk=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ufam6qBxd4IznbDvvcURlO4C3ckH81gOv4LbTqwwWHro1tdsqO1h2dUVUCojVUY4qZb0wnh46E1QoMrcH1uBpPZVj97CVqQe7e58rl2nr2Cg6PMoJhBQrmQY132AcEHCEXM7i+BdPfy0hgAEqwVxJBj8w9vg7EpyRf2K3Jk/wxAwH+JYkpZlbVIwI0BQqdDtnhhjbgbLDzPtptheQeq4tzHZjGP5jlGgrkmuU402UsV19Wzz1OjxkwCvqhKcC7IqgIcwuL9LUoK+0CjcpPe2JzGQK28lcUVQksQPHev4p4lTRehJZsZvctdVQPdQT6CSFraID7uL/O16X5mkef9Zty7Vo2ZdPwf9fZ4Jy2fmgo2zPdIAql9q5wUuAt8M+56EXcnZJ3/0DkvFV9/Abx80TgXRbZskRUN8SIpxloVUEGpdML1relGWFcmWjC9u7zjd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:53:40.0815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba607cac-0ec4-4332-f54e-08deafead147
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7797
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

On Mon, 11 May 2026 22:12:30 +0200, A. Sverdlin <alexander.sverdlin@siemens.com> wrote:
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> index b2ec450f900..c2b20a1dde6 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -105,6 +105,9 @@ struct arch_global_data {
>  #ifdef CONFIG_ARCH_IMX8ULP
>  	bool m33_handshake_done;
>  #endif
> +#ifdef CONFIG_ARCH_K3
> +	u32 reset_src;			/* Cached reset source register */
> +#endif

Since we're trying to make this an architecture agnostic hook that users can
override, I don't think we should have it conditional on CONFIG_ARCH_K3.

IMO having it in bd_info while making it accessible to user via 'bdinfo' command
could be better instead of only displaying it at U-Boot splash as we do now.

-- 
Anshul Dalal <anshuld@ti.com>
