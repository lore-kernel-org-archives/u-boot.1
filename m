Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F9606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VUu26EFs;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K7nNV9a+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3F840568;
	Wed, 28 Oct 2026 13:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hX-8Bf9gM784; Wed, 28 Oct 2026 13:16:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8D304056C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793193413;
	b=MH1TUvz9dbqkI6NDzyrfL6+qD2qQji2+XLiG6Ks2bo2yza6INdNPJEDgE+z31ez3gFms
	 bdqNFFnFwWIRISXETtO7HxcfmQ02E2cMC7Wv1sZNfcwBXEHyIlVrD5pszy1Ize0VnJZDu
	 XV1YAlbELJXdgn+MisKjYiqKu4sEtNeryKb7XyJkRQI3GdC22pk6fvG0OV4f0yRQFG6RV
	 jTPN3YY+IOjjrYLIecGMjjli5+tMbooXxMI/e4/GVRsY4aPyXg/nii1UHGy+pMf+XUIwN
	 HkkKrTdHXrTSBPL5xcMGItgU7oHT5cC9k1eFwtRIZOWE/+FFSu4t1BsJXRKwzvgfeFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793193413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
	b=qPJxC/pm3m1DmqMeKuWUnR/6H+XvOdc5c+v+Ao9ma2HOrbrxhgPzgb5QilJTgluVeWwh
	 iJHU+F3jyqU3ODC8CX5Tu6FsRSk1odMgz2rW0Dio5px6MQ5rD6o1Um1yVq5fIoPtg7YHl
	 U3DbqS+gosD9fKotE0hq0595eubVjCDW//FGVtrpJk6IaG5rhj9HY4kr1YzvDEHA7h7uM
	 uMvKUpBZaMaeKF8UF+xQWwG1h38hxjq8bAF0oYtqH1sz23VSylAPznCCk0e4OtQOPF2ay
	 rMMmxZJUAtTkepz3IQqm0eMubeqYS/an9G6Bb6ug0oNeHQteTiG5Z2ZykMBtSjEmDqA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793193413;
	bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUu26EFs7Mxb3C50l+GnhtmrD+uRApeMspCBFvykz/MTvTdDg/ukHXATNSM7erPvO
	 HPf5CSRWx0hwxzIGwIpLklJTGkXry2cA7YQlhjZDFsX5ZdPC68DEPqv/nO2uHCgdam
	 FTUjdh9pM9F/BNsWto2u1iDTBiqwS5Zv0t7IZh5xh9tk7BnD33frD4Vj8sm5awvHZh
	 Is8UjTiemDOoozzMBT3lzpFX/LRVZSZQxDzeuu7BGhiXuNnaDPig5wQw5exFzYPfwD
	 wQ6SS+/NDoima5AarhfKiZ64TRdaaQY+803pnv08FhgeeZer8W+VexGd2ax3xeLU+S
	 FvV+yvlGpzQtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8D304056C;
	Wed, 28 Oct 2026 13:16:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9788C356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CDDD6060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BCsC97dmEuTk for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 117E4605AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793193411;
 b=c9SOIIPbgniiU7R3k39m6VQV41tZ/JOG0jbPNSGywMGOVGzcUFcc9tta2Dt3a7JL1dvt
 tL32Vq98Y1i/87AhsE5OQK26RwVbPQWaeIPWe47qAK/b+xd0hisLheBLwQa13etzMT9Mq
 UvE6AEO+SF4eoXDhO9ez3XCQDcFHYP/eTxNPhw2AeVouscfGgfLiAghaTExv7RVZtmIZw
 kCZp0Nuduw3ggkNy2EivhXNgn/cW5ap/fUT61sS+6x5X9oafFzB03RYKM0t+ipFzODgbX
 gmKRFDHqX7877LF+y0mRXeR4nlYBZ0x4tqbTOao0v4Q7YUUDN9iW0wgwk5uCQrNKxFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793193411;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
 b=R8FE2msKrhJ5GNbug8d4YWht/YKLYzBexHWOpRWvtmcxNwhImUu0f+a9uyxSvVrubuhf
 SbXkSipeEnCL3+ocl08XTF7NimE+/9BcKMSmKSa6Stt50VxV6Wz8J6wjDbhmJogg4PQzP
 wmnWFDsBTyB4n8fiBvqyuUFpPMiU7YIn4uiTd9VqKs7rzyfACEp0cke1VmZKQ1zZxcpG5
 LK21D54OwTbEM6vhZk0GU/nkSHpzjo+B+Her1u11yKloAOfthoRUGa4E/cZZ4A5AMhf4U
 vLIbYuY5u46IchntxvM5oEiyTNKTkLp6XtrUDP0dEwSrpiLu79v3xwwfn7hp7RKz9nQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 spf=fail smtp.mailfrom=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K7nNV9a+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K7nNV9a+
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 117E4605AF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:16:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB780847F7; Wed, 28 Oct 2026 14:16:48 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD058404D
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 14:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so1687913a12.3
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 06:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793193398; cv=none;
 d=google.com; s=arc-20260327;
 b=eRxR4X8XvgdbONtwMFIkZUOHP+J4yDOTniGUGUd42b5XhjS40R2L3a39fUtYVPfnXP
 TXbau07e0wAvMHY0PHv6k6//mohUbFb5jHxg5SboRQp4LgRdWfOb51m4p/FXolWNRzb1
 u8eZE0kAOnsu60gKGtR79N0oeJCA83HchrjFwW/ugAcephDKb94h+kDgdr1b6dN/i+jF
 c0MNtkWDL9AtmKS77tLxQGFOnANY82ujD9xNGeGX9v20EhQUIUVk+eEdz/ES7jxp1Xx5
 T1GpCtUwiFWPc2TLmhSqPBrupC2PLXdsbAaRYtb3HxAo3xorPVBbGHd2DeMdFJhtBLAe
 sx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
 fh=70Gl7RO74cmrCn32ypcjLU1dMg5267mfhG4fPaLHv/w=;
 b=hOLT5+YNS1Lim3Jn8Ht9vhtvNGZ+98CgzFd8BzI5yQtD7Pfz9GtDNpiqI2Oc8EvXVH
 qLDkdyjcbXb6RHEDBsLNuynU7rLyAiARhWFmukUDq8IVayVhQ5dvwnxYtx8zrbO8IAat
 CtPF5qOv7HBq8cc/v55DgBt1GH22oomnozOba3Wi1xm3hrf3zEGSV4NknvWvT2o5P9nR
 +q+7y66A0kht+bWAsGZ9WavagdKGCCK6q7Vm5rtt32ONZ1Byrcabyo6GI9PZJ1xCAMt6
 KTrQden1R9obXe72sUYEDLD+ZUC+YT/GSjS5+TmVs+G6JCDsqpbwT8qQLjlTRwhCfVzr
 DaEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793193398; x=1793798198; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
 b=K7nNV9a+9hiS3vWP027jN1I3fnaXckx9M1hIissN4ts3YlXen2ixpGt5Ee0Zl0V0T8
 ZuQOkd7E4gcoLOHAAXMGIXaN7ETMdktTQXFlCJ9ga/l7dcwr0PGHRSD18B3aobmT4sYg
 lgcoZSb+AGbxCzN9P0o52S058SMDTX90EFm5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193398; x=1793798198;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hJAcFt4xiIA6T65CfBmhYBC318ye9zCYmg9eBq+bjX0=;
 b=OIFo94Hx49KHMgedj37yZMA9B+0JOGrorjDgEnN633zi/X7l0kiRIbG9IGrdhRA92A
 XHmBRp3+HzX7SLtImWUVtWHXukRRJTTCuLWIcI0sggP3UF+shoVnuiAnh7kPZSGCEZMl
 uOpMBirmfG961cCS3YvQOSvEte2V2klcAolmpXadS5SZ78qSBsHx6dtoGniAVf50mKRq
 Q8Mgz0O/86lRlYQrbVWeNmf5bQx5/XCvFSPfNwBI+9BPj9kul4uG06KiSKpPIOZODARG
 vhBPwKnyuhGTOVy9eu8LBxvGqHvT7erbSgDHr91BSkQq7qvDvxPELU69gpskSWkwUBJs
 7X3A==
X-Gm-Message-State: AFq9FYJuaDZOK4+XLfKIiEadaZfOF5oRg8dCv20wWmdDsfJdMD2KoVdg
 ec2fJ7FDOA95u8xvq/YixU0+4josBSLEAzrh20oZve3azsL3xvo5rs6Cts+Nmtwob3VlBX2svpb
 aoQGl6S7Inkgy+apmWFMyISoFcpDCPCCvz2uiGboX
X-Gm-Gg: AYBFou2GBjRnN2C+c/+hDC37lv49ZwSBPLD4aL0reZ6d2W1bJlO8VhhODCUogRDoayJ
 Y1g33orNaFElvhHvCytxTzi/jeWXZcD5Jdac4/bTKvPGHGUntsc34WouFYKf6F+njVX1Oej0jwK
 Tm0941GUDr0pzxbrwOj+RU2I8kyRzkSEEaKZS+KclSWVu+hdozxImO0WbhbWw3u0XKUEviZJVfN
 BG5FHbHai55hk3/uAfyhQ/thbiRkCgM7rf40kTM/J8QNVyW3BG/t4gEzeCAq0/ka7ym2+UzjfTs
 h2h2RT5PKB75eZBzLdSVJJq2v3PC34KZ6y00uS2mRPWBCqm8EUALIqPcSWD0XFhe8Wmx5xLFw1w
 nsmCndy+PbBe/BarvU4lZUvmjiE332wy+vCw=
X-Received: by 2002:a05:6402:2813:b0:6aa:ff76:3076 with SMTP id
 4fb4d7f45d1cf-6b49cc08c09mr1528850a12.32.1793193397637; Wed, 28 Oct 2026
 06:16:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
 <233a88cd-c83f-4e72-ac54-fa773b60ff20@ti.com>
In-Reply-To: <233a88cd-c83f-4e72-ac54-fa773b60ff20@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 13:16:26 +0000
X-Gm-Features: AclHuK9KwFzSQh-8BPzFKrN4b5tFUqwaXnNikmuMr9-P6xU4OWjlBms6kmg5vKE
Message-ID: <CAFLszTjXimm970c81700MAS7V4Os-J8MTDZgvHAo3GjjV1PXZQ@mail.gmail.com>
Subject: Re: Binman and blobs
To: Andrew Davis <afd@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neha Malcom Francis <n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 3 Mar 2026 at 20:03, Andrew Davis <afd@ti.com> wrote:
>
> On 3/3/26 9:14 AM, Simon Glass wrote:
> > Hi,
> >
> > At present binman handles finding/building tools needed to build images.
> >
> > There is no equivalent mechanism for the firmware blobs themselves.
> > Users must manually obtain these and point binman at them.
> >
> > This is quite painful at present. Each board requires some splunking,
> > reading vendor documentation, etc.
> >
>
> If the pain is in finding/collecting these blobs, then would this be
> solved better by having a single location for vendors to host their
> blobs?
>
> If we had one repo that we could point BINMAN_DIR to, and the existing
> "filename" properties would resolve and produce a working bootloader,
> would that fix much of the issue?
>
> https://www.youtube.com/watch?v=iz7l9On8qik

I definitely like the idea of having a shared repo, but who would run it?

I've implemented blobs in Binman just recently and it is definitely
better that hunting about for how to build all the blobs yourself. I
did set up a blob server as a test but I'm not sure it is ready for
prime time. Also I haven't yet integrated the new 'binman blog' into
U-Boot.

Regards,
Simon

>
> Andrew
>
> > I believe we could create a similar setup for blobs, where they are
> > described in the image description (compatible string) and there is a
> > way to build them, download them, etc.
> >
> > What do people think?
> >
> > Regards,
> > Simon
>
