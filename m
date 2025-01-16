Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91208C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB4D80214;
	Thu, 16 Jan 2025 10:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vDLv0dP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CF780283; Thu, 16 Jan 2025 10:24:15 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00061801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43618283dedso5858805e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737019452; x=1737624252;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IWCO9qUsFfCsRJ3jnS1FjtRpQp3dPO0eRYe0xV4qVW0=;
 b=vDLv0dP1pik65Q1M8FCUD4uHH0JSZxpt2ENgfGpkxRYMMfMaEnSmLz6RlW7k0wAJhA
 z/5lDvN6K3pShef/S0jEulf9kM+m2RJJNjrMi+MnR4lqwbPW/L8deXele39YXJbZU6Hh
 8XA1YxccRqL0PjmNOPY6PoaNCFSFrE2dpaLIFonHkOblFu07vYV93z23nYcr8w1oy+2O
 BDwezcJmJ3Y5IvCAmsN8FeFv4/ssYdgNvLKnmZzFchYZqQWfMuqZg9QUthOo0SJTvF0k
 FHRqHFI9ppq6/QEa9VNPohwBKfvInm5E8xLMFfA+aPQUdX49DQEXFvMMz7eftB0xqR/i
 r5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737019452; x=1737624252;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IWCO9qUsFfCsRJ3jnS1FjtRpQp3dPO0eRYe0xV4qVW0=;
 b=acio6wKpekapQl0nuxxaFsQ732x2PrREdkwRA4sOzXLwLLDWu58OTFHC8iei5upme7
 +4WVXqgkRWrhxHDgvk8Qc6b2IXseHgKoZ26ecxobeuaRyiBvSbdsx0vcdt7/Eb7rEcBL
 P7FWPaactmDHGCKi/JSFBZhPwwXSJQCujEwzU/Oj9g2R6KgNZwWF5r8nsBWK451pfHQO
 d1dR7E3LRyK7TW4tToeFcDX8nP3tmLh9PDdWaNDXOnXvu0jc8Y6J4OnhtUrGjhIcmk3d
 E0in4Ou7eiwx4r1qRF1ZuuyYq+ihExsQ2Hrdky9E8lCuUYhtFf+6TFeSVAgItX7xrQ3b
 Tn/w==
X-Gm-Message-State: AOJu0YwtfJpKg2QHB/W1TVlAJLvCxzFNXmduXMtMYJkUUDSeHCiHcLW3
 7DRTqAlLA1eN3Omjwu12Ar5FeAIiRcQtXyL/Mjtf+DOd1rLBRHqaMISpDKuKc94=
X-Gm-Gg: ASbGncsqx09rYrCwj1kTmWOYej9v+uFUYc4cMyntwlN0GRF4Q8bWVVj4Ed/abs/xvqE
 sz1ncEmzmNHPtW7tuGkhYQY2v8SffHuNWvdfVpfFstDFHbMz91da0940EwYshUfm8NE8BoBx+T0
 br1+WxK8QvdndDfESyplZbAKvFMbnC86X42Rh7q7pOrTOrZ4nKwTkhIHAa8BgtM6b97oiZL0pQi
 IHB+A4Xdf7yaaf2kGXq3D3EhzoNdFiRopFww0dD2LsqWzRz14CWlRHI8BZcdh4bNA==
X-Google-Smtp-Source: AGHT+IHTl8CYRGBsaBiavuh556PREfAEPkV7ERoQKWGqryoTRS7K8yI5SmMGDfnjc0452WZJX+M0Cg==
X-Received: by 2002:a05:600c:4f09:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-436e2707f13mr272920805e9.23.1737019452425; 
 Thu, 16 Jan 2025 01:24:12 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753ca42sm51461645e9.35.2025.01.16.01.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:24:12 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v4 8/8] usb: dwc2: Replace uint<x>_t types with u<x>
In-Reply-To: <20250110-dwc2-dev-v4-8-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
 <20250110-dwc2-dev-v4-8-987f4fd6f8b2@pigmoral.tech>
Date: Thu, 16 Jan 2025 10:24:11 +0100
Message-ID: <87ikqf862s.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Junhui,

Thank you for the patch.

On ven., janv. 10, 2025 at 21:55, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> From: Kongyang Liu <seashell11234455@gmail.com>
>
> Updates all instances of uint8_t, uint16_t, and uint32_t to u8, u16, and
> u32 respectively, ensuring consistent use of kernel-preferred types and
> resolving checkpatch.pl warnings.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/dwc2_udc_otg.c |   4 +-
>  drivers/usb/host/dwc2.c           | 100 +++++++++++++++++++-------------------
>  2 files changed, 52 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 084e9824faac03d47e23e0d52e81a9d12308e06a..c3fdc81e9096bb216b63ff0ac672d216bed3f23d 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -466,8 +466,8 @@ static void reconfig_usbd(struct dwc2_udc *dev)
>  	/* 2. Soft-reset OTG Core and then unreset again. */
>  	int i;
>  	unsigned int uTemp;
> -	uint32_t dflt_gusbcfg;
> -	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
> +	u32 dflt_gusbcfg;
> +	u32 rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
>  	u32 max_hw_ep;
>  	int pdata_hw_ep;
>  
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index b27429235798ce223bb8a11999e3d520c26ef377..16f21fa9083a71da1c8dd62d174712962d0227b1 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -39,16 +39,16 @@
>  
>  struct dwc2_priv {
>  #if CONFIG_IS_ENABLED(DM_USB)
> -	uint8_t aligned_buffer[DWC2_DATA_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
> -	uint8_t status_buffer[DWC2_STATUS_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
> +	u8 aligned_buffer[DWC2_DATA_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
> +	u8 status_buffer[DWC2_STATUS_BUF_SIZE] __aligned(ARCH_DMA_MINALIGN);
>  #ifdef CONFIG_DM_REGULATOR
>  	struct udevice *vbus_supply;
>  #endif
>  	struct phy phy;
>  	struct clk_bulk clks;
>  #else
> -	uint8_t *aligned_buffer;
> -	uint8_t *status_buffer;
> +	u8 *aligned_buffer;
> +	u8 *status_buffer;
>  #endif
>  	u8 in_data_toggle[MAX_DEVICE][MAX_ENDPOINT];
>  	u8 out_data_toggle[MAX_DEVICE][MAX_ENDPOINT];
> @@ -67,10 +67,10 @@ struct dwc2_priv {
>  
>  #if !CONFIG_IS_ENABLED(DM_USB)
>  /* We need cacheline-aligned buffers for DMA transfers and dcache support */
> -DEFINE_ALIGN_BUFFER(uint8_t, aligned_buffer_addr, DWC2_DATA_BUF_SIZE,
> -		ARCH_DMA_MINALIGN);
> -DEFINE_ALIGN_BUFFER(uint8_t, status_buffer_addr, DWC2_STATUS_BUF_SIZE,
> -		ARCH_DMA_MINALIGN);
> +DEFINE_ALIGN_BUFFER(u8, aligned_buffer_addr, DWC2_DATA_BUF_SIZE,
> +		    ARCH_DMA_MINALIGN);
> +DEFINE_ALIGN_BUFFER(u8, status_buffer_addr, DWC2_STATUS_BUF_SIZE,
> +		    ARCH_DMA_MINALIGN);
>  
>  static struct dwc2_priv local;
>  #endif
> @@ -85,7 +85,7 @@ static struct dwc2_priv local;
>   */
>  static void init_fslspclksel(struct dwc2_core_regs *regs)
>  {
> -	uint32_t phyclk;
> +	u32 phyclk;
>  
>  #if (DWC2_PHY_TYPE == DWC2_PHY_TYPE_FS)
>  	phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
> @@ -95,9 +95,9 @@ static void init_fslspclksel(struct dwc2_core_regs *regs)
>  #endif
>  
>  #ifdef DWC2_ULPI_FS_LS
> -	uint32_t hwcfg2 = readl(&regs->global_regs.ghwcfg2);
> -	uint32_t hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
> -	uint32_t fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
> +	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
> +	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
> +	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
>  
>  	if (hval == GHWCFG2_FS_PHY_TYPE_SHARED_UTMI && fval == GHWCFG2_HS_PHY_TYPE_UTMI)
>  		phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
> @@ -172,9 +172,9 @@ static int dwc_vbus_supply_exit(struct udevice *dev)
>  static void dwc_otg_core_host_init(struct udevice *dev,
>  				   struct dwc2_core_regs *regs)
>  {
> -	uint32_t nptxfifosize = 0;
> -	uint32_t ptxfifosize = 0;
> -	uint32_t hprt0 = 0;
> +	u32 nptxfifosize = 0;
> +	u32 ptxfifosize = 0;
> +	u32 hprt0 = 0;
>  	int i, ret, num_channels;
>  
>  	/* Restart the Phy Clock */
> @@ -253,9 +253,9 @@ static void dwc_otg_core_init(struct udevice *dev)
>  {
>  	struct dwc2_priv *priv = dev_get_priv(dev);
>  	struct dwc2_core_regs *regs = priv->regs;
> -	uint32_t ahbcfg = 0;
> -	uint32_t usbcfg = 0;
> -	uint8_t brst_sz = DWC2_DMA_BURST_SIZE;
> +	u32 ahbcfg = 0;
> +	u32 usbcfg = 0;
> +	u8 brst_sz = DWC2_DMA_BURST_SIZE;
>  
>  	/* Common Initialization */
>  	usbcfg = readl(&regs->global_regs.gusbcfg);
> @@ -347,9 +347,9 @@ static void dwc_otg_core_init(struct udevice *dev)
>  	usbcfg = readl(&regs->global_regs.gusbcfg);
>  	usbcfg &= ~(GUSBCFG_ULPI_FS_LS | GUSBCFG_ULPI_CLK_SUSP_M);
>  #ifdef DWC2_ULPI_FS_LS
> -	uint32_t hwcfg2 = readl(&regs->global_regs.ghwcfg2);
> -	uint32_t hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
> -	uint32_t fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
> +	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
> +	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
> +	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
>  
>  	if (hval == GHWCFG2_FS_PHY_TYPE_SHARED_UTMI && fval == GHWCFG2_HS_PHY_TYPE_UTMI) {
>  		usbcfg |= GUSBCFG_ULPI_FS_LS;
> @@ -402,9 +402,9 @@ static void dwc_otg_core_init(struct udevice *dev)
>   * @param regs Programming view of DWC_otg controller
>   * @param hc Information needed to initialize the host channel
>   */
> -static void dwc_otg_hc_init(struct dwc2_core_regs *regs, uint8_t hc_num,
> -		struct usb_device *dev, uint8_t dev_addr, uint8_t ep_num,
> -		uint8_t ep_is_in, uint8_t ep_type, uint16_t max_packet)
> +static void dwc_otg_hc_init(struct dwc2_core_regs *regs, u8 hc_num,
> +			    struct usb_device *dev, u8 dev_addr, u8 ep_num,
> +			    u8 ep_is_in, u8 ep_type, u16 max_packet)
>  {
>  	struct dwc2_hc_regs *hc_regs = &regs->host_regs.hc[hc_num];
>  	u32 hcchar = FIELD_PREP(HCCHAR_DEVADDR_MASK, dev_addr) |
> @@ -427,9 +427,9 @@ static void dwc_otg_hc_init(struct dwc2_core_regs *regs, uint8_t hc_num,
>  }
>  
>  static void dwc_otg_hc_init_split(struct dwc2_hc_regs *hc_regs,
> -				  uint8_t hub_devnum, uint8_t hub_port)
> +				  u8 hub_devnum, u8 hub_port)
>  {
> -	uint32_t hcsplt = 0;
> +	u32 hcsplt = 0;
>  
>  	hcsplt = HCSPLT_SPLTENA;
>  	hcsplt |= FIELD_PREP(HCSPLT_HUBADDR_MASK, hub_devnum);
> @@ -447,24 +447,24 @@ static int dwc_otg_submit_rh_msg_in_status(struct dwc2_core_regs *regs,
>  					   struct usb_device *dev, void *buffer,
>  					   int txlen, struct devrequest *cmd)
>  {
> -	uint32_t hprt0 = 0;
> -	uint32_t port_status = 0;
> -	uint32_t port_change = 0;
> +	u32 hprt0 = 0;
> +	u32 port_status = 0;
> +	u32 port_change = 0;
>  	int len = 0;
>  	int stat = 0;
>  
>  	switch (cmd->requesttype & ~USB_DIR_IN) {
>  	case 0:
> -		*(uint16_t *)buffer = cpu_to_le16(1);
> +		*(u16 *)buffer = cpu_to_le16(1);
>  		len = 2;
>  		break;
>  	case USB_RECIP_INTERFACE:
>  	case USB_RECIP_ENDPOINT:
> -		*(uint16_t *)buffer = cpu_to_le16(0);
> +		*(u16 *)buffer = cpu_to_le16(0);
>  		len = 2;
>  		break;
>  	case USB_TYPE_CLASS:
> -		*(uint32_t *)buffer = cpu_to_le32(0);
> +		*(u32 *)buffer = cpu_to_le32(0);
>  		len = 4;
>  		break;
>  	case USB_RECIP_OTHER | USB_TYPE_CLASS:
> @@ -498,7 +498,7 @@ static int dwc_otg_submit_rh_msg_in_status(struct dwc2_core_regs *regs,
>  		if (hprt0 & HPRT0_OVRCURRCHG)
>  			port_change |= USB_PORT_STAT_C_OVERCURRENT;
>  
> -		*(uint32_t *)buffer = cpu_to_le32(port_status |
> +		*(u32 *)buffer = cpu_to_le32(port_status |
>  					(port_change << 16));
>  		len = 4;
>  		break;
> @@ -519,11 +519,11 @@ static int dwc_otg_submit_rh_msg_in_descriptor(struct usb_device *dev,
>  					       struct devrequest *cmd)
>  {
>  	unsigned char data[32];
> -	uint32_t dsc;
> +	u32 dsc;
>  	int len = 0;
>  	int stat = 0;
> -	uint16_t wValue = cpu_to_le16(cmd->value);
> -	uint16_t wLength = cpu_to_le16(cmd->length);
> +	u16 wValue = cpu_to_le16(cmd->value);
> +	u16 wLength = cpu_to_le16(cmd->length);
>  
>  	switch (cmd->requesttype & ~USB_DIR_IN) {
>  	case 0:
> @@ -606,7 +606,7 @@ static int dwc_otg_submit_rh_msg_in_configuration(struct usb_device *dev,
>  
>  	switch (cmd->requesttype & ~USB_DIR_IN) {
>  	case 0:
> -		*(uint8_t *)buffer = 0x01;
> +		*(u8 *)buffer = 0x01;
>  		len = 1;
>  		break;
>  	default:
> @@ -650,8 +650,8 @@ static int dwc_otg_submit_rh_msg_out(struct dwc2_priv *priv,
>  	struct dwc2_core_regs *regs = priv->regs;
>  	int len = 0;
>  	int stat = 0;
> -	uint16_t bmrtype_breq = cmd->requesttype | (cmd->request << 8);
> -	uint16_t wValue = cpu_to_le16(cmd->value);
> +	u16 bmrtype_breq = cmd->requesttype | (cmd->request << 8);
> +	u16 wValue = cpu_to_le16(cmd->value);
>  
>  	switch (bmrtype_breq & ~USB_DIR_IN) {
>  	case (USB_REQ_CLEAR_FEATURE << 8) | USB_RECIP_ENDPOINT:
> @@ -724,10 +724,10 @@ static int dwc_otg_submit_rh_msg(struct dwc2_priv *priv, struct usb_device *dev,
>  	return stat;
>  }
>  
> -int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, uint32_t *sub, u8 *toggle)
> +int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, u32 *sub, u8 *toggle)
>  {
>  	int ret;
> -	uint32_t hcint, hctsiz;
> +	u32 hcint, hctsiz;
>  
>  	ret = wait_for_bit_le32(&hc_regs->hcint, HCINTMSK_CHHLTD, true,
>  				2000, false);
> @@ -764,7 +764,7 @@ static int transfer_chunk(struct dwc2_hc_regs *hc_regs, void *aligned_buffer,
>  			  int xfer_len, int *actual_len, int odd_frame)
>  {
>  	int ret = 0;
> -	uint32_t sub;
> +	u32 sub;
>  
>  	debug("%s: chunk: pid %d xfer_len %u pkts %u\n", __func__,
>  	      *pid, xfer_len, num_packets);
> @@ -834,10 +834,10 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
>  	int ret = 0;
>  	int do_split = 0;
>  	int complete_split = 0;
> -	uint32_t xfer_len;
> -	uint32_t num_packets;
> +	u32 xfer_len;
> +	u32 num_packets;
>  	int stop_transfer = 0;
> -	uint32_t max_xfer_len;
> +	u32 max_xfer_len;
>  	int ssplit_frame_num = 0;
>  
>  	debug("%s: msg: pipe %lx pid %d in %d len %d\n", __func__, pipe, *pid,
> @@ -859,9 +859,9 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
>  
>  	/* Check if the target is a FS/LS device behind a HS hub */
>  	if (dev->speed != USB_SPEED_HIGH) {
> -		uint8_t hub_addr;
> -		uint8_t hub_port;
> -		uint32_t hprt0 = readl(&regs->host_regs.hprt0);
> +		u8 hub_addr;
> +		u8 hub_port;
> +		u32 hprt0 = readl(&regs->host_regs.hprt0);
>  
>  		if (FIELD_GET(HPRT0_SPD_MASK, hprt0) == HPRT0_SPD_HIGH_SPEED) {
>  			usb_find_usb2_hub_address_port(dev, &hub_addr,
> @@ -876,7 +876,7 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
>  
>  	do {
>  		int actual_len = 0;
> -		uint32_t hcint;
> +		u32 hcint;
>  		int odd_frame = 0;
>  		xfer_len = len - done;
>  
> @@ -1083,7 +1083,7 @@ static int dwc2_reset(struct udevice *dev)
>  static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
>  {
>  	struct dwc2_core_regs *regs = priv->regs;
> -	uint32_t snpsid;
> +	u32 snpsid;
>  	int i, j;
>  	int ret;
>  
>
> -- 
> 2.47.1
