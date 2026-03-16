Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA0AF53D7E
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1113084171;
	Mon, 16 Mar 2026 19:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pGyQ2IVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012C38414B; Mon, 16 Mar 2026 19:07:43 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E56D84142
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d73e0e0a36so2141781a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773684459; x=1774289259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd/07Txef1lCuNz0KSTNiuJjZTG3KbA/bZ3YA5VvYFU=;
 b=pGyQ2IVhwgB6iXT4SBY3zK/wtn3wXSaCavGkjGUZVyeraqtI0nZq6iN89TXcBpp2Dw
 otnhy+EbQVf5LsHX5wa7bDW3ga7z6YmGrqxFMpAGb7TuXBiBaGGaHtZDKBD/aN7NHRYW
 ePgOBU1EfyY+6ktOWLV9r+mrPgq+a0zTkAnxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684459; x=1774289259;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nd/07Txef1lCuNz0KSTNiuJjZTG3KbA/bZ3YA5VvYFU=;
 b=oQ9+I+d1nJNIRbbKBIGwhuFSgDodomkK2gs3/HnQJYI1a1Ctfqwp+Ieaz9ZCbCof5I
 uZlX2YZIz2o5YiGeLr5cG1EdY0pzm0qJNa6PdpcdwvZqOdyoJr0JASoGkt2MLl2R7cl4
 FEffbt3N4cyACsq2uRUr405fijk5B3RUyGgjRYU/mfzvPcu7iYOTTbW0YqvJW2nksOwp
 OG5ev7c5NW2uv0EqbN90Q1hnW3YgbQpQl6bPJ5JlnDwf2P2poCku7qCnITIuoxPZ35Eq
 SddX7ARn3mdFrsoQCPqGgGbaeEYw0mTv+jtpJIx0AcUavn8zk7JPTTrM5U4cfmCrNdSh
 UvKA==
X-Gm-Message-State: AOJu0YzY2TbqcoeJlRRBhP1ximFFhyXBlcMPW+l1pqBLZAsB+BV+Nw4K
 ExQ6C/oLdlSVdiQq2iFQ0sTKWBsJutNtVFGBFw09Ze2Ox9x4+zLLNpEmREDiP3pdqNo=
X-Gm-Gg: ATEYQzxbTXVwKcdnKHZ8Jukh8aumYLL4yAOd2BFzZxy6+LiVRYC6WuR8xWc3OsqGiEG
 t8RcJZt4tJ0JEHdcSFlWCQucjduQhXsSAd6qIxFQJLM8BwmshBREsD9/IdUQIY9hFT1XjTknuSF
 sezJsLpi/9qnYirXbv+eAlHp/gXLSkbu3O9jTHiBexPgcziHE2dsLL9bCXrSmGm/si6ZYQYzi9o
 vdX1Ln5aGr9ZmwGRgqjzI7jqqTLvhneYIyT2y5qQOSnHllVKWjWIN0C4wq/i2snT7v0Gs6t9aZB
 c+Y/ulvvz0sC6neWADgZNens11yrVd//NcU2jOX+/UOSenVP6Fb+dzdBYZhKIDgWuVUPdXpk5/e
 /2IweF/bbOYVgaoJ9rzltKhHOR/fRfZExX9y32rTAviP4uVw2cobPu14uJRidQpE7zaan3YwYd/
 queeG+MX1w3TjT4Uzvh91UqDrKmvdfw1//rvtxDvrKD69WhOP3BAK6Q0X/TVtCHZvowes69evnM
 pUAzCxvply5pC88zQdOuCZbtSIbYkSJGuN9dplF8Xdj2lo=
X-Received: by 2002:a05:6830:4421:b0:7d7:b89e:578d with SMTP id
 46e09a7af769-7d7b89e58bcmr965873a34.4.1773684459155; 
 Mon, 16 Mar 2026 11:07:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm13255393a34.5.2026.03.16.11.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:07:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260304184900.3104058-1-sjg@chromium.org>
References: <20260304184900.3104058-1-sjg@chromium.org>
Subject: Re: [PATCH v2] kbuild: strip sub_make_done from test-script
 environment
Message-Id: <177368445849.2276702.12311067513791017742.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 12:07:38 -0600
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

On Wed, 04 Mar 2026 11:48:53 -0700, Simon Glass wrote:

> The exported sub_make_done variable leaks into the environment of all
> child processes. When make targets like tcheck spawn independent
> make-invocations with O=, those child-makes inherit sub_make_done=1,
> skip the KBUILD_OUTPUT setup and try to build in the source tree.
> 
> A global 'unexport sub_make_done' cannot be used because the build
> system itself re-invokes the top-level Makefile for syncconfig (via
> '$(MAKE) -f $(srctree)/Makefile syncconfig'). Without sub_make_done,
> that child make re-enters the KBUILD_OUTPUT block and recomputes
> abs_objtree. With a relative O= path this resolves to a nested
> directory (e.g. build/build/) where .config does not exist.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] kbuild: strip sub_make_done from test-script environment
      commit: a27980786cfb3c430aa1c05da8e79180c584d221
-- 
Tom


