Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2587CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EA8831D8;
	Tue, 12 Aug 2025 00:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRuY1tzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858DF83287; Tue, 12 Aug 2025 00:21:09 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E19831C2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3e5477e8effso8541775ab.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950865; x=1755555665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IO4KiSTUlywov2oxQxGb1zu0bJFBCXdO+MuTjha7WU=;
 b=ZRuY1tzhxoKYgJW0XTBhpFjfDBIO298kyDh4DTFYdYRe4bpCZodECZ2FelIyporPKL
 k7SoaFGBt/RGlwLF49XpLo9PbczIMx/tCPIFaBcxyDJOdvZFZRW6N9LlEr80F1T4fCMN
 Rp8bOHD2aBZlb3PKlS5yMfeGyu3yzfkOQWvKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950865; x=1755555665;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IO4KiSTUlywov2oxQxGb1zu0bJFBCXdO+MuTjha7WU=;
 b=dmXZHu/ye4bGfy42z6ZvCDEjwq4xux1RqBikghFDyygJxynabyZX2fGg1COrLnYe70
 YPccD0PvfgB74QJAM/Jsx2TBNNSlP/wwuOqrmFrdsOX+fRFE34LzmwlQDx8MI/PBAx2J
 08tbaF8yqjovItQj3riKUKU+qPS+q9K+SsPhk42mM30SbZxE8GANUVOpI9OuGPOOrTHh
 9GhTRQayn7mJduQkyuD/6hNASlYk6V25YIkoehi1HjDA8Z2o0HMQWBBlO9jZe72qZPva
 5vS8x9HoKYER697sJbG2PCu9pvEZShJ5l6ZOslhIyw+xYd4DlYop8sl218nwsZjq1NZR
 WGrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmi5WsAunKcTSBaWFsgt15yhyXVFWtdSRz1lBLDYiHkSU9/v/J1WBY75rR86/0E/BaMAoJRXM=@lists.denx.de
X-Gm-Message-State: AOJu0YwTeL6DBjX5igPfzVQMZl8gnqPVRS5+BU1D2f4a3bbAO3BwMHMT
 Cl2uENC4X6cPrvr4wBl3FCPL4gRCTxkfRCV5Jdk+RWMBpX+AF50qXm9PrsyJFhyb0oB3/nS8eH6
 +prd7o0I=
X-Gm-Gg: ASbGncuBK9nQuTQ/QEk/Rf8n/Qk4Z5856OR7O1C5WN7+SRifkN3GCddvJNHqIvfX9sH
 boSO5qB1mMG80crBJ5IHx+yNoyOKaxKFJjjc4sI2gI4bSz+nbBcTxI6Zo+ZquGDyHo+iTBTYZPM
 jzlPJJv5XnKRJjYfegKAHyeMP7U8Uz3Y6/54HK3IX6HLm8Zw0GhG+BwS9asPiSdh82dpkLaLDZw
 P0XjbVcbmXrE9UAZg+WVoGlFRD8M3s+hkyl4EMhBqy0iiEzYlOUTFoZkfZJSpRfU4lzVkhlwaxN
 YAPC82uDPc/mr+dvaqTkyrtaHtZs9AdfHC3PKVtFkwUlaPeDwB3EMSs0hhNwZ6btrSnn/xtWtkD
 rOOdBIf4K1OAjXL6dA2DKjU0z4sgVTHBfvwb9Nr9iCBohrGaOrXXXl/cjGmAcoOi0mQ==
X-Google-Smtp-Source: AGHT+IGA0IIina9w0836L9+VyroPjW9WmdrIfZxeh7F4SVoDRhucuFHAF3NfFDGnscT6LML6MWZ6oQ==
X-Received: by 2002:a92:ca09:0:b0:3e5:41a2:d71f with SMTP id
 e9e14a558f8ab-3e55afa3b4emr21061775ab.14.1754950865496; 
 Mon, 11 Aug 2025 15:21:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:21:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: chalianis1@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20250730-topic-sx150x-copyright-v1-1-c2e2074b8942@linaro.org>
References: <20250730-topic-sx150x-copyright-v1-1-c2e2074b8942@linaro.org>
Subject: Re: [PATCH] pinctrl: sx150x: reformat and fixup Copyright header
Message-Id: <175495086436.1657597.12433601073889188790.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:21:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 30 Jul 2025 10:03:39 +0200, Neil Armstrong wrote:

> The Linux pinctrl-sx150 was originally written as a GPIO driver
> and fully rewritten by me as a Pinctrl driver and extended by
> other contributors.
> 
> Fixup the Copyright header style and correctly report the
> Copyright headers from the Linux driver.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] pinctrl: sx150x: reformat and fixup Copyright header
      commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
-- 
Tom


