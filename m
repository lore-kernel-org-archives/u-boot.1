Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23354EBFD04
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 06:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9E1840D8;
	Mon, 13 Apr 2026 08:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1MA4MNtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A8983F75; Mon, 13 Apr 2026 08:23:20 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82B08352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6A3iYkJZWx4MzJPrD3QLyMSOKlmZ2kQSmOOYeJNSOGFJtXgFH/dhEcUT+baO25qZnlv3FR/BQ79DR7wNeOsT+h/N8MsIIEyxQAU6FS83IEoxUrwRiDgKzioBvk5UP6/fwJmVO4hjsQFaQ0/sT5cpVD8kgUCy9+0ZJoUZIkKEXQ/DH9MsTwxY/zU8Ut0U0oMwkdJDCGt6T4XunPJzc9Ng1FX31T2PYpIGg+Z6CjFmzhYhDVvxDJ1L2BfrGgze2/m9vS/+Mqq9N/6xBEQiKSR5yZQYayyZFnsRTRaalWuVOXuI2C2SGEiMH3qz9HnsHVAr2bx3P5LzFmx7MLjd6kiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MPJTfrS3js/HErG9ey31TC8tmOx115vxE36OkaOi2E=;
 b=SpZWCJOIIoBvr5P2L/v2GbT6DUtuM205dpxtitr8EYoxXuHsJG6n3NQfYeO3sqm7x5IU9HO8/YWZEpT+4H74aIo6859Wsx10V69c1j1DhBqdtk9ndgpWTAdjuNY/qMoj8qB00qLZyGJ8Czb2X6xU58dAPeVi4oC01CCZQXiU2i6Hf1BF9UtGWTRbiHk+gI/4uVHOoWLJl1WcTejXY6GJuxMjfoYbzeRW4p1Kg0YsIvFocsOc3j2DMe4H8ht6JPN7KcWCRjv5WrSoTW9np3pgGgyEgpTd83pq4IGobdTpNCp/qNn9QYcdHBQowyyvACcs0Py/a33OMo0720IpZrGrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MPJTfrS3js/HErG9ey31TC8tmOx115vxE36OkaOi2E=;
 b=1MA4MNtRQ1X92/097l190aSQa75yKDOlktFmkinRaNyk3iwr+s9N+jPKhDBbzRfkXsIS+kO+UJk2fClD26sa/SbAwRi8virC8Dr7+1cdqa55b3awuNqf3qQbz+nPUDHR5mFPtIyYKUkxSSvs3VzlWRmBBD1noiK6ZRyzPDifvJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 06:23:12 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:23:12 +0000
Message-ID: <710bc45a-2846-4bae-96e2-1bbd5b0a898e@amd.com>
Date: Mon, 13 Apr 2026 08:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: Simon Glass <sjg@chromium.org>, Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
 <CAFLszThhVEp3EH1Rqb6acPzJ6TbPc0p0thCG0+PHHCruKGz=iQ@mail.gmail.com>
 <be4b085e-cafe-4d68-bb80-7c929b0060d5@seznam.cz>
 <CAFLszTi+sn9RZkBFFafKAcY4W4PJWsgdfBbOEv4C9=Fr1EmW=A@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTi+sn9RZkBFFafKAcY4W4PJWsgdfBbOEv4C9=Fr1EmW=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::34) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0340ee01-211e-4c63-6701-08de992523ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Vyyu+hyEFwUy7X4B8GF8yCj7k1zZ4rLNvsIqRJ6SZMlv+Lwk8u+ADkfjHGht/HSNKG0Gfeka8imN1Ydyvj+AKdNYwcQV3QRB6a1cBJFjYciDBd9/5U3hop7ag5Uz7qhhZUT1/Y3Z10/vmhfLl3tYTteYyjuYbMr2GEDnz6TVfwtVVUuFFI86R+UXSJ4EGG5n6/8NrJVu1nZtzsm3iwbypjrqLMkD6jzTsr/V22eSljbLjFCfDJCv8Q64geQ9CGdObrVgGz5RX3YpJDOr8ZE6w3GxAuXFC2yKpc+qnjFbdmIFpfLg96Kw1pf4a7/44wpqsrAjQHJHqIm6s4P7KYCtyGexj2Fly+uZ2ueWlp8ynwEYBH6y5eAF6mYgWV/aWZ3PSnkufvUACl0TEh6bFI+fpf0EiESxSpVzdxov1hUfIVwWQkADC4/3CEDSnvumo5RICMLOSEEHkjf7f5Dub4ZT8Xdym25BbiLFcC7GWVYerDuMamfarkrMZZ+v870Blda5T9ErE09iKPXqznY93BhSVorCwvKHc0PDPARROOHcHm452/kKw8YWEfEB85Y87X0ePMaJfW+ov3UGgVW6SLwKg6lPX434Ktlcqpf/4fBZvZSP0uhNn7u2VeVmQPKDUsd+CYMlZ/zH7gmzq6+iEWZY4XCRZA9PwFHCBaiURJE/Rs9+llDRSeXxNAemxn4PRhdMp/UQ9cMAns3jhnzD7zgPkDDC9J9B96KH/nnNvgcRI7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhxSnVlV3E5TitwRnBIQ2F1Umx2NnNrZmZSK3hBV042d0dpb1JvOUtRTkc3?=
 =?utf-8?B?THB5WWVhQ1IvRHZnSlloQy8rWSt1N2hjZnNUVW1EdzZ3ckpWbDJXN3RtK1du?=
 =?utf-8?B?TnpLd3FwSHVVNUdOcU0wN04xTWE0SFlTdGNud0pOcThUandzMnNRYU9OZXpV?=
 =?utf-8?B?Y0s5NXk1NmxMdHNEZENnenl6bmpEckc3WVRlNG5UbSsyeWVYU2J4ZklsUWlP?=
 =?utf-8?B?T0MxMk5XN251Nk40blNXVWxjNndjYVhBZWU1ZU1aUWpsQlZWeHZPRmhxSkZ0?=
 =?utf-8?B?SHBxVkJST1RGNFBrbDJsZzBCRk1IVU1Eb2NoSEFxSjh3alFOYXNwcGxHTkVy?=
 =?utf-8?B?NkFPSERNOWJuSEw0V3J5ZnRMMDBtZDNWWUppdFhaUzRjZlRWZzQ1eEp2bFNH?=
 =?utf-8?B?U2JmWS9RbC9oa0c1cm95ZUpaWFBMb3ZaY1Q5LzFveWIxajhYekltQTU3Z2dT?=
 =?utf-8?B?S2JzU0Vua1FOS2hqZ3ZySmZyTDJKZDlEVFpvZ01LZFB4TWgzb0FQMFExL1J1?=
 =?utf-8?B?TTAzN0ptTUdBTUtHT2Z1MnBCVFI5VW5LN3Brc1ZLUHY0N0dqd3d4VlIwSEFF?=
 =?utf-8?B?Z1AxMEwwcU9pYVZ2T1JnamZubmlrajlUYm5Uczd6c09qdTlMYkRUbWNZLzNk?=
 =?utf-8?B?MXU4em1tbloreXFvTVUzRUlvN1pxTU5ucVBDK1ZpbUh5MXpHR0VmeFhqMEdW?=
 =?utf-8?B?VU83cWg1NE1JOU1FY0Z4b3FTdEFUZFZ3bUJ1MEtvWXFUVUE2SytVcDNIaXFw?=
 =?utf-8?B?TFJqOVVxTitGdGcxRXY0c2pZSzJXbGlaVzRDaWtYUjEvOE1LaDhWaXlVRk45?=
 =?utf-8?B?cm1wSm5RLy84OTE3K3VLRUhCTUNLZGNyRnRGUW9zQnhVaDJjYTE4K1JhUWdB?=
 =?utf-8?B?MkZMMjdDOW1HSEVUTW9mUjlGbnBvbHVOMEVXazlhaU94Y1p4QkdTRkZuZFFJ?=
 =?utf-8?B?em80dFh4MGFOL24yZXgrbDg2N3BhV3k5Rm0vdE5uWGsrSWp4Sk9FS1RZdUtW?=
 =?utf-8?B?YnRBRWZpQlVGODdGNTJ5bVV2eW5XZTV0QUNRNnNQd0FEd3haeW5HVHBGZHVM?=
 =?utf-8?B?Tm85d0dTZURFci9oc1VabzJnU2pWL3IwNGExZUdCU01qUmEyRVNUMWdBNlpN?=
 =?utf-8?B?NWdNakwzK3p2RnJUTHprSmZySUJnVU1ZTFZRakhBSjdmaEo5alBmMFJxQ2FC?=
 =?utf-8?B?Q1lUSEZJQWh3Y0VuK1BlcS83aUVIWEt2Z2REVHI2RFBZK1oraC9QQWtEYUZm?=
 =?utf-8?B?VDMwdWpWODlNVlpPMkxjTVNwaW8ycldOWndsc0dIOG5OOUt5L2xYcVhjYmJD?=
 =?utf-8?B?TjNtUWhkSUJWRXBZM0JlcGJoWFZXeC9FQzl1OFZlSGh5ckR0dFVReWpjM1pl?=
 =?utf-8?B?RkVsNnlENTNtQ2NpVFpkd1ZNNzBqd1BNdmRkYWp0NHR5QWxGWFdvUUNjQ1N2?=
 =?utf-8?B?YllSNzh3d3ZjMkY1eHhWeWJxOW1LcnlMMzZTdXdhUUYvVXlEZmNLa01zdmhG?=
 =?utf-8?B?SjFoL1RpZnhKcldNREJiOHdraHgyK3FuWXc3Z2VwRFJHMS9uc3UyZ1FLUWl4?=
 =?utf-8?B?SW03VTBaUUl0b3pncXlkenVKbEFNQ2VuK014Sm54SlhjUUlWSExJaUg3aWtO?=
 =?utf-8?B?ZVpncDg3eUx5UFZmcjVDWTBQTUc2R0YwSUlVYkZMQ3ZXR1BSWmhZQ3loK0JR?=
 =?utf-8?B?VXkyTHgwQm5FRWZQUnpHTk1FdW1wZDdROVVWdDcrWGg5Nk5oMzhOeE1xWGRC?=
 =?utf-8?B?RnlPd0lPQ3RCTSt3NEFGekRwaG8xVmd5cXNLUEFjWWFZNkdySlRjMUtta3ow?=
 =?utf-8?B?dm1LQ3N5b1p1ZVE3T3lia054eGpoSWRUVWJhODY3cGtwaW9Jbi93S3lRck5Q?=
 =?utf-8?B?eGxzT2llSTVDWFlROU93WCtiZit4ZkNqVGhRa1ozMGZxc3VCM1hLWFc0ak9I?=
 =?utf-8?B?T1I0aVFQanFJYk4yYXpiU0QwbFhTNXBsK2NwUWREaDlUVUt0SjltZ1FtdEFk?=
 =?utf-8?B?by9CTldVL2lod1ZCQVRiK3VKTVpxTHBFQWV6MlhNb3Y1NHZzNGlJU1BENXlh?=
 =?utf-8?B?NEI2K2FGTGR2dHdNT3Y3K0o4Z3gzT1FuWkJIY2FqbnFLNTB4UnlPUm03b2xG?=
 =?utf-8?B?Z2tQb2Y5NFZTWWQvdTU1ZENBRDlFa2RZUFdxek5hbEpYNGtHeUkyL095WVlT?=
 =?utf-8?B?aFFyVkhkbU1EM3dXK0hYWkxKVXVRT01vVzhJcFdWaFBzdWZQby9vQXVGOXZ6?=
 =?utf-8?B?VWVpTHllaXdWV0R4aTl6NHpGUHFnQWVTT1l4YS9BV3E1SjRCUDl2T1hxTDEv?=
 =?utf-8?B?V2o2dW1sTlh5RWgxVUEycjV1bnRGaElZeGl0QnB4ajNYVlFXWU13Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0340ee01-211e-4c63-6701-08de992523ca
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:23:12.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwrWnI9g3HQedkPh4Hvy1zZ70k7fkXyKu4LfKRvV7jvFTenrw9PnWv0SMH8cl6S4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:48:10 +0200
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



On 4/12/26 14:04, Simon Glass wrote:
> Hi Michael,
> 
> On Mon, 6 Apr 2026 at 16:44, Michael Srba <Michael.Srba@seznam.cz> wrote:
>>
>> On 4/6/26 17:50, Simon Glass wrote:
>>> Hi Michael,
>>>
>>> On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
>>>> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>>>>
>>>> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
>>>> Since the contents of the ELF file are platform specific, add a config
>>>> option that allows specifying a linker script to use to produce the
>>>> ELF file.
>>>>
>>>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>>> diff --git a/Makefile b/Makefile
>>>> @@ -2014,6 +2017,26 @@ u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>>>> +quiet_cmd_u-boot-spl-elf ?= LD      $@
>>>> +     cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>>>> +     -T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>>>> +     -Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000
>>> The existing cmd_u-boot-spl-elf includes $(if
>>> $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) for endianness. Please can you add
>>> the same here for consistency.
>>>
>>> Since this redefines cmd_u-boot-spl-elf using ?=, the earlier
>>> definition takes precedence if both SPL_REMAKE_ELF and
>>> SPL_REMAKE_ELF_LDSCRIPT are enabled. This is probably fine since
>>> enabling both does not make sense, but maybe add 'depends on
>>> !SPL_REMAKE_ELF' or a note in the Kconfig help text.
>> Hi,
>> slowly going through the reviews, I think when I originally worked on this
>> u-boot didn't support remaking SPL into an ELF at all. I completely missed
>> this change when rebasing (or didn't miss it, made a mental note, and
>> completely forgot... hard to say at this point).
>>
>> I could certainly just
>> add a conditional, though there's probably cleaner ways to do this where
>> only the linker script is conditional (not sure what to do about the page
>> size, would need to test to double check if it's even actually necessary).
>>
>> Actually, making the linker script path default to the standard one would be
>> the cleanest option by some measures, but since you didn't suggest it
>> I assume that's not your preferred solution?
> 
> Actually that seems better, something like:
> 
>    config SPL_REMAKE_ELF_LDSCRIPT
>        string "Linker script for SPL ELF"
>        depends on SPL_REMAKE_ELF
>        default "arch/$(ARCH)/u-boot-spl-elf.lds"
> 
> Then your platform can override it and there is only a single
> cmd_u-boot-spl-elf with no problems with ?= !


Keep in your mind that SPL elf remake patch has been recently merged.

Passing custom linker script needs to be done on the top of this.


Thanks,
Michal

commit 60ef345b1a10ec859f29ebc706724f907e8771cb
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Thu Feb 26 10:27:16 2026 +0100
Commit:     Tom Rini <trini@konsulko.com>
CommitDate: Fri Mar 13 13:21:52 2026 -0600

     spl: Remake SPL elf from bin

     On Xilinx MB-V there is a need to use ELF file for SPL which is placed
     in BRAM (Block RAM) because tools for placing code to bitstream requires to
     use ELF. That's why introduce SPL_REMAKE_ELF similar to REMAKE_ELF option
     as was originally done by commit f4dc714aaa2d ("arm64: Turn u-boot.bin back
     into an ELF file after relocate-rela").

     There is already generic and simple linker script (arch/u-boot-elf.lds)
     which can be also used without any modification.

     Signed-off-by: Michal Simek <michal.simek@amd.com>


