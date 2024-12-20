Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE65E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 09:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9768007D;
	Fri, 20 Dec 2024 10:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556A080087; Fri, 20 Dec 2024 10:09:49 +0100 (CET)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F6480079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 10:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=208481d893=meng.li@windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6wWqZ005155;
 Fri, 20 Dec 2024 09:09:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43h1096ydt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:09:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huGIMKpro0EXH5zg2++jd4tBvFu09d+OXL9Tkl67AhIqC9XvtZPEgqljZuxCYU1xvyl4v3COPlrh6afktFjYJ3q59RvITpUhQEWMWIbFmErpYQBQCcJxyHHwdQEWRPMMqftI/OFohDirG/5EuzsPVRxl8oQg3YvLEDGy6z+6GnNAueiNUu2hdUx6gH+Hrxv/TV5VzyrZqZf0avV4tO22Y5HwJJ1M2y8nIf3Jz7C7wTVJV2nEKqjSI+FtQbd+SGC6SM+2FlaArKOzcnSwvW9PjjJhYUozUkND3LoZiNy7HnHhztFGiaGDh0rsrovJDQtZBP1eZThISDcuYCUrHslAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9LcLLoR1smXE6Am5uuR2/kSyliV++GsW9o7GFZJhNk=;
 b=ZSTC3jhNdPLA3R8tkQ2xDGXDYLE49a+OqolKvguuyEWQg8aVvvQITdwe25GjT4tbXdblTjx+tLKAZluYXtB71Mf/pR0fTK0qMZto/Ay3Xm+MgNNS8rzpPUSSGwkd1Fi9o2s4KPMz2v2S212Au6jSMrFAtlzBLOhynOAHdJYpxXTlfM4j08Aw+XDmGGO7jlblJ/vm+lYpe9WU5Z3l/9NG9u/HCmJdvpKgDh/OPjhptUuZKykCdmUObhcESY5nW9OmNHTmsUHlnWp8BoxI9DCqOHid0nVPIy9bOCq/LmrPxPwmcoDJM32RM1u9Z1Mt76yLwAAJNFtS/VpsKnslkLQelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 09:09:38 +0000
Received: from CH3PR11MB8773.namprd11.prod.outlook.com
 ([fe80::c241:6bd2:b212:f4b2]) by CH3PR11MB8773.namprd11.prod.outlook.com
 ([fe80::c241:6bd2:b212:f4b2%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 09:09:37 +0000
From: Meng Li <Meng.Li@windriver.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 festevam@gmail.com
Cc: meng.li@windriver.com
Subject: [PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC network
 driver
Date: Fri, 20 Dec 2024 17:09:19 +0800
Message-Id: <20241220090919.2186070-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::14) To CH3PR11MB8773.namprd11.prod.outlook.com
 (2603:10b6:610:1cb::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8773:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f19a7f-4ec0-4d37-79cc-08dd20d6075c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D9gVQs1yqMfR4qVivpye9OdVbomDSyUutLNIXbOt4EVCR5hFWMzaqz9y6Fvp?=
 =?us-ascii?Q?PWZe/ZmuxMlT31xUTT12inUh+2jo7JVzE4U5B1KVIwGOS1qh5g6lTgU7QIIr?=
 =?us-ascii?Q?FYM6euQ9Db3Ml1e6b/tCwIajwdPBla6PCBJCzGbIdktnQfuzn9MnKLTCe3DG?=
 =?us-ascii?Q?XrChizcBY408j0gnZ9kgtnUQbTYydgYZqQ1b2G3ISvKVkNMAZ9VAD1ew4ig3?=
 =?us-ascii?Q?SoSCgOwr1QtAfM3iN1doJZ9CuVzWMFyXhzVieIeL3af07SWm9EylVr5TSTcJ?=
 =?us-ascii?Q?jmpxKOCvJ+tNo6VGDBBAv4dPyrs7z+U3WYREuYvAZsz0XgpGi5711Jsj94hG?=
 =?us-ascii?Q?tR6+EIyPfgXIttsfzzfu97gcEAk17ZDbJiUtpLvUH7eMwBuLX2W8Sfzs7IFJ?=
 =?us-ascii?Q?1nQSFQ+Nco17kPydmSuz2ILfP/aWARBoZtoIPd61HmhB7G20hVTUXxnmZu21?=
 =?us-ascii?Q?c2GLKal6pha+NAfqHrH+/OibVNB53buo7w9DLccJ5K0Q0v74SvotDnMtwmPa?=
 =?us-ascii?Q?mcC4s8Tfxwe/5t31c1BmgPiY2P7V8Dmz5rdGlF0N6I1YoFJZYn8S56qD5gl4?=
 =?us-ascii?Q?V+S6Xjvqvfk+l4R4CfhBgnAqyyOb5A64nVN+qtkEkk+zkgrbQJ6/EpBmbZSv?=
 =?us-ascii?Q?dkHn3OSS3kCSPrO6DZqD5AzneoyOuYKvgBJ+ytr+zsngRQb4KHIARY165FpX?=
 =?us-ascii?Q?y7kFjdh7k0PKNYHMhN0IIAH+ObfP4dqD9RK0MNX9qCFX42oR6k7BhQOu/SY4?=
 =?us-ascii?Q?Zuld/L8648PKPmH2waD+Oqg7TyN3fFzRi0kFaMTh/aGCKk5mlf3tdoTL19Pd?=
 =?us-ascii?Q?nDBwi15NCjslpGOTMVk7rSjqSFwdAC9NxB9KQDm9/o9vwNHTOh9oFv+vC3Q5?=
 =?us-ascii?Q?hEmhSMaf4HXV+eGHFY948C31cebAcUT2s9hbfg1OBXbn8S7mQPbxzDq3YeoA?=
 =?us-ascii?Q?ytNNsvmmlj+5w4IHa0FuLbZkz1bXgRmi3bhreV7811jl4dVDhxWfCE6GOoCX?=
 =?us-ascii?Q?uJVw/Q7E6CW+czrfvmSGNvdTAMuBQExK7P+IwYzFnvRYPk9SvCzmGfZ1BGsZ?=
 =?us-ascii?Q?u+pc4uwikv/3+Nxjf+Jpio3LqOTIXelga9NqJ0ercB5JCrMcM2KHiHxW9dbP?=
 =?us-ascii?Q?4GMqR9obodzYgi/9BexHoHbBTGvsPyUJScH0JZOlmAvEe9bODcNYJ/QWdWkD?=
 =?us-ascii?Q?DQLyIbhPf1PFTXD3N9MGpo7DieRCMcorwgtu1lZd1r+U4B6hunHZxXyRTkMI?=
 =?us-ascii?Q?/pdu5rwQ1ap8c9xNfNPEWKEk+KhAq/+0lj57LXqUzTJYYhUZpu54XubHXiDS?=
 =?us-ascii?Q?KhRZiBtYpbwBbFer8AejN2Sk1kQXbmZrRYXbP+dQRPti1yPkp/BMEJ8QpJlN?=
 =?us-ascii?Q?n+9j0qZBTZBTdurbSCJp5I+jzEs8ym4ShNA/XBnqVCX4GawzEJEh/7yA+Lv8?=
 =?us-ascii?Q?49Ds3/fl1/YqjgHgk6+LsdLXtIioVCsb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8773.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0VtNwB8rCH3IFMr7BQGYATpHzfX8fUkqaL+pm1jdB1nabs9K0qjHZy3pHFw?=
 =?us-ascii?Q?u05zpIs6fZ6FrqLMnF5VntBsICdR7Ksdg7njo3CVWiEJUuPTbApQx5usWjlk?=
 =?us-ascii?Q?/GL1+uYbaf/Cl3o2q0rQAvqi1bHFMpF9J41hbfuVMoAkRVaLpl/DFUB1/d0h?=
 =?us-ascii?Q?HwafVW3lg2D9UVmi3yb9CL8pPswgk/n+0t0v0O3PW0EaIJgIFllBhzWVRcHq?=
 =?us-ascii?Q?issOO2zRtOsLfXw7z00pi1GmwcQ6lnbrWXsUCKpeIAhJG4Z5dPt76O4RPJF0?=
 =?us-ascii?Q?9/bpTjj8i7uIFSUIt4xXoKEjY6lhoWOHlwa+6IJ9Do/JrQQN+wFybECsvcfl?=
 =?us-ascii?Q?L3Jur0mwjvT9WuLfYAQwZLo5uK4UJIqcz5nEiQiEv6nMAWlokfkRdk4wkJzl?=
 =?us-ascii?Q?tNNSXcPewf+ntOXN1g/oRLtDIvNr4sU00TjJ/NY4scX1SRaJuc9bSvDE5H0U?=
 =?us-ascii?Q?/HPiK+rR0ba0dtp8WQJGtAiTMncRkBeKNh50mbcjsMJRLJRXUGQp9nfaZWxI?=
 =?us-ascii?Q?HA+fKq0FGYrNNnOtANM9GnMn30EUWWiamggwQw5UW62/z6trlbfYN2zrlmg4?=
 =?us-ascii?Q?+fNUZhZbx+nd/62q3RsiNckWqzJlzP4DShLGuybZRYOCuQYJ1eqSaWJNTUJg?=
 =?us-ascii?Q?6msJl59yxtc8DvULriidEWhsMu4NKTX9akQdE9OvZqMRku5PCiCp3TKw1goU?=
 =?us-ascii?Q?OdJAAZ6LMNi7l0q7FEXlv6MInP/gNWRGGYNu7yPIklwhob9g6fz3tXTPxUxB?=
 =?us-ascii?Q?kMWZhXwKTd6WX+1qU2Sm4cpuqM3z7lxEZ2xf2GTLs0AO7lSzYlHYCfY9QfNS?=
 =?us-ascii?Q?J/LRYOsRvefzv8Vydq9tzC/F1wy9tdTsEz7LIZO0XMezS75eCED0i3PuAe38?=
 =?us-ascii?Q?JMzVW6f5nZaJqoeHioJgelsysBpX/yVWlKsM/aHxCjN8Om+bOZPp0arv/rcC?=
 =?us-ascii?Q?YP7Nkj4cOi7oUHhrcd23a1OhkBJAqB3XOl2XST2PPxdyI2hd0Dw2xFZJl41E?=
 =?us-ascii?Q?siEjbOaS9YWa8Jnsv+10lsz3tJkOfJKO4lh0O6UsTrpPKcF7Yir2kLtDMNsf?=
 =?us-ascii?Q?Hef0jUgyQdc45I5hwbC2NwP7apPrk2aYSzu9IUkEJqpyOYlPUIG+spcYbdUT?=
 =?us-ascii?Q?Saz85/0qbNlz/qsIg4Hh7fgrYTDGGnLtMmcTcrwHLoQpVaH/tEYn+xA3VcOz?=
 =?us-ascii?Q?YaKiMKrJPMuBWIbRzQemDaY9G/bAAc4ShvZjOdRnoblVunNjS9PB7SioffiP?=
 =?us-ascii?Q?HEZq6A7JNCNNRk/E4/1Vo8wajEJWpDDMt9ySI7BFX4/xVTFNmP+LTte4crUV?=
 =?us-ascii?Q?szacKpL+bKZViSPut+SKGj4S1xzYxpRFVcoIOog/khZr7iO+k6z4l2rc/h2B?=
 =?us-ascii?Q?A9AfOX2EUSGMEhofndIIlOWdsngwn1ErPYyzK34xhnL7uuKbFt5iQ35ePVU2?=
 =?us-ascii?Q?Kcznv4Cc8qZlVKvF11pUMnoe4S/s4XkWVevG2BTR20SPwUfVaHzduMZl6iHE?=
 =?us-ascii?Q?fEROaPK0Y/GXXXMpxhbFgQaXUSS66FhS66TGxBtsDPjiYIh8kNIFaVn67Gty?=
 =?us-ascii?Q?K9CIE2b2Y01D4nFcpfdCF7ADulXMit7125dvq5ag?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f19a7f-4ec0-4d37-79cc-08dd20d6075c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 09:09:37.8231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64RSnIistb2tyy/uZGrOrx0zTcs09umbvLuObGoMyHWKMkwWY0uKZxUc5N4ExFhtvD/2UEE+ixK2WG7c4yFQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-Authority-Analysis: v=2.4 cv=bp62BFai c=1 sm=1 tr=0 ts=67653456 cx=c_pps
 a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10
 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=Q-0qum7mTfOGCo0FPWQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: qHcNIzN5gCOPridpayWOaxLPu8fIC6fZ
X-Proofpoint-GUID: qHcNIzN5gCOPridpayWOaxLPu8fIC6fZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-20_03,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412200076
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

From: Meng Li <meng.li@windriver.com>

When FEC network card works as the prime one in u-boot, and is in
active status, kernel might crash during booting up stage, especially
working with grub. Because the DMA of FEC is still in active status, and
copy data into momey if there is network data received. In this case, if
kernel allocated a part of memory that has overlay with the memory
used by DMA, kernel memory may be destroyed and cause kernel crashes.
Because before kernel boots up really, u-boot dm_remove_devices_flags()
can call the remove callback of FEC driver with DM_FLAG_ACTIVE_DMA
flag. In fecmxc_remove(), phy power is disabled, so there is no data
received. In this way, it makes sure that there is no DMA action, so
that avoid kernel crashing occurs.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/net/fec_mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 70eccfa8a4..07aff12b53 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1484,4 +1484,5 @@ U_BOOT_DRIVER(fecmxc_gem) = {
 	.ops	= &fecmxc_ops,
 	.priv_auto	= sizeof(struct fec_priv),
 	.plat_auto	= sizeof(struct eth_pdata),
+	.flags = DM_FLAG_ACTIVE_DMA,
 };
-- 
2.39.2

