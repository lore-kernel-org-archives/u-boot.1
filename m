Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BAECCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCE98423A;
	Thu,  9 Oct 2025 21:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USCQaN1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA9184248; Thu,  9 Oct 2025 21:38:03 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F5283C94
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-57b35e176dbso1604546e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038680; x=1760643480; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHYiGsyH5gNwiF+Flbd7kywUCl2UyRa82tnC38yl9Nc=;
 b=USCQaN1pxG4RRcRebcX8rUIdCgWHER85qqlKcqdd8rjRukSfhqOF/gachTzhHt6fxR
 lWJGLS7hYGa4O2rCB8iKlcMgLh3AyNF2bVccmlm2SmwAcgfql5XhRK83tQxwNjX0LOun
 lsEzsBjgt3dieE1n5ZZPU9tPQVe3BWIz4QjKdEtrdIJTpxgN2N7Zq1u17OLTTyQV5xn2
 fiAA7F+U70sqxbqMhZqwaii9MHggAoXD8cbZiFM2V6zpBTyaGTBPB/yW7aDF56rxqfHL
 iho7XRJie4wG0Nw5nESEyFKAcOVWT7FjV7TRzPgK6tZxsLjzCQknUqnUW2nqvpITSXw7
 c9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038680; x=1760643480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHYiGsyH5gNwiF+Flbd7kywUCl2UyRa82tnC38yl9Nc=;
 b=TM3O+J9j7ntmJfFEMDz/8ykMe4Wp4gsV09dSQ4pTWGdFagqmk7EeNJhaFPUzyny0UT
 va9AjnhQ0GezaeP1fdsixDrauk5ibmmU8LRlML04xmVR+Jkll2svrE/6qhL9nrTvVvou
 cZhScNowhDt4POOn/NJDEAbHVSA6mgLpB0BtXpml/0P5tnIM+B71oHLAlbNNxVN1s89s
 dbOZ70NK0OlNcRhrv5vH1Dpht6Mt1VAhQrMjQ6QvgiSgw39H1GEpbJw3txczBTWyJ1F6
 8M0Fzw9z1ourWOjYcrrYG4KKsewWmsHRMQLqWCr/z/cYm4s0IaqaQTrDOtuVavUVUWfQ
 1f+w==
X-Gm-Message-State: AOJu0YzPvIhFtzU1JuWpzlPF1G0PbB/x2eG+3ZtV9wAGqm6cn39IJQ6T
 RRgyD5mbpg/0xQQsePE7rffA5NMQZAMkKSCWc9kidzi/YC5wHY+pfWxepJPwdy14m6Q7iurgEUI
 CvJmxTBC+Od/gsNCzWdxMr1Oznxy/k4s=
X-Gm-Gg: ASbGncs51lOSsQ6A3GYQUm68MVmsEHazbzpqwShnwdYvdMQD15EFM+Ij1AFIg3ph4yz
 GPatLKaYjXtTuWiwOSJ9hIRNYz7ghdHmcdyNzQsymv4L+jaFFUXwzd6Z4JKJhm+MRsozmj65EX6
 towx9NStEnsSIt5ya/GNRjgBWOKFvlb26fvtkdeoWFigyt+yjbdiNlstxf2aWYH+qzFXZfZAl/z
 4N1q5sGKRaGETjtxP0CilgP0j5Gx/BLCR8mh+/wkVvrpJ/g6VSMVBmkoVluKgk=
X-Google-Smtp-Source: AGHT+IGf6fJcyAkmki3hLMrjaEsxxoHwAMjUrJshwNshO68JXnSLwp1AnXr2Q/DgVrKs4ypW2APezPzB9DFvPH8iiZQ=
X-Received: by 2002:a05:6512:234d:b0:576:fbdc:e3de with SMTP id
 2adb3069b0e04-5906d75fa21mr2263348e87.11.1760038679936; Thu, 09 Oct 2025
 12:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251008-mathieu-frdm_imx93_fastboot-fix-v1-1-0dbee2f10b7c@bootlin.com>
In-Reply-To: <20251008-mathieu-frdm_imx93_fastboot-fix-v1-1-0dbee2f10b7c@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 16:37:47 -0300
X-Gm-Features: AS18NWDN2kbPJjcqsJs7CSkAeGp21SbQkyS1-x_TEssMHqYnnwZjke_R0DLsd0k
Message-ID: <CAOMZO5CzXwndSrBrJoV6VZ96XSckTVHpNGRHWSG54O1qVG9Gpw@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: Fix USB vendor ID
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
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

On Wed, Oct 8, 2025 at 6:08=E2=80=AFAM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> NXP manufacturing tools expect the device to have the NXP 0x1fc9 vendor
> ID instead of 0x0525. This is the value already used by other i.MX8 and
> i.MX9 boards.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Applied, thanks.
