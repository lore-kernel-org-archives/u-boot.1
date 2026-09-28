Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE88CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9211405E2;
	Mon, 28 Sep 2026 14:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHvBYKeo9s-N; Mon, 28 Sep 2026 14:59:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D70E405C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607548;
	b=sOxrG3dfWQJ0Ficd2LjWhpcGARhxCD+sf9WsS1+r1G8Sp906HMolp1Uxh1rcVGs4Z1eN
	 Q7GsiMC1c6vr5ikTrouYA6K9pfNDrI+E06FKnuikz4kURkSoQubE43WkuLgsR5vhXyZGo
	 zqGx2vvfGki2r/TdsMdjfGUjETA1b50viGFZ3nBBud3vn89LTw2W/6NU237Bry6mwjkRH
	 8WqfDsuAS4Cny7TxsnihN3Pz6dARv8VSQ113xPTPSLD97Qr2d/W19qyh7ww98Jd/QqOsY
	 lTgsRNPILL0SvR5wAbjF0g4Z3phodGhQaa4l1XC4GSq53CBoUxWLy6/Lg48ZvIoodcg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790607548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
	b=jzv+z6XiTMwEXKyI2HbToDaAk8tOARDViLrrl+5MzPmsQtissWj2BsxhcbEshlHvjlMJ
	 DWCQ6m+2v2XbGvYpStUF5znJZJULddG1CSY6A3vDVJHWncdFUK+hBvigZp5CMAxiMG772
	 NsqvdWNQq3fACpdWawRUagPYaxd5G76JO1FuXL08oUzu23ctIIosggTGvo2nWNy1xRTmr
	 nFih+d9qjhCeILkylfrKoM2CASpdVx/H94A3jA1eWeFS++yfODWyC+QmAEJUS3QiPukka
	 mc13HGOMR7W+W3L82NogoS4xHoKtFb43PS0ZIQsZTKaHck9R03rGS12uAcys/KW120A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790607548;
	bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YRmwVmjYJroF20HMNOUwTFe1j1ItvY3qa5YnPCh6+6f6IeDMpBu36lhSloe8Nlvih
	 nqpE/8jGnQcQvUm+fIUNQr3ItJWOVGn+g1cFbXp+eRZV/qsgN82nkwzu3xVqGcXXhw
	 OTbF1CHfYK/BSQU1LfhTf2d9uKhTziuqNPT0oqbESOLIkcpovTAqDvRpP1TNhLVd0T
	 HPg0yWy8ACgpkpN7C4X3/U/YTXi9AS9mWktFHPpTQ/QwcILoBBEgc6ihKSHGeyG2Pm
	 ShyW1JAFnBYjD996WyGCRzMY9I3cSM7SdudNP6nx3TAoSZJCn7LV/fopfmLFRM3BxJ
	 6oI+X4+cBKRYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D70E405C4;
	Mon, 28 Sep 2026 14:59:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 385B424E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E132401ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tV0J0zRfXFbX for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1432C40076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607546;
 b=Yx/lYfKo3Y16k5A4nsrnICXFmv6HmziNMTF7FZo4rMgDBJJR4oPrRHJVdkKWqvpGonKV
 ONkHvO8GABnxd0ACV2BFVp5rLIgCoTe83kkhe3ZeShoi93u2VWkOUUFOFvnH9Qt+IN2qy
 Dh96oSaOyGcFbv6cJ/FoF62UJJfYCG3HPwPvWh5yXPDfYuMG0bFfO+a0MJUKqUVWEpsf3
 EDslt/yMQSE8Wlix4DmLI/PpTd3Q1piU0OFQA8Eszxk2bNXfcpbPTiJO1caQKVdu5dpG8
 1ulAy1HJByf0I4dafv8vv4IUyh1A4K2EHVQuCz4pp2pb1oR0vYMhiL0osHMbZPAfIDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
 b=XJ6Qx0yvacBr35oiqJvBG2P+cIefrc+BClW3Gx49KSDHSJwBdlQAKacwHNG3EbUvMhIO
 oG0OS1s8Zq2zectuhWP1CdQKF0wf8CBDDAz5ZlUtVyGpSpjs5FfVyKABKeLyEhwbEIuXu
 Nhh9KnipSaTTDtuvhx7u6nPf6bvZYL2nUXNYT+XTyoJL2S6OHYeyg8ggdKi1ZScWWyI9i
 khFX5UzsWrPYkGcpNCiz1C0nAbFp8Fpgae2ikhzaBkdcHlC+jU2FWvqDNZQKlsoNRxlWv
 Ok1vwxPUmuHsIZHzFussjEC2zQ12pJFkshBLFBZee89WT2LJwP3kn/oHLF4830oDYZg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ai5ceFSj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ai5ceFSj
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1432C40076
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:59:04 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab062a08f5so2906978a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790607543; cv=none;
 d=google.com; s=arc-20260327;
 b=gMUBWa2LFzRj405waVGqblukc6DtOQv9DhBFFmp/BYBVh1k1739sX8iLDILlimFUE4
 TCkY5IkvI8g6pCJwnYfrpc+q462iB88r5V6jP4ktLDjK1FV+0Dp5kNM/a9vE9VRMy/pp
 GbcUiHOTgNapTdCgRbFwc213uZoC6xbVPIVtZOIwUoBz/HLpinCPqNp32Z0Kz30b28Tz
 y4enAmKRL97TQNr9nCfZU+ycZ4BEmWQ6faEsr/Tddo7KUkXiYm9e0wffCB/T/Q5UqWdx
 jSpcjqsctri5atcyVJn7tTo1unMpRdoUFh7ygci7cr6eKHdXGHVxML/KIKrERsy8TEo9
 Arjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=odGMz3TJFARJ8+GyL/qwh/zRnAUnLHXf6UktF9QUtQ2Eai8B7k80cKadyJlwSva2ZO
 pJRZK8wLF4zJJG3Mx0cQRkJMYHZs9ojirP9BRyxd+uhSKbY/nkqt6IDFOEJBL3ARyc/v
 QUVorIQ73aQKivHTfUxKItGe0lxCKTX8KXohERbBfI3ly2ZjoeA18VmCePVR4jjKQS4t
 e1LLKN+pnYg4B4ql2siD1GHtjjReeSjMXdhJV4BPNuXLdKXSyt1alRPewMFzo8F58hU6
 3tEgXdsSmcAWlpfSmQbne416DNJFsp5KntqzZ/ZfmwSPRairOjz+FIfixMllrl1I4lLH
 qdmQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790607543; x=1791212343;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
 b=ai5ceFSjYtyY02SwBkh9zz3SkOl6g2ZdiI2ftBM4j/IXdqUMzCTqAul+O3dVz4CHmO
 guhRaH1St4bq9Ei+QsNOqnInWzef016kkagFLCY8HRQTzjyu+0lhL0qIklE6CiDW7pyu
 ugRrPwm6asBk1pLEUimDd98FBkJeL+dIFo/vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607543; x=1791212343;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=izjFNCwBP3Nz8xtK9Ia+k0HOQ8g+qlop2oc2r7QcMOc=;
 b=uoAKEi1KkEWatT9M3o6hMbWBcXxCfo0TQre/NNiWXfqIPl51wSFLDpJmSGXbP1E2VL
 op6CMYaLjzz50dJ3217vWYx8SZnC7oLaCNc5+Gcmr+1ygXJ6uA96LdGQxVNxaiKz/EBO
 n4fVysUu3uCnjfK3iuZqEhOD1KR2kNFgdTXrA/xrZewd+RpmGeJ+XPvdgcqwhCePybJk
 oepwD46WSKdTQ03P9kDPvhzrvMkfevFJfDCGHiE7kd/LaQQOFSKu6TAstTe8aVHAMHW3
 YsjKFcVhhP8P1YV5Tg9VGTAd64S97MvQxyl79m0L+ljqAJTnQEwt8/egqTqnw3Dwwik0
 h/8w==
X-Gm-Message-State: AFq9FYKtebML/U8hNjtvNjk6VnNgdDIunY2jSU77gmXe201JaidfpZbn
 +mqH1doq0wyE4Ez+xOQ/uEXW/+C+EjfDsrEJ68ejbA5Mc8+hShi3rw6iKfgPIVr73l+sSF8Ixwj
 L3eWi2wLsAR7vU4St7DtjlioUrTPNXc2Ys0lZeHNj
X-Gm-Gg: AYBFou3MErE22ZAq+ws2pveNI9Z+lmL9UYqVmOzOzAoY37C53rQ4DzvL+UgupmA17MR
 999vXhQH67sepHKUA4zt3gDw0sMcRwg7XykQIKGpHxt4y77UvdHrCm8Li6Gnw3rG3fNAVW52asi
 wG3GjNk6RaH1jZrcAtaYaDDIImjySkd2fxreoHAg3aNniwZ4pU/F2wh462ECttPvo5Lig9QXS7V
 bCjiuwHYwssRUFUeuoXV0thum+1WpuiZC+yjXwqL56Nn3mzxbT/xfqYIKhZbIYs/2zVaaD0pq26
 0jbWCvWg5vDnZ05k6aVq3oY5JB8UUuAqUG7OzKen3H3RPl9GkSpRMly4hDT9VQH6
X-Received: by 2002:a05:6402:23d1:b0:6ac:8dce:5aa7 with SMTP id
 4fb4d7f45d1cf-6ac8dce6344mr1631752a12.28.1790607542630; Mon, 28 Sep 2026
 07:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
 <20260917065545.1989088-2-lorenz@sigma-star.at>
In-Reply-To: <20260917065545.1989088-2-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:58:49 -0600
X-Gm-Features: AclHuK8WckRTIZWF7upxsxY4fkf-rGzpQ-Gg_3ZE-3iWEUSzp3S_RKV8orI5SzY
Message-ID: <CAFLszTgCEmuypyz2D=qmVhwAP2-z5aR461cthj8hwY-0j5CZQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] binman: pre-load: Move signing into its own function
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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

On 2026-09-17T06:55:42, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Move signing into its own function
>
> _CreateHeader() signs twice, once for the image and once for the first
> header, with the same key and the same padding. Move the signing into a
> _sign() helper rather than repeating it.
>
> This is a preparation for signing with an OpenSSL engine, which needs a
> second implementation of _sign(). No functional change.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
> tools/binman/etype/pre_load.py | 49 ++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
