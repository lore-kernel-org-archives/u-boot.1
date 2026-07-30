Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF35BC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A22DA40AC2;
	Thu, 30 Jul 2026 13:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZdyXXq7w6MG; Thu, 30 Jul 2026 13:59:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A833540ACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785419969;
	bh=HmiBUziMo3G0WgawK8I7QAKD2gQMegp3GLyFx5+K93c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNYvXA56AbW3TxnKyWph87ucTFUQ3mWCuMoldXg9RAiips50ebLW08Vbr7sAMNx8v
	 +TahtUpIVqYOSz5IWCJ0ja1/u8AS92FIZe0/SqCWrmn+WGnDX1RqZZP5TO3Y11rp4a
	 CDdm5Q+fPiSwAjUvy4Zjya3wml+X7mgP91FfQQN0m5hCmj6k/t2J0P5xZ123EIrTzi
	 8VFU1+ttSmVqAtvGVwSzx1SyAajg3iPoAYWy9JEu7xPHm18nwERuFLD+wzcjAbeC5B
	 ghVpRDKVkJTgoylSnpziYvtVonY0bqM/aPch3tW44gKS2tWzs5jLUyuPZksTDlwgCA
	 9IXdrBHXmZc6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A833540ACE;
	Thu, 30 Jul 2026 13:59:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D9B69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 054E980B28
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wN-wazzJoQUy for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:59:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9920680C27
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9920680C27
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9920680C27
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:59:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530D5849AA; Thu, 30 Jul 2026 15:59:23 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B163B8498B
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 15:59:20 +0200 (CEST)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8f29ec73064so14147356d6.1
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 06:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419959; cv=none;
 d=google.com; s=arc-20260327;
 b=hpc7DTI4sT30rn7TXjQBXIDiqAB2b7fU2Ic8U4R5N0bOtvgnZLabetPBEUHnPKeZ6Z
 6AKNyq0vpYZsDGkGzQqfu1ZU8TqfwtaIFDyFUVCt0qn8TTv5x3dm+0CI6McWMne8YXKL
 MRuBLWwyVPGLZRB2hhQ8Z68nY/1t6rrQ3ZjCRZBQUunmEiVkVUZv8O85Cmph9s1R1NMX
 eNJqdZNJjO7WiLl919MtlKj8AxT21DCNCljm2MWsMgjd4MlIXRM49V9znzpN/XgM1oce
 6iAB35gMelITFxKfTSC584wV6cN+CPcO5e6AeIQ1anB4AWsaqZXGi3w0CD1ETNcvDf4/
 v7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HmiBUziMo3G0WgawK8I7QAKD2gQMegp3GLyFx5+K93c=;
 fh=RVoSddvH8G0KE3CD22tmq4htmO3nBG7sKD4SyG3Hn/A=;
 b=UkslaAzClehUQmBf1mfAfgLKiqOZ/WQcSPl5EQnJQVOdB2MWApoq6UsVr4+7iYXcmI
 y6BeSNO04YerSNpui7D+GV5cdFUXuRgkJV0+wn965wqf6rC20P7OEVHh1DBaRWah7Q2F
 uUal/vf9dRMHhiyW93QCrNQW8xoXkvm9ug7bawTXOhJi9Q4l+RMyqZuRI7feDjR/gAMz
 AfMWQkr8vLKs2hcDZsGYomQwt7vGVFlWLGC6v5lQeO4JxEpp2CsRngOLtvsSd2tCQ452
 Ry9tohBBv7/CxjWpItp4mvhrq1QmGCtwlvoU5u5JWsCEUhIlXYL7jEMi+4Wq9vqQ1ER6
 POQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419959; x=1786024759;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HmiBUziMo3G0WgawK8I7QAKD2gQMegp3GLyFx5+K93c=;
 b=KX1STtQXEAyeWCPWsvfdqMa8LcnS5Jbs7qWy/vfMdS9Id7BKzGzzPzM9ee6TildM9i
 UKY9d8xAuFgr2QxSKqNYfoIk+jpf519M+c0aNsA1ZAXMxaM9qQlDryy+widY7tX209i/
 g6Jb+3df4JTF/9oxuQMev0B9vudtSFIbWMzLC+KoUwhtV5565nmDg+gcosWtBrK8Rely
 NjQUZp8NeeL5iXBp/o2+r5vkrpqqH3L/RXkRd+IUKxNzuI0al+htDJSfDOftQmCz03ut
 2fwH7H54pqkPesjqCsOQRrYy7+rFeiIyhcz+fcz8lkMj9UsRO5zXhSAjQbiN2Lrf//0s
 HzXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbCMs+idE9OvutR3kxX2+bm1be+IibWfg8HfdYUQyVcnc3E6Ny5z2xPBw3bkcslKHjJ00JECk=@lists.denx.de
X-Gm-Message-State: AOJu0YzPfDmNSkjwH57xZ/teHyfT2nUuNLDOA7RuTpFVi5hUq9l8QuEq
 ZtDLPeRYb4sfkXQ9YliV3BCwWDakXIO3ydN4vYImgT7k2keOrOPtDlmsI17yl9NrESKuLr+DzPM
 KS5inHXsnFrq5LW8Y4u23I9zPXq+t/9M=
X-Gm-Gg: AR+sD10pxbq9E9DgOSPZKuxzaBGmm3oxqFZkNoUW9/3lwJ8RG5QQsFdCNVk3Fx+7iJN
 Yok5pP5+yyqgvaY3W334b9rCrJB9AUQjzP6Emqk0fuajU+tZWxcDw3jwCuxpJKN3UWCIsRbj4F2
 4rI2Llw8k+mYc3zOoEAcfme2UTSJRvSNjlAt07sOZ6CLOuoG6mahYKU+lwpqzR5+6R0JpLF9pKE
 h/XTy0uDKbFcjrK8epy9yKGmbunAYmjRzVKkhJbWfmWWsoPTavqw5+IB5D709VJsAJUQSbFSjvU
 nG1xZvdTX/0elSauVYAOBjNBvHmDUESOF4tHpFtCP/9GObRV4lcBICCzaXQ633YZ7EGD7H45SWz
 o0I+Lvjpd/UcWCcWVyB00e4/FZe4Vhll6zzzvhAmQua3fbliq82/zCbSgafvNC8DeCivR1gFWrh
 XVcgBieTrLK9cs666xRooh0g==
X-Received: by 2002:ad4:5761:0:b0:906:7fea:354 with SMTP id
 6a1803df08f44-908346e7645mr25167066d6.18.1785419958602; Thu, 30 Jul 2026
 06:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
In-Reply-To: <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 30 Jul 2026 14:59:05 +0100
X-Gm-Features: AUfX_mxuzNsbb5deisNdT7tDue-E-uksAfrFXOYBCTaj0c-MJVo4AsCinaFXcbA
Message-ID: <CALeDE9N1GUu7z2vL4SG+JNyA32Ro207P1QQCPUuxz6QycJ-dGA@mail.gmail.com>
Subject: Re: RK3399 TF-A hash verification failure for atf-3
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vic B <u-boot@vicb.net>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785419959; x=1786024759; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HmiBUziMo3G0WgawK8I7QAKD2gQMegp3GLyFx5+K93c=;
 b=lvMCvbvYAqSXOvqmZxEZh07gGl52uWJW86WuOxHf3O0s0a7uZuaeIk2QqKza1LIicJ
 A1EAsLTGXbbF6+70QETAtU0y/4THwf7uv1jS32ZNvu0CmXRO/aSOuygJQj0nREUX6l/+
 sJQiGC7jxO+kzUSQY33JOPySgrrW9OBlPH3eINlM6GSdpqdJLFShuvg8sRMK34GBjGqv
 GYA8sDk2auD0zp4z53tLXBY74u/W2fSeIiiqSK9UVyoI2oKuB5X/5zRRWhrU5YWo9uH9
 yVMf7v6Md/qx4G0FWrzY/5xBydLMJdR2D2osodbws341TnjyqWMevaTRzuTWfjUrayY2
 dOVQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lvMCvbvY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvMCvbvY"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 at 18:13, Quentin Schulz via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> Hi Vic,
>
> On 7/18/26 6:03 PM, Vic B wrote:
> > [You don't often get email from u-boot@vicb.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi,
> >
> > while trying to compile u-boot v2026.07 (or v2026.04) for RK3399-based
> > NanoPi R4S, I run into issues with current mainline TF-A (using 2.14, more
> > precisely the lts-v2.14.4 tag). I'm cross-compiling both TF-A and u-boot
> > using GCC version 14.2.0 (Debian 14.2.0-19) from Debian Trixie.
> >
> > First, I encountered TF-A build failure with the
> >
> >   region `PMUSRAM' overflowed by 3928 bytes
> >
> > error message, which seems to be a long-term issue know since 2018:
> >
> >   https://github.com/ARM-software/tf-issues/issues/650
> >
> > and recently also mentioned in this mailing list:
> >
> >   https://lists.denx.de/pipermail/u-boot/2026-April/613754.html
> >
> > Although some discussions suggest that this issue may be compiler or
> > toolchain dependent, I've eventually found a solution in Armbian
>
> Debian toolchain issue, reported to TF-A last year, see
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8.
> We wanted to rely on Debian upgrading at some point their TF-A, hitting
> the same issue and working on it but it seems they are stuck on
> lts-v2.12.1 (which is slightly concerning considering we're at
> lts-v2.12.12 already) so this hasn't happened yet. I'm building on
> Fedora and my company's CI has lts-v2.12 pinned to avoid this issue, so
> I'm not going to be chasing this myself. Can you try to work this out
> with Debian maybe? You're not the first, not the last I suspect either.

The distro team got to the bottom of the problem, it's an issue with
the TF-A linker [1] not getting that CPU errata may well be enabled by
default in a compiler options. The patch I think should apply to most
branches of TF-A.

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/53010
