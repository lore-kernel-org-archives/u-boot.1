Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D24FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9098F84514;
	Sat, 25 Apr 2026 22:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OKgZYEwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A131D8452C; Sat, 25 Apr 2026 22:47:36 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FE4844AF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38dd575bca3so87542141fa.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777150053; cv=none;
 d=google.com; s=arc-20240605;
 b=LATQijURB5/+ym4lyQlWlYQBfIQuUqlndSls5NruVQSJkph9qnVu0SpEBDL/CS/U4e
 FfGs1KL/NU9drXzgZNCT3ZR5Kr3il5I0a887xh4KZYW36+h8IQpi/oMiSlnwtqeb6OmQ
 GTAEF/2nzP4cMBh2aDN6p1y4XW3dysVzp2x3eZnYYtQclznBc8pLWSkkZZVbd0TC9cVF
 rJ5C0z4aHwFYE5KsSWhM2B8XbAZLK+gNtjKzGSnd/TGpQNgDRcKjG+olboELhWAV3k6B
 jrinsNgvsTvAxJHHlwikvUSiV5Uap3DkgUAWzd3OYDOZ7fRTCDcC8AHrQwKRvCmtv6hH
 tk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WgAu5h4xEzkrU/ZeVi9iXQ/JOHtGr8cD7A9yO0xyMuo=;
 fh=XUFRYmYGYRXaPdEVa0BorvzlEMbC6h7UrdgBnGfsHWA=;
 b=LHOr6SQRSyoQcfoob7bipgv9xSopPzdjWn1sjhQAMvxG2jFh7bwGW+z0LQPqQXcP05
 qDGsmR4tcVEBMFDAPCiIZ1VH8gM8+v1lNBp+orJT47JQNTM/X2vQFr4wrnSwRTXiCYLv
 y57DgVbAVsn+SG7432WVrw+eDr3Q7kRe7U/8FA2zKFosYeRBpgrjuV+P5/UUZsXtswhp
 AZGBhTlrPPawS/Te2E+TB6rO2Uo1056BrFuqqnMLZV2GyDgYWnVgbQLRHqB8kO4yw+l9
 GeVEMXj+HmFy0OshpEJz8aWenB2DcaEilJ4SXg4/ulb3HhmGOCLdh0nKDzWuGpUlyyF5
 LOTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777150053; x=1777754853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WgAu5h4xEzkrU/ZeVi9iXQ/JOHtGr8cD7A9yO0xyMuo=;
 b=OKgZYEwxVVyYmocOc2g1RrDK9Yo+ExFdwf1gwspHj+GUkXP1VbIQtntVg/ApbadaYJ
 giUJfIUiWc5h4SjtUZEQDylm5fszL8sfQHFEmH6x3WvQ+c482k83Bosfx2VUVnLAt/27
 lgqS5dBHRqMCVkr71O1hws8w+QAwbCzIL5hes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777150053; x=1777754853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgAu5h4xEzkrU/ZeVi9iXQ/JOHtGr8cD7A9yO0xyMuo=;
 b=Sj59wqac342Wc4ElcYTQ0dYA+DWC0daFFoMumfToYan8PEvGsJJHdwUQKQMb4i0Ekr
 hmvFhmN7kTXk/KT6jMPyJbyTLS3dPXlMvbqJ+AFtET01elm69tbkbf0qpywT4pj702IH
 zigjgL9EVEHUyOaexhNGGU8Hs1JKmFRgBfDqK++BS90LgjZulgwNxcfPtzdgxVU6X1CX
 sTfjg5HU3k+WBRYcI3hHIir/h0/VmL4mBPIsmVwF5WMviNdFJXH2Mkz4LLvua5h1OWi2
 zJJ9YDMWeh4+VTPoUtH1ub8rtZFbLwD2SsdGCc7m/pUw0fxnye+nCZksdBaShg6fkMzO
 sxxw==
X-Gm-Message-State: AOJu0YwPaOZIDx4UbZ4rbpYOieY5y3xl4vJMc0XuRnHFGhDsLIfrNvio
 VtxG2i5yMIzHlTwUGjNEod8mLVic54dkGuGgljo8BhfMJalRZftZQenFnfbbUZQn5SW8SFGD+gU
 d3E5jN5wV1+Jp5+vYgctEEkpAGrL18mYE7ATxKMOhPKRgBFbYWyxHnRhH
X-Gm-Gg: AeBDiesApTfFLt+uHOUA6IPs9sQibELakLRpTQLjgppHzwrkNDGwXQaxxPB+I2sZqJ0
 RcH618znd6lk1MrdLRITH/GuZKt5L4AkcU/n+tCMjrgpBhGm7+Q8H8UTGGomHgCCVSdfJzthlXb
 MwOxgXecU3sI2aiwucYtUB7qN0fnMo71oBRMCk5Xhkv/u1k9bUPjeCqTA067H127gM9cP95q5Y2
 TFRDXowrX5vTKldqT86sJ6A3xo240E/ZKl5TCRhIy0gBjGjo89i1XFJCrz+zFWy18XcThBgJ0eI
 TPD9oxGkbyyzz8qPtKQ+wflwBLZWuss=
X-Received: by 2002:a17:907:968f:b0:ba6:4eea:c1e1 with SMTP id
 a640c23a62f3a-ba64eeaca99mr854129066b.17.1776891277171; Wed, 22 Apr 2026
 13:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260422023131.2813748-1-sjg@chromium.org>
 <9a9194d8-65ee-4c84-a760-2a73378a7170@mailbox.org>
In-Reply-To: <9a9194d8-65ee-4c84-a760-2a73378a7170@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Apr 2026 08:54:23 +1200
X-Gm-Features: AQROBzCB-AAl4vmuQX-HxzwvWdG8KHqNxrWqkkVoDlE8pCgTgW_kJvwgJcnj9Z4
Message-ID: <CAFLszTi+_1KBMWJ2rRF0B+4KJTfewrGicdrWJeybs-EJ7_HJRg@mail.gmail.com>
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, 23 Apr 2026 at 07:08, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/22/26 4:31 AM, Simon Glass wrote:
> > When producing a DTB from fdtgrep, there is no way to reserve extra
> > space so that more nodes/properties can be added at runtime without
> > growing totalsize first.
> >
> > Add a -B/--pad option that appends a caller-specified number of free
> > bytes after the strings section and grows totalsize accordingly. The
> > padding is applied after fdt_pack(), so it is not reclaimed when -r is
> > used.
> >
> > Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   tools/binman/btool/fdtgrep.py |  3 ++-
> >   tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
> >   2 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> > index 446b2f4144b..7b393241878 100644
> > --- a/tools/binman/btool/fdtgrep.py
> > +++ b/tools/binman/btool/fdtgrep.py
> > @@ -16,9 +16,10 @@ Output formats are:
> >       dtb - device tree blob (sets -Hmt automatically)
> >       bin - device tree fragment (may not be a valid .dtb)
> >
> > -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> > +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >     -a, --show-address                 Display address
> >     -A, --colour                       Show all nodes/tags, colour those that match
> > +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
> Shouldn't the parameter at least match the dtc -p parameter ? -p is not
> taken yet.

We have:

  -p, --include-prop <arg>           Property to include in grep

Regards,
Simon
