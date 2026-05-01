Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB90CCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 22:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3A383693;
	Sat,  2 May 2026 00:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTNQmt5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39DE83E36; Sat,  2 May 2026 00:51:34 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86FA80F0E
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 00:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-56d8d479149so853862e0c.2
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 15:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777675890; cv=none;
 d=google.com; s=arc-20240605;
 b=L47dDfOHAd7pJalNuoLuaVNiIOzvsEBACiEHVB64o/eTpcKO7EVwap///RO8N1ylQy
 KFm9rkP23AHXGtSF6wP+36uRMAignYvIAy59p5eOxaXy2DhPzVNVZ9lRCqfBqKLVLf+p
 ETulJG9T8NDk1/hcCE4EgmeScRQRc0E3M17hP4nCjGncWDFLdZV0q8/E4Egy8qCqFj+M
 N63fz2O6DnFHDiCypSuwySPLROOc481McgX7MNQ3lwozlA75l64WajF4S3ZYMjKuIByz
 Ac6BO19zV4VKJnSq+5LzRgy1GOspVy6H+dFtiGzOV3Cf33WqYbIKJg+IaoQanw+B2Jq2
 kGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RYqXkIxbrIJNTw3mN/msctz7wj+X3BOWSrVccUsBbrg=;
 fh=AAfzKCDxc1e/dJvGwugRKl9x1DS6TyFb222UJuOjQmQ=;
 b=UU2803DZIwMme7y5ItnIdL2Pq2e35F1aO7qceULo2Qp6eJhzSbWpxkr3BH2Ri/fKuE
 HzyIVNmb2aoWFAQ+UB6F3K0hA2BspuBTojOhwX/KEVhWOW+UqeXyNEBoaZvAa/XwEuQC
 nX7ofNAoYJW29dA8d5xl++xI5oQKCX1feLeA/DV2+HI09WeVFhGKn1TI/GOKIz6giL/9
 2ny1HQwudT00LjgMr+fbyop10NJt4i7gvLlvZeDbL8r/2t7krY84g20L2QwMxNzQ/AMw
 naC+th0EDcB+MtIORpACNlymPua6sT+FZILOkLQD80a60ZnP6nolRn7ejVmohcpZAIko
 Rqtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777675890; x=1778280690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYqXkIxbrIJNTw3mN/msctz7wj+X3BOWSrVccUsBbrg=;
 b=fTNQmt5ghYLPPTd3wizBFCJitrugZSwykKzahRqyNfeyePRfbOM39IVpzoqwFfBCP8
 T1waQkWT03xet0pJt4iMMQV2tF8wjB+xOirkY3R4M4QK2zYTMEMNjZqjdIZeMEy/wq7e
 TbkuafWXsvdSfyyRxS45/J1cfMiw+gcEwKL5lCS7ABNoz32J5n5IWMv0uoeLaaujij/u
 QB0wG5CKspa4zyGlzbwYXgp07VHO3OTyx6r4W73fe5VXry2Lq+9l2MbZjIFaBpIyqVok
 oJUJ9Id8z4A4jMrL4AZmQTaJLFDjfkslRD2Kd45yzcIhsPPGHph/Owf0UbtmgJNWo1g3
 poEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777675890; x=1778280690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYqXkIxbrIJNTw3mN/msctz7wj+X3BOWSrVccUsBbrg=;
 b=jCS8STy0H3teub9ZrfVwjjItxrJQOGDZ6YuMaLwGHyLHYB2+aMOKPKfhdJhzz0KI0Y
 dWzXVWSDgX7tQj2uB1fCn2buY0fMEWRvTd1oXRzd+UAQlM0iPh5dnRclrr6hXKrYT9i/
 xdoryKQeAsEghqFtnBXh8CNJuihczG6IT59UT5eIkvgYzS7qATO/xPISFCOl9STimEvw
 5hb2OGYVNejdlgLaAf6Fsj2W1eM+m1KesOsOrxnTL/aLiGTPztrj1UIBpDVy8Q2ccrZz
 zHtz+OtnHbrbWE/zhXYKZ/aBiPwN7G5Ngjb74bQTGVVJJlHhzbvMObxIhWxWVdUVs+CH
 5NGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8t+qwtc3GIfXvjGE9JGp0NUc8MVzQ7UE0shhR68FIm0j1VksEDIb4ioEQ7VfKOKdMMsKRiJt0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1YYxkl8j/cDpaXeZAS3MRrMGIUemO+yHv1gN/O2PabA88SBYM
 vHOsbbMLJPdgIERQhC3blvWQe47YaFvf3iD+mh28f6jRuwW6vXH8IWv/tGllHdhvK8yhsmU6c6o
 B+nB8SEk58ct1T84jGRVn/BC4WXIERG0=
X-Gm-Gg: AeBDietG6KQ2qtsll4/urL5AKG8x9v1Rv+krqw575E8BvyaOKGF6vDGHLbmKfBHwCLe
 PtxeV4+K0JA8erhjXzC6P+n2vPzFMhNL7ahNYo70cjRvelcD/3hg5tw3fA6nRlPjU4QSRxrVM68
 9VUSgOb0ag7KjyZaMiAmj6yIKFJQ3AAoU/SsGfTjHFkFkmR7Fl3UWBALgIqayc982s1aERMvYAY
 E6c1taZNzKIQ9blDUqRS8vfzDnPUm33XFq5wkfgg3Yk2JYsG+vtgkYd0rj1QodHHvlruGIFixnI
 JkirJo0QhBTjRaqI4R0=
X-Received: by 2002:a05:6102:5123:b0:607:798d:8083 with SMTP id
 ada2fe7eead31-62d86b18ee3mr653237137.15.1777675890547; Fri, 01 May 2026
 15:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260428140433.GQ41863@bill-the-cat>
 <92fd2c06-8b50-487b-8f42-2e620dd607ed@amd.com>
In-Reply-To: <92fd2c06-8b50-487b-8f42-2e620dd607ed@amd.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 1 May 2026 18:51:19 -0400
X-Gm-Features: AVHnY4KQTWarlxvTHNZb-Sy24jrUTW93UIliXkwKZdXlaM10SZMy6YNy9RQ1GXg
Message-ID: <CAMDkj5xDBUxrSqHCs8e+JHFDmG8=ndkwP=GHzWF=XFjSp1vSzg@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Michal,

On Wed, Apr 29, 2026 at 2:31=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 4/28/26 16:04, Tom Rini wrote:
> > Here's the latest report.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Apr 27, 2026, 5:41=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >     - *New Defects Found:* 9
> >     - 77 defect(s), reported by Coverity Scan earlier, were marked fixe=
d in
> >     the recent build analyzed by Coverity Scan.
> >     - *Defects Shown:* Showing 9 of 9 defect(s)
> >
> > Defect Details
> >
> >
> > ** CID 645841:       Incorrect expression  (BAD_COMPARE)
> > /common/bloblist.c: 303           in bloblist_apply_blobs()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 645841:         Incorrect expression  (BAD_COMPARE)
> > /common/bloblist.c: 303             in bloblist_apply_blobs()
> > 297                                   log_err("Failed to apply blob wit=
h tag %d\n",
> > 298                                           tag);
> > 299                                   return ret;
> > 300                           }
> > 301
> > 302                           rec =3D rec_from_blob(blob - dat_off);
> >>>>      CID 645841:         Incorrect expression  (BAD_COMPARE)
> >>>>      Comparing pointer "rec" against "NULL" using anything besides "=
=3D=3D" or "!=3D" is likely to be incorrect.
> > 303                           if (rec <=3D 0) {
> > 304                                   log_err("Blob corrupted\n");
> > 305                                   return -ENOENT;
> > 306                           }
> > 307
> > 308                           /* Mark applied blob record as void */
> >
>
> I sent a patch for this one.
>
>
> > ** CID 645839:       Error handling issues  (CHECKED_RETURN)
> > /lib/fdtdec.c: 1785           in fdtdec_apply_bloblist_dtos()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 645839:         Error handling issues  (CHECKED_RETURN)
> > /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> > 1779
> > 1780          ret =3D bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> > fdtdec_apply_dto_blob);
> > 1781          if (ret)
> > 1782                  return ret;
> > 1783
> > 1784          /* Shink the blob to the actual FDT size */
> >>>>      CID 645839:         Error handling issues  (CHECKED_RETURN)
> >>>>      Calling "fdt_pack" without checking return value (as is done el=
sewhere 5 out of 6 times).
> > 1785          fdt_pack(live_fdt);
> > 1786          return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> > fdt_totalsize(live_fdt));
> > 1787     }
> > 1788
> > 1789     int fdtdec_setup(void)
> > 1790     {
> >
>
> And this one.
>

Thanks for solving these two.

Raymond

> M
