Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FEFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 16:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB4381026;
	Tue, 18 Mar 2025 17:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fhzPWFDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5561A810F4; Tue, 18 Mar 2025 16:42:06 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF9381026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asemalwafe@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e6405e4ab4dso2842786276.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742312522; x=1742917322; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cR4xev0BBEtZaRKILHCLPNGxtsjJVKi37DSsjIdnjP4=;
 b=fhzPWFDQkHkw8bNe61ujzWBlTsK24eJ5EASVUNojAST5JUcVWLxspnsrwnywvCPF1A
 aA2uUph6UAWLzdFde6Zwdi67bNIQ+dYjXZbt5R5E8+raRQNeC5R55QKvLnqoS8EAJXaM
 4g+M67UPcrWkz0JIJgz8OHk0QY/76f8tHcaxOVNlmJKQr6+12st5sEtSrU5aREAwE85j
 EXU5HAR+ngBuEN+YhRTsmp3ZM42EnyqYlxW8D31vX+YICIzmB0etoj0e9sWcci3FQJ9x
 bGwHZjL2WPesSA31wX96If2fFSoGN/kAzzBS1wohpKgc+/5lncs4kGAt2XxpVeQ4XxA3
 ClOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742312522; x=1742917322;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cR4xev0BBEtZaRKILHCLPNGxtsjJVKi37DSsjIdnjP4=;
 b=gzJC/cGbMfXsPUA+/0gC5poONKvmpSK0wE5w14TmuAhWzW7AlLHRsQrKEbXkWrb5G4
 fT7wi2ET8bh5BQf5nvoP8vFwqeSgDecKq6ABjz5jStsYp6l1xehpm8MO0fxermReEJ1w
 x/k8iGBEGdGMsOydXfo67ve8Y9Msg+EaC78X578oC4Dur6LIdeZSBZPANcR+odmCs6IW
 JZFgRg18a/Tc8hJ5VkjkKKeyCEaf1k7o1vEPrmzquzFESp+372uYOl8keXq0ddwY2wOi
 rYRzUOCcKSx8dywA1B7VZXhW+4AIic8qICNdsyb9vj6lLTO/gsz54u846pxZRptF34ml
 rThg==
X-Gm-Message-State: AOJu0YyP2ERHnTPRjvhDi+eVelq3bQKsNpc7lXz1193wA+MFMTPM3dzE
 e8PLGFGYz4H3y8VpkEf3C+UTehivYREqltgQsfAjdz4p8sTLYWdaB9Kdht01b3gMZfKT2YAZ7sG
 1E51ETkq1JJCondZMNx6MgWoKuFDZ2A==
X-Gm-Gg: ASbGncvtoIJls64feON5UGjIYQMnfr0FFzjnKeRG1ox4S/2D1muOR8UHPK2GOQglA29
 EbNaTyeEOdCueO+wRy1gXgpxLNX8qxYU3fvMNO0OCCrZO3oaXLEQqt7nqjyiKTEN+aPMCc4WtRu
 tFRlcrCLG/xj12iwEJrivyxRtnIHZY
X-Google-Smtp-Source: AGHT+IHbayEe/pP6u//q9N31UaX1kw/tJ8iM3+VFcOBvcMJRn5DQV0zp9xwBFKKW9dke856BRgCETdK7eWP0pFy/MKA=
X-Received: by 2002:a25:d656:0:b0:e65:5698:e40 with SMTP id
 3f1490d57ef6-e65569811fcmr4036382276.18.1742312522588; Tue, 18 Mar 2025
 08:42:02 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?2LnYp9i12YUg2KfZhNin2LPYt9mI2LHYqQ==?= <asemalwafe@gmail.com>
Date: Mon, 17 Mar 2025 06:33:48 +0300
X-Gm-Features: AQ5f1JqssCnXNR9I_hDtiV1cKXE5dhldYwUq2YDrP-Kxj-fAXHKMQt8LuJlgdtM
Message-ID: <CA+BXrAFmeO72n8HhsXphU6UZqMxbPPu4k2=enrL+kJsSac90aw@mail.gmail.com>
Subject: Re: [U-Boot] [PATCH 13/15] x86: Increase the size of the phys_size_t
 and phys_addr_t types
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 18 Mar 2025 17:06:53 +0100
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


