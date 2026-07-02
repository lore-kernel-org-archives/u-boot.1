Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67D4C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 12:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CE7849A3;
	Thu,  2 Jul 2026 14:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JjFR29kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD851849B1; Thu,  2 Jul 2026 14:24:39 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E2D84994
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 14:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-666275a685eso824419d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 05:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782995076; cv=none;
 d=google.com; s=arc-20260327;
 b=C1+IwomeeyI3hEK9NRhFj+rbWYaRHd6y0s4kH2wuiLrrWtUSvzyXc2WZYFeDsCOUMi
 Sold5ebgVohx9FrgjsE6L3gQZpJEv1eajPYmtVyLP+Tu2Uqk918uQtO7udUoCfcKGaNz
 wG2KlRoL7iEgRjGMNz+kLB8clwWEn0dTqLJwGE4dco5An1JaW0l2/pOK3dRzXcBXb6YE
 OKdkxVvR+jSXyh4ztc2OcWSHVoTlSJDg/J0wSizVAlxkRNeId41KyO75Wt7V8bNk9vgA
 celGZ2XEbC/RDirpGDHOzPs4z9velbny+8hOpm7kP5q2XXH6TaCFKLgk5grqwb0QYubg
 OBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=un64Iw1DJG1Fgb4lFScsIRXRmDFPvrSOKrkpJNqAXiw=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=H3NqGkBeewvzW92DZvExyhFM2yhNiG2hvwdg+pb+KomMtq+EnMu2LPzZDDO+q2DYMd
 XwGeSNmhDhK9yg/ZUyrUJxb+vuyjXqQk3ee7AbaNAQ+PfNYmHpH1zzPNo8PiBbUp+pgD
 hWnzC1C5/q+00MhAQrKxm9kJuY+/5lw0jNx+VG+qDZMwhXJSMiHAFk7XaG9rLZdLLye2
 cBAd0qrfKAbeRjNQFTty5/TXlhInyBvmmlVJrOIbe5EWPslqDLZa8myMktT/cp+qtjhL
 FRYW0EfePcTbKK/Hqr+s8DItbWZSm0n2oQlgekdRQtK+3jwmOh9GIpEFa8M3PSKprv0w
 5cDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782995076; x=1783599876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=un64Iw1DJG1Fgb4lFScsIRXRmDFPvrSOKrkpJNqAXiw=;
 b=JjFR29kQBL4+jlyoZID0PHFthoSbFIunenLQ9UWvK9RgMsU/1Q+cQr6N6meACPsteY
 eQwV++JMP55cnI4RYCD5JT0BJdV0ccWRhaYS2UTL27Asu9Xfu7Poat8QzEvoBulsZnGJ
 xrdpHQyDUUKDiXBUB6WISVa+i7bBwYDe4Z2OrMIFaNwtrarH8fkoxPpkOlfqLlAy15IK
 X9NH6z6nD59l8e9EZ4iJ3VtvsdiBH7DDQs3djt6nZGk8tdouXgSNNXimjeJcqlVFooFr
 hSqlPQSEDSz3LHsBe7ZqwaTDihfNOPWpm3l9bZ0Ggd+fGAkOLicEDqoZqWRTUCQ4Z0+G
 XBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995076; x=1783599876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=un64Iw1DJG1Fgb4lFScsIRXRmDFPvrSOKrkpJNqAXiw=;
 b=YRb87y5w/cIghP4eCNednzHf3H7YW+Zs+Ei+QHuR0HwTjVPjUBS9qm286VnOPxJbwa
 I0HwZuzFzidQk2AnzSavr6GqsmhiIbkX2T3ycpii0+503wJlDR35u8QapPQCjpv2wuSH
 MU7VdQYbsAS7mSe+DuBBER+k1x+z1bxcYHt/9Ra7ebJqZAh+/3EJfdCp2RW57IsfcFSA
 D7G31fEVodPxaDKIfzI26/8N45K8u4SEvdahWxwKPvQEhbBk5GzrCn3pT7J+c4LgJvcv
 wTK2kVWkmit0HyIY8iASQf3TD7ZujCTc2YKze+BMW5QgNO7tKusdRXlJ3yGnFJ6dlMQn
 eBNg==
X-Gm-Message-State: AOJu0Yzl81YLSTmHzRU5VLp6Yf1VD2yeHqwo7a/OQOZ34B7gdW0zTPn/
 4V8iv0zVwxcL1s8tFpDg7xgN6dHGexmikzCgafOZRDQQ170/qEP35iifkwuOtrC2TgOlWxRC9TZ
 QHPg60lrRb8gRmbLcRMawraSjjFk6LOV80BoMGZrzIQ==
X-Gm-Gg: AfdE7cnIZW3Xl+ON+nMEiDsAzrxkXXOeyRZXILOMy9k76gJix0WZWw4aexaFR3b92Yp
 SQ3/YkinTAFQOXP5ed1EQgufvhHsagWfVSVaOfCsh8UCtQsqRv3I0ZpCjPtCGakLERsd+RqgYdZ
 mA5X0CJgdeNvLL8aXjiHscBwBNY9fVRb5hXxACO0r7RCcvHgBGssxbZ1QMxBXz05RHpqcAemhzE
 zMLHhqaUa4jE6O0ojl9LIugYPD7oVh7HyCYQ8SIvkikG4om1lTntdN09348/fb1vRK61ZZS1JMa
 gWRhpyRTLAMo2tIC+uPm6nR/KyHeph8qQrokJydvI6ZvMWDKvtdg4bNWnE79x9BEUHWVBTMudeI
 Y2K58oehWWKU4DIeJmiir8fEdMX5OucBIKq6ugojC/46ScLjYLMgl7xGU9rNPiCWXbF50U0sZKO
 DaFP+OAMy+MMy8GxJZhihzgLa60ZjVDm+GMGmc020UjgJDMi1r2MqX0bW5gjapAtA6jkSkxRlXt
 +KjOdRossVPXLPdl2KHKu0cKXjwHBnVlgGSIUcBwLOZyVK23YbbS/JtqCBLWb31a6BxxHZVVb+M
 BvmXo5dNNSVAH+0CTomm86zzTMQ84IhFwPKA47+2Kq7DM/iEENTCRHlEMmD3LPXSP6G+OxE=
X-Received: by 2002:a05:690e:d57:b0:664:c281:a100 with SMTP id
 956f58d0204a3-66521cdee27mr5804417d50.40.1782995076248; Thu, 02 Jul 2026
 05:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
 <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
 <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
In-Reply-To: <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 15:24:00 +0300
X-Gm-Features: AVVi8Cc2Upid5pPEvdnvqn_LpwZwKxPnnrBVdQgBk07mlamIIrMgh4RVpRU6ES0
Message-ID: <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Michal,

[...]

> >>>
> >>> The prints below are just from fwu and efidebug for the ESRT table.
> >>> Those will work.
> >>> But what happens if you try to run a capsule update?
> >>> Eg. efi_capsule_update_firmware() will call
> >>> fwu_plat_get_update_index() which will fail,. no ?
> >>
> >> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
> >>
> >> versal2> efidebug capsule update -v 0x40000000
> >> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
> >> Capsule flags: 0x18000
> >> Capsule header size: 0x1c
> >> Capsule image size: 0x41434
> >> FWU checks failed. Cannot start update
> >> Cannot handle a capsule at 0000000040000000
> >
> > Ah yes, that ret 0; will never update boottime_check properly.
>
> I think the question is if this is acceptable or not.
> Because none checked error code before
> 583efb504058 ("event: Check return value from event_notify_null()")
> and then
> 353166279c32 ("fwu: Move boottime checks to EVT_POST_PREBOOT")
> it checks it too.
> It means in past fwu code error out but u-boot continue to work with above
> behavior.

That's also a bug imho then.

>
> Pretty much this patch is bringing back old behavior before these two patches
> have been applied to the repo.

It doesn't make sense to update to or run a firmware that won't be
able to use capsule updates ever again.

Thanks
/Ilias
>
> Thanks,
> Michal
>
