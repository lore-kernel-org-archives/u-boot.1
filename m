Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB6CCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 12:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D841583804;
	Sun, 19 Oct 2025 14:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lJa2apDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0ACF8382E; Sun, 19 Oct 2025 14:33:46 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54C083631
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-64e84414cfbso1623958eaf.1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760877223; x=1761482023; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b85YFLZbaUUnnrnVkBDdC41wVo3rCH2/WzvRPTfrbvM=;
 b=lJa2apDay2KhRFRVtTYIn2T9jBRtKsMwgyDpQjXplih4kgxbMoDzc26Mt6r/eO/R1F
 bB80eDKCDPpb3deUJKJxyd13rKpAPgtXyvG+Ld6Kz0T33Yh+7dXfFLBvK2HJ4hAqpAP+
 hMu39Qu8qaooeSx8ET4h5RwePTUc7MMZXD1Y96NKkgZGXmJhgJyDkxD19IGSk5ZUz8V6
 PNgpJMbxrqsaO38+73ehl9sVN0ZcaLEafbXXSYGR9t2E0IylJeJfzrzXFBVZkNBHnGdd
 TYr9aWLNa5I0iQJbjtyqLjAgONQygKrlNNq148p+Oj3QiITP8plG3trity8c31w/9t5J
 Ul8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760877223; x=1761482023;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b85YFLZbaUUnnrnVkBDdC41wVo3rCH2/WzvRPTfrbvM=;
 b=Er5Ca0djZU3b/Z2/cgrzm9FJJxQnPSRrV3IkRssF+Rbk6DRXDmzZUT5Bd4Tozt+X/1
 tb5YauUVcMPU9iE8inxGW/IhZuYtKVwsfATyR/TuWt6xN/42WNG7aGo7yXTmwHOxViJo
 NysNl1DuND+9JrU2COrekmxcDJ8W2k468JPH5FULMK4V+6NAmqH2SmcNO92fLKU4SRAQ
 rQaR1H3LcdM0ppl2rj+SPAzYKEQiKW8MIMufbn5peZDpjFkGDHUpXXazD+wt7724hWkc
 pFirRaXpHB5efLuJora6zu4nOfpQC1DVJvrjcu/bJm450MguGvCAkifAa7AZxdyhVG8W
 EtIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgnt39urUPjhQo9hqpXM/Ks/560qDApNcugtm0v8QVvb7sBKfkVGpf8AqNOF57t7TXiJMM59M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyu5aBEy5vmGozTPkAy7+e82kLgVEwjS1aZ7DaQud9rYSkrcVC
 2oPJ5QY/6W8UYoyUsYKgsytUNv4kwv1xhnAJaRdbZbAY0qEEOTPOUzt6PHRwIUUBsOiBFRUfOyS
 tZ2iOBNpFERBp2jjuXm+ljHYElu0M3dM=
X-Gm-Gg: ASbGncsIV2R/AJ0xeIdp8hFp1FlYQM4L8/dEnvaAKNxVRzMVBs80xVgCqSkff3RdpUS
 2+9HGjPzR3SE087HQfJycLIaXHlJysYf/Y2Plwg6aTrIvM/PI5SHLKuWG5DDm8ugbiSEMq4BJyq
 P497kAp01w9YnANENTXmQDohF6v8ftfajSa29M9rFdWghOp9XTBaqASr4NPWBs42abF8w0DFCLD
 nr0iuNCt5EAEB30XRe8PQkIbBvFjQPgaUL51tb1eTPLZrTQ8GqxUQ4Y2bAvXcachxANe4w=
X-Google-Smtp-Source: AGHT+IFDCv/jXClzZvakDhyUPzCXUO3tf/Q9DNbcEtXFP5VaoT9MpRTSkt4XSUHGsRylGDqB21fn2b/WVi8r9BUZegQ=
X-Received: by 2002:a05:6820:1520:b0:63d:bc20:a61a with SMTP id
 006d021491bc7-651c7e554acmr3621152eaf.7.1760877223337; Sun, 19 Oct 2025
 05:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251019092341.1158-1-briansune@gmail.com>
In-Reply-To: <20251019092341.1158-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 19 Oct 2025 20:33:35 +0800
X-Gm-Features: AS18NWAjN-sdsxMinV5vBDV5qmmHeS5qWGY2tJAIflaWkUnhuzVazrTwbff6nbM
Message-ID: <CAN7C2SA-KF_eFGwo3fCd0iUTwAJRi7pVXPsMbqFyr=3-s6ZC0g@mail.gmail.com>
Subject: Re: [PATCH] Altera SoCFpga Boot Stall Fix
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Brian Sune <briansune@gmail.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=885:23=E5=AF=AB=E9=81=93=EF=BC=9A

> -       if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX))
> +       if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
> +               ret =3D socfpga_get_base_addr("altr,sys-mgr",
> +                                           &socfpga_sysmgr_base);
> +               if (ret)
> +                       hang();
> +       }
> +
> +       if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
> +           IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
>                 ret =3D socfpga_get_base_addr("intel,agilex-clkmgr",
>                                             &socfpga_clkmgr_base);
>         else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
> --
> 2.25.1
>

Explain a bit more, and correct me if wrong.
Under investigation on different revision.

"Commit 3563817"
The base address of system manager can be retrieved using
DT framework through the System Manager driver.
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

However this is completely wrong on simply removing the inline from first p=
lace!
ret =3D socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
if (ret)
hang();

In consequence, simply support Agliex series and w/o consider
old series of socfpga breaks the boot and stall the HPS.
I highly suspect either NOR or SDMMC should also stall no
matter how. B.C. the sys-mgr never setup.
