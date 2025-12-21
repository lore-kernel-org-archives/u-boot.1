Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1C1E66886
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 04:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703638397D;
	Sun, 21 Dec 2025 05:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="C5OIhJL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3ABB8397A; Sun, 21 Dec 2025 05:37:40 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386258389A
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 05:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b736ffc531fso535311166b.1
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766291857; x=1766896657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jvaxORZMYT22EcLFWbhwqatZQ1trN3S4ZiKvBnezGlg=;
 b=C5OIhJL+6numiWyEwRobTWmAgeqNt5UodCOIX2jvqjdOyUvyfxuPAjCxnOO02I5G2g
 vDp9Qla/6A8kFcGIUamC2ccOR94Xw9bBBcb1286oIH9GG8+KFQNQYWm0MMeQfqiZOEdO
 uiU8wy/ahuIYuCiv8XBB5u5fCUP1P48GElgrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766291857; x=1766896657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvaxORZMYT22EcLFWbhwqatZQ1trN3S4ZiKvBnezGlg=;
 b=v0biIyxnQydKIZDE2+cjaMNyRpBqk/0aVGxYejexCRE32PH5kdMr0rV5qTTe93g9kY
 IJJDVCcQVuqc8dwgvopKq0IYbC3aCipJtUUl4QdzjCFNnuG7sHaCGVJEfEbXdL+1Ik50
 D743GudLwZvFTYQ+CI1FvnDpIPEVTCdXUi4QkHZBoy59AfnY9rdZjGKkIj86HRzhXL/0
 IepX0Q9V/4fhRurjlCGdjbdKBdMm1cPRcJV5izhLd2MSinh8bA6XAerd/jbOnncPnSaZ
 Gw98sOpNDznNHFRCiakijxscnNEA8lcTQnojQxkt2ZULrjjtfGWfs5+6zE2go4XdaE5Q
 e3EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2e9E6k6qF5JtSDm/CnkusKaZomj+0Jcrlvc4FqCm5kLgtfRXAE4X2NcvEEqS4egNb2J05KPg=@lists.denx.de
X-Gm-Message-State: AOJu0YyH3TUMD1Is2ge680RCmbcyJ4xJ0tMFUWiIZW1LI6bSaom+0/OI
 daGm2dlEmWd98O+VfzJn1JcYTwTNw/1tNCyP3umcfu+eisQogrIyA0VcK/FY7Cnj6JhkHEvhKOQ
 xPK3rqWy1w+5mz//990JVEbg1BJDGFqXBt+rpr2t6b1f5d2/axTYN
X-Gm-Gg: AY/fxX4KH3PsHFrgX9S7JOKzI/akzKggGTgObJY+nR/Dg3ow68oEfKdAjHsCXdmbnIE
 KEiKpcaHsaaya5/d4tDPSLrOTs3bw4pVs2zWropPNhb8gPFdkwjw1ccMVlFjPYynUZVLaQpz2nJ
 jRwVbGX9ohr9J+1QyHCQxCHQ3pvTqRqfyKVrjs5qcPfycywEprwY8GHirVOq4+bVcQQYoKrELgD
 4kAICifm8hDqW73uqMltGQ2+VjrbNoLq9E/avh90kXbmsZpA1B8PPOiJODO2BIOkNdEa0XT
X-Google-Smtp-Source: AGHT+IExa0qEOlLpAzqnyZAbMiCa3zDElvRdZ+LIT++mpuOl7m0axa7YTe2xSmp7iyrB6TplTlI6WThf8iNJK/xRJ4c=
X-Received: by 2002:a17:907:9444:b0:b7a:58ab:3de1 with SMTP id
 a640c23a62f3a-b8036f13014mr846333766b.20.1766291857027; Sat, 20 Dec 2025
 20:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-4-visitorckw@gmail.com>
In-Reply-To: <20251218185252.957388-4-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 21 Dec 2025 13:37:24 +0900
X-Gm-Features: AQt7F2pWocNkZRzqHyhnOzNf1ebbxD6d_8NLnaDkeIWAPDzhEkRokwABUiubjPY
Message-ID: <CAFr9PXk5x5RczuE95A64EVu+i_DwWd2hUdU2Wv1dUrwfppJwtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Fri, 19 Dec 2025 at 04:06, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.

Since I already have this setup working and able to boot linux I will
add some input:
- The virt machine can use any supported CPU type, even 000 without
mmu, you should really handle that.
- m68k linux for mmu machines uses "bootinfo" that is a structure
after the kernel image that the bootloader prepares so linux can work
out what CPU etc is present. QEMU does this as well but it will be
after the u-boot image now, so to boot linux you must save it before
it gets destroyed and when the kernel is loaded copy it to after the
kernel. I use ELF images to boot linux. I have a hack in bootelf to
put the bootinfo in place just before jumping to the entry point.
- Since QEMU gives you the bootinfo and you need to parse it to work
out how much to save either way you should use it to detect the
selected CPU in u-boot. If the code is built for 000 it will run on
anything and just needs to handle the differences in the caches. In my
setup I fixup the cpu compatible string in u-boot's devicetree and
then use that to work out what cache function to call for the current
CPU.

Glad to see I'm not alone in messing around with this. :)

Cheers,

Daniel
