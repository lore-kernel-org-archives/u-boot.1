Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED50C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4E62409AA;
	Tue, 28 Jul 2026 11:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llLSDql7tG_D; Tue, 28 Jul 2026 11:50:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12239409E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239410;
	bh=gKcPM/kprDdoa6d8qUSnXpf20b6Kp3LNSilZhIpGVaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQx4ObtgZ83dMGNd1vjQNR28rcCGxibg6uOjef6T+jvrxldCE/QklzrvRk1ZCjCfq
	 sELMT+9MqB+LhQSVetoLHlEpLddxAIVfB+xAQybEzzzCW3tNFcij9+V5EjrruKygUR
	 qG8jsWViP4Nv65yzb1usw86MLwzq8XdB4+SH6Fmv8SBmnn40KuCCCTyJp35M5DRH+M
	 CuiPELNFn8MlxkxSTtoSOQLHqbb23fIZ+dw2jpHYGSh6Yh+z4chorPFWCT7va9vVSW
	 ucPFZaJqlg4VqOBgoXFpiE63UUv9dgIEiofoBjsCgvsJ3fNEXIVHxlHBvcs+UfVzni
	 wIFNcb3VxrUiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12239409E3;
	Tue, 28 Jul 2026 11:50:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 74901788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A1E0812E4
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bJItprZigfc for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:50:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 24496812C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24496812C9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24496812C9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FA98494B; Tue, 28 Jul 2026 13:50:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAED482991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:49:59 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so5773476a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239399; cv=none;
 d=google.com; s=arc-20260327;
 b=ZiWVo6bfzHc83RIuOHfCzcu9kVLB6C/Wpui/KkQ+ukzGPP4T2ykR1sEDj9OTV4ZNTq
 Ezy/6pI7umwG6eNtguluvV5oAkKDSlzP0lSx96r75SkB4rbW/gJ6blTvaqXxFqNDxnZZ
 Cc0Z/B0E4+iSJ36ZRU3QIIybgDUuCrhYU+bk+VZ4rE4aWzyTesq+e57h6kzzOd7SwtO/
 eqLGueZa9ODMXokFYdG/8EPc4g3pz4kp//t833Yx+u1sq2PJkzjPlfbeIcecsq/3e30i
 O5FgkjPOAn6ZkvdP3vZ0O5xXHl3PPkL72bAR/XCVlARAT8Cc21jDbCSSJtKz0hzQjVYu
 /QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gKcPM/kprDdoa6d8qUSnXpf20b6Kp3LNSilZhIpGVaU=;
 fh=KgRgszSybv2CkDAefRlisrvM6JndpsxewHFGFqtqSm0=;
 b=NudVXr0tY1/QEXsUVxZS3wgMUpw/Pxfgendpk2awcicbFtBxIoZ5f3a9UlA7CfMtHQ
 LFMUjjt72IfVMQai2bsf2ovU0c06DIu6OgdiVO+GJ3fjp+Lz/G9XTl/RPl7EgMusaiZK
 Zo8JsC3/DsZifU5pjlTxr3fQNnoTNJIskfnPzNqUCJKpTEhwDUqKSOAZKElvjzRgP89O
 V0anlwv37/C6yiClEntqynMvSMj1sE8y0bVWJ0sRp3ht6F1fwRRtlQCcqw5Hm/TE8nYi
 i3/pUh+7KmL8IkPPZSbDtY1yxvCcyqkXI8gzgcf7ADVNEO5tiHcL/x7bEIJE2C1OL5yw
 i6WA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239399; x=1785844199;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gKcPM/kprDdoa6d8qUSnXpf20b6Kp3LNSilZhIpGVaU=;
 b=VJv5aypI27eLvKAkRGcXiO2NnqEys5xhMV18n3eUoq7J3FaS5zsci5wF7/UGs1LXpa
 Qj3mKuwLR+lBUQyrZMv0p9Ar9xtKTKU2Bu8I38HhSMCk2G53tFjYzgFTO7yCK0jdZGVf
 BPHL5Xkvg/c/wa0Pt1wPSXD253gZDlHdHfynGb3Pyt50P+XIExiw2wNSiEzPfMPVNvg9
 IT3C9ccGUuMO6f95+bJB6ockyKsa2wbaCfAVApY97MviuS3ytdd/c7bNdk9uIdfpZhky
 aalzjdni1Gmv/BO8uT7LtTNEScA+DU7TcjfM5CS444xcJohOoUM9c1NfHdm12YQqqntO
 r2pQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEKPbQ5mJSHTnZ/mfT/TbNifMi87Xc/Q1urLR4oXHeTnYXbMQydSCZNuh/GJHli6fnJwpna1s=@lists.denx.de
X-Gm-Message-State: AOJu0YxKQGSthw1NBYCp83avVMU5j8NJJCw4OD9bLXwqttWfAjWCh1xZ
 l1rZC04sdJ+blQhhaz7/8fhGoNe+cLBTuVmUTIruIkAhTG6D/lGqhot9tALUnF+IAtEHz433Kh+
 ZtFcqicmm9bZufUt+7VSTWyPRt69gnD3BG+t+VR17
X-Gm-Gg: AR+sD11TyvZUJQwKoED7UHpdtRpVNjfKFB1DnUbfwJB+PAbNsGg2RHgJN85/NiXxeG+
 OGglwLSaDg0BJ6LuwyUt4S5Citw/sUJ8kHKvQMKfIAUaRasC/u73KxUtyyBZ4MkNV8yuYq3jzWP
 N7UvvKxOI2ltply7+SpB70u2H9ahLYcKbSlyyjj7MK7zgzJA88oytPmY6EZLvz3gyFDoZGqbXkv
 Qto/HwlSTD6HtKSh/Ko03h7pgXCls9wH78x6caRldPI2tEAAyq3rbUE6lTy8AUgb1gYbOw=
X-Received: by 2002:a05:6402:40c5:b0:69f:c7ff:a755 with SMTP id
 4fb4d7f45d1cf-6a034a8ae9dmr1081755a12.31.1785239398985; Tue, 28 Jul 2026
 04:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
 <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
 <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
 <90e62165-aee3-4e36-bd1e-3d5cbb991f11@cherry.de>
 <CAFLszThwRges8dceWdr71KioTR8nZ_mbC0me20EKNsBtuYuvrA@mail.gmail.com>
 <5ca38884-d8f1-4fca-b087-7980c2ea96ed@cherry.de>
In-Reply-To: <5ca38884-d8f1-4fca-b087-7980c2ea96ed@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:49:47 -0600
X-Gm-Features: AUfX_mwv5Zy9tghAkgHVtSaVr2HIygu8Dd0Cv7kPHRh1WZlyEwX9sNA_CfP2GH4
Message-ID: <CAFLszTi7uVFoLdFcG=HrQCaoi_BGu-fQwE5qsfHP+UUwv+zGvQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239399; x=1785844199; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gKcPM/kprDdoa6d8qUSnXpf20b6Kp3LNSilZhIpGVaU=;
 b=Am5Rlsh1DyqQ6mDU1ZwAxUM6o/WNTUFUXc2q1APuUboiddbAZZNooACCgcukmophpr
 alQVYdnZ+Yg7zC0uwv/0xiy1g5jd1WZCGLEORq0rzllwBUAAHpidb29Igz9VqE0pjsL0
 e9buCM9ZPgWQUbZlReVQytgJmlt5M6hWTu8Yk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Am5Rlsh1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Am5Rlsh1";
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

On Tue, 28 Jul 2026 at 05:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
>
>
> On 7/28/26 1:38 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Thu, 23 Jul 2026 at 10:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 6/27/26 10:30 AM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Fri, 26 Jun 2026 at 16:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Denis,
> >>>>
> >>>> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> >>>>> Add a diagnostic console trace indicating the reset type.
> >>>>>
> >>>>> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >>>>> ---
> >>>>> Changes since v3:
> >>>>> - moved get_reset_type_str() next to do_reset()
> >>>>> ---
> >>>>>     drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
> >>>>>     1 file changed, 17 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> >>>>> index 1ba698b37285..2b7717857ce6 100644
> >>>>> --- a/drivers/sysreset/sysreset-uclass.c
> >>>>> +++ b/drivers/sysreset/sysreset-uclass.c
> >>>>> @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
> >>>>>         return SYSRESET_COLD;
> >>>>>     }
> >>>>>
> >>>>> +static const char *get_reset_type_str(enum sysreset_t reset_type)
> >>>>> +{
> >>>>> +     switch (reset_type) {
> >>>>> +     case SYSRESET_WARM:
> >>>>> +             return "warm";
> >>>>> +     case SYSRESET_COLD:
> >>>>> +             return "cold";
> >>>>> +     case SYSRESET_POWER:
> >>>>> +             return "power";
> >>>>> +     case SYSRESET_POWER_OFF:
> >>>>> +             return "power off";
> >>>>> +     default:
> >>>>> +             return "unknown";
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>>     int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>>>>     {
> >>>>>         enum sysreset_t reset_type = sysreset_get_default_type();
> >>>>> @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>>>>                 }
> >>>>>         }
> >>>>>
> >>>>> -     printf("resetting ...\n");
> >>>>> +     printf("resetting (%s)...\n", get_reset_type_str(reset_type));
> >>>>
> >>>> NACK, this is potentially misleading as sysreset drivers can end up
> >>>> performing something different (see sysreset_walk_arg() just below).
> >>>
> >>> That's always been the case, but it was silent - do you suggest that
> >>
> >> We only said we are resetting, not which kind.
> >>
> >>> it prints a new reset message for each type? Bear in mind that when
> >>> one succeeds it is unlikely that the serial console will be updated
> >>> before the reset happens. In the majority of cases the requested reset
> >>> succeeds.
> >>>
> >>
> >> Indeed.
> >>
> >>> I quite like showing which reset is being attempted.
> >>
> >> I don't think it's worth the potential confusion. After all, we may very
> >> well NOT do the requested kind of reset. Wording will be important if we
> >> really want to do this. We need to be clear something else may be done
> >> in the end.
> >>
> >> We could print before attempting each sysreset type which kind we're
> >> trying... I think it's actually a good idea, because it isn't
> >> necessarily clear that even if you request a warm reset, you may still
> >> get a cold reset (or even a power-off) if no driver supports doing a
> >> warm reset. At the same time, we don't have a delay between printing and
> >> attempting a reset, so indeed like you said it may never get printed.
> >>
> >> So, first line in the while-loop in sysreset_walk would say "attempting
> >> sysreset <type>" and after the for-loop we check on ret != -EINPROGRESS
> >> and then print "no driver could do sysreset <type>, trying more
> >> aggressive reset" or something like that. Before return, we check on
> >> -EINPROGRESS and tell the user we failed to do any kind of reset. We
> >> probably should have some of those messages rather debug messages
> >> though, I fear it may be a bit verbose.
> >
> > The odd thing is that the last thing you would likely see (with this
> > approach) is the reset type before the one that actually succeeded. It
> > could be a bit confusing. But I suppose that would be OK, since we are
> > resetting and people should be aware that this can result in lost
> > serial output.
> >
>
> True, that's also misleading. We could flush() also and then hopefully
> the message really will be printed.

Yes, perhaps as a Kconfig option though, since some platforms reset
due to a fatal error, etc. Also it couldbe a follow-up, not blocking
this series.

>
> > Another approach (perhaps a follow-up to this series) could be to have
> > the driver indicate (e.g. with plat data) which reset types it
> > supports, so we don't bother trying unsupported ones.
> >
>
> We're iterating over all sysreset drivers in increasing power reset
> levels until we find one that works and do that reset, so filtering for
> supported levels by drivers... I'm not sure what that would help with
> here? What am I missing?

Hmm yes if the driver returns -ENOSYS then we know that type is not
supported, so it doesn't add much.

Regards,
Simon
