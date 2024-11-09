Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07831D5E387
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 22:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1381388EAB;
	Sat,  9 Nov 2024 23:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BUz5U1WH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE073890C1; Sat,  9 Nov 2024 23:55:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B678885D
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 23:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E0E623F29B
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731192924;
 bh=GQwjrYH/6ZCEE+1nqbROmDtEcmYBB8iPLfmWFv0e+rA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BUz5U1WHw7yOq9BBDy75r7KFGwvUZZZEcrElsqYBOtknQf0CXW3Qnf0vO7rKRj6FA
 7nXGifhqS9dT7JhXPjXXur6Zbt0XezEzFbjAUKGNddUDbdsrS9uUlpqQ75Hhu/wJwO
 3rZK2IfzLuA3up73g1J1XBkcnTEzUI7em/nxYa5QGjL8szDc4V3byMZDN0PjLPSC01
 fJUVcaxhHYbH2JETXvdFHmdu8GxmgWppkRknimYxg3fbd7DXU5keOs4uY47RM1clwn
 DDWHwzMvWaXG2Yz/MwyrzSbH3eeyuYKwEHh+1Vy25x/LK9YsufNGHQ3fn003gnVFpU
 S3UBKYCTsaLXw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so2579855f8f.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 14:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731192924; x=1731797724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQwjrYH/6ZCEE+1nqbROmDtEcmYBB8iPLfmWFv0e+rA=;
 b=MnimHEJYkenWty6nYtMYbhLPIxirTGNzqrUBNgpe8Q4RzO+8sg4MXA4WD5PtnsBBgW
 gzRp1oVz0r7VnXHvgX/I6Fd3amGCK3gVZHjThzdKowk5jg40eauDL57ZPvMJq/uWhGha
 4h8HmaALBtXdKKukG/V+I6IjToNC4FF7e0VEjWDd5hMCWaaK2H3NYLz3HjW03YtgOtjJ
 qqJjZF/tnZgdfd0hMcmTH41adE7jpKBQpUu42PVhCGfWgVtZPg+HNXf+nK2I22lLyld5
 +7MrrUmGqu/QOAg+lIpUAxSJDmEAdCjyxlRO63/eY8d29ME0a9j3HTsoAq31EkpftomN
 WnEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxZFwk+IqkZOtH7IyJ5IPpzsBVu4Y/FONgUdY/+hL1syEcIH+t1RkW8emEJIL2T83KE0bKtc4=@lists.denx.de
X-Gm-Message-State: AOJu0YyBYd+Owl2ZMeHJeI6LK4UK4LTVdzUXkliEoSxuMPXXQNDgLz1s
 ukjLwMFvErR08dD6QdcDIrAN3FhUq/EPYb1CFZV/qTim8yTsKbs/xKavipplKr2rYeJQDg2c8Xe
 1srkr2okL8mk9zRCTJiBPwC4OUX0b774wWbMK8hcZh1SB1Aal3e7ZuS25T1FhyhuTqQelNk/9ap
 WirA==
X-Received: by 2002:a05:6000:4107:b0:381:f587:1c2c with SMTP id
 ffacd0b85a97d-381f5871d05mr4529443f8f.20.1731192924329; 
 Sat, 09 Nov 2024 14:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj4D8yQPCLRg9WW+rXN0qfl020BT8yj3GsDl6XhVDsHpsr7D1vC41CCLvVzotQmKLrckYSmw==
X-Received: by 2002:a05:6000:4107:b0:381:f587:1c2c with SMTP id
 ffacd0b85a97d-381f5871d05mr4529430f8f.20.1731192923874; 
 Sat, 09 Nov 2024 14:55:23 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa709ec7sm161656345e9.35.2024.11.09.14.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 14:55:22 -0800 (PST)
Message-ID: <a6cbb2d2-d346-45be-9edd-22b1d4901b88@canonical.com>
Date: Sat, 9 Nov 2024 23:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241108152350.3686274-9-sjg@chromium.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08.11.24 16:23, Simon Glass wrote:
> It has become more common to use config fragments to extend or adjust
> the functionality of boards in U-Boot.
> 
> Propose a format for how to deal with this. It is not implemented as
> yet.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/buildman/buildman.rst | 39 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 924564b5700..48705d0e49e 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -1148,6 +1148,45 @@ like::
>   This is partly because there is no way for Buildman to know which fragments are
>   valid on which boards.
>   
> +Specifying the build matrix with fragments
> +------------------------------------------
> +
> +In order to build boards which can use fragments, Buildman needs to know which
> +fragments are valid with which boards. The following scheme is proposed, but not
> +currently implemented.
> +
> +In ``defconfig/``, files with a '.buildman' suffix are used to effectively
> +create new boards for Buildman to build. All such files are processed, but it
> +might be best to put all the information in a single file for now, e.g.
> +``extended.buildman``.
> +
> +The syntax consists of a number of sections, each introduced by a name. For each
> +section the fragment file is named (without the implied ``.config`` suffix),
> +then the targets which can accept that fragment are specified, either by their
> +board name, with wildcards, or a set of ``CONFIG`` options to check. All
> +``CONFIG`` options must match for a board to be included in the set. To specify
> +multiple fragments to be included, add them in the order which they should be
> +applied, one per line.
> +
> +For example::
> +
> +   # Build RISC-V QEMU builds with ACPI
> +   name: ACPI with supporting boards
> +   fragment: acpi
> +   targets:
> +     qemu_riscv*
> +
> +   # Build Android variant of 'k3' boards, with DFU
> +   name USB DFU for am62x boards
> +   fragment: am62x_r5_usbdfu
> +   fragment: am62x_a53_android
> +   targets:
> +     CONFIG_SYS_SOC="k3"

Thank you for looking into this. I don't think that we will have to 
build every board with each fragment. But for every fragment there 
should be at least one build.

qemu-riscv64_smode_defconfig + acpi.config and qemu_arm_defconfig + 
acpi.config would be enough for acpi.config. x86 anyway uses ACPI.

Best regards

Heinrich

> +
> +Buildman normally ignores these files. To request that Buildman process these
> +extended new 'boards', use the ``-X / --extend`` option. Note that this may
> +significantly increase the number of boards which Buildman builds.
> +
>   Building with clang
>   -------------------
>   

