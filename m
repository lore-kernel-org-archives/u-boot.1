Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321C1FED2DD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A4983F6D;
	Thu, 12 Mar 2026 08:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OMOov/Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6289784099; Thu, 12 Mar 2026 08:51:13 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C0683952
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A8006057A;
 Thu, 12 Mar 2026 07:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD9FC19424;
 Thu, 12 Mar 2026 07:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301870;
 bh=pUF/qCo5dWF6F3DdL8W7OzRxHxRjUdujLXxSHFiK23Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OMOov/Sb32CzxjqsELQcQA6TKOKBeJYiNntMaHcTjc7OJccxZLTBLaPIcBN8WH9cB
 0zEwsApJ/yUOAw95NwOtm9Yq84rhrpKljNEEoRIBNVUw3I4AqFXwi+yV2N54/hJ200
 B/ZQMiMFhCM8b9a4SAjQNf29vddNFWHCyKgoJrFCdafjoH+086OWmTN8OIo9y7Dfts
 0PQWOOqLyYY621zvyM1tEw9J9rrZOBBEmae0nVxlQ4zJzdPyM/A5yHRwKfVSrbYdK/
 9ji0ORVWva6hbzSdzs1mxdE1f3mB6YjDwqk5jsG72V67DmUoQEi6XTt6ycIDAtr2/j
 ygIMuNqwVOuUg==
Date: Thu, 12 Mar 2026 13:21:01 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 7/7] board/qualcomm: add debug config fragment for Milos
Message-ID: <abJwZcs72KwimAMl@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-7-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-7-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:47PM +0100, Luca Weiss wrote:
> Add a fragment similar to others to enable earlycon.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  board/qualcomm/debug-milos.config | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/board/qualcomm/debug-milos.config b/board/qualcomm/debug-milos.config
> new file mode 100644
> index 00000000000..a4cdd13f226
> --- /dev/null
> +++ b/board/qualcomm/debug-milos.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xa94000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> 
> -- 
> 2.53.0
> 
