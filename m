Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295D5CD3430
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 09:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F423846B1;
	Tue,  5 May 2026 11:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EwA7hrIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188C88484C; Tue,  5 May 2026 11:34:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A587846A1
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 11:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR1rAd5ymIhF2UWSg/JIk/LXxbb+oVG3xDfrJNplb0/dMJtB5LQFBOBW12vbJyP+9dZjxszzVvT+/FpOdsB+dXXDy0vaM8YUdXtUh/PSOsxyKTnDA4G05kAARtuRVMb5HMNj+/GLNwYFNn1p8tzjTmZqD2s/ODYtgPfWMxeSP8odOgtH1JmbG6mjPEbqcIRrLuKWUDrxO2HgTrI+Hdl6Sdy7Ov/3OnXEzZFgxfjCH/vuHq/zLb3N6k7fVyf0Y3geZy4+N2hgiieergBmPomEiA48nrvnnxlXlZgaX4W+xSauVUFh4Bdr2NqjaBdZWZe5do8MDuZm2ahR3Ecnf/wJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dl8TSH6QXOVnz241xG5W6knau9zG1s4qo3KnXdpHA0=;
 b=EiV1qnLYjbl8bjnc9iz4FjOdVQg9nzZOk82MQXkZBuszqwsaXzNBqQtRd4K3ZpcVJiSliE4pTdHoRw2Kx9d5ZdZ82VPEaPj/CwyLkR+rhUj8WKl1J7tXOt5g9AgnSDbjlpxrXdxjpsZSBumfrUVQczZ/t2bBnoo1pEhNd8ccQVMWLH2jc0S09phD+LO3kEadJATKnBQUeLkVuE1MWzmR4gEz9AWbcbBjTizf2NnZJPgE79ukBhPVLLieZ3JSR3hJPuPfD5xgGughmsi5p3cW8eFw2izuY1L3molkOOhSFc7jlu5GR2PxFy3ZyYBd+xbbiEDUIze5CymZLRFyUVNmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dl8TSH6QXOVnz241xG5W6knau9zG1s4qo3KnXdpHA0=;
 b=EwA7hrISf7FzBuIAhC6VH0gTzZ/ilBWRx6jx7Fyt3cf97uyAs1sLRvGEpxVYjUCYN/+RPXFz3x9qk/WYO1dzG1ov0VpCN0CBQclb2lu4mmAtBaVrgHDrnW1jevVkYeT7X/5X5vliLoApFj5VthOs0Y4ryI/CdPW0gC8TKLjZe1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:34:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:34:15 +0000
Message-ID: <cd62b6cc-f9ae-4ad9-ba7f-28629d5f0e78@cherry.de>
Date: Tue, 5 May 2026 11:34:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 02/18] CI: pass clang HOSTCC and CC to pytest
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
 <20260504180534.GK1614990@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504180534.GK1614990@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000213.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ca) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10081:EE_
X-MS-Office365-Filtering-Correlation-Id: b18dfc62-facc-432f-41f7-08deaa8978c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NEgZIgXU7YWX8SNYrVFKQR3DLKKVnZ2CUWXXxc+wEhidJfn1nNiReIQ4j+ZDL1ELzNRPZUnIAujknaECOmFuwJe2SSSEJV8Jkh4bEgUDG3d1eASrU/DJwDgWm6uXLgTLzhwpkUgkS7WUSTK8IhvUN61BHkCmLhhPGUhVHJnHWnrlnaBic052ZY8bohCJcCQZeOdyfkgLrFLgmTJPSOTXcD4eytGW1oUFZOOafZsDtxOs/FczbVTuLut5ZZNwB+Rxp7Ms5ZU1IKDf6GiFvctXXYhi93DqNIn6R4lBsGusNhatXJcjp47PkLgNFQZDtZ0k6Htpm7UTIMLTaU514JBHugd8X53iHA1a9h4ZWePn2sz/1VvLBnjBhdUpUa8Rrh8cAjMRx3qezPCLhPwRQnP9N2pz8djQOX7sVs9WMm4NX93gUsK+704htKB9drEnrCXtyVp4sm9ra4hQziPVFtd2PRMhRWnvDV2K1jTVbhzyzfxtUsCRzYqCX9I1Lpb6pQtuvmxELSPoUZxPX3n3FertYx1AeHf1AfubMmBC5d835NZ/UlhFbj9TLVgiZoU8ivqrLTwUaUAeN0dCgw29aQq+3CfxzKkLiZvo2nScELFQO//q9VRuIJsqdZmifMU60bb2n3dq38nsyCFxURT5CV8nAP2h9pcHbWZ+hY7QxRoAYIDtlDFmndcnlJ0Cek4RC4iEU5ZXzujw2zkOPY1eXF+X5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVN4VENjemZsUUZ4Vi9kK1BYWTBaTDRxYVd3TG1DOUp5elNzeW5URjBCNFBF?=
 =?utf-8?B?KzhFblFJR1JVSXV3dTh3bUVCaVhSUmwxYU1LVWxnSXdxeUN4MWkvNVdBQitP?=
 =?utf-8?B?ZXYrQkMzaWxVSGwvQzQ5RSswNWh6TlpGV1gyQ0VoNzR6QVpwWkZtREd2Y1cz?=
 =?utf-8?B?dE5qUW52YXVoL1BtSEwySEh3REViY0Z2WktJamFwQy8rWUlDc2o0aVlBZ2V4?=
 =?utf-8?B?cnFaR1dXbHNxZlZzQzBWYWl5azZwT3ByRUZMQm9qcS8xZjdaQzBSOHM5UDBQ?=
 =?utf-8?B?bUQxd2pXUjBkeW9TdWFwNHg0dTlvOGdUL2o3UjM4c1lqMUV4OGxOQ2I0QzZE?=
 =?utf-8?B?NHo5MGRxWThCcjNmcTlObDZaYnV2bHVzM3YxYmxPeFpxWlo0VlNuRjUyUU1u?=
 =?utf-8?B?Y2ZHOWc4VnNrVFkyWENyWS9sOEJ0L25Ya0E1eVlveHZTakVNWU5JdUpOUW1Q?=
 =?utf-8?B?WVRqdUZDUGh1T0dJTGFjaW5zNi9LakFydkFZK1oxYmgwLzVRTFpzd0wzTjZz?=
 =?utf-8?B?ak9mbkRoUUFZdXpxbzVzMDZ4V0JYVDUwR0VRQzd2cjUyTHVJRnVmV3pFUjZh?=
 =?utf-8?B?a2duNEJsOGJ4QnZWSVJXamNJTk5hcGNZZEhHazYrdEUzSUgzcDRITkVyOE5E?=
 =?utf-8?B?SXFRS2VQN2pkRTJwZ1ZETGFIcmVVZGFKZXpreE9QWXJ5eXAvOE5RRjBuNHNz?=
 =?utf-8?B?OG5EdFBNRi9iWW10bW0vZ1RiTGc3YU5jUkhSekh4SUFUaytZWGtJTTVZdmpM?=
 =?utf-8?B?MVVFQndlVjhZelBUZW1BVytYdmxnMEM3YUV0RllCVDEyTTliVGJZSTFYS011?=
 =?utf-8?B?ZWRmc3JTeENvVUZlU2Y3MzJOZ0JxQUgwVEVFTTFxelY0WWUwSDMxN1BmL3ND?=
 =?utf-8?B?bk0vN3lnaUE5Sm1UMUN5TndKU1ZzejJCMExIaEo5cDdTVzgyL3pGTDdoRjY0?=
 =?utf-8?B?dEw5czFkNTc2UGhJbmo5YlVNeUdvWE1MVnMyZVg0R2dCR2U2OElmZWd0VElr?=
 =?utf-8?B?eVZaZDNsM1Z1QmJ0akVySEJGaWtjM1ZrQmFFMCt5bWtVZDBNb3h4ZVlFajlr?=
 =?utf-8?B?bEVHZ3MwQjhYdVRQZmhkb3dSendXa1U0WHBhVVAxcEJiZWdjWlNTMnh6czVX?=
 =?utf-8?B?NDhGUTJtV0t4ZDVpRXZRdWp1VFUxMEVnRHE0dWJBeC95UmhqYmZJSDcrMVZV?=
 =?utf-8?B?Y0twYjdIbGd6bjFFbDdFdm5ZaHREVXQ2M1lzbzBmR25uMkVnY0ZlTHVLeUp3?=
 =?utf-8?B?VHdmN2tkTnNBYURBYnJKR1JTNzhnSXAxRENMaytCSXFXM3pRVjg5aWJKLzVX?=
 =?utf-8?B?bE1jV1R6SFZ5cFNGWndzYVArU1l3T3dkUGw3WW9CZmZOekZWZEtnSkdxd0Jy?=
 =?utf-8?B?cWVLNW1ZZGJHKzJFUVREOXlxT0lLSlNINU93cGVLbHYzMUo0ZnFaVy9GZ2hR?=
 =?utf-8?B?QVBySXcwS2JRTGgyeTBrclNnb2tZNjB5Y0FIb0FBSlUwZmdiUDNEY0lkN1po?=
 =?utf-8?B?NzN6UGZPS3phR09DZW4zUDVBVUQ0SnZWeTlQVDVrWEgrYnNCNWJ5bkdvakdI?=
 =?utf-8?B?RHpKYkNGWDN5Qm1Wem5YSzc3QURDSXJNWHNOMVBWUUpCNWZva1dURFQreE1o?=
 =?utf-8?B?bVJKYS9MYnN2K1B6NTFUZnhlRi90V1cxSFpldFFBL0ltcVBSa3dPWjVxM04x?=
 =?utf-8?B?cE5OVVU5NWZ3Z2FqaUpRVWFnZXFEUk4raEJZdFd4SnV0dFlxV1FVcnNEeFpi?=
 =?utf-8?B?a1BpRHRTZVlOenRNOHBtYUJRRDRWSmVuUFNhMXpYanRjczAzNC9Xa2hhemhS?=
 =?utf-8?B?YnlZNndHMVRUT3dScG52WStPTmxWbXZjVFZGcUEwTVNRTGVxYitKTXBsMm5l?=
 =?utf-8?B?SWRRbDNSTTI5QXQ4QTBCaXRYemFjdzJQeUFjZFJzOUlzc0R4ekJJaW9qSmU5?=
 =?utf-8?B?b0l0RmJNdkgyOFhzOUkyUG5mbzc0aGs5TFJySkRWcThhQTBqSk9wR1ExZHpk?=
 =?utf-8?B?OTlQT1JISzYyLzVQcUhxenZFcEo0VnNGV09uNC9samhoOTErTGdJL1VWSG5W?=
 =?utf-8?B?MlZEU3VobS9OSlhRNmpBdURvZDNsVXhRRVpxdTM4cW1PY1Rzd0FYNVpWMEVu?=
 =?utf-8?B?cXQzR3NCVUpXOXBxSHF4RXlqeVNHMndzVjUzaWtFcjBNaVhoOVR3cHEzWUl2?=
 =?utf-8?B?RlV2b1k3MU5XeSswVi9yWXV3V3RqNWk1VC8wMEZXYXh2cFZNTEJXelVkZlY1?=
 =?utf-8?B?MnQ0amhWbXJpZVJsdklEcjkxTnNnYVpzWE02QmNVY3BUUmpBUEdOWlN6c1pW?=
 =?utf-8?B?VDlLK3VjV0VQdGI2dlRpQXZUU2E2WEs5NVpoTEZ1V3IrN1pCSFFsdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b18dfc62-facc-432f-41f7-08deaa8978c9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:34:14.8831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d15UWTKLUrM8cNcbinbAl45yIf4uSe1gQwAFbafMeO3KYvIUsJnC1OwYxfumjYM64TWTVt/W45V6kWiHSoKMMvwc1rM7sIso8x1hi5lnrhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081
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

Hi Tom,

On 5/4/26 8:05 PM, Tom Rini wrote:
> On Mon, May 04, 2026 at 03:20:29PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> test_env_initial_env_file test calls make on the build directory passed
>> with --build-dir parameter which points at UBOOT_TRAVIS_BUILD_DIR which
>> is populated with buildman before pytest is run. For "sandbox with clang
>> test.py" and "sandbox64 with clang test.py" jobs, buildman uses clang-20
>> toolchain, but pytest isn't configured to use that as well, resulting in
>> gcc being used with a configuration made with clang-20 toolchain.
>>
>> Specify the HOSTCC and CC clang make arguments so pytest uses the proper
>> toolchain, this will be required in a few commits when we'll upgrade to
>> a newer version of scripts/Makefile.extrawarn which gets rid of checking
>> whether a clang flag exists (because it's supported by the min clang
>> version the kernel advertises as being supported) which will be an issue
>> since GCC for sure doesn't support all clang flags.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   .gitlab-ci.yml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 245e422d72f..d0ebd9f123b 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -288,6 +288,7 @@ sandbox with clang test.py:
>>       - ${HOST}
>>     variables:
>>       TEST_PY_BD: "sandbox"
>> +    TEST_PY_EXTRA: "--make-args HOSTCC=clang-20 --make-args CC=clang-20"
> 
> Is ""--make-args 'HOSTCC=clang-20 CC=clang-20'" not parsed correctly ?
> 

Well, this will make 'HOSTCC=clang-20 CC=clang-20' a single argument no?

Try:
make 'HOSTCC=clang CC=clang'

Makefile doesn't like it.

If you're complaining about the need for duplicating --make-args, it's a 
choice I made when selecting the "append" action for that parameter, 
c.f. https://docs.python.org/3/library/argparse.html#action.

We could use the "extend" action with nargs=* or +, but I personally 
hate those. It'd look like something like that:
--make-args HOSTCC=clang-20 CC=clang-20

It requires you to be aware of the special "--" argument to stop parsing 
of command options and start parsing positional arguments.
Cheers,
Quentin
