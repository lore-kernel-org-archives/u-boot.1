Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C55C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B0BD60684;
	Mon,  7 Sep 2026 08:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3HY_KP-_f2M; Mon,  7 Sep 2026 08:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 42BC860653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768811;
	b=BxpkKTyFw2EtrYLop05iKrdTSQQlsG1887kSLlNJDgtMu1GC3WCkY92bTRgn7iiM7S9n
	 BD2qCmybunAMlkx/JLaJuc0K1C6yXlpOwfL9ucJRPgRD7ibKKtcjfyDhCgB4jzlqvMjV3
	 qhiUSXxntw83h9uOhyReCB0X60gh7ZEEZwmUWudeBkptlC7PsBfIZ++wAJ6pnVBqbk4rb
	 8z7eg/McNJ5D7IjEmhGqQHyAmlEqcsJiAHc7KG0Q40etuoSNRnOguqiAdg19v9BBN+jBB
	 lMUU6nP/g9weKMEPLOYJbBSn2+CX9ncXO7GO7inCV6pHBA6k+Eyom1uf/FjHLb2b6uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rwLEjd0ycRQEoUO2+0ikq5resSF0QGj6AKUy8vW4eLE=;
	b=heuLhVtvCbNWAAvwQ2ohq/M9GZ/x/Z6F+z4WUuN3cZ9cWMILZqzc/pFbQ/WUQrG6HLZw
	 Di/RsrPANmwRY8jC7/yU7xGjnMN0jtwGUgqMPFLV9SRfUnMz13INLeHOotZbABFcGtxAd
	 h9+LSvT1p8jAiIt8HxTM99zaL2DXQ7o8Wsxk8yIyeDOU14rvhR3hFcS2yD2KvCgJkHOLm
	 sPCAcfvMT5l9GKmcQh+YLscCFoZdxgLGRMSZkPiDYY7fRKSGSsnih5z3Xppt0TGwmKWXb
	 br8u1WBzcfTvRP5ekNM/2dUfdTPAxQWs0WxgQqzrrhyn+7yoT2yJIRkqS37BhcLr01w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768811;
	bh=rwLEjd0ycRQEoUO2+0ikq5resSF0QGj6AKUy8vW4eLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHf9vmbCgzxGY6uJ2ZKii23Mff9piPnY7bmkTXJTfZHvN8rBqOUsUss3cxh/oDoWp
	 kRgIlN+MCr5rWmRS8eDoXwdYf6GuhzMvW3RgAgEKT5BFk/Ub5JyJv+FRqxqFSgg12h
	 SydBOmziTTWMH+Iu/O6pimlgPjeRm1B2nkQC7oNoZ8yxg04FpWc1DvVfWiUz/6atFm
	 rFdOeI1wkQ1onOnjk5yDnXXYx5yONKvgp2zoDno97+jcXFTIvFBaLaY7Ya0Vy1WKMk
	 PEsufvVm8l+t682Zn+n79QGFSgr0aoyl4PczmGQFViJ8LjiEN+d/dHHQ38toh34gWE
	 FyS3SBOMs6lpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42BC860653;
	Mon,  7 Sep 2026 08:13:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF961118
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5FA7400F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfvc364PwwZF for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C32CC40068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788768808;
 b=KEeIVcq0pOTv1q1XQ6k++Gxh/WPtbXCaD4HERfWPX6ymied53SLRoGNTInr/MizUWEkn
 B7yyPHjguYS62ZlDyCxp6svrU0nFQcTNWdSNAYW6PNscly4kTbFFnCCr6dG0GXnKHZj+1
 2dGATRUCLlqZxzGp4GN4j9mhwy0YarGsmbk6uXI9Y+O79+BBl+0wPQPRtAjhCuND/OAuZ
 Cn7zYS3MjbMJcbK4GXlDXzwyVCyaEunxEB5Ezx0ZkrJM7JxwP4/+dI/T2/vD4/W0YDPei
 INkWu+0L5GsTHAuhR7ZoUBavObKE5MiRo+VT53cLza17v2LB/ImV3Wu+V6LczR/UIqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768808;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=rwLEjd0ycRQEoUO2+0ikq5resSF0QGj6AKUy8vW4eLE=;
 b=F1lT2nCxKTCRDTftSWNYQKupWCnloRbuZ5r5MuWZa5wGpo1xmU0f2Rmn86usLajvcD2Q
 A6dv9uLSvAQK+2waTHOnEfFW84d/sW/dPPFm2JyFWFh6xnQ2ogyuvtJHEhYg95IckaXp6
 Tc+Rvp1FZDOp0qOFR9PN9p957KVrINdkbEwc/dFYi/DjqotQpJj+BgBUmFrELB/YCBxdo
 TZfzqLawvsQZgA8lA2HUD+bnHh22nr61snk5YMz2Lox5foZr0b+9ZJti9PLguDcQRy8MP
 VA1Gvsg228RMljPTNKvVVITWzui0webk7pjpR0fA9P93zIYisc2R5LsYaK94+HdzOJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kaWPDmwS; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kaWPDmwS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C32CC40068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:13:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2896436F0;
 Mon,  7 Sep 2026 08:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83021F00A3A;
 Mon,  7 Sep 2026 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788768807;
 bh=rwLEjd0ycRQEoUO2+0ikq5resSF0QGj6AKUy8vW4eLE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=kaWPDmwSjK6+tivxjnDRDmFYZdHn36rJLzWYYp28iUbV+UeP0c4V7knKY7jzPxlsz
 BRchYlgxIqNok7X9pjF2cbQvtqQ8VPaUIoWu5rPoBf2bbRA8Qx5nyfV9R5Hp1mlaN8
 w/uzYNLRprg4MiXwzvXtGMBfiTaClvfUZHiVxEL0fdhq1AEm25nGutJnB8i2wUIVmw
 ZYo6hF0Qdfq7k5VL3Coyt6SfCf2nPhnTTJPbAibj2OV/BkV5DmzShlJmoPA/fkaczd
 +3Dxk2QoQtGfUtGu8ZEQlyWDW4CjsAwFS777wdik+CIyISIx4xcCLpzBprmptKZS7G
 eD2bDNpJlBSwg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Levi Tomes <levi@userdevice.net>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: gadget: dwc2_udc_otg: translate DMA addresses via
 dev_phys_to_bus()
In-Reply-To: <CAG7BTaqzj4Z=LM8E6U+e8Rz531Pf0BvFEB8nnSWvz9BE2e3tRw@mail.gmail.com>
References: <CAG7BTaqzj4Z=LM8E6U+e8Rz531Pf0BvFEB8nnSWvz9BE2e3tRw@mail.gmail.com>
Date: Mon, 07 Sep 2026 10:13:24 +0200
Message-ID: <87tso1tr6j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Levi,

Thank you for contributing to U-Boot.

On Fri, Sep 04, 2026 at 12:12, Levi Tomes <levi@userdevice.net> wrote:

> The bcm283x phys_to_bus() helper applies the 0xC0000000 VideoCore alias
> unconditionally. On BCM2712 the OTG controller sits under the axi bus
> with identity dma-ranges, so the alias points DMA at nothing and the
> host sees 'device descriptor read/64, error -71' during enumeration.
> Use the DT-aware dev_phys_to_bus() like macb/sdhci/nvme already do; on
> BCM2711 the soc node's dma-ranges still yields the alias.
>
> Tested on a Raspberry Pi CM5 Lite (BCM2712): the CDC-ACM gadget
> enumerates and works as a U-Boot console. Also tested on a Compute
> Module 4 (BCM2711) to confirm no regression: the gadget still
> enumerates cleanly there.
>
> This is my first contribution to u-boot, let me know if I am not following
> process and I can adjust. My hope would be to do any testing you
> need on this patch so it can land, and I can stop patching 20 machines
>  in my talos cluster with my own sketchy patch.

Please move this section below, with the "Notes for reviewers". We don't
need this part to be part of the git log.

As Marek mentioned, this patch is not patching the checkpatch.pl script:

$ ./scripts/checkpatch.pl usb-gadget-dwc2_udc_otg-translate-DMA-addresses-via-dev_phys_to_bus.patch
WARNING: It's generally not useful to have the filename in the file
#271: FILE: :52:
+ writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),

WARNING: It's generally not useful to have the filename in the file
#280: FILE: :75:
+ writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),

ERROR: patch seems to be corrupt (line wrapped?)
#286: FILE: :106:
dwc2_request *req)

See:
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#general-patch-submission-rules

Also consider using b4 for helping to send patches in the proper format:
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#using-b4

Thanks
Mattijs

>
> Signed-off-by: Levi Tomes <levi@userdevice.net>
> ---
>
> Notes for reviewers.
>
> How this was tested:
>
>  - BCM2712 (CM5 Lite): with the fix, the CDC-ACM gadget enumerates on
>    the OTG port and serves a working U-Boot console. Without it,
>    enumeration fails with "device descriptor read/64, error -71" as
>    described above.
>
>  - BCM2711 (CM4): regression check. U-Boot built from rpi_4_defconfig
>    plus USB_GADGET_DWC2_OTG/USB_FUNCTION_ACM, loaded over USB with
>    rpiboot; the gadget enumerates cleanly (0525:a4a7, cdc_acm bound, no
>    descriptor errors). rpi_4_defconfig also builds clean with the
>    change.
>
> Note on the BCM2712 side: Raspberry Pi 5 / CM5 support is not upstream
> yet, so that testing used an out-of-tree Pi5 patch stack. The change
> itself is independent of Pi5 support -- it only swaps phys_to_bus() for
> the DT-aware dev_phys_to_bus() in the dwc2 gadget, the same pattern
> macb, sdhci and nvme already use.
>
>  drivers/usb/gadget/dwc2_udc_otg.c          | 10 ++++++++++
>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 14 ++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c
> b/drivers/usb/gadget/dwc2_udc_otg.c
> index e475b14b9a..3835244cca 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -168,6 +168,15 @@ __weak void otg_phy_off(struct dwc2_udc *dev) {}
>
>  /***********************************************************/
>
> +/* udevice of the probed controller, for DT-aware DMA address translation */
> +static struct udevice *dwc2_udc_udev;
> +static inline unsigned long dwc2_phys_to_bus(unsigned long addr)
> +{
> + if (dwc2_udc_udev)
> + return dev_phys_to_bus(dwc2_udc_udev, addr);
> + return phys_to_bus(addr);
> +}
> +
>  #include "dwc2_udc_otg_xfer_dma.c"
>
>  /*
> @@ -1073,6 +1082,7 @@ static int dwc2_udc_otg_clk_init(struct udevice *dev,
>
>  static int dwc2_udc_otg_probe(struct udevice *dev)
>  {
> + dwc2_udc_udev = dev;
>   struct dwc2_plat_otg_data *plat = dev_get_plat(dev);
>   struct dwc2_priv_data *priv = dev_get_priv(dev);
>   struct dwc2_core_regs *usbotg_reg =
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> index 5a7f50ebaa..04c0485ae9 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> @@ -31,7 +31,7 @@ int clear_feature_flag;
>
>  static inline void dwc2_udc_ep0_zlp(struct dwc2_udc *dev)
>  {
> - writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
> + writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
>         &reg->device_regs.in_endp[EP0_CON].diepdma);
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1),
> &reg->device_regs.in_endp[EP0_CON].dieptsiz);
>
> @@ -49,7 +49,7 @@ static void dwc2_udc_pre_setup(void)
>
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
>         &reg->device_regs.out_endp[EP0_CON].doeptsiz);
> - writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
> + writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
>         &reg->device_regs.out_endp[EP0_CON].doepdma);
>
>   setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl, DXEPCTL_EPENA);
> @@ -72,7 +72,7 @@ static inline void dwc2_ep0_complete_out(void)
>
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
>         &reg->device_regs.out_endp[EP0_CON].doeptsiz);
> - writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
> + writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
>         &reg->device_regs.out_endp[EP0_CON].doepdma);
>
>   setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl,
> DXEPCTL_EPENA | DXEPCTL_CNAK);
> @@ -107,7 +107,8 @@ static int setdma_rx(struct dwc2_ep *ep, struct
> dwc2_request *req)
>   (unsigned long) ep->dma_buf +
>   ROUND(ep->len, CONFIG_SYS_CACHELINE_SIZE));
>
> - writel(phys_to_bus((unsigned long)ep->dma_buf),
> &reg->device_regs.out_endp[ep_num].doepdma);
> + writel(dwc2_phys_to_bus((unsigned long)ep->dma_buf),
> +       &reg->device_regs.out_endp[ep_num].doepdma);
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
>         FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
>         &reg->device_regs.out_endp[ep_num].doeptsiz);
> @@ -152,7 +153,8 @@ static int setdma_tx(struct dwc2_ep *ep, struct
> dwc2_request *req)
>   /* Flush the endpoint's Tx FIFO */
>   dwc2_flush_tx_fifo(reg, ep->fifo_num);
>
> - writel(phys_to_bus((unsigned long)ep->dma_buf),
> &reg->device_regs.in_endp[ep_num].diepdma);
> + writel(dwc2_phys_to_bus((unsigned long)ep->dma_buf),
> +       &reg->device_regs.in_endp[ep_num].diepdma);
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
>         FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
>         &reg->device_regs.in_endp[ep_num].dieptsiz);
> @@ -913,7 +915,7 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
>     (unsigned long) usb_ctrl +
>     ROUND(sizeof(g_status), CONFIG_SYS_CACHELINE_SIZE));
>
> - writel(phys_to_bus(usb_ctrl_dma_addr),
> &reg->device_regs.in_endp[EP0_CON].diepdma);
> + writel(dwc2_phys_to_bus(usb_ctrl_dma_addr),
> &reg->device_regs.in_endp[EP0_CON].diepdma);
>   writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) |
> FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, 2),
>         &reg->device_regs.in_endp[EP0_CON].dieptsiz);
>
> --
> 2.54.0
