Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFD6C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 768A880C95;
	Thu, 20 Aug 2026 11:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxxDFwTzAyKR; Thu, 20 Aug 2026 11:14:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787224447;
	bh=h5XnXTlin41wSh1+qcmba8S5KYs3RDaUTSz1QUPYR2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ISY98DfkPz/Dc6rFuNIp01wwbH767c9nML+vOJgkfJ5MS/ZJsUup3Wknn43xw5CYa
	 OkdkvFPVrcBpegwYiGM8BiPH/1KZudecv8gU8eSnJsQkfu8FN5M5TrZtjCON6/eD8b
	 XUWA8j2q5QL62Jy3WdJPjK8W0P5w5tevVpqoFEYELDc/ZubcwjrZrgPUZSMNdEP41r
	 BB7aaMD6xMsYn3bjqoPQXxh/KiL/uLLec7p8yX+nkdXfuAoAp9q9tiHDKULjZpnIF9
	 4ee+NdqNl8a+r7CacEiNqAkZ4STHH0JVc7X5arYgI0p3DAgWJkxWpDYXE+fwzWicxi
	 Wv7VbmXaIM2JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B127780C9F;
	Thu, 20 Aug 2026 11:14:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EB4A1460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6540D40558
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IYqxxOGXVl7 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:14:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AruMDdob
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04FC3402EA
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:14:03 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so360866066b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224442; cv=none;
 d=google.com; s=arc-20260327;
 b=N50C38U1zP7RVmEAt5OTjfLYivYo/bfWOpkl9V/nX4ILuzi4ta4KmA4SLKjLyBSOat
 eaINlxG27oxvyetLWvj8bZHtrzGMXERScjD+JwS6rtNPm37U0HvYINAamlRN0EIJQssW
 ovO1lAIwnZcW+svTHesNGA1Tii/GT/iFteM/9luKM3hl3JLrNzo3n8WqrIKfb8KAY2n1
 FiNK7m9fH52yVLxTssll6K6MIQbhyeares102JtsFu3PGNKdRpHvuMzJco9+fg5etxfU
 HOZMpY+6jQ7jbmPCfgX1savgmZeUUjOA1aUqmDDGHyT6k8Q+JVkgMR9VsoHSqaCB+lfN
 K6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h5XnXTlin41wSh1+qcmba8S5KYs3RDaUTSz1QUPYR2Q=;
 fh=qAhl89FyieLOy2FMyxlKQGb3htvgrYTVxaeq/HEP604=;
 b=IDbMhpkcEUhiFH28XsfYKnnZxIpafejJXsrHiLZJRKP8Gc2iFV3xg76MtMPM1ASi3F
 3FyCuRELv2vzSYXrr//linfH2C4qgEUn8YYgAGvLTiz+xXdm62bjvperruFZba46ODQh
 SvlPkbA2u/cd0dS5HEP9WN/BKMuJbsFZGgr0SKOE3W8ihG94jh1gsIXHhyUNplAWnMgI
 Jgc8ZTj+njaS5mfOyLdIkkkPipTx+5tHI2Hof0jsZHV1X+ay3sHrUKTgtc8V+pnX5/o6
 MUaKXdWYmMlhAo2bLQNMg1/PTXf+HglpQ66j12llgw2X6vG8Mjk78nMt16dyVuO0EA8b
 Z6hA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787224442; x=1787829242;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h5XnXTlin41wSh1+qcmba8S5KYs3RDaUTSz1QUPYR2Q=;
 b=AruMDdobjZXU36ES/8h7CPFYxs2jGl04dJdZSJH5VOi77uhpNYvlV3b0npl9iwP66h
 BIPcDsK1LuHpkI7umoWv50KuginPLN0JdmPGIjQVQJU601La0/KikLmX4fkktcWtftD4
 g4abwhqs5RxM2nV7T5ko43IwiW3/EgWcbgNrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224442; x=1787829242;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h5XnXTlin41wSh1+qcmba8S5KYs3RDaUTSz1QUPYR2Q=;
 b=iPgoy8J0fNuPvSdzXx4rhDk5C0NRLXdbbOksTpFzBnFAA3WRKaUPRbxImUKFZ8w/0c
 WFP4SvEG2DtEE72KnIBCi2YATYdLYiDvQNaKDhMWD4A0gPQ3hC3XhfenEmSVci8ighLQ
 2+LTEpu2T+b86MjcZamV+FvLAqDbR4yegDUKf8FFZ/Nh0XGTk5mbxR54BZzhxt9eEOks
 MjQiozcLlae0s5u+aSDyeJR+8JxkMjU8/zWZH/3kl9vPzdWML5/o9a+Cr5elj8A/PxAa
 DQK1OAffSTfVU8C/ajwqv/B6hnQPQqkrXN9OlaGBEQwwkrgXDf6CuF9hIn2luGiThfSS
 7RGA==
X-Gm-Message-State: AOJu0YxVzLNQni7Eoc296vzyAIu1gmYXtUSciN7W6Ae6mJqZSeDEP0iU
 57Y31Cvuy5f2K0OUcWmjDc81RE1pAXCoX7JvLHB/aSdBz3ftzXF7qwExsn/mXoZKs4tlOQGBFpf
 IYxiLHJKS0P0Dee3ZNV1D1KpyqkYHqcnJrPRzGy5AYnTcqfyGG8A=
X-Gm-Gg: AR+sD12io78Gwr5UWzla8BcGBFyqVAsFBmGvcegqIaNy9dSFTx0P+BjvJbZyYyqHWBd
 fT74qc7q5Mk0l7SnMMoZ1oRLxP9Rq0iUOpxCSlqkD+peN0OY2mgasp1NFuv4CLfmcoxN5USTylx
 q+y8Xy8tW4DB3HaeWoUgc6kxSs0Fj5adAOpuOmOtqJoJ0D8vUKMT41pZ2Ap2bA5BFw8SDcbCz0J
 A0yLLVvnoXSg60IrzBUkVfF2OyQsSHuPwhP4K6FKLavF+q14cfHd42Fh+gJEQRo0YKKFBh+xM6W
 Td5xOpMzQx14wxzwjzsiDnjv9zoJlR7Xh+da5TcNdn0=
X-Received: by 2002:a17:907:a892:b0:c1c:5c90:1bb0 with SMTP id
 a640c23a62f3a-c23f92d6210mr745983866b.8.1787224441667; Thu, 20 Aug 2026
 04:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260729083826.2277173-1-dmukhin@ford.com>
 <aoS68ZxFH2Oh+OyL@kraken>
In-Reply-To: <aoS68ZxFH2Oh+OyL@kraken>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:13:46 -0600
X-Gm-Features: AcwNN1UqAsB0cyKKS6hwEOoN2rpcZLRkE2aG-VQA9MyHFYqmHIcqXgLF53ZuBiY
Message-ID: <CAFLszTi06pNKU+N+Uab23xC+KWLPOXS6xMBtXWoh_UWwNnZe7w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] reset: small cleanups for x86
To: dmukhin@ford.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Denis,

On Tue, 18 Aug 2026 at 14:05, <dmukhin@ford.com> wrote:
>
> On Wed, Jul 29, 2026 at 01:38:24AM -0700, Denis Mukhin via U-Boot wrote:
> > This is small cleanup series for x86 reset device driver.
> >
> > Patch 1 introduces a small fixup for the x86 reset driver.
> > Patch 2 introduces a small fixup for the x86 EFI reset driver.
> >
> > Denis Mukhin (2):
> >   reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
> >   reset: x86: Use cpu_hlt() in efi_reset_system()
> >
> >  drivers/sysreset/sysreset_x86.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Just following up on that mini-cleanup series.
>
> This is re-submission of the reviewed patches originally posted here:
>
>   https://lore.kernel.org/u-boot/20260603070743.1268544-5-dmukhin@ford.com/
>   https://lore.kernel.org/u-boot/20260603070743.1268544-6-dmukhin@ford.com/

Yes, I have reviewed these.

Regards,
Simon
