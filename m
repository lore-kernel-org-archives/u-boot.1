Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838FFCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643F584873;
	Tue, 26 May 2026 15:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i6hYch0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1B4848A2; Tue, 26 May 2026 15:33:00 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472FF8486D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR0NmKG9dwlRkGPyU1avUXnaEvi4E/alDhvxvTBnCQDIWf+Aw/b/B0EdBSriUhqz/zkpxmaLuOcQY8N0Ss0eBwhK63Qj2Q6uEGPKS9BUicE/qax997m1Qn0fJ4KQwV5BznOxGE7OQTZX0pwV1TrGxMd3JXqwCQ02ygtlOksbxC6uQXu7VhEYT3uDL74hS27cXc/nHn2piWKg87KE3NsAz9LeZ5JcDrT7EZx50Mede/EbGZ+jOP9xX4MveHQEalLCNd0ETSLu2rROMfHdijZn+1TxqSakcTJ7f9TZf76XUpexfFH7riz24ecHU9E5B46W9hekd4hrak8iiV6zGX0qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBWALvx4TKFXWj6LH7g7H5mQ1AmG2TyDIjht0u8NPwA=;
 b=DfTHLQKmshH3qwq4m6lIFggG4YYQmvpKv4znr1kEccxtWPgWJSmWkO/At2F0678JsJgv7BPhdsLXUGYWVIhe9gZFbt1DS69MIjdWfD2pOmuhbWA8E1jD4+YcBc1Gmb0JwQ0WJmMVlYkR70RZLps0r+rwgBSIvIHRnBy/+/lrmjhAxQUm9eAYjElDQp0Lgkk2+YChIo2tZZApOvWjp4N4SwF0JQKlsGkdbOjarwapVAZv/7lX2sqlkMOy7HbDWYFvevqThaF/4+4AdjsXeU1hnYLIgyPjJ5xFWxpWHtukYtEBdQp6Rx6+Nq58Je70Fgw8omHhhNE0YdZgVnadaY/Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBWALvx4TKFXWj6LH7g7H5mQ1AmG2TyDIjht0u8NPwA=;
 b=i6hYch0tG+RWhaDf09G5ZJwv1kZWHWZ4/DODApMDPW8KX4SDPFGfTigorYVQ+k7+cEvSpES5HFDK3RzrHd1ily7Nm4A83BZOVH+c4pSRM3QEFD96BKMDD3TFoj9shAfdlh6hOKm/KNa7EKdWgUe/Ng2ScPgCrTLiTFqt7/8hQ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Tue, 26 May
 2026 13:32:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 13:32:52 +0000
Message-ID: <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
Date: Tue, 26 May 2026 15:32:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:802:16::28) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: f0605ba3-4a2b-46ee-6f90-08debb2b4956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|921020|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: KxFpOok/SqBN3T1VrYcyrOO4Vi0ZMtfcP3k2ZLqPjwYZLhQ8mzDopmlJvGPrTyDMXDzuBR3zYVeNj8fQhHjdS3j/SzGJ5FwsxO659EjD2i5iL7W3SeUQ078yHY84PBlf90upzmnE8Bqn6jzYsFS8B5c3LggXdU42TQ5p3+jG1ICsimtH0xfyjUSEply1RlCE9kTK7Yc9fvpFBlMVihTA1b707iDqIzg4Jg0/YaTCFjPaZfGlC0NVE7p6+/0NQqFtzmdvEj3g3nuq8xicjqLqxm4KVP5qH9XBxhoczYO/fvmfDheE+/DA7P3+GiMSP8Pm85Uf5D315yF44Y5fbJF4Yr0SyaNiL/YUvkOnR2MWY+4zcCYjtID3RmCGoN8V6dZ5FSeZpwez/V5cJXeRnAbvVzqp8ymNCwTEG3ttBPR9LUh/r+RfTth/aVg9uP5iVrqlayIYEPnLaDRfP+3+MNSey9LpM9K63T/s/jSA1KFEdqiM4A/4FOP2xf9miE+nxEnll58y2X1MeGoxlWJOtNSj1+m+/Mj7nBGwKiaZ/rhn315Uc+XWAlqWn8fL7f1zLSMcPNTQyvdAbJK8zJG0/RaerCNCZRhHfOb+GWT+qfjbssHKkHGSEttNa8qyFsGRGiu/f9ia9wHb5EtzPjwe7dCGa/MtilU4EZF7+0MdMsbdWLaR49UfhaJH/UEFZD904DC5vQbEIgKvb2MWNnjy7VUNFRFcaGu1+2daa/BE4HO7yj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020)(4143699003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZpMGEyNEY3TFk0eDdiUnZRYUllV1djNEtLenFMUE5yQUtiRE1vWEl1OW42?=
 =?utf-8?B?QXE0cVJCbk9vSjJ2bnF2ei9nRklkVytFeFhMcWxYYXl6WWJ0a3dpdElORFBt?=
 =?utf-8?B?L2EzSG1HMk0rVnZ4aytuOG83czFZNGpjOTByeHFKdmI1YUZrNE1obTluSUlB?=
 =?utf-8?B?WkRjbmRkb3BDOENpVzhwN2xaZlp2TkJhZGc0OFQ3aG9Va0hQcDJORElhZlpX?=
 =?utf-8?B?d21hUUw3R1VSa21LWFVqZFRxQXlwME1VUE8rZXNCWEh6NWtBOXZDdGZkQ2pQ?=
 =?utf-8?B?SkFpZ3BnQ0dVNHlwU3dWdFprckU4UFB1b0lCTTVtK0dZQkVxNXl6eEpyN01W?=
 =?utf-8?B?K05Td2JkQ0lFVWZlUHNGdjlZZUI5OGY5S29nTFRkbUtRN1lWWEFXQjZCQURm?=
 =?utf-8?B?ZEo0L0ZMN1JrU3NXVlp6dVlUYkNIS2VBcTVBREFKZlpPTXVTUmwvR3pzTzho?=
 =?utf-8?B?R3ZQRGRuWU56THp0Z1VieXE4RWRRZUozVXdZRWFIaFZDMzZNR2ttbUVqQWRs?=
 =?utf-8?B?U1p5Qk1leFA2NXhrWWxmVm51cS9WMjNhd2Jmbml5Tm5aczR0Yk9mbkNKQk5J?=
 =?utf-8?B?S0F6OXUwM040bW1hSEdnREpEMkRkUHNFeDNaNEZ6ZmtlV2g5SlhBTHhDVkdF?=
 =?utf-8?B?Wk9TZEJyK0ZNOFRsZFc4MEpxYkt2VHpGWjlkL0tPTXROSHNYdWIyMkhRWnZB?=
 =?utf-8?B?RXdoSmhkTjBjYW5pTlRjVy9JRURWTHM0T3pzN3JoR0pURGVNa0RodUpDL3Uz?=
 =?utf-8?B?SVNqc0k0LzF4Q0NpMC9vWXJacHZJajY2V01PdjRCQnpoZTdLbnhHbXJtOTBE?=
 =?utf-8?B?bHFvVVp5YWNnY0kyUnpvSExZa3dTclhVTHZ6Z3o2Wk03N0ZTTlQ5bTljWldJ?=
 =?utf-8?B?a1FMcnlLZ05JOHoxWHJsR0l4cnUwRU5SeVQwVi9zZG94Y3E2UmFjaXFjZlpK?=
 =?utf-8?B?SDZFUlhDMDBTMlFyUmFMQVlEcXhqVE9qajZPWmM3dGJRNFhtTzkyaTA2bmM2?=
 =?utf-8?B?b1o3Q0FOZnNlWXZLLzdWZzQ1d084dTBydkpadFprZGVCMDFoMW5KeHFZd1Jo?=
 =?utf-8?B?aVFFaGRUSEJ6TlNPRS9udTh0TVU4S0lYUmV2YXZMdExXQlZTRWduU0lxSmNu?=
 =?utf-8?B?b3VJNkRYR2x2NEJZN242dGpuWnVyODdkZ0p5RUQ4bEI4dnhDTkxHeFRWMW92?=
 =?utf-8?B?c0lFNFFNcEVUZmRiZmMyZHlHb0JrdC9ra3RMYzg2VGx0SGhWS2ZhVlZhVm1T?=
 =?utf-8?B?anltVTBWUGZ3ZVVhNEt4dmZXYk1PbWZ4S2g5ck84MkdTNUQwb1lkbGJadmJ4?=
 =?utf-8?B?RUdTUmtPdmFnMTAvVTEyanNGOExCKzZuMzMvTHZwODBNSGJNa05PVDBoQXRo?=
 =?utf-8?B?V2dFRkVOMUlzQUFlOEt6ZE4rTjdTcldnZHRPME4vc2JVQWRxQWo4WXZ5eUJV?=
 =?utf-8?B?KzA0WmthekxKVU85RXJsc1VFVTBJYmRIQ2l0ZHZZbVZ4eVhPUDBvSE1VKzNq?=
 =?utf-8?B?S1kweGV3dXlzb0V4N25RdVhFbGRNUlJOSDNBREJncjUrUnZUTTZUSU8rWGVV?=
 =?utf-8?B?RVYxREVqU3BTMlhMN0dZaXJzTzBreXN1TkFvSHl6YVQreGhObjB5M05PcTVP?=
 =?utf-8?B?OEIrdEZSeDhFNjBWOEtraEYyVXh1c2NrYVcwTWRPcUZNZE40ODlOdWY1Zk9L?=
 =?utf-8?B?QXJva2lpRnp4blRocU5qb0xvdFc1a1VXS0V5MnRTTTVKSDYzMUtKRTEzazhZ?=
 =?utf-8?B?VkFTZVdGbnRrQUt1RWthRUg2UzFpRGcyK29MVk1OSHNCWW9sSEFNaG9NTk1V?=
 =?utf-8?B?SDZPckRkQnY4NHpPOVl6aHcwV3lCQkwycVhDWnhEWmk0R1BmWG5TL01SMHRY?=
 =?utf-8?B?clZTZlM0Wm15U3RWclRBSkJBcUFTRVhVSnJmYXlIVlFOQjZ3QXJOeE1UbE5q?=
 =?utf-8?B?bTZ6dUd3UVh2WGliN1d5eUZRbWsrNkMvRy9kdjd6MzJ5OVRRSjNvY3c4OGhJ?=
 =?utf-8?B?MTAzRlVLMENhblBRbXBXSDlwa0grUGxwU1Eyb3ZXamNpWVM1U3lhQUVwdVVw?=
 =?utf-8?B?WVJmeTJsTU9zekhSRkkvWTF2Qml0MHI1Nk0zQU9Jem5NeE80YS9KQ29WOVZQ?=
 =?utf-8?B?UE56WXpPTFgvN3hLQ3ZwN1h4VFl6NHN1a1NJY0ZWcFJwTEFCTFhIMUhNRG1m?=
 =?utf-8?B?R2ZrS3dwYWM5R1FubU1oR0pocGZ2aitScXNyeEFuSFNVNkhTSktUOVI4OFBp?=
 =?utf-8?B?NjJ1M2dlSG1qU29XUG8yN0ZMRnY4MFFSRG5FZG4rODhPQ0NIbkNSYm5VNE5w?=
 =?utf-8?B?OXU3V213cnJlS3VIdmpQMDhRM0RKUklESmpPcFM3MkFvQ1J5TzZXQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f0605ba3-4a2b-46ee-6f90-08debb2b4956
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:32:52.3467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0l/5/0s5Y00+S/wH/l537/eAJ/UGJd1NE3gIeruc0DXtWIaiEwD1DYCex1clgN2StYFDnoh3oMnnSiRz5nc3lpIJxzN0Ps/fHELlKFGoTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278
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

Hi Varadarajan, Casey,

On 1/21/26 7:39 AM, Varadarajan Narayanan wrote:
> Implement request_arg() sysreset_op for QCOM SoCs that use
> PSCI to reset to EDL (Emergency Download) mode.
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
>        issuing it
> 
> v3: * Move argument handling to a separate function and pass the
>        arguments to the actual handler to process
>      * Drop Qcom specific SYSRESET_EDL from the common enum
> 
> v2: * Update commit message
>      * Elaborate Kconfig help text
>      * Use '-edl' instead of 'edl' for consistency with other arguments of reset
>        command
>      * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
>      * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
> ---
>   drivers/firmware/psci.c               |  4 +++
>   drivers/sysreset/Kconfig              |  6 ++++
>   drivers/sysreset/Makefile             |  1 +
>   drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
>   4 files changed, 56 insertions(+)
>   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..b6838a244d2 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
>   					 NULL);
>   		if (ret)
>   			pr_debug("PSCI System Reset was not bound.\n");
> +		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
> +		    device_bind_driver(dev, "qcom_psci-sysreset",
> +				       "qcom_psci-sysreset", NULL))
> +			pr_debug("QCOM PSCI System Reset was not bound.\n");
>   	}
>   
>   	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 6fb0ca81dc6..905ad2a7769 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -301,6 +301,12 @@ config SYSRESET_RAA215300
>   	help
>   	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>   
> +config SYSRESET_QCOM_PSCI
> +	bool "Support reset to EDL for Qualcomm SoCs via PSCI"
> +	help
> +	  Add support for the reset to EDL (Emergency Download) on Qualcomm
> +	  SoCs via PSCI.
> +
>   config SYSRESET_QCOM_PSHOLD
>   	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>   	help
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index f5c78b25896..8bb1eabd48e 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>   obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>   obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>   obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>   obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>   obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> new file mode 100644
> index 00000000000..3627bbf5c82
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qcom-psci.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/system.h>
> +#include <linux/errno.h>
> +#include <linux/psci.h>
> +#include <asm/psci.h>
> +
> +static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
> +					  char * const argv[])
> +{
> +	if (!strncasecmp(argv[1], "-edl", 4)) {
> +		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
> +		if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
> +							ARM_PSCI_RET_SUCCESS) {
> +			psci_system_reset2(0, 1);
> +			return -EINPROGRESS;
> +		}
> +		printf("PSCI SYSTEM_RESET2 not supported\n");
> +	}
> +
> +	return -EPROTONOSUPPORT;

I think this is a logic bug.

For reference, what calls this function:

   int sysreset_walk_arg(int argc, char * const argv[])
   {
           struct udevice *dev;
           int ret = -ENOSYS;

           while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
                   for (uclass_first_device(UCLASS_SYSRESET, &dev);
                        dev;
                        uclass_next_device(&dev)) {
                           ret = sysreset_request_arg(dev, argc, argv);
                           if (ret == -EINPROGRESS || ret == 
-EPROTONOSUPPORT)
                                   break;
                   }
           }

           return ret;
   }

The issue is that the first sysreset device implementing the request_arg 
callback will consume the args and return EPROTONOSUPPORT which will 
stop the loop.

Think about multiple sysreset devices, and let's say we have a new 
'-dummy' argument to the reset CLI command, then it'll depend on the 
registration order of the sysreset driver whether the dummy argument 
will be handled by the qcom driver which will return -
EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.

I think we should have a fourth possible return code which is "I don't 
know how to handle this argument", e.g. à-la IRQ_NONE in Linux kernel 
for interrupts that aren't for the device this IRQ handler was triggered 
for. Or maybe we should really be using -EPROTONOSUPPORT for that 
meaning and not exit the loop if that's the return code?

Or maybe I misread or misunderstood the code?

Cheers,
Quentin
