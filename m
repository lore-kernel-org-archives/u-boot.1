Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008CC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC0184BA1;
	Sat, 11 Jul 2026 02:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNMXykld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9C684AC3; Sat, 11 Jul 2026 02:17:30 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA5C84B61
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43cce34c881so806692fac.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729047; x=1784333847; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J79603PRyV1zLg/XZMVo36iEiPdlzz6wI41IiJuW4Ks=;
 b=uNMXykldqx9GlRsg3bu8ZE0F0cGrB58vEew+2cDZc47oBxLtJ/yRpwweVV1ND7GntT
 x0h6bRBEf3bk3ROWZpR50UyQYaGQChUXmL8W/OoHsfm6rgDusfpeopVEevBmM2zI6TUG
 7Q2oibwzh/IHIJZvu3tPzZ0J4A6G6oukn+pWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729047; x=1784333847;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J79603PRyV1zLg/XZMVo36iEiPdlzz6wI41IiJuW4Ks=;
 b=hPAOySxSCHzBxRlUYS+cczNtmYAYuoQUBJ0+UhvcWeHTwfLSAAqYlow0xakbMv7YnQ
 Db/3Mk0E1HGGWzrS1B2kyVYKRajXJOihTtpNRVxIaSkWRhZ3nQOvV6LY/jRGG8/QsrkA
 oq/12xiwo6hDdICxn0FUaZUXjhYMWOs+LM9tAD1h2gxmEexR844iTPTl1KAE9IPYctlj
 ANZ6GK1o1OpHM8k9xYD6Fx7P5yVElubUd+n0f4mCnum93W68wyU7WHkJuaG4drJiGRaw
 jsxbCDyQsvMPYwhRkoKW3P4IGeav72ZpGdGud8J08S/zwgvgdqby7PY1i/jzt7YHemMD
 rowg==
X-Gm-Message-State: AOJu0Ywgon+b90roidA7ngVzWAzM9UrTplKdThtKVHEF/kIZoj4iAmfd
 bBf6LNXhsMWtmKVyyw3FlZoxV8Kn++OpuR5iBu/Jmn1vEXmw/vPR1t8Mbb9ojhijAWnR8l/4ANR
 1ATx8BlI=
X-Gm-Gg: AfdE7cnJzmltxwPft9JT5c6cHeuMrvz+pgCpgOAUq1oLLOmmrzvPE37ApyEFYrCHQdJ
 ZlNZczSo0K2aepTnVCOaWXIDvlvMjHh6kosMT5BPu4ic5jrt7ad5oUia9pnhh+gVP9A/FHPHsmd
 fxmPHQML+TSwx4b7wdLi249Hou+BB7B1iXX5EJXFS6tzFEFZDPNpJSAIkWwRjYYdAI+W79mSy/F
 xQnHQfYEw5vddTyMJTBxw3C8jCw47HcZHyC/0l/4A1zwh1p0dgJXV/mpl0HsbTrlvHPjctuwZEf
 Rr+DOT01B5p0cSa4usK1gkJcTCoPS2Ij1iMR1QBZCsSDiDYuYJUjT+kci+Vt2DD8EsyfyOvnYnU
 71YIrXj49rh/X11PcNGaFY7i/NWVs4crnGA3Ogffa22Cf/r3skbIYMmx92YDItZUBVfUez9Gvbg
 HMEP1VDJFua+6d+qfiLJjfsLEda5H1y1FdRkcJbpD159nPFp1iz0ySpxffoA1z1pf27wK4saxy4
 zAfvakOxUYcCYKwX/mwKudQ4Eu4XkyPdmfiHNwQgmmnlEM=
X-Received: by 2002:a05:6820:f02a:b0:6a3:7976:7059 with SMTP id
 006d021491bc7-6a39a5aeea3mr818079eaf.24.1783729046757; 
 Fri, 10 Jul 2026 17:17:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, bmeng.cn@gmail.com, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <yyd6c26qxgnlewo7jzibw4ryl6aycp46nfefwanxulmzs3y5k2@wlde6okhi43g>
References: <yyd6c26qxgnlewo7jzibw4ryl6aycp46nfefwanxulmzs3y5k2@wlde6okhi43g>
Subject: Re: [PATCH] cmd: x86: zboot: remove duplicate zboot_setup() call
 in do_zboot_setup
Message-Id: <178372904563.2905849.10054124778877257482.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:25 -0600
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

On Fri, 26 Jun 2026 09:20:22 +0530, Naveen Kumar Chaudhary wrote:

> do_zboot_setup() invokes zboot_setup() twice: once with proper error
> reporting, and again immediately afterwards with no diagnostic. The
> second call re-runs the entire boot parameter setup on the
> already-populated zero page, which is at best wasted work and at
> worst leaves the structure in an unexpected state.
> 
> Drop the stray second invocation; the first call already covers both
> success and failure handling.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: x86: zboot: remove duplicate zboot_setup() call in do_zboot_setup
      commit: e0d10a4b85cb3adfff152494afe74d3a0cac1090
-- 
Tom


