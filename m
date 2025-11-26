Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20636D1037B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4635841BE;
	Wed, 26 Nov 2025 12:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+EmZ8Qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60ED9841C8; Wed, 26 Nov 2025 12:08:29 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE6384011
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-594270ec7f9so6138823e87.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764155307; x=1764760107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYGiADTuUEGU1FCZWMwIHmbsA5lOfjAC8D3ncudAlug=;
 b=R+EmZ8QnGA18dRlvV5ltcST+9YciFFK5h5jLGVs49oYp90xhQdmW3sPl7xrVhRgjW7
 Xjxv07RCal3DD8qbTHI1Ai2P6wVHRa82vcllATwthpwgaTStSrgXo142N6uhSCvXCdCx
 nxzHXlRYLckloquJ3hCqJsZRkfo8VfWbD84lapTPtGHe8zz/aLeU/WpwWSNauFji0xQD
 vUQfkXfdvU2FXYe4lCnxJiGEJ4rGrLZNNbwSK02ZnCsnTyw1TFlpmoq1ISII2joXNGfb
 viN2dvYlxyAFa2tbr8lI6h0IVCOSv9Uxrsf2cwOh6C4tNA85VDLYn1zgqQoGZu17LiM5
 edmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155307; x=1764760107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYGiADTuUEGU1FCZWMwIHmbsA5lOfjAC8D3ncudAlug=;
 b=fkmk3rjZhYwJFE01ECV5e4bMqgV6bLBpfL26MxPmF2vouUIX2nImZrTG+jLbvDLHhp
 yn9rJAEQ7hgTTBbzRJrlB1RqQQUfCZoK+zR+YW2mDTi0eFf9y7P+yUuSwiNjQs9YLFKb
 2jRV89YrGBsyA5LxJRPUVw4YQN1UBiB7ynrebLHRl847Gj8M3EblyhjIswbYzgQShIWg
 vf/vfOzIp0w325txdvQgwj1DyiG9/8FKTqc2Dd4ypBpG3gjA+UeMPFqTi5tbHDWnTz6n
 XUIy6ydxvqsy9cAdmmKEOAgjCQ3ShkoV6zFeqeg2WIB4RdN1AxYcu8DH7WnFuICDxdGf
 dXZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8rpI3KU6AGckuFVTNHomZmeITole7R98AgbNDik+Z8aFF7BZNxZSrl0jcjdcMQc+ytbU9bbU=@lists.denx.de
X-Gm-Message-State: AOJu0YzmhIuAttOcOjlHcyX/wPIJ3JWSjvnnKqHTMX7sZxIkCTHDCbbh
 ilRLpY3WA4YUbXKdMmr84P24MS/kwVVdEGIhmNHuRvoVQmmUrRyv/v7R1zivlrBqRZLD7MwYZS9
 Z5blOVpGN+BjWFGVJENaz5fZW2kvF+ns=
X-Gm-Gg: ASbGncslsrXDfeSycdMdGEdZ7L1gH4TxHZa4CIdDZqXW8VpBK+q5SXyxlvzQL0iQ7aW
 mfAvzfLE30o7lJyZl/aIPWrUiTWgvR39bP2kzh2b2SMnvmMaxoIShUAbstyk4S2Sh0JWvW3PaRA
 Sgg1ZcGlyrpN8PMlLitij8yfwCFJ4qqqcUeSQ5CtoNMNZ7b5lPnGDNdwoBhzY5rfiApn2BfVNRi
 pjhWArJlTkAVbx4nA6FihcyWRJzvihamfGv0MBCfqzdWzmddPswMS2wbePceOHY7zeJx5SMqnUs
 5RiuJNukFMFMaosdHTxDDDny5w==
X-Google-Smtp-Source: AGHT+IEmP894L07Bj4VAhGTeiOK235vDPENTTrWgd5+3Auht0mtGwgCiQbzZC4oBQf5Ha8Bvr3k9KadpJOCMSnH2gqY=
X-Received: by 2002:a05:6512:398c:b0:592:f9dd:8f28 with SMTP id
 2adb3069b0e04-596a3ed25cemr6720217e87.35.1764155306445; Wed, 26 Nov 2025
 03:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20251113-imx91_pins_fix-v1-1-820933392e7f@valla.it>
In-Reply-To: <20251113-imx91_pins_fix-v1-1-820933392e7f@valla.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Nov 2025 08:08:14 -0300
X-Gm-Features: AWmQ_bn1UaKx6PRaGUCiBpyn23nluf2XrWYAZxWnWygw7Z9oiYiTYTgr2Hw11qE
Message-ID: <CAOMZO5Bst+7ghGCGmnTbzM41La4aa=f54JizL5TXSMjbqPcd9g@mail.gmail.com>
Subject: Re: [PATCH] imx91: fix pinmux macros for ENET1_TD3 and I2C2_SCL
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Javier Viguera <javier.viguera@digi.com>
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

On Thu, Nov 13, 2025 at 2:04=E2=80=AFPM Francesco Valla <francesco@valla.it=
> wrote:
>
> Fix macros for the GPIO function for two pads (ENET1_TD3 and I2C2_SCL),
> aligning them to the functions specified in the datasheet.
>
> Fixes: a9d562daa3c3 ("imx: Add iMX91 support")
>
> Suggested-by: Javier Viguera <javier.viguera@digi.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Applied it to u-boot-imx/master, thanks.
