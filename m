Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95954C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 19:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8F880E1D;
	Wed, 16 Sep 2026 19:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6Hdn3z3lDAg; Wed, 16 Sep 2026 19:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5ACFC80E17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789586667;
	b=cZfgl7AFEXVT01PBcceXRrlJXad0Xr5Nk7jZum1jV7rCN3sQ+A+dTCfxkjy79AtqC+PR
	 6+c7Az1/Rc/zm8dOfz7Be6vSMd1I8+4nWBblLdSid3nucHhPCAdiauzLQxPiml6sFzDSc
	 2zo3KDBKE7GyZhEcNoEZgWFRRLAaLhtOnqEIBmbVbPtmXGTMVQQxI4Y/7o65PF+EqdFmE
	 QFQRgBY3cnio6DYzsfFb0OfFkP6y3XZ78KYudoP7ErcIiR0XkXWxoIpqqd7W3jWSv1MAA
	 4StBadK2xBBNcKO+Dhc28slSPowlfUt0ex9e/36NW8OxcIv6UprWhOYm6y0jcnw2Vjg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789586667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
	b=K9DMdvuiRpxkZfgyiorh+ofxP4u2uYSa9SdarlSg+UvkdQuy8vpe8BChsDvabCNl8qtu
	 26KiIh8qvqW6QQBd+EcXoun4BLYTn+KbxZDTcouZpmKpivYWSstScpBvdgoQOmbyDARKb
	 E/9oeUNuBy5Qwz+bbkFYn1uxBgBQClBPH8GxbWRqcPYrnO7mgPP7A3K61NchTNdujN489
	 QNSptIHaR5IUiKBBX7dWsYP15PWqX8Gs3UHe8+8Eub2LxU4k1M6+nCiXVaEV8n5bq7UGP
	 klZW9KW7PIbkrbX6o5vUs4N7x3QSkxmG0lTZxFqGi5AK1YKWtjVpmtbulzCkqDSmr6g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M51EEPpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789586667;
	bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0052hHwCgkoQsVtYI4NEswFTf7CWC1tzoYWgYkXRrV54iVPD9Vs9xK8BFz9xBCYLk
	 2GuLHK3UJpmeoCb9p5k2lnFcLYTPlykZU0BIAYvkIzTAHQEKk9HhZzI2tQyth5sZTW
	 o2Ho8RgjPgJVok7oadOWtZ7aMPIuwmr0ZMX1rCdy0RcDpbpQ/GnLgLoll8GzhpS3fo
	 FtD8Vbc5HFBAOavBC1lFcZeJJ52oRszZT2awtS46hmJnEb2LnU+/gqX+zHYG5cfeRN
	 iPQ6SqCWly53JBGQNQEyAVxiREuaOtSjIyXHCVXRNjr2f1NDbn9eTjHzWU5Oxe7sHT
	 w9LnpmUUjENoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ACFC80E17;
	Wed, 16 Sep 2026 19:24:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EF772EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 008DD80E17
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zmy-HF28ZDiC for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 19:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD3B480C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789586665;
 b=JEIAyUdnQGGNOk2RiFAMH2pZmDYr1PQrw0vSUIf1znN3aMOpIuCeWKIoZK8x5ydZ2LbR
 ciZP5yfgSLe9a5dmDrmOFIZg7f2Bhs2KZ8zlKjVxpPd8OsPfskRQ6lgaqQtPGMPdJUMbT
 e2Oi3oakEEHdJ7ApfOVC+I5kpDAawd+NryY/gV/lShfyI5wnXVbkL04uzHQ9gd3y3b7eY
 23pEYu+QgwxSGBgaZqh3Aa1sKFjnTyRHOSQge+UmJnvLpQSNx+Izs87a+NoUhe+mW+On+
 F2ISijzvuWMtLjih3A75KiqwxmKonGkVwoFya0xiDo5p3lAgP3baO3QJ9rPbBfjs/Bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789586665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
 b=GQ1EpueSCX1D3LkYpwddVX8FMkGY6cDl0LopNXqFVQ0WhjDYrIRM/S4OQtYwvSOJmPvV
 KL5Q0OCa0prto63/loWheCq9MgSQL0v6sgbaEaXrtcAC5FdtgS1E9CQgb7SR2J5nG0uc2
 mWxMbDjpuBoJyUyOEH3Y/rYXsmFyH5kdVzPS8136mBc05FYLFG4kqOv/6U1h52NTnRLj9
 Rhn7fmx0jQiPkDn/0CflLb7phkddq8Zev2RF/+GlCFx2/YGNfoknPO9b0XzRIhaSwjfRR
 6w7rJEKS7lXMOZvBCPRDujfoLD1QhnTfwuXiFhDBJrxCI6lXxYuthfh61W6QVt3HWpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=M51EEPpG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=romain.beauxis@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=M51EEPpG
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD3B480C1A
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:24:24 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a98dfb8002so144767a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586662; cv=none;
 d=google.com; s=arc-20260327;
 b=fLT4eOgm8uvLTXqsK5cPAIO6i9cbQ1Joq0QWOAoQYOokaBAJY9kzTnaUDS0wox0c5W
 YpjHSPXCuErqf69SUOxPcX2Y7J1gYleaqozrqZA4Uk4doVqkHu0UBxObb0ti57zIlOeR
 935KJ523Ln3XNFd4KlmMLeaZktHHTYwCKFqtv8wQtY07saSJFNeXWyf4NlsQqqrWUYYr
 2gXC+l/XQEeOLLK+trfD6pWFQ6DMu+lF9iP08AxOoQikV0h6II/qoQtKt5vaz9o/SFbi
 ghlw5Y4d5vUDu1IkAzUu5Wo3Osenc6s6aVEnLBhaSUkbZLeif+HeO/VsPuGJ6mw7UYxA
 ADug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
 fh=yIE9CgBYLQ3ZvCeWV3cxEF+Jts3RFpCxY/ikp2tgAxI=;
 b=k+Pq12g9hnbmc2PMxstDNh0upUijc0ae+UPm5iVedfRhyn78rv5C/HJYuHQxRO/z3A
 jXhYhiSWp5MnV+YrIoT18PFpwwHsSMYaLnZaYlXGwfxIPBBT+VhuUTIUBDEBQKZkDtl1
 ydSN6vcNWSFqLLJo8f0uR0G6tPjvtsO/fTjQIcvrO571lVr75iE3TP0IZ58SVJJULTGe
 DyxUGPUPTZn8dfBg7EdejO9coFTCq8ewiHVRT8iX9Qet6u8o8HCQrDiYqhvyDQy0mkKC
 NXl6OJpKVxakrtltqILdpfDdMcHIx6xTVQ5MMJTA+HG0e6qY3dWgKudYq8LGz4y9TgYb
 EqAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789586662; x=1790191462;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
 b=M51EEPpGYp2MfGVASH9MQ69EXHU4O8u/OsIjrAKm6QWFrvICXYonSSjJorOFpKOOfK
 gDcMjRHnUn13U3cl36CICZf7dzb7s4wGJ2jtZssTv8AGqGsGijfR+zUU6kqnlrw13LQ0
 znuiRkBJ+jIdUmjhwLJ5YfbU3ykbdx6HwGyATkYAT92dgJiPjyqJR1CXwma1UI1RRmGr
 i9ERUAsGZfvfmk8jzwvl5cCk/ZFdd/FnMp18e3RbUWLOiiAQPwqNXnlokvteu6qPwXAD
 TWWQNFt4puiftFvIbjnG+QUiY3OUQTA9YlIp+RrPqiJFWbxUAm6CYsJpSiYVaJEKCNic
 nVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789586662; x=1790191462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BGS6YBxr5sWMkqx37aSXgANIcA8dN8TZHzlOalX72Rs=;
 b=arJVzb7fu+51HEZpsIdAX/sA65NeFHB0jLArvM5HzUQtJCd8bxp7Zg1Aq7DNUhzdwY
 nNpf8y6KmuC0YBqWckPnauraPrV3CxVWy5C1OsWlIF0wwaZQ1Akc9TdvwUA0BGqnvF3y
 VSj7aTHH73HG08BWjfNICtZ54Vfp4v3zoi47YYBB3m1HbdATdakl5qkcO4PA8thoYIJ4
 LZqdnnCwAMH02dkOuwva7l6wNXvq+7sh/mCECteys/ctTQflik0op2RdNueqITcxugiT
 9lb/TItYDX547o6EJdTmSuw61dRf0dPOsmI1rSVHTPT5y1cimSm5jd4D+G9E/S3sF0zL
 QSHQ==
X-Gm-Message-State: AFuF++l5dIjn3AtEcTWyICiOp6xy3CGU6pDl1edS9RjLjzIvafP6noK3
 PERXtrzlBx5zA3EYTqV30l1vCSqF3bwTlWgcuZE561PyZlsGfQxTgOtCigGjFdfPkH1iqpnbchE
 b2zRd22yodyHI5mLqUOojYL/YHEO4YII=
X-Gm-Gg: AYBFou2fvCatpmjuZqsnt9120pNOLNUcCtmH8AwGVM5zhqyL6QwLkqfvOsHKQDXro90
 Y4S6O2Voxv3JSRqp1RL0D9y4vxNs+n9Fta2u7ml43Tf9dfeaKVtvVhqVAI8VlX6J5vtYvE4xgV2
 3WfMcdvkmLhgCdWJyVzz2LcHhS59w9fHxpPpW8wlBOQtOtFdQI2vP0jKlAo3ufezuT8YtiiayGE
 6W+nX49K7neBp0KCs4Rot5KrSYCj/QMkriScik9dqsTXMjk8Vy6b/esghKjsiC38h/bmqwQqwas
 q5KK2SlBr7PEJyCay9Zuvf7e2+H3NSI3ON+Zeqv5uN/eu8eRgdrpsFJvZu+9dkpOclW7wT4xWr4
 jXIGTBarChBiRY7iydarHuXJ9c/V7DV4FvCzCNzHVqsTSLDlvmSFdtdpeR2IDoZ6Pl/nj
X-Received: by 2002:a05:6402:3054:10b0:6aa:28d7:5b15 with SMTP id
 4fb4d7f45d1cf-6aa28d75d9fmr1960448a12.16.1789586661908; Wed, 16 Sep 2026
 12:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
In-Reply-To: <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
From: Romain Beauxis <romain.beauxis@gmail.com>
Date: Wed, 16 Sep 2026 14:24:10 -0500
X-Gm-Features: AcwNN1Uj9E5A7XjUJVkW-18M8VKf-bdn2GhmiZO1lSFMBL9ClAEXlFAaP1R-_PE
Message-ID: <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>
Content-Type: multipart/alternative; boundary="00000000000047237d065b9e9d21"
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

--00000000000047237d065b9e9d21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 12 sept. 2026 =C3=A0 22:04, Marek Vasut <marek.vasut@mailbox.org> a
=C3=A9crit :
>
> On 9/11/26 10:32 PM, Romain Beauxis wrote:
> > Neither bootm nor EFI ExitBootServices() stops USB controllers
> > explicitly. Both only remove devices whose driver sets
> > DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
> > controller brought up by "usb start", e.g. from preboot for a USB
> > keyboard, is handed to the OS still running.
> >
> > Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
> > is the path "usb stop" already takes: the xHCI is reset, its PHYs are
> > shut down and its clocks and resets are released. Child devices such as
> > hubs, storage and keyboards are removed first, and a controller already
> > stopped by "usb stop" is skipped. xhci-pci has done the same since
> > commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
> > have ohci-da8xx and the cdns3 wrappers.
> >
> > On Apple silicon machines the running controller is user visible: Linux
> > does not enumerate a USB device attached to a Type-C port at boot until
> > it is unplugged and plugged back in.
>
> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is
> that not sufficient to tear the controllers down before booting Linux ?

Any idea how to test this?

I can confirm that normal boot does not work without the patch and works
with it, that's about as far as I've been

Also tested passing an explicit usb stop without the patch and it also
works.

--00000000000047237d065b9e9d21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>Le sam. 12 sept. 2026 =C3=A0 22:04, Marek Vasut &l=
t;<a href=3D"mailto:marek.vasut@mailbox.org">marek.vasut@mailbox.org</a>&gt=
; a =C3=A9crit :<br>&gt;<br>&gt; On 9/11/26 10:32 PM, Romain Beauxis wrote:=
<br>&gt; &gt; Neither bootm nor EFI ExitBootServices() stops USB controller=
s<br>&gt; &gt; explicitly. Both only remove devices whose driver sets<br>&g=
t; &gt; DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, s=
o a<br>&gt; &gt; controller brought up by &quot;usb start&quot;, e.g. from =
preboot for a USB<br>&gt; &gt; keyboard, is handed to the OS still running.=
<br>&gt; &gt;<br>&gt; &gt; Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove(=
) runs at handoff. This<br>&gt; &gt; is the path &quot;usb stop&quot; alrea=
dy takes: the xHCI is reset, its PHYs are<br>&gt; &gt; shut down and its cl=
ocks and resets are released. Child devices such as<br>&gt; &gt; hubs, stor=
age and keyboards are removed first, and a controller already<br>&gt; &gt; =
stopped by &quot;usb stop&quot; is skipped. xhci-pci has done the same sinc=
e<br>&gt; &gt; commit e3bbc1f74e05 (&quot;usb: xhci-pci: Add DM_FLAG_OS_PRE=
PARE flag&quot;), as<br>&gt; &gt; have ohci-da8xx and the cdns3 wrappers.<b=
r>&gt; &gt;<br>&gt; &gt; On Apple silicon machines the running controller i=
s user visible: Linux<br>&gt; &gt; does not enumerate a USB device attached=
 to a Type-C port at boot until<br>&gt; &gt; it is unplugged and plugged ba=
ck in.<div>&gt;<br>&gt; boot/bootm.c bootm_final() does call dm_remove_devi=
ces_active() , is<br>&gt; that not sufficient to tear the controllers down =
before booting Linux ?</div><div><br></div><div>Any idea how to test this?=
=C2=A0</div><div><br></div><div>I can confirm that normal boot does not wor=
k without the patch and works with it, that&#39;s about as far as I&#39;ve =
been</div><div><br></div><div>Also tested passing an explicit usb stop with=
out the patch and it also works.</div></div>

--00000000000047237d065b9e9d21--
