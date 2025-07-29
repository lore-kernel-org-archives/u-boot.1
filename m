Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAECC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 00:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DFF982CFA;
	Tue, 29 Jul 2025 02:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oe2dzPlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1342882EB8; Tue, 29 Jul 2025 02:20:43 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22228277D
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 02:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ffa1b10918so2829285fac.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753748439; x=1754353239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+T25S8Zwg3JOHFA26ZDJ5Wf2VBc/1tCAUc81dD89lxc=;
 b=Oe2dzPlUoy4OMwXX43E7HvsYqR2E5Ey/rfOSCAGSCiHPQczc3yjIaU7H9yKlF7aqwy
 JqC1MXblWZ66ivwhLUoe2D6lkPOGqr0QW4JXapCZNuKiv90tWYqbmjrvX2g09n5JqVla
 m8JVqu2PXakZIoxNLVDjJBirLINcULoB6g91s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753748439; x=1754353239;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+T25S8Zwg3JOHFA26ZDJ5Wf2VBc/1tCAUc81dD89lxc=;
 b=HBC+XjFEmdnwMU0zkXvpyIRfiqIASMBwFoBGeWbo3O6SzxSLmOlMce8l1iJ8Nu6dpq
 3sql4qQU+4EztrQLWmhZiuQ2R35Zzdu/ePRGFEKF8IAvADcHbaM/6fNWrfzqinpc+hYS
 NSfLbym7hX7fQnc1kTiNfBcJglYY2IqFyMNZBQ2z656361Eq+md5gq0WDc9Ar0GNR2kf
 lKDximGdw350o9wZaPi1jT07fIF6rIe2lTmgzCVPyQ50oKncPA2Q8A/pGrbSsBXcwx0B
 Ah7qHMdKYbeUmyJ8e0rYzmS+UuL4qrbxGjGF8kqkMRMqOfgVuwg0S1VxBRu6wj8K9CIR
 WwBg==
X-Gm-Message-State: AOJu0Ywz3qxatTKhMuzEbIMufk/LUqWzGf70ouhZeINSBH6/SeL06fep
 FKDqhH4R7gDAGR0LExv2ZSMGDBa6CgLkVHKrm2gED0BPWKkB3+sgLlzocG7qNHCkhnw=
X-Gm-Gg: ASbGnct5Th3FYrlDgwrglv2U+H1S1etH7CyiCuPHdp3XFL7UAxulKixow5FLJl4aO8i
 CjG1JjJ18glYh7II8D6x1UHXiKjdxMI5ZNGu0sf9KvSdFOlvpWKOe9Bysc6qhr72ApVGLtg7tOV
 xt8LabILhZH3R7BU4hIZ1UZ8FuOVxj3wAP48XKwxPmyp009P6vyqrQKJH6gDFU1EX30DSrSkw0G
 /v/zHT9XaTE+QX/6fzuu+ZEGgEwN0FGmIOsuFjbsG3if8UImPxyn9jML1i3WJVONX2x5EWe16i3
 FD24yNm0JXvoNcbHcdzyQSlDlUY9GSq3ATEfUAY5f39nh2XfpTba1W176RF5kJUMt7rXj7I9fbz
 xtEmTDOiqURzxckiNoTee1bdhbmnGFcKYp4fHCWNhGtBNxYj0CH5q1Yk=
X-Google-Smtp-Source: AGHT+IF3gELZ+znw0R865d37Jeauj53xzRfmHUETGPMu8jyX9iYCdIN7EZrszPC9WBrdzi+yUzA+cw==
X-Received: by 2002:a05:6870:f214:b0:29e:3c8d:61a0 with SMTP id
 586e51a60fabf-30701cc39e2mr7827800fac.8.1753748439517; 
 Mon, 28 Jul 2025 17:20:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30713239f12sm1907491fac.11.2025.07.28.17.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 17:20:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250721-elfboot-v1-1-00b431844e3b@linaro.org>
References: <20250721-elfboot-v1-1-00b431844e3b@linaro.org>
Subject: Re: [PATCH] cmd: elf: Prevent possible buffer overflow
Message-Id: <175374843849.1767077.9170284249498354175.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 18:20:38 -0600
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

On Mon, 21 Jul 2025 15:43:36 +0100, Andrew Goodbody wrote:

> In do_bootvx the environment variable 'bootdev' is fetched and copied
> into a buffer without confirming that it will not overflow that buffer.
> Use strlcpy to ensure that the buffer will not be overflowed.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: elf: Prevent possible buffer overflow
      commit: b83f865e75aecf7edbc75c3794b3e29ef5bff5a2
-- 
Tom


