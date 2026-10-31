Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B02606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i5NvOfdb;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jf/PAe95
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06DC6606A9;
	Sat, 31 Oct 2026 08:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWc958YnyJVZ; Sat, 31 Oct 2026 08:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AE80606AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435655;
	b=odzddY72PFfgEXiyOTpUbJzHXvWr+kHA93NSC39+6qtEGjq0eqThGnFRLBdAjwPWqgb8
	 F/bB2d3Djoq7YOjPUKC8BXopYY4mV4qw23QZv7XXT93tUOMs+Gu+EL9FGl3H8X1gpPWDQ
	 51VCB9eUCEmtqFF6gPSlwsSkHGId6/4CjNPKlevmBAqyVBJ+/liuQsZX2MUq+qcrD26hf
	 lzccfSxmqjHWTDWeLnhk8Tr4zrBngCPvmfaWqLZSiHLEAalTJAAz5WWh00/Wz8a3uocSP
	 Je84iZu8rSk5QXgJmsP7yWSqVj7klnAGvSpC8MgOOFbSm0VG0ra8hr7xwt12p5+pjhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793435655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
	b=ZKU9l2GzpjJixf8c9SfOxYWlEHeW5rWmSdqMeaC8wxjDpOsH2sgpWDJBRxtHJ8MLgjmH
	 U1d2EXkerSZLSRHkM2/LRMVQ9dvta+UfthwIMcHpy7ANIwa6LZOU8l08wvrYuJIkho8HO
	 S327B7gjW+UO3aJIaYd7m86+miss7POLySrSxgoI16pzqcbC1dN1AAXZoODcw/k5maV+H
	 tNjMr60j8mAJyUhlzP/9xnoakIHeOm64cK/rL/fENKQ2/Alcd0FMCl4H59kE6vbcWGWSe
	 lEV42Ruc5NZYm3HcZGrw5lt9+ZgXF7BCvqLOWjkxY2I0O+chJSj9OyclFdZ8vDWM2tw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793435655;
	bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5NvOfdbwTeusHBntW+BOFMeL2Gp8mJfv1Rlzl4HFEw4UY/ZtEHDXEEICknvtloBt
	 G1ZNp691seUDI97Upt/UOjd57KpG9Q8Q9QvPDnhqDxQv31g2XbmDkbjvftj/l/zbil
	 73RM0zx2HgtinpwPXFBcFT9jQtzZzgRMS0/7A9fRR5Lf7RT8QYxxZexGLh45MG89Il
	 fMfAmpHn0AIyA8oi0gxzRWJWXSP7KZg6Mg1raN6iPjm5t2lXA61LYdLdbioJ/nC8aA
	 JIAGg8eeWb8+WWDexF+rlEqSufNWjOhvsjaNgVGSXBV+PtPTaqA2Zu3KD91fe1xu/e
	 +KslHFZTAg1QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AE80606AA;
	Sat, 31 Oct 2026 08:34:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A29344BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93FE7400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tacggr2dzVnY for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 994B740057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435653;
 b=krYqwOpFY7r0mkGEb7LDcNU7pNItKt8JOpVVuEhskMM/FL/NkCR3o9yMEobbYE4VI2/j
 S1ELRpQ74EbjbIvvYT86U/Ct36Bct1GqdrdTRHlgWZI70u7nV/UpRAa2pzGEgJ3NXZcym
 8iQKr/krIKAcdu7cBMrf0eI8SMaY0Cns+9BiYiQpABk5xGnRTBF/CUR2yGHYhwdHk5SEt
 0DlmT3N1zQKvTDH41Fcb1NwU7ve9fKwk6D810xc5Rds37cy4XnCerI4E4BAWTsHzDfC59
 sMR/ZxSOEhhYebVP7n/MAyQE4qPyo1ZIaeKTjidNrgpOIuLOF0RKeamU821KSVBd4cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793435653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
 b=pPSOR7qk0+ahOTXBwU5sFN/CAKy9r7V0njDkYWO7xpHVJISy62nvBmt0k09WLurIpKvx
 20i8/QPPfGer55zsdVv4l7e261tk7ZLa5vjjz8tkJ/SWAwjZdS2PrZqgzp9uojhrzujWs
 Vp6xyT0dKO/Al/iGBNhb8vJ4TCQzr67/v2I+Sbd5Tia7Aywh+wDE078KjOSeeYFIIYEec
 SVGZVllquzGkjKGLPmmWockDry+PgQKiOXnluRGdDCLNRxGjJRV3gmHuRL1AVU5QR59W/
 x4GkYxkNi449Fl1G/WAlNt1Hms7BnGjjqRx445m7REDR5LeFSm94GqnJ1R+us6k/Kdw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="jf/PAe95"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jf/PAe95
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 994B740057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:12 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b4e814214aso1234033a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793435650; cv=none;
 d=google.com; s=arc-20260327;
 b=dHxhW3P36WkjFdRmBo+dz2T8cWpSQHnR3W8HgeATZSJXoYu5EaIP2gpCP2Qx6daZWM
 NitfB31TquF3w5Bytw4+ePTGaFYcEl/bpaRgNPu5WBw92ThE2MeHaq6CJT83MdvNpGyY
 mhPue+wlpkdHLtgKKnblU8+q9JwEA2PHK2+aruIyy4j4QDZuH32F3jjS2WRx7d2YuZIg
 4Z9ju0p/Xi42lBlfkNAKbBbsZS55s6tCIF+XP7H7pycd9N9Q6/+XRnFw2ogTFVR3gXwl
 dirSN1kxUg4jILM1mpQ4ttoHlfqY/6i5JubpmRj20G435IB8/V3Tl7/fZJnXwCp49NyJ
 gxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
 fh=VN98Y0auae+gfOO5vPHq5BCDyz+eiCJJZ2MVhrlBNbY=;
 b=B2xPBuk4x91LEApioLc6Y7rEWfJB4m66cO1jNjvMrPeo0ORb9C+i2LVeQnvrubG/xt
 8Tw7DdVj2LuNfX8ZjnoCLpb2SIezLIP7KKV6K3IIE13DxJ/dLgChTsKSfL9r1B6AiQ6I
 L2STKv7h1n0t8GHH456mVs/aZkAsj10Lc5T2UzFv1836LD8Wh82RQfz6y9yo2JCT/NRS
 ZCpJrgAuypDer58YgMQCnOM7iIk2giW4jTBDCC+ty2CwBVfDBxDOMl8uR2M1PSI7SuJR
 3uLsPRmye3T8c/XsYQ7+l0mw4FsZ9zGcZhd4uB2Sz75fkbJ4S/PbJ9p30x5u5ZzlxVsM
 dI6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793435650; x=1794040450;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
 b=jf/PAe95YDCC1d0LYtzTgADsTpNQyex6gmo5YXjP7YM+UyTHdIIlLyi6smAs9IjUTj
 6VpTSz0eTVnAe36TbThHC7dRpHZwYea8UTKyQ3+3zT6e9yZvws6LgMYzH8Xx1GxV2dDk
 9yl8jRxhjZtkt2Sc2g7FeinjY0hA/YiUXQDS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435650; x=1794040450;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yLrwuusIiuKQ9kNbhhrzOCcx9S8lN7WYQ2jkTxrU/p0=;
 b=fMrAsD8nLHfwkhRiAKF/0GoZbx/0O2dvQQAl6lEMKtMwj9vWeEA0RGMpoP00THyMUx
 HkXadHfsvBTQU5VFprL6sWEb1NWNuNIQprO0IljMDpZ4knbqmETxoLx0xbyGSg5XC8QU
 8qobw+lvPasddZvSLyhBimGACMujw8Iwum2/ZckoPEsMxdGzz3lGgwCkM4TyAT1/aZHI
 gpWDvZFz0aphE063rgBvZiXrNtS5IXsX2VKvjre3gihxhwr51O1QKcxvbwXSLjIifPw+
 Lw6SmDxrOxUPK3uV6cKvgE2eIZ9ocyF6liiFSrQL3913pvQqajC/YQOhvztbTniSGib+
 Qebw==
X-Gm-Message-State: AFq9FYKyNcF+xOhvmiFu3tduaFtMYBzThy+t2DG/3+7birvOV+pwOlY7
 Y27H+bewD/dG3D+v2/Ah2JTozKNzpz2NdzR4axQYsuiQIKz0oLYJrUruKL4kbm8MXWX0y1pem1P
 q/V6bXRoJbyW8ij7zQv19nbTji5AF1BLAI4/scM/UuSMnZSZ6K87vNA==
X-Gm-Gg: AYBFou2gTHOA1nwGtIsHH6/dX+P1ed1L2WXEwsdxSYKx41Te+v7qUc3jXn5o6Ja2CFj
 jW7dv6wC9Eql9kmu87AJwkjnMjM1w7CwgokJIUq1uQTLz0rwlsucQtK/O+QYoZRpPSEX8wMd/6M
 jVEEpdxfMWvsZ9MyFYcbbFQpaBkgVu/NAHHieRwVw5GqQO0XfyUSJ7h9cehGF2Y2RiDSiBFw6JJ
 633OiN+9I7MGIoHDoPoBewY6G5xRzyEvJubwlh9Bm8roxGXBkBW2ZXZoYAJaGM4RwjUhg8qjaKh
 iKorjbOZM/vCQHa3RuHVDqQOplvl5GPefwUMFGQh6Pe+MF1T2InmX/09EXKvI1hdgITjiQwUAHt
 P8axt0WP9DrUkKaMuJHsarKZOlXCV/doQEGWxCGyK52XEhKg+Wzxz6MTgl6XRmWpqcBNSypPd1h
 WH53kJejr9HtoK6363
X-Received: by 2002:a05:6402:44c8:b0:6b3:cbb1:a365 with SMTP id
 4fb4d7f45d1cf-6b4d4689105mr2698327a12.25.1793435650237; Sat, 31 Oct 2026
 01:34:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:34:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:34:27 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030143843.467968-1-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:34:08 -0700
X-Gm-Features: AclHuK9F2-YBurDpG8b9Gkd6li4NqF-skapwHljfB3l8dPEXKXK5I4w2ay5J8Ec
Message-ID: <CAFLszTjr0U2wcEJKjkxhaQFGbj_rsTmkMrBBGSOcR-2vXFK=JQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement the efi timestamp protocol
To: felix.moessbauer@siemens.com
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Felix,

On 2026-10-30T14:38:40+11:00, Felix Moessbauer
<felix.moessbauer@siemens.com> wrote:

> The protocol is used by bootloaders to obtain timestamps from
> the firmware to measure boot delays (and where they originate from).

One thing I'd like to check before this series goes in is the U64_MAX
end value, since it affects all three patches. See my comment on patch
1.

BTW the cover letter could mention that this protocol comes from the
PI spec rather than the UEFI spec, since that is where people will
look for its definition.

Regards,
Simon
