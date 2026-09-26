Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F98C98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 20:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 913778115D;
	Sat, 26 Sep 2026 20:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FUoqmyvKpaq; Sat, 26 Sep 2026 20:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 95B3981129
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790453990;
	b=Xl/7XMUrmbnpFUr8xAix8YQUyX2rQCX5pYKPjyFTod+zhHbRMFwwvvbm/4DZjpMJMD8F
	 TQu58etZ5nOEtionk++fv+6yQVQP9aI/SoG0OvBA/RocQo9evM2KB2adM4VjdVveIU9Wg
	 BNFfnbBVKPP7mOVTYSyMJvoIPh7EZI2oGawqJUyv8Ed6Wvf2Rlv5nvbqEEPSDQPcHnNSt
	 ULw73KP/ARv7yDbCESciIYgDtjsCK3gDhNoo9URMWYFdDtG82Pfz3gsd7KWFjPc3UAnJP
	 YYZKkre1Pf5HgqCskJLMf550ZU5Xvpdrpi6kZ2bf3KUusDhKaZhpIl8zkPUGnuIwTtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790453990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
	b=Ww18GmiBQTSWKoZFYoP89/MVFBgV5orj1hj1ramOZuuqti0OR89MrfyyN51jmiMHQ2Fq
	 23UyIueqkb7e2BwFi/D+mc8qmpex4xe4if0riBABe+3xnqzQK78YD2om+Ii9hSlTA1FXx
	 aH61gZ0a9rYWQ8mhH5y+5hh8PGrmDia4mMn2p120g/JBUpN34U2NJ3jVPo10l84ixGu//
	 dDxjFcjVLaWMIS5KBhNGQlv5qrbRg0Up7b/nk2eNncEh9yKzm/sLaGo+rkOZQ7u9hQcDb
	 ClDuyv3ZrwlLL+U9r6d13VN+Kmz5chQhDaEf2UiOpagDV5IR17Dg84P6r/CTHWFrTtQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790453990;
	bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VCVCLAa9XdTGbZhdQx96tKrtN4sHTFBVlZkZKTfm9rHgd8KlB5xSnKIXuzHjvM0Y9
	 UgD7ycDhFfaOrL/J9TL6ye/2rFGaExUdypT82Bj6Nv6Pyp7LnZafIqb46w1inXvxrM
	 rvoKhOt390f8ZRb0o4aLtOhA3OPy6gkxkGD9G4qHH6Ph8JADEoJpnKAx5fEw04xXoQ
	 7LZ1+ncpwztyCsRyfXORimHQm5+Q4MkpX8zpcI+rHlzZ+rILVpf7MmiZdjtrf64lUf
	 uJS4yEWEVu6rAxw+2sDigfacw+15iHQ9qpCYW5XAtoZC02MSYnaQoCz7p/bivmje1r
	 IH9/SWSex92OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B3981129;
	Sat, 26 Sep 2026 20:19:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31055DD6
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C79A40A56
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVbiitp_seua for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 20:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB39740A29
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790453988;
 b=jnBDckB8YHUYOcMwQdJdc6Gc6lS5kChtTcqQlVtS1DHiEkOtheOHGG3SnOssSC3CJf9h
 45qArg2tKKtLZyisGBjoddsN01cB2B+DCzphItL3zmt4L8Kld30Sb5MYiJqHS8/f8loSb
 MmiryogN7R74KNB6LZmu57SyD/Y7n7BuaxvaZdTAwIWozGaXhjeHvmFiH/naHzkb0bO7O
 9UsmEtEOdWI+ZTb5SdHvIvGXBZF5VbKHwZVY60MKT0z9y8osfSxJnLnCVcyGGk5m8GxR6
 80mcZGk5YqdquUS9D1OCF1K5d01vlxNqjPjM8k3mUZiuckcjacmhrMIQmMGqkA3/wwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790453988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
 b=Lfeivu9vh7IOMkYGIA8alrds4YUVjt7i0GASpjYd0c063MntMIX8VQR2zGd6/oP/lub2
 AOCfmbWtZeGV3njAKqgTErGFqcRx+ke/nZGEiwhQGPFnVEPj1BuAFc9gT3CSWNQEfMTDr
 U33IcwwagJLS3G8ZuuVPnnSI7mJhlJVZ932loioaU1DV1ob4EPyqIBP1MNhjk5fiETcwG
 fnCPE/f2Wzo9eNoxssGeGjbSEN5H5LvWnAZJFizri0SYhaVXyUiNVMMXhJS3ratumKqbl
 J+kJnBBPrx2jp5keamgBnCXf4UwLGI39JpwUQzqANLWpfRkR9tD7zupBNSp2zzlIK2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="hOyQka/B"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hOyQka/B
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB39740A29
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:19:47 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8d6489419so1544237e87.3
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790453985; cv=none;
 d=google.com; s=arc-20260327;
 b=jdrlGCNDdLd+O8spoOHL9xS1DGR+sTR/6ogRUAwtyKRhB5utLOv1vC/fvX+vdMASUt
 PA8hLQooRShsahamY7S6tvd8KbUKjpDDuu22TEX79dI8RbvTzr9WgIQjcZsxTk8M0oOb
 +VvnOwUS+NuHd1jZuAAxd8RRXD62algFpTMaUzGbqNehNqaxTcpxc9gTNNMTE8b6VvqF
 gmdE9W+HaPm7zrV4/ijS12cr/3qMUD0GscYuLh0VRS9mUfF5mwUHxt+uaWD/ha76nuKc
 WhixHgabd17c4l+tRZcNLMVqDbIj5UDH9F9zlgGcpArKoDWSq4KcF2M31MBwXjtOdYTC
 4T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
 fh=2VikWhaeXFMHhe7fHdOlCOGFT36wa+SPvpEIOMPfRdE=;
 b=dluEocDz/D8vLlHlmC15swE4p0wXcALr3oQl01q3mbtjs9nYn7MWV6IiWmMFuLCg7F
 aLNrvTSMyS61VoSqjnd7a2hAj2vSaprQU3/SyjG+buQHhwqxdPBlzVswtz78JRolf9/2
 3XpzwNvRkAia1qyHUaB/M1Mh0Ov7e8mu2IvUk94GScoNFPj2s7sIni92t2aTZXyUDPh5
 tZbm48SOD97WyT750Vrw1LjEfWuCuayMIg5udDWa6BGypC6lW6MqpenbZSDGMCgx4yBX
 4xALlqgAG45UWCa34o5rehODK83XXgXSmVGMZQrxkFyQJ+27rAQZSPfD2iHg9xTCBMtp
 VHGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790453985; x=1791058785;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
 b=hOyQka/BdKpNuhasYEankXH7IEwGvhY8xyz29iPVkWUmwIhaV2+8gswMIMBYF+rxB6
 ms6QnNXD5CZyDtboWY+WiOndH9rR4mSIT1Sv6jQmu7wuS5bYSmIlDNcKSqXFqPnuPRw9
 012w9G4VSNbhPzFcVXZNlTq+27/Uj31qnoibnhCQLMxQTlDDF7olPEezUw23YqsiTptS
 57aflnyEEDNLru0qADJ8gOf/aVGeN+lu+VjWYlAevF37c7NqfmD6sfsrkJrmNPd3QCKM
 1VKtQ2uFE5VFE38jQoX5CQxC3nhBq480anXE784Tzr4fa3L7Q9f7ggMBaKFywp2tklkj
 7/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790453985; x=1791058785;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DcZ28BhTW+y3zs/ZyW2F2vky0KH9JcSTMOErfj359xQ=;
 b=uEgo5pjclRHB3ipBA3+L5ZxJc3MEAb5Fs7kjCQNl/0wQhYXh3OLMPVtkgqatXT+/2Q
 isYrNK56xQmASOI4aWPdZC8ymujoNQGDOuOpz8FDEDD9+sC52ND6uqyI1XYdi74UTTPC
 Yxvmyt94TVWzYFw2Dqdygrqd1MWkgu7qTC2NmigwAv9acOjU7FEwlLhCrXTkgr+skwlw
 x8n3MRiV8eJWE8FvWgB25Zk2UNezRJ06wTYlLABa58Sg42aX4fdy9cPYfet0mExMyJCG
 0z2qb07Jc61ze32c+FsQkuMv6oFnl/33spUFeA8g3EPluwcdYsixmgK01u9bzMjb1kMO
 Mcvw==
X-Gm-Message-State: AFq9FYJnrDcL0n6zev+rr6a6T7mUVuWJ4jSItSP7RiN5IhrybpgPbTVK
 pjErUc2Lk4vpHwN/Cg/DnKZPZyHA9jm503XMkTZITq5pNTYFeV4yvF21hp6e8iUouFIUeQkO6Os
 nDtddhIpJ6UdmjrCcmcT9gfokOow4x9w=
X-Gm-Gg: AYBFou2CdizCWuNTk5Hvd86GMKTmNk0mm/+xW83cP0d+dftEbKFGweAcndiTPqJL0W7
 1mEDfXcnXFv1/PZEtEOsZ5zlDPoHFdR7B0m4uswulJE4vXh/+S5VfEQIIfZ9+naYf2oNBQ1wUbR
 FSRVZD9mkYGibJpaOocqI+E/6ZTipsQ5D6C1dOpCj3rFcrdvP2JF362TgT8vyuhyophZZJA2g+p
 m50IZmnUx86W2bg1rIMhSiRKZzF2ero1rltY6jw/FWMQk201/NO8cZmqjshySsppjrH5qVNQSuy
 Du3B5i4eJwm1IE9OZVPjl78sqT6+6JjY4v7oFqkloF23uj1YvMWia5nUkBvFpxuyu0ys8q6NUnl
 XzTJGU/ihSlZMChR5ezka3irFfLlaKu44Gh//XtFvYHiH
X-Received: by 2002:a05:6512:1586:b0:5b8:99b1:fa26 with SMTP id
 2adb3069b0e04-5b8df062946mr3379156e87.30.1790453985216; Sat, 26 Sep 2026
 13:19:45 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 26 Sep 2026 17:19:34 -0300
X-Gm-Features: AclHuK9HKcNIO3TH2OZRmTY67l3zjCkgbAmkN0wiEnJdcdXyHH3d9E_KdZRopxM
Message-ID: <CAOMZO5DxpBces5Y4VVHdYM7Lq7JxP-rg+pwqi12LMqsPrUVTgQ@mail.gmail.com>
Subject: Review of i.MX binman patches
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Marek and Simon,

Could you please help review the following i.MX binman patches?

https://patchwork.ozlabs.org/project/uboot/patch/20260910081200.679031-1-mwalle@kernel.org/

https://patchwork.ozlabs.org/user/todo/uboot/?series=523074

https://patchwork.ozlabs.org/project/uboot/patch/20260922051838.526368-1-hs@nabladev.com/

Thanks for your help; I appreciate it.

Fabio Estevam
