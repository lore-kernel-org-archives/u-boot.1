Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78ABFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0782A8460D;
	Mon,  4 May 2026 14:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GjXs6aoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7C880F0E; Mon,  4 May 2026 14:08:13 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70548460E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso831240a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896491; cv=none;
 d=google.com; s=arc-20240605;
 b=a/Z9TrZJOSMIpvkP1rg32atvScruiTAJcWPFuW3DJIlU71gB2tJVN2r0571qnzv5HY
 FKFHekCVtm/RIE6vCgVf9HQ12V0RExOTH4m7ZrFJj4xGPFq2TybRRXoRshuG/C+lki8n
 P3TnYOSxDBxO/7WuSfnHbMhZpn04Zjn9Hd8pN0Tdm57mXVaJZVDuF3ZOjxRKuuoIXXq5
 j10iOtMgJdTEKWbbA9WVOPFWUu0Mh2vtumJsBBJVLRfXJI66NqtsxveYBTYwVX2cLg0l
 GUAKEq23UekNnOsL2+3Iph4BdyrVl5+nsSFY6nSkOJp45xwXtGbkig4TDkocZ7bOFJ3K
 QiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eEXeZ51QDLLWkAOJhlbJxRdst+KTy+5CASPp1g0DKzQ=;
 fh=riS258wPZhKPiPIwb7TeuHwFio61U2578GVrX1RJA/0=;
 b=U6GAJcUudEQwxxpgLR6tjkgnmJKVyLoacJPBtDUZ4Q6gkdK6II08N1scC/MhuePQqf
 chmRZrH2jVxFFWo5yQim2GvhBydZq6JdUQ+SCJyhwcrAsObZ2odUOUrA/cMEN0SEiz62
 MYjwsw4tStWsVtfeHwhU8NFTGkaS6zlIAeGXlFYVewSgzPOPDW16o4FN45e3vWLXkx0h
 RSaW30JHmtLOTNpJpk4C34PpqwDutXDmQfdNUyolbHZv6Kdu4I/qJVcm5eIgsdX4GABd
 U7g+qpEdGi5d66n4buO4AJhmuPwpLla1GAlB5w/Xsm2O18BDYJd9JdpoH8rTOWmzKzNr
 H3rQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896491; x=1778501291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eEXeZ51QDLLWkAOJhlbJxRdst+KTy+5CASPp1g0DKzQ=;
 b=GjXs6aoqlC5bh/cuGRwXwE+yIn1OQe3tnGSToO6FdEt4cbStMTXvfLLZcNFIZ0gBsj
 ixefhxPbn3FrYGf1Z1R0otLZFFIHfdkHGimv5biWeahLhrmLL26gLvD5ux8SA6+38bic
 80b4FtSHAiuf11dH4UUJtYweFhy1iwJFkgWKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896491; x=1778501291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEXeZ51QDLLWkAOJhlbJxRdst+KTy+5CASPp1g0DKzQ=;
 b=Aa/wtVOlfSpNruPejmBgHi87E/Ff6sF3yvj0VVCLcMTh+hKTSdEun/zK8G8tlCIzvk
 4Vc9lPLCXXNH8YErfICeD4eBFC/0XxDDW6WqsNJkPs03Jh8Yq8AneZh4d/v+K3B+1GhW
 EUIhMK7G/M6EGSVqTmVVl2RCDQQWuqLOLeeRgtbORpuMUNw536YDG7oDxkCVRe7EnVDU
 eW/EYth9YgrFe1uergHhMi223gj5BHrYYfmFEJkfqF7lv1LPCeuR239x2sHrUThek5/R
 zq/z/q0kztALi7yU/5qDy8cuLkaJByFYnp+vBK2kE8MSu0tQShVAGT5+mnk5SQT2/zvu
 9VJg==
X-Gm-Message-State: AOJu0YyKKdw2862OWcQFqMx3tGY2+q7RUNjHBkciu5brm1L/ulQNDpen
 KAOQTmdvThb1HnNsBs1GVHjQhIpj8JfNhyp8aH3ATu3ERdccBNLvNdalygqtXxAFtmE230MSC+0
 Rf7b6Q2bfSLGV0Pn4S1wTyBONE1hnJayhNzHQnArz
X-Gm-Gg: AeBDieu5tvMhL9qsotWqPJZqbg2UUpUGdfhWBhyYIri2xI2imgKgQUkZBrpp9mP7ho7
 9bfyQNK24QayOmAsr41zQJLT7xyQ/ovGOMSX8bS+wGymwXGrZWPCB1Ohijtz9KADWKRbxGpXoxp
 1A+0dULxyMef+g9/5PoOXZzqi0ZOO4UlSnPa0knXJDOlxaSke+kCQmH3UoDh4PGd4EhtCj+Ma4y
 h2cnTatiu01fZ5BA/VxBsazW9xG/dkE4z0dpYKBh663DWRo4h1TxsICW/75hxesHlNPdun1tSAl
 ytfT/K0Y4g5S9daY
X-Received: by 2002:a17:907:6c0e:b0:ba2:3f1b:1314 with SMTP id
 a640c23a62f3a-bbffb961df1mr498774866b.33.1777896490720; Mon, 04 May 2026
 05:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:07:59 -0600
X-Gm-Features: AVHnY4JD5-yypRTuojCaCiTieoMU-PQ9PH4_fWLYt3nbcwHWzaiE9pgNfIZX-R0
Message-ID: <CAFLszTjGTXHbOej36kJdC28Ri0EgPv_0URi5vCm_y4yUYyznzw@mail.gmail.com>
Subject: Re: [0/5] Enhance the SPL FIT "full" loading logic
To: francesco@valla.it
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

Hi Francesco,

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:

> this patch set tries to align the behavior of the SPL FIT 'full' boot
> flow (i.e., the one obtained enabling SPL_LOAD_FIT_FULL) to the one
> happening in U-Boot proper through the bootm command.

Please update doc/usage/spl.rst (and the falcon-boot section) to
mention the newly-supported pieces, i.e. kernel decompression,
post-processing, ft_board_setup()/ft_system_setup() and the ramdisk.

Please also extend the existing FIT/SPL tests (test/image, or the
pytests under test/py) to cover the new code paths. At minimum a
sandbox_spl test for the ramdisk fixup and ft_*_setup() invocation
would give us some coverage. Let me know if I can help with that.

Regards,
Simon
