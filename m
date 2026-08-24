Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC08C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D721480DCB;
	Mon, 24 Aug 2026 13:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiKKcvrbiSGZ; Mon, 24 Aug 2026 13:15:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577301;
	bh=Itqz8dLIGB1XeH2YEl4/OSZatM8E8RCKxrgn9f0nKpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFo3cRm3f9t/8m1N5s5ONs7phDq8Nm4mc+Q7CoR2SH+zzdF1eshQf4bBmvRsEHaCB
	 SmMCEFE1h1ZQIcykWanqOhx8fnQ79rRgvV3nqkAgHrqRERBqbjrMyaS5zoOyguVy/g
	 JA9wEUyelkLB4SA1A/ZFkSeySLZlONetQBquuOotQbKHnK1c+og18HBduo/nVcSfQM
	 1XuOLXdrH76t+jdvKiv0cW7aaP6LXoisRcj2xi+7aMHPx0Zg+fQkNSUhtgjlGOSsgJ
	 B1B2//MCXcBiNsnkF7xsZn2DwU5gFXkpNrkjoF5tvLrlRrG0dtIdFTt9u8sqZY54aZ
	 V5syeFnR6lLhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 381D380B0D;
	Mon, 24 Aug 2026 13:15:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B465534E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7ECE680C09
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZYiUGU_g1W1 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 10:11:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FL9PXhOL
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 248B380BEC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS/Jco2GRH8Xm/mw8sDIxeYXpf54XS9IUWK1FTA7Mc4PmfWwwxm+FbXAmRFS2F/VZEb5JwplXrzN1BTLSZWc2vhj2cVV9ZVLpnLetil7qXBgoV4QsmVXMKb7q/HOoEHKCfjwbekT1JlVrNvROZyWo+RhexNHzaoOuUmYTWD86daU++m1ZhNg7AWm9/mC7V0cRwdC/QmjafxiDkhCejbUIw/PlmN9/DV8I/+O6TrNToxJue7jRo4n0h50S4oBV2xQtKdu6kpprlnuGmQLqE9wWGjN/nluplNJSD+C3TjSRwFyDv7UExVyoy2Tc2yFqgyfuzE7bg89TuEKGSUw1PP/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itqz8dLIGB1XeH2YEl4/OSZatM8E8RCKxrgn9f0nKpY=;
 b=EKwcj4p0+qUBw7k13v6l6JhjKSpW4CWv0qn0EMHWeZSpbTMU6Mh4f0y1ufp8pi7odsvFHzh+PHlhWE0hJ4G/84XSVBmT8equSF1oODtd/awZW7etXBiumvBwze6vH5Swy1/PKoSGfOd9U6qbGWzW3THzH/ZkDEdGX/Ldi4UwPe34WuYmGpm820Rcl4BFFquYLE1LD+THXsXennJ+bR36La8JUPMSuaBZhAx6qljRRi6InHvSRgLfpkd2R+ANeLLfIfC0hH7qHLu4HL2ThVscZoaWj7ITRHFHoj8azN0cD78hVu1fJIgLy77CHFA07S7j8TAHVN+Uj2XYUGxnixej4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itqz8dLIGB1XeH2YEl4/OSZatM8E8RCKxrgn9f0nKpY=;
 b=FL9PXhOLZKf2MI/Yj7qovf8akHJaNW3CtoARvH6Fi0vGCxP+r5qNTtIRdK025WFY1qMojiL7idugF9EMVG9SYIg8KAXgZJp6RYKd7L+QqBCOZQlB/cPUHpgdHegfFNEGW+FodK4fNXVeKArbMzLzDK2UcISkDs3T6TMmcAeVsQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VE1PR04MB7341.eurprd04.prod.outlook.com (2603:10a6:800:1a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:11:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:11:40 +0000
Message-ID: <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
Date: Mon, 24 Aug 2026 12:11:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
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
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0051.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VE1PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a6199b-4acc-4ad0-2377-08df01c81734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: VwGUtacAoc9SwpQ/nzmiYn0FZK4T7UGIOhvH4Dn5SRe2wvX3ndGs3gKv5/ZRbipnHNi0YFGm5UCCH2CSX59WzwOeNfGf9DTc9eT1uz0YHMkBVb/5LfqBSLNjlhN0qrar4eAB5rafwqTQVayXoFESQjln9Nm5RJjf9BdGyhLlQGSpumLCLOmd9rvlZXezCcuZNnRp/mb246111ZY1M0idsvRq122cIwpoRvFZnWPAoNSPrKsIhC5OMxD3WmxnewM1PBObUBnHWxSOMNJO3jnr3p5Pz3hbOetymFZbX+9fiEiAst2aRP02bKX4WVBjPkEb0qbh2qz/hAMvF3QanYtmV7O9AWyEfLF91FQQxbXBHRyb7Wa6o/Pcx6q2eYfJdWyUXzAW7mj0StHjTbf2PG5fKW2ImLvFf10Dagw11kru9yOlBamXOuNxLsazG4628omOuIfThWJS4cmLW7lHViXu3Gw4yPwIYuut8+JTziGaaBG1swOO0BVYiuXQvI7Z+BdFGqJPID7KKRZHTKd9LCftKWb0JjQ8E3qsFWzWBhoL6D/QAgqi/be/mSrD57yol9RJqMCFKASzcRfebU7fBXdq/8GRVdaYbPjv7zk26d0Mqeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkl0V1Vpc3VQTVhKSzhJYkFPc2NoOEVkRUFYRzA4NktFMUZBR1JYQThUMTBJ?=
 =?utf-8?B?WU5Pcnd6VlJsb012Nnk5di9kNk9jbmRNMWIyQ0d5TmpJYS9aU3FlOUZWbXQy?=
 =?utf-8?B?RTg1SEVMU29OaU1ydzRxcXpUd0JwSndBSUlEdEdqL2FuZHh3WXhMKzBmNllR?=
 =?utf-8?B?bGQ4UzZ0THlhdVZla25EaW1RaHJxNXAvMzJiRmxsSlU3TDBscE9HK1JlRXpi?=
 =?utf-8?B?cVhtNTdPS0ZSU1piRHhjWmhRdGdqdUdFV042Z0lwZXhNMTJaZXRzaE9hSjEr?=
 =?utf-8?B?Rkk1bHN2MUlKUC9ZbEZQQ1ZKWEp3dWtnMHhYc0I0TE0vY3RXcURDa1FIeUZK?=
 =?utf-8?B?ZEh2WlJVMnFXOXE5MmpSZkRqQWZiS0FGRmxvaXdQWjdUcmtNVjcySkRvVklO?=
 =?utf-8?B?REZsSlJxT2F4SUlMUS9qZS9vZXU4NkQ3djFGb3BKQUU2ZzBHVWNrWHZ3TGFP?=
 =?utf-8?B?TzdIRmh5clcvK3NmWDh6QnVuQk5CeWxSM3JmNmRGamUxWnhOeU5MSzRXQndk?=
 =?utf-8?B?ZkRmUFRjdGZaK0hmaksvVldmOUlsSkVYUk44cWxTYWNGT2svSjJrNnJET2hI?=
 =?utf-8?B?REtXVHFDOCtlZ05mRnRuMHV0NzRTRC9CM0FFczJuT1p5TGNXTmROUXNYQUhX?=
 =?utf-8?B?OVhJS0loMkJKamI0SS9RK0xCMmRpSkRlbFpCYnJJeDI0V3FGNVcrakZIdE15?=
 =?utf-8?B?TDBHSWJQaXBXQysxUDNPOTZDUzgxTFcrMGxTbEdFTmI3dGVNTlF0UmNKSDdY?=
 =?utf-8?B?MlJzN0ZZTHhjbUJIOCtWRHowbm9xOXNjYjM0cjVSR1ZPSlFBNGRNd2J1MW82?=
 =?utf-8?B?S2U3WGVlcXJseUJDM3JNNUhrbVRsUDN6TmphOE03TTNJSDEyaWkxSmpwSDlR?=
 =?utf-8?B?Nmt1dk5xUVBhVGFyaEs4L3VJbStIYjlMV2MxZXBTSFVPYkFpOVZxZ0VRVXQy?=
 =?utf-8?B?MnBTU2VEeEF2eVFyQkZFTGVDVDBMT2VwelJxWkZ3dVd4YkZuNVBUVDdDbTh1?=
 =?utf-8?B?cVFJY0lqVHZHSDZNVWxzYmpxdHNHL0s3U0ZTN2pZQTkwd25TY2lHUnlkNk10?=
 =?utf-8?B?d0N4VWN4N29JT1Btc3lKMDB6RWtsbkM0c1g3SzRmUHVTZUptVjlrclVhY3dI?=
 =?utf-8?B?UzFzUmlQMlh6NjNCOTZ3YVF3QVp3eU1GREt1WFk1SzkyRS9mUndQUThhVnRB?=
 =?utf-8?B?dTJoTXBEYVUvZkJLUWwxOTBrTWlsM2RGNTlQRm42TlZHUFczNmFsTklCSFYr?=
 =?utf-8?B?NFJhRnNpUFlZNU9ZRit1dnN1UHhtV0o0UDR5TzduQmRGQ21VZmdMTzc3Ymw3?=
 =?utf-8?B?N0NGZDVVc240RWZIcmJRTC9UdStwRUJaY2lMcUxTcDhaa1hkTFpIZllaMzc1?=
 =?utf-8?B?VTBRZGV3YjZkVzQwbnNiQjIvNUhJaXh1SU91QWFFUlJuVncrd1A5ZGs0dklL?=
 =?utf-8?B?V01PYldWZ0kxWDRvbVo4VWlLbXN6RDZVUkRsMWZhY3RCYWNKd2Yrb3JmZzhW?=
 =?utf-8?B?YTZRVDNrdUR6eGNGN3BSdkpmRHJiNFR2ODZNanM5MnV1Y3JhWFFaTEF0cDli?=
 =?utf-8?B?SkU0aVpMRVBOQnRPaE1aT3VySisxY01lSExkaFdDeDNobzluWUdINDMyUVlx?=
 =?utf-8?B?N3A1ZTMzZGZYREdEcEZLKzVwSmtJTGZsL3NuUE4zYitRcnh1MUZDQmpHZzBV?=
 =?utf-8?B?MVgvZFFzZXQxbUFhQlpaRTV1UUpwY1hQMENsbTZBN0tjM0ZKalBOUXZ5K0VB?=
 =?utf-8?B?d1J0R1RZZDdsenJZcjlpQVZJdXJWOW0vMnRjQXZUWmhDM2t5dlRpa041Yzdr?=
 =?utf-8?B?cG0xQ3poWVVCWWNUbHVid01GblF1RW1HYy9zWXgydnRMSEpPT2R1ejZKTG5M?=
 =?utf-8?B?OGNVUzFsWW15WWNUQ3lGYi9QeWRKZzIrdStJSDQ2dUZtbmJiNHZ4T1NnQXNY?=
 =?utf-8?B?bjN0RC9IQTVuOSswZnQ2ajZjQmVLR2xVY2hFeGpKNU12ekhjNFpJeTJ0L2Q3?=
 =?utf-8?B?YmlYblFxSll0NUl1NlZoM2RkZk5rUWJBUzZxNUNnTklJVStPWSs2eXZ1N1hw?=
 =?utf-8?B?OUx5OFREdDh1Ym9pSlhoSjBtME9ubHk0UzdRb1Bqd3JqR3VSWjlYOWgrV0dM?=
 =?utf-8?B?VnZvQ3FDKzhPb3J4UlVyWW1EUkRrTmpObDdwTGMxRGpwZHFLdjkrUk5WYzVX?=
 =?utf-8?B?emRXV0RZSHhJWVF5a3ZlbU0vNjBETE9PV05LeUdNbHlJbEc3M3ZlUUhoTTVF?=
 =?utf-8?B?c0N0Y0dGWEZ2U2MvdWg4bkp3Z0wzVXY4R1VvNDhzUUlJcm9HTDN1QXYvMjZr?=
 =?utf-8?B?eVJpVndCTmZzQzBBRkxOcnZFQUtlWVowOWE1NFFhYTZrVks0VnRsaXlPTTlS?=
 =?utf-8?Q?mT+OLn5eTHLgS5f5MgwGFsieBqxcQjQETfwwkohFlC6FX?=
X-MS-Exchange-AntiSpam-MessageData-1: pCpbp5GuMTdOnoD7QEY6tSOaSNcyKxqAIBM=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a6199b-4acc-4ad0-2377-08df01c81734
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:11:40.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5wGW45c1ILQIomHhAzTu9HkGBkdmsuFyZfe2zZyTAmf553CVJw6JIpOp4cCSRi2vyZYBrlsh4RAOmDmOyzDLvLwDsZ/nMl/A6IDrZ96Umk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7341
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



On 8/24/26 12:07 PM, Michal Simek wrote:
> 
> 
> On 8/24/26 11:54, Quentin Schulz wrote:
>> Hi Michal,
>>
>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>> files or directories which had been renamed or removed over time. Drop
>>> these stale references so that every F: entry resolves to an existing
>>> path.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>> [...]
>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/ 
>>> mach- rockchip/rk3576/MAINTAINERS
>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>> @@ -13,7 +13,6 @@ F:    configs/nanopi-m5-rk3576_defconfig
>>>   NANOPI-R76S-RK3576
>>>   M:    Jonas Karlman <jonas@kwiboo.se>
>>>   S:    Maintained
>>> -F:    arch/arm/dts/rk3576-nanopi-r76s*
>>
>> This is a leftover from v1 which had a file there, but we merged the 
>> v2. See https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260108143551.4017839-3- 
>> jonas%40kwiboo.se%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C20d22328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=0 and https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>
>> For now we don't have U-Boot-specific additions to the upstream DTS 
>> for the NanoPi R76S but we could in the future, so having a wildcard 
>> like that would allow Jonas to be notified if one ever gets added. So 
>> it's not completely useless. No strong opinion on still deleting it or 
>> not.
> 
> File is there or not. If you add it in future you should extend that 
> fragment and that's it.
> 

And Jonas won't be Cc'ed on it being added if someone forgets to update 
MAINTAINERS (which honestly is very likely), that's my point. He 
maintains the board but won't be notified if something directly related 
to the board he maintains gets added.

Cheers,
Quentin
