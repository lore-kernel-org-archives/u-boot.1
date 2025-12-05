Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51335D32D9C
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 15:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17228420C;
	Fri,  5 Dec 2025 16:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QkffrB7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA35841BE; Fri,  5 Dec 2025 16:13:37 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C167E839E2
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 16:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6e815310aso1533953a34.0
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764947605; x=1765552405;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TampX8rjraq7O8EWbNr1MvgfMAO+trvtVw4Y92wpOg8=;
 b=QkffrB7pAJxrFonxfFyz0BorCArArgv9JWsVZHHXiq9PrpeNBTjMmsTWtAiIl4l7hb
 OSlz9tkCwMFpOk3iKYmhn+1BakmF/Mz6e5GF0jikN0+4l2KLUqKxJRAv6hnveOQvI79G
 xw6UhiSiINSrS1/UJJrFhYjVPpdxXoWnZk43dWgvP93af8lDDeez1RaVjy7sELCeuMsZ
 Zzkj0TrQfGPOkxNTQvPW4LlX7l2Wh3cGSbRCZx54yuum3+XJdkLuRHg3M1elmIwIQ/pV
 hH4Gv3erO6V8ivy1AelgtmWE2O/CRMM2ORbZ6DJui0PZ3XnlQVSSIjlBZJGbGgd/TaPb
 RYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947605; x=1765552405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TampX8rjraq7O8EWbNr1MvgfMAO+trvtVw4Y92wpOg8=;
 b=PvAGzUT0D7J2v2StdcQQj5cWr+7l4P0QoLjDZ/ZrmBaLjF0Zl1YxafXROpOncMxmwy
 cPujPdDlWzSYoXV1p6XVWu37aVObHYDjp9ZSUwLuZ/z25ZnGOKnzt6dsziHBNWl/xq4g
 AglPGcLL9YT80HU4RpV6BJ0GLWHmRgoZAfjNU6Xs8RVS+hMoT5HDBos+PYuXeDN+mwWW
 55HJY0rL/IZ0VMCtu4X+BJ8bdE3sOvc7nz5b7Olf72YVcmnYU5AlldEy9ZCOh45jix4b
 89IwzAW6v+EHTsDmJULkIFlY5F3s16YyF+ljPMG1ybEIVAQZVlMN0M0tWY3izYlzjtwm
 9Lng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr4JgG8A4wMa4zPXUppoXZhVfN9qBOuEq7ONbEk8hiCfzG8Oaje3La5UbmpjhkgT3PnOLAoys=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5LX4QcarCO2ehf23GI4oQKzHDm6oMtlpZ4MJ3JRTUcGxxyMuW
 p58r2Cydks4lEJpUv2SNHsaJakptsdcrOZ0BxW7X3rXInNWZGSrbSWA+r0AFJXlYvNs=
X-Gm-Gg: ASbGncvwDYbTTn/sP7uDMyrhDKm4HMrP/huFUG4tBtxqvyN9xnKqpJFhudyHFpyEXmT
 bHPXaR3BuE72xdzlGKGZUIxSDmWTjPWRWUV41qdv05p8CyuaoBjbOBr28o5fCIwdqa7IZ0R9EMy
 UWrO7kZHzIBCTUelHcetf2UQ4ME8rUerIPYwQHv4xC5BZVBWtU0I00kJCPUgAogHtzn5t5HqUmQ
 WG4LEa77I7UkKr2HqCLWN1BhS7rCNCbp4aUzTnj/USHZO8hRwcaDIgHfgQfgzCx9zARUJvfGFek
 dQ+BYdwBusGJzhnyzcdYsDRGzXdVYCPCcHxL7o1u54HmLX8cvbyy6zxdgW6GqNSt+0HCn3Bbbxe
 DsJZst7rnHfETO+CXw5F21o3SCE5UtkLqqb+5xHdKl1Yspb/S8NvdmAGEfghH1rFLz9OthBjFCA
 5XpbRUo+iEPiTjimTrvw/Jq1Dvd0yr1hk4mMXPrFJyOcDto5ehSdR355L++DtpaOX2aQ==
X-Google-Smtp-Source: AGHT+IGD9ADdWGL4bVOUcMv0Wuso+uZcKfLpr3ULn62+C0jj2o4r6fsNhQqOtaKTUmGu+EqaOsTQXg==
X-Received: by 2002:a05:6830:3c8d:b0:7c6:ca92:3621 with SMTP id
 46e09a7af769-7c94db6284amr7622482a34.22.1764947605314; 
 Fri, 05 Dec 2025 07:13:25 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c301:de6:97d:1492?
 ([2600:8803:e7e4:500:c301:de6:97d:1492])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acb3cf1sm3952327a34.20.2025.12.05.07.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 07:13:24 -0800 (PST)
Message-ID: <0e33d7ce-5b72-4edf-95c0-799acd445c19@baylibre.com>
Date: Fri, 5 Dec 2025 09:13:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Julien Masson <jmasson@baylibre.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "macpaul@gmail.com" <macpaul@gmail.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>
References: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
 <7021158b1829c5daabf62b1901a8b4988a940a92.camel@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7021158b1829c5daabf62b1901a8b4988a940a92.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Dec 2025 16:34:34 +0100
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

On 12/4/25 9:16 PM, Macpaul Lin (林智斌) wrote:
> On Tue, 2025-11-25 at 11:35 -0600, David Lechner wrote:
>> 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>> 
>> 
>> Change mt8365_evk_defconfig to use CONFIG_OF_UPSTREAM=y and delete
>> the
>> U-Boot copy of the devicetree source files for mt8365.
>> 
>> The upstream devicetree is identical to the U-Boot one being removed
>> (other than having more nodes for devices not used by U-Boot and
>> upstream fixed a compatible string in &scpsys, also not affecting
>> U-Boot).
>> 
>> There was one minor glitch with upstream missing a few topckgen macro
>> definitions, so those are added to the clock driver directly as a
>> workaround.
>> 
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  arch/arm/dts/mt8365-evk.dts                     | 418 ------------
>>  arch/arm/dts/mt8365.dtsi                        | 840 --------------
>> ----------
>>  board/mediatek/mt8365_evk/MAINTAINERS           |   1 -
>>  configs/mt8365_evk_defconfig                    |   3 +-
>>  drivers/clk/mediatek/clk-mt8365.c               |   4 +
>>  include/dt-bindings/clock/mediatek,mt8365-clk.h | 375 -----------
>>  6 files changed, 6 insertions(+), 1635 deletions(-)
>> 
> 
> Thanks for your observation!
> However, there are some basic checks should be ran and 
> please keep in mind before you send the patch.
> 
> 1. Please always put the Maintainers and Reviewers (run
> ./script/get_maintainer.pl) in "To:" when you
> send the patch.
> Otherwise reviewers might simply filter mail to the other folders 
> in mail client and skip it.

I used `b4 prep --auto-to-cc` and this is the default way it handles it. I can
put everyone as To: next time.

> 
> 2. Please always run ./script/checkpatch.pl and check errors 
> before send out the patch.

I did run this and did not get these errors. I can see that your email server
has modified the email by adding "External email : Please do not click links
or open attachments until you have verified the sender or the content.". I
believe that your email server has also changed it to Windows line endings
during this process.

> I've download this patch (.mbox) from evolution and found 
> the following errors must be fixed.

You should be able to get an unmodified version of the patch from:

https://lore.kernel.org/u-boot/20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com/raw

> 
> ERROR: DOS line endings
> #1809: FILE: configs/mt8365_evk_defconfig:8:
> +CONFIG_DEFAULT_DEVICE_TREE=3D"mediatek/mt8365-evk"^M$
> 
> ERROR: DOS line endings
> #1815: FILE: configs/mt8365_evk_defconfig:14:
> +CONFIG_OF_UPSTREAM=3Dy^M$
> 
> ERROR: patch seems to be corrupt (line wrapped?)
> #1828: FILE: drivers/clk/mediatek/clk-mt8365.c:14:
> 
> 
> ERROR: DOS line endings
> #1829: FILE: drivers/clk/mediatek/clk-mt8365.c:15:
> +/* Missing topckgen clocks definition in dt-bindings */^M$
> 
> ERROR: DOS line endings
> #1830: FILE: drivers/clk/mediatek/clk-mt8365.c:16:
> +#define CLK_TOP_CLK26M         141^M$
> 
> ERROR: DOS line endings
> #1831: FILE: drivers/clk/mediatek/clk-mt8365.c:17:
> +#define CLK_TOP_CLK32K         142^M$
> 
> ERROR: DOS line endings
> #1832: FILE: drivers/clk/mediatek/clk-mt8365.c:18:
> +^M$
> 
> total: 7 errors, 2 warnings, 0 checks, 36 lines checked
> 
> Best regards,
> Macpaul Lin
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 

