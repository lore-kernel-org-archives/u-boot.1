Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD82C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6988288D;
	Fri, 16 May 2025 01:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KqOPFzow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECE78288D; Fri, 16 May 2025 01:42:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A400480107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7304efb4b3bso1030011a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352519; x=1747957319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v0rp88s/wh6i/1Nmte1lZOu/DX5cX7M62dnlWORxqQw=;
 b=KqOPFzowvORjydaC6o05qHrb9RBMCEtZrcaAvA3GT0sYb7bt09yH1bCmPY58LR4Uu5
 LBbi2pSWaky09GKP+WBD0MgsK57geP6lX8n61XB6D/rY0OM9PbdHx8qrCkfRkbfGuyp0
 3eh2nHAXtFw8/uBLmGh0TCG4WGKRZLZ1aHrvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352519; x=1747957319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0rp88s/wh6i/1Nmte1lZOu/DX5cX7M62dnlWORxqQw=;
 b=jDgpLdTwyRx8lV0VKL9pDoDxJimJeCLnzqjbsE8INNzylY0xU/gNNGvugorkMWD51R
 MNX4IOiuiW3t2DLCRZO3NWuofFVTwbj5/WaUQMZW2vFgRtgtlBTUka2/D0LK6VE7d4B3
 Ho34M+ioOH6Jgf04Li1Ujlgj9ocNVhB3ktoCQyelmYXKuWp6yHpQ0nxOyOBu49CELkwE
 wiDk8cDcxumCzHqA+DqgrKkzAD5a7cI0Zc6uxgvqtT/ONmibYl+zxTAE595XG7WrIH9U
 Tkm6h3GU2LiKSlSh3bl8hy5vx1hMdghANCrVoFvbPSIn0CbwCtz0ghfP1vcPstlA1J8J
 XSnA==
X-Gm-Message-State: AOJu0Yy4YDBjY6sX8xyWmNhWnOOjKBkWR6QE4uhMEYSYdZ2dG7b/c9Bs
 TNY2aRSMWEWspG/BCe33jHLSn5zdXwymINMJoggryPiSNNgO1SMVdb/C5o5w/t/AnVwtjJe7ChO
 JI4gHxeA=
X-Gm-Gg: ASbGnctBBMyqZDAml3qRXKaM+VfKVcHe5H7K/Jc4q7Wa1y4Zy/1A2V9DvXdteDdQNon
 f4C8cRQb5+Ebtn9jiJpwP/4vGpERldDktEVQYcu+Hkr9Wz0/4ZtfqG0uJSIzSJqRF4md9Mg+MWd
 EundO7pEoSxnSuHhacDm6ikv5A5brxNR5btFOUVG5cZ6DcEQXF6HQftk2pCQiT5ZmXcww371u/e
 UjGzWcZ6c4r+sQzQCduVObctQTr5Rg/LCNSv3i15u1ikJpOMXQsKKqmV52pScBgJr8PsvCDoaFR
 o1g9O3SYeRDYbiHa+rHv868+95dpu4268UFYYfbzjcIVo8hA+uhDjecnpE4fVrd+5Mq6K9QR1e/
 C7jkU8B4/fYo6qlU=
X-Google-Smtp-Source: AGHT+IGYdej1hEH1TkN8k4oXigx03AyMBMlPRO8XqQTbo3fO8fctKngPEWMNhXsHQaskLxxpR0ic+g==
X-Received: by 2002:a05:6830:6201:b0:731:cac7:3636 with SMTP id
 46e09a7af769-734f6aae1e4mr957110a34.6.1747352519384; 
 Thu, 15 May 2025 16:41:59 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.41.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:41:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v3 00/22] Remove <env.h> from <net.h>
Date: Thu, 15 May 2025 17:31:29 -0600
Message-ID: <20250515234154.1859366-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

Hey all,

This is a v3 of Simon's series[1] and depends on the series[2] I posted
the other day that removes <env.h> from <command.h>. With this series
done, I believe we've tackled all of the current cases of headers which
include <env.h> without directly needing it. Much of this series is in
fact Simon's v2 with the main differneces being:
- Removing <env.h> from <net.h> at the end
- Removing env_to_ip() given how little it's used rather than shuffling
  around where it's declared and un-inline'ing it. For a rarely used
  helper, this ends up being cleaner I think. Especially looking at some
  of the users (which called env_get repeatedly). If there's strong
  opinion here about using the other method[3] we can do that instead.
- Setting aside for now how to handle CMD_ELF=y and NO_NET=y because
  today it's actually fine as we unconditionally build lib/net_utils.c
  where string_to_ip() is defined. I'm unsure if a further series is
  warranted here or not. We rely on link-time optimization to keep code
  readable too.

[1]: https://lore.kernel.org/all/20250501010456.3930701-1-sjg@chromium.org
[2]: https://lore.kernel.org/all/20250514225002.15361-1-trini@konsulko.com
[3]: https://lore.kernel.org/all/20250501010456.3930701-23-sjg@chromium.org

-- 
Tom

