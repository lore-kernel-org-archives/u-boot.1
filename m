Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2E5C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF2384CE5;
	Tue, 14 Jul 2026 13:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qwtz8FSS";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KndaZ331";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB5D84CF1; Tue, 14 Jul 2026 13:05:28 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1FD84CD7
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E9IIQu1854363; Tue, 14 Jul 2026 06:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=vuFQAvG6LCbceIv/IwhIHjNgOY8xTjj3g/S/GXnmP
 yg=; b=qwtz8FSSiRWo8BofQA90Vox3B2y81WoTgfF6xyMPjYDbebi8YVWohIeJD
 +11ZvxFOK4ubAeuI1GQJ7NZRLwxSAZmLHYrMX2lYCyxhaLU9EVO9W2Jj/8L0XZZ4
 IqSnDKyTXylvuIvCPLiTEF8NCVipNoJf8OV4gUOjO6i0iidiykYoCP55jqd9O5wU
 vcyHETw9RdnqV7N6xNr1prQAjLRid/mnqV1RB7386w54e3azuEcZlYWuZjP7ZRyY
 Awf1qkOG/c/raF5ND/FbUyW1AnXdHzdpTgbNZnJplWQQzPdAPzN8CccL2NFyqNwC
 jIJYyrZ15NnsaYpF2sNyr8FXy8tHg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdjc3rdx2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 06:05:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPYZyGhDSWei4lH0j5d4h9fZbwZh68HJ7fyhXmY/RjCEic+VCgXSw5mCok8R20YGCZj05EgNtxNbZ9awEIZJghf+cHu7bOHQdlkmrpYD6du4ai1q+2D0gGUw3V+d9UNizCB4n347+8iQElt69HHUK9xBCkfK0rnnbjXt7bHURkxml8irokQX2NmyansbBcrvMfs0vjP0mLDcIwbgnkErFzy/mCacTWAeEPTni2XSnrH8ek8TKB3tNRDCpexdQ8ndyB5tVzTzluq7y71YM7Ipqvkt7O/6hFQmx26ItnurwINFa11OGhW7Ch33d0vsoneA1RxPxMPRjzt3HH8jlgMt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuFQAvG6LCbceIv/IwhIHjNgOY8xTjj3g/S/GXnmPyg=;
 b=ppOr5rE+Bh4446Fsv1CJ3D9xMSSxn467wnH6olyMuDm3AuDj5w5xzXP1BVDNizbWg6MC+tgdKCoJzGO4tvyOQHj4iVbssW1m+9zX9ir5i2ZDFgcEkUwX2mEFRuaLgHDEYvi2RMMdnbBXZX6vnU0XFRkL7e6mXdp6FP30v7LhLKw7U7teDfkdRaBQNRSGa7tSmbd7Nv6IXOnuZxcLAqiwB/OJWKDeC6Anxavm7g95PXAHMC5oQC9+C9QGD7QfFqff4X3ogfya+v6p7KvxA3hbgKjC+F79yc/YaYVTiG9BBU4nDM7C/ZkDqevErpVB0bErbYfHk0QGVAiMAaKgcHnhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuFQAvG6LCbceIv/IwhIHjNgOY8xTjj3g/S/GXnmPyg=;
 b=KndaZ33136i6Oxm12jKOBtfhWduRjvAoij21EQNrYbzzX9RsSkywGiO1AeLTf8VUszj18+9GIoT4GoJ78kh3gG8ic6jnsfoQ4g7jbdZgdxnRPFS4TwIjOjzLytUttLJtdjj1JGUhHNEu74WWAFa76qT6IMR32XXX6DKjVPQLe8Y=
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by SJ5PPF1D755039F.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::790) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 11:05:14 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::40) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 11:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 11:05:12 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:11 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 06:05:11 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66EB5AiI3983785;
 Tue, 14 Jul 2026 06:05:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/3] Enable Ethernet boot on SK-AM62A-LP
From: Anshul Dalal <anshuld@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260710102229.2980029-1-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
Date: Tue, 14 Jul 2026 16:35:08 +0530
Message-ID: <178402710824.246195.16306871650899600493.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784027109; l=821;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=U/cRxgweiupw6Rxe8OoJoz3QpabKzHSMt6IASkgK9OE=;
 b=DJlvGvjuRRVa3hlDS6Kugawn9BAnts6Uvm+wCq5SznlhYUgXSS+NhZLtqr11KmXlSz3+ghTbw
 FUlJNvQpLbiCK/gwoYCqQVL0NunjBSJ5YigDII2EO3eEgPEU+4oHbZa
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ5PPF1D755039F:EE_
X-MS-Office365-Filtering-Correlation-Id: d07cd36c-28cd-4f1a-f725-08dee197c6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: bznHkdkUJ+WqNa1ZyGeGln4xjVBAH+XNevWWCVKLMQMlMEjbUB/Pb8odFkoDucX0OnbE22rGy6KRiPoGwHbaFSTVXHLTt7iM3UnDpPifWdeVm82Jf/sj1gQsG1Ae989zCgMsZAZIt5bmgtF9FYzsMK2gg1edKKCHn+q701blZ54I5qjk/KVoPC4qFuVR2suxMcUW+UVrCU/lKrwVDoF8iawbmikGAgV6QuJOp0xQgbVveMTaiSjL7WVnYp1Uhc7cJ+0NWWEHgAdFkEUn60OYxDuBZJ+mXeyl/hBZJiDUAElKOUyJabvA3xLUVZ+txwFr+iDdOUjUFyTBvvBmtqFuydczZ021iSk5pczqKgxOMexjVPkSEBev/qzFIzE7JXfZ0JnJb7swczA8yk2YPfio8rSQjhL2VjQrTW6lF9QOpr+dPu8zhquF9SjTs8gc9dyxFqmnjnUUJG4ftjnyF50fw7EDfRt/0ffCBHwer810oBH8zO8BLtnNdtE2ZiFXwl/JgKUvpSo9qGuINq/EmUvlgIwohr5EkpPs+Y8LcV/a01/TjwzeQFZAv24j1f18BrYOlyS9NbX+bQhzJQwILZYdpYYd1GuJTSyaLF+Jl9a+roVFtyL8U/FHxorxTNsAGm0wEZr2F/tViJaXGWOBoE476gOyOndjxRDerAhiuaQs4gAolFP1YAeoEz4Ri2c+29KDt6eC/kuS04vYtdHhP6T35w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zzthWM/utF1MoODbpgkCO/YfmPAOre8k+OV8Z3BnCey962k/eyuH7hcKydE28rWiXHnD8JAqsnc0drplBQ/i33SSI46C87jZieNjkVMauBY9SBKTLGOIYGLTwLhM9SqIMK4TwYw7hGXXWDh7sQ4JrwdFJvUbqH7GGmI2Fg4WDqlf04yzuwOzJLbDI8WokbikBG1Ehu1NeOdvsn/wvX0cAMS35y3YANWhTIvkiV3SfwFIoYxYIMi1vnHxRfVmkBD2HMS9Qfk9RqHTGa1UGSZptFFSu70A1dDL8tyfYCF670BFSX5h5pDY6U9HqaJTs2UAnbRFUjB1zMUu9ueD/nxJ9JpkU18p9fLOomu3SmJO76I2Nrf8DqszX/v+TKmshGu396acO5ngIo6ucdVtQzCnqBQvAu563oN3XiR+xRPm3VyEnwUyxIcSUJRxOWhcO0b6
X-Exchange-RoutingPolicyChecked: jjKdbAorBK+Kep8wVN+K5sFP3q537zjOqfwFHFR2KFnVS5s3GJGB4veVfge3odiabQl2JrEPTX5FWhKHsOlhy79Nz8RxqdAd6m++XjIWyhcsfHrnbOiR7HC/PONhU4vX3Dmiv4VUmV+WSisXJxISvhAsqsExZMsSlGrypPbrJp25tPQ6KVas9slv4O5/wSLNdLGwf2zfC+aMmIChsFNXx1NH2tmSkwy5d7imdpwCXTuXpwaXAOAs2HFenOpTjbySX0jZGCFo0lLAE8w4lC+yIw0KyZvHZLpUv6MSYGdcrXCp4OkP9jGHOg9P6So5yvVweWFNZkB4hjoU+Y70JSsaQw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:05:12.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07cd36c-28cd-4f1a-f725-08dee197c6d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1D755039F
X-Proofpoint-GUID: 24FzbgbbQF6hldnCq8hL61l7SoLu7dRU
X-Proofpoint-ORIG-GUID: 24FzbgbbQF6hldnCq8hL61l7SoLu7dRU
X-Authority-Analysis: v=2.4 cv=L5UtheT8 c=1 sm=1 tr=0 ts=6a5617f0 cx=c_pps
 a=a15oepxCFtbapkdjUscCyA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=Su-vaLTe98WYrtYN0fkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX9PYrLijUxxUE
 hfvpYpRM8tYKdTLvOKBB6qhoB3n5Zq1x82Ug9HUJVMO15pK5mEQomeADNUviOVJ+Y+oEkWqX0iv
 ODfj8wIuyUz7LV1SmQxrUPu6vckfh1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfXzg+uFc8Z68Xm
 euTurjAj9ToNmwTQ0Q2CkEiF1oLjg38mYkG+jHlITPc/V7E1AUbWRsNxs/T06TqIAEGDM3BChM/
 hHwYegjwYHBdFgRZq4y4HYYtq1IUPi52a7eAVteOJUXfITmSndaezBfinTqi3Ie5XLuSsr/8kld
 uTHMGNRDyq2Zq+pFkOZWKciEPX6+ftA/a/QO/B4KxaQirSXxmH5KrKs1/Hal37e4bTY0wd5vreQ
 F7fBcm4H2+j/Jg4m/VyuIEb5ylZlaWtmIW53W1SAe5r41MBgFa5M7b+lWt/uKIxN8tcISj24icY
 Cg8+uQhU0GkgNTQNKv/oUHPzezq4Z41O1Jgd/fMzPXZdH43QtxXt9aeWpeLe35jBXCauJ+GbU9l
 OskN0QeDKcJuO4dmUxDDIibbAMvUQuKI8K2G80WfZxzUVpdN6MQFxN6gjDs2cDaAA9622otlTni
 qpKqIla9JR5ePIFO6iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140115
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

On Fri, 10 Jul 2026 15:52:26 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
> This series enables Ethernet boot on SK-AM62A-LP. The series is based on
> commit 'a18265f1ccb7' of origin/next branch of U-Boot repo.
> 
> Link to v1:
> https://lore.kernel.org/all/20260702081251.2691159-1-c-vankar@ti.com/
> 
> Logs:
> https://gist.github.com/chintan013/db875ef8b703094af70ca681659ba7f0
> 
> Changes from v1 to v2:
> -> Removed the duplicate config options from r5 and a53 defconfig.
> -> Updated commit message for [PATCH 1/3].

Tested on AM62A EVM with the below patch applied:
https://lore.kernel.org/all/20260625113223.1711052-1-c-vankar@ti.com/

Logs:
https://gist.github.com/ArchUsr64/3265edca99084022a128bb51cd142cb5

Tested-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
