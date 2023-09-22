Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F3CCD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC1886BA1;
	Fri, 22 Sep 2023 20:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XsKhpgT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D474B86B8B; Fri, 22 Sep 2023 20:29:17 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB45186B56
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d81f079fe73so2886730276.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407354; x=1696012154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDryTBfte/lOrEQAFm/6gy10EXT0nMuxjDRyH+s0hGE=;
 b=XsKhpgT9CMljCTKHzdHHl1f+yJM2O2ZWW77lHojwwiHvtkL6UXqsZVtMqYVXKvEzRe
 Q5UzNAlFfp5QdrZHikG0KKh89eSVh3mLzgwBP8e9P7SSLmN4lJyN/pxI5wNyoAl9fJBP
 zkMw8jNeFOMATMnD5oAf0pMO/Th9z5V1Sx/uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407354; x=1696012154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDryTBfte/lOrEQAFm/6gy10EXT0nMuxjDRyH+s0hGE=;
 b=tXWndAcuTLtOYa+/+ZMcOl13A5JFg8cdlmZpQqBlFcQu4U8SbeuNIsm/gHDDpl/B/I
 AFmZq2yEq9nj9vXgHQQsnNiFaXPWz3JJssHR0wCdEeRJ6LvThFUbTgIO61wLPQRX6wT3
 x38EGzHM+NncGF9sN6FXv1dIf/ukFppabF6RikQTFWT5BEQI7VF2uMzP+Wt/q+yo975z
 d29XHgLbxXDesRbHNRR48BKpqb1i7LaQghYB2KeOzyl2iRwoFR/AIVbDv1olj1mvxiQ9
 jJPqwy478Vf+BZOZ8Jh1cCwo5aOEg9ak8X5RB58ba386VHkuuiiWINZ9naNjW5EuarVO
 5gUA==
X-Gm-Message-State: AOJu0Yx/uSfiQJD/jaK5Vw+7zfrhgpgoM7mBVi35oL89wyKCAnYpVw9E
 sXp1/XGP945A1JmVf/MHhfwklTkFg8sKlY7tNhD+CsYmtUCREM5vcWY=
X-Google-Smtp-Source: AGHT+IF+3+UGc3HrTd/qGn7zgPGH3FMdCDSx0hzbztME6Zx9aCmnU9B6zya7AOnezWQA2b3kSl3qK/SWaB7McCT1Ono=
X-Received: by 2002:a25:ae18:0:b0:d0f:2038:9ca2 with SMTP id
 a24-20020a25ae18000000b00d0f20389ca2mr92066ybj.51.1695407354407; Fri, 22 Sep
 2023 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-7-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:33 -0600
Message-ID: <CAPnjgZ3r4q3b0ZHK5oJxDWKzfa1EZrtybACTrQqZXiyB+zwgOw@mail.gmail.com>
Subject: Re: [PATCH 7/9] test: bdinfo: Test bdinfo -h
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The bdinfo -h should print error message that -h is an unknown
> parameter and then command help text. Test the expected output.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/bdinfo.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
e
