Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA99F34C43
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D35839DF;
	Mon, 13 Apr 2026 13:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DgztNqcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFFE83DC9; Mon, 13 Apr 2026 13:51:11 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B22B839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so40791625e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776081067; x=1776685867; darn=lists.denx.de;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19jN+7p+xWZF/QyrrHJVAF+8UmAsFmBAkjP4V3NCgXA=;
 b=DgztNqcCRmJKnQVcljA2gYrMP4VaFUcDYFKpkRkPNYWqoR1dBVAW5WGc1ZibqhuDI1
 f0dNzccluU6OZV86n9HEufr+GjNhOcBDiPEBVjdxa5lUt7/Acioy26zDUiWbkd9hjFES
 g7qO/2cZIt6/PGl9VfsF5OHICK3qaZrO6GWcJc2pA6ZA2lt6xWXcAFtP2uNW5BL/K7Al
 PzvyZR3rmOYbK3DDbeV1LvjFjWc4sOn99VZU4h8HVumn/NI3UFAUw4Dbinn0TRDQd5Nx
 Kw36+7gz338Wq7Qqq2wPPIiwKHwHforu081Ej6ptHbFgJgoDgQ3IUIybk4Fy3YsH+jIb
 bXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776081067; x=1776685867;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19jN+7p+xWZF/QyrrHJVAF+8UmAsFmBAkjP4V3NCgXA=;
 b=tBebcwn6tXjeRJZeG9OyidI/KK8GL4kXNKtHrl590uuNmkVWL56VRyHXBLSEPUHgZD
 M4q/DtHr6cjvTU/hEwtgWz4rKLackfJF7LfEmk/M1zXpAwnw6y3bUJPbUhh/0wzkkKt6
 xJSPqoO8jEXIe8gBsTH/irCg3wMSFDXQLOcIpDO84TILcU0OzmhpUS4n59JiOfHby/jN
 jvk7keq6GWG3Nk6blYlF3pnu92iBvkpkPmLu8nDxmWy1gkg/vollYUeEHODgs0OVIAn4
 SMiBSVCQad7ZUYV1gerzZjOPHTmeLsdmRV0ylzc7jWXJeGYMtzH5ySpJ4QvA4hgGEn3G
 TGtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3JfeZCGt4vepmQCLjheCmScGgxR1fjkLnhv/lu+/UekPxfDL4rFFtXf+sII7z5iu64tYUwp8=@lists.denx.de
X-Gm-Message-State: AOJu0YwrCtG/vru//fUoWGmN5iF2VXTgfzvinKxS/Mws9iidYAM/F+3b
 SjZi2k4cyCThVXhafgLONkP+7/UBQMnnowpyFLFEon+80xP91l6D8nrSnPiOMV9Hilg=
X-Gm-Gg: AeBDieuAKrxRIn+K70FFheJfZe2HJ7OGCEAYStDQFJF1T/xq8XHuFWTMKEMnIINfssx
 /rvoq5HDVMliIkQB3RzDbDYVUbJPiRngq4RTYXkyYncsox4EbylqkvbNuamzFTQjFVdNtXceoLZ
 DICZUKnEvlhAsLgGjG7GLuquvfyDU1GVh2YYDtinJ59VIujXjEB0mhueZ8gNRMBKOwT5/H91UGL
 E6vAOFDFhXHjuv0fn8cjFTUMWdzAjI6cnthI4YnispwciHOUYf7RKce/qBVupdWTHdc9Di4a4qG
 ixbaS91GKIKRqyfWQeQtYabiyTof02DupqhS1KBOMJemDLOS/lNTwtmi52+RE7+A0eM7rwEXUhE
 2+aQWyoHbKfCiO5mXjIDFXpkn0dlNd1yi6sTEJOqOE4lf3MDHfuTXVXiLcglBX31KiAVadpZnQB
 kIAbXJw6xPy5y477vtySzG99znPYkZ65BwcBNSIT4v75d1aWuA9iCXZ9HE1LRgJrw9AZdY
X-Received: by 2002:a05:600c:c088:b0:486:f4d2:eac6 with SMTP id
 5b1f17b1804b1-488d67e6776mr125451375e9.13.1776081067405; 
 Mon, 13 Apr 2026 04:51:07 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5380feesm359094895e9.9.2026.04.13.04.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:51:06 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] arm: dts: qcs615-ride: Remove unsupported USB
 clock reference
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 alexeymin@postmarketos.org, nathbappai@gmail.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
In-Reply-To: <20260120042551.650113-2-balaji.selvanathan@oss.qualcomm.com>
References: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
 <20260120042551.650113-2-balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 13:51:05 +0200
Message-Id: <177608106538.1177412.2919192265950107035.b4-reply@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=y2nS+eQbmfvX7G/n5W1DcArMOGmK5CgbosKfMRntRPA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw7N1a9OP1nSf3+KazHL6hum3z21mGn+KpS913tCdFrD
 X+wzTuk3VHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmwj+FkWGpd0LO/Yep+2rv
 FTq7K15Wvdi5qbdO9F9b9M3ZHJekHxgw/A9nndOwwk6Xsb2rTnV/WbieziYxDeaPu7aJrCm7t2z
 lQy8A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

On 2026-01-20 09:55 +0530, Balaji Selvanathan wrote:
> Remove GCC_USB3_PRIM_CLKREF_CLK from the USB controller node as it is
> not implemented in the U-Boot clock driver. Keep only the supported
> clocks to avoid clock warnings during boot.

Can't you just add fixed rates for these clocks to the driver?

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> index 68fffc70fcb..d8af124cc27 100644
> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,18 @@
>  		      <0x0 0xc0000000 0x0 0xc0000000>,
>  		      <0x1 0x80000000 0x1 0x00000000>;
>  	};
> +	soc@0 {
> +		/* Remove GCC_USB3_PRIM_CLKREF_CLK from usb_1 node to avoid U-Boot clock warnings */
> +		usb_1: usb@a6f8800 {
> +			/delete-property/ clocks;
> +			/delete-property/ clock-names;
> +			/* Keep only the clocks that are implemented in U-Boot clock driver */
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
> +		};
> +	};
>  };
> -- 
> 2.34.1
> 
> 


