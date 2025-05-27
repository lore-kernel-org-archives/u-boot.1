Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFE8C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 19:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034DE83121;
	Tue, 27 May 2025 21:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="VV/XlUQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C598384E; Tue, 27 May 2025 21:07:44 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E554B82AA4
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 21:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e7d925ff60bso2549376276.2
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748372860; x=1748977660; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=noQGwRo7Ouj9Gz3qOKPh09piDFwSulydDXK6lfX1amg=;
 b=VV/XlUQUbquYEVBncnoVKMTHpHhK9J0gfj/POib9qLiYxiYjD7V9kXbwGTmYPaWvhj
 /XDVn1OvNem81HDtIl7b1aer8DlNGx/JB4KRRPS8eepTp9pbRNTuPbq/UgPNRqrbf204
 mYTOtNYW/6vp5LQmzfUxEDO/oFLuzAc7MJcSGil1Tpbn7F2/k73zyUVU0IUZidkgyfCN
 2Ok2aWt2Xzvw4M3OPPW1KRw4bZ6GCLWikiFkvWF91sN+wI/z2WrFa0Tc56XQ5cf4i2ma
 iozWk8AR54rb+d9x5/g92uhAIlbmckPYgjmJvEc0waeGIoPHO545ypOiWR77G5NVi997
 JA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748372860; x=1748977660;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=noQGwRo7Ouj9Gz3qOKPh09piDFwSulydDXK6lfX1amg=;
 b=vDUUKhaKCuPrClvMYiK/Sv7UJrVUEvsqr5rT5h2QhfJybhxrSS9b4iysqXe8NkT8T6
 VdgadoTlzNSSpFCM14N+I6ipsK1r0KmJNdAk5bW1915K0gqONm4IUacFZ8LxQT726914
 K1kzJ1nNd6eQKBxsWlWr55FnKg4pzr+ojs7qXvOBzU6e27TuthOU71a4y2PUum5+SJa0
 KrdXjGEEY+Jobt/ckf6U/RRAP0QrApT0aND3fNL6/8K3B6wHiBWBtcyTtj2G1rqjPzbs
 u4VEhZqk4oXMos/UALmj0x2jIR5dxl1axHO+WDdJV4fly5t7Ulm0jyInRWZ8gBRieh1J
 CLFw==
X-Gm-Message-State: AOJu0Yw3oK71zBa1Hk141zQ6RFDOASl8j8Jy9ISIb7Hws6jMNDHRgtrT
 G6rZ4/asjx/oL8EQxAzUF6NEHBMNDtOS5LOgCHVB4qkDX0u0wCehTN5OU6urEsHsOunXFP+0uIg
 Gbt2qgfg1HH4GD7B4vJRST5vRYvZop1ttOcmvA4KJ132WwLhPQZb2W50=
X-Gm-Gg: ASbGncvXYJYrtPrYQvCGttGcc2yjgHNck7Xx8QLOOZ3+bYv2d2ac+qEljd1938PzH7E
 Mc+6kAt/gHaGU6yBezBC0bdhqIdv/p8PyKjM6kwsbEnj7cnktMjtqj6ab1PS9/62DdQAFti13EH
 mVhcDEO2/ATxy2y1KXbgz3+BzlgW07pKdXNxDNcjgbHBo=
X-Google-Smtp-Source: AGHT+IE+RoPNpGwNjt21zRKCI1D84+bSaWc72USGZk3Ea2spfGC/AbYrGgnO7xlvFwhh1dG4+eiyfMdZycQ4/1I/7CQ=
X-Received: by 2002:a05:6902:230a:b0:e7d:c51d:4b17 with SMTP id
 3f1490d57ef6-e7dc51d509emr5189201276.8.1748372860115; Tue, 27 May 2025
 12:07:40 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 27 May 2025 12:07:29 -0700
X-Gm-Features: AX0GCFu6xv6KsXpNJxkXDfyXsHUgwatH1Ed1ZwxSU_lOBJUzuc7OW_YLxBDwHGw
Message-ID: <CAJ+vNU1=maNegZ=DiVR+OQG6B+eaGdn9v9Spz+KhYGCbzhRaFA@mail.gmail.com>
Subject: lwIP watchdog not being serviced
To: u-boot <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>
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

Hi Jerome,

In my continued evaluation to see if I want to switch my boards over
to use lwIP I've noticed that the watchdog does not get serviced
during at least http/tftp which surprised me. This causes board resets
when transferring large files such as disk images.

It seems lwIP is missing some calls to schedule(). Do you have a
suggestion for the right place to call this for lwIP?

Best Regards,

Tim
