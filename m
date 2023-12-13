Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C5C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD05487852;
	Wed, 13 Dec 2023 21:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XfoYR0or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B05A8781A; Wed, 13 Dec 2023 21:39:06 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B62987828
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db5e5647c24so7094902276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499941; x=1703104741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUx0PrdPXY2pFpiQz+3scC14fITcKaBaE5pwdTLhcv0=;
 b=XfoYR0orTABgZ2Xu75emDnPlKGY0P8QJfzA2yQ4bSoQSy+feQu72g9l0a9FBK92eq+
 QKJLs3cmfxITVitcHFx7QmVyQ7lAJjyl8+DXDpy4wwf84N7bXv7k5US6e+gb9/UVhBFN
 KPq0Cvnz6ygtmRS/7B+8xnzH1wbLrdY5ytTjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499941; x=1703104741;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUx0PrdPXY2pFpiQz+3scC14fITcKaBaE5pwdTLhcv0=;
 b=MAQbrI+uQh2Fb1NiiO14GhiwWjebldvF8RHZqGYqoeriXbKvLr+z96Ddq0ZgIQH0Gf
 Rh02+0pg+E9JAQVNWIja/P5cvkAY9ajOKWI9vRev7wYmLpr59E/ulmt/3uSOT0eWIeRV
 6RvZmMLmadDoYEQhpYsK/O3cIu6w7iaEHtVpXaw8aNJ73jXSYN8Ahi971jGGe726JyRu
 V27a2U5pI+Ou+crRGrVXB1aua0qMZEotQ7W2Crf41u49QL9zsB26IWGzTMYo19AW5kCX
 H3tusleHvuTVz7RJ/QzV2M2Z+BfMBzbH5gWFjkjTyCQ8adN0trqXig1Jq1TIW7VMi2t+
 GxEA==
X-Gm-Message-State: AOJu0YwBNhWjEbuolJiAts5amBHNFihPEjj39tPo2ZMlVPznmejKIA47
 8EX0kVyjRXfQLcej/5eMw9u9n0MPwSHu62LPUC64kw==
X-Google-Smtp-Source: AGHT+IEkzRz5wRQkIsEqb0OnYg6PXrsTAP8DvqDhTAKqHGHuAFkzhsD9j2zWOXhKCYeDF3d9JH4wDqYoXXQCAHGRUmg=
X-Received: by 2002:a25:9391:0:b0:dbc:b93c:71d0 with SMTP id
 a17-20020a259391000000b00dbcb93c71d0mr2786594ybm.19.1702499941458; Wed, 13
 Dec 2023 12:39:01 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:56 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231205102056.dmkh4fntzs4thpdv@uda0497581>
References: <20231205102056.dmkh4fntzs4thpdv@uda0497581>
 <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-4-n-francis@ti.com>
Date: Wed, 13 Dec 2023 14:38:56 -0600
X-Google-Sender-Auth: T7ACzJg4IZDNj4LlMMWtRzloWow
Message-ID: <CAPnjgZ1sR9f-eG3RLj+OVmk8301wswxqSDc+QWbQzgByKKw4qQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: board: ti: k3: Mention TI_DM argument
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: marcel.ziswiler@toradex.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, hs@denx.de, christophe.leroy@csgroup.eu, 
 mr.bossman075@gmail.com, afd@ti.com, kamlesh@ti.com, nm@ti.com, 
 c-shilwant@ti.com, u-kumar1@ti.com, Neha Malcom Francis <n-francis@ti.com>
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

Hi Neha,

On 15:12-20231205, Neha Malcom Francis wrote:
> Mention TI_DM argument can be used to fetch a custom DM binary in the
> A72 build instructions for K3 devices.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  doc/board/ti/k3.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
Applied to u-boot-dm/next, thanks!
