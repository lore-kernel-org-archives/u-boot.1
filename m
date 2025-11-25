Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A722CFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49A383FAA;
	Tue, 25 Nov 2025 09:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nBZNZM0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A4B83F30; Tue, 25 Nov 2025 01:02:24 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DEB83EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-657044fea68so2061357eaf.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764028935; x=1764633735;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqzmILeyIr2kdSU3kaK1YpQlqpstFrhl7jPxHXX56bA=;
 b=nBZNZM0IEvJO9BqBlb2IEj1BZyvCqs/HMjnOfO0F2PcPJheZRndl0dmCTg/nZGsiyy
 I7zJRP+55EIB4SJqimuRPK6wqA+Z9A7ye5MUSZCqaupOMIXIvMYFQG7ybVVtqloQupkn
 lVTLib0NwQs1I2tXsBU9CLcNxcRycVzMILMcgvCcBw00RTzMOS3EtCWSUWmOdoiY65M1
 kNSgn2wL4ass2QuqOuy0CouvGIuQE9Bp3kahCL+AtzYk3JQ/yWkcI1E+3BFGD656QCGZ
 NLO6qqGfGhrLdriyCcUbNeaQ3D0+MB4PHkLlWxIxFSX4jlcbyrcdpBzK7EGyvMefwnR3
 VNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764028935; x=1764633735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqzmILeyIr2kdSU3kaK1YpQlqpstFrhl7jPxHXX56bA=;
 b=StvyU09fIsyeQ1xbjo5n3zrrfWUpiXjM/h3FIORrdsi7ILgu7HspwlGujV3lLpBpB5
 j5uxtZt9mUUSwJSTtZwIY2fETT6hZ4mJ+sP9UWD0H3/LamQMsVoOJKMX0lkhfWkWXefL
 9uscz/G4NOnlVjrHlrT8eW1npfuAPth/sbJqXlwflLadSiNgDZ55ExFOlldamgJil1Pm
 C/l+LwZrxYO10px/PZG4l1xNDfkgG55B8x0wBa/O1E/JfffZ3QCp0rlof2lSoxBUa9qt
 wvAvqJkGNkBd3AZVoCtwZiEGd5ZIfFr/cXllzMYngJFzF6BPwS5cp/ZAkCMFZkEq2gFZ
 biFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh+FhAQxMbO0L9dqAHHzH6odGrebUumVsTWi8mmWFBGUwUx7MPAJQRK2lUohOCNoY5RkvM6A8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj05zeDdKkO5eh9K74hgYb3sr4kFADi2ffxEJOsvW2oF2JXqvd
 oiSbjTWClBgSdtfIf1KAvGXsQAqyy1/FUcP1VXDw2D9hmn2W+iyD6fCpmF4lPbvJLGA=
X-Gm-Gg: ASbGncv4OwPLhUGoHCAMnP4tx5jhiHSiMprbe32GRLlfFOPl2yFOMW0vyfC6dA7NYGi
 zESuhJJqOoSIW1KqVnBVhMGUsTZK/KGbevZjpLAXrJUDvEFOQV93WaTQPuLnXvrG/upC2lzgTto
 /fSLtXkKkl1fFnrA0i0obwN+6t7F9R7z5jADswuvrhrn+HGXSjfQi70yRHXUhDJKg99c/gMwPdR
 QTYjkqbkjkB0xJkX2RNOBC8IkJduOHkREQC/VtIPKeM5xLyhZ3G60P5HtjGoN4i4RgDCm8a9bGJ
 +5zrC++qSLiNRMqliK6PjuJZQzACA6LUiligns32F+4Gz2KlFwYBtzG634IIf6oIJgONvlrtleH
 9XTcOK2mGK4HZZWF+8461DKu6UHPz9ZxjRHDjVC4bWzDxqOPwlcJsYVVe3KKlluBNpKK8jWj+Pz
 d0fyCCxzrybJLJomLRqcDa26HWpDnTlY6bVHY5iThFyqhq4+jKu+JsevmnEw==
X-Google-Smtp-Source: AGHT+IFtw2D/SUwB3V4FAVpR0bPVe6uJH5EZDE4VsYFfdLF3mJDeCnPZn5eIU0MrSbGO8/YU6PBlbg==
X-Received: by 2002:a05:6808:1987:b0:450:dce4:8a with SMTP id
 5614622812f47-45112bde0famr5641012b6e.31.1764028934977; 
 Mon, 24 Nov 2025 16:02:14 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8a36:4d72:5018:118?
 ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe65cfesm4158285b6e.7.2025.11.24.16.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 16:02:13 -0800 (PST)
Message-ID: <05e3f326-fb94-4d32-8d50-218feb114078@baylibre.com>
Date: Mon, 24 Nov 2025 18:02:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: pytest: fix hook script environment variable
 names
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
 <20251124-doc-pytest-fix-script-env-vars-v1-1-fec5b54007f1@baylibre.com>
 <d4cad994-e978-4319-958a-95371224ace8@gmx.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d4cad994-e978-4319-958a-95371224ace8@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

On 11/24/25 5:46 PM, Heinrich Schuchardt wrote:
> On 11/24/25 23:44, David Lechner wrote:
>> Fix the names of environment variables set for hook scripts. These
>> have a U_BOOT_ prefix, not UBOOT_.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>   doc/develop/pytest/usage.rst | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
>> index 7335a39b9633bb16869dfc976adab32d78dc984f..7c42a31528fd0ef78d3e24f65ee86ce2d61d6e87 100644
>> --- a/doc/develop/pytest/usage.rst
>> +++ b/doc/develop/pytest/usage.rst
>> @@ -315,14 +315,14 @@ Environment variables
>>     The following environment variables are set when running hook scripts:
>>   -- ``UBOOT_BOARD_TYPE`` the board type being tested.
>> -- ``UBOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` if none
>> +- ``U_BOOT_BOARD_TYPE`` the board type being tested.
> 
> I checked for the variable names in U-Boot origin/next and u-boot-test-hooks.
> 
> I could not find U_BOOT_BOARD_TYPE via grep.

It is because of:

    env_vars = (
        'board_type',
        'board_type_extra',
        'board_identity',
        'source_dir',
        'test_py_dir',
        'build_dir',
        'build_dir_extra',
        'result_dir',
        'persistent_data_dir',
    )
    for v in env_vars:
        os.environ['U_BOOT_' + v.upper()] = getattr(ubconfig, v)

Between this and the next patch, the docs should match this list now.

