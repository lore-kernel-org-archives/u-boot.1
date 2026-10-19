Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF44CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B6580A89;
	Mon, 19 Oct 2026 09:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEeedgn9kJb6; Mon, 19 Oct 2026 09:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68D8380892
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401823;
	b=kys2mlHLsVxXf24CMqos4OL/Ne97sQM+PD04QukRpu9haic5D06cA7mAGLm5MJHeAHFQ
	 /MUkrulKish7FpopQx7HQq/1DGOdNSzR3x/eeq1CFD6DTqIjfj2wu5azNKrFF+cNnunzy
	 KvVvkhgxcqfJuzsEyBvCPsYV2kr19V4l0zoOyZhsgweKz485Zwnv5Y3H1M0TyOy7LIMsI
	 SsPCMB/Es5YyaSmXsJlt4yqi+mlvqCItZX3Y/BSPAb1mtFj5gPAKMz1sIZA1RjpFRUZoW
	 QZfJeLFk65SMP5HoIv/6TIljEWJSfmNvMBMZP0kHneRBPCFVrDAsfyZbfKzyX4Cm0OA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
	b=nRjm4s145M7DhkkV+bArk8ulQfB5TefpvdzKHap7czHryeytrvpxGFvUjygBA6szU4KH
	 KG/UNnxAm1QqrhneHX/unPWZZ5Ck4kM/O7A8O/myMlpej2VNRGJUUgaomkOEw5oYrVWgP
	 JWAsQXHfOpRd8JDQWWq0YZibAvJTfo2F6QCnx7F3q0vdvNanU39KvEymJ+qbbyHxJxD0L
	 prozqm2v20OKxRHWOQZyDAAnzX8yZjgutPpV7RytBxgE1E3h+vwK5neQz56O7DbzJvZ0a
	 A4h+bhGHvVny+5BkEKtmImyEE/DxqCjqQWktVeAxGNjlqgfwknJOrNgUVVuGp9YVn4Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401823;
	bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O5ygbOca2zo7gZ0QJabblbjVz26bI2yK1shhdJmS+v/+e2L+XYKa2WurxPxL98lpS
	 QuOxUZaychQ+BXQaiDTQKs6XJVY+idRiWgeAfCPWv57Y78WrPH80lwcBwI//wnbG5m
	 Ou+QiRzAmXgssOJUUvMu1O+aepvBxrhx4MMRQZoEWgwgkpFBhrg5Wu2o/l7RSDJe6u
	 3mzSk/SnX1z5IKrePrgvhMffhmYBmFNW+8PHKp8kCaWpunbNEUFB5s9j7775X8qmeV
	 zQGSnICpmRXmfQ2omngfuh2++qas7Da1IMnVey+A1KMdznFHWSpD9FUr+x2pgM2YV/
	 wEYY0eTzvdC3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68D8380892;
	Mon, 19 Oct 2026 09:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 434111DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29012406FA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAeKXfFeEVJi for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27173406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401821;
 b=YM878bzfq906ufHRLTNSrKiDaX1pZE1XjrVxbp64b4txBCA8OF22tXu0UloZPK4suvWP
 rfeIGe6fptYh0yRBbI5MvtETzORA8FY9GW3Kp2A4yVQQMUi8JUVQOK/BWPmF/M1B/hUlX
 yKE/WwvU3hlOog3CvBgL6gFliGO/PRUQRBnAaUk8wZDKDew6NCLaP8zi0EMgaJ2JjA8pd
 bLqPPqmf/hZQbXUG2T8w9CRXeLWp5vNBLGidNEnY5fgzcNh/RROfdDLHDEm+DiXWT+vmi
 IbHcmbLYMphe5/ZIuUYWoA8YCgGGUwtHVF4M9Y9X5XguXuHwHXZmsWOesM8vE2PGuCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401821;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
 b=pGKrT55srr9Rp63PQPLj7ii+pU2wUkcSspc0joL0haz0xdbF8C1tYmw3vYAhVUOvYMZ8
 YU6l1VWPy8GZalQTAwW1jpqtkrDInPlglcrkLBx3hydTZvNdPxj4cweodhSTibPGTDMSL
 YHvHOk1F1Ja8qkadPyEbitN1QM9OvjyJZ/RKIT55h89fOOTyoJbF541spcKVQ2FrzXjIb
 sTg3deT/S/tVTPcCE2hDWq7TL9Z1ZbZkcO9kLFulgPElefTbCU07SGbIzbbr8shkEKfp5
 yy/VQR3us8aCq3UyH9xHoaN3z0+DrCPGDJa69WGbcEvPP3GCwVU2LNIIQzVcXieplGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NwiVdsLX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NwiVdsLX
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27173406E0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:40 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6ae27f06c2fso3069598a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401818; cv=none;
 d=google.com; s=arc-20260327;
 b=PS9y4LGb2VLmzQLDMQzotyzlO3F9YtHmITjRQrDSZdy2jaGwWwCDpE+ZziwkCsRJIo
 xsln5UTTaMfF8g2q1y9o9rjySIwdl0HGR7JlY8ChhGChjvBdPfoxyirMM19ktQ/C24Nu
 ih38sfzci/KUvqdX7wNHzORO+ZO/ALnxItmtoxi89WRbQTP/uh0R9sJie68MRWwKFggP
 D5H6k7z0wywfgn5rowvWqbMf4P+is6AGz9GBRZLWpC0FZdYbXrMY+iGYI7dz+hdSjrem
 pqYFRsTSwrlyEXXmLnmWkNa3or+0QUseCP8fbOktBSN/RYRuO/qYve0mllohw1UGI/Mn
 EwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=KLsWAJ/U0SOOaZ7cvardWh9fkzY8biMEvI1Ypy3b5lYHcpfehpRfcR3hjrYYUtXZ6B
 q+eQ54EcgKS0Obc1PsC4wUl6jaxxR4xD7XHkfObEkNLXhj7eiNSFdxSQPh7q/8vY57RU
 HzxubMiTEyq20bj8ZMewiJHQ+LTTmGM6Df/HLqOqH/wJ4hpEshHpHSX1G2WoUOxu0hkF
 /ge1dhZb3GnUVbj0eipRh6/c4i95jXEZgF/4b5es2vGY0MhCJ21hJl2gE8ycIm1YmRxD
 OTtp5YuKI17PeP0iWfbIfQOrsACwvpwSCmex0jdXCRA+ZGCDCfqcuxIMFZPU56lJ6ecs
 jXtA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401818; x=1793006618;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
 b=NwiVdsLXJNPiQrmRcguAHLihEUSyYi8nt66iZA06w/y2iAUjkg8VsQp4OMsHpCzgHg
 n/i1XpqrIypTXT94gJi3gb7p034r8t5en8VfXrjRU/f2VWaFZF+mh3oaX9sRqWlNPagb
 LN619OvLReWrlQq17cu5hHdfgLDAJUvCDDkpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401818; x=1793006618;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+y+NtOko0V4+IWXAFPNBXlKsboK0HUYj2HN9CiPVsQo=;
 b=P8BCWK3pYEWe6W2EQtt1U3D6aKJXzifpgFl0pbINVleYPcv6BexjW5WJDDrNAP0QNA
 zeEl33ZLxwHylVbVOrzR861+L7Sl+0tPEZeJZWdMJbUqgrLlU8V0Ll8QD8JL15ig1sk5
 KFO/j+5dFJSo1vhLTGl4Qz37pgmTS0V36lz3XGJg9h4rEzE0YiW+BazLGNTY0KAT1rNy
 HImakHxs3hYuXR15ytjK8rvKGDOgt02VuVFz9JhFwAuF+qYEKTT+ZZzRC3p3327+H7ew
 rINr+kxvih0qockmMo5KwE5GJY3EJ+KkEEQjOwirBWv4cByOW1p+L+IWLyHY7Zi0lgIo
 3hOA==
X-Gm-Message-State: AFq9FYJIEdAgXJX+/szzLAldevfiFr+Eip4lh8ikqcdNW+xbDFM1vsCw
 bQKObYTUG26uFICeXnywN/1iNIxWDhByL5yVBD0QqH0iuAfKsklfFj0wKDqMrFteUQ9ErN9C3UU
 7RiF8U9lR/ZCTrQJ7wov9W/DmW2fjXyOWF04O86VG
X-Gm-Gg: AYBFou0rtcw7GAu+yszw9rnQ7Xmewy4qh6an0andvi9f/mdeaxE0Zqy2Blyp0GUHXMq
 Q3E6tIZEM+443BUUc0uKVjHFbydPHRm3mH4QMnE7sj8fFBpmjyjz39J1bhGx/baFcprw8EodSNK
 5I0iRjv28PGgepYP9HSJrO6evqSgUEuyesPt1a0jteQN44XgzMrlRksVvuoN7hR2tciZaIeYMRL
 sOwMnsz1/x92/sr/jdtcdr4a2hutjznnm2rqfY/q6zmtns8tkqVCFH4Cn1kcM/rQZUW6ki81Bsn
 h46eFR5d4pqJjWDs2pzrf2VuomcB77Fcl1TkjKnJ/CMZFw4psfe6jS9NYLxc7gBn
X-Received: by 2002:a05:6402:2402:b0:6b1:b17a:de82 with SMTP id
 4fb4d7f45d1cf-6b3a82133a7mr4021100a12.38.1792401818435; Mon, 19 Oct 2026
 02:23:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:23:36 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 06:36:28 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-1-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-1-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 05:23:36 -0400
X-Gm-Features: AclHuK_HIN4YVijG5p6kGdIJ8ZLaUvLhU2tXY1QQpikR72-Q3jhIRypD1HjGuGo
Message-ID: <CAFLszTjBHAYZiDGzhn1gh3tC3hrEB9OAtG_aE_bPNEAnjaVpEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] binman: Factor out the compression bintool lookup
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
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

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: Factor out the compression bintool lookup
>
> Move the compression-algorithm-to-bintool mapping out of
> Entry.AddBintools() into get_comp_bintool_name() so that
> it can be shared with other etypes.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/entry.py | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
