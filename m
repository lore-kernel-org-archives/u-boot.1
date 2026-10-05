Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB759CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 04:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC46C80CB9;
	Mon,  5 Oct 2026 04:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vyrU8YoXidli; Mon,  5 Oct 2026 04:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D505380CAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791172906;
	b=bnKV6kVwv+ZImpebvQW9s1aIWVf5UiWzqIi/DDC4it+DnO9buDvcCuN+efiP3/UVALMV
	 Pl7159zo2S1epS/J6rxQzaE1ejGBkpUvNWdQHo4Drs/+Z4dn70htdYg0WU9l03fPqfaJJ
	 FX2exrtcxu9bG82MbxAv/RLK0muxKfuMQxM624yellAd0Yrl60a9u+A2X8B4kyU6EI/cW
	 jYqnFSjr0L7ErT6gF0gcGEt3d6tc4R8AjSrciL9lV5degTSexmH9wocy8dR18lgeqxTce
	 BYdHW8CtRPG8Koi4RciZnsOnNhl6i38ABAdDvEW8YuY5ctRGNrWon5F0RILBJwDxxig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791172906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
	b=TgcNodt5MViLMoil4HBaGq1clzbID3w1pQxZZUuAGtGKqGFTiiDAtJNHWTYg4jSd3Y1g
	 RxRgP5NmFyC3gsRh712BvFjK3vx/a6pDN7sXNo6xkXvwnat6g5eo47kknejfvaO61MnI3
	 0iwoBIIzoxXsRqJkHReDAB4zcWp71DaxeWSHKETSpDiwOnXb6uwUoUfBQzlXFMO39aFqW
	 AMsctbSPp8tCEcfQjiT3aYREZvvQZ4wd05/VI0sNnq++3TeYIVF7zo2o9kX78Of5QF7G/
	 LnBYx7arBGi+DI/xaJsREumeRsAt2vN9/IzwZ1UAKlUz0sIPghOOiiJYBZospWgORwg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791172906;
	bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o03h+p5p/6OM44SwwwdbKWp+ePaalZxQcg9jhrc9jFoa4gfL7dyvPml3Hvq2l4Nzf
	 NGc1lZwfDzVts2Ac2zJsUYduNTxUZIHfqntdUmdH4iNi9vg1FXR2Sy0C5i5yPdNQ5i
	 AgHMM97UWXPy0tx4s1wDQppTIvOpuz0U9hTfZLdAkDuKtJ/x2KwGFrtHarDOAkroIs
	 l0C5CnS5TnHBBUulLQvaaPym7pNBcMoUNQIB0tVVPo0Tjx75FtpoZD5M8mmjn99a+X
	 CZgQ9q+pf2JI22m3eHFBNf0X/IjBZbMyXFyqfRiFoV+dVdjjrkn2Xl3GyNkk80/svF
	 jJj94ttmHJjuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D505380CAB;
	Mon,  5 Oct 2026 04:01:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6C42341
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C9C14007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2yut2Z_mzHQ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 04:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7FC8F40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791172902;
 b=bzCmuTVtABiRZ4FhSe32S9zMbQlYukwDdTIbUG0rW/knVdGHFn/nnrYyfavwHOkO0eX9
 sVXIY3vsUQHtNOrmvc9HqiLMO7B43gzimPH1Z59Dmkrm8vL20ivCwDGpTG+G1QXzYnp+k
 gp1c5spg2WdjkUZ2U4PJ2/lrWOL4j+XtR6xyz0T4T0JTYjfp+cF+xfMj/NyxG9b5pCmpQ
 L2IuzRRsJKU+XoFC2Ap1RAz0QQaTS0NWDrHJjPWVb53Kogp/tKpLmIG0+nJDxxtPx4iW4
 009yXBtxFEI/MbhPpZDUiOvQ6kAvBjQpk3nciyak8AepJfoge0p+uf/FTNnHbyDOGkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791172902;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
 b=oOnmSEurN5BLllw5pc4BFeRaIevspNrEIt5UoqM6Msmwwz/9Nv37nwj5qFO+vdQio1A0
 XpSf+vD5/jJfB6GJIUAXk/8KC/scwrVpoVD0ooBChA7/n+zIuNnYF/LnQXAw4hiCuvgmi
 wHbLZ2u85PbBYF6MY9HzPR/r8wA6+0JWJY9KvfULcd/do5XG+8hzovNi8QeFtd4/m4Gca
 vCNVKHc43iKpDZn7rpBFmeJ+/AA/u0DAKEPAIEWdur9YuNRhOb9Pz7423Ke2ZrQeIhAH/
 l2m7JfoWtpQIn94L2NnmVIf/T1NKYSeumn07WL3tvQYg5uFw92wpC4bwJrIrEX+JG2w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=kf6qJQJR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=kf6qJQJR
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FC8F40068
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:01:41 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso1376373e87.0
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 21:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791172899; cv=none;
 d=google.com; s=arc-20260327;
 b=d4Q7mtpP8tgNBWCCD9Ofx2GuvF9XEbu2Ofnj0vF8ajVFscsDkotlCkvCEMlHfguQZ8
 zjjRh2/fCDV6amYmbN0MEjiEcZojsmMf2lqauL92xFGMpzr8OO6emXqUkhyMLSZdVD/X
 epE0BTcICYklRJrx6eq+GdX0tE7YfTzz3jhn06Ee+rHJAhDF+UiY2OZo/NiQahFwtQgb
 uqgjhB+V639PNHFvF/sOPP9vdp1PSGJYHuGZUuiXyjZn5KfRpQO8fsWR5K9wgmSUtdDJ
 kFhnwSlUVR5RyGcOcaEMkjimZ/Yt+3fW/Ox75UqZBpuJ02GlmKqrz3wf+cvSre1Y+iXm
 ZSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
 fh=JlDnpPVZd5zD2RZlUuoPtiX+rdCnNugsW94oWXgafvg=;
 b=JFFwyhUuFPX98RL3e+NfTb/gWO/knDdWMPQy6coZt0oUULPE864FAOiKRt4rM/DHhx
 etb5SymUskW3oaTNK4bSW+lXVLUG97zgX8a71HPiuZrHRXzg4KU/5kICLOX8yVVlDSfT
 CWfs4BVN15tyPMGGNAhYA1M3qed6yFBy7sta1Pc8KQd/1bb161KiCl1oyManwPG2TkIj
 TL8YkQa07LRnPa6hKp6+b5NnGHdFDH7fzUOguFzlT6zbxrUk9sgxRC3+pC8CXI44XMs7
 5tzJXAIbwCgHSQY0DvF43K53pF0KEtyzS41KPYUyT685+gCLZUtuJbhfsi+uQa7WqKSd
 fkwA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791172899; x=1791777699;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
 b=kf6qJQJR6u3zqn9fuQNSy1V6/hwLiFiCcKHDNkuk0Z4LbvX2bptNgX4zuhwDvp7QsV
 eX25lBjZ4f3mgMprWZDbs9tABzPptMyfwOWF9odgTaYmeJA1Nn+jXxJRHmkumTqHViWR
 Ax0c8EN4a+/uUTVhuPJj+UKb/KmRRiaUYBJwcwfaXg2W3N6jPG4/3N7Gi+GZQJydaqhS
 RP/9toczdnm6T1je7LeQvo1umXrIKAuh9pzCzAD++hZ/9fApmK7weSgfZXWQaGfgTjlv
 61JJ21T0j0qWahncAiDyWoe0hynmY0IObg5J2kmxOb+8DJSm9HQfxVk/tjFhSnMhhbPn
 9hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791172899; x=1791777699;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ao7+p6RDgYMkIiuCVlgbtNJu5c7khdCuofPhfs3mnsE=;
 b=xjLq5se1lpxeh3xiszAxykzrn7PIpBJxX5EZnvIMJ0DothRoEvo1VVAs0OYu06uwai
 uJhXbbITipOjHzFOoeDCa49jk5gwk0Ta76LJh0/YfCdnFh7mrR8uadxJX2PFSjJKWr/0
 620NS7OIJrnwReiO/gIiVLEJBHS8w9pYVw1bJW8l3T0AkpjdtcLs5ubt1rLGfPxJiNCA
 DBwjKlaGmRqLQprI1kjBYfhrEYzWsJIrwvvH1R1m2Ew1J3rwQl+7XE6BUmnbxeld04x3
 Y2bEYstbWZVqfhwaus3c/CclfDFBF58iaoYUqucjyveeJEeiv4tCoGmZBOrPJE+u7fe3
 w0aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx8j/sW/ucx57SAWyzWVmJX8cgf1JoWEvxeV6rDe87fvUsDQZTP5RBhmkb4M1DkII58FQS7rE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKckgzwuDlYsPv1IT04csrHRAUy3BBbRAk/bMaJIHQd1ib7BNrh
 iPNvYvAgOXvkI0bSDz5xeAibBbStzMd+7zhaQjEeL+XMyidTgnvIvOxRld1NC3zVgVFwycsKIgh
 ZsRMedThcDT8T0RccWnYhrzrD5OfyEqHG3b1k3c8Yzw==
X-Gm-Gg: AYBFou06ex1IBfG49CO5iLlioxTQh74uG/LrxBYod69LAxkhkQCTHLF/TcPhQ2/V4OY
 WsblnMmCmX+pLJvGdYFEnCnhTK5A37IsYJklBi0wRj3c1KcTXhSRxfPRHVqzoQ8RdcWJ/tz5m3c
 KstNhFzEvm64nzf8j0EH8bjiOtszaDtWVXLkJisYp6kAfI14QHe0KKjsFdwldmu+aOwuRSF23cd
 oApk9ziDX1qJRm54XbemR9/ybfXT/FBQHLbkA3558ROO5Cvbv8w9A2SOZYkQAkl2Qg/HAgI4F2O
 tKF3ZCNqMuoUJ3bbxC/aiyd5fR0rTGPj1BobBK8MAsoagBFpubK2B6xbY5pcanMrM3slD05jV33
 IqCKO4DMTH108uCqEgt36SRXdC7jRDfPhWaqAgxt7+k0I3h2UJUxIMZyYzM2uGBWgDe2DrguYZS
 TT0dmk0CQPOBMWpD18He5/NfI=
X-Received: by 2002:a05:6512:130c:b0:5b0:137f:9476 with SMTP id
 2adb3069b0e04-5bcb54419b7mr2126261e87.16.1791172898268; Sun, 04 Oct 2026
 21:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-7-71043b29630f@riscstar.com>
 <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
In-Reply-To: <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 5 Oct 2026 12:01:25 +0800
X-Gm-Features: AclHuK8pv0PQhrYDmhW7MrzVAyb5T40sRP7bFz4aQfp7GZiDOrM1w7KMgKtL6ZM
Message-ID: <CAH22mJw3MfVyEva=CGgaEp4y_V2cCv-=n3vz9oKpHtkjsScAPQ@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: Andre Heider <a.heider@gmail.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
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

On Fri, Oct 2, 2026 at 8:58=E2=80=AFPM Andre Heider <a.heider@gmail.com> wr=
ote:
>
> Hi,
>
> just a general question related to this patch, not about the patch itself=
, see below:
>
> On 12.09.26 2:37 PM, Eric Chung wrote:
> > +static const struct {
> > +     const char *eeprom_name;
> > +     const char *fit_name;
> > +} k1_board_map[] =3D {
> > +     { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
> > +     { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
> > +     { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
> > +};
> This maps the EEPROMs product_name to the dtb, just like the vendor fork,=
 nice.
>
> But does the BPI F3 really have "k1-x_deb1" in there?
> I know that's the fallback dtb of the vendor's fork [0][1], in case there=
's nothing there, and I thought that was the case for the F3?
>

k1-x_deb1 means the internal development board. And it could work
smoothly on the Banana Pi F3.


> Because it seems it's not set for BPI-CM6 IO board either [2], which then=
 makes it impossible to distinguish, at least based on the EEPROM value :\
>

What's BPI-CM6 IO board? Is the BPI-CM6 IO board similar to the Banana
Pi F3? Is it supported by linux kernel now?

> Are there any ideas how to handle that, yet?
>
> Can we distinguish between those boards in the SPL based on something dif=
ferent?
>
> Or can we make up our own strings and let users write that to EEPROM? Mai=
nline and vendor technically allows it via e.g.:
>    tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
>    tlv_eeprom write
> But that's assuming the EEPROM is writable, which I haven't checked.
> (And I neither have a F3 nor a CM6).
>

tlv_eeprom should support to write EEPROM. If it fails, we could
enable ENV in SPL. I have a patch in the mailing list to enable ENV.
But that patch was abandoned. You could review the mailing list to
reuse it.

> Cheers,
> Andre
>
> [0] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/=
include/configs/k1-x.h#L28
> [1] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/=
board/spacemit/k1-x/spl.c#L558
> [2] https://github.com/openwrt/openwrt/pull/23231#issuecomment-5943699070
