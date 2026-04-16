Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5E2F8D763
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC90684222;
	Thu, 16 Apr 2026 19:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S60AEuON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181ED83EEF; Thu, 16 Apr 2026 19:37:27 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551D084222
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba23b5bcbd5so271321966b.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361043; cv=none;
 d=google.com; s=arc-20240605;
 b=WDfjtJznSC3UKvULW1almHP1wRZzyz9sHh5xAUoNL1pNpL7n6zzkmkhRUuoR78GLW+
 au9iMf/fFBviVqXb1sh7IffPqXf7ZsYpGLqpkXlO4JGOk96sWCQ0142sAFKVVeYclH+6
 BALmvrvS0N1OHjMU1ubDQIXMoATP6+jFcGn0Kb2h4L+PfXgt4Y5XlDBwHVqIJ6pBk/rv
 ZSmSxnu40tBppjVav6vaZSu3CXvqeFebCrlL5OrnsWa1MS1u7XBBvIHukdNmqbsMRySk
 FRAt37BxgxT7xt25hKlsGhgNU1pN8DgJbEoD9HgihCOucfZce3fTJOq9eB5FlD+f94zD
 GXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9HZSGz1ltfUcgcYen5fD68YqgSX/yuh8/4LC/JZyS8E=;
 fh=G2iFFmyQ91w1x6RvycywyLjc4sE7hyScy1hT0eFmV1o=;
 b=ZclPIdjaItUVQMxsrfFtFltoibaiUbcDD6llfCOdyIx98uucQ1ENxrZp2nn2Y4NkLz
 FZ1a/F8DQH8OMF5dH4SE4J0Nq2cd0FdrjfaOmQJgqddc+cvw6mr9cpv2WJwIMQAMBFq2
 Pu0yVeYSK2ScOcgowGZuHpNZ6/DbKxQ8F8iCnApiS87q/8W7nzkaw/g46OpUAWl652rY
 sgAtnZJjD29ipI08PUkNrmkVFlkKsdAyx13ucw5RxZYCanrj5HU48So7p+sMFckDH2Wt
 9x8iRlrx6ZzJdDlfWwrx8tk8w7cRMVXyehE2pVGC27vxOAo2248okS7sKxIyvTLLfJ0h
 E1AQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776361043; x=1776965843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9HZSGz1ltfUcgcYen5fD68YqgSX/yuh8/4LC/JZyS8E=;
 b=S60AEuONqnHqswhmgVDBV7oDLTIwIhc7+Tw5yw095Y5cTGdFYCv6hzI5l/JTaL/N1B
 c1oIbPX5Mdfg5Kf1KpeLM7exHUGdk0JpxSUmKRb64Micp9iXBWVem1WkP+hNjPMM/OMA
 YjT6tPh9OZTFq6Hk9mypOXKPbZT1topUMVbxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361043; x=1776965843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HZSGz1ltfUcgcYen5fD68YqgSX/yuh8/4LC/JZyS8E=;
 b=GIV/pzllG42o6S4l26+cu0UQ4H/qymi1tOZ2H6c2FhSPdXnop8Qf0UfWFRXLeDNHw1
 7CO3pz5/Ax+7DmpQJqI0IVV19cQOIfKPpd6/eH7kUTBB0l7S4vebz5rOVq8v8prZ92Ad
 8iBxJCQgdplcrBcOeteERl6OF1zSJtv3/ZqRk2fsV2tJ6B9IwBUMRBVLHnZV04oYERiF
 amSwQn7DjqMfEV3lpsl6Qw2yFtSRZohyS+ysML4dqn8QRetZvrE+DpiVWlsYXya2QJ69
 DHxo9DQFJL5i7MM+7ylvXorEdttlBwiIYPZ2jWehoJD9P8McU7iUZ8DXJk/WXViv2/iS
 MdRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/MHhymNiDnqKEaMk+fk9S8nTze+k5sqmzN0BqL1ZxPbbW4b0WZsGkCQsV18PnyVenFMwFqng=@lists.denx.de
X-Gm-Message-State: AOJu0YyNjZcMLU+2ohN6R+4y+lFx/649P8DWhgvQtUAtVkwrQysLS/xd
 A+l65I6AqXPxRC1qvsl6G7pI4RPIwW9Ct8KxkHsOqvtbox3lhgheISUopqDo4EGcdEZ4xGoHi4t
 trdhb86tBhuHvMdUz6cl1bWt5lcwy+lL0fWF/+wfL
X-Gm-Gg: AeBDievFi4gdkZKCRVBiOtupyNVrVvCDiz6hi5LV+FOtpOo8IbOsNrmJqqy8fEWagGd
 J4CESYqVbjISFiCjefZoFBQ0ADDfiOoS3cKO6d3Cbv6vpjEEcVOfPD6CbOwIGH2yedNU0KM71uW
 3r/EqRZp45Pp3fbL/HF89Y1fNVantPcIABj5W3nMH26NjdrjQ+qWCIj50FXiGnfxERuDFrN9vLb
 5DiZmNue4XHQzUf6SXQfjlTvou/yP0p3vxrik8EG7PiYzroTjyAKPwTK/EuG5mkNj1jjtWeGf0N
 lBOzGT38SGtxJLVuYvjP9sPzqRccDyM=
X-Received: by 2002:a17:907:c281:b0:b98:1b18:782c with SMTP id
 a640c23a62f3a-ba3db88bdddmr23751066b.6.1776361042651; Thu, 16 Apr 2026
 10:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
 <20260414131558.538656-1-yan.wang@softathome.com>
 <20260414131558.538656-4-yan.wang@softathome.com>
In-Reply-To: <20260414131558.538656-4-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 05:37:03 +1200
X-Gm-Features: AQROBzBD8NfdygbPelcSxyxSPaTgFhu135EmW-4Nw7NnY1OX-TI1-QJbRpRPjsc
Message-ID: <CAFLszThms6nyZG8vGT-X6G1k=tYz-_S7btPZnth8vaqDN8oPgQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tools: binman: Test signing an encrypted FIT with
 a preload header
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

On 2026-04-14T13:15:55, Yan WANG <yan.wang@softathome.com> wrote:
> tools: binman: Test signing an encrypted FIT with a preload header
>
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/ftest.py                              | 21 ++++++++
>  .../test/security/pre_load_fit_encrypted.dts       | 63 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
