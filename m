Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA5AC27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE77883E7;
	Wed, 19 Jun 2024 09:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAIMJnlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F7C883E7; Wed, 19 Jun 2024 09:11:22 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8B9883F6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6e4dbca52f0so4661998a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718781079; x=1719385879; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B7Kpp86ZRB0FFXPlFuzXVxx43kUapkBbM7qeY06WlXI=;
 b=XAIMJnlHjQxHo1+I77AbR0qwg1kzKlpuJyDfWKKhXj7q6T7/AgZb5Zc8rQOIFFHv/C
 zmLdYbkn/kE0bNAbLJ/ZV7Z3en6lF7u6hd1jxw9WVhjrm1YqsrdJs2Ap8zQnR0RBHsRi
 B8qgzgjp9PLBpYJlv9FSCN1sg764f4Ew8hQ98AHTtCSbj022FTMOryZvUpv6Dzse2jAK
 ZLV6a/m8kqAmn3hneylUtyXwFpZv4ArTwIPkTeCdFxMK3UY7hod2lhYoOpGoNHxld+BW
 paW3hd0AvwltRYRe2ddWAe9ploQ0FpBltXBmkRVj7LYqdKSlZqP2qZ3Q5DCgTkNEbFZD
 JYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718781079; x=1719385879;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7Kpp86ZRB0FFXPlFuzXVxx43kUapkBbM7qeY06WlXI=;
 b=YJI2XAIABi3jUKQeO4s05dwgcKptOycUHS/mKC7hg2bH1oipFcO7qyTRHb+Qm2bkXr
 uPGs6O0hT44ZRDJ3be+WVldjyAavLzIYU7eLYrrGsDj9jF5cF0WEzUcNaGcASXj3s5sR
 W0lpS7rIqsP1MEGKYn2erY8MPLAD3592zv+fHPIPZePnrUzjDlZpIDTzW5Oum2Z9k8vq
 mEK2DczZpDw7VPbAhv24lDhQny1eVIy1+kuMdck0KevoLtxtqldAi3lJEaVe7LYvkeMj
 pktZWImEJVainm/mm0Ym/tGj2eJ9UQk3Z904UTZmVRrH9udUCmAXupBp1Hdnsiy5LzTz
 4WmQ==
X-Gm-Message-State: AOJu0Ywje/u4kTN8ZwEmbPli+ztSxq3ufr/oIacQ5gj6pmEnVHa5lpiB
 SvZIlZca2G668DJTjpxEWjlJgbaizGAoaVnJwUQ8lUYf5s5llNs5MVXLIbxZB7QhfJqiNDlmhlk
 XwfNYF4yr6SvqS6nDLLKL9t/u3Jv4rA==
X-Google-Smtp-Source: AGHT+IHlV/lBlrT/SsRqlKK6ViJMomAysm7b4Jp+PKlWBOrB72CyX3z3Nft7zBt9/kqwcBli+LkF6eOceMNduetGIIc=
X-Received: by 2002:a17:903:110d:b0:1f7:2099:6f9a with SMTP id
 d9443c01a7336-1f9aa396de8mr20955855ad.11.1718781078857; Wed, 19 Jun 2024
 00:11:18 -0700 (PDT)
MIME-Version: 1.0
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Wed, 19 Jun 2024 09:11:08 +0200
Message-ID: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
Subject: How to retrieve cpu info from u-boot fucntion?
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

Currently, I am using the MAC address from eth_get_ethaddr() function to
calculate a hash value. But, I would like to replace this with a more
unique device info such as cpuid or other values. But I could not find any
function that can retrieve cpu info.

Can anyone please point me in the correct direction? Do we have any
functions for this? Are these things part of the documentation?

Thanks in advance.

Kind regards,
Sourabh
