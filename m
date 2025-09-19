Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7482DCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B930483510;
	Fri, 19 Sep 2025 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="URin8myo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA43C832DA; Fri, 19 Sep 2025 12:10:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1D983335
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzsl0wOaGe3h/ZkQoTGxVe/FdvsMY+pdkrxLCL9LE5xSBVPCzCIvlFFwgnKKUqJvOQouCRE+GsAkhRH8khGSoNft/DSBU+Sbma1jnJjzXhdp5/xO10NZ3zBFRJSixCBYjKDAc3jd2ZsZSuhkrk7UJwy4i9Jj/Qkil4QVref6txPQ7SPB86lN66D75qFItrmoJkNm8m7P87zjXNOntJmviEa6Ub2lZ3XlrVec/AkTdL4kIbKFIfczuLr1xgZ+RPb4kXPwzSMlBUHMZUtb1Nx0NIzrN+JZQmk67CEr4M1tNEYi/saPnIMakPP9Jf+6iGH3MjnaKnlIeKXHO6TaPqp9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdg2cbqy4yP+Jm+goy/9LYlFwTiuV72yHwrBWqcBTnI=;
 b=U1hoauboYuMIaxSomAREmNv7jmcq2JWKqCBHqsOLNBQmEHiPWlgjzASHSuJzfaWBfeZ3aIEIVMfgGoQJzDSrtObMhpq68q6BqO6sfj37BT6J5sw9scrGXSNpuJB9QK4DwibDaXCIGWpJRu6MKe7am6DFQKcUsqT7sc3QIWGxxA3nYowBlG8IjpqvsnbJRowkvPnNLKN/kyJZ1Um3WbwNjTNf75Kv8pE0kVzInGOX3YyU6VMlkgyJ7QZn4hL5fqq9cL4u45CRb6ScyHmU9RtrmFoMmYbHZBS8oSqP6PV8XfOMLOMDaPprKjijEUuOOcP1VQlrp360HZ1//qgJz97xAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdg2cbqy4yP+Jm+goy/9LYlFwTiuV72yHwrBWqcBTnI=;
 b=URin8myo19TlOdwCHMmn6YQdeGGD2A18EEipMw8OraoAaP4jPZg5OOF9D/GFxRmOoqB+qVXqfVI/VSQSEHJVw/SMeFPEbq1Gw1pVIrHA1NwfR/nEkIeoNPcGLmEbPOI4sU+x3n28DNnEIUOONPxlp8Or9cBnA0c6vXtw6hBeEYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 6/9] exports.h: make sure declarations are in sync with the
 actual exports
Date: Fri, 19 Sep 2025 12:09:59 +0200
Message-ID: <20250919101002.568488-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc3ee52-67d1-4080-da5f-08ddf764b9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?psdcbnJOmFw2WZgu1lkTUULoLQXsoCLrW7QYd8ZhM3SsJd3JvI9eRtWACPYH?=
 =?us-ascii?Q?cGDOfOH+4Euqw+qSLeZ4dkj6GYVIjVG97POlh8dv0MekbDEjZtBVVw5McpKm?=
 =?us-ascii?Q?gVjmc2qknz01Um04znaD5+hh1GMHqmgaqbz2qvjlGHBQ67lT3/4+CqwF5aLd?=
 =?us-ascii?Q?C7C7kp1PeXAivUvGf0jIJ/OWEa9c8R4UfRiy1vIyt2eRM7GqByxG07djXu4j?=
 =?us-ascii?Q?s0jZsU0dyY27sSK6YfqE3DPLQDHdZhs9bH7Us6d3m3yM38+XtKX4dOgR/RWZ?=
 =?us-ascii?Q?3qLn3f6o1NdwESHBJsmC0Mgh+foyYUV1pU090EHghAyZDRYIeE5SG1ECoLG8?=
 =?us-ascii?Q?cM4kMjVUkBpVQt6WOjg6OIMEX/Qhah84WY8VdK5Q8/75ZsYiP17xGok7TkPy?=
 =?us-ascii?Q?ZHLiuBELLFtNBWq8ywBqll25rhBTQzIZ9iX1X1rwJdhb1J3XxFcW1k2aVM2G?=
 =?us-ascii?Q?O4/i8pHh7Eqe9kRmyXL3AZczRj4DCVxPoMLauU6VGbHAM7Y9b02Q4sM4yBFo?=
 =?us-ascii?Q?bjSEu4BhCIYsl7YRKdlALvFxcFoaqrGGYbmHp9p0OuaXfS0Iwz3vhhw+e+iH?=
 =?us-ascii?Q?WWxUMu65Jz0OV7rnAtVyE+KY/2dpbI7/JwgY3+MYYx6CK84zcBt2zAvbD4F0?=
 =?us-ascii?Q?xb6mUY4Neb7pT+jRbPsWFF1ttcQNa9Q9LGh1PzxqOCT6BeSzJ67kLr+eZtkL?=
 =?us-ascii?Q?ft176+GfhQW/NgozaNh+3g3KYF44SjZa7zsFvUpcPyIus9EbdQLNSOnj/yC8?=
 =?us-ascii?Q?Mm00kxmHiaFxO96nfN4DowxkWk+uM6dD13mDQb26n7zaze83kkTsmXl4XSpv?=
 =?us-ascii?Q?P38L61rZVwsBP5jU+nGDhtmUnV1he2JHQeidqxFXJqzaAuwDxZ7xBfMGunL0?=
 =?us-ascii?Q?GOqelRTN6nCOT6nGmU4ppYG6vKZirGizLXXCuMnijz/oo98AzxoA3biR+YEc?=
 =?us-ascii?Q?LTep8hS0b6GtxjoJVc5B2OT38m41awqn5RzW5Rjp3GcBrgaVKUCll9WkzmW/?=
 =?us-ascii?Q?QdUR4zugCi6ariB4S8BpSAPY5HrRHghh3VIqlYyiK4HYnbCjw88Q5VLODx5y?=
 =?us-ascii?Q?ISahay578DAebfMOswSUgcNmPfcKMRbAnfhcJ6L371/9mqFrSFbCjsLIVbGU?=
 =?us-ascii?Q?ydIAoMsDSt7FiN/n98BJstHgghTNiDHvtPG/9b1eGW5ha4Mj4iAMu9abMTvW?=
 =?us-ascii?Q?Hn/acqAXccdzCIixD7A5kl55wGxoR46WzcnrSTQ+QtkX9g981gG82kQCR9FR?=
 =?us-ascii?Q?LO61rHfwcdPqNhTvW4XWrm/SN/sc9S7kVHKGFB7pCZJLL+S2BHB/9sL28ytZ?=
 =?us-ascii?Q?O8vAPyOhNr8m+w2KSkY1iFgWEnwANrrsS0qm3PCI2gSSJpkKV95cjSzQ8GmS?=
 =?us-ascii?Q?y9VVwFX7pZTDARFyJdVTP6nPYeBqZ9+Gev1B2vWtneD7LM+Tjg8Bt8ujzBUp?=
 =?us-ascii?Q?PxxzF3zLFDRKzC/mj9/mxoWgcsODml+wfq+oH1W5V9k2BHPMh8W4vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wUg318DIuE0vnB43Uq+Fs3ZRPzFplTKs8gUNSpEdlurJ7qd7kJC4sQiBbu8N?=
 =?us-ascii?Q?26nePSvHpo1Njst/I+RefD2s3jLaaQULj0IoVWtYYWIzIWOkWruXBUl5D2JT?=
 =?us-ascii?Q?6SoRsNdhzSV4NtCcjoAQcaidZMKHt/on/GmpAtZG4i6fAp1fyPfyw/yweWBw?=
 =?us-ascii?Q?RRxrOfs4z57cyzAqluu7lIEUyOQM8iDjyX9BKFz93VqTEeXy9fyGpNzzkpkU?=
 =?us-ascii?Q?6CWHqefwHADnMyy0LhcFlHdV8PXazk7Y87L3ZelDKfAmYHGvnsIiMj82wEhi?=
 =?us-ascii?Q?jeCU96SbHSY70XmAaA67IhFepHYAMmJCq55bTdbJhBFsZt4qTBS0SxbPtvWt?=
 =?us-ascii?Q?5Uo6lLIaYfcbHJ7mw7h68C4OmTg76wsr9TLFM8o3Joj/TPeyGVZkk9secafX?=
 =?us-ascii?Q?prGpYfibVTQ3RBC4OFM79lXT78JItF20S08RlNmqwfSBDb6Qyq2rMR8rCm44?=
 =?us-ascii?Q?Neb72nigrgOHuRY2NZktI8v/fKyp3U1KkS9QJTWBSp6RGBAXkNWKhwGKc9Ht?=
 =?us-ascii?Q?I/V38zg/9TmgSLCdaIm3+VAxyXj2oeVgfJzIuGr8T23Zw/XwDpf3rHN2YLC7?=
 =?us-ascii?Q?+pSl0ZPP94SLt6U2RIk41IPMZ94OgwIW4oea/kpeNlXubBq8ZqOqVYjxXSAO?=
 =?us-ascii?Q?ZmGc13Qg86zQGXS6PwAw6GLcnV8mlsKFZLN9NxCAvbUarYmrHFPMzX3mGIQB?=
 =?us-ascii?Q?2fN4m6gB/K7f2wvUCeuwZI2LqIcT+aWVB8tqXwnZLOVNy1FdNl8ovy4pfG0W?=
 =?us-ascii?Q?Fia4zG4lUNrMdxSsYYi+VL+ErUdgxwhIdww38su2Wq4cTS3wOSKtsE5BfGRm?=
 =?us-ascii?Q?6FCk+oblDEjp1i2s14u/WTUWkfMXM93ieyRQu+ldibPrufwjsQSQVNGx4pvW?=
 =?us-ascii?Q?wpwyLAAqsNhMVO5bPeOvT2FROrk8NW0SpqunQiuLCTyoW7gg1KFKMqsFuQ+G?=
 =?us-ascii?Q?PrUpYO8c0cLOu1jfCF11Kd/efQ/WW3NVbqhgkl2A8fiwiknG3/2lvxQRuj7C?=
 =?us-ascii?Q?itnPWCxxZVsc0XdGYNt+E905AcVcypnLbP9Jpo/qtO/wMTY7MsqB6uOcWy/+?=
 =?us-ascii?Q?wfbnA0KNAod/vdRLwbDiAyOU4Gn1Uwe45IUVhpjdRbvd7Yei/Uj1c3cFV5Kn?=
 =?us-ascii?Q?n71xT5kfIfFniTWTb2HppnIM23e3PZkG++CvVtGhtAGfGRL/7ZiUiYeTqi+M?=
 =?us-ascii?Q?SLEFolObIWeyUegawrFRm3wTkQF0BcZfeRvRiRa08/fviunCsou1jiaWbeM8?=
 =?us-ascii?Q?m12xguELiPju/K/Xta0nCPwgH9RtUhs+wbg48wX1pIn+Dt6MjoEMiiAwuUUt?=
 =?us-ascii?Q?6lco1wx9z5Kt+s6Ovf+kX8FX6XQxiQqqn9liZzMYzDZ9f9Wz9uMTAiLE7yen?=
 =?us-ascii?Q?jNiuUiSZ/yKVOdIcirL4ZK0OlMfv/f9sGXYZsBAtk+J0udbeaeOIcAV9GpmU?=
 =?us-ascii?Q?5CJvuRWxsIopcs/uucUgVobTFOZo8h4geuLrnYHLoC5Ky2t7Gqbp0bXCxuqg?=
 =?us-ascii?Q?r0d3dBg7pf4Fh25wVGRGXsFQE0qrDEZyzMVMaSIi5HlhKXJBzA4NPqNGiy8j?=
 =?us-ascii?Q?7fRwUwJeTWC0n2+jE2E1jCBmDkgSwJD/u1nfld6+utDlqjSikyA33cBUVdsU?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc3ee52-67d1-4080-da5f-08ddf764b9e5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:14.5831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57wUKXaf1kR2+nlDBThdTM6FEk+11gf/H50shyHLw0OHclAV8r6d0DHcCHKkjcGmNVqoECuLhd+EHdtPvbIkclPFbRTwG0qIQ63dCUgranE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

After finishing a later patch in this series, I discovered I had
neglected to update the list of declarations in exports.h to
match. But then I realized I wasn't the first to do that.

Use the existing mechanism and DRY it out.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/exports.h | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/include/exports.h b/include/exports.h
index 23cc3a66c20..bcf170dca87 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -26,39 +26,9 @@ struct spi_slave;
 int jumptable_init(void);
 
 /* These are declarations of exported functions available in C code */
-unsigned long get_version(void);
-int  getc(void);
-int  tstc(void);
-void putc(const char);
-void puts(const char*);
-int printf(const char* fmt, ...);
-void install_hdlr(int, interrupt_handler_t, void*);
-void free_hdlr(int);
-void *malloc(size_t);
-#if !CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
-void free(void*);
-#endif
-void __udelay(unsigned long);
-unsigned long get_timer(unsigned long);
-int vprintf(const char *, va_list);
-unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
-int strict_strtoul(const char *cp, unsigned int base, unsigned long *res);
-char *env_get(const char *name);
-int env_set(const char *varname, const char *value);
-long simple_strtol(const char *cp, char **endp, unsigned int base);
-int strcmp(const char *cs, const char *ct);
-unsigned long ustrtoul(const char *cp, char **endp, unsigned int base);
-unsigned long long ustrtoull(const char *cp, char **endp, unsigned int base);
-#if defined(CONFIG_CMD_I2C) && !CONFIG_IS_ENABLED(DM_I2C)
-int i2c_write (uchar, uint, int , uchar* , int);
-int i2c_read (uchar, uint, int , uchar* , int);
-#endif
-#ifdef CONFIG_PHY_AQUANTIA
-struct mii_dev *mdio_get_current_dev(void);
-struct phy_device *phy_find_by_mask(struct mii_dev *bus, unsigned phy_mask);
-struct phy_device *mdio_phydev_for_ethname(const char *ethname);
-int miiphy_set_current_dev(const char *devname);
-#endif
+#define EXPORT_FUNC(impl, res, func, ...) res func(__VA_ARGS__);
+#include <_exports.h>
+#undef EXPORT_FUNC
 
 void app_startup(char * const *);
 
-- 
2.51.0

