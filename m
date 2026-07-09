Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75834C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6E384AB8;
	Thu,  9 Jul 2026 08:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lQsQSZBi";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aL/Ty42k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CAD84ABE; Thu,  9 Jul 2026 08:31:33 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA0584AA3
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6696UQ52292840; Thu, 9 Jul 2026 01:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wnxGJLxlmcfk487F4Fu1fsCt+qO9hVBF/4VHbJDno
 u0=; b=lQsQSZBihJVFSmZSAhj9DZcbpBiIrYMOtTrFQBcAZpbtGGVmXI75BeyPw
 yEOph+bfOBg7K8MsI4ENXQ0PVHyl19G/3QAlZDhb8VgPzarDysQYFETtT8qfmzEW
 Bx8wVhnKW9g2f7oBGf5RDNSh8UWnxFbWXrihuebPnlNy6zUNM3BYqwJJzA25umMa
 C49Vzvrv5zvW7d8g0TW9vECDpwMxu+8flny3zCs6UyJ+D1PEjvN3xJaYxOYitAp2
 tm3BrVfZ55TxSxFCGxhTnvY3X2POWzWl+Wz0+BXor1/+5lCJBgzThuZpcIxwH6zc
 GZf+kgDR8MVdE/YaCUV0Q577HGDPQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f9kuay602-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 01:31:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M38JpPF5o0jRGoWoU3VRxcXIkA34Kd0+i46H07c9U1YcgrawYFu4SoGmCoyFaWh7nf5P6RyKs4Iec7OzjrtPb8f1UUUX+sV3UXYU0xXApkYPdZ+dpeQXaAI4gqnrlptKedAyUxQnY7oPC19arqJXVlXevmxtypDsmzD0FjcREVZpQ6JwWlAgOSXSlURKzIcZW6eB3oiNiYE0f+VQSndbb/8iSyISMQRNLJ06u4Gevz4O7tidM3f17/bS3US2yEOh8CqupXdPXxj1aNNl4xiZDQ4gBSXv0/u1ArKS0/5UuNIuKGupOMJV/v5UYnlKdiJ8qUdjIGuTWqRpi2opsdC/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnxGJLxlmcfk487F4Fu1fsCt+qO9hVBF/4VHbJDnou0=;
 b=jwy9ptn8QEdHR50+q46M2B6RlbqdOcsMKQjRVgS3ODag3C/vNwdHwGcqDKCjZp1xamQjIy1ugoNTg55senphmExJNROsv5YuvWLv6gm307ngMw2wGgb8V6Vy9bVX922mCh6ROc4mPDCbLAdb1wKXGB6LNAIHv5yHsuHgZVNDoOj9p6osHdXyz6irpwsVrVGBd4jx6s3paRpyCLEYIMZgmzh9Cx0dval10gLvY878FVE61/x819Q9ci5ZSqD3VFaAwCQV0ixJEVX+FSsHvl+UwyJ1Ik9AK4mYSK9ttQVB6jHUtZkBUO0JGJMLSuY3syz2Mgj7llC02qlfMYIX4t6cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnxGJLxlmcfk487F4Fu1fsCt+qO9hVBF/4VHbJDnou0=;
 b=aL/Ty42kD6Oa/G4KAzuKwhoZPdDsueogEDCVj08QAodx4XQjtD4Ez7bn1HcMy+kqi5NTo/ylr7JhZ4+sF3oc3uZA0RNCT6uyItOFXC8+WH5TRlYPwL++t0lj2hWEiBAsXUf4f4hytZTpGn9nr7DbnoTScp2z5sTWJqM/4sYM9cg=
Received: from DS3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::14) by
 SJ5PPF8BAA3881C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Thu, 9 Jul
 2026 06:31:26 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:8:45f:cafe::6c) by DS3P220CA0009.outlook.office365.com
 (2603:10b6:8:45f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 06:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:31:24 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 01:31:06 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 01:31:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 01:31:06 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6696V4De009874;
 Thu, 9 Jul 2026 01:31:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
From: Anshul Dalal <anshuld@ti.com>
To: Jordi Trepat Mur <yordy1902@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <vigneshr@ti.com>, <nm@ti.com>, <anshuld@ti.com>
In-Reply-To: <20260625174121.3633162-1-yordy1902@gmail.com>
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
Date: Thu, 9 Jul 2026 12:01:02 +0530
Message-ID: <178357866277.2041875.12232978422798341195.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578664; l=236;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=mEf+906dMR4lCcCxLumw16GWspoh7zYz2GAopKRfi/I=;
 b=Wql/TTDxoI3qJS+aAnLkCv01NCkh6AjgxV6g+lY91tmmwo1Hb+elC/nylD31Puqg5vCJ6RBeC
 mh4rtHhU4ceCaQwh1Mz6zeAdQC4uAJAtIgxmOMI2AqIqYVMyhV9satj
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ5PPF8BAA3881C:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c97bf7-a604-42b1-c616-08dedd83b2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: uOQ3zw47C0dJeW1+ZBARhqp99teZ3xsNvhvS5ShjHV7ef5q5dp0EUVVtZrR9hA5U397uEh8WtJ0c1chYh/4HlPFKbObJfZgwKYEZsbQDYxNRNDO5t+9wO/CH5o5blfKyD541SJa/isINxt7dM8r4BbuvNGDXX1sBQKtO4AYbkzaLS4CNzEgLzSn5ybphMmYAEuWYVDxaRnChzCXjKUPguKmVYnA8FmT9fAPUkmubCDAmWw8D6NGIe41ah1rcBNXR2PWU1Zw0FEuyFNTPKaSgoX2v0PyN9DTS1CK9FFGyF6K5ETz+1g2/ovGjsN7nCtuSKuxKYanT+RvJ25eFMSLEXUNcjwI6T6r6NO1bWryiOsxvXHfeObUXQvnCmldnqJr+ysg3RZli01vz8Oc/JcPro0IwclJ9Bqdt9g3Hb7gks0Agx6s4fe/vkBUbAb8uOv2ZXv1IEbMtNitpBobI/yeY1XsvfRg/V5eaahDc5OPXq/HnYFqOAeRkB1U1Mk+4bzPM701qxgBCA/g7IsJtazIyDeMQoIspf1CFAgQRp6Ixw5t7I22n8kvgjQoiSBNAHv/Bjnhggp5QWkptn04vPAUQaxsjOrPMXT2mUZl3oTj8WK58vhUwYCCZAkwjGD+YfEtBZIcufRmOpeSiuCH/FeFVwx1sSXKYqSdOBzBaHPGp6QAaSd+GNps3FepEORumZkDSkG2XbRLmKJgt8kL8ibBQeQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c11H2B50bT39E49RN2gOxCov5OWLAJ0BO0z7ZTactog9rtGt4POWjtmMw+ALv6AlJbZKUWZcsEdot5CUEQBjIbpBynOTQzBC/W4YapvxUmquMvmzZcL0f3Ipog0l432Vp9axm9QpXKq5DHWKp4Rw6vxOP7mJrPa9LlzeAV8ip0BQ8Nat6mdHakN7AB2uxQnu8wCcAwJERsFmRa8UopdrzLaGGV2/Bhb+E8dWdIKwnEdUtzxwZ36AWaSfTrwdKVfFk0mHsvFRBu7yP9yBRRcTGMgWfnlLxnjEKZHKxBBeebk2llstdXLHiKF0XHChSazuj7+Ysf3UFQP5baDTQ1DvHQyJG8hFrk2ikw0TaS4zT866dXMnu1vpPUmhKfTphevaSPNck9tmJp42ij56hXOWztLxtV/olfgebRjhFW2YBQStTswbaHIGfBPe7sb7iwTP
X-Exchange-RoutingPolicyChecked: LJb5qdZZT04vnayVUh0J+wFFbg6cQ9RnCuK8vcTzproxmR1cjip9KqgxLsu7Vb5uBoJLm1geqDt9sBBrUYZ2OFzUzQN+hp1/yee94hkdnhDs7en80TGKRJBkvxsvAC5IpYUOEJRqVumKMJJMLhhBWt8FTQacpqVlN2WwZw0Qd2Sq7MBF3xjQHCTwMEsa7jaltOfiZEYdhS28WgE9G/RloNwNwbqTAMChWmpYxeNLB8AYmNxkcvJyHJ9jKnYjYhtgIfE0GHU0p1vCD0ZouXOxg5HGQ9MQZS+3c9sgXiLtV5c+WiZxap1IXJu01C0PgILb+AbeXQhA+oxtHksqmk0nxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:31:24.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c97bf7-a604-42b1-c616-08dedd83b2e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8BAA3881C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfX7tjWNS9tqjjb
 bvCsHQFcNL4uYuaHyhFUAF7bpFTFxlcbt/pyFW3Z3o64+DRcNM3c205dCMpZFqOsGTK40bWTeD6
 zQ+EH78ynxQ2s17kJuVnaDXtrWRThmc=
X-Proofpoint-ORIG-GUID: 2UruCHBZclGaCeN1Nzf9jaaUCLlLaOdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfX7AGJ/UD8U5qn
 EidAoam4VoctY7xrfsdSuiGtB5OxNrMXG1xEyxnxpiOhVAHIFY5hWK8Fv7yW6uF1J/VjIA4n3/S
 X/uXzurmRTzKtp3R33AqLjYHSDxRFJxVmsJoZpwYOQooxiq8c7pbocwCrsjPBRsJ8bHlC8gUsRD
 hDPhgBhtt8lT1aNvkIU4yZ36CwixKvraB9Ua3Kd+Xr6jTXwpJETL6i/D2+k02q/ERSrTTj/xi/i
 a5XWDXkHsFL60wPziojjjylhGrSH5FcVFzG9kbMYbkGrVtqzJKTog3wZ7vEM92y9jn8SxcozG4y
 luD2nDJL34SGvoO97UCpFYe5478Gahw1yI+k9FmdGrLVimfABBAau0UhedAHge8chPGVD95pLZE
 aQnIMDPr2pInWHvpdUMnYbWS2lHPvfYie3IrB7+keK7BJAXGZ5UEj53++0ygz1j2EWEFaDisWlt
 +jGlBQX6xeAeYkPNFWQ==
X-Proofpoint-GUID: 2UruCHBZclGaCeN1Nzf9jaaUCLlLaOdV
X-Authority-Analysis: v=2.4 cv=GtJyPE1C c=1 sm=1 tr=0 ts=6a4f4040 cx=c_pps
 a=bw0VQspFR1l10E3Rz9sV8Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=KjUE41Sa7xxLoNDqXl4A:9 a=QEXdDO2ut3YA:10 a=y0wyb9q6_hAA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090059
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

On Thu, 25 Jun 2026 19:41:21 +0200, Jordi Trepat Mur <yordy1902@gmail.com> wrote:
> pinctrl: single: parse gpio-range as a raw array (O(N^2) -> O(N))

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
