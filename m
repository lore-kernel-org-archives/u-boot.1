Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95E7CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B37B83E81;
	Mon, 11 May 2026 15:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWaiMeEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A746A83EEF; Mon, 11 May 2026 15:19:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6064583E36
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so769664266b.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505550; cv=none;
 d=google.com; s=arc-20240605;
 b=j0IOHj9K6WSekzcRKHnIGih/hN5GwjngaTYtBebvpq8I5uteN6V9YLsBpsSXrs0HlE
 xnc25NXxkvpZDCTcA/HhK/PwmJv3TApUI2ZyzewoMtUrizE//J7+U2a8ipN4fBRLrNt0
 omCM+XuioqqVgGMefOKzIuQtK9NipFPW1fW89Dew4z7VaTlJDu69xmV1HE7KlHWuvbjy
 BDBMVdeE7pjO+RWFnK9Ct5iZHcdVfwzlsmNjDVyndBhC7kxeijL7AqN6hKADJ50amB0U
 mKM9UkiUa+axFjRf290D4SU4eNdmpKmUr+jAlnnpFYZh4CxPPaZzwnu0jvQu172nuPgV
 3gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GtbstkhLiTQ6Hr8QcIYx1DNSKApf+qPLkRLkwKnj5K0=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=g2/+C040exsiGA2sGN1bE9sty1AUDT+i4PSSPO1TYV8jcuV5GcM4hvkADbLteYNWDR
 k3OPY/eYfKmm9APA1oCkBDHCevvbejnEhqD0lolYQwfAFhfhR/d6kzYpav4r7VqXtflx
 JBycUefbeWvz5ybFbSzWcpY1Tvs/XZw2CN8SmcQc/cEEcURy6JsdAOVLMfsIo28WjxSn
 TWpm2Uf9tcVX4NboC9MxabjXnmw5bwPwODpX0e39DaME+wWEUQAMehciqMu6eU1xv/Lq
 fyOc+xNjxA48MrPIvbD/rYukkwzfKle5JFPhaZxjXWpy2zO/nZYsomnxmPJuheYSJekR
 a+7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505550; x=1779110350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GtbstkhLiTQ6Hr8QcIYx1DNSKApf+qPLkRLkwKnj5K0=;
 b=iWaiMeEo9BARo5Vu6XKCStRhUVRptUiDUMxZV4QsO3ZMml47hGEVHG2pPXwLV7vtY8
 1Br/gIusacLqjt1Ofxtkgl0EpjAWRYVrsxdug1cWcKI6qEDeTAGcq/QTGFu1eUJnfoPl
 zFTqn2Q3lFNEJO1ynMuYei/XYZ+yZPg1PN1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505550; x=1779110350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtbstkhLiTQ6Hr8QcIYx1DNSKApf+qPLkRLkwKnj5K0=;
 b=qwRikSYf4lDkSCo77gu6kOVE9c/HGvBKuV0jXA1OIzMnMFQWtFviudClbXjyiXz6d6
 /a1SingYwEhShZyrqa9cKbkRLwyjPP9ViKdOvvZk8x0RxJ90omXsw2npifZias4uZWm9
 Wd3btlGLgy3iu3d2cpSBD+M0rslVDSwnkeSFlSCCCwxFEU0f+J8kVeCy9fqaP3qAHQe8
 0piJpOKNjfBM44JeVhc0BGs9z3IvCFLPNaZ+kwXqG2vp8+iazz7cFsUAcdjvdIZALHFZ
 zJ5JXed9PyuR4BZKSafBtEu87r5H9BVsLQt/e1YTjb2e/FM6xSgGiTR2+pCfLu1bijYp
 FHQA==
X-Gm-Message-State: AOJu0YyrEHk/yeXVWEMlrO9md03S7Zhb1QjirpD6mQxY9RAhODJjeJDh
 odMyqVIDbcZby+pUVqTnRT7luwbL3acN07C2m9WMbx+rbArr2wMT0i4gFZApV89kZB8aTdVvEJJ
 z6Xy6NT+AmGJKw72qvNPtZZlKQKxjM9FwB1Nrx2D/
X-Gm-Gg: Acq92OHT8hU3obdBe/a20zSmTgL5KyZ2w4wqaVvnKbiwsmNCy2LuQSF22NABZBIHrOM
 vYBixa7gj1D1HbcUhvaezmWMhXAgI839YPGEHBheSS00kIhm/g1nDrAhkqgyqdaHKflEE0i5GBO
 8cA5HMShGVmz0/R78P/un+2o4wqZM+r5Uy/tAMsWAOAU6p3WHiSibVsX3gbv5CoJ+URgyXmfi8/
 Ogym7puwJJYfN3VB4IuO3nx05InNANAce7D2NZUZyXQ3zCjPLquSW7nA64OMYTsmiqqf8kbG0M9
 rkfBlC+lApPQj1lX
X-Received: by 2002:a17:907:c06:b0:ba9:2611:31e6 with SMTP id
 a640c23a62f3a-bc56be3f762mr1486874866b.6.1778505550207; Mon, 11 May 2026
 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260509151339.23116-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151339.23116-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:18:57 -0600
X-Gm-Features: AVHnY4LrnvqclznxaJNDwgrjIAgHe1smr6tU2puf_TV_zkrrSUtJSC0nkKsd0hk
Message-ID: <CAFLszTiep-M32JpLWZiB08xKuKa5vDVAwijWYrpefr187cVYGw@mail.gmail.com>
Subject: Re: [PATCH] rtc: emul: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-09T15:13:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> rtc: emul: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/rtc/i2c_rtc_emul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
