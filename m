Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3BC5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B09F60650;
	Fri, 31 Jul 2026 14:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5VCb1UW3wdf; Fri, 31 Jul 2026 14:44:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17D966065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785509040;
	bh=Na567xN6V+J10BfFgezFk+cEPZlOW2TfvHoLIz6+oC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZvn+EU47xvjWQOQwhixrRqL9ssaLHeQkrjvzXZo9VNx3MPdAmeGl6/TbjHb0XFs2
	 DEMiZ3qPYrUPP09nwQqjgZjOsfqA8Symwjk9dYQF1MSgg3qYiPE3IGdfAh53bYi78T
	 ongvQnIyuQW046efwLjvNANaeklA6HaICe810PlXZvOkakGXMsf31oCD+Uq3d/gJC2
	 nMyrzQYP0rObl/f5jlwS7qm+/lFNdshLGII+S5AHEVdekShUDL/AvjWyskcghLOIEZ
	 XfkcoqlKJMRsMcH7eEDmrN9uRDqPLMLoSWTw0x4RgD3VtgvMJ9mEP3QrNnc6td8FEm
	 NWxWeW8/I5HXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17D966065E;
	Fri, 31 Jul 2026 14:44:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8735E2E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84B5B80EEF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACkHGoOHbWeG for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:43:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C829C80EEB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C829C80EEB
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C829C80EEB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:43:56 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6685483aad2so1484280d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785509035; cv=none;
 d=google.com; s=arc-20260327;
 b=L4wxWbmLpYZRIIROjiBNkN0qMvSsLEGASB+C7Gkq4cCo1Me5GSmTWGcTkdJRVJ4Z2f
 l8eam3d+Q/zfrwnxbOeqktscOn+ojyXpEISitx4ZsD2XXbSpdsMu6PTP7RjtC6K0KdhE
 bX29pg0uejeN4paCND/kTBpGCPCoovDj3zFyBjwZCSY4nnn/VjV5i5h3H+v3Zr3AohOp
 Ny5XOZgDnBB8T3QDHrY7qY2WjSFdeyx1fmmuAA5nwhdL76GzWO+57M8VCQUcZhA02J4S
 O1SNHCLZTQ8KeVQtO7ueIFUIjKq1IgGCE34dBIZ+60fwCEJqKmimWNu/87Fh2FTeSapN
 0nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Na567xN6V+J10BfFgezFk+cEPZlOW2TfvHoLIz6+oC4=;
 fh=ISaYKS3FU5nt4I0HWrj+yeOaGnWjFKsuc0uR/fPQk2U=;
 b=EhnIi6oDR7MFLcRbBNtuymkooC83oqhMQmYlxHpxpeQRYStg03lvTgFDxOCiRO6uCu
 WgjMs8ypXrnNzbGcDNV+4YYsqH6FWj3epTQxfrkfgb93YdHqdMXpkdMzuwusFG98ik6S
 nRU/cMXWUpr44JELIw+1Xu8X/4NP9vQSW1YRnuGznst6Zxh5VJquLzkS9kDQMQjQloet
 jwchKeuNQAhwMEeqO9GKIxqXI9jII7EJL8G1EKCRCSpLutlAbFvP9x7wJfFjHVjSD11g
 ploEIwzy+B8GYzE9o8u5LHYXvNERPok+SnoX5QAO0qWcCUQhD3E8V2qhXAf54MFMpLiE
 yRVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785509035; x=1786113835;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Na567xN6V+J10BfFgezFk+cEPZlOW2TfvHoLIz6+oC4=;
 b=c7+ZSaVhllmttCIhZ48sBuQNMPIcKRAAINL569X6TAi0bSJ5DHrDNNyuhnbGZ4qw2L
 SZqYu8winDJ/c9qgN7jlJ8RWZGCxBfSb72IwtMn8HcOuSxj8l8+GBg/AgvcZwPNsIAVa
 sSSw9MwFKTuCMMajRAlioSORFfVRw1Xz6ps8qI4jLpmO0HuMhc75l9xDUY6CMmT/ucnA
 EfNRVbbcOX8AIPOCMyFTRy80FFhiPa2BdA7XSxl1oacSoKH+CTwdjjaSEO10e/RI9UrE
 bZB9norf0x+UGJeSlRFUCWGsZQqRGhFVmFHNH+XiSrqCVYG2TUYCWBPbrqBHYrd6ZD8H
 mXxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMfB+Au+UeaEvoDDZhCuMd8a6TerzYe+GGHkgQ7sRRSXMY1BcPDvW0ly2JHGKOL9gPLIysJR0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxrAWMyx48BIF34X1ZRUMO3RTNBH+5Spe92IReCo0B3yuphxzhT
 jz5z2kNhH2tL6AXb81MLnP7Qvm/ablmjgJ9bC94Jdfb5zc1axPs9P6TiKzKnds71KaU0TwEkSRZ
 5p8tGBRME78jsJY1bWw7tgErJe1cvKd4b7LPNbJr/0L0qLPut0GHUg8M=
X-Gm-Gg: AR+sD12/2xD5tvluh09o37ixuxoZFMM98B8U6kCxd6ArPcVkdPHwzPpqXRmbgKESpnS
 j8VeoOw1r36uSPH3GHeYdWKRdwVCOYBhGMLL2j9ZMuYkpjLv40bwCEfge5pUjVFibrL6cka0V7W
 9OeuDGnzLGv8u75VrQUMKcPDJzrQU97eQ9anWOuwbuWtO0aj8M79dOQc34wzoM16/kAdoW99mOy
 /A4/ElXeDvRmmmbLxsEDaqMeOSW8NgrKjClejjsO6axRcS7OzYkaA66kRvGRGJyGvGxgdAc8Poj
 qM6BOAhyAzp3tWLEanZExQ5c7Az4a8lFk7uMinMHbXnpymrsll8blFVRz2l21Wok8C551RZS37L
 036omtraHlvk454xoZaHHRvKQB62wt2CqIRIKGyoOayjoELLKJ2KyGNpcHYmc58QBoUnif7JuBq
 uW1VKpq1XXfBWazpOnwMooZZyN57DvWx12yeLaFXGxyBxtUhiHrAet3ou2hJnxeAWjtHchhJvpb
 ym/jGtyyZ3LeoaOLSeOp3BN3fLejDxJC49zeKtWkUAduPvi65Vr1nSKIuq2a6pyvRMqLEx53ytp
 YU0+H4phv+/lMaPXnuAb6tJUhFBemvyucIGvu54/pwKrICtt/yY/sOZKZjqAumVn+TIJ4pYFIMQ
 YwnqxSvE26AZrqMQ/Oeg56eFogDfUxHd2SHup0Y47rK17bCklKSPpOktTxNZbzcAgMR4diRePIg
 BxRg==
X-Received: by 2002:a05:690e:168c:b0:668:56aa:6d77 with SMTP id
 956f58d0204a3-6694efdd7acmr258795d50.9.1785509035039; Fri, 31 Jul 2026
 07:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
 <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
 <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
 <b4f8d148-ae3d-43e9-88b7-1362608985d3@arm.com>
In-Reply-To: <b4f8d148-ae3d-43e9-88b7-1362608985d3@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jul 2026 17:43:15 +0300
X-Gm-Features: AUfX_mwjZswKssVBENsCzTpZVosfAxSpUq6HO5PJcKo6JpfwDZL0OeXauNxxqAg
Message-ID: <CAC_iWj+35n7J2D6EvHr7LZB7L1t2+kNmxY7mBP+w7xgr6=A2jQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785509035; x=1786113835;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Na567xN6V+J10BfFgezFk+cEPZlOW2TfvHoLIz6+oC4=;
 b=tc+zwjXstZ4ZyKzbTd6Kpt0pIiBUmgdSs3GWJGFZtsEYMpgQR/oS/rqE26FbqsK/ry
 Zgr1JHMcprEylrVbOaICOHm2yTUM1YZzBz3Kef35SA5zev8jNNw8KxnBHJViyeU4L7cD
 bWzqJSTrz0ZKhvuWRa1DLPlofu7RSw/qX1gEIQis+7OOhWgfm5HdJXHRtl1m3pUkOUbQ
 gL3D26AZ5l1bTffeuroin7LR1xt8+sWBz45bySRaO9FFGzU5hMMiY6T/zvQZQEVM3wBc
 p4kv8mj5djM78RlxpeBmXvldBcwlrcnNB141q8r6SkecTL8zBvSipqeR+oQFykXS7y0W
 ejYw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tc+zwjXs
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

Hi Harsimran

On Fri, 31 Jul 2026 at 17:17, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 7/30/26 13:12, Ilias Apalodimas wrote:
> > Hi Peter,
> >
> >>
> >> Hi Ilias,
> >>
> >>> I'll be off next week so this is going to take some time for a wider =
review.
> >>> Since this is quite a lot of code to review, I'd prefer being able to
> >>> test all of the cases to make sure nothing breaks and add more
> >>> selftests in the future. I don't have access to a Corstone-1000.  The
> >>
> >> You can get the Corstone-1K FVP here:
> >> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/index.html
> >>
> >
> > Ok thanks. I'd still prefer to have this on QEMU since we can
> > reproduce all the cases there (variables in RPMB as of today + the
> > FF-A variant). Even if we do use the FVP, I'd like to have information
> > of how to build & test this as part of the cover letter, since Tom
> > includes that in pull requests.
> >
> > Cheers
> > /Ilias
>
> Hi Ilias,
>
> The instructions to build the Corstone-1000 FVP can be found here:
> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/user-guide.html=
.
>

Thanks

> For the QEMU/RPMB/OP-TEE question: QEMU RPMB would cover the storage
> backend, but the FF-A runtime transport also needs the secure world to
> expose the MM variable service through an FF-A secure partition. OP-TEE
> alone would exercise the existing CONFIG_EFI_MM_COMM_TEE transport, not
> the FF-A runtime transport, unless OP-TEE/SPMC is hosting an FF-A SP
> that implements the same MM variable communication protocol.

OP-TEE can also be configured to run in SPMC mode and load SPs. The
question is what is the backing storage of your SP

>
> For Corstone-1000 we are already using the Trusted Services SMM Gateway
> SP. That SP implements the MM variable service and exposes the MM
> Communicate endpoint over FF-A direct messages, which is the path used
> by this series.
>
> I agree that QEMU would be better for wider review and CI. I will have
> to investigate the QEMU setup using the same SMM Gateway SP along with
> OP-TEE/SPMC and RPMB, so we can reproduce the FF-A runtime variable path
> without access to Corstone-1000.

I can help, I just need a bit more info on that SP. I'll have a look
at the public docs as well

>
> Do you suggest that I investigate this QEMU setup for the
> next revision?

I'd like to at least see the gap, but I suspect it's going to be small
if it even exists.

>
> The setup I am currently testing is Corstone-1000 FVP with the MM
> variable service exposed through FF-A. The FF-A runtime path is tested
> in two phases as follows:
>
> The first phase (setup phase) creates the non-volatile runtime variable
> before reset. On U-Boot prompt:
>
> corstone1000# setenv efi_selftest 'variables at runtime setup'
> corstone1000# bootefi selftest
>
>
> Then reset the Corstone-1000 FVP and run the second phase.
> The second phase verifies that the variable is available after reset,
> then exercises runtime get/set/append/delete paths.
> On U-Boot prompt after reset, execute the following commands:
>
> corstone1000# setenv efi_selftest 'variables at runtime verify'
> corstone1000# bootefi selftest
>
> The testing steps are documented in the bootefi documentation commit:
> doc: bootefi: note two-phase runtime variables selftest
>
> For v5, I can add these tested steps to the cover letter.

There's no need for a v5 yet, I'll take some time and reprod with the
FVP. Just keep in mind I'll be off for the next ~20 days so this is
going to take a while, apologies.

Cheers
/Ilias
>
> Thanks
> Harsimran Singh Tungal
>
> >>> latest version of QEMU do support emulating an RPMB device. Would the
> >>> changes above work with with an SP, QEMU RPMB and OP-TEE?
> >>>
> >>> Thanks
> >>> /Ilias
> >>>
> >>> On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
> >>> <harsimransingh.tungal@arm.com> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> This series adds FF-A runtime transport support so EFI variable runt=
ime
> >>>> services can communicate with the secure world after ExitBootService=
s().
> >>>> It also extends tests, documentation, and Corstone-1000 configuratio=
n to
> >>>> validate the runtime path and keep boot-time behavior aligned with t=
he
> >>>> runtime flow.
> >>>>
> >>>> Changes in this series:
> >>>> - Add EFI runtime-safe memset helper and FF-A runtime transport supp=
ort.
> >>>> - Add runtime-safe FF-A direct-message handling and ExitBootServices=
 setup.
> >>>> - Implement FF-A runtime communication in the EFI variable TEE backe=
nd.
> >>>> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableNa=
me(),
> >>>>    and QueryVariableInfo() over the FF-A transport.
> >>>> - Add sandbox FF-A runtime transport tests.
> >>>> - Extend EFI selftests for runtime variables and enable bootefi self=
test
> >>>>    on Corstone-1000.
> >>>> - Document the FF-A runtime transport and runtime-variable selftest =
flow.
> >>>>
> >>>> Changes in v4:
> >>>>
> >>>> Address Ilias Apalodimas's review comments:
> >>>> - Split FF-A bus runtime support into smaller patches covering runti=
me
> >>>>    private data, SMC invocation, direct-message helpers, boot-time r=
euse,
> >>>>    and ExitBootServices setup.
> >>>> - Split the ARMv8 cache range-maintenance runtime annotations into a
> >>>>    separate patch.
> >>>> - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
> >>>>    GetNextVariableName(), and QueryVariableInfo() support into separ=
ate
> >>>>    patches.
> >>>> - Replace MM SP status macros with an enum.
> >>>> - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
> >>>>    enabled.
> >>>>
> >>>> Other changes:
> >>>> - Rebased the series onto current U-Boot master.
> >>>>
> >>>> Changes in v3:
> >>>>
> >>>> Address Simon Glass's review comments:
> >>>> - Move FF-A ExitBootServices event registration to the end of probe =
and
> >>>>    clean up RX/TX buffer handling on failure.
> >>>> - Rename FF-A runtime-context helpers to the ffa_runtime_context_* f=
orm.
> >>>> - Rework FF-A/MM cache maintenance to cover only rounded request and
> >>>>    response ranges.
> >>>> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> >>>> - Document FF-A shared-buffer ownership and alignment assumptions.
> >>>> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
> >>>>    entry points.
> >>>> - Tighten sandbox FF-A runtime tests and reset runtime state between
> >>>>    test cases.
> >>>> - Update FF-A and bootefi documentation for the runtime transport an=
d
> >>>>    split runtime-variable selftests.
> >>>> - Rework commit messages to drop redundant information.
> >>>>
> >>>> Address Ilias Apalodimas's review comments:
> >>>> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset=
.
> >>>> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> >>>> - Remove log_*() calls from __efi_runtime FF-A/MM communication path=
s.
> >>>>
> >>>> Other:
> >>>> - Fix FF-A memory-share sender_id to use the runtime private endpoin=
t
> >>>>    ID after rebasing.
> >>>> - Fix the expected QueryVariableInfo() return status for the
> >>>>    TEE-backed runtime selftest path.
> >>>>
> >>>>
> >>>> Changes in v2:
> >>>>
> >>>> Address Simon Glass's review comments:
> >>>> - Fix efi_memset_runtime() style, declaration, and byte cast
> >>>> - Tighten the FF-A runtime context failure path, clean up arm-ffa-ru=
ntime.c
> >>>>    style issues, and move ExitBootServices event registration earlie=
r in probe
> >>>> - Add shared-buffer bounds/alignment checks, and tightening comments=
/kernel-doc
> >>>> - Document the FF-A shared buffer cacheline-alignment requirement an=
d add
> >>>>    BUILD_BUG_ON() checks for the address
> >>>> - Cache attributes before the shared buffer is reused, moving the re=
ad-only
> >>>>    check earlier, and split the u16_strsize() related change in sepa=
rate patch
> >>>> - Reword commit messages for the runtime helper relocation
> >>>> - Rework the non-volatile runtime variable selftest into setup/verif=
y phases
> >>>> - Extend the sandbox FF-A runtime tests with no-context coverage,
> >>>>    runtime-context reset, and separate errno-mapping coverage
> >>>> - Refresh the FF-A runtime transport and bootefi documentation
> >>>> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime an=
d
> >>>>    boottime capabilities in v2
> >>>> - Squash patch 8 and patch 9 from v1
> >>>>
> >>>> Address Ilias Apalodimas's review comments:
> >>>> - Reuse common MM SP error mapping for boot and runtime paths
> >>>> - Rename runtime-phase tracking to reflect the ExitBootServices tran=
sition
> >>>> - Collapse duplicated boot-time and runtime MM communication helpers=
 into common
> >>>>    implementations
> >>>> - Keep the arm64 cache-maintenance path runtime-safe
> >>>> - Move FF-A shared-buffer runtime memory-map registration to the end=
 of
> >>>>    variable-service initialization
> >>>>
> >>>> Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-=
harsimransingh.tungal@arm.com/
> >>>> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-=
harsimransingh.tungal@arm.com/
> >>>> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-h=
arsimransingh.tungal@arm.com/
> >>>>
> >>>> Harsimran Singh Tungal (22):
> >>>>    efi_loader: add runtime memset helper
> >>>>    arm-ffa: store boot-discovered runtime data separately
> >>>>    arm-ffa: add runtime-safe FF-A SMC wrapper
> >>>>    arm-ffa: add runtime direct-message support
> >>>>    arm-ffa: reuse direct-message helper at boot time
> >>>>    arm-ffa: enable runtime context at ExitBootServices
> >>>>    arm: cache: keep range maintenance available at EFI runtime
> >>>>    efi_loader: add MM SP status mapping for FF-A variables
> >>>>    efi_loader: make MM transport selection runtime-safe
> >>>>    efi_loader: make FF-A MM SP notification runtime-safe
> >>>>    efi_loader: make FF-A MM communication runtime-safe
> >>>>    efi_loader: reserve FF-A shared buffer for runtime variables
> >>>>    efi_loader: enable TEE runtime SetVariable() over FF-A
> >>>>    efi_loader: enable TEE runtime GetVariable() over FF-A
> >>>>    efi_loader: enable TEE runtime GetNextVariableName() over FF-A
> >>>>    efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
> >>>>    charset: mark u16_strsize() as __efi_runtime
> >>>>    corstone1000: enable bootefi selftest
> >>>>    efi: selftest: add runtime variable tests with non-volatile stora=
ge
> >>>>    test: dm: add sandbox FF-A runtime transport tests
> >>>>    doc: arm64: document FF-A runtime path for EFI variables
> >>>>    doc: bootefi: note two-phase runtime variables selftest
> >>>>
> >>>>   arch/arm/cpu/armv8/cache.S                    |   8 +
> >>>>   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
> >>>>   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> >>>>   configs/corstone1000_defconfig                |   3 +
> >>>>   doc/arch/arm64.ffa.rst                        |  88 ++-
> >>>>   doc/usage/cmd/armffa.rst                      |  11 +
> >>>>   doc/usage/cmd/bootefi.rst                     |  31 +
> >>>>   drivers/firmware/arm-ffa/Kconfig              |  11 +
> >>>>   drivers/firmware/arm-ffa/Makefile             |   4 +-
> >>>>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
> >>>>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
> >>>>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> >>>>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
> >>>>   include/arm_ffa.h                             |  16 +-
> >>>>   include/arm_ffa_priv.h                        |  22 +-
> >>>>   include/arm_ffa_runtime.h                     | 191 +++++
> >>>>   include/efi_loader.h                          |   3 +
> >>>>   lib/charset.c                                 |   2 +-
> >>>>   lib/efi_loader/Kconfig                        |   4 +
> >>>>   lib/efi_loader/efi_runtime.c                  |  20 +
> >>>>   lib/efi_loader/efi_variable_tee.c             | 739 ++++++++++++++=
+---
> >>>>   .../efi_selftest_variables_runtime.c          | 715 +++++++++++---=
---
> >>>>   test/dm/Makefile                              |   3 +-
> >>>>   test/dm/ffa.c                                 |   6 +-
> >>>>   test/dm/ffa_runtime.c                         | 123 +++
> >>>>   25 files changed, 2004 insertions(+), 498 deletions(-)
> >>>>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> >>>>   create mode 100644 include/arm_ffa_runtime.h
> >>>>   create mode 100644 test/dm/ffa_runtime.c
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
