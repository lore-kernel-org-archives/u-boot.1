Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED6CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5FB84B65;
	Thu,  7 May 2026 17:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ASXNR2tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028F384B77; Thu,  7 May 2026 17:32:53 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0912B84ADD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso1583934a12.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167970; cv=none;
 d=google.com; s=arc-20240605;
 b=H1qQPv2oL7R22F6m3+vO7KZh67lpLIuHcT0qvwNtd4ysqjdOJVjKQulwSyAlq7aDiC
 UPusMuMNDKHsYZ/QKul5XYECgolfstih9TxOw+eBD+I5eLCc890HU1Ttw7iQZYR+Tz2h
 ooSoazUAxCnvpqjFGOn40uQvbzeOfOiYDQsRXNTblauRIMm4k6wYQFJ16kbCR16Ozt2n
 xrnhGnABT8uriyUUxj98TBfDL1VOsuYrHXi6cH/BCqnFrsbnivXwkNCj9Jhmc37K8ouH
 qt/9PQX/XWPwcYxvq2Cey5fXsXfGLIdst5GNBLzZEI+l1vtNuP7FTxEjYAFqAA15xHTx
 iuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jDlKVjhVdWwaR1Pqn/Qx9HBkQNshJiRnsZGEkv+SV3w=;
 fh=3zI1MY2jLb+geQSEEyacKu9xbYcO7fBIfrZAWhTcvFI=;
 b=XhnrGhqfntOWwFEUmk72NqFRv5YUh9F4XHIIcTjpSbyLe2jxlLx10iD1x150j7HLYP
 LWb+4n789limZWbZYDTJRC102EO7h+oSV+pVrJyTgelEt9cEYr+wP7Q9Zd6wgwXzesZQ
 WWyb58ppbxY2qPixA+EtpItDrMonmFIWBiJYmgGgWLEjsQDowNdusFLMWsdMG/jb6u6k
 gdwrmdkkIdsCJTzAkM6rWstHlygZDTM21VbrIFoS/LxPDmWUyCWzBoeMgG1ykVc6b8m5
 48PugZVsw5S8TfAyRWAK69t2dHSjcO4FNeQoK8E+AfMA3L/PRvFopL1iEAmh7Uh/cweS
 eycA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167970; x=1778772770; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jDlKVjhVdWwaR1Pqn/Qx9HBkQNshJiRnsZGEkv+SV3w=;
 b=ASXNR2ttfCrfgBZbRtBC5K9ePHQscYzfBNOeV1aWomhfvMOv139szEN938ulOCORcs
 p8+Pse1VyPmBGc/6IzkyOyz90W3M8Pxj+zgufAZLI8HtY6tIfquiBuQG2tZ33UtyUldv
 iCPzzEM+UGSjSRGcwgyFT+2K5Bjmyy8n04+N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167970; x=1778772770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDlKVjhVdWwaR1Pqn/Qx9HBkQNshJiRnsZGEkv+SV3w=;
 b=L3/ZHzZcD89E2yQNY69bvL4J4NTHohEUL11tpJt0asfB95+7e62KlXu/a8meeQ89a4
 Ep8EVtc91aO8JXzbQDWnjtTirHE4/bCgoqgDcY1Ed+wk5U0GpYa4nZVQnA6MhI6eWGuh
 Cwlr7u6pjxn1Sc1rfKkaUDOHOQZBKhMLYLky+I0ygRaFwGEu4TSKtBuY2XGUmdmG9ROD
 NUV6rrNyfQbWNQbd+3h0bfAaaqxx9PSClo4XhM70P3meOEnpinmFGM5XYOjdm19VAtSm
 bAzVhd8YvpAsS+iscddhthpp5/rl0fzejug61V6xpTqe7PbpGeIr4wohvQP8CdhPgiqn
 ftnA==
X-Gm-Message-State: AOJu0Yy+p4LTh37TzwkdvHJzsNTIZc0c4YLERxEvyLX5C+IhA4/RnpQT
 0sMCPflZVizwIcVqrJJ1y5a4bzrqzp2USSwEtmYTY2OzRHtDzkBbO7DY8JmS5LK5hTB8FE4CQgi
 mhreIdPHyvG3Kj+93HU8FHxn7a1WN3+a0bl/beKNO
X-Gm-Gg: AeBDiesdgWhHR359XyPo5glvak62xXnbekGGQw1MOKf5WrwwanYERasBpIE9cMpcBVD
 x3OqoLWqcVebzLIsoygbr/JFhlAm8Xv3teEtw8aBBtwz0T30PlUgi3M0balBvu97iC4C7WIXWL8
 cUnRVGcoeUKk1EO+65mjQJmuPTjENiAP2db8H1hbZS2pAA0pgdstTJ5l1XX4/NKGsHMrjLZQLG2
 zKBjeDuDjKnob70C7jtvlgWgOH6yjK+ZslKca0DTQYb/bCmEkuwbbqqQq/TODhM8enkkbcv7wJ9
 Im++VgPDLhyDVoti
X-Received: by 2002:a05:6402:26d0:b0:679:223c:d181 with SMTP id
 4fb4d7f45d1cf-67d642b249dmr4417411a12.15.1778167970273; Thu, 07 May 2026
 08:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-8-harsimransingh.tungal@arm.com>
 <CAFLszThODjZiHNnTnKFUV=Sx2dZPeW=t+5t6Yfh6wcQDwjMkZA@mail.gmail.com>
 <177808046518.1594688.12778239468862754841.b4-reply@b4>
In-Reply-To: <177808046518.1594688.12778239468862754841.b4-reply@b4>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:32:38 -0600
X-Gm-Features: AVHnY4KMZl3de5eXWj8Acv_axOSg48acFx_PFqEEzIDQPJjZwdEr_rKEcrnNIBY
Message-ID: <CAFLszTgJUCxJoYPepLZC_zpL_4T4hRZ=2UYrZZLy9SjMy_MuhA@mail.gmail.com>
Subject: Re: [PATCH 07/12] efi: selftest: add runtime variable tests with
 non-volatile storage
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
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

Hi Harsimran,

On Wed, 6 May 2026 at 09:14, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-04-28 12:04 -0600, Simon Glass wrote:
> > Hi Harsimran,
> >
> > On 2026-04-24T17:31:50, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > > efi: selftest: add runtime variable tests with non-volatile storage
> > >
> > > Extend runtime variable tests for persistent storage
> > >
> > > Previously, EFI selftesting of runtime variables was only supported
> > > under CONFIG_EFI_RT_VOLATILE_STORE, which uses VarToFile to simulate
> > > non-volatile variable storage. This commit adds new test cases that
> > > exercise runtime variable operations for persistent storage.
> > >
> > > Features tested:
> > > - Creation of runtime-accessible variables (set)
> > > - Retrieval of runtime variables (get)
> > > - Deletion using SetVariable() with size = 0
> > > - Append operation using EFI_VARIABLE_APPEND_WRITE
> > >
> > > This improves EFI compliance validation for non-volatile runtime storage
> > > scenarios and ensures proper attribute enforcement and variable
> > > management.
> > >
> > > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > >
> > > lib/efi_selftest/efi_selftest_variables_runtime.c | 106 +++++++++++++++++++++-
> > >  1 file changed, 104 insertions(+), 2 deletions(-)
> >
> > > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > > @@ -39,6 +46,80 @@ static int execute(void)
> > > +     /* Compare the value of EFI variable if it already exists in non volatile storage */
> > > +     if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > > +             len = sizeof(v) / 2;
> > > +             ret = st_runtime->get_variable(u'efi_st_var0', &guid_vendor0,
> > > +                             &attr, &len, data);
> > > +             if (ret == EFI_SUCCESS) {
> >
> > The two-phase split worries me. As written, phase 1 creates a
> > non-volatile variable and immediately returns EFI_ST_SUCCESS, so a
> > single 'bootefi selftest' run reports a green test even though none of
> > the new assertions (append, delete, re-get) actually ran. It also
> > leaves 'efi_st_var0' behind in NV storage if the user never reboots
> > (or if phase 2 fails on an early assertion before the final delete).
> > Could you split this into two distinct EFI_UNIT_TEST entries - say
> > 'variables at runtime (setup)' and 'variables at runtime (verify)'.
> > Then the user (and CI) explicitly select each phase, and the
> > persistent state across the two is part of the contract rather than a
> > hidden side-effect. At minimum, phase 1 needs to print a clear 'test
> > incomplete, please reboot and rerun' rather than EFI_ST_SUCCESS.
> >
>
> Hi Simon, Heinrich,
>
> I would like to confirm the design direction for this selftest change before I send v2.
>
> The proposal is:
>
>   - Keep the existing automatic `variables at runtime` test for `CONFIG_EFI_RT_VOLATILE_STORE=y`, so the volatile-store runtime coverage stays in the current single-run form.
>
>   - For the non-volatile case, replace the previous implicit two-phase flow with two explicit on-request tests:
>     `variables at runtime setup`
>         EFI_UNIT_TEST(variables_run_setup) = {
>                 .name = "variables at runtime setup",
>                 .phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
>                 .setup = setup,
>                 .execute = execute_setup,
>                 .on_request = true,
>         };
>
>     `variables at runtime verify`
>         EFI_UNIT_TEST(variables_run_verify) = {
>                 .name = "variables at runtime verify",
>                 .phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
>                 .setup = setup,
>                 .execute = execute_verify,
>                 .on_request = true,
>         };
>
>   - `execute_setup` would:
>     run the runtime `QueryVariableInfo()` checks,
>     exercise create/delete of a runtime variable,
>     create `efi_st_var0` in non-volatile storage with the first half of the payload,
>     print that the system should be rebooted and `variables at runtime verify` should be run next.
>
>   - `execute_verify` would:
>     validate the prepared variable from `setup`,
>     append the remaining payload,
>     validate the full contents,
>     delete the variable,
>     confirm that it is gone.
>
>   - If `setup` finds an existing `efi_st_var0` already containing the expected half-payload, it would report that setup is already complete and ask the user to run `verify`.
>     If the existing variable does not match, it would delete the stale variable and recreate the expected setup state.
>
>   - The failure logs would also be made step-specific, so local runs and CI logs show exactly which runtime operation fails, and `verify` would print an explicit success line.
>
> The intention is to make the reboot-dependent non-volatile flow explicit, while keeping the current volatile-store runtime test structure unchanged.
>
> Does this design look reasonable to both of you for v2?

That seems reasonable to me, yes. This is a little tricky :-)

I have talked to Heinrich about moving these tests to the normal ut
framework, but I have not tried to actually do it yet. In any case it
should not affect your work here.

[..]

Regards,
Simon
