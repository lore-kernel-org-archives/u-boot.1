Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97ABC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53EE3810D2;
	Thu, 17 Sep 2026 17:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZU9lQvwb7cNq; Thu, 17 Sep 2026 17:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 541D78109C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665557;
	b=Bn+v/03vNYaPPDlcn0M9aL0FSuLPlYfxS3UaP9QU5POCafTXtEc/WGqy6KgQAM0CjmB5
	 noehkgySeh9qPeXAGS8mYddJuAjJpStbLNgK1p4JmppyPZBLiJk7wbCz2Ml84J07Vt3ZA
	 sCujcIfGSJFH6F5RYJWtf/mcrTYsveNk6ShsDGTMv+WE6Cqu1WK+woPDhv2rn7BA/twzX
	 R9pdRa/D+kyaj/ZDQDzkOfiY6qolrvE7NySytK7Sjsvh9ki/nb4Uqr4r51CxAIJ8DLAxa
	 sWv15CPuP9tVNQfyRDB0novwH/8zpKjIxQXCC8bVqAam+sU+8Nqef/qh2L2HV4tXJKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
	b=AbByPBYmXv+Snrehqq6EYYwulRNIbU93wwH1+ogvCQxYPNbQAY0pCR5jRgfYxaZuKIoP
	 /CZVCIKV0Sr8XfM/Ste1Z+xFAoJWjtdRWwEOy4o1GkD3kzZAPg9QmQ7896wXnyCAiad8W
	 OOUulozz78hMPcs/McwRVNT35GqXz0PCKSyiYt/lU85pTrQlpOSrHqOnrKqBvEx2BA92F
	 WqWSR+8/PQOdVdARV+4zs4mZkuhufWzJuHQD3janjSIO+tPDJiRMOE38OWwmmVksl3lmf
	 p/mtM9SKIxgWhSIGc1Am3Ti7gzLlc0yrSZWXPQYX6ltp8nYIPUVrqruhLvv0QgxkCxQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mwyUiqOV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665557;
	bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3kSwausLUmygXKu/nLpFyR6d/yjD+YctlNdJM/ApY1dUQkf2DNYlq39JMmtKjR0a
	 TODD3utW+R4iX/SqYcjjjyRjWac+KbrM4mQXNFqbs043oykJ/ZKtLkAMfDrGWkvY+e
	 9RP8TZPRW+/AKmn03X5HodnFe7S+JTVrJEJytCdf8TSBPv88bIWQapqT/i3714sN+v
	 9LiS3rAyph6QC2XBv7/3ytmhEB3jyQJydYL/s06EY+4ncZI+/Q4A3LZiluxCQNZNQV
	 MHP5HhueStuuNusrJ6Q/Tf7gZr1C/SIlabvYOUoU9st7mdrsGGDUlzc/Q2QplqndW5
	 zoD3VOHrDvqkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 541D78109C;
	Thu, 17 Sep 2026 17:19:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA6B8352
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7DA8807C9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmNV8i8msvOK for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F08B8805F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665432;
 b=Sa+HVn21xYABQO+DlvhyCyu41Rw2Ui/0HhTNG0na0seEANgYp3zFBIk5gYNuZbwq1uQ1
 ayBDtaumjwxRMCJKNcc88ci3XxfTMLMNn4cS3Sa64xjrtJtpgWD0dMuxDdJdDr6ipwzKb
 vCNFxqPmyzVjJMlZ8oBFNfDnTEvnbuQFgqMz6uAjj/TQpnkYKbFII54sM8uD6SU2+BT6i
 L6iZLvn4LRQvopMqNhBpF4PLtirhcrbgCac48IZ+GCaZtkvCrUQ367kaGBYJRgL2m1JAE
 MCrJ8xiOV2LYyi5T7N+OgE/JziCHrSaNo8h53WzGH+nK6M9Tb6Y3f+PlHu+HY7+t78A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665432;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
 b=Q+rwhF06MaNJCgrbocQpjx0nZjdyWi0gdvzwLh1ywMCHX8VlC8PB9AIlNTqHzCe82O5O
 I8gneohts4Y32BnXO9b5/SPFB8XBjarwNpLCJ5Fc2gLlrQiGYxvFaHfJezRx76J+rsW5Q
 TjiigF+PIYIebMGKnPRiazR2XXY0H8PR1Y9qajJHtY3OGEW1bME7NwVPFL+10dA8KVSzP
 voE0IcJtor6+gLRcY0K8ZdPlGJ3C8m1IDid0nTTBpXJc+MrFwb4ZJVn2sIulnmKMcmY4B
 rRwhEi6lFVil7s681FkllAlgY8k6jb30la62bdc3oyxy4/pCFEdIBgXtu1DLxSQ3hLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mwyUiqOV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=fractalclone@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mwyUiqOV
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F08B8805F5
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:17:11 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43daa8f4so7769457b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 10:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789665430; cv=none;
 d=google.com; s=arc-20260327;
 b=k7kDOjcpfj86nh86o8mOfuFxBMXLWpZxdqIjrLsSVNYZUSNx3y0KUVzbl4VZsFTMC2
 qtiJwY55OD2SUatVKdNTQJ/12lashEPsBSusj2c+CPEJW28TKGSzV6+Jyekn6ih1IMI9
 OzxBDqQr9wRUmUscDU3tcVWfWKuBr7RZJMHQFO7HbO7iOcpErQrVZXw3aKJNNIKO3eMh
 z+U45JFCKp/Lk7sbbFKVqS6wMp6xad1RU4fsSP6SLKEkg10UACLjSp6NoviBVOO5SAPf
 oNb8ktstZag1nDgTbunnXuWKa+Bg48cYT+jhkWX0uG73n9TfomJ45atzY6hs3g2UhsGj
 R6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
 fh=akAKr4LjbXQwNzwKRXyePz0+A0fuRahkJ7U0mEup4Ok=;
 b=oFvn47a/ww2eL/GBaA0DXrHjpubQ05KsTNrQQWrZJz7cCfgzY5PnT9S2p79aSd5Aju
 4K/ak6iZCtoxDRDIStnpx1VA1Pi20sXxdfxO3GPX5Pq7EzwRY4K1kOHT3y/ZwyZ1lh6+
 9GqVikrkPE6hLyoZm/8RZXXNHf3rTRW8TLFutZUeOFjqNI73R5ZI2dAVu6jG66kjmfIm
 XJ8QYCFkqFTSkBw+K/ESqGt2WMg3BYmPlJdag/EkgDg8pxDll54nVXqpr82IBycQOTur
 zxo89IGpaMmtlIrqeHaTzahpq55UolG3BG3C0hZtMDCL/mbyNqbfjR2ltfhaoCHNu5Zh
 fJ9w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789665430; x=1790270230;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
 b=mwyUiqOVKWcbCOj6DyE/a1SzI06zOsE1Ufwaih4MokyOnkwDbsv++86JFEc+Qat/KE
 QEzHldPFNgcT91lXYiaUDeWsf/bQtYgN4PMkTuLXjVZ/nMTQqkkfZTm/9Ar1wZuHrfl8
 k4gGCg/DSE6FE7bPdxL+Gu7xsZS5/v+GzfKK4hjFSuHV2Qrffz593T6yxN+t2+HoZFgX
 JZV5PRIf2emOCMkPWjtMfHnzVeJ83a71VYKnfz7Tohpjy3UKQ0xHsXZuRJy/sv1K2Q56
 gC8JzQuOnJ1sVvCcaCH3Ix+JAxKdb+JXv6TaSHyCj387O5lyCmaI22c1jIqFX/zMG1Id
 Yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665430; x=1790270230;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jBrKXJ+G6giTPb+VJeuW+BeXK3c/MC/s2au+tXJBUC8=;
 b=tAZXzeGvjbrWy6exvKkImNEgfZClfwFCQ6jIxZDIjzFiGpdJQ9krP/Lou67xO3V3cw
 eukzQ1q1mdDQ5POSsLJAp930CrxpT4+IKbzc/PQZCL55A5X8HXrJ/s7lSMRsX5APszRv
 nwL471x1nQhfHZUmhEeiSa6F2Wx0I/CNLExw0cGmpBRIRbVZcIazicpOr2qbWPRZH4oH
 +xWUSreukgiDMMK5IPzVBYk1T+bXWHrBxO5egrDn8cM4xiX7x4ka4FdyE8BQ7fztT3CC
 YwPXT6K+U62N4LESp93+yNag0QMu3hNvf00u+9wpnEVBOoG6Hgi9kFqhoJqN7VfqbEQJ
 W1TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMTHDC3I9UwVFsD+JVYM/1f4rUw6PI8pbh9/sAmA+hK0NsT/oWTcsJmyBJM0qtdoT2X18gSic=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nziWiARcQGaWAprOvcZXvnIoumPH8mcOs5LJF7CGTp05Uq3Yal
 3m+gO53MBg4vOmHsD/1rTTpemfCeJPeJLU/Sb2MlKHe8hz3R9sCrR0mFsmClY7Bg4HqlD7U9QE3
 rf6orinp3hiT/6PcEXYhrE9WHIeVf4SCAHS/oXWM=
X-Gm-Gg: AYBFou2w0FRjuBnw334e4dpx0zpUsAadz3sqXTJWaLMSH3g8K58Mn/Tuk+pMDpl4To4
 1GOytMYWc3N4VlYGbHjf7himQf5Bs2cIWwp0c7/Wd8oXJZppKo9lDJ7n/sOXU8YWVCyhIF7N2vm
 0pRa4+RtVPvI+QJMvmiox0SZ16hK/njWragbiKUwHuk8NBLunCrH5RLER6rVYaSUx8mHFe8CJz4
 u5bFTjBjl5L1UqWwJ0kHRoccMLVOLyJoVIDrNHJdeJkQZ4rnkgpjaOTjMdSzoGS/MJqH7P6B2jt
 HmBekyb+8kfsDgWgzeV9Iix2cBD9LLy1Cm6lbBh15mc75Wvzp5Vi5o8=
X-Received: by 2002:a05:690c:389:b0:865:50a0:b1a1 with SMTP id
 00721157ae682-89221bd27famr24334617b3.25.1789665430494; Thu, 17 Sep 2026
 10:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
 <a634939e-d34b-4119-8856-c75740b33014@0leil.net>
In-Reply-To: <a634939e-d34b-4119-8856-c75740b33014@0leil.net>
From: Jean-Paul Etienne <fractalclone@gmail.com>
Date: Thu, 17 Sep 2026 19:16:59 +0200
X-Gm-Features: AcwNN1Ukr51bkIJanNlwqja3G2i8TsO5vGzepHwf1StRZoMJIAaa_s5zCURfRoQ
Message-ID: <CAN7e4jpt1jGCQPhEKceYDO8mXNBE6p9F+3-6yaa0eAO_yP1q6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] rock-pi-4b: add config and fix dt
To: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000040630e065bb0f4c9"
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

--00000000000040630e065bb0f4c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,
I've tested rock-pi-4-rk3399_defconfig.
It works for me.
Thanks,
Jean-Paul


On Thu, Sep 17, 2026 at 5:11=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> w=
rote:

> Hi Jean-Paul,
>
> On 9/17/26 4:04 PM, Jean-Paul Etienne wrote:
> > This series add a defconfig for rock-pi-4b and
> > fix rk3399-rock-pi-4b.dts to account for SDRAM LPDDR4 params.
> >
>
> We already advertise ROCK Pi 4B support with rock-pi-4-rk3399_defconfig,
> c.f.
>
> https://docs.u-boot-project.org/en/latest/board/rockchip/rockchip.html#ro=
ckchip-boards
>
> Can you try that instead and report whether something's broken/not
> supported?
>
> Cheers,
> Quentin
>

--00000000000040630e065bb0f4c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Quentin,<div>I&#39;ve tested=C2=A0rock-pi-4-rk3399=
_defconfig.</div><div>It works for me.</div><div>Thanks,</div><div>Jean-Pau=
l</div><div><br></div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 17, 2026 at 5:11=E2=
=80=AFPM Quentin Schulz &lt;<a href=3D"mailto:u-boot@0leil.net">u-boot@0lei=
l.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hi Jean-Paul,<br>
<br>
On 9/17/26 4:04 PM, Jean-Paul Etienne wrote:<br>
&gt; This series add a defconfig for rock-pi-4b and<br>
&gt; fix rk3399-rock-pi-4b.dts to account for SDRAM LPDDR4 params.<br>
&gt; <br>
<br>
We already advertise ROCK Pi 4B support with rock-pi-4-rk3399_defconfig, <b=
r>
c.f. <br>
<a href=3D"https://docs.u-boot-project.org/en/latest/board/rockchip/rockchi=
p.html#rockchip-boards" rel=3D"noreferrer" target=3D"_blank">https://docs.u=
-boot-project.org/en/latest/board/rockchip/rockchip.html#rockchip-boards</a=
><br>
<br>
Can you try that instead and report whether something&#39;s broken/not <br>
supported?<br>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div>

--00000000000040630e065bb0f4c9--
