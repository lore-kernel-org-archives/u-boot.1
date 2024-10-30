Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA63ED74957
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 03:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF4D891D7;
	Wed, 30 Oct 2024 04:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC1D891D4; Wed, 30 Oct 2024 04:08:36 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46768918E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 04:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1730257679tc30xg6
X-QQ-Originating-IP: q72j8URjV+t1DNb5KspNzUhuA3qxBO31zYGh7syMB+o=
Received: from [IPV6:240f:10b:7440:1:2231:c46: ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Oct 2024 11:07:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8332746298117862469
Message-ID: <08A30A7EA30489D4+81cbd3a3-455d-4c98-a75f-0fe107ea7560@radxa.com>
Date: Wed, 30 Oct 2024 12:07:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: add (but disabled) SFC node
 for Radxa ROCK 5A
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se, sumit.garg@linaro.org,
 Heiko Stuebner <heiko@sntech.de>
References: <20240824223343.98577-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240824223343.98577-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nn3bY5kS8sjsIqqHBpo+1/zQwHSmBEuJXGcWhgBeSHs+A49tyrgw/ghr
 nHMew/nDVmPJM7Owyq+nvnvl/evzp1XH8IugERmMSaP1MZUMVqUytw4M8hwQ3+JMHdaH9g1
 szD6ERoKBP52UOPnmHwb2J4rXg/fYB5SIRviW36bzhn8RudilZHnwC6vc1Ve7z8KXKBCsMc
 I1/692gzl8qcOzBo5q72JhY+5QDb42yHmjr3bq3V6vZzPEMJfTgfwnNkt5HWvxSRIBSl0w3
 PsDlos1rJ3ni78IH2vZLTjAj3qluptbpN76pk/cqLnzCKCB30aN3gfKTK3qGQnZusba/LQZ
 1f2olGw+6g4YKBAhUJliZBk3kz2PLNgSsedwXQl+6xECTwhib9cSr/yPPtcYutmalGSuM8N
 as/vvGsTWg8DLvYCCJIY8LHWPUgwd5+WsmbSQsQAAN4yMpM8FMJltuEPF7P7uA7/YGaxYNY
 2Rm+GhRogtX9IzoRozZfXGCZX/7kOfVTvqgP5YzpUxg92iRUUDhShML54rYB80Y5lrZ4tRr
 3yUWjklOLymKxF8GUQ+wgUhoZfarLOxwC8ar2U5/uOgdilq5KqWKePBZkXCSjBL5v/s3Kfh
 G5Og2r+ONPHZ5y1Qn9lpsAftW285o+EPgL41T9tMXD35rO4yksi6S+FBr40m4WFiEkKhYjx
 5EhIcf72bG2zQ2BMfLq8mdRKVJa6KooQZyUTKs0icc9EBnX5Ck4Zx9r1duHyf5dxi0z2xwP
 I3J9N+pYzKY47HUTtc01SdJ4rvnNNSL94RT4/tB2/E48jAlHAiGOKummEdeWNFcYBQDgjrf
 ymffnYd6zlkqeBkFcTx/pzQ0PCM5hxxCHiP47Jr1kibFV5d47fkkpn3EDpdeoX8OqAXNVkz
 H06Z1qlhpU4Q63vW86IvxZ81ER9CPCoCA/ePR8nfyEf02pNNLOpl1A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

dts/upstream/src/ inclues this change now, please ignore this patch.

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 8/25/24 07:33, FUKAUMI Naoki wrote:
> This commit adds SFC node for Radxa ROCK 5A.
> 
> since sdhci and sfc on RK3588s share pins(i.e. exclusive), it cannot
> be enabled both nodes at the same time. so status = "okay" is omitted
> here.
> 
> you may be able to enable sfc (and disable sdhci) by fdt overlay.
> 
> SPI NOR flash chip may vary, so use safe(lowest) spi-max-frequency.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/20240623023329.1044-2-naoki@radxa.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: 00224650dd45e166ea6eb1593f5f064583963ccf ]
> 
> (cherry picked from commit fde218de3133705f3f56dc8eb26baa878f0e0dc9)
> ---
> Changes in v2
> - none
> ---
>   dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> index 3b9a349362d..2e2f7f0e769 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
> @@ -377,6 +377,19 @@
>   	status = "okay";
>   };
>   
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspim0_pins>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <104000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
>   &spi2 {
>   	status = "okay";
>   	assigned-clocks = <&cru CLK_SPI2>;

