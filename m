Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D0E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3138007D;
	Thu,  2 Jan 2025 17:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="DSQeLBmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AF080107; Thu,  2 Jan 2025 09:44:03 +0100 (CET)
Received: from AUS01-SY4-obe.outbound.protection.outlook.com
 (mail-sy4aus01olkn2082c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2819::82c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6650780087
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujh2818@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAMcv4TaW/K4DJYP+h6NolhkjBg6Db1Y6TOEsmg45N5Z3sWGrIJCG17oU9v1KAFUDWE+Srcl20utDLN9jRmoisNkfyD1a4+hpMJlT+i/xFb2whFiDw/Ns7PDDmyOCzc5RWbE8IWsbsnDSabyOAzuVXzIBtPcC+zTNOZ2FkRk3/MXq3C/vAlLoH4ipeTTaHNbwbmrWpuQwb0xlBpzDeeD2f1RNPgEtDIN/j+s8lv7fZh0vLsaMYMpmZS9wKPpTBof17J/R7B5tmtJ2xM+O5/5blM+uPmbUBLo7+xvjgzpLIbL7P5KUDYnAGwmNUiHJ3vFpP206YDSoM5Va3trTgvLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ8DdRP+HuOVBjWtClM53nZQc2POZhsTPeTQsV7mozw=;
 b=OolwyJdRXy1BRs/5PgZDAL54VphZsRJ7CU5adXCkOwOL0VeC45kuq0RaiY+0ChCXMQXtGC1wtzs6MPe4WaHRr6JFxMcGJVFdl0nhnqjTbtSC9xlegPp3Gt1R/rQ/2cn0TpVnWOLcGlLTe9VeBTaxI/VjcFOmhbU3MJGtpGQzA3QzOVi63EL0XKYDe8GydwVVFFuvgth98oTyofu0D1XwcxXWac2aN6/7x4wKPbFWfrG2/X0WDlvT2iC0rT/zN6oDuhyySd5Kj9jTqjklvWkf0JSk5paaomzuyimiMs+Z9HAtZVRGKzL0jqwEl2mzPd8ZTx3owqtpRRb5Zy8WMMhBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ8DdRP+HuOVBjWtClM53nZQc2POZhsTPeTQsV7mozw=;
 b=DSQeLBmRMXZpk3Zd5N337oASdIk4/1oqAyBKgjbzzKKhggLNkblyLKODWO9SVIZSFFNK4Zz/PfhhXnMTwyFYiNpilGs7FmkdkVzw77l8hdKB4lEow+AyKuI+Wz6iVmY+hspRnzaNWTPonXYmZI3OFc9EHTY9w/zSQrC+gDaQ7BxVclW2DAqm/G+p4fCH2LrEnzy4kiMyUXgiIABwdpZpTIrnNVQAertcRbSvOgfM+/uzigreI1z3zz+fbnVmFnF9mfsb0Ke8pbL+lgbiAXFhY7NQwObxj+cLfb0HyDODn7nG9biiUue+fTAKGJAyODs5XQddXV+YKxXXDdSPNmd0Fg==
Received: from SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:296::5) by
 SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:299::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Thu, 2 Jan 2025 08:43:51 +0000
Received: from SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fc57:50c4:6ee6:c8c1]) by SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
 ([fe80::fc57:50c4:6ee6:c8c1%7]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:43:50 +0000
From: Liu Jude <liujh2818@outlook.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Kongyang Liu
 <seashell11234455@gmail.com>
Subject: Re: [PATCH v2 4/8] usb: dwc2: Clean up with bitfield macros
Thread-Topic: [PATCH v2 4/8] usb: dwc2: Clean up with bitfield macros
Thread-Index: AQHbWms9zyq5/dGV9kS22gPKNPWuwLMAp10AgAKIoQA=
Date: Thu, 2 Jan 2025 08:43:50 +0000
Message-ID: <52DE23A6-5DEF-4C02-9892-043EBA522534@outlook.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-4-12cd9b8a2358@outlook.com>
 <18ea1084-69be-4370-b8b2-95a6c06e3e0f@denx.de>
In-Reply-To: <18ea1084-69be-4370-b8b2-95a6c06e3e0f@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0922:EE_|SY8P300MB0571:EE_
x-ms-office365-filtering-correlation-id: dcfe07a3-84ae-45c9-febc-08dd2b0994a6
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|19110799003|461199028|8060799006|8062599003|102099032|440099028|3412199025|56899033;
x-microsoft-antispam-message-info: =?us-ascii?Q?MwSPuzBCaZyICQpk1fL5Pl99CYL1CK13v7ex9ZbyN0Lf62aEz1ZQp8nua2QQ?=
 =?us-ascii?Q?k4qlUAhNhi+dxsXfuWFQ2DUaU+jpXwwygCgfVPSe16IRF1x/tU+fUakk6ZFC?=
 =?us-ascii?Q?b3SWmBWZyKn2smmjFuskvg3r5WLuN/OhZQ4mbH3KXHXSzd8YzAntjGdohK+h?=
 =?us-ascii?Q?v/OV7yZfxnKvVkSDHlkvBE9d20n6L1lol1Z+RjFMnXLaWizghniqKZEJL0AC?=
 =?us-ascii?Q?3OdwVnv7YXsWHIX7xxW6K2rK00iz8yiCuqw4dwBwm/1b6OdqBzQv3wxDiULx?=
 =?us-ascii?Q?9zrmEVutpE1nGbsThmKiJCDAETT9NGvI5Nt1MGqgTSxEJ0XE9ANS2WKQmS9j?=
 =?us-ascii?Q?qcJDr5oicX6dV10xgFLDR+xuZCZjMylJXqv80bJgzo9KmViOaMHButpkPsI9?=
 =?us-ascii?Q?KHAX7MHwyiGfPJBVQyEppZ2960fHZpeWx6aJgC99lf7cFAy2KYGh5hvMczt6?=
 =?us-ascii?Q?bjIAfsnhefl5KzCzUKmrpzkG5jDy7nIiyjqi2jE2TT68DEDQ33/nXlnG4FKE?=
 =?us-ascii?Q?xP2343Tq9XUXUkK+Zfs41kfE/No8Sow0ZB8ZEpyhu4l2QthklJF4gP6uezQH?=
 =?us-ascii?Q?aOFY/3cL6xkLJgod4tjMByLq+Ito8PVQnu3wTVuJxgnp7nFOeyfITmMG1w32?=
 =?us-ascii?Q?WDlz31PgLCWA+xcD7xMtG9oMr7ZgrmvTLbaHuId1TXYday9sUjaHZDqA+yap?=
 =?us-ascii?Q?NuCJB3GfJe86OK+eXDXE5UGQH1tjklh0yzaJOnmeHd/BGRsVdMuUAZtfOg0l?=
 =?us-ascii?Q?ZV6kHtJZ/ZawRcddCunukH6ipxY6jpD5pHR6Na2bnW4/Fpgge5FRGg5//veQ?=
 =?us-ascii?Q?cqmpUMerYCgJG7CBHMFOhyk+2LJTwQiJIHPixulP2qPQCaDAQWeJbtFFgqpo?=
 =?us-ascii?Q?m/qZayTpNUJo2oMjvlxhQh3rUIOya/O+wBf1VaQV+op7hi7GaFnqcCrp7DeR?=
 =?us-ascii?Q?czMxs9FAwxSoQL4JrLUXmFVuTJ/7U9V9PN6Ki/+DQCIEMi73s5wZVioTm8tn?=
 =?us-ascii?Q?Pwm+XlUrk+D8GfF09Lq3xHAVN9hGXg+D2lfCniL+QFTK0UzOudhZh0Mq+fsN?=
 =?us-ascii?Q?TpMHPA6Qd86wfLLfpcJS/32pSd0MWg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bouPhiS7OtLh+u6Emt9YfMJgn/0ZPO5mCZSS96uXtaZYtjlmA6sFdS+M3zX5?=
 =?us-ascii?Q?Ky0IYjNqwHSAaGJWoIBzea/V8kb0awbVHvodfCL35lR+GD2qUsJvIgouXBEf?=
 =?us-ascii?Q?Z2vat8u1GE8WTpWIYJsRp9jS6xD3BWUMtJmkSQ3dPIJXg58EgFk3JWx5TeNG?=
 =?us-ascii?Q?LVCAALFfN/YC4z0df+iXxTDobvzn8zeR6dQvbrINEpg6LLmCiZzrGJgTSjIN?=
 =?us-ascii?Q?elKSFzhQwHasootz4FqVHs/zL59AysgA3I6Zn+1Kzjnvbm49Mt98oTkBMS5Y?=
 =?us-ascii?Q?WBhBxLM97aa7o8Ekw5JvxFrcYjgsZ7TmXzxKGy/Lhqa6of7u4/FdlbqjTHrb?=
 =?us-ascii?Q?sLK1d87l8iot7SVaWC/bhPSXa/VOUpqfaJI00GCqRhatI4gFUMLm1t97xvMd?=
 =?us-ascii?Q?Fv4ulumRy06mpAEfZvnCjZSRZXbSGaDMjZYxl0EWtqwCTDRgxrpvtD1sXJte?=
 =?us-ascii?Q?6/eTv7XFiCOTRkrvhJFnHAQwgn/k/5j07l0cut+DMeEGX9XGanIZ4+qHaAXG?=
 =?us-ascii?Q?e7ZKm2zmiGtwZGAtzWaD9ENJJFScNYpECEWyRf9HrN6OSQ2QmwNuMiUrRvCO?=
 =?us-ascii?Q?w2/3qf61ImOExgPhTirDUX/KfZtYEG4OD7qB2bDxfJGStVkOJNEdcN4/t/uR?=
 =?us-ascii?Q?lqYv2RYFdRjjvWUv7H0XuCGVXJmr4g3zQRsRU66EihpsKSt9ouM2p2Fs3Baw?=
 =?us-ascii?Q?kq39+MMkuDTdb9UcfAJSX8YaRLNdfBX5nAn3lDlRIAE3AvIyYrXKMVS62L8h?=
 =?us-ascii?Q?YzPeWlaKclOTc+WRUZaNa768hIG8SqFadsHhu254KyXc86AIjcu8gs0ktdt2?=
 =?us-ascii?Q?j7nOuUnDJ2ch5394N7u2sfSBoLSr8Jp9xK8u+aGTaGvrQXhdFTkLpE76/DF9?=
 =?us-ascii?Q?2SmTTZun5po2hm40iqtY3s7s7t1qHNZYDIIMHam5YiTnQYEv50JSnldF22FS?=
 =?us-ascii?Q?k565iulnPS1s4RerSFAab9MOWyjyeT38USJyQD/luDVWs73MFOWaDngo+KO8?=
 =?us-ascii?Q?B9lqO56xC08QqmUAhreIoow+mmIXpfGE8Y8XkKwTwsaXlf/VNFEexCCWU+em?=
 =?us-ascii?Q?FuCe8+AAoVGLr0Wmi2zrGHA1YkZRNRtScg67EkoUrYURbyLeYc9boN3TJwhB?=
 =?us-ascii?Q?hBDSOkqmPUhssk28keLur3yYwA7de4J9o8M2R1Eg4s0sk/OwIqLG8i/ZIyM7?=
 =?us-ascii?Q?MUB5j8r9sUqJ9wy3xxVzboQd+3Jbu/IlPMnxGgYpsW4wzu5IbvQcAnz9lje4?=
 =?us-ascii?Q?vSiWvbeQDf26e/ZsVaounvFzYwtSEtegtXWPzjUMYvNlx1TB0ABeAZueY7Oz?=
 =?us-ascii?Q?tJ210gVSDv7/9PcYFH+r64xK?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0922.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfe07a3-84ae-45c9-febc-08dd2b0994a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 08:43:50.4803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0571
X-Mailman-Approved-At: Thu, 02 Jan 2025 17:27:20 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks for your review.

On 2025/1/1 02:02, Marek Vasut wrote:
On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:

[...]

diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dw=
c2_udc_otg_regs.h
index 198ba7a7c37d05dca084ef017534265f5fb5fd70..33359ba56f7864525fb435ab52f=
2b21538e4647f 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
+++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h

[...]

@@ -78,15 +77,15 @@ struct dwc2_usbotg_phy {
  #define HIGH_SPEED_CONTROL_PKT_SIZE    64
  #define HIGH_SPEED_BULK_PKT_SIZE    512
  -#define RX_FIFO_SIZE            (1024)
-#define NPTX_FIFO_SIZE            (1024)
-#define PTX_FIFO_SIZE            (384)
+#define RX_FIFO_SIZE            1024
+#define NPTX_FIFO_SIZE            1024
+#define PTX_FIFO_SIZE            384
  -#define DEPCTL_TXFNUM_0        (0x0<<22)
-#define DEPCTL_TXFNUM_1        (0x1<<22)
-#define DEPCTL_TXFNUM_2        (0x2<<22)
-#define DEPCTL_TXFNUM_3        (0x3<<22)
-#define DEPCTL_TXFNUM_4        (0x4<<22)
+#define DEPCTL_TXFNUM_0            (0x0<<22)
+#define DEPCTL_TXFNUM_1            (0x1<<22)
+#define DEPCTL_TXFNUM_2            (0x2<<22)
+#define DEPCTL_TXFNUM_3            (0x3<<22)
+#define DEPCTL_TXFNUM_4            (0x4<<22)

Nitpick -- please add spaces around << , I think checkpatch would warn abou=
t this.

Okay, I will fix it.

[...]

diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadge=
t/dwc2_udc_otg_xfer_dma.c
index e2a24c53b4c8d632163484d52b4338820dcb1731..76c0b03c355b47e9523a071bd76=
ab8d6a17cd3ac 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -19,6 +19,7 @@
    #include <cpu_func.h>
  #include <log.h>
+#include <linux/bitfield.h>
  #include <linux/bug.h>
    static u8 clear_feature_num;
@@ -174,11 +175,11 @@ static int setdma_tx(struct dwc2_ep *ep, struct dwc2_=
request *req)
      ctrl =3D readl(&reg->device_regs.in_endp[ep_num].diepctl);
        /* Write the FIFO number to be used for this endpoint */
-    ctrl &=3D DIEPCTL_TX_FIFO_NUM_MASK;
-    ctrl |=3D DIEPCTL_TX_FIFO_NUM(ep->fifo_num);
+    ctrl &=3D ~DIEPCTL_TX_FIFO_NUM_MASK;
+    ctrl |=3D FIELD_PREP(DIEPCTL_TX_FIFO_NUM_MASK, ep->fifo_num);
        /* Clear reserved (Next EP) bits */
-    ctrl =3D (ctrl&~(EP_MASK<<DEPCTL_NEXT_EP_BIT));
+    ctrl &=3D ~DEPCTL_NEXT_EP_MASK;
        writel(DEPCTL_EPENA|DEPCTL_CNAK|ctrl, &reg->device_regs.in_endp[ep_=
num].diepctl);
Nitpick -- in some follow up separate series, this could also be replaced b=
y clrsetbits_le32() , but that's really for separate patch/series.

Sure, I will start a separate series to deal with this later.

Best regards,
Junhui Liu

