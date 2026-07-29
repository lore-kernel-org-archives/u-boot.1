Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FC4C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DA8A811B4;
	Wed, 29 Jul 2026 13:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uMAtVLPiIkP; Wed, 29 Jul 2026 13:40:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1ACC981167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332446;
	bh=6iT8fCdPXjy5VxQ7gItSjL3jQm+1Z3pwV8GF72MVbSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZm118jPuZ69sNmcAtBbh82JNuaBTtA/5bUopYpwCUs1/PG4MdF+uExQbUn8bx8ho
	 jNWQeMF0m92Qa0UjrvYJ1EHzkhRC8RiIKGFmdbpvrL5jkHD3n5HRMe4L70KGPq++nX
	 MK6GE2XD+vdaocoULj8/10qkTfG3dKd74NsXHGRG6I7C9DR6p9lyjZcg1XWNw6uXGg
	 4W1XM8o85WGczwQHM3Zhik/DCbMFlKlfj4RYt+UxKRNidpbJ2Swjb/IX57DiS7BPjz
	 56fRgGs44lS3ZvYl6Mrb26cxSIkVILtdHvATC4PucbsT+1lmfQ/0QG9ic4KuslWiKe
	 H9OmPGp/2Jh8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ACC981167;
	Wed, 29 Jul 2026 13:40:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5632226C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C26840B33
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ku3zhrWnVMFU for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:40:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 50D9E40B29
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50D9E40B29
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50D9E40B29
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:44 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69fec980a30so996583a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332442; cv=none;
 d=google.com; s=arc-20260327;
 b=YPjJ7aTqx0GSicQAl68azOWYopDXBHhDMmyazGEPJJCkhasDC8QriyHxgNtxlvtFHg
 KQSN3tMod9vORzE8reRwHbnuIT68XGvOEKBLVxyaY9+D8c2CsvXiKFAqoyQd2Vb4HbRW
 21MlbLeOEJ3ZyoLn5gwWV3pnAWADLqgHBQf5mP1FRo8XqbOuT7Y7r/7FhYvbWeEjgWjG
 5lHS0KW7U3CiBNh5iFNMPjdy5TgoGtrp/zIVOpmhJ2ZTbnswFqX9eNAFY6mXcnYje2Es
 zSSY2KKIRXRuYXQjgSAToV3ObFda1n6qI1xr+Vghf1h7trxNXKOOHrM74QZJujCui5wn
 DqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6iT8fCdPXjy5VxQ7gItSjL3jQm+1Z3pwV8GF72MVbSA=;
 fh=B1Dxvk54ayXKp7SfellHA/001IeTuQc3B7CBARalrIw=;
 b=cviJDjNzF8CxnVqCpg9XT2YBwz0UgDzNtg8Gb8OZVvZI56i/sIwPKOtM5N1Fk3nJ+N
 hLlwkxZ9hQJLxUH8/KusG85H//UKF6t/reNgVzZbTwhGeCEkeOezDz6Pqg4eYbDSLj9/
 M9p1rddFWZcUBntvvAijSTrHcWtmOUxWmBA4uVt8DzZP75cJ2nM8MkhMecONip7ZTkCW
 WkoxQ5n3jnZGI6d9unCsRQFSsUJDJV/J3N3vgk/8ZZTuXGQmt2XGgprIfmkn1iw2kKMo
 S0A/O5XAlS5Usb2xs72SzNWK8esKlbyLBsPtGcm9hWWP07R8kO7+1q+ziml4v4jrFJBn
 Y6lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332442; x=1785937242;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6iT8fCdPXjy5VxQ7gItSjL3jQm+1Z3pwV8GF72MVbSA=;
 b=PwCRsKr1fC/DFpOm/IIrD4GqUFOAB6FNUd/mCKi/ybKL/Qyd6pj6TS/6arBOoLnLJ1
 wRBkuOUY+PHIFFXedBWCU1UfyOKjOURIenTho2fg2Bf8tV+WvZlcusXWc/yxBZDcgf+I
 6xT6mDCzKoDp5hA3ZAuO8IP6Xz6Ll10ftD9MhhpUQfzLgudr+vqHV6OMxqP8yR5I60iR
 1cn0nuA9SCpBu3XGmhJ/L1a82n8yclJMWH+SOzW0hY5KABbL7vkPCshXa8ApTbYKyl8o
 K6aQuB35Dpc+OPHQXf8RitZxoHe9y6yDX2P7G8aN3dM6aQEnFCeVdFGM9zZeayQ4WYQU
 0eug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/kK/f6C+L1TLGcK5DqM3lT7LIOaycsRKJn8171QZHi5fzpVnrMUkRs01HdmJx1kpxc8Yd4PQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyrhJYdcBrdYs2JZ2pC+yC73JmrU/mHRVM07hdyiSr9yw2LP6Po
 V8Z87kWDutku+Bai6xT1ZeYNFEqYPbFF4sZFDx7z1AzMk8yhfWwm4z4GW1W3uvacmO2sRaN61tO
 YzNzJVkRQJkF8KNaXzxmBmwWvYe7QPUKCnsStg5JG
X-Gm-Gg: AR+sD13MRZgZBeqHEfK4HsBamNT6UA8AJEVEY+P/t58DApnqis6mxN+LzHoitAZ0q61
 fwHIUClTodXXZboeINooW5jCYDwpUuQmzjTRWKwYG7xs2SAdhtT3xZFIHSFLRnN24KRsjl2zsm8
 xxIKhq2dkoKmXiG29fypt229wXiDVKG/EDzZ/cWlaECeI1Ejsy+jlcIgcHM1RJOuk33O9zQgPeV
 nvgrncbFiP+D7EFCYRKDo0ADnT1Wga2mQMfc3CG27unKJvCtq2C+IPgWpRa2FV1eU/sOnWTZ+tC
 TYId1WH3m4SQLe1GYTq2KxQPNLFtZZUG6Wt8HTACJFg=
X-Received: by 2002:a05:6402:4345:b0:698:be17:3790 with SMTP id
 4fb4d7f45d1cf-6a034a92d57mr3356781a12.37.1785332441875; Wed, 29 Jul 2026
 06:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <d7728192-7ec3-4c47-a4a9-70a85920f3e5@gmail.com>
In-Reply-To: <d7728192-7ec3-4c47-a4a9-70a85920f3e5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:27 -0600
X-Gm-Features: AUfX_mzGfPpaxj5HoGPTKZcS1EKnmXh-NlPKZZQmZz94xkRvWMgzDWr10SHLpKQ
Message-ID: <CAFLszTi1tfGVonh+QOnC_R9QqjFWiY-QFGWCz01kKcEdCyWuRA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rockchip: doc: add BootROM/MaskROM mode text
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332442; x=1785937242;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6iT8fCdPXjy5VxQ7gItSjL3jQm+1Z3pwV8GF72MVbSA=;
 b=TfzsD5dRwzx7UmC9S5+gnsTD13+19Yw09phZrMiMiYFV5YgMuBEMlXQvciwi6BPpS7
 Y//GwZ9dHG1sh5vrg+4XvMd1i082FHdzfvZUMsJuKbRgaYdstdVPKnMwvYOAu3Lkua9q
 PpSXSHtTLfRbg8XCqFgJDobMVMvElVnROY8yw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TfzsD5dR
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

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add BootROM/MaskROM mode text
>
> Add text that explains how to get into BootROM/MaskROM mode.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

> +BootROM/MaskROM mode
> +--------------------
> +
> +Options to get your board into BootROM mode:

The heading says 'BootROM/MaskROM mode' but the body only mentions
BootROM. Please either drop MaskROM from the heading or explain what
it is and how the two differ.

> +* NAND: connect pin 8 and 9 of the NAND flash with a needle while
> +  reconnecting to the USB OTG port to a PC.
> +* EMMC: short the clock line to ground while reconnecting to the USB OTG port to a PC.

eMMC

Also please wrap it like the NAND item above.

Regards,
Simon
