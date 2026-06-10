Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC83CD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8588849C9;
	Thu, 11 Jun 2026 04:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="HI7e79FN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFE6848DC; Wed, 10 Jun 2026 16:25:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D68848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQrTy4G5W/kLo4G77q/nkDUhggV3gFtVIMYWbKCzredM8SMTbWVM8YnR62Tpfm4NG/H+MZ+5iJNjKeAmo2VrF9LKQJNOHHYI96stk4bmpOYM5rt+1edYL4PmYeOqTGfK3fSVOBLIi6Z+bQQKIuCIp6B4fk5c/RZXoU4fZ5lBhj5Fyd6gxqUId0n2EtxrvP8pHBimjxmNLwYrAX3E/vnU4DFbg+RCa1LcFwnzODk5SJ68FviJqMRQlnrm5n7ODmW3M05BsAxRuNyTG58fjg6z4/8LsnNxZGnWHV3dlgi5SfgV0mI1ULyWAFo0fye2dOWi/Gq6dIfpfQVrxMeyqqko+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsZ0lu+wcNxZoUSlq9spDN1z/mc3Z2Kcuk5W2M33DC4=;
 b=bG9RFHXnNNQSqh3wgBsF+Q/AB06TXiahLPuiXIwRH2YKGT3AgS/BKKlGtDPyiJgYvNDO76XxSSQgikqYIoZ9I2O8Y+7mbAkH+4kb39zLEXYCQEHAtQaRHYFUQbgylJBdtOaSjcJue3Kiz52DqiO5foYTTHDTJ6PpnLx+ZhpTscS8bwgTSiLnKu69t0THe7UtpG26G3v9WECA7DPe4FvtlRG580WiWbkcCGqsVY6omqIX+r1iNoLb9fBGECYwowlcpv1wDRtXERv23VRQcHTWHadU2OOW+v2ObbyUB2ekApMigDDRwQxlNrbE9t9e8G/cBDKM9+z3Z8SlPXA/sub1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsZ0lu+wcNxZoUSlq9spDN1z/mc3Z2Kcuk5W2M33DC4=;
 b=HI7e79FNfq9A2JnuDmQgjyOodFLaWuH0pSFNpcidjzPzkq0HtAfFsj7YzO40HhDTHJ0+X5ACfnUAlZ26zu1DauzFbsHM1Q1/C1APsuYcVlgA1GEc/t9mvgfN0lAB9TcaqoK5bssVhpcB8wVhGyMh+8fVRPj99BNM/uJ1Vkt08t57WbdiufmzR8Hzoy6PFui1JaxeCGvGKuJnqKGzGLkCma5gu7BBP/gfD8YeRhYBFisVASlF3L5PV2QZQIySDUxJP97RXCLzDb6+7/mA2eFacMDgiSHmB7nBplpP+IrJyQO1SUSJn/mfmflP46PIigZBsK3ZgO7jz9dlYmUugewwGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by AS4PR07MB8827.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:25:52 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 14:25:52 +0000
From: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Subject: [PATCH v2 0/2] net: clear IP defragmentation state after returning
 a complete packet
Date: Wed, 10 Jun 2026 16:25:32 +0200
Message-Id: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxzKWoC/02NywqDMBAAf0X23JQkRsGe+h9FStysui01ktjQI
 v57fVx6HBhmZogUmCJcshkCJY7shxX0KQPs7dCRYLcyaKlLWeRS8Hh31AbbCZVLzE3hXOUaWP0
 xUMufvXWrD47v5kE4bYHN6DlOPnz3WVKbd3RLqf+6SQklWoOodFkgmuo6+CfbM/oX1Muy/ACDJ
 21+tAAAAA==
X-Change-ID: 20260530-ip_defrag-130c345dd9db
To: Ben Warren <biggerbadderben@gmail.com>, 
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mikko Heinonen <mikko.heinonen@nokia.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alessandro Rubini <rubini@gnudd.com>, Simon Glass <sjg@chromium.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: WA2PEPF000008A1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64e) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|AS4PR07MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4681d48e-1f5d-413e-0f6f-08dec6fc2cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Bk70cz2ZPozLiAUvBw6jmOmqrAAzS6impVm6DL+w0hNB7COfQinejcKl6zZdInK+dbeqk2CIkU3sEM3IW2kg+RbOdKdH4Sk0fGRCOy/A44YchcscbHC0CKXzGPWLerpILRtxXm2Y+dEHjK3BULRZoK3EKbkaWYdygdQh9OjdtIpjAxwIgef8kOq5YS08/P1hZL9WLKus0FxB26DryT5w5rQC54Pe3jgQuwzt/w6Me8QVgxNWTuVqmvW5OsLY/8pFO2FihLJfz1XtNCN9LJVT6l37jh+teKi7/zxlHQ0nRGC+RvKPT56kHwYhQxwqQmrGpbBrQo+dkgBxzlivNLrxwgf1+91pzVVeddT4rgN1fTBHZOTgn/T3phXEeGiRxgRVe15BMEQUfLg1pgx7LnjrEiUd0uVWIwa5mGaS3tGEu/GU85FLH79zQs7ey46xyLR4MN9dN4rZFGaAPZUmbnBzrIQrIgD1P1dO2F7y7Ov5LyZopQubtsTvW7ZlNURGNlO9bsM03H6Mqp8k5xwKdj5d/ukzKDbcL85ormCJl1irg3n5X+15tfvJZBnK8rsbJlzNa7G1BXzsSTdPQpIMM8Cy5x4Q9BlTNqDar3v2oZ3+/HOk5XyF0w7RtXJLkCRGYrxntdyiOkkvVb+7I+d/tmXqF6UA2obNgCp7DDEzc6cuWrmaR/pMtmKFql9Kpj8PPqSEkoGSnCNiQdXQ9NzjmwY3vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhkbEZtVWhLZUp4UkUzTVFyS1hXNmhFSWZsUkJBMU5TV1pjV2w3MVRZY1Ey?=
 =?utf-8?B?TzQrL2ZRR0RPMUhhRWtPR2xuQ2lDV2ZkWU9aVGdsVkh1b1dwMngzMDViV2Zi?=
 =?utf-8?B?RHlaU1pYK1ZEdlRLRkZod3hScmgwQzk2MysxRWZSdVRSbEdjdUozTGF2Q29a?=
 =?utf-8?B?SlZXckVmL01aQkhKUENsU1NTaVVzK0wyRUcwMTBNQURXNVBWejZOOUF3bFBT?=
 =?utf-8?B?Z3RjSzJjenExRERVMUtNeE53OUpkcFlFWldUdUtpS0FvQS9oemR3ZlFUR3U0?=
 =?utf-8?B?QWppRVJXTnBJdU9JTkZOQW9udnVLWFJmbllWZUc1RWwyY3pBM0lvdHRFV2ZJ?=
 =?utf-8?B?RW9YbU8wQkpjdDhpZXBEalRCUHprUERueE1qUnhDbWhkQkUremxENzhuRUNB?=
 =?utf-8?B?L2JVYXd0SDQ0ZGNMS2RpdjNoN0pqQngrZDRxZDZmTHI3dWtSSUJXRGUzYzRr?=
 =?utf-8?B?UUZDUVE0U29YTTBlTGJrWnFCcDZPVlRoYkdRT3FJYW0rVUFoMXRyMXIwcnda?=
 =?utf-8?B?U25tbk53ZXdaeFh1ZTJFZnh6bDJjalhxeDl4a3lVc1k0RjBHSW1kamdxbzdY?=
 =?utf-8?B?eHVpOUZkV3JUb2ZsRXRuMzQreWtFY1BKWlRUSkVaUWZLdm9DeGJQQU0rUGUr?=
 =?utf-8?B?WTEzVlJUTm1EM2NyOUZOVjJVdU9hbU81S3VpWStZZmg5MGRvNG9GN1lKbmJF?=
 =?utf-8?B?L21jUUI2OU9wRXU3azd5S2FNYkRuVWhrZFJzbTlacUQ0N3hTRG1tTHNLQmhB?=
 =?utf-8?B?RHNSL1A5Zmthdml5T1NhbHlsTzRleTBBRzdEWktTM0tETlRUV2o1YVJmYWg2?=
 =?utf-8?B?WnI4eWZHNzdoWkJPdlBHUGRMTVAvRDFPVktwekhCd2Y0V3l6UFFoR3ZPZTlq?=
 =?utf-8?B?TG0wS2VabS90QWdRMXU2UXJDdFFBTFMwOHRWd2pKcGc3ZVc0TEdsMVUvY3Qx?=
 =?utf-8?B?eU1aYTlwRExGWG5PR0FMR3dadkQ4WlpnazVVcloxM01uakhIaFJValRmc1Qw?=
 =?utf-8?B?b203SUNiQ25tWnpnNGsxMFFwVko0OUdTNTVvTU1Yb0FtS0ZRSkhzN0RHQm80?=
 =?utf-8?B?cUVnb0dsTis5ZDVKOTN4bmtlVmt3S3FDV054TmkvQmM0ZkpBT3RHWmlOZktX?=
 =?utf-8?B?MFVpY0Uyam4wZURFYlV6ekxVank4d2VFTjhVQlA4QjVyeFdKVXN6bEJjcDhH?=
 =?utf-8?B?RnNvVGpSMW1ZUkY0V005M1YrcFNxU0x6N2VUVGRvWHYyZTIxdThWMlZ6VzJk?=
 =?utf-8?B?YzJVYlFHbXdneHNzVWs2dTkxRVIwTU9RL2gxUzdZcTFCUmc4eFF5ZFhGc1pv?=
 =?utf-8?B?T2pER1NJWHpHYkFwNjh0ZCtKWGhiTUlqZXR4RC81andRZWRvU3ZKaHRGeFhI?=
 =?utf-8?B?WDlrdU1Vd3BPVzRsOHY0Q2sxYWNUYnpBc0MzU0IySkNGZW5HTVZkeTU4eElV?=
 =?utf-8?B?UzZxbldtRmtFcjlpSTI0bzdsQStHVlRPZnMydXAwN0ZkcitLaWVNRG0xS3hT?=
 =?utf-8?B?NEZyOTVwV1RZU2RUZERLWlVIL1hkOXBoMFIxZ2M5SFUreVJxZDN1c2QxVHdB?=
 =?utf-8?B?OEoxRDRZWlR5Snc4b2lWUFF3cXlxaHkzbENyZVQrbUhVOEo1d1diakU2NDNh?=
 =?utf-8?B?KzkyY2I3V09tbGpTcUpxUEZIb0M4K0F4N3N1c3FnN3hOdEx1cVhlY2tvOENC?=
 =?utf-8?B?ZzhtSG1RZjBoS3JGSVR2S1J4bzc1TFF4bE5XcGc2L3pVL1ZVdUk4WDJnRGUw?=
 =?utf-8?B?SC9BN2lQQ2hMYWlvdUFTRHRUY3FuQjcvR1hSaThPb3JXNWdpaDJNS2dhWGwr?=
 =?utf-8?B?T2JmRDdjL1BneXVLNExva01Td0lHMTlrN3pNOFJhaEVVTzM3K2lqRHdyc1ly?=
 =?utf-8?B?TU1IRlJlTnA0enk3T2tjZGdORm1nLzhXbHNUenQxWVVIR2xnY1NjMGVPamlV?=
 =?utf-8?B?Wlc4eEVNN2lzUDlZc0FidDNaR2tHcnhGS2lUdk03TVhjcVBla3dpRW9MRWtx?=
 =?utf-8?B?dEQvY3czczBDK1JtOVlCRHNPWkNsWW1pZlAwdmMxSW5LVWNCYWNpYWNNbDVj?=
 =?utf-8?B?Z2xpMTlTS3pzM0tzcUlkV2RnYWdEVXhYell2TktGeFlHTzRMaWR5M2d4SE9n?=
 =?utf-8?B?azU5MDdNdG1xSXZ2ZTVDUHFsTVo5K1YrdVB1TFRJTCtmaDE1OG51c2c1a25E?=
 =?utf-8?B?V3FLbUJRM2hUb3VZZGw2WS9QUlpKQmxMN05HMFhPZHVGcmwwakdSd0xlOGVw?=
 =?utf-8?B?OWprblArUDhlNVlqaVYweEl4Q1ZZUHNXVmhIdGxuQjBnK0pFdzk4UnJtbE9s?=
 =?utf-8?B?SDlxQUc1L01MWFVJOTJIMGY1WWp1b1k2b0szbzRzVnMxVk1rZ3Y2QUNJMi8y?=
 =?utf-8?Q?1YXdmkhRHGWRTzTM=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4681d48e-1f5d-413e-0f6f-08dec6fc2cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:25:52.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9rWRTYD/sfs0CxW875xdLvXIWSCD2mfmAjPwkRehEKACTgCTtgITtIj42GnEyItcTkyftrcSGpTRRo60eTeq3HcXf+pFzhHIR5S3bxxI2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8827
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

This series fixes incomplete clearing of the IP reassembly state
(CONFIG_IP_DEFRAG): the static counters and hole list are not reset after a
reassembled datagram is handed back to the caller. A duplicated final
fragment is then processed against stale state, mis-parsing the delivered
payload as the hole list, which can lead to re-delivery or out-of-bounds
accesses.

Patch 1 contains the fix and the full rationale; patch 2 adds a unit
test (run via "ut dm") that reproduces the duplicate-final-fragment
case and guards against regressions.

Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
---
Changes in v2:
- correct spelling in commit msg "mistakingly" -> "mistakenly" 
- net.c: fix block comment formatting
- add regression test (net_defrag.c)
- Link to v1: https://lore.kernel.org/all/20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com

To: Ben Warren <biggerbadderben@gmail.com>
To: Alessandro Rubini <rubini-list@gnudd.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>

---
Mateusz Furdyna (2):
      net: clear IP defragmentation state after returning a complete packet
      test: net: add IP defragmentation duplicate-fragment regression test

 net/net.c            |  9 ++++++
 test/dm/Makefile     |  1 +
 test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260530-ip_defrag-130c345dd9db

Best regards,
--  
Mateusz Furdyna <mateusz.furdyna@nokia.com>

