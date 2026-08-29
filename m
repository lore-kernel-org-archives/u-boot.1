Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC006C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 16:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 709A46060E;
	Sat, 29 Aug 2026 16:05:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dqtNFtcY26j; Sat, 29 Aug 2026 16:05:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788019542;
	bh=o7fODf0rH6iD5gXPbESdVAMTU7CmNJwiD/Yd9r3GGcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBDwKC0b7H+vV8zHq/blcwmHS9w/zxpMPywRFMhFvpphBsP5a9KPOS+Rtt8IKZSO2
	 id7j2u+u3S6efBUwmWXHtQ1vjaaiPKi6gX8kEkNplkVsOHiFZQeUJ21MqrZpQ5eLM7
	 CqHBQsg3++9Ph4BpkxvAevvILbc4jpavk8clQWwOZGS5oz9iaFguShE1zATi9GB3TK
	 UMsnIvKIZRK137yWfGqYt5t8nQPX1cC3iEtZN9uNio8Tq3CWxo2x36o1T64hNDiS76
	 +s/mhvDGiQqwaTXXjZUnV0qhzgJ0kLRd7FhKh3caG+gF4Q6w9pGzu/Z/wX9FC1dJRG
	 5jTH+LoueD1ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEF4A60607;
	Sat, 29 Aug 2026 16:05:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7D71355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADE4C60607
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DL8mJCQVO48X for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 16:05:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B/sZq5xU
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19BE2605FA
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 16:05:40 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so451121a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 09:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788019540; cv=none;
 d=google.com; s=arc-20260327;
 b=PKekST39u6USpOqFt/U5erj/d9/QKJKQfuYwJNMRG+49qPwFuesqFN3+LeCO2mQ7Jb
 kAlo0+ze4OHkdomjcyuI5aeA51u26u0Tiaz3QmxL60e5fSSnAY5gDOZOCkX5q4gliez9
 fvMzhLWGJ7BN/LqDMae46Uzqdg+KsnvJVjp/QjcL8TeuAHj/9+ZnWpiFcOVauiWnIowv
 8g/bdmEn+CFR8YKgprCXA3zCNZlLSTP3kdGm0KRULg69FiBPfzpIaFYqgdmlYYt85xkK
 nsXys8/2Cpc4JCZR1brdkUYs2Iv3Ede9pSpM4sH26vqIK85c9+uynKH6diSx0wsujwb0
 3pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o7fODf0rH6iD5gXPbESdVAMTU7CmNJwiD/Yd9r3GGcw=;
 fh=LfeEjkq/Yq80tkHkwtAwBiaSjxJjy/fq+BFUyShCiAc=;
 b=C2YY2gYrHjTdsV88PwHHWGDeYvQ+pAvWOFMfDn3CQZu5LRPtaegQnb1RIGdsDQ9RpD
 Fak15WFkOK8ctHM5t1ajpFuL7rRnjx9hIjdChiPBOkdTSfP7JedSSTnjDrU8KxtxHZtb
 E9riETR7K+e7fywar8vrOEDuXaVUnZTFYj7ESUdrv+Ytpa+EUaldy+glOGHKSHpkLsWf
 DjqzNrWOxDyAPnbeQGtVtqZgKoP72OHy4/ejFbZ1Q6o5zhOAw/GKqppMeZeOK2NQkpgd
 8yVY3cCqGvPPQ7xnIPHMpdPHIHyrfzoJl7YCnHtzfHme6vxnRgvgG18x6c4Mdjms1ekm
 mTaA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788019540; x=1788624340;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7fODf0rH6iD5gXPbESdVAMTU7CmNJwiD/Yd9r3GGcw=;
 b=B/sZq5xUNJZLD7P+zNswd5MBzYzL//XIB58ezAZUdkKrHco4OVR2RKdZCP/wjBD27a
 2G9QlU+wbZF2Nwar7qK1A10weftgsRHd1msUBcCfj2RTaioNksoU87UEFn5sB3NT7Cd8
 2e1JAYVh1Ne5EscHZGpQCyWp/VwnIEEe7g1bY1KzU4Ep5q0OpJch47gQi6SDWF0oyAPw
 597ArEJ6MdlTtc2neikDIYoXsKgI1A/YzuuP+FQrPJUWZRWOZeIkHENad2l3lAdfvO7H
 ZXw99HwIswkQp56d8Ok3aLlfSlzUZvsnHP7m1K9nD4nWoqwtqeSXgbeVL0k6ZUlGevjB
 cXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788019540; x=1788624340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7fODf0rH6iD5gXPbESdVAMTU7CmNJwiD/Yd9r3GGcw=;
 b=Js5oWLgwAUzizRvS1RxwbSF7owLYAWJNyR0Nl1GYiMKoA+PSjY71bWNjMID1HAYv7e
 k6EdzLLAqBrgaLirgLEQP6DMRalfCwRudM6+CrWi3M/2zJ7CAD53lzez5nvLF/LRu6Xd
 hQZiNbO8ikAc0GBGa6ISw3/0pof5E1H4fNAR5AStSj3SrTxRG5vUQ4m9gJ47IXlJhD89
 gN6Djsffa7MnCvHO7zpbGilPRr/Bz2AwkROjSuuBd2OKudPu6B93VByvwRAuWpt6R8H1
 0kDeTz0xBmRgdgO6WBiLCx786DqfhnSKrWNTeQUbjwWRoePfczypj+AlkktIPVJg0Dnh
 udKw==
X-Gm-Message-State: AFuF++mnyo//+SHBqPLVCyWhihX1pC0uCK2tfA/u3vFbiLkqrbFkFnUi
 O/dpRugx1ItSQjnvtHbUHCMnfbYTozoWX9gUoFc4FeKs+E3J26e2XqQP1t485g/y6SGlXl4OT6t
 PloiCRfapP/3i0iuw4c3O5PHqcwddLW2Im+i+
X-Gm-Gg: AYBFou1HAS4P2WRlHAt6S8qmJekRbRE7ov7+9xeh2N2nKnwQCGvQHUvTrs4vHbhLcZj
 GddkSg6BL/rwiWX8rYfCVn7+58F526aijCgnGVX79PYtXEaTZom+/8IyWACBPxHZUsr9ici0fwg
 tgOFWOwBhzUAsIWaOT7nt1Xt9tYC/CMzpmBBhdnGydbqCWt0sAeO1DWZVF3N9sibZcldbpx2fzS
 LbBXW/fRV7pQJGHUH0e/xsHj68jihh7FxoT4s8VcKFUtNVzn+IKgLaaKX3R6UEzwNkzsJ9QYBsa
 VUZD3rMtmiwqYDt3thKCAo047HrMpUXzvp3OZNUBT8XDLdd+aBgBo2He1nFfDOTJVaKklbVO74j
 CHQ==
X-Received: by 2002:a17:90a:14f:b0:398:9c00:29f0 with SMTP id
 98e67ed59e1d1-3989c003c60mr6451686a91.24.1788019539696; Sat, 29 Aug 2026
 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-3-trini@konsulko.com>
 <CAPVz0n2EQAiqCGeDGosfrytB6908iPfvAt4JwNHtua6QE_ETOw@mail.gmail.com>
 <20260829155433.GO3959812@bill-the-cat>
In-Reply-To: <20260829155433.GO3959812@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 29 Aug 2026 19:05:28 +0300
X-Gm-Features: AcwNN1VHeTPRlODHxMxcmVUGMD0ui8a4R80-CmlA0tfk9_XAP5LQ33-eTPrfEmQ
Message-ID: <CAPVz0n0dGEhiK-LO7kSQGvJnU1gC5E=m0U70cO9GAHjhwwKdiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: tegra: Update and correct entries
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 18:5=
4 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Aug 29, 2026 at 06:13:27PM +0300, Svyatoslav Ryhel wrote:
> > Hello Tom!
> >
> > =D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE =
04:50 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Update the main MAINTAINERS entry for Tegra to make use of the "N:"
> > > syntax to catch everything with tegra in the filename. This lets us
> > > remove the incorrect board config header entries for a large number o=
f
> > > platforms while still having the used header files have a maintainer =
be
> > > found. Furthermore, correct some platform MAINTAINERS files that othe=
r
> > > obvious issues (such as .dtb rather than .dts in listings).
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Michal Simek <michal.simek@amd.com>
> > > Cc: Thierry Reding <treding@nvidia.com>
> > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > >
> > > This is slightly different than Michal's version because it adds the =
"N"
> > > entry for Tegra overall and so catches include/configs/tegra.h which =
all
> > > of the boards which had their include/configs/ line removed actually
> > > use.
> >
> > That is smart. You don't need to replace device specific header with
> > tegra.h in some files, you can just drop them. Thank you!
>
> My thought process on keeping them was that if a change is made to the
> header then all of the board maintainers should get cc'd in case the
> change impacts them. I can drop them if you still prefer in v3 however.
>

I am pretty sure that include/configs/tegra.h is unlikely to be
changed since it contains generic properties for all SoC generations.
Even if it is changed, only SoC specific stuff is allowed there and
device specific adjustment will require creation of device header.
There are a few devices with non-generic header, mot.h and
apalis-tk1.h come to my mind as an example.

> --
> Tom
