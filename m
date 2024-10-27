Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3220D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 14:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D8D8897F;
	Sun, 27 Oct 2024 15:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHQgqOVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F4A88DCC; Sun, 27 Oct 2024 15:57:21 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFDA8857C
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 15:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a68480164so479115566b.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730041036; x=1730645836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c2vhfkR7NuVaJpqs376NMZ55ExERvkI4Ey2KGpL2ESk=;
 b=JHQgqOVKrH/9BKjT31x0rBqZ7SUnPDjxswAqD9lDwIUQSb2HeFFcHSGQhDguvnmq28
 KBPUeRiM54v+Z9c0TKpK7mqW69qPfAgR7f+5ST8I3KAgkYoD2qMjFpc9/YzFxWwrtjDG
 45OxRgsayk5yhTdOmca1F9TABCuH1R+Hl5KZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730041036; x=1730645836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2vhfkR7NuVaJpqs376NMZ55ExERvkI4Ey2KGpL2ESk=;
 b=gmcwDb4SZ9rB5AybB5CkVoD4vPKwdx8fmxQA3zLktEIlmVLl+34fVRvHD6pOFdLPz7
 vzWWrZ9bob+X16F4x24Qgc8Y3H/HUf2zVj4Hqbacic1vYVBRYPzl+e2i+oN/AX0ldcpm
 W93d2KU1/WZ85yozz0lUhvO2BTa7H2XNxm6ehd7zb4vBIV/bTLYdUKno/GqwVfYbNiqo
 ok6xaI14EIDT5TEGjw0eqf3n8wkQQwMoRcqfUbpxrHjZcr4/WcN9epIdhM+JscUpt/jh
 SQjbsopGB1tu31jOXlLZHX4c7NFo3mLVmH6lH33AqubsyOLoPf3Hc/Yao347A/gVe71M
 f7jw==
X-Gm-Message-State: AOJu0Ywwi0H/QJ8wNpX9y6fzm/XBb5d1BJip6CYWBBshlEUXzKx2UQlW
 UciADCMnhKLPN1afIlU/Oi70bLbzb0tYYN5BCHgYhN0aEbfmq/xkVuJtEqn0P3+//ar7dHwAGFz
 rq5dVoqaaxs0P2EhH/C5mC3/5nCQ9u44ZOKnR
X-Google-Smtp-Source: AGHT+IEfOmnvD0dJnhH4caWXtOlfwp+iLW1Q0hqmBRPK8xIfA9J68Si6giYtAvl+uekGvZVSe8c3Nr/KU1T48g2tx9U=
X-Received: by 2002:a17:907:7f13:b0:a99:5f2a:444d with SMTP id
 a640c23a62f3a-a9de61a0feemr457008166b.56.1730041036045; Sun, 27 Oct 2024
 07:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
 <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
 <CAFLszTjxD+DjGYUd+o3mELCctOnJZO6U6FSkSjr1su7iVTcmpg@mail.gmail.com>
 <6bdd212e-2a70-4c32-a463-c83cbf7bd0c7@siemens.com>
In-Reply-To: <6bdd212e-2a70-4c32-a463-c83cbf7bd0c7@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 15:56:26 +0100
Message-ID: <CAFLszTgDPYkoc-F2cdMHy2hKb85+zVRdACLiB67ptTUUU+gwvw@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, 
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
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

Hi Jan,

On Wed, 23 Oct 2024 at 06:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 23.10.24 05:39, Simon Glass wrote:
> > Hi Jan,
> >
> > On Tue, 22 Oct 2024 at 21:41, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 22.10.24 19:00, Simon Glass wrote:
> >>> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> >>>> be first used by the IOT2050 boards.
> >>>>
> >>>> Based on original patch by Li Hua Qian.
> >>>>
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> ---
> >>>>  include/sysinfo.h | 1 +
> >>>>  lib/smbios.c      | 4 ++++
> >>>>  2 files changed, 5 insertions(+)
> >>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>
> >>> What is this used for? Would you mind adding a comment for it? Should
> >>> mention that it is a struct uuid
> >>>
> >>
> >> What exactly is unclear here? The System UUID is a part of the SMBIOS
> >> spec that U-Boot just ignored so far.
> >
> > OK, well that just mention that, along with the data type.
> >
>
> Now that I look at your data type comment again: It's actually not ok to
> misuse sysinfo_get_str for transporting this. The UUID is not converted
> into a string by the driver, it is rather returned raw and may even
> terminate prematurely if containing some zero. We need a new
> sysinfo_get_bin or raw op.

Yes, perhaps just sysinfo_get() to read binary info?

Regards,
Simon
