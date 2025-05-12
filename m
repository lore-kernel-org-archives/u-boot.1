Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6274AC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 07:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5675805D7;
	Mon, 12 May 2025 09:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cEUjASYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF62281DD6; Mon, 12 May 2025 09:08:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E74D800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C2D20445FA;
 Mon, 12 May 2025 07:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9076C4CEE7;
 Mon, 12 May 2025 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747033718;
 bh=JwLc1fjGHu5hyq4vg9rn1WW4F+HGZkZyMzOZnt+nrh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cEUjASYV8CM/SH56coFZ0kkU7vP/gScOUGRUX8nAwTOJvIy8NZ+NoMeoaeRGaS0ho
 QAlHoK95Ev4ru39Gyk+z62CcLNgM5rVfWZ6cwfLsUG3FWg4L5cy8IJgag6IQmCpo/d
 08DnUYUyGxcfpIiV2ovoAOJ1L3aoyB3/AJQTeTOBQ5i6fom0SOnJKeV07I/Y0K2ht/
 5fC1vqS1niw2s0NketxgzyN2q+K2uod9feUONXr3sH1EGxapfiIllgpS1Y4rDyO2uI
 gTnfu/+qLtG6zD+ilaw+WRwn/gGHtpj7wXL/XDyNWpv7XwI4uQW94IFhNYiPlbAnWf
 Jx8VSjE8dCy1A==
Date: Mon, 12 May 2025 12:38:30 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 ilias.apalodimas@linaro.org, me@samcday.com, sjg@chromium.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 1/6] dt-bindings: power: rpmpd: Add QCS8300 Power
 Domain Indexes
Message-ID: <aCGebjL9ZGjsMV5e@sumit-X1>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-2-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508111952.2304578-2-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On Thu, May 08, 2025 at 04:49:47PM +0530, Balaji Selvanathan wrote:
> Added QCS8300 Power Domain Indexes in dt-bindings/power/qcom-rpmhpd.h
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  .../include/dt-bindings/power/qcom-rpmpd.h    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h b/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h
> index df599bf4622..50291f918c2 100644
> --- a/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h

Please don't directly patch dts/upstream subtree. Rather you should
follow documentation here [1] as to how you can cherry pick patches from
upstream dt-rebasing tree.

Also, are these DT bindings header changes posted in Linux kernel
upstream?

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit

> @@ -4,6 +4,25 @@
>  #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  
> +/* QCS8300 Power Domain Indexes */
> +#define QCS8300_CX	0
> +#define QCS8300_CX_AO	1
> +#define QCS8300_DDR	2
> +#define QCS8300_EBI	3
> +#define QCS8300_GFX	4
> +#define QCS8300_LCX	5
> +#define QCS8300_LMX	6
> +#define QCS8300_MMCX	7
> +#define QCS8300_MMCX_AO	8
> +#define QCS8300_MSS	9
> +#define QCS8300_MX	10
> +#define QCS8300_MX_AO	11
> +#define QCS8300_MXC	12
> +#define QCS8300_MXC_AO	13
> +#define QCS8300_NSP0	14
> +#define QCS8300_NSP1	15
> +#define QCS8300_XO	16
> +
>  /* SA8775P Power Domain Indexes */
>  #define SA8775P_CX	0
>  #define SA8775P_CX_AO	1
> -- 
> 2.34.1
> 
