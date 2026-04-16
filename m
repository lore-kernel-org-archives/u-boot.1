Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D394F8DFCB
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA988841F2;
	Thu, 16 Apr 2026 23:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KrGVKkhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051188420C; Thu, 16 Apr 2026 23:35:30 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B5083EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso11316866b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776375327; cv=none;
 d=google.com; s=arc-20240605;
 b=bjRsa2HxaGCK/f8W+8fmIeoJwEuxXnAGb986TBIljhbCXKGEQk1Fyb5FmfJ/fO6orV
 vxRRBii2nVUijvK+TGO9MgBHK5V3sdnJGndS8Gn8tDVDps2RFWk8gIbgUAeGkFKi2Z9g
 YD5n+SqyhH5SuHcymPWq2OYviypX3LJWps5exyNrK0hI3s8nUBFmhdeIACLacJa/ZVHl
 uU9YWxai9YOczMEIJE4IWo7cdTJJRF1pY5Xb+7KH9hT8SOYtyh5aDo3hU5jPU6yn3Trz
 efRL1Y3rknUO8D/My1qrQ3upw7wFJDbPEyUZUIrCkRblZyDZYeULwNyw/llptv4y/ksa
 Dv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0OVDIDq6p9ZtryXw3LDjkFbthvN7Q8DYN2q3t8qAznE=;
 fh=g/Gn5oxOtNoTfR9YZiGiuldCUcaTUEbyLdcgcFGi3bA=;
 b=Pxu9ceskr6+z6j92lvdaScfnt+gRbADfV9R4hLOBdb46dF9qansDwaWOF0C6B9cchv
 3rExHIt5P4ZP79sjB+glkeLHsiB2x5KjSdmA6V6eQh4sRTAecKNe6lOIu0IIDYQdAEe7
 VnFPNd9t/FrUgxOTX5+JoMCqpg+moI3y3nd6tlk0kRfXPzkDg5NLaKkEkTRPx0F0qotf
 sjvXBvwL1++70QmyPpntgiLMRTeLJspQJ5e3Aw2BFlqLnCsTGXU+BQx032j1nZ31abK2
 TXeUKS3mMQGZNOpWPB4nz6x2HOdgtnOZNGIGkAgc5vdTmBSHBGC8y2vpcXDE1oGzAYRn
 OLSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776375327; x=1776980127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OVDIDq6p9ZtryXw3LDjkFbthvN7Q8DYN2q3t8qAznE=;
 b=KrGVKkhLASXm99sAQCYdzspxH006RFn2qX8fZ+XlwiB7sHvR/YYQJ8sb8WW6Dt5H4E
 PvRa1DZ2g1ApbSQQwaEjfKsYVTsRWpAY9XFno+BHWhZ8oIvo6eG4uEuH90M/poUJuwP6
 zeKf8f+GDcfCWfd6a0+PNgQQZcfzfknciT8BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375327; x=1776980127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OVDIDq6p9ZtryXw3LDjkFbthvN7Q8DYN2q3t8qAznE=;
 b=jVXGqzyGbr4D937cw+GlmSW3mZ79Uca8LiPLZaSBG/7pP+yCpeYfsUly43cajk3h9l
 mf69JwvPJ3tFWiNysI6sRHzHGtNhLcOmaEWn2a9uRXlM2OQBGlCxJo23DgKn03Qt3+/z
 j+Hm1Q3m47keADuLZ3HHuIXYkyb6+iXv+bGI325z807bjUqolZtkqFUSpGCXOYXGIAGx
 YqMdKwNGUvq2uFOeG5OKuW4QWmTYBrW037h9jDIZRGM3Tw3z/tViYPH/omWR8HM60brK
 2GH+gYoXyLzmEz1SqIo1x44JExTyVWaL3W2ixpzKk0rwfiD6FIjNrLNlIaDjm+MtXt+z
 9mzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86eN9X8aBN126geRTmYiaRZEwVJV76IBfwgxvuuMfPW6+wiUo7HzWBsWu7wvHCBroUswGQ9wY=@lists.denx.de
X-Gm-Message-State: AOJu0YwdyEKb9H7ryZJRauYYnXLwVU7hEgTimY92EtQqz4HJ1Tp7dgJF
 D3U8UBRGCAx5ABl5GM0PP2lgfyC4+gVmtp+wDQRnVVkt5qitSDcO5R4VOv3rkBm4GRVji/CxUjC
 TC3tIxempIQBuNHjt0ReiDjPajPeDXbphLeL8woQv
X-Gm-Gg: AeBDiet1+bMpo7W2/B1/cHUVYZkawA9mL1k8ivnLR4gz4mLFPrAk8xVfsmDG1vNF15w
 8ci4rRCwpj8prwW7kwxrbEP6qnQIbfg7GWulzi97YWe4Sca0tdqDdFMEWULNs5UBd61s5rz8Yuz
 kFx46H8pfxQDqJDNxJxjVffcqvs0ArMhT1THM/WB6tVL2+LW7gQezPv3qyEB9vvpFp2YDnvimAq
 T++85KXCJzVYG7YXq5DiBYABWbbQCBr+WyCHVng6J8a53OTbDp37Fr53qgYVq0I6w2mvc2CZhr7
 LxW6my2em3obkaYuek9B
X-Received: by 2002:a17:907:6088:b0:b9f:1754:8e0 with SMTP id
 a640c23a62f3a-ba4235bb10cmr4887066b.23.1776375327230; Thu, 16 Apr 2026
 14:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
 <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
 <DHUW0ASRTCZR.8TB6FRJ580PY@ti.com>
 <CAFLszTjXh+uEEMFQYOAS7sApqYBkfb3VhgiRrTDmzEzj9P+M5w@mail.gmail.com>
 <DHUWE3NAISJ7.CID3Q8TRSIGX@ti.com>
In-Reply-To: <DHUWE3NAISJ7.CID3Q8TRSIGX@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:35:15 +1200
X-Gm-Features: AQROBzCjXZs81V7sj4KHPjEH3Ke8EVOFe_mBED0z8KUUs0Tc9gecbpN4xGTUQ50
Message-ID: <CAFLszTj3BfevPcMwaushmLDjnES40cRxLLjUbb+SC+rbXEuGtg@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Fri, 17 Apr 2026 at 09:30, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 16, 2026 at 4:20 PM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On Fri, 17 Apr 2026 at 09:12, Randolph Sapp <rs@ti.com> wrote:
> >>
> >> On Thu Apr 16, 2026 at 4:02 PM CDT, Simon Glass wrote:
> >> > Hi Randolph,
> >> >
> >> > On Tue, 14 Apr 2026 at 08:36, <rs@ti.com> wrote:
> >> >>
> >> >> From: Randolph Sapp <rs@ti.com>
> >> >>
> >> >> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> >> >> parsing a new device tree and properly warn people when a reservation
> >> >> overlaps with an existing allocation.
> >> >>
> >> >> If we don't at least warn the user of these reservation failures,
> >> >> there's a chance that this region could be freed and reallocated for
> >> >> something important later.
> >> >>
> >> >> This useful warning mechanism was broken in:
> >> >> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
> >> >>
> >> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> >> ---
> >> >>  boot/image-fdt.c |  5 ++++-
> >> >>  include/lmb.h    | 14 ++++++++++++++
> >> >>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
> >> >>  3 files changed, 47 insertions(+), 5 deletions(-)
> >> >>
> >> >
> >> > With bootstd we maintain a list of images attached to each bootflow,
> >> > including the address when loaded. Could that provide a solution here?
> >> >
> >> > Regards,
> >> > Simon
> >>
> >> Hey Simon, you may have to elaborate on that a little more. Are you suggesting
> >> we treat FDT reserved regions as dummy bootstd binary entries? That might work
> >> if it counts as an LMB reservation and we can dynamically update it if the FDT
> >> is reloaded/changed. I haven't looked into that too much yet.
> >
> > Not so much dummies, I mean real bootflows. I am not sure if you are
> > using bootstd, though?
> >
> > Basically, once you have a bootflow there is a list of images attached
> > - see struct bootflow_img
> >
> > Each image has a type so you can see if it is an FDT.
> >
> > This is just an idea though...I'm not sure if you are even using bootstd.
> >
> > Regards,
> > Simon
>
> Oh, the issue isn't in the region reserved to load the FDT itself, it's the
> regions the FDT reserves for other components. Specifically the
> "reserved-memory" nodes and other things like that.

OK, got it.

Regards,
Simon
