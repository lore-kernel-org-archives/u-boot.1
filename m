Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE78109E528
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9034B83E7A;
	Thu, 26 Mar 2026 00:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jV0izTtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC286840D8; Thu, 26 Mar 2026 00:06:04 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423B884027
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46808125c65so127356b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479960; x=1775084760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsdaEZ3yY6+BFS/Jk0G9GW4m3KGJpdtliKo6+3VDSm4=;
 b=jV0izTtcQSMPm+iQF+tQebBbVE1KjZ/pru3doUObkFEbVHKpQAQIP/YQs9Bwu2sCxx
 cAJfjt2nNBKuDL7lcDOmba+E7uKIRU/tIsQ2FkFlGJFVGnnXbXpa76HFJJmNnjkoySd5
 xR2/v7XwNPfk88UKeLTz6aqf5AcmYh1+igQmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479960; x=1775084760;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsdaEZ3yY6+BFS/Jk0G9GW4m3KGJpdtliKo6+3VDSm4=;
 b=W8r/4d9JPL5ZIfrQs4QfZSguGbZTcvQWh+c7b+mAlbtjoZ768Kdf5VR/bXuNN9RUFK
 zViMvogVGEh5MzrU2h12VBv9semHZg7743+wYYNIfYW4SPD5GrINpvYvPBWqXNwM3Nwq
 YiGSCyQBpwq/OFXvvHrJRiBKNQcXkH6+8HO+FwcfZOMZk3ikqd0tw0/OmAC002Zf144V
 Zq+TnzmwIYkckjddBooyB1h6j31n7ldfDmk4PB13zdcPcj2x3qB0xUJiDPBJxxbNiMMD
 6hruDjRqoIjxV2qCnVh+6mcCOSUkNttU3CK/HgWrVuoiIDVbvYmTEkLTrcEzn3KpRse+
 ZNiA==
X-Gm-Message-State: AOJu0YySg8yb5Ab9Qs/0jFKlAW27hG3Nt8g22LVFv3uYf2kg8/JFva3D
 k3htesSzpBG/ff3V4s52MVvSyvlUO+ZU3GDCt/lqL+9rRuRa+DXKBZ9r/CfdO/nmJd/kAwoO4Pp
 Nath10Zs=
X-Gm-Gg: ATEYQzwzc+Qa/DgKHHDG/Pad5je3KsKqeTx57D+TyVyyTHlDwx18aIN4xrzsulBcsCO
 cj400r78+WVtHtYLFInC0JiwEUFwD9FlY0xVi4MOKfUxx+OSSSj8BW8jjxdjA4mTiik+1aOTTIw
 3UDRIQV0bYYsaJqoDsLNkzSqKIh2PKc88Da+mRpCsQ4g2cqtWLXkYrWUI7HqMSjTSgADq/H3aQy
 kSwGxjd/Ne1TKAibrMF7u98OzzKOFVPEsmlP4foOhqNaqV/gt9o7xZXqXC8V1Kw3IdRHEA/BQVF
 g3OusGN5mhwzrx9s/K+k1Ris08gfRh8UuvqOIkQrhDRTtZzB3535j/bBWR11wgTSJpa0Xm0rRR+
 JJQkkieSpc2/6LjAMY5y9raJ6iY9gKHYuFYmAYQgy8LB0fcK+dQ9EN/ighNgyorQaUPgQw0hUnL
 mt3eCVwoKxaSgHtCAcLQSVinDynFUear9l2X/Q60iRjReeQs/61JL0buXhmUmEzUzxjdxD5OgOy
 Ga/ySNfpr1VbmArepnt+9+anp8ToBZ36IRLwZs8vG2Q+kg=
X-Received: by 2002:a05:6808:17aa:b0:466:feb1:5f79 with SMTP id
 5614622812f47-46a5c785723mr2481903b6e.50.1774479959929; 
 Wed, 25 Mar 2026 16:05:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
References: <20260312100106.702368-1-ravi@prevas.dk>
Subject: Re: [PATCH v2 0/4] add [ as alias for test, fix 0/1 argument handling
Message-Id: <177447995901.3508238.4236856739882459467.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:59 -0600
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

On Thu, 12 Mar 2026 11:01:02 +0100, Rasmus Villemoes wrote:

> Make 'test' behave a little more like its cousins in other shells, by
> allowing the [ ... ] spelling, and while here, fix up the handling of
> a single, non-empty argument to comply with POSIX.
> 
> v2: update documentation, add a few more test cases.
> 
> CI is happy: https://github.com/u-boot/u-boot/pull/905
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] cmd: test: allow using [ as alias for test
      commit: fc8bf9a984c118d551b3f93c66f1ae2733b9b588
[2/4] doc: test: document [ ] spelling of test
      commit: d44f61582947564991cce7501f2e5db0b29ebad6
[3/4] test: add tests for left-bracket alias for 'test' command
      commit: 6f9cc3310a764aaae4478b5a8a0c0cae3b2be4a1
[4/4] cmd: test: fix handling of single-argument form of test
      commit: 8b0619579b2282050e7fb0d92fbc645b79d18bae
-- 
Tom


