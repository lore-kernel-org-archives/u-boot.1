Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3158ECCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C871E8148B;
	Fri, 16 Oct 2026 12:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpY_ajQNBV3R; Fri, 16 Oct 2026 12:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F7B58146D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153553;
	b=WjBunLh33V72k57xPXEdg52Rm27MX9FE1rVA3schX87s84VkPedRq0RvZR7YYXosesjq
	 10T62I+aruG7bwivBqmm/4M7qEn7n+5x4FE4N3HHnCu+iIthT4gpKhx49Q4E4zna0uOnY
	 mhoO/R9JfDWBZleGCLdaITzVEZCAJdSXZQNZaVajPt/E5Wf0hDfUuTt0kcR/8dehYcVDJ
	 zFoSfIdzE3Edf0mNwsWYklHgSauLODBMITM0hWrkJEbQTKXzRx1WmMjSIEfBH6C6oY71L
	 IEcn17akyIOQlpUemKppYph10pzR1w9lVBRI2njnsL5k0DwCJam0SXzKsVQo781rBVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792153553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aevuP6f9FFmXsEyQcOgi4It2Ni2eaU3y00A2mX/9E4Q=;
	b=jPl09taI7e3qR8xU79893KzsmKVtdfn5UK5UCyPCE/gz1LmgmGrbn8o24kWYLL0TSEq6
	 qhOsF1XoR4Jpd41BFrmGEZj/WIXLAuTh6VFNn0Z3g0ClSgwodnYyiGxLjhoXezQIBkfpB
	 2XAFI9+04ts+kXTGYsVppbJ13VxE+9Ae/mhYbQr4XffI3w8KS9vtGMOD2wOIpRdBPoLAR
	 1AZ0vkSKb3zqAfj8vPUxn8KPzmTsO10+69jGWpTen3HDsSo51DYtpD4r3PEIcp/1BjmM4
	 ZJ71Q2e+XS/usCnG4bm72jA1uQQByQSadjn8ucHns7c04kYB9MNz7UpzJbLahlr+IXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792153553;
	bh=aevuP6f9FFmXsEyQcOgi4It2Ni2eaU3y00A2mX/9E4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZPoJqXu3mmx5x/y5UKEwGJGUqfvoLTadvcesVqPzQod5ZlVZrWppH167IgoW2qJs
	 CQ4JsJQxgc+onDETB2QvYHdfHnUP3UGYBLk7/E0sZL7vvx2cUCZwnqMcRYA0an8TRS
	 n2qbQwmnGoSwJraQh3YW+WQLL6A8F+Llz9TqjnuM4DQYmNVAujN06ZgKdJfiWfBbSR
	 sca+1VhOdwt+QTnawLG2cW4q06i/rETevvfMcCwDuebSr75b+ZWP+wg7dfZmtqqeY3
	 9DBTfKaAq/nacUWe+Y8Ga+oFPgShKmNN5mXBNl3wcMFeqngtGYErwabGle9glmZ4V0
	 RIixsVLKL6hdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F7B58146D;
	Fri, 16 Oct 2026 12:25:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F6C255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CDC66080C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lN8aEHn-DF6Z for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 511F4607E8
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792153551;
 b=KcPxJFE4BqsjLsZCv9qXVrlVJSxEEGAxK0n/1k4J+GWbdqHmkhliVxtd4X+9BpyPvKAV
 DW1pQgjKGCfeyQP0pZlF07C4LPamC/H4NITgv5TsnHqdnFxnr/GLgvgYF/QCPwt7D8nZb
 VYcLIO6bp338MIx56M5lWhzPSaWIJyOACM2tXXC77AyF71dAs/7ERLMZjMoHTjIY40AIx
 VldRo01amr/wg1WY3yzYH59Un6ijegMMEayFr6zIK0LVQ52AYJdWlSlzQHA0615VrO8kH
 lqtTYBfQaRI/jMf8ZFJKylhH897lIQGVCdPGeO6YrCR7yBxY/dKqwHFsEMpK3w6gNiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153551;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=aevuP6f9FFmXsEyQcOgi4It2Ni2eaU3y00A2mX/9E4Q=;
 b=njLLCHW/GU+nTHJoBwDbBC1k+S439djJYHdClUF9JoclasibyZGDGVb+0CamwCicrZHI
 oNA6R5IKIVn5s+H2sYvc4SNxDC71JB+TD0wUQpn3KfHplqbi9haRTXMBk86Pjqx5bjnhb
 NgyaZucO8vaAyFGFUsIiBOsKK3lLwO3rFEDVjMIugmtjaCX/MdagzBQZQuMJb0jTl/EJo
 ETEA3xuU+IwbXrZuUSaTGW+Bo/i24LRaXWbdbvoCMSSMc0xdGFDAwRwhLnOzZRVPFMz2Q
 ONQCdVMrgmSfD3s0NuroyEsKpyGLXJs3ehvpNeA44ZzCRORZbCsM4FmrztWo9lAY7dg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OYhfVhQc; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OYhfVhQc
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 511F4607E8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:25:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BF4640478;
 Fri, 16 Oct 2026 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9760F1F000C4;
 Fri, 16 Oct 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792153550;
 bh=aevuP6f9FFmXsEyQcOgi4It2Ni2eaU3y00A2mX/9E4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OYhfVhQcTmSEMwgNb3hG7vECsJ86IOOBehByHJCLiq2QWNT+LWF2z+dcD+gWPtDoZ
 2rSnT22DYTKc3hlpjIpjY0rm51JbV8vFp3N7WVeDAm97RZ20ul67Fx+Jzj+UmSrs1l
 bG5LCMPcdiOoAsZkOJtgeXhb1dPTKxO/L6h9zoKuyDQICDN4Da24GWZ+ag15H1aNYu
 Hz4cDVM+0Ohc5+1Q7nfrzEagq92q1spfP2lmXVEpG94gxoTLehDmqErxOkGg7LyR8b
 lhHUuXE4ea3Hi/HAKQPmySf0XeJC7YF3GcykHfWPv9F4egIPiTnPludrGH/n/yyfpx
 eCZGbMvkeCruA==
Date: Fri, 16 Oct 2026 17:55:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v4] misc: qcom_geni: fix RX_RFR_WATERMARK to use RX FIFO
 depth, not width
Message-ID: <atIXyNvHWVl2mXn4@sumit-xelite>
References: <20261014-geni-rx-rfr-watermark-fix-v4-1-2902fb3f953e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261014-geni-rx-rfr-watermark-fix-v4-1-2902fb3f953e@oss.qualcomm.com>
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

On Wed, 14 Oct 2026 at 21:37:30 +0530, Vandhiadevan Karunamoorthy wrote:
>load_se_firmware() derives the RX_RFR_WATERMARK value from
>QUPV3_SE_HW_PARAM_1 using RX_FIFO_WIDTH_BIT/RX_FIFO_WIDTH_MASK, which
>decode the RX FIFO element width (bits per FIFO word), not its depth
>(number of entries). The watermark register expects a depth-based
>threshold, so this produces an incorrect watermark value and, on QUP
>HW versions >= 3.10 where the depth field widened to 8 bits for
>256-byte-deep FIFOs, an inconsistent one depending on core revision.
>
>This mirrors geni_i2c_get_tx_fifo_depth() in drivers/i2c/geni_i2c.c,
>which already reads SE_HW_PARAM_0 with the HW-version-gated
>TX_FIFO_DEPTH_MSK/TX_FIFO_DEPTH_MSK_256_BYTES masks for the same
>reason on the TX side.
>
>The same depth-vs-width distinction, and the HW-version gating for
>QUP HW >= 3.10, was introduced upstream in Linux by commit
>fe8aa1ba0783 ("soc: qcom: geni-se: Update Tx and Rx fifo depth based
>on QUP HW version"). The Linux driver this file's firmware-loading
>sequence was ported from, added by commit d4bf06592ad6 ("soc: qcom:
>geni-se: Add support to load QUP SE Firmware via Linux subsystem"),
>computes the RX_RFR_WATERMARK value via geni_se_get_rx_fifo_depth()
>which applies that same depth mask -- confirming this is a porting
>bug rather than an intentional difference.
>
>Extract the major/minor-gated mask selection into a new
>geni_se_fifo_depth_mask() helper in <soc/qcom/geni-se.h> instead of
>inlining it here, so that other GENI SE drivers (SPI, I2C, UART) can
>share it for their SE_HW_PARAM_0/1 TX/RX FIFO depth decoding instead of
>duplicating this logic.
>
>Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>---
>Changes in v4:
>- Include <linux/types.h> and <linux/bitops.h> in geni-se.h to make it self-contained
>- Make commit message generic, not SPI specific
>- Carry Reviewed-by from v1: https://lore.kernel.org/u-boot/20260824-geni-rx-rfr-watermark-fix-v1-1-d83fd078850f@oss.qualcomm.com/
>- Link to v3: https://lore.kernel.org/u-boot/20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com/

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>---
> drivers/misc/qcom_geni.c   |  9 +++++++--
> include/soc/qcom/geni-se.h | 27 +++++++++++++++++++++++++++
> 2 files changed, 34 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
>index a62ae6a2478..f3cf05c1c0b 100644
>--- a/drivers/misc/qcom_geni.c
>+++ b/drivers/misc/qcom_geni.c
>@@ -168,6 +168,7 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
> 	const u32 *fw_val_arr, *cfg_val_arr;
> 	const u8 *cfg_idx_arr;
> 	u32 i, reg_value, mask, ramn_cnt;
>+	u32 hw_version, rx_fifo_depth_mask;
> 	int ret;
>
> 	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
>@@ -207,8 +208,12 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
> 			       rsc->base + GENI_CFG_REG0 + (cfg_idx_arr[i] * sizeof(u32)));
>
> 	/* Configure condition for assertion of RX_RFR_WATERMARK condition. */
>-	reg_value = readl_relaxed(rsc->base + QUPV3_SE_HW_PARAM_1);
>-	mask = (reg_value >> RX_FIFO_WIDTH_BIT) & RX_FIFO_WIDTH_MASK;
>+	hw_version = readl_relaxed(rsc->wrapper_base + QUP_HW_VER_REG);
>+	rx_fifo_depth_mask = geni_se_fifo_depth_mask(hw_version, RX_FIFO_DEPTH_MSK_256_BYTES,
>+						     RX_FIFO_DEPTH_MSK);
>+
>+	reg_value = readl_relaxed(rsc->base + SE_HW_PARAM_1);
>+	mask = (reg_value & rx_fifo_depth_mask) >> RX_FIFO_DEPTH_SHFT;
> 	writel_relaxed(mask - 2, rsc->base + GENI_RX_RFR_WATERMARK_REG);
>
> 	/* Let hardware control CGC */
>diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
>index fc9a8e82cd8..8af78c3a61d 100644
>--- a/include/soc/qcom/geni-se.h
>+++ b/include/soc/qcom/geni-se.h
>@@ -6,6 +6,9 @@
> #ifndef _QCOM_GENI_SE
> #define _QCOM_GENI_SE
>
>+#include <linux/bitops.h>
>+#include <linux/types.h>
>+
> enum geni_se_xfer_mode {
> 	GENI_SE_INVALID,
> 	GENI_SE_FIFO,
>@@ -277,6 +280,30 @@ enum geni_se_protocol_type {
> #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
> #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
>
>+/*
>+ * geni_se_fifo_depth_mask() - Pick the TX/RX SE_HW_PARAM_x fifo depth mask
>+ * for a given QUP_HW_VER_REG value.
>+ * @hw_version: value read from QUP_HW_VER_REG
>+ * @depth_mask_256: mask to use on HW that supports 256-byte-deep fifos
>+ *                   (QUP HW version >= 3.10, 8-bit depth field)
>+ * @depth_mask: mask to use on older HW (6-bit depth field)
>+ *
>+ * QUP HW version >= 3.10 widened the fifo depth field in SE_HW_PARAM_0
>+ * (TX) and SE_HW_PARAM_1 (RX) from 6 bits to 8 bits; both fields are
>+ * gated by the same major/minor check.
>+ */
>+static inline u32 geni_se_fifo_depth_mask(u32 hw_version, u32 depth_mask_256,
>+					  u32 depth_mask)
>+{
>+	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
>+	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
>+
>+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
>+		return depth_mask_256;
>+
>+	return depth_mask;
>+}
>+
> /* QUP SE VERSION value for major number 2 and minor number 5 */
> #define QUP_SE_VERSION_2_5                  0x20050000
>
>
>---
>base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
>change-id: 20260821-geni-rx-rfr-watermark-fix-d48171a6541f
>
>Best regards,
>--
>Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>
