Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA2CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 15:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F34B4074E;
	Wed, 14 Oct 2026 15:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QT2YGkvHcVtD; Wed, 14 Oct 2026 15:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F8B140723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791992285;
	b=Tfe+Rs8jnQFI4cmoWgPn+iWFgXut2I/umZzAxkFpEpeWrJ6XHPBR0j7fTZHrC5x16Nhb
	 Hrcaca6IMlSyvFkyMPxWaoum27HGSh88FX/SEH07iBraK2N7gVUQWxFbCKIv5AJODMfYU
	 5GPgS5O+FDDFm7MMSBOo+k22RMfrtT//mrBBzcFQXazZagOgwVpsBm0Ut6sBx3YYFTi5L
	 OXxL8M08+a85Tf5m/PsFYvbs/FdP4NvVbaHFQ6UNRAQ0c/t8q8rAcpKr0cOzg47iShlZq
	 a7dnKWrHIbZkWXG8vJ+uEDgu9TLu+SmMkQUPyS3gfC057hOYktgJVtnrRObOUPc8v1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791992285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
	b=N8BCvW7PxNrs33rkTmxHb5uH81cHC+UVhGij6aej3hmpKBsH73KcoVN0eegh0APPBcb6
	 vsY20vvYafUYbAOXnknlvPgKuuC6HWF28pDlWNLtzLM/ljxnQi0QTkWs0P3UDkQZhQXZv
	 EYObW/rtOupMde3W1vd6TYuFjmkBSv5OLLdHnfpJ4p6yJa+LdaiB5VIHRKRgxHnuKsa1y
	 jbeR4dKE+H2KIyyNiDG9Rey8E48K9aD0ITbNWNJ05ouvY6b/oubt0VFEU7cV4gY1kKpwg
	 FaGP0OUkcJ3L67BpKzaiJyPOrdY234FFJTL2gcWR6onTlhs3lpjRv6lRqheOvIVCX6g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791992285;
	bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZBwfOw2VA1Kr2HDolIpYyKl4j8Rt0G9F9DwZMO792Eb6ZxkT2A5RZ/+6N3rCwCDDk
	 PH5gXgAv23qCjEXg4AuZJMnqseqC7jXoGnbu9lwomRZVSdZeUdbjBOmLFdvOFGOAcv
	 3EMYjZvhKoRlH1Cd+Udl9GSeVMKQSgIWm0mfyhPUrpzN+rXz1O8OrbpHbF96pzhk2E
	 18Jb3wTC3MONFz2hT9UOWgRMbYbejGPCzQP0L3gb41AnPFFp2rfpHMQcOOtBurw9O5
	 +tdUkTgQHN6NB1O2KD0INiA4CDGirSjUdxWqjOnz56YjZ2ot50yq+KVAwk0eRgZDQM
	 QZjUE+uQp+pJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F8B140723;
	Wed, 14 Oct 2026 15:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EDCC2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 15:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C56B808C6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 15:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9OxjOb1Da9P for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 15:38:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7361A808AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791992282;
 b=om0KJURYStu9FR1KGVs3dahw+FzGvHCLmD4UbvD/TA60DwUNrWHXXyLkKsmID1pMafy5
 9zfZ2RgKjX/C6Tpt0NJPzY9nyLD5wpMq8lKULKpiR+er7mDBi1X6beBreVZoUJrS5Ju2b
 v7IeGmf0VwdjedgKH8ApD4Ud4HgNflx58iSVf0hVZvne4rpWzfo8oHm4exPesck0pqmYy
 UKX9gH4L6Xd5Jym+y00hrl/UdQzEmRt2YO0sAiDu/ntZMP21Xbls6JmhFIEDtbFhy/tgP
 ZNGMSBDJRrGOzV3iDMaNtbO/HrJPc0Lorb1C0GNE6VzwJrb3yK6nqLxe+SpnS8L8UIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791992282;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
 b=E+O0l+U5WxQgdZqct55HGGhPNwPYdb01PBKVPOy6OCFzpBX+2fT6D0IBI14/U9Vypt29
 PpgP42qpTsP01WDOZPO9EWjfjMWBmAMWNKctvA3a+x5EoyY6JVHgWsopMv9bBXKi8Snad
 tPQCvr7shfG/7gcOgPRLctho6KSSXjkOcpFswvg4pGZUrTrjZ2QiLMMSEM+Us1CTp8iSf
 TvM0gI7cfeFR/Vx9q4jwqSPeNfJT5d+YqiVC4A+GTSgoeSHQSA3bkKdnd/F4pnYJLypfg
 ocat46o8zT4/e81yt8NnqUpEfcw72GfDMyUgGcqsWdmkBxYazH81qkIQcdo0n1g6aHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QlRxlZak; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QlRxlZak
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7361A808AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 15:38:01 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab38a051aaso35873987b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791992281; cv=none;
 d=google.com; s=arc-20260327;
 b=FIojC8nVO3Ds/cSEEytXPsxaSLNdgLGQHzZwmSdN0oJPByjGPCRyNzmE0pKKPOW5p3
 CGUSrfDlegHuJfFSzE3tFt0WZbnpalBDSJfdBaQmRg6GGefyxR/I7fkk8Pw7wBnrHWFi
 LUaJE1gV21iCN/XxFA/qdAyoAPa8d4lOC8iPomwr812cwscxApOPyPFFelVJuAoFjjcx
 bJZ7xyRDo7oKzN0QmT8wzLuVPAbjHNJH4aHejjJMiffEzzuOPP6GmNMGBDbqvfIYkdtw
 DXhEv8CcE88UE1mIp8OOdNncUcTrel5EGAwka1PRcsQt7kuvFeAisfe0K9VdH2InisgF
 BWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
 fh=6YAlpzlZToLaieZ+kpvTcwCYUR5sldNe3NkMQvQPyG8=;
 b=gWE4zmDtl8QNPf6GhabLdtCcQOS4Yw1obG34nzXJeek2vlgRJPEUJmtz3RdbwmMfr3
 b60aRoQAsOfAFy75YrrJYIawC7yfr2BL9VyvGO9vGqdEmf4g2R6CAbtJ7S5441oIka3z
 m1dwsaajFLqvS+bGO18XPaqMXdAhb5UuENni5KcD0lLbKd9evHtNnruaoJkcdfPFKF/8
 HgdTKoOz/E35cMbJe5uCeLYgjBSpgGiDPt3h0ZXZpUYewbLYGZPup7ZPnjfh/MJUuMKS
 Wbg7ThQRBLi5rKYMAXua3yRopEtBlhiU7v90yXPUZm/fib4BR1grEBVC+/BacHOiNyj6
 nu6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992281; x=1792597081;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
 b=QlRxlZakHzVdFDbqmfaJi6kCjfZLQ0rGly8R1+RB04+WlZ71Qw1J2EKK43CJwCQ953
 dnPlNKzd69h41NqkrP3xMVJThJLp5/o7Ze8ZRLZq8mWBRzzhBKE/xGmN5nwOxEc004G5
 KBUGzTrUZFpqesXjcpemxUKBNzBFTjguh26DaJ4Zn8N2+tTMimhoHJQIhxHXis6g6LOd
 bKMwUjbGmcDBqsLQn+Vo/FYCqBHDOCPMg0w4kozI3NZrsWbEPHrfQw71pf6XNAbQiHJW
 H2WSTbRkoRhX2BdyyZLXFZepffIN9bUMPyXOueMMOZpWZkplHhhOZmGMRpetY/j4DQVH
 shuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992281; x=1792597081;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raTN10HphG+7eVcYX1nMvwAikjiDZfRc3528Mvzx/Uw=;
 b=nwnRpA8KlZbp2Y4eCQdw4mTjWb9mnXWBK1xcDJTrKCJ7R+nA4Owq07oOUsrGJaVmRB
 jAtSJVBi6gdQ4tGRxIvr78y8PJDWP6TUc/u+U2vfUzJL19BLf2MJS6I9T9jITET9erTd
 Wtndzam/62MXYNw0FQKk6z8ukA0tfT1CuXRnErbsKNbyj6Q/b5GnVsReABkHxwCpSWU0
 clruiiPhDfeQCnYrrz6SkhfBeb2DSfl0NoBt7WR4rDazvpTl5jRoMUabULfn+rkZN6Zn
 gtrp32MBF22FtGmuT5P/sf/BZRyDuGe2NUGyoRxSv5lMr6aVHYnqN45F+3/UToYxHNfM
 BvyA==
X-Forwarded-Encrypted: i=1;
 AKwUvByzB90ktmINIZ8N95yymMkU6eOrBfXo+0rkIkGm0CDIBGxACe9D62Vb6GKnTFaPAOvp5EnKGz8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKUOXZ+aeV8JDBldEppuutz1IQiSZEVgL3jTLY4vVwhCPog2QMV
 tle9mdOVRz2jY2TUxHtvKMOZho1Y8tnRfnBZiatDfXY+2VJEAeqWHIF8V4acj7ruTXYThE85/dA
 UYNu2mGig2OW4glIxCVRXYa5vvSIXOF8=
X-Gm-Gg: AYBFou0htTg3cPclLeqhx7bBI49s3RMMXkVX2U+oNeyPvTdc7i4m3WRl1cG3XBQ2ftE
 scKG6pUX/rIyGB/IsbC1juk72PSwn36hkVyPn3dD95UdFcZfb4F743STC/v2w+ntkNp8oi1SjPt
 pd+xANzfQv6XBBMwu6VeZ3pnSooRUGByK4PSu0QZM5reIVoLpzCKsU4iPTNuYFVdNCFBWQWXK9Q
 SNeer2T/gKGx5+pNPXt39KNJFgBnjrMNBmB9jw7t2ixbMXeVH5f9b2iNOrsANdY5y+5ZBN2Yx4C
 YxFS1oz1m1rNPe/GcCH/WblIyPB5PQvVjRjby391w1aUE4eaQaW4aQMxB2uMnHaV5kHnxJJYyB9
 oagdC6gi8q1LPyvU=
X-Received: by 2002:a05:690c:a597:b0:8a9:da0d:1d94 with SMTP id
 00721157ae682-8b07eebac03mr48512087b3.68.1791992280672; Wed, 14 Oct 2026
 08:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
 <20261014140716.1181882-2-alan.tseng.cs@gmail.com>
In-Reply-To: <20261014140716.1181882-2-alan.tseng.cs@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2026 23:37:48 +0800
X-Gm-Features: AclHuK84iguiW6Rz340SctPhvq9BfbW4gjWDsTNvps_CJDEtAG_9wZBvBNBp5KA
Message-ID: <CAEUhbmUMowoTW4fVXaFLejvtgxZuFK4wVe5-xDjhmhbQEPpecw@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio: rtc: Add virtio RTC driver
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
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

On Wed, Oct 14, 2026 at 10:07=E2=80=AFPM Hung-Chun Tseng
<alan.tseng.cs@gmail.com> wrote:
>
> Add a driver for the virtio RTC device (virtio device ID 17), which
> QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
>
> The device exposes its clocks through a request virtqueue. At probe
> time the driver asks for the number of clocks with VIRTIO_RTC_REQ_CFG
> and picks the first one whose VIRTIO_RTC_REQ_CLOCK_CAP type is UTC,
> smeared UTC or maybe-smeared UTC. Reading the time sends a
> VIRTIO_RTC_REQ_READ for that clock and converts the nanoseconds since
> the epoch with rtc_to_tm(). The clocks are read-only, so there is no
> set operation, and the optional alarm feature is not negotiated.
>
> VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> VIRTIO_RNG does for DM_RNG.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>  drivers/virtio/Kconfig         |   9 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 206 +++++++++++++++++++++++++++++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 220 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_rtc.c
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 55b444280..c19138ef2 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,4 +84,13 @@ config VIRTIO_9P
>         help
>           This enables the 9P transport driver over virtio.
>           It can be used with QEMU based targets.
> +
> +config VIRTIO_RTC
> +       bool "virtio RTC driver"
> +       depends on DM_RTC
> +       depends on VIRTIO
> +       default y
> +       help
> +         This is the virtual RTC driver. It reads the UTC clock of a
> +         virtio RTC device. It can be used with QEMU based targets.
>  endmenu
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 6e7bcfc8e..ddb5ce4eb 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
>  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio_blk.o
>  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio_rng.o
>  obj-$(CONFIG_VIRTIO_9P) +=3D virtio_9p.o
> +obj-$(CONFIG_VIRTIO_RTC) +=3D virtio_rtc.o
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclas=
s.c
> index c163b2fd7..c6cf55922 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_=
NUM] =3D {
>         [VIRTIO_ID_BLOCK]       =3D VIRTIO_BLK_DRV_NAME,
>         [VIRTIO_ID_RNG]         =3D VIRTIO_RNG_DRV_NAME,
>         [VIRTIO_ID_9P]          =3D VIRTIO_9P_DRV_NAME,
> +       [VIRTIO_ID_CLOCK]       =3D VIRTIO_RTC_DRV_NAME,
>  };
>
>  int virtio_get_config(struct udevice *vdev, unsigned int offset,
> diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
> new file mode 100644
> index 000000000..7d0dc9c7f
> --- /dev/null
> +++ b/drivers/virtio/virtio_rtc.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> + *
> + * Driver for the virtio RTC device (virtio device ID 17). The device
> + * exposes one or more read-only clocks through a request virtqueue; thi=
s
> + * driver reads the first UTC clock and reports it through the RTC uclas=
s.
> + */
> +
> +#include <div64.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <rtc.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +#include <virtio_ring.h>
> +#include <linux/types.h>
> +
> +#define VIRTIO_RTC_REQ_READ            0x0001
> +#define VIRTIO_RTC_REQ_CFG             0x1000
> +#define VIRTIO_RTC_REQ_CLOCK_CAP       0x1001
> +
> +#define VIRTIO_RTC_S_OK                        0
> +
> +#define VIRTIO_RTC_CLOCK_UTC                   0
> +#define VIRTIO_RTC_CLOCK_UTC_SMEARED           3
> +#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED     4
> +
> +struct virtio_rtc_req_head {
> +       __le16 msg_type;
> +       u8 reserved[6];
> +} __packed;
> +
> +struct virtio_rtc_resp_head {
> +       u8 status;
> +       u8 reserved[7];
> +} __packed;
> +
> +/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
> +struct virtio_rtc_req_clock {
> +       struct virtio_rtc_req_head head;
> +       __le16 clock_id;
> +       u8 reserved[6];
> +} __packed;
> +
> +struct virtio_rtc_resp_read {
> +       struct virtio_rtc_resp_head head;
> +       __le64 clock_reading;
> +} __packed;
> +
> +struct virtio_rtc_resp_cfg {
> +       struct virtio_rtc_resp_head head;
> +       __le16 num_clocks;
> +       u8 reserved[6];
> +} __packed;
> +
> +struct virtio_rtc_resp_clock_cap {
> +       struct virtio_rtc_resp_head head;
> +       u8 type;
> +       u8 leap_second_smearing;
> +       u8 flags;
> +       u8 reserved[5];
> +} __packed;
> +
> +struct virtio_rtc_priv {
> +       struct virtqueue *vq;
> +       u16 clock_id;
> +};
> +
> +static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_le=
n,
> +                          void *resp, size_t resp_len)
> +{
> +       struct virtio_rtc_priv *priv =3D dev_get_priv(dev);
> +       struct virtio_rtc_resp_head *head =3D resp;
> +       struct virtio_sg req_sg =3D { req, req_len };
> +       struct virtio_sg resp_sg =3D { resp, resp_len };
> +       struct virtio_sg *sgs[] =3D { &req_sg, &resp_sg };
> +       unsigned int len;
> +       int ret;
> +
> +       ret =3D virtqueue_add(priv->vq, sgs, 1, 1);
> +       if (ret)
> +               return ret;
> +
> +       virtqueue_kick(priv->vq);
> +
> +       while (!virtqueue_get_buf(priv->vq, &len))
> +               ;
> +
> +       if (len < sizeof(*head) || head->status !=3D VIRTIO_RTC_S_OK)
> +               return -EIO;
> +
> +       if (len < resp_len)
> +               return -EPROTO;
> +
> +       return 0;
> +}
> +
> +static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +       struct virtio_rtc_priv *priv =3D dev_get_priv(dev);
> +       struct virtio_rtc_req_clock req =3D {
> +               .head.msg_type =3D cpu_to_le16(VIRTIO_RTC_REQ_READ),
> +               .clock_id =3D cpu_to_le16(priv->clock_id),
> +       };
> +       struct virtio_rtc_resp_read resp =3D {};
> +       u64 now;
> +       int ret;
> +
> +       ret =3D virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(res=
p));
> +       if (ret)
> +               return ret;
> +
> +       now =3D le64_to_cpu(resp.clock_reading);
> +       do_div(now, 1000000000U);
> +       rtc_to_tm(now, time);
> +
> +       return 0;
> +}
> +
> +static bool virtio_rtc_is_utc(u8 type)
> +{
> +       return type =3D=3D VIRTIO_RTC_CLOCK_UTC ||
> +              type =3D=3D VIRTIO_RTC_CLOCK_UTC_SMEARED ||
> +              type =3D=3D VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
> +}
> +
> +static int virtio_rtc_find_utc_clock(struct udevice *dev)
> +{
> +       struct virtio_rtc_priv *priv =3D dev_get_priv(dev);
> +       struct virtio_rtc_req_head cfg_req =3D {
> +               .msg_type =3D cpu_to_le16(VIRTIO_RTC_REQ_CFG),
> +       };
> +       struct virtio_rtc_resp_cfg cfg =3D {};
> +       u16 num_clocks, id;
> +       int ret;
> +
> +       ret =3D virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, siz=
eof(cfg));
> +       if (ret)
> +               return ret;
> +
> +       num_clocks =3D le16_to_cpu(cfg.num_clocks);
> +       for (id =3D 0; id < num_clocks; id++) {
> +               struct virtio_rtc_req_clock req =3D {
> +                       .head.msg_type =3D cpu_to_le16(VIRTIO_RTC_REQ_CLO=
CK_CAP),
> +                       .clock_id =3D cpu_to_le16(id),
> +               };
> +               struct virtio_rtc_resp_clock_cap cap =3D {};
> +
> +               ret =3D virtio_rtc_xfer(dev, &req, sizeof(req), &cap, siz=
eof(cap));
> +               if (ret)
> +                       continue;
> +
> +               if (virtio_rtc_is_utc(cap.type)) {
> +                       priv->clock_id =3D id;
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static int virtio_rtc_bind(struct udevice *dev)
> +{
> +       struct virtio_dev_priv *uc_priv =3D dev_get_uclass_priv(dev->pare=
nt);
> +
> +       /* The alarm feature is not supported */
> +       virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
> +
> +       return 0;
> +}
> +
> +static int virtio_rtc_probe(struct udevice *dev)
> +{
> +       struct virtio_rtc_priv *priv =3D dev_get_priv(dev);
> +       int ret;
> +
> +       ret =3D virtio_find_vqs(dev, 1, &priv->vq);
> +       if (ret < 0) {
> +               debug("%s: virtio_find_vqs failed\n", __func__);
> +               return ret;
> +       }
> +
> +       ret =3D virtio_rtc_find_utc_clock(dev);
> +       if (ret) {
> +               debug("%s: no UTC clock found\n", __func__);

At this point the driver has not announced DRIVER_OK yet, so it should
not initiate any virtqueu operation. The discovery of the UTC clock
can be delayed to virtio_rtc_get() when operating on the virtqueue
buffer is safe to do.

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct rtc_ops virtio_rtc_ops =3D {
> +       .get    =3D virtio_rtc_get,
> +};
> +
> +U_BOOT_DRIVER(virtio_rtc) =3D {
> +       .name   =3D VIRTIO_RTC_DRV_NAME,
> +       .id     =3D UCLASS_RTC,
> +       .bind   =3D virtio_rtc_bind,
> +       .probe  =3D virtio_rtc_probe,
> +       .remove =3D virtio_reset,
> +       .ops    =3D &virtio_rtc_ops,
> +       .priv_auto      =3D sizeof(struct virtio_rtc_priv),
> +       .flags  =3D DM_FLAG_ACTIVE_DMA,
> +};
> diff --git a/include/virtio.h b/include/virtio.h
> index b981eead5..95069a2de 100644
> --- a/include/virtio.h
> +++ b/include/virtio.h
> @@ -32,12 +32,14 @@
>  #define VIRTIO_ID_BLOCK                2 /* virtio block */
>  #define VIRTIO_ID_RNG          4 /* virtio rng */
>  #define VIRTIO_ID_9P           9 /* virtio 9p */
> -#define VIRTIO_ID_MAX_NUM      10
> +#define VIRTIO_ID_CLOCK                17 /* virtio clock/timer (rtc) */
> +#define VIRTIO_ID_MAX_NUM      18
>
>  #define VIRTIO_NET_DRV_NAME    "virtio-net"
>  #define VIRTIO_BLK_DRV_NAME    "virtio-blk"
>  #define VIRTIO_RNG_DRV_NAME    "virtio-rng"
>  #define VIRTIO_9P_DRV_NAME     "virtio-9p"
> +#define VIRTIO_RTC_DRV_NAME    "virtio-rtc"
>
>  /* Feature bits for virtio 9P */
>  #define VIRTIO_9P_MOUNT_TAG    0
> --

Regards,
Bin
