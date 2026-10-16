Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5985CCF2C6
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88FD7814FE;
	Fri, 16 Oct 2026 21:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eFusPWF1axE; Fri, 16 Oct 2026 21:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD56081544
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187236;
	b=Ur4aXcJwK86IDhDrlDJA7/aSGsMg7kgYYWw8faMvR6LIq4aqwnBAnIuk1TwEaxIrxpum
	 UyZNNVsj7U2H/fRTcfhbhtpGI6Eti7FKeBkWt5DoNKQh6NRwCJUfifxQWT3CtRWSIWSEq
	 abYvwhckg2TxygiTfm+/+7STTBNoxpbr6Qvev77iRq+DHyV62tgzFHj2pG5MNpm0tqsMi
	 GG7l135DjE2BvbLQVf6dYgF+UIw0a30wws6VRxHjuUX76L5qKI+52yW1hr9QutthMzjpP
	 RgusaOrMY1dC8O+4EOQanW7O7aIXism3klK8xt7amC2mEsw3qSGT7kaGZrxqUR57FhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792187236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
	b=YswhS7OLIStDysuoON4Ua5lNb7LmqO2ENB2RyQ/myYOZ1qLTsfgdJOV5gPJAsoUip5C2
	 etkmQtbTGWXxARDr3tAmZLC6bowP6xqar0HYQyLf0np4S5WYzcLVQl+p0azhhP5UUFZy5
	 roprFIExIJ6762wuVuGLsYJQ9l073wJn25jcqSQG8mLTQ6p6zzXliNOqEpTFB5UBXfFOk
	 7+/zUAm/s264Wg5ilpZa1B2ttWsPI3F0Ekk8ZJaTbqeCQ2h1D37TYebVr15JyaaccXduk
	 ml2HZpNqqeratv4DribYqmIVDBvbBQ2n+/xh6kaMPmHhaL6H2GYzEGS+Pvn6ZyOO2rw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IAURiCor;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792187236;
	bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hj92XzCyxdiSO5RFWk1NLmvohI6K10A5iYzK/0dZsMFtfpwpXTP3Q/sredKZXfq+i
	 8JpT5vMUJoIJPb4mZoKxQzeTWeWuZToVhJdmE9OvOXhJGc2uf7lh/b8D+7k9skKz0R
	 4+Ll2BzrAz2IWQps6sQs5tWqPBGVhWViT1bxJr7XpQj2b81Woe12HenzScflDd+xZW
	 grkeXoUm0MSY+9x7qMBaM2dEdDgSodAL84fD6kSwLo92iVosnZOdoJDTfPARPaW2ys
	 ykLz3Vaketl0ISKYXtBGB7Y6bAN3gAvlLTOT/KSu7X8/klxdfZVeqCsnKL2ivehe4a
	 51nNnYjKwtlxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD56081544;
	Fri, 16 Oct 2026 21:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62B9879D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 492DE81544
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVqkZipckQUP for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 460CC814FE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187232;
 b=Y6e3rZQujzTu27waypRifc2cf8Irj4SVo2K/++IHA6jLjFit2u6CoHnp352uGL84C48Z
 LoC1ghoyKZeqsxpEe/S6o/uIfkIAxGCkVTbnKZJIAo2tQ+BEhPaHEKbqr2rObr92wgnnq
 yps7AtpdxouJld98QJtZLchGTgnQL+atvFd5y3YeGpVp79gweP8Of9FJi3F88hVZ2GfkW
 4zylMYv8ENu72DkrPM2eMHTgcQ3dVNa72jSTvq4NZUvqAwJ/aEd0yoxOTGN5pSuX+2AIg
 fLNlEejXQysfk8jmpphazW4ByMCWbFk0QW36aco32PVNma08s6UuYHHdtDxsflhC5+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792187232;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
 b=nTV6IglqzH7Q3XAnCKGw6Eirstzwt7BZSF1GW2zH/GTVcHCydhalYrrxtzmWQa1X8SPN
 WTfDXkth0rYkOYpwdyZKOhNZLbFEuATgiI04KWKOviFL71lYDp0iQKTGkxCDwpKZ0swjs
 8n8FWmtPCDwF/2PhLS3AaB0GH1Nys8QE2OTugSaLloZc0V3pJPjDKHaCUXkSuuMOvX3Fo
 LjKWaMu09rDYrsaAryyedYKGC6DwjXaAoS14XH6w5/vgfoevE6drBe8j17C+Bb5t1bNtb
 aNdF6/9GXx2ONWf9LdFPbQyQL2IxNfyOA1SN7oTBPtSYAJ2gHHtQZzikJJMRmlkhLYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IAURiCor; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IAURiCor
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 460CC814FE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:10 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso412189a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792187229; cv=none;
 d=google.com; s=arc-20260327;
 b=qiasnv2b+islSl37cUk71d1IVTCf0+k4APdYFhw9FlhO0S5ySrutfcHZ3xg3nPFjvu
 uDPn+8kxR94z37cfkCpjffaEI4BS23BikpJlAQUxOyED6P383Sneu46SLybG5sVL/LJm
 BZPapx5rh7UtmmbxPGHClqHb/PEQuGF8mcv4+VxAAh5L6j+i8ap1G8X4B4L2hea5zQzs
 yTBM4fCUJsIhgCVoam2cXB82H1OE9GPi7Jgb2QWWnjW5hRNYiEhXQQqOq59ZCt1C8lKl
 lg3HKbGZf0YN3bPItjjO6natQSchdrEMnRIyADNObePo1qu27bDOouvPpB1MorooU0ve
 P4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
 fh=+eJq0KF0QybjfGrvukVdIwlV0sWUoyO45/qmFlNuPR8=;
 b=me2JX1wg0oxu54eCYPweaw2bnVna6obFhKTP/pqbxmcCFnDhdf4OM3S5TIqLWaRVtq
 7bpZHIqweAwYbLsxYyYHDgmBANq/uUabBTkuAazFti7H1PJvFSbY/4YnRkE7Pd9Hl0Uq
 ZltwDkhNBgqpqb9DpEEGGIv+BT61Zn4HFFv7wh0s/O311LPDgkFSGphxSaESBMmW3p8+
 t2Ahl3hBdwmBOuc6r/tUWky+vd6LS++3pSUTTMGujaVbHiEK7rMgsDfj3NYTETPdD0nf
 v3WKlBhzWisFv/xNHGx6a+xTw+OkelJIzdNvI2+9ox0odQT+7IUT/9YH66IJ2uA86qHW
 aU2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792187229; x=1792792029;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
 b=IAURiCordp8MvONFHyP8Nxn0/PxBYfdlP5j0ikG/ig6i/H8d5Y5/aR+HXYaITDpMDl
 N8Z+OkmbF2SSoqaOqRE1GvdJPzscemFItxvj8RLzB/0BKCsXoMuM4CWklNIhXf7vUTT9
 YjdC9yabWG5dnMJDD8eH61ltuTMQmPcAM9Wvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792187229; x=1792792029;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/zdtqv/A5acFR7D7Iqk+cvV9Wp0U6jDyLBeAzi5KYjM=;
 b=LhzrLqSRfkCrCzimAcmQeYF8c501Eu4qu3Xz2vOMk0QyrEAsfkQmHLIUlHPznj0EyB
 RyeA+XHrqr3sOWTLx6RL0EYyAHDFJBypsRS9vu8k5X/8xTMO6yDJkKuU5nxjQPhvoemR
 vzBuxF0GKFeGzjGCDN3ZElHitoNhp7roB45vO6+ZZ2N5kq6TywAx6EtIgFoc6r0uK5pn
 3f9cHw46S7mb188rsgHiq3L0qGvthJipqNf7Cg73vwUz504ZI7bGuO6RWhpzFI5XP69+
 ACVL3vPz+daMboV/q8bO1jk1AKeLjZHwXTOFrFx1tgS61JWIoB4E7r9mtzgHYrca5o+E
 L+zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx60E05fYVx5TY/Mbw3UL7h85kAdAad1NtFWwsIpEMFPQfQugKZM+moV8LqH13V9ygLJG/Qwmw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJut/rxosdLOHYXMcn7kr/VzBmAcrPL6qspo/EfawpUB7TKkMEn
 NkHjuTL6RSOwRiQCOcT81NvYMrXmoVcGvjLyl9QOcQKXU3XC7Sn+kkcdd/vjBRg0+fcY5IcVs9B
 LZDYxvMcj+UTyLMY5wlc+cO5/KPeATUgLdcHAkOoS
X-Gm-Gg: AYBFou1KJLnWbORuho6O22Y+G/9iMjYZdVZsCWNNUVEGVDUFiVDtPNdjgIRkMdVL5TW
 u4OEzIK50KHUPWkxEO6SsYFM6XbX/cydoMIZ3XwJ1Xa/4srbL85/LmqnFeh8L+4vM6mZWZJRp5C
 oYqOkN+5YuPsjDcZIyp8kg8fQRenvMHzzQ1/XpqnNoLpY5EvH+P8REIKnCs+6BWDIOQZCgnuMsb
 TTB89pTjOK2iXrCQVym2ECIOXMjogGXLhpL4HFJ1gt8g/kcDNeLSYdqA2wqQkbR6QXl+6oRb0Ug
 zSbakrFXe8RYDbqlUB/Plm/KNxvXF8pdOlOIhsN3YNTJ5wuJSltYRQSsZi5BsB+b
X-Received: by 2002:a05:6402:3225:b0:6b1:ef16:1850 with SMTP id
 4fb4d7f45d1cf-6b3a8215291mr645092a12.43.1792187229012; Fri, 16 Oct 2026
 14:47:09 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 14:47:07 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 08:55:26 -0700
MIME-Version: 1.0
In-Reply-To: <20261014190631.2232208-3-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-3-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 14:47:07 -0700
X-Gm-Features: AclHuK8NTUPoJYpJ84bjMA8smUvW21A5iVfhF2j65tDc7-SmHHJieA2LMQ3qvtg
Message-ID: <CAFLszTgVf66nZAfctZNyepbT4VmD6f+aeKKqvOE3Dp_LLq2R0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc: virtio: Mention the RTC device
To: alan.tseng.cs@gmail.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
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

On 2026-10-14T19:06:28, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> doc: virtio: Mention the RTC device
>
> The list of supported device types still only named network and block
> devices. Add the entropy, 9P and RTC devices, and note that the virtio
> RTC device needs QEMU v11.1.0 or later.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
>
> doc/develop/driver-model/virtio.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
