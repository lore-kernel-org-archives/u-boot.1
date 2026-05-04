Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A07CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D257846D2;
	Mon,  4 May 2026 22:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bK/HnInk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45408846A1; Mon,  4 May 2026 22:31:54 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4657847B0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8173b2af32so1028198a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926710; cv=none;
 d=google.com; s=arc-20240605;
 b=NpAv2GKFh9Lg0R3G6zyaWfFiLLBoNkK7vfa13I19X24TLXJAmvM/hAzqaBNjqYsURm
 UT2Xzv93AkpV2mV4SiV3kc6lptjoZfO2z1LPPBBx3xRsqo8KQU++CtwXGyEoWLVKcDbk
 +Y3w5rAxPKCBhwdAdRDg2cWLZ8U1BhcXlsoKVQMb19gVV8wB+xk7j1xD0/wGkbwl99Un
 jvUReimcUY1/y2EatZ8s5knThA4LaD0ObuaVlU+0B6cCwqD9dl/9P4rsoa3Fz2fIloaw
 QK3FltsNeOxaZxyzV+cirBXh7tUxxCpOWjP21OzgiyQKU//oM9ONHAJjdodW8s+QN34h
 tAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ucUoHpsOzwdSxLqAo/CgBgIGbtJySBeRFOQhp1Z9Vi4=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=kl4LlQEylUrSM5tVevhOJIZZu4IrX/8uf6tgNq/Ld6J4EM5B7cS9XpV57qICtVtLkP
 Ev3PCzTR5HRkuBIW0Fw+cj5lTJdAmt3AR5BUHhqTnCowyV2B8kr8IyzTs25Xf9mM/96b
 v0EYS8rNv7lERY7QnmavzA9NHKocKRixgsLOG9K0mwdLDz+tz9Z7RPitcf9G2OeRCcS4
 Y2FAJyzZ48ueTC33JpmKQ+YF/nHvAcjD2V0WFkjhPKoCs9P23Zvz7dKO1EKl8TsyqJeh
 xrMscR27JkhKSQ3aQZ07a1IKBxTMDXpw9h5LVHSJEf+5b8k/Sr8JeGIdVkH3HzDbxUk4
 4qEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926710; x=1778531510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ucUoHpsOzwdSxLqAo/CgBgIGbtJySBeRFOQhp1Z9Vi4=;
 b=bK/HnInkCuYxiNr4/tHnXRRms6rTkYWBxPizTQO5ontZ+jISAxSR4Ry+bEHOjNwJA0
 Dl7rglbr7E7o2Iv6HHfZ40bN6AMmTi6U+Xe6fXkYUHabxQMn3rlvKSTWj3AROE0dTthe
 m9fhuOee5oNXNuW3ilBS+CR7koWJLNvt+RLMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926710; x=1778531510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucUoHpsOzwdSxLqAo/CgBgIGbtJySBeRFOQhp1Z9Vi4=;
 b=bKabnhrDmo6wLX/FqykmVPEGPpG5j3Ac1QvKp9ziQeha7F2tpTAPkz/Ii6seJ1c5H6
 JRs90zSwfTJhUOL9ZSwlN8MnNPFn/olYC7Vkv/QpCoUZtSO5/YWxMLsRw/AULDctlect
 zl5eS2sqUHJdd9WWArPFEUCp+GW7thG+bDwxUnUzeAEfrFltZCF7Bm+k6tdW19Y0/I15
 FpOfk3ySvEWFLP+HhTIqpco2CLu+CBzhc4BZaS5EUlIZEOPJ0VO6q/QvvTuBaInTrhj7
 2iyI8zVlpO3HD0YdW38VZL8ZmyFbPXjL/eXVvfaGM5vstUW57AVmyX4+rZasrifxxvzE
 l7rQ==
X-Gm-Message-State: AOJu0YwdSc/Hhsm7xM1KMTbAsUPHQDOvXf0u1j+SD0f/y+x+w/bnseHp
 /FGn0qREPgyv+kYnGUFsOav2fSo349KJjWhJvjsic4Rqxu93FLiHT73XYaAR6C281ErBsm93+sg
 xRbltcIMJjqxWCkdxcPl/18zkzm3GIGfXEP8LuL3p
X-Gm-Gg: AeBDiesjxRhHAxChapbaiu0ynLWch0Ey/wxPemzVZ5dn4GuLDihDowhrB7BZZpMKk6z
 a5PS2O0Ri69fEHzmYXmmmjoOfzW8WzLjKz+BtpjppuAHSKjC7dzQfzpQ9+2q8i6C/gxB3SABBiF
 ku33UFe14+c4EPLrwxSEJrG5LQ6n+7S3ZGL0Dt2bpab09EruDNIaKQ7UnhRN/jzKhFsL+sbMBCG
 fEXOXMqsIhQqPsPzcmum0HTLFIks5Xsdy4QBsNE1ulEbCblciQozR5IghDnqmBMf4xHbG/4KmEP
 ytjONCku/L7PhYvK
X-Received: by 2002:a05:6a20:7f88:b0:39b:d937:8010 with SMTP id
 adf61e73a8af0-3a7f1c85ecdmr11581810637.45.1777926710480; Mon, 04 May 2026
 13:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-12-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-12-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:43 -0600
X-Gm-Features: AVHnY4JX8EE3H9sQnt7fpbV0acf8_WxvfUkiKzXXpo78tPQACtwY6T9qyKvLA90
Message-ID: <CAFLszTiHHc8sRJavxdNZOmSg2xPS=u1A=-0DYNs8k7GXZauMYw@mail.gmail.com>
Subject: Re: [PATCH RFC next 12/18] scripts/Makefile.extrawarn.u-boot: remove
 redundant Werror handling
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> scripts/Makefile.extrawarn.u-boot: remove redundant Werror handling
>
> In the previous commit, scripts/Makefile.extrawarn from the Linux kernel
> gained support for adding -Werror to KBUILD_CPPFLAGS when CONFIG_WERROR
> is enabled, therefore this is now redundant and can be removed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn.u-boot | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
