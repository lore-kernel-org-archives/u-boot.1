Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBCCDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 10:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A672184866;
	Mon, 22 Jun 2026 12:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nqvTQzrY";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D2Juj8HL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411D2848DC; Mon, 22 Jun 2026 12:04:56 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D6584832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 12:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65M6nXqK2132029;
 Mon, 22 Jun 2026 05:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ifqgj3W8me2bJG2H0GMAtbiwD0OvHiVkD3GPBiE91
 Qk=; b=nqvTQzrYYzTIps8tDceWd9lhA965SaHS7/MKxjNHWOB+jjTlBEACjXNoP
 QJtbWNlW2gxa3q5m2Zo5S7z5b4oomN6PZnHg5b/TNEmHDfoACnJgXZWqYc9+gUHx
 P1pWXhOOvigKqlT31bN2Oum5RvNP4veSGGuOZR66lyvwY4RWBdldGN5foqUdA3kC
 PiXd/p+SttQ2CckRIBsfatrbuS3+g1l11SLj3XlYJMzYmof7PNrVNd2zJYvLB9jP
 fCS32J0gnRUaloMo9LBu/F06e+rr7O6Ylqf4X8xyNzlRVCp1SasfTkdLgpbHvf9q
 4ej89rb8qLHPZHvCSdNx83OwIaLbg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ey04e8xak-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 05:04:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ1qdLtZ/hKlKbcLZ7QgtgDGq1iahojYN9Qf2n8q4KQpr91Xvitbs7gT0kBrdDAtCdStMu6Z2NdNFJ3aXWZKpQiGeaJ/c7B3YqxgBxM8gGeO/lBvJ38kaTOHuHusYEr5lvUvgOuz2K1pMtdDdRCbtubWAK6NBUTUb66wAwUQiJirrqmENjGQRPFbkxSvSphEYkcZt0RAYWSQ9FTPbPAWMDXnQduFqeZkcFWiNC3E8gDwFNhB2usMIfUR6uSvumHQ3SteamkauECpokqtI4k5UE8AGKjnvBrePYcuaJD8R8pJHyCUfoRk8fPsZ04ol+oAR4KXV+3T66BpRsyYtJLLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifqgj3W8me2bJG2H0GMAtbiwD0OvHiVkD3GPBiE91Qk=;
 b=hJsOS1p7LlhUidT54o+mc6ThC+Qi01YtYB46gFxc09fig/iLLbU/1bZ7eNlUVrOg4TjJYM0G4Q5kEtCLmqbaffHOxiLsEZqAzk0DgMcB7/BZ9CxkExQ0JNuPwJmbi+sW+UXBwkAIw3qnj81D6OJ1EnDhfYv3wL4w/NDYzH9bHEsPsoDZ+mrDCdBkJCT9BzdNqw8KHRrmr0tPhBDOcxhap6ZAayfe3DnWGa5g1zQyh4s7rTsI+y5JjJB4EjYSQ57jh7eKu/in53r9T5CEoBWJ/Uuu1J8QR7n3qWWeED8xQbFyXag2pg3vJGmYMSceLRO0A7a/w9hrgZ57tqaaDP/DqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifqgj3W8me2bJG2H0GMAtbiwD0OvHiVkD3GPBiE91Qk=;
 b=D2Juj8HL0ZNjj79uYxqCi7qSd2y/8OaxC82tnwWTrKS2WfBK7xPaZ3phnKZjltI2RzcEOZNfuDjRbssJCkw3FmSoGFkfhJGVezR2L0A/txUXm+Z4+Qa7E6sL95mAByl2tjGevPX8nThFutN+CLJ6SgOrW8Sc53q74vy0ZaWnykU=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by DM4PR10MB5944.namprd10.prod.outlook.com (2603:10b6:8:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:04:46 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::3) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 10:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 10:04:45 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 05:04:45 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 05:04:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 05:04:44 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65MA4hIB3863418;
 Mon, 22 Jun 2026 05:04:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <vigneshr@ti.com>, <nm@ti.com>, 
 <anshuld@ti.com>, Jordi Trepat Mur <yordy1902@gmail.com>
In-Reply-To: <20260614103232.3586246-1-yordy1902@gmail.com>
References: <20260614103232.3586246-1-yordy1902@gmail.com>
Date: Mon, 22 Jun 2026 15:34:41 +0530
Message-ID: <178212268104.3933933.6321183759645640242.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782122683; l=3081;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=t+tE491bzDDC33Z7ebSKSR0MB5zZ1xp77RCUAu5D2wM=;
 b=qzBK2fIIqkHjtnG2CeEjn1yRePnZS5tQ/4HO1xwmqKIp0/5wQMNex9DOQZb3CyVleXgwqbSaY
 8qJjaAikx0cA3O7K4P0/VJ2W4PefChrnjs5v9e6qKRpDtH3X2+e2N4z
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM4PR10MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: cf81bea0-fe17-4fc7-67a7-08ded045afef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BN6MKSzDhqB4gvz1jIsw1l5AAc0iW3DHD1Z7qMDOsauXJ6CFzgyF2HVAkSQnvpC+v18cf0BAXEEox2yLxtojftpQE4z7ybKN1Rzw3/lwyRXCmshsXyZTzR+pmOsM2GpQfL79BbRwXDaitGETHusEtNR4U7PxeyTTaeDFQ6QsNloXmxPEm/QprPlD70c/zsvIXqe5HF2JBnevVi+HxTHOU8HHjH/7IH5NsaIcrCGQv1w0TAxnR4jsymrz5KwCM7jNs6Rg/GgDsETw5Qk2FHsH6/c0sCKUGQn47KyqwZM2PXh6zw33mL2Wo4zMQLmM6x5M19xtQsrgx6zgy+6hHMVKYfmchNdTxIIIBpVF+PRpRA8HwTvPs3xl/Aj/tosjNvg3jUlNE9G0ALs26AtquZsjuyNq9au/Tsm0l2auTmeWd61L4UZf92cAZYL9Dm8trHbyq1iodkLJQkcy5wFKBfP1E58L5zrqg+8lwwfLCdBkfEZpOcucyjrlfykoBU72T7D1LxPfnG4g9SGj6/ZPU+iWWvTQiOidBC63y5BnCpSxZrCck6h0ZBVoipEPpGHErfvyF4GEZADYS+xwE5YrP+MG0To3KDyzI/4u3fMUmxA4hjqqAHh66iqBEV5hwJbjqe2AsTkA+kcInu19oQyhGdyUhfDHGByLjCx5f4z7U5H5WV/qm8MAZIwU0ToRmux/fH+QkqI69pwcZDQXu/lNZutnMg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gncKzcYjDFRtQjexB/zw03xWooeMU/WoF3qMgvxK5CDXrds1QKYCgSxX20klQ8jAJYLE4crrpGOYR82FjDl7qWjTX6W0VVLiqjCiXe26hrMKSFgE4Gda5yjO2WMXCaYpgE3ZynKLQ55kB9xw8HVM1iB/b7qoviBn4BhODdRbGjIf+ArK+lV0LgrpculYnQKFoGVjbiVbf6bKxTJdt9aiABFvQ4sS5llFqefVTa/vn1pFgLGbpmKx66JO8CxJeniwu38yPz2wcSBoHo47DIFI3xBWavyA7WKbYP18/sndT9geQ9rJF6wJ1q0mn/5xKn6AFRsTO3/VcoxXGWN9VdsVzmsB8n7uJoZI/9JHxsWE/DUBqzpDUFX/xmuVsGD/oXHL8CuaERZXvmezGWnAlF6cMg9q2GFoHHnxuKimHERwRuh0GkQ1MkexJiJBeKFhIAAR
X-Exchange-RoutingPolicyChecked: CrdITn8Kxn7+Uld8kAa7u9XW1h5CS9ASzmPURo8tvhD7nLPK0wEKOIR0SLISzMvcpA/IpPaOEkG6iauLNTub0/w8eGOsTJI+lVjYCUmcJURYWJ+XzTkoVH3ZWz551jR9h5SoY8mLYRISoG0O6bCDNWI+qXpK/QjpF9ZwA6Arr3JV6jdrkzWxZ20t8oFyt28DS2TeWuLW5YK4NrFfIMdY9GQ9tCF84f0ur7mzs+TMe6aYahWfOL8OOZ9PWP+5xjQYCJ/OfQERQ9KIJnlKVm4XaZthSCKlVotFQgfAUdGkhNKtOTCgfzOkYS4zJR1Jk6Hy4UkGuIJJPsMkloe9OUuR/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:04:45.5161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf81bea0-fe17-4fc7-67a7-08ded045afef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5944
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5OSBTYWx0ZWRfX2aVbhCIOpqbU
 eGkQGkD1GUFmDGznmDAiZI+QdswPg8sYRmBb4D/yeWRimjUpoiLRgTUxHN9n7A0/u+TPWgPIlda
 ec3VjqNwBqbvrQVidr5olqkbUVsZxvw=
X-Authority-Analysis: v=2.4 cv=X/Fi7mTe c=1 sm=1 tr=0 ts=6a3908c0 cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=pGLkceISAAAA:8
 a=sozttTNsAAAA:8 a=Yx4SyzFDe5jPTd1-q0gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5OSBTYWx0ZWRfX3UXOgsick0A4
 E8H2zjmhaqWz3iCa0PmWrktR/ub1GOTqETquGOGL616dK6WhlIldxpcH63j9N0AYAOfWtO51udh
 iovJQMhIOOnsyzgQJik3Nhri6bXP7cLZTWM/ZV/Uk/dcK7gi+DHz0SSLjAMnWa4UlQETG1r5nHI
 hhgskjPtnExLiYf9v/iqk2y2cXrSv1nhPPFOpLPN2zAD7if0B6MD4fuPYPPn3cjpOoNiwVpcwBV
 bp3CqZew02weRxKqpB8rR9gq+sp5Wvp2YMt4JHkhVc0SXgYiQYY8gjlyXEIHWiOuAadsYKUpL1P
 nStXnki1CPoki2sK8zFRbKMJWkAXJMqeZ0qBjdTV9xk0CUI3P6v/qxxq7p+YfPKwYUciRWaVmzY
 bXtNYyqKe4V7XTjZYrbQOvC1yPtFlvvzeSMprAX64LIkqkZoWpjKLk0W432BCr8XIPi0T90bkMS
 GI5jy1vqtDUBBlv2a0Q==
X-Proofpoint-ORIG-GUID: -Bqm58VwmNiIkISKF6CnKxvn-NlGYh-3
X-Proofpoint-GUID: -Bqm58VwmNiIkISKF6CnKxvn-NlGYh-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220099
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

On Sun, 14 Jun 2026 12:32:32 +0200, Jordi Trepat Mur <yordy1902@gmail.com> wrote:
> single_add_gpio_func() calls ofnode_parse_phandle_with_args() once per
> gpio-range entry. With a flat device tree, every call re-iterates the
> property from index 0 and, because cellname is set, performs an
> fdt_node_offset_by_phandle() (a full-FDT scan) at every step. The total
> cost is therefore quadratic in the number of entries and proportional
> to the size of the device tree.
> 
> On a TI J722S board this makes the pinctrl probe take 723 ms

I'm unable to reproduce the delays you have observed with the J722s EVM. Are you
using a custom DT perhaps?

>
>
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 42980e097e0..442979519d4 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -511,27 +511,61 @@ static int single_add_gpio_func(struct udevice *dev)
>  	const char *cellname = "#pinctrl-single,gpio-range-cells";
>  	struct single_gpiofunc_range *range;
>  	struct ofnode_phandle_args gpiospec;
> -	int ret, i;
> -
> -	for (i = 0; ; i++) {
> -		ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), propname,
> -						     cellname, 0, i, &gpiospec);
> -		/* Do not treat it as error. Only treat it as end condition. */
> -		if (ret) {
> -			ret = 0;
> -			break;
> +	const __be32 *list;
> +	int size, total_cells, cells_per_entry, entries, ret, i;
> +	int ret_total = 0;

Why rename 'ret' to 'ret_total' here? From what I can see, it's still being used
for the same purpose.

> +
> +	/*
> +	 * Read the property once and iterate over the raw cell array in
> +	 * memory. Calling ofnode_parse_phandle_with_args() once per index
> +	 * re-walks the property from the start on every call and resolves
> +	 * the phandle (a full-FDT scan) at each step, which is O(N^2) in
> +	 * the number of entries and very slow pre-relocation with caches
> +	 * off. Resolve only the first entry's phandle to validate the
> +	 * cell layout; the target node itself is never used here.
> +	 */
> +	list = ofnode_get_property(dev_ofnode(dev), propname, &size);
> +	if (!list || size <= 0)

The size check is redundant here, the size is only negative with error code if
list is NULL.

> [ ... skip 20 lines ... ]
> +
> +	for (i = 0; i < entries; i++) {
> +		const __be32 *entry = list + i * cells_per_entry;
> +		u32 phandle_i = be32_to_cpup(entry + 0);
> +
> +		if (phandle_i == 0) {

You could just do `if (!phandle_i)` here. Also, is the validation for a null
phandle required here? Wouldn't a properly configured DT never hit this case?

> +			/* empty entry - match original: skip without creating range */
> +			continue;
>  		}
>  		range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);

I wonder if we can just allocate a pool of ranges[entries] outside the loop
since we already know how many entries we would need. This would avoid the
repeated calls to malloc and the subsequent null check.

-- 
Anshul Dalal <anshuld@ti.com>
