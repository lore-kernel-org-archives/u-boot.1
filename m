Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A45DC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1019B60692;
	Sat,  8 Aug 2026 13:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncLsgA2JvlSm; Sat,  8 Aug 2026 13:49:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91C566065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196960;
	bh=uE8BJ4wIRdzHO2K9LGqBcJtk9ogLc31eUyisL/XUusY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AgiNeG5xYQbE24wUxl9jPhYf7zx7ZrqGYM+AZMRPU/bhXE7FFfYHvv1NGBS5/Kg9n
	 1n2fdXMVS0A62sQlTvpjUw0rnbQGfxqAJQnHpuWTXlre1y0LyElMbJN9Uoe+mu/XWY
	 V4tNHm81sWeRxy5kv74NXWzi0ufFtcO0/LlgKfmpIp9bJ32lMLpkmz/XsF1PZ6RbdR
	 EPlU2xp20SAvulE9FWpucQDBM948xOWoZiL9KyETmwilvEHQ0cU9VAETmTEBJclpm5
	 V26uZuhTZ/kfvIIS9PUgVbCgir4PCyPBruZda3NGx/USi5cb1pzlCnqCoJhF5rTgTf
	 Z6wsVZztoL99w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91C566065E;
	Sat,  8 Aug 2026 13:49:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 584D0282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EA5180E33
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHSLk87Gn1m8 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:49:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5C37280E28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C37280E28
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C37280E28
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:49:18 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a1ff91dcedso195882a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196956; cv=none;
 d=google.com; s=arc-20260327;
 b=fGhGOZE4sq0kywsTAyZFoEb4VG7S3E8DDxv+Rin/0aYtR13fbEZmWat2J8yZm3QnFF
 9R4Q1GBHFJ5wy0aZwS+wj8npRtCrKf/PigTYxo8QPX+8Wqt8yi2uj5CFx26lfMaIi0f/
 u+IBhEvfziN7FdIZIcQ7qACNb2V3HzB2cc14NH+CrZGeNnu0ajSdPKQGLmIEgoFmjpOd
 2JSllSBNI1ZXL+EaMq4H/PTON8wrfXY+OWSGFnsGQFjG/QTajNKJUKehAUaunQi7trvl
 lgcZJSbYL3Qme9rUSyRQMHt7XB75t1pAh9i3cyturNmJB+6DaxvUKgjSqkPdR5BRBTlP
 Hjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uE8BJ4wIRdzHO2K9LGqBcJtk9ogLc31eUyisL/XUusY=;
 fh=7jrThJA6pEWCuPXKG1O5LDhObUByc+vIYCmgiLRHVlk=;
 b=SgLejD0KDeAwgfvLmYnfH9/SJ2vs85mAatwpBI6xI8WgW3s0jPTsnnwUntBQTMdz9E
 Cn2oWhPyxLclpmWhTTwm/hbQePyVdiTS4QvHrlXz00Z2pRmURVsc+mXQz2ktRLma6eMz
 oAK5yIJ2AqWBpcY1QQqX1RwdTQHSFKrISG99hpZ8g+7vSznE2S0S6bOil6C3kpBrbyTm
 wvD1Vw3ymqDaSWVWOMpkLQee0BMZs1j2QdxVcy9of/AVCqGEpQoltCa8v+5suWZ3Rmlm
 9qsyPR3X9xzVQPyeAz/ArYYhmsU9B8cu20j2ZHwXlNxssQJEKQ6YkCZFq+/ZMy1gFOW2
 /yPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196956; x=1786801756;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uE8BJ4wIRdzHO2K9LGqBcJtk9ogLc31eUyisL/XUusY=;
 b=pe5Bv2tKE/GnVifkoPCMA0loDb3FxB/XWn0zFF6w8xCwTkbTcNwECaZGDwG1zEuJsx
 c0yG6mEztAuRhJzxvFC5/IwWzpRTadRp7wUT9khyCJEBySWlqkFVrnvqK3jdj/K8lZaL
 lu3F185ZzunEg4sAUwvk4PqDx29xoVy8vzC8MLOAi+yvAZ4hMbDJ9bo/WqaFRGrkKhAh
 8rgwprileTtZ04wH4b+FFMQrDm9mdtVLLAhRQTKi71KZzprl54yCUnoXfo25iLPFRJSU
 D9+1arlrSXN3rub/bU6uXXmxn0ZsS15F1S67K2wqqFstYBTfe61CdvWXasJDy40Fc3PS
 vZPA==
X-Gm-Message-State: AOJu0YztHhyfXJTx9ASZF0OzGJjYxwqSAK6szB0fOqy5WyEQGNzNpL71
 Fubxht0iFBQ3NgpAO+QC+3tUN/gVF4NLV3eMO9GWydqh9AZlcqblbwDNvP/7wc1tqWfs1Pp8bNT
 b9m69ip7k9KQSCLKUU2rU2VHwWuYSE2lMgDLwrF19PIYVnUT4V9A=
X-Gm-Gg: AR+sD10/SvVsWjtTENUG8UchuKC4/LTybjZ4Tqe3+dOlXgBQCTdiHzNmOy7HIfiGn4E
 cLbq5FLkLwDslgh+AbYrkUJyOcufaYLQ+VJYfMDQVos9MJFZ6uWK7KbMwY+xC2DEdMZJomcOK3V
 f4NlQ+6NinFVjz0wFYosePZAqh9DCmvcc0cFIeCctW09bH9yeZCYj8IEAzezFTmIirCthAuUQLu
 Dj/u6vD6B/SuIfpetbbl36knuibeQo3xcM+2jcJC8Eu4YNjgsFuxMoekD+hx5ix+R7kIyKe3LtF
 hGZy/OaMaH2AEvdZN2tIMrB4l7YjkXqAJKJyAHP12Xo=
X-Received: by 2002:a05:6402:21d2:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a1e59f17a6mr5292464a12.0.1786196956275; Sat, 08 Aug 2026
 06:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 07:49:04 -0600
X-Gm-Features: AUfX_my5VUHVEj5GZ0Hd_GIPOrFPbyyaSdmKErPEkSMPWZkxQwYvPHMLta-Iim0
Message-ID: <CAFLszThsggCcTCw63L71JhTCH2VC+HNUD=6XyBJNm9QpwLdmhg@mail.gmail.com>
Subject: Re: [0/5] RISC-V SPL: fix OpenSBI FULL FIT loading
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786196956; x=1786801756;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uE8BJ4wIRdzHO2K9LGqBcJtk9ogLc31eUyisL/XUusY=;
 b=CS97kBz+Jv1y/kNF/G9543kixHO+8gCAJUkbSLIs/e/NweakeMbbQQvthJnfC9avAo
 rxOV2zietn6mt+xdxVE0ArzSmtq0u+8Tzuuyzp3YJLclPr7ftJB49d9WsZVpYdP6Ofpt
 SEKdOa/bQmV+XFjBEgZmSDDZxAo9VGOy9pCRY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=CS97kBz+
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

Hi Nikita,

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V, primaril=
y to enable loading OpenSBI as firmware and recording loadable images (e.g.=
, U-Boot) into the FDT passed to the next boot stage. This aligns spl_load_=
fit_image() with the behaviour already present in spl_load_simple_fit().

Just to check, what is the motivation for using LOAD_FIT_FULL here
rather than the simple path? spl_load_simple_fit() already loads
OpenSBI as firmware and records loadables, and is what existing RISC-V
boards use today. Please can you explain in the cover letter why the
full path is needed for your use case (e.g. full FIT verification), to
justify the extra code in each board's SPL?

> - This works only if FIT Image contains dtb blob, spl_load_simple_fit() o=
n the other hand relocates gd->fdt_blob to the end of U-Boot;
>   It's currently unclear to me if spl_load_fit_image() should do the same=
.

I suspect it should, since boards ought not to see different behaviour
depending on which path is enabled. That can be a follow-on series,
but please can you mention the limitation in the commit message so it
is not forgotten?

> - I am not sure if sandbox test is a right thing to do, still i think it'=
s better than relying on QEMU for testing in this case;

Yes, a sandbox test is the right approach - the spl_load tests exist
for exactly this purpose and run in CI on every commit, so please keep
it. Since the test constructs its own FIT at runtime, the grafted
image you used for manual testing is not needed for CI, which seems
fine to me.

Regards,
Simon
