Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AECCF11E6
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CF689025;
	Thu, 10 Oct 2024 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XxjrX3qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7EC88F30; Thu, 10 Oct 2024 13:48:28 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBEA88EE6
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 13:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arthurphilippeheymans@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4603aced3a5so6862721cf.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728560905; x=1729165705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oaiE3R4REv6EITy5dejfNPnwXMTC1Z9WkMIkRjPiDaU=;
 b=XxjrX3qfdPzlPttImg3Q4eYRXgPbsByNC5Q1ZCZmUkfi4CdMRFt+T7GQAgq/2bu4OD
 VZI4JWvyoDVSBbeMD9vPczPwIPt5FMISTwWCeWPc60db8iyiA1b61WKKmLJ7NvTjWr2X
 IDxnkxJXB5O+fhmAUqwwwuiYJz53ZWM4in+m67la80sbjKmGuVaZXUmpEsF/386oO6IH
 //X1x0yfCiIIrVxIbdfX7taPxBkX9ZpZ7BBkRTfwa9lr+N9xLCTAGn2X5ytwiEebSx1D
 PqbRKD2ddWdqcVIz1S1Z0Efnf0AgsNK/l73lQzRonTsr/d6v3FO9RvXAO2xLWNNmqqAy
 M+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728560905; x=1729165705;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oaiE3R4REv6EITy5dejfNPnwXMTC1Z9WkMIkRjPiDaU=;
 b=LLvgLsI/z47DgXlGpD/s+ELuVeHgZolLyTTsuunUjnNstysajqvos0z6nbnC0LGAGy
 4ziLKHduNXZVJc1MDA8JcgJjfd3BkHdmftFnER7oaURRXxoDtwxd0Ro4+wLzmsve6ETt
 3JgoFDn0rgHyL0UGPpEonVPccMdMHXKX7kZwAE1KM98jO9Iw3fLtTcLhEW74oBwB2iVP
 g5igNT7uNrHXUgWOkaQ2OTbBW6G/rXqVHp2Sgs2PQ4vADgJhGvUnaocPM0KWxLAPFViT
 G7wtAbSTDBwbgGzbvxrYGeJaFzz/05zRES+Zs4spVX9ylYswH+0AqbatQSkWO9SSSfLb
 uKiA==
X-Gm-Message-State: AOJu0Yzm8oh8e3/vST123aTuNsEuGpn/t7HRhKVzh5TzKuWYd+IdI4uZ
 Oo2BsxpCj/a1HZlKBJsRA2nWA9YOMZyUU4GqwKrTqMFTckTda9oDHl5OZbefa9qmqQ7Q0wKoRn/
 rh1K74Sj5LWxErNb1jXscFszLDlM=
X-Google-Smtp-Source: AGHT+IFovlSzH/+btLDcqn1tYYo09jxnpIuZAivPowyr9uSmVkOraWHYOG9i3aJWL9gNd0scE4ucWMIQigPo7rpYlng=
X-Received: by 2002:a05:622a:48a:b0:460:43c2:df00 with SMTP id
 d75a77b69052e-46043c2df57mr15719501cf.43.1728560904886; Thu, 10 Oct 2024
 04:48:24 -0700 (PDT)
MIME-Version: 1.0
From: Arthur Heymans <arthurphilippeheymans@gmail.com>
Date: Thu, 10 Oct 2024 13:48:14 +0200
Message-ID: <CAC8Nb8Q0ACFhUxvmFM5YRSE=b9XEQQH--RQ1iZdva4LNzXDBRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: heinrich.schuchardt@canonical.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 10 Oct 2024 14:50:10 +0200
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

Hi

The addition of the line

ret = device_chld_unbind(dev, NULL);

Broke booting from sata with qemu q35 with coreboot + u-boot for me.

Kind regards
