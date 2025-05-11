Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9834FC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 20:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75B180C83;
	Sun, 11 May 2025 22:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746997058;
	bh=/Ax/yWIt7J3hg262AYPPHS0aJ9MZFZcgFTYlpssnv/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m2roXIkwxKUDxKhXbPUIs7PG23p+3o+GmfX2HjZpdLx43UiZOv4QwY7QwG3JX//Ph
	 vv/3G0QpQqg4gHNPUgcOp+os8hJmpRTSsfxJGWux/U+lYUXHIJs55tbI+5rWETxzbK
	 WIBbJTgQs1rMb326zdXVCKTW8OMdVu8Nd0Kud+Ppm1MpQ3OYgJT2upCUKiXOUPabTQ
	 j1QhAVKTVv9RUQccbMauBo4pPB5L9sSo8TdshkSGIHzz/Acb4LsyH1e7kVSojBBkAZ
	 nUqfI+u42TJPyAsa42v2AKxXAsTGz7R3P4mInkjqbECXaVBywVr+NjkQNP+jgdbCkR
	 w/OdhMh4LAVbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DFF81FEE; Sun, 11 May 2025 22:57:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D328091A
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 22:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JOW2e356"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1338B1048C2EC; 
 Sun, 11 May 2025 22:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746997055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/Ax/yWIt7J3hg262AYPPHS0aJ9MZFZcgFTYlpssnv/o=;
 b=JOW2e356S0P+pS5vplrI76WcyfwfwTJSJ5lS5Q/y4TfTk2mwsBXnn+WOSKu13+l9Jp+OZq
 DAL/31MyV+6PGuS2Re2rQZXOcwJ03+YwbLO3b7C3C7pjQujyBTnG+PYJGZeZXEHF/TpJ9k
 j4ZvVDpU+PJkheMwD7mSKBgyU+z9K10WIC++QYVZWxt0Khg+A2FBYbzP/tDLrU8SkXCnRM
 A4SC6I4lj3foOhp0dIjksY5aiDfQLj+DSc72D+y4dsbVAJxhgX+dqIIpdMCGTG16uiYxXH
 vReCjpWCGQgpQSCQq7nnslzPwSs0jPOmHp/jncGq5TiLMsUVOGbETsyisewJEg==
Message-ID: <831cd958-018d-4f39-91ed-5a9c44853bc2@denx.de>
Date: Sun, 11 May 2025 22:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32mp: Correct sign extension for memory address
 in dram_bank_mmu_setup()
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
References: <20250510065256.267546-1-lukma@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250510065256.267546-1-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 5/10/25 8:52 AM, Lukasz Majewski wrote:
> On a system based on stm32mp157c, with 1GiB SDRAM (starting from
> 0xC0000000) and CONFIG_PHYS_64BIT enabled

STM32MP15xx does not have 64bit PA range , why is CONFIG_PHYS_64BIT 
enabled ?
