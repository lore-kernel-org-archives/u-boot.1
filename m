Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E54C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 11:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 813C54060E;
	Tue,  1 Sep 2026 11:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id asKGdAGnq9yT; Tue,  1 Sep 2026 11:19:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788261548;
	bh=1RMggdA/j6RqztPA2S7ZAJnGjPpbLIaM9BRUV7kNtpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OGRDk0hnBF31CL1kk5QoDimW4J3Uyl5IwAtMSj+a4pOX3SiY+PErZiBnmNusCC53E
	 CjCSNTlt5P/R2mdrXG0WWR7BGaXJo1pG8upGjwW061Co7/M650Ex5O4Ao4Jr1WG1ml
	 n3XLF9XE/FzXj3+RI642PsIX0X7A8tzPGDdmBk1WA+lo/aymQpvJDWG0MJdSARaS3C
	 Xf/ZNoY3c0NMxEQXEFrvZJ1tQ3p4rd3K4Nxw/y2Z8/x3YrsDfaJmdrIXNqTOrBQkmg
	 LOBDV4LdX61IIS8DJ6YJAZsrjBilVMIfAXoI2l2O6FjKR5L1q7YSxf4cjuAGcZZILo
	 YGUNtXQKdczhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48A1740612;
	Tue,  1 Sep 2026 11:19:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33C0F1D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19AAA400A8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id paUPyYOVyWzQ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 11:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sd2QOO4g
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 961784000B
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:19:01 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-865bdc6ed72so32997187b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 04:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788261540; cv=none;
 d=google.com; s=arc-20260327;
 b=lw8z2PNAsJqCj5PuMkrpRYUEOBM4rV7zvf0lLGWYXCZbcziM5EREMQL9sgwU/CYMSK
 7DuYMF75YQaAEJczi0SoYjMcNvjW3WOTASW2SikL7SSfP1X6/Ms/h04iGMWZfQf66KS0
 QVUnLQOIhRXJiq84IpqejO/sWgpyF/5jhE8YwTzOtOplDXVAec/CSPB9gnL02RV1DWuq
 jfwSQM8wbrLOupIGbLRMUooEL+eLhG7KcF3vF279dANzBP2wvnRsTQ9ql1P/mrzw1hd/
 t8abSjFTihN89MnLbF08RSEgiQDAiYlFUX9ZviXqyWJbzKc+Ud3m0YpwVuVXkkWM27TA
 KCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1RMggdA/j6RqztPA2S7ZAJnGjPpbLIaM9BRUV7kNtpI=;
 fh=M8zexr8yuyxMjVfTMW34rr52/NF1uYWVPVWnu3x84Wk=;
 b=BykXIEYIQ86qhJ0bt02Uk5APrCUTFFO62PJATsoGKVTqzf76Ylt3VxIbE+2bMVTwaB
 ZwIMVEy4/HfV4dpAnYGkXPMD6Ki5qIjoDAzYt/GLVbeuf96r3TWHnvxi0iG+CF3f/Rwk
 PqxjOWK+ooksbYivUIbq409Owq2mhzLBwRD4AxX8qeQBSGg2FAO6zWu1YsMX3wi1gC5O
 jB8VsHEZS4jFl2ABZj5A3VeAT+UaPXiX0FpHKymiHgDCQfx/s2OF6EBUCyodg9XusZXr
 tK07qr2tTX6L9Jb264mdvehS7vRBKr8QXIsM92FvrkkPOLJEqlepkDoitVbUudeK3HRy
 qycw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788261540; x=1788866340;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1RMggdA/j6RqztPA2S7ZAJnGjPpbLIaM9BRUV7kNtpI=;
 b=sd2QOO4gY5zYKx/bm41wSTtl/HUQQSLqyXDsFK58dvjm8CSUjiUZquBvYLZmouoLSd
 xAPx4nExxyQcg2smkfue/DaHWykIREIM9evFfj/YyCmPlnesKGtnoCEmGJYub3rVt+3J
 kJazr+UmGJZ1LpRJTfViN/i6Ez+6/7znsQuYAMvG6oGSzNLzTFLnb/gyu+RFoYSIjEB7
 ZfAZHefO+DYq/DhH6C29HvD3WPNRG2ohJxLY/k75DrDXnTkvdLdJvcNq1+vvGGeHG/wc
 juxQxmIukkt5M0FNH9hPv5WcKKEhIYtKgp9rYvejTRsSvBVjGmns65Lpx1+Ooa45yZaN
 FEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788261540; x=1788866340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1RMggdA/j6RqztPA2S7ZAJnGjPpbLIaM9BRUV7kNtpI=;
 b=SH76iXK8PUKDTu0mdGdMwT9H+Uvk7O9WydqZA9mMRatFs4tBNfBjmxamfK9pdsjkU9
 AwB6oQNu8cNq1G0Q5DMMFigAOf6pWbpKAm0SaPkDhqCTb0GogpkJSDIOoiDraJ3EhSM9
 kvqVl3yE7qdeUiMvIiTsyBOWtYbT5TANNutPu/F8hlZPc8Sxb3N5HXn1x/WtYgNdvUrD
 TQg0rerVvn1OVqKrrQ0lnh3aePAcDK7tPrBls608bLyTH92kOL/BPgSTn0kqBaONKMY7
 7y4XMi2d2N8sOVNlMxfAbMWy0XGlXOHrEv9qGJmA0NeHGvNsCEPEpyLzeUSg36OXbSBC
 lnBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWOswhvocrP0L22bykGpVOz8dS9SzGWJJDVcLmXZ27wYp9vKW047SKMGg4bIxRDWEPjAlkgZQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuXGkliwDDEpoKVIAiy+WQ2OWgVKYKDQJml4aRGwN9lvdlRZvn
 xLXnKEqDw1YAkaymzu8snC3h+vvYjU2v9FMsQFQVEKxOE+eVKFmjdjznk62w5VFpmm2daMfyRcm
 fkb5B4NvyPSZ0erxYvtXetWz31a2/F+qKimZZvth+ag==
X-Gm-Gg: AYBFou0gGJl3878wz/MDOY2nwvl/zuDWQ9aAOYJizBazHhpvx0h50+fmN6D2qBDBLwB
 /x0Ya9A5UFqXA/CoU7Bp522Aw23vme/XzrhNZ7+m0omYznBaaaJjCY3yZ/RNg3Uxiuc+Hvg1Hbi
 Lvgj7e9DcHo+QqauNhwoT/HtWmiqmIuCie/9BICvDcNNDqffQ4J+FYv2iyKpqjMjpcQDprpJCBN
 U1MJEmoPbFzX7UbS3SeAFEuWTXkWnJKi2uqS5j5wHmLmU3/CHizOuGULfhyzMJZPeVmtRCJHyj9
 0bfXisLu1usbTFsTgdg3el6rsbHyzXRGjkhzfBLVtZwCkE5KxWZxIj38RClI+ScUb/AiPJeOxxy
 dE6+z85i4G6yU5hnSgEzqSf6dRbmTocDUxqgItWK02UzpG6amAX6lh3on1RAZDjIwuf1F7n7nJG
 vLv1tDfQlD883WetubyNnJe9MXitTGDe06ErCR6pt9c4A6K2ysB6ZCILcrvTngd2OewVOtcgiPX
 9vOK5LOipOAJlgR3//g99JlyYqpfxmDy1dtMwLpjv/tFU7DrXj46qzwiyI7fU3zBwLq4WgIGsNn
 pDcGHEigvZaJZI3fnplgA2J5vRVhKGoxCHQrixOf0DubDStB9h1+NK7rJIPY9eKLX393QkCX4qo
 K61No53NQmoCe7x2srKi2qEE9YQIC4guu4XXfRKnMrDo=
X-Received: by 2002:a05:690c:e296:20b0:80c:5ce9:8f1a with SMTP id
 00721157ae682-868751b9a61mr26540867b3.34.1788261540034; Tue, 01 Sep 2026
 04:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
 <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
 <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
 <b4f8d148-ae3d-43e9-88b7-1362608985d3@arm.com>
 <CAC_iWj+35n7J2D6EvHr7LZB7L1t2+kNmxY7mBP+w7xgr6=A2jQ@mail.gmail.com>
 <4dadf23a-91fe-423b-9e73-e31d7da5c9e1@arm.com>
In-Reply-To: <4dadf23a-91fe-423b-9e73-e31d7da5c9e1@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Sep 2026 14:18:23 +0300
X-Gm-Features: AcwNN1WgdvHpw38_hd9pVc7aCb86Dq0msZpEVrbEnvYX84GKOtGb06h1D8RsL7A
Message-ID: <CAC_iWjKaPOKB8SvKHQ4ZD0CoSZQ2-=QZTo0fdwc879Xo-d8Emg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

[...]

> >
> >> For the QEMU/RPMB/OP-TEE question: QEMU RPMB would cover the storage
> >> backend, but the FF-A runtime transport also needs the secure world to
> >> expose the MM variable service through an FF-A secure partition. OP-TE=
E
> >> alone would exercise the existing CONFIG_EFI_MM_COMM_TEE transport, no=
t
> >> the FF-A runtime transport, unless OP-TEE/SPMC is hosting an FF-A SP
> >> that implements the same MM variable communication protocol.
> >
> > OP-TEE can also be configured to run in SPMC mode and load SPs. The
> > question is what is the backing storage of your SP
> >
> >>
> >> For Corstone-1000 we are already using the Trusted Services SMM Gatewa=
y
> >> SP. That SP implements the MM variable service and exposes the MM
> >> Communicate endpoint over FF-A direct messages, which is the path used
> >> by this series.
> >>
> >> I agree that QEMU would be better for wider review and CI. I will have
> >> to investigate the QEMU setup using the same SMM Gateway SP along with
> >> OP-TEE/SPMC and RPMB, so we can reproduce the FF-A runtime variable pa=
th
> >> without access to Corstone-1000.
> >
> > I can help, I just need a bit more info on that SP. I'll have a look
> > at the public docs as well
> >
> >>
> >> Do you suggest that I investigate this QEMU setup for the
> >> next revision?
> >
> > I'd like to at least see the gap, but I suspect it's going to be small
> > if it even exists.
> >
>
> Thanks Ilias.
>
> The SP we use on Corstone-1000 is the Trusted Services SMM Gateway SP.
> It is built from the Trusted Services smm-gateway deployment and exposes
> the MM Communicate endpoint over FF-A direct messages. The generated SP
> manifest uses the SMM Gateway UUID.
>
> The main gap I found so far is on the QEMU/TF-A side. Trusted Services
> already provides the SMM Gateway SP, and QEMU has RPMB support, but I
> could not find a QEMU-specific OP-TEE SPMC manifest in TF-A. The FVP
> platform has fvp_spmc_el1_optee_manifest.dts, but there does not appear
> to be an equivalent QEMU manifest in the TF-A tree.
>
> So I think the QEMU work is likely to be:
> - add a QEMU OP-TEE SPMC manifest for TF-A
> - package the SMM Gateway SP with OP-TEE SPMC
> - wire QEMU RPMB into the secure storage backend
>
> Do you suggest that I continue investigating this QEMU setup for the
> next revision?

The QEMU setup will be a convenient way to integrate this into CI, but
I don't mind if we address it later. If you have time to spend on it,
by all means; otherwise, I am ok with the FVP setup

Cheers
/Ilias
>
> Regards
> Harsimran Singh Tungal
>
> >>
> >> The setup I am currently testing is Corstone-1000 FVP with the MM
> >> variable service exposed through FF-A. The FF-A runtime path is tested
> >> in two phases as follows:
> >>
> >> The first phase (setup phase) creates the non-volatile runtime variabl=
e
> >> before reset. On U-Boot prompt:
> >>
> >> corstone1000# setenv efi_selftest 'variables at runtime setup'
> >> corstone1000# bootefi selftest
> >>
> >>
> >> Then reset the Corstone-1000 FVP and run the second phase.
> >> The second phase verifies that the variable is available after reset,
> >> then exercises runtime get/set/append/delete paths.
> >> On U-Boot prompt after reset, execute the following commands:
> >>
> >> corstone1000# setenv efi_selftest 'variables at runtime verify'
> >> corstone1000# bootefi selftest
> >>
> >> The testing steps are documented in the bootefi documentation commit:
> >> doc: bootefi: note two-phase runtime variables selftest
> >>
> >> For v5, I can add these tested steps to the cover letter.
> >
> > There's no need for a v5 yet, I'll take some time and reprod with the
> > FVP. Just keep in mind I'll be off for the next ~20 days so this is
> > going to take a while, apologies.
> >
> > Cheers
> > /Ilias
> >>
> >> Thanks
> >> Harsimran Singh Tungal
> >>
> >>>>> latest version of QEMU do support emulating an RPMB device. Would t=
he
> >>>>> changes above work with with an SP, QEMU RPMB and OP-TEE?
> >>>>>
> >>>>> Thanks
> >>>>> /Ilias
> >>>>>
> >>>>> On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
> >>>>> <harsimransingh.tungal@arm.com> wrote:
> >>>>>>
> >>>>>> Hi all,
> >>>>>>
> >>>>>> This series adds FF-A runtime transport support so EFI variable ru=
ntime
> >>>>>> services can communicate with the secure world after ExitBootServi=
ces().
> >>>>>> It also extends tests, documentation, and Corstone-1000 configurat=
ion to
> >>>>>> validate the runtime path and keep boot-time behavior aligned with=
 the
> >>>>>> runtime flow.
> >>>>>>
> >>>>>> Changes in this series:
> >>>>>> - Add EFI runtime-safe memset helper and FF-A runtime transport su=
pport.
> >>>>>> - Add runtime-safe FF-A direct-message handling and ExitBootServic=
es setup.
> >>>>>> - Implement FF-A runtime communication in the EFI variable TEE bac=
kend.
> >>>>>> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariable=
Name(),
> >>>>>>    and QueryVariableInfo() over the FF-A transport.
> >>>>>> - Add sandbox FF-A runtime transport tests.
> >>>>>> - Extend EFI selftests for runtime variables and enable bootefi se=
lftest
> >>>>>>    on Corstone-1000.
> >>>>>> - Document the FF-A runtime transport and runtime-variable selftes=
t flow.
> >>>>>>
> >>>>>> Changes in v4:
> >>>>>>
> >>>>>> Address Ilias Apalodimas's review comments:
> >>>>>> - Split FF-A bus runtime support into smaller patches covering run=
time
> >>>>>>    private data, SMC invocation, direct-message helpers, boot-time=
 reuse,
> >>>>>>    and ExitBootServices setup.
> >>>>>> - Split the ARMv8 cache range-maintenance runtime annotations into=
 a
> >>>>>>    separate patch.
> >>>>>> - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
> >>>>>>    GetNextVariableName(), and QueryVariableInfo() support into sep=
arate
> >>>>>>    patches.
> >>>>>> - Replace MM SP status macros with an enum.
> >>>>>> - Keep OP-TEE as the runtime fallback when FF-A runtime mode is no=
t
> >>>>>>    enabled.
> >>>>>>
> >>>>>> Other changes:
> >>>>>> - Rebased the series onto current U-Boot master.
> >>>>>>
> >>>>>> Changes in v3:
> >>>>>>
> >>>>>> Address Simon Glass's review comments:
> >>>>>> - Move FF-A ExitBootServices event registration to the end of prob=
e and
> >>>>>>    clean up RX/TX buffer handling on failure.
> >>>>>> - Rename FF-A runtime-context helpers to the ffa_runtime_context_*=
 form.
> >>>>>> - Rework FF-A/MM cache maintenance to cover only rounded request a=
nd
> >>>>>>    response ranges.
> >>>>>> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> >>>>>> - Document FF-A shared-buffer ownership and alignment assumptions.
> >>>>>> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableNam=
e
> >>>>>>    entry points.
> >>>>>> - Tighten sandbox FF-A runtime tests and reset runtime state betwe=
en
> >>>>>>    test cases.
> >>>>>> - Update FF-A and bootefi documentation for the runtime transport =
and
> >>>>>>    split runtime-variable selftests.
> >>>>>> - Rework commit messages to drop redundant information.
> >>>>>>
> >>>>>> Address Ilias Apalodimas's review comments:
> >>>>>> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchs=
et.
> >>>>>> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> >>>>>> - Remove log_*() calls from __efi_runtime FF-A/MM communication pa=
ths.
> >>>>>>
> >>>>>> Other:
> >>>>>> - Fix FF-A memory-share sender_id to use the runtime private endpo=
int
> >>>>>>    ID after rebasing.
> >>>>>> - Fix the expected QueryVariableInfo() return status for the
> >>>>>>    TEE-backed runtime selftest path.
> >>>>>>
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>>
> >>>>>> Address Simon Glass's review comments:
> >>>>>> - Fix efi_memset_runtime() style, declaration, and byte cast
> >>>>>> - Tighten the FF-A runtime context failure path, clean up arm-ffa-=
runtime.c
> >>>>>>    style issues, and move ExitBootServices event registration earl=
ier in probe
> >>>>>> - Add shared-buffer bounds/alignment checks, and tightening commen=
ts/kernel-doc
> >>>>>> - Document the FF-A shared buffer cacheline-alignment requirement =
and add
> >>>>>>    BUILD_BUG_ON() checks for the address
> >>>>>> - Cache attributes before the shared buffer is reused, moving the =
read-only
> >>>>>>    check earlier, and split the u16_strsize() related change in se=
parate patch
> >>>>>> - Reword commit messages for the runtime helper relocation
> >>>>>> - Rework the non-volatile runtime variable selftest into setup/ver=
ify phases
> >>>>>> - Extend the sandbox FF-A runtime tests with no-context coverage,
> >>>>>>    runtime-context reset, and separate errno-mapping coverage
> >>>>>> - Refresh the FF-A runtime transport and bootefi documentation
> >>>>>> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime =
and
> >>>>>>    boottime capabilities in v2
> >>>>>> - Squash patch 8 and patch 9 from v1
> >>>>>>
> >>>>>> Address Ilias Apalodimas's review comments:
> >>>>>> - Reuse common MM SP error mapping for boot and runtime paths
> >>>>>> - Rename runtime-phase tracking to reflect the ExitBootServices tr=
ansition
> >>>>>> - Collapse duplicated boot-time and runtime MM communication helpe=
rs into common
> >>>>>>    implementations
> >>>>>> - Keep the arm64 cache-maintenance path runtime-safe
> >>>>>> - Move FF-A shared-buffer runtime memory-map registration to the e=
nd of
> >>>>>>    variable-service initialization
> >>>>>>
> >>>>>> Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-=
1-harsimransingh.tungal@arm.com/
> >>>>>> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-=
1-harsimransingh.tungal@arm.com/
> >>>>>> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1=
-harsimransingh.tungal@arm.com/
> >>>>>>
> >>>>>> Harsimran Singh Tungal (22):
> >>>>>>    efi_loader: add runtime memset helper
> >>>>>>    arm-ffa: store boot-discovered runtime data separately
> >>>>>>    arm-ffa: add runtime-safe FF-A SMC wrapper
> >>>>>>    arm-ffa: add runtime direct-message support
> >>>>>>    arm-ffa: reuse direct-message helper at boot time
> >>>>>>    arm-ffa: enable runtime context at ExitBootServices
> >>>>>>    arm: cache: keep range maintenance available at EFI runtime
> >>>>>>    efi_loader: add MM SP status mapping for FF-A variables
> >>>>>>    efi_loader: make MM transport selection runtime-safe
> >>>>>>    efi_loader: make FF-A MM SP notification runtime-safe
> >>>>>>    efi_loader: make FF-A MM communication runtime-safe
> >>>>>>    efi_loader: reserve FF-A shared buffer for runtime variables
> >>>>>>    efi_loader: enable TEE runtime SetVariable() over FF-A
> >>>>>>    efi_loader: enable TEE runtime GetVariable() over FF-A
> >>>>>>    efi_loader: enable TEE runtime GetNextVariableName() over FF-A
> >>>>>>    efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
> >>>>>>    charset: mark u16_strsize() as __efi_runtime
> >>>>>>    corstone1000: enable bootefi selftest
> >>>>>>    efi: selftest: add runtime variable tests with non-volatile sto=
rage
> >>>>>>    test: dm: add sandbox FF-A runtime transport tests
> >>>>>>    doc: arm64: document FF-A runtime path for EFI variables
> >>>>>>    doc: bootefi: note two-phase runtime variables selftest
> >>>>>>
> >>>>>>   arch/arm/cpu/armv8/cache.S                    |   8 +
> >>>>>>   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
> >>>>>>   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> >>>>>>   configs/corstone1000_defconfig                |   3 +
> >>>>>>   doc/arch/arm64.ffa.rst                        |  88 ++-
> >>>>>>   doc/usage/cmd/armffa.rst                      |  11 +
> >>>>>>   doc/usage/cmd/bootefi.rst                     |  31 +
> >>>>>>   drivers/firmware/arm-ffa/Kconfig              |  11 +
> >>>>>>   drivers/firmware/arm-ffa/Makefile             |   4 +-
> >>>>>>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
> >>>>>>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
> >>>>>>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> >>>>>>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
> >>>>>>   include/arm_ffa.h                             |  16 +-
> >>>>>>   include/arm_ffa_priv.h                        |  22 +-
> >>>>>>   include/arm_ffa_runtime.h                     | 191 +++++
> >>>>>>   include/efi_loader.h                          |   3 +
> >>>>>>   lib/charset.c                                 |   2 +-
> >>>>>>   lib/efi_loader/Kconfig                        |   4 +
> >>>>>>   lib/efi_loader/efi_runtime.c                  |  20 +
> >>>>>>   lib/efi_loader/efi_variable_tee.c             | 739 ++++++++++++=
+++---
> >>>>>>   .../efi_selftest_variables_runtime.c          | 715 +++++++++++-=
-----
> >>>>>>   test/dm/Makefile                              |   3 +-
> >>>>>>   test/dm/ffa.c                                 |   6 +-
> >>>>>>   test/dm/ffa_runtime.c                         | 123 +++
> >>>>>>   25 files changed, 2004 insertions(+), 498 deletions(-)
> >>>>>>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> >>>>>>   create mode 100644 include/arm_ffa_runtime.h
> >>>>>>   create mode 100644 test/dm/ffa_runtime.c
> >>>>>>
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
> >>
> >> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
