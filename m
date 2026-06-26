Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835FCCDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 01:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8AD849D1;
	Fri, 26 Jun 2026 03:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qDT45sLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4108B849BA; Fri, 26 Jun 2026 03:09:37 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C9F84981
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a0a38a013eso385175eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782436173; x=1783040973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntMQ8rk0WPoW63bm4Ymn1lWlMZKhASU6QB32pcUA7Sg=;
 b=qDT45sLKlVYwlh5Gs8AoCAR6S32jABs8WJJ9wIoUFePVYwJ6/hQquWHeg5bAyqHKem
 ZAe+2QvGUobQbAPr1lbSiv0b7za7lWCpkOVc9k867QKNXPB6h2ZyAsnDdT/dKZ36I5lf
 4aManvyqb5S1Ussn2jxNZ4G03mrzyp5BmoLgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436173; x=1783040973;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ntMQ8rk0WPoW63bm4Ymn1lWlMZKhASU6QB32pcUA7Sg=;
 b=l82sSiRT/hHg3nCo7DOegdm+I7an1pgwiukLKW9Q8tL33dIl5DGy68al/MdFVyMwE4
 mdX6cAE89ogL2h1nAa72Qu2KBVxwc+LAKk1Px6Mu3imgsWA5CSKZL6T70OGeqicbWgCy
 nKrZnP8N5HECqfnhGOO+JwHEzbINc5dwVbH68bAbuLGEiWUdh+1FmjMuPjqqndFDD1pr
 tJuhbXxoKK/FTlyC+1/GSk8f89wK5OyqbRW2z4TSvUJzaWd7SI2FjgUBg51bYWDi19zB
 /tJvT35fgcGfJ1Ir0ZbR+MvWTkWyQctQUkDkIfD56Y0ntjDvkcPbXKwB+ab1p8PpYyMA
 pdNA==
X-Gm-Message-State: AOJu0YxhFgatJRt6VHatoeuZUYu+X925St0gvwoaEFawATzhp9NjWdZO
 UzD9i4xLsMKZHTwrLuFPlImo2qGYp2rhsE7k6Af0A/VpLY37nWde3ys4NmGCZbwZGz8=
X-Gm-Gg: AfdE7cmbGGqoL+TOTc3qYwQgQYwC1n2U2/tnP8dkpAe2Ev0C9kK/22ITpIajh06NJ8F
 vDtI26GmB6eojtvte6E7CCa2ig3yrTO5FsQMQOlpAvYDaImABII3sDlfaz/Dv3oKbq7i3akbGsE
 a3PhQkwMFBwjlduGu/cuah+HSYGQZfx7KorrovH2KVhW2uu4S5vcHi/GzwWpOjQ0l3WUeWwBteW
 RYGaY4sPmr0mVUdZoNh6WVHuAHon8hyOnuXJBkK98kDnxVSTVY2fdAgfE2glxdMH1FNE/7zAjZc
 Bijue2yxebkz7OyoheKRu37ELmnP4O1EsVZmUdQZRTkbRFg2eoS0wXEf8dZlsNccBqc5Dh+LFRd
 QU/Q+bmTNLlmUDlnc3Dzvl4vX/9bGDIc1IDZFoSWYJ2IFrQtgLeD9A6GeAFPOR1EVKpA4OMjJ7F
 WoEO7w0rsjHZ8FJUQptoJo0OldiUQaU1jJ63hBL/izU2lrL4pbeeEZna0qa73gX1q7sftTZpANB
 OIb6rZT5pTxEk9CM5Peh0RWccCVn8ZOMsp+xvE=
X-Received: by 2002:a05:6820:1688:b0:69d:eec5:20b1 with SMTP id
 006d021491bc7-6a13426bac1mr3186001eaf.9.1782436173187; 
 Thu, 25 Jun 2026 18:09:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a141048ebbsm526043eaf.0.2026.06.25.18.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 18:09:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Subject: Re: [PATCH v1 00/18] Kconfig restyle part 2
Message-Id: <178243617212.3992068.2483395414526262262.b4-ty@konsulko.com>
Date: Thu, 25 Jun 2026 19:09:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 10 Jun 2026 16:32:08 +0200, Johan Jonker wrote:

> The Kconfig menu attribute '---help---' is deprecated.
> If we change to "help" the text has to indent.
> This again has to align with other attributes,
> so we have to restyle them as well.
> And as there's a script then change all Kconfig files
> excluding 'arch' and 'board' directories from part 1.
> 
> [...]

Applied to u-boot/next, thanks!

[01/18] Kconfig: boot: restyle
        commit: c28e57164d78a671338f1e59ba924190a66c9a55
[02/18] Kconfig: cmd: restyle
        commit: 6f9303f33029a562c027d7c4d464c2a3daa57ff7
[03/18] Kconfig: common: restyle
        commit: 89957a4f58192d68cc84a5ee5c3e6357edb228ae
[04/18] Kconfig: disk: restyle
        commit: 7ffcbd87d2e664fcb6db3adf2efb5463ffff22c2
[05/18] Kconfig: dts: restyle
        commit: 5bae190bde0ddd891560b76c9b8257a7b9246931
[06/18] Kconfig: fs: restyle
        commit: 5c1ab62653eb772fc5e6d6db65c405fce44f86b0
[07/18] Kconfig: lib: restyle
        commit: 8e85b5c761872d56d657b220134cf89c36103a10
[08/18] Kconfig: net: restyle
        commit: 2b92ad862243f8052b66ac8b8b5e4cc2535cb6fc
[09/18] Kconfig: i2c: restyle
        commit: 54cac2bf5cd53311d50b182d5885770126c8ce33
[10/18] Kconfig: mtd: restyle
        commit: 11b7a94757954822d58316024f02a367bfdda99a
[11/18] Kconfig: net: restyle
        commit: 2b92ad862243f8052b66ac8b8b5e4cc2535cb6fc
[12/18] Kconfig: pinctrl: restyle
        commit: 591086d49d170aa32b851011f0c456082e5c2d48
[13/18] Kconfig: power: restyle
        commit: b2c5dd6048caeac7a87175b0d7200565a9ae760a
[14/18] Kconfig: usb: restyle
        commit: 8b09b702d488799ee42fbc7be3b8434e8a1c2fa0
[15/18] Kconfig: video: restyle
        commit: 55ae284935295843ac6697e67425cc163756c1cf
[16/18] Kconfig: gpio: add empty line
        commit: 173ffc7bcfbf6af70cd3b46a30110dad18278f72
[17/18] Kconfig: drivers: restyle remaining
        commit: 145d58e2c7276f68195a7fc760457a5b88f867dd
[18/18] Kconfig: restyle
        commit: 58ecf78d2bfe6f8255604397483953ceee52a035
-- 
Tom


