Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C6C79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A15AD606A6;
	Tue,  8 Sep 2026 09:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3cpOQmYij5P; Tue,  8 Sep 2026 09:09:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3AC1E605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788858571;
	b=A7f92CKfyvLV/qyHEJyXNzmTSsYBD18upeMUqturyBrEKJ1TrxPpFtVRZzeM5sncf047
	 tzgNC4yhn+wWP0O2LNXCXHGsip5WtPasUI2a9RL3BMAjSr73CB9CGgtWJdllq01WVUiXZ
	 1Q452NIf5J0Ljz9zw6SQYAwUrA8ASq0Wwu8CJNwLzz1l+b9nJsEwoWlA1Qg4c//WEQs1b
	 wQ1+LE3J2a6yRJ4P/0G1aSUv95WRGskGMzrd0FkrTvs6CB0YPoo9ZkddvaDJYrk5WWKxv
	 37NqAsgnGApU+yZAG1Ru2/a/LT5se4ojX0L0g0tRvlRcrh4ekSJjm1psuF8mSI2thAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788858571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ETl7KFpNdJx6LhQtbBynPoE/KpKOK3T5OF/gzXsnR2o=;
	b=Dxd5ypNz90gMlBmeaseZ1mDSqYMcY5YZlKtaTa3OjVaGl8JkKSETFuQkb6aZvQMiJOxk
	 bOtwLSzq8jtMUldvvZd8zNmDTRQrTXSju0sNcpt+2hDmRBpG+rS+rLk2Z8e37yXdsXA+/
	 p3ch5VtqS9m7g+0twl4hQg03DCDHleYDp2sr3VLqiYPPQ49xxUvbxr6pVp/qCPNWg0rlc
	 9YIeyiZxtb+igRqJkNj0qggz5XOPLOCIRQutA0GFJdMXAfmFVTC0zWndLezqXe0M1/1y8
	 j2aWwyY5Pv2el0WfeT10bavBkKNSlDAxbIf1lkF3S72UrUptET7mx0GY9JlvYnDAxVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788858571;
	bh=ETl7KFpNdJx6LhQtbBynPoE/KpKOK3T5OF/gzXsnR2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bUB5TZ8WtU+HMhj/VTrnutLVfm+nJO2GYd16wCWhR6OSvRgMeK3QmYXpx1wNWQIxz
	 tBgkT2S3Zvyg0wkb37JKChHHbd1k6b/cZVgNP03dbD4580lZfT5Qq2b598ynKndBog
	 /J90KjJRPNOr5akNWRI5gOrJAVKivqNu7H49pJcxFeMwQrtcryofw4gwu+Lzf9lidv
	 ZmOQ2/+dvy9oyho4f3f9Mf0Ra1xsrZG9W3CHNhIlntsrXiIqF2C/6QaaY3fDrwxg19
	 /MtTkkf26wqE7/V7BKmbgW1XgdBIya9qKOyHXE2v94yHoALlO2h6m1b/w6TvGW5xJk
	 8zbZDn+QL+rdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC1E605DA;
	Tue,  8 Sep 2026 09:09:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03DA772C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEF4E40063
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3-DiANpSZoR for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4D9B14002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788858568;
 b=XkXpUKQS8AHX0oNzEY49xJpas31pENZISBNY/kG8FAu+gAF/MVbV6xX7SBu2yF/Jzuef
 fNme86haxLYglQtFwrQGlN+9OepGbngLuxMCmbAl9DYr/fYQ1dEErAUZg7RSlYsk2evhN
 CXSUe/Ccw4Tgbl+P/h8ctuOXrPo7z1eEVj8Mi5FGFVROGPEAIfiXDRvpfGDYCZqa85bcD
 1gR1CeavMqc1WcxDhlzOrT8q9mp6XtlWDMPs6Vt6QX8xeVkrYJHmj0IjMV299mqDsFRak
 F8yH/EYo2gn4IJaiOCXXzqEpOpMLufCbpQdSrgnc7V/pIbwEKgdg46U1AcHUft/2/4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788858568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ETl7KFpNdJx6LhQtbBynPoE/KpKOK3T5OF/gzXsnR2o=;
 b=aaPdk5rplUw9BO7Px69PpHCXHU470hgMdUiZ/7WYWNS+meMcVoZdZTUA0Uq/TiCBbGi3
 d7aBuokKxuXvcxDOmP06cuAfx/Bg3w9BkExvvXQP44v7pmRwymBBJburNmNRwUYWje+VS
 Kxh5gCE6BQj7lZzoT2nvJXXz4uIZ7aWyevAzZbjIokAsQ38to/pyEIaF1Gz2EQyES6kmB
 WDHadVa9VspYKmqzX6xHXPvgcf8k5HkKocuHbgk7GDsTEiaziJjq2uGhjfmAC0DYfEXXE
 3rugfH38Xjp+RZYmma3/AVOWiEfvuCV7xlT8qPBZOvWQcBJCzuhNkNHfMkGkFkw4GTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JwcxSPiA; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JwcxSPiA
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D9B14002B
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:09:26 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356256so396665f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788858564; x=1789463364;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ETl7KFpNdJx6LhQtbBynPoE/KpKOK3T5OF/gzXsnR2o=;
 b=JwcxSPiAAqJmM4gvWf7Y5ImcHnUa57tyHui1xPtARn3ff4Pki/ucT9LvJnvUYpRVZg
 n5JS8wzTYN06is+zeFpRALQF30k8mwkNWSRy1n+LpIEvd25D31EOBXRoJGfle9AxBl4F
 o3FeogecY+3vznD1w3kXNWByYdnPBovpJ3OqAnuofWRmpU23KbEG4IU0JYSLrOhQ8TR6
 998Y8cSku95xk7g0k5A8895WLkZbx4nvwukb497BEKqQPZ2Am8QQXOclLeTaSFRFxlb6
 P0XOZNNy0ApJn/gefFuZZziC5tg9ZjFN2cmHejYNIYc8pa7LbAcFs63jGpzVjdM8fgXC
 PVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858564; x=1789463364;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ETl7KFpNdJx6LhQtbBynPoE/KpKOK3T5OF/gzXsnR2o=;
 b=k4/q6WNj8p+m47YMEhJ7SoYbxmk3pmncJTFAGu13n4T6D2n9H7Hx+qoyhBl+yBujrz
 tdvosahMTahlszDpUyFLmGslGJAuEMpKMzAqap4jvTTUyeyTB9OGuQRljJ9UJf7Fh7s5
 05+rmpu1blTfeLR2x3d2zV7YtPQHSiPF/4trVbtWFMOTAIif8t7Gql7X6fIyfqewzZQ6
 wfyXQ/OzmNhq/XJoS0IIUuU+psSq2Q3CFYxiiDIvF3LaAruNM2PCtM/jfPkHPbg38M7L
 7tUffnR9O+UFK9/eZwOchIewfKs83LDzoUvZWun3rUGE0jJWfN/sBNQ06b6oNakdYC61
 NPuQ==
X-Gm-Message-State: AFuF++mUZC41TIBgNo501AuhyyelkvsC7sNwsy55U/CcPBfVc1rcaD7I
 6zYtA4U571cjM6D+1IIUjP5lfb9u5rxSlqSIfNMaDfBVUxVsk2nUKNjjtUoNOavcwN0=
X-Gm-Gg: AYBFou35o7UxoPtb4xTmQq2w6j3WQ+qaF5kFDSvKyw+30I98BfbXb2JeR+mFWTkaU8g
 MZqjvUxciLNiIuK6r734AtAleC4ee0LRfEO5TaWczKgOWqqtEa/T/CPfayOMa1NS3eZz8KD3NCA
 0ISbpNJHFdIrFhRZ+ZKGdn4IafdhgrXTc5ZcmHx8QJ8p0vRucF+oObOnddZdYSH65wfn5CQkInN
 qqoHtpwGaCjv32+Bcz6LtjLeW3Jq+v5Ky0SLdi2HaRAKddxsAv87p/zIn10tGaAtOmYmhTLQ+Of
 lrlKGtrxcY3NPZUpqVQeRt5k3XNLaIIagcsABBprV7osuD4BI+YIMORhWy6yscUUwjLR4/r93Sg
 rDvJiYTE1e4OlSg/2q+MyBozscCrxXCQ0KoPKXqZ03P0w4ewXVyvnhh49J2dmfRdERwfvy8iOTB
 5kPKW545pNTl93nt+jJ3Yv2ZiqpoDZUXcnhoYv3TKmmN/iD6g0p6FG/jKbie+/HhrGTfL70MWwC
 WXni2LOOIqaySw5OFu1tEUl1bMj3PreuYXYRgIP3Ms+DKc=
X-Received: by 2002:a05:600c:4ece:b0:49c:eded:44e with SMTP id
 5b1f17b1804b1-49d175561bbmr52717255e9.7.1788858564150; 
 Tue, 08 Sep 2026 02:09:24 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0656e7bbsm273743625e9.10.2026.09.08.02.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:09:23 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:09:21 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
Message-ID: <ap_PgbRzwImsNwO4@macbook>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
 <CAC_iWjKrYxidFNW9MWuKT2DKynD4OSirA-jprGQ=NJYUxPGFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKrYxidFNW9MWuKT2DKynD4OSirA-jprGQ=NJYUxPGFkQ@mail.gmail.com>
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

On Tue, Sep 08, 2026 at 11:37:43 +0100, Ilias Apalodimas wrote:
> Hi Carlo,

Hello Ilias,
 
> On Thu, 3 Sept 2026 at 16:10, Carlo Caione <ccaione@baylibre.com> wrote:
> 
> > SystemReady DeviceTree can boot through the UEFI boot manager without
> > going through the per-device EFI bootmeth. Use firmware_fdt_stage() here
> > as well so both EFI launch paths install the same firmware-owned
> > devicetree.

[...]
> >         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> > +               if (!fdt) {
> > +                       ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
> > +                       int err;
> >
> +
> >
> 
> Any reason we are doing the _hex variant instead of env_get? Don't we want
> to bail out if the env variable isnt defined instead of picking 0x0 ?

We do, but we do that in firmware_fdt_stage() that is returning -EINVAL
before loading or copying the FIT (so we return EFI_DEVICE_ERROR from
this function in the end).

So basically zero is an invalid-address sentinel, never a staging
destination.

> +                       err = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
> > +                                                &fw_fdt_fname);
> > +                       if (!err) {
> > +                               fdt = map_sysmem(fdt_addr, fw_fdt_size);
> > +                       } else if (err != -ENOENT) {
> > +                               log_err("Failed to load firmware
> > devicetree '%s' (err %d)\n",
> > +                                       fw_fdt_fname ? fw_fdt_fname :
> > "fdt.itb", err);
> > +                               ret = EFI_DEVICE_ERROR;
> > +                               goto out;
> > +                       }
> > +               }
> > +
[...]

Ciao,

--
Carlo Caione
