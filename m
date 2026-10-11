Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC1ECA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 08:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BA6C80DB5;
	Sun, 11 Oct 2026 08:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eaoKQy6nuVVi; Sun, 11 Oct 2026 08:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8027480C0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707402;
	b=JnNkLAxqHGdctiVKONof/UxE+Mnz9q3LmZc98Ao/IT09De2jba5XdsE3WoWxTxA5tOFs
	 dYyfbsR+bWdgzLTh6Eh7NlIIqVwauDTnOVDMOzKvVK0/6PS5F76DpZdATMs6e4Q/413vI
	 CJn3HdtmrwAb++jhprrF4Ei2E89EZVIXnecOni3iskQptwX2HamQdW7NX5eCA5Y9+LueG
	 4XU4ybYAsvcrQoJEHSwIOjd3XYqa1xefrTxoqoRat1Od11XBUPz86UyuuwqvzCIf5v7ys
	 3c/IQovZMARFseK0g73RCqqKtdhCKLjrnoE7+iuDzKuVzi3Ysb4z/fs6ro24TdrXfqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791707402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
	b=AlFrSk6DYLJr+eMNMmaVL69i7Lc9KPunxraLANyEwjFKCwsAtY7ALbSev5nB91gjjoLi
	 r+PYIxnt6ktEZL0fqm2ONIXbfh6tH90AiGG9PY8egXLwX0N8oLfTwTGGSEECSABCkwKB3
	 kwuEzzQm/gNw200jV9WY9TR5TzrkJgLkvHSIIFo8zmjmsOvgTGIEIBziOm6Z2Av0v0QEC
	 BhAxxKVuSjHhZBOaUZ3u4BdmFf1gLnYhQ0RgTwNfFto1CkhNkK6sB090UJNm31449fvvf
	 vtsxAS6G4SR95lbmIglFkw8HvyXI5xXNC4q0nI24Bsv0PScXmslR6FquNR8emfPazzw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791707402;
	bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y4E1GzfiA56Bnj1BJ0ws6m67TrpBAQfJcu16E8aypuRbCIUhv51ctiSloXom7ML1Y
	 5qcEuqneGcTt8FbRuOqgYDORf+RlpfCalOsTfThfZ7HYwpEfmkFeiWNUMXK8z5Iub1
	 GoucHAe0KBulgiHdGD+zBxwrNlE7Tb5AKoLBkXBApDXTukO50BFRNeNUSnktMGc7YE
	 eZT89CVAFvhuL3jiseqr1noVh+FYbrFKC/Wexh47I3Oy2CUGqPZSC5oLDNMA8mFmPn
	 5eLzRkiT1+xTDwLIX4UVOWAyzoYfnPe1xWvlcVscS7Q7YA9ns7v9FhRxLIvsFCvOcQ
	 aC8NJhAnaW8oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8027480C0F;
	Sun, 11 Oct 2026 08:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 256FC9DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 178E1407B8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJleCRXqob_m for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 08:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1EA39406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707399;
 b=ODj/DYEOKqDgVxITPCBFEZc92r/wAsEh9lnobl/SlWUpLP78+6VbT4FXPVaQwCZM3PqD
 rxqMGWXiOcvPUrM22J8oyX8/u0muNC2YZQ02YaVb7RslPqdGOf/yqOtDW2AoqWOQo1DwJ
 CIM6HnS8sShRooALov/7dKbWCt7QFLNE1eHYRf/B7D23gLfCGedEEhqag4r7EDgoWWDhE
 CdqpioYYljgo8O1CJisKFf2bBbwRxjZ8YDax66+tABSr00pZcHomNh00D8OlsJ1dB0RqM
 4Pny8+SkwAJ6Lq8cu8iSJZo6S1G/D91Yq/brSrX40+mui1EDaR+hvHprbs4T+lGElTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791707399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
 b=CwtEeM4z3XnaXIzKbRBpBkUOehxJi9MrrVcomGS8aVuxLqL3vg+wdJPqCo52fFvo4s5g
 iqqDX3NTP7Zr28fsnubBbAE1UIujfZXRlaN5noZFHSkiw+MCTx8+hVA0AiHG5driF5+FF
 rykOTz4z/jvub9m/OoqKYZV43XAEJ/Jd968gKQ2i9ziEa9s3gpnz9+R9tzzd4DDhSmOFS
 dg/kQHP3QI44Z+7KqPUKRolphPENiGNE+GdDeThshTGkqWEv7GL5xhiWqLeoyEP+amdfb
 1kEsgy3uvW9ToGZQ7zFmmawcjY7olnnxMe3KeW0OIt3R1y36IPnLuNlaA/qRPIe2+0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lWHfSvik; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lWHfSvik
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EA39406C3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:29:58 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so842887a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 01:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791707397; cv=none;
 d=google.com; s=arc-20260327;
 b=V6ixCk8BrKVMSQlRm2cWpcB1fZwaPGK9nb1txUTFkea1xJdyTTsR4p6GS+S1Vz6M1a
 +ysUE4g3gwW5o1D/0lrFZHA+AbbGThOnpBnI+COjmJNU/iEHtGU274gIyLkVKIRTQHmu
 Db2Ak1mCFrZkYlGd6f+CuPoB6JT8iC0vnCztvt1MKuDZQwo396XNxHwIfWkv9nYWFrDp
 aSQm2/R1AxgA9Vo708png/H+uJCRyrs0ZvrY63mT+GrL2QBZlWZWAd0eGHkT9KZRbjzU
 F7lwZ7Ia/v6zdaY5FKrz+Tjslgizv9cx3PwctvPDpSIDKNbH7N7BjqUfd6cF25Vbcw4a
 djrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
 fh=PisyWqpOt3KgwGOMNTdTJHnls/W+CsMJkBK+ozL1iPw=;
 b=MlC0AwK9bUe8+Nmf7jG1vTbTPg9Pkj6oEIj9H8vXbg7NkeNSQ5F5kZL6Hr8fDHFG0A
 6jOXhfKwdkBKyyScgNmctF6PKp9cAb3zS3kbBZGBuQfAjZWT/BuuuTqlFd+1auG339Iq
 rEkx3Wiw6WwYv76WAEjSbHUQZyK9NP3sE4nGIcAIFcuOYne5amNg4CkOdAbZD5KxAcoJ
 Xi86Wk8RiKHpKVIsXkZuTfyrsvxI5B0lHkxVsgNU3eMGI8Cold173eJzMITgA0WVD8lm
 WQRprnRJNT5NAqKpPV3Noh56BuhvTqJXM4MT7+K2xv1hdC+eB5H/hxDgWy20ACfQB6ML
 XZlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791707397; x=1792312197;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
 b=lWHfSvikmIleLG8SwNwmHDMIyTF/vAlv2kcJiUBEkr0wR2jBElt2EJNx+SrhVwvULm
 TQr+rvvNOR6XI12ZNtSzKjiQU1gqLdajBHzcP11z/uw3ZNf9VjgyXhUGlXV2DD2jPOb8
 NFXZNLuZbI8/gN0q77GxbrKTBYEoAUyULaDKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791707397; x=1792312197;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ny6KWra+H6yFN7OL70GwMzx5rJ6RkoqzIzksAp3WPY8=;
 b=vDwKA7166275ROxgUImabvn2/64453uDLR6C/PAioet6idllY5q6R+BjaxYxRPgKP0
 X8wJJ5xTIU7v/2+cvhH0X/YO6iBdmAMyB7Bn+kWfaMxCiBSr5wmDoGV8hPxMIiXCQsXL
 hpPb3VmXQJ/H4t1OFFkwX4/lWgbXEWFRkZ7v3FHGNV0FSy26guoOXTc5lbBPLkO6d3Rm
 nbdbHbQV+rAKgY9LBzmjaEkTKJ/5sXKSxhITMpQ7kM/0slCpP7/f9ozDTuZ+sgsTHkIm
 ZVSQqocmPQksZhQF6TapdoMzupPRqBLZK6OAD7PqaSTclkMSxfW+vYmLEswkPWvx5Old
 qdGA==
X-Gm-Message-State: AFq9FYLnYXQuCjV/cZ9TCGOAkoC7IAXQb4SjrF+HcADsDWHTZ7jo0ooQ
 6z3+YSaO8kHx5RqUGeGZ78fSHp/RvQCG/gJo+qdA7q3EnGwPdpaRuYAalajQMj1Va8XjKywohK/
 llBrdxTIDU19gOTyBX5NJxgTJilyR6ot2cY8yaKeN
X-Gm-Gg: AYBFou00j0EIfpatUbv/DdRcDnFOs396WLSOGzCPBIpNfSU3fkI4DkvEGwkzvskWQ02
 Rjt5h8zHQ5f1w2HEjbAi9BAGUnANlAU0raQOameBFE3/wJ8xlQ3Dh4SnuTVFiViuxD7eAucoCNY
 BIwmJNgZZuURgYkn1PSocBJHyCfMnm26utCbXkPeeq7U+Xt/xKhrTMQzXqTA9cj/OhapmvEHRi2
 GRiGit0+OuI+eJ5xy9UsA8VO1NOAjgJ6/ukAj6GXaITZHJNTi6kPww/sKMqm8Ewo1Jdt/ijOLEZ
 FoPenSVspKqcG7kRoBbzZbqITfMIVNaYa+il4re5s11y2B5wyIuGtQWe
X-Received: by 2002:a05:6402:1ed5:b0:6ac:b9b5:8e7a with SMTP id
 4fb4d7f45d1cf-6b17c2527efmr5889470a12.19.1791707396815; Sun, 11 Oct 2026
 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261006110919.396293-1-prasad.kummari@amd.com>
 <20261006110919.396293-3-prasad.kummari@amd.com>
In-Reply-To: <20261006110919.396293-3-prasad.kummari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 09:29:41 +0100
X-Gm-Features: AclHuK_58j39qDXthjuUvbyOppcOwW4rlCWTNk4q-dItbzj0Bds5s69nQn4kJyU
Message-ID: <CAFLszThQKDnh9Po5zvEWNDKHYpn_WvhzQO4-+9_KCcexKqya5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rsa: reject zero-bit modulus in rsa_gen_key_prop()
To: prasad.kummari@amd.com
Cc: u-boot@lists.u-boot-project.org, git@amd.com, trini@konsulko.com, 
 sjg@chromium.org
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

On 2026-10-06T11:09:17, Prasad Kummari <prasad.kummari@amd.com> wrote:
> rsa: reject zero-bit modulus in rsa_gen_key_prop()
>
> rsa_get_n() only rejects a zero-length INTEGER, so an all-zero
> modulus (e.g. a single 0x00 byte) is accepted and leaves num_bits
> at 0 after the leading-zero-stripping loop. With num_bits == 0, n
> is allocated as a single header word, so br_i32_ninv32(n[1]) reads
> one word past the end of n, and modulus is allocated via malloc(0).
>
> Reject num_bits == 0 with -EINVAL right after stripping the leading
> zeroes, before any of the buffers sized from it are allocated.
>
> Fixes: e0d310b098b1 ("lib: rsa: generate additional parameters for public key")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>
> lib/rsa/rsa-keyprop.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
