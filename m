Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772D3CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B267386BAC;
	Sun, 24 Sep 2023 21:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OsbpVtm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E844686B03; Sun, 24 Sep 2023 21:26:10 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857D786A43
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-76c64da0e46so197589039f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583560; x=1696188360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucQ9EQNnd5GshJw6qQ8RcJD83TZS1YHJrF3h8WwaSjo=;
 b=OsbpVtm+IBHgNQ/yuJujp8MTTRTJ1Vcn9dyRT2a6w2jJVFfYOC9YYeBzrdwx0RyWUV
 NqcAUrlJstrFSr2ek207hqrdimHKZStdiWUo/fMzsEy99YfE59giDydXMfMNNlk21hc8
 YcztgPP336Q6MhTLLyrJb3Ws/3w3D7CE8R3nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583560; x=1696188360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucQ9EQNnd5GshJw6qQ8RcJD83TZS1YHJrF3h8WwaSjo=;
 b=bWfxJWFIBU2O9cI4dICpwxuGWUrlp2CAMoPHKJGFaqObjxdEGJNyyAN6CxxZm5rD8k
 ZCFqJRbb9ArO/pVhk5GL8vXbM211OJTww2titTo1J09l5bDUulndK6AiI7CfjlxFbhM+
 0+XnzY7SgNwyN7n8PZQ5pwSplkC7oJGxO9LKNnFgKQ0WySeXs6gwHZDXlSrQQpGFFHzs
 8xwLEVxRPYjX1qHJewHsm8DadIc1smmRtsmwImSxikWD7trEBnz0ZfFBU9AVgVUMf7VF
 GacpuL4hCzP5M/jdWyip4Rix0EKBmDTZulJVOO2tke/K11INQxab2aHd/OxfuWOQihSs
 UHGw==
X-Gm-Message-State: AOJu0Yz7uVikFfJjBbm2HI7MEeMWIuXr/Klsjsm3VEyvVsycShO0P4wA
 Mfyltt/CZyq8eXxhA64Yfyes6Yc4cRADjKqO6C4=
X-Google-Smtp-Source: AGHT+IFuECGMt4MYSj95tRiJHretAsbQNkCgk/7YgBd9PEVPQNvEL9Q6Te5k8m4SQz1y5Z8tSg1tXg==
X-Received: by 2002:a5d:9144:0:b0:792:2cb6:5c65 with SMTP id
 y4-20020a5d9144000000b007922cb65c65mr5515972ioq.8.1695583560205; 
 Sun, 24 Sep 2023 12:26:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:25:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 12/38] Tidy up uses of CONFIG_SYS_MALLOC_F_LEN
Date: Sun, 24 Sep 2023 13:24:57 -0600
Message-ID: <20230924192536.1812799-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

Use CONFIG_SYS_MALLOC_F instead to of CONFIG_SYS_MALLOC_F_LEN to
determine whether pre-relocation malloc() is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to tidy up uses of CONFIG_SYS_MALLOC_F_LEN

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index efbaf434df48..23abb70136d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1287,7 +1287,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
 	fi
 
 ifeq ($(CONFIG_INIT_SP_RELATIVE)$(CONFIG_OF_SEPARATE),yy)
-ifneq ($(CONFIG_SYS_MALLOC_F_LEN),)
+ifneq ($(CONFIG_SYS_MALLOC_F),)
 subtract_sys_malloc_f_len = space=$$(($${space} - $(CONFIG_SYS_MALLOC_F_LEN)))
 else
 subtract_sys_malloc_f_len = true
-- 
2.42.0.515.g380fc7ccd1-goog

