Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD2C79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7725B80965;
	Tue,  8 Sep 2026 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nstvOpdrO1Z; Tue,  8 Sep 2026 09:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 770CE80956
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788860262;
	b=TlSG1v8TMD2OZO7oOfqGsvGbDbQfEplRpqGHTsmSTCAe6JVxXDfIktzSfnimeEO0uTiB
	 ZRYxNaYDdHdommvcjPLFBWLP0Ll8Lk9V3s7cZZ/bUeZt7Fi3mhq4QVSzQ+5USX/L8y7Le
	 +BYWwlRAq9nQTRn+dN3lOC81eiGr8y1naMSG1oYo0ttCiNAxTEWBRC8qHWtq79AZ3L3Df
	 y3RcBZruZ59B6BFJOp7DOJtfuOeEHtUDKccPZGSR2mCYi+1Szt9DmCTJCOsfOOa81+m+N
	 TicFTpW2IZ/jnqz56pChLdTCcWOliSEvZVmsWoMTHLP0HJG8pW7g/zO+TTDmvW0KpkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788860262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
	b=AO5y908op7Vbc6De3gbt1KlH5Ra1txJ5rKDcEG1FKNJ5gdXvl/YNzxnkPjcF2qr9Ng6l
	 Y5mDnhmp5+iC/j2LsjjMgWIBgZ409MmHPzfU+GttRCJhqNA4dr4M6EAQzQ8Y/jz71l7Ew
	 XfSjn4J7BNcw9ddn79QbEUurYbSe4fyzN98E7Opl+WXCxloqIIjZRMq8VWGHHTUPBKzzd
	 LWNlOFmgADWhK12mP3F0p29zYqxSuo+u5nhvjpYzeNZwPJ94Acr0heWhgirDhEfE69VE9
	 0XgxTT4/tT8DxGdfUeazJWJ9pw5PBSuOxS1084OP4xP6oYCtipABvjJvj2Ktc/LSgrA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788860262;
	bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YkiGsX1cH7l5ASC/8R05gHs6JGCnm+r1zKdV+1SsSzCjxxr2zxLfc+hcGISD8sdC8
	 BIbKBIc3WXOCrs1wT0WBdCxjgHM/+GjnI16l8uJUR/3kOgTzlXrulGtGCCw/qF5adB
	 GNavCJbntRNWHFPRXUKEbcRJ0Na672mQLuu8SW6TspNd2bmYt8dg6s2SQKy30vnxG8
	 I2DVEal3ynQYxymQf+YqqXhN058+lCjUxh5HkVSnU2UpKott2OZIi18HiZUHQ+6THh
	 mrkrKAh3oUz9T55zsWBMmwj114LopASoWPluQIRQushWevekEZERZ8KDranYSKCrjO
	 CObtUQoGHJOrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 770CE80956;
	Tue,  8 Sep 2026 09:37:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EDE972C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07C674046D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LKd2OEbekxj for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B157E40435
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788860259;
 b=VxgFqgjaFsRQ50va8lezDyvwcN6XyZ4wtDhzYNIq8VWbVRJw8/5wQIFYx2FP20PRUkCN
 LjBmYT/7e19Lsz0URT12EztqIKou+PqC1kMlPPUzOjiRDxaUZI7BVwmYkfrO0KIw1Blml
 iCjIa2jE4IWxFlUIyHPGAHoKEO28LV0KE9FlDE2ldSduCYxmZOBPvPHjE+QxkQDDEj++e
 2W8cKLVZqU2W/LVqW7abBl2+re/OkWTxJjixod4dMBIGwXQuU8SCbdQ1DAyLStHE7UjMA
 eyIMXDPkWK08fS3ciRxGvcGfjkFgBhyaGq+4n5Ayu2FKAl+OH5eM+AW9kZcHNgKRqsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788860259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
 b=HT3Vq5BNQcWTpuTQjaRPr7vw0ywl1Z6oonDYNO8HlBXXodQDkqAZgaNNW8jNnMZ8tVvq
 +CNoisfjoRY3Wm2f/zKeVvQ8yUCSEtPcAoDlLy8Sopa7o3DZZ+PtaWBNMlJPW81OWlPge
 arasnQZPc7ww25D7LHLhg7QfGRXalNxomue1DY0aqxi3kBvADMOMJfqyNfqyZvw1phqKu
 Bm4woGctFnLg9/4OTun8NvYuxdT9UAIZPxY4c442aigQ5HaaaRYP5p9kahZZF2LeO+tMK
 BXHPmkTouEpzL6cal80THNmYwQ7hrpjtR3DK1HR515JEd35XlQrdjLEZWF/aLxlCcmw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HGy5Z6JM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HGy5Z6JM
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B157E40435
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:37:37 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-867a943b149so65485097b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 02:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788860256; cv=none;
 d=google.com; s=arc-20260327;
 b=A5VPUHc1m78O3P8O0BPYfiQw2R+aaJMCaiHCxlPQMTO2Lqx6KbVAUxmwNowYOo/Ft2
 e7Hin5IZRd9ZQfDNVB73v4TB/QDcoW05b6jwFhrSyUu9dTGrptjxZA6B1n2n9X3C8HNj
 6U3ReQ2iKPS2hdu0thFwcBPL97NfqSH1B+1+v6KSL6H7eeLAwXAPjP+Q5nVMNOdibAN+
 q61zWHWNPTmrCXg+nCoVHDkzyKOXJFYCf6doGBxQf/uMUFiKp7VKUNd9FqxoNKGaPeM0
 X8itPKxljwc2DuC6sToMxa2UXQYaZ/DotHWEwHyfJSTrOgIx3acx1C0tsqZDWTH5uPEf
 lNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=ZJl06IKfMhXCAvhClH6pkDEclkex86+Wcym4kJI5n02QJ3aFuGfnHOIP9E5ZLPacHo
 3GfprpIbnxc4ODoszMiByCA+xQ9DvFbXWuK6GOXSVhA58ZfmF0WtOMK6LVF8iWvv/PKs
 lGZaguZASy4xzfTFP3pr+VRRKya42gDuW4oSHELwEV+FR+gfXeRBh8lNtDJfA4IkUwr6
 VKEtHOi/v7MZa2cxYRgp3QgUBZNABRykWObUZZr7ZbXkR6mtZ93FJ8zSyXSBTczds78R
 AHEytEyHI9r8zUBiV9cX8XCEExGxDvij7YE69GfnjJBC4EcCEbcvPP9SOUSKTumxOiaU
 DigQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788860256; x=1789465056;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
 b=HGy5Z6JM6tP61TXdnx7Cyxwj9rXwvUDXgZgR95BjQTKe7TXp5n3BExFafLrW+2Or8J
 7WT1f74Erdephrtx54DV24eWZhrpiOWuUYt/MaI94mHUJH5taPsQrm6PqJd1IE5hW1Kj
 OrPUs+4/K2p111kMovKKWsvcaRSkcVqolskljugrXM/Wr0+CkblavK91QNNWVdXh0dox
 7f8jnkxQMGLNYqFopuwLACy5/UJo6XTZeKDmCFxnr5RgF+gZT5ZJdieCgmW62wDhWPM4
 T3DqcCf61qK+pjivZM2/TPBJsIduFRBand8ARciCgipCLOTgSNWiovK8cSCBVM7jg6gm
 KAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788860256; x=1789465056;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mpPPMY16WaNWz3RMCT2g81iJbGwP7ejVezRlvI4vXRA=;
 b=gMuaRtjnHeC7a3kBVpRdV/VzvmRTPHVoqgsdLpCh2EKpVEYqW27tflX4gsf/u/0WqT
 7hze9A0YyBkHz8octBJ+VarpTSWOlmd5p1wDidORSHWAC9Lj3hUKUorIQLzgSkQSY/Sr
 YZNKXl4CR3+Dycv+gxDXflcdbxKs0OIcqX0Mc4GN6DZcmGBFtHAawlLn4zLuuKOXdiPU
 izlPKe9o5dUgq0u/NxSl0FpzmJoR8IRFZ3fw48bWMZaHp4zJPFZ43ehzK4hw+YoPCKC3
 F4CCm+uWSqAU4bQEh0FLFZbjK8d7TGKz2i0TS1a6sE1iu0Y3QSkJ+cULfr6wdgDJodv3
 k9hA==
X-Gm-Message-State: AFuF++k343c/IFPNI49EKeNMtKHidt2KSOGNlaR88/UDYviSf2KF47P9
 bOZdmeiwNCwpj5dFykaV6NKgp+D0DpXi5N/oIs3kx5lRGfVLJmL8dVYqsqn3cWyhMxn+u5FuSrg
 5L42WMXPl1TJqn7FvfdipV9LpmGfsejaLdqnDPwgYdEb1lOELrnJPwSnIqA==
X-Gm-Gg: AYBFou3NBip1Ft+tSC0JkNnyI6WOrLPR6FxC8hr+PKQdTX7GzuLILIIWAeNcqPOguBE
 DYtyoeiecfPI1QuIbFS3knRJAaVB9yeNwt9GhYiyxCffNLGUCP8SgcCXr/XvdctDeKk5DitHoeq
 F4cUJrCwFbeKa7AST74FBZIA7nFVcLZyLPtCIaeiHmAkUNoYDJFwHBfjMOI2r8Si4SjWhAtf7PY
 09ki3kulIREUGE64C6sxrSsDHdk+gYBw72TLFYAbGMYyUhVg/qgMnyUCvdJr8s0Qjmb8QjvD3kg
 EhRfS67XToZS2l6Pu60Upb9s/vnqfzQUMSjWtFWPxMKFU14jcFOhVHUq/3fSP59JCZfLdYRn+hV
 je+YGfrBqW9KlDAqTdiaxjtOK8SGUua80cC4iXO5lKw8Sn2KTIvfE3WqwQ6Dwh60jqs4VziUtYO
 7AGYlTjjoIvvN5JiyqFK2RIBGoO2uCgI5VWLiwws7ERqmObGlpaJO5cJJA9AfQXoDm+OzjdhwkL
 9lkHgU6QdpICrO1fJ4MpmbBLlWex9bNdILGCt22Yprzw2nNCCSTydUeVvd3NkjM0E1Qwf/jhEWz
 1kJtxeWjt35210rxopmNnP4Qw0fpCygQQab2qcSS6ed2qc8ECVefg6ojm6LEzGZ2FhcD88ka10b
 GE5Y+c28U8bkgtykNEBu8PFTlLFaOIZdBQrTiHFa0LD4=
X-Received: by 2002:a05:690c:387:b0:873:5bd1:98ba with SMTP id
 00721157ae682-8735bd1a1e4mr76759427b3.44.1788860256464; Tue, 08 Sep 2026
 02:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787514446.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 12:36:59 +0300
X-Gm-Features: AcwNN1WePhxVCkrLc9YOEUlSRgLCU-5HnSNj5sqpXwM_FCEgzovvcg-X4LLaTF0
Message-ID: <CAC_iWjK+o0Udb6mSkfCPr-CAF+A+A-gDMC+BZ3xr4U_FMqVftQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] optee: Add support for enumerating RPMB-dependent
 services
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Content-Type: multipart/alternative; boundary="00000000000023c4b2065af57c43"
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

--00000000000023c4b2065af57c43
Content-Type: text/plain; charset="UTF-8"

Hi Jan

The CI [0] complains on this. My guess is it's due to the dev_dbg changes,
but I haven't found time to look into it.

[0]
https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1208

Cheers
/Ilias

On Sun, 23 Aug 2026 at 22:47, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> This allows to find firmware TPM again with recent OP-TEE versions,
> possibly also other services. The StMM service was not affected because
> it is directly invoked by efi_variable_tee when needed, and that is late
> enough so that all dependencies are available by then.
>
> See patches for further details.
>
> Changes in v2:
>  - fix build breakages with disabled CONFIGs
>  - structure code differently between optee core and rpmb
>  - debug() -> dev_dbg()
>
> Jan
>
> Jan Kiszka (5):
>   tee: optee: Factor out service enumeration and binding functions
>   tee: optee: Add support for enumerating services that only need RPMB
>   tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
>   mmc: Call back to optee after a successful mmc_init
>   mmc: Make "MMC Device not found" a debug output
>
>  drivers/mmc/mmc-uclass.c          |  2 +-
>  drivers/mmc/mmc.c                 |  4 +++
>  drivers/mmc/mmc_legacy.c          |  2 +-
>  drivers/tee/optee/core.c          | 58 +++++++++++++++----------------
>  drivers/tee/optee/optee_private.h | 24 +++++++++++++
>  drivers/tee/optee/rpmb.c          | 19 ++++++++++
>  include/tee/optee.h               |  6 ++++
>  7 files changed, 83 insertions(+), 32 deletions(-)
>
> --
> 2.47.3
>
>

--00000000000023c4b2065af57c43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,sa=
ns-serif">Hi Jan</div><div class=3D"gmail_default" style=3D"font-family:ari=
al,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:=
arial,sans-serif">The CI [0] complains on this. My guess is it&#39;s due to=
 the dev_dbg changes, but I haven&#39;t found time to look into it.=C2=A0</=
div><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif"><br=
></div><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif">=
[0] <a href=3D"https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/=
-/pipelines/1208">https://git.u-boot-project.org/u-boot/custodians/u-boot-t=
pm/-/pipelines/1208</a></div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:arial,sans-serif">Cheers</div><div class=3D"gmail_default" style=3D"=
font-family:arial,sans-serif">/Ilias</div></div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 23 =
Aug 2026 at 22:47, Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com"=
>jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">This allows to find firmware TPM again with recent O=
P-TEE versions,<br>
possibly also other services. The StMM service was not affected because<br>
it is directly invoked by efi_variable_tee when needed, and that is late<br=
>
enough so that all dependencies are available by then.<br>
<br>
See patches for further details.<br>
<br>
Changes in v2:<br>
=C2=A0- fix build breakages with disabled CONFIGs<br>
=C2=A0- structure code differently between optee core and rpmb<br>
=C2=A0- debug() -&gt; dev_dbg()<br>
<br>
Jan<br>
<br>
Jan Kiszka (5):<br>
=C2=A0 tee: optee: Factor out service enumeration and binding functions<br>
=C2=A0 tee: optee: Add support for enumerating services that only need RPMB=
<br>
=C2=A0 tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE<br>
=C2=A0 mmc: Call back to optee after a successful mmc_init<br>
=C2=A0 mmc: Make &quot;MMC Device not found&quot; a debug output<br>
<br>
=C2=A0drivers/mmc/mmc-uclass.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 =
+-<br>
=C2=A0drivers/mmc/mmc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 +++<br>
=C2=A0drivers/mmc/mmc_legacy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 =
+-<br>
=C2=A0drivers/tee/optee/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 58 +++++=
++++++++++----------------<br>
=C2=A0drivers/tee/optee/optee_private.h | 24 +++++++++++++<br>
=C2=A0drivers/tee/optee/rpmb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19 +++++=
+++++<br>
=C2=A0include/tee/optee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 ++++<br>
=C2=A07 files changed, 83 insertions(+), 32 deletions(-)<br>
<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div>

--00000000000023c4b2065af57c43--
