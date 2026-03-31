Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8726E10F92FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 20:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6498E83E7A;
	Tue, 31 Mar 2026 22:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J2azRs0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE23F84056; Tue, 31 Mar 2026 22:43:06 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D80E83AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4152698e745so2272499fac.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774989782; x=1775594582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71QG2dOUXXz8SHYA+ueTJhSWOKAz9NsHay5zQZN5d5E=;
 b=J2azRs0xMmOMSDK7gnHlpOGODqZIBqPU5OTSeUwBtMps6BW0F3GygvNSRyD3RwGtvh
 YNApodxhEhJLrVJLXzCs6xSExiVsct6KXUK1r4zY6+7eAFQyVz7IJtPUYQg9f3vPUt1j
 zsXgBdGdWxNNcgffXmHUl0oRb8oCGfD/ureOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774989782; x=1775594582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71QG2dOUXXz8SHYA+ueTJhSWOKAz9NsHay5zQZN5d5E=;
 b=Bi6HnDBNNuxL4qdnqpRs4rUxXwgMv7VBquCoVNQlHLLjq5sVOTIGgM0+1NXr8vQEj2
 mwmqdmjKAjW1JsMaCEKjhlHx0aStnOshldb+wRS8+Zs9iOECpxQwR172dwYlmXEvN/pZ
 xilCYGnXPN6L2qnSppL/HukjgXr+bYneoaSIMcT4m5SNNdXS7afDAdGDB5h3zya9NRE/
 OVELN16rK7fsOcgcEA2sCXP2Y6hIYprRATUD30DK62PVda73Vot1+96wwkcSWXCNEgGa
 5IKtKm0DfEhrDh85X8mMXpfeGyNY1MpjwHXgmPP/w8pIh6oC3DaBKqc0jmDRIqmsiXik
 f3Ow==
X-Gm-Message-State: AOJu0Yz2DCECA9CpXJWWB44UW6JIUqiMfaoYhFx3ArLEaUjER0A2SPiN
 xWAFrzRjuJaBeVOraxGIB246cNfxR9zdFgn3+fihRs9a0NGoeo8RrtZHMNdBQcXVbNh9F9ZKZjB
 nkgKU520=
X-Gm-Gg: ATEYQzzM1OLJOMVTcg+qdu/6O6oZr3XLBPiOsNnzkjHjOD+LZnUfqCdWnhjsWL4yckW
 TQbXZsZhPhtR1pXPuVGrSfQM9W4VN6ZyfqcSMo5q8lkEm+Vs/Ynre1A0149ra+GhjPYqQ54Juvl
 LYZvZ3pGdOX6cPe+C7IKVTijVB3cJ8mp0szVRKYq1sGkD/Lb1XOOYj160DD9+FSX2kkVfr+wvul
 B3Eab+5TfS1r86THcjy2O1xMKK0V629koeRdWtJOvzJrBfS5OKACb9tAy3tw/wkr/2p7wde7Izo
 gC/D6R8n0wWwX8/xW3GI8mdxCNfRwNV5FhrYX+FA2heImAZyV+v/bKWxLmHBUKfDdhGBF6uZU1V
 XOlIeVd3IoxzdfmmEQ+iFrD3dNwEF9LAkXxCSQ27ySkJ0Gut+mP3HlC7DgmjTBEDmv78TE2oDxb
 Ek1qhhvOeMa6+dU5NtnVrc3gwuiqYT7dpjAd636NH2n33NmJdfPrtZgnDk4oAd/DKIVIqlqjN2S
 N8yVkF/ONP8Jmt1NDvLBbIENqTgflNK3ieS04nCcdTSXpeuPAs=
X-Received: by 2002:a05:6870:b2f5:b0:41c:e4:f933 with SMTP id
 586e51a60fabf-422cfebd25cmr786631fac.22.1774989782168; 
 Tue, 31 Mar 2026 13:43:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm8036752fac.4.2026.03.31.13.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 13:43:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Jerome Forissier <jerome.forissier@arm.com>
Cc: nd@arm.com
Subject: Re: Please pull net-20260331
Date: Tue, 31 Mar 2026 14:42:50 -0600
Message-ID: <177498406592.1300265.11722109677715680627.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f3e46b87-6c9e-4145-9ddc-cac3e317d593@arm.com>
References: <f3e46b87-6c9e-4145-9ddc-cac3e317d593@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 31 Mar 2026 18:27:41 +0200, Jerome Forissier wrote:

> The following changes since commit 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b:
> 
>   core: Rework REGMAP symbols implementation (2026-03-30 16:59:35 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260331
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom

