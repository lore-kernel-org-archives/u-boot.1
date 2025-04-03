Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373F4C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82C18214F;
	Thu,  3 Apr 2025 19:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i1EYdnJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A538A82140; Thu,  3 Apr 2025 19:54:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845BB82155
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac41514a734so207163766b.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743702881; x=1744307681; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIxmcK9FSTBPFL2FoF9PY8a2bZPCNWkrV+tlpiuvQWA=;
 b=i1EYdnJre5UMI7LbP+vDz8t4T7GDMsTn1W6MNz3z/UpYJr99zuQRv0ElLmYYE/qYwX
 YUaybq/IYTNHQQCFliQelYR38rpcazbB2aPYLyRxLDWHXM6xgO668mqhbIhfIUAZ3BSE
 SkJxMMWRrpoN2y2kuZlIhuJn5Z1tOWr/rMPyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743702881; x=1744307681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIxmcK9FSTBPFL2FoF9PY8a2bZPCNWkrV+tlpiuvQWA=;
 b=RBF1hBGQxl0MFdBKnzS9TD15igaMKLeetzsuE5u7GIBt4MvwoVkxQ8KGvX4fkNv1M1
 HjiJ6qw3V9cwqX23RHstmw6fr8ih1GMEDCvqw+WQzCAYW2onkWWuQRREGkSTeH5Q7O9E
 Nys2vMQ5LsfEkOp3tCV8N4wHVKXu3UOTYVue5wxWPdH4fFiaqw2JebQo9act4TK46tpQ
 4aosDr2rqKNZ4/N4AYZyATelnLZ3NAwyn3dOcHZHxKqhVaqKLpCVnU2TGpR1V9nxXO1D
 alDIgtLhCnQHlwkxE8ZqSlJm/C5g8oiE5Ki2clKExm0V//a9wCwtFC8xKCShutUJugA3
 fNSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRsKYMvD883JRAPuvEEhiDJgDSjiloTVx5XNTdJbYVzKeYfCS0UfC5v0wC2jVuAR/83/1LNtI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf5uvX95UB0EnMXH9whQkiNfYorYKnz6st+7UpVvDGnxC8HGYe
 NeNVfKruMmZQODfTFzG6rdFVkqcbT1PA9czh3AA4NAd4Rs7R0mJgZz8JE8TDRL2oql54DUUhzJP
 pLQB6c43fOxGzlZl47VgHKIelEoYaAiNPjECQ
X-Gm-Gg: ASbGncvzjOxtFxQu7sXhXshiQOt1wBf6GgHjtrEd+DeWz79bKwwl/H9A5q6X4CEKta1
 2Ly1qd2g5V8dQVz2CUjIuvr9BrWNGHWnZppo6Qlky8kgLp8p/IPJ+bgUEmlUxhoseHRi1pIYltp
 nesGhlipkTn8I3DJA2K1y7p3qI/mwg
X-Google-Smtp-Source: AGHT+IGJdLpdwqLD5wr8w7mQRUSsmGL6hqPOh5asAYZSswGMH0KqYsfr5amifX4h3DXuZUcPWFlmewCX3owKLo4kY08=
X-Received: by 2002:a17:907:7e9d:b0:ac2:49de:3969 with SMTP id
 a640c23a62f3a-ac7d190fe39mr44095566b.47.1743702880670; Thu, 03 Apr 2025
 10:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
In-Reply-To: <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:54:29 +1300
X-Gm-Features: AQ5f1Jrsn_8aVOawsCgUi-CERMXJi4vrYOwvDgkvo5ai0FZwoNPBvzX93njOPBE
Message-ID: <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_U=2DBoot_interferes_with_initrd_binary_=E2=80=94_Revert_?=
 =?UTF-8?Q?=22efi=3A_Correct_smbios=2Dtable_installation=22_=3F?=
To: =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Cc: Michael Brown <mcb30@ipxe.org>, u-boot@lists.denx.de
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

+Tom Rini in case this affects the release

Hi Christian,

On Fri, 4 Apr 2025 at 01:46, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> Hi Simon,
>
> > On 1. Apr 2025, at 17:51, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> but I don't know precisely what these various functions are supposed t=
o
> >> do, and I can't find any path that leads from any of these to eth_halt=
().
> >>
> >> Is it possible that U-Boot is failing to call eth_halt() in response t=
o
> >> ExitBootServices(), and is therefore leaving the network device active
> >> and performing DMA while the kernel starts up?
> >
> > The dm_remove_devices_active() is supposed to handle this, but it is
> > possible that one of the drivers lacks a remove() method.
>
> for what it's worth, this is happening on both ODROID N2+ (meson8b-dwmac)=
 as well as NanoPI R4S (rk_gmac-dwmac).
>
> I also don't understand why reverting 06ef8089f876b6dabf56caba31a05c003f0=
3c629 "fixes" this behavior. Does it mean that any memalign / malloc may ca=
use this?
> Also, how can this failure mode be detected and prevented in code?
>
> I really don't fancy the thought of remote code injection into Linux init=
rd by spoofing Ethernet packages, but it really looks like a possibility.

Here's my idea of what might be going on based on Michael's observations:

1. designware_eth_start() starts the interface and
designware_eth_stop() stops it

2. tx_descs_init() sets up the DMA and uses the device-private info
(struct dw_eth_dev)

3. When the device is removed, the struct is freed, meaning that a
future malloc() can use that same space.

4. DMA traffic could then write over the malloc() region

I'm not seeing where the Ethernet device's stop() is called. The
dwmac_meson8b driver does not have a remove() method, so presumably
DMA is still running after the device is removed. Probably the correct
fix would be to add a remove() method to that driver.

Regards,
Simon
