Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC89CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B92846AC;
	Tue, 26 May 2026 08:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cLzAid2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B7C5846A5; Tue, 26 May 2026 08:52:35 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262E8846A5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7eWUmm//mCOCecHDd9SMiSn5yFJKzLs1CNnlC+Ly6m1lXVDoF1nbZwIwaxJ7hxZ0ZWaLsddaOcl3x2OZT/r8VKmLPa82ReyW2DeXepc319RlABrMeeew8Vqotfja48d7NOEzpVnJcuKJdZ7Rb6z7EsBjW/D+DtLiWGeZX0POc8xwj9xdnYLPL0AGw+YVu3NLT7/Nc4fcV66rfkwNY8NVcxhAhWDtugNNa9I1L87IkpokHPtBW8U+M/iSYRKZhNMNptx+6fUIEhICE1L3KZOmR1DtgiwohgTidev4RjEpbA0YAnL0k/z1OTNb+vtWFrrWfzc8LPiw31hTp+G/vTc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qG8xmhge6y4ftqo7B2/GGqq2tp5ihkRKiRJub95iDs=;
 b=ZXxpfeZk1tHs3lG8uGHoajOj71gx7z53UQxvaKfO0aAzaStJRJHB3L4TyIa5AP2xC8Oq6zAe8+g6F5V10fNmjmTemgkCXVyMtxBWkkghDdHLPB1YMPmsrgRQYegeuXhbq3zn8gU67HZLvppgVrY2ZgxiVdl/1dCUtNk7PpNMONAoneHxnSrhO68pheb9911pWLPf4ZGa/kV82TjpzGLBWf0HpG5I6TNNVQgyjRtFm/9eivbm7qalhIEDX2VmES9dPW1sZawvLGaEmPU7ilp64AdAy3U6FWbgcxXtk3JXLua+Qy+vpsOc3vJqMZ2tnSR1TsX0u5bNjW66ksah8Ok+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qG8xmhge6y4ftqo7B2/GGqq2tp5ihkRKiRJub95iDs=;
 b=cLzAid2YLlxB+PMh3AwKsOs8JZfOr0TdScf5dPNtq68XFp3qd9mdzrila2w/BbW/o4f/IJ1CznsKeFJu0c3RoVWG9nTSkaFs4VOf1IFy6zMIkkj348ix5KLZJSzTd4SuQZXLFUqDsBf/lT1je9s94XJFK60shbWjE4uPHFT5AYg68nQGnO1FFPXYicAq3oIjK7SfCNhdxauGSaVKWWeQrIk0a9KzBLU43mbJGrlvNk7ic9ZNOPn01IpLkMRi1DjaSZADVlNKAPRXlnuXjHQOtnKrCX2JDxZxDJQD0KArAwN0pjjdz/KvZiEWmC8kZumM82GrAUzSJvKOlxG1Xp3MFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:52:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 16:09:10 +0800
Subject: [PATCH 2/5] pci: mpc85xx: Simplfy code with dev_remap_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-pci-v1-2-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4561ff04-dcb9-450e-fcb1-08debaf35aea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Vlu9lhQpTpxuXZLY77cZ39Wr+a2xpH+Z5VOPLQZHt0b+e4YF+FHe5eIJYHrqWutEhNscSQnGKngRbCl6WmtlCT50kYuHEc7uI+WncAknTwZmBJ7dDDJcOW7rLp1y7HXgkLJrSO3+KqSYVCIYmhT0T9Tntw5D47PaZDvnj71v3UiTGmy9fbeDvgHg8eidv+tkyKPUCU9jPKaIUE74gItyJnH2w37JRNceiwN+m22vUoti3yNDybC4U5PYOrM851Nr0O3vRammfRxAaNsBF/K2tG/qJwn+B0pvBCy5katpBsfdvW7PdfYtmCKTN5idjUvLIJm8xEchVUUUQ6iJzKG1iquRygXcZsRaC2g48qz1k3JhrYBQC9Puy7HY6rUwbMMR+YvHNcdDyZ+Fl925DJZYQrgR1qqXWnbXWWF2dnad+Tjaarht5MpjETdRUSc+vMzkze0fRIQfUByFldig3s3fIPquNpfH0pfH1r51uwHOwtkX0Cs6VQdaqYiI9EtoLwUWCts7ok/hx7q1D3lBdOvlrTEXKwhhhgZs/DCULFAQWawx4qEeM0ChIUq8GzgumkyzRuVbIWQc4rP9r/vXHbx2ViQEmLhb4rp80v+6OqXdC15DGtlG/D0NbQKJlFntKBA4yPQ+iZQpkNLa29lcS+E+xiNfoAmVhHZ9C9ptRAJ4+osPuVWg3oqJa6dNEo2H9FdLgfL2yJtguwjB3bWsUMdNajKqac78YA6hJKdAfOGea68DlISSPUSbkJzhT5JZfGp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFpUWtveTJFcUJnSXZ4ZUlMOXVqWWtxWUxQQmJBa1lWamp4M2dkTGF5eDFx?=
 =?utf-8?B?NjVBWDB1aU5JaHdhMU1QRGVPZGlyWStRSUJwcWlQQUZBU3p0RXNmSW9VQ2p6?=
 =?utf-8?B?NW1WOExPajFUaUFJYkl3WmJOTHh3T28rN3VoN0lUSFplVitRbEhsTno2akgy?=
 =?utf-8?B?d0J0YlF4dkhmYWtZOWZralhtMytycERCblg4VUlDODlRQjdZSnFtQ1lKcklV?=
 =?utf-8?B?ZHNKenlsV3BmenNURVVUeDQ2bGtaS2M4SnZ1amVvWlAxaXZMRHc2bjZsWGkr?=
 =?utf-8?B?eFByZk4rUkFpa0lKVkF1YTE0TkhJNHFpdTBRZ0QyczJjcldCWU5xay9UNy9P?=
 =?utf-8?B?c0hlNXRta20zbVlIU2Z3RDlaZW1oU011dUdjMVFFajNtUXdtbFdQeHpkOUNO?=
 =?utf-8?B?Ym1BVVVUR0pnMDM2RHJ2SlVKQkxVd1ErRWZCSkhFL2d1SXhZYmkrNXRRTHZz?=
 =?utf-8?B?SWx5cVY1UEt4eEI4YVh2RTNZUFpBQU40NzB4OTBHczB3K2hhNDk3S1lSWE1T?=
 =?utf-8?B?ZlZ2WVVML29HNFFwZC9wWm5aYTFCanRaL29CVGZuREZWeDdadXdDTkZudEdw?=
 =?utf-8?B?bjdJMVk3Njgxb29GdzZTRzR2Q2YwNmJqQiswaVRDRE8zZUtrWXl4MWpoTGpO?=
 =?utf-8?B?TUU4TTN2VlovbFE4SXFRSEcxd3dNcVNqQldFVG5tMnA3RVZCaWJqRmZ5ZTcr?=
 =?utf-8?B?WTZXK0xXSEJya0FUWS9mTnY3SWIrSGxyU0xsWm1nd0c3WENQOGpuZlBPVTlK?=
 =?utf-8?B?UzZRN0JLakg3ejVEUEtjSkU4dTRxRDNzK1NHL0M2RDhpQ1hRVlNMR2NVWkdh?=
 =?utf-8?B?WDhxWXFXZjFqQU1pYUVLMGtaTWJDYWM1aU1CRTg2Z0FFVmxEZ3h0WG9ZUUdk?=
 =?utf-8?B?OGord20yeGVxUFVURzhXei9tNUtjR0pJVmFvU2VuUWJTaHhNaFlGS08rZkF4?=
 =?utf-8?B?ajNVSDVhblVlaVVOZGw4TndTQVhEZm9uaGcxRTBlRUN2bXIwNjg5dSs1MzF1?=
 =?utf-8?B?bTZvWnVrNzFCZUI1QXdPWm1XMnRTaTZCMWt4d05iSFdkbWlLaVNCN2RSOG1v?=
 =?utf-8?B?VUFlSjNscUw3QnBmN05vZHRLc2FpbWdmU3RualF3a05rQ01GVTlwY2V0V1Bz?=
 =?utf-8?B?N29HYzM5a2ZZSi9rUG1Vc3pMMlUvUmdTTS9FSEJ0eFFFY2lULzVoRytUcDl6?=
 =?utf-8?B?Y012NDhsY1Z2VHIxbk12eXd3a1pkZVRDYlhZMi9mTWg0U1hBWHhUcG9iVkR5?=
 =?utf-8?B?TWxjNXF3UzFqRXk2UE9MT01KbjZhaUlyT29XOWo2SENYRzR4QlB6aisveDR2?=
 =?utf-8?B?M3JpeE9xNHJkbTFHUmtFYkVtVlhIN0UrZG1wWnh2WDN4b2c4UWR2NXBsQmxX?=
 =?utf-8?B?eG5CYS9hQWtMZWsxc3h3ZEdDa0ZKcnF3OHpmV0pzTlE2clFyM1FIN2JwcTM0?=
 =?utf-8?B?QzRVSWZzSWNuU1lKeFlnUHp6V0ZybkNJVzdqcjZPMmxuWmdYcWVDLzMwNm1k?=
 =?utf-8?B?LzYrUGowNlRrSHpEWTBZVEM0RzBVMHFUZXB2ZnNnMThaR3JxRFFuU3FPTDM0?=
 =?utf-8?B?dnY2NFFuaFBvbWNZUGZwMWVCR1J2enJBTXlsL2dPL2l5cFZtTUNGbXNmZFBY?=
 =?utf-8?B?RUYrRWNXRGd3b2xxU1VSUWZodFFLSFJRczJIUWxhVVI3NUhRcm1nYkgvNUlv?=
 =?utf-8?B?VGxpOUYrSFVCUEs4WkJMcFJiNVR1WjFsa2VIUUtnUXNXZm0vNWliRGxTSHNq?=
 =?utf-8?B?UzhBOXlBRzFneG02aWR6U3h0bmNoMGVIL3kxYjhFZmtsbnhwcklrUTZUbkF4?=
 =?utf-8?B?VGdnVTc3b3J5Um5heWhZNHIvYmZHeG1nekpzdWViUEVkQ2hFRHAvbyt1eHNZ?=
 =?utf-8?B?YXlpbHpkOTZKcERNV1c3ZjFHYUZuVkk4UWFNNjkxTEc0c0FOQ2JrWXR2K0ht?=
 =?utf-8?B?blMxaGNqV3NZZVpXYVZvck5wRUczT0VQZm5mRXN6ZkJjNFNDNEc4dVh5cjdi?=
 =?utf-8?B?UlZwVXY4ejZEWkdrY0pQUjBzQWozRGtEYkZxK2ZUYUMyU2RudE9JNi96Q0hX?=
 =?utf-8?B?ZEVTUXBqL0hLbDVMSjZ4dHcreDc5cFJ6eUlJOGluN3JEWEp3bkIrcW5BRk1B?=
 =?utf-8?B?bXVnV2ZhNkpObDQzNWs0UURxOFlXd1ZoQzlmQXJuUk4vU1BPalNscEJSc09o?=
 =?utf-8?B?VWhDYmhFWHhEQ1UyemdGUjRMRU96Q1FPSUtvOFpVcXQydzh4WjQ2WkhWM0dt?=
 =?utf-8?B?YXhQTmNtSmZLcnpkYmtZNGRpRVh1LzFTN29ZaHBRL0VkT3RFNEd4bWlNazRv?=
 =?utf-8?B?KzNDUmZpNTRWbG5kZEFHOVdudElXK0MvZEQwK0RicW5VUkhkemRodz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4561ff04-dcb9-450e-fcb1-08debaf35aea
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:29.9122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPAiBFol7Hc535+ScOyP9jPsSVPSMS+1KxLPb8CkNN+cRC0VsJ7m/FEI+XQnrKycIH3+PqwTW+t5dgQhLPRQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
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

From: Peng Fan <peng.fan@nxp.com>

devfdt_get_addr_ptr() + map_physmem() could be simplifed with
devfdt_remap_addr(). But to avoid direct dependency on devfdt_* helpers,
use dev_remap_addr().

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pci_mpc85xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci_mpc85xx.c b/drivers/pci/pci_mpc85xx.c
index c07feba7976..96550a9ff8f 100644
--- a/drivers/pci/pci_mpc85xx.c
+++ b/drivers/pci/pci_mpc85xx.c
@@ -170,13 +170,14 @@ static int mpc85xx_pci_dm_remove(struct udevice *dev)
 static int mpc85xx_pci_of_to_plat(struct udevice *dev)
 {
 	struct mpc85xx_pci_priv *priv = dev_get_priv(dev);
-	fdt_addr_t addr;
+	void __iomem *addr;
 
-	addr = devfdt_get_addr_index(dev, 0);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_remap_addr_index(dev, 0);
+	if (!addr)
 		return -EINVAL;
-	priv->cfg_addr = (void __iomem *)map_physmem(addr, 0, MAP_NOCACHE);
-	priv->cfg_data = (void __iomem *)((ulong)priv->cfg_addr + 4);
+
+	priv->cfg_addr = addr;
+	priv->cfg_data = priv->cfg_addr + 4;
 
 	return 0;
 }

-- 
2.51.0

