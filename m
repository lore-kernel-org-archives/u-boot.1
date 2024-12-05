Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E54E77171
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9F1891E8;
	Thu,  5 Dec 2024 10:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="czLhsz2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE30891E8; Thu,  5 Dec 2024 10:00:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BC488F6C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733389212; x=1733994012; i=xypron.glpk@gmx.de;
 bh=ntLzRfixTQUfW7VyGGl4m1YDVPX8I5L3Vxkl/SaBJ1Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=czLhsz2v5um9KH94IExjAK2TQMp8Mc94fYnO+Cv0fdfqgZ1xpNOipqe+e/ghKCDP
 9LktDar89UQS3BGMgC51jNqomjsg24zM9cuLKF73bdELGA/54qYiRRH75KwQmQegC
 8VI9PJBdDgqOLYSLhC3TcGfEAL/+T9P4YtvJ4E3zY0SrXY2gCWWwYz3EEyD+pWc7N
 z5g7R2HGAobcv6FGGY3R0FdUP8YMunKBd8IGdEC+WOTuz2DCDeLPchGB0m/pQ/+zo
 heTVscFl2MlNGjaXr/vcvOIho6W2VsEmlZJoW4TXo0AcCzGy8tt12WZ64LGvtWuoL
 H8di3Kld+lYyA0ZHPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1u4WEC2XDI-00a7Wk; Thu, 05
 Dec 2024 10:00:12 +0100
Message-ID: <38d341ba-7690-496e-bace-60604219f174@gmx.de>
Date: Thu, 5 Dec 2024 10:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
 <20241204030530.2099776-8-adrianox@gmail.com>
 <20241205013018.GA1377816@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241205013018.GA1377816@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TRTg0VYaiQBOGlM9FsRUQ2nNS6YmvobFnIRPtt+SPXvEkS/F0Xz
 QNtPjV4ozwcpzHUfue34ng3iP4FHzH2py3lhbimTVDnjlk1ilIib9NCd9NAq5aT2eNipS5Z
 zabIfu6tcDy0KqO/iR+6xUbRS6OG2CJC8/LjBnzRf+ce9BAUWrEBRQ0em+06ckGNKRAMljI
 xcTfEVhIMzihIaoJVCrLQ==
UI-OutboundReport: notjunk:1;M01:P0:H9+IGx5mJQ4=;EnzzeCZhzPznmRudFYrloaGGPSd
 8Nu8VyuPz/hBFySpfLVwX3xTdLAZi27Pv4vY0d420HE9vikUL+ro32pN6rgKQpW5ok2ooYuoT
 Lh0lOuXkMA7VgolbbVLB4fkaZ2Jt+qHihGgpW8iAdcEx+5FnNkqREbH1INh0dUxHoDbEob/pl
 K7eo0NdXInDm9lhO1jzpgyHezT1H8tqltb6vozLrK8m78bLT/hv0mwEHjyaQA9OY5OTmnnYZS
 ibJwSaBN76KL3GKwz12v8gtHkojc1owGh7uMp/IfWtLpJ5DfpjjXtRFPgq3MsH4MuKepz/kzN
 KXXaGqJ5x0IAZPsFqLM+wWIPEKuXLpRv7up1wCoD16JOwB1QI9ErzOARawfMZmOlzoiKJyvkY
 46HQKPg9ysN9rsPtKX5CNMobdBUgrflBLdHAJLFEogUAsLOKjmbEhBiyNawH1W8l/W73zpEX1
 VjLutIvWCQaqVXB4YuQnckkWY0EJyprXm/4uJggyLTsRKQ2r6Cjvsv6HdbVdIprvBiUodQCU6
 Lik1cOBXsd5tNXKXcTIV/IlluunV/uZK4u/EfmtOMEGJH1FMJN8GAhFN7jeurD4NMupktiZm0
 e+NJz7WvlMG0uMScBD9ypTpO07/ppu99z5Ci/Q67nOyeukf0UInl0uwi7Jxn+24gwQhzrCmsr
 +T98+KJhzK3IS6NefKkIqA4j4Hs8q/ycY57KoxNY2j71qJxD3wsnmiHN+cBFoJS/ADzfUA+Cv
 scknVAQ2cmSnK1GkexwXWqEo/8YB3pRCNuGU7EKbRkV3AK5hWEpUPMQnaYJB7RsTBFazvOZN6
 /fKuHUoEmhy6Uepl9e27OQGBgpZExMVimhnAbsa6RuKtVBuDhiyR8/jtSJwhyRXYgIspUMr3V
 qaSYpjSd0kuI8WgnrXg6g9CtAFWWz0wgNFAy5aDXVOm0OKqQKqbl3rEiF7pOwlQl2mixgKF09
 vD8LoZP7JpwxLXNscN1QtjxhQ7yPmfvawXTDbGu5L8wtTHKOk2j1L/yYmf2gMKdiBcO1cqJy6
 7Md6kGOcFWqWfLTc//tyhFbc+LgVg+Fpu7gy13Nm/rMF0PrRPxKlub/czEw+U63+tYJWXcWQb
 jHbNaB9dFma1OaKy+m7LDlIZazPJSq
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

On 05.12.24 02:30, Tom Rini wrote:
> On Wed, Dec 04, 2024 at 12:05:23AM -0300, Adriano Cordova wrote:
>
>> Set the device path of the efi boot device to an HTTP device path
>> (as formed by efi_dp_from_http) when the next boot stage is loaded
>> using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
>>
>> When loaded from HTTP, the device path should account for it so that
>> the next boot stage is aware (e.g. grub only loads its http stack if
>> it itself was loaded from http, and it checks this from its device path=
).
>>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> I know this is applied now, but after re-checking some things in one of
> my labs, this breaks test_efi_helloworld_builtin on rpi_3 at least (and
> possibly others). There is no output from "bootefi hello".
>

Hello Tom,

None of the Raspberry Pi 3 related defconfigs enables bootefi hello:

rpi_3_32b_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
rpi_3_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
rpi_3_b_plus_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
rpi_arm64_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set

Which configuration have you been testing?

Please, supply the .config and the related test log.

I just tested pinea64-lts_defconfig with CONFIG_CMD_BOOTEFI_HELLO=3Dy and =
get

=3D> bootefi hello
Card did not respond to voltage select! : -110
Booting /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
Hello, world!
Running on UEFI 2.10
Firmware vendor: Das U-Boot
Firmware revision: 20250100
Have device tree
Load options: <none>
File path: <none>
Boot device: /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)

So there seems to be no generic problem.

Best regards

Heinrich
