Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F22F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6748419C;
	Wed, 22 Apr 2026 00:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e2XEEwYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E750C84337; Wed, 22 Apr 2026 00:51:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDA083AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b941762394aso650006566b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811862; cv=none;
 d=google.com; s=arc-20240605;
 b=IiOXRzHbHJ+PnodrNZspY9h4827utopPu6RBOVBSRGvlPQWeLZNenjQGCjlUL9CeOC
 ne73e+Ut27iZdIONeAGLBPELYa4GFAAnx24XJHjzne7ANZtafUQc2xbol+4/5Dny7+e8
 msb0gs3IsdChm2MFrMHm4z+hcC20+MYWm1996Mpyswp/sZS1xybGOf/R4tU+DB+NStTl
 R3zXLrvZX3oEw6r60qSAy9RfZigWUrx6e+g/ZQ4EjrzmEKy1WJJ1L8jJ6ultnoUw42Rb
 oPgFZ1/wOBmX5iOYi6yJ+KIgU5wHDBuaRuEXP1boU3SPpmiYEtwReFch7eXc1VM406m0
 q9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UfxGlShJndguUIUycEnxYNHigdL7zsNnw2fAng3T+VI=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=XhPHjYH1CVGKcYbARLNQMmQwBPW009025St3A3U1iPRKwlDm++n7+N1FjLMRvGC+7Q
 5huI8WKkqi64BzmfYvWmKeL48c8q8P+Fadsojven054CDqETVEZidSFOdMc4utHsi9TM
 eHdc2WeUbVwVGMvTS3auZwcXF/6qfkOu10ihzCvz9hhOmGLCiqCMzlnNQi87b19xWz4B
 CxjnCv76LvGYWKmxwVpOLwK478cOAsJeaQE9ys53Vz0tnwkm2M/h+FZaS3MGlOE96STb
 2eRHeU/HR1maGWbLK4kqE9TwgJzYXxednpOmQkPhgFu6UALkOB3o4VjZs/wMQ5nkDknv
 l+IA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811862; x=1777416662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfxGlShJndguUIUycEnxYNHigdL7zsNnw2fAng3T+VI=;
 b=e2XEEwYJ80Am7gystuQcENmavCNNFs2DMYQojoZltm3edgjOC80MBzTKWFrBVmEz9L
 pNuX6CsIFhYOMKcfrjMNqBbdm3t3Rveo10wz5UVsQlFwEru5ND+EMMrEVtxAPHTazGI/
 Hs9MlwkPc7G7Murvb0iGvIYU+80tnFwer7Ve0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811862; x=1777416662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfxGlShJndguUIUycEnxYNHigdL7zsNnw2fAng3T+VI=;
 b=DDpyLy+/BtElA06ebnXs8RD6dLn5FBHoyhP3ORnqfOWWYj+qqJIgyZ9IIhIprA8Xy0
 /nxzHsy08HVeGlmYQkmDki/fMb1hIwLw6GpzwEy7qc3TNFQk4HbcmzcvLs49/s2idxlF
 9oOzlbOqCOWC/OJ6N9vh3zLjfOwvINaykHukxKhUzQfzXYPNrtxmxapU5xbEdTY+wnvO
 mH/jyn0wnPFB7pPppdZUESVZxLeD5cK+v33TRs7O/27wjjipY8HN5IWTUm5V8NHtTTYg
 yZxhWjKr6r49c7C/uCY7qcqjhtGp9o7xv4NTYroWWBJEssVSWqoUVhcVDCccBqCFRDPH
 FHeQ==
X-Gm-Message-State: AOJu0YwXegQzs7PWMW1pCHeOMtjUuqRuvEKKxyXkigGlaP7UqADw/mPZ
 plY7tsedh+edoxVmL3IWwlVA/Jwva0SLocbzsSrwtNHRLpoOktdAPWd8Z0ic/yxo4khq1R/8bjx
 ho8/1Bv8yF6psbFM91Gu2i3R6Pj+pPiZhDWwJP0C8
X-Gm-Gg: AeBDiet7aRQxcpvuZAIMSbekiuSulD95fJWjv0QtYm3ru/n5xBEvx5meq3QnNYOffOw
 YrP2eJWxrxzbyXlB6UvnVzp37DG6sua0oRwNarr61ANS9m6jhmv3kmICPl+SzKVWSUZ4jaVb3qM
 +eFP5S9DgacADH8WFXHQxJSKr34LNokx9FkqT/TkEMhUnvwrDpDkLAjkPBpdigH+e1bQJWnExz9
 vq3eXhJVpwfcPx3TZBvCaa+fV0WdoB2SHkxwZ8qApKWMOc2kSILbJfMVQ8BZdD+lliK9P7vWNyU
 da+XKP2Mi14Ab7PXLAmW
X-Received: by 2002:a17:907:c318:b0:ba8:28de:697 with SMTP id
 a640c23a62f3a-ba828de0ac3mr529854466b.9.1776811862553; Tue, 21 Apr 2026
 15:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-3-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-3-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:50:48 +1200
X-Gm-Features: AQROBzC_ppL9osczPBe8QdJ7uah37vyo-eG-SvkcJCKxdcG_7vPENSgaavHZSqc
Message-ID: <CAFLszTisHY-Um8a833uOQv6Z2nqWRa2N1tyY4U_kfMThFPHzjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] board: ten64: remove USB hub references from
 internal FDT when needed
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> board: ten64: remove USB hub references from internal FDT when needed
>
> More recent revisions of the Ten64 board do not have a USB Hub
> (USB5744). The references to the USB5744 need to be removed in U-Boot's
> internal FDT to avoid the USB5744 setup being invoked on these boards.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> board/traverse/ten64/ten64.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
