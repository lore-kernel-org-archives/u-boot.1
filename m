Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AF1D72340
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 07:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081E4839DF;
	Fri, 23 Jan 2026 08:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tSn4UnzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85EC83A6A; Fri, 23 Jan 2026 08:24:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEE2839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 08:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdqxuYwLhGmgTXsp5qoKJinAssRsCN/VsAW7MoQWs22B/vkF63tsYMAADUC7yfgx1iyMTsytARznL8j09MN0x1Ti1qEBD9dxebmeJlfqeMHHMmtCD5t8nKtaSO30P7ASyodpx2K1lhdoO7pRH6htal19TO+fhhP4lYSNGpjSYIQTPpz+tRmutwiv6rZgbnub5gZMfaoUJiUFGT10BzGzEhaKzHeK25303YbixiMs6qgZDf5cL5bT4UctnimUmapuEQxvt0H7if6BamptonKfC/sQMzR6C7p1V7lotfqqIKFYSRjh3B3l4yGF1TkcZZytH2Zfm2r0PJGQfJlMy5JsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL/olJ6Qq+iUXTH4Z2w9/4X8FqElD5ZRouGGOnpQkPQ=;
 b=r1Dv/Gbt5wipmSBdtdbIYzvy/YvdASpL06k3HqD/ww0Nd4f7hHYacoiiTQo6A9JYBWdkB9yGKDBYEp9frgKr6DOqvEp3i49VjkbkkoqZskqEgfvqNpqCs2a/CeMDIsiscnQz+iOL7xqpfmEzvROiEd+YdbYdiVvwjcWDvqos+Sk0ctLN75Eb9U7DOSdesgSgZXd2tEcemWCO/UF1P1pdmZCnv4LK2lO7aUKikKgP3bSXqfjbzDcw1agmJWnzCIry2A5chsFCwb3whvDHT6C9S5gJMfTKXQnwE7XA+4Xs0dVdV8EWzqjPIVJ9NyQUpTrPLojsd44hGyBDrkE3pW1OOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL/olJ6Qq+iUXTH4Z2w9/4X8FqElD5ZRouGGOnpQkPQ=;
 b=tSn4UnzMZD2JOt9TlmcPYWU1G1nAZPpiDm8Dgj3028R7RjI5Am12FSOUE2lRU22OfXfqG/SgscTAiOFffTh4UDK66Vu9stPDsfdGzRanE49ee6j4YpoN/59JpjxR/0r+s61k8NEVsb3vnZFNZdx1XC1KLv7MhPaAGKy8rTVQls5e6zPmt+MKYOaPstUDkWeSlvjJHBuCNwMoP0JUrh1TwJD1opikU6k/mcrIykocFjevfijtx0mIdM4vMJQQ62ZDH5RX5GIajTpuQy/71iLmw/GKWxeLM7JnMvjS+KVFB+4WxGEZtKpsBl6rhcUIZbu/aSuivEtQRjVKcg0wQFHKAA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 07:24:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 07:24:04 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Ernest Van Hoecke
 <ernestvanhoecke@gmail.com>, Chris Morgan <macroalpha82@gmail.com>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "thinhn@synopsys.com"
 <thinhn@synopsys.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "quic_varada@quicinc.com"
 <quic_varada@quicinc.com>, "felipe.balbi@linux.intel.com"
 <felipe.balbi@linux.intel.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, "lukma@denx.de" <lukma@denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "macromorgan@hotmail.com"
 <macromorgan@hotmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mian
 Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggVjIgNC80XSB1c2I6IGR3YzM6IGNvcmU6IGltcHJv?=
 =?utf-8?Q?ve_reset_sequence?=
Thread-Topic: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
Thread-Index: AQHcjDlAnPldC9me00mnxDJGyCNBrg==
Date: Fri, 23 Jan 2026 07:24:04 +0000
Message-ID: <PAXPR04MB96444D82A8CC6D3DABD42159E294A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
 <20260115230135.183158-5-macroalpha82@gmail.com>
 <z2hh7mpyjljlvgjw53lggxuqundl3y4xcb4mdbczlgouwhygz6@phktqzuxxjs2>
 <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
In-Reply-To: <d3dd54e3-d20f-4aa0-9da1-3c0e821d6aa7@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB9056:EE_
x-ms-office365-filtering-correlation-id: 71d9a8b0-398a-420f-78b3-08de5a506362
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V2FVR2VXMktzb214K2o2eXN3TUxtdjk0eVppSTJJMnFGdzRVdXJxOTEvNDdI?=
 =?utf-8?B?bVNoNUdEbUhDZGZwVG42d1NpVExWcThqU253djJURkMyZEVlRkZyS0xoaTRZ?=
 =?utf-8?B?OHpxQ0tTWnVNNG5ZRXJLaTF1SGIwd1M3SlR1TFFYN3J3em9xbEJ1UFU4dGlo?=
 =?utf-8?B?UFJiLzNRdjRmRHZYWG8vcXJLRzRBSFpTcEpoVFRuVlNsY1FsNXVXQ1J4WEZx?=
 =?utf-8?B?aU5oS3cxajIyeXJHWDBRQk0vU3BZTm9mUHBPOHJ2cFkyZ2FqK3NaUDVPY2ZN?=
 =?utf-8?B?Z3lEMXNtZTVqUFg3TXBIWFo4ZXJOTWRYVkpwT1E4TWJqekM1a0RibW02ZGVv?=
 =?utf-8?B?aWpqSFJlMmdrUUV0QXBoUmJsU2JpV3ozWmtlcEVrbGtoNGF6WmFaa2pUNEVp?=
 =?utf-8?B?MUludW1VVlU0T1JXNGV0MnZxUkRFSnNEUmNlVjVOc0xKMGVWV0VhWmNNSFdK?=
 =?utf-8?B?MTJGUnJzWTNVV3pBWGk3R043Q25HMXg3NUJsUldEV1d3Q2h2eWpmVzIxaEJ6?=
 =?utf-8?B?djU5OHNodG9SS0FPbzczMmFZTmdZT1I3YTN2RllRUHh0NDVrbnBtT2orYW12?=
 =?utf-8?B?bGpXejQyWDBJUTAyUlpWOG50emNPNzBFelpLVE5VQUdzek5abkdzWUZNT3hj?=
 =?utf-8?B?VXFnMFRoNEsyMmUyMkpDU2pMWUErSVlBUERIZW1wcGU2OElRN1pGbEFaMWRz?=
 =?utf-8?B?ZWlaaG83MG0wVHhFNW9KZGdNNjU4c3poSWRSQU93VkEzSjRsS3FJa0FNL3d1?=
 =?utf-8?B?cGZFdW1vcmlFdTRCQTF3eTRsSDFVYlJoaGZsL1JYWTNOUktBRE9KUG5OeFhZ?=
 =?utf-8?B?MGJ1VmhqakJnR1R0UlFVK2RvakdvelZZQ2p6R0ZXODZIdVdISFdKQ2RZVjRm?=
 =?utf-8?B?VTRadGJyWnAwN1p0NVdxaXB1TzNvcGhUMzV4TndWWjFXejIvMVhldXE4eEdO?=
 =?utf-8?B?VEp2aCtkMkRZUFdlZzd0YWJTL0xsK0RvT0tXL3d5TXgrTndRbXNKbE11UEdO?=
 =?utf-8?B?SjE5Z0JLc01rcTVPdVkvYmxIT2xkeEg0ZDBIelZsSHNlTnA2aXJEZHZQKzdX?=
 =?utf-8?B?azFOUGh2ZUVjTWUzb2FWOWUyVmprVjRYOGxvTlZBNnJZZ2VkMmE3M2c4dkw3?=
 =?utf-8?B?d0NYcTVhM3Q3WDIzZmZqeFk1TGYvaE5ZODFrczNYLzR1SGxPbm5PdEpIRi9u?=
 =?utf-8?B?NzZwa3lkblRWY2VzZGtQMGY2MytXOVdmdXl6cjNTVHQ2UWJNY2c0REhwdjZM?=
 =?utf-8?B?UlI2eDVTT2Y0TFB2L0ZrTGZjVW11d2FYWXI4Y3JzUmRJbFd1THdvQzBhK0dL?=
 =?utf-8?B?U1FpeCsvNHF0dGlpNU9zYVFQZUEzWlZiVTdrMzl4cUE0K05WMnRWdWcyOWxR?=
 =?utf-8?B?U2d4c2x4dndKU1M3L3U3cWhXSHc0OTZEYjV3c2xScnZKSU9nS3hyNExHZG8r?=
 =?utf-8?B?QkR6ZGpzekJGY1VDbnVSOGZlZ1FVbjhibFN6amFjY0lybUNscnpMNU9ybjQz?=
 =?utf-8?B?RFVYZVYxdFV0Tnh4K2V5Zld2M1piOUx5V0Y1NkdUeHJiNjg3RmpaVytNWG1P?=
 =?utf-8?B?VGFLaFRsVndUV0dmeW11Qy84SzV5V1drMnFETGlPRzBnellBK2F0aXVmWkxl?=
 =?utf-8?B?ZlB0YWQzYlV1Z0U2d29vSmpEWGFMUVEveWN2d0hzTWhsKzNqSmpEdWJ6SkNS?=
 =?utf-8?B?bkVnWDBtVndaajl4TnRMMitaUjVhTFh3cmJVVWJ3andUbEIyYU5leWhvTDJS?=
 =?utf-8?B?cmdSbGQzOGVVZHJIakZaME5jSW9xK2pqY3BSRkFOeGp3Mkd5aS9aVm15SE1Q?=
 =?utf-8?B?KzZac1RaeWRIaU9HUldmOHlrNndjTitkdGlmUXFRS1hXWXJmTWQvWExzRjEw?=
 =?utf-8?B?U0sxRW9sVDlpV2RpT3ZsNVIvT1dmSVpMNVBOMzZFL0ZOTmI0KzhGUkZkamt0?=
 =?utf-8?B?NzFRUGNHRzZHSEU4N3BVeHp2Q0IwVlFvKzBZWFFDMDFwNkhHYksrN2pva0ph?=
 =?utf-8?B?UHhrRnFPRTBOV2VUaDEvZzFpVjIyK3ZnYUZUa2ZiRXdGWmxBM0JvOHhsUk5E?=
 =?utf-8?B?eEhvOFJXaHRvaytMbGFZT1dpcjYxU1NLRXVNRHI0eWhMK1IrT21iQU5lRktv?=
 =?utf-8?B?SnVGOE51bzluYlFJY1JhRjlsWVhNb0I0R1VMNGZaM2VKSFAyS2dUZFYwcjJT?=
 =?utf-8?Q?P81EX/H6rflPLqJ7swkxzSI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVOZzc2WWdLN3ZIZkRqZXpuQUFTZUJWK0lzcTNzcmpDY0kyTTJmQURRcmxa?=
 =?utf-8?B?R2k3SEl0U0RETkZHY1hNTE1vTjFDZXlGOXFwbmFQUXpaNXEyaHRabmRHMFBn?=
 =?utf-8?B?WGp2ZzVwc21jalhXM0xjNnlLdERsWDdSTWZEWFA3Qk93NFNpZjhkMVoyd0dl?=
 =?utf-8?B?VE83NUJLR0k1dEhVa2Mzb1h1S1kzb1l2Y0VUQmNjV3BERVdlQllSRmlYWDQw?=
 =?utf-8?B?UDB4eDBNZXl1cXI2VVQxLzRBMlVSVW00S05UeG56V2FYVDZDWUIwb1ZpRHJk?=
 =?utf-8?B?SG0wRDRtN25xaUtHZUpGTUNOd2RzVmJEd1pVczk4eDlrL1pCSHA3R0ZHRVcv?=
 =?utf-8?B?RUdDa2NSc01yTzhadzhFRkNjZi9xN0JabHZSRGp6MDhoYmF2S3FKQWFLbzlj?=
 =?utf-8?B?K3ZWVXZ4RkN4amxRUXhzN0pKVzVGZEhoY1dqVFFUNzJpM2J3STRMQmJPOXZ3?=
 =?utf-8?B?R3dMRXZPRDhEQU9LOWFQOW1CeG9EYzEwQjdlSjVrR2ZxZ1VZNGVlZTljaUM0?=
 =?utf-8?B?Q2ZCei9mdCtFNDA5aVdGVEpEUTQ5RWxueElEaGRNWFJQWnIySEEzZ3hRM2Rz?=
 =?utf-8?B?ZVE1aXpmS0p2QVlpc1lEN3Z3bzZDUExlZ0l3U0FTSjRLQklpa3Njd1RCbm1U?=
 =?utf-8?B?blpvQjBiREVDd2VYQlI3djZhSjJEcHcyd3l3NE9Dd3c2aUtIVWkwdzVxd1Jr?=
 =?utf-8?B?cUVHZ1VxdEdIbW9HQm84ZnNhdnJvT3NVdjloWnVpUFArQmxhOWtGeWtEa3ho?=
 =?utf-8?B?WlhEREgvM2hmdGRiL0tNcjJXYmwxVEc0VHl3MW40WllJbFdxcXV2NmkwMFlS?=
 =?utf-8?B?TFNTVDNWUENrdW8rMlpCSHNLZW5neXFYVUx4bzF2aUdtdWdYR1NZNXBQdFFJ?=
 =?utf-8?B?ODVDemo3NTl6U1ZDeDUyMFJueHdvSldKQXBFeXdDNHZxSnFLRm5RNUR0OG1H?=
 =?utf-8?B?U3U5eFJXT21HampobldDbTFicWVBR0FmMzkralAwQXZlY2ppZ0lHRkJYdzZk?=
 =?utf-8?B?dWF4Z1BuaDZWVjZHNUF4cmlRN0J2ZlBrdFVvcmd3aDNuQ2wvV1pDMlNwZERG?=
 =?utf-8?B?RlpXbyttODJDMFVZTDV5WnVodDlxSWhraXFJdVZScjBJbDVFc3FyQWt3WXhp?=
 =?utf-8?B?OUgxakgrckZ3OWR3TnJ5aWpveXdNeldDYWhqWUdOV1VXNFBBZnJ2ays2eGFP?=
 =?utf-8?B?ZTNra1E2eHBublFwTTR5bmhKOUxrczQ3S3JaMDE3d3lZWjdFbUNRZHNMVWpD?=
 =?utf-8?B?MXFTaFo5Z1R6anRHTXZ5aU5Xc2ZYMVpnU2Z4bkpVR2tmbHJwN0RnbUVwaDZk?=
 =?utf-8?B?aDZtR1VKWlpkK25oVmIrL0F5RDlFMUtNSEhGbzhnWFl2ZE0rcmdMWWpEVUx0?=
 =?utf-8?B?dDIrSThrSmEwb0IxT3VtamFRaTlvSENRbUhVQU1MOTRGNnlxRWZ2WDZqbnF2?=
 =?utf-8?B?RTVGUk5sSlBFdEVHdEJqRllJd2crL0drTXhIdzNvRWFhUTdxLzRQNWZKcHZu?=
 =?utf-8?B?a0drcEM0alNzSVBsQjYwQTA3RCtaQU1QR2Y0S1JFVkpjUzRXb0s0R1pGSnV6?=
 =?utf-8?B?eE10cEo1SDljTjVtSWU2ZFNMZjFCMG84RW1MekpVdUVBa2MyeDYzeVl2Tk0y?=
 =?utf-8?B?YklDWUFhRkxVak1zUTZ2anRXU1oyNUpOd2NxSm1sTXYvUXZkQnpwRWhmUnc5?=
 =?utf-8?B?VnQyV2NFNVJ6TUFNUExlVTRUdXdVUHhvbTJZazZkckJBOXZHL1p2MGFrV2tY?=
 =?utf-8?B?N3JOeDlCZTZOZDhCR3NLeVl6UjdaV25hTml0amNsTmVnWUE5TnZSS1ZJZjlR?=
 =?utf-8?B?bXA0SXphYnFmcXIrdFZTbFdQcnFHRGlISHNORm5uQUdHMm43QnBhQk1IRVY2?=
 =?utf-8?B?NTlTeEJoK2F6Vkx3ZkxmNVpqRVJGQlZoVGlMVlNlQUU1dml3aGFja1RQbEE0?=
 =?utf-8?B?ZDRwSXJoTlg5WTRKUm5mRU5hQmNqMGtMRTZuRUZtUW52aU5TSDRuODd1Kzk2?=
 =?utf-8?B?dmpuQUYvbjlqUklRanp5Vk5QRUtNQncrRlhsYW9Ubkg1RGNud0pFY0RJMXp2?=
 =?utf-8?B?VDMvdHdxQ1hFaEpKZTdNWC9aWnpWdkdiYy8xTEhXa1RXMWt4RGFXUCtHa0lh?=
 =?utf-8?B?VjVBaHFKRngyT3JxZHA4RStob3loVlo2VW1zNms5MTcxWlFCY2d5djY1VHIz?=
 =?utf-8?B?U1BsNXRQWVdhVzFnVytjSjF4ZlRlSnoyVXh1TGdhMkhMd3ZpUzQ2eEhrOHZ0?=
 =?utf-8?B?enBmUEJpUWE5eVVaajczeU11cUU2KzJwekFxUm5tei8vRVJ5dWQ2dHJTZ1VT?=
 =?utf-8?Q?9Xdzl6a1CMV4HHK9qg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d9a8b0-398a-420f-78b3-08de5a506362
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 07:24:04.4364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpk4urdOiObP+IRVTPWO9Y9U21nIsEiwrTF3Qn2eIObOQEVYq/I6HyO5etLns6hS8YlcgkXu+U5AYyN17Xejyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVS1Cb290IDx1LWJvb3QtYm91
bmNlc0BsaXN0cy5kZW54LmRlPiDku6PooaggTWFyZWsgVmFzdXQNCj4g5Y+R6YCB5pe26Ze0OiAy
MDI25bm0MeaciDIy5pelIDIwOjM0DQo+IOaUtuS7tuS6ujogRXJuZXN0IFZhbiBIb2Vja2UgPGVy
bmVzdHZhbmhvZWNrZUBnbWFpbC5jb20+OyBDaHJpcyBNb3JnYW4NCj4gPG1hY3JvYWxwaGE4MkBn
bWFpbC5jb20+OyBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+OyBBbGljZQ0K
PiBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDmioTpgIE6IHUtYm9vdEBsaXN0cy5kZW54LmRl
OyB0aGluaG5Ac3lub3BzeXMuY29tOw0KPiBuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnOyBxdWlj
X3ZhcmFkYUBxdWljaW5jLmNvbTsNCj4gZmVsaXBlLmJhbGJpQGxpbnV4LmludGVsLmNvbTsgbWtv
cnBlcnNob2VrQGtlcm5lbC5vcmc7IGx1a21hQGRlbnguZGU7DQo+IHRyaW5pQGtvbnN1bGtvLmNv
bTsgbWFjcm9tb3JnYW5AaG90bWFpbC5jb207IFRoaW5oIE5ndXllbg0KPiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT47IE1pYW4gWW91c2FmIEthdWthYg0KPiA8eW91c2FmLmthdWthYkBpbnRl
bC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCBWMiA0LzRdIHVzYjogZHdjMzogY29yZTogaW1w
cm92ZSByZXNldCBzZXF1ZW5jZQ0KPiANCj4gT24gMS8yMi8yNiAxOjE1IFBNLCBFcm5lc3QgVmFu
IEhvZWNrZSB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAxNSwgMjAyNiBhdCAwNTowMTozNVBNIC0w
NjAwLCBDaHJpcyBNb3JnYW4gd3JvdGU6DQo+ID4+IEZyb206IENocmlzIE1vcmdhbiA8bWFjcm9t
b3JnYW5AaG90bWFpbC5jb20+DQo+ID4+DQo+ID4+IEFjY29yZGluZyB0byBTeW5vcHN5cyBEYXRh
Ym9vaywgd2Ugc2hvdWxkbid0IGJlIHJlbHlpbmcgb24NCj4gPj4gR0NUTC5DT1JFU09GVFJFU0VU
IGJpdCBhcyB0aGF0J3Mgb25seSBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLg0KPiA+PiBJbnN0ZWFk
LCBsZXQncyB1c2UgRENUTC5DU0ZUUlNUIGlmIHdlJ3JlIE9URyBvciBQRVJJUEhFUkFMIG1vZGUu
DQo+ID4+DQo+ID4+IEhvc3Qgc2lkZSBibG9jayB3aWxsIGJlIHJlc2V0IGJ5IFhIQ0kgZHJpdmVy
IGlmIG5lY2Vzc2FyeS4gTm90ZSB0aGF0DQo+ID4+IHRoaXMgcmVkdWNlcyBhbW91bnQgb2YgdGlt
ZSBzcGVudCBvbiBkd2MzX3Byb2JlKCkgYnkgYSBsb25nIG1hcmdpbi4NCj4gPj4NCj4gPj4gV2Un
cmUgc3RpbGwgZ29ubmEgd2FpdCBmb3IgcmVzZXQgdG8gZmluaXNoIGZvciBhIGxvbmcgdGltZSAo
ZGVmYXVsdA0KPiA+PiB0byAxbXMgbWF4KSwgYnV0IHRlc3RzIHNob3cgdGhhdCB0aGUgcmVzZXQg
cG9sbGluZyBsb29wIGV4ZWN1dGVkIGF0DQo+ID4+IG1vc3QgMTkgdGltZXMgKG1vZHByb2JlIGR3
YzMgJiYgbW9kcHJvYmUgLXIgZHdjMyBleGVjdXRlZCAxMDAwDQo+IHRpbWVzDQo+ID4+IGluIGEg
cm93KS4NCj4gPj4NCj4gPj4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggd2FzIHN1Ym1pdHRlZCB0byBM
aW51eCBpbiAyMDE2IFsxXSwgaG93ZXZlciBJDQo+ID4+IGNhbiBjb25maXJtIGl0IGlzIG5lZWRl
ZCB0byBzdXBwb3J0IGdhZGdldCBtb2RlIGluIFUtQm9vdCBvbiBteSBkZXZpY2UuDQo+ID4+IFdo
aWxlIEkgYW0gcmVmZXJlbmNpbmcgdGhpcyBwYXRjaCBmcm9tIExpbnV4IEkgYW0gaW4gZmFjdCB0
YWtpbmcgdGhlDQo+ID4+IGZ1bGwgZXhpc3RpbmcgZHdjM19jb3JlX3NvZnRfcmVzZXQoKSBmdW5j
dGlvbiBmcm9tIExpbnV4IGFzIGl0IGV4aXN0cw0KPiA+PiBpbiB2Ni4xOS1yYzUsIHNvIGl0IG1h
eSBkaWZmZXIgc2xpZ2h0bHkgZnJvbSB0aGUgaW5mb3JtYXRpb24gaW4gdGhlDQo+ID4+IDIwMTYg
cGF0Y2guDQo+ID4+DQo+ID4+IFsxXQ0KPiA+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvcGENCj4gPj4gdGNoL2RyaXZl
cnMvdXNiL2R3YzM/aWQ9ZjU5ZGNhYjE3NjI5M2I2NDZlMTM1ODE0NGM5M2M1OGMzY2RhMjgxMw0K
PiA+Pg0KPiA+DQo+ID4gSGkgQ2hyaXMsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgd29yayBo
ZXJlLiBXZSBhbHNvIGhhdmUgaXNzdWVzIHdpdGggZ2FkZ2V0IG1vZGUgb24gdGhlDQo+ID4gaU1Y
OTUgRFdDMyBJUCwgbm90aWNlZCBvbiBvdXIgQXF1aWxhIGlNWDk1IFNvTS4gVGhpcyBwYXRjaCBz
ZXJpZXMNCj4gPiBmaXhlcyBvdXIgaXNzdWVzLCBidXQgb25seSB3aXRoIGEgc21hbGwgY2hhbmdl
Og0KPiA+DQo+ID4+IC0JbWRlbGF5KDEwMCk7DQo+ID4+ICsJZGV2X3dhcm4oZHdjLT5kZXYsICJE
V0MzIGNvbnRyb2xsZXIgc29mdCByZXNldCBmYWlsZWQuXG4iKTsNCj4gPj4gKwlyZXR1cm4gLUVU
SU1FRE9VVDsNCj4gPj4NCj4gPj4gLQkvKiBBZnRlciBQSFlzIGFyZSBzdGFibGUgd2UgY2FuIHRh
a2UgQ29yZSBvdXQgb2YgcmVzZXQgc3RhdGUgKi8NCj4gPj4gLQlyZWcgPSBkd2MzX3JlYWRsKGR3
Yy0+cmVncywgRFdDM19HQ1RMKTsNCj4gPj4gLQlyZWcgJj0gfkRXQzNfR0NUTF9DT1JFU09GVFJF
U0VUOw0KPiA+PiAtCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HQ1RMLCByZWcpOw0KPiA+
PiArZG9uZToNCj4gPj4gKwkvKg0KPiA+PiArCSAqIEZvciBEV0NfdXNiMzEgY29udHJvbGxlciAx
LjgwYSBhbmQgcHJpb3IsIG9uY2UgRENUTC5DU0ZSU1QgYml0DQo+ID4+ICsJICogaXMgY2xlYXJl
ZCwgd2UgbXVzdCB3YWl0IGF0IGxlYXN0IDUwbXMgYmVmb3JlIGFjY2Vzc2luZyB0aGUgUEhZDQo+
ID4+ICsJICogZG9tYWluIChzeW5jaHJvbml6YXRpb24gZGVsYXkpLg0KPiA+PiArCSAqLw0KPiA+
PiArCWlmIChEV0MzX1ZFUl9JU19XSVRISU4oRFdDMzEsIEFOWSwgMTgwQSkpDQo+ID4+ICsJCW1k
ZWxheSg1MCk7DQo+ID4NCj4gPiBPbiB0aGUgaU1YOTUgSSBhbHNvIG5lZWQgdGhpcyBkZWxheSB0
byBnZXQgZXZlcnl0aGluZyBmdW5jdGlvbmFsLiBJZiBJDQo+ID4gcmVtb3ZlIHRoZSBjb25kaXRp
b25hbCB2ZXJzaW9uIGNoZWNrIGhlcmUsIGl0IHdvcmtzIHdlbGwuDQo+ID4gJ2R3Yy0+cmV2aXNp
b24nIGlzIDB4NTUzMzMzMEIuDQo+ID4NCj4gPiBJcyBhbnlvbmUgYXdhcmUgb2YgdGhlIERXQzMg
cmVxdWlyZW1lbnRzIG9uIHRoZSBpTVg5NT8NCj4gTGlrZWx5IEFsaWNlIG9yIFBlbmcuDQoNCkhp
IEVybmVzdCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIG9uIGkuTVg5NS4NCg0KSSB0
ZXN0ZWQgdGhpcyBwYXRjaCBzZXJpZXMgb24gdGhlIGkuTVg5NSAxOXgxOSBFVksgYm9hcmQgd2l0
aCBVU0IgU0RQIGJvb3Qgb3ZlciB0aGUgVVNCMyBpbnRlcmZhY2UsIGFuZCBpdCB3b3JrcyBjb3Jy
ZWN0bHkgd2l0aG91dCB0aGUgYWRkaXRpb25hbCBkZWxheS4NCg0KVGhlIFVuaXZlcnNhbCBTZXJp
YWwgQnVzIDMuMCBDb250cm9sbGVyIG9uIGkuTVg5NSBkb2VzIG5vdCBuZWVkIHRoaXMgZGVsYXkg
aW4gbXkgdGVzdGluZy4gQ291bGQgeW91IHBsZWFzZSB2ZXJpZnkgdGhhdCB0aGUgVW5pdmVyc2Fs
IFNlcmlhbCBCdXMgMy4wIFBIWSBpcyBjb25maWd1cmVkIGNvcnJlY3RseSBpbiB5b3VyIHNldHVw
Pw0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
