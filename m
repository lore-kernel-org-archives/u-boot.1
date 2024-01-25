Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B8C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 19:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BD587889;
	Thu, 25 Jan 2024 20:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="JKl3kTBP";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="JKl3kTBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9D087B6C; Thu, 25 Jan 2024 20:51:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05hn2205.outbound.protection.outlook.com [52.100.175.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B4D878C9
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 20:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=YR2L+OpGPnUAdmKL0fZhjZz29X/c/hgdz41klOisIrOlFmiY/+vAZ3VqgbPSK+Kwfm2qfg+g3eFxKg+bEAlx+ZcjT8YR3Ze6r6vGArVLig7Bu5EKJeORBKWt/vfcRIKZZn+pt8arqpexTrI6I6Tg7NJOjDmxFfZWCkO1FinnC6NkwzcFoY3dMddTQwV57iuJ93kJiO3GBzahhniJ6V/exWGFTSc7KXqKFqqrbIDcCU7InGcYo2SFzZG69QRTh2jdgYkIVWfvdqzGkIk+JP79INSAavV1TosRwvI1p/SaJonE33a7rU8lrqwjO+jeKCxhooa3HHCyVKwwDrufirxwog==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pdL7EsNkxIXQC+JnKGNXJLg6UsVew2aDD3zBSDLKkQ=;
 b=kLEPa8r9GV+6Zh7TOGCI+CMdKRXfQkugTuPnDImmeJTuA1dbogq0+GyOJMsIoe5mKVOvbFD84LujhxNrIAVPnI8qA1eh05XG4Exlrpc73X2TNkbYsbQAmeoEv259LOPoxUq48c44Wus1bvARBd6iGF5U7m3wkvAqnb0tTb/vOySs1vXCm05qEIr3iAiEFKCzTz4uPkU7kya33Swt3iEBux99D0lVf2mezUSxG5SjiKrymsWazKVL78rHf4yy3E8vqXGzM6oEzgeL323nL+dNl/WKs/Ba81mUNsKv6RaidhBtySjHNiOWE3SWJLdgfH+J+0qUzloxNk4rqswcz8R9oQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=conclusive.pl smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pdL7EsNkxIXQC+JnKGNXJLg6UsVew2aDD3zBSDLKkQ=;
 b=JKl3kTBPKHkZP7ti5VYifzobq6GHExvryOSJkm/q4ZhqZ0rGH3i3V5gLFGuVS70RWacAbstajaKf4U8uPv2YbHbBASGstwZNMasyU9aUaK0nB2zAA4sF4OICRWE86wugXPosRlL5LA+dGxyBKar+xZpFyTdFlmgJmP6dQj+lNxTapodQrynzdQu/+zvoH/zOO5Od9JCIm52fVRLMt3S3bLnfVCXHWReN6c4QgPPju8LwtIDLEbsWJDLMDw5OkUS5aPRa/Yu0GkRh95tYW8Qr5+7LcW/8rt/4cIJ+bdPCohdi8eFiPOmLhCrAW/ojvIPpmyFLfnedGuA876qJz1246w==
Received: from AS9PR05CA0352.eurprd05.prod.outlook.com (2603:10a6:20b:490::29)
 by PA4PR03MB7039.eurprd03.prod.outlook.com (2603:10a6:102:ef::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 19:51:18 +0000
Received: from AM6EUR05FT025.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:490:cafe::39) by AS9PR05CA0352.outlook.office365.com
 (2603:10a6:20b:490::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 19:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM6EUR05FT025.mail.protection.outlook.com (10.233.240.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22 via Frontend Transport; Thu, 25 Jan 2024 19:51:18 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 4DADB20083980; Thu, 25 Jan 2024 19:51:18 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 270DB2008006F; 
 Thu, 25 Jan 2024 19:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGci+xM2xOqmhfS2U/HQpMRjR18v2WbpoemQj/HX6hHig88jc7X/LRhWagPrOoKT2YHtK2PY/JrGy46IcHIzwLCkaniYeYnpyt9JmN6bW12PJOXfZo6D42Zl9PQBFu7ycfwIvnltnc3a5iEIIRw2CKgsUg9LsnpPAeJCJOi+4MyXfHPJZG37xBUBVbLScI1CGDJH8q6jKcTEeRpmS874X7ohTxxIUSsV1GT0PKK7nj+h70wA3JBCL8TsA4Iogp0Ms/hSc3IuHilwlZ9NcdkA00qGUmrANB0Yz8sYB1apjhNUVfExtuF2E7ozBgBttwlvllvPkDA0gxPqkaY9ERyeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pdL7EsNkxIXQC+JnKGNXJLg6UsVew2aDD3zBSDLKkQ=;
 b=oRpWam8gVqHrvLXJOTY6A/EfHrNGkBw8GrpYfsxBFzMBHiQW5z3f632/CqvRxnuXU6nA44HX9Ygu+QwvlzpMYaRgR3CN/7A42K05pCwOrCQGgSv++kb4uSScodh6pxLrqdYGq+5TlgrgOVjs2LqEIoh9V9ox17C7TEwHCH8e5nx91QE3+DKgdA6QpLevLlA3+925112fohQcSYrSTiy3uq2Yzx7gpmEPoZHhn7zWk+I43CBwMaIvuaS3JfouEzIOu7j56btM0pmZABNqslvSdtinNwBYnwuI28bO+hP1aZUzhfCgb7mwC4cHlAEKPrVQq1hEebRLHIYSgsdyGSVwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pdL7EsNkxIXQC+JnKGNXJLg6UsVew2aDD3zBSDLKkQ=;
 b=JKl3kTBPKHkZP7ti5VYifzobq6GHExvryOSJkm/q4ZhqZ0rGH3i3V5gLFGuVS70RWacAbstajaKf4U8uPv2YbHbBASGstwZNMasyU9aUaK0nB2zAA4sF4OICRWE86wugXPosRlL5LA+dGxyBKar+xZpFyTdFlmgJmP6dQj+lNxTapodQrynzdQu/+zvoH/zOO5Od9JCIm52fVRLMt3S3bLnfVCXHWReN6c4QgPPju8LwtIDLEbsWJDLMDw5OkUS5aPRa/Yu0GkRh95tYW8Qr5+7LcW/8rt/4cIJ+bdPCohdi8eFiPOmLhCrAW/ojvIPpmyFLfnedGuA876qJz1246w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB8199.eurprd03.prod.outlook.com (2603:10a6:102:26c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.42; Thu, 25 Jan
 2024 19:51:11 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 19:51:11 +0000
Message-ID: <654de45a-ca70-4aad-916d-eb667d4ccdc3@seco.com>
Date: Thu, 25 Jan 2024 14:51:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Add support for LED configuration
Content-Language: en-US
To: Artur Rojek <artur@conclusive.pl>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jakub Klama <jakub@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
References: <20231130203919.757-1-artur@conclusive.pl>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231130203919.757-1-artur@conclusive.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB8199:EE_|AM6EUR05FT025:EE_|PA4PR03MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 599e0d68-425c-410c-1baa-08dc1ddeff69
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KQBslufE4L8g5VXmGxctqmllWNDpSjD729Gtnx/+tOVqIOJkSOoTFZeJPbkLjjCbV7K5wXHfYYvdNymCX1xEW4fb6erhA7zthVRm/MQthKCLWw0yRoZas35pDIbXPIDeId79tEybQrYoQ4AQB5TfeL7YSFwboSRTIFOaMOgCU9PNRZOJ2HvN1JUfdvInhhyhmlmED+Xhnw5SMY2i4TZFAdvYMrc97A540vdEBIEF1upkgzlP5LClu75s7HHv3VntAPqJpBDNYl53s7xTqalYZevyHjFmGkg5Tk5O+LtxEBWFg1FJrzHzR8SHsKZH7D+cc84SG3tSul6ooqH9PzDq4HO2kOxXpuF5PLQyjxNBWyK3VZCIxaPpfahoIjzMXdoHQWqV/pJxKoyATr9hMxMK/YsZew46YUxED+Ec6vZSMkoFCuq45GM+TPqxLzSF4JtwjqbK/YbEA00QzNvIp8L0VdQ8lRH5DsbqTox0ik0qBhlojGFUwiClRA/uhI0PlQK5B7zLkMd+S5lEzWdIf1kENQ3FpeUDOjd56+oowwkkacEi1ACJWSMBhAVwJpvu8llWYlYURbbSvfnJvZsnn4jKKwBt0DEzmfuSMkEdp+v4yqP0z7mZpfZsj17s6/bEjoRy5fs3mJrFa2eHcaY0LknJNqq+Jv9BkmypGIAHDutdII8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39850400004)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(2616005)(52116002)(26005)(53546011)(6506007)(6512007)(83380400001)(4326008)(8676002)(8936002)(44832011)(966005)(6486002)(478600001)(66946007)(66476007)(316002)(66556008)(54906003)(6666004)(110136005)(31696002)(86362001)(38100700002)(31686004)(38350700005)(5660300002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8199
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT025.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d3b17c3d-bb66-49e1-ba32-08dc1ddefb2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m6gWWUMc9cIf6vrRf+KzK9ukuiLfQh+TggWiXnOvkij0PwPui+hHsr5rsG9zbrcxRcBibLbgRl04v6lUZlPLSDScCxv7Czm1mScRWcv2h6+dAefzsdZfgQUfWFDrBzsYvxD6FZe6YMj4DV4zBTm3pgd7kZ7Yj0feqESIZUewtTZiA3lOdsw1kwc07wdZLR4QjQak7xQYCfoYljtnh9yVme5vA/B+Emh31Ln8KucGy/D9/qFyq5TOMyINbAzajRGinaHwtR67iPvC7+NSO5ba5NNEvHwm3M8erFTz91KybYytPKwyCmsymGhIoRytnA7JTDdnx84uXNBAEWj7MqAdK95ejjZzwSWzpv1Bhxm5lKiNwThXxGn/3f0j/RvxKuHAdM5UHDm0yuao1dnimQYuFgCOQZnJN5E3la1G30n+WeqAqXwVh43dBcjQCC1O/4VOubGa70HI7GobEGsCT6pYVLoCw+0lwqb7bLMeqxeEhzsuuo1W+sIzpl0ydfVuBwA/0SwV7rE50euQK/DcYFTZYbxMFFJehyFJf0RyDvx3lKMglT3H1ZqKjXiWjNTOMhs/ZBbXN5QrgYb8B8W5URyg6W43j/oCzq5N75xhcinRD+b0EVBLKmbOPdWzQEEkTj9aU2ssTmq4AV2c/9tCX0t6CgBGkXNJRMfJ/Vl4pg5/3eFqDlc+o4K2z6/2HEQJ59dTWfMiObp9Zt6tXVDJGilBGHYfrMMiMbtWUj5G249wH6SFgr6EVyPyyES0aw7a3mxqV/Gf98+nCoFoWLWQvkfzxpFU+gs2xw2jITTryLChq1sElHkTwd8Qq+CXzaR0hlD
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(39850400004)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(5400799018)(186009)(36840700001)(40470700004)(46966006)(31686004)(40460700003)(40480700001)(66899024)(83380400001)(41300700001)(31696002)(356005)(86362001)(36756003)(82740400003)(34020700004)(26005)(47076005)(2616005)(44832011)(336012)(6512007)(6486002)(6506007)(36860700001)(2906002)(7596003)(966005)(478600001)(316002)(70206006)(110136005)(70586007)(7636003)(4326008)(53546011)(54906003)(6666004)(8676002)(5660300002)(8936002)(43740500002)(12100799054);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 19:51:18.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599e0d68-425c-410c-1baa-08dc1ddeff69
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT025.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7039
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

Hi Artur/Jakub,

On 11/30/23 15:39, Artur Rojek wrote:
> From: Jakub Klama <jakub@conclusive.pl>
> 
> Introduce an ability to configure LED and Fiber LEDs found in RTL8211F
> PHYs. This is achieved through two optional Device Tree properties:
> * rtl,lcr  for LED control
> * rtl,flcr for Fiber LED control

The Linux netdev maintainers do not like this sort of LED binding (see
e.g. [1] for reasoning). They would prefer that PHY drivers use an
LED-subsystem-style binding for LEDS [2]. So I can't see this sort of
binding being accepted in Linux.

Unfortunately, U-Boot's LED support is a much more primitive than
Linux's. In particular, there is no comprehensive trigger system like in
Linux. So this would be a lot more work than your initial patch.

In Linux, LEDs are configured by userspace, but in U-Boot there really
isn't a userspace to do this. So I think maybe we need a u-boot,trigger
(like linux,default-trigger) to determine the blink mode. This would
need to be more expressive than Linux's.

Ideally there would be a way for LED triggers to hook into the net
send/receive functions. But I think it is probably fine for any initial
attempt to just parse a Linux-style binding and configure hardware
control.

Alternatively, you can just write these registers in board code, which
is not ideal but which is what everyone does anyway...

--Sean

[1] https://lpc.events/event/17/contributions/1604/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-phy.yaml#n206

> Signed-off-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>  drivers/net/phy/realtek.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 396cac76d6..d078f41bee 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -59,6 +59,7 @@
>  #define MIIM_RTL8211F_TX_DELAY		0x100
>  #define MIIM_RTL8211F_RX_DELAY		0x8
>  #define MIIM_RTL8211F_LCR		0x10
> +#define MIIM_RTL8211F_FLCR		0x12
>  
>  #define RTL8201F_RMSR			0x10
>  
> @@ -220,6 +221,8 @@ default_delay:
>  
>  static int rtl8211f_config(struct phy_device *phydev)
>  {
> +	ofnode node = phy_get_ofnode(phydev);
> +	u32 lcr, flcr;
>  	u16 reg;
>  
>  	if (phydev->flags & PHY_RTL8211F_FORCE_EEE_RXC_ON) {
> @@ -254,14 +257,17 @@ static int rtl8211f_config(struct phy_device *phydev)
>  		reg &= ~MIIM_RTL8211F_RX_DELAY;
>  	phy_write(phydev, MDIO_DEVAD_NONE, 0x15, reg);
>  
> -	/* restore to default page 0 */
> -	phy_write(phydev, MDIO_DEVAD_NONE,
> -		  MIIM_RTL8211F_PAGE_SELECT, 0x0);
> -
> -	/* Set green LED for Link, yellow LED for Active */
>  	phy_write(phydev, MDIO_DEVAD_NONE,
>  		  MIIM_RTL8211F_PAGE_SELECT, 0xd04);
> -	phy_write(phydev, MDIO_DEVAD_NONE, 0x10, 0x617f);
> +
> +	if (ofnode_valid(node) && !ofnode_read_u32(node, "rtl,lcr", &lcr))
> +		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_LCR, lcr);
> +	else /* Set green LED for Link, yellow LED for Active */
> +		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_LCR, 0x617f);
> +
> +	if (ofnode_valid(node) && !ofnode_read_u32(node, "rtl,flcr", &flcr))
> +		phy_write(phydev, MDIO_DEVAD_NONE, MIIM_RTL8211F_FLCR, flcr);
> +
>  	phy_write(phydev, MDIO_DEVAD_NONE,
>  		  MIIM_RTL8211F_PAGE_SELECT, 0x0);
>  
