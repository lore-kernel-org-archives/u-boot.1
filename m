Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0976C5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 08:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9909780AEC;
	Tue, 25 Aug 2026 08:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dY2fy9NiUNhC; Tue, 25 Aug 2026 08:03:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787645037;
	bh=W7RGQZ9/PudYubp60frCH3koXKh5zDGRSbnLAGukIos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uTEk9TRfAGq37VYTYj2JjvUhBJ2qVEFgelPz9nO9kUvOZfxIqAOHkRPB4yQi0zni6
	 Rd9xFTYtArOYVNnfzdKRSeSDX9YmROFLefqzKuF9AZ4UPZJNY6gUpdB57w0mH/af8Q
	 SI0qF2JpAvC+03uqNQbhboXHFANKyql+8za7zUuRQSJdBAkCOSLX12EYYxZiSfXDtP
	 wOOFhBdStIZy8snKGfnhoevVwkDxnyEirBPspl7S/GIyMxHvUya7L6xdpWZEDeLR/M
	 Na8W3K9bJqdvEm32c72WJw7dxZxijXf2RQh3wb5SByAt4sZFzv4AVTHqWo1WVAGYIx
	 gp0Dp81FGqXiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CFB880ADE;
	Tue, 25 Aug 2026 08:03:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3444D1EB4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA57A6068D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id is8pTgHIDgSo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 08:03:55 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=cl3fmjlO
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AFD660618
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBWZPprtAc+v7ZL3E3ql3s6q5ozByJFwDBW8LpA4kzAQ3hs5OKBpbjTGesC2RdvYkeBfc27flF6u3fRiEDJW6EiL6oHR8DQCrHRy12DDV+j4Ul/tyb2UpMMGF4PqzauXI/d/2OfkU7qJcbiF9YnMB+z2386CJmMA7KGPARh7R6Phz+0slufD7wlDNBl2SiyxcMYm0X67UQXR9FQt9eqz0+4MPBYFkHh/ZpBPqswF0Hab+Jj2+P12dw689klkvqJkcWR7TPlh3gdk9O6PhQh4BVJUvMB0aSwqelAF8k9f/yxVDoAqO7fv1f+LPH8ideM3LVHwOhtmZcUnBqkZziCKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7RGQZ9/PudYubp60frCH3koXKh5zDGRSbnLAGukIos=;
 b=luPxlP+EcqYkPvg2nOKusWoXZhAP8JMne2S3rWfq25U7VuQlW8ujVjlHBiYh71wxCSAPI96DN7cuLOcFEb62eIopLK3MzqbmSbbKNCv3FdX3HcPKTL8fWN+h5BIOaZS6le4F7o8qKhS/Ip9N0FlnurdEoYU5KeVn9fdIz91RJRnOOQNb96UVpvWDcyHxQcwAtK9xyl86uqQZ9ynl68x+rKOJeOIDZY7X3EjH1q7VSTopKTyq+GHKJOT0AECDumKWmp2WTNSHAxYYHUmv33xmtUb+MZHzybk3fAz8miq3KZ417O36p3OqF0tPN7uiSDPknOzfngShk5BpJvvJXIinPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7RGQZ9/PudYubp60frCH3koXKh5zDGRSbnLAGukIos=;
 b=cl3fmjlOO1AZ19hhTxnNJMzI0pBuJbvBGNmvL2uqHdq2WzWgn97I87JUVEiqayP95XooYklOgb/xlquPlpdCSKmkkWdD3Chj1QXNEDVhwmOAAzjTlGCKuJOsXPbEx854w/uPZn21DZ15Sc8+T/eHNUuUuwzu74UOYLy/y8FqqDLMpl05pR/HU5f6H0BA5sVKnq1NJLdWkJ669IZi98/HNgMjLgIBlgpvdgdRQQMYe/o0TepUEG+wL71qeWRNXSpT3H4TVSh65rMgRal8onjLu8euYnHW1iL/OSux8fyUsMxrJHtvjuReLu5yhQNnoxhZsbeIbBbBg4WnmW49HvAOXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 08:03:49 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:03:48 +0000
Date: Tue, 25 Aug 2026 16:01:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/6] common: kconfig: raise SYS_CBSIZE default to 1024
 for FSL_LSCH2/LSCH3
Message-ID: <ao1L1_1E_UAufqWa@nxa18884-linux-1.ap.freescale.net>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
 <20260824122825.95712-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824122825.95712-6-vladimir.oltean@nxp.com>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0316d667-6979-4e48-fc7a-08df027f64e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|19092799006|22082099003|18002099003|11063799006|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: CX59Lu0po+U6+NGh1ZFp621zmJXxunNsTEngaN3owJx8d1t2tuQ6QDDl31dZDlqnKUINpZ5cXxpx0YvkLwP0mQQ67XhpQ9/gCYdnVMj1YwIZ43SB0Vr6Icfh15ek8lGYGU/ZSkrUvem86h6oLQUhPmAlJzlTFIWwM7dL1FFQaHLCX4snenKxukZZG+mmWxx9b3UeObG8lx/0dwSvUWFcRswCuRU8NdJYoPHzi0yGc3QOgNZpGzu6t1WYOAa6+wGD8bsmdIYoCVVHLXLu6MWMaklJfMFBA/jTMhJJaKt8MsquGw4j4ptfULWEo96DwngbDquUbMQXmqR7fG6u///ow3HLWriSy2tBHAUQmJZzS1eFVp1Vv+N5/dTQPAoc6x+q92Z9Xr0Tp6NuLX7vt9+uJnX66fcK/fTivXn2INCjsKKPZCC8OlHJ23iAF+hcg2UQdeAJcXvLz1ZVzjadSOOUsfhAP/nYceaNVcjEebFt7iup8BYhv5e5P6ZMefYCqTmnRoGPFoWpV1aqK5cyS8RrzhfQx48+jxyCQWLJufRmVDVMJtKaqfXTxWaR7Z5zxqOFU8WP2rxMxWf7mit0a3aauaZt5tbS0yiSdDOQIzqd04Eq8+t9Nfj5KV1DXfcn+h3aylf91lJZQPqhKDBPUO0o1Lfw8K+m7RhfsyXfdz4oVZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IPJZ/LCyKY/ciMQ1QMs9anQ08neKF02vZtYYQpzdWIrD3MD2iNb4QWxMvY0T?=
 =?us-ascii?Q?voVGXZxJ56C+/Cz5fYiA0TQg830gfmVjfg0DYtnsAcF6K1d2jzWUwljYDjUW?=
 =?us-ascii?Q?53Y8DvloxSGerTZTwXfTThf+5yBhVjrZStruT2wPbAemEGEtrf68I1yvo7kJ?=
 =?us-ascii?Q?5SMbXArF0nJZDDDMdn3nsZ8ttPeurlXLgrO8m4LemJ0b53/MFdfIJYaB2sqF?=
 =?us-ascii?Q?xhdUpmI4N7qxXVgIRoMsevQWvjpm+CZfpMgX9J/fszpONcSmkL3lrxE2xxZL?=
 =?us-ascii?Q?b56BFtD9dKyhPW+9yVDocDBk+jLBfC+/Y53RfCrv9GJ0hsHkfEEEDXab0XEP?=
 =?us-ascii?Q?B4uwslg4XXOMFIL/2qAWaMce1zDdrDYCfzng6aiS9mnby55z/iiunCKfi/2n?=
 =?us-ascii?Q?T5XxU157HFKsNXUbNZuEPKBWvQZZnEdOeY1ERtql1aD7HnQtKk28yPWVD804?=
 =?us-ascii?Q?2xm62v2M0cRzvLPLScKkpUGTt+6Nyt8ZWfqf9SgwI9YmYA+ROcAksjl/8VTn?=
 =?us-ascii?Q?KVpTHy2+5Zc/NAQSZ2Sj2ksn10myqjTne8mpVzJGtrRFRaDOQffdhcrqAapZ?=
 =?us-ascii?Q?a6n1N8CeHTAY3bnNAbnhuZ53mgRC+wYOSBOrabHX/21sEY341TiQxw1+9kTB?=
 =?us-ascii?Q?i5YqWopxRybU5DeZgClp19sX7sZlUZYSr0AN6CTlHwb5w//SjUWrlGbDPBeP?=
 =?us-ascii?Q?2FuDLv6j6Wb7iq/DG3so4uZTPtKvV1q1ri44wfEfuMp/jKuGtFhsNHeMocCb?=
 =?us-ascii?Q?p40r1msq0GTNGGxQ8lXRLbMiOLOwI6t0RKzxz0Ux7LEI4wzno91XM1e5n6b2?=
 =?us-ascii?Q?9nvm0cQXkrJeL1rceYboCdbDxBQHNjzI+yLOXNEVRo0jT+ACKFxHv97jCF+i?=
 =?us-ascii?Q?TrxICBTgPeHEsErQrDRqAAHVsyZkEzTu/N8+USp9F3yywbwIhIhxSiVxoiFu?=
 =?us-ascii?Q?CaWzQsBpkFpVHpOFJNmti/8820UNwtyViyHezvkd33u0/rVs5Sg20icaJg3M?=
 =?us-ascii?Q?kpXCX2mfS+W6gT7UoWeKOB9K03TBklWlgOgJMeQLgyVRpVXqTiHaAj8FohNF?=
 =?us-ascii?Q?dHRSUPV4TN/LpSgrFlrThw7QGiEku1DqeD0nIrdAXIZdSIEzkM/QLOB1Ge8W?=
 =?us-ascii?Q?WomlznxiEAEMRFoGh2G00smw2HW3z50Ykm/hrRL5KD8N5RGNqpH1RkJaowSw?=
 =?us-ascii?Q?7haRoNWpaG+dN1Fjzpo7WuC7MaCRy+PSlkeQ8/R2RxZlCuu37qQqVgbrZXIC?=
 =?us-ascii?Q?xPfLRdQ2jwlUCBspaiCYUorPRzVfH4tmcgLJKJZNM9eaPL4FMfv9fYI/oBcN?=
 =?us-ascii?Q?kWr7DTpvjZ/qYiWan98wR7N1ou2XbUwF9V7MjIHGtW7lhRav03fEwoSVQTU+?=
 =?us-ascii?Q?FTECM7l5a+HlNWMnDUf4McJYzTMA3hlhELZYKdY10Da+F7siM+ypAFJVIO1l?=
 =?us-ascii?Q?FeEjdFgJtyx1xsPKh3ssHuYbxjkbI2B4hroxARc58AnsLF+4oQY2XaABZhDK?=
 =?us-ascii?Q?R6SM+JnL+ZB0pgnQLxS+SpTIz4vCiSWfsmT4fnXKT1YcPclHXXLkTuzEtwro?=
 =?us-ascii?Q?laXiKLlpPDpxPHigILOrBcN0olH7OHq9IbtgtUKShCf6ENtrnFE5bNzRFL3m?=
 =?us-ascii?Q?v/6HkXdlDl+maIBNI3l606X8K2Oo05NqUAeoe0HDDyZT8mk/Ol688y0RQ0j7?=
 =?us-ascii?Q?SCnOOW31GNUniPhoJxrUfZZJ44m6+iNh4CBoKJ5nQYuLeV6OjlsHltQz9CzZ?=
 =?us-ascii?Q?MvMbDUcV7sxD02+Rhh42DJjSZbjp6y3f9NMbtp8TMb17MSGtqLTx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316d667-6979-4e48-fc7a-08df027f64e2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:03:48.8856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovE3fK0eKVahNCU62tVZVciy8zC7ajFLAxMANlkv/2mO8otpnPqgKCuDmagf3/8y4mo2foc7rGKo+nJImAM42LrC/WYvHSs3V2t9Hw01M9YTSVci6e8GHMjXzLpChefl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 24, 2026 at 03:28:24PM +0300, Vladimir Oltean wrote:
>The 512-byte console input buffer limit for Layerscape SoCs originates
>from copy-pasted boilerplate in the original LS2085A board support added
>in commit f749db3a75ec ("ARMv8/ls2085a_emu: Add LS2085A emulator and
>simulator board support"). No rationale was given for the 512-byte
>choice; every subsequent FSL_LSCH2 and FSL_LSCH3 common header
>(ls1043a, ls1046a, ls1088a, lx2160a, ...) inherited it by convention.
>
>When CONFIG_SYS_CBSIZE was moved to Kconfig in commit d31466b382dd
>("Convert CONFIG_SYS_CBSIZE to Kconfig"), the existing 512-byte values
>were transcribed mechanically into Kconfig defaults, cementing the
>limit without re-examining its validity.
>
>The practical consequence is that environment variables holding
>multi-step boot scripts are silently truncated at 510 usable characters
>on all Layerscape boards, making it impossible to store commands such
>as combined TFTP+flash sequences in a single variable.
>
>The same problem was already identified and fixed for i.MX6 and i.MX7
>in commit f7b237b81e5a ("MLK-24380 imx6: Enlarge the console I/O buffer
nit:

This is a downstream commit.

Regards
Peng
