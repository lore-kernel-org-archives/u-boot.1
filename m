Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D8C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD1282AFD;
	Thu, 15 May 2025 00:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lo4kTnqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3015482AF6; Thu, 15 May 2025 00:50:11 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD07782AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6060200710bso216311eaf.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263007; x=1747867807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iOKflYadlVU+fnAcZzDTgj3xT0p1beDmeremuRJ3VyA=;
 b=lo4kTnqSvTvsfAh49EaRj8u/Dq/h6S2pupTZ3mZKPPrX0sFsMV/96xC2qa0I8t5khb
 DORoEoJ+CX/ZdPDaBeteipbb8HMkOQ0KN5M6q3Ym6Wqthgj+1Iq1lBlrRVueT3plEkna
 RdXQ+vuQ5HuQgSOWjNkEFygggZ3pA/8PRZOaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263007; x=1747867807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOKflYadlVU+fnAcZzDTgj3xT0p1beDmeremuRJ3VyA=;
 b=tiqsQroDRTCuwSOzNv5b1RZYFw9FwQKJ+fAsR83dyXmqnvbp3y+Z+/55Rsg3hBvAyq
 G6TPaQ1Z/OCqjQUpQ70SI/b7elo3M3JIfLY1rVxr/CkqUYu+IR2Rw2xxUf8iV7YDORrd
 f8uPOSM69Ke3mIwvInTdtlwquuzUr94S90xvahJbugNvjKBnUnjKOGAm6Nd9bWodQZZ3
 U3IA4Igv+mZuvZCAx0i+d0UQelzp6x9ni5WVHk3QBp8T8TIC/fwfAVCBsVl7xT2+tmxB
 bDlP3b61tEKOg0yRScAnSpHLIENh7VPy2pehEruiAVWHaTOPWRGFuOnJxHScRHKRn9hb
 hsCg==
X-Gm-Message-State: AOJu0YzEGEH6oKYAAIdBeqEZMg7S1mEJFCX2MJKLw0GUkdslX6DnbtpX
 j4Apx1+XRow8Eu7TodZVDZ1itE+FJdgG04sUcIAke0js70t/Jk2VTCL/qI8WW8h6LQhsceY9h5G
 k
X-Gm-Gg: ASbGnculPYJcTruHQmzNK9hIUhM52FU/sKI4UI8AKisF+CjzPXyiBJG571rdHUuiARc
 xiMoJ0o4atvpT0CUIa/vxm06hZZ8c3hOiMgc6HM3g+f3/zfIZf7pPARVeu/6j0uekSwZSBaPXN3
 nOr571yhYhnaxNPXxTxnVkSQ/03TiE240ODeesghaUFKiFOVhRDvVRx4gEH3e3AANF0CMHROFDw
 6YV7UXpkLpo3otVs8p3dGOVY8PVpqzcyfPo7vCeEMaMtrO6kh0AFho3UiVD7Rd0KHOwo2ou+gd9
 CfDhxLTuXm5XKPP0+3gex31X0mue9ATW81E2/7pLEk/0NtcMsyOTeiRnXhVNM44vFlSRUJEu7sO
 lbB3UlIA1nEBhb30=
X-Google-Smtp-Source: AGHT+IGZPE0oRwmu6zeyaKvzzAD4qK6s0yru1Sh5P7PBVgNRxRb7M8bX9u/vwo9xZun5uDPaxzDHuQ==
X-Received: by 2002:a05:6820:214:b0:606:d85b:570e with SMTP id
 006d021491bc7-609df240b34mr2684867eaf.3.1747263007392; 
 Wed, 14 May 2025 15:50:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/5] Start removing <env.h> from headers when not required
Date: Wed, 14 May 2025 16:45:59 -0600
Message-ID: <20250514225002.15361-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

Given Simon's series at [1] I started looking in to what brings in
<env.h> when not strictly required and in turn has some unintended
implicit includes. This series takes care of the places where, commonly,
<linux/string.h> or <env.h> itself were required along with a few other
less common cases. This sets aside for the moment what to do about
net-common.h and env_get_ip() as I'm not entirely sure what's best
there.

[1]: https://patchwork.ozlabs.org/project/uboot/list/?series=454939&state=*
-- 
Tom

