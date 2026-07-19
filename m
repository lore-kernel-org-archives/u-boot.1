Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E930C44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 13:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A4A842FC;
	Sun, 19 Jul 2026 15:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhlllare";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9205E846A4; Sun, 19 Jul 2026 12:43:42 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751BD80517
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 12:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grovesmx@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8efbafa1bacso77414516d6.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784457819; x=1785062619; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vkL5SN+N8jzOUJd3Va2M+hPaWdUNketPX2CT8l995VM=;
 b=mhlllarey5vlCzq7cz51/7/dP4ozQdlFSmwA6abRAj/5UqwVsxwPl3zQUA5qnE9Oh0
 5vZMOWb/QN8mw6sTp6tmJ5/fUTuxYvGCp+8s3T4PJg20IpH38po1nhwgpPEjeKV3XS5X
 77taOfMLvzpmfpYpXehaHo09h13ulyOt4hxHt89UZoye3OZeicelecGPa8AqTYP6OdUT
 11azrejNjNs6qB2Pngt+q/Awnx9+atGnEe6ibh/RYZ+DkBfT7IIYq6FjTobO3rFaAFfI
 nHokWCIX8Y4Mu6nzcHD+7BG732WGw5HQvi52KuWpmLtNqdpxVIhM4ZQ6wYpVf+uuYKXw
 iiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784457819; x=1785062619;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vkL5SN+N8jzOUJd3Va2M+hPaWdUNketPX2CT8l995VM=;
 b=mqHZIBgJ20NmPc14qO/+qGNQA5YoQNlncULF21pwKoUOGInXjjeiFG7E1dz0NgH/7P
 RT/bLtLFRNCFohCQIx9SeUujbcTCsnqmLyfxsjxL4Y+TFSfHVXvW2zDoYytEOLn7syzu
 z0JSQd/fiNARevuwqq5CXoCcP6OwCr4PS3qRf6u4DV3Z5CZIy/giRnqd3bnscVBRDopB
 lDNskJzC/7eKYr8p+bwQNyh9/C/PySDkJBStaKZrsyZLEXq/5A/GJ6pctKd1GEfm4SwW
 QkJLPmaV1PLjpJDpFokzQol/9jsKJDnnYju3TuGnye4HaD+zd9ZRMW1MVdYwxz+3j1Ss
 KV/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbZQWlet4FqgMzZEy+txDOCbnrrRLjmkOMZtzqm4mZTr0ldy090pp1eTykD84xjsHnNrqIU/A=@lists.denx.de
X-Gm-Message-State: AOJu0YyemvYC37TTBfoZ/76kPGxJrWYNpCxWVhmECF+nG14nrnPSfaQY
 dFHW3tb56x1dq0+6u4MSMabOSOOvNcBcXAWjrZ6mLNeSv2R7GSlJVs5p
X-Gm-Gg: AfdE7ckAexwh9mIoDUloF84KchdCViUH1vXqvSqN8RAef9JzKQcxQ13jPYVfqgP2+Tg
 RnKQZ+6+YynjX9QPhbiwM0tacDbzMm5RdkQPyQn5AnLcANkix9gzt5xWgZhsnBMmFZdjOEGQ7lL
 lkSqC4nbH+L4m7xfprF0g/sZeIxSMf8BGbHH5L3yIeSu76T6HavWDJNVefNHCnI8KsPL2lWHMW5
 0TjnAqJGlejPCym+BgoMSrT0osHUU7l+9iYIXD86kh3aspZLOaqWL4xjoyZ1U0HfO77AkbxtrRu
 LZ1jJ+/lZqpSLdqwyG1fX6db+qoRmd6h1tW+oLe1Ki/IkkOAPMe+SqA7TgC1tYx/g8xyj2bJtXi
 RDMg91Xg/M7Qk0Rb9lhh0bX75qUFArbeqllmpDo6CaG+yWulsgJntvWnCQRbRg9er02fz7qlTo9
 949uz+5Om8OmKE7x0/UrBmikzN+tt4p8w732wV2SHCgsi/HNI0iCaih9J7fOh7vIjT
X-Received: by 2002:a05:620a:3722:b0:92f:c78:559e with SMTP id
 af79cd13be357-930b3ee9343mr982381385a.35.1784457819194; 
 Sun, 19 Jul 2026 03:43:39 -0700 (PDT)
Received: from pixel-lappy.pixel-brain.net ([153.66.209.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778728a50sm65277686d6.47.2026.07.19.03.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 03:43:38 -0700 (PDT)
From: Mike Groves <grovesmx@gmail.com>
To: pbrobinson@gmail.com
Cc: Oleksii_Moisieiev@epam.com, andrew.goodbody@linaro.org,
 ansuelsmth@gmail.com, chenjh@rock-chips.com, duwe@lst.de,
 gabriel.fernandez@foss.st.com, heiko@sntech.de,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, mbrugger@suse.com, me@per1cycle.org,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com,
 paul.barker.ct@bp.renesas.com, quentin.schulz@cherry.de,
 rfried.dev@gmail.com, sairon@sairon.cz, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.denx.de, volodymyr_babchuk@epam.com,
 ycliang@andestech.com, zhangqing@rock-chips.com
Subject: Re: [RESEND PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Date: Sun, 19 Jul 2026 06:43:34 -0400
Message-ID: <20260719104335.211638-1-grovesmx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CALeDE9Pwp9j4Nh-YS-ncx+HfXz4oVfabkd6-eDgQwS6JOO4ZxA@mail.gmail.com>
References: <CALeDE9Pwp9j4Nh-YS-ncx+HfXz4oVfabkd6-eDgQwS6JOO4ZxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 19 Jul 2026 15:11:38 +0200
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

Hi Peter, Torsten, all,

I have not been part of this thread so far — some context: I have been running a forward-port of this same work (full set) in production for several weeks now, across four RPi 5 boards (revision e04171 / D0 stepping), as Kubernetes worker nodes booting from NVMe via a custom Talos installer overlay. This is what prompted me to start following this thread and look at contributing.

The ask is understood, and tracks with what I ran into looking at this myself - happy to help with that cleanup if useful, deferring to Oleksii/Volodymyr/Torsten on attribution for anything I did not originally author.

The three-way split makes sense to me. One thing I want to make sure I understand correctly before anyone puts more work in: when you say RP1 support is now upstream, could you point me at exactly what's landed and where (kernel tree, specific commits/series)? I want to make sure part 3 gets built against whatever the actual current reference implementation is, rather than against the static BAR-configuration approach the original RFC used - my understanding was there was disagreement about that specific point, so if there is now a settled upstream answer I want to build on that correctly rather than repeat the same discussion.

Once there is an agreed shape for this, I am glad to help test against real D0-stepping hardware - that's one gap I can concretely help close if not already tested. Happy to also help with the actual restructuring work if that's useful, or just stay out of the way if Torsten's already got it in hand - whichever is more helpful.

Mike
