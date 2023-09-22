Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010FCD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF1586538;
	Fri, 22 Sep 2023 20:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aCaSILTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3976185DFA; Fri, 22 Sep 2023 20:28:41 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2861A868D1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59f4bc88f9fso3039547b3.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407318; x=1696012118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TtZyY18yDErKOniBb/JKrDHOAG4TiHCM6xXQCEfDfko=;
 b=aCaSILTu5iPTY1zaP4FG5MXNPepFNx6/Cip+sW+4d8j07aUVtKmqgDhzPtuB4wKGe0
 tMYBNXefmZf0idueHdtftLhkDvzcTHWyqH/J54SQhSKK/B9JRhIKK9wn3P/6wc89xygC
 B5rSFH6S9MygTLIE/LBEh38GPsoP6+LZWw9jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407318; x=1696012118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtZyY18yDErKOniBb/JKrDHOAG4TiHCM6xXQCEfDfko=;
 b=W/5UOckMJdqalZv3jg9g6r8UCVwNlaHul2AqaG31q2U5ru8xrChJg8tCkTbOCYYRWr
 HOcDL0g0Srm/2qUAT65JIexLupIBl6j8Ih5rknRVlbOwPcVMAw3R9cI5grXcRp2ugG4E
 H8VbwFZRH5sSg8WTSQCOV4CkLBqeAIOAEBoBnpkS4I3Hpj4ioCMBLZu7fTti2Hv4w8YC
 thDlVhc+W0EqYa1UQRZdBx6/K8ogI77Hbu0YZTIPG4kHPdDi4bPMuxxtQo2XSLtc/Pb+
 rrHyZPh62s3DS4FGeAHhZtb7K5hRH1yXgqj0OpcIHVXYmovrb7HmcepqdRpyfdsi2X4z
 0x/Q==
X-Gm-Message-State: AOJu0Yyx/r1jSDBpJ5gP8rebmxu9gqO1VkD6ufqHjaTQo8q6f3C91bEo
 JuGl/Kji9/UbQF+xe0j2L6oo15/v9K7n1P51FHSbvA==
X-Google-Smtp-Source: AGHT+IH+/Y1UfXUO5euCgCjxsDXeWGoxjgNokfAOS0AE7h0273ogvjymo5hFY6ZV3dWLsGMCFJDR4QFMPQuhSbZvj1Y=
X-Received: by 2002:a81:8485:0:b0:592:b38:9662 with SMTP id
 u127-20020a818485000000b005920b389662mr524167ywf.22.1695407317637; Fri, 22
 Sep 2023 11:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-3-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:30 -0600
Message-ID: <CAPnjgZ1fovM2_8zpjZS255A3KNrPT4PrxtQOhvuQm9Ua+8qFWw@mail.gmail.com>
Subject: Re: [PATCH 3/9] cmd: bdinfo: Implement support for printing ethernet
 settings via bdinfo -e
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
> Add support for printing ethernet settings only via 'bdinfo -e' .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  cmd/bdinfo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
