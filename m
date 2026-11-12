Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10609606A336
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PChcubJM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xER/k4Bm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7910813AD;
	Thu, 12 Nov 2026 18:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ea5Gwhy1ApeL; Thu, 12 Nov 2026 18:39:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14F2F8119F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794508781;
	b=VYzFMRi0z6nmyuaavMApGrPTfuMcz5I/Y4nsxmn7kcWw+kr5oQz0lrNZyG4v5YC616N2
	 o1QGfQv/r9VolcWQ4XQOlDNKVi7kIKZGwiqKOIeOP7tTA67Z7RA3Jbu/7uXJQY6Zew6TK
	 cga3Hmj/soa6R4JuK83dA5+7Dy2ZPFH/PP8m96NcfGTPzNbaKRjKUj4jvr7/rUQM2aMFK
	 DT1M/sbjXU8hF4gbyKKmbDZzeBZ8t1H+KPG0Ly0aBFhdiO7fC8N8GdAR8oDJvBxAt1sXY
	 pRlUNQRGCh+YDueVg9idiHvY11RrwCg9mVqWQn7T00w9qoobS3FcizUumOxyU3y8/cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794508781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nIqwDh1CIYlN0oGTyA00NMoTOrzGoyygn7O19uYvLIE=;
	b=h+TewCd9xWbnn/eLm4Pau0gpIVpBpvGgKMz1/nR1V0wBjERoGD5fIcZ22cqeNpbiUuW2
	 IyHXUR8Gf3c8/o8DqL9ap2pWXDcUFc1LiSj1gNVgkU8pKdIDVN2rxZWiLCmrch2ciNnch
	 fzXjxLyVOcMS1VKGDJeHkYxqJ2EgBNhKuP/PgtXDxFTsVkzesTFicROdVEhM13BsV2CG/
	 iNhxqi+zWdy4NEI03nKoW5Q1fzqrrE2NNpgr6nGPi3h2gWxdMdnA2OXL1rYRXRQ+Hwmyr
	 Ns1+K0a88zlP9KQNIoRITzthA5hpxW1Dl+6Hz8DF7tm/R2n1VERgpSWDT8Df6esqe9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794508781;
	bh=nIqwDh1CIYlN0oGTyA00NMoTOrzGoyygn7O19uYvLIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PChcubJMZrRBhCWvOOfIw2zOCmbINk4Qi2Z2wVNnulgJqg5tMbT0ipVA1iXLXlExN
	 BiQlNYoc6dq489sINr34jxrykRmHp9nnHb104Z77t3il8KMSM8Fg2RSRjrvO7PdaiN
	 ZNf0YF4niSZ2PBNF2p65gPS7guuHFbYdwMVt103+ZC+JsnWKECKThmbfixhNAxl3th
	 vwCTnE/nNlSjCC1D3SAevUtpV0CWbQwK8ljW1N6y59xZ1FZaJbfGsdqYnqZMmH+nLa
	 m9ZFdEQW8ft20Bjj27XuSzfhuXVxd+7Xhxmm7Zq8hYIP6ALfQu5+kTyCa9hdFnGDf9
	 N3zgCyFDdUo0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14F2F8119F;
	Thu, 12 Nov 2026 18:39:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16108F46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07B1D4049A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEeGP22nYbBj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 012B8401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jernej.skrabec@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xER/k4Bm
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 012B8401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:39:38 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so83868f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794508776; x=1795113576;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIqwDh1CIYlN0oGTyA00NMoTOrzGoyygn7O19uYvLIE=;
 b=xER/k4BmCpKN9yfnItrIMw8Cjd0o/JEWD4ZUmSK8UpNep9UaKN70VQ//tJKfFzUlbp
 0g1BMkf4V+Pwgwg6/XQtHVy76v/5td6A4dJy/sHE7DAdJzab9eHiY9wLvaOU2L/JlNh+
 s2d8SvZBptZie+cwQhObSej1iWMFiRXzchmVTIrrMg15gXvDa+J7xelNq4hMbunG+2kI
 mpzAX3dW1YZRrplNAlkyK+9e087EW4kFKtu85qpNIKJR4W1KbMPKYzdejke+q7isuZHH
 yuJzlMaSNU2CSukNk4Sz+fLp5guzcTyT6I/zxWC1aaVRQuskCvloj+ewFJ3/+qJvvqxQ
 xT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508776; x=1795113576;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nIqwDh1CIYlN0oGTyA00NMoTOrzGoyygn7O19uYvLIE=;
 b=zgMXq9KuzJKsce3ajdghD0sXKekX64kZlAePeWstSj6E74q8UWJTDydgzIpV5KIqCZ
 HJNqn2qtFIQ3nWQl4GdjxkwBVdFeuukeB06zJ1vvta6S3hCuTKLRwFw8LlyE2HKaZIxe
 M59F3wi50Fekizbq7X/jUgUO7qy9GnWAD3RpjdAfhkJFC1OMchUemSwWQJydz5H2fmqq
 Kyo75M0GYs5T1IMZH25+LXIdAGeu6l/RbQj+8IvFLppoVDk7cWMDx41v2cDF3O//M1Qh
 DhqE92Zl3eVfpbQmtvrBMcpcF7WNQE3s8WzhI0dREHEkflB3AhuvWum1CZdLtVSZeAOk
 lihg==
X-Forwarded-Encrypted: i=1;
 AL+hErFZrqfb37lmrPftjIrlKdb/kJ9b4XFIciORrtxSJQrzYYDGZCFcyFtkoX85Pe1RKOutwb0E9WY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8nCBXTt9tVxmqj17B2U4dP80UJRpU29MW4NZ2SazzfZ1KwCnQ3
 FpCmdH/iPaBSUYoaMf8zWRg0DRX+lcSVqzqiLcgqbDVexR/a/tQrFhBhAKu1WQ==
X-Gm-Gg: AYBFou0AioS4/Xv/4izivgAItQzFkjUjaCCh3I68GH6CRlDoMWhQJQY5Qy4hJ4ntBsx
 lbRdgoPIye/Pyyg2i1Tuz+CFUaE6nbBU4fzxU2CMm/BOBwjiXaKDiXM0HFKl3bj6SKVptQ+eKYL
 RHZ77bSFEjn0T+YPw6ZY08JwxwOeCdFQIx7PwLvBEHAuvL5gRaGclJj+zEFgJYa1yFlrfKgKHG3
 B2ZuE54gB013UTPD2b2cVVj762fy/YH7tV5LTxdFEEuxIRP4rgI+mtM4h6ybQ7ixcdjC2S4Acmt
 sPbMtUe8BRVYTOtWqGhT6+/n0fh+YslJXsgNcUbnjiqbWmPEHm8HKPpHZo8GQOfEIh8QJ/LAumF
 T0XuYkHiTfPVYXOYlKALG0mVQ6Fji9EG7LWf/r4ml+5v7nhLpg6xrjoejcUspDytooQp4/zCzOk
 +LF6kg39cygFgEPrODnaVW56XuJ7FohRl+d7Z7Id2gFPE56pGNSznqG0nfeqGyDKPkvMxGcxyo9
 c+KrM3VPJTXT9/NAdEOLcMO7lgs4pwrJNaz7jJixdVBjdnJ7L6iiiF/ZNu1qK+xWyACHVfsXSCS
 H1nrWN/DDv3V07JDc2iUSffgkyzshxh7Ehpz3e9HKL9Vxgc+XBp+zj0TB2VZ+LEz57VmrqNC57L
 9JGCuCIFwHgMdl1HJjbZXe7FSVKMc8oHVYob2WpywZiTyGD0ma/O7bSGuggi1Qyf/uCLsPVyyY7
 dt7jrdqkofMxRScW8l1CKvASdKK8I+47KhQ1vGEunsArGsnw82622GaMUz8c1jKHzF70J+2iaS2
 oYk2gpOMOXYuI1Ul6lyUYHVGAJ8RYGgbFKLvxYSdOiKgtrLyeKUEwiFBv+HODSERDrWoNE0YWQ=
X-Received: by 2002:a05:6000:428a:b0:485:8cc8:1f5f with SMTP id
 ffacd0b85a97d-49c72e852b9mr538716f8f.42.1794508776356; 
 Thu, 12 Nov 2026 10:39:36 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-12-36.dynamic.telemach.net.
 [86.58.12.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d615sm672989f8f.56.2026.11.12.10.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:39:35 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: marek.vasut+usb@mailbox.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] usb: host: ohci/ehci: halt the controller before booting
 an OS
Date: Thu, 12 Nov 2026 19:39:35 +0100
Message-ID: <dyaPjPzbR86eIzIO25L6WA@gmail.com>
In-Reply-To: <20261112183546.GG554944@bill-the-cat>
References: <20261112182838.2792025-1-jernej.skrabec@gmail.com>
 <20261112183546.GG554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dne =C4=8Detrtek, 12. november 2026 ob 19:35:46 Srednjeevropski standardni =
=C4=8Das je Tom Rini napisal(a):
> On Thu, Nov 12, 2026 at 07:28:38PM +0100, Jernej Skrabec wrote:
>=20
> > Currently, OHCI is not stopped before OS starts booting. This means HCCA
> > is still being written into during OS boot. This may cause all sorts of
> > random and hard to catch errors, if same area is being used for some
> > other needs.
> >=20
> > Mark OHCI and EHCI drivers with DM_FLAG_OS_PREPARE so remove hook stops
> > both controllers during OS boot.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  drivers/usb/host/ehci-generic.c | 2 +-
> >  drivers/usb/host/ohci-generic.c | 2 +-
>=20
> I think per:
> commit d610f703f937ebf7681e5cc36905586666e7ceb8
> Author: Jacob Procee <sn125164@gmail.com>
> Date:   Thu Oct 22 18:58:08 2026 +0200
>=20
>     usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag
>    =20
>     xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
>     controller keeps running after ExitBootServices or bootm. If a device
>     was enumerated by "usb start" (for example by the default preboot
>     command for USB keyboards), the controller keeps polling it.
>    =20
>     On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
>     USB device that is connected while U-Boot runs is then not detected by
>     Linux until it is unplugged and plugged back in. Running "usb stop"
>     before booting avoids this.
>    =20
>     Add DM_FLAG_ACTIVE_DMA so the controller is removed, and its DMA
>     stopped, before the handover.
>    =20
>     Signed-off-by: Jacob Procee <sn125164@gmail.com>
>     Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>=20
> We're preferring to use DM_FLAG_ACTIVE_DMA here instead.

Ok, no problem. Should I respin it now or do you prefer to wait to
potential other comments on it?

Best regards,
Jernej



