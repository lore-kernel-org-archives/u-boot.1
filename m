Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C887CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C72F4810F0;
	Mon, 19 Oct 2026 13:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHCKcAc9E2aY; Mon, 19 Oct 2026 13:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 244FF81115
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416480;
	b=aPoG3ijfhEFHOxJesWKCQf7LDULMGAAPZNe95YcRdbOj2nAK/3NFXt+DhCUhiqYsZCb2
	 1hwEPw2KwoX/c4+Gyoi4arBwttRKIwbLZIzWcMY66heqjdY4AImJvcadLIh5AiFHFiwtu
	 YwB8e3Jbva+j5ffNUttCu7VLCzmMKZxxwovsqZi16x/YILB2vgY8o/+FtdaehOSm5zEt5
	 LZj3Z7k9fB0qeYfSIPeSVKh/T1MSTt/opi5pyT5Dy+WebDmINTxlBwgDIMXheY3fde5br
	 7vX7PctBVQGQRacwoVll5xdELd1v4n/e+cJFfXtzJZTYNyBT6M3l2bSvz1x/L/z1N3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
	b=YWUrOdly2yewaP9acn1RlWRGTFd9OSKWa85t7X6FlqcPCBHFVa0/vWgHA7V7Qlus81P4
	 q7FOArCH9L916h9qFPSMxtlEII58uHRu1T2ft0CYtu8SzbRUJkuZ5sIVj1UBvwBy7ybBC
	 DzOX5idCdbdDXJPN51Spqi8i4NSFLkhez2XIEsP+NNqfx8YXX0gBFW/4VYrRkc5qUrtNl
	 1K9920bldSDAq3lvWifTvKS8vSmhAMB0Sb/GknYobVAeBE2lrwdDy8q80ZWQdMXRyjSPC
	 zoQWe2oNPR1S2oc1iTMxo/AKmPVf3Is9okoR4aqySFRu7ww860KtX9BWUvzz8BCpQrg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416480;
	bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1NkzZhqw5J+4w3PHdRLg8wXCvzK+g8YuGpRF/zZ7WoE2jOMHJPxB4j68O8JG4zLh
	 p35yigGWCWVt17KM+D9UMmDvOI6T8eIwy/w91MsV6AmxIf6QP3rO0b/1hLvZMCvAll
	 rcfGLBMSbopvM/35RdTJUH9KEZMn4G2sDCo5DcVzEG/3fXzjIwAV22xefQnxIY4KAL
	 0NorfANf8BQpLv1YwricYdvWnUbIpOUZNILjaPHwva8jmoyCJ3bdS+YF0o1YRNi2Kn
	 B5Qsu9Z7alSfPJNy397wBRkt4Ayo9YKC8aQWKGGjdfMg0Od9890kuQiwJEqy69yoVD
	 RDgsLOFAYT8xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 244FF81115;
	Mon, 19 Oct 2026 13:28:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCCB323A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF1D560644
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SAjMe4jsdgC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04B6A6063F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416478;
 b=mBxlULSxX3vk1Ot76kIB8qTJu/luk85oJ3zu1Gt6b1Bg7V4ogbDp2Yx7hqCN1kFg+qDA
 6BtDgQdqQKX/Aqpl9YuyMvVOflhhcTesq25p2YVHpE2fGW3aOdBM8VvTkWqbzuvG5Qns2
 hzj03iWRX8+mqNkCT+6Efb+cGzYAAgUqcMO/VQ3MPqMEXnsmfrs/BbW8Mhg6KUURQJWwl
 CjQAjqvpO70QxBTqJokGNYAplxRDagdFqmU5JBduXBBEAfDybYt0jWKbLS728a6al+c0b
 sR2a7P7D3dgTM4zL6t3iskyBRrJcfkKzLQcVcYuI9SEWehh3yFPlBZurLFrXIiqxYcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416478;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
 b=Pl0jCbwAXahfp9uNVwhWH9I+TJuamdbuLYnOOj3giLb40vEWBUpLsztYQ6EVtxl3MjzH
 o2QtUK/eBGZ9Ns1EaT2Cggt8mrkfh/Bv4OiT5eSFIWr+2uw/ZH8fiNC3sHgBZBk5n2UTD
 kw80anxP+OriG6pluhrllBLzIKPQxwcPevXwJwYRwa76xKhOnN1eR2uWhzHhQl6x5lvvb
 ud24dAmu6+6+WpZ77ZmkUuaM9ozzKWYmakJliMB+TXc/KuSXmmm9g4/UhTLupyKl128IA
 2mYsjEORx8Nr3KHorIVExU1/b3njj/EvvqgTumNKQaGuVwyHj8Gh9v7UOMp0M0FFHHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EBsBHXfD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EBsBHXfD
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04B6A6063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:57 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1417611a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416477; cv=none;
 d=google.com; s=arc-20260327;
 b=XVi+na6fJk/D7pGcEpb/rV/Q23Q6zL31EoInaxvkvkLMQAh9lgXwb2SNlgQDRy7lcZ
 fl+4B/943G54Nrumm32+go0t5LHAEa2iYX5xrO5+wL0IEqKimG9xiqRxvEPCZaMx+DBW
 Eg8EO0MVjasdebDyCasoeGHHAz9MtxpZQ1P2q+q3oZipxq6a0vi/0eY5lwaFb3lPUIGv
 auL6hFoppkGopEIUyiayZbTMBWs5TUfmB6poS5teeZwxovffUo2iAIoMNIbd1+LT1hqU
 TRP7XF5kZBg/reuGqgElBvcRnDpG0XyvYYzDLXS/ndzbXnj+M284Q994WaWiPi/BR/aR
 gs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
 fh=b1NmG5n+zk/hZwVAlG6mr0XN9k8lxKDS4+LUscUCFwE=;
 b=H/YuQLzhIT7okO63Psz5JJWheKrDDL7ONcpiQqcPHkizN9dXJujW4kmVZbP5X1Cyoh
 XG+IDJ+PgjO6ms1Sey9p4S2pRTYJssG4Ly8KgMUAMZre5jmtQPHJ4MmDK/WldXsRO8GH
 aWrNBAKQq7U3bRqiGazRJxtBPAhXqj/Y+lAz6YoamCWT8F0kIAJqsBaGqK3iQxsINEQp
 ZM4Id+DxQD+TiQjufc5+oZMis4/E0DdFevxh57YSGU1XnbOt6SDbfockZQwB4kOOfhof
 u99DtPWZZAjUOuofZ8XNUp+CuAehtAU0INpo6/9k3CoqUl1tVY+H4tBX6Wx/mP8G/y+H
 8lbQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416477; x=1793021277;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
 b=EBsBHXfDkfgqhoGi/l+eQMAsbERTyMYJU/N/VQmIg77b/gu5SJZIqi8M4ht8jP8goT
 /tqgpkvUx3VGZROdWlGYmZ3WaGmJ0qn27mq+e9IzelYo2OEBWroz5s4rXFjdHnCoh5Hx
 oF4wB9EXxjlNAXC63TXJ6DxuYFjizExUO65FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416477; x=1793021277;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0IlRUCUH6O3EdKNTV3UmG8A7oblD4XK44zT+3Bi96Ac=;
 b=juyPYSH6Z0vkvLVpqskHAu9DF5pTucqAbUNHJXTlnnZyxKhATpscIfF/7H8MC3FfGr
 tijnQfHjccKB9foa9UtiKhEQw5xe5WMU07ioTioF7C+CsQnEDazlCZCqlsaikZ+Oy5Oy
 /ftz8Yx5iIQfk4jJjlPEEVV9jJNGj9H1VmLWBpbIlmCDIelfieT/oTZtTbDt63w4D6lt
 XQmHGEUGfZAuzkCXWdzxqC0VozC1f67f+fOnllmcQb7HyW4prrtC2wRFFpk4YgFa4QYM
 kAkoibwynBlV6RZf3VEQbmayB3fGpGGAgGgZ03HHaUeZyASRp3gjL0IXYT2zwtUqBTJz
 ArXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9PfkWhLQIlU5Lz7pjewoCent0aEOMqVwVtBjCZSdBtCiM8oFicFj4I4EKi8xZVywFTFHU3WY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKPXXXv8s3ilnly87Kl6MtTDDsvLHdfVtnSH1Na3bX6W+YQxYI8
 D7cg57S3cD0lCp/v/7S8jGQOuQ2FiLjLU6YMcqg6/dvQ04Vct/+8cYPGUJaAWJfvH1kOB3jyUXC
 SzeHsZp8dR4jZWN61pmXoGKJBcqb0tZiUwJvP/T4L
X-Gm-Gg: AYBFou1bkuKueshO96XMLjaduOXr1v78EIZgAxLC5QCtfc4Cylb9P1nmO8iwrQzXSKV
 ypFCbThiJa3MLvv4XZ6Y5THlEv1cbwHqsSuzqFPbj3kjCb2ZT6RPSiPdDEyg4gJec7pwEkGa/mq
 mtLtXn09HJQEvzHhUWDNqnb+YsDQ4tF578PxiYoxiWXwOl/MRaU2vIvauIVC9pPcig/Alyu/7GV
 7Kji+jQVshRN5wdiQpa9QNb+qLBhqmt61xTci/IZ2mUfi/XoEEXdM8NH53RpEoAt9fmkKb/+81M
 BIhDq88gy6F02LDkuksNaX6ugGltPn0gInnULo6682jVrA2pseGRT28=
X-Received: by 2002:a17:90b:5112:b0:3ac:9e5e:d19c with SMTP id
 98e67ed59e1d1-3acef134c23mr7235116a91.17.1792416477156; Mon, 19 Oct 2026
 06:27:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:27:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:01:16 -0700
MIME-Version: 1.0
In-Reply-To: <20261016040216.3636305-5-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:27:50 -0700
X-Gm-Features: AclHuK_fV9s0YD1v5HPe8uMhPlQ_jNQFsQwhOMSAxaTQ-NqUYhYYov3-DWzgDu0
Message-ID: <CAFLszThWTHySt4BdKpUthrk3BdUzgRVvAuoRCE3CiouJKUnFPg@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs: google: Add lga default configuration
To: visitorckw@gmail.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com, 
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
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

On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> configs: google: Add lga default configuration
>
> Add google_lga_defconfig for Google Tensor G5 boards, using
> google/lga-frankel as the default device tree.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
>  MAINTAINERS                  |  1 +
>  board/google/lga/MAINTAINERS |  1 +
>  configs/google_lga_defconfig | 10 ++++++++++
>  3 files changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
