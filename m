Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5F9CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EEB83849;
	Sun, 26 Oct 2025 16:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eVMD1tCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0C08391C; Sun, 26 Oct 2025 16:46:33 +0100 (CET)
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com
 [220.197.32.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07447832AD
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27374904c;
 Sun, 26 Oct 2025 23:46:27 +0800 (GMT+08:00)
Message-ID: <5e66d798-8167-4ccb-b7a2-dcf6f0907878@rock-chips.com>
Date: Sun, 26 Oct 2025 23:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] rockchip: odroid-go2: Add myself as a reviewer
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250831165001.2749711-1-jonas@kwiboo.se>
 <20250831165001.2749711-18-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250831165001.2749711-18-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a213316c803afkunm2b959ab84d3618
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx5LVh5OGB1OSB0fSUsYHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhCVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=eVMD1tCJqr+VbzjcIXHYeYQCzr6jb1U4N7HMJt1wWveclFoTvIvLUAcZJbzjCdRbIDqchbgNxIZetvtPoawVwAS3d30+6Wt4zHvfP3vi/aFjikSsf7Q5yvHD2AXfHRy+qzIQY1orpvWPNqGqRhvueQk/ae6yp/mBy4a7Q5itaH4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=nvVWol7PsAu5F2cDEfQmyRqMFyP5Iqk50dE2+6L1kog=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/9/1 00:49, Jonas Karlman wrote:
> I have the ORDOID-GO Super variant of this board. Add myself as a
> reviewer to help review future patches targeting this device.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   board/hardkernel/odroid_go2/MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/hardkernel/odroid_go2/MAINTAINERS b/board/hardkernel/odroid_go2/MAINTAINERS
> index 9e83bc9452c8..ee06c2fa6518 100644
> --- a/board/hardkernel/odroid_go2/MAINTAINERS
> +++ b/board/hardkernel/odroid_go2/MAINTAINERS
> @@ -1,6 +1,8 @@
>   GO2
>   M:      Heiko Stuebner <heiko.stuebner@cherry.de>
> +R:      Jonas Karlman <jonas@kwiboo.se>
>   S:      Maintained
>   F:      board/hardkernel/odroid_go2/
>   F:      include/configs/odroid_go2.h
> +F:      arch/arm/dts/rk3326-odroid-go*
>   F:      configs/odroid-go2_defconfig

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

