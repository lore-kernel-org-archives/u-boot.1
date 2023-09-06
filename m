Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63006EE14BC
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC71869A3;
	Wed,  6 Sep 2023 19:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sEbMomtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D755A869AC; Wed,  6 Sep 2023 19:50:44 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2582986989
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59205f26e47so813497b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694022640; x=1694627440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=furbGd47u+uwcRUEHADdr6wBu1nS4p5VZeaKNMz2rzA=;
 b=sEbMomtRMYyicR/88yn7ZIytAlszyHYS8oLDKgTz7/fN7Rc+/iNC2m5gZ1ZjkRB92H
 OCWoZ2tJsiMQEeBw6qSSY9r+5Sajcb1FutsYhQgp0W2FZTPErk/9hRqeTkJYDzeZRXsO
 ejHOHK+o/BG4Pk3/eqy0/bo9H3foSixnOYIFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694022640; x=1694627440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=furbGd47u+uwcRUEHADdr6wBu1nS4p5VZeaKNMz2rzA=;
 b=TdftNYPPcDa8+qYqH+ALPqRdovKBe5DpHvqBzCnZ17tsjix/tQgEM/xqGoUY1Vd0YN
 fhwnIM2Dmu1pqN0hteOXyrRdwDKYxajBQltRhcyyf3/qiWsjEyRR8sxU65uYEe6w6mUn
 +SvF6/VlGG5c6hpryLjEkfjm+OyPFD3Bfx3c6OkP4FjWzHDWEnOMsdRKSNd+o42yDdxz
 3Py+7v40EG5ZFZFGdI3Uym/hdUqUCwn1c2cu/obh7VLguBOxGHpnmpaaTpXEBtmJJzS8
 JD1WYz4fUqC11Hj3Ra2UDSEHh+dL/mBbgqI8sVh7ZdQ0HhS+gT8YnfkDvbswZU7obgml
 Z+mg==
X-Gm-Message-State: AOJu0YyL1EOQiagWL57MZHecvZARsWBBcUzRyhbmTedjS0HN/l8tf7kt
 hYwylFx9gKtsKlQW63sNU/7lilptBag+Ouwcmp70wA==
X-Google-Smtp-Source: AGHT+IH7gmEFJ8xpxcnC/PUd3uprNoVhtIxeLHyVxh701UHwqssLufWPjmqUhCYb0uVqHz1EICiD1g==
X-Received: by 2002:a05:690c:f03:b0:599:da80:e1e6 with SMTP id
 dc3-20020a05690c0f0300b00599da80e1e6mr17998067ywb.34.1694022640770; 
 Wed, 06 Sep 2023 10:50:40 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 m125-20020a0de383000000b00583d44b4b30sm3883314ywe.99.2023.09.06.10.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 10:50:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] riscv: Rework riscv_cpu_probe for current event macros
Date: Wed,  6 Sep 2023 13:50:39 -0400
Message-Id: <169402263440.935221.409149664957886372.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904190635.3896494-1-trini@konsulko.com>
References: <20230904190635.3896494-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 04 Sep 2023 15:06:34 -0400, Tom Rini wrote:

> This function should now be a EVENT_SPY_SIMPLE call, update it.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom

