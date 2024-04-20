Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B5C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 07:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355DD8811C;
	Sat, 20 Apr 2024 09:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dembg5R5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BD088125; Sat, 20 Apr 2024 09:20:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF4E88113
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713597637; x=1714202437; i=xypron.glpk@gmx.de;
 bh=+TRrqiNvG/HPUnRx65GhosPNPdSTFabLjJtpZaR+q20=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dembg5R50Lzg6Y5nTsnUEfPSgn6ctiSgwCgVDdVld9SrCJqyVLPckOz5gPaGKhXM
 HeKZ59/p/FE1DIcic9i0wMk+5DCiRC7fdCGIRASsAortbD5FICqUiIpd5+dLtWVIV
 PkXSdmOx1ZRbemVBs03IHblNnpCoKztjoTlgNQNVFnxB8+otHuRGqsJq3M+gc39CQ
 IFOxdVL+1fBFFVZYDAGiqO43stsaYk3fSt7xw6EywBhPs0pC0Ko63saL+Va/pWXRa
 GqSXX06OAB+tBq3rakkAuSBPrn/YuI+tUiuQg+YPKvAXyru1WDZGH/VWYM9gFzE5f
 bcqu3y+bwHwRQVjtvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1rohN92fMw-009T9u; Sat, 20
 Apr 2024 09:20:37 +0200
Message-ID: <3fd5c650-293b-482a-8f23-7ecdb28bc4c3@gmx.de>
Date: Sat, 20 Apr 2024 09:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4]
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 kettenis@openbsd.org
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wv4fXlyUbSguphUqNU2I9idLTDb5NsjZX1KXJth4qNwCcjECvc8
 qdG+oRbtu5HwJgMasJCtLhAMvSWprIbP6H6jPoAomSTMZjhgpKmBYrM0fYzvDBZwqF40DOb
 STPWp5DfH56t0VLJnNwAkr00qXwAYa4nTtmIGU4UwO1+7i8HR6pT4C6QFe3CE49ZqroM/Vy
 a72UUa+IacLba0YoVGg3g==
UI-OutboundReport: notjunk:1;M01:P0:QsxoI9bdNsM=;4LSV01PJnH20sTl10QqHt0UyRjA
 BHYM0c9urhKjCaO01Xv3YJexKbsvdwj5cPHNgll6X+5vREhkPTcWp81x8NFzOKOLuU8+nKJI3
 CDJx5FBTeanABzDXM1MwGwIlQjrx5aWBTrhHv8DblKscJ/tcgqnTlCrhqBsjq5qXEpoHK+NpX
 rpJYv1lG7Cpn6rIzqSvrgiEW9cNz+Y5shY42eDGRfrLrCb5TzdyI8QgW1VupDa6A0T56ew5dw
 c93NRzuBtA4xJ/zb197yn3aI2pZgbHdzWKcLQ4O4jKQx+I+heX8ZdxqPLd9rJe03+n6VDy5Ai
 I5qK0QNz4PIp1QWZOdHoRY03E+cLFa1VYCR0p7sOekUUawn2/GHtv0Np744mG2Jv0REQ0bxnO
 ThxhUJKeoFTXF7fDPUbmxQ7NEna8K5qfNoUYu6fE+CQ6RTpYhL+aZ6PxJBoy6SRqjwwTHClMT
 j7K5mcApFEUrqu/O8t0k4uygspgS+yeTghuHAvQ/5o19HoV/8uzXA83D/URGn7euRc/O5LkKP
 eX7H99bgWfO9fFcPDvd+qpjedGPhF5RT1R4wzwzop6qWUcIuFjvv5Uoafnnzl0sygKj8zRTBq
 HWFcFWLCOYYJnK7a9A1eOCDCO+UkHgjYbNgsJ/WrQ8ZiPKsFDRdpMVRNiiPmMs0rvtA9D8o4n
 t9CevTlCCSTRd4YPVf3kNgGLre5yiQNKWS4JSJXqFSg87ufp1h43nZe6lIVWQF6gVVK6Utpq6
 Df9bI7EzMYt/nGWVU1ygdSELVb4lfoFnkrNofQrJog3AN/pZTBFsFTMuCL4H2NlL9BJbdWzW1
 I0P6evO6dYEvd2pwOxglkQYcKYIqV75X4AMJpU4UHdnEA=
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

On 4/18/24 14:54, Ilias Apalodimas wrote:
> Hi!
> This is v3 of SetVariable at runtime [0]
>
> Nothing changed drastically from v2.
> A few more test cases have been added, comments/suggestions have been
> addressed and a bug where deleting a variable by setting 'attributes' to
> 0 has been fixed.
>
> Changes since v2:
> - Add more selftests checking for variable deletion as well as the
>    VarToFile header format
> - Use unaligned sized variables on tests
> - Add a new function to get the variable entry length instead of
>    repurposing efi_var_mem_compare()
> - Converted VarToFile to RO
> - Added a few comments requested by Heinrich
> - Fixed a bug where SetVariable with attributes set to 0 did not delete
>    the variable but returned EFI_INVALID_PARAMETER instead
> - Run FWTS 'uefitests' and attach the log in patch #1
> - Added r-b tags from Heinrich
>
> Changes since v1:
> - Instead of Creating VarToFile at SetVariable, create it on GetVariable=
.
>    This allows us to get rid of the preallocated RT buffer, since the
>    address is user provided
> - convert Set/GetVariableRT -> Set/GetVariable at runtime
> - return EFI_INVALID_PARAM is NV is not set at runtime
> - Heinrich sent me the efi_var_collect_mem() variant
>
> Changes since the RFC:
> - Return EFI_INVALID_PARAM if attributes are not volatile
> - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
> - Add 2 EFI variables and allow userspace to write the file
> - Add selftests
>
> I also have a patch enable QueryVariableInfo [1], but I don't want to
> introduce new patches now. This also needs a few more testcases of its
> own so I'll send it once we finalize this one.
>
> [0] https://lore.kernel.org/u-boot/20240417101928.119115-1-ilias.apalodi=
mas@linaro.org/T/
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/ce35270=
aaeb93686d7e013f3b028808e8af88cc0
>
> Regards
> /Ilias
>
> Ilias Apalodimas (4):
>    efi_loader: conditionally enable SetvariableRT
>    efi_loader: Add OS notifications for SetVariable at runtime
>    efi_loader: add an EFI variable with the file contents
>    efi_selftest: add tests for setvariableRT

I am missing a defconfig change which is needed to run the unit test in
Gitlab CI. I would prefer testing this on the sandbox.

Best regards

Heinrich

>
>   include/efi_loader.h                          |   4 +
>   include/efi_variable.h                        |  16 +-
>   lib/charset.c                                 |   2 +-
>   lib/efi_loader/Kconfig                        |  16 ++
>   lib/efi_loader/efi_runtime.c                  |  42 ++++
>   lib/efi_loader/efi_var_common.c               |   6 +-
>   lib/efi_loader/efi_var_mem.c                  | 151 ++++++++-----
>   lib/efi_loader/efi_variable.c                 | 122 ++++++++--
>   lib/efi_loader/efi_variable_tee.c             |   5 -
>   .../efi_selftest_variables_runtime.c          | 211 +++++++++++++++++-
>   10 files changed, 495 insertions(+), 80 deletions(-)
>
> --
> 2.40.1
>

