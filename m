Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F66C5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82AE34069A;
	Thu, 27 Aug 2026 08:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsCYNPcWuM0S; Thu, 27 Aug 2026 08:35:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787819754;
	bh=tLhIUIiWjocAsveeSXgFU+iQUIeBJ/NspIoO7jFygQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l+niD3qGHZvkGWRQjei81Bj+HQQqA9/XoH1nt4jKxsZIMkILIhtDt9dVGIzMDrrMa
	 gb8FwbHXtbBfrBsfhRUfDhVvKXKlsUKf9ZuveHqDumKe0/BIaNIG4n2DBEY1DO+v5+
	 XoAWIZXB6e/8BYy3LAH41Yje9R4+wYFC0/EXxQMBnFUkjLFLunmXBTHXK0rhGPTSIO
	 xqJukqc5ktj6Ei2GTQWXWjLJiAPOLfLDX9/WkMXv50bRpMY9cPa4FCsuyJhIq2GZuR
	 Zo6VRwFRxbVaVscREtWsY6zfIN1vdwR69q9rtq/m9T0HdMF2XPec3C+Fg0J0Tdo0Ty
	 vJBxyeeEB3Wzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CDBF406BE;
	Thu, 27 Aug 2026 08:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B007E78B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DD3760765
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mf_84PymQHCK for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:35:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=PWhKCf+T
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7467960698
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:35:49 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so526297a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787819748; cv=none;
 d=google.com; s=arc-20260327;
 b=V8o6lgQNpdz/RrzFiheBIMFkqlJtXp5R+s7NwFWAHE1ixkYayn933tVlNzCcsv1gYq
 Obw2U+Vi6DMScQ+DUV0VlSqX9EB88srKGoIj4aDP8TL1FtxobcHGCp29kbXaLtnl+cYt
 FClXKhaMI2gowSUfoS3CX77iELf1rHEiFIbmLtHdWm2tcsA2EoI4b1OFeP9+zsyAVI7+
 2DZcAuzU+JSEymm1dUTXMNpovIynTMYUToEm46NzlRVANJb8r+9DCxoeFR5ynlrM0ff2
 Q4f9ctA1lLyFbuHMFpYoHxyQkaLQMoqoAWw7p1fYoI1E/PdlPdbCuHFXqppbuV87ylzz
 w0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tLhIUIiWjocAsveeSXgFU+iQUIeBJ/NspIoO7jFygQs=;
 fh=1G2e/UfVT6whcjfJp93R2plvwWbq0KHex67HT6Up9e4=;
 b=U6Z2ztMxsAIAXpZuaZE/uMOdPyhSA1aR9OMwpg5Tdo5TEaO0BtlSB5XSpzdzmbXATd
 Fny/tr1S+7I4zWHKdfSQ1WFGYd1P5pSr2TPPOmT80nclJcPCsB6vEQvr1tS7+D9z6l+J
 G7E/5jBwprYZTxZ4WUBbjTG/+zYG3SM0S9I3Ef6D/qCTJkpSKzSLQi6VVrYtru3ErRnk
 s+EVQPbLGdpWFdF3E0qTCB3d8Gq8OstXKrB882MVXQlazFYXRkFXePJp9WHDODOVjFX5
 bL1wVUt7Ii8rNKO6bXbyyAe0TCDGJvC2MVr1yv0mOOYEZQq5hUZbJUB/2PYeSQJjHBkH
 oIAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787819748; x=1788424548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLhIUIiWjocAsveeSXgFU+iQUIeBJ/NspIoO7jFygQs=;
 b=PWhKCf+TZdnf1GlkV7JeLEISvqi56PpBXqwQhZfQRsDEFxDnlofYm//9upG5J2UPO2
 qLblgHhmtOKBnZce3cd2LuX2Xvd5o97V6sjY7+2O/0gtlQ/1lEh+4OOkU2U+8sf1Vhs9
 vzsBLvJUfuibV5U5wbv6j+8l6jJuppfhL4jcWq6p4E7rh9TR4FvTKOpK7+JpoNdvshuN
 aBalqggrbVeiXR/8WtMlpV8hte8PzjWAEZJbPtbrPdKo7qJ/FA367xU3stYUr/LkIf8t
 Dm7Ht1pJbPCCdqSNDX698J2Hc6IUSdYag+3Y0daC2JG2wAm2KjBXNKVYLdLlel2T23s7
 +Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819748; x=1788424548;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLhIUIiWjocAsveeSXgFU+iQUIeBJ/NspIoO7jFygQs=;
 b=fGw1BmDCehFsz0QIhzQ91l41lrgXisGA9Ipcf6Nz7ZtcRTIw8FiTEBpOmAqb5JNx+r
 BO88AKaWn2pH0gcfnszxPUs8ZYGrpz04UXtUGejusWvnTZKEDH6OnX91vWwS7OkUYx3D
 bsqaheXHcrqzf+Ly2wzGOd3g0cCDDk4XyUSrxfOe4LoWDcBpSihmUJVxHw5EuzYiRQvJ
 wzfS3vC1OBtMCw8vWuaGN7sBlXPiYnlqPLBqI4dmjGM6QHUvmwxbQThzVlFcHY4Xrubw
 sEHCy5CwfxHUbjkM9WAI6YU6mlObEq9aSrbI2q02J+0AJmpMZcGyJi1K28sHJHDEl0mu
 a+5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHCW2UIw+aB5yMZVuvVcdCGO5EtmsJH+jokL3SuOZSdA+pfIh/cviBmgFMeWDbFfaK8vgVZKs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mGmhZBgQid9+6b0FlyheJEdKmvrIR+eLW+VCQ/ZxwvvXUF/n0z
 XCbIbwZtZYFkfcoUsZkM8fwaWtCLA7kMWqlnHaeL08GHsFmGvipckH2mAzFpKvPuHZEzAbQPLRo
 VpcOWB5GlgWfS46lwOuSQ7yRd8GrTcRnd36as5utlyA==
X-Gm-Gg: AR+sD11jJd3of4NOvovbiurvNv3vcJBdaTera2wDxMlvdt2GcIwH8+sblwarIbwLaLU
 bQDW1TXKZG0J3kcLK9+ZgktdOwsvzzQT6nrfQs38mVq685Qe2HhAegQaGg78esDJB/6RMGPYwuZ
 UAVI38jV5ju17qLjRlcV9Tg8sn0YXQYlQ2l/+5A6uzGKyje4c6TF12IkF4CxMvKkIhI4i/MFANd
 dJW4u2UE0Fu8oxLNXjjN44yjS4W/51UT6s6/XK5ofwLPtqT6nI67Q7VJIFlV7EurJ5tskhz2K9x
 /uYZ7vTorBAdXira8K6J/Fjkz+nIpq0YqHlTotKj/mDzAkhdAfgkZb4cS6sqlpN0VFuz3Vw+waT
 6QKB2EAYKF4Sh
X-Received: by 2002:a17:907:94cd:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c250c35241emr1238957566b.23.1787819747649; Thu, 27 Aug 2026
 01:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
 <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
 <20260825194528.GB523975@bill-the-cat>
 <CAKTNdwGJfC=11vdSzL1wbE5WTF=4S6HS+DYMzJqYEQxD6kThGw@mail.gmail.com>
 <e3e03c35-4a17-4d0e-8bf3-6c3d47857851@gmx.de>
In-Reply-To: <e3e03c35-4a17-4d0e-8bf3-6c3d47857851@gmx.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 12:35:39 +0400
X-Gm-Features: AcwNN1WUTyyyq0K_hNof3t5d4ZbIrP1v66BvjMoM6T7koHtLAhaY43o5ZUTZ_Rs
Message-ID: <CAKTNdwGmskh2+cLVmOGTmWrFhhGR=v4qF7zR=rmxScY6FOO55Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>
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

On Thu, Aug 27, 2026 at 12:25=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 8/27/26 10:21, Alexey Charkov wrote:
> > Hello Heinrich, Tom,
> >
> > On Tue, Aug 25, 2026 at 11:45=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> >>
> >> On Tue, Aug 25, 2026 at 09:37:43PM +0200, Heinrich Schuchardt wrote:
> >>> On 7/31/26 14:40, Alexey Charkov wrote:
> >>>> part_test_mac(), part_print_mac() and part_get_info_mac() each decla=
re a
> >>>> single-block buffer sized after the descriptor struct:
> >>>>
> >>>>      ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> >>>>      ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> >>>>
> >>>> Both structs are 512 bytes, but every blk_dread() below them asks fo=
r one
> >>>> block, which transfers desc->blksz bytes. On a device with 4096-byte
> >>>> logical blocks that writes 4096 bytes into a 512-byte on-stack buffe=
r and
> >>>> corrupts the stack.
> >>>>
> >>>> part_test_mac() runs on every block device during partition probing,=
 so on
> >>>> sandbox with CONFIG_MAC_PARTITION=3Dy this crashes on any access at =
all to a
> >>>> device with large blocks, for instance:
> >>>>
> >>>>      host bind 0 disk.img 4096
> >>>>      part list host 0
> >>>>
> >>>> Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_=
PAD(),
> >>>> which is what part_efi.c already does for its own block buffers.
> >>>>
> >>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>
> >>> Modern Apple Computers use GPT partition tables.
> >>>
> >>> Gemini claims:
> >>>
> >>> Because APM was functionally obsolete by the time Advanced Format (4K=
n)
> >>> drives emerged in the 2010s, Apple never updated the specification to
> >>> establish official compatibility guidelines for native 4 KiB sectors.
> >>>
> >>> If Apple has not defined how to treat 4 KiB sectors, we should not tr=
y to
> >>> invent a scheme.
> >>>
> >>> Apple has already deleted the documentation of this outdated partitio=
n table
> >>> format (http://developer.apple.com/techpubs/mac/Devices/Devices-126.h=
tml)
> >>>
> >>> My preference would be to remove this driver completely.
> >>
> >> Yes, this is another case where we can just drop the driver and if
> >> someone *needs* this for something, likely emulated, they can bring it
> >> back.
> >
> > I've sent a separate patch [1] removing the driver altogether, which
> > Heinrich has reviewed already. That one is against next though, and I
> > believe these fixes would be great to have in main, so I'd rather keep
> > this patch in the series for 2026.10. There will be a "change vs.
> > remove" merge conflict when main is merged into next which will need
> > to be resolved in favor of the removal. The upside is that tests don't
> > keep crashing wherever a Mac partition table is probed for with a 4Kn
> > storage device.
> >
> > Does that sound fine?
>
> Nobody seems to be using the MAC partition driver with 4 KiB devices.

Sure, but the probe runs unconditionally whenever the driver is
enabled, and it crashes then even if no MAC partition label is found.

> I would rather drop this patch to make merging next after v2026.10 easier=
.
>
> Maybe Tom already wants to drop the MAC partition driver in 2026.10.

That would work too - I just thought a deletion is not appropriate for
the feature-freeze period.

Best regards,
Alexey
