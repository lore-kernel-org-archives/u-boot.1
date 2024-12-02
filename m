Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9DDE69E9A
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 23:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E71F8951D;
	Tue,  3 Dec 2024 00:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C79C89588; Tue,  3 Dec 2024 00:03:48 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD8F689246
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 00:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip4t1733180590tar4ym2
X-QQ-Originating-IP: PIW0JxVAi1O8Rwjkaqp8XRwjPbH9SZ3bMbWU42BbJ3M=
Received: from [IPV6:240f:10b:7440:1:f61a:d8:e ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Dec 2024 07:03:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17368748476962677574
Message-ID: <D651125F63787803+83f3b9e3-ff88-42d5-a5e5-93144cb4df58@radxa.com>
Date: Tue, 3 Dec 2024 08:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399-rock-pi-4: Fix Synchronous Abort
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241119001222.3795292-1-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241119001222.3795292-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nwz8Cs33/Lpr1sVL70qCuy3dkwcIWlas55OOxR7zx0pYF4J0ugVI3x5K
 sgiZWnFtuthCAk1gp1SMEFdk8SEqHm43pbx5WBKA1Cr5mdrWtSRbhMCPP8ZPjNn8/wuKclQ
 XwXb/d/YLIPBtFmSdVOHC1BIIapNQh4kMquaq1rne3pp+lbDEqZAOsg/qJyjeRiLjbblNG6
 j9eyc2TeB+EN8bIPSiLM3ReqbvnVuAedG0WMRcxFqZqFV2vOrbrSOlsjLLHxsMvzClQu/f4
 MpSqsED5OUrgr8fYaJPW45Ztz+IyqbVUhWKfxFi+MxBxL5reVKlkvhJVnB1BxxcOvJBtOdd
 MPQNsvWz41RsfnjXLetJqW05P6NCL/ae6lirp5fraqhNaIlfaYc5EjT65hC4G6MxTax0BgO
 hPOwHfBS7Id28cMnPUdSJTrmcl1eCJIl4SLF9ppLy34YWaXhSlgb0UZtdTxHYuSb6bcCPzx
 bFa8ejuupJEF7MtE6EOhzXCfn2uzoWYHsLlFTv2LNHc8NU/RVJcrlNnwMHxSQiQST/hJpiJ
 buGjMp5LwRg1bZvDRDWgrHcwySqWs6Lp9O+4nN0CRbHUYiwG49nXJqn8UqFJOZhauy7MIPT
 Cw+XC9HW3wsvbIzSqE6IsWcFZ9ouCn3hgWXl240qUCovZ952kRkIqK17hDxhy6lVEqx0Vyt
 qriwEIqPSoIam9XvSI5KAFvCCbS/1L/OeFydjaLn9Q7piNYBt7T9uSz7dl5r0jzvy2/htGe
 P88gGM4zMtqGHxYiLQqGcuBxYczgPXfZ3NDY+gEq3GhwRXWGkwOOk3Nh0izsTJz8VEcw/Hc
 wnvol9IOCksFV+hDfah4ZZ95NlPnj4ey29qesKW8Vvzn3O90kmp1nIy7LFOTMtcyRkAxDjg
 gYTl8rYeYeogCpqk215tuCl4tUAfjI5Lsi/Bpl2IfE0yiJZfxdmtVg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

Hi,

On 11/19/24 09:12, Jonas Karlman wrote:
> After the commit 788cf33315c7 ("efi: add a helper to generate dynamic
> UUIDs") update_info.num_images must match number of valid update images.
> 
> On Rock Pi 4 following Synchronous Abort can be observed due to fw_name
> being NULL:
> 
>    Scanning global bootmeth 'efi_mgr':
>    "Synchronous Abort" handler, esr 0x96000010, far 0x0
>    elr: 0000000000200e28 lr : 000000000028adb8 (reloc)
>    elr: 00000000f3efbe28 lr : 00000000f3f85db8
>    x0 : 0000000000000000 x1 : ffffffffffffffff
>    x2 : 0000000000000000 x3 : 000000000000000e
>    x4 : 0000000000000000 x5 : 00000000f1ef0d78
>    x6 : 00000000f3fb3b90 x7 : 0000000000000044
>    x8 : 0000000000000010 x9 : 0000000000000031
>    x10: 00000000f0ea3fff x11: 00000000f1f29e00
>    x12: 0000000000000002 x13: fffffffffffff000
>    x14: 00000000f1f29e00 x15: 0000000000000018
>    x16: 00000000f3f44f7c x17: 0000000000000000
>    x18: 00000000f1ef2de0 x19: 00000000f0ea3040
>    x20: 00000000f3ff53d8 x21: 00000000f3fd0498
>    x22: 0000000000000000 x23: 00000000f1edb960
>    x24: 00000000f1edb95f x25: 00000000f1edb990
>    x26: 00000000f1edb964 x27: 00000000f1edb998
>    x28: 00000000f1edc1ec x29: 00000000f1edb820
> 
>    Code: aa0003e2 d2800000 eb01001f 54000060 (78607843)
>    Resetting CPU ...
> 
>    resetting ...
> 
> Fix this by setting update_info.num_images to 0 when no valid update
> images is added to update_info.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

thanks!

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
>   board/radxa/rockpi4-rk3399/rockpi4-rk3399.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> index fd827467b30a..856b434df36d 100644
> --- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> +++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
> @@ -52,6 +52,8 @@ void rockchip_capsule_update_board_setup(void)
>   
>   		fw_images[0].fw_name = u"ROCKPI4C-IDBLOADER";
>   		fw_images[1].fw_name = u"ROCKPI4C-UBOOT";
> +	} else {
> +		update_info.num_images = 0;
>   	}
>   }
>   #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */

