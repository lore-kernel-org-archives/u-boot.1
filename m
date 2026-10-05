Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B3CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30F9540642;
	Mon,  5 Oct 2026 08:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8BpNEPQueb3; Mon,  5 Oct 2026 08:37:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D8E84063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791189427;
	b=FY91rgcoLDUB31OtcoS2Jk/aCoEn3v16+CC84F9Wvkb+v7SILbUjUJBPOEPr3TT9WgFA
	 WhJnDJEYmZAdwiCuq1x+m12vXM6Sps3F6GK/Jpj4huiAKsCTene+l5wrTeen4gs5xAbxS
	 xL451gyVVubu4Z8Zah9HYZEdvkTu2NMRyJ4QRiMaHDTU1j8SFEFtdLlHqv3VXlANBSmgF
	 P5jeovwn//F+e+7DxGBalzwDqQ2jVZmtfmI7sJG49bZjn0n2ux8wXrgNLTemS1OmoE0Nv
	 U+/vzqvrp16xlZdcpP0Cozu7YnQgtxJIqNtjXbI4GMb4Wb2Qw9YYJCpr4XdbGUvkAHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791189427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
	b=BqSezIPCbx2gqg2vl7Ih8hnrQqx1PBb1d049OCfaAYTs+iY7MxRoM7aypdn+b9I/GHKc
	 rN9NKPOZLQbZPAlXB+juOFPUrgdA62Zcb4g4DWb4mEWmXi0i/R0nabvG0Su+RVEAlhjnF
	 T96thco843Nfo1AP/5i5EraGay/fRk53C3x5uojkODZlyjT3OXLQ6o+RERiYt3yad3ddu
	 d11G8nIPqRegubjPPvd8BIIchz0mx0F9MkxCeDxz7JTs4uprxqIe7W8T3CZKMRdC97/rj
	 utAWtlE6rcVXq+lNKiWi64nqMfZ30uYwSX4Y2p2oATD2wF13f+7OseFR0jj3+8MBHCw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791189427;
	bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHr/h3Va/YxlWsFFOqxVvCXTzJpChHyhn4n8xoAEBMPabMIWNhmdgOXbSSAo3YtW7
	 9TBfYdSydpYDf66qpUrwhoYTAX+IbKi46l8uRbMHUj4hJR8eKUlHe06AESR0TCnl9p
	 bM06MvQe2SA3F0c7H4eBvJi5MjDy462xsRB2EWvpKaSvCvpFEr8cXVCj10T/tE7nzY
	 fXHB6GlT1mFs7jx1rE7Y41ttTGS9cMknes9OwmKOBsJogVV5vafuzkCFcAKv+alD39
	 zsjgcSy/eNZV5utkOk+YOXIZoOMkSCF8YlK4+5S7sInFJwNbgN21wnycQIrHJBzS+I
	 FKisoaOPoU18A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D8E84063A;
	Mon,  5 Oct 2026 08:37:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC12132F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 05:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B983D40068
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 05:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nkUEK5LuVqEy for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 05:48:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DDBF140051
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791179325;
 b=gLAc2uC+OKeHLxqqgnhbhkESv2sa/XtlrlZFltqYM1Lkoyy1S2Qfbtwfx8zwW4pFs75K
 NRI7AuA522CU6q1DqGV8hlqMnbE114CRAIoOonzt39e1O468CEtsLbeljzsxLeKsGynMb
 EGFjXpnTuLMzGrPkmpQW0bLqHQwTpTxlPFsRGmVKT/q+HKc3jibHwv0pKyEBYE1del7g4
 +sPTbvWO4jwpp+rOZSqCc3fk/HIl/AF7MN3o7E/5q9scdU+p/YA5BNvKFrhcgTnJcq49j
 amSLBfyjKMJtBz0hwoKrKeSc0huhkk184olGdYTu2R16uKX+LJdG1Fk8x9hx7WN07hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791179325;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
 b=jAnoDUZ6bcevGzZNxaVgSM39zHoOOBS18E9TCK3MRBTN6XUuU+EuKpc9ncG5FnVZmZND
 vHk4vi5u/HpefNuKq/yk1zf+LxazbJuqUosqGKBGCJUUc64nG6jwDn99D4R5w6E496iAG
 sbRs/lu4Dvhvh0kqRE776skLDqQxFBqIKWsphAMNiDj3jtnThlEP4HgH3XByvg0iq83Ng
 Z/RiGelwp1knRF49q8ZDarfPQD94s1qwIt0y6/HqzZ4MOCJTT9Cshh1RxVS+LtIEhKCFN
 56JesAHjPWA7u2zqJdHQ70C1RjAyTUODj8TWOmfCaaXhn3S07IhGCBxCmM3eJMze8VA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AV9Irn3v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:36::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::d;
 helo=mail-dy2-x0d.google.com; envelope-from=sycamoremoon376@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AV9Irn3v
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com
 [IPv6:2607:f8b0:4864:36::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDBF140051
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 05:48:44 +0000 (UTC)
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34c0b552ccfso929466eec.3
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 22:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791179323; cv=none;
 d=google.com; s=arc-20260327;
 b=awOpYx6Qdnp0/7v6Ji6Dj3GXd2VOsu1R/AHC/BesjEsCNqmGhFsXxXp11rV7X0txGm
 hP0t8ufI0h3/KUvHV3+D/a7PGvn9SgtehIDKixRt31nn65tRIB2B8mzlnLAlQCK8/vHL
 DefUxHQ4Tg6VjmJlPzgUzrwGb9NL9y9UCIMwt5QY0NXXidEr/35/5wIBJcSbPkC/5obA
 8QhqB+4h/8Sk7qUie3PGd0d39AtEB5Fg/IixJhLItQc4JqNvxRKWl93+hGR8H9mNpreu
 ALG/1UBvtlNPZdRfV8NidImsvRq1kZ2vCZ51pemSaFu6kxnXE6pQ3NExDkBJQtruNLTB
 EqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
 fh=arVK0dq6nW6MP7nUWnFgs6Ursil5RLR40dA4tGfb6mo=;
 b=nX+kXe1KGPN0eCCUtTGwZjrwIbu+qMG8tbuOODJ5MLfa00cMijzwpc2FIqBan7OuGb
 ypTi3Q7QKFQNK+0Uknsu9r7RDdOTUEzNk8ZFge8QVJYEDowOUfzrDI/NrpMdavfSuCwc
 Q87PtCPwTyA+QOUmoYa0lvriBigd+ix2umbw1QKW7YDnbk7FNA9tnpop3pG07T5L264/
 2lckEa2j8HLtYQMd6yCumngIsnx8KIb+epTCtedFFLlzI7XhirnZQHnHPZk+25ZiUjBv
 f6vQA4i/TTD6/Llflc4NMSQC3jBkQCZ/UiUyH+E8pbZiIgzfQbYT1k6mZyHRRPtwOt3B
 yQrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791179323; x=1791784123;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
 b=AV9Irn3vGj1qNx6gtiLYYxvyfW0GbF0oi/JzLcTlw5hlfiro7Sz7TWJHCsFIvXsHPw
 LZSAdw5Sr1eEsWIWNnH1f0ZdWQyJUVESh9Ho2OxGd+Jdf8IwN6K+6LAAAMhPS9I7gCZC
 QToJNQrKAHC0e+Cb+PPB8Vz+huBQQhUj7VbVNoKoHlhPjledjRRYWm2ONPcteW1cXOBf
 FURBlMvcfJRDQpfO4pzn2mDWDax5QcvQK9VvGdAFBaAdaAScirXYvO2NwO4wEmlH+sc7
 gp0vU4UlLIKjQ84383bDzmOngRC0if9E4trElh7+X2x9Kut+Pw1KdmSZ8SxEnVaoZCK3
 35ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791179323; x=1791784123;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CKwf1QLtxNZDjLwpJ7DZC7h4CujpGdKNPV8lkzwq4Y4=;
 b=wXRomz0/8yKHe8E16v2wTkuevtz7xclU0tmFXWH9NFxTrSFNep1A8Wb0ZofSEyKA8F
 CG6/IPJxm0Nf8+XGc5ABs649V+ainmV+XivMMLNdpRM+p6xxhBWPKK9n8KM+5V6kg7fb
 IFoemx/7Pp7KMooMAVISq/jcQxq0Z8TfNlCIP3wTCRNL57gzJO91zAlIRV8IghWgcYk/
 OqSE38Jytk8yqgmowvSpljq3nOdvZGrH69vRkEwYWyzB4a6KsTQFK3a4pCLrVPH2Wk9m
 mOSQPPUAOFIBHah4G+KtDzvH0e+cmOSZMZZRYtkTUUAHMFpLr/kdXn4Zs3765l5EFcI6
 5FVw==
X-Gm-Message-State: AFuF++kc7yJcNlzv/EeX5ppDlW+u2YGo7pOolj1dkoTnTeGdYkwjfr1n
 WoJhlFqPbVGnYyieduPHAO7CrK3ZAJh3TPJQu0eXtj8mu+rR6EjB9FJqAxv9kK/DItlxEK70Qp8
 HPEWM1H8UU3jL9AuOIW3Ieo4aBpHri1K8+nc0sSQ=
X-Gm-Gg: AYBFou2DbqULEnkrq7UMnlzz3tD3KHOIgpJoKEN8xeo5yOu4U1BnKgtzrWDOURV1Rpy
 q/TNFCS2CPUHWy9kWP3eb6YJL8nriUqzVxnwk7MQIjXNYRQ07J1a3Q/g8dnw4zNsRbxlrtxPOBO
 uLMBh9KeRA/gCCwYtdRl81E/zInbw0NDj2ga6pABBOpEiOeWELtRj9u9fQbx/eRn6B5+lFoetso
 TNPJBMxnAP3fuwWr7qhaFpbjd8dKW7pnXqtMnpJ2Xu6JBbp+n+j2oqSWbhwi/KANYw4XwZywWjS
 jMoaXvePwh8tqBS3JvTTCswRzx4Kupo+fvQCtf/O+ScTpzjDGP4mbrM=
X-Received: by 2002:a05:701b:4587:b0:14b:992f:c168 with SMTP id
 a92af1059eb24-14f58fd2a19mr10719788c88.4.1791179323334; Sun, 04 Oct 2026
 22:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261003031735.emac-v1-tested.DaveWK225@protonmail.com>
In-Reply-To: <20261003031735.emac-v1-tested.DaveWK225@protonmail.com>
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Mon, 5 Oct 2026 13:48:31 +0800
X-Gm-Features: AclHuK_lmtM2tmaQMgV7AVguMAG7S_TIBm8KRIpwnf6C1GfLULNu7sUuhv2Q_x8
Message-ID: <CAKyUbwU0O7gHNOypv+wxobv9-Raq8u11TX59iYFPZkCGUdipjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: k1: add Ethernet MAC driver
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Oct 2026 08:34:58 +0000
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

Hi Dave,
On Sat, Oct 3, 2026 at 3:33=E2=80=AFPM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> Hi Zixian,
>
> I tested v1 1/3 on OrangePi RV2 and R2S with YT8531 PHYs in rgmii-id
> mode. I reverted my local EMAC driver and applied the exact posted
> patch to my K1 lane, keeping the unposted board support, clock/DDR
> workarounds and OpenSBI v1.9 fixed. Both board defconfigs enable
> PHY_MOTORCOMM and ID_EEPROM. Both variants built without warnings.
> The existing SPL was retained; these were U-Boot proper tests.
>
> RV2: both ports link at 1000 Mbps full duplex. DHCP passes on the LAN
> port; the isolated second port uses static addresses. R2S: the first
> port links at 1000 Mbps full duplex and DHCP passes; its second port
> was not connected. Router/peer ping passes where applicable.
>
> On every connected port, each driver passed small/1 MiB downloads,
> three 64 MiB downloads at each TFTP window 1/4/16, ten further 64 MiB
> window-16 stress downloads, a 128 MiB download, and 1/128 MiB uploads.
> Downloads were SHA256-checked in U-Boot, uploads at the receiver.
> The 128 MiB transfers cross 16-bit TFTP block rollover. No DMA TX
> timeout, exception or payload corruption was recorded.
>
> Median 64 MiB download rates, local driver / v1, in Mb/s:
>                          window 1     window 4      window 16
>   RV2 MAC 0              15.58/14.89   80.66/82.19   153.04/151.44
>   RV2 MAC 1              16.15/14.05   82.48/82.43   152.09/153.30
>   R2S MAC 0             140.80/140.91 371.28/370.26  639.89/636.86
>
> Each pair used the same physical peer and settings. These are TFTP
> application rates, including peer/protocol overhead. RV2 window-1
> control samples vary; a separate three-sample repeat had a 15.33 Mb/s
> median. Its single 128 MiB MAC-0 upload was also slower with v1
> (13.60 versus 18.22 Mb/s); this n=3D1 observation needs more sampling
> before calling it a stable regression. R2S large-upload rates were
> 151.52/151.12 Mb/s. Duplicate upload packets occurred with both
> drivers, with correct payload hashes and no receiver retries.
>
> I repeated the complete RV2 MAC-0 test set against a locally adjacent
> independent wired Linux peer. Its local/v1 medians at windows 1/4/16
> were 51.59/148.59, 396.80/393.31 and 531.56/672.77 Mb/s. All hashes,
> stress downloads and
> 128 MiB upload/download rollover checks passed on that peer too.
> Both variants had window-1 samples near 3.6 and 10.4 seconds;
> the variable three-sample medians do not establish a stable speedup.
> The ten window-16 stress-transfer medians were 675.31/669.83 Mb/s.
> Single 128 MiB upload rates were 56.50/61.13 Mb/s (n=3D1).
> The isolated second-port cable remained on the first peer.
>
> Both variants booted FreeBSD with eight CPUs and connected links.
> R2S also passed the FreeBSD network checks. FreeBSD uses its own
> smte driver; these checks are separate from the U-Boot transfers.
> The original ESPs were restored and verified, including unchanged
> boot regions, followed by normal baseline boots. No long-duration
> soak or RMII/10/100 test is claimed.
>
> One source-review suggestion: k1_emac_dma32() validates each DMA
> starting address, but not the buffer/ring end. The local validator
> rejects a 1536-byte buffer starting at 0xfffffc00; the posted helper
> accepts it in an extracted-source identity-translation test. I did
> not force such an allocation on hardware. Checking the full range
> would retain that protection when allocations approach 4 GiB.
>
> Tested-by: Dave Klotz <DaveWK225@protonmail.com>
>

Thanks for your testing and suggestions. You are right, the helper
only validates
 the start address. I checked the current board dts: dram is declared
as 2 GiB at
k1-bananapi-f3-u-boot.dtsi, and u-boot's heap sits just below ram_top,
so the straddling case is not reachable on today's boards.

But for logical completeness, the helper should honour its contract
regardless of
the current memory map, so I will validate the full range in the next revis=
ion.

Regards,
Zixian
