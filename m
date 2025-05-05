Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C85C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 07:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EF180BAE;
	Mon,  5 May 2025 09:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iNvS1uPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4647280F03; Mon,  5 May 2025 09:07:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7678091A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 09:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so3121307f8f.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746428848; x=1747033648; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BAcvdE2xY/zpD3KTmU7HwvxmS2gSLmyMDAFLT80zCwA=;
 b=iNvS1uPeZEJpYvqQ8Fr6e0u0Q9djgLtM7O7kiFMAba7vSr1mxkNJ6Aro5UsQ/m8U8H
 R5a3+ka9FWHPAgmIFDp+ATG/+wxXbBV2qW7X0Et0yOVqvk+gJxHAAmHuIPDiIy4q1wRu
 CxBsVb71QffVtK1+ArmIKCs1+lGJhMUA30EctYT9VgS8mpT0HaSh4DCchpribiZ1ErRs
 GjdGkgWPzOFr6mV4FEPcxe2pj/+UnRHF2VhHrezatQ3CDYPhcTiz5LaP65zXw1reJib4
 QkMvdueH5WWd64pycYaKEcWACutxLmLR6ubvA+0kCAiAi1VsHrvgI4/wXQwHSkum0uNe
 rcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428848; x=1747033648;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BAcvdE2xY/zpD3KTmU7HwvxmS2gSLmyMDAFLT80zCwA=;
 b=SEbwcUQvIj262+QlF2uGqEU1KP8BXR382SzRJ+OwPNYaxmcqbH3vwhS16C3M8rb/h+
 1SVeLuYNRbQTA1pwOFIm79u5HwXDJy6HRjrTpOQQ+atkcqGzd4WQe89ybfKIm6BAKJXZ
 uu/u7RH4MgIDSl/ge8LD6fDaGz9na1s53pyoJl4icdbNu/JTJnIglahsP24GAKIclxk5
 Ajj16zEEJFy5BtATt380DuUtJGZp4oygqDxtVKmSGcBSzkCreB2zvb109Q3pEeiEm9l1
 JdHG2+qmPZ34ZMrFkde7Tuj1ZaOeo294Fg/sumaCC5umv/g+XorPMKrNokI9vvqqSZf1
 wmzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQHWxfbII3dCtTgiO0DckOC08WMrCYFg/Hd9B5syRgmg3gLywwrB6RpOuEL324LbseMNezXb0=@lists.denx.de
X-Gm-Message-State: AOJu0YwmGApg2XcbRGviLIt1xrWxxf1iLYRBF5o4G41XIXcEMz7YDSJU
 nEgARja6dn128t/PTQKHXJSlMQ5jpIQGsAjLPwVkISHUAcRxtbDEDeBBuv7M6g4=
X-Gm-Gg: ASbGncv67pcAzIBNpPx1HKWMaDoYkIlTEUkFIAYcTynLl21mDlPVYbXhIOlf8jO9QiL
 +9YwrqvCqPRu+jB2v78F6ZIGPn6lBeWWoGaKkhr2gY+Jc5V2TGi5ZWv6IjbmAKvzZdK18ES6g/2
 TNyr5ediVUgxI1rzy+bAiNEDt1MDPW7bDgNWFCrbOtWyIaeaCAc4iJJR87MFOapOvol1343Z03y
 cBxDBnQCxSYOUfXX+Jk4LrkxvGohwISDNtpaO1ulmaRDMhjmwoAzlp/6TL5Ll+VvjhWdDShlQtD
 bQ2JicV3YKT/VId5KK5ESkXp8s4kVdkXII+MSm+EEap4AW1Im4s/jGRyX8y8xtSGnNf0ZXEc4kr
 rw+iwvON1zW2h57x5lv+oPU8JjmbX
X-Google-Smtp-Source: AGHT+IHydklTwgvkH9q6GqOTfYh+FoH8zbjEJ/ifB4D6ubYun8TosSrDO7fZcpMAINEvL9rzwviU+w==
X-Received: by 2002:a05:6000:400e:b0:39a:ca04:3dff with SMTP id
 ffacd0b85a97d-3a09fdbb907mr4641524f8f.40.1746428848634; 
 Mon, 05 May 2025 00:07:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3?
 ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16f00sm9251942f8f.84.2025.05.05.00.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:07:28 -0700 (PDT)
Message-ID: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
Date: Mon, 5 May 2025 09:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>, u-boot@lists.denx.de
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
Content-Language: en-US, fr
Cc: "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

+CC u-boot-amlogic@groups.io
+CC linux-amlogic@lists.infradead.org

On 05/05/2025 00:34, Wayne Schroeder wrote:
> Hello.  I am not sure if this is a bug, or even related to u-boot, but I am
> reporting it here because it was easiest to resolve via a u-boot change.
> 
> I am using u-boot-2025.04 (source) with a mainline linux from Arch Linux
> Arm.
> Linux alarm 6.14.4-1-aarch64-ARCH #1 SMP PREEMPT_DYNAMIC Sat Apr 26
> 13:02:01 MDT 2025 aarch64 GNU/Linux
> 
> On my odroid-n2+, the USB ports work on the first boot after power.  If I
> run shutdown -r now, or hit ctl-alt-del and otherwise reboot the system,
> the usb ports do not function at the next or subsequent boot up.

I think it's a very long term issue, USB lacks a proper reset at probe on
warm reset, does USB still work from U-Boot after the reboot ?

> 
> My apologies if this is not applicable to u-boot because it is a linux
> issue--I am not sure what the source of the issue is, but adjusting the
> u-boot .config after make odroid-n2_defconfig resolved the issue entirely.
> 
> I am booting via extlinux/extlinux.conf and have adjusted my
> CONFIG_BOOTCOMMAND before build to execute a usb reset prior to the
> existing run distro_bootcmd.
> 
> CONFIG_BOOTCOMMAND="usb reset; run distro_bootcmd"

I'm pretty sure there's driver callbacks we should implement to do the
same here, I need to check.

> 
> This has allowed me to reboot the system and successfully have access to
> the USB devices such as my keyboard, mouse, and root file system on USB3
> SSD.
> 
> Thanks!
> 
> Wayne

