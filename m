Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA4EF8D76E
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC38783FC0;
	Thu, 16 Apr 2026 22:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rfiiGPY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB2A8407E; Thu, 16 Apr 2026 22:26:23 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538B683EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDlKCbWRHkDt3+FOimGs4Hpbh7DVdfTt2HR66KEu7awG+a7GhEvd3CEROQMkQqp9SqtaCpm56WpGY4QmJQ+NI1d0ccOF8dpaEZR5p7L93ZApeRh7SlyPVwb2q+qdEC3p1SI/Ml0BnsEv6CJj9xpU7iKTd4D2TtSxW7W5+AVMzRmRDV9z6bjndQfaXMIh7SbfqbyeRaLeIDpUo8qe1yYCgYQWAT5d/qWyokHmYn7AQaAYr7QywLuaH1zUMU14HebYpQkYWDASuDCiLMq1uvffiOxovHYgIf1i5B0FLci80hFfNhj3Nwfe/GQM33xMngObHMsciAKinvg5m7MiJ657fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HFR7LJ2xF+frZB5QIUVhiVj/aUHO0YIMdZU57lHpZs=;
 b=BY+GESMWEmpSFsk9BPsbci2A96w8xk1k+bPaPBREejSfyUduE7Ojj+PUxFoINPIS62LfKoJTiIfHCRaTBzqvbpmfc6KA7pTFr2U+MkmJNqZ6G2yp2gNt41Vur8G2RK4Fxf54M+0WmyQp7Kcg7C9cQm4FCru69HxjrvxxJ8aOT+8ZCHlTPuWY8DtjgsXF4Z9M54MpVyVmeOwYeSVGHGZ9YfWbj2bZmvZ2Gp6edqkGl3jcmGoJT+xPN7DeanT1svqaAyNEgl90wzifDjCx7mDoR3+p9iOU7GuzijA3KFWYT34O4dMkUZd+gzVKIZr1vz+WqljW9DDdo6RjvDlZGD+Usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HFR7LJ2xF+frZB5QIUVhiVj/aUHO0YIMdZU57lHpZs=;
 b=rfiiGPY1OgKPBH2yC0oD87be1TnXCG4bqoi0dZwmlBtasQ/t7yJASNLMGF6FW3dd+aA1CtsYoj0Mzr6wr6jrIoUlzfMdxNYzGqfFqDXdwxKHCPxqY4AMz/ESKITvQ/rA8ZN2vjJUm0wINX+cuBWTNU9chgUNdKSyyJmOujeCF6U=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by SJ0PR10MB4560.namprd10.prod.outlook.com (2603:10b6:a03:2d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 20:26:15 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::eb) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 20:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 20:26:15 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:26:14 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 15:26:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 15:26:14 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GKQEUk655757;
 Thu, 16 Apr 2026 15:26:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Apr 2026 15:26:14 -0500
Message-ID: <DHUV0ZQ8Y0KC.1HCMIW6TK4K9A@ti.com>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
 <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
In-Reply-To: <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SJ0PR10MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f5ca59-0618-4308-cadf-08de9bf6689f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: blaPqMJUXbM92jSjZAodbaqVRNyCiuI/VMpDSRrTKOvcVrDcFvylDGIivQEfEy6GrM7PHQ8pVI1VZ/AhzIJYh0u92njZRoVZuc2EIwNXOIY5AObCzCmkMuJYRxRvddkK67m8EAebEapPKD9M1hFc/EamYs4rUe7gdtpXphGj6Zro7/hZYAuT2+bCx6TEtcIw1Ed4ONme4XhStI71uSjaijEH+UxyiCO8XgSxcFKkVWc6RMn2JgQDj2Nhl7hlipDNhIUTYqzkLVpPVr8R9r4mIrmlvH8p1RiLy8SeRuS0VGWuBCTxyZ2Y+3e2mMMuqVcVb7wKoduiwhWtU6q7Crx6AKsMJ0ASV7WkGMBvhQZ42/5OgCNJeL5NW5wp8rQu5Pm+H9HZsKiLIGRLSVI9mndLK5UlvzvPCfxLLyW+4LAP4+53drMM4uHQDTBLXtaB++msumWhUUIacIXAO48RNSKwTmpTxb7SWJKWYKDOIYDTt7n4HRVJl2blxV2CDWSQHcOwcG6bv2SxxsqRtJ3nj1YG5NAbsizCC7NRMc9LURfBfZBlm1n0JdZ4veNLD7toSQZvFF5ghbuzZ4AsRzVnCXdWMk42z2YPNbuzixjOYz8o/kQQnSdCwkXjxyL2xR/e8ilOYt2v0RwLgtuKzPlIrybFgafl1kmifxf+AwHGCzB3QTklxeGnrgtfRgyamAfFmM+FBa6hVgK/oLeq439Ofcw9CuvIKulTzFq0vheaNNqx4C/gmflUFWabOIugVYZKTZCxI42Fidru/SIjEA//CEVJEA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZP8cfwlNijUGRgASl8OPfHtR2f4SU/CLOAPu+W59AaKLb+UqkqYx8YCLHvi3u2695T/WbBhoMaZ8zwrnBk4+DU0EQBKW2UyUGdch5hvNWZ7J9XjxQy4wQWdquyP6jNM+oaZKWtOoXQAurAYc0dBXDjHjOMuko/Mc02+EMdZrF4zi9a6mbJyn57dL+4Dhbr6A9Qi8G4xCCsqbMqoVtzLL7qCYBA2ij4ry60+q7+pXd/xO/7M1LSNYaLiG58SqV4KQkX3xMMjD8j1liVTxv2WEjCaMTbMfsnx7Pf+RAQ9FITu1vOOrNdutRURv0XS18UYDxqsJUH38Hz/c5L3srBvHXUk00+1g3uwK1qocno2i2CLU9Ko3rHHRxqsteqD2Dp6X9QaU6dpkwYB1RwP4bBBxetmsZ4lS76Curzc6cZ0rdgKlIhEMqTr7kK7GiiD5uyrX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:26:15.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f5ca59-0618-4308-cadf-08de9bf6689f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4560
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

On Thu Apr 16, 2026 at 3:55 AM CDT, Ilias Apalodimas wrote:
> On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Check for duplicate memory mappings before reporting any incorrect
>> attributes. Could be that second allocation has the correct type while
>> the first doesn't. Knowing there is a duplicate in this scenario is
>> more helpful than just reporting the first mismatch.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> [...]
>
>>                         }
>> -                       found =3D true;
>> -                       if (memory_type !=3D entry->type) {
>> -                               efi_st_error
>> -                                       ("Wrong memory type %d, expected=
 %d\n",
>> -                                        entry->type, memory_type);
>> -                               return EFI_ST_FAILURE;
>> -                       }
>> +                       match =3D entry;
>>                 }
>>         }
>> -       if (!found) {
>> +       if (!match) {
>>                 efi_st_error("Missing memory map entry\n");
>>                 return EFI_ST_FAILURE;
>>         }
>> +       if (memory_type !=3D match->type) {
>> +               efi_st_error("Wrong memory type %d, expected %d\n", matc=
h->type,
>> +                            memory_type);
>> +               return EFI_ST_FAILURE;
>
> This check is now outside the loop and only checks for the last entry.
> If you wan't to split the fucntionality, don't we need a loop over all
> memory areas and the type?
>
> Thanks
> /Ilias

Not necessarily. At the end of the day we can only really raise one excepti=
on
anyway. I just think informing the user about a duplicate should take prior=
ity
above mismatched attributes. It hints at a bigger issue.

>> +       }
>>         return EFI_ST_SUCCESS;
>>  }
>>
>> --
>> 2.53.0
>>

