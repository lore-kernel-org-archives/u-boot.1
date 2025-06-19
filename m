Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F0C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B380C82CBB;
	Thu, 19 Jun 2025 16:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x771RkNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D08282CCE; Thu, 19 Jun 2025 16:43:48 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943E682C65
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b31d8dd18cbso929658a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750344224; x=1750949024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EDDaClTIEtso8c16D3DJBteP6SV7y+NZjBhuvMThMko=;
 b=x771RkNktw2kVm5wMnzpVaCMPauXzC0MYT/sPA5lFm5TOPMrP1ODfH4HZ1U77FdzzA
 qQ+Jf7SBRXFQUnCCYSKB4S4cNBUakmSpWI3iYmE+XWxfBSy2FbpI1lyzKONi/kgtXbAz
 bJQht9XVBer0HzVcKxd5YMhxmvcuGBIRny1vuzhGxS+fkimFAZTybA1dl57SPjzbtaEe
 dPvV7JQsErEvHf7WpMPog2+nn7CXvYByHUWrDeT/tmXWWL82WDu5HoHOjDLmjXSHIeSs
 AHyiFcyONKG+pj3paAxz7zETHLlz0HdOFq+Fd5lWbSOXXudcz61rSfrSm1P7tqNZffPo
 UwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750344224; x=1750949024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDDaClTIEtso8c16D3DJBteP6SV7y+NZjBhuvMThMko=;
 b=KLr7LvY9osQrYHkBLD/rCNKvTOdFA2kQUlxd0f0g2xW36iaDCMuLBiwgQjBH5YDh4Z
 gesXhYVG+K4WtCBLTL5+kz1OvoVl/8opYXXTPvuLc5mMY1JQ65TEYtO8Y6y06CJOwwDE
 sO1kkaIgiZ0RjmdlqNF8j4ZlbnXhRFL0zP/tdkCaj54qTs3XXBDij7DRlHUHY85aCEuV
 k7jCbAcDg6E2ePzwVILsFMHhquwKa1OsLzy1nVPLTRbIHRhkJVpEIOehEQ6vkXpoZq7K
 bBrX6OEh6lWHQDnW8Z7kRpC8Ny89cMi+gjboIBp/Rxkt5G4gaMojLvBK0gZM9uPZs79i
 yKlQ==
X-Gm-Message-State: AOJu0YyaFt1NUSzmxxewaGJ7Y3HP38HZnt8SJVW9OJ6jjgXG0jg76fNG
 v1B7IjVucmoJiFCyhuaYrw4kvKCrodmeTV9FxDMbEjBJMMfzuWM6+PTT8PaNwie/OQBfH/x6s2s
 LJ/JOsnDBn6wtOkGKFUr6reTg2kkEOkhR8aOZre+z8A==
X-Gm-Gg: ASbGncvVajfP70zrnoam7KCwQJUTMevgo3fKOmKt5r+V3y7uHn0f/2T411QrcQoptlD
 nlLD1VtKfyQOYnF1qPpMsA7bKHdljmW7Qx6KQ/IeJv/u0N1DZ/3URYSB5Th/6A0jI2wganPr6/i
 w6EPcNQGwjmeHLa0VW2LSWRz3s9qFXBMnwGXr3RaQvz8CqAKIA8c2tcg0=
X-Google-Smtp-Source: AGHT+IG9UnoyJLmF0/KQeKt0t3gRspgJ5+JAQapIzeJXwl1jFtgickC4/rRlZhAuxqNKs4OoteeM2dzv7Y8nU+aEzrE=
X-Received: by 2002:a17:90b:3907:b0:313:f6fa:5bb3 with SMTP id
 98e67ed59e1d1-313f6fa5d88mr24037584a91.26.1750344223949; Thu, 19 Jun 2025
 07:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-2-raymond.mao@linaro.org>
 <20250618173713.GH6521@bill-the-cat>
 <CAEfUkUJe+sgbPU0BYiZnGo15CMXfaixiRVYNv+vw8+h6YAOrZA@mail.gmail.com>
 <20250618220441.GK6521@bill-the-cat>
In-Reply-To: <20250618220441.GK6521@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Jun 2025 10:43:31 -0400
X-Gm-Features: AX0GCFuCtVxw0nttH1-PWwYlu0hq3ZHFypiBxNPsP-QqQIOfk2daLawCTJuyhuE
Message-ID: <CAEfUkUKAr+ANHk3F1_Zdtgfg1zT+WiM_H2T8Nx-emdboGupgCA@mail.gmail.com>
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

On Wed, 18 Jun 2025 at 18:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 18, 2025 at 03:53:15PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 18 Jun 2025 at 13:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jun 18, 2025 at 07:59:23AM -0700, Raymond Mao wrote:
> > >
> > > > Add blob type for DT overlay according to the update of Firmware
> > > > Handoff spec[1].
> > > >
> > > > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >
> > > Once merged, this should be a Link: line for tooling to better pick it
> > > up. And I don't want to merge this here until it is merged / agreed to
> > > in FirmwareHandoff.
> > >
> > > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > > index f32faf78560..b40e04fe2d3 100644
> > > > --- a/include/bloblist.h
> > > > +++ b/include/bloblist.h
> > > > @@ -110,7 +110,8 @@ enum bloblist_tag_t {
> > > >       BLOBLISTT_ACPI_TABLES = 4,
> > > >       BLOBLISTT_TPM_EVLOG = 5,
> > > >       BLOBLISTT_TPM_CRB_BASE = 6,
> > > > -     BLOBLISTT_ACPI_PP = 7,
> > > > +     BLOBLISTT_FDT_OVERLAY = 7,
> > > > +     BLOBLISTT_ACPI_PP = 8,
> > >
> > > ... sigh, so BLOBLISTT_ACPI_PP isn't something in FirmwareHandoff yet.
> > > Was someone working on that it should it be moved down to the project
> > > internal numbering area?
> > Since we decided to make bloblist compliant to Firmware Handoff, it is
> > required to get an ID placeholder in the spec first (at least a PR)
> > before updating the code to avoid conflicts, but BLOBLISTT_ACPI_PP
> > does not exist in the spec. In this case, I will consider it as a test
> > only ID and can be shifted. Or I can move it into the custom range if
> > you think that is better.
>
> I'm hoping maybe Patrick will chime in at least as yes, we should either
> upstream it, or move it.
I think shifting it to 8 makes sense, that is an un-occupied ID and is
not blocking for submitting PR with.

Regards,
Raymond

>
> --
> Tom
