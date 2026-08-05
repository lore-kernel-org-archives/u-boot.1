Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4481FC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1B2D80DE6;
	Wed,  5 Aug 2026 21:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aH-I1hTReFmz; Wed,  5 Aug 2026 21:25:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ABE480DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965151;
	bh=huR5h7NqvDhfHScrT+f0ds8/x4oFQzexcsGlyCRmO2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzsvUQsnd3X2ICyoEdzBYrOm1Gx6wTIffbcJcdAmw0HEQmiSlF2Atojx+w9I7eqpR
	 M6ydHoYX4pG4MT/v5bcjmck6TKhwzR4MLfAR4YJZyEM7RrDDn0wqsoHj3ndI8jVJWd
	 VHWCTyfWlOZOrVyspvzR2ujabkJ4rFw9ThiOU1ZZoNR9brHjfx/jRPuNbS/mva84TT
	 Jer/vAUpzx00TxiqPOnL7cFozbUXqcIQanBns4kgR4MmAjbw6TfIv5jmeCR+hq39so
	 wzxbQSBf3MH+TCHloDuwxtBmLXZM8IQGmi1GZ3UUwzzwXPIh0VCB/6gOhivoChPcyz
	 U5M/lhUAkBRjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ABE480DE9;
	Wed,  5 Aug 2026 21:25:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 523F412C8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38E4A80DE9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QycZI-zzeh4D for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:25:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4D17380DE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D17380DE6
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D17380DE6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:49 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso1931721a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965147; cv=none;
 d=google.com; s=arc-20260327;
 b=XNP/2vqR9i6yClWgGHHcYfjfMSM2DHcLbK2wP3EzUKURJ6LnWJ+SfJjYOu5GGsacNz
 JS2rr3xpXzq60ie0mjyjw8iWNrLT5vLHrzqi/1JTlpsG8t+u01AwZe5L7Vz8CJP/IW4d
 UEGpWUJKOsxO2celcalTgIlWkLcj5WOLCz71qh6fA8znzQo3kcjLFXXWEEDzoujEi74H
 /txCNOCEic7eV3lSkBlxCRpqROmV4vSwoi5o8vm8zXM2Xu4Vea++160lDPjhYBSjJU9O
 3jG+BisXPCCjte2gTxKnmINy4tvhaDlqedOVODB3AEbDzVVyIcaG2EKfXpu2/atqyy0v
 HUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=huR5h7NqvDhfHScrT+f0ds8/x4oFQzexcsGlyCRmO2c=;
 fh=oC6iYu3Ztt1o9pEJ7IkHLRTwgEEcJ0uGLDH3cUMq2IY=;
 b=fXOAH2xM/Syzya+tbx0GzbcqFiAUGaeJ5UYe1qPjyOJ+ESij9duYkm8NQUchEDb0mx
 hQjbRU/HlR0hMjtWIsgf7feDZmfjWR7S3J0S0RKSaGcYaArdam9q7R8FysAaa+EEM6dI
 3wzxrLpqQwWo7xL5Owij4HdMYRVqOFvD48NIVR9572bCmSdWkbXp4s4fwEWZe5LGRuK1
 6jkifP2hMvYYjq584lVUf3ob7Jgy2QWvWXpVQcHZgUixodb0+daME5nKlwhJrfS/UviW
 xON05c60be0CcO9kaw+1HQj16pGADmey3SNk2ol2F8hAk+2kbshpsrvpsKqXkZycSgJa
 2m/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965147; x=1786569947;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=huR5h7NqvDhfHScrT+f0ds8/x4oFQzexcsGlyCRmO2c=;
 b=c9WFql1IZrhTkYeD9lr8+D36h/Z5tOUgkhS60LKf+qZUk/ar1nz3z94FXcnhSWkORL
 rR7MGB14qKBwsVSmCRuQan0ZCz4lkOskUHduQA/skAt1O80e5QrgeTXHv1hZImJgpNZR
 fT6g5IO40gS07wA19sRm/NSAWCx1O2JE4/7WojGJGz1O/Giqh78lIkzj+VfmNANJ6GAs
 4fbKZFYc20eznPo+bVJ7eGCbVsTQ+BudUAr983WbTLYKVBliJNW0YggphQm9IJ+ZepTy
 N5JZc6qDYrPvFhEuBs7l4M8aPSPKQcuPM7Y5Gjuz9JUaE73U1nWeDMRHMU5MdvG28bEK
 sZfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopbK//xmgkh6OTYX2lCACybFr1kZSl+7ZnZhOZViu6pN6xepRmubssrQKsApRYJY3WmQB7QKE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxN9te3wZXfduwpw3QYsVebW4Wm+RzaGgqtUshVC9UYNJwrbs87
 bxTYR/tejUNgOEqzkc1VybBE2rX2t2ByUXjPLESlN/E+roI8ut39tmIjQ5PKtfIkACaawvST5q4
 B/pMD2GZmOGhE3AZGOiBWp6rz6P8/6vQBLLoXIf13
X-Gm-Gg: AR+sD13+ceRz7hdzQiCsyziqAUUgW2dERuIpivjreqJ1PAlB+EkNGObyk9JAA9meYNa
 yaRPcbTei9TLwjuRSj/ffr/Rd7m3SXuxXMVkQbSa02LHFAD4Upze685EAUzvx2LUObl2gjAXR2Y
 w51RnIt/rYbth8wI8NsquQLus5RtKRUecDtc8JjBDDTTaSOBkozbRyqGFsDfxDPjgjKlDsGwdJQ
 ZlNsMxADbnsl/+llS0np2/AkARXP4owkpmH8sOQL1wGsoBUy63fXFvgTgz53CzB7vsRScR15lpt
 U6DuSv1ZmC9KBWd2cFUgp3RtorZuHg15IzCTM8xzTG9JDxsz+qBCWg==
X-Received: by 2002:a05:6402:380a:b0:6a1:1e25:143e with SMTP id
 4fb4d7f45d1cf-6a14f07aa0emr5237130a12.3.1785965147362; Wed, 05 Aug 2026
 14:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <b5753fa3-d1a3-4411-9f1d-319915541676@gmail.com>
In-Reply-To: <b5753fa3-d1a3-4411-9f1d-319915541676@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:21 -0600
X-Gm-Features: AUfX_mxBZcyji7HTHWr8D7oyMywkxrmtvxj2YpCR2POSmFPcjF9HaggRT5CT-OM
Message-ID: <CAFLszTjhdAfFy4f_QNFw2SnQU28abXfvESQobVtyn3XizptBug@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] rockchip: tools: add comment section to rkimage.c
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965147; x=1786569947;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=huR5h7NqvDhfHScrT+f0ds8/x4oFQzexcsGlyCRmO2c=;
 b=Y8H+jfiXoAvjW4Zv2zsy1eyykR/pQp3IwBfUm9xDKUJYGUrgvTdCwF+kKA+FVTUSyM
 oV7OioTPBd9NEbp3+leAGbET4ROBpvR9jFTVOx5hO4GNDJ5AYC08Gh3fiiRCxpxIBIVd
 lMj+CGNnsg3k+wJwOv6Zxr8hPu5fkB6U4EiTs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Y8H+jfiX
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

On 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: tools: add comment section to rkimage.c
>
> README.rockchip must be removed.
> Move the rkimage comment section to rkimage.c
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> tools/rkimage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
