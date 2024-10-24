Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F21CE8E63
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2C488FC0;
	Thu, 24 Oct 2024 13:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wT7Ianl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B1088F2C; Thu, 24 Oct 2024 13:25:54 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCC988C7B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso751341e87.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769148; x=1730373948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y988mXFVlw/ZvqvO8EpMiKq+MdDOfWgrkrGomVG+qSc=;
 b=wT7Ianl+GjTdhyG2sGIrpS9KK9lD+yizwysdY2lWVEcBpQLkzrSjWy53dDNZ5qBW9q
 7hsIqry7V9kmpSgc/t2yk5uQeUAELRTihy1ENRU4T6RSLwlom4NjBhWn+4wWAMLebUev
 9xxF99DGK705+athSgjBoP2+SGOVhxau+n7XsUiezgmQ39dktXSJDtJVDwtm22NeePcu
 40wjNRCofIR6sKU5iK+G8CAFKcMAFhU6tnxxI3ccwwyvRRnhtChqkm+spivL7tuwSzmy
 pDUt5OWZvItYNCiBIK8hT4zcnRmeyjknzPDo+grxJSlI4rcECPsIx60MwoM3xvirGbMf
 qR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769148; x=1730373948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y988mXFVlw/ZvqvO8EpMiKq+MdDOfWgrkrGomVG+qSc=;
 b=CjjmK2RW1UcykwpqSIWJgJBsRT4w8WQM/SQEXd4vtN0jqoBsRTYrMz6QFPz1Tg2Ygl
 nxZvXttGFb4kDZk0IUr31hiY85bDQO6hjcOq2hOE53aiZudbePEVN7W1Fs4oyrwKQB9v
 fOXuZXGrJWBkqaq8QjrseNNLcZhQPa+dX0nGa2GCV/H3mJFADz/fOh+aGCQ562yjZxmC
 4P4JRIvsb/8yQwYk8WxKhQx9MV9GXaKFa241toKO6w+CF5gwGp08WnebqqsjRAnAC1+e
 aYR8MUDhyjcEzL4fWjz0DRxMEgsXjqr6/EZkjo4ZxQu+Jv55yN1Jt4sgZNj3ckXbwC4k
 19xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmNREcLzEOa5vZ3zYaAT9pF/hHrqcpMMEzeMPvlc7fmIaJMhCIEc4y8Ity2tWR6wcN9jdbyc=@lists.denx.de
X-Gm-Message-State: AOJu0YyjY42zpeTTR6b7iuqBful2N3p3Cycbwy+cFG9jwdIzOqG3b6oA
 KhQyDNSbM+my1Q/Y0HSYZMErrfGs5ciKLemx0kM3M9bGs0BTQk9+cK9k1wki5NM=
X-Google-Smtp-Source: AGHT+IFu/rotmUevBL1l4HyfEIksQrZxAlB+BjWk/TQJkFMKTIZLAxwgZMY6atM0cZQaUTMx1vNVGw==
X-Received: by 2002:a05:6512:31c3:b0:539:9f52:9e4 with SMTP id
 2adb3069b0e04-53b1a375da2mr3506942e87.48.1729769146791; 
 Thu, 24 Oct 2024 04:25:46 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:25:45 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 5/6] configs: Enable https for wget on qemu arm64
Date: Thu, 24 Oct 2024 14:24:12 +0300
Message-ID: <20241024112449.1362319-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
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

QEMU already has an lwip variant of a defconfig. That defconfig
is also configured with mbedTLS by default. So let's enable the
remaining config options to enable wget for https:// as well
and test that codepath in the CI

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index d3d8ef16e668..754c770c33fc 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
+CONFIG_WGET_HTTPS=y
-- 
2.45.2

