Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF00CA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 09:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5D52410D1;
	Sat,  3 Oct 2026 09:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9UHVeGZmVFZ; Sat,  3 Oct 2026 09:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7972410CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791018387;
	b=qhiJLSeEqfHjrqAcVm7o8pcQHUM4T1vnX/R909I6sS2ahvhemlT3KWj0BcIWp2WLguxO
	 0KmAIqHfeuXsY9qJC1ibY+r97cCLIpPg8AUL+jAnysaaY2XUtkQY39f2uzesfbCU/E/X7
	 /aWGYstFNVCEO3EHQjhP92yTl9GhaxsOOG7y8ZO6GupieXrCtxKSDCdOpGGA6yHBg9daM
	 TtiOUlS3SEZGM0XFl4q6NdP60ZRwsk8hySxZdufablzbaxp3crqPhkiXz5BJhmQ3ri+wf
	 1rM/CdrlhDysoGVyBdAmVD+D6jq51Ky32vl7NjjXZoNOcgZnyMbH9zULMYtkZRrgolQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791018387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
	b=nWomIwBtnbPfCtC75sTyFhdxtA18WoN0H2IzHObkhWz/4WK3QDx37CbmOnrWt3FXdPcd
	 OCtAI+vU7u7vWEJmVKbVHcSQ96HXqvRipp8o5rvDVU5k9xw5O5PMCB4muBrRNWdeoJK0t
	 QkMSQuoYL2M+2ahEp71R2uMkG4Gdtj2AMh00Hu0wBQDbTtbC5DNW2L4+EoNPR44TmS0qP
	 O2rHeYk/04mEW7fKbvsPRFfExmwagqoZE8DiRl60myvFjTeuuL+rv7LwhsgLl5Sx6bhUa
	 iIJjbHQR38GKtTAJbTJvYFx2sNlEbMOvReYZCPgsNj0ZZdjgB2/nphAKEdev4xQlFew==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791018387;
	bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rbd5C3PhEz2gup5/sz+z6MhRxpxUZm6RfZ+BgTyUEr4ywEqQ1oNQhR07BZQ0I9YL/
	 pymnyzc8+Mbmr+3zWvxYX+j95BpbdHxuxOouXnz3LVb7gZEPUGXQCqoWi2pde8z1dP
	 3WIzm3jqvVT1xqIn6LSUoX8m3LcF6OXFS1nOnJikEDw1UA5haRBhC2DF6kYgO8wg3a
	 ke9KDaPBRe2GtKRnvr1hs46oNTgRBqURPlHomSw8TS1E/NeXHlKyXo+J9dLDh0CqID
	 MPVoAssLdPshLQWrbsFTPlNAUdlIH1jUnoe8Xv3B/OrD9Syil16wnfBm1oMgp3C0UB
	 sOuAiusUQWKDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7972410CA;
	Sat,  3 Oct 2026 09:06:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85712335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7778660E57
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGv8OspL2CCl for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 09:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 989EE60E53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:33::23"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791018363;
 b=juNPRlQX8TslSvS3skbwmkU6elakxKE5ADEVeLWOL694BXUDE6VYpNgrOdL8KfBLRWGV
 U2FCBE8GNk3MsuF4fp+kZi+ixGdSu07UB/gZSjN8MMOsoT6jZJG67dLpKd6CK1bTGNk5+
 L1PXDhVw01UCNg27TMGypE11dcsCkjpgOG/tsaNkIS185L0lVJjsw9dRlLLv3pb9/TmuO
 nX2cAogejIUBMNr+iP7mOzaF6pWA4pUZhr76FHmUdVdRkczUuUiYR0gZlQS5x48QdlLz7
 +VJKLYHYSMrkYAzuA1THYLz1G7WcdzCwyvy6LdHQ3xQGWQhlzQsA9UZnn1vMq+OOKng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791018363;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
 b=YUTizoRn2qhOcJ9sRgUth+408p5GcQUZ3NhXWUPxUu2H++PFXzN8JmXdItVD0Di8aAFx
 +AEMPAzpzdpkSfH99WhXqLtjo9/v349ySgX4AxYzEfxBKXwYDubW8X7Ztz3t49Rq7uHsW
 JqoTTTT5GWBIrVd7AzY5SI5oEl5qTXiZ/8x3gjCA/CkmoAuxl43DalgXoOHFXxIJkYEG/
 fMJP/erzL2/jf0P8DcmA+bhAbWTDHRlWwujlMG3fFtmtllpyevsAjc7WMEUeV9wTyYWwF
 zDtQ5PtGIBfqZpZHBWK+TAaLr/erc7zqTA6JF7fsDrBmk3B3CXeaUuSP7z/8YUREQZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NG9UoVYV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:33::23"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::23; helo=mail-qv2-x23.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NG9UoVYV
Received: from mail-qv2-x23.google.com (mail-qv2-x23.google.com
 [IPv6:2607:f8b0:4864:33::23])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 989EE60E53
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:06:00 +0000 (UTC)
Received: by mail-qv2-x23.google.com with SMTP id
 6a1803df08f44-91219376dd6so8204916d6.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 02:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791018359; cv=none;
 d=google.com; s=arc-20260327;
 b=Z2Qzgvb+Bx4Dn0GRMl/zrb15/C+3nBAQkcFQGUmgX2OhKsFO6gjddKYsTezGTo2bae
 5ud08C4N+O5iB5bw8IUw+vcZ1ya0DWHJ7F7k0vloXQlSMZjwhuSBPdoXINxzL//cw/+l
 uFSDBDZvpjsO0wyWoT0CK07etbdkx/1JOtpOQk+3mKq1fKLsIbf5wlz2VJDv4c7Dz9ly
 iZyqTJfK3G4vhDEUuxtzHWeGureG0evEtl9Ecp89b2FHsxpv7YYKuQ1oS+hraMMYetra
 DBPblf5T5OtvPiA7J2ilGXxdg9pazU21XEB+Ypq/CFdd3vQiuGH3eRctuS0HGL4gNTIp
 2Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
 fh=IMCIa7j8lzuPnQQaj9AHs+wCNk/7v1WIbdAWNgiP6ug=;
 b=CoHnWXNex+DSgck0uXgCXq06Ac5KLg9w4bqJHwFc/NdzCsBjyetm8e1rO0V/2YuHd9
 wPmCBYNKPGMdqcq/USssHSmKVvzsoi2RPara7JFkdlxnLJItjaJ44adUFNaXEtTCzl/G
 wXRHyP+Z+zs5bNjN4B5KJQXmULvuPPuzse0oRhs/bv68pouYGJ8NR+5PP5/dvAn/EkNo
 n7JAsuRiScdc5EplEtlOxqTD9Ynvh6LX2wVJ44urdUHjt76K6zKIUA4crBzXvE1et9uF
 zWT8xNTHg15YXayaBGrpnlLarqvenhOltx9hWLiAfTOT+UYWkf2C2ga8Ig40PoJtQir7
 w8Sg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791018359; x=1791623159;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
 b=NG9UoVYVbKfkROxxRQ4W+kDRVXd10tuBdIsWgmeWXmwOMNX8aRbTrfmuZfnZ9E1PpX
 aJyRVtiBphr670EhWYMC/XZ527FUuxZG7qPgQaPtRta89Wnq2C10xTpPfcbDVN5M4PUz
 TdqociX+/XbvH6MEjdENP6D63QJzGLpz0k7f4WvF0PAZK4tx2o2j2eYHv1lvGZbH6SoY
 WK6ayxGh8I54zinDz/zBeb9YRea6NNNgT1aambr10hp6EPQUYwzrBw1nj5+1Yhufzxxx
 Lt9q9hclvgKSWtK1NEfK1VTN7L0SsgNYE4IlJfeLwghBZd4+wzuw7BQ1vmFmHQdCyPbo
 lqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791018359; x=1791623159;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gy6wX58Ujyo4wiJBNpAnNbix+rUV1zW9BySvs008Y5g=;
 b=dpEl9fURThQT1BribBm+HMnvcaN5JgmFJebQlrHgIw3tYtraF8oo1BXMmLmqrsqh2G
 Y7uMnRmV+wJaGWP9+7MFyfn21hECl8bisVs+9nREg2GVWhSXPsZkKMdmAI09+WU0A7DS
 m/hRbxJewgTp5ZLtrvXgGh2JWIXfMIs0XfZgK2IRYTlUkXWKlj+DyoBGiJ3pturFY2iP
 KCYAjdHsHk5oeqiJffrFZ/tUkALax8R22IflManWqXdvRe6FP08XJSMPfPJLOjIyRDgK
 zRh/czA+FxQNKm7V8Cx6dHoZE8h/UAc+WjtG4oK/VyBE7ZkBmN09PelhH3scLmW392w6
 AXmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBze8gUCsgoHZElIK4VRI8zjZOGLHOF4f/zoAq5xH/DKDZMsFuF/3lVTAB5iqA7RBP7/0/TzAJw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIP5fdzrFITJJrxBNWrNkBD8uzZCEKNH8HlSyO1p29LDrhPFPzC
 N7xagcySZxnwiwJF3Q1rqD9w/5g7G7+CmbDYQH5wjTPa/HrMwk91JilOLdBAOOxBCSX3pExgsg8
 V4lqGz5FUrA5Hd3FUeCLjVhDTrxkWBWKJ9Pab
X-Gm-Gg: AYBFou05/8QNheCh2xT8OjdNk6nTqfoRF4hz/dnYdE2R+oQ7iVHUGM3M5jgIzRgtQq5
 prvfzafDbhSnbVk+YfXUShGx8dwUR6zm1jQIVaGxmEKttPnZ41pFirWpDgMS4iAtTSGRD5FANL5
 DOr/9i3hmJ4zKkZLCxJYGCVNBRQ5N4e5pYt9tHaVs/DQdYrRMq5I6+jrievB09Bv5VgZ8mmIZxV
 X4lQ9PcytauVcH7vqrH5g6cqD+14/b6w6NwS4xPmiRUj2fGD9Rg8kSue0HBv5RrfzU1cQIAecUt
 t3L+sorKVyfP2nydyYoaQqVCQPXZTri7lwIP+OZhYZLp/h5xPuLawG0nRAEyp5JAT0DRAV3CGU/
 42vhQ0gudfWiRH5/M3NWU9hBbdYDfgHSG0oC8eyvDiLV8cqjGkaWAoekecUlx85gpUZKnpKXpnm
 2nX0Dsey/zgNNGNZG5k095/cuSASWSLOwro+D2Xm6ZuXwMpk9MBg==
X-Received: by 2002:a05:6214:240c:b0:917:8565:10e4 with SMTP id
 6a1803df08f44-917c00438d8mr107852136d6.9.1791018359189; Sat, 03 Oct 2026
 02:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-6-dennis@ausil.us>
 <a2d13cd0-7704-4152-8b29-73328cdbad01@0leil.net>
In-Reply-To: <a2d13cd0-7704-4152-8b29-73328cdbad01@0leil.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 3 Oct 2026 10:05:47 +0100
X-Gm-Features: AclHuK8fqGnxRjQ6BDWulKO2r5mjs34wSlP1TwgNszYVdElkk85HIRz4WYaiTkE
Message-ID: <CALeDE9OM7+EbN1FCSver2wg8H_JBrcVvJ10L0hGELd1q5d_wKw@mail.gmail.com>
Subject: Re: [PATCH 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
To: Quentin Schulz <u-boot@0leil.net>
Cc: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

> > +CONFIG_USE_PREBOOT=y
> > +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
>
> I know Jonas has been pretty vocal against having PREBOOT set by default
> as it drastically increases the boot time in all scenarios. We don't
> have many Rockchip boards that set this variable, do you really need it?
> Shouldn't bootflow set this up properly when attempting to use
> PCI/USB/NVMe storage to locate files?

I patch all of the Fedora builds to enable preboot so yes, I think we
really do need it and it should be on all boards. Bootflow doesn't set
this up by default, and if it does would it not increase boot time in
similar ways?

Ultimately these sort of things are always a compromise, for the
defaults what would most users prefer, a system that just works with
whatever storage they use, or a boot that saves a few seconds. From a
Fedora, and likely most other distros are similar, I would prefer a
system that works as it means a *LOT* less support tickets/complaints.
Users that care about a few extra seconds of boot likely are doing
other custom things as part of the process and likely are changing
other things in the build config anyway so disabling the storage they
don't want to boot from likely isn't a big step.

Peter
