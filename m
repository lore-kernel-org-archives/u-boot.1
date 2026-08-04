Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC2DC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E2F5406E1;
	Tue,  4 Aug 2026 18:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLBzgnHWo5Zu; Tue,  4 Aug 2026 18:13:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14A5240696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867204;
	bh=flbUtuoci6ywY/OVfgWnpF9TRtHzdCIPWXq+EsMqqt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUts1XLDguKM3+3vW3kg2louaNXf06PHQ3YZWJXIWpllbOtiUvRa3CGxqSM5hOTdK
	 CXI+BlY/UO4E0lfJZnJvBs6bQjHQujUEljonA9AxIy7wpOfQ0O5MkVaHO1gIO+QQtu
	 WldkCmFJoVmOPvgiltbwVdnYIrUAlUmKdZG1RcySH/Ml0jJkL6fYqS030NIc5poEaJ
	 iCbsUKQzsmiv/fm32t6GUI684u8yP7v0fDnDrvt3tFRgTp3tkqTPuPaVTc2WjZlfqx
	 h2tGSS/j30istAoUU5Uh4/QszzzNXn4RBxoXqy+cvw33UNrE23sQE5ot/PjumveqE5
	 Ek/4mgkHPDT4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14A5240696;
	Tue,  4 Aug 2026 18:13:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EDC5350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0547960633
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6prH-WU35ioV for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:15:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4CC0D60627
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CC0D60627
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CC0D60627
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:15:14 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso5425582b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852913; cv=none;
 d=google.com; s=arc-20260327;
 b=EnmB6EFi/WwFQ24ybJe1+RLqlhYHfgs77iZzf8+uKPMRed/ENzuwgq7jCA6VRXaiMU
 z6ajaJ8X3y5dyiqblv6txw81/ahli0ad8SzJrHp9OcH0HfPrrZ5TR8PtULcwCEdDs6IG
 c5CeEqPTU7wAXUCepPbJqYdVpB983xMvpciY3+MVuU3ORILIZbBnOaPFMNY+KoU65Wh5
 txWZLcdB59dp32vqB12yU/jj3ccz0UpfviZqjjK+4Enhn7NfF/+agr61wbn4veXghqg5
 watnle7NeWeiuFrhTdGWl5aPpPzvijmtom/zecDOJv1QCK0Pzsqpfnpwc+XHwptLbhgC
 S/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=flbUtuoci6ywY/OVfgWnpF9TRtHzdCIPWXq+EsMqqt0=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=FKTZq+ZcTFnR/hZulfCHkgYDXuToWa1mM3vIBXehl68PcgG8DSvFgDuwbnBlH4Jqx6
 Lgk8lqVu/aH7A258XJqPQZaUtIW0MivEl8pNDzlKCkntaqu55rv4D9JimAdDM/LRpnPj
 0v0n/X8gchWZAq7AbJlp9hk9lh2VfkPZgaZE4oiQ4iFLXV4UuF2t+By2H0EmKbWK0LVW
 spu8xO533OuYy3VJTL4zgME0sUVKVW16+i0gByU4U52E+eMq7RSuofq7+K+VwMoUEeJW
 A2MhOsPwJXscMHyuCLgbMLmvMO/exA8YpwkhX9wQywpR0iAf49S1wqYsTcpz4RpWXpnq
 e/zg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852913; x=1786457713;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=flbUtuoci6ywY/OVfgWnpF9TRtHzdCIPWXq+EsMqqt0=;
 b=Gt+Yq4CW9JRyn1s2blzfnxnbq//KuQGVB12H/oyE+CLeccbRfFx+g7ZCAJ9MRLb9QC
 8zTHXwk5KiIlyciENsbpscnqAbEinspiUoOQ6DPcHdSKF1MvXI50tJ6NryIEu7sPh1Fd
 Ssm/LHkWv/Nmh3USZ96KeS40CYbKksh3Gwqe0xsxo7XabmKFd6CbStczW3DsE3YGyvW7
 III2jdBGbjuzw8nJ4JUG5sDXQEVZ7ST2djdxT/8CBBKajAbVU5j/IQuLBvzTDV1Zn2LR
 23u650kkkqijH+nqw4+lRbxGgr1wPTNU0trIgBJYmutsXttL+fdrVvkq7bB0g5YGfJQ6
 r14Q==
X-Gm-Message-State: AOJu0YzPYDjWpDte+nHNJLcTHo8JAjgncceW4upgqPZWT/i5kyR5oYOY
 MuaTX0BAocXasuODhLyzE+oRUKQ1i+y5wr5Jp+uEEQ9ehj2aso/+o/5Q+A/AE0BV2Dy8asEJzUo
 pJ22h8RlEC3usix9dHaKBSwvRb94lPdD3ZXsJjrte1w==
X-Gm-Gg: AR+sD12if2CkXRZUEM7EVzKaa/bxS+PWmIehOet71vbA+UijaJOv1cQ38FHG40HYRn0
 YHstAdvWc/Z+V+QpmRX5FyeWh5NKmkngeZK9voNZimUYXx2OgmplDZNyvAAFC61ph/v/xjRUI3j
 FTvxe6uSl3rx61eRn3uAml2YBQ0E5lUHBI0KdXhLgb5E7iGiK8u07NsnU3YVl5g6lCWpRDUmnVo
 J3iHVl/1XDa1odurUxwOUOG7L0TspLQ1rqj0i9zbdvFPvx/XWp/XvHPRzZG5ceIuv2zGwUHegRR
 2t+v8EnB8xHFjkAECQRMFTNi00v3YUmnmwCO8PKWZzy2PxjsMUd0lVCBUTKtOWkkxtMK5iBGKv9
 c
X-Received: by 2002:a05:6a21:920d:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3c92a543d28mr16232214637.3.1785852913551; Tue, 04 Aug 2026
 07:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <CAFLszTh-HpSCUjT6R+daf57YDdwgWfNun4mddqZi+jU5LTwVLw@mail.gmail.com>
In-Reply-To: <CAFLszTh-HpSCUjT6R+daf57YDdwgWfNun4mddqZi+jU5LTwVLw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:15:01 +0400
X-Gm-Features: AUfX_mx2sj0MIyt0wKDntgtvQ-76799is1c3S9MGHGMVxAgJ8KGjSwp1tjEknFY
Message-ID: <CAKTNdwGLEBm6W1s-xAnhwK+Wpisek87kLMPF9grm+J7tmZKW3A@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785852913; x=1786457713;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=flbUtuoci6ywY/OVfgWnpF9TRtHzdCIPWXq+EsMqqt0=;
 b=U8UB6soKSV+wO3KLPjVv8o8v+kzafSX8DOoKfseu2WvPZFdKxSo/rSSi/AwPZsDyHM
 1v2eW1LOEiubuzI1iwkd0wdAVBwmGyffiB8AjNHAGoWthZItM0W3pYcRSidERIj6POB0
 760O4VSLqF3SbafflixXaktrgeRAl2f9MxztdFXOVnCZ5YAED3fcahKf6MiJEemcoWHI
 PEiMFzOLxBV+SpMGRvpa3jlGo+ofMTzOVSOlrDBUsjp3k51RUfTy+dL79X0lqgKQiFDo
 KoAn9S+Vnj7vJkoU3V2vRqXTuMqe/m9uftalX6qknfhbwm80h7sS827MO8jULQOUlZfZ
 wBJw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=U8UB6soK
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > binman: Add support for pre-patching FDTs in a FIT with a /chosen node
> >
> > When a generated FIT is used to boot Linux directly, bypassing U-Boot
> > proper (Falcon mode), there is no runtime code to discover the kernel
> > command line and (optional) initrd location and include them in a FDT.
> >
> > To facilitate easier preparation of a ready-to-boot FIT, add support fo=
r
> > pre-patching the FDTs in a FIT with a preconfigured /chosen node includ=
ing
> > the bootargs and initrd location.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > tools/binman/entry.py     |   8 ++++
> >  tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 111 insertions(+)
>
> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > @@ -745,6 +779,66 @@ class Entry_fit(Entry_section):
> > +        if initrd_name:
> > +            entry =3D self._priv_entries.get(initrd_name)
> > +            initrd =3D entry.GetData(required=3DFalse) if entry else N=
one
> > +            size =3D len(initrd) if initrd else 0
> > +            if size:
>
> If fit,initrd names an image that does not exist in the FIT (e.g. a
> typo - 'randisk' instead of 'ramdisk'), entry is None and the initrd
> fixup is silently skipped. The user ends up with a Falcon-mode image
> that has no initrd, with no hint from binman as to why. Please raise
> here when the referenced image is not present at all, and only fall
> back to the silent skip when the entry exists but has no data (the
> "optional initramfs was not supplied" case the docs mention).

Indeed, let me add an explicit check for that, thanks.

> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > @@ -745,6 +779,66 @@ class Entry_fit(Entry_section):
> > +                # Use the device tree's root #address-cells for the wi=
dth, as
> > +                # fdt_initrd() does (4 bytes per cell)
> > +                cells =3D 4 * libfdt.check_err(
> > +                    libfdt.fdt_address_cells(fdt._fdt, 0))
> > +                fdt.setprop(chosen, 'linux,initrd-start',
> > +                            start.to_bytes(cells, 'big'))
> > +                fdt.setprop(chosen, 'linux,initrd-end',
> > +                            end.to_bytes(cells, 'big'))
> > +                # Reserve the initramfs region so the kernel does not =
reuse it
> > +                libfdt.check_err(
> > +                    libfdt.fdt_add_mem_rsv(fdt._fdt, start, size))
>
> Hmm should we add address_cells() and add_mem_rsv() to the fdt
> library? We should not really be going into the private attribute.

Yep. Let me expose it publicly, thanks.

> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > @@ -302,6 +302,40 @@ class Entry_fit(Entry_section):
> > +    Patching /chosen into the generated device trees
> > +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The underline is longer than the heading title - please trim it to match.
>
> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > @@ -302,6 +302,40 @@ class Entry_fit(Entry_section):
> > +    fit,bootargs
> > +        A string written to /chosen/bootargs of every generated device=
 tree
> > +        (any existing value is overwritten). Typically set to `CONFIG_=
BOOTARGS`
> > +        via the preprocessed devicetree source.
>
> The docs say 'any existing value is overwritten', but the
> implementation guards with 'if bootargs:', so an empty fit,bootargs =3D
> '' leaves any pre-existing /chosen/bootargs in place. Either the docs
> or the code should change - I'd expect the empty case to be treated
> the same as absent (leave untouched), and the docs updated to say so.

Makes sense, will adjust.

> > diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> > @@ -636,6 +636,14 @@ class Entry(object):
> > +    def GetNode(self):
> > +        """Get the devicetree node which describes this entry
> > +
> > +        Returns:
> > +            Node: Node for this entry
> > +        """
> > +        return self._node
>
> Nice - good addition. There are a few existing entry._node accessors
> in control.py that could be converted in a follow-up, but no need in
> this series.

Thanks a lot for looking into this!

Best regards,
Alexey
