Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC22C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F4C060E1D;
	Fri, 18 Sep 2026 20:40:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3X6i5E5Yf4Ag; Fri, 18 Sep 2026 20:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5872360DB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764051;
	b=IOmMCvWvNLBHzq08mJHgRAg1Bky6llogR7b9QfPL0MimJVMVuADJQDM7/cCr9daC7JT5
	 5+47jhYUAUwWcIGK190iDoKz5+CoK+N7F3x5eSdv5QI+32dvZoKX3rN6qcj0LqxdMo1/1
	 XBsmUV2GyUM5iUetmfh0c8dREerC08nyRZL5qsXtAwYWvcMiAce2D0OhYUh21NJ/+gWAw
	 qlUaBurWgyHhG/cDgiZfQEYPvt8txUPfkoEehsfDa+E7+G/rpZCOnDEfmAHKYlMgYmhYT
	 zk4BO0i+JHxrvuJkrQsKzbXGCFctWGwIBS6MlN6F76xwjSXII2JGr8mUz2x04lDEEdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764051;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
	b=MdApNY3mplenNlQL5CqY0IUTG6OPhDnposWxPpj3sg/EckYUK/TjDaNxpbw2jsthk8La
	 sTs47MgqxOH+E6GU8/FZUPEEW1NDoh7vFQOPlQ6F6YxyBcGVjranLLUraU23PPCket8HV
	 igejr7Vya9I1vS6XKeC9ZX32VLbz1Huea3Omw7RK+mjMDx3lEiCKJIxM0gBHstGLXM6q8
	 M85u36NhYmIbavA57BbdZCJQQWK0OQZFX9RvbLH6Ygz3+qrkLnZRDNFOH58dX/rsCy6Ur
	 teX7YO4UAn18Fwy9zllC11vtsWDlS8AM4siZlx+2QqOt8Ll8UDd/LnwLqnOorAAwi/A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RdnEvknl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764051;
	bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KsDG+gGSPRRNbWNbCR7N7u+mZ+c7mdA/fCz7T9+eqN7oT202/0q+zOFlClOuD8if4
	 BS9kv4OZMIdGZe2j99zH3zW1w/OVZKSOdK+tmI6WHW1Pnp1DtuPNpH2OQ+YZFaz1or
	 OvuRxle5E8lotHm0Bh37FRxnaLYjrUz61U9gLcIdURDrff/32k4equNF2cTd3PM6bA
	 2fWlYYKYrnqswU3I6t6JshNhmK5BZ4J49NadJF1f4cu8eSXoCNoaH1uk4Gv+C8rwBd
	 zKrJ7GimBYpGv/nIO5mS7kSYKpE1U2y3Pix5RgxWdiAEyIPoiKrea/w7FI90szS2Ju
	 Z+hfFkZMume0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5872360DB6;
	Fri, 18 Sep 2026 20:40:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F58B362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65B5160DB6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1SNht5takre for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:40:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 56FD460D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764049;
 b=MH+j9LkStM7RWZAqcQtVB0Nd7aHzian6erMU1hHWUiiDZyz9SAdbJfXf6JRDnopk4the
 KeSwKltSv5oVkkrcOgpaz0aYBQPG5lffLFfwPZ4yRX2xgiihaAUDZvizHpeseXPF5MDzh
 3vo54xwFPPPAS3et163iNSh+imAOhn71OyqymxdqInCn6cndSxsMeVgLepw6RRQGI5xvm
 j/M7eNIGlgpKasWPulHAGI3aHfTPbj5CEHBcIhDYQnaxeZWkivgAf6vN9lvQQyLggPYb8
 qkI1bLM5OfcgU+EXZ0R+x7d0M4PQ1a5dlGkqbNLFG14G8PtqaTa3anTAwoaePwqC2Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764049;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
 b=nPmIUNjk4GSDyvS1oXec19fesCLwAaPPI7BlkdNTQwJ9s187hqLD19J9n14Pp2jnDswf
 9CHJ2BWtpOFpfzgyadS8msZRggiqli+OqHRJxcjlyhXe6EqefTxYZwcEYcw10MXtKk279
 BbY2yO2OC25NO2rHUhjNM4v1cyJn01uGKpqSNdm62gsCAoAtw11ChYM2xknwpx7pYmcmu
 vBkEnZJEi+/vZ47V1IJ9U2lY6P9eCPS/83DIIK78OwbYDELe7erXHBdZ9GptlDqCwFcRt
 7yApJCFzCE1t/v11ZbrJQBvwI03kOH+mUnpQ/MmyvB/em7xsTQptB5V79qpzJ4GqOTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RdnEvknl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RdnEvknl
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56FD460D6A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:48 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254fa650c8so196429266b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764047; cv=none;
 d=google.com; s=arc-20260327;
 b=pmOrCCeoFiLAeTZpltDOJK9TyTLkl8HLgHI3y67BaMwobJM3k3JBZBpK0Zw1veer+G
 JkS6JC2noW7O6uxqdMgzcypP1F1Axb93GWTUncj0rll4LrzjmA+DL+q6dVnUjAvsPkVf
 BHnnaQN2116uMLqvgJEBEX+HXsmQoEapVm4gKDc+rwIkXJhAdxO5iRchzEUN2bzXxMCW
 VATuLNySsz9V0X1aY5pOES9RqdEJ8RwIGj6LcuVLBGj9jDF8SffC/yllqMl7eK/MZh64
 052d74PO8BZacNWt9JYOIR6gVg27pAnxlrJBEXmfDSjgeMyi+l5eq7G1mudFNHEkiT4y
 XvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
 fh=hMnzCCESv5iutVaH6AX1PrbYoVsPb+wpOEI00M227js=;
 b=NmVIqRuBk0xgok0LMMqOfJdyCSCrpBVYLEBts8ASgOfoIz9Zt1fXVE6YYnhcr5F+N3
 Te46Ta3AXDOuMEOMHU0ksNcBxR++rKCqxeyeV5bK7Zq1q8ZqFWb2lz/BN2QN9fj6Wk9V
 XBXF+/fp/AF0MRd/sRULR2megr781U8LfPYd0Svloj1FrDQK11Xz1haPalK4c49nL7eI
 LEqz1u+6aQzV03h9Y3ybhhKr3yQB85dzFvIQA5kS3GOGsYcGlJf4LUV9PNg41oTIjz5h
 9yLIJud2n0vkYQ3wJEu2HZVtoT8pPQFZGjDqaWChjfo6y9H2YcsHwRZ/4IwGDOIlN2cK
 XiAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764047; x=1790368847;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
 b=RdnEvknldZfxG66itiRnoZ+xfjbyDbCRv5a2wjPkaWjcdBc8wVoEbBbUIWgbypjfk8
 jEYqUC9y1j++WQ155IPJw70FJ8m+9SgG28KM3JIFxIpNQLlxuZVfdCdd0tElqucCf2xP
 s3qPWDUIvL2SMk7sGUZiG6ThmDJfnoCY6v9rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764047; x=1790368847;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N0iBZvzpxKYDDTQuZGLA2wpo2AgkT5GBrQu/iOtILAk=;
 b=LzY5uGfCuKLH6YsWjsCsZcObqDw2wBztSf/p7jRynRGP2WJ5WAuFw9KrzIyy++XDN8
 v4IYRC2ekMRtQhy5UIdP0PP9ixYEop750u1uT4cicg6BRthjcYjzwDsjHaY+f8xre97+
 pmf6x2Aevd5O9ffdZXRRvhkdPt5MXeeCy97Y6N5sKZj5g0W4Jl8Uu6eG2MFliTm9S5uC
 5vodGA0czkHiraIumb03QRGxUoObUGp+WprMeEorcUrvNim5Jv/axFg04qGRqTmbbakA
 PhVfqCKq64lBv/M9hzU8GiSheP5loYO+ntLUIqhrVkGQS/krkynRz4+wXD/xxLis1BAc
 J8ug==
X-Gm-Message-State: AFuF++nejrDX3LDL34dnwyZTXp1BBMBg72I0ZG6HK8T/Uet2eClIe+k/
 v4BkhCMGwUfuTjMka5Ue0Fxs1pRB7bQ8M/pWTZnQ0Ptf/PR5XvQsoWer0rpOCrH+Vg2PWFmPBbL
 ctqW+10ZT3guil7mJCEdWrZ1TbrMHc5GDXzEaLlgQ
X-Gm-Gg: AYBFou2BmcQbKeFiK6bdMNaKQYe/P7/d8n55wCd9d632lEh8ADxpU4PSZi/5E5Ib0fs
 PK2LICzkp/vb6hLjy4NjXdpf1Rj5CTr28t3zX7V10XaEFzcLot7V6rXoSSyP2KSdLU98qIm8c+c
 /sQFrG58WfAlqmYitR86oafbXLxjKXg/Z1UjG0E1Tu+p3BfsQ7C7Qg4Qwnc44ZSgomqxxxw4Sz4
 wJJWsGTTRmTLuu7rn7aREPcIfnP55+3MQqKrIzsE3NkDK1W1YyN0tIvqGfjclQI97W4S8qcw+e7
 UYeL5WGlcHyyJTiXzRwA+lpvGJZHP2LHB1Z6/tGmccQRQbJkivcgToOh
X-Received: by 2002:a17:907:c20e:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c2a1564868cmr354286266b.9.1789764046816; Fri, 18 Sep 2026
 13:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260912124454.13578-4-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:40:34 -0500
X-Gm-Features: AcwNN1VW-mUIpREu95Dvnug49VtI6FUwkMMtnOXpJN0v9PGMakNqXvROaRamqWs
Message-ID: <CAFLszTi=dWnahtzxcN7_q8-782mcXhKnwovZWFOMLsQndovaBQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] tools: mkimage: share the external-data region
 between image-data images
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
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

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: share the external-data region between image-data images
>
> When building with external data (-E or -p), an image sharing another
> image's data through image-data still receives its own copy of the
> payload in the external area. Skip such images while the data is moved
> out of the FIT and point them at the referenced image's region
> afterwards, through identical data-offset or data-position and
> data-size values, so the payload is stored only once. This is the
> resolved form the specification describes for external data: both
> nodes reference the same region.
>
> An image whose reference did not resolve cannot reach this point,
> since fit_resolve_image_data() has already rejected the FIT.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/fit_image.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
