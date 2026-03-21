Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6589C1094472
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 12:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615AC83F00;
	Sat, 21 Mar 2026 13:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjncdxmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3F783F9B; Sat, 21 Mar 2026 13:55:07 +0100 (CET)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1282483E48
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 13:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2c0f754e756so2715704eec.1
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 05:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774097702; cv=none;
 d=google.com; s=arc-20240605;
 b=Q/dRV6/fwoZ391ueNngl4w5knnqUJd6PKTIF648Qi4muCfU3YG0hH90e/A2FlxeOYE
 P7h4dfOcEBoDjPQc6uyXJvKAgGJUl1gEgG7vPnng7vIBjraWmirAM4J/HOcPCc9khlvA
 eq9Tgnd274iN2yVG6ZabfM3afl4OeRb4/sKGd9owRbxO71jStHD89O6GPLM4H77UzzTc
 MTnT0OD3OMv5oBFgXMD7bsP3IBIC1zmY4P/WhFOxNAiQevi43amz0RTKDX2PtYg95+W6
 WAudu60/HuFZZdT2SaW2fugLkDvcH4zWFWQgaW8cFzk/dIWZ2RRusK3iioNbst839jQJ
 thwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yPQ3zAaTCre/8ZGDJW9QLtOA6XlPbld6wj4YhEoMoB8=;
 fh=GQyKwPRr8dOXk65gAXuiKSXcuQM8h6Aog4njpiF9nLE=;
 b=ZIbWD7sYer/oPQXXE1399c1jKkYufyeeTYP3Yzqpi0+5RPG4ZYTnZ0LGRR5jSLmzko
 W+JXfEVGEjYzikC2U4bXVCwo9IQk6S0+R5x9CA7CUXomhh4eF6y2gBtnL4BaTwq4F3/W
 EoOdWyv3CFV+FI2y2mnARqVVjC3ofO3eKmH39SOOzTK+HqeOYbPdbMwUJXrm2ngeZQsm
 GVVL6vOljwrxdJ0JG+MBiTsRUxjfG55B+KXcWmTzboMBbAk0VS5VlQozRq+5l2EBc22U
 fJme1rrSki7lr8tvcjIXHlLbLMWtzSshb4wf1bK33pbggBka8qO4O5eShbbQkh7a8jIA
 9JVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774097702; x=1774702502; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yPQ3zAaTCre/8ZGDJW9QLtOA6XlPbld6wj4YhEoMoB8=;
 b=FjncdxmE3BnF8/tmbFAEr1shVN1Wr09JZqJVc3QbUvUMrHJjm2CaWb94k1k8rP4Li3
 if+6naj55EbaH25BLRa8gZV1XvgNJTF59+Rb7SzD8oLiUNDFpN0rOn+5Uv/ooIXPzXTv
 liXS56MM211K2vyqCVjQ9Z0jWbYruAl5zWsm7YN57PeW1DPpTAa52poZw8hWJurzb0xP
 sdsCC5x6kmIA06zIAeV5qYQvGRRcHvL2bznbf4zgR0fhj5JN882XMCUaz1n2lDPIbAFD
 dpH7zguY4GDwiWWheIcMsWmlU/1r5d9WnurYa/fJuj2hX3enVL6LkVOsL14+Q4VTz6TS
 kALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774097702; x=1774702502;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPQ3zAaTCre/8ZGDJW9QLtOA6XlPbld6wj4YhEoMoB8=;
 b=MDk1vkWA1UiULDPDqMp2m/yhLbzH/shCRe+jaL6cg0d0w97lqBrowFp+wZvFxDVkCK
 /jNBABqcoiww4DVfqpRHlJkRWv1HN3NDZNyv0BFKCG4KIdv0B5yFEbf3SRjquSOrNoX2
 nOHrBpJK4em5ojgJiSpTn6qY2BcYQFNZmdeAb4Gn7VbY9TWfZt9Ivywcquzn/AuzMfo2
 0Q64KA99FguW6uPeGL2aJGrxMYnXLQz4cW1KZwVA3H+Trdojljq2VGvPG82V6YxzBNfw
 b533PVl3Mg7HiW8beiTKvyWbslJ7ehLSDOHZvGfCEGLF1GpNuikyZZ/7iid9bPG+87MJ
 RQHA==
X-Gm-Message-State: AOJu0YzKs7wdKLGzNN98eNTsqGd7MYE0ZVCrUYaBTESkG2aHV3c/9TqA
 PIFK+pWPBwufs7JHy0frFLiNp1jNyakqWEV79TtZh8MkntNGmiOisaentJ2HyM3rm/Bip5Upzlx
 2CaCNta6JMFp9UWvsFL6hruv9HdDEPFBaA/s+mQE=
X-Gm-Gg: ATEYQzzDBa8tS1wrSyDpyIj3w8VhW7N6DaBXxWqgr//DVr4fQYvTcr2Yu2waavU6NNC
 ry4GexzD8TN2Q7yq+GCgnFlOaQqLQn+ts/kVfe6/tbtxbMLSRx4hbaRGkZUvo2h+b4cRv+xtB8S
 qi9TVFN9K6OiVQ4HPKQeyDHieOxwmuR8drAAkEuox2pqsiy8a0LzzC7PqFxwbvVl6ab0//Li/hl
 QywHkbGISmEtdM1P0bK5K54hwkjPVxM9ysmG9AnxbzrD8eOJJYQxP523ZsvF7vkQEwfJjEBmTSW
 SXEHa4oz8OM4pPQ=
X-Received: by 2002:a05:7022:fa9:b0:128:d1cf:8ab with SMTP id
 a92af1059eb24-12a7263d773mr2658989c88.6.1774097701812; Sat, 21 Mar 2026
 05:55:01 -0700 (PDT)
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sat, 21 Mar 2026 15:54:49 +0300
X-Gm-Features: AaiRm52NtworBSX4gPvetHSG-8FSid2WDykuUvmr3S0UnKCDfwSPAjRDOA_9vXs
Message-ID: <CAJs94EYWoVAyWXexA=f_UwqUpo9zuxO6G6Tx7L7xPdciAVHW5A@mail.gmail.com>
Subject: Need help with FDT overlay
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hello,

I am running U-boot 2026.01 with orangepi_zero2w config and I am
trying to apply my hand-written dtbo via fdt apply.
The issue is that the fdi apply command just hangs forever for me. The
issue only appears when I try to append a new node to the root. How
could I find what is going wrong here?

The overlay source is the following:

/dts-v1/;
/plugin/;

#include <dt-bindings/i2c/i2c.h>
#include <dt-bindings/gpio/gpio.h>


&i2c0 {
    status = "okay";
};

&i2c1 {
    status = "okay";
};

&{/} {
    i2c_gpio: i2c-gpio {
        compatible = "i2c-gpio";
        sda-gpios = <&pio 8 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; // PI0  (29)
        scl-gpios = <&pio 8 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; // PI15 (31)
        i2c-gpio,delay-us = <2>;        /* ~100 kHz */
        #address-cells = <1>;
        #size-cells = <0>;
        status = "okay";
    };
};



-- 
With best regards,
Matwey V. Kornilov
