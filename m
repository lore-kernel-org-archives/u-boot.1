Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBA1CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78ADE86F61;
	Wed, 18 Oct 2023 13:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djNmo25x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FDF86F18; Wed, 18 Oct 2023 04:21:00 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3203286EE0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 04:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cppcoffee@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso4017617b3a.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697595656; x=1698200456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t5gFVf9f5UP8NOCHIa6OjNNo1NQFw4EtDdrs1mwc554=;
 b=djNmo25xwYPGFQYuc3YUdaZ2kgRynTd6i0MY22A9u9WVmUf92TYKNtundhlayKGX7X
 HEJfkX6cB5gK9YzXbBTdX/Fkvx2cdVDMvWklepQFP8eg9C1kYDC2fj4Ys9ut0aV403IT
 xjIGTE1XmWFZDw8r1lSEtSGl+tC1uzDW21evTlGYxDkxWmI8HU0PNAwEK5LczOEKjviW
 PoXRHRxA4oPpLcxsrcdE4zj4HZS901qcep9KCOMGKrq47O92xOhxDxpsUgl5gmdSDgjI
 NXqAIb/SvyHo7mMYuCB0ZmN9/RLzRTJlptkODYqnFZ3vB4vqCwk6RiTA2ClHCSC5ms99
 iP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697595656; x=1698200456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t5gFVf9f5UP8NOCHIa6OjNNo1NQFw4EtDdrs1mwc554=;
 b=Kk68bQHg66jMe2EKl4ZRdOVsVFcZ4hlcF2imVcMknmdfi6aHH5nJQwTKw8+g95zI+i
 ex7oYHVUOWZGtDn6Rbj4OlMFx2xCnYwxPkixLTCrlxxDysM1duh+yD6BGz5mU+LQHUPX
 n37/XKUm4UrtXgyrzqaGPvnnFcU3atCZBEE9nx8r/ru49jXRp+IcuxzddLxQ/b0HLP90
 zTSH8aNB3NJXD7eJpwhYEeXvEeTUSsvt/ZU3hQBB2Pdx8UU5t/PvL7Q370cAWX53wM/3
 +AuriRnggQmkN9B86F1k/SZDSJwrL2s9aChfSRAIO+8DbBa+G4lXNqFyy3nRjolsmtZ6
 SQmw==
X-Gm-Message-State: AOJu0YzHo98EGLnN+W2pj1oAdRqdbS0pwO8wnl2mFg4uqQPUrK/g04dx
 V4m9ckw9SZWBtDvitmmnaxb6JTHc85EemnNkG+2wLvdTVzdOew4R
X-Google-Smtp-Source: AGHT+IH4HVX2AWL6DBRRw469R791xuSRw+ViSsw0y32uOHQRPMat5WelySf9P+ou8rhmX1yR5v+Qxi3vhbzRC8X4MHg=
X-Received: by 2002:a05:6a21:4984:b0:16b:e89b:fb11 with SMTP id
 ax4-20020a056a21498400b0016be89bfb11mr3450422pzc.56.1697595656426; Tue, 17
 Oct 2023 19:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJeqHvL8xNKOZ=WD3PVjQVGz_S-EU3qDRCV1LwY4auOWxTq1dQ@mail.gmail.com>
 <CAOMZO5BmGMUJq1m=eq_7ckDDx2FSg7LtU8bC6BE_fFc88MJZSA@mail.gmail.com>
 <CAJeqHv+V6KoddTR7XA6Z=Z7tzmGx=ZH1jZN2v=pAuURcR70FnA@mail.gmail.com>
 <CAOMZO5C=2AAKC25ip1r5qKFdTyOmFphsXAzjCR0hpt3ar06aYQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C=2AAKC25ip1r5qKFdTyOmFphsXAzjCR0hpt3ar06aYQ@mail.gmail.com>
From: Xiaobo Liu <cppcoffee@gmail.com>
Date: Wed, 18 Oct 2023 10:20:45 +0800
Message-ID: <CAJeqHvJbPFg_hjzGCMPrPJ7tKnEFFSyJ9m=R0qTyTu+2O6zeeA@mail.gmail.com>
Subject: Re: failed to build u-boot mt7621_rfb_defconfig
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, ryder.lee@mediatek.com, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>
X-Mailman-Approved-At: Wed, 18 Oct 2023 13:30:29 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you
