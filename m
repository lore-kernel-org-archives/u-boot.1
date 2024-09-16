Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF35C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 08:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B9988E2D;
	Mon, 16 Sep 2024 10:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTWpvdAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD28A88E88; Mon, 16 Sep 2024 10:24:52 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BA488E26
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 10:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-535694d67eeso4017783e87.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726475090; x=1727079890; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSCD+KHJ7RdVHQ0DFkbK0MLVMu1Ghfv0CzdSykDT47A=;
 b=aTWpvdAIPV2lGLCelcevhLOeW2SKhUYo6iqSGRj5+ZLJTlMpsK0RGI6cgvT4nWYFGM
 TDE/G+11uVn55gEnHmHrPcsuKBeWTiAJKed865bPoOXTOUUffIrlE5bS5t6vd1tRPl7L
 DDOZgxAunufh/IGdh6q0RoTj8Vkc3c3b6ar3oB+O7v0Km9y5zp3p3gM8Himgw+NzejJQ
 XLRHcqoel2rLPvIdvTH+lDEbaIpOOgU+QL4OdrFAqwhUY3WjXT8Istj2/3INk8/jRRo+
 XlmtoZWXX9zCmtZT2Y/4auNjr9I3UmFedQ+lKJ32NJ4MxwszKF0UcDHsRZi4yxUPvsyr
 W60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475090; x=1727079890;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSCD+KHJ7RdVHQ0DFkbK0MLVMu1Ghfv0CzdSykDT47A=;
 b=WJzungJ1RxUJOiVrL+tjhL9fvmcblAGJeytHZ2H0Qm/5EK/SexYIqY/Nx+Sdo7EHFL
 u0sEJhzSSWGk9ZEug/+maEYr2y9IipFbMbcweXnpWvlgkdZCnq/QIbx2Y2A76GuUwg9Q
 ebfC636kXu5kVXGlLKlb0zCumLQ5/N7wWvU0c5b7ayAjZb3Y6V6RrxJ4mCsGuNGTmVdF
 MWyfV8huhAt3o7TuOnEzwevRlQz2jCLvgXe8cLiBftsyklG5jsEBt5vKQgwl1h6ijUMk
 nHh2DRkxXH2PsbZCwp1DNAYb0ktLQcFaPUusZcuGn8EUYwOVhdjv8Hc1K9XN1PV7QLen
 8gpA==
X-Gm-Message-State: AOJu0YwfPG4YXYucqxveAgxGPT9tAEVNM0j+5sl1RqnNVo7WGGS+3Jg0
 3ZobU43YSlYm22FiIXnoK+3qkFKdTSQoDL9tEY9cbwl+7tSSTkVz1fP9kg==
X-Google-Smtp-Source: AGHT+IGB36SHpV4Rhs9BfH0oYIcTQgUsUUv7kQ82cOru0+ytr+kzVBfA9iluePj2fBLBTOBu7pmMkg==
X-Received: by 2002:a05:6512:3188:b0:52c:dc06:d4ad with SMTP id
 2adb3069b0e04-5367906db3cmr4184361e87.6.1726475089230; 
 Mon, 16 Sep 2024 01:24:49 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5368704dca5sm804367e87.111.2024.09.16.01.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:24:48 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 0/3] Implement signing FIT images during image build
Date: Mon, 16 Sep 2024 11:24:43 +0300
Message-Id: <20240916082446.32082-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
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

From: Alexander Kochetkov <al.kochet@gmail.com>

Hello!

I've done verified boot on Radxa Rock 3A. I've embedded public key in U-Boot
SPL and signed FIT image configuration. All the work was done during U-Boot
image build. For some use cases building and signing images in one go will be
much simple, than building unsigned images and signing later. For example
SPL-image for rk3568 called idbloader.img consist of TPL, U-boot SPL and
U-boot SPL DTB with public key. So in order to assemble signed idbloader.img
lately we have to keep all the intermediate files used during build.

To embed public key, I've replaced u-boot-spl node with blob-ext and generated
u-boot-spl-with-pubkey-dtb blob using u-boot-spl-pubkey-dtb entry.

To sign FIT image I've used newly implemented fit property 'fit,sign'.

I haven't sign FIT image nodes, because I had realized that signing
configuration is safe and sufficient for verified boot. But I doubt.
So I've left that signing scheme in the test.

What do you think, is using signed configuration and signed images at the same
time is much safer or doesn't provide any benefits?

Now I thinking about implementing configuration option, something like
FIT_SIGNATURE_KEYDIR. The value of the option will be passed to binman
using -I.

Alsi I want to embed another public key in the configuration DTB, so
it will be used to verify kernel FIT. But I couldn't figure out how to
do it using binman.

&binman {
    u-boot-spl-with-pubkey-dtb {
        filename = "u-boot-spl-with-pubkey-dtb.bin";

        u-boot-spl-nodtb {
        };

        u-boot-spl-pubkey-dtb {
            algo = "sha256,rsa2048";
            required = "conf";
            key-name-hint = "uboot-spl";
        };
    };

    simple-bin {
        ...
        mkimage {
            ...

#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
            rockchip-tpl {
            };
#elif defined(CONFIG_TPL)
            u-boot-tpl {
            };
#endif
            blob-ext {
                filename = "u-boot-spl-with-pubkey-dtb.bin";
            };
        };

        fit: fit {
            ...
            fit,sign;
            ...

            configurations {
                default = "@config-DEFAULT-SEQ";
                @config-SEQ {
                    ...
#ifdef CONFIG_SPL_FIT_SIGNATURE
                    signature {
                        algo = "sha256,rsa2048";
                        key-name-hint = "uboot-spl";
                        sign-images = "firmware", "loadables", "fdt";
                    };
#endif
                };
            };
        };
    };
}


Alexander Kochetkov (3):
  binman: fix passing loadables to mkimage on first run
  image-host: fix 'unknown error' error message
  binman: implement signing FIT images during image build

 tools/binman/btool/mkimage.py           |  5 +-
 tools/binman/entries.rst                |  7 ++
 tools/binman/etype/fit.py               | 57 +++++++++++++-
 tools/binman/ftest.py                   | 95 ++++++++++++++++++++++++
 tools/binman/test/326_fit_signature.dts | 98 +++++++++++++++++++++++++
 tools/binman/test/326_rsa2048.key       | 28 +++++++
 tools/binman/test/327_fit_signature.dts | 98 +++++++++++++++++++++++++
 tools/binman/test/328_fit_signature.dts | 61 +++++++++++++++
 tools/image-host.c                      |  2 +-
 9 files changed, 446 insertions(+), 5 deletions(-)
 create mode 100644 tools/binman/test/326_fit_signature.dts
 create mode 100644 tools/binman/test/326_rsa2048.key
 create mode 100644 tools/binman/test/327_fit_signature.dts
 create mode 100644 tools/binman/test/328_fit_signature.dts

-- 
2.17.1

