Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80553C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D015587799;
	Mon, 11 Dec 2023 18:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hbwTxi1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5AB8778F; Mon, 11 Dec 2023 18:53:04 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D1687796
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db7d198e791so3624170276.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317181; x=1702921981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wsOGz6mCT+nUlBUDL2lDoXpxQCx2tBCFBX+M/U3LfQg=;
 b=hbwTxi1RjyU9Yi6eUJoOg2uur8jkBxiur2fs/J+c+1Fch1oozYnYbjUna4cdlLKfnX
 Qv5M/pw3Eyu/aqL/AqiTfd4t56jbpTLfYST82uO22ZDd3jcZ74Nk0KSnJkTWibGOS9I6
 G+GNrkyLs6mzsYHt0GiLsu8WI4DSrFEl8fOb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317181; x=1702921981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsOGz6mCT+nUlBUDL2lDoXpxQCx2tBCFBX+M/U3LfQg=;
 b=UaFpU8hEBFWxa6/cHxwsLk6HLHxFE3RozeZ7d3M9cD7KRFIuI0a8RJvmOa5TzhvYK0
 rwW+sMfT/uKZSE23FkkOuNG30vJkZI3PJsSkmFYsEOjfyKDYPRC+g+irVQ5DjEfof6dO
 g2Do+nIYns88NhEcPEpfzEgn4/oX0lDit+HRlD/dX6RLkCKP76KOuUg3AosCdArh7wEt
 YOMkE7gwx3lTQtvhJ//j3N1hwcmt9PEhWDar3xcN1o8a9pEe+5S56ygqrIZe7gwQ72H1
 pbaXXupfJNMuJmRVZtlMC8S+KluIyrv+wWb9Zi+0EwWjZ9JsE3qga7FOPAOcEvS5tiET
 TiuQ==
X-Gm-Message-State: AOJu0YxtpJf+jzbEzyBgrCrE2Kk89oSblDk6vZUZmiqX4IDKVRNLiF5J
 WLnyc1miQ4Ev6HEX/BwfbtOgNimebPjgmMFl5QL19w==
X-Google-Smtp-Source: AGHT+IHaz7UNm0d6Qw5ZmDWU0+ZBb3tvY9JFrUU6R+WbAQT/67jFWcxJ9fYnL74/JHvPcUJyzVzsC+Ryr6VgEmByh74=
X-Received: by 2002:a25:ce8a:0:b0:db5:47ee:47c4 with SMTP id
 x132-20020a25ce8a000000b00db547ee47c4mr1972703ybe.53.1702317181333; Mon, 11
 Dec 2023 09:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
 <20231209185411.8212-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231209185411.8212-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:17 -0700
Message-ID: <CAPnjgZ2MvwjNtmgty=a6M=OyFaytzvi5i5sJpUUH0X9uXz3+3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: fit: Using variable 'old_dtb' before assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de
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

On Sat, 9 Dec 2023 at 11:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> old_dtb can only be assumed initialized in the finally block
> if it is assigned a value before the try statement.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_fit.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
