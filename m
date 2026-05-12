Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7FCD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 10:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B880D80398;
	Tue, 12 May 2026 12:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XE6dQtNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA3380F0E; Tue, 12 May 2026 12:17:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AAA801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRtohnT3iNkIuH9wg05e0T32xv0K3IJqH0+0yh0kCiDOJTNDFIZjh/8qY6CAUbw8EPl7WmH1VpFDiVdvF4qoHhf+W74l7AhbvcXF7l7NMnHcc6IgAQLGi+irmiU6LzkalMuo6Dty+/stEG5X2mmNrRXgr2n0MI6/Q2ADzvrjkinv3dbx/mnBdJm77MDCpGbwFQHSludyYLMO4/44L66vpilU2Qa0P9Pu+niPUD5JsfzFQIkU4toQ2K/Y8yhaYvX98QDe38d96CczuOhZxW0wx72Ictugy4hjlMVyoUCW+/Jj8Fx9+Zem1Crm8OdkZfmyJsB0Y9i7cn7/JY/F9qJ2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkcyEBAvZ0hLbL4Tk6asF+FOgIAwDg0Z+MMdC49sfwA=;
 b=QhWhclnvivwosEPMnovaTgiWGQJvlahtTNeUHQANvqYzVSpMmqlUWnpgrMWVxQauS2CUWgk/ysRyW0VWUxhPYbaT0+q1kRUiepGlLOXbQIJp/m0ke6U1rw5fmGAyqI7ZoP/RfNeZ3vNQOAV7r4LdVGCGBg3N9Ev/lMYMhG4CNOR/5nMPBpSy8vduTjwUAczRKCZ6qsISY237KJpXZGVGvUEGPXnPnNVr6K4IyFWxEOeVzlWgN3jYJ7bpH3Ftd9+2bNsX3s/nmG/L0UolSnsmPxVtnb8BpY40uDGzwnM26/WHANz+b7L8ymvVk2uEWQK2uSVaORi9etg5DzJsnX2UPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkcyEBAvZ0hLbL4Tk6asF+FOgIAwDg0Z+MMdC49sfwA=;
 b=XE6dQtNhIF4CMOnn4dgRzUfowfDESXd/0EiP3mBuDrxbO6KqopyX/UYAMPdCGQTd3YKzgl6T0XKIKlPEciFFdFrSOy0ePWsVnIjw78R+YLpvFjqnwkM7c4WByDmOlXOpbZC+U4Q3h84uo3CUXIk6v3+hST9fE7JUkxHprn1x3FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9402.eurprd04.prod.outlook.com (2603:10a6:10:36a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:17:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:17:35 +0000
Message-ID: <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
Date: Tue, 12 May 2026 12:17:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR0902CA0060.eurprd09.prod.outlook.com
 (2603:10a6:802:1::49) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c4241-2969-40f3-6644-08deb00faf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|56012099003|22082099003|18002099003|4133799003|11063799003;
X-Microsoft-Antispam-Message-Info: 4K81IcRcr/+8xN3kg580/Tl36ytYsclmgItuJ9Yd8oD0GxyJpOHn9qhm8+4Yo/OH4FiQ8TDaRT3bfW9fkoF9waMLesPqPoKLZqnHLZUzkW2ckysxfx6LzbIInep8/1zN0qqFFCdYBTfF+qNIPoXfxSOTvYH8nywgijcpsXhJP/i1XMgcUlMtgUM79MG6IkX5a0y0Faokhk7ofvvPTkzzejyVmTngjmK0/94LPXlMZJpGTmO488WpSSp1AJkrLplKXxqIiir/XQgUhtI7VwXi570mRIaP/l5iEG7H2vQPBhtU4a8247quvdxLQqc+HKMxYKWh363DyAsxkds2LX7GzbIpzKYZdAlevelbIlKsgusV6mFlS91ueBcEBwzs9QfYCpbazO0KBAZFEluW9TiLjf7jKUMKxc00Zb4IW6nS9VSF98WRkaJDsZUDI7jADs5dfIX0FdFx5/zvSiL5/umeFC7lqPIWNSX2RkQ1d1K2CqNV1orZgmXPNro3jzIOdephiA/oosCRgkOp2/Mg+u/cxl8eqUs/4qLq93JecGCNSjYn44coBarY/DLpBl3iy5FQKLL9hqhGZUYuTNihUHKswNamKqZCb8LAuW86DNxUWp3j6TqVAeiKiDPeNC5mFIZs66eOmYqlLapvRuGh06hf6KxVQDmlqvBBF6pNMyq5ydtO5pUVTW7A5ku4KvoI5YTJ7ToSOrkm5C/RE2tg+B3dDOPFcwoyv8ZtXD1va2IQhRoeiKmJPp8fdMPzovNMfgKD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(56012099003)(22082099003)(18002099003)(4133799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlQ4aGpUTElYVnUrSDNMQWtCVmt0Um56SmtCUTlGSzFheU13M3ZhdDV0bXVr?=
 =?utf-8?B?b3hCZUN0SWZ4MWM3a3E4Sk9GZzJBRGU2TkpHaVFwb0RlQTZnaE8wRlNNMTdN?=
 =?utf-8?B?b054NFZmTmlPVDhXZXZieWx5ZHhPdUZxdzY2UU0vWTYzMC8yUTdvbVJMMVFR?=
 =?utf-8?B?N29qM3lkK1ZHSG9hT1luMWVjTU9uRUJ6ZEhCQlRSdlpIZm5ERW15b3BkaE1x?=
 =?utf-8?B?Y2VZc2p2dVJ2cEZnTGdOZXIxVStheENVdkE1MjVwUTNNd0JBK1hhWUlaenFH?=
 =?utf-8?B?cmdMaDdTRy9wTXRQWnFWNXNwUE5wZXcwR1RORjRHdldSYWtGdFVieWdJbWhs?=
 =?utf-8?B?UGJUT2dRZEs0NGZhcjlMQzlpNW03SThEb2RFQXdULzZtektBRVBtVGFCUzdz?=
 =?utf-8?B?T3NaS0JEWnZkbCtlMjNOc241bE4vZXB5aVZ0cUQ3QkhsYno4SHJlMkVRSWlp?=
 =?utf-8?B?c0toSGJKSzlGamdWUDlNc1FhNVRtWFpnSVdkSnhXT3NQSVdXSUNMaExQNHVw?=
 =?utf-8?B?NUZlbXhrQ1ZMVWFFelg5azZXM3lFbmdkeWZITTZLblpIV1MyNzFBa25LL2Np?=
 =?utf-8?B?bTBOL0xLa2lxb1duSC90eXBDdzFVQm5SeU4xdzdzbnB4ak9iYzAxNlFCYzA3?=
 =?utf-8?B?amRLVC9IUGpIWG9rNUQyaE1uSmE0ODdwNko3MEQyc0dnUUUwYXVFUlVPaEJE?=
 =?utf-8?B?R0w4ZmVydVZRYWRIRnJUMlphVllNd3pMOHdiMld5d0o5OURBTG1idXVqeG5P?=
 =?utf-8?B?a0VHbHVMNzVIYUlNaGE4UHowMUFsemF3dm9VOVcxZm9tNTF1cVAzS3RtVWJs?=
 =?utf-8?B?RmtDUk5xNG52NysrOWI5SnNPcDFYaTNCZ1g0Y1RsZ0dleERrbm14SUIxS0pV?=
 =?utf-8?B?d1c4UjgvbkU1YTR4Q1ZEN0Uxc0FLVVR6a2k1b01JZUtkR2lQdStvMm9hbDlw?=
 =?utf-8?B?USs4UEN0cnVKU2ZEVTI1Tk1MNU1hT3RsU2ltVy9RYUJzMTZTTnhFeTM5eXI3?=
 =?utf-8?B?TjlNUm1lcWNRUzFQV0lxRTFIdXlxdk83NnR4QXc3RkJHVzFKWDl2QkRlZU0r?=
 =?utf-8?B?TmlZVHBXbGZaMGN6d2dRUjRDd0FtUG50RXA4TmdodWxWbFdqU2xKQmEvWVJl?=
 =?utf-8?B?dk1BNGwrL2ovMlUrZ3hzK2pmQVNuM0VXWlJwVHMvOVdySmJaZ1dnMC9QQmMv?=
 =?utf-8?B?ZHM2VWwrRHkvSVlVUDdyV0xpbEdxVnk4dEVIcjMvREZKUnhTVkFxTzRxTDF1?=
 =?utf-8?B?N3VjdXhnTkZwRVpCRU5razlBVGQ2aWRvTDBUSFpSZHhNWXJWZkxiWkozNStR?=
 =?utf-8?B?ODlJM2pkWUF2SUhIOG1aRkFzaVJxSXdIY29xbE5WZ2VwWkg1LzB2Q2pIbmo2?=
 =?utf-8?B?cEY5dUNOUzVhYnhVNDNTS3B2U0dra0NEbWtPdzhVTEN1bmd3dW1rd3QxVTBB?=
 =?utf-8?B?MkFxb1RJSml2YmZOdnJQbW0rckh5cm5XZmJYZzZOY0Mzb3NlWUdsaTNzbWRx?=
 =?utf-8?B?NGJMT1lMZWZKRE9tVnJoUy83ZGlOcitWRHl2amlKSGluT1JBK2RDQm94dmh3?=
 =?utf-8?B?NzEyOFVoV3FMdlhlL3QveVErdXR4RStETGt4QlVNRjZzOTBFOUd3d1hFSEFq?=
 =?utf-8?B?QmZpYmgrSGZxSWRYT3FmS0VkNk1seldBbUVkRXhiWndDdW9pQ21Ya3M0QTIy?=
 =?utf-8?B?b0xEMm53U1BqMXRBOXJuQzBXSXF3UFJXOTZjZGhRbzBhTU9ha2Z0UkRXS2J6?=
 =?utf-8?B?dlcxYTFhbDlZZWozVVk5QnVIWlBGNXI0eEdnY3BoQXFDQm16RGx1OUVXY1JL?=
 =?utf-8?B?MUNoRm9Ha0pZeW1BcDNLN0JHaC9ZTnpucmZLN21wYSttOVVaTnA1WWFpRWgr?=
 =?utf-8?B?WG9lN2FPUTVQTzBrRENQS1lIYXlQVUVPem4xdUVud2FWems1YmJpQm9tczRW?=
 =?utf-8?B?T3pKamgzOG1jVUtyOUdyMXAxbGVlU1kyc2hJaDlFVURMUkxqS0FBWFFwOHla?=
 =?utf-8?B?R2VxVEhhVU9UVFBXN0dTM2w3VXdveWlHZC9pbXBIUldWaDJuNjU3QndxZExa?=
 =?utf-8?B?ZEE5QkN0VGFrSUpmZWlnWWQvRnptWmZ4N3NxUnhUdEJ6MUFNVkpFY0N3aFRj?=
 =?utf-8?B?bjFRb0s4SGswL3ZKN3NJMHJrd3preE9XbjA0NjRkbVBNNUFzeFhjdlpNQVg3?=
 =?utf-8?B?cWRtZitMVGhFdzFhZTliNzhBUlpqcStFYy9vVzdmbXB5RElDYmZlNitpRkRa?=
 =?utf-8?B?OVBCRGc0ZFNtQWUvYmNCUEQyQVJFL1Z1cUxhSDVXT1RIYUxnMlpHaWs1czlX?=
 =?utf-8?B?Mmh4QUxXVG1hemtHYlRvOTVwVnhuNGxHYzdydlBXQXU4VGlxT1JlbG1OeEQr?=
 =?utf-8?Q?5OiOe7kVQyTTdy7mBA78EAZ0cW9KHrEqbKjSceCPlznCT?=
X-MS-Exchange-AntiSpam-MessageData-1: mevTQeDU5VvwXSYAxOZgRE78c0Due7R3H7g=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c4241-2969-40f3-6644-08deb00faf44
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:17:34.6431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayqyg02X1gZaVEVbhGrNzH+fjUu7SZHd2j/sQYI60zKrqthVnzTCVIDJbpnOxEM+Cmn96gMCDmi5hckMG/m3gUaMbuTKyPQv5oY7nJ0rDZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402
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

Hi Eddie,

On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
> 
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
> 
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
> 
>      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>      Author: Jan Stancek <jstancek@redhat.com>
>      Date:   Fri Sep 20 19:52:48 2024 +0300
> 
>          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> 
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
> 

But does it actually use a provider or an engine to begin with? I don't 
see test/py/tests/test_vboot.py calling mkimage with the -N argument. 
What are the tests (or command) you ran to validate this? I briefly saw 
the CI failed in v3 because a package was missing, but wasn't it simply 
because the headers or provider libraries which are now necessary for 
building lib/rsa/rsa-sign.c were not present? The logs aren't available 
anymore unfortunately. If that's the case, then that's also an issue. We 
shouldn't need to install providers if we aren't going to use any? Yes, 
I know that we currently cannot compile if we don't have 
openssl-devel-engine (on Fedora), but if we can improve the situation, 
we should.

How did you test (locally is fine) with providers?

> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>

Please do not forget to add the colon after Tested-by so it actually 
makes it a git trailer instead of just text.

> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
> Changes in v4:
> - Add comment that @engine pointer is null when using pkcs11 provider
> - Remove extra line break
> - Add pkcs11-provider package to build dependencies
> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/
> 
> Changes in v3:
> - Removed Kconfig option
> - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
>      USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
> 
> Changes in v2:
> - Remove default for new Kconfig option
> - Use #ifdef instead of IS_ENABLED macro
> - Remove comment after #endif
> - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
> ---
>   doc/build/gcc.rst       |   4 +-
>   lib/aes/aes-encrypt.c   |   4 +-
>   lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++++--
>   tools/docker/Dockerfile |   1 +
>   4 files changed, 103 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> index 1fef718ceecb..29a6a632e7e3 100644
> --- a/doc/build/gcc.rst
> +++ b/doc/build/gcc.rst
> @@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
>   
>       sudo apt-get install bc bison build-essential coccinelle \
>         device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
> -      libgnutls28-dev libguestfs-tools libncurses-dev \
> -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
> +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
> +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
>         pkg-config python3 python3-asteval python3-coverage python3-filelock \
>         python3-pkg-resources python3-pycryptodome python3-pyelftools \
>         python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index 90e1407b4f09..4fc4ce232478 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +# include <openssl/engine.h>
> +#endif

Considering there are no other changes in this file, is this include 
actually needed?

>   #include <uboot_aes.h>
>   
>   #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 0e38c9e802fd..f456f3c58e65 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,7 +19,47 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if OPENSSL_VERSION_MAJOR >= 3
> +# define USE_PKCS11_PROVIDER
> +# include <err.h>
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else
> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +

Sorry but that's a NACK.

As far as I can tell, this effectively disables using engines when your 
host openssl version is 3.0+, which we currently support (and I 
currently use it). You can have this for 4.0+ as engine support has been 
removed, but not for 3.x.

> +#ifdef USE_PKCS11_PROVIDER
> +#define ERR(cond, fmt, ...)				\
> +	do {						\
> +		bool __cond = (cond);			\
> +		drain_openssl_errors(__LINE__, 0);	\
> +		if (__cond) {				\
> +			errx(1, fmt, ## __VA_ARGS__);	\
> +		}					\
> +	} while (0)
> +

Is this really related to the PKCS11 provider? I think there's a mix 
between "using the provider API" and "using the pkcs11 provider".

> +static void drain_openssl_errors(int l, int silent)
> +{
> +	const char *file;
> +	char buf[120];
> +	int e, line;
> +
> +	if (ERR_peek_error() == 0)
> +		return;
> +	if (!silent)
> +		fprintf(stderr, "At main.c:%d:\n", l);
> +

main.c?

> +	while ((e = ERR_peek_error_line(&file, &line))) {
> +		ERR_error_string(e, buf);
> +		if (!silent)
> +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> +		ERR_get_error();
> +	}
> +}
> +#endif
>   
>   static int rsa_err(const char *msg)
>   {
> @@ -94,10 +134,11 @@ err_cert:
>    *
>    * @keydir:	Key prefix
>    * @name	Name of key
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider
>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
> +#ifdef USE_PKCS11_ENGINE
>   static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   				  ENGINE *engine, EVP_PKEY **evpp)
>   {
> @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   
>   	return 0;
>   }
> +#endif
>   
>   /**
>    * rsa_get_pub_key() - read a public key
>    *
>    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>    * @name	Name of key file (will have a .crt extension)
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider
>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
>   static int rsa_get_pub_key(const char *keydir, const char *name,
>   			   ENGINE *engine, EVP_PKEY **evpp)
>   {
> +#ifdef USE_PKCS11_ENGINE
>   	if (engine)
>   		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> +#endif

We should probably at least print something when engines aren't 
supported but the engine parameter is passed, or maybe even fail as 
that's an incorrect configuration.

>   	return rsa_pem_get_pub_key(keydir, name, evpp);
>   }
>   
> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   		return -ENOENT;
>   	}
>   
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +

Why are we unconditionally loading providers and specifically the pkcs11 
one? As far as I could tell we should know from the URI whether a key 
from a provider is requested by checking if a colon is in the URI. And 
we can automatically load the requested provider based on that?

Otherwise the easiest answer to this could simply be: "let the user 
configure this externally via OPENSSL_CONF environment variable".

Do we also need to update tools/mkimage.c (and doc/mkimage.1) to remove 
-N engine from usage if the tool doesn't support it? Do we also need to 
update doc/usage/fit/signature.rst to explain how to use pkcs11 provider?

FYI, we (my employer) are migrating from engines to providers for 
signing FIT images with binman so I'm starting to have a look on how to 
do this now.

Cheers,
Quentin
