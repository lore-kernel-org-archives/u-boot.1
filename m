Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025CCDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 16:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA0887798;
	Sun, 22 Oct 2023 18:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iNuzIC3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FDC8779D; Sun, 22 Oct 2023 18:44:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB95C87560
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 18:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697993085; x=1698597885; i=xypron.glpk@gmx.de;
 bh=aYvcv1ghS0dA6emrPJSQQShTe71iSO9OCv9wTGxEBYY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=iNuzIC3rFYARKkrYndM0Lr/j4ZrQ9+Vd6dkjqyayCL6UvQxthADG/q7XF5fybeig
 Ezfu0eiLoAl4fHZwF106qOcS2FetIpDRCwKL27MuIR4pOUKW/uUKYCs3WZdgGTodI
 0ndTnp1bOIYXhiDRVday5nMAppkd+aBozxxUShduPL2e6sAfzrWzn/tQgr0HNGZ+P
 J5JUc7evxgcAtmqjZ5PWRHP0qiZ6XxJYS4wOyw71szh7bZ8pfX43RCihqsvOGlzHD
 llWFCBNSnezwyGR4z1Zf3XsWPJyllnW4sWrwAcfE/1Tgk6Ql5Okw6BRBIY7VED20J
 nMCh7ZvPZZv74RF3AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1qqSpb3wY7-005KJP; Sun, 22
 Oct 2023 18:44:45 +0200
Message-ID: <0221ec2c-c691-4b7f-8ee3-89dc5fc8c14f@gmx.de>
Date: Sun, 22 Oct 2023 18:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iot2050: Allow for more than 1 USB storage device
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Le Jin <le.jin@siemens.com>
References: <d1d6efbd-32f7-40e2-8c20-8eac06bd6075@siemens.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <d1d6efbd-32f7-40e2-8c20-8eac06bd6075@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p1g/WDQzXiKoHLPgsvNxp+igbfHfChYHRJmrkXjS1pX1lcQOfPF
 aPnLl7cl76qvF4ire4JEsxvEB55KSxT+LMO48oGrQyVMCuCpbO/YHfREQ+3wrj4AZeC87Iy
 Rqkge9ua4U9BmpiDmb+3Ob6W5ElzeEE64NtiFJ45uokBVR+P04OE+tWObIHK0ePZhT2LWpu
 8Lyhj3m0hvaD8E0oLoVZw==
UI-OutboundReport: notjunk:1;M01:P0:xlTQXs94X6A=;tiADJYdzRJ1OjQvJTqE8v8Q42JW
 ERe4tvxsyVD3m6HbKiXP2fw5a/d42lKTmkEik1F23Qsg9mndXTDHoPWQz4k3Gu3s6g4uJk2yu
 8WKFuTDV1t6CdNMVzJaeTtSKC3KhDQvoqfsDhNlK2Pn7Ii8aCLcWO/rreX2tsekwFOvl+W2A4
 vGeeWehyYrwXK05CNAGqhO4HWgAnptkEf8GYpOljKcPFkQrpA3iqmsiqFZlncM4/GxG1H/VNr
 ZaIix7T7ZtVYL7QbKzfF1BT4mMkZDr97KIeOXJbX7bdNbagoF1sTrfxkYYC3xz0J9H5ZKN8c7
 bby3m3H4pK0GHLKcl+8N+JhiWqN/7PSJxYJhYrSr/HgIIVbXmtrU1qYJPyRonvs0/sHYvdEPk
 KQcg8gc98M7j2WQReO+brwRZfUf7obUApfdRrpbwCHLFK9fzh3to0PNyQiNgg9FJJqD9fVOO8
 sjSG8daB5WyW3Ehb/z5YOraVIiGLUloOAuIPf6T2UcBKEww6P4hKrPddtw6L871LbVM/cEtAg
 cG7piJMNawQVhv2ltiIVmrkE4TeW0P1i7IKIPjRNXjRDL+dptKU/fWc01fKsdOm+n/gUzqf3T
 juJiNzqpaWWKRV5LRq8fI+86xIzp7RYSX5LYLEI0c0dV+LbzIFQZn62SWedFmcdiHp+GXenNj
 PFwuPi5Y8wK/MgwrBiSmtl343mDsvhOe8ik+4uGvtKXiPUX+JNQ9BiCtek3ZCD4yezU9Kslq8
 90YZs0caVltWbI31pFVcWXAXgkFQCV0/quvH6Ug47rNOp8RWPczc8mXzMjYgXMB7/wWfYt3sr
 fV6Fj35x5ZoW6aAdHnNfQ/dwhG7l60Xr9YoQuql2TISyQpdmg9bYxBEMwEbr++aGvzK7MVl9y
 CiGL7Yd9A/LFBmTUMGqUXxUd7kTJ4PU3IzE6HT7t59NpYIS4yse9E+ONbcMiUF+TskjhNEsqu
 vLDfJlDkbUr9EWh0Jgj65zQ8Neg=
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

On 10/22/23 17:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This was lost via 53873974a4b0 while some users of the IOT2050 expect it
> to work: Make sure that up to 3 USB storage devices are probed.
>

Fixes: 53873974a4b0 ("include: armv7: Enable distroboot across all configs=
")

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   include/configs/iot2050.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
> index 4968722d18f..1d444d02c83 100644
> --- a/include/configs/iot2050.h
> +++ b/include/configs/iot2050.h
> @@ -15,6 +15,15 @@
>
>   #include <configs/ti_armv7_common.h>
>
> +/* allow up to 3 USB storage devcies */

%s/devcies/devices/

Otherwise looks good to me.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +#ifdef CONFIG_CMD_USB
> +#undef BOOT_TARGET_USB
> +#define BOOT_TARGET_USB(func) \
> +	func(USB, usb, 0) \
> +	func(USB, usb, 1) \
> +	func(USB, usb, 2)
> +#endif
> +
>   /*
>    * This defines all MMC devices, even if the basic variant has no mmc1=
.
>    * The non-supported device will be removed from the boot targets duri=
ng

