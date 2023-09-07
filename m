Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B5CCF9F4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D00867F6;
	Thu,  7 Sep 2023 13:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdGX7EgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B246867F6; Thu,  7 Sep 2023 13:23:08 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5788A8685B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Bi0bHEdqNXu+/PKJyMJMxRFZd8mm9V9kuxkfq6SabiuFcOy9Ub/LDOCtO7IkFOy1NKRjYOVh+J0n01dGx4zD7zfD0GChe8eifRHZdXxgnJbKxIBfei/HJsY6teAfI5bZZE8eQntlQAvH75uXYQ18kGP21d3JQOzNGTb+th+b00/uQpiXn+Ud3x3kBzRnyVRAALTbQYgD6kieU0lKr860lD+5x/i0z/w5+kWcrJvUSPWEuUvehtZ3R/OBME1cs/T9VGzHE08grSRDLYkicx9BaovFgTWjuVidfMOgKkmoKNedCCYMzYGux3KV/ZZtZqq12MWr/MUfpks57Og4/oCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfMzp0fRL6Trn6yRpRz+Me+1/qGXhRCaxAjYpXBqCVU=;
 b=DRFZ4xEcRbB/LkPlMNs6Pj4lg30aVLt0qH8Sq744/1qAj3RpuzbFaDCW7lSMziwfAq/Xw6BKuwGlbvHT5KS877KOv6ydjn9Yr+8Vn41H673fn0PUBpUe950HhztO/RMtbSXgdx1gdMJJjDybcVDIk4DZZGJVqKo4ghOT+0Wgb4j6zBj4AuEh8I5D58+GSuT5tADn10msEPYQ82W7zl5TasJjo841NmZut67hNGs775ykhxEvBnksJXz15Q6tTN4O5SiYeuGR9IJt2qZ9hihvFQ2b6i6Y816MCAY8q+kpmvnilJj46HCqzobyA6pjpmQVRLmuVtunqxj+TtT0Vr08nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfMzp0fRL6Trn6yRpRz+Me+1/qGXhRCaxAjYpXBqCVU=;
 b=RdGX7EgQpkLtTpqVMFmzqMDdfuF6fgfP87oa0OYKH7ejlcB1nNAZ+IFo1oDDWr5r6JPz3Iq2FfUfWSjP+rqufK9CnpTjw7UPKpAUy/2HM9SL8pzQiH2St5InONTNrYzdr/v8LaclFBMgIXa812/nTB7oORJcPT3Y48KwIiE9EFQ=
Received: from SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::18)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:23:01 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::8b) by SA1P222CA0018.outlook.office365.com
 (2603:10b6:806:22c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 11:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 11:23:00 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 06:22:58 -0500
Message-ID: <09500ec1-b9ca-ccf1-1806-243dda59c3f3@amd.com>
Date: Thu, 7 Sep 2023 13:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] clk: Dont return error when assigned-clocks is empty
 or missing
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini
 <trini@konsulko.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>, Nikhil M Jain
 <n-jain1@ti.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>
References: <a9a9d853e0ac396cd9b3577cce26279a75765711.1693384296.git.michal.simek@amd.com>
In-Reply-To: <a9a9d853e0ac396cd9b3577cce26279a75765711.1693384296.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a089c98-d4d0-4e3e-f6f1-08dbaf94cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyWmydIA8uiMTvjLss6YFLq5kGTHZUArFsTjzdmubgDFt6Ql21QM1Y1Vv0bAqDOXh+yL0juvdZzewz+nAqpHKdf7x2aVFziwVPSOfIvKkxHgM5kXytbbIk/T5Gkx+NPZ0ttaGoWFveQ0AqUMNfEinbqVsLu002K64lSq+yVUX9nNhyUq75wRM4qFMub85uZ+AY+jQ7G6K8EkSUKBPKX10CMJxZl6WW9PWWHn67ZeMqm5eOTk/M2bONcUOVnDntGs5oMw2+zajN7yFIHqVDcE6NnvGKwqOlReZVHXcwymcrX4IUA3LyCkUtRw3z6ATzAB/ov+A5mRoTPXqatFyQ2e1U33dgg9DgV/qG2qmU3aTJaVpSDKuQjWFyXAqRoZud/Ws+lqN1BxdtN4PW1SkAxNZ5NAsTId+gbltYGkMlxuTqP9yJlWCWhaqwIFULnwzAX+2fwa29mSO1dHfaJofSDWR46bWvoCHmNAuMfKFx2ytUDsGnrTGpPrHpCCsOoMh58i5SvXdcI0QDNetR0PCWDrGj+EfAaJ27J1lib1F1aAQozYCxT86VIScNvUwMwIvvoYaqWve9F0vEk+zVd9ygQFvmz9LXA3ZlgmrCIzMAgA7t+3Z7ARrwJNBkw5BSyGWQf+OK/b36wbDnm1q9f18nxtAeOO5lzHIf1RD7Llp93RD8o+cOE4pxGFGsjrEj/lY+6RAopV3BhL5MOFTQetkzYMKoT8yb1hs8cSuGshyi6lj/v8FtpRyMwY9VrBEgKIa2Ds1Ri175g56cwGz4e8h/AokSmckC+Mne4IgNN1zZixUR/ak7AQGZdtk1Imd6X1vKEZ5Oxy9U59ZUPhXxXqSzePmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(31686004)(36756003)(316002)(2906002)(41300700001)(40460700003)(82740400003)(31696002)(86362001)(40480700001)(356005)(81166007)(44832011)(5660300002)(2616005)(36860700001)(426003)(8936002)(4326008)(8676002)(47076005)(83380400001)(26005)(53546011)(16526019)(336012)(6666004)(54906003)(478600001)(70206006)(16576012)(70586007)(110136005)(192303002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:23:00.7531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a089c98-d4d0-4e3e-f6f1-08dbaf94cb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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



On 8/30/23 10:31, Michal Simek wrote:
> From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> 
> There is a chance that assigned-clock-rates is given and assigned-clocks
> could be empty. Dont return error in that case, because the probe of the
> corresponding driver will not be called at all if this fails.
> Better to continue to look for it and return 0.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> 
> Changes in v2:
> - Add also test to cover it
> - Add Tom's reviewed-by line
> 
>   arch/sandbox/dts/test.dts | 16 ++++++++++++++++
>   drivers/clk/clk-uclass.c  |  8 +++++++-
>   test/dm/clk.c             |  9 +++++++++
>   3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index ff9f9222e6f9..90f876ac9c78 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -589,6 +589,22 @@
>   		clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
>   	};
>   
> +	clk-test2 {
> +		compatible = "sandbox,clk-test";
> +		assigned-clock-rates = <321>;
> +	};
> +
> +	clk-test3 {
> +		compatible = "sandbox,clk-test";
> +		assigned-clocks = <&clk_sandbox 1>;
> +	};
> +
> +	clk-test4 {
> +		compatible = "sandbox,clk-test";
> +		assigned-clock-rates = <654>, <321>;
> +		assigned-clocks = <&clk_sandbox 1>;
> +	};
> +
>   	ccf: clk-ccf {
>   		compatible = "sandbox,clk-ccf";
>   	};
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a2615..f186fcbcdb86 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *dev,
>   			dev_dbg(dev,
>   				"could not get assigned clock %d (err = %d)\n",
>   				index, ret);
> -			continue;
> +			/* Skip if it is empty */
> +			if (ret == -ENOENT) {
> +				ret = 0;
> +				continue;
> +			}
> +
> +			return ret;
>   		}
>   
>   		/* This is clk provider device trying to program itself
> diff --git a/test/dm/clk.c b/test/dm/clk.c
> index f48de05436bf..01417fbd8257 100644
> --- a/test/dm/clk.c
> +++ b/test/dm/clk.c
> @@ -36,6 +36,15 @@ static int dm_test_clk_base(struct unit_test_state *uts)
>   	ut_asserteq(clk_is_match(&clk_method1, &clk_method2), true);
>   	ut_asserteq(clk_method1.id, clk_method2.id);
>   
> +	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test2", &dev));
> +	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
> +
> +	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test3", &dev));
> +	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
> +
> +	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test4", &dev));
> +	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
> +
>   	return 0;
>   }
>   

Applied.
M
