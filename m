Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1B8CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BCD82E34;
	Mon, 20 Oct 2025 15:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NSREA6On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE53B831D5; Mon, 20 Oct 2025 15:13:58 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3334807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7a9a2b27c44so3226699a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760966035; x=1761570835; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaCkaAYF/k2/JfZtvqBisw6GEc39MOACs2ImwWFPm5Q=;
 b=NSREA6OnR3xdEWbq770l4ZOkmbMDRfyq+GWzbxwkHVNm6jTW4pOcDTLub97qAVmzJm
 SMaHiidcFakdbDf9HZK8qCvv62zZKByxz4UDYFECtqtDnU5BmV3bQEuoxox0F5Xv2MVK
 BhswUqZ91/uQRSsjvt7ISN0qOYzKUg9vO84DDFHPBtaVrF6AHsNXcKfB0OnbGUSztZyP
 p2YMRkBkipckJADjiEBc9zTQw5dksLIWfwgbojzhDmPvm1zaqqw3xLT9Nh6s268hE2+j
 20/WO2aunHFYRoDU8Ib/D0OA418llFEmdGd8jcWWZu+stLIC/Uh2JS8pj0w1EJcBComq
 oO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760966035; x=1761570835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oaCkaAYF/k2/JfZtvqBisw6GEc39MOACs2ImwWFPm5Q=;
 b=uAOTqse/6UiX1oC0/Kn+8iWE7UgU6b8o3qZnADBbhNDv/rb7bYZe9ZiNSTNEm/kfuU
 6nO3aP+RtM+JEs3TuR0YhnwhPn9G3FjnfewEd+6urkheBrpldiLx8s/JhtmGNYBiSIW1
 6s/gixONfBlV0Z7cogLrhejRWRoIjH+dZCcMjXxY7SfDATmb32p3/7GcB23OBMHUe9Oq
 UiyrihFgJ5KUskcM67mTbZN124NfE2ddURgkz9SgUZ9V2GLSbY4tjWbYZaFqLj6un37y
 9TkIpCXHfh4ncq0H6n5MuwcRiHicNqvycl7+CtOyzrYu/tFXwLfyBDPZ7pC/+jISRuvP
 vjaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuHI1Gtxy07dyq1rZcdwgTKnevTvptYSEa3ki4CwroDhVAGBuQXCRCAb0yrw+D6fnyKQX+pcg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywon8d7AJz2o03a9LDHc58cceQL/OxHZkHPe7s61xryN29f7Omh
 mgn4aJVb1X3HniUMFdhTW8ih8QR3guQsY+cRsCqKvm92qsZ/mVWRnEj/aUQFMGO7OEs8RyGlMNd
 izbYmG5NsleWVmaS6/IlrpIDZCzuwd/I=
X-Gm-Gg: ASbGnctBCRVUKu2HPLq9HxnVwhykuM1YMZy6dRoC4AcXGWz280KLurRr1jrFa9gwV0/
 9+MvVJFyfxfmI8mpht39sj8Vn78sep5JMnhodtrE7M4nc2ybzfhcLFfqLwt232Ur/Rc17RdmnKE
 QH7/APEa6XYn41pRe9NEWvu1SCwSyeMcGXe9vSuHyGR4n7pHS0//e9aKQDPUKIedj2pN5W1ylKN
 41eZXK8bO4PtMgYvs11wvNaMPpcajCB/ffh1XzPmyFHGPViGvZmsxFjw7UcJQG/pgGaW0E=
X-Google-Smtp-Source: AGHT+IFe0WCY/eYUWVUf78erz887AP8CwGDDLMi1Lz3yIXeqpjrrPgA8OEsGGkSwKGkV/9dp+FIVYOLZ8+cvZRiY1Ug=
X-Received: by 2002:a05:6830:60d0:20b0:7c2:82cb:dbe2 with SMTP id
 46e09a7af769-7c282cbdf28mr3924425a34.7.1760966035317; Mon, 20 Oct 2025
 06:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251020082304.1778-1-briansune@gmail.com>
 <CAOMZO5D8vtV2oBmrNirqQsYTBbxU3x8TLsmibri2ZTngJM_6UA@mail.gmail.com>
In-Reply-To: <CAOMZO5D8vtV2oBmrNirqQsYTBbxU3x8TLsmibri2ZTngJM_6UA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 20 Oct 2025 21:13:44 +0800
X-Gm-Features: AS18NWCvvHsigk4uzxstHJkmOBrIQuwZKHMOnvQYmN1PK8eyjC_nhJEPVtH4A0Q
Message-ID: <CAN7C2SBEowgfJJKBTAG-QUPWuKCipFTA=DYTqyLoq0zqn=osNw@mail.gmail.com>
Subject: Re: [PATCH] FPGA2SDRAM setup fix
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> > Signed-off-by: intel <intel@intel.com>
>
> You should use a real name in the From and Signed-off-by lines.

Indeed, I forgot to amend the signed-off.
There are too many virtual machine on my side to work on these.
Close this and reopen a new one.
Sorry about the signed-off issue, not pay enough attention.
