Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5675C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 19:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0431082C2F;
	Wed, 18 Jun 2025 21:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nq10/I59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4986182C55; Wed, 18 Jun 2025 21:53:32 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACD482BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 21:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso8635680a91.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750276408; x=1750881208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2jwHvYDgWthlqZjosTW9ucfSveRLHxEZa77uOykgOmM=;
 b=Nq10/I59IOzmO6b9SIzh8BPAlSpezcMKdavedoOhC5BGjeUqk+bD5ux7/2ov/Lt2IL
 hy2Rb4wl3JHOykbfaqzn7lnWXM0RsoWAls1bPCHQrvp3DKYb/vAWcf+HvFsxeklCiMGO
 0QX/JmCoer1VLqKLvT1qRtIGrhU93TMQGw+Cw6jx5JQuwsyMmtDictkXZq7LGb86RccC
 zkN3sjhJEU6fhF72qdsAanAIc6hJBeMuaL0IsKnszauFJ/aR8N245TFdy9sOAZupyf/a
 yrdmvgdRViplYRetViQHSeMQykqo0rtJbwIIdBzcwNxA9NL+3n7aTdPpM8cAVsU7xfsl
 80Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750276408; x=1750881208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2jwHvYDgWthlqZjosTW9ucfSveRLHxEZa77uOykgOmM=;
 b=i0KZNusEaITSUArLIpXFXicLFbSMs6BABghLO0fZ8loi7iKI9WSTdDaScphGcGXM/e
 cUZ/PzzLOrUjzwwn0Uh7BXoyfkiIhWJPCzR+TJklgdAkD+lL0KerPW2mYJmnVc34RpoF
 8m2dlzT/KaAbqxwts7UHYkcrG++/wsguQ9DKjG8FAoUAf9sajgdjhdZ426cLBOskO0tM
 ZnsBim2xwiZE9zd3FEKQZa+Bmyyehc6zzU8TU5YmGs4iqWj5y9Nmcf8dhHBvLasboRO3
 U7zgww3TciNWcFH1Qo0vUaChjFMqkcHuVMHY+/rN5KhmxNzKb5gXQxoXb4NKIcIu+3Q5
 zn6w==
X-Gm-Message-State: AOJu0YyzQj9PhjXgL7U4wciLbuFcNKE3lmfoABa9Qdxjo4M98MvKMVGl
 ueWTss95skdVlSNlZSUxHDw+PWPHq7hh3PciO3hD1ZzS1zG3oWGwlLBhekqSwL7JOxX2wWVGG4S
 KJpCt1Aw2kEFt0irgE2HM5Q/+ew+ZVVDXrVyhetskNw==
X-Gm-Gg: ASbGncu7PFV0Co84eQezyQ68n0ZMM6sx/xKBW54ZLrL/yIQ+kKLqvxosda1hVzrcWH+
 vErsTT34Ypggasl3aCRT1bt0awlMi+/D4jmWkdCC37F3gIBP9aI8KbRqRlBCiIUE6j6uLQijrE9
 qKkQLadFr8Rihrhtx7px59gBviHYUrm5kjrymolNrVsyw4
X-Google-Smtp-Source: AGHT+IHa/ABILFjJ7svf1tL8rxYPEqt7Ax3/2DbNJsW54h5JoG5AdKOdu/yowDkZch3elmLFaK8th7Ex/oyNAL9wN6w=
X-Received: by 2002:a17:90b:1a8e:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-313f1d25619mr21818955a91.32.1750276407896; Wed, 18 Jun 2025
 12:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-2-raymond.mao@linaro.org>
 <20250618173713.GH6521@bill-the-cat>
In-Reply-To: <20250618173713.GH6521@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 18 Jun 2025 15:53:15 -0400
X-Gm-Features: AX0GCFvzbeOFL-VFvE_nthidpw2ffPtRJXT_-vQcZxTYGmFW-RRlaxk2trd77YQ
Message-ID: <CAEfUkUJe+sgbPU0BYiZnGo15CMXfaixiRVYNv+vw8+h6YAOrZA@mail.gmail.com>
Subject: Re: [PATCH 1/6] bloblist: add blob type for DT overlay
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Wed, 18 Jun 2025 at 13:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 18, 2025 at 07:59:23AM -0700, Raymond Mao wrote:
>
> > Add blob type for DT overlay according to the update of Firmware
> > Handoff spec[1].
> >
> > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>
> Once merged, this should be a Link: line for tooling to better pick it
> up. And I don't want to merge this here until it is merged / agreed to
> in FirmwareHandoff.
>
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index f32faf78560..b40e04fe2d3 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -110,7 +110,8 @@ enum bloblist_tag_t {
> >       BLOBLISTT_ACPI_TABLES = 4,
> >       BLOBLISTT_TPM_EVLOG = 5,
> >       BLOBLISTT_TPM_CRB_BASE = 6,
> > -     BLOBLISTT_ACPI_PP = 7,
> > +     BLOBLISTT_FDT_OVERLAY = 7,
> > +     BLOBLISTT_ACPI_PP = 8,
>
> ... sigh, so BLOBLISTT_ACPI_PP isn't something in FirmwareHandoff yet.
> Was someone working on that it should it be moved down to the project
> internal numbering area?
Since we decided to make bloblist compliant to Firmware Handoff, it is
required to get an ID placeholder in the spec first (at least a PR)
before updating the code to avoid conflicts, but BLOBLISTT_ACPI_PP
does not exist in the spec. In this case, I will consider it as a test
only ID and can be shifted. Or I can move it into the custom range if
you think that is better.

Regards,
Raymond


>
> --
> Tom
