Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A0C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 07:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B9A84BD4;
	Thu, 16 Jul 2026 09:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fNdvBECQ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TJVdPXYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1633884BED; Thu, 16 Jul 2026 09:39:26 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F32284A67
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7G3QE3179107; Thu, 16 Jul 2026 02:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ZU0v1r+vgYLzEHWSAlMar6Iq8W+Mb5/2rDg9LXg8v
 TE=; b=fNdvBECQHAkm/MckNa7+HYEtZbFL8fE2ikoZTMgt13is2sMbcKWYRf5qT
 o0HEZkrNL4amIUVUXujIgDxpFWo7/uJCUc0gQXm2RhGG4lRsqsCoixDG7zy81F04
 ydwfEXX/0+wRyH7pG+P3NtSkoigvJhshwJgkDl7fDnFLBiSBgvFedr9pmcxKj7gy
 DJQbKa4TIZSQjTGorUKQz0+xQMwZKpbihjBU1sjcVG3Hq6aXtvhBDoUvg49U8ky7
 JsTA5dxSeEB+IjyoAuvsURJ30wYjjpyPOBvUCcvgVS7ipEJiME1gH/kXsDQ4Vcf/
 VV8WCLSn7mBK0QNTeNVqIQx/74V5A==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe9jb69mw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 02:39:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyjIUMAUP/cQJjyousfZa1jNuPfnb2j5TL8oH/2jFGbazXs0xrYJYjGDap/4fXGxd4lR8RKiTlhTuh07z+p86SLwZpwCS92M9FnoTeUg91W6HRKmfHJgbaaW1nZkyQogKOkTEvqjo7gjPD3ZHqTCzjUiV/RWqvTaSCf0pZepo625yZC4sVVimibZI6nCHR5Z+eIibuReUn81tN6O4ch5STGdLZdqnCMzzJ8eM5VYA+Z77I9TbeKAhfXUTLXvJRqzUMsh/8Mx0XUvAFXtXSJxhj6rv6dgANsGZWqQCCbt+BlgePaSNY7CfWIFu2qiWDXVL9bUr/9yC+Zj5WqC02oSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU0v1r+vgYLzEHWSAlMar6Iq8W+Mb5/2rDg9LXg8vTE=;
 b=bpLuC5nP1iWj2oGamnzLU7J3KYNdFM2iGiKVNj07XLsNDMJKOTaos4T5ixrM42rS5my8nvC1FAqUGdIN22I05PBGtU1krRXjBTQJUx8ScilcHUH7hNpmVATV+57tJ0wthtv4rgzZaREPszcGRYV2S/Z3O8DFoMAdK3fljrnbM5q47oh/udAgGDjLRS9oAjU3QtPz1GX8H/7tAHPx0a2fWQ8Dqo3gqaGM5+WjywX/VO6cGlMlNBYc+eAr9Ax5u+9UkYlg5vXw14RPE3GAYlIpql2AbTgaXYS0gu3hsUQmrvah53KqzTozUV1hK9VSnNNNkJD9WRB92Ugn1lTpbmsRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU0v1r+vgYLzEHWSAlMar6Iq8W+Mb5/2rDg9LXg8vTE=;
 b=TJVdPXYxIVKyJpbo3+V6EU5ByerzJ8URDYyfzfKNSZIeYRZHpQcYkhLKiSnyN0OyP+qsWf7VE10Fy/zPXgUmk/V01HmQPA8IHhkPBvLTqzBVgrjTPPMVqBwYD8Ek3+wuCDUjlTSt5ZwlydB8YVw0zcWDR485qyHDUbn235FBGcc=
Received: from SJ0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:a03:3a0::24)
 by IA4PR10MB8660.namprd10.prod.outlook.com (2603:10b6:208:561::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 07:39:06 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a8) by SJ0PR03CA0259.outlook.office365.com
 (2603:10b6:a03:3a0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 07:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 07:39:03 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 02:38:23 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 02:38:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 02:38:23 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G7cMbV818745;
 Thu, 16 Jul 2026 02:38:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] board: ti: am62x: Fix build without
 TI_I2C_BOARD_DETECT
From: Anshul Dalal <anshuld@ti.com>
To: Guo Hao <guohaoprc@163.com>
CC: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, <u-boot@lists.denx.de>, Bryan Brattlof
 <bb@ti.com>, Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>,
 Vishal Mahaveer <vishalm@ti.com>, "Peng Fan" <peng.fan@nxp.com>
In-Reply-To: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
References: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
Date: Thu, 16 Jul 2026 13:08:20 +0530
Message-ID: <178418750029.393743.12900440415467707713.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784187501; l=849;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3Rfi8Ja0KGPt/rlw4PVzyt116CbnBWASs/NN6z1mE+U=;
 b=8tcOmo6UzD4PvyxYczPWYUkdnc2OeQoeRTQNaxoTvjLgnOOxGfPd466aRyiP7+r7p3etd+R08
 7I5+HS6rNAPCr07HXblBnD4ttWJ3U0sn47L2LZjwiWDiaI/Hp5Kg1bq
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA4PR10MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fd5d3d-5a23-4c57-52a6-08dee30d4f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: pYC4FmkleEal7ays59XWVgBp8sFr4tX7kZtUNEYRniFLbUkRB3ENiycI1kQpY8dB90FzrHYZ8ELloXWfbBf8YQSNbXjoMvysTfN+MbukTxsjSEOyYl2mzC9sp77jdG4iGpIwej4M2+FNy7rQ/qjMTJUh6gCNLHCPLmPrrmSSRtO0zBBNJ3MqxlzAE6sh/8uBLe24kjmYw2dHou/t4yJEi0kFczdW40gEw0MPU4BcxRMVD0A/oj6Yq46t3xBaZauBB5ojUMukAK09jNQTttChF8SWa6cHaRX0mYUlOqW9RiHCHd0Mz+xDw4uNhhzuhsJ+gEQNfYgsljoxxOrWuFgpq63AmNN/461uNsTZkGxWAwMfz+azQefji7ICNHjzzCZD3X+C2iLc9UstTrEJCkZ4DdHpHq5m4GobSZvytSraFOHgSBr11usGXwODmKGImw5x3SEETuAYY9+uWzKxUa2D7XXTyc3rWjhICxfpyPmziSsuO1ZSxCpUBGg8P/E9tRm/ghX6eCien13vW6b1hrO9frE61c+Rj/cJGGWRe3ej8RX/Eko4fAQ5oP1CinRg2/v94ofrHX2PqP7/kc801ClvV2py9ev8iEe8zqKSf56LAbmw8zq1gWJO6VJpX5r1+1ksCycQ6au1pJMUVdgxl+ikbIsodgaSDkXqseKb4R9GUg+0DAVeXZezG3a4wc5JibJ6N3CIljqb7jDZPjuaGxV5AA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gvZ8UTkpZwmFn9X4Hwj/tTtp94tv6vWwXc5jozaalkQhzTACsLGWL5cgVA+8zRqbS94RqeORl7iIamJ9/i7tvvWvHYBxbKRSwWQdToFIi1FpeJWxtCUFwHZbK5HzGarFdEbIxSCc65JqIoO0rx0QEvp8ohjRspBbcQEbLmnWARSB9QN68q+f6CuxZvequ5356qu8LZbgZBGB0YuMKn++BtC9fFSp+6nwZBC6M5Fk5h9r/HwEABODNAu2X9KyW7QWiUdMp1b+B5rzjnqWa99WnhMHVEDvmMksYmgow1S6meN7ZFQB0G/unQnszddHp3Ik35VOuaMWFbC7tfhBC4oMu1wi0UZIwxsXWhzhRzQq6HgxSh3+ZFwDOK7MPby6fZuUDIIyayVExoboAPXy2Z2za4eyboUQpz70V6lz5DPJFLB4COOuMW5c/cSThLmW38r
X-Exchange-RoutingPolicyChecked: nJm7oDi6N6O3Pg3lsrDqaF49gsrWTW8fiNhIt8L8e4Xu47qnSRE0ZkFlQCDT1GFKktiY2Z8I+QL6D2aEUicax1Qa2m8ECKmwuQ8XThLQXhQzOep66gUrAMRx0xdYTyyWMFvKPSQrtcEQFXcrzgTdnTT3y/yHQQlUCAc1F+nWXghz3Xn+bSk1S5DDaQChT2YR2Sq9wG6V+nQMhWjKrPJGsoSOBXyN5ZVZWevT/tU3tPo2/xwqVDISqkHjdu98FZ1RpuS0ol8bCFpgDq2oMxyTejR1ZH9yo3KdjjBJd/4s/2IhYk7PR49JpbdMZeVTarWcDDlSygFyJuTAhawRiGgwWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:39:03.9561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fd5d3d-5a23-4c57-52a6-08dee30d4f7e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8660
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3NyBTYWx0ZWRfX3SYZXLDPm0QC
 UFdn2+RjW8mxOWImlkKJUJDlQM49MB8b04vYkyCh4jFiY/i9oZlGlCxDPHYcPrRS3KCodcHjoGT
 6DbTBWSt/1IXkF3wzp9tmrAaKW6ajlEipV2YgusMlPUTmf53YbFUJMyw8RsjZV2vzu6hLRnAwJc
 2UOKRZ+w1nVujLsmU3oK12zWh0YVJEIGc2W0eT0bLIX3oXD8mSAXdBofOt06kFRp6DzzFmqdEwn
 KEXAxY/detIe0ylt0gZcYSuGsWGPuN+sOAd/RDU+qmI9E/bHglI82OHvzxKSyJDoy6zxgCs6sBK
 anDwvSPaZFyWuAA5MnqXn7bbeWGP1ba3lwT+95s3Qbs/KCTG7TRQ19rHsMawaAqQEAJjER+hHNb
 N78bK5GRhKhWfNEk52V7uwSNyQaijLVx9AkwZog7xUNckoTXMG1Fen937rcml7FWiLf0kZOP+Rs
 8YurjwoppfDzczWhkWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3NyBTYWx0ZWRfXyCUyCT6mC0Tb
 rQRhkaOCnTJAPwth9IrFU0+MsAdSZTLPXMEnAl4k8LxsFLR0ZY105gdwVC9PG5HzNR9ZFLza9ef
 82OBOLsA7hmzKXoHDrFr6wJ8AkPiBj8=
X-Proofpoint-GUID: KRvIk2wGLsBA8N04neJqrlcsMRZSY75I
X-Authority-Analysis: v=2.4 cv=ROqD2Yi+ c=1 sm=1 tr=0 ts=6a588a9d cx=c_pps
 a=YKnEkNs9mh/nosOxSBBx4Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=Byx-y9mGAAAA:8 a=sozttTNsAAAA:8
 a=GgQJ5DKRVZ7hj79r504A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KRvIk2wGLsBA8N04neJqrlcsMRZSY75I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160077
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

On Wed, 15 Jul 2026 11:32:26 +0800, Guo Hao <guohaoprc@163.com> wrote:
> setup_board_eeprom_env() and setup_serial_am6() are only available when
> TI_I2C_BOARD_DETECT is enabled.
> 
> IS_ENABLED() does not remove the guarded statements during preprocessing,
> so disabling TI_I2C_BOARD_DETECT results in an implicit function
> declaration error. Use a preprocessor condition to match the condition
> used for the function definition.
> 
> Fixes: ff1b83c095c2 ("board: am62x: Add support for reading eeprom data")
> Signed-off-by: Guo Hao <guohaoprc@163.com>

This is a valid fix however I wonder if there's an actual use-case where someone
might want to disable TI_I2C_BOARD_DETECT on an EVM board.

Also, it looks like the same issue exists for other platforms too (AM64x, AM65x,
J721s2 ...).

-- 
Anshul Dalal <anshuld@ti.com>
