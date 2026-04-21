Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA5AF8925D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 11:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2578883BC4;
	Tue, 21 Apr 2026 13:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PU24tPZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAA583FFA; Tue, 21 Apr 2026 13:06:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F2180433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ8wbIw2WFPVk8mh1pYmgDZrPUFYUgspSvDX2rQqvfCrbTsZpIwF+Sd1ZWVSxZYCRFNfg9VgSRdL6ikOBRMe2+Ziim1kEL2UsL69wkyc7cz/SqZvQnKfIWvvT09ljsXrr0pfSAHHR6rZeOQpoR6AbI9dpQZagU/uYXTl1h2d6iCHr3139VIoS4MBG40TeG0/3oEgM6UXreCmbr1csM3FgY5pQqbTmekxkZT1jvyDSVJkfqDpkkd+czOZvoXa/JIRoPSviHI+mOBKTVYM0HK5jFYLSPTrpHqhBB5qeMH9/1dEnDV0eij3MLWaq/M5LrtBtyfmQBQodx9iBjcQeuS4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCEtK2mcewaOn2VgrlIsLwcOJ6aLXygK40enxvKrqmI=;
 b=brKTkuef4qnd+nBv2GngmX+RV+oyd+GoUq3CCtGxOQzmzKJQueoJZTz9d6CCgGrQPgn2C5cKMOo7m+YF7dF27BtNtHrKbWvmJljmcWLkb9xKPNsF6OpEx9D9MS7X4UXKHMyXIK0XUF/Cxem5J4Hy5FKGZAos95eqr3GmK4EtsNlHCIwjFnLZSlQ413eSrdMFu6o5ovBMrM/dOOngmuvxw/7hKDYl4hMXdq35xr1EzKI3wlaBIhBOjvNfEOUTg3F2+lvdK1vsJtumur2MJmRbiyznEpBOgdsSInyC4SFnCXnHZTyf28QhvQz+NWB0Y9j5BHtk5Qt/+qOzLC2zNruH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCEtK2mcewaOn2VgrlIsLwcOJ6aLXygK40enxvKrqmI=;
 b=PU24tPZ7BpOTqqbxR4F7a4+huFNXKJ7IEBfcj4MCLDD0Q6V+wWbPQTqQAH32Zuucj54x51Mz4oYj579bAzkBV6etucNq2IOlwbdX6RtQKWL2IEII4Di9cbjwulPnb6Xh/AveBAhXUw9phQ4zKXDr9CBzZsM0HPQT8DkJJ9y3eGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB12289.eurprd04.prod.outlook.com (2603:10a6:150:30f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Tue, 21 Apr
 2026 11:06:50 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 11:06:50 +0000
Message-ID: <3462e9ac-e882-4145-88d2-a553cd1c3cb2@cherry.de>
Date: Tue, 21 Apr 2026 13:06:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [0/6] net: migrate NO_NET out of the networking stack choice
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: u-boot@lists.denx.de
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <CAFLszTjTSUOy9=d5NpgsP63dQp7UXuhpqg4wFwnXgWJzD74_6w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjTSUOy9=d5NpgsP63dQp7UXuhpqg4wFwnXgWJzD74_6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0066.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB12289:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9890c4-6e71-4ff4-6ed3-08de9f961651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W2NQqX7h+RtFUGahf02Ir80JYbz4KyupovUO8cpaxxJ9UNx+n1K1QTUDsu9QZkALeTZh1QmhaVlO3Rkm/4rRLXQlrDTbnh+SopKeExjvn90JHZuw8CjWlV2QlPQHRRJxcKWXk0WULT5VokWA9ibf9yaFWuAmFdYiBKgPJspnY03ANSSf9e7AEinP3pzjKKBvpnG9uG2JQe6XbGMitw8fM2dGLBSCXILt3wOG3+qXsXz1yXRo39fDrZDh5Ha6GOB/2uQy8o0h1xthLPbLycJu081qLopkRmvmx2+qG5ghKl9ik5qS18cLI11uUnNMxC+AG17/giifWphwFPUY3VDyV6QNnSgedDvErO7QJPIOczvLzhEhPMFIVAwY5zIhSLfdEniN+0DMIp6VLbJIPYMKeLmBj5lcdUSC21is4GwFrkGifu3fgW1tYMuMXoLMVPH+LFLwzPY/7l42rQLYP8Yqt3GDj/4Iknc+NmjrqMdZ6hXCXtPZAKnvrunJM3ovjfw1XQtA1E56gyMmN6YdIt1oZ778eEhJ2SIogP3yaQ6tFePsYvtp7UxjcapJvyTuTmB9wm61g89ApE9KAlgIFjimdUtroNVtyuCOmDCCv5RUfx58cvTErijFy5a12kbgwdd3WXtjnIbZ7gupQ7nxlzQQ5ocEoAKvV01oMNK1LNlxbhxJYBNidRIEry19lL7IGgvV0PgQ3bZxPH1OVbrgdZU/6PRYCjtheQ9DF7aFzIp0ChA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRmTUNhM0t6b1lOZUh0akQwNHVGOWcwdmtOZHY4eXdPY3c0YmpRZzBjRzI5?=
 =?utf-8?B?WTRyL01sNHNvTm9HenFsZWxlemtYZlZMZENiQkJnUnRrSWEyQ0pVRU1NVzE0?=
 =?utf-8?B?MVN2UlZ3NkZvT1NEQzhYR0FUaUw1Mnp3N0dxSllnNkd2dGN5RVdiZU94aFdD?=
 =?utf-8?B?elNPallJa2hTc3hqRFdKVXM0ZTM1WjhtSUo5ZkNzd21XazdkYjFvNTZXeDBE?=
 =?utf-8?B?UmV5K1A3RlpHV3BiUFJncXFwSXFsQk1paFE0VU4xeTNyazErNUVrYVBNcHhr?=
 =?utf-8?B?ZWpldDVoK1BETXRWWExLMHpGczM2RThiaUpzSjBwSytWbkR3WkduaTYwVkJu?=
 =?utf-8?B?VSs2ZldDcGVGS0RaYTNaSWlPSzgxQTZTWDJyZ2JXdTJDeGZjQXBZZ1FsZkl1?=
 =?utf-8?B?TFFPWDNRSUN6cVRoY3NmQTdlMHd0RmlPUzdwMGVuZm9YSHBwQS9qWDdxZUs0?=
 =?utf-8?B?NlgwNEhmbzhLdUdFNC8xWXBRT2xCdVc2cnNSQmEvY204RUlJYnkxRjd6TTNH?=
 =?utf-8?B?Z0s1MmpFWkxhc3djenlSaE82a2VjWmZQRnlUU1VLVDBrM2ZxdjYyWk9Hd01H?=
 =?utf-8?B?bG1ySEYzeU1SNXAyRlRNcFJFT0g5ekRXdFAydWN2SnNRYXRRekJnUFZXdDgz?=
 =?utf-8?B?YUZrTy9QbTNxeXBOcGVURlpiY3ozYmx4WGRPeFlIZEUySjFaMlBpSGlSTWYz?=
 =?utf-8?B?Q3pzamNQTmwrUTRIVWxUaE1VdUpZaDB6SkZ6TGVaWS96RW45TEE2S0lSVDJU?=
 =?utf-8?B?MWtKbkFoZTR5dG5JWXdnZHdZSlFxekNTSjZYSzlJcXZ1L0tEVzQ3T0ZPdlZl?=
 =?utf-8?B?VXAxdFVOSVI1V1RqVWhTaUFqd2NackVFaE9YZXpYWGp3clh2SmJDeG1GSkVa?=
 =?utf-8?B?cTBJMXhyMTk0Qk5VZm5PanFNWi9iYWNqamE4c0xSWDBZaWhTcU44RGVJcDVC?=
 =?utf-8?B?S1U2Smo5azVIY0lMZTY3T0VkdzdqOFExcUhnN0ZpaEhTWVV1WUJVQUFEeno1?=
 =?utf-8?B?czZxcVdRL1IxbFZtbnZaV1hBRS9RQ1dEcFM0aUNXelVaei96MExUUVNJR3pa?=
 =?utf-8?B?bFVYUklnbVJrdUV1TVI2UW0wc3ZLYi9TcnVKWUgwQVFOS0dzNllTMkxOVUM3?=
 =?utf-8?B?dHMrTVZmY0pMUmx6d2lPQ2pZb0xFZHNNc1I3Yk15V0ExRDlQN1hVblJWcnh5?=
 =?utf-8?B?cHVZZ21yRUVJcGpMN1I2TjRzSXJuRDQ1bStHc1NScUNqenZINVl2UGtybjZv?=
 =?utf-8?B?cmFrcWRSUDZrT0w3dUdKVExmRzNBMnA0R21XUTJUdWN3ZEpud3hYUlloN3Y3?=
 =?utf-8?B?bjVFcDZER2NyaXc4cW9PbUdqVXRKVTNiWFRlU1VGbzFoeUZZUFRNVXJQNGdj?=
 =?utf-8?B?WUJ2dExjVVJCUlo3Nlc2aGc4U3NtSkpxbXl0d1VIa0F6SGpUc1pDWGVjQ2NG?=
 =?utf-8?B?MDJrb3c1MFRwNnZrWElUcWpjZDdHbTBQYVJLL0lySFhSMFFJbkNvMWM5Ukwx?=
 =?utf-8?B?RklOM2FlMEFqUXhXMGpmQTVrUTVnU2F1OUxlUGlsM2FMbExUUi90MUFiV2VS?=
 =?utf-8?B?VUl1UWJKWWZUa2RYU0twa1gyaGVvRzBFNzlnczFLN3NJdmdTNVVIYjVXZHA1?=
 =?utf-8?B?aDMyN1ZKUm01ajFiSmJma2tZNmo4YlhTM21LWWttc0h1Q04rVHV1c1d1ckhN?=
 =?utf-8?B?aS9va2lUc29jcnNZWUUyUDR1OTRpRG5INy96bUFKNy80NmxPVDF1VlVnMmpX?=
 =?utf-8?B?bEVzenJnZzZvRlRWQkxNaVY3TlR4ZnlZYTZ5VGhFdDlpYjl0ektYUkEzckJB?=
 =?utf-8?B?T0tJVzROUnZpZkNsWGIvNVg3QnJxOGluc3A0U0toU0lXSDY2QVZKSXNCU1ZI?=
 =?utf-8?B?ejdBeU9Pek9WNzVBMnJVOW1YdkRXVVdSUWNkS0NxaUM5MmYrMDlFeElDMEpC?=
 =?utf-8?B?aUluTkZ1Uk02aitwcjNIamdsUEZUdURJS2VmUmlyU0F6OVd2NlF4ZksrV21s?=
 =?utf-8?B?RnBmclR3RlRVcUVzUnpRSGZUQ1VwRnhCZE5XVDl4aFVIRTlLU0Z3WHEzS1Nh?=
 =?utf-8?B?UWRGcFBVcmFDRGN1SUI5akxFMTMvUHZVSGNHeTdKWFozYXZrWVpzM0M0UTZL?=
 =?utf-8?B?b0N3dCtNc3dWdEdqTGVjNkFRVWR6TGNReURXRTVlZ0xRNG9pRUM2a2lWS0to?=
 =?utf-8?B?VWFiSnZPdG9ENUJxYStjdkdhMFJ1TDROZkJ1M2d2ckhhK0EvVy9mZ3dXdTg4?=
 =?utf-8?B?QXJpTncwTVZZV0xOK29sSHcvMWc2cGY0MFV4Z05OZjZzdTh1c0xCWjA2UEIr?=
 =?utf-8?B?b1I1MSsvV2p3YmE5dXE0NUgwQzRGUDM1SEJ1ek96OHFXZ25wMS9ta1haZ1V0?=
 =?utf-8?Q?21IN9JWcD/7PRZMy/VQftQ643wagaXeXsli/v?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9890c4-6e71-4ff4-6ed3-08de9f961651
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:06:50.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D56BCWJveLHSI85YpPGx8pXC7YRyhrWgieErAh7v5/GONNWOrOooo+/HXNCPIZJTPCuIfS2/S0XfQWKJ7dCR1RPO80T6vVX8Gk6PbzymH1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12289
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

Hi Simon,

On 4/20/26 9:51 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> 
>> This series introduces a new NET umbrella symbol with NET_LEGACY and NET_LWIP underneath.
> 
> Thanks for this cleanup!
> 
> Re SYS_RX_ETH_BUFFER, how about moving the extern for net_rx_packets[]
> to net-legacy.h ? (is it used with lwip?)
> 

That's not the only thing making use of SYS_RX_ETH_BUFFER.

- drivers/net/fsl_enetc.h uses it as value for ENETC_BD_CNT which is 
used in drivers/net/fsl_enetc.c,
- drivers/net/rtl8169.c uses it (if defined, otherwise defaults to 4) to 
create a static buffer, see NUM_RX_DESC,
- include/net-common.h sets PKTBUFSRX to it, this in turn is used in 
*many* places, including many network (assumed Ethernet controller) 
drivers, net/lwip/net-lwip.c, net/net-common.c (with net_rx_packets 
array, used all over the place), net/net.c, and net/tcp.c.

So seems to be used for both NET_LEGACY and NET_LWIP.

Simply guarding the "#include <net-common.h>" with 
CONFIG_IS_ENABLED(NET) won't do as many files currently expect some 
functions/macros/constants from that header to be defined.

Another option is to ifdef PKTBUFSRX contant and net_rx_packets array in 
include/net-common.h. But it's used in arch/sandbox/include/asm/eth.h 
and drivers/dma/ti/k3-udma.c which aren't clearly dpeending on NET being 
set. All defconfigs enabling CONFIG_TI_K3_NAVSS_UDMA do not modify the 
default CONFIG_SYS_RX_ETH_BUFFER which is 4 (according to 
./tools/qconfig.py -l -f CONFIG_TI_K3_NAVSS_UDMA 
'~CONFIG_SYS_RX_ETH_BUFFER=4') so it should be fine for this driver not 
to have PKTBUFSRX defined (as UDMA_RX_DESC_NUM will then default to 4). 
According to ./tools/qconfig.py -l -f CONFIG_SANDBOX CONFIG_NO_NET, all 
sandbox defconfigs have network enabled so maybe 
arch/sandbox/include/asm/eth.h is not an issue either (or rather, for 
later :) ).

With

diff --git a/include/net-common.h b/include/net-common.h
index 69b6316c1ec..0c260873c2c 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -20,7 +20,9 @@
   *	alignment in memory.
   *
   */
+#if CONFIG_IS_ENABLED(NET)
  #define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
+#endif
  #define PKTALIGN	ARCH_DMA_MINALIGN

  /* IPv4 addresses are always 32 bits in size */
@@ -132,7 +134,9 @@ static inline void net_set_state(enum net_loop_state 
state)
  }

  extern int		net_restart_wrap;	/* Tried all network devices */
+#if CONFIG_IS_ENABLED(NET)
  extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
+#endif
  extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast 
address */
  extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
  /* Indicates whether the pxe path prefix / config file was specified 
in dhcp option */
diff --git a/net/Kconfig b/net/Kconfig
index e712a0dd2ac..deab340f26b 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -279,8 +279,6 @@ config TFTP_BLOCKSIZE
  	  almost-MTU block sizes.
  	  You can also activate CONFIG_IP_DEFRAG to set a larger block.

-endif   # if NET
-
  config SYS_RX_ETH_BUFFER
          int "Number of receive packet buffers"
          default 4
@@ -289,3 +287,6 @@ config SYS_RX_ETH_BUFFER
            controllers it is recommended to set this value to 8 or even 
higher,
            since all buffers can be full shortly after enabling the 
interface on
            high Ethernet traffic.
+
+endif   # if NET
+


And building sandbox_defconfig with CONFIG_NO_NET=y, the build finishes 
without any issue. So maybe that's the way forward? I think this would 
be better as a separate series though, what do you think?

Cheers,
Quentin
