Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33828F531C7
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 19:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D50F83DC9;
	Mon, 13 Apr 2026 21:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cxRhKStx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF918407D; Mon, 13 Apr 2026 21:24:01 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6AC839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 21:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we/pPz2PF2Vh54vTO4IL0UUZtsSQBFd0WVVWqW3pxJKkewiptCgFeuEUji82mDf3BEipXvbbJS57wl8sbcoKYs0pUZu9x3wznyfiSztWbrUzuMZ+Q+HM+V8GhbRur7Awi6btb3DSVs1DaUFvTi/3spvTFM+Q7JUnk8Gm2CUl88Hf1EQsK7hA3B3mMiFdkZAfLbcG2fUPwdwiFBoTA3vLjqsHsO85rrW31Q97oFigy6Fe9G2E6a4EijSQ9yKRk4fguzBgpjxTIFjQZXKA5/eyzOpS9m2Htc/yEPA37r5a9DrZWqgDk+BA5fjxoGrhVGWzs+kcflMawPVUGDp1qp4YEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSu03rATZZXdV7YDp9EzuA9BakZJRkl+eclPUThT8k0=;
 b=ka7XngQmmaBZXOJy0nok/Qu7XiVGLwUefS7JAtKhzbnz1TFyzpvNhkH1IuS/gq6N8KyXAjQiSGJu0bZvtNtmoWSwphIRKFJBuJhkahTGNa7s1wRQg7K9lHXtAMG3ZviSSOwOpKbT5WDjNNpGo8mspysVSERLr9ZjQTbJxa30+xRUZPHGJfY2/3cBJhFVuefSFg73OYNevC6B3+8FkU90yDd7caRc7poUcJkgx4635uLCDCmFXcur7lvvE/VJdRXoVCZV8HViR37d4vP7XRT+jzQkJnl68fIznXCbYJiXl0YQivlEfUbTDNsEip3DBqZpHHtqN7YVwgTJnO35OZcAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSu03rATZZXdV7YDp9EzuA9BakZJRkl+eclPUThT8k0=;
 b=cxRhKStxaPBWxPrQXjcfSXQjjqPNBbJ+PfkUu8XzOypnRmxCl3W29W95Lrx/Kw8mW/exqzTNtB9C3+aNFi/KQDb8EgNXF5Qcb0WVjD+OYV34ogjpdfXda/UcWGG1gpV7UZ8BRg1ADWvqnyeOlCdaTIXJ6adAIzWd/4ynmYppuVo=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:23:53 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::fc) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 19:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 19:23:51 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 14:23:50 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 14:23:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 14:23:50 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DJNoqw2641776;
 Mon, 13 Apr 2026 14:23:50 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Apr 2026 14:23:50 -0500
Message-ID: <DHS9TKSVNH16.3L5B7F14AYYTI@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCHv2 4/5] efi_mem_sort: skip unnecessary compare
From: Randolph Sapp <rs@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rs@ti.com>,
 <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-5-rs@ti.com>
 <59AD8D70-3B2E-4969-8E94-90BC60BEF96A@gmx.de>
In-Reply-To: <59AD8D70-3B2E-4969-8E94-90BC60BEF96A@gmx.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: fe634b6c-baa4-42dd-e446-08de9992322e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: wCudq+x16PhSg7N20RVpan1TxBW47EJYUOTGcu+VZTuP7/Q49OGaPz3QThPpd8LRXeLdvVJnwAkE65WSmXyHN8NezAJUS9/5o+Ye0TWjTpNeZ2O1alWi0bSzBHQvA6IQGfEj1TgV8tJXcK5LHocA8E2AXXjLkPcdxpQvebaGie7NB4XsQ4CbgK9RjhH3xNH+3egVbHtokm/0CGS54KoKAUHpt8FLWOrQt1iXPPehkWQYdcmoQ6QaqSPfioTy3XLKARsw5AC0LZhCDB9d9IgwCz7Rt2DsZEPazXPEawKwmOSbiTLobCjVh0S4WsvrH5Z3dra6g9tvvd+Dt/ibUHl/NvpYQTFNKfBnIxGwXSzYcqY7wmtA3AzNp4vYyMGfZn4AxZkyXFh7wdGlo3CtRm3afeOfj7zZngo3DsTH8wpt5ZOq9OBn+H7FECIiNRPC0BrrF0WQtiIvKvay2NwqgBET7mKg+EOSD9jKl/wzXR+NaoaU+en/jcNGYyeglBtIDcTuIpuQh3ja5zCpn3d6COIW0+Ok/AHoByuhRmpJJ/knF+XVvrN6dMukQiXohh2YO/fhXCm+WDkQiLHmYSiGV+iZ0pcsiPxu23eE6Nt54DLb0XrKSNmBCPqV9ZHZ8asdLzrNik1LR/xFf7vxe4vNLchRc6ORJ6MXuiWue/9i63igYVSmPQwlJkMk+TEwJJVraxNrVSv1tUE4Kxi2UpfDT1SQKePe4Gy/zcJG+3oI7Igf3AdyTz+2iccFs/U1wN4fVPczdb6IA32yfwFUvnL7T+ezbv6NOTbcnvxpmoV3WanXfK26hpBhz+VdOrKADw2gCU9W
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M/pvyO2jMWwRor/uLveFciLlzluR5wEjiTygwgvGYDBVnhAk4K1QyfGQtjwaDMx9GRyXo2VZJrFNqB+7gpG7wJibOO/enJwa900W9lwZ1kZtxJuS0Xu2Sxz05p8NdFbgv6npCrtdjW+pSRTVsmiT9RNEiYi9/BT5mgTZrnTfQ67e2kmRzcxop4LYeZ6ft9pTDFd+u3kqmmVSmAY6G6VQhjiUBNX5s3k+7nUW1C9uxiJ4Z964wXPfBu+4Le987C+3byhk+EdVpUxA++euuosArb9psHCZTHEtrKPtHjwNx0Cm9BjWQSAZRNZQ52Ezx/mBs3IeiP4/kgvvTIS/5LSa64dhmLOiBNh6T2pfbrxp9yVeyNCnHxRwgqvV00+d9/LiIgWGGBt4CSGK0BrLIoQ68C+FXjjCoMJfwLMrDaaRTBqrg3oxivXaEHHEwo4EjySj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:23:51.8007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe634b6c-baa4-42dd-e446-08de9992322e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
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

On Thu Apr 9, 2026 at 2:47 PM CDT, Heinrich Schuchardt wrote:
> Am 2. April 2026 22:50:37 MESZ schrieb rs@ti.com:
>>From: Randolph Sapp <rs@ti.com>
>>
>>I don't want to think about the possibility of this pointer containing a
>>reference to something from a previous iteration. At best it results in
>>a some arithmetic and a comparison that should usually be unnecessary.
>
> "a some arithmetic" is not understandable. Please, adjust the commit mess=
age.
>
>>
>>Signed-off-by: Randolph Sapp <rs@ti.com>
>>---
>> lib/efi_loader/efi_memory.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>>index b77c2f980cc..882366a9f8a 100644
>>--- a/lib/efi_loader/efi_memory.c
>>+++ b/lib/efi_loader/efi_memory.c
>>@@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *d=
esc)
>> static void efi_mem_sort(void)
>> {
>> 	struct efi_mem_list *lmem;
>>-	struct efi_mem_list *prevmem =3D NULL;
>> 	bool merge_again =3D true;
>>=20
>> 	list_sort(NULL, &efi_mem, efi_mem_cmp);
>>=20
>> 	/* Now merge entries that can be merged */
>> 	while (merge_again) {
>
> The suggested change looks correct. But we could go further:
>
> We could get rid of this outer loop by either eliminating prev instead of=
 cur or by using list_for_each_safe().
>
> Best regards
>
> Heinrich

Very good point. Didn't know about the safe iteration functions but this lo=
gic
would benefit greatly from comparing current and next efi_mem_desc and merg=
ing
into the next efi_mem_desc instance instead. Less arithmetic, iteration, an=
d
generally less room for error.

Will apply that.

>>+		struct efi_mem_list *prevmem =3D NULL;
>> 		merge_again =3D false;
>> 		list_for_each_entry(lmem, &efi_mem, link) {
>> 			struct efi_mem_desc *prev;

