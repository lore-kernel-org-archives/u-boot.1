Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19081C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED320878CB;
	Mon,  1 Jan 2024 17:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ga7bxHFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D46D86FFD; Mon,  1 Jan 2024 17:53:18 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7C9877B0
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-781251ed685so716135985a.3
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127995; x=1704732795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5KPHKV6HwNq6FUbBosZLDf3g0fqBLbVb2Af6c4W5lo=;
 b=ga7bxHFDSnJE9ZHx4ahPJzJspqcrRtj436m1hy166ApAWFdQNOb9lPF3H31v/Ny6KF
 GDZjfGnoHNlX3RjHtTjWvxYMWh/xj80LDKpH1a38XbhIh4Ro1oKo3G5cVAhk7rhGFxsp
 dihFwj2kCm2Zyg6gHBgjFxVkjIAA15X3K8+1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127995; x=1704732795;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5KPHKV6HwNq6FUbBosZLDf3g0fqBLbVb2Af6c4W5lo=;
 b=g7vxwrs0WeLU1qfmqZTSY9TCHkEFpA3AtkplyEnE1WTKm3DChXFKLE6duvae1hjRcN
 MGiUlQwjeGctg7JvgCZKTv2kQgb0pdn17ULCKWEyatXVPdJN0WBIbIRLL4/GqPyYb5X9
 M6fVomLFVCstFg/dmL9BoIf43lQTsmYeRZ7DnIE1bCR7RhhG1NsoCZCLts1AdO+MOLhr
 1ZiNZhzVzORFWqa0I7CZEzF0oKeATyOtzIR7GSYJltXjqYQcjU8m5gaga68hBWh19wp8
 prWjqs2+3kPqSUXNu/fSC3rTyUNexGiyzWN9/rL6J+CNPfxqqaEZ5twtbtUpQhhBLnBn
 z3+g==
X-Gm-Message-State: AOJu0YxQidjh7134H6ttLMnw+HMFu54ZwQ0RRQVa7tPR0bm5Y8Uvo1SN
 gy7zbcBMJP7qI/QFvKCE2pR25ZtGVPiwZMWY8/OUU/1Kqo9N
X-Google-Smtp-Source: AGHT+IGhHB0c+YpgOYP87wI/1zp1WgmyEyBMXZci8An8b6z6Yn/bFWNGE5izW+z7Wqt/CrJ1pk91NeWrNHR6Zw29X7k=
X-Received: by 2002:ad4:4f2c:0:b0:680:810b:983c with SMTP id
 fc12-20020ad44f2c000000b00680810b983cmr7438792qvb.71.1704127994971; Mon, 01
 Jan 2024 08:53:14 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:14 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-11-raymond.mao@linaro.org>
References: <20231229174244.892818-11-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:14 -0500
X-Google-Sender-Auth: Pa_E9hkJEyf2b2pqQyWyYLyoybY
Message-ID: <CAFLszTh3WjQ6ODAfbdwceDa4Aygc9GLrXCszPEPj5ioOzMUXjA@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] bloblist: Add alignment to bloblist_new()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

Allow the alignment to be specified when creating a bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3
- Keep the flag argument to align to FW handoff spec up to commit 3592349.
Changes in v4
- Minor fix to use a full ternary operator in function bloblist_new().

 common/bloblist.c  |  5 +++--
 include/bloblist.h |  3 ++-
 test/bloblist.c    | 40 ++++++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 21 deletions(-)

Applied to u-boot-dm/next, thanks!
