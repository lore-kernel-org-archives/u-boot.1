Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CC0CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216F783DAE;
	Fri,  7 Nov 2025 15:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LYD7V3io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF1683DE9; Fri,  7 Nov 2025 15:53:03 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6202283DDD
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B5C9601BD;
 Fri,  7 Nov 2025 14:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64441C4CEF7;
 Fri,  7 Nov 2025 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762527179;
 bh=yqCu2ug8f4ZDolTtGV4wYTOLlJdSeZR1t78/xzlZM5U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LYD7V3iojurotc+62zxUETwHGyDA2kVRkEdzfTf9N6eWePmhRXz3DGQ23sZRzew4V
 5PJLqHipqVMidYXEaAc6GXuQGQVHwafnnVvTUU0SzFAS+sXfuh6d6hj3B/HhsPTYzj
 HqdsMrBXlQe6V45Fr9X8UVZWQ6NkdOzwRvjEeoULA/vHtMC6t+xHJEXbh+PpqGEbDi
 UmdAD14sRodBPD/1SmF/U5Cfz6pcIBweOCSUVYePlKQ4T+ygKrgbhrtzMVSmapXyLW
 v1UJKuglHQI3gjRNV+I6osKqXUmrRI8saFaBrnr2grynVCBuxNLg8WLLWph52ZGGUW
 3NZ2JugjHCahA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 5/5] test: abootimg: Add test for bootconfig handling
In-Reply-To: <cde34459-c4dc-4abc-9ad5-1e709b9753f1@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
 <877bwb5960.fsf@kernel.org>
 <cde34459-c4dc-4abc-9ad5-1e709b9753f1@baylibre.com>
Date: Fri, 07 Nov 2025 15:52:57 +0100
Message-ID: <87cy5tao8m.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Nov 05, 2025 at 19:14, Guillaume La Roque <glaroque@baylibre.com> wrote:

[...]

>>> +
>>> +    # Verify BOOTCONFIG magic is present
>>> +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
>> Can we explain why it's either BOOTCONFIG or BOOTCON? why would the
>> magic be truncated ?
> no reason error from me

Ok, please fix in v3!

>>> -- 
>>> 2.34.1
