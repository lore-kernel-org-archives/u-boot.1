Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81CFEDB7CF
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 08:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55F883A41;
	Tue,  7 Apr 2026 10:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="j1AOOlMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F8D84034; Tue,  7 Apr 2026 10:21:05 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE1B8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 10:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12732e6a123so2888026c88.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 01:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775550058; cv=none;
 d=google.com; s=arc-20240605;
 b=R3RRYg7jW7WJMq8PrMTnGKuR85/FeBJbUd4ID6A6eEObIeuqI2iptShhcZGWh1gtDa
 2NzMwzP7Dnh9IAWnpQke2E7DHx5vm2RbNc+2eOTdD+LhNc9N2pxKJRYLAfD/h8sim44n
 RK2GRyRMmbkR86M2wbwrDusKN71yn6bsJ+vOD8+R7MMslSucCj+42pTVK0vy5dC/NATC
 0Rf1J4USZFS6Cfp0Ua5rizmHF6zVm3lmAIXB8VOmbMpfrbCF6vLCjm5GQuCC3oTyMxEu
 24nTqowb5tvQIfb/bLyVamuq5RE4RRykI1EpznkncOtHGOxdAKGPnzW5mOJGmJEosrZj
 qUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IhgX3GHSXLhwqh2osTjt9O5Khj47SJzxXyq5I5V/Zds=;
 fh=X7ZiQQ3sOOg74reXPFineJ1Pq6aEJ23foYWvJiKUtS8=;
 b=Rl78e56WJZrPfA4oKSsttohmVY8vDkCK8bnCx3blvBmccH5CyVigSt2dRy4xUXsIEJ
 gkuDggXNm/ZlauwGnAY4gUEPnNAE8fKjiAx7g7aFz5g5vulTgUjREaoECkrQnz76rxey
 SXPerB38rsrycYQc3kGKAXSe5rByUGKrF7H/TVNhflO3smDDBEPexdP7Oj2eG/fh1pkT
 71RF9B/aDUhplKL04GggecSKrJYbMgGL3iEFdFcTOw+nVtWmQ8I5g3s/XBxstzglcLC1
 ILUd07ljGeX0iFouFZxYiQIW9Qa4M7eQuhMEo8LftAUiIRl9Cin9wuvHaXibHd6Zzu91
 W4xg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775550058; x=1776154858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IhgX3GHSXLhwqh2osTjt9O5Khj47SJzxXyq5I5V/Zds=;
 b=j1AOOlMuZ/x3f1r/Du3Z9FICk4VMu1tT8//DU53+M4NdrukCeDIfxAi5N1HzScuLRP
 M4RK5g1PQOW/qty/uygSnWRT0eL9sZXTseq+nY/y3juJH3VZPAuoYw/4lPEGivHtSmRT
 eg9mUJBLfFBrkbcTu30WkrC8J6TJiPAsWA7rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775550058; x=1776154858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhgX3GHSXLhwqh2osTjt9O5Khj47SJzxXyq5I5V/Zds=;
 b=FFFyVNx4k9Nj5uwhymyfHN0GaDMAG5XU4R5132nu14tKEgVFpfnYY7LTah9IDA6yAt
 yFvnF4NLmCIaS5L1isoB9QuMDKHuUvi+ezuAC/uz9R1U3IosX6csAJY6yXDtoTski34E
 psqrRkzYd/EeVZYnYXVxenFYpNkygAnvBrGAXIhm+ujkuZgFWCtthUk1HVE+KRACesKE
 z98tARU9GAYZNsOG8AcIldK/9rcaEb+6qjQUGADTb9gOjXIan0Bq7cMK7t+yB9wUzDeZ
 qNOFwrFPDc5qzs0/0XWbVi1z9oaoG3+0kQ0Tn+MyikyvggtoJXPJ7mn6mi3PGMDCXD+P
 3ZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPBsuWHAGZp1ngxBWz0C1nyf1jg7Mr9NOqM/v+P1IHEkSJ9sFQZ5QpcyoFbWN9NB779LW9Kc4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+Tzd7VQZqwZ/76AJwLml4AkKGLmuvyH9EAv4zovJoBO/67RYY
 LeO/J11+FXmJx70Skzjf3Yy/MtUwlhukLOIxABLRaI/bn4nyDz9jDoUSLR1fkBqb8/0O+bBd3/T
 mO/O57KBYKV+3cr6Vhc5gVq+ZGNQJx0u8g87NQ43wRg==
X-Gm-Gg: AeBDietRuO5TwIvrnEDV7LpTvubtFbco5BcbKlY83LePlx6Mu33HJ+LUeEs8pYHm8Zx
 EUzmP9zlk8PmcU0d6WsivmbT0EE+t6zy0Rfdz1+T5gpd7T81zTpId1ZxdGzIolGo6s/k88wQPCX
 4MDEdI2WOkSCnnN5RcI35vRnEYCtfUTbc37nKqkg4kOAHCSQIS0/gFK2eDahBN6wwzR46xQl3Pa
 4stZg8bHJmqeQIC1fxdoNI+Ica+nUXMiX5caLlgA4oLDaVDwErwmD8kVSsccSuxIgyv1oEX0Uxw
 SK0N
X-Received: by 2002:a05:7022:23a4:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-12bfb6ec47cmr8742987c88.8.1775550058130; Tue, 07 Apr 2026
 01:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-4-daniel@thingy.jp>
 <adPlWa9YE9_FZJXe@google.com>
In-Reply-To: <adPlWa9YE9_FZJXe@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 7 Apr 2026 17:20:47 +0900
X-Gm-Features: AQROBzAxdFeUQx32JQOTMHu0W1M4PeGpMjWVDJzWLG8djgML0SyktqYzgZxFd10
Message-ID: <CAFr9PXkwLWHCbXwdLFFTZYLRV5Ak_f0m_r1nDbq=qs0verKMsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] virtio: mmio: Keep vendor id little endian
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On Tue, 7 Apr 2026 at 01:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> This direct memory cast relies on little endian byte ordering to spell
> "QEMU". On big endian machines, the memory layout naturally spells
> "UMEQ".
>
> So maybe we can extract the characters safely using bitwise shifts like
> this?

I think this has uncovered a more important bug..

 /*
  * virtio mmio transport supplies string identification for us,
  * while pci trnasport uses a 2-byte subvendor value.
   */
 if (uc_priv->vendor >> 16)
      sprintf(desc->vendor, "%s", (char *)&uc_priv->vendor);

The comment makes no sense. uc_priv->vendor is a u32. The id might be
ASCII chars but it's not a C-string. It's only working right now
because by luck after the chars in the u32 there is a 0.

Anyhow, I think I've fixed this properly so I will send that in v3.

Cheers,

Daniel
