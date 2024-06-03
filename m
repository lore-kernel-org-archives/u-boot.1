Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E92C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A4A87D1D;
	Mon,  3 Jun 2024 15:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="EAb9O2Bd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFE5881C3; Mon,  3 Jun 2024 15:35:05 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694E087D0A
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKT0HBd8F+hCGZQSiY0W3O8BEsyB6HhUr8K9hUmJeyUIPc9nHs/V+Tefz902Ldcf5RkzTzFCioWry6tWGZi1fKPKPfWhRqY7hGa586BUCcfwQjpmoE9IB5BbLsHXQ2AMiD9GP1YgwHNPraPVbpJVKwvD6bwY5Ut1x3niZDVR+SY5v4uDu80/D68/JvKtYJdwFbzm1nVTBxQwiCs/jfFAwkQZL34dT9dFIxSQw7maDUMgLBPnGS3A2uI3ZGKz2YLXr3L5azad9oGwfndOU7EynEbtTY3hoLTcKnNWljse+Y3iaUnp1ZDAu1pXylGL+wUN8awI3FAHxWDZh7z95z4s0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOdLQWBCh8OZ+DfmZwKGxNxknfCTqDB2n6VN35saj54=;
 b=XqZKCGdDwPPURshsclIeqnxVKsCc+/CYLurZyQ9x2zQQ3cNLLtE8MTQoA5RhaO3FzyrP7Df0nSvffZVjSVOVSiH08HlBL48nNC2yUj8eGS2NfzIwOthyH8xDK0hfCJZJKlItoQg+yeq2YiyNt+U2oYFZ0VTSD1eqmG8oVnEcLe1+Vv6uWLce8z2orly6U7xV6DCfZrW1aNo1+pfulFIct37k3b0dvJocHS6O6GCuBY4Z3/wZLBhflfy3p5SQK/7KcZ7JA0h0/PLnmKyu/0lP2EHDayG9OgLKwmPnB9Cscx9Fp1/PXpIYgO4+2iUIAUpf55Hf95/aWehDmPipo25AjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOdLQWBCh8OZ+DfmZwKGxNxknfCTqDB2n6VN35saj54=;
 b=EAb9O2BdvJyaMOceAsCe8woeTwoDllmGPKyF5KwsKETM1qoS7Zz3wzasrfkRwx3ngIzvXPl0hXGeMEBnE0ok5H430RM9Q0sk4kYb0sOad/nGDlQEj+dya43d/X5fHekM1vjgD8L5uUJ+2Ypl62IFlwXrCajOmhoQqIYYBLrHxhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB7877.eurprd08.prod.outlook.com (2603:10a6:20b:51c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 13:34:55 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:34:55 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/2] Enable reset_cpu() in SPL for ZynqMP
Date: Mon,  3 Jun 2024 15:34:45 +0200
Message-Id: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6af98e-bfc0-4f86-29fe-08dc83d1f4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|52116005|7416005|1800799015|366007|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bYipBrNVtA0S7wLCuKP0TMnVR72ObSu4zhusY1i02BVy1ShBVo1nFQyrJiOy?=
 =?us-ascii?Q?s0moXykrNmE2CM4Yr1fKZZqADUpdGaSGXKaBYXxxBBHxDIvBpQ04Tpl5n+CO?=
 =?us-ascii?Q?jjq58puAndl7F/azDVqL3jk6ZzwlTjeg1//Tt4kSVyn+Vp6YNr+wC3O/ESNu?=
 =?us-ascii?Q?T7f0eX5c96AJ6M8KViEsCEHmNnBf71ofZbNgsS4XSn5FG03JmYfazfJWGq3E?=
 =?us-ascii?Q?DwiudSMlRQywWmRbNe6gp9RxgbGc8T+QpUyrKKjhS6tSsgn9pUGBf2BRDQ1y?=
 =?us-ascii?Q?5iN6yG+2Muwh/JA0yAiSoaXZe/hH52LqCrQbQVSkOauC9cEyyogq3ATs0kFt?=
 =?us-ascii?Q?bF8RQHj+yVN1P6uYt3HVzHQkPHTVZqzEcmZOYUME94nRZJPCdKotEqC1BdCs?=
 =?us-ascii?Q?2vfqkbJLIAzbeuK8QZ239A4Psk0lmnjGZ+CZsq1T8WZlGaP0gitv/F/ZNJvR?=
 =?us-ascii?Q?CqZrUKU0Q6IH+6nstVje8+4suQA7Ziz82663nZpcl8kfAHkpQgTriTuffc6e?=
 =?us-ascii?Q?evI9cBOc/CtnhvzvMFpPLa02Wf7cR7n0NB6M1bfeYgIeIX5NP6VeIMTHlMx1?=
 =?us-ascii?Q?0vVxuRQxLoQjcd+CoEPoeGfbn5KSlji1NV/0s+57tPmmzXAfrCgoRdovhdXD?=
 =?us-ascii?Q?4boAdsYLnbThNDWBx1/eVtcMlFbSg4122oUSVhxWWJC276bWR81FcEC4DUuA?=
 =?us-ascii?Q?WjAWAHWYCPcK5vFnP3hMf5y/PQWbCKSw8lTBsM1G2xTGTgxkhXz/zvdoWXAA?=
 =?us-ascii?Q?sma+cBISTPoD0vZr5YfTsDubhMjS+6NUuUIrw7Pi1YzhS05N/UVaMi/RKVP3?=
 =?us-ascii?Q?T9KmPK+JGl2s7X3Owp+VA2Kky2elc3hW9uh0G5TzRIb33HQl1tFnWcccI7h3?=
 =?us-ascii?Q?WYaEqTtqCu5GRnfEhryYy0ODGvA1FJ0Kg2HUr/CFN00947Y47GjGkGTqkle2?=
 =?us-ascii?Q?laZz+vnhkEJhKjKTjjA5U+Ejhn2o5/ip6q+nRme/JvyaAt56gIhkkyFhWCDF?=
 =?us-ascii?Q?3l6p8mkKj+Lk4trkJru4GJNqFyjzyQmIvFEolv5mqW77Dtikrg3j5jHjAvy0?=
 =?us-ascii?Q?cUvmJpBaOQ0SAcA17DsPtrsfacl6IHbB0no+lY3Hlfp+SVRZfnYv18qzME6S?=
 =?us-ascii?Q?e+eo9n3XYVZL7hsVqS+RNGxqsl1a64g9RBfgUudvBzj5GQS9/lHI697rY1bp?=
 =?us-ascii?Q?mpifuu8WEg9xpwsX1nTYf/T9fJl/3VO34TweVyDo1BGRIUXLwJhQrWu6Eev1?=
 =?us-ascii?Q?W6vxSQ/kyS5gxm5OCHYMx/nop0OwSdcJmuI+Va5QDQQDAO+TKkx1Yf4xdvO/?=
 =?us-ascii?Q?eZaCrguU8otEdolEsD2gz0LsFIPKCQ/t/wx+COSmYxaQ3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(7416005)(1800799015)(366007)(376005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FgDNWUfFnfhxEc2wog64ns1v3P9CCnMmgZapBBO+vJW5jDncEVtAc3z5NsT?=
 =?us-ascii?Q?G+hmmAxJzmdny0oXEQQx3tM+SGPTMDQwFepF+4cOePgNqIkM/oT+EkvHob0T?=
 =?us-ascii?Q?otDa2ZI8+gaHvQiplYxeHvzFySC//w5LP18sNZ91aASxUc5w6mqkS/iyGOP5?=
 =?us-ascii?Q?4MQCq0K/838K8J3u8ZhKFkSfii3+ynldsu+M5/6xO9o1DplVSECu2Flv8tr8?=
 =?us-ascii?Q?d509ll2dWjMddQq86kc0TTmhMoULCpgpdMBmP8zUQuxABbk0I0yyoZdAsB8g?=
 =?us-ascii?Q?4uya127fn1SKfPyz2rWAnkM7Drw5b+XdtD1cMhSxwFESNm/a3UFYOwm8p+qG?=
 =?us-ascii?Q?WS4ulgpWiQjBa6vIWithKQDj2CBTSQx/N0WoC1Cwa4vwqmTPektLtbBjo+Wv?=
 =?us-ascii?Q?qEd2TqJN+mUZOL2ZXrTEXsqcia5vpBYbGV6W+ncyfW7nQnx3d3EPH61ZudkP?=
 =?us-ascii?Q?n8CNGqwVJQQRfTqPGAPgYt7O/uhPdYCaopGYdHksaChAP1crjK/5xCTw6z8f?=
 =?us-ascii?Q?oUCbTUF2LVn9z+HHHMK31Y8pUdWj6IxjvxfEyputkmc7bZH4tRtS6K4ajpuL?=
 =?us-ascii?Q?WRh7OZKoUTQvNQ5c5qemWQaxJ1CWElDkcWf/1Psfv5oYbYpOsal6xHwfYrC0?=
 =?us-ascii?Q?jDeXEAFhnDVtbu5cC5mI83kTg9TXviNUKkMYOWDjhNTHXk2hcPDeJ8pOlHgK?=
 =?us-ascii?Q?R8fbBEaCP8oz7YF1fo+B0cbpgRwCpgzdVrDynEA/4FvEoMwpFvTAt7ooWvll?=
 =?us-ascii?Q?t4duGhm64hGrvcdD6DUXMlYbcIAYqjH6Fc6dpXMvxoujGP77zCMTh9KDzLOf?=
 =?us-ascii?Q?iM93GzBM4ik3aUTIW2LlWsJ1dyad2fXNZuC+UisDMzyVQi9sKiNE9EJRO9Bf?=
 =?us-ascii?Q?rK0vPAc7+lkVCY15gn4woPMdh0cLAING3z3Wn3sPvQrkr7NpkYf7imHe036W?=
 =?us-ascii?Q?36O2eHw+CZvPSeotiJzI7D1wfuW/8XqCJsF4DrOKNK7A9/fahmySWmAyZl6/?=
 =?us-ascii?Q?zI5DAEHL8v/mwkkORYt4vqC9H4gtbH/MAhG/VWv13mMBNDMrMsJVCknvmdj9?=
 =?us-ascii?Q?9Foq5hUkE2CjVmAvJZAgohaHF3KvNS0+0okZNh4QcgVmAPycyEZXjTodq1M1?=
 =?us-ascii?Q?gAJg8FhFTjX4FYDi/Xqs74QI3Cx1fbH37cDiUAXxO/rXfpcHWn3yQO5vJ+Qb?=
 =?us-ascii?Q?6Mqz3WvUAGi4nRj72hxKdkd7zt9pB60HywvAySdPQT/UgJm25myvs1h5yFI0?=
 =?us-ascii?Q?sZSpfbL+ZhZ6bEqd+bd4S8ZLFRalUXc/wSEDwf5xIo+MPkolPCZ7Bh1KX5d3?=
 =?us-ascii?Q?/Mr3FR6iohwBZXGuNmgfBBRXZ9p4fKoqxgQJdVJrCy8CehM74DYHDVKucZKE?=
 =?us-ascii?Q?YQJS6rr1PoEChmHhiKR7hQ3z2rx3tsjuw+CEDK4g//UmuiCfl3s4gMAXNfC9?=
 =?us-ascii?Q?9A8l22/HEzVYqrcNOz4Hrcr93ZnsiMS1z+43c54vqoTO34KYilcYln4CMOn9?=
 =?us-ascii?Q?3JXOT6CvYKsuJA7BTokbs3hTGW7iniJ9VwRu68ev5Z0OboVjlNXWwgwm9jEL?=
 =?us-ascii?Q?AJ/54wtHU5sE1pMtJJokJJ28O1NGAa5URmqSIUaEQQKtEBiF2fdFEoYh56Kw?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6af98e-bfc0-4f86-29fe-08dc83d1f4a9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:34:55.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvClHoTZC9DLT2nPBUprUm7GOUoRmz+h7ZzFJyEYATzJ80K8v88RcwhMyHVesuAWU3UOYP4fUqenOnrT/t7tHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7877
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series enables the CPU reset in the SPL for ZynqMP based platforms.
This only works if CONFIG_SYSRESET is disabled. This is usually the
case since the the regular sysreset requires bl31 firmware to be loaded
in order to hand the sysreset over to PMU firmware. In SPL we can talk
to the PMU firmware directly and request a CPU reset.

The series also introduces SPL_ZYNQMP_FIRMWARE Kconfig symbol in order
to make 'CONFIG_IS_ENABLED()' work in SPL.



Lukas Funke (2):
  arm64: zynqmp: Add 'SPL_ZYNQMP_FIRMWARE' to Kconfig
  xilinx: zynqmp: Enable reset_cpu() in SPL

 arch/arm/mach-zynqmp/Kconfig |  2 +-
 arch/arm/mach-zynqmp/aes.c   |  2 ++
 arch/arm/mach-zynqmp/cpu.c   |  4 ++--
 board/xilinx/zynqmp/zynqmp.c | 13 +++++++++++--
 drivers/firmware/Kconfig     |  5 +++++
 drivers/mmc/zynq_sdhci.c     |  4 ++--
 drivers/pinctrl/Kconfig      |  2 +-
 7 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.30.2

