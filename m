Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8405EC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 11:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9EE540891;
	Thu, 23 Jul 2026 11:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2El-XY8TqvDs; Thu, 23 Jul 2026 11:32:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E203740795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784806334;
	bh=jPzZ1JMuiYsBUq7VKPOiY/HFeq8BWlCUlpUESwRbMXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CtBmt6Rjh203/BQETN0Z51zBfsuJ5w27zB1wvG/zpQfYFadIG06ayYMmw9VDd20NG
	 GLJ53SbT8CwhhAAY1oAorvhxihGYzJh006xmsQ1lgmXUdBube8+4xX9DAnNtBOH0mA
	 h8uDBbPlyE0AVer9CkcAl9wR8Ge0hRvs5SwWRY7jdDOr3gqOi+5BPo+nwTCAMxRC66
	 g1vSSQIX1akcA1qwnU/myuUtNiXqzN+pf9QZy6vohTs+K6ZlxnE2sn9mv7NiNR09RK
	 0/wNfQDdkNbhlhVzbTAuIJynG8TGnEq2ggyutn9Wm1QofVAmA6zXTK/VJsq3vEgxnT
	 EAeDIq0raKHvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E203740795;
	Thu, 23 Jul 2026 11:32:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05B741B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB948608DD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RA9OStz2Uy1 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 11:32:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 92A0D60618
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92A0D60618
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92A0D60618
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:32:10 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39b22d0e488so4398351fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784806328; cv=none;
 d=google.com; s=arc-20260327;
 b=P+9LnjTqZfI6IprAdENwt869joffqL7+zHDoLm4pCLf83CA9C8q22zU0WT4TQIxCOu
 xiNRyvE0M1NKA3yyt/qeVT+RBr5xsNKJDgJYgz/0xK9I3cY3Ax0zdFDK/bC1ORnm2vjz
 6sns5dMflIwX9tapwLydZyJedBRlQQSL+V3u5kA6s4BY3eAqEIvJMPxAX5YKfwx49gmn
 b+IS5po4JwyYCB6ssoCZdCHMTOyGGR2H+rtaUbq8D61Aizk1Ox68pCMyav3uyiUzlwqz
 3Ic98wcPM9MYf70jh4PuryL8NBNZeeGt/kZRBCWqexnA6Nms5hxY1bacTUg4YeRmsGh/
 T8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jPzZ1JMuiYsBUq7VKPOiY/HFeq8BWlCUlpUESwRbMXc=;
 fh=j50A/xKtUd72OQclrUotalEg/PAv91Ne1fgVO7q4Sf0=;
 b=miNTCfviBMD77ZL0XTz2sZ7USJhHe9ab8uXvKwYU+RI6J4dYWKyZB8Aw8RaEO5YihE
 P8QQE2WT4tncg/fKCMwaEIxnkYdqnul+esteaBS8hVBSYZpC92FM7XcWgLun04k41xaJ
 5fkqBmbXH4k4MoeVqmF5wP8JEeSWCvjpInXQZUhiMBYrlK0/yQbZN3vz9ruGl0R1sOxl
 waECET/rvy1X0J95A7G+BwtTFMeo/Wc3Q/bKYPhOiODIylY8WyPERuyMxYVnoLlQOeh5
 1EwOMoEf6ZBY3rzTVMbXlcOC88Aq/6xtOoau/eWkle46QhQejCoZjtvFClv8+79q/mN9
 KxJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784806328; x=1785411128;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jPzZ1JMuiYsBUq7VKPOiY/HFeq8BWlCUlpUESwRbMXc=;
 b=YsxXgfxf9QHxtDeZwVELU9duTtG2y6tvzBlpD+kPrTl/r77sA5QumnLHsTN7S1LXhX
 UXY6OFiPn3gr9u6XaNnVey6SQHsWSDd+9F+qgo+ui8gG0kPb1JV0MpJvLh0dpjJOE/kr
 IyAak8zX/54TQkbwzlwDF2SnShPwklYirx9YskC3PyezL5PX8q0fTfcaJUjNdXmNxQtd
 7DuK9zaMmVzBba7uD8SD5szRb73IdLI+itXnHF8qGtt3T8V9AZhrYZPKw+9oqj1vVA3b
 GDy8L536GXPHEh39PfVmfPFs5JsSAZ0kUgAt9R8rVEoA5h+QeDXWE4IPTfVoru6Pu22E
 ug/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6EvMmOZM/8YBMf7cGRUPK/sSXh9i514wPvcEvIMbG9GR4SLbx2sBffc6tkVIrwT8EI66yXI0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz3nZhIVKGLZUe+IKC2vOlnAP5EfM3nU9JyM78cC5aKtmX1rVAl
 r13GACxtKAlPHYtacxXAbcku+qPrCbY9OHLDnGisKnOQ+QZ8WhmN3oL3PScq5bUs5nXnL0pyd1G
 wcGrLcf+7IMOsVV2xsif/gF+RMV91Ihc=
X-Gm-Gg: AR+sD13U769+wmg2c+ur+1yPvbMwcXfBaDLpTLkTM31SkRhWJvb8dLyjewhhd4/vELG
 1iXr61DFbvRtX6y3gM3hjwoqb/4BPhKlawomnvuWqTtSPLb3BfIKejdrRuRmJ394yD+FczcA6Q3
 Z/6juzTOzikyeDVikQSf4Sh7Fx9va6haJJSLsywpHPe2YOke1F0rPfSZhmBM9bahOt3u702pZnD
 2MxS+8+lqPRMKnZSOlx1FF+QkBKTIHCJ42eiLT3HL/5ZOJQ2EdJQB4tYFrq62NZiO4FRuopSCNB
 jgcem4ukDTVZAXB8TeVE0WezWX49Gt6dAXMIDBmrXXNYx/pkYxuUE0oeT5P+
X-Received: by 2002:a2e:9e53:0:b0:39c:8f36:80ee with SMTP id
 38308e7fff4ca-39f07c671f6mr3550721fa.24.1784806327833; Thu, 23 Jul 2026
 04:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260722184024.1210447-1-festevam@gmail.com>
 <e26ee0a6-5220-43b3-9846-7b594c4c4f85@cherry.de>
In-Reply-To: <e26ee0a6-5220-43b3-9846-7b594c4c4f85@cherry.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2026 08:31:56 -0300
X-Gm-Features: AUfX_myCbIL6uqQwTu3w0S2EK-V6MmzfHYvhWemSrDG9-AgQfM63Lmt1k1X_Zik
Message-ID: <CAOMZO5AGM3Lm5=rfECDnkgwokTOxb=T9ww3+gqS9wdXpm-bQ+w@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: rk3588s: Add support for ROC-PC-RK3588S
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com, 
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784806328; x=1785411128;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jPzZ1JMuiYsBUq7VKPOiY/HFeq8BWlCUlpUESwRbMXc=;
 b=GMcgKaQKl/hTR2cDXLtwF9t1wIZoDUFwaTvuT1ZvIMYKFhqQKIXvOFJBcHaQnkFeKx
 P1ZXB8quDTOKpNQMI2LuuLTjBX43k+ia2v5lCwUMDlmfocEkq4rwPg+6mGu7KiJ3Zhf0
 /WgCGiy7Yk9Q75M9dSEKyIjZY47/GNonBGm4CIp5tdMho/JijsU/bwq1ocJVx2uWen48
 J0WsPBKW9+tj5DEATC3D1xaUsxOkvkvkLtUJOQzkMKjFYVpElBQph9eQ4BfWI1cceOcc
 3e4mhZ2aR02Cu/ziDShI8Wrz9WRaufscdDOvMhmAyPCtDIFrjfUiMXYmXAuy1KxuXM/G
 qNOw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GMcgKaQK
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Thu, Jul 23, 2026 at 7:01=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:

> Just to be sure this isn't an oversight, DWC3 is used for
> usb_host0_xhci, which is enabled on ROC-PC-RK3588S. I see there are a
> USB-A port marked as USB3 on the product datasheet, and also USB OTG
> that is capable of doing USB3. I couldn't quickly find schematics to
> verify what's what, so does the full USB-A marked as being USB3 capable
> still working?

Personally, I am not using any of the two USB host ports in U-Boot.

USB host support in U-Boot can be added later if someone needs it.

> It's actually ROC-RK3588S-PC (c.f.
> https://wiki.t-firefly.com/en/ROC-RK3588S-PC/), I can fix this up when
> applying if you want, if there's no need for a v4 based on feedback above=
.

Please fix this up while applying.

Thanks.
