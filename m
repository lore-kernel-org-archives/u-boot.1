Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B3BCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81C88004F;
	Tue,  4 Nov 2025 19:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iH5v1RvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E4E8390D; Tue,  4 Nov 2025 19:06:24 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DDF8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-591c9934e0cso9267262e87.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279582; x=1762884382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9fC/JHNkm9tXqSM/bsOhDNEbM1nZnV4tQwT43rP2Vo=;
 b=iH5v1RvBC3XNL72vQYiriF3I5FwLe3bsZ+yuips35VhRuKPMyOAjLJI7XxZAiK8R0a
 R+Pn6LnBG+J8A7hsiN1qxcES34RdoDwQVue5unKYn1O7JrXkpIB6jsryWRwrEstcpaaa
 QJlwJ7ZQnqqFAyxJFO5nXNHGVm/Jmm4sV+agA1/SyIryvn5Y+PSwW2kvx0HTP1028VJs
 utI4zrvVYhg2vRN0Wzzxt1uopqYXUWVUaJyf9NCatFHcIb4J8Fx3xWl+YtOyiX/0e0y2
 0/BHaLqDGpZQNTl0sctGuB8B/+dKJQUk4Hva6nk+aOZ7mSECx4bn4p/mFSCaQvsDNkX2
 tYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279582; x=1762884382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9fC/JHNkm9tXqSM/bsOhDNEbM1nZnV4tQwT43rP2Vo=;
 b=YRzfXsZuOQBdGtD7ytDjzrJ42ZX+mZzlr7Nham0s74kKZFIOaLnHg0KXPWzjsj9cBj
 Z71Bu0Y+to10g1o9pnObXJ3rBEU/Z7oKpfPz9J3EbwIOKxZjkPB0WsrGAvcyH/dxXuSf
 dM8BYS0SBiNFxsD8oiOybMkMyXqLJHYVqIQVxPErK5xdAjnLYE3HapUB8Apu1CxEPMjX
 LwMwfvDbsDcPORxMUHdtWM5QdBsgZKKcu6QhUI/A/hj/V/qad1x5p4LBvxP1LCyffMvi
 QaprUQbNkFePD2HOT8WBiCVLg3AiEqvZodRgXgqm8GjqQP7GV0bjLpZFA/XD+B8fOCEN
 5Agw==
X-Gm-Message-State: AOJu0YzTgQ14z8tt1GkATxpEux1cA33q1yKh3fGMD/AzXAZLuYYGLPTx
 W6yTpPxqilBZDfMK55p9O3rkCIetmxFeSJd8IwkoRDVjl1vu2YI8uYGKW8ePcC3kpkg5T1BkPRE
 bOqUMHZqg0CsZgc4zWQ3QavAMeSuwahw=
X-Gm-Gg: ASbGnctC5ZmmfSdeVNEEbVzVXUU9LQPMeVPSdkOxYaPipMbrunl625PvtsHdp2cqDfj
 YFSwmJLNP8ND5d09cfPPA0qyKDfg04NdAzzVey6GZo7R937UbRl1OeNFvmIWObFfIXmeCTVj1K2
 pJuf195BRz1cpABzftrB4iyzctOn4WfH68NnpNJpUfhJYaMZlpXSYpWIFRqqNcFLmtrBFjwYK6s
 J6tDhDtBp+aXR3z1NhDNsFOB/5GPsEA/xDHE6C/uP23I85BvhcmCS1sZxXG8eTL424qgKDlIgQ/
 1uLUIcEph0UrhXDN
X-Google-Smtp-Source: AGHT+IHXZPs9740sQMMz4GyNcAoqFyC9beDgVd3HOamUmy2U6m6fOig/35uwbNS/gY9Ug+YNZeJIToTsk2xNF79VBU0=
X-Received: by 2002:a05:6512:2345:b0:592:f2ac:779f with SMTP id
 2adb3069b0e04-5943d75466fmr22348e87.18.1762279581596; Tue, 04 Nov 2025
 10:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20251104015212.220542-1-marek.vasut@mailbox.org>
In-Reply-To: <20251104015212.220542-1-marek.vasut@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:06:10 -0300
X-Gm-Features: AWmQ_bkkVJo8EOnS9Q5wfPMyVYWNkag3Nf4nXX5r_S0NerdP-R6GcFNe6_b_qGE
Message-ID: <CAOMZO5BPV0Jbu=oBHnL0NqM71OBSeBgqpeGeHCbpXE88Qoe7kg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators for DH
 electronics i.MX8M Plus DHCOM on PDK2
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Mon, Nov 3, 2025 at 10:52=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> The LED enumerators are missing, which prevents the LEDs from being
> accurately told apart by label. Fill in the enumerators the same way
> they are already present on PDK3. Put this into local DT extras until
> matching kernel patch lands in Linux.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Applied, thanks.
