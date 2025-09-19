Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E5CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1DC832AD;
	Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Qg5wTplW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C15083071; Fri, 19 Sep 2025 12:10:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A82583071
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj80PCAMasAkunc22BGQCx30bsRwOb4fxBjt6aKadC3UAyc7/GR0mnBJ3La/5QsD0hAiBoHo10fBSQ+wH40DVc4p411LWD7RF23R4Oz9D8nYu7wvcr1rfnRos2QxxV4A0pEJkY6bS/QXvyH8hz+FXMw1UgXiqJKMOASVmMqxrXypfTTlU8iC3IL52st2oxz1WTfhCNcKSKIhzAlX+O4oCNqbCDljuLcngJmGprilR/gzIMyf98VH2xkqL5rGuTJAnaPFdpp4r2FsDmoscYwmLZLH0jx7Um9rFEoI+nuEfS9f4VZRt1wKdPbvIY1Er+ZDE96p/imfEonX3jBiTGDiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y23JdfKxeKDVQrpb3foRe1L9oM7W+8sA+USSeFqUCC4=;
 b=OxSvwcKLWZkQEdwzesiM9DqHUNL4UmTSWDzxnEfscgQ6ARoZbbUNEujevzqXFjmd+gu5+O7lgUo1yHXc4N+Fxf37/Obx6+Q/O4FOr0VZVwPT+mhxztgmq2lSzcEtKuiU2g68LxEvDndvLo1vMdz94TN/jKDH3enmL75qstMJYCO3AAj+VxRAmmqU+1GKIrOuHqau4JfZDbxyb7uXeJVXLplr/NaBCS7kAR8YgFwrAHEhKqTaqLZ4NvKes5CKlXy9BL41I9m5nNlu/3MdCtagSagFky8FhFVuiySDx7GhG+DGjKayiYs0VDtHElaz3DQ5nNenHMgKckGb+YhX2qvubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y23JdfKxeKDVQrpb3foRe1L9oM7W+8sA+USSeFqUCC4=;
 b=Qg5wTplWXUQEY8URLOS0YbzZw94DnzTD6YasCs903aJsAqsiMkFLcdmKkN9HFqw+qKPrPgsLL7ov5+44roI/IbVIAFE4K4t7TurbPB8DN5grK3bsgqVpSyWXQiTrtX6geVxJVM5onFdpQ9pSGs54KvCcehol2d3m1/JnCFY57I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB3PR10MB6833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:439::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 10:10:07 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/9] exports overhaul
Date: Fri, 19 Sep 2025 12:09:53 +0200
Message-ID: <20250919101002.568488-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ef2392-99c6-4b14-95b8-08ddf764b51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mFWTnjEaj5do9cJKpSHTmUBmwD0FIheOqhmh+3w3+1nAKl8fy07kmY0wahY?=
 =?us-ascii?Q?133/U2BpzHrvOlSgh+DBZiuRHM0M2LmyaDVDHB6eGg3/lRwhET54wou6wbt8?=
 =?us-ascii?Q?NY2hJplL9C+yFpyYMOS9Fv4vR9RLqH2sHsxzZ3r8OVTUo4dyI/dTRZqYBKke?=
 =?us-ascii?Q?KrvT6vVNrPHfW7TgBQZmIKRk4TeuYYri+xswF6iX1meySdV4xhI9bzH9fUCd?=
 =?us-ascii?Q?3omERo5EzEH8/V8I6lynR/29JSDEwNfQzspSVZWf2BsziD6TcrzD8fATME41?=
 =?us-ascii?Q?gCzLuC2hcM7r7Igx4Ce6q2hcP5LhgeetHPA8/Ke+hsB0t4dcTAcSD8/BBuoF?=
 =?us-ascii?Q?aEOBIkqsbTd6jTdV/O0/nmLj+PRKDekLVhBjQAm41GgJi5km/G1JMyLovQ9w?=
 =?us-ascii?Q?8as9AylFZ4ni+ao6NAzF6/dRyoQgUxMls7SVWVXuLWJ0wevgfutyVNNRS5xf?=
 =?us-ascii?Q?5gBMtH5Ic+9Q8k8TivmnZvct96TRKkvsMM/WCkRihibrpXTL67+G+LDUjz0y?=
 =?us-ascii?Q?cZhaM8+wXNCGaUm6ymvatkq4uV+vjrmHl+nz2K3lXW2DWZPlOBWKDCtnyKu+?=
 =?us-ascii?Q?CAwHAB4QdZHAJMBnStx1jJvhfBgyZi6Zu/mMdBM29/H5GCjxS20OI65+l5OM?=
 =?us-ascii?Q?ksx2DcKp4OhqkB5tCGYrPhnXPM7VlO/zB8Uu5iHz3/lQ9Gb17nbNJPZ3b8Xf?=
 =?us-ascii?Q?RKUTHMXk+DzARhvUI2eHlELCNXgjoxX1UEgqL657E9guzUfM0ZAbwcpc0aek?=
 =?us-ascii?Q?W0589TdjIkzrRxDjzg1OZzrif1Woy/6+r0BmmzTIj+gGxXNX11miFCxpCL+M?=
 =?us-ascii?Q?RcbkscG+UTiSWjpbCaAqMW7r78iLTNcUqXfbpYIngAQ5oBcd8rAoRq4E5gXX?=
 =?us-ascii?Q?Hh67rTmupCnaBSYicPz35xR0D/gyvVsT+oW5T2P5PWz365x2Zl5hTSnAJRld?=
 =?us-ascii?Q?kkothPzjjeGh7OT9ieetFuQPtyg8xlhw4UUUP8KgpjQQ5O+YLUEhUgfK36q3?=
 =?us-ascii?Q?QjF5TZQy2mK5RrvoCwek+LKaG1hScYR9GHjZwq1efP+px6/AKf/xX6rNTbly?=
 =?us-ascii?Q?oLgjXa+JeK9zvjsfdejJcaFftf54oXOid+qMyRS9JZYSu1ABuiGDFXhvdyTT?=
 =?us-ascii?Q?7SgZJsP6B5GXBxanJx7TyuRpkv3EKf605+al0/YtqaEYFDOhb+K18ImrjzCT?=
 =?us-ascii?Q?ZHmyyZsoeqKPc/ClvmMU0bEd1fOFirMIppL5iBf7WV8dkCHnZeLah+LO+A0g?=
 =?us-ascii?Q?36BSoLW+n2RVg9gFkjJ6dLwsVjBIQUIIWpyqDTlnS/j4acXofueMqQ5Qzxjy?=
 =?us-ascii?Q?HQ/86Tsr29cCGHayHICTi90sMIxunLITV8R5ABcpYOOD28WDvZw5PPeL6c4M?=
 =?us-ascii?Q?8nFiEsyD0IQW4/muQmWGeApgE7nvnITUjfwx/MuRiMq62egt5cZLcjV+wlis?=
 =?us-ascii?Q?PtYWglUGpnPfMCkA/4fWUlHMNbN4Nzblwr2za802RLmVubaPw04D/hL40SBd?=
 =?us-ascii?Q?/UmWG3NczuC07uo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tc3hTAcpn1F3nWIsDylBgbw8v3jlJvn1VW/1DU9OFML+/KDaCr+iGoG35ytz?=
 =?us-ascii?Q?5tiTBW5HOyqI3bwcnyNdCS4YMGjmSQTxC6QAj94Qmizn7MVYiPkmCr0nnP9K?=
 =?us-ascii?Q?5O2FnLxWGKdMuDZDZSOtBQ96hz58IDVuSgqHRi13laV9GMTzRUOGkUj5J8YS?=
 =?us-ascii?Q?JYA45S4KKyRVoLgjzuFScY3LZVnTsIU5XaZk4bKoZfyl7IJh7c6zAAPT6UFC?=
 =?us-ascii?Q?T+Ewu3TtpNXM6DwkNHVOypFeqUTJ8XUSP40D4jVtpybcz++lweBg15NKluFt?=
 =?us-ascii?Q?hpErxuZJKM0u91IfXH80a4EcrpHQ+NhKYQ6iKGtjuA3G9RUirfYwZu3Hasnf?=
 =?us-ascii?Q?JA02vvziJm9gsPuB0graUd0j6/RppEDqlir7uTXdLDQQAO4yFC9BzDViazZt?=
 =?us-ascii?Q?R7rRgCbHmeBVrj0VOcDZz0h1f6H+jGYOSwEirVgFvfyjfLwHyCX8Mw+UxBHK?=
 =?us-ascii?Q?luPYXhWkfbbm7u7WhZs8o4dyKORBBYeVRU5nDJqI6jCFox1M/HcPJM7ENebB?=
 =?us-ascii?Q?4yL+F9B27ZEgDBHAsU5xOq/Ircy/KjYQ8lx5ViyoicWvlvGc4rOxYlizApjF?=
 =?us-ascii?Q?p2/wkp7ihketT0OZofeEhmA4R1bhpE+RikWBa+QOpf4XmWr3ZsgH5vfbpUPP?=
 =?us-ascii?Q?/qwAxCUWNC0K2ICQWqEnOYj0SHJbjLwtTJWA5OidgIH4S+FjHKxSR54KmQYu?=
 =?us-ascii?Q?ISLntm7iRcFIfyNS3ZENBW+TfWIGkkS2n3+K4d0TZCc6G0tlwnm54dt/eH5J?=
 =?us-ascii?Q?tKIA6ZVZKgJxKO5kx9ZqFc+BIeGpqdsVeTYJ9zMwaYWqIarwA3Qd2zR51NMy?=
 =?us-ascii?Q?xtuzsTepPwcsMyge6fX1SJEDtyORSvluUSxxLvJDup9iZS9w9B8eAyhEMDdq?=
 =?us-ascii?Q?NjrbvCkGyLI/GgjZp7oAcovfKJc8RvuEonkNFhNAbWuUPCxPZy605FDU8/Hr?=
 =?us-ascii?Q?+Cr9Y49l/+160uYVwtv7S9KWqBzh2W90LseFOyuezZgzkw1Di7SYXjn+SN81?=
 =?us-ascii?Q?Wbt2ZzoVQNR11Hu3+aORQYwccOlNKju12J6IozZnNCSHB8OGx1Tu/Nnbw9XZ?=
 =?us-ascii?Q?7UNHnyYYh9pXEnkg8USbDDBN1q3J96dmpaSgAXnAl5uimTFLZSfmIyL4nYr/?=
 =?us-ascii?Q?8FcgwitkajdsvobgXnPTgMgYhSiVoVTrHK6VuMIlL0jrf8oFrVAetDMWg12L?=
 =?us-ascii?Q?f8CpduVv+sjfKQfxvwSzkUuGoldOAcyZOzCq4IbLUFxP900kkO2OJubcLz+a?=
 =?us-ascii?Q?yoehlw/onQKC7YsSvC/3NBBrsPUXuYWUgi5aMEND0N6e9GzUeU4g9gvnjhJi?=
 =?us-ascii?Q?0MeHcQNCtuXxaQAHPUIWUKYXOAV9IzuW/OzSTZC5/9XLdHkai6AJz3/5YWGM?=
 =?us-ascii?Q?1O6KlqT/OSvDKfChHZra227A/O3GsdDBdubHdlw9sfjfwmBOE9O70ZSYN/lH?=
 =?us-ascii?Q?C1pXBzagEcbdCKSHY17L7Ew2t5/g60kUrwK8O6tiuimZ9R/BYL2m9W/0qdLr?=
 =?us-ascii?Q?HJuAaEmS0YS0YlVhIVAAJJ08NOz+7enNyhsfN/iklm13mnW0ZqaCRYismZtW?=
 =?us-ascii?Q?TiMLAUxP9UFEfaNStFEp2yWBZsYqx7unjyHxOOpFJw6bucdxIKrtfxASgoXZ?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef2392-99c6-4b14-95b8-08ddf764b51d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:06.6120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXxCfjvnKkQEdc7eTF/eUNdNmFDhi98qwJukZzZFaa4VZKr6QOiL9azsPOsxEqTIi0T6boZ/u8mIbyW6iS5oUmTJMq942QI48tjQ3iupfRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6833
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

This all started from me wondering "why does this standalone app end
up being so huge"? Oh, it essentially links in its own standard C
library to get strlen() and snprintf(). Which then led to asking "why
don't we export all those standard C functions when we have them
anyway?".

CI has chewed on these and seem happy - it was CI which told me about
the necessity of [1/9]: https://github.com/u-boot/u-boot/pull/813


Rasmus Villemoes (9):
  malloc.h: be a bit more consistent with macro definitions
  _exports.h: drop creating dummy i2c entries and fixup config
    dependency
  _exports.h: simplify condition for including spi functions
  _exports.h: drop the last dummy entries
  exports.c: drop unused dummy function
  exports.h: make sure declarations are in sync with the actual exports
  _exports.h: reorganize a bit
  _exports.h: export standard memory/string handling functions
  exports.h: bump XF_VERSION

 common/exports.c   | 11 ----------
 include/_exports.h | 50 ++++++++++++++++++++++------------------------
 include/exports.h  | 38 ++++-------------------------------
 include/malloc.h   |  6 +++---
 4 files changed, 31 insertions(+), 74 deletions(-)

-- 
2.51.0

