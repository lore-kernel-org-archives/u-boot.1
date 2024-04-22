Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53744C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA8D688353;
	Mon, 22 Apr 2024 10:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="R7QirZWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A168883AD; Mon, 22 Apr 2024 10:08:09 +0200 (CEST)
Received: from mail-m21474.qiye.163.com (mail-m21474.qiye.163.com
 [117.135.214.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C6888340
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=R7QirZWD67ZwNzQK8FjnPUWxXvzgQQhU41Yv9Wcd+a5dC8eaFZIqK0tn0gIrFFZukWpRnP90s0FKpFc7LLTWhC/7ikw8jcpQaYwO5oUzU7RBCyThbwwabXzCd+ywdVv8zbFh9/yFl21c3r0ja7EE/PeKwa4rdguTYkliOenuJZo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=EiKeIE+DgwqNgwCvDnSkFXtszp0emivw7Urw4K8gmGQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EC0969002DA;
 Mon, 22 Apr 2024 16:07:50 +0800 (CST)
Message-ID: <cca4d735-d202-4fb9-97d0-5a957c4681cf@rock-chips.com>
Date: Mon, 22 Apr 2024 16:07:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/28] rockchip: rk3588-coolpi: Add boards to
 documentation
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-18-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-18-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhPGFYdHhpMGENMSEtJTUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d8d9fa03a9kunmec0969002da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6GSo4AjNNKjoiTTU4HAgD
 PCwKCzZVSlVKTEpITExISUxJSkhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTElPNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the documentation.
>
> Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Split Makefile change to a separate patch
> v3: Collect r-b tag
> v2: No change
> ---
>   doc/board/rockchip/rockchip.rst | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 5dd5ea7f1e29..9a726e9cde63 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -131,6 +131,8 @@ List of mainline supported Rockchip boards:
>        - Turing Machines RK1 (turing-rk1-rk3588)
>        - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
>        - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
> +     - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
> +     - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
>   
>   * rv1108
>        - Rockchip Evb-rv1108 (evb-rv1108)
