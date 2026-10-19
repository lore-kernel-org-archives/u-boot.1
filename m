Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E39CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 506F780F91;
	Mon, 19 Oct 2026 13:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1t0mLKEtWRW6; Mon, 19 Oct 2026 13:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9860480F8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792417958;
	b=jLt4WYKwV36hHVlJEX3WXPoiPe7gb5vpDngXA9iYj5c2SBGJ21V12dY9ADnfuu8F0qfO
	 9QxB2z/rhxFvYz0y2T3lfiNaxhZTDAg1HDYTW2yQCsyXLrgIsTDVnr/hqcd7MBODsDW9y
	 3q9jrRtPxSwA4qCg/mh7+h1RIeC1lbxY27oOirfbhtRKG1wbfI6ZXxHsi3oxF+s46l1Xz
	 6W5XdZsLiYj97/97f6VUoAYBapRr+eZ59TkSRA+ABoI03wBsx1F/fQAI1Xrbi3tm35rj7
	 Fh+xt/kQ/UXXV8m2xADcfwZwwDiorlzPRGWyikrolUHLbl0GuclBGoM1WCpQUIsGSDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792417958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
	b=rT1LTrzS1SQGApCZdgxFHerPsu7/giCA2t9KoUGz0tZr0YU2Xki1hJd916oYcq3c32l0
	 raghwcLPvk7wm9o3IjgR+KagxXks2PtK1J496vh+KxjVKjnHQgjN6YyR2i1rjozptC8mT
	 SYofeEsl4q/upXjAs2ZiMDtVhwFsAwu4V0clzV9uHaTY5tRKNXMr+060UeYbjNLxKffEe
	 A/swlc/uvOT5b4ZEHiUPSo6yznM8KuF5zNVvQSuVWQ4FHo0TaVfJUh/VbyFMhs1G/BBaI
	 1m+PBqQ9cPoc5PCbgdrzQI/8/gnSmrfOLU76L+PFawMfGJlC+s7yaPTXjv/4Br6hjiA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ffJq6M9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792417958;
	bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SVnqmj1g/P6nL0nB3GBs3S/MPvw1gyZQ+PgTSQHIdexJysLIMjLfTtgq6e9356H9b
	 LZ5bQCAAS9xB/nhSNAPK091M0MhuldI2t7WlDxporx6V9JWXxRM1wkEKe6B1lvd44R
	 yAINowNGZUVqEKx+IZ+cprpRto5pLW+TaWPZRCA0vVgGKD+Uma09bsRQT7vGaQjWpz
	 wOvPEo2QDhC++EMbmWSEf8VD0f1ukQ0hYKQOvErEoWawbNf3togVqF6ZTfjBbyUFsg
	 sD1Iqlc887kqOAAMqZorx+ZoGnguMhw/nVjg+M/imdRKjUIz9NBBifQY5108kzlHaU
	 stzzwQCxQ4nyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9860480F8B;
	Mon, 19 Oct 2026 13:52:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A437A279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89E3380F84
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ya313lMCKR7s for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A62A980F80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792417957;
 b=Z01xay1FfUTOfAy7FLoFzeUlwAPwQAq6WntBjcBEuNGvmES0Bd7uM0bgTPB9rDOKRGtm
 tYszVCSHehPc4xWyP+kCQp/XrICakKN4MroU14JVv5Mn6ty+6ekdpzNeeaB0WmJ/P1yi5
 8KAkdXZaeQMp+MX2OkfkX3ELkc6KGzJLUzvRwYvT6pvkpXq+z8qM56gDFxBn5FaXnzHTE
 e8aqicym6Yoofhv72CEYtFv7uKOJePzR/+Cu67drkv3/hioavZlcpEaVRUqERFZUuc+lh
 o1je5AM4ApQaw7JI45R6rC3kGWiF7UziSGeV8RTynMZ5nkzHT6i+1lK/WGxXCs2p4yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792417957;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
 b=WuiDMGhCGuw1e19Stoto9YKBoB9LQ/I3xDxyuwDRLaIWh4bNbcRpi/UwjRBU/IIEmzjq
 a1lMDTftvLfOnO7AZ6M5+yJuczF6DnowLqBmVOdBp4HNyaoNOg/l0oQNQWSuXNa12SYEp
 peceH2ubAmXXcQ86TUv0rBIvN0Rw2ADRbHC7RJlWLwyGeeq2quEXJ+e22I+ErIpZrO24S
 m+qWLlYAYi/R2T+vYvIxbtMAJGXuZXnZ4F/DD8Ihbs/Mrb1smlpJQNjDZF6U2R9yB5CR4
 HpQoPwdCRb9TQcJT2Z8RLvgvy14xMTy0SbLrvN0C+ZULUAjNf6pL9D5yGC9Sp/Nuk+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ffJq6M9y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ffJq6M9y
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A62A980F80
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:52:36 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so3190811a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792417954; cv=none;
 d=google.com; s=arc-20260327;
 b=n9Fhw8Uj231QSTyHvHXEbgcQFehzfjX1EQs1gkQMxTW8/GSgliA7Xve1ZAOMwEcJnV
 SUmogpr7G+O6ZoqTDOQyIEy+VDj811pc38c7H2PoMxl6aPYXuhY5XS6jPLW8+z1Z4/9G
 SfXnlT3Pl1hv2fzTsQlNWaoL+cPDC2ZPD3fcZMVhO1mOq45AgKon43VBlw+elg6PlwC2
 ARVL56nAzykNEJZlPYUmfHCpuBT1CXwLfBe++J51Vs2cLbm1dW7QlyEAbI0RTXj6A5GW
 gusFChJFUmhYgZqeVo864o90muO3yz3geG6P7k5B0AxTDXzaNMJ1HBw5ON5ejcB/qEVC
 kOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
 fh=WQPG4xs3jtFIIyoWt/8TweWcYUyTJuvf+8WOa3kBdOE=;
 b=l/0mr1Bxl5RYV6JfQkK45dXTb5CIowTzrYsJcCTO76Lq0itCgNWdYtElgXZiNrcK8K
 gUsH+mPAvwlgqsk9edMDNZUALahjRBAb5Hv98SYdqgSmhjkrpazXR05Kq/kdAJ11IwcY
 yCipiBjR3ZrzLAY8+5qgdXvAPxFfGKLVEOfGMnNmX/Fl0oHD7tthSafWlLe4ZxEph2Tu
 ZgbswBSTTxk2hAOHHUsWKjxqoK2ZljwXXs4o08lsHbvw7e2O3OVA7/c2jwVPIOwYM2zV
 29c/UFzab3UWU4svgzwyuRfLmMYG8KR5oNMvxwEAmGMWgkpvmQnOdT35Q6kZWUtBKNWl
 yusg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792417954; x=1793022754;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
 b=ffJq6M9yhgbnnof5dXfhCEGZWwqmVL5lPI7ypM2H0lpwZps9xEzQ5f2D3Ma7Msb8M2
 D8KRgHWCvDVGPnzMvxc+FvVdXEZATmaU4zLHryTpCawdTl1tT4wpWCVJYg3FubuJBPgR
 fyos1+zi9espAqWyeGLDw4QCmUOGTV0jMqA3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792417954; x=1793022754;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
 b=I8jbve8JwCGW7AmT4UkCJjS0l44Bo8mMr4ty7Wd4TphIcODVQepKYPObtphzMgyfY1
 DNvCVG4TKAeHSYNapmqhVV8ZijQ5y8dv/LN6hqDHoURD3odUMECHDNWHEyVJfKrn6t/a
 tzuYKl6g0iaCwU02DBFUHyyg6Wj8y016CZfvQgjVInAfXGTcXghXKTq1z9QSLBumNduL
 Nb8d7BkIrDVGTiiyN57eFce6EAlzarv8vuY1LL31uVsL9rDw7++Bm8KM4n6RoahNwvRI
 iZ1H6xIdxdnf+HIGU5ikxJBEDL7oLlCuhkra8w2bRjppeEHBOxSPU7DDD/M7J8Cp3SJ2
 nQFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhbtiZARlVgV2uYuJiOY2zX45Vb3l2GBo2nGUbyua7sGsbYyO1d2i2p1ah9ZDVcPlHyLEXTHk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOmjrL0xr2aFCPGb0IHP3kgmy2rbI4wSdftwh9iYi8vPnuaRgM
 CUneMBVUvCt2ppordD8kHZ3xc4+8qYhoRfKV7Diq6gzeY0smhnL783Se98sHQW1IDgDNGxWfdOc
 vGRhn6JH2Y2KaljWJ98rrGCm4gZYU+yCfoKpN1XBg
X-Gm-Gg: AYBFou1UgP6y9gDff7lpiqVyc/srq9PoXlJ/gX2HVnDRVuYHxAtrVEHPb3UvlORiVUk
 NWXNrJyGdbGyHEa2fpKX+0qxInd4lT5czu3IZRmYJCpYEMXKlxdsH5OKoEKNlUe5Lmc6JlY0CuV
 IdmN/93bBfjN0rYvtsgrKJpnH9j17PpF/prddKjMWLi99E2cmXHUvIeR2isOL/HtFacIEKo1xCz
 pThyDj+uYexW0RFcw3hYUIvzHrYGXEQckdd8SAoUNHwGR9AhLxIizyLoZasNavQKoFfFxeOIel0
 ApwCIbSwDhGdGnfe+mc9eePmaikubYi7apGAaIZqxjtd/4YHn7lhjw==
X-Received: by 2002:a05:6402:4551:b0:6b1:b0f5:40e6 with SMTP id
 4fb4d7f45d1cf-6b3a818e3ecmr3554789a12.36.1792417954492; Mon, 19 Oct 2026
 06:52:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:52:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:52:29 -0700
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
 <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
 <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
Date: Mon, 19 Oct 2026 06:52:31 -0700
X-Gm-Features: AclHuK_S3Fxl5pfkshi2jbaQSyuqEfrdCqj0FbNMQDBlZObe0JKcA-N3fLhw_aY
Message-ID: <CAFLszTj_cjm9S=7UH_ggncMydYuCE-usOnh57iGuqMpcgZ9HYQ@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Reza,

Reza Kurniawan <imkyufie@gmail.com> wrote:

> Is changing 1 << bpix appropriate in this case? Since bpix is already set to
> VNBITS(priv->bpix), that bit shift shouldn't be aimed at calculating the bits
> out of a log2 bpp. Should this be left out?

You are right, sorry, I misread that one. 'bpix' there is already in
bits (from VNBITS()), so VNBITS() does not apply. Please leave it out.

As an aside, '1 << bpix' in that debug() looks wrong anyway (for a
32bpp display it overflows), but that is a pre-existing bug and not
for this series.

Regards,
Simon
