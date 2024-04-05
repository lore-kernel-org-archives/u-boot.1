Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578E9CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C5B884EC;
	Fri,  5 Apr 2024 18:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKlUMH09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921E1884F7; Fri,  5 Apr 2024 18:49:41 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AED8883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso440348a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335778; x=1712940578; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0+NWBUEHS5Pc8OPryk6IJy+B7I6izI2nBilH8G5cEI=;
 b=XKlUMH09X6NNQnRT3viS4KKcpA8Dr3TSTd0C2PfOuqt6kPStkp2m5NS2sqh3IIQvMp
 wEX2+Nbg+RoceeTiub/ZggL4HFjQarRZFhaOQ/9Xd9OO2Al/73y/sL0w+OwHTqNt/kVj
 DbkWJemmaVDOC2nDGetHYXiNC/ZE+sP4YyZHGjabAjG19z6wlmK7WXW9AMXu5ZVQajQH
 q1XXK0WX7WGH+03HCxMiIldNZ+waJpAEy1YtwgNRFBvLT9CbPIN1uVHJvyAuMCFK+SGp
 2WBz7P3jRmJkPEEEhBXJ3ZLYdub5Ct6CslFaZaqNqVIDwTNPLTMdiyJQrWnCJTIZgOKx
 Mu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335778; x=1712940578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0+NWBUEHS5Pc8OPryk6IJy+B7I6izI2nBilH8G5cEI=;
 b=Bwap8HNs6cN3NzX/lZsxap2LLSLmIGeJkak4dYQkGS0BIsdePqD83Paqzui4rMimzs
 iaAbOfvKWShAXRlZnqVtE7/GrjDf4FDtEank6Xkeylkxsq2CmmcnrHEe9dijQDN2JCOH
 kokZRAJNVedl92bQQv7zKNWKfe1PtZD9kDgv8699PRzPofYrDpgwPg0l3VfIqbA8XzFS
 0jYtoUOIwfHP7FCqG6gr9BNw/oezPqMyE8PaUlnaSShh/eAzt8GNgaaK/kSp8YqBefih
 VAAAzSm5KHRKm9VtMDYOxBsZ/z5wPimPOk8v8MeTOj3UHIalA7fnRHDQWP2lAdgOgi/U
 YT4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Fius8kbAG9Zv2roXg99worURckFjWbi7pGJKIqSm0LI3G+BCZCZ6ZkGZmHEr0N5Wygepll13XyhB7yauzUjmqS00/A==
X-Gm-Message-State: AOJu0YwAE/xsjRTKYiQkdNlHOg9lzgFj9fdGVmR6OQZ47mtUSI1vqU8s
 MiTz8X9ZtRfL2wFv3ja5h35ka4d6fHyY3X/tI/cRcuBpv7f1FcdwZkJrCED44sEszKRzXz1CY/n
 V2Q7L/3gaxwjmYvyKbUVeQ+SN2PE=
X-Google-Smtp-Source: AGHT+IFPqCoi57/KewXLZxj82yuGHKEYKWYhcn9DFjl6fC/PgCFTQQ0t1BwQ6PJFH0mJc+/3Q8UppmvF5spOJ4yY+fM=
X-Received: by 2002:a17:90a:c695:b0:2a4:949f:3220 with SMTP id
 n21-20020a17090ac69500b002a4949f3220mr427866pjt.3.1712335778046; Fri, 05 Apr
 2024 09:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <1711935669-26353-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711935669-26353-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:49:26 -0300
Message-ID: <CAOMZO5Cth=tZOiP3NEZyvzu1_GHRrSS-sH_WkgsyiThKRTXNWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: imx9: Correct imx9_probe_mu prototype
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Sun, Mar 31, 2024 at 10:41=E2=80=AFPM Ye Li <ye.li@nxp.com> wrote:
>
> Since the event callback imx9_probe_mu is re-defined, update
> its prototype.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
> Changes in v2:
>  Fix imx93_var_som and phycore_imx93 as well

Applied both, thanks.
