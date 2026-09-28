Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85052CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 558E680CAB;
	Mon, 28 Sep 2026 15:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bcTJqX1eIM0E; Mon, 28 Sep 2026 15:18:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7C59E80ECA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608682;
	b=IXxLH2DXF0UPHfhaF/39W1rCr6DccGKaBwov9B2LPV/SI2AB09/M8rlA99LoAgzFy6c5
	 T6F4UWlp+6UFxKPWDjlkYuMxo8O7hIw+8SPusMAzNdDkvy+A0NMetsITYVwmkZAjtslwL
	 UtTAPtLe11TTI2ImoKllK5FkrhHwuTMMg4DTO0SfluniL99QfdJ9Vf87UjskquWPAQ3OR
	 3fqSz2Ldq8HOVXuUawTKCbe7f80zbgJwBnaApZJXwEYE6pL+TlJUmeABANa14L5pX6SqR
	 9dNjeTFCBXaOo3AcX4M6S8pwDpqNWOmuFWOpK5tprErSOFz1zSuFd9TOsTwgklyX6FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
	b=Rk7p6eu0b5dXZG6ZvKnbk35VQCL8bcVhPNmSZg2MZ8SNf1tU9d0+RJKOkBdlSAzV0k2b
	 8n2+xUK+Ywf6EcNj1hhZrcEb7m/9VzeLw81gwIokLnw50heXfyX5sbi2KFYHU7SEkAswO
	 jzB376ncb/eKPXqjXxM9zM0qBUEZRk+iShSozXGRcjtd9hSQ/h3jpZhhiNhQZ47M3XNMV
	 zP+xpoY0PNG4h9uZHXGb40FGzj+/9Cy4hOIbVFmbDeYxmKrolIbPDcnFC50Tc94ldrpdn
	 zakoR9b+qMo1t4xIGmL1EzECQSIXlNXjGM5AqJJdmq39ubsDuC4VWFdIF58WjTa0OlA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608682;
	bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dhNhL360HYy+Hd4u39MHE8jNjNor1rh56W98/nqNLY6rhJG++AVChYbd2zDIlvQMx
	 ny3q2urS/qxsmfUD786XpOf89grS6vl3lQe/BztNa4xwVGY3gt94DLVf9kvQ/3CaSu
	 qEuJKfYl7j82qV0G7drACin6DEsmd0iYF3wdJwiEmMRcUGCRgSAoYOmA79DDKlWkhu
	 2tivd4RW66kB1tX0i9I+XfuWTSuPhA2BdahlduqQvg6a+Yes6VXWoA3E9MiqI5z2zw
	 F4PZ1tiTnXWkrdXcSL59lSVWr2vpFcpVf1d3LuEBOxn7M+Zr59vNWSIe+caX0L2X88
	 IfMkBlzYIOQKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C59E80ECA;
	Mon, 28 Sep 2026 15:18:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C383D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0383606DB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yONfDUiHgx1D for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F4088605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608680;
 b=bZaW8fqn37rcPWrC/ZU1CVZI2A4olZQUDYzshu5Zo2izGCxoTvqJIzvkpqz82M7bZUIf
 l3inY1okgKFBryalCup+g6/tipqpm1qMqD82cdiBFfKzKu40+5APmgAiP7PJ5rtlrnM0a
 BasXDTinIXtUzH8ZpNlfSB6QJ/sZ0z0HcnRVgIuAcCGcfga8+ib5Shh9vDaTbNd7iPceJ
 TxPAjQ+rTjlG87MXQkrkHFbrBjVZWaQmO3WyIFRwDnNjN+nPq5avBl5THRRW9tg/xWhk4
 laWGNl85c4mJdSbXOKM9O6asyZJrdyLvhYkmQfT3Nf+lU4AlklfAEWJJfn2DxvbMUgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608680;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
 b=KnlCxFI7VGmkX3YYm+En/M5YMF8sx/xDGG1gI98cBPJSxblnrF4y4ECZUUzB+tTRzYrW
 2KORo+uX94Ec9Iek2pihc49e/eGWOCrHGGzY073+8cGsAMJqnB6TWHUUFM84nhJEIouUq
 K+6CMaH/RKKL/ifEmLHto+ljpyF22U7nZO20diG4DV9sViNwb4Sv8gYjpFqVO9YwJI+2H
 WIVz1kUxufUSmqaESZrPgpeguoSdc0JgS//OAHiH/jo5jB4iHXPxQZEhrScR8PB2KW6P7
 6tHkSCL/a6YnFw/J+Mgof2p9Fcj7Yt/BYBvHyvwPAG+ayWrN3mz757fkjrQMHuqOJww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LmVmVnJT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LmVmVnJT
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F4088605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:17:59 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac6fa788e6so2014765a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608678; cv=none;
 d=google.com; s=arc-20260327;
 b=VPdbfUKxaEe2fyjkwBhquheYHTOgwnBaRAGVCeIyf1QxEo0kmrw3RzWVJ2bXfqETHR
 aIXhq81x84hv5Se/HuYVAxslIL7ZwvlDc0SAZxXzugD/3VP1avCSK4ETeCegZqX7+JsM
 T6xnOsxZiBezK9gAfJ5yXe6HlxpbSdu20TRF/c3tFnld05gM6DxwZp26qF+ftWWG42XT
 NXGrO+lHGRDpfjuSuG+GXprVm/EsAPhYpRnae0THJdVteZiDLbttNNdMKtGQcK8l8vuM
 UF5boLzr8FVkORK8ppGn/hfVTeZfjnkyWkvfut6S9on+GMIllCLBeXEws4xdVRSRLp+s
 8j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
 fh=aqd46N2Hyzxox8VQ4JNlgL5WStDH1LI92L24RO4+pe8=;
 b=Ly90tUNy6IKk4bD5gGbN7OENI0wcwknVcOEtXE+Nbrfeymzfkxx4eLVoVJTSZ6u1u4
 cczptbwOirI5n7y5mUoHKWa4T3hxxLmqJqxDoPlfjTujW071nLb1gkHo1Vn9OfjQrhqx
 0TqLDM2/RNT9nWamynqNZRLk0ZLXlXVBQV90+HZwAgWcJa3QlUMVeI7psCIW3oVmUEsr
 FK4EqbCvIbFUOS6lv+RLLgNjM674kAytNuG9pa+hA7UcDAZgaZxyOMA1fqeT0/gN7n0V
 TyNEHQjfQ/U7o71xo4dBhr5FJ8fUWhHc0y6ryXoYyoMGdNMJtiwJSSwrLXalK2hB547I
 N8yQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608678; x=1791213478;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
 b=LmVmVnJT6Ns7xXjeAsbxL7dEKL2mRXLc/78yXRYnYLK0KQiap7cv17HTmxbGUax/G9
 JgO2Y0WUVkPofBrz2VtDdUX23fTkSFPCVuToMKiOQBCbmDLOJNm3GBldY0RsnMPStNzj
 zC7eYK/5ASZc5CcvZA59/6a+W94agHfAkYR1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608678; x=1791213478;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H9K9e0GtnAs9GfuQOnXLhfSCFvkBvHI8ctjdOhV8ZkQ=;
 b=kBdNls+n/+lTvY0MeU7wgAP8SzSTv+jHF49I1ni5RpwPCpzjjI+VnuwDSKdcAQO1kw
 KvSkjyF6Ms4aw58c5kidtKLFEk7fK/uDVQFGKkc6CfXN4DwlQzYQylhYWMBIQHJg+UUi
 ZHkP1Cazs05zLzI7wsBj5ZWznMA2vc2nvVqD0fll+wfgU0oy1kssi/yBIX1vr63lB+yf
 YfylaVasHM2rBr5imZcsp/9tc9QXFgoLt5050P3nmQzEDou1+s2oOc2wHkRnwKqzNMZD
 x2XdA0xa0kv5PWeCXLHhrpdF15+FkijoAdOSOBj5PAjV9pswv5tr+m5u6ADZ513wYHZ9
 Rv5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl16TdYl7yv/0TrUanAXPVslRmuJrow9IerDLRFt0fQG/N5IuNQPON/cDem8iK/rhat2xXJS4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJXb4GYB2fk8DY+g1I1/iyga6fXUp0mYvbsWUCzvv376iTjqli8
 2zcssAWtYVrRfgRfM8xCY44jz8YKCftrzM0zx6GxwuEmu/k1osHw7pKUzui0dhztvrYwRD7ENGq
 VzaYTGxjp78LxV0xorJi7UvdXSGz4Qtj5IWDwy8mv
X-Gm-Gg: AYBFou33oLLDqLRccaN9/vOyHtnsAezxMY2Fb5NdD4CNKiygxGQk6kpYBGhwJ/U/HA5
 ZqCAqw7gAPS0KrGoEPnr/ReZPkE1OcjheiyFV0dgDwMKBySNYlDIc3hX5gqzQ+wdkF3tD1reZ+v
 +Xt0ku7ZTOz5Oe8/lD8aePsox4FC+i9k/s2WPUv/lXsdBe8uNlKRxXEF6aoJjAAPtMAFWkAWOnG
 sCtArQubF8bq5LxtharHpEUfnmU5rhmTNB/0IigTB+tUIWu3S+h1T/eh5IahLImA1Wx8pN3t5p3
 qo/ef0zzcqnCAXd/OuCfsx17tmhilLpUXWKPS52TZ2a6oxdwEVjftiNOugKyY5/2
X-Received: by 2002:a05:6402:320d:b0:6aa:4529:4cba with SMTP id
 4fb4d7f45d1cf-6aacc4e67ffmr11031283a12.7.1790608677800; Mon, 28 Sep 2026
 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <bcdef6b8f84ca16bbfa79cfce7e9deecd3f9b24d.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <bcdef6b8f84ca16bbfa79cfce7e9deecd3f9b24d.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:17:44 -0600
X-Gm-Features: AclHuK8ROH8P6Upw-U2nlKtkfk9ymJqtsKbfc9M5dinlYgtDgplxOnUimQkTzdo
Message-ID: <CAFLszTgJH-_45WU0j1DdiX4odghDa5eP+8gZXTbD6nkebFfmkA@mail.gmail.com>
Subject: Re: [PATCH 9/9] doc: imagemap: document on-demand loading framework
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> doc: imagemap: document on-demand loading framework
>
> Describe the imagemap framework architecture: the translation table
> that tracks mapped regions and its phase-determined caching, reading
> from a block-device partition (including MTD via mtdblock and UBI via
> ubiblock), the integration with bootm for on-demand FIT sub-image
> loading, and the SPL build.

The doc doesn't actually describe the SPL build - imagemap is
full-U-Boot only. Please either drop that clause from the commit
message, or add a short paragraph in imagemap.rst noting the SPL
gating (why xpl phases carry no cost).

>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> MAINTAINERS              |   1 +
>  doc/develop/imagemap.rst | 100 +++++++++++++++++++++++++++++++++++++++++++++++
>  doc/develop/index.rst    |   1 +
>  3 files changed, 102 insertions(+)

> +The ``bootmeth_openwrt`` boot method is the primary consumer of this
> +framework, using it to boot OpenWrt-style FIT firmware images stored
> +directly on raw storage.

bootmeth_openwrt isn't in-tree yet - so better as 'will be the first
in-tree consumer' so the doc doesn't point at a missing symbol.

> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> @@ -31,6 +31,7 @@ Implementation
>
>     directories
>     bloblist
> +   imagemap
>     bootstd/index
>     ci_testing
>     commands

The surrounding entries are alphabetical (bloblist, bootstd, chid,
ci_testing, commands, ...) so imagemap belongs later - around
global_data/init, not between bloblist and bootstd/index.

> diff --git a/doc/develop/imagemap.rst b/doc/develop/imagemap.rst
> @@ -0,0 +1,100 @@
> +``imagemap_create(dev, name, part)``
> +   Create an imagemap device over a partition of block device *dev*,
> +   selected by *name* or by index *part*.

The real signature also takes a struct udevice **devp out parameter
(see include/imagemap.h). Please add it here so the doc matches the
API.

> diff --git a/doc/develop/imagemap.rst b/doc/develop/imagemap.rst
> @@ -0,0 +1,100 @@
> +Boot Integration
> +----------------
> +
> +The ``imagemap`` framework integrates with the boot pipeline through
> +``bootm_run_states()`` in ``boot/bootm.c``:
> +
> +1. The imagemap device pointer is stored in ``struct bootm_info``
> +   and propagated to the global ``images`` structure.
> +
> +2. ``boot_get_kernel()`` uses ``imagemap_map()`` to read the image
> +   header and FIT metadata without loading the full image into RAM.

boot_get_kernel() is a static helper in boot/bootm.c - a doc reader
won't easily find it. Please either name the entry point a caller
actually reaches (bootm_run_states() / bootm_find_os()) or note that
it's internal. Same for the imagemap_map_to() reference under
fit_image_load(): it would help to say which caller in patch 6 uses
it.

Regards,
Simon
