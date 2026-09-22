Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482D8C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0638D60787;
	Tue, 22 Sep 2026 02:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8dmXSSMN8ia; Tue, 22 Sep 2026 02:20:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0FED860778
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790043615;
	b=EZ9MwX6TwPPo9W1XSXO7TMPp6FHaYZZTB6uJxguKlvEci/mrhfVjD8FyoXDexA5+/8sZ
	 5Z7tzO7EiGWrGJ3tQUJWtzQjgR9JoSxg+q0PHy5fEQqEWHCUIJTWOMFPQhphR4N8R09bm
	 6bCmcw7C5O5ECo1G+tcbkzA53YTYbgM+5ho45anwVI2WeDnkbBi2lz06Am+XuCZLPydO+
	 Bxw5m7nhQ3h5XdEhErpmnMUIEco8MpZHyninuqSrTCeSFiKM589JnuSkZ4aXF+0zUfuBc
	 2aTNGNQ04YfQ1z4E1TfFBbkhOL0+UAFRUZjQsEuo+nDvGb3ZNEtyEbn7CGyKhf877tQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790043615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T0Ih9hDPUeJ60tHaOE9DHw6747hkAVBG2Ow2hVAoeeU=;
	b=XNfZ1F2F1lbZgt34fwXK6R/O0TsNQ7Dc8ac2yhzmS6S+KBgfDOM5oXRmM6KB/jfLy7FT
	 MvehdybBEbornODPyr8x2hwGBCdI0TD0YB4nC3TqaW0FLeHzECe4O48jlXCm21dFlFz+7
	 b7g2VlhYkWT0jYHvKLSE50hvlnhyoIAzM/yrsHGRw5GWdiqs3WKRXZ968fH2ZNYm7NPUy
	 2I6/4nA0pF1+igDo4/IQCa3kaxz5FKYXyP0rouJYqYgT6x1UU9ye7s6CrDZmqEkMcCTQm
	 Vlz3trLkc1T8L1+g4TwvQ3RkRQmnmxmzFuBt1A70hPFOaMBnYzr6wKjWgZ23/dBCSnw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790043615;
	bh=T0Ih9hDPUeJ60tHaOE9DHw6747hkAVBG2Ow2hVAoeeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=the1zbZfQEkxfEXdGXz2voDAqYByakphFl1LqsBmZ0mxIeZy/eM+6E5GSkig3ujUM
	 zylrr+UZwk158GC0hDkA8T2Lca6bXoo+c+qglh6T4rB3Quo7V3jRYBHUi4cGi/K2n2
	 PNeGWc1gxmVpmer10DqoVoMHXZrLdoZ+ntNMrmXnmXQw9xBtzyYsOFYxTNntcBWPn5
	 fcKcV0qAXgQBOULDA3HSBot269UzmVoa25MLB8VK3p+XYOcRUmfBhNWVlRQ9OdtMty
	 vkkmJgCoiAiVBS9hgi7X3aP4wU93xHxN9JGX8vMXzpx6KgTiKQPGquIbqXcRusgrNO
	 zz7x7Pds9hUGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FED860778;
	Tue, 22 Sep 2026 02:20:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76414B02
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67585400BC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLrr9ngrxNvf for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 055AF40081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790043612;
 b=fCYVdMzPi2gy/R3bzS3br+ky0DtUCXA/ILDW/W9oLCgm/Fp0fVucQ+iP2MH6KFgxjQvO
 sViKLTft+Zxb7LqbgngLqEjir0gEyYegw6EFY+WZwBbSaK0pIAAtkkazkeYhVjyvfbqcW
 cYDF5xDUBQHQ3vESBtxDT4jVezPU7XWXPVCH2IqwAR4knnSZPqmUJ/DtnpC/Ok9O5nAcY
 0LoIn/QesNlAiihiM7IPMJH8VIIiSzdJmD6amDOwCArAqWja3jPhQR02gVaowMYIcYhbz
 9A9irfyZaVNgfhYbt79UeyybDSGa3Asm51XiPDo8P4k9VU3i/tus0ibBhf/wNsFJ/tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790043612;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=T0Ih9hDPUeJ60tHaOE9DHw6747hkAVBG2Ow2hVAoeeU=;
 b=RDYW7gGxmP+NzWRSVSkCxmYp1mD/wjYK11I+TkeMZorGm3MgVxIZmxcO3XEmVJyj5mcq
 qLvHTxjVVgLNxjEh+iIfOtsCTXlzoT4Vti7zXXaBQq73WwZqsPWFYb83VrTOAYUEOrN+C
 +xq7qGkP7aeZq611efK90BZi2a72ZoErXzXpmDIyvkEDcigehwtlz+EoNsi/6auRtYdyX
 FYBa/NoOM+6NKMpWrcUdNn25vJG3buHPzvLrNzunT3jJROpzJu6g51leihms/nIO1MF0I
 DppWqHjIUoRQNtF21bRvSDm18bOSWSnjNojg6aR7beAJMc1yaquV4W8zisTytI7tmrg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DQjPTa0D;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DQjPTa0D
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 055AF40081
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBttJQ4jGJgycSIDS/BYh8h0ielNXIHzGz2ilh2iFHaIgNDU4M6IL9LuzksBZrVS2PqxAMiljjNM5Hmjy81FWYivsMBqX6/hzhdEen9LPu17WIZgtXw2ZlGucyjovwFS3lGBdOxws+uWnuL48G7M0bJg5WeFxbw+i58RKhutLdfMK12yIuY3Qh5J/UbFZuxRVOZ9Uc9OjJIkA+BNqALJ6Zz8PvFtPtLshdvgzpo1sB7ge2XBxVY3Cr+ewgAQtyq9S1KWIay2tZ7ZkXN62SFkUrzk32muW1hzKocpZNaDerP9NUfJDTRPAROlQlgXxzWyNGwumIGLUmEuU12QyuMTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0Ih9hDPUeJ60tHaOE9DHw6747hkAVBG2Ow2hVAoeeU=;
 b=u3JesPzVubXj1EefPEGUUL/qMbTLBmtTcjvOLuY77SHgj1UafVLDRv9zCjnvYl1NVfKGz5mRf/DQw+8v6t/OqyXwe+OfOUJ3M6uzyuqYppyL+6tBXy77LwF/Wd2NVPH+z+8F0vcQZ1Kd6rB4XMH+WC7DJY5WGYRzaUMx3eH3cm5yPtpFlJa62DLT57XrQwwzuRnXg5DV5oLxIEwwHUa+mssSGAaDb8G12zO+v2tfZ5nKOfXelju8VYhWUgUgikE/lKr2cT/pWw6ckPkfaIzosr+xAJASK0peSPGFywkWfIodIjnuEeads5p4eXLJKUFBp84T8kD+BWBZop8Ml9InoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0Ih9hDPUeJ60tHaOE9DHw6747hkAVBG2Ow2hVAoeeU=;
 b=DQjPTa0DXZRH+66RXDuoYhnU/usH2l7orxTel8VT0SS568NR/KJ8uJ2jRshIycHpOFZ9pa0YBmT5UNw5zF2svdnkmxX7DIqipBwKUB6gcUaTZisstqAqkvx6k/WbDSZKe6d3XtKiy0tv4iJOEQG9rwJfbLkDR9pUu5ScH9WoOenCTEMaBiPkC9G4P/OBLgPI90aWbzjg0GdEC5FakF890D5apd7LMt+DrlqAxNI3VHWrakATZ4m8/HLibFfOnxmn/LOc0YbbXscVNKcXHSYoyRf4y4svePldJyjbspzw4WzOsI6Q1VhFnAIiYEonCXyse9Kdtl9SaIfJen4Wsz6jIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com (2603:10a6:10:14::32)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:20:09 +0000
Received: from DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b]) by DB7PR04MB5130.eurprd04.prod.outlook.com
 ([fe80::299:61d2:8995:f85b%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 02:20:09 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH 3/4] spl_imx_container: Fix verify image after SPL dcache
 enabled
Date: Tue, 22 Sep 2026 10:24:05 +0800
Message-Id: <20260922022406.1838737-4-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922022406.1838737-1-ye.li@oss.nxp.com>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To DB7PR04MB5130.eurprd04.prod.outlook.com
 (2603:10a6:10:14::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5130:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 88288dd8-e5e2-47c1-5beb-08df1850063a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hRxOe9ihlMmGf5UASmDJLNtD1LMB2/YlCxv5uhQr6LgD8tZ1D6TUNuPOK/f3aXxCHXacJVGS7QdGz73+njENPxNv5JCQpmdBl6R3V12Bxzs1k+boHZQMsv1CIAwRyadFSvJdXSySYhga8LIe64C54iNKQF13B3mIlWL18JLjJj/W72dMr8JuB9X4gN5WNWTo2dWLQs/pufXyD9MuKZoLO0ej0mVaJ6PHHclv7xoBgexHv0J9zhT4HoKmzvyOehHwjK6IMKcsMHi5w8hQNpCGA6CSx+oUF2i0ojlZGqa2APWwG/vmZJ0IyZ9JtsNEt4dXsG12xQCPYQjyRu0ciGy+ZM95S5Xr2V/M50SRK6D1B4Fcq6QipRkxUoXKJXiU3KrbqrHkgQfjR87prbAzgZZ3R3isD5yDVRLJfeauFgQq0VNCQhcOaSOYaTJQSs+NLrcTJr3V+sLhmevk/j+p9CGNu5C8jfLV2e/U0aybwHP02+5OBtg8ov4j7FoNSjQi3Ig4DkqnhMeKCVuyar20z3JvhKjhDewscRt73rAxcLqQrh69eAOm2GBvi5RF2ZQSX1dB2c3yg3AupW7zaPIlD99ifavDpjTV8AvFZgo034gIVT5+Ds8aPvMJ5gmeSzBUqUa9Z9cXC+Z88jnd+1TquNfKTzfd6Vr7IUDv0zWebbKhx/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5130.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZPBZa/Ruka/MYWMOpoMjLIMxXciHp7JZNdL0fYjW5cKyzBYcN/HLg8Qec873?=
 =?us-ascii?Q?eI703YfRX1XHqiTapWrNA/ju42rZDqJOFyXz/pKjgEM7Ubaoe9cSdlJVYLls?=
 =?us-ascii?Q?KhVCQs3rym6AkVkOSc0OvDPVC/GksioAUVlMlcXeaP6uolL6pMRZe3mePZPs?=
 =?us-ascii?Q?jkI7cTylD/E86JrTZNrmefhGbydv6Bw0ZjX3G3KWzPYsM8O6oa1b4Dzjik17?=
 =?us-ascii?Q?1gm78Cml9JAN5eRN3y67Km5Ycpenk+Jpzj75O9qq8FAbs0ox2vX5DUj25ZRQ?=
 =?us-ascii?Q?wBunp7GOhpjwBIMKiwZ/Tl2YDiOMwT0jgadR4BpnSYLzIRf+Y4FqAEBbSe+P?=
 =?us-ascii?Q?AlLpWglmY2V5w5SN5TzvOmYgFWaNa0UQD+H2Y0/fPxg0cV6qH3HlP5JndhKo?=
 =?us-ascii?Q?8VJ4hk/iww+c6Q5JX0Z0ARbB09Sp6fpT4rATTCrvaxCIAgBQ8RtEHAAGYmh4?=
 =?us-ascii?Q?DYCjOOx2XrU4guXkuOPQCYPFBIJHCxklFaKX8LPxFNPFzfLQJXN5lIhjHCnr?=
 =?us-ascii?Q?s9TPGvHKKfUPNHh345ZgmUvciQabekSenDhMIzFkHk1ABomEnS7Ay/Bq7qcE?=
 =?us-ascii?Q?VEmeOmMuBgbehXHlyqJ0D7ZKErtJNdJjMzJZxIK3mATc4dAqsIflaEmEcZ1l?=
 =?us-ascii?Q?6fmmlUL0SYRPfgo1/JKK8j6TqZbZjrnDYLbt6+m62qjKPrheTAYJsPLKDEaO?=
 =?us-ascii?Q?IwPqkyV/b/kyYvqIld7iVSMhMRyC76sxQJZhYLqKvDLO2iKHWXgHjtvTTNuR?=
 =?us-ascii?Q?yB3dBl/c4rZojXT+q1sR1ilU4mdcqc8fFNc4I13UlyFQzQfn2vSShJToRuyI?=
 =?us-ascii?Q?HtWGu6omVy1/GVMHxhPVOIjUE2mW7er9006TgwmUxfeYbZSIEhOYlvbz9NcY?=
 =?us-ascii?Q?Ap8s2BrS3o50f5Ll6vlOH0ah+GGvX05toTteDNchxu6vlNYIS51qr7kx+BiB?=
 =?us-ascii?Q?fK5rgvQZ1vqWTSwEfnZbFOwP/0m5L6jxuOFbABg7AyBHZLCTlZ8iX2dI5sjU?=
 =?us-ascii?Q?NZEg6GWGEpIT6+822MZ/H9c00HWaiGiMj9U45/kcYiw94YvGp6zOqGbf4oO0?=
 =?us-ascii?Q?4Pmm/xC2EBx4c6/cKlNsxUhSJ94BgWZ/ceaEtpgQfMHip4T5hFw6JKVDHzNS?=
 =?us-ascii?Q?PJeQiwVwGV+xHOi1BF9Ssf7pVmFArBzb7eCHHRNlX4czF2lUdqoSfzWLy6mC?=
 =?us-ascii?Q?RHOgN2A08P8bfBkGAdAI0IeVM8bOWpinOk3Y+4L6Uyr1cSN9x0o6HNXGLP3a?=
 =?us-ascii?Q?pjla03mpr4BvqajhoMDsP9EphKMvujrKUq4nvXkxREiP95OcUuYtj6/4yQpm?=
 =?us-ascii?Q?l7n0nd+MOKteRLWv6Kr8d7zfCRh5ouksMntGANysIe8rxDcx3FloA42BLtPZ?=
 =?us-ascii?Q?io7rg0c650Mw5ozEV0cRZlCcqmzJGlMNBbmy0kodpVUTcgJ/OA3ZzF753r9p?=
 =?us-ascii?Q?8aOL7H/gXMTM2JglViR1iI8O1qVzir6dC61QsLCiHfmTUe3nxYSmZIqBr/I9?=
 =?us-ascii?Q?HtBTcbgwAOvlvLAbqRyCYPyBdD+8P8sX/dZYrRusMfbm+zWrBbbPE5u77x1H?=
 =?us-ascii?Q?QIiuG92qxjrgvqzjesibe2hry9jhW6kh/Uf7upSt00A/8AFiAUPxg3OCmQMw?=
 =?us-ascii?Q?xU6XnMXdC8U/bQv+5+ycyLYyM9Gsq2W+hFgfGEzxI5tlF8H9SfyDEd2uiiNg?=
 =?us-ascii?Q?MFgHff22R9k95lA1JGLMeMEHiifQKQtVwyiz7Xh9ClzPM32GpgxiFDuVeTU8?=
 =?us-ascii?Q?yuImWbgwA1yksfiyNhroEoWLSYQMq4s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88288dd8-e5e2-47c1-5beb-08df1850063a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5130.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:20:09.3579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmqI+jfF7iwebEXh/eHoFk6mLtoD9M+3wAgJVUt/I/NLv1bazyWkAJv/1Fv5ONztoc6V4kUd9aKb0XatchGHZpzIDhkbdNHhOZF3DNf89pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Ye Li <ye.li@nxp.com>

After SPL dcache is enabled on iMX95/94/952, verify image in
authentication meets failure. There are two root causes:
1. Driver read APIs won't flush the image data from dcache to memory,
   such like: USB SDP, ROM API, SPL NOR, etc.
2. iMX95/94/952 uses trampoline buffer to destination address in
   secure memory. This buffer is not flushed.

Flush the image address before verify image to fix the issue

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 common/spl/spl_imx_container.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 57cd75b9b5e..dee0c9006d6 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <cpu_func.h>
 #ifdef CONFIG_AHAB_BOOT
 #include <asm/mach-imx/ahab.h>
 #endif
@@ -77,6 +78,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	}
 
 #ifdef CONFIG_AHAB_BOOT
+	flush_dcache_range((ulong)buf, (ulong)(buf + images[image_index].size - 1));
 	if (ahab_verify_cntr_image(&images[image_index], image_index))
 		return NULL;
 #endif
-- 
2.50.1

