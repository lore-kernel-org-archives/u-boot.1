Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4471C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B22940A9A;
	Thu, 10 Sep 2026 13:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4IbI2AwOq85; Thu, 10 Sep 2026 13:15:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7B77940722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789046103;
	b=h+S5o7afFjkK7XBOlhmgvzjhU9RBwg29UddH1PBntMPL+tu0Kfp7ecbQKG3Z1Swu9azX
	 zNJbgNEk2D6MBVO5XN+BfU7sVqSVpw5c/oGrIZxUQP+9dNmntpHNZN7deRLbGnJRmlZo8
	 TEBHrdDpEiBJx3XFRdlpXmFcVsXBm/fMgq3xJTF1zFsxpY+rl2bpLmx/muOzJNbosm0Ch
	 6r4KSCWFTfBd0RPuzMNHnQjD4cAGFt7oPUL/+BTopf3dvJzVUHx6m6XzeVBrLqio9nGwJ
	 i+XpkI0wE8fNvCM0dwTqB0DoGX+f6k69a+wRPFpmPTuFb5/V+VrFSd/rSb08jZ9oRiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789046103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=09cSGKnFCYlhpbqcXyRvkYjCUMvVZR3YUHka/xDjWQA=;
	b=QuRrZ/YxKTKwn3qpnxJnT8BkKChCL+4QXJrepcMeT3zg9bvYkk9sLveAUKiDrlefleCI
	 jNDGrlcABe/WUVEP9mYtS1kI8OMVf+dZDe8wwhnr3szYeEOYdqoMMuIt4/jSQ1pqGNyJf
	 0sXKj/fYBZd5W3CAtDbfvTMy7OfX0ErmaPOMjcRc8aS+riVf3kvlS0BD0l/Vnlm5H8fdC
	 XKd/0BIXi8Ydk0+/l/d/61xICcQKAql260QQ6EZvuYczF2GZB3KIQ84fI9TmZcBWXThOV
	 EkOlM8OHar7DJXQVIPNgD16sb8usHak5NUM/6RHxnM41MJSapPss4LjUvbTzZVKXz6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g5iZV1Xq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789046103;
	bh=09cSGKnFCYlhpbqcXyRvkYjCUMvVZR3YUHka/xDjWQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L/iZPmyfwnW9fEJmxnUouiDw8FeybZRqDcFj656in9A2nZASgT2bYZKh1UCveS2Ro
	 2d5fxYoHupIK9i25UXlDuEWUQF8bFsZCxSJLWvz+XBDSijOW+4prOHUL0pQr48a8rV
	 Yq735UxOvTyiOwHnNzcDp3zgws7kBEqArcaO3DMXFfBH4DM2llqq8h00uDpt4PLetz
	 +VlSrC1U0gFHuS7scQ8klbKRU2M88t4SwgTUg6+tvyX7u7f9Uo2UIpQeNFNwUKIVxt
	 eOK/4GKwBOl9+2Xth0YvmtEO+cEiOalSVabZUx+6VSk/DkKtgFYvrwnD3ALkvFCLuM
	 Zef/0h3aTxKVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B77940722;
	Thu, 10 Sep 2026 13:15:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBE1D268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1FFE40722
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cav7-CkmnSG2 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73FF840698
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789046101;
 b=AVN93txcRurPXnfmmibBpWJihmdOgc+5/Ros9d0E0rI14VgbhexNxQQCMeRQBo6vX4xi
 MfshG7C48nzUHui9+41crQCcTMhiM17EdEHONjx3PidckHA+P3hZ/JCzN8evEXrDNRSwN
 +vWCHoMEHkgZaQu7tQI5EiT9pWT6VHo2cAs/vmuhFdqjohjycARapz/6JRFdskMtj5br8
 Z+TcTtcKSGipYTW4yetqtjQ5u5jH0qkNHYq0tPbybFx0zvJPbGU3O+9mXpwSiB4poXUOv
 hv/qzAFCl8OzsEGHR0C7rV+HmkM6+mgOkgZz5gDqwNzsmLNT4YoKQgw0Xm0v+tvv8UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789046101;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=09cSGKnFCYlhpbqcXyRvkYjCUMvVZR3YUHka/xDjWQA=;
 b=tDs4f3upFqc6mHlWLjT+Ong2RpQ83vvH1mvmFYeUA1Rv+tGfH4nsShYhWmxm7OBbCE15
 /dvcCMgAs3XrqxW1HVEVx0dGGGDsvACZ/eYoJASJ3dN9HCSFCNHnTfG7f1npAOyjYZhA4
 g3iN1n3kGdmAElFrbokfozbpItlYL6Pz1I51UDKMA+bNHE2PwVC74P70lkBv/z277Snp1
 t8X3/GAhY/V6K4oFQE1bSGaLkHZQHDCWY88VkRl072+sR4qigP3Ip9Z89xMg4Yj4SZQmx
 zIspdy2P5fY//u1thn12CuREfHZcdbrZ93kyvVibLtzZShQ2ht2jkAD88YYOWwlPS7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g5iZV1Xq; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g5iZV1Xq
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73FF840698
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:14:59 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so1267053f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789046097; x=1789650897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=09cSGKnFCYlhpbqcXyRvkYjCUMvVZR3YUHka/xDjWQA=;
 b=g5iZV1XqPZicbi9dutPQ2r0NTbnFyd324QKanA1qOw5MWpW1McWfgUtbVq4CEbjdkB
 zLbGnLqJOtzv2v3UhhejJqaaPcStamantqVzHAXorv/JwYp0Gces3eYX7CLF/9yJYdX7
 dROzo1YYgvX0bhZp2XfPWiYibfyWUKdNn1uUGVKgO5QxpWFx+p4rZg6QGwi7Vu9N6cGv
 2302KJTGzLymRMEuFc2vhjKdWhi31cmaj3PJC05iF0Iw21fYTnWACeEpSOY3kpmKfyEx
 26p3XB/ZFYH6id/iQQiGoYWctFWeWk1Q42EVi4Ns2zg0alGez93YNewwVpnTSVkgHSc5
 VCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046097; x=1789650897;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09cSGKnFCYlhpbqcXyRvkYjCUMvVZR3YUHka/xDjWQA=;
 b=mA6ANrDIcygbA05W34KN+i4EzvHvhsUdz6Zyor2GfBLg5QER7QUFYSYldZVsequafc
 nPJ0/PhfIQBichCrwJQrWcmAVYp8luUUXTKXINoQvbbvGa84np4Y9zwRYj9S5MkF5thg
 saqPiLJMf9w6JPnhrlYcikT9e4j/GdQAVlBjGCkaRzWmhhbNVRRumBUqpMEx6Tz7MpcF
 8rFcZmbYVaqYE3TCIWbLpFSz8gL0KbuCaJ2/jmyc5bknvO/E6odd9BebGUNNta3WDpSc
 N0jsl6H41vfZyUCjvQRl03BOI4P0LWTLIUHY3BWM/mr2z3uLw13O8qYDE3IsrsbbBB7A
 SJew==
X-Gm-Message-State: AFuF++lsPrbOeo5gzKSSRxn5fZpJMVdQileJDZ2WotiY0QnVh40f3sqT
 r0So5xz12aD5aNp+wpkifO/h9AvBTRrK+gQAslrJu0d9SgouvE84cpO8PW/kXf7xNFGr4oiCpxK
 y2xn1
X-Gm-Gg: AYBFou0PoMAd0beRgJQQ44f1zDtGORYxYRW/vZjikK5jr0dJ8pFt/vvtH7qTUIp1BP8
 WYzC56X4Dq3z7S/WLaLfbPViVPWX16eT7auRmQnigdzQfZSf4hMeCJ7P7fBa24gNSd4mt/WTZsc
 WS9x8gEO6zVWyKMY4sMDwx8k0qReJfmfKpi8FugFok0F5q4Ui6sSHmPu/dLHnyW8rIfsTmPdzn/
 3DSda5AAdUkqbpk4iTPSFKgkUGpVDvyPSvtAFcKPRz/sc4m/TH3ug5V0iR7yFu971Eal4ViKYuQ
 lpMcCgDNpSMYe9ZbusqNWEQxJdXvBE2Qy9H78qozUxX109B7bwLqMy2JFDNxPFg5OfwO4O3F6Az
 /NwOsbGvwtRNz2FQt7z/09mlNF74FsiJxWMVXZKGzuSDbdrLAal1a8Qc073UzIaZRCtEKhmlIgN
 CETQZiSGWlkNyuXRiu7bBOgPknRXEGkr2MFOb8bd/1wzW0MrvdJKR4T695NApwn5E+SDmDrlFjB
 kuRC5sLetj8NpAdAfw=
X-Received: by 2002:a05:600c:4f8e:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49d1f22755amr223208745e9.5.1789046097419; 
 Thu, 10 Sep 2026 06:14:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fb40e1sm131152225e9.2.2026.09.10.06.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:14:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Francois Berder <fberder@outlook.fr>
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
Subject: Re: [PATCH 0/4] Apple NVMe fixes for macOS 15+ firmware / M4 support
Message-Id: <178904609637.1818032.13027647184967728015.b4-ty@b4>
Date: Thu, 10 Sep 2026 15:14:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Fri, 04 Sep 2026 21:22:38 +0200, Janne Grunau wrote:
> Hej,
> 
> this series adapts Sven's Linux nvme-apple series of the same name to
> u-boot. It fixes bugs which are worked around on M1/M2/M3 based devices
> with NVMe firmware from macOS 14.x or earlier. Starting with the NVMe
> controller firmware from macOS 15.x (required for M4 support) the
> workaround is no longer available.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme (u-boot-nvme-fixes)

[1/4] nvme: apple: Don't set a DMA direction for commands without a data transfer
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme/-/commit/f31c5646ccac279d11e128b8c42e968847eb7df2
[2/4] nvme: apple: Never set the opcode in the NVMMU TCB
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme/-/commit/bf7661a63cb9f2804cc8851f60686a490355a193
[3/4] nvme: apple: Add WARN_ON_ONCE for non page-aligned admin queue buffers
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme/-/commit/b63d271ae7c034033a06e771e06d5a72cd41269d
[4/4] nvme: apple: Drop the PRP null check chicken bit
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme/-/commit/b3f756587082dac42a828ed74b58f64ac4f336e5

-- 
Neil

