Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468BCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A510842FC;
	Thu, 30 Apr 2026 21:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kmb/90gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5734C80433; Thu, 30 Apr 2026 21:28:45 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A62280086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50d87610513so11214821cf.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577321; x=1778182121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YszaYLo8lCrz+C+AIeRc8M8XI18B45A1oe3Vj3yxF5I=;
 b=kmb/90gzxylQDBP6CHaxqql2MwXU+ZYK8tOWaKMKZGJAhGXOAt8gV0pT4T67HrIdfG
 c2jPFuh57lIpq6tEEqviCVmjqlQUuXVzgrwRQiFrB/c2JRAaYB7CkwTmk0dHwZmSISwP
 mwy4fnwdRfTlGv4AZ0eQiAqO0GythmS4Vm3FYM4IFuSMcbEBFVNbuTwkyIS/a5zY1gwN
 JDDSudo6EF7i6t39BoFC6vOzNkQodANh6V1mWbxBGik1zE0NUZX/brmXhiFmRQn3Y7A8
 i8DpGBKAnzkyJOceHoGMtZXlmDRkARSeZ9YhxaNJ08AgheznqztfcOHv9TCxWNMG+VIt
 0hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577321; x=1778182121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YszaYLo8lCrz+C+AIeRc8M8XI18B45A1oe3Vj3yxF5I=;
 b=WL3rFtWrsNnofwc/bMWKPtOJN+a4F8UQeRKfKAsi106UW5BPcdJ2z+eXpyh/kEWjSg
 azJZeNA8eT2p3b0btDGIn/1A4N/+x4XczxH3IrckBc/IRkCLP782TGp/ixos5r/KyUuj
 Z786DN1sCiwrA4C8NKHWsx/qDWhJZ4JB8ikb3Gflxa1GYus+nI0P2KZ8gmRlilEeUsqV
 uZzGVm49FpkgXCsI1+c8Aexpe+WVN4K1etmC4dvfddC0AMo2e+IC8Dz8Ne5wdto4m2HX
 6Nax+rl4+yhvEOqJSB2ZZpt/nMh1VDzfEn6sN1er5TfLrFv9+LJoNPQEtBBLg0l/KYmP
 5L6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ85wt1oBTNfBz91ZfdIqy8PGy6Oi7NJfrHa7Yg0SX3cBZtzFHHZSFIMMJXMocxW6qMuTvi53AU=@lists.denx.de
X-Gm-Message-State: AOJu0YzgV5MUw9NAU+iv4DXtQnBN0QY1ZFT5jz0lLtTOL0NDKDVeX40G
 IfrRR4ILo93zvZUVlHkmmZyMvv6CUOI2mflMbzPsRqXhpkn0j3kEc0IM
X-Gm-Gg: AeBDievv/t7voEFpAW5LmYJUQ4mKqDgLsV5oRoe55KuWVCNE3VOpgo8lmMYJRJK6nxl
 WiBs0IeOYrH+uzYS7Eom601+39KnFKpIiZ5nwAbzZEb8LeTRMZZlqNRYzAVxYFW+SDFFL8ra0bI
 eQg6bJdTFlqOvS8m2IzcR4fTM/NW6rX4bJhDjvdrk/jNxMbUJH+ypZrbTXcnEl1YHwop4rcY1rQ
 nCGlEByL2Pry5yyKTCzP98xcaui7Amb4lBBYuZvGGX5FzFGs3LcNV9+8tklBKTU8pB+Rbrb/L0v
 1iBo8X6UmmiVUwqqQkI52BKsfaN/AiBnTpF+91Bf6P7YgZlIJoF5KaRkBXRt0qcrghDGI/Cuomk
 ky64F94Jl6e2Y/rw1gQSoRcmeJ5qGzUHGdOqCtm9r9rm1SZB5B50bipey2srkGFrOUakrRaD2MN
 prxqbdDu+j62zdhEGFJANZ2/2560QT3tcU8cqNgXWVIS2Hvoee
X-Received: by 2002:ac8:7e94:0:b0:50f:ccdd:13f1 with SMTP id
 d75a77b69052e-5102ab04e3cmr62182301cf.16.1777577321542; 
 Thu, 30 Apr 2026 12:28:41 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d3371adsm2822671cf.29.2026.04.30.12.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:28:41 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 05/15] mach-sc5xx: Add USB boot command
Date: Thu, 30 Apr 2026 15:28:39 -0400
Message-Id: <20260430192839.4918-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTiZRVXXtg_e1FimCOGvB4xNUxCAg3nd8Jq+QBk=TkmwYg@mail.gmail.com>
References: <CAFLszTiZRVXXtg_e1FimCOGvB4xNUxCAg3nd8Jq+QBk=TkmwYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Hi Simon,

> Just to check...should the partition for the fitImage match the rootfs
> convention used by mmcboot (load from p1, root on p2)?

That is correct, the USB and eMMC have the same partition layout.

Thanks,

Caleb Ethridge
