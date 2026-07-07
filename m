Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329DEC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CE9848EB;
	Tue,  7 Jul 2026 12:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bZLWU1ss";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hzvig8v6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EFC84942; Tue,  7 Jul 2026 12:44:32 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C08C846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6679X3Yv3276619;
 Tue, 7 Jul 2026 05:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=KNOBuJszX7vX6
 JuBLJyfEriw6nDWtIf6A9HpyPwgWo0=; b=bZLWU1ssLv075CbmNuyoLdaEQLSuA
 /MTPIJYTxgh0YcB3fg2kzdT3TnvYL0x97kOOYo5VXScdaRO7n5Lhecstes+O6pOU
 yPrWRgq1HkYWMIMFQpBxu0RQZ3tDUWMl0+nu8SSP6MUQKjbfzSdpufD8ouGEocJy
 xz3L0oevI1hEDqz2Lg/tG9QzRkeMS1uqjgqcwXQ85L7trTP46q7YvKDpL7U0quzg
 AbLWFfjTnfjuhXXVelbWg0JdjwRh61BIKX7Zjxn0IyWIo+iITlzQP0TdRPJ13HSK
 fI1BbYZrT4STlHaIyVjLBpzRN1uAQt9eDXixmmzvvgybtnJjiWg1pE41A==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f8xx2ga57-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 05:44:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNWKFSy4OvT0FMPbEy5h6/u0ppPuQIdsAkxjL1bY8isPZW2Wx4acq5/aHNYj/qncOt7ST7WnFvS5XLaxVIq0EwMY+txK5sNhzAxIUErFIKxNUyGD8ECjlo+zWi5HozYk6h3DVxs6y/F/Fr1mO3aBlB0wAF94DRg07ZoZNzOrW1NvkPDHaBkMUU1oLSQMVyPmFR2/GhGvCpnUod1JlstK/fJ+E4oiTpgFDWa9/cGJpjtCi6/zvpFl+XeZKBq7Ya0/bRW50i8FD4A8OK85P4sMOWjkrT/a+hqLmt4o2EFejZnEZXJCDUDQi+sRnQLNzUjLU7PXRFfCbmELKsUWkkEPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNOBuJszX7vX6JuBLJyfEriw6nDWtIf6A9HpyPwgWo0=;
 b=MAiPY1XuplQwbjiRIByhZKRnuR2G1FNDB3loI6xogucwmYEl8zMieNm7LwsQJ4LWOEsvm5Ibeo4MQvU6yDrSk1cFdnowsRUemD2Ca9oGp1VOu3sS+15MSbAHq67rS28drglCuFfbZMj97geLhrSnwROOTk5idphjaaZJ4QfmDKSKVY77EnmUKEX7EjsiDdDGmmo7IGM+mgEUDHJ2sQI1dIMq6e1eeoiN1yQezl/Hn7HaYNPEuM0iWAxF4/1Z3RAEHqUT2IeRswi5Pk1Wgq4ZN5wH71feYAmWwmFXvGEXz3YF0Tcwc2ARxusuFg/Mv+tBTsr2cDQrMFvAZ67RLnSMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nabladev.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNOBuJszX7vX6JuBLJyfEriw6nDWtIf6A9HpyPwgWo0=;
 b=hzvig8v6EpVpOGjrdxUPkHn5j47gjlC+t6mbUvSF1Ui9oQveRGmgXIpUJANeegsp4QfjccaBmbM+Bb3g/cCQjueeDjuldiTYNxdOHdoG5Ntm5Dsjq6UITtC+XvOHyoF9Yqu7zz78ii4YMUvruoOeAEk3fzA0LSkgBbVuyo+j0Dc=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:44:13 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::93) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 10:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 10:44:13 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:44:12 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:44:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 05:44:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667AiAdC3641996;
 Tue, 7 Jul 2026 05:44:11 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 7 Jul 2026 16:14:09 +0530
Subject: [PATCH] tools: binman: fix changes not being written to source.dtb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwqEMBBE0a1IfxvoqMTHVkQk0VZ7wEQSHQbEv
 ZvRz1NQ94RAnilAk5zg6cuBnY2QaQLDou1MgsdoyDBTWGIpDNtV2944t29LP/FPSKWVrLDGOi8
 g/jZPcX6abfc6HOZDw/4PwXXdieOjjnUAAAA=
X-Change-ID: 20260707-binman_bootph_fix-16a618090934
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Yannic Moog
 <y.moog@phytec.de>, Chukun Pan <amadeus@jmu.edu.cn>, Marek Vasut
 <marex@nabladev.com>, Aristo Chen <jj251510319013@gmail.com>, "Wojciech
 Dubowik" <Wojciech.Dubowik@mt.com>,
 Moteen Shah <m-shah@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783421050; l=4075;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=49vouUKTWoErhtGZcWxLe4zw1J+xS4JCojRlE/GbZNg=;
 b=rqlnc2vrSMW6PYFbx3HRGolwPgeZpUtGxiTvCCKemFmqbXZOF3VzGC3Q8oe6kJzwcrCovRCjX
 8iNktlqR3X2AuNw6L0DzCPcJ2zu8QnqRhNL7LjUBQyOXThHVqI2iNsn
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 6624707d-38a4-4fc5-e1a4-08dedc14af4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|6133799003|56012099006|18002099003|17002099007|3023799007;
X-Microsoft-Antispam-Message-Info: okDtTFx492cboRxSgdYGW0mdmZiPtsi5TqW4xQxUjmoHE4gk1g0BZrupwq0bGrc4IlP3wgYD0pxAe3uAb2uoMNTTAeK65MuRIWML4e1tuNO0mOqfvjGPwp0SzV3Zq4JEXseW6Gl3JAxLhn0Md4ktkEePxpDMpG6km++6nu4XbJgQKedqvvx+tnKDF4sj8+Yt4pi31nl2cTiYPm+qTV9qFJkmvn1svH6TmMRcZcDtcf93spxbfqxpdtS33Edw/fQ15xzYXE+M5c/p6aHoOnzYePrKK/bP3zpsQlT5Bq79GR6otTuT5NFGKb4MqLEdY3n8Bbu/B8jrctVhJw8uAT4BPZNEh0KclJMwdsWYdHPEX/O6VAwdVWgocitc5pclkRtG5gonqsP8HnlQTgtxNnMHLyIoZXFi/Stf0uXpY2fKBoO7/IFPII00Ov10j0xOa0ne6SHtD5ByDf8Zwpf7o+nk2QPIs4ztA+JDdCiPV1jalZfTgK3roCzXxMxvxYXHhiKrsIatyBtObbCzwUdHCVyGBdunMjkJqyIbqgSg5FHLgEHTZ4/kww/7x6zxRih4/byAMkcbCuH6rafFlLJlH0nRWnyrFXKvQ4skMzMfgSDTaqYCpJ5yehEn2/K8128PydGObggZy0jjaEcuPb/6BgCdPRsMIYpukWBEjU4RUdj0/U1I46ENALFw5Dw/AorE/Yw0CvUqrKMSHPeBh1fYOgC25g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(18002099003)(17002099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OvokInzEg+4KKTzCDNOcXUGFIZNO4sHxkkzxCeUTbvbBIom48jTc28p0QVYTTXsJ6jJDHFeD2+w0w9xB3l0q4x+B7OyZKtYIXxPt2iWRS7kF8r1S/UTbCefQz1W3MGgrWY4eel1puikUgGeRb7+mVUGUK4b8bm3XB5cJ1O+umqNxB97+HlOzP+vzqi9SQ4a14tQTvAT0bqHmOMHWRdVlHXK677NIy20sAgl1Kz26+wUdbe9BZ6h7QVRAQu5dfr9WyIo4yoqd+Hl9VJzHS49SjL89dkPTjYdSQOyR7hdxvTDqiIbwy21KJvnSWSH8WnJD4yGsFIPsxrDaxjsVVYY9IMkaHDzqNmSfvodlnkNXrGkQ4IVmdXfsUUeROwmrIxo8iGs5eLN3bO1vF/DcVqbRYBWkyZJCf0T6w1sfpkI7+wVTHUGGkXQKVF+r8wH1KeEA
X-Exchange-RoutingPolicyChecked: Xwro3ezzsFcCrerVure1ErKeiP+b1YRQDzhAUXW9/P5Vr8dqjOpyFcAmS1BdwSWpqSlchbX2SCaSYZkPm4UUStNlqrYCfKvuDB/SSF+7eECz4DxVqCVufj3j46h2n+sVXFFEprOuK21EnavkSmGpxlxIup9zuvsiJbEFc3ZW6xGHTSCrGZMlmZF2mMCn9zPS7kcRIKtHPdbLa08vy9Pc1/Ldd1/NDwU7JxqymY3wxdxuGdmiUJxIXIMenEQN7df25/jedcrpjc2+qQHo5ohvxa79yI6YlomOPgnZskfApyq0UDik057vgzS682k6bThIq0bOB8Z281rkTlpxQhm2Jw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:44:13.0504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6624707d-38a4-4fc5-e1a4-08dedc14af4c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMyBTYWx0ZWRfX2FD5tJMHrgqL
 uppJVhFEwRbwpKhcFdkXihAipc9Z2bgeOOBBLR0Aw0fnyRh4vi64HGekxxlYmqK9i6hF6lE5FRC
 kcPQ5uAtLS3YfhlPepe8w+LDv+3Yt3w=
X-Proofpoint-GUID: H_WzPA1TzzT4n317I_lHAtTEAJVldAOq
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a4cd882 cx=c_pps
 a=JPzmcyOoIuAgIyAaop9pOg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=m0Qgy9-u149eyPlWhncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMyBTYWx0ZWRfX2QZAB0tzShTo
 4Ex59kIcjAbEjlsPTSZRhTKhANdYfJOTNaxfvPzcSn67+isdDLHKKVuiEb/v89E7n1TO/9tAUfe
 2nlPObJvQ1MLU9w/SJIPi+jNuMsAp8GkA+OiG3Er4ksqc+zP2vu/ZLoYIZwxOuXLfFIIZ62jtMd
 nNDEAwutfAoZAEyuFfYqeTwl5vT5+rl6fx73NSzg1UV/tqxekZZ8ZsAGaZ5A+eSF4DjSZskSvIT
 8lUU9Bkap71q9Id61vOSc1KdiiwIyNrKjXV9wf62QWMFh92cucmkeJCjG0NTzjw28YBgMDAat3S
 FytlDk1H/HlF22gR9fVpWXLBxy+I85UTOsJLnbt+TcY9IWPwnTzC2jT0yC+ppcuRUyrg6bDhinv
 egljLxs/u3HscvdBJbEa0D0vlMa6ARLPsScC+lyGDmCvLuXbX39QKXnSpLygGTKF9oJB17ooq++
 +21ZmXU04SKj684MaYA==
X-Proofpoint-ORIG-GUID: H_WzPA1TzzT4n317I_lHAtTEAJVldAOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070103
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

In the current setup the changes done to the dtb by binman such as
bootph propagation are only made to the intermediary *.dtb.out but not
the final dtb.

This means the final dtb that's in *-binman.dtsi never gets the required
changes applied. Therefore this patch fixes the behaviour by writing to
the supplied dtb before exiting with a modified test to catch any future
regressions.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 tools/binman/control.py |  3 +++
 tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 816f7c1eba26..a500e735f6ce 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         dtb_item.Sync(auto_resize=True)
         dtb_item.Pack()
         dtb_item.Flush()
+
+    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied to binman
+    tools.write_file(dtb_fname, dtb.GetContents())
     return images
 
 def CheckForProblems(image):
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac15..d02ab3a87a5f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8532,25 +8532,28 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that bootph-* properties are propagated correctly to supernodes"""
         _, _, _, out_dtb_fname = self._DoReadFileDtb(
                 'fdt/bootph_prop.dts', use_real_dtb=True, update_dtb=True)
-        dtb = fdt.Fdt(out_dtb_fname)
-        dtb.Scan()
-        root = dtb.GetRoot()
-        parent_node = root.FindNode('dummy-parent')
-        subnode1 = parent_node.FindNode('subnode-1')
-        subnode2 = subnode1.FindNode('subnode-2')
-        subnode3 = subnode1.FindNode('subnode-3')
-        subnode4 = subnode3.FindNode('subnode-4')
-
-        self.assertIn('bootph-some-ram', subnode1.props,
-                      "Child node is missing 'bootph-some-ram' property")
-        self.assertIn('bootph-all', subnode1.props,
-                      "Child node is missing 'bootph-all' property")
-        self.assertIn('bootph-some-ram', parent_node.props,
-                      "Parent node is missing 'bootph-some-ram' property")
-        self.assertIn('bootph-all', parent_node.props,
-                      "Parent node is missing 'bootph-all' property")
-        self.assertEqual(len(subnode4.props), 0,
-                        "subnode shouldn't have any properties")
+        def assert_eq(fname: str):
+            dtb = fdt.Fdt(fname)
+            dtb.Scan()
+            root = dtb.GetRoot()
+            parent_node = root.FindNode('dummy-parent')
+            subnode1 = parent_node.FindNode('subnode-1')
+            subnode2 = subnode1.FindNode('subnode-2')
+            subnode3 = subnode1.FindNode('subnode-3')
+            subnode4 = subnode3.FindNode('subnode-4')
+
+            self.assertIn('bootph-some-ram', subnode1.props,
+                          "Child node is missing 'bootph-some-ram' property")
+            self.assertIn('bootph-all', subnode1.props,
+                          "Child node is missing 'bootph-all' property")
+            self.assertIn('bootph-some-ram', parent_node.props,
+                          "Parent node is missing 'bootph-some-ram' property")
+            self.assertIn('bootph-all', parent_node.props,
+                          "Parent node is missing 'bootph-all' property")
+            self.assertEqual(len(subnode4.props), 0,
+                            "subnode shouldn't have any properties")
+        assert_eq(out_dtb_fname)
+        assert_eq(tools.get_output_filename('source.dtb'))
 
 if __name__ == "__main__":
     unittest.main()

---
base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
change-id: 20260707-binman_bootph_fix-16a618090934

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

