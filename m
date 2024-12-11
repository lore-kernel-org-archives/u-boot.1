Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B311E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 04:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF11801FB;
	Wed, 11 Dec 2024 05:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F87801FE; Wed, 11 Dec 2024 05:02:28 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2E9801ED
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1733889712teosekl
X-QQ-Originating-IP: BxgEHqFr0qeg6Dxd43k95lLHFuyqF0CU9R8dgXZetjQ=
Received: from [IPV6:240f:10b:7440:1:b238:648b ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Dec 2024 12:01:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5363787743543667401
Message-ID: <141E39B6D24BD687+23e9960e-2acd-4cdd-939c-0cc950eaec2c@radxa.com>
Date: Wed, 11 Dec 2024 13:01:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241210222341.3537543-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MScs1grlNJ6zFfR/HCGkXK4CkHUVPYLcK1BK+NFXb/85KFYbS+cy3BGC
 csMlTFNZeaNomLn3jfzxoXOxfuWDir0lpwRDNppmRF0lR9gxz71Y/HsYgb7aVa1cCPBKiJn
 mgXbxD0YReue6Yj2YKY9ljUQwAsg4ALeIy4k+zz+tErqPOFC7IR/yxyVcmESf1yNPOuXNJb
 oOqt9sExacE3jliBTHbZQRFxGV5JkhOlmwTBT1FtzNXLDcvoIp5SdGCm/rmt1IOn98rAQxW
 qGk6OSPkc3YRzz67XP/saxpASviTaRIOHihOjnP8CgTVmE6RQfcI3RdcBFOHxMqRwrDP3/n
 17MRBGbGebP2xT5Pixl6ssm2fmvWTMEJf5B5+RXcLxO1GVfzgEuAs30TsvL7ivrtCMP33Q8
 se4Wj8LpEnLRpQxQnhnYCL1SzMpBvoxIehYhRjHzR8PZrWnXC9Z9ip/ubwxb0Q3vFMt4T6B
 WLjMBWgTnB0ulBYAdQPh0dvcaevEJqcN8trHpI7h5xpN3IdcLhRe0TM7TE24C2KYSAI5KDZ
 MSarkp34e+fJWtcoeyZNlAKbdbj96BcugpTxIv36tT7PgsOlVGZWDWLZkfVLmj39e6uG1Kj
 25VBAP580n/07JEIsiN0YzQYfWpFNrqthaObOybn3VRSkEDF+olCNVc4F1YelhrScrt7AoE
 1uZAYyuMaeYX5sM5Rx0YNgghPlYS1Q8mvIttnRIuijiWfQ/zHBHGRMenSGUIOMxF7BNrPXN
 jn6flBTo/Xxd6pQkfv3VHMnGoOd/gusQN9JGelrJvVIFWuNqkhJykDz/T12xlH1HX9liTuO
 arr9kRvsZsIWOj8nXjh02NnfHwIoaFfzaRsz1bPJ8c+xYKgkY4/XvIdczjO29BsCfTMUZgU
 XrmDAoWVs/auE+NW6ywqzqRJ51nmQiQYCGelbYVdMCA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Hi Jonas,

Is it better to apply following patch series with this patch series?

  rockchip: rk35xx: Implement checkboard() to print SoC variant
  https://patchwork.ozlabs.org/project/uboot/cover/20241110005622.1515100-1-jonas@kwiboo.se/

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/11/24 07:23, Jonas Karlman wrote:
> This series add initial support for RK3582 support. The RK3582 is a
> variant of the RK3588S with a few ip blocks disabled. What blocks are
> disabled/non-working is indicated by the ip-state in OTP.
> 
> Compared to the vendor U-Boot variant, this mark cpu and gpu with
> status=fail instead of removing nodes during DT fixup. Linux skip cpu
> cores marked as failed staring from v5.17-rc1, however the GIC driver
> will generate a harmless WARN_ON that safely can be ignored. A patch for
> Linux will be sent to skip the WARN_ON for failed/disabled cpu cores.
> 
> This depends on the patch "rockchip: rk3588: Implement checkboard() to
> print SoC variant" [1] for a clean apply.
> 
> [1] https://patchwork.ozlabs.org/patch/2009181/
> 
> Jonas Karlman (2):
>    rockchip: Add initial RK3582 support
>    rockchip: rk3588-generic: Enable support for RK3582
> 
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
>   configs/generic-rk3588_defconfig       |   1 +
>   2 files changed, 129 insertions(+)
> 

