Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B824C61DD3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 01:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8B8940802;
	Wed,  2 Sep 2026 01:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l3PC-F1yIqst; Wed,  2 Sep 2026 01:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788313948;
	bh=v1B7iqNwTJPuVckhQlvtUPgLLYsH5DISvYVOoyw9vJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QtmF8PDgCNsHaEQdGJaxBahSHcLJ61tel0g8+XPBkIyGVZR/60wiQzNNz3EiblPfr
	 W7H0ILTKXLrlvFpLL/qFXyxrvKCK5sfxFkbvUyOnXymShMX3NIi19gE0lsCQBIQIg3
	 GVdgtivyhjqfW6hfC7L1Cz2mf521TYHvkhk4jW+t5jy8QItCvIgNLEGgE7Slk34iNP
	 XfLkJabeLvTUzRuGIowFIxNdyDpx+u/jsISpFNHrzIv32OA5dR8L4/mUHjaBWJmtpv
	 wVQekdVlpIvGo5jbpD8185scrYyEbC5jWuI6DNWkUw4ufOg4vp66pmNl46rFKS8Vw7
	 0XNH0Ojy3F2UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2F58407B2;
	Wed,  2 Sep 2026 01:52:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2790C2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18360407B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqieTg9WQkO4 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 01:52:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cvZOvhtP
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D57DC407AD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:52:25 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39c9a3acd40so3881541fa.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 18:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788313943; cv=none;
 d=google.com; s=arc-20260327;
 b=DmrrF6AJs36F30zyq/V5EUmwiVY1DdxSNc4Ho49BARaOkwSmxjvDIDsuinR4p9utd5
 +7VidukLzwCroHFXDzvMATjQ7gbt/UxkQ/N8pZFZgv1TbD3xIk5VXM+n1Us/QcQD1fbJ
 nfHRPo0pV/yG/uWVHy8MvjnVUbRPE4Olj39lXkUCXrbTwgCf09537HFFW8pAJDTfAeHD
 WZGT8CNVTOeNwVCF09w5Z8tlSh90ICCfU6D5N6i2iGJyagPIwvr/hZvYISYlOReRWhcR
 v8HbJZlUr8mKoJGmZdaSHrWG3d7YpYc/YDFlcEyqfMcmGdjS8uIaNi89vSM/rnCvdJkE
 C4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v1B7iqNwTJPuVckhQlvtUPgLLYsH5DISvYVOoyw9vJU=;
 fh=x36PVjtVPxakTvwYZbfBytfefzrjItbeyIPR7+L0Y6A=;
 b=j+WADEOQpYAOLsJ2PtdNRDE1lNxEuxGy77M3QBGDxcF7xKKDqt3lWgIY72awZ0Pl0m
 bwwjx4txrREWHv3J+XKMSEuuGdU3T7q9BkLT0dwUxN11wdo9Cae3xtqpx/ubpODTrHbU
 Oe59AQ+HuZCoHiNb2upVzhYocgIpGdRXhyLb/qnRXKj5xJqxnVZ6khnSj3v1dYj3/d6c
 IeoHNVcMjG9SEWIvm9HhD+PdNUQzScQ+mDuKXqrbNZJbye+PzDS5b6aMQjp4R/2nP21Z
 ADoucN/9iL3O1jAAxgaiivzLzl1sGeoFcvJzptKrp4lSze5L4LiM4X8nC3rKVJ3HANdh
 nfaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788313943; x=1788918743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v1B7iqNwTJPuVckhQlvtUPgLLYsH5DISvYVOoyw9vJU=;
 b=cvZOvhtPMLrzZbV+0275Ut0YoC5txdFMty/LZ+GknakylsD3EAVMVrkZKkizmTVX+A
 ozWwrL46qGjDOHNeFJq7ptjoGGAfjpjEVMbLQ8GcFbngRGC0ka2iHbiQW/J2q7MH4o6e
 2IUbrF9BDvhrwfWbZ/R/aYrLNjqN3r1M2cXIHAaf0fvj/2DKFea4PxRop93jrWiO80wA
 fkpR+gC/S8cytL2fsvuPLHwfv7c79sOhjoHFXwfIlimPpdcHxQmXdCPtu3nBV2wC46uE
 sgcDD1zbJBZ3RKLpiVcDpQAIhRyyuQ6KjXq8JpqQWAjiIDUBF66s67MCWLf64SxkEQtN
 qBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788313943; x=1788918743;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1B7iqNwTJPuVckhQlvtUPgLLYsH5DISvYVOoyw9vJU=;
 b=CXbxD2E7v8Au78R/ad4ksXx7omw9BCCpfYAdXRJGiFFV3Ouk+oikGkSY1VROa87tNS
 ajzPGvO+Cq4GXCln3SXYGK41DTnM5/Uc1zULJ38+WnXResLmXKNWYr8wBWYi9/QKrSqX
 v6/GqF5Q+L0s/OZcqPtdlhu6j0+8LcU1vjDvSljOuRMynvXfCJbYh5F3UizwaWO1R8Ao
 H0JBK7aS5M9e6TX0lNwUfMhun5L73y6xxapXhVwsPpCM3sxgQ9Lvzxt+gbTwkSCblOFK
 95oCMcqcjrfOxIrWdKRpV4uEWybCaEA3/Dptv5fhbcWbvx1BbJ9RTvxIegSAq9TY5mg7
 Ckow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhNOFPkmyanrs1pHlWYYlWlIJrlDsvxD05FD/9SJCriwZ4emn0wN6Rps63V5erBQj4+mdmcV4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nJz3CEht1MIQD+XRrmcUQi/ZRH7ecv7/Bp4MPuxQ+9tW/q1WaI
 LXf/f2zsxO5V+huXygJPca3T20z2GE2mLqukkf3YSaYgKw7XI3WjivuG6pk2LYFT/E5T/PHT6//
 hEjCuNGyfKXgHMZBBRuf+aUWgRRgRMOOnQeluAEKzIQ==
X-Gm-Gg: AYBFou2b1wG6CZbgGYuLNZTRMJtdit23Ykk0xPKCnm1v52lhldpYOJ0IMLM/Fm8KQTD
 ZUwzNkmBFsKh+RBdzZhioZBhKXvQN5kGLNzcyzTxT0GJc+IPYAJCeDkrhFRyjogL6z45uqK285T
 lasgDTDZAJ6HSL2MSMhlZLzSg/idRQjn219ZCy+SzdMQDfTVxiR7hYEfdWiYZpXZcEesnrL98Gt
 n7pQC639hYzsga1OV46iCxYB5FoiwMG65a86Z54Qnx6oLCY0IdKHIptiRsMzY14RnH7RP8bfP3h
 Duac3Wzk256yIXsGzr2tKagHongrI5xERp34EPmxEK0SzSJH27bggCSiB90UENrE/sxHUFJFbZ2
 Sxw5N5jRdnW6KZh+akzboFtrdf4V6I/WDA0lBJkHmytFnPrIT+dzBxiwg1deg1Grs3SJ7qXu0Fc
 FE1w==
X-Received: by 2002:a05:6512:31c4:b0:5b4:5846:d925 with SMTP id
 2adb3069b0e04-5b60869986amr483941e87.21.1788313942053; Tue, 01 Sep 2026
 18:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
In-Reply-To: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 2 Sep 2026 09:52:10 +0800
X-Gm-Features: AcwNN1UTV_UO63GNT54L8UWuav-dZ-J0s2VFNdybzKh5DJdDcLECF9SpStfOuXk
Message-ID: <CAH22mJykqkR_R3KYvy0yFiyvdvmDKHeYaZCOX8=BpBxOsquLXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: fix on Spacemit K1 SoC
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, 
 Huan Zhou <pericycle.cc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
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

On Mon, Aug 24, 2026 at 4:14=E2=80=AFPM Eric Chung <eric.chung@riscstar.com=
> wrote:
>
> - Add IO power domain control register programming via APBC block with
>   ASAR unlocking for dual-voltage GPIO banks (3.3V/1.8V switching)
> - Fix drive strength configuration: use FIELD_PREP(), preserve io_type,
>   return correct pin number, and remove redundant initialization
>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> ---
> Eric Chung (2):
>       pinctrl: k1: fix drive strength configuration
>       pinctrl: k1: add IO power domain configuration support
>
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 107 ++++++++++++++++++++++++++++=
+++---
>  1 file changed, 100 insertions(+), 7 deletions(-)
> ---
> base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
> change-id: 20260824-pinctrl-718fe50eb9f8
>

Hi Tim, Leo & Yao,

Could this patch set be merged now?


> Best regards,
> --
> Eric Chung <eric.chung@riscstar.com>
>
