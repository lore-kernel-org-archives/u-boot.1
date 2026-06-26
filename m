Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9112EC43327
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 13:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B242B84704;
	Fri, 26 Jun 2026 15:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VeZT4TAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CB88495B; Fri, 26 Jun 2026 15:36:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1688460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 15:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRPfSP4kidHaJyNGoc8dFAM+yzH1gjbO5FH1GOTmeSrUx9MhVc1ZY2yEjuBnsVwEJKVaxL2+v1ZzPoQwYdxxg733265GL3xgLywzzyUj9OlR3CitdK4dhE73736yr8iwVX28eIyGADpXt0ylr3paPYzKGWoqa30qTno1gdGiCb7zsRcFf24nwXfJiYmWl5k882sadtzA6Nozk+jTnWo3eS4wGB1h0EM99uLQ0/YVBue70gid5tE6tad0pHd+2HdDSB+N1bZ9x6CyA5ITsfaIBQddQMoo/WyGnEGU5Vs477Q8lRz4gg0V9SLxr/0RPmiFzgmiDrGWOsEzwN1gN0BmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kJ/Ox9YWMz7Nj6WzO88nCNZp4R1HLYwyF7KwuRprjU=;
 b=Jat4iJdehj/pmdU1NqDI01/D4yLupR4Xe/Hj4W+ivqQX1MSyxYOJ8edZOV7IkfjqlTB4VDqhGtSkDv+YZBqkXz95Q/h/QBsU8gcFVnFvMteQyluJ+CqMteoRbR4z6W9FW9GQfkiKScEJWjL/xvCVCV9oCUC/Ckvw/HLZXWrB9ny3z4YWta2K8c+pJWECKk9+IUN13n6JjNzGnHjPBJXgDnyPp9QEgNGD8mGz/eJ5tCIScrc1XCJczuBKSWWhhIMwcGSqYi2IXCaql4x5NJjZRnn7KKY7SsSp3Nbf59yEf+wCGU82deQpzqveyjavAoudA5aMPm5gKYf4nJvURfqaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kJ/Ox9YWMz7Nj6WzO88nCNZp4R1HLYwyF7KwuRprjU=;
 b=VeZT4TAzjrTDicOFvbAyrgbSuZ4DnTGwss+j6yO5vYrDWANzpWYw0m+0uRX31eGv9CA3IaQ74LM1H1qC83rNnSPyj2xHlfXK7HlhAlJS2t282bCU/HutIA2CaEn9aV+5NX4+K8hdjEG3I8jMGdxRNfLnR0JbbcOf42d4R22Zrgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 13:36:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 13:36:32 +0000
Message-ID: <f363790f-3d17-49b2-900a-57fbe357af4a@cherry.de>
Date: Fri, 26 Jun 2026 15:36:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ums: Set Device Descriptor iSerial based on serial#
 env variable
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260613025510.134239-1-marex@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260613025510.134239-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: fe663323-3d82-4eb9-707d-08ded387ef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /n/DOcriYXtKsBHUiJ52RiW5ThFJsH2Y8CLuGuz2vc7IUJao3auiBw4XZDP05n4L8tgu6jQ/qNNn0O14fCgxn7yfop8tRGImL2/yrdsrF2IlLSBQ0lVXLb2uK9e2W3r4xzC3cgGYYQFk+fFiZ0U9eCut8WR5q1dGta6qIC7FSQ1YXY1wk20KAy0PH9GNiHMau6debfMWkyK9BoHuLg1Kr1viftv0X62FZ1IB7zvfSSyob8CkAxLuYRR1wZ6lsNrZEf+G41yPVZcfgVBZrtopsCHQTfSRi0oRyqqIZVHcGauaFHPnhOZtZ6XkYVrKXq5lzsoM4q4hvH+jKN8l7k+/zye4xpQHDjnWOnNXiaLxYx+ZRLIP8a29Kdj9PFbICQMTjGEKKTxH2OC4XZeHlupxwZSca0JB6wluJ5kU/vHEAmJw0rYKex9h3nSQFyqY+IX9nAg4myjptINi/pl2ePHUrwfLsOwiyMGBoDbaLng4ugA82Rau2hwLy4y5qVGWpqE2W+aHappHXwpbif46nrpgynloJbhpEPz6GCJKcgCjg8rUFtOiuT/dlqZAvpsedTX169aHytfV5Vr40AdwkeKatuIUVHfwRRIRaPoRyZ6yZ12rI1KpWR/gDNp6x9JaoLRxGu+goE191JLBghr/XSqWAyhLf9uqWwaIztOXxAogv/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXprd3FtYU80ZXpGbWFVQ0hYS01aMi9NMGIyVnA5QldUOU8xUTJBSDRZRUJa?=
 =?utf-8?B?dHBkMGFtSjNORWZLT2JnQ0xhdmtxcDlBRUFNbGpnTWpaQmRFY3RKS3NSS0pF?=
 =?utf-8?B?WTcrdDdaQm9xcTBJeWluWnA4T0tJTitHSCtlNU5ReHZMTjBuMGFGN2JuYnVa?=
 =?utf-8?B?cUFSWkVrUTBuL1NrZUdoYmtvM3F1Y3JlSnIzSllhTjFzV0RUQThWS0tVTm5F?=
 =?utf-8?B?R0svZWh5MG5INUI4ZkhJM3ptNVRDcXphQ3F3eHIrSzFrQ2h5RExzWHgwQkI0?=
 =?utf-8?B?N0Zsem5mNXN6Vi9FVTkrakRRQ1BPSXo3STFQOTh5MStRWW9TeW1XVTlsQTAv?=
 =?utf-8?B?T2dkNWhUNXN0RGs0SHc2VDB4VGdJVEh2L2JVZCsyNEtTZmN6VnZiZU9jNnZE?=
 =?utf-8?B?Z25TcVpINUdRcnVmRE1nazJoRkc0Tk12OU1yVStXL1pweDluaVFUTmY4V2R5?=
 =?utf-8?B?b0YrWHVTQnY3QnlNN2E2VXh3dWhtM3NFT2dVMUVXZ2lHSE56aTZZRW83SGNH?=
 =?utf-8?B?dUFaSUVPUXI2UURJRUQ4QjQreXpxdm5KYk1vaXJ3clkvNE0za093RVRTSWJI?=
 =?utf-8?B?TXp5OW9PTjZNMFZLVCtqSjA5OXRHL0FvcWhxK011cUg0NDRRVExpVW9yQ2ps?=
 =?utf-8?B?cStiWm1FeEVyNkFIbExxNFVHZzk4d2I2a0UzOEtmNld3M1lLTi9EZUE5b2NX?=
 =?utf-8?B?TGtTY0hMN2hCY1lZK0dPOEJ4V3c3ZXJGU0k3TUhLNFVxcGd3L3FxMVZ2Zmgw?=
 =?utf-8?B?YkpNN2VtZmJ6T29xN0MvVkhMRHZ2bTRUcjIvNW1HeHN0cThLWHVFOEJQNURz?=
 =?utf-8?B?Z1U0UjN3d3k5N2NOY241SVFnWXorVXZMNG9qYTZkRkZHRm1BRzg1QjRZeGJC?=
 =?utf-8?B?T0habFFlRTZzNE11bTJqejlNM2poRExoSmZheDVSeFUrUlJtbnhUeE5mM3pO?=
 =?utf-8?B?bkJ3N0FYY0ZvZ1V4dlhEMXZ6QWc0TUZuc3F4dGMzWHRXUysvOHp1MjdYWC90?=
 =?utf-8?B?OEpNbkxtWnUrWmNxK21sS2szSEVybzFMVi9JdWZlemhna0hlaEZPeWlDUEo3?=
 =?utf-8?B?KytkUGRIMUQ5L3c5U1ZKZER0T3lxc0Zwb1FTcUI0dCtiUUdCTHVkbGt4VzFp?=
 =?utf-8?B?Skh1UXRaNEpmSVB5T0Z6L1l5a0ZmdVRoQ0NKckJzbzBEWlQ2blVXeUNvZ0Fi?=
 =?utf-8?B?d25oOWlzODVxTldFYitRaWRSWXlCc09iSzVzQ2ttM2FvanhsMmY0c2Fsazhv?=
 =?utf-8?B?ak1yMlhLTGRtU3BjZ0JoWEJENFlaeEpobEloVFJqSi84R0Y3U2huMm91TUo3?=
 =?utf-8?B?Nk8reWF0RWJod0swS3JXSzB6Y0RJRmJNNzJReUlqb1pNMDlDYitMTjh3VTBz?=
 =?utf-8?B?ellLQzBMbjQrWjkxLzJmYVRzREQ5SDRJemliV0VvczQ5Z0FzWTlCTEcvOEt4?=
 =?utf-8?B?TGl0d0owM2RTQUlHSVIxYUZDUWdSVVE2RnpUWG1MU0RmYW9xRVNoRXhZbDZ6?=
 =?utf-8?B?a21HV0pCckIvMXgvY00xZVBrRjB2M0ltZFBEQTJLcnRza2xFN0dnRUQyWFlO?=
 =?utf-8?B?dW80VjY1dHhSbVJTWjhQL2Y4MnRCYVVJcjBQdzlNeGsyVDIxZGV6TjBiZkp2?=
 =?utf-8?B?V1pDczh6UnIwemNNZVBGdUNtT1BpVFRPQ0lEdjdyaDlqM04wbmZBbVExZk53?=
 =?utf-8?B?WlZma0NvazFRZVROK0dlOXFCY3N2UGlpQWxmVHlZaUI1dUVwL28valVMaFJR?=
 =?utf-8?B?MytkRC9GOTd6T3A4L2pERkowdWJaaW96eUhCYmNMWmNUWVAyYkFPcUJWa0Z0?=
 =?utf-8?B?VEl5Mnh1WlNvTFhlR3FRamFaYXpaVHgyVDVmY3pKQ3kzNGo4OUlSK2xKSHh6?=
 =?utf-8?B?bG9uM3U4S1RyNENaQ25Ga05MREJ0WVE2aVExNFJGNlBSL1NCMXNMc09MNVl2?=
 =?utf-8?B?aTB6eUlYeDlVa2JVempEVU5MV0hoUkgwcUJscnIzbGVMQ1BOc21FVThhamRW?=
 =?utf-8?B?UnNNOWtUVml5bnUvTzcwaG9oM2JhRjBwMHVVNmVaVC9SS2xiVUo3Q0xjakU3?=
 =?utf-8?B?c1JYVzJuRXRiQVF4TGRnWUZpUmVIZlhUM2FnUzFCMVdYd2w0Nk5aR2lyeElr?=
 =?utf-8?B?cUt2MTd3TkhEdDNLbWRJOG5SRXVHZHZYNm8zeGRIek5BaUdRU3dEK2ZMSVVJ?=
 =?utf-8?B?STNiV2Vlei8zdEhvTWc1QmVGSGx2MDFzeG50S3puZ0RjVUo3VFRBYU0waytV?=
 =?utf-8?B?MHZrWHAxek1wMlhJTGprNHRUVFpWbHg4bCttZkZKRkVVYWxZOGtSWEJFbUd3?=
 =?utf-8?B?d3A5dW9CTlhQSjNNMXdMdE9VVGdhOG5ydm5xeUpjSzJ1L1V2VU5CQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fe663323-3d82-4eb9-707d-08ded387ef95
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:36:32.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qKF1HE81EF+49okb3jn9o4MTjW9+0ix8LfdxnNf/cmcL6jdajyUbt46rXTlxOnNoNrk8NDwAYft6PAEDHQDQCcbHO5xNm9Uetf+TqL2UFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9176
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

Hi Marek,

On 6/13/26 4:54 AM, Marek Vasut wrote:
> The DFU code currently sets the content of "serial#" environment
> variable into Device Descriptor iSerial field. This is useful when
> there are multiple devices connected to the same host PC and they
> have to be told apart. Replicate the same behavior in the UMS code.
> 
> Example without serial# set, which is the original behavior:
> "
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
> 
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
> usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
>                              <------------------------------- NOT HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
> 
> $ lsusb -vd 0525:a4a5
> 
> Bus 005 Device 051: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
> Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass            0 [unknown]
>    bDeviceSubClass         0 [unknown]
>    bDeviceProtocol         0
>    bMaxPacketSize0        64
>    idVendor           0x0525 Netchip Technology, Inc.
>    idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>    bcdDevice           7e.a7
>    iManufacturer           1 Vendor
>    iProduct                2 USB download gadget
>    iSerial                 0 <------------------------------- NOT HERE
> ...
> "
> 
> Example with serial# set to 1234abcd, which is the optional new behavior:
> "
> u-boot=> setenv serial# 1234abcd <------------------------------ HERE
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
> 
> $ dmesg -w
> ...
> usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
> usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 5-2.3.7: Product: USB download gadget
> usb 5-2.3.7: Manufacturer: Vendor
> usb 5-2.3.7: SerialNumber: 1234abcd <--------------------------- HERE
> usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
> ...
> 
> $ lsusb -vd 0525:a4a5
> 
> Bus 005 Device 052: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
> Negotiated speed: High Speed (480Mbps)
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass            0 [unknown]
>    bDeviceSubClass         0 [unknown]
>    bDeviceProtocol         0
>    bMaxPacketSize0        64
>    idVendor           0x0525 Netchip Technology, Inc.
>    idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
>    bcdDevice           7e.a7
>    iManufacturer           1 Vendor
>    iProduct                2 USB download gadget
>    iSerial                 3 1234abcd <-------------------------- HERE
> ...
> "
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   cmd/usb_mass_storage.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
> index e8b87045bdc..335258d7a56 100644
> --- a/cmd/usb_mass_storage.c
> +++ b/cmd/usb_mass_storage.c
> @@ -9,6 +9,7 @@
>   #include <blk.h>
>   #include <command.h>
>   #include <console.h>
> +#include <env.h>
>   #include <errno.h>
>   #include <g_dnl.h>
>   #include <malloc.h>
> @@ -65,7 +66,7 @@ static void ums_fini(void)
>   
>   static int ums_init(const char *devtype, const char *devnums_part_str)
>   {
> -	char *s, *t, *devnum_part_str, *name;
> +	char *s, *t, *devnum_part_str, *name, *sn;

Reduce the scope of the variable by declaring this variable in the 
if-block? I find it easier follow code this way. Additionally, I'm 
assuming we could get a "variable defined but never used" kinda warning 
if ENV_SUPPORT is not selected?

I don't know anything about USB, but I'm a bit puzzled by the choice of 
location, as the DFU, fastboot and rockusb USB gadget drivers are 
setting this in their bind function... shouldn't this be added in 
drivers/usb/gadget/f_mass_storage.c:fsg_bind() instead to match? I'm 
thinking, if someone programmatically configures the UMS gadget driver 
without going through the CLI, they probably would be missing this as well?

Cheers,
Quentin
