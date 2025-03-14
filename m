Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5923C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9F481DEC;
	Fri, 14 Mar 2025 16:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NfWA7CZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E596281DED; Fri, 14 Mar 2025 16:51:01 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D7481DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1997424f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741967459; x=1742572259; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9MZV/xfqenlsEYC1WXATMchlnySnzu46NHN8q1wVzY=;
 b=NfWA7CZeeLYUxkMxJleZi6Xr3Awu6vE1puDrZNnkG/HMncVO+OxG34yS5CqWdkb+mR
 +Yq8RXw7WFzQ3pPK9mPIMXw5hPC+w9O7EjrCYJ4wO5L3eP6Vw3i82Xymd4UopPwiL9LO
 2fLnr+DX4UMHz19UtHxma11o9P2ArFgBg6cE0TR5dLW1uGHC7PSs6G1XCTdJWLN9MA09
 Ib8CdTFmS1pvBCfsaReuu9krXATaBEx6ISTj/SUceBTzRWnqGjnDUyiM9+frxB87euoH
 3rTn+NRlkhSfW/RwC80Mei+n0yHw7pbr1UfNPNCpyIewXr4KMqqYLXhCnuwuH3O78NET
 C73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741967459; x=1742572259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X9MZV/xfqenlsEYC1WXATMchlnySnzu46NHN8q1wVzY=;
 b=WRxquY59orytNdwCeA7QfeUcxiLtWH5Q/22seSFKDIJlgmIngfFZfcOL/6N3F/CAoA
 ZgVf7R6HRQAxPt28setpKWtKWt6+yFZj834PFyc57vZYqWcWz4jqN4C/SC9PjlVEWK/j
 ACPVeor2TVMgpaWA+aVXPpybyo1QNpynirNV7nsdPjIbkLFqBrlPPSeBoR5sYLdyQYrk
 GujQFSax6yJhR1YszpLD8VBhXT8Dbw2X5Ck2eYNuPQijOUzdh1A4/sNqCTq0Rc/Otkr5
 DGyeULtqIEerv8tdD9Cv2WDMkFrx2kq/PT8pBqCK4Gwrilob6FKRsP5CPJVfTcs7+LUm
 y6dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzKHhYXcjXYE5c8MB1N5BNtL6OSNQAZ6OplDNO5p8+a/oW52hGHDOJu11OpiWjetdOSaPe7OY=@lists.denx.de
X-Gm-Message-State: AOJu0YwO9Wq+YDSL9Uzx+qABy7IqUvYeSAjXQftebKkfA96ISVIoSzEF
 oeh5M5zeGgD/T5nJOOojr3aQ7lz0wZHhzMdK9aEG9qwOKbTCzzTfZ3rm4iYMJyc=
X-Gm-Gg: ASbGnct/xUQjJnqh6hiOigZ8suJNH6uWzykVM2H6cNW9fZmrmM8vwwufNVIGx1hDXht
 0J2IGUfNGufyJUh2gq77r2Koxxf1B8ZxSfmf0hDtLWnGmDHw1Ec9VG24vIMxnggs8LfLK0TQ2Lg
 NbGyS2KpjgiCPqMs/QjHwTRo2mm861Z5lf/Tq1BKcLAQDtdN/XVeJJyO3VyREKjL97udm1d4Lo6
 6aiAkp15/g+M/YzWB4JXWnAo0XyPEAW/E5MyKYm5+k/ourKQAsPpjuThvVTmKyZyuQOZgyuMZqF
 9DUKUHwRGv+RX7XgGT5tGlNUxcBBPVi2ERkp+oPxrICa3Sd1Z/AOAs/oXuMW8k8Ftmqvo6T4956
 P43eU1abQ3bL6W9wyYZgYyNM4Mg==
X-Google-Smtp-Source: AGHT+IGHKfA4u8J2qYSY2xOdjGVQcoUkyEqLE3+vBy8mw/9PHV8d0roDwHxbR0ag6MvOxfPFhnBeaw==
X-Received: by 2002:a5d:5847:0:b0:391:3f64:ecfe with SMTP id
 ffacd0b85a97d-3971cd5801cmr4438408f8f.10.1741967458746; 
 Fri, 14 Mar 2025 08:50:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:2b81:563b:c694:c380?
 ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318acfsm6084321f8f.70.2025.03.14.08.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 08:50:58 -0700 (PDT)
Message-ID: <50257462-cf99-42bb-a76c-b9ec9f6635ba@linaro.org>
Date: Fri, 14 Mar 2025 15:50:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Better smartphone support (Qualcomm)
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
 <CALeDE9Nm+ZV6_3Vs0CE1o8vngquRq-JvvpsdUOLceM2nxkf7_g@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CALeDE9Nm+ZV6_3Vs0CE1o8vngquRq-JvvpsdUOLceM2nxkf7_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Peter,

On 3/13/25 19:07, Peter Robinson wrote:
> Hey Caleb,
> 
>     Improve support for running U-Boot on [Qualcomm] smartphones, with:
> 
> 
> Is there anything in this that is QCom specific? Like should this also 
> work on the Pinephone phones which have either a Allwinner or Rockchip SoC?

The ideas here could be adapted to other platforms, but unfortunately 
the implementation itself (e.g. the environment file) is Qualcomm 
specific. Every device will be slightly different here and - at least 
with the current approach - it can't be made very generic.

> 
>     * A boot menu which can be entered by holding power during boot
>     * Hang on panic (so errors can be read on the display)
>     * Serial gadget which can be enabled by holding volume down or via
>        boot menu
> 
>     In its current form, U-Boot's boot menu is perfectly adequate, however
>     once an option is picked U-Boot will never return to the menu, always to
>     the CLI.
> 
> 
> I wonder if it makes sense to make this a generic option selectable by 
> Kconfig.

I couldn't really see a nice way to do this. The commands get run 
through the shell interpreter anyways.
> 
>     On a phone (with no keyboard), dropping to the CLI effectively makes the
>     device unusable until manually rebooted, since there is no way to run
>     any commands...
> 
>     To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
>     add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
> 
> 
> Is there a way to do this without hush, a bit of thinking out loud by 
> with this hush makes less sense, and compiling it out has the plus of it 
> not being available from a security PoV.

I don't think so, since we rely on the shell to run the commands in the 
menu.
> 
>     This provides for a flexible menu system which we can enter and exit.
>     See qcom-phone.env in patch 1 for more details.
> 
> 
> This over all sounds like a good way forward.
> 
>     Finally, provide some rough-ish documentation to describe how Qualcomm
>     phone support works and outline some debugging steps for when UART and
>     the framebuffer are unavailable.
> 
> 
> Can we make that generic phone?

The techniques described in the doc may apply to non-Qualcomm hardware, 
but I have no experience with it, and I know that a lot of the things I 
describe are Qualcomm specific. For example under what situations a 
Qualcomm device is likely to hang and/or reset itself, as well the 
framebuffer.

> 
> I have both of the pinephones, I can likely try this id there's no 
> specific qcom-isms, or if there's specific features I need to be aware 
> of I can see what they're missing at least.

You could surely write a similar env file for the pinephone with a boot 
menu based on the same logic, I don't think that would be a lot of effort.
> 
>     ---
>     Changes in v3:
>     - Minor wording/clarification improvements in docs
>     - Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
>        behaviour.
>     - Enable some more gadgets in the phone config fragment.
>     - Link to v2: https://lore.kernel.org/u-boot/20241004-qcom-phones-
>     v2-0-c7ab67ac3043@linaro.org <https://lore.kernel.org/u-
>     boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
> 
>     Changes in v2:
>     - Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
>     - Add Tom and Simon to CC
>     - Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-
>     v1-0-08614edd8e35@linaro.org <https://lore.kernel.org/r/20240831-
>     qcom-phones-v1-0-08614edd8e35@linaro.org>
> 
>     ---
>     Caleb Connolly (4):
>            board/qualcomm: introduce phone config
>            cli_hush: support running bootcmd on boot retry
>            bootretry: check for bootretry variable changes
>            doc: board/qualcomm: describe phone support and bringup
> 
>       board/qualcomm/qcom-phone.config |  17 ++++++
>       board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
>       boot/Kconfig                     |   7 +++
>       boot/bootretry.c                 |   2 +
>       common/cli_hush.c                |   6 +-
>       common/cli_hush_upstream.c       |   6 +-
>       doc/board/qualcomm/board.rst     |   5 ++
>       doc/board/qualcomm/index.rst     |   1 +
>       doc/board/qualcomm/phones.rst    | 122 +++++++++++++++++++++++++++
>     ++++++++++++
>       9 files changed, 211 insertions(+), 4 deletions(-)
>     ---
>     base-commit: 78f8c8c58f7d3f7c3a26af4afbd08aba21c14c90
> 
>     Caleb Connolly <caleb.connolly@linaro.org
>     <mailto:caleb.connolly@linaro.org>>
> 

-- 
Caleb (they/them)

