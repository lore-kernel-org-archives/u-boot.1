Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7FDD2444F
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 21:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCB28926F;
	Thu, 10 Oct 2024 23:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D23zArw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BB88926F; Thu, 10 Oct 2024 23:21:53 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD9E8926A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 23:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2facf48157dso15727991fa.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728595310; x=1729200110; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiNI9rcEkc0/RDy4p5fZE9bfV+F9JtxpGPiE2f+y2HY=;
 b=D23zArw8PqKiHUL3Nx6hHeLga0dgyfV8rWG1ABN2z3U1hSBXV0bJ9hIsWCWORp1L6p
 wPB09/t2WcGaQeXFPqfreZIAl6v34HMuS/pntIzPmtphhApgK/sDC8iCPVbvuyH2Z/wJ
 hZ7zfElQ5pZZEqxA2Yxh5cCa1iMi0Xc60p3FbgasvOOkVsZPJQ8oaPwtY3zQv0e1c27g
 N0w/3ahcohIpPRjxaNAKAZy7TWr5LHZJFmq3agUJCLKui/+rBI+E08wLrnoG7Raa0Y23
 OCDS+1wHxbSqyPxpTKPThl/wy9+0foy2xMuNN/6xpCwddAr0KExrJ70VZmMUXKmd7Y+o
 iG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728595310; x=1729200110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiNI9rcEkc0/RDy4p5fZE9bfV+F9JtxpGPiE2f+y2HY=;
 b=GSIpWJiwfEtvMDjay7p87a9mUqiwczVNBzKh/ZFZDYyqsyFg8SYqyxGaYMd3UZ1jv4
 tFBMNtH1wC2xBEFFW5zBuR/yiHdoVml9uvf6KHk6dKwTo5DnNMGgQz+IaDQuupoua4ik
 Uj2qCvm7D/ZhNtpRaUABErakY47Le/wnGVOBls0Dk/9yyaxh9a5OT7akEAfZnW1aJo7L
 jubPdJ924U0pcrABWNM9m2BwlrPbENXRozGcyN45xRerL6Q+b/K5uxYJYMJeyfBpCW9x
 OzNv/rjDE+4QyiInmVdT2VKc3uQ0NZM51Yn3RhjawKcLdUkkmVkugEQFAWOwgRxe6QwG
 WKKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYWU75nBbRCpsh6iGrK+4dKLVAT/q/NlSWRmQ5KlHrcPuLIbXGZ47PB7EXZncP7HKYJmz7rR8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyia05YU0I/P1F9zxeqDOtBf/Klez62lilyrpVdp/0su33cedHf
 PE/yzNCejMi59zOGbj4frkHs/31XSbll+LxgwVMjMstRN7XnB3mkCFPk9/76bplMpdWps0Ikpvs
 izdj0/sQjf0jNpxQiB2D5ZRGuiv2eoQ==
X-Google-Smtp-Source: AGHT+IGl8U6MM5DWWPZIB5HHKQZB5T+6SvAFRDts+oOVJTSvtdYxn+3azeVbbwB1W1+8MMWoBWAegVkui+1cWKSUiKo=
X-Received: by 2002:a2e:be84:0:b0:2fb:2e27:5324 with SMTP id
 38308e7fff4ca-2fb326ff3admr1008721fa.4.1728595309802; Thu, 10 Oct 2024
 14:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240930032244.20286-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Oct 2024 18:21:37 -0300
Message-ID: <CAOMZO5ABWwjBHC+qxDi=ibPxgtwKe7rVTxJZWdyqTXp3MZeVmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: pmic: Support pmic pf0900
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, uboot-imx@nxp.com,
 Joy Zou <joy.zou@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On Sun, Sep 29, 2024 at 11:19=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> +static int pf0900_read(struct udevice *dev, uint reg, u8 *buff,
> +                      int len)
> +{
> +       u8 crcBuf[3];

crc_buf[3] instead to avoid CamelCase.
