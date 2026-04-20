Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D2DF588C3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A559E8437C;
	Mon, 20 Apr 2026 15:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GYew9QeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B86843B7; Mon, 20 Apr 2026 15:30:55 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD90384366
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501d242e2fso2658344d50.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776691851; cv=none;
 d=google.com; s=arc-20240605;
 b=EmUfW8j08IR2+xL8l+9O1aqhSYFXscjgS33pbkmg/P3rgTqTstb63C9i7847Mh9lbx
 Ckep3NdnzNhg51WpXs3kR5GAlAbnz2GUkEudIlGI/pzu6Z3sbj980Wt5ukM+TOXdLdcp
 taDdFRl5kpb7X7s/Y0TLCwSy4iUDjqyur8tcMIXD/VeuEmbX1xZyljtuybH76kuIqSTd
 6ytvXNuHVx5M0xegm746tK63oDvprpuFRPvrmErK9shHySGvVDJvc0Bi9k2Mhj1KvW6H
 9QLxeXwBbItj48AmyDvaCnrxzaBeiOI7tpvXam/Ch3FgRFoOA2m2oIkK8gOwH+cSe4Aq
 0amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UFvctR2FH5MJkBu1wH8Y67Ayzdm1wQrjksp74/j+HfU=;
 fh=o87YjfsHObo1Cl6u5IhfEEVg9K9/GmFj88eZpmc2vZE=;
 b=Ed9nJB1gvkXJKoXlW2Y6tQIcJgF+Jm/RaJXG5GcjjwGQUDLzUfnJ/Q58Pnzw9sNsts
 z0CvcitB/xMhpmi5KIGgE7YCD6W6L7nPivzqjhAJr36l3k1hDBNymbWNatjcS3DibHca
 0gQx8My3gbiPDJO3Q96nhifYwg9E0NeExmajGJukmahGWhPeQaA/sa1tuoT8WZ+J5fmP
 j7ph3ZztiXvGPKCTheGFn/MuIHazw+h9i7arNG49U7DX+Q0+f2c3ui/UTi1rUVr5IJLN
 r3RiuFhVIUHQhi2d4WthGH6AqrcS2CnNFCElyT/aVZSYsDpFKiQpBMmWxmd8HT2h2LZc
 iOHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776691851; x=1777296651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UFvctR2FH5MJkBu1wH8Y67Ayzdm1wQrjksp74/j+HfU=;
 b=GYew9QeJ3rb8AdazPsPTokLG6z8N+DcSZ/ACg8lIAoaWSdEQr1qfvHMoalWiZeyMO2
 hYf5B+NYZOnh7ziMPzV+2xbJaZh6bjYLWrpWQMr/En0UmZG+v6JuQZOG9gD3tEK4D+n6
 RYdlEjPH1MqS3naShcNA3XhKeo4ugsrVt+XALSMiKXIWiqmOKqrGULze+b6PUtyDF9Y3
 zwIQyXUGtzuvEt70uBFFA7+63jcttxTeTaAY4t1rJh/8P8uCru+bwZ5SHU0QU9jQtJ4j
 3kFigBJKHaoUAfJH7j8wtXmoQD2ZGUjo34TcmS/LWTypeQ3QMp7OQjsM14xwU4OW8G0F
 YGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776691851; x=1777296651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFvctR2FH5MJkBu1wH8Y67Ayzdm1wQrjksp74/j+HfU=;
 b=deCupBgsAz32i4jJaYzm+cH5T/e+hTvZs0evzRn++mhjaP7GQVBCcYoYV8eektiSZ6
 xqLhJZKLZ1FpTjmVZQx9V0rf/lSVGVI2jXOhMlGRDAkrXbWETXFmU1PiJsG5SRQwJr/p
 buuqjsfkaEVtW55E8h6LlYuwusfYTge4mBa1KojfKPgoIgQqdCcTd1xb1otdP3l7GEj1
 TYW9d0OITk+ejkvvTKrxDlJo6+986/7sVD63ZAARcVhfh1Ug54iHQPjrbMEHqE93Leiz
 QIG/+6Ys7d7TsviGOKYyO5FwELH8OId3s6rOVQ2QZQWy89JPlgqvyZXjqgmHlmE/J8bC
 TKmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8phap35fnzroIe6WyOaY8p7wayysOk6EwFj1i9J+hJfrKNiUhZyAK17SlWy4ijKed2V20IzsA=@lists.denx.de
X-Gm-Message-State: AOJu0YzUQvlT+avJc5zuDY9UR3yXMNju8xp/OQN7/UTrut5Dn+9Sgls9
 9frGAqYwnG+lImqKM1YcYIh1dVpUGQcRP08SPbdDP1d7FAmGjQWIpIaqzZpwbo+Cy6D8MNk4ASC
 +YoM3p0LCK0P1FhhrQwVJBXFlAaKZ+S7kBLlhlRqRNUlJZ1PIQS9huis=
X-Gm-Gg: AeBDieu+/yJPuqGUe7CYCVkbsZbe9q3Xsuclv9334YBJWgsOuVpMi9LbHRpMr7jv9dM
 YnxwqN+bMLsHNaOFskqh7j40ZkS6i807v/bGL9+ZWYyo8QXuHKW41pCkO+HpvfWRxxNuau/kb/o
 trSYzEEFJFTwoK52bkdYqqqK8ykGeGwAcxgTV/Ku4LXa3kQzeMS72mN/moFHf2XXVg761ysCzd0
 M/M5Xg8qZDe3+JXerYVRvgl+x4TaWFOydyWo5wg0AZ38TtXqmX6ukh9IIxQadW3zXbJV42IEi9H
 sL5jevuMEng9x9+rgNXSNLvm64Us9dBEBUknma3ThiuMU2vLqrZF2DUeMUt+uOGrMYUch20x+EQ
 8JKVRkqHNhweCXR2mo/pH8IuWN5SHsuz+U7kWcNzbZuyee41rxnj7ZFDIq/gybrfGljkxh68wX4
 TQNkwWnKirKEQJKgYKhST5QkgPYf9XOo7isNtMRm+JgEj+DbgLy7IFksXsXBdKS4Rp28w0JIbVH
 wMH1Hn+ARIwNXsz1TlowoAgO3DuVnnMSpQ6A+QQjkp7qgxhxqC123jN6phkHDtuf4jZ1DZAIUfU
 QsTXN2PvcbKtyFAWn8VMD8mZ8hgcVG4QvGeYXi23dGuTL5zMkb0jeRQ=
X-Received: by 2002:a05:690e:418d:b0:654:1261:8b88 with SMTP id
 956f58d0204a3-6541261952dmr7879235d50.29.1776691851230; Mon, 20 Apr 2026
 06:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
 <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
 <DHUV0ZQ8Y0KC.1HCMIW6TK4K9A@ti.com>
 <CAC_iWjKtRMz1Vr7VXyw56cij=zhcSRfOdGO=XGui3uYGcp1x7Q@mail.gmail.com>
 <DHVL32OQW0ON.F5MYYVTYU1JE@ti.com>
In-Reply-To: <DHVL32OQW0ON.F5MYYVTYU1JE@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Apr 2026 16:30:15 +0300
X-Gm-Features: AQROBzBsOMP1qF6a9p5wMbxCrHIpe_AmO2HMslHAum9TXOoBb8Mcz6Q0CAQX8DA
Message-ID: <CAC_iWj+K6_MiUziEsVYQHatjMqu2Co_dxz_0J5F_Pz4_Cr9ZkQ@mail.gmail.com>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 17 Apr 2026 at 19:51, Randolph Sapp <rs@ti.com> wrote:
>
> On Fri Apr 17, 2026 at 3:17 AM CDT, Ilias Apalodimas wrote:
> > On Thu, 16 Apr 2026 at 23:26, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Thu Apr 16, 2026 at 3:55 AM CDT, Ilias Apalodimas wrote:
> >> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >> >>
> >> >> From: Randolph Sapp <rs@ti.com>
> >> >>
> >> >> Check for duplicate memory mappings before reporting any incorrect
> >> >> attributes. Could be that second allocation has the correct type while
> >> >> the first doesn't. Knowing there is a duplicate in this scenario is
> >> >> more helpful than just reporting the first mismatch.
> >> >>
> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >
> >> > [...]
> >> >
> >> >>                         }
> >> >> -                       found = true;
> >> >> -                       if (memory_type != entry->type) {
> >> >> -                               efi_st_error
> >> >> -                                       ("Wrong memory type %d, expected %d\n",
> >> >> -                                        entry->type, memory_type);
> >> >> -                               return EFI_ST_FAILURE;
> >> >> -                       }
> >> >> +                       match = entry;
> >> >>                 }
> >> >>         }
> >> >> -       if (!found) {
> >> >> +       if (!match) {
> >> >>                 efi_st_error("Missing memory map entry\n");
> >> >>                 return EFI_ST_FAILURE;
> >> >>         }
> >> >> +       if (memory_type != match->type) {
> >> >> +               efi_st_error("Wrong memory type %d, expected %d\n", match->type,
> >> >> +                            memory_type);
> >> >> +               return EFI_ST_FAILURE;
> >> >
> >> > This check is now outside the loop and only checks for the last entry.
> >> > If you wan't to split the fucntionality, don't we need a loop over all
> >> > memory areas and the type?
> >> >
> >> > Thanks
> >> > /Ilias
> >>
> >> Not necessarily. At the end of the day we can only really raise one exception
> >> anyway. I just think informing the user about a duplicate should take priority
> >> above mismatched attributes. It hints at a bigger issue.
> >
> > I dont mind about the priority. We can swap that over. But with this
> > patch we will check for less problems than we currently do.
> >
> > Thanks
> > /Ilias
>
> In what regards? We're still checking for mismatched attributes, we just check
> for duplicates first. If there's a dupe it doesn't really matter what the
> attributes are on either allocation, good or bad something horrible has
> occurred.
>
> The prior version of this would never report if there was a duplicate unless the
> first allocation it saw had the correct attributes.

Ah I misread the loop. I thought it was trying to do that for multiple
addresses, but we only have a single address in 'addr'.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> >>
> >> >> +       }
> >> >>         return EFI_ST_SUCCESS;
> >> >>  }
> >> >>
> >> >> --
> >> >> 2.53.0
> >> >>
> >>
>
