Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA16C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BCA84099F;
	Tue, 28 Jul 2026 11:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DvlMu0n4lWdJ; Tue, 28 Jul 2026 11:34:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9ACA409A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238439;
	bh=JqO+1L6uXLqkdl63jQf4zUaM6Dp6TyqHyDjcODpn2UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msiRw7CVHOuoUWrTjEr0WiBlQcGvUTeQzD/bEW3RIfYXmaGkFGZ6YrSVuuY3O8go3
	 cSCe+RLIB20QLWHHnJSt3QeLpBl0gSdscV4AB+/CQ/ZUrIcHaxI65tqFfG+/a9QrCQ
	 dwTmc4qLz2nTTYYiaTWpIczaDIguvmuq6qWFYK1PDW7CnosUoKBOnqc7U899Oaq2kc
	 ocndY3WVoF/sjJyhDKa94gTdZS0kBzwBqABbMxDtXpo92M5cbhPgZDtiiHcMtyh1UX
	 nSfSbLzPRbt3A6NBTvZCc2BOS7MJd9ryhRHL3kjxvCWyTMS60W1z8EF8QbTeZHpxF6
	 60eznkQQwpvMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9ACA409A0;
	Tue, 28 Jul 2026 11:33:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3434D350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A8BC409A7
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8SxPdq667gBe for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:33:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AE0A84099F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE0A84099F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE0A84099F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:33:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33FE8494B; Tue, 28 Jul 2026 13:33:54 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6539882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:33:52 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so474128866b.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238432; cv=none;
 d=google.com; s=arc-20260327;
 b=ZNpO6UW+TndapXPXcsoancQTKQr3VnrJV1qyI6QETRqdw4FrJN1BeqAdpU1P8u6m9F
 NZfr6zalZbLsayyLm3pRNA8Sn0vDOwfdMj0dFt90Tbbrubykoynk4RauGqp1brnHC7b7
 XroOnTt5D6/dEb7JFrNVpxB3DXtf4vN2kAeJU7a99wmmRnK7gd1Fz91OF9HKFPik9m7Q
 su9ZjuHR6vseNSrY1a/9sDqAm5j8XKzWNjWaH8YjbWN/Sa3RfVLYtNFG811XK9DlcMoo
 arJIup8emPOBUWwyR6CJcT1TBJ56Ek/BZpWi2x/yXfpDuuvcd+KZaG37desyr80rTxWb
 64gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JqO+1L6uXLqkdl63jQf4zUaM6Dp6TyqHyDjcODpn2UM=;
 fh=MgiHO5E4cCrBzRVcaZ+7viK4F0Tcwb0QN5iR5miw5sA=;
 b=OiBGk92h6nY5yA/YAtvwUtKvJZyrGm9A8/WVVts3gnamAyF3RTuxAL0kVu5q//LopR
 MC+tXVAkY6+Hnj0J3mWZlrXOV/h8A+TKFkI5ysepMCE8YvHAWUgioMYx3DV5KJYnjbjk
 oV/fJWmdQg+uNQ4Ivgtyws0zG9uRzE9FiQxcS604FU34+Vilr/O5VgngBoVGMo6YBtaz
 JqwgnusldO1SYDqRFYdgzJOd+NhfxqFH4o1KyiNnBANq981ufn0tIKFZXR4/ywMpXag4
 ZOize+MMy6d7k0vYLBrQzMNtyWr0T1N+dnlYtyA3V0QbADJkpGEN/ztjidJT3csomZcv
 0OZg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238432; x=1785843232;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JqO+1L6uXLqkdl63jQf4zUaM6Dp6TyqHyDjcODpn2UM=;
 b=a6jhPZmro6Fk+aiWTiLLTTIPcfI+pGImAWwELckhE41NMIueMjpLSw1aCYxB8wy16r
 WcEc4gamKprnYCzFcbuJHDZPsyVfBgZ8nYn9o1zDfUT0XKKVXpRJaEu6TwQJEfD74plY
 bmt40aErFOUn4FlA6rGQqDxaMu981nJXoHWjJO87oBf9qQFclWJ+sMIAoeuiCT5AxH6u
 HHiISKmbsmpfawzY9iI1rS6HKVIoyoswNmyy1PVmWqA3oWBMSwmmsxo9O6KJiT3tYbJk
 Bai58YsgCSigHbthNICVM4SWwa7IxVBK4JyR4YJNhVjq06KhRufDsTAS4RHcoVtCAIzM
 +Ilg==
X-Gm-Message-State: AOJu0YwR+jcem4IrkVYSCHUAmGT6uDVdNj8VDHj04gF7kNl0oYgcG5yS
 Nt2QdIrbrwpQwrSydcJEHkY6m6ah8n7JQUoX3P7PPEvhHlh2FibDodJAQYIcUFDmwS+qCu/DrLF
 AeTkKI20T+atSRnIBUFIbo2+JCnwQ/AYt698qVt2v
X-Gm-Gg: AR+sD11kBbJesYq1cTmVU/zKsvWwlCyuEF2IhLMjpeJhnLX89SPiZRKy6X/1+XyKWqc
 oDeK8bTUiaPIrc8hojr41mE4D9pFsE0MiwDiZe6l+WbQqaODtJW3EwlcmlvLkjNSLwcycR4wVUP
 9eboYafO014914gDRu7T549oGGu5Gyu8mqewRDmLxXf5cVMfP1O4TUQcQ2L3E1NjGZs4Ny2UfOp
 2ZWYxwxzfjx4KPkKyuIjRQrUKHlI4EvyJgtapYw9etFffzia4ybcQjEWdUXzLDeTRfBKYA=
X-Received: by 2002:a17:907:1b1f:b0:c15:bfd4:d422 with SMTP id
 a640c23a62f3a-c1f721151d6mr106848166b.25.1785238431795; Tue, 28 Jul 2026
 04:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260715133716.10449-1-marex@nabladev.com>
 <CAFLszTgd-5XitS0XCDMVVboozbqmz_VhvyoU6=-NKJT6DZiuaw@mail.gmail.com>
 <69df7c30-1e58-474d-a1f6-af1edf684e5a@nabladev.com>
In-Reply-To: <69df7c30-1e58-474d-a1f6-af1edf684e5a@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:33:39 -0600
X-Gm-Features: AUfX_mzMp96m2WB1enq7z8Dr1NRHPpbazw67ygkICcnliPHbi8RrHZmKgW2MFAo
Message-ID: <CAFLszTh-mS0Tgshp3uw51RJRk4z0puZrfyaJc0Z17gntUN9E9Q@mail.gmail.com>
Subject: Re: [PATCH] binman: nxp_imx8mcst: Handle FCFB header during SPI NOR
 boot
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238432; x=1785843232; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JqO+1L6uXLqkdl63jQf4zUaM6Dp6TyqHyDjcODpn2UM=;
 b=LbrzieDa/YfhnfhZtLcXAMRF2MwKr5gumuaYQVnQqSBN0opwFq3AHL/49hG6Z+ybEM
 apCydVhLNnWNV+ej7kyZ9qfhncE4t52hl1oRyS8BmG13+kvXa7/1qviAQaXRBC4CIn9j
 B1U4UeCy2dEORj1wfKhxuqtwnYwR0Kjx2kLDA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LbrzieDa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbrzieDa";
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

Hi Marek,

On Mon, 20 Jul 2026 at 20:10, Marek Vasut <marex@nabladev.com> wrote:
>
> On 7/17/26 4:05 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> >> @@ -114,6 +115,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> >> +        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
> >> +            # Sign the payload including FCFB and imx8mimage headers
> >> +            # (extra 0x1000 and 0x40 bytes before the payload)
> >> +            signbase -= 0x1040
> >> +            signsize = struct.unpack('<I', data[4120:4124])[0] - signbase
> >
> > Please see below for test ideas.
> >
> > Also, 4120 is quite obscure as a decimal literal. Since this branch is
> > the IVT one shifted by 0x1000, perhaps the two could be merged, e.g.:
> >
> >      if signtype in (MAGIC_NXP_IMX_IVT, MAGIC_NXP_IMX_FCFB):
> >          off = 0x1000 if signtype == MAGIC_NXP_IMX_FCFB else 0
> >          signbase -= off + 0x40
> >          signsize = struct.unpack(
> >              '<I', data[off + 24:off + 28])[0] - signbase
> >          data = data[:signsize]
> >
> > That makes it clear the value being read is the csf pointer at IVT
> > offset 24, same as the existing case. What do you think?
>
> Yuck, no, I would very much prefer the current readable form than this
> conflated horribleness. The image assembly is convoluted enough as it is.
>
> >> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> >> @@ -114,6 +115,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> >> +        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
> >
> > Please can you also update the block comment above this code ("Parse
> > the input data and figure out what it is that is being signed") to
> > mention the FCFB case?
>
> Done in V2.
>
> > Here is my attempt at a test (it doesn't actually check the output though):
> If you would like to write a proper test, I can help with providing
> expected outputs.

Checking outputs is nice but (perhaps oddly!) not essential. Binman
just requires that tests exercise the code. So the test I sent
previously should be enough to get 'binman test -T' to pass.

Regards,
Simon
