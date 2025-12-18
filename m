Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2854D6E2BF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD7782BF2;
	Thu, 18 Dec 2025 18:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QZShrunF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB59080050; Thu, 18 Dec 2025 18:27:26 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7F183642
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcdECNewHLlYvfOAUZws7r+SqAkMAvlNSeg2o5zdxWtDleI+zRvY58yCCfQNx5EKduN5BmkM0rV3tFEs+CCgPJWWG5OouWi+ymT0xyf1uThTGBUJ93d6LPPRJOwFzCF/oVFGBcUR8AjbPIH/eO6+kWr9iZ6YRywON7dkSJgVsWQ28MN87UmqrAhAVn7m5A2G+eT/b5gdEEft4Gc4cWC5lIIeOmGim4aJQ3uiwUQQiFwDP6Z4kbIl5VNQn7+wTIDlMGJlPBaSW5tOZAOe4ipU5ujMuxiOSJemg9lnbBhuA5YLGeZonEbm7hZAYdGQoz5S8ByM/QhuNxNtbq0szeM7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh8XbIijYfvZDgUPvfLMcticTMa5CMrjAnuu9Z1x3zI=;
 b=j/W25IdQPbb6ZOiR9dKAG3yjxzAwWbtOL5k4sbcwFaOZnk0+6eV1YR7CvlsKxo9it4FoEkkAh3wg/8IXjPCgqyCJeyFgs4QMUf6trbg2CYFZtCaWzLVSJ7AXcbgUZ5JMzN/lDB7RSuzf83w++0lwdkMTUTSYWH6Szs+DMVW7tWEWs09NDPoY+HfdNzkC444SCMc2bYFtzT1K1xu25a+yYDeZIsWgvm1gBH6fkY3n2cxZoAEOZI5Mqa6U9FS4c6+tVRw19d1u/qZU3Z2p+nPl76kk4bsR42VuY0K+V8CCV8B0AjGCh8IoGGUmfy4yXKmiOpJLlECG8TZh+CfvU7S2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh8XbIijYfvZDgUPvfLMcticTMa5CMrjAnuu9Z1x3zI=;
 b=QZShrunFfcyDTU1uoO+FIpWGAepqKIdBVx4VRLOKweNoBhRwDcGJzSn9v3qEhRVdr7VhCZ8hvJkHKihSfmgCauqiIUcRRHnKMmCROEF4bVPlCwEgvv2+G7RtF2Ks853zYQ4Wlkj5GG5KNPS7sVZHz65bNIKM/7X2GzG0UMRtRhw+wvcJ+tGUwUc9hfeH5bFoNUE0ak/+URX9/0TdkemvRBFGfLr6tRvDaFxcYduYc6zDGyAkSajsaspr0IYSPxW0sUAbppQ9F/MYId0uzfywPZonpgxTMMFlJEBp2sfuRCR4oTUqALSanzndS7DwR2gVRMSZKw9B88ObRoYZYeAc9w==
Received: from AS4PR09CA0030.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::20)
 by VI0PR10MB8556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 17:27:20 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::b5) by AS4PR09CA0030.outlook.office365.com
 (2603:10a6:20b:5d4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 17:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:27:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:51 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v5 0/3] clk: scmi: various fixes
Date: Thu, 18 Dec 2025 18:27:00 +0100
Message-ID: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQ5RGkC/2XOQQ6CMBAF0KuYri2ZDq0FV97DuGiho10owhiiI
 dzdYjAhsPyTeT9/EBy6GFgcd4PoQh85No8UzH4nqpt7XIOMdcoCAY1CKCS3LUtbFLr2VGtyVqT
 XZxcovn8150vKt8ivpvv8Wns1XVcFvZIgsQQCU+qQgz9Rw5zxK6uau5gqelwwZWaGiZVOGYcIF
 r3dsnzJ7MzyxCjXYMijqxVtmV6y/0g9MSqNJ4QDutXIcRy/x2MVuT8BAAA=
X-Change-ID: 20251208-sqqs-7884dbfd4fa7
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|VI0PR10MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: f58342ae-78e2-4951-d250-08de3e5ab2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qys2Q1lrY0FTblkzUnFjT0xlSlBIWSthcFIwZUp1N3hNSVJXMEtYMnp5bDlu?=
 =?utf-8?B?dEhmeFRGQWRlZVBLRDZkQitmRUF4Q1BVR0lDNTBINkg1Qnp2aUs1S3FleUZU?=
 =?utf-8?B?THRadVc5NzBwajRJYUNUS3lOUTRlM25RM2E5MFpxME9BbUMzV3F3Vm4zVkdw?=
 =?utf-8?B?OVZ3Q0tiNW9aVHBQQXBDRUNaSldHa05FR2M3Mm9qcFNqbEQ3M3JhY25BZnpa?=
 =?utf-8?B?Slk1N01GUjZSZkpqaDJiOUJ3ZmxMVHowRUlsbU9qN1J6Um5jWGl1cW5IQWwx?=
 =?utf-8?B?Yy9DR2Nwam1wTnd0Wk1vS3dDV3dTbnhSRXVONTVrRUdoUWkyMTM0Qm05cFRy?=
 =?utf-8?B?TDhxQjVFM1A1WTBMd2VpRG9MVlE4dGZhS2JWdCtzd2FNQ08wUVl4OTBwSEk5?=
 =?utf-8?B?elNodXRmMllLbE1LK0lUaHV2TjBpOFZvd0UvMlN0QmxrejF2T2x4K1YzTWxm?=
 =?utf-8?B?MmR1QW94UGpXUitER1AvSnBlMW1GOHIzUGdUSGRLZ0h2bm9qc2lsN09uOG91?=
 =?utf-8?B?ZkdFQmU3NVM2Q25FRldjMXoxK2s1ZTFnY0wzSFdjSjQ3Y0FEcFY5S24valFq?=
 =?utf-8?B?aUlyTWVMejBsUmp0M3k3MWJGNVp4bVRkUFdvZmJONDFra0VkUzNrNitpQ1By?=
 =?utf-8?B?TDdxRjA3aFBHZUlQK2NtMUppVTJUcGcxMmJaSkJ0UWFrOWxiUWdCSDV3aTJl?=
 =?utf-8?B?NFZBcDRGbVZwaHZ0YWRWaGlsbGZnakRTMVZMYkNyWXMwUlloV3ZFZjZJeERL?=
 =?utf-8?B?eXNXZ2loN29wZitmOGRJSEwyUmIxZUdVbWFPSXZpTUxMbDlFOGlTdW5UVUNj?=
 =?utf-8?B?RlFGMGxDVXpBaE45MHUwVHBlNW5FMXA4MzR4QnJNUHE2YkZVVjVjZlZZMHp1?=
 =?utf-8?B?RlRnekZVLzFjVkZiKzRZNWtqenJva3V5NmpieWJSaDhSSDBXeUNST2FML01J?=
 =?utf-8?B?aVRYSXo3R1NrWnVQa0Zsekc4UlE5WDZKYkYzSEhTa1pYcU9jVVV2VEJ1K0RF?=
 =?utf-8?B?UE1SKzdKTEJWRzRMMUovWC8rbVJ6aks5WDJNTnlGbi9oL3hyRDllMldVcmtL?=
 =?utf-8?B?TnRQVE9TWDEzU2VGeFE1Tjk2YW0xU3ltYXFLL1Q1Y3FVMjlvQkZUUzJ2TzNv?=
 =?utf-8?B?RWNhblF0RXFuMGV2K3lrTVZWUjJEcHhacGZZRjdqdkd2ZFRnc2lzZ3Y5a1BW?=
 =?utf-8?B?MFdKMmo0QWVQdUs4bU1JRWVscDhsUU9oZ201SUFGbmkrOWRtTE5XVUp4TWda?=
 =?utf-8?B?MndWY1Juamw2S2d2NUVra0lSdUZBZkRjUHBoSlZBNHhPMmVvcXZ6VWpjK0d0?=
 =?utf-8?B?TFhwckNlSi9EVzNjTGpnTEp1YndSWGFEaEZUNkN2aUFodjBsNVNtcFdRNGhh?=
 =?utf-8?B?eWUzZENuekErK3hnSkJ5OURVK0dyQWhxNkFscmx2V3RzTi90VDg5MXpkd2JB?=
 =?utf-8?B?QUJ0WHB0Uko1R2d0TnRoT0NmV0hkUHFzYlRlQWM4T2M4UmdMbzBHaldZckI3?=
 =?utf-8?B?R3FzdjNoN1lrUnB4OFQ1aUxWL2xtUzZ2cXhNaUtVOUVrc3ZQeU9yd3ArYW5j?=
 =?utf-8?B?YXFEVlpvQ3ZSREM5dEk0R2J5N28ySDlCQmxJZFVQMlh6MVcrczJ6WE0rdGJT?=
 =?utf-8?B?Tlk2QWZReUdKOWJVYkpUeGp5eTZvQ24yQzgxSzVoY0ZLc041M1h6Q045UXYx?=
 =?utf-8?B?eWluWkIvNkY5TTVmT1V2MUxTMjZqc09qNUZiTm5McEtjSjFySWQ2VGt3a24z?=
 =?utf-8?B?SnZ4MkJLMHQ4aWpqV0t0SnpGQVVldTRoUE5LakEvakZTYUovUWQ2VUp1Mm5P?=
 =?utf-8?B?UDNvaUhXMG5pbGlUQ3p1Mk1QK29PRXdhU1E0WEwyTnJ3YVorUU13UGRwbUgv?=
 =?utf-8?B?RmYzVFZ5Vm1mRER2ZU91NGZzV042aC9IRDlOcHZVKzdnenVyYXRibE9wd2Jw?=
 =?utf-8?B?SVd4a1Q3RWhHZFBsb0R3bWczUUFzUkFLNXZTaVBtelJ2UlNzaGFPOEtsenl4?=
 =?utf-8?B?bW9jZ0NmRkNUZEpRNnhvOHFQcnJoSk1nZmJXMmFaa2hWakp4M2dNUlZpR0Jr?=
 =?utf-8?B?THRDOGZFTis2V1cza1YvQ2dtMThYSnA4MEpQTXV6YjdmdnlUaFlqYStZMDJZ?=
 =?utf-8?Q?Zw7SIrfq5nGcOrRP1l2H56rv7?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fUn/Zbys3b5bU3i/Dg+1Wo0eySrwiyAfXRwqSxoA/mihN4aWWlW8KSFAqe6uXwbZS9EFxCMRPsGvv+e5Wz0yyjc2uuyeuiG8WLhmGo6JVzUOjERlcPxi/n7pC29n1qsQacQoRdiZXuP+/+tOGL0abQzCSt8WK839wvjhsDzZX6akWkJti3ohcemE6uoMUbO+zkeQDEUdZNgRAlIVrTKtGbaUMUk8bLASx9cdfWPBB38t6zCj3/74gBW02xDiSH+MYPPdTvyOWvdi5FbyMOvy5UZXjh1P2sr1BsCGVA1NUKW9UpuXz5w9qDg28oEY7RRrqzpi8S7Op9AfW2FYtxJBnnYjCUpKQIhD9nfLVtplSnUZ8tgBQLNd/dVcgYmGoB7ps6xD+vLT279e3UXPbkv1EJ6u1b1Ymd0H6lCiQOajkEI9As55RJO7PpgOKxZXW9vYUQ7p1HItCV5xmrG/WaH1lIpzIuDFdt8jdiYPSfdZN0Bn2zwyyqZQwP4+UPmvtwPBeUFRSlIP4c1dfaJp7kHgoroqtSmGpWSLXMLJredc4T8q3ss8mxyD61w+z0beI0pXMIzwZq9WScsqz20EUAranFdOsB0U7YzOaLKN1v6lS2gxwsSiXu4D70PDDOZz1CruQgEE+phhRiR1+Hb9I3+OzqfFVwATdLDbzp36vhyubxORj6tdVpvQ0zLMfMF2i5NqvOpRUno31NonFK1vI15+kQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:27:20.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58342ae-78e2-4951-d250-08de3e5ab2e6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8556
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

- Fix typo scmi_clk_get_attibute.
- Fix priv initialization in scmi_clk_gate() which leads to
  clock_enable() error when CONFIG_CLK_CCF is not set.
- Remove duplicated scmi_generic_protocol_version() call in 
  scmi_clk_probe().
 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v5:
- Remove blank line in patch 2 commit message.
- Link to v4: https://lore.kernel.org/r/20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com

Changes in v4:
- Update commit message of patch 1.
- Expand comment of patch 2.
- Fix CC, AB/RB/TB tags.
- Link to v3: https://lore.kernel.org/r/20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com

Changes in v3:
- invert CLK_CCF conditional in scmi_clk_gate().
- Link to v2: https://lore.kernel.org/r/20251215-sqqs-v2-0-9a15a22072b7@foss.st.com

Changes in v2:
- Add Peng Fan's Reviewed-by.
- Add comment in scmi_clk_gate()
- Link to v1: https://lore.kernel.org/r/20251208-sqqs-v1-0-290f0594e30b@foss.st.com

---
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251208-sqqs-7884dbfd4fa7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

