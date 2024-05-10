Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949FC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 15:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8B3887DF;
	Fri, 10 May 2024 17:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Mx8sgica";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4965E887E1; Fri, 10 May 2024 17:04:38 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2814::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A5588122
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 17:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCCtB6cuHIIBTADTPE4rikwZ9+c8jbDvrFCHpljQ2tlv2dXWEim16QZztp1x9gu/XY1MQ3aDsDqnQvorvWKQV7wqccw+JdcCaWQhk9OAuPcfeTOKVtNFld0Lj846EzQVvdXHHkI59f6bBiqj3Sl0E0NeqQtUCBgN5EZTL1PtTf/a00HaaenRphTA3Jtj42e31bb3Zu3wlKiqyMYAmbljgAzfSiS1XoOtHJZCGZi54hkV8jKkvABq7+WIOoOMgwdSKVerxFovuDmVNOOFMdBsV5VhrG1dpuIH/9jGBJKH0phtg+diqvlbK8I6zJZkYCLuTaaE8NiJ1fCOuHRnk39Hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2O1Sz01uKuEnggiqoFPDwh5PG7uMVbZ9gmTh0Qsi7o=;
 b=FiS05jVhPZd6BNKKFQ+GAS/GCqy+tCfJVaFTrngaMXMBL+BS00dheJllN3xkLXZXFSxWkKiWthHm6edEovLQouduXzuBLowdIEWASkN3zFPbM5SBgXSRSzwzU2pdPDJdr/uQEgFCG4Vu9nzYOMZ8Cy2/wXspgM78FIAYCX6mhWJZcn+VpJevM/gQGhsflnl5988mHvD5VuPP9e09b+cAuZdnI+gsBp+JevBqjqplYgYw0tPppO1a8AJUDQs8vO05OzEFSuVb0WZ3I9QNg7hfKW28Za57I3nitVCHSlz76JKAbpjctTTJEpdTUlGbhJYu6n0I477a80sWgFC5EvRsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2O1Sz01uKuEnggiqoFPDwh5PG7uMVbZ9gmTh0Qsi7o=;
 b=Mx8sgicaxCiPWG4aSI7/2TPqlnd2KDJ1FJF0mBweKYP3U0t8EOAvNMq/U9r3taFivfLD6KrYaLcJ1NsUoPiJ1Jz8xoCbRy2uqo1efFT2h5o7wgiZL/oRqmr47Sj+RlJZn3GdhmEjKfHldPjy1FS7DEHZ7haJ42d7nmlrcn7ApwGegOQG29f9k0vf3aOYlOBAI1gxme9rY6F3NsrndTE7nSvOfrED9WY5KCqEl89pT+l55K1ussM/ke1NP67AZpBHjYMisyR29ArOWSt02WdyHn1Q7cgTUg7OvcysIfeFJDwBSOIe6ez6qfxnyNoH6i9xJu/5ehTQw9IB82OfvBhC3A==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OSZP286MB2459.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 15:04:30 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4982:ca24:1b5a:a88b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4982:ca24:1b5a:a88b%5]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 15:04:30 +0000
Message-ID: <TY3P286MB2611E44E8CCCC9720E0C28BF98E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Fri, 10 May 2024 23:04:26 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/5] board: add support for Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
 <20240510055223.11617-3-heinrich.schuchardt@canonical.com>
 <TY3P286MB2611F8A85713E2ADEF0F918998E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <TY3P286MB2611F8A85713E2ADEF0F918998E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yVap0lOFVM10rq4Jf6pV5HuA"
X-TMN: [F0v1d9jyulzgBVRJZp928OtNBdmUkOYCIrxgUbGJ+tTIpq0lQ7sQ2rPoXSkouqBEfh8alCx7G2E=]
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <f770513c-0c0d-4281-b1cc-9f83787b1235@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2459:EE_
X-MS-Office365-Filtering-Correlation-Id: b6eb4d70-0924-4bc6-9c2d-08dc71027e8e
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6092099003|461199019|440099019|3412199016|1710799017; 
X-Microsoft-Antispam-Message-Info: fs/oClUWYLvrmBHnnJATvsjibHWqwrzmqWZSSWZoaQ/V3nRL3PbrwZLvZFCyDDrtPlHg126DWx9Si1OIOehNnqNQQaW44cVGvk/lW/w7xRu8ZRsXb0wV/0f7a0ZV9jPW51ZZjfpcfXbinT10TNOLjbgG4zmPluwMxIXYRpSQWSK+MsnanVs0+Dp8mZtZPyX4iFu552F1t8pGLz6/q15AU8gI08jCBG68LBfe1MFBeIJ5Mcqjn3JZbUhI4F3ar2DurqPl/4wfjCqq8QMsBYkhkANXOsJA+m/DwFqXZILyvrKHOr+VIDwpL60V6jqjT7HEUpEYCdAkmaw5okqZkQGlrL/yhwp1tqL2Z7k5DJG4VpBEWs9heP53wbNQVTyB+bSYp8RyPPkaaolFcscO84wg9yC6L37WEBH5Bgbp/y6bX9t/wCUC+8p5TL9q3MluG2SVmtDef60EKlBkqCWxtyraRLok66iPL5BU4eKupkfwtNPjjxVZJF3Wh3lEOl1CYTeoR0LqU8l99BM5Cpw6yNAThVvrxVzITZzLYG9zoA1Mw4QBKg+ZvtQt+5XZfZwtCF7fdf6J8uHoR4545vx3mGDu2a3CatmaqeTD862KfOne8J6ah4LH3ObLVVKZVCY7rwBeOyEIMSZDGP7lCavMjYwRZw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ow+ZxVuTPGJuwcbVFdTSh65EkoBwKV2+NYCjE1pIcRX+KprIPb+IUoDa/sMQ?=
 =?us-ascii?Q?hUFczok0V9ggdvKZ6QgIJF5X9rGF4PceAUA2ph7OczuaudZOun2G3i9VsjL3?=
 =?us-ascii?Q?Iq1KH7q4qrfz3lXS4m33tERIxIIDuSohx9tCVXgfwibj0uNFqrrVR3lgL1ki?=
 =?us-ascii?Q?foML1/YDCHtdbW9CmVD9kxoTrnEMI91hc/AWwfsBRtd1/G3Et25RbjzRn8DI?=
 =?us-ascii?Q?w4S4PagdCsHBGRgv3xe3hch3Fx6WM+XzYob7Pu3x668+GODxUVvHcFuH0svz?=
 =?us-ascii?Q?46cuvooZX+QEPiiIzQlr2UTeL9FlFV1RIoZY763927aFfWmVF6txDQ/kAL5m?=
 =?us-ascii?Q?/sViSjQ6Md5+aypZpAlcDBeofeyf3uxSTsbIwi31bX4uO1Egy3L+1Mau4FRL?=
 =?us-ascii?Q?NTUG/hubgXxOa83rQmadf2/3XS1mn59mM1CrOklwA7bZsg0WmLkm1drnkNh0?=
 =?us-ascii?Q?gTvNZGXfe8y0vJVveX8NEm1EjdQBv9ts0X4rnnrpH7T4fFCNepAYgNoaknHE?=
 =?us-ascii?Q?NyG8k6W6AxN+pYTb1COZuDvnTemLvNDm4/ZL/BBVuJY5JUwfqL6WLdHNZ0Ev?=
 =?us-ascii?Q?TB7m8IXJ8bYoRBRGOsRNUKluCEVKUWpT4OqqQmyRojs2SpJgjKhCQSU2LRgQ?=
 =?us-ascii?Q?8LqATcATWm/3v1N2DT2399SzwqCIBvBGWXEsmvOzi1nb5hL5hU7ydTLw5sRn?=
 =?us-ascii?Q?OAubDo0HVge3YTW/M+kOtm35Bla7OgAf5T2u+56vUJFYw3bZxnEq1usSohox?=
 =?us-ascii?Q?EV6ujRi5q+0oTWxiRmgBqYgPn/pWUChOpPDPVn+YiS4ZKqR7Enn8RXQvxTqV?=
 =?us-ascii?Q?CSOnaAQlQ3BvKFAul2aCcp02QATo3nhnw94DKfJJ41/EGda6Erm1Djtt1wKU?=
 =?us-ascii?Q?gsYP+OZKyAAz3eHlr8yHFPwW7HDw8u5++iqtPH+lEYSi+BLWLlrWioBkPwia?=
 =?us-ascii?Q?cBtwhIQqWBH6Y1jVuuin+0E2YUuWAW0fJ0WMrDJwdyTB833DbrlUC9GLxcVR?=
 =?us-ascii?Q?Bv1vcdhnBDEcCZHa60JfAcuAp/Ic91KPRMIOOBmtnA1gy9AlnfCcHqfT+2YJ?=
 =?us-ascii?Q?80nQdmN3s2vBH49abJR4F4H4m0fQiAf4EJYNyk9YyId8KV1ldqqsrvBg9gsI?=
 =?us-ascii?Q?ZdstjyxP8jp1lkqzhS4GRK478YfM8H7Y4gDQmc5cNlDQtGQvco6G7+PELtrw?=
 =?us-ascii?Q?nhOt+7tGSbn+bOT5shLUNjxirXHzSPSAiqJbwHBSz0O+XHv++blBOOM6WKpS?=
 =?us-ascii?Q?2iZYHnu4VmTsaN7UoQ/jrpW3YEY+/LWVOhiihphWj/rn6MgPdl4xW1WDHvua?=
 =?us-ascii?Q?Cvw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb4d70-0924-4bc6-9c2d-08dc71027e8e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 15:04:30.8308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2459
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

--------------yVap0lOFVM10rq4Jf6pV5HuA
Content-Type: multipart/mixed; boundary="------------XRQ0Bd1jdrfivVeSnm0g05iG";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: wiagn233@outlook.com, Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
Message-ID: <f770513c-0c0d-4281-b1cc-9f83787b1235@outlook.com>
Subject: Re: [PATCH v4 2/5] board: add support for Milk-V Mars CM
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
 <20240510055223.11617-3-heinrich.schuchardt@canonical.com>
 <TY3P286MB2611F8A85713E2ADEF0F918998E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB2611F8A85713E2ADEF0F918998E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Autocrypt-Gossip: addr=aurelien@aurel32.net; keydata=
 xsFNBEoFU8cBEAC8RFeiCQYAWyRAM3znUKeHjbBs2bTqxsYkuCRQDilOUYHDgkH+Gbfv1Lng
 0XrGvMiAsqdPnp0SR8ADNW74xi03GTUiz8pfiHl9NGipuLKESsoU5jrRv8Ujpqq+zj1lbKod
 31vh6xbqPBKamKgR3OUuWrNlGeavzQTAe1hyzG63K8X0eZ/1OzoKHf9OBgbKB7BHSc7+L+G5
 KGX19XFN/Ic6znaEhiLgRKaIGOutGsUxZoTEqYnsdpIkwwzgEP0W8C29WCotVDXA5IO5jliL
 M3amXQqSgccm+l/0AdDSZALVWoL5juO+Qc7pNkbbCI+yjwSNqJR//FwPUvX4drggPKZ+n3bO
 u7pnx0uFdvb+8SptjurqGLeSOjlEPWZPzCLShY4tkUnCBMbDSP29vp3Lfl6MnWgHKs1IyEMw
 FEl2dXWo1OshOrjsDh0if2aBN6dzPJ99MllcrdPG6d6rbOvs8WBubAjysBF7XyA2i2ePk2Bh
 WwweT+hwole7nmpkgrelcNnoC3t57TFuATlv7iEQFoKYKSE0oDDnv7iYjdCCOBO5IJssp+T/
 SJtM7sJXzeQxPhyRWkCLHNR7fFNmJVbDCtVh9QPHWhEfX0IbJflYAQ4edavqR+jIY0Gowx0m
 hb0Xb8sbQl9poPiBzg7IeP44D31ES8VS9H3/uyMY/HbGkVoQuQARAQABzSVBdXJlbGllbiBK
 YXJubyA8YXVyZWxpZW5AYXVyZWwzMi5uZXQ+wsF6BBMBCAAkAhsDAh4BAheABQsJCAcDBRUK
 CQgLBRYCAwEABQJLRbXAAhkBAAoJELqceAYd3YybDbwQAIqQROIwoed5bOIVYR7vqIPXVWBW
 CbGtZzbVCgD4JRdPIOqtB1aiUoVYxM0kRUcvRs4iOc2YBd1L1/u8XWrpgTg7Op7G+JufusXI
 4Kd9p5XpvVM4ryGkn+mqbpd2YuV5rdTPO253gdmrRr60jmCB08wODYStEGApPM/mI90FMOzz
 Cc3xR8IS86OnhUul4f7V8Yiz99Fe6B2LGqrAzlvS+DdeGFGpq6QyRoM+2uyq5ZH+HToPDCk2
 RB7DOlXeyZj8DSshwMJMU8Iba9R9Wj5NX8eCakdW2XGMec5wrW1hzjyE3N9TNcGV9AxIOuB4
 LEz8PCS0QkoA/LJqm28v8lgYuyfo8C2aL1IqDeClCkRt5rqEEAaFffuo3OQNXEcO7zsZ0ddo
 wbK/Xl1yCcqk+qXIoqlHni56StG6csi45iD4DmAVbiYznKlFFweDBixzooUbFt0mvoV981ix
 00g6kz1RWUbjQ9+on0oEznr+Wwbsbe5EXOfmnqe6E2jwXnYqeuxTY0cwHKTsObOxIntY67VS
 N3XuD+hIe+joFydr18BuISF823cFZWbWS8zF5wXmWR9TOsERjvq9Bhj/V6Wby/TDJj4GLrPk
 lAT4XAqgR+dClMG7rc4G8gYCf2tZDwLTKZAm07eTy0YyZECK1EKTrEi9wTtszuP8cYXHorcT
 8d2kksUozsFNBEoFVBwBEADcwl6rGcXTWGROr7m3+vTU01gb8+pWMrnbWb5/O1kBH6ORvAqN
 xERHt2jE6M/rpPvuo4tEdP2R7t+zo11xaPqCnEUq7RBr9odppUoCgGkfAjA8CjsNLpLmQTi4
 yA3miZSq3zEZZ9m7X1JzAjgoSPblH7rcAd/R7ETpeoo7tS55pJ2h6GDFvmrpGUQn5uF+sDxt
 ZMDXByQM+pluIFKuiCIYR4vhmsTjDgeAQYyEfX9VpkTnVDkk+k8v0CaPiiqWuXUOT4y+cIPb
 rLxCpimZPDxSSSPh3yPChMsCe1CEYwnfJwh5/4KhQED7+qc9/1ifb9BzM+qHfM34dCvxuFz4
 h61qz2hU7Cv4fO9VWyYIvxURd+vpPNFlIBFdENka+y7877AIA8tINGFYl8XDBWPJYpKsyllW
 nRvJ/17ReqQBU65H8MXAl/R2/V/ipRLEqAy4zFWBhzC57MFSaJYKkbjz5s8UGHSy7I/XXXR4
 rk0QhQdV+SWlX22sZSSx1zE960YVVJCfrOGQdv1/Aym/vyAhXVwGbia50Kb0JX8R17DnrxCY
 tKIgAvY6CgX9mn6Hbf23yXkHAZUQFUTsydn9MaDplYEFOhQmBC/wb3Z8Vd7RxkzYYXwrIx3K
 1wMMrqd26+pWnVdwjei9iM2mi+M0PeKzUUzvDkXyeGRQ3+gb4fp7Lx2lXwARAQABwsFfBBgB
 CAAJBQJKBVQcAhsMAAoJELqceAYd3Yyb5+wQAIDlMuRQq+nU31hqFUH8hpqGfqGz7su91pc+
 pveLXe0CP9S/f/mk4l54Z3p7w52aOTnwcnMj2Ji21HCFUzS8ht2Ro0G3Pm+HgLOmV6S2s5nu
 9nYP0E4uCOQmZZgzFsXoSd3+C1dasdAuu9TOSxyjMe3iiRUcPdsBus5qXyXMlXZvJDr9XxmO
 mwnTClgvrFfP3XFpglauiS8OIwAX5j5EA/AYd3L2mGb7bicp+8k8Cezq/0y0tDNk3H66Mdic
 Pj5XA+4Bpnw8Y77w3Z+6WuRaA8uHJYZqgSLV5vPa/by8skHXCvMbqGJnAIoDqAwSPSzWQyAO
 npPJH/4JHslYz6UrTCdWGTyThOqngMetQJLEbP9QAHjHPUqeDJALuilW9btUs0IlPglNSP9Y
 s5n64ucsED9ru4CJDCyzR6FL8xSP4I+VAnxvqoqj/WQaHBG9/ZX3nXusOnFOzRrlWc6xJPdL
 HRNoVUxf1lFq/0574bNKvR85Klmi61rrTUfK+uuGttoIg0degb2QXAMHt4Mp4KDhAaRtllEs
 DsAndmS4Q/dM/5FRuZ/zVtOTPhRBNe5II9rwQ7PDCaB2PHBqsikn9Pj6AsW6LsLvx9oqiaXf
 gKHRzbaJPx5rR/qRP4vThReKkSyADebR0vAFf2xKb39wmXgRkHaYw3Zpql5vnz0OxYO61Cy0

--------------XRQ0Bd1jdrfivVeSnm0g05iG
Content-Type: multipart/mixed; boundary="------------KHPIB04DVjfn3yUmiod5XUte"

--------------KHPIB04DVjfn3yUmiod5XUte
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI0LzUvMTAgMjM6MDEsIFNoZW5neXUgUXUg5YaZ6YGTOg0KPiBCdHcgSSBk
aWRuJ3QgaGF2ZSBhIGNvZGUgcGF0aCB0byBwYXNzIHRoZSBNQUMgYWRkcmVzcyB0byBrZXJu
ZWwuIFNvIGRvZXMgDQpUeXBvLCBoYXZlLT5maW5kDQo+IGl0IGFjdHVhbGx5IGV4aXN0Pw0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBTaGVuZ3l1DQo=
--------------KHPIB04DVjfn3yUmiod5XUte
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------KHPIB04DVjfn3yUmiod5XUte--

--------------XRQ0Bd1jdrfivVeSnm0g05iG--

--------------yVap0lOFVM10rq4Jf6pV5HuA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmY+N3oFAwAAAAAACgkQX75KBAfJsRlw
/Q//Rbh96+Nu+IltIBLJpNz+jTG8XNJWrzY6AowwjCdSGBC+YHGf03wkpMj5qmc/GNb+GFpPD8H2
QX3L8jeaVCBpdpFZXj/NYF9HmBmkS2D569CK8eRnV4Ga7MbpauSttN7slYXYIfIi4hbG4/dsmghz
+VMtYYWLQB23EAd8pYs9+NGD8z6oZX4xVNQCXsyPXuKJyDsGe6PJrG1EeqZhAuselcvIGmg+qGIl
zkotVIUhReyvwQF+/auUwNPxYP44z3b0C/Z1/KIEv+Pv04VZ+g1aoLuRMuUTDWW31+L7zPEEKymG
ylni+xA24Xauw8QS33DVCIjfCnblz9Kl75Uuu/VlacQMaB0J5sbakLCN9FrM1bcvyT53Kweeb1b6
ov0xPDU9gbDYDUiv3cFMFuxTPOJzb+sE/RelNatx0GXpuQcygvINGh9AvvOyGLr0qqW/EB8lqlu0
ah9KnXZxlK90u6NTGFi3cnipa4isxSa8DNlVwE5I5aAoahrWCBcef/SYiHgQNZ8AC6r/JQSfYB/x
DRrU6ycM3PkOTu/jMXbKRWyAPkKroZtJUq1dUrYgLmtr5WgLw9gNO+RUDOyckhCF3l3hg5Uk/8ls
/qa/wPx2hcUCghF57tY9PX4QayI+XRSo0CK/bjLV7U1UdlnFYF+vLhk223MlcB6ScRIZ9UhNtwXO
/V4=
=P/2w
-----END PGP SIGNATURE-----

--------------yVap0lOFVM10rq4Jf6pV5HuA--
