Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B991CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E3184975;
	Thu, 25 Jun 2026 14:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lTTm09MM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE08C8493A; Thu, 25 Jun 2026 10:24:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9080C84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACua0Ay+ymuRFgxmT5g0gJhXhejXQfJdTQ1rcb446XKoDvTONwPy5JRfjvX04thwXxyfDro4NzhUhPVJwfB8o9LCeYN4ywZmjz7Bzj5qNtBH68I8TdjaxqhEkv8/wIon7P0TCCVMHjbdHF97ZjHHY2Sbg9RL48MN3iQK75mKWGw5EloI92H8OQ+vYScX7KccV1ePLz9Qqcim0F4jfj4kJg899mZ+yskQCZ/6glNldJpWz3gVTzF0sTvlv+5QsgEfgXIzaJfdv3d5eEnTxgw2dOALARL+rGOo7yy37LVtO+f16gWPlc6Vhcyq8kZ2QQlwgZpVyGfX9vHDR5mnhVTB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbJOoSOKUJjuW3NlXGNxibcXWOpJbfk0rwFneZ/uz74=;
 b=mZOLmqAr+vespijgQWL8B5Y5Ji7vae0bFigZTpFEnde1e3NXP8UwRfuFBbu5VgBtZEsPVZvgtulF/REBL6zy/DM7EqDcikrcT/ER2JoGt+Z5B51s/pFOAwenOR/qzAwmWZTEVUSJwNKVJL4k3NGWA06K8e5a9iBvsIutvF/ePrWm8Za5Rc5RF9lKi+rWLqT4DnfcWYdSUZTG9LZpSDWIbr9sbCZPSR2Rbe4uU/tUi2yIRdFZ2V19KVsCHHAAzXVYNlitkz76tQAaz8iTcQWPX3mg+dzJWsBqg4W9uKMUqxc36LmAD2kwj6Fw8DViAHpuBN8ThYpBsIUCC64DyMEEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbJOoSOKUJjuW3NlXGNxibcXWOpJbfk0rwFneZ/uz74=;
 b=lTTm09MMHxwB86b3Ij4GAmWhJ03nkVdZBsqTxznRzloV93pUCNtMH3FuK0umqUFoWyRx87VxJ2a9Wjv0xUIeMr97FnunaEEyNKWW9BDMWukqwII7l5y82OLImYBSla9gYpgRaPtaEPTGxCPSLTgScletlXmHu19uDZBM2Yw/U3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:24:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 08:24:52 +0000
Message-ID: <9ee2050e-5751-4d82-a8a8-e0c52f56e1f7@cherry.de>
Date: Thu, 25 Jun 2026 10:24:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
To: Anshul Dalal <anshuld@ti.com>, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Dinesh <dinesh.maniyam@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Marek Vasut <marex@denx.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nick Hu <nick.hu@sifive.com>,
 Jimmy Ho <jimmy.ho@sifive.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Jonathan Stroud <jonathan.stroud@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Daniel Palmer
 <daniel@thingy.jp>, Angelo Dureghello <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>, "Lucien.Jheng"
 <lucienzx159@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Beiyan Yun <root@infi.wang>, Weijie Gao <weijie.gao@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Alice Guo <alice.guo@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Shawn Lin
 <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 546f7384-f53d-4b4f-bbb9-08ded2933ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: e3U+TikLNZ2/UTnfT3fnVAs7g4WDG/mOsIqaifYQSZLVYVGGYUgAC5N7mPwqWX/HJbdyQ8QXTzJd8Tkt5Ip3bMWAsB2l1UgWvCCRkTqUe7GMQbxg626qByGAl+18ED+9fF6gRkA9XyCO0LmUBMief+7XXd7/HXYrK91DsXwvf1qZimNr90y5bf2LtECwzFaGK2sXV9TyqvahnQshOvCY2LvY667SThYurZVPlDh/q8uCjKquQUQNQqDjK7kxe4qKtyaH3rMw0g9MghA6sMvYfWKKFTp97oPIRvdak4mLTsMvvc84/UBEpdl0U6MUQKOIa309fFhozDrD8FDeQA5oYWxMwEVnWmog46kFX8B27auJXuM19M+aCArfP6iDUz81BLFEzidvbKWAL6XBxlqGmgV7gSmk3ssGdfkQVqJTqDOCgU4V5TjhDOYqrmV+VQPisCqh4lYKg9mIoGG0f4Ef5a0SVXsPZ5JtfciD7+PXEYcaeLRRMDk4WUU22Hs9ZqwhkH024bkyTTiWTP53szKXzcjwLNHExS0EuiveEuV9UiT5FDgATc0NVHggaaaWnJpQqrwQfDZo4arq2XwynEVzohMFsF25dEYC7Q93wyF2GOlylsVo4UqVEz5wC6CcKvSTSaQwodJsM8rGBCvh8dGlooWMzlH8Vez/wgHpSMld4lE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3gvQXVtRzMyMXBCc3g1b1JEd3ZpOHhFNDdoQzFlejRYR2dQU29ZUVp5UXUr?=
 =?utf-8?B?dFBSSmRva3RlSGxkVlBYdFpJekVXc0xYZ3I2NWxnMFpzby81dFpKOGp6cWQx?=
 =?utf-8?B?SkVTSTlHTjRNYUQ2eElzTWFQM1pQVU9nQzFPYlhPS3FwRFh3MFJOd0NQQUNO?=
 =?utf-8?B?eE5TNmV0M0djZEYxaTBVQUd2L09XWm5sNnYvMDlwS0djWXlwU2FCYWRIaTZK?=
 =?utf-8?B?bnh3RWc5ajB0SFl3OEtHYXhLY3V2UU5MOTlpQWZONnBkbkVtY3A4VFVBVnRm?=
 =?utf-8?B?azFaK1p4SzlwUTF3QXRDYzNxUTFkTnpjS2hCN2FQNm5lTzJZRDJwOHhMcW9k?=
 =?utf-8?B?bFVTQThmWHA3dFE3OEZJMCtGZDhxaTdjRGhCbzRkL2orR1VJWDJpU3AyR2xx?=
 =?utf-8?B?R3dZSkcxdlU2R2h5SmFKaXhUM21BUmtNcGc5dGFNWURKZ2lPeFJNYlliWitH?=
 =?utf-8?B?aVI4WW1iT0g4QXhQSDBvVVRoREl1elBWalFCYnN3NHdMOHQ1b3A1OVZRSkxY?=
 =?utf-8?B?SGkxcGxyanA0QTBuQ3RnbHRrTUMvS2lsb1BMQWpLNGtSOFE4Z2JPeUFxd2pN?=
 =?utf-8?B?VWFVdXJzNDZYTjFWMHRyb3RiQktXREQraXBZa3hMdjVBNWdHaFE5bkN3Skxv?=
 =?utf-8?B?WWFqekNsZ05SSmZhWXZFY2Z6NUdUWUFjV3Vuanl4NW9UNUkwcksrZHNNcnBW?=
 =?utf-8?B?OGdwbG5RQU00UmtzU0NTZzY5alRuN3M1REFqMkNzaENhV0ZJZ1d1V0JINzJS?=
 =?utf-8?B?Q3pjYUFVN2xSWHIwZ0JDMnZNNzUxWjRVbHlxM0d5dzdpNDFvZ2p0ekNIOFRy?=
 =?utf-8?B?bVM0WldHUWFuWEp2bzJDR1JEUUhzQXZKbkdsNlhEcmdnYTFpOUxYWjNTVURa?=
 =?utf-8?B?L3BhNDJlL2pYbVo0OFVGcmxmY1ZDUy9hWTJBcm9vc1hsUXpmeStkZ0NuVXhX?=
 =?utf-8?B?QVBDdTBpR0tqNng4UEhoSGE4YnJsLzZ2bnRGM2NGUWE2R1ZTNlRNVzczc1hI?=
 =?utf-8?B?eUEzdFFDYUs0eE1ZWEVQWVNLRWRXOEx3OEc1NzlmQ3dwZkNVUHFmY1diOS9I?=
 =?utf-8?B?Y0NtakZ1Y1E5T2phbDhidHhScjhQSVcwZGFVRlZyd1c3bHVHWFFrbkpVRmhG?=
 =?utf-8?B?OUpHdXBhdjExZFNGWDNTdndqWG1PcFNuTVFYTTh1ZTBRU2cxR21VSlRUbk5X?=
 =?utf-8?B?dG0yRy9JaG9xWlJVR1RsekhGdC9pS2dDM1MwTmRFMklaTzMvTVRhZVAzNXRy?=
 =?utf-8?B?cXVaaThzT1dIeGd5alJpeklUVVVCemhWbytGVnlhWndEYmVUK1VXZmZlZW9H?=
 =?utf-8?B?ZzZ3cHU0MEdxNzFtNExnQ3JRVTc4dDdBM29hQVBmblFFaUIvcW1PS0FicU43?=
 =?utf-8?B?NS84blFEMWhFMkhHK0x1elNzZHdwRUsxVmJRVUxabTJLdXdvWEVpci9YU2FF?=
 =?utf-8?B?TjVuSHpmMURiSTJzUHQrWHgxRVlMREpXT1hoVmsyUnd3NVVIZk5TTGJFYlYy?=
 =?utf-8?B?Wmt2NGJ6TFYzcVNtWjdyTUJZOUVyaWtCRnBOcS9rU1drTkg4aEFwNDJQSStu?=
 =?utf-8?B?c1B5UDNoWEdrcHlyaU1ib3VDaWVkNEc1dGgrUk5FbWltV2ZxS2NRbi9sNHY3?=
 =?utf-8?B?RzdsVzB0VUtaMEwxRmcrQWttcithNG9FRzUwVHN3Tm85QzZCZzJyNFl0RitN?=
 =?utf-8?B?YXZrZEdjZGdzUmVKeXZQb2FrYVNnVjZOOUdCUklGMytpZkxWbmNiT05VUjI5?=
 =?utf-8?B?cUtsVnVJbjZwMFBDS29mdXNCYklPTytSendLS2hlditKSXNGNitGdWNrUzFW?=
 =?utf-8?B?S3NlbzNCb241RTk1bzZ4bCtVYlJDQlFYRWVuUWJWTmdsUDBRS2xwdUlPWFFR?=
 =?utf-8?B?a1M2TWluYnVnQTlucWEycEh0aDBNQnlTWVZpbGU0N3RTa1dJYzhwWHllZWEv?=
 =?utf-8?B?djN0clRpWkYzaXdNREpEaStlR3JBb3JLdTByZGZYb2JhSWsvWDdYQkNVdkEv?=
 =?utf-8?B?dUY3RE1XQ2svRXhqcEVDVERDZ1MxdlBUTmdpbG1qU0FFTXExZ1Rhci9XTE5L?=
 =?utf-8?B?cGlVb3V5WWc4ZjBkbG0yTWNJNDVZWFBtV0xhS0pacnBvbWNRSDcvMEhhS25a?=
 =?utf-8?B?YXdHZEJjN1hhWGVQck13MnVXMmZkZEFIU3JoZ2M4aHV6N0lXZHkzay9wSXJj?=
 =?utf-8?B?bmcrN2tIRmxYR0VIbjFlWW4rbm5qQ1V4OTZxc2ZMcS9pMVVTL240d3NoTFpR?=
 =?utf-8?B?WUFBQ3BFSUQ2TXY0RS94SEdTTCtHeklNQkl3LzcvK3IvSkVNZmNLV08wdy9s?=
 =?utf-8?B?Vzd6MEQ0WWVWTzZVaE9HT0RFUkpaNTVrQU5PdGs0L0VoSHVtK1lFUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 546f7384-f53d-4b4f-bbb9-08ded2933ad1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:24:52.3676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbVSuCZ0LS1S6JnDWcjI1GG8LhToNuAmarHK6q1mP4lfhkOxsipLa17JNMXkOChdz6rCaobIAELqCYQmoHLeQiU6otaZV3SlwunbbaHZT7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi Anshul,

Thanks for the cleanup!

On 6/25/26 5:17 AM, Anshul Dalal wrote:
> U-Boot does not support modules, so having tristate options is useless.
> 
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
