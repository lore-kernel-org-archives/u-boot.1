Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C9AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4507C40A3E;
	Tue, 28 Jul 2026 11:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqhRUUPgOo3h; Tue, 28 Jul 2026 11:38:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61463409F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238701;
	bh=KiBfyraTQ8tv3wb7vxHRAe7kunVKU3calh3NPqRRgb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wzv8UlOBhf8am2auv5slBnP1SjJ73F6msV9rGYw7cQKmMnz2+k8Fv4MGc8E7eQpku
	 jIIEmF6UZX+MtPxjA5eHqKoN4tl0ahJP/u2Sw3qEIVIo/1FJKq9CNrtLKLvdJvdhGb
	 qaFSjBaA/rTESVMMgY61rQYblXjecCpAR+IYGQahOZbr/NS2YV33thOWZssUb06PMk
	 vhtX+mtVobEbb/uczE2KLn/P2Se0oWpJoqWcyXt0FF/DGT+9O73/pn669RIV6KI3PV
	 cb/Ag8gGBetbYuEAIPo8wJJ6Qmt71ZPUi6lT3N4X8mH4cLiY9NUsHXyDUbvwKnmCJ5
	 XfZspyeAXhWIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61463409F0;
	Tue, 28 Jul 2026 11:38:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B993A47
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D9C5400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zMi7mXfvS8Hy for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:38:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 180AF402D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 180AF402D8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 180AF402D8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EC28494B; Tue, 28 Jul 2026 13:38:16 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F57482991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:38:14 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso6548435a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238694; cv=none;
 d=google.com; s=arc-20260327;
 b=N3JJ2bsVfqGzgQyrxRZnFggONvB51HvHiz8XMZsGgT61ia8vJF/+YJXE/anTHnT2cg
 659g7o1ph+qagw/dDRwV4t5lM9wW8e6CMCXFppwDEnOR8rKNVgO87MBSrkMPB6Xeo1hk
 oY9dxNc4fv+qNlEfT8TSsrsv+gjGpoasvURMzxyGxXKi1f34X1vqAmAlFnmfR8q9S16S
 rPWEfqw6o9MRLmPlkOhuzBxBFPXEFr+W0yALcvCu4Aa+oya73K3Ly3VaNrg/wEiXs4hY
 CAXwfdj1Fk/vVDnpOEOqvTeoaA0DZWFI5/yzh52XBExbNvQj1e6/qGzXBjKL0bSCglRB
 JZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KiBfyraTQ8tv3wb7vxHRAe7kunVKU3calh3NPqRRgb0=;
 fh=0NJJus3dM5bujpCCWJppnqqVjl2nHAh6kfQzDqp1Auw=;
 b=h+SYJnRCJgEKDqePTtE2++Ww8jTIX/MftJSV3ekM1svSWirHVRYx6TEVbLKXR3rcLg
 dq7NA8j6m0iYlUA6z69DdLVY8QBlCiYcycdtF47Dln/qzzUGkFm1YBFyZD20aI6ank0t
 onPIysHC388rIEM+9PAzb41kOB+3r57kFPTc4Pp231svzTelE8SBrcfOYUtsQvACCjcA
 lxPNUTsWmXftx0xwMV3pP3AhIzhJ8Ae5zCTIQWrv4LuO4Z5OLd4BM3KEZkPQw8a8h4tD
 lJc5wYWuYF5zJpdM/eMSA7chCx+sI05drZNBXFFV8Gq28KvY3vEwkmL/tNBzGyUt2pf/
 1QHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238694; x=1785843494;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KiBfyraTQ8tv3wb7vxHRAe7kunVKU3calh3NPqRRgb0=;
 b=dWoWCwaK4UsZGRk6heof1dpwsm0JDcLF5m2mZh0nE4qxJUAVhi2aAstgZuFJ3LW2ji
 AAx+CMIAb4nGlxQVWwEONTbuRV2vPfkfqHH/ZK7KYq1dmIOZeUUaL78OS+V0MpiF/e3u
 NRFM3TdVEGEFNAmoHoECK7A4Hz3KSJaXUdbHiiewo3l0rLXM3o99NVTLaGxOUAqcmm8F
 JDnhv06grWZtjKRoGUnzTVV+fAkq3m2J5rgR1A2N+WKIx0csHWSuiy/utK34Vz/Y53oI
 Z1mt0j9bwhRZI6aUs1yv+nOenE4OwIfGxEODhRAUsks4vfWF5OUVtr+xudU4Lx/6T9Ld
 H8Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe45sQDhAwIHqnSQ2QmWBZl8FuR2I4pzSxCzmYOwbCQeO6XPgddgmy0mTeS559zdQZfBgkXTU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy500jdS8VRpMoJqnHjBZpnXyXb3Qv2uWvHMxMaloaF/8SvtAv7
 uhhuY3drdaqtR7DN6wNcZQdKhfnSjnLLEnBseoVBLfgag9sZwn73qev4z8Mxmh1Aa+UgJED67Ib
 lzTTdQWGrtbVixsyA2q8r7/pLU8byjWbXQ9a2PMfv
X-Gm-Gg: AR+sD12M0zM9QdrpmKjPqKsfDmCJ0fjQr5wGKRGy6ZKn9EeK8Gtz75g9qq/+2zsqpQd
 TA3emzpLV2omjAK85DHy2G2qPnTKcy3ms8dzRqWFkmT4iXJMEZnDlMBVDUR5awtBbWDDAVyg+Ln
 R1it5Hj7FJCvgju+ZT7TtVzRKigdxrP3+BK4puc+WWtHRM7iSEKesk6chWB/ApNQu3rtOZZYSEd
 VUk1B8spUEBpNNFbG7EekKbLhv414pdHhdPcPTXPkhdOBceA3nJ3xr6+2Zh
X-Received: by 2002:a05:6402:2696:b0:69f:b52e:7484 with SMTP id
 4fb4d7f45d1cf-6a034a87fb5mr1114181a12.19.1785238693784; Tue, 28 Jul 2026
 04:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
 <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
 <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
 <90e62165-aee3-4e36-bd1e-3d5cbb991f11@cherry.de>
In-Reply-To: <90e62165-aee3-4e36-bd1e-3d5cbb991f11@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:38:00 -0600
X-Gm-Features: AUfX_mzidVck182ovFh1DDJG-yunsf-DCeDC9PYmaY61eDhLVtPwgd_Acw4LK0k
Message-ID: <CAFLszThwRges8dceWdr71KioTR8nZ_mbC0me20EKNsBtuYuvrA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238694; x=1785843494; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KiBfyraTQ8tv3wb7vxHRAe7kunVKU3calh3NPqRRgb0=;
 b=WxNkolPrFBOvG9wS61gzxADEL6a/LQq/T1QeozJzQHnCD8TBWui92qKLVbKIEdZAfg
 K8rtrHn0E2jT3zGtJP7J6hWql0es+RJXDO9CnjNMMRicoeX8Wg0FQltu6IGt3As+675S
 XAEhYebwj5koIKwZ4tw3FUD7a0oW3tpVJUwa4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WxNkolPr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="WxNkolPr";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Thu, 23 Jul 2026 at 10:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 6/27/26 10:30 AM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Fri, 26 Jun 2026 at 16:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Denis,
> >>
> >> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> >>> Add a diagnostic console trace indicating the reset type.
> >>>
> >>> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >>> ---
> >>> Changes since v3:
> >>> - moved get_reset_type_str() next to do_reset()
> >>> ---
> >>>    drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
> >>>    1 file changed, 17 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> >>> index 1ba698b37285..2b7717857ce6 100644
> >>> --- a/drivers/sysreset/sysreset-uclass.c
> >>> +++ b/drivers/sysreset/sysreset-uclass.c
> >>> @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
> >>>        return SYSRESET_COLD;
> >>>    }
> >>>
> >>> +static const char *get_reset_type_str(enum sysreset_t reset_type)
> >>> +{
> >>> +     switch (reset_type) {
> >>> +     case SYSRESET_WARM:
> >>> +             return "warm";
> >>> +     case SYSRESET_COLD:
> >>> +             return "cold";
> >>> +     case SYSRESET_POWER:
> >>> +             return "power";
> >>> +     case SYSRESET_POWER_OFF:
> >>> +             return "power off";
> >>> +     default:
> >>> +             return "unknown";
> >>> +     }
> >>> +}
> >>> +
> >>>    int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>>    {
> >>>        enum sysreset_t reset_type = sysreset_get_default_type();
> >>> @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>>                }
> >>>        }
> >>>
> >>> -     printf("resetting ...\n");
> >>> +     printf("resetting (%s)...\n", get_reset_type_str(reset_type));
> >>
> >> NACK, this is potentially misleading as sysreset drivers can end up
> >> performing something different (see sysreset_walk_arg() just below).
> >
> > That's always been the case, but it was silent - do you suggest that
>
> We only said we are resetting, not which kind.
>
> > it prints a new reset message for each type? Bear in mind that when
> > one succeeds it is unlikely that the serial console will be updated
> > before the reset happens. In the majority of cases the requested reset
> > succeeds.
> >
>
> Indeed.
>
> > I quite like showing which reset is being attempted.
>
> I don't think it's worth the potential confusion. After all, we may very
> well NOT do the requested kind of reset. Wording will be important if we
> really want to do this. We need to be clear something else may be done
> in the end.
>
> We could print before attempting each sysreset type which kind we're
> trying... I think it's actually a good idea, because it isn't
> necessarily clear that even if you request a warm reset, you may still
> get a cold reset (or even a power-off) if no driver supports doing a
> warm reset. At the same time, we don't have a delay between printing and
> attempting a reset, so indeed like you said it may never get printed.
>
> So, first line in the while-loop in sysreset_walk would say "attempting
> sysreset <type>" and after the for-loop we check on ret != -EINPROGRESS
> and then print "no driver could do sysreset <type>, trying more
> aggressive reset" or something like that. Before return, we check on
> -EINPROGRESS and tell the user we failed to do any kind of reset. We
> probably should have some of those messages rather debug messages
> though, I fear it may be a bit verbose.

The odd thing is that the last thing you would likely see (with this
approach) is the reset type before the one that actually succeeded. It
could be a bit confusing. But I suppose that would be OK, since we are
resetting and people should be aware that this can result in lost
serial output.

Another approach (perhaps a follow-up to this series) could be to have
the driver indicate (e.g. with plat data) which reset types it
supports, so we don't bother trying unsupported ones.

Regards,
Simon
