Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E3E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD0C8414B;
	Tue,  3 Feb 2026 14:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ubicomp.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679CD83F53; Tue,  3 Feb 2026 00:50:17 +0100 (CET)
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com
 [136.143.188.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF4283E1E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 00:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ubicomp.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jian.zhang@ubicomp.com.au
ARC-Seal: i=1; a=rsa-sha256; t=1770076211; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MOypGA4vJXhZRwsMKQf27ne+jFSVtxudAMF1fAJAl7sXyJAwdDY/Ugty7Ryaah7QQcaaCPdhViWDb+ma37NKJcQ5YCHK53viEwWEWlE6o1MDq9/gJzYRGK7/QHAtXtMoJuYF+KWmKpd9tUjVDZ3MpSwPe2ZYx4ZoUR1RMkZcNn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770076211;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=XD/eW68Ae08XmL0VdVNOU7ytIocTpKi+DyDYuwlmnzE=; 
 b=VUStQxT39k3WVvEGDOU8zToVdT/cTOq8EKoUSqUrbn3cKaXMKdg1g5XYqEyjzdi/fpKJlhbGLoYOA5g61RaWY2vGqgAChuS9cQQGyuSuWhagvwfO6fDa+x/b4FgheCDkR3/o97omdIHJVSw7EjtcrlH25VPby9pv4LW4l40PICo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=jian.zhang@ubicomp.com.au;
 dmarc=pass header.from=<jian.zhang@ubicomp.com.au>
Received: by mx.zohomail.com with SMTPS id 1770076208575194.61731333101375;
 Mon, 2 Feb 2026 15:50:08 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6630d0685abso2646965eaf.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 15:50:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzKAHJQzux5a2YGzz6DsrytUoPI87uuHefGS5Ex8fH41qTcnNGr
 +u17WwQLrbaHximsr94T1fvDggSVWkBR2FnprZNs7sTqrineWlna+jWvIqO5IqDMo0RrU++zXTE
 klCg+7qfwnis21dn9rSD4upVNey+dpqg=
X-Received: by 2002:a05:6820:1886:b0:662:f8b0:60ff with SMTP id
 006d021491bc7-6630f387ea2mr6502784eaf.62.1770076208096; Mon, 02 Feb 2026
 15:50:08 -0800 (PST)
MIME-Version: 1.0
From: Jian Zhang <jian.zhang@ubicomp.com.au>
Date: Tue, 3 Feb 2026 07:49:57 +0800
X-Gmail-Original-Message-ID: <CAOcTRc-rWaX-wJOETDus+pQovNOxxFHSOQnp3RFQ-DryG+qjDA@mail.gmail.com>
X-Gm-Features: AZwV_Qh3CXWfimY9iiyQ8EJ4PhPG1-5qhP0HRjy6nlvQHI_UrMopEGqzSJiW_N8
Message-ID: <CAOcTRc-rWaX-wJOETDus+pQovNOxxFHSOQnp3RFQ-DryG+qjDA@mail.gmail.com>
Subject: [RFC] sunxi: video: Porting sun6i-mipi-dsi driver from Linux v6.10 to
 Mainline
To: u-boot@lists.denx.de
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

I am working on U-Boot mainline (targeting the v2026.04 cycle) and I plan
to implement splash screen support for sunxi platforms (t113s) via MIPI DSI=
.

Currently, I have mainline booting and loading the kernel on my hardware,
but I lack display output in the bootloader. My plan is to backport the
sun6i-mipi-dsi and associated DPHY logic from Linux kernel v6.10. Given the
shift toward OF_UPSTREAM in recent U-Boot releases, I intend to leverage
the existing kernel Devicetree bindings as much as possible.

Before I proceed further, I=E2=80=99d like to seek guidance to ensure I=E2=
=80=99m not
heading in the wrong direction:

   1.

   *Ongoing Work:* Is anyone else currently working on MIPI DSI for sunxi?
   I want to avoid duplicating efforts if there are existing WIP patches or
   branches.
   2.

   *Driver Structure:* Does the community prefer a minimal "U-Boot-style"
   driver, or a more direct port of the Linux DRM bridge/host structure
   (similar to how some Rockchip DSI drivers were recently integrated)?

Thanks and Best regards,

Jian Zhang
