Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41878C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E267810DC;
	Thu,  3 Sep 2026 13:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6dHfRN9pyV8; Thu,  3 Sep 2026 13:10:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B55958100C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441009;
	b=P8oFBEzl6BYL4KPAt1izce00l8Rh7bH0bkatzGC25CUuaNTNBVWRKJDfdtNzxurHJMNa
	 47W7q6Izw/QhgKcaPr/fIaCqVAPpF63u07PSWTV16XkfZHuHuQX1n8s4E+rqlzH2lIjqY
	 CJj0KuijQjzYf1HtPL+qOklQXT09FKMOIEEsdthtcw42UMy1AXQ2yJBHWfPH6PjtO7183
	 77otK8qLWiI5oWFt+kQ/mElS+QW1tULMNT2ZI13ONGhVVVLqPt0bVPumXWxlMcjPaRt8U
	 RP4ltHuFtWSQ5/ZFiEpdQWuvuzcP3GGEFYsaNNGxZI49lBO1rvujQ/vQRoHpw/IVsxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zAm2FdiTSlR8t21yb6XUiVAMl8NzT4Nl61G8jAGAxtk=;
	b=rTpq26PWAaYi6CkPprjkHkr7LXyXuqTzvKgTCssJlOJv9ZKwQ8qG5GznwBCiS1dRQI41
	 71yVAa1yKU6lRScKsDDW2UBos3i49DU+QPJ3ePAMkyEXmAuaHwbO9RQLwprg+aUzM4pd9
	 2d+ypMG4kLx2iNyqTel8URL/HerprFICgxZwyolL8uXTyGwc2CEAas33Eu6vzkVHvU4NZ
	 q4v1bkag5Zx6Ci/IXNQAY9JgNYHrH9OfoKzFOHxt34n2Fxv469CpDZyFtMBNrlEGjH24H
	 BgSLHIFI4Q+ZhNy//nve6kntL5Ydu0UBrLeo+Ydmp2LEG0SPCCzdcdFp1+KzMyKgBSA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441009;
	bh=zAm2FdiTSlR8t21yb6XUiVAMl8NzT4Nl61G8jAGAxtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5+tuklsWHptEuVrCGMtrDitzfFdFXdkD+zPlJC8LiQPZq23Hf5YbhYHQynGmKlD9
	 RtzeWszulnJ/RspWW/cbYT19vC8ul0pz4Hqr/J/se4RGTjWMFQ2cVWvD0q6OCR2rCT
	 jm4mpY+1/iJDuwIDgKbu90zaAOqTB8eheYMsheWDzyTl33tvn4uEzTTsabaNiVl8w5
	 +/MmsCnHIU6m6o1UzscD7FKpZ0zlsY2tmXPi3RhjyIZgvk1pZO4/AIjD8NIXWUPf9u
	 aWyHzCI4rrcZ7ZIhdUhSX9YTVY9ABuAZeGaue27Pe7M+WsoVegi3i8wYAMbSUO71uw
	 9ae2jayr/kSQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B55958100C;
	Thu,  3 Sep 2026 13:10:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BD46498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01D5C40462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fn7vqg4RPZsH for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9A96A40454
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441004;
 b=jg8u65yvuJQnSWXC30XCY0JSgTZOa0prWmgKnoY3BimwENgzQRXNJplnR6DGzW+WKI/M
 CxK6PjiF3vYzAzdiTn5R8e1SodG7KKoCHjpyw0YgT1gg3xLOUaC93Hm1ezZAz3qUZGWsR
 bL+GdVc17mLmLKkU5Nyt6OtU7gTtDogkcUL+OEok3bTrAt+7+giWijqVIg/tw293XD1HN
 xJ/90fUohw7oGr9/kYntb6WjkIm28wjjE3PkXm13kRlwS7X0LkIOAkkLp+20XRDT9hC0i
 BQQyl409wKWgsDWylCbA6KLasrRMp2JmDB7mCakrqZrU74zDu2i4Q5zoY16K6YWkkOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441004;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=zAm2FdiTSlR8t21yb6XUiVAMl8NzT4Nl61G8jAGAxtk=;
 b=RqcK38xvS3fWBJx0R4kA1PPj1jyCorL5PKeNXC3BsRMo4/2Ga1JPCWBHF3XFqvl2aiMv
 E3WmWKF4ZmXUnNS5QnFmlTBZeCHTRtfG2QnWYKMo3D9W+09DTNu55whr4+7oQkg8oZboB
 O4sh5u6N31/fHaBoKguINU8ec3lfGxySu+cwey6wPtAdSK/bFNYAww5UhOimvPwn5eJwW
 keUwvy4aHFOiSkcNkDGe25YLjyem/TCSj1YteO0J9TGNmH12g51tLvSrh0T6zpvpbXjro
 u8Kb73roCLRCTt/JiwP2wSudh6RxdxIa9zHBjjeQy4cPyNeQgAuE3Zxmt+0rSpdChcg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=k1L5gY88; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k1L5gY88
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A96A40454
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:03 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482f9309813so2216825f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788441001; x=1789045801;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAm2FdiTSlR8t21yb6XUiVAMl8NzT4Nl61G8jAGAxtk=;
 b=k1L5gY88FkNTu88xwRlTUACjiTXjoINh40T/s0EhJfIEBnxQXKjvQHyLH7Yg48YKp6
 HWgEtOhSQeNyly5Ey7TJtC6ZnFnBYQj+Z5s5DcL/+CWZQ6ZS9D56DYYtn9Ryehd1hvdQ
 lvUDSTbinzw+tuQVWVOT6lDUqp8nVsvfzbj14TghPn+B3jOWyjGRHzDyYdjuR7zE5ThZ
 cBGszYuJfiWKl6+O8aAQ2T4PkON4KGMoXiOElGydlGOvnh1Rcvz/QwdrQIhHl2c1CIdj
 ZjesS3MNO7aipWdeQyHBiMB6mSbqDnJtJ8zwoKKNQp1t+mdMVcwvZAkRFw7nhAR2avgi
 Hq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441001; x=1789045801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zAm2FdiTSlR8t21yb6XUiVAMl8NzT4Nl61G8jAGAxtk=;
 b=X6zXW2V2DI/nMKk2x1ni/Bref8OJ3L2nyaAg/SItkAzYlzAJOFVVJy4+C3aPh0qwdD
 2J5w3IISIzvOxOfYpIdh1nMwz2VZBUEcOogMabawPBUvXxbQre6zzOkytUllZAhOUr5L
 VX9r7ynSXcdI0oLG+LITe+DtHYMKVtYbthRJj6lBv1Ab1bIf3gDimjlh8jgqhPJV9lXl
 jQb6snEAS8RnKyXfDiRRMHGrPgmJ5IQc2T0S5QtWxwBsOFr2aANq+i9jBm5tK3vds9GN
 XmPPr5poiH5OGoFE24QxG/6MlHO8Xamh6hhUlB8IYCOcCtXWlEMz5Hhsx6P+Py6PP+Rn
 g43g==
X-Gm-Message-State: AFuF++ka2A07ARfLvBp0ukK8WYZV+ddSmVB3N9Zn0WGg/Eg3f8coB8O9
 ijlJQc5sfNMWQ9Aj3w5xkgFXOyjTeqtDTpqzn9kKrgfMxryQ3ZGZByFzP7PeOgxDq4Q=
X-Gm-Gg: AYBFou2+PGUSVVV5e33zgkBYuq3TpP80o5CJN/4w4+vbMz1k4ABqKpEL4GWqaFkSQ+v
 634p5Dlh9D+3U3jvJfKkNvVlTy3hfRBbMuXMY2fpHQ8WUdHLVA1mjoJkggcNP6U+cFUso2TxrR8
 i8Y0/bhy147kpENXKBfq1JcHaspmKJl24IQLbWITyf+lvwQGJQmmuA8ZTgdOamBZszbIBbmc7hw
 T6QLP54tYW1QzwMlPJ2fZb885TAwCnwyrxMvMxMbMG9qqFT99m/OkE2Idmf9k+xVylpA3v+P4fm
 h8RICBYl5BzGP29iSoiFAhWmx6bxtCEuj3yqlpsM5+WtA5XHjcbuqjCvYfMTrrrjSW2rwTjFe2e
 KotaTNXQP33I3lKthg7jZmCB6UrbQq0Ytv5pN6emDrUVrrc+pfWaH9l/eEKPMhD17Utk+p77g3c
 UI4HssILV/61W0cFY9b/OVh1DUleswx4v9EEHJQCb/vntKL1J5d0Vr/ToHEZCLC4QOa7jQwdQPZ
 xZ6X111io11Y2G6cCY0qtL3/MQ4Y5oy2X8wf1RDY7x6860xXMLEXyQR+i+wxk6pwlVW8PuEnG2p
 gT6A
X-Received: by 2002:a05:6000:2212:b0:485:1bcc:67f8 with SMTP id
 ffacd0b85a97d-485860bfc30mr138006f8f.13.1788441000814; 
 Thu, 03 Sep 2026 06:10:00 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:10:00 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 03 Sep 2026 15:09:49 +0200
Subject: [PATCH v3 2/5] boot: add a firmware-owned devicetree source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ccaione-upstream-ebbr-v3-2-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Platforms following EBBR / Arm SystemReady DeviceTree keep the
devicetree in firmware-owned storage, updated independently of the
operating system, rather than shipping it in the OS image. U-Boot has no
generic way to source and assemble such a devicetree.

Add a firmware-FDT uclass which loads a FIT through a storage backend,
selects and verifies one configuration, and assembles its base DTB and
overlays. Each backend supplies the FIT while selection, verification,
assembly, caching and consumers remain storage-independent. Require
exactly one enabled source device.

Implement the first backend, 'u-boot,firmware-fdt-block', which reads the
FIT from a filesystem on a GPT partition of a block device:

    firmware-fdt {
        compatible = "u-boot,firmware-fdt-block";
        firmware-fdt-store = <&mmc0>;
        partition-type-uuid =
            "384e979b-eb76-435a-a3a6-1a071dbad91d";
        partition-name = "firmware";
        filename = "fdt.itb";
    };

The 'firmware-fdt-store' phandle points to the media device, while the
GPT type UUID and/or name select the partition. 'fw_fdt_part' is a
runtime A/B partition override. 'fw_fdt_config' is a runtime
configuration override for boot policy; otherwise use compatible
best-match against the control devicetree and fall back to the FIT
default.

The compatible suffix identifies the backend. Future drivers can load
the same fdt.itb from other firmware storage, such as UBI on MTD,
without changing the FIT contract or common code.

Cache the assembled result in the source device, keyed by both runtime
selectors, so repeated bootflow candidates do not read and verify it
again. Add separate Kconfig limits for the input FIT and assembled FDT.

The loader is independent of bootstd. Add firmware_fdt_stage() as a
generic staging helper for its initial EFI consumers. Make -ENOENT mean
only "no source configured"; once a source exists, a missing partition,
FIT or configuration is fatal. Reject load addresses, external data and
configuration chaining, require every image to be a flat devicetree, and
verify every image before assembly.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                               |   3 +
 boot/Kconfig                              |  49 +++++
 boot/Makefile                             |   2 +
 boot/firmware_fdt.c                       | 303 ++++++++++++++++++++++++++++++
 boot/firmware_fdt_block.c                 | 143 ++++++++++++++
 boot/image-fdt.c                          |   3 +-
 boot/image-fit.c                          |   9 +-
 doc/develop/uefi/firmware_fdt.rst         | 118 ++++++++++++
 doc/develop/uefi/index.rst                |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 160 ++++++++++++++++
 doc/usage/environment.rst                 |  13 ++
 include/dm/uclass-id.h                    |   1 +
 include/firmware_fdt.h                    | 106 +++++++++++
 include/image.h                           |   5 +-
 14 files changed, 912 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e41ff7700df..c8d0c8c9654 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -902,8 +902,10 @@ F:	boot/bootdev*.c
 F:	boot/bootflow.c
 F:	boot/bootmeth*.c
 F:	boot/bootstd.c
+F:	boot/firmware_fdt*.c
 F:	cmd/bootdev.c
 F:	cmd/bootflow.c
+F:	doc/device-tree-bindings/firmware-fdt.txt
 F:	doc/develop/bootstd/
 F:	doc/usage/bootdev.rst
 F:	doc/usage/bootflow.rst
@@ -913,6 +915,7 @@ F:	include/bootdev.h
 F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
+F:	include/firmware_fdt.h
 F:	net/eth_bootdevice.c
 F:	test/boot/
 
diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba493..e51094fdd25 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -194,6 +194,55 @@ config FIT_BEST_MATCH
 	  If several configurations match equally well, the one named by
 	  the configurations node 'default' property is preferred.
 
+config FIRMWARE_FDT
+	bool "Source the devicetree from firmware-owned storage"
+	depends on DM && FIT && OF_CONTROL
+	select FIT_BEST_MATCH
+	select OF_LIBFDT
+	select OF_LIBFDT_OVERLAY
+	help
+	  Source the devicetree from firmware-owned storage rather than from
+	  the operating-system image. The source carries a FIT whose
+	  images hold the base DTB and its overlays, and whose configurations
+	  name the bootable combinations. The assembled devicetree can be
+	  handed to the OS, so it can be updated as part of the firmware,
+	  independently of the operating system.
+
+	  For secure boot, sign the FIT configurations and enable
+	  FIT_SIGNATURE with a required key in the control devicetree; the
+	  standard verified-boot policy then rejects unsigned FITs.
+
+	  Storage-specific drivers provide the FIT to the common selection,
+	  verification and assembly code. This is intended for platforms
+	  following EBBR / Arm SystemReady DeviceTree. Say N unless you are
+	  booting such a platform.
+
+config FIRMWARE_FDT_BLOCK
+	bool "Block-device firmware-owned devicetree backend"
+	depends on FIRMWARE_FDT && BLK
+	default y
+	select EFI_PARTITION
+	select PARTITION_TYPE_GUID
+	help
+	  Read the firmware-owned FIT from a filesystem on a GPT partition of
+	  a block device. Other backends can provide the same FIT contract from
+	  different storage without changing its consumers.
+
+config FIRMWARE_FDT_FIT_MAX_SIZE
+	hex "Maximum firmware-owned FIT size"
+	depends on FIRMWARE_FDT
+	default 0x400000
+	help
+	  Maximum accepted size in bytes for the FIT read by a storage backend.
+
+config FIRMWARE_FDT_MAX_SIZE
+	hex "Maximum assembled firmware devicetree size"
+	depends on FIRMWARE_FDT
+	default 0x400000
+	help
+	  Maximum accepted size in bytes for the devicetree after applying the
+	  selected FIT configuration's overlays.
+
 config FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by U-Boot"
 	depends on SOCFPGA_SECURE_VAB_AUTH
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..487141b963a 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 
 obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
+obj-$(CONFIG_$(PHASE_)FIRMWARE_FDT) += firmware_fdt.o
+obj-$(CONFIG_$(PHASE_)FIRMWARE_FDT_BLOCK) += firmware_fdt_block.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
new file mode 100644
index 00000000000..9d2303b5747
--- /dev/null
+++ b/boot/firmware_fdt.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_FDT
+
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <image.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
+
+#define FW_FDT_FILENAME		"fdt.itb"
+
+struct firmware_fdt_priv {
+	struct firmware_fdt cache;
+	char *part;
+	char *config;
+	bool cache_valid;
+};
+
+static const char *fw_fdt_selector(const char *name)
+{
+	const char *value = env_get(name);
+
+	return value && *value ? value : NULL;
+}
+
+static bool fw_fdt_streq(const char *left, const char *right)
+{
+	if (!left || !right)
+		return left == right;
+
+	return !strcmp(left, right);
+}
+
+void firmware_fdt_free(struct firmware_fdt *fw)
+{
+	if (!fw->borrowed) {
+		if (fw->fdt_owned)
+			free(fw->fdt);
+		free(fw->fit);
+	}
+
+	memset(fw, '\0', sizeof(*fw));
+}
+
+static void fw_fdt_clear_cache(struct firmware_fdt_priv *priv)
+{
+	firmware_fdt_free(&priv->cache);
+	free(priv->part);
+	free(priv->config);
+	memset(priv, '\0', sizeof(*priv));
+}
+
+static int fw_fdt_get_source(struct udevice **devp)
+{
+	struct udevice *dev, *source = NULL;
+	struct uclass *uc;
+	int ret;
+
+	ret = uclass_get(UCLASS_FIRMWARE_FDT, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (source)
+			return log_msg_ret("multi", -EINVAL);
+		source = dev;
+	}
+
+	if (!source)
+		return -ENOENT;
+
+	ret = device_probe(source);
+	if (ret)
+		return ret == -ENOENT ? -ENODEV : ret;
+
+	*devp = source;
+
+	return 0;
+}
+
+static int fw_fdt_read_fit(struct udevice *dev, const char *part,
+			   const char *filename, void **fitp, ulong *sizep)
+{
+	const struct firmware_fdt_ops *ops = device_get_ops(dev);
+
+	if (!ops || !ops->read_fit)
+		return -ENOSYS;
+
+	return ops->read_fit(dev, part, filename, fitp, sizep);
+}
+
+static int fw_fdt_check_images(const void *fit)
+{
+	int images, node;
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0)
+		return log_msg_ret("img", -EINVAL);
+
+	fdt_for_each_subnode(node, fit, images) {
+		if (!fit_image_check_type(fit, node, IH_TYPE_FLATDT))
+			return log_msg_ret("type", -EINVAL);
+
+		if (fdt_getprop(fit, node, FIT_LOAD_PROP, NULL))
+			return log_msg_ret("load", -EINVAL);
+
+		if (fdt_getprop(fit, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		    fdt_getprop(fit, node, FIT_DATA_POSITION_PROP, NULL))
+			return log_msg_ret("ext", -EINVAL);
+	}
+
+	return 0;
+}
+
+static int fw_fdt_assemble(struct udevice *dev, const char *part,
+			   const char *config, struct firmware_fdt *out)
+{
+	struct bootm_headers images;
+	const char *filename, *conf = config;
+	bool fdt_owned = false;
+	ulong data, len;
+	void *fdt;
+	int ret;
+
+	memset(&images, '\0', sizeof(images));
+	images.verify = 1;
+
+	filename = dev_read_string(dev, "filename");
+	if (!filename)
+		filename = FW_FDT_FILENAME;
+
+	ret = fw_fdt_read_fit(dev, part, filename, &out->fit, &out->fit_size);
+	if (ret)
+		return ret;
+
+	ret = fit_check_format(out->fit, out->fit_size);
+	if (ret)
+		return log_msg_ret("fit", -EINVAL);
+
+	ret = fw_fdt_check_images(out->fit);
+	if (ret)
+		return ret;
+
+	/* Verify overlays too, since boot_get_fdt_fit() can skip a bad one. */
+	if (!fit_all_image_verify(out->fit))
+		return log_msg_ret("verify", -EACCES);
+
+	if (conf && strchr(conf, '#'))
+		return log_msg_ret("chain", -EINVAL);
+
+	ret = boot_get_fdt_fit(&images, map_to_sysmem(out->fit), NULL, &conf,
+			       IH_ARCH_DEFAULT, &data, &len, &fdt_owned);
+	if (ret < 0)
+		return log_msg_ret("conf", ret);
+
+	fdt = map_sysmem(data, len);
+	if (len > CONFIG_FIRMWARE_FDT_MAX_SIZE) {
+		ret = -E2BIG;
+		goto err_fdt;
+	}
+
+	ret = fdt_check_full(fdt, len);
+	if (ret) {
+		ret = -EINVAL;
+		goto err_fdt;
+	}
+
+	out->fdt = fdt;
+	out->size = len;
+	out->name = filename;
+	out->fdt_owned = fdt_owned;
+
+	return 0;
+
+err_fdt:
+	if (fdt_owned)
+		free(fdt);
+
+	return log_msg_ret("fdt", ret);
+}
+
+static int fw_fdt_load_source(struct udevice *dev, struct firmware_fdt *out)
+{
+	struct firmware_fdt_priv *priv = dev_get_uclass_priv(dev);
+	const char *part = fw_fdt_selector("fw_fdt_part");
+	const char *config = fw_fdt_selector("fw_fdt_config");
+	char *part_copy = NULL, *config_copy = NULL;
+	int ret;
+
+	if (priv->cache_valid && fw_fdt_streq(part, priv->part) &&
+	    fw_fdt_streq(config, priv->config))
+		goto cached;
+
+	if (part) {
+		part_copy = strdup(part);
+		if (!part_copy)
+			return -ENOMEM;
+	}
+	if (config) {
+		config_copy = strdup(config);
+		if (!config_copy) {
+			free(part_copy);
+			return -ENOMEM;
+		}
+	}
+
+	fw_fdt_clear_cache(priv);
+	priv->part = part_copy;
+	priv->config = config_copy;
+
+	ret = fw_fdt_assemble(dev, priv->part, priv->config, &priv->cache);
+	if (ret) {
+		fw_fdt_clear_cache(priv);
+		if (ret == -ENOENT)
+			ret = -ENODEV;
+		return ret;
+	}
+	priv->cache_valid = true;
+
+cached:
+	*out = priv->cache;
+	out->borrowed = true;
+
+	return 0;
+}
+
+int firmware_fdt_load(struct firmware_fdt *out)
+{
+	struct udevice *dev;
+	int ret;
+
+	memset(out, '\0', sizeof(*out));
+
+	ret = fw_fdt_get_source(&dev);
+	if (ret)
+		return ret;
+
+	return fw_fdt_load_source(dev, out);
+}
+
+int firmware_fdt_stage(ulong fdt_addr, ulong *fdt_sizep, char **namep)
+{
+	struct firmware_fdt fw;
+	struct udevice *dev;
+	const char *filename;
+	char *name = NULL;
+	int ret;
+
+	if (namep)
+		*namep = NULL;
+
+	/* An absent source remains -ENOENT even without a staging address. */
+	ret = fw_fdt_get_source(&dev);
+	if (ret)
+		return ret;
+
+	filename = dev_read_string(dev, "filename");
+	if (!filename)
+		filename = FW_FDT_FILENAME;
+	if (namep) {
+		name = strdup(filename);
+		if (!name)
+			return -ENOMEM;
+		*namep = name;
+	}
+
+	if (!fdt_addr || !fdt_sizep)
+		return log_msg_ret("addr", -EINVAL);
+
+	ret = fw_fdt_load_source(dev, &fw);
+	if (ret)
+		return ret;
+
+	memcpy(map_sysmem(fdt_addr, fw.size), fw.fdt, fw.size);
+	*fdt_sizep = fw.size;
+	firmware_fdt_free(&fw);
+	log_debug("Using firmware-owned devicetree\n");
+
+	return 0;
+}
+
+static int fw_fdt_pre_remove(struct udevice *dev)
+{
+	struct firmware_fdt_priv *priv = dev_get_uclass_priv(dev);
+
+	fw_fdt_clear_cache(priv);
+
+	return 0;
+}
+
+UCLASS_DRIVER(firmware_fdt) = {
+	.id		= UCLASS_FIRMWARE_FDT,
+	.name		= "firmware-fdt",
+	.pre_remove	= fw_fdt_pre_remove,
+	.per_device_auto = sizeof(struct firmware_fdt_priv),
+};
diff --git a/boot/firmware_fdt_block.c b/boot/firmware_fdt_block.c
new file mode 100644
index 00000000000..4569aaab91e
--- /dev/null
+++ b/boot/firmware_fdt_block.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_FDT
+
+#include <blk.h>
+#include <dm.h>
+#include <firmware_fdt.h>
+#include <fs.h>
+#include <log.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <dm/device-internal.h>
+#include <linux/string.h>
+
+struct firmware_fdt_block_priv {
+	struct blk_desc *desc;
+};
+
+static int fw_fdt_find_part(struct blk_desc *desc, const char *selector,
+			    const char *type_uuid, const char *name)
+{
+	struct disk_partition info;
+	bool want_type = type_uuid && *type_uuid;
+	bool want_name = name && *name;
+	int part;
+
+	if (selector) {
+		char *end;
+		ulong pin;
+
+		pin = dectoul(selector, &end);
+		if (*end || !pin || pin > MAX_SEARCH_PARTITIONS)
+			return log_msg_ret("pin", -EINVAL);
+
+		if (part_get_info(desc, pin, &info))
+			return log_msg_ret("pin", -ENODEV);
+
+		return pin;
+	}
+
+	if (!want_type && !want_name)
+		return log_msg_ret("sel", -EINVAL);
+
+	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+		bool type_match, name_match;
+
+		if (part_get_info(desc, part, &info))
+			continue;
+
+		type_match = !want_type ||
+			!strncasecmp(disk_partition_type_guid(&info), type_uuid,
+				     UUID_STR_LEN);
+		name_match = !want_name ||
+			!strcmp((const char *)info.name, name);
+
+		if (type_match && name_match)
+			return part;
+	}
+
+	return -ENODEV;
+}
+
+static int fw_fdt_block_read_fit(struct udevice *dev, const char *selector,
+				 const char *filename, void **fitp,
+				 ulong *sizep)
+{
+	struct firmware_fdt_block_priv *priv = dev_get_priv(dev);
+	const char *type_uuid, *part_name;
+	loff_t size;
+	int part, ret;
+
+	type_uuid = dev_read_string(dev, "partition-type-uuid");
+	part_name = dev_read_string(dev, "partition-name");
+	part = fw_fdt_find_part(priv->desc, selector, type_uuid, part_name);
+	if (part < 0)
+		return log_msg_ret("part", part);
+
+	ret = fs_set_blk_dev_with_part(priv->desc, part);
+	if (ret)
+		return log_msg_ret("fs", -EIO);
+
+	ret = fs_size(filename, &size);
+	if (ret)
+		return log_msg_ret("size", -EIO);
+
+	if (!size || size > CONFIG_FIRMWARE_FDT_FIT_MAX_SIZE)
+		return log_msg_ret("big", -E2BIG);
+
+	/* fs_size() consumed the mount. */
+	ret = fs_set_blk_dev_with_part(priv->desc, part);
+	if (ret)
+		return log_msg_ret("fs2", -EIO);
+
+	ret = fs_read_alloc(filename, size, 0, fitp);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	*sizep = size;
+
+	return 0;
+}
+
+static int fw_fdt_block_probe(struct udevice *dev)
+{
+	struct firmware_fdt_block_priv *priv = dev_get_priv(dev);
+	struct udevice *media, *blk;
+	ofnode store;
+	int ret;
+
+	store = ofnode_parse_phandle(dev_ofnode(dev), "firmware-fdt-store", 0);
+	if (!ofnode_valid(store))
+		return log_msg_ret("store", -EINVAL);
+
+	ret = device_get_global_by_ofnode(store, &media);
+	if (ret)
+		return log_msg_ret("media", ret == -ENOENT ? -ENODEV : ret);
+
+	ret = blk_get_from_parent(media, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret == -ENOENT ? -ENODEV : ret);
+
+	priv->desc = dev_get_uclass_plat(blk);
+
+	return 0;
+}
+
+static const struct firmware_fdt_ops fw_fdt_block_ops = {
+	.read_fit = fw_fdt_block_read_fit,
+};
+
+static const struct udevice_id fw_fdt_block_ids[] = {
+	{ .compatible = "u-boot,firmware-fdt-block" },
+	{ }
+};
+
+U_BOOT_DRIVER(firmware_fdt_block) = {
+	.name		= "firmware-fdt-block",
+	.id		= UCLASS_FIRMWARE_FDT,
+	.of_match	= fw_fdt_block_ids,
+	.ops		= &fw_fdt_block_ops,
+	.probe		= fw_fdt_block_probe,
+	.priv_auto	= sizeof(struct firmware_fdt_block_priv),
+};
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 956a3d97c42..e65114ff835 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len);
+							       arch, &load, &len,
+							       NULL);
 
 				if (fdt_noffset < 0)
 					return -ENOENT;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..fa22a2e08b2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2513,7 +2513,7 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2533,6 +2533,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	if (ownedp)
+		*ownedp = false;
 
 	if (fit_uname_configp && *fit_uname_configp) {
 		fit_uname_config_copy = strdup(*fit_uname_configp);
@@ -2691,8 +2693,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 out:
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	if (fdt_noffset >= 0 && base_buf)
+	if (fdt_noffset >= 0 && base_buf) {
 		load = map_to_sysmem(base_buf);
+		if (ownedp)
+			*ownedp = true;
+	}
 #endif
 	if (datap)
 		*datap = load;
diff --git a/doc/develop/uefi/firmware_fdt.rst b/doc/develop/uefi/firmware_fdt.rst
new file mode 100644
index 00000000000..6cf92b0c2d0
--- /dev/null
+++ b/doc/develop/uefi/firmware_fdt.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Firmware-owned devicetree
+=========================
+
+Some platforms following EBBR / Arm SystemReady DeviceTree treat the
+devicetree as part of the firmware: it lives in firmware-owned storage and is
+updated independently of the operating system, instead of being shipped in
+the OS image or on the EFI System Partition. U-Boot must read that
+devicetree, assemble it (base plus overlays) and hand it to the OS.
+
+The :c:func:`firmware_fdt_load` helper (``CONFIG_FIRMWARE_FDT``) provides a
+consumer-facing interface independently of standard boot. A firmware-FDT
+uclass separates the common FIT handling from storage drivers. The source
+compatible identifies its driver. The first implemented backend,
+``u-boot,firmware-fdt-block``, reads the FIT from a filesystem on a GPT
+partition of a block device.
+
+Additional driver backends may load the same FIT from other firmware storage,
+such as UBI on MTD. They reuse the common FIT configuration selection,
+verification and assembly, as well as the consumers below.
+
+The first consumers are the two EFI launch paths, so the firmware-owned
+devicetree is installed regardless of how the EFI application is started:
+
+  - the per-device EFI bootmeth (``bootmeth_efi``), and
+  - the EFI boot manager (``efi_bootmgr_run()``).
+
+In each case the assembled devicetree is installed into the EFI configuration
+table via :c:func:`efi_install_fdt`, exactly like any other source, so the OS
+cannot tell where it came from.
+
+This replaces vendor-specific firmware-devicetree commands while keeping
+storage discovery behind the source backend.
+
+The FIT
+-------
+
+The firmware source carries a FIT (by default ``fdt.itb``). Its images
+hold the base DTB and any overlays, and each of its configurations names one
+bootable combination through the standard ``fdt`` property::
+
+    configurations {
+        default = "conf-panel";
+        conf-panel {
+            fdt = "fdt-base", "fdt-panel";
+        };
+    };
+
+The helper selects a configuration, verifies it, loads the base devicetree
+and applies the listed overlays in order (via :c:func:`boot_get_fdt_fit`, the
+same code path ``bootm`` uses). The FIT describes and carries the devicetree
+as one artefact, updated atomically with it.
+
+Images in the FIT must be self-contained flat devicetrees: images that carry
+a ``load`` address and FITs using external data are rejected. With
+``FIT_SIGNATURE`` enabled, node and configuration names must not contain
+``@``.
+
+Configuration
+-------------
+
+The FIT source is described in the control devicetree (see
+``doc/device-tree-bindings/firmware-fdt.txt``). Each source compatible
+defines one storage backend and its locator properties. Exactly one source
+node may be enabled; multiple enabled source devices are rejected. The
+currently implemented ``u-boot,firmware-fdt-block`` backend points at the
+media device through the ``firmware-fdt-store`` phandle and identifies a GPT
+partition by type UUID and/or name, with an optional ``filename`` for the FIT
+path.
+
+A future backend may use different locator properties, for example an MTD
+device and UBI volume, while preserving the same FIT contents and the common
+selection, verification, assembly and fail-closed behavior.
+
+Two optional environment variables are runtime boot-policy overrides:
+``fw_fdt_part`` pins a partition number for A/B firmware selection and
+``fw_fdt_config`` names the FIT configuration for the current boot target.
+Without an explicit configuration, compatible best-match against the control
+devicetree is used; if there is no match, the FIT's ``default`` configuration
+is used. The ``fw_fdt_config`` value must name one configuration;
+configuration chaining with ``#`` is rejected so the selected base, overlay
+set and ordering remain one authenticated unit.
+
+The source device caches the FIT and assembled devicetree. Repeated bootflow
+candidates using the same selectors reuse the verified result. Changing
+``fw_fdt_part`` or ``fw_fdt_config`` invalidates the cache and rebuilds it.
+
+If no source is configured, the helper returns ``-ENOENT`` and the caller
+falls back to its normal devicetree source (ESP / built-in control FDT). If a
+source is configured but cannot be assembled, the error is fatal for that EFI
+launch path; this prevents a bad or unauthenticated firmware devicetree from
+being silently replaced by another devicetree source.
+
+A firmware-owned devicetree is the complete, authoritative devicetree: no
+other devicetree source is layered on top of it. In particular,
+extension-board overlays (``extension_scan()``) are intentionally not
+applied, since modifying the assembled (and, in secure mode, signed)
+devicetree would defeat the authenticated-combination model. Boards using
+extension boards should ship each supported combination as a FIT
+configuration and select it with ``fw_fdt_config``.
+
+Secure boot
+-----------
+
+Signing a FIT configuration authenticates the whole combination: the base,
+the overlay set and its ordering are the signed unit, and a tampered selector
+can only pick among combinations the firmware author pre-signed. Sign the
+FIT and inject the public key into U-Boot's control devicetree as
+usual::
+
+    mkimage -f fdt.its -k keys -K u-boot.dtb -r fdt.itb
+
+With ``CONFIG_FIT_SIGNATURE`` enabled and a required key in the control
+devicetree, verification is enforced by the standard verified-boot policy:
+an unsigned or tampered FIT is rejected and, because a configured source
+never falls back, the boot fails closed rather than booting an unverified
+devicetree.
diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..67b100691bd 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -14,3 +14,4 @@ can be run an UEFI payload.
    u-boot_on_efi.rst
    iscsi.rst
    fwu_updates.rst
+   firmware_fdt.rst
diff --git a/doc/device-tree-bindings/firmware-fdt.txt b/doc/device-tree-bindings/firmware-fdt.txt
new file mode 100644
index 00000000000..9e4c8937089
--- /dev/null
+++ b/doc/device-tree-bindings/firmware-fdt.txt
@@ -0,0 +1,160 @@
+U-Boot firmware-owned devicetree source (firmware-fdt)
+======================================================
+
+Some platforms (EBBR / Arm SystemReady DeviceTree) keep the devicetree in
+firmware-owned storage, updated independently of the operating system,
+rather than shipping it in the OS image or the EFI System Partition. The
+firmware storage carries a FIT: its images hold the base DTB and any
+overlays, and each of its configurations names one bootable combination
+through the standard 'fdt' property. U-Boot selects a configuration,
+verifies it per the usual verified-boot policy, assembles the devicetree
+(base plus overlays, in order) and installs it via the EFI configuration
+table.
+
+The source node's compatible selects the storage backend and its locator
+properties. This document defines the first backend,
+"u-boot,firmware-fdt-block", which reads the FIT from a filesystem on a GPT
+partition of a block device. Additional backends may load the same FIT from
+other firmware storage, for example a UBI volume on MTD, without changing
+FIT selection, verification, assembly or consumers. Each compatible is
+implemented as a firmware-FDT driver which supplies the FIT to that common
+code.
+
+For the block backend, a standalone node points at the media device that owns
+the partition by phandle. The node may live anywhere in the control devicetree;
+a node with status "disabled" is ignored. Exactly one firmware-FDT source may
+be enabled. Multiple enabled sources are ambiguous and rejected.
+
+
+firmware-fdt source node
+------------------------
+
+Required properties:
+
+compatible:
+   "u-boot,firmware-fdt-block" - the FIT lives in a filesystem on a
+   GPT partition of a block device. The suffix names the first implemented
+   backend. Sibling compatibles may define other source backends and their
+   storage-specific locator properties later.
+
+firmware-fdt-store:
+   phandle to the media device (UCLASS_MMC, ...) that owns the firmware
+   partition
+
+The partition is normally selected using the properties below. The
+'fw_fdt_part' environment variable is a runtime override which pins a
+partition number for A/B firmware selection. Without that override, the first
+partition matching every configured selector is used: when both
+'partition-type-uuid' and 'partition-name' are present, both must match (so
+a misprovisioned disk fails closed instead of silently selecting whichever
+same-type partition comes first).
+
+At least one of 'partition-type-uuid' or 'partition-name' must be present.
+
+Optional properties:
+
+partition-type-uuid:
+   GPT partition type UUID (string, case-insensitive) identifying the
+   firmware partition. When A/B firmware partitions share a type UUID,
+   'partition-name' disambiguates between them.
+
+partition-name:
+   GPT partition name (string) identifying the firmware partition. Used to
+   disambiguate, or as a fallback when 'partition-type-uuid' is absent.
+
+filename:
+   Path of the FIT on the partition (default: "fdt.itb").
+
+
+Environment
+-----------
+
+Two optional environment variables override the source's normal selection for
+the current boot policy:
+
+   fw_fdt_part     pin a specific partition number (A/B firmware partitions)
+   fw_fdt_config   name of the FIT configuration to use for the current boot
+                   target; when unset the best compatible match against the
+                   control devicetree is used, falling back to the FIT's
+                   default configuration
+
+``fw_fdt_config`` selects exactly one configuration; U-Boot's ``#`` syntax
+for composing several configurations is rejected so the base, overlay set and
+ordering remain one authenticated unit. Both values only choose among
+combinations the firmware author shipped; with signed configurations a
+tampered value cannot select an unsigned combination.
+
+The assembled result is cached by the source driver. Repeated consumers with
+the same two environment selectors reuse it; changing either selector causes
+the FIT to be read, verified and assembled again.
+
+
+The FIT
+-------
+
+This is a standard FIT image. Every image must be a flat devicetree
+('type = "flat_dt"') without a load address (images carrying a 'load'
+property are rejected), self-contained (no external data). For secure boot,
+sign the configurations and enable FIT_SIGNATURE with a required key in the
+control devicetree. Example source (.its):
+
+	/dts-v1/;
+	/ {
+		description = "Firmware-owned devicetree";
+		#address-cells = <1>;
+
+		images {
+			fdt-base {
+				description = "base board devicetree";
+				data = /incbin/("board.dtb");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+			fdt-panel {
+				description = "panel overlay";
+				data = /incbin/("panel.dtbo");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+		};
+
+		configurations {
+			default = "conf-panel";
+			conf-panel {
+				fdt = "fdt-base", "fdt-panel";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+			conf-base {
+				fdt = "fdt-base";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+		};
+	};
+
+Note: with FIT_SIGNATURE enabled, node and configuration names must not
+contain the '@' character.
+
+
+Example
+-------
+
+	firmware-fdt {
+		compatible = "u-boot,firmware-fdt-block";
+		firmware-fdt-store = <&mmc0>;
+		partition-type-uuid =
+			"384e979b-eb76-435a-a3a6-1a071dbad91d";
+		partition-name = "firmware";
+		filename = "fdt.itb";
+	};
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 80498853336..e5642b60449 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -243,6 +243,19 @@ fdtcontroladdr
     device tree used by U-Boot when CONFIG_OF_CONTROL is
     defined.
 
+fw_fdt_config
+    Runtime boot-policy override naming the configuration to select from a
+    firmware-owned devicetree FIT for the current boot target. If unset,
+    U-Boot uses compatible best-match against the control devicetree, falling
+    back to the FIT's default configuration. Configuration chaining with
+    ``#`` is not supported.
+
+fw_fdt_part
+    Runtime override for the partition containing the firmware-owned
+    devicetree FIT. This pins one side of an A/B firmware layout. If unset,
+    U-Boot uses the partition selectors in the
+    ``u-boot,firmware-fdt-block`` control-DT node.
+
 initrd_high
     restrict positioning of initrd images:
     If this variable is not set, initrd images will be
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304..1e63851ecd7 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -67,6 +67,7 @@ enum uclass_id {
 	UCLASS_FFA,		/* Arm Firmware Framework for Armv8-A */
 	UCLASS_FFA_EMUL,		/* sandbox FF-A device emulator */
 	UCLASS_FIRMWARE,	/* Firmware */
+	UCLASS_FIRMWARE_FDT,	/* Firmware-owned devicetree source */
 	UCLASS_FPGA,		/* FPGA device */
 	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
 	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
diff --git a/include/firmware_fdt.h b/include/firmware_fdt.h
new file mode 100644
index 00000000000..fd25b0d7c5c
--- /dev/null
+++ b/include/firmware_fdt.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __FIRMWARE_FDT_H
+#define __FIRMWARE_FDT_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct udevice;
+
+/**
+ * struct firmware_fdt_ops - operations implemented by a storage backend
+ *
+ * @read_fit: Read @filename selected by @part into an allocated buffer
+ */
+struct firmware_fdt_ops {
+	int (*read_fit)(struct udevice *dev, const char *part,
+			const char *filename, void **fitp, ulong *sizep);
+};
+
+/**
+ * struct firmware_fdt - an assembled, firmware-owned devicetree
+ *
+ * @fdt: pointer to the assembled devicetree in memory
+ * @size: size of the assembled devicetree, in bytes
+ * @name: FIT filename (for diagnostics)
+ * @fit: internal: buffer holding the FIT
+ * @fit_size: internal: size of the FIT, in bytes
+ * @fdt_owned: internal: true if @fdt is a separate allocation
+ * @borrowed: internal: true if the buffers belong to a source-device cache
+ *
+ * Release the returned view with firmware_fdt_free() after consuming it.
+ */
+struct firmware_fdt {
+	void *fdt;
+	ulong size;
+	const char *name;
+	void *fit;
+	ulong fit_size;
+	bool fdt_owned;
+	bool borrowed;
+};
+
+#if CONFIG_IS_ENABLED(FIRMWARE_FDT)
+/**
+ * firmware_fdt_load() - assemble the devicetree from firmware storage
+ *
+ * Assemble the devicetree (the base DTB with its overlays applied, as
+ * described by the FIT from the configured source) and return it in @out,
+ * ready to hand to the OS. The returned buffers are cached by the source
+ * device and remain valid until its selectors change or the device is removed.
+ *
+ * @out: returns the assembled devicetree on success
+ * Return: 0 on success; -ENOENT if no source is configured (the caller may
+ *	   fall back to its normal devicetree); another negative errno if a
+ *	   configured source fails to assemble (the caller must fail, never
+ *	   fall back)
+ */
+int firmware_fdt_load(struct firmware_fdt *out);
+
+/**
+ * firmware_fdt_free() - release an assembled-devicetree view
+ *
+ * Safe to call on a zeroed or already-freed @fw. Cached buffers remain owned
+ * by their source device.
+ *
+ * @fw: the assembled devicetree view to release
+ */
+void firmware_fdt_free(struct firmware_fdt *fw);
+
+/**
+ * firmware_fdt_stage() - stage a firmware-owned devicetree
+ *
+ * Check whether a source is configured, then assemble and copy its devicetree
+ * to @fdt_addr. Only -ENOENT permits a caller to try another source.
+ *
+ * Callers must read ``fdt_addr_r`` once and pass that value as @fdt_addr.
+ * The same value must be used for any fallback source, so an environment
+ * change cannot make the two paths disagree.
+ *
+ * @fdt_addr: destination address, normally the caller's ``fdt_addr_r`` value
+ * @fdt_sizep: returns the staged devicetree size
+ * @namep: if non-NULL and a source is found, returns an allocated copy of the
+ *	   FIT filename even if a later operation fails; the caller must free it
+ * Return: 0 if staged; -ENOENT if no source is configured; another negative
+ *	   errno if a configured source cannot be staged
+ */
+int firmware_fdt_stage(ulong fdt_addr, ulong *fdt_sizep, char **namep);
+#else
+static inline int firmware_fdt_load(struct firmware_fdt *out)
+{
+	return -ENOENT;
+}
+
+static inline void firmware_fdt_free(struct firmware_fdt *fw)
+{
+}
+
+static inline int firmware_fdt_stage(ulong fdt_addr, ulong *fdt_sizep,
+				     char **namep)
+{
+	return -ENOENT;
+}
+#endif
+
+#endif /* __FIRMWARE_FDT_H */
diff --git a/include/image.h b/include/image.h
index 6edcb1995bf..0456e7c7a4c 100644
--- a/include/image.h
+++ b/include/image.h
@@ -719,12 +719,15 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param ownedp	Returns true if the loaded image is separately allocated
+ *			and must be freed by the caller; may be NULL if the caller
+ *			does not need this information
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.55.0

