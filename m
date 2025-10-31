Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C514CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9F683A83;
	Fri, 31 Oct 2025 18:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/Vv8mVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1707D83A83; Fri, 31 Oct 2025 18:35:39 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0689F83A61
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65677b3aa4bso1234300eaf.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761932136; x=1762536936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6SIVAJpw/92ej5ZId861QequOo9hlFQmd7MD7vHEy0=;
 b=l/Vv8mVmCSrXOIczeqjdfn8wGLv+TdHfV0TNyMLFBl063JbZoVmBLNFBoKhEMmsOLe
 lR0ZBPWRMVOpNZ0TRN9vNtq4K+U9tznrgpal8/00vuiSyqPxdqK9Po8JITtG9KgAijYu
 DYWkGJPunpa5aBgccDzBUWh6kJuh+UAFBJAXNnovsZyupsIGq3wUxh1v/WZWL2mm37v2
 kDQiu1M7uZElzcHlCD/zJzPgL5CuaTclSC3lA32Qy1FPAwg7imppH+PmtQ27d8haawTj
 IwKDF7prZesw9cvPVFi4hZLBoBlyxTYwvpGw8h/p1Vsoon9iXuLY1FTxpOJ35Mf73PPR
 FqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761932136; x=1762536936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6SIVAJpw/92ej5ZId861QequOo9hlFQmd7MD7vHEy0=;
 b=UWgxbO9Al4ar1MiaO8zG1yxsNwfFpRH6cCgw62Pc3iOcVliguBfQJLCP2kn5mpUZrL
 S86APWlurEa8ilV9TQ17wmaEGo2lZBcugz2nvJftuwSI+sPP06fM40YNzCfXpNG7i4uF
 yEX+5tMmCX1/cBoAR5CWTexVkjZyOH425AH/5SOpqslj5+77aV3M3sW2KdnS2KBviwmB
 wEPke7KbccLZ5OpGYG0OkDCG2RvDuxDPCf5fXUYJtX9UExZjP3xTF2DD1bbiilxs0rUm
 0uAy9wR5Oo6/TfvpMWiTs39CpZlhLEN5r7qCQD35uUcYQq/dEMn5MvRmmKYXapYs5u+8
 Ci3A==
X-Gm-Message-State: AOJu0YywDK0Rsy4WqgR9Qk3yFancsnIWjLryt5RZGHB4fhgyA0P2hjEH
 0Ip11JY4axp4BG89UOscLlB39r1Gx8r6lkg49rZUsbUNVCV3ilXTXzusf93rrnxdQjdJKgwfsgs
 utUw/BOS9vvdOtPh3aWUaannpUElnIzVrmg==
X-Gm-Gg: ASbGncvhDvyVFVqN6tAz8kNO2ALh9VVipJsB3ygUh2aQZsArlqW1hQOoR5Pra+b+XJo
 LuTTAcgzSo2nyfbCtzU+bP6I3MC2y3ASTtW8faTCELoClUliRxeQyqy7AKjuRfciR4EocPrNGGQ
 zbXzg/ADyr1f4ksD6ud2pJO/bsJUWf1NgKWD7oLmAvQXDWoJCHe7QYKq3RnSPgp97vd9QfY9S3k
 hpLMBbwS5LFycygzai2temdJ807xdTchzUJM+g2XVJKOGUOBMVfOms292WzQQ==
X-Google-Smtp-Source: AGHT+IFPUAT2P4cdsvuy7JjAHKkZCO9a8pfD7/xLzD3bR8yXSv2FubgjLJiV4fM36p0B1+8cUQkS0oT4UfAU9xR9mIg=
X-Received: by 2002:a05:6808:18a1:b0:441:8f74:e8b with SMTP id
 5614622812f47-44f95fd8eebmr1767076b6e.53.1761932135600; Fri, 31 Oct 2025
 10:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
 <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
 <20251031155427.GC6688@bill-the-cat>
In-Reply-To: <20251031155427.GC6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 01:35:24 +0800
X-Gm-Features: AWmQ_bljcP_b0Qo9BwH84ccRn210kcsUl1L3ey1aclKr-nz6ndNZ3BuJVx08kqQ
Message-ID: <CAN7C2SB6dPGn4Tf_Z7ELK1VPv_LDf_ufRHWRn-u-Oo=xN9rWig@mail.gmail.com>
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> kind of tooling should live. At bare minimum it should be in
> tools/something/ and have it's own requirements.txt file too for
> whatever python modules it requires.

I just pull from official and this is the location where Altera puts.
If you think it should belongs to a better place please do make
suggestions how to do so.

Brian
