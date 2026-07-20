Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D794AC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5546784119;
	Mon, 20 Jul 2026 10:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PSpJlk1c";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F1CCOfX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FF0842FC; Mon, 20 Jul 2026 10:09:23 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B922B82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6UjgX1435656; Mon, 20 Jul 2026 03:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=TgjK7eeMIKdZUlOqF8C09ZXQ54Tf9JhLWt4hsQsNL
 dA=; b=PSpJlk1c3BeM0RqDgKifl08SZJ8h5uDbltAFfHVPdejoQfXJaxREW2kUY
 omoYxbyioryZXAZzuDKh7HkKMx4C+vuaMKkPjYvbvEMWp4MH3+XC3NAIiGFSz0Qb
 yeHeNSExfLCt5QUw1GMJbmRBm+i2Vgdi+3E0ViQiWd3ZofVTT/7SyciGWcxa+v69
 dMPQ4J9Dl+cER98JxMFAtHS4dFC11I7Au/HWw82d/0MZmy2oPC2++qoARncxpnAE
 Sz2Efa7HxD8u2Ya3fvOYCL8IriLUuodDYEQCEJopU3rCKmT1SibAXFSJV6TGLHjA
 c5brbDq6DnwPRtoQriijKkgcc7cdA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fgwfrv93a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:09:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTNOaS0pFg2cDFDO2s6w9bOpIDaDBnc8tQEunaWr/GOjCVwzZ/o9eKWuTxXHngPswQpRuIDeBxIjq425pULYqBGQOixDi0jKTJ98UcxkwnrjO5oNrSBJuFHeicDFB3kVCO8qwMN7IcZYTRooo/YgNahHpsEZeBOxqddMbs/nc/TyPWObrCnOC69f1VdI/t6BzjUzNyomQ3q8ltQ4d2rBMOuCxbldfTqy5u1Y9fi5jMWFGW2Iz/PwL4HX+1MyEXMUQlUdigpMju2VReG8wXTjIyJVom7tk0wCJ06tLhf5Zu/xX6x1EQZZ3AYmiF43Ral3dBxqBR8FRyg8eHkgpc1aVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgjK7eeMIKdZUlOqF8C09ZXQ54Tf9JhLWt4hsQsNLdA=;
 b=AB72snIkUM1BQ+/CjFqzuAXi2DyYgLTzIZP+5cD3gQspi/Y0i8Q2yZBgIfP0RDdT9jwaD4Y9WwqnLiZc+dyXa9l/CHhIzfbmbVW4XMIE4c43tipQLMHGfiOtxygpJE+fd7kFr9cnCU8Eu7erx2EeDeVuiMzbZ1wTzH3+i3FQajOKE3P+Vxuskg4kV+pwn2vVlkVSK0QTf3Y4HP1CE4g7utwVC7akijg5aeiRr+5u+8/FMH6kaowbqBP9Eljmo92NNRzfqxcl/YliaJTYlwmGK7H7DY4ZMavayLveEa7jUDVLV3/9mxnfkJWd0aQmfMubrjOIjn4EEUe5pycAxI53xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgjK7eeMIKdZUlOqF8C09ZXQ54Tf9JhLWt4hsQsNLdA=;
 b=F1CCOfX8GQ8pLfq47hr11Mby3QdU5MOHqq2avK60YYd2Ug7Y/94GTMlqbfa82nlerGMNyZz+qyVYyFf0Yvmg628763iUFFHyWupCcS6XRn6NFzcuOezPV/0FONo1jptEr7Ox8Ues666gPaDt0gKIwfMKUm5yty+x7nfFOL/ykQE=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:09:15 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::74) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 08:09:14 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:08:54 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:08:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:08:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFm2478591; Mon, 20 Jul 2026 03:01:19 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 1/7] arm: mach-k3: Explicitly identify TIFSSTUB images when
 discarding buffers
Date: Mon, 20 Jul 2026 13:31:08 +0530
Message-ID: <20260720080114.775206-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e54d8b-04b1-42b0-91f9-08dee636300b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3Cn5fJP6aOXJdC40FUrhkQ/yn+Kpln6KKYZtThyZg991zuM5/3/28FzO2OvPDuLfMo6HXmawhCXygYLz5vM6eRrHva866MR6U5aly1rnXpEXhSdsl3pXKwBK9xWFb+XdVqVxCp3YuQxV3A5j2hcy1BWfEubNML61OfclWsla7sAlo0Ka2BSBdCB1EsJuWclOomctG5e3LRit0z8KMEcjkF7lNPT/jwf4pzKjwnvkvHgpfMOtQpEGke+N4xVdNI4Nq8C/Jm3/eRs0JaAA2AbhEgPHcOcY27km+4kylqF7xk/z8IadBffDasF91rAU1d2qvykG4cUjNN5/l1zZ9xj8uXkPmoEIbAkh1QuFgmQkjBLf7muczgqe9r9gcj6c9yvQ8YwilYC3qUZFu7s1B+6CHnUhvFJF6grJVagsbycUUXN7bqEErnvwvI3tFyFFVRJeokbbbYTofGsnNIUL6nq8Sk7MMfZjmCjfeVrQh197OX7azgBgm4duNkFh9Yiykk7RrUhHSQ/SeD1fSp0VRqYFYR7jmSgTmZnKA1rcymWAq9R/8XVfjw5wzbJX4InTnRq2nUCXK7xUi0qbMgN7myEmBdETu/TtH7Ow+3q8jiIkuSy0VFQJKw/LDEQnEujVEe9KQprFinX9CrONYpYwfICCuHajbCDYJ9O3SIX+ulCHykD/1y9vG31g0350WLKKw5udHiI1FrW/9AJ1DVeQeWR6xA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pDkNvxHuYsGvjGsI1F6RmI94HhmnaJ6lOUF0daKMSSTFzcnfPM36aM16Oc8H3iQuh5tQ6zCzObCRrPNvgpvH4mhHafoffMp4srh4NnAP0NSHvmMMnwtODrRZfaydI6StorLgaMUFj/82BAIclY7etNr94+IqMGckQSZXLqo5nJKX8KS61bPHc4/htDOT+hz3KU0+/PZLeff93TNlrBe8OYC3RBLMLbbJO2FyuS3Ibx4D/DZQcLePOMDLp28t2KNDC2VxvVKs/HAgLswIy6ryVUVRd/6EqRbPuuwm2SkB8KTiLY+cCGK3eM7zHXDtJ+unWJvKDzKKgsdYA3CeZ0649t/k5Bv2fbsnNgg6P4bnWvx2RBcYgjBI3yjt4HWk/5E54+2XbceN8O/DDgwX1lxATJk/j1mdtq/s2PhrGjOW9vsDV6SMObJp3IDpWCF0tdfN
X-Exchange-RoutingPolicyChecked: QP9y1wASkYBsklESVoa07nTu4WvWwbxhB+YNnjScwS65KD+c5yQMxyeKAPS1ZdJ7ri/xDQkYgzZ20StYob9eqvgpKdPaEAQgv4ZrMipmCmPnCyGbFzRFFYERFHIu72cmvitMKNEuDkM1j6Kl4dyI30iwlTHjB25J7lbkcJ3MHAbd+vgzuxin319roaakLH8wFmPfwVQU0PJSQvlk3waJDLRvid/Ev5VT7sFIH8kSTJ6AZAiV8xQBnb0eseDF7FcP04fMEK+GQvvDtyUg4ECo/jQPu1Qg8X3f8g1kTIOAcZmvkpIhs5v9AgfM9rzv8QVkngZlZFrCbltg408F99fOvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:09:14.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e54d8b-04b1-42b0-91f9-08dee636300b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX4Ahq0W00HU9s
 I9gohI29CRoL61xbCb2mAy0TtXDIUXdvo0uO0Fn9/aEY28g6MIpY1JocMifku4ZFkY5AG1jy39H
 FOQQXq1kCL7scke81OLqUw3aYTe8pTg=
X-Proofpoint-ORIG-GUID: VEFdQBUjQDUxdlhTY4ONQr5-vizZtt89
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a5dd7ae cx=c_pps
 a=I1DPz4bLegk/AyvijR/I8w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=_5kEWAfKtByya8EkQWQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX1CVsYdpc1pdW
 vSZVLwCMRhl8TyEsAo5e6CtKPX31PWlGZ72xszrOlj8qU7VdszJO2kf+FKncaxgjXgIf96UmsI8
 EKYaDFEdzjns42C7ioNccavxPWNersum1OtBdOy0RD/lb7Gn0q5kLby2lwy6xbLJZXq0jt482tM
 FqqQX7/td1fKtx/9f4U1luuFjev3NjIH7gw3rHgiD+KOqIHx8NePARjtBSTIfcEWTUoPKPp1iTD
 MNeuqwL/XRoMS/rg9pj/kGmg8eV6RXFnGVYwc9++jh0aE9bX1WC73igVXgsyisUmola/pNauCRX
 9LJ8tQkAxidRMUhiL/8yFmGnru0TIpLxjyh2HbO89NcgI5PX5w6joy1QhAs+yv17ybJr8XheOzX
 x2iUwkUQBLwL6fGKAZyCjn6GA/DvfOGtmJaP3/hGrwjSHXtEvRXTVoWh9kEVdGWPRpSvgcrwXfZ
 +JOZMQkOR7hXOdF6KBg==
X-Proofpoint-GUID: VEFdQBUjQDUxdlhTY4ONQr5-vizZtt89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200090
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

The board_fit_image_post_process() function assumes that all TIFSSTUB
images appear at the end of the image_os_match[] array by using
the condition:

	i < IMAGE_AMT && i > IMAGE_ID_DM_FW

However, this assumption breaks when new image types are appended to the
enum and the array, causing unintended image types to match this
condition and having their buffer sizes incorrectly set to 0 with:

	*p_size = 0

To avoid this issue, replace the range-based check with an explicit
match for TIFSSTUB image IDs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-4-b-padhi@ti.com/

v4: Changelog:
1. Added the correct condition in commit message. [Andrew]

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-4-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-7-b-padhi@ti.com/

v2: Changelog:
1. New patch. Fixes condition to allow new images to be added at the end
of the enum.

 arch/arm/mach-k3/r5/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 484d96f9536..a0e1b791c82 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -347,7 +347,8 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		}
 	}
 
-	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
+	if (i == IMAGE_ID_TIFSSTUB_HS || i == IMAGE_ID_TIFSSTUB_FS ||
+	    i == IMAGE_ID_TIFSSTUB_GP) {
 		int device_type = get_device_type();
 
 		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-- 
2.34.1

