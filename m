Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D340FF6E8C
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 08:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47F28410A;
	Wed, 18 Mar 2026 09:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OodhUyCG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OodhUyCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6C18413A; Wed, 18 Mar 2026 09:37:56 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEFB840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T87OZPYiueiX0iLVCIfMJtFcLP+BRpjihHpHifCA2HJnRdVujHKq519H0SSy0QRJjcc1Ja3aPxIKSpU+Yz4hj1xQ7AOmSWhTEoWVq7sBs9Tke+Ve0WlLUn5CyNXiFx0Gh9WtAg62VcbJB8dTT4F9mKizk3de3315LTU6j1t1RLTCcwBK+iuF2Ca0wChZLxbcsAVwsxqECRkYX1GwNzkZkhQ1/ovkXITJgyQyH7ML8f++qTAxCAODG5kcgOa7SfZIORZnni62v7YsXBtWhSm2V6ukwj2ZXcTjgBTQGvSX9De1HErryX2G7AiijK0BHpUHoVDIP22A6oPWWGS3MboUmw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPQ3fbh8+tQPXqb7fh9lkTNAJdIJkn2lSXZWLt5/TrM=;
 b=B+XxhCXB/Izves5I9dfKwcQeepXBM8PJBTFX/VpejdE2Mp1RQ3dpNrZHeIfs1dVCM9XtMDVMwcexznLEluAYjHQYMaU17t5ii6TQn5kXyQdXPvrpVK1OZzkgbd87rspbnztx68xUINCYp+DfkBpW5Gl8XsdBfX7kxFHNle8OFrXUTOtHaOlKAjeg+nCxaQbdEWOY+pBfFffwZa/ow/f2fHZAhmSwMDvBH20N0hL2X38fZkaGzATCc4tDVNAVw7W2JtlJcxaPRdZ5s/zEKVXOeKc1U+gxSO7FmA4c/4b4U+5lLn5Qhqmjx54tdqzVBiAKbOM+jstkigtVDfjagJrRDw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=altera.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPQ3fbh8+tQPXqb7fh9lkTNAJdIJkn2lSXZWLt5/TrM=;
 b=OodhUyCGYhcUc/zxZI3RJT6YxrNzOV0LxNbrUvPtpSQDfU1qiGh9COtjiQqSqAktsRras933P5sJiE5P4jOE3bjv5NKEqh7kcJcpL4QXqBe7nGWCKjW2odqLOvAV2SaZ4y9Z50bfFnhfHQdMml3KeKdgtHcQb01xQuVYYVG80lo=
Received: from DB9PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:1da::7)
 by GVXPR08MB10785.eurprd08.prod.outlook.com (2603:10a6:150:156::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:37:45 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::9f) by DB9PR05CA0002.outlook.office365.com
 (2603:10a6:10:1da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 08:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 18 Mar 2026 08:37:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgGIRhHDBzGDbxDdQxlFFksFG/tj+CuanzXHxfLuLuZ92ULlaLgtQa8yE8OXuVbpw+BummsR3uMx6fK+dRwDA2AR3yu4dH5KH6D4gPkrtfKfRtlDuEu6GdYZpbtDJcvJCs14X/YWNTEOEuvEzwqQ4k0spo6CMlJvYhDh3zoPSSo0cT+b/t/V2oLsS0u9mGrntVuPRBMgwfKOczucE86mg+tnjAZDLgG/UfUZTAXe6kIanTD7D8QKYR0kkfYXaI0tfOsFtQKAXWyqj7Nc/MWLArq/leWevC150AKIsqBUgdBrnslcWD/fTGhhOlWRhoXTdHA6uq1HonnICU/2u0GfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPQ3fbh8+tQPXqb7fh9lkTNAJdIJkn2lSXZWLt5/TrM=;
 b=Nc+a1mFMrJ7kdOHAEok+3uCj4v111dYL0HipG53VJ2OkjGcAbi9pXf2Ux6lKkfJiSU9Pjt3eH+jSx8cC3F6Gw3IcpUMJrswZPURNbtX6ayO8GACEFCxoW8Mo9YgKeK1zGfgGcQdhJ4O7KZMAdKgGmVvCFnF92HD61uL0vtJd5t1HikvzrJtVReYCpTRrv7jnB2rUCDhZK3XvLmLozT1773L7/ofbjiP4V4ktuBrzUnJdoyJMFNu9rHCRs3YURB4Zbgaq+QZmx1QWu/Naj7V0Z7VMoCx+s2qARDC/IQ+7JP/swFeHUXaQxMdGZprV3ZTWm3enUJBpQVWpuZ3ze0oqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPQ3fbh8+tQPXqb7fh9lkTNAJdIJkn2lSXZWLt5/TrM=;
 b=OodhUyCGYhcUc/zxZI3RJT6YxrNzOV0LxNbrUvPtpSQDfU1qiGh9COtjiQqSqAktsRras933P5sJiE5P4jOE3bjv5NKEqh7kcJcpL4QXqBe7nGWCKjW2odqLOvAV2SaZ4y9Z50bfFnhfHQdMml3KeKdgtHcQb01xQuVYYVG80lo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB11832.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Wed, 18 Mar
 2026 08:36:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9700.025; Wed, 18 Mar 2026
 08:36:43 +0000
Message-ID: <7c2b19c5-56fa-4e7c-a5f2-4cd923312a93@arm.com>
Date: Wed, 18 Mar 2026 09:36:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] phy: micrel: ksz90x1: Issue PHY soft reset during
 configuration
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nikunj Kela <nikunj.kela@sima.ai>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, nd@arm.com
References: <20260312112247.30570-1-boon.khai.ng@altera.com>
 <20260312112247.30570-2-boon.khai.ng@altera.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260312112247.30570-2-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0505.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB11832:EE_|DU2PEPF00028D01:EE_|GVXPR08MB10785:EE_
X-MS-Office365-Filtering-Correlation-Id: ed489228-9e04-413b-a785-08de84c9a0d9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: TRSf4nd8sqCbbDm852GgTBa/RpJ3fGDfpWIH7rymTJ/+8083Tl561X3n7GO9SD02YjmpDPhAafmJKGVDDKAE6e1vOGfUXhaGtU/aAqfW7K+v2UvotNC9d9GG7DzMZ9oZABajarYq8C1gZ58qHmEiwQz4zWFnNBKYiDHLNiBYAW6oJE33KAFJA8XpOAEYS35Ax29Jqn/6gOiGe+PNKW/X2llo/Xw3NpFHdzttzrQIikD4uB2k55YyEc2UGNVvF2Qjbhk8JxjqamB2ho3UYiz80uu3gEy8ATBPdETWrBfvxfdFUgyMMbFA5LD+Vh7v/bOJMIV8Bv8LXARYhMIVP0TDGLEDQCVbYkAJkv8xO2sGgZp+/80gRh6BFHaWwMlTrKMLT974sSXNXeRsUGQtJf7S48NV9pgI5YIpdEydTFtciUX04pJzLpua6A5xqY64XUzm2SdperHG0BqOXvduh8MZ2m7JZVeE5d2OhyL380uNkoj7ZhswUSoZUHAV5Wu2yvv0WS/wTKNzP/krZ1m+XUh3BgbTwc9rLWrWGcEAfpCqCJzCVs82UkPyH1T7njZVmk662ATBU9WlRRyO/UH+pTUNmYkEIj7JptfyREDeJ5KEJlfmx3E0t4KmR4x3KCnHoRQB+Rw9N3sK7++9i0wniwnZ9L8+6R9ADVzFDp0tFyXcfOn9bP3ERYdHB+c8VO4mqnLCXuSsdAzYp0Dt5pZcVzEstHnzy1YLXZlL4HcBKr4wbrk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dMiprSDlsfXdu+FsdMeRsd0iPohNqMt69jC+fOYnzn0zCbbbpQJY2rsDunwuxI4/4jY/u7kcwTOcj3Q4FEum7rBjNJSRQAdwWAB4/SkSg1vqiFctnI2pewzP5TULvUp7IKNXghqIkwABr9a0f/R1v47430SNpE496rIx0rrbXtdikxgihKadD0RjV7OvyVM19O88B1UO+fJKQY4IbaC/ZHDAP+G9XNLrneq4Bwvcd+LxYe5vBfb7zyo+lHuJAb2gvZYEkrAQKWzMLcxut+HYu7Bo7sLzVEOitrnErI+8+dxcJSMP8Q8CzE/W0WCv7TpXanAMuvq9HtqV2hWcRMLtsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11832
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 342ec63d-3ce0-45b0-8b43-08de84c97bd1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|36860700016|35042699022|7416014|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: UvbYxtylAkWUtIPxgnTWXVlEU1N0zYI/2tVeGMfSsw6NNkHd66POsLyvzMDPwMMCqd0Mh6wpAHhTP0uZpc5GqNvh+2I2OXdyUAIAjvSh9TE2opGnnw7y+7nBr8wICGN1HeXPd8NyIs05pDFoHj3L8CiEj4lFAwjI3UntxVXckNPrJNvp8ExFDeVfCdlWUn0PXGafQwy3MgV5A8lTnDjPxLJGKug6OeNChZxVkT3NJ+rdbFQlMm0ftHf8O1DRHz9m1PsH9nOSLuY/oI+EcBxEOnFJxUzwlB7yZD7Rn15R29jrSY08edwIc1/EXD71USqeSDZwkoL12qg3LKztEpp0Jfkq+qIjjrqnYrZSCX/Ic9XTTUtYNZKxjIXuOmDQZbYF6Go+f3yRy2CkIp2hSYgXPpgc4CdFEhOdW/S2NVxna0MOsqalAwjWXDGIbRshezs+begItaVXGXV1o/3XHHR6Ej7eaGpC80rGeHMvB/uY5/YI84sQEO/KW3dRAXqE5oX09JdcQ9tkK0ZkH9NeocDK4nFDEKh6DWm0pd7qZhaZKdIYfpnxYpkGyOOvhiIEc5vHt05XoQyypNXv+HkCb8BNvRZsPkQPc53PUm5J7o/C9mZeHs4ZtJiZY3/0DRwtm7ZSpg9RhQhzLxtAS7x6oTPyHvAUAE+0bmCpdPnyWC+XmKbIJOOZVbB8IDtp13MfS6yIljwLLmnLt+JJf5E8VNuKa6t0Vj92anPaQXag+kwkbE5KP1F3OvAGKa3/31Na44KhOsPOxTjIt5jZ9XcJECuIXQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(36860700016)(35042699022)(7416014)(376014)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 59X3H1hn+K03m7fRn1eZcMe1OCdGfVEalTOh957SxVp7Vul80+IimGsfi90upFeR+frqw0cmi/MG1YQ606a62y5oJyr3MiANLyQf2zgSFZLs5fcHLJ7DtSpj9vYj5VHQ5PGXE4mAhTeJu23E56URnfMVH2SWguVM/0s24JfZ9zg5i66+JIVRAGYXhaEsRr6Rtw6FibwKaPwkcO2Tx8TTEw8a/UlJISCe3yd52zlXXR86GjMSrQi9wpL+omD5OkC9LDxlbtNabjAfRf/NGwWrBTxXfqLBxpFc8LZvbnvJxvk/8cC9rD38thHe59QBxAd/TAb5fAVqPnVIKwk8S2hF8q+FiVCsMjwiPympG4fislQev+O+yLgsBrZ37y+hkIwRrOhN8CYJE3IarBiwB0Kj7K2/2kKQW1Xli2fCivlnIDq5tuS1o5eC07gVmuW/fRsD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:37:45.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed489228-9e04-413b-a785-08de84c9a0d9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10785
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

On 12/03/2026 12:22, Boon Khai Ng wrote:
> - Add a call to phy_reset() in ksz9031_config() to ensure the PHY is
>   properly reset during initialization.
> - This clears the power-down bit and ensures the PHY recovers correctly
>   after Linux reboot.
> 
> Tested on Agilex5 hardware with KSZ90X1 PHY.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/net/phy/micrel_ksz90x1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index f357e0f1c77..1a7116f4ddd 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -407,6 +407,9 @@ static int ksz9031_config(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* soft reset */
> +	phy_reset(phydev);
> +
>  	ksz90x1_workaround_asymmetric_pause(phydev);
>  
>  	/* add an option to disable the gigabit feature of this PHY */

Queued for net-next, thanks!

-- 
Jerome
