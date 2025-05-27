Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E68C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 14:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA3B8380E;
	Tue, 27 May 2025 16:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIoJ1KRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D2E83818; Tue, 27 May 2025 16:46:30 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7671830B5
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 16:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6065803ef35so706903eaf.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748357186; x=1748961986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ui7dRqvHH79IXA/wAVQTXcCEmx6uZ3ERNSL6klbRkkI=;
 b=nIoJ1KReLGsJd1uqY9QYHIR+Sa202Bul1E8Zw3FCeeUMSB9K9RX9b1P88mszjiN7kE
 6nnaJoVXD1ZlcrI1YPHEKKIxF6kWQ+h3VRu4RgL74mmOUXvHDWcJGZ19T623PRBfoVux
 CbP9eqlqhUIiX/PFUa2YXxu548jrRuA5pMtNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748357186; x=1748961986;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ui7dRqvHH79IXA/wAVQTXcCEmx6uZ3ERNSL6klbRkkI=;
 b=C+0j61XiKNtTPrHmVBoYqMclunT2l0VdLYKQNJQCI5bA7j+2ZYKDusyHysS+Bg1HLF
 +oNgTnPXqHaD0dKzRA+zotSmoTKRNir9xUZ7vYb2arZGHSHR/7Sao92t6oSlQzymUCMh
 rbXTqBker0Y+ZMH68c5BHHk/6oesrgI/boHDTj0TuETIqwonqVooa05o8kHmdDIVEOnC
 gTZI+2BYQLmNdWvy2oY7NXEM2+eSSc3jiO1CcIq9TYIuOf1u8MM5YIKLfZEaSjzSDMwg
 vxWdHoU5k/gWcn5S+ALiOW/CLrk270j7tsY7KeY9NLCg0eyKmE0zv/Ehd0Ccc8U3gFPR
 zK2A==
X-Gm-Message-State: AOJu0YxBoxdSJP/KuBSimsvUNchQXelrRPni6kNz+T+Pvlsqz0/jLGiP
 JlrDwwaKftpa7KA1dIZ2qDcCbI+qHuIGYNHIyKVTH3gvxZZ63POYZyY8NmYfJCyRNHA=
X-Gm-Gg: ASbGncseV/QIr2IZJUcBO0yKEz/wAOzd0d9yvmLg52FmSJaFjoGFpNkjCG+fclHX5BW
 meUYBJKDfFteZ+fxd2zef+nwI4/5z5blWPbWFQ+9bTavHikk777VmkcKVkA+IWlOBqQABGKh5MJ
 sG/SQMjBpfGOfpHVehUv8W/wRogDChKqsuNGm+ynjUZXDaI2Eo4JUVWCOm+t0wmspD7Ep/KI+30
 vJQjHlev0PSwbbTC8inN5DbdxRW2QP0LhPmdP3Jvp21cTG0pLG+SHCPOD4UQ8BXFGW0Vpyy1QeQ
 e/hXVH4Am65JQ/Jau7eyYP5yBwusvBLJZgc54OMOKgslStv++k/0Ks131N2JGl4CCmr0TN5Ds2M
 MVYUdRpOU4aU=
X-Google-Smtp-Source: AGHT+IFlmFj5o78w4QrktN1iv+tbLRnAQ7rqdJcAJrH7UEJQJElEv/OZ8j1Uu+klmbbwlcpHsQpHPA==
X-Received: by 2002:a05:6820:2610:b0:5fe:9edb:eafe with SMTP id
 006d021491bc7-60b9fba1696mr6644450eaf.5.1748357186681; 
 Tue, 27 May 2025 07:46:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f58b94sm4793261eaf.17.2025.05.27.07.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:46:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTitaKMU84qGpu_RqVi6HJ1C5F92vy4eZg17PDoVAGZGWg@mail.gmail.com>
References: <CAFLszTitaKMU84qGpu_RqVi6HJ1C5F92vy4eZg17PDoVAGZGWg@mail.gmail.com>
Subject: Re: Please pull u-boot-dm into -next
Message-Id: <174835718543.2857927.15275163345249546039.b4-ty@konsulko.com>
Date: Tue, 27 May 2025 08:46:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 27 May 2025 13:15:14 +0100, Simon Glass wrote:

> This is for -next
> 
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26346
> (note that x86 boards and RISC-V board don't work in your tree at present)
> 
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=79&view=results
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


