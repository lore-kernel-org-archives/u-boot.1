Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE3CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C576F84949;
	Thu, 25 Jun 2026 10:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QJ74uPSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944FA8494B; Thu, 25 Jun 2026 10:04:06 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64AF8493F
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec3ffb95dbso369003966b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374644; cv=none;
 d=google.com; s=arc-20260327;
 b=GBCmr3v9qy3ErLiJ7psuuerxOEJa7MCTBnww1sQ4uJd0SKge4BKD9PiZjWinB2fApe
 fBQVU2/V+nOLltjrvgU+tesFLDqQYmEqEmi7icqX+zQmlGKLR5goeRefOXUD1MO3YU6V
 Qsl73SqTue5nw61u5MRKXlzRVAifpzjXrae0JLVuCB5JiVLD3WhB7nqIaQHIFlIRj3Cn
 ybEMyMc7n+OTDVhkS2VKLl4jnUFuiA6Oa7fCA6Y/171QWU4MnsFh+Ur/+SKj8I2CGFA1
 KKoX/qX7N85maR+EkZyc26EWsSaTq9AKkBOPvnwcdk+KzbyPdkxjwZoDiuYb355NtCxS
 pjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FjTX7yCZQRYR9cKkuJgDUNz+c0rclUyecAxw0cz1ego=;
 fh=RMotW0d5XlV4ufFtnrZdzQ0yk4gZppNtVCUWCpNgShU=;
 b=offJCLR1iurhgg5uuuUyogrYq1N0yqPKXaAKs/WaK5H1jW3XRiFTFMmmX9/Vm6if3f
 /bK7UqPeqMhPM+qGNQVcuY4VlAZSjesfKTnLqV2v3sPA29V6CABvZBx2kHwA25lFUIxm
 FTsgVfXb+kOrHPW+yjI10ufVVq74B6cZD58Oj9XYj6A9GLIm3/DEpvALpGAPpmGcrLU1
 ePn2nAEdFzP8p9AeBxYfoXlASs0h9jZbkn8zL3KA6k8z69pnWeNTxsrIj8OFUcPTmdV2
 ntfVHjKJnG6sjihfJIeIWUPpZOP/9zJlIEmdE8jTbFla5enAYFo0KPTZguxl1AcUJzai
 w2jw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782374644; x=1782979444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FjTX7yCZQRYR9cKkuJgDUNz+c0rclUyecAxw0cz1ego=;
 b=QJ74uPSOrWwXFdbOtp9lGo3ZrliCifW5CpoGMFkNBo8VXWa7rdzO1TIXISqLh5WtGm
 UhLDqf5mb3FmxxLyDgW+P9pgzBV7pF54saoGzr4i9vOoORaRFBxmSHYyZofxHisQ7Yba
 /d6r9RhMQbLD1NikZ0P66ATNYR6P6LgAH6RLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374644; x=1782979444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjTX7yCZQRYR9cKkuJgDUNz+c0rclUyecAxw0cz1ego=;
 b=eNyL4ylSctneVzTYLs2bMIRC7af/2Qwmf9Ppb0P2PTuqAA5WLlP5HD3/izgnKNDYb+
 GbYH8mrS1DBjSdgwUSQXjxYrkmkX2lCPG84li/HvZjsmNz6E/gUZiZX8lZcJVo7FGVEM
 oJ7ujdE04XQGYKw5MnBBGLSvBBour09/NWXsLVMVXSsuyMbZDhIZaK5IcRd9Eq1WfTaJ
 hBogc9dNaw0hPKioAo6aC3xkT8RQHp9nYrTLKzZgpWRt3SGaC1ueZxcVer7Kt28pCehN
 9ekc3KrKJda1UzkthhUczEQUfB/I7U2OgSdjoumaWwJK5rvwWKPRD0hTYZ6p9hYI6vH1
 XxZA==
X-Gm-Message-State: AOJu0Yw6CgwC7nN1dg7uaEIxBRxIHPrmMl8DlggWl6OsoHIuiEiP6Oai
 MgCH2l5oBpaQ17CQZUEhQo0dRTX8HTz9LVafXhxaiUDOHtT7iCQUOTk6O8pvMI54PoeXiAMk4G7
 uXemHDED9VNcZ5z459rQilZMkTWo4zumEGCJvg1Pw
X-Gm-Gg: AfdE7cnc32KsZ6WJCq1OnkQMEn5cQGGMHi4OF54+FJpTSB3bdx2kDCR3F1fdws86Svj
 SD/HBLpnFOTkPJU+BwXex3izpznrqm5P5Hkp5ak9RAJZrNFvBoTfEG7KgEMq0LjZ6ytXIWE87Gk
 GUZ7YIJ1aN14DKAa2IK1Wjiyn4ywTWCcCU48y/Mles7xb8bGOrEnv9SK9jujAwNLPpRiBKIoyoS
 EpnomnwGHo1zyFQPRNSWW5NDLtmbzKs2BIA3JpTZsHQvwEcVQIbU0m7eTmeLO02WpJCh/1Ipw==
X-Received: by 2002:a17:907:3f88:b0:c10:d41c:e540 with SMTP id
 a640c23a62f3a-c1205e3bf79mr81061566b.11.1782374643560; Thu, 25 Jun 2026
 01:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260618154750.180675-3-aristo.chen@canonical.com>
In-Reply-To: <20260618154750.180675-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:03:50 +0100
X-Gm-Features: AVVi8CcmYrtAUNPm2aMmizHIi4sSifCheUGOn_39oLB5EFRdhe1KgoSr9MCidXY
Message-ID: <CAFLszTgiYQLugJ4Qm6ATwF3YyznsRzFhwNqgcXajNyFrSE740A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] test: spl: check load_simple_fit() rejects an
 oversized data-size
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-06-18T15:47:45, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: spl: check load_simple_fit() rejects an oversized data-size
>
> Add a regression test that builds a FIT with external data, inflates
> the data-size property far beyond the image and any plausible load
> region, and confirms that spl_load_simple_fit() returns -EFBIG instead
> of reading the declared size off the device. Without the bounds check
> in load_simple_fit() this test overruns memory and crashes; with it the
> load is rejected cleanly.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/image/spl_load.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
