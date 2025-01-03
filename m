Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E39FE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6A980275;
	Fri,  3 Jan 2025 13:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C22C80295; Fri,  3 Jan 2025 13:58:42 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F98801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 13:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1735909079tx99svl
X-QQ-Originating-IP: ebII1+uJP5CGZetEKpgRzyOvQq5AmDpeyxCSGmDRciI=
Received: from [IPV6:240f:10b:7440:1:8992:1149 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 03 Jan 2025 20:57:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3431154941262054916
Message-ID: <20786146C3D31F40+35f2b982-a1b3-446d-9b4e-1ff006107c69@radxa.com>
Date: Fri, 3 Jan 2025 21:57:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] arm64: dts: rockchip: enable PCIe on M.2 E key for
 Radxa ROCK 5A
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de,
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com,
 dsimic@manjaro.org, pbrobinson@gmail.com, macromorgan@hotmail.com,
 cfsworks@gmail.com, sebastian.reichel@collabora.com, cassel@kernel.org,
 didi.debian@cknow.org, boris.brezillon@collabora.com, jing@jing.rocks
References: <20250103123052.110350-1-naoki@radxa.com>
 <20250103123052.110350-2-naoki@radxa.com>
 <CAFA6WYMerej_EZouy7OWtmYH1upObTWeh_FaKXNr7aqMT_YqzQ@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd.
In-Reply-To: <CAFA6WYMerej_EZouy7OWtmYH1upObTWeh_FaKXNr7aqMT_YqzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M0wYV6TTeeWirpnkNQ2/jtm0N2qdvaTmubaLiO/R36zkXbmub5hZdf8u
 fQuhHXd8epltJ8MrOXdObhSew0umuZCyMlouZ7cGthCk8tBXIK280oCGGzdLNhNdV6pr9A9
 Y+8GxcdNDVLObTiP4ts0DUySp0SsmlgE6a2xSSjNgU/l9m2j++poU0FpLxaEgXbJ9HTJ5DC
 6ar+3ezNfqA8FP8mQlARNV8SOr2HEXva3GKxRTvR7CfyxyCyDTID3FtO50ZQi7jnUFVbYW0
 XaGTTJOqOaa/mYYIVDohHAh3a94rLRsB3fKrCluGbCJxIjPJSkMg1VStE3GlmKtuqJ8DHR+
 hXhUh14D/Ko6qEQJlsmrVFvwEpmWVS5jb24YiX8CSdC7MX+m8oZ2Y+/t6qUPwUc7LHhpDvH
 jsvAwidEgmLLRjxdLRyP9zonhLihqLZkTmQfrzqXLI7gGFw/oY7jT3Ml0eQ57Icgid/q/Dt
 Q8AVjRseOOztkVTFNokei0Sqepk8t6AJTZU/VB0Y6x+JPf/RxUN5Gf0MFAOwUN1mJAtO3lI
 M6b6ZCnG0SznmC3ARkdvRrULsE22mSycwFDp+AfJGRQIxJwwAEGf+gGTQRCrhjt/lSzWORu
 O1UB34UULEMHbkcvJsbZFK8yX2so7tCm/alKxREuw16fPZ2XFvJ+v8CvPgWn9AlMuiuj58r
 4roxKgMNIkclxvRUEHOjJcV4qHo5HOCHUpQC7a1gE3Vfm3SBSpLczs1kV8rmmm0lwAth/Am
 7pQIJj+f2JA4DNcOGg6RURf6oOA47XnIv6jf0nE+R9y2KEOLPaVDR0mXlQwwDIxtA5QLTUv
 h7/Q7bn522xwW/INknhsTnHXAOt8j05WDPtlWwnuttqjO7pXDFrGBTEX9XMPsQXSC+kx9c6
 hh1biy05cZkozehxpWR4gImAVXXoFqLcP5OfIgllgGBkAZnnJDIuadtMqm3XMyxHP0pc7v2
 uUixCaA25mPhAmXGPBcSi/wDa3AjJrFWImT11BGQbcJm9wEcNc5ROmCzR
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Hi Sumit,

On 1/3/25 21:53, Sumit Garg wrote:
> Hi FUKAUMI,
> 
> On Fri, 3 Jan 2025 at 18:02, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>
>> Enable pcie2x1l2 and related combphy/regulator routed to M.2 E key
>> connector on Radxa ROCK 5A.
>>
>> Tested with Radxa Wireless Module A8:
>>
>> $ lspci
>> 0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
>> 0004:41:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
>>
>> $ ip l
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: end0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>>      link/ether c2:58:fc:70:55:86 brd ff:ff:ff:ff:ff:ff
>> 3: wlP4p65s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 2c:05:47:65:5b:ed brd ff:ff:ff:ff:ff:ff
>>
>> $ lsusb
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 001 Device 002: ID 1a40:0101 Terminus Technology Inc. Hub
>> Bus 001 Device 003: ID 0bda:b85b Realtek Semiconductor Corp. Bluetooth Radio
>> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>> Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 006 Device 002: ID 0789:0336 Logitec Corp. LMD USB Device
>> Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>
>> $ hciconfig
>> hci0:   Type: Primary  Bus: USB
>>          BD Address: 2C:05:47:65:5B:EE  ACL MTU: 1021:6  SCO MTU: 255:12
>>          UP RUNNING
>>          RX bytes:2698 acl:0 sco:0 events:329 errors:0
>>          TX bytes:69393 acl:0 sco:0 commands:329 errors:0
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> Link: https://lore.kernel.org/r/20240826080456.525-1-naoki@radxa.com
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> (cherry picked from commit b728d4c51f0ce9207daf502f3a85073785c46319)
> 
> This doesn't seems to be a clean cherry pick from devicetree-rebasing,

It's weird, but I'd do it all again
Thanks for your review.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> I get following error:
> 
> $ ./tools/update-subtree.sh pick dts b728d4c51f0ce9207daf502f3a85073785c46319
>  From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
>   * branch                    master     -> FETCH_HEAD
> fatal: bad object b728d4c51f0ce9207daf502f3a85073785c46319
> 
> -Sumit
> 
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>   .../src/arm64/rockchip/rk3588s-rock-5a.dts    | 30 +++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
>> index 03ed48246d36..a385e0991990 100644
>> --- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
>> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
>> @@ -65,6 +65,18 @@
>>                  regulator-max-microvolt = <12000000>;
>>          };
>>
>> +       vcc3v3_wf: vcc3v3-wf-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vcc3v3_wf";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               enable-active-high;
>> +               gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-0 = <&pow_en>;
>> +               pinctrl-names = "default";
>> +               vin-supply = <&vcc5v0_sys>;
>> +       };
>> +
>>          vcc5v0_host: vcc5v0-host-regulator {
>>                  compatible = "regulator-fixed";
>>                  regulator-name = "vcc5v0_host";
>> @@ -114,6 +126,10 @@
>>          };
>>   };
>>
>> +&combphy0_ps {
>> +       status = "okay";
>> +};
>> +
>>   &combphy2_psu {
>>          status = "okay";
>>   };
>> @@ -293,6 +309,14 @@
>>          };
>>   };
>>
>> +&pcie2x1l2 {
>> +       pinctrl-0 = <&pcie20x1m0_pins>;
>> +       pinctrl-names = "default";
>> +       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>> +       vpcie3v3-supply = <&vcc3v3_wf>;
>> +       status = "okay";
>> +};
>> +
>>   &pinctrl {
>>          leds {
>>                  io_led: io-led {
>> @@ -300,6 +324,12 @@
>>                  };
>>          };
>>
>> +       pcie {
>> +               pow_en: pow-en {
>> +                       rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +               };
>> +       };
>> +
>>          power {
>>                  vcc_5v0_en: vcc-5v0-en {
>>                          rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>> --
>> 2.43.0
>>
> 

