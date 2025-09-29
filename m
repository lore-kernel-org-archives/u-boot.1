Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3718ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACE883071;
	Mon, 29 Sep 2025 16:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hiiEmABl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A001483189; Mon, 29 Sep 2025 16:25:47 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82F682A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26e68904f0eso46711055ad.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759155943; x=1759760743; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZVu1Ev4EPydeL5fnj26l6Koj9nMHEG/HhYQFo36dyY=;
 b=hiiEmABlBJaBHpbxhbbUovFoFNtOattItgQOZQ73SG+gBNGKOtDRANyYLqrVWXwtNN
 jXlzIMIIzxRe0IStMVtqTbT5TbCyGWLbfoM2mAu7OVc5R3TyaJ2JWdle6ne+GfK89FOx
 VkT2Iad6/+j8toFivu6uzlE5NZ4ZUAI6juFRm3dy5+AbYkt/C5Syqdpw2vqqpBFf95eS
 T4nOSCwv+Q8/SVkc6RKJdZ6Ij+cMb1GnV4b2Z2fhP/Gw85X4unF1m2GyLL9HF7sF4+dv
 QRLOVcQzdrvW8HPYRyXL60AQDkY1IGwPj1vYk2N4yw04aY2mtfwjPOMjOmeHJwBk3jg8
 SnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155943; x=1759760743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZVu1Ev4EPydeL5fnj26l6Koj9nMHEG/HhYQFo36dyY=;
 b=hsv6or9VN3vproWRucmuEfVgAkoz5FarTduwej2K5ngLQhhVcN/ovDG9+OgbjAnp7p
 YnTJKmmmRr7SCfFPOhQACiebfV/G2h8gfvfqp9tnuR2OUSNiYVP0L++6JjmgcLAUKorn
 48nubyPL8R+oMpaqJ6o9/Z4IKobh6LUXMR16pZFYnMMaJ3b8fuZWieFbFyGmAHidPfJc
 Sp41bpRh1RUa1LfrXJq6+uCRo6VVGtZdcgZAnOrvC4thej7bV+2pQpQTRgKHhIhmFYN9
 JFEWcDgFhJ6mZj645ZH9vkibmGF73iVDX1scxH5h7siuoOzqUDqsBqKKYByFzRddQ1SW
 +1vg==
X-Gm-Message-State: AOJu0YxmOKELe/ScaPvH8wWjQ4C33ZM0EZ8dkpNVDjnlO1JjjG7LUqrI
 +Gu41bdWE0+hCGR5Bxdxunbm5+1HJUHrb/thkjFbwnv46xm3G4S5OuiF3Zbtb9noJWTpA0rpAh/
 cMhiZ0/KulXiTX7iLZjn8a3dEh4zzlL1kP5cw0G1kYQ==
X-Gm-Gg: ASbGncsgekbjpKKKNizNxRSzbAKq5SdNhNrMyAGIXa4rkzG7N7pC6MK5hzsaqQarsyl
 InFV4A82Eroztzq57+xD2QeR/F0CrEz/ljwPZBqAWFSWdh7AmndTl1ZBH5JtR7uxo4fzKWdEAAl
 E+jK9NyMYJ4JkgkTlV2pXOO+JrirYBWZXHFQXXe29m9D6jDIEyteYZdX8WgGKDlTWu5+F0fxG3i
 Mz1YyR/
X-Google-Smtp-Source: AGHT+IHEm8D8/YxTp67XoENX+1vDpvz+6q5r43Tj8P4pM6Mez1QlS4RG+ImftBXrMl7BUQwJgq007ZV6AWCueJeNji0=
X-Received: by 2002:a17:902:e84e:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-27ed4a06c9amr219184755ad.2.1759155943241; Mon, 29 Sep 2025
 07:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
In-Reply-To: <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 29 Sep 2025 10:25:31 -0400
X-Gm-Features: AS18NWCRsSBDlu9Wq4qWmCl_-MyGXaI-LRKxbeqjiZgrqWtKT-NWrP0K1Zs3vGs
Message-ID: <CAEfUkUKiyexSC4EUkzuchXJ25J+jGV5PSw9+tFhm4S7tDUE7fA@mail.gmail.com>
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Harrison,

On Fri, 26 Sept 2025 at 12:10, Harrison Mutai <harrison.mutai@arm.com> wrot=
e:
>
> Hi all,
>
> We recently applied changes to the transfer list library [1] to correct
> the checksum calculation. Previously, we used a simple byte-sum
> approach. However, we later realized this contradicts the Firmware
> Handoff specification, which states:
>
> > The checksum is set to a value such that the XOR over every byte in the
> > {tl_base_pa, =E2=80=A6, tl_base_pa + used_size - 1} address range is eq=
ual to 0.
>
> This discrepancy creates problems when interoperating with Bloblist.
> Should Bloblist=E2=80=99s checksum calculation be updated to follow the s=
ame
> XOR-based method?
>

Currently I am working on patches [1] and [2] to enable Firmware
Handoff in U-Boot CI.
It is pointing to TF-A v2.13.0 so actually the changes later that it
won't break anything at the moment.
Do you know the plan for the next TF-A 'non-RC' release? I think you
can send a patch to update the checksum when the 'non-RC' release is
done and then I can let CI point to the new release.

[1] https://lore.kernel.org/u-boot/20250916161426.32259-1-raymond.mao@linar=
o.org/
[2] https://lore.kernel.org/u-boot/20250916161230.32140-1-raymond.mao@linar=
o.org/

Regards,
Raymond

> [1]
> https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42548
>
> All the best,
> Harrison
