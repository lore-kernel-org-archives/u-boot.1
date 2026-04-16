Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52960F8D763
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D8E84246;
	Thu, 16 Apr 2026 19:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GN8uRWS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489828424E; Thu, 16 Apr 2026 19:43:59 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58BD841C8
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9c755b2cdeso1349590366b.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361436; cv=none;
 d=google.com; s=arc-20240605;
 b=Ff1SqtReZ1zMUzEzMmoU0eddnEs3oy35Nq4P5DIIEYQYaB0iHEdHHIhobJCORhrjUW
 NZx2bEbBjSx+/rLF3S4tQWYSd0d/CifXaQCS2+EskLY8nnwvdiY3LWkudhm2BDyzEmQW
 deBD7bO9SJ8btCIHrKVFAd8KPIkkm4Vmw2GjtAc+X3y5Y6h7mjD80z12bdueaBhnX+yx
 47nWhDuWox1jbqVevCT77WX7Ws6haiMuoCndD/oWPq3NEb4sJacMm8n0C4TDGgwrCUps
 nTIKihsXHYVnpTeKcPOjaN7UC9mNdyvYaLS3lpt7U3uzrHu7ZAwr3cBPPNmu/KsvH2gY
 XvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UoO374vGrwHRviCUoNligYvR/1zjExDOTOoY9YdbElM=;
 fh=GA4qErqYl7KG2lEuOyu3WtbTdOjHCRexHqdv3eCP390=;
 b=kHIDMqvBzOtz7RAim7ipMgh/bCMrcLoQqKRYT4WTi6jL+p2UhSQZtDU5qyoBPumA58
 DwjHgBG+FjPTUtln18mHyAOKJzY3frAEV84Rh4AQhNWkrMVUlkDYxzFBWpf5ph48bbT+
 ZuWZn7uHNIwG2pe4Qt7fOLuZJ0TjdtBXKBU/BbKM8mrO9azj6qqpmu6ONT55nmtx3y/z
 g5KN+N9+fNAvZFDlkPmhL3fz0hJIXZTWghpLvYyQH0Jm9CvDXEXY3OBHr9BRzGdJHc/d
 OS0b7WW5Ntu+JbB8zIKjSL94jRV8Hh0nSmctyw72w1PPymDHmU8mWvT3hiMvePAB6Td+
 T53g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776361436; x=1776966236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UoO374vGrwHRviCUoNligYvR/1zjExDOTOoY9YdbElM=;
 b=GN8uRWS1kouCI8fL/8zpeGSPXokbc0V6dVsV/nko7He71bME1sUVx8912paJETBi7Z
 fG12CIbFc4/7KmYYnP7NJudhMRNLssUxPxFz0AqrVoluqhENJlI7mWjlYjZMiqDEabdn
 n6CWvYNpAGQ/SCM2LnADWQLOkWGE6u7qWKuzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361436; x=1776966236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoO374vGrwHRviCUoNligYvR/1zjExDOTOoY9YdbElM=;
 b=jkoZmAn3dORCcPB2y7U6cnsm0YoZCtC40HobeGq/7VvNXsm2SNcTOrmZU9jJosrIIT
 LwlIi8jzS/r2sUyOH1pq1QC9ztGqz1YYOSbv2MYcacNT9Axs8c7poR95FIrq531aMgdd
 MqNGI3V0OTf5jYlcSkHh+6yDs3v8IiRBJTHONu+gp0nLxTh9sM6uPZLo4bFXqcTLidWM
 qsjsN4RmONNyVbgA2VkzQua0xPKeoVLbAa/tBKE+m/86XzhrqfYugDbOp++F/e/1shvE
 vd4hiq5xcI1nMpAXKjvu05BCV/cbQyQcw8kkYDJJar2uJl60UKPjIxryDKRl12Ft0goS
 Wx2w==
X-Gm-Message-State: AOJu0YyqRYqZMUdt4vrO6XM6mFzfwUCFy9LWZ6PUXQ9aAF4qTADQG8C1
 b3139rA5z5PqVAOlNO8iT6K0X9pTJNsawmErGXBD6R26Ss4jCc1NWYjsKsLyHydtlkQR7614eMK
 RNu7CpvWXPgw++Xb1b0mZg3cbFdlb/3g2Y76KA99t0ETfp3BJHbF7ew==
X-Gm-Gg: AeBDievJd8o1VACXZ36fMM6vS4gPB2LbHgm3CjNf9maLGSQqawNyKNiTyVriRy+MeAg
 sxCIc8FKKEstoqST3d0p2qMY8AkfEpQpsRl4axculZXUb92qTEdT02HslRSZvk/Px5lG1TK0EDX
 3Gr1HjruFKwMeW+ciGjPaEYG8lCojeX4pHOwBL7geaiieEMkjLEK7Zlt8AC+Gut9PGPaHx8cawO
 SHp8qCMP0pBsp1cuGxhjZF5lEO2mnPXCfjcyXeDtPH7LM6g7NJJ4e9BEB30K6/VCZVckiHv/tNb
 8gpbYY4A8AB3mqLKGS5z
X-Received: by 2002:a17:907:8b95:b0:ba0:d58b:6045 with SMTP id
 a640c23a62f3a-ba3dc68653amr20744266b.27.1776361435980; Thu, 16 Apr 2026
 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-2-sjg@chromium.org>
 <20260408162543.GD41863@bill-the-cat>
 <CAFLszTjKBrUu9zFHyHXmSUMCrZjLB05ri9jdSaaTBOuJndKE0g@mail.gmail.com>
 <20260413201853.GG41863@bill-the-cat>
In-Reply-To: <20260413201853.GG41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 05:43:43 +1200
X-Gm-Features: AQROBzAE-hsinKc6dk9QRFgOSg4ucv9kQnZFtzbGheFvCei7sWkpLovM-SLKV58
Message-ID: <CAFLszTjn+AB4LijTEw4T7cFrBPZbz9tpZK=KW0uRoJxQVpOpbg@mail.gmail.com>
Subject: Re: [PATCH 01/13] boot: Split out the first part of fit_image_load()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Mon, 13 Apr 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Apr 11, 2026 at 07:03:35AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 8 Apr 2026 at 10:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 10:54:10AM -0600, Simon Glass wrote:
> > >
> > > > This function is over 250 lines long. Split out the image-selection
> > > > part into a new select_image() function which handles format checking,
> > > > configuration selection and image-node lookup.
> > > >
> > > > Take care to only call fit_get_name() when a valid node is found, since
> > > > libfdt does not handle negative offsets gracefully.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Function length isn't a problem in and of itself, especially when we
> > > aren't pulling out some 4 or 5 level deep nested logic to improve
> > > readability.
> >
> > In my view the current code is very hard to maintain and change. I
> > know this because I have tried to do it:
> >
> > 1. By my count, fit_image_load() declares 20 locals. Even without deep
> > nesting, tracking which variables are live at which point in a
> > function of ~270 lines is extremely hard (see [1] for someone else
> > that had this problem). Just to take one example, pulling
> > select_image() out makes it explicit that cfg_noffset (for example) is
> > only relevant during image selection and doesn't leak into the
> > load/decompress path.
> >
> > 2. The function has distinct phases: format checking, configuration
> > selection, hash verification, and image-node lookup. So we have 'find
> > what to load' vs. 'load it'. These  are much easier to understand with
> > clean function boundaries, rather than an arbitrary split at a line
> > count.
> >
> > 3. Reviewability - when someone adds a feature to the loading path,
> > they currently have to read past 90 lines of selection logic to find
> > where their change fits. Smaller functions with clear contracts make
> > it easier to see where new code belongs.
>
> Or, splitting things up makes it harder to review because now what
> you're reading through is over *there* instead of the next line. I find
> myself having to "un-inline" function calls sometimes because we've
> thrown around so many abstractions. So I stand by what I said in the
> cover letter.

So...NAK for this series?

My motivation here is partly to implement new features in FIT, which
is quite painful with the current state of fit_image_load()

Regards,
Simon
