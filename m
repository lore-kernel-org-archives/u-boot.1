Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D263C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 14:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087C78209F;
	Sun, 13 Apr 2025 16:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="o1z0m5f9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF790820E3; Sun, 13 Apr 2025 16:33:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474118004F
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 16:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744554825;
 bh=/rzmdFZHj11mnrecIfzEoyz2y4bxsjFsXpKqNWXXK5o=;
 b=o1z0m5f9cWX+lc2o44CEyBXvsDBzh/8Hu6IsMBbdcd1AtXEKjk2IZPDKYoHd4bE5Y2ljXqEtZ
 CP5oQ3bmUoiSY+Ylr/jivgr8AyUp9w3psbTKBIEG5kOUar7GJHkH63dyTwXr2puliEnZ2XB+s9N
 60f3S92bj17p7f4/18DRgdzRywQ/+xAv7xHmga+Wx2MZyOCCJv7tmeE1yt+h2qiQ6OgY8yj2x4g
 tSEwzTaR55KB6f4BxISALx2SORM45HjjuUXpxYSOJt0LXDDdCKl6O3KPQZKfA+R8oR8Y4+hMufD
 GkeYlSPMwL8tLRJtTVotKwc+qnmq9Q6GmuEyshcIWX6A==
X-Forward-Email-ID: 67fbcb3b7cfcd77aa7dc31e3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a496ff87-1030-44c0-8707-04af70208883@kwiboo.se>
Date: Sun, 13 Apr 2025 16:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] dts: rockchip: rk356x: Prerelocate VOP in U-Boot
 proper
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Piotr Zalewski <pZ010001011111@proton.me>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
 <20250412-vop2-pt2-v3-8-7c796db335e9@riseup.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250412-vop2-pt2-v3-8-7c796db335e9@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 2025-04-12 16:27, Dang Huynh wrote:
> We need to prerelocate VOP2 memory so the driver can work. This
> will only support U-Boot proper.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm/dts/rk356x-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 24a976cf7e21da351cbbb969ba2b4687c344ca6c..1191e2fd567dd18655c88ea1b7a28d160d43c220 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -166,6 +166,10 @@
>  	clock-frequency = <24000000>;
>  };
>  
> +&vop {
> +	bootph-some-ram;
> +};

This node should be sorted after &uart2m0_xfer to be in alphabetical
order, and not put between &uart2 and &uart2m0_xfer.

On a related note, I do not understand why U-Boot must allocated its
framebuffer in pre-reloc phase, but that may be something to change/fix
in a different series.

Regards,
Jonas

> +
>  &uart2m0_xfer {
>  	bootph-all;
>  };
> 

