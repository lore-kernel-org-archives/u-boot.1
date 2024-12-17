Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79678E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71393802B4;
	Tue, 17 Dec 2024 18:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I+7W78HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7E880285; Tue, 17 Dec 2024 18:18:18 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC661801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6f53c12adso335136085a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734455895; x=1735060695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOKASZnskkrD2fPsOUtrLligdZndeyMENGOXqW81EkU=;
 b=I+7W78HTkGJYZT3hpjVAy6FImujj/70k8RPi/zAUlqz7OFjep7hCJkoUT3alBrJwXf
 E4t3wpX9+CAyidLo/9/G0mpRJdgg63GywBYgfwmBoYogYG3N1vpnpfSTFn27TUIvB/z3
 O4400cYa9NwFVkUI5BYdjagvENA5G14f5rOXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455895; x=1735060695;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOKASZnskkrD2fPsOUtrLligdZndeyMENGOXqW81EkU=;
 b=BskEw+dLRkexatI0qm/XvpnGglhjLq2tXT6RMfwaTPj4gmC8oGamtzvo612R1AiWVx
 Vnc7BMJxSVdmGxfK/8Nc9/5qlyIQMRgi1uI63bO6LE/So/gff8Gm9sV1DcIRbPRuK+EW
 LWWAN7ZsiRxLcYLTjExoU/IsXB5ad+2ylsyNcIebjk0aZ1dM8eEyKDo4M55bruALao9l
 nqdzpCG/bSTnLKHIdJQUp4v3AUfIbdb5eANtbLIK748P46X631T2ifmtEpc60THEKp+6
 N5XmdaCthPtm2RfandZroEcKuAo99eC78Oz6npvxT5g0Imj5rkpJMAMuBY8Dm4fjYjlL
 67cg==
X-Gm-Message-State: AOJu0YzQ4VX2cyVy7MBrEAMq6tHY6ctnT70WAGk+IzCjwuqbGc2EqRX3
 QFJDTuf00aLoeMvfo5e1rGwB8qpIJDdViQ2Sphjo127OB2TpB8CSMMgYGj+8u8w=
X-Gm-Gg: ASbGncut9HwwQZy+/JWxmZ58fv9dZABYiBguNFqClw90TpvtgXxJKutboloyI2NZ4jl
 QZrvfUfGyIkhPgHScHh9JE3id3w7zoIoF9Rk8LuSpFlI9MNs3A6mgp766BIAmj4qeNEZIxYd1V6
 TGeDSFkqdx72ue21d2Yj6qlOjryJDPqEYMbOrUzOc/zAmHQqpKepeI17T5APw+j3vuq+scSsvSr
 9BQtESUfpVjWxnJCo5hTMlBKkqm8uM/68RLpu48PYUFOj6v5+2UZ1U=
X-Google-Smtp-Source: AGHT+IFA9hqNQYf85Hqmt50EFfNUUMnP/43QVhdVRsE15AHIFc2I4kcgq38WHFkdDkOU75J43/uAtg==
X-Received: by 2002:a05:620a:2409:b0:7b6:dc74:829f with SMTP id
 af79cd13be357-7b6fbecab5fmr2695509185a.7.1734455895669; 
 Tue, 17 Dec 2024 09:18:15 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bbe9asm336450385a.94.2024.12.17.09.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:18:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241213005903.73919-1-sjg@chromium.org>
References: <20241213005903.73919-1-sjg@chromium.org>
Subject: Re: [PATCH] gitlab: Add an rpi to the sjg lab
Message-Id: <173445589300.4187054.11781033453500566062.b4-ty@konsulko.com>
Date: Tue, 17 Dec 2024 11:18:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 12 Dec 2024 17:59:03 -0700, Simon Glass wrote:

> I have an original rpi installed now, loaded with OS Lite (32-bit)
> Add an entry for it so that it can be used for testing.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


