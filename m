Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD568C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82B782E35;
	Mon, 26 May 2025 20:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CWG/Hg5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BE182E37; Mon, 26 May 2025 20:03:43 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8687882D43
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi+Z8VBOv2N13hJG7vfz/bPszn/kBK0YGryTtYxsh0oYMG+ZdeXMNzFV43bqbzYzWjutj5ey0ENxsq7V0uA3V1Oc31/e9IyQxuHcTU9acvFFnAOqADSlr5b4KCRcxkuHqXPXCSjrTew+Bnb/XGk8oHc0JhmL8ZLftKM5RMHIBYjJ1NpXnslSb/J8v7z1mBcYItY19zhY/Y1RRMudhxAGdrfVHjgcBvJF+WoLMUcIVvu8awdC+3pNWvaFyEY3gC04WoFIhMrJNoev3TZ3yWiJJPaxEb+AYAt4/bQcXy2kOUO2uLKDZml5Hcr/zW0KHnYOhEeF9M8Gz5KLqna1L0dWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXJMMDjUYo4GTkTZBWEy/q9UQcOSLn/HCDOA6qM0lSs=;
 b=I6nFjjuMkfgrj91naVyVknRF7o4igBX1UmLKJLalzEvj2gE+UT+o2xjJvCF5BjSZHimeE6Jj7tS1BpoDUqSMlGuggr97i4B7A8LYqKCuVa0KQcxIDl5Rg0xSerrdcgQPeaq4WvK90iIEYZL+37s+RJ6+MlzOyzuUqn/82pQL3Ac8b8rWmpkhURiHQZxw+JKWZFI0kQcm6PoiXbmewxhu2YP0O72v8Jh0Q4Yca4U3PtSl1L+9scYkJDcnCI4gsDGWTySBNOeI2jZfCEQEUyzfl8I5T/0Mt4jNCkfP0icuGOqzs1CQwBsgqDUVO7sgZYc+DfzdAFW/JjAYPIoWZFiuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXJMMDjUYo4GTkTZBWEy/q9UQcOSLn/HCDOA6qM0lSs=;
 b=CWG/Hg5oo6/EV32NDpCwePlbgHwhksnH4hwhkI4Zwqzx4HecmS63utBFpTJUoySWhC2CeauETIE0BsmOUGNWdvEoDumrxPZ0I+1V5GhTa6knOnQyK+zPBCA/DkOdvgQtd+iAHSE4c3N7lca/pp6Kx6gvGiMQRl2fRrbF82W4gZHMuMxJYp7ZJBAM47Y5dpyuCK0iaqcGyogn7O+rhHjORlCQLx+kIANfmhEaaVPet9s6qoNMEII6g8Af3ct09bD6OHLH6puPQerhHWjrvFyGjyXsqNKjBz1HuJadFued0bE68aU4qRjZcVOSJTtZ0y8wNQm+YpYhlHEjfOjcn7LYmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:38 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:37 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 0/6] Enhance DDR support for Arria10 SoCFPGA
Date: Mon, 26 May 2025 11:03:22 -0700
Message-Id: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 355b4e63-dde7-4fc5-bf5c-08dd9c7fa31b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?poVHXMJKJtlVPAEiNQ69Yi5vf/OD5cO9Y+lpJYydqB5wr15zgWjGbmqW4rbD?=
 =?us-ascii?Q?FtsAY45UysrTmYKuzC2xQDjDe1wxLYYWldd/b4mxn8dDKC5g6/uv49wesOC8?=
 =?us-ascii?Q?30QjgNZKpD8YGiPsgqVcp2XyfOKIgTHm9PGubx2Xwpl2wYF635TDzmpWFg6k?=
 =?us-ascii?Q?8U78gXDELkYG+ux04RpkpB3OiHEmqSVkF7forCi7HaIOPiI9ff1gZhVTXleS?=
 =?us-ascii?Q?kuIdULSUsoNMdoF3Iohanq4u+F55noO16kdv5++sk1/AO7kE4V8FqCK+0S4s?=
 =?us-ascii?Q?IPYFhdTKLr3KaPURX5fO77j/tJYBMqFdqIeuwPSCa4svXPCf8NZ7kkzX0YC7?=
 =?us-ascii?Q?W8HAaODKyA5VUxm2CPtXgOA3O/mIQ+Oh3ryvNSrgjbSvf91ydrnIE1AuwLil?=
 =?us-ascii?Q?pHUrbwNGp5MJF560ZrJ0xSatbivk4oGpCUtLrrS9yE8Z0ho9bBaQAFkrfCCc?=
 =?us-ascii?Q?SY3O/KbTPxk1NHX+TsvQlZQseogyiG3URGw0FyzFfRRhmvLAKPwmoUtgSAwy?=
 =?us-ascii?Q?5ySMpPREKSAf6lQsmnDKYplt2Yb+TfkfI6uZy/mTJqrB8fsOzP1iqBWH+qj3?=
 =?us-ascii?Q?njWHrTRBtPafcYtWFrC92cJ/YCQqsr6pdk01XZkdDeRQelwvMHk6m5XEyvmx?=
 =?us-ascii?Q?p8/2p7aMX1JunZenhArVmkfgt4sNbU+xW6Yu58NpgZV0OMEqDgfALIJxdBVC?=
 =?us-ascii?Q?RUBbJykzUY4RB2ln24p3RXj8uUE9rP2Y06EOBxkICrZtfhOwKcFqz9Sriz5m?=
 =?us-ascii?Q?JXd7/zAcmE6OuABSnUe2dLPrUqnFQ+DSRAULwzMfbcVJjyhe14gduBy+6y/z?=
 =?us-ascii?Q?0u7Uvel8Fuakn/sl8SDrvarCoFvjiijKTXwndVQOHuRpR+yq2WZ+IghAky1c?=
 =?us-ascii?Q?bDKKNNzWG1/HM6m3Xm3nzmo/7r+V8tqs1K+ndshkCMftc9Bv9Bce2OaQVLz0?=
 =?us-ascii?Q?BmRZYOzb37Br7N1kmagxzAzzVIZR1dXIQ1v2BIZKPy93k5VyJ+UErsYfj2bt?=
 =?us-ascii?Q?TpYqHKHwHa1G91NbER/+tFvtXVC+d3Nbk8h5ITvQTQQ6lHb0FKjj1eRUP2xS?=
 =?us-ascii?Q?vl34/HZnXgEx41TdX3CmOrDYdzCes6eV2fBga3wfs0RzxLc/g4qcpQDbGg5j?=
 =?us-ascii?Q?K6oAS5aDBbt6CJODeK7OC5PY2CO4E75cNZry9IWp5Ddyswff298MG8nz187m?=
 =?us-ascii?Q?hymMkptGp1xx62c6JpM0vkSnv23y8YMXIpULRWPOYJ7Fx0v7hcqVDTC59KYv?=
 =?us-ascii?Q?xyQWMnEg9fBbtjD6bmcexi5l4zV7nx5UUEXaB6T854Njg3T8E2o10X15J7aF?=
 =?us-ascii?Q?aQ52+nwWm/xYmKd5gxCZ1GVh6UznmicP4AkqktlsGI0ClUxdBwtGvTOyWbnw?=
 =?us-ascii?Q?t/r8UYkNP8PPhD5Umog2uYlo6hXOAXFyEAo9GHIg31nGRnsqaPfChgLxrpxj?=
 =?us-ascii?Q?oiMoIGIj0wE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwTEyATzZi6IjjHq2M1QEFqgMjH8YiAYbUKEIrV6nm7WCdWBZRcyfV4Xy8d0?=
 =?us-ascii?Q?vsu7H2TH335hoDGfVAv6Lvsfm8ZSt+wEyiZfuP3s8bsQ6ouyGJY21PIPZSJe?=
 =?us-ascii?Q?V1N9HuDvXU7O9vUMLqfIIgPxSF2/AzZeeU5f1wiH3jzOfhb1FJEjbOCM+PAy?=
 =?us-ascii?Q?yZFQKhfUGvJhn+9mwJQdORuYLDw4TtXHCXzzypS1GsT9xENcJayyIe9i7X36?=
 =?us-ascii?Q?VuLtpphjObahFsjPU2qUacnGGbyS+08RL9N+sWyeu531AO5wCqzY3s9BoOTm?=
 =?us-ascii?Q?jndrBja2L2eAdTwi63OD4yryNflHcYYd9NQOOF/+jVX2NXTtAgYUYfa8U3lX?=
 =?us-ascii?Q?jfMw1Il0ciMnRvXeRg7QIIAJ42DrPRjuKkaIdwNK+j7tXiuFxarrSe94StXe?=
 =?us-ascii?Q?y+JsN3caCub8UGkfxJ/uMoK7kAvXkubifKxux7rRJt2gcaA+3todJQ5m/4B1?=
 =?us-ascii?Q?e1Odg5f1CH6UO4JPQnD9BpCYtnQeKh3LgUJGOCI5HkW3arLYHEDS4o3qtMKv?=
 =?us-ascii?Q?QXEp+rWPG4MV6ooo2o+T7tj2pZKbktiA5OR6Ap7iWsik0QXDOl6AzTrVeKrW?=
 =?us-ascii?Q?AzgY/SK4i8/TgpJgsCmomqZsQcm7kgjt4PfRteiz8AcZAt50kVoByjjrEvBp?=
 =?us-ascii?Q?uBYlXE3bUAu5NVNJMrokvXfdxiAlg3NiloV12qbFMuadTdEkAh2YQtPnhxsu?=
 =?us-ascii?Q?VNfeUar3yBhThRSa9WvoYeLkFPjOmYjqyS9IBjGJUfji5quoPWIUVqqW5XAM?=
 =?us-ascii?Q?MhRyUt08dYsJK6e4hG4+MArJN7SSKdKuYjlTJeldlEm6MQmPB5WnlYg+47VV?=
 =?us-ascii?Q?CoZby+z39NUtEkhQjB7nektdjPBN+670ayeBC2/HwWyq+KiaQrxXEziEKj2S?=
 =?us-ascii?Q?VdCBSX63R+oroJKoaT1asoPS48RPmZG8Rv4Nw71GST0f+yZy2QaU099oa4Rr?=
 =?us-ascii?Q?LQUcdpo5kG9YG0VsKRyz+FurRqmJ6fPK4nKTzMhafOJHlTaJWVylfTPvPNjU?=
 =?us-ascii?Q?K3uzKDzcfhftisB6Aj5EzTxaAwPnDwbL4+S+dQaQ0lcddd3TeiYzdZ/ewvC7?=
 =?us-ascii?Q?kE08kU4PhK/hHVlK0IH6yOpvKnVSC2UQPgBEtHexP5EqZ0zbIKwDklTaqMX8?=
 =?us-ascii?Q?Nz+k2ERmEd1NY1lmMfiorTBAvRShi99nkFJuUlARw9F27m+gmpvVVMn6bOu4?=
 =?us-ascii?Q?CXbilpArCp6qpQ3Iq6oJdHnombIgHVwYqnISa0zm/GfufTkSL3XYVcKXj5r3?=
 =?us-ascii?Q?frM+sppXSaQaKyLh5FtjaogTrcK+WwPHhdzHjJx8IBq2JhclUx6wAtCxYDLH?=
 =?us-ascii?Q?ImRjPaDRE+4eHdL2SxeNnE7fmLKAvWWQex56+B+Oe4Sv3qpbEiS/FiON1o7i?=
 =?us-ascii?Q?qItzpIrHpDpgcCFr5hom/z5ODyCI0R33cLW67ad/tgxs7b1y1YBGS4pXLagb?=
 =?us-ascii?Q?1B2g3zj9UsyhmjRVheX2QsKBiiG75o9qwwjb8fCAI17yAFI7FXLWPv54BW+r?=
 =?us-ascii?Q?sf+FWGrORecvHsYlHsnR8WYv97a3I7qFKfjg7xpVenbQiBnpEHsXU2+BeYDv?=
 =?us-ascii?Q?cjVxzBTWK7nyziGj50nNOOaYIi4QI/ThjAtCR+gYn5bQc04ZwEhU4S7Bj3uw?=
 =?us-ascii?Q?d0iFvwqc34I1J/+msWNlWnM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b4e63-dde7-4fc5-bf5c-08dd9c7fa31b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:37.7488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Izme1+KZOFqsx38TZchUTPKp8gYuXHaGHcE0Mf/UVhZ4MHRUn7o1skE5diQFzWHXhSXVnoEZzJPQ0NhaUhQEaIK2AMauQaAK230GMyPwsLy5V2Uy0lFBSkEguZp8Y15g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6379
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

DDR driver of Arria10 SoCFPGA is enhanced in below ways:
a) Check DRAM size from device tree and actual hardware,
   mismatch is notified to the user
b) In case DRAM size from device tree is greater than actual
   hardware, DRAM size is initialized to the hardware value
c) Fix a bug during computation of mpu1 address
d) Move common code specifically, initializing SDRAM ECC bits to a
   common sdram_soc32 file. This allows using the same code for
   future devices.
e) DRAM initialization is sped up by enabling Dcache

Changes in v2:
- Avoid hang if DRAM size from device tree is greater than
  actual hardware
- Correct ECC Scrubbing commit message to appropriate one
- Address minor comments in v1

Naresh Kumar Ravulapalli (6):
  drivers: ddr: altera: Add DRAM size checking for arria10
  drivers: ddr: altera: Add valid RAM size check for arria10
  drivers: ddr: altera: Fix incorrect address for arria10 mpu1
  drivers: ddr: altera: Clean common code for SoC32 devices
  drivers: ddr: altera: Correct code alignment in sdram file
  drivers: ddr: altera: Improve DRAM init with Dcache

 drivers/ddr/altera/Makefile        |   2 +-
 drivers/ddr/altera/sdram_arria10.c | 112 ++++++++++++++++-------------
 drivers/ddr/altera/sdram_soc32.c   |  88 +++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   |  11 +++
 4 files changed, 163 insertions(+), 50 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.35.3

