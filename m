Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CFACA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 18:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A29340BE4;
	Thu,  1 Oct 2026 18:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4v2HtYt28xeq; Thu,  1 Oct 2026 18:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D885C40BEC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790877948;
	b=q13VR8l6UHmAMxNQQztuvkIuOs/Ise4+KyY/dVSz8zgGqrOja5mHxx/CwUZujXgcPA/k
	 Og/xfSukMvrRn2uXuyNlnlHGcTu4WV2pbaLLHX6ckRNm7N+2Vwh9qqiWsm+vo4ebn+Xx4
	 vnnzBwDXMrlOOKq2RdlCOSavBVcJzhZ+sWapMiuXB+/554kHrapdScwIV0C18sCf9UAst
	 41Jm7GmQzam4sxRA9k0YsRRhGMAQzcWY5QBmXe2xpL1CGDAqIcBQ8Rn2x1QUkqCIzEtsl
	 TDsZOxXZWiorckscENJ8B4k4gnv8F3guPTRPOC+8qQR/CT7GzgiQfLw5/c/9YVtqbwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790877948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
	b=I1kj1sHVqKDwhL66szZsNAz9+qIS4cY+DOjDFcCDPPVpZDS/op/kJ6yvkCGj1QiTLEaH
	 vvkbSp/+8TCjZ0SCtu3ukJQhQl2qUBOThwCLhQng4wMLpXy0L+Joh25vsvxPnGlIq76ne
	 j5c1yU17iGftiIQeBAwFyYtgvgUUuSorvyZBTfrmtKHjtwkC+XrJ6hcqZB0tQT/rtqE6Y
	 fRUlmvNb0i8gQme1mriZ4a3U4HmDDw7fMuoTwGpIIGAaSGNYjqq3Xjadd0WUv8arm+7GR
	 11h7H7UZ/EQBTlsT/TDcjeVe8UpnkZ04UH20uF92EYhNfwPanEUkDXk8V2WI/uqwAUQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MGezBFfX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790877948;
	bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAQHSFlse6sCnN3PztJ+cDAgaY0zfPkPyORwZe0jfq9xYspsLmXzyv091Y4WAcBzV
	 yd5N6zxzsaqbDZR1UcsqntMSMElJLhAyv7Cx3fmp/UtGMpatwUSZWU9P0K43TtsP0c
	 TS4iR+5iCv46yy7VUM/nNcfntAgeg0ojhiWkEYM/Di8No9+z8pwUe8JyTnevnXsQEl
	 KPgDXdQ4BE14WW2UR95UsH/lXVxLXVzs1z6qBdFJSpScvREeMQCNOTpbQ1VhTw2UpL
	 ox1dXfE2wb+cRGFqm3aGOVdUK+mW13+qTZeotcXSgCbEOZSqyMLa5de3T0LcNwfA9F
	 1AIII+kHekY1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D885C40BEC;
	Thu,  1 Oct 2026 18:05:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C430282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 420CA40BEC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpJMDCF6Mj2V for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 18:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 607E840BE4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790877945;
 b=U3Zk/ThHcLpcY4sap0Xidg5wTTRtwygdcU/gRinBy4JG+8z7cWcuKZJq5+IeRKBv2orr
 +ullwVfScpuOs8SxhlTIyanH+mri7GAtB5wd1pHu/cJOQimsamGrnXZJXNpYx/OA6wdqB
 xqGa76qOTCn0PG+bYCKNgJS8ACwmLSAlryIt9Ha0EfDNjh2c+ZCC0MhKOuTA5KTaOp65O
 LhuS5mKXacweOU2NkndVdySr8VXoGRSK/EIYAJJwPx9KIhYSi8wgnXAXZ7M7Autyu3lcH
 y/oxeMozY4hTZnFX6rJqVxGLj+thTPFR50ne8aaxATOhvF1w4kae646gXU/J5oe8isQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790877945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
 b=JnPouPwAi8GXqrvQuByHT6+ydNZxLJLeTfOJa/EBxFN/t11YjPIpPDe8eKqIiS5MqkHC
 SmsZcYtsGxOw6g/4Y5LCZk2DvVLfDp1NYPGwTjOeRkdb/TjpDYs7upguBjNfA6UjT3Z6a
 WLz/hGq06s6nGISuN4qbBydp3FGKK0ygZqDJaEYTuS5FyhXN8EPA71/jH9zqrtWN9s275
 lllLvb+svpJhoKosE/q8KVNzms6KZLI/PQVycA0UzontJZlQO7v4mHpGC7EQ6/bRS76oU
 BZdgIAopd3trf1vAEsD63yvnhLw8yo+75k597j7zYpkMSObIGQum17joai8NSOeUh9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MGezBFfX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MGezBFfX
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 607E840BE4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 18:05:44 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-895353e9051so68076677b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 11:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790877944; cv=none;
 d=google.com; s=arc-20260327;
 b=Z6YePS72Fyi57l8FnBRKIsWE47GgM1UzFY/PieGyCDYaU1fKO35mtD3kJt0nI8WuGH
 qP/l6PnEDN6EhknbzBsaafZ3O6SELsVpjzZGnARhxJ82zLgiWGtfaSiI7p5xzcFB/9O/
 Wvmfc3toluXSTb5Y1+NrfFd1AZ25RzRMrzC0tYzISo7pJ2Z5WNXeX5io0KUqL0EDOzwJ
 gxLCi3SvhwMLb59MtLMgLO29e8QLA6fobmhGJFrHW7B1hWHJdgwvIWDENgvUovZI3s+e
 zS7eNE0AY0wD4X6L3LLb86HdXN3bQRKcDFNTrfwZ/kSzSWQHGeOM6RVNZwLoLPO0BOga
 NRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
 fh=SAaPAFZX4WKlKd/mCetnRE/KSbe1e0xp/fK3yEItU3g=;
 b=q/Tv0xdzpQAYhPi7UjwW+5qDoIP7shiytksYJatYTmQnvDX3gAn7z0S08y+3wfbfq+
 bYA2d4QONoY+/96HbQouwkbSJ1/zsz1jpymQhHcamZt5VcnINtqki7MDU7XUezFvKVYc
 0G+F5C5cJst1DE3pEPYVfb2LyCp4pKJl4Ce/xXG4x0xPnb81vb8dDEHhDRYlAdZXoGiM
 qx8UtId8Or9+InVJJ4rflA+UAL/vYNtFVEy8yQRFA9zCBByKJVyal0hVNEBGJiHU9bMu
 EZm3yTjdhXEpMshuuZGdVEF99LsRNR8EFdq9sG9vDPb5xAOqPBVVD2eNKwRpX1men56u
 tPag==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790877944; x=1791482744;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
 b=MGezBFfXW/tywQDHqC+HxBp0NTrzBsUIupr1HBriXOR/818lf23tgxv86i+udgrPOU
 LAt+e5ieIYN0uOVPU/mJd8MVfRO5Z250XvnVwP3YPd5UMQ8L/EkXv3OQ4RinQ4Ey1V6P
 AR0uk4kToGbooi1aTUrmfiVQr4HI4MI95J2jfXE/SkPgyxNsPfNXGSTcG4yE3+mfzMyi
 R8RZEByuzjjKf2zMdg0JD9zNXjWW1RPEa4OHuRypJppWSknMemJIsov3LASo7SCYQcJk
 88Z+DJPWvve9nE5JhWvQ8pwsMSo9CnM++udeL49eGxVWkEucvQas1WkXS1w1ljt4UL43
 0eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877944; x=1791482744;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IsgHghsPdGYLjRfxbXg3RBl+HKF2KJYCjS8S30Fapjc=;
 b=g82/j1VAxWaxVVyXSz7py3LSTaG5VxlZ2QFlJI8J6i1bxh3S5OUFgmn39JlrQD9hJJ
 U4Yj6T+x5YYEgH6DMZ3sCYkUFSqOKFFyH9QbSVjNNk78ynT11ELO5x3NDytVhAhfBa5P
 /sslon1H3JSloYbR7PqoAv+du0L/zoYyL1bZd1rmgzbtL9wGhCF53iRqFMEsa354rhLO
 uG3K9/fypsyDjb1hd2EPbJfkh7r0CRPqPQ1lw5L0DxqtrOha4p9CqPcD0C076og1d8JK
 wa7KBvLn1jdK78WPpStI8FvEt/1ou5Cd0blgwsTsfBY5fB1/MgiDMAW6tuD42SGmwhYE
 7vdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByo94MT2B73yOQ5Q67kackBNyNLWms0155KaU4tWwu/BHZVyuSD9iqWPyGAMH/5ocR4zA1LULU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLyr1Af7Em59LulpqMFlt4M7lqRCBS3BpW1sbPB+uF4pQhLSCAM
 5ecnhzS3hfIXhLiNpJWlPTZ8e3kMzACye9aKx4SffrmkOXql4vxOUNQmECinG9FWRSFnHWJjSZG
 6OPr3vg+slj9YneQb+H5SPTyD3294yONxdjAOmt3I+UafUUVekxfgxF4=
X-Gm-Gg: AYBFou0/vIX4h2gx1+YkawDonXUb6UFEhdQuPyMwP0fwLebURM4x4IsHiZC90XIubBA
 bV1F4/ZIcza3EbfBA6B7tB/RrY+bzJsrKg9kPiv+RpPt9Nqjb63zV4Z2jWzVNnl/dadEhvfT4B3
 Ac5lP0cI4IRWpmHpSncxlhDjU9lKEoCzWU3xN1kJrtTBx/VJ0EFxSoippXpcaGrn6w9ABIr25Ls
 hTjxN8oQotDMNtef2MGk3+qwzZpsw7XJ4vNdjz9SKUWV8KtNNX4GGVVEeF9K/Ps3rbPzr2uLqj+
 bOwSoNLauhVIhSvxMTUwAPh5q5Q0yvFb9XUFRciYp8EGXrJ0HkQXsYuQDzb74uzDmqeTF3Al//3
 FWRByY2lbNYtqIVcZdgYvNEcTvWwBReef8SdNoK/K7OxxtDHlTq1nKRuGQvjusQvEUUtsTlnKSU
 yj+o5wlUOn6sjkwqQCMiXAcuMm+MCRdo9RS1zYT+krUslya4EDqPJc3Iw8CIIyDNRX2PJ3ArQFl
 jzvDWlykRTDo4Wu88hRhpZf5FLuZBMkOGpwCLKwXFFmNBdrhIMvsNrzB5n4QWKymdPrtYIdimk5
 /6THgOQyNhNIJx1lCyYx36YdiKZStjZXSuaYXnbBH0RmFw7zfLwiLYK8GZalg5QQxoLw5QedsNO
 4VuM4S1rIUoAjZziqva8q4cUZeba2S0vvccvn3ypLDTPUReC90hAiVA==
X-Received: by 2002:a05:690c:e21a:20b0:8ab:3960:65af with SMTP id
 00721157ae682-8ae3a7ea362mr257917b3.56.1790877943394; Thu, 01 Oct 2026
 11:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
 <20261001172745.GO858934@bill-the-cat>
In-Reply-To: <20261001172745.GO858934@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Oct 2026 21:05:07 +0300
X-Gm-Features: AclHuK-6ycLI0PhGMzYM5haYqPzU10rp-hnrdubcbd6AZTh5W9CvVDGb-XOPiIo
Message-ID: <CAC_iWjLZahHaYeuCgFr7bXbAv=TKLBk2-_=E_RPoBK0oOSN9Og@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, michael.haener@siemens.com, 
 u-boot@lists.u-boot-project.org
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

Hi Tom

On Thu, 1 Oct 2026 at 20:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 01, 2026 at 05:03:31PM +0100, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > Any reason why we can't add this directly to the uclass probe instead?
> > > According to our docs, the probe is supposed to 'make a device ready
> > > for use'.
> >
> > IIRC we talked about that a few years ago. Probing a device is
> > supposed to get ready for using the hardware, so we typically have a
> > separate operation to actually talk to it and get it into a particular
> > state - otherwise just probing the device would take quite a while (it
> > also means that TPM cannot be used for certain things after init()
> > unless the board is reset!). The same approach is used by the
> > keyboard, for example.
> >
> > But given that this keeps coming up, we could perhaps provide DM
> > support for this sort of thing - it's not obvious the best way to do
> > it in a generic way, though. We could have a DM flag and perhaps send
> > an event that the TPM uclass picks up on?
>
> I'll let Ilias weigh in here, but I feel like maybe we've just been
> treating TPM wrong and it should just be on-probe.

I can buy into the argument: 'The TPM self test is slow and i might
want to skip it'. However, I don't see why people who care about boot
speed and not the TPM and don't want the extra security layer don't
just disable it from the DT. Probing it at the uclass or an event or a
cmd makes no difference, it just complicates our code. If anyone has a
use case in mind that I am missing please shout.

Cheers
/Ilias

>
> --
> Tom
