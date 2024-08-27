Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517ECC54735
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 10:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695E88857C;
	Tue, 27 Aug 2024 12:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="BPziHeUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413BF88905; Tue, 27 Aug 2024 12:21:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F13A881A2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1724754079; x=1725358879; i=smoch@web.de;
 bh=vLIxIR47jYP1BCwEEJJHitjVvNc5EonF1JEB0gG3H0Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BPziHeUQ+WCHVY2xxePVF4cvm2aV9BljpXDKfyx6560csRDZkIs1eOSO4/ap+PAQ
 O3Nzaov/Ns/fDXt8ZK7LU+nrQ+EGrGGIOvbgfxozESAfmDQPAkMJKaIEsmyaaqfRi
 FgG+7i1U0BJ5z3nR3GmurrO+h26/PEDTKeI7jf1VrUFasz1NnIiNzFV1Wy1zL4pOH
 r3Zcgm2aNelYwELo8B+/rWko/K4lkd7dtFG61lziWTcwogApJ77pg1kYJdWBPTUEy
 cGhUh4Sy1mpjWdjWvKHvJVNBWGqIxDsycgVxOIZ4rzgMYBOwp6L8xA/fKMoGg8E9Q
 u5OlEH0CjPhcjVsi7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([77.191.44.80]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1s14LU0RQh-00roiP; Tue, 27
 Aug 2024 12:21:19 +0200
Message-ID: <3f6f162e-7083-4ad9-984e-61e449e68b21@web.de>
Date: Tue, 27 Aug 2024 12:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] imx: Remove CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
References: <20240827005826.2831478-1-festevam@gmail.com>
 <20240827005826.2831478-3-festevam@gmail.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240827005826.2831478-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yoii1jVd2zETtaYxjA6/QIzmkQQO5oGPYl5H5zJFpF4rDZ9y+H3
 CPu0g6lHdojpgtWvZ1SN5v0QF7ieywr1cRHozelcB00HwG1s7Y8A+nQpYOdynZHWT2TzySc
 2/FpQR8obznbgxgIWoRIn/u9CTEfdDdA1mgbIutEgvCC5M2XtoD9Pv4OELBImCLFm8C3XGI
 bU1F+o6H+qcVRPwpEDieg==
UI-OutboundReport: notjunk:1;M01:P0:lElLSvkS6tk=;7xo6ZpGDhgj1AIElzSNhaWKIbeV
 AVSBiSFmfrdTDrqGTxc4fTkXT9PtGoVnxIyeTnCv7oAlFUIT6q/ecXkCcF3Q+XNUm1jdUD7zu
 Z6Hlb5WaYc6tm/XSOerHq1NpHdqQgsTm1sAM2MZO8W/+fjh5akftC9WqgTGYYYBb+/gwTCzsi
 a3xiwDK++fKGWGCAlPYDBI+HJ/5qO9MQnqZ1BMldgG4/elNTsEXi3Ax4gH1fpnAeeovjBOt1p
 hY+e3VY6BEF2FqWx0ey6CbPII6iya/bPQcBLSJXB5KXJtri3BX7cglQZ0K09eTPDJ5mrKMIhz
 DLdWU4p3Q5gPjRCm8f3HRaQinso/bfXNBXSIy5/vN7caPbNNVGVBSvc1D0DKHzZxcFVnyfT01
 Xj5sN7sX6245rsjMSTePR7uv6iDowb7CyN38QN1zLOQeWp5kWP9rosUL5AfZqSWWn/qlSMzyo
 64xKzmrFZOebKLSFSR+LqjG+KcdrHeqRB9RgI0P51wiHOblHyvfE8DHovGQFLpqm41MAWeIR5
 rlDKaJJREivLUx1xyQqQSpIIenOlIkxKaCNaU7ZjtB/JzCLfB3ztiOOsmZoya5E9vOGENaAVg
 AwBJdEtZmEL/0hd4ZNNQiMkYlMu3skw/FW4nSg/XBOXnuTB5o6EyK+6JORGe07I0C4GtXEU2A
 F4cPEaVkCd6c6iUgvI6TcP4zAt5WI84UHP8/ufCqFoLMF4Kaf79T9DoFgEuuN0oBO4SzMdEUr
 cLsAoo/Q5L259LmY/FJ6riEcWPZYduZEKFqN/QB4y6t4Onniv8Yl94hxqmIk5YYvnCcXHKaOQ
 oKyvRYGKaMuHJN0Ub9HB820g==
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

Hi Fabio,

On 27.08.24 02:58, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>
> '#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
> be removed from mx5/mx6/mx7/mx8m board config files as it is the
> default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.
>
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   include/configs/apalis_imx6.h            | 1 -
>   include/configs/aristainetos2.h          | 1 -
>   include/configs/brppt2.h                 | 1 -
>   include/configs/cl-som-imx7.h            | 1 -
>   include/configs/cm_fx6.h                 | 1 -
>   include/configs/colibri-imx6ull.h        | 1 -
>   include/configs/colibri_imx6.h           | 1 -
>   include/configs/colibri_imx7.h           | 1 -
>   include/configs/dart_6ul.h               | 1 -
>   include/configs/dh_imx6.h                | 1 -
>   include/configs/display5.h               | 1 -
>   include/configs/embestmx6boards.h        | 1 -
>   include/configs/ge_b1x5v2.h              | 1 -
>   include/configs/gw_ventana.h             | 1 -
>   include/configs/imx6_logic.h             | 1 -
>   include/configs/imx6dl-mamoj.h           | 1 -
>   include/configs/imx6q-bosch-acc.h        | 1 -
>   include/configs/imx7-cm.h                | 1 -
>   include/configs/imx8mm-cl-iot-gate.h     | 1 -
>   include/configs/kontron-sl-mx6ul.h       | 1 -
>   include/configs/kontron-sl-mx8mm.h       | 1 -
>   include/configs/kp_imx53.h               | 1 -
>   include/configs/kp_imx6q_tpc.h           | 1 -
>   include/configs/liteboard.h              | 1 -
>   include/configs/m53menlo.h               | 1 -
>   include/configs/meerkat96.h              | 1 -
>   include/configs/mx53cx9020.h             | 1 -
>   include/configs/mx53loco.h               | 1 -
>   include/configs/mx53ppd.h                | 1 -
>   include/configs/mx6cuboxi.h              | 1 -
>   include/configs/mx6memcal.h              | 1 -
>   include/configs/mx6sabreauto.h           | 1 -
>   include/configs/mx6sabresd.h             | 1 -
>   include/configs/mx6slevk.h               | 1 -
>   include/configs/mx6sllevk.h              | 1 -
>   include/configs/mx6sxsabreauto.h         | 1 -
>   include/configs/mx6sxsabresd.h           | 1 -
>   include/configs/mx6ul_14x14_evk.h        | 1 -
>   include/configs/mx7dsabresd.h            | 1 -
>   include/configs/mx7ulp_com.h             | 1 -
>   include/configs/mys_6ulx.h               | 1 -
>   include/configs/nitrogen6x.h             | 1 -
>   include/configs/novena.h                 | 1 -
>   include/configs/npi_imx6ull.h            | 1 -
>   include/configs/o4-imx6ull-nano.h        | 1 -
>   include/configs/opos6uldev.h             | 1 -
>   include/configs/pcl063.h                 | 1 -
>   include/configs/pcl063_ull.h             | 1 -
>   include/configs/pico-imx6.h              | 1 -
>   include/configs/pico-imx6ul.h            | 1 -
>   include/configs/pico-imx7d.h             | 1 -
>   include/configs/somlabs_visionsom_6ull.h | 1 -
>   include/configs/tbs2910.h                | 1 -
>   include/configs/tqma6.h                  | 1 -
>   include/configs/usbarmory.h              | 1 -
>   include/configs/verdin-imx8mm.h          | 1 -
>   include/configs/vining_2000.h            | 1 -
>   include/configs/wandboard.h              | 1 -
>   include/configs/warp7.h                  | 1 -
>   include/configs/xpress.h                 | 1 -
>   60 files changed, 60 deletions(-)

[...]


> diff --git a/include/configs/tbs2910.h b/include/configs/tbs2910.h
> index 256331ae1733..eb5fdae0ea86 100644
> --- a/include/configs/tbs2910.h
> +++ b/include/configs/tbs2910.h
> @@ -27,7 +27,6 @@
>
>   /* USB */
>   #ifdef CONFIG_CMD_USB
> -#define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
>   #endif /* CONFIG_CMD_USB      */
>
>   #define CFG_EXTRA_ENV_SETTINGS \

Can you please also remove the now useless comment and empty #ifdef
block!?

I have not checked in detail, but the same occurs also for other boards
in this patch.

Thanks,
Soeren
