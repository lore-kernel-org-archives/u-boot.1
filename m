Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D300CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3C3F40613;
	Mon, 28 Sep 2026 14:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48EnN_plU9o9; Mon, 28 Sep 2026 14:39:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ED26440621
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606393;
	b=FMynENCmXohoiYzGh6IdxbAluSOhB8wSy5Wmsh6wQKHViWfPhoJ7b1ZO4+xtH3pMoi2S
	 rY4klMeaxOKjftGty7+EPO6eTY7Tyz24VkdpQuBkcqNIOv7bmhDzAaNIKkwGuLpCSiItR
	 rwUn6eN4ssI6OEiMdfkXyf8f3kGUwBcp2csHH/CqP86DpMq9sXmj7kLMdqCbGLwBWqTRd
	 +ArHXQMTcwFEvL4iwzVCTSNpVV5Ri7AjQRERPikS4hdog6ZQmNPId52DX3exQSOiOXWdd
	 DdjEavyco9U5HifaXIG49G53XjBQ1+YOq1JfgrxtbeckyOlYFotCQVSqV5osKxXyarQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
	b=oH8tedI+JBH+5OIrQB5SLw5nhgOiMiG4Apr/WksxH1spgVGeltrRYM3j9oTl4XFcZaE6
	 45VzG75wbpsTD420GUNalbr45uYrW833bSmemT08GA6Pu1UTWrBUmVBV/qEBsgMajtn9J
	 Hivqz5+PnPNaL15HfN8PsblDTW745g2zXSeTWZgH1kZ2q7rbY6mUB4W5Cdr2CkstNCEse
	 NE6C69V13Wae72l0XMDiTTHPHwX4KLh7SGwwRt6JXe+bYTsrAes2XfWbGIDGgx68B+s+w
	 YTP5DgWesUmypQNFZ/eU13Y0wXYKRVYkb3GfoahZJWzvBB/8P38fQXCJuFwUXkWRe0Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606393;
	bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W5c9eRaCTJt5wIBR+vew2/FkZ56Ss+mleqvLVq8HVZLRUWjX/XOTj4efEBMGTH31L
	 2LojWV6Isz/SweXBX+z+yXhczjWv+VBjeJ5g+ZXLpLSaJ/O60/KMkf96ldJW0tqTOl
	 ZJyiPMFB27j1C8zDr6y2fc8fiRBn4xyfqKYLmXACjPYUxeQb0SMZYxBnZQrXt6M+hF
	 AuyKwS3X8qSn8HW3TN9mELgIJFc6lbCpzuI+4LdN9YM1R8I4cnDSYj75bxZNdseBde
	 8yxQ6Z6pDDbiLj4mztBLOe/GsZjCJJd6N7LCf+EPovm8xnMTCKJZXaLB+5G3oAbVth
	 raLCxaZlMwZHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED26440621;
	Mon, 28 Sep 2026 14:39:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 714AB3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62F4E606AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6QvVoQ0_MYQ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:39:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D4F960631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606391;
 b=sttCUaWBYR25mnGhgxlInLWPrRMRYYpBU0PF6QDa6tbo+0iA/zr/s5ZNTo5qgUdu9mcq
 btgn+Rjnoya2/CrzsfyRyvJ3D6sqCrNLDmH2/haqGkCJVFMrpr+8RXGOVkuNhK1BLB1NW
 V8hh85MsE2Ze+TXBOThO5A7d/gc9L41e1p1NuYNGUS+OPPQtoxtjnW+gfbXhcXQjr6Mxa
 YQv1T2NSHT7GWv5/3bXE8Ts8agQNyjpayUXrvS6w0EDa6JYnwZbWic1U5JnCWEo9g6c9y
 0f+XmG8J4tCGdOhClqe+re5/rmsVyKbknAMZjUu0Qh1BdezM1QuaDI7AfzhVEZdKmhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
 b=q/2FDAXWu/iyda+ViMj7+A30KXFbXVYUu193WPlEqM8/mw7FTnumPI6QvE1kTd7ZGf6f
 hmg45JPNV/b8RN5jamjbPsg97vQiwbgdcToxvE20lto38p+ho0fEv6zrKBgJGqVLq68VP
 SgqqidPneBC0i0KHfh/Y7NTAU0kOenqjDHSJJKRma/xYGA0JI01I3WVUO5IpqTKPlNe+I
 cSKzCK2dHEQCKwULTMZFDi9l+/6Wj+nzK1zuY5K8Zsft4SbkDrLJefWv0P+bmcQi14xKi
 bNeO2ksXhzyBU/LGVLnULb1UHKIcqMscPVNNi0onfAkGXub2Z3zhDiZFVrjBU55v8KQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m8tCO7To; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m8tCO7To
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D4F960631
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:39:51 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so5035367a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606389; cv=none;
 d=google.com; s=arc-20260327;
 b=kkLBvLqz6bOKKqCPs/nC3sFY7SDOwlRuLAOJBFfKi32mRcKqcNTfYEMT4XWCEioBA0
 PTkxIBzCA/oiVnQ2caOiBbGU0I4rLzS2O+EqJZoVH3f/ukNsc3IzgaxQk3xzBPDZrvFg
 SOZJazIzPzSca72d9MpJBiaHUuxlKW9c6hYLEE3IHcg7yk0qhpttCstnUqcR++eMrm9H
 gLh8jIKFVP+AmUZoHWpurkZv6gWUedMjB67J8hjICZzIG1gzbhu6ObqtTw0af3Q8NNY7
 XeLYipH+yu+ECINIAw9WJI4mZaKSIUJIQkQKKoEVLx9/sVi+DUibAFazrCNr/LyyoFxe
 DKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
 fh=QtkmEzcJ7JCKpNKBdtVrlWZQAnggxshbE+6Jib1Opbo=;
 b=E2jw4veKuCne29xIQ+QLkwmarmwv0tdULA2OCifox3mbW4GaVy4T9O6YZX+Do6XHmy
 MV10CrvOOyvds9vRvSAmTN/wOsdxAfFJtOeBHxCxjgtUmJgoi0z0nhaIsR3AdGRUU1hE
 rRjL5LiQ8lJGwNGVx5tifEv/l33WBB0oW6RAbZLrZzCqfhNPB0G8r2Zj2qN3MV3C/xiW
 k7EMns5zMrqR43fMQsftuWUO+C/u6pTmGZEKUmLUAApE7A+caR3ggYU/xeYYQJGjUf+X
 7pRqwr+Je8UctMJM5nf3BUU1PXYPo4m74mhRNatCyahXN8pQnTkvzR50GiHFkzYMcgli
 +lMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606389; x=1791211189;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
 b=m8tCO7To4WaxzGWkCfKUIOO0UgwUmNrMtkjagYxD+mrwMrpu9NGvtf9uAIkzL+SIBv
 oHcXnSipy3X4Tt58Z9pc8lA4U0xkTk4xSPGD0cDn+5bG2EGBF+syHpv9RLg1uqHkxPBz
 jGHU4YIAq8teqJ/0/GFJwJ2RlQDk2IsyOERz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606389; x=1791211189;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g5tK5PIdiaMvjG46MdW7f7bnM47Mj71M5f6uGzIzs6k=;
 b=kx2F8uPaIl6RHP/4TM/fJ8m8pmdoPzeXE12bXXA0JPd4AClG8U1eWNrzE5X6XDBDow
 ws4zfxmhV+JXw7O800MC+Y1rotWQxrbR8YuJ9J6sIMQB6YOpRK7Gxseaw9s/DGR0vTHh
 aVp2/mwzoraP2YluKUX69408KW2KgQ7YvINj2x0KKybZXDwCVmGUYzlfap5xQRD0B5xu
 +3KMS7insWfdvm32YLi3Ag6kwNmnaQvuxV0IA4jnM2vGi67+axPZm9VI7QWPW7k3qHIl
 9Y8+WTd4vQ+l2oFdn9ueJ16/2ppo2pVtBOjts078jTc/ty0E0OE3dsgadnwQKR5rWhbR
 iVGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkPJkc+c7lUiOx4jlzpyF0qakdeWYwNjDvxcfRFUfEQIb2UCOycvtGyapXedCd2nhUJI7HzCk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRyP5PsSWrnYnbPCoQh3PW/exGedqC+k6fTDsTN2o8SZxiOkUV
 IAX1/D5URNArzgh+4oYhj0IfB1PwzEw5BcEHifu/VW7bwq0PgvW0plWxtrEpYHBh/CNpnm3NJ8M
 sJpvFWOQ5DRpfaS1hpeGAOqgY83QG9n7qjVAG937yvcbhPFVWUSA=
X-Gm-Gg: AYBFou2Oeh4pK6xjjMChvWVnxJK3vse6dZW1IE7EdWfLBXrR+BYulZ0SdWmh+HLAtPb
 ZnpJi4KDkeTo7Et2TLR12qLGZ/OObYeZ/6CLcj+T6ZikJSap1AyaGr6nh8rz8U1iBQGZVYZaCtF
 gsZ4VB3koRC8+usDqj4JaQ2sAj0XXAsJxF/N0lfrQzNBFuaoR9vtRZ/FgnwB0rfUE6ZY6fEcvTo
 mZYPVXknYAc/5Y0j7NQAcsk9EZPcZtuuGCX8yUBnLTipngEAIIx7REIuHSNL1ZJgGSW7kpwkQw1
 261zp0jrohhwTefZoKEZ7Sq/Qrh0i8yF21jWqjwmIfyl+8s+NAfXZQ==
X-Received: by 2002:a05:6402:4403:b0:6ab:d416:d486 with SMTP id
 4fb4d7f45d1cf-6abd416d9f9mr4060439a12.7.1790606389256; Mon, 28 Sep 2026
 07:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
 <20260915184953.GA909517@bill-the-cat>
In-Reply-To: <20260915184953.GA909517@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:39:37 -0600
X-Gm-Features: AclHuK8l8JesAcT2NLVNrh3swojrGOaAcSjsjjAi-Kty2ATXQhBXIjgfRdALw0g
Message-ID: <CAFLszTgwv8dDCbgfWHBhToR=e6NHW2FD5Lk7t1xbSte_4fdUBw@mail.gmail.com>
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
To: Tom Rini <trini@konsulko.com>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
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

Hi Tom,

On Tue, 15 Sept 2026 at 12:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 01, 2026 at 03:50:35PM +0530, Naveen Kumar Chaudhary wrote:
> > If the malloc() for the UPL handoff structure failed, ret was checked
> > while still uninitialized, leading to undefined behavior: either a bogus
> > error code was returned or, if ret happened to be zero, gd_set_upl() was
> > called with a NULL pointer. Bail out with -ENOMEM on allocation failure
> > and only read ret after upl_read_handoff() has set it.
> >
> > Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init process")
> > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> I've seen this a few times, I'm curious why you have 11 chars of the
> sha1 for the Fixes tag, and not 12?

I probably copy it from the short log, which currently uses 11 -
sometimes I forget to look it up and add the extra digit...

- Simon
