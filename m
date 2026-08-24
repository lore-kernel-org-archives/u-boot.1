Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF4DC61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8CE640761;
	Mon, 24 Aug 2026 13:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAWIjZ_6McDr; Mon, 24 Aug 2026 13:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577304;
	bh=VVQqlnDD4+DxLjeQE9K8z9ylg4xKSbC8g2AluviguX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RqlIpnp96RvCHSE7weV7JnEvTXQAXRK9z/F7acKzEwu8cBfp8ru4mFUYwJp7cy+pj
	 pKy0uqtkcTduJv7rNcAKnO4Y14gz6Vx5KAbRLuhdjpIUSUO4eLpWpMbOxTlCh1670K
	 1+osoy6JDjTrIWfOQYQ5cZ57y6IQXubnXy5PvHPD3XP2PFTbFq2iCCJWkoJFIPEeqq
	 mhR+aMg68Ao41iF9fxNxWFSGd6kW8A3N4BFxWJpVp5QE6D+RlmE3wZX9pqmLqrUrA2
	 pWrZwG+WMv1B21fyhDcZg2THOo67j1hiAyZiMW1NNrINtCEJ+HQt9psZNecQNO1zN0
	 CCF8q+NEeITNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 574A7406AB;
	Mon, 24 Aug 2026 13:15:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D7F4386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FC9780C09
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMSTC-BsaBeW for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 10:16:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OEZ2mSZL
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCD5780BEC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNX9Ls5rdvPpaFc7qUumYOX7JceJoJpGlnaBSlAbhQnL/4fnL1RVN6W2N9Nl4fWeIhqTzu5KGJRmDd1eupC0xhwkM8ijWwhR23VmIc+0X7H7rNMiYFKNRYpOmqushJbJL59EAsA2xm0DCMrvuq/0YDvX2CnxyVgZg6Rv3gumDZ7uMoTig5WCm+zyAUBEL4cvwWTg8dyE2hEEurxcEuMns6I/RK4RZYsnZEdHw2dBF+KZA9Oyoys9evHlMQ/6e9SxeEcPMMU0Kkhhu5RjZjP4HJ+7lbLvruLZy0lDsTHBG/CV3SfH5VHhpLlxsWbGpkbX2Uqkyug7N2EY1HkScNbsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVQqlnDD4+DxLjeQE9K8z9ylg4xKSbC8g2AluviguX8=;
 b=AUuBaDwkcw6r0vghkA/qSC6ipc6Q7PdqpTQyIGm5Hp7qbvwLUvaT4fdlVVz+vPLt7rgZ75ImR/jE/my46Ddr/kces0XLQTt0jyPHWm1vJ4g6oXYLCdWzY2QzSBOk6EtnM5M2V+xIXy6quiHtuahR7vRSIuxBLHVlRb/LuhmNCmLWC+OSbYmgVYOu0Sf5b5TAAcsSSkH6T98kYPwjQUGVQM5YOCEUu8Iljh4dndnCPyKju93dgk8eiYJ2JlMInXlY0HuWWdGe+AuFltA9pnQl9Bqb0o0IXu0AAheDmfTJ3geypcLs27PjzlHdOP6NuEmLKIO1zXfWwmMBBIND5DL+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVQqlnDD4+DxLjeQE9K8z9ylg4xKSbC8g2AluviguX8=;
 b=OEZ2mSZL5DXPHsBmcQUwwvCwHEqdLKwlwE2Mks+zpAB++I6e+A0XByX35RCGtZFtRWV+BO8rBASjMZfS24wXOSUoU3OJxht98TL5jyysD801bCDMR12j8UgUuq93xro0w0cTzEjwKTYFPoiyYMcGnBunCyd2WbWD3rWrCrhtZO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB12127.eurprd04.prod.outlook.com (2603:10a6:150:313::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:16:27 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:16:27 +0000
Message-ID: <4d7ef207-189d-4b7b-8fb1-385dc1411add@cherry.de>
Date: Mon, 24 Aug 2026 12:16:22 +0200
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
 <e128ba15-d1aa-4414-9273-8fe999e054d4@cherry.de>
 <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ad8a8f9d-8fab-4976-9d9b-10e7f5bade9f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB12127:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4d0359-ca06-4360-e39d-08df01c8c22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: ltNAIfl/gFVdOeHfGIa4azeWTNi7Yswga7nVEVnlxLA9dkBxiovk4bot/8mn1PGAFIN4SxzflgQgyVhNpjfGlpodWI4V01cL8A9eUWOymchPlvPPmJ+zOu8FLSZa/H7Vt6NJstpW0B5C3DmAFBNeauZQvCJTIlNrCJjLGVyK+bq96nihnMm+811nNLMMJADWTZ+twnLkB19V2D+oqjEs7CzWPTkei94pVnGsvB95LOQXe1PmaP+DrguIcnd1ujKnREyvcyMmzY/cKd2JFujqLs5ortmq6h1t8WV8PfWXVAF5icQz6893YC5AqV9VM4VdY+PMjhFU4DpohP0wBRYrtxDT0ql12isGkJo0ccELPhcWRI2f3vkhhNUrZtjDV6TSFOVxw7OvBv6lr4X6Fjs28asu3uMuEcSL7slUzfo3DCwpuIkpRT/Eq0HWO9eb9LG94uziRMZ4tgLhIZS4Ckovoye3xWJOGOTooVEtqs5QzDwemqdcFvqQx9MBpBz4QS+WVjDH0wtLtF70PXZhfV8tZRxwrIIXvoGdlBQaz81BwUzITWnSVAlMWsHpU6gL1g4+lLl/HFS839JU4fyUhj/VZ1psVPWzIvm3+qGNj9SZ7oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0g4VmV0c1pHcnZuRTJ4Mzh3aXhadk5ra3NLaXYrTWl0VmtPSzBLRWRHVHVN?=
 =?utf-8?B?Vm9vN1JLcTRFNTM4RVVzZkQ3Q0JLRFo4OURUYUhpK0RFbVZPU0wzTlZEYkky?=
 =?utf-8?B?MG9FUGtWbGpVT2xHSFZhREZBNU5TSHI1aTBVYWhtQlMrTmRtdXJ4OUdWN3Jy?=
 =?utf-8?B?K1ZjbTgrVjhQQk5XY054bXJySmlKM3pLMlVwdkNTaS9IMHNxL0dtbVpqeWlS?=
 =?utf-8?B?RFBUU1pDbWJLMFQ1L0xuSktrQ01KUlpBLzNJbGdlcEZoa2lZbklLbnJxZHBk?=
 =?utf-8?B?T0xZRGQ3ejhiUkRBTjRBajIrWkFCZGtscXlxTDhhQXorUjN0czJGSmUxcmda?=
 =?utf-8?B?bzNJTThiZGIzMGRNNWIvWHVOTE5Pa0VDYXhRZGNxQStQVlJNVnFHMmtpWSt2?=
 =?utf-8?B?VVZGWmp0SmxJanRnVFRTOXZCZ1VpUGNib2w1SW1Uc0YwN1RmQ0g3c1NYWVZW?=
 =?utf-8?B?YTF1TnZ1R3lUTVYvejBJdFpUN3dndk5kTzNqNDlyMlZxTDFDcHhXazdpK3Ro?=
 =?utf-8?B?ZEdOUVdUanF5dGtBWTdWZGRvQ0FJNzVJOGlnUEtyWjFWWUQvSzhvSGp2WHRD?=
 =?utf-8?B?VTB6N0VtVmg0YmZxYWFSckRvREVPc2ZCVmNPNzI2Wk0wcDlranBlTnZ4ZGhQ?=
 =?utf-8?B?cGtqM2orMDlEYkloTGZWTlBsYUtNcy9BaHFQemgrVnVZZ0hmNVF3d3ZFRWtw?=
 =?utf-8?B?YVNrSzR0SU5DaGRPSFdzb1ZKeEdhUU41MnVERXA0REZkNVRRSDBJK3VSZ21T?=
 =?utf-8?B?VDNEdm5YZkQyUUpBQWtwdFpPT3JqeTlTdGVYOWx0ZnNXbDMzSCsxWWxWamNm?=
 =?utf-8?B?TVp3RE55Um9LWkRyemJSSzRzZHpNbjlUSTBiZkE3ZS9ScXRFUVJ1bk5SZm1J?=
 =?utf-8?B?ZmdRTHcrUDJ0NXVBbytZNjZjeGZYMXhreUt3dEtVVFB5SENlOHpCRnh2RW1B?=
 =?utf-8?B?aW1QSkJmaHBiOS9nTzVnbXU4NHNLdzMrZ28zTVdodEphNHZyRUUvKzdvZWVF?=
 =?utf-8?B?SUFqNkRZMDJQcktIbUtGcjlKUklPR0gwMVd1NFpTdHJ0a0RnRzVmY0psZWU4?=
 =?utf-8?B?UmJCNXZtMUpqTWphcmpHTUVuSERpUXp0N2ZJUHRhZFcrUXVBQWpqMFJYenFw?=
 =?utf-8?B?cUJaSmdsSjdjb3FuR2syb2F5Mkprb2NPam1rVVo2a3ZDZU8wTUg3M1pGSnB5?=
 =?utf-8?B?MnFNRmhtc2RZOHM0cEMvd2VRd3RnNEE0N2ExMzM0M2NIYnVmREZRcUltczZy?=
 =?utf-8?B?RUk4MlRBbExpc2xhaXc1dEIrUW5vTUFRZmlhMWZUY1JhbnV1Zjk0bjc5ZkhI?=
 =?utf-8?B?RlJpNktBQTBQR0hRbTF3MHNSTWp4ZCsyZUdETHYwZWx0eFJpcGZqOTdWNk9U?=
 =?utf-8?B?bktWYkZUcmI4Rzh4OTNiTmZlbUJmZjE5bmd1b1lFYzkyanlqQUNJVDVscTRk?=
 =?utf-8?B?Q1BUU0RrbWQxb0RxTGVIbysyckZmR2w1akF6cXdLMGM4WkZmKzlldi8xOVJM?=
 =?utf-8?B?T0VRQzhncFRTSFdhVmsxcGw1aStiMkxIUXZrNEJrbGxzSnN4Z3hlQU1xQnVT?=
 =?utf-8?B?amFDZVZ0V3VUZmoydVhRY2lqSkZCcTg3bTRFNmUvNXR5RG9oTkJYSkNFekJ5?=
 =?utf-8?B?M3hxTFZjMTF0Q3pOclRabThmNWE4NWhaNno2ZmNtN0pXNnNBaTF1KzdQcUNj?=
 =?utf-8?B?TXVrY1JTTUZ3eGNOL2FwOU5oanBLY251bkxJczRweU9VWENxVjMyOWZnU2xM?=
 =?utf-8?B?VW14UVFBdXJUU3Z4ZE81cWdNTXdGNFdMQnFTSUk1WnJ3MFRVQ0d2WHIzV2RC?=
 =?utf-8?B?SW96bnpKaTg3VGllU3ArM3hQU2xMa1FMbnJUODQ3WW92dGg5QzlZR0U0cGMz?=
 =?utf-8?B?cVIrdC9hN1UxSGxvZmN2QlBUc3V5Ny80TjFPRk9RZkVEbU5GZDRiQko5RWh6?=
 =?utf-8?B?eVNXZjZ6cktnbHlwOVVMSjFDa2R3QWVsMTUvTWNueFFZbDlQRmxJT21MTU5Q?=
 =?utf-8?B?ei9GeW1JdXAwdDY5dEcvQVplVTNzQ0I0WVdZNjdvK2Vpeks4WXpQYW02VTBo?=
 =?utf-8?B?ekgvSnBxNm5lSGhNYk4ya1pzYWFyalJFZU1sVW1Yd09xa1AvWFhvTzB1eG9M?=
 =?utf-8?B?QkdWQ1o3L3htWGIvNXEvOGhML0R5ZTRVZ3FobEFMNGdjTTVaTCtsMGdlSDds?=
 =?utf-8?B?N0kxWHl0K3ZPRmNDNWk4cmgwdXJDd1p0ZEhqdlFJd0pDR0ZweDJzVnBETFM1?=
 =?utf-8?B?RjhIcWNxTjFvbTN5ZFhNSjFldWcvbUpKbXFKMnFVVVczNEpzNGpVbmg0djRk?=
 =?utf-8?B?ZlFKd25VNmVwSWdXYmFiZnR4YkVocHZNTy9OaG9vVERaWE1maTVnNzNYcWUr?=
 =?utf-8?Q?o/dP8tCWfloi5mxWAVKzvAw8Y5XbFWF0q5/SczhaMDXup?=
X-MS-Exchange-AntiSpam-MessageData-1: kpDr8LbTu5wokw==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d0359-ca06-4360-e39d-08df01c8c22c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:16:27.4400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsLus+1+lwj7Kpl9MLxvdeL7ttp/yrOjjH0CKkVEcAM7IMesZk2itlTLzBZmf2NgQRmO8nEdfapk2TT1RZOHyRwYz7XerLvW6mZYbxdqE/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127
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



On 8/24/26 12:14 PM, Michal Simek wrote:
> 
> 
> On 8/24/26 12:11, Quentin Schulz wrote:
>>
>>
>> On 8/24/26 12:07 PM, Michal Simek wrote:
>>>
>>>
>>> On 8/24/26 11:54, Quentin Schulz wrote:
>>>> Hi Michal,
>>>>
>>>> On 8/24/26 9:18 AM, Michal Simek wrote:
>>>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>>>> files or directories which had been renamed or removed over time. Drop
>>>>> these stale references so that every F: entry resolves to an existing
>>>>> path.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>> [...]
>>>>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/ 
>>>>> mach- rockchip/rk3576/MAINTAINERS
>>>>> index 79cf9e97f70b..62c3ce765e0d 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>>>>> @@ -13,7 +13,6 @@ F:    configs/nanopi-m5-rk3576_defconfig
>>>>>   NANOPI-R76S-RK3576
>>>>>   M:    Jonas Karlman <jonas@kwiboo.se>
>>>>>   S:    Maintained
>>>>> -F:    arch/arm/dts/rk3576-nanopi-r76s*
>>>>
>>>> This is a leftover from v1 which had a file there, but we merged the 
>>>> v2. See https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Flore.kernel.org%2Fu- 
>>>> boot%2F20260108143551.4017839-3- 
>>>> jonas%40kwiboo.se%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C20d22328c2c14b04e70608df01c79b5d%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639231628996802560%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BGNHaQOa3XRWnaRD%2BMBZJDH3t54Q17ZQGynxdQr34e8%3D&reserved=0 and https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>>>>
>>>> For now we don't have U-Boot-specific additions to the upstream DTS 
>>>> for the NanoPi R76S but we could in the future, so having a wildcard 
>>>> like that would allow Jonas to be notified if one ever gets added. 
>>>> So it's not completely useless. No strong opinion on still deleting 
>>>> it or not.
>>>
>>> File is there or not. If you add it in future you should extend that 
>>> fragment and that's it.
>>>
>>
>> And Jonas won't be Cc'ed on it being added if someone forgets to 
>> update MAINTAINERS (which honestly is very likely), that's my point. 
>> He maintains the board but won't be notified if something directly 
>> related to the board he maintains gets added.
> 
> you can use N: regex fragment for it.
> 

Fair enough.

Cheers,
Quentin
