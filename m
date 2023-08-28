Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B336BC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 10:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BA086496;
	Mon, 28 Aug 2023 12:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="049qcdH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE42786456; Mon, 28 Aug 2023 12:25:43 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F3586498
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 12:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO7oZ4Hy8eU4b337Imvx8RiZUcZnCM/oyXwnsHqpHdWj4a4Ri5Mjm3wim/T3cNm69y5bD/Sqxk/HVdSQ7BTbwiY99pgfhRkL00/kb8QgG6S/mS1r/wuqLkGKG0/+7eXLoUMIE5NoCBU2/D/AsR4ULnvnWeH+/oYqDnvKP5RTenIuxk/3joHpGVIP/BznLiVMTkRc1r+EBrFTsshMwVCEVC3E9yEbyUYIBdmWPQawznHzXITTuoB3JC+urIV83IYrx95MkI5B5yARnoxGDc0XBsaFEmrGqxRyVv+2wygH6V6lO5mV2jh33tjaRxf7DsyWEW17EyILgIpU763jrpEcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buyxdODgvz/hBrSoA6yrIuP8soUJb1flIoe8aqi/WEA=;
 b=ewEAa5C8TvhhyBsebnnfccZnwciSH9OdIdCsBCx9SO8V4ymzrjEfJRix1hdCr1UUg4X0WnRNZptzmL85nbUMnlvErlDiU/WWuH5CCS1MzsWhad4bzetPpqkvSSlXep82iipIoLMvIPB/jdQyVmlhfLEHCbs4ftEFeTP1Oe41up+nA0IRFTPMww/kjyorGsUl0rgh2qYxDAGYuQlrKfjuzTOKUkWmoxrAOGnx3cpscK8uLpI9S38i7Ak06G0xkCRKHzRj8YAFWmqAB3SstcwgUAqcqAcKn+nCtqJ2M8FUBKzDEih2jTcHOd3NZRBYIy6aGA+yShQ99utK7hv+5KkS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buyxdODgvz/hBrSoA6yrIuP8soUJb1flIoe8aqi/WEA=;
 b=049qcdH11gs0fO7b+KW3W34L+G/evFswyezXfYbkm+B1+PACAOH8GwMFNRiUTIzSRM7WgJFLagVKTp5SO4sI2GVrP0jxQkNQUD2GJpYcaHWdeIrKM0cUeK6Mm09QZWIiWxeqSEqQQ587OkpLsUKKioRIW1b0ZuAlx1TQuR572Zk=
Received: from PH8PR05CA0014.namprd05.prod.outlook.com (2603:10b6:510:2cc::7)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:25:37 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::a3) by PH8PR05CA0014.outlook.office365.com
 (2603:10b6:510:2cc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Mon, 28 Aug 2023 10:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 10:25:37 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 05:25:34 -0500
Message-ID: <3d815d7d-a091-6f58-9d3d-c65e9eac8f41@amd.com>
Date: Mon, 28 Aug 2023 12:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <seanga2@gmail.com>, <git@amd.com>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
 <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
 <20230825143959.GH3953269@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
In-Reply-To: <20230825143959.GH3953269@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 124daf40-4512-48db-ad2a-08dba7b11edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyLD5ctROAmx9ny/XGzrdwFaZBILsMraQG691mgejq+dPDH4qY9w9cEOxYeqTCcbnPeSr5NcWR5i7f/eGL+28/3akeel7cPMOb1VCQ5OVb/7PiA0Kj6zY0eEfc1YZdQKn4lY4IY4S4leHLgmR9g1C8kjmcVSQcWP5uF+94OMAiMd5T69MaOM2QM+7agiYgeQJerSn5lePAbjoyKn5TtIwLZHh1kbTxRqmEnqaEravrkT9OBUMs/4aIMbhZnIFMq1cinR7GZ2ZYMs99VdrTMSksW+hTYgXPganG7pVjp/3i3arSuwQtxSObzF6uw123L8PURfaVOmB7lAcBAlkwEmlqyIofb5ro9zi++ZVgAhzXsMyT77vRz1l9Jsfe/XzsRUQ/S5D5cWTK9g0ThPuC2c+ZNT3Zh/ibElLO1dOFntrvHuEp/V9wQ7zUZA6y7q3jZRr9icMf0qShm0AQ0orXGJ4WHBSSZgePnFxS3v68kp+jd+qLfHLtYZy4h5roZTeP8QMewI/34xWiHwRF+1OaL4yaJ3en1k3t5wkaklZYo48FEPeRAGK38SDW+L1NyoPiEU5IgDHNwMWzIIttrpqDH1+NJ8ed/dRyEXzvmYAqDsGFBF+K5ilB6tD/cm+ScgjhXdsYQi6GQXU7kyIzkT+6+qxsX9w74QXbNYUX+kJdAQy8dsImDhfnVA7Y5XsEDzmzIvabbH+iLO3kBepF3MFCK5nLG2fW99CLahfwdmGhXH+0UMWmqoQULg9OBXEDB6apsIRcWk283IEIYXrxdsEMX0K1GDTo6dErvf7zT8NQ7AJUKyUF25F+fKHeJFuV9qE81kYDrgsSG4F2qyfIMUrpzqEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(31696002)(6666004)(53546011)(2616005)(40480700001)(40460700003)(2906002)(36756003)(5660300002)(86362001)(44832011)(54906003)(316002)(70586007)(4326008)(8676002)(8936002)(41300700001)(70206006)(6916009)(16576012)(82740400003)(81166007)(356005)(478600001)(83380400001)(36860700001)(47076005)(31686004)(26005)(16526019)(336012)(426003)(192303002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:25:37.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124daf40-4512-48db-ad2a-08dba7b11edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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



On 8/25/23 16:39, Tom Rini wrote:
> On Fri, Aug 25, 2023 at 09:15:09AM +0200, Michal Simek wrote:
>> Hi Tom,
>>
>> On 7/11/23 11:51, Ashok Reddy Soma wrote:
>>> There is a chance that assigned-clock-rates is given and assigned-clocks
>>> could be empty. Dont return error in that case, because the probe of the
>>> corresponding driver will not be called at all if this fails.
>>> Better to continue to look for it and return 0.
>>>
>>> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>> ---
>>>
>>>    drivers/clk/clk-uclass.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>> index dc3e9d6a26..f186fcbcdb 100644
>>> --- a/drivers/clk/clk-uclass.c
>>> +++ b/drivers/clk/clk-uclass.c
>>> @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *dev,
>>>    			dev_dbg(dev,
>>>    				"could not get assigned clock %d (err = %d)\n",
>>>    				index, ret);
>>> -			continue;
>>> +			/* Skip if it is empty */
>>> +			if (ret == -ENOENT) {
>>> +				ret = 0;
>>> +				continue;
>>> +			}
>>> +
>>> +			return ret;
>>>    		}
>>>    		/* This is clk provider device trying to program itself
>>
>> What's your take on this one?  I didn't get reply from Sean.
> 
> I guess, what's the validated upstream dts where this is the case?
> 

It was found by incorrect DT. It means I don't think there is any DT which 
contains this issue.
But that being said we can extend current clock tests to cover this case.
Please look below.

Thanks,
Michal

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ff9f9222e6f9..0f9bedc0065c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -589,6 +589,16 @@
                 clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
         };

+       clk-test2 {
+               compatible = "sandbox,clk-test";
+               assigned-clock-rates = <321>;
+       };
+
+       clk-test3 {
+               compatible = "sandbox,clk-test";
+               assigned-clocks = <&clk_sandbox 1>;
+       };
+
         ccf: clk-ccf {
                 compatible = "sandbox,clk-ccf";
         };
diff --git a/test/dm/clk.c b/test/dm/clk.c
index f48de05436bf..71ae32eaff50 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -36,6 +36,12 @@ static int dm_test_clk_base(struct unit_test_state *uts)
         ut_asserteq(clk_is_match(&clk_method1, &clk_method2), true);
         ut_asserteq(clk_method1.id, clk_method2.id);

+       ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test2", &dev));
+       ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
+
+       ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test3", &dev));
+       ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
+
         return 0;
  }

