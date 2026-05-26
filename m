Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6DCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 21:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59B9848D8;
	Tue, 26 May 2026 23:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="h5n8V/Sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7855E848E2; Tue, 26 May 2026 23:18:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8D3846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb980eQ9hVlNruLOp+uydvg4YSuF3+lMQKIZyhJHt8M7xvkoNs7pWeTxm/UkLWCrJnDCMjEUJ6g+wKjNg3lyKrHoMGa1l3PuCGUindoELpgPy4j3iwtismafsHArPbiz6ImDQjbsrmiTMmIbnkOuHtpV2PqJFnkQwM9ocjQDx3lACbftWVdIPyTzW4+CWk/I/yZS3EiUInl5VoU1iuSAxWeBBrVSHyDVZrvRFilbk+Kp72iki26ORxm+w+Rb3E2P7lYnsNLSAki9GD3Lxn0cXWnq9rPxoBiAXLwjfA1i/Tol379iTSD4v8SgOQByqP6MuIWYlFW+uHhegYdh4/PmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQyFPFh4s4dm+8i7V4G7TbJhWGFz2fTB5NPz5pBF73E=;
 b=iPI+ntXmW5ECDgYaDLFpIg5lQWtCDvrHTFMMAHdN6mA7MX5wZx6bBIYUxZzsq2O2IrUSKcAg5CGP43h+V7VuTYJbUYwYMlRqFnNW5vysQKxcuoU3MZ/1/PbfFN5sTbQiaiD+lxmKxQA9MeKS27n29o+F0rLHNs5EJvrbWVyqVKOULrfRoMqi5bPWA/4GLv8CqqvWyE3UdRV3FZ4JZEuWhnCpAaEt/wt16hAyuGD0+uAnly7EFKcbPpni4lrJNq/zzMqM0BRD/4PRzZ/zbBbWtQCD4fayKeFYOziwiLuzzugidDWYhpeYow2c69QtonTiZWtgaFTnSkKuaWNmNp1sPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQyFPFh4s4dm+8i7V4G7TbJhWGFz2fTB5NPz5pBF73E=;
 b=h5n8V/SvmO9pxHM82iXi+TQr1rQchkWvUbMRu3MImQsnaiFgvIU814V7dpfdS0EbDBhWFSCHtcNG9EArsJ/lFfFL6HvVL7VOPHOqm00DHxYtnCVZNqkjzVYkr41x91yY+1rQr+5zf8zCY1bg6zs6WmTKxV69mkEiKzZe7QPdZPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB6327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 21:18:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 21:18:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 3/3] test: hook up test of allowing control DTB to
 act as FIT image
In-Reply-To: <CAFLszTgin=mUdzdxypMXrA867JFeesYE=fbO+-B+=Ce=X+iMLw@mail.gmail.com>
 (Simon Glass's message of "Mon, 25 May 2026 09:28:07 -0600")
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-4-ravi@prevas.dk>
 <CAFLszTgin=mUdzdxypMXrA867JFeesYE=fbO+-B+=Ce=X+iMLw@mail.gmail.com>
Date: Tue, 26 May 2026 23:18:24 +0200
Message-ID: <878q95g99b.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00073CEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1d8) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: b151649e-81e1-4957-4e1a-08debb6c532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|5023799004|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 33VUbzcDSTBu6Cbb/YYrITGSgOucz70oxIJtnyz00BlCLXN70yRtRlAynpjgjBVQxbFK62ezOwinSGsXLhFWji+1Onp55ek4crpnHBfsz6MElwpQC8BQNdG+xWrJ9KoCrVW8cz4Vp5xETBR8BRvZ635AOqb3t7lt4IPZbZ0kSQ4n8wPyjlK3rMr1sI+8lyyh/1HR/CIvKSgJ/DWahxSOvKejhxNlTl+yJd4kk6CVLn8V+v3ahIOtjKaZ3qJdiRZUI+boUsx4vIaLk5ym+qHT5fi1Tfi2/RtVe385KFjeKpimGIaNOveB+fddZKFD7lDn+XZJC2xaxu6vKk2Scf4MxjPDHCOvzKqWpehfYQ10+wkPoLi7gygfDxJQsQgh0ZeWL+JbX7LsE+9iozvaP0FNz/dVpzVm32l1Wlb8fe+S18rhkU2IBUMHkLrn3KDkPFbonKBxqMcDpJE4jSh5hRejobC9YEtB9t+tP0T8WcVSEyFCUm0RuTQ65OIwlhJfXNAiaqpKs0X6/QcoSBVe0BfObDfK+aYs4YT9gFiImKYaX9+KPUbHjvmXEgJXwB0rwIgb6nftJu0reIT+svd5nYgqdgEsTzTG65gyJkltPIKtQRUCSVx4tJaHEU+HdvqmMklDodFoaa0gND7Jilr9XJFTxF7wwYlo8ZQKYMxWOAHhiL7oZhs5vik+IOVX9UOlLNlBFkTBC2AwcTi71+/Jn8jLyxHl8+OO8zw+LbZGDZsDtBkwFE8k80SbnYZDE/TpChRh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(5023799004)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ph+AjVLodUIc6LSLlCOfO0OHc/9ahu0XRe4olaSg7gCBES5hRX0OfRywpMlR?=
 =?us-ascii?Q?xa+BkyT6KnO7e+6YzdQnht/7lTSfMR6x58UIPAYx4hyjen61T9nEqgCQPdSW?=
 =?us-ascii?Q?wDC2XOtxj8s662T1icqilRpfJLsyQqIjEcZdfz7QYVoADFWN2BcEvnU2gAAx?=
 =?us-ascii?Q?eZW2Db6UbYJf9BrNaMLU1nJO4w2+2dktiYADFwnvES+UV/4BLopo9Deio3yW?=
 =?us-ascii?Q?bpT/AnE9YlltSFEjyaZrbF3kD84WpSWWtvf290YSNzMkx6GBqrm0SGZKUwkC?=
 =?us-ascii?Q?wT82u3s7x0bt+VSLVuX/MrXlW3AQR4p9GvtoFpdHC/pnnNtC39BIiHqPhj5k?=
 =?us-ascii?Q?+CLXlRxBPejcYvf8dDjopobOQVDk+ZtawZlq1rsiNDs6vbK/SZuWQHVrvrwW?=
 =?us-ascii?Q?UBFMGxIht1/cND//u8HOGhURkoalYzJxzmn/MG90x3HRb05ShqPcSG/3Ya4j?=
 =?us-ascii?Q?UZX9qHnT9ItZxoNOmpY7a5Rrxn2Bynyn4XNZPlJzAlVld1oMjCjU2rbr3+16?=
 =?us-ascii?Q?nLkSIVWFtteTyNYscqnSccq8HblMYDxM8YkOa39hrKli4bktzqLQXzF8rKXH?=
 =?us-ascii?Q?jps0nZXT3TzcQyPgyGOM3tE7Nt5Qedltb0418KTUROGw99aLhcOvTabQRtlQ?=
 =?us-ascii?Q?ubVNgpByQGgS88hhm/tu9bIeZNvYRSF+Dy+WBmmn8fz5RwfIkNKCvxwp2bZZ?=
 =?us-ascii?Q?TCsrHIdXNexm3VfAbbrbg/VE2AsrNEUyWR2hxkUVM+lyZWdK8nCwFVNZCj4s?=
 =?us-ascii?Q?KdHH3wElZDfS5nqQN2tActA8nDmFFQgEkuXuv0mjxEVqA8DUdUTCIRiAJM+7?=
 =?us-ascii?Q?ab23C90fgx9eGBB9+2hl2CvXD0nQd683dum/CSSQxEZa4KJFcYWVrd36pkrF?=
 =?us-ascii?Q?Luu+s4UYv2DlJs71/gv1x3us67vNFokqaVt8U6BDKg8414lAaszbvhxdEx3V?=
 =?us-ascii?Q?bjwriMZhYF5phS31poFS6URQfObKxfq7LIOC33QAGFXdPDAb6dWl3rJAjcT6?=
 =?us-ascii?Q?DReBYBdmvznXYbwDFgpLxs8kO7xLPYNEyA2QfYhfpuTnh+qIelCrhvdAL31Q?=
 =?us-ascii?Q?8zxx1JtrF/nwYOZwETtMFrcrbIKcPFiLNAG7D15ZufRB/JeDFc1XrnteUVTU?=
 =?us-ascii?Q?LeU1vrwKaWHtiZIgO4LpL8JpyV1Y0LqRMQJScg9HGMx+XGuE4FJ/h69XLf/a?=
 =?us-ascii?Q?/IFhmTelkaURZvbnH0K1FwxOFNunbsKTjypFQ7wxnCuJmLfbL1aq2TrDUrGu?=
 =?us-ascii?Q?r+Qtdm7GKqSJ5Yvdnu5uDj8xmBhWoLxhWmAkD2/Vb+L4jNnIjdFjkkwKqyZs?=
 =?us-ascii?Q?4cSTQZUiOr3zojikIQ63bqBG4TM36qKIMJ4BwpjiBvmkZvu2EwUBNLlvxTr3?=
 =?us-ascii?Q?drbbaSQkkXIcjUGHrh4Y/XHSgY168j/+GXES4YEoegib0qv4V7TqLJkHXr4R?=
 =?us-ascii?Q?aU+a65mOSRLKOvRAJrDamajM1wub0RPoY5rshmOatAqNcjbQYFZfv/fbEULO?=
 =?us-ascii?Q?onFFzmJNLrgRdBskWTcR41dZLNDQSVJVimTYH27l9FSBk+QxeV17LobJHj0n?=
 =?us-ascii?Q?sEchlDZNBNfWtcI5gUY8XfHosBdKEVvU+09WLgOTFvv7zw6AIy99tco+rC2D?=
 =?us-ascii?Q?nxyLoOor6ApTkvlXyQd5dh0khoN/EXkyHyyh/jP0hAyrzUYlEGj0aqr7i4xZ?=
 =?us-ascii?Q?kqRM3m14R/5qfONcLh1LtyovEDQjiKoQnY9T/YDZVl1tmO2E9/8pXMlL+PV1?=
 =?us-ascii?Q?lhh/AnRQVM/qpDRzWVtu0rtx/jKDnXk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b151649e-81e1-4957-4e1a-08debb6c532c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:18:26.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7+6EtvT9bgPSx2iCc6w5ev0jkyqjRwNHuLPizOQ97rfbihjVoeoWITSK9LBS4T1+sq4h5i/78uCghKeKRX6M8u8PoaUlnNStohUV2Fxi4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6327
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

On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> test: hook up test of allowing control DTB to act as FIT image
>>
>> Add a test demonstrating how one can embed various scripts in the
>> control DTB.
>>
>> Verify that the source command can be used with ${fdtcontroladdr} by
>> itself (invoking the default script), and with :<node-name>
>> suffix. Also check that the scripts themselves can invoke 'sibling'
>> scripts.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>
>> arch/sandbox/dts/sandbox-boot.sh      |  2 ++
>>  arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
>>  arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
>>  configs/sandbox_defconfig             |  2 ++
>>  test/py/tests/test_source.py          | 18 ++++++++++++++++++
>>  6 files changed, 54 insertions(+)
>
>> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
>> @@ -9,6 +9,7 @@ import utils
>>  @pytest.mark.buildconfigspec('cmd_echo')
>>  @pytest.mark.buildconfigspec('cmd_source')
>>  @pytest.mark.buildconfigspec('fit')
>> +@pytest.mark.buildconfigspec('control_dtb_as_fit')
>>  def test_source(ubman):
>
> buildconfigspec markers are ANDed in conftest.py, so the entire
> pre-existing test_source is now skipped on any sandbox build that has
> FIT but not CONTROL_DTB_AS_FIT - so silently losing coverage of the
> original source tests.
>
> Please split the new assertions into a second function, say
> test_source_control_dtb, with the extra marker on its own. That also
> makes the new functionality independently selectable.

Yes, I did consider doing that, and I must admit I'm not really sure why
I ended up not doing it. Will redo.

Is it worth it adding another function marked with
@pytest.mark.notbuildconfigspec('control_dtb_as_fit') and checking that
'source ${fdtcontroladdr}' always fails in that case?

Rasmus
