Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D43DCF9C41
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B70388B63;
	Fri, 20 Sep 2024 17:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YHmK3nOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC0588C10; Fri, 20 Sep 2024 17:09:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D7688A9D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=79c3=QT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726844942;
 bh=kGgbjsqXNm1h5wR2ZQFWbgXErFxjxC6f32jeevjUKkU=;
 b=YHmK3nOgJ14sv780Wiqq0xN2D12Wd8ifUHxOP0Bb/TmJlkR+lymJXi9vsCxzsOH+RLvAfJg5k
 qfPW4WX34nkWbVXcNfXM+pdnBWxHMUUkk7vqVtzYkiscj0XPFBIf2N3i6Wj5+ozFeI6rUjSOiNA
 us32MzOZSs9M9+JRIqt/2TraCA/Bt8qUHN6pDTryCG5ffwoGBilUfMGvk71QujszIBVmFmZTdz8
 xsvYZfvGPreMJBQUtGc31FBW0Mg7+hBuQ0eep8Oacm+LwVGmJY2o+WC4V6pqqsRDqGSXNn6vfbl
 gVyuuGJtxWozI4LsNj4qD6wF70rPqT3ubbD3+NvWdGgg==
Message-ID: <538c3d08-4426-4981-bf78-b906a92516e8@kwiboo.se>
Date: Fri, 20 Sep 2024 17:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] rockchip: Provided SPL control over efuse
 presence
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, u-boot@lists.denx.de
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-19-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240920072444.134997-19-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ed900bf21c75f5e64c8ada
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

On 2024-09-20 09:24, Simon Glass wrote:
> This driver should not generally be present in SPL, even if misc devices
> are enabled. Update the Makefile rule accordingly.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/misc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e53d52c47b3..ff984d7b191 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,7 +68,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
>  obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
>  obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
>  endif
> -obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
> +obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) += rockchip-efuse.o
>  obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o

Please also include similar change for ROCKCHIP_OTP, the EFUSE and OTP
drivers provide same functionality, just for different Rockchip SoCs.

Regards,
Jonas

>  obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
>  obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o

