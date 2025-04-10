Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E13C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BED83D17;
	Thu, 10 Apr 2025 22:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iUPOBMio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC4683AE9; Thu, 10 Apr 2025 22:14:22 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86E883B8C
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72a4793d4e2so718549a34.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316059; x=1744920859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obwsu2ZVaxIegTARKaGgfRP/cU0UC2QNf5dBqQLrJ20=;
 b=iUPOBMioYbwgKR7NbcJYRFBWLBIi4w96fhqhmqkgVW/h4Xbbpfyirdc2J+d+3tWlco
 uOty/anKKwZRJauOCBPPjSiQZz0MJ11oz920RX03kP8dH7J+YPffDkrWkNgkBgvSwaEz
 l5AGZ6oaj3R/1EAe5H3lEtJAq81JhJ3rrvPgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316059; x=1744920859;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obwsu2ZVaxIegTARKaGgfRP/cU0UC2QNf5dBqQLrJ20=;
 b=O5fBfxYLyPbUICCTnNRGg/XY/WaZr0Pl7RIbVpLJOWuLoL1oS/pKmqAWGTGvvkgHQr
 alIAku9WhDsLFO2nD8gOoVCRBlSAPDXZK5uO3+Hp4IG83uYoj27i897gOji1JEglzatn
 NRjFBtTsBGsdZBLI6Nr3fWGl55X6V8Exdb38fCYI4Qq6yE7Z0mxiV7gX6m4ZTc1mUSVY
 5fpCWz5CjJICnsQbh9K6fYeW8DvuFJgsrNVIA/JWmlNl8XMionEkq3w6DbwrsjlCkE0e
 utUpKzfSkBjgU68oCd0NtDJEzNvG0BH7mDTrreS72+OIYTdWaW2ET1NcTWRyHJCaBPXE
 pL2Q==
X-Gm-Message-State: AOJu0YyQqpZDv4gsDKxNHsVThISakhgV91BYI0FFoDcX2ZvnVvfMYNi/
 xBaKw2sMv+WX/pCU9zIyRN7EcSgi/okzyDXGCiQNppI+R2NkSHMCHQobe18AFHV/Ui8fsKA2LG+
 zNIM=
X-Gm-Gg: ASbGncvRrcAEXF1plbHMtdKFmTTKVVj8F4t0b4w0JpgKORO9guJKUuT8oP+gjdQkuLl
 hDCEcuId++/+WuRfvjnGthDCgUWOId6ErXApjiD4OtUceWbSQn2rKkSccIrBpk6au6pp8I9ZnRj
 8YXgizfdv11l7rvDe05wQyO0Xl7+Orn6JQzEl+hHv1tFRkrYga+/4aud0E2XwxoS0LA22hQA8Xp
 erYiKO5FFY7ur4SNZRhIVdFTJQZjHDYLHl/hnZUqS+reAU9h4zw2u+96Ch1jPU357TX5fY2/zer
 tudZxqfKKTp50RwdhD/5knbxArrXrj+rFoM5OGYjgOh/slDYmQC7kldlcMwQCfr+it1Xl/lWb73
 K
X-Google-Smtp-Source: AGHT+IEymlW9681OFCfRIpUBeH0lSHfn8m1guUxf+ypotkTpx2OIQ9m24zFfKfQBXZDEPtjkyc35Ag==
X-Received: by 2002:a05:6830:6812:b0:72b:92aa:b69f with SMTP id
 46e09a7af769-72e86334ba3mr188493a34.16.1744316059597; 
 Thu, 10 Apr 2025 13:14:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250328163037.24594-1-andrew.goodbody@linaro.org>
References: <20250328163037.24594-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] test/py: memtest: Fix test for non-trivial parameters
Message-Id: <174431605873.2981499.17792649603359869563.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:18 -0600
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

On Fri, 28 Mar 2025 16:30:37 +0000, Andrew Goodbody wrote:

> When using non-trivial values for parameters for this test it
> will cause a spurious failure as the test passes a decimal value
> to the mtest command which will interpret it as hexadecimal and
> result in failure as below.
> 
> test/py/tests/test_memtest.py:66: in test_memtest_ddr
>     assert expected_response in response
> E   AssertionError: assert 'Tested 16 iteration(s) with 0 errors.' in 'Refusing to do empty test\r\nmtest - simple RAM read/write test\r\n\r\nUsage:\r\nmtest [start [end [pattern [iterations]]]]'
> ----------------------------- Captured stdout call -----------------------------
> U-Boot> mtest 134217728 0x8001000 90 0x10
> Refusing to do empty test
> mtest - simple RAM read/write test
> Usage:
> mtest [start [end [pattern [iterations]]]]
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test/py: memtest: Fix test for non-trivial parameters
      commit: 3c6a3e99b398558b6bfb1362a44fbf0e07e2539e
-- 
Tom


