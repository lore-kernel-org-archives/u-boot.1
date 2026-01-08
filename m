Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D3BD185C6
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 11:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F4232840CC;
	Thu,  8 Jan 2026 12:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qLkjFK7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAF784121; Thu,  8 Jan 2026 12:40:13 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19FB83B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nICGHEPbtS0V0CbN177NVxQInYyjZRoKdyRRsyNTQLgTlEB/J3zpb8Qh5O0ng/nPwQcx0QZwDn+DST9pLhyXJC340NklVDXKBrzB4Ws3LvYhKPIxjYTi97DgrOaBTEJeAhNUMi1PKSGABxr24PFt9wORHfAY/oT7eSx5UxphOAeSD3DInqfqANW+rejKO7y/eB64yAQzCSJtmW2IjKFN+v0mhRbM7KF6MSb1I6UZWxQ8tUMv32U64ZzGta0AixorYFYhL5eZcwJgoiuM1XTaETqMxZ8iZjF1yQ+6oDZsEF5qfoNk/i4lKyXCpmxpWdT+snL+xr5sjJnM7iCWzzzW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzZ6JsqSMdzsvrTIr2vxmk1BncWBtH7IK3dYKvHuDzE=;
 b=sl/+8q5kQSX6UfJlsrsi7xIgHqC+DiVb62VuS3Aq57viz7C9x5HK8J6nlYhkYBA0W7stj9Ku5G2X5Ibx968VWtbZlaiXiWq/mPXe11V4zjjlYEhU7hJ5CQLrDgURbJ60vZetCfqA6jDDXcatYi8LG8yjdf2xkHbsE0Cdqj4H5SbEY8dazje6WpuoLnspIneNbLUzG+53IQucrw2v8qyC46ARnNtg0jOQenxHFw4gv7FEXgZoDmC59c8/cJD0gemnaUdzN1PFFt1ado00OpVhRNd/7T9xSTcWKb9uvPsmw2xDjIIFP3JuxGLFqXGd/yvDMhtnc35M40HRed6qFLHyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzZ6JsqSMdzsvrTIr2vxmk1BncWBtH7IK3dYKvHuDzE=;
 b=qLkjFK7kRM0uXWErV40vj+lA9EwHmPiodEGuc7lq4coZeN8gJwfrsEOzxe5KPmaLZWhPP+VqX95td12v9PBmV1Pdbn9FvTxLg0dAzMsgW5W6fNXvgEhG0ETGw5cpSRyyEvqEqlHzomLta1T43sGlq0Lfwvb6oKpLO9MVX/E7OrEJvhDy3qRkvjcmCtgB/9aJIe+26t1pe9sbrpU1nBPUDT0kwOpkS/CcCvOjsxpJgFwQ+Pk7eCOADIoqX7xD5UIAnbf4y2eJmrliX5yVLT8Lcf2no2oZm+UXdG1bu13gZKRCu2JgJ7zdgQfGY5q1XahXzs9zJKGgR16bEjnJwmY3jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by LV3PR03MB7729.namprd03.prod.outlook.com (2603:10b6:408:287::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 11:40:08 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::6b00:aa6:cd64:2526%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:40:08 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 festevam@gmail.com, ivitro@gmail.com, max.merchel@ew.tq-group.com
Subject: [PATCH v1] Revert "mmc: mmc-uclass: Use max-frequency from device
 tree with default handling"
Date: Thu,  8 Jan 2026 03:40:02 -0800
Message-Id: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|LV3PR03MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: b59e17fd-d164-422a-f738-08de4eaaac83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?57GS4eniywEjEwSDONvxOifAMZLh2Mbnx1UwN60cq9xPCUR8muOs9D3JHLeS?=
 =?us-ascii?Q?2+cqxT6WVAvY9cDAGXrfv8NymI/M8wYNqzz3wAy21Dl8JObq1um2Z55mU1hK?=
 =?us-ascii?Q?AGejQp/g0jMCerZNC/ZBu5PulD4oAk0B5nLv646hy8k8eNxyyzRTkb8+rBg+?=
 =?us-ascii?Q?lFjgQlP8yuW9b8xKlMvOizIolkbuh0QqrgpKKqrhU8E/xOnWNkB9sYI+FIUH?=
 =?us-ascii?Q?MRGRXE0F3xcLv3E55zCcGUAUuhOiEi0x97TdXvcMIWRECbr+mGhrbD7Dbxyc?=
 =?us-ascii?Q?nJal1ep6inET8Y8nKnlzRQTuyGH5X4I4U+f979jHNMc3vrlUDrnxSoKlhN4l?=
 =?us-ascii?Q?4MFm1mqN+bDhA09+zqJC0/StPSi/VLGrfFNH0vXr4vFWB8KmwGqArL5u/vPT?=
 =?us-ascii?Q?LK1rzHCuaIEJH3jZLNe/HR17GVWcfNUadQSgtp2TMt8yThxgzfB2f6FSlQ6q?=
 =?us-ascii?Q?Elj9VHGkqGzYXMyDGS2gj8P0gvTU4snWTEicSraKYg28scOCoCWTVYKVHIFv?=
 =?us-ascii?Q?gsQT8RSDV71acmihkK/TdyPislHj1LiO4DvwcNEX2jcY0DrNgGhzw3qvcBYg?=
 =?us-ascii?Q?yxRstnr2ZtfGTPv4B6UbRZ6CX3S+bwsii7Gq5v/VqHASzLGCGuwF6uO9VQMb?=
 =?us-ascii?Q?8HopzAxhpMLjmOGoPmDfXEO6XgG0gAoKVFlP1igdoJ6jr3hrTLo8Dyfx/MGm?=
 =?us-ascii?Q?5xWxxbHuUlBrKwckduCDwkqgdJa6OPaDP1rrQty5xdeUGN5GkA1d/4yREGEz?=
 =?us-ascii?Q?olxeM6SAlLTtujFGPCRlhyFhA8XvHdwjdfBZG/aN4x4wSPPrhjdcY8+2vtJ1?=
 =?us-ascii?Q?J/DKGJPz282hFHPC1pZq4VIbdk4hqjPpE+1crI/FY9RilsFye0KMhieGKuDY?=
 =?us-ascii?Q?EzYJjlYVUwMUfS2dCWb0iK2QQH9VSQSyOUtKO/Isaomqm/le9FIymk7VsJh5?=
 =?us-ascii?Q?nQuVTOvrazXGXaMDJOiQFSSKmEHwjPvtA4D0v5putgwTqDeMQaLKp+2Pf0CK?=
 =?us-ascii?Q?S5Qdw/loxu3rKFqBHMN+shBLGqhrOwPqdcdSFdmT1oUYSdj8L/Mxv1JHeMFX?=
 =?us-ascii?Q?sBJI6f6sseUNF8nMO1/aBtzAJeQMg8SaGxYYoB2+0wrH8dkCPbWkqCZ0lOVP?=
 =?us-ascii?Q?D6jbdbU+13B/Xgrtw6D68cwlSRauTZhyBESjr6NCE+tddL3iEh3XkO3k0Nxd?=
 =?us-ascii?Q?sbVyKBgzm3Dtvli6L1dksyvJ8FwDCqMf8yHAFlcQJ2uComkwDjApsUGXjRZD?=
 =?us-ascii?Q?ahbqhDGgqWcw02cahYUyIkGqWzm/cY0OcmZcKlRhnghjfB/HlT3p9RI6or5A?=
 =?us-ascii?Q?uDJKv/9AVmCT62RKr4xGKya4HVscEFgdxXuxi5BBaktvYumpSCTlQgevcfsh?=
 =?us-ascii?Q?VaG2XCf0N0OcNTtrR/KWfzsI8fFoeCiw/LadOkbh4oKXzmSIiQhG3vTQN62A?=
 =?us-ascii?Q?JHd95fJR3walrCruXxjZPa+LOJWbvKa2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72Sg+gVHxVy9mNOl3wS0CXnYl7vR2TOMCOoahtq67db9Ihqr0HIL0DlQQXH/?=
 =?us-ascii?Q?y6IILfL4vRzY406cis3hFsoJZOIUo9AkLmH1tQ1+VbI2GW1nLj/7ou5ENXKv?=
 =?us-ascii?Q?Efzww0s24V+EeYrP1oI8oIYnr7r75L+8oK5+cbAeov3OYSO9hx0MZ/6nf/uV?=
 =?us-ascii?Q?DugW/RITOHeIdK3rEFZp1ZEQeh8kVuedxWkfU2EnDthjYdpdK1OhYfoos2z3?=
 =?us-ascii?Q?ZTpxQR2oyh9hSbHkMrVzqpTD292sq9Lcja07dVM/vCYFVxQ1BF1iIe878B2H?=
 =?us-ascii?Q?/n4034L+T+WOLolMpJkL0ZWcc+PBoHBJ/Rwm6OwbxgVEk8GCNK30LPTSo8K/?=
 =?us-ascii?Q?CbxaPAFWLVZpNnZ2dNJHh96UaaL6qrKLi+rAlWiXAY1Vn3jCqhBXXxkQAVse?=
 =?us-ascii?Q?IDbGWsscBP8WHK6Js+gT7HMQZZ2kOoJZzxI3j1pOSrqMZ3hdkPeoZoRuYtsD?=
 =?us-ascii?Q?rQEMZ4NAAazDsOchJkAbLgGJ1TpGKywkwItXocXuGi1XZ60bgn0RAX6MTEQA?=
 =?us-ascii?Q?Q9EBnjuyDPHyOhG3wlaMQ23qL6kQvWwWu0/V1nYzxcuY+SyqBi8P+8BysL9H?=
 =?us-ascii?Q?j/cDRhNKzsbBxF8Z71emLCUk5WRtUqSxI+iao37z7o/egmOCwBFn1HBB52a5?=
 =?us-ascii?Q?h7zSZd3Ap3Y5OimGzJg8HkGvZjQFZG5lfImC6X1i0XBe75ujN+u/X+BqGbFm?=
 =?us-ascii?Q?S/WmB0FWE0Biynmc7uuOJEUIHFGT/m8H/RSFLoFJdYQPFJgoyI2GQAhkNLm2?=
 =?us-ascii?Q?zVsZw5YQbP0bgyEf5jjyG6i2zn5lK1JPWPA6K0+TYPm5iEGBD5qiJdzCvINJ?=
 =?us-ascii?Q?YPRlbYBfM17U96ppRmr3InkBIMEmj1YEWMawgQB5geVVh5Mr6lnQdUmPgKGz?=
 =?us-ascii?Q?0dqfU5qGQF7NmFQNT7We2pTGu/F5CsG0qTRT6tkdq+wtGc6aRbd5anchgHdH?=
 =?us-ascii?Q?dATowqyf3V+iTlLxusSbUbBG+RvCqAuA4qJ2jq05AK0oSGeczr2NsKPjtQzl?=
 =?us-ascii?Q?zTMKQvrdpVZtS4lCO+MUO46CB7iboEIwbKoKd1YBAejt8hpN784oKSWgkPDj?=
 =?us-ascii?Q?oID7H22DudQ7qtWGUzBAfbU2SuWvlf4qRMT/HVH5hVfEvhfi7yVHVaUTWc8f?=
 =?us-ascii?Q?o0H/xTJfti6UQGlg0zwROuX2H5sqyOSw0ihQuTG42SWwwkNPR8l0A7xjLW5k?=
 =?us-ascii?Q?qAG74k3aDosg4TWFufScVKZs0euhpGyxJJhXLHMlDV7hHpHuL/Z05F3Xbgtn?=
 =?us-ascii?Q?E++b0I6RDzTPc/hWL588tIGIRWXz+YGrFCnhlkOmhgr5+NQhyaN5QbyL5a45?=
 =?us-ascii?Q?VsyQTPNBDv2sTcQOH11P2fhTopqune8Mm8gOJ2wumjfPVlSOGZvZ7g212PEP?=
 =?us-ascii?Q?kPI+b1hjnZOy1xwg872voAS0wJNZxeFoCerWbNhOqWBWeLTb3zmRNup5y2EQ?=
 =?us-ascii?Q?U9qcpike08fwMIc7ER8kSucPCuIlYozqhGOftB5YXROGK8fIjt341yrsx8yf?=
 =?us-ascii?Q?Z5nStiQcPDny+1+z06H8LHwdqMv06atGv7OKh71q1rxfBU7Ojz+VyRgga1Sj?=
 =?us-ascii?Q?eF1OiPaI7iiqCZEkTXrmszkLLFP1LM3CxSLZV3fb7UHsZcTc3sKc47H1/AVT?=
 =?us-ascii?Q?y7mq5k2HWOBAJ5X78MM5m/O5r4jgYP1RPA3nL+wiDFdMTHG3cYHlLnV99gCV?=
 =?us-ascii?Q?3yRlMfvXw1QQ7UJqHFEWLxQ1cCzNZcoGRTQi6ITU4kFcl+ftKgflEGv4Ok5X?=
 =?us-ascii?Q?Rr1Nz4ik7UvNmpbUsGcF9OOqA2Ao4v0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59e17fd-d164-422a-f738-08de4eaaac83
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:40:08.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAux+Iv8LurTekqLZFmqVUjOWin2kHUXowFIbqYOIj3llXs517lbu+lvccQlWXfy7BjdrJG5/SyKtoJ+Mqeuo1V39nKmRHjItJWoYMNofTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7729
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

This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.

The change to use dev_read_u32_default() with a default value of 0
causes regression for host controller drivers that hardcode f_max
before calling mmc_of_parse().

When the "max-frequency" property is not specified in the device tree,
dev_read_u32_default() returns 0, which overwrites the previously
configured f_max value set by the driver. This effectively resets
the maximum frequency to 0, breaking MMC functionality for those
controllers.

Revert to the original dev_read_u32() behavior which only updates
cfg->f_max when the "max-frequency" property is explicitly present
in the device tree, preserving driver-configured values otherwise.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc-uclass.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index bf0bea93853..2f4dc5bd887 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -243,13 +243,8 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
 		return -EINVAL;
 	}
 
-	/*
-	 * Maximum frequency is obtained from the optional "max-frequency" property.
-	 * If not specified in device tree, defaults to 0 and sdhci_setup_cfg()
-	 * will set the MMC configuration maximum frequency to the host controller's
-	 * maximum base clock frequency from capabilities register.
-	 */
-	cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
+	/* f_max is obtained from the optional "max-frequency" property */
+	dev_read_u32(dev, "max-frequency", &cfg->f_max);
 
 	if (dev_read_bool(dev, "cap-sd-highspeed"))
 		cfg->host_caps |= MMC_CAP(SD_HS);
-- 
2.19.0

