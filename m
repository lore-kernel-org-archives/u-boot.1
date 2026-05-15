Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47A1CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 02:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A524184671;
	Fri, 15 May 2026 04:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9Y23yql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430E78467A; Fri, 15 May 2026 04:19:13 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C848464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 04:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3937014be0cso81014451fa.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811550; cv=none;
 d=google.com; s=arc-20240605;
 b=dO1PTJzDt9qNDEprNZPrMUyqR8GoS+Q2AOvZF4W84BT6DdVDPFsrBsDefm0BBp95Jg
 g6e3VRI4d5R8alz9RLmUmfQZ/FEdZoaOBxX5+ueUnHXjwhgdDGcS+I5acs8TcLk6OekC
 WOAIIYS6js8TrabqvZZMK5RHtnt616CHjNESjxBvn8fbCR3yCUEDqR9bM6Gjlov/VYHg
 tPWX8/1WpFtyDXKLkUFJaJqCiKBGUGlInFgOfux/2lB8MEfjeyChZD4xygQAUBXKYF9g
 dhsxFoCeqxJolztwvdGD2GcPeDF2lHXtTm3eP8CaKGUH6t64OiQ4jurCtyXsutxtXeIs
 Up3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wUhxNzfdFIy3K+yWareVZd1hfjNvaFk/qfZdnBlBaMA=;
 fh=wR+86S+xvD+GQRuAaos8ddh2YMywLITwsKKGC2pMVFQ=;
 b=RYOuLW1N6Y0/3cKirz+QuC9/RdBSZEDrysM35xz3PMeQKeTisAo0Xvy2/wWaoY7/cZ
 SB4d2T0x9zyuG4bH4sI+9+IRmcwGKM4JXg/OLHX1nU4qFpwJ6Ss6HUxfO7I+zeHmYbkM
 zvyXoHSPlwJvHhoM7kOq4NgL/YSHkvRgf5SgjeuFG5pOSaHCSmBwwAoDmLXJI867vXqs
 s3SFp95rlFJtC1aL0q+y2k6pH2UU8HmtELFQzm+SC1LbyzKXVQSldQ3tRQSy/RJ1t6IS
 L8QCorHUP+6nsvi2Gj5hQ6U22E8J5I6gjBK8rNwayIIuY9nJh3IxO6KmnWyIPwtdfBeU
 XsHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778811550; x=1779416350; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUhxNzfdFIy3K+yWareVZd1hfjNvaFk/qfZdnBlBaMA=;
 b=e9Y23yqlRCopy61c0Ya7+6R4ATJ2TpGNTZFSn/JpBsQ30IU4xDdLXKabVV8iI6mwPg
 s35pW65LHVFnPqdEdBjN7vSZv4n7o4abILiy75f1MM2msUBpy9Ci6yQRV0gszOH4mKwM
 0yG4LGpE6YhN1gKdLsHon93gi50QYFAjXC3QeuqD3gbsWy4qEMzABj26MCDCyj3SJoMl
 6eslTzbj+5Itk1XQJ8mFtrwjeSRnk9mT5C+I8IP/kVQsa6WXGqmYKOjxVSsT4TDYflI1
 cOZeEaCVsMhQaWHA03xqDIvoXf23th+k7sR5pesAqT8I07pTp9T6ZcSWWZREXHJC4tXb
 95GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778811550; x=1779416350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wUhxNzfdFIy3K+yWareVZd1hfjNvaFk/qfZdnBlBaMA=;
 b=caWWPugigbEtp96OAR86sQeIf+sgkizi6hy8JJfX15As9uyFGGCsf+EC9LotwWPa7c
 X9TmMhBJbmH4X/HEFwufXrR4rS05g5BqXW6X8ALFtk0+lXREvbreddpr9smaC2NdU9UN
 MnFGQN2ZDfiaJBmP+S2vrp2lNPAGevYxYlMKuXKHGV7eLkmoQmp/OOj9qdZrub/Tasv/
 UmMcZjhEWNaOwb5tNpGSq5fE72on8nkZL0a5nlRAFwnUc0yEFR+sF1cqHrL/l/BW5A+/
 9S06sgJUvPhBZbi4QixKus6GfQjOXYWdsesrcuGaX66AZICvtsOvxWY8o0VCnMUmzzJr
 ne+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/dMU6iJdHZk1B15Fmu+b1e1nmI3DGhrjOjkum5fovhmvW5uKSVm3CyVu7INq0/WhWkj04xrY=@lists.denx.de
X-Gm-Message-State: AOJu0YzuCxKiTaa1Qvifro4k0s8cWkdGCUJcoIoX6o7arGWmEEh61L2f
 GjnEkiZljTHqcPmNMeZs+Msnppw1YvkGwVf4Atg9EICo9vAnfcnjN0djf4YEzX3KrzVb1Ve5Luf
 xjRfXDthvSBSlgckewN6AOKel/puw0x8=
X-Gm-Gg: Acq92OEZ+KI9OMTwa7qvL5NpDmGSYCPl0lkC/+RgM3uTQcsu7CSz9vHOJi8UjPH+lH+
 iSO8HeATB35OMp0FTcYOuLAZqQvrfoZmnedJA4x6bqZVezbOY4Pw+NsdTU5WCL/aOAWcaGs97Te
 BOdKo7MbVPh2a+G9glfESun7+M/ISNpm/9GHq+P9E7vCTeJuRwMpCHgVsTlgVsjQZ8tYdFhmLwp
 GvPuw2Gs4W3YiK7W3YG8icRXbz/k18QiwW4rj+1vphob/DGx6EwyppsvlyCaStfU8zmud0f0V83
 /csfk4/QYklsBmHZK3fyvwmGDtVQeKApCufs60JG+gQULR/CeER/skVxXyAzHZNzNFyZUa6w
X-Received: by 2002:a05:651c:12c1:b0:38e:2fcc:78ed with SMTP id
 38308e7fff4ca-395619baddcmr4970021fa.0.1778811549903; Thu, 14 May 2026
 19:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260428085117.402523-3-brian.ruley@gehealthcare.com>
In-Reply-To: <20260428085117.402523-3-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 May 2026 23:18:58 -0300
X-Gm-Features: AVHnY4LoSLW2uPDh_QEeadPc_VCpll5ep6cPFBF5_9ds4p884lUekg4MThw7XJQ
Message-ID: <CAOMZO5De=9ECdSZ=VxvhrAJxRX7vpHu65hCueUn7VChmBnYPxQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] imx6: clock: allow different clock sources for ldb
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.com>, lukma@denx.de, u-boot@lists.denx.de
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

On Tue, Apr 28, 2026 at 5:51=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:
>
> The LDB clock sources don't have to be the same, so allow DI1 clock to
> be configured separately.
>
> Unlikely to be significant, but the reason will become apparent in the
> following commit.
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>

Once again, this series does not pass CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1450024

arm: + kp_imx6q_tpc
+arm-linux-gnueabi-ld: u-boot-spl section `__u_boot_list' will not fit
in region `.sram'
+arm-linux-gnueabi-ld: region `.sram' overflowed by 200 bytes
+arm-linux-gnueabi-ld: drivers/clk/imx/clk-imx6q.o: in function
`imx6q_init_ldb_clks':
+drivers/clk/imx/clk-imx6q.c:271:(.text.imx6q_clk_probe+0x1458):
undefined reference to `select_ldb_di_clock_source'
+make[2]: *** [scripts/Makefile.xpl:546: spl/u-boot-spl] Error 1
+make[1]: *** [Makefile:2440: spl/u-boot-spl] Error 2
+make: *** [Makefile:189: __sub-make] Error 2

For v3, please share a URL with a green CI pass; otherwise, I'll need
to ignore it.
