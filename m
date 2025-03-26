Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BC2C36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 01:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8F2810E8;
	Wed, 26 Mar 2025 02:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770048186D; Wed, 26 Mar 2025 02:26:12 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C658083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1742952338ts970h8
X-QQ-Originating-IP: 9pR4GzsEk8Q49/BG5vXDmgiCtbnBxSInKN80KheQ9J8=
Received: from [IPV6:240f:10b:7440:1:9157:8105 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Mar 2025 09:25:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16227297490792217465
Message-ID: <03D6E89096614725+95fe243a-7bc6-46f6-87cb-7dab45145985@radxa.com>
Date: Wed, 26 Mar 2025 10:25:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Enable usb gadget on Radxa ROCK 5C
To: Arnaud Patard <arnaud.patard@collabora.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>
References: <01020195cdc6e188-48dacf9c-cfa6-421c-aab3-61d989bc7c78-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <01020195cdc6e188-48dacf9c-cfa6-421c-aab3-61d989bc7c78-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NN51gi9eLBwa1uuct4QDpLjEEB6o8VM3xRIMUX82LtZYQUcDQWj5RaXi
 P3M6VxIB16bemlcIRzl/Kf8uD8Ry9iLplNGbs35ZGQc4W1rYraDMVLGDFow47YxjeDpAZqZ
 Zt5zJn5ZS2h+lixn6pnhWMINx9JFpTpS1HWGCdYysJqjhbQ+qEzpaD6lQgqD6wOFkcZb9O+
 o8WaOjGiATZfv9MArOEXNba0lq/iXLJ/oNIhO7bICPqAgJ4ypNpdak4EWDJ2TwdYz6ESbK+
 I1szrS8qzontT74YavQKASCus9gtBolEKkiFXCMGB0rWEXsX3wQIWB2Q6lGMnIyuXrgVuMx
 UaQ5XuVGzfDEydIo2wpiUkYOcHqHBFpnTM47rUhXeG15oa51t4A+GLvYjwTpHqpTjy5AAdw
 NqyOPO5sWFHFoZo/wMMoAvc03GUpaSpdVOIIh9znGaX08D7Th2qr+HnB2rf5dj3JQmRTUxf
 veVqrYvlqLig5PiK8fkkQlaEhroPENC/sy4DLBZFh+zLoxJvwZ3gSH6SxotWRZape0zrTlO
 /QYOYd/1IbVG+Z0tasWQm3Beh4pGjSdSHpRY0aFGu6hsD2SNG85VI4PDdKSS8oRHEtbvtam
 MFSNyvdCvjYsJ75xU6K32HlyGxZ/7OYDgGvAaVNBgrBBvRXSf344Gb/+YD/7evbOzoOblIX
 js1A9vBU9CMnUQ9Ssxe9KQTOzCETcGPL48HZIBmlPMHw3CvyC+HHJH3w/9waaM/er7SFcv8
 e7R1H6cXY/1A0ulPzK+rGaFL8SFnqFq8ub1m0HyXCatGw+c+LCQ6hdhIBWd0CyoHeJJQV6c
 53tayLTTcIZEVpP3Y4CGprysP3L4fPvDxeBzchZIqUS9p3/LVye1nzjvhYS22JCEjYauXuL
 h+7dZYwCUjOX/7GWrt56UF3rOvwp9jL398+k0pWa1+Q=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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

Hi Arnaud,

Basically, the Type-A OTG port of the Radxa ROCK series is intended to 
be used in HOST mode (unless there is a HOST/DEVICE switch).

That is why the following patch series does not include Radxa ROCK 4, 
5A, and 5C.

https://patchwork.ozlabs.org/project/uboot/list/?series=443764

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 3/25/25 23:48, Arnaud Patard wrote:
> I was testing DFU and SPL DFU [1] on my rock 5c. To get it working,
> I had to set the usb_host0_xhci node to peripheral and maximum speed
> to high speed, as done for other rk3588 devices.
> 
> For DFU (and not SPL DFU), I had to set the "maximum-speed" property on the
> usbdp_phy0 node, otherwise it's failing:
> => dfu 0 ram 0
> rockchip_udphy phy@fed80000: cmn ana lcpll lock timeout
> rockchip_udphy phy@fed80000: failed to init usbdp combophy
> rockchip_udphy phy@fed80000: PHY: Failed to init phy@fed80000: -110.
> rockchip_udphy phy@fed80000: cmn ana lcpll lock timeout
> rockchip_udphy phy@fed80000: failed to init usbdp combophy
> rockchip_udphy phy@fed80000: PHY: Failed to init phy@fed80000: -110.
> No USB device found
> udc_device_get_by_index failed
> 
> The issue is that it's trying to configure the usb3 phy, which is not
> the one used for peripheral mode. I've not checked on other rk3588 devices
> if they would need a similar change.
> 
> [1] for SPL DFU, I've used the serie https://patchwork.ozlabs.org/project/uboot/list/?series=443761
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> ---
>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> index 1dc574c2f21..54b0f914010 100644
> --- a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> @@ -9,3 +9,15 @@
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
>   };
> +
> +&usb_host0_xhci {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +};
> +
> +&usbdp_phy0 {
> +	bootph-all;
> +	maximum-speed = "high-speed";
> +};

