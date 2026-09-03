Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F10DC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 15:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B4A660B8C;
	Thu,  3 Sep 2026 15:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VzRIOsgczI8; Thu,  3 Sep 2026 15:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C76C60B6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450190;
	b=EvE2FUd+pWuvIOL4AxAlgdA7ewqnSlnMvKDC1w9Mh1to6xivIkiOchKa9ls0aF2+vQCB
	 HHIPHpt5jCKJk6UTzABlk9ulmJ7BLQnsRoxdelNPlF8mW3FyVQDjHUP7xnxEwLc+J6Vka
	 MgjYslhxhlwCBoyKwOhyxgV45m2Fh0pkHpZkF6SpV5Zx/Wl/pU2U4DMgFW0eCimNv69Eb
	 A1i1XWDuqYHcX4dUiSSBYAslgDy76Xa5hRrBTv0ciGUAekNGZMBz80u19kcDqM2YHdX3+
	 BcmKEAJDqWVOoINUTb2dvRy4k5KTZZYmpDvjmHlw5d9KeIaXQI9XLHhpArpsp7vGbCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788450190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
	b=M47w2/H4xAlz9uptpwl8jcTndj0mwnNysx2D2kKL3y01hbyFEfZTcqhgoGU69WvfIqIM
	 BqrzeXCHvnRgEAONFGRh0iCn9hLWEXrjzTMWLBAqvxjCkF+iMymt9HbGbpPUndrH13kuO
	 t4zxUoltuMC794FwCnieqmC80ViEpM8ISeb/FstAajt/ZvLvTjX8+ZfQxRok7uA5EWEBo
	 qIBrIbswHklfs50l1FXSlIMSx34oF9KTRPmqdZeAnXyyciLrL3QJSi84ugFyqWMb+ctIN
	 /0FCWr/heNmgAlLmPeiDx6vD0hBa8acvH29s+QNnjnfE48yOAHemJSKvQ7JGIUO1aTg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788450190;
	bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xshUp8J5sd8XH27zByFap3Sng9lOtRxjeN1P1/w9w9s7lscqW5tO8bZrUxWRdJolH
	 cK/gqAMy7qw7Gxhgn0O+DZKu64+lW3Pd6KZgzbaCX0ekZKt2Ad92mCK+Ps/fOI9UpM
	 oJWN6TO4wgjytYbDHcl8ymmy69s4g/E7A5zY/pNXrjq4uyM396RH5t1f/N3jpsBmrS
	 iq8y0cg+4c3jXrMAvWd/ntxKXO8MA+vYd8VHOlJudmrEwx2vDzhji5OUIbrZ6VL1LA
	 dqKH/78kGaaX0Gedj5censkHvux6Yj71GqJX1gURsfK8/8qF1qqdKocP6IUPvjZp9K
	 UqV9aL8dQv9yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C76C60B6E;
	Thu,  3 Sep 2026 15:43:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99DCC34E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96102810E8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxKKkChikyGW for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 15:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E51D7810E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a35"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450186;
 b=TZ4+isrPIKNFn+5s1Xv6xg4OhhSlGi4XfKYP0DbRmoo5KLJQaA7m+oLg2nl9aDd3/Nj2
 xzP02zTa2TSHlyyrJMd436FScd4OQASzRT3h4yaA2XVXfCh36clO2Za+mW2KxrCI39gHC
 3XFTwVMWUUpZnJ2GNAwG3zDTfwujdme9L3K8SoWQgr1vF45j7FMTX70o6ftH/qm9+Zlq0
 ZAJ5vFjDANs8SXdVmE5qLCixfKhj/OcAdcHIYpNGmdH9nY1HJ/Dp9OvRgkORYqEObfCgp
 ygg2J6zCgRWE1FvcAMfQE4n0iered2OWfrnRjjY1vgU1gK9XBie9nzYpSuUzTUq7G3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788450186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
 b=baN3i6ackn3h98vx+Z8sY5wdx2CiJP9UtWzWoPVQ0tldQ/aHXz096oVgxwsHCw7zt+Ax
 RkNLdEfILDLm5o9tcOAs6AJt/UBc1Lej6Vom0h1Nkntwin4MIHA3byMbBUJIczXSvC/ud
 njHr6EMfU0+rbfW6R9VdtcV+qKQVFxC86F8VAiprd/9V3BBWpD3T8YIVIwL6eQPmj6VHy
 iQSVKdGq92qdVpG5TlvAxNfmoshegGeRByHDcltX+GHyNznHt154DVf2R4Wwu+RPMJoAS
 oNdpa2R3gVGsAyqp3yIig0cBOzDLq40Yqrg48sSHGl1rrlRXOAiTrKFyWdBMDrNKAXw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kirh6Tb2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kirh6Tb2
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E51D7810E2
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 15:43:05 +0000 (UTC)
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5c7d65c83feso405e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 08:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450184; cv=none;
 d=google.com; s=arc-20260327;
 b=Zw+GnvMhwQ22r0XWB2YpBUQ6swu4h/BtZCwGC64/vypFx4Gut6M7XgGoTBSOvUanL7
 XcRs6UY1vGn7Hedv8KIkCHrVwTZfvcbGlPuLaLsVt55dRox0Wa+0BZSvxIRhjeAEF0se
 x+wyKkuXUWBbVlRcalukOf57DOwQjhvrOhi2YJ78Ek+qHiTMS2VXBSBg1T9NOOiZspgg
 6cVLJS3wZWpiTFgTPLiKH3cym5HCeJOEsTjP2nsfLABpF1xPU5+kWyo5Fp61pDngIuCP
 UX6KLoG2DmMv/yq4DDQZAKPFHIhbWDyxVpukci6TW5o5SbVkawwHAusgmKmCCzW6wOY0
 F6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
 fh=AUg+0sKm1nhYXEt6qKV0eM7Q4jdA3C23gj4NpPQcwTM=;
 b=sBoPFwjzcOHqP06tHcS3FXGAimTA0E0yt+mKPWDd5pg9/9cNybkhQKGa17EJVRtCmB
 A/OS2hpkOvV+qshETMp9OLEmpig3ACcvQi6a1Pd+ZSYi+gFCRs/iLMGLHDyTIuYmHnIt
 KXMrfMBU0PIWbFOOYCldvALHH517Wm6uBMd0jxxmlMGKrJmzbpis5jzjXFCploW6YfnC
 hgZqUPNUR1ixVdGkSTVvqlr1o1TREumQRsnuvf0k4eJjdePFb9KB2XgRXIrrLQtTiMFB
 WXhAikbLzVjPjBZhQY1NykhTA2hTiV8uagYzoZ6gk1T26z7uLJ1eUrR2osMJFHyNiJG6
 pdKw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788450184; x=1789054984;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
 b=Kirh6Tb2Y08ZBI+wEWGMvKccNbj+V6HuXLbNG+7MbVI5xMPO6BCPuV6k/QHkDxFVvk
 XJQRYxorrKHK3dcxd8OwBmCgdaPLcx6nNNvXcBh8wumvR610ByYIZT8QES5brGGb005d
 4+USSEMzQYgaN+R/ud2t6w7Tx7GojXrTQIddID7dL+Hh4JT72Fg5t0Qq1KpRrPNQR5R+
 AduxCzMaCuhdYOn1TVDwtFlPpd9sbM5v+nlVN9Zolic+45YAJXUYuVY9WqzIJ/4FfmcZ
 K2MoIhVjb1bcx1cXnjopMp577Z8r5IJ4v/QwVK/cd96HeNvfa/fB/x35qdiJFVD7TBGL
 IpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450184; x=1789054984;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/eXK1yKhGfZ6IiwIJi0W7wUnZo6ngvXeHcm2srkUn0=;
 b=YiNfMKMiF5XHJh2lRo9v2FEAL9BuKb9MWbVEvl+WkEB5arPeIieEjlsOLYq/JCF255
 0tBxQQ7wNdUmTeCSxSMoFX/xr09nKMjm4Jndf3iKdxdyLbXh23ZzRbzmXUO6ancCJcbq
 U9GXPOkyBhFOvabQF8OtERgJ7ucMkxihIsk0FBcqy93fQxFdl9c4sq9g/msRa2npfE8w
 q+KUPFTOKiolh35o+YpmHOlbad2St5ZPoGLTAXoppZ9iKdvqNv6wNsi8WBuDFfhrcmgq
 pS3QTRzKSltNvM+3JYwpmCzJYniFc44SXvg+8cyUlRBHdxd6Eg9PNnHuLNBuGGFdyl8H
 mJsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzunjrHFHUqLTqPi5D+1c8HEXy4zablnNYjBeY8hma8YK3AAlNwF1doka+k2qXyeroED6b1gAM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQUCTrjH+1aAWXFR5ANsirx9UeIwX+0CT9yA4seo+spDFi4q/U
 hV0GaGZwjfluatrp12aWm7l7JOx63uMJGbYAWYdM2SiZdb6/VqYfn5YGSnBzTDBGQdJH5ta3ZC/
 +5KwpgsO1qB+2PwjpaWj+Q9SMT1+feQdzIydQ
X-Gm-Gg: AYBFou2TKtl7yf64uIwndmLaJ48etpUp6MGPQzHhaDChclA+J5m8MxHAaPlf5cGGT5b
 /2yGZ1x/vsIRZAiicd+BYJKXd6oGYvnqFONnIb0klCS+zv8OAdcFYA9nDEykc0MC/g13YNXboFR
 UPVcwwsaDf2umfALeZbbAK/xY4rleU5c4QT/JalmXABj+uap/82Nw0//ERXd1VA0Np5ugn7knD2
 SgbEH9bpzqkH+YXWhAgggBcPAXsyLjTrOOhgZWHfe/YdmJnHNGI9Ci64U5e15lEWE1KHgrh8Wb9
 xcchEtFXekyWw/QH1rkCDAhRG8YwOuMJapWoQ46SEv/ts0Y=
X-Received: by 2002:a05:6122:311e:b0:5c7:9947:5ceb with SMTP id
 71dfb90a1353d-5c7d22c65b0mr6203968e0c.0.1788450184100; Thu, 03 Sep 2026
 08:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-8-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 11:42:50 -0400
X-Gm-Features: AcwNN1Uv1hjpwcS7Wg2AJx70NWHecgp6rdAj9VNo73SgqxF1k5pN9k7Sv1iTJXs
Message-ID: <CAMDkj5xYYdamBSOqsuKaDr8dCWNR5g=strgGzwLdcC0+Sb9pxA@mail.gmail.com>
Subject: Re: [PATCH v9 07/15] test: py: vboot: prepare integration test for
 ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,


On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The vboot tests only consider rsa algo for signature.
> To prepare the integration of ecdsa test, the signature
> algo is now explicit.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - some minor update to fix rebase on next
>
>  test/py/tests/test_fit_ecdsa.py               |   2 +-
>  test/py/tests/test_vboot.py                   | 104 +++++++++---------
>  ....its =3D> sign-configs-sha1-rsa2048-pss.its} |   0
>  ...sha1.its =3D> sign-configs-sha1-rsa2048.its} |   0
>  ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
>  ...ts =3D> sign-configs-sha256-rsa2048-pss.its} |   0
>  ...56.its =3D> sign-configs-sha256-rsa2048.its} |   0
>  ...84.its =3D> sign-configs-sha384-rsa3072.its} |   0
>  ...s.its =3D> sign-images-sha1-rsa2048-pss.its} |   0
>  ...-sha1.its =3D> sign-images-sha1-rsa2048.its} |   0
>  ...its =3D> sign-images-sha256-rsa2048-pss.its} |   0
>  ...256.its =3D> sign-images-sha256-rsa2048.its} |   0
>  ...384.its =3D> sign-images-sha384-rsa3072.its} |   0
>  13 files changed, 54 insertions(+), 52 deletions(-)
>  rename test/py/tests/vboot/{sign-configs-sha1-pss.its =3D> sign-configs-=
sha1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha1.its =3D> sign-configs-sha1=
-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its =3D> sign-c=
onfigs-sha256-rsa2048-pss-prod.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss.its =3D> sign-config=
s-sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256.its =3D> sign-configs-sh=
a256-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha384.its =3D> sign-configs-sh=
a384-rsa3072.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1-pss.its =3D> sign-images-sh=
a1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1.its =3D> sign-images-sha1-r=
sa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256-pss.its =3D> sign-images-=
sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256.its =3D> sign-images-sha2=
56-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha384.its =3D> sign-images-sha3=
84-rsa3072.its} (100%)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecd=
sa.py
> index 3e816d68eb6..e59390374af 100644
> --- a/test/py/tests/test_fit_ecdsa.py
> +++ b/test/py/tests/test_fit_ecdsa.py
> @@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
>      with open(key_file, 'w') as f:
>          f.write(key.export_key(format=3D'PEM'))
>
> -    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', te=
mpdir)
> +    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.=
its', tempdir)
>
>      fit =3D SignableFitImage(ubman, fit_file)
>      nodes =3D fit.find_signable_image_nodes()
> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index e9259584e32..33cbcea5c24 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, =
fit):
>  # Only run the full suite on a few combinations, since it doesn't add an=
y more
>  # test coverage.
>  TESTDATA_IN =3D [
> -    ['sha1-basic', 'sha1', '', None, False, True, False, False],
> -    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False=
],
> -    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
> -    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, Fals=
e, False],
> -    ['sha256-basic', 'sha256', '', None, False, False, False, False],
> -    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, F=
alse],
> -    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
> -    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, =
False, False],
> -    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, =
False],
> -    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True,=
 True, False, False],
> -    ['sha384-basic', 'sha384', '', None, False, False, False, False],
> -    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, F=
alse],
> -    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True=
, False],
> -    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
> -    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False=
, True],
> +    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, Fal=
se],
> +    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, =
False, False],
> +    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, =
False],
> +    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False,=
 False, False, False],
> +    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False=
, False],
> +    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, Fal=
se, False, False],
> +    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, Fal=
se, False],
> +    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse, False, False, False],
> +    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, Fa=
lse, False, False],
> +    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x1=
0000', True, True, False, False],
> +    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False=
, False],
> +    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, Fal=
se, False, False],
> +    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
> +    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, F=
alse, True],
> +    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, =
False, False, True],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> @@ -111,9 +111,9 @@ TESTDATA +=3D [pytest.param(*v, marks=3Dpytest.mark.s=
low) for v in TESTDATA_IN[1:]]
>  @pytest.mark.requiredtool('fdtget')
>  @pytest.mark.requiredtool('fdtput')
>  @pytest.mark.requiredtool('openssl')
> -@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,fu=
ll_test,algo_arg,global_sign",
> +@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,re=
quired,full_test,algo_arg,global_sign",
>                           TESTDATA)
> -def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, r=
equired,
>                 full_test, algo_arg, global_sign):
>      """Test verified boot signing with mkimage and verification with 'bo=
otm'.
>
> @@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.key '
>                            '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
>
> -    def test_with_algo(sha_algo, padding, sign_options):
> +    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
>          This is the main part of the test code. The same procedure is fo=
llowed
> @@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>
>          # Build the FIT, but don't sign anything yet
>          ubman.log.action('%s: Test FIT with signed images' % sha_algo)
> -        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mk=
image, dtc_args, datadir, fit)
> +        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding=
), ubman, mkimage, dtc_args, datadir, fit)
>          run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else =
'dev-', True)
>
>          # Sign images with our dev keys
> @@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
>
>          ubman.log.action('%s: Test FIT with signed configuration' % sha_=
algo)
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if a=
lgo_arg else sha_algo), True)
>
>          # Sign images with our dev keys
> @@ -390,7 +390,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>              run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, ef=
it)
>
>          # Create a new properly signed fit and replace header bytes
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>          bcfg =3D ubman.config.buildconfig
>          max_size =3D int(bcfg.get('config_fit_signature_max_size', 0x100=
00000), 0)
> @@ -424,7 +424,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>
>          # Create a new properly signed fit and replace hashed-strings
>          # size property
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>          utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0' %
>                            (fit, sig_node))
> @@ -448,7 +448,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>                    'Bad Data Hash', False)
>          ubman.log.action('%s: Check in-bounds hashed-strings size' % sha=
_algo)
>
> -    def test_required_key(sha_algo, padding, sign_options):
> +    def test_required_key(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
>          This function tests if U-Boot rejects an image when a required k=
ey isn't
> @@ -470,12 +470,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign=
_options, required,
>
>          # Build the FIT with prod key (keys required) and sign it. This =
puts the
>          # signature into sandbox-u-boot.dtb, marked 'required'
> -        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubm=
an, mkimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, p=
adding), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>
>          # Build the FIT with dev key (keys NOT required). This adds the
>          # signature into sandbox-u-boot.dtb, NOT marked 'required'.
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit_norequire(sha_algo, sign_options)
>
>          # So now sandbox-u-boot.dtb two signatures, for the prod and dev=
 keys.
> @@ -487,7 +487,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>
>          # Build the FIT with dev key (keys required) and sign it. This p=
uts the
>          # signature into sandbox-u-boot.dtb, marked 'required'.
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>          sign_fit(sha_algo, sign_options)
>
>          # Set the required-mode policy to "any".
> @@ -567,8 +567,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>      dtb =3D '%ssandbox-u-boot.dtb' % tmpdir
>      sig_node =3D '/configurations/conf-1/signature'
>
> -    create_rsa_pair('dev')
> -    create_rsa_pair('prod')
> +    if sig_algo =3D=3D "-rsa2048" or sig_algo =3D=3D "-rsa3072" or sig_a=
lgo =3D=3D "":
> +        create_rsa_pair('dev')
> +        create_rsa_pair('prod')
>
>      # Create a number kernel image with zeroes
>      with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
> @@ -587,9 +588,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_o=
ptions, required,
>          if global_sign:
>              test_global_sign(sha_algo, padding, sign_options)
>          elif required:
> -            test_required_key(sha_algo, padding, sign_options)
> +            test_required_key(sha_algo, sig_algo, padding, sign_options)
>          else:
> -            test_with_algo(sha_algo, padding, sign_options)
> +            test_with_algo(sha_algo, sig_algo, padding, sign_options)
>      finally:
>          # Go back to the original U-Boot with the correct dtb.
>          ubman.config.dtb =3D old_dtb
> @@ -616,6 +617,7 @@ def test_vboot_ext_data_bounds(ubman):
>      by U-Boot to hold public keys from the signing process.
>      """
>      sha_algo =3D 'sha256'
> +    sig_algo =3D '-rsa2048'
>
>      def run_bootm(test_type, expect_string):
>          """Run a 'bootm' command in U-Boot and expect it to fail.
> @@ -684,7 +686,7 @@ def test_vboot_ext_data_bounds(ubman):
>          sign_fit() overwrites the FIT, so a new one is built before each=
 test
>          case mutates its external-data properties.
>          """
> -        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_a=
rgs,
> +        make_fit('sign-configs-%s%s.its' % (sha_algo, sig_algo), ubman, =
mkimage, dtc_args,
>                   datadir, fit)
>          sign_fit('-E')
>
> @@ -762,21 +764,21 @@ def test_vboot_ext_data_bounds(ubman):
>
>
>  TESTDATA_IN =3D [
> -    ['sha1-basic', 'sha1', '', None, False],
> -    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
> -    ['sha1-pss', 'sha1', '-pss', None, False],
> -    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
> -    ['sha256-basic', 'sha256', '', None, False],
> -    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
> -    ['sha256-pss', 'sha256', '-pss', None, False],
> -    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
> -    ['sha256-pss-required', 'sha256', '-pss', None, False],
> -    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False=
],
> -    ['sha384-basic', 'sha384', '', None, False],
> -    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
> -    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
> -    ['sha256-global-sign', 'sha256', '', '', False],
> -    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
> +    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
> +    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
> +    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
> +    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False]=
,
> +    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
> +    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
> +    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
> +    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse],
> +    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
> +    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x=
10000', False],
> +    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
> +    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
> +    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
> +    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
> +    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> @@ -787,8 +789,8 @@ TESTDATA +=3D [pytest.param(*v, marks=3Dpytest.mark.s=
low) for v in TESTDATA_IN[1:]]
>  @pytest.mark.buildconfigspec('fit_signature')
>  @pytest.mark.requiredtool('dtc')
>  @pytest.mark.requiredtool('openssl')
> -@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", =
TESTDATA)
> -def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, al=
go_arg):
> +@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,al=
go_arg", TESTDATA)
> +def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_o=
ptions, algo_arg):
>      """Test fdt_add_pubkey utility with bunch of different algo options.=
"""
>
>      def sign_fit(sha_algo, options):
> @@ -807,7 +809,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>          ubman.log.action('%s: Sign images' % sha_algo)
>          utils.run_and_log(ubman, args)
>
> -    def test_add_pubkey(sha_algo, padding, sign_options):
> +    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
>          """Test fdt_add_pubkey utility with given hash algorithm and pad=
ding.
>
>          This function tests if fdt_add_pubkey utility may add public key=
s into dtb.
> @@ -830,7 +832,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>                              'rsa3072' if sha_algo =3D=3D 'sha384' else '=
rsa2048'),
>                             '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb]=
)
>
> -        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, m=
kimage, dtc_args, datadir, fit)
> +        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, paddin=
g), ubman, mkimage, dtc_args, datadir, fit)
>
>          # Sign images with our dev keys
>          sign_fit(sha_algo, sign_options)
> @@ -852,4 +854,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, paddin=
g, sign_options, algo_arg):
>
>      # keys created in test_vboot test
>
> -    test_add_pubkey(sha_algo, padding, sign_options)
> +    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
> diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/test=
s/vboot/sign-configs-sha1-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha1-pss.its
> rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vb=
oot/sign-configs-sha1-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha1.its
> rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/=
py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/te=
sts/vboot/sign-configs-sha256-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256-pss.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/=
vboot/sign-configs-sha256-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha256.its
> rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/=
vboot/sign-configs-sha384-rsa3072.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-configs-sha384.its
> rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
> diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests=
/vboot/sign-images-sha1-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha1-pss.its
> rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vbo=
ot/sign-images-sha1-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha1.its
> rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tes=
ts/vboot/sign-images-sha256-rsa2048-pss.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha256-pss.its
> rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
> diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/v=
boot/sign-images-sha256-rsa2048.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha256.its
> rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
> diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/v=
boot/sign-images-sha384-rsa3072.its
> similarity index 100%
> rename from test/py/tests/vboot/sign-images-sha384.its
> rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
> --
> 2.43.0
>
