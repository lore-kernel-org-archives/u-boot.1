Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C039C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB568818C;
	Mon,  8 Apr 2024 20:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afGGf4X6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F5E880AD; Mon,  8 Apr 2024 18:41:50 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41BA8787C
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 18:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nroycea@gmail.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcc7cdb3a98so4403934276.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712594506; x=1713199306; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X4Ai8eGsDcOMxleh+6IJQz8uv0SngY1eOIsUqiy2scc=;
 b=afGGf4X6omu+rk3wv1LQcuK7Fm67TSxOkio9KjM4RYirQPGZPEzCLHsMAhkGsEo06g
 AGLHVPU+6pQTIRo4spG+rB6dPIU+pdvRGCQQL0DcBLbwl1M5vnZJodLKchdW51/RIO1m
 1hQaODmAAFmKIjpRZAkHHYKIwaSKiiKc5n/S8zo9BEk2l17oCqRGIuqAZhzEBOQLFlmg
 4iK7YLOQ8MxuyzZCXEYfxLtLA46fWeayKlGgm+4F84wo28o/jtXkrBEKyniztUqBY2nV
 HRybL5qIMhu/gro2M3geMX3FGpWxQevFjwSRkzivjJhAzkgZAvzKRc9IMCpd+vn18qRl
 /W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594506; x=1713199306;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4Ai8eGsDcOMxleh+6IJQz8uv0SngY1eOIsUqiy2scc=;
 b=oZOIMxIitd0xB1dM25bqBP9o7H8rmA/yoZ9P45RzGll88o4wZcuIzdK7b7Y5RhvlVs
 G079FQQinLMP3vrGb+jpnvlm0oW9Z1RWWAk9ZPAj6kTzk+H4L4NBGWjYACbkJfERFGY0
 glh0XhWUQ7olWodxS77dDV3KErZz6n8P5RGOh9S3uKyJfPGQ2V6MV06Ty9xoIQLKfcRQ
 oRtF8+IBlhXolwHNqg7v8byCOF9jSeRnR21FOh9r1rwFuVzGdvl3htJvyw9rb3M0OQow
 8l8T+L96KrCd2bF0eTWN1i17CmKnthKNBK/utGB1ZdwKY9arcHDK43qL+q15L0poFbc8
 er1A==
X-Gm-Message-State: AOJu0YxhkjkHhUy4YBeuOAy28T2mOz9N0aMocsHBZChElrsJUxQam+s3
 yS837OEE1a95C8ZqB4a23bAh6M/R1LF3jxN3vjkXRWN5LGfz7clWaHF+TKk0PIxAI/Z7OaA2/di
 qQxawswoIBWLp1zXEEZw6scSIBh+hCvcLK0Y=
X-Google-Smtp-Source: AGHT+IFgmE8Sls0J2ROlaBj8jSbbyZuD0Q1w4xqN+8actAcUjZ3NahTUXdykyooEeV/NQeqMtxuSW9SBOurn8H7/pNU=
X-Received: by 2002:a05:6902:248e:b0:dcc:fea7:7f7b with SMTP id
 ds14-20020a056902248e00b00dccfea77f7bmr7805819ybb.11.1712594506627; Mon, 08
 Apr 2024 09:41:46 -0700 (PDT)
MIME-Version: 1.0
From: vindicator <nroycea+denxde@gmail.com>
Date: Mon, 8 Apr 2024 11:41:10 -0500
Message-ID: <CALaQ_hrVXwbgrCwkw4=OzsV2mvkWaMVMHUpC42byALg6gwtxyQ@mail.gmail.com>
Subject: U-Boot/UKI Relationship Regarding Multiple DTBs
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 08 Apr 2024 20:35:45 +0200
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

Is u-boot capable of selecting the correct DTB in a UKI during boot?

I saw "doc/README.multi-dtb-fit", which at least somewhat addresses
what I'm looking for I think, but I'm not sure if that will relate
directly with executing a UKI that has multiple DTBs...

For my one board, I was working on building a workable "tinyconfig"
kernel, but then also had the thought to maybe also build another
"allyesconfig" kernel (one time) so I can figure out everything that
gets used for ANY board (supported for $ARCH).
Then another thought came after that, that maybe I could pile in all
of the DTBs the kernel supports into a UKI (via "ukify"), which is
where I came across https://github.com/systemd/systemd/issues/31946
(convenient timing being so recent).

So it looks like my thinking is "doable", but just hasn't been done
yet in "ukify", and I'd thought I'd check here if there's anything
that needs to be done from u-boot's end as well.
