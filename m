Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CBACA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E830080FA1;
	Fri,  5 Sep 2025 14:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5Ni7yFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F1D83164; Fri,  5 Sep 2025 14:43:05 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A809800C1
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 14:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-336b5c44a5bso26023081fa.1
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757076183; x=1757680983; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTQr10S6/LWX3s++2DLMxTlJxyKXo6d//enPxw6cKDw=;
 b=C5Ni7yFkKvqviOiJHm0p8dquXuCC3c9fDADlK9ur6PnzFY4ohEBzeAmRHRBgc8JNsg
 ERKKNyPUdAfvYnXGgZyujWPLijca8RVOhs0Ce3lT616ve9DZznDXuYnf6VDmsqAzupSE
 T6Sw5ACNBQp3QH2MCNVNoqlKEee/fyzUZLo/gjmsSxX2gpDCr0h/Zy9w7hSSkasaZy3/
 4dtV7AjB9Tin4+Zk49O0f0qekaeYgsdPgzf7/YtuvGnCLBWWb1Bz132jrzdc18sOjr35
 k3SdjpVpBg1aer8v0u9ziFiZVE87tRb2PX5EA8/YJyj6IhkSjZrUk2rrTk1EL8H75Cwk
 MogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076183; x=1757680983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTQr10S6/LWX3s++2DLMxTlJxyKXo6d//enPxw6cKDw=;
 b=sZ823JUbrEQ+zzFJGCA7ozirCaPbf6uQrxyxyPQSZF2ssnA+EV6UNkrhhSnuO+0ib7
 19QAa5LfEGce2MAX7HtSeEf/ZGkreXy06sKTCQOhbS391u9sq7XTfpWOvDLpEW90V9Q7
 htNrMt1FqP1SmSJ20dPVGfv3tf46nFUURzBKg+NBEqJjDNsTNV2Pxf61NzE8essO5oLh
 Qz0pjLxomTCYYYZy1RQZNbV5Dh4fi+j1BtVRUNWO58eq//uNj0n8Vg+9w6D8DsZkovQa
 Dy14sPzXeG2aqDqK9GrDVD8FKxx8VodHYBXTvGKmXQna+GDoaV7+umnNx/msWFhge5WF
 wtdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB1//zzTtwQ/H02yoCM6u2R84EPDmBiPtnyRy7dblDWlfxmYSfApEj2d7o7rRhCkvFI8dD6yA=@lists.denx.de
X-Gm-Message-State: AOJu0YxQqRTEzvWA49kQimDwaGnitE9FyO5n3KGCMpJ6CzC4wjm95Esl
 6L8oIjjbuSBIe/FLhfo9Kd5DO0qlDj5zMSbFizDmoyPxBC5HHZiNdPcHBmk2QDawO8sEd/cR4LR
 TrfacWxP6Zi4abotMm0farr6RG8dgJxDTfw==
X-Gm-Gg: ASbGncuKTg3RPSJyxrOl1w8ZS02vnVq9IbJ8dWtvYaf2OwAjT1uEh4DnDuMazUR2K2U
 gkigqxjneng4IfSPlMvgC1CauZwS8hXsXgfDng1VJatzDxqdBWNkLAXHqHJC0MRDcna7Zc1ldR/
 HSlpQQ4OPv0pOMzyngr6G3SnDgdbv3l8yELDFd0cEMBEGy3ouyEsRJwzswr/bBKm8BigkoObaKy
 J2uergWhEzfeKaTDxVgnmaiajVcwxuwAbabqKs=
X-Google-Smtp-Source: AGHT+IHNY/0Wua6teaID177/9LapGlpMuFIe+4RlE7xtlIFuaT8zNDLtz1DcHz48VACnGFneyj5Wc7cSJz8dubd3xx4=
X-Received: by 2002:a2e:8215:0:b0:32b:a9a4:cd58 with SMTP id
 38308e7fff4ca-3381e5e71f0mr6908331fa.15.1757076182502; Fri, 05 Sep 2025
 05:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
 <20250814-imx8m-optee-enable-v2-1-c489d795ae07@phytec.de>
 <7e21749ea852683f04ad4656fbdd8e60d26d93b9.camel@phytec.de>
 <d7985ba438722fea1c921372b42a3fe0bd073d06.camel@phytec.de>
 <773f80902471cf12d4f2247b4b468b1024817a93.camel@phytec.de>
In-Reply-To: <773f80902471cf12d4f2247b4b468b1024817a93.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 09:42:51 -0300
X-Gm-Features: Ac12FXzWC7S_3nJLsQ2lcnQbx4rfvlD8_JEVAKBZV5t9V0zjIk-lrTEqZOmucHo
Message-ID: <CAOMZO5Au4Qh1Q-5nkqfoPpGy2hs1=XX2xQ_chVHOcWxxSdTPrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] phytec-imx8m boards: enable OP-TEE for KASLR
To: Teresa Remmet <t.remmet@phytec.de>
Cc: "trini@konsulko.com" <trini@konsulko.com>, Yannic Moog <Y.Moog@phytec.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Jan Remmet <J.Remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Yashwanth Varakala <Y.Varakala@phytec.de>
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

Hi Teresa and Yannic,

On Fri, Sep 5, 2025 at 9:37=E2=80=AFAM Teresa Remmet <t.remmet@phytec.de> w=
rote:

> I am still not sure if the end of 1GB is the best solution but please
> use that for phyCORE-i.MX8M Mini. I plan to send support for the other
> RAM sizes soon, too. Including 1GB RAM. 2GB will not work then anymore.

Should v2 be applied, or should I wait for v3?
