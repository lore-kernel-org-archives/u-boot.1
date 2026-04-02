Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D925E111224A
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65045840AA;
	Thu,  2 Apr 2026 02:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jnijSR95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C1F84132; Thu,  2 Apr 2026 02:17:47 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F8C840AA
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 02:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9841aecf72so34585966b.2
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 01 Apr 2026 17:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089064; cv=none;
 d=google.com; s=arc-20240605;
 b=ls9+19P3vpuqIbOsbE32JcOywlyMByvGcD7wEnoG6rdF3sts/mqo6c3uqr/7/qpBPq
 MBIqQpyZsWfYD7cahsn6t3aXeRo6QrKkxcmBqC+M6+AUREZRE4TI6GyGdSj3rY+zFKxl
 vxT6kvfLuxeZRYMuzQgxcolGpsX/bfaFbomdMMaHYwyOnZHhumfGsk6p0AP+6M7WYvJr
 h1yGz2UkEeWNDnGkFzwJGO8dAD4+6PPYtFcD1UhCaBkL3JXSrw7KQ42E5EKapIK4JIxA
 XJgM44U9YrJCUN5aiPJzXTpG4X+4yfS5wlfirq0DtsygNDyiEPbyHOUyu6QdbtIbZoPD
 dxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KfdxnU1DzaDbgEE43C3kgxrMy5ZYzBgE6qaKBKQZrRM=;
 fh=Y24MqdswxAZBAAGuN9Jyq2ZYsf1Zi1npAg1EHf++Pow=;
 b=EWqbH9I4r5eCz1Zeok2B0iYYeAMd0UUEu7N3poIoxUFX08t1LMOF17lvsuIOCzNJaT
 SDBz+SultJZTXfREUFWhodob3XB2aSRDjawUHRKz+GI0YjycuV0NHSoS0wwdwvTGhSrO
 CyYTiOSuwv6LtO+PFtjUYSM8Btzu/iRyL0aj3OG6nGAi8VHu4gOYhuBU5Wucy5MSB/vW
 ogIDBvSls/iryjjqQMlphwBnbQm6ipt7DDLwboeN7CAL9KUCG+K0d5b9YukvtNruEXoq
 cnsJoeeN/aHFbd0rUzYexnNTxpOANTd1WQU8V2e5TMP1m8VfdREGZ6PWlRbe37f4RZ1q
 0w8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775089064; x=1775693864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KfdxnU1DzaDbgEE43C3kgxrMy5ZYzBgE6qaKBKQZrRM=;
 b=jnijSR95ckP3gD4Vg+QLTaTsLuX/yTkXGumxWNpYOC1C73yfb5wYNR2SNBL19zlnrJ
 5w9UHWAHesdweuvvVHOp5CXQ0yD3Xje5liRG0Q6kyK5qUUCdlhJKrrjpBHOTPrLVtoyc
 amRG0yahmpg5s59k1vPL82n6UlK2suPkVktYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775089064; x=1775693864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfdxnU1DzaDbgEE43C3kgxrMy5ZYzBgE6qaKBKQZrRM=;
 b=BHNXvgaRho0sm7noSdbwfUlMVDmm7TcSU0wuJpWPWPPHPFqb2toiO/eeghbAxttYkf
 UNS3nr6QoJSEnetv6DfDNDCNFo6x2nfoO6i/KS6hbVwilrWqdTlDpBEKLC4YjOuhKMpx
 vlbzZ3AXI/3MWd2IRCdMBMuBI3aeDDhe1ypIjyNUw7G+prX5doOYQH1jqCrJIZf9YbEk
 WtC9d1bIXzjc3kpma9+Q/XS04ax0R6V+Jx8ejRJ3RlzyIo4+Ri4bzVmK0NhPngx1GCL8
 DLR2z4TUx88jNMpN5SWn65znCEpqSOYWX5crQScGrk7hHqjUOB/3/nz6OdbQBGM7qcNU
 r19A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmHKP8EWs4T0yzbRZa0D0SjSpxAi3DnlbN4nWZVmve1Caef7RZo+8/ph10F+m0V5pqtD21Jww=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj+FZatMUP/5XErhyRqEe+5XucGPrSDQRmVbmcgQ3JJk46+Qrv
 +Bswp8pVftGxNgBFC7fs4T3vLzhe1BnFns0a9QL01lQp/7Wn7Hy7sL8SxMTpRs5vEOQOWx+Ckr8
 ZPzyW1bINY8MlmTC4OvuF1Fwyqj9kPGVNIHwQNIGA
X-Gm-Gg: ATEYQzzQ0XMwLD22TVfLFu5KzbMBydNHQfqZiyerhctm1R29FewH1tXxquqlZSQG8Sa
 tjl3CF/TsiTVr4S5MqJ/d2caCXwDtIOjZBIivUBlJwOe2D2fI4lVLVuwvl3GVa1sJdocNT9Q3px
 R3iRGk2wJ3tKTX65vl3thZYuTPCQpQrdjy1KnU0D7Nxwh29Tza8g78c4qxwPTxwcMJ2sA0V4Xz1
 OiAN8Jf7Cyw151zuQLNgxXLVwJdLtdd0xxRAgcnu/Qc9F8BCFCKFTSvj9hF8kG/P2oPth/Yfiwh
 HmfRgw==
X-Received: by 2002:a17:907:d204:b0:b9b:e687:7ca7 with SMTP id
 a640c23a62f3a-b9c13cc743amr392857466b.50.1775089064437; Wed, 01 Apr 2026
 17:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260401153525.1541415-1-yan.wang@softathome.com>
 <20260401153525.1541415-2-yan.wang@softathome.com>
In-Reply-To: <20260401153525.1541415-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 20:17:31 -0400
X-Gm-Features: AQROBzAMtPHtQj2LxJqVs6t66FwP6HasWCqo_gOVAL9CKvr2g03gBEDfLDA2l80
Message-ID: <CAFLszTie01tay5W0FfeP-fn_ZGN4D+fQXe7P6UxLAdNLHG27sA@mail.gmail.com>
Subject: Re: [2/3] binman: Generate the preload header and sign the data only
 once
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, 
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
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

Hi Paul,

On 2026-04-01T15:35:23, yan wang <yan.wang@softathome.com> wrote:
> binman: Generate the preload header and sign the data only once
> binman: Generate the preload header and sign the data only once
>
> To optimize the preload generation, the header and signatures are
> only generated once all data have been collected. This avoids to
> sign multiple times.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,14 +152,12 @@ class Entry_pre_load(Entry_collection):
> +    def ObtainContents(self):
> +        """Do nothing here.
> +        The data will be obtained and handled in ProcessContents
> +        """
> +        return True

Since ObtainContents() no longer calls SetContents(), contents_size
remains 0 during Pack(). This forces an extra packing pass when
ProcessContentsUpdate() detects the size change from 0 to header_size.

Since header_size is known upfront (from __init__), you could set
contents_size here to avoid the re-pack:

    def ObtainContents(self):
        self.contents_size = self.header_size
        return True

This would allow Pack() to reserve the correct space immediately.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,14 +152,12 @@ class Entry_pre_load(Entry_collection):
> +    def ProcessContents(self):
> +        self.image = self.GetContents(True)
> +        data = self._CreateHeader()
> +        return self.ProcessContentsUpdate(data)

Looking at the series as a whole, patch 3/3 adds the build_done
marking in GetContents() which prevents referenced entries from being
rebuilt. However, this patch calls GetContents() unconditionally with
required=True. If the referenced entry's data somehow becomes
unavailable between passes, this would raise an exception rather than
returning gracefully.

I suspect this is fine since ProcessContents() runs after
ObtainContents() has succeeded for all entries, but please confirm
this is the intended behaviour.

Regards,
Simon
