Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6462C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D579587C79;
	Sat, 16 Dec 2023 19:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RtSLxmLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7126287C8E; Sat, 16 Dec 2023 19:48:38 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BEB87C6B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbcd0928530so1180934276.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HS2b2uJyUj1823H9WTxxiQt26h64zEHE0mE0OAVNB7s=;
 b=RtSLxmLIkk3t0JZKTIB2YB6N0sXW8HPAnQlwsIMFHDtS/AzO2lBPFuyzjuG0kc8ha0
 L1i4KWoiBXiHuNyRHWJDKY8exKzv1gsaRmMptr31nGF4TZIOgjLWz+7DMY8Z3doKlenX
 mDSoNlJA/1ta7shMNfnoCYuIoF1pCerydMb/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HS2b2uJyUj1823H9WTxxiQt26h64zEHE0mE0OAVNB7s=;
 b=QkmPEqJipuLPNRqKeAbDGP3K2AqqyZhdgH97E27xXzMaYZs2SbpoID95D/zihD0L0G
 XJjmqPIvJgncKaR8gqrlCZ+LzGWIdsmf+h/HhkumfSTThT3r8zvFfcy5chjKjAxBdfON
 qqhjhQ/3rbDqNDWTRAGe4DdS0OCvmRMTIKn48dhsLhDTyXA59THIVQepxq7H6x5B4KFu
 +wC6qI9sn93BzfDJLEnvM+kOY66BzQUSgaW2v9RsRRJ7InJO4onYQroFpo7xjc8iiTtW
 7UZNRLnAkP9L4Jl2VPpD7yMRB9tmaDbO5YF2SU5ZOEl+doI/mY90+MzEaxwvURjh5ZsT
 f1SA==
X-Gm-Message-State: AOJu0YwAHMKN82zwzLoPAKD3vh74p3M4f99sUz1juR9g1+nInvCAyrEX
 JrB6S+lubWiitbIM01vTTIwqBBcu/ldkS4QHB9GwKR5G+sxjkunYeDk=
X-Google-Smtp-Source: AGHT+IFYguoInqnqYgRN9Oho1yTjyA8Pd3NUOGGcmfMJPsZN9A6QgPXm3bUvnt/Ox3cg4dSqvnT/M8uadUGfbt5o9l4=
X-Received: by 2002:a0d:dbd6:0:b0:5e5:eba:9d5 with SMTP id
 d205-20020a0ddbd6000000b005e50eba09d5mr889766ywe.94.1702752514147; 
 Sat, 16 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <5d800e23-e427-4198-ab24-f2e1fe595c4f@longervision.com>
In-Reply-To: <5d800e23-e427-4198-ab24-f2e1fe595c4f@longervision.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:20 -0700
Message-ID: <CAPnjgZ3U+6E42HgO0gXirp6n6NKXt1tH2kRwK6T-EpSkaYXAzA@mail.gmail.com>
Subject: Re: Where is the u-boot for BeagleV-Fire?
To: jiapei@longervision.com
Cc: u-boot@lists.denx.de
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

Hi,

On Fri, 15 Dec 2023 at 06:15, Pei Jia <jiapei@longervision.com> wrote:
>
>
> Where can I find the u-boot defconfig file for BeagleV-Fire?
>
> I've got an issue posted at
> https://forum.beagleboard.org/t/error-illegal-operands-li-t1/36823 .

You could check here, or ask the vendor?

https://github.com/orgs/beagleboard/repositories

Regards,
Simon
