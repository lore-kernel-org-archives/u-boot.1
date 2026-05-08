Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C9CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F2184B56;
	Fri,  8 May 2026 13:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="j+1xp2NV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 607AC84C72; Fri,  8 May 2026 13:01:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404C584AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67e43a8996fso1756652a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 04:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778238082; cv=none;
 d=google.com; s=arc-20240605;
 b=OKaHRSZ2kr8uOVEPIUjWuyHqs0hoABCopiHTsRbablMAoCbXMgs0cCLql7HpbSfkuy
 1R98GbEiEY289hJvfMbzrpgKNtYPVMEa4VYqfR6E78O12jOFC34kT7CPwkiLPUuQHVrq
 BC8rkvx/tiqKy6JBdOK/Due+9ZZmmyiISWeJtwmVRl51l2CkBgDlGst/lmmulQbG9w+x
 wKycBJ87Uy4VRUNJBmYnD4sGBLFLg2a+vPMsthTAYmMWLbByrtYomBCVM+b2UwxVuOYY
 lb5dclfuTFJBbsMCteVYJKW0zhM9NLjZCSHBWS/PDDLfkOedZnFfOpRJb0Bgv5n+nkCA
 R26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PomJqz9yPBs4I8c5nmZVynZxnJhBdf05otHtSIi5cJk=;
 fh=GHvsfaNFfJc6freB36TFZe9eRjJCdWwTuX66cUaCh64=;
 b=h2Fl2IxANzZgDeQjKOp62imMqiwA6g6Ihh47I6QvGizSImZDekG33iGw8wj8TTDjk5
 93A3LzzybOpIQCB4NfUIRTUtw4a1Mk1wJtDWKtfaXTfPIUfweMkbFfwNVQzokqVPCS0W
 JfWJmZUEziKx5iwHpYlSg2H5Bcwh+4Ig9FCLJsFygM0k0mOU1JuwDYvmdPWusITy2YRl
 nU9Ih8GakxaD5or6+umXaHejrAihG2jNuNT608GytCupJcLYW7hZcPtCaCTEB7kqcYpv
 Wo20bGDg3KM91qnbP4CUkTotN0FuZ+wA9mn2cXRXfhY6Mgc3TvqD6CvwMxkgGgqoI1MA
 iyHw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778238082; x=1778842882; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PomJqz9yPBs4I8c5nmZVynZxnJhBdf05otHtSIi5cJk=;
 b=j+1xp2NVcP85V+BuVDy0Et2SzrjJSO6PM1GzYwBlMIMCFkGFe+RPgiSfrZ84pOWUrR
 jurltu2wCHQ+nHZfYFL/bOfO9bXtT9dDfqBzcgDeqCnbGN4NdJvJI7tLRXMcFibFZBc2
 CsKvk2ftbPH/UL6OVTP5iZU9dUEM1XZuKSnzXk251DfBxij53sAawwNA2sTxshidU//U
 ScO6bKzEYr7ZEhNaawTULoN9Env5LSFgNRzU0CCHiRRhpi7lRZBEjo1La09VCU7gDEWc
 3lsBtTxV75lnVVw8oupjpxJSTigzT4MYydoHYpVICqMhXyE78bAGQzOoV8iklC9HMBcR
 aTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778238082; x=1778842882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PomJqz9yPBs4I8c5nmZVynZxnJhBdf05otHtSIi5cJk=;
 b=c5/nr+E1fvinqekzw00gjvMBKSlm2WRom/gdBOX94J+p7m26NYCDN4SOWCKik13Det
 4yRvJyTOJqT9fdDKedm0+uo7472zj0nYkS3k3uyN1H/oD1Bj8fUVw5/Gmwz5u5W1DE4a
 KDL9Eh7f+dURSOpzCFn+stUEOcomlRns3GG37sT6GPWNhdzmgGrIkjpGOe8cD0SAA9k0
 Ch7PObIFWoqoIGnnd5PQgduPum3erVtz0YsXnmFFUtcaZ1W0flUH3SYszemUzi4YQlkg
 YQecuwZLyf5SpQMwLvbG+ZX6SQ+43gn9MWHXIOAetMvWLmCEhCm4mG3jM7dhrkwoSi0d
 A+JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kw6qt6xHa2ECBjn3Ub7bCqBECuRrYrllEcS86EJExh9ukSnArKCpQC1ZurdhOKseqW9nK9A8=@lists.denx.de
X-Gm-Message-State: AOJu0YzwMlCgSbNon0X99iUtJaIwMv/7SWuL8klHKPJgUWUB9t/n+1kZ
 qJ4lX40na6VC5uC8N5BcyJMZPaYWloJGISyoAQA3Q1if4iStEy8kGStBTEiTyzp0YSCYASNwbRs
 B9PYMM4/rZkf9lBrl2vmSBQ60lFoMQmPuLM9ps5DIWA==
X-Gm-Gg: Acq92OFG1FHQyZfePo3GuBA5KRoWD5m7xl+dmWkgzKDak2Q8Vtui/XaRisIwMu/MEb7
 xWnI06cjfV4AQI+oJOd44KBDs7BaHUv3XzJADJZDsxQcEpmLDdpDAMI7Axl0d8JyPr6lRHS9pIS
 ADnU/70km6O14xJnrW97YjKkic9eP3z73+Wt7mDZtJ8N3Vu5EfwaCI05dBUEZR5A0m/iQvJ1Gxf
 S64dxzI3TBZgvSya7+r8eUkpNaOjPu5tPSaT+VIU+z4tYcatXG/b0RerZna7Zy4VJAlmHgF8Nnl
 yD+B2N3viUqWKjj9SgjWjsDiHehhYB+hL6oILlU9uwu23w5ojOQ=
X-Received: by 2002:a17:907:720f:b0:bc8:b8cd:8a22 with SMTP id
 a640c23a62f3a-bc8b90a98b4mr434837366b.23.1778238079952; Fri, 08 May 2026
 04:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 8 May 2026 15:01:09 +0400
X-Gm-Features: AVHnY4LBx4Hw9P8dN5ZIiWO2Gspy61K7n21lW7oZFk3Yijj6YlsFW0Xqss8VO88
Message-ID: <CAKTNdwHA_3eJ4D7maBmAAr1DyrvT_meMsJ7_Naux1dKTzOu3OQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org, 
 macromorgan@hotmail.com, casey.connolly@linaro.org, quic_varada@quicinc.com, 
 felipe.balbi@linux.intel.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 8, 2026 at 2:45=E2=80=AFPM Gurumoorthy Santhakumar
<gurumoorthy.santhakumar@oss.qualcomm.com> wrote:
>
> In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
> being freed via dma_free_coherent(), but the evt structure itself was
> never explicitly freed, causing a memory leak.
>
> In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
> with memalign() was never freed after iterating and releasing all
> individual event buffers, causing another memory leak.
>
> Fix both leaks by freeing the evt struct in
> dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
> dwc3_free_event_buffers() after all entries have been released.
>
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualc=
omm.com>
> ---
> Changes in V2:
> - Removed redundant NULL check before free
> - Removed NULL assignment to the pointer after free
> - Link to V1:
> https://lore.kernel.org/u-boot/20260414055013.2978223-1-gurumoorthy.santh=
akumar@oss.qualcomm.com/
> ---
> ---
>  drivers/usb/dwc3/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 6f22b9232ba..65c4d1a4e6f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -206,6 +206,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *d=
wc,
>                 struct dwc3_event_buffer *evt)
>  {
>         dma_free_coherent(evt->buf);
> +       free(evt);

Hi Gurumoorthy,

evt is allocated using devm_kzalloc, so this change introduces a
double-free causing a crash when tearing down a USB gadget mode
session on my Rockchip RK3576 board:

=3D> ums 0 scsi 0:0
...
CTRL+C - Operation aborted
"Synchronous Abort" handler, esr 0x96000004, far 0xfffffffffe04e990
elr: 00000000408333f8 lr : 0000000040869e90 (reloc)
elr: 00000000ffe4a3f8 lr : 00000000ffe80e90
x0 : 00000000ffe592d0 x1 : 00000000ffe592d2
x2 : 7d00000000000000 x3 : fffffffffe04e980
x4 : 00000000ffef1e68 x5 : 00000000fdea7c52
x6 : 00000000ffef1e78 x7 : 00000000fdef81b0
x8 : 0000000000000008 x9 : 0000000000000001
x10: 0000000000000006 x11: 0000000000000008
x12: 00000000fff090ba x13: 0000000000000000
x14: 00000000fff090ba x15: 0000000000ffffff
x16: 00000000ffe793f0 x17: 0000000000000000
x18: 00000000fddf7d70 x19: 0000000000000000
x20: 00000000fdea7c60 x21: 00000000fdea72a8
x22: 00000000ffeebe50 x23: 00000000ffef5e40
x24: 00000000ffef5000 x25: 00000000ffee5966
x26: 00000000fde90b70 x27: 0000000000000000
x28: 0000000000000000 x29: 00000000fddc6350

Code: f0000526 9139e0c6 cb000063 8b000021 (f9400860)
Resetting CPU ...

resetting ...

These offsets translate to:
 ... free at common/dlmalloc.c:1599
      dwc3_free_event_buffers at drivers/usb/dwc3/core.c:253

Reverting this hunk alone fixes the issue for me.

While at that, I see similar asymmetry (devm_kzalloc + kfree) on
dwc->mem, which might also cause double-free issues, but I'm not
hitting them in my usage scenario.

Best regards,
Alexey
