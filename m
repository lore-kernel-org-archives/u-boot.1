Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359DAC02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 14:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28AE805E7;
	Wed,  5 Feb 2025 15:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MJ6y/TBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D2F80711; Wed,  5 Feb 2025 15:51:45 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7094F80562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 15:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so1233373566b.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738767102; x=1739371902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tzp65lK+jU1IsC0plLjStypKJX8D2tufwVjRRhauDfc=;
 b=MJ6y/TBTHJ6nTDnDm1iTZsFcop1mPkN5Dsr+cnK2cSrFfFvJAtfEMqhLtsDDxfX+4p
 knwB3Rfq1gvpFeWmsp0VURADGPdEPZOGvYZY5t4KOW2Dq2fPvl7oVQf+aJNxxipwX4G1
 rKylx/hoDf+sgnm84Lkysu0MdRz0OS1vyy460=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738767102; x=1739371902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzp65lK+jU1IsC0plLjStypKJX8D2tufwVjRRhauDfc=;
 b=X0+TlLhQwKdVf5Qa6dGMwWVWiPLExc4rYBTnS9j/hgeFwwyTfKjCGysNwHTbcULxsE
 E69GUtdnARraxy+jx3iyiXZDv81ellpchHdkCrKaik+4fUklCubO3E93qvt+qkff4suW
 MSJJA0FtU2nYMH5b6GUlPgmcui4pFe/gqWBCh4TR3kN/0nKzG9ZZ6j2Lwxk0dJI/Gn+x
 rSdS2yXjyG4QPtDuPSEPIisEP+wqQSFN3Z5LzrdIYRnoiDgEe2qP3WESMd3AQhR0IMJF
 IOi1FRirmfNQU2YL3301FIMXxkrqNlE0SF4sLezihuaC6QqMUfcxTqvhKwnDk6L1nLhi
 AuFA==
X-Gm-Message-State: AOJu0YwrdNDkBQ5p1wERNnpZWXX8xa4m12kEwXHD+9P0FhnWFxpf5lw0
 C6uNJ5zkvRYVc7i+YGL7UZfwKvyiUNMhh4xSt3z9Yp57+pSvH4/FWKPvzwh8LIcHl6csYmYPrwE
 yOmcTLEgjcLcuGF0qGJOglcOLC+F877r52L71STHJrVYBqowHrJkh
X-Gm-Gg: ASbGncszfvIV9M1EeuIUk93ivC7FFYE/U2yLavqR8u1/h2oHz6Q/JQQ8FDVKdtVax40
 ZKX/iWcC4CP3ATLKVxrDsxlSkXnGMkcgVhbVaMAflUbWMRKbx4cxtF+VMo1tQAGJBv0JYVXjSwA
 ==
X-Google-Smtp-Source: AGHT+IHntWthMqjlQCHUbHClB9p4O5pneTgGHVGKdIR1/hgOyZqwnTGVigSoVDnuQdVZCqQLQYUg5Qh32sC3m/SsDjw=
X-Received: by 2002:a17:907:72c6:b0:ab6:cf9c:584a with SMTP id
 a640c23a62f3a-ab75e27e50cmr304914666b.15.1738767101722; Wed, 05 Feb 2025
 06:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20250203162608.626479-1-sjg@chromium.org>
 <20250203171356.GW1233568@bill-the-cat>
In-Reply-To: <20250203171356.GW1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Feb 2025 07:51:30 -0700
X-Gm-Features: AWEUYZlbSZi6OKgBb_tj7fo3HoB4YYbIe6lyJu-y3h_ETlnC67guRrcELFUsp_4
Message-ID: <CAFLszTi6aE+upqrmC0U370kG+o+LJcBhQDAB3kJwWfp3teakMg@mail.gmail.com>
Subject: Re: [PATCH] CI: Use different containers for concurrent runner
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 3 Feb 2025 at 10:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 09:25:54AM -0700, Simon Glass wrote:
>
> > When running multiple runners on the same machine, each should be in its
> > own container to avoid them interfering with either other.
> >
> > Add a container name for this. Ensure it is removed after use.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .gitlab-ci.yml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 1d4d3a85741..3487ad7e579 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -14,6 +14,10 @@ default:
> >  # in the u-boot tree at tools/docker/Dockerfile
> >  image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
> >
> > +services:
> > +  - name: container:${CI_JOB_ID}`
> > +    command: ["--rm"]
> > +
> >  # We run some tests in different order, to catch some failures quicker.
> >  stages:
> >    - testsuites
>
> This seems fine, but we should start by moving the image: line to be
> under the default: stanza, and then add this in default as well.

Actually it turns out that this doesn't work. See the failures at [1]

I was following the info at [2] but may need to ask on the forum. I
would expect separate filesystems for each container.

Regards,
Simon

[1] https://ci.u-boot.org/u-boot/u-boot/-/pipelines/343
[2] https://forum.gitlab.com/t/gitlab-runners-container-conflict-when-processing-more-than-1-job-at-the-same-time/86893/2
