Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA51C54F52
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 01:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61F7140696;
	Wed, 29 Jul 2026 01:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-rjHiD0aKIi; Wed, 29 Jul 2026 01:41:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53A21407CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785289284;
	bh=ivwPYTTiqOZUFmfW1yVstW4wNH1nz+Kben2VoGWJYNc=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=esNMQztfubwqyzMUSVR+MUhJRILHJyAtVoKlaqU2dXV0WnZ/BzW7Je6b8waqZk1Up
	 1d8gG6jeEDN3hZpRQe4aviq3pKRneNcbj/xqqkZ9sQGUZKMm+mg5vfDuZcVe4dnnQ6
	 TTzVGxbiNnWT45CEcCvOXE19LUeItJ/ZoW4OCLQ6wn7jWOQk9IcXUhEXrsPTX8HBKY
	 N1p78wunkiaytkQ982X8XYhQQAXhwQ2dRCsQ3xF2FOYJfwqF7KcpO4LJjK53I3kxYE
	 jHTOT3GsoBDW2T4u65+M8wKIRHdjPPI3HpGkXn41DOPYjObr6vSO3slc9JSWz5PAc1
	 a8Hie5aF8q1mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A21407CF;
	Wed, 29 Jul 2026 01:41:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1DE788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D376760787
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10ldJM8eufz9 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 01:41:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6B4360782
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6B4360782
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6B4360782
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:41:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE6F8494B; Wed, 29 Jul 2026 03:41:16 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571878404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 03:41:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YholOrCPb2T4NWALvAB6SGgMuDW1msU/z11izwYwcXu0r77XVoe5JYwB+9mKOj0bJV7TcWJuZx9YCbK8muc0vahU0Nyu8KJmnMyms5H5oQvmelMwxoVvQWsDAwODKmmYgo2HbjGd4UABZa1E5FceaZFqwViL8Huv1JYF13FPECSNlNS2VMDWlUvUujQMHyOeLSDarrMuWNq+n/s9wJTTBkpYccAorlN7mzgDljZ7b/lUc02ebzyiJc5CPVRFpFOkwvFOOqhWKehwOcHmcdY2mKboqqSw3rc48HG2QpEZ4/iwCbAWLDvGNqYsiMAL96ta/eBc6599w8fYSGZDhp6Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivwPYTTiqOZUFmfW1yVstW4wNH1nz+Kben2VoGWJYNc=;
 b=mlsFwhAmpJavLShFAQ/Otp63OOSdwZiYVkzrqZ4JnLwqRL4j9Vz4KbgSkimZxVXYLxbs7YYqRHqAmTT14O9sYg77KeBN2y7gLhQZ15jCeaHS8GDx38ICCJgFZXbjp+Tlj8WJNLQCDmcKcnOgPMSAODpuh8RURxzV/y9sKADFLnVQJ0O+w/Efyth9PhKUOkYdYKO5w8c2BlLP7IQhKypS0Wq14l3ZG1joZtJN6fIdfORIvRgxOtXFgHEk/o6BK6XLPeN8aId8KOCGoLgOhxv9kvHAiND4FQEEPE6xpW1QS4UCQwcvqPcZVO54fkXvHAzsrnp75ESqNPOWiIBYhhPJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB5797.namprd03.prod.outlook.com (2603:10b6:510:30::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 01:41:09 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 01:41:09 +0000
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Will <btdai@terasic.com.cn>,
 Shi Lin Teoh <shi.lin.teoh@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Nano Board Support
Date: Wed, 29 Jul 2026 09:40:57 +0800
Message-ID: <20260729014057.17982-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7275a055-7d75-4cd7-bfee-08deed127655
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|13003099007|6133799003|55112099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pkPxVCmTGnTDymK7JSP31P7i5v+BuHNUr6L9RTm45XR3V5ouvHHL8WcoF0+3GQG7CMGxdeCQlUWMyS5WhyCg41pjYwHPbCPQwmWcJTx4VewTIEAunBeoGGBwoy4zoNDDyIvJGYJl6qEPpodDEPM3ahjroYxoMnMMv/8XSaOt4MqVQ4amHRlPpAZTgedb3mgBNPA3cGqcsCFEZgqVThGW8wDbMNpUI6s3UroZPHigz24vZJ8Q4hgGBLGDi9osNI8nTyMPmRfH5DtUa2OLobqVLHcH3CcfPt6gCQXRqaPhtyZnOtch6Ql8oC3staPdDm8fpEMRZsBNhMUsbLEv/C8WVdZSbVs74aldG7JtR8xn9jD6GXoE4BolZdhX6BYCEQwNm9szY06v5u9OAeNpuAIdTpfw+vptTWxmqwJ2HphhAjOgDrwWKKdH8vKTMhaCPqF+fGJAOlscmYPj6v6CWue8vcMn7jzbUAK2JO2ZR/jQiviDex7C4x5UswQQIPHKCPachrQVo70E/+vVg5a7QvCovw00KqPFk8YDbUDqLUe0Oyr5iZt0CIvTjW2oH6l+bOYCQ0KjlRmJjuqBeMOZbgyl3iIkpKkth8Q/DEnB7DWsPwOhOkoT253pQ2DnE09kWfNh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(13003099007)(6133799003)(55112099003)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?98XmvX9GiKCDSNzDWwTZOJYegCb/bGsambCP4/FRW9RPYnwaS/yx+DbAWu5B?=
 =?us-ascii?Q?SFG30RsMSBt4gTnuXHbAEVlAtTdFSeuaEhV4VBHt+HiRoB+1Oj7byGl2aG09?=
 =?us-ascii?Q?PjHncF5achJpeqXk/qEQZE4EyEP8ntw8EOAjuheV/q6w96/wxRR/iuY7iZVT?=
 =?us-ascii?Q?RHipRmRvIVwAjSF7TZSsj+m0mBMDWu7D+BIH41CWOE4jMzbgLFo7oD1vZWgU?=
 =?us-ascii?Q?rdd687DWO+qvl23QIUdhL4agJehqU2GGEYbHT4ea618g0vttUj4x2j19+eXZ?=
 =?us-ascii?Q?aeMQljUyepUoohwI62Rtzzedth+PdJG0h4YkvLOzV3qydeuQAJg/7uSCrYTi?=
 =?us-ascii?Q?2pN+/92Zp5ANS9aZ+6aXlEGA6UqmE0IJUZDtPtq6II0eG1nem972mgr4sS3K?=
 =?us-ascii?Q?fpGBJgNM8GsObeDE2X5krDoeSVhbY3+OBlvgav8wkpaErvf8edr8rfbElXKF?=
 =?us-ascii?Q?+5+37hTXjiWRCT91sFSuT/LXjlwdAVuYIGJhaJ/siJdjXwDCzz1573iLdjbB?=
 =?us-ascii?Q?LFmdiUBvrkjUgM4y1/X2hw0YbTC18zlXZnCrikuD40t235u8BwLe0VQ2YGF8?=
 =?us-ascii?Q?D2+z8kIv35lO/ZX5KF0Ru1wBTz9BUfRt1M2ARGVbS1+cEwGIdf5mKkNmZQ40?=
 =?us-ascii?Q?l9qA/S/nF/hjhtGknVSXBJr5OcNf2acgFT7CdrvAS7CJCNtLc4+FpvN3PAmE?=
 =?us-ascii?Q?fmU4vrAo3m5S3h0IOdjVv6uI/g6UMqf9vxOxI8N7aNxgQc0pqv9doXwM22OC?=
 =?us-ascii?Q?toRuz0o4+dIdJSvE6mdrIEyEVWeF3PeTkOuFa8o+//LiOI2JhwUZxf/P+J+3?=
 =?us-ascii?Q?XCiwO4fGyoV/RUSUibJ+K6tnY4kg9f675ptwbL4SqrRAScqqXK4GuAngiYxC?=
 =?us-ascii?Q?gYo6L93fbJV36crDidstuYS/9nYW7ki7iX9ub9DZTlv4VyQQCwXS+fLpweM6?=
 =?us-ascii?Q?Oyv32UjukJOXTAHNFtBzw7sIvkYRbjrn2ryNu7vtGLAQF80eHdb0/72q7zjs?=
 =?us-ascii?Q?ZQKInUPiTed9jbGrsqeFVO8Ug3D67Q7y0q4dlonnx2N28eQFUX4RnbqBGbGt?=
 =?us-ascii?Q?yhtuD6VIsuYRrjORW7VtbrtSd6Con3wjt6madOdB5n8oRkOqRTof9KPpcRQj?=
 =?us-ascii?Q?i/Ps83XNMvppWrWwUNLoOLzPyy/cPo0AH71kht1ChISOOHarm2y2DJY+TSIl?=
 =?us-ascii?Q?OCFos3mJ/swK6IoaykxqWPW67us4JsRs/wLZ2QqR82ypnTb8ECYmPqnofUMT?=
 =?us-ascii?Q?IvIwi/jWiEH0K/l1caS5nRceawp3oeO0x11MjOgahgZixYYHYljAtEqsEmCV?=
 =?us-ascii?Q?/HJC7a0P0KD9JTNoHycZ4rwmtTDjagyF/ZdwO1VhNayYPcCaWfX/uJHDRnSn?=
 =?us-ascii?Q?hRS1pJObkhxwD/kmKp65Q3HNXzno8u9s0JJ1ndm+fsa2RSjVrZgWOP9og02J?=
 =?us-ascii?Q?emWbhRFiupmz83CCfuoDCsq4WS+lBPQcS0sLr5a4ytqa/ZqBKgNDk0QikaxQ?=
 =?us-ascii?Q?oO+T/7CyJrKgaSVmOYjGpTjT03+zOVu5WFip+JW+qS3aIHZvXSH/U2QJpwgY?=
 =?us-ascii?Q?wI18/wEOIcpj+avA+NAKG3A9UJCSlaTEF0TD6ARivBVsltJszzuoclnNMHsB?=
 =?us-ascii?Q?LPVbiogHoRvZdjL/U2oRmZ1z4x9kEXREXzs3IKOqgKCnpbdMI62tDp84QF67?=
 =?us-ascii?Q?Wm814yNI//WgeH1xa9ToCPq3kzp01vDY8l7UoZUQlZzXmVyeP3aW8oFArs4f?=
 =?us-ascii?Q?z2nICqY5Ya0kiJMY/UB3S6joo9/If3g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7275a055-7d75-4cd7-bfee-08deed127655
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:41:09.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmadfuIbJm+FWo+4n2DrsFHWZChh467i8zB3aj3/8a0w0KCmvGDprhWMdZ3Lr+LAwPOClIfjuJsyBl4W3KGkf7wO8Ny6SzAfsbbOzrDLNow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5797
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivwPYTTiqOZUFmfW1yVstW4wNH1nz+Kben2VoGWJYNc=;
 b=YsXfk8W3Y31vRn0nBd07k7TWXVp4Lg5us22VpHWVMmu114/wmIe3DmN3/oq+x5x9RGH7lNjQNOfUmKTLirECLUFRgM8/LqH8JkcebdMxkp59ZVwAK8oH06XjDTeaE+ow/Ll6pq+ecd9eeSMEAFA35RuJNaK1+1QtmTGb/Vk6ISzYql1idi1PDYo3/RcfErQ6eJHKA6DWE5IcrisudrGoDSZ0YlBHCq194DSOjgHo1sJV3l914ktiug8j1tk1DSmP7nS5ByCjUhI+IGrxx+pT7uZ7bncDw9db3kWahV6H14WGg55StyeUaFGH5o/IDKP6DfbmEGt9xdu7MfKRtut75w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=YsXfk8W3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="YsXfk8W3"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Alif Zakuan Yuslaimi via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: alif.zakuan.yuslaimi@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add dedicated device tree support for the Terasic DE-25 Nano board, which
is based on Agilex5.

Following Terasic's Linux device tree for DE-25 Nano configuration in which
UART and MMC mode differs from Altera SoCDK boards - enable UART1 instead
of UARTT0 and using SDR50 instead of SDR104 mode for MMC. The device tree
is also tweaked to enable the 16MB QSPI flash to store U-Boot image in a
single partition for QSPI boot.

New files added:
- socfpga_agilex5_de25_nano.dts: Main device tree
- socfpga_agilex5_de25_nano-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_de25_nano_defconfig: Board configurations

Build system integration:
- Add build target in Makefile for DE25 Nano device tree binary file

Signed-off-by: Will <btdai@terasic.com.cn>
Signed-off-by: Shi Lin Teoh <shi.lin.teoh@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/socfpga_agilex5_de25_nano-u-boot.dtsi | 148 ++++++++++++++
 arch/arm/dts/socfpga_agilex5_de25_nano.dts    | 183 ++++++++++++++++++
 configs/socfpga_agilex5_de25_nano_defconfig   |  12 ++
 4 files changed, 344 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano.dts
 create mode 100644 configs/socfpga_agilex5_de25_nano_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25234697e6a..b59df585a92 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -415,6 +415,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex5_de25_nano.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
new file mode 100644
index 00000000000..8e71a7c426a
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+	disable-wp;
+	cap-sd-highspeed;
+	no-mmc;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <1>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "disabled";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_de25_nano.dts b/arch/arm/dts/socfpga_agilex5_de25_nano.dts
new file mode 100644
index 00000000000..c64b7d5525d
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25_nano.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Terasic DE25-Nano";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	sdhci-caps-mask = <0x00002007 0x0000ff00>;
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&uart1 {
+	status = "okay";
+	bootph-all;
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x01000000>;
+			};
+		};
+	};
+};
+
+&nand {
+	status = "disabled";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
diff --git a/configs/socfpga_agilex5_de25_nano_defconfig b/configs/socfpga_agilex5_de25_nano_defconfig
new file mode 100644
index 00000000000..88b616149b6
--- /dev/null
+++ b/configs/socfpga_agilex5_de25_nano_defconfig
@@ -0,0 +1,12 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_de25_nano"
+CONFIG_TARGET_SOCFPGA_AGILEX5_DE25_NANO=y
+CONFIG_MMC_SPEED_MODE_SET=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_MMC_UHS_SUPPORT is not set
+# CONFIG_MMC_UHS_SUPPORT is not set
+# CONFIG_SPL_MMC_IO_VOLTAGE is not set
+# CONFIG_MMC_IO_VOLTAGE is not set
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
-- 
2.43.7

