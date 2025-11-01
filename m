Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C38CCFA02
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 18:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCA383642;
	Sat,  1 Nov 2025 19:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FHN2I4hA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655F083677; Sat,  1 Nov 2025 19:44:59 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489A48331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 19:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-378d6fa5aebso33346601fa.2
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762022696; x=1762627496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU9T3ZbppLCn/On+mCRXM+SwGjh2AY9L7mmcJhw1DFQ=;
 b=FHN2I4hApkM1Zzwu0/N0oBXJAhi3TJLUN8wmLAmdXv6wxUO4DXcqBh/vDktbIJWu7k
 cQ7p6D2R88NVCZWNBP/1zVG2Jly5MbQsRWPudfAhvpyChZIWqY2+UmViyT95pu4V3ENs
 ew6pDW7PVXOdMAD6K8NcwYlh5sYlEtu2QxmhVy1SHpL9NP95cgSxPoue3pxP8VyvzH8o
 hMwXXlk1tRr7zyxldJHtLWREZUWaHXqLGhCjZFW3dEYWN0aKYyw3NY6nYqHCnPWUwn0H
 YybSNBmeZrvLpNCiC9C5Oycqi/LNS03dyT959Pvp1dQn2iUxtjIlPMpINcUyRoBxbz3V
 IJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762022696; x=1762627496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WU9T3ZbppLCn/On+mCRXM+SwGjh2AY9L7mmcJhw1DFQ=;
 b=am4nxUdFQsHMEBoeDWh9y/VX4IjZxecR1FKEsptcc14qPK3cn+sWkjjxJ9XeWQo+A2
 mJCqlPaxyStMT2VBkdB8v5AMpv7TMogsrJnr1RnECqpVM7F57Yo/I+XDh1QZjACk8cni
 SjNugBpsxv1ny3x7nwn9eGrTcD2aKaiGT1byRUytbf/LxJzfIURZMU6q2wqpWdSvpB9c
 DEARqI9EwnGZXS6sUh3tsQVGqE44H+LulPnrMAbLqgaLhw6RRWydQoxMEaHmD4PL26A/
 JUMrtsfOcraRdHPH4+H/peSRVjhUmc/YI3JKo6X6iw7GP/Mc1G2NF3QgHOcwxRG1u5Hc
 4QkQ==
X-Gm-Message-State: AOJu0Yy7puLv+q5JKrJOzZtWyrekp2ootISuKbSNRuFQerL/O6KxvwXL
 KChuZQoZW6ughPi15T/yY5JKNWAnA+VMrswbfXXvt9l1XeKdMVfvvF96cqhv2Eq8rIdZvLYk0Wj
 rXwMSRPV5/fyXjhCLFcTs3A+uVut0PbJYJPL/6/s=
X-Gm-Gg: ASbGncvfq3Pguq3Ahz/YokZrs4f0DleP/rbdGT5+1agyxnAlq136s1luSPx5lIrhGb+
 7NlAqHp8lfJmockaKXQCTvw7sOKlY6HyEvX+fdNcO6Adr3Sw9wO9Q0j2S1d3Vzpm6nBWB1yz3QX
 +vsHISqQeVDdcLGxz8YpCxR5lLoE8lboiDlU3+l5uieF++y4ydFu9i7dIc4FS1TxRWGwCgwZ2gZ
 jCPZnC2cN1O1vvE27d2I5NXH5AqSuvsI+JA+YN2KtEXyIN0HMd2KBYqh9oY9gTvSCV8e83gKyKL
 S+5vHCNPvEjnwJpsKDUlb1UMiVOp3Rz4qwkNqg==
X-Google-Smtp-Source: AGHT+IG5CC+xL87urJWPXIdYW0Wc9EJtQdDloV4/qw0J0+RTbqjlzXgNxuiCf36N9n2Zq3nBmn8Oi8JJDHSqZp3dnpg=
X-Received: by 2002:a2e:bc25:0:b0:37a:2f9b:92a6 with SMTP id
 38308e7fff4ca-37a2f9b93c8mr3403621fa.17.1762022696173; Sat, 01 Nov 2025
 11:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <63bb0a47-d02d-4d73-a63a-3f6b37caa09e@app.fastmail.com>
In-Reply-To: <63bb0a47-d02d-4d73-a63a-3f6b37caa09e@app.fastmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 1 Nov 2025 15:44:44 -0300
X-Gm-Features: AWmQ_bkuIhfXTgzF7cNXOUBGhdB9Vsdl_Cj3A7JsP1nLjARWpq1Rs4JLGP-r5kg
Message-ID: <CAOMZO5BD=Q6_VamiPr-qAomfmszU41g8ML+q0sOnSn=Bj3ooPQ@mail.gmail.com>
Subject: Re: building u-boot without pxe, dhcp, etc.
To: andrew@internet-e-mail.com
Cc: u-boot@lists.denx.de
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

On Sat, Nov 1, 2025 at 12:15=E2=80=AFPM <andrew@internet-e-mail.com> wrote:
>
> I want to build u-boot without a network stack (the target machine only n=
eeds to boot from usb, nvme and mmc devices) but disabling pxe causes a dep=
endency problem. Does anyone know how to resolve this?

Try passing CONFIG_NO_NET=3Dy in your defconfig file.
