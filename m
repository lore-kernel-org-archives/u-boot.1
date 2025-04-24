Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01478C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A58B80F9C;
	Thu, 24 Apr 2025 11:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItBDV7LD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77B6815D1; Thu, 24 Apr 2025 11:16:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC87F809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so1539221a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745486165; x=1746090965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m+naocrw2WECONeHdnc9kPzL8fFwLDQpd6rKHRr31G8=;
 b=ItBDV7LDFK1DC9nJyRudOa/3rnNB3gtJg290PDU3ZyIfPNXNyDaWry1uBmox/zOPze
 7ClVDPdjn9yuJQ15dTgrKzuK27BbZGpcEq2T/4ZfLolyRr6A4OnVvsx8NrL7FaFk3BTN
 dhZyYW8sJBxCzCj8dajKsW2w8NuUs9ckI6vl9Si+9iKqEsFVsEu5wHda9Fp9NJ2TsIip
 WZc/xWuiKYlD/rkxgTGhx37ybjmrIMTY6p8uPyhXLguAukOaQUEjolX4kxq6GySnqON0
 sh6/dybRvpsx6gflKok+ySCw2uEYxt8Or4f1rFlaeGh8Pc/3fuwQBDmpe4vQ/Hr3mRJx
 1xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486165; x=1746090965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+naocrw2WECONeHdnc9kPzL8fFwLDQpd6rKHRr31G8=;
 b=puyXF7OpFNtSvcV7/JklcWWLzBI71KlpQavqsbu4W7cF7VnFdajwDuLpJF8T4Mh7H8
 xzjnPLiVcUQloM67pTdJ9jlxSatiSlqUf8mR1ZHGY0TQGgf54KeHTgU5EIx6lOnuKdTQ
 FV0qZyBiOzhzjPbNSkgGk2G0P5EmXKkZTQ+Z7JroQJyjkZjkYjQMi77OBftKRNW70vHr
 ES0vgATMh+qGwV+13d9uJ40D89z+3tfC3603HHOVkN13FBU/HZqUFSOb2LxNMv8EQcup
 q2/Vr1UCZ+v13RwdCTPTj00vyJgYVKyUFoHpqKrRJ104FGepBm+84kr6Zsax87mIdyag
 Rq4g==
X-Gm-Message-State: AOJu0Yx9zujFnhr1jBEmBV9Jz5x1+X4gKXWh6Jj7ic/jaRpcE5yF2t1G
 3r3E740CxfgUU3vex9AQhPAfxb00RHHI75FN0OTxTp3qbWYSNnosTOpjcwOjD1kXGFrflSjgmZC
 eZ/TqRmikKByp+JhvRHCGevd9d30=
X-Gm-Gg: ASbGncubC+ipN/FaPZ+PfCkkR4Jk9ywnRSUpfirHDAG6rPll/xUP5dMSNYTadu2awGc
 vVlxUTX4PGohBaHQmgHiPl0l98dq10KxILr5Gm8WNqalectLCXcv24XTZNXbeEu9O8W+EpP+Dng
 jdIXVRUfxOa1byIRD9RwmA4Si13DI6HPo8uXcvWtVg/g5AVMFVoA==
X-Google-Smtp-Source: AGHT+IHxYLq2rbkuExlqFraRO3Ef+ek0RMi3YbKVlJ+2U3ynIEN/J0EkbMn0bX5Q+vms/uKjPt1PSKdRrjujE+VpeuQ=
X-Received: by 2002:a05:6402:1ec8:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5f6dfa2f102mr1868198a12.30.1745486165049; Thu, 24 Apr 2025
 02:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250423213145.1959046-1-paulliu@debian.org>
In-Reply-To: <20250423213145.1959046-1-paulliu@debian.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Apr 2025 10:15:54 +0100
X-Gm-Features: ATxdqUEV5f7r4dbnt5tqUsmCR45yvcu0aqTiybAcEjuK9ZZtyPGdzCTHLktEj_o
Message-ID: <CALeDE9M12+7PMRqekku9RcpnJ2R8HBHdFrzxGPi+nN1F=h02Yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi: Add EFI Debug Support Table feature
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

Hi Ying-Chun,

> I implemented the UEFI Specification version 2.10, specifically focusing on
> the functionality described in Section 18.4, which details the EFI Debug
> Support Table feature. This implementation ensures support for
> hardware-assisted debugging and provides a standardized mechanism for
> debuggers to discover and interact with system-level debug resources.

I think this should be configurable, I suspect there would be usecases
where it would be useful to be able to disable this functionality.

Peter

> Ying-Chun Liu (PaulLiu) (3):
>   efi: add EFI_SYSTEM_TABLE_POINTER for debug
>   efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
>   efi: add EFI_DEBUG_IMAGE_INFO for debug
>
>  include/efi_api.h             |  32 ++++++
>  include/efi_loader.h          |   7 ++
>  lib/efi_loader/efi_boottime.c | 196 ++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_setup.c    |   7 ++
>  4 files changed, 242 insertions(+)
>
> --
> 2.39.5
>
