Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF053C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 12:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC7387E7F;
	Mon, 25 Mar 2024 13:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f84OuKKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E9AB87E7F; Mon, 25 Mar 2024 13:17:23 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DAE87D73
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 13:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso687471a91.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711369039; x=1711973839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkZkHDkvmopwcQFLKFK7Ub2U37rtlitl7PjUo6eHHn4=;
 b=f84OuKKf9uSb2VXVnKKau40nqhmttIPnEeZIeljyJuSITsTRwIoY8CPMQbqaNSdCEZ
 JDnTw03cRnmB7a/RlQy40dhgg6/kbMG+tfZqdUefJgWor2YM91ebb2MmuS2cA1pB6Sqg
 Uym+RHPML2pKln/VWkDeejrtj7IUjr2XB0yRn4ok4gVzbrlOQRqrepiBgJ7SXMlASYEF
 TNDY0lbtmPSovC6JF3HE+VwBJ6yLeB+sTes3k6VHrrIhunRaLnWmgcibtQtEIr/6sKSE
 ttTIkptEtJ3wpe3OEkjzNkTSXNA8YLfLx+0eG8KMXuU8yXW1vrcrcO62cvePci5A9PY3
 TKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711369039; x=1711973839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkZkHDkvmopwcQFLKFK7Ub2U37rtlitl7PjUo6eHHn4=;
 b=IQI3IPUNwFdIG4bM+nf5SKH2FdqOkekcQKamTfkKwfsBTiW2w7qmSMGaHdEMROqc7J
 ZVibqrPOJ0ESkOXwIkvnVr0TjFFE+bsDn7WyguOb+By5s8olv2Hsi8OVPwsBSURFtpwh
 r2Jp19e+YHzXyaB/t1LJP/DcN4pBGLfOVma8osHsPZNLbUoxdXILcFV4f7zkTZqCO6vd
 cnuUSqY4GCoLGZEDAMAWbERNNewHCIhdHEu4hFxXiYERBPzyPa8rlkk8MMp9od0ha0WD
 jUCuMJowce4++qYiFeXV+I9vX4JQPYtArg2YIpfUfaRMF0+VIgVZAs6g1w7gJ2Nvqx6F
 7bvQ==
X-Gm-Message-State: AOJu0YxxE4TDPcNOsfoifK14recpKy1JTu1/afjBGrTQOXXIRB4nvWj4
 Xy+I7QTehfR5sr+fUyDcT1iZjOUVMcAzTU7GsACF3oOv7uS3kuq426TucddVI8j9Chfb128vqDc
 IGqwjSi0zTJlgABIMEv90jD4anU8=
X-Google-Smtp-Source: AGHT+IECSWjyabxX/wI6OCar8kiScMxSIswaDmTcAY5auyrYUpOSYvX5muNJvZQHP4N+aM/PMzJEZ8NqibixC1hutLg=
X-Received: by 2002:a17:90a:b016:b0:29b:ef73:44ff with SMTP id
 x22-20020a17090ab01600b0029bef7344ffmr5678300pjq.1.1711369039530; Mon, 25 Mar
 2024 05:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
 <20240325114642.3664840-2-ghidoliemanuele@gmail.com>
In-Reply-To: <20240325114642.3664840-2-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Mar 2024 09:17:07 -0300
Message-ID: <CAOMZO5B0wECVB+m1O-XTt60oA7hMPRvBtjidDPpFJ6aXhRq+NA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] crypto/fsl: allow accessing Job Ring from
 non-TrustZone
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Gaurav Jain <gaurav.jain@nxp.com>, Breno Matheus Lima <breno.lima@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
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

Hi Emanuele,

On Mon, Mar 25, 2024 at 8:47=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:

> +config FSL_CAAM_JR_NTZ_ACCESS
> +       bool "Give caam Job Ring access to non-secure world"

Please spell CAAM instead.

> +       default n

'default n' is already the default, please drop this line.
