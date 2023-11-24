Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7334C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 19:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97323876DE;
	Fri, 24 Nov 2023 20:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dNjqxdJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CE687652; Fri, 24 Nov 2023 17:35:04 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0747087616
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 17:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.kubik@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH8YKuVew3YnP/P4OpN6OVh2ycBQ06h5hMTOM40tCtk+MDanAXEAowh7qKx0sYWTORvPB8HGUCCHjdisS8FA7Kx/t5SCg0SurOBoz6Nx5gKqgBi63A9OyAxdj3UJ9V8HMnlBE7GZT250gbV8AyAWLKLMbfGdMCtxXUXyzbjOPwKunzXVb4X4HRlWhjRmwyRFH087al+enrpWMyeAR0mSU0ZwqRNqbYBpLruH2G8eNFu0H2I+32f1kPOGlSUbVF4cYETdladJrdsks4tfY2hbU7ACCExoQpEry051Eh/pNu3Y0d/c1gtbbIU2toIXXq2yDuiop8b6JuCdeJn2K8SU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTjIjCqEdOCCYRuKjh5gy8swMTU5QAA/3T3bFtddVjo=;
 b=UxySmLay3OgAmvsXTUyNYfvpfgmjd82ZB0HYWi6IowVlVhNUzPNEhh2Mt0c0Adf6PTfIS/WjmSvhDGqqC8BBQRkCJAcPW+yWj0cx6kkjMfTiB06uc17IqT+rmXWHewUDCaRV3chpCAx5QdG5lUW6iQXY2hiV5bruFLN9YqOQ/pj3xmhSIT0k1deyXQ15wxumbE2urvD9ASb6G1416O902lg35pvzJKZD9Hpzr+yRZduX6TdpScJDuoWxQRNEpaQepigW5Znr3VtK7s149XmQxNEIpoF/Mn0IYd9O8rK8ri+NSrxPi8vILhfFVse/BDayQEUONJqvE+qj1H4pm0bdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTjIjCqEdOCCYRuKjh5gy8swMTU5QAA/3T3bFtddVjo=;
 b=dNjqxdJfDpu3n2bUgw+THKjEnYQqxC1UBm9iKj/XFB44YV1DhAlYbFuTdP6bxW6m9zn+fSbo+CoI54bwKg/S7845fmPOWDZzUMEwwiD561ulaC1jYz8d9MIL9ZgIw0FUTlyFyrT55lGwqbkCOeZ5Vaa8sAkyoSrT8yE0N0GxpeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by DBBPR08MB6043.eurprd08.prod.outlook.com (2603:10a6:10:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 16:34:59 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::f36e:3882:2fce:d775]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::f36e:3882:2fce:d775%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 16:34:59 +0000
From: Piotr Kubik <piotr.kubik@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Piotr Kubik <piotr.kubik@iopsys.eu>,
	sjg@google.com,
	trini@konsulko.com
Subject: [PATCH v2 0/1] bootm: Fix flags used for bootargs string substitution
Date: Fri, 24 Nov 2023 17:30:45 +0100
Message-ID: <cover.1700843096.git.piotr.kubik@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
References: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To AS8PR08MB6806.eurprd08.prod.outlook.com
 (2603:10a6:20b:39b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6806:EE_|DBBPR08MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ae14a9-12c2-4dc6-c84f-08dbed0b4d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMmFWWmqOPvgfcv1BWByNr0N6r2EgrY4uNsd3Ic+GJuYj431vhp+LkvRWBr2D7NwK9p6eWUPgibiEYNaNJpLF8+fZtJeulOgiq5t25B1oswAE7dzPGtiYVqcYoxsiGrO5k/De8uEgoOaPI5YznpYEfEZQmzovqJ5l56oJH4XjvEI9vi5w6E3BymgA4GJgIRQtyfA1C6JE+OihbbvrnhwzEnpn/7n8K+1IMz9wYeNEwQo8GiqaymdxM+E2oDEb3iXFp6ruoEg458EE7N+VXJBKK0LElQ1llmFQrCHXVfISZjUeKWhVq+R6GO5UwqwFjRRtX2WgGbO06EO7rFcs6Qm4fMEM3/i9wTMgaMxUpLmXxoyO2ziheSwlQ9f+yLSj91YTlNQPR6w4uCxUH0cf1AawbHVi5QXVv3olkPqctWIm+sg8A1JD7QW7TSaUBuPbi1krnPf7ZBJExXVaIyR7414Gf/tfph6DtjmC20FChEO86gaXwP1Tqu4/A5KuDLzTccmySaGV/ncudS/7ut6g7jZdAElOclEXuOONNDovk3J6WCbNdWpVqGYuqTonRAsyqoaXfElwqzFtNG3q5cwFe65OeDpZFM1GDoKCaj/mRukSGzy4z2XzylRXO9nYPVXjwus
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6806.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6512007)(83380400001)(26005)(6506007)(52116002)(478600001)(44832011)(8936002)(4326008)(8676002)(41300700001)(5660300002)(6916009)(4744005)(6486002)(2906002)(316002)(66946007)(66476007)(66556008)(86362001)(6666004)(38100700002)(36756003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87jFvja+ghryh/8gD37afnHVFwB1AoAhdSokFxQ/b+vn6SeFp5zACmVy1+SX?=
 =?us-ascii?Q?EcbjOgC8mBiypO/bvDRymKAraC2Gbfgxjq73JJIrPY5PkzjFa/S8bEzmqQkl?=
 =?us-ascii?Q?LfaUPOfKQaJKq4kRF4ozXCVREI22XiES33UMWTGTSX3+CNnKto87JvtNV5sS?=
 =?us-ascii?Q?aihorjtyp/ImZPWBXEYoK+WfjcaZP7nutC2r/UI0++z9KrWtGiJQFU4jI3fK?=
 =?us-ascii?Q?0SUM3562mu3tWtzD2/ZU7fDSUJkKYPnNfl83ROAYdfn5SygZ2/wLeMf524eW?=
 =?us-ascii?Q?GqmckGKnNIbWY1df5uhdvQL9NmXsDi8Cjl2LNZJp52p17oCCV5AzouIbvz82?=
 =?us-ascii?Q?EEL2TAKkaEy+gskCIPKY3mlfHoGBJmxenmmvTJC1A5mUFt/N08Qet8UWU8VX?=
 =?us-ascii?Q?F/AS5AyrJVpBHzfMKknMFlT/7E6p+zdO/ahHhDzf8PMGttLXDXPCK/4rdit6?=
 =?us-ascii?Q?oQiFTViz8GZooJJKCf7s5aZ6kYjr30xYWeFUwI/gFbbAVCErTloP8uy9mELE?=
 =?us-ascii?Q?DUUYAvuV3t42R7rHzjKjd/7oBIk6cwvr+D3AvRNb5zYOfICUmFXAQaTStLR7?=
 =?us-ascii?Q?vZ3vevu2EFplbUXepJJlYTyHiHLxry6VpewM26vwAvR0NpsI59o4hY1734g/?=
 =?us-ascii?Q?Ja2Ylq1EsOy62CiWac5IR0Di6n0Of7CpW5ZnnXVBUdewbmMYMtqXgxuhpQgN?=
 =?us-ascii?Q?L6v6qsMPzRtB+31ULTV0HNfGrQR7mWDnHv0Bad9g2vAqWUWEhxtKGU8r9kL6?=
 =?us-ascii?Q?y7FeZM2wRXQ+HZd5OeCiItGrrvEdE7qUqqDL3E/NXrtqtti7+HNLb/IS3R4h?=
 =?us-ascii?Q?LYNepzVe1w9VcRCgslFLZWwA/xYp3F8j5IyjwbSYkxQADMyQ4/29vfnywbzV?=
 =?us-ascii?Q?yfzrHiqyWE0bGF0cwD3Z6Cju7uAuW7rBn/YFMDHb95YiFNverut3nXqeTDOo?=
 =?us-ascii?Q?JiaaHskeQ8F4OiP9xZ3C+GyjDyncvI5sjtTl7xJxP+qa5HoIP+L1ZOC3Yx7W?=
 =?us-ascii?Q?5yqjPcRLz/KjtVhpJdAGwxTNfoPc7GxbVjQ6jesHnITT/nx3VFm+42LuT7uS?=
 =?us-ascii?Q?ix717+UKEPD0U/OXmcv1pxbDH6hi9UPn0VNXAKtvNrfAOT6d2nLk/PRt5CC5?=
 =?us-ascii?Q?bAcgEM/BgBxjLgRMkUfkSgWSAOKaj82oispcbT4ytnBTBZYZYTXE3sIDq9eV?=
 =?us-ascii?Q?g5oAHpAtoIBB15K8rReXF1YNV9B943vjHWF44L4olISpzivSnSrm2yywKgJt?=
 =?us-ascii?Q?ASXnx/K6QEWu3MVtJ3GS4ntVIrV7Q+YLGNW0m5g9FSXW9kuW/zdsk1h3h3Ev?=
 =?us-ascii?Q?odn2UQpmRskhZhPeB5WHCJmCflWvBnQquT4o37T4eA16uCosMTirGN3s/Pkq?=
 =?us-ascii?Q?wIS1xPkNFFEYmvjTBesxN8yQKmvewt0ZwFQZi299SIgpyY2+/7lbmPlp9scq?=
 =?us-ascii?Q?aKPL6kQDLAl6NIXwPyeaZwN7BrO1GUs1BH2hfcXC5uXMLcpxQJ21kFKF9d4k?=
 =?us-ascii?Q?B/LxSn2BbXTk76uvCWYOtbAWkKLCyaf1QIXJHCw5nMxmOYkz32QLCWlLSyg+?=
 =?us-ascii?Q?6xbHE+4oiWloe4BCaokgoSc906usPaw2lmD8jwzf?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae14a9-12c2-4dc6-c84f-08dbed0b4d0e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6806.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:34:59.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpdF1xv7FcePmIbP09Ryy8Vz7qyWNsGvE5ilBDQSu5SAhZRETx+UdwCvzIw+2MuQ2ePwjMBwkjhWUWB1mVAGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6043
X-Mailman-Approved-At: Fri, 24 Nov 2023 20:59:31 +0100
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

Changes from v1:
 - fix commit message
 - improve code readability 
 - add bootargs substitution test to test_fit.py

Piotr Kubik (1):
  bootm: Fix flags used for bootargs string substitution

 boot/bootm.c              | 6 +++++-
 test/py/tests/test_fit.py | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.43.0

