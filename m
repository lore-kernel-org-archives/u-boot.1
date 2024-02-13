Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E53C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 16:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3902087D1E;
	Tue, 13 Feb 2024 17:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="W/buqYqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D49875FA; Tue, 13 Feb 2024 17:58:05 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E1587D35
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 17:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYb+xSW/oVT+fmuy8Fe5FChwluq2oZEn3m9AxqEvRtownculeomIB20O3cvIpcEOQ8Ikc0YzOYMNKsEIM1sXwJidAbHqSKdaTvirR5kZWVeVMBYTZPhc/u5hPo8zdspzaKX/ee9eEl32b74mdWK2Zq2EpYz8fg5YuFYMuGmTjhwBqYnOG1mUMaczvctWosx1XpjpFinGTcHpFAiyILkMBRU1IYYc/nkOEj27a4Rbh2H+5sTg0vTDZ1zu68XzdZR7RyJQZHYEixrlZ16Vxb3BbMQdIq9ksV3aaIQS13wlm3a/s6+7cq5r7HjfOD58kq2pAjn347PJlA6FlVZ6vttckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QgnA4dFqJ5To6CPHCxu82t0PokXYLUJdCPuyrHiNs0=;
 b=W6IUyXKOIspet1ulw2mMltOoAFkRdvXgro8ysroqgZ7hARn0YfUqKgx2mtbabj4VpJKO3++xXj3fWF2EmliDBY/Rh7OMkusBw3QNzdbNJbe9qvKRi+LMRPGJmQj/rThIzdiXkorpeiuH7fexZ2UyuaB9mRYG3r5l2hpZUPeV96XVKJ/8fO9yKK55kkJ9PVibovxqxQ1WQboylOwGfaFZrKTQrh1HlUtq7pKpI9QMHkR9ldKkI72fGcZG3a3PvAoln2e3wYl0AWI5vRycFXIYKoda9DGjo/ArTQ7tJn1KqaxfNZZQiaKXaR052WwWAM0XUh5we9wfnsKSm8a7IXUlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QgnA4dFqJ5To6CPHCxu82t0PokXYLUJdCPuyrHiNs0=;
 b=W/buqYqwoBMhMYGf7PcL28YBjZGs6i28F/Jq6sNJurU1ipYTbQaTwUKIRqse5NRwOT2DEJp2W+N6HwSFFWccUW/7qJhm643V07OajX13M1LIYx8EUxvJDBfpqPRDx6FeMsW1yxqp+hmYvMdzWK9gVMnYcgcX2oLP2LkKpd3NgjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB7971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 16:57:58 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 16:57:58 +0000
Message-ID: <69eca99a-e760-481d-817f-b312c71cc10b@kontron.de>
Date: Tue, 13 Feb 2024 17:57:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] board: Add support for Sielaff i.MX6 Solo board
Content-Language: en-US, de-DE
To: Fabio Estevam <festevam@gmail.com>, Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>
References: <20240208165849.104787-1-frieder@fris.de>
 <20240208165849.104787-2-frieder@fris.de>
 <CAOMZO5C3JVhG4hfe3F6xfERJidDUt=Ow5eB+LNFx1EWp07wysw@mail.gmail.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5C3JVhG4hfe3F6xfERJidDUt=Ow5eB+LNFx1EWp07wysw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: b11d8879-4c2d-468e-637f-08dc2cb4ee60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgwWImT9DuLJ1vVb7h0H0y13b2zeMnLL6z7+6L2tCNv7/oA3FlLUiKMx/K3QsDn6+45FoWH6BOfiN/QoOk8dvuW68VZQA5sbgaL8NJGWv7Ilub4k46ERo8MksbVHCSkhEReqJKPMSwmDXc9OB4bCCvrdQxEkTM1t+IXnhFuy0RxunK5ldclzQJdaT19bAziMIZtfsmtPPWtpzyPnmGQAxVvKzkQr6msKhcynSTg4jgA9774FWtOhZxYRIEqsJDvZyxDBiBRlgbcsMaSsZ21v19zgpxNsoamfibMOfUuxSsR82zIKb99xBtoiNFCkD9AFt9ynnWVe5zt//soMG+43tDSMCIrTxi3fbF5ZX87B98oiegeP0ATWLhDpkHwDGs+9HYha+ge1kRMKwTu9P5pDsWD/d5yboTRe7U14ZcGGQa7imQCSUTrFKsX5SkiXDS7VcVaCIbLim6jnv5NNpnqYlJ4M+u0kAelAXSDYJTrKw+B/mOGnfEGDxS1V0Xr0D5gEWM879RTy/kTrfDF9vIl4nEHNSt3rdcvMMKpw+hxtCTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6512007)(6486002)(966005)(478600001)(41300700001)(8676002)(8936002)(7416002)(44832011)(5660300002)(2906002)(4326008)(110136005)(53546011)(6506007)(6666004)(54906003)(66476007)(316002)(66556008)(66946007)(2616005)(31696002)(86362001)(38100700002)(26005)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZ0RlQwREhQMHhpYlg5TUlJZm5vSElzQk5GZXA4Y2tkLzIrL3Qzd1ZpQUJr?=
 =?utf-8?B?Z0x5ek9OdDV0RVNxc21PTGZkQkV3NytTN3VxTWtxUkFVK1NjUFMzV2plc3Nz?=
 =?utf-8?B?UWtaaUUzaldhMDBTNTZTY3hVSlhrYnlSU2hSN2ZYdGErTktGSXoxamVNQTdC?=
 =?utf-8?B?QTVVa3YwbUVzdlYvU0lreFg4WmNiWVMyb3FnRDYrYWZraUFjS3lzWVQ4WTVu?=
 =?utf-8?B?YWttb3gvdzRzV3dvRGMzalhTaEhkS1IvZkdVaTNqY3JWNFU5c2FTbzkxakow?=
 =?utf-8?B?OXA3MzRSdkRnWDlDcFprZjZwcDBlbTVmKzh2UHYxMW9BZ3ZjdFk3QmdOQ0ta?=
 =?utf-8?B?N0JMREhWaTFockxPUDg1WlE0V3pXY2d0cHJZbSsySGJTa1dZSW9RaFZmOVpn?=
 =?utf-8?B?MFRlaGt2aUdUMHJqSHJ0bkY0Y3Y3TDdjbTNVaEZzcnUrNlMrTEk0aUp2WmtZ?=
 =?utf-8?B?Z1ZTZnFFTXhVV1VMY0VmWS93VU5pTHJzSUFrN1VZM2lLL1RlYzJmTXlVMUZC?=
 =?utf-8?B?RldpNFYwbEdTMlB6M0dwSFBZbElXN0ZzNmhSWktUdVEvekhXMlZLdkxEVVRm?=
 =?utf-8?B?a1dmN3hQVDlJaytTazA5aER3cnFGTzVxREowa2VWbUFjd2JvL1Q5Y3VUeW1y?=
 =?utf-8?B?a0tPaEU2eURPVHRUcURZTm9qNEN1WEtqWTkyN1hneE9Ed0hGQnMzS2lNRi8r?=
 =?utf-8?B?RGd6ajVnUm04S0ZBQ2NvbzBVcEhnZXFRY09pYkNuNVpzT0RONVdwWWdzcm1N?=
 =?utf-8?B?WGVWNS9NajFRTTlPMTErSWkwc0tnNUtYUHZJOFF3MlMzL2pUOXZlYnVZdy8z?=
 =?utf-8?B?ZDRIVmlheWQ0eTBLRzRCM1owd0x5U3l5Q2ZaQS9LRHdjVHc1bEUyY2Q4VTVU?=
 =?utf-8?B?WWNXSEV3VHgzd3NtVXlpWkJoUjZ4UG1YS0dvN2pjUHVWTnRXMHhnQzBoRlNQ?=
 =?utf-8?B?NStMWG84ZEpkZ3FWMFM5OHd1UHpUS3pxU2l2QkIyVHJuN1NHLys1dFpTSW9X?=
 =?utf-8?B?UXV2bm5OajQrVzFkcEtzTHF3VWF1K2psQU05U3dtWWpzUTFzWElYV2hWOHZT?=
 =?utf-8?B?QTdsSzFNa29aeElaWlltcjRSMlM3TENRYVJoVjQ4M2x5TFRSRFhCWDlvTEt0?=
 =?utf-8?B?ekNweEloMVQvcnhzMUJFQmNyKzc2VzBJOTJPTWxVKysza3hqSUFOUVdPQ2Vo?=
 =?utf-8?B?RERoWUFMQ29SSHkzWm42aVBNZUhyQnZLZXRkV2lRQkxLTTdkZjI0UGdCd1N2?=
 =?utf-8?B?SGhETEkycW9QdEUwckNWb3NXNVNmNGE5NG5XZ1Rvb2tPaDNFd3BsMVVCNTNp?=
 =?utf-8?B?Y1E5WEZveDJXSUlxQTFhc0ZzVHQvZWw3MXc4RHppdUgzZ2w4WXBXN3FTSTJz?=
 =?utf-8?B?THFVUjIvNkJ4cWtkdGxaTWlYUUlJdjNubzZGN1V3QUFHdC9lSFhaK2x3ZGVt?=
 =?utf-8?B?WVkxZXpmaE9EUXIvMXphMU4xVjZGVitKYWxDcVlIVFl3OVZLVjNzOEpNeGJn?=
 =?utf-8?B?T2VwYS9uQnNaNjRFYjR1TzVyL0lNSkZMSW5HWTZaMmpibVRtbGFqOVRhMWRE?=
 =?utf-8?B?ODZ2YlJJdEFvNy9yUWErTHEyN2ttajRRTFh5Vlo4M0dMK3M3RVp2ZGlHK3ZI?=
 =?utf-8?B?d01yZG9waCtpVEVQSERXbVliMEluNUJCZnJYOUFJRG5Qb3JxR2N6eCtwSzBX?=
 =?utf-8?B?cGhzRVN5U2xwQk05azc1aitjYVlTVXV3VGhBK0I4dS9sUXlieHhNdXhad2V5?=
 =?utf-8?B?Um9vMDI5S3JWL2tGNFhkU1ZDY05abTd5V1pWTVk3UXA3M0k1Y3ZOY1dMcDZX?=
 =?utf-8?B?bUdrZkYxN0FwRXNGSGxzdDRJbW1zcm03ZTRUTjJ6R3EyQ1hadEIyTmdEcTd5?=
 =?utf-8?B?aDc3SzdtR0l4aFVHL0VlQ0N3eDZPUk94c04vYmMrQjgvWWhRdHpiTlJBKzJO?=
 =?utf-8?B?bVBqcFZVVmd3RGoxclJyQWNxM1JWdEU1WjBUMjUvYmEraEZPcWkvMkJIYzZs?=
 =?utf-8?B?SVFVSk1TUTl2WklvNG1zQVp1b1hLT2E2UEZoNnBMNDBpUjhyOGFjVHJwbjIx?=
 =?utf-8?B?NlNnMktOMzFXcVNXOXZqdThiWnA4WmZXSGVlVnZuQWtzYnYzY1hxSVRnOEZI?=
 =?utf-8?B?NDg4dzBZME02R1FReXB3TVF6b1pZS044NVFoQlQyZS83eXZOSXVoQXdwQ0Qr?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b11d8879-4c2d-468e-637f-08dc2cb4ee60
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 16:57:58.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcFtLBsOUktyrzV7/+jqq/ZHloQlHjCvguVoplYLG3145js19JUYlO51GAc2AnXxNRhYCoeSC3cNpG7ozQq3UtOvLDqeEIcuA3dEs0SNnq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7971
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

Hi Fabio,

thanks for reviewing!

On 10.02.24 19:12, Fabio Estevam wrote:
> Hi Frieder,
> 
> On Thu, Feb 8, 2024 at 1:59 PM Frieder Schrempf <frieder@fris.de> wrote:
> 
>> +/ {
>> +       binman: binman {
>> +               filename = "flash.bin";
>> +               pad-byte = <0x00>;
>> +
>> +               spl: blob-ext@1 {
>> +                       offset = <0x0>;
>> +                       filename = "SPL";
>> +               };
>> +
>> +               uboot: blob-ext@2 {
>> +                       offset = <0x11000>;
>> +                       filename = "u-boot.img";
>> +               };
>> +       };
> 
> As mentioned in patch 3/3, please remove the binman entry and use
> u-boot-with-spl.imx instead.

I understand the reasoning and I can change that if you insist. But I'm
not really happy about it as we already use the flash.bin as common name
for the binary across all platforms downstream. Also in our upstream
config for the i.MX6UL/ULL SoMs we already use this pattern (see [1]).

> 
>> +config TARGET_MX6S_SIELAFF
>> +       bool "Sielaff i.MX6 Solo Board"
>> +       depends on MX6S
>> +       select BINMAN
> 
> Please drop it.
> 
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +iomux_v3_cfg_t nfc_pads[] = {
> 
> Make it static.

OK

> 
>> --- /dev/null
>> +++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
>> @@ -0,0 +1,115 @@
>> +blkloadfdt=fatload ${device} ${devnum}:${partnum} ${fdt_addr} ${load_fdt_file}
>> +blkloadimage=fatload ${device} ${devnum}:${partnum} ${loadaddr} ${load_image}
>> +boot_devices=usb mmc ubi
>> +bootargs_base=vt.global_cursor_default=0 consoleblank=0 cma=200M fbcon=rotate:1
>> +bootdelay=3
>> +bootdir=
>> +console=ttymxc1,115200
>> +ethact=FEC0
>> +fdt_addr=0x18000000
>> +fdt_file_legacy=imx6dl_sielaff.dtb
>> +fdt_file=imx6dl-sielaff.dtb
>> +fdt_high=0xffffffff
>> +hostname=mx6s-siline-hmi
> 
> Please remove it.

OK

> 
>> +void reset_cpu(void)
>> +{
>> +}
> 
> Is this needed?

No, I will drop it.

> Does the 'reset' command work on this board?

No, I will fix it.

>> +++ b/configs/imx6dl_sielaff_defconfig
>> @@ -0,0 +1,117 @@
>> +CONFIG_ARM=y
>> +CONFIG_SPL_SYS_ICACHE_OFF=y
>> +CONFIG_SPL_SYS_DCACHE_OFF=y
> 
> These options should be dropped.

OK

> 
>> +#include <asm/arch/imx-regs.h>
>> +#include <linux/sizes.h>
>> +#include "mx6_common.h"
>> +
>> +#define CFG_MXC_UART_BASE              UART2_BASE
> 
> As you use DM_SERIAL, this can be dropped.

This is still needed as SPL runs without DM due to internal RAM size
constraints.

Thanks
Frieder

[1]
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi#L10
