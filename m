Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B5C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 09:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E1B86F6E;
	Sun, 16 Jun 2024 11:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="l9CdZ/mI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F15E880CC; Sun, 16 Jun 2024 11:45:50 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B7A86784
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 11:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e15e=NS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718531138;
 bh=0Vo8NiKrfGz8X4di4jQtnmRezTf/B3mNrxgOR0iaWO0=;
 b=l9CdZ/mIpwZ6l9+8f2P3eW6sS8NZgAbBgwnpORN+YJvfvT7OymC8SAiFaInSD3G4aDM1fbrKs
 iDvlpMisIm5A75Ti12EFXfm+o5y+KuNpvCVltpyVUIGraMpLVpr/bUCxQ8B7jGunfyNmFEGZDtx
 KUy4R07VZG9DT0/5vFeL+Ua+UCbB90z5I+Hvr9LfJoxn5RU6fFkDvrnZuNKiuY0TkXXqd0VOy/U
 cyfrPWrxx0PeJkQy/7NqJgeimJZrnQnTQw0Wrsa9WIqSiNpDsztnso/iGQWhC/IE+MO/moaIBNw
 pdUoHIV9i4dUXcegHoBu5xPs714YHopRtKvEvuSyjwFw==
Message-ID: <ce5c5447-1b40-478e-9aea-34baefb14f4c@kwiboo.se>
Date: Sun, 16 Jun 2024 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: dts: rockchip: rock-5a: enable USB3 OTG port
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, eugen.hristev@collabora.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 gajjar04akash@gmail.com
References: <20240615074639.1686-1-naoki@radxa.com>
 <20240615074639.1686-2-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240615074639.1686-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666eb1c3b23880544d1fe9a3
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

On 2024-06-15 09:46, FUKAUMI Naoki wrote:
> enable USB3 OTG (upper) port for ums and rockusb commands on ROCK 5A.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index efba0c359b..5ae1a3cdd9 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -9,3 +9,19 @@
>  	cap-mmc-highspeed;
>  	mmc-hs200-1_8v;
>  };
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	status = "okay";
> +};

Instead of adding new nodes to the u-boot.dtsi-file, please pick related
commits for dts/upstream tree when possible and remove any merged nodes.

E.g do something like following:
- base on u-boot-rockchip-next-20240615
- run: dts/update-dts-subtree.sh pick c233f1327b04279454217b826ebf648bd4bc6b8f
- run: dts/update-dts-subtree.sh pick 402af187821d4e38a6c687e868b26ba22cb82886
- remove u2phy1/usbdp_phy1/usb_host1_xhci from rock-5b u-boot.dtsi
and instead include those commits in a v2 :-)

Related devicetree-rebasing commits:

arm64: dts: rockchip: add upper USB3 port to rock-5a:
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=c233f1327b04279454217b826ebf648bd4bc6b8f

arm64: dts: rockchip: add lower USB3 port to rock-5b
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/commit/?id=402af187821d4e38a6c687e868b26ba22cb82886

Regards,
Jonas
