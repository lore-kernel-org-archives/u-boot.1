Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A5AC88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107E14035C;
	Fri, 11 Sep 2026 11:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLxBvlxnFfUH; Fri, 11 Sep 2026 11:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2850240334
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127093;
	b=ZnZlQBfHpZaNynCAixEpcAoZoiLbs5VElFa0niJ7w6vIue4ze3jckhqDthw0Y08cP5em
	 h47M7ditaJ8VlIfjdu/al52uFVnrleXCIPpJUVrLh4zZxT+VZEbqRSOG0DGyV8Gi7mSZu
	 CKPzpOFxeYzlatlwK46CYhEGP4xZ9cTUJ5old8bw855GCm10cK756Tm1cqpZl2FroWQWZ
	 45ebZic9rWO5ysMhoBHBcKmdZP1LVyUaElLm441X3hh/Z39Eak4qDrrEojOGdx8YnnnId
	 EtkSAVGrFZ/mhzFDrZOHvyciHrAlXk6OzJqA5PuHFOC8I9HDRjoXHgVQk5GXYWOt02A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
	b=jCx9qHJao5kOcjbzm1FDiB5GAOiTgXoEa+7/tArjOvBWUp33YXDezOC/QplsllLRjpcz
	 OtHKsukYYCmg2nYszmIMdW3dH0a+sbsxlQCG8eUWQQAJ+dEjbHwO3Cff3Tw9DwPYWHYzg
	 TxYHtURj1H4E/6REasVn6YV3KaMOkm1GzhLRbj34uAdDACd2Yb/Jqdp2vSYNEd3eRf6cT
	 qMbkXQKqbCxW0BN8KJqLI/sHje8VD4hV85TdwwxJ+6M7Nw4/qfYjFxz4q3fYx2+1ikrSA
	 mmHW8I2/VYSGabwwI7MT6/3JJFl1oxlkFoH94PMo60MawTmoIwnqSSEh11Y3nw2DHlg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127093;
	bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L48jgtjx2BUnn3+RepdpXYarhhliym3qEQuXznTnzFV2iBkpIL6gPNDYQ8c/ioPc8
	 UqWWfn6G8XQYaT20r1FqEQE8w228qvieumsCfFx/G7qg1MBk4Y9WbtcEE92L6gZKaQ
	 Jl53lUWJWSLWyO1auM3UfJfOPKkImRGySWxZ/y5YqvWqMF1ss+O3G9XmFQapFLUicS
	 WMuMg8ab+1tQfeKsAYFRQwj/BRUrL3V2pzayf61CgtCng2cOY5TBE6lwvAMsEelxB7
	 DK7YdFsZRGnqOjN97WusqO3ZTPIQfpjaBS5I8DeRxfuib7VjAOEmF9t0xp9c8HVpv+
	 H+nqsMYYfoEYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2850240334;
	Fri, 11 Sep 2026 11:44:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 10783769
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9E9880D7D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAL3l7trc8An for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A063D80D64
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127090;
 b=hNvVf7exuQfkpP+O3DMHWJxV9Rbnv3Qd+vjin1o27YQbNqaqSph+jMeKnJ8PeqyKWWCm
 487NHXsO/8XSwQ7tPbTcfpYKwIS8RVS+CYpvI9TcP1ZzJoQlITB9lgNO64/wobLEo5sBz
 QrDtFfPXUtgRqCBDox5PWMDSlNRuEY8teMpTJpYQpdllmgu+BYmQVUlJ963j+bhW/O1lU
 4wJRIglWZHKByXQU5itiydR4GFaBaO+9TO5QNK3/3++AmlxsuBLUFPe26MWlot3/QvbYR
 9pTD5XVNOZyqCs+J4PiqeSos//bMMQgHw8GuKYfnLXmtyduL3UOzCTQoOYTJb0OgZMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127090;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
 b=tb47YrJuZXVSB8bv1/q/7gFdv/hQgmCjfcqZlPDsuuQPXgka25RhcAJ6LiwNQSlANOFr
 0P1UB82RO4vBEZhI7juap+L8Nqz7ux/S4nzxDJaskOJmdb+D8HOQ4HgcIC9CoDJaLol+w
 UPsmbEh2pTn/rkOCZhcf6RYOsnGl65tobvJvckW8uiSignZyXdbDsB163gJiHL9fPwM4+
 RdqmO5A8Er5J4LMHpId5ICSEzhgnp0lk9n4Im0k6eyfj2nQUiamRd0oe7/b4XIg0nUiCz
 /xLU2NxP6Cv2Yi74XnoW+e7trACDZX07B4z/hlOA6atm/DCqKrm/F4biVoUz1J1b8Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=W0FVwlox; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=W0FVwlox
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A063D80D64
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:48 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a68279dd86so981467a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127086; cv=none;
 d=google.com; s=arc-20260327;
 b=iSKNb3t0OY19EVwe58Zo+BxNrQZ2b7g+opIlS/jketV9bk5m0Anq8MPfXFeIWu+1+F
 IiPgk9npzfHBgHLZBUZaiee6nhj28uCjylHCw9Va/FkoC/bY1jSkpVmoiWrvg1hpogEs
 +xzj/sjQjVSPPChqwHyJvv5GylKbA8uoWDwwB6vn16J2FrhozIaMm7RMWhwoC0oD04VK
 Ppde74Q2A0JHIIPEp95Z9jnlZlHfrR1isBdBThnD3ccu3Pz1zhlZWfcqIxe30gWcfW36
 WkTy4vWpLlaabZwyw7Sc/OSn6x+a8yr7PjhF/Xh65DG6j32fUXf4daxNTE/wEZUXHEx0
 E02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
 fh=/Wh54bq/3YE2e5MESoOG94IpoiMu++8iZP16poUkR3M=;
 b=j11q5ggKQsEmZf0aak58Ye9LC4svXBdhZwVeA44PNQXcWBOEvtl0L0DcB5f9zwlc0B
 c4u2frtP2yQDTRd5gYMmonE2jojxB5Ckpt1ydNB0iSJBHJ65k+RMfwXEMW8jxpuC4o6l
 5tDSccYn6VI9eSHdQhVTM8TShxFGSf+iYUol3L8cx4l9R1MBw7mwpuNQ0HEY/h3W/56w
 EiTk5gggi4HONVPc9kak85CTIR5FVWtgKLBePc9BPPMPT+E6wK9qJIijQDGlLgPWoJ/Z
 DCC2LvFoPKPPALocwM6ammiFX3NgbKGMvFDE3G214TVEUvWq2d0P5tfAwtLzvCW0vldd
 2oVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127086; x=1789731886;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
 b=W0FVwloxilqdiqOsaOHigDypKvf3WtGgq4ZoQHZfsRIJUan0drIStt7VgA0TO++14q
 r2V7lfNkkzUV+Gyzujs1VPb+x+PuoOT9DbcNIeQ3G26jloiNGX78muJ1YbONwShQym4q
 hl6O2RWqGJUHXrDU3O403tagUWwMHShmkz5TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127086; x=1789731886;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
 b=QfMGK9S8+N05kr0L3pZrRITFcWdtYFgXeWd8Jr6jo/4Z2PPIB+f0P/U4fj3Rschv1r
 YS2ygJsXfjS5kvEVsJsk2mjZLKRQTY52XR9mpV/nNdeTpd9XZGg+OmCIQTwSFDFXEB2n
 L9BUVnA5VUPvEvVcc2J4Xh7mHCr0NQf9TnyrcyV0ukOAGYSw3R283yy4UHRayQiftEl7
 Fhq5R6s/h4H4wNreh59UlzWdjBvRJ7o+0G8nhcL3uVXSJKROltuBJ1V+jFFLVD5bFKZx
 Czw+hW374DLtfDaVIBsTi4WPBAWexnzmFeLerofuGTCiZoYl9VM2MvU01CtAOoQQSxyv
 AEeQ==
X-Gm-Message-State: AFuF++kO7UfbBnihWiQP6fOJ9Jzf75Z/5+NXXFn6gKs/eYjhaW69mlGd
 1mkRu3fsJv6a/Jrn1hEPAHF77SOgj4tH3YTy7y8wsfcsrYBOt0FwaudSH/mb3aXVqOYsYHRnupu
 d1ugsuuA4NfcxPsHoxwFhuC5+9mbQ3J0MLAPYp/yU
X-Gm-Gg: AYBFou2CYpyEYJlKQ3otL/UpG7C3xN/96Bc3czhvAYvudTvRXtFubjCQXAtDwp8F8MP
 tzyrfulQzOdiWx5jPXKwkO1tEbkZIJ/dWBK51qss+ZKy7k+sFWTTjHSa9Qw5JQHFvxDACRTQYvK
 dHmyozZk2o/BigY4EQPYumkpxrWfshZVu14OcntskFyJ/tfvGjaGANs3gYv8sxcy9OQLfP2ClSf
 l5RBtcr9gh7g/aEoHTECAJLjORudR+Ksz7bdIN8c4hx8dvOM+MZtvXp/7J1ISNsVp3Anl2ATyme
 MtxlimkaHeQvFZp4SQdYrCjEZkZc+k7CPvD+ej6+CToE1lZ6oBf+tdU=
X-Received: by 2002:a05:6402:3259:b0:6a9:9833:2ecf with SMTP id
 4fb4d7f45d1cf-6a9b561d545mr1323232a12.10.1789127086438; Fri, 11 Sep 2026
 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260828210003.823954-2-foss+uboot@0leil.net>
In-Reply-To: <20260828210003.823954-2-foss+uboot@0leil.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:42:55 -0600
X-Gm-Features: AcwNN1WSqFAXmuRG4hpTxN_El2LNXTd9Hv8INRA_V0L5wmIWZ78w_gDf1PUfTRo
Message-ID: <CAFLszThBsKoFcFyGgetiJR-0X0r97P9xwdRv77JEFWDF_vj2Mw@mail.gmail.com>
Subject: Re: [PATCH next 45/45] binman: gbb: update link
To: foss+uboot@0leil.net
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org, 
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in, 
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de, 
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com, 
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com, 
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-08-25T16:49:42, Quentin Schulz <foss+uboot@0leil.net> wrote:
> binman: gbb: update link
>
> The current link results in a 404. Looking at the Wayback Machine[1], I
> found a similar page currently being served. It's probably very outdated
> by now but at least it's not a 404 anymore.
>
> [1] https://web.archive.org/web/20230520044331/https://www.chromium.org/chromium-os/firmware-porting-guide/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/binman/etype/gbb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
