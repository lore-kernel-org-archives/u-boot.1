Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC7C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC41381F66;
	Fri, 27 Jun 2025 08:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wxGM6LSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B0582E27; Fri, 27 Jun 2025 08:09:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B861380C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef14=ZK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1751004563;
 bh=ogoRoUboawlj+IEwRCVwjsFDVxqjPkpTEkiy5D/cvBY=;
 b=wxGM6LSHSyZGhEW/w/zSYh55bA368H171svZkFqzwPSmg+AY+p0mOfKRfUsTIdR2hY4JL6iJQ
 NpuRfb2JtzG/yCSVugGVwkQsViFWgO8iOTQ5p4Ty0VbokuPHSIjMeRzKdu1SzyEtwi394ml4/oa
 yam1mk4GBMTpLkdJnPapZcTfw7/zceqwUlFKwN82HIRnl8C5gvIS+SU46H1I2BhwCMtlK55+9IJ
 F+2b7JYX088SDsydMOG7VLh38Mo5swd8doAzCPQn+kaAk9TEnCJEkkc9S7EhQuHoKfkX+ckySfz
 DJtXcXFt7AcB4ruGfljYZakWmfS/cKl0C6dpbxKj/CeQ==
X-Forward-Email-ID: 685e358f7cdf8336a3484daa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <07e80d9e-c91b-4b33-ab12-bcc5aa0bf3c7@kwiboo.se>
Date: Fri, 27 Jun 2025 08:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add ArmSoM Sige5 RK3576 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>, Sebastian Kropatsch
 <seb-dev@mail.de>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20250627025721.962397-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250627025721.962397-1-liujianfeng1994@gmail.com>
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

On 2025-06-27 04:53, Jianfeng Liu wrote:
> ArmSoM Sige5 is a Rockchip RK3576 based SBC (Single Board Computer) by
> ArmSoM.
> 
> This is the second board of ArmSoM supported by u-boot, so I change the
> dir in MAINTAINERS to board/armsom/.

Please review my series that already adds the Sige5 board, see [1].

[1] https://lore.kernel.org/all/20250422211216.3727559-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> Booting from emmc is tested.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>  MAINTAINERS                                  |  2 +-
>  arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi |  6 +++
>  arch/arm/mach-rockchip/rk3576/Kconfig        |  7 ++++
>  board/armsom/sige5-rk3576/Kconfig            | 12 ++++++
>  board/armsom/sige5-rk3576/MAINTAINERS        |  7 ++++
>  configs/sige5-rk3576_defconfig               | 44 ++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst              |  1 +
>  include/configs/sige5-rk3576.h               | 15 +++++++
>  8 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
>  create mode 100644 board/armsom/sige5-rk3576/Kconfig
>  create mode 100644 board/armsom/sige5-rk3576/MAINTAINERS
>  create mode 100644 configs/sige5-rk3576_defconfig
>  create mode 100644 include/configs/sige5-rk3576.h

[snip]
