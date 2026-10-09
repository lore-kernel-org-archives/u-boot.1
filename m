Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B75CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA2EB606A0;
	Fri,  9 Oct 2026 07:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcVQ7uMoU7Ve; Fri,  9 Oct 2026 07:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1F776084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530650;
	b=O5YFnO55ytrmwFHBbnbxJ7LNS6ML+1BoHNV7If06hp35SxE2VUfrtbvI0mllf4yLSctc
	 FXIVHAymMxVq62TL949JUQs/vUNr/dpxBkWK7PVCgol3C4KnQEwGYQdaTnGyGdvukOwuS
	 TvgbxSZGHWEaq6m0euaYWgHMJX3xYr5JviDvuV/Rs8l+4RPVe1L24h/FjUSF9CmyZ/35b
	 2z97U9hNl+HSDrXLJ9LfC1yZ6y4SqRV8auWkXQZI44+UsZ1bhkZ6Im49B8sNX6Gvz8wSJ
	 d0pgeH37cOoQE4UfuiD4MKeUSoeeRU8eqGRPe3CPoKVPdxFYzhfV9ko9pKKYGIPqtlQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
	b=P+L9HOb4MiBKVhtnxUEHsZ7LDLqU4q3wI7JxJQAYdtIuVGzK/OPRQ3q/LzztSDlJq5pz
	 zdsC66thvBIxc5t3aeTU+7BSjeMxxhG7bPFhz36aIJrOcGivvcjw7Gcsj6ADY1leAmg1h
	 cwhYVW2aZJb4oEBcaxWnIxsbqbjqnXiVba/Cmheav9VzrT/I4nu9nXA3q0r65C+H7TpM9
	 msnjZC34FJUdgyD0Tn6TWr4o88HxdVLQrXoWY8Sw8IKbjrZpG3nQOdpiJ9IfLwHubuPQB
	 DlYPWmDZ9aSbET29faENElQpfRokTNvlRVebpbCT6kFwhMrNQBPROKyoC8ycuY6ITUw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530650;
	bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onSRZPx01EjqltSKKL5k5IJ6INOjlUjhu16jyYCJNVPEJCs2sC0zvRLQNLWx3atfZ
	 3SptUsddFRi6RjzZ2N0gpeyCxS5mnh/akYQ528ppmCnb85MQsGxhfaG64m6Up5JxKk
	 STWvXuRoiFiuu6KyEY7qmj8nr2X41/DSx9I0U1gS4yPsbIcIjZNabPwo8YGIBbPK/O
	 R3U4PyZa1FGMq6GQDjhrzTI90G4Esdr4NxVnqeDqlMClKEZyU01zmwhFcTRQ+sUxvR
	 LWjhcTRKM/PpzQr1vBf9g+Nc94vezihVizHFU0xSj+SGD9HdmuovBNqGKz7rUg8gv+
	 HJw8yVLaDtw3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1F776084A;
	Fri,  9 Oct 2026 07:24:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5ACA2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7A6B40902
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0j6a4LbcvhE5 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B763F4091E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530648;
 b=f1Upjr4OOrddZBbWsboR5u+B0fIxTzPeaO3dPnqIdeW8zr5ixBjS7ZfuLZhEeQGf0MNF
 IetRGjZy8wBZhGjpvQ+A69sQoQKx4Y6+wH0H20QIX1RURLx8Z2DzXUcRUi99XPnGQeg9P
 idemLjRgmTg6LKnX3vaUuAjY04TNH98Tf37Ws7ESbooOTLhFZxhifyDSC6yCge5audnV0
 RaXd16y1SdGZwKn/4h67jb0gYTvRWJoltVeGnGKZMNbpB1tM06LH8o51spOxJOUJ4AoiE
 AxBJ4C37XzM0CapLRjdzKY9XwDP9erhKZ5PwS8Y68jfVR0SksRE76GjcytDSu54cGHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
 b=aIPiF4x2O2X2utLP2/OMCwhrRGh6+kySmMNPGiH5+FrtixrZx8q3/DOKQLIrGRdif0M+
 CSXVb2w/dQigS/CMR8WX6rS0YotSQB5QW9OWH0U4KeXBMLFAx4VGzmKIn0Qi5QswLbwKr
 xz8ZxAlm/X1dzjDa0aiIHTqyg3NeJkTN3MO+sgINDOSS0yBr2mfwzXQvsuVPENb+EV2Mx
 INGTmjY6XeFygKvBq+AxxanJsOA0ywa7kKv8xmozU2kLl0jSl1aMXEG4S3Akn+iAtPGe7
 xTOJe+aFYJNFHgDfzQr5u/376mzGtr7p5jpaTCP/bkBubpBCg+33LqcFIpshkJV6b7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="JJEZ/HDq"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JJEZ/HDq
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B763F4091E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:24:06 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so10247196a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791530645; cv=none;
 d=google.com; s=arc-20260327;
 b=orJUa2zyEuSuGvfJpA+A+cJuU6HOfb21i7hNoscvFM/JGZC1RZjoSjJTH8nG+ztQiV
 /daSDEO3u+Y5sxDL2eyg0SW0zm6j/5+aay+fEp1t/UM06B/AJhWlJ/fkpCA8lRoj4fzU
 dhgkZYoY4KjrlD+MdB+f6Ul1NSx8swGhKtagKMm62Wf9AnJqU37YXT0RDAFpLlNxRpgM
 F79Ruam+R148MhxHg5fVkslgFyfS0NwidIhASvXqSE1zAMRMEiyVnsJndgpSNYDgU7tA
 ACE1PdOfymjV/BEPOJgPPyl5YfYlw8J/it/5KnySRFfXQSaLI29Gdjm6RJiIzREOrRSz
 FX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
 fh=C+cTdi+zNvp82oRqtXr/ImfMU651V9uoPpnItaKYo+s=;
 b=LJJwb/Qi0znTgI9hRoaYKs6vQHR46oz9qgHVyZSM27yTmjR1aBvovss1zVdCBC9ZFa
 iCB/N7docRf01nOl2XiBXkL4ttoTce829Xk6sAvbjMwPOW4yx3uXk8/xCarpNUMaKXbj
 uGSYJ1PYz0v3Ik3fYKDoShClCJyS1hee1DMOaJLd94hEfq8c/ov9fvFMptd7XeDXIIZA
 Eu3rNi/rFuAetkyF4m+3q7bn1+qJ7Zc+bU86nkUHVBmmDB5VKlJDBlx+FMC/OZzIkOuA
 UAdi4+LNWn32XQAw9WbT2VLwOsS3HuIVoJtbc2lSjdM1cw71hiC630NUiAofNZh57Mzd
 SNMQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791530645; x=1792135445;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
 b=JJEZ/HDqbnOc8+mYy1h0HaaiNtCCTdYbrLTJM+qgJk5m75gEqSNrpl67guxuF4qthA
 +VH8kgpvElGr5advzI0Gaftsz0brnQYf8jms0iUrS+H78vn03qJuefIqGILOKA6oE48W
 lQ9QRVT+XjPe7p/8KiaWln+Gc8PGkPEjfemA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791530645; x=1792135445;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d/6HHS7mpafuVOBEaJI/kWi742e69fNW9RcUDT2yUNo=;
 b=pFD/+ewkIEfSJPh68amlyMtq4wvCT/hopEPeifOijJ4iRP3iJNlftW3LzdnCVsQkeT
 F20A6LhUWr2xEZCFzONOZAYSpVmVNzzZLMSZ5z8PDlnn4tsDqx7pJnIYw2y3CLhKnfI+
 rGfMZ8PY72Lr1juRAh0FxJ7gnkgRgmx2lDW6Ew+zc6tUKZkb5Ej/Fq9yIfPY9oTZalQU
 MrlT6cqse0LF6VitSHLpYHXqBfHF9LjKyMqj89rsWM35/mWPyKNd56thXrrJuc/vfQPY
 VapE4Ss11qsqWnWCLq5TgohV7Lk2P9MTM/g68lyzyW86NpBn/+ULP4pa0Cj3iuy4UUQ1
 XxUg==
X-Gm-Message-State: AFq9FYL5UiR/af5IsifSjLJIHzZIImAo+TLOXXVTycJk3t2Q09GUUzQs
 jx6XPPD2GDg92boLm0nfRvW0PoYSjwxV4tBpyidhUGgtNcaCM7dLZHA9Cc/67Zp70LpOtqaqFLK
 RpM5dZJuTUFSvW1pYta8cNZln63thuBCwKWzwqf3r
X-Gm-Gg: AYBFou0BFI5q8/MZpusAXNO9FaloRny336ewtcOoZAQvq5zUPWZmBjxdm7WfpT9R4SY
 BDVHOUtYMwwiGIEZb75lhynMFWMOyygLOJuFW1x3kJdlIjZ186T3OZuIaKnhm6SEWRkLW08mPJo
 H6P1zuqgfqbP7pR5li1gunp4VFVz1ppw2yyPMKjB3ingbnpQE0l8R9QPeQxQSPtOnSCF3RsO5o2
 wDTJSupEpNqYmROcgBmK9rYrsmqI906o1Y1zcUKBd+Qgq/Im65BiSP1fTIY+mBJ3bkTEc4qX7rW
 N9iTkjYUQej3DH/MAyHyJGj/F8qkz2dpsUGHVqINw9mKNiEUziyZQtc=
X-Received: by 2002:a05:6402:2115:b0:6a9:f88d:c092 with SMTP id
 4fb4d7f45d1cf-6b17c164de5mr767235a12.0.1791530644893; Fri, 09 Oct 2026
 00:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:23:53 +0100
X-Gm-Features: AclHuK8t9gib6elJk8L65GFgbG8Vpdcd-2WOZLHFHvGBSCf0VjwPKO08dj5Oq50
Message-ID: <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Hi Ludwig,

On 2026-09-23T11:49:31, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
>   incompatible with the intent of the qemu DT merging feature, ie merge
>   built-in signature nodes into qemu's DT. To be sorted out at some
>   point.

One thing I'd like to check before this series goes in.. with this
series applied, qemu_arm64_defconfig still ends up with
CONFIG_OF_OMIT_DTB=y, since ARCH_QEMU implies OF_HAS_PRIOR_STAGE and
BINMAN is not enabled. OF_OMIT_DTB no longer has a prompt, so the 'is
not set' line added to the defconfig in patch 1 has no effect and
savedefconfig drops it. As a result qemu_arm64 never has a built-in
DT, the merge code in patch 1 always takes the early exit, and the
problem in the cover letter (QEMU not seeing the public keys) remains
by default. The patch 1 commit message also says the defconfig change
enables the feature, which is no longer true.

Please can you either fix the Kconfig (e.g. stop defaulting
OF_OMIT_DTB to y for QEMU when FIT_SIGNATURE is enabled, or let
ARCH_QEMU opt out some other way), or drop the defconfig change and
say clearly that the merge only happens on builds that include a DT? A
test for the merge itself would be good, perhaps as a follow-up, since
none of the vboot tests run on QEMU. This may also be worth checking
against the CI failure Tom reported.

Regards,
Simon
