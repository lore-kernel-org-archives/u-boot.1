Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782ADF8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4539C8435B;
	Tue, 21 Apr 2026 14:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="coddHdB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133C58441A; Tue, 21 Apr 2026 10:38:12 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877918435C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eyvkob+NMvyZqlOkvvv8HxVMTY4radUZqzIo/sxWB9isPDgXC3pnb0PHCQTC9B5htCxNjzqYBu/7frodNdTWbvMuUbjxEdQUcxbgoOc+gshU78is3XzdRqeehRC06djrqRDJqP7EfLaFSt3/j8aimQ+bN73QmsphtFY2MfQHSPLw8qAIHZpKTmAyTzD8Q5WB6Qdit/gqBmZPL4g72SZY7zqDz9lttjLhik5KxkSlPr6GGKC28PmjynQs7CHyp+3L4qqeg3cBANmW576/o6D1UaOlDQqv/42v2nEtc1n/U42QC/Jr2bZK2fIHgnJNpQKBN3cZdZlJJXDW+W4+bTsovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgE6KVtv4ajsvS5NMDzqltVWObkaJdOHe4kTfPxlF3o=;
 b=E2/BD+99cAXlVt9PuOB6NgepAWoYOxMrDXyGzEaInhDqw7QmtVfjZ4kHcpTboYxGz8rsAQHnAYR3ecSSPyE3/yR1coxvwwUJa7uGo68eYXsFVFLBLG2L1Ep1xAekYEah5QHkXontlBSiDEYPG8afViMKaLJnsygl8uTtsTxdKP2A1J5LFdmhIBV/emHe9zo8VJz2q+AKT2G60t5cYVu7qJWsKIKu7USx6ZJ5+pPBiqAQs9s0qbODzQYuC3YgXiHiCNAXCAFzpOTxRBxSEvYe5coLRoQM8b7NCy8soMw0Mkzj1OLHJQE6cTB/ug8GesZ92Nj1GiFKxo/SBSLC55Yixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgE6KVtv4ajsvS5NMDzqltVWObkaJdOHe4kTfPxlF3o=;
 b=coddHdB/DWXKststDRG0RMlcchNuuuhTE68QSbIlnhyGsn3ttbtZUMP+JUstPkcQcDX/1MXQ7o2t9JL5fhCsquayn5QYVF3rbwP54FY70Chtt+MXltpArWoS4uC+HBaiSMoftCk1htQd/Ejthu1d8qObNzmbCucouqdqk/n0jwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA4PR04MB7550.eurprd04.prod.outlook.com (2603:10a6:102:f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 08:38:05 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 08:38:05 +0000
Message-ID: <4bc9cdaf-38bc-4edf-b19f-d7301c84b49c@cherry.de>
Date: Tue, 21 Apr 2026 10:37:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] net: make NET a menuconfig (and downgrade NO_NET to a
 simple config)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alvin@pqrs.dk>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Adam Ford
 <aford173@gmail.com>, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 David Lechner <dlechner@baylibre.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, Max Merchel
 <Max.Merchel@ew.tq-group.com>, Sean Edmond <seanedmond@microsoft.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
 <18031190-2B66-4DEF-8382-6CB9DCCFA3A1@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <18031190-2B66-4DEF-8382-6CB9DCCFA3A1@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA4PR04MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: c3445b3b-5dd3-4bf2-1e2a-08de9f814eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info: qoGZGm/WdcnNtiw0ioutf0eVXc1kKp3aU41kyqDI1kCrQQ1RLVU327q5D7g7tMtqIiaW9zphhANSJhsQXcDRYctcBkV7mpAPIClGQua28SbHgxXgOUnyjGFTroK+CR07u27cj1md2AzD0Ep0NHYaCrUZ5pAJJ0vuwtxnypxGUAY+36Lnm2oQVVsbJoCC+dLUfROgD/rx8fjL0LJ04ZyjV6URw09X4DPeciNofn/XtSwVJRZAEqPbaRYpvKLQJNghgjcrOONsOh15jXmTe58cfcfzuMZMoXNvWwetJY92bs1E91WAUxYGxz6pzD1tu+OHNSyTqiDHkDnGrc1PplPlxk5yGHjOP32QR8+a0Ggyu3E8bwhKUptSrWtI3XSM9/0y3sYBstyIZSoEFzJxuhgh5Ty9fdfkHq3Ypx7mJguxibgXFq95Kod8yiiWeo7LsqUOa6FZGIDPH+k8ifKgyhbJJthArQfFXXnzURnEB3ceeKwJukXKc/9Mrm9bnVRhjka7YPt3ivD1kBLiQgyeUlE0mqYWgm7EW+A7fi72XHOT4gsBOMKvCNDi0ArlCx/9JiaruVPt7vwsLuMjPLBlsEKM6ShxZyMkC0S/sH7tKXcfDk0XIydEdjGizrW6CoD3IEHkoy9tYRsIIyUtB09k2gXtpTghtaNxCer6G5L3IEegowyjxwjLFBVLsVTh0lxPzvPD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxtTFd1VmE3QTc5dW9vcHZXZUpLU2ROUTNiYTVOK0J3UmZlby9sT084eEJE?=
 =?utf-8?B?UWxvdkJvUjhhbGNoeElYNEk3T2gydVpMNU1MYmU0cnRLazl3OHR3L1B2R01G?=
 =?utf-8?B?NHpsVzN1WWlKREZMTW1DR2diRmNmQ1BYL2sxVlplWXAvOUUrMjIvSHpyMmYy?=
 =?utf-8?B?NUNGM0VocVFORDZsZEJzdTFjekRIZUFDL3ErT256TnFNK1FpeFNQZi9HZEEr?=
 =?utf-8?B?NXgvWkhYd2RBUlRLeEtLWkM4U3lURlpVQmhOQ1MremVTSFFpUHZ6dzdrQ2sz?=
 =?utf-8?B?MlhMM2E1ek1iUTBTQ1dKUUZlcFdhWmg1ZXF5S2tLaS9hQUlTUkp4Zndzc21Z?=
 =?utf-8?B?V1lZTnRXTTNoVFhYQTd4YmxKeVdTVjY0UFJvaTQxeXgzeDU4MEZwak9KaVRP?=
 =?utf-8?B?cVhvRzJiYStYci9VR0tXdFR3RVBjZENlWC9sV2UvZzZhWWhaZWllUWxCMGZk?=
 =?utf-8?B?RCtTZFJHK2dFRm9aVnpoN2N4ZFZvMnVEcVFDRUZ6YUlCeXplU3lsNXRoczh5?=
 =?utf-8?B?K1hKTWFlOXk5M0pwY0ZHeWRXWCtrZU8wcUxlY0NHbHEvM0hzVUNuMGlhc3Iw?=
 =?utf-8?B?aUZiK2FsSytoOEo5SWphd1pjUncwemtTRno2VytNbG5WYlBWelYwZGhZY2lN?=
 =?utf-8?B?ZUJJYVBhdGU0QzVBVXN2R0F5VDkyL0VjZUw1YmdRZFpzNnVPdFdmdWo3OGtk?=
 =?utf-8?B?dnFBbi9ZKzhlck12bTg5V2JXTlRTV0R1MEg2ZnEzdjBxVExObjNKQlFrRFY0?=
 =?utf-8?B?RUtHdnMxMzBrUGtZQkNUMno1aFIwQ2ZsRTNJbk9xU1VJc0pnTnRydnVTYkVK?=
 =?utf-8?B?NnFsSDA5S0Z6Vlp0dkYzNEFERGV1N3RVQkkwVXBNU0M0amNERnkvTTBhVU5L?=
 =?utf-8?B?K1ZpQU1JdE1sdlBOZHhWWW5NNUlyMWhaRkFENnh4UmJtaWZadFVucGsvQitI?=
 =?utf-8?B?NUE1SGZFZE45MFFjMjF3RnQ3OE9pWjc1L0E2Y0U0R2pzckFnMllEOE1lS2RV?=
 =?utf-8?B?NEFvaVg5WlQzLzBlOGNpekpLWVhGeHlOVS9Kem9XcmZvYWFsdnVWc0FQVUs3?=
 =?utf-8?B?Mmwyalg1b0RIL0VPTkN0SS9hc3VrK2tqazhWOTBvUnZ0UEowemoxVFlqd3Za?=
 =?utf-8?B?K015YVFLbllYeHJUU0pKUU5nMVBWQWR1aE1iRXFIekdBMUVmNTlkZFRpYzkz?=
 =?utf-8?B?KzFSTkVSbXlRQzVubEFWRHVoMXo0ekFnQ1pUY3h5YmV2VG1rd0dpT21GNENm?=
 =?utf-8?B?SzRsNmpaTDgvSjl1TUVPaVVweEkwQ1RmNm9zTkdBdERkeHM4SllDRUFCRWhM?=
 =?utf-8?B?NlAvcG1GOUwyQTVYNnZWeXFSUmdoQmNPQW90SXZGYWRscHgwQ2xMdm15dGZl?=
 =?utf-8?B?bG9xR1ZYcnpJbUVLcTRkKy8wMHBHNEcvRFBkZGo2Qm1XWFN3VGI3aFEzSUY3?=
 =?utf-8?B?UzFDOTZGSk1xUkFYdWxQaW1Hc1UvVlFVaTI0dFBGKzZNdlNMQWxWQ3UxbnBs?=
 =?utf-8?B?cFhSOVIzWGplZXVRcFA3a0lsNVl0VHdadyt0WXlNbi92YnJxenhPMVR0NGFT?=
 =?utf-8?B?cUVUSGNnUkFUdXpNNGFYRStoTjBISWJEdlNnUlFkS0IxUlZBL084VjN0VGhS?=
 =?utf-8?B?SmFKMGZyV0trOFhmSDJuckZtWUE4anplWkF3N0dHMkpRdi93Ry8wUkMzS0w3?=
 =?utf-8?B?WW9Eczh3bk4zODdTNkplZkJpQkRjeGVFZnJOSVVjNTAvcWZNU2FNNzNscmYw?=
 =?utf-8?B?NThNSCtxUjNRNG5MU0Focm5OZXhQSHc5RU1LVlFaSHFWSXU2MTdQNDNEU25s?=
 =?utf-8?B?OE1WcUc0REVVYmVmZmFLTzVYNDFUc3I3MENaVndGUUxXSC9UbVQzelhTWGhG?=
 =?utf-8?B?L2JZSlA5ZStaWUsrRGNxRWY2MFdGNU9DS0QxL3JUSFlBb2E4azVlcDQxblRS?=
 =?utf-8?B?QkJpZ015WkZPL05sNGZ5TXgyREE3N2tydXZNaXgwSVpIYmtnSTFYRDI3UExF?=
 =?utf-8?B?bmJjY2o1SktyVytEMk02dHNTYUlGbXhLbTlGc2NpOURyckQ0ajFLaVpobW5s?=
 =?utf-8?B?Ry9oeGhINUhYbjQyNzU3RDN4OXFHZkY5RHNacGZEMnFTTysxY3VIWXIzYW5p?=
 =?utf-8?B?SVpUelYzMXVPcGZ2SHBNZDcyQU10Wm5BVnNsUUY5anNQSzJmYm5kdDBPa2FX?=
 =?utf-8?B?YzErYi9oQlJCWlBsSmVBeDMwSXQyVU1yMnVJeWxIZy96M3k3dXVMblJiaFgy?=
 =?utf-8?B?ZGdyUXNDUmlMSS9VSzY4T1RYbS8yY0srRFNNcUdnVmFtanJnbXVVV0RSbTYy?=
 =?utf-8?B?eHYvMy9HWU05ZWVLLzhYdE1kMjFrSWVZRVZmUUl1aE9vYjVtQjBua0crUUpJ?=
 =?utf-8?Q?7hrczJdGp+yi/vg4ENLXvtOj+rqYN8HMHopM0?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3445b3b-5dd3-4bf2-1e2a-08de9f814eaf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:38:05.5286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Cp9f3WtfuOG9VyFO0eUXuEVMTzL1Kys4v52CgeikM6cpo4Iu2kuOwhS8nH3KSHii45F/59trEMuwZPgAte3qlKlKphy8JpmljoBOILNTAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7550
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

Hi Heinrich,

On 4/20/26 10:24 PM, Heinrich Schuchardt wrote:
> Am 20. April 2026 13:36:09 MESZ schrieb Quentin Schulz <foss+uboot@0leil.net>:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This will allow a bunch of simplifications across the code base.
>> Disabling NET is the equivalent of today's NO_NET choice. This means
>> that if NET is enabled, either the legacy or lwIP stack is necessarily
>> selected, which allows us to simplify if NET_LEGACY || NET_LWIP into
>> if NET in a later commit.
>>
>> Config fragments - or defconfigs including other defconfigs - setting
>> the network stack (NET_LEGACY or NET_LWIP) must also set NET (or unset
>> NO_NET) if the config they apply to - or the included defconfigs -
>> unsets NET (or selects NO_NET) as otherwise the NET_LEGACY and NET_LWIP
>> symbols are unreachable. This is the case for the two defconfig modified
>> in this commit.
>>
>> NO_NET is now a convenience symbol which hides NET entirely to avoid
>> modifying many defconfigs. If one selected NO_NET to disable the
>> networking stack in the past, this will still work for now. Technically,
>> we should be using the "transitional" Kconfig attribute but that is only
>> available since Kconfig from Linux kernel v6.18 and we're on 6.1 right
>> now.
>>
>> Note that this moves CONFIG_SYS_RX_ETH_BUFFER from under the Network
>> menu back into the main menu as it seems like it needs to be defined
>> even when there's no need for NET support at all and menuconfig option
>> doesn't work the same way as a menu.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>
>> I'd say we should have everything net-related depends on NET as well,
>> so that disabling networking support with NET=n is also disabling
>> anything related (e.g. Ethernet controller and PHY drivers, USB
>> Ethernet, USB gadget CDC/RNDIS, network CLI commands, etc.).
>> ---
>> configs/am62px_evm_r5_ethboot_defconfig |  2 +-
>> configs/j722s_evm_r5_ethboot_defconfig  |  2 +-
>> net/Kconfig                             | 23 ++++++++++++-----------
>> 3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/configs/am62px_evm_r5_ethboot_defconfig b/configs/am62px_evm_r5_ethboot_defconfig
>> index 8baec9d43ff..df49324b25a 100644
>> --- a/configs/am62px_evm_r5_ethboot_defconfig
>> +++ b/configs/am62px_evm_r5_ethboot_defconfig
>> @@ -5,7 +5,7 @@ CONFIG_ARCH_K3=y
>> CONFIG_SOC_K3_AM62P5=y
>> CONFIG_TARGET_AM62P5_R5_EVM=y
>> CONFIG_DEFAULT_DEVICE_TREE="k3-am62p5-r5-sk"
>> -CONFIG_NET_LEGACY=y
>> +# CONFIG_NO_NET is not set
> 
> Does this imply that NET_LEGACY is the default? Choosing LEGACY as default would not be plausible to me. We should use LWIP as default. Then every new board will use it, hopefully.
> 

(below, "current" means the value in master branch, so before this 
series is applied).

(current) CONFIG_NET is the default already, see 
https://source.denx.de/u-boot/u-boot/-/blob/master/Kconfig#L794-L824. 
This series does not aim to change anything but the name of the symbols. 
Yes, we could make NET_LWIP the new default stack, but not in this 
series. Also, we have an issue that if you enable SPL_NET you need the 
legacy stack, even in proper (according to 
https://source.denx.de/u-boot/u-boot/-/blob/master/common/spl/Kconfig#L1152-L1154). 
So we would need to tackle this first (we don't necessarily need to 
support lwIP in SPL, just that the choice in SPL shouldn't impact the 
choice in proper).

If you're asking about this defconfig specifically, it's simply because 
it is not a typical defconfig. It includes 
configs/am62px_evm_r5_defconfig which sets CONFIG_NO_NET=y. Because 
NO_NET used to (before this series) be a choice with (current) NET and 
NET_LWIP, am62px_evm_r5_ethboot_defconfig needed to override it with 
another choice, namely (current) NET. Because NET_LEGACY is 
automatically selected when NO_NET is unset (due to NET default y), we 
only need to unset NO_NET in configs/am62px_evm_r5_ethboot_defconfig to 
restore the current state of enabling the legacy stack (current NET, now 
NET_LEGACY). This is not changing anything, just moving things around.

Does this answer your question?

Cheers,
Quentin
