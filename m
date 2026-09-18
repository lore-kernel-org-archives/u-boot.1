Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B8C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 22:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF9DE40CFD;
	Fri, 18 Sep 2026 22:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LqWsMLnyD4G6; Fri, 18 Sep 2026 22:40:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ECD2040CD1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789771207;
	b=V1sfG/lcCyKUdtspctCsUPOTkl7G8hqZJ4NfDVoMnUCWPATeh0djYL8iYxsqruVYoGD4
	 WYpcOu/km/rl2HEKQ0OBv5OrUBTUnnKapGd+qyn3uegOmvO8YF15y4iksY/9aZGuw7u2G
	 908x2aF0wo64Lo2KTLaYBL660d1jJW6oQakCMd5v8ObxjN+5nmpspuDsgq8iuFTRSSIk7
	 gkTpFRGFd8h5iGPAKPeQUJ3TgRCnpwx+dvOqshN6n+OalUfE6sg/WUXCC7C/cexN8GYiN
	 veDZ4OZS9warQAcIWIS0ULVCGUaoofLmQRDKEyqHMX6aoHBM/7p9r8w98CzPgPr7S/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789771207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
	b=nTA5U3Ur7PWQMbTeCNAQBINUhl3dTTRhvR0tNq1bFqhYqtjCZNwsg6SKoya35pNXLtQE
	 0hj53AnyHXuRoLT6IHVziKpNAkhm429lmQqA6x0sgQxMHhAd5aRhrI91u62XB75GqyMfi
	 kr3DmJHJWV/MErS3AxwsxvTrF/WPf5I97RmFQjYZkVVT2HJ3D+q9WXFdkoY+uXGOKkdkp
	 dS2Dj8neQ6IsjIqVReS1qAJa1gsT5xE/loWens/gdpn0o1UA9uA6QxDRaYvpw7w40BIpV
	 WvF0wAsCX4LbLetBOJATPAlkkObRDk5UTwpTXknk5j+9pnxrDdPCdUS63ysb7WHLu5Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="id4/8uP/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789771207;
	bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxieEaEALGdr9I+IasFPhC0hjD3IJZmuWHpAk6+CWceXuZ/WdqBuFQSvhau2Rbeuv
	 OzgLMOssg8dQ8l10XOuXQj2oCe7ZxAI7t1NeVkWnPt7Ng2AzBZwhcDe62YpLph4Ii2
	 XPiinfcsY8IC0/QTLQmy9Nech4+9U2hNlUXkV51XRtPNvRkZXRks1UMnmqZy9sXG1C
	 2ReaqJcnCDLadoolyS6L2eBK+i6kSVo+9am5K4UBw9YKLEXtq8+RNOEKw411RbGp1+
	 517tSos38IBJvimMPAqnJOXf9j4UJZKOZCZb3F4PsFaJU+kMuFfl5ACNDSx9vj5goz
	 gjW/62uJZR7vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECD2040CD1;
	Fri, 18 Sep 2026 22:40:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD36329B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C394440CD1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRMXdYYS2BDi for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 22:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B194D40CC3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789771205;
 b=E9Ez3c2tPpi0ff9hQ8vyy4drf+tnjtxapky8vmbr8JSG3EO27T9wNTwNi+oDEH070R8W
 ev9hUelqlEk/JTKxsFb06ac7gSpvU7r2W0dMJ8jPc9noTEJ2A5/Znvnb0HQNTRdkLhv10
 dg0Vlu/kFjb5GSZvU1H55EXu6oZTWbTXkh0jNayDn/dq4hH1CydEBjYumgWEGjyKmCikl
 LZ88m4xFieModReZT6SfgiDQhU4tv4gZHLTsxHBmRfiiesbKJavEf0V1nFS/48YObij1t
 PSzwL6Q/EEzmPsD9uy0v/GfOaw6J5PNYLPEug6kulG04KjNPpl3YwOtIK1TUuey4FZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789771205;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
 b=Z5zjHX3Rd5AnLLAXTBg/iK43RvOd/+OHttWp/WULFPkQFCGeFhhvxbvLA+ckm66fHla2
 PE1T1MRPLDdvPR6sC5MTuSeoKYM8ZOa8Vh1Zk7CIyvcznze82BWpMel8okxA88cYk+Ojg
 OvITaYwtSCqamqrvVNFT+rg4fIkL8P3Qh49M5Vlsm9x6H4s5hpHVulq9vtmlXsYWAOpIO
 QBy6fePACDV2K53fKz5qiOaIEpjr5m5xiZpkWZsniGmRTHB5By1QY49LCE+lGKyE//pKz
 m6lxPpyiqSfvvrpj4FGb7m+r+jj0D5AF3fgz+TlWaxjKHg/uT9ySkObVsqTlbQ37QJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="id4/8uP/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=id4/8uP/
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B194D40CC3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:40:03 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so1981193a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789771201; cv=none;
 d=google.com; s=arc-20260327;
 b=nRj06s18wIDGvTiGeEMHGOgJjyVrtV/aZ3aHMgl5gRzyr6cyaYQPAQKmuYicXR/7Ss
 FQczglkWg3sRwSjonMFxudkS/QTGqPJfmcYIqedA7RMQD23sKWEwIbgfWDIqulMuv4o/
 FcNVzoqP1Mw/M+XUkB4sedQwGK7dtKk3FDDk+f21ZKWhGQC3jUyrr3wZzjrSll9rsBpx
 lvyVR752pLB+Uss+Vq/0rG+rqisnF0ASEE+cemUA1yne5ygWthv1zhMI/rR0vZYY1pVi
 M/IUaLrKqm2i3QhFIOH/fho+V8uJQIPlZPzGuINCAokuAWvYHVXupq/erMsqkLFePDWd
 /vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
 fh=Ph3WjIDpSrKnlC/d25moCNQ1ILuMDszZstrZJCE/55E=;
 b=R+R124UT0Wdx7BiGfzDDhgJwFt90hy6zno8+b53/ChGWJIw9btgHvDTxCwm+ciQugX
 9QR2EtKVtdtdZaErEowq/MIQmc7EFwJsspy/qd2Lmk4PfVy8Ulx2q8JHfEVEBI/mlM7u
 EvXcArtR6xZP5z9/vs8xhYg2KFIh/YPioI59KiPNABgzuJOn8cpIvpvj3lQQbakZMoeb
 WXCduovqEqt7bqcGgC3WtNZ4EmadJ7BQYPqtgHEvV/jNhVVzdcdo2b7DRPoGM1Y+kFCi
 4N5wQxg2cFF/i9sv+pu49bjE8Cg3+RZukjOW+5oUcLl/8GOZkLBHqhn67tPkP3vxbzEP
 BW8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789771201; x=1790376001;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
 b=id4/8uP/nIO9vPtpJL0NXE5v72yHdfHKvQxTzXvQNBbZyiUxV1DMsjXTMWWxv9G7h6
 I9K6uA/vhi3+STHPNIX/gbNqqzaQExQcGdkl1pmHhSSNKTwbvEb0HPphrJc7myvbcR0J
 xkCRXKwY2a653Mt2dgs4gWbUnnhaGmCFEBFVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789771201; x=1790376001;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n5G513fQZnenzlKF/Q/TuJ89q/vI8ZI3yCiGfOVc+fE=;
 b=vbSHNRmoauLDxi/1fMrVE9WfNoQ6MPomWwvAErypSqSAnTtriq/GM2Rl74D+cn2ehY
 bD/jxON6OSkb6MJnJ9MC4rDYgr3d/54IQi30jpMaPiikBhvVgs3/sdbC3+1qajjuulKA
 N5+9hj7jvviL8an/8JD25QeTCpxmeRBH/P/BZulYXmUZmaf4HcmewNT6GVb1ZZxIYF4O
 jgwevXZWQJq8Xso140Fx0QZdi4LwVzLV36hwNyIjf3osPGhm7ZQ+D7EBQA0Zkd1z2FvA
 S9xJ3veW5KPtaDBxQCOJlBYQPTaUUuZ4CFTKdmMnnRrzRP4Bb+4UYtqokmHlN9X2oegg
 lnEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD9mVYnyrLwn8TixbJgNtfxQCHyCTXkgR2XWaCbwUBLPElYTldS+xZWCKRSWgTIJLzZ6H4t2A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++myhyWU9qLuF7N5VeKvGi4A2gKdjUkhK09xQ5ql0/D1ebRVI78e
 rUlF45CGeulX2KI8prpuRtpT9ZcDof2obbdR77IrQwuHJQYHofoxoC5a1yAgeILYtO9Cj8qZcxx
 luR9+o70dflrmOeb8R7S0cRmulOR7Qx1oGCj8E2Z6
X-Gm-Gg: AYBFou1chZb131w6QuI3LjL+pxmfxdLt7/GcNraqEyNnoOvD5ZUoJmjWdddDt4OFvwy
 V8CulhwOwHy/+9EEW2Ivuq2vWs0q7pLgeGzXHD2oEmGdQObovt6k9AKs76ZsedXMKPQNIhgfpMG
 C9jAXld9KykmP3VXErSMO50w/nWzDcD1P8mwu4yKn9XWnb3GuSoaIYcGEk4fhFboPost4mIwLtL
 W8aR+CtpvO6I0Wv/cJRAIcvPLbpcj0QJHdhxzlLiVwFxBNfAXIxAiBqKJ5U4zoTFUsFZzHqQA3h
 jlhuaaY3ADTgn508kGttFt1RSp4D/cL/cGTTZlnpxI1Lv5OXsmRsoL0J
X-Received: by 2002:a05:6402:1ece:b0:6a1:7825:5230 with SMTP id
 4fb4d7f45d1cf-6aa5781925amr2415021a12.16.1789771201613; Fri, 18 Sep 2026
 15:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
 <CAFLszTgGNjf2TLT3joC2P2b3c-iA-affy5SrbjXyM-FA_c89UA@mail.gmail.com>
 <20260918214154.GV858934@bill-the-cat>
In-Reply-To: <20260918214154.GV858934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 17:39:48 -0500
X-Gm-Features: AcwNN1XgFO4S9F7tQ2j5PK8oSprkAcQvfrXLOLGyvnP7rU7iekR6Iu6qAzgx3gE
Message-ID: <CAFLszTi3VkJRmRGn_7ZMWGM8RH4RjB9spa1_A0MsheGO8GYOnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
To: Tom Rini <trini@konsulko.com>
Cc: jstephan@baylibre.com, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com, 
 u-boot@lists.u-boot-project.org
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

Hi Tom,

On Fri, 18 Sept 2026 at 16:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 18, 2026 at 03:49:44PM -0500, Simon Glass wrote:
> > Hi Julien,
> >
> > On 2026-09-01T08:52:42, Julien Stephan <jstephan@baylibre.com> wrote:
> > > video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO
> > >
> > > Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> > > at link time:
> > >
> > >   video-uclass.o: in function `video_get_u_boot_logo':
> > >   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
> > >
> > > The __splash_u_boot_logo_begin/_end symbols are provided by
> > > u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
> > >
> > >   obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
> > >
> > > video_get_u_boot_logo() and show_splash() reference those symbols
> > > unconditionally, so with the logo disabled the reference is left
> > > dangling. show_splash() alone would be dead-code eliminated (it is
> > > static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> > > but video_get_u_boot_logo() is an exported function and is always
> > > emitted.
> > >
> > > Guard the splash helpers and their symbol references with
> > > CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> > > video_get_u_boot_logo() stub returning NULL for the disabled case in
> > > video.h. Callers already handle a NULL logo pointer (e.g.
> > > bootflow_menu.c), so no caller changes are needed.
> > >
> > > Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> > > enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
> >
> > I won't comment on the word order / mixed tenses.
> >
> > > [...]
> > >
> > > drivers/video/video-uclass.c | 7 +++++--
> > >  include/video.h              | 9 ++++++++-
> > >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > > diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> > > @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
> > >       return priv->ysize;
> > >  }
> > >
> > > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> > >  #define SPLASH_DECL(_name) \
> > >       extern u8 __splash_ ## _name ## _begin[]; \
> > >       extern u8 __splash_ ## _name ## _end[]
> >
> > We try to avoid #ifdef in .c files and prefer if
> > (CONFIG_IS_ENABLED(...)) so both branches are compile-checked. The
> > SPLASH_DECL externs do need the preprocessor guard since the linker
> > symbols don't exist, but the guard around show_splash() and its call
> > site in video_post_probe() could be avoided by keeping show_splash()
> > defined and providing an #else stub that returns 0. The existing if
> > (CONFIG_IS_ENABLED(VIDEO_LOGO) && ...) at the caller can then stay.
> >
> > > diff --git a/include/video.h b/include/video.h
> > > @@ -418,9 +418,16 @@ bool video_is_active(void);
> > >  /**
> > >   * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
> > >   *
> > > - * Returns: Pointer to logo
> > > + * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
> > >   */
> >
> > The stub is guarded with CONFIG_IS_ENABLED(VIDEO_LOGO), so the doc
> > should refer to VIDEO_LOGO in general terms - SPL may have it disabled
> > while proper enables it. Something like 'Returns: Pointer to logo, or
> > NULL if VIDEO_LOGO is not enabled in this phase'.
>
> Simon, can you please make sure you're looking at both the current
> version, and previous feedback, when commenting on older patches?
> There's been a v2 for about 2 weeks. Thanks.

Ooops, yes will do.

Regards,
Simon
