Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CEDC5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C618B80851;
	Thu, 27 Aug 2026 08:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9pnh2QIKCXj; Thu, 27 Aug 2026 08:22:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787818928;
	bh=oXzOItiWco7Dy8z+uypH5SP6Fi7BWC4EcCTEZWTx6xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qPjUNkrDuMYnDUSzAzIYOMTeo8F61WddgL+E9ULJuP1tXFCngwByaUKH9mR2qNI6U
	 sIRJYNdj9leHuIQzu4JHWYDn/mS9PA4v+l6NACnF2UrHSJAaode2WjG7bOlGEKSCrq
	 NaBS+Vt3esNy+VwTEUVXLVFzgen462md9yc2SIdOekd0/7GSh9p/rnZbx3ElQO0eX1
	 9JPoJftre3RmFVYMC+Y5qh2XrZKwy97hMNmRDIRLddTLa6qaL/M1UBiYcnuXVyKkCx
	 ztwzsDcRViXW0gS59eoqUNwb/aYT/RJ++f1V6d02fHXqq55fRLbeh9XTCj8Fyc7hPb
	 HUOCtizXOwm3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAF348083F;
	Thu, 27 Aug 2026 08:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A310C7AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8370E60765
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2uOee4ffVxU for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:22:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=e/IjvvPA
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A5FC60661
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:22:05 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso126486566b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787818923; cv=none;
 d=google.com; s=arc-20260327;
 b=oFx5adyg+XviA1Gu8KWTUaa4pRBLA3BvYvQXwwn090koZ5XnZHIGVClOpiq324hWSS
 eYL2bScKApc/HRRlQnEBIIe9opTghjO7CD3y7tHnkkMnmUO2ClYYuchHJ5I1CI3T8M5K
 8uzu8qjygMgBohInc3M7FYOQvkrvkLx+kBxHQudSO+jqGErw3Rjq/EFkamfqRMesQjRi
 LYDVyh7fQy7Ez42NjF0Q2jP/MxatDH1g5n4GyUzGYrmTXHJePGPDZB0j/UJFc/R+GZOh
 HYt6PWsyOlSKEndyIpfhZtWb73ivHXX+9M8D8m/8+qoSNgr3Zoeyq0ofL0+P3zP9w1HD
 Swxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oXzOItiWco7Dy8z+uypH5SP6Fi7BWC4EcCTEZWTx6xg=;
 fh=1qVgzqnnOEG6PkzGvKPeeKqgsBl4RE23x2HfQkQau/4=;
 b=F0mqFWj+veOnpW5xh/ZfAIbpAS/0l4CyWUkO2BzHkCXMqocyT+h0qvmJbUdsyQI3A1
 tnEUinxATmyS1bg80t7RMxln+uYTFWw8Y/uvbItSyWKpeJvv3RByhNfzBSp2b6v9JXKb
 ZtjSJ54K/kAo6I1JBBYUsk0chOLuog6/gRRerObwDuu734Hj1tbzUQ8BOwW4oKuJ9Zv0
 WqVaVepqu1WUeu67/8/gtbuFQyUOLtUwW+j2rFL+dIUJ1ZnxCssj8M1m+CEYP/51MKjC
 kCmvG9Cka6WCHg/mA/npgVgmE1Kl3SY74E76fHlqeuouY5kr5OrWyNZsjGkHIAsXaTYe
 XAxQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787818923; x=1788423723;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oXzOItiWco7Dy8z+uypH5SP6Fi7BWC4EcCTEZWTx6xg=;
 b=e/IjvvPAadIzcixLth1ZAAey1SN5sLg280YCOkfodUHu8iWF7qQW+Lav1T2W3o0vrr
 cFmNYwD5OPi+V6uI/AqArXhgMqNsiIvbi4REULCR/R4E5/SLtQaQHI7b1O6ctYF0s1P1
 gMXR/j740m1kQS2ZZdsEQ73JlcM8MbLrPpcQoRAVj63QeCABpmBsdvoNOYkYE5bRuAIa
 UNGbXL+vy/aX+VsnkxXA9AOAMSiOwGAarcnzpkf+gJiy8hY0HbG8p4dw6nDimCmpwLLU
 KsnrxTQPxu/XUYHLJdFzK6DnpBL3zM4nyiXo9FHIgLYTZ7tUQGp7mFd39e/9j5iIEXMt
 nHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787818923; x=1788423723;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oXzOItiWco7Dy8z+uypH5SP6Fi7BWC4EcCTEZWTx6xg=;
 b=fc+y5maBTBGLSwhhyX693TdJ2YsnPEmJ4znogTULlI0QiNd3RpbDEGEHpZtDNu3u5w
 CRWxMsINggIlkv8qfi83gYJuiurqKvyM5MThouyDMP0MZIAf5V+zJQ9k1/1/igpw+xTA
 5TI24sU3ep4hJw7REBZ+X9eiFzIj+hTDM3KR8Gp2mR1k+uMZzpwebD5CJmrQtBlhWufD
 /CzNJgUxP5Vc7/5VZPzqfX1x0B3LI5/vJFLjsF5xHuzZDgXaeBI/QTC7NMg3hdGpi5TU
 VzKSexciUC5wUWnPZEGHJrR3g3hm+Q9d08+0NFW+rL6n/F2PXBAenx0qBsG6WrK5o+a0
 MGRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFhThHiMRqnNy4ybmukU49jSZGu/FpTHZdi9IzjBksDVlLyXUWTkl49Z/qVlo7myPQ/Mg+sPQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mdS/tDBLkZn+gGkN9BpZJsgJuiZkMb38fBLG/i+8T83PXAxUkO
 /tTQDXkp3tHhJL73y27Vj8H2mU9H5awIGxe0uXN0cyGBEravg9Xz+PkJp02GBYXrLEle+ZpE9bF
 eYLGT5e3lDwKtaDRLG4J9Bf0i/dRLs8FMz9m7mTCEbg==
X-Gm-Gg: AR+sD133w6HC2igd4dxIEKQMPb8IY6TYp2HPxrqoh7k5BEXBP37Hq6qQkzaBk55KO3+
 I92MCULmNbtAqzfxcYn9EZQD/NxaU7YapL5x9mLcnhZj5lxg4MVBeOyrdpHDu8i2EaEQJx8VnWg
 EdmqlD4q9lOVDZOqtFJpCZ9G22pFlNKu6WARwhLsFZm1LTD0WNwOP3pojyQOL+C26mH39Go8qlg
 mGhAAndjOu0OPVKuVnxdKDBBHaifslvr2C10raFH8RB3RUw5Ko6hXnY6/7Z88jSymCFYS0yeuV+
 Z6Yk2ZYA5g+3XMGWWWMppHxthy7vu8CfQYTSan26pkT/A9MGHfPgY6OAVGOxtXMiqsfYurROQMZ
 J
X-Received: by 2002:a17:907:ea7:b0:c24:cc3c:db11 with SMTP id
 a640c23a62f3a-c250c362e7cmr1327614366b.21.1787818923460; Thu, 27 Aug 2026
 01:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
 <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
 <20260825194528.GB523975@bill-the-cat>
In-Reply-To: <20260825194528.GB523975@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 12:21:55 +0400
X-Gm-Features: AcwNN1XSy6OfeU3zPR-kCW1kXcZD5AIJbjiryyzb2VXrTNmf46xg_rZlE3mzcWc
Message-ID: <CAKTNdwGJfC=11vdSzL1wbE5WTF=4S6HS+DYMzJqYEQxD6kThGw@mail.gmail.com>
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Burticica <mouse@ya.ru>, 
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
 Patrice Chotard <patrice.chotard@foss.st.com>
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

Hello Heinrich, Tom,

On Tue, Aug 25, 2026 at 11:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Tue, Aug 25, 2026 at 09:37:43PM +0200, Heinrich Schuchardt wrote:
> > On 7/31/26 14:40, Alexey Charkov wrote:
> > > part_test_mac(), part_print_mac() and part_get_info_mac() each declar=
e a
> > > single-block buffer sized after the descriptor struct:
> > >
> > >     ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> > >     ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> > >
> > > Both structs are 512 bytes, but every blk_dread() below them asks for=
 one
> > > block, which transfers desc->blksz bytes. On a device with 4096-byte
> > > logical blocks that writes 4096 bytes into a 512-byte on-stack buffer=
 and
> > > corrupts the stack.
> > >
> > > part_test_mac() runs on every block device during partition probing, =
so on
> > > sandbox with CONFIG_MAC_PARTITION=3Dy this crashes on any access at a=
ll to a
> > > device with large blocks, for instance:
> > >
> > >     host bind 0 disk.img 4096
> > >     part list host 0
> > >
> > > Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_P=
AD(),
> > > which is what part_efi.c already does for its own block buffers.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > Modern Apple Computers use GPT partition tables.
> >
> > Gemini claims:
> >
> > Because APM was functionally obsolete by the time Advanced Format (4Kn)
> > drives emerged in the 2010s, Apple never updated the specification to
> > establish official compatibility guidelines for native 4 KiB sectors.
> >
> > If Apple has not defined how to treat 4 KiB sectors, we should not try =
to
> > invent a scheme.
> >
> > Apple has already deleted the documentation of this outdated partition =
table
> > format (http://developer.apple.com/techpubs/mac/Devices/Devices-126.htm=
l)
> >
> > My preference would be to remove this driver completely.
>
> Yes, this is another case where we can just drop the driver and if
> someone *needs* this for something, likely emulated, they can bring it
> back.

I've sent a separate patch [1] removing the driver altogether, which
Heinrich has reviewed already. That one is against next though, and I
believe these fixes would be great to have in main, so I'd rather keep
this patch in the series for 2026.10. There will be a "change vs.
remove" merge conflict when main is merged into next which will need
to be resolved in favor of the removal. The upside is that tests don't
keep crashing wherever a Mac partition table is probed for with a 4Kn
storage device.

Does that sound fine?

[1] https://lore.kernel.org/u-boot/20260827-drop-part-mac-v1-1-c81ede492be7=
@flipper.net/

Best regards,
Alexey
