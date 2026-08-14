Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C7C5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7665F40D91;
	Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZN0zGPVrjt7N; Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA72B40D4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715473;
	bh=YobVC0VAqOvgCrhjg/ZrIWgJBoWK5tnK6PDCl7oHVrY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g629tcEopFI7X5Kvkeuv36bpfdKILDnRRNVyBORqOLI1OTOkCWJvkDVKxYdLMa9Ot
	 9W9hDaaVES1bezpECEshvXbUGJw6ee4/QtyliHf+dGz1Gk4/7Q4beQZgSHAYrI/nee
	 gKCtMI+2MEPiFMIGbwHLXnW1HKmRhwDSWdt5KIAwyP+LftlZKw3KnAJ2hDJPmSaix+
	 KnTtstzt4p0n4ZQ13inpyD1m23Ds4muAvbzoOkykLZSbdlNHd/w/uSUdDNu+2hrWDP
	 85bbU3Z5uPifxwuYKzYLNwLwMXGoW+sRecxd4aqgrtnK8a+YYpmhsrRaeL7liiq8RZ
	 SRr3RN9sFNglg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA72B40D4D;
	Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA2C361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A8DC40411
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgTmg8HrPHKy for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 40E7A4040D
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40E7A4040D
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mySYGxKR
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40E7A4040D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:09 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7eb64085c45so752899a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715468; x=1787320268;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YobVC0VAqOvgCrhjg/ZrIWgJBoWK5tnK6PDCl7oHVrY=;
 b=mySYGxKRudZAngejZlDL1Fp64hxq/CPH47HxqS5Cj8q1ksxE80+GY/wOBHvz4pDqsA
 +qznQqbtwjoQI8vNST9RkkFV3Q0wJj+cvBiHQJtT3jhQPVewi5XvmkPdz1pl2Du+rscb
 u2fdeQ51v5CTNw7c9ZThKjI72xOerEaB36T9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715468; x=1787320268;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YobVC0VAqOvgCrhjg/ZrIWgJBoWK5tnK6PDCl7oHVrY=;
 b=fcDRU8UxrycZZy2oIbezCR05j/Q1OqAnAly2J02AjSpeukczL28A2eUZme5OkdRUs8
 cYrK+K4vN4Y3rib4oX4b+ovG8lRVNlqJO2I5MGKr4nCpVm5KIjbyrAFlIJ3Hds3bs+HO
 ozXY1A0ABJyHgCJpnSA8Ov/0X4b00Juwx85DTcFEaVpMRFjR3COBqA9f+eUht9qCBPbK
 b3EEirmb1Uk2OgGZZ7TC+Dc8JQc1rByAyK82BzE4BwI42wjwHRItcQO1Wxf5yS4c+LO8
 JEVHiYoUfHKgCUf/t5c/5KRZ3JLk0DMTjHR0fzAzRXSyM+H1tdetoj8F8zy1ALE2CHMZ
 ucfA==
X-Gm-Message-State: AOJu0YzUtkTvK/rcBSWl8sDqJym4yqCJwayEh1CJcWDSiKS7cxrk2jWq
 fb3yvB5vvUUqQuACynEaYzpW1IiRB2DWwhWsRAEOtUcoOZlyx2Ah5v0MoriVvrlfubaSAt2MnJi
 0rIzo+N4=
X-Gm-Gg: AR+sD13cb33CZLJlHY7cYdu2hMHBKy5qW3QOC6LgS24ajHDOxW9qoJrBv5DH/pWPglo
 sytTJb+fn75oMjBkzSpZS6/qUj7Q8lG2uUUwA0QP3W99Rpw+lyvbP0vn/N+LzzcV4P3PTF4/wkv
 9MRzEr/usuQck/y4IxFFhjOra3LObLIGpnPw6MN3+5jX3t8i2JTge7YJ+/PiXae2kq3QyWQjwUx
 gwzoHBeVimmJ9JWOaC6ljLDj/x/2VOWVoivBzyy0YHKFbkRz8kjZS/59K7w3KYSHN4ivFE8pgdX
 YU+Y9gDxHlhrbHKXIamgMO5pt/LF9ptJ1dW7BkNpnzuofKLYrsh1egeWeWFhGXpL3U39u4I6CQg
 qxFIqEQCjePrKCbii6gXQBuJvzwow+/sh0uSnsYex6uq1/S5cH28xkxyPWhaNVmNK9wlq1OswCv
 3RhYQoLwpglZ2OclCW9+03CpGCdsP/+ZKieqcG+SfT6YdKyhglIvRYGlcUH9KelqvYFwrTAIh7N
 U5Z/d5qn3PrOo8GcNoTWnPZXS2yTDY0D5kUKrM0C/R5o+evue7a8chGkAEihdezxsPXC06L3///
 H2JzVYbi
X-Received: by 2002:a05:6830:6018:b0:7e6:f31c:47bd with SMTP id
 46e09a7af769-7f3de37a4famr5003056a34.3.1786715467991; 
 Fri, 14 Aug 2026 06:51:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20260730-spl-lzma-link-v1-1-03bb8331029a@flipper.net>
References: <20260730-spl-lzma-link-v1-1-03bb8331029a@flipper.net>
Subject: Re: [PATCH] spl: Fix link when LZMA is enabled without legacy
 image format support
Message-Id: <178671546717.3828101.15326438984010315134.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 13:31:47 +0400, Alexey Charkov wrote:

> spl_load_legacy_lzma() lives in common/spl/spl_legacy.c, which is only
> built when CONFIG_$(PHASE_)LEGACY_IMAGE_FORMAT is set, but the call site
> in _spl_load() is guarded by CONFIG_SPL_LZMA alone. Enabling LZMA
> decompression without the legacy image format therefore fails to link:
> 
>   ld: common/spl/spl.o: in function `_spl_load':
>   include/spl_load.h:73: undefined reference to `spl_load_legacy_lzma'
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: Fix link when LZMA is enabled without legacy image format support
      commit: 824317a8bc5689d93016e4c2211d194f98d9da33
-- 
Tom


