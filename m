Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF01C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4422980F58;
	Tue, 28 Jul 2026 11:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DQwAkY7DTU4; Tue, 28 Jul 2026 11:54:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 914DC80DB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239667;
	bh=LdHDYTmkpKHE1erT/ssYbr5IGtcMzBA+wAU0WL/VyDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0tzApbV9xK1sgJXcOkh7TeMLQYr6fLpjWz2r4lioonhYBiUyhSvyJ1sExxeMeNevG
	 y9GEp8Ik7sLAxULi7H2EjYQkKioMScU6cfpwoIbdVdYb3Wg3cm/stXK8ja0dW+nvNE
	 9ZY+XExA08qBes9QKfnZTmjSN68Fj+iolozXlsYWgiJyjinu0leW9hOc2uUmxQR44h
	 aIsrHDaopJCncv0WrNWXhZhhCsA/mx+MKvTJyftunwaOmOirmHrIAWrLp+uBDfGQCN
	 ZtQSKXhwrLOfqlQD4brTQsfFBPp6x3GgnMI8Xh9gsO5m5XeZ8dhIYugC2Pm0YeeH+R
	 57zGnNHNtRvZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 914DC80DB1;
	Tue, 28 Jul 2026 11:54:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6FEA788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8AED607D5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzECoymmUPiT for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:54:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ECBE960710
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECBE960710
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECBE960710
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:54:22 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so4534523a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239661; cv=none;
 d=google.com; s=arc-20260327;
 b=OOgko5wzKK0xgJeU5SammxZ0e59GSkBChzCEb/+zqRMdwt8UxcGgTrY7haXvA8W/S9
 durekj0m0vAn7Pd3+Wo9YAv0vMGji2IpHKzpgTyHOC4CSybZAalK/osr1hfEWUEGiKtK
 tjSzn3jvlA2tsXnne7tOyPsiDNYiokIUtyALYa8rftfN+zWoI/xwLJBT+vnv5nH8vN9l
 MRA7m6y9/7+1vSeZLG1nYVgpx4YYTXSIs7owEXZR4RqhUhLxmKz5SImwIaK82+jS4thv
 aYxl6l4fGrB3ibMgpCM/otCpzYCzjxW6MShq4guJympu9gTW98X9Xo7A/uPUHW+2BAZv
 S1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LdHDYTmkpKHE1erT/ssYbr5IGtcMzBA+wAU0WL/VyDs=;
 fh=nQ9gGeks0E2bZ6YExEJCNOUNcszcWqrR9p5J9QmLags=;
 b=V6UyxXqtqYT+VspNg8j81CCKzu4JBXr7cTjF1hwjyrk0UenWtBB/BkwAoAxQjVEU5r
 i8Zc9RNQggLp3roH035MesYGUWAiI7HYiuW+n2LJXtYOMOxXyeZLUrJ6VF317S8iJ4tz
 E9rDfqidARmogcomgZ1S/aMgMd9D4Zt3Ep+JUe9kon57N2qr0u9B4ia8CoyaDVl4fbFE
 beZx0ZDGD4fSbUML0GIknxfjP6x98GsukrfXb74ducsbu2MJq5VkziMJdtGjZMh3zkr4
 qx4HLK6+vACB2BQSIAqNKvSHmzl8yZnUY3kbCcZfZHe4bzOZMqgxp7vWKvNRRydnIxht
 Xkew==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239661; x=1785844461;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LdHDYTmkpKHE1erT/ssYbr5IGtcMzBA+wAU0WL/VyDs=;
 b=ftCtVfIsnzI+vDcDwMbW5dbXySG3bwZOdWzFwvyEJWzMUBthDXL9Unw7PYVNb660fI
 9GPuXTzmA7BLHXZuzQS5tB09piDjzlvhD0lQrR6j+Chli2g6cFRfU2euGAkUl+h1Qmhb
 wmxV42CS2jShVffqCPQGkWi+hpBDQGaNv0Sfr1xagr0AC0Q2jS/UtmQIS8ql+e9Br24s
 RFzZitbiNF/a2scvR+S6IDfKVAUY6obVb+tnLaXBS8vdPdSq2Jf6v9JvFl8qwpCVZU0z
 YuDiZd+E7t2eIk13zt3LhZM/gqHwi1BSU9juBG1fnwh8HI/sfON3xaTqlE6n7m9ZTkbD
 Bg7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUtN/819LAzfEtx35s890GeieNaqI/Z5SwWf/AJYnSjo5sE5k34e+zJc62bDaQYm6GBOBBCRo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz0qQg37aRd0vAPvh5xJaMyKyNqb++rgQWFMEpsz42kQ7wPe7b3
 fHhXPB0qfoL36F/eEAxLy/HleL6aptVgg4TNjWPMcu0HwxzhxdmCklmQA14zg/y5CzbL6v+sOk2
 uzLt7FiruRguT/p993MjVIQEpan+0Aj6wRjlftzTp
X-Gm-Gg: AR+sD11smRJKzl7cNOVdkNc3nkg8iL6vBUtpddZdALFu3XJIFOKKkC5hZhJY1RRhOcU
 kEmMOWKJ9xHsbl8DFguX3ZRMFywL28j/hkkmwCd0k8uJinJADIR9JpQdM+FACst5o6LlIuYAU3k
 VTK6X0H/ZEeSUVpAUGWXrKj2y730MHTNh6gZCXbcDyoxwukl2aDrgAIxHtDFBviMjOLS931AVJP
 fjBF8rYiSMy/j8nK59eJWdDkmSusLQro6rZ+seCjCYmtGCCySG9xwnG9JbIU+yUfBw3r5E=
X-Received: by 2002:a05:6402:194e:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-6a034a9e9demr1021318a12.19.1785239660880; Tue, 28 Jul 2026
 04:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
 <20260722-video-oob-fix-v1-2-d6943f687c50@byteray.co.uk>
In-Reply-To: <20260722-video-oob-fix-v1-2-d6943f687c50@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:54:06 -0600
X-Gm-Features: AUfX_myKUTXunCh2UB6hJjobvBA2Cnm7h-qVpzG2wCvbBmCY1QJFTqgGmLK2iGM
Message-ID: <CAFLszTi5aG1PZX6vrppu_v1UASjpxAUG9=NiJw0c2bcGXrHWsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: video: add regression test for RLE8 bmp overflow
To: shj <shahriyar@byteray.co.uk>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Argus <argus@byteray.co.uk>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239661; x=1785844461;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LdHDYTmkpKHE1erT/ssYbr5IGtcMzBA+wAU0WL/VyDs=;
 b=fScXOiE02TJ3eO16cf0qcZ0ZP0+5ttO/zdH6I9Hzv49o4/wSJVQu6qpxpwUZT/GKwG
 Wx1SHpHgB2OmPHz0QV22qCVDVHRmLzvcECLFJfAyMm7B7hfARbFQL778cepu/BaGjUFv
 5oegw5ypyfUIgYGFwdZf6eDm7mgEnm5I/bMcQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fScXOiE0
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-22T07:10:10, shj <shahriyar@byteray.co.uk> wrote:
> test: video: add regression test for RLE8 bmp overflow
>
> Add a DM test that displays a crafted RLE8 bitmap whose decode cursor
> is driven below the framebuffer.  Without the preceding fix
> video_bmp_display() writes out of bounds and returns success; with it
> the image is rejected with -EINVAL.
>
> Signed-off-by: shj <shahriyar@byteray.co.uk>
>
> test/dm/video.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
