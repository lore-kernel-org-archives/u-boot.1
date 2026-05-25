Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6507ACD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA75D84879;
	Mon, 25 May 2026 17:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="An4vPZsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CCC84894; Mon, 25 May 2026 17:08:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F9684862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso11955387a12.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721684; cv=none;
 d=google.com; s=arc-20240605;
 b=MkxcwmKaecmXoipFt0kX0UqS6Ume75d5jESJRbgh2kSF1EszJ0PiuSxtSYsj+sCweP
 FO91jBAoH6W4AguSQmR4Y4Q0JvkNwmII9r3sgnlAflYUZjN7CLH4OeOKUx0muyseCcP/
 VQjJIBUbx2T0Lc0BsbuHaWvjcVFCk0Q7FrsagdbusKmP01cxN8mZtco2ekjwclJF49eL
 MIOko8mwBfUFNMBbcO2k20ewEstiIdgbecQWOTFRJniwZXR5mIyE8TX92SSJt0ThpPL0
 am998v9YNG2A0+NSEs1TXEBljjFJgyUPop+EbrXUy1Ye4BOhrceAZm9+sVsSMHukrqTS
 8Fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X63Bo+F9o8skgdLsb3MRHtCrZXd9Da4SKs6/MzKamNQ=;
 fh=E8i5n10XNmew4pFsbezk1l8PWdZuCHzZSzlRhvS0fOM=;
 b=DlrGxVbdr5G5xWugiwAgyXdvLWJkyVaT58+0crOtMzOvHFfl6a3LM5smt4Zvpo/wpd
 n0fxJfcz57M4h8PEe+cXG3tPRDaE77sXzMNoHI7111Pr8Kpo/8HT75LyPo7okYqj9De2
 Ftsr0ghLYc+Q2D1JBsMTxvUVjw8peNS3aisyYqieqFZttW5z8YnrIBBxrPKTFWQHslEo
 63EoieyZjwy/TfLnC1WyxZop7f43HsWbekZip0L9E9YeGKk7E/BLzM9xdEe5+LZ1AE0K
 wsMppDOAounYgF/N+AbDJ825h+E0Ix+yhscWdJ1fhSR2en9JpEJvb7OD57riAxx6SOcb
 D7vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721684; x=1780326484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X63Bo+F9o8skgdLsb3MRHtCrZXd9Da4SKs6/MzKamNQ=;
 b=An4vPZsbPwZvH8aGWlzdJzTOcoku1cepAtsh5JtX9y3/Rw/WsRN0RSeRW8VdRxgw5J
 +JJICbqhxacdSY2vSGTczT7VBWguMBtXhW3Mto6Q/uE7LwnXciZVsdykzK1o2XUm98Dz
 Pban4UseOmFqjQGECPXnk39PkK88kjeG1iHmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721684; x=1780326484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X63Bo+F9o8skgdLsb3MRHtCrZXd9Da4SKs6/MzKamNQ=;
 b=F3IIvw34sAd91TuPFXZ8TUv6YF2u9hvuHJr5J30W7os61tt6axW0NVOyRrAJLq1vgd
 KFJIoPnSO6sLBcury/E9pU4fg121yqHdpXurXaqwjMPcfe9/mpOcI54tiebZdrafFIPe
 sMnH401iKOhI17TVGlj+BXP+Xk05MbqErTSqU+ptjRRwVOLylG2VZ25TRS5pf+OK5QeR
 aTf4NBWX7fAD2+qFt1iq/uzcp/wPMxThhKBjGf86S9oWv1QMvZslRsicUItAGmTqht8a
 ANEGyQHoppPL91Qb5acWR19mNUxS3Hh30QZrx59bGqpjR0bkav2K9MnhsymRobmRbgqz
 e/PQ==
X-Gm-Message-State: AOJu0YwO9ZMljX5cew1G3qvmEUY6x78hreumrfRIHK7GTc7BIXa5Ex6S
 ZxFSFLwNnU218025P6pHdB5w0aXnUaBhoa3UH0qLqHsVOxeHoJaIlh+hB8T5mHi5b1k7i5qI7oZ
 HJpJKV251zUH7PbpRaZ3rCMoCrSrl8uAQ482QPxVj9Rfl/rEeaEUalQ==
X-Gm-Gg: Acq92OF5UeBbyy9Lz0f9PFJMm/2yYs7m6L77AYL1/j9A5TgDNIh0+JEf2j6FX335GUI
 twlYsSNuvE9baiTXOEL/6JVhonjCFwPDAEHxXZuWzJ2P6zSnQFkUvgQhWW8rQ+iBvoW6jhweSlv
 pgK27bglj3QW3CMXCkbEwnlLh1MAvxu1dJjGhJCPe3hJ0VN+pW6Gmo5vBx/8Jt6ivqxO90RExHT
 s/nDhFyVsm2W92hk0NVCSyXrSHpe/d4RWpeWiSf4V5CE/0Bw3DwGZFj2I2i8aGVWoSRzSFG7c9Y
 avwwWA==
X-Received: by 2002:a17:907:290f:b0:bde:72a9:ba83 with SMTP id
 a640c23a62f3a-bde72a9beaemr416040166b.29.1779721684288; Mon, 25 May 2026
 08:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
 <20260521191401.29310-2-ant.v.moryakov@gmail.com>
In-Reply-To: <20260521191401.29310-2-ant.v.moryakov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:07:52 -0600
X-Gm-Features: AVHnY4KCm-41xLWNtrJELRe9k1w2_CHnBpoEVY5g4x6pIxfVhV50TxzV8bZKKBc
Message-ID: <CAFLszThNouTnATzDrv4md5WLv7tb9MDu=J4kUBADSAJDvP3Buw@mail.gmail.com>
Subject: Re: [PATCH] tools: ifwitool: fix memory leak in ibbp_dir_add()
To: ant.v.moryakov@gmail.com
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

Hi Anton,

On 2026-05-21T19:13:59, Anton Moryakov <ant.v.moryakov@gmail.com> wrote:
> tools: ifwitool: fix memory leak in ibbp_dir_add()
>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>
> tools/ifwitool.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
>     tools: ifwitool: fix memory leak in ibbp_dir_add()
>
>     Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Please can you add a commit body? Describe which buffers leak on which
path, and how you checked (static analysis, valgrind, etc). Something
like:

   On the error path from buffer_from_file() the manifest buffer
allocated above is never released. On the success path the manifest,
ibbl and ibb buffers are copied into the destination subpart buffer by
create_subpart() but never freed.

   Free them explicitly to plug the leak.

Regards,
Simon
