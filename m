Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC3ACA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 11:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5853360B21;
	Thu,  8 Oct 2026 11:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H_RRDD7CyJLU; Thu,  8 Oct 2026 11:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B46E60697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791457830;
	b=f0hkslsdtMFUmeDpctF4nwOIbzybEahwruTwVZGsN5YYjPyl/dHV3i6e07ex7iOitYqM
	 9DogbBbSuJ5OfaVOAzj9KLIQfPNEBZsJ0isadCgANNDDuWTc2/lySM1jZKrDFWO192ZDW
	 rhMz5lY2jZn5HchTEtUPCQp3hAeTm70xYE2yjhs3aujpAKDDTXDL0//FDN+QjthbhX4S4
	 GUbB13lBE86F/bhaJiIgcd5kBHBRDVRwdgA2fJAqFBsZzYQhtWUyrUnIKJqF7Beq33rWz
	 oZHaysoOWZiZ7Io3/Yn/mPIfLWoWn+MuMXdrz31mXx+Bl4cim5rNjosx3k74s4LQciA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791457830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
	b=drqbEboFWMZ/uZHf3l41o4Z2GV8FUS5h6fC7mU6zAcOCx3z3WvaZhRdpy0neQTDA4sqi
	 cK352HasrwicXf03W31A1xRZkMwXFQ7MzX9MDceJHDatbWg/Hq+8c6OVtwpIH6E7mZ5Zj
	 7UNwz7Rcp6F1vWY1k6auZrzXSD1nVpkvxuLSg4zDJ3dlWYUfYA6f7UwiNgXNyzLkkhIMI
	 k7wL/u0iADjheiGrHBfojLV/OvbnhE+N9itlB1HvVRvhE5ZTzAoEMSpv4qPxkwUR7kJLp
	 3MiqeoH64MzBuSNfScS721vKlUMHxdTWlweFfZlN5gfwgsn7bOJveGWRFfKX9sJ0kTw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791457830;
	bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YMk/Xtum4/QS9e8a/FsWzSLQjTrc1WiWoTu2tHPzOMdWDJfn4ixtqNotedqsA17XQ
	 DS1BSb2gzFfK33obaUMhZiw/8UH3P4Dfk1bd7kiTtDkCfrEgA75Tel8cL9e83SpiE1
	 xRlQeIc3nrmV23knzG5cPWAuAZUpjx6zJ4xGi1FhR/UbHJBcdIuasMYlLnLCbhuKAy
	 GFzzf5DYwpS9WHMjL6FhVyrdHpmgSCa6eBekgvXBoUfRfKYH68WUKvuHZCYWiuC90X
	 lU6fGSATlpYnLqnIG89Bql2Q8ZRCMboD/R1xmOA22oSxweGtOK78KjMSagX85ULnKG
	 r1QJhQ7F9Qq1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B46E60697;
	Thu,  8 Oct 2026 11:10:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A62C1D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FDD3811F6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zM-IBCQ7nz7L for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 357A2811ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791457828;
 b=TRT8wx2ie5q1XbXq0RthhrMTcqA+OlZHD2E1n4FXSQIB9NBxlmQkhqcFEp9bB5lkRa3F
 TQx0bAbm6tNI75r6n0xmJtPOC+IfFb1y7X8WUOpmaFM3En18cL9QcqWr4AxJzco3Jkjnh
 zryoIbluOeOYSS0h5SBz8ZwywoI9Hfl2xtuAiaGeSXaPG8hf87+ZO4pIxiMY10pTAOlBV
 LJ+tFX23A/C4g0bKJD0yhVEeTR7A+Slw+hSKShEIW6zjRx1srOYhft6KKkXSA1e8vBpQp
 kz3i86n4vzSiQR/xkgpRgXXPmtXd1u1hrfnxRbkENA+viVUG45KnO9pO+oFFbpWZy+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791457828;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
 b=Z5gArNUmWUZcm6FNl1qN5+GvOojZS5d4e8bM73u7YVCU+xcD5GbQ2jI2mcBQ2bZXA5Vd
 9eZt06WzRGBiXDwKI5T72JNFMXRNzcNlmCDpmqRaQ4DXUMiuRV/lOaeBYYSyulW67hf52
 rT2pE5D8Q/UTgnQC4qN5qWvuxs0vI6XEEYf7GV+GnPQR1tvF5PK9sIrc56o8ZHn+IpbXd
 kUg23/bSeEHU+U72Ukf7pg8IBgz3CqHJIItq5JSM2tqnxculsu4ROwxtIA02Aeg42kosR
 sH8wtn1R4UtHFfOh+eHqAPC7I1kb6zv/7/x/IA/gmgztg4kISgbn2xLG8/QtQD1TxOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uj2r6880; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uj2r6880
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 357A2811ED
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:10:27 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-677bc4704cbso3004089d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 04:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457826; cv=none;
 d=google.com; s=arc-20260327;
 b=OFEYdloClVwwGPAJGmRwutwnuKTkto9B59gAjJ5dTA7bZocHQ0G0qtwuGbx0TMbrDh
 wLEDzlyHfY6HYIjgrmQpD6uKgOatBhbQM/+YyssRjx4oBD/gcyURDvLEU9xau2/1MQBu
 mTGInMwA7oal/ocjb+F6gnvLVdA4PHTy5cbRXee6hr8XZ0PM7TEqB0id8kLnY/Y+8P7i
 eBi2cC8mWPRdQlBBEjWGA16L93053C7yvMzUCyB08L7oB/SahAXHyp54IIkyoNDnzKa2
 9eBxZ4xGWkhI/Q/JoJxxAxEarcAMctaA3mHy0dhBrLxW8c24KLEbY9z1rmWweVgb0vmD
 xQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
 fh=/jawDDmWOyu+gXtALRIS650Ut0HSDA7jW+OhxcKl6A0=;
 b=gRKhv3uZlWdmsYLHZY7Xti+c3kYiDg5IPvmONY1L4mME5rbl/NnGWFz9sS1BKQIare
 gouZAFGbMG4mkXZkG4fXjMmHcPzdE+x5b7olnAmwhvTIemSJMgeExsqDqf02ZTUbzcbf
 K06J29NPs/O2JNNQOV3jABQBUwZZVdOtSCnv7nF1jh8svyt1fbak/LXre89E5cMgx6v9
 Ut1hLqHLDG3DPZnoeGHwyTdDj+qDtBncaetMB+pH73QhLwLSD7l//x3b8kO9OZMMyiZl
 sWswaa2z3zOc6+yOQFGJZtDONOW2CyIn5ifCLnCIzwXbOapBkl0zsbDs5G9jKR0BtCC5
 fznw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791457826; x=1792062626;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
 b=uj2r6880Br+3jMEOd3sFGYvJRTyXazgF+aKIzEjHHD7Q/KDqZjrYxpmiUErkXv86fw
 GucYmb5BW8DbueE6dk/sELG+X7sw14GRVuzNEjB11ZhZcHCN9Cl0LvnGUMFNIyC1QLEJ
 /dKUsrmfxQ1FF52juWq3tCq437OY6Sht9GWgzHZO0ZLIh6VZj5Z5OxBBbpTPpGo6mpEP
 VRzI1GhQ41J9EtBUj14pniMHP0DusLOrjiQSgmTYYyFd2D10DWW4iAaEyNxyqLf/ruCf
 WrtMGK4qXE9j82QQFwoGdLPGu0ORAocSB2w0pTltrT81ZMF68qXS5zPnxG9x4qt2Wwk8
 zGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791457826; x=1792062626;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NKzVmlDAxgSKAwemPjcXgpPzszpFQG4ijEz/BxVsc5o=;
 b=DJ9nMkpvuoGM5NPo3QpSCPrJkrHaMHJE3MzAwcb8pBXjoR9rF5qr8QYxPsAw25ymzG
 JB0HuIiQxDGdbJaEoecVacw7w8YPRHxYcwx1SPNLr4Xot81Cq2MPBNYT5m7N9O2mX9MW
 xl+7YvJbLnPJ+RSfBr15YWJwNaEF/ZEqkYO5xvleFUb5bbF/MPYiJQlNOI50QCmsVSWP
 82V6n03QCNc3tZzgeK7vHPbWeqqL6/EmarEU/q2Hor+PKPnw9iYHl3dDGe2mhCyejsK6
 AlMslahhrlSOTA6B1mEq4emxb04HdDMex6B5gyLT1HbcIU12WgsPStno6oYYnX6TGZdw
 9qvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1XK9CwGNoh2w1v3Pn5PPaM2Y5Ll5q1kSdOiINv3bj/36AyrszhvSFCDYlBpIBDM4uPItlWro=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI1fQvfkJ/eVi9mZRnJJRJEe8KoLSEu9sn9IzGPHMuKpREHxhqf
 qmOMHQ4JOLRUTclSr+31rT4nonnDRT9blTfjSz46wJg9V7tg7hyOznwva4HtBdmsu52utS5ebMX
 IYAwrvxtyMT0t73pSWiTp8QJRJFxHdOf0ngUMTo/ytGkhI/ENjSLz1yA=
X-Gm-Gg: AYBFou3vnWm7qjsyHJAtutHWKmJnA018A2znDEfQfCmM8Css87pIECPQQvJYsUkjQjA
 j0Nw7SXtn+jg4I/bLGqruitMtZKM9YP94FVh8Cdqs3htUvwOi8TJxeD2KT5jos/Tn/cLZLy2ZMM
 juw23wjdBt+cslAZR2NNnyZedBQ64rDcHX15KflVinEw3owGm3th6yY/Astgp71zzMtnzN3DE2Z
 6dOPYhZH/kZwe+Ckw3ZXjAc5JyRYwGIIbntqd64NCmQ7yMg3ilcbJXraCptSSZGK7RPlV0rUMU5
 zO44npmtnfn9YyH9BgG5PFHx+/7MBQACQIUTH/bFMZeQ7OV/jd5OpLJ9gPVo4/5b5fnRcvcKOes
 UDUoxeCoEP6e6Hr+yFXWOx63J4Yr5nkdbZrb2OYmCmgg1bYZgZni0brfHo0P9+krh7Prt17mDmR
 J5NMxL5R6+OfEAqBXPvWU0ri8UgD3M8TES9WaA9Qyny2wkPUDaObd/S6MjBr/fcVjo35Y4J6UCZ
 y2VcNiG5XkpmVRX3Igq3BJa5vhRSkSCDARf81qR8OP7hFbtYaU8tE14JTU5GdCOiKarYEGgVXSG
 mnSKwjSjgIiXlMcabdm22Fq1llAg1ipPc6OpspEguhRS3O8Uv7EEscTNiAkyUe5eREre5IU9mCW
 1TYnK2i08Uu9gq1b+dYA0EJo5LBXAwYFcv/UQoXuVTPYcOBjDXL1nEw==
X-Received: by 2002:a05:690e:120d:b0:672:99e0:ec0b with SMTP id
 956f58d0204a3-6790a54bb2dmr2808448d50.163.1791457826460; Thu, 08 Oct 2026
 04:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjLP6PTPO-MpAsQGMVrZKRy6o==0D8iq9vp+36bmiU9hTg@mail.gmail.com>
In-Reply-To: <CAC_iWjLP6PTPO-MpAsQGMVrZKRy6o==0D8iq9vp+36bmiU9hTg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 14:09:48 +0300
X-Gm-Features: AclHuK-YA7FrMm4AgU8UALwB_obvEqZb9gOxYrQFrUlFuZaYMpC6gwZF4tT97UM
Message-ID: <CAC_iWjLifmyDHSHi0f92GG-MAJ_O4zLnyEXEJiQSV+tmUk0tPw@mail.gmail.com>
Subject: Re: [PATCH v1] armv8: mmu: sync emergency page table attribute updates
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, 
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

Also I just compile tested this.
find_pte() isn;t used anywhere anymore.

For the next version, just add the argument to find_pte() instead of
renaming the functions. It make  the whole review process easier.

Thanks
/Ilias

On Thu, 8 Oct 2026 at 14:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ashwin,
>
>
> On Sat, 26 Sept 2026 at 12:26, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
> >
> > mmu_change_region_attr_nobreak() updates only the primary page
> > table, leaving the emergency page table with stale attributes.
> > The emergency table is used temporarily while the primary page
> > table is being updated.
> >
> > As a result, speculative accesses can reach regions that were
> > intended to be blocked in the primary table, leading to XPU
> > violations.
> >
> > Update both primary and emergency page tables when modifying
> > region attributes to keep mappings consistent regardless of the
> > active translation table.
> >
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index ad232435eb2..f351f11007d 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -173,7 +173,7 @@ static int level2shift(int level)
> >         return (12 + 9 * (3 - level));
> >  }
> >
> > -static u64 *find_pte(u64 addr, int level)
> > +static u64 *find_pte_tbl(u64 *root, u64 addr, int level)
> >  {
> >         int start_level = 0;
> >         u64 *pte;
> > @@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
> >                 return NULL;
> >
> >         /* Walk through all page table levels to find our PTE */
> > -       pte = (u64*)gd->arch.tlb_addr;
> > +       pte = root;
> >         for (i = start_level; i < 4; i++) {
> >                 idx = (addr >> level2shift(i)) & 0x1FF;
> >                 pte += idx;
> > @@ -211,6 +211,11 @@ static u64 *find_pte(u64 addr, int level)
> >         return NULL;
> >  }
> >
> > +static u64 *find_pte(u64 addr, int level)
> > +{
> > +       return find_pte_tbl((u64 *)gd->arch.tlb_addr, addr, level);
> > +}
> > +
> >  #ifdef CONFIG_CMO_BY_VA_ONLY
> >  static void __cmo_on_leaves(void (*cmo_fn)(unsigned long, unsigned long),
> >                             u64 pte, int level, u64 base)
> > @@ -998,11 +1003,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
> >  }
> >
> >  /* Use flag to indicate if attrs has more than d-cache attributes */
> > -static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> > +static u64 set_one_region_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
> >  {
> >         int levelshift = level2shift(level);
> >         u64 levelsize = 1ULL << levelshift;
> > -       u64 *pte = find_pte(start, level);
> > +       u64 *pte = find_pte_tbl(root, start, level);
> >
> >         /* Can we can just modify the current level block/page? */
> >         if (is_aligned(start, size, levelsize)) {
> > @@ -1039,7 +1044,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> >         return 0;
> >  }
> >
> > -static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> > +static void set_regions_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
> >  {
> >         int level;
> >         u64 r;
> > @@ -1050,7 +1055,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> >          */
> >         while (size > 0) {
> >                 for (level = 1; level < 4; level++) {
> > -                       r = set_one_region(start, size, attrs, flag, level);
> > +                       r = set_one_region_tbl(root, start, size, attrs, flag, level);
> >                         if (r) {
> >                                 /* PTE successfully replaced */
> >                                 size -= r;
> > @@ -1061,6 +1066,11 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> >         }
> >  }
> >
> > +static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> > +{
> > +       set_regions_tbl((u64 *)gd->arch.tlb_addr, start, size, attrs, flag);
> > +}
> > +
> >  void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >                                      enum dcache_option option)
> >  {
> > @@ -1095,6 +1105,13 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >  void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
> >  {
> >         set_regions(addr, size, attrs, true);
> > +
> > +       /* Apply the same change to the emergency table, keeping it in sync
> > +        * with the primary table.
> > +        */
> > +       if (gd->arch.tlb_emerg)
> > +               set_regions_tbl((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);
>
> So the problem I see here is that emergency page table is a snapshot
> of the original mem_map, that we only used to update in
> mmu_map_region(). We now update it on every change and I think this is
> the right approach. But are we sure get_page_table_size() will be
> enough? The 4 used to reserve to accommodate dcache settings is a
> random pick. What I fear is that some architectures, for example the
> ones that enable PGPROT and create even more tables, will require more
> space now. I think we should also increase the get_page_table_size
> size calculation.
>
> Thanks
> /Ilias
>
> > +
> >         flush_dcache_range(gd->arch.tlb_addr,
> >                            gd->arch.tlb_addr + gd->arch.tlb_size);
> >         __asm_invalidate_tlb_all();
> > --
> > 2.34.1
> >
