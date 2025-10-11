Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B55CCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AADD838F3;
	Sat, 11 Oct 2025 19:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWrzmvWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F30838F3; Sat, 11 Oct 2025 19:07:30 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426DB83906
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7bc626c5461so972066a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202447; x=1760807247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xHRCFcp5+ncWQ6D8+HC1Im/pdcLUgFZNqFNPSYnbTTY=;
 b=NWrzmvWp7V0XXGa+Et44cHlXFHbQDy8n8EK01IJ81T5SaZlE88COsxbJJmKwegmf3C
 FQsFOFAuHE/ZWO0Z8eaR4KuY85S501kptqWTQPTTaDt9rAvjMAol0Orm1W+wL5Zf13av
 gLIUzkKkU4rabNIlNP7Uv/KcTSvJfULpidzi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202447; x=1760807247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHRCFcp5+ncWQ6D8+HC1Im/pdcLUgFZNqFNPSYnbTTY=;
 b=SxPajdKrliopu3u3BPBXF6PlpRFypz2zQ0rYEumAuA3hzxkeA2rW6rdpITeKmGCnv9
 pp1Fh6XZY+fWSSS8OmTzCMlSIdkpZ+b4STjXW9J5IAE26ID0AV3vT8Fm1ZhuA7ULmJKA
 yeNpQcC5/TKXCOJ2EBRdGGVgtesEXAgJYmY/jcFc9SjUDI/gznDYbL8ELwYBkGsntHRN
 leIw2RCV2lyFiFxqF4oR5/YnU/mrAzTZ4MEhDTINEgmO+cLJcFywR+Bjv7AJy7FwnCki
 ONPlfscIBD9wTlTD2PNYwdTLlhgd4+OXrUw39yJN0JbpeLy/72gx5eISyGxWs0dZDJQy
 9vWQ==
X-Gm-Message-State: AOJu0Yw+j9Z7rgMXNa8iy3+fGLVzfD9+Eqx8IamtB415sCn5YGNKBL97
 QWt4Q/Se5/64qkzBBC36wGZOl48pozhEXiuqlGtLB6fL4MeRIU6GO0gSUCaeiwFZTj5fu/Iqd+5
 I9jYN72c=
X-Gm-Gg: ASbGnct4MmOkTNlmoWyJSy4ZxIvuvF1fUs6CuCZe2yWUsvDfJeX9ILuNA4QTOKH3X2z
 djUfYrGK29evwDvgduci3aSyvJOVnq8nKiJp9O9ENvuAX2h/EAUMyujo/K9BgtNBE1NReRGFlHn
 fx8gY/7zNV7h53AhWmVNa7JrmwX6rUJKjdeNnE7d2Z6QT3NJxmY0jgRMl7iwO6tp49x2nM3hePx
 V8SbEdX17XhEvKqtKkq7MdjMu9FdLL928td1oeNWgSCny7BTdWZqgkxaHO4JPmJ+1Xhb56eo/4l
 AmFAfzSQC4VyMvvGP4gyZQyMMGalvgvibFv5Ir2BuWuy5i4G7gDOR5+T8gRl7XWCk48exZHPQhU
 l7/1M5VbdM15BHtBMh4DTqEDVEjOU5HaMjmnRIyJRVP3/o0d0hPDRfGgpyix+WeoQoF0eiol78x
 kbsIiaxb35LAqU3A==
X-Google-Smtp-Source: AGHT+IEvrE2l19OgBFI4d8mgpFXXnXXq8XqPe+Aj+uwlgPh/Fx6qU2GUy1pEddLrnHngSIhn9VjmHQ==
X-Received: by 2002:a05:6870:330b:b0:314:b6a6:68a1 with SMTP id
 586e51a60fabf-3c0f9595ddemr7036338fac.41.1760202446920; 
 Sat, 11 Oct 2025 10:07:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203101.2828577-1-trini@konsulko.com>
References: <20251001203101.2828577-1-trini@konsulko.com>
Subject: Re: [PATCH] lz4: Do not disable LZ4_decompress_safe* for xPL
Message-Id: <176020244612.1312138.682456160356797507.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:26 -0600
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

On Wed, 01 Oct 2025 14:31:01 -0600, Tom Rini wrote:

> We should compile the LZ4_decompress_safe and
> LZ4_decompress_safe_partial functions in SPL and they will be discarded
> if unused.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lz4: Do not disable LZ4_decompress_safe* for xPL
      commit: dde1515be5e2f6fdf3429b0d6d5ad6fa80e7715e
-- 
Tom


