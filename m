Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8385C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 08:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A90380F70;
	Mon,  3 Mar 2025 09:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GbsgzusF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9700810EA; Mon,  3 Mar 2025 09:04:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CC5809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 09:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxONlTFQ028xCtaKCfJMr1TxyDqm49vVGE2xcnmalxEvY9GJT9W8I+O2N7iyZUptXRUaGshqqG0IDGgjTiJM8drNBfzk1hGZdNNdTWnVQR9XQXRII3YLcDwW+PnQbS2EAawk7WpQYEp7dlf8tnyBNkrVWLEJXZVQ4xlJfaF0t2VBD6B4ya4B6E9GiF86OyXD96h/i0xPeVUv+pr20kMS4rjDBjezQQNxJbjhamaPLnnUVW7fwUKVAmFTB1u8XzFTTah4v3zd6Y9X/x7T8a6aDW4sA3/1G4xZnx+z3pUXWxHfUHHOwn1skLFc4fllvZyNmZozrOlUFAzD1VQ+AmRzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU1QqH4JIgVq2PGY82V3Im62FbNvNAoGrUeek1pTx6g=;
 b=L1uTYF4y6xwI4TemVZhP518i+yR+Gd+0tQgL7oSWd8CKAJERmOLeyfNgcEQPMUJXXzwjf8CdxH6xOVfbxOHFPthvBw97rYn+sSX+53SugoXwlP1WyTCdKf4/+KORGnMjFIjLQ/m5h2c25LMh7KjmXTwXjQYCcispwy4oyh++TGTBp43qnHyM4NV/z0mo5ezooMJuq98tD6Fu888ieFf8nXaptlpW6gv1uvLmudcpigDyCu5PS5PNPqaHTH3tilQkg+kdAO+uVdwy+i5yOq/WOSperOwkdDiWdRhK5H6MBJZb/QBVOMUIsDjbmsg8/hgg2KeRCtLvM3lYdo5yduprZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1QqH4JIgVq2PGY82V3Im62FbNvNAoGrUeek1pTx6g=;
 b=GbsgzusFdvYAUwqAsCpzMnsbonjneh1s28fDZIBeEU4oGU1NRG7Am6NvY8yBMQlQFgq71o7L6iGZqhMouAjYy0y1L7ETwPwLDcRVmnRenKCGDuKDDdllrZhl3T6sN4Pl5JMqj7ulEUDIIi9TRFeqk8fVs9KkHLSKiXSHfQ41HWLrUhyQcsbK5jwmKhUfr3H2ilAVauW74j3/hdqCT6DOSYuDqlHy+YYU82L5Ryu/Pi4Bzfn/CUjAYyfIx/ZRKoSFwLO4prBq81bmx0HwJV7l/zSgyZPvws6NHbYC4NOdccPONeWsGFMegOTZTRT7cOHdfouI4CkZAcwn/fEs5Zfqdw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 08:04:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 08:04:38 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogu9i4tDogW1BBVENIIHY0IDA0LzIwXSBmaXJtd2FyZTog?=
 =?gb2312?B?c2NtaTogYWRkIHBpbiBjb250cm9sIHByb3RvY29sIHN1cHBvcnQgdG8gU0NN?=
 =?gb2312?Q?I_agent?=
Thread-Topic: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHY0IDA0LzIwXSBmaXJtd2FyZTogc2NtaTog?=
 =?gb2312?Q?add_pin_control_protocol_support_to_SCMI_agent?=
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbNQy1yAgAA15YCAAQ5sgIADuNAAgAdZAACAA/8voA==
Date: Mon, 3 Mar 2025 08:04:38 +0000
Message-ID: <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
In-Reply-To: <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI1PR04MB6848:EE_
x-ms-office365-filtering-correlation-id: e25337fe-f219-460a-24e4-08dd5a2a0b81
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?NVMySlJZNzg5bjhEdGFmK1J2alMxQ1BVZVJTN1c5bUhSV2lRaUdiaVd2WlVs?=
 =?gb2312?B?ZkJhck91dWI5cnZMNVNzMnRtM2dqQU1sT2dnWlplQm9UR2s5c0pjdDFWeVVz?=
 =?gb2312?B?d1NnRVBSSlcyWDQyN3ZwYWc2Sm5VQ0JUditDVHBJOTh0RUNZdzNPQlVTMmtD?=
 =?gb2312?B?bUVkQjZxdmJWUys5aTh1NUFDa2h2R29hUmhoZG5WenRqeStZTk8rOTVpcVZN?=
 =?gb2312?B?cFJRdGtoV3UzOFhKdk9uSEJGcjZtR1NEcG9Wa3ljaHc5NWxEUkFIZ0lvNk9o?=
 =?gb2312?B?Z0FxYzREWVhsZ3p4RXIwRWJNekdyVS9YM3FxcHV1Tm1acThTTTlPVDFvY0Yx?=
 =?gb2312?B?cmdyRzlHZisyWkxHNU1wbGc4TDdiUDRvaVg1NE9qL1RiRGpJc201VlhsZi9m?=
 =?gb2312?B?YzBxMnVERkNTVU02SHh2ZFRQRzVHWE00amI0MitodUk4L3NmT2prcmtlbHJp?=
 =?gb2312?B?b3pCWC95UXVkNUhSSjNPUDYwZVFOWmxqUUNzTit3bDBjSkNZKzBCUDE3NzlV?=
 =?gb2312?B?RVZldFh6OWlySWU3bjhNSmxlWm1IUXNsQWc4R0NDODdOZVV4dHFodGVNQ0hL?=
 =?gb2312?B?aG42bkwxd2tUcnJrbmJDTWVLQUREOU53c2VyN2dTTWVneGdyQVVFSXpIbk54?=
 =?gb2312?B?R0hYU2hIUmI2REFZMUZmUEczTmxuZHp0MXg5bWVHUUFPMUZqWmtSSFkreVVB?=
 =?gb2312?B?YjZKQURtbGUrL2lEZ0c4aTMyeUNQZmZ6SFdPeTJGSnkrVlV4Y1I3ZVFyZWJK?=
 =?gb2312?B?MEdJSmExamFPaXQzUTRNRmtOY2E3UnppSnZTdFlhZU1GdjFrQmJDb0FuYzV0?=
 =?gb2312?B?bmd4aUlhaGRaSVgzZkxHMHdlNUdJTUdjWGNKOXBTRy9mdUhaV0NvK3hHSFRS?=
 =?gb2312?B?T2JUTzUyaHdqb252RkNONGlzY2NkY0VYWjl1ZXZNcTdEVjEyWk5ZRStDUEYy?=
 =?gb2312?B?ZGg2ZURrWmFmWWRXTzh0SDZxUFJpM3pKVDg0Rzl5SVlIOEVDL2p6YlRwRXNj?=
 =?gb2312?B?dHBuNWljTkxLeUZZZXBIdk9XcTNrL1E3SmpwQmN5V1ZCMVNNeEdveXBiTjJR?=
 =?gb2312?B?YXFrLzljcXFtaXN2K1M3V2hidkkzRVNsRVVacDFLYldkcGVlYjF0MTZXeFFk?=
 =?gb2312?B?OFB0UGJ5N0tvYnphZTZGY0xKM2FjYXZSVnJRaDBJMVIvNlhSTWsrakVKOTZE?=
 =?gb2312?B?SFlSb3R1VDBYaXhBd2ZtV1ozS1lLU1VGM2o4VFZhYTluUUJtSmg4OGIyZTRs?=
 =?gb2312?B?a3hidWtkK3ppSnVsMTBidVM2OFV0L01SVHhBS3lvSE9CRjE3OGZjckVYZDZ1?=
 =?gb2312?B?T3pWTldHV2lWRFpHaUVVRXpud0NhZ2FCM3FTV01yOFJjQXZvSTJyMWZ4RnlW?=
 =?gb2312?B?QmEyMDE2TC9HNlRucGg5YTVDUllPUFo4d3Z6NWhkR2dVQUtWdjl3Y0U0Z3Ro?=
 =?gb2312?B?VldiSmpMbnRPWWtGTEJUNGgwUVFGb3U0WnlEVHo5eVFwWk5VMnoxZlVXVDF6?=
 =?gb2312?B?TGVlbTArdjhhVm92T0tWRHV4QUxtTitGOFUrU09PdFhFd1dJQjBQcSs2eWZT?=
 =?gb2312?B?SWtNdnBTYTZEMVdUN2N2TGlHN3BobUV5clptZkJqT0RHMWVSN0NaZUJ4S20z?=
 =?gb2312?B?VUF5MFQ0b2FkM1ZIY1c5NE5IQ2Y5Q0RQMnRHTjcxcTNMZGFkd1A4aEdIQTZP?=
 =?gb2312?B?QjkzZHB6aHhqZW5aaEw4TEdtQ0Ura1dGWDBRbXVCTGdIRjFaSU1WTndabjhH?=
 =?gb2312?B?a3JtaVVjOXhrNHdYVkVuYWhpZ0pUUXdrc2hmNVR4U2drc0ErUDR1MVQ5VStX?=
 =?gb2312?B?cFgweHorakJZRENjTzdBNTNxcldwaFhqb0hDUDBhU21oVUJ6U3U5cmErdHRP?=
 =?gb2312?B?anRHRmhONUJRMm5xYkg4WFlTREZzOENQcVNEcWVadDJmY2dSVmpoaElaWVFT?=
 =?gb2312?Q?cbWGhoj26LQBpktNTiGDdzat3e8c+Vn2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MFBFM25mME43KzdacWxLRzRtUkdxTFFiMzdFQVNLN283azhkRStSRm11ZTZ0?=
 =?gb2312?B?cnlXYVFYcnFYQUxHSnp4SlV0OXBEVFJKUnBqNkh3Um5uNFFiSGlnb2ZQL2hx?=
 =?gb2312?B?Ym9YMEVMcFhrRFlSTE1DSThkS09WNHg5OXZoYVh1c1Nmb1Zjd0llcC9XcFRE?=
 =?gb2312?B?RnpZL0VWYXc4Q00zWkxadXNVK2hGc0pmTHMwb0s1R2FQUVJtQUxIdFU0OEtq?=
 =?gb2312?B?R0p6bHNpVldNNkVQQjFiNFMvWUs2UmlKcjU4UEYveG1obko0MUNDRE1kekFu?=
 =?gb2312?B?WTd6RHQxd25wYmFDUGNGTlZHbllSanpwa0tJaFBNYmRleXQvejJ4Q1pEcjR6?=
 =?gb2312?B?K1E1cCtpTVk1NDF0aVdkVlhFclhJZTg1d1daTnVDMzJXL2JtTnhjeEYycHdN?=
 =?gb2312?B?YW5lSDkvRHByNVJodUc5TThlRG5YazRGbHM4OHNhUGhWMXBSTWtqeFJXcWpi?=
 =?gb2312?B?Qm14d1ZBN1dFTG5XNzlYNENoSG1PY0NsOXdOV3BrVkFwbndCcmNad05rNEJP?=
 =?gb2312?B?c0tiZDRCRFJ3cVJaL3pDM1NqOWcvQXcvUzQ0MnEvTW5JQVFDN3ZYTFhKZ2pG?=
 =?gb2312?B?bHZMQ3J0WmV1N3lGRFZka0w0WFRsalFoRWpYQWkyczQ1TzFxcDljaUxBM2VP?=
 =?gb2312?B?U1JVTnJqa05SMEthUWZ6NXlndk42RGFJMDVMckI2SkNzZ2dELzVWanJPV3BS?=
 =?gb2312?B?U09hb1ViMkw3aDBXeUhNWmZrYm1kSG9vRTdGQjlmbHJIV0l3NDkxSldIdzJH?=
 =?gb2312?B?dWhKVTNkQnNEQ3krVEFtdlI5bEx1ME94dm90dzBMWlliZHZjNE41U2xhTDhY?=
 =?gb2312?B?bGtzUVZ0QjFXbHo0dC9iTnNOV3VRM01ZRGhwaXhYR0laT2t4UXNpbXBTY3pZ?=
 =?gb2312?B?VkpHUk1VUmVma1M1Q2ZaSERlaXhiZDIxN3ZOTHFaWmVHVTZrcXRJYXY5amJk?=
 =?gb2312?B?SERSZlI0RHFEZWtwaU55NDhDY0JXSitOZGtjVmMzbmwvd2N0V1N2cmJHMlJV?=
 =?gb2312?B?WW1NK014ZjJJYmxPMnRnZVVTRFZCSVA4SEZEM1c2V3kxRUNURW16dVZSZ1FI?=
 =?gb2312?B?OWx5d2E1NEJCS3J2SHVuU3p4dEcwdXg3Wmd0bzBDQ0VyVnZYOXI3WVBiZXlU?=
 =?gb2312?B?SjBWWWlWUzcrY1l6eEJib01EU1hXM3BVTkp4aUhWR2tVSWM0Z25DRlpHSXZU?=
 =?gb2312?B?Ri9Wc2doODd2RWtrd0RocWxmMHhnTHZGOEdEWkFsZUJ6R2NqaENrRlg4SGRD?=
 =?gb2312?B?bTc0TXc3Yk1adnhOL2VKcFZWVi9vdzFZQ1Q5OXIrcHQ3TGFpMGVqWjRva29V?=
 =?gb2312?B?TlZZemN6VUNVR0FrMGc1Z3JMY2ZGN1Uzci9wTmd0ekVrOFI1cUMxZVR5RmpH?=
 =?gb2312?B?WWNjamo0andMVmhtSE0xa1RIL2wzT0dBT0pMaldzMnppRmtPVFZ4cTFuQUIy?=
 =?gb2312?B?QmxKYXFUZmdSZm1PYUdkVGNYV3hzczZPYjZPWG9qSStQOEljQ0dodW00RzlG?=
 =?gb2312?B?NzhoLzhEb3Rzb0NtZXNQdzZDZDQzY3I5OExybnNWcVEzc01JWjFSWW4zN3Zv?=
 =?gb2312?B?K2F1NTFHeTlJTE1UYkp5VmxyQXBOdm5HNk85QTVzbUpjQVhOQlBZdE0wRFBZ?=
 =?gb2312?B?MzN5MDJJU3ROV0Uxc09ZamM4ZjNIVldPRUlCV0thbEFBVm9JNkIxWkhlaUEw?=
 =?gb2312?B?Z3VRUDRCMkF5TjNwOXllTUJ3dDRDVEZvUXVYNlIzZERKMGd1MmJiNEdFeGtW?=
 =?gb2312?B?THBVS1NjUk01dm1MU21GRkNzSzJ6ZjZmY0pnWS9BMXpjSUxrQTFZMUV4bjgv?=
 =?gb2312?B?V3pzWmZ0SERpTVNydXdjUEVVSVNzOUY5dTI0Wnk3N3N0ZlFwU3RhakUvMjYx?=
 =?gb2312?B?SmxxbTN6TzFPMUlVT3EyUUtIOUZ1Wk9GWVY1WDNrMUNLWFBhSUNCMEZZbDdz?=
 =?gb2312?B?cEo0VzJFenpPL0c3UDUvaGRZWmg3ZEtyWTBsLzBUWTJJMGZrcUtlZmNXQmNn?=
 =?gb2312?B?aWFvT2M4anFDYm85dlJnY3dFaEp2dHE2elRwbEhJUURjTitjSGlDY2xjSmZz?=
 =?gb2312?B?YXJHRWhHWUZuNkwxZXpYNXRMQ3M1cDJZUjF3STl2Q3F6VlZrUlJOUUFVNVht?=
 =?gb2312?Q?qh9s/MRN7EKHDWGeYtP+vMBHm?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25337fe-f219-460a-24e4-08dd5a2a0b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:04:38.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R36b3PkcyPvVpznZG29ZpL2sxZq/b5jd+eNIFeInjIprZ5YzirRI1pYvvGdEXQX9/18h51K8Emq8PO7OfZzMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jPUwjHI1SAyOjU4DQo+IMrVvP7IyzogUGVuZyBGYW4gKE9T
UykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiCzrcvNOiBBbGljZSBHdW8gKE9TUykgPGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVm
YW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdt
YWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFq
ZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47
IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxw
ZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gdS1ib290QGxpc3RzLmRlbnguZGU7IHRoYXJ2ZXlA
Z2F0ZXdvcmtzLmNvbTsgQWxpY2UgR3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g1vfM4jog
UmU6ILvYuLQ6ILvYuLQ6IFtQQVRDSCB2NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6IGFkZCBwaW4g
Y29udHJvbA0KPiBwcm90b2NvbCBzdXBwb3J0IHRvIFNDTUkgYWdlbnQNCj4gDQo+IE9uIDIvMjQv
MjUgMzo0NSBBTSwgUGVuZyBGYW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+Pj4+PiBA
QCAtNDM2LDYgKzQ0MiwxMSBAQCBzdGF0aWMgaW50IHNjbWlfYmluZF9wcm90b2NvbHMoc3RydWN0
DQo+ID4+Pj4+Pj4gdWRldmljZQ0KPiA+Pj4+ICpkZXYpDQo+ID4+Pj4+Pj4gICAgICAJCQkJZHJ2
ID0NCj4gRE1fRFJJVkVSX0dFVChzY21pX3ZvbHRhZ2VfZG9tYWluKTsNCj4gPj4+Pj4+PiAgICAg
IAkJCX0NCj4gPj4+Pj4+PiAgICAgIAkJCWJyZWFrOw0KPiA+Pj4+Pj4+ICsJCWNhc2UgU0NNSV9Q
Uk9UT0NPTF9JRF9QSU5DVFJMOg0KPiA+Pj4+Pj4+ICsJCQlpZiAoSVNfRU5BQkxFRChDT05GSUdf
UElOQ1RSTF9JTVhfU0NNSSkgJiYNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJcyB0aGlzIHBpbmN0cmwg
cHJvdG9jb2wgcmVhbGx5IGlteCBzcGVjaWZpYyA/DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSWYgbm90
LCB0aGlzIG5lZWRzIHRvIHVzZSBzb21lIG90aGVyIGNvbmZpZyBvcHRpb24gdG8gZ2F0ZSBhY2Nl
c3MgdG8gaXQuDQo+ID4+Pj4+DQo+ID4+Pj4+IEN1cnJlbnRseSwgaXQgaXMgdXNlZCBmb3Igc29t
ZSBwcm9kdWN0IGZhbWlsaWVzIG9mIHRoZSBpLk1YOSBzZXJpZXMNCj4gcHJvZHVjdHMuDQo+ID4+
Pj4gSXMgdGhlIHByb3RvY29sIGlNWCBzcGVjaWZpYyBvciBpcyBpdCBnZW5lcmljIHByb3RvY29s
ID8NCj4gPj4+DQo+ID4+PiBTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkwgaXMgbm90IHVuaXF1ZSB0
byBpTVgsIGJ1dA0KPiBkcml2ZXJzL3BpbmN0cmwvbnhwL3BpbmN0cmwtc2NtaS5jIChkcnYgPSBE
TV9EUklWRVJfR0VUKHNjbWlfcGluY3RybF9pbXgpKSBpcw0KPiBvbmx5IGZvciBpTVguDQo+ID4+
IFRoaXMgcGF0Y2ggaXMgY2hhbmdpbmcgY29tbW9uIGNvZGUsIGl0IHNob3VsZG4ndCBiZSBsaXR0
ZXJlZCB3aXRoDQo+ID4+IHZlbmRvci1zcGVjaWZpYyBpZmRlZmZlcnkgb3IgaWYoSVNfRU5BQkxF
RCguLi4pKWVyeSAuIENhbiB0aGlzIGJlDQo+ID4+IG1hZGUgZnVsbHkgZ2VuZXJpYywgc2ltaWxh
ciB0byBlLmcuIHJlZ3VsYXRvciBwcm90b2NvbCA/DQo+ID4NCj4gPiBJbiBMaW51eCBLZXJuZWws
IHRoZXJlIGFyZSB0d28gZHJpdmVycywgcGluY3RybC1zY21pLmMgYW5kIHBpbmN0cmwtaW14LXNj
bWkuYy4NCj4gPiBCb3RoIGZvbGxvd3MgQVJNIFNDTUkgMy4yLCBidXQgcGluY3RybC1pbXgtc2Nt
aSBoYXMgc29tZSBzcGVjaWFsDQo+ID4gc2V0dGluZ3MgdG8gYWxpZ24gd2l0aCBpLm14IGlvbXV4
YyBhcnJheSBiYXNlZCBzZXR0aW5ncywgbXV4LGlucHV0LHBhZCBhbmQgZXRjLg0KPiA+DQo+ID4g
SW4gZ2VybmVyYWwsIGlteCBwYXJ0IGNvdWxkIGJlIG1lcmdlZCB3aXRoIHBpbmN0cmwtc2NtaS5j
IGJ1dCB0aGF0DQo+ID4gd2lsbCBtYWtlIGNvZGUgbm90IGNsZWFuLg0KPiBJbiB0aGF0IGNhc2Us
IHdoeSBkb2VzIFUtQm9vdCBub3QgaGF2ZSBwaW5jdHJsLWlteC1zY21pLmMgdG8gY29udGFpbiB0
aGUgaU1YDQo+IGN1c3RvbWl6YXRpb24gdG9vID8gSWYgdGhpcyBwcm90b2NvbCBpcyBJTVggc3Bl
Y2lmaWMsIGl0IHNob3VsZG4ndCBiZSBpZmRlZmZlZCBpbg0KPiBjb21tb24gY29kZS4NCg0KSXMg
aXQgYWNjZXB0YWJsZSB0byByZW5hbWUgIiBkcml2ZXJzL3BpbmN0cmwvbnhwL3BpbmN0cmwtc2Nt
aS5jIiB0byAiZHJpdmVycy9waW5jdHJsL254cC8gcGluY3RybC1pbXgtc2NtaS5jIj8gU0NNSV9Q
Uk9UT0NPTF9JRF9QSU5DVFJMID0gMHgxOSBpcyBub3QgaS5NWCBzcGVjaWZpYy4NCg==
