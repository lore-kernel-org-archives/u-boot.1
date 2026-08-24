Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358D8C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA07B406D2;
	Mon, 24 Aug 2026 13:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6q7iYGzMYsEr; Mon, 24 Aug 2026 13:15:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577299;
	bh=tA4cnIG8yyx013J3uVrpbTyUYBy4HUHcWyDNmTdHMYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bxnY0EgGZ/Ab0T8obxWi6tUy7maJ2SsQqmgCqjodFL6gYWeX2CURveYOV5f+h4//v
	 M6Ze/GnlDVXPcecoeH6LKAbf/3bcR57FdJHOFHBzoKsSicigi/wdGnFG1CiN/I6i5X
	 t/ObBsmAUVZYulI5fFAo//leTkICYenBUHB94ulZ6j0TP8pgMs/roN1LGMp7VyD2cV
	 LNMZYfZYMd24Jh92yHqPC8MOoaZn8QK2L6v9JERCBu0N7o8XC8eYaMrOQqy1rxZ83g
	 70lUCVLqQdblZ/eGSV6VU3SBZTW3Nq+x0RvtBrskcaSLd0SSeaFmRwvFrH0ZXsuMaC
	 l5Tue7oQ6ifMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A34A9406AB;
	Mon, 24 Aug 2026 13:14:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83E14336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A64580BCD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sLSsPKczqtjv for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 10:08:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=S9CBNqUq
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36F8280AAD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1YabO8z94Cngrd4HrGEdhlxW0OulyrvdlPpYZ1KzXdFmd1LJP/+fI1FKY/N5LQHgKuhHLRPMdsxAndmN7UZMhog7UabeVBoSKq/1GV9Kmj7AvhrgJ54WLALMosntJ6pE8008uqHoylHCrkBnsvt0cWTa33PTgwXCiAo3Nn6eUNeMuKKVaeD0Qg9urtwdc1Mq4OQzZGKCmgxwmgNrkSBCQ/g4PNsqucwW4vOXEdnl5yW+c3fCwI3K2au6gyk7XDMJJ3DgwcYmqjdp1ume56vPQ7ZNvZd2lsjz1YKEpTIGU4OJ/f/29YVmT5Wlu/pM6VCDkHOb40F9SBEZWLF6r0ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4cnIG8yyx013J3uVrpbTyUYBy4HUHcWyDNmTdHMYo=;
 b=NtJ8UBHQh8cmAbeThTGQdKXyrFydDkB0DDlGtaros9ShN2mMiUmK6PrXGnlO/JuRXXH4U0K6yyRYVwisy/cnep3hluUIMCEWxqmKndYJ4yaOX9nR1cbB2v9hy/wjKuxAIMguPi5ofJiK0wDe0XWS7pupQTtWJVPK0ifIJPfDPfl72ZDeN6hULhe7iRwoCmJedX4XkwdA9xMu2TzavESrJ5QF6u/libvsMt17WkztN7CWtlyb7huCcZIDPJ8TMpLLbqev9GnR0RnlMrfMEhIbDy4C+TO2ZG0snU3iUE93fj7pkZuuSA8Vr/eL2Dl5fX8ejnFT/ADhz5HJoyq1aXFSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA4cnIG8yyx013J3uVrpbTyUYBy4HUHcWyDNmTdHMYo=;
 b=S9CBNqUq1LyLs2SXtZdTIzLbdGwGY8m2FzDJNZz7d81Qpl/JhRYrXNV5EMuoaEhiT+eK+w/6SnM4er1vAxEioHzZpU3DWTo9YZ61C/GJvUOXoDcDZbyrpbNH+dE4B+eegr90KJV1YQE4piauMLo+P1RYpMEr67w0lFo+cWSnddY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:07:59 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:07:59 +0000
Message-ID: <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
Date: Mon, 24 Aug 2026 12:07:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Allen Martin <amartin@nvidia.com>, Andre Przywara <andre.przywara@arm.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinh.nguyen@intel.com>,
 Dominik Haller <d.haller@phytec.de>, Dzmitry Sankouski
 <dsankouski@gmail.com>, =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>,
 Eugen Hristev <ehristev@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Gilles Talis <gilles.talis@gmail.com>, Green Wan <green.wan@sifive.com>,
 Hans de Goede <hdegoede@redhat.com>, Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Mathew McBride <matt@traverse.com.au>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 "maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>,
 Philip Oberfichtner <pro@denx.de>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Randolph <randolph@andestech.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>,
 Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>,
 Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Stelian Pop <stelian@popies.net>,
 Stephan Gerhold <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>,
 Tony Dinh <mibodhi@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 "open list:P212" <u-boot-amlogic@groups.io>,
 "open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>,
 "open list:phyCORE-AM62ax" <upstream@lists.phytec.de>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 599096be-4418-4215-627d-08df01c7937c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kUGE+q8uD7AA/jEQh98yuJhYqvgHrEqvUNFpbGNvDf9Ot7f3mAk50GKgmR8Xfk0qE2fxkkkaZVWLFEldXMb139d8yeKDDT9PQ2Mt1iFBMl7LjFpTzPhGDoEPTo8Gj+bpKgrBxGFmtc1Rssdrr8QuN5e76RIfocZHhIeu8EDTmtMNTCaNpW7TZWUV6tgYdPJdJCD24AdZnpEtdOrGkfXYoNgqVDCUR3OmI7zL2Wu4X0dHxSaHq6b7Pv3fCoIZykANcEUxJYyFhCF7WdvDTrhQ+kLYG64FvmdPCGMhKMmwAXFgnMUwoJYCXspfbD2xFYFrBq0P3ALGuooEB4FgrlmEWQkDFKX9zG4ZsqNtCvoeIvtwUCpni6UMC8ecR/aoNcj2ksbeHi6BMNQoAT3UebqCRK4ii/8zDQcAgXJSUCXuKisPOrKIFEKT66rkCZuqVcKqSL6a3r/QLs7CiaNs7fk/a6J/AcwN1zklqq0DFxQI5YhMrCLxMCb194lEIKwCCguKJx42rmXaMvvBELLxdnw57FiB6udGsoQLBWD7/Wd/3ZgckIJ1x65b7ZnPcPswQT0+k9fP4zHNF2TAaej8Wmndv51rk/jyOQUJsaRfKpzWQDCU8zX8pg8fZPG5v1Wq2oLyM+94S/OdD9IBYmMa/Nrj/V2wGddrWNLeSrcFKHaRJjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFhV05Gc08rbStCYXVPVTBxd1VneUQ0SFhEZ0ZLZk1DcWg1YkV4SFZvcjR5?=
 =?utf-8?B?TXNZNWZPOENPd1dHSHEvOTh5Zi9GSTRDZkxjb3cyZlR3Qk1nUG5DRDB2bjFN?=
 =?utf-8?B?NkNSYityN1lKUnQ5bTBVZmxhYytVeVZTREhpMWtYbisvZzEvU29KcVpSVHBW?=
 =?utf-8?B?ZXNSRWNGYlQ3cDBndGgrTVBvejUvWVVaZVUrdllNWVlxSGNjdXBDR2xJZzYx?=
 =?utf-8?B?UWpPMFp0TlcwQnNMTVJ2ZUhOR3NrVFlIRFBRNEc0RTZlTGRXQlh4Tmp4a2FK?=
 =?utf-8?B?NTV5d3YyanN2OElOUlRUbVJrMkV5TFJGcWFhaXhZSm80by9MUmxpM041M0FM?=
 =?utf-8?B?SHg4S0w1Rk1uak9KSXB1MmtSbXRaNE9rRXV1QW1HcThpMGYwMGdFcDh0OFNF?=
 =?utf-8?B?b1BMUlNEVmI5bndHNFU5NTFnUld4Y21NYm5tMnNpNnhjVlI4ZkU3UHMwWDhV?=
 =?utf-8?B?aWZUbkFJbFppMDliYXcvZ1duUmgxUVd2aWVXQTF5Qmc5L1pKTHhHaVZKYUdh?=
 =?utf-8?B?R2M0Zlh5RlpXTmtGZWh3YXBnYUN5OXEyWXNMNFVYNk1FQko5VkZGaThFbEpz?=
 =?utf-8?B?MHlRSVBkZnBGaWFJd1VqdWF3TjRUeEczN0VKQVBSSEh2UnJpalo3WWJyOXJ3?=
 =?utf-8?B?eUtmSFJpSjlVcWVrL3hPQkF2bUg1c0VMK3FHQnlSMzF6b3hVaXNKVTdwTkM1?=
 =?utf-8?B?Y2tJYVZ1eHh5dzhST0d1SmcrMFlEM3MrT3hENDgwTjNFakNlSnU0VForMi9L?=
 =?utf-8?B?NWkyalpsT0VDdmVQTmZUREoxOHJ3Vis5YzluaVdqSWc2SlR0SDhseHZ3VEdF?=
 =?utf-8?B?cHlOMWhMRXdDOGJmcExEL2RqRStEVDlaaXJYV1A5NTFSTFRkdVpnRWF6QXM4?=
 =?utf-8?B?T1ZrTTZHUy9TeHR1R3MxWk82Y2Fya2hMRW5GK3FSdTdKWTNBVUhZM2JEUmJ0?=
 =?utf-8?B?T3IxbW0wSDVIdzhYeDdHdVE3OEI2aE9ndWNLSXI5VXp6Nk81RjVzcEZKUFdN?=
 =?utf-8?B?SzU2ZjlnVW1lZGJkUDBuS0pJL3BvMWw1UzN6MUhsZ3I4eGcrUFRiMmR1dGlZ?=
 =?utf-8?B?SFg1aDdTWk5YSjFtcnVKc2t3b0NzOGdQNHZhZXhadkZaZkVpTEVhZTZwSlU2?=
 =?utf-8?B?NkRaWW5HKzE5azNlMFNaUDl2NmoxN3dLc0VLbXplWHA3OE9tVE1FWkowQURo?=
 =?utf-8?B?UXNEKzJVSkFFWHBYYU9HS0VzdU1hSWNJelNXaEdNUmRZSm1nSHJXRXZQTENl?=
 =?utf-8?B?V3BSUDZYWFNyZk9vcjhaZmVDK0xsTTBzb2cwUjJaTk95d1FsKzBrczRsK0hv?=
 =?utf-8?B?Q25tdVlyYlhKenNiYWlCcUUzUDBtbFkzcTg1VzQ0Y3lwZ2ZxRzBuckRFNkQx?=
 =?utf-8?B?VjZBOWcvbXVENUxldm55NVRmSmlHeXN0OGpuNGRXdkFva2pNWWxEM0RrY0lx?=
 =?utf-8?B?bXhvUG44YUJJOEJrd3M3VVRlcUpqVUJFT0c4OUF6S2JLZHlWVmljRGxlVWRF?=
 =?utf-8?B?Z1JSZ2Z4WGd2TlVUaE1ZQ0dQS1J0TE5DanA5NUlRVVU1NU1ER1dnTFFSSndy?=
 =?utf-8?B?ZnNDYWJpRHRKYWdPY3U3aC9NMWtHZDBVdytJdHI1SjIwSlczU0YxMmxZS0k0?=
 =?utf-8?B?Tk4xR25uUnhuQUVxT283aDA3dGNodmg5S1hoQXJ1OWd1MHV3NG9SK3VwL2Q1?=
 =?utf-8?B?RHdUWnRXQndPWGdvd3RNT1M0dTFBNnBNYXVIV2drRGNHRzlnNEJjeHN3QUZI?=
 =?utf-8?B?NEl4M253YTlwZlQ4WDJFQ2hjWFhxRGpNa2drNTN3SXROYU1yeTU0Y3ZVNU9p?=
 =?utf-8?B?MDU5ODROdVlIczhqbGhKbzFLSFppamNva1VpeUVVWGhPa2grWnpkb1U0a1hk?=
 =?utf-8?B?cGpodFpGWDJSaDBpcXhhV2h5RU5vS29Qci9MK1phWjQrK0R3MUFoaWE0aFpT?=
 =?utf-8?B?N0I4dHFOVnp2S1JGaW0yNC9WM1kwQU5zVkg3MVRHRTBTaVZDcnAybGJ1SXFH?=
 =?utf-8?B?WmJUR3lqSm5lUFlJZG9heXdTQ2RJazhIVUIvTEQxMGw4aUpOZmN1dHZyeXJa?=
 =?utf-8?B?dXJ3SVFhNFMxR0ZWOUZVNTV1TGswSjN5dURwMXY1a0ozZklFeHVuV2t1Z0Zr?=
 =?utf-8?B?UGora29JeStsdUFkOG1BekFaUVQzSTVDT0cwQXZiTCtFVHhZVGZmTi9oZHJU?=
 =?utf-8?B?bDZ4WE9qeUtoQ2VYOUJyNVZ6alovU2VpcWxjNGlscVRMaEx2Um5naVpBU3hj?=
 =?utf-8?B?MW14MDY1S2dzbnB6ZEtWQUV5dFBsWVJwRnc3R0pudU54Y2ZEcjlOOWc3MjVm?=
 =?utf-8?B?Q29MU3dsYy84MkZ6cVhOQTFlMVhYeGlETzIvWXd2WmF5Vld2TU42UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599096be-4418-4215-627d-08df01c7937c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:07:59.6052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zc/OVGKWYcuI5/CMSC8zF/72c0SCnRY+SGfkS/QaLtN3ErEzLJR02pEkqY7vzfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
X-Mailman-Approved-At: Mon, 24 Aug 2026 13:14:54 +0000
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



On 8/24/26 11:54, Quentin Schulz wrote:
> Hi Michal,
> 
> On 8/24/26 9:18 AM, Michal Simek wrote:
>> A number of file (F:) entries across the MAINTAINERS files pointed to
>> files or directories which had been renamed or removed over time. Drop
>> these stale references so that every F: entry resolves to an existing
>> path.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> [...]
>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach- 
>> rockchip/rk3576/MAINTAINERS
>> index 79cf9e97f70b..62c3ce765e0d 100644
>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> @@ -13,7 +13,6 @@ F:    configs/nanopi-m5-rk3576_defconfig
>>   NANOPI-R76S-RK3576
>>   M:    Jonas Karlman <jonas@kwiboo.se>
>>   S:    Maintained
>> -F:    arch/arm/dts/rk3576-nanopi-r76s*
> 
> This is a leftover from v1 which had a file there, but we merged the v2. See 
> https://lore.kernel.org/u-boot/20260108143551.4017839-3-jonas@kwiboo.se/ and 
> https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
> 
> For now we don't have U-Boot-specific additions to the upstream DTS for the 
> NanoPi R76S but we could in the future, so having a wildcard like that would 
> allow Jonas to be notified if one ever gets added. So it's not completely 
> useless. No strong opinion on still deleting it or not.

File is there or not. If you add it in future you should extend that fragment 
and that's it.

Thanks,
Michal

