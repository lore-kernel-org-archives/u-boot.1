Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28412FF60DC
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E623B83F5B;
	Tue, 31 Mar 2026 09:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aC+KQWdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAF984010; Tue, 31 Mar 2026 09:55:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872DE83F0A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so44680885e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774943699; x=1775548499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JQPCR6jt/Xi6mJj12VbTpZ7t527tMuKCIh3x3PzLHEQ=;
 b=aC+KQWdmWEiqLTyAprhIhR2p2pz2yTuP7KrhaGVum1gS6cVtB6lJRsDZH2GMTYvpxz
 cEHEwk6e8BeIUU00of8JtTMud9JDWwSja7oQOhVIplcIgOnCsuNhhkyjfidAImX7LKgc
 f+RdUHST4yVDJ1CJ0eDgPT7XtRDkF3AhqYnKQd79pvQ/LWbG7+qYiZZMGtlrmyuy+VE6
 rIM3uHs+ZWlt2FKRhI1nZ6EvJEO+ucFUvNF+tQXZhotVZRZK16rxre+x+6aYOYY8sgjR
 4gLmotRSjobL52IQHEAr8n4oVCfQgSboiNZMprX51iIMin+Q+sJk6ZKyk+CJrMzpbp9d
 2KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774943699; x=1775548499;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQPCR6jt/Xi6mJj12VbTpZ7t527tMuKCIh3x3PzLHEQ=;
 b=l/bjT5hNGKgrnqfhQXZdXbuDzlBcWVWlRSqayHo4vc8JAhxn3KjALe6r/08XzwXNhM
 Fg0SP+EbgMn2hPoh7136gGB/UYu0C/whX0Vsdv9NouXlKQr/ipCwBMDT53n5VMhKan+4
 vQp6A8GvRLA/ztAIzUoSCKLLVPImH/O6iFIQvg5pHAKa+EFBcPBthHO2PsWD9qBxIOAC
 MvIx3ztC6U9c/7CncuPVczqMhNzoFctn0gfJotAGVoTHeqegF0cRTcsyEDN9SAec5VDN
 YB4FX84W8uRZSgCCu2n16ioICmuCqjg5FUU+vIstwJPQ8ayWNJcpHehf+6WoRM/yil3/
 +2XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1ay/akzJgx0wfFaMZDjLzA9XCTyKo28M+Ef75yBeM0H1k0GPx3Gd6ekJzOlH86ufkKK1rO0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3NTLdWHCV2AyDSVfm7djO59D4gUv1lH/RynB8NhrHbYhjpMJg
 cJ7an2KFwYbkqgdTWXZc9LYVpIY36U/DrshlnDjjuDB3+luxSwdb+zRw
X-Gm-Gg: ATEYQzxfvFZd3+LIYS+SHy9a4baAEyVnxhmzrHiyY0xksmG+388HgufX8D2L77MDnNL
 jgu0rdfQ0tuftzpfSAMGJDH/a5fME63QyfWUsqWpsEeAC83kKT5v/KnDIBIK3Wew33w5nys1Lrg
 hN8hAIQnTkGUt5s3xKhbskQNz9L+zPe5fGtdJNeI/BvJy7UoDysVM63BQJAOOt2CTgX/7HiIjYC
 b+Hc2QbnvhCUg25Kh97VfLAF+WRISfalkL71eFm/es9RveUhwkUks9V1cG50yNy+myixpS9oa+q
 q81rr+6/++NqmbWUjXztvBVbd15bUzsNsH66qFQQJ2UY3VNIU4WI+g6xspWtO3XA+cBAxgwoP4m
 EwHD0IfRX7YWl3wuaxeTRW0B7rQeOBdtpLntXheeEGt+IFQ5ARZhbYgO0+jJI/pH3NX9Gh2LV+l
 GAYqF4pBGGl4tQNMcthiQOnFvpRR9zyPcjnmCR4GZ8ObKgV3cczgbk6w==
X-Received: by 2002:a05:600c:c102:b0:485:ae14:8187 with SMTP id
 5b1f17b1804b1-48727d594c9mr189776905e9.2.1774943698816; 
 Tue, 31 Mar 2026 00:54:58 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93c0cfsm18389555e9.9.2026.03.31.00.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:54:58 -0700 (PDT)
Message-ID: <69cb7dd2.050a0220.2aae7.7d3f@mx.google.com>
X-Google-Original-Message-ID: <act9z7ZV4xUgChIx@Ansuel-XPS.>
Date: Tue, 31 Mar 2026 09:54:55 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/5] misc: fs_loader: reorg and split to FS and FW
 loader + FIP loader
References: <20260317153614.18409-1-ansuelsmth@gmail.com>
 <20260330230757.GA1030901@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330230757.GA1030901@bill-the-cat>
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

On Mon, Mar 30, 2026 at 05:07:57PM -0600, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 04:36:04PM +0100, Christian Marangi wrote:
> 
> > This series mainly rework the FS loader to permit reading firmware from
> > container that are not exactly a readable filesystem.
> > 
> > One scenario is when a firmware is shipped in a FIP container as
> > a generic blob with an UUID.
> > 
> > FIP are mostly used on ARM in the context of ATF.
> > In such context U-Boot is loaded as BL31 and the PHY firmware
> > can't be stored in the FIT image for the kernel as U-Boot should
> > not depend on the presence of the kernel to correctly enable PHY
> > for Ethernet port.
> > 
> > To handle such case the PHY firmware is stored in FIP with a
> > predictable UUID.
> > 
> > One example is with Airoha 8811H firmware where the FIP can
> > have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
> > (generated from command "uuidgen -n @dns --md5 --name en8811h.bin")
> > 
> > With these example DTS entry:
> > 
> > fs_loader0: fip-loader {
> > 	bootph-all;
> > 	compatible = "u-boot,fip-loader";
> > 	phandlepart = <&mmc0 0>;
> > 	partoffset = <0x100>;
> > };
> > 
> > mdio {
> >   en8811: ethernet-phy@f {
> >     reg = <0xf>;
> >     firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
> >     firmware-loader = <&fs_loader0>;
> >   };
> > };
> > 
> > And PHY driver using the get_fw_loader_from_node() and the
> > common request_firmware_into_buf() it's possible to
> > load the PHY firmware transparently by just declaring
> > the required entry in the DTS.
> > 
> > get_fw_loader_from_node() is implemented to actual get the
> > loader from DT. This was something that was already in mind
> > from when the FS loader was implemented but then it was
> > never implemented in favor of a single loader per device.
> > 
> > The first patch is a minor fixup for something that probably
> > won't ever happen.
> > 
> > The second one is a good reworking of the FS and FW loader
> > moving the internal struct to a dedicated header. (this is
> > really to enforce what drivers should use and what
> > driver should not mess with)
> > 
> > Then there is the request_firmware_size() new OP to get only
> > the size of the firmware. Useful for case where the firmware
> > size is not always the same and change across different version.
> > (the patter might be get size -> alloc buffer -> get firmware).
> > 
> > Then the FIP loader as a basic parser of FIP. This only
> > read the FIP header, loop all the entry and search for a
> > matching UUID. If nothing is found then no firmware blob.
> > Very simple implementation.
> > 
> > This is being CI tested on [0]
> 
> Both "git am" and "b4 shazam" fail to apply the second patch here, can
> you please rebase on top of current next and repost? Thanks.
> 

Sorry I was targetting master instead of next. Just sent v4 with the
conflict fixed (it was the global declare dropped commit).

-- 
	Ansuel
