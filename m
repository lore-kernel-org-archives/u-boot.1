Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E91CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D99C83A41;
	Fri, 31 Oct 2025 18:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcaH5Wl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3426783A5E; Fri, 31 Oct 2025 18:30:49 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133AB839A8
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c53908e8b5so1490411a34.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761931846; x=1762536646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhQk4lh77i4vVyBvdvfncqJK3rYWye/Tcx57Ifzg3S8=;
 b=YcaH5Wl8bwS1aBWTpsCuyFscbBdD40t47j7m8HFQmTUswgjQIv3kFCVNb3p+buKmir
 Rls7muJyYuXBbCyKwPniZRYBQham7s+foDddOA9QN0rjysylRSWnyUiTdvYxjDbyLMvL
 oJiemhIE++nQ8hW2w7pnDXjNjE+eI2MlI/rTFkXl0tWJR34YAIGg6/3Q8Q6DjfV5ZXmA
 OR0ylEnlt7l0rfoNSfQQY7NSoYFRVaOmA/NitBfe8aM/2nIVuh+vSRR2WTZ1cgefZRAE
 6xluJn/kBci0zd8CUKS5k0eBSM+ivLqvjjXymAU6MTAXZM+sqoyaiaqPUnJzNfuqCoG9
 hfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761931846; x=1762536646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhQk4lh77i4vVyBvdvfncqJK3rYWye/Tcx57Ifzg3S8=;
 b=pAbrQxLf69mAzWLWSJltNQZI2N8y/nuYx9udsrdmTaDpLu+S4pHWcDafnvLDObeVzc
 S2wzLKt2uguJEh+/1R0PNT0Ck9Kma6crvGznygi8/GuGOs0MJp85M+gUSIOI11mPtv3Z
 OaYs29WioHkrMu1WzNlyBNuFjfgF97CH/bKVls0r7cPDV+EHQSh3M2rpXfx4g38ZB8wB
 lSgOJaB6o9NxG0iUzBED2AMic4f93u8s12G1L5mUDfj1sO5mkxFq/o7j6ECpJ2GAqwSZ
 t6dC/pto7Bz9ktJxyNd2B4bKY2qUfbYcfOBBtSKGl5ICuE++qBptOUO5RBeCF3m/YrgY
 NxGg==
X-Gm-Message-State: AOJu0Yyw76xGBGLDqFfitV5cqfTBquTABOIwqazRn4sxoNKg+59q6p5L
 i4C0wzfRyiSllOJoY8zr5EL8aqIBnIk42RJYaWa7tfDKD9bNWQz7bYe1R3CoSeRfgaZH3WuztHw
 bp28L69DPDFCygqBFNPcvnoUD1tYCR7I=
X-Gm-Gg: ASbGncsr165zC/FBDpWN0viblWmj7o4sCSfwi4vRBs0WvDya5zPSVT+r5CUZKcpjxdH
 zRhRVmrZF1OrgIyDj46cLst3gCwPUsuL496vEBfDp7RZolI9/mS6PoipDR5+K8g3QKSCFXiFjzU
 1mhUCCTOZ2B4Lq+gHM5YNjyHAHrJGfQp9k77Oq1UA3cXC0DvZojcoB1Ep8t3/WcvypCnGX7l2bg
 FoNXUegdMkdVD26UH8dSTJ8dIOq8JmcxHCrbttZ6Lf6oH2qsMUo0aBtl1R5TpkzUN8S5TL9
X-Google-Smtp-Source: AGHT+IHuWdaSZMgqaGaW9M/v7TFviFSicJlptcqHC56ggH81TIXGsDkryGutxMuh2trn+oFtbIjAgLq89Yg4mDrsCpM=
X-Received: by 2002:a05:6830:380e:b0:7c5:345f:60b0 with SMTP id
 46e09a7af769-7c69677bea2mr2273906a34.18.1761931845647; Fri, 31 Oct 2025
 10:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
 <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
 <20251031155427.GC6688@bill-the-cat>
In-Reply-To: <20251031155427.GC6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 01:30:34 +0800
X-Gm-Features: AWmQ_bneGjr3s2RebKKD-LFcjKOqWe2LHwzC4DvkV6edgNTb1lnddcSNSb3jt80
Message-ID: <CAN7C2SCXWoi6XRKppKFUzPiUykYeQ0Mbm=S3dhALajP98S8rAA@mail.gmail.com>
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> That's interesting. But that also does mean that someone needs to work
> better with upstream about integration here as no, that's not where that
> kind of tooling should live. At bare minimum it should be in
> tools/something/ and have it's own requirements.txt file too for
> whatever python modules it requires.

Do you mean I should move it to tool folder?

Brian
