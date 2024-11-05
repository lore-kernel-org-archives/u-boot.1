Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96653D1CA13
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5500888F14;
	Tue,  5 Nov 2024 02:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q0DQH8lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B701C88FD2; Tue,  5 Nov 2024 02:07:10 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D26288F83
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbd550b648so37366156d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768827; x=1731373627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPpvXINAASwkJKHMUnqTsqFiZb7AGYofEpTYYapxXMA=;
 b=q0DQH8lxwrBo67HL/gK4WrzhCR6p/dPx8UaXj6rPcwD9p3kZzF4YGMNpDeVELfitJC
 A/fWRhsfSiRWNwWXcZwYl6ZMmWZdH9d4MIg0bPyNOSLmcJtKnZ4vCj0jKqA0Tk88h1MH
 RAlnhG/+wQcpP8wBnWU0zIa1H/YEoLmz/Hyx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768827; x=1731373627;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPpvXINAASwkJKHMUnqTsqFiZb7AGYofEpTYYapxXMA=;
 b=PQFbpMyZMGAm0oS4y1qDVOmvWpORZdNteO5k4y/KQ4XAuFsO1UO+kRqgfXKaN5hwf9
 QZJHbUtBXhvjKuPEkQ3M2EqltsVJ9Pj/mEJytu3bmaVgrXGl1X78vdxgDXuOXEjolZB1
 CY2B+5kJnB7BcyNDYRaAoqWjQaRGyTkpdGa43miMHVbXRHbz+Uv14F4kycMcwMeer1dl
 +uslCySvqg8VmMHMWXpY6YTffK3kpUzL3kequSw2+ExCVImXEqzukVcanAG/kIXa4A+C
 Gj0P1C0K1GvPFJy4Vt8EzHBtf7Xd+snQe4VprSirL5CiHRWjbpwNGrW+jWlLgA+cVo3o
 MSww==
X-Gm-Message-State: AOJu0YxIR3xtsH0kgp24FK7qhz/6uVsiuMKQYCuM4U7lDMIiXWzmOXvj
 /H8O+n9VkA4e/Dl7XNF6HsjVrAiqKmguonpGliwp0qZXMmMdUF4FLkJ3uJaP+Ck=
X-Google-Smtp-Source: AGHT+IH+t10lxZ2SZEIxKNfNCiO4oyinI5U+d3aGpyli8mgQXrBB01wkoWWgTYaOnjU/+FOl8kEXqg==
X-Received: by 2002:a05:6214:5981:b0:6cb:e4d3:10a0 with SMTP id
 6a1803df08f44-6d35c1aea9dmr222475396d6.48.1730768827488; 
 Mon, 04 Nov 2024 17:07:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Daniel Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH v2 1/3] menu: fix the logic checking whether ESC key is
 pressed
Message-Id: <173076882609.3917422.16645000092069467592.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 29 Oct 2024 17:47:10 +0800, Weijie Gao wrote:

> It's observed that the bootmenu on a serial console sometimes
> incorrectly quitted with superfluous characters filled to command
> line input:
> 
> >  *** U-Boot Boot Menu ***
> >
> >      1. Startup system (Default)
> >      2. Upgrade firmware
> >      3. Upgrade ATF BL2
> >      4. Upgrade ATF FIP
> >      5. Load image
> >      0. U-Boot console
> >
> >
> >  Press UP/DOWN to move, ENTER to select, ESC to quit
> >MT7988> [B
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


