Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C29C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12CC4405FA;
	Mon, 24 Aug 2026 13:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YJb1AmC3-4b; Mon, 24 Aug 2026 13:15:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577302;
	bh=NppZK+oPP+XQR+WB2wkjWiBPQyhl6zSP8nSN511MAbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XyhgwWMsNIifmJ4rP6yVYZeTiB8RNZqUha/jlanHUsFiGDQ/BtQxiueZ+2OpFRVEK
	 e9zU8lXrBog2UTaEwWxkabMRY9Q8FUiCI8myJZheme944aHh872sc2+47oGUjpTgyD
	 m+eyIuZVOjXGgdboG7gwaa80jFMJIodLR2YwajQNhMmkeB00lzUUoIu/nzkERGOQXJ
	 JJFoYSJXSrug0JYdepn6xbwdnhIA+IkEmmiZCoYkHU/4r1DivQQ4hYATCogp4i44eI
	 b/wQeq/D++dfJc1fOmLkk9+wJar2uwnIm+cZhsjuFE/SoAK2oANvM54GjBbopAbWL2
	 kLdr5q55ff8/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76231406AB;
	Mon, 24 Aug 2026 13:15:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DF413AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FC8E60617
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVOM1OYLB5gO for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 10:15:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ADLgWOHD
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBF726060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jis4lmTMCG/6vVExKNlzVPInPlUKE5K4LDUSPanrTOLxafK8iQltP/aCkPA85oVI9WJlJnF5bkOFsaQhd5swPAoNbyULMzQfgjxDlr8Sm9keMlxWOww6Kd6ms9+tqTQcB9xv1sErR014vjukFBukr3GjZtA8owiaiWl70U9H1K3lUkXY9Wch1i6ym7PI3AWF7G+9rCh2KA83au5y9VVnTtKuot+HfkcVA5UlLQXXmrq1m0jRqHEP4DBdmPsHS9QZxect90M4WrH2Rql0ZJxrziHkrgmIduo8WokcgPDcECcF4XuOvo+j5DgY5YEMOkHJaFuTtYDYe36bywjYdZJ9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NppZK+oPP+XQR+WB2wkjWiBPQyhl6zSP8nSN511MAbo=;
 b=vLbPCj3UeY/b+t7MxvVA/zst+k7J7X8YLOYCxWoFb5NqZFckVcSB3UDs0vMzJqwgExdUnjnj2LrFX3+FWuEkK603bjddd0pQuv5+nU/4m9pvBc8NpYZKcXLO9cF+V0oMHUyFbSnhgseZ//A3dUcxG1KwkNTmYciEOOICvjdx6TBHo0dlbaBFayH+HnpMX/e+OcsddsgibJWW1SBI7V7wWc1OE6CUCyKFyb0xsm173GTWa2xilQeDCpi3kA7U3iqcSTadMd1ct2DTjtJUGxWQRTDIZsDcyWsBegwdqt551inxkH3xYy//KghKkTAX1/y5KfXH4GVSdjpP3XnladKKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NppZK+oPP+XQR+WB2wkjWiBPQyhl6zSP8nSN511MAbo=;
 b=ADLgWOHDtuIQiUETpctMahSI8X9MQA+zafMap9h47P68YgiB5IAjlAMzDdxIvNpaLSRjppfSGJnis8zDu2EKJJzxC4boV80SfoANen6GoHyd2fsZJQQ5IimS/lidtWhhAgNmKG1bFs/eRSHXR8cJl6u1xsJtIP9PcRBV7tjOQL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:15:27 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:15:27 +0000
Message-ID: <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
Date: Mon, 24 Aug 2026 12:14:37 +0200
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
 <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
 <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 20377e99-b342-422b-9b01-08df01c89e5b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|4143699003|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jXH1FFF63KJe8XFrOoaDfH/mYZMIuhFUtftCPBX91bwqcCtgRq1/n8GDdZ6KJJz/VTu5+xC5TR4CsvD8IlUv65Uo15Q+ZWGE+EoVgABf592l6jfGt+wy5tA+cG0OOG14ZBywT3o/pmBbE2zkJ5TUvM3RM0eMVOG5RvpTijBy+F+xpf2SnzeFv9JsclHnmj0MujuRsIMQsvi+GlkptndEoc7b9Ymzp62h26ZD85ZljZTagDmJ5eO7AJUKDCpul76SnQ8dCJ+7BBIw27i9H7pCYKAYcLck51Wo4mXXvc7VfhBUKCvxR+3fgDPs+X2lR+JwitjHrGr/8RUI4NX57HdsVXBSIF5xJUpjW/fb7t4oFbUnR36vX9Zi85FqYpgL4PtpgyBJLigOarxXL9tLPKmPbgWMIfBkLxPdxMZmljmp8QvrKBfFeEumFUIooArF2qseHslJNXEOAB5q7vUzNH0vxrYkEw9v4bl+GalwDFSoJxddg4gfXqxVuc2BAalql808eBX53Ep9Q10BFj+frZX4n3AzXC/C5g2+J/6j8DbmhpRi+fndOsfUpjoHAeLFG5MEL3cQKS/rgoNT/530ddFEezg1nCNLx449R646BvgzihI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(4133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNmc2haREczWUJQVlViOUFseWJQK0xsUjFISmo1VzlJd29MTWs2RXNRcjlK?=
 =?utf-8?B?Z2xIWUFIWnpWdlY5ODNoZGhtVXQ0ZUpaOVQ0VGtjeGdZbmtwYUhlMnlMT2Ji?=
 =?utf-8?B?eUV6dlMwTksxU2w5ZWM5dTJVUGI0REQzeUVQaU9ma3AxdjI2bVphVG9CTWRC?=
 =?utf-8?B?ODVBN21vOG5JMENuaGd5cHVmRjM2OVBzc2JpQ2QvdXZERW1Pb3hUOEFEN1Rh?=
 =?utf-8?B?NXFUYVBXbzFvUEZmUXJrQnR0Umg2blVVUlVlWVlpSnNtb3lsN3F4ZDYzUXZE?=
 =?utf-8?B?VWhOREVjaGUrQXp6Rmg3NENTWlNtSzBaNFViNDYwcUczVXVKdHNpYmFTMXBZ?=
 =?utf-8?B?bmU4VHB5U2pRcWU3ZG5uNVJVWVIxR3lCaWdUT1BmQmIvcUxOaTJSc0ZuUHI0?=
 =?utf-8?B?YmN3NnlsOGhKK1J4NzhvdTJHUWk5YXZCUEdnK2ZoamhqTnVIMDB5Mkl2eCtx?=
 =?utf-8?B?UDJLMGQ2dXA4Y2kyQTBpalpjdWRJNmR5OGJIQkJxM3ZIVmZJaGxFek5oR3p3?=
 =?utf-8?B?eitITlVaOUxueDZvWXVTNXFoRXA5N3hLNytCL051VlpyelJuMitQWDVHQ2l3?=
 =?utf-8?B?ZTI2cFlnWTlRaU1hZFpVS0k5RUh6R1BNNVVJSzFCdEZGTnNOWG5qZUR2alEx?=
 =?utf-8?B?S2F2aW9ja2xoUnhxNlRlNGZMTU4wazBWTUhScldvcVBiL2YzMmNQK0dwRVRW?=
 =?utf-8?B?L3k4NXl1TDZqRmRLRW5ndVdFZm9WSmFLR3N4Qi8yclJTY2hLNVMyQ2VUNW84?=
 =?utf-8?B?bFJZbHdBaDhISlBMZW5MSTc3Y0Y4V2FKSnpHTzduNSt4Y0ZlSFRmcDJYanBz?=
 =?utf-8?B?REM0S1hnekNsdEdnNnZxcGhrVHJEeXYyU3dFeDk5WWZzdkdDQVZic3Bna3Q2?=
 =?utf-8?B?WlV4VmxXbU9XcWtDZk1Ialo2bUpsMG1ScklhMGZkTXpmWjl4aWwyMU9nVWJ0?=
 =?utf-8?B?WHZDY3lRSk02YXZKSURlcE9HcHpYbzZhYlFhTjd1RFZYVDNTcGlWdVlSSFJG?=
 =?utf-8?B?UUlsQzdRQk9BTjBUdW5vSnZ3aWRXZ2NWVTV3dDFqczZxUXc3YWRmaE56M1Zs?=
 =?utf-8?B?aDA5Z2Y5bkxHWVpLUUorQkNmOWQrdnBSWnRtODk1T2pONXBrWE1yM29JdFdB?=
 =?utf-8?B?ZitReGpoSUd0dWhDOXNxZnhHMEFwdzI3N0F0cGJBQ2EvU1cvTytiRFdDZ0FH?=
 =?utf-8?B?by9zZ3FxbDhzOVNHYkJaa3JlRnR5QS8xVjArREY5QzYxbHQ2T2VkNVBQK2dP?=
 =?utf-8?B?UGdRQmw0WlFIMWN1UWF3RlhJMHlRQWZZNEtoN0tXLzZYcWRyZnlBdVpMd3dW?=
 =?utf-8?B?dHRyUmxhV3hWOENIdGlTL2pJYWxNT0psYTRQb2pnZ1dEVWFqTiswaWQ5bFZP?=
 =?utf-8?B?TXlnSzZTYXBjU3NKeExUejdrS0U1d3hOWEVlaTJ5MURCTDR5blBUWDZvNE1S?=
 =?utf-8?B?ZFlTY0R6d21CYXo1dHlXR1ZSWE9HdFgvclR6dFJRdVBpTXRuS0JybFYzUDhM?=
 =?utf-8?B?UExjcG9CQUMrYlpkWWZqcURwMmNrMWhDZVVoTDIzYjVHT3M4bnJBOTMxQk5J?=
 =?utf-8?B?RUwxMll0K2lRS0VNN2NybzJQUFJKVk9zSElKcmVvQ1p4enYyZ3JmdnFPRXdx?=
 =?utf-8?B?ODdscURkUUdkRXcyV0RocXhCYUpxWUhGbUFzc3QzZkMrdEM1aGZoM1pqdDFt?=
 =?utf-8?B?USt4MkJ2Sk9tMjhUNkEvdXo3a1lkTTg4M0ZleXkvREVDTFFZL1d0Wmt4eGlw?=
 =?utf-8?B?NU1xVmd5YzBsTEZlQkszZ3BvQmdKNEExT1ZDK1NHakFaTW9DVjRsbmhWUVhP?=
 =?utf-8?B?U09xMlhielBualB1TzJ4dVFJZkprdkJ2Umorb0dabzN3eXVEcUVaRkxObkNn?=
 =?utf-8?B?NWtJdVBGc05UazZ5bjhKMmJ5aDZERE5UbnhDOEwrRHlWL1ZyS1IyUnFDQ1F5?=
 =?utf-8?B?OEFFQUxycDNaUU5objU5NVpXYUMxY3g3TEpHMDFKaDZDM1o1Z21kS1hJNkFL?=
 =?utf-8?B?akQwMlMyRHl3VXkySFl6TVc5V3hVbHh6Zi9GMzI1OXl1YmhKdW8zcW1wbFlt?=
 =?utf-8?B?aXpwV3NzRDBoYUpTRTA4NEU5RU9yamlhQit2bFdtVTQwUVJ1eCtOUVlGZ0ZS?=
 =?utf-8?B?Q2VWZWh4VGhGRzlhVlArMUw1ZTdaZGZqWVBQaThicUZQNHZzV2cxREttZG9v?=
 =?utf-8?B?Y3BIQy9ZWmtKaTkyVXE2YjJvS0JpS3RPbGJQZ2hPKzlrTUxnUmVWYWZZbjZY?=
 =?utf-8?B?N2NrWmUyWjBZbWpQaWhWcmNpYkNCTy9EcDBZRkN2Mi9TSS8wNGF2d01DNkMw?=
 =?utf-8?Q?FlRBoAfYTyKLqllfhp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20377e99-b342-422b-9b01-08df01c89e5b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:15:27.5469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox0e/k+Sc5t3pih+nf7QbEbMOAa4kovYKRcnZTV4Cs1/A1jvS+Eb6uMVQZ8YHPmt
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



On 8/24/26 12:11, Quentin Schulz wrote:
> 
> 
> On 8/24/26 12:07 PM, Michal Simek wrote:
>>
>>
>> On 8/24/26 11:54, Quentin Schulz wrote:
>>> Hi Michal,
>>>
>>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>>> files or directories which had been renamed or removed over time. Drop
>>>> these stale references so that every F: entry resolves to an existing
>>>> path.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>> [...]
>>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/ mach- 
>>>> rockchip/rk3576/MAINTAINERS
>>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>> @@ -13,7 +13,6 @@ F:    configs/nanopi-m5-rk3576_defconfig
>>>>   NANOPI-R76S-RK3576
>>>>   M:    Jonas Karlman <jonas@kwiboo.se>
>>>>   S:    Maintained
>>>> -F:    arch/arm/dts/rk3576-nanopi-r76s*
>>>
>>> This is a leftover from v1 which had a file there, but we merged the v2. See 
>>> https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260108143551.4017839-3- 
>>> jonas%40kwiboo.se%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C20d22328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=0 and https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>>
>>> For now we don't have U-Boot-specific additions to the upstream DTS for the 
>>> NanoPi R76S but we could in the future, so having a wildcard like that would 
>>> allow Jonas to be notified if one ever gets added. So it's not completely 
>>> useless. No strong opinion on still deleting it or not.
>>
>> File is there or not. If you add it in future you should extend that fragment 
>> and that's it.
>>
> 
> And Jonas won't be Cc'ed on it being added if someone forgets to update 
> MAINTAINERS (which honestly is very likely), that's my point. He maintains the 
> board but won't be notified if something directly related to the board he 
> maintains gets added.

you can use N: regex fragment for it.

Thanks,
Michal
