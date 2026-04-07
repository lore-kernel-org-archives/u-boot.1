Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29DFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D082784213;
	Tue,  7 Apr 2026 21:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qw6XTWBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA477841FF; Tue,  7 Apr 2026 21:50:27 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A7F84154
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-41708f6c3feso3491790fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591424; x=1776196224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwSkJ3K7J7ffq2SeA7Bu4JoDq1rg3p/LdZP339+UVaE=;
 b=Qw6XTWBT7JpTiyMf8LkHcJd8CeR7w9DRotkA7TFxJpv06Spz9XzYx3Ox7X/oruZ1P4
 NAzJGwg+LwhIW8A+IILFLRPA8w+NsxhFN8eX5RkxonSSjEHo/w+ab+LnBE9cnCJ6WJm6
 5GDYJmiru/jThZsCbLcFMGLg7CHoFQA3QIh50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591424; x=1776196224;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MwSkJ3K7J7ffq2SeA7Bu4JoDq1rg3p/LdZP339+UVaE=;
 b=CoaNUlKRritIowMmt4AoeH0chdMgzSwRhIZDMEkcT/v8mUkdJN50acYO6Lo43AVYnx
 6ajy7A0dkX/vU51xDI+QnDq0fmDBE6xU0SwXGyp7vjnMhKcirPCkLniAS2XwF/ymguf1
 6WLxcr1tMLfaEVBBLM+HP4N3F7L1oe1LXdbAlF14rjQzyOG6rMWHJQDV+e4oqdbWtJWJ
 eXhaAxK+z99pK6/RWsa5s6Ivp6SBgZaZfDFM9UAJqJ0aO4e3k9Bqivxj2sVYw4BTzogp
 +YE/Fijh1soH/0QDXSFMVpT8EwTaR5+FG2ALoaHoCHHmJqb6iHAzpP7GvDeMV4Ucvy88
 8tZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG90poqALmEznyXpjNJqsnd5B6G0nGRCwOYDSjJy2YFjugXqvljA531KXnKnbPILaaOoelt2A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi+2+Ud1SCjpgqdwhYIq2rwER5eSRjJVTYPge/RjzorU8TMr25
 9ND0WXpYMkBJfEy2G6VM3RStvllfgBE2XXO9oYJKvr4V7SLYatvHS41nFCU8rh88Lq/l2KL8B67
 KH76HxJ0=
X-Gm-Gg: AeBDieu1lHilmcoSm5/PkFqqOBtGvRnHmtxRDXvX5ikJkEAWYVmRzcjQBiBxN68fi34
 VGpQQIbjNrnFfqX0nqUmnRm5URmQneqdsQ+bhuNNTWvKY0CTLL+UiS8Iem/UmoIaI6djBJUyHAW
 8rz7Y/LK048vJuT0denqJRv0eTZK8Wru5XVUcb4hFzw9Mql9eIM7xqEYntZWpGGCRF7vcH8IxrT
 LnclkrC4nMEi3ZC4ntX4ecClpA87WmwfSyUR/Sven5vRSnMIL3fPlN/531NLxAfAXM42oPQi81W
 NT6+tP533LN6w6eVVQ/PoTXYmyAGaws4qQLqV48yhR1fn33aG/7uUhusAGMKjtAn6w2PxYeANH8
 KN1GF8qan+HjjLzodVw8fU3ffIWCezgw9WxWALA4Frv8FeWq9pF4uvNfpi0otZCe340k/bvPn9Y
 ZOo8U4doMpjdl/Ys3kMDsMvoapT9kLPwPzhUcEf9fFOA4jXHuOd0VmzXZ0FtXzXwh3hMYa9wrPa
 qQ6UhmJTAGKHEA+Il8hvfOSAL+wlntR++KZvMvSq3RhUDY=
X-Received: by 2002:a05:6870:72c8:b0:416:414:bbd7 with SMTP id
 586e51a60fabf-4230fdd9514mr10800072fac.21.1775591424419; 
 Tue, 07 Apr 2026 12:50:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260407-doc-fix-stats-link-v1-1-1b53b54f816b@baylibre.com>
References: <20260407-doc-fix-stats-link-v1-1-1b53b54f816b@baylibre.com>
Subject: Re: [PATCH] doc: release cycle: fix 2026.04 stats link
Message-Id: <177559142354.2108693.284535265862885295.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 07 Apr 2026 14:13:25 -0500, David Lechner wrote:

> Fix the link to the 2026.04 stats page. It was likely copied from the
> 2026.01 line below and not updated.
> 
> 

Applied to u-boot/master, thanks!

[1/1] doc: release cycle: fix 2026.04 stats link
      commit: c3062edfed295c010f81dd31b9e9cdfaaeaa71a4
-- 
Tom


