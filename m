Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9EDCDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 04:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28B4848DC;
	Tue, 23 Jun 2026 06:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pOlXm7e/";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ke5hfoUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B6B849CE; Tue, 23 Jun 2026 06:59:04 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3766849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N0hwJ22788191;
 Mon, 22 Jun 2026 23:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=BbxRrPvqIzstPF5Jckh9s7ILLYpG/OJbuJiaD+fmK
 XY=; b=pOlXm7e/dpHmDIrWyueDLb7FUBJHxIpaQ/AWiMs/A2xeQ5p2kEMHrH8ZT
 ojCUs+X27Llxn4SC6XXoIGT0Gso8ySvF0ob4wxvoa+avbWnss/EnHweZixWOrICQ
 1M9LVLSmZMYdY/muibREAk/n/VGJ+2iqz/FiEAbqtWgt36sX2fUXB0Pu9EPf/jsN
 G8bWr0VPPYYk8hUev0AWiJJybTn3ZUSPNSKVQzP9bWdGiIIRn9qL4lSO5ZLNTULT
 T57Ap8APIX2KqNIgzlvQ785jZMByVsdpXoEI4sjeJEBySRWSy6X2ImbgU4TSD4Y1
 OSSC9cDJEoAJJvUAx8CgA4yifa+yQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ey42xw82y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 23:58:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKUHjGbHNt+KgDZWiXnZi3lpb7gMVS117VT4mZkDVRB4Rg4ZQZIbktdRTiF62hNoA/IolmxJGlH9IE6U9VTQM+/dY81EEPAxcGXlZLXHIPV00fhT+s5sjJAHOV9o1ZnA2bcwvDgb8QBPQvK/pl2DQ6GqUKK7Vi67vyZuOuxFXd7QrXoU6Vjyu/NoUyZZhDeHDak69s0rXxcqgUh45aIdlbLw76qIuPbcXJGtlpMxZpKXxu76d1bLRlL0oLo1OLZYCl06xvLml3yOX4jYIngj3c4/0XSTdzYa0edDpJsUbk/dijXoaN7f6bfWytrHZXZM2n0rBvxHOK55/MFGdyyMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbxRrPvqIzstPF5Jckh9s7ILLYpG/OJbuJiaD+fmKXY=;
 b=Pwgkm37LwlZoKWlI7NtFD8nNjWXiTyQp4V9lPvizL5uK40SduxFwJU5M0XG44W2wSIc2PRq0dLgj+gkaS4ouVBwmpr+mlJwF78rX8dlFsgK5ydRWdSZ50VcxVbCnpELRzS0pnVSfwqdy0xUd+I3ySUdj9fzfDxBK12sbHR0MyxXPDLdT901SwAfKBy3HjWGajBQuczvjVfExnujmO0vSr84e2qt0NY5/vOd5g35WFVCCBQO+ybwLMyZMZB7KQGKxmCPEGK4vl5nHPGUTlfraSZ4Tt1HPZcqbgjzDzNf3BzrM5Z7ZKIuncC5ylrm/ok9Kg1VSVriFrHB+r+2X3Cn2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbxRrPvqIzstPF5Jckh9s7ILLYpG/OJbuJiaD+fmKXY=;
 b=Ke5hfoUqpo7YAEHGFonWPKKoisa+SZR6dc/iit44tcsUidawl6TFWfRgFylL/DIFioXXMAW4TK28wCeuP4G2g4QD5L60COiDrXKJ/8jsFyJ3GAcIrIpSSDF5JtP3IBbFtw5Jwb6XPeZwuFS9pkO6XaR/WafvyPFXRPypi/QR6m0=
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:58:56 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::42) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 04:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 04:58:55 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:55 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 23:58:55 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N4wrod1490763;
 Mon, 22 Jun 2026 23:58:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
In-Reply-To: <20260609181006.460401-2-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <20260609181006.460401-2-p-bhagat@ti.com>
Date: Tue, 23 Jun 2026 10:28:49 +0530
Message-ID: <178219072990.1099376.15811657406428447596.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782190731; l=1234;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=MdvTMlI4tnnGatWa+ffCuwHxBYmHVrZxSevFzAAR0Fc=;
 b=RbEqRVRdc2j0t6VCXkLqHl5RoKfyhfZ3O8ZqNQIs824srjl8W/IF7Sby45MK5peETjk0dY3Wr
 P/f5fJHAlhjBu7EMrId4UbziTzEbhd0sF+Pm6T9g0mZKhXTbNQFETch
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6c71a5-272d-4345-2131-08ded0e4212d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nbWfbA27o/GHgXnRP3GIs4btWu9MQGrWEyRUEUbMx8b/ob6GtYgu2rquZTuGx9s/RLpSxz4dYIlT5/M6nUblaGIFVeXp3DR5jtdDIjmkcxXsvvS4Ql1TlHiQk0Zrvzo63isPNBiLjbBE5ZbYSaY7W5aeN9WycW0jWqqXsBxxLX/8OFgVh1Dgp3Qpvz3Xeu6N9xH4T1IOqCvUlCurWDKfp+C+EM8Da8rUfC42TWwwXEmqIesxRU9rgkROJVmfG71dN7BLl/1o/+5DKnfNwoWC6G1duNLvDP0/YKuvf6meriDcfWrf0kAAf1yJGZHj66VPlXjppsA2GdVRJo0xDPiZzA+zz71BAlUfH83JYsbfuEYN/e8HNTkQUgb7Cl7fN2/rl7KcubloT0utB7VK+iRVJLjvBDTHCKZaekTadplawQecDYR6RHVw11QiYCVykkjW22tT+Cg9zm+olHdBNKBHOBMQsrHE2TtTWKZ1PAamH3ItCvRNzHcHxN4Dr+8/PvbTtdswRrnN9IwD1V1cKU0/nA6xylgmoJTI9mv2dLaTteBKWLgsM3213owYMoaalku7i05ln+z2R8iV4boFnrjRWg91WM9LP9D4YJ6s2IGvmUWLDbhUg/oTvtNe/GeKMAvhXJlROJEHW56lSm27wWGY20nWgz3Ry70Aqn5Sg1pKcYPfa7avcFRc9zp4OZtIaNQq5TrKg9ORjh97nsVSwL+IyQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AFUbG5/I9NK3KB5LEefx9WJUzPQIV+tnY1C8CGqINmtVw4vwhwcUhTfP93zPct2mNYAKeylquy4ZD9FSOjJWO7pJbh59ta1hrVJXBVl3Qnwas0kHDsuU2DFl6Qmx7f4Pw8HGyQwgxD1GEJJWeKaLm1KN1xKjxjNUIBn+oEa5PknmucrZM7ylHYnR/VueMMH2C2gIFv8tS4ZwbIVYbI0T1gn5rfhEqcuPskgqnhkHyCqBfjuzS50r9h3A7ni+v4d/4j9D1QjcltfcA/Kfpej20EXAiYX4Gz+PX3vRt6TWP5TuSXCVpk4UrWL8fnXhLKhpMbjhN0qFvJoRhGB8+eNfWDOoFZTo2lYjjNbC0NRQ/JuAYdXKxSROFHIwsMoQ6jV5znSD5tA4icVBMVQGErUH/Bb8sHi1V22Oeqr7nBkjgJZSFeqVTsZVkwOB0uolZqH3
X-Exchange-RoutingPolicyChecked: DzhGbzRMedAKPlUWxS7zx8EOvBk1sT23152O03Pi5xFoRhIunlcJ3EzKFo70hQ44Q5mdvbwayc7fG88WZj/mW3BA8Ae/OBA12qxcywFCEdxl/7oilhYYsyAEV2nSLINdUj9sJrt4ptjWIBPRIyCd4d7uSF0cA4mAGpyaV06rBGxo2Jk8wf1kiEU1QeKzT7U7JachR17bRJ1g3pl1OZPFH+KAnp3tZkGzYVb9TxfltckCrzc4BQ80VwDO8+7XPADWUBzlEaMmNGzI9/fMMqDwCGR8AnuhpkkGzHtKpro2ppizh0Zn3MRlak3MRapygfGdh9abyKNJa+2zOr2KtgNVxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:58:55.9524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6c71a5-272d-4345-2131-08ded0e4212d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfXyxM7k6XXlP+8
 9ewxjXnQ9PoGY3Uj05d5SoeIRxJv12CT2EaO37jxtOX5mUbWgLP5g0Gd1vqHMk95MnmJrTXbK3F
 jUaIn5dl0aAZ6bO9Y3DhJV1o/EJoKyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX9r715IceVv+O
 5g19y4sZJmDPZZ2/f2/pD0pTJP4eSDG2J4OYI5/MQRfoaGgn8BXcP8qGwAoIPRzH8i9mKOvyb3H
 i8gnV802IZIyGPbLnMFEkrOatSCPuuRym2xxMOxBE8xz1du7FhfGo7meYF12t/u0HtK+k/1ZH1s
 +aJT/EDnB02RkKUMlMZlmpIFWNR6am0Dm8GP43lDNT2Edhps+gUqBtijC37h+zn8jXPAYAcbnsm
 cem3OFy6KeE6moC5iXe6d16pTd4lfmNKlcMdcidzpHGAanBW7SI0H6wpKsb8cYoWhbLXwpAfLWn
 EyRp6xWbeVQFotAp1Wj9y/2kvIBKN0Z+1iqkbulXlA1vgKAnxIKAuNdJX/TY7sIppMvf1javztu
 Zgr2ttADSZhLqCEwuKWvSNYFMlE7LzsHWw7rSwPzEVVEuV3QxxO+FEF4DqEf7raUVj+4maRt9MU
 20Y0GHHC3vpGgpVrIHg==
X-Proofpoint-GUID: HOrlJONi2VY6925wCNRgkcedOCdeEh-m
X-Authority-Analysis: v=2.4 cv=INgyzAvG c=1 sm=1 tr=0 ts=6a3a1293 cx=c_pps
 a=fq9WP/vNXoxpaIAZvvUcmQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=nmjXCB38mdbVRDcWTLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HOrlJONi2VY6925wCNRgkcedOCdeEh-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230037
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

On Tue, 09 Jun 2026 23:40:03 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 39cb00c3f43..25e40f6a666 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -146,15 +147,14 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
>  				false);
>  			if (addr == FDT_ADDR_T_NONE)
>  				return -EINVAL;
> -			new_size = size;

If this removal is intentional, we can get rid of the redundant call to
fdtdec_get_addr_size_auto_parent above since the locals 'addr' and 'size' are no
longer used.

> -
> -			/* Delete node */
> -			ret = fdt_del_node(blob, subnode);
> +			/* Update the reg property in place */
> +			reg[0] = cpu_to_fdt64(new_address);
> +			reg[1] = cpu_to_fdt64(new_size);
> +			ret = fdt_setprop(blob, subnode, "reg", reg, sizeof(reg));
>  			if (ret < 0)
>  				return ret;
>  
> -			/* Only one matching node */
> -			break;
> +			return 0;

You could just do return fdt_setprop(...) here instead. And a similar cleanup
can be done for fdtdec_add_reserved_memory below, if you wanna take it up in the
next revision.

-- 
Anshul Dalal <anshuld@ti.com>
