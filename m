Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C3CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F2F832DA;
	Tue, 12 Aug 2025 00:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f0xJ65MM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E08D8329F; Tue, 12 Aug 2025 00:21:01 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED069831C2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dc9e7d10bdso13270745ab.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950858; x=1755555658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i0MdU/cUfE4qsDs2thkk/fjmAh5ZrnjgHLV3u9CoXwE=;
 b=f0xJ65MM34pPKu/PQd1vGd9M37khb7c9Ib8n+Lzc7uzuX/uZLUba1mGRZLK07xaAP0
 dJPQsiYLiPSTwjquEX/cYenRRPAqC2UBG+qBNNXZGAH0lG5Oo5LvW7ZPXmsrOGbnxqYv
 dRzjlfWxD9MtpyYYwg/ui3sDAs4BfcTHHQ4/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950858; x=1755555658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0MdU/cUfE4qsDs2thkk/fjmAh5ZrnjgHLV3u9CoXwE=;
 b=e7Om4mhUxi9CrDA6M+iMDA62wriiEQoLANGNOiD209RFTbSWtqCpvJwo8n+Wk/F0Y6
 VoRONsGVaV6OIWKGCftpIhOiByJOBX6oD160Qx8I4nzIKbm1Pp0BwZwtRbs9Q8t69Vw4
 wLzJdY/UkCbelZ2A+05QvR5oUh8I2aQVVHXgBKQOndX+ME2GntV5WVfYzd6HQeRBRI72
 bpvVQInB3qC6RjSXb4LB5Sv3kOQK0SASfzJ2klVnWo9iVQfVZxkAQHE39/rxR3z/Y8FM
 qJs4aMqaC3KzcX4PYX4l/texB3n/Wq9q+l0LoR/8TTT50TBWEO66c+YTomjBr44kVxj5
 izNg==
X-Gm-Message-State: AOJu0Yzz7TxBMjAFuC0AGBV3lt8bdCT+PywvUjHk151zUaC5A4lfCiW6
 JO+zlxdMyHpunsEFfv8xqS6cTXuXuHIu+3I5O9t+vseMTyYj4SqRuyOgm6I2zaaLEHnLUadg2O5
 Kdihg+ZI=
X-Gm-Gg: ASbGnctfI7Yl0dCIMMmKDLze8GqnLm9vRkxA2U1YUXn5mJAwdEhh8G63qhT25DpVgv6
 XBezYrFKRCmQVx+9nvU2Q0YS93Y+VXWzZg4T98S2pKE0ir6ccc4TZkzXIzM5gtblashsL9CxFhy
 fTP1XKONAagnEOyMnQpjJxt4yAjy93bI+SHLdTrSvwvo9fgCMCuXSF+MvXe4tz/qubDQHd3vmno
 WHXAT99j93OGsRZLuav/xdCLPETpQv8odVA6eWHy5W624pnRicDWOqw7B//a7WOqQOCBrIYzPng
 5B9S5TcmtIfL49kNRVp3VuaWgFAyMgbqDp4ZTl+WYsGlU89Xc2VpmvDddqnWzw+Eq3/xavmrxIa
 JBzprIFd/RHSi6v5/FY3KiOPSDjc1HQcBwuxcwLC6m/BUkf3T00iw1CM=
X-Google-Smtp-Source: AGHT+IEAnh/MH6PX5NGVTnkhlg97Awr8Jdndu8Umb+yJ+NQQVYWOu5pum37sxqiO0juoA3SbIICSHA==
X-Received: by 2002:a05:6e02:1687:b0:3e5:52a3:dade with SMTP id
 e9e14a558f8ab-3e55afb9c14mr20070355ab.16.1754950857217; 
 Mon, 11 Aug 2025 15:20:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250718011526.1333863-1-trini@konsulko.com>
References: <20250718011526.1333863-1-trini@konsulko.com>
Subject: Re: [PATCH] pci: Tighten some PCI controller dependencies
Message-Id: <175495085615.1657597.11615066360963816177.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:56 -0600
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

On Thu, 17 Jul 2025 19:15:26 -0600, Tom Rini wrote:

> A large number of PCI controllers cannot build without access to some
> platform specific header files. Express those requirements in Kconfig as
> well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pci: Tighten some PCI controller dependencies
      commit: cb8e5727089b6069f314a2f232e105f7c2127dbb
-- 
Tom


