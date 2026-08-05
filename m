Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A50C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 22:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 988A180E01;
	Wed,  5 Aug 2026 22:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y__33wbLKu4F; Wed,  5 Aug 2026 22:00:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17D9580DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785967210;
	bh=rJQd7cP9xH8Dmhhu0WJkKmzkeBIHrB5o8aCJupVSLdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M0y1j3+czFBynHOr9oJjZ1SrQwxRfKBr75iRaueJ4zR7W/hBsviWjHNHV5Vt0FF4y
	 h5chmyC0Lqbd+tMV1KGWP4Ko/ZvEzxTh2j/mSZxuga1AM0It33nsG/HQS09nqSsqlf
	 0h9CMAT29swbr6uixGJN4KM68YgCDVXqVfVhzClvsIiwBAVB+R4lSgGHr1/9KgWhwS
	 vRhnLKPH1zbmaB5Ns3bFYGvPO9p9UqHhQWKoyeP9xAQGx8WJCAC46e8N5JPkfkaY4c
	 Lf9trYeKuDn5ZHwz3ixR54GF/l1jOE6Bnejhac+81y4td+esKvAxp7ztFZ/bqNtXAx
	 e+jDJCLJD+lsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17D9580DDD;
	Wed,  5 Aug 2026 22:00:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21B6D218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13F48607F3
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fo3681gJFFa2 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 22:00:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DEEB607EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DEEB607EC
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DEEB607EC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:00:08 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so1230196a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 15:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967207; cv=none;
 d=google.com; s=arc-20260327;
 b=UblOiclOfAwD7lJJaYyTb/LcIuXnMK+v2qQ05UivPMGoHOEnuoK/yA9sukKLrQzJDZ
 r2RCdLAU9elUrGICiASqcQ66DakNWsXoFa+EqtLHPlyHxFp7QzPZp12Z/RNHZVFWveXd
 UDYlxv5U7BBX3aMooHRZiIBctCGpuqU+V+NvnoxGl/Rb7Ve6eNxygijk3cNVGX9KbdsH
 lXhgKJSHY1IlxY4L40q5WYYNN75a6M2iHJ+DyNwuQ1nAuDc0RScRr2s/GRNMoUbinVcw
 TTmHRYmJHoyBX91j9fnMUJKMvWu7fY2WV7pfrib6/tbydT5DaaXmL15mHYg9DRkNogRo
 IqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rJQd7cP9xH8Dmhhu0WJkKmzkeBIHrB5o8aCJupVSLdM=;
 fh=w09VALJ2HAUXfuyBvXzNdt2wc1+gedBlkDcU88B30nY=;
 b=fr7icpRICr/4JD3LxvhgkmqZv52R4i74ILYaLsmYsTAUEzEF3kyArazsDz3YgA61zs
 AoB97qdfoLoklAJa03ubC0EFwxedFk7B78trQGqZ1YX/E2AJ+DmHxy7b0HgOEW0rJPgD
 UhDaQgv3yxskHetCdErDAmu5n3PKkdmtcj1ApksusjyWK6p1On5N66QugjvnGOdNgp0N
 zxszTRO9evURqCBUD5m6aYE9dPKN3yr3YewAI2NPw31HVLwgcpwxbMAAMVJaCfYIHaQP
 pKpt4s5jwjljt8T8CZnIpA3T8b8+kmc3fMdpJltDz7ea0D/6U4zmNMo6AP/424qjj+Ya
 aWIQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785967207; x=1786572007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rJQd7cP9xH8Dmhhu0WJkKmzkeBIHrB5o8aCJupVSLdM=;
 b=BKniPcVK1T+KgOfApDSXVRmq3q85c4uARi6NjewyhGBprY3VXRjCYhA2CGdCIZ6Orz
 I3elyIDnaNR/pjtXK8qEV375UWr5+gJDYdEEK05wo6KJ17my0JCLT1/RYhIiDlz5eRa1
 y9Pr3LvsMYRuoOsodaDDAOjJ0SRbJzo9eG3rLS4XPtITs44Z1MSjxH1xRxLegIBMuxEd
 f58a3thbAkcth9iQU1plwMQ89saIU/sH1MSmSF680M6K+ipsdNmHfNyZSpsHMs0s6pGz
 6GMLL87VxzzbzOuwIG1OjCOB2eFVjh+3qoMlnuUSzRthIjeU5LIHMRuAkdrr5IztXl5b
 cx7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkZOW8psYqPGLIDRrNevNhlNjr9Y/6n4ZamEkFnmUwRFbUf4/cJ/EWI1X9OJkaebFEVmFjG3E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx3KGqreyqAhjFYyhmhr3+/iyONB3XucLskQZrPJhdD5HN3LSp1
 UUudWsjhb9tYIp3gJ5XToVFIeWFhjd87lniLB6iiAvx7oN5oDatVjWGMlMgwQ7Rk9agf8s09W3m
 604+1wqJJ7xnYKegwpnOGP65ayjNSe+otokwKZHpq
X-Gm-Gg: AR+sD116sjB8scpoUV4ovv+bSOiWKyq1pLUqNf8/u5GY8qMM9uxlhUyubkEY5MtAwLY
 TaAwoUn1FkAyucRRRw8xa+XEHooWQWfZKGbPox2ir1l3JLXWNjHae8f1QBYDSXmgWXkOZaIlEXg
 Gx67WvR5laFC6qPgiAKoGlL0BWb3KLIRi6LqYKPcxx5VC/JeT9dkzPCAjenqS+EjlS2h5KJs9UT
 ZGqT1bUa1Rmj1Gu9yoE1SBpfg11FxfNUtmoASqSyR+IB4u/8IbJrksoUraeB+JHgu1QlPAJZM3p
 9MQpCvVP/UyiQYxN1E0UaGhDlRcHWM9SJPUlV3IWGFc=
X-Received: by 2002:a17:90b:3847:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-3903c5a7285mr8924457a91.13.1785967207423; Wed, 05 Aug 2026
 15:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260731085724.75729-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731085724.75729-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:59:51 -0600
X-Gm-Features: AUfX_mzoglHL9Gswj6bATJzTa1aSAhxDBax20f3rVUGHl-C4AtxygcRtRVinjs4
Message-ID: <CAFLszTg3Rw8fOabWEsTKJvkazwJrnQYnAfTgANX9XDjpUczVdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: avoid video ghosting in EFI app
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785967207; x=1786572007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rJQd7cP9xH8Dmhhu0WJkKmzkeBIHrB5o8aCJupVSLdM=;
 b=TkLHsjbIMk+upFwYf7lulBaA78ZOzaNkLTAwt1G7fPnhRlOoUqAEvQXfjYj6XlRyWV
 wxczsB/fI05qdGlYmGo/RiSiIj4a79U/KMvsHqHGnlyDp0/VpPT5HLY6XEM/mfGwYNXW
 gnt4QsAEJUAk2vpwk2zFcT88vMnlpEjhl6w44=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TkLHsjbI
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

Hi Heinrich,

On 2026-07-31T08:57:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi: avoid video ghosting in EFI app
>
> When running the EFI app via QEMU with EDK II using
>
>   cp /usr/share/OVMF/OVMF_VARS_4M.fd .
>   qemu-system-x86_64 -enable-kvm -m 2048 \
>     -machine q35,smm=3Don \
>     -drive if=3Dpflash,format=3Draw,readonly=3Don,file=3D/usr/share/OVMF/=
OVMF_CODE_4M.fd \
>     -drive if=3Dpflash,format=3Draw,file=3DOVMF_VARS_4M.fd \
>     -hda disk
>
> every character printed to the console by the U-Boot app appears twice. S=
ee
> https://gist.github.com/xypron/7214e785c7d73104f8541bcac363a192 .
>
> The reason is that environment variable stdout has serial,vidconsole as
> value. This is defined by board/efi/efi-x86_app/efi-x86_app.env including
> include/env/x86.env.
>
> Provide a proper efi-x86_app.env file which does not use vidconsole.
>
> [...]
>
> board/efi/efi-x86_app/efi-x86_app.env | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/board/efi/efi-x86_app/efi-x86_app.env b/board/efi/efi-x86_ap=
p/efi-x86_app.env
> @@ -1,6 +1,17 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> +
>  /*
>   * Copyright (c) 2015 Google, Inc
>   */
>
> -#include <env/x86.env>
> +netdev=3Deth0
> +consoledev=3DttyS0
> +scriptaddr=3D0x7000000
> +kernel_addr_r=3D0x1000000
> +ramdisk_addr_r=3D0x4000000
> +ramdiskfile=3Dinitramfs.gz
> +
> +/* common console settings */
> +stdin=3Dserial
> +stdout=3Dserial
> +stderr=3Dserial

Please can you keep '#include <env/x86.env>' and override just the
three console variables afterwards? env2string.awk uses vars[var] =3D
env, so a later assignment wins, and we avoid duplicating netdev,
consoledev, scriptaddr, kernel_addr_r, ramdisk_addr_r and ramdiskfile
=E2=80=94 otherwise any future change to include/env/x86.env will drift awa=
y
from the EFI app.

Also, the previous include pulled in pciconfighost=3D1 which this
version silently drops. If that is intentional it deserves a mention
in the commit message; if not, the include-then-override approach
fixes it for free.

BTW an alternative is to leave x86.env alone and make the vidconsole
entries conditional on something like !defined(CONFIG_EFI_APP), so
efi-x86_payload.env and the other x86 boards keep sharing one source
of truth. What do you think?

Regards,
Simon
