Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7C9D25020
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 20:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602348392C;
	Sat, 10 Jan 2026 21:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="V4Yke2Kv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8F483C0C; Sat, 10 Jan 2026 21:39:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FFD838E6
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 21:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6292=7Q=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768077545;
 bh=BIvBwmRZqvf9h/pTWuLvMqleHnzIyD0XniP91CeInSY=;
 b=V4Yke2Kvgv/53y2aK9TQpDcr+dztnWUS/XJOg5xXKTAC6TI5FmBDh5FEaXCCIGI0hziTGa+BS
 T0ryror39ZkW0UTGFRLnF2qksi6cg11nQ8FduF841y1X1uasWRuEiKKexXZ8ST8bk96bl0e1X4e
 89mSTimPgHl5I4V6FiHtKxemVEgQPnf496gf31EZFlZfInTtIcq6G11trtxyHGSqddP/kzCkJU6
 T+R79LGVvWFhexfBskeOLPBzAeMecALEy9VnEh/u3Izzon5qmoNh1i7qQPz9cUoaJXHz7NYQX9z
 cAkGs5zulrn09oW8Ic8NBqW2VqUjFHoQHjaicvp0BjYQ==
X-Forward-Email-ID: 6962b8e5729b84f3047b8eec
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6828b868-e9e9-4675-8c9a-a9e54e229d49@kwiboo.se>
Date: Sat, 10 Jan 2026 21:38:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: Switch rk3288-veyron boards to upstream
 devicetree
To: Johan Jonker <jbx6244@gmail.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <63ff76d9-3429-48cb-80ad-0c0d45702e6b@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <63ff76d9-3429-48cb-80ad-0c0d45702e6b@gmail.com>
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

Hi Johan,

On 1/10/2026 1:00 AM, Johan Jonker wrote:
> Switch rk3288-veyron boards to upstream devicetree.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/dts/cros-ec-sbs.dtsi                 |  52 --
>  arch/arm/dts/rk3288-veyron-chromebook.dtsi    | 205 -----
>  arch/arm/dts/rk3288-veyron-jerry.dts          | 208 -----
>  arch/arm/dts/rk3288-veyron-mickey.dts         | 266 ------
>  arch/arm/dts/rk3288-veyron-minnie.dts         | 302 -------
>  arch/arm/dts/rk3288-veyron-speedy.dts         | 143 ----
>  arch/arm/dts/rk3288-veyron.dtsi               | 795 ------------------
>  board/google/veyron/MAINTAINERS               |  13 -
>  configs/chromebit_mickey_defconfig            |   5 +-
>  configs/chromebook_jerry_defconfig            |   5 +-
>  configs/chromebook_minnie_defconfig           |   5 +-
>  configs/chromebook_speedy_defconfig           |   5 +-
>  .../src/arm/rockchip/rk3288-veyron.dtsi       |   2 +-
>  dts/upstream/src/arm/rockchip/rk3288.dtsi     |   9 +-

Please do not modify files in dts/upstream, instead pick upstream
commits from devicetree-rebasing or add missing parts to -u-boot.dtsi
files, e.g.:

  tools/update-subtree.sh pick dts <commit-id>

Regards,
Jonas

>  14 files changed, 15 insertions(+), 2000 deletions(-)
>  delete mode 100644 arch/arm/dts/cros-ec-sbs.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-veyron-chromebook.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-veyron-jerry.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-mickey.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-minnie.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-speedy.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron.dtsi

[snip]
