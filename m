Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A736AC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7386F80F33;
	Wed, 22 Jul 2026 12:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ge2hgulAzSg2; Wed, 22 Jul 2026 12:33:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9616080F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723626;
	bh=E1gf7y6qZrmN8Pzg99dEO5aYjstCAcnc5u70NZL6qis=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zES9qXnjpn8z5Lq/XncAhqjdI9ot4LBviLdYBd3DAGqETZR+M4VPLMS0TPZggOdp6
	 Q0jNJL9bl7mtL3J35FdhQrR3b81n1nAz8ef/osFjYsR/8u4cDLFQDXp3ChxLgGzQFk
	 GUJaWKsP+btKka6LI4ItGLBLYp1tO8B50fQKL4vzbSWb/XIVZxuFSL+GUiLJj/blc1
	 tqLyxCI7xst9qBMF1q4v3FRyVEU68SHsCH6taj8XzYHhIuPlQrekqlVJTg05d7khKp
	 9EFbKyAVUqPNZTWFObG3jJSKjec1BsNZ3MUJJ/ojdkn/oBP4u1tKXIKX33n+20Kivc
	 a1FAn2odOiHOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9616080F2D;
	Wed, 22 Jul 2026 12:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C0F224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A438C6071B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zu-iyjlI6CwB for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:33:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 70A6A60773
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70A6A60773
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70A6A60773
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:33:44 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86B3848BA; Wed, 22 Jul 2026 14:33:42 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07BD803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:33:40 +0200 (CEST)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c8e2e39easo127206181cf.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 05:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784723619; cv=none;
 d=google.com; s=arc-20260327;
 b=JlDmjKwBjgeMAvQT4qjh05uJ+CfkZGtSIFG1BL8MD8uQoavRP2qQCf+BjvkZsIBvxV
 g2cFEWjBZQHYw7TnPdEYQNriaukCUo+rJMkJdhjbx462F6ZB1rucV+gEwEH+QNELXuGp
 qHHAAnuhMXLogitZclh3B6IObqaUcqNKay8mtI3cfcKpPifbAmkBftXyA2ZQxvNvY+5o
 /pqWufT2i08J1/Zg8B8M5BXpBIdjfy0a1F77CCfGfPd7XkhkFi7DqpMeLcdLWQ0J70LA
 66Yv40H/XFjUFvxzwlWULmK4fnN7tKf/upRMj901w2u1y9DiXTIw/9QKc9DwFCk11wke
 W2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E1gf7y6qZrmN8Pzg99dEO5aYjstCAcnc5u70NZL6qis=;
 fh=V3imX7mvzqNVMxdtK0vPpYkCCeD8qowsk8kz/+TQ42I=;
 b=f+msaxNdiewWCBmXGG1meJ5KGy5BSo6dAj7DDXrrDCeXW8XKVZ4WQEa1tEpZUA8Ag0
 4fgUNLr66L05JH3uw6mHz8R7oJ2P1REqvDNtabnzk7+hVGr0+hRGa9JEgZ3gyvD83Hr+
 sUoHl4PMA78AVI6pRV9dESPK4Q96GbVR5v8RwkivQcI8RVGyfxXViCEuJYJgkD/O1HJm
 GqQG1VadyOwygY2esHFbrAXXu1AjQlsTJprYJaZiaCQgM+g2dKOreZxxNW5AZfwsFVlR
 AfcEcejmyZ6FYxYeky211WjQHYayVH2tZqiBTdRmN+4eXTjmtGVjeXoDpm9/16lhDLLZ
 EW0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784723619; x=1785328419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E1gf7y6qZrmN8Pzg99dEO5aYjstCAcnc5u70NZL6qis=;
 b=kum/7MikzscyT7kh3g5BKzfiOhmyjp4t8aKkwjCzii/Ci6icAKtTrpBrhfUNHVNuY7
 nZDuIFRMmDtW+EKipRmY06inXlTgcWgQG35QLVmwM3jdAGQ5xL3+X4K5IinPAIB+oOxf
 KWEq0J46neAdtWEnXoEHlPLUBYqHCZUPQ0gq8ZICvkczyyzYw4FEVWLjwvNwewdRVXrD
 D9ItYoF9razyCXKkuhrhuGDHaaVYPYCqHgkFI6y1rTB53j7b6GD4bVIqBr9qiOqTfAST
 9g9QxLsGljdr5x7w/2pyQP+52DDbH8bD1Hddr6688Gz1+Y2/nBWBjf3/Td1ERlYgd+SA
 xnGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RraM6fb6Otn6qw63feBCCFJEOB8Ouy7iqCn+TaF/5mf5u0LUodOW+u25NhoAgN7e3ScnjpORgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1ZTtLyy4HSvBHVXz1+CFCWcTb4FPFfS2TaidwJzRqOe12u47Z
 UA/GTt7K0CEA8VD5eLqmSrKWZnrr8g5p+S848dmtqSdYqqQXuQ12NzVCl53O+kWpuYQuCPHs5px
 MVZDKAN1o5AYWeV9l0JEyBkH5MRlwTu8=
X-Gm-Gg: AR+sD10pkgW/5MrnFiraqh4Cj5bOWFmhmSL42T/bjpCCneXpeY5EhskXUL0EKpLMzLM
 sVs+nHOaEQThxVc5YUqb2/tQkPT/TlpnZ7Asrn9eheIt6kXM7BTH7pAXiyU+eWx38HGPhhF0FEt
 ft3sjzLtF1E5V1/pjkPequ3V/w+jorR1rWJ+lyHscC0SM9D4pc+4fVwydQUqqov2FvGtETITntf
 9pUiHoYQhbaem16nBWTmIesh0M+HJj2up08MYjQeEoW90sKN1vr4FBdgHlFnZjM06JZWhLC3Hn2
 y3OedxhakPlu6nkYpujB9yn7SVQ663sp9TLTRd4myQiwAK8thMc+0jY1hilzS90bRNUYokvwRn7
 JysoC+MwajcFip/TUJRa6CYA7LCpzYeQJg9+e6iylz7KSrSNK7G1fVxxb
X-Received: by 2002:a05:622a:13cd:b0:51c:7b11:41a9 with SMTP id
 d75a77b69052e-5213f959cc5mr214476261cf.86.1784723619349; Wed, 22 Jul 2026
 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
 <amCRWI7K4Jj_psYp@trex>
In-Reply-To: <amCRWI7K4Jj_psYp@trex>
Date: Wed, 22 Jul 2026 13:33:26 +0100
X-Gm-Features: AUfX_myio84MFzEnDQEfgDCWNwgTlmWWL-nb72ay_PKA0Ke1v1X8GzhXRnybKiw
Message-ID: <CALeDE9PV=1-8sgWZn7n3w9A2p6A_TDus1gHyjetaT_oR5uA0Cw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, 
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org, 
 shawn.lin@rock-chips.com, igor.belwon@mentallysanemainliners.org, 
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com, 
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com, macpaul.lin@mediatek.com, 
 jstephan@baylibre.com, bb@ti.com, j-mcarthur@ti.com, 
 venkyada@qti.qualcomm.com, hayashi.kunihiko@socionext.com, 
 dlechner@baylibre.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784723619; x=1785328419; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E1gf7y6qZrmN8Pzg99dEO5aYjstCAcnc5u70NZL6qis=;
 b=d6A+oT1pnwgksGndsDXHBgZoiOJk5T/9qqhFK3TvUk7bFkIdqVg+VN80r45h0z7hGJ
 xLxJjcqLNh/8JOuZDNpz8XxwABULhU43GDnz2ohMIWFrpFh4xqA3ljhTh4nty8DpH8QU
 Gz9RO4GOtTQkGhd1+H/tQ/pUkPgpBiAPIinwHfMkWhAfhciXxJc7WT3liGplBjrb+vUL
 xlrzwiDn0TEmtXebINKfnpEgaBRUgeUg8dIL3VpUb+PFMyDwXKgODdGvJI09kwOo94kB
 NM72OHXja0Sf49rahxV2m6Qq/+ODWWf3iFSk4y7B9cd+rgqU3UqfeoCcfn3XN3kaq/+D
 oisw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=d6A+oT1p
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6A+oT1p"; 
 dkim-atps=neutral
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
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 at 10:46, Jorge Ramirez via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
> > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
> > > supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpm=
b.c
> > > name is free for the RPMB subsystem interface added next; pure rename=
 plus
> > > its Makefile object, no functional change.
> > >
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > ---
> > >   drivers/tee/optee/Makefile                  | 2 +-
> > >   drivers/tee/optee/{rpmb.c =3D> rpmb_legacy.c} | 0
> > >   2 files changed, 1 insertion(+), 1 deletion(-)
> > >   rename drivers/tee/optee/{rpmb.c =3D> rpmb_legacy.c} (100%)
> > >
> > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > index 36ac085ef42..8321cf53a19 100644
> > > --- a/drivers/tee/optee/Makefile
> > > +++ b/drivers/tee/optee/Makefile
> > > @@ -3,4 +3,4 @@
> > >   obj-$(CONFIG_OPTEE) +=3D core.o
> > >   obj-y +=3D supplicant.o
> > >   obj-$(CONFIG_DM_I2C) +=3D i2c.o
> > > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D rpmb.o
> > > +obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D rpmb_legacy.o
> > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy=
.c
> > > similarity index 100%
> > > rename from drivers/tee/optee/rpmb.c
> > > rename to drivers/tee/optee/rpmb_legacy.c
> >
> > Why not rpmb_emmc ?
> >
> > Neil
>
> right this is what is confusing about the current abstraction; op-tee has=
 two modes:
>
>   1. Legacy mode (legacy_operation =3D true)

Does the spec refer to this as legacy mode? Presumably it's RPMB on
eMMC vs RPMB on UFS (or presumably also NVME) or the revisions have
actual version numbers. Maybe name it after the interface that
supports the revision, or the actual revision of the RPMB spec, as
opposed to just legacy. What happens when next version comes along, to
we rename legacy to old_legacy so we can have new, legacy and
old_legacy?

>   - Uses the original RPC command OPTEE_RPC_CMD_RPMB.
>   - No device enumeration =E2=80=94 assumes a single, fixed eMMC RPMB dev=
ice at
>   - CFG_RPMB_FS_DEV_ID (dev_type =3D OPTEE_RPC_RPMB_EMMC).
>   - This is the fallback for older supplicants that don't understand the
>     probe protocol
>
>   2. Probe / new mode (legacy_operation =3D false)
>
>   - Uses OPTEE_RPC_CMD_RPMB_PROBE_RESET + OPTEE_RPC_CMD_RPMB_PROBE_NEXT
>     to enumerate RPMB devices, then OPTEE_RPC_CMD_RPMB_FRAMES for the
>     actual frame I/O.
>   - Supports multiple RPMB devices
>   - OP-TEE probes all devices first, deferring key provisioning until
>     every device is examined.
>
> This PR adds supports for UFS using the new mode of operation that
> enumerates devices instead of the legacy mode.
>
> In the meantime eMMC continues to use the legacy mode.
>
> So the super-sets are legacy (for emmc) and probe/default (for UFS and
> eventually eMMC/NVMe and so on).
>
