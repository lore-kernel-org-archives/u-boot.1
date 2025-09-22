Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92005CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB448350A;
	Mon, 22 Sep 2025 16:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y8r9cbRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA20D83526; Mon, 22 Sep 2025 16:25:13 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB6983443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-578ecc56235so3635464e87.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758551111; x=1759155911; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKf4W0tST69Vz6OOnubUtHqnvOBqFkcADKg5RJsmCLE=;
 b=Y8r9cbRmtuG+EzqpGHjiAnb53wDtRtmlj3E1INXqXUrtJyfrj5hMDGMu0b5Ri6RyFn
 kVylkOXNKi4UERnrmbq3qI0ouKXMh9ORlskUG0KqP6IgAUFIgDw4qzcQEy3hJAU2ctVx
 XMRuZI7JkKdiUa/hkN/TvbnD9bWJMIz+Qs3ME6uhwx/d36xUuyyYNs5yUJQQ/x+fIPcC
 JPGZlsyIUEslRou3H8zrlh+hx2JOuc38JUEPSfTcdGysI1e8ctJVMI6LVdIzI8UJ9QUZ
 0JbN8xsjfEi1DrjD9EYQJLzP13ox7AB0SFha+INhG+MDHxE+b8b4ApxeyopPwAvd/LnX
 74Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551111; x=1759155911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKf4W0tST69Vz6OOnubUtHqnvOBqFkcADKg5RJsmCLE=;
 b=UA3X0SvOAlpONr6ZHTZbzizKxxl0yekeRX2WWhjcb3nKrGcdqvton2OON3VOtp2pc0
 oemFbKK2SEqK90Arb0R3fiaa6A67ZgRlF4+lFX6C8ABkwkK/B21HlnsAzjZOc3mnR+RE
 WKI/N5zcpDpKJHWoSfp79TIgoS3kRiEoefejLDB7FIxuG2A+LiuKKVFU5SWs42h43Ozd
 ckwCDbA+KZQRwdEzpMlACeeSvvp6DZhqbpdifu2YM9vrRY8Mv9Es8CMT8dQC9Guqyo5x
 fU85y/QIEzd4P7L3dUN/14ojA1DSY83zrcrUK5dF5pIWxWIdqziwq1qEp3vOSAlSwGYS
 MPow==
X-Gm-Message-State: AOJu0YyIi/w+13toR3QkfXbhOlWewjoDqgm8e67QS3Nuv0wzwTZgmT+j
 UjG46yGRd/+k1MeLxRNw680aqCbkwSjGdYq8K1g6a7GG1TnQsRC/QU+EjaqNJUfUPcrw0mWfyIS
 DzAaHHMiOtFpu3ZAzWgOd2dFDUlVt5w0=
X-Gm-Gg: ASbGncve6kfYIUlBZhJSX/NPsu0nZdPpd/5eIVwo095BXGICWBoUkG/QCxotGFVUwrW
 y4av5D79tyhFo2UXSXqA+px2mOWAHQQ4DpFsJneP73MCG9MhEJkU7UM3ctdL7hJB9zWUN5ycMEw
 bWOu7JTM5ghnvkCLBcCxVNThQAzrzYSXfCgUebgDo44LZ3SEV4xaKWbt2Lc06P5w1rIqKSudX3F
 cES3iA0CRivEMjxi1VuideZ1FAE2wjMGb18A3k=
X-Google-Smtp-Source: AGHT+IErukkJVYslv91uGivJhr93jfTD6C8JS/ZqfVPQXjdSO+fk6ZPcJEhTKyZq1E0VFeMJqUvCdC3Xg9dXZcUcvFw=
X-Received: by 2002:a05:6512:aca:b0:57a:8b00:fa5 with SMTP id
 2adb3069b0e04-57a8b0010c9mr4530956e87.51.1758551110938; Mon, 22 Sep 2025
 07:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250919065834.1497068-1-ye.li@nxp.com>
 <20250919065834.1497068-3-ye.li@nxp.com>
In-Reply-To: <20250919065834.1497068-3-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:24:59 -0300
X-Gm-Features: AS18NWA7xJx7_uIr_QApgG8A7ONDgvtlYbH4YXaPIfU5m93RNNa_E5T-ghSRJxQ
Message-ID: <CAOMZO5BFVgyELK7=WT=u3R1BVMTrm=59xw42H78qRsRBt=50yw@mail.gmail.com>
Subject: Re: [PATCH] arm: imx9: Fix LPCG number in ccm_reg structure
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Fri, Sep 19, 2025 at 3:59=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The LPCG number on iMX93 and iMX91 is 127 not 122. The wrong
> value is used in ccm_reg structure and Coverity reports several
> issues as out-of-bounds write.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied to -master, thanks.
